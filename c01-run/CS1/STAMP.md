C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# CS1 stamp

- Session ID: `cse_01GKoxmCJjcMDZYMAkjcvomh` (read from `CLAUDE_CODE_REMOTE_SESSION_ID` with rule 1.2's command; not denied).
- S: 2026-10-12T06:04:44Z
- Step: CS1 (C01's combined scenario, first run; W-C01-47 item 1).
- Attempt: first (no earlier `claude/probe-c01-cs1-*` branch was fetched).
- Fire reason as the session sees it: a scheduled task; the first message is marked "SCHEDULED TASK - AUTOMATED FIRING OF A CONFIGURED PROMPT", started by a schedule.
- Text arrived with the start: no (nothing besides the stored prompt and the scheduler's wrapper around it).
- `main` commit read: `14ec14cdba06f1d4625a05e156387547d085b70a` (`git rev-parse HEAD` in the starting checkout, whose checked-out branch is the session's own work branch at the same commit as `origin/main`).
- Control file version line: `Version 11 (W-C01-47 item 1, L-254 and L-255, 2026-10-11; ...)`.
- Rule 1.9: the starting checkout was shallow (`true`); `git fetch --unshallow origin main` was run there as a call of its own (exit 0; it also moved the checkout's `origin/main` tracking ref from `5d0cc58` to `14ec14c`; no commit, branch, `HEAD` or working-tree change).
- Branch: `claude/probe-c01-cs1-20261012T0604Z`, from `origin/main` at `14ec14c`.
- Step choice (rule 2.3): R1a, R1b, P1, P2, P3 and P4 each closed by a fetched branch (rule 2.2 count 1); R4V Open `no`; CS1 open, not closed, no prerequisites.
- Boot ID at 2026-10-12T06:05:18Z: `352eb2d1-e9b0-4b57-ab1a-da42252e0ec8`.
