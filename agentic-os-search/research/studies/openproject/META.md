# OpenProject — Study Metadata

## Identity and status

- **Study ID:** `openproject`
- **Title:** OpenProject — Project, Work-Package, Dependency and Workflow Control Baseline
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U01 of `work-management-project-control` completed as a source-bounded baseline; no installation, live-organization study, scalability benchmark or adoption evaluation was performed.
- **Research object:** `opf/openproject` as an implemented project-management system, with emphasis on work-package identity, hierarchy, relations, role/type-conditioned workflows, scheduling, history and portfolio composition.
- **Canonical external target:** https://github.com/opf/openproject
- **Observed default branch:** `dev`
- **Pinned research ref:** `f531cc348d6920dd6d02f9b395f90878db57b3d3`
- **Research date:** 2026-09-17
- **License observed:** GPL-3.0
- **Freshness risk:** medium/high for current product behavior. The `dev` branch is active and current work-package workflow/project-specific configuration is changing.

## Primary question / purpose

What does a mature project-management system treat as the primary work object, and how does it distinguish hierarchy, semantic dependency, scheduling dependency, blocking, workflow state, ownership and strategic composition?

This unit is the classical project-control baseline for the broader `work-management-project-control` study.

## Source-bounded synthesis

OpenProject's central execution object is the **WorkPackage**. At the pinned ref it belongs to a project, type and status; has author, optional assignee and responsible actor, priority, dates/estimates and cost/time surfaces; includes relation, scheduling, hierarchy, status-transition and journal/history behavior.

The strongest methodological finding is that OpenProject does **not** collapse all “dependency” into one relation:

- parent/child hierarchy is maintained separately from ordinary work-package relations;
- predecessor/successor carries temporal scheduling semantics and optional lag;
- blocks/blocked-by constrains closure/status standing rather than schedule;
- requires/required-by and includes/part-of can be representational relations without automatic scheduling effect;
- duplicates has its own directional status propagation behavior.

Work-package status is also not a universal free-form column. Allowed transitions are configurable by **work-package type × project role**, with additional transition sets when the user is author or assignee. Reverse transitions can be configured; the model explicitly detects closed→open as reopening.

Scheduling is a separate control surface. Manual scheduling may intentionally ignore predecessor/child date constraints while preserving visible relations; automatic scheduling derives dates from predecessors or children and propagates schedule changes. This makes “relationship exists” distinct from “relationship currently controls dates.”

At larger scale, OpenProject distinguishes **Project**, **Program** and **Portfolio** workspaces. Projects execute operational work; programs group projects; portfolios provide strategic visibility/coordination rather than direct task execution.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** strong for primary work objects, hierarchy, relation types, workflow state, scheduling and portfolio composition.
- **Actors:** strong/conditional for assignee/responsible fields and role/author/assignee-conditioned status authority.
- **Information:** strong/conditional for durable work state, journals/activity/history and project/work-package metadata.
- **Environment:** conditional for calendars/working days, time/cost and project-level configuration.
- **Relations / control:** very strong for separating hierarchy, temporal dependency, blocking, semantic relation and workflow-transition authority.

These are retrieval hints, not Foundation membership claims.

## Potential SOUL relevance

- avoid a single generic `dependency` edge when different relations have different control effects;
- distinguish work hierarchy from readiness/blocking and from schedule propagation;
- allow the same relation to be informational in one mode and controlling in another where the system explicitly supports such modes;
- model work-state transitions together with actor authority, not status labels alone;
- preserve project/program/portfolio distinctions when strategic visibility and operational execution need different semantics.

No SOUL work model is authorised or implied.

## Potential Development OS relevance

- work-item hierarchy and relation taxonomy;
- configurable state-transition matrices;
- reopen/backtracking as normal state transition rather than exceptional reset;
- schedule propagation with manual override modes;
- assignee/responsible distinction;
- activity/journal history for recovery and audit;
- project/program/portfolio separation.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- classical project-control baseline;
- counterexample to “one dependency edge is enough”;
- candidate mechanism source for hierarchy, status authority and scheduling;
- comparison target for Flowable, Beads, OpenSpec, Spec Kit, Leantime and Gas Town;
- test-case source for replan/reopen/schedule/dependency semantics.

## What should not be inferred

- Source reading does not show that OpenProject is the right product or methodology for SOUL / Development OS.
- A configured closed status is not equivalent to independent verification or acceptance quality.
- The presence of blockers/predecessors does not establish a general actionable-frontier algorithm.
- Portfolio/status aggregation does not prove portfolio decision quality.
- Documentation and source semantics do not establish organizational effectiveness, usability, scale limits or live concurrency behavior.
- Enterprise-only features were inspected as documented semantics, not licensed/runtime-tested functionality.

## Freshness / revalidation

Re-check current `dev` HEAD or a stable release before load-bearing reuse, especially workflows/type variants, portfolio/project-life-cycle behavior, MCP surfaces and scheduling semantics.

## Package entrypoints

1. `FINDINGS.md` — work-control comparison matrix and source-bounded findings
2. `SOURCE-LEDGER.md` — pinned source surfaces
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; OpenProject is U01
- `../recursive-prerequisite-discovery/`
- `../mattpocock-skills/`
- `../gstack/`
