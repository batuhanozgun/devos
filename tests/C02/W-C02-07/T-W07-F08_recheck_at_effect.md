# T-W07-F08 · At the moment of effect, the work item, its dependencies, the claim and the read set are checked again

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.f08`, its eleven work items, relations, artifacts `w07_fixture/f08/*`, keys `w07_fixture_key_f08_*`, the revocation reason and session ids are made up and labelled SYNTHETIC W-C02-07. Tokens, including the one revoked to change the epoch, are issued inside the rolled-back transaction.

**Serves.** W-C02-09 points 3, 4 and 8 (point 3: "a claim taken in the earlier epoch produces no effect"; point 4: "a claim past `lease_expires_at` produces no effect", and the released, expired and revoked claims); C02 Acceptance's first line; Appendix C F08; B 3.12 and 3.5; EV-C02-002 DM-06 (expiry computed at every effect), DM-37 (the read set's mandatory elements are the server's), DM-29 (`revoke_claim`); EV-C02-004 X-07 (the epoch change is made by revoking a synthetic token).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_f08_recheck_at_effect.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-F08-1` and `-2`.
**Time added to W-C02-13's run.** None. Expiry (c2) is planted by setting `lease_expires_at` to one second before `now()` (owner, inside the transaction; README section 9). That leaves untested whether the build compares the lease with a clock that moves during a long transaction. The lease's length, 30 minutes (EV-C02-002 DM-07 and section 4, 2026-10-12), is read in T-W07-DM07.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it. Also:
- `devos_api.relate(relation jsonb)` with `{type 'depends_on', from_ref {id, revision}, to_ref {id, revision}, hard true, group_mode 'ALL', scope, method 'recorded', epistemic_status}`, called with the working token.
- `devos_api.revoke_claim(assignment uuid, reason text)` with the audit token.
- `devos_api.record_attempt(claim_token text, operation uuid)`: the moment of effect for a prepared operation.
- `devos_api.revise_work(jsonb)`.
- `devos_api.register_artifact(claim_token, jsonb)` as the effect on a work item.
- Owner plants: `devos_private.work.execution` and `.acceptance` (B 3.3 axes on the identity row, DM-02) set to `finished` and `accepted` to resolve a dependency; `devos_private.assignment.lease_expires_at`.
- The work item's `input_refs` are mandatory read-set elements of the planted class (`mandatory_read_set` includes `inputs`).


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
| Case | Input | Expected |
|---|---|---|
| F08-pos0 | effect under A's claim before any dependency | `ok` (the earlier result, later checked as kept) |
| F08-a | a hard dependency A → X (X not finished) added after the claim; then the effect | `refused`, nothing changed, F08-pos0's artifact still there |
| F08-pos1 | meanwhile, an independent work item's effect under its own claim | `ok` |
| F08-pos2 | X planted finished and accepted (dependency resolved); the effect again | `ok` |
| F08-b | an operation prepared with source S at revision 1 in its read set; S revised to 2; `record_attempt` | `refused`, nothing changed |
| F08-pos3 | the same with S's current revision | prepare and `record_attempt` `ok` |
| F08-c1 | the claim revoked by `revoke_claim` (audit token); the effect | `refused`, nothing changed |
| F08-pos4 | a new claim on the same work item at once; its effect | `ok` |
| F08-c2 | the claim's lease planted as passed; the effect | `refused`, nothing changed |
| F08-pos5 | a work item with two inputs: a read set naming the work item and both inputs | `ok` |
| F08-d | the same with one input left out | `refused`, nothing changed |
| F08-c3 | a synthetic token revoked (the global epoch increments); an effect under a claim of the earlier epoch | `refused`, nothing changed |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-F08`: an effect is accepted only if, at that moment, its work item has no open hard dependency, its claim is active, of the current generation and the current epoch with its lease not run out, and its read set holds every mandatory element at its current revision. **[Designer's addition: no claim line in the F entries (R2 section 5 (c)); drawn from the class rule.]** |
| **Failure class rule** | Appendix C F08: "At the moment of effect, the current work item, dependencies, claim (active, current generation, valid epoch) and read set are checked again; the mandatory elements of the read set are determined on the server according to the operation type." A member is any effect accepted on a state checked only earlier (at claim or prepare) or on a read set the agent shortened. |
| **Examples** | The original finding, a new hard dependency not stopping the old session's update: F08-a. Others: a changed source (F08-b); a revoked, an expired and an old-epoch claim (F08-c1, -c2, -c3); an incomplete read set (F08-d). |
| **Negative control** | Each of F08-a, -b, -c1, -c2, -c3 and -d is `refused`, with the state digest unchanged by the call. In F08-a, the candidate result made before the dependency is kept (its artifact still exists). |
| **Positive control** | F08-pos2: after the dependency is resolved the effect is made. F08-pos1: independent work continues under another claim. F08-pos3, -pos4 and -pos5 are the paired controls of (b), (c1) and (d): each differs from its negative in the one thing tested. F08-pos0 shows the claim worked before the change. |
| **Break attempt** | (1) `breaks/B-F08-1_dependency_recheck_removed.sql`: the dependency re-check at the effect is removed. A wrapper hides the work item's hard relations from `register_artifact` for the call. F08-a must turn red. (2) `breaks/B-F08-2_claim_recheck_removed.sql`: the claim re-check at the effect is removed. A wrapper makes the work item's latest claim look active, unexpired and of the current epoch for the call. F08-c1, -c2 and -c3 must turn red. Both run on the throwaway database. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (12/12); each patch turned exactly its named cases red. |
| **Stage and environment** | C02. `devos-test` in the migration job's step, where the owner-level path issues and revokes the synthetic token for (c3) (EV-C02-003 §6.3; EV-C02-004 Y-05, X-07). The throwaway PostgreSQL 17 database for the breaks. Never `devos`. |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; agent ID in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the breaks. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. It does not show a real external effect (C03, C08), the real clock's passing (planted), or the Data API path. |
| **Evidence envelope** | README section 4. Fixed before the run: the outcomes above; PASS at 12/12; the breaks' red cases. `transport`: `sql-set-role` or `throwaway`. Raw evidence `W07-F08-<run_at>`. |

## Clause table
| Clause of Appendix C F08 (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "Class rule: At the moment of effect, the current work item, dependencies, claim (active, current generation, valid epoch) and read set are checked again (and the grant, once Grant is activated; PC-08); the mandatory elements of the read set are determined on the server according to the operation type" | F08-a, -b, -c1, -c2, -c3, -d | The grant: Grant is deferred (B 3.6). The current generation: T-W07-DM07 (DM07-oldgen) and T-W07-F01 (F01-c). |
| "(a) a new hard dependency" | F08-a | — |
| "(b) a change to a source in the read set" | F08-b | The source is a work-item revision: Source is C04's (EV-C02-002 section 3, 2.6). |
| "(c) revocation or expiry of the claim, or an authority epoch change after the claim" | F08-c1, F08-c2, F08-c3 | — |
| "(d) the agent deliberately writing an incomplete read set" | F08-d | Tested in the design's form: the server's mandatory elements per effect class (EV-C02-002 DM-37), with a synthetic class. |
| "Negative: The effect is rejected; the candidate result is kept" | F08-a (with the kept artifact), -b, -c1, -c2, -c3, -d | — |
| "Positive: After the dependency is resolved, the effect can be made; an independent exploration work item can continue under another claim" | F08-pos2, F08-pos1 | — |
| "Break: When the re-check at the moment of effect is removed, (a) must pass" | B-F08-1 (F08-a); B-F08-2 (F08-c1, -c2, -c3) | — |

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK before the build, when a fixture, a revocation or a planted state cannot be made (that case is `could_not_check`), when a call raises, or when a refusal carries a token reason code.

## Not covered
- The real clock.
- Grant (deferred).
- Real effect channels and their classes (C03, C08).
- The race of a late effect against a revocation: T-W07-CONC.
