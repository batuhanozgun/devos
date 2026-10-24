# ERPNext — Source Ledger

Pinned corpus: `frappe/erpnext@5d5eeb5e02cb21ce4256ceb97fc2712d14bf9dac`  
Observed branch: `develop`  
Research date: 2026-09-17

## Load-bearing source surfaces

| Source | Why it matters |
|---|---|
| `erpnext/projects/doctype/project/project.py` | Project status/progress methods; template/task creation; dependency mapping; timesheet aggregation; purchase/sales/billed/material costing; gross margin |
| `erpnext/projects/doctype/task/task.py` | Task hierarchy, project link, dependency completion gate, status/progress/date semantics, task costing/billing fields |
| `erpnext/projects/doctype/timesheet_detail/timesheet_detail.json` | Project/task/time/billable/costing/billing linkage at work-log level |
| `erpnext/projects/doctype/timesheet_detail/timesheet_detail.py` | Timesheet-detail validation and cost/billing computation behavior |
| `erpnext/accounts/doctype/sales_invoice/sales_invoice.py` | Invoice-level Project dimension |
| `erpnext/accounts/doctype/sales_invoice_item/sales_invoice_item.json` | Item-level Project + accounting dimensions and billed amount attribution surface |
| `erpnext/accounts/doctype/purchase_invoice_item/purchase_invoice_item.json` | Purchasing item Project dimension |
| `erpnext/stock/doctype/purchase_receipt_item/purchase_receipt_item.json` | Receipt item Project dimension |
| `erpnext/accounts/doctype/journal_entry_account/journal_entry_account.json` | Project as accounting-entry dimension |
| `erpnext/buying/report/procurement_tracker/procurement_tracker.py` | Procurement reporting/filtering by Project |
| `erpnext/buying/report/purchase_order_analysis/purchase_order_analysis.py` | Purchase-order item Project visibility |
| current repository metadata / `develop` HEAD | default branch and freshness baseline |

## Source-derived observations used in U09

### Project and Task control

- `Project` has status `Open | On hold | Completed | Cancelled` and multiple percent-complete methods: Manual, Task Completion, Task Progress, Task Weight.
- Task is a `NestedSet` with `parent_task`, `depends_on`, project, dates, progress, weight, total costing and total billing.
- Completing a Task checks declared dependencies and rejects completion unless those tasks are Completed or Cancelled.
- Project templates can instantiate tasks and copy dependency/parent relations; expected dates are derived relative to the project start and holiday list.

### Time / labor evidence

- Timesheet Detail records Project, Task, hours, billable hours, costing/billing rates and amounts.
- Project aggregates submitted Timesheet Detail rows into actual start/end, actual time, total costing and total billable amount.

### Sales / billing evidence

- Project can link to Sales Order.
- Project aggregates Sales Order base net total for project sales amount.
- Sales Invoice and Sales Invoice Item can each carry Project attribution; Project billed amount includes invoice-level attribution when item-level project is absent plus item-level attribution when present.

### Purchase / material / accounting evidence

- Purchase Invoice Item and Purchase Receipt Item expose Project attribution.
- Procurement reporting/query code includes Project filtering/fields.
- Project computes consumed material cost from Stock Entry Detail rows with Project attribution and includes selected landed costs from manufacturing Stock Entries.
- Journal Entry Account exposes Project as an accounting dimension.

## Evidence limits

This ledger does **not** establish:

- complete ERPNext/Frappe ecosystem coverage;
- HRMS/Expense Claim semantics outside the ERPNext repository;
- detailed budget control, capacity/resource leveling or earned value;
- accounting correctness or legal/compliance behavior;
- SAP PS equivalence;
- runtime performance, concurrency or production deployment quality.

Exact current behavior must be revalidated against a current release/ref before load-bearing use.
