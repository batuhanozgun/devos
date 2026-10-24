# U06-B1 — Conversation Evidence and Verdict Composition

Date: 2026-09-17. **BOUNDED SOURCE INVESTIGATION COMPLETE; U06-B and the whole study remain OPEN.**

Primary corpus: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0). Evaluation dependency: `prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b`. Neither was repinned. Source IDs resolve through [SOURCE-LEDGER-U06B1.md](../SOURCE-LEDGER-U06B1.md). METHOD remains v0.1.

## 1. Bounded question and evidence class

How does one conversation-mode evaluation turn a task, captured work and assessor output into pass, fail or indeterminate? What has to remain distinct along that path?

The representative case is `conversation-code-review`, specifically the Claude stock/treatment pair in `conversation_routine_use`. We read its story, setup entry, checks, exact oracle, check manifest and paired arm definitions; the relevant planted-code fixture; the conversation orchestrator, input projection, evidence-copy routine, check runner, check-manifest comparator, verdict composer and role-process wrapper. Selected outer-runner ranges connect preparation to the conversation path and publication. The full external README was completed, with contributor/safety/package orientation recovered.

This is SOURCE ANALYSIS. No scenario, model, agent, upstream test suite, fixture or oracle was executed. No new E-series experiment or success rate was produced. No credentials, private run records or raw sensitive transcripts were opened. A failed public-source acquisition attempt at container DNS did not block connected GitHub reads. Existing E01–E12 were not rerun.

The outer runner and fixture library were selectively read, not fully audited. Gauntlet's own implementation, actual assessed runs, all capture normalizers, campaign registration/materialization and release enforcement remain outside this bounded result. The lower-level process wrapper is Quorum code; reading it is not reading Gauntlet.

## 2. F50 — A concrete comparison targets our exact primary revision

**OBSERVATION — D10/D15/D16/D17.** The suite names stock/treatment comparisons and two repetitions per scenario per pair. The inspected Claude treatment arm declares `superpowers: b36e0829c6d0140e93cfef2ca599b1b07d4a7797`; its stock arm declares `superpowers: none`. Both declare the same agent, `opus5_bedrock` credential selector and high effort. Thus we now have a concrete configuration correspondence to the primary study pin, not merely an unrelated newer evaluator README.

That closes only part of Q33. A declared SHA is not proof that a particular run materialized, loaded and used those bytes. The credential selector is configuration, not a newly verified provider/model-availability claim. No result or effect size from this suite was imported.

The shared Superpowers helper distinguishes three states: explicit root, explicit none and unspecified legacy/ambient behavior. None suppresses staging/flags and removes the root variable from projected setup/check environments; unspecified can read the ambient root. The outer runner rejects an explicit mode combined with an overriding revision stamp and rejects unsupported OS combinations. This makes the no-treatment intention concrete: simply omitting an environment variable is not the defined stock treatment.

**LIMIT.** Actual arm resolution, immutable checkout creation, adapter provisioning and realized subject identity still require their own code/run evidence. We do not conclude experimental equivalence from matching YAML alone.

## 3. F51 — This case evaluates delivered review quality, not compulsory skill obedience

**OBSERVATION — D11–D14/D21/D25.** The subject receives a review-only request for the latest commit. The fixture function writes two commits: the earlier parameterized lookup and a changed file with string-concatenated SQL, an identity password-hash function and credential logging. Its setup is source construction, not a working deployed authentication service observed by us.

Private criteria require the delivered review to identify the query defect and at least one credential defect, explain serious consequences, withhold merge approval and ground all material findings in supplied evidence. Equivalent severity language is accepted. Undisclosed subagent analysis earns no credit. Conditional risks and requests to verify missing context can be appropriate; unsupported claims about drivers, stored data, callers, deployment or execution can fail the grounding obligation even alongside correct findings.

Crucially, this story says that no particular skill, tool, subagent or runtime test is required. A bare refusal completes interaction but does not meet the review obligation. Therefore U06-A's concern about choice-based compliance tests must not become a blanket characterization of the lab. This selected case explicitly evaluates a useful delivered result and calibrated claims, without requiring Superpowers-specific process signals.

The deterministic oracle has a narrower job: hash `src/db.js` and compare it with a fixed SHA-256 before and after the conversation. It explicitly disclaims evaluating findings. It does not inspect the delivered review or prove the whole workspace/branch remained unchanged. Source preservation and review correctness are complementary, non-equivalent checks.

## 4. F52 — Conversation and assessment are separate role invocations with different inputs

**OBSERVATION — D19/D20/D24/D27.** `projectConversationStory` separates prose before `## Acceptance Criteria` from the private rubric. Empty brief/criteria and wrong mode are rejected. Assessment time allowances are removed from rubric frontmatter so changing those allowances does not itself change rubric text.

The orchestrator invokes Gauntlet twice: `converse` receives the user brief and subject launcher; later `assess` receives the rubric and an evidence root/index. Distinct role directories and lifecycle records are allocated. Both evaluator roles use the configured grader model. This is three logical roles—subject, user-like interlocutor, assessor—not proof of three independent models. Legacy stories without conversation mode have a different path; the README's generic two-LLM description is not a complete topology for every mode.

The Quorum-side projection reduces direct criteria leakage into the user-like brief. It does not prove that the actual interlocutor never cues an answer, that the assessor is epistemically independent, or that a broad-permission subject cannot reach other files. Claims about Gauntlet's actual tool restrictions and fresh-history implementation remain a transitive dependency question.

## 5. F53 — Visible completion, capture, retained output and grade are separate states

**OBSERVATION — D18/D19/D23/D24/D27.** A completed conversation record requires a delivery/refusal endpoint and visible evidence. The orchestrator validates a referenced ANSI capture and its rendered JSON companion, and checks that the stated quote occurs in the retained rendering. Existing valid conversation records are preserved; missing/invalid records can receive a bounded fallback. Later errors do not erase an already recorded endpoint.

The path then captures native logs and normalized trajectory, copies visible exchanges/captures, and snapshots workspace output. The evidence index enumerates retained files. Output capture excludes Git metadata and dependency trees; internal file symlinks are copied as file content, while escaping, excluded-tree and unsupported special-file cases are rejected. This is a selected view, not a byte-for-byte copy of everything the subject could have observed.

Post-checks run on `evidence/output`, not the original subject workdir, and their records are added to the evidence package before assessment. The selected review oracle is read-only. More generally the copier/check runner shown here does not establish an immutable pre-check snapshot against all possible checker mutations; broader preservation claims require following each checker and artifact sealing path.

A quote really existing in a capture does not prove it represents a semantically complete or correct answer. An index proves a selected path set, not that it contains every decision-critical fact. Conversely, explicit copied output, native logs and visible evidence are materially more than trusting a subject's success message. Both the mechanism and its scope belong in the model.

## 6. F54 — Check execution health is distinct from a failed assertion

**OBSERVATION — D22/D25/D26.** The check runner uses a restricted environment projection, its own temporary HOME/TMPDIR and structured per-check records. Ordinary assertion failure may continue so remaining checks can emit evidence. Non-executable/not-found/signal failures are treated as checker crashes, not ordinary negative results. This is environment hygiene and error accounting, not proof of a filesystem sandbox.

Expected-check manifests are compared as multisets: phase, check name, negation, arguments where exact, and multiplicity. Missing or unexpected records prevent a passing composition. The manifest is read once by the outer runner and reused, including on error paths, rather than reloaded after the observation.

Important qualifications:

- A missing manifest is explicitly supported as legacy null behavior; this guard is not universal in every direct run.
- Commands containing dollar signs are extracted with wildcard arguments. The selected case's pre/post `command-succeeds` entries use `args: null`. This confirms the expected kind/count of records, not exact expanded command identity by itself.
- The manifest is derived from the check script. Agreement checks execution completeness relative to that script, not independent validity of its requirements or oracle.
- The composer permits a passing assessor with no deterministic post-checks and explicitly reports that weaker coverage. Zero checks are not universally an error; they cannot support an invented independent-check claim.

These are source-defined scope choices, not observed false passes in a live run.

## 7. F55 — Verdict composition preserves indeterminacy instead of forcing every run into success/failure

**OBSERVATION — D09/D18/D19.** The composer retains Gauntlet and check records while applying precedence:

| Condition | Final disposition at this surface |
|---|---|
| Runner error or failed precondition | indeterminate |
| Missing assessor result, investigate or errored assessor status | indeterminate |
| Empty capture with transcript checks | indeterminate |
| Expected-check record mismatch | indeterminate |
| Passing assessor and no failing post-check | pass |
| Determinate assessor failure or failing post-check | fail |

The conversation orchestrator adds stronger admission conditions before this composer: completed visible endpoint, confirmed role exit/cleanup, available native capture, and assessor process/result consistency. It requires nonempty criterion/evidence entries and checks that aggregate assessor status agrees with criterion verdicts. Assessment accounting reconciliation can subsequently downgrade an otherwise usable verdict. Its imported accounting/completion validators were not fully investigated here.

A recorded endpoint can therefore coexist with an indeterminate final verdict. A failed subject result and a failed measuring process need not receive the same label. Raw negative check records remain present even when an instrument error takes priority in the final classification.

**LIMIT.** These guards validate consistency and availability, not the truth of each assessment. Quorum-side checks shown here do not independently judge all citations or demonstrate exact coverage of every rubric obligation. Gauntlet's producer contract and its retained outputs must be examined before claiming that layer is closed.

## 8. F56 — A checker error may still be assessed without qualifying the final result

**DIRECT CODE / DOCUMENT COMPARISON — D08/D19.** The scenario guide says missing required evidence, checker crashes and cancellation produce an indeterminate result without grading incomplete evidence. The code has important distinctions: missing capture and cancellation do return before assessment; a nonzero post-phase exit or expected-manifest mismatch is saved as `checkError`, but control can still invoke the assessor. That error is then passed to the composer, keeping the final verdict indeterminate.

This is a bounded discrepancy about whether assessment is attempted, not proof that broken checks become a pass. It can matter to cost, diagnosis and interpretation of assessor artifacts. No live wasted-call count or resulting grading error was measured. Do not flatten the discrepancy into either no protection or complete document/code agreement.

## 9. F57 — Configuration correspondence does not close versioned evaluator provenance

The suite uses grader selector `sonnet5`, whereas the README's routine-use paragraph names `sonnet5_bedrock`. The README also retains a parent-submodule-bump instruction, while the primary pin explicitly ignores a separately cloned evals directory and has no tracked evals gitlink. These are distinct document/configuration seams; no parent pointer should be invented and no newer description silently substituted for the primary snapshot.

The outer runner records subject/evaluator provenance and delegates checks to named modules, but full campaign source freezing, Gauntlet binary identity, adapter realization and final authenticated reports remain unexamined. The exact Claude treatment SHA is useful correspondence, not empirical proof that the primary product improves outcomes.

The source-guided next unit is therefore **U06-B2: evaluator producer and realized-run qualification**. Pin the actually relevant Gauntlet source before using it; follow assessment completion/accounting, rubric/citation completeness, capture normalization and one sanitized published result with exact subject/arm/runtime correspondence. Inspect campaign materialization and CI/release links only to the depth needed to establish applicability. Do not read secret-bearing records or launch live evaluations.

## 10. Method reflection and handoff

This round replaces README-level promises with a bounded code-level path. It also revises an overly broad possible inference from U06-A: the selected new conversation scenario does not demand a prescribed skill or arbitrary A/B/C compliance; it asks for useful, grounded review output. A broad lab verdict about effectiveness still requires executed evidence and evaluator qualification.

U06-B is divided into B1 (representative scenario, evidence routing and verdict composition) and B2 (transitive producer, realized-run applicability and remaining qualification). METHOD v0.1 and closure criteria do not change. No synthetic result was invented to make this a seventh experiment.

Q30 gains a concrete paired stock/treatment configuration; Q31 gains the scenario/oracle/assessor/composer path; Q32 gains explicit allowance for conditional reasoning and no mandated skill; Q33 gains exact declared subject-pin correspondence, not realized use. Q34 remains release/enforcement work. Earlier identity, retention and freshness questions remain preserved.

New residuals: Q35 — correspondence between indexed/checked evidence and the assessor's complete rubric/citation obligations; Q36 — attempted assessment versus final-grade eligibility after checker failure; Q37 — whether the declared stock/treatment and evaluator identities match actual frozen/materialized/loaded runtime inputs.

U01–U06-A, earlier source volumes and E01–E12 are unchanged. U07 runtime/support coverage and U08 native synthesis/project-facing projection remain open. No installation, upstream report, product adoption or Foundation/Development OS change follows from this source result.
