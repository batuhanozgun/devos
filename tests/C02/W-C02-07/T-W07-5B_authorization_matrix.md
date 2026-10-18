# T-W07-5B · Each devos_api function admits exactly the role classes of its row, in every direction

Synthetic test data (plan Section 8 item 13): six synthetic tokens, one per role class, are issued at run time inside the rolled-back transaction and held only in PL/pgSQL variables. Every argument is a neutral value made from the function's argument types. Text reads `w07_fixture SYNTHETIC W-C02-07`.

**Serves.**
- W-C02-09 point 8: "its authorization test (B section 2: each function refuses a token of every role class not on its list), with `devos-test`'s tokens". This is the role lists.
- W-C02-10 point 5: the last two bullets, "For the three environments' role classes and `devos_kurulum`, in every direction, an operation that only one class may do, made with another's token, is refused", and "the job classes' limits (`devos_ci`, `devos_backup`) as W-C02-07's record assigns them". These are the separation lines.
- W-C02-07 point 5 (b) at the database, with `devos-test`'s tokens. The real tokens' runs of the same line are `T-W07-RT`.
- C02 Acceptance: "✘ With each environment's real token, an operation that requires another environment's authority is rejected." Shown here with synthetic tokens. W-C02-12 shows it with the real ones.

Design relied on:
- EV-C02-003 §4.1, the matrix, every cell (EV-C02-004 X-18);
- EV-C02-008 (merged and accepted, PR #300; CHK-C02-025): section 1.2's ten rows, section 1.4's R15 name, section 1.7.2's `operation_state` row, section 1.7.3's ledger transfer row and section 1.7.4's gate row for `set_effort_policy`;
- Appendix B section 2 and section 4, with PC-43 places 5 and 13;
- B:47 ("The role list sits in the function's definition and is tested with the authorization tests");
- EV-C02-002 DM-19 (one row per call for a verified caller refused for another reason), DM-29 (`revoke_claim`) and DM-23;
- EV-C02-003 §5.2 (`devos_ci` holds no right an environment must not hold) and §5.4 (`devos_backup` with synthetic tokens).

**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-10 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_5b_authorization_matrix.sql`. It runs in `devos-test`, by the job's test step as `postgres`, and on the throwaway database by the harness. Its statement timeout is 300 s.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. As `T-W07-IDC`. Beyond it:
- the wrong-role-class refusal's reason code is `role_class_not_permitted` (in `w07_cfg` key `role_codes`; a list is allowed);
- the functions of the four rows whose function the design leaves to W-C02-09's build (EV-C02-008 1.4) go in `pg_temp.w07_fn_cfg`, keyed `R10r`, `R12`, `R13` and `R14`. They are empty until the build names them. R15's function is named by the design: `devos_api.read_rejected_attempts(since timestamptz)` (EV-C02-008 1.4), and sits in the file's matrix.


**Phase C4a (EV-C02-008, merged and accepted).** The ten functions N-256 named now have rows (EV-C02-008 1.2: R20 to R25 below), R15's function is named (1.4), and `operation_state` (1.7.2: R26), the ledger transfer's fourteen functions (1.7.3: R19) and `set_effort_policy` at the gate (1.7.4: R08g) have rows. EV-C02-003 §4.1's row "Effort-reduction approval; standing effort policies" (R08) is kept as an operation row: its cells are checks after the gate, which `T-W07-N03` tests (EV-C02-008 1.7.4, and CHK-C02-025 condition C2's cases there). The qualifiers of the new rows' ✔ cells are checks after the gate (EV-C02-008 1.1; Rules O and C, 1.7.1), which `T-W07-ROC` tests. The assumed lists were revised before any result (README section 8): no build exists.

## The matrix as the file holds it

Columns, in order: `devos_calisma` (cal), `devos_denetim` (den), `devos_sinav` (sin), `devos_kurulum` (kur), `devos_ci` (ci), `devos_backup` (bak). y = ✔, n = ✘, as EV-C02-003 §4.1.

| Row | §4.1 row | Functions | cal den sin kur ci bak |
|---|---|---|---|
| R01 | `token_role_class()` | `token_role_class` | y y y y y y |
| R02 | Need and decision records; opening work other than missions | `record_need`, `resolve_need`, `open_decision`, `link_prior_decisions`, `admit_work` | y n y y n n |
| R03 | `open_mission`, `revise_mission` | the same | n n n y n n |
| R04 | `claim`, `heartbeat`, `release` | the same | y y y y n n |
| R05 | `revoke_claim` (DM-29) | the same | n y n n n n |
| R06 | Contributions, candidates, products, findings, … intents and their observations | `register_artifact`, `record_finding`, `prepare_operation`, `record_attempt`, `record_observation` | y n n y n n |
| R07 | Reviews, verdicts and acceptance | `open_review`, `record_verdict`, `accept` | n y n n n n |
| R08 | Effort-reduction approval; standing effort policies | none at the gate: an operation row since EV-C02-008 1.7.4 (below) | n y n n n n, after the gate: `T-W07-N03` |
| R08g | Not a §4.1 row: `set_effort_policy` at the gate (EV-C02-008 1.7.4) | `set_effort_policy` | y y y y n n |
| R10 | `EvalRun` writes | `record_eval_run` | n n y n n n |
| R10r | Reading `EvalRun` and the exam fact | named by the build (`R10r`; EV-C02-008 1.4) | n n y n n n |
| R11 | `competence_summary(role)` | the same, if built in C02 | y y y y n n |
| R12 | Reading review verdicts, decisions, current authority and epoch | named by the build (`R12`; EV-C02-008 1.4) | y y y y y y |
| R13 | Fingerprint matches | named by the build (`R13`; EV-C02-008 1.4) | n n n n y n |
| R14 | Recording a check's result | moved to C03 (EV-C02-013 section 4; note N-279 (9)); a function named for it is still judged | n n n n y n |
| R15 | Reading RejectedAttempt | `read_rejected_attempts` (named by EV-C02-008 1.4) | n y n n n n |
| R16 | `deployment_drift` | the same | n n n n y n: Data API only, `T-W07-IDC` cases `IDC-dd-*` |
| R17 | `mark_exported` | the same | n n n n n y |
| R18 | `ingest_source` | the same, if present | n n n n n n |
| R19 | Not a §4.1 row: Appendix B section 4's "Ledger transfer" row (B:397; PC-44 place 10), "Only `devos_kurulum`", in §4.1's terms by EV-C02-008 1.7.3 | `begin_transfer_run`, `transfer_mission`, `transfer_work`, `transfer_relation`, `transfer_decision`, `transfer_review`, `transfer_acceptance`, `transfer_need`, `transfer_finding`, `transfer_artifact`, `transfer_event`, `end_transfer_run`, `record_handover`, `record_ledger_entry` | n n n y n n |
| R20 | EV-C02-008 1.2: `ready_works()` | `ready_works` | y y y y n n |
| R21 | EV-C02-008 1.2: writing and retracting a relation | `relate`, `retract_relation` | y n y y n n |
| R22 | EV-C02-008 1.2: the affected-records reads | `affected_entities`, `explain_paths` | y y y y n n |
| R23 | EV-C02-008 1.2: a work item's revision, staleness and cancellation | `revise_work`, `mark_stale`, `cancel_work` | y n y y n n |
| R24 | EV-C02-008 1.2: taking work items into the candidate review set | `reopen_for_review` | y y y y n n |
| R25 | EV-C02-008 1.2: a Finding's review transitions | `review_finding` | n y n n n n |
| R26 | EV-C02-008 1.7.2: the current state of an Operation | `operation_state` | y y y y n n |

**Readings stated** (the matrix's cells, applied to functions):
- **R02's `devos_sinav` cell** reads "✔ exam tasks only, as ordinary work (B:38)". At the role gate it is ✔. That a sinav call opens only exam tasks is a check after the gate, not part of the role list, and is not tested here.
- **R07's `devos_kurulum` cell** reads "✘, except the ledger transfer's copies … through the transfer's path". A direct call of `open_review`, `record_verdict` or `accept` is ✘. The transfer's own functions are R19's.
- **The qualifiers of R20 to R24's ✔ cells** ("its review work", "its exam work", "its exam tasks only", "the installation's work items" or "own records") are checks after the gate (EV-C02-008 1.1). Rules O and C (1.7.1) decide them for the Work and Relation writes; `T-W07-ROC` tests them. The ✔ cell here judges the gate only, so a call with neutral arguments that the gate admits and a later check refuses passes the cell.
- **R19's ✔ cell** is the gate. The limits after the `ledger_handed_over` event are a check after the gate, read from that event (state, not role; EV-C02-008 1.7.3), and are W-C02-14 point 13's tests. No case here plants the event, so every `devos_kurulum` cell runs before one exists in this transaction (1.7.3's inference). If `devos-test` already holds one, a refusal after the gate still passes the ✔ cell.
- **R08g and R08.** `set_effort_policy` carries three kinds of write (EV-C02-008 1.7.4): (a) an item's own policy at the default or within an active standing policy, (b) a reduction for one item and (c) writing or retiring a standing policy. The gate admits `cal`, `den`, `sin` and `kur`; R08's cells, `den` only, bind kinds (b) and (c), and Rule O binds kind (a), each after the gate. `T-W07-N03` tests them.

**Rows tested by another test, named so that no cell is lost:**

| §4.1 row | Where |
|---|---|
| R08, "Effort-reduction approval; standing effort policies", as an operation row after the gate (EV-C02-008 1.7.4) | `T-W07-N03`: `cal` ✘ `N03-neg-own-approval`, `-declared`, `N03-neg-standing-calisma`, `N03-neg-retire-by-calisma`; `sin` ✘ `N03-neg-own-approval-sinav`, `N03-neg-standing-sinav`, `N03-neg-retire-by-sinav`; `kur` ✘ `N03-neg-own-approval-kurulum`, `N03-neg-standing-kurulum`; `den` ✔ `N03-pos-audit-reduction`, `N03-pos-standing-audit`; and kind (a)'s limits `N03-neg-default-denetim`, `N03-neg-rule-o-kurulum`, `N03-neg-rule-o-sinav` (CHK-C02-025 C2). `ci` and `bak` are refused at the gate here (R08g) |
| The qualifiers after the gate of R20 to R24 (Rules O and C, EV-C02-008 1.7.1) | `T-W07-ROC` |
| Any call that takes a claim token when the claim's class differs (S8 line 2), all ✘ | `T-W07-N17` (Group A), one case per kind of call (PC-43 place 11). Phase C checks it covers every column |
| `issue_env_token`, `revoke_env_token`, all ✘ | `T-W07-IDC`, `IDC-n-*` |
| A direct write to any table, all ✘ | `T-W07-5A` (Group B) |
| R19 after the hand-over | W-C02-14 point 13's tests (EV-C02-008 1.7.3) |
| Release activation | C05's form (B 3.14). C02 builds none, so nothing is tested here |

## Cases

`5B-<row>-<function>-<column>`, for every `devos_api` function in the catalogue at run time with a row above, and every column. Example: `5B-R07-record_verdict-cal`. An overloaded name gets `#2` and so on.
- **✘ cell.** The call with that column's token is a role refusal: its answer carries a role code, and RejectedAttempt gains exactly one per-call row (function, code, that class). There is no other RejectedAttempt change, no event, no table changed, no echo, no raise.
- **✔ cell.** The call passes the role gate. No token or role refusal is recorded for the function, and it is not denied EXECUTE (42501). Whatever follows with neutral arguments (acceptance, or a refusal for another reason) is allowed.
- **Coverage cases.**
  - `5B-unmapped-<function>`: a function with no row, read from the catalogue, gives COULD NOT CHECK, so a function added later is never silently untested.
  - `5B-row-<row>`: a C02 row with no function present gives COULD NOT CHECK.

The rows that may be absent are R11 (Competence is C05's), R16 (`deployment_drift`), R18 (`ingest_source` is C04's) and R14 (moved to C03: EV-C02-013 section 4; note N-279 (9); revised before any result, 2026-10-18). Every other row is C02's: until one of its functions exists, `5B-row-<row>` gives COULD NOT CHECK. That includes R19's fourteen functions (W-C02-09's, B:408, PC-44) and the rows phase C4a adds (R08g, R15, R20 to R26). R19's ✔ cell is the role gate before the hand-over; that every function but four refuses after the `ledger_handed_over` event is W-C02-14 point 13's test.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-5B. **[Designer's addition: no Appendix C entry. Plan C02 Acceptance, R2 section 5 (b), W-C02-09 point 8 and W-C02-10 point 5 ask for it; Appendix C's own authorization tests, C03 test 1 and K06, are C03's.]** Every `devos_api` function admits exactly the role classes of its row of EV-C02-003 §4.1, or of the rows EV-C02-008 sections 1.2, 1.4 and 1.7 add, and refuses every other, recorded as DM-19 says. |
| **Failure class rule** | A function whose role list differs from its row in any cell. It admits a class the row denies, or it refuses a class the row permits. Or it refuses without the per-call record. Or it records the refusal under another class, or under `none`, for a verified token. Or it refuses after changing state. Also a function with no row (its role list unjudged). |
| **Examples** | (1) The original finding (R2 section 5 (b)): only working→audit was tested in C02. The audit token writing a product is `5B-R06-register_artifact-den`. The exam token writing a verdict is `5B-R07-record_verdict-sin`. (2) Another manifestation: a job class with an environment's authority, such as `devos_ci` deciding (`5B-R02-open_decision-ci`) or `devos_backup` claiming (`5B-R04-claim-bak`). (3) Another: one environment's audit right taken by another (`5B-R05-revoke_claim-cal`; DM-29), or a Finding accepted for use by the working environment (`5B-R25-review_finding-cal`; EV-C02-008 1.2). (4) Another: the installation token on a Mission is ✔, the others ✘ (`5B-R03-open_mission-*`). (5) Another: a job class reading what it has no use for (`5B-R20-ready_works-ci`, `5B-R26-operation_state-bak`). |
| **Negative control** | Every ✘ cell, judged as under "Cases": refused, recorded once per call under the caller's class, nothing else changed. |
| **Positive control** | Every ✔ cell passes the role gate with the same arguments. It differs from the ✘ cells of its row in the token only. A full acceptance of each family's operation is its own test's positive: R01 `IDC-d-*`; R02 and R03 `T-W07-N01`, `N02`, `N29` and `F05`; R04 `T-W07-N17` and `CONC`; R05 `T-W07-F08` (c); R06 `T-W07-F01`, `F05`, `F07` and `N28`; R07 `N04-p3` and `N04-p4`; R08g `T-W07-N03` (`N03-pos-default`, `-pos-audit-reduction`, `-pos-default-sinav`, `-pos-default-kurulum`); R10 `N08-wp2`; R15 `T-W07-DM19B` part B; R20 `T-W07-6RG` (readiness); R21 `T-W07-F06` and `T-W07-ROC`; R22 `T-W07-F04` and `T-W07-K05`; R23 and R24 `T-W07-F06` and `T-W07-ROC`; R25 `T-W07-N09`; R26 `T-W07-F07`. This file shows the role gate. Those tests show the operation. |
| **Break attempt** | Each patch is applied by the harness on the throwaway database (README 5.2). Each widens one cell, by adding a class beside the permitted one in the function's own text. If the build keeps its role lists outside the function, the patch refuses to apply, and the prober makes the same one-cell change at that place.<br>**B-5B-1** (`breaks/B-5B-1_verdict_admits_working.sql`): `record_verdict` admits `devos_calisma`. Red: `5B-R07-record_verdict-cal`, `N04-a1`, `N04-a2`, `N04-c1`, `N04-c2` and `N04-e1-record_verdict`. Two more turn red where the function has a role argument or a database role `devos_denetim` exists: `N04-c3-record_verdict` and `N04-c4`. The prober adds them before the run.<br>**B-5B-2** (`breaks/B-5B-2_revoke_claim_admits_working.sql`): `revoke_claim` admits `devos_calisma` (DM-29). Red: `5B-R05-revoke_claim-cal` and `6TK-ka1`.<br>**B-5B-3** (`breaks/B-5B-3_review_finding_admits_working.sql`; phase C4a, a row of EV-C02-008 1.2): `review_finding` admits `devos_calisma`. Red: `5B-R25-review_finding-cal`.<br>**B-N04-1**: `accept` admits `devos_kurulum`. Red includes `5B-R07-accept-kur`.<br>**B-N08-2**: `record_eval_run` admits `devos_ci`. Red includes `5B-R10-record_eval_run-ci`.<br>For any other cell, W-C02-13's prober may copy B-5B-1 with the function and class changed. The red case is that cell's case ID. |
| **Stage and environment** | C02. `devos-test` (the job's test step) and the throwaway database. No real token is used: W-C02-12 tries the separation lines with each environment's real token (`T-W07-RT`). The migration job runs a file of this test only once W-C02-10 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As `T-W07-IDC`: written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record); run by the job, by W-C02-09's and W-C02-10's producers at their heads, and by W-C02-13's prober with the breaks; judged by a fresh-context checker. Shared: model lineage, EV-C02-003's matrix (the checker should re-read the matrix itself, not this table), and the README. |
| **Evidence layer** | Structural, at the role gate. It does not show that a permitted call does its work (the family tests do), that a refused class cannot reach the same effect through another function (each function is tested, but not chains of calls), or anything about real tokens or `devos`. The header is simulated (`sql-set-role`). |
| **Evidence envelope** | README section 4.<br>Fixed before the run: each cell's expected outcome is the table above. The number of cases is 6 per function with a row (R16 excepted), plus one per unmapped function and per absent row. With every C02 row's functions present, that is 46 functions with rows (R01 to R08g, R10, R15, R17, R19 to R26; R11 and R18 if present) and 276 cell cases, and three coverage cases for R10r, R12 and R13 until the build names them (R14 moved to C03, revised 2026-10-18). On phase B's stand-in, 23 functions gave 138 cell cases and 7 coverage cases. Each break's red cases are as above.<br>`transport`: `sql-set-role` or `throwaway`. `observations_ref` and `raw_evidence_ref` as `T-W07-IDC`. |

## Clause table

Not an Appendix C test. Point 5 (b)'s "Cannot do" lines of Appendix B section 2 map to cells as follows:

| Role class: "Cannot do" | Cells |
|---|---|
| working: binding verdicts, acceptance | R07 cal; R25 cal (`review_finding`, EV-C02-008 1.3) |
| working: approving rule changes | R08 cal, after the gate: `T-W07-N03` (`N03-neg-own-approval`, `-declared`, `N03-neg-standing-calisma`, `N03-neg-retire-by-calisma`; EV-C02-008 1.7.4) |
| working: reading exam records | R10r cal, and `T-W07-N08` |
| working: release activation | C05 |
| audit: writing products and candidates | R06 den; R21 den (`relate`, `retract_relation`: the relations that state how a product was made; EV-C02-008 1.3); R23 den (by §4.1's no-row rule, EV-C02-008 1.3) |
| audit: reading exam records | R10r den, and `N08` |
| exam: writing products | R06 sin |
| exam: writing verdicts | R07 sin; R25 sin (EV-C02-008 1.3); R08 sin after the gate, `T-W07-N03` (`N03-neg-own-approval-sinav`, `N03-neg-standing-sinav`, `N03-neg-retire-by-sinav`; CHK-C02-025 C2 (a)) |
| `devos_kurulum` (S8 line 1) | R07, R10, R10r, R15 and R25 kur; R08 kur after the gate, `T-W07-N03` (`N03-neg-own-approval-kurulum`, `N03-neg-standing-kurulum`); issuing tokens `IDC-n-*`; the rest `T-W07-N04` |
| `devos_ci`: writing verdicts or decisions | R07, R02 and R25 ci; the R21, R23 and R24 writes ci (EV-C02-008 1.3: its one write is its checks' results); the R20, R22 and R26 reads ci (not among B:40's reads) |
| `devos_backup`: every other write | every non-R17 write row, bak; the R20, R22 and R26 reads bak (B:41) |
| The ledger transfer: "Only `devos_kurulum`" (B:397) | R19, every column (EV-C02-008 1.7.3) |

## Format gate

Not a format-gate test.

## Could not check

- Before the build (`5B-pre`).
- A function with no row (`5B-unmapped-*`).
- A row with no function (`5B-row-*`), including R10r and R12 to R14 until the build names their functions (EV-C02-008 1.4). `5B-row-R14` stayed COULD NOT CHECK, never a pass, until W-C02-09's build named R14's function or moved the row to C03 with its reason (EV-C02-008 1.4). It has moved: EV-C02-013 section 4 names the move and note N-279 (9) carries it on `main`, so, revised before the first result (README section 8; 2026-10-18), `5B-row-R14` is no longer a case; the file prints a notice "not a case: 5B-row-R14: moved to C03" in its place, never a pass.
- The ten functions N-256 named are no longer a reason: EV-C02-008 1.2 gives them rows (R20 to R25), taken from the design, never from the build.

## Self-check (not a result)

On 2026-10-12, on PostgreSQL 16.15, with the scratch stand-in (phase B):
- 138 cell cases were `ok`, and 7 were COULD NOT CHECK by design: five unnamed rows, one function deliberately left unmapped and one function without a row. So the file's result was COULD NOT CHECK, as it must be while such cases remain.
- With B-5B-1, B-5B-2, B-N04-1 and B-N08-2 applied, the red cases were exactly their `expect-red` lists.

Phase C4a, 2026-10-12, PostgreSQL 16.15, on a scratch stub of README 8.1 and EV-C02-008 sections 1.2, 1.7 and 2.2 (outside the repository, not delivered; the test designer's reading of the design, not the build: a pass on it is no evidence about the build): 151 cases, none `bad`, 7 COULD NOT CHECK by design (R10r and R12 to R14 unnamed, and rows whose functions the stub lacks), so the file's result was COULD NOT CHECK; every cell of R08g, R15 and R20 to R26 was `ok`. With B-5B-3, the red set was exactly `5B-R25-review_finding-cal`. On an empty database the file gives COULD NOT CHECK.

## Not covered

- Chains of calls; a check after the role gate (R02's sinav restriction; R03's `batu`-class decision, which is `T-W07-N29`'s; R08's operations, which are `T-W07-N03`'s; Rules O and C, which are `T-W07-ROC`'s; R19 after the hand-over, W-C02-14 point 13's).
- What a ✔ cell of R20, R22 or R26 returns to the class it admits, including whether DM-35's hiding of exam-linked records tells a working session which tasks are exams: that is N-262 (EV-C02-008 section 4 item 11), whose resolution is phase C4b's (`T-W07-F04`'s F04-c-noleak).
- `deployment_drift`'s cells here: they need the Data API, and are `IDC-dd-*`. Their break needs a Data API on the throwaway database, which the harness lacks. Its own breaks are W-C02-03's.
- `devos_ingest` (C04).
- Real tokens (`T-W07-RT`).

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_5b_authorization_matrix.sql`.
- **`w07_fn_cfg` (EV-C02-013 section 4):** R10r `read_eval_run`; R12 `read_review`, `read_decision`, `authority_epoch`; R13 `fingerprint_matches`.
- **Left for a later revision: 5B-row-R14.** Its move to C03 is carried by note N-279 (9), which must be on `main` before the row is revised; until then R14's key stays empty and the row gives `could_not_check` as before. [Done: the revision of 2026-10-18 below.]

## Revision before any result (EV-C02-013 Revision 2 and N-279 (9), 2026-10-18)
Under ledger rule 3, before any result of W-C02-09's build beyond its first migration (M09-01; no function this file judges exists yet), by the test designer, a fresh-context subagent of type `test-designer` of the working session (agent `a9863a9a24b64f461`, filled in by the executor at filing), from `evidence/C02/EV-C02-013_w09_interface.md` section 4 (the row of `w07_fn_cfg`: "R14 moves to C03 … `5B-row-R14` is revised to \"moved to C03\" before the first result") and note N-279 (9) on `plan/work/C02.md` at `main` `4630798` (L-340's annotation: "R14 (the CI role recording a check's result) moves to C03, because Appendix B gives no record family for a check's result and no C02 check writes one; the C03 check that first needs such a record is test 6, the leak check (plan C03 (6); Appendix C N06), or test 5's gating check if C03 records its results (T-81); C03's work list gives the family and its function before either runs"). One checker judges it with EV-C02-013's Revision 2 before M09-02's first commit.
- **Files changed:** this specification; `job/w07_5b_authorization_matrix.sql`.
- **The one case changed: `5B-row-R14`.** Its expected outcome was `could_not_check` (a row with no function); it is no longer a case of this file, and the file prints `W07_5B not a case: 5B-row-R14: moved to C03 …` instead. Source: EV-C02-013 section 4 and N-279 (9), as this file's own line in "Could not check" foresaw. It is not replaced by a pass: R14 joins R11 and R18, rows of later stages that give no case when absent. If a function is ever named for R14 in `w07_fn_cfg`, its six cells (`n n n n y n`) are still judged. No other case ID, expected outcome or break red list changes.
- **Text:** the matrix row R14, the paragraph on the rows that may be absent, the evidence envelope's coverage count (three, not four), and "Could not check".
- **Self-check (counts: no: self-check on 16.15):** on the thirteen merged migrations (W-C02-03's, W-C02-08's and M09-01), the file gives COULD NOT CHECK as before for its absent C02 rows; `5B-row-R14` is absent from its result rows and the notice is printed (the run's lines are in the test designer's report).
