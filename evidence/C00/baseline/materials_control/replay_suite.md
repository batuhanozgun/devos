> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Replay suite

The replay suite checks that changes to Brindle's agent prompts and tools do not break what already worked: it replays the tool outputs recorded in **golden sessions**, past sessions marked as good references, and compares the agent's new choices with the recorded ones.

## Golden sessions

When a reviewer marks a session as a good reference, they run `brindle replay promote <session-id>`. This copies the session's transcript (its run record) from the run store into the Brindle repository and commits it there as `tests/replay/fixtures/<session-id>.jsonl`. Reviewers are the engineers who review a session's pull request; every reviewer reads its run record, and may promote it, while reviewing, within 48 hours of the session's end; a review that happens later uses the pull request alone. `promote` takes the session's start date (its record's directory) and end time from the `sessions` table, and refuses a session that ended more than 48 hours ago. There are 61 fixtures (2026-09-30).

## Running

`brindle replay run` replays every fixture. The suite reads only the fixture files; it does not read the run store. A fixture that fails to load fails the suite; it is then fixed by hand or removed, and never copied again from the run store.
