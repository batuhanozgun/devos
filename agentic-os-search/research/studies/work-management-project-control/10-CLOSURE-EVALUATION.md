# Work Management / Project Control — U10 Bounded Closure Evaluation

Date: 2026-09-17

## 1. Closure question

Has the program sampled enough materially different work-control systems to support a reusable methodology corpus without pretending one model is universally correct?

**Answer: yes, for this bounded first program.**

The corpus now contains source-bounded implemented cases for:

1. **Classical project / schedule control** — OpenProject;
2. **Durable process / case / decision execution** — Flowable;
3. **Dependency-DAG / actionable-frontier control** — Beads;
4. **Artifact dependency / living-plan control** — OpenSpec;
5. **Spec-driven decomposition / convergence** — GitHub Spec Kit;
6. **Strategy → goal → milestone → delivery alignment** — Leantime;
7. **Multi-agent orchestration / liveness / integration control** — Gas Town;
8. **Enterprise transaction attribution / derived project standing** — ERPNext.

The parent study is therefore bounded-complete as a methodology/comparison corpus. It is not a product-selection exercise and does not authorize SOUL or Development OS architecture.

## 2. Main conclusion

Large-work management cannot be reduced without loss to:

`Project → Task → Subtask + status + assignee + priority + depends_on`

The sampled systems expose multiple independent kinds of standing:

- intent / strategic trajectory;
- plan/spec/artifact completeness;
- hierarchy and decomposition;
- prerequisite/readiness;
- workflow/case lifecycle;
- actor authority, assignment, claim and liveness;
- execution attempt / wait / retry;
- verification / approval / integration;
- operational/economic evidence;
- realized outcome.

A system may need only a subset, but the research rejects assuming these are one generic state.

## 3. Work representations are condition-dependent

The corpus supports at least these bounded mechanism-selection conditions:

- planned deliverables with dates and schedule relations → project/WBS-style control;
- repeatable event-driven process → BPMN-like execution;
- adaptive knowledge/case work → CMMN-like case control;
- explicit prerequisite graph with many workers → dependency/frontier substrate;
- planning-information dependencies → artifact DAG;
- software intent with incomplete upfront decomposition → spec→plan→implement→converge methodology;
- strategic alignment → goal/program/milestone surfaces;
- many replaceable agent runtimes → orchestration/liveness/integration layer;
- enterprise economic/operational attribution → ERP transaction/project dimension and rollups.

This is not a recommendation to compose all families into one system.

## 4. Cross-cutting distinctions retained for later SOUL / Development OS work

### Work and relations

- hierarchy ≠ dependency;
- dependency identity ≠ control effect;
- blocker ≠ predecessor ≠ traceability ≠ provenance;
- work item ≠ planning artifact ≠ business transaction;
- transaction attribution ≠ work decomposition.

### Readiness

- planning-ready ≠ logically actionable ≠ workflow-enabled ≠ implementation-ready ≠ session-admitted ≠ dispatch-admissible ≠ strategically on-track.

### Actor control

- authority ≠ assignment ≠ claim ≠ liveness ≠ integration authority.

### Completion and verification

- actor completion signal ≠ work-item closure ≠ aggregate completion ≠ implementation convergence ≠ integrated effect ≠ financial completion ≠ desired outcome.

### Backward movement

- reopen ≠ reblock ≠ revise ≠ append remediation ≠ retry ≠ suspend/resume ≠ migrate ≠ compensate ≠ cancel/terminate ≠ redispatch.

### Persistence / recovery

- conversation context ≠ durable work state;
- durable work state ≠ execution state;
- current plan ≠ realized state;
- derived rollup ≠ authoritative source transaction.

## 5. What the program does not prove

The program does **not** establish:

- one best project-management methodology;
- that any sampled product should be adopted;
- empirical productivity superiority of one representation;
- that agents reliably discover correct prerequisites/decompositions;
- that source-defined verification surfaces are independent truth oracles;
- that combining more control mechanisms improves outcomes;
- scalability/usability/organizational effectiveness of any product;
- SAP PS equivalence for ERPNext or enterprise feature completeness;
- a final SOUL / Development OS work ontology.

## 6. Deferred candidates

The following remain valid future targets but are **not active work**:

- Camunda — revisit if Flowable is insufficient for a later process-orchestration question;
- Plane / Redmine / Taiga — revisit for a narrower issue/agile/workflow question;
- Huly — revisit for unified work + communication/document workspace questions;
- TASKS.md/minimal queues — revisit if a minimal work-substrate baseline becomes material;
- additional ERP/project-control systems — revisit if resource leveling, earned value, commitment control or SAP-specific semantics become load-bearing.

Deferred does not mean rejected.

## 7. Reuse protocol

Future sessions should not load all target packages by default.

Use:

`work-management-project-control/META.md → STATE.md → this closure → select only the mechanism family relevant to the active question → target META/FINDINGS → current upstream revalidation if load-bearing.`

Examples:

- “what can be worked now?” → Beads + recursive-prerequisite research;
- “how do we run a durable human/system process?” → Flowable;
- “how do we preserve planning prerequisites?” → OpenSpec / Spec Kit;
- “how do we coordinate many agents?” → Gas Town + Beads;
- “how do strategy and execution relate?” → Leantime;
- “how do work records relate to actual cost/billing/material?” → ERPNext;
- “how do schedule/workflow/project relations differ?” → OpenProject.

## 8. Closure standing

**BOUNDED-COMPLETE / REVIEW-READY.**

Further work requires a new gap or a later authorized design/architecture question. No automatic next repository is activated.
