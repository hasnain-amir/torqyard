#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

# shellcheck disable=SC1091
source "$repo_root/infra/nodebb/upstream.env"

preview=false

if [[ "${1:-}" == "--preview" ]]; then
  preview=true
elif [[ $# -ne 0 ]]; then
  echo "Usage: $0 [--preview]" >&2
  exit 2
fi

run_id="torqyard-theme-test-$$"
network_name="$run_id"
postgres_container="${run_id}-postgres"
nodebb_container="${run_id}-app"

workspace=""
app_url=""

cleanup() {
  local exit_code=$?

  trap - EXIT INT TERM

  echo "Cleaning up disposable TorqYard environment..."

  docker rm -f "$nodebb_container" >/dev/null 2>&1 || true
  docker rm -f "$postgres_container" >/dev/null 2>&1 || true
  docker network rm "$network_name" >/dev/null 2>&1 || true

  if [[ -n "$workspace" &&
        -d "$workspace" &&
        "$workspace" == "${TMPDIR:-/tmp}/torqyard-theme."* ]]; then
    rm -rf -- "$workspace"
  fi

  exit "$exit_code"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

echo "Starting isolated TorqYard theme integration test..."

workspace="$(mktemp -d "${TMPDIR:-/tmp}/torqyard-theme.XXXXXXXX")"

echo "Creating isolated Docker network..."
docker network create "$network_name" >/dev/null

echo "Starting disposable PostgreSQL..."

docker run -d \
  --name "$postgres_container" \
  --network "$network_name" \
  --restart no \
  --tmpfs /var/lib/postgresql \
  -e POSTGRES_USER=nodebb_test \
  -e POSTGRES_PASSWORD=nodebb_test_local_only \
  -e POSTGRES_DB=nodebb_test \
  postgres:18.4-alpine >/dev/null

echo "Waiting for PostgreSQL..."

postgres_ready=false

for ((attempt = 1; attempt <= 60; attempt++)); do
  if docker exec "$postgres_container" \
    pg_isready \
      -h 127.0.0.1 \
      -U nodebb_test \
      -d nodebb_test \
      >/dev/null 2>&1; then
    postgres_ready=true
    break
  fi

  sleep 2
done

if [[ "$postgres_ready" != true ]]; then
  echo "PostgreSQL failed to become ready." >&2
  docker logs "$postgres_container" >&2 || true
  exit 1
fi

echo "Cloning pinned NodeBB revision..."

git clone \
  --quiet \
  --depth 1 \
  --branch "$NODEBB_VERSION" \
  "$NODEBB_REPOSITORY" \
  "$workspace/nodebb"

actual_commit="$(git -C "$workspace/nodebb" rev-parse HEAD)"

if [[ "$actual_commit" != "$NODEBB_COMMIT" ]]; then
  echo "NodeBB revision mismatch." >&2
  echo "Expected: $NODEBB_COMMIT" >&2
  echo "Actual:   $actual_commit" >&2
  exit 1
fi

echo "Starting disposable Node.js container..."

docker run -d \
  --init \
  --name "$nodebb_container" \
  --network "$network_name" \
  --restart no \
  --publish "127.0.0.1::4567" \
  --user "$(id -u):$(id -g)" \
  --env HOME=/tmp \
  --env npm_config_cache=/tmp/npm-cache \
  --volume "$workspace/nodebb:/app" \
  --workdir /app \
  node:24-bookworm \
  sleep infinity >/dev/null

host_port="$(
  docker port "$nodebb_container" 4567/tcp |
    awk -F: 'NR == 1 { print $NF }'
)"

if [[ ! "$host_port" =~ ^[0-9]+$ ]] ||
   [[ "$host_port" == 4567 || "$host_port" == 4568 ]]; then
  echo "Invalid disposable NodeBB host port." >&2
  exit 1
fi

app_url="http://127.0.0.1:${host_port}"

echo "Installing NodeBB at $app_url..."

if ! docker exec \
  -e NODEBB_URL="$app_url" \
  -e NODEBB_PORT=4567 \
  -e NODEBB_DB=postgres \
  -e NODEBB_DB_HOST="$postgres_container" \
  -e NODEBB_DB_PORT=5432 \
  -e NODEBB_DB_USER=nodebb_test \
  -e NODEBB_DB_PASSWORD=nodebb_test_local_only \
  -e NODEBB_DB_NAME=nodebb_test \
  -e NODEBB_ADMIN_USERNAME=testadmin \
  -e NODEBB_ADMIN_PASSWORD=TorqYardTestOnly2026 \
  -e NODEBB_ADMIN_EMAIL=admin@torqyard.test \
  "$nodebb_container" \
  timeout --signal=TERM --kill-after=15s 600s \
  ./nodebb setup --skip-build; then
  echo "NodeBB setup failed or timed out." >&2
  exit 1
fi

echo "Installing TorqYard theme into disposable checkout..."

theme_destination="$workspace/nodebb/node_modules/nodebb-theme-torqyard"

if [[ -e "$theme_destination" ]]; then
  echo "Theme destination unexpectedly exists." >&2
  exit 1
fi

cp -R \
  "$repo_root/packages/nodebb-theme-torqyard" \
  "$theme_destination"

cp \
  "$repo_root/scripts/activate-test-theme.cjs" \
  "$workspace/nodebb/activate-test-theme.cjs"

touch "$workspace/nodebb/.torqyard-theme-test"


echo "Activating TorqYard theme..."

if ! docker exec "$nodebb_container" \
  timeout --signal=TERM --kill-after=15s 60s \
  ./nodebb activate nodebb-theme-torqyard; then
  echo "TorqYard plugin activation failed." >&2
  exit 1
fi

echo "TorqYard plugin activation command completed."



echo "=== Checking active plugins ==="

docker exec "$nodebb_container" \
  timeout --signal=TERM --kill-after=10s 30s \
  ./nodebb plugins

echo "=== NodeBB runtime information ==="

docker exec "$nodebb_container" \
  timeout --signal=TERM --kill-after=10s 30s \
  ./nodebb info

echo "=== Installed theme stylesheet ==="

docker exec "$nodebb_container" \
  sh -c '
    ls -l node_modules/nodebb-theme-torqyard/theme.scss
    cat node_modules/nodebb-theme-torqyard/theme.scss
  '

echo "Building NodeBB with TorqYard..."

build_log="$workspace/theme-build.log"

if ! docker exec "$nodebb_container" \
  timeout --signal=TERM --kill-after=15s 360s \
  ./nodebb build 2>&1 | tee "$build_log"; then
  echo "NodeBB asset build failed or timed out." >&2
  exit 1
fi

echo "=== Build warnings and errors ==="

grep -inE \
  'error|warn|sass|scss|theme|could not|undefined|not found' \
  "$build_log" \
  | tail -80 || true

echo "=== Generated CSS file sizes ==="

find "$workspace/nodebb/build/public" \
  -maxdepth 1 \
  -type f \
  -name '*.css' \
  -exec wc -c {} +

client_css="$workspace/nodebb/build/public/client.css"

echo "=== Inspecting generated client CSS ==="

if [[ ! -s "$client_css" ]]; then
  echo "ERROR: Generated client CSS is empty or missing." >&2
  exit 1
fi

echo "Client CSS size: $(wc -c < "$client_css") bytes"

echo "=== Checking for TorqYard variables ==="

if grep -q -- '--ty-' "$client_css"; then
  echo "TorqYard CSS variables detected."
else
  echo "No TorqYard CSS variables found."
fi

echo "=== Checking for Harmony font URLs ==="

grep -oE \
  'plugins/nodebb-theme-(harmony|torqyard)/(inter|poppins)' \
  "$client_css" \
  | sort -u || true

echo "=== Carbon Amber token search ==="

if ! grep -Rl \
  --include='*.css' \
  -- '--ty-carbon-950' \
  "$workspace/nodebb/build/public" \
  >/dev/null; then
  echo "ERROR: Carbon Amber tokens missing from compiled CSS." >&2

  echo "=== CSS compilation messages ==="

  grep -inE \
    'sass|scss|css|error|exception|failed|theme' \
    "$build_log" \
    | tail -120 || true

  exit 1
fi

echo "Carbon Amber CSS successfully compiled."

echo "=== Checking compiled font assets ==="

for font in inter poppins; do
  font_dir="$workspace/nodebb/build/public/plugins/nodebb-theme-torqyard/$font"

  if [[ ! -d "$font_dir" ]]; then
    echo "Missing compiled font directory: $font" >&2
    exit 1
  fi

  echo "Found compiled $font font directory."
done

echo "Starting NodeBB application..."

docker exec -d "$nodebb_container" \
  sh -c '
    exec node app.js > /tmp/torqyard-start.log 2>&1
  '

echo "Waiting for NodeBB HTTP readiness..."

nodebb_ready=false

for ((attempt = 1; attempt <= 90; attempt++)); do
  if curl \
    --silent \
    --fail \
    --max-time 5 \
    "$app_url/api/config" \
    -o /dev/null 2>/dev/null; then
    nodebb_ready=true
    break
  fi

  sleep 2
done

if [[ "$nodebb_ready" != true ]]; then
  echo "NodeBB failed to become HTTP-ready." >&2

  docker exec "$nodebb_container" \
    cat /tmp/torqyard-start.log >&2 || true

  exit 1
fi

echo "Running NodeBB HTTP smoke tests..."

NODEBB_SMOKE_URL="$app_url" \
  node --test tests/integration/nodebb-http.test.mjs

echo
echo "TorqYard theme integration checks passed."
echo "Local URL: $app_url"

if [[ "$preview" == true ]]; then
  echo
  echo "Preview is running."
  echo "Open $app_url in your browser."
  echo "Press Ctrl+C to stop and clean up."

  while docker inspect \
    -f '{{.State.Running}}' \
    "$nodebb_container" \
    2>/dev/null | grep -qx true; do
    sleep 2
  done

  echo "Preview container stopped unexpectedly." >&2
  exit 1
fi
