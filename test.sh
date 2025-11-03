#!/bin/bash
set -e

case "$1" in
  base)
    # Run existing test suite; should pass on the base commit
    pytest tests docs
    ;;
  new)
    # Run only the newly added tests; expected to fail before implementing the feature
    pytest \
      iommi/table__tests.py::test_builtin_data_endpoint_simple_rows \
      iommi/table__tests.py::test_builtin_data_endpoint_queryset_pagination_and_metadata \
      iommi/table__tests.py::test_builtin_data_endpoint_respects_filters_and_includes
    ;;
  *)
    echo "Usage: ./test.sh {base|new}"
    exit 1
    ;;
esac
