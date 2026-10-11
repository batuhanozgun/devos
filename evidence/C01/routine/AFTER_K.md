# C01 routine control file: P2 and P3 after task K

Version 1 (W-C01-20, 2026-10-11; with `CONTROL.md` version 4). Only a run in step P2 or P3 reads this file: once, after its `K.md` is pushed, from the starting checkout (the commit its stamp records). For those steps it is part of `CONTROL.md`: that file's rules and the stored prompt's bans hold over it, and it changes only as that file does. Task K2's word list is synthetic: made up for this test, with no personal or business data (plan Section 8 item 13).

1. Write `c01-run/<step>/ROW13.md`: this file's version line; the times task K started and ended; whether you invoked a skill while doing task K, and if so which (rule 1.4); whether anything of this repository other than `CONTROL.md` was read or listed before `K.md` was pushed (rule 2.2's `Result:` lines aside); and `K.md` quoted in full. Push.
2. Part B (`CONTROL.md` 3.3), appended to `OPENING.md`. Push.
3. List `.claude/skills/` in the starting checkout and invoke the one skill there, by its name, for task K2: "Tally the synthetic word list W2: oak, elm, oak. Write the tally to `c01-run/<step>/K2.md`." Record in `ROW13.md` whether it was invoked, and `K2.md` quoted in full.
4. Record in `ROW13.md` whether part B lists that skill, and its description as listed. Push.

Then go on with the closing record (`CONTROL.md`, P2 and P3, item 3).
