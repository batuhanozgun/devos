# S03 — Intent, Planning and Context Handoff

Date: 2026-09-18. **Provisional native subsystem synthesis, not an adopted design or whole-study closure.** Primary source: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (6.3.0 manifest context). [STATE](../STATE.md) owns current authorization and continuation.

Evidence roots: [U01-A](../notes/U01-entry-routing-and-bootstrap.md) F01–F02; [U02](../notes/U02-approval-plan-workspace-handoff.md) F13–F19; [U03](../notes/U03-delegation-review-and-acceptance.md) F20–F24/F27; [U07-A](../notes/U07A-visual-companion-lifecycle.md) F65–F70; [U07-B](../notes/U07B-distribution-versioning-and-support.md) F77/F79. Direct source re-entry and the separately qualified public discussion are recorded in [U08-A's register](../SOURCE-LEDGER-U08A.md). No new execution occurs here.

## 1. Native explanation: approved intent is progressively made executable

Superpowers tries to turn a request into an appropriate working agreement, then—where the selected route requires it—into a plan that a low-context worker can execute and a reviewer can assess. It scales the amount of preparation without treating presentation of a design as the same event as human approval. These are procedural obligations assigned to agents; the prose does not itself enforce consent. User instructions can override skills under the target's own priority rule. [S04/S10; U01-A F01–F02]

| Route | Basis for selection | Preparation and intended terminal direction |
|---|---|---|
| Spike | Feasibility question; output is an answer | Approve a bounded probe; report findings; constructed code stays throwaway |
| Bounded | Narrow change to an existing readable flow | Clarify, present a short design in chat, wait for approval, then normal implementation; no separate spec/plan document |
| Architectural | New or materially restructured project, subsystem or interfaces | Alternatives, sectioned design, written/committed spec, inline self-review, human review, then writing-plans |

The lack of a written plan in the bounded route is an intentional process choice, not evidence that approval is optional. Conversely, approval of a spike does not authorize keeping its code. Hidden complexity can upgrade the route. [U01-A F01; U02 F13]

A bug investigation can enter through systematic-debugging; a review request is not automatically an architectural build request. The whole-system model must retain those entry differences rather than making every interaction begin with the longest design ceremony. [S04; U04 F29/F31; S01's outcome-review case]

## 2. The plan is both decomposition and context preparation

Writing-plans defines a task as an independently testable deliverable with a meaningful review boundary, not an arbitrary five-minute allocation. The two-to-five-minute guidance concerns individual steps. Plans carry a Spec pointer, exact Global Constraints, files and consumes/produces interfaces. Self-review checks coverage, placeholders and type consistency. These mechanisms try to prevent local task isolation from losing project-wide meaning. [S28; U02 F14]

The direction of justification is explicit in SDD: the spec is binding; the plan argues from it. A plan-mandated defect can therefore be challenged instead of being declared correct merely because the plan says so. But an exact path is not an exact revision, and a reachable plan does not guarantee a reachable spec. SDD notes an unreachable spec and makes resulting rulings provisional rather than unconditionally stopping. [S30; U02 F13–F14]

Self-review, a complete-looking template and a committed file are different qualifications. A plan may be formally populated while carrying an incorrect expected value. Making its requirements easier to transmit does not independently validate those requirements.

## 3. The coordinator is a semantic intermediary

The task-brief helper extracts a task section; it is not a requirements compiler. It does not automatically carry the plan header or all globals. The controller must compose the dispatch from the brief, exact binding requirements, interfaces, relevant previous decisions and report location. Workers are explicitly not given the whole plan/history. Reviewers receive the same brief and the global constraints. [S28/S30/S33/S35/S37; U02 F17; U03 F20–F21]

This makes the controller more than a dispatcher. It decides which information is relevant, preserves cross-task relationships and handles what a task-local actor cannot resolve. At the same time, it is told not to predetermine reviewer severity or suppress a likely finding. The source separates supplying necessary context from steering the reviewer toward a favorable conclusion. [S30/S37; U03 F21]

The trade-off is structural: smaller worker contexts reduce repeated history, but increase the importance of the controller's selection and handoff. This is an explanatory dependency, not a measured claim that Superpowers always reduces tokens or that a controller is a demonstrated single point of failure. Another reviewer using the same incomplete brief can share that omission. More actors alone do not repair the common input.

## 4. Authority changes at handoffs

| Decision | Source-defined responsible role | Qualification |
|---|---|---|
| What is being built or probed | Human reviewing the presented intent | Approval is tied conversationally to the proposal, not implemented here as a digest-bound permission |
| Most conflicts during SDD execution | Controller, with spec and recorded ruling | Four stop classes remain: destructive/irreversible, security-sensitive, normally consent-requiring external effects, or no non-guessing path |
| Concern/blocker in executing-plans | Executor returns to the human | The alternate skill has a more stop-and-clarify-oriented contract |
| Whether a local task is accepted | Controller after prescribed review and disposition | Worker DONE is not acceptance; unverified requirements must be resolved |
| Merge, PR, keep or explicit discard | Human in finishing | Task completion does not itself grant integration or destructive authority |

[S10/S30/S31/S55; U02 F13; U03 F22; U05 F36]

This table is not a universal priority order invented for conflicting skill text. The target explicitly supplies user-over-skill and spec-over-plan priorities. It does not fully settle every generic/specialized overlap. Scope expansion versus SDD rulings, reviewer wording assigning plan-mandated defects to the human versus controller adjudication, and fresh-verification versus evidence reuse remain qualified in [S05's composition register](S05-native-system-model.md). They must not be silently resolved by our preferred design.

## 5. Workspace and recovery are part of the handoff

Worktree creation is host-conditioned and can be declined or replaced with in-place work. An existing worktree can be reused. Passing baseline tests is not the same as verifying that the working copy contains no unrelated changes, and a declined worktree is not automatically consent to implementation on main/master. [U02 F15]

The executor also needs the actual documents in its environment. U02's local fixture showed why a plan saved but not committed need not exist in a new worktree. The appropriate conclusion is a materialization prerequisite, not that agents inevitably lose plans. [U02 F18]

SDD supplies a real recovery mechanism: a per-plan scratch area, progress ledger, brief/report files, rounds and commit references. It instructs a resumed controller to prefer the ledger and Git history over recollection. That refutes a text-only account with no work continuity. [S30; U02 F16; U03 F23]

The mechanism has distinct identities: working-tree root, plan basename, full path, plan revision and completed task. Earlier local observations found same-basename collisions and unchanged completion markers after same-path plan edits. Those remain scoped helper observations, not proof of an actual agent skipping work. They show why retrieving an old record and establishing its applicability are separate tasks. [U02 F16]

The records are intentionally short-lived. Recovery while scratch exists and retaining necessary decisions after cleanup are different promises; [S04](S04-execution-verification-and-delivery.md) follows that later transition.

## 6. Process weight and coordination are different dimensions

The source does not justify extending SDD's file-backed delegation/ledger properties to every bounded change. The bounded path omits the written plan, while SDD's entry expects one. This does not prohibit every possible one-off delegation; it means the full planned SDD chain is not automatically established for that route. [S10/S30; U01-A F01; U03 F24]

A public discussion, [issue #2203](https://github.com/obra/superpowers/issues/2203), provides a bounded challenge to the model. The reporter describes v6.3.0 bounded work staying in the main session and increasing its context load. No transcript is attached. In [the follow-up](https://github.com/obra/superpowers/issues/2203#issuecomment-5434633417), the reporter explicitly does not claim the work is bad. The reply by obra asks whether the concern is outcome quality or preferred delegation and suggests a host-policy explanation. That external-policy claim was not independently verified here. [I01/I02 in U08-A register]

The report neither proves a performance regression nor isolates Superpowers from host/model/request effects. Its useful contribution is to separate objectives that a simplified model would combine: fewer planning artifacts, lower human interruption, smaller controller context, lower total cost and better delivered work. Improvement in one is not proof of improvement in all. The native source model can explain this distinction without adopting the reporter's proposed fix or launching a benchmark.

## 7. Synthesis contribution and limits

The subsystem's positive contribution is structured agreement and context engineering: scalable preparation, explicit spec/plan relationships, testable task boundaries, interfaces, required review inputs and recoverable decisions. Its main applicability conditions are adequate classification, actual consent, correct context selection, reachable matching artifacts and stage-appropriate authority.

The source supports this explanation; no new live-agent run validates how reliably it happens. The companion's clicks supplement rather than replace dialogue, and a task template does not establish a universal workflow engine. S03 joins operational availability in [S02](S02-availability-runtime-and-distribution.md), execution in [S04](S04-execution-verification-and-delivery.md), and procedure evolution in [S01](S01-skill-evolution-and-evaluation.md). The native whole-system account is [S05](S05-native-system-model.md); project projection remains later authorized research.
