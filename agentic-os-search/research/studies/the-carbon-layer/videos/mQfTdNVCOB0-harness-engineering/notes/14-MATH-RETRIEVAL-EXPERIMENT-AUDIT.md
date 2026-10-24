# U03-B / Note14 — Math retrieval: policy, transfer and evaluation identity

**Date:** 2026-09-16. **Standing:** bounded documentary/primary-source audit and descriptive arithmetic, not a reproduced experiment or an adoption decision. This is the math family within U03; coding remains U03-C. [SOURCES](../evidence/2026-09-16-u03b-math/SOURCES.md) defines P01/P02, B01, D01/D02, R01 and K01–K04. [REVIEW](../evidence/2026-09-16-u03b-math/REVIEW-AND-LIMITS.md) records the same-researcher checks and residuals.

## 1. What the experiment is trying to improve

The paper asks whether useful solved examples can be selected for difficult math problems by an automatically discovered retrieval program. The model solving the problem stays fixed during search; the outer proposer changes the procedure that supplies its examples. This is neither weight training nor four mathematician agents solving in parallel. The chosen procedure can be reused with other solver models. [P01 §§3, 4.2, B.2]

The reported search uses Claude Code/Opus-4.6 as the general proposer, GPT-OSS-20B as the math search solver, 40 iterations and 109 candidate retrieval programs. Section 4.2 describes 250 search problems from OlympiadBench and hard Omni-MATH and selects one program using search performance. Appendix D separately names 88 math problems as a practical search size. No historical configuration/lineage was recovered that explains whether these describe different stages, runs or a reporting error. Preserve both; do not silently replace either. [P01]

The final evaluation uses 200 other problems, with three responses per problem. Section 4.2 explicitly evaluates the search solver plus four models not used for search. The abstract, caption, summary box and project page instead describe five held-out models. The defensible operational description is **five evaluated models, four explicitly not used during harness search**. This narrows the claim without resolving the inconsistent wording or alleging misconduct. Unseen by harness search does not establish unseen during a model's training. [P01; P02]

## 2. What the selected program actually does, according to the paper

A lexical router chooses exactly one route using keywords and geometry-related regular expressions. All routes use the BM25 lexical stack, including mathematical tokenization that retains LaTeX units. The author describes the selected program as a merge of two search lineages, not a manually assembled post-hoc design. That lineage is reported, not independently reconstructed here. [P01 B.2, Figure 8]

| Route | Reported operation | Intended benefit and remaining test |
|---|---|---|
| Combinatorics | Retrieve 20 candidates, deduplicate to 8, rerank using lexical score and difficulty, keep 3 | Combine relevance with diversity; whether the selected diversity preserves the useful proof pattern needs retrieved-instance evidence. |
| Geometry | One hard NuminaMath reference plus two raw BM25 neighbors; no reranking | Retain structural matches. Figure 8 says fixed reference; C.2 describes a hard-reference index. The exact selection function is not recovered. |
| Number theory | Retrieve 12, rerank using lexical score/difficulty and an early-technique bonus, keep 3 | Prefer examples that expose a useful method; an early technique phrase remains a proxy, not proof of applicable reasoning. |
| Default algebra/other | Retrieve 10, rerank and adapt the number of examples to score concentration | Avoid one fixed example count for all problems. Exact thresholds, fallback behavior and selected counts are not recoverable from the diagram alone. |

The positive mechanism is **query-conditioned example selection and presentation**, rather than simply connecting a bigger store or adding another critic. It is a pre-solve selection program; it should not be conflated with an agent that chooses to search repeatedly during reasoning. The routing categories belong to this math artifact, not the Foundation hierarchy or a general SOUL taxonomy.

**Analytical positive case:** a problem requires a combinatorial proof pattern. Diverse relevant worked examples may help more than several near-identical lexical neighbors. **Analytical adverse case:** equivalent mathematical structure is expressed using unfamiliar vocabulary, so a lexical gate chooses another route; alternatively, truncation removes the decisive condition in a retrieved proof. Both are mechanism questions, not observed failures of this unavailable program. Exact prompts, retrieved records and downstream outputs would discriminate them. Merely counting returned examples would not.

## 3. Corpus size, eligible examples and solution quality are different properties

Table 10 lists 535,356 problem records across eight sources. Its row counts add correctly. The paper reports source filtering, one solution per problem, benchmark-family exclusions for OpenMathReasoning, and subsequent decontamination against both search and evaluation problems using exact prefixes and fuzzy Jaccard similarity at 0.8. It also reports manual inspection of top BM25 retrievals for held-out examples. These are positive safeguards in the stated protocol; they were not rerun here. [P01 §4.2, C.2, Table 10]

The source-to-prompt path applies further restrictions: some solutions are first truncated to 5,000 characters; runtime eligibility requires non-empty solutions shorter than 4,000; prompt insertion truncates to 3,000. Geometry additionally uses hard NuminaMath references. Thus 535K is neither the final prompt size nor a verified count of examples eligible on every route. Actual post-filter counts, exceptions and ordering require the exact historical transformation. A character limit does not establish retention of the proof's essential step. [P01 C.2]

Two native dataset cards clarify what a record can mean:

- **OpenMathReasoning:** its card distinguishes generated solutions, generation model, expected answer and question type. The documented `pass_rate_72b_tir` is a problem-level success rate across 32 generations, available only for answer-extracted questions; it is not itself a solution-specific certificate of proof validity. The paper's statement about selecting the highest-verifier-pass-rate solution therefore still needs its own preprocessing/verifier identity. It could use additional measurements; the card alone neither verifies nor disproves that operation. [D01]
- **NuminaMath-1.5:** `problem_type` names a mathematical domain, while `question_type` distinguishes proof, multiple-choice and word-problem forms. The `answer` field can contain sentinel values such as proof or notfound. These fields should not be treated as interchangeable evidence of a solved and verified example. The inspected card does not establish where the paper's difficulty-greater-than-six attribute came from. It may be derived or imported; its provenance is unresolved here. [D02]

Decontamination and mathematical independence also differ. The original IMO-Bench paper deliberately changes wording, symbols and sometimes formulations to reduce memorization. A string filter can remove matching representations without certifying the absence of equivalent or derivative problems. This is a limit on the warranted absence claim, not a demonstrated leak. Excluding source families within one input dataset also does not imply those families were prohibited in every other corpus source; Table 10 explicitly contains AIME and Putnam material. [P01 C.2; B01 §2.2]

Three different exposures remain separate: candidate-search exposure, retrieval-corpus overlap, and model-training exposure. Passing a check for one does not close the other two.

## 4. Recompute the result with the right comparator and model set

Table 6 reports averages of 34.1 without retrieval, 37.5 with BM25, 38.1 with dense retrieval at k=5, and 38.8 for the selected program. The following uses **displayed, rounded per-model cells**, not hidden raw outcomes. The local [data](../evidence/2026-09-16-u03b-math/REPORTED-DATA.json), [script](../evidence/2026-09-16-u03b-math/audit_reported_numbers.py) and [output](../evidence/2026-09-16-u03b-math/ARITHMETIC.json) preserve the calculation. [P01 Table 6]

| Meta-Harness minus comparator | All five evaluated models | Four not used in search | Search solver alone |
|---|---:|---:|---:|
| No retrieval | +4.660 pp | +5.075 pp | +3.0 pp |
| BM25 | +1.240 pp | +1.125 pp | +1.7 pp |
| Dense retrieval, k=5 | +0.700 pp | −0.100 pp | +3.9 pp |

The difference between +1.240 from rounded cells and +1.3 from separately rounded published means is retained as rounding/accounting, not alleged experimental inconsistency.

**Positive evidence:** the selected program improves on no retrieval for every evaluated model, including the four not used for search. It beats the BM25 baseline on four of five model cells. This supports studying reusable retrieval policy rather than dismissing the result because reporting details are incomplete.

**Important limit:** it trails dense k=5 on two models and BM25 on one. On the four-model transfer subset, it is essentially tied with dense k=5 by the displayed means (−0.10 pp). The all-model +0.70 includes a +3.9 advantage on the search solver. That arithmetic does not prove overfitting, statistically significant inferiority on new models, or superior dense retrieval in general. It shows why an all-model mean cannot stand in for the exact transfer comparison. The paper's qualitative transfer result against no retrieval survives this distinction.

The subject router, model choice and comparator choice answer different questions. The reported experiment is not a current model ranking. Model-cell wins are not problem-level wins. No new confidence interval, p-value or independent-search repeatability estimate was manufactured from rounded aggregates.

Nor is avoiding a dense encoder a measured total-cost victory. Index building, proposer search, repeated evaluations, judge calls, per-query retrieval, prompt length and solver generation incur different costs. Baseline example counts, equivalent eligible corpora, prompt formatting, token/latency budgets and actual provider configurations are needed for a fair cost comparison. The math table does not supply that complete accounting.

## 5. What does the combined math score measure?

The 200 problems comprise 100 IMO-AnswerBench, 60 IMO-ProofBench, 17 ArXivMath December 2025 and 23 ArXivMath January 2026 instances. Those are task counts, not evidence that all problem types use an identical oracle or scale. C.3 explains that answer-style, proof and research-style problems are pooled; its table supplies counts, not per-benchmark Base/Meta-Harness scores. The section even contains prospective wording about including such results. That wording is not an instruction to this researcher to invent them. [P01 C.3, Table 11]

The cited **IMO-Bench primary paper** makes the distinction concrete. AnswerAutoGrader checks final-answer equivalence. ProofBench instead grades rigorous reasoning and supports partial credit on 0–7 points; its principal proof results use human experts. Its published proof percentages are proportions of attainable points, whereas its answer table averages repeated answer-accuracy runs, mostly eight rather than three. Its automatic proof grader is separately evaluated and qualified. [B01 §§2.3, 3, 5.1–5.3; Tables 3, 4, 6]

Consequently, citing the benchmark's standard protocol does not recover the exact Meta-Harness conversion to a common pass@1: which proof grader, prompt, reference/rubric, normalization or pass threshold, how failed generations count, and how the ArXivMath portion is graded. The original benchmark supports a useful evaluation design; it does not establish that the later experiment used its exact implementation. This is a missing correspondence, not proof that the reported aggregate is wrong.

Similarly, three responses per problem are not best-of-three selection, majority vote, pass@3 or three independent problems. Under a binary, equal-task-weight interpretation, pass@1 can be estimated by averaging each problem's three correctness outcomes and then the problems; a pooled fractional-proof score would be a different quantity. The historical scorer is needed to decide which calculation actually occurred. Samples on the same problem also share difficulty and content, so 200 × 3 cannot simply be treated as 600 independent new tasks for statistical inference.

Without a per-benchmark breakdown and paired outputs, overall gain cannot be assigned specifically to proof construction, research-level tasks, a particular subject route or the effect of one retrieved technique. It remains aggregate evidence for the defined mixed evaluation.

## 6. A useful rival: conditional retrieval is not one universal mechanism

We reopened the paper's cited *Adaptive Retrieval helps Reasoning in LLMs – but mostly if it’s not used*. Its Llama-3.1-8B setup studies GSM8K/MATH-500, dense retrieval from MathPile/OpenMathInstruct-2, and a model that may call search during reasoning. It is materially different from Meta-Harness's lexical pre-solve program and harder mixed benchmark. It is a source for an alternative, not an equal-budget head-to-head comparator. [R01 abstract, §§2–4]

That study reports both harmful static-context effects and successful adaptive behavior, including high performance where the model chooses not to retrieve. Its nonretrieving subset is selected by the model, with problem difficulty related to retrieval frequency. Our inference is that the subset comparison alone cannot prove that suppressing retrieval causes better performance; changed prompting, extra reasoning and task selection remain alternatives. We do not import the source's metacognitive explanation as established causality.

The two sources therefore do not force a retrieval-always versus retrieval-never conclusion. They motivate distinguishing what examples to select, when to seek them, whether to use them, and what evidence establishes their contribution. Query-conditioned routing and optional mid-reasoning search are alternative mechanisms whose utility depends on the work.

## 7. Recovery boundary, contribution and continuation

The framework's current main still equals the existing pin `0cbc31e97c9e6d24232d1dc754827c02e1ec415c`. Its README and inspected root/reference/experimental entry trees expose classification, TerminalBench and Harbor routes. They did not yield the exact math candidate, corpus builder, historical scorer or run receipts. This is a bounded search in the named entry locations, not proof that no math artifact exists in any branch, archive or author resource. The cleaned-up reference release and the separate coding artifact do not reconstruct math by analogy. [K01–K04]

This unit advances the original questions by separating task holdout from model transfer, explicitly recomputing the four-model comparison, tracing corpus-to-eligible-context restrictions, reopening native dataset metadata and proof-scoring contracts, and retaining the useful four-route mechanism with its alternatives. It neither repeats the prior classification critique as a new finding nor starts a new broad benchmark study.

**Candidate SOUL/Development OS reuse:** a research library may support selecting applicable methods and worked examples, but its total size is not its usable context and similarity is not applicability. A reusable mechanism should be evaluated for the actual consumer, its work mix, criterion and resources. This is a bounded research-use hypothesis, not U06's current-project assessment or an adopted retrieval architecture.

**U03-B closes at documentary/arithmetic depth.** Exact historical efficacy, causal component contributions, cost, source/score identities, contamination sensitivity and statistical uncertainty remain open. No upstream code, provider, benchmark, retriever, model or proof grader was executed. No earlier validation debt is closed. **Next: U03-C, coding experiments and historical comparisons**, then the unchanged later synthesis/probe/project/closure stages under their existing authority boundaries.
