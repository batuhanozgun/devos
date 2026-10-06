The documents name five readers of the run store itself, three readers of copies (the replay fixtures) and a few readers of disk metadata. The main gap is that the dispatcher's 15-minute trigger check needs the current period's periodic headers kept for up to a whole quarter, but no document states that as a retention rule. All eight files in `materials/` were read in full, and a keyword search turned up nothing further. Paths below are relative to `/tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/bl/rebb1/materials/`.

Names the documents use: run record, record, transcript, session header / header (line 1), end line (line n), golden session, fixture (a copy kept as `tests/replay/fixtures/<id>.jsonl`), run store (`/srv/brindle/runs`).

## (1) Readers of run records

**A. Dispatcher, trigger check**
- **What it reads:** line 1 (the session header) of every record, in every date directory, however old. It looks for a header whose `trigger` and `period` match the current period.
- **When:** every 15 minutes, for each trigger.
- **What must be kept:** each periodic session's header for as long as its period lasts:
  - a week: up to 7 date directories;
  - a month: up to 31;
  - a quarter: up to 92. For example, an `access-review` record from 2026-10-01 must stay readable until 2026-12-31.
- **Why nothing else can stand in:** the `sessions` table holds none of `kind`, `trigger`, `period` or `model`, and periodic sessions never enter `queue`.
- **Citations:**
  - scheduler.md L18: "Every 15 minutes the dispatcher checks each trigger."
  - scheduler.md L20: "At each check the dispatcher reads the session header of every record in the run store, in every date directory, however old, looking for one whose `trigger` is this trigger's key and whose `period` is the current period."
  - scheduler.md L20: "By design, these headers are the only record of a period's work: a header it cannot read, or a session that failed before writing one, counts as none, so a new session starts, as intended."
  - brindle.toml L12: `trigger_check_minutes = 15`.
  - run_records.md L17: the `sessions` table "holds none of the other header fields (`kind`, `trigger`, `period`, `model`)."
  - overview.md L9: "periodic sessions never enter it."

**B. Dispatcher, billing copy**
- **What it reads:** the token counts on the end line.
- **When:** once, as soon as the end line is written. If the usage database cannot be reached, the dispatcher holds the counts in `dispatcher.db` until the copy succeeds. After its own restart, before anything else, it writes the end lines of sessions that stopped with it and copies their counts.
- **What must be kept:** nothing after that one read.
- **Citation:** operations.md L11: "When a session ends, the dispatcher reads the token counts from the end line of its run record, once, as soon as the end line is written, and copies them into the usage database…"; "…before anything else it writes their end lines and copies their counts."

**C. On-call engineer**
- **What they read:** the whole record, header included, of sessions that ended `failed` or `killed`, to find out why. Records of `done` sessions are never read on call.
- **When:** when a session fails or is killed. The on-call guide requires the last 7 date directories to be available (today in UTC plus the six before it).
- **Citations:**
  - operations.md L7: "When a session fails or is killed, the on-call engineer reads its whole run record, session header included, to find out why; on call, records of sessions that ended `done` are not read."
  - operations.md L7: "The on-call guide requires the run records of the last 7 days to be available, counted by the run store's date directories… That is its only rule on run records…"
  - overview.md L5: "An engineer reads run records only as a reviewer or on call."
- **One-off metadata read:** the on-call engineer also wrote the storage report. It used directory sizes by month of session start and the date of the oldest record, not record contents (storage_report.md L5 "Prepared by the on-call engineer for work item BR-212."; L9; L11–22).

**D. Reviewers** (the engineers who review a session's pull request)
- **What they read:** the session's run record.
- **When:** while reviewing, within 48 hours of the session's end. A later review uses the pull request alone.
- **Citation:** replay_suite.md L9: "every reviewer reads its run record, and may promote it, while reviewing, within 48 hours of the session's end; a review that happens later uses the pull request alone."

**E. `brindle replay promote <session-id>`** (run by a reviewer)
- **What it reads:** the start date and end time from the `sessions` table, then the whole record (the "transcript") from the run store. It commits the copy as a fixture.
- **When:** on demand. It refuses a session that ended more than 48 hours ago.
- **What must be kept:** a 6-hour session that starts just before midnight on day D can still be promoted early on D+3. That means 4 date directories, which fits inside the on-call 7-day window.
- **Citations:**
  - replay_suite.md L9: "This copies the session's transcript (its run record) from the run store into the Brindle repository…"; "`promote` takes the session's start date (its record's directory) and end time from the `sessions` table, and refuses a session that ended more than 48 hours ago."
  - brindle.toml L5: `run_store` is "used only by the dispatcher and `brindle replay promote`".

**F. Readers of copies (fixtures), not of the run store**
- **`brindle replay run`**, before each release:
  - replay_suite.md L13: "The suite reads only the fixture files; it does not read the run store." A broken fixture is "fixed by hand or removed, and never copied again from the run store."
  - operations.md L19 (release gate); brindle.toml L7.
- **An engineer who fixes a fixture by hand:** replay_suite.md L13.
- **Agent sessions working on the Brindle repository:** overview.md L10: "Its container sees that record and the repositories it works on, with their committed files (in the Brindle repository, the replay fixtures)…"

**Stated non-readers**
- **The list is meant to be complete:** overview.md L11: "Run records are read only as these documents describe."
- **Agent sessions:** overview.md L10: "A session reads nothing from the run store; it only appends to its own record."
- **Invoices, the cost report and the usage database:** operations.md L11: "built from the usage database only, and usage data are never rebuilt from run records."
- **Periodic sessions' own data:** scheduler.md L24: they take it from the repositories, and `cost-report` from the usage database.
- **Backups:** operations.md L15: "nothing in either database is ever rebuilt from run records. The run store is not backed up."
- **Audit, legal, customer and security:** policy_notes.md L9: "No audit, legal or customer obligation requires keeping them, and no security process reads them."
- **`brindle periodic retry`:** scheduler.md L22: "needs nothing but the trigger key."
- **Filing a work item:** overview.md L5: "filing a work item needs none."
- **`queue-vacuum` and `cert-check`:** operations.md L27–28; neither touches the run store.
- **The 85% disk alert:** it reads how full the volume is, not records (policy_notes.md L11; brindle.toml L18).

## (2) Points the documents leave unclear

1. **A deleted record is never addressed, and it matters most.** The scheduler restarts work when "a header it cannot read, or a session that failed before writing one" counts as none, "as intended" (scheduler.md L20). A deleted record is literally neither case.
   - **No rule covers it.** No document states the retention this implies: up to a full quarter for `licence-scan` and `access-review`. The on-call 7-day window is "its only rule on run records" (operations.md L7), and the policy notes only require staying below 70% (policy_notes.md L11).
   - **Why it was never addressed:** no record has ever been deleted (run_records.md L21; storage_report.md L9).
   - **What a re-run would do:**
     - `dep-update` opens duplicate pull requests;
     - `cost-report` re-sends its email;
     - `access-review` re-sends the lists to team leads;
     - `licence-scan` opens duplicate issues;
     - `weekly-digest` posts again.
2. **Races with the 15-minute check.** Nothing says whether a deletion, or a header not yet written, could be caught mid-read and counted as "cannot read". Nothing says whether a retention job must be coordinated with the check.
3. **Where a retry's trigger key comes from.** A retry "needs nothing but the trigger key" (scheduler.md L22). For a failed periodic session, that key exists only in its header, because `sessions` has no `trigger` (run_records.md L17) and periodic sessions have no work item. So the retry implicitly depends on reading the record. The documents also do not say:
   - how or when on-call notices that a periodic period was skipped;
   - whether a retry made after the period has rolled over is intended to suppress the next period. Its header carries the new current period.
4. **The dispatcher's reading around end lines.** Nothing says:
   - how it detects "as soon as the end line is written", or that a session "stops without writing it" (run_records.md L15). Both imply reading the end of the record of sessions still running.
   - whether, on restart, it reads counts back from the record (as the general rule in operations.md L11 says) or copies them directly.
   - where the counts "reported to it while running" survive a dispatcher stop. Tool-call lines carry no token counts, and the `sessions` table holds none.
   - whether a session that wrote its own end line just before the dispatcher stopped is re-read on restart.
5. **How engineers reach the records.** brindle.toml L5 says `run_store` is used "only by the dispatcher and `brindle replay promote`". No viewing command or access route is given for reviewers or on-call, so how and where they read records is unstated.
6. **Whether fixtures count as run records.** Fixtures are copies of "the session's transcript (its run record)" (replay_suite.md L9). If they count, then engineers fixing fixtures by hand and agent sessions in the Brindle repository are readers. That would contradict "only as a reviewer or on call" (overview.md L5) and "reads nothing from the run store" (overview.md L10). Either way, fixtures do not depend on the run store being kept.
7. **The retention job (BR-212) is not described anywhere** (policy_notes.md L11), yet it will read the run store. Unstated:
   - whether it reads directory names only, or also headers, so as to spare current-period periodic records;
   - when it runs;
   - whether it reads `run_store` from brindle.toml, which would make that file's "used only by" comment wrong;
   - how its required dry-run, which "prints what it would delete" (operations.md L30; policy_notes.md L8), reads the store.
   - Once it exists, overview.md L11 ("read only as these documents describe") is incomplete.
8. **Storage-report reads.** Nothing says whether reading directory sizes and dates counts as "reading run records", or whether such reports will recur. The 2026-09-30 report was a one-off "for work item BR-212" (storage_report.md L5).
