# Superpowers — Source Ledger Supplement U06-B2

Observation date: 2026-09-17. Additive continuation of the [original ledger](SOURCE-LEDGER.md) and [U03](SOURCE-LEDGER-U03.md), [U04](SOURCE-LEDGER-U04.md), [U05](SOURCE-LEDGER-U05.md), [U06-A](SOURCE-LEDGER-U06A.md), [U06-B1](SOURCE-LEDGER-U06B1.md). Previous S00–S69, D01–D27 and E01–E12 remain unchanged. STATE owns current work and completion.

Primary remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, root tree `21219529a4e224bcb27baf8816b039c8bf7c6673`, manifest context 6.3.0. Lab remains `prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b`, root tree `38d962c27c78a4ba692fe3c0f8ec6ebb8f80a059`. No primary/lab HEAD repin, installed-version or release-acceptance verdict was produced.

## Lab additions — D28–D37

Paths are relative to [the pinned lab source](https://github.com/prime-radiant-inc/superpowers-evals/tree/e64684cd1fa270c464ac797747e45bbe8d127e8b). FULL means source reading through EOF, not execution. Public reports retain their authors' epistemic status; their private underlying artifacts were not authenticated by this study.

| ID | Path | Git blob | Actual coverage and role |
|---|---|---|---|
| D28 | `src/runner/assessment-completion.ts` | `34a870287f28874066e57cdd65804b38d12c8e03` | FULL. Run/directory identity, completion/digest consistency, result-byte digest and row/status validation. Consumer contract, not semantic re-grading. |
| D29 | `src/runner/role-usage.ts` | `8bd00810be8996985df4ac4837912c174773bb83` | FULL, 1–240 and 241–EOF. Logical/physical request identity and settlement reconciliation; known usage, report eligibility and complete cost coverage separated. Not executed or independently priced. |
| D30 | `docs/experiments/2026-09-10-conversation-code-review-smoke.md` | `b5e4bacc4b80b7ff5460c2f214035a6760f78abe` | FULL. Public author-reported initial campaign, retained-submission parser repair and fresh rerun. Exact primary treatment and historical evaluator references; all-pass/fail-side and sample limitations. Not our experiment or raw-run verification. |
| D31 | `docs/experiments/2026-09-10-assessor-triage.md` | `6bdb9d125966c702a9e74bb25a8b924e463af46d` | FULL. Public report of accounting-reader correction, native semantic grounding misses and six assessor-only diagnostic cases. Private full bundles/receipts were not accessed. No general reliability rate inferred. |
| D32 | `src/campaign/registration.ts` | `b10edaabdef200df635599ca8bd117167ffcad82` | PARTIAL, 1–220. Imports and initial registration/identity contracts; navigation to snapshot/comparison dependencies. Not a full registration, qualification or campaign-execution audit. |
| D33 | `src/campaign/comparison-input.ts` | `bfd76de598516dbe4ae25f4c851a9ecc0db53749` | FULL. General baseline/candidate pairing helper, canonical arm construction and template-role validation. Not assumed to be the selected stock smoke's actual runtime path. |
| D34 | `src/campaign/snapshot.ts` | `c5a997c4b1e0a06e170e44e45ecf158658e9b094` | FULL. Evals/Gauntlet snapshot handoff, distinct non-null subject SHA worktrees, reconstruction versus registered references and verification delegation. Imported instrument-snapshot implementation not fully read. |
| D35 | `src/campaign/provisioning.ts` | `5fa55a2155f6843e8683c9e52e96a220748d5ac1` | FULL. Initial response truncated during stale-lock explanation; overlapping 350–EOF recovered the tail. Full-SHA validation, ownership-aware lock, detached worktree creation/reuse and failed-creation cleanup reporting. Not executed or concurrency-qualified. |
| D36 | `.github/workflows/test.yml` | `e7b69bb46e8014a184b21fe933c3c2f33480c51c` | FULL. PR/main-triggered static/type/unit and scenario checks, pinned Bun installation and frozen dependency lock. No live campaign invocation in this workflow. No actual CI run inspected. |
| D37 | `docs/experiments/2026-09-10-repeatable-pr-release-validation.md` | `0217f76c471bf33cc0f249fe4aa13b9643d62f77` | PARTIAL, 1–160. Latest opening focused-path report after PR69 and start of preceding PR68 account. Actual latest run timestamps are 2026-09-12 despite older filename/heading dates. Reported executable checks, preserved failures/disputes and uncalibrated grader; private files and remaining historical document not read. |

Ten new lab file entries: eight full and two explicitly partial. Prior B1 partial files remain partial unless a later entry explicitly advances them. D18's outer runner, D21's fixture library and D08's scenario-authoring remainder were not silently promoted to complete.

D30's reported smoke uses historical Evals revisions `1139abd8` / `041e1b27`, not the later repository snapshot carrying the note. D31 names Quorum `a098eb3a156f086de41be6cc315b75ff77d7cf55`. D37 names Evals `bc8cce83dc42ab6e8ca92ce54624512d92c30617`, Gauntlet `aa08b72989fe59c57362c42f5d1bfe2c26417253`, primary b36e0829 and candidate `3a8bdc11e1db42955350d6d6f063f7a8e89aef58`. These are identities reported in those sources, not newly checked binaries or fully inspected additional corpora.

## Gauntlet — separately pinned transitive source

The pin follows D30's repaired rerun rather than a newly fetched default branch:

- Repository: `prime-radiant-inc/gauntlet`.
- Resolved commit: `db6c8e0fcf80889aa6d9631c99adec698f6c0caa`.
- Committer timestamp: `2026-09-10T19:09:36Z`; author timestamp `2026-09-10T19:04:19Z`.
- Root tree: `bffd36a8bc682081eb813a1a92a4a5d27fa06083`.
- Source base: https://github.com/prime-radiant-inc/gauntlet/tree/db6c8e0fcf80889aa6d9631c99adec698f6c0caa

| ID | Source | Identity / actual coverage |
|---|---|---|
| G01 | Commit resolution for D30's `db6c8e0f` | Full commit identity/metadata resolved through the ordinary commit endpoint. A short-SHA Git-data endpoint returned 404 first; no repository-access failure or current-HEAD conclusion follows. |
| G02 | `docs/superpowers/specs/2026-09-10-assessment-report-criteria-repair-design.md` | Blob `8f192f0023ee457fe5032e5e0a3e08fae6201ba8`, FULL. Design still labeled draft; intended recovery, unchanged validation, visible repair and residual multiple-block limits. Actual implementation checked separately. |
| G03 | `src/assessment/report.ts` | Blob `8ed7084a55aa0263fa4acc9832d04900bd0938f0`, FULL. Exact row count, canonical text by position, required fields, exposed-reference checks, derived status and optional markup recovery. Imported generic validator not fully read here. |
| G04 | `src/assessment/assess.ts` | Blob `599c913e3d5a14dd237a95c391582dc89826161c`, FULL in 1–240 and 241–EOF. Fresh message array, two model-facing tools, pending/exposed read chronology, rejection/repair handling, decision and publication callback. No model call or SDK/runtime qualification. |
| G05 | `src/context/scoped-read.ts` | Blob `c2f8ab9ea519fe44e5cf501c47770d3e72f4dc42`, FULL. Indexed normalized relative paths, containment/regular-file checks, duplicate and final-symlink handling. Scoped tool read, not universal OS sandbox. |
| G06 | `src/assessment/completion.ts` | Blob `8b186f9b6b062121ff640c7f1233c5a7809c3409`, FULL. Result/publication identity, atomic-file operations, finalization callback, no-replace marker, result digest and error publication. Imported evidence writer not fully audited. |
| G07 | `src/format/story-card.ts` | Blob `506148412a27b70ec767b70499f434b0ffc3f251`, FULL. Frontmatter/body parsing, bullet criteria with continuation lines and heading termination. Not arbitrary prose-requirements extraction. |
| G08 | `test/assessment/report.test.ts` | Blob `041dfd27b21cb2442f5e3d17a5083724ffc1454e`, FULL in 1–240 and 241–EOF. Parser/repair/field/count/reference/derived-status tests, including acceptance of repeated valid rows. Read, NOT run. No live semantic-grading evidence. |
| G09 | Exact comparison and complete changed patch from G01 to `25a2e3e00431f8d8eb63781162ccb974d43d5405` | One intervening commit, named by D31. Four changed files: report schema metadata, Anthropic provider conversion, shared ToolDefinition and provider wire tests. Strict input metadata is conditional on direct API-key routing. Assessment loop/scoped reader/completion/story parser unchanged in this comparison. Full provider files and test suite not run or fully read. |

Seven full Gauntlet file reads plus identity/delta records. Gauntlet was not registered as a new standalone study or adopted dependency. G09 does not retroactively change the G03 pin or establish live provider support. D37's later Gauntlet revision is a public-record reference only, not another source pin used for implementation conclusions.

## Primary source navigation addition

**S70 — `.github` non-recursive tree**, primary pin, tree `37fbdb3953b7ebcd62a4555822985a3111b26980`: complete response with `truncated:false`. Contains FUNDING, ISSUE_TEMPLATE and PULL_REQUEST_TEMPLATE, with no tracked workflows entry at this snapshot. No new primary file body was read. This does not establish the absence of external CI, organization policy, branch protection, maintainer gates or historical release checks.

## Navigation, acquisition and omitted dependencies

- Lab docs tree `40cac271102d1cc78565584ab19a3f89786a7f34` fully listed.
- Experiments tree `26c9c4ffe2f914461483e454577a85e0caae29aa`: initial tool view truncated; response-resource search recovered the complete first JSON copy through `truncated:false`. Only D30/D31/D37 were read for findings; directory presence does not constitute other campaign review.
- Gauntlet `src/assessment` listing exposed four files. `lifecycle.ts` was listed, not read; other imported provider, logging and generic validation paths remain outside full coverage.
- Lab `.github` tree `ad66b30d0635d96b3bc4853af03c21c98c68ad06` and workflows tree `6651cfcb94674d99d254b1d8dbb8da1d3bcf876b` fully listed; the latter contains only D36.
- No private transcript, credential file, evidence receipt or machine-local campaign directory was opened. Machine paths printed in public notes are reported pointers, not accessible sandbox files or authenticated evidence supplied to this study.
- Connected GitHub carries all load-bearing sources. No web search result is used for substantive findings in this register. A container acquisition attempt failed at DNS; no clone/archive or dependency installation was obtained or needed.

## Execution and evidence accounting

**No new experiment and no E13.** E01–E12 were not rerun or modified. No upstream script, parser, oracle, CI suite, live agent, paid/provider call, installation, upstream issue or PR was performed. G08's tests and G09's wire assertions are source observations only.

D30/D31/D37 are public first-party experiment reports. Their numerical results, reported diagnoses and author audits remain attributed claims at that evidence layer. They are not our raw-data replication, human gold labels, production incident observations or general product scores. Reported retained-case repair and a reported fresh rerun are different evidence classes; the first does not independently validate itself.

B2's own findings are source-level contracts, code/record comparisons and qualified interpretation. A published result and a digest-valid report cannot independently establish semantic correctness. A later uncalibrated-grader report is not ignored merely because earlier instrument checks passed.

## Recovery, publication and bounded closure

AGENT was fetched fresh and unchanged. Applicable protocols were available as full canonical same-conversation text; causal-depth and work-continuity protocols were freshly recovered in full. They are control material, not research evidence. Current STATE was freshly read; the missing U04 source supplement was freshly recovered completely. Required METHOD, META, PLAN, other source volumes and B1 note were available as full actual canonical source text from this conversation. INDEX and shared CATALOG were refreshed for publication; truncated views require tail recovery before writing.

The new [B2 note](notes/U06B2-assessor-contracts-and-evidence-qualification.md) records F58–F64 and Q38–Q40. The first [native subsystem synthesis](syntheses/S01-skill-evolution-and-evaluation.md) combines U06-A/B1/B2 without promoting source observations or public claims to independent efficacy evidence.

U06 closes as a bounded authoring/evaluation source inquiry with explicit empirical applicability limits. This does not weaken an evaluation threshold or certify the grader. The result explains the mechanism and the remaining evidence obligations; a full external platform audit is not necessary to support that result. Packaging/update and remaining release materialization belong to U07; full-system synthesis and project-facing projection remain U08. No new percentage, adoption decision or Foundation classification is established.

Current publication status and exact handoff belong to STATE. Old source registers, notes, evidence and METHOD remain preserved.
