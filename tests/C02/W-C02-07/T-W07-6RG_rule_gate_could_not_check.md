# T-W07-6RG · The rule gate's checks answer "could not check" to missing, unreadable and partial input, and let nothing through

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.rg`, twelve work items, relations, keys `w07_fixture_key_rg_*` and random ids for missing records are made up and labelled SYNTHETIC W-C02-07. The broken inputs are planted by the owner inside subtransactions that are rolled back before the next case: renames, a deleted row, nulls, a revision pointer. This is W-C02-03's technique in `w03_drift_could_not_check.sql`.

**Serves.** W-C02-09 point 7; W-C02-07 point 6; plan Section 8 item 14; PC-16; B principle 6; EV-C02-002 DM-01 (the global authority epoch), DM-06 (expiry computed at `claim`, `ready_works()` and every effect), DM-37 (the read set); GROUPS.md section 3's rows for the rule gate.
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_6rg_rule_gate_could_not_check.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-6RG-1` and `-2`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it. Also:
- "Could not check" is returned in README 8.1's form, `{"status": "refused", "reason_code": "could_not_check", "reason": "<the input that could not be read>"}`, apart from clean (`ok`) and from fail (`refused` with any other code) (W-C02-09 point 7: "records 'could not check' with its reason"). Phase C5 (CHK-C02-030 C8): the per-check counts (the notice `W07_6RG answers`) and `w07_ready_case` read that form: it is counted as could not check, never as refused, and `ready_works()`'s could-not-check answer is taken as "not listed". Any other form (a raised error, `status = could_not_check`, no object) is the test's own `could_not_check`, never a pass (README 8.1).
- The global authority epoch is the one `devos_private` table whose name contains `epoch`, with an integer column whose name contains `epoch`; it is found in the catalogue.
- `devos_api.ready_works()` → `{status, works [{id}]}`.
- `devos_api.relate(jsonb)` with `{type, from_ref {id, revision}, to_ref {id, revision}, hard, group_mode, scope, method, epistemic_status}`.
- `devos_private.work (execution, acceptance)`, or `devos_private.work_revision` if it exists, for the unreadable reference.
- `devos_private.relation (from_ref, to_revision)`, and `devos_private.assignment (lease_expires_at, generation)`.


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
Each "could not check" case wants the answer `could_not_check`, and the state digest unchanged by the call (the write blocked).
| Check | Case | Planted input | Call | Wanted |
|---|---|---|---|---|
| Global authority epoch | 6RG-e0 | none (positive control) | effect | `ok` |
| | 6RG-e1 | the epoch row deleted (missing) | effect | `could_not_check` |
| | 6RG-e2 | the epoch table renamed (unreadable) | effect | `could_not_check` |
| | 6RG-e3 | the epoch value null (partial) | effect | `could_not_check` |
| | 6RG-e4 | the epoch row deleted | `claim` | `could_not_check` |
| Referenced record or revision | 6RG-r0 | none | `relate` | `ok` |
| | 6RG-r1 | `to_ref` a random id (record missing) | `relate` | `could_not_check` |
| | 6RG-r2 | `to_ref` revision 999 (revision missing) | `relate` | `could_not_check` |
| | 6RG-r3 | `to_ref` without its revision (partial) | `relate` | `could_not_check` |
| | 6RG-r4 | the work revision table renamed (unreadable) | `relate` | `could_not_check` |
| Read-set element | 6RG-s0 | none | `prepare_operation` | `ok` |
| | 6RG-s1 | an element with a random id (missing) | `prepare_operation` | `could_not_check` |
| | 6RG-s2 | an element without its revision (partial) | `prepare_operation` | `could_not_check` |
| | 6RG-s3 | the elements' table renamed (unreadable) | `prepare_operation` | `could_not_check` |
| The effect-class read (EV-C02-002 DM-37; phase C5, CHK-C02-030 C7 (c)) | 6RG-c1 | the synthetic class's row deleted (missing) | `prepare_operation`, the call of 6RG-s0 (its positive pair) | `could_not_check` |
| | 6RG-c2 | the effect-class table renamed (unreadable) | `prepare_operation` | `could_not_check` |
| | 6RG-c3 | its `irreversible` null (partial) | `prepare_operation` | `could_not_check` |

Phase C6 (CHK-C02-030 C7): every case that wants `could_not_check` also wants nothing returned through it: an answer that carries a key naming or holding a record, an operation, a claim or a list (`id`, `operation_id`, `claim_token`, `assignment_id`, `revision`, `records`, `works`, `paths`, `rows`) is `bad`, and the state digest must be unchanged. 6RG-c1 and -c3 turn the effect-class table's user triggers off for the plant only, as 6RG-e1 and -e3 do. The keys are interface v1's choice (README 8.1) and are revised with it before the first result. 6RG-c1 to -c3 and their place in B-6RG-1 were not run on a scratch stub: the stubs at hand do not build the epoch table and effect-class read in README 8.1's form, so B-6RG-1's red set for them rests on its patch text until W-C02-13 shows it.
| Readiness group | 6RG-g0 | the member true | `ready_works()` | the work item listed |
| | 6RG-g1 | the member's state null (partial: unknown) | `ready_works()` | not listed |
| | 6RG-g2 | the relation's target revision 999 (member missing: unknown) | `ready_works()` | not listed |
| | 6RG-g3 | the relation table renamed (unreadable) | `claim` | `could_not_check` |
| Claim's lease or generation | 6RG-l0 | none | effect | `ok` |
| | 6RG-l1 | the active claim's lease null (missing) | the next `claim` | `could_not_check` |
| | 6RG-l2 | the lease column renamed (unreadable) | the next `claim` | `could_not_check` |
| | 6RG-l3 | the generation null (partial) | the next `claim` | `could_not_check` |
| | 6RG-l4 | the lease null | effect | `could_not_check` |
| | 6RG-l5 | the lease null | `ready_works()` | not listed |

**From 2026-10-19 (N-301, under ledger rule 3): the two reads that hand a check of the gate its input** (M09-09; EV-C02-008 1.4 rows R12 and R13). Each is planted and judged as above, with the state digest unchanged and nothing returned through a could-not-check answer.
| Check | Case | Planted input | Call | Wanted |
|---|---|---|---|---|
| The epoch's read (B principle 9; EV-C02-013 24 (7)) | 6RG-a0 | none (positive control) | `authority_epoch()`, working token | `ok` |
| | 6RG-a1 | the epoch row deleted (missing) | `authority_epoch()` | `could_not_check` |
| | 6RG-a2 | the epoch value null (partial) | `authority_epoch()` | `could_not_check` |
| The fingerprint store's read (Appendix C N06; B 3.23; EV-C02-013 24 (6)) | 6RG-f0 | none (positive control) | `fingerprint_matches(array['w07_fixture_hash_rg'])`, `devos_ci` token | `ok` |
| | 6RG-f1 | the store's table renamed (absent to its reader) | the same call | `could_not_check` |

The run also prints, per check, the counts of `ok`, `refused`, `could_not_check` and other answers, with the denominator (README section 3).

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-6RG`: each rule-gate check of W-C02-09 point 7, given missing, unreadable or partial input, answers "could not check", kept apart from clean and from fail, and lets no write through. A readiness group with an unknown member is not ready. |
| **Failure class rule** | Any check whose input it could not read in full gives an answer other than "could not check": clean, which lets the write through, or fail, which hides the cause. Or it lets a write through. **[Designer's addition: point 6 gives inputs, not a class rule.]** |
| **Examples** | One per input form for each check above: the epoch (e1 to e4), references (r1 to r4), read set (s1 to s3), the effect-class read (c1 to c3, phase C5), readiness (g1 to g3), lease and generation (l1 to l5). **[Designer's addition.]** |
| **Negative control** | Each planted case must answer `could_not_check` with the state unchanged and (phase C6) nothing returned through it; for readiness, not ready. "Clean" (`ok`) is `bad`; `refused` is `bad` (folded into fail). |
| **Positive control** | e0, r0, s0 (also c1 to c3's pair), g0 and l0: the same call on readable input is accepted (listed). Each planted case differs from its control only in the planted input, so a check that refuses everything fails. |
| **Break attempt** | (1) `breaks/B-6RG-1_could_not_check_as_clean.sql` folds "could not check" into clean in `register_artifact`, `relate`, `prepare_operation` and `claim`. e1 to e4, r1 to r4, s1 to s3, c1 to c3 (phase C5), g3 and l1 to l4 must turn red. (2) `breaks/B-6RG-2_unknown_member_counted_ready.sql` makes `ready_works()` offer every work item without a known-live claim. g1, g2 and l5 must turn red. From 2026-10-19 (N-301): (3) `breaks/B-6RG-3_epoch_read_missing_as_clean.sql` wraps `authority_epoch` so that its could-not-check answer becomes `{"status": "ok", "epoch": null}`: 6RG-a1 and -a2 must turn red. (4) `breaks/B-6RG-4_fingerprint_store_absent_as_clean.sql` wraps `fingerprint_matches` so that its could-not-check answer becomes "no match": 6RG-f1 must turn red. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (24/24); each patch turned exactly its named cases red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step: owner-level plants inside rolled-back subtransactions, as W-C02-03 does there. The throwaway PostgreSQL 17 database for the breaks. Never `devos`. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; phase B, Group A; the effect-class cases and the v1 counts, phase C5; agent IDs in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the breaks. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. Planted states model unreadable input by renames and nulls. They do not show every way a real read can fail (a lost connection mid-call, permissions). The token header's forms are `T-W07-6TK`'s (Group D). |
| **Evidence envelope** | README section 4. Fixed before the run: the wanted answers above; PASS at 27/27 (24 before phase C5, plus 6RG-c1 to -c3); from 2026-10-19 (N-301), 32/32, with 6RG-a0 to -a2, -f0 and -f1; the breaks' red cases. Raw evidence `W07-6RG-<run_at>`, with the per-check counts. |

## Clause table
Not an Appendix C test (W-C02-07 point 6). Mapping to GROUPS.md section 3's rule-gate rows: the global authority epoch (e1 to e4); a referenced record or revision (r1 to r4); an element of the read set (s1 to s3); readiness with an unknown member (g1 to g3); the claim's expiry inputs (l1 to l5); and (phase C5, CHK-C02-030 C7 (c); TABLES K24) the effect-class read under `prepare_operation`, EV-C02-002 DM-37 (c1 to c3). The token header is `T-W07-6TK`'s; `affected_entities` at a limit is `T-W07-F04` (d)'s.

## Format gate
Not a format-gate test.

## Could not check
The test's own COULD NOT CHECK, kind (ii) of README section 3, applies:
- before the build;
- when the epoch's table is not found;
- when a fixture cannot be written;
- when a planted state cannot be made (that case is `could_not_check`);
- when a call raises;
- when an answer is neither `ok`, `refused` nor `could_not_check`.

## Not covered
- The header's forms (6TK).
- The checks that read database settings (6ST, Group C).
- A lost connection in mid-call.
- `deployment_drift` (W-C02-03's T-W03-07).
- From 2026-10-19 (N-301): three rules of `fingerprint_matches` that EV-C02-014 section 11 lists as reached by the producer's self-check alone are left without a case. No source the task names (Appendix B 3.23, principle 9; Appendix C N06; EV-C02-008 1.4) requires the form the build chose:
  - *k18: the answer holds no `source_ref`.* N06's positive control lets "the source ID go in", and B 3.23 keeps no content, so no column of the store can carry the matched text that N06 bars from the audit record.
  - *k19: an empty array refused `invalid_field`.* Admitted, it answers "no match" for no hash. Whether a check computed its hashes is C03 test 6's check's input (EV-C02-008 1.4: "C03 may revise it before test 6"). The refusal is EV-C02-013 2.8's choice.
  - The partial forms of the store's rows: every column a match returns is NOT NULL (W-C02-08's `leak_fingerprint`).
- What the epoch's and the store's readers answer over the Data API, and what C03's checks do with the answer (C03 test 6, N06).

## Revision under ledger rule 3 (N-301, 2026-10-19)
Under ledger rule 3 and README section 8. This file is not in `supabase/migrations/tests/` at `main` `6ec7a53`, so the migration job has never run it. Any earlier result of it is void, and the test is repeated (the executor's decision). Origin: note N-301 on `plan/work/C02.md` (branch `claude/c02-w09-m0909`): of the rules M09-09's producer built, those no merged case reaches (EV-C02-014 section 11) are weighed by the test designer. By the test designer, a fresh-context subagent of type `test-designer` (named by the executor at filing). **No case ID, expected outcome or break red list is changed. Five case IDs are added (6RG-a0, -a1, -a2, -f0, -f1), with two breaks (B-6RG-3, B-6RG-4).**
- **Files changed:** this specification; `job/w07_6rg_rule_gate_could_not_check.sql` (the header, a `ci` variable, and section 6 of the main block); new `breaks/B-6RG-3_epoch_read_missing_as_clean.sql` and `B-6RG-4_fingerprint_store_absent_as_clean.sql`; `TABLES.md` (section 3's K26 and K27; section 4's row).
- **Why these two reads, here.** k17 and k20 of EV-C02-014 section 11 fold a missing or absent input of a read into a clean answer: `authority_epoch` answering `ok` with no epoch, and `fingerprint_matches` answering "no match" with the store absent. Appendix C N06 names the second ("with the fingerprint store absent, the write is stopped as 'could not check', not let through as clean"). B principle 9's single counter, with plan Section 8 item 14, gives the first. Each read hands a check of the gate its input (EV-C02-008 1.4 rows R12 and R13), so this test's failure class rule ("any check whose input it could not read in full gives an answer other than could not check") takes them in.
- **What this asks of W-C02-09's copy.** On a build without M09-09 the five calls raise (no function), which is the test's own `could_not_check`, so the file is COULD NOT CHECK there and is copied after M09-09 (README 5.1 (c)).
- **Self-check (not a result; counts: no: PostgreSQL 16.15, offline).** Set-up as in `T-W07-N08`'s revision section of this date (`…/scratchpad/n301_run/`).
  - Merged file on the build: `PASS (27/27)` (`out/02_merged_6rg_dm19b.txt`). Revised: `PASS (32/32)`, with the counts `6RG-a`: clean 1, could not check 2, of 3, and `6RG-f`: clean 1, could not check 1, of 2 (`out/04_revised_6rg_dm19b_direct.txt`). On a database without the build: `COULD NOT CHECK` at `6RG-pre` (`out/05_revised_empty_db.txt`). On `main`'s twenty-one migrations without M09-09: `COULD NOT CHECK`, the five new cases `could_not_check` (42883) and every other case `ok` (`out/06_revised_main_without_m0909.txt`).
  - Through the harness, on the revised file: B-6RG-1 and B-6RG-2 shown, unchanged; B-6RG-3 shown, red exactly 6RG-a1 and -a2; B-6RG-4 shown, red exactly 6RG-f1 (`out/14_revised_harness_all.txt`). On the merged file, B-6RG-3 and B-6RG-4 leave it PASS: not shown (`out/13_merged_harness_new_patches.txt`).

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_6rg_rule_gate_could_not_check.sql`.
- **D-1 (EV-C02-013 section 1 item 3 and section 5 D-1): the flat reference form.** Every reference sent as an object `{"id", "revision"}` under a field name (`mission_ref`, `work_ref`, `from_ref`, `to_ref`, `target_ref`, `owner_authority`) is now sent flat: the field's Appendix B name holds the record's uuid and `<name without _ref>_revision` its revision (`owner_authority_revision` for `owner_authority`). Read-set entries (`{ref, revision}`) and internal helper objects are unchanged. `pg_temp.w07_rel` sends `to_ref` and, only when the end carries one, `to_revision`, so 6RG-r3's end "partial (no revision)" is sent without `to_revision` (EV-C02-013 2.5: a revisioned record's end sent without its revision is `could_not_check`). Section 13 of the record asks no other change here: the expected outcomes are what its section 1 item 7 builds.

## Revision before any result (EV-C02-013 Revision 2, 2026-10-18)
Under ledger rule 3, before any result of W-C02-09's build beyond its first migration (M09-01, merged and applied; no function this file calls but the identity chain's exists), by the test designer, a fresh-context subagent of type `test-designer` of the working session (agent `a9863a9a24b64f461`, filled in by the executor at filing), from `evidence/C02/EV-C02-013_w09_interface.md` Revision 2 (section 14, its list "For the test designer", at branch `claude/c02-w09-rev2` `a542f83`, on `main` `4630798`). One checker judges this revision with Revision 2 before M09-02's first commit. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_6rg_rule_gate_could_not_check.sql`.
- **R2-7 (EV-C02-013 2.2, K2; N-279 (16)):** the fixture Mission's owner-planted `batu` Decision (`pg_temp.w07_fixture_mission`) now names `answered_revision` 1, the revision answered (DM-11 (a)), which `open_mission` compares with `owner_authority_revision`; an answered Decision with NULL `answered_revision` is `could_not_check` under the record. Without it, every case of this file gave `could_not_check`.
- **Self-check (counts: no: self-check on 16.15):** on a scratch stub of `open_mission` written from EV-C02-013 2.2 (Revision 2's order of checks; not the build), this file's `pg_temp.w07_fixture_mission`, taken from the file unchanged, opens its Mission (`ok`, revision 1); the merged version of the same helper gave "fixture mission not opened: could_not_check"; an answered `batu` Decision with NULL `answered_revision` gives `could_not_check` (`owner_authority: answered_revision missing`).
