I read all eight files in `materials/` in full (overview.md, run_records.md, operations.md, policy_notes.md, replay_suite.md, scheduler.md, storage_report.md, brindle.toml). The documents use three names for run records: "run record", "transcript" (run_records.md:5, "Some documents call it the transcript."; replay_suite.md:9) and, for copies kept in the Brindle repository, "fixture" or "golden session" (replay_suite.md:5,9).

## (1) Who or what reads run records

| # | Reader | What it reads | When | Source |
|---|---|---|---|---|
| 1 | **Dispatcher, periodic-trigger check** | Line 1 (the header) of *every* record in the run store. It looks for a record whose `trigger` and `period` match the trigger and the current period. | Every 15 minutes, for each trigger | scheduler.md:20 "At each check the dispatcher reads the session header of every record in the run store, looking for one whose `trigger` is this trigger's key and whose `period` is the current period." scheduler.md:18 "Every 15 minutes the dispatcher checks each trigger." brindle.toml:12 `trigger_check_minutes = 15`. The run store is the only documented place that holds `trigger`/`period`: run_records.md:17 "it holds none of the other header fields (`kind`, `trigger`, `period`, `model`)." |
| 2 | **Dispatcher, usage copy** | The token counts in the record's last line (the end line) | Once, when the session ends | operations.md:11 "When a session ends, the dispatcher reads the token counts from the end line of its run record, once, and copies them into the usage database" |
| 3 | **On-call engineer** | The whole record of a session that failed or was killed, header included | After a failure or kill. The on-call guide requires the last 7 date directories (today and the six before) to be available. | operations.md:7 "When a session fails or is killed, the on-call engineer reads its whole run record, session header included, to find out why." Same line: "The on-call guide requires the run records of the last 7 days to be available, counted by the run store's date directories (today's and the six before it); that is its only rule on run records" |
| 4 | **Reviewers** (the engineers who review a session's pull request) | The session's record | While reviewing, within two days of the session's end | replay_suite.md:9 "Reviewers are the engineers who review a session's pull request; they read its run record and promote it while reviewing, within two days of the session's end" |
| 5 | **`brindle replay promote <session-id>`** | The whole record, which it copies into `tests/replay/fixtures/<session-id>.jsonl` | When a reviewer runs it. It refuses a session that ended more than two days ago. | replay_suite.md:9 "This copies the session's transcript (its run record) from the run store into the Brindle repository" and "`promote` refuses a session that ended more than two days ago." brindle.toml:2,5 (the `brindle` command reads `run_store`) |
| 6 | **Replay suite (`brindle replay run`)** | Only the fixture copies, never the run store | Before each release | replay_suite.md:13 "The suite reads only the fixture files; it does not read the run store." Same line: "never copied again from the run store". operations.md:19 |
| 7 | **The agent session itself** | Its container can see its own record (it creates the record and appends to it) | While it runs, at most 6 hours | overview.md:10 "its container sees the repositories it works on and its own run record, and nothing else of the run store." run_records.md:21 |
| 8 | **On-call engineer as author of the storage report** | Disk usage of the run store, by date (month of session start). Not record contents. | Once, 2026-09-30, for BR-212 | storage_report.md:5 "Prepared by the on-call engineer for work item BR-212." storage_report.md:11 |
| 9 | **Retention job BR-212** (does not exist yet) | At least the list of what it would delete | Not defined. A deleting job must run in `--dry-run` for at least one day first. | policy_notes.md:11 "The platform team owns the retention job (work item BR-212)." operations.md:30, policy_notes.md:8 |

The documents also say outright that these do **not** read run records:
- **Invoices, the monthly cost report and the `cost-report` session** use only the usage database. operations.md:11 "usage data are never rebuilt from run records". scheduler.md:24.
- **Backups and restores** don't touch run records. operations.md:15 "nothing in either database is ever rebuilt from run records. The run store is not backed up."
- **Security, audit, legal or customer processes**: policy_notes.md:9 "No audit, legal or customer obligation requires keeping them, and no security process reads them."
- **Other periodic sessions** take their data from repositories. scheduler.md:24.
- **Other sessions** can't read earlier records. overview.md:10 "A session gets nothing from earlier sessions".
- **`brindle periodic retry`** reads no records. scheduler.md:22 "needs nothing but the trigger key".
- **`queue-vacuum`, `cert-check` and the disk alerts** read only the database, certificates or volume usage. operations.md:27-28,34.

## (2) Where the documents leave unclear whether, or when, something reads run records or needs them kept

1. **The trigger check needs periodic records kept for a whole period, and no document says so.** The check reads every header every 15 minutes, and "if it finds none (a header it cannot read counts as none), it starts the session" (scheduler.md:20). So deleting a periodic record before its period ends makes the trigger fire again in the same period. That means a second dependency pull request, a second cost-report email, a second access review or new licence issues.
   - How long that is: about a week for weekly triggers, a month for `dep-update` and `cost-report`, and up to about 92 days for `licence-scan` and `access-review`. For example, the Q4 2026 records dated 2026-10-01 and 2026-10-05 would have to last until 2027-01-01.
   - Nothing connects this to retention: scheduler.md never mentions it, and the on-call guide calls its 7 days "its only rule on run records" (operations.md:7). A retention design built on that rule would break the scheduler.
   - It can't be met by keeping whole days. The 70% target (policy_notes.md:11) is about 717 GiB, which at 15 GiB a day is about 47 days of records. Records would have to be kept selectively, and the documents give no size for periodic records.
   - It is also unclear whether the check really scans the whole store or only recent directories ("every record").
2. **It is unclear whether relying on the run store for "is the period done?" is intended.** The `sessions` table lacks `trigger` and `period` (run_records.md:17), and `queue` holds work items (overview.md:9). Whether periodic sessions also appear in `queue` with their trigger is not stated.
3. **The dispatcher's token read has gaps.**
   - For a session killed at the 6-hour limit, the dispatcher writes the end line itself (run_records.md:15). The documents don't say whether it then reads the counts back from the record or uses the counts it already holds.
   - If the dispatcher is down when a session ends, nothing says whether it reads missed end lines later, and so whether a record must outlive that gap. The fallback described covers only an unreachable usage database, after the read (operations.md:11).
4. **The on-call 7-day window leaves points open.**
   - Whether "today" is the UTC date the directories use (run_records.md:9) is not stated.
   - Whether 7 days is a minimum or the intended retention is not stated.
   - How the on-call engineer learns that a session failed (the `sessions` table status or the record's end line) is not stated.
   - "no one has needed an older one" (operations.md:7) describes the past; it is not a rule.
5. **Reviewers' reading has gaps.**
   - It is unclear whether all pull-request reviewers read run records, or only those promoting a golden session (replay_suite.md:9).
   - It is unclear whether a review that lasts more than two days, or more than 7 days, still needs the record.
   - How `promote` learns when the session ended (the record's end line or the `sessions` table) is not stated.
6. **The agent session's own record.** "Sees its own run record" (overview.md:10) doesn't say whether the session reads it. The record must clearly exist while the session appends to it for up to 6 hours, possibly into the next date directory. No document states this as a retention constraint.
7. **The retention job (BR-212) is undefined.** What it reads (directory dates only, or headers so it can spare periodic records) and when it runs are not stated (policy_notes.md:11, operations.md:30).
8. **brindle.toml is only an excerpt** (brindle.toml:2). Both the dispatcher and the `brindle` command read `run_store`, so readers not shown may exist. The file also says `replay_fixtures` is "used only by `brindle replay promote`" (brindle.toml:7), yet `brindle replay run` reads the fixtures (replay_suite.md:13). How `replay run` finds the fixtures is left unclear.
9. **A record without a readable header.** A periodic session that fails before writing line 1, or whose header is damaged, counts as "none" (scheduler.md:20). The trigger then fires again, but the documents don't say whether that is intended.
