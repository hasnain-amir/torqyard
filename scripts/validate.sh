
#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "Checking shell script syntax..."

find scripts infra -type f -name '*.sh' -exec bash -n {} +

echo "Checking NodeBB upstream configuration..."

# shellcheck disable=SC1091
source infra/nodebb/upstream.env

[[ -n "${NODEBB_REPOSITORY:-}" ]]
[[ "$NODEBB_VERSION" == "v4.16.2" ]]
[[ "$NODEBB_COMMIT" =~ ^[a-f0-9]{40}$ ]]


echo "Checking Docker Compose configuration..."

env_file="infra/development/.env.example"

docker compose \
  --env-file "$env_file" \
  -f infra/development/compose.yaml \
  config --quiet


echo "Checking Git whitespace..."

git diff --check

echo "All repository validation checks passed."
