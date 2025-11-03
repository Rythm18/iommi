#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

usage() {
    echo "Usage: $0 {base|new}" >&2
    exit 1
}

if [[ $# -ne 1 ]]; then
    usage
fi

case "$1" in
    base)
        pytest tests docs
        ;;
    new)
        pytest \
            iommi/table__tests.py::test_builtin_data_endpoint_simple_rows \
            iommi/table__tests.py::test_builtin_data_endpoint_queryset_pagination_and_metadata
        ;;
    *)
        usage
        ;;
esac
