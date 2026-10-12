# T-W07-5B · Each devos_api function admits exactly the role classes of its row, in every direction

Synthetic test data (plan Section 8 item 13): six synthetic tokens, one per role class, are issued at run time inside the rolled-back transaction and held only in PL/pgSQL variables. Every argument is a neutral value made from the function's argument types. Text reads `w07_fixture SYNTHETIC W-C02-07`.

**Serves.**
- W-C02-09 point 8: "its authorization test (B section 2: each function refuses a token of every role class not on its list), with `devos-test`'s tokens". This is the role lists.
- W-C02-10 point 5: the last two bullets, "For the three environments' role classes and `devos_kurulum`, in every direction, an operation that only one class may do, made with another's token, is refused", and "the job classes' limits (`devos_ci`, `devos_backup`) as W-C02-07's record assigns them". These are the separation lines.
- W-C02-07 point 5 (b) at the database, with `devos-test`'s tokens. The real tokens' runs of the same line are `T-W07-RT`.
- C02 Acceptance: "✘ With each environment's real token, an operation that requires another environment's authority is rejected." Shown here with synthetic tokens. W-C02-12 shows it with the real ones.

Design relied on:
- EV-C02-003 §4.1, the matrix, every cell (EV-C02-004 X-18);
- Appendix B section 2 and section 4, with PC-43 places 5 and 13;
- B:47 ("The role list sits in the function's definition and is tested with the authorization tests");
- EV-C02-002 DM-19 (one row per call for a verified caller refused for another reason), DM-29 (`revoke_claim`) and DM-23;
- EV-C02-003 §5.2 (`devos_ci` holds no right an environment must not hold) and §5.4 (`devos_backup` with synthetic tokens).

**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_5b_authorization_matrix.sql`. It runs in `devos-test`, by the job's test step as `postgres`, and on the throwaway database by the harness. Its statement timeout is 300 s.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. As `T-W07-IDC`. Beyond it:
- the wrong-role-class refusal's reason code is `role_class_not_permitted` (in `w07_cfg` key `role_codes`; a list is allowed);
- the functions of the five rows whose function the design does not name go in `pg_temp.w07_fn_cfg`, keyed `R10r`, `R12`, `R13`, `R14` and `R15`. They are empty until the build names them.


**Phase C, the executor's decision (N-256).** The ten C02 functions with no row of permitted role classes in EV-C02-003 §4.1 give "could not check", one case each, until the executor decides their rows; the assumed lists are then revised before any result (README section 8).

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
| R08 | Effort-reduction approval; standing effort policies | `set_effort_policy` | n y n n n n |
| R10 | `EvalRun` writes | `record_eval_run` | n n y n n n |
| R10r | Reading `EvalRun` and the exam fact | named by the build (`R10r`) | n n y n n n |
| R11 | `competence_summary(role)` | the same, if built in C02 | y y y y n n |
| R12 | Reading review verdicts, decisions, current authority and epoch | named by the build (`R12`) | y y y y y y |
| R13 | Fingerprint matches | named by the build (`R13`) | n n n n y n |
| R14 | Recording a check's result | named by the build (`R14`) | n n n n y n |
| R15 | Reading RejectedAttempt | named by the build (`R15`) | n y n n n n |
| R16 | `deployment_drift` | the same | n n n n y n: Data API only, `T-W07-IDC` cases `IDC-dd-*` |
| R17 | `mark_exported` | the same | n n n n n y |
| R18 | `ingest_source` | the same, if present | n n n n n n |

**Two readings stated** (the matrix's cells, applied to functions):
- **R02's `devos_sinav` cell** reads "✔ exam tasks only, as ordinary work (B:38)". At the role gate it is ✔. That a sinav call opens only exam tasks is a check after the gate, not part of the role list, and is not tested here.
- **R07's `devos_kurulum` cell** reads "✘, except the ledger transfer's copies … through the transfer's path". A direct call of `open_review`, `record_verdict` or `accept` is ✘. The transfer's own function is W-C02-06's (`T-W07-N04`, part T).

**Rows tested by another test, named so that no cell is lost:**

| §4.1 row | Where |
|---|---|
| Any call that takes a claim token when the claim's class differs (S8 line 2), all ✘ | `T-W07-N17` (Group A), one case per kind of call (PC-43 place 11). Phase C checks it covers every column |
| `issue_env_token`, `revoke_env_token`, all ✘ | `T-W07-IDC`, `IDC-n-*` |
| A direct write to any table, all ✘ | `T-W07-5A` (Group B) |
| Release activation | C05's form (B 3.14). C02 builds none, so nothing is tested here |

## Cases

`5B-<row>-<function>-<column>`, for every `devos_api` function in the catalogue at run time with a row above, and every column. Example: `5B-R07-record_verdict-cal`. An overloaded name gets `#2` and so on.
- **✘ cell.** The call with that column's token is a role refusal: its answer carries a role code, and RejectedAttempt gains exactly one per-call row (function, code, that class). There is no other RejectedAttempt change, no event, no table changed, no echo, no raise.
- **✔ cell.** The call passes the role gate. No token or role refusal is recorded for the function, and it is not denied EXECUTE (42501). Whatever follows with neutral arguments (acceptance, or a refusal for another reason) is allowed.
- **Coverage cases.**
  - `5B-unmapped-<function>`: a function with no row, read from the catalogue, gives COULD NOT CHECK, so a function added later is never silently untested.
  - `5B-row-<row>`: a C02 row with no function present gives COULD NOT CHECK.

The rows that may be absent are R11 (Competence is C05's), R16 (`deployment_drift`) and R18 (`ingest_source` is C04's).

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-5B. **[Designer's addition: no Appendix C entry. Plan C02 Acceptance, R2 section 5 (b), W-C02-09 point 8 and W-C02-10 point 5 ask for it; Appendix C's own authorization tests, C03 test 1 and K06, are C03's.]** Every `devos_api` function admits exactly the role classes of its row of EV-C02-003 §4.1, and refuses every other, recorded as DM-19 says. |
| **Failure class rule** | A function whose role list differs from its row in any cell. It admits a class the row denies, or it refuses a class the row permits. Or it refuses without the per-call record. Or it records the refusal under another class, or under `none`, for a verified token. Or it refuses after changing state. Also a function with no row (its role list unjudged). |
| **Examples** | (1) The original finding (R2 section 5 (b)): only working→audit was tested in C02. The audit token writing a product is `5B-R06-register_artifact-den`. The exam token writing a verdict is `5B-R07-record_verdict-sin`. (2) Another manifestation: a job class with an environment's authority, such as `devos_ci` deciding (`5B-R02-open_decision-ci`) or `devos_backup` claiming (`5B-R04-claim-bak`). (3) Another: one environment's audit right taken by another (`5B-R05-revoke_claim-cal`; DM-29). (4) Another: the installation token on a Mission is ✔, the others ✘ (`5B-R03-open_mission-*`). |
| **Negative control** | Every ✘ cell, judged as under "Cases": refused, recorded once per call under the caller's class, nothing else changed. |
| **Positive control** | Every ✔ cell passes the role gate with the same arguments. It differs from the ✘ cells of its row in the token only. A full acceptance of each family's operation is its own test's positive: R01 `IDC-d-*`; R02 and R03 `T-W07-N01`, `N02`, `N29` and `F05`; R04 `T-W07-N17` and `CONC`; R05 `T-W07-F08` (c); R06 `T-W07-F01`, `F05`, `F07` and `N28`; R07 `N04-p3` and `N04-p4`; R08 `T-W07-N03`; R10 `N08-wp2`. This file shows the role gate. Those tests show the operation. |
| **Break attempt** | Each patch is applied by the harness on the throwaway database (README 5.2). Each widens one cell, by adding a class beside the permitted one in the function's own text. If the build keeps its role lists outside the function, the patch refuses to apply, and the prober makes the same one-cell change at that place.<br>**B-5B-1** (`breaks/B-5B-1_verdict_admits_working.sql`): `record_verdict` admits `devos_calisma`. Red: `5B-R07-record_verdict-cal`, `N04-a1`, `N04-a2`, `N04-c1`, `N04-c2` and `N04-e1-record_verdict`. Two more turn red where the function has a role argument or a database role `devos_denetim` exists: `N04-c3-record_verdict` and `N04-c4`. The prober adds them before the run.<br>**B-5B-2** (`breaks/B-5B-2_revoke_claim_admits_working.sql`): `revoke_claim` admits `devos_calisma` (DM-29). Red: `5B-R05-revoke_claim-cal` and `6TK-ka1`.<br>**B-N04-1**: `accept` admits `devos_kurulum`. Red includes `5B-R07-accept-kur`.<br>**B-N08-2**: `record_eval_run` admits `devos_ci`. Red includes `5B-R10-record_eval_run-ci`.<br>For any other cell, W-C02-13's prober may copy B-5B-1 with the function and class changed. The red case is that cell's case ID. |
| **Stage and environment** | C02. `devos-test` (the job's test step) and the throwaway database. No real token is used: W-C02-12 tries the separation lines with each environment's real token (`T-W07-RT`). |
| **Independence level** | As `T-W07-IDC`: written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record); run by the job, by W-C02-09's and W-C02-10's producers at their heads, and by W-C02-13's prober with the breaks; judged by a fresh-context checker. Shared: model lineage, EV-C02-003's matrix (the checker should re-read the matrix itself, not this table), and the README. |
| **Evidence layer** | Structural, at the role gate. It does not show that a permitted call does its work (the family tests do), that a refused class cannot reach the same effect through another function (each function is tested, but not chains of calls), or anything about real tokens or `devos`. The header is simulated (`sql-set-role`). |
| **Evidence envelope** | README section 4.<br>Fixed before the run: each cell's expected outcome is the table above. The number of cases is 6 per function with a row, plus one per unmapped function and per absent row. On the stand-in, 23 functions gave 138 cell cases and 7 coverage cases. Each break's red cases are as above.<br>`transport`: `sql-set-role` or `throwaway`. `observations_ref` and `raw_evidence_ref` as `T-W07-IDC`. |

## Clause table

Not an Appendix C test. Point 5 (b)'s "Cannot do" lines of Appendix B section 2 map to cells as follows:

| Role class: "Cannot do" | Cells |
|---|---|
| working: binding verdicts, acceptance | R07 cal |
| working: approving rule changes | R08 cal, and `T-W07-N03` |
| working: reading exam records | R10r cal, and `T-W07-N08` |
| working: release activation | C05 |
| audit: writing products and candidates | R06 den |
| audit: reading exam records | R10r den, and `N08` |
| exam: writing products | R06 sin |
| exam: writing verdicts | R07 sin |
| `devos_kurulum` (S8 line 1) | R07, R08, R10, R10r and R15 kur; issuing tokens `IDC-n-*`; the rest `T-W07-N04` |
| `devos_ci`: writing verdicts or decisions | R07 and R02 ci |
| `devos_backup`: every other write | every non-R17 write row, bak |

## Format gate

Not a format-gate test.

## Could not check

- Before the build (`5B-pre`).
- A function with no row (`5B-unmapped-*`).
- A row with no function (`5B-row-*`), including R10r and R12 to R15 until the build names their functions.
- Ten functions of C02 families have no row in EV-C02-003 §4.1, so their permitted classes are stated nowhere: `ready_works`, `relate`, `retract_relation`, `affected_entities`, `explain_paths`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` and `review_finding`. Each gives COULD NOT CHECK with that reason until the design gives it a row. This is reported to the executor as Open: a design gap, not a test's choice. The test gives none of them a row, because a test that took its expected cells from the build would judge the build against itself.

## Self-check (not a result)

On 2026-10-12, on PostgreSQL 16.15, with the scratch stand-in:
- 138 cell cases were `ok`, and 7 were COULD NOT CHECK by design: five unnamed rows, one function deliberately left unmapped and one function without a row. So the file's result was COULD NOT CHECK, as it must be while such cases remain.
- With B-5B-1, B-5B-2, B-N04-1 and B-N08-2 applied, the red cases were exactly their `expect-red` lists.

## Not covered

- Chains of calls; a check after the role gate (R02's sinav restriction; R03's `batu`-class decision, which is `T-W07-N29`'s).
- `deployment_drift`'s cells here: they need the Data API, and are `IDC-dd-*`. Their break needs a Data API on the throwaway database, which the harness lacks. Its own breaks are W-C02-03's.
- `devos_ingest` (C04).
- Real tokens (`T-W07-RT`).
