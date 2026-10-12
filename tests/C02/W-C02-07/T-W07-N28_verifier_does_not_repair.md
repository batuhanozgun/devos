# T-W07-N28 · A Review and a new revision of its target are never written in one transaction; the repair is a separate work item

Synthetic test data (plan Section 8 item 13): artifacts, revisions, reviews, a verdict and a work item made up for the test (text `w07_fixture SYNTHETIC W-C02-07`, use `w07_fixture_use_one`). Part A writes inside a rolled-back transaction. Part B commits, on the throwaway database only.

**Serves.** W-C02-10 point 5: "✘ N28: a new revision of a review's target in the same transaction as the Review record is refused; ✔ the repair opened as a separate work item is accepted (B 3.11)". Appendix C N28 (Ek_C:145). Appendix B 3.11: "The verifier does not repair in the same action: a new revision of the target product cannot be written in the same transaction as a `Review` record". EV-C02-002 DM-41: "A trigger refuses a `Review` (or `Verdict`) and a new revision of its target in the same transaction, whichever comes first, by the transaction id".
**Command.** Part A, in `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n28_verifier_does_not_repair.sql` as `postgres`, and passes only on the notice `W07_N28_VERIFIER_DOES_NOT_REPAIR PASS`. Part B and the break, on the throwaway database: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-N28-1_same_transaction_repair.sql --pg-bin <PostgreSQL 17 bin>`. The patch's test list runs both parts; part B is `harness/scenarios/n28_separate_transactions.sql`, which commits and refuses to run unless `w07.throwaway = 'yes'`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. `devos_private.artifact_revision` (`artifact_id`, `revision`), `devos_private.review` (`kind`, `target_ref`, `target_revision`, `use`, `basis_refs`), `devos_private.verdict` (`review_ref`, `result`) and `devos_private.work`. The writes are planted as the owner, since DM-41's trigger acts on the tables whatever role writes (README 5.1 (a)). A write that the rule refuses raises.


**Phase C, the executor's decision (DM-41 and sample reviews).** The tests assume the build exempts from DM-41's trigger a `sample` Review the database creates in the same transaction as a format-gated record; this is an interface for W-C02-10 (README section 8.1). This test writes its Reviews through the owner and `open_review`, never as a database-made sample.

## Cases
- **N28-a** (the original, part A): a target's revision 1, then a Review of it, then its revision 2, in one transaction. The Review and revision 2 are not both written, and a write was refused. If the Review is already refused because revision 1 is in the same transaction, that is DM-41's rule too ("a new revision of its target in the same transaction"), and the case holds.
- **N28-b** (part A): the order reversed: revision 2 first, then the Review. Not both written.
- **N28-pos** (part A): a new revision of a target that no review in the transaction names is written. The trigger does not refuse every revision.
- **N28-S-sep** (part B): a Review written in a transaction after the one that wrote its target's revision 1 is accepted.
- **N28-S-repair** (part B): in the Review's transaction, a separate work item for the repair is accepted.
- **N28-S-later** (part B): revision 2 of the target, written in a later transaction, is accepted.
- **N28-S-verdict** (part B): a Verdict on that Review and revision 3 of its target, in one transaction, are not both written.
- **N28-pre**, **N28-S-pre**: `could_not_check` when an object is absent or the target cannot be planted.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-N28. A Review (or Verdict) and a new revision of its target never commit in one transaction, whichever comes first; a review in its own transaction, with the repair opened as a separate work item, is accepted. |
| **Failure class rule** | **[Designer's addition: C2 rows have no class rule]** The verifier repairs what it judges in the same action: any transaction that holds both a review record (Review or Verdict) and a new revision of its target, in either order. |
| **Examples** | **[Designer's addition]** The original, Appendix C N28's negative: N28-a (review, then repair). Other manifestations: N28-b (repair, then review) and N28-S-verdict (a Verdict instead of a Review). |
| **Negative control** | N28-a, N28-b, N28-S-verdict: after the attempt, the review record and the new revision are not both present, and one of the writes was refused. |
| **Positive control** | "The repair is opened as a separate work item": N28-S-repair, with N28-S-sep and N28-S-later. Each differs from a negative only in which transaction holds the writes. N28-pos shows in part A that a revision alone passes. |
| **Break attempt** | **[Designer's addition: C2 rows have no break]** **B-N28-1** (`breaks/B-N28-1_same_transaction_repair.sql`) removes DM-41's rule. It disables the triggers on `artifact_revision` whose function reads reviews or verdicts, and those on `review` and `verdict` whose function reads revisions; DM-02's append-only trigger stays. Must turn red: **N28-a, N28-b, N28-S-verdict**. |
| **Stage and environment** | C02. Part A: `devos-test`, the migration job's test step. Part B and the break: the throwaway database (README 5.2), because part B needs committed transactions, which a test in `devos-test` must never leave (README 5.1 (a)). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job (part A), by W-C02-10's producer at its head, and by W-C02-13's prober (parts A and B, with the break). Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural. Part B's evidence is on the throwaway database built from the same migrations: it shows the migrations' rule, not `devos-test`'s deployment. |
| **Evidence envelope** | README 4's fields. `transport` is `sql-set-role` for part A in the job, and `throwaway` for part B and the break. Values fixed before the run: each case's outcome and the break's red cases. |

## Clause table (point 2)
| Clause of Appendix C N28 (verbatim) | Case ID(s) |
|---|---|
| Claim: "The verifier does not repair" | N28-a, N28-b, N28-S-verdict |
| Negative: "A new revision of the target in the same transaction as the review record is rejected" | N28-a, N28-b (and N28-S-verdict, DM-41's Verdict) |
| Positive: "The repair is opened as a separate work item" | N28-S-repair, N28-S-sep, N28-S-later. Tested in the design's form: the separate transactions run on the throwaway database (EV-C02-002 section 5; DM-41 (b): "which the throwaway test database ... lets the test do") |

## Could not check
The test gives COULD NOT CHECK when `artifact_revision` (with `artifact_id` and `revision`) or `review` is absent, and part B also when `verdict` or `work` is absent. A case gives `could_not_check` when the target cannot be planted. Part B gives COULD NOT CHECK wherever the harness cannot run. While it does, N28's positive rests on no run, and the record says so.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-N28-1 turns red exactly N28-a, N28-b, N28-S-verdict, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- The sample Review the database makes itself in the same transaction as a format-gated record's revision: DM-41's trigger must not refuse it, or every sampled write would fail. This is reported for the executor (the group's report, "Open"); Group C's sample tests would show it.
- The same rule through two tokens' `devos_api` calls in one connection: covered by the trigger, which acts whatever the caller.
