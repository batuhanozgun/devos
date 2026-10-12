# T-W07-N25 · A verdict whose basis, criterion or use changed cannot be used for acceptance

Synthetic test data (plan Section 8 item 13): decisions, a review and a verdict made up inside a rolled-back transaction (uses `w07_fixture_use_one` and `w07_fixture_use_two`, random target uuid); one synthetic `devos_denetim` token.

**Serves.** W-C02-09 point 8 ("N25 (its C02 part)"). Appendix C N25 (Ek_C:142): "When `basis_refs`, the criterion or the use changes, the old verdict cannot be used for acceptance" / "A verdict whose basis stays the same is valid" / stage "C02, C08". Appendix B 3.11: "When `basis_refs`, `criterion` or `use` changes, the verdict goes stale and a new acceptance is needed; the old verdict is not automatically carried over to another use of the same product". EV-C02-002 DM-02 (revisions never change, so a verdict's basis cannot change under it).
**Command.** In `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n25_verdict_staleness.sql` as `postgres`, and passes only on the notice `W07_N25_VERDICT_STALENESS PASS`. Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-N25-1_stale_verdict_accepted.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. Group B's call convention, as T-W07-F04 states it. For this test:
- `devos_private.review` (`kind`, `target_ref`, `target_revision`, `criterion_ref`, `criterion_version`, `use`, `basis_refs` as `[{ref, revision}]`);
- `devos_private.verdict` (`review_ref`, `result`) and `devos_private.acceptance`;
- `devos_private.decision_revision` (`decision_id`, `revision`): a basis or criterion "changes" when a newer revision of it exists (DM-02);
- `devos_api.accept(verdict_ref uuid, accepted_use text)`, permitted to `devos_denetim`.

## Cases
Each case plants its own two basis decisions, a criterion decision and a passing verdict on use one, makes its change, then calls `accept`.
- **N25-a** (the original): the first basis decision gets a newer revision. Refused; no Acceptance row.
- **N25-b**: the criterion gets a newer revision. Refused.
- **N25-c**: accepted for use two, while the review was for use one. Refused.
- **N25-d**: only the second basis decision gets a newer revision. Refused: every basis is checked, not only the first.
- **N25-pos**: nothing changed. Accepted; one Acceptance row more.
- **N25-pre**: `could_not_check` when an object is absent.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-N25. The database refuses an acceptance that rests on a verdict whose basis revisions, criterion or use no longer hold; it accepts one whose basis is unchanged. |
| **Failure class rule** | **[Designer's addition: C2 rows have no class rule]** A verdict carried over after what it rested on moved: a newer revision of any basis, a newer criterion, another use. |
| **Examples** | **[Designer's addition]** The original, Appendix C N25's negative: N25-a (basis). Other manifestations: N25-b (criterion), N25-c (use), N25-d (a basis other than the first). |
| **Negative control** | N25-a to N25-d: each call is refused and the Acceptance row count is unchanged. |
| **Positive control** | "A verdict whose basis stays the same is valid": N25-pos, which differs from N25-a only in the absent new revision. |
| **Break attempt** | **[Designer's addition: C2 rows have no break]** **B-N25-1** (`breaks/B-N25-1_stale_verdict_accepted.sql`) removes the staleness rule: `accept` is wrapped so that a refused acceptance is written anyway, as a plain row. Must turn red: **N25-a, N25-b, N25-c, N25-d**. |
| **Stage and environment** | C02 (its C02 part). `devos-test`, the migration job's test step, with a synthetic `devos_denetim` token. The break runs on the throwaway database. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job, by W-C02-09's producer, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural. It does not show that a basis list is complete (semantic: the audit environment's), nor C08's tie of a verdict to the head commit. |
| **Evidence envelope** | README 4's fields. Values fixed before the run: the cases' outcomes and the break's red cases. |

## Clause table (point 2)
| Clause of Appendix C N25 (verbatim) | Case ID(s) / moved to |
|---|---|
| Claim: "A verdict whose basis changes goes stale" | N25-a, N25-d |
| Negative: "When `basis_refs`, the criterion or the use changes, the old verdict cannot be used for acceptance" | `basis_refs`: N25-a, N25-d; criterion: N25-b; use: N25-c |
| Positive: "A verdict whose basis stays the same is valid" | N25-pos |
| Stage "C02, C08": the C08 part | Moved to C08 by Appendix C itself: a verdict tied to the head commit at merge (R2 section 2) |

## Could not check
The test gives COULD NOT CHECK when `review` (with its six named columns), `verdict`, `acceptance`, `decision_revision`, `accept` or `issue_env_token` is absent. A case gives `could_not_check` when its fixtures cannot be planted, or when the call cannot be formed. Before the build exists the test gives COULD NOT CHECK.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-N25-1 turns red exactly N25-a, N25-b, N25-c, N25-d, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- A criterion or basis that is not a Decision (an Artifact, a policy): the build may type `basis_refs` (DM-15 leaves it to C05); a case per family is added if the build accepts other families.
- `mark_stale` and the stale state of a Review: not named by N25's C02 part.
