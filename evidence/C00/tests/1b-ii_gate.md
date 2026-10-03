# Gate 1b-ii: test output (W-C00-12 tranche 1b-ii)

**Written:** 2026-10-03T22:19Z by run `session_01Gfj3M4MjrMb4YcRHwsA1X8`, replacing its own run on `bea1a32` (readable in git at `dff691e`), which replaced the run recorded at 20:49Z by run `session_01CmCKBkyHynQ27CwqkiviC6` (at `242d195`). **What:** the unedited output of `python3 tools/test_check_records.py`, run from the repository root on the commit named in its first line. That commit is this file's parent, and it already carries this header, because the log names this file and claims (a) would otherwise fail on its own evidence path. **Preconditions** (R-W12-4 C-3, R-W12-5 m-4): a clone with full history **and** a `refs/remotes/origin/claude/review-<ID>` ref for every verdict under `evidence/*/reviews/`, fetched after each reviewer's last push (`git fetch origin 'refs/heads/claude/review-*:refs/remotes/origin/claude/review-*'`). The script checks that the refs exist and fails the gate with `PRECONDITION FAIL` when one is missing; it does not check that they are current, and a stale ref fails later inside T-M15 or `claims`. The procedures are `plan/builder/w-c00-12/11_test_register.md` section 2, made concrete in `plan/builder/w-c00-12/15_tranche_1b-ii_intent.md` section 3. This run is on the head after R-W12-5's findings (intent section 10), including T-W9 (x) and (y), T-M15 (b3) and T-M4 (d). **These results count only under the session Verifier's verdict** (W-R1; R-W12-2 C1 c), since the scripts are new in this PR. Lines starting `MUTANT` come from the two mutation checks, where the checker is disabled in a scratch copy; the PASS of `M1` and `M2` means the tests then reported FAIL.

**Not exercised by this gate** (R-W12-4 m-4): of the stop reasons of C-R1, only S1, `S3 ISSUE_READ_FAILED` and S4 run here (T-M6r (e), T-R20). S2, plain S3 (lease released) and S5 have no test until T-C5 in gate 1d (`plan/builder/w-c00-12/12_tranche_plan.md` section 2.2). Read this gate as "the record checks are tested", not "the stop reasons are tested".

```text
HEAD 2b7da5623dc957510685458d514fb2d23755d588 (clean)
run at 2026-10-03T22:19:32Z
PRECONDITIONS OK (full history; a review ref for every verdict)
PASS  T-R20 (a) the second failure of one class on a pushed head prints HAND-OVER DUE naming stamps
PASS  T-R20 (a) S1 then fails
PASS  T-R20 (a) S4 is accepted once the failures are fixed (acknowledged by a later exception line)
PASS  T-R20 (b) two failures of one class on an uncommitted tree print no signal
PASS  T-M1 (a) b74ab11 fails naming the operating model
PASS  T-M1 (b) the migrated tree passes
PASS  T-M1 (c) a fact marker differing from its home fails naming the marker
PASS  T-M2 unmodified tree passes
PASS  T-M2 a hand-edited generated line fails
PASS  T-M2 a state change without a re-render fails
PASS  T-M3 (a) a modified decision record without a Record changes line fails
PASS  T-M3 (b) a modified log entry fails
PASS  T-M3 (c) a correction without a reason fails
PASS  T-M3 (d) the decision change with a correct block passes; the log modification still fails
PASS  T-M3 (e) a correction line with patch:M-R14 is accepted
PASS  T-M3 (e) the stop check passes and prints a patch count of 1 for M-R14
PASS  T-M4 a decision file not in its index fails
PASS  T-M4 a home removed from the map fails
PASS  T-M4 a missing file named in CLAUDE.md fails
PASS  T-M4 (d) a duplicate log entry ID fails (R-W12-5 m-3)
PASS  T-M5r (a) a hand-edited DURUM.md fact line fails
PASS  T-M5r (b) a waiting-for-Batu change without a re-render fails
PASS  T-M5r (c) the template's first content line is 'Senden beklenen' and it states the check-in residual
PASS  T-M6r (a) an unrecorded comment by batuhanozgun fails naming its ID
PASS  T-M6r (b) an unreachable URL fails with ISSUE_READ_FAILED
PASS  T-M6r (c) all comments by batuhanozgun recorded passes
PASS  T-M6r (d) the cursor moved past an unrecorded comment fails naming it
PASS  T-M6r (e) S3 ISSUE_READ_FAILED without the MCP line fails
PASS  T-M6r (e) S3 ISSUE_READ_FAILED with the MCP line passes
PASS  T-M6r (e) S1 with the MCP line still fails
PASS  T-M7a (a) lease expiry 3h20m ahead: fails
PASS  T-M7a (b) lease expiry in the past: fails
PASS  T-M7a (c) lease expiry 3h ahead: passes
PASS  T-M7a (d) a prose log line with a future time and no sched: mark: fails
PASS  T-M7a (e) the same line marked sched:: passes
PASS  T-M7a (f) an S5 wake at resets plus 15 minutes: passes
PASS  T-M7a (f) an S5 wake at resets plus 2 hours: fails
PASS  T-M7a (f) a Watchdog wake 3 days ahead: fails
PASS  T-M7b (a) As-of 10 minutes after the commit: fails
PASS  T-M7b (b) As-of 20 minutes before the commit: fails
PASS  T-M7b (c) As-of 5 minutes before the commit: passes
PASS  T-M7b (d) Usage As-of is the write time, quoting a 40-minute-old observation with its source: passes
PASS  T-M7b (e) an added plan/ file whose Written: line says 18:31Z against an 18:25:01Z commit: fails
PASS  T-M7c (a) the real check over L-016 to L-041 at d69d7c6 fails exactly on the prototype's 19 rows
PASS  T-M7c (b) a dateless quoted time 5 minutes after the commit: fails
PASS  T-M7c (c) committed at 00:10Z quoting '23:50Z' without its date: fails
PASS  T-M7c (c) the same with its date: passes
PASS  T-M11 a note written into a non-existent item path fails the chain check
PASS  T-M11 a note on a planned later-stage item appears under that item in the zoom view
PASS  T-M14 (a) claims at 05ba7c9 fails naming R-C00-BOM-3.md
PASS  T-M14 (a) claims at ef4bd4d fails naming R-C00-BOM-4.md
PASS  T-M14 (a) together they name R-C00-BOM-3.md and -4.md
PASS  T-M14 (b) a library path containing evidence/ is not reported
PASS  T-M15 (a) one byte changed from the branch blob: fails
PASS  T-M15 (b) committed on the review branch by the producer's session: fails
PASS  T-M15 (b2) committed on the review branch by a session that is not owned (critic of 1b-ii #2): fails
PASS  T-M15 (b3) the reviewer session made owned only by a line the same change appends: fails
PASS  T-M15 (c) a redacted copy whose differing line is a pattern substitution: passes
PASS  T-M15 (d) a redacted copy that also changes a non-pattern word: fails
PASS  T-M15 (e) R-W12-1's committed copy passes
PASS  T-W1 accepted_by names the producer session: fails
PASS  T-W1 accepted_by empty: fails
PASS  T-W1 a retired test cited: fails
PASS  T-W1 a hand-written 'deterministic' file naming no command: fails
PASS  T-W1 a command whose re-run differs: fails
PASS  T-W1 (g) the command's script changed in a normal-class PR after the item became running: fails
PASS  T-W1 (h) the same, after a later PR with a bound verdict that did not touch the script: fails
PASS  T-W1 an existing verdict of another item reused (critic of 1b-ii #1): fails
PASS  T-W1 a bound verdict: passes
PASS  T-R11 an accepted item without an independence label fails
PASS  T-W3r precondition: the fixture item is ready
PASS  T-W3r (a) superseding an assumed decision marks the item stale and drops it from the frontier
PASS  T-W3r (b) a correction line for another assumed decision marks it stale
PASS  T-W3r (c) accepting the stale item fails
PASS  T-W3r (d) a recheck note clears it
PASS  T-W4 a parent accepted without a composition record fails
PASS  T-W4 with a composition record it passes
PASS  T-W4 a child's verdict reused as the composition record fails
PASS  T-W9 (a) 'Status: binding' written into a Governing-documents row: class high
PASS  T-W9 (b) one word changed inside an existing acceptance block: class high
PASS  T-W9 (c) a lease renewal: class normal
PASS  T-W9 (d) (a) merged without a session verdict: the stop check fails
PASS  T-W9 (e) a new item with its first acceptance block: class normal
PASS  T-W9 (f) one line of plan/Ek_A_Rol_Sozlesmeleri.md: class high
PASS  T-W9 (g) one line of tools/records.py: class high
PASS  T-W9 (h) the exact revert of a merge that changed only tools/check_records.py: class normal
PASS  T-W9 (h2) after the break-glass revert and its line, with no verdict, the stop check fails
PASS  T-W9 (h3) an unrelated verdict naming the reverted merge does not cover the break-glass revert
PASS  T-W9 (h4) restoring the content before M1 after a later merge M2 is not break-glass: class high
PASS  T-W9 (i) the exact revert of a merge that changed an acceptance block: class high
PASS  T-W9 (i) the exact revert of a merge that changed a Governing-documents row: class high
PASS  T-W9 (j) deleting an existing depends_on entry: class high
PASS  T-W9 (k) adding on: finished to an edge: class high
PASS  T-W9 (l) admission admitted -> candidate: class high
PASS  T-W9 (l) candidate -> admitted on an item with no waits_for: class normal
PASS  T-W9 (m) one word of the Stage row: class high
PASS  T-W9 (n) a new tools/x_check.py: class high
PASS  T-W9 (n) one line of plan/builder/w-c00-12/check_ids.py: class high
PASS  T-W9 (o) appending a recorder-form line to owned_ids.txt: class normal
PASS  T-W9 (o) deleting a line of owned_ids.txt: class high
PASS  T-W9 (p) the exact revert of the executable part of a merge that also added a log entry: class normal
PASS  T-W9 (q) the exact revert of a merge that changed .github/workflows/watchdog.yml: class high
PASS  T-W9 (q) the exact revert of a merge that changed tools/builder_check.sh: class high
PASS  T-W9 (r) candidate -> admitted on a candidate whose history once carried waits_for: class high
PASS  T-W9 (t) reusing an existing verdict to accept W-C00-12 and its children (critic of 1b-ii #1): class high
PASS  T-W9 (t) the work check rejects the reused verdict
PASS  T-W9 (u) a producer-written verdict file naming W-C00-12 and a commit after its start (R-W12-4 B-1 scenario 1): class high
PASS  T-W9 (u) the reason is the missing M-R16 (b) binding
PASS  T-W9 (v) the existing unrelated verdict R-W12-2 as accepted_by and composition_by of W-C00-12 (R-W12-4 B-1 scenario 2): class high
PASS  T-W9 (v) the reason is that it names no commit at or after the item's start
PASS  T-W9 (w) control: accepting an edge target with a bound verdict that names it after its start: class normal
PASS  T-W9 (x) a child's bound verdict naming W-C00-12, written into W-C00-12 with no composition record and open children (R-W12-5 B-1): class high
PASS  T-W9 (x) the reason is the work check at the PR head (W-R4)
PASS  T-W9 (y) the children re-parented away and a child's bound verdict written into W-C00-12: class high
PASS  T-W9 (y) the reason names the parent change
PASS  T-W9 (s) a new admitted item under a stage with hold_until: class normal
PASS  T-W9 (s) the render shows it blocked by the hold
PASS  T-R4 an item marked small touching .claude/hooks/: computed class high, acceptance below a session verdict rejected
PASS  T-R4 an item of class normal without a triage record is rejected
PASS  T-R9 class batu without an owner reason fails
PASS  T-R9 a major decision without reopen_if fails
PASS  T-R9 a complete record passes
PASS  T-MAP1 the migrated tree with every carrier mapped passes
PASS  T-MAP1 a script, a hook entry and an agent definition without rows fail, each named
PASS  T-MAP2 a removed mapped script fails naming its row
PASS  T-MAP2 removing .claude/hooks/tool_allowlist.py fails naming row A-01 (critic of 1b-ii #6)
PASS  T-MAP2 removing tools/builder_check.sh fails naming row B9 (critic of 1b-ii #6)
PASS  T-MAP2 removing CLAUDE.md fails naming row B2 (critic of 1b-ii #6)
PASS  T-MAP3 a blank coverage cell fails naming the row and column
PASS  T-MAP5 a PR touching .claude/settings.json described as status-only needs a session verdict
PASS  T-MAP7 a planted derived term in a staged log line fails the stop check through the leak check
--- mutation checks (the check disabled in a scratch copy; the test must then report FAIL)
MUTANT  T-M2 unmodified tree passes: outcome as expected
MUTANT  T-M2 a hand-edited generated line fails: outcome NOT as expected (the disabled check shows)
MUTANT  T-M2 a state change without a re-render fails: outcome NOT as expected (the disabled check shows)
MUTANT  T-M3 (a) a modified decision record without a Record changes line fails: outcome NOT as expected (the disabled check shows)
PASS  M1 (views disabled): T-M2 reported FAIL: True
PASS  M2 (kinds disabled): T-M3 (a) reported FAIL: True
--- per test
T-R20 PASS (4/4 outcomes)
T-M1 PASS (3/3 outcomes)
T-M2 PASS (3/3 outcomes)
T-M3 PASS (6/6 outcomes)
T-M4 PASS (4/4 outcomes)
T-M5r PASS (3/3 outcomes)
T-M6r PASS (7/7 outcomes)
T-M7a PASS (8/8 outcomes)
T-M7b PASS (5/5 outcomes)
T-M7c PASS (4/4 outcomes)
T-M11 PASS (2/2 outcomes)
T-M14 PASS (4/4 outcomes)
T-M15 PASS (7/7 outcomes)
T-W1 PASS (9/9 outcomes)
T-W3r PASS (5/5 outcomes)
T-W4 PASS (3/3 outcomes)
T-W9 PASS (39/39 outcomes)
T-R4 PASS (2/2 outcomes)
T-R9 PASS (3/3 outcomes)
T-R11 PASS (1/1 outcomes)
T-MAP1 PASS (2/2 outcomes)
T-MAP2 PASS (4/4 outcomes)
T-MAP3 PASS (1/1 outcomes)
T-MAP5 PASS (1/1 outcomes)
T-MAP7 PASS (1/1 outcomes)
GATE 1b-ii PASS
```

## Mutation checks of the hold-lift cases (R-W12-4 C-1, R-W12-5 C-1; intent sections 9 and 10)

The planted cases must depend on the fixed checker, not on their fixtures. In two scratch clones of `2b7da56` (the commit the gate above ran on), `tools/check_records.py` was replaced by an earlier version and committed, so that the fixtures inherit it; then T-M15 and T-W9 ran. The lines below are the unedited result lines for the cases named, with the trailing check output after the label cut off (`: PASS  impact…`, `: PASS  claims…`).

`d6dea29` is the checker before R-W12-4's fix:

```text
head 2b7da56; mutant 8bfeb57 with tools/check_records.py from d6dea29
FAIL  T-M15 (b3) the reviewer session made owned only by a line the same change appends: fails: PASS  claims
PASS  T-W9 (t) reusing an existing verdict to accept W-C00-12 and its children (critic of 1b-ii #1): class high
PASS  T-W9 (t) the work check rejects the reused verdict
FAIL  T-W9 (u) a producer-written verdict file naming W-C00-12 and a commit after its start (R-W12-4 B-1 scenario 1): class high
FAIL  T-W9 (u) the reason is the missing M-R16 (b) binding
FAIL  T-W9 (v) the existing unrelated verdict R-W12-2 as accepted_by and composition_by of W-C00-12 (R-W12-4 B-1 scenario 2): class high
FAIL  T-W9 (v) the reason is that it names no commit at or after the item's start
PASS  T-W9 (w) control: accepting an edge target with a bound verdict that names it after its start: class normal
FAIL  T-W9 (x) a child's bound verdict naming W-C00-12, written into W-C00-12 with no composition record and open children (R-W12-5 B-1): class high
FAIL  T-W9 (x) the reason is the work check at the PR head (W-R4)
FAIL  T-W9 (y) the children re-parented away and a child's bound verdict written into W-C00-12: class high
FAIL  T-W9 (y) the reason names the parent change
```

`dff691e` is the checker R-W12-5 reviewed, before its fix:

```text
head 2b7da56; mutant 0b47930 with tools/check_records.py from dff691e
FAIL  T-M15 (b3) the reviewer session made owned only by a line the same change appends: fails: PASS  claims
PASS  T-W9 (t) reusing an existing verdict to accept W-C00-12 and its children (critic of 1b-ii #1): class high
PASS  T-W9 (t) the work check rejects the reused verdict
PASS  T-W9 (u) a producer-written verdict file naming W-C00-12 and a commit after its start (R-W12-4 B-1 scenario 1): class high
PASS  T-W9 (u) the reason is the missing M-R16 (b) binding
PASS  T-W9 (v) the existing unrelated verdict R-W12-2 as accepted_by and composition_by of W-C00-12 (R-W12-4 B-1 scenario 2): class high
PASS  T-W9 (v) the reason is that it names no commit at or after the item's start
PASS  T-W9 (w) control: accepting an edge target with a bound verdict that names it after its start: class normal
FAIL  T-W9 (x) a child's bound verdict naming W-C00-12, written into W-C00-12 with no composition record and open children (R-W12-5 B-1): class high
FAIL  T-W9 (x) the reason is the work check at the PR head (W-R4)
FAIL  T-W9 (y) the children re-parented away and a child's bound verdict written into W-C00-12: class high
FAIL  T-W9 (y) the reason names the parent change
```

Reading: (u) and (v) depend on the R-W12-4 fix; (x), (y) and T-M15 (b3) depend on the R-W12-5 fixes; on the fixed checker (the gate above) all of them pass. (t) passes on all three checkers, and the control (w) stays class normal on all three.
