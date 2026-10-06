I read all eight files in `/tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/bl/r974a/materials/`, using 10 tool calls and writing no files. Five things read run records or a copy of them. The documents also leave 11 points unclear about who reads them, when, or for how long they must be kept.

## List 1: What reads run records (also called "transcript"), what each reads, and when

The name "transcript" comes from run_records.md:5: "Every agent session writes one **run record**: the session's transcript, as JSON Lines. Some documents call it the transcript."

1. **On-call engineer (one per week).**
   - **Reads:** the whole run record of a session that failed or was killed, header included.
   - **When:** when that session fails or is killed. Records must stay available for the last 7 days.
   - **Source:** operations.md:7: "When a session fails or is killed, the on-call engineer reads its whole run record, session header included, to find out why. The on-call guide requires the run records of the last 7 days to be available, counted by the run store's date directories (today's and the six before it); that is its only rule on run records, and anything needed for longer goes into the incident notes, not the run store. In the last six months, September included, no one has needed an older one."
   - **Likely also (my inference, not stated):** the engineer probably gets the trigger key for `brindle periodic retry <trigger-key>` from the header. scheduler.md:22 says the command "needs nothing but the trigger key", and run_records.md:17 says the `sessions` table does not hold `trigger`.

2. **Dispatcher (the process on `disp-1`).**
   - **Reads:** the token counts on the end line only.
   - **When:** once, when the session ends. No later re-read is needed.
   - **Source:** operations.md:11: "When a session ends, the dispatcher reads the token counts from the end line of its run record, once, and copies them into the usage database; if that database cannot be reached, the dispatcher keeps the counts in `dispatcher.db` until the copy succeeds."
   - **Killed sessions:** for a session stopped at the 6-hour limit, the dispatcher writes that end line itself (run_records.md:15). It reads the store's path from the config (brindle.toml:2 and :5).

3. **Reviewers (the engineers who review a session's pull request).**
   - **Reads:** the session's run record.
   - **When:** while reviewing, within two days of the session's end.
   - **Source:** replay_suite.md:9: "Reviewers are the engineers who review a session's pull request; they read its run record and promote it while reviewing, within two days of the session's end".

4. **The `brindle replay promote <session-id>` command (run by a reviewer).**
   - **Reads:** the whole run record. It copies it into the Brindle repository as `tests/replay/fixtures/<session-id>.jsonl`.
   - **When:** only up to two days after the session ended.
   - **Source:** replay_suite.md:9: "This copies the session's transcript (its run record) from the run store into the Brindle repository … and `promote` refuses a session that ended more than two days ago."
   - **Config:** brindle.toml:2 says "The dispatcher and the `brindle` command both read this file", and that file includes `run_store`.

5. **The agent session itself.**
   - **Has access to:** its own record only.
   - **When:** while it runs, which is at most 6 hours.
   - **Source:** overview.md:10: "its container sees the repositories it works on and its own run record, and nothing else of the run store". run_records.md:21: "The session creates its record when it starts and appends to it while it runs."

**Readers of copies only, never the run store:**

- **Replay suite (`brindle replay run`).**
  - **Reads:** the 61 fixtures, which are copies of run records holding the recorded tool outputs and the agent's choices.
  - **When:** before every release.
  - **Source:** replay_suite.md:13: "The suite reads only the fixture files; it does not read the run store. A fixture that fails to load … is then fixed by hand or removed, and never copied again from the run store." Also replay_suite.md:5 and :15, operations.md:19 and overview.md:13.

**Touch the run store but do not read record contents:**

- **Disk alert at 85%.** It goes to the on-call engineer (operations.md:34, brindle.toml:18, storage_report.md:8).
- **Author of the storage report.** The on-call engineer measured space by month of session start on 2026-09-30, for BR-212 (storage_report.md:5 and :11).
- **Planned retention job BR-212.** It is owned by the platform team (policy_notes.md:11). In dry-run mode it "prints what it would delete" (operations.md:30).

**Explicitly not readers:**

- **Invoices, the monthly cost report and the `cost-report` session.** They use the usage database only, and "usage data are never rebuilt from run records" (operations.md:11, scheduler.md:24).
- **The dispatcher's trigger check.** It uses the `periodic_runs` table (scheduler.md:20).
- **Other periodic sessions.** They "take their data from the repositories" (scheduler.md:24).
- **Backups.** "The run store is not backed up"; "nothing in either database is ever rebuilt from run records" (operations.md:15).
- **Security, audit, legal and customer needs.** "No audit, legal or customer obligation requires keeping them, and no security process reads them" (policy_notes.md:9).
- **Other sessions.** They see "nothing else of the run store" (overview.md:10).
- **`queue-vacuum` and `cert-check`.** They work on the dispatcher database and on certificates (operations.md:27–28).

## List 2: Where the documents leave unclear whether, or when, something reads run records or needs them kept

1. **Which reviews read records, and how late.** replay_suite.md:9 does not say whether every reviewer reads the record of every pull request they review, or only of sessions they promote.
   - The two-day limit binds `promote`, not review. No document limits when a review happens.
   - A review done after 2 days, or after 7, would still want the record, though the session could no longer be promoted.

2. **How `promote` finds the record and checks its age.**
   - It is not stated whether `promote` takes the end time from the record's end line or from the `sessions` table.
   - It is not stated how it finds the start-date directory, or what it does when the record is gone.
   - "Two days" is not defined as 48 hours or as calendar days.
   - brindle.toml is "an excerpt" and does not say which `brindle` subcommands read `run_store`.

3. **Edges of the on-call window.** The 7 days are "counted by the run store's date directories", and directories are named by the UTC start date (run_records.md:9).
   - A session can run up to 6 hours. One that started before midnight on the day before the window and failed or was killed after midnight falls outside the window, although it failed within the last 7 days.
   - The time zone of "today" is not stated.
   - Only failed or killed sessions are covered. No document says whether anyone reads the records of sessions that ended `done`, for example when a merged pull request later proves wrong.

4. **Who "no one" means.** In "no one has needed an older one" (operations.md:7), the sentence sits under On-call. It is unclear whether it covers only on-call engineers or every reader.

5. **The dispatcher's read when something goes wrong.** operations.md:11 says the end line is read "once" when a session ends. The documents do not say what happens:
   - if the dispatcher is down when a session ends (a later catch-up read?);
   - if a session crashes without writing an end line. run_records.md:15 has the dispatcher writing the end line only in the 6-hour kill case.

6. **Does a session read its own record?** overview.md:10 says the container "sees" its own record. Whether the session reads it, or only writes it, is not stated. This matters only during its 6 hours.

7. **Sessions that work on the Brindle repository can see 61 earlier transcripts.** Fixtures are committed to that repository (replay_suite.md:9), and the platform team uses Brindle (overview.md:18). That conflicts with "A session gets nothing from earlier sessions" (overview.md:10).

8. **How `replay run` finds the fixtures.** brindle.toml:7 says `replay_fixtures` is "used only by `brindle replay promote`". Yet replay_suite.md:13 has `brindle replay run` reading those files, and how it locates them is not stated.

9. **Header fields kept nowhere else.** `kind`, `trigger`, `period` and `model` exist only in record headers (run_records.md:17). `periodic_runs` holds `trigger` and `period` but no documented session ID (scheduler.md:20), and the usage database holds "token counts per session" (overview.md:12).
   - No document says whether anything besides the on-call engineer needs these fields, for example `model` for billing, or tracing which session did a period's work.
   - The documents do say that invoices and the cost report come from the usage database only.

10. **Engineers who file work items.** No document says whether they read run records (overview.md:5). policy_notes.md:9 excludes only security, audit, legal and customer needs, and no document claims to list every reader.

11. **What the retention job will read.** Nothing says whether BR-212 will read only directory listings, or also end lines and headers, for example to skip sessions still running in today's directory (policy_notes.md:11, operations.md:30).
