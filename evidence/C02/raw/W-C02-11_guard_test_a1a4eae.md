# W-C02-11 point 6: the guard's tests at the commit that went live (`a1a4eae`)

- **What:** `bash tools/test_tool_allowlist.sh`, run by the executor in a scratch clone of `devos` whose `main` was checked out at the merge commit M of PR #290 (EV-C02-006 section 6).
- **When:** started 2026-10-12 at about 18:20Z, after the live tree's sync at 18:18:40Z; the run ended with exit code 0.
- **M:** `a1a4eae8be81b8aaafef7b6d5a8a699f2be1dfce` (pushed: `origin/main`), the clone's `git rev-parse HEAD`.
- **The three blobs at M** (`git rev-parse M:<path>`):
  - `.claude/hooks/tool_allowlist.py`: `956f1b34ccf674138bf0d10b3fdd1bb77ccb8666`
  - `.claude/settings.json`: `c6907ccf460912e9403b3f192b834a3681377b24` (the live tree's, checked at A1 and again at 18:29:36Z after the next sync)
  - `tools/test_tool_allowlist.sh`: `694c393a03e234b2f51eb71ffa7b9b97c2d8212c`
- **Counts:** lines beginning `ok`: 821; `BAD`: 0; `info`: 1.
- **The `info` line, verbatim:** "info this checkout holds no skill under .claude/skills/: its repository-skill controls ran in the fixture above". It reports where controls ran; it does not say a control was skipped.
- **The last line, verbatim:** `ALLOWLIST_TEST PASS`.
- **Result:** pass, by EV-C02-006 section 6's rule (no `BAD` line, no skipped control, the last line `ALLOWLIST_TEST PASS`). It judges only the three properties (the guard denies a tool not on its list, never answers "ask", and denies when it fails or runs past its time limit).
- **Not filed:** the run's 823 lines of output, which name the guard's rules case by case; point 6 asks that the record carry no rule detail (D-017). They stay in the working session's scratchpad.
- **Validity:** the run counts only while these three blobs are the live tree's. Before the first session runs in one of DevOS's three environments (W-C02-12), the executor compares the live tree's three blobs with these.
