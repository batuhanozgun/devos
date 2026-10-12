# T-W07-F01 · An idempotency key is bound to the operation's whole intent

Synthetic test data (plan Section 8 item 13): the Mission and work items under scope `synthetic.w07.f01`, the effect class `w07_fixture_effect`, keys `w07_fixture_key_1` to `_3`, targets `w07_fixture/target_*`, bases `w07_fixture_base_*`, payload hashes `w07_fixture_payload_*` and session ids `w07_fixture_session_*` are made up and labelled SYNTHETIC W-C02-07. Tokens are issued inside the rolled-back transaction and never leave PL/pgSQL variables.

**Serves.** W-C02-09 point 8 ("F01"); C02 Acceptance line "✔ The Appendix C tests whose stage is C02 pass …; when each rule is deliberately broken, the related test fails"; Appendix C F01; Appendix B 3.12 ("Same key and same full intent: the existing record is returned. Same key and different intent: conflict"; "An idempotency key's record is never deleted", PC-42 place 17); EV-C02-002 DM-28 (keys never deleted) and DM-37 (effect classes).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_f01_whole_intent.sql`, run by the migration job's `devos-test` step as `postgres` (README 5.1 (a)); on the throwaway database by the break harness (`tests/C02/W-C02-07/harness/run_breaks.py`, Group B) with the patches `breaks/B-F01-1` to `-3`.
**Time added to W-C02-13's run.** None: it waits on no schedule. (d)'s "delayed retry" is planted by back-dating the record's timestamps by 400 days (owner, inside the transaction); what that leaves untested is under "Not covered".
**Interface assumed** (Group A common interface, v1; README section 8; revised before the first result if the build differs):
- Calls run as role `anon` (the role a request with the publishable key reaches) with EXECUTE on the named `devos_api` functions and the header `x-devos-env-token` in `request.headers` (EV-C02-003 §1.6).
- Every `devos_api` function returns `jsonb` with `status` one of `ok`, `refused`, `could_not_check`, and `reason_code` when not `ok`. A refusal is returned, not raised (EV-C02-002 DM-19: the record must survive the refused transaction); a raised error makes the case "could not check". The token reason codes are B 3.27's; no other reason code's spelling is assumed. A refusal whose reason code is a token code is a refusal for another reason and makes the case "could not check" (README 5.3).
- `devos_private.issue_env_token(role_class text) returns text` and `devos_private.revoke_env_token(token text)`, owner-only (the same interface Group D's `T-W07-IDC` states; phase C checks they agree).
- Fixtures: an owner-planted synthetic Decision row in `devos_private.decision` (`class` `batu`, `status` `answered`; a `devos_private.decision_revision` row if that table exists), in `devos-test` and the throwaway database only, inside the rolled-back transaction (never in `devos`, EV-C02-002 DM-23); then `devos_api.open_mission(jsonb)` with the `devos_kurulum` token (`{purpose, scope, owner_authority {id, revision}, acceptance, constraints}` → `{status, id, revision}`), `devos_api.admit_work(jsonb)` (`{mission_ref {id, revision}, scope, purpose, impact_class, consumer, return_to, stop_rule, input_refs, target_refs, mandatory_needs}` → `{status, id, revision}`), `devos_api.claim(work_id uuid, declared_session_id text)` → `{status, claim_token, assignment_id, generation}`, `devos_api.release(claim_token text)`.
- `devos_api.prepare_operation(claim_token text, operation jsonb)` with B 3.12's fields `{idempotency_namespace, idempotency_key, effect_class, target, expected_base, payload_hash, work_ref {id, revision}, read_set [{ref, revision}]}` → `{status, id, operation_status}`; generation and epoch are taken by the server from the claim.
- `devos_private.effect_class (effect_class text, irreversible boolean, mandatory_read_set text[])`: the synthetic class `w07_fixture_effect` is planted by the owner inside the transaction. DM-37 places synthetic classes on the throwaway database "since the table changes only by migration"; this test reads that as excluding committed changes, and plants a row that never commits in `devos-test` too. If the executor holds DM-37 to the throwaway database only, the cases run there and `devos-test` gives "could not check".
- `devos_private.operation` with B 3.12's columns, `status`, and at least one timestamp column.

## Cases
| Case | Input | Expected |
|---|---|---|
| F01-pos1 | `prepare_operation`, key 1, intent P | `ok` |
| F01-pos2 | the same key, the same full intent P, the same claim | `ok`, the same record's `id`, and no change in any table (no new operation, no new event) |
| F01-a | key 1, P with another `target` | `refused` (conflict), nothing changed |
| F01-b | key 1, P with another `expected_base` | `refused`, nothing changed |
| F01-e | key 1, P with another `payload_hash` (content) | `refused`, nothing changed |
| F01-f | key 1, P under another work item and its claim | `refused`, nothing changed |
| F01-c | key 1, P, after `release` and a new claim (generation 2) | `refused`, nothing changed |
| F01-d1 | key 2 prepared, its timestamps back-dated 400 days, then the same intent retried | `ok`, the same `id`, nothing changed, and the returned `operation_status` equals the stored status (the real state is read) |
| F01-d2 | key 3 prepared and back-dated, then retried with another target | `refused`, nothing changed (not accepted as a new operation) |
| F01-d3 | catalogue look: function bodies in `devos_api` and `devos_private` that delete from the operation table; DELETE or TRUNCATE on it for `anon`, `authenticated` and each DevOS role class's database role that exists | none of either; the look's own control finds a planted temporary function whose body deletes from the table |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-F01`: an idempotency key is bound to the operation's whole intent (type, target, expected base, content, work item, claim generation, authority epoch), and its record is never deleted, so the same key answers only the same intent. **[Designer's addition: Appendix C's F entries give no claim line (R2 section 5 (c)); drawn from F01's class rule and B 3.12.]** |
| **Failure class rule** | Appendix C F01: "An idempotency key must be bound to the operation's whole intent: type, target, expected base, content, work item, claim generation, authority epoch". A member is any call where the same key with any one intent field changed is answered from the existing record, or where a retry is treated as a new operation because the key's record is gone. |
| **Examples** | The original finding: the key bound to content only, so the same content for another target returned the old receipt: F01-a. Other manifestations: another base (F01-b), another generation (F01-c), another work item (F01-f), another content (F01-e), and a late retry after the record could have been purged (F01-d1, F01-d2), with DM-28's "no path deletes Operation rows" looked for (F01-d3). |
| **Negative control** | F01-a, -b, -c, -e, -f and -d2 must each be `refused`, and the digest of every `devos_private` table except RejectedAttempt's and the token tables (hash and token columns left out) must be unchanged by the call: no operation, no event, no half state. F01-d3 must find no delete path. |
| **Positive control** | F01-pos2: the same key with the same full intent, by the same claim, is accepted and returns the existing record (same `id`), and changes nothing. It differs from F01-a only in the target. F01-d1 is the late form of the same control. |
| **Break attempt** | All three patches rename the build's `devos_api.prepare_operation(text, jsonb)` and put a wrapper in its place, applied by the harness on the throwaway database (README 5.2). (1) `breaks/B-F01-1_target_not_compared.sql`: the target is left out of the comparison (the wrapper copies the stored target into the call). F01-a and F01-d2 must turn red. (2) `breaks/B-F01-2_generation_not_compared.sql`: the generation is left out (the stored record takes the current claim's generation). F01-c must turn red. (3) `breaks/B-F01-3_key_retention_purge.sql`: a retention purge of records older than 30 days is added, the form DM-28 rejected. F01-d1, F01-d2 and F01-d3 must turn red. Designer's self-check, never a result: on PostgreSQL 16.15 against a scratch stub of the interface above, outside the repository, the unpatched file gave PASS (10/10) and each patch turned exactly its named cases red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's `devos-test` step (EV-C02-003 §6.3; EV-C02-004 Y-05), with synthetic tokens. The break harness's throwaway PostgreSQL 17 database (EV-C02-002 §5). Never `devos`. No Claude environment's real token. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer`; W-C02-07's Record names its agent ID. Run by: the migration job; the build producer at W-C02-09's head (W-C02-09 point 8); the prober of W-C02-13 with the breaks. Assessed by a fresh-context checker that wrote none of the tests. Shared with the producer: model lineage, Appendix B and C, EV-C02-002 to -004. |
| **Evidence layer** | Structural: the database's refusal, acceptance and state. It does not show what an external system did with the effect (C03, C08), the header path through the Data API (transport `sql-set-role`), or that `devos` behaves the same (W-C02-08 "Not covered" (d)). |
| **Evidence envelope** | README section 4. Fixed before the run: each case's expected outcome above; PASS only when all 10 cases are `ok`; each break's red cases as named. `transport`: `sql-set-role` in `devos-test`, `throwaway` on the harness. Observation: the job run's URL, run ID and step name, or the harness output with the patch name. Raw evidence: the unedited output under `evidence/C02/raw/`, ID `W07-F01-<run_at>`. |

## Clause table
| Clause of Appendix C F01 (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "Class rule: An idempotency key must be bound to the operation's whole intent: type, target, expected base, content, work item, claim generation, authority epoch" | F01-a, F01-b, F01-c, F01-e, F01-f | The epoch field: no case of its own. A new epoch also ends the claim, so a same-key call under it differs in generation too (F01-c's class). "the grant revision once Grant is activated": Grant is deferred (B 3.6). |
| "(a) same content, different target" | F01-a | — |
| "(b) same content and target, different expected base" | F01-b | — |
| "(c) everything the same, different claim generation" | F01-c | — |
| "(d) a delayed retry after the retention period of the key record has expired" | F01-d1, F01-d2, F01-d3 | Tested in the design's form (EV-C02-002 DM-28; B 3.12 as PC-42 place 17 words it): keys are never deleted, so (d) is a retry after a long delay and a check that no path deletes Operation rows. |
| "Negative: (a)–(c) are rejected as conflicts" | F01-a, F01-b, F01-c | — |
| "(d) is not accepted as if it were a new operation; the real state is read" | F01-d1, F01-d2 | — |
| "Positive: The same key with the same full intent returns the existing record and produces no new effect" | F01-pos2, F01-d1 | — |
| "Break: When one of the intent fields is removed from the comparison, the corresponding example must start to pass and the test must fail" | B-F01-1 (F01-a), B-F01-2 (F01-c), B-F01-3 (F01-d1, F01-d2, F01-d3) | — |

## Format gate
Not a format-gate test.

## Could not check
The file ends in COULD NOT CHECK when an object of the interface is absent (before the build), when a fixture cannot be written, when a call raises instead of returning, or when a refusal is for a token reason. Each such case is `could_not_check`, never `ok`.

## Not covered
- The real clock: back-dating plants the long delay. It does not show behaviour after real time passes, which DM-28 makes irrelevant (no retention).
- The epoch as a separate intent field (see the clause table).
- `record_attempt` and observations (T-W07-F07, T-W07-F08).
- Real external effects (C03, C08).
- `devos`.
