# U00 / Note02 — initial evidence and validity audit

**Date:** 2026-09-12. **Status:** source-level audit, not a reproduction. All paper statements refer to P01 v1; source IDs resolve in [SOURCE-LEDGER](../SOURCE-LEDGER.md). Positive evidence and limitations are kept together.

## A01 — End-to-end optimisation is not unconstrained authority

**Observation:** P01 searches executable harness code around a fixed model and a task interface; Appendix D recommends evaluation outside the proposer. C01 distinguishes the reusable framework from its reference experiments and from C02, the selected coding artifact.

**Inference:** The phrase end-to-end does not establish permission to change every surrounding system, the objective, the evaluator, secrets or deployment policy. Separation in prose or process layout is not proof of tamper-resistant enforcement.

**Next evidence:** trace actual mutable paths, code admission, imports, evaluator credentials/process/filesystem and score attribution. A candidate that can manipulate its measurement can improve a score without improving the intended work. This is a threat to evaluate, not an observed exploit in the unread code. Q01–Q04.

## A02 — Rich history is not a giant mandatory prompt

**Observation:** P01 §§3 and A.1 describe selective filesystem inspection of prior code, scores and traces. Appendix A reports a median 82 file reads per iteration in one TerminalBench run. The much larger history/feedback quantities describe availability, not necessarily the amount consumed in one model context.

**Inference:** The potential contribution is recoverable diagnostic experience and selectable evidence, not the slogan that all accumulated sources should be loaded. File-read counts cannot by themselves show that the right evidence was understood or that it caused the improvement.

**Counter-test:** equal-budget summary/raw-history alternatives; misleading or irrelevant trace controls; retrieval omission; provenance and freshness loss. Q07/Q11.

## A03 — Experimental families must not share one generalisation label

**Observation:** Classification includes nine out-of-distribution datasets (§4.1/Table 5). Math uses a separate 200-problem evaluation and reports several models (§4.2/Table 6). Coding explicitly uses the same 89 TerminalBench tasks for search and final evaluation (§4.3, p9).

**Judgment:** The coding result is evidence for benchmark-specific discovery, not a held-out-task generalisation estimate. Manual/regex checks for task strings address a narrower concern than adaptive overfitting from repeated benchmark feedback. This limitation does not erase the other experiments or make the coding discovery useless.

**Next evidence:** exact search exposure, selection history, per-task paired trials, unseen tasks/environment variants and current evaluator provenance. No statistical significance or unseen-work guarantee is claimed here. Q08.

## A04 — The headline comparison is a bounded average, not universal dominance

**Author-reported results:** Table 2 classification average rises from ACE 40.9 to 48.6 (+7.7 percentage points), while additional context falls from 50.8K to 11.4K tokens. The selected policy regresses on USPTO relative to ACE (16.0 to 14.0). Table 6 math mean is 38.8 versus 34.1 without retrieval, but only 1.3 points above BM25 and 0.7 above dense retrieval with k=5; it is not best on every model. Table 7's reported coding comparisons are historical leaderboard figures, not our fresh controlled rerun.

**Judgment:** Report task/model-level tradeoffs and the relevant comparator. Do not translate an average into a guarantee for every work class or equate a reported benchmark ranking with current product capability.

**Next evidence:** uncertainty, sampling/selection, baseline budgets and per-task losses, especially where average gains hide regressions. Q08/Q09.

## A05 — The selected coding change is narrower than the title may suggest

**Observation:** P01 B.3 and C02 README describe environment bootstrapping before the first model call, added to an inherited Terminus-KIRA agent. The paper describes a timed, silent-failure fallback; C02 contains an agent and supporting files, but U00 did not read their implementations.

**Inference:** This is a promising Environment-to-context mechanism candidate, not evidence that the optimiser invented all tool calling, sandboxing, verification or orchestration. A harmless-looking additive snapshot can still impose latency, reveal inappropriate information or bias action; these are possible failure modes, not measured defects.

**Next evidence:** actual caller, command construction, output truncation, failure behaviour, config/model dependencies and downstream consumption. Then compare to appropriate no-bootstrap and task-conditioned-bootstrap alternatives. Q05/Q09.

## A06 — A plausible fix can be a regression

**Observation:** P01 Appendix A describes six early candidates that regress before an additive environment snapshot becomes the best candidate in that run. Several early proposals bundle control-flow and prompt changes. The paper includes proposer diagnoses and later attempts to separate those interventions.

**Judgment:** The history illustrates why plausible explanations require testing. It does not establish every quoted causal conclusion: reverting one intervention while others remain is not a complete factorial causal study. The proposer's wording that a fix is proven is a target claim, not this study's verdict.

**Bridge implication:** retain rejected proposals, intervention identity and negative results. Distinguish a monotone best-so-far selection curve from a monotone sequence of safe operating changes. Q07/Q10/Q12.

## A07 — Cost and unit fidelity are part of the result

**Observation:** The main classification table uses additional context tokens. Appendix B Table 9 and P02 use additional context characters. Their quantities differ in scale with declared units. The optimiser comparison plots evaluation counts; Appendix D recommends small inexpensive search sets.

**Judgment:** Do not call character quantities tokens. Less additional run-time context does not imply the same reduction in total search dollars, model output tokens, tool cost or latency. An evaluation-count advantage is not automatically an equal wall-clock speedup. A second short model call can have different latency/cost from one larger call.

**Next evidence:** actual token counting, proposer and evaluation accounting, cache assumptions, wall-clock and operational cost/quality frontier. Q09.

## A08 — Reporting ambiguities stay open rather than being silently repaired

Three source-level issues need reconciliation:

1. **Math model holdout:** §4.2 states selection using GPT-OSS-20B and evaluation on that model plus four models not seen during search; nearby captions/text use five held-out models. Safest current description: five evaluated models, with four explicitly described as unseen during search; exact protocol needs code/log recovery.
2. **Math search size:** §4.2 describes a 250-problem search set; Appendix D's practical guidance mentions 88 math problems. These may represent different runs/stages. Do not merge them or assert a fraud/error explanation without evidence.
3. **Search presentation:** the classification protocol describes 20 iterations with two proposals, whereas the project presentation includes a roughly 60-proposal description. Resolve dataset/run/version identity before comparing budgets. The paper's broader compression-method characterisations also require their original sources, not repetition as settled facts.

These are documentation/protocol questions, not findings that the reported performance has been disproved. Q04/Q07–Q09.

## A09 — Published code availability is not experiment reconstruction

**Observation:** C01 README labels the repository a cleaned-up version and says testing was limited to verifying it runs. Only two reference experiment families are advertised there. C02 is a separate selected coding agent; its README reports 89 tasks × 5 trials.

**Judgment:** We cannot yet infer that the exact historical search, all three paper domains, all model versions, evaluation settings or all scores can be reconstructed from these entry files. Conversely, absence from the root README is not proof that an artifact is unavailable elsewhere.

**Next evidence:** read actual trees, manifests, source, run records and test definitions. Record each missing correspondence precisely; do not substitute a new successful smoke run for historical reproduction. Q04.

## A10 — Verification and improvement require different judgments

**Observation:** V01/V02 separates checking a result from diagnosing its path, while grouping both under its tenth component. P01 evaluates candidate quality and selects harnesses. Neither source has yet been shown by this study to implement SOUL's future acceptance authority.

**Research hypothesis:** A useful bridge needs at least three distinguishable questions: did the intended effect occur; did the candidate improve the relevant work under fair conditions; and is this change acceptable under the actual authority/risk/cost constraints? A passing check can answer only part of that.

**Counterexample:** removing a needed review gate may reduce latency and preserve a narrow task score while making the system unacceptable. No such change was executed here. Q10/Q13.

## Initial conclusion and boundary

The sources justify deeper research into operational composition and evidence-driven harness change. They do not yet justify adopting Meta-Harness, a ten-component stack, autonomous evaluator modification, or a SOUL architecture. The most consequential immediate uncertainty is the code-level candidate/evaluator/selection boundary, so U01 is directed there.

No upstream code or benchmark was executed; no independent replication, causal proof, production safety validation or completed cross-study synthesis is claimed.
