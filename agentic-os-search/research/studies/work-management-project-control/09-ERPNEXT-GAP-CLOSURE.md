# Work Management / Project Control — U09 ERPNext Gap Closure

Date: 2026-09-17  
Target package: `../erpnext/`

## Gap being tested

U08 identified one material gap from the user's original Jira/Asana/Trello/SAP-PS framing: the first wave did not deeply show how project/work structures bind to enterprise time, cost, material, purchasing, sales, billing and accounting transactions.

ERPNext was activated specifically for that question.

## What U09 added

ERPNext contributes a mechanism family that differs from the six first-wave families:

> **enterprise attribution and derived project standing** — a Project/Task structure is cross-referenced by independent operational/financial transactions, then project-level time/cost/billing/material/margin standings are derived from those authoritative source records.

The bounded source study established:

- Project/Task hierarchy and prerequisite completion gates;
- multiple project-progress derivations from task state/progress/weight;
- Timesheet Detail binding Project + Task + hours + costing/billing;
- Project aggregation of actual time, labor cost and billable amount;
- Sales Order/Sales Invoice/Sales Invoice Item project attribution and sales/billed rollups;
- purchase-side Project attribution in invoice/receipt items and procurement views;
- Stock Entry-driven consumed material cost;
- Project as an accounting dimension in journal-entry lines.

## Why this is not just another project-management feature set

The new distinction is structural:

`work object` and `business transaction` are often different entities with different lifecycles.

A Sales Invoice or Stock Entry can contribute evidence to a Project without becoming a child Task. Conversely, Project completion does not mean every commercial/accounting standing is complete.

The program therefore adds these distinctions:

1. work structure ≠ operational transaction structure;
2. transaction attribution ≠ decomposition;
3. project reference ≠ lifecycle ownership;
4. planned progress ≠ realized time/cost/material evidence;
5. billable ≠ billed ≠ sales/order value;
6. delivery completion ≠ financial completion;
7. resource attribution/cost ≠ capacity availability;
8. project financial rollup ≠ source accounting truth.

## Residual gaps after U09

The following remain intentionally under-researched:

- workforce capacity/resource leveling;
- earned value / advanced project controlling;
- commitment/budget availability control;
- HR/payroll/expense processes across separate Frappe apps;
- SAP PS network/activity/settlement semantics;
- portfolio investment governance.

These are real residuals, but they do **not** justify another immediate target for this bounded methodology program. The study's purpose is to discover distinct work-control families and boundary conditions, not to achieve SAP-PS feature parity.

## U09 decision

**Enterprise resource/cost/operational integration gap: sufficiently covered for bounded closure.**

Proceed to U10. Do not activate Camunda, Plane, Redmine, Taiga, Huly or TASKS.md unless a future question exposes a new material gap that the current corpus cannot answer.
