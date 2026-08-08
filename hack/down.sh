#!/usr/bin/env bash
set -euo pipefail

KIND="${KIND:-kind}"
KIND_CLUSTER="${KIND_CLUSTER:-memcached-local}"

if ! command -v "${KIND}" >/dev/null 2>&1; then
  echo "kind is not installed. Please install kind manually." >&2
  exit 1
fi

if ! "${KIND}" get clusters 2>/dev/null | grep -qx "${KIND_CLUSTER}"; then
  echo "Kind cluster '${KIND_CLUSTER}' does not exist. Skipping deletion."
  exit 0
fi

echo "Deleting Kind cluster '${KIND_CLUSTER}'..."
"${KIND}" delete cluster --name "${KIND_CLUSTER}"
