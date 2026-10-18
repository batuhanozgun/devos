# T-W07-N17 · No effect without the claim's own token, and no claim-token call under another role class

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.n17`, five work items, artifacts `w07_fixture/n17/*` and session ids `w07_fixture_session_*` are made up and labelled SYNTHETIC W-C02-07. Environment and claim tokens are issued at run time. The unknown claim token is an issued one with one character changed at run time.

**Serves.** W-C02-09 points 4 and 8 ("N17 (with point 4's N-136 cases)"); Appendix C N17 as PC-43 place 11 words it; EV-C02-003 §4.3 (S8 line 2), §4.4 (S8 line 3 moved to C04), §4.5; EV-C02-002 DM-06 (an effect with a lapsed claim is refused) and DM-07; B 3.5. The real-token runs cite this test for the same rule (T-W07-RT, W-C02-12 point 6, README 5.3).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n17_claim_token.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-N17-1` and `breaks/B-5C-1`.
**Time added to W-C02-13's run.** None. The lapsed claim (N17-n9) is planted with `lease_expires_at` one second before `now()` (README section 9).
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it. Also: `devos_api.heartbeat(claim_token text)`, `devos_api.release(claim_token text)`, `devos_api.register_artifact(claim_token text, jsonb)` (the effect). The claim result carries `assignment_id`. Owner plant of `devos_private.assignment.lease_expires_at`. Break patches: the derivation `devos_private.caller_role_class(function_name) returns text` (EV-C02-003 §1.6), and `claim_token_hash` as hex SHA-256 of the whole token (§1.7; the encoding is assumed).


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
| N17-n5 | effect on W1 with W1's claim token under the audit token | `refused` (S8 line 2) |
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
