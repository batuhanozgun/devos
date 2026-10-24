# OpenProject — Work-Control Findings

Pinned source: `opf/openproject@f531cc348d6920dd6d02f9b395f90878db57b3d3` (`dev`), observed 2026-09-17.

## 1. Native work ontology

The core operational object is `WorkPackage`. At the pinned ref it belongs to a `Project`, `Type` and `Status`, has an `Author`, optional `assigned_to` and `responsible`, priority and project-phase linkage, and mixes in scheduling, relation, hierarchy, cost/time and journal/history behavior.

This is already methodologically useful: **work identity, work type, lifecycle standing, assignment and responsibility are separate fields** rather than one overloaded task record.

## 2. Decomposition is hierarchy, not generic dependency

OpenProject uses an explicit parent/child hierarchy for decomposition. The model exposes a closure-tree hierarchy and the user guide treats child work packages as the mechanism for breaking a larger work package into smaller work.

Parent/child is maintained separately from ordinary `Relation` rows. That separation prevents the common mistake of treating “is part of” and “must happen before” as the same edge.

## 3. Relation taxonomy carries different control effects

The pinned relation model distinguishes:

- relates-to;
- predecessor/successor (`precedes` / `follows` internally);
- blocks / blocked-by;
- duplicates / duplicated-by;
- includes / part-of;
- requires / required-by;
- parent / child as an abstracted separate hierarchy relation.

The user-guide semantics are materially different:

- **predecessor/successor** can constrain dates and carries lag;
- **blocks/blocked-by** prevents the blocked work package from being set closed/resolved while the blocker remains open;
- **includes/part-of** and **requires/required-by** may express relation without automatic scheduling effect;
- **duplicates** has directional closed-status propagation;
- hierarchy expresses decomposition.

### Research consequence

A future SOUL/Development OS work substrate should not assume that one `depends_on` relation can safely stand for decomposition, ordering, readiness, semantic inclusion and closure control. OpenProject is a concrete counterexample.

## 4. Scheduling is its own control plane

OpenProject has manual and automatic scheduling modes.

- **Manual:** dates may be changed independently of predecessor/child scheduling constraints; relations remain visible but do not control dates.
- **Automatic:** dates can be derived from predecessors or children and changes propagate through the schedule. A parent with children defaults to automatic scheduling and covers child date ranges.

Predecessor/successor supports positive or negative working-day lag. Working-day calendars affect derived dates and duration.

### Research consequence

The existence of a dependency and whether that dependency is currently **enforced as a schedule constraint** are different state dimensions. This distinction should survive later comparisons.

## 5. State is controlled by workflow + authority

A workflow defines allowed status transitions for a **work-package type and project role**. OpenProject additionally allows extra transitions when the acting user is the author or assignee.

The transition matrix is directional. Reverse movement exists only when the reverse cell is allowed. The WorkPackage model explicitly detects a closed→open transition as `reopened?` and open→closed as `closing?`.

### Research consequence

“Status” is not sufficient to model work control. The system needs at least:

`current standing + allowed transition + actor authority/context`.

Reopening is a normal transition pattern, not necessarily a destructive rollback.

## 6. Readiness is only partially represented

OpenProject contains meaningful blocking and temporal constraints, but this slice did not find one canonical derived property equivalent to “ready frontier.”

- a blocker constrains closure;
- a predecessor can constrain dates in automatic mode;
- workflow constrains status transitions;
- manual mode can intentionally ignore scheduling constraints.

Therefore “ready to work” is not reducible here to one engine-computed queue. Later agent-native systems such as Beads should be compared specifically on this point.

## 7. Ownership is richer than one assignee field

The WorkPackage model separates:

- author;
- assignee;
- responsible principal;
- project role permissions.

Workflow authority can also vary when the actor is author or assignee. This makes ownership/authority a relation between actor, work object and transition rather than a single owner attribute.

## 8. History / recovery

Work packages include journalized activity/history and paper-trail behavior. The scheduling user guide states that date changes are documented in work-package Activity.

This supports reconstruction of what changed, but source reading alone does not establish that history captures the reason/decision rationale for every change.

## 9. Portfolio composition separates execution from oversight

OpenProject models Projects, Programs and Portfolios as workspaces with different purposes:

- **Project:** operational execution;
- **Program:** groups related projects;
- **Portfolio:** strategic visibility and coordination across programs/projects rather than direct work-package execution.

The hierarchy has explicit composition rules; portfolios are top-level, programs may belong to a portfolio, and projects can sit under portfolios, programs or other projects.

### Research consequence

A large-work system may need more than nested tasks: strategic grouping and operational execution can be distinct aggregation layers with different responsibilities.

## 10. Verification / completion boundary

OpenProject can mark statuses as closed and can constrain who may transition to them. It also tracks percent complete/work and supports project-management phase/gate methods.

This does **not** establish an intrinsic independent verification oracle. “Closed” remains configured workflow standing unless a project-specific process adds review/approval semantics.

This is an important comparison point for later systems with explicit approval, tests, workflow gates or execution evidence.

## 11. Uncertainty / progressive discovery

OpenProject supports manual scheduling when dependencies are uncertain or not yet defined, and work structures can be edited over time. This is useful flexibility, but this slice did not find a first-class object comparable to Wayfinder's “fog of war” for known-but-not-yet-specifiable work.

Absence here is a bounded source observation, not a claim that no plugin/custom configuration could represent it.

## 12. Execution coupling

OpenProject is primarily a project/work tracking and control system. It enforces some internal effects — workflow permissions, scheduling propagation, closure restrictions — but source reading did not show that ordinary work packages execute external real-world work as a durable workflow engine would.

This boundary motivates U02 Flowable.

## Matrix snapshot

| Dimension | OpenProject bounded observation |
|---|---|
| Work identity | WorkPackage inside Project; typed, status-bearing |
| Decomposition | Explicit parent/child hierarchy |
| Dependency | Multiple typed relations with different effects |
| Readiness | Distributed across blockers/schedule/workflow; no single ready frontier found |
| State | Configurable directional status-transition matrix |
| Ownership | author + assignee + responsible + project role |
| Planning regime | classical project planning with agile/board variants; editable over time |
| Uncertainty | manual scheduling tolerates undefined/ignored schedule dependencies; no fog object found |
| Change | hierarchy/relations/dates/workflows configurable; history retained |
| Backtracking | reverse transitions/reopen supported when workflow permits |
| Scheduling | manual/automatic, predecessors, children, lag, calendars |
| Resources | time/cost/work estimates and actor assignment surfaces exist; detailed resource optimization not studied in this slice |
| Verification | closed/status workflow; no intrinsic independent verification oracle established |
| History | journal/activity + paper trail surfaces |
| Coordination | role/permission/assignment model; collaboration features |
| Recovery | durable database/history supports state recovery; session-agent continuity not its native concern |
| Portfolio | Project → Program/Portfolio strategic composition |
| Execution coupling | internal project-control enforcement; not studied as general external workflow executor |

## Open questions intentionally left outside U01

- live organizational use and usability;
- concurrency behavior under many human/agent actors;
- enterprise-only resource/cost/portfolio features under actual license/runtime;
- MCP/AI-agent interaction efficacy;
- stable-release versus active `dev` differences;
- critical-path/resource-leveling depth beyond the scheduling surfaces inspected.

These become gap candidates only if later units require them.
