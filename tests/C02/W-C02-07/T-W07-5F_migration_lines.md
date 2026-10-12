# T-W07-5F · Each migration line of C02's Acceptance has a test in form C0 among W-C02-03's tests

Synthetic test data (plan Section 8 item 13): this test reads file paths and field names only; it plants, in a scratch copy outside the repository, a specification with a field removed and a citation to an absent path, both labelled SYNTHETIC W-C02-07.

**Serves.** W-C02-07 point 5 (f) ("the tests W-C02-03's acceptance gives them are named, with their paths and the item that runs them; a line without a test in form C0 there gets one here"), and point 6's `deployment_drift` citation. It serves no build item of its own: the tests it cites serve W-C02-03 (W-C02-03 points 5 to 10, 12 and 14).
**Command.** From the repository root, at the head that adds W-C02-07's tests:
- `git show main:<path>` for each path below (present on `main`);
- `grep -c` for each of the ten C0 field names (`ID and claim`, `Failure class rule`, `Examples`, `Negative control`, `Positive control`, `Break attempt`, `Stage and environment`, `Independence level`, `Evidence layer`, `Evidence envelope`) in each cited specification. Each must be ≥ 1.

The checker of W-C02-07 runs it, and W-C02-13's prober runs it again.
**Time added to W-C02-13's run.** None.
**Interface assumed.** W-C02-03's test files at the paths below, as on branch `claude/c02-w03-tests` (commit `86ebd65`, its check CHK-C02-017 at `a755c92`, PASS-WITH-CONDITIONS), **not yet merged into `main`** when this was written. The citation waits for that merge (W-C02-07's body: a partial wait, off the critical path). Until then this test's result is COULD NOT CHECK. If CHK-C02-017's conditions C1 and C2 change a path or a field, the table is revised before the result.

## The table (the cases)
| Case | Line of `plan/work/C02.md`'s acceptance | W-C02-03's test (path) | Point | Runs it |
|---|---|---|---|---|
| 5F-36 | "✔ A migration merged into `main` is applied by the CI job, and its effect is seen in the database." | `tests/C02/W-C02-03/T-W03-05_apply_and_effect.md` | 5 | W-C02-03's producer, from the job's runs; its checker (point 13) |
| 5F-37 | "✘ A migration merged into `main` but not applied is detected by the comparison of 6.2 (PC-16)." | `tests/C02/W-C02-03/T-W03-06_merged_not_applied.md` with `supabase/migrations/tests/w03_drift_detects.sql`, `tests/C02/W-C02-03/test_decision_steps.py` and `T-W03-DEC_decision_steps.md`; breaks `tests/C02/W-C02-03/breaks/B1` to `B3` | 6 | the migration job (SQL), W-C02-03's producer and checker; the breaks by W-C02-07's harness at W-C02-13 |
| 5F-37cnc | the same line's "could not check" (W-C02-07 point 6) | `tests/C02/W-C02-03/T-W03-07_could_not_check.md` with `supabase/migrations/tests/w03_drift_could_not_check.sql`; break `breaks/B4_could_not_check_as_clean.sql`; and `T-W03-14_order_and_stop.md` with `test_workflow_order.py` (the second example of point 14) | 7, 14 | as 5F-37 |
| 5F-38 | "✘ The migration credential cannot be read by an agent session, nor by a workflow run for a branch other than `main`." | `tests/C02/W-C02-03/T-W03-08_branch_refused.md` (branch runs) and `T-W03-09_credential_search.md` (agent sessions) | 8, 9 | W-C02-03's producer, from GitHub's run records and the scheduled jobs; its checker |
| 5F-39 | "✔ The C01 probe schema and its tokens no longer exist." | `tests/C02/W-C02-03/T-W03-10_probe_absence.md` | 10 | W-C02-03's producer and checker |

A case is `ok` when the path is on `main` and each of the ten fields is present; `bad` when a field is missing or the line maps to nothing; `could_not_check` when the path is not on `main`.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-5F`: every migration line of C02's Acceptance (`plan/work/C02.md` lines 36 to 39) maps to a test in form C0, on `main`, named by path with the item that runs it. |
| **Failure class rule** | Any migration line whose test is absent, not in form C0, or cited by a path that is not on `main`. **[Designer's addition: an Acceptance line, not an Appendix C entry.]** |
| **Examples** | The original gap: "The migration items … no Appendix C test" (R2 section 5 (b)), checked for every line (5F-36 to -39). Another manifestation: a cited test that exists only on an unmerged branch (the state when this was written: every case is `could_not_check`). |
| **Negative control** | A field removed from a scratch copy of one cited specification, and a citation to an absent path, must each make the check `bad` and `could_not_check`. Run on a scratch copy outside the repository before the real run. |
| **Positive control** | Run on W-C02-03's branch (`a755c92`) by the test designer on 2026-10-12, the field check found all ten fields in each of `T-W03-05`, `-06`, `-07`, `-08`, `-09`, `-10`, `-14` and `-DEC`. It is repeated on `main` once merged. |
| **Break attempt** | (1) What is removed: one C0 field from one cited specification (for example the "Break attempt" row of `T-W03-08`), or one path from the table. (2) Path: a scratch copy of the repository outside the clone, never a commit. (3) The case of that line (5F-38) must turn `bad`. |
| **Stage and environment** | C02. A repository read; no Supabase project and no token. |
| **Independence level** | Written by the test designer (fresh-context `test-designer` subagent; agent ID in W-C02-07's Record). Run by W-C02-07's checker, and by W-C02-13's prober. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the plan text. |
| **Evidence layer** | Structural: presence of tests and fields. It does not judge whether W-C02-03's tests are right (CHK-C02-017 judges that) or whether they pass (W-C02-03's acceptance). |
| **Evidence envelope** | README section 4. Fixed before the run: the table above and the ten field names. `target_commit`: the `main` commit read. Raw evidence `W07-5F-<run_at>`: the command's output. |

## Clause table
Not an Appendix C test. Lines 36 to 39 of `plan/work/C02.md`, each mapped above. No line lacks a test in form C0 at `a755c92`, so none is written here.

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK while W-C02-03's tests are not on `main` (the state on 2026-10-12), or when a cited file cannot be read.

## Not covered
- Whether W-C02-03's tests pass, or fail on their breaks (W-C02-03, W-C02-13).
- The ledger line (line 35): W-C02-14 point 13, written after W-C02-06's design.
