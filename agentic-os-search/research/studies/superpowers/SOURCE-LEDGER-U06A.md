# Superpowers — Source Ledger Supplement U06-A

Observation date: 2026-09-17. Additive continuation of [SOURCE-LEDGER.md](SOURCE-LEDGER.md) and the [U03](SOURCE-LEDGER-U03.md), [U04](SOURCE-LEDGER-U04.md), [U05](SOURCE-LEDGER-U05.md) supplements. S00–S57/E01–E12 and earlier notes remain unchanged. STATE owns current work and completion; this file records source identities and observed coverage.

Primary corpus remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, root tree `21219529a4e224bcb27baf8816b039c8bf7c6673`, manifest context 6.3.0. No new primary HEAD/release/installed-version verdict was issued. The separately pinned evaluation dependency below is not a repin or automatic compatibility result.

## Twelve new full primary-file reads

Paths relative to the pinned [primary source root](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797).

| ID | Path | Git blob | Coverage and role |
|---|---|---|---|
| S58 | `skills/writing-skills/SKILL.md` | `f33f39f523c8a3ae2ec0eaf365a524571df8ff3d` | FULL in contiguous ranges 1–230, 231–460, 461–EOF; 26,360 bytes in metadata. Intervention selection, trigger/body separation, failure-specific guidance, no-guidance micro-tests, pressure/revision/deployment contract. Not executed. |
| S59 | `skills/writing-skills/testing-skills-with-subagents.md` | `a5acfeac86f34c7bc625d064e10c8a2f8180b696` | FULL; discipline-pressure setup, exact rationalization capture, same-scenario revision, meta-testing and historical efficacy claims. No subagent/model run. |
| S60 | `CLAUDE.md` | `5f3d7410f82cb3d348a80cbd59c359da9f75e6d8` | FULL; contributor admission, real-problem provenance, human diff review, dev target, harness transcript and external eval route. Research object, never active agent-control. Rejection/efficacy statistics unvalidated. |
| S61 | `.gitignore` | `efa95832b9a3e91fe87b2ce3b2d568cfba4cbeaa` | FULL; explicitly excludes the separately cloned development evals directory from the plugin. |
| S62 | `.github/PULL_REQUEST_TEMPLATE.md` | `2ec951316ff237ebd2829283bdbc74ff265de1e1` | FULL; actor/environment provenance, experienced problem, alternatives/prior art, before/after evals, clean-session transcript and human review. No PR or enforcement test. |
| S63 | `skills/writing-skills/persuasion-principles.md` | `9756416a59600b70ecca4044e0919ee7d4a37b21` | FULL; typed persuasion recommendations and ethical boundary. Borrowed paper statistics/psychology remain target claims; cited paper/book not reviewed here. |
| S64 | `skills/writing-skills/examples/CLAUDE_MD_TESTING.md` | `47881fc85bd6c01b32b84d52ed9a0c73c8d6a089` | FULL; four scenarios, NULL and four variants, proposed protocol, expected outcomes and future work. Not a completed results dataset. |
| S65 | `skills/systematic-debugging/CREATION-LOG.md` | `9aa03092809feaf93c9bfa985252f6f1c9624692` | FULL; historical 2025-10-03 extraction/iteration narrative and reported test success. No recovered raw run evidence. |
| S66 | `skills/systematic-debugging/test-academic.md` | `23a6ed7a2044e0c44d74c3101406140f4851aa41` | FULL; recall questions based solely on skill content. Stimulus, not observed response. |
| S67 | `skills/systematic-debugging/test-pressure-1.md` | `8d13b467e4a98abfffd12161cbc3c418021d6023` | FULL; emergency/economic pressure and A/B/C choice. No real incident or agent execution. |
| S68 | `skills/systematic-debugging/test-pressure-2.md` | `2d2315ec8a24ca872bc80d2f4056468ba051462a` | FULL; sunk-cost/exhaustion/timeout scenario. Stimulus only. |
| S69 | `skills/systematic-debugging/test-pressure-3.md` | `89734b86fdc756488df315d53e5c3ac2d3752cd8` | FULL; senior/lead/social-pressure scenario. Not actual organizational authority or observed behavior. |

S58 is the fourteenth of the fourteen originally observed SKILL bodies to be read fully. This is a file-coverage milestone, not fourteen qualified subsystems, complete dependency reading or whole-study closure. The five previously unread debugging history/scenario files are now read; earlier U04 source coverage is not retrospectively rewritten.

## Navigation and deliberately unclosed supports

- Primary root tree `21219529a4e224bcb27baf8816b039c8bf7c6673` was read non-recursively again, with `truncated:false` in the complete first JSON copy. There is no tracked root evals entry. This supports S61's explicit external-development-directory explanation; it does not imply absence of evaluation elsewhere.
- `skills/writing-skills/` directory listing was fully visible in the first JSON copy. It exposed S58/S59/S63, examples tree `e8157a4fc560750a28fce72685f7ce7aee8c9667`, and unread supports below. A repeated wrapper copy was truncated; it was not needed to reconstruct the listing.
- Listed, NOT read: `anthropic-best-practices.md`, blob `15ea9eae223d9081b602618849791c07a7758f3d` (46,197 bytes); `graphviz-conventions.dot`, blob `3509e2f028cacaa8118cbc8c80025efb089ec28e`; `render-graphs.js`, blob `59e74b54e8538ff0a358d05c770479b3eb8484aa`. These are reference/rendering supports, not evidence for F43–F49. Re-enter when their claims or execution become material in B/U07/closure.
- S64's exact path was obtained from S59 and fetched directly. No extra content under examples is claimed as read.
- Earlier S42/S43 description-test and S56/S57 native-preference/source-policy findings are retained from the full source reads already available in this conversation. They were not rerun or newly counted. Current integration tests/CI/release implementation remain U06-B/U07.

## Separately pinned evaluation dependency — D series

Repository: `prime-radiant-inc/superpowers-evals`.

| ID | Source | Identity and actual coverage |
|---|---|---|
| D01 | `refs/heads/main` and Git commit metadata | Observed on 2026-09-17 at commit `e64684cd1fa270c464ac797747e45bbe8d127e8b`; committer timestamp `2026-09-12T00:49:23Z`; author timestamp `2026-09-12T00:44:39Z`; root tree `38d962c27c78a4ba692fe3c0f8ec6ebb8f80a059`. Metadata read fully. The commit message's run/cost/check narrative is a claim, not evaluated results. |
| D02 | `README.md` at D01 | Blob `1280de9c88405cd1fa202d6c0e8fb057a5730e00`, 30,018 bytes. PARTIAL: exact lines 1–165 recovered after an initial oversized/truncated view. Supports only lab orientation, static/live distinction, stated risk boundaries and described conversation/assessment/control-arm workflow. Not full README or implementation reading. |
| D03 | Non-recursive root tree | `38d962c27c78a4ba692fe3c0f8ec6ebb8f80a059`, complete first JSON copy with `truncated:false`. Navigation only: src, test, scenarios, suites, arms, docs, packages, container, results and scripts exist. No recursive coverage, credential-file read or results inspection. |

Canonical pinned entry: https://github.com/prime-radiant-inc/superpowers-evals/tree/e64684cd1fa270c464ac797747e45bbe8d127e8b

D02 uses the name Quorum; S60 uses Drill. The newer dependency snapshot is not established as the exact historical evaluator for b36e0829. Neither naming difference alone nor a current README demonstrates a behavioral change. Subject/evaluator/version correspondence must be recovered in U06-B.

D02 says live runs may use broad execution permissions and credentials and explicitly distinguishes per-run HOME isolation from a sandbox. No setup, installation, credential acquisition, live CLI, API/model call or private campaign was performed. These are target descriptions, not current host-security certification. The disclosed newer stock/treatment and fresh-assessment design is a lead, not an independently verified mechanism.

No transitive evaluator implementation was used. Pin such dependencies separately if later source analysis makes them load-bearing. Do not open raw secret-bearing files merely because they appear in a source inventory.

## Supplementary primary specification — X07

https://agentskills.io/specification — directly retrieved through web on 2026-09-17. The search query returned no results; the direct official page succeeded. Selected format/frontmatter/name/description and progressive-disclosure sections were read. This is current specification context, not a snapshot-matched historical standard or host execution result.

Used narrowly to distinguish the specification's lowercase name and description-field length requirement from S58's local illustrative/frontmatter wording and trigger-only method preference. No validator was installed or run. The primary target's copied vendor best-practices document was not silently substituted for this page. F44 does not infer a product incompatibility from a guidance difference.

## Execution and evidence accounting

**No new behavioral or script experiment.** E01–E12 remain preserved and were not rerun. No new E identifier, model-generated answer, test pass count, CI verdict, actual PR or release result is claimed. Files and scenarios were read as source objects.

A temporary local drafts directory was created for publication work; this is not an experiment or installed target. Repository writes below are research publication, not a Superpowers development workflow under test.

The main evidence distinctions are source-defined contract, analyst inference, historical author claim, proposed/expected outcome, and partially recovered external orientation. There is no independent behavioral replication in this unit. A clean publication readback cannot upgrade those evidence classes.

## Canonical recovery and continuity

AGENT was freshly read and unchanged. The nine applicable protocols had already been read fully in this same conversation and their actual texts remained available; no remembered substitute was needed. Agent-control files were neither changed nor used as research evidence.

Current STATE, META, PLAN and the previously unavailable U05 source supplement were freshly read. METHOD, original/U03/U04 source registers and U05 note had already been read fully in this conversation and remained available as actual source text, not only prior conversational conclusions. State and plan agree on U06; U05's old next-action remains a historical handoff into this unit. No earlier experiment is reinterpreted as a new run.

U06 was split into A (authoring/admission, bounded source complete) and B (evaluation implementation, compatibility and remaining release qualification, next). This is an evidence-led plan revision, not whole-U06 completion or a new architecture authorization. METHOD v0.1 and study closure criteria are unchanged.

## Results and next retrieval

[U06-A note](notes/U06A-skill-authoring-and-change-admission.md): F43–F49, partial native authoring loop and Q30–Q34. Current STATE/PLAN/INDEX/META route to this supplement in addition to earlier volumes.

For U06-B, complete D02 README and follow the pinned dependency's ABOUT, CLAUDE, SECURITY, package scripts and actual scenario-authoring/source/test paths as project data. Trace one scenario through subject provisioning, interaction/capture, independent checks, assessment and final reporting. Resolve source-revision correspondence before using any results as evidence about the primary target. Retain unexamined CI/dev-to-main release paths and authoring reference/rendering support coverage for explicit later closure.
