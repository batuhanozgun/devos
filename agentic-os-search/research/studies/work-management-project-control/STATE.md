# Work Management / Project Control — STATE

## Authority

This file is the authoritative package-local current-work state for `work-management-project-control`.

User authorization on 2026-09-17: plan the research program, process candidate repositories sequentially, and reflect the work durably in the research repository. This authorization does **not** authorize Foundation mutation, SOUL/Development OS architecture decisions, product adoption or installation.

## Current status

**BOUNDED-COMPLETE / REVIEW-READY — U00–U10 COMPLETE**

No automatic next repository is active. Further work requires a newly demonstrated gap or later design/architecture authorization.

## Completed units

- **U00 — Method/program setup** — COMPLETE
- **U01 — OpenProject** — BOUNDED-COMPLETE (`../openproject/`)
- **U02 — Flowable** — BOUNDED-COMPLETE (`../flowable/`)
- **U03 — Beads** — BOUNDED-COMPLETE (`../beads/`)
- **U04 — OpenSpec** — BOUNDED-COMPLETE (`../openspec/`)
- **U05 — GitHub Spec Kit** — BOUNDED-COMPLETE (`../spec-kit/`)
- **U06 — Leantime** — BOUNDED-COMPLETE (`../leantime/`)
- **U07 — Gas Town** — BOUNDED-COMPLETE (`../gastown/`)
- **U08 — Cross-unit synthesis / gap assessment** — COMPLETE (`08-CROSS-UNIT-SYNTHESIS.md`)
- **U09 — ERPNext enterprise integration gap** — BOUNDED-COMPLETE (`../erpnext/`, `09-ERPNEXT-GAP-CLOSURE.md`)
- **U10 — Bounded closure evaluation** — COMPLETE (`10-CLOSURE-EVALUATION.md`)

## Mechanism families now source-bounded

1. classical project / schedule control — OpenProject;
2. durable process / case / decision execution — Flowable;
3. dependency-DAG / actionable-frontier control — Beads;
4. artifact dependency / living-plan control — OpenSpec;
5. spec-driven procedural decomposition / convergence — Spec Kit;
6. strategy → goal → milestone → delivery alignment — Leantime;
7. multi-agent orchestration / liveness / integration control — Gas Town;
8. enterprise transaction attribution / derived project standing — ERPNext.

## Program conclusion

The corpus rejects the shortcut `large-work management = task tracking + dependencies`.

Across the sampled systems, large-work control requires reasoning about several potentially independent standings:

- intent / strategic trajectory;
- representation / plan / artifact completeness;
- hierarchy and prerequisite/readiness;
- workflow/case lifecycle;
- actor authority, assignment, claim and liveness;
- execution attempt / wait / retry;
- verification / integration;
- operational/economic evidence;
- realized outcome.

Different work conditions justify different representations. The research does **not** recommend combining all mechanism families into one architecture.

## Load-bearing cross-study distinctions

1. relation identity ≠ control effect ≠ enforcement point;
2. hierarchy ≠ prerequisite ≠ scheduling ≠ provenance/traceability;
3. lifecycle status ≠ derived actionable standing;
4. planning-ready ≠ logically actionable ≠ session-admitted ≠ dispatch-admissible;
5. authority ≠ assignment ≠ claim ≠ liveness ≠ integration authority;
6. work item ≠ planning artifact ≠ business transaction;
7. materialized artifact ≠ semantically accepted/current artifact;
8. completion signal ≠ verified effect ≠ integrated effect ≠ desired outcome;
9. reopen ≠ retry ≠ revise ≠ migrate ≠ compensate ≠ redispatch;
10. conversation context ≠ durable work state ≠ execution state;
11. delivery progress ≠ strategic/outcome progress;
12. work structure ≠ operational transaction structure;
13. transaction attribution ≠ work decomposition;
14. planned progress ≠ realized time/cost/material evidence;
15. project completion ≠ financial completion;
16. resource attribution/cost ≠ resource availability/capacity;
17. derived project rollup ≠ authoritative source transaction.

These are research distinctions, not a proposed SOUL or Development OS schema.

## Deferred candidate pool

Valid future targets, **not active work**:

- Camunda — if Flowable becomes insufficient for a later process-orchestration question;
- Plane / Redmine / Taiga — for a narrower issue/agile/workflow question;
- Huly — for unified work + communication/document workspace questions;
- TASKS.md/minimal queues — if a minimal work-substrate baseline becomes material;
- SAP-/ERP-oriented targets — if resource leveling, earned value, commitment control, settlement or SAP-specific semantics become load-bearing.

Deferred does not mean rejected.

## Fresh-session recovery

Read:

`META.md → this STATE.md → METHOD.md → 10-CLOSURE-EVALUATION.md → select only the mechanism family relevant to the active question → target META/FINDINGS → current upstream revalidation when load-bearing.`

Do not preload all target packages.
