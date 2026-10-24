# U03 — Delegation, Review Evidence and Qualified Acceptance

Date: 2026-09-17. Target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0).

**Status: BOUNDED SOURCE / LOCAL-HELPER INVESTIGATION COMPLETE.** This is not a live multi-agent evaluation, product qualification or whole-study closure. U01 and U02 findings are preserved. U04's testing/debugging/verification mechanisms remain next.

Source IDs S00–S36 resolve in [the prior ledger](../SOURCE-LEDGER.md); S37–S43 and this round's execution record resolve in [the U03 ledger supplement](../SOURCE-LEDGER-U03.md). Method remains [v0.1](../METHOD.md).

## 1. Question and coverage

What separates an implementer's claim of completion from a reviewed, accepted task, and how are evidence, uncertainty and residual findings carried into continued work?

Seven additional files were fully read at the pin: the task-reviewer and scoped re-review templates, parallel-dispatch skill, requesting-code-review skill and its actual reviewer template, the SDD description test and its test helpers. S30's task/review/fix/final sections and S34 review-package were re-entered directly. Earlier full reads of the implementer and execution contracts remain available in this conversation; they are not counted as new files.

The exact S34 helper was hash-verified and executed with explicit OUTFILE in synthetic temporary Git repositories. A literal predicate from the description test was separately exercised with constructed answers. No agent was dispatched, no model was called, and no first-party suite was run. No upstream instructions were activated as this research agent's rules.

## 2. F20 — Current task review is one reviewer with two verdicts, not two independent review seats

**OBSERVATION — S30/S35/S37/S38/S40/S41.** SDD dispatches an implementer, then a task reviewer that checks spec compliance followed by code quality in one task-scoped review. Both verdicts are required. A separate broad whole-branch review occurs after all tasks; fix rounds use a scoped re-review rather than a new whole-system review.

The task-reviewer template explicitly says it reads the diff once and returns two verdicts. Therefore README-level references to two-stage review must not be expanded into two independent agents at this pin. Two criteria, two phases of reading and two actors are different topologies.

| Actor / stage | Required inputs | Output and next consumer |
|---|---|---|
| Controller | Plan/spec, globals, interfaces, prior rulings, current task and recorded BASE | Task brief/report locations and bounded dispatch; later dispositions and ledger entries |
| Implementer | Task brief, supplied context, working directory and report contract | DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT, commits and report; not task acceptance |
| Task reviewer | Same brief, global constraints, implementer report, BASE/HEAD and diff package | Spec verdict, unverified requirements, severity-ranked findings, task-quality verdict |
| Controller after review | Reviewer findings plus broader plan/cross-task context | Resolve unverified requirements; route fixes, plan-conflict rulings, deferred items or qualified completion |
| Re-reviewer | Prior findings, same brief, appended fix report, FIX_BASE/current HEAD and fix package | ADDRESSED / NOT ADDRESSED per finding, new fix breakage, separate out-of-scope observations |
| Final reviewer | Whole-branch range/requirements and deferred/parked ledger pointers | Broader architecture/integration/readiness review; does not itself execute a merge |

These are source-defined role contracts, not observed actors or guaranteed isolation. Implementer/reviewer templates prohibit spawning their own children. The controller owns review dispatch; an implementer's self-review does not replace the external task review.

## 3. F21 — Review independence is bounded by what the reviewer can see and what it rechecks

**OBSERVATION — S37.** The reviewer treats the report and its design rationales as unverified claims and compares them to the diff. The controller is told not to suppress anticipated findings or preassign a favorable severity. Those are useful anti-anchoring provisions, but they remain instructions.

The review is deliberately diff-first. A cut-off function or a named concrete cross-cutting risk can justify focused source recovery. Missing diff files have a direct Git fallback. Requirements that live outside the diff are returned as `Cannot verify from diff` items. S30 requires the controller to resolve every such item before completion; a confirmed gap enters the fix loop. Thus a local spec-compliant verdict with an unresolved warning is not the same as full requirement coverage.

Test evidence is normally reused from the implementer's report rather than regenerated. The reviewer can run a focused test when code reading raises a specific doubt not answered by an existing run, and can recommend heavier validation. Missing or garbled evidence is first re-read at its stated path; genuine absence becomes a reported gap. This distinguishes retrieval failure from missing evidence.

**INFERENCE.** Fresh reviewer context can reduce some anchoring, but does not prove independent execution, correct original test expectations, current result-to-code binding or complete spec coverage. The same task brief and controller-selected constraints are shared dependencies. Reusing good evidence can be efficient; its existence alone cannot validate its provenance or oracle. Conversely, rerunning the same test would not automatically fix an invalid oracle. U04 will examine that separate layer.

Read-only review is prescribed for the checkout, index, HEAD and branch state. The templates do not install a permission boundary themselves. Their wording is not evidence that a live reviewer lacks mutation capability.

## 4. F22 — Completion records include decisions about unresolved findings

**OBSERVATION — S30/S37/S38.** The return states have different meanings:

- DONE begins review; DONE_WITH_CONCERNS requires the controller to classify and handle the concern.
- BLOCKED/NEEDS_CONTEXT trigger a changed response: more context, a more capable model, decomposition or a recorded plan correction. The instruction forbids unchanged retries as a substitute for addressing the blocker.
- Spec failure, Critical/Important findings and confirmed coverage gaps enter the fix loop. Minor findings are deferred to the ledger. Findings conflicting with explicit plan text receive a spec-grounded controller ruling before action.
- Rounds 1–3 normally resume the original implementer; rounds 4–5 use a fresh implementer and a more capable model. A host unable to resume can use the report file to support a fresh worker.
- Each fix round must carry the covering tests, command and output before scoped re-review. Re-review judges each old finding and new breakage in the fix diff. An attempted fix is not an addressed finding.
- At the five-round cap, remaining findings are adjudicated. Contestable or non-load-bearing findings may be parked with rulings. Load-bearing defects require an explicit unblocking decision carried forward; they are not supposed to disappear silently.

The ledger admits both `complete (..., review clean)` and `complete (..., K parked)`. Therefore `complete` is a workflow disposition that may preserve unresolved risk; it is not a synonym for all defects fixed or all reviewers agreeing.

**INFERENCE.** The cap changes the process from repeated correction to explicit adjudication. It can bound cost and prevent an endless loop, but reaching a cap supplies no new evidence that the code is correct. The target's claim that repeated rounds indicate structural failure is a rationale, not a causal result independently demonstrated here. Keeping the reason and consequences visible is central to the intended trade-off.

The final whole-branch pass receives deferred/parked findings. SDD allows one final fix wave and one scoped re-review, then recorded residual dispositions; residual load-bearing findings are to reach the human at finishing. Whether the finishing path and durable records preserve them is still U05, not established merely by this instruction.

## 5. F23 — Context preservation and decision preservation use different records

**OBSERVATION — S30/S35/S38.** The implementer report is an appendable record used on retries and fresh-worker escalation. The progress ledger records rounds, commit ranges, deferred/parked findings and rulings. The controller keeps agent identity for resumption and supplies relevant earlier rulings to later tasks. This is more than transient todo tracking.

Before scratch deletion, every `Ruling:` entry must be copied into the final human-facing message with the cost if wrong. That is a stated preservation obligation, not proof of its execution. Ignored reports and ledger content are not automatically stored in code commits. No scratch cleanup or live transfer was performed here.

**INFERENCE.** Worker-memory recovery, accepted-task standing and durable human visibility are separate handoffs. A report can preserve what was attempted without proving that the prior review is still valid after code/spec changes. U02's path/revision limitations remain open; this round found additional consumers, not automatic revision invalidation.

## 6. F24 — Parallelism is conditional, not a general property of all SDD work

**OBSERVATION — S30/S39.** SDD prohibits simultaneous implementation workers in its task loop, while allowing small same-shape work to be batched into one dispatch. The separate parallel-dispatch skill applies to independent problem domains without shared state or sequential dependencies. It routes related failures to combined investigation and state-sharing work to sequential execution, and requires conflict checking and integrated testing afterward.

**INFERENCE.** These are distinct procedure scopes rather than a demonstrated contradiction. A claimed independent task is not automatically safe to parallelize because it has a different task number or filename. Independence is evaluated by the controller; this skill does not implement locking, isolated filesystem allocation or dependency scheduling. Context isolation also does not itself isolate shared tools/resources.

The parallel-dispatch skill permits returning summaries and running a full integration suite, whereas SDD's per-task review narrows repeated tests and review scope. Applying either test/parallelism rule universally would erase the intended context of the other. Actual efficiency and conflict rates have not been measured by this study.

## 7. F25 — A correct review package still depends on the caller choosing the right reviewed object

**OBSERVATION — S30/S34.** The controller must record BASE before dispatch, and a fix package must begin at the HEAD seen by the previous review. S34 verifies plan existence and revision resolution, then writes commit list, file statistics and net diff. It does not derive task admission from the plan or validate a report's tests against that range.

**LOCAL OBSERVATION — E07/E08.** With two synthetic implementation commits, the recorded pre-task BASE produced a package containing both commits and both changed files. Passing the first implementation commit instead also produced a successful package, but omitted the first file. A scoped fix range correctly included only the amended file. Missing plan and unresolved BASE were rejected with exit 2.

These results support the target's specific instruction to retain the pre-task BASE. They do not show S34 is broken for accepting a valid narrower range: range selection belongs to the caller. They show why a successfully generated packet does not establish complete task coverage.

A separate check modified tracked, staged and untracked working state without changing the explicit commit endpoints. The package stayed byte-identical and the helper preserved that dirty state. Thus committed-change review and current-working-copy/test execution can concern different objects. No live reviewer accepting a stale test report was observed.

The primary Git documentation distinguishes endpoint diff from ancestry-based commit listing. It was consulted for that narrow underlying behavior, not as a source of Superpowers efficacy. No arbitrary diverged-branch, mutable-ref race or full Git security campaign was added to this bounded study.

## 8. F26 — One description test has a predicate that can favor an obsolete transfer form

**OBSERVATION — S42/S43.** The SDD test file explicitly identifies itself as description/keyword testing, not behavioral drill coverage. Test 7 asks whether task information is provided directly or by file, but its predicate searches `provide.*directly`, `full.*text`, `paste` or `include.*prompt`. The current S30 contract instead calls for a brief file and directs exact task values to remain there. The predicate's helper uses case-insensitive grep.

**LOCAL COUNTEREXAMPLE — E07/E08.** The literal predicate rejected the constructed answer `Controller provides: by file` and accepted a constructed answer prescribing direct pasting into the prompt; both said the implementer must not read the whole plan. Against this round's stated criterion of matching the current transfer contract, both oracle-health checks failed.

No model produced these answers. The entire test was not run. A correct longer answer containing `full text` could also satisfy the regex; we therefore do not claim every compliant answer fails or that upstream CI is red. The bounded result is that this predicate is not a reliable discriminator between the two transfer forms.

Keeping a description test is not inherently wrong. Its scope is recall, and the file says so. The issue here is alignment of one assertion with the behavior being described. References to separate drill scenarios are leads for U06, not observed behavioral results or proof that all evaluation shares this problem.

## 9. F27 — Specialized and generic instructions have unresolved composition seams

S40's generic review example suggests HEAD~1 (or origin/main) as BASE, while S30 explicitly forbids HEAD~1 for multi-commit tasks. Use the SDD-specific recorded range to interpret that workflow; the generic example is not a universally sufficient task-boundary rule.

The task-reviewer template says the human decides when the plan mandates a defect, while S30 instructs the controller to rule on plan conflicts. S40 also says not to proceed with unfixed Important findings, whereas SDD describes cap-based parked completion. The latter can be an intended specialized exception, but a shared precedence/authority resolver is not supplied by these files. This round records the seams without inventing a universal resolution or treating them as authority for this research assistant.

S30 asks the final reviewer to consume a prepared package and ledger pointers, but the generic final-review template exposes only description, requirements and Git endpoints and shows direct diff commands. The controller must compose the specialized extra inputs; the generic template does not automatically transport them.

These observations strengthen the need to study composition and consumers. File-local rules can look coherent while still leaving consequential work at their junctions. Actual model interpretation, resulting errors and comparative reliability remain untested.

## 10. Experiment scope and method reflection

E07 runner: [U03-review-probes.py](../evidence/U03-review-probes.py). E08 actual output: [U03-review-probes-results.json](../evidence/U03-review-probes-results.json).

The exact 1,469-byte S34 blob was verified before execution. Linux, Python 3.13.5, Git 2.47.3, Bash 5.2.37; isolated HOME/Git configuration, no remotes or credentials; temporary repositories were automatically removed. Explicit OUTFILE avoids default-workspace behavior already examined in U02. The predicate experiment executes literal grep, not the full S42/S43 files.

Nine cases: four positive helper checks, two descriptive range/working-state observations, one narrow file-coverage negative control, and two failed verbal-oracle alignment checks. Seven matched their stated observation criteria; two oracle-health criteria failed. A descriptive PASS is not acceptance of a task, proof of code quality or universal oracle qualification. No independent reviewer, actual multi-agent retry, paid call or upstream-suite execution occurred.

This unit follows evidence production through its consumer and decision. It neither treats more review seats as inherently better nor treats cost caps as correctness guarantees. Existing source/helper limits were retained. METHOD v0.1 is unchanged; PLAN v0.4 records the evidence-led refinement and an additive source-ledger volume rather than rewriting prior source identities.

## 11. Residuals and next authorised research

Q04 now has a bounded role/packet/acceptance answer. Q15 gains concrete reviewer-global, report and unresolved-coverage consumers, but actual transfer fidelity remains untested. Q17 gains exact-range/working-state evidence. Q13/Q14/Q16 retain authority/revision/durable-retention limits.

New questions:

- Q18: what binds a reported test run, its environment and reviewed code revision when the working copy or plan changes?
- Q19: what discharges deferred or parked findings before final delivery, and which surviving record carries unresolved risks?
- Q20: how are specialized SDD rulings and generic human-decision/review rules composed in actual invocation?
- Q21: do other recall/evaluation predicates track current procedural contracts, and what independent behavioral evidence do the drill scenarios supply?
- Q22: how are cross-task/global constraints restored in scoped re-review when the re-review template has no separate global-constraints placeholder?

**Next: U04 — evidence, testing and correction.** Fully read test-driven-development and its actual test guidance, systematic-debugging and relevant supporting techniques, receiving-code-review and verification-before-completion. Trace expected behavior → test/oracle → observed result → reported evidence → correction/verification claim. Reuse this round's review topology instead of redoing it. U05 owns final delivery/retention; U06 owns broader skill evaluation. Source-based investigation remains authorised; installation, upstream reporting and architecture adoption do not follow automatically.
