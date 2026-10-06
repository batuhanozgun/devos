<!-- W-C00-15 run r9be1: condition control (after unblinding); valid (audit); the runner's final message follows verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-017 -->

# BR-212: Retention job for the run store

## Summary

Each day, delete every run-store date directory older than the last 7 (today UTC and the six days before it). Nothing else is deleted. This rule meets the needs of every reader of run records listed in the materials. It keeps the store at about 9–12% of the volume, well under the 70% target. The job is a daily systemd timer on `disp-1` and has a `--dry-run` mode. Several guards stop it if anything looks unexpected.

**Deadline.** The store held 891 of 1,024 GiB on 2026-09-30 at 06:00 UTC and grows by about 15 GiB a day. At that rate the volume is full around 2026-10-08/09. The one-day dry run is required by policy (2026-04-14) and cannot be skipped, so the job has to be built and in dry run by 2026-10-07.

## 0. Who needs run records, and for how long

| Reader | What it uses | How long it needs the record |
|---|---|---|
| On-call (`operations.md`) | Whole records of sessions that ended `failed` or `killed` | **Today's date directory (UTC) and the six before it.** Nothing older has been needed in six months, and anything kept longer goes into incident notes |
| Reviewers / `brindle replay promote` | Records of sessions that ended up to 48 h ago | Up to 48 h after the end, so at most 54 h after the start (a session runs at most 6 h). That is about 3 date directories |
| Dispatcher, for billing | Token counts from the end line, read once as soon as it is written | Until the end line is written and read. The usage DB and `dispatcher.db` hold everything after that, and usage is never rebuilt from records |
| Dispatcher, after a restart | Writes end lines for sessions that stopped with it | Until it has written the end line |
| Replay suite | Fixture files in the Brindle repository only | Not needed. Golden sessions are copied at promotion, and a broken fixture is never copied again from the run store |
| Periodic triggers / `periodic retry` | The `periodic_runs` table / the trigger key | Not needed. Neither reads the run store |
| `cost-report` session | Usage database | Not needed |
| Audit, legal, security | (none) | Not needed (policy 2026-06-03) |

The run store is not backed up (`operations.md`), so **a deletion cannot be undone.**

## 1. What the job deletes and keeps

**Rule:** let `today` be the current UTC date and `oldest_kept = today − 6 days`. The job deletes each record in a directory `/srv/brindle/runs/<D>/` with `D < oldest_kept`, then removes the empty directory. It keeps everything in `oldest_kept … today`.

**Why this is enough:**
- It is exactly the on-call guide's window, counted the same way: by the start-date directory, not by file time. It is the longest need of any reader.
- It covers the reviewers' 48 h window (about 3 directories).
- Every record outside the window belongs to a session that ended at least about 5¾ days ago. Its end line is long written and its counts are long copied.
- Golden sessions, periodic sessions and all statuses follow the same rule. No reader needs them for longer.

**Space:** 7 days × 14–15 GiB is about 100–105 GiB. Just before the daily run the store holds about 8 directories (≈ 120 GiB, ≈ 12%). Just after, it holds about 90–105 GiB (≈ 9–10%). The first deleting run frees about 790 GiB. Even if the job failed every day, it would take about 40 days to go from ≈ 10% to 70%.

**Options I rejected:**
- *Deleting `done` records sooner than failed ones.* The job would have to parse every record's status to save space we don't need.
- *Keeping golden or periodic records longer.* No reader uses them.
- *Deleting by size, or until usage falls under X%.* That could remove on-call records from inside the window.
- *Using file mtime.* On-call counts by directory, and mtime is the session's end time.

## 2. When and how it runs

**Units** (on `disp-1`, like `queue-vacuum` and `cert-check`):

```
# run-retention.service
[Service]
Type=oneshot
User=brindle
ExecStart=/usr/local/bin/brindle-run-retention        # add --dry-run during the dry-run period
Nice=19
IOSchedulingClass=idle

# run-retention.timer
[Timer]
OnCalendar=*-*-* 00:15:00 UTC
Persistent=true
[Install]
WantedBy=timers.target
```

**Why daily at 00:15 UTC:** the window moves forward at UTC midnight, so one more directory becomes deletable then. A daily run deletes one directory (≈ 15 GiB, 1.5% of the volume). `Persistent=true` catches up after downtime. The job is idempotent, so running it twice changes nothing. The schedule is in UTC whatever the host's time zone. The job does not touch `dispatcher.db`, so it cannot collide with `queue-vacuum` at 02:30.

**Configuration:** it reads `[paths].run_store` from `/etc/brindle/brindle.toml` and a new section:

```toml
[retention]
keep_days = 7            # the job refuses any value below 7
target_used_percent = 70
max_dirs_per_run = 2     # backlog guard, see §3
```

**Command line:** `brindle-run-retention [--dry-run] [--allow-backlog]`

**Steps:**
1. Take an exclusive non-blocking `flock` on `/run/brindle/run-retention.lock`. If the lock is already held, log "already running" and exit 0.
2. Load the configuration. Abort if `keep_days < 7` or `run_store` is not a directory on its own mount point.
3. `today` = UTC date from the system clock. `oldest_kept = today − (keep_days − 1)`.
4. List the top level of `run_store` without following symlinks. Directories whose name matches `^\d{4}-\d{2}-\d{2}$` and is a valid date are date directories. Log anything else as a warning and keep it.
5. Run the guards in §3 (clock and backlog). If one fails, abort before deleting anything.
6. For each date directory with date < `oldest_kept`, oldest first, check each entry:
   - The name must match `^s-[0-9a-f]{8}\.jsonl$` and the entry must be a regular file (not a symlink) on the same device as `run_store`.
   - The last line must parse as JSON with `ended_at` and a `status` in `done`, `failed` or `killed`, and `ended_at` must be at least 48 h ago. Read only the tail of the file, since records can reach 2 GiB.
   - If an entry passes, unlink it (in dry run, print `WOULD DELETE <path> <bytes> <status>`). If it fails, log `KEEP <path> <reason>` and leave it.
   - After the files, `rmdir` the directory only if it is empty. Never delete a directory tree recursively.
7. Write a summary to the journal: directories and files deleted, bytes freed, files kept with a reason, and used % of the volume afterwards (`statvfs`).
8. Exit non-zero and warn on-call through the same channel `cert-check` uses if any of these happened:
   - the run aborted;
   - any file was kept with a warning;
   - used % is still ≥ `target_used_percent`.

   The job never deletes inside the window to reach the target; that case goes to a person.

## 3. How it avoids deleting the wrong thing

- **Window floor:** `keep_days` below 7 is refused. Today's directory is computed in UTC, and file times are ignored.
- **Clock guard:** about 400 sessions start each day, so the newest date directory must be `today` or `today − 1`. If not, the job aborts. A clock that jumps forward would otherwise delete everything. A clock that runs backward only makes the job delete less.
- **Backlog guard:** in steady state one directory goes per run. If more than `max_dirs_per_run` would go, the job aborts unless `--allow-backlog` is given. That flag is used only for the first deleting run, after the dry-run output has been reviewed.
- **Ended sessions only:** a record without a valid end line, or with `ended_at` less than 48 h ago, is kept and reported. This covers a dispatcher that has not yet written end lines after long downtime, and so also billing.
- **Strict scope:** only `/srv/brindle/runs/<date>/s-<8 hex>.jsonl` files are touched. The job does not follow symlinks or cross devices. It never touches the Brindle repository, the replay fixtures, `dispatcher.db` or the usage DB.
- **Crash-safe order:** deletion goes oldest first, one file at a time. An interrupted run leaves only fully expired directories partly deleted, and the next run finishes them.
- **Single instance, low priority:** the `flock` and idle I/O scheduling keep it from slowing running sessions.
- **Audit trail:** every deleted path and its size goes to the journal.
- **Backstop:** the existing 85% disk alert stays in place.

## 4. Testing before it is enabled

**A. Automated tests** on a synthetic run store in a temp directory (records with header and end lines):
1. Run at `2026-10-10T00:05Z`: it keeps `2026-10-04`…`2026-10-10` and deletes `2026-10-03` and older. Repeat at `23:55Z` and with `TZ=America/Los_Angeles`; the result must be the same.
2. A record with no end line, an unparsable last line, or `ended_at` under 48 h ago in an old directory is kept and warned about, and the exit code is non-zero.
3. Stray files, badly named directories, symlinks to files outside the store, and a nested directory are all left untouched.
4. `keep_days = 6` is refused.
5. Clock guard: the newest directory is 3 days old → abort, nothing deleted.
6. Backlog guard: 5 expired directories without `--allow-backlog` → abort. With the flag → all 5 deleted.
7. `--dry-run` changes nothing (a hash of the tree is the same before and after) and prints exactly the set a real run then deletes.
8. A second run deletes nothing. A run started while another holds the lock exits 0.
9. Interrupting a run halfway, then running again, leaves the expected end state.
10. Failed, killed, periodic and promoted records outside the window are deleted, and the same kinds inside the window are kept.

**B. Dry run on `disp-1`** (policy: at least one day). Install the timer with `ExecStart=... --dry-run --allow-backlog` and let it run at least once. A second platform engineer reviews the output and checks:
- the oldest `WOULD DELETE` directory is older than `today − 6`, and no path from the last 7 directories appears;
- the bytes to delete are about 790 GiB, and the remaining size is about 100 GiB;
- there are no `KEEP` warnings, or each one is explained.

**C. Enabling:**
1. An engineer starts the first real run by hand with `--allow-backlog` and watches the journal.
2. Afterwards, check that used % is about 10%, that a `failed` record from `today − 6` still opens, that `brindle replay run` passes, and that `brindle replay promote` works on a session that ended within the last 48 h.
3. Switch the timer to `ExecStart=/usr/local/bin/brindle-run-retention` with no flags.
4. On the next mornings, check that each run deleted one directory and that the disk alert stays quiet.
