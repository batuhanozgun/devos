<!-- W-C00-15 run rd0d5: condition control (after unblinding); valid (audit); the runner's final message follows verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-017 -->

# BR-212: Retention job for the run store (design)

**Summary.** Run the job once a day at 01:15 UTC. It deletes every run-store date directory older than the seven newest days (today in UTC and the six days before) and touches nothing else. After the first run the store holds about 105 GiB, roughly 10% of the volume and far below 70%. Every reader of run records still has what it needs.

**This is urgent.** The store held 891 GiB on 2026-09-30 and grows by about 15 GiB a day, so the volume fills up around **2026-10-08/09**. Run `df -h /srv/brindle/runs` before you start. The policy of 2026-04-14 still applies: the job must run in dry-run mode for at least one day. Plan the build so the dry-run day and the first real run both happen before the volume is full.

## 1. What the job deletes and keeps

**The rule.** Let T be the current date in UTC. Keep the date directories `T-6` through `T`. Delete every record in a directory dated `T-7` or earlier, then delete the empty directory. The rule is the same for every record, whatever its kind (`work`/`periodic`), its status, or whether it was promoted.

Example: a run on 2026-10-06 keeps `2026-09-30` through `2026-10-06` and deletes `2026-09-29` and everything older.

**Why seven directories cover every reader:**

| Reader | What it needs | Covered because |
|---|---|---|
| On-call | Records of failed or killed sessions in today's directory and the six before it. Nothing older has been needed in six months, and anything needed longer goes into the incident notes. | This rule sets the window. |
| Reviewers and `brindle replay promote` | The record until 48 h after the session ends; `promote` refuses after that. | A session lasts at most 6 h, so the latest need is the start day + about 2.3 days (start 23:59, end 05:59 the next day, plus 48 h). |
| Dispatcher (billing) | Reads the end line once, as soon as it is written. After a restart it writes end lines for crashed sessions. | Only running or just-ended sessions, all dated today or yesterday. The end-line check in section 3 adds a further guard. |
| Running sessions | Append to their own record for up to 6 h. | Dated today or yesterday. |

**What the job does not need to keep.** Do not build exceptions for these:
- **Golden sessions.** `promote` copies them into the Brindle repository. The replay suite reads only the fixtures, and a broken fixture is never copied from the store again.
- **Periodic sessions**, including the quarterly ones. The dispatcher records whether a period's work is done in the `periodic_runs` table in `dispatcher.db`, not in run records. `brindle periodic retry` needs only the trigger key.
- **Billing and the cost report.** Both are built only from the usage database, which has backups and a standby and is never rebuilt from run records. Token counts that have not yet been copied wait in `dispatcher.db`, not in the record.
- **Audit or legal needs.** There are none (counsel, 2026-06-03).

So the job needs no keep-list, no hold flag and no header parsing. A shorter window for `done` records would save little and add a rule, so the design does not have one.

**Capacity.** Seven days at about 15 GiB a day is about 105 GiB. Just before the daily run it peaks at about 110 GiB, which is 10–11% of 1,024 GiB. To reach 70% (717 GiB), the week would have to average over 100 GiB a day, about seven times today's rate, so there is plenty of room for bursts of 2 GiB records. The first run deletes nearly all of the 891 GiB counted on 2026-09-30. `keep_days` can be raised later but never below 7.

## 2. When and how it runs

**Form.** Add a subcommand to the `brindle` command: `brindle runs prune [--dry-run] [--catch-up]`. It reads `run_store` from `/etc/brindle/brindle.toml`. Add this section to that file:

```toml
[retention]
keep_days = 7          # date directories kept, today included; values below 7 are refused
target_percent = 70    # alert if usage is at or above this after a run
max_dirs_per_run = 3   # deleting more directories than this needs --catch-up
```

Update the comment on `run_store` to say it is used by the dispatcher, `brindle replay promote` and `brindle runs prune`.

**Schedule.** Add a systemd timer `run-retention.timer` on `disp-1`. Like `queue-vacuum` and `cert-check`, it runs as the user `brindle` and logs to the journal.
- `OnCalendar=*-*-* 01:15:00 UTC` and `Persistent=true`, so a run missed while the host was down happens at boot.
- The service is `Type=oneshot` with `Nice=10`. A oneshot service started by a timer never overlaps with itself.
- Why 01:15 UTC: it is an hour after midnight UTC, so a clock that runs slightly fast cannot delete `T-6` while on-call still needs it. It is also clear of `queue-vacuum` (02:30) and `cert-check` (07:00).

**Steps on each run:**
1. **Pre-checks.** If any of these fails, abort without deleting anything: the clock is synchronized, the configuration is valid (`keep_days ≥ 7`), and the store path is a directory.
2. **Window.** Compute T as today's date in UTC, never local time. The oldest kept directory is `T − (keep_days − 1)`.
3. **Candidates.** List the entries directly under the store. A candidate is a directory whose name matches `^\d{4}-\d{2}-\d{2}$`, parses as a real date and is older than the oldest kept directory. Leave every other entry alone and report it.
4. **Cap.** If there are more candidates than `max_dirs_per_run` and `--catch-up` was not given, abort and alert.
5. **Delete, oldest directory first.** In each candidate directory, delete an entry only if all of these hold:
   - it is a regular file, not a symlink;
   - its name matches `^s-[0-9a-f]+\.jsonl$`;
   - its `st_dev` equals the store's (it is on the same filesystem);
   - its last line parses as JSON with `ended_at` and a `status` of `done`, `failed` or `killed`.

   Delete with `unlink`: no `rm -rf`, no globs, no following links. Keep and report anything else. Then `rmdir` the directory; this fails harmlessly if something was kept.
6. **Measure usage** with `statvfs`, computed as `df` does: used / (used + available). Write one journal line with directories and files deleted, bytes freed, files kept and why, and usage before and after.
7. **Alert on-call**, through the same channel `cert-check` uses, if a pre-check failed, a file was kept as an anomaly, an error occurred, or usage after the run is at or above 70%. The job never deletes inside the window to get below 70%. That decision belongs to the platform team.

**`--dry-run`** runs steps 1–6 without `unlink` or `rmdir`. It prints:
- each path it would delete, with its size and end-line status;
- totals per directory and per month;
- the projected usage after deletion;
- any candidate directory that `brindle` cannot write to (`unlink` needs write permission on the directory).

## 3. How it avoids deleting the wrong thing

- **The window is a floor in code.** Directories dated `T-6` or later are never deleted, whatever the configuration says.
- **UTC everywhere.** Directory names are session start dates in UTC, so T is computed in UTC and the host's time zone plays no part.
- **Clock guard.** The job aborts unless `timedatectl show -p NTPSynchronized` returns `yes`, because a clock that jumped forward would move the window. The cap also catches a jump: a normal run deletes one directory, or two or three after missed days.
- **Only ended records.** A record without a valid end line belongs to a session that is still running, or one whose end line the dispatcher has not written yet (so billing has not read it). Such a file is kept and reported, never deleted.
- **Strict names, no links, one filesystem.** The store holds nothing but records, so any unexpected entry is reported, not deleted.
- **No access to `dispatcher.db`.** The job needs nothing from it. Never opening it means the job cannot lock or damage the dispatcher's state.
- **Safe to interrupt.** It works oldest first, one file at a time. A crash leaves the store consistent, and the next run carries on.
- **Catch-up is manual.** `--catch-up` is used only for the first run and after an outage of more than two days. An engineer runs it after reviewing a dry run.

## 4. Testing before it is enabled

1. **Unit tests**, with the clock and usage injected:
   - T at 00:00:00 and 23:59:59 UTC; the boundaries 2026-10-01, 2027-01-01 and 2028-03-01 (after a leap day); the same results with `TZ` set to UTC−10 and UTC+14.
   - `keep_days = 6` is refused; more candidates than the cap without `--catch-up` aborts with nothing deleted; an unsynchronized clock aborts.
2. **Integration test** on a fake store in a temporary directory:
   - Contents: date directories from T-10 to T+1; records with `done`, `failed` and `killed` end lines, with no end line, with a truncated last line, and an empty file; entries named `notes.txt`, `2026-02-30` and `lost+found`; a symlink to a file outside the store; a symlinked date directory.
   - Assert that exactly the expected files go, that directories from T-6 onward are unchanged byte for byte, and that anomalies are reported.
   - Assert that the `--dry-run` list equals what the real run deletes, and that a second run deletes nothing.
3. **Dry run on `disp-1`.** As `brindle`, run `brindle runs prune --dry-run --catch-up` and check:
   - no path dated T-6 or later appears;
   - the monthly totals match the storage report (Mar 4, Apr 9, May 21, Jun 46, Jul 98, Aug 293, Sep 420 GiB, minus the September days still inside the window);
   - every candidate has a valid end line, and any anomaly is investigated before going further;
   - there are no permission errors, and projected usage is below 70%.

   Then enable the timer with `--dry-run` in `ExecStart` for at least one day (policy of 2026-04-14). Check that its output names exactly one directory with the right date.
4. **Enable.** As `brindle`, run `brindle runs prune --catch-up` once by hand while watching the journal and `df`. Then remove `--dry-run` from the timer's `ExecStart`.
5. **Check after the first runs:**
   - `df` shows about 10% and the disk alert stops;
   - on-call can open a failed record dated T-6;
   - `brindle replay promote` works on a session that ended within the last 48 h, and `brindle replay run` passes;
   - the next scheduled run deletes exactly one directory.
