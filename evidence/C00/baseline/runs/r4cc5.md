<!-- W-C00-15 run r4cc5: condition control (after unblinding); valid (audit); the runner's final message follows verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-017 -->

# BR-212 · Retention job for the run store: design

**The rule.** Every day at 01:15 UTC, the job deletes the run records in date directories older than today (UTC) minus 6 days. It keeps today's directory and the six before it. Nothing in Brindle reads a record after that.

**This is urgent.** On 2026-09-30 at 06:00 the store held 891 GiB, and it grows by 14–15 GiB a day. At that rate the 1,024 GiB volume is full around **2026-10-09**. Policy requires at least one day of dry run before the job is enabled, so the dry run has to start straight away (section 4).

## 1. What the job deletes and keeps

### Who reads a run record, and for how long

| Reader | What it needs | For how long | Source |
|---|---|---|---|
| Dispatcher (usage copy) | The end line's token counts. It reads them once, as soon as the end line is written. After a restart it first writes any missing end lines. | Minutes after the session ends | operations.md |
| Reviewer, `brindle replay promote` | The whole record. `promote` finds it by its start-date directory and refuses a session that ended more than 48 h ago. | Up to 48 h after the end. A session runs at most 6 h, so at most the start day + 3 | replay_suite.md |
| On-call engineer | Failed or killed records, header included | Today's directory (UTC) and the six before it | operations.md |
| Replay suite | Only the fixtures committed in the Brindle repository. A broken fixture is never copied again from the run store. | Never reads the run store | replay_suite.md |
| Periodic triggers, `periodic retry` | The `periodic_runs` table in `dispatcher.db`. A retry needs only the trigger key. | Never reads the run store | scheduler.md |
| Invoices, cost report | The usage database only. It is backed up and never rebuilt from records. | Never | operations.md |
| Audit, legal, security | Nothing (checked with counsel, 2026-06-03) | Never | policy_notes.md |

The longest need is on-call's 7 date directories, and that window also covers the 48-hour review window.

### The rule in detail

- **Delete:** each `/srv/brindle/runs/<D>/<session-id>.jsonl` where D ≤ today − 7 (UTC) and the last line is a valid end line. Then remove directory D once it is empty.
- **Keep:**
  - every directory with D ≥ today − 6, whatever is in it;
  - any record without a valid end line, however old it is (its session may not have finished, or its counts may not have been copied);
  - anything that is not a run record.

The date comes from the directory name, never from the file's modification time or `ended_at`. That is how on-call counts its window and how `promote` finds a record. A session that ran across midnight therefore goes with the day it started.

### Options considered and rejected

- **Keeping golden sessions or periodic records longer.** Golden sessions are already copied into the repository as fixtures, and periodic triggers use `periodic_runs`. Neither reads the run store.
- **A shorter window for `done` records.** Only reviewers need them, for at most 3 days. This would save about 60 GiB, but deletion would then depend on reading each record's status, and 70% is reached without it.
- **Compressing or moving records.** This changes the path that `promote` and on-call use, and there is no other storage (no paid storage this year).
- **Deleting oldest records until the store is below 70%.** Reaching 70% never justifies deleting inside the 7-day window. If usage is still too high, the job alerts instead.

### Capacity

- **Steady state:** after each run the store holds 7–8 days of records, about 100–120 GiB, or 10–12% of the volume. Reaching 70% (717 GiB) would take about 90 GiB a day, six times the planned rate.
- **First real run:** it deletes everything from 2026-03-02 to today − 7. That is up to about 215 directories and roughly 900 GiB.

## 2. When and how it runs

**Units on `disp-1`**, set up like the other maintenance jobs:

- `brindle-run-retention.service`: `Type=oneshot`, `User=brindle`, `Nice=10`, `IOSchedulingClass=idle`, logs to the journal.
- `brindle-run-retention.timer`: `OnCalendar=*-*-* 01:15:00 UTC`, `Persistent=false`. If a run is missed, the next run catches up; the cap in step 5 allows two directories for this.

At 01:15 UTC the UTC date has just changed, so the directory that has just aged out can be deleted. The time also stays clear of `queue-vacuum` at 02:30, although the job never touches `dispatcher.db`.

**Flags**

- `--dry-run`
- `--max-dirs N` (default 2)
- `--keep-days N`: keep today and the N−1 days before it. Default 7; the job refuses any value below 7.

**Steps of one run**

1. Take an exclusive `flock` on `/run/brindle/run-retention.lock`. If the lock is already held, exit. Write nothing inside the run store: no lock file, no log, no marker. The store holds only run records.
2. Read `[paths].run_store` from `/etc/brindle/brindle.toml`. Abort unless it equals `/srv/brindle/runs`, is a real directory and is a mount point.
3. Set `today` to the current date **in UTC** (never local time) and `cutoff = today − (keep_days − 1)`.
4. List the top level of the store. A **candidate** is a real directory (not a symlink) whose name is a valid `YYYY-MM-DD` date earlier than `cutoff`, and which is **not** one of the 7 newest date directories present. Leave anything else at the top level alone and report it.
5. If more than `--max-dirs` candidates contain at least one deletable record, delete nothing, report, and exit with code 2.
6. Go through the candidates, oldest first. For each entry in a candidate, delete it only if all of these hold:
   - it is a regular file (checked with `lstat`, so symlinks are excluded);
   - its name matches `s-<hex>.jsonl`;
   - its last line parses as JSON with `ended_at` and with `status` set to `done`, `failed` or `killed`. Read that line by seeking from the end of the file, because records reach 2 GiB.

   Delete with `unlinkat` relative to the directory's file descriptor, and never go into subdirectories. Keep everything else and report its path and the reason. Remove the directory if it is then empty.
7. Measure the volume with `statvfs`. Log one summary line: directories and records deleted, GiB freed, skipped items with reasons, and the used percentage.
8. Exit 0 if everything was clean. Exit non-zero if a guard aborted the run, anything was skipped, or the volume is still at or above 70%. A failed unit should warn on-call the same way `cert-check` does. On-call resolves skipped items by hand: for a missing end line, check why the dispatcher did not write it; move any foreign files out of the store.

**`--dry-run`** runs the same steps, guards included, but prints instead of deleting:

- a line for each record (path and size) and each directory it would remove;
- the total size and the predicted used percentage;
- any listed file that `brindle` could not delete (no write access to its directory).

## 3. How it avoids deleting the wrong thing

- **Window floor.** `--keep-days` is never below 7, and the job never deletes the 7 newest date directories present. That second guard matters if the clock jumps forward, which would otherwise make every directory look old.
- **Cap.** More than 2 directories to delete in one run points to a clock problem or a bug, so the job stops. The first backlog run, and any catch-up after a long outage, pass `--max-dirs` by hand after a dry run.
- **Only run records.** Names and file types are checked strictly. The job follows no symlinks, does not recurse and stays on one filesystem.
- **Only finished sessions.** An end line is required. Running sessions (at most 6 h) are in today's or yesterday's directory anyway.
- **Only the right path.** The path comes from the configuration and is checked as the mount point. The job never touches the Brindle repository or `dispatcher.db`.
- **Oldest first.** An interrupted run leaves the newest records in place, and rerunning it finishes the work.
- **Deletion is final.** The run store has no backup, which is why the dry run is mandatory and the first real run is supervised.

## 4. Testing before it is enabled

### Automated tests

Use a temporary fake store, with the clock and `statvfs` injected.

1. With today = 2026-10-08 and directories 2026-09-20 to 2026-10-08, the job deletes up to 2026-10-01 and keeps 2026-10-02 to 2026-10-08.
2. Repeat at 23:59 and 00:01 UTC with `TZ=America/Los_Angeles` and with `TZ=Pacific/Kiritimati`. The result depends only on the UTC date.
3. A record in 2026-10-01 with `ended_at` on 2026-10-02 is kept on 2026-10-07 and deleted on 2026-10-08.
4. An old record with no end line, a truncated last line or a non-JSON last line is kept and reported, and the exit code is non-zero. The next day, its directory does not count toward the cap.
5. Foreign entries are left untouched and reported: `notes.txt`, a subdirectory, a symlink to a file outside the store, a symlinked date directory, `2026-02-30`, `latest`.
6. With the clock set to 2027-10-08, the 7 newest directories survive and the cap stops the run.
7. With three candidate directories, nothing is deleted and the exit code is 2. With `--max-dirs 3`, all three are deleted.
8. After a dry run the tree is unchanged (names, sizes, modification times). Its list matches exactly what a real run on the same tree then deletes.
9. If the configuration is missing, the path is different or the path is not a mount point, the job aborts and deletes nothing.
10. With two runs at the same time, the second exits without deleting anything.
11. If usage is at or above 70% after the run, the exit code is non-zero.
12. A run killed partway through, then rerun, finishes the work, and no newer record is ever deleted before an older one.
13. On a 2 GiB sparse record, the end line is found quickly by seeking.
14. `--keep-days 6` is refused.

### Dry run on `disp-1` (policy: at least one day)

1. Install the units with the timer running `--dry-run --max-dirs 250`, and run it once by hand.
2. Check the output:
   - the oldest directory kept is today − 6;
   - every listed path is under `/srv/brindle/runs/<date>/`;
   - the total it would free matches the storage report (March to September, plus early October);
   - the skipped list is empty or every item is explained;
   - there are no permission errors.
3. Leave the timer running for at least one day. Confirm that the 01:15 run's list moved forward by exactly one directory.

### Enabling

1. Run the job once by hand with `--max-dirs 250` to clear the backlog, with someone watching. Compare the journal summary with the last dry run; `df` should then show about 10–12%.
2. Switch the timer to real mode with the default flags.
3. The next day, check that the run deleted exactly one directory and exited 0.
4. Confirm the readers still work:
   - on-call can open a record in the today − 6 directory;
   - a reviewer can promote a session that ended within the last 48 h;
   - `brindle replay run` passes.
