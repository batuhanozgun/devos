# T-W07-DM07 · heartbeat extends only an active, current, unexpired claim of the caller's class, by 30 minutes

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.dm07`, six work items, their claims, the revocation reason and session ids are made up and labelled SYNTHETIC W-C02-07. Tokens are issued at run time.

**Serves.** W-C02-09 point 4 (the lease's parameter; a claim past `lease_expires_at`); EV-C02-002 DM-07 and section 6 ("`heartbeat` refuses a lapsed or revoked claim"); B 3.5 as PC-42 place 13 words it; EV-C02-003 §4.3 (S8 line 2 for `heartbeat`).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_dm07_heartbeat.sql`, run by the migration job's `devos-test` step as `postgres`; on the throwaway database by the harness with `breaks/B-DM07-1`.
**Time added to W-C02-13's run.** None. A lapse is planted (`lease_expires_at` one second before `now()`), and a near expiry is planted (now() + 5 minutes) before the extension is checked (README section 9). The lease's length is read from the stored value: 30 minutes (EV-C02-002 DM-07 and section 4's lease row, 2026-10-12; B 3.5). Its reasons' sources are EV-C00-012 P16 (2026-10-05), EV-C01-007 Point 2 (2026-10-11) and PC-38 P1 (2026-10-11), checked against Batu's later decisions in EV-C02-002 section 4 (no conflict). Untested by planting: the real clock passing the stored time.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it. Also `devos_api.heartbeat(claim_token text)`, `devos_api.release(claim_token text)`, and `devos_api.revoke_claim(assignment uuid, reason text)` (audit token, DM-29). Owner reads and plants of `devos_private.assignment.lease_expires_at`. Break patch: `claim_token_hash` as hex SHA-256 of the whole token (EV-C02-003 §1.7; the encoding is assumed).


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
| Case | Input | Expected |
|---|---|---|
| DM07-len | a fresh claim's stored lease | within one second of `now()` + 30 minutes |
| DM07-pos | lease planted at now() + 5 min; `heartbeat`, the claim's class | `ok`, and the lease is now() + 30 minutes |
| DM07-lapsed | lease planted as passed; `heartbeat` | `refused`; the lease is not revived; nothing changed |
| DM07-revoked | the claim revoked by `revoke_claim`; `heartbeat` | `refused`, nothing changed |
| DM07-released | the claim released by its claimant; `heartbeat` | `refused`, nothing changed |
| DM07-oldgen | the claim released and the work item claimed again; `heartbeat` with the first claim's token | `refused`, nothing changed |
| DM07-class | `heartbeat` with an active claim's token under the exam token | `refused`, nothing changed |
| DM07-epoch | a synthetic token revoked (the epoch increments); `heartbeat` with a claim of the earlier epoch | `refused`, nothing changed |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-DM07`: `heartbeat` extends a claim by 30 minutes only if the claim is active, of the current generation, made in the current global authority epoch, with its lease not run out, and the caller's role class is the claim's (EV-C02-002 DM-07). |
| **Failure class rule** | Any extension that keeps alive a claim that has already ended, by lapse, revocation, release, a newer generation or an epoch change, or that is made from another role class's environment. Also any extension that is not of the stated length. **[Designer's addition: a rule added by a design record, with no Appendix C entry.]** |
| **Examples** | The rule's own case, a lapsed claim: DM07-lapsed. Others: DM07-revoked, -released, -oldgen, -epoch and -class. The length: DM07-len. **[Designer's addition.]** |
| **Negative control** | Each of DM07-lapsed to -epoch is `refused`, with nothing changed. A lapsed claim's lease stays in the past. |
| **Positive control** | DM07-pos: an active claim near its expiry is extended to 30 minutes. It differs from DM07-lapsed only in the planted lease, and from DM07-class only in the environment token. |
| **Break attempt** | `breaks/B-DM07-1_heartbeat_state_check_removed.sql` removes heartbeat's state check (active, current generation, lease not run out). A wrapper makes the presented claim look active, current and unexpired for the call, then restores it. The epoch and class checks stay. DM07-lapsed, -revoked, -released and -oldgen must turn red. DM07-epoch and -class stay green. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (8/8); patched, exactly those four red. |
| **Stage and environment** | C02. `devos-test`, in the migration job's step, with synthetic tokens (the epoch change by revoking one, EV-C02-004 X-07). The throwaway PostgreSQL 17 database for the break. Never `devos`. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; agent ID in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. It does not show who sends the liveness signal, or when (C06; B:154). Nor does it show whether a live session's claim can expire mid-work before C06 (W-C02-09 point 4 asks the record to state that). |
| **Evidence envelope** | README section 4. Fixed before the run: 30 minutes ± 1 second; the outcomes above; PASS at 8/8; the break's four red cases. Raw evidence `W07-DM07-<run_at>`. |

## Clause table
Not an Appendix C test (EV-C02-002 section 6 adds the rule; GROUPS.md section 4). Its role-class part is also N17's (PC-43 place 11).

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK before the build, when a fixture or a planted state cannot be made (that case is `could_not_check`), when a call raises, or when a refusal carries a token reason code. DM07-len is `could_not_check` when the stored lease cannot be read.

## Not covered
- The real clock.
- The sender of the liveness signal (C06).
- The length's suitability (read again in C06, N-214 item 2).

## Revision before any result (EV-C02-013, 2026-10-17)
Under ledger rule 3, before any result of W-C02-09's build (no SQL of it exists), by the test designer (a fresh-context subagent of type `test-designer`; agent `ae53376fe7add21d4`, filled in by the executor at filing), from W-C02-09's interface record `evidence/C02/EV-C02-013_w09_interface.md` (Revision 1, at `349e151`). One fresh checker judges it with that record's Revision 1 before both merge. **No case ID, expected outcome or break red list is changed.**
- **Files changed:** this specification; `job/w07_dm07_heartbeat.sql`.
- **D-1 (EV-C02-013 section 1 item 3 and section 5 D-1): the flat reference form.** Every reference sent as an object `{"id", "revision"}` under a field name (`mission_ref`, `work_ref`, `from_ref`, `to_ref`, `target_ref`, `owner_authority`) is now sent flat: the field's Appendix B name holds the record's uuid and `<name without _ref>_revision` its revision (`owner_authority_revision` for `owner_authority`). Read-set entries (`{ref, revision}`) and internal helper objects are unchanged.
