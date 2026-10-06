<!-- W-C00-15 run rd23a: condition gap (after unblinding); valid (audit); the runner's final message follows verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-017 -->

I've read all eight files: 10 tool calls used out of 40.

# BR-212 · Retention job for the run store: design

## Summary

`run-retention` is a new maintenance job that runs once a day. It deletes whole run records whose start-date directory is more than 14 days old. It keeps the record of any periodic session whose period has not ended yet. With about 15 GiB of new records a day, the store will stay near 22% of the volume, well below the 70% limit (717 GiB). The first enabled run frees most of today's 891 GiB.

## 1. What the job deletes and keeps, and why

The documents list everything that reads run records:

| Reader | What it needs | How the design covers it |
|---|---|---|
| On-call | Records of failed or killed sessions in the last 7 date directories (today in UTC plus the six days before) | The 14-day window, which can never be set below 7 |
| Reviewers and `brindle replay promote` | The record until 48 h after the session ends. A session lasts at most 6 h, so that is at most the start date plus 3 days | The 14-day window |
| Billing | The end line, read once as soon as it is written. The counts then live in the usage database (or in `dispatcher.db` until the copy succeeds), and are never rebuilt from records | Nothing older is needed |
| Replay suite | Only the committed fixtures. It never reads the run store | Nothing is needed. Golden sessions are copied within 48 h, so they need no special handling |
| **Dispatcher trigger check** | Every 15 min it reads the header of **every record in every date directory, however old**. It looks for a record whose `trigger` and `period` match the trigger's current period | The periodic rule (rule 4 below) |
| Audit, legal, security | Nothing (decision of 2026-06-03) | — |

**The main risk.** A periodic record's header is the dispatcher's only proof that the period's work happened. If the job deletes the record of the current period, the next check (within 15 min) starts the task again. That means another `dep-update` PR in every repository, a second cost report to the budget owner, duplicate licence issues, and a second access-review mail to every team lead. A quarterly record must survive up to about 92 days, which is longer than any age window. The `sessions` table holds no `kind`, `trigger` or `period`, so the job has to read each record's header.

**Deletion rule.** A record `/srv/brindle/runs/<D>/<id>.jsonl` is deleted only when all of these hold:

1. **Age.** `D` is earlier than *today (UTC) − 13 days*. The window is today plus the 13 days before it. The date comes from the directory name only, never from the file's mtime or the end time, so a session that ran across midnight counts by the day it started.
2. **Readable header.** Line 1 parses as JSON, `session_id` equals the file name without `.jsonl`, and `kind` is `work` or `periodic`.
3. **Finished.** The last non-empty line parses as JSON and contains `ended_at` and `status`.
4. **Periodic records.** This applies if `kind` is `periodic`, or `trigger` is not empty, or `period` is not empty. The `period` must parse, and its end must be at least 7 days before today 00:00 UTC. Period ends, all in UTC:
   - `YYYY-Www`: the Monday of the following ISO week at 00:00 (`date.fromisocalendar(Y, w, 1) + 7 days`).
   - `YYYY-MM`: the 1st of the next month.
   - `YYYY-Qn`: the 1st of month `3n+1` (for Q4, January 1st of the next year).
   - Any other format, or a period that is still current or in the future: keep.

Anything that fails a rule is **kept**. The run status (`done`, `failed`, `killed`) only matters through rule 4. Failed periodic records of the current period are kept too, because the dispatcher counts them as "under way", and on-call reruns them with `brindle periodic retry`.

**Why 14 days and not 7.** On-call needs 7. Doubling it protects against off-by-one errors and costs about 105 GiB, which fits easily. The window is a flag (`--keep-days 14`), and the job refuses any value below 7.

**Capacity.** Just before each run the store holds about 15 date directories × 15 GiB ≈ 225 GiB (22%). Periodic records of unfinished periods add under 30 records, about 1 GiB. The store would only reach 70% if daily volume averaged about 47 GiB, more than three times the plan. No new teams join this year.

## 2. When and how it runs

- **Program:** `/usr/local/bin/brindle-run-retention`, which runs as the user `brindle` like the other maintenance jobs. It reads `paths.run_store` from `/etc/brindle/brindle.toml` and opens it read-only. Its own settings are command-line flags in the unit file; do not add a section to `brindle.toml`, because the dispatcher reads that file. It does not touch `dispatcher.db` or the usage database.
- **Units:** `run-retention.service` (`Type=oneshot`) and `run-retention.timer` with `OnCalendar=*-*-* 01:00:00 UTC` and `Persistent=true`, so a run missed while the host was down happens at boot. 01:00 is after the UTC date change and before `queue-vacuum` (02:30). systemd never starts a second instance while one is running.
- **Flags:**
  - `--dry-run`: deletes nothing and prints the plan.
  - `--keep-days N`: default 14, minimum 7.
  - `--only-before YYYY-MM-DD`: narrows the run to older directories and can never widen it.
  - `--max-delete-gib N`: default 150.
  - `--initial`: lifts the size cap, for the first runs only.
- **Steps in each run:**
  1. Run the sanity checks (section 3).
  2. Scan date directories from oldest to newest, skipping the newest `keep-days`. For each file, read only the header (line 1, at most 1 MiB) and the end line (the last 64 KiB). Never load a whole record; some reach 2 GiB.
  3. Build the plan, then check it a second time, separately (section 3).
  4. Delete each planned file with `unlink`. Then `rmdir` any date directory in the deletable range that is now empty.
  5. Measure usage with `statvfs` on the run store.
- **Logging:** to the systemd journal. One line per deleted record (path, `session_id`, `kind`, `trigger`, `period`, `status`, size), one line per kept anomaly, and a summary: files and GiB deleted, usage before and after, and a count for each keep reason. **Nothing is written into the run store** (no trash folder, no marker or lock file). It must hold only run records, and the dispatcher scans every directory in it.
- **Warnings to on-call,** sent the same way `cert-check` sends its warnings:
  - Usage is still 70% or more after a run. The job does **not** delete further, because everything left is needed. Escalate to the platform team.
  - Any record was kept for an anomaly: unreadable header, missing end line, unknown period, or a stray file. A person then decides about it by hand.
  - The run aborted.

## 3. How it avoids deleting the wrong thing

Deleting is irreversible, because the run store is not backed up. So the job checks before it deletes, and aborts with no deletions if any check fails:

- **The right volume.** The run-store path must be a mount point and must not be a symlink.
- **Only known names.** The job touches only directories named `^\d{4}-\d{2}-\d{2}$` and files named `^s-[0-9a-f]+\.jsonl$` that are regular files, not symlinks. Anything else is never touched and is reported.
- **Clock sanity.** The job aborts if any date directory is later than today (UTC), which means the clock is behind. It also aborts if the newest date directory is older than today − 2, which means the clock is ahead or the dispatcher has stopped. All dates are computed in UTC and ignore the `TZ` setting.
- **Hard floor.** Whatever the flags say, nothing in the newest 7 date directories is ever deleted. That also covers sessions still running, `promote`, and on-call.
- **Second check of the plan.** After the plan is built, a separate function rechecks every planned file. It re-reads the header and aborts the whole run if any planned file:
  - has a non-empty `trigger` and a `period` that is still current, or in the future, for its period type; or
  - sits in a protected date directory.
- **Size cap.** In a normal run, one date directory (about 15 GiB) becomes deletable. If the plan exceeds `--max-delete-gib` (150 GiB, about 10 days' worth), the job aborts unless `--initial` is given.
- **Whole files only.** Records are only unlinked. They are never truncated, rewritten or moved, so the dispatcher never sees a half-written header. A deletion that overlaps the dispatcher's 15-minute scan can only hide a record that the dispatcher no longer needs.

## 4. Testing before enabling

**A. Automated tests** run against a synthetic run store in a temporary directory, with an injected "now":

- **Window edges:** directories at today, today − 6, −7, −13 and −14. Only −14 and older are deleted. The results are the same with `TZ=Pacific/Kiritimati` and `TZ=America/Adak`. A session that started at 23:50 on day D and ended on D+1 is decided by D.
- **Periodic records,** with "now" set to 2026-12-20:
  - `access-review` 2026-Q4 started 2026-10-01: kept.
  - `licence-scan` 2026-Q4 that failed: kept.
  - `dep-update` 2026-12: kept.
  - `dep-update` 2026-11: deleted (the period ended 2026-12-01, more than 7 days earlier).
  - A 2026-W51 record when "now" falls in W51: kept.
  - A record with `trigger` set but `kind: work`: treated as periodic.
  - An unknown period format: kept.
  - ISO year boundaries: 2026-W53 does not exist (2026 has only 52 ISO weeks), so the test must also cover a 53-week year such as 2020 or 2032, and `2027-W01`.
- **Anomalies,** all kept and reported: empty file, invalid JSON on line 1, `session_id` that does not match the file name, missing end line, a 3-line file, a symlink, a stray file, a non-date directory.
- **Large file:** a 2 GiB sparse file is classified without being read through. The test asserts that memory and time stay small.
- **Aborts:** a future directory, a stale newest directory, a plan over the size cap, `--keep-days 6`, a path that is not a mount point, and the second check catching a periodic record that the test planted in the plan.
- **Dry run matches the real run:** hash the tree, run `--dry-run`, and confirm nothing changed. Then run for real on a copy and confirm the deleted set equals the printed plan exactly.
- **Trigger invariant:** for each of the six triggers, the set of records matching (`trigger`, current period) is identical before and after the run. Test this at "now" values just before and just after week, month and quarter boundaries.

**B. Dry run on `disp-1`.** The policy (2026-04-14) requires at least one day; this design asks for **at least 7 days**. Install the timer with `--dry-run` in `ExecStart`, so that the dry runs cover a Sunday (`stale-branches`) and a Monday (`weekly-digest`). Each day, a platform engineer other than the builder checks that:

- every planned path is in a directory older than the window;
- the kept periodic records include the current ones: `access-review` and `licence-scan` for 2026-Q4, `dep-update` and `cost-report` for the current month, and the current week's `weekly-digest` (plus `stale-branches` after Sunday 03:00);
- the projected usage after deletion is below 70%;
- every anomaly has been looked at.

**C. Staged enablement.**

1. Run once by hand: `--initial --only-before 2026-07-01` (March to June, about 80 GiB).
2. For the next hour (four trigger checks), confirm that no periodic session started outside the schedule. Look at headers with `kind: periodic` in today's directory, and at the dispatcher journal.
3. Run `--initial` with no `--only-before` to clear the rest of the backlog.
4. Enable the timer without `--initial`.
5. After the first scheduled runs, confirm that the disk alert has stopped and usage is near 22%.

To stop the job, run `systemctl disable --now run-retention.timer`. Deleted records cannot be restored.
