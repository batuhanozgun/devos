> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Replay suite

The replay suite checks that changes to Brindle's agent prompts and tools do not break behaviour that already worked. It replays the tool outputs recorded in **golden sessions**, past sessions that a reviewer marked as good references, and compares the agent's new choices with the recorded ones.

## Golden sessions

When a reviewer marks a session as a good reference, they run `brindle replay promote <session-id>`. This copies the session's transcript (its run record) from the run store into the Brindle repository and commits it there as `tests/replay/fixtures/<session-id>.jsonl`. Reviewers are the engineers who review a session's pull request; they read its run record and promote it while reviewing, within two days of the session's end, and `promote` refuses a session that ended more than two days ago. There are 61 fixtures (2026-09-30).

## Running

`brindle replay run` replays every fixture. The suite reads only the fixture files; it does not read the run store. A fixture that fails to load fails the suite; it is then fixed by hand or removed, and never copied again from the run store.

A Brindle release needs the suite to pass.
