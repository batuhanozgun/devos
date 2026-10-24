# Superpowers — Source Ledger Supplement U06-B1

Observation date: 2026-09-17. Additive continuation of [SOURCE-LEDGER.md](SOURCE-LEDGER.md), [U03](SOURCE-LEDGER-U03.md), [U04](SOURCE-LEDGER-U04.md), [U05](SOURCE-LEDGER-U05.md) and [U06-A](SOURCE-LEDGER-U06A.md). S00–S69, D01–D03 and E01–E12 are preserved. STATE owns work and completion.

Primary corpus remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`. Evaluation dependency remains `prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b`, root tree `38d962c27c78a4ba692fe3c0f8ec6ebb8f80a059`. No new HEAD check, repin, installed-version or release-qualification verdict was issued.

## D02 completion

The external README, blob `1280de9c88405cd1fa202d6c0e8fb057a5730e00`, is now FULLY READ: the actual 1–165 content recovered in U06-A remained available, and U06-B1 read 166–380 and 381–EOF. This advances D02 reading coverage, not the evidence class of README claims. Its generic actor count, routine-use grader selector and parent-submodule instruction are compared with more specific source/configuration, not accepted automatically.

## Evaluator source register

All paths below are relative to [the pinned evaluation source](https://github.com/prime-radiant-inc/superpowers-evals/tree/e64684cd1fa270c464ac797747e45bbe8d127e8b). FULL means through the returned EOF, not execution. A numbered range means only that part is claimed as deliberately recovered.

| ID | Path | Git blob | Coverage and role |
|---|---|---|---|
| D04 | `ABOUT.md` | `4c527492557d225320f7f226e6a57ade2dcf02ec` | FULL; experimental lab orientation and Gauntlet/Obol dependencies. Generated project-map text, not implementation proof. |
| D05 | `SECURITY.md` | `8747e49c2a661e46b8ada67f677bca8b5c4d51a3` | FULL; static/live separation and sensitive-artifact boundaries. No private artifact or credential read. |
| D06 | `CLAUDE.md` | `c7215bce581355346c2fecd337a5c250b48fa865` | FULL; initial 1–180 response truncated, overlapping 95–EOF recovered the tail. Evaluator contributor/architecture data, never active agent-control. |
| D07 | `package.json` | `b7e7d1feee6f53a45c3e9c73a44c43464bf38f03` | FULL; Bun/TypeScript scripts and dependencies. No installation/build or check execution. |
| D08 | `docs/scenario-authoring.md` | `11aacadcbfa70c7cf6805683b540a180bc532dab` | PARTIAL 1–180: conversation topology, projections, capture/check/assessment claims and scenario anatomy. Remainder not read or treated as absent. |
| D09 | `src/composer.ts` | `43847a8abfcdac5b292db1e96951b24d59bc879b` | FULL; error/precondition/assessor/capture/manifest precedence and final pass/fail/indeterminate. Not executed. |
| D10 | `suites/conversation_routine_use.yaml` | `dc1d5796f4603fb3482fd022b789cafcec4e0529` | FULL; comparison identities, n=2, bounds and grader selector. Definitions, not observed attempts/results. |
| D11 | `scenarios/conversation-code-review/story.md` | `558ddef50002c20a4e437c225e19945d4d1be03e` | FULL; natural review request, private delivered-result/grounding criteria, no mandatory skill/tool/test. Stimulus/rubric, not response. |
| D12 | `scenarios/conversation-code-review/checks.sh` | `1e11d4260d6449f5ec8192ef4fa642878a840eeb` | FULL; five pre-checks and one post-check invocation, limited agent list. Not run. |
| D13 | `scenarios/conversation-code-review/oracle.cjs` | `e7ed7216fc72908726545852732a975f144b1c58` | FULL; fixed SHA-256 target preservation, explicit findings-assessment disclaimer. No local oracle execution. |
| D14 | `scenarios/conversation-code-review/setup.sh` | `de69a07024e483c7275119ab6433570669a8309a` | FULL; named planted-code setup-helper entry. No fixture instantiated. |
| D15 | `arms/conversation_claude.yaml` | `c2b77ec16cbab0ae3b8d28094b22e91fd89c859c` | FULL; exact primary b36e0829 target, agent/credential/effort settings. Not materialization evidence. |
| D16 | `arms/conversation_claude_stock.yaml` | `158a1990350f95112a78d93b727517bed3c08433` | FULL; same settings with explicit superpowers none. No realized no-treatment run verified. |
| D17 | `src/agents/superpowers.ts` | `19bb7dee55142a2fa48cde045c9d221957cbb97c` | FULL; explicit none/root versus ambient legacy, projected env and launcher arguments. Not every adapter implementation. |
| D18 | `src/runner/index.ts` | `bfe30dbb10fd4a72c3081f2cb9d0661a2ffa0f9c` | PARTIAL: 1–210, 950–1130, 1170–2100. Imports, selected context substitutions, runScenario publication, preflight/config/manifest/provision/setup/pre-check and prepared-conversation handoff. Other helpers and legacy/backend paths not fully read. |
| D19 | `src/runner/conversation.ts` | `40f0f6741a573d8d6ae59138ab7c41e28fce759a` | FULL in contiguous 1–220, 221–440, 441–EOF. Projection/invocation, visible endpoint, capture/copy/index, post-checks, assessment/result consistency and accounting handoff. Not live execution or all imported validators. |
| D20 | `src/runner/conversation-input.ts` | `5aa5979381ad8fb9fb11ca3e6ade2af83161055f` | FULL; separate brief/rubric and validation; excludes assessment allowance metadata from rubric. |
| D21 | `src/setup-helpers/behavior-fixtures.ts` | `01848b52e564b460eaf905d60f202fb56e48c917` | PARTIAL; exact 171–260 re-entry covers planted source constants and createCodeReviewPlantedBugs; initial larger response was truncated. Other fixture families not part of B1 claims. Registry/CLI dispatch not newly audited. |
| D22 | `src/check/manifest.ts` | `f69528717336e872d56cdb59eeda426227f497e4` | FULL, 1–220 and 221–EOF; conservative extraction, wildcard args, optional manifest, multiset comparison. Importing dispatch/schema modules is not full reading of them. |
| D23 | `src/capture/output.ts` | `9ae178480c6ea601e0c4fd3e97d6df5463ab4990` | FULL; selected file snapshot and symlink/exclusion rules. Not all session-capture/normalization or immutable sealing. |
| D24 | `src/contracts/conversation.ts` | `528a7089ab9da12f97e84c5cca8368d6fbb8e893` | FULL; endpoint/visible evidence, normalized indexed paths, duplicate rejection and role process records. Schema validity is not semantic correctness. |
| D25 | `scenarios/conversation-code-review/checks-manifest.json` | `6d0e67e160ce8243ecabb406723a3aaff5e8f523` | FULL; exact phase/count definitions and wildcard command arguments. Derived expectations, not independently established oracle truth. |
| D26 | `src/checks/index.ts` | `600574c3493718ff9d9b0717d24d34fda0364c53` | FULL, 1–240 and 241–EOF; env projection, subprocess/record classification, crash handling and directives. No check phase run. |
| D27 | `src/runner/gauntlet-role.ts` | `331f4a5aae8ab7553908458bf228b9aa8d22a2a9` | FULL, 1–220 and 221–EOF; separate external role launch/lifecycle, deadlines, runtime cleanup and completion-validator calls. Quorum wrapper, not Gauntlet implementation. |

The register contains 24 new dependency-file entries; three are explicitly PARTIAL. No primary S-series file was newly added. File counts are not mechanism-completion criteria.

## Navigation

- Selected scenario directory was listed: story, setup, checks, oracle and checks manifest; all five bodies subsequently read.
- Arms tree `416c603fbf60e821b87361caa05f49344dc74e87` was read non-recursively (complete first JSON copy, `truncated:false`). Only the named Claude stock/treatment pair was source-read. Other listed arm names are not model-availability or execution evidence.
- Source paths were followed from the recovered README/contributor guide, source imports and scenario references. Large outer-runner/fixture files remain explicitly partial rather than represented as complete repository coverage.
- Gauntlet is identified as a transitive binary dependency. No Gauntlet source/result was used; its relevant revision must be pinned in B2 before such use. Obol accounting and all-harness adapters likewise remain outside full implementation coverage here.

## Web and acquisition

A web search for the named public lab returned official GitHub README/security pages and third-party mirrors. Only the official pages were used for discovery/cross-checking; pinned connector sources carry the findings. Current search snippets, including an older submodule account, were not substituted for exact source. No claim of a fresh primary HEAD or runtime API was made.

A targeted raw package.json acquisition through the container failed at DNS resolution. Connected GitHub recovered its full body. No clone/archive, install, model/API call, live agent, upstream test, synthetic scenario, oracle run or private transcript inspection occurred. The local draft directory is publication workspace, not an experiment.

## Evidence accounting and interpretation

**No new E identifier.** E01–E12 and their failed criteria remain unchanged. This round produced code/configuration observations, document/code comparisons and bounded inferences; not measured efficacy, CI status, cost or model performance.

The declared Claude treatment exactly matches the primary b36e0829 corpus. The stock pair differs by explicit none while retaining the declared agent/credential/effort. This establishes intended correspondence, not immutable materialization or actual loaded bytes. The suite grader/README selector difference and parent-submodule/ignored-directory seam remain explicit.

The selected review rubric accepts no particular skill/tool path, requires useful grounded findings, and rejects unsupported additional assertions. The source-level oracle measures only one file's preservation. Brief/rubric projection, selected evidence copying, visible endpoint retention, structured checks, optional manifest consistency and verdict composition are distinct mechanisms. Their existence does not qualify Gauntlet's judgments.

The code permits attempted assessment after a recorded checker error even though the guide describes no grading on checker crash; final composition remains indeterminate. This is not an observed false pass or measured wasted-call incident. Some missing-evidence/cancellation paths do stop before assessment.

## Recovery and publication

Current AGENT, STATE, METHOD, original source ledger, META and PLAN were freshly fetched. Mandatory protocols and the full U03/U04/U05/U06-A source supplements and U06-A note were available as actual same-conversation canonical tool text, not only prior summaries. Truncation in the original ledger was repaired with overlapping exact ranges. Current STATE/PLAN agree on U06-B and research-only authority.

No agent-control file is research evidence or was changed. The research package is the only substantive write scope; necessary shared-catalog maintenance must preserve every unrelated entry. Publication readback/scope checks establish transfer and continuity only, not independent research validation.

## Next retrieval

[U06-B1 note](notes/U06B1-evaluation-evidence-and-verdict.md) records F50–F57 and Q35–Q37. U06-B2 remains open for the relevant pinned Gauntlet producer, exact rubric/citation coverage, imported assessment-completion/role-usage contracts, actual capture normalization, campaign materialization and one sanitized public result with exact subject/evaluator correspondence. Remaining CI/release qualifications are still open; U07 owns supporting runtime/materialization coverage and U08 native synthesis/project-facing projection.
