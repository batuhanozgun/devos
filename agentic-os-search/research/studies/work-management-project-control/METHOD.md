# Work Management / Project Control — METHOD

## Research posture

The goal is not to rank tools. The goal is to recover **work-management ontologies and control mechanisms** from implemented systems, compare where each model is strong or weak, and preserve counterexamples against a single universal task model.

Every target is read in its native vocabulary first. Mapping into our comparison dimensions happens only after the native model is understood.

## Common comparison matrix

Each unit should answer, when the target materially supports the dimension:

1. **Work identity** — what is the atomic or primary unit: project, work package, issue, case, process instance, task, decision, artifact, bead, etc.?
2. **Decomposition** — hierarchy, WBS, backlog, graph, case plan, artifact tree, dynamic discovery, or another structure?
3. **Dependency** — parent/child, blocker, predecessor/successor, enablement, condition, milestone, resource dependency; are these distinct?
4. **Readiness / actionable frontier** — how is “can be worked now” represented or derived?
5. **State** — which lifecycle states exist and which transitions are valid?
6. **Ownership** — assignment, role, claim, lease, queue, team ownership, concurrent actors.
7. **Planning regime** — upfront plan, rolling-wave/progressive planning, discovery-driven work, event-driven workflow, adaptive case work.
8. **Uncertainty** — how does the system represent work that is known to exist but not yet specifiable?
9. **Change / replanning** — how are scope, dependency, priority, estimate or plan changes applied without losing history?
10. **Backtracking / reversal** — reopen, rollback, compensation, cancellation, supersession, invalidation, rework.
11. **Scheduling** — duration, calendar, predecessor dates, critical path, milestones, deadlines, forecast.
12. **Resources / constraints** — capacity, cost, skills, budget, availability, environment constraints.
13. **Verification / acceptance** — what makes work done, accepted, verified or releasable; who/what can change that standing?
14. **History / provenance** — audit trail, comments, decisions, versions, event log, reason for transitions.
15. **Coordination** — one actor, teams, humans + agents, parallelism, conflicts, locking/claiming.
16. **Recovery / continuity** — how another session/actor recovers current state, unfinished work and next action.
17. **Portfolio / composition** — project→program→portfolio, parent initiatives, cross-project dependency or shared resource semantics.
18. **Execution coupling** — tracking-only, workflow execution, runtime orchestration, automation, or direct effect on external systems.

## Evidence ladder

Prefer, in order:

1. current source code / schemas / tests for actual semantics;
2. current official architecture/reference documentation;
3. official user documentation and examples;
4. release notes / issues / PRs when needed for edge semantics or freshness;
5. first-party benchmark or product claims, explicitly labelled as first-party;
6. third-party commentary only when it adds a distinct externally checkable claim.

A README feature list is enough for qualification, not for a load-bearing finding.

## Unit protocol

### A. Revalidate and pin

Record repository, default branch, observed HEAD/release and date. If fast-moving, distinguish qualification HEAD from later pinned research corpus.

### B. Recover native ontology

List the target's own entities and relations before translating them. Similar names across systems are not assumed equivalent.

### C. Recover control semantics

Inspect how work becomes ready, blocked, assigned/claimed, started, changed, completed, reopened, cancelled or superseded.

### D. Recover non-happy-path behavior

Look for partial completion, failed transitions, concurrent edits, stale state, dependency change, actor disappearance, restart/recovery, cancellation and rollback/compensation.

### E. Recover scale semantics

Inspect how the system moves from one task/case/process to project/program/portfolio or multi-agent coordination when relevant.

### F. Separate representation from execution

A tracker may represent work without enforcing execution. A workflow engine may execute transitions. An agent-native system may both derive ready work and launch actors. Keep those different.

### G. Compare selectively

Compare only against prior units/studies needed to sharpen a distinction. Do not create a feature-table contest.

### H. Record limits

Every unit must state what source reading did **not** prove: efficacy, user outcomes, organizational suitability, scalability, correctness, agent reasoning quality, etc.

### I. Update durable state

Write the target package/finding, update parent `STATE.md`, and refresh `CATALOG.md` where status/reuse relevance materially changed before moving on.

## Method-revision rule

The matrix is a starting instrument, not a fixed ontology. When a target exposes an important dimension the matrix cannot represent:

1. record the mismatch;
2. decide whether the missing concept is target-specific or generally reusable;
3. update this method only if the new dimension improves later comparisons;
4. do not rewrite earlier findings to manufacture consistency — append/revisit explicitly.

## Cross-synthesis rule

The final synthesis should identify **families of work-control mechanisms and their boundary conditions**, not a winner. Expected families include, but are not limited to:

- project/WBS/schedule control;
- backlog/issue/agile flow;
- workflow/state-machine execution;
- adaptive case management;
- dependency-DAG/actionable-frontier systems;
- artifact/spec enablement graphs;
- agent/multi-agent coordination systems.

The research should remain capable of concluding that different work conditions require different representations.
