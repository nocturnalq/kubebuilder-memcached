#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIND="${KIND:-kind}"
KIND_CLUSTER="${KIND_CLUSTER:-memcached-local}"
KIND_CONFIG="${KIND_CONFIG:-${SCRIPT_DIR}/kind-cluster.yaml}"

if ! command -v "${KIND}" >/dev/null 2>&1; then
  echo "kind is not installed. Please install kind manually." >&2
  exit 1
fi

if "${KIND}" get clusters 2>/dev/null | grep -qx "${KIND_CLUSTER}"; then
  echo "Kind cluster '${KIND_CLUSTER}' already exists. Skipping creation."
  exit 0
fi

echo "Creating Kind cluster '${KIND_CLUSTER}'..."
"${KIND}" create cluster --name "${KIND_CLUSTER}" --config "${KIND_CONFIG}"
