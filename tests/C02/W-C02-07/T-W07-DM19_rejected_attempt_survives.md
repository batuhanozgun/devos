# T-W07-DM19 · A refused call leaves its RejectedAttempt record and no half state

Synthetic test data (plan Section 8 item 13): two work items, a hard dependency between them, a review and a passing verdict, all made up inside a rolled-back transaction (use `w07_fixture_use_one`, scope `synthetic.w07fixture`); synthetic `devos_calisma` and `devos_denetim` tokens, kept only in PL/pgSQL variables.

**Serves.** W-C02-09 point 3 ("That record survives the refused transaction, while the refused change and its event do not") and point 5 ("✘ An error raised mid-transaction leaves no half state and no orphan event"). EV-C02-002 DM-19 (a): "Each `devos_api` function runs its work in an inner block; on a refusal it rolls that block back, writes the record and returns the refusal"; a verified caller "gets one row per call, with its role class"; a call without a verified token is counted. Section 6 asks W-C02-07 to cover it. Appendix B 3.13, RejectedAttempt.
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. In `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_dm19_rejected_attempt_survives.sql` as `postgres`, and passes only on the notice `W07_DM19_REJECTED_ATTEMPT_SURVIVES PASS`. Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-DM19-1_no_record.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. Group B's call convention, as T-W07-F04 states it. For this test:
- `devos_private.rejected_attempt` (`id`, `function_name`, `role_class`, `reason_code`, `counted_hour`, `count`), with the token refusals' reason codes of EV-C02-003 §15 (`missing`, ...). Group D's T-W07-6TK assumes the same codes; phase C checks they agree;
- `devos_private.event` (`id`, `role_class`) and `devos_private.acceptance`;
- `devos_api.accept(verdict_ref uuid, accepted_use text)`, `devos_denetim` only (EV-C02-003 §4.1);
- `devos_api.relate(...)` as T-W07-REL states it;
- `devos_private.caller_role_class(text)`.

## Cases
- **DM19-a** (the original): `accept` with a verified `devos_calisma` token, a class the function does not permit. The call returns its refusal, not raising it. No Acceptance row, no event, and a new per-call record with role class `devos_calisma` and a reason code.
- **DM19-c**: a permitted `relate` refused by a rule after its work began: a hard dependency that closes a cycle. No new relation, no event, a per-call record, returned.
- **DM19-b**: a permitted `relate` whose event write fails mid-call (a failure planted by a temporary trigger). No new relation and no event; the call is refused, whether returned or raised.
- **DM19-d**: `accept` with no token. Refused and not raised; the counted total for (`accept`, `missing`, role class `none`) grows by exactly one; no state, no event.
- **DM19-pos**: DM19-a's call with the `devos_denetim` token. Accepted: one Acceptance row, an event with role class `devos_denetim`, and no record.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-DM19. A refused call leaves its RejectedAttempt record, and nothing of the refused change: no half state, no orphan event. The record survives because the function returns its refusal rather than raising it. |
| **Failure class rule** | **[Designer's addition: a design rule with no Appendix C entry]** A refusal that loses its record (the record written in the failing transaction and rolled back with it, or never written), or that keeps part of the refused change or its event. |
| **Examples** | **[Designer's addition]** The original, DM-19's own case: a verified caller of the wrong class (DM19-a). Other manifestations: a rule refusal after the work began (DM19-c); an unexpected mid-call failure (DM19-b); an unverified call's count (DM19-d). |
| **Negative control** | In DM19-a, -b, -c and -d, the state table's row count and the event table are unchanged. DM19-a, -c and -d also require the record, and that the call did not raise. |
| **Positive control** | DM19-pos: the same `accept` as DM19-a with the permitted token is accepted, with its state and event and no record. It differs from DM19-a only in the token. |
| **Break attempt** | **B-DM19-1** (`breaks/B-DM19-1_no_record.sql`) removes the record: a trigger drops every RejectedAttempt write. Must turn red: **DM19-a, DM19-c, DM19-d**. DM19-b does not require the record, so it stays green, as does DM19-pos. |
| **Stage and environment** | C02. `devos-test`, the migration job's test step, with synthetic tokens. The break runs on the throwaway database. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job, by W-C02-09's producer at its head, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural. In SQL the whole file is one transaction, so "survives" is shown as "returned, not raised, with the record present while the change is absent". The Data API's own transaction per call is shown by T-W07-DM19B part B. |
| **Evidence envelope** | README 4's fields; `transport` `sql-set-role` or `throwaway`. Values fixed before the run: the cases' outcomes; the count step (+1); the break's red cases. |

## Could not check
The test gives COULD NOT CHECK when an object of the interface is absent or a fixture cannot be made (DM19-pre), and a case gives `could_not_check` when its call cannot be formed. Before the build exists the test gives COULD NOT CHECK.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-DM19-1 turns red exactly DM19-a, DM19-c, DM19-d, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- Whether the record's reason text is useful (semantic).
- The other token reason codes: Group D's T-W07-6TK.
- Reading RejectedAttempt as `devos_denetim` only: T-W07-5B.
