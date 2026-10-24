# U03-B — Review, alternatives and completion boundary

**Date:** 2026-09-16. **Method:** same-researcher source/figure comparison and reproducible descriptive arithmetic. This is not independent experimental verification. The bounded question is whether the reported math experiment, its retrieval policy and its comparators support the claimed improvement and transfer.

## Coverage and outcome

| Required question | Evidence and result | Open boundary |
|---|---|---|
| What was searched and selected? | P01 §4.2/B.2; 250-problem description, 40 iterations, 109 candidates, search solver and four-route selected program recovered | Exact program, lineage, configuration and 250-versus-88 correspondence unrecovered |
| Which transfer is measured? | Five evaluated models separated from four not used for search; 200 final problems distinguished from search problems | Wording conflict remains; no training-contamination certificate or historical access-log audit |
| What does the corpus provide? | P01 C.2/Tables 10–11 and native D01/D02 fields; total records separated from eligible/included examples | Exact processing, verifier/difficulty provenance, eligible counts and contamination sensitivity not validated |
| Which comparator supports the gain? | Table 6 transcribed and calculated for all models, four transfer models and search solver | Rounded aggregate evidence, no paired problem outcomes or significance estimate |
| What is counted as success? | B01 answer/proof scoring and P01 C.3 inspected | Exact historical grader, proof normalization/pass threshold, ArXivMath scorer and failed-output treatment unrecovered |
| Is retrieval one universal mechanism? | P01 pre-solve lexical routing compared conceptually with R01 optional mid-reasoning search | Different models/tasks/resources; no direct performance ranking or causal retrieval-abstention proof |
| Can the published run be reconstructed? | K01–K04 named entry routes checked; framework pin unchanged | Math artifacts not recovered there; no exhaustive absence claim |

## Positive evidence retained

The displayed results improve on no retrieval for all five model cells. The four models not used for harness search also improve against that baseline. The selected procedure is a concrete, reusable, query-conditioned program in the paper's description, not just a recommendation to provide more context. The reported filters, held-out tasks and alternative retrievers are useful experimental safeguards and comparators.

Those positives remain useful even though a stronger claim is not established. The task is not to reject the method for every unresolved historical field, nor to accept it because the user values the source.

## Material alternatives and reverse checks

**Comparator sensitivity:** the large gain is versus no retrieval. Against dense k=5, the displayed all-model mean improves by 0.70 percentage points, but the four-model transfer mean differs by −0.10. We retained both the positive no-retrieval transfer and near-tied dense comparison. Neither rounded difference establishes significance, inferiority or overfitting.

**Same name, different oracle:** citing IMO-ProofBench does not automatically specify how partial proof credit became P01's pass@1. Conversely, a documentation gap does not prove a wrong scorer. Reconstruct the actual scorer/prompt/reference/normalization before interpreting a proof-specific gain or pooling populations.

**Corpus relevance versus warrant:** generated solutions, problem-level pass rates and difficulty fields can supply useful selection signals. They are not automatically independent verification of each selected solution. P01 may have additional preprocessing measurements; that possibility remains open rather than being silently assumed or rejected.

**Text matching versus mathematical novelty:** exact/fuzzy filters and manual top-hit checks reduce specific overlap risks. Equivalent reformulations and base-model training exposure require different checks. No leak is demonstrated here.

**Mechanism versus causal contribution:** routing, difficulty, deduplication, formatting, amount of context and proposer search are bundled in the selected program. Aggregate comparison cannot assign the gain to one component. Single-route or simpler retrieval and optional abstention remain alternatives; R01's self-selected nonretrieving subset does not causally isolate retrieval removal.

**Recovery limits versus absence:** code inspection stopped at explicit README/root/reference/experimental entry routes. Their failure to expose the historical math program is not proof that it cannot be recovered elsewhere. Modern classification or coding defaults were not substituted for the missing math experiment.

## Arithmetic checks actually performed

The executed standard-library script and its input/output are included. Checks cover shape, finite percentages, the one-search/four-transfer grouping and population totals. Three known numeric expectations check the +4.66 all-model no-retrieval difference, the −0.10 dense transfer difference and the +3.9 dense difference on the search solver. Population sums are checked separately by input validation. Three malformed inputs were rejected as expected. These checks concern this small descriptive calculation; they are not six agent tests or six independent confirmations of the paper.

Manual transcription and its visual review share the same researcher. Script self-checks do not independently validate transcription, experimental results or the source's treatment of missing outputs. Every arithmetic claim remains conditional on the displayed cells and declared grouping. Task-count shares are not established score weights. No raw confidence interval or paired significance test was invented.

## Closure and retained debt

U03-B meets the planned documentary exit: native protocol and mechanism recovered at stated depth; legitimate comparisons recomputed; source/metric/exposure ambiguities explicit; positive evidence and material alternatives retained; exact source routes and next work recoverable. It is not a closure of U03, the video/paper campaign or independent efficacy.

Remaining high-value evidence: selected program and baseline adapters; corpus snapshots and all filtering/quality steps; task IDs and candidate exposure; exact graders and sample aggregation; per-benchmark/paired results; independent search repeats; resource accounting and controlled component comparisons. These are requirements for stronger claims, not an automatic mandate to run costly experiments or block all later source study.

Original media fidelity, U01 unrun checks and bounded diagnostics, U03-A historical/comparator limits, full U04 synthesis, U06 project-facing assessment and U07 closure remain untouched. No application, model, retriever or grader was run. Next: **U03-C coding experiment and historical-comparison audit**. The user asked to preserve the plan; no second-video or architecture transition is made.
