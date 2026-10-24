# ERPNext — U09 Enterprise Project-Control Findings

Date: 2026-09-17  
Pinned ref: `frappe/erpnext@5d5eeb5e02cb21ce4256ceb97fc2712d14bf9dac`

## 1. Why ERPNext was activated

The first wave of `work-management-project-control` covered project/work-package control, durable workflow/case execution, dependency-frontier control, artifact/spec planning, strategy-to-delivery alignment and multi-agent orchestration. It remained shallow on the user's SAP-PS-like question:

> how does project/work structure connect to time, people, material, purchasing, sales, billing, accounting and other enterprise transactions?

ERPNext was selected only to close that gap. It is not being treated as an SAP PS equivalent.

## 2. Native work model

### Project

Project is the aggregation and coordination surface. At the pinned ref it carries:

- expected/actual start/end;
- status: Open, On hold, Completed, Cancelled;
- manual/task-derived percent complete;
- company, customer, department, cost center and optional Sales Order link;
- estimated cost plus derived actual time/cost/billing/sales/purchase/material/margin fields;
- project users and progress-update features.

### Task

Task is a nested-set work object rather than a flat issue:

- hierarchy through `parent_task`;
- declared prerequisites through `depends_on`;
- project ownership;
- expected/actual dates and time;
- progress and task weight;
- milestone/group/template semantics;
- costing/billing totals;
- statuses Open, Working, Pending Review, Overdue, Template, Completed, Cancelled.

A Task cannot enter Completed while a declared dependency remains outside Completed/Cancelled. Parent hierarchy and prerequisite relation are therefore separate structures.

## 3. Project progress is derived standing, not one authored status

ERPNext explicitly offers multiple project completion calculations:

- **Manual**;
- **Task Completion** — completed/cancelled task count over total tasks;
- **Task Progress** — aggregate progress;
- **Task Weight** — weighted task progress.

When derived progress reaches 100%, the Project becomes Completed unless it is manually On hold or Cancelled.

Method implication:

`project lifecycle status ≠ project progress calculation method ≠ task lifecycle state`

Even before financial integration, the model already separates several standings that a generic task tracker often compresses.

## 4. Time is both work evidence and economic evidence

`Timesheet Detail` can bind one recorded activity to:

- Project;
- Task;
- actual hours;
- billable hours;
- costing rate/amount;
- billing rate/amount;
- optional Sales Invoice.

Project then aggregates submitted timesheet rows into:

- actual start/end;
- actual time;
- total costing amount;
- total billable amount.

This is different from merely storing an estimate or task duration. The work structure is receiving realized evidence from an operational time-recording subsystem.

## 5. Project financial standing is a projection over independent ERP documents

Project costing refreshes multiple sources:

### Sales / revenue side

- Sales Order may reference Project.
- Project sums submitted Sales Orders for `total_sales_amount`.
- Sales Invoice may carry Project at document level.
- Sales Invoice Item may carry Project at item level.
- Project billed amount deliberately handles both patterns: invoice-level attribution where item project is empty, plus item-level attribution where present.

### Purchase / cost side

- Purchase Invoice Item carries Project.
- Purchase Receipt Item carries Project.
- procurement reports expose Project filtering/attribution.
- project purchase costing is maintained separately from timesheet costing.

### Material side

Project computes consumed material cost from submitted Stock Entry Detail rows attributed to the Project where material leaves inventory, and can add landed-cost amounts associated with manufacturing Stock Entries.

### Accounting side

`Journal Entry Account` exposes Project as a link/dimension. Project identity can therefore participate directly in accounting postings, not only project-module reporting.

The key distinction is:

`transaction attributed to project ≠ transaction is a child task of project ≠ project controls transaction lifecycle`

The transaction remains an ERP business object with its own lifecycle. Project aggregates or reports over the cross-reference.

## 6. Enterprise work therefore has at least three interacting planes

### A. Work-structure plane

Project → Task hierarchy/dependencies/progress.

### B. Operational transaction plane

Timesheets, Sales Orders, Sales Invoices, Purchase Invoices/Receipts, Stock Entries, Journal Entries and related records.

### C. Derived project-standing plane

Actual time, costing, billable/billed amount, sales amount, purchase cost, consumed material cost and gross margin.

The planes are connected, but they are not one ontology.

This is the main U09 addition to the first-wave synthesis.

## 7. “Done” becomes even less singular in an ERP context

ERPNext makes it possible for all of the following to diverge:

- task completed;
- project progress 100%;
- project status Completed;
- time recorded;
- labor cost posted;
- material consumed;
- purchase cost posted;
- sales order value recorded;
- customer invoice posted;
- billable amount versus billed amount;
- gross margin realized.

A Development OS/SOUL discussion that uses one `done` flag would lose these enterprise standings.

## 8. Enterprise integration changes the meaning of “resource”

The first wave mostly treated resource constraints as actor capacity, runtime capacity or scheduling conditions. ERPNext adds economic/operational resources:

- labor hours with costing and billing rates;
- inventory/material consumption;
- purchase-side cost;
- revenue/billing transactions;
- accounting dimensions.

However, this bounded slice **did not establish resource leveling/capacity planning** in the SAP PS sense. Do not confuse resource *attribution and cost evidence* with resource *availability scheduling*.

## 9. Comparison with first-wave families

### vs OpenProject

OpenProject was stronger as a classical work-package/workflow/schedule baseline. ERPNext adds much stronger direct coupling to business transactions and accounting-oriented rollups. Neither observation implies product superiority; they solve different parts of project control.

### vs Flowable

Flowable owns durable execution transitions. ERPNext Project generally does not cause every linked sales/purchase/stock/accounting transition; it aggregates/reference-binds their results.

`execution engine` and `enterprise aggregation substrate` are different control families.

### vs Beads

Beads derives an actionable frontier from a work graph and manages claim/liveness. ERPNext derives economic/project standing from transactions. Neither substitutes for the other.

### vs Leantime

Leantime connected strategy/goals/milestones to delivery. ERPNext connects delivery structures to economic/operational evidence. Strategic trajectory and financial/operational standing remain distinct.

## 10. Gap closure result

ERPNext closes the first-wave gap sufficiently for this bounded program:

- **time/labor evidence:** covered through Timesheet Detail and Project rollups;
- **cost/billing:** covered through costing/billing and invoice attribution;
- **material usage:** covered through Stock Entry-derived project material cost;
- **procurement/purchasing:** Project attribution exists in purchasing records/reporting;
- **sales/revenue:** Sales Order/Sales Invoice attribution and project sales/billed rollups;
- **accounting linkage:** Project dimension appears in journal-entry lines.

Still intentionally **not covered deeply**:

- workforce resource leveling/capacity scheduling;
- earned value / sophisticated project controlling;
- detailed budget commitment/availability control;
- payroll/HRMS and expense claims across app boundaries;
- SAP PS networks/activities/settlement semantics;
- portfolio investment governance.

These residuals do not justify another immediate repository for the current bounded study because the original question was methodology discovery, not exhaustive ERP feature parity.

## 11. New cross-cutting distinctions from U09

Add to the parent comparison vocabulary:

1. work structure ≠ operational transaction structure;
2. transaction attribution ≠ work decomposition;
3. project control field ≠ transaction lifecycle control;
4. realized time/cost/material evidence ≠ planned progress;
5. billable amount ≠ billed amount ≠ revenue/order value;
6. project completion ≠ financial completion;
7. resource attribution/cost ≠ resource availability/capacity;
8. derived project financial standing ≠ source accounting truth.

These are research distinctions, not a proposed architecture.

## 12. Evidence boundary

The source slice establishes data/control relationships in the pinned repository. It does not establish:

- SAP PS equivalence;
- full ERPNext ecosystem coverage;
- accounting correctness/compliance;
- organizational effectiveness;
- live transaction/concurrency behavior;
- financial reporting accuracy under all configurations;
- that SOUL or Development OS should implement ERP semantics itself.
