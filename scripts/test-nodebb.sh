
#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

# shellcheck disable=SC1091
source "$repo_root/infra/nodebb/upstream.env"

run_id="torqyard-nodebb-test-$$"
network_name="$run_id"
postgres_container="${run_id}-postgres"
nodebb_container="${run_id}-app"

workspace=""
app_url=""

cleanup() {
  local exit_code=$?
  trap - EXIT INT TERM

  echo "Cleaning up isolated NodeBB test environment..."

  docker rm -f "$nodebb_container" \
    >/dev/null 2>&1 || true

  docker rm -f "$postgres_container" \
    >/dev/null 2>&1 || true

  docker network rm "$network_name" \
    >/dev/null 2>&1 || true

  if [[ -n "$workspace" && -d "$workspace" ]]; then
    rm -rf -- "$workspace" || true
  fi

  exit "$exit_code"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

echo "Starting isolated NodeBB integration tests..."

workspace="$(mktemp -d "${TMPDIR:-/tmp}/torqyard-nodebb.XXXXXXXX")"

echo "Creating temporary Docker network..."

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
  echo "PostgreSQL failed to start." >&2
  docker logs "$postgres_container" >&2
  exit 1
fi

echo "Checking out pinned NodeBB revision..."

git clone \
  --quiet \
  --depth 1 \
  --branch "$NODEBB_VERSION" \
  "$NODEBB_REPOSITORY" \
  "$workspace/nodebb"

actual_commit="$(
  git -C "$workspace/nodebb" rev-parse HEAD
)"

if [[ "$actual_commit" != "$NODEBB_COMMIT" ]]; then
  echo "NodeBB revision mismatch." >&2
  echo "Expected: $NODEBB_COMMIT" >&2
  echo "Actual:   $actual_commit" >&2
  exit 1
fi

echo "Starting disposable NodeBB runtime..."

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
    awk -F: 'NR == 1 {print $NF}'
)"

if [[ ! "$host_port" =~ ^[0-9]+$ ]] ||
  [[ "$host_port" == 4567 || "$host_port" == 4568 ]]; then
  echo "Invalid isolated NodeBB host port." >&2
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

echo "Building NodeBB assets..."

if ! docker exec "$nodebb_container" \
  timeout --signal=TERM --kill-after=15s 360s \
  ./nodebb build; then
  echo "NodeBB asset build failed or timed out." >&2
  exit 1
fi

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
    --show-error \
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

echo "NodeBB integration tests passed."
