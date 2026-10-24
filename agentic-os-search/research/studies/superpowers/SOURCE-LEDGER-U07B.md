# Superpowers — Source Ledger Supplement U07-B

Observation date: 2026-09-18. Additive continuation of the original ledger and U03/U04/U05/U06-A/U06-B1/U06-B2/U07-A supplements. S00–S78, D01–D37, G01–G09 and E01–E14 remain preserved. STATE owns current work/completion; this register records source coverage, not universal correctness.

Primary unchanged: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, root tree `21219529a4e224bcb27baf8816b039c8bf7c6673`, manifest context 6.3.0. No new primary HEAD, installed-version or release-channel verdict. The lab and historical Gauntlet pins were not reopened.

## New primary sources — S79–S102

Paths are relative to [the pinned source](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797). FULL denotes the complete textual body, not execution or every linked resource. Only S81 was executed by this unit.

| ID | Path | Git blob | Coverage and role |
|---|---|---|---|
| S79 | `scripts/package-codex-plugin.sh` | `5308e28d9c3460b130abd7e3185374294b33d00f` | FULL. Selected Git ref, rootless positive payload selection, prior-package metadata, normalization, path checks and digest. No archive or upload produced. |
| S80 | `scripts/sync-to-codex-plugin.sh` | `bdaa13a357defed6b43e0a769b0ec06e9099b6d3` | FULL, 1–220 and 221–EOF. Working-tree/ignored exclusions, destination overlay/preservation, preview, apply guards and optional commit/push/PR. No mode executed or credentials accessed. |
| S81 | `scripts/bump-version.sh` | `14ead00291407c584f58a437f3acf5be1e772e78` | FULL; exact 7,461-byte transfer rehashed before execution and inside E15. JSON-only synthetic check/audit/bump cases executed; YAML and production layout not run. |
| S82 | `.version-bump.json` | `8df0a9775cc57470a3596805a402c852bbc56e77` | FULL. Nine declared version fields and audit exclusions. Study fixtures use an explicit smaller JSON-only configuration, not this full production layout. |
| S83 | `scripts/lint-shell.sh` | `190db0140d9e250af4cd8edabb42995c0201803c` | FULL. Changed/all/explicit selection, optional formatting, ShellCheck and syntax checks. Not run. |
| S84 | `.devin-plugin/plugin.json` | `8b68f28e4d66152c78e835294504d4666dd93b14` | FULL. Metadata-only manifest/version. Not native discovery evidence. |
| S85 | `.agents/plugins/marketplace.json` | `4e3b4350d5585e4240bb48ac3378f828985f2c8c` | FULL. Development marketplace/local source and policy metadata. No installation. |
| S86 | `.claude-plugin/plugin.json` | `7e0c66154823e7258db20820e99fc0dd82e0479f` | FULL. Metadata and 6.3.0 label; not current marketplace acceptance. |
| S87 | `.claude-plugin/marketplace.json` | `f85d3464bba23ce5100d3510f066fe0b5b62f9c4` | FULL. Local source/development marketplace and version field. |
| S88 | `.opencode/INSTALL.md` | `080f043f8f63e4e5bb44e29bcde84cd9593871a7` | FULL. Git-backed package, migration/update/cache and mapping guidance. Commands not performed; host claims not independently revalidated. |
| S89 | `docs/README.opencode.md` | `11da85425a102a03b7bb598376c5d9e59e6f3276` | FULL. Discovery/injection, cache/update and source-selection guidance. Not current host API qualification. |
| S90 | `docs/README.kimi.md` | `0d7cd74d0b5d65c60ae44d51dcf11691ae1041f6` | FULL. Release versus explicit branch, manifest delivery and fresh-session activation guidance. No Kimi execution. |
| S91 | `tests/antigravity/test-antigravity-tools.sh` | `e10edd42c5002a77b37772a43823fe454b6829e2` | FULL SOURCE ONLY. Mapping/link text assertions; says no installed agy required. Not run or a live bootstrap trace. |
| S92 | `skills/using-superpowers/references/antigravity-tools.md` | `2e1eac90534af6e1f27df4e18410be8a7b442448` | FULL. Subagent mapping and task artifact versus process-management distinction. Target mapping, not current external contract. |
| S93 | `tests/devin/test-devin-plugin.sh` | `16ea31f4d6fab49994d0e92ac73a5f150edcb627` | FULL SOURCE ONLY. Manifest/version/forbidden-field checks and native-discovery account. No Devin or suite execution. |
| S94 | `.pre-commit-config.yaml` | `08fd36d126acd2d5b9ad2dc29c0f83cbb7ebe428` | FULL. Python evals Ruff/format/ty hooks; no observed installation, enforcement or live release. |
| S95 | `.gitattributes` | `def8027c9d57f718d0817f54158d4073b4a8e300` | FULL. Text line endings and binary declarations; no committed export filter. Local info attributes not observed. |
| S96 | `skills/writing-skills/render-graphs.js` | `59e74b54e8538ff0a358d05c770479b3eb8484aa` | FULL. DOT extraction, optional grouping and external dot-to-SVG rendering. Not a workflow executor; not run. |
| S97 | `skills/writing-skills/graphviz-conventions.dot` | `3509e2f028cacaa8118cbc8c80025efb089ec28e` | FULL. Process-diagram naming/shapes/examples. Not rendered or treated as an execution schema. |
| S98 | `skills/writing-skills/anthropic-best-practices.md` | `15ea9eae223d9081b602618849791c07a7758f3d` | FULL TEXT: 1–200, 201–410, 411–640, 641–880, 881–1130, 1131–EOF. Copied reference, 46,197 bytes in prior metadata. Embedded image markup read but remote illustrations not rendered. Not current vendor-policy or efficacy verification. |
| S99 | `skills/brainstorming/spec-document-reviewer-prompt.md` | `60993129de3c445efeff53987b5297dc1acf3eb1` | FULL. Available reviewer template; default S10 calls inline self-review. Presence does not prove mandatory invocation or universal nonuse. |
| S100 | `docs/testing.md` | `414d69790c708df23b3da1ef21365b40f4112ec3` | FULL. Infrastructure/behavior account and named exceptions, historical Python Drill guidance. Not execution or an updated description of the separately pinned Quorum corpus. |
| S101 | `tests/version-bump/test-bump-version.sh` | `195d88a11a4faea7d3844be2a3d7e47ed3b2ed4f` | FULL SOURCE ONLY, read after E15/E16. JSON/YAML happy path and invalid YAML preflight preservation. Not run; no yq installed for this study. |
| S102 | `tests/codex-plugin-sync/test-sync-to-codex-plugin.sh` | `01de3948477d6fa213130562ef0da3517be9e2b5` | FULL SOURCE ONLY: 1–220, 221–460, 461–730, 731–EOF. Temporary-repo/fake-gh preview and refusal/no-op checks plus source assertions. Old hook fixture is not current host behavior. Not run. |

Twenty-four new full textual file reads. This is observed coverage, not a quota or whole-repository completion claim. No extra SKILL body is counted; the original fourteen remain read.

## Re-entry and navigation

- S01 README, blob `09a91c6d03cfa3d874c5c33b6f8cc3d0b2d89645`: FULL re-read for installation channels, updates and testing links. Simplified workflow descriptions do not override prior detailed skill findings.
- S08 porting guide, blob `4ae9603defaf0d9ff052189a33fe515dd2a4ee2e`: direct re-entry at 1–145 and 730–EOF; previous full reading remains recorded. Universal bootstrap framing, native-discovery appendix and old sync route are kept distinct.
- S10's already fully recovered pinned brainstorming text supplies the default inline spec-review comparison. No claim of another new execution or full skill count.
- Full nonrecursive docs tree `06af9f8dc0950f04b5037161ac2b9a3be55fe2e7` and Devin tree `8ba7112d31a60c856f4cacf8bdd20eb98f31b262` were listed. Historical plan subtrees were not recursively read.
- `.agents` bounded recursive tree `5f66635751badfd4a3f23bdd8e7ea58390e020e0` contains its plugins subtree and S85.
- Full test-directory listings: Antigravity `c06d4e1ac1852576a532836de36e72d4091ec972`; Devin `22030e472403437fb912add449ecf6682d1411c3`; version `726ffc9c29f1ff07125989cfe905a276d2951818`; sync `5a008de790b1d7abbea18a0c8c8bf2f89211b954`. Listed run wrappers are not additional executed/read tests.
- Existing root and .github tree observations remain at their original pins. No new administrative branch-rule, current channel availability or latest-release claim was made.

## Supplementary primary documentation

- X08: https://git-scm.com/docs/git-archive — official selected archive/attribute documentation retrieved through web on 2026-09-18. Supports distinction between selected tree content and archive attributes, including repository-local info attributes. Not an exact-version implementation or actual Superpowers packaging test.
- X09: https://git-scm.com/docs/git-status — official selected ignored/untracked/porcelain descriptions retrieved through web on 2026-09-18. Supports the ordinary-status scope qualification, not an actual sync observation. Unrelated search results were discarded.

No vendor best-practices page was silently refreshed or substituted for the copied S98. Current third-party host claims were not promoted from the installation guides. All load-bearing target files came through connected GitHub.

## E15/E16 — actual version-helper experiment

- E15 runner: [evidence/U07B-version-probes.py](evidence/U07B-version-probes.py), 9,454 bytes, local Git blob `63763cce58982ab0c22002ca767765eaaec16f9f`.
- E16 actual output: [evidence/U07B-version-probes-results.json](evidence/U07B-version-probes-results.json), 9,103 bytes, local Git blob `be459537a1e14bbf5f75f4823b5e33d4db88644b`.
- Required S81 source: 7,461 bytes; exact Git blob `14ead00291407c584f58a437f3acf5be1e772e78`, checked before execution and again by the runner.
- Command: `python3 evidence/U07B-version-probes.py /path/to/pinned/bump-version.sh evidence/U07B-version-probes-results.json`.
- Actual environment: Linux, Python 3.13.5, GNU Bash 5.2.37, jq 1.7. Existing tools only; isolated HOME, minimal subprocess environment and temporary fixtures with bounded command timeouts. No actual Git checkout needed by the version helper's tested paths.
- Actual exit 0; eight cases, zero unexpected observation failures, two explicitly unmet stronger criteria. The final result file preserves stdout, stderr, exit and independently read file state. Temporary roots are represented as `<TMP>` in captured text.

C01 normal JSON mutation and C05 malformed-existing-file preflight are positive/protective controls. C02 distinguishes check failure from advisory audit success. C03 supplies a missing middle file and demonstrates incomplete inventory despite a zero bump exit. C04 moves the missing entry to the end and observes nonzero exit after prior writes. C06 retains an undeclared old-version file through a post-bump current-string scan; C07 proves current-string matches can be reported. C08 rejects an exit-code-only completeness oracle.

Two study-defined stronger criteria remain false: zero bump exit implies all declared files at the requested version; post-bump all-clear implies no unregistered old-version manifest. The actual source prints missing/drift/SKIP messages, so no blanket concealment claim is made. Other cases are mechanism/scope observations, not product passes.

The criteria were selected after source inspection and before execution. This is exploratory exact-helper evidence, not preregistered independent replication or a generalized reliability rate. S101 was read afterward and not executed. The study did not exercise YAML, the nine-manifest production layout, package assembly, sync, upstream suites, real releases or host/model behavior. E01–E14 remain unchanged and were not rerun.

## Acquisition, control and canonical recovery

A single raw-source acquisition attempt failed at container DNS resolution. No clone/archive or dependency installation was obtained. Only S81 was manually transferred for execution, then independently checked against its returned Git blob. Draft/publication workspace files are not additional experiments.

AGENT was freshly fetched unchanged. Required assumption, influence, goal, verification, source-fidelity, preflight and candidate-library protocols were fully recovered; full same-conversation causal-depth and continuity protocols remained available. Control files are not research evidence and were not modified.

Current STATE, META, METHOD, PLAN and the previously missing full U06-B1 register were freshly read. The original and other chronological registers, B2 note, S01 and U07-A note/register were available as actual full canonical same-conversation text, with earlier truncations recovered by their recorded ranges. Prior summaries alone were not substituted for required source bodies. INDEX/CATALOG must be refreshed at publication before changes.

## Findings, coverage and return

[U07-B](notes/U07B-distribution-versioning-and-support.md) records F73–F79 and Q44–Q46. Its coverage disposition distinguishes completed bounded source families from unexecuted host/release behavior and selectively deferred historical/tests/assets. U07 is now explainable at the selected source/local scope; U08 still owes native composition, current project-facing research and CORE/omission/freshness challenge.

The new findings do not certify reproducible packages, legitimate external metadata, actual loaded revisions, release admission or improved model outcomes. Same-label and source-permalink provenance are qualified, advisory diagnostics are not promoted to gates, and failed exits are not assumed to roll back effects.

Only this study and necessary derived discovery maintenance are authorized writes. METHOD, older source registers/notes/evidence, S01, other studies, Foundation, Development OS, agent-control and upstream repositories remain protected. STATE owns actual publication status and the next U08 responsibility.
