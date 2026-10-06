## (1) Who reads run records, or any part of them

The documents use these names: "run record", "transcript" (`run_records.md`:5, `replay_suite.md`:9), "recorded sessions" (`overview.md`:13), and "golden sessions" or "fixtures" for the copies (`replay_suite.md`:5, :9). The records live in the "run store", `/srv/brindle/runs/<YYYY-MM-DD>/<session-id>.jsonl`, where the date is the day the session started (`run_records.md`:9).

| # | Reader | What it reads | When | Source |
|---|---|---|---|---|
| 1 | On-call engineer | The whole run record of a failed session. | When a session fails. The on-call guide asks for the last 7 days of records to be available. | `operations.md`:7, "When a session fails, the on-call engineer reads its run record to find out why. The on-call guide asks for the run records of the last 7 days to be available; in the last six months no one has needed an older one." |
| 2 | Dispatcher (usage copy) | The token counts in the end line (line n). | When the session ends. | `operations.md`:11, "When a session ends, the dispatcher copies the token counts from the end line of its run record into the usage database." |
| 3 | Reviewer, through `brindle replay promote <session-id>` | The whole record, copied into the Brindle repository as `tests/replay/fixtures/<session-id>.jsonl`. | While reviewing the session, "within two days of the session's end". | `replay_suite.md`:9, "This copies the session's transcript (its run record) into the Brindle repository as `tests/replay/fixtures/<session-id>.jsonl`. Reviewers promote sessions while reviewing them, within two days of the session's end." Also :5, "past sessions that a reviewer marked as good references". |
| 4 | Replay suite (`brindle replay run`) | Only the fixture copies, never the run store. It replays the recorded tool outputs (lines 2 to n-1) and compares the agent's choices with them. | Before every release, which needs the suite to pass. | `replay_suite.md`:13, "The suite reads only the fixture files; it does not read the run store. A fixture that fails to load fails the suite." Also :5 and :15, `operations.md`:19 and `overview.md`:13. |
| 5 | On-call engineer writing the BR-212 storage report | Only metadata: sizes by month of session start, the oldest record's date, and the daily volume. Not the content. | Once, for the report dated 2026-09-30. | `storage_report.md`:5, "Prepared by the on-call engineer for work item BR-212." :9, "the oldest record is from that day." :26, "new records added 14.0 GiB a day on average". |
| 6 | Retention job (BR-212), planned and not yet built | At least the run store's listing, to choose what to delete. Its dry-run must print what it would delete. | Not specified. It must run in dry-run mode for at least one day before it is enabled. | `policy_notes.md`:11, "The platform team owns the retention job (work item BR-212)." `operations.md`:30 and `policy_notes.md`:8 give the dry-run rule. |

These are named in the documents but do not read run records:

- **The dispatcher's trigger check.** It reads the `periodic_runs` table, not run records (`scheduler.md`:20).
- **Invoices and the monthly cost report**, including the `cost-report` periodic session. They are "built from the usage database only" (`operations.md`:11, `scheduler.md`:12).
- **Backups.** "The run store is not backed up" (`operations.md`:15).
- **The disk alert.** It reads how full the volume is, not the records (`operations.md`:34, `storage_report.md`:8).
- **The security lead and counsel.** They asked about and ruled on obligations; no reading is mentioned (`policy_notes.md`:9).
- **Writers, not readers.** The session creates its record and appends to it (`run_records.md`:21). The dispatcher writes the end line for a session stopped at the 6-hour limit (`run_records.md`:15).

## (2) Where the documents leave unclear whether, or when, something reads run records or needs them kept

1. **The on-call 7-day window** (`operations.md`:7).
   - The guide only "asks for" 7 days, and the guide itself is not in the folder, so it is unclear whether 7 days is a firm minimum.
   - The 7 days could count from the session's start (the directory date, `run_records.md`:9), its end, or when the failure was noticed. They could also be calendar days or 168 hours.
   - "When a session fails" may cover only status `failed`, or also `killed` (`run_records.md`:15).
   - "No one has needed an older one" rests on months when only one team used Brindle (`overview.md`:18). It says little about need now that volume is about 14 to 15 GiB a day.
2. **The usage copy** (`operations.md`:11).
   - Nothing says what happens if the dispatcher is down or the copy fails when a session ends. No retry, backfill or reconciliation from the end line is described.
   - For a session stopped at the 6-hour limit, the dispatcher writes the end line (`run_records.md`:15). Where it gets those token counts is not stated.
   - The usage database is backed up nightly (`operations.md`:15). Nothing says whether up to a day of counts lost in a restore would be rebuilt from run records.
3. **The promote window** (`replay_suite.md`:9).
   - "Within two days of the session's end" describes a habit, not a rule. Nothing says what happens if a reviewer is later.
   - It is implied but never said that `promote` reads from the run store.
   - The two days count from the end, but records are filed by start date. A session can run up to 6 hours (`overview.md`:10), so the two can differ.
   - It is not said whether reviewers read the record to judge a "good reference" (`replay_suite.md`:5). It is also not said whether engineers who review pull requests read run records (`overview.md`:5).
4. **Fixture repair** (`replay_suite.md`:13). "A fixture that fails to load fails the suite", and a failing suite blocks a release. Nothing says whether a broken or outdated fixture is ever copied again from the run store, which would need older records kept.
5. **Retrying periodic sessions** (`scheduler.md`:22). The on-call engineer runs `brindle periodic retry <trigger-key>`, which needs the failed session's trigger. Two documents disagree about where that is stored:
   - The `sessions` table lacks trigger and period, and the header is "not stored anywhere else" (`run_records.md`:17).
   - Yet `periodic_runs` holds trigger and period (`scheduler.md`:20). Whether it holds a session ID is not stated.

   So it is unclear whether a retry depends on the run record's header. A retry can come any time within the period, up to a quarter for `licence-scan` and `access-review`. It is unclear whether those records must outlive 7 days. `scheduler.md`:24 ("like any other") does not settle this.
6. **Restoring the dispatcher database.** `dispatcher.db` is backed up nightly (`operations.md`:15), and data loss has happened before with `queue-vacuum` (`policy_notes.md`:8). After a restore, the `sessions` and `periodic_runs` rows added since the last backup would be lost. Nothing says whether anyone rebuilds them from run record headers, the only other copy of the header (`run_records.md`:17).
7. **Header fields with no named reader.** `run_records.md`:17 stresses that the header (`kind`, `trigger`, `period`, `model`, `work_item`) exists nowhere else, but no document names who reads it. The data sources of `weekly-digest` ("the week's merged work"), `licence-scan` and `access-review` are not stated either (`scheduler.md`:9–14).
8. **The retention job's design** (`policy_notes.md`:11).
   - What it reads is not stated: directory dates, or headers and end lines.
   - It is not stated whether it must skip records that are still being appended (`run_records.md`:21), sessions not yet promoted, or failures still under investigation.
   - No retention period is set anywhere. The only target is staying below 70% of the volume.
   - Deletion cannot be undone, because the run store is not backed up (`operations.md`:15).
9. **Agent sessions.** It is not stated whether sandboxed agent sessions on `disp-1` can or do read earlier run records (`overview.md`:10).
10. **The fixtures path in the dispatcher's configuration.** `brindle.toml`:7 lists `replay_fixtures = "tests/replay/fixtures"` under `[paths]`. The path is relative, and it is unclear to what. It is also unclear why the dispatcher's configuration holds it, that is, whether the dispatcher or something else on `disp-1` takes part in promoting or reading fixtures.
11. **Security or incident use** (`policy_notes.md`:9). The ruling covers obligations to keep the records ("operational data"). It does not say whether security or incident investigations ever read them.
