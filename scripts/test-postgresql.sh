#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

image="postgres:18.4-alpine"
container_name="torqyard-postgres-integration-$$"

cleanup() {
  docker rm -f "$container_name" >/dev/null 2>&1 || true
}

trap cleanup EXIT

echo "Starting isolated PostgreSQL integration test..."

docker run -d \
  --name "$container_name" \
  --restart no \
  --tmpfs /var/lib/postgresql \
  -e POSTGRES_USER=torqyard_test \
  -e POSTGRES_PASSWORD=torqyard_test_local_only \
  -e POSTGRES_DB=torqyard_test \
  "$image" >/dev/null

echo "Waiting for PostgreSQL to become ready..."

ready=false

for ((attempt = 1; attempt <= 30; attempt++)); do
  echo "PostgreSQL readiness check $attempt/30"
  if docker exec "$container_name" \
  pg_isready -h 127.0.0.1 \
  -U torqyard_test -d torqyard_test >/dev/null 2>&1; then
    ready=true
    break
  fi

  sleep 1
done

if [[ "$ready" != true ]]; then
  echo "PostgreSQL did not become ready." >&2
  docker logs "$container_name" >&2
  exit 1
fi

echo "Running PostgreSQL integration tests..."

docker exec -i "$container_name" \
  psql -X -v ON_ERROR_STOP=1 \
  -U torqyard_test \
  -d torqyard_test \
  < tests/integration/postgresql.sql

echo "PostgreSQL integration tests passed."
