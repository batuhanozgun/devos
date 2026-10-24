# U03-A / Note13 — What the classification experiments establish

**Date:** 2026-09-15. **Standing:** bounded source and comparator audit, with descriptive arithmetic on published numbers; not historical reproduction, independent verification or adoption. This is the first experimental family within U03, not completion of all U03. [SOURCES](../evidence/2026-09-15-u03a-classification/SOURCES.md) identifies the exact papers, release and reading extent. [REVIEW](../evidence/2026-09-15-u03a-classification/REVIEW-AND-LIMITS.md) preserves rival explanations and remaining evidence.

## 1. Question and unit of analysis

The video proposes an evidence-driven improvement loop. Meta-Harness's classification experiment supplies one concrete test: can a coding-agent proposer discover a better context/memory procedure around a fixed classifier? The relevant object is not the whole SOUL system, all forms of learning or every current implementation of a named optimizer. [P01 §4.1]

Three claims must be evaluated separately:

1. **Selected-harness quality:** how the chosen procedure performs on the reported final test data.
2. **Search quality:** how candidate-generating interfaces compare under the reported search budget.
3. **Transfer and explanation:** whether the procedure helps on new datasets, and whether richer diagnostic access explains the advantage.

An observation supporting one claim does not automatically establish the others. A good selected output can coexist with uncertain optimizer repeatability. A search-set advantage is not a held-out-test estimate. More efficient evaluation use is not necessarily lower total cost.

This unit extends Note02's initial numerical cautions and Notes03–04's reference-code characterization. It does not present their older discoveries as new, rerun their unexecuted checks or project modern release behavior backward into the original experiment.

## 2. Recover the reported protocol before evaluating it

P01 describes GPT-OSS-120B as the fixed classifier and Claude Code with Opus-4.6 as the proposer. Classification-specific text reports 20 iterations with two candidates, producing 40 candidate harnesses. Human baselines seed the search; candidate selection uses search results, and the authors say test results are withheld from the proposer. The final frontier is evaluated on test data. [P01 §§3, 4.1]

This separation is a positive design feature of the stated protocol. It is an author-reported condition, not a fresh audit of historical access logs. The two uses of experience also differ: the inner classifier accumulates example-dependent memory, while the outer proposer changes the procedure that manages it. A frozen harness can still use labeled examples on a new task; that is not equivalent to zero-shot use without adaptation data.

| Protocol surface | Recovered condition | Remaining qualification |
|---|---|---|
| Solver and proposer | Fixed classifier; same Opus proposer configuration in the optimizer comparison | Historical request/configuration identities and full search accounting not recovered |
| Population | Three named datasets for search; nine additional datasets for transfer | Exact historical sample IDs, ordering, duplicate checks and per-example outputs not recovered |
| Search/test separation | Explicitly stated by the paper | No access-log or raw-run audit; release controls cannot certify the historical boundary |
| Budget | Equal full-harness evaluation counts claimed for optimizer comparison | Not automatically equal proposer tokens, tool work, latency or original algorithm rollout budgets |
| Candidate selection | Frontier/search-based selection | Candidate lineage and all final evaluation receipts not recovered |
| Measurement | Published aggregate accuracy/context tables | Metric, call-count and unit semantics require source-specific interpretation |

The word online needs care. P01 describes sequential labeled experience followed by held-out evaluation. MCE's native evaluation also has a distinct online mode in which test examples are attempted and then used for updating. The released Meta-Harness configuration discussed in U01-A defaults to offline training. These labels do not by themselves establish identical protocols. [P01 §4.1; M01 §4.1; Note03]

## 3. The positive result survives, but the comparator changes its meaning

The selected policy is **Label-Primed Query**, not the two-call Draft Verification variant. It combines label coverage with query-relevant and contrastive examples before prediction. This is a useful discovery: stronger performance need not come from adding another model-based critic. The paper contains a family of trade-offs, not one universally optimal mechanism. [P01 B.1, Table 9]

Table 2 reports a 48.6 mean for the selected policy, against 40.9 for ACE and 40.8 for Few-Shot (all). Our [arithmetic record](../evidence/2026-09-15-u03a-classification/ARITHMETIC.json) recomputes comparisons from manually transcribed, visually checked cells. These calculations are not a new run of the experiment.

| Comparison, Table 2 | Mean difference, using reported means | Dataset differences: USPTO / S2D / Law | Additional-context comparison |
|---|---:|---|---|
| Meta-Harness versus ACE | +7.7 percentage points | −2.0 / +9.0 / +16.0 | 50.8K versus 11.4K tokens: about 4.46× baseline/new, or 77.6% less |
| Meta-Harness versus Few-Shot (all) | +7.8 percentage points | −1.0 / +8.5 / +16.0 | 12.3K versus 11.4K tokens: about 7.3% less |

The additional-context advantage over ACE is real in the reported table. It is not a fourfold reduction relative to every plausible alternative. The simpler few-shot baseline is almost tied with ACE on the reported mean and already uses much less context. The more informative result is therefore a better reported quality/context trade-off against several baselines, not a universal cost multiplier.

The selected procedure regresses on USPTO against both of those comparators. An average therefore cannot authorize replacing every task's existing procedure. Reweighting the tasks could change the decision even if every published cell were accurate. The mean of rounded cells can differ slightly from the difference of separately rounded reported means; the arithmetic record keeps both rather than treating rounding as an experimental inconsistency.

### Transfer is evidence, not universal generalization

Table 5 reports transfer to nine datasets not used for harness search. Against ACE, the selected policy gains 2.9 points in the reported mean, with six positive and three negative dataset differences. Against the best listed baseline per dataset, it has five strict wins, one tied best result and three losses. The paper's six-of-nine leading-result description includes the SciTail tie; it need not be treated as an erroneous claim. [P01 Table 5, C.1]

The losses are informative: FiNER, Financial Phrasebank and Banking77 favor another listed choice. Transfer therefore supports usefulness beyond the three search datasets without establishing uniform benefit. It does not demonstrate that these datasets were unseen during base-model pretraining, that the procedure works without labeled examples, or that it transfers to open-ended work with external effects.

No confidence interval or significance test was generated from the aggregate percentages. Historical paired predictions, exact evaluated populations and repeated independent searches were not recovered. Nine task aggregates are not a substitute for those records.

## 4. Does diagnostic history explain better search?

The strongest local comparison is the paper's interface ablation, not the headline against ACE. Scores Only and Scores + Summary both retain code; the latter adds LLM-generated summaries but not raw traces. The full interface adds trace access. Reported median/best accuracies are 34.6/41.3, 34.9/38.7 and 50.0/56.7 respectively. [P01 Table 3]

This is positive evidence for the richer interface in that experiment. It is more discriminating than merely observing that a successful proposer read many files. But the scope remains bounded: these are the reported candidate/search outcomes, not distributions over independently reproduced research campaigns. The table's count above zero-shot must not become a count of independent replications or successful production changes.

The summaries' construction, retained information, prompt budget and total proposer work matter. A weak summary condition could omit the relevant evidence; another summary or selective exact retrieval might perform differently. The result supports testing recoverable diagnostic access, not declaring all summaries harmful or all longer contexts beneficial. The full interface retrieves selectively from a filesystem; it does not put the entire archive in one prompt.

Table 4 compares optimizers on the **search set**. Its best values, including 56.7 for Meta-Harness, are not Table 2's final-test scores. The TTT-Discover baseline is explicitly only that method's text-optimization/PUCT reuse component. Equal full-harness evaluation counts are the comparison's stated budget; they are not a faithful accounting of every resource or necessarily the native budget unit of every original optimizer. [P01 §4.1, Table 4]

The claimed tenfold speedup is tenfold fewer full evaluations to a reported target, not measured tenfold wall-clock or monetary savings. There is also an unresolved presentation boundary: the classification-specific protocol and figure use 40 candidates/evaluations, while the introduction refers to 60 proposals and the generic implementation says roughly 60 over 20 iterations. The project page repeats a roughly-60 claim. We cannot assign these to one historical run without its configuration and lineage. [P01 introduction, §3, §4.1, Figure 1; P02]

## 5. Reopen the comparator sources, not just their labels

### MCE is an adaptive mechanism, not merely a static handwritten prompt

MCE's primary paper describes learned skills and executable context functions. Its meta-agent consults the history of skills, contexts and metrics; its base-agent changes files and retrieval/composition code. A history-informed outer loop retains the better context. Its experiments use a bounded query-to-context interface, but that experimental interface should not erase the broader mechanism. [M01 §§3.2–3.4, 4.1]

Thus Meta-Harness's broad grouping of MCE among human-designed strategies is insufficient as an account of the original method. The local benchmark can still legitimately compare a particular MCE-derived implementation; what remains missing is the exact tested adapter, skill, budget and configuration. Correcting a method description does not disprove the local scores.

### GEPA already consumes execution traces

GEPA's algorithm gathers feedback, scores and module traces from minibatch executions, then uses them to revise a prompt; candidate retention/selection uses a per-instance Pareto mechanism. Calling its history representation a summary must not be expanded into the claim that it never sees raw execution traces or uses scalar feedback alone. [G01 §3 and Algorithms 1–2]

The useful comparison is more specific: how much history is retrievable, which module/instances are inspected, what gets retained, which artifact can change, and how much work the interface permits. Prompt evolution within a language program and direct executable-harness rewriting are different search spaces. Their adaptation into one benchmark needs explicit contracts. We did not inspect the historical GEPA adapter used by Meta-Harness.

### ACE also changes and refines its context

ACE's Generator–Reflector–Curator design uses feedback and structured incremental updates; grow/refine and deduplication are part of its account. It is not accurately reduced to indiscriminately appending all history forever. [A01 §§2–3.2]

The three primary comparator papers refine the comparison space; they are not fresh replications of the variants in Meta-Harness. The versions read here are identified in SOURCES. In particular, reading a later ACE revision does not prove that MCE's earlier experiments used that revision.

## 6. Measurement identity is a load-bearing unresolved seam

### Same dataset name, different score

MCE's native LawBench experiment reports micro-F1, giving partial credit for multi-charge cases. Meta-Harness's classification table is labeled accuracy. The pinned reference code makes the distinction concrete: `eval_lawbench` returns exact charge-set correctness and additional F1/count metrics; `evaluate_memory` computes accuracy from the `was_correct` values. A separate `compute_micro_f1` helper exists, so the release must not be described as lacking F1 altogether. [M01 §4.1, A.4; K03; K04]

**Inference:** a LawBench number in one paper cannot be substituted directly for the other paper's number. The common dataset name does not make the metric, model, split or adaptation protocol identical. This does not invalidate a within-table comparison if every method was reevaluated with the same criterion. Its historical implementation identity remains to be established.

Likewise, USPTO in the retrieved loader asks for precursor SMILES strings; its evaluator compares normalized component sets. The paper's 180-class description should not silently turn that generated-output task into a verified fixed-label classifier. The mapping between the reported class count, data sample and historical target representation was not recovered. No claim of dataset leakage or historical manipulation follows. [P01 §4.1; K02–K03]

### Tokens, characters, calls and total cost

Table 2 labels thousands of additional input tokens; Table 9 explicitly labels thousands of characters. Figure 3's x-axis says characters while its caption says tokens. Preserve the declared units and the labeling conflict rather than applying an assumed four-characters-per-token conversion. [P01 Tables 2/9, Figure 3]

The project page's blanket statement that no discovered harness needs another LLM call conflicts with B.1's two-call Draft Verification description. The selected Label-Primed Query policy can still be single-call; the family-wide statement is too broad. A variant with smaller measured added context is not thereby the cheapest complete prediction. [P01 B.1; P02]

The release README separately identifies the historical classifier as a local vLLM GPT-OSS-120B deployment with MXFP4 quantization and a 32,768 model-length setting, whereas the release defaults to an API-backed model. Together with Note04's last-prompt character accounting, this creates a revalidation need, not permission to infer the exact historical tokenizer, truncation, cache behavior or full cost. [K01; Note04 F06–F07]

## 7. Release correspondence and missing evidence

The external repository's current main still equals the study's existing pin. Its inspected `agents/` directory contains only the initializer and three simple baselines; the selected classifier and ACE/MCE adaptations are not in that directory. This is a bounded directory observation, not proof that no historical artifacts exist elsewhere. [K05–K06]

The following would materially strengthen or change the conclusion:

- The selected policy and every compared adapter, pinned to the actual run, with skill/configuration versions and complete candidate lineage.
- Historical train/search/test identities, instance ordering, labels available at each stage and the evidence released to the proposer.
- The metric implementation actually used for the published cells, including normalization, missing outputs and exclusions.
- Per-example paired results and independent search repetitions sufficient to characterize uncertainty and repeatability.
- Separate accounting for proposer effort, evaluations, inner prediction calls, context units, caching, latency and total cost.

These are evidence requirements for stronger claims, not instructions to launch all experiments now. This turn did not install dependencies, run an agent, call a paid model or execute any upstream benchmark. The only new computation was descriptive arithmetic on a manually transcribed subset of the paper's tables.

## 8. Bounded conclusion and next work

The reported classification results support a promising selected procedure, a stronger local search interface and nonuniform transfer to additional datasets. They do not support universal optimizer superiority, a single causal explanation, cost equivalence across comparators or independent replication. The comparator-source corrections and metric distinctions narrow interpretation without dismissing the positive results.

For later SOUL/Development OS inquiry, the reusable question is not simply whether to add more memory. It is whether the improvement decision compares the right artifacts, populations, criteria and resource budgets while preserving adverse results and simpler alternatives. This is a research-use hypothesis, not the U06 project assessment or an architecture change.

**U03-A is complete at this documentary/arithmetic depth.** The next bounded family is U03-B, math retrieval: recover the 250-versus-88 search-size statements, search-model versus held-out-model definitions, retrieval corpus/decontamination, three-sample aggregation and fixed-retriever comparators. Coding remains a separate subsequent family. U04 synthesis, U05 justified probes, U06 projection and U07 closure remain open.
