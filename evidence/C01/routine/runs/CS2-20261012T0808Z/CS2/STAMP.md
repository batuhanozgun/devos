C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# CS2 stamp

- Session ID: cse_01UtoNQkUgoAwmHg3KD2D3m5 (read by name under rule 1.2; not denied)
- S: 2026-10-12T08:08:36Z
- Step: CS2 (C01's combined scenario, second run; W-C01-47 item 1)
- Attempt: first (no earlier `claude/probe-c01-cs2-*` branch in the fetch at S)
- Branch: `claude/probe-c01-cs2-20261012T0808Z`, made from the head of `origin/claude/probe-c01-cs1-20261012T0604Z` (CS1's latest closed branch), commit `c2240846ccea2cc9587cc3547ee388c05fd771f3`
- Fire reason as the session sees it: scheduled (the turn opens with the scheduler's header saying it was started automatically by a schedule)
- Text arrived with the start: no (only the stored prompt, inside the scheduler's header and the platform's own context blocks)
- `main` commit read (`git rev-parse HEAD` in the starting checkout): `56d1ac7207343124dd4c2244bbad9ee573ea745e` (the starting checkout is on a platform-named branch whose head equals `origin/main`)
- Control file version line: Version 11 (W-C01-47 item 1, L-254 and L-255, 2026-10-11)
- Rule 1.9: the starting checkout was shallow (`true`); `git fetch --unshallow origin main` was run there as a call of its own; it now reports `false`.
- First commit: batuhanozgun-devos <335658439+batuhanozgun-devos@users.noreply.github.com> / batuhanozgun-devos <335658439+batuhanozgun-devos@users.noreply.github.com>; signature headers: 0 (commit `c4559f1`)
