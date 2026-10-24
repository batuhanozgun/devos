# Leantime — Work-Control Findings

Pinned source: `Leantime/leantime@056835f1c29cf1f587415e6c45ddaf8d69f8d24c` (`master`), observed 2026-09-17. Latest observed release: `v3.9.8`.

## 1. Leantime connects strategy and execution through several distinct objects

The system does not treat all project-control data as tasks. At the pinned source:

- Projects have types including `project`, `strategy`, and `program` plus parent hierarchy, dates, budgets and access/team relations.
- Goal-canvas items represent goals/metrics.
- Tickets represent executable task-like work; ticket types include task, subtask, story, bug and milestone.
- Sprints group backlog work into short iterations.
- Milestones aggregate/visualize roadmap progress and can be linked to goals.

### Research consequence

A large-work system may need a chain of different representations:

`strategic intent/metric → delivery milestone → executable work`

rather than one nested task tree carrying every semantic role.

## 2. Goal standing and task standing use different state vocabularies

Default ticket states include New, Blocked, In Progress, Waiting for Approval, Done and Archived. Project-specific labels can override names/details but map into semantic status types such as `NEW`, `INPROGRESS`, and `DONE`.

Goal-canvas items instead use strategic standing labels such as:

- on track;
- at risk;
- miss.

### Research consequence

A goal being “at risk” is not the same type of state as a task being “blocked.” One describes expected outcome trajectory; the other describes execution lifecycle/control.

Work-management models should avoid one universal status enum spanning all abstraction levels.

## 3. Goals have explicit measurable state independent of delivery progress

Goal items include fields such as:

- metric description;
- start value;
- current value;
- end/target value;
- start/end dates;
- parent/KPI links;
- assigned actor.

The repository records goal-value history when current values change and has safety-net snapshotting for writes that bypass the normal repository path. Historical reads use the last recorded value on/before a requested date.

The goal dashboard derives percentage movement from current versus start/target metric values.

### Research consequence

This is a different progress model from task completion. A system can track whether execution is happening and whether the desired measurable outcome is moving — two different feedback loops.

## 4. Goal-to-milestone alignment is an explicit many-to-many relationship

Current source migrates from a legacy single `milestoneId` column toward `tracked_by` edges in the generic entity relationship table:

- entity A = GoalItem;
- entity B = milestone Ticket;
- relationship = `tracked_by`.

The write path validates that the milestone exists, is of type milestone and belongs to the same project. Reads support multiple milestone IDs for one goal.

### Research consequence

A goal can be tracked by multiple delivery milestones without becoming their parent task. Strategic traceability can be an independent relation family.

It also prevents a common modeling error:

`goal owns milestone` is not necessarily the same as `goal progress is computed from milestone progress`.

## 5. Milestone progress and goal metric progress remain separate

Milestone progress is computed from related task delivery state. Current report/service source describes weighted milestone progress over tasks, using project-specific DONE status semantics and story-point/effort information.

Goal metrics retain separate start/current/end values. Goal tooling displays milestone percentages alongside goals but does not make the milestone percentage itself the goal metric.

### Research consequence

This is one of U06's strongest lessons:

**delivery completion ≠ objective attainment**.

A project can finish all planned work and still miss the outcome; conversely, outcome movement may occur before every task is complete.

## 6. Ticket statuses have semantic categories beneath project-custom labels

Projects can customize ticket state labels, while the code groups them by semantic `statusType`:

- `NEW`;
- `INPROGRESS`;
- `DONE`.

The default “Waiting for Approval” state is an `INPROGRESS` semantic state, not DONE.

Cross-project/program views union status keys by semantic type because different projects can have different local labels/IDs.

### Research consequence

This is similar in spirit to Beads custom status categories: domain vocabulary can vary while a smaller behavioral vocabulary drives aggregation/control.

However, Leantime's categories are used heavily for progress/reporting rather than Beads-style actionable-frontier derivation.

## 7. Task/subtask hierarchy and dependency are represented more simply than in prior targets

Tickets expose a `dependingTicketId`. Current tools use it to create subtasks with a parent task, and roadmap/timeline views also use the field for dependency rendering.

This bounded slice did not find a rich multi-edge relation ontology equivalent to OpenProject or Beads.

### Research consequence

A product can be useful for strategic/project visibility even with a comparatively simple work-dependency representation. Richness of the planning hierarchy and richness of executable dependency semantics are separate axes.

Do not infer from UI wording that `dependingTicketId` means every kind of causal prerequisite.

## 8. Milestones are executable-control aggregation objects, not only calendar markers

Milestones are stored as ticket-type records and participate in roadmap/timeline views. They have dates, dependencies, status/progress presentation and group related tasks.

Current release fixes explicitly ensure milestone reports/timelines use the same task-derived progress logic.

### Research consequence

A milestone may simultaneously serve:

- schedule/roadmap marker;
- grouping scope for work;
- progress aggregation point;
- strategic-traceability target.

This is richer than treating a milestone as a zero-duration date marker only.

## 9. Sprints provide a second grouping/timebox independent of milestones

README and language guidance describe a backlog of to-dos and short timed sprint iterations. Current releases add cross-project/program task views and inherited sprints.

This means the same underlying work can have at least two orthogonal groupings:

- milestone/roadmap delivery grouping;
- sprint/iteration grouping.

### Research consequence

Work grouping is multi-dimensional. A task need not have one canonical container beyond its project.

## 10. Project/program hierarchy adds organizational composition

Project source supports project types including `project`, `strategy`, and `program`, plus parent relations. Current release notes add program-board and cross-project task/milestone behavior.

This adds a broader organizational axis missing from most agent-native task systems: one work system can host execution projects alongside strategy/program containers.

### Research consequence

Program-level views can coordinate several projects without forcing their local status vocabularies to be identical; Leantime normalizes semantic status categories for aggregate views.

## 11. Budgets/time/resource data sit alongside work, but resource allocation has a code-boundary caveat

Core project records include hour and dollar budget fields. Tickets include time/effort/story-point related fields, and README exposes time tracking/timesheets.

The pinned HEAD explicitly changes the `app/Plugins` submodule because Resource Allocation behavior depends on paired plugin code. Therefore this unit does not treat resource allocation details as fully validated core semantics.

### Research consequence

Enterprise/project control often needs resource/cost information, but methodology research must track **which subsystem owns the semantics**. UI integration does not mean one source tree fully defines behavior.

## 12. Risk, retrospectives and strategy canvases are companion artifacts rather than task-state transitions

README includes risk analysis, retrospectives, SWOT, Lean/Business Model canvases and idea boards. These give teams additional reasoning/learning artifacts around projects.

This bounded source slice did not establish that risk or retrospectives causally modify ticket readiness/workflow. They should therefore be treated as information/decision-support surfaces, not assumed work-state gates.

### Research consequence

A project-management environment can support work quality through **adjacent decision artifacts** without encoding all of them in the task state machine.

## 13. Approval is represented as a work state but not proven acceptance

Default task workflow contains “Waiting for Approval.” It remains semantically INPROGRESS until moved to DONE.

This can support a human/reviewer gate in practice, but source reading does not establish who must approve, what evidence is checked, or whether moving to Done proves quality.

### Research consequence

A workflow label can create a social process boundary without being an independent verification oracle.

## 14. Strategy changes and historical truth

Goals may be edited, relinked to milestones and have metrics updated over time. Goal-value history preserves measured-value changes. Project hierarchy/status and task structures can also change.

This bounded slice did not identify an OpenSpec-style explicit “proposed delta vs current strategy” package. Changes are generally mutations to current project/goal records plus history/audit surfaces.

### Research consequence

A system may preserve **measurement history** while not preserving strategic-plan revisions as first-class immutable proposals. Those are distinct historical needs.

## 15. Matrix snapshot

| Dimension | Leantime bounded observation |
|---|---|
| Work identity | project/program/strategy containers; goals; milestone/ticket work; sprint grouping |
| Decomposition | task/subtask via dependingTicketId; project hierarchy |
| Dependency | simple ticket dependency/parent pointer; milestone timeline dependencies; no rich typed graph established |
| Readiness | lifecycle statuses/backlog/sprint views; no computed Beads-style ready frontier established |
| State | project-custom ticket labels mapped to NEW/INPROGRESS/DONE; goal on-track/at-risk/miss separately |
| Ownership | ticket/goal assignment + project roles/access |
| Planning regime | strategy/planning/execution connected but editable; sprint and roadmap planning |
| Uncertainty | idea/risk/canvas/retro surfaces; no explicit actionable-fog object established |
| Change | mutate goals/projects/tickets/links; metric history preserved |
| Backtracking | project reopen and task status changes supported; no special compensation/migration model established |
| Scheduling | milestones, roadmap/Gantt, dates, sprints/calendars |
| Resources | budgets/time/effort; deeper resource allocation plugin-bound and not validated here |
| Verification | Waiting for Approval social workflow; Done status; no independent oracle established |
| History | comments/status reporting + goal metric history; strategy-revision provenance less explicit |
| Coordination | project roles, assignment, comments, program cross-project views |
| Recovery | durable DB/project state; no agent-session liveness protocol native to core finding |
| Portfolio | project types and parent hierarchy include program/strategy groupings |
| Execution coupling | tracking/planning/control environment; not a durable business-process executor like Flowable |

## 16. Method learnings after U06

U06 adds four distinctions:

1. **delivery progress ≠ objective/outcome progress**;
2. **execution lifecycle standing ≠ strategic trajectory standing**;
3. **strategic traceability relation ≠ ownership/dependency relation**;
4. **reasoning/support artifacts (risk/retro/canvas) ≠ task-state controls unless explicitly wired**.

## 17. Open questions intentionally outside U06

- resource-allocation/capacity semantics across the paired plugin submodule;
- exact program-board rollup behavior for every status/progress metric;
- risk severity/probability workflows and whether they can gate execution;
- retrospective-to-plan feedback automation;
- live MCP/agent behavior and AI-generated project changes;
- empirical value of the strategy-to-execution UX;
- detailed project status-update and financial reporting semantics.
