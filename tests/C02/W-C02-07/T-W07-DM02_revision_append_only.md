# T-W07-DM02 · A revision table refuses UPDATE and DELETE to every role; a new revision is appended

Synthetic test data (plan Section 8 item 13): one revision row per revision table, planted inside a rolled-back transaction (text `w07_fixture SYNTHETIC W-C02-07`, scope `synthetic.w07fixture`, random uuids).

**Serves.** W-C02-08 points 3 and 6. EV-C02-002 DM-02 (a): "The revision table refuses update and delete to every role"; section 6 asks W-C02-07 to cover it, as a rule no Appendix C test names (plan Section 8 item 3). Appendix B principle 3: "An update does not change the old revision".
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-08 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. In `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_dm02_revision_append_only.sql` as `postgres`, and passes only on the notice `W07_DM02_REVISION_APPEND_ONLY PASS`. Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-DM02-1_work_revision_writable.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. `devos_private.<family>_revision` for `mission`, `work`, `finding`, `artifact` and `decision` (DM-02's families in C02), each with an integer `revision`. Every `devos_private` table whose name ends in `_revision` is read from the catalogue at run time, so a family a later stage adds is covered without editing the file.


**Phase C, the executor's decision.** TRUNCATE counts as a delete for DM-02, so the `-trunc` cases stay.

## Cases (one set per revision table, from the catalogue)
- **DM02-<table>-ins** (positive control): a new revision row is appended at the owner level.
- **DM02-<table>-upd**: `UPDATE ... SET revision = revision + 1000` on that row. The row is unchanged afterwards (refused, raising or not).
- **DM02-<table>-del**: `DELETE` of that row. The row is still there.
- **DM02-<table>-trunc**: `TRUNCATE ... CASCADE`. The row is still there.
- **DM02-list** records the tables found; **DM02-pre** is `could_not_check` when one of the five is absent.

Every attempt runs as `postgres`, the migration role and owner level, which is the strongest role a test reaches. The application roles' direct writes are T-W07-5A's.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-DM02. No role, the owner level included, can change or remove a stored revision; appending a new one works. |
| **Failure class rule** | **[Designer's addition: a design rule with no Appendix C entry]** A stored revision that changes or disappears: an update in place, a delete, a truncate, through any role or any function that runs as the owner. |
| **Examples** | **[Designer's addition]** Update in place, DM-02's first named act: DM02-*-upd. Other manifestations: delete (DM02-*-del) and truncate (DM02-*-trunc), each on every revision table. |
| **Negative control** | Each update, delete or truncate leaves the planted row present and unchanged (`to_jsonb` of the row compared before and after). |
| **Positive control** | DM02-<table>-ins: an insert of a new revision is accepted. It differs from the negatives only in being an append. |
| **Break attempt** | **B-DM02-1** (`breaks/B-DM02-1_work_revision_writable.sql`) removes the refusal on one table, `work_revision`, by disabling its user triggers and dropping its rules. Must turn red: **DM02-work_revision-upd, DM02-work_revision-del, DM02-work_revision-trunc**; every other table stays green. |
| **Stage and environment** | C02. `devos-test`, the migration job's test step, as `postgres`. The break runs on the throwaway database. The migration job runs a file of this test only once W-C02-08 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job, by W-C02-08's producer at its head, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural. It does not show that a function writes a new revision where it should (the families' own tests), nor what the project owner's or `supabase_admin`'s superuser rights could do (W-C02-08 "Not covered" (e)). |
| **Evidence envelope** | README 4's fields. Values fixed before the run: four cases per table, with the outcomes above; the break's three red cases. |

## Could not check
The test gives COULD NOT CHECK when one of the five revision tables, or its `revision` column, is absent. A table's cases give `could_not_check` when no revision row can be planted in it. Before the build exists the test gives COULD NOT CHECK.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-DM02-1 turns red exactly DM02-work_revision-upd, -del, -trunc, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- **"Delete" read as including TRUNCATE**, since TRUNCATE removes rows without firing row triggers. DM-02 names update and delete; if the executor reads it otherwise, the trunc cases go before the first result (the group's report, "Open").
- The superuser roles (W-C02-08 "Not covered" (e)).
