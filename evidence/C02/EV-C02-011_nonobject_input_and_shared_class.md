---
id: EV-C02-011
item: "notes N-269 and N-270 (plan/work/C02.md)"
kind: record
title: "A tool input that is not an object gets the guard's own G0 denial, in the event's form and with its decision log record (N-269); tests/C02/W-C02-07/shared/ is class high in the merge gate (N-270): the root cause, the change, the empty forms, the cases, the breaks, the texts made untrue and what is not covered"
date: 2026-10-13
main_at: f39c96f
produced_by: "a producer, a fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (same session; declared, Ek A 5.3), in a scratch clone on branch claude/c02-n269-n270 at c3178fa (the test designer's commit on main f39c96f), its changes left uncommitted for the executor"
sources:
  - "plan/work/C02.md, notes N-269 and N-270, at main f39c96f99b1fe070a1624943c2102ac50a1541e4 (their text is the acceptance)."
  - "The executor's task of 2026-10-13: fact 1 (N-269, with the decision on the empty forms) and fact 2 (N-270), quoted in section 0."
  - "tests/C02/N-269_N-270/README.md, the N-269 block of tools/test_tool_allowlist.sh and the N270 cases of tools/test_merge_gate.py, at c3178fa (the test designer's commit)."
  - ".claude/hooks/tool_allowlist.py, read at c3178fa (blob 5787f87, the same on main f39c96f): summary(), redact(), withheld(), decide(), log_decision(), deny_text(), main(), token_finders(); tools/merge_gate.py at c3178fa (blob 2a7f6bd, the same on main)."
  - "evidence/C02/EV-C02-010_token_stop_and_monitor.md section A.8; plan/Installation_Working_Order.md sections 4 and 10 and plan/DevOS_Kurulum_Plani.md 6.7 at f39c96f; plan/decisions/PC-49.md."
claim: "Sections 1 to 3 describe the change at the producer's last edit. Section 4 holds the producer's runs and section 5 its breaks and probes: observed, a self-check, not independent assurance. The run at the pushed head, the commit and the raw evidence are the executor's; a fresh-context checker judges the change."
---

# EV-C02-011 · A non-object tool input gets the guard's G0 denial and its log record (N-269); the shared token folder is class high (N-270)

**What this is.** The record of one change for two notes on `plan/work/C02.md`. N-269: a `tool_input` that is not an object crashed the guard while its G0 denial was built, so the call was refused with no rule named and no decision log record. N-270: rule L4 reads its finder patterns from `tests/C02/W-C02-07/shared/`, which the merge gate classed normal. The cases were written first, by a test designer that does not produce the change (`tests/C02/N-269_N-270/README.md`, commit `c3178fa`).

**No format string here.** This record names the two DevOS token formats only through the shared files. It holds no marker, no pattern and no string of either format (section 6, the scan).

**Labels.** [obs] observed in the producer's runs and probes, 2026-10-13; [inf] this record's inference. G:n is a line of `.claude/hooks/tool_allowlist.py` at the producer's last edit; M:n of `tools/merge_gate.py`.

## Evidence envelope

| Field | Value |
|---|---|
| Source commit | The executor's commit of this change on `claude/c02-n269-n270`, parent `c3178fa4787f3e4206038afefb055b6262065cb4`. Filled in by the executor: |
| Configuration | At the producer's last edit: the guard `64e2dd70ea97193846f533d5d046335adfe05933` (at `c3178fa` and `main` `f39c96f`: `5787f873c7a468e523acc8c7ba1e4e342a89757f`); the gate `4840fef1daf1df86e65ab8958559d281d2e7784a` (before: `2a7f6bd103b89a3e9d93974b133d65861f240a08`). Unchanged: `.claude/settings.json` `c6907ccf460912e9403b3f192b834a3681377b24`; `tools/test_tool_allowlist.sh` `bcd0b9936c98952428ca65f2f60d1731a0c0220e`; `tools/test_merge_gate.py` `6097bacc24ac5a92db9e2db81974d0b6a74047fb`; `tests/C02/N-269_N-270/README.md` `0cd41826fcd442b4df72de16ca68a462adc13f30`; `scan_patterns.json` `b548c8cea2c485256a9b4bd8499aa0eb29db3b48`; `token_format.md` `175c68c75602321c0eff50fb7b698fabb1ea83cb`. |
| Criterion version | N-269's and N-270's text on `plan/work/C02.md` at `main` `f39c96f` (blob `88b165d`, the same at `c3178fa`), with the executor's facts 1 and 2 of 2026-10-13 (section 0). The cases: the test designer's, at `c3178fa`, before any change existed. |
| Input (the case list) | The N-269 block of `tools/test_tool_allowlist.sh` (54 lines: 46 `N269-x-*`, 8 `N269-ok-*`), within the whole suite; the cases `(N270*)` of `tools/test_merge_gate.py` (19 of 97). |
| Raw output | Section 4: counts and final lines of the producer's runs at its last edit. The full outputs stay in the producer's scratch directory and are not kept; the executor's run at the pushed head is the run of record. |
| Raw evidence ID | The executor's. |
| Independence level | Producer: same session, fresh-context subagent (declared, Ek A 5.3); its runs, breaks and probes are a self-check. The cases are a different fresh-context subagent's, written before the change. A fresh-context checker that took no part judges the change at the head. |

## 0. The notes and the executor's facts

- **N-269** (origin W-C02-21): "A `tool_input` that is a string or a list crashes the guard's denial". Remedy: "`summary()` and the denial read a non-object input safely, with a case on each event, through a checked guard change".
- **N-270** (origin W-C02-20): "The guard's token stop reads its patterns from a class-normal path". Remedy: "make that folder class high in `tools/merge_gate.py`, with gate cases in W-C02-19's form, through a checked change".
- **Fact 1 (the executor, 2026-10-13).** For every tool, a `tool_input` that is a truthy non-object (a non-empty string, a non-empty list, a non-zero number, and so on) is denied by G0, with the denial built and printed in the event's form naming rule G0 on `PreToolUse` and on `PermissionRequest`, and the call appended to the decision log like any other decision. `summary()` and the denial read such an input safely. The call's text is shown only as other G0 denials show it (redacted; no string of either DevOS token format reaches the output or the log). The empty forms (`""`, `[]`, `0`, `false`, `null`) keep their behaviour at `main`: they are read as an empty input object. "Nothing else changes" holds for them and for every object input. The root cause is to be fixed, not only the symptom.
- **Fact 2.** `tests/C02/W-C02-07/shared/` is class high in `tools/merge_gate.py`. Adding, changing, deleting or renaming a file under it, or replacing the folder by a link, needs a covering verdict. The other files under `tests/C02/W-C02-07/` stay class normal, and so do near-miss paths.

## 1. N-269: the cause and the change

### 1.1 The cause, by layer

- **Outcome** [obs, the designer's run at `main` and the producer's break g1, section 5]. For a `tool_input` that is a non-empty string, a non-empty list, a number or `true`, for every tool, the guard exits 2 on `PreToolUse`. On `PermissionRequest` the settings wrapper denies it, "failing closed". The answer names no rule, and the decision log has no record.
- **Proximate cause** [obs, code at `c3178fa`]. `decide()` returns G0, "the tool input is not an object". `main()` then calls `deny_text()`, which calls `summary()`. `summary()` reads the input with `.get()` (for `Bash` and the file tools) or `.items()` (for every other tool) and raises `AttributeError`.
- **Contributing condition (the cause the test designer found)** [obs]. `main()` builds the denial (`deny_text()`, through `summary()`) before `log_decision()` runs, and outside any `try`. The decision is already made, yet one exception raised while building its text reaches the top-level handler, which exits 2. So the rule and the record are both lost.
- **Prevention gap** [inf]. Two readings of one input make different assumptions: `decide()` checks the type and denies, but `summary()` reads the same input again, for display, with no check.
- **Detection gap** [obs, `tests/C02/W-C02-21/README.md` and the suite]. W-C02-21's `W21-c-input-string` and `-list` accepted "deny or the fail-closed block", so a refusal with no rule and no record passed. That is how the crash was found, and why it was not a failure (README R5).
- **The same class by another route** [obs, probe P1, section 5]. A crash between reading the hook input and writing the record also happens one step earlier. `main()` catches only `ValueError` around `json.loads()`. A hook input nested deeper than Python's JSON reader allows (100000 levels in the probe) raises `RecursionError`, which is not a `ValueError`. The guard then exits 2, with no rule and no record. This happens for a `tool_input` that is such a list, which fact 1 covers, and for any other input nested that deep.

### 1.2 The change (three parts)

- **(a) `summary()` names a non-object input and shows none of it** (G:466 to G:467). For a `tool_input` that is not an object, `summary()` returns "[not shown: the tool input is a `<type>` value, not an object]". `<type>` is Python's type name: `str`, `list`, `int`, `float` or `bool`. This is the designed text for the route N-269 reports.
- **(b) `summary()` never raises** (G:468 to G:481). Its reading of an object input runs inside a `try`. Any exception gives "[not shown: the call's text could not be read (`<exception type>`)]". This change is at the layer of the contributing condition. No failure while reading the text to show can cost the denial its rule or the call its record, because `deny_text()` and `log_decision()` both get the text through `summary()`. When the display fails, less text is shown, never more. Break g2 shows that (b) alone, with (a) removed, keeps all 46 cases `ok` (section 5).
- **(c) `main()` treats a hook input too deep to decode as unreadable** (G:2240, G:2246 to G:2247, G:2252). A `RecursionError` from `json.loads()` is handled like invalid JSON: the guard denies the call by G0, in the event's form (the event comes from the command's argument, N-173), and logs it. Its detail is "the hook input is nested deeper than the guard's JSON reader reads". The detail for invalid JSON is unchanged. As for any hook input the guard cannot decode, the record carries no tool name, because none could be read.
- **Unchanged:** `decide()` (G0 for a non-object input, as before), `deny_text()`, `log_decision()`, `RULES["G0"]`, `redact()`, `withheld()`, and every caller's `data.get("tool_input") or {}`.

### 1.3 The empty forms

The callers still pass `data.get("tool_input") or {}` (G:2117 in `decide()`, and in `log_decision()` and `deny_text()`). So `""`, `[]`, `0`, `false` and `null` are read as an empty object and decided as at `main`, and they never reach part (a). This follows the executor's decision of 2026-10-13: a tool with no input may send `null`, and N-269 concerns only the inputs that crash. The README's cases judge neither reading (its section 5 item 1).

### 1.4 What is shown, and why a fixed text

Other G0 denials show the call's text after `withheld()` and `redact()`. For a tool that sends text out of the session, L4 has read that text first: the stop runs before every other rule of an outbound call (G:2123). A non-object input is denied by G0 before L4 is weighed, so a string of either token format in it meets no finder. The alternatives:
- (A, chosen) Show none of the input. Fact 1's ceiling, "shown only as other G0 denials show it", then holds by construction (README R4 reads it as a ceiling), and no new reading of the shared files is added to the display path.
- (B) Show it after `withheld()`, `redact()` and both token finders. This needs the finders inside `summary()`. A fault of the shared files would then become a second route into "could not check" inside a display function. It also adds code that N-269 does not ask for.
- (C) Show it after `withheld()` and `redact()` only. Break g4 shows that the token cases catch this (section 5).

### 1.5 What changes for other inputs

- **Decisions:** none. Every readable object input reaches `decide()` as before, and `summary()` returns for it the same text as at `main` unless reading it raises. In this run, with Python 3.13, no readable object input raised there. Probe P1 shows the same G0 answer and record at `main`'s code and at the change, for a `Bash` command that is a list nested 5000 deep. `N269-ok-*` and every other line of the suite are unchanged (section 4).
- **The one answer that changes for an object input** [obs, probe P1]. A hook input nested 100000 deep (`object-100000`) exited 2 at `main`, with no rule and no record. Now it is denied by G0 and logged. Both are refusals: the answer now names its rule and keeps its record, which is N-269's failure class closed by part (c). The producer reads fact 1's "nothing else changes" as covering the inputs the guard can read. A checker may judge that reading.

## 2. N-270: the change

- **The gate** (M:35 to M:36). `HIGH_PREFIXES` gains `"tests/C02/W-C02-07/shared/"`, with its trailing `/` as the path boundary. The docstring's "Class high:" list (M:14 to M:15) names `tests/C02/W-C02-07/shared/**` and why. `high_paths()` and the rest of the gate are unchanged.
- **The forms** [obs, section 4]. The gate reads `git diff --name-only --no-renames`, so each form of fact 2 touches a path under the prefix:
  - a changed file, a new file, a deleted file;
  - a rename out (a deletion there);
  - the folder replaced by a link (its files deleted): `(N270a)` to `(N270f)`, with their verdict cases, and `(N270g)` and `(N270h)` at the fixture guard's M7.
- **Class normal, as before:** `tests/C02/W-C02-07/README.md`, a new file under `job/`, `shared-old/`, another item's `shared/`, and the same path under another root: `(N270n1)` to `(N270n5)`.
- **Not added: an entry in `HIGH_DIR_PATHS` for the folder's own path.** Such an entry would make a file or link standing at `tests/C02/W-C02-07/shared` (or at a parent) class high even when the folder no longer holds files on `main`. That state needs the folder's files deleted on `main` first, which is class high. It would also leave every call L4 reads denied as "could not check" until the files are restored. N-270 asks for the folder, and the cases do not ask for its path [inf].
- **The live tree is unchanged** (N-270: "the guard's file rules do not protect it in the live tree"). F1 and B5 guard `.claude/`, `tools/` and `.git/`, so a session's edit of the live copies still acts at once. The working order now states both facts (PC-50 place 1).
- **The gate's list beyond plan 6.7's.** Case (28) of `tools/test_merge_gate.py` checks that plan 6.7's list is among the gate's paths, and it still is. W-C02-07's DM-47 program prints the gate's extra paths as notes, never as a failure (`tests/C02/W-C02-07/job/w07_dm47_merge_gate_list.py`, its docstring). Plan 6.7's list is unchanged (PC-50 alternative C).

## 3. Texts the change makes untrue, and their correction

- **Working order section 10, the "Token formats" bullet** (line 143 at `f39c96f`). It said "on a class-normal path". The correction is through `plan/decisions/PC-50.md` place 1, which also lists the places checked and left unchanged: section 4 item 5, section 10's opening paragraph, its "Not protected" bullets, and plan 6.7's list and network row. PC-50 also meets PC-49's `reopen_if` for that sentence.
- **`tools/merge_gate.py`'s docstring "Class high:" list:** changed with the code (section 2).
- **EV-C02-010 section A.8, the first bullet:** a dated annotation naming N-270 is appended, and the record's past text is kept.
- **Reported, not changed** (test designers' files, outside the producer's files):
  - the comment above W-C02-21's `w21c` cases in `tools/test_tool_allowlist.sh`, which describes the crash as current (README section 5 item 4);
  - `tests/C02/W-C02-07/GROUPS.md` line 216, which names `shared/scan_patterns.json` beside a script that "stays class normal";
  - the copies of `HIGH_PREFIXES` in `tests/C02/W-C02-03/test_decision_steps.py`, `test_workflow_guards.py` and `test_workflow_order.py`, which lack the new prefix. By their use there, a script under the folder counts as not class high, which is stricter, not looser.
- **Notes N-269 and N-270** stay open until the merge. The executor closes them.

## 4. The runs at the producer's last edit

[obs] On 2026-10-13, in the scratch clone (branch `claude/c02-n269-n270`, at that time on the remote at `c3178fa`), with the guard `64e2dd7` and the gate `4840fef` (the envelope). Each suite was run whole, at the clone's root.

- **`bash tools/test_tool_allowlist.sh`:** `ok` 1374, `BAD` 0, `info` 26; `TOKEN_STOP_TEST PASS (ok 423, BAD 0, info 25)`; `ALLOWLIST_TEST PASS`; exit 0.
  - Every `N269-*` line is `ok` (54): `N269-x-*` 46, `N269-ok-*` 8.
  - `W21-c-input-string` and `-list` stay `ok`, now as `got=deny (DENIED by rule G0)` on both events.
  - `W20-P7-change`: "the 9 files of the change (against origin/main, with untracked files) hold no format string".
  - **Against the test designer's stand-in** (README section 6: `ok` 1371, `BAD` 0, `info` 27): the branch is now on the remote, so the three branch controls run (`ok`), and the `info` line saying they were skipped is gone.
  - **Against the first run** (after parts (a) and (b), before part (c)): the same status on every line.
- **`python3 tools/test_merge_gate.py`:** `MERGE_GATE_TEST PASS (97/97)`, exit 0. All 19 `(N270*)` cases are `ok`, and the 78 earlier cases are `ok`.
- **Before the change** (README section 6, the test designer's runs at `main`'s guard and gate with the cases): every `N269-x-*` line `BAD` (46), and `MERGE_GATE_TEST FAIL (83/97)`. Breaks g1 and m1 below repeat both.

## 5. Breaks and probes (self-check; each on a full copy of the scratch clone, edited with the Edit tool, deleted after)

The copies were made from the scratch clone after parts (a) and (b) and the gate change, and before part (c), which no case of either suite reaches. Each break edits one file of one copy. Each suite was run whole, at that copy's root.

| Break | The edit | Expected (README section 3) | Observed [obs] |
|---|---|---|---|
| g1, N-269 (i): the fix removed | `summary()` as at `main` (and `main()` without part (c)) | every `N269-x-*` `BAD` (46), the rest as at the head | `ALLOWLIST_TEST FAIL`: `ok` 1328, `BAD` 46, `info` 26; the 46 are all the `N269-x-*` lines (`got=block`, and the wrapper's fail-closed deny, with 0 records) |
| g2: part (a) removed, (b) kept | the non-object branch deleted | (the producer's own: does (b) alone hold the rule and the record?) | `ALLOWLIST_TEST PASS`: `ok` 1374, `BAD` 0. (b) alone holds N-269's route. The text then shown, "could not be read" with the exception's type, is read from the code [inf]; the suite does not print it |
| g3: part (b) removed, (a) kept | the `try` deleted | (the producer's own: does (a) alone?) | `ALLOWLIST_TEST PASS`: `ok` 1374, `BAD` 0 |
| g4, N-269 (ii) | a string input shown as it is, any other non-object as its JSON, after `withheld()` and `redact()` | the 8 `N269-x-shown-env-*` and `-claim-*` lines `BAD` | `FAIL`: `ok` 1366, `BAD` 8, exactly `N269-x-shown-{env,claim}-{string,list}` on both events |
| g5, N-269 (iii) | `log_decision()` returns without writing for a non-object input | every `N269-x-*` `BAD` (46) | `FAIL`: `ok` 1328, `BAD` 46, all `N269-x-*` ("the denial lacks 'Decision log: #'; 0 decision log records") |
| g6, N-269 (iv) | `decide()` decodes a string input as JSON before its object check | the 8 `N269-x-json-string-*` lines `BAD` | `FAIL`: `ok` 1366, `BAD` 8, exactly `N269-x-json-string` for the four tools on both events |
| g7, N-269 (v) | `summary()` returns a non-object input's raw text | the 14 `N269-x-shown-*` lines `BAD` | `FAIL`: `ok` 1360, `BAD` 14, exactly the seven `N269-x-shown-*` inputs on both events |
| m1, N-270 (i) | the prefix removed (the gate at `main`) | `(N270a)` to `(N270h)` with the `p` cases `BAD` (14) | `MERGE_GATE_TEST FAIL (83/97)`: exactly those 14 `BAD` |
| m2, N-270 (ii) | the prefix without its `/` | `(N270n3)` | `FAIL (96/97)`: `(N270n3)` |
| m3, N-270 (iii) | the prefix `tests/C02/W-C02-07/` | `(N270n1)`, `(N270n2)`, `(N270n3)` | `FAIL (94/97)`: those three |
| m4, N-270 (iv) | no prefix; a directory component `shared` is class high | `(N270n4)`, `(N270n5)` | `FAIL (95/97)`: those two |
| m5, N-270 (v) | no prefix; a path containing the folder's path is class high | `(N270n5)` | `FAIL (96/97)`: `(N270n5)` |

In every break, the lines not named stayed `ok`: the counts of `ok` are the head's less the named lines.

**Probe P1** (part (c), and the "other inputs" of section 1.5; a script in the producer's scratch directory feeds the guard file named, through the command's event argument, a hook input built at run time, with a decision log of its own; it prints the exit code, the answer's form and rule, the "What matched" line and the records):

| Hook input (`tool_input`) | At the change (guard `64e2dd7`), each event | At g1 (`main`'s `summary()` and `main()`), each event |
|---|---|---|
| `Bash`, a list nested 100000 deep | exit 0; the event's own form; DENIED by rule G0, "the hook input is nested deeper than the guard's JSON reader reads"; 1 record (G0, deny) | exit 2; no answer; no rule; 0 records; stderr "guard error RecursionError" |
| `Bash`, an object whose `command` is a list nested 100000 deep | the same as the row above | the same as the row above |
| `Bash`, an object whose `command` is a list nested 5000 deep | exit 0; the event's form; G0 by `shell_checks()` ("the command name …"); 1 record | the same |
| `mcp__github__get_me`, a list nested 5000 deep | exit 0; the event's form; G0, "the tool input is not an object"; 1 record | exit 2; 0 records; "guard error AttributeError" |

## 6. The scan: no format string in the change

[obs] A script in the producer's scratch directory reads `env_token_find` and `claim_token_find` from the checkout's `tests/C02/W-C02-07/shared/scan_patterns.json` at run time. It scans every file that differs from `main` `f39c96f`, untracked files included, and prints only names and counts.

**Control:** a string of each format, made in memory from its finder and never printed or written, is found by its finder.

**Result before this section was filled in:**
- each of the 9 files has 0 matches for each finder: the guard, the gate, EV-C02-010, this record, the working order, PC-50, and the test designer's three files;
- the last line is "SCAN PASS: 9 files, 0 format strings, controls found".

The producer ran the scan again at its last edit and reports it to the executor. The suite's `W20-P7-change` line (section 4) is the repository's own form of this check.

## 7. Not covered

1. **Whether the platform ever sends a non-object or a very deep `tool_input`** is not known. The cases and P1 show the guard's answer to synthetic input, not a live call (README section 5 item 3).
2. **Part (c) has no case in the suite.** Probe P1 and break g1 are the producer's alone. A case would belong to the test designer.
3. **No input known to the producer reaches part (b) on its own** (section 1.5). Break g2 shows that (b) holds N-269's own route, and break g3 that (a) does. So the suite cannot tell the two parts apart. Each closes the route alone.
4. **`withheld(detail)` in `main()`** (G:2260) runs before the denial is built. It catches `OSError`, `ValueError` and `SubprocessError`. Another exception there, for example from a malformed fingerprint store or settings file, would still exit 2 with no record. That fault would come from the environment, not from the call's input, and it would hit every call, failing closed and visibly. It is outside N-269 and is stated as a residual.
5. **The live tree's copies of the shared files** are not protected by the guard's file rules (N-270; section 2).
6. **A link at the folder's own path when the folder has no files on `main`** is class normal (section 2).

## 8. What stays open for the executor

- The commit, the push, the run of record at the pushed head (both suites, `tools/test_token_stop.py` within the first), and the source commit in the envelope.
- A fresh-context checker's verdict at the head (the guard, the gate and the working order are class high), with the breaks rebuilt by the checker.
- `tools/records.py render` (the ledger's generated rows for PC-50).
- The closing lines of N-269 and N-270 after the merge.
- The texts in test files reported in section 3.
