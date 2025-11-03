# Table Column Summaries

## Problem Brief
Implement optional per-column footers for `iommi.Table`, allowing automatic sums, averages, or custom callables to render inside `<tfoot>` while keeping pagination-aware aggregation configurable.

## Agent Instructions
- Extend `Column` to accept a `footer` namespace mirroring the existing `cell` API: defaults for include, aggregation keywords (`sum`, `avg`), callable `value`, and formatting. Carry over attr evaluation helpers so attrs or format callables receive `table`, `column`, `values`, and `rows`.
- Update `Table` to materialize a footer fragment: cache preprocessed rows separately per pagination mode, evaluate footer rows after headers/body, and expose `_Lazy_tfoot` so templates render `<tfoot>` seamlessly.
- Ensure aggregation can toggle between all filtered rows and just the current page via a table-level default plus per-column override. Reuse existing evaluation helpers to maintain compatibility with grouped columns and custom formatting.
- Adjust `iommi/templates/iommi/table/table_tag.html` to emit the new footer fragment beneath the tbody.

## Test Assumptions
- `test.sh` provides `./test.sh base` and `./test.sh new`; the latter exercises `iommi/table__tests.py::{test_table_column_footer_aggregations,test_table_footer_pagination_scope}`.
- New tests expect `<tfoot>` output and aggregation results for both numeric and custom formatted columns, including grouped headers and page-scoped totals.
