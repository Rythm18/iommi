#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 {base|new}" >&2
  exit 1
}

if [ "$#" -ne 1 ]; then
  usage
fi

case "$1" in
  base)
    # Run existing test suite; should pass on the base commit
    # Explicitly exclude the newly added tests to ensure distinct test sets
    python3 -m pytest \
      --deselect=iommi/table__tests.py::test_table_column_footer_aggregations \
      --deselect=iommi/table__tests.py::test_table_footer_pagination_scope \
      --deselect=iommi/table__tests.py::test_table_footer_table_default_paginate \
      --deselect=iommi/table__tests.py::test_table_footer_callable_kwargs \
      --deselect=iommi/table__tests.py::test_table_footer_sum_ignores_none \
      --deselect=iommi/table__tests.py::test_table_footer_tag_and_attrs
    ;;
  new)
    # Run only the newly added tests; expected to fail before implementing the feature
    python3 -m pytest \
      iommi/table__tests.py::test_table_column_footer_aggregations \
      iommi/table__tests.py::test_table_footer_pagination_scope \
      iommi/table__tests.py::test_table_footer_table_default_paginate \
      iommi/table__tests.py::test_table_footer_callable_kwargs \
      iommi/table__tests.py::test_table_footer_sum_ignores_none \
      iommi/table__tests.py::test_table_footer_tag_and_attrs
    ;;
  *)
    usage
    ;;
esac
