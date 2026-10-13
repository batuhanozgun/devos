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
