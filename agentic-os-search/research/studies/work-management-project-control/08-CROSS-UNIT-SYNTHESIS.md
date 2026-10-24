# Work Management / Project Control — U08 Cross-Unit Synthesis

Date: 2026-09-17  
Scope: first-wave bounded studies only — OpenProject, Flowable, Beads, OpenSpec, GitHub Spec Kit, Leantime, Gas Town.

## 1. Synthesis question

The first wave asked whether large work can be usefully reduced to one generic structure — for example `Project → Task → Subtask` with a status column and dependencies — or whether different work conditions require materially different control representations.

The first-wave evidence strongly supports the second interpretation. The systems do not merely offer different UIs over the same ontology. They encode different answers to:

- what a work object is;
- what an edge means;
- how readiness is derived;
- who may advance work;
- what “done” means;
- how changing reality affects an existing plan;
- which state must survive actor/session failure;
- whether the system tracks work or causally executes it.

This is a research synthesis, not an architecture recommendation.

## 2. Six mechanism families emerged

### A. Classical project / schedule control

**Representative:** OpenProject; Leantime overlaps on organizational project planning.

Core shape:

`project/program/portfolio → work package/task/milestone → dates/status/roles/progress`

Strengths observed:

- explicit project hierarchy and aggregation;
- typed relations and schedules;
- milestones/roadmaps/calendars;
- configurable workflows/roles;
- portfolio/program visibility;
- budgets/time/progress surfaces.

Boundary condition:

This family is strongest when the work is meaningfully represented as planned deliverables over time. It does not automatically yield a single actionable-frontier algorithm, adaptive case semantics, actor liveness recovery or causal execution of external activities.

### B. Durable process / case / decision execution

**Representative:** Flowable.

Core shapes:

- BPMN: executable directed process/event flow;
- CMMN: condition-driven case plan and plan-item lifecycle;
- DMN: repeatable decision policy.

Strengths observed:

- durable waits/timers/events;
- human and system activities in one execution model;
- claim/assignment of human tasks;
- explicit migration of in-flight work;
- retry, suspension, termination and compensation semantics;
- stronger causal ownership of state transitions than a tracker.

Boundary condition:

The system must already have a sufficiently explicit process/case model. An execution engine does not by itself solve exploratory problem discovery, strategic objective definition or the quality of the plan encoded into it.

### C. Dependency-DAG / actionable-frontier work control

**Representative:** Beads.

Core shape:

`persistent work graph → derived blocked/ready standing → atomic claim → execution → close/reopen → frontier recomputation`

Strengths observed:

- explicit distinction between open and actionable;
- dependency/provenance relation types;
- graph-derived readiness;
- race-safe claim;
- actor liveness leases and abandoned-work recovery;
- distributed persistent graph/history.

Boundary condition:

The frontier is only as correct as the recorded graph and external conditions represented in it. Beads can compute over prerequisites; it does not prove the agent discovered the right prerequisites or that the world permits the work.

### D. Artifact dependency / living-plan control

**Representative:** OpenSpec.

Core shape:

`planning-artifact DAG → artifact readiness → apply readiness → living implementation checklist → reconciliation/archive`

Strengths observed:

- work artifacts are first-class;
- planning prerequisites differ from execution prerequisites;
- custom work methods/schema;
- proposal/current-state separation;
- live revision during execution;
- archive transition into maintained specification truth.

Boundary condition:

Materialized artifacts are weak evidence: a file can exist while being semantically wrong or stale. Artifact readiness is not work authorization or implementation correctness.

### E. Spec-driven procedural decomposition + convergence

**Representative:** GitHub Spec Kit.

Core shape:

`intent/governance → specification → technical plan → independently testable work slices → bounded implementation → convergence → appended remediation work`

Strengths observed:

- decomposition toward behavior/value slices;
- foundational versus story-local prerequisites;
- reviewer-owned requirements-quality surfaces;
- bounded work admission per agent session;
- source-directed repair;
- explicit implement→converge rework loop.

Boundary condition:

The sequence is largely agent/procedure-driven rather than a durable causal execution engine. Convergence remains a model assessment rather than an independent truth oracle.

### F. Multi-agent orchestration and execution control

**Representative:** Gas Town, layered over Beads.

Core shape:

`durable work substrate → work order/convoy → actor-local Hook → capacity/admission → worker runtime → monitoring/recovery → aggregate completion → integration/verification`

Strengths observed:

- separates work state from orchestration state;
- persistent actor identity with replaceable runtime sessions;
- capacity-aware dispatch;
- stuck/dead actor recovery;
- selective workflow checkpointing;
- aggregate work-order convergence;
- post-worker integration/verification queue.

Boundary condition:

Orchestration cannot repair an incorrect underlying work graph or decomposition. High liveness and high parallelism do not imply correct work selection or outcome quality.

## 3. One universal “task” object is insufficient for the observed systems

The word “task” hides several different things seen across the first wave:

- a project work package;
- a human wait-state in an executable workflow;
- a case-plan item that is available but not yet active;
- an issue whose status is open but whose derived standing is blocked;
- a planning artifact that must exist before another artifact can be produced;
- an implementation checklist item;
- a strategic milestone tracking many tasks;
- an ephemeral scheduling request to dispatch a durable work item;
- a worker procedure step that may or may not deserve durable materialization.

Treating these as one entity with only `status`, `assignee`, `priority`, and `depends_on` would erase load-bearing semantics.

## 4. Relation semantics require at least three questions

Across the first wave an edge cannot be understood from its endpoints alone. For every relation, the research now asks:

1. **What does the relation mean?** decomposition, temporal ordering, blocking, traceability, provenance, aggregation/tracking, authority/approval or strategic contribution.
2. **What effect does it currently have?** blocks readiness, moves dates, blocks closure, changes visibility, or no direct control effect.
3. **Where is the effect enforced?** UI/procedure only, query/derived-state engine, transaction/state transition, durable execution runtime or external integration gate.

Examples:

- OpenProject predecessor and blocker relations have different effects; manual scheduling can retain a predecessor relation while disabling its date control.
- Beads `discovered-from` records provenance without imposing prerequisite ordering; parent-child currently affects ready work through propagation even though it is not treated as a hard blocking edge.
- OpenSpec artifact `requires` affects artifact-generation readiness, not actor ownership.
- Leantime goal `tracked_by` milestone is strategic traceability, not task dependency.
- Gas Town convoy `tracks` aggregates work without replacing Beads dependency semantics.

## 5. “Ready” decomposes into multiple standings

The first wave exposes at least these non-equivalent readiness questions:

- **planning-ready:** enough information/artifacts exist to produce the next planning artifact (OpenSpec);
- **logically actionable:** work has no recorded blockers and is not deferred (Beads);
- **enabled but not active:** a case-plan item can be manually activatable without running yet (Flowable CMMN);
- **workflow-transition allowed:** actor/role/type configuration permits the status transition (OpenProject);
- **implementation-ready:** planning prerequisites satisfy apply/implementation requirements (OpenSpec/Spec Kit);
- **session-admitted:** this portion of the remaining plan is intentionally loaded into the current agent run (Spec Kit);
- **dispatch-admissible:** logical work is ready and execution capacity/runtime is available (Gas Town);
- **strategically on-track:** expected outcome trajectory is healthy (Leantime) — not execution readiness at all.

Therefore a future work model should not infer “ready” from one boolean without clarifying the standing it represents.

## 6. “Done” decomposes even more sharply

First-wave systems expose distinct terminal or near-terminal standings:

1. actor says local work is complete;
2. task/work item lifecycle is closed;
3. all items in a higher-level work order are closed;
4. required approval/review task is completed;
5. implementation artifacts/checklist are materially complete;
6. realized code converges with specification/intent according to a verifier;
7. result is merged/integrated into the authoritative environment;
8. strategic goal/outcome metric is achieved.

No first-wave system establishes that a single `DONE` status is an independent truth oracle.

## 7. Backward movement needs typed semantics

The first wave shows that “back” is not one operation:

- **reopen:** a closed work item becomes active again (OpenProject, Beads);
- **reblock/recompute:** reopening/updating one node invalidates downstream readiness (Beads);
- **revise representation:** edit proposal/spec/design/tasks while retaining the same change identity (OpenSpec);
- **source-directed repair:** return to the upstream artifact that caused an inconsistency (Spec Kit analyze);
- **append remediation:** preserve history and add newly discovered work rather than rewrite the original plan (Spec Kit converge);
- **migrate:** map already-running durable execution to a new definition (Flowable);
- **retry:** re-attempt failed execution without changing the work's intended meaning (Flowable/Gas Town scheduling);
- **suspend/resume:** retain state while stopping progress (Flowable);
- **cancel/terminate:** intentionally stop work/scope (Flowable);
- **compensate:** execute explicit inverse/remedial effects for previously completed work (Flowable BPMN);
- **re-dispatch/recover actor:** keep work, replace failed runtime/worker (Gas Town);
- **force-close/override:** privileged actor changes aggregate standing despite incomplete normal evidence (Gas Town).

Any later architecture discussion should preserve these distinctions instead of designing a generic `moveBackward()` operation.

## 8. Actor control has at least five separable dimensions

Observed dimensions:

1. **authority:** who is permitted to perform a transition?
2. **assignment:** who is expected/responsible for the work?
3. **claim:** who won exclusive allocation to an actionable item?
4. **liveness:** is the claimed actor/runtime still alive?
5. **integration authority:** who/what may make the result authoritative in the final environment?

Examples:

- OpenProject separates author, assignee, responsible, role-conditioned workflow authority.
- Flowable has candidate groups then claim/assignee.
- Beads has CAS claim plus separate lease/heartbeat.
- Spec Kit can keep requirements-quality checklists reviewer-owned while agents implement.
- Gas Town separates persistent actor identity from runtime process and places integration/merge authority in Refinery.

## 9. Persistent state needs multiple layers, not one conversation memory

The first wave shows durable information at different layers:

- plan/specification artifacts;
- current work graph;
- execution-runtime/wait state;
- scheduling/admission attempts;
- actor identity/history;
- process/case history;
- goal metrics/history;
- completion/integration evidence.

A session handoff can help, but no first-wave system suggests conversation history alone is a sufficient work-control source of truth.

## 10. Progressive planning appears in several different forms

Progressive planning appears as:

- editable project/work package structures (OpenProject);
- adaptive case activation (Flowable CMMN);
- new work discovered and linked without necessarily blocking current work (Beads);
- living planning artifacts/tasks (OpenSpec);
- convergence-generated remediation tasks after realization (Spec Kit);
- evolving goals/milestones/programs (Leantime);
- dynamic convoy feeding and actor recovery over an evolving work graph (Gas Town).

The important distinction is **what may change after execution begins** and how downstream standing is invalidated/recomputed — not whether the system calls itself agile.

## 11. Verification remains a persistent open problem

The first wave contains many verification-like surfaces: workflow transition restrictions, human approval tasks/statuses, acceptance criteria fields, `verify`/`analyze`/`converge`, merge/refinery gates and strategic metrics.

But these differ in independence and what effect they qualify. The program therefore retains the existing R04 discipline:

`completion signal ≠ verified effect ≠ desired outcome`.

## 12. Mechanism selection appears work-condition dependent

The observed families are useful under different conditions:

- predictable schedule/deadline/dependency planning → classical project control;
- durable event-driven operational processes → BPMN;
- knowledge/adaptive cases → CMMN-style case control;
- explicit prerequisite graph and many autonomous workers → dependency/frontier substrate;
- planning-information dependencies → artifact DAG;
- software intent→implementation with incomplete initial decomposition → convergence methodology;
- organization strategy→delivery traceability → goals/program/milestone model;
- many replaceable agent runtimes → orchestration/liveness/integration control.

This is not a recommendation to compose all of them. It is evidence against assuming one universal representation before the work condition is known.

## 13. Gap assessment after the first wave

### Covered sufficiently for this program

- classical hierarchy/schedule/workflow baseline — OpenProject;
- process/case/decision execution — Flowable;
- graph readiness/claim/liveness — Beads;
- planning artifact dependencies — OpenSpec;
- procedural decomposition/convergence — Spec Kit;
- strategy/goal/milestone/program alignment — Leantime;
- multi-agent orchestration/recovery/integration — Gas Town.

### Material gap: enterprise resource/cost/operational integration

The user's original frame explicitly included SAP PS-like project control. The first wave remains shallow on the enterprise question:

> How does a project/work structure bind to people/capacity, timesheets, expenses, procurement/materials, budgets, billing/accounting and operational business transactions?

Evidence for the gap:

- OpenProject U01 observed time/cost/project surfaces but did not deep-dive enterprise resource/cost/accounting integration.
- Leantime core has budgets/time/effort, but its deeper Resource Allocation behavior is plugin-bound and intentionally excluded from load-bearing findings.
- Flowable executes process state but is not an ERP/project-cost system.
- Beads/OpenSpec/Spec Kit/Gas Town do not target enterprise resource/accounting integration.

### U09 decision

Activate **ERPNext** as the only immediate second-wave target, specifically to cover project/task links to timesheets, costing/billing, expenses, resource/business operations and ERP context.

Do **not** activate Camunda now: Flowable already supplies the process/case/decision family for this bounded program.

Do **not** activate Plane/Redmine/Taiga now: their likely issue/agile workflow value is substantially represented by OpenProject/Leantime/Beads for the questions currently open.

Do **not** activate Huly now: unified communication/document workspace is not the demonstrated gap.

Do **not** activate TASKS.md now: Beads plus existing Wayfinder/recursive-prerequisite studies already cover the minimal-vs-rich work representation question enough for this pass.

## 14. Method refinements added by the first wave

The original 18-dimension method remains useful but should explicitly carry these cross-cutting sub-distinctions into U09 and closure:

- relation meaning / control effect / enforcement point;
- lifecycle status / derived standing;
- work state / execution-attempt state;
- planning readiness / logical readiness / dispatch admissibility;
- assignment / claim / liveness / integration authority;
- materialization / semantic acceptance / verified effect;
- delivery progress / outcome progress;
- event-driven update / reconciliation from authoritative state;
- whole plan / current admitted actor slice;
- current representation / proposed delta / realized state.

These are method refinements, not a proposed SOUL schema.

## 15. U08 conclusion

The first wave is sufficiently diverse to reject the research shortcut “project management is task tracking plus dependencies.” The stronger description is:

> Large-work control is the coordinated management of multiple kinds of standing — intent, representation, dependency/readiness, actor authority/liveness, execution, verification, integration and outcome — whose relationships depend on the work condition.

The program is **not yet ready to close** because enterprise resource/cost/operational integration remains materially under-covered. U09 will inspect ERPNext only for that missing mechanism family, then the package can enter bounded closure/evaluation.
