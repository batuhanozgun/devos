I read all eight files in `materials/` (`overview.md`, `run_records.md`, `operations.md`, `scheduler.md`, `replay_suite.md`, `storage_report.md`, `policy_notes.md`, `brindle.toml`) using 9 tool calls and wrote no files.

The documents call a run record by several names: "run record", "the transcript" (`run_records.md:5`: "Some documents call it the transcript."), and by its parts, "session header" (line 1) and "end line" (line n). A copy of one in the repository is called a "fixture" or "golden session".

## (1) Who reads run records or parts of them

| # | Reader | What it reads | When | Source |
|---|---|---|---|---|
| 1 | **On-call engineer** | The whole run record of a failed session | When a session fails. Needs the last 7 days kept. | `operations.md:7`: "When a session fails, the on-call engineer reads its run record to find out why. The on-call guide asks for the run records of the last 7 days to be available; in the last six months no one has needed an older one." |
| 2 | **Dispatcher, usage copy** | The end line (token counts) | Once, when the session ends (at most 6 h after start) | `operations.md:11`: "When a session ends, the dispatcher copies the token counts from the end line of its run record into the usage database." |
| 3 | **Dispatcher, periodic trigger check** | Session headers (line 1): the `trigger` and `period` fields | Every 15 minutes, for each trigger, for the whole period after its "due from" time | `scheduler.md:18`: "Every 15 minutes the dispatcher checks each trigger."; `scheduler.md:20`: "The dispatcher looks through the session headers for one whose `trigger` is this trigger's key and whose `period` is the current period. If it finds one, the period's work is done or under way, and nothing starts; otherwise it starts the session." `run_records.md:17` shows these headers live only in run records: "The session header is not stored anywhere else: the dispatcher's `sessions` table keeps only the session ID, the work item, the status and the start and end times." `brindle.toml:12` has `trigger_check_minutes = 15`. |
| 4 | **Reviewer, via `brindle replay promote <session-id>`** | The whole record, copied into `tests/replay/fixtures/<session-id>.jsonl` | "within two days of the session's end", while reviewing the session | `replay_suite.md:9`: "When a reviewer marks a session as a good reference, they run `brindle replay promote <session-id>`. This copies the session's transcript (its run record) into the Brindle repository as `tests/replay/fixtures/<session-id>.jsonl`. Reviewers promote sessions while reviewing them, within two days of the session's end." |
| 5 | **Replay suite (`brindle replay run`)** | Only the fixture copies, never the run store | Before every release | `replay_suite.md:13`: "The suite reads only the fixture files; it does not read the run store. A fixture that fails to load fails the suite." `operations.md:19`: "A Brindle release needs the replay suite to pass." |
| 6 | **On-call engineer, as author of the storage report** | Run store layout and sizes: space by month of session start, oldest record | Once, 2026-09-30, for BR-212 | `storage_report.md:5`: "Prepared by the on-call engineer for work item BR-212."; `storage_report.md:9`: "the oldest record is from that day." Also the table at lines 11–22. |
| 7 | **Retention job BR-212** (planned, not built yet) | The run store listing. Its dry run prints what it would delete. | At least one day of dry run, then on its schedule | `policy_notes.md:11`: "The platform team owns the retention job (work item BR-212)."; `operations.md:30`: "A job that deletes data must have a `--dry-run` mode, which prints what it would delete, and must run in dry-run mode for at least one day before it is enabled". |

How long the dispatcher check needs headers follows from the period lengths in `scheduler.md:9-14`. No document states it as a retention need.
- **Weekly triggers:** up to about 7 days (`weekly-digest` is due Monday 06:00 for the rest of the ISO week).
- **Monthly triggers:** up to about 31 days (`dep-update` from the 1st, `cost-report` from the 2nd).
- **Quarterly triggers:** up to about 92 days (`access-review` from the first working day, `licence-scan` from the first Monday).

If a header is deleted before its period ends, the dispatcher finds no header and starts that periodic session again. A failed session's header also matters: it is what stops an automatic restart (`scheduler.md:22`).

**Checked and found not to read run records:**
- Invoices and the monthly cost report, and therefore the `cost-report` session. They are built "from the usage database only" (`operations.md:11`).
- Backups. "The run store is not backed up." (`operations.md:15`), so any deletion is permanent.
- `queue-vacuum` and `cert-check` (`operations.md:27-28`).
- Disk alerts, which watch volume usage only (`operations.md:34`, `brindle.toml:18`).
- The security lead and counsel. Their decision says "No audit, legal or customer obligation requires keeping them." (`policy_notes.md:9`)

## (2) Points the documents leave unclear

1. **The dispatcher's header lookup is never tied to the run store explicitly.** `scheduler.md:20` says "session headers" without naming the run store. Only `run_records.md:17` implies it. Nothing says which records it scans (every date directory, or only those inside the current period), or what it does when a record is missing or unreadable. Presumably it treats the period as not done and starts the session again.
2. **No document lists the dispatcher as a consumer that needs records kept.** The only retention figure stated anywhere is on-call's 7 days. `policy_notes.md:9` calls run records "operational data" but does not say what the operational uses are. Under the 70% cap (`policy_notes.md:11`), 716.8 GiB at the planned 15 GiB a day (`storage_report.md:26`) allows only about 47 days of records if they are deleted by age alone. That is shorter than a quarterly period.
3. **`brindle periodic retry <trigger-key>`** (`scheduler.md:22`). Nothing says how it gets past the header check, or whether it reads run records itself.
4. **Reviewers.**
   - Who they are is not stated: they may be the engineers who review pull requests (`overview.md:5`).
   - Nothing says whether they read the run record while "reviewing" a session.
   - "within two days of the session's end" might be a rule or just a habit. Nothing says what happens if a review is late, or if `promote` is run on a record that has been deleted.
   - It is also not stated whether engineers reviewing pull requests read transcripts at all, or when.
5. **Fixtures.**
   - "Copies ... into the Brindle repository" does not say whether the copy is committed to git or only sits in a checkout on `disp-1`.
   - `brindle.toml:7` has a relative `replay_fixtures = "tests/replay/fixtures"` in the dispatcher's config, with no explanation of which component uses it or what the path is relative to.
   - Nothing says whether fixtures ever need to be rebuilt from the original records, for example after a format change.
6. **The on-call 7 days.**
   - The on-call guide itself is not in the folder.
   - "Last 7 days" is not defined: by start-date directory or by end time, calendar days or 168 hours.
   - "No one has needed an older one" is an observation, not a rule, and most of those six months came before the other three teams joined in August (`overview.md:18`).
   - Nothing says whether failed monthly or quarterly periodic sessions are ever looked into later than 7 days.
7. **Usage copy and the `sessions` table.**
   - Nothing says whether the token copy is ever repeated or done late from the record, for example if the dispatcher was down when a session ended.
   - When the dispatcher writes the end line for a session stopped at the 6-hour limit (`run_records.md:15`), the documents do not say where it gets the token counts.
   - They also do not say whether the `sessions` table's status and end time come from the end line.
8. **Periodic sessions' own data sources.** For `weekly-digest` ("posts the week's merged work", `scheduler.md:9`) the source is not stated, and it could be the week's run records. Sources for `stale-branches`, `dep-update`, `licence-scan` and `access-review` are also unstated, though nothing suggests they read run records.
9. **Agent sessions.** Nothing says whether a session, sandboxed in a container on `disp-1` (`overview.md:10`), can read the run store or earlier records, for example a later session on the same work item after a failure.
10. **How the retention job will select records** (BR-212) is not documented.
    - Paths use the session start date (`run_records.md:9`), and a session can still be appending for up to 6 hours after a date change.
    - Nothing says whether periodic sessions' records, about a dozen a month (`scheduler.md:24`), get different treatment.
    - Nothing says what its dry run reads.
