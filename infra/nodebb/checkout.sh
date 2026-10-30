
#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
checkout_path="${1:-${repo_root}/vendor/nodebb}"

# shellcheck disable=SC1091
source "${repo_root}/infra/nodebb/upstream.env"

if [[ -e "${checkout_path}" ]]; then
  echo "NodeBB checkout already exists: ${checkout_path}" >&2
  echo "Refusing to overwrite an existing installation." >&2
  exit 1
fi

mkdir -p "$(dirname "${checkout_path}")"

git clone \
  --branch "${NODEBB_VERSION}" \
  --depth 1 \
  "${NODEBB_REPOSITORY}" \
  "${checkout_path}"

actual_commit="$(git -C "${checkout_path}" rev-parse HEAD)"

if [[ "${actual_commit}" != "${NODEBB_COMMIT}" ]]; then
  echo "NodeBB revision mismatch." >&2
  echo "Expected: ${NODEBB_COMMIT}" >&2
  echo "Actual:   ${actual_commit}" >&2
  exit 1
fi

echo "NodeBB ${NODEBB_VERSION} checked out at ${actual_commit}"
