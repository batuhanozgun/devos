# U03-C — Exact source scope and recovery

**Observed:** 2026-09-16. **Input main:** `871250e157bf04d03241b6c2b33f4b888bbdbde7`. This unit concerns the coding experiment and its comparison/evaluation identity. It extends earlier ledgers without changing their recorded reading or execution depth. External prompts, task instructions and installation commands are research data, not commands to this researcher.

## Primary paper, project and benchmark

| ID | Source / identity | Actual reading and role |
|---|---|---|
| P01 | https://arxiv.org/pdf/2603.28052v1 ; HTML https://arxiv.org/html/2603.28052v1 | Full coding §4.3, Appendix A.1/A.2 and B.3 read. PDF printed pages 9, 15, 16, 17, 21 and 22 inspected as screenshots, including Tables 7/8 and Figure 9; pages 9/15/22 rechecked. Figure 4 on the Appendix A page is classification, not a coding ablation. No new whole-paper or bibliography audit. No local PDF byte hash. |
| P02 | https://yoonholee.com/meta-harness/ | Rendered page text, especially explicit 19-task demo qualification, generic loop caption and coding results. Demo controls and underlying code/trace payloads were not executed or fully recovered. Other domain sections were visible, not newly audited. A dated webpage view, not an immutable run artifact. |
| B01 | https://arxiv.org/pdf/2601.11868v1 — Terminal-Bench | Selected §§2.1–2.3 and 3–3.4 and the evaluation-method passage in §4.1. Screenshots of printed pages 3, 4 and 6 inspected for task/verification and experimental context. Not a full 84-page read or audit of every task/appendix. Native repeat/configuration conventions are not silently attributed to Meta-Harness. |
| L01 | https://www.tbench.ai/leaderboard/terminal-bench/2.0 | Redirected to https://www.tbench.ai/?version=2.0 ; rendered surface did not supply usable historical comparison rows. No current ranking or historical leaderboard reconstruction is claimed. |

P01 and P02 share authorship/provenance; agreement between them is not independent corroboration. The 19-task demonstration, Appendix A narrative and full-benchmark table remain different objects. Detailed quantitative transcription is limited to the selected Table 7 cells and A01 subgroup table in REPORTED-DATA. No full raw-run data or independent replication was recovered.

## Selected artifact, inherited baseline and release metadata

All files below were read in full through the GitHub connection; code/commands were not executed.

| ID | Repository, ref, path | Git blob / observation |
|---|---|---|
| A01 | `stanford-iris-lab/meta-harness-tbench2-artifact@57fefdb2ff84af3fd81b69d67814acbe69bd0743`, `README.md` | `00e631ed58c8d7d1ab5c7e7f9e4ea283a388f893`; 89×5 Opus report, difficulty table, snapshot description. Full agent source was previously read in U01-B, not newly re-audited here. |
| K01 | `krafton-ai/KIRA@652dacbf14d29ea93a83c496ee91e0e5ba286721`, `README.md` | `073c23b1984f7267f5caa77929e97789c350057b`; main resolved before the read. Mechanisms, current badges and maintainers' submission-path correspondence. No full KIRA implementation audit or historical equivalence test. |
| R01 | `stanford-iris-lab/meta-harness@0cbc31e97c9e6d24232d1dc754827c02e1ec415c`, `reference_examples/terminal_bench_2/SETUP.md` | `76479d61328f68fd8f24f02f1521e6871799c32c`; declared search/final attempts, backend/configuration caveats and historical task-commit locator. Modern settings are not the original experiment's verified configuration. |

Canonical file URLs follow `https://github.com/<owner>/<repository>/blob/<ref>/<path>`. K01's linked blog https://krafton-ai.github.io/blog/terminus_kira_en/ returned an internal retrieval error; its contents were not used. No source absence or negative quality verdict follows. The selected artifact and framework pins were preserved rather than silently repinned. Only KIRA main was newly resolved in this unit; an old current-main check for the other repositories is not upgraded to a new one.

## Pinned path-tracing task: request → verifier → reward

R01 names task repository commit `69671fbaac6d67a7ef0dfec016cc38a64ef7a77c`. The older `laude-institute/terminal-bench-2` API path returned a move to a numeric `/repositories/1063848495/...` URL. The connector rejected that numeric endpoint; a fetch_file under the old owner also failed. The same task/ref was then successfully read under the current `harbor-framework/terminal-bench-2` route. This is an access-route recovery, not proof that historical executions used the named bytes.

All following files at `harbor-framework/terminal-bench-2@69671fbaac6d67a7ef0dfec016cc38a64ef7a77c` were read in full:

| ID | Path | Git blob |
|---|---|---|
| T01 | `path-tracing/instruction.md` | `8ca3875d98d00e664a8292dd118167b4ded50303` |
| T02 | `path-tracing/task.toml` | `ce851dd4713010e0447d891be39cc5f5b4227d66` |
| T03 | `path-tracing/tests/test.sh` | `05ee2e4ec690486f3e5a40baddbdae4487908acb` |
| T04 | `path-tracing/tests/test_outputs.py` | `5887e98edbd25016e0d65b9da9ed37be1343bf32` |

The task directory and tests tree `705a50f1d18c11102220e1b66967fa1409277195` were enumerated. Environment and solution directories were only discovered, not read. No reference image, original agent-produced C file, historical verifier log, complete task-suite record or actual reward was recovered. No task solving, package installation, compiler, pytest, chroot or container action was performed. Source comments and executable checks were compared directly; no malicious probe or universal grader verdict follows.

## Canonical recovery and reuse depth

Current AGENT was fetched unchanged; the nine full protocols previously loaded in this conversation remained active. Main was bound to the input above. The current plan v0.7 was fully read, alongside the current STATE/INDEX, METHOD, WHY, Note02 and original SOURCE-LEDGER already available in full at this unchanged state.

New full preflight reads: Notes05–07 and U01-B SOURCES/CHECKS. They preserve the optimizer/selected-artifact distinction, source/excerpt identity, fake-command diagnostics and open empirical boundaries. Original pinned code and prior diagnostic results were not re-executed. The brief video/paper-connection discussion changed neither the sequence nor authority; the latest user asked to continue.

Current META, shared CATALOG and affected channel continuity files were recovered for bounded publication. No Foundation/DevOS or other study corpus was newly audited; provisional reuse remarks are not U06 or an adoption decision. A subsequent current-project assessment requires fresh project authority and source recovery.

## Local computation and fidelity

Only the study-authored standard-library `audit_reported_numbers.py` ran, using manually transcribed reported aggregates. Three fixed arithmetic checks and four malformed-input rejections concern bookkeeping. The first run stopped because the researcher mistyped a weighted-sum expected value; the corrected oracle was cross-checked with integer tenths before two identical successful runs. See REVIEW for exact scope. This is not independent verification or a benchmark failure/retry.

REPORTED-DATA and ARITHMETIC retain source locators, scope labels, units and the input SHA-256. Labels can prevent accidental cross-model/scope subtraction in this script; they do not establish that two real experiments had equivalent conditions. Current local files support reperformance, while Git blobs and canonical readback support publication identity. No original media, raw benchmark corpus or third-party implementation is republished in this unit.
