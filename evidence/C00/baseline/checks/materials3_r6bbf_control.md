I read all eight files in `/tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/bl/r6bbf/materials/` (9 tool calls, no files written). Citations below are `file:line`, and every paragraph in these files is one line.

The documents use these names for run records and their parts:
- **The record:** "run record" and "transcript" (`run_records.md:5`, "Some documents call it the transcript"; `replay_suite.md:9`).
- **Copies of records:** "recorded sessions" (`overview.md:13`), "golden sessions" and "fixtures" (`replay_suite.md:5,9`).
- **Parts:** "session header" (line 1), the tool-call lines, and the "end line" with the token counts (`run_records.md:13-15`).

## (1) Who reads run records, or any part of them

**Readers of the run store itself**

1. **On-call engineer (a person).**
   - **What:** the whole record of every session that ended `failed` or `killed`, header included. Records of sessions that ended `done` are never read on call.
   - **When:** after the failure. Records must stay available for today's date directory (UTC) and the six before it, counted by the day the session started.
   - **Sources:**
     - `operations.md:7`: "When a session fails or is killed, the on-call engineer reads its whole run record, session header included, to find out why; on call, records of sessions that ended `done` are not read."
     - Same line: "The on-call guide requires the run records of the last 7 days to be available, counted by the run store's date directories: today's (UTC) and the six before it…"
     - `overview.md:5`: "An engineer reads run records only as a reviewer or on call."
   - **Implied header use:** for a failed periodic session the on-call engineer runs `brindle periodic retry <trigger-key>` (`scheduler.md:22`). The trigger key exists only in the record header, because the `sessions` table holds no `kind`, `trigger` or `period` (`run_records.md:17`).
   - **Copying out:** "anything needed for longer goes into the incident notes, not the run store" (`operations.md:7`).
2. **Reviewers (the engineers who review a session's pull request).**
   - **What:** "its run record".
   - **When:** while reviewing, and only within 48 hours of the session's end.
   - **Sources:**
     - `replay_suite.md:9`: "every reviewer reads its run record, and may promote it, while reviewing, within 48 hours of the session's end; a review that happens later uses the pull request alone."
     - `overview.md:5`.
3. **`brindle replay promote <session-id>` (run by a reviewer).**
   - **What:** copies the whole record from the run store into the Brindle repository and commits it as `tests/replay/fixtures/<session-id>.jsonl`. It finds the record through the start date and end time in the `sessions` table.
   - **When:** while reviewing. It "refuses a session that ended more than 48 hours ago".
   - **Sources:** `replay_suite.md:9`; `brindle.toml:5` (run_store "used only by the dispatcher and `brindle replay promote`").
4. **Dispatcher (a process on `disp-1`).**
   - **What and when:** it "reads the token counts from the end line of its run record, once, as soon as the end line is written, and copies them into the usage database". If that database cannot be reached, it keeps the counts in `dispatcher.db` until the copy succeeds.
   - **After a restart:** "before anything else it writes their end lines and copies their counts".
   - **Sources:** `operations.md:11`; `brindle.toml:5`.
   - **What it does not do:** it writes missing end lines (`run_records.md:15`), which is a write, not a read. Its trigger check uses the `periodic_runs` table, not the records (`scheduler.md:20`).

**Readers of copies (fixtures), not the run store**

5. **Replay suite, `brindle replay run`.**
   - **What:** the fixture files, which are promoted records (61 as of 2026-09-30).
   - **When:** before every release, since a release needs the suite to pass.
   - **Sources:**
     - `replay_suite.md:13`: "The suite reads only the fixture files; it does not read the run store."
     - `overview.md:13`; `operations.md:19`; `brindle.toml:7`.
6. **The engineer who repairs a broken fixture.** A fixture that fails to load "is then fixed by hand or removed, and never copied again from the run store" (`replay_suite.md:13`).
7. **Agent sessions.**
   - "A session reads nothing from the run store; it only appends to its own record" (`overview.md:10`).
   - However, its container sees "the repositories it works on, with their committed files (in the Brindle repository, the replay fixtures)", so a session can see copies of records.

**Readers of the run store's size or metadata, not record contents**

8. **Storage report**, "Prepared by the on-call engineer for work item BR-212". It shows space by month of session start and the daily volume (`storage_report.md:5,11-26`).
9. **Disk alert at 85%** (`brindle.toml:18`; `policy_notes.md:11`).
10. **Planned retention job, BR-212**, which "The platform team owns" (`policy_notes.md:11`). Any job that deletes data needs a `--dry-run` mode "which prints what it would delete" and must run in that mode for at least a day first (`operations.md:30`; `policy_notes.md:8`).

**Stated non-readers**
- **Billing:** invoices and the cost report are built "from the usage database only, and usage data are never rebuilt from run records" (`operations.md:11`).
- **Periodic sessions:** `cost-report` and the other periodic sessions take their data from the usage database or the repositories (`scheduler.md:24`).
- **Backups:** "The run store is not backed up"; neither database is rebuilt from run records (`operations.md:15`).
- **Security, audit, legal and customers:** "no security process reads them" (`policy_notes.md:9`).
- **Engineers filing work items:** filing "needs none" (`overview.md:5`).
- **`periodic retry`:** "needs nothing but the trigger key" (`scheduler.md:22`).
- **Closing statements:** "Run records are read only as these documents describe" (`overview.md:11`); "after a session ends, its header is read only within the whole record, by the readers in `operations.md` and `replay_suite.md`" (`scheduler.md:20`).

## (2) Points the documents leave unclear

1. **Dispatcher restart.**
   - The dispatcher writes missing end lines "with the token counts that the session reported to it while running" (`run_records.md:15`) and, after a restart, writes them "before anything else" (`operations.md:11`).
   - The documents never say whether those reported counts are saved in `dispatcher.db` or kept only in memory. If only in memory, it is unstated how they would be recovered, possibly by reading the records.
   - It is also unstated how the dispatcher finds sessions without an end line (from the `sessions` table or by scanning the run store).
   - Nor does it say whether, for end lines it writes itself, it reads the counts back from the record or uses the values it already holds.
2. **The cross-reference in `scheduler.md:20` does not match the files it points to.**
   - In `operations.md`, the dispatcher reads only the end line, not the header.
   - In `replay_suite.md`, the suite reads fixtures, not the run store, and reviewers read "its run record" without saying whole record or header.
   - Who reads a header before the session ends is not addressed.
3. **Where the on-call engineer gets the trigger key for `periodic retry`.**
   - It is never stated. `sessions` has no `trigger`/`kind`/`period` (`run_records.md:17`), and `periodic_runs` has no session ID. So the header is the only link from a failed session to its trigger, and that is implied, not stated.
   - The claim "nothing needs to know which session did a period's work" (`scheduler.md:20`) sits uneasily with this.
   - Retry runs for "the current period" only. Whether a failed past period's `period` field is ever needed is not addressed.
4. **The on-call 7-day rule.**
   - It is a minimum ("its only rule"). The statement that "no on-call engineer has needed an older one" is history, not a rule.
   - Three of the four teams joined only in August, so only September reflects the current load.
   - What goes into the incident notes, and who reads them later, is not described.
5. **Reviewers.**
   - Whether "its run record" means the whole record is not said.
   - `dep-update` periodic sessions open pull requests (`scheduler.md:11`), but `overview.md:5` frames reviewing around work items. It is unclear whether those records are read or promoted.
   - Also unclear:
     - whether a failed or killed session that opened a pull request is reviewed with its record;
     - how the 48-hour limit applies to a review that starts before it and runs past it, or to a re-review;
     - what clock the reading limit uses. `promote` enforces 48 hours using the `sessions` end time, but for reading it is only a statement in prose.
6. **How humans reach the run store.** `brindle.toml:5` says the run_store path is "used only by the dispatcher and `brindle replay promote`". How on-call engineers and reviewers access records is undocumented. The storage report and the planned retention job are not in that list either.
7. **Agent sessions and fixtures.** Sessions working in the Brindle repository can see the committed fixtures, which are copies of records. Whether any session reads them, for example `dep-update` or a work item touching the replay suite, is not stated.
8. **Retention job BR-212 is unspecified.** It is also missing from the maintenance-job table in `operations.md`. Unknowns:
   - what it reads: directory names only, or header/end-line fields such as `status` or `kind`;
   - whether it skips records still being written, since a session can run up to 6 hours past midnight from an older date directory;
   - who reads the dry-run list, and what they check it against.
9. **Size and metadata reads.** It is unclear whether reading the run store's sizes and date directories, as the storage report and the disk alert do, counts as "reading run records" under `overview.md:11`.
