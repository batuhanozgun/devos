# U03-B — Sources, recovery and actual computation

**Observed:** 2026-09-16. **Input repository:** `batuhanozgun/agentic-os-search@21d3c02c31c9f0f489d749dd04b8361abbf73a17`. **Scope:** the math/retrieval experimental family, not another video pass or a whole-campaign replication. This ledger extends prior evidence without revising its historical read/run status.

## Primary sources and exact reading extent

| ID | Source identity | Actual reading and role |
|---|---|---|
| P01 | Lee et al., *Meta-Harness: End-to-End Optimization of Model Harnesses*, `2603.28052v1`, submitted 2026-03-30. [Abstract](https://arxiv.org/abs/2603.28052v1), [HTML](https://arxiv.org/html/2603.28052v1), [PDF](https://arxiv.org/pdf/2603.28052v1) | Recovered §4.2, B.2, C.2–C.3 and Appendix D, plus relevant general-method text in §3. PDF screenshots of printed pages 8, 20, 21, 23, 24 and 25 (zero-based 7, 19, 20, 22, 23, 24) inspected. These include Table 6, Figure 8 and Tables 10–11. Classification/coding material on adjoining pages was surfaced, not newly audited. No full-paper reread, historical run reconstruction or local PDF byte hash is claimed. |
| P02 | [Author project page](https://yoonholee.com/meta-harness/) | Opened source/identity links and math section, including its comparison table and five-unseen wording. Dense comparator rows are present in P01 but not that page's math table. Same provenance family as the paper; not independent corroboration. No immutable page snapshot/hash or interactive-demo audit. |
| B01 | *Towards Robust Mathematical Reasoning*, EMNLP 2025. [ACL entry](https://aclanthology.org/2025.emnlp-main.1794/), [ACL PDF v1](https://aclanthology.org/2025.emnlp-main.1794v1.pdf) | Selected §§2.2–2.3 (robustification and answer grading), §3/proof grading, §§5.1–5.3 (answer/proof reporting and grader agreement), limitations and selected B.2/B.6 grading/error passages. PDF screenshots at zero-based 3, 5 and 6 inspect the rubric and Tables 4/6 (printed 35421, 35423, 35424). The ACL landing also exposes later versions; this audit intentionally binds the stated v1. Not the whole 25-page paper, benchmark implementation or raw human/automatic grading record. |
| D01 | [NVIDIA OpenMathReasoning dataset card](https://huggingface.co/datasets/nvidia/OpenMathReasoning) | Card overview and documented record fields, especially generated solution/model, expected answer, question type, source and `pass_rate_72b_tir`. Selected release/license metadata surfaced but no adoption judgment. Current card, not the exact historical corpus bytes or processing code used by P01. No dataset downloaded or sampled as a validation corpus. |
| D02 | [AI-MO NuminaMath-1.5 dataset card](https://huggingface.co/datasets/AI-MO/NuminaMath-1.5) | Summary and column definitions, distinguishing `problem_type`, `question_type` and `answer`. Preview rows surfaced but were not a systematic data audit. The inspected fields do not establish P01's difficulty attribute provenance. No claim of absence from every possible source/version. |
| R01 | Shakya et al., [*Adaptive Retrieval helps Reasoning in LLMs – but mostly if it’s not used*](https://arxiv.org/html/2602.07213v1), v1 | Abstract and §§2–4 read for task/model/corpus, static-versus-adaptive retrieval and the authors' interpretation of retrieval choice. Selected A.1 configuration/prompt text also surfaced. No quantitative chart transcription, full appendices, code audit or reproduced evaluation. This is an alternative mechanism and selection-effect case, not an equal-budget head-to-head comparison with P01. `R01` here is a local source ID, not an agent-control reference. |

Additional discovery-only route: [MathArena](https://matharena.ai/) was opened to locate the cited research-math context. Its current models, task list, sample counts and leaderboard do not recover the earlier experiment's exact ArXivMath scorer. No current leaderboard conclusion is used.

P01's published results are author claims. Native benchmark/data documentation clarifies meaning and exposes correspondence questions; it neither reconstructs P01's historical implementation nor proves its scores false. Web read dates are observations, not immutable source-byte identities. The experiment's known pin remains v1 even if another source later changes.

## External repository recovery

All implementation entry checks use `stanford-iris-lab/meta-harness` at `0cbc31e97c9e6d24232d1dc754827c02e1ec415c` through the connected GitHub reader.

| ID | Exact GitHub surface | Extent / identity |
|---|---|---|
| K01 | `git/ref/heads/main` | Current main equality with the existing pin rechecked on 2026-09-16. This does not repin or recreate the historical run. |
| K02 | `README.md` | Full read; blob `66cb63258372c1e403ec104f7f31d3799de382d4`. Describes two reference experiments and a cleaned-up release. External quick starts and source instructions were not executed. |
| K03 | Root tree `37d52e49bb7d8e945d4d9dafc240833184f0a8e7`; `reference_examples` tree `b61bac7a7bf182745c6f114164af51c2d35bb5bf` | Untruncated, nonrecursive listings. Reference entry contains `terminal_bench_2` and `text_classification`. Root also includes assets and experimental directories; this is not a full recursive inventory. |
| K04 | `experimental` tree `8c4ab8d4e0d1a141ce7f4adc79971005e4da8e54` | Untruncated, nonrecursive listing; exposes `harbor_meta_harness` tree `cd591b76846cb7e61be6c0d0c4f96d7286a065c0`. Its deeper implementation was not read here. |

Canonical file route: `https://github.com/stanford-iris-lab/meta-harness/blob/0cbc31e97c9e6d24232d1dc754827c02e1ec415c/README.md`.

The named entry routes did not recover a historical math candidate, corpus builder, scorer, exact comparison adapters or raw run receipts. Branch history, every nested directory, author archives and all community projects were not exhaustively searched. The bounded result is non-recovery at these inspected routes, not universal artifact absence. No new source-code behavior was executed.

## Local arithmetic and its provenance

`REPORTED-DATA.json` manually transcribes P01 Table 6 and the population counts in Tables 10/11, visually checked against their PDF pages. Model order, the one search solver and four not-used-in-search models are explicit. Numeric strings retain displayed precision; they are not unrounded raw measurements.

`audit_reported_numbers.py` uses standard-library Decimal arithmetic. It checks input shape, model-group identity, metric ranges and count totals; recomputes all-model and four-model means, comparator deltas and model-cell win/tie/loss counts; and records input/script SHA-256 in `ARITHMETIC.json`. Three fixed numerical expectations and three deliberately malformed-input checks were executed successfully. Negative fixtures remove a model cell, change the search-model grouping and corrupt the evaluation total. They test this bookkeeping only, not retriever efficacy, benchmark validity or experimental replication.

Actual local command:

```text
python /mnt/data/u03b-work/audit_reported_numbers.py
```

The output uses no model/API credentials or network. Data/script hashes in the output identify the executed inputs. The script can be rerun from its published directory using its defaults; a future run should compare source identities, not trust a former local path. Task-count shares are marked as counts, not confirmed score weights. No p-value, confidence interval, pass@3 estimate or problem-level win count is inferred from aggregate cells.

## Canonical context and unchanged boundaries

AGENT and all required protocols had already been fully read in this conversation. AGENT was refreshed this turn and unchanged; active protocol copies remained applicable. They govern the researcher and are not research evidence. Current main/STATE were refreshed. The unchanged full reads of INDEX, METHOD, v0.6 PLAN, WHY, Note02 and original SOURCE-LEDGER remained available at the same repository snapshot; their required U03-B route was followed. No prior conversation summary substitutes for those source reads.

The user's clarification concerned understanding the plan, not changing it. The subsequent request explicitly preserves that plan and authorizes continuation. U03-B is one bounded family; U03-C remains the next work. Before any future U06 projection, current Foundation and SOUL/DevOS authority must be recovered anew.

No video/audio processing, whole-paper experiment reproduction, independent review, installed retriever, model call, proof-grader run, dataset filtering, sandbox test or paid/remote benchmark occurred in this unit. Prior U01/U02/U03-A evidence and all open validation limits remain unchanged. Publication requires the actual bounded Git diff, non-force main advancement and readback; local files and arithmetic output are not publication receipts.
