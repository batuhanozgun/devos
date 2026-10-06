<!-- W-C00-15 run rbdf8: condition gap (after unblinding); valid (audit); the runner's final message follows verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-017 -->

# BR-212: Retention job design for the Brindle run store

## Basis: who reads run records

These are the only readers the materials describe:

| Reader | What it needs from the run store | Source |
|---|---|---|
| On-call | Records of `failed` and `killed` sessions in **today's date directory (UTC) and the six before it** | operations.md |
| Reviewers, `brindle replay promote` | Any record until 48 h after the session ends. A session ends at most 6 h after it starts, so this is at most 54 h after the start. | replay_suite.md |
| Billing | The end line, read **once** as soon as it is written. If the usage database cannot be reached, the dispatcher retries from `dispatcher.db`, not from the record. | operations.md |
| Periodic trigger check (every 15 min) | The header of **every record in every date directory, however old**, looking for `trigger` = key and `period` = current period. If no such record is found, the trigger starts a new session. | scheduler.md |
| Replay suite | Nothing. Fixtures are copies committed to the repository and are never copied from the run store again. | replay_suite.md |

Nothing else depends on the records. There is no legal, audit or security requirement to keep them (decision of 2026-06-03), and the run store has no backup, so **every deletion is final**.

**Urgency.** On 2026-09-30 the volume had 133 GiB free. At 14 to 15 GiB a day it fills around **2026-10-08/09**. Check current usage before planning the rollout dates.

## 1. What the job deletes and what it keeps

**Window.** The job never touches a date directory `D` where `D ≥ today_UTC − 6 days`. That keeps today plus six days, as the on-call rule requires. The same window also covers promote (≤ 54 h), billing (end lines are written within hours) and every running session (≤ 6 h, so always in today's or yesterday's directory).

**Deleted.** Only files outside the window that fall into one of these two classes:

- **Expired work record.** The header parses, `kind` = `work`, `trigger` and `period` are both empty, and the last line is a valid end line (it has `ended_at` and `status`).
- **Expired periodic record.** The header parses, `trigger` is not empty, `period` has a known format, the period ended at least 7 days ago, and the last line is a valid end line.

The job classifies a record by `trigger` and `period`, not by `kind`, because the dispatcher matches on those two fields. Any header with a non-empty `trigger` or `period` goes through the periodic rule. These fields exist only in the header (`sessions` has none of them), so the job must read line 1 of each file.

Period end (exclusive, UTC):

- `YYYY-Www` (ISO week): the Monday of the following week at 00:00. Note that 2026 has a **W53** (2026-12-28 to 2027-01-03).
- `YYYY-MM`: the 1st of the next month.
- `YYYY-Qn`: the first day of the next quarter.

**Kept:**

- **Everything in the window.**
- **Periodic records whose period is current or ended less than 7 days ago, whatever their status.** The dispatcher counts even a failed record as "done or under way". A plain age rule would delete the 2026-Q4 `access-review` record from 2026-10-01 on 10-08. Within 15 minutes the dispatcher would start a new access review, and then again about every week: roughly 13 confirmation requests per team lead each quarter. The same would happen with duplicate dependency PRs and cost-report emails (about 4 a month) and duplicate licence issues. The 7-day grace also absorbs any time-zone difference in how the dispatcher works out the current period. Example: the Q4 records stay until 2027-01-08. Periodic sessions are about a dozen a month, so keeping them costs less than 1 GiB.
- **Anything the job cannot classify**, which it keeps and reports:
  - a header that is missing or does not parse;
  - an unknown `kind`;
  - an unknown period format;
  - no valid end line (this may mean the session was never billed);
  - a file name that does not match `^s-[0-9a-f]+\.jsonl$`;
  - a directory name that is not a valid `YYYY-MM-DD`;
  - symlinks and subdirectories.

**Choices made:**

- **Promoted sessions get no special treatment.** Their fixtures live in the repository.
- **One window for everything.** Records that ended `done` could go after 3 days, but one 7-day window is simpler and only costs about 60 GiB.
- **Deletion is by age, not size.** Size is only checked. A rule like "delete the oldest until below 70%" could eat into the window during a burst.

**Space.** The window holds about 8 directories × 15 GiB ≈ 120 GiB, around 12% of the volume. The limit is 70% of 1,024 GiB = 716.8 GiB, which leaves about 590 GiB for bursts (single records reach about 2 GiB). Reaching 70% inside the window would take about 90 GiB a day. If that ever happens, the job **does not shorten the window**. It alerts, and the platform team decides.

## 2. When and how it runs

- **Command:** `brindle-retention [--dry-run] [--allow-backlog]`, on `disp-1`, as user `brindle`, logging to the journal.
- **Configuration:** add a section to `/etc/brindle/brindle.toml`, and update the `run_store` comment to add this job as a user of the run store.
  ```toml
  [retention]
  keep_days = 7            # code refuses values below 7
  periodic_grace_days = 7
  max_delete_gib = 60      # about 4 days of growth
  warn_percent = 60
  target_percent = 70
  ```
- **systemd:**
  - `brindle-retention.service`: `Type=oneshot`, `User=brindle`.
  - `brindle-retention.timer`: `OnCalendar=*-*-* 01:15:00 UTC`, `Persistent=true`, so a missed run happens at boot.
  - Why 01:15 UTC: it is after midnight UTC, when a new directory leaves the window, and before `queue-vacuum` at 02:30. No trigger is due between 00:00 and 03:00.
- **Steps in each run:**
  1. **Lock.** Take `flock` on a lock file (for example `/srv/brindle/retention.lock`). If it is already held, exit.
  2. **Sanity checks.** Abort with a non-zero exit if `/srv/brindle/runs` is not a mount point, if any date directory is later than today (UTC), or if the newest date directory is not today or yesterday. About 400 sessions a day means this would point to a wrong clock or a stopped dispatcher.
  3. **Scan.** Look at directories older than the window, oldest first. For each file, read only line 1 (at most 64 KiB) and the last line (seek from the end), opened read-only. Use the dispatcher's own header parser if it can be imported, so that "readable" means the same thing to both.
  4. **Build the plan and run the guards** (section 3).
  5. **`--dry-run`:** print the plan and the summary, then exit 0.
  6. **Delete each file.** Re-read line 1 and the last line, re-classify, then `unlink`. Remove a date directory with `rmdir` only when it is empty and outside the window, never recursively.
  7. **Summary.** Log the number of files and GiB deleted, the kept counts by reason, the list of unclassified files, and usage before and after.
- **Normal run:** one directory, about 400 files and 15 GiB.

## 3. How it avoids deleting the wrong thing

1. **Allow-list.** It deletes only the two expired classes. Anything unclear is kept and reported.
2. **Hard window floor.** `keep_days < 7` is rejected in code, and dates are always computed in UTC, never in local time.
3. **Independent check of current periods.** A separate, simple piece of code works out the current ISO week, month and quarter for the six known triggers. It aborts the whole run if any planned file has `trigger` = key and `period` = that key's current period.
4. **Clock and mount checks** (step 2 above).
5. **Size cap.** If the plan exceeds `max_delete_gib`, the job aborts unless `--allow-backlog` is given. This catches a jumped clock or a classification bug.
6. **Re-check before each unlink.**
7. **Unlink only.** The job never truncates, rewrites, compresses, renames or moves a record. The dispatcher would read a compressed or partly written header as "none" and restart the trigger.
8. **Path confinement.** Only `/srv/brindle/runs/<YYYY-MM-DD>/s-*.jsonl` regular files; symlinks are not followed.
9. **Audit trail.** One journal line per deletion: path, `session_id`, `kind`, `trigger`/`period`, `status`, size. Never record content, because there is no backup.
10. **Alerts,** through the same channel `cert-check` uses to warn on-call:
    - any abort or non-zero exit;
    - new unclassified files;
    - usage at or above 60% after a run (warning) or at or above 70% (alert).

## 4. Testing before it is enabled

1. **Unit tests** with fixture files:
   - work records ending `done`, `failed` and `killed`;
   - periodic records for each period format, both current and expired, including one with `kind` = `work` and `trigger` set;
   - a header-less record (end line only), an empty file, malformed JSON, and a file with no end line;
   - symlinks, file and directory names that do not match, and a future-dated directory;
   - period ends at 2026-W53, year end, month end and quarter end;
   - window edges at 00:05 and 23:55 UTC.
2. **Integration test** on a synthetic run store in a temporary directory, with the clock frozen at:
   - 2026-10-08 01:15 (the Q4 `access-review` record from 10-01 and the `licence-scan` record from 10-05 must stay);
   - 2027-01-01 01:15 (still kept);
   - 2027-01-09 01:15 (now deleted).

   After each run, check three things:
   - **Trigger equivalence:** for all six triggers, the dispatcher's "is the period's work done?" check (its own code, or the documented rule) gives the same answer before and after the run.
   - **Window untouched:** every file in the window is byte-identical (checksums before and after).
   - **Aborts:** the independent check of current periods and the size cap both stop the run when bugs are injected.
3. **Skeleton run.** Build a copy of the real store on `disp-1`'s scratch space outside the run store, containing only the real paths, line 1 and the last line (a few hundred MB). Run the job there for real, not in dry-run. Confirm that what it deletes matches the dry-run plan on the real store exactly.
4. **Dry run on the real store,** with the timer running `--dry-run` for **at least one scheduled day**, as policy 2026-04-14 requires. Given the urgency, one day is enough. A second platform engineer reviews the output and confirms:
   - no path inside the window is listed;
   - kept: the 2026-Q4 `access-review` and `licence-scan`, the 2026-10 `dep-update` and `cost-report`, and the current week's `weekly-digest` and `stale-branches`;
   - every unclassified file is explained;
   - projected usage is below 70%.
5. **Go-live.**
   - Run the backlog once by hand with `--allow-backlog`, and watch it. It deletes about 770 GiB.
   - Then check:
     - `df` shows usage below 70%;
     - no unexpected periodic session started in the next hour (look for new `kind` = `periodic` headers in today's directory);
     - on-call can open a `failed` record from six days ago.
   - Only then switch the timer to real mode.
   - The rollback is to disable the timer. Deleted records cannot be recovered.
