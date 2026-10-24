# U03-A — Sources, versions and actual coverage

**Observed:** 2026-09-15. **Repository input:** `22e9ff43e3e09c2bb8ec7017fe8037a39cf2156e`. **Object:** classification experiment/comparator audit, not all three experiment families. New findings: [Note13](../../notes/13-CLASSIFICATION-EXPERIMENT-AND-COMPARATOR-AUDIT.md).

## Research sources

| ID | Exact source | Actual reading and role |
|---|---|---|
| P01 | https://arxiv.org/pdf/2603.28052v1 | Selected introduction, §§3/4.1, B.1, C.1, Appendix D and classification tables. Main experimental protocol, selected variants, ablation and transfer. Not a full new reading of all 26 pages or all cited papers. |
| P02 | https://yoonholee.com/meta-harness/ | Project-page classification, optimizer-comparison and variant descriptions; whole short rendered page available. Same-author presentation, not independent confirmation. Other-domain text surfaced but is not a new math/coding audit. |
| M01 | https://arxiv.org/html/2601.21557v2 | Meta Context Engineering: selected §§3.2–3.4, 4.1 and Appendix A task/protocol definitions, especially LawBench micro-F1 and split descriptions. Some adjacent discussion surfaced. Not the full 46-page paper, all learned skills or its implementation. |
| A01 | https://arxiv.org/html/2510.04618v3 | Agentic Context Engineering: selected §§2–3.2, generator/reflector/curator, incremental update/merge and grow/refine mechanism. Not a new audit of all benchmark results or code. |
| G01 | https://arxiv.org/pdf/2507.19457v2 | GEPA: selected objective and §3 reflection/candidate-selection account, especially Algorithms 1–2. Not the complete 96-page paper, all appendices or Meta-Harness's benchmark adapter. |

Version metadata was checked through the arXiv abstract pages. P01 is v1, 2026-03-30. M01 v2 is 2026-02-11; A01 v3 is 2026-03-29; G01 v2 is 2026-02-14. These identify the texts consulted, not automatically the versions or code commits used by historical experiments. An ACE revision later than MCE v2 cannot be retrospectively assumed to be MCE's original baseline.

## PDF visual coverage

P01 screenshots inspected at printed pages 1, 6, 7, 8, 20 and 23 (zero-based 0, 5, 6, 7, 19, 22). These expose Figure 1; Tables 2–5 and 9; Figure 3's unit-label discrepancy; Figure 7; and relevant appendix context. Some pages also contain math tables/diagrams: their visibility does not mean that U03-B has been completed. Pages 6, 8 and 20 were reopened during the numerical/source review, not counted as additional independent evidence.

G01 printed page 6 (zero-based 5) was visually inspected for Algorithms 1–2 and Figure 4's explanation. We did not extract coordinates from its subsequent result plots or use their scores as controlled comparisons with Meta-Harness.

Parsed-line routes used for selected text: P01 approximately 190–403, 875–935, 943–957, 1050–1086 and 1130–1179, plus introduction; M01 approximately 140–213 and 438–452; A01 selected 118–151; G01 approximately 190–398 and candidate-selection context. These are tool-view locators, not stable canonical line numbers; use section/table identities for recovery.

## Pinned release observations

All K files are in `stanford-iris-lab/meta-harness@0cbc31e97c9e6d24232d1dc754827c02e1ec415c`. `TC/` below means `reference_examples/text_classification/`.

| ID | Path / identity | Actual extent |
|---|---|---|
| K01 | `TC/README.md`, blob `91974283cc9a91d5108833fdda46729ee8e6ffa6` | Full. Historical local-model versus released API default; minimal experiment and public-data boundary. |
| K02 | `TC/data/loaders.py`, blob `7399be9911dda0f0ba4bb0d4642c174e267e89b1` | Lines 1–240 only. Local split paths, original-task input/target construction, especially precursor-SMILES and multi-charge outputs. OOD loader tail not read. |
| K03 | `TC/data/evaluators.py`, blob `414692470e6f2d610899c3965ce9c533cecf15cb` | Full. Exact/normalized answers, charge-set correctness and auxiliary F1/counts. No new domain-oracle validity or execution claim. |
| K04 | `TC/inner_loop.py`, blob `e355cf127b29ed282dbc302c73f31c7a4004df48` | Selected lines 1–240 and 400–545. `_unpack_eval_result`, `compute_micro_f1`, `make_result`, offline validation criterion and complete `evaluate_memory` path. The middle and later main/output code were not newly read. |
| K05 | `TC/agents/`, tree `5d4d3f31372ff2b26782613f35003312c86c5aa8` | Untruncated nonrecursive listing: `__init__.py`, `fewshot_all.py`, `fewshot_memory.py`, `no_memory.py`. Directory scope only; bodies not newly read. |
| K06 | repository `refs/heads/main` | Fresh check still returned the existing pin `0cbc31e97c9e6d24232d1dc754827c02e1ec415c`. No repin or claim of an exhaustive historical-artifact search. |

Canonical source URL pattern: `https://github.com/stanford-iris-lab/meta-harness/blob/0cbc31e97c9e6d24232d1dc754827c02e1ec415c/<expanded-path>`.

The selected historical classifier, original ACE/MCE/GEPA adapters, raw dataset contents, historical execution logs, installed runtime and wire requests were not recovered in this unit. Their absence from our read set is not a global nonexistence finding. Notes03–04 retain the previous broader source trace and its original unexecuted boundaries.

## Numerical record and execution boundary

[REPORTED-DATA.json](REPORTED-DATA.json) manually transcribes Table 2 and Table 5 cells from P01's screenshots. It preserves the table's units and uses null for the unreported zero-shot OOD context entry. No data was scraped from a plot or reconstructed from rounded percentages into individual outcomes.

[audit_reported_numbers.py](audit_reported_numbers.py) was actually run locally with Python's standard library. [ARITHMETIC.json](ARITHMETIC.json) records input/script SHA-256, differences of reported means, means of rounded cell differences, context ratios, and win/tie/loss comparisons. Its scope is descriptive arithmetic. A second method or independent investigator did not reconstruct the raw experiment.

Run command: `python audit_reported_numbers.py > ARITHMETIC.json`. Output precision is arithmetic formatting, not additional precision in the measurements. No p-values, confidence intervals, significance claims, runtime tests or performance replications were generated.

## Canonical recovery and access

AGENT was freshly recovered and unchanged; the nine fully read protocols from this conversation remained active. Current STATE, INDEX, METHOD, PLAN, WHY, Note02 and SOURCE-LEDGER were fully recovered for U03. Notes03–04 and U01-A SOURCES were fully read for the selected family's prior results. The current library/catalog and affected metadata/state surfaces were refreshed for publication. Control files are not research evidence.

A local arXiv PDF download failed DNS; web PDF/text access and GitHub connector reads succeeded. GEPA's HTML v2 retrieval failed, so its exact-version PDF was used. No local PDF byte identity is asserted. No source text was submitted to an external processing service and no credentials or paid inference were used. Web pages are dated views rather than immutable byte captures.

This unit did not revisit the original video/audio, align captions, run any U01 check, install a framework or start U03-B/C. Prior media/historical/runtime limits remain unchanged. Fresh project/Foundation/DevOS recovery is still required before U06.
