# Work Management / Project Control — PLAN

## Strategy

Research in ordered contrast, not by product popularity. Each unit is chosen because it represents a materially different way of modelling or controlling work. The sequence may change when new evidence exposes a better dependency or a missing prerequisite; any change must be reflected in `STATE.md` with a reason.

## U00 — Program setup — COMPLETE

Outputs:

- `META.md`
- `STATE.md`
- `METHOD.md`
- this plan
- `INDEX.md`
- root catalog/index discovery updates

## U01 — OpenProject — COMPLETE

Classical project/work-package baseline: hierarchy, typed relations, scheduling, workflow authority, reopen/history and project/program/portfolio composition.

Target package: `../openproject/`

## U02 — Flowable — COMPLETE

Durable process, adaptive case and decision control: BPMN/CMMN/DMN, wait states, human/system tasks, retries, migration, cancellation and compensation.

Target package: `../flowable/`

## U03 — Beads — COMPLETE

Dependency graph / actionable frontier: ready-work derivation, typed edges, atomic claims, leases/liveness, reopen/reblocking and distributed persistence.

Target package: `../beads/`

## U04 — OpenSpec — COMPLETE

Artifact enablement graph: artifact dependencies, planning readiness, apply readiness, living tasks and archive/current-spec transitions.

Target package: `../openspec/`

## U05 — GitHub Spec Kit — COMPLETE

Spec-driven decomposition/convergence: constitution/spec/plan/tasks/implement/converge, optional quality gates and remediation work.

Target package: `../spec-kit/`

## U06 — Leantime — COMPLETE

Strategy-to-execution chain: goals, programs/projects, milestones, tasks, roadmap and delivery-versus-outcome progress.

Target package: `../leantime/`

## U07 — Gas Town — COMPLETE

Multi-agent execution/coordination: durable work substrate versus orchestration substrate, actor identity/session, capacity/admission, recovery, convoys and integration/verification.

Target package: `../gastown/`

## U08 — Cross-unit synthesis — COMPLETE

Output: `08-CROSS-UNIT-SYNTHESIS.md`

Result: first wave was sufficiently diverse to reject a universal task model, but exposed one material enterprise integration gap.

## U09 — ERPNext enterprise gap unit — COMPLETE

Purpose:

- test how Project/Task structure binds to time, costing/billing, sales, purchasing, stock/material and accounting transactions;
- distinguish project hierarchy from transaction attribution;
- distinguish delivery progress from financial/operational standing;
- answer the original SAP-PS-like gap without claiming SAP equivalence.

Outputs:

- `../erpnext/META.md`
- `../erpnext/FINDINGS.md`
- `../erpnext/SOURCE-LEDGER.md`
- `09-ERPNEXT-GAP-CLOSURE.md`

## U10 — Bounded closure — COMPLETE

Output: `10-CLOSURE-EVALUATION.md`

Closure standing: **BOUNDED-COMPLETE / REVIEW-READY**.

No repository is automatically active after U10.

## Deferred targets — not active work

Revisit only when a new material gap appears:

- ERP/SAP-oriented targets for resource leveling, earned value, commitment control or settlement;
- Camunda for a later process-orchestration question not covered by Flowable;
- Plane / Redmine / Taiga for narrower issue/agile workflow questions;
- Huly for unified work + communication/document workspace questions;
- TASKS.md/minimal queues for a minimal-substrate question.

Deferred does not mean rejected.

## Re-entry rule

A future extension begins by stating the **missing mechanism or unresolved question**, not by choosing another popular project-management product. Update `STATE.md` and this plan before activating a new unit.
