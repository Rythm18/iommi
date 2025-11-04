# Table Column Summaries

## Problem Brief
Implement optional per-column footers for `iommi.Table`, allowing automatic sums, averages, or custom callables to render inside `<tfoot>` while keeping pagination-aware aggregation configurable and intuitive.

## Agent Instructions
- Extend `Column` to accept a `footer` namespace mirroring the existing `cell` API. Support the public keys `footer__include`, `footer__aggregation`, `footer__value`, `footer__format`, `footer__tag`, `footer__attrs`, and `footer__use_visible_rows`. Aggregation keywords `sum` and `avg` must ignore `None` values and run on column values gathered from the current table state.
- Update `Table` to materialise a footer fragment: cache preprocessed rows for both paginated and full datasets, evaluate footer rows after headers/body, and expose `_Lazy_tfoot` so templates render `<tfoot>` seamlessly.
- Provide a table-level default scope: by default aggregations operate on all filtered rows. When `footer__extra__paginate=True` on the table the default scope must switch to the current visible page, unless a column overrides it via `footer__use_visible_rows`.
- Adjust `iommi/templates/iommi/table/table_tag.html` to emit the new footer fragment beneath the tbody.

## Test Assumptions
- `test.sh` provides `./test.sh base` and `./test.sh new` entry points.
- Footers default to aggregating across all filtered rows; `footer__use_visible_rows=True` or table-level `footer__extra__paginate=True` instructs the system to use only the visible page.
- Aggregations must ignore `None` inputs, while `footer__value` can inject static or callable content before formatting. The rendered `<tfoot>` row should reflect summed totals, averages, and custom markup output by `footer__format`.
