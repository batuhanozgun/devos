# U04 — Testing, Diagnosis and Verification Claims

Date: 2026-09-17. Target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0).

**Status: BOUNDED SOURCE / DIAGNOSTIC-HELPER INVESTIGATION COMPLETE.** Not live-agent qualification, a general TDD effectiveness study, or whole-study closure. U01–U03 remain preserved. U05 owns final delivery and retention.

Sources S44–S54 and E09/E10 resolve through [SOURCE-LEDGER-U04.md](../SOURCE-LEDGER-U04.md). Earlier source IDs resolve through the original ledger and U03 supplement. Method remains [v0.1](../METHOD.md).

## 1. Question and coverage

When does an observed test or review result justify saying that a defect is fixed, the work meets its requirements, or the current work is complete?

Eleven new files were read fully at the pin: four SKILL bodies (TDD, verification-before-completion, receiving review, systematic debugging), the actual writing-good-tests reference, three debugging technique references, the condition-waiting example, find-polluter, and its first-party test. Two bounded source trees were inspected. This is not recursive repository coverage or a complete evaluation campaign.

One exact diagnostic helper and its exact first-party fixture test were transferred and Git-blob-verified before local execution. Controlled npm stubs replaced the real test launcher. No coding-agent session, actual project test suite, dependency installation, network call, credential, or upstream mutation was involved.

## 2. F28 — Test chronology, error sensitivity and oracle validity are separate obligations

**OBSERVATION — S44/S47.** TDD prescribes an observed expected failure before minimal implementation, a passing result afterward, and continued green tests during refactoring. A typo, test setup error or unrelated failure is not the intended RED. Its supporting reference adds two explicit principles: name the particular break the test catches, and exercise the real behavior.

The reference requires expectations derived without the production implementation or its helpers; literals and hand-checked fixtures are preferred. It distinguishes bugs from intentional design changes, behavior tests from source-text assertions, and real effects from mere mock presence. It permits specific doubles where arguments/order/counts are part of the boundary contract. Thus its warning against testing mocks must not be expanded into a ban on every spy or controlled dependency.

It also asks for a **mental** mutation check: would wrong arguments, branches, missing state changes or invalid-input handling escape? That instruction is not an implemented mutation-testing engine and does not establish that mutations were actually executed.

**INFERENCE.** These rules address different error paths. Watching a test fail can demonstrate sensitivity to that particular missing behavior; it does not independently establish that the requirement, expected value or coverage is correct. Running a well-grounded test after a change establishes an observation at that revision; it does not retroactively establish test-first chronology. Neither implication should be reversed.

A useful source tension remains: TDD's checklist calls for a test for every new function/method, whereas its supporting reference exempts trivial forwarding and human prose unless behavior earns a test. Read the behavioral qualification rather than turning a function count into the quality criterion. No universal precedence resolver or measured agent interpretation was established.

## 3. F29 — Diagnosis is an evidence loop; escalation counts are not causal proof

**OBSERVATION — S48/S49/S50.** Systematic debugging traces errors, reproduction conditions, recent changes and data/environment propagation across component boundaries before proposing a fix. It compares working examples, states a specific hypothesis, changes one variable and reevaluates. Root-cause tracing follows an invalid value back to its originating call or initialization, rather than only patching the point where the error manifests.

The procedure then calls for a reproducing test, a focused correction and verification of both the original issue and regressions. The supporting defense-in-depth reference distinguishes entry checks, business checks, environment guards and diagnostic logging. These have different functions: logging supports detection/diagnosis; it does not itself prevent an effect. Multiple checks are not automatically independent or complete protection.

The debugging SKILL directs an architectural discussion after three unsuccessful fixes. SDD instead describes escalating implementer/model at rounds four and five, then adjudication. The counts concern related but not necessarily identical loops; a debugging attempt and a task-review round cannot simply be equated. Their overlap is still a composition question.

**CALIBRATION.** Statements such as three failures proving a wrong architecture, 95% of no-root-cause cases being incomplete investigation, or layered checks making a bug impossible are target assertions/rationales, not research-established statistics or proofs. The historical test counts and speed/pass-rate improvements in the supporting documents were not independently recovered or reproduced.

The main debugging file also provides a bounded exit when investigation supports environmental/timing/external causes: document the investigation, add appropriate handling and monitoring. This qualifies its absolute anti-symptom wording. The root-tracing diagram itself permits a symptom-point fallback when tracing is impossible. Do not erase those qualifications to manufacture a single unconditional doctrine.

## 4. F30 — Waiting for a condition is not automatically waiting for the current operation

**OBSERVATION — S51/S52.** The waiting guide replaces guessed delays with repeated reads of the relevant condition plus a timeout. It retains justified timed waits when time-dependent behavior is what is being tested. The example supplies event-type, event-count and custom-predicate variants; the latter explicitly demonstrates matching a tool-call ID.

The type/count helpers inspect the events returned for a thread without themselves recording a new-operation boundary. Existing matching events can therefore satisfy those predicates. That is not necessarily a bug: an occurrence query may intentionally accept an existing event. A claim that a *new specific operation* completed requires the caller to choose an appropriately bound predicate or event scope. The custom matcher is an available source-level route for that distinction.

The TypeScript example imports Lace-specific types and is a reference example, not a standalone generic runtime proven by this study. It was read, not executed. No flaky-test rate, timing improvement or event-race elimination was measured here.

## 5. F31 — Received review is input to a decision, not an implementation command by itself

**OBSERVATION — S46, compared with S30/S37/S38.** Receiving-review instructions require reading and understanding feedback, checking it against the actual codebase, evaluating compatibility/context and only then accepting or pushing back. Unclear related items are to be clarified before piecemeal implementation. External suggestions that conflict with prior human decisions are routed back to the human. The source treats human-originated feedback differently, but that does not make a human's technical proposition independently verified.

Its YAGNI example searches usage, then asks whether an apparently unused endpoint should be removed; the longer example expressly asks about possibly missed usage. A search miss must not be promoted to universal absence of consumers.

**COMPOSITION BOUNDARY.** Generic receiving-review says clarify before proceeding and handle items individually; specialized SDD asks the controller to rule on many ambiguities and uses a single final fix wave. Those can describe different actors/stages, but the files do not mechanically resolve every overlap. A subordinate asking its controller is also not the same event as a controller stopping for the human. Preserve the actor and stage when interpreting a stop rule.

## 6. F32 — Verification is claim-specific, not a generic green status

**OBSERVATION — S45.** Verification-before-completion requires identifying the command relevant to the claim, executing and reading its complete output and exit status, then either reporting the actual failure or making an evidenced claim. It expressly distinguishes build from lint, tests from requirements, code edits from a fixed original symptom, and agent-reported success from inspecting the resulting changes.

Its regression example also uses pass → remove fix → fail → restore → pass as a sensitivity check. That demonstrates a falsification-oriented check, not proof of every requirement or of TDD chronology for the whole change.

| Proposed claim | Evidence the source asks for | What must not be inferred |
|---|---|---|
| Test command passed | Output and failure count for the relevant run | Every requirement is met, every possible execution mode was covered |
| Build passed | Actual build command and exit status | Lint success is a substitute |
| Original bug fixed | Reproduction/regression observation after the change | Editing likely code is sufficient |
| Requirements met | Re-read plan and check each requirement | Green tests imply complete scope coverage |
| Child completed successfully | Inspect VCS changes and verify their meaning | A DONE message is accepted completion |

These are procedural checking instructions, not an executable verifier framework. In particular, a VCS diff establishes changes, not by itself their correctness. The choice of command, oracle and coverage remains load-bearing.

## 7. F33 — Fresh claims and reused evidence need a composition rule the sources do not fully supply

**OBSERVATION — S45 versus S30/S37/S38.** The generic verification skill says a passing claim requires running the command in the current message, lists previous runs as insufficient, and applies broadly to positive work-state statements. The specialized task/re-review templates instead reuse implementer test reports for the same code and disallow routine suite reruns; focused tests are permitted for an unanswered concrete doubt. Missing/truncated report evidence is recovered before being treated as nonexistent.

Some apparent conflicts disappear when the claim is made precise: reading an unchanged report and saying what it reports is not independently claiming a fresh run; a complete command can be a focused command rather than the entire suite. But those interpretations are **research inferences**, not a complete source-defined exception to the same-message rule.

The inspected files do not mechanically bind a report to a complete code/worktree, environment, test/oracle and input identity, nor automatically invalidate it after every relevant change. U03's fixed-commit-versus-dirty-working-copy finding therefore remains relevant. This is a bounded absence in the inspected contracts/helpers, not a repository-wide assertion that no other mechanism can help.

**ANALYTICAL CHECK, not adopted architecture:** For a load-bearing result ask what claim, code state, oracle/test, inputs, environment, command/output and observation time it concerns; then ask which of those dependencies changed. Mere recency is insufficient, and age alone does not prove the evidence became invalid. Actual host/model interpretation and end-to-end evidence reuse remain untested.

## 8. F34 — The diagnostic helper finds a particular side effect, not all test correctness

**OBSERVATION — S49/S53/S54.** Despite the bisection label, find-polluter runs the selected files sequentially and stops after observing creation of the requested filesystem target. It skips a file if that target already exists. It discards test-launcher output and suppresses the launcher's nonzero status before checking the target. Its final line says no polluter found and all tests clean.

The helper's narrow objective can justify continuing after a failed test: a failing test may still produce the side effect being investigated. That is different from proving tests passed. A target not appearing does not establish successful execution, complete coverage, causal independence or general cleanliness.

**LOCAL OBSERVATION — E09/E10.** Both source blobs were verified before execution. All project test execution was replaced with a controlled npm stub; its independent call log records invocation, and a filesystem check records target existence.

| Case | Actual result | Interpretation |
|---|---|---|
| Missing arguments | Exit 1, zero launcher calls | Input rejection |
| Two matching files, clean stub | Both invoked, no target, exit 0 | Positive narrow search control |
| Stub creates target | One invocation, found signal, exit 1 | Positive detection/stop control; exit 1 here means found, not a broken helper |
| No matched files | Zero invocations, exit 0, final all-tests-clean wording | Failed study-defined claim-scope criterion; no scan execution established |
| Target already present | Both files skipped, zero invocations, same final wording | Failed claim-scope criterion; not a completed clean scan |
| Stub launcher returns 127 | Two failed launcher attempts, no tests, same final wording | Failed claim-scope criterion; failure to launch is hidden from final status |
| Stub test returns 1 without target creation | Two invocations, exit 0, same final wording | Descriptive scope observation, not proof those tests passed |

The zero-match and preexisting cases also print zero/skipped information earlier in stdout. A careful reader can detect the limitation. We do not call the complete output an invisible failure, infer a production incident, or claim every exit-zero search is incorrect. The three failed criteria specifically challenge the unqualified final conclusion, not a promised fail-closed API contract.

## 9. F35 — A passing first-party fixture test and these limits coexist

The exact first-party `test-find-polluter.sh` was actually executed: **exit 0, five passing assertion lines**. It uses its own npm stub to create the target, verifies nested/top-level and prefixed-path matching, and explicitly checks that zero matches report zero and reach the no-polluter path. These are real local observations of that selected fixture file, not a repository-wide suite verdict or model behavior.

The separate study runner collected seven cases: four expected mechanism/scope observations and three failed claim-scope criteria. A descriptive PASS may reproduce a limitation. Neither result is an overall product score. The runner's criteria were fixed after source inspection and before execution; this is exploratory, source-informed evidence, not preregistered independent replication.

This also prevents a simplistic reading of the no-source-grep rule: the first-party test matches text **emitted by an executed helper**, rather than merely grepping the helper's source. Runtime-output assertions can be appropriate when that output is the contract. The unresolved question is which property the assertions establish, not whether a string appears anywhere in a test.

Evidence: [runner](../evidence/U04-diagnostic-probes.py) and [actual output](../evidence/U04-diagnostic-probes-results.json). Temporary fixtures were removed. No original project tests, real npm command, live agent, credentials or installation were involved.

## 10. Method reflection and residuals

The source model must retain both useful verification disciplines and their boundaries. A bug-hunt-only account would omit the explicit independent-expectation, named-failure, requirement-checklist and hypothesis disciplines. A prose-only account would miss the diagnostic helper's observed-result-to-final-claim gap.

U04 did not run agent pressure scenarios. Their existence in the debugging tree is recorded as a U06 lead, not behavioral evidence. New helper checks were selected because they separate completed execution from a no-observation verdict, not because every research unit must have a new test.

Question transitions:

- Q18 gains the claim-specific freshness/evidence-reuse analysis, but actual result-to-code/environment binding remains unverified.
- Q20 gains TDD/reference, diagnosis/SDD and receiving-review/SDD composition cases. No universal precedence resolution is asserted.
- Q21 gains one actually run first-party helper fixture; recall/drill and skill-efficacy evaluation remain U06.
- Q22 remains open: scoped re-review's global constraints are not automatically supplied by a newly discovered mechanism here.
- Q23: how are no candidates, skipped execution, failed launch and completed negative observation preserved in final status and downstream decisions?
- Q24: which evidence-reuse/fresh-run rule applies to which actor, claim and stage when specialized and generic skills both apply?
- Q25: what binds a waited-for condition/event to the current operation rather than an earlier occurrence?

**Next authorised unit: U05 — delivery and lifecycle.** Read finishing-a-development-branch fully; re-enter SDD's final review/rulings/cleanup and worktree ownership clauses. Trace accepted or parked work → latest tests and actual revision → human merge/PR/keep decision → resulting Git state → cleanup/retained evidence. Preserve unresolved findings, ignored-scratch and external-effect authority boundaries. Installation, upstream reporting and SOUL/Development OS adoption remain outside this request.
