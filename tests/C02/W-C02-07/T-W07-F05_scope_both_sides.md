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
