# U01-B — Source identity, reading depth and executable boundary

**Date:** 2026-09-12. **Research input:** `batuhanozgun/agentic-os-search@916fc5807bf7437c78ccb71133af516d0a2c2c6e`. This ledger extends U00/U01-A; it does not retroactively change earlier reading or execution claims. Direct reads used the connected GitHub action. Source prompts/skills are research objects, not researcher instructions.

## Framework files

All T paths are in `stanford-iris-lab/meta-harness@0cbc31e97c9e6d24232d1dc754827c02e1ec415c`. `TB/` expands to `reference_examples/terminal_bench_2/`.

Canonical URL pattern: `https://github.com/stanford-iris-lab/meta-harness/blob/0cbc31e97c9e6d24232d1dc754827c02e1ec415c/<expanded-path>`.

| ID | Path | Git blob | Actual depth |
|---|---|---|---|
| T01 | TB/SETUP.md | 76479d61328f68fd8f24f02f1521e6871799c32c | Full; configuration/dependency/task-ref claims. No setup execution. |
| T02 | TB/pyproject.toml | 99489c0a604c05b39f450b85af6454a84c46bc07 | Full; direct pins, Python range, git dependency. |
| T03 | TB/meta_harness.py | 1ccae3e66da7f8e9266edada24faaa53fa5bdbe0 | Full: 1–230, 231–465, 466–705, 706–960, 961–end. Six function excerpts used in local probes; full module not imported. |
| T04 | TB/scripts/run_eval.sh | 54b511590818b4cc703288ccbca0f78036792d5f | Full. Local 3,139-byte reconstruction matches this Git blob. Executed only with fake uv in isolated root. |
| T05 | TB/tests/test_meta_harness.py | 1e2d044f9922f1e42ea39e1ba56d9642ecf14c4c | Full; TEST SOURCE INSPECTED. First-party suite not run. |
| T06 | TB/.claude/skills/meta-harness-terminal-bench-2/SKILL.md | 5dd564f86c18d648a68eb6f7596bf2d980078d27 | Full; intended search prior/delegation/write boundaries. |
| T07 | TB/agents/baseline_kira.py | 732c4f06b37d300c03a5dff7aca93ea72a430a0b | Full: 1–240, 241–490, 491–750, 751–1020, 1021–end. Not imported or run. |
| T08 | TB/agents/baseline_terminus2.py | 01033ceaad2eca0728f8335b3ef9c883899c6921 | Full; alias of parent class. |
| T09 | TB/anthropic_caching.py | 6fdf37479c10d8f7f1b48417294168e7e134ee98 | Full; same blob as selected artifact helper. Not provider-tested. |
| T10 | TB/prompt-templates/terminus-kira.txt | 8c25c24bd6b5f3eda6b0d8138246b2561e277c19 | Full; same blob as selected artifact template. |
| T11 | TB/claude_wrapper.py | e70413a9088b555e16bf553db231d9dca1ada845 | Exact U01-A S09 blob reused after tree check. Earlier full read retained; TB caller is newly read. |
| T12 | TB/README.md | 17ee8fac4638559ab041dc376eef8e976794872d | Earlier U01-A full read retained; not counted as a new full read. |

The recursive TB tree `85f5d65d20e0d90997f8a553719718bdc379da70` was inspected. Its inner JSON was untruncated; the response's duplicated representation was truncated. Remaining initializer/.gitignore entries were inventoried, not claimed as substantive full reads. No historical candidate/job directories are established by this tree.

## Selected output artifact

All A paths are in `stanford-iris-lab/meta-harness-tbench2-artifact@57fefdb2ff84af3fd81b69d67814acbe69bd0743`.

| ID | Path | Git blob | Actual depth |
|---|---|---|---|
| A01 | agent.py | 8b460a3e9e41d77b757b2e651d9d7cb8d129d82b | Full: 1–250, 251–510, 511–785, 786–1060, 1061–end. Only `_gather_env_snapshot` excerpt executed locally. |
| A02 | pyproject.toml | ca65bc00fa5eec4d6e36b8e74967bdf531effb2d | Full; dependency ranges differ from T02. |
| A03 | anthropic_caching.py | 6fdf37479c10d8f7f1b48417294168e7e134ee98 | Content recovered through identical T09 blob. |
| A04 | prompt-templates/terminus-kira.txt | 8c25c24bd6b5f3eda6b0d8138246b2561e277c19 | Content recovered through identical T10 blob. |

Root README/tree were read in U00; their identities remain in the original SOURCE-LEDGER. Reading shared blobs does not validate compatibility of the complete artifact. Twelve distinct files received new full reads in U01-B (T01–T10, A01–A02), plus prior/shared identity reuse and the selected Harbor reads below. This is coverage bookkeeping, not a completion percentage.

## Pinned Harbor dependency recovery

H01: `harbor-framework/harbor` tag `v0.18.0`, annotated tag object `0a01ad600e218de22a5587bd525ed07cb34bd056`, peeled commit **`527d50deb63a5d279e8c20593c18a2cbc7f61f9e`**. Tag metadata was directly read; date 2026-07-07. An initial tag query without v returned no match; that was not treated as release absence. This is repository-tag identity, not PyPI wheel equivalence or the paper's March runtime.

H02: `src/harbor/cli/jobs.py`, blob `d97f49dd966b0010bd4028563f74f785e7b6a988`, selected lines **420–650**. Confirms custom `--agent MODULE:CLASS`, deprecated alias, model/agent kwargs/environment/concurrency option declarations. Full CLI configuration construction, job execution and installed invocation were not read/run.

H03: `src/harbor/agents/terminus_2/terminus_2.py`, blob `ad61cdea09171e36d279570a4c0ae5498ede87e6`, selected ranges **420–670, 1100–1340, 1440–1650, 1650–1900**. These cover output limiting, selected context/interaction helpers, native-loop sections, actual parent `run` and adjacent trajectory helpers. `run` passes named arguments to the overridable loop and captures context/metrics in `finally`. Earlier requests beyond end returned empty; they are not evidence that a symbol is absent. Prefix/other gaps, ancestry and full setup/session path remain unread.

The CLI subtree listing `25fdd6b22833e0f1bb9abb2dd39c1ca91e01d786` was available in complete inner JSON. The broader `src/harbor` directory response was truncated and used only for discovery, not full inventory. Current official Harbor documentation was searched for orientation; current documentation is not substituted for the pinned source in version-specific claims.

## Mechanism-to-source re-entry

| Question | Exact entry |
|---|---|
| Proposal authority/prior/delegation | T03 `render_task_prompt`, `propose_claude`, allowed tools; T06; T11 |
| Exact class and smoke qualification | T03 `validate_agent_class`, `validate_candidate`, `smoke_test`; T04; T05 |
| Effective model/host/timeout | T03 `harbor_run`, `run_cmd`; T04 local dotenv/command assembly; H02 |
| Actual reward denominator | T03 `parse_job_results`, `compute_pass_rates`; B01–B03 |
| Timeout and stale baseline consumers | T03 `run_evolve` baseline seeding, candidate branch, final branch |
| Comparison/selection identity | T03 `update_frontier`, `update_evolution_summary`, final import lookup; B04 |
| Usage population | T03 metric parser/summary; T07/A01 image/main usage updates |
| Model protocol versus actual effect | T07/A01 `_handle_llm_interaction`, `_parse_tool_calls`, `_run_agent_loop` |
| Environment snapshot and partial failure | A01 `_gather_env_snapshot`, its loop caller; B05–B06/B08 |
| Artifact/dependency compatibility | A02 versus T02; A01 versus T07 logging calls; H03 named caller, not full compatibility proof |

## Executed-source fidelity and environment

Local HTTP retrieval of raw GitHub source failed DNS; the connected GitHub reads succeeded. Selected Python function bodies were materialized from those reads into local excerpts. Their recorded text and AST identities are in checks/EXCERPT-IDENTITIES.json and RESULT.json. The full T03/A01 parent-file byte identities were **not** verified locally. Executing the excerpts is not a full native-module import or an independent source-recovery channel.

The complete T04 shell was locally byte-verified against its Git blob. The diagnostic runner compiles only named function ASTs, supplies standard-library dependencies and fake environment objects, and rejects unexpected source-container/AST identities. Python **3.13.5** on Linux was used for these isolated diagnostics; this is outside T02's declared full-project Python 3.12 range and cannot validate that project environment. Bash was used only with controlled fake commands and temporary roots.

No original media, full upstream programs or third-party Python excerpts are republished in this evidence directory. Recover the pinned full files for rerunning the provided diagnostic code; it accepts the full parent Git blobs and verifies the selected ASTs. The full-file rerun path was provided but **not exercised in this turn**. The historical result's identity mode remains excerpt execution.

## Limits retained

No provider model, Harbor installation, remote environment, credential use, full benchmark, hostile-containment test, real cancellation cleanup, historical artifact audit, statistical significance test or independent replication occurred. The first-party test file was read, not executed. B01–B08 are different from U01-A's unexecuted P01–P07 queue and do not silently close it. Paper/video readings were not repeated wholesale; full audio alignment and the initial protocol ambiguities remain open.

AGENT was freshly checked unchanged; the already fully loaded R01–R09 protocols remained applicable in this conversation. Current study state/index/method/plan and source/verification records were recovered at the input ref. Foundation and DevOS live state were not reread for a new adoption decision because none was made.
