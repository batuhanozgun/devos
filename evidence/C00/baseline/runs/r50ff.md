<!-- W-C00-15 run r50ff: condition gap (after unblinding); valid (audit); the runner's final message follows verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-017 -->

# BR-212: retention job for the run store (`runs-retention`)

**Urgent: check how full the volume is first.** The storage report shows 891 GiB (87%) on 2026-09-30, growing 14 to 15 GiB a day. At that rate the volume is about 96% full by 2026-10-06 and completely full around 2026-10-09. An 85% alert that has fired for a week matches those numbers. Run `df /srv/brindle/runs` before anything else. Policy requires one full day of dry-run (decision of 2026-04-14), so the rollout in section 4 takes two days. Start it right away.

## 1. What the job deletes and what it keeps

### Who reads run records, and for how long

| Reader | What it reads | How long it needs records |
|---|---|---|
| Reviewers and `brindle replay promote` | The whole record | Until 48 h after the session ends, which is at most start + 6 h + 48 h. `promote` refuses anything older. |
| On-call | Records of failed and killed sessions | The UTC date directories for today and the 6 days before |
| Dispatcher (billing) | The end line | Once, as soon as the end line is written |
| Dispatcher (trigger check) | The header of **every** record, every 15 minutes | While the record's `period` is still its trigger's current period, which can be up to a quarter |
| Replay runs, agent sessions, invoices, cost report, backups, legal, security | Nothing in the run store | Not applicable |

This means golden sessions need no protection. Their fixtures live in the repository and are never copied from the run store again. Billing needs nothing once the end line has been read. The run store has **no backup**, so every deletion is final. Keeping more than these needs require gains nothing, and a smaller store also makes the dispatcher's header scan faster.

### The main risk: periodic records

The dispatcher decides that a trigger's period is done **only** by finding a header in the run store with that `trigger` and the current `period`. Suppose a plain 7-day retention deletes the `access-review` record for `2026-Q4` (started 2026-10-01). Within 15 minutes the dispatcher starts a second access review. The same would happen with `licence-scan` (duplicate issues), `dep-update` (duplicate pull requests) and `cost-report` (a second email). It would repeat every retention cycle until the period ends.

Two facts make this safe to handle:
- A periodic session always starts inside its own period, both on a normal start and with `retry`.
- The longest period is a quarter, which is at most 92 days.

So a periodic record more than 92 days old can never be a current-period record.

### Rules

"Today" is the current UTC date. D is the date in the record's directory name. The job checks each entry against these rules in order, and **the first rule that matches decides**:

1. **Not a run record.** Anything other than a regular file named `<YYYY-MM-DD>/s-<hex>.jsonl` directly under the run store: **keep, and report it**. This covers symlinks, other names, nested directories, and directory names that are not valid dates or are dated after today.
2. **Recent.** D ≥ today − 7: **keep**. That is 8 directories: the 7 that on-call needs plus one day of margin. It also covers reviewers and promotion, who need at most D + 3 days.
3. **Not finished.** The last line is not valid JSON with `ended_at` and a `status` of `done`, `failed` or `killed`: **keep, and report it**. Its token counts may not have been billed yet.
4. **Modified recently.** mtime within the last 48 h: **keep, and report it**. A finished record never changes.
5. **Periodic or unknown kind.** Line 1 has `kind` = `periodic`, or line 1 is not valid JSON with `kind` set to `work` or `periodic`:
   - If D ≥ today − 100: **keep**.
   - If older, and `kind` is `periodic` with a `trigger` that is not one of the six keys in `scheduler.md` or a `period` that does not parse: **keep, and report it**.
   - Otherwise: **delete**.

   An unknown kind is treated like a periodic record because the dispatcher might be able to read a header that the job cannot.
6. **Everything else.** Finished `work` records with D ≤ today − 8: **delete**.

**Expected effect.** The first run deletes everything from 2026-03-02 up to 8 days ago, about 770 GiB. After that, the store peaks at about 8 days × 15 GiB ≈ 120 GiB (about 12%), plus roughly 40 periodic records. A burst of 2 GiB records still leaves plenty of room under 70%.

## 2. When and how it runs

- **Form.** A `runs-retention` command with `runs-retention.service` and `runs-retention.timer` on `disp-1`. It runs as user `brindle` and logs to the systemd journal, like `queue-vacuum` and `cert-check`.
- **Schedule.**
  - `OnCalendar=*-*-* 01:15:00 UTC`, `Persistent=true`, and `After=` the dispatcher's unit.
  - Daily is enough, because one day of records is about 1.5% of the volume.
  - 01:15 stays clear of `queue-vacuum` (02:30), `cert-check` (07:00) and every trigger's due time.
  - Run it under `nice` and `ionice -c3` so live sessions keep disk priority.
- **Options.**
  - `--dry-run`
  - `--allow-large` (see guard 5)
  - `--now <ISO time>`, which overrides the clock and is for tests only
- **Settings, defined at the top of the job.**
  - `keep_days = 8`; the job refuses to run with less than 8.
  - `periodic_keep_days = 100`; the job refuses to run with less than 93.
  - `warn_percent = 50`
  - `limit_percent = 70`
- **Steps.**
  1. Read `[paths].run_store` from `/etc/brindle/brindle.toml`. Refuse to run unless that path is a mount point.
  2. Run the pre-flight guards (section 3). Abort if any of them fails.
  3. Walk the date directories without following symlinks. For each file:
     - call `lstat`;
     - read line 1, and read the last line by seeking backwards from the end (records reach 2 GiB, so never read a whole file);
     - apply the rules;
     - remember the file's inode, size and mtime.
  4. Check the plan (guards 4 and 5). In `--dry-run` mode, print the plan and stop.
  5. Delete, oldest directory first. For each file:
     - call `lstat` again;
     - skip the file and report it if its inode, size or mtime has changed;
     - otherwise `unlink` it.

     Afterwards, `rmdir` each date directory that is now empty. Never delete recursively.
  6. Log a summary:
     - records and GiB deleted;
     - records kept, counted by rule;
     - anomalies;
     - volume use before and after.

     Exit non-zero on any error.
- **Dry-run output.** It writes nothing and prints:
  - one line for each record it would delete: path, size, kind, D and the rule that matched;
  - every anomaly it would keep;
  - every periodic record it would keep, with its trigger and period;
  - the summary, including projected volume use after deletion.
- **Documentation.**
  - Update the comment on `run_store` in `brindle.toml`; it currently says only the dispatcher and `promote` use that path.
  - Add the job to the maintenance-jobs table in `operations.md`.

## 3. How it avoids deleting the wrong thing

1. **It only deletes.** It opens records read-only and never truncates or rewrites one. A damaged header counts as "no header" to the dispatcher, which would start a duplicate periodic session. The job does not open `dispatcher.db`.
2. **UTC dates.** It computes dates in UTC explicitly, whatever the host's time zone.
3. **Clock check.** It aborts if any directory is dated after today, or if neither today's nor yesterday's directory exists. Either means the clock is ahead or the dispatcher is not running. The one-day margin in rule 2 absorbs a clock error of one day.
4. **Periodic check.** For each of the six triggers, the job works out the current period in UTC:
   - the ISO week, using the ISO year (`2026-W41`);
   - the month (`2026-10`);
   - the quarter (`2026-Q4`).

   If the plan contains any record whose trigger and period match a current period, it aborts without deleting anything. After deleting, it scans the headers again and alerts on-call if a current-period header that was there before is gone.
5. **Size cap.** It aborts if the plan covers more than 3,000 records or 60 GiB, about four days of records; a normal run deletes one day. `--allow-large` lifts the cap. Only a person passes it, after reading the dry-run output: for the first run, or after an outage. The timer never passes it.
6. **Narrow scope.** It deletes only whole regular files that match the file-name pattern, and checks each one again just before deleting it.
7. **Alerts.**
   - A non-zero exit triggers `OnFailure=`, which notifies on-call by the same route `cert-check` uses.
   - After a run, it warns if the volume is at 50% or more and alerts if it is at 70% or more.
   - The job never deletes a record its rules keep just to get under 70%. That decision belongs to the platform team.

## 4. Testing before it is enabled

1. **Unit tests** of the rule function, with "now" set by the test. Cover these cases:
   - D = today − 7 (kept) and D = today − 8 (deleted);
   - a session that crossed midnight;
   - periodic records at 100 and 101 days;
   - an unknown kind, an unreadable line 1, a missing end line, and an unknown trigger;
   - a symlink, a stray file, and a directory dated in the future;
   - the ISO-year boundary: 2027-01-01 belongs to `2026-W53`.
2. **Integration test** on a made-up run store covering 150 days with every kind of case. Build it in a temporary directory that is **not** on the run-store volume, which is nearly full. Check that:
   - a dry-run changes nothing (compare a listing of paths, sizes and mtimes before and after);
   - the dry-run prints exactly the expected set;
   - the real run deletes exactly that set and removes only empty directories;
   - a second run deletes nothing;
   - with `--now` one year ahead, the job aborts;
   - with a current-period record placed in a 101-day-old directory, the periodic check aborts.
3. **Concurrency test.** While the integration run deletes, run a loop that reads every header the way the trigger check does. It must find every kept header on every pass.
4. **Dry-run on production** on `disp-1` for at least one day, as policy requires. Install the timer in dry-run mode and also run it by hand straight away. When reviewing the output:
   - no record from the 8 newest directories may appear in the delete list;
   - the kept periodic records must include the current periods (`2026-W41`, `2026-10` and `2026-Q4` on 2026-10-06);
   - projected use must be under 70%;
   - explain every anomaly.
5. **First real run** by hand, with `--allow-large`, during working hours and with on-call told in advance. Then switch the timer to real mode.
6. **Checks afterwards.**
   - For 24 hours, confirm that no periodic session starts for a trigger and period that were already done before the run.
   - Confirm that on-call can open a failed record from 6 days ago.
   - Confirm that the 85% alert has cleared.
   - After a week, confirm that each daily run deletes about one date directory.
