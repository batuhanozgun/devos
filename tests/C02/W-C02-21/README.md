# W-C02-21 · Tests of the guard's denial of `Monitor` (rule T1)

Synthetic test data (plan Section 8 item 13). Every input is made up for the test. The hosts are under the reserved `.invalid` top-level domain, which resolves nowhere. The commands are strings inside hook inputs, and nothing runs them. The names that are not made up are DevOS's own file paths, the guard's rule IDs and the platform's tool names.

## 0. What this is

- **Serves** `plan/work/W-C02-21.md`: points 1 and 2 (the cases), point 3 (the breaks, section 3 here) and point 8 (form C0, section 2). Points 4 to 7, 9 and 10 are the record's and the checker's, not tests.
- **Written** by the test designer (a fresh-context `test-designer` subagent that does not produce the change) on 2026-10-13. It was written from the guard at `main` `326269983e2608355ebf85e8d8a51f690c59b256`, before any change to the guard exists.
- **Files.** The cases are one block of `tools/test_tool_allowlist.sh`, headed `# --- W-C02-21`, next to the suite's other tool-list and `PermissionRequest` cases. This file holds their form-C0 text and the breaks. The same change withdraws W-C02-20's two `Monitor` cases from `tools/test_token_stop.py` (`tests/C02/W-C02-20/README.md` section 11).
- **How to run.** At a checkout's root: `bash tools/test_tool_allowlist.sh`. Each case prints `ok   ` or `BAD  `, then `W21-<case ID>`, the tool, the expected decision and rule, the event, and a label. The suite's last line, `ALLOWLIST_TEST PASS` or `FAIL`, counts these cases with all the others.
- **Case IDs.**
  - `W21-x-*`: what the change must deny; each is `BAD` against a guard that allows `Monitor`.
  - `W21-c-*`: input the guard cannot read at all; these are controls of the fail-closed path.
  - `W21-ok-*`: the positive controls.
  - `W21-x-list`: a structural check of the list.
- **Expected against the guard at `3262699`** (`Monitor` on `ALLOWED_NON_MCP`): every `W21-x-*` line is `BAD`, and every `W21-c-*` and `W21-ok-*` line is `ok`.

## 1. The facts the tests are written to, and the readings this file takes

**Fixed by the executor** (decided 2026-10-13; recorded in the item):
1. The remedy takes `Monitor` off `ALLOWED_NON_MCP`, so that rule T1 denies it like any tool not on the list. Running its `command` through the shell rules was not chosen.
2. Nothing in the installation needs `Monitor`. Waiting uses `Bash` with `run_in_background`, or `send_later`.

**Platform facts used** (labels as the plan uses them):
- The tool's schema, read by the executor through the tool-search tool on 2026-10-13 (observed): `command` is "Shell command or script. Each stdout line is an event", and "The script runs in the same shell environment as Bash". `ws` is "WebSocket to open", with any `url`.
- The tools reference, `https://code.claude.com/docs/en/tools-reference.md`, read 2026-10-13 by this designer (documented, not independently tested):
  - "A WebSocket watch takes a `ws` input in place of `command`, and a single Monitor call can't combine the two." `ws` has `url` and `protocols`.
  - "Opening a WebSocket prompts for approval": in these sessions the guard answers that prompt on `PermissionRequest`.
  - "When Monitor runs a command, it uses the same permission rules as Bash." That is Claude Code's permission layer, and `.claude/settings.json` has no `Bash` rule (76 deny entries, none naming `Bash` or `Monitor`; read with a JSON reader).

**Readings this file takes.** Each is the designer's decision, and a checker may judge it.
- **R1 "Whatever its input."** Point 1 (a) to (d) is read as every input shape the tool's schema allows, and the shapes it does not allow:
  - a command, harmless or banned under `Bash`;
  - a WebSocket;
  - neither field, or both fields;
  - fields of the wrong type, and fields the schema does not name.

  The platform may refuse some of these shapes before any hook runs (for example both fields together). The guard must deny them anyway, because the test does not rely on the platform's validation.
- **R2 The rule must be T1.** An answer that denies `Monitor` by another rule fails the case. The reason: a denial that comes from reading the input (a B rule, G0) means that some other input could pass. Break (iv) shows this. T1 is the rule the executor's decision names.
- **R3 Point 1 (e): input the guard cannot read at all.** The guard checks the input's form before it weighs the tool's name (`decide()`, lines 2006 to 2015). So such an input is denied before T1 is reached, as for any tool not on the list. With a NUL byte the guard answers G0 with the full denial text, and the case `W21-c-nul` asks for G0 or T1.
  - With a `tool_input` that is a string or a list, the guard at `3262699` decides G0. It then fails while it builds the denial: `summary()` calls `.items()` or `.get()` on the input (lines 434 to 441). So the call is blocked (exit 2) on `PreToolUse`, and the settings wrapper denies it on `PermissionRequest` ("failing closed"). Neither answer carries the rule's text, and neither leaves a log record. This holds for every tool, not only `Monitor`: the designer's probe gave the same G0 decision for `SendMessage` with such an input.
  - The cases `W21-c-input-string` and `W21-c-input-list` accept a deny, or the fail-closed block on `PreToolUse`, and nothing else. They run apart from the suite's `$OUTS`, so the suite's checks of every denial's text and of the decision log do not count this known defect against the change.
  - The defect is reported to the executor (section 5). It is not this item's to fix.
- **R4 The list, by name.** `W21-ok-list` compares the guard's `ALLOWED_NON_MCP` with a literal list: the 28 names on it at `3262699` other than `Monitor`. A later reviewed change to the list must update `W21_LIST` in the same change. That is deliberate, since the list is the guard's T1 rule.
- **R5 Point 2's comparison with the base.** W-C02-20's tests are on the same branch, and their ✘ cases stay `BAD` until W-C02-20's stop exists. So W-C02-21's head can show "no `BAD` line" only if W-C02-20 is merged first. Point 2 therefore compares the run at the head with the run at the base:
  - the `W21-*` lines are all `ok` at the head;
  - every other line has the same status at both commits;
  - every `BAD` left belongs to an item whose change is not merged.

  To compare, run the suite at both commits and diff the sorted `BAD` lines (`grep '^BAD'`). The labels print no temporary path or random value for the `W20-*` and `W21-*` cases.
- **R6 Terminology.** Appendix C's form C0 calls "Negative control" the check that the wrong solution is caught, and "Positive control" the check that the right solution is allowed. The item's ✘ cases fill "Negative control" and its ✔ controls fill "Positive control".

## 2. Form C0

### T-W21-1 · Every Monitor call is denied by rule T1

| Field | Content |
|---|---|
| **ID and claim** | T-W21-1 (`W21-x-*`). The guard denies every `Monitor` call by rule T1, on `PreToolUse` and on `PermissionRequest`, whatever the call's input. |
| **Failure class rule** | A tool the guard allows by name whose input runs a command or opens a network connection, which none of the guard's shell or network rules reads (point 5 of the item names the class's other routes). Here: any input with which `Monitor` gets an answer other than T1's denial, whether allow, pass, or a denial by a rule that reads the input. |
| **Examples** | 14 inputs, each on both events (28 lines). (1) The original finding: a harmless command (`x-cmd-harmless`), and commands that `Bash` is denied under B6, B1 and B8 (`x-cmd-b6`, `x-cmd-b1`, `x-cmd-b8`). (2) Another manifestation, the network: two WebSocket watches (`x-ws-wss`, `x-ws-protocols`). (3) No field, or both: `x-neither-empty`, `x-neither-desc`, `x-neither-noinput`, `x-both`. (4) Input the guard cannot read as a `Monitor` call: `x-cmd-unparsed` (G0 under `Bash`), `x-cmd-not-string`, `x-ws-not-object`, `x-unknown-fields`. |
| **Negative control** (C0: the wrong is caught) | Each `W21-x-*` line is `BAD` unless the answer, in its event's form, is a deny that names T1. Against the guard at `3262699` every one is `BAD` (`got=allow by T1`; section 7). `W21-x-list`: `Monitor` is on neither `ALLOWED_NON_MCP` nor `USER_TOOLS`, and no allowed MCP prefix covers it. |
| **Positive control** (C0: the right is allowed) | T-W21-2. |
| **Break attempt** | Section 3: (i) to (iv). |
| **Stage and environment** | C02. Any checkout of `devos` at the head under test, with Python 3, git and a POSIX shell. No network, no credential. The guard runs through `.claude/settings.json`'s two wrapper commands, as the rest of `tools/test_tool_allowlist.sh` runs it. |
| **Independence level** | Written by the test designer (a fresh-context subagent, not the producer). Run against `main` and against a stand-in by the designer as a self-check (section 7). The fresh-context checker of the item's point 10 runs it at the head, with the breaks. Shared with the producer: the acceptance block, the executor's decision and the model lineage. Not shared: the change's code (it did not exist). |
| **Evidence layer** | Structural: the guard's decision on synthetic hook inputs. Not behavioural: whether the platform runs the hook for a real `Monitor` call and honours its deny is shown only by the item's point 6 (the live try). |
| **Evidence envelope** | Target commit: the head judged. Configuration: the blobs of `.claude/hooks/tool_allowlist.py`, `.claude/settings.json` and `tools/test_tool_allowlist.sh`. Criterion version: the `main` commit of the item's acceptance block. Input: the block's case list. Observation: the run's raw output. Raw evidence ID: the executor's, in the record. |

### T-W21-1e · Input the guard cannot read at all is never allowed

| Field | Content |
|---|---|
| **ID and claim** | T-W21-1e (`W21-c-*`). A `Monitor` call whose input the guard cannot read at all is denied: by G0 (or T1) with a NUL byte; by a deny or the fail-closed block when `tool_input` is not an object. |
| **Failure class rule** | A check that cannot read its input and answers "allow" (plan Section 8 item 14). |
| **Examples** | `c-nul` (a NUL byte in `command`), `c-input-string` (`tool_input` a string), `c-input-list` (`tool_input` a list); each on both events. |
| **Negative control** | Each line is `BAD` on an allow, a pass, or an answer in the wrong event's form. |
| **Positive control** | Not applicable: no right input of this kind exists. T-W21-2 holds the item's positive controls. |
| **Break attempt** | None of section 3's breaks turns these cases, because the guard's form checks run before the tool's name is weighed. That is the point: they hold before the change and after it. A guard that answered "allow" when it could not read the input would turn them `BAD`; the designer did not build that break (section 6). |
| **Stage and environment** | As T-W21-1. |
| **Independence level** | As T-W21-1. |
| **Evidence layer** | Structural. |
| **Evidence envelope** | As T-W21-1. |

### T-W21-2 · The controls: nothing else changed

| Field | Content |
|---|---|
| **ID and claim** | T-W21-2 (`W21-ok-*`). Taking `Monitor` off the list changes no other decision. `Bash` with the same commands decides as before. Every other listed tool is still on the list and is denied by T1 on neither event. The hooks' matchers still cover `Monitor`, so the guard sees every `Monitor` call. |
| **Failure class rule** | A fix that closes the gap by widening a denial: another tool dropped from the list, `Bash` denied, or a matcher narrowed so that the hook no longer runs. Also a case that does not hold what its label says (a "banned" command that is not banned under `Bash`). |
| **Examples** | `ok-bash-harmless` (allowed, B0); `ok-bash-b6`, `-b1`, `-b8`, `-unparsed` (denied by B6, B1, B8 and G0; `-b1` accepts B3 too, because in a clone whose `origin` is a local path, B3, "pushes only to claude/ branches of devos", fires before B1); `ok-list` (the 28 other names, exactly, and `USER_TOOLS` unchanged); `ok-listed <tool>` for each of the 28 names (one line each, both events); `ok-matcher` (both matchers). |
| **Negative control** | Each `ok-*` line is `BAD` when its decision changes: `Bash` denied, a listed tool denied by T1, a name missing or added, a matcher that does not match `Monitor`. |
| **Positive control** | The same lines `ok` at `3262699` and at the stand-in (section 7). |
| **Break attempt** | Break (v), the designer's: the stand-in with `WebSearch` also taken off the list turns `ok-list` and `ok-listed WebSearch` `BAD` (section 3). |
| **Stage and environment** | As T-W21-1. |
| **Independence level** | As T-W21-1. |
| **Evidence layer** | Structural. |
| **Evidence envelope** | As T-W21-1. |

**Format gate.** None of these tests is a format gate. `ok-list` compares names, not whether a field is filled. The item's point 4 (every hit of the search with a disposition) is a record that the checker reads in full. A disposition that is filled but meaningless, for example "true as written" with no reason, is the checker's to find there, by sample review. No test here judges it.

## 3. The breaks (item point 3), as specifications

**How each is built.** Clone the head, so that the guard reads that tree's own `.claude/` (its `ROOT` is two directories above the hook). Edit only `.claude/hooks/tool_allowlist.py` there. Run `bash tools/test_tool_allowlist.sh` at that clone's root, each break on its own. Each must end `ALLOWLIST_TEST FAIL` with the named cases `BAD`. The unchanged head must show every `W21-*` line `ok` again after.

| Break | The edit (in the head's guard) | Cases that turn `BAD` | Cases that stay `ok` |
|---|---|---|---|
| (i) `Monitor` back on the list | Add `"Monitor"` to `ALLOWED_NON_MCP` (the state at `3262699`) | every `W21-x-*` (28 lines, `got=allow by T1`) and `W21-x-list` | every `W21-c-*` and `W21-ok-*` |
| (ii) allowed by a branch of its own | Before `if name in USER_TOOLS:` in `decide()`, return allow for `Monitor`; the list unchanged | every `W21-x-*` decision line | `W21-x-list` (so the decision cases carry the claim), every `W21-c-*` and `W21-ok-*` |
| (iii) passed to the user | Add `"Monitor"` to `USER_TOOLS` | every `W21-x-*` decision line (`got=pass`), `W21-x-list`, and `W21-ok-list` (`USER_TOOLS` changed) | every `W21-c-*` and every other `W21-ok-*` |
| (iv) the alternative not chosen | `Monitor` kept on the list; in `decide()`, before the `Bash` branch, its `command` passed to `shell_checks()` as `Bash`'s is, then allowed | allowed: `x-cmd-harmless`, `x-ws-*`, `x-neither-*`, `x-both`, `x-ws-not-object`, `x-unknown-fields`. Denied by the reading rule, not T1: `x-cmd-b6` (B6), `x-cmd-b1` (B1, or B3 where `origin` is not `devos`), `x-cmd-b8` (B8), `x-cmd-unparsed` (G0). `x-cmd-not-string`: allowed or denied, by the rule its text gets. Also `W21-x-list` | every `W21-c-*` and `W21-ok-*` |
| (v) designer's: one more name removed | The stand-in (`Monitor` off) with `"WebSearch"` also removed | `W21-ok-list`, `W21-ok-listed WebSearch` (and W-C02-20's `P2N-n-read-ws`, which needs `WebSearch` allowed) | every other `W21-*` |

Section 7 gives the designer's observed result of each break.

## 4. Clause table

| The item's text | Cases |
|---|---|
| 1 (a) a command, harmless and banned under two or more rules | `x-cmd-harmless`, `x-cmd-b6`, `x-cmd-b1`, `x-cmd-b8` |
| 1 (b) a `ws` watch, `wss://` and `ws://` with `protocols` | `x-ws-wss`, `x-ws-protocols` |
| 1 (c) neither field (three forms), and both | `x-neither-empty`, `x-neither-desc`, `x-neither-noinput`, `x-both` |
| 1 (d) an input the guard cannot read as a Monitor call | `x-cmd-unparsed`, `x-cmd-not-string`, `x-ws-not-object`, `x-unknown-fields` |
| 1 (e) input the guard cannot read at all | `c-nul`, `c-input-string`, `c-input-list` |
| 1: "on `PreToolUse` and on `PermissionRequest`", "names rule T1" | every case runs on both events; the rule is read from the answer (R2) |
| 1: `BAD` against `3262699` | section 7 |
| 2: `Bash` with the same commands | `ok-bash-*` |
| 2: the list, `USER_TOOLS`, no MCP prefix | `ok-list`, `x-list` |
| 2: each other listed tool not denied by T1 | `ok-listed *` |
| 2: the matchers | `ok-matcher` |
| 2: the suite at the head against the base | R5; the checker's comparison |
| 2: the guard's diff and the reason beside the list | the checker's reading (not a test) |
| 3 (i) to (iv) | section 3 |
| 8 form C0, written first, synthetic | this file |

## 5. Found while writing: reported, not tested here as a requirement

- **The guard fails on a `tool_input` that is not an object** (R3). At `3262699`, `decide()` answers G0. Then `deny_text()` calls `summary()`, which reads the input as an object and raises, so `main()` exits 2. The call is blocked on `PreToolUse` and denied by the wrapper on `PermissionRequest`. This is fail closed, so it is not a hole, but the denial carries no rule and no "What to do instead", and the decision log has no record of the call. It holds for every tool. Whether the platform ever sends such an input is not known. The executor decides whether it becomes a note or an item.
- **Monitor's line in the platform's tools reference about plugins.** "Plugins can declare monitors that start automatically when the plugin is active". Such a monitor runs a command with no tool call, so no guard rule sees it. The item's point 5 asks the record to name its layer.

## 6. What these tests do not cover, and why

- **The live call** (item point 6): the executor's, after the merge. These tests show the guard's decision, not that the platform runs the hook and honours the deny for a real `Monitor` call.
- **The records and the sweep** (item points 4, 5 and 7): records, read by the checker.
- **A `Monitor`-specific "What to do instead".** T1's generic text is not tested for content.
- **The platform's own refusals** (for example a `ws` URL to a private address, which the reference says Claude Code denies). The guard must deny regardless, so no case relies on them.
- **A guard that allows what it cannot read** (a break of T-W21-1e): not built. The existing suite's `t deny 'garbage'` and the fault-injection section cover the fail-closed path in general.
- **Other routes of the same failure class** (item point 5): stated in the record, not tested here.

## 7. Self-check by the test designer (not a result)

All runs were on 2026-10-13. Each ran the whole `bash tools/test_tool_allowlist.sh`, W-C02-20's `tools/test_token_stop.py` included. The guard was probed first by calling its `decide()` with no wrapper and no log, then by the suite.

- **Against the guard at `main` `3262699`** (blob `956f1b3`), in the executor's scratch clone `cw90`: branch `claude/c02-w20-stop` at `a2e5a53` plus this change, uncommitted, with `origin` the GitHub repository.
  - Every `W21-x-*` line was `BAD`: 14 inputs on 2 events, 28 lines, all `got=allow` (by T1 on `PreToolUse`). `W21-x-list` was `BAD` too, 29 in all.
  - Every `W21-c-*` and `W21-ok-*` line was `ok`, 47 in all. `c-input-string` and `c-input-list` read `got=block` on `PreToolUse` and `got=deny (failing closed)` on `PermissionRequest` (R3). `ok-bash-b1` was denied by B1.
  - No `BAD` line outside `W20-*` and `W21-*`.
  - Suite totals: `ok` 977, `BAD` 307 (W-C02-20's 278 and W-C02-21's 29), `info` 26. Last lines: `TOKEN_STOP_TEST FAIL (ok 109, BAD 278, info 25)`, `ALLOWLIST_TEST FAIL`.
- **The stand-in for the change** (the guard with `"Monitor"` taken off `ALLOWED_NON_MCP`, nothing else). It was made only to show that the cases can pass, in a scratch clone of `cw90` plus this change, and deleted after. Every `W21-*` line was `ok` (76 lines).
  - Outside the `W21-*` lines, every line had the status of the same run with `main`'s guard in a scratch clone of the same kind. In such a clone two pre-existing push controls answer `BAD`, because `origin` there is a local path. That is not this change's doing, and the same holds with `main`'s guard.
  - Suite totals: `ok` 1004, `BAD` 280 (W-C02-20's 278, which wait for its stop, and the two push controls), `info` 26. Last lines: `TOKEN_STOP_TEST FAIL (ok 109, BAD 278, info 25)`, `ALLOWLIST_TEST FAIL`. The `FAIL` comes from W-C02-20's cases and the clone's `origin` only (R5).
- **The breaks**, each in its own scratch clone of the same kind, and each turning `ALLOWLIST_TEST` to `FAIL`. Breaks (ii) to (iv) ran with an earlier text of this block whose `ok-bash-b1` accepted B1 only, so in those clones that control also read `BAD` (B3, the clone's local `origin`). That control is in no break's list, and the final text accepts B1 or B3. Outside the `W21-*` lines, each break's run had the same `ok`, `BAD` and `info` counts and the same `BAD` lines as `main`'s guard in a clone of the same kind (928, 280 and 26).
  - (i) `Monitor` back on the list: the stand-in with the name restored is `main`'s guard, byte for byte (the stand-in's diff from `main` is that one name). Its result is the first bullet: all 28 decision lines and `W21-x-list` `BAD`.
  - (ii) A branch of its own: all 28 decision lines `BAD` (`got=allow by T1`); `W21-x-list` `ok`; every `W21-c-*` and every other `W21-ok-*` `ok`.
  - (iii) `USER_TOOLS`: all 28 decision lines `BAD` (`got=pass`); `W21-x-list` and `W21-ok-list` `BAD`; every `W21-c-*` and every other `W21-ok-*` `ok`.
  - (iv) The alternative not chosen: all 28 decision lines `BAD`.
    - Allowed by B0: `x-cmd-harmless`, both `x-ws-*`, the three `x-neither-*`, `x-both`, `x-ws-not-object` and `x-unknown-fields`.
    - Denied by B6, B3 (B1 where `origin` is `devos`), B8, G0 and G0: `x-cmd-b6`, `-b1`, `-b8`, `-unparsed` and `-not-string`.
    - `W21-x-list` `BAD`; every `W21-c-*` and every other `W21-ok-*` `ok`.
  - (v) `WebSearch` also removed, with the final text: `W21-ok-list` and `W21-ok-listed WebSearch` `BAD`, and every other `W21-*` line `ok`. Outside them, only W-C02-20's `P2N-n-read-ws` (an ordinary web search, on both events) turned `BAD`, as it should with `WebSearch` denied: `TOKEN_STOP_TEST FAIL (ok 107, BAD 280, info 25)`.
- **No format string in any run's output.** Each output was searched with both finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json`: no line matched. W-C02-20's cases print no input.
