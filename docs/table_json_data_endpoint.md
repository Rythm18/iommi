Problem Title
Table JSON Data Endpoint

Problem Brief *
Add a first-class JSON export endpoint to `iommi.Table` so any table can expose its current rows, column metadata, and pagination state through a single GET dispatch. The response should mirror the table the user sees, including active ordering and filters, so downstream consumers can build reactive UIs or automation without scraping HTML.

Agent Instructions *
- Extend `iommi.Table` to register an `endpoints__data` handler by default. When invoked it must return a JSON-serializable payload containing: ordered column definitions (name, display name, value keys, csv whitelist flag), current query params, paginator info (page, per_page, total, has_next/prev), and rows rendered as dictionaries keyed by column names with formatted cell values.
- Ensure the endpoint respects existing table behaviors: honor `include`, request-bound sorting/filtering, row/column level exclusions, and omit columns hidden from the rendered table. Reuse existing evaluation helpers to avoid duplicating business logic and to keep performance acceptable for queryset-backed tables.
- Document the new capability in the codebase (docstring or README section) and cover it with focused pytest cases exercising simple lists, Django queryset tables with pagination, and tables using `extra__csv_whitelist`.
- Provide `test.sh` scripts plus `test.patch` and `solution.patch` per project instructions.

Test Assumptions (optional)
- Endpoint callable is exposed at `Table.Meta.endpoints__data__func` and reachable via dispatch key `'/parts/<table_path>/data'`.
- Tests live alongside existing table tests in `iommi/table__tests.py`, using `perform_ajax_dispatch` to invoke the endpoint.
- JSON payload includes keys: `columns`, `rows`, `paginator`, `query`.
