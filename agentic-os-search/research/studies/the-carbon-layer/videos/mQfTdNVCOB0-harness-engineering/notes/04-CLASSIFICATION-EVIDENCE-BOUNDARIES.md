# U01-A / Note04 — What a candidate score does and does not qualify

**Date:** 2026-09-12. **Standing:** source observations and explicitly bounded inferences. No upstream code, provider-free test, live model, sandbox attack or benchmark was run. [Note03](03-CLASSIFICATION-CANDIDATE-LIFECYCLE.md) explains the normal lifecycle; [SOURCES](../evidence/2026-09-12-u01a-classification/SOURCES.md) binds the observations to the pinned release. [CHECKS-NOT-RUN](../evidence/2026-09-12-u01a-classification/CHECKS-NOT-RUN.md) preserves validation debt.

## F01 — Producer/evaluator roles are not a protected authority boundary

**Observed:** The proposer is told not to benchmark, while the outer process launches evaluation. Yet its wrapper command disables interactive permission checks and supplies generic Bash/Read/Write/Edit capabilities in the project working directory. Candidate modules are imported by Python and run inside an evaluator worker. The worker loads all three data splits. Neither the wrapper nor the inspected classification admission path establishes a path-scoped read-only evaluator/data boundary. [S04, S07–S09, S12]

**Interpretation:** The supplied example is a cooperative research arrangement, not demonstrated adversarial isolation. A task prompt can define who should do an operation without mechanically preventing another actor from doing it. The README explicitly warns that public test data is not access-controlled. [S02]

**Limit:** The host could impose additional controls not represented in these files. We did not inspect a deployed host or observe tampering. Do not report a successful exploit, universal insecurity of all Meta-Harness deployments, or evidence that the paper's measured scores were manipulated.

**Reuse pressure:** SOUL/DevOS must distinguish assigned responsibility from actual effect/read capability when a change generator can interact with the environment that evaluates it. This is a research implication, not a prescribed sandbox design.

## F02 — Named results are not bound to immutable candidate/dependency identity

**Observed:** `build_val_runs` and `build_test_runs` reuse an existing result when `_has_usable_result` finds a dictionary with numeric accuracy. The address is based on dataset, candidate name, short model name and seed. There is no comparison to the candidate's current bytes, saved-memory identity, dataset bytes, evaluation code, mode, temperature or dependency versions in that reuse decision. Result metadata exists, but it is not checked against current inputs there. [S05, S07]

Candidate source lives in a shared `agents/` directory, even across named runs. `fresh_start` removes non-baseline Python files from that shared directory while clearing selected current-run logs. Finalization records system names, not frozen candidate code and dependency closure. The proposal's base-system/file fields do not become an immutable lineage manifest in the summary. [S04]

**Conditional counterexample, not executed:** Evaluate name A, replace the code under A, then request the same run/group while the old numeric result remains. The inspected reuse predicate does not notice that the code changed. Unique names and disciplined file handling can avoid this path; their use in every historical run has not been demonstrated.

**Important counterweight:** The LLM response cache does use a content-sensitive SHA-256 key over prompt/model/endpoint/arguments. That cache answers a different question and does not supply the missing candidate-to-evaluation binding. Do not summarize this finding as 'the system never hashes anything'. [S18]

**Reuse pressure:** Evaluation reuse is a conditional claim about the same relevant object and conditions, not merely about a file that still has a score. A hash alone would also be insufficient unless the correct dependency set and current target were bound.

## F03 — Complete seeds can coexist with incomplete and incomparable task coverage

**Observed:** `load_results` discards groups missing a configured seed. But `print_frontier` aggregates each candidate over the dataset groups that are present; the outer loop computes candidate scores similarly. `print_results`, in contrast, divides its displayed average by the configured dataset count and shows absent cells as missing. A benchmark worker failure is logged by the outer loop without excluding that candidate from later frontier computation. [S04–S05]

**Analytical illustration derived from these formulas, not a run:** With three configured datasets, a candidate having only one completed 90% group can receive 90% in the aggregate frontier while its displayed table average is 30%. A baseline scoring 80% on all three has 80% under both formulas. With equal context cost, the incomplete candidate can dominate the baseline in the aggregate frontier. Completing the two absent groups with low scores could reverse that ordering.

This illustration does not establish how often such a path occurred or what historical scores would become. Nor does it endorse assigning zero to every missing result as the correct policy. The issue is that differently qualified measurements can be compared as though they covered the same evaluation population.

**Causal chain:** worker failure or missing group → partial result set → available-case denominator → apparent ranking. Fixing one failing worker can remove one instance; it does not by itself establish a coverage-aware selection rule.

**Reuse pressure:** A score needs its evaluated population, exclusions and failure state. Seed-completeness is a real safeguard but is not a substitute for candidate-level task completeness.

## F04 — Finalization success and held-out exposure are different state transitions

**Observed:** `finalize_run` writes in-progress before test work, attempts test evaluations, produces/displays test summaries and then checks completeness. A failure leaves in-progress. `run_evolve` blocks only complete runs. The first-party test `test_incomplete_finalization_allows_evolution` explicitly expects recovery into evolution and uses corrupt empty result objects. [S04, S11]

**Inference:** A mixed outcome can leave usable test evidence from successful groups while other groups fail. The same-run evolution guard still admits a new search. The empty/corrupt fixture in the inspected test does not discriminate between 'no useful test evidence released' and 'some useful held-out evidence released'. Availability is not proof that the proposer actually read it.

**Why this matters:** The paper's search/final-evaluation separation excludes proposer access to final-test results. A release-state transition based only on completion status cannot alone establish that property after partial finalization. [Paper §3]

**Counterweight:** Separate test invocation, the completed-run lock and required-group check are genuine mechanisms. This is not a claim that there is no finalization gate. It is a narrower question about when the evaluation evidence changes status and what recovery is then allowed.

**Reuse pressure:** Failure recovery can alter the epistemic status of evidence even when no intended production change has been accepted. An operationally retryable state need not be epistemically equivalent to the pre-test state.

## F05 — Rich data produced in a function is not necessarily durable diagnostic history

**Observed:** `evaluate_memory` constructs detailed prediction/target/prompt records. The main worker uses those arrays to compute aggregates, then `_build_output` writes aggregate metadata rather than the detailed arrays to `val.json` or `test.json`. The training logger and proposer wrapper retain different views: training steps/checkpoints and proposer interactions, respectively. In default offline training, batch/checkpoint logs do not automatically become per-example validation traces. [S07, S09–S10]

The wrapper's file-read/write counters track particular Read/Write/Edit events, not every file effect possible through Bash. Its raw tool-event records can still contain Bash output. Neither 'all I/O is measured' nor 'Bash leaves no trace' follows.

**Inference:** The generic promise of filesystem-accessible rich experience requires a source-specific write/read audit. The inspected classification path does not automatically persist every detailed validation diagnostic it computes. A proposer may recover some information from code, data, reports or its own probes; the resulting diagnostic coverage was not measured here.

**Reuse pressure:** Information formation, persistence, discoverability, selection and successful interpretation are different conditions. This is a concrete implementation case for the bridge hypothesis, not a new Foundation taxonomy or a finding that no useful history exists.

## F06 — Context and usage metrics expose different accounting surfaces

**Observed:** `MemorySystem.call_llm` records the last prompt for the current thread. `evaluate_memory` estimates added context using that last prompt's character length minus the input length. The LLM wrapper can subsequently truncate a long prompt and add a system prompt. Direct callable use can bypass the memory helper; the skill asks candidates not to do that, but the inspected interface check does not enforce it. [S06–S08, S18]

This metric is not a sum over every model call in a multi-call prediction, not a token count, and not necessarily the final wire-context size. It can be useful under its intended candidate convention, but its interpretation depends on that convention remaining valid throughout search.

Provider response-cache hits return before fresh token/cost counters are incremented, while the outer call count is still incremented. This is coherent as current cache-miss usage accounting; it is not automatically the cold-run cost of the candidate. Proposer cost, search evaluation cost, runtime context and useful work are separate quantities. [S18]

**Reuse pressure:** Optimizing a proxy can change how accurately the proxy represents the desired property. Metric validity must be revisited when the candidate can change the measurement-relevant call structure.

## F07 — Released search prior and defaults must not be mistaken for the historical experiment

**Observed:** The reference README distinguishes the API-backed default from the paper's local-model setup. The configuration chooses offline training, while paper §4.1 describes online classification. The current skill mandates three candidates, prototyping and mechanism novelty, and discourages stopping. These are material search choices; the actual outer parser does not verify all of them. [S02, S08, S10; paper §4.1]

**Judgment:** The release supports implementation learning, not an automatic reconstruction of the historical experiment. The code's restrictions/defects cannot be projected backward as proof that reported paper results are false. Conversely, paper performance is not validation of every path in the released code. Historical run records, exact candidate versions and evaluator configurations remain needed.

Mandatory proposal generation is also not the same as accepting every proposal: frontier selection can retain older candidates. The value of richer history versus proposer priors, extra analysis budget or selection effects remains an open causal question.

## F08 — Derived improvement history can lose its comparison anchor

**Observed:** The main iteration captures a frontier before evaluating candidates. After evaluation it rewrites the frontier, then `update_evolution_summary` rereads that updated file to compute a candidate delta. The console comparison and persisted delta can therefore use different reference points. [S04]

**Analytical example, not run:** If the prior best is 60% and a new candidate becomes the 75% frontier leader, the console comparison can show +15 points while the subsequent summary compares 75 against 75 and stores zero. The score itself need not be wrong for the improvement narrative to be misleading.

**Reuse pressure:** A derivative history field requires an identified baseline/time, not just an accurate number. The interpretation of a learning trace can change even while its files remain readable and syntactically valid.

## What is now supported

The classification reference contains a real staged proposal/evaluation/selection mechanism, with useful dispatch, seed-completeness, explicit-finalization and multi-objective-selection features. It is not just a diagram or collection of instructions. At the same time, cooperative role boundaries, name-based result reuse, coverage-sensitive aggregation, partial-test recovery and diagnostic/metric representation limits constrain the conclusions available from its outputs.

The strongest study-level implication is conditional: **an improvement loop needs qualified feedback, not merely more feedback.** Candidate identity, scope, exposure, comparator and measurement semantics can each change what a score warrants. This is a research synthesis from the inspected paths, not a newly adopted SOUL architecture.

## Bounds and continuation

All above findings are source-level, with explicitly marked analytical examples. There was no runtime reproduction, adversarial exploitation, independent reviewer/model, end-to-end paper replication or live quality/cost measurement. Test-source review is not a passing test run. No Foundation, DevOS, agent-control or upstream code was changed.

U01-B should now test whether the TerminalBench optimizer and selected artifact implement materially different identity, execution, evaluation and history boundaries. Do not propagate classification findings to it merely because both directories use Meta-Harness terminology or the same wrapper blob. U03/U05 retain the named empirical validation debts.
