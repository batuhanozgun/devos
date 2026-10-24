# Leantime — Study Metadata

## Identity and status

- **Study ID:** `leantime`
- **Title:** Leantime — Strategy-to-Execution Goals, Milestones and Task Control
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U06 of `work-management-project-control` completed as a source-bounded strategy/project/task study; no live organizational deployment, plugin/resource-allocation campaign or adoption evaluation was performed.
- **Research object:** `Leantime/leantime` as a project-management system that connects project/program structure, measurable goals, milestones, tickets/tasks/subtasks, sprints, roadmap progress and strategic planning surfaces.
- **Canonical external target:** https://github.com/Leantime/leantime
- **Observed default branch:** `master`
- **Pinned research ref:** `056835f1c29cf1f587415e6c45ddaf8d69f8d24c`
- **Observed latest release:** `v3.9.8` (published 2026-07-08); pinned master is ahead and preparing/binding plugin changes for 3.10.0.
- **Research date:** 2026-09-17
- **License observed:** AGPL-3.0
- **Freshness risk:** high. Core domains, program views, goals/milestone linking, MCP tools and plugin-backed resource/cost surfaces are actively evolving.

## Primary question / purpose

How does a work-management system preserve a connection from strategic intent and measurable goals down into milestones and executable project tasks without collapsing strategic outcome metrics into delivery-progress metrics?

This unit adds organizational alignment, milestone/roadmap and strategy measurement concepts largely absent from the preceding agent-native targets.

## Source-bounded synthesis

Leantime's operational task object is the Ticket/To-Do. Built-in task types include task, subtask, story, bug and milestone. Project-specific status labels map into semantic status types (`NEW`, `INPROGRESS`, `DONE`); default labels distinguish New, Blocked, In Progress, Waiting for Approval, Done and Archived.

Subtask decomposition and a single `dependingTicketId` relation are stored directly on ticket records. The same field also appears in milestone/timeline dependency rendering, so this bounded slice treats it as a broadly reused parent/dependency pointer rather than assuming a rich typed relation ontology comparable to OpenProject or Beads.

Milestones are ticket-type records and roadmap/timeline aggregation objects. Milestone progress is derived from underlying work using project-specific DONE semantics and story-point/effort weighting. Sprints add short-iteration grouping over backlog tasks, while roadmap views expose milestone/date/dependency progress.

Strategy is represented separately. Goal-canvas items have their own metric fields (start/current/end values), status standing (`on track`, `at risk`, `miss`), dates, assignment and parent/KPI relationships. Goals can be linked many-to-many to milestones through explicit `tracked_by` entity edges. Goal metric history is recorded over time. Thus **goal outcome progress and milestone/task delivery progress are distinct measures** even when the goal is tracked by those milestones.

Projects themselves have type values including `project`, `strategy` and `program`, parent hierarchy, start/end, budgets and access/team relationships. Current release/master work also exposes cross-project program task/milestone views. README additionally surfaces retrospectives, risk analysis, SWOT/Lean canvases, time tracking and related planning tools; this bounded slice treats those as supporting organizational surfaces, not as deeply validated control semantics.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** very strong for goal→milestone→task alignment, project/program grouping, status, sprints and roadmap progress.
- **Actors:** strong/conditional for task assignment, goal assignment, project roles/access and organizational ownership.
- **Information:** strong for goal metrics/history, roadmap/milestone progress, strategy canvases and project status reporting.
- **Environment:** conditional/strong for calendars/time/budgets and plugin-backed resource-allocation surfaces.
- **Relations / control:** strong for measurable-object versus delivery-object separation, goal↔milestone tracking links, task/subtask/dependency pointers and program hierarchy.

These are retrieval hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

- separate **desired outcome/metric** from **work completion percentage** so finishing tasks does not automatically mean the objective was achieved;
- preserve traceability from high-level goal to multiple delivery milestones without making the goal itself a task;
- model strategic standing (`on-track/at-risk/miss`) separately from delivery lifecycle state (`new/in-progress/done`);
- support project/program hierarchy and cross-project execution views when one objective spans several projects;
- retain metric history so progress/strategy can be reassessed rather than represented as one latest value;
- combine project execution with retrospection/risk/strategy artifacts without assuming each is part of the same state machine.

No SOUL organizational/project architecture is authorised or implied.

## Potential Development OS relevance

- goals/metrics linked to milestones/tasks;
- milestone and sprint aggregation;
- program-level cross-project work views;
- explicit Waiting-for-Approval status category within task execution;
- effort/story-point weighted progress;
- project hierarchy/budget/time surfaces;
- outcome progress versus execution progress distinction;
- historical goal-value trends for reporting/feedback loops.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- strategy-to-execution baseline;
- counterexample to “task completion = goal success”;
- milestone/program aggregation reference;
- organizational status/risk/retro pressure surface;
- comparison target for OpenProject and agent-native systems;
- candidate mechanism source for objective/work traceability.

## What should not be inferred

- A linked milestone does not prove causal contribution to a goal metric.
- Goal status or currentValue can be user/system-maintained data; this slice does not establish an independent measurement oracle.
- Milestone progress does not establish outcome quality; it is delivery progress derived from tracked work.
- `dependingTicketId` should not be assumed equivalent to Beads/OpenProject typed dependency graphs.
- README features such as risk analysis, retrospectives and resource allocation were not all source-deepened here; resource-allocation code is affected by the separate plugins submodule and must be validated at the paired plugin ref before load-bearing use.
- Source reading does not establish that strategy canvases or neurodivergent-friendly UX improve project outcomes.

## Freshness / revalidation

Re-check core master plus the paired `app/Plugins` submodule before relying on resource/cost/portfolio behavior. Revalidate program views, goal↔milestone linking, goal history, status semantics and MCP tools on the current release/master.

## Package entrypoints

1. `FINDINGS.md`
2. `SOURCE-LEDGER.md`
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; Leantime is U06
- `../openproject/` — classical project-control/portfolio comparison
- `../beads/` — agent-native actionable-frontier contrast
- `../mattpocock-skills/` — progressive planning/Wayfinder comparison
