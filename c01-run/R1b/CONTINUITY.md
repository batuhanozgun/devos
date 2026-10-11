C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# Continuity: R1b (2026-10-11T09:15:35Z)

Read before any queue work, on this branch: `c01-run/R1a/HANDOVER.md` and `c01-run/queue/QUEUE.md` (both at commit `67fcd98`, the head of `claude/probe-c01-r1a-20261011T0808Z` this branch starts from).

## Taken from the hand-over

1. Items done: Q1 (output 29, commit `e686797`) and Q2 (apple, cherry, fig, pear, quince; commit `78b33da`). They are not redone.
2. Next item: Q3; then Q4, the end of the queue.
3. The queue file's state agrees with the hand-over: Q1 and Q2 `done` with times and boot ID; Q3 and Q4 `open`.
4. Open question 1 (shallow starting checkout, denial #16 in R1a): this run met the same shallow checkout and, as CONTROL.md Version 2 rule 1.9 now says, completed the history before its first push; the first push passed the guard (stamp).
5. Open question 2 (session ID): CONTROL.md Version 2 rule 1.2 names the fallback; in this run the read by name was allowed, so the fallback was not needed.
6. Open question 3 (two statements about the model): met again; recorded the same way in this run's opening record.
7. The external effects R1a listed: all pushes to its own branch, outcomes known; nothing merged, no pull request, issue or comment. Nothing for this run to follow up.

## Found out elsewhere

1. The queue's input values (N1 for Q3, T1 for Q4) are not in the hand-over; they are in `c01-run/queue/QUEUE.md`, which the hand-over names. Nothing else was needed.
2. How to take an item (mark `taken`, do it, write `out/<item>.md`, mark `done` with time and boot ID, push) is not in the hand-over; it is CONTROL.md step R1a item 2, which R1b item 3 points to.
3. Whether R1a is closed, and from which commit to start, came from the remote branch list and R1a's `CLOSING.md` (`Result: done`), as CONTROL.md section 2 says, not from the hand-over.
