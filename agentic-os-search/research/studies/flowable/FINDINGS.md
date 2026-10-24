# Flowable — Work-Control Findings

Pinned source: `flowable/flowable-engine@42aa81de65ce48572577c1826ba5d16135347aff` (`main`), observed 2026-09-17. Latest observed release: `flowable-8.0.0`.

## 1. This target is an execution engine, not only a tracker

Flowable's README describes BPMN process, CMMN case and DMN rule engines and explicitly positions the platform for orchestration of human and system activities.

In the BPMN tutorial, a process definition is deployed to persistent storage. Starting a process instance causes the engine to execute forward until a wait state (for example a user task). At the wait state the current process state is persisted; completion resumes execution until the next wait state or process end. A crash/restart between those points does not require reconstructing the process from conversation or UI state.

### Contrast with OpenProject

OpenProject represents and constrains project work. Flowable additionally **owns execution progress** for modeled work. This adds a new dimension to the parent method: the same state name can be descriptive in a tracker or causally enforced by an execution runtime.

## 2. BPMN: work as directed process execution

BPMN represents a process definition with start/end events, activities such as user/system tasks, sequence flows, gateways and event constructs.

The introductory example makes direction explicit: sequence flows connect source→target and the engine advances along them. User tasks are human wait states. Candidate users/groups can see a task; one user may **claim** it, after which that user becomes the assignee and it disappears from other candidate lists.

This is a stronger ownership transition than a passive `assigned_to` field:

`candidate pool → claim → exclusive assignee → complete → engine continues`.

## 3. Durable wait/event state changes the meaning of continuity

BPMN execution continues synchronously until a wait state. User tasks, event-based gateways and timers can suspend progress while runtime state/events remain persisted.

The async executor uses persisted timer jobs and async continuation jobs. External-worker completion can schedule continuation in a new transaction. Retry/dead-letter machinery exists for failed jobs.

### Research consequence

For long-lived work, “continuity” need not mean an agent reconstructs a task list. A durable engine can make the unfinished transition itself authoritative and wake the workflow when the required event occurs.

## 4. CMMN: work as a case plan with plan-item lifecycle

Flowable CMMN represents a `CaseDefinition` / `CaseInstance` containing a case plan model. Plan items may represent:

- human tasks;
- process tasks;
- case tasks;
- stages;
- milestones;
- other supported CMMN constructs.

Runtime plan-item instances have a state machine. At the pinned ref the API exposes standard states:

- `available`
- `enabled`
- `active`
- `disabled`
- `completed`
- `failed`
- `suspended`
- `terminated`

plus engine-specific intermediary states such as `unavailable`, `wait_repetition`, `async-active` and `async-active-leave`.

This is much richer than `todo/in-progress/done` and separates, for example, **work that may become active** from **work that has been enabled for manual start**.

## 5. Sentries are condition/event-based readiness controls

CMMN plan items can have entry and exit criteria backed by **sentries**.

The documentation example shows a milestone becoming active only after two human tasks complete. Multiple on-parts and conditions can participate. Exit sentries can terminate a plan item or the whole plan model when a triggering event/condition occurs.

### Research consequence

Readiness can be an **event/condition transition**, not only dependency-edge closure. This should be contrasted with Beads' graph-derived ready frontier in U03.

## 6. Manual activation distinguishes enabled from active

Flowable's plan-item control includes `ManualActivationRule`, `RequiredRule` and `RepetitionRule` (plus engine extensions).

The activation source states that when a manual-activation rule evaluates true, a plan item becomes **enabled** instead of automatically becoming **active**. Tests assert enabled state before manual start.

This exposes a useful control distinction:

`conditions satisfied` does not always imply `work begins`.

A human/system authority may still need to activate it.

## 7. Required and repetition rules shape case completion/evolution

CMMN supports required and repetition control. The engine maintains a `WAITING_FOR_REPETITION` intermediary state and required-rule tests include cases where the case cannot yet be completed.

This means “case complete” can depend on more than no currently active tasks: obligations and repeatable plan items participate in completion semantics.

## 8. Case work can invoke process work and vice versa

The current HEAD changes variable inheritance on CMMN `CaseTask` and `ProcessTask`; CMMN docs also distinguish blocking and non-blocking process tasks.

This demonstrates that process and case models are composable rather than mutually exclusive. A structured process can be one activity within a broader case, or a BPMN service task can start a case.

### Research consequence

Work models may be nested by **local control requirement** instead of choosing one representation for the entire project.

## 9. DMN separates repeatable decision logic from flow

Flowable's DMN engine models repeatable decisions using decision tables. Inputs, rule matching, outputs and hit policies are defined independently. A BPMN Decision Task can invoke a referenced decision table.

This separates:

- what path/activity exists;
- what decision rule produces a value.

That is important for SOUL/Development OS: work progression policy does not necessarily belong embedded in task sequencing logic.

## 10. Replanning already-running work is migration, not merely editing the diagram

Flowable supports process-instance migration when a new process-definition version is deployed. The migration builder can validate compatibility and map active wait states to activities in the new definition. Historic information moves with the instance.

The observed 8.0 release also reports process and case migration improvements, including validation and creating plan-item instances for new case-plan items.

### Research consequence

Changing the canonical plan does **not** automatically change already-running work. A work system needs explicit semantics for how in-flight state is mapped to a revised model.

This is materially stronger than changing a future plan document and assuming current work follows it.

## 11. Backtracking is not one operation

Flowable exposes several distinct mechanisms:

- process/case migration maps running state to a revised definition;
- cancellation/terminate events end scopes;
- BPMN compensation invokes explicit compensating handlers for already-performed work;
- job retry/dead-letter handles failed executable steps;
- suspension keeps work state without completing/terminating it.

### Research consequence

“Go back” is too coarse. Reopen, migrate, retry, cancel, terminate and compensate have different causal meanings and recovery guarantees.

## 12. History and standing

Runtime/historic APIs retain process/case/plan-item state and history. Flowable 8.0 adds historic process state/end-user tracking and migration includes historic information.

History here is tightly connected to engine execution, not only an activity journal. It can answer which runtime state/plan item was active when the model changed.

## 13. Verification / completion boundary

Flowable can enforce model-defined completion requirements and route human verification tasks as part of a process. A user task can explicitly represent an approval/check, and required CMMN items can prevent case completion.

However, the engine does not make the truth of an approval independent merely because it was executed. A human clicking “complete” or a service task succeeding is an executed transition, not automatically proof that the business outcome is correct.

## 14. Uncertainty / adaptive work boundary

Compared with BPMN's explicit sequence-flow execution, CMMN offers condition-driven plan-item availability, sentries, manual activation, required/repetition rules and stages. This is a materially more adaptive shape for work where not every item should automatically execute when a predecessor finishes.

The CMMN schema also contains planning-table/discretionary-item constructs, but this bounded unit did **not** establish Flowable's full runtime behavior for discretionary planning. Do not elevate “dynamic creation of arbitrary new work at runtime” into a finding from this slice.

## 15. Matrix snapshot

| Dimension | Flowable bounded observation |
|---|---|
| Work identity | BPMN process/activity/task; CMMN case/plan item/stage/milestone; DMN decision |
| Decomposition | process/subprocess and case/stage nesting; model-specific |
| Dependency | BPMN sequence/event conditions; CMMN sentries/control rules rather than one generic edge |
| Readiness | BPMN token/event progression; CMMN available/enabled/active transitions |
| State | durable process/case/plan-item lifecycle; persisted at waits |
| Ownership | candidate users/groups → claim → assignee for human tasks |
| Planning regime | BPMN prescriptive flow; CMMN condition/case-plan control; DMN decision policy |
| Uncertainty | CMMN supports gated/manual/conditional activation; full discretionary planning not established here |
| Change | deploy new definition + explicit instance migration |
| Backtracking | migrate, retry, cancel, terminate, compensate, suspend — distinct semantics |
| Scheduling | timers/due events/async jobs; not classical project-date scheduling |
| Resources | actor/group assignment; general resource-capacity planning not core in this slice |
| Verification | model can require review/approval tasks; execution ≠ independent truth oracle |
| History | runtime + historic engine state, migrations, job history surfaces |
| Coordination | humans and system activities in same durable execution model |
| Recovery | persisted wait/job state survives restart; retries/dead-letter support failures |
| Portfolio | not a project/program/portfolio system in this slice |
| Execution coupling | high — engine executes/guards actual modeled transitions |

## 16. Open questions intentionally outside U02

- full runtime support and operator UX for CMMN discretionary planning tables;
- business-level idempotency of external effects under retry;
- full current-main migration support beyond docs/release notes;
- live engine concurrency/performance/cluster behavior;
- human organizational suitability;
- whether CMMN is cognitively usable for the kind of exploratory work SOUL may manage.
