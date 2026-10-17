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
