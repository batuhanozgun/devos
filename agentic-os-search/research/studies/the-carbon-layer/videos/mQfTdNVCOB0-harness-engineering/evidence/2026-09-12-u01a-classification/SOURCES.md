# U01-A — Exact sources and reading coverage

**Date:** 2026-09-12. **Research input:** `batuhanozgun/agentic-os-search@c4a85e50fdbb4eccb55580d6f09b9238e3573147`. **Scope:** classification candidate-to-evaluation-to-selection source trace, with TerminalBench entry discovery. This is a reading ledger, not a run manifest.

## Pin and path resolution

All S01–S19 source files below are in `stanford-iris-lab/meta-harness` at **`0cbc31e97c9e6d24232d1dc754827c02e1ec415c`**. `TC/` abbreviates `reference_examples/text_classification/`; `TB/` abbreviates `reference_examples/terminal_bench_2/`.

Canonical file URL pattern: `https://github.com/stanford-iris-lab/meta-harness/blob/0cbc31e97c9e6d24232d1dc754827c02e1ec415c/<expanded-path>`.

Reads were through the connected GitHub action. Full files were read in one response or consecutive/overlapping ranges through the end. A selected range remains selected even when it contains the complete function needed for one claim. Blob identity describes the external source, not a locally executed copy.

| ID | Path | Git blob SHA | Actual read extent / role |
|---|---|---|---|
| S01 | `ONBOARDING.md` | `287c0953cfa2715d6298e604182b8e464fcf5106` | Full; 1–160 and 161–end. External design prompt, not researcher control. |
| S02 | `TC/README.md` | `91974283cc9a91d5108833fdda46729ee8e6ffa6` | Full; operation, test separation, release/paper boundary. |
| S03 | `TB/README.md` | `17ee8fac4638559ab041dc376eef8e976794872d` | Full; next-variant entry only, no execution. |
| S04 | `TC/meta_harness.py` | `ad676c1f49d122e91de1234d58080453c4a911b2` | Full; 1–220, 218–445, 443–end. Proposal receipt, validation, summary, finalization and resume. |
| S05 | `TC/benchmark.py` | `3bfacaa864e707d1069edf037e4bd64465e5a6ff` | Full; 1–240, 241–500, 501–750, 751–end. Dispatch, reuse, aggregation, frontier, reporting. |
| S06 | `TC/memory_system.py` | `446c234ee85ff1b98323a562994197ff30d1ea78` | Full; interface, prompt measurement, serialization contract. |
| S07 | `TC/inner_loop.py` | `e355cf127b29ed282dbc302c73f31c7a4004df48` | Full; 1–240, 241–500, 501–750, 751–end. Training/evaluation/import/storage callers. |
| S08 | `TC/.claude/skills/meta-harness/SKILL.md` | `5b9675ca2cd363dab245cbccd6e2e8342a10eb54` | Full; proposer prior and intended constraints; not enforcement evidence. |
| S09 | `TC/claude_wrapper.py` | `e70413a9088b555e16bf553db231d9dca1ada845` | Full; 1–220, 221–450, 451–end. CLI, environment, skill injection, logging, process path. |
| S10 | `TC/config.yaml` | `77f375c13b63fb6cf210e6d1ccca421f61a3b917` | Full; actual shipped default configuration. |
| S11 | `TC/tests/test_evolution_contracts.py` | `aece8bda2d3b0f9ea5b8b4884a5be59097da8c68` | Full; TEST SOURCE INSPECTED, NOT RUN. |
| S12 | `TC/data/api.py` | `8be69b3530f9a360a51e1a6dd8ed8f8fd1f0daf0` | Full; split loading, bounds, sampling, metadata preservation. |
| S13 | `TC/tests/test_benchmark.py` | `c290f822d5db6421ce5907c7dba0eac7031e6ba5` | Full; TEST SOURCE INSPECTED, NOT RUN; supplied range 1–300 reached end. |
| S14 | `TC/data/loaders.py` | `7399be9911dda0f0ba4bb0d4642c174e267e89b1` | SELECTED lines 1–220 only; local MCE loaders and split-path code. Transfer-loader tail not read. |
| S15 | `TC/data/evaluators.py` | `414692470e6f2d610899c3965ce9c533cecf15cb` | Full; evaluator selection, answer extraction and scoring. Domain validity not established. |
| S16 | `TC/agents/fewshot_memory.py` | `72a8e407df38e98b0beab1e664201b96eaefdc2f` | Full; baseline state, stable sampling/order, actual context cap. |
| S17 | `TC/agents/fewshot_all.py` | `95bb6cd2069accecf9384d523ff37e0bdcdad135` | Full; baseline subclass and doc/code boundary. |
| S18 | `TC/llm.py` | `5834c4a534e7a61865e86744b06212131634ad97` | Full; 1–220 and 221–end. Response-cache identity, truncation, usage and provider call. |
| S19 | `TC/data/__init__.py` | `d717b5122bdf20ff95766ef54888b6990c97441b` | Full; actual re-export path from worker to API/loaders/evaluators. |

Thus 18 listed files received full text reads, and one received a selected-range read. File counts are coverage bookkeeping, not percentage completion, successful tests or comprehension certification.

## Mechanism-to-symbol recovery

| Question | Source and symbols |
|---|---|
| What may the proposer do; what enters its context? | S04 `PROPOSER_ALLOWED_TOOLS`, `render_task_prompt`, `propose_claude`; S08; S09 `build_command`, `run`, `load_skills` |
| What admits a candidate? | S04 `validate_candidates`, `run_evolve`; S07 `load_memory_system` |
| Which exact jobs are executed or skipped? | S04 `run_benchmark`; S05 `_has_usable_result`, `build_val_runs`, `build_test_runs`, `main`, `_run_with_retries` |
| What is learned, evaluated and saved? | S07 `_run_offline_loop`, `run_inner_loop`, `evaluate_memory`, main block / `_build_output`; S12 `load_dataset_splits_3way`; S19 exports |
| How is a scalar attributed and selected? | S05 `parse_run_path`, `load_results`, `print_results`, `print_frontier`; S04 `update_evolution_summary` |
| When may search resume after test? | S04 `finalize_run`, `run_evolve`; S11 `test_incomplete_finalization_allows_evolution` and completed-finalization test |
| Is measured context the actual total call budget? | S06 `call_llm`, `get_last_prompt_info`; S07 `evaluate_memory`; S18 `_truncate`, `_generate_one`, `_cache_path`, `get_usage` |

## Trees actually inspected

All listings below were untruncated. Except the indicated skill tree, these were nonrecursive; a root listing is not a full repository inventory.

- reference examples: `b61bac7a7bf182745c6f114164af51c2d35bb5bf`.
- TC root: `3c7ba2da3965932f948fa6a2a058afc652db11b5`.
- TC `.claude`: `1250d002c1532f5b21071c802fee087c0b306f1e`, recursive listing through the skill.
- TC `data`: `e2ea9dfa27d59ac583937ebcbed949bf591bab5b`.
- TC `tests`: `bd8136507073bdb1c115313df1bcf968d6920f0d`.
- TC `agents`: `5d4d3f31372ff2b26782613f35003312c86c5aa8`.
- TB root: `85f5d65d20e0d90997f8a553719718bdc379da70`.

## Exact next TerminalBench surface

The TB root lists `SETUP.md` (`76479d61328f68fd8f24f02f1521e6871799c32c`), `meta_harness.py` (`1ccae3e66da7f8e9266edada24faaa53fa5bdbe0`, 34,550 bytes), `pyproject.toml` (`99489c0a604c05b39f450b85af6454a84c46bc07`), and `scripts/`, `agents/`, `tests/` trees. Their contents have not been read in U01-A.

Next trees: scripts `3f3b4b3797f645f5e7b1244576393d904f443607`; agents `6d7785af5191c6d0f187d318f70aac176b3d9755`; tests `f36cbbd0c73642b2fcd6b65a59c63b144cf960bf`; skill parent `.claude` `5767fc117f3bd1cd0efddcb5c1a7268a0b9402e0`.

TB `claude_wrapper.py` has the identical S09 blob. Its implementation need not be rediscovered, but the TB caller and authority/evaluation context remain untraced. TB `anthropic_caching.py` (`6fdf37479c10d8f7f1b48417294168e7e134ee98`) and prompt tree (`f44471f0ed410ac0621bba3314e9e7e77b6a25cd`) match identities listed in the separate selected-output repository; those contents are still unread.

The selected-output pin remains `stanford-iris-lab/meta-harness-tbench2-artifact@57fefdb2ff84af3fd81b69d67814acbe69bd0743`. Its `agent.py` blob `8b460a3e9e41d77b757b2e651d9d7cb8d129d82b` (52,915 bytes) is still unread. Do not equate the optimizer, reference baseline and selected artifact.

## Paper correspondence and current limits

P01 remains arXiv `2603.28052v1`. This unit selectively recovered HTML §§3 and 4.1 at `https://arxiv.org/html/2603.28052v1` for search/test separation, generic proposal loop and online-learning setup. It did not repeat the U00 full first-pass PDF/appendix/figure reading or recover historical run logs. Current README/config/source observations are distinct from the paper's historical experiments.

Not inspected: raw dataset rows, `data/constants.py` body, transfer-loader tail, `tests/test_data.py`, full installed dependency code, provider wire traffic, actual host enforcement, historical candidate artifacts and raw evaluation records. Names and tree entries do not count as those reads.

No local source checkout was created and no upstream test or program was executed. A local raw-GitHub HTTP retrieval attempt failed DNS; the connected GitHub reads succeeded. Analytical examples in Note04 are source-walk illustrations, not executed fixtures. No API key, paid service or deployment was used.

## Canonical continuity

Within the existing conversation the fully loaded R01–R09 controls remained active. Current main and the existing study work surfaces were recovered; METHOD, SOURCE-LEDGER, WHY, Note02 and META were fully read, while current STATE/INDEX/PLAN versions remained available from the verified U00 publication. Main was rechecked before staging and still pointed to the research input above. The existing catalog was reread before its single-row update. U00 source material and earlier notes are preserved; this ledger extends rather than retroactively changes their recorded reading depth.
