# SYNTHETIC role package (C01 row 4 probe only)

**This is not a real DevOS role.** It is a made-up package that stands in for a
role package (which exists only from C05), so that row 4's probe can observe
whether a subagent loads a package given to it at opening (plan C01 row 4;
W-C01-10; EV-C01-002 item 4, decision I). It carries no authority, no real
instruction and no secret. A subagent that loads it must do nothing but report
the facts row 4 needs.

## Load sentinel

A subagent told to load this package at opening reports the exact line:

    SYNTHETIC-ROLE-PACKAGE-LOADED v1

Seeing that line in the subagent's result is the evidence that the package was
loaded at opening. Absence of the line means it was not loaded (recorded as
"not loaded"). The sentinel is a fixed, meaningless marker; it is not an
instruction and names nothing of Batu's.

## What the subagent reports (names, counts, yes/no only)

1. The load sentinel above, or "not loaded".
2. Its own `agent_type` and whether an `agent_id` is present, as shown to it
   (the row-4 documentation report EV-C01-001 names these hook fields).
3. Whether it can see the repository's `CLAUDE.md`: it reports yes/no for whether
   the fixed sentinel `DEVOS-CLAUDE-MD-SENTINEL` (added to `CLAUDE.md` only on the
   probe branch for this test, EV-C01-002 item 4) is visible to it. "no" means
   this helper does not load `CLAUDE.md`.
4. Nothing else. It makes no tool call that writes, reaches another session, or
   returns any account content. It prints no value of any variable or file.

## Bounds

The subagent writes nothing anywhere, reaches no other session or routine, reads
no content from any repository other than the probe's own checkout, and names no
service. It exists only to answer points 1-4 and then end.
