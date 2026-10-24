# U05-B — Publication receipt and maintenance outcome

**Date:** 2026-09-17. Publication/access and same-assistant consistency checks, not independent research validation. STATE owns current work; earlier receipts remain unchanged.

## Actual publication

| Action | Identity / result |
|---|---|
| Publication parent / root tree | `8bdcce7af6228cbad7eae03d5c5e01074e65289b` / `7465b4aeb17c04d3ff45583dbf96e60bffaa9176` |
| Twelve-file research/evidence tree | `69ef42b006160f21453e47b9529e54502d9e51a4` |
| Research commit | `e0ccfd22f170bb90d1363e68b168f420eba81018` |
| Own-repository branch / PR | `research/ecc-u05b-20260917` / PR #10 |
| Expected-head merge to main | `bbbfe5ae8da65eeca52d50d9a4dbe3f21cc9dfae`, merged=true |
| Initial catalog update | `4a93f3d3d2315896bdcae73acb73f22828f68577` |
| First catalog restoration | `3e6fd61148e4b52c590617fa4a5804743f7141f9` |
| Byte-verified final catalog repair | `9addefafbdec3af0d21717cfacd61acbb5f4cc59`; main advanced with force=false |

PR #10's changed-file list was checked before merging: five current entry files, Note08, U05-B source ledger, ROUND-U05-B and four E04 artifacts, all within ECC. The own-repository PR is publication plumbing, not independent review or an upstream ECC contribution.

Compare publication parent to final catalog repair shows exactly those twelve ECC paths plus CATALOG. Compare the merge to the repair shows CATALOG alone, +1/−1: the final net change is the ECC row. Previous notes, experiments, METHOD/WHY, old master histories, Foundation, control files and other studies were preserved. The shared library INDEX already had a generic ECC route and was not rewritten.

## Actual readbacks and evidence identities

| Main artifact | Blob / completed check |
|---|---|
| Note08 | `9a52a3d9aefa334c1ec3999a5418d29daae3e48a`; full 1–65 and 66–EOF |
| U05-B source ledger | `77f64f8a93a8aae9d13cbcaa7ec4d46dd99167e6`; full |
| E04 README | `0e56aec85ab9805506bc373dc46be236ff9e613e`; full |
| PLAN 0.9 | `67fa904b80f96f7dfcb7881d28e619a4965cba1a`; full |
| STATE before closure | `5eb96482a1f04df06c048c53340319dbaa551604`; full; retained publication IN PROGRESS until checks |
| INDEX before receipt link | `7b1a19b36afd5e64b9034f1942a1f3b96ec7b4e9`; full |
| E04 prospective PLAN | `ac291d5f5e388a00d9d01721c9025475b6f25814`; main directory metadata equals original local bytes |
| E04 runner | `16333fcf9d2bbe208fee061044a997d7aa06e2d3`; same identity check |
| E04 exact compressed stdout | `8a3796d5523276ea9366a1cc1535d9e127985dfe`; main directory metadata equals original gzip blob |

Local reinspection confirmed the prospective plan/runner identities, the original receipt timestamp and nine recorded cases, empty captured stderr, and exact decompression equality. This was an artifact check, not another E04 run. Every fixture and output remains in the raw stdout; README is the readable derived view. The gzip recovery mechanism is documented there. No real task outcomes are implied by the synthetic labels.

This receipt precedes the final INDEX link and STATE closure writes. Those future commit IDs/readbacks are not represented as already completed. Not every changed artifact received a full post-write reread; no repository-wide automated link/semantic suite or independent fresh-session trial ran.

## MR08 maintenance addendum: failure, repair and narrower prevention

The initial whole-file catalog replacement unintentionally changed the Matt Pocock relevance ordering and the OpenProject relevance labels. The actual commit patch revealed both. The first restoration fixed them but unintentionally shortened the AI knowledge-strategies phrase. These are assistant transcription failures, not concurrent stakeholder changes or ECC defects.

Repeating an unchecked whole-file repair was not adequate. The final repair instead reconstructed the current catalog locally and required its Git blob to equal `97084fa6ae092a2c12f527a1af70a2d714d2fb2b` before changing the exact phrase. The mechanically produced candidate blob was `154126031cbb89b8e7de095fc3e20bceabac2dd8`. GitHub create_blob returned that exact identity before any branch movement. A detached commit comparison then confirmed the full net catalog scope was one ECC row; only afterward was main fast-forwarded without force.

This excluded unintended text differences for that exact final repair. It does not prove the chosen ECC wording scientifically correct, eliminate concurrency risk, or establish an efficient general workflow. The repeated whole-file maintenance cost remains a negative method observation. Subsequent shared-file changes should reuse verified source bytes and inspect the prepared net diff before publication rather than relying on careful generative recopying; apply this as study publication practice, not an unauthorized agent-control change. Old per-unit histories remained untouched.

## Scientific disposition and next work

U05-B source coverage is S109–S122. E04 ran three exact original evaluator/proposal/health helpers once with predeclared synthetic inputs. Count/filter/tie/regression controls and duplicate/unmatched/mixed-amendment/single-failure cases characterize their predicates. No upstream test suite, tracker/full CLI, native host/model, dashboard, installation or snapshot/rollback ran. E01–E03 and U04/U05-A source-only boundaries remain unchanged.

Q06c1 is bounded-answered; Q06c2 retains the connected independent task oracle, valid version-bound experiments, actual change admission/deployment/use and instinct bridges. Other residuals and P1 remain open. Next U06-A/Q07a is security/governance at a concrete configuration-mutation boundary, not already performed. METHOD 0.1 / PLAN 0.9. The comprehensive joint evaluation is deferred until research completion, while intermediate checks continue. No owner upload or merge is pending for the already integrated research and repaired catalog.
