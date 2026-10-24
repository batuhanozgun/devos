# ERPNext — Study Metadata

## Identity and status

- **Study ID:** `erpnext`
- **Title:** ERPNext — Project Control Bound to Time, Cost, Sales, Purchasing and Stock Transactions
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / U09 ENTERPRISE-INTEGRATION SLICE**. U09 of `work-management-project-control` completed as a source-bounded enterprise project/resource/cost integration study; no live ERP deployment, accounting audit, capacity-planning campaign, payroll/HRMS deep dive or adoption evaluation was performed.
- **Research object:** `frappe/erpnext` as an ERP whose Project/Task records bind planning/progress to timesheets, billing/costing, sales, purchasing, stock/material and accounting-oriented transaction dimensions.
- **Canonical external target:** https://github.com/frappe/erpnext
- **Observed default branch:** `develop`
- **Pinned research ref:** `5d5eeb5e02cb21ce4256ceb97fc2712d14bf9dac`
- **Research date:** 2026-09-17
- **License observed:** GPL-3.0
- **Freshness risk:** high for exact transaction/project fields and Frappe/ERPNext module boundaries; `develop` is active and some adjacent enterprise functions live in separate Frappe apps such as HRMS.

## Primary question / purpose

How does an ERP project model differ from a project tracker when project/task identity is also carried by operational and financial transactions, and project standing is derived from time, costing, billing, sales, purchasing and material usage?

This unit closes the first-wave gap around SAP-PS-like enterprise integration without assuming ERPNext is equivalent to SAP PS.

## Source-bounded synthesis

ERPNext keeps **Project** and **Task** as recognizable project-control objects, but binds them to a much broader transaction environment.

At the pinned ref:

- `Task` is a nested-set work object with project, parent task, explicit `depends_on`, status, expected/actual dates, expected/actual time, progress, weight and costing/billing totals. A task cannot move to `Completed` while its declared dependencies are not `Completed` or `Cancelled`.
- `Project` can derive completion manually or from task completion, task progress or task weight. Project status becomes `Completed` at 100% unless manually held/cancelled.
- `Timesheet Detail` binds work time to both Project and Task, carries hours, billable hours, costing/billing rates and amounts, and can reference a Sales Invoice.
- `Project.update_costing()` aggregates submitted timesheet detail into actual start/end, actual time, total costing and total billable amount, then refreshes purchase, sales and billed amounts and gross margin.
- Sales Orders and Sales Invoices can reference a Project; Sales Invoice Items can also carry the Project dimension. Project billed amount therefore aggregates both invoice-level and item-level project attribution.
- Purchase Invoice Items and Purchase Receipt Items carry Project dimensions; procurement/reporting paths expose project filters/attribution. Project purchase costing is aggregated separately from timesheet costing.
- Stock Entry / Stock Entry Detail project attribution participates in consumed-material-cost calculation; landed-cost additions for manufacturing entries can also contribute.
- Journal Entry Account exposes Project as an accounting dimension, showing that project attribution can survive into accounting records rather than remaining only in the project module.

The methodological distinction is that **enterprise project standing is partly a projection over other business transactions**. A Project does not own all those transactions as child work items; many documents merely reference the project/task and remain governed by their own ERP lifecycle.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** strong for project/task hierarchy, dependency completion gating, project progress aggregation and project-to-operational-transaction linkage.
- **Actors:** conditional for employee/time attribution and project users; this bounded slice did not deep-dive workforce-capacity planning or HRMS ownership semantics.
- **Information:** very strong for derived project standing over timesheets, sales, purchasing, stock and accounting records.
- **Environment:** very strong for the surrounding ERP transaction system that gives project references economic/operational meaning.
- **Relations / control:** very strong for distinguishing project containment from transaction attribution, dependency completion gates from accounting dimensions, and source transaction state from derived project aggregates.

These are retrieval hints only, not Foundation membership claims.

## Potential SOUL relevance

- a future work system may need to distinguish **work structure** from **operational/economic evidence about that work**;
- project standing can be derived from external transaction systems instead of authored directly in the work graph;
- task completion, project progress, financial cost, billing standing and business outcome should not be collapsed into one status;
- links such as `transaction → project` can be attribution/reporting dimensions without making the transaction subordinate to the project lifecycle;
- enterprise work may require integration with time, material, purchasing, sales and accounting substrates even when execution is managed elsewhere.

No SOUL ERP/project architecture is authorised or implied.

## Potential Development OS relevance

- separating project/task state from time/cost/billing/material evidence;
- deriving rollups from authoritative external transactions;
- treating project attribution as a cross-system dimension rather than forced hierarchy;
- maintaining task prerequisites while allowing financial/operational records to have independent lifecycles;
- distinguishing delivery completion from financial completion, billing and margin;
- designing adapters to enterprise systems without making the Development OS duplicate their accounting logic.

No Development OS ERP integration or implementation decision is authorised or implied.

## Reuse modes

- enterprise project-control baseline;
- SAP-PS-like gap pressure test without claiming SAP equivalence;
- counterexample to tracker-only project state;
- candidate mechanism source for transaction attribution and derived project rollups;
- comparison target for OpenProject/Leantime/Flowable and future enterprise integrations;
- test-case source for completion-vs-cost-vs-billing-vs-outcome distinctions.

## What should not be inferred

- ERPNext is not established as an SAP PS substitute or as equivalent in WBS, network/activity, resource planning, settlement, controlling or portfolio semantics.
- Project financial rollups do not independently establish profitability/accounting correctness; they depend on source transactions and ERP accounting configuration.
- A Project link on a transaction does not mean the Project controls that transaction's lifecycle.
- This slice does not establish workforce capacity/resource leveling, earned value management, procurement planning, payroll or detailed budget-control semantics.
- Expense/HR processes may cross into separate Frappe applications; absence from this repo slice is not evidence of absence from the broader ecosystem.
- Source reading does not establish organizational effectiveness, accounting compliance, performance/scalability or integration correctness in a live enterprise.

## Freshness / revalidation

Re-check current stable release/develop behavior before load-bearing reuse, especially project accounting dimensions, Project aggregation logic, Timesheet fields, purchasing/sales/stock links and module boundaries across ERPNext/Frappe HRMS.

## Package entrypoints

1. `FINDINGS.md` — U09 comparison findings
2. `SOURCE-LEDGER.md` — pinned source surfaces
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; ERPNext is U09
- `../openproject/` — classical project/work-package control baseline
- `../leantime/` — strategy/project delivery contrast
- `../flowable/` — execution-engine contrast
- `../beads/` — dependency/frontier contrast
