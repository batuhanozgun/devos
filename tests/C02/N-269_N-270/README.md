# N-269 and N-270 · Tests of the guard's denial of a `tool_input` that is not an object, and of the class of the shared token folder

Synthetic test data (plan Section 8 item 13). Every input is made up for the test:
- the commands are strings inside hook inputs, and nothing runs them;
- the service name `Quorvantel` is invented, and it reaches the guard only through `DEVOS_SERVICE_NAMES_EXTRA`, for one call;
- the credential path is a random name in a temporary directory;
- each string of a DevOS token format is made at run time from `tests/C02/W-C02-07/shared/scan_patterns.json` and is never printed or written into a file of the repository.

The fixture files of the gate cases are made-up content. The names that are not made up are DevOS's own file paths, the guard's rule IDs and the platform's tool names. This file holds no token, no marker and no pattern of either format.

## 0. What this is

- **Serves** two notes on `plan/work/C02.md` (at `main` `f39c96f`), whose text is the acceptance of these changes:
  - **N-269**, "A `tool_input` that is a string or a list crashes the guard's denial". Its remedy: "`summary()` and the denial read a non-object input safely, with a case on each event, through a checked guard change".
  - **N-270**, "The guard's token stop reads its patterns from a class-normal path". Its remedy: "make that folder class high in `tools/merge_gate.py`, with gate cases in W-C02-19's form, through a checked change".
- **Written** by the test designer (a fresh-context `test-designer` subagent that does not produce either change) on 2026-10-13. It was written from the guard and the gate at `main` `f39c96f99b1fe070a1624943c2102ac50a1541e4`, before any change to either exists.
- **Files.**
  - N-269: one block of `tools/test_tool_allowlist.sh`, headed `# --- N-269`, right after the W-C02-21 block.
  - N-270: the function `shared_token_files()` of `tools/test_merge_gate.py` (cases `(N270*)`), called after `listed_paths()`, with a sentence in the module's docstring.
  - This file holds their form-C0 text, the breaks and what is not covered.
- **How to run.** At a checkout's root, run `bash tools/test_tool_allowlist.sh` and `python3 tools/test_merge_gate.py`.
  - N-269: each case prints `ok   ` or `BAD  `, then `N269-<case ID>`, the tool, the expected answer, the event and a label. A `BAD` line ends with its reasons in brackets; no line prints an input.
  - N-270: each case prints `ok  ` or `BAD `, then `(N270<letter>)` and its label.
  - The last lines, `ALLOWLIST_TEST PASS` or `FAIL` and `MERGE_GATE_TEST PASS` or `FAIL (n/m)`, count these cases with all the others.
- **Case IDs.**
  - `N269-x-*` and `(N270a)` to `(N270h)`, with the `p` cases: what the change must do. Each is `BAD` against `main` `f39c96f`.
  - `N269-ok-*` and `(N270n1)` to `(N270n5)`: the controls. They hold before the change and after it.
- **Expected against `main` `f39c96f`:**
  - every `N269-x-*` line is `BAD` (46), and every `N269-ok-*` line is `ok` (8);
  - every `(N270a)` to `(N270h)` line is `BAD` (14), and every `(N270n*)` line is `ok` (5);
  - every other line keeps its status.

## 1. The facts the tests are written to, and the readings this file takes

**Fixed by the executor** (the task of 2026-10-13, quoted; the producer builds to the same):
1. N-269: "For every tool, a `tool_input` that is a string or a list (or any non-object) is denied by G0, and the denial is built and printed in the event's form, naming rule G0, on `PreToolUse` and on `PermissionRequest`, and the call is appended to the decision log like any other decision. `summary()` and the denial read such an input safely. The call's text is shown only as other G0 denials show it (redacted, no format string of either token format reaches the output or the log). Nothing else changes."
2. N-270: "`tests/C02/W-C02-07/shared/` becomes class high in `tools/merge_gate.py`: a pull request that adds, changes or deletes a file under it needs a covering verdict, as for any class-high path; a file elsewhere under `tests/C02/W-C02-07/` stays class normal."

**Observed at `main` `f39c96f`** (the designer's probe of the guard through both settings wrappers, 2026-10-13):
- A `tool_input` that is a non-empty string, a non-empty list, a number, `true`, or a string holding an object's JSON gets G0 from `decide()`. `deny_text()` then calls `summary()`, which reads the input with `.get()` or `.items()` and raises. The result is the same for `Bash`, `Read`, `Monitor`, `mcp__github__get_me` and `AskUserQuestion`:
  - exit 2 on `PreToolUse`;
  - on `PermissionRequest`, the wrapper's deny, "failing closed";
  - no record in the decision log.
- A `tool_input` of `""`, `[]`, `0`, `false` or `null` is read as an empty object (`data.get("tool_input") or {}`), and decided as such: `Bash` allow B0, `Read` allow T1, `Monitor` deny T1, `mcp__github__get_me` allow M2. Each such call is logged.

**Readings this file takes.** Each is the designer's decision, and a checker may judge it.
- **R1 "any non-object".** The cases use the forms that reach G0 at `main`: a string, a list, a number, and a string that holds the JSON of the control's own object. The last is read as a string; a change that decodes it decides on text the platform did not send as an object. The empty forms are not judged, because fact 1 does not settle them (section 5, item 1).
- **R2 "in the event's form, naming rule G0".**
  - The answer is read only in its own event's form, as the suite's `decide()` reads it.
  - It must be the guard's own denial: its text starts `DevOS guard: DENIED by rule G0 (`, and it carries each part the suite asks of every denial ("What was attempted:", "Why this rule exists:", "Where it is written:", "What to do instead:", "Decision log: #"), and "What matched:".
  - The wrapper's fail-closed answer fails the case, and so does an exit 2 or a denial by another rule.
- **R3 "appended to the decision log like any other decision".**
  - Each call runs with a decision log of its own, and it must add exactly one record.
  - The record carries every field the suite's log check asks, and `prev` and `event`.
  - Its `event`, `tool`, `decision` and `rule` are the call's event, the tool, `deny` and `G0`. Its `reason` is the G0 denial.
  - The denial names the record (`Decision log: #<n> in`).
- **R4 "shown only as other G0 denials show it".** This is read as a ceiling, not a floor: a change that shows none of the call's text passes. The planted texts of `N269-x-shown-*` must reach neither the answer (stdout and stderr) nor the log. Each stands for one way other G0 denials keep text out:
  - `redact()`'s generic pattern (a value after `password=`);
  - `redact()`'s credential paths (`CLAUDE_SESSION_INGRESS_TOKEN_FILE`, set for that call only);
  - `withheld()`'s service names (a made-up name through `DEVOS_SERVICE_NAMES_EXTRA`);
  - and, for the clause "no format string of either token format", a string of each format. That check searches the answer and the log with both finders of the shared pattern file. The planted string is drawn so that no REDACT pattern masks it by chance, so only a change that keeps it out passes.
- **R5 W-C02-21's `W21-c-input-string` and `W21-c-input-list` are left as written.** N-269's text asks for "a case on each event" and does not ask to change W-C02-21's cases. W-C02-21 is accepted and its results have been seen, so changing its cases now is what ledger rule 3 and Appendix G G8 item 3 forbid. The stricter expectation for the same inputs is carried here: `Monitor` is the unlisted tool of `N269-x-*`. After the change those two cases still read `ok`, now as `got=deny (DENIED by rule G0)` (section 6). Their comment's account of the behaviour then goes stale (section 5, item 4).
- **R6 N-270's forms.**
  - "Adds, changes or deletes a file under it" is read as every form a pull request can take there. The gate reads diffs with `--no-renames`, so a rename out of the folder deletes a file there, and so does the folder replaced by a symbolic link.
  - "A file elsewhere under `tests/C02/W-C02-07/` stays class normal": a changed `README.md`, a new file under `job/`, and `shared-old/`, the folder's name without its path boundary.
  - Two near misses outside the folder (`tests/C02/W-C02-08/shared/`, `docs/tests/C02/W-C02-07/shared/`) follow W-C02-19's case (29): "a rule wider than the list".
- **R7 The controls' rules are those observed at `main`** (above). "Nothing else changes" is checked by these controls and by every other line of the two suites.

## 2. Form C0

### T-N269-1 · A `tool_input` that is not an object is denied by G0, in the event's form, and logged

| Field | Content |
|---|---|
| **ID and claim** | T-N269-1 (`N269-x-string`, `-list`, `-number`, `-json-string`). For every tool, a `tool_input` that is not an object gets the guard's own G0 denial in the event's form, on `PreToolUse` and on `PermissionRequest`, and exactly one decision log record. |
| **Failure class rule** | A check that cannot read its input and fails without stating its rule or leaving its record (plan Section 8 item 14; working order section 10, "Every decision is appended … to the decision log"). Also a check that "reads" such an input by decoding or coercing it, and so decides on text that is not an object. |
| **Examples** | 4 forms × 4 tools × 2 events = 32 lines. (1) The original finding: a string and a list (N-269's text). (2) Other manifestations: a number, and a string holding the JSON of the control's object. The tools are chosen so that each of `summary()`'s three ways of reading an input is used. `Bash` reads the command. `Read` reads a file path. `Monitor` (not listed; T1) and `mcp__github__get_me` (an allowed MCP server's tool) read every field. |
| **Negative control** (C0: the wrong is caught) | Each line is `BAD` on an exit 2 (`got=block`), on the wrapper's fail-closed deny, on a denial by another rule, on a denial lacking a part, and when the log does not hold exactly one matching record. Against `main` `f39c96f` every line is `BAD` (section 6). |
| **Positive control** (C0: the right is allowed) | T-N269-3, and the stand-in of section 6, with which every line is `ok`. |
| **Break attempt** | Section 3: N-269 breaks (i), (iii) and (iv). |
| **Stage and environment** | C02. Any checkout of `devos` at the head under test, with Python 3, git and a POSIX shell. No network and no credential. The guard runs through `.claude/settings.json`'s two wrapper commands, as the rest of `tools/test_tool_allowlist.sh` runs it. |
| **Independence level** | Written by the test designer (a fresh-context subagent, not the producer), and run by the designer against `main` and against stand-ins, as a self-check (section 6). The producer runs it at the head, and a fresh-context checker runs it again with the breaks. Shared with the producer: the executor's facts and the model lineage. Not shared: the change's code (it did not exist). |
| **Evidence layer** | Structural: the guard's answer and log record for synthetic hook inputs. Not behavioural: whether the platform ever sends such an input is not known (section 5). |
| **Evidence envelope** | Target commit: the head judged. Configuration: the blobs of `.claude/hooks/tool_allowlist.py`, `.claude/settings.json` and `tools/test_tool_allowlist.sh`. Criterion version: N-269's text at `main` `f39c96f` and the executor's facts (section 1). Input: the block's case list. Observation: the run's raw output. Raw evidence ID: the executor's, in the record. |

### T-N269-2 · The call's text is shown only as other G0 denials show it

| Field | Content |
|---|---|
| **ID and claim** | T-N269-2 (`N269-x-shown-*`). For a non-object input, what is shown in the answer or kept in the log carries no value REDACT masks, no credential path, no service name, and no string of either DevOS token format. Each case also asks all of T-N269-1. |
| **Failure class rule** | A fix that makes the denial show the input by a route other denials do not take: raw, or past `redact()` and `withheld()`. Or one that takes the usual route but misses the token formats, which other G0 denials never meet, because rule L4 is weighed before them for every outbound tool. |
| **Examples** | 7 inputs × 2 events = 14 lines: `shown-redact` (`Bash`, a string), `shown-credpath` (`Bash`, a string), `shown-service` (`Monitor`, a list), and `shown-env-string`, `shown-claim-string` (`Bash`, a string) with `shown-env-list`, `shown-claim-list` (`Read`, a list: a tool L4 does not read). |
| **Negative control** | A line is `BAD` when its planted text, or any string either finder matches, is found in stdout, stderr or the call's log, or when T-N269-1's checks fail. Against `main` every line is `BAD` through T-N269-1, since nothing is shown or logged there. |
| **Positive control** | The stand-in of section 6, which shows no text for such an input: every line `ok`. |
| **Break attempt** | Section 3: N-269 breaks (ii) and (v). |
| **Stage and environment**, **Independence level**, **Evidence envelope** | As T-N269-1. |
| **Evidence layer** | Structural. |

### T-N269-3 · The controls: an object input is decided and logged as today

| Field | Content |
|---|---|
| **ID and claim** | T-N269-3 (`N269-ok-<tool>`). For the same four tools, an object input gets the answer it gets at `main` `f39c96f`, on both events, by the same rule, with one log record by that rule. The answers: `Bash` `{"command":"git status"}` allow B0; `Read` a file path, allow T1; `Monitor` a command, deny T1; `mcp__github__get_me` `{}` allow M2. |
| **Failure class rule** | A fix that closes the crash by widening a denial: every input of a tool denied, or an object input sent to G0. |
| **Examples** | 4 tools × 2 events = 8 lines. |
| **Negative control** | A line is `BAD` when the answer or its rule changes, or when the log does not hold exactly one record of that answer and rule. |
| **Positive control** | The same lines `ok` at `main` and at the stand-in. |
| **Break attempt** | None was built that turns them. The rest of the suite (every other line) is the wider control of "nothing else changes". |
| **Stage and environment**, **Independence level**, **Evidence envelope** | As T-N269-1. |
| **Evidence layer** | Structural. |

### T-N270-1 · `tests/C02/W-C02-07/shared/` is class high

| Field | Content |
|---|---|
| **ID and claim** | T-N270-1 (`(N270a)` to `(N270f)`, their `p` cases, `(N270g)`, `(N270h)`). A pull request that adds, changes or deletes a file under `tests/C02/W-C02-07/shared/` gives GATE FAIL without a covering verdict, and GATE PASS, "covered by", with one. The guard's M7 refuses its merge without the verdict and allows it with it. |
| **Failure class rule** | A pull request changes what rule L4 reads at every call (its finder patterns, and the Finder table they must equal) and merges with no fresh-context verdict. EV-C02-010 section A.8 names the outcomes: a weakened finder with no "could not check", or every outbound call denied until the live tree is restored. The forms: a change, a new file, a deletion, a rename out, or the folder replaced by a symbolic link. |
| **Examples** | `(N270a)` `scan_patterns.json` changed (a key added; the patterns stay as they are); `(N270b)` `token_format.md` changed (a line appended after its last section); `(N270c)` a new file in the folder; `(N270d)` `scan_patterns.json` deleted; `(N270e)` `token_format.md` renamed out; `(N270f)` the folder moved away and a symbolic link put at its path. |
| **Negative control** | Each lettered case: no verdict, so GATE FAIL, exit 1 and a "class high:" line naming the touched file. `(N270g)`: the fixture's guard denies `(N270c)`'s `merge_pull_request` by rule M7. |
| **Positive control** | `(N270ap)` to `(N270fp)`: the same pull request with a PASS verdict it adds naming its head gives GATE PASS, exit 0, "covered by". `(N270h)`: the guard then allows `(N270c)`'s merge by M7. |
| **Break attempt** | Section 3: N-270 break (i). |
| **Stage and environment** | C02. A scratch fixture repository with a local bare origin, holding copies of the gate and the guard under test and the two shared files byte for byte. The gate is run as M7 runs it. |
| **Independence level** | As T-N269-1. |
| **Evidence layer** | Structural (the gate's class rules); `(N270g)` and `(N270h)` behavioural, at the guard's M7 call in the fixture. |
| **Evidence envelope** | As T-N269-1, with `tools/merge_gate.py` and `tools/test_merge_gate.py` as the configuration. |

### T-N270-2 · The rest of the test folder, and near misses, stay class normal

| Field | Content |
|---|---|
| **ID and claim** | T-N270-2 (`(N270n1)` to `(N270n5)`). A file elsewhere under `tests/C02/W-C02-07/`, and a path that only looks like the folder, stays class normal. |
| **Failure class rule** | A rule wider than N-270's folder: the whole of `tests/C02/W-C02-07/`, a prefix without the path boundary, any path component named `shared`, or a substring match. |
| **Examples** | `(N270n1)` the folder's `README.md` changed (seeded in the fixture first); `(N270n2)` a new file under `job/`; `(N270n3)` `tests/C02/W-C02-07/shared-old/scan_patterns.json`; `(N270n4)` `tests/C02/W-C02-08/shared/scan_patterns.json`; `(N270n5)` `docs/tests/C02/W-C02-07/shared/token_format.md`. |
| **Negative control** | Each, with no verdict, must give GATE PASS and "class normal"; a wider rule gives `BAD`. |
| **Positive control** | T-N270-1: the folder itself stays class high. |
| **Break attempt** | Section 3: N-270 breaks (ii) to (v). |
| **Stage and environment**, **Independence level**, **Evidence envelope** | As T-N270-1. |
| **Evidence layer** | Structural. |

**Format gate.** None of these tests is a format gate.

## 3. The breaks, as specifications

**How each is built.** Clone the head, so that the guard reads that tree's own `.claude/`. Edit only the file named (the guard, or the gate), in that clone. Then run the suite named at that clone's root, each break on its own. Each must end in `FAIL`, with the named cases `BAD` and every other line of the suite as at the unchanged head.

| Break | The edit | Cases that turn `BAD` | Cases that stay `ok` |
|---|---|---|---|
| N-269 (i) the fix removed | The guard at `main` `f39c96f` | every `N269-x-*` (46) | every `N269-ok-*` |
| N-269 (ii) the text shown past `redact()` and `withheld()`, but not past the token finders | `summary()` shows a string input as it is and any other non-object as its JSON, then applies `withheld()` and `redact()` as for any other input | the 8 `N269-x-shown-env-*` and `-claim-*` lines | every other `N269-*` |
| N-269 (iii) the denial built but not logged | The fix, and `log_decision()` returns without writing for a non-object input | every `N269-x-*` (46): no record, and the denial names none | every `N269-ok-*` |
| N-269 (iv) the input decoded | The fix, and `decide()` decodes a string input as JSON before its object check | the 8 `N269-x-json-string` lines (`Bash` allow B0, `Read` allow T1, `Monitor` deny T1, `get_me` allow M2) | every other `N269-*` |
| N-269 (v) the raw text shown | `summary()` returns the input's raw text for a non-object input | the 14 `N269-x-shown-*` lines | every other `N269-*` |
| N-270 (i) the folder's rule removed | The gate at `main` `f39c96f` | `(N270a)` to `(N270f)`, their six `p` cases, `(N270g)`, `(N270h)` (14) | `(N270n1)` to `(N270n5)` and the 78 other cases |
| N-270 (ii) no path boundary | The prefix `tests/C02/W-C02-07/shared` without its `/` | `(N270n3)` | every other case |
| N-270 (iii) the whole test folder | The prefix `tests/C02/W-C02-07/` | `(N270n1)`, `(N270n2)`, `(N270n3)` | every other case |
| N-270 (iv) any component named `shared` | No prefix; a path with a directory component `shared` is class high | `(N270n4)`, `(N270n5)` | every other case |
| N-270 (v) a substring | No prefix; a path containing `tests/C02/W-C02-07/shared/` anywhere is class high | `(N270n5)` | every other case |

## 4. Clause table

| The text | Cases |
|---|---|
| N-269: "a `tool_input` that is a string or a list" | `N269-x-string-*`, `N269-x-list-*`, `N269-x-json-string-*` |
| fact 1: "(or any non-object)" | `N269-x-number-*`; the empty forms are not judged (R1; section 5) |
| N-269: "For every tool" | four tools: listed with each of `summary()`'s readings, not listed, and an MCP server's tool |
| fact 1: "denied by G0 … in the event's form, naming rule G0, on `PreToolUse` and on `PermissionRequest`" | every `N269-x-*` case runs on both events (R2) |
| N-269: "the decision log holds no record"; fact 1: "appended to the decision log like any other decision" | every `N269-x-*` case (R3) |
| N-269 and fact 1: "`summary()` and the denial read such an input safely" | every `N269-x-*` case (no exit 2, no wrapper answer); break N-269 (i) |
| fact 1: "shown only as other G0 denials show it (redacted, no format string …)" | `N269-x-shown-*` (R4); breaks N-269 (ii) and (v) |
| fact 1: "Nothing else changes" | `N269-ok-*` (R7), and every other line of the suite |
| N-269: "with a case on each event" | every `N269-*` case |
| N-270: "make that folder class high in `tools/merge_gate.py`"; fact 2: "adds, changes or deletes a file under it needs a covering verdict" | `(N270a)` to `(N270f)` with their `p` cases; `(N270g)` and `(N270h)` at M7 |
| fact 2: "a file elsewhere under `tests/C02/W-C02-07/` stays class normal" | `(N270n1)`, `(N270n2)`, `(N270n3)`; near misses `(N270n4)`, `(N270n5)` (R6) |
| N-270: "with gate cases in W-C02-19's form" | `shared_token_files()`: the same fixture, `neg` and `pos` forms, and the form-C0 comment |

## 5. Not covered, and found while writing (reported, not done)

1. **The empty forms: fact 1 and the observed guard disagree.** `""` is a string and `[]` is a list, and `0`, `false` and `null` are not objects. Fact 1 says each such input "is denied by G0". At `main`, the guard reads each of them as an empty object, and decides it without a fault: for example `Bash` with `tool_input` `[]` is allowed by B0. So denying them changes decisions that N-269 does not report as faulty, and fact 1 also says "Nothing else changes". The cases judge neither reading. The executor decides one before the change's result is seen, and a case is then added.
2. **The live tree** (N-270: "the guard's file rules do not protect it in the live tree"). N-270's remedy is the gate only. A session's edit of the live tree's copies, which acts at once, is not tested here. It stays the residual that EV-C02-010 section A.8 and the working order state.
3. **Whether the platform ever sends a non-object `tool_input`** is not known. These tests show the guard's answer to synthetic input, not a live call.
4. **Texts the changes make untrue.** The producer and the executor have to handle each one; none is a test.
   - The working order, section 10, the "Token formats" bullet (line 143 at `f39c96f`): "The two shared files are on a class-normal path".
   - The docstring of `tools/merge_gate.py`, whose "Class high:" list the working order cites ("listed in `tools/merge_gate.py`").
   - EV-C02-010 section A.8's first bullet.
   - The comment above W-C02-21's `w21c` cases in `tools/test_tool_allowlist.sh`, which describes the crash as current.
5. **A token string with its marker removed.** Fact 1 names format strings. A change that removed only a string's marker and showed the rest would pass T-N269-2, so no case asks more than the fact.
6. **The real merge route.** `(N270g)` and `(N270h)` run the guard's M7 in the fixture, not on GitHub.
7. **PC-23** (role procedure step 6). Neither condition designs a parameter that sets when dependent work can start. The notes' deadlines are the executor's.

## 6. Self-check by the test designer (not a result)

All runs were on 2026-10-13, in the designer's scratch clone `cw95`: branch `claude/c02-n269-n270` from `main` `f39c96f`, with these test changes uncommitted, and `origin` the GitHub repository with the branch not pushed. Each run was the whole suite.

**At `main` `f39c96f`, before the test changes:**
- `bash tools/test_tool_allowlist.sh`: `ok` 1316, `BAD` 0, `info` 28; `TOKEN_STOP_TEST PASS (ok 422, BAD 0, info 26)`, `ALLOWLIST_TEST PASS`.
- `python3 tools/test_merge_gate.py`: `MERGE_GATE_TEST PASS (78/78)`.
- The executor's figures (1320, 0, 26) differ only through the unpushed branch: three branch controls are skipped, with one `info` line saying so, and `W20-P7-change` reads `info` when no file differs from `origin/main`.

**The guard and the gate at `main`, with these tests:**
- Allowlist suite: `ok` 1325, `BAD` 46, `info` 27; `TOKEN_STOP_TEST PASS (ok 423, BAD 0, info 25)`, `ALLOWLIST_TEST FAIL`.
  - Every `N269-x-*` line was `BAD` (46): `got=block` on `PreToolUse` and the wrapper's fail-closed deny on `PermissionRequest`, with 0 log records each time.
  - Every `N269-ok-*` line was `ok` (8).
  - Outside `N269-*`, only `W20-P7-change` changed status, from `info` to `ok`: it now scans the changed files, and these two hold no format string.
- Gate suite: `MERGE_GATE_TEST FAIL (83/97)`. All 14 high-side `(N270*)` cases were `BAD`, every one with GATE PASS, "class normal", or the guard's allow. The 5 `(N270n*)` controls were `ok`, and the 78 existing case lines were identical to the run without the tests.

**Stand-ins in throwaway copies of `cw95`, deleted after.** They were made only to show that the cases can pass and that each break turns its cases. None is offered as the change.
- The fix, as a stand-in: for a non-object input, `summary()` shows a fixed text and none of the input; the gate gets the prefix `tests/C02/W-C02-07/shared/`.
  - Every `N269-*` line was `ok` (54), and `ALLOWLIST_TEST PASS` (`ok` 1371, `BAD` 0, `info` 27).
  - `MERGE_GATE_TEST PASS (97/97)`.
  - Outside the new cases, no line changed status. `W21-c-input-string` and `-list` read `got=deny (DENIED by rule G0)`, still `ok`, and the suite's log check counted the 4 more records.
- Each break of section 3, with the result observed:
  - N-269 (ii): exactly the 8 token lines `BAD`.
  - N-269 (iii): all 46 `N269-x-*` lines `BAD`.
  - N-269 (iv): exactly the 8 `json-string` lines `BAD`.
  - N-269 (v): exactly the 14 `shown` lines `BAD`.
  - N-270 (ii): `(N270n3)` `BAD`.
  - N-270 (iii): `(N270n1)`, `(N270n2)` and `(N270n3)` `BAD`.
  - N-270 (iv): `(N270n4)` and `(N270n5)` `BAD`.
  - N-270 (v): `(N270n5)` `BAD`.
  - Breaks N-269 (i) and N-270 (i) are the runs at `main` above.
  - In each break, every other line kept its status.
