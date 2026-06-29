#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "test-macos-runtime.sh only supports macOS." >&2
  exit 2
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

PYTHON_BIN="${PYTHON_BIN:-${ROOT_DIR}/.venv/bin/python}"
BUILD_DIR="${BUILD_DIR:-${ROOT_DIR}/build}"
TOUCHENGINE_DIR="${TOUCHENGINE_DIR:-${ROOT_DIR}/external/TouchEngine-macOS}"

if [[ ! -x "${PYTHON_BIN}" ]]; then
  echo "Python executable not found: ${PYTHON_BIN}" >&2
  echo "Set PYTHON_BIN=/path/to/python or create the project .venv." >&2
  exit 1
fi

if [[ ! -d "${BUILD_DIR}" ]]; then
  echo "Build directory not found: ${BUILD_DIR}" >&2
  echo "Set BUILD_DIR=/path/to/build or build touchpy first." >&2
  exit 1
fi

if [[ ! -d "${TOUCHENGINE_DIR}/TouchEngine.framework" ]]; then
  echo "TouchEngine.framework not found under: ${TOUCHENGINE_DIR}" >&2
  echo "Set TOUCHENGINE_DIR=/path/to/TouchEngine-macOS or init the submodule." >&2
  exit 1
fi

export DYLD_FRAMEWORK_PATH="${TOUCHENGINE_DIR}${DYLD_FRAMEWORK_PATH:+:${DYLD_FRAMEWORK_PATH}}"
export PYTHONPATH="${BUILD_DIR}${PYTHONPATH:+:${PYTHONPATH}}"

cd "${ROOT_DIR}"

if [[ "$#" -eq 0 ]]; then
  set -- test/pytest/
fi

exec "${PYTHON_BIN}" -m pytest "$@"
