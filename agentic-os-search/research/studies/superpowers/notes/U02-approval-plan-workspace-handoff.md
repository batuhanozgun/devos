# U02 — Approval, Plan Identity and Workspace Handoff

Date: 2026-09-17. Primary target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0).

**Status: BOUNDED SOURCE / LOCAL-HELPER INVESTIGATION COMPLETE.** Whole study remains ACTIVE / PARTIAL. This unit follows [U01-B](U01B-host-delivery-and-continuity.md): restoring procedures is different from recovering a particular work item. U03's delegation/review investigation remains next; reading its main skill here does not complete it.

Source IDs resolve through [SOURCE-LEDGER.md](../SOURCE-LEDGER.md). Research method remains v0.1. Evidence: [runner](../evidence/U02-handoff-probes.py) and [actual output](../evidence/U02-handoff-probes-results.json).

## 1. Question and coverage

How does a request become approved intent, a specification/plan, a usable workspace and an admitted task? Which identities and permissions survive that chain, and which are only assumed?

S10 brainstorming was re-read fully at the pin. Nine new files S28–S36 were read fully: writing-plans, using-git-worktrees, SDD, executing-plans, three SDD scripts, the implementer template, and the first-party workspace test. SDD's large SKILL was read in contiguous ranges through EOF. Its detailed reviewer templates, independent parallel dispatch, broader evaluation and finishing dependencies remain future work. Two bounded directory trees were inspected; no recursive whole-repository coverage is claimed.

Two exact helper scripts were executed in temporary synthetic repositories. The documented ignore-check command was also executed literally. No skill was activated as our instructions; no coding-agent/model session, real approval, plugin installation, dependency installation, upstream test suite or production work was executed.

## 2. F13 — Authority changes with the phase and execution route

**OBSERVATION — S10/S28/S30/S31.** The three brainstorming paths remain distinct. Spike ends in an answer and throwaway code; bounded work receives in-chat design approval without a separate spec/plan; architectural work produces a written spec, self-review and user review before planning. Hidden complexity upgrades the path. Approval of a spike is explicitly not approval to retain its code or begin follow-up implementation.

The architectural plan header points back to the Spec. Writing-plans ends by asking which execution approach to use. That is not a documented machine-verifiable approval token tied to a particular plan digest.

SDD then defines a different operating contract: the spec is binding, the plan argues from it, and the controller rules on most conflicts/ambiguities rather than stopping for the user. Each ruling must record the decision, reason and cost if wrong. Its four stop classes are irreversible/destructive operations, security-sensitive actions, external effects that normally need consent, and a plan so broken that every way forward is a guess.

Executing-plans instead says to raise concerns before starting and stop on blockers, unclear instructions or repeated verification failure. It also redirects to SDD when subagents are available. Its short executable prose says to execute all tasks; the description/handoff language still mentions checkpoints, but does not define a batch size or an obligatory human checkpoint after every batch.

**INFERENCE.** Choosing the execution route is not just choosing whether another model writes the code. It changes who resolves uncertainty and when the human is consulted. We cannot generalize the brainstorming approval gate into a universal stop-on-ambiguity rule throughout Superpowers.

**OPEN SEAM.** Brainstorming's reclassification rule and SDD's broad ruling authority can overlap when implementation exposes substantial new scope or architecture. The inspected files do not give a shared executable arbiter that resolves every overlap. This is an unresolved authority boundary, not proof that all decisions conflict or all runs violate consent. The target's self-authorizing prose is not authority for this research agent.

## 3. F14 — The plan tries to carry its justification, constraints and interfaces

**OBSERVATION — S28.** Plans name a Spec and copy its project-wide requirements into Global Constraints. Tasks specify exact file paths, consumes/produces interfaces, tests, implementation steps and commits. The task boundary is a deliverable with its own test cycle and meaningful reviewer gate; the two-to-five-minute estimate applies to an individual step, not a universal task-size quota.

The author performs a spec-coverage, placeholder and type-consistency check. These are self-review instructions, not independent verification. SDD's entry review is another source-reading discipline: one ledger row for every task and for each pair sharing a file/interface, with conflicts and rulings recorded. A bare clean verdict is expressly insufficient.

**INFERENCE.** The plan is more than a to-do list. It attempts to preserve the reason for each task and neighboring interface obligations while reducing the context a worker must load. Its adequacy still depends on source-to-plan fidelity and controller judgment; copying an exact value does not establish that the value is correct or current.

**BOUNDARY.** The inspected header names a spec path, not its immutable revision. SDD reads a reachable Spec when supplied, but a missing/unreachable spec yields a note and provisional rulings rather than an unconditional stop. That is different from a missing plan file, which the helper rejects mechanically.

## 4. Request-to-task chain and artifact roles

| Transition / artifact | Producer → consumer | Binding / retention actually described | Failure or boundary |
|---|---|---|---|
| In-chat intent / approval | Human and brainstorming agent → next phase | Conversational approval of presented intent; heavier written artifacts only on the architectural path | Not an executable authorization capability; revised scope may require reclassification. |
| Written spec | Brainstorming agent → human, planner, SDD controller | Default dated path; explicit commit instruction; user may override path | Self-review/user edits can change content; no exact approval-to-digest protocol is specified here. |
| Implementation plan | Planner → execution controller | Saved dated path, Spec pointer, globals, interfaces and checkbox steps | Save/frequent-commit guidance is not an explicit final plan commit-and-transfer check at every execution entry. |
| Git worktree | Host/native tool or Git fallback → controller/workers | A chosen working tree, branch/detached state and setup/baseline | User can decline; sandbox-denial fallback can work in place. Does not itself certify task consent. |
| SDD scratch workspace | sdd-workspace → controller/helper scripts | Current working-tree root plus plan basename; self-ignored scratch | Basename is weaker than full plan identity and revision. |
| Progress ledger | Controller → resumed controller | First line names plan path; task-completion and fix-round lines; commit references; git-log recovery | Instructions interpret this ledger. Helper does not validate task completion or invalidate entries after plan edits. |
| Task brief | task-brief → implementer/reviewer | Selected task heading/body in a plan-scoped file | Plan-level Spec/globals are not automatically included by the extractor. Controller must carry required context. |
| Report / review package | Worker / helper → controller/reviewer | Report file; BASE-to-HEAD commit list and diff | Review/acceptance semantics remain U03/U04. File production alone is not acceptance. |

This is a source-grounded cross-file map, not a runtime trace from an observed agent session.

## 5. F15 — Workspace selection preserves host ownership but can reduce isolation

**OBSERVATION — S29.** The procedure checks existing linked-worktree state before creation, considers submodule context, respects user preferences/consent, prefers native host tools and then falls back to Git. Existing linked worktrees, including detached ones, are reused. If the user declines a new worktree, work continues in place. A permission-denial fallback likewise reports the limitation and continues setup/tests in the current directory.

Setup and baseline tests follow. Failed baseline tests require a report and user decision. The file's clean-baseline section is a test-baseline requirement; it does not contain an equivalent comprehensive check that no unrelated tracked/untracked edits already exist. Do not equate passing tests with a clean working copy.

**INFERENCE.** Isolation is a negotiated/host-conditioned working arrangement here, not an invariant achieved by every path. A declined worktree is also not automatically consent to implementation on main/master: SDD and executing-plans separately require explicit consent for that.

Git's [worktree documentation](https://git-scm.com/docs/git-worktree), consulted on 2026-09-17, confirms that linked working trees share the repository while having per-worktree HEAD/index and checked-out state. This describes Git topology, not a security sandbox or independent actor authority. No new sandbox claim is made.

## 6. F16 — There is work recovery, but its identity is weaker than its broad description

**OBSERVATION — S30/S32.** SDD records progress in a per-plan scratch workspace rather than only in conversation/todos. It checks the ledger's plan-path header, resumes after completed tasks, preserves fix-round position, and uses named commits/git log. These are concrete continuity provisions; U01's entry-layer limitation must not be generalized into no work recovery anywhere.

The helper verifies plan-file existence and derives the directory with `basename PLAN_FILE .md`. It does not incorporate full path or content revision. A shared self-ignoring .gitignore keeps scratch out of normal Git status/staging. The code comment claims this prevents one plan from overwriting another structurally; that claim needs a basename-uniqueness condition.

**LOCAL OBSERVATION — E05/E06.** Different basenames yielded different directories. However, `team-a/shared.md` and `team-b/shared.md` in one working tree yielded the same scratch directory. Extracting Task 1 for the second plan overwrote the first plan's Task 1 brief. This fails the recorded cross-plan isolation criterion.

The ledger's different-path check can prevent a compliant controller from reusing the wrong completion entries; it does not make the underlying brief/report namespace disjoint. No live controller was run, and we did not observe actual tasks being skipped.

A second probe changed a plan at the same path. The helper returned the same workspace, the synthetic completion line stayed byte-identical, and the brief was regenerated from revised task content. This is an observed lack of helper-level revision invalidation, not proof that a real controller always accepts the stale completion. Source changes, Git review, or human intervention may expose it.

**INFERENCE.** Worktree identity, plan pathname, plan revision and task completion standing are different bindings. The mechanism supports resumption within assumptions; it does not by itself establish that a completed task under one plan revision remains complete under another.

**RETENTION BOUNDARY.** Scratch is ignored, may be destroyed by git clean -fdx, and is intended for deletion at finish. SDD therefore instructs the controller to preserve rulings in its final human-facing report before deletion. Whether code commits and that report retain every load-bearing decision/evidence item is U03/U05 work; Git code history does not automatically contain an ignored ledger. No cleanup was performed on a user's work.

## 7. F17 — Task extraction is not complete requirement transfer

**OBSERVATION — S28/S30/S33/S35.** task-brief extracts numbered task sections with an awk parser and skips matching headings inside supported triple-backtick fences. It is not a complete Markdown parser or a semantic requirements compiler. It reports missing task content with exit 3 and a missing plan with exit 2. Default output is deterministic per plan basename and task number.

The local fixture preserved Task 1 and its fenced example while excluding Task 2. It also excluded the plan header's Spec pointer and Global Constraints. These are descriptive boundary observations, not failed assertions that the helper must include the entire plan.

SDD instructs the controller to give the worker its task, interfaces and global constraints, and explicitly forbids sending the whole plan/history. The implementer template has an open Context section; it does not itself extract globals. The controller is consequently a load-bearing information-transfer actor, not a transparent script launcher. Correct extraction and adequate dispatch are different claims.

The template allows a child to ask/escalate uncertainty to the controller and forbids child-created subagents/reviewers. Whether that packet and escalation preserve all requirements is U03; those instructions have not been behaviorally tested here.

## 8. F18 — Saving an artifact does not establish availability in the execution worktree

**OBSERVATION — S28/S29/S30/S31.** The planner saves a plan; execution establishes or reuses a workspace and then reads the plan. Neither the existence of a relative path in the original checkout nor a message saying saved guarantees that this path resolves in a newly checked-out worktree.

**LOCAL OBSERVATION.** A synthetic spec was committed, but its plan was only saved. A new detached worktree from HEAD contained the spec and not the uncommitted plan; sdd-workspace rejected the relative plan path with exit 2. After committing that plan, a new worktree contained it and the helper produced worktree-local scratch. This is standard Git materialization behavior, corroborated by the primary Git documentation, not a Superpowers-specific Git defect.

**INFERENCE / QUALIFICATION.** There is a handoff prerequisite: the chosen executor must actually receive a reachable, appropriate plan/spec revision. The agent might satisfy it by committing the plan, retaining an existing worktree, copying it, or using an explicitly reachable path. The experiment does not establish that normal agent runs omit this step. It shows why written-in-chat and saved-on-disk are insufficient end-to-end evidence.

## 9. F19 — The documented ignore check is not bound to the selected directory

**OBSERVATION — S29.** The path policy selects .worktrees when both .worktrees and worktrees exist. Its displayed safety command succeeds if either of those paths is ignored.

**LOCAL OBSERVATION.** With both directories present but only worktrees ignored, the displayed command returned success while a direct check of the selected .worktrees returned not-ignored. Both-ignored and neither-ignored controls behaved as expected. This fails the criterion that validation concern the actual selected directory. Git's [check-ignore documentation](https://git-scm.com/docs/git-check-ignore) was consulted for quiet/exit-status semantics; the local observed version was Git 2.47.3.

**CAUSAL INTERPRETATION.** The selection is specific; the verification predicate is an OR over alternatives. A true result for the unselected alternative can qualify the wrong path. This is a bounded example-command weakness, not an observed accidental commit, a claim that .gitignore never works, or a proof that an agent cannot notice and correct it. Custom user-selected locations also require appropriately targeted checking; no additional custom-location execution is claimed.

## 10. Experiment record and verification limits

E05/E06 used the exact helper blobs S32/S33, checked before execution: 1,586 and 1,158 bytes respectively. S34 review-package was separately transferred/hash-checked but not executed. The ignore experiment used the literal displayed command from S29, not an execution of the full skill.

Environment: Linux, Python 3.13.5, Git 2.47.3, Bash 5.2.37. Repositories, synthetic commits, isolated HOME and worktrees lived under an automatically removed temporary directory. No remotes, credentials, user-repository changes, dependency install or model calls were involved.

Thirteen cases were collected: eleven named mechanism/representation/identity observations matched their expectations; two health criteria failed. An observation PASS is not a product-quality pass: e.g., confirming a retained completion marker establishes its presence, not that retaining it is correct. Runner exit 0 means successful collection. Positive and negative fixtures constrain the local oracle; no independent reviewer or general verifier qualification is claimed.

S36's first-party test was fully read, not executed. It checks missing inputs, different plan basenames, ignored scratch, helper output placement and worktree separation. Its two plan fixtures have different basenames. That test does not by itself test full-path collisions, same-path revisions or real agent recovery. This is a statement about that file, not repository-wide test absence.

## 11. Method reflection, residuals and next work

The unit needed to follow both the behavioral instruction and the artifact it manipulates. A prose-only account would miss concrete basename/materialization effects; a helpers-only account would miss consent, spec authority, controller rulings and possible human correction. Neither replaces the other.

The synthesis remains native to Superpowers. Potential SOUL/Development OS reuse concerns phase authority, artifact identity, requirement transfer, chosen-target verification and recoverable decisions. No Foundation node, architecture, dependency or new control rule has been adopted.

Question transitions:

- Q05 now has a bounded request/spec/plan/workspace answer, with live approval and revision binding still unverified.
- Q04 is partially informed by the full SDD/implementer reads; child/reviewer packets and actual acceptance remain U03/U04.
- Q13: how are scope expansion and plan correction bounded between brainstorming reapproval and SDD rulings?
- Q14: what rebinds existing completion/review state to a changed plan/spec revision?
- Q15: how reliably does the controller carry globals, interfaces and prior rulings into each isolated brief?
- Q16: what preserves ignored reports, rulings and review evidence across worktree transfer/cleanup?
- Q17: do task/review helpers and their consumers consistently bind checks to the chosen artifact/range?

**Next authorised unit: U03 — execution, delegation and review handoffs.** Preserve all current full-read statuses. Read task-reviewer-prompt.md, re-review-prompt.md, dispatching-parallel-agents/SKILL.md and requesting-code-review sources; re-enter the already-read SDD and implementer contracts selectively. Trace worker result → controller disposition → reviewer evidence → fix/park/complete → continuation. In particular, completion with parked findings is not the same as a clean review. Do not treat the prior README's two-stage-review sketch as the final current task-review topology.
