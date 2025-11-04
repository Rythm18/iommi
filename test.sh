#!/bin/bash
set -e

case "$1" in
  base)
    # Run existing test suite; should pass on the base commit
    python3 -m pytest tests docs
    ;;
  new)
    # Run only the newly added tests; expected to fail before implementing the feature
    python3 -m pytest \
      iommi/table__tests.py::test_table_column_footer_aggregations \
      iommi/table__tests.py::test_table_footer_pagination_scope \
      iommi/table__tests.py::test_table_footer_table_default_paginate
    ;;
  *)
    echo "Usage: ./test.sh {base|new}"
    exit 1
    ;;
esac
