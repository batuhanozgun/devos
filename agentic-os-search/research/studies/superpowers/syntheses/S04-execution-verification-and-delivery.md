# S04 — Execution, Verification and Qualified Delivery

Date: 2026-09-18. **Provisional native subsystem synthesis within the unfinished study.** Primary: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0). [STATE](../STATE.md) owns current work and authorization.

Evidence roots: [U02](../notes/U02-approval-plan-workspace-handoff.md), [U03](../notes/U03-delegation-review-and-acceptance.md), [U04](../notes/U04-testing-diagnosis-and-verification.md), [U05](../notes/U05-delivery-cleanup-and-retention.md). Source IDs and original experiments resolve through their ledgers; [U08-A](../SOURCE-LEDGER-U08A.md) records synthesis recovery/direct re-entry. No earlier experiment is rerun or given a stronger evidence class here.

## 1. Native explanation: production, assessment and disposition differ

The planned SDD route assigns implementation, task review, cross-task coordination and final integration decisions to different responsibilities. It tries to keep local work focused while returning unresolved questions to the actor with broader context. Its governing workflow is in skill and role instructions, supported by file/Git helpers; it is not a single executable state machine demonstrated by this study. [S30/S35/S37/S38; U03 F20–F23]

A compact task loop is:

`admitted task/context → implementer result → review package and task review → controller coverage resolution → correction or recorded disposition → qualified task completion`.

DONE starts review. It does not mean that requirements were independently verified or that integration is authorized. A report can preserve useful evidence without being accepted at face value.

## 2. Review topology is specific

One task reviewer reads the task diff and produces both spec and quality verdicts. A scoped re-review checks fixes; a broader whole-branch review comes later. Two verdicts are not two independent reviewer agents. Implementer self-review is also not the controller-dispatched review. [S30/S37/S38/S41; U03 F20]

| Stage | Main evidence and responsibility | Different conclusion not established automatically |
|---|---|---|
| Implementer | Brief, context, changes, tests, commits and report | Accepted task |
| Task reviewer | Same brief, global constraints, report and recorded BASE–HEAD diff | Entire-system coverage or independent test re-execution |
| Controller | Reviewer findings plus plan/spec/cross-task context | Correct ruling merely because authority was assigned |
| Scoped re-review | Prior findings, amended-code evidence and FIX_BASE–HEAD diff | Unchanged areas fully re-reviewed |
| Final branch review | Whole-branch range and deferred/parked findings | Human authorization to merge or publish |
| Finishing | Current tests, actual branch/workspace and human choice | Every cleanup/retention operation has succeeded |

The reviewer is told to treat report claims and design rationales as unverified. Focused source recovery is allowed for a named risk or a cut-off hunk; unverified requirements are returned explicitly. The controller must resolve them before task completion. This is a deliberate distribution of coverage, not a promise that a diff contains all relevant facts. [S30/S37; U03 F21]

The same brief and controller-selected constraints are shared inputs. Fresh context can help separate roles but does not establish epistemic independence. Read-only/no-child instructions do not themselves revoke host capabilities.

## 3. Correction is bounded without pretending the bound proves correctness

BLOCKED and NEEDS_CONTEXT call for a changed response: supply context, increase capability, decompose or correct the plan. Repeating the same unsuccessful attempt unchanged is expressly discouraged. [S30; U03 F22]

Spec failure, Critical/Important findings and confirmed requirement gaps enter the task fix loop. Minor findings are deferred. Plan-mandated conflicts receive a spec-grounded ruling before action; this is a separate route from the cap-based adjudication of other open findings. Rounds one to three normally resume the original implementer; rounds four and five use a fresh, more capable implementer. A host without resumption can use the saved report with a fresh worker. Every round supplies covering test evidence and a scoped re-review. [S30; U03 F22–F23]

At the cap, repeated fixing gives way to adjudication. Contestable and non-load-bearing issues can be parked with reasons. A real load-bearing issue requires an explicit unblocking decision carried into dependent work; the text does not allow silently ignoring it. The completion record distinguishes a clean review from completion with parked findings. [S30; U03 F22]

The final branch review has a different budget: one fix wave and one scoped re-review, then recorded residual decisions. Residual load-bearing findings are directed to the human at finishing. Neither five rounds nor a final fix wave establishes that a remaining issue is false. Caps can limit further effort, but the claimed cost/quality advantage was not measured by this research.

## 4. Test quality has several independent obligations

TDD asks for an expected failing test before implementation, followed by a passing result and green refactoring. The supporting test guide asks which concrete break the test catches and requires expectations that are not computed by the same production implementation. Appropriate doubles can observe boundary contracts; checking only mock existence is not sufficient. The mutation check is a mental discipline, not an automatically executed mutation-testing framework. [U04 F28; S44/S47]

Three propositions must therefore remain separate:

1. The test preceded the implementation and failed for the intended reason.
2. Its oracle and observations discriminate the relevant correct and incorrect behavior.
3. Its current result applies to the code, inputs and environment behind the present claim.

One proposition does not prove the other two. Repeating an invalid test does not repair its oracle. Writing a sound test after the implementation does not establish test-first chronology. A current green result does not cover an untested requirement. [U04 F28/F32–F33]

Systematic-debugging adds a causal investigation loop: reproduce, trace relevant values and conditions, compare, state a hypothesis, change a variable, then verify. Its escalation counts are decisions about process, not scientific proof that the architecture is wrong. A debugging attempt and an SDD review round are not automatically the same unit. [U04 F29]

Received review likewise requires technical evaluation before implementation. A reviewer suggestion, a human request and an evidence-supported diagnosis have different roles. [U04 F31]

## 5. Evidence has an object, not just a date or a PASS label

S30 requires BASE to be recorded before dispatch and FIX_BASE to be the head previously reviewed. The helper packages the supplied range; it does not discover the true task boundary. Earlier local checks showed that a valid shorter range can omit an earlier task commit and that a fixed committed range is unchanged by uncommitted edits. Those are scoped observations explaining why caller-selected identity matters, not a new execution here. [U03 F25]

The generic verification skill requires fresh current-message commands. The task/re-review contract instead reuses existing same-code test evidence unless a specific unanswered doubt warrants a focused test. Reporting what an existing record says differs from claiming an independent rerun, but this interpretation is not a complete source-defined resolution of the literal overlap. Q24 remains open for actual multi-skill composition. [S30/S37/S45; U04 F33]

The diagnostic helper and version-helper cases elsewhere in the study reinforce the same narrower point: a successful search/audit invocation, no observed target and complete validation are different outcomes. Their exact failures must not be flattened into either universal unreliability or a single all-green score. [U04 F34–F35; U07-B F76]

## 6. Delivery creates new objects and new authority questions

Finishing requires current tests before its ordinary integration menu and gives the human merge, PR or keep choices as appropriate to branch state. Discard is separately requested and confirmed, not an ordinary default menu option. A detached workspace's action menu differs from a named branch's, and actual host capabilities can further constrain execution. [S55; U05 F36/F38]

Local merge is followed by tests of the merged result. This is a genuinely different verification object: separately green inputs need not produce a green integrated state. The earlier synthetic Git case demonstrates that possibility without being a failure of Superpowers' prescribed retest. [U05 F37]

Integration, publication and cleanup also do not form an automatically atomic transaction. Merge can succeed while branch deletion is refused because a retained worktree still uses it. A conflict can leave an unfinished merge. A command failing later does not establish that earlier effects were undone. These remain the original local Git-primitive observations, not real project incidents. [U05 F37/F39]

## 7. Decision disclosure is not identical to evidence archival

SDD requires every Ruling entry, with its cost if wrong, to reach the final human-facing message before deletion. It also directs residual load-bearing findings to finishing. These are substantial preservation duties and must not disappear from a critical account. [S30; U05 F41]

However, code commits, human-visible decisions and detailed report/test artifacts are different records. Scratch is ignored and intentionally ephemeral. Normal worktree removal can delete ignored scratch without force; refusal-based protection applies to the conditions that trigger refusal. PR/keep can preserve an outer worktree without proving an inner SDD directory was never deleted. [U05 F40–F41]

The controller must therefore compose disclosure, residual handling and cleanup requirements. The inspected generic finishing skill does not itself consume the SDD ledger as a required input or certify that every necessary record has been transferred. A concise menu and a prior risk disclosure can potentially coexist; their separate existence is not itself a contradiction. Their actual composition and receipt remain unobserved.

## 8. System contribution and boundary

The strongest positive source-level contribution is a differentiated work-control discipline: small testable tasks, independent-looking but explicitly scoped review roles, coverage escalation, diagnosis before repeated fixing, changed-response escalation, recorded disagreement, merged-result testing and human integration choice.

Its limits follow where these responsibilities depend on context selection, evidence applicability, judgment and handoff. A clean task, a parked task, a green test, a successful merge and retained decisions are different standings. They should not be compressed into one completion fact.

This synthesis does not prove that more rules or more reviewers improve outcomes. It explains the source's intended distribution of labor and its concrete helper boundaries. [S05](S05-native-system-model.md) composes this with availability [S02](S02-availability-runtime-and-distribution.md), intent/context [S03](S03-intent-planning-and-context-handoff.md), and separate skill evolution [S01](S01-skill-evolution-and-evaluation.md). Foundation projection and CORE remain open.
