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

The run also prints, per check, the counts of `ok`, `refused`, `could_not_check` and other answers, with the denominator (README section 3).

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-6RG`: each rule-gate check of W-C02-09 point 7, given missing, unreadable or partial input, answers "could not check", kept apart from clean and from fail, and lets no write through. A readiness group with an unknown member is not ready. |
| **Failure class rule** | Any check whose input it could not read in full gives an answer other than "could not check": clean, which lets the write through, or fail, which hides the cause. Or it lets a write through. **[Designer's addition: point 6 gives inputs, not a class rule.]** |
| **Examples** | One per input form for each check above: the epoch (e1 to e4), references (r1 to r4), read set (s1 to s3), readiness (g1 to g3), lease and generation (l1 to l5). **[Designer's addition.]** |
| **Negative control** | Each planted case must answer `could_not_check` with the state unchanged; for readiness, not ready. "Clean" (`ok`) is `bad`; `refused` is `bad` (folded into fail). |
| **Positive control** | e0, r0, s0, g0 and l0: the same call on readable input is accepted (listed). Each planted case differs from its control only in the planted input, so a check that refuses everything fails. |
| **Break attempt** | (1) `breaks/B-6RG-1_could_not_check_as_clean.sql` folds "could not check" into clean in `register_artifact`, `relate`, `prepare_operation` and `claim`. e1 to e4, r1 to r4, s1 to s3, c1 to c3 (phase C5), g3 and l1 to l4 must turn red. (2) `breaks/B-6RG-2_unknown_member_counted_ready.sql` makes `ready_works()` offer every work item without a known-live claim. g1, g2 and l5 must turn red. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (24/24); each patch turned exactly its named cases red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step: owner-level plants inside rolled-back subtransactions, as W-C02-03 does there. The throwaway PostgreSQL 17 database for the breaks. Never `devos`. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; phase B, Group A; the effect-class cases and the v1 counts, phase C5; agent IDs in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the breaks. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. Planted states model unreadable input by renames and nulls. They do not show every way a real read can fail (a lost connection mid-call, permissions). The token header's forms are `T-W07-6TK`'s (Group D). |
| **Evidence envelope** | README section 4. Fixed before the run: the wanted answers above; PASS at 24/24; the breaks' red cases. Raw evidence `W07-6RG-<run_at>`, with the per-check counts. |

## Clause table
Not an Appendix C test (W-C02-07 point 6). Mapping to GROUPS.md section 3's rule-gate rows: the global authority epoch (e1 to e4); a referenced record or revision (r1 to r4); an element of the read set (s1 to s3); readiness with an unknown member (g1 to g3); the claim's expiry inputs (l1 to l5). The token header is `T-W07-6TK`'s; `affected_entities` at a limit is `T-W07-F04` (d)'s.

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
