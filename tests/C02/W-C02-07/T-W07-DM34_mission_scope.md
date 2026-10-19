# T-W07-DM34 · A work item's scope cannot lie outside its Mission's

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.dm34` and the scopes tried (`synthetic.w07.other`, `synthetic.w07.dm34x`, `synthetic.w07`, malformed forms) are made up and labelled SYNTHETIC W-C02-07.

**Serves.** W-C02-09 point 8 ("every other test W-C02-07's record assigns to this item"); EV-C02-002 DM-34 and section 6 ("a scope outside the Mission refused at `admit_work`"); B principle 4 (PC-42: a dotted path of lower-case labels; a work item's scope lies within its Mission's) and B 3.1 ("Opening internal work cannot widen the mission's scope").
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_dm34_mission_scope.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-DM34-1`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it (the fixture Mission, `admit_work`'s payload, the return form). Also `devos_api.revise_work(jsonb)` with `{id, base_revision, scope, reason}`. A malformed scope is refused, not normalised.


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
| Case | Input | Expected |
|---|---|---|
| DM34-pos1 | `admit_work`, scope = the Mission's | `ok` |
| DM34-pos2 | `admit_work`, `synthetic.w07.dm34.sub` | `ok` |
| DM34-n1 | `synthetic.w07.other` (a sibling) | `refused`, nothing changed |
| DM34-n2 | `synthetic.w07.dm34x` (a string prefix, not a path prefix) | `refused` |
| DM34-n3 | `synthetic.w07` (wider than the Mission) | `refused` |
| DM34-n4 | `synthetic.w07.DM34.sub` (upper case) | `refused` |
| DM34-n5 | `synthetic.w07.dm34..sub` (an empty label) | `refused` |
| DM34-n6 | `synthetic.w07.dm34.` (a trailing dot) | `refused` |
| DM34-n7 | `revise_work` moving DM34-pos1's work item to `synthetic.w07.other` | `refused`, nothing changed |
| DM34-pos3 | `revise_work` narrowing it to `synthetic.w07.dm34.narrower` | `ok` |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-DM34`: a work item is admitted, or revised, only with a well-formed scope equal to or under its Mission's. |
| **Failure class rule** | Any work item whose scope ends up outside its Mission's, on any path, including by a prefix test on strings, by a malformed path, or by a revision. **[Designer's addition: a rule added by a design record.]** |
| **Examples** | The rule's case, a sibling scope: DM34-n1. Others: the string-prefix trap (n2), widening (n3), malformed paths (n4 to n6), the revision path (n7). **[Designer's addition.]** |
| **Negative control** | DM34-n1 to -n7 refused, with nothing changed. |
| **Positive control** | DM34-pos1 to -pos3 accepted. DM34-pos2 differs from DM34-n2 only by the dot. |
| **Break attempt** | `breaks/B-DM34-1_admit_scope_check_removed.sql` removes admit_work's scope check. A wrapper presents the Mission's own scope to the build's function, then writes the requested scope. DM34-n1 to -n6 must turn red. DM34-n7 stays green (revise_work keeps its check). Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (10/10); patched, exactly n1 to n6 red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step, with synthetic tokens. The throwaway PostgreSQL 17 database for the break. Never `devos`. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; agent ID in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. It does not show that a scope is the right one for the work (sample review), or the Mission's own rule (N29's class part, Group C). |
| **Evidence envelope** | README section 4. Fixed before the run: the outcomes above; PASS at 10/10; the break's six red cases. Raw evidence `W07-DM34-<run_at>`. |

## Clause table
Not an Appendix C test (EV-C02-002 section 6; GROUPS.md section 4). Targets and sources: T-W07-F05.

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK before the build, when the fixture Mission cannot be opened, when a call raises, or when a refusal carries a token reason code. DM34-n7 and -pos3 are `could_not_check` when DM34-pos1 admitted nothing.

## Not covered
- The Mission's opening rule (N29, Group C).
- A Mission's own widening (`revise_mission`; N29 and the matrix).

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_dm34_mission_scope.sql`.
- **D-1 (EV-C02-013 section 1 item 3 and section 5 D-1): the flat reference form.** Every reference sent as an object `{"id", "revision"}` under a field name (`mission_ref`, `work_ref`, `from_ref`, `to_ref`, `target_ref`, `owner_authority`) is now sent flat: the field's Appendix B name holds the record's uuid and `<name without _ref>_revision` its revision (`owner_authority_revision` for `owner_authority`). Read-set entries (`{ref, revision}`) and internal helper objects are unchanged.

## Revision before any result (EV-C02-013 Revision 2, 2026-10-18)
Under ledger rule 3, before any result of W-C02-09's build beyond its first migration (M09-01, merged and applied; no function this file calls but the identity chain's exists), by the test designer, a fresh-context subagent of type `test-designer` of the working session (agent `a9863a9a24b64f461`, filled in by the executor at filing), from `evidence/C02/EV-C02-013_w09_interface.md` Revision 2 (section 14, its list "For the test designer", at branch `claude/c02-w09-rev2` `a542f83`, on `main` `4630798`). One checker judges this revision with Revision 2 before M09-02's first commit. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_dm34_mission_scope.sql`.
- **R2-7 (EV-C02-013 2.2, K2; N-279 (16)):** the fixture Mission's owner-planted `batu` Decision (`pg_temp.w07_fixture_mission`) now names `answered_revision` 1, the revision answered (DM-11 (a)), which `open_mission` compares with `owner_authority_revision`; an answered Decision with NULL `answered_revision` is `could_not_check` under the record. Without it, every case of this file gave `could_not_check`.
- **Self-check (counts: no: self-check on 16.15):** on a scratch stub of `open_mission` written from EV-C02-013 2.2 (Revision 2's order of checks; not the build), this file's `pg_temp.w07_fixture_mission`, taken from the file unchanged, opens its Mission (`ok`, revision 1); the merged version of the same helper gave "fixture mission not opened: could_not_check"; an answered `batu` Decision with NULL `answered_revision` gives `could_not_check` (`owner_authority: answered_revision missing`).

## Revision under ledger rule 3 (N-285, 2026-10-18)
Under ledger rule 3 and README section 8, before any result of this test's break. The break has never been shown: the harness has not run it on any build. `job/w07_dm34_mission_scope.sql` is not in `supabase/migrations/tests/`, and its runs in EV-C02-014 5.5 (run 06) and CHK-C02-089 are self-checks. Any earlier result of the break is void, and it is run again (W-C02-13). Origin: note N-285 item (3) on `plan/work/C02.md` (branch `claude/c02-w09-m0904`) with CHK-C02-089 C2 (a), and EV-C02-014 5.4. Deadline met: before the break's first result. By the test designer, a fresh-context subagent of type `test-designer` (named by the executor at filing). **No case ID, expected outcome or red list is changed:** `expect-red=DM34-n1,…,DM34-n6`, with DM34-n7 to stay green, as before. The test file is not changed.
- **Files changed:** this specification (this section); `breaks/B-DM34-1_admit_scope_check_removed.sql`, rewritten (lines 8-62).
- **Fault.** The wrapper read `devos_private.mission.scope`, a column the table does not have (the scope is in `mission_revision`, migration `20261014170203`). It also read `mission_ref` as an object (`p->'mission_ref'->>'id'`, D-1's old form; EV-C02-013 section 1 item 3 makes it the uuid, with `mission_revision` beside it). Applied, every call raised 42703, and DM34 ended COULD NOT CHECK, 10 of 10: the break was "not shown" on any build. The first version also updated `devos_private.work.scope`, which is `work_revision`'s column too.
- **Change.** The wrapper reads the scope of the Mission revision the call names (`mission_ref`, `mission_revision`) from `devos_private.mission_revision`, and calls the build's `admit_work` with that scope in place of the requested one. Every other rule of the build stays in place: the Mission's state, `stale_revision`, the form of the other fields. A call that names no such revision, or sends no string scope, is passed through unchanged, so the build's own answer stands. The requested scope is then written onto the admitted item's revision, in the form the N-283 revision gave B-N29-4: `work_revision_append_only` is turned off only for that update, and the guard block checks that the trigger exists. The guard and the change run as one transaction (README 5.2).
- **What the wrapper cannot write.** For DM34-n4 to -n6 (upper-case labels, an empty label, a trailing dot), the update is undone: `work_revision`'s own CHECK on the scope's form (migration `20261014170203`) is a second layer, which this break does not remove. The item keeps the Mission's scope, and the answer stays the build's `ok`, which is what those cases judge ("accepted, wanted refused"). The `work_admitted` event's payload names the Mission's scope; DM34 reads no event.
- **Self-check (not a result; README section 10; counts: no: PostgreSQL 16.15 with M09-02's stand-ins).** Same cluster as T-W07-F06's revision of this date: `main`'s fifteen migrations at `fc9fc7c` and the real M09-04 from `claude/c02-w09-m0904` (sha256 `165ea699…01d5`). Patches applied with `w07.throwaway=yes`. Raw outputs: `…/scratchpad/n285_run/out/`.
  - Unpatched (`R02_dm34_unpatched.txt`): PASS (10/10).
  - The merged break (`R03`, `R04`): applied, DM34 is COULD NOT CHECK (10 of 10), "raised 42703 column "scope" does not exist", as CHK-C02-089 C2 (a) found.
  - The revised break (`R09`, `R10`): FAIL (6 bad, 0 could not check, of 10). Exactly DM34-n1 to -n6 are `bad` ("accepted, wanted refused"); DM34-n7 stays `ok` ("refused: scope_outside"), and pos1 to pos3 stay `ok`.
  - Restored, on a fresh database (`R11`): PASS (10/10).
  - Without `w07.throwaway` (`R12`), the guard refuses ("the setting w07.throwaway is not yes"), exit 3, and no wrapper is made.
  - A probe of what the wrapper stores (`R13_bdm34_probe.txt`): a sibling scope `synthetic.w07.other` is answered `ok` and stored as requested; `synthetic.w07.DM34.sub` is answered `ok` and stored as the Mission's `synthetic.w07.dm34`.
- The "Break attempt" field above, written before this revision, describes the same mechanism and red list. It still holds.
