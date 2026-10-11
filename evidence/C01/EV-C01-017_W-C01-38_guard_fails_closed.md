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
