> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Run records

Every agent session writes one **run record**: the session's transcript, as JSON Lines. Some documents call it the transcript.

## Where

`/srv/brindle/runs/<YYYY-MM-DD>/<session-id>.jsonl`, where the date is the day the session started (UTC) and a session ID looks like `s-7f3a9c21`. The run store holds nothing else.

## Format

- **Line 1, the session header:** `session_id`, `kind` (`work` or `periodic`), `work_item` (empty for periodic sessions), `trigger` and `period` (set for periodic sessions, empty otherwise), `model`, `started_at`.
- **Lines 2 to n-1:** one line per tool call: the tool, its input and its output (an output longer than 1 MiB is cut at 1 MiB).
- **Line n, the end line:** `ended_at`, `status` (`done`, `failed` or `killed`) and the token counts. For a session stopped at the 6-hour limit, the dispatcher writes the end line.

The session header is not stored anywhere else: the dispatcher's `sessions` table keeps only the session ID, the work item, the status and the start and end times.

## Life cycle

The session creates its record when it starts and appends to it while it runs. After the end line, nothing changes the record. No record has ever been deleted (`storage_report.md`).

## Sizes

Median 9 MiB, mean 34 MiB. The largest records, from sessions that read big test logs, reach about 2 GiB.
