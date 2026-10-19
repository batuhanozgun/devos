# T-W07-F05 · Every operation checks the work item's, the target's and the source's scopes and revisions, on every path

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.f05`, work items in `synthetic.w07.f05.a` and `.b`, artifacts `w07_fixture/f05/*`, keys `w07_fixture_key_f05_*` and session ids `w07_fixture_session_*` are made up and labelled SYNTHETIC W-C02-07. Tokens are issued inside the rolled-back transaction and never leave PL/pgSQL variables.

**Serves.** W-C02-09 point 8 ("F05"); C02 Acceptance's first line, as T-W07-F01; Appendix C F05; B principle 4 (PC-42: a scope is a dotted path of lower-case labels; "within" means equal or under); EV-C02-002 DM-34 (Artifact and Finding carry `scope`).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_f05_scope_both_sides.sql`, run by the migration job's `devos-test` step as `postgres` (README 5.1 (a)); on the throwaway database by the break harness with `breaks/B-F05-1`.
**Time added to W-C02-13's run.** None: no schedule or limit.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 (the return form `{status, reason_code}`, refusals returned, the token and fixture functions), as `T-W07-F01` states it. Also:
- `devos_api.register_artifact(claim_token text, artifact jsonb)` with `{work_ref {id, revision}, path, commit, kind, scope, declared_session_id}` → `{status, id, revision}`. The target's scope is the artifact's `scope`.
- `devos_api.prepare_operation(claim_token text, p jsonb)` with `target_ref {id, revision}` naming an Artifact target, and `read_set [{ref, revision}]` naming sources (Artifacts or work items).
- `devos_api.revise_work(jsonb)` with `{id, base_revision, scope, reason}` → `{status, id, revision}`.


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
| Case | Input | Expected |
|---|---|---|
| F05-pos1 | `register_artifact` under work item A's claim, target scope = A's | `ok` |
| F05-pos2 | the same, target scope under A's (`…f05.a.sub`) | `ok` |
| F05-pos3 | `prepare_operation` under A's claim: target A's artifact, read set A and A's artifact, current revisions | `ok` |
| F05-a | `register_artifact` under A's claim with target scope `…f05.b` | `refused`, nothing changed |
| F05-d | `prepare_operation` under A's claim whose `target_ref` is B's artifact (scope `…f05.b`): the second function path | `refused`, nothing changed |
| F05-b | `prepare_operation` under A's claim whose read set holds B's artifact (a source in another scope) | `refused`, nothing changed |
| F05-c | after `revise_work` makes A revision 2: `prepare_operation` naming A at revision 1 | `refused`, nothing changed |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-F05`: no operation is accepted unless the work item's, the target's and every source's scopes lie within the work item's, at their current revisions, and each function path that writes or prepares against a target applies the same check. **[Designer's addition: no claim line in the F entries (R2 section 5 (c)); drawn from the class rule.]** |
| **Failure class rule** | Appendix C F05: "Every operation checks the work item, target and source scopes and their revisions together; different verification paths apply the same check." A member is any accepted call in which one of the three scopes, or one named revision, was not checked, on any path. |
| **Examples** | The original finding, a target in another scope with the same revision accepted: F05-a. Other manifestations: the same target check missing on a second path (F05-d); a source in another scope (F05-b); the right scope at an old revision (F05-c). |
| **Negative control** | F05-a, -d, -b and -c are each `refused`, and the state digest (every `devos_private` table except RejectedAttempt's and the token tables) is unchanged by the call. |
| **Positive control** | F05-pos1 to -pos3 are accepted. Each differs from its negative in one thing: F05-pos1 from F05-a in the target's scope; F05-pos3 from F05-d in the target and from F05-b in the source. |
| **Break attempt** | (1) Removed: the target scope check, on both paths (`register_artifact` and `prepare_operation`). (2) Path: `breaks/B-F05-1_target_scope_check_removed.sql`, on the throwaway database. Wrappers present the target with the work item's own scope to the build's check, then restore the requested scope. (3) F05-a and F05-d must turn red; F05-b and F05-c stay green. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (7/7); with the patch, exactly F05-a and F05-d were red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step, with synthetic tokens (EV-C02-003 §6.3). The throwaway PostgreSQL 17 database for the break. Never `devos`. No real token. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As `T-W07-F01` (README section 10). Written by the test designer (fresh-context `test-designer` subagent; agent ID in W-C02-07's Record). Run by the job, by W-C02-09's producer at its head, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. It does not show that a scope label is the right one for the content (semantic; sample review), the Data API header path, or `devos`. |
| **Evidence envelope** | README section 4. Fixed before the run: the expected outcomes above; PASS only at 7/7; the break's red cases F05-a and F05-d. `transport`: `sql-set-role` or `throwaway`. Raw evidence `W07-F05-<run_at>` under `evidence/C02/raw/`; observation: the job's run and step, or the harness output with the patch name. |

## Clause table
| Clause of Appendix C F05 (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "Class rule: Every operation checks the work item, target and source scopes and their revisions together; different verification paths apply the same check" | F05-a, F05-b, F05-c, F05-d | — |
| "(a) a target in another scope" | F05-a | — |
| "(b) a source in another scope" | F05-b | Sources are Artifacts or work items in the read set: Source (C04) is not built (B:69; EV-C02-002 DM-34). |
| "(c) the right scope, an old revision" | F05-c | — |
| "(d) the same operation attempted through a second function path" | F05-d | — |
| "Negative: All are rejected" | F05-a, F05-b, F05-c, F05-d | — |
| "Positive: The right scope and the current revision are accepted" | F05-pos1, F05-pos2, F05-pos3 | — |
| "Break: When the target scope check is removed, (a) must pass" | B-F05-1 (F05-a, F05-d) | — |

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK when the interface is absent, a fixture cannot be written, a call raises, or a refusal carries a token reason code. F05-c is `could_not_check` if the new revision cannot be planted.

## Not covered
- The Mission's scope at `admit_work` (T-W07-DM34).
- Sources of family Source (C04).
- Decision as a source: it has no scope and is checked by revision only (DM-34). No case here.

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_f05_scope_both_sides.sql`.
- **D-1 (EV-C02-013 section 1 item 3 and section 5 D-1): the flat reference form.** Every reference sent as an object `{"id", "revision"}` under a field name (`mission_ref`, `work_ref`, `from_ref`, `to_ref`, `target_ref`, `owner_authority`) is now sent flat: the field's Appendix B name holds the record's uuid and `<name without _ref>_revision` its revision (`owner_authority_revision` for `owner_authority`). Read-set entries (`{ref, revision}`) and internal helper objects are unchanged. `prepare_operation`'s `target_ref` is sent with `target_revision`. Open, reported: EV-C02-013 2.7 lists no `target_ref` among `prepare_operation`'s keys, and keys a function does not read are ignored (section 1 item 4), so F05-pos3, F05-d and F05-b depend on a key the record does not name; the executor settles it (a key of the build, or a revision of these cases) before the first result.

## Revision before any result (EV-C02-013 Revision 2, 2026-10-18)
Under ledger rule 3, before any result of W-C02-09's build beyond its first migration (M09-01, merged and applied; no function this file calls but the identity chain's exists), by the test designer, a fresh-context subagent of type `test-designer` of the working session (agent `a9863a9a24b64f461`, filled in by the executor at filing), from `evidence/C02/EV-C02-013_w09_interface.md` Revision 2 (section 14, its list "For the test designer", at branch `claude/c02-w09-rev2` `a542f83`, on `main` `4630798`). One checker judges this revision with Revision 2 before M09-02's first commit. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_f05_scope_both_sides.sql`.
- **R2-7 (EV-C02-013 2.2, K2; N-279 (16)):** the fixture Mission's owner-planted `batu` Decision (`pg_temp.w07_fixture_mission`) now names `answered_revision` 1, the revision answered (DM-11 (a)), which `open_mission` compares with `owner_authority_revision`; an answered Decision with NULL `answered_revision` is `could_not_check` under the record. Without it, every case of this file gave `could_not_check`.
- **Self-check (counts: no: self-check on 16.15):** on a scratch stub of `open_mission` written from EV-C02-013 2.2 (Revision 2's order of checks; not the build), this file's `pg_temp.w07_fixture_mission`, taken from the file unchanged, opens its Mission (`ok`, revision 1); the merged version of the same helper gave "fixture mission not opened: could_not_check"; an answered `batu` Decision with NULL `answered_revision` gives `could_not_check` (`owner_authority: answered_revision missing`).

## Revision under ledger rule 3 (N-285, 2026-10-18)
Under ledger rule 3 and README section 8, before any result of this test: `job/w07_f05_scope_both_sides.sql` is not in `supabase/migrations/tests/` (W-C02-09 copies it) and has no counted result; any earlier result of the changed file is void and the test is run again. Origin: note N-285 item (4) on `plan/work/C02.md` (branch `claude/c02-w09-m0904`) with CHK-C02-089 C1, and EV-C02-014 5.4. Deadline met: before the file's first result and before the pull request that copies it. By the test designer, a fresh-context subagent of type `test-designer` (named by the executor at filing). **No case ID, expected outcome or break red list is changed; F05-c asks the same.**
- **Files changed:** this specification (this section); `job/w07_f05_scope_both_sides.sql` (header lines 11-12; lines 364-371).
- **Fault.** F05 (c) revises the work item `wa` and then names its old revision in an operation. The revision sent only the scope `wa` already had, plus a reason. Under EV-C02-013 2.3 ("same content: repeat") and R2-9 that is an exact repeat: `ok`, `"repeat": true`, no new revision. The file's guard (a new revision must exist) then raised, so F05-c was `could_not_check` on a correct build.
- **Change.** The revision sends a changed scope, `synthetic.w07.f05.a.c`, narrowed under `wa`'s own, with its reason. The operation's work item stays within the Mission's scope and its own, and the operation names no target record. So the old revision is the only thing the operation of F05-c gets wrong; it is judged `refused`, as before.
- **Self-check (not a result; README section 10; counts: no: PostgreSQL 16.15 with M09-02's stand-ins).** Same cluster as T-W07-F06's revision of this date: `main`'s fifteen migrations at `fc9fc7c` and the real M09-04 (`open_mission`, `admit_work`, `revise_work`). `claim`, `register_artifact` and `prepare_operation` are not built yet (M09-05, M09-07, M09-08), so a scratch stub stands in for them (`…/scratchpad/n285_run/stub/stub_effects.sql`). Its re-check at the effect is the test designer's reading of EV-C02-013 2.7, not the build, and the setting `w07stub.recheck=off` removes it. Raw outputs: `…/scratchpad/n285_run/out/`.
  - The merged file on the stub (`S01_f05_old_stub.txt`): COULD NOT CHECK (1 of 7); `F05-c` "the new revision could not be planted", because the real `revise_work` answered the repeat.
  - The revised file (`S01_f05_new_stub.txt`): PASS (7/7); `F05-c` "refused: stale_revision".
  - With the stub's re-check removed (`S02_f05_new_stub_recheck_off.txt`): FAIL (1 bad), exactly `F05-c` ("accepted, wanted refused").
- **Not changed (reported):** F05-c, like the other Group A negatives, takes any refusal but a token code or `could_not_check` as the rule's (`w07_judge` with `refused`). Its operation is built so that only the revision can be refused.

## Revision under ledger rule 3 (N-290, 2026-10-19)
Under ledger rule 3 and README section 8, before any result of this test: the break `breaks/B-F05-1_target_scope_check_removed.sql` (the job file is not changed) is not in `supabase/migrations/tests/` (at `main` `6fd25a2`) and has no counted result; the runs of the staged file in M09-06's record (EV-C02-014 section 7) and in CHK-C02-092 are self-checks, never results, and any earlier result of the changed file is void; the test is run again. Origin: note N-290 item (1) on `plan/work/C02.md`, CHK-C02-090 finding 12, EV-C02-013 2.6 and 2.7. Deadline met: before the break's first run and before the pull request that copies F05. By the test designer, a fresh-context subagent of type `test-designer` (named by the executor at filing). **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification (this section); `breaks/B-F05-1_target_scope_check_removed.sql` (header lines 11-16; lines 31, 43 and 45).
- **Fault.** The wrappers read `p->'work_ref'->>'id'` and `p->'target_ref'->>'id'`, the object form EV-C02-013 2.6 and 2.7 replaced, and the work item's scope from `devos_private.work.scope`, a column that does not exist (the scope is in `work_revision`): applied to a correct build the patch raised 42703 at its first call, so F05 ended at `F05-pre`, not red.
- **Change.** Both references are read flat, and the work item's scope is read from `devos_private.work_current` (its current revision; W-C02-08's migration `20261014170205`).
- **Self-check (not a result; README section 10; counts: no: PostgreSQL 16.15 with M09-02's stand-ins `…/scratchpad/m0903_run/setup.sql`, unchanged).** One throwaway cluster (`…/scratchpad/n291_run/cl.sh`, socket `…/scratchpad/n9s`): `main` `6fd25a2`'s eighteen migrations, M09-01 to M09-06 among them (M09-06 sha256 `f13b7f00…`, as CHK-C02-092 names it), one fresh database per run; the breaks applied with `w07.throwaway = yes` by `…/scratchpad/n291_run/brk.sh`. Raw outputs: `…/scratchpad/n291_run/out/`. `register_artifact` and `prepare_operation` are not built, so F05 runs past its pre-check only on `…/scratchpad/n291_run/stub/stub_effects.sql` (labelled stub: the test designer's reading of EV-C02-013 2.6 and 2.7, `register_artifact`, `prepare_operation`, `record_attempt` and `accept`, which W-C02-09 has not built; not the build; added to the eighteen migrations as the database `base_stub`).
  - Unpatched (`S_w07_f05_scope_both_sides.txt`): PASS (7/7).
  - The merged patch (`B_f051_merged_*`): COULD NOT CHECK (1 of 1), `F05-pre` (42703 in a fixture's call).
  - The revised patch (`B_f051_rev_*`): FAIL, exactly `F05-a` and `F05-d` bad; `F05-b`, `-c` and the positives green.
