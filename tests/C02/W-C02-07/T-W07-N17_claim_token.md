# T-W07-N17 · No effect without the claim's own token, and no claim-token call under another role class

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.n17`, five work items, artifacts `w07_fixture/n17/*` and session ids `w07_fixture_session_*` are made up and labelled SYNTHETIC W-C02-07. [Revised under ledger rule 3 (N-293 (4), 2026-10-19): W3, `devos_kurulum`'s item, lies under the installation's Mission (the hook `installation_mission`: a synthetic Mission stand-in of scope `synthetic.w07_fixture`, planted as the owner inside the rolled-back transaction, or the one already there), with that Mission's scope.] Environment and claim tokens are issued at run time. The unknown claim token is an issued one with one character changed at run time.

**Serves.** W-C02-09 points 4 and 8 ("N17 (with point 4's N-136 cases)"); Appendix C N17 as PC-43 place 11 words it; EV-C02-003 §4.3 (S8 line 2), §4.4 (S8 line 3 moved to C04), §4.5; EV-C02-002 DM-06 (an effect with a lapsed claim is refused) and DM-07; B 3.5. The real-token runs cite this test for the same rule (T-W07-RT, W-C02-12 point 6, README 5.3).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n17_claim_token.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-N17-1` and `breaks/B-5C-1`.
**Time added to W-C02-13's run.** None. The lapsed claim (N17-n9) is planted with `lease_expires_at` one second before `now()` (README section 9).
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it. Also: `devos_api.heartbeat(claim_token text)`, `devos_api.release(claim_token text)`, `devos_api.register_artifact(claim_token text, jsonb)` (the effect). The claim result carries `assignment_id`. Owner plant of `devos_private.assignment.lease_expires_at`. [Revised under ledger rule 3 (N-293 (4), 2026-10-19): `claim` gives `devos_kurulum` only a work item under the installation's Mission (EV-C02-013 section 18 (2), step 6; EV-C02-008 1.7.1), so W3 is admitted under the Mission the hook `installation_mission` returns, at its current revision, with its scope; the hook is T-W07-ROC's, copied byte for byte (README 8.1, "Hooks").] Break patches: the derivation `devos_private.caller_role_class(function_name) returns text` (EV-C02-003 §1.6), and `claim_token_hash` as hex SHA-256 of the whole token (§1.7; the encoding is assumed).


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
| Case | Input | Expected |
|---|---|---|
| N17-pos1 | effect on W1 with W1's claim token, working token (the claim's class) | `ok` |
| N17-pos2 | effect on W3 with `devos_kurulum`'s own claim and token (N-136) | `ok` |
| N17-pos3 | `heartbeat` with W1's claim token, working token | `ok` |
| N17-n1 | effect on W1 with session b's claim token (W2's claim) | `refused`, nothing changed |
| N17-n2 | effect on W1 with no claim token | `refused` |
| N17-n3 | effect on W1 with an empty claim token | `refused` |
| N17-n4 | effect on W1 with a well-formed unknown claim token | `refused` |
| N17-n5 | effect on W1 with W1's claim token under the `devos_kurulum` token [Revised under ledger rule 3 (N-293 (4)'s further fault, 2026-10-19): this row said "under the audit token"; see the revision section] | `refused` (S8 line 2) |
| N17-n6 | `heartbeat` with W1's claim token under the exam token | `refused` |
| N17-n7 | `release` with a working claim's token (W5's) under the `devos_kurulum` token | `refused` |
| N17-n8 | effect on W3 with `devos_kurulum`'s claim token under the working token | `refused` |
| N17-n9 | effect on W4 with a claim whose lease has run out | `refused` |
| N17-pos4 | `release` with W1's claim token, working token | `ok` |

Each negative is also `bad` if the state digest changed.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-N17` (Appendix C N17): "No effect without a claim token", extended by PC-43 place 11 to every call that takes a claim token under another role class's environment token. |
| **Failure class rule** | A call that acts on a work item through a claim is accepted when the claim token is absent, belongs to another claim, does not match any claim, belongs to a lapsed claim, or is presented under an environment token whose role class is not the claim's. **[Designer's addition: C2 rows give no class rule (R2 section 5 (c)).]** |
| **Examples** | The original negative, another session's claim: N17-n1. Others: no token (n2, n3), an unknown token (n4), the class mismatch on each kind of call (n5 effect, n6 heartbeat, n7 release, n8 `devos_kurulum`'s claim), and a lapsed claim (n9). **[Designer's addition: examples beyond Appendix C's negative.]** |
| **Negative control** | N17-n1 to -n9 refused, with nothing changed. |
| **Positive control** | Appendix C: "An effect with the right token is accepted": N17-pos1. Also `devos_kurulum`'s own claim (pos2), and heartbeat and release by the claim's own class (pos3, pos4). N17-n5 differs from pos1 only in the environment token. |
| **Break attempt** | **[Designer's addition: C2 rows give no break.]** (1) `breaks/B-N17-1_role_class_match_removed.sql` removes S8 line 2 from `register_artifact`, `heartbeat` and `release`. Wrappers give the presented claim the caller's role class for the call. N17-n5, -n6, -n7 and -n8 must turn red. (2) `breaks/B-5C-1_claim_of_another_work_item.sql` removes the rule that a claim acts only on its own work item. N17-n1 turns red, with 5C-n1, -n2 and -n4. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (13/13); each patch turned exactly its named cases red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step, with synthetic tokens of `devos_calisma`, `devos_denetim`, `devos_sinav` and `devos_kurulum` (EV-C02-003 §6.3, §4.5). The throwaway PostgreSQL 17 database for the breaks. The same rule with each environment's real token in `devos`: T-W07-RT (W-C02-12 point 6). The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; agent ID in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the breaks. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. Transport `sql-set-role`: the header is simulated. This shows neither that the Data API passes it nor that a network secret adds it (T-W07-RT, W-C02-12). It does not show a second real session in one environment (EV-C02-003 §6.2). |
| **Evidence envelope** | README section 4. Fixed before the run: the outcomes above; PASS at 13/13; the breaks' red cases. Raw evidence `W07-N17-<run_at>`. |

## Clause table
| Clause of Appendix C N17 (verbatim, PC-43 place 11) | Case ID(s) | Or: moved to |
|---|---|---|
| "An effect attempt with another session's claim … is rejected" | N17-n1 | — |
| "or without a token is rejected" | N17-n2, N17-n3, N17-n4 | — |
| "and so is any call that takes a claim token (an effect, `heartbeat` or `release`) when the caller's environment token gives a role class other than the claim's (EV-C02-003 section 4.3)" | N17-n5 (effect), N17-n6 (heartbeat), N17-n7 (release), N17-n8 | — |
| "Positive: An effect with the right token is accepted" | N17-pos1 | — |
| N-136's extensions (W-C02-07 point 2): N17 with the `devos_kurulum` token | N17-pos2, N17-n8 | — |
| "a claim used with another role class's token" | N17-n5 to -n8 | — |
| "a claim without registration refused" | — | Moved to C04 with SessionRecord and `register_session` by EV-C02-003 §4.4 and PC-43 place 11 (merged), carried by N-223 on `plan/work/C04.md` |
| Break (Appendix C gives none) | B-N17-1, B-5C-1 | — |

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK before the build, when a fixture claim is refused, when a call raises, or when a refusal carries a token reason code (a refusal for another reason, README 5.3). N17-n9 is `could_not_check` if the lease cannot be planted.

## Not covered
- The real tokens and the header path (T-W07-RT).
- A fake declared session ID (T-W07-5C).
- Registration (C04).

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_n17_claim_token.sql`.
- **D-1 (EV-C02-013 section 1 item 3 and section 5 D-1): the flat reference form.** Every reference sent as an object `{"id", "revision"}` under a field name (`mission_ref`, `work_ref`, `from_ref`, `to_ref`, `target_ref`, `owner_authority`) is now sent flat: the field's Appendix B name holds the record's uuid and `<name without _ref>_revision` its revision (`owner_authority_revision` for `owner_authority`). Read-set entries (`{ref, revision}`) and internal helper objects are unchanged.

## Revision before any result (EV-C02-013 Revision 2, 2026-10-18)
Under ledger rule 3, before any result of W-C02-09's build beyond its first migration (M09-01, merged and applied; no function this file calls but the identity chain's exists), by the test designer, a fresh-context subagent of type `test-designer` of the working session (agent `a9863a9a24b64f461`, filled in by the executor at filing), from `evidence/C02/EV-C02-013_w09_interface.md` Revision 2 (section 14, its list "For the test designer", at branch `claude/c02-w09-rev2` `a542f83`, on `main` `4630798`). One checker judges this revision with Revision 2 before M09-02's first commit. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_n17_claim_token.sql`.
- **R2-7 (EV-C02-013 2.2, K2; N-279 (16)):** the fixture Mission's owner-planted `batu` Decision (`pg_temp.w07_fixture_mission`) now names `answered_revision` 1, the revision answered (DM-11 (a)), which `open_mission` compares with `owner_authority_revision`; an answered Decision with NULL `answered_revision` is `could_not_check` under the record. Without it, every case of this file gave `could_not_check`.
- **Self-check (counts: no: self-check on 16.15):** on a scratch stub of `open_mission` written from EV-C02-013 2.2 (Revision 2's order of checks; not the build), this file's `pg_temp.w07_fixture_mission`, taken from the file unchanged, opens its Mission (`ok`, revision 1); the merged version of the same helper gave "fixture mission not opened: could_not_check"; an answered `batu` Decision with NULL `answered_revision` gives `could_not_check` (`owner_authority: answered_revision missing`).

## Revision under ledger rule 3 (N-293 (4), 2026-10-19)
Under ledger rule 3 and README section 8, before any result of this test: `job/w07_n17_claim_token.sql` is not in `supabase/migrations/tests/` (at `main` `d140797`) and has no counted result; the runs of the staged file in M09-07's record (EV-C02-014 section 8.5, run 06) and in CHK-C02-093 are self-checks, never results, and any earlier result of the changed files is void; the test is run again. Origin: note N-293 item (4) on `plan/work/C02.md`; EV-C02-013 sections 18 (2) and 20 (8); EV-C02-014 8.4. Deadline met: before the file's first result. By the test designer, a fresh-context subagent of type `test-designer` (named by the executor at filing). **No case ID or break red list is changed; no case asks less.**
- **Files changed:** this specification (the synthetic-data line, "Interface assumed", the case table's `N17-n5` row; this section); `job/w07_n17_claim_token.sql` (header lines 13-17; the hook `pg_temp.w07_hook`, lines 303-311; a declaration, line 315; W3's admission, lines 329-336; `N17-n5`'s token, lines 380-385); `breaks/B-N17-1_role_class_match_removed.sql` (lines 11-15 and 36-40, a further fault, below).
- **Fault (N-293 (4)).** W3 was admitted by `devos_kurulum` under the test's own Mission, opened through `open_mission` (creation event `mission_opened`), so it is not the installation's. M09-05's `claim` refuses `devos_kurulum` there `not_owner`, and the file stopped at `N17-pre` ("a fixture claim was refused") on every correct build; B-N17-1 and B-5C-1 could not run either.
- **Change.** The hook `installation_mission`, copied from T-W07-ROC (as T-W07-F06 uses it since N-291), returns the installation's Mission; W3 is admitted through `admit_work` with the `devos_kurulum` token under it, at its current revision, with its scope, so its artifacts (N17-pos2, -n8) lie within it. Everything else is unchanged.
- **A further fault of the same kind, found and fixed: B-N17-1.** Its wrappers wrote a text value into `devos_private.assignment.role_class`, an enum column (`devos_private.role_class`), so every wrapped call raised 42804 and the red cases came out `could_not_check`, as B-F04-7's did before N-291. Both values are now cast to the column's type.
- **A further fault of the same kind, found and fixed: `N17-n5` passed for the wrong reason.** It made the effect with W1's claim token under the audit token. M09-07's `register_artifact` admits only `devos_calisma` and `devos_kurulum` at its role gate (EV-C02-013 2.6), so the audit token was refused `role_class_not_permitted` before the class match (S8 line 2) the case's row names, and the case passed on that refusal (`refused` takes any refusal). So B-N17-1, which removes the class match, could not turn it red on any correct build, and its red list could not be shown (as N-283 (2)'s widen cases). **Change:** `N17-n5` makes the same effect under the `devos_kurulum` token, which passes the gate, so its refusal must come from the class match. It still differs from `N17-pos1` in the environment token alone, and from `N17-n8` (`devos_kurulum`'s claim under the working token) in the direction of the mismatch. Nothing is lost: the audit token's refusal of an effect is T-W07-5B's `5B-R06-register_artifact-den`. The audit token is still issued by the fixture; no case of this file now presents it. The case ID, its expected outcome and B-N17-1's red list are unchanged; the case asks more (the rule, not the gate).
- **Self-check (not a result; README section 10; counts: no: PostgreSQL 16.15 with M09-02's stand-ins `…/scratchpad/m0903_run/setup.sql`, unchanged).** One throwaway cluster of this revision's test designer (`…/scratchpad/n293b_run/cl.sh`, socket `…/scratchpad/n293b_run/s`): `main` `d140797`'s nineteen migrations, M09-01 to M09-07 (M09-07 sha256 `9677e7b3…`), one fresh database per run; patches applied with `w07.throwaway = yes` by `…/scratchpad/n293b_run/brk.sh`. Raw outputs: `…/scratchpad/n293b_run/out/`. All on the real build. The earlier draft's runs are not reported.
  - Merged file (`M_n17_real.txt`): COULD NOT CHECK (1 of 1), `N17-pre` ("a fixture claim was refused").
  - Revised file (`R_n17_real.txt`): PASS (13/13). N17-pos1 to -pos4 accepted; N17-n1 and -n4 `claim_unknown`, -n2 and -n3 `claim_missing`, -n5 to -n8 `claim_class`, -n9 `claim_expired`.
  - B-N17-1 on the revised file. The merged patch (`B_bn171_merged_real_*`): COULD NOT CHECK (10 of 13), each wrapped call raising 42804. The revised patch (`B_bn171_rev_real_*`): FAIL (4 bad, 0 could not check, of 13), exactly its red list `N17-n5`, `-n6`, `-n7`, `-n8`. The revised patch on the file with `N17-n5` still under the audit token (`B_bn171_rev_on_draft_n5_*`): FAIL (3 bad), `N17-n5` `ok` (`role_class_not_permitted`), so the break was not shown without the change above.
  - B-5C-1 cannot be applied on this build (`B_b5c1_real_apply.txt`: `devos_api.prepare_operation(text, jsonb) does not exist`, M09-08's); `N17-n1`, in its red list, waits for it.
  - The merged harness (`harness/run_breaks.py --pg-bin` 16 `--os-user nobody`, its own stand-ins and fresh databases, the staged files of this clone; workdir `/var/tmp/t93b`, deleted after) with B-N17-1: "shown", red exactly `N17-n5`, `-n6`, `-n7`, `-n8`, positive control and restore pass, labelled "counts: no" (`H_harness_n17_roc3.txt`).
