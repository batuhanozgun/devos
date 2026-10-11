# EV-C01-017 · W-C01-38: the guard fails closed, by DevOS's own tests (PC-21 item 5; 2026-10-11)

**What this is.** The record W-C01-38 asks for. DevOS's own guard test was run once, in one session. The record gives the run's commit and counts, and judges the three properties PC-21 item 5 names (plan line 968): the guard denies a tool not on its list, never answers "ask", and denies when it fails or runs past its time limit. Under D-017 and the block's point 3, the record carries no rule detail. Test lines are cited by number only (`test:` is `tools/test_tool_allowlist.sh`; `settings:` is `.claude/settings.json`). The run's output names rules line by line, so it is not copied here.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527` (PR #221), checked out in the producer's clone on branch `claude/c01-w38-guard`. Blobs: `.claude/hooks/tool_allowlist.py` `35c23f7421783ddfe892b01bc0a3d9c5720f74f9` and `tools/test_tool_allowlist.sh` `24599661a18efa4f64686454d9f0ad9892353cbb` (both last changed in `1764100`, 2026-10-06); `.claude/settings.json` `ce7d09dd9f55d427969398d01d30064f638971cb` (last changed in `5223552`, 2026-10-05). During the work, `main` on GitHub moved to `fe69e1f68ee1ab6fc39d33b34c7d8abd459f760a` (PRs #223 and #224). Its five commits change none of these three files, and the three blobs are the same there (GitHub API, read 2026-10-11) |
| Deployment configuration | The guard run as a plain process, outside the platform. The test reads the two guard hook commands from `.claude/settings.json` (test:18-24) and runs them under `/bin/sh` (dash): the `PreToolUse` command with its wrapper that turns any non-zero exit into exit 2 (settings:18), and the `PermissionRequest` command (settings:30). Python 3.13.16, bash 5.2.21, git 2.43.0, in the Linux container of the working session `session_01XyxvJd3RayQk4HCrjurbVH`. Inputs are the test's own synthetic fixtures (test:1-6). The clone's branch is not on the remote |
| Criterion version | W-C01-38's acceptance block (`plan/work/W-C01-38.md`, blob `3571cb6fe995fadb2df7086ef580d3d37d4ad7ea`). The block's text is unchanged since `44cef4e` (W-C01-31, 2026-10-10). Read with plan C01 row 9 (plan line 952) and the PC-21 note under the C01 table, items 5 and 9 (lines 968 and 972) |
| Input | `bash tools/test_tool_allowlist.sh`, run with the clone root as working directory, 2026-10-11 from 12:55:36Z to 12:57:51Z |
| Actual observation | 702 `ok` lines, 0 `BAD` lines, 1 `info` line, final line `ALLOWLIST_TEST PASS`, exit code 0. Standard error: 13 copies of one Python `SyntaxWarning` (an invalid escape sequence at the guard's line 1018), and nothing else |
| Raw evidence ID | The run's standard output (704 lines, SHA-256 `7188825bb0ad0a06afa2013680b8ca56225ca94a6050d3c8830edac19c4f6167`) and standard error (SHA-256 `70bb60b835c88cff47cadc7b1d7a79fadcf0e31c9aa0abd5e7d46d50f837d61f`). They are kept only in the producer's scratchpad of session `session_01XyxvJd3RayQk4HCrjurbVH`, not in the repository (point 3). A re-run at the same commit on an unpushed branch gives the same counts, not the same bytes: the output carries temporary paths |
| Independence level | The same session's own test (plan Section 8 item 7): DevOS's deterministic unit test, run by a fresh-context producer subagent of the executor's working session. The documentation was read by the same producer on 2026-10-11. Judged by a fresh-context checker (declared, Ek A 5.3; PC-06) |

## How the criterion is read

- PC-21 item 5 governs. The three properties are "a property of DevOS's own code", "shown by DevOS's own tests of the guard in one session" (plan line 968).
- **"The guard"** is the one file that `.claude/settings.json` runs as two hooks, on every tool name (matcher `.*`): `PreToolUse` before each call, and `PermissionRequest` when a call still raises a permission prompt (settings:12-35). Both runs are judged.
- **"Its own time limit"** has two readings.
  - (R1) The guard's own limits: one time budget per call, and the limits of its own steps. The hooks' platform timeouts are set above them (working order section 10, line 150).
  - (R2) The hook's `timeout` in `.claude/settings.json`: 600 seconds for each guard hook (settings:19, 31).
  - Both are judged below. Point 2's action is the same under both.
- A case the tests do not cover is "could not check" (plan Section 8 item 14). It is never counted as met; it is handled as a failed part.

## Point 1. The run and the three properties

### The run

The counts are in the envelope. The one `info` line says the clone's branch is not on the remote, so the test skips 3 controls that need a pushed branch, and that the test (T-H4) counts only on a pushed branch (test:698-705). The 3 skipped controls concern starting a session on a branch; none bears on the three properties. An earlier run, with the same three blobs, recorded 705 `ok` lines (CHK-C01-009 item 10); 702 + 3 = 705.

### (a) It denies a tool not on its list: met

- Every tool name reaches the guard: both hooks' matchers cover 9 sample names, a made-up future tool name among them (test:25-29; 18 `ok` lines).
- 6 controls with tool names not on its list are denied (test:71-74, 103, 113; 6 `ok`).
- Positive control: the same run allows the 181 calls it should allow, beside its 450 expected denials. So the guard does not simply deny everything (plan Section 8 item 2).

### (b) It never answers "ask": met

- At the end, the test searches every guard output of the run for `"ask"` and finds none (test:915-916; 1 `ok`). The outputs searched are 630 decisions: 449 denials and 181 allows (test:918-949 counts them against the decision log; 2 `ok`).
- Error sensitivity: one output saying "ask" anywhere among the 630 would turn this check red.
- Coverage beyond the test's inputs, by reading the code: the guard has no "ask" value. Its `PreToolUse` answer carries its decision, allow or deny; its `PermissionRequest` answer is allow, or else deny (`.claude/hooks/tool_allowlist.py`:2083-2088). Read, not run.
- By design, the guard gives no decision for the two tools whose purpose is to put a question to the user, `AskUserQuestion` and `ExitPlanMode` (test:9-10; 3 `ok` controls at test:669-670 and 697). That is not an "ask" answer: these tools ask the user by what they are.
- Where the guard's `PermissionRequest` run cannot run, the platform leaves the prompt to the user. That is not the guard's answer; it is judged under (c).

### (c) It denies when it fails or runs past its own time limit: met in part

| Case | Shown by | Result |
|---|---|---|
| The `PreToolUse` run cannot start or crashes: a guard file with a syntax error, one with a failing import, a missing file, no `python3` | 4 fault injections through the `PreToolUse` command (test:952-960; 4 `ok`): each exits 2. The platform blocks a `PreToolUse` call on exit 2 (documentation, below) | met |
| The guard cannot read its input | 5 malformed inputs denied on `PreToolUse` (test:124-128; 5 `ok`). On `PermissionRequest` (test:696; 1 `ok`) the guard cannot learn the event from unreadable input, so it answers in the `PreToolUse` form (`hookEventName` `PreToolUse`, exit 0; `tool_allowlist.py`:2057-2066, 2086-2088). The test counts that as a deny because it reads either field (test:61-63), but the hooks page does not make it a `PermissionRequest` decision: `hookSpecificOutput` "requires a `hookEventName` field set to the event name", and a `PermissionRequest` hook denies through its decision object (CHK-C01-062 C2 (i)) | met for `PreToolUse`; for `PermissionRequest` could not check, a failed part (N-173) |
| An internal error inside the decision | The guard turns it into a denial (`tool_allowlist.py`:2069-2072). The test checks that no decision of the run came from such an error (test:917; 1 `ok`), so the path is not exercised | met by reading the code |
| The guard's own time limits (reading R1) | A call whose time budget is spent is denied, the denial says so, and the same call within the budget is allowed (test:833-839; 3 `ok`). A step that runs past its own limit is denied, and the denial says it timed out (test:840-846; 2 `ok`). Both hooks' platform timeouts lie above the budget (test:40-50; 1 `ok`) | met |
| The `PermissionRequest` run cannot start, or fails outside its decision step | Not covered: the test injects faults only into the `PreToolUse` command (test:955, 959). By configuration and documentation, it would not deny. The `PermissionRequest` command has no wrapper (settings:30). A hook that cannot start, or exits with a code other than 0 or 2, is a non-blocking error, and "the action goes ahead". Exit 2 is not honoured on `PermissionRequest`: "the permission flow proceeds unchanged" (documentation, below). The guard's own exit on a top-level error is 2 (`tool_allowlist.py`:2095-2098). So the prompt is left open, as working order section 10 already states (line 150) | could not check by the tests; by the documentation not met. A failed part |
| A guard hook reaches its platform timeout of 600 seconds (reading R2) | Not covered: the test checks only that the timeouts lie above the guard's budget (test:40-50). The platform cancels a timed-out command hook and discards its output. On `PreToolUse` the call "continues through the normal permission flow" (documentation, below). The guard's design keeps its worst case, about 580 seconds, under 600 (working order section 10, line 150); that is argued, not tested | under R2: could not check by the tests; by the documentation not met. A failed part. Under R1: outside the property, a stated residual |

**Point 1's result: not met in part.**
- (a) and (b) are met.
- (c) is met for the `PreToolUse` run and for the guard's own limits.
- (c) fails for a `PermissionRequest` run that cannot run or cannot read its input, and under R2 also for the platform timeout.
- The run is recorded with its commit and its pass and fail counts.

## Point 2. The fail path: the guard is corrected before C02 opens DevOS's environments

Row 9's fail path applies: "If the guard does not fail closed, it is corrected before C02 opens DevOS's environments" (plan line 952; PC-21 item 5 keeps it). This record does not make the correction. It changes class-high paths (`.claude/settings.json`, `tools/test_tool_allowlist.sh`, `plan/Installation_Working_Order.md`), which go through the merge gate with a fresh-context verdict. Note N-173 on `plan/work/C01.md` carries it. What it needs:

1. **Both guard hooks fail closed** when they cannot start, fail or time out. The documentation now offers a setting for this, `"onFailure": "block"` on a command hook. With it, a failure on `PreToolUse` blocks the call, and a failure on `PermissionRequest` denies the request. Failures include a hook that cannot start, an exit code other than 0 or 2, a timeout, and output that cannot be parsed or fails validation. It requires Claude Code v2.1.295 or later. The changelog dates that version 8 October 2026, two days after the guard's last change (documentation, below).
2. **The `PermissionRequest` run also denies on every exit 2 of its command, and on an answer in the `PreToolUse` form.** Every exit 2: the interpreter's own included (`python3` exits 2 when the guard file is missing), not only the guard's own top-level exit 2. The `PreToolUse` form: the guard's answer to unreadable input (point 1 (c)). The documentation counts exit 2 neither as such a failure nor as a block on that event, and does not make an answer in another event's form a `PermissionRequest` decision (CHK-C01-062 C2 (ii)).
3. **The test** gains a check that both guard hooks carry the setting, and fault injection on the `PermissionRequest` command with its expected result stated: for a syntax error, a failing import, a missing file, no `python3` and unreadable input, the command either prints a deny in the `PermissionRequest` form or exits with a code other than 0 and 2 (CHK-C01-062 C2 (iii)).
4. **Working order section 10, line 150**, is corrected to match, through plan Section 14. Its sentences "A `PreToolUse` hook that times out lets the call continue" and "A `PermissionRequest` hook that cannot run leaves the prompt open" describe the state before the correction.
5. **The version.** The page read does not say what a Claude Code version older than v2.1.295 does with the setting. A routine session cannot see its own version (EV-C01-007). The working session's container reported 2.1.296 (EV-C01-004 line 29; L-202). So the change shows, after it merges, that the settings still load and the guard is live: each session's opening check shows this.
6. **The tests run again**, on a pushed branch with no skipped control. The run is recorded with its commit and its counts, as here.

**Point 2's result: not met yet.** The correction is open; its deadline, before C02 opens DevOS's environments, has not passed.

## Point 3. No rule detail beyond the three properties and the counts

- This record names no rule, no rule ID and no fixture content. Test lines are cited by number.
- It describes the guard only as far as the three properties need: its two hooks, its exits on failure, its time limits and its answer values. It names only the two platform tools that the "never ask" property must set apart.
- The run's output is not copied (envelope, "Raw evidence ID").

The checker judges this.

## Facts taken from the documentation (PC-21 item 9)

Sources: the Claude Code hooks page, https://code.claude.com/docs/en/hooks (fetched as `hooks.md`), read 2026-10-11 at about 12:52Z, which shows no date of its own; and the Claude Code changelog, https://code.claude.com/docs/en/changelog (fetched as `changelog.md`), read 2026-10-11, for the last fact only.

- A `PreToolUse` hook that exits 2 blocks the tool call (sections "Exit code 2" and "Exit code 2 behavior per event"). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested. Live corroboration, for the guard's denial in its JSON form rather than by exit 2: in the routine's first run, a write the guard denied was not sent (`evidence/C01/routine/runs/R1a-20261011T0808Z/R1a/CLOSING.md`:30; EV-C01-005).
- A hook that cannot start, or exits with a code other than 0 or 2 without valid JSON, is a non-blocking error: "The action goes ahead". So is output that cannot be parsed or fails validation with exit 0 (section "Exit code output"). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- On `PermissionRequest`, "Exit code 2 isn't honored for this event and the permission flow proceeds unchanged"; a hook denies through its decision object (section "Exit code 2 behavior per event"). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- A command hook that reaches its timeout is cancelled and its output discarded, "so on most events a timed-out hook renders no decision". On `PreToolUse`, a timed-out command hook "doesn't block the tool call. The call continues through the normal permission flow" (section "Timeouts"). A command hook's default timeout is 600 seconds (section "Common fields"). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- With `"onFailure": "block"` on a command or HTTP hook, a failure does what exit 2 does on that event, "except on `PermissionRequest`, where it denies the request". The failures are: cannot start; an exit code other than 0 or 2; an HTTP error; a timeout; invalid output. The default is `"continue"`. It "Requires Claude Code v2.1.295 or later" (section "Block the action when a hook fails"). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- A `PreToolUse` hook's decision is allow, deny, ask or defer, and "ask" prompts the user to confirm. A `PermissionRequest` hook's decision is allow or deny (sections "Decision control" and "PreToolUse decision control"). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- Version 2.1.295, "October 8, 2026", "Added `onFailure: "block"` for command and HTTP hooks: a hook that can't start, times out, or exits with an unexpected code blocks the action instead of letting it through". Guaranteed by platform (documented in https://code.claude.com/docs/en/changelog, read 2026-10-11); not independently tested.
- Qualifiers:
  - Per environment, only the variables, secrets and network setting are separate.
  - The GitHub identity and the account's connectors are shared across the account.
  - An environment's variables are readable inside its own sessions.
  - The channel to the model's own service stays open whatever the network setting.
  - Routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).
  - These facts hold for the version the page describes. The working session's container reported 2.1.296 on 2026-10-11 (EV-C01-004 line 29); a routine session's version is not visible to it (EV-C01-007).

## What the record cannot show

- **The platform's side.** The test runs the guard as a plain process. That the platform runs these commands and acts on their answers rests on the documentation (above) and on the live sessions (EV-C01-005, EV-C01-007), not on this run.
- **Coverage.** Only the test's inputs were decided. For property (b), the code reading covers other inputs. Not exercised: the internal-error path, a failing `PermissionRequest` run, and the platform timeout.
- **Skipped controls.** 3 controls were skipped, because the branch is not pushed. They do not bear on the three properties. The re-run of point 2 is made on a pushed branch.
- **Freshness.** The result is tied to the three blobs in the envelope. C02 plans to change `.claude/settings.json` before DevOS's environments open (S9's bridge, note N-136 on `plan/work/C02.md`). A change to any of the three needs a new run before then (note N-174 on `plan/work/C02.md`). C03 test 3 tests the guard again (PC-21 item 5).
- **The warning.** On every run, Python 3.13.16 warns about an invalid escape sequence at the guard's line 1018. It changes no decision here. If a later Python version made it an error, the guard would not start. The `PreToolUse` wrapper would then block every call: closed, but also a lock-out of the working session (working order section 10). This is not one of the three properties.

## Result

| Point | Result | Where |
|---|---|---|
| 1 (a). The tests show that it denies a tool not on its list | met | Point 1 (a) |
| 1 (b). It never answers "ask" | met | Point 1 (b) |
| 1 (c). It denies when it fails or runs past its own time limit | met for the `PreToolUse` run and for the guard's own limits; not met for a `PermissionRequest` run that cannot run (could not check by the tests; by the documentation, the prompt stays open); could not check, a failed part, for unreadable input on `PermissionRequest`; under reading R2, also not met at the platform timeout | Point 1 (c) |
| 1. The run is recorded with its commit and its pass and fail counts | met: `f957519`, 702 `ok`, 0 `BAD`, 1 `info` (3 controls skipped) | Envelope; "The run" |
| 2. The fail path: corrected through the merge gate before C02 opens DevOS's environments, and the tests run again | applies; not met yet: the correction is open, within its deadline | Point 2; N-173 |
| 3. No rule detail beyond the three properties and the counts | met, for the checker to judge | Point 3 |

No change to `plan/DevOS_Kurulum_Plani.md` follows. The working order change is part of point 2's correction, which is class high. No decision is Batu's: the guard is the builder's technical matter (D-003; D-008), and the correction enables no paid feature.

## Addendum (2026-10-11): the corrected guard merged and the tests run again

**What this is.** Point 2 above left the correction open (N-173). It is now merged, and DevOS's own guard test has been run again on `main`. This addendum records five things: the correction with its merge and verdicts; the re-run; the working session's report after the sync; the documentation facts that no test observes; and N-185. It then reads the block's points 1 to 3 and its last paragraph against the record as it now stands. The sections above stay as written; where this addendum differs from them, it is the later reading. As above, it names no rule, no rule ID and no fixture content. It cites lines by number only, at the merged blobs in the envelope (A6): `test:` is `tools/test_tool_allowlist.sh`, `settings:` is `.claude/settings.json`, `guard:` is `.claude/hooks/tool_allowlist.py`. It copies none of the run's output beyond its final line and its counts.

### A1. The correction, its verdicts and its merge

- **The change** was made on branch `claude/c01-w38-guard-fails-closed` (L-222), as N-173 (a) to (e) asked:
  - Both guard hooks carry `"onFailure": "block"` (settings:20, 33).
  - The `PermissionRequest` command is now a wrapper of shell builtins (settings:31). It passes on exactly two results of the guard: an empty answer with exit 0 (the guard's "pass"), and an answer in that event's form with exit 0. Everything else becomes a deny in that event's form, with exit 0. That covers a non-zero exit, the interpreter's own exit 2 included, and an answer in another event's form. The wrapper also names its event to the guard.
  - The guard takes its event from that argument (guard:2066-2068), so it answers input it cannot read with a deny in the `PermissionRequest` form. The decision step is untouched, and no rule changed (CHK-C01-076 finding 3).
  - The test now counts an answer only in its own event's form (test:67-84). It checks the setting on both hooks (test:53-65). It injects seven faults into the `PermissionRequest` command, under `/bin/sh` and under bash, with three positive controls (test:981-1012).
  - Working order section 10 (now line 152) says what the change does.
- **The verdicts.** All three checkers are fresh-context subagents of the same session (declared, Ek A 5.3):
  - CHK-C01-076 (behaviour, tests, lock-out safety): PASS-WITH-CONDITIONS at `2844fe7`.
  - CHK-C01-077 (documentation, settings validity, texts): PASS-WITH-CONDITIONS at `2844fe7`.
  - CHK-C01-081, the delta check of merging `main` into the branch: PASS-WITH-CONDITIONS at `dbec7dc`.
  - Their conditions are met at the merged head. CHK-C01-076 C1 and CHK-C01-077 C1 and C2 are met as worded (CHK-C01-081 finding 6; L-228). The second half of CHK-C01-076 C1 and CHK-C01-077 C2, the log entry after the sync, is L-230 (A3). CHK-C01-081 C1 is met by L-228's corrected time.
- **The merge.** It went through the merge gate as pull request #235, merge commit `8fe23a739de3f83a6b8b2aba4478c21996aac655` (2026-10-11T15:48:59Z).
  - The pull request's head was `e50d0e0`. It adds only class-normal files to `dbec7dc`: the gate's own `high_paths(dbec7dc, e50d0e0)` is empty, so CHK-C01-081 covers it.
  - The guard allowed the merge call through its merge-gate check (decision record #8266, 15:48:57Z).
- **The guard files are the ones judged.** The three guard files are byte-identical at `2844fe7`, `dbec7dc`, `8fe23a7` and `a9f62f5` (A6).
- **The deadline.** C02 has not opened DevOS's environments: `plan/work/C02.md` reads `execution: planned`.

### A2. The tests run again

Both runs used the same commit, in this addendum's producer's clone, with the clone root as the working directory. Run 1 was made on the clone's own branch. Its branch controls were skipped, so run 2 was made with `main` checked out. Run 2 is the run of record.

| | Run 1 | Run 2 (of record) |
|---|---|---|
| Commit | `main` `a9f62f5` | `main` `a9f62f5` |
| Checked out | branch `claude/c01-w38-record`, not on the remote | `main`, on the remote |
| Time (`date -u`) | 15:53:57Z to 15:56:09Z | 15:57:09Z to 15:59:31Z |
| Exit status | 0 | 0 |
| Final line, verbatim | `ALLOWLIST_TEST PASS` | `ALLOWLIST_TEST PASS` |
| `ok` / `BAD` / `info` lines | 725 / 0 / 1 | 728 / 0 / 0 |
| Skipped controls | 3 (the branch is not on the remote; test:718-725) | none |
| Standard error | 26 lines: 13 copies of the known `SyntaxWarning` at guard line 1021, each with its source line | 18 lines: 9 copies of the same warning, each with its source line |

- **The run's summary counts** (run 2):
  - 181 expected allows and 448 expected denials, both in the `PreToolUse` form.
  - 2 expected passes.
  - 6 `PermissionRequest` decisions in the main section.
  - 20 `PermissionRequest` fault and control lines.
  - 4 `PreToolUse` wrapper faults.
  - 450 denials, each with its full text.
  - 637 decision-log records for 633 decisions.
- **Against earlier runs.** 725 + 3 = 728. CHK-C01-076 (finding 2) and CHK-C01-081 (finding 4) report the same 728 `ok` and 0 `BAD` for the same three blobs.
- **The merge gate's own test,** `python3 -B tools/test_merge_gate.py`, 16:00:34Z to 16:00:39Z: exit 0, final line `MERGE_GATE_TEST PASS (24/24)`, no standard error.
- **The clone** was clean before and after each run.

### A3. The working session's report after the sync (L-230)

N-173 (e), CHK-C01-076 C1 and CHK-C01-077 C2 asked for this step. The session that syncs the change gets the new hooks mid-session through the file watcher, and its opening check does not run again.

- **The sync.** `tools/sync_worktree.sh` ran from 15:49:04Z to 15:49:05Z ("SYNC OK: 8fe23a7 = origin/main").
- **Before the sync,** the last decision record was #8268 (15:49:04Z).
- **After the sync,** the first was #8269 (15:49:08Z, allowed), then #8270 (15:49:15Z, allowed).
- **Checked against the decision log.** This addendum's producer read records #8266 to #8271 in the session's decision log on 2026-10-11 at about 15:57Z. Their times and decisions match L-230, and #8271 (15:49:18Z) is also allowed.
- **The live tree.** It is at `a9f62f5`, and its three guard blobs are those in A6; `git status` shows no change to `.claude/` or `tools/`.
- **What this shows:** in the working session after the sync, the settings load and the guard is live.
- **What it does not show:** that the platform applies `onFailure` (A4).

### A4. Facts taken from the documentation (PC-21 item 9)

These are the parts no test observes. The sources are three Claude Code pages: the hooks page and the changelog cited above, and the settings page, https://code.claude.com/docs/en/settings (fetched as `settings.md`). This addendum's producer read the hooks page and the changelog on 2026-10-11 at 15:54:57Z, and the settings page at 15:57:38Z. Line numbers refer to the fetched files. CHK-C01-077 read the same three pages earlier that day (findings 2 and 3).

- **The setting.** `onFailure` on a command hook decides "What happens to the action when the hook fails: `"continue"`, the default, or `"block"`", and it "Requires Claude Code v2.1.295 or later" (hooks.md:461, 883).
  - The failures are: the hook can't start; an exit code other than 0 or 2; an HTTP error; a timeout; invalid output. "Plain-text stdout from a command hook isn't a failure" (hooks.md:916-922).
  - "With `"block"` set, a failure does what exit code 2 does on that event, except on `PermissionRequest`, where it denies the request" (hooks.md:924).
  - The field has no effect on four events where exit 2 sends Claude back to work (`Stop`, `SubagentStop`, `TaskCompleted`, `TeammateIdle`) and on background hooks (hooks.md:926-929). Neither guard hook is one of these.
  - Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- **A timed-out hook.** It "doesn't block the tool call", and "To block the call when a `command` or `http` hook times out, set `onFailure: "block"`" (hooks.md:878). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- **The changelog.** Version 2.1.295, "October 8, 2026": "Added `onFailure: "block"` for command and HTTP hooks: a hook that can't start, times out, or exits with an unexpected code blocks the action instead of letting it through" (changelog.md:106-109). Version 2.1.296, "October 9, 2026", is the newest entry, and no entry after 2.1.295 mentions `onFailure`. Guaranteed by platform (documented in https://code.claude.com/docs/en/changelog, read 2026-10-11); not independently tested.
- **Edits to settings mid-session.** "Direct edits to hooks in settings files are normally picked up automatically by the file watcher" (hooks.md:718). This is why A3's step exists. A3 observes its outcome, a live guard after the sync, but not that the setting is applied. Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- **No output.** "Exit code 0 with no output means the hook has no decision to report, so the tool call continues through the normal permission flow" (hooks.md:227). This bears on N-185 (A5). Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- **A rejected setting.** "Invalid JSON or a rejected value makes Claude Code skip the file or the entry" (settings.md:702). Guaranteed by platform (documented in https://code.claude.com/docs/en/settings, read 2026-10-11); not independently tested.
- **The claim no test observes.** Claude Code 2.1.296 applies `"onFailure": "block"`. So a guard hook that times out or cannot start blocks the call (`PreToolUse`) or denies the request (`PermissionRequest`).
  - The pages above document this for v2.1.295 or later. The working session's container reported 2.1.296 (EV-C01-004 line 29; CHK-C01-077 finding 2).
  - It is recorded as guaranteed by platform (documented in https://code.claude.com/docs/en/hooks and https://code.claude.com/docs/en/changelog, read 2026-10-11); not independently tested.
  - It is documented, not observed (D-017 item 2(c)). Under D-017 item 3 it is never counted as meeting a condition that the row requires to be observed (A7, point 1 (c)).
- **Qualifiers:**
  - The facts hold for v2.1.295 or later, as the pages describe them. A routine session cannot see its own version (EV-C01-007). The pages do not say what an older version does with the key.
    - If an older version rejects the entry or the file, no guard hook runs, and the opening check shows it (working order section 3 item 2; CHK-C01-077 finding 3).
    - If it ignores the key, a timed-out call continues, and no check shows it (working order section 10, line 152).
  - The hooks page contradicts itself on the default shell (CHK-C01-077 finding 2). The test injects the `PermissionRequest` faults under both shells (test:997), so its result holds either way.
  - PC-21 item 9's qualifiers stand as listed above:
    - per environment, only the variables, secrets and network setting are separate;
    - the GitHub identity and the account's connectors are shared across the account;
    - an environment's variables are readable inside its own sessions;
    - the channel to the model's own service stays open whatever the network setting;
    - routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).

### A5. N-185: an empty or truncated guard file reads as "pass"

- **What it is.** Some broken guard files exit 0 with no output on both hooks: an empty file, and a file cut short at a point where it still compiles.
  - CHK-C01-076 (finding 8) ran an empty file and 13 such cuts through both live commands. Every one exited 0 with no output. CHK-C01-077 (finding 9) confirms the reading.
  - Exit 0 with no output is no decision, and the call goes to the normal permission flow (hooks.md:227).
  - `onFailure` does not count it as a failure (hooks.md:916-922).
  - The `PermissionRequest` wrapper passes it on as the guard's "pass" (settings:31).
  - So such a guard does not deny. The guard behaved the same before the change (CHK-C01-076 finding 8), so the change neither made this gap nor widened it.
- **What shows it.** The test does not cover it (CHK-C01-076 finding 7 (a)). This addendum did not observe it either: it rests on the two checkers' runs and readings, and on the hooks page.
- **The likely causes.** A session cannot write the live guard (CHK-C01-076 finding 8). That leaves an interrupted sync or a disk fault. A low likelihood does not take the case out of the property: probability is not impact (Ek D, D1).
- **How the block handles it.**
  - Point 1 asks the tests to show that the guard "denies when it fails". Row 9 reads "when it is made to fail … (fault injection)". An empty or cut-short guard file is the same kind of fault as the missing file and the syntax error that the test already injects. So it falls inside property (c).
  - The tests do not show a deny for it, and by the checkers' runs and the documentation it does not deny. So (c) is not met for this case. It is a failed part (plan Section 8 item 14).
  - Point 2 then applies to it, as it did to N-173. The guard is corrected through the merge gate with a fresh-context verdict before C02 opens DevOS's environments, and the tests are run again. N-185 proposes the correction: an explicit marker for "pass", so that empty output becomes a failure on both hooks.
  - N-185's "or a recorded reason why not" is not read as leave to accept W-C01-38 with this case unjudged (CHK-C01-076 finding 8; CHK-C01-077 finding 9).
- **A narrower reading.** On it, "fails" means only the guard process failing: it cannot start, it errors, or it times out. A file that runs and prints nothing is then a broken install, not a failing guard, and N-185 a residual outside the property. This addendum does not take that reading, for two reasons:
  - It would make the property depend on how a fault happens to show itself.
  - Both checkers read the property the other way.
  - The checker judges this.

### A6. Evidence envelope for this addendum (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `a9f62f5d1674de243746891d0f90fcc35144b7fa` (PR #236). Blobs: `.claude/settings.json` `6d81bf2c96ce82a19ba2a93532bf176ef51dd1c8`, `.claude/hooks/tool_allowlist.py` `46636ffefa4fcfb37267bcc96df7078a17c50fe8`, `tools/test_tool_allowlist.sh` `b088ee3f1a4055d9b3eb8df7895d62c4032bdfc4`. They are byte-identical at `2844fe7` (CHK-C01-076, CHK-C01-077), `dbec7dc` (CHK-C01-081), `8fe23a7` (PR #235) and `a9f62f5`. The working session's live tree is at `a9f62f5` with the same three blobs (read 2026-10-11 at about 15:57Z) |
| Deployment configuration | The guard is run as a plain process, outside the platform. The test reads both guard hook commands and matchers from `.claude/settings.json` (test:19-25), and their `onFailure` and timeouts (test:41-65). It runs the commands under `/bin/sh` (dash), and the `PermissionRequest` faults under bash as well (test:997). Python 3.13.16, bash 5.2.21, git 2.43.0, in the Linux container of the working session `session_01XyxvJd3RayQk4HCrjurbVH`. The inputs are the test's own synthetic fixtures (test:1-6). How the platform applies the settings is covered in A3 and A4 |
| Criterion version | W-C01-38's acceptance block. It is byte-identical from `44cef4e` (W-C01-31, 2026-10-10) to `a9f62f5`. Its SHA-256, from `<!-- acceptance -->` to `<!-- /acceptance -->` inclusive, is `595b3ea1ca899bbda5577bf9d1f0f965fe5ddff050e388172d0b70be439c0d4c`. It is read with plan C01 row 9 (plan line 953 at `a9f62f5`), the PC-21 note's items 5 and 9 (lines 969 and 973), plan Section 8 items 7, 9 and 14, and D-017 items 2 and 3 |
| Input | `bash tools/test_tool_allowlist.sh`, run twice (A2): run 1 from 15:53:57Z to 15:56:09Z, run 2 from 15:57:09Z to 15:59:31Z. Then `python3 -B tools/test_merge_gate.py`. The documentation was read by plain GET (A4), and the decision log's records #8266 to #8271 were read (A3) |
| Actual observation | Run 2: 728 `ok`, 0 `BAD`, 0 `info`, no control skipped, `ALLOWLIST_TEST PASS`, exit 0. Run 1: 725 `ok`, 0 `BAD`, 1 `info` (3 controls skipped), `ALLOWLIST_TEST PASS`, exit 0. Merge gate test: `MERGE_GATE_TEST PASS (24/24)`, exit 0 |
| Raw evidence ID | SHA-256 of standard output and standard error. Run 2: `0b7488daac22421c00efa011a413acc73c917721c48840f283c8cc68954000eb` and `846d869a5f034dc354d1da305f86664ccd7f0d699cb9f8d5212de482ec78f2cd`. Run 1: `dd92626363fc6f488dde53249a30ef75f82f67d870376d2a239bc723764d24a7` and `a38f9de2755762d05e8f00933b86ab8bf80d4d176a64e29898f2b5ab93a5c50a`. They are kept only in the producer's scratchpad of session `session_01XyxvJd3RayQk4HCrjurbVH`, not in the repository (point 3). A re-run gives the same counts, not the same bytes, because the output carries temporary paths |
| Independence level | The same session's own test (plan Section 8 item 7): DevOS's deterministic unit test, run by a fresh-context producer subagent of the executor's working session. The same producer read the documentation and the decision log. With the three verdicts in A1, it shares the test and the documentation pages. It adds no new break test; the test's sensitivity rests on CHK-C01-076 finding 7, for byte-identical guard files. It is judged by a later fresh-context checker (declared, Ek A 5.3; PC-06) |

### A7. The block, point by point, against the record as it now stands

**Point 1 (a). It denies a tool not on its list: met.**
- Both hooks' matchers cover 9 sample names, a made-up future tool name among them (test:26-30; 18 `ok`).
- Tool names not on its list are denied, for example the made-up name at test:133.
- Positive control: the same run allows all 181 calls it should allow, beside its 448 expected denials. So the guard does not simply deny everything.

**Point 1 (b). It never answers "ask": met.**
- The test searches every guard output of the run for `"ask"` and finds none (test:936; 1 `ok`). The outputs searched are the 633 decisions counted against the decision log (test:959-969).
- By reading the code: the guard's only answer values are allow, deny and pass (a search of the guard for `"ask"` finds nothing). Its `PermissionRequest` answer is allow or deny (guard:2088-2089). The wrapper itself writes only a deny (settings:31).
- The two tools that put a question to the user still pass, as point 1 (b) above explains (test:689-690, 717, 1008).

**Point 1 (c). It denies when it fails or runs past its own time limit: met for every case the earlier record found failing; not met for N-185; under reading R2, the platform's part rests on documentation only.**

| Case | Shown by | Result |
|---|---|---|
| The `PreToolUse` run cannot start or crashes | 4 fault injections (test:972-980; 4 `ok`): each exits 2, and the platform blocks a `PreToolUse` call on exit 2 (documentation above) | met, as before |
| The `PermissionRequest` run cannot start or fails: a syntax error, a failing import, a missing file, no `python3`, the guard's own exit 2, an answer in the other event's form | test:997-1004 under `/bin/sh` and bash: each gives a deny in the `PermissionRequest` form with exit 0. 3 positive controls show that the guard's own allow, deny and pass are kept (test:1005-1008). 20 `ok` in all | met (before: not met, N-173) |
| The guard cannot read its input | `PreToolUse`: 5 malformed inputs denied (test:144-148; 5 `ok`). `PermissionRequest`: test:716 now counts only an answer in that event's form (test:78-80). Unreadable input is denied in that form under both shells (test:1002), and by the guard itself, not the wrapper (test:1010-1012; 1 `ok`) | met (before: could not check on `PermissionRequest`, N-173) |
| An internal error inside the decision | The guard turns it into a deny (guard:2075-2076). The test checks that no decision of the run came from one (test:937), so the path is not exercised | met by reading the code, as before |
| The guard's own time limits (reading R1) | A call whose time budget is spent is denied, and the same call within the budget is allowed. A step past its own limit is denied and the denial says it timed out (test:853-866; 5 `ok`). Both hooks' platform timeouts lie above the budget (test:41-52; 1 `ok`) | met, as before |
| A guard hook reaches its 600-second platform timeout, or its shell cannot start (reading R2: the platform's side) | DevOS's side: both hooks carry `"onFailure": "block"` as command hooks, not in the background (test:53-65; 2 `ok`). The platform's side: documented for v2.1.295 or later, not independently tested (A4) | DevOS's code: shown by the test. The platform's part: documented only, and under D-017 item 3 not counted as observed. Under R1 it lies outside the property, a stated residual. Under R2 the tests could not check it. The checker judges this |
| An empty or truncated guard file (N-185) | Not covered by the test. By two checkers' runs and the documentation, there is no decision on either hook (A5) | not met, a failed part |

PC-21 item 5 calls the three properties "a property of DevOS's own code", "shown by DevOS's own tests". On this record's reading, that wording favours R1 for what the tests must show, and makes R2's platform part a documented residual (A4). The checker judges the reading.

**Point 1, the record of the run: met.** Run 2 is recorded with its commit (`a9f62f5`) and its counts: 728 `ok`, 0 `BAD`, no control skipped (A2, A6).

**Point 1's result: not met in part,** because of N-185 (A5). Under R2, the timeout case also rests on documentation alone.

**Point 2. The fail path, then the tests run again.**
- **For the cases N-173 carried: met.**
  - The guard was corrected through the merge gate with fresh-context verdicts (A1).
  - This happened before C02 opens DevOS's environments.
  - The tests were run again on a pushed branch, with no skipped control (A2).
  - The working session's guard is live after the sync (A3).
- **For N-185: it applies, and is not met yet.** Its deadline, before C02 opens DevOS's environments, has not passed (A5; N-185).

**Point 3. No rule detail beyond the three properties and the counts: met.** The checker judges this.
- This addendum names no rule, no rule ID and no fixture content, and quotes no denial text.
- It cites test, settings and guard lines by number only.
- It copies only the run's final line and its counts.
- It describes the change only as far as the properties need: the hooks' setting, what the wrapper passes on and what it denies, and the event argument.

**The last paragraph.**
- **The evidence envelope:** met (A6 here; the envelope above for the first run).
- **PC-21 item 9's claim:** met. Every documentation fact carries its source, its reading date, "not independently tested" and the qualifiers (A4, and "Facts taken from the documentation" above). The checker judges this.
- **A fresh-context checker at a fixed head, with its independence level:** not yet. W-C01-38's acceptance waits on that verdict (CHK-C01-062 C3).

### A8. What the addendum cannot show

- **The platform's side.** The test runs the guard as a plain process. Whether 2.1.296 applies `onFailure` rests on the documentation (A4). That the platform runs the hooks and acts on their answers rests on the documentation and on the live sessions (A3; EV-C01-005, EV-C01-007).
- **N-185** was not observed by this addendum. It rests on CHK-C01-076's runs and on the hooks page (A5).
- **Freshness.** The result is tied to the three blobs in A6. C02 plans to change `.claude/settings.json` before DevOS's environments open, and any change to the three files needs a new run before then (N-174 on `plan/work/C02.md`). N-185's correction is such a change. C03 test 3 tests the guard again (PC-21 item 5).
- **The warning.** The `SyntaxWarning` is unchanged apart from its line number, now guard line 1021. As said above, it changes no decision here.

### A9. Result

| Point | Result | Where |
|---|---|---|
| 1 (a). The tests show that it denies a tool not on its list | met | A7 |
| 1 (b). It never answers "ask" | met | A7 |
| 1 (c). It denies when it fails or runs past its own time limit | met for every case N-173 carried and for the guard's own limits. Not met for an empty or truncated guard file (N-185), a failed part. Under reading R2, the platform timeout rests on documentation only (D-017 item 3), for the checker | A5, A7 |
| 1. The run is recorded with its commit and its pass and fail counts | met: `a9f62f5`, 728 `ok`, 0 `BAD`, no control skipped | A2, A6 |
| 2. Corrected through the merge gate before C02 opens DevOS's environments, and the tests run again | met for N-173's cases (PR #235, `8fe23a7`; CHK-C01-076, CHK-C01-077, CHK-C01-081; the re-run). Applies to N-185, not met yet, within its deadline | A1, A2, A5 |
| 3. No rule detail beyond the three properties and the counts | met, for the checker to judge | A7 |
| Last paragraph: envelope, PC-21 item 9's claim, a fresh-context verdict | envelope and claim met; the verdict is still to come | A4, A6 |

- **Not accepted here.** W-C01-38 is not accepted by this addendum. A fresh-context checker judges it against the unchanged block at a fixed head (CHK-C01-062 C3).
- **N-185 stands in the way.** On this record's reading, the item cannot be accepted while N-185 is open: point 1 (c) is not met for that case, and point 2's fail path applies to it. The checker judges this reading.
- **No plan change and nothing for Batu.** No change to `plan/DevOS_Kurulum_Plani.md` follows. No decision is Batu's: the guard is the builder's technical matter (D-003; D-008).

## Addendum 2 (2026-10-11): N-185 corrected, merged and tested on `main`

**What this is.** Addendum 1 (A1 to A9) found point 1 (c) and point 2 not met for one case only: N-185, an empty or truncated guard file, which gives no decision on either hook (A5). N-185's correction is now merged. DevOS's own guard test has been run again on `main` with no control skipped, and the working session has reported its guard live after the sync. This addendum records those, the break tests a checker ran against the corrected guard, the documentation facts the correction rests on, and the residual it leaves. It then reads the block's points 1 to 3 and its last paragraph against the record as it now stands. The sections above, Addendum 1 included, stay as written; where this addendum differs from them, it is the later reading. As above, it names no rule, no rule ID and no fixture content, and quotes neither a denial nor the marker's text. It cites lines by number only, at the blobs in B7: `test:` is `tools/test_tool_allowlist.sh`, `settings:` is `.claude/settings.json`, `guard:` is `.claude/hooks/tool_allowlist.py`.

### B1. The correction, its verdicts and its merge

- **The change** is one commit, `3ff0460`, on `main` `083d1ec` (branch `claude/c01-n185-guard-pass-marker`; N-185's dated line on `plan/work/C01.md`):
  - The guard answers "pass", for the two tools that put a question to the user, with a plain-text marker instead of nothing (guard:109-112, 2089). Allow and deny keep their JSON in the event's form. So no path of the guard exits 0 with no output, and an error anywhere exits 2 (CHK-C01-085 finding 2; CHK-C01-086 finding 4).
  - Both guard hook commands are wrappers of shell builtins that pass on only an answer in their event's form or that marker (settings:18, 31). On anything else, an exit 0 with no output included, the `PreToolUse` command exits 2 with its reason on standard error, and the `PermissionRequest` command prints a deny in its event's form with exit 0. Both hooks keep `"onFailure": "block"` and their 600-second timeout (settings:19-20, 32-33; CHK-C01-086 finding 3).
  - The test gains a section (test:1015-1077):
    - It checks that both commands carry the guard's marker, and that the guard alone answers the two user tools with it.
    - Its controls show that an empty file and a copy cut before a definition each exit 0 with no output when run alone: N-185's case.
    - Under `/bin/sh` and bash, it has an empty guard file and two truncated copies denied in each event's form. It also has an allow in the other event's form, and plain text that is not the marker, denied.
    - Its positive controls show that the two user tools still get the marker, ordinary calls are allowed, and a call the guard denies is still denied.
    - That is 44 new `ok` lines (CHK-C01-085 finding 1).
  - No guard rule changed (CHK-C01-086 finding 4). For five inputs, allow and deny output is byte-identical to the previous guard's (CHK-C01-085 finding 2).
  - Working order section 10's guard-hook item gains one sentence on the marker (`plan/Installation_Working_Order.md`:152).
- **The verdicts.** Both checkers are fresh-context subagents of the same session (declared, Ek A 5.3), at `3ff0460`:
  - CHK-C01-085 (behaviour, tests and lock-out safety): PASS-WITH-CONDITIONS.
  - CHK-C01-086 (documentation and texts): PASS-WITH-CONDITIONS.
  - Their one condition, the same in both, was a false sentence in N-185's dated line. It is met in `plan/work/C01.md` at `747441c`, and the executor's four checks at that head are in L-233.
  - From `3ff0460` to `747441c`, the diff touches only the two verdict files, the log, `plan/work/C01.md`, and the generated `DURUM.md` and `plan/ledger.md`. It touches none of the three guard files and not the working order (this addendum's producer, `git diff --stat`).
- **The merge.** It went through the merge gate as pull request #238, merge commit `e9fc0a41fcde2cbb58c0db19eb12fd1b6c81cef3` (2026-10-11T16:33:28Z).
  - Its parents are `083d1ec` and `747441c`, and its tree is `747441c`'s (an empty `git diff`).
  - The guard allowed the merge call through its merge-gate check (decision record #8916, 16:33:26Z).
- **The guard files are the ones judged.** The three guard files are byte-identical at `3ff0460`, `747441c`, `e9fc0a4` and `ec4429a` (B7).
- **The deadline.** C02 has not opened DevOS's environments: `plan/work/C02.md` reads `execution: planned`.

### B2. The tests run again on `main` (L-234)

| | The run of record |
|---|---|
| Commit | `main` `e9fc0a41fcde2cbb58c0db19eb12fd1b6c81cef3` |
| Where | a fresh clone of `main`, with `main` checked out and the clone root as the working directory |
| By | the executor (L-234) |
| Time | 16:34:01Z to 16:36:27Z |
| Exit status | 0 |
| Final line, verbatim | `ALLOWLIST_TEST PASS` |
| `ok` / `BAD` / `info` lines | 772 / 0 / 0 |
| Skipped controls | none |
| Standard error | 26 lines: 13 copies of the known `SyntaxWarning`, now at guard line 1026, each with its source line |

- **Checked against the run's saved output.** This addendum's producer read the run's saved standard output, standard error and time file in the session's scratchpad on 2026-10-11 between 16:38Z and 16:44Z.
  - Standard output has 773 lines: 772 `ok`, 0 `BAD`, 0 `info`, no line naming a skipped control, and the final line above.
  - The time file holds the start and end times above and `exit 0`.
  - Standard error has 26 lines.
  - The clone was at `e9fc0a4` on `main`, with nothing changed (`git status`).
- **N-185's case in the run.** These lines are all `ok`:
  - the 12 lines for an empty guard file and the two truncated copies, under both events and both shells;
  - the 6 lines for an answer in the other event's form and for plain text;
  - the 2 controls showing that two of those files, run alone, exit 0 with no output.
- **Against earlier runs.** 728 + 44 = 772. CHK-C01-085 (finding 1) and CHK-C01-086 (finding 5) report the same 772 `ok` and 0 `BAD`, with nothing skipped, at `3ff0460`, with the same three blobs. Apart from the new section, only three earlier lines changed, in wording or count (CHK-C01-085 finding 1).

### B3. The working session's report after the sync (L-234)

This is N-173 (e)'s step for the session that syncs a guard change (A3).

- **The sync.** `tools/sync_worktree.sh` ran from 16:33:34Z to 16:33:35Z ("SYNC OK: e9fc0a4 = origin/main").
- **Before the sync,** the last decision record was #8919 (16:33:34Z, the sync's own call).
- **After the sync,** the first was #8920 (16:33:37Z, allowed), then #8921 (16:33:37Z, allowed).
- **Checked against the decision log.** This addendum's producer read records #8917 to #8923 in the session's decision log on 2026-10-11 between 16:38Z and 16:44Z.
  - The times and decisions of #8919 to #8921 match L-234. #8920 is the working session's own call; #8921 is a subagent's.
  - #8922 (16:33:48Z, a deny) and #8923 (16:33:50Z, an allow) are further decisions after the sync.
  - L-234 calls #8918 (16:33:31Z) "the report before it". The log has #8918 as a subagent's call, and the working session's own previous record is #8917, at the same second. Nothing here turns on it.
- **The live tree.** The working session's three guard files are byte-identical to those at `e9fc0a4` (`cmp`, 2026-10-11, just before 16:43:47Z).
- **What this shows:** in the working session after the sync, the settings load, and the guard, with its marker, is live.
- **What it does not show:**
  - That the platform reads the marker as no decision. Neither user tool has been called in the working session since the sync: the decision log has no record for either after 16:33:35Z (this producer's search, between 16:38Z and 16:44Z).
  - That the platform applies `onFailure` (A4).

### B4. The break tests: the guard denies when it fails

CHK-C01-085 (finding 4) broke the guard beyond the test's own set.
- **The broken guard files:**
  - an empty file;
  - byte cuts at a quarter, a half and three quarters;
  - cuts before the first top-level definition past a quarter, a half and three quarters;
  - a guard that prints a stray line before its answer;
  - a guard that prints only a newline.
- **The runs.** Each file was put into both live hook commands. Each was run on an ordinary call and on a user tool, under both events and both shells: 9 files × 8 = 72 runs.
  - Every one was denied.
  - On `PreToolUse`, that was exit 2 with the command's reason on standard error.
  - On `PermissionRequest`, it was exit 0 with the command's deny in that event's form.
- **The contrast.** Run alone, six of the files exit 0 with no output: the empty file, the half cut, the three definition cuts and the newline guard. The quarter and three-quarter cuts exit 1.
  - Under the commands as they were before the change, the same six give exit 0 with no output on both events: N-185 reproduced.
  - The stray-line guard gives plain text on `PreToolUse`.
- **The test's sensitivity.** The suite was run against a copy of the corrected guard with only the marker's print removed. It ends `ALLOWLIST_TEST FAIL`, and its N-185 lines turn `BAD`.
- **CHK-C01-086** (finding 5) ran its own combinations of the old and new commands with an empty, an old and a new guard.
  - With the new commands, an empty guard is blocked on `PreToolUse` and denied on `PermissionRequest`.
  - So, on both hooks, are the marker followed by an extra line and the marker with exit 1.
- **The level.** These are a checker's runs: a fresh-context subagent of the same session (declared, Ek A 5.3), at `3ff0460`, whose three guard files are those of `e9fc0a4`.
  - They are not part of DevOS's own test, and this addendum did not repeat them.
  - DevOS's own test covers the empty file and two cuts, on both events and both shells (B2).
  - The stray-line and newline-only cases are covered by the checker's runs only. CHK-C01-085 suggested two test controls for them, which L-233 takes to W-C01-45's guard change.

### B5. Facts taken from the documentation (PC-21 item 9)

The source is the Claude Code hooks page, https://code.claude.com/docs/en/hooks.
- CHK-C01-086 (finding 2) fetched it on 2026-10-11 at 16:21:59Z: 4159 lines, SHA-256 `3a1f944503d05a61fdc0fac62add9ba3d877ccb03dd4ef9c3c79881c973938ef`.
- This addendum's producer read the quoted lines in that fetched copy on 2026-10-11 between 16:38Z and 16:44Z. It did not fetch the page again.
- Line numbers refer to that copy.

The facts:
- **Plain text at exit 0 is no decision.**
  - The table under "Exit code output" gives "Plain text, or nothing" at exit 0 the outcome "Success" (hooks.md:790, 794).
  - "Exit code 0 with no output means the hook has no decision to report, so the tool call continues through the normal permission flow" (hooks.md:227).
  - Output "that doesn't start with `{`" is plain text (hooks.md:815).
  - Neither guard event is among the events with their own rules (hooks.md:796-802).
  - Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- **`onFailure`.**
  - "Plain-text stdout from a command hook isn't a failure" (hooks.md:922).
  - With `"block"`, "a failure does what exit code 2 does on that event, except on `PermissionRequest`, where it denies the request" (hooks.md:924).
  - On `PreToolUse`, exit 2 "Blocks the tool call" (hooks.md:937).
  - On `PermissionRequest`, "Exit code 2 isn't honored for this event and the permission flow proceeds unchanged. Deny through the `decision` object instead" (hooks.md:938).
  - Guaranteed by platform (documented in https://code.claude.com/docs/en/hooks, read 2026-10-11); not independently tested.
- **The claim no test observes.** The platform reads the marker as no decision, so the two user tools still reach the user.
  - It rests on the page above; B3 does not observe it.
  - If the page is wrong, only those two tools are affected (CHK-C01-085 findings 3 and 8).
  - The marker is not JSON, so the platform cannot read it as an allow. A misreading could stop a user tool, but never let a call through. It does not bear on the three properties.
- **Qualifiers:**
  - Plain text at exit 0 is "Success" with no decision fields. It is no decision, not an allow, and the normal permission flow runs.
  - It is not an `onFailure` failure either. That is why the hook commands deny an empty answer, rather than the setting.
  - `onFailure` requires Claude Code v2.1.295 or later. The page does not say what an older version does with it (A4).
  - PC-21 item 9's qualifiers stand as listed in A4.

### B6. The named residual: any stray output line now fails closed

CHK-C01-085 (finding 6) names it.
- **What it is.** Anything that prints to standard output, other than the guard's own answer, now has every call blocked or denied.
  - This covers a print when the interpreter starts, from a site or user customization file or a path file.
  - It also covers a future stray print in the guard.
  - Before the change, such output gave no decision, and the call went on to the normal flow.
- **Why it is a residual, not a gap.** It fails closed, not open, so it does not count against property (c). It is a risk of locking out the working session (working order section 10).
- **Its likelihood.** The checker found nothing in this container that produces such output. A session would have to write into the interpreter's site directories to cause it. The lock-out would be local to the container, not merged into `main`.
- **Two smaller points** (the same finding):
  - **A pre-existing vector.** With the interpreter set to turn warnings into errors, the `SyntaxWarning` at guard line 1026 becomes an error, and every call is blocked, before and after the change alike. That setting is not set here. L-233 takes the fix to W-C01-45's guard change.
  - **Form breadth.** The `PreToolUse` command's form check accepts any text that ends as its answer does. The checker judges this form-level only, and not a realistic output.

### B7. Evidence envelope for this addendum (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `e9fc0a41fcde2cbb58c0db19eb12fd1b6c81cef3` (PR #238). Blobs: `.claude/settings.json` `b7033747bf9d788251b208bd4ee274b0677cdb98`, `.claude/hooks/tool_allowlist.py` `1f3a8f0868d586d2216ae6b36ea2d717715ebcd4`, `tools/test_tool_allowlist.sh` `cffd6ddd916fe12364365548ed4875613b8a5fe3`. They are byte-identical at `3ff0460` (CHK-C01-085, CHK-C01-086), `747441c`, `e9fc0a4` and `ec4429a` (`git ls-tree`). The working session's live files are the same (B3) |
| Deployment configuration | The guard is run as a plain process, outside the platform. The test reads both guard hook commands and matchers from `.claude/settings.json`, with their `onFailure` and timeouts (test:20-26, 43-67). It runs the commands under `/bin/sh` (dash), and the `PermissionRequest` faults and N-185's section under bash as well (test:999, 1059). The run was made in a fresh clone of `main`, in the Linux container of the working session `session_01XyxvJd3RayQk4HCrjurbVH`. The container has Python 3.13.16, bash 5.2.21 and git 2.43.0 (read by this addendum's producer). The inputs are the test's own synthetic fixtures. How the platform applies the settings is covered in B3 and B5 |
| Criterion version | W-C01-38's acceptance block, unchanged since `44cef4e` (W-C01-31, 2026-10-10). `plan/work/W-C01-38.md` is blob `10bf47b31770f289d9b9225110183fcf9ded1070` from `a177d28` to `ec4429a`. Its SHA-256, from `<!-- acceptance -->` to `<!-- /acceptance -->` inclusive, each line with its newline, is `d3c6f62ba810dddb0a05f8cec52c757ef600dcc4b27f513b2f763434e57af4f7`. That holds at `44cef4e`, `a9f62f5`, `3ff0460`, `e9fc0a4` and `ec4429a`, as CHK-C01-086 (finding 9) gives it. A6's `595b3ea…` is the same text without its final newline. It is read with plan C01 row 9 (plan line 953 at `ec4429a`), the PC-21 note's items 5 and 9 (lines 969 and 973), plan Section 8 items 7, 9 and 14 (lines 836, 838 and 843), and D-017 items 2 and 3 |
| Input | `bash tools/test_tool_allowlist.sh`, run by the executor from 16:34:01Z to 16:36:27Z (B2). CHK-C01-085's 72 break runs (B4). Decision records #8917 to #8923 (B3). The hooks page as fetched by CHK-C01-086 (B5) |
| Actual observation | The test: 772 `ok`, 0 `BAD`, 0 `info`, no control skipped, `ALLOWLIST_TEST PASS`, exit 0. The guard after the sync: live (#8920 and #8921 allowed). The break runs: all 72 denied |
| Raw evidence ID | SHA-256 of the run's standard output `50d85fe5c6ef161751e6d1b0e63d1aae75f28ede299ea42ad9005f6e51930028` (773 lines) and of its standard error `d18e9bb6a144b8a212735a14e52d7c41124470158efadd3bee767376db254ff5` (26 lines). This addendum's producer computed them from the files saved in the scratchpad of session `session_01XyxvJd3RayQk4HCrjurbVH`. The files are kept only there, not in the repository (point 3). The break runs' output is in the same scratchpad, as CHK-C01-085 lists it. The decision records are in the session's hash-chained decision log. A re-run gives the same counts, not the same bytes, because the output carries temporary paths |
| Independence level | The run is the same session's own test (plan Section 8 item 7): DevOS's deterministic unit test, run by the executor in a fresh clone. The break tests and the documentation reading come from two fresh-context checker subagents of the same session (CHK-C01-085, CHK-C01-086; declared, Ek A 5.3). This addendum was written by a fresh-context producer subagent of the same session, which re-counted the run's saved output and read the decision log and the fetched page. It shares the test, the page and the checkers' framing, and adds no break test or test run of its own. It is judged by a later fresh-context checker (declared, Ek A 5.3; PC-06) |

### B8. The block, point by point, against the record as it now stands

**Point 1 (a). It denies a tool not on its list: met, as in A7.**
- N-185's change touches no rule (B1).
- The run of record passes with 0 `BAD`, so A7's lines hold at `e9fc0a4`. The matchers are now at test:28-32 (18 `ok`), and the made-up name at test:135.
- The positive control holds as well: ordinary calls are allowed, here and in N-185's section.

**Point 1 (b). It never answers "ask": met, as in A7.**
- The test's search of every guard output for `"ask"` passes (test:938).
- The guard's answers are now allow, deny and the plain-text marker. The marker is no decision (B5), not an "ask".
- A search of the guard for `"ask"` finds nothing.
- Both commands write only a deny of their own.

**Point 1 (c). It denies when it fails or runs past its own time limit.** It is met for every case this record found failing, N-185 included. Under reading R2, the platform's part rests on documentation only, for the checker.

| Case | Shown by | Result |
|---|---|---|
| Every case in A7's table except N-185 | The run of record passes with 0 `BAD` on the same lines (B2) | as in A7 |
| An empty or truncated guard file (N-185) | DevOS's own test denies an empty file and two truncated copies in each event's form, under both shells (test:1049-1066; 12 `ok`). Two controls show that two of these files exit 0 with no output when run alone. Plain text that is not the marker, and an answer in the other event's form, are denied too (6 `ok`). A checker's 72 break runs, on 9 broken files, were all denied (B4) | met (before: not met, A5) |
| A guard hook reaches its platform timeout, or its shell cannot start (reading R2) | Unchanged from A7. The test shows the setting on both hooks (test:55-67, test:53-65 at `a9f62f5`). The platform's part is documented only (A4) | as in A7: DevOS's code is shown; the platform's part is not counted as observed (D-017 item 3); under R1 it lies outside the property. The checker judges this |

**Point 1, the record of the run: met.** The run of record is recorded with its commit (`e9fc0a4`) and its counts: 772 `ok`, 0 `BAD`, no control skipped (B2, B7).

**Point 1's result: met under reading R1.** Under reading R2, the platform's part at the timeout rests on documentation alone (A7). The checker judges the reading.

**Point 2. The fail path, then the tests run again: met.**
- **For N-173's cases:** as in A7.
- **For N-185:**
  - The guard was corrected through the merge gate, with two fresh-context verdicts whose one condition is met (B1).
  - This happened before C02 opens DevOS's environments.
  - The tests were run again on `main`, with no control skipped (B2).
  - The working session's guard is live after the sync (B3).
- **For the checker.** The verdicts are at `3ff0460`. The merged head, `747441c`, adds to it only the verdict files, the log, `plan/work/C01.md` and the generated files. The condition was confirmed at that head by the executor's checks (L-233), not by a further verdict. The guard files merged are those the verdicts judged (B1).

**Point 3. No rule detail beyond the three properties and the counts: met.** The checker judges this.
- This addendum names no rule, no rule ID and no fixture content. It quotes no denial text, and not the marker's text.
- It cites test, settings and guard lines by number only.
- It copies only the run's final line and its counts.
- It describes the change and the break tests only as far as property (c) needs: what the guard prints for "pass", what the commands pass on and what they deny, and which kinds of broken guard file were denied.

**The last paragraph.**
- **The evidence envelope:** met (B7 here; A6 and the first envelope for the earlier runs).
- **PC-21 item 9's claim:** met. Every documentation fact carries its source, its reading date, "not independently tested" and the qualifiers (B5; A4; "Facts taken from the documentation" above). The checker judges this.
- **A fresh-context checker at a fixed head, with its independence level:** not yet. W-C01-38's acceptance waits on that verdict (CHK-C01-062 C3).

### B9. What this addendum cannot show, and the result

- **The platform's side.** That the platform reads the marker as no decision, and that 2.1.296 applies `onFailure`, rest on documentation (B5, A4). No call to either user tool has been made since the sync (B3).
- **The break tests** are a checker's runs, not repeated here (B4).
- **Freshness.** The result is tied to the three blobs in B7.
  - W-C01-45's guard change will change them (L-233). It needs a new run before C02 opens DevOS's environments (N-174 on `plan/work/C02.md`).
  - C03 test 3 tests the guard again (PC-21 item 5).
- **The warning.** The `SyntaxWarning` is unchanged apart from its line number, now guard line 1026. It changes no decision here.

| Point | Result | Where |
|---|---|---|
| 1 (a). The tests show that it denies a tool not on its list | met | B8 |
| 1 (b). It never answers "ask" | met | B8 |
| 1 (c). It denies when it fails or runs past its own time limit | met for every case the record found failing, N-185 included, by DevOS's own test, with a checker's 72 break runs. Under reading R2, the platform's part at the timeout rests on documentation only (D-017 item 3), for the checker | B2, B4, B8 |
| 1. The run is recorded with its commit and its pass and fail counts | met: `e9fc0a4`, 772 `ok`, 0 `BAD`, no control skipped | B2, B7 |
| 2. Corrected through the merge gate before C02 opens DevOS's environments, and the tests run again | met, for N-173's cases (A7) and for N-185 (PR #238, `e9fc0a4`; CHK-C01-085, CHK-C01-086; the re-run; the report after the sync) | B1 to B3 |
| 3. No rule detail beyond the three properties and the counts | met, for the checker to judge | B8 |
| Last paragraph: envelope, PC-21 item 9's claim, a fresh-context verdict | envelope and claim met; the verdict is still to come | B5, B7 |

- **Not accepted here.** This addendum does not accept W-C01-38. A fresh-context checker judges it against the unchanged block at a fixed head (CHK-C01-062 C3).
- **For the checker:**
  1. the reading of "its own time limit", R1 or R2 (A7);
  2. whether DevOS's own test, with the checker's break runs, shows N-185's case;
  3. point 3;
  4. the claims in B5 and A4;
  5. whether the verdicts at `3ff0460`, with their condition confirmed by the executor at `747441c`, are point 2's fresh-context verdict for the change as merged;
  6. whether B6's residual lies outside property (c).
- **No plan change and nothing for Batu.** No change to `plan/DevOS_Kurulum_Plani.md` follows. No decision is Batu's (D-003; D-008).
