# T-W07-5C · An operation with another session's claim, or with a fake session ID, is rejected

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.c5`, two work items, artifacts `w07_fixture/c5/*`, keys `w07_fixture_key_5c_*` and session ids `w07_fixture_session_a`, `_b` and `_fake` are made up and labelled SYNTHETIC W-C02-07.

**Serves.** W-C02-09 point 8 ("W-C02-07's test for '✘ An operation with another session's claim, and with a fake session ID, is rejected'"); C02 Acceptance line, verbatim: "✘ An operation with another session's claim, and with a fake session ID, is rejected."; W-C02-07 point 5 (c); B principle 8 and 3.5; EV-C02-003 §4.4 ("A fake declared session ID changes nothing … an effect still needs the claim token") and §6.2's last item. The real-token form of the line is T-W07-RT (W-C02-12 point 6).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_5c_other_session_fake_id.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-5C-1`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it. The declared session ID travels as `declared_session_id`: as `claim`'s second argument, and as a field of the `register_artifact` and `prepare_operation` payloads. Break patch: `claim_token_hash` as hex SHA-256 of the whole token (EV-C02-003 §1.7; the encoding is assumed).


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
| Case | Input (two sessions a and b of one environment, each with its own claim) | Expected |
|---|---|---|
| 5C-pos1 | a's claim on a's work item, a's declared id | `ok` |
| 5C-pos2 | a's claim on a's work item, a fake declared id | `ok`: the declared id changes nothing (B principle 8) |
| 5C-pos3 | a's claim through `prepare_operation` | `ok` |
| 5C-n1 | b's claim token on a's work item, b's own declared id | `refused`, nothing changed |
| 5C-n2 | b's claim token on a's work item, declaring a's session id | `refused`, nothing changed |
| 5C-n3 | no claim token, declaring a's session id | `refused`, nothing changed |
| 5C-n4 | b's claim token through `prepare_operation` on a's work item, a's id declared | `refused`, nothing changed |
| 5C-n5 | no claim token through `prepare_operation`, a fake id declared | `refused`, nothing changed |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-5C`: an operation on a claim-bearing path that is not a verdict is refused with another session's claim and with a fake session ID. Since no authority rests on a declared ID, the declared ID changes no outcome. |
| **Failure class rule** | Any authority over a work item obtained by what a caller declares (a session ID, the session of the claimant) or by a claim of another work item. **[Designer's addition: an Acceptance line, not an Appendix C entry.]** |
| **Examples** | The line's first half, another session's claim: 5C-n1 and 5C-n4. Its second half, a fake session ID: 5C-n2, -n3, -n5. **[Designer's addition.]** |
| **Negative control** | 5C-n1 to -n5 refused, with nothing changed. |
| **Positive control** | 5C-pos1 and -pos3. 5C-pos2 shows that the fake ID with the right claim token changes nothing in the outcome (W-C02-09 point 3). 5C-n2 differs from 5C-pos2 only in the claim token. |
| **Break attempt** | `breaks/B-5C-1_claim_of_another_work_item.sql` removes the rule that a claim acts only on its own work item, on `register_artifact` and `prepare_operation`. Wrappers move the presented claim onto the named work item for the call. 5C-n1, -n2 and -n4 must turn red (and N17-n1). 5C-n3 and -n5 stay green, as their rule, no claim token, stays. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (8/8); patched, exactly those cases red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step, with synthetic working tokens. The throwaway PostgreSQL 17 database for the break. With each environment's real token: T-W07-RT. A case made within one session holding two claims is labelled so and does not count as the real-session case (EV-C02-003 §6.2). The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; agent ID in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. Both "sessions" are one database session with two claims: the database tells claims apart by token only (EV-C02-003 §6.2), so the case tests the same rule. It does not show two real Claude sessions. |
| **Evidence envelope** | README section 4. Fixed before the run: the outcomes above; PASS at 8/8; the break's red cases. Raw evidence `W07-5C-<run_at>`. |

## Clause table
Not an Appendix C test. Mapping to its Acceptance line: "with another session's claim": 5C-n1, 5C-n4; "with a fake session ID": 5C-n2, 5C-n3, 5C-n5; the right attempt: 5C-pos1 to -pos3.

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK before the build, when a fixture claim is refused, when a call raises, or when a refusal carries a token reason code.

## Not covered
- A verdict with a fake session ID (N04, Group D).
- Two real sessions in one environment (EV-C02-003 §6.2: not asked).

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_5c_other_session_fake_id.sql`.
- **D-1 (EV-C02-013 section 1 item 3 and section 5 D-1): the flat reference form.** Every reference sent as an object `{"id", "revision"}` under a field name (`mission_ref`, `work_ref`, `from_ref`, `to_ref`, `target_ref`, `owner_authority`) is now sent flat: the field's Appendix B name holds the record's uuid and `<name without _ref>_revision` its revision (`owner_authority_revision` for `owner_authority`). Read-set entries (`{ref, revision}`) and internal helper objects are unchanged.

## Revision before any result (EV-C02-013 Revision 2, 2026-10-18)
Under ledger rule 3, before any result of W-C02-09's build beyond its first migration (M09-01, merged and applied; no function this file calls but the identity chain's exists), by the test designer, a fresh-context subagent of type `test-designer` of the working session (agent `a9863a9a24b64f461`, filled in by the executor at filing), from `evidence/C02/EV-C02-013_w09_interface.md` Revision 2 (section 14, its list "For the test designer", at branch `claude/c02-w09-rev2` `a542f83`, on `main` `4630798`). One checker judges this revision with Revision 2 before M09-02's first commit. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_5c_other_session_fake_id.sql`.
- **R2-7 (EV-C02-013 2.2, K2; N-279 (16)):** the fixture Mission's owner-planted `batu` Decision (`pg_temp.w07_fixture_mission`) now names `answered_revision` 1, the revision answered (DM-11 (a)), which `open_mission` compares with `owner_authority_revision`; an answered Decision with NULL `answered_revision` is `could_not_check` under the record. Without it, every case of this file gave `could_not_check`.
- **Self-check (counts: no: self-check on 16.15):** on a scratch stub of `open_mission` written from EV-C02-013 2.2 (Revision 2's order of checks; not the build), this file's `pg_temp.w07_fixture_mission`, taken from the file unchanged, opens its Mission (`ok`, revision 1); the merged version of the same helper gave "fixture mission not opened: could_not_check"; an answered `batu` Decision with NULL `answered_revision` gives `could_not_check` (`owner_authority: answered_revision missing`).

## Revision under ledger rule 3 (N-287 and N-290, 2026-10-19)
Under ledger rule 3 and README section 8, before any result of this test: the break `breaks/B-5C-1_claim_of_another_work_item.sql` (the job file is not changed) is not in `supabase/migrations/tests/` (at `main` `6fd25a2`) and has no counted result; the runs of the staged file in M09-06's record (EV-C02-014 section 7) and in CHK-C02-092 are self-checks, never results, and any earlier result of the changed file is void; the test is run again. Origin: notes N-287 item (1) and N-290 item (1) on `plan/work/C02.md`, CHK-C02-090 finding 12, CHK-C02-091 finding 8, EV-C02-013 2.6, 2.7 and 18 (5). Deadline met: before 5C's first result and before the pull request that copies it. By the test designer, a fresh-context subagent of type `test-designer` (named by the executor at filing). **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification (this section); `breaks/B-5C-1_claim_of_another_work_item.sql` (header lines 11-20; the wrapper, lines 35-49).
- **Fault 1 (N-290 (1)).** The wrappers read the named work item as `p->'work_ref'->>'id'`, the object form EV-C02-013 2.6 and 2.7 replaced (`work_ref` a uuid, `work_revision` beside it): null on every call, so the wrappers passed every call through and the red cases could not show.
- **Fault 2 (N-287 (1)).** The work item's own active claim was set aside with the status `w07_set_aside`, which `devos_private.assignment_status` does not hold (22P02).
- **Fault 3 (found by running, the same patch).** Moving the presented claim to the named work item kept its `generation` and `work_revision`. W-C02-08's schema makes `(work_ref, generation)` unique and `(work_ref, work_revision)` a foreign key to `work_revision`, so the move raised 23505 whenever both items' claims had generation 1 (always, in this test), and `check_claim` refuses a claim that is not of its item's newest generation.
- **Change.** `work_ref` is read flat; the own claim is set aside as `released` and made `active` again after; the moved claim takes, for the call, a generation above every claim of the named item and that item's current revision, and gets its own three values back after. It still holds none of the build's checks.
- **Self-check (not a result; README section 10; counts: no: PostgreSQL 16.15 with M09-02's stand-ins `…/scratchpad/m0903_run/setup.sql`, unchanged).** One throwaway cluster (`…/scratchpad/n291_run/cl.sh`, socket `…/scratchpad/n9s`): `main` `6fd25a2`'s eighteen migrations, M09-01 to M09-06 among them (M09-06 sha256 `f13b7f00…`, as CHK-C02-092 names it), one fresh database per run; the breaks applied with `w07.throwaway = yes` by `…/scratchpad/n291_run/brk.sh`. Raw outputs: `…/scratchpad/n291_run/out/`. `register_artifact` and `prepare_operation` are not built, so 5C runs past its pre-check only on `…/scratchpad/n291_run/stub/stub_effects.sql` (labelled stub: the test designer's reading of EV-C02-013 2.6 and 2.7, `register_artifact`, `prepare_operation`, `record_attempt` and `accept`, which W-C02-09 has not built; not the build; added to the eighteen migrations as the database `base_stub`); `claim` and `check_claim` are the real M09-05.
  - Unpatched (`S_w07_5c_other_session_fake_id.txt`): PASS (8/8).
  - The merged patch (`B_5c1_merged_*`): PASS (8/8): nothing turns red (Fault 1).
  - The revised patch (`B_5c1_rev_*`): FAIL, exactly `5C-n1`, `-n2`, `-n4` bad; `5C-n3` and `-n5` green.
  - The patch's second file, `job/w07_n17_claim_token.sql`, stops at `N17-pre` on a correct build both unpatched and patched: its `devos_kurulum` fixture claim is on an item under an ordinary Mission, which `claim` refuses `not_owner` (EV-C02-013 18 (2) step 6). That is a fault of T-W07-N17 outside this revision (reported to the executor), so the break's `N17-n1` cannot be shown on the staged file yet. On a scratch copy with only that fixture moved under the installation's Mission (`…/scratchpad/n291_run/stub/n17_scratch_kur_fixture.sql`): unpatched PASS (13/13); the merged patch PASS (13/13); the revised patch FAIL, exactly `N17-n1` bad (`B_5c1_merged_n17s_*`, `B_5c1_rev_n17s_*`).
