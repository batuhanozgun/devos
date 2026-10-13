---
id: EV-C02-010
item: "W-C02-20 (change 1, the stop) and W-C02-21"
kind: record
title: "The guard's stop of both DevOS token formats in outbound text (rule L4; W-C02-20 change 1) and its denial of Monitor by rule T1 (W-C02-21): the channels, what the stop reads and where it runs, the results, the faults, the planted controls, the texts made untrue, the same failure class by other routes, and PC-23"
date: 2026-10-13
main_at: 527ae11
produced_by: "two producers in turn, each a fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (same session; declared, Ek A 5.3): the first (agent ae3e100a5ff7884bb) built the change and stopped at its turn limit, its files committed as checkpoint 397a39f; the second verified that checkpoint against both acceptance blocks, corrected it and made the runs of sections D and E"
sources:
  - "plan/work/W-C02-20.md and plan/work/W-C02-21.md, their acceptance blocks as at main 527ae11 (W-C02-20's merged by PR #293, b679568; W-C02-21's by PR #317, 527ae11)."
  - "tests/C02/W-C02-20/README.md and tests/C02/W-C02-21/README.md, tools/test_token_stop.py and tools/test_tool_allowlist.sh, as on branch claude/c02-w20-stop at a527a29 (the test designers' commits a2e5a53 and 8d10337)."
  - "tests/C02/W-C02-07/shared/token_format.md and scan_patterns.json at a527a29 (blobs 175c68c and b548c8c, the same on main 527ae11)."
  - ".claude/hooks/tool_allowlist.py, read in full at a527a29 (blob 956f1b3, the same on main) and at the head this record describes; .claude/settings.json at a527a29 (blob c6907cc)."
  - "plan/Installation_Working_Order.md (sections 4, 6, 7 and 10) and plan/DevOS_Kurulum_Plani.md (K-9 item 4, 6.7, C03's Tests, Section 14) at main 527ae11; plan/work/C02.md notes N-209, N-221 and N-245; plan/ledger/C02-log.md L-294 and L-306 to L-309; plan/decisions/D-027 to D-037 (status and dates)."
  - "evidence/C02/EV-C02-003_identity_chain_and_environments.md sections 1.1, 1.6, 1.7, 2.2, 3.2 and 14; evidence/C02/EV-C02-006_session_tools_bridge.md; evidence/C01/checks/CHK-C01-051.md and CHK-C01-052.md; evidence/C01/routine/CONTROL.md (P1)."
  - "The platform's documentation, fetched by the first producer on 2026-10-13 at about 03:50Z: https://code.claude.com/docs/en/tools-reference.md, workflows.md, skills.md and plugins/components.md (documented, not independently tested). The second producer had no web reader and did not re-read these pages: the quotations in section B.5 are the first producer's."
  - "This session's guard decision log (/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl), read for the input field names of ReadNotifications and StructuredOutput calls only; the user-level plugins folder (/root/.claude/plugins), read with the Glob and Grep tools for monitor declarations only, 2026-10-13."
claim: "Sections A and B describe the change at the head and the producers' own runs of the tests (observed; a self-check, not independent assurance; sections D and E are the runs at the last edit). Platform behaviour is documented, not independently tested. The run of W-C02-20 point 8 at the pushed head, point 9's and W-C02-21 point 6's live tries, the run IDs and the commits are the executor's, after this record (section C)."
---

# EV-C02-010 · The guard's token stop (W-C02-20, change 1) and its denial of `Monitor` (W-C02-21)

**What this is.** The record of two guard changes that merge together at one head (L-309): W-C02-20's change 1, a rule that stops a string of either DevOS token format in any field of a call that leaves the session and in what a push would publish, and W-C02-21, which takes `Monitor` off the guard's allow list. W-C02-20's change 2, the client path's exception (its point 3 beyond `P3c1-*`), is not built: the client script does not exist on `main`. The technical facts the change is built to are the executor's (the task of 2026-10-13: the patterns read at every call from the shared files beside the hook, which must agree, any fault "could not check"; the raw input, before any masking, for every outbound channel, before every allow; the denial withholding the call's text; `Monitor` off `ALLOWED_NON_MCP`). The research library was not consulted: the change implements a design fixed in EV-C02-003 and in the two items.

**No format string here.** This record names the formats only through the shared file: it holds no marker, no pattern and no string of either format (section A.9, the scan).

**Labels.** [obs] observed in the producers' runs on 2026-10-13 (sections C to E say whose); [doc] the platform's documentation, read 2026-10-13, documented, not independently tested; [inf] this record's inference. "The head" is the commit the executor makes from the second producer's working tree on branch `claude/c02-w20-stop` (parent `a527a29`); line numbers of `.claude/hooks/tool_allowlist.py` ("G:") are at the head.

## Evidence envelope (W-C02-20 point 12; W-C02-21 point 9)

| Field | Value |
|---|---|
| Source commit | The head on `claude/c02-w20-stop` (parent `a527a29`, which merged `main` `527ae11`). **The executor fills its full SHA.** |
| Configuration | Guard (`.claude/hooks/tool_allowlist.py`): at the second producer's last edit `1fe3010b10b19a09931af5a034ca72dc4e49ed37` (read from `git diff --full-index`); **the executor confirms it at the head** (at `a527a29` and on `main`: `956f1b3`). `.claude/settings.json`: `c6907ccf460912e9403b3f192b834a3681377b24`, unchanged. Shared files: `scan_patterns.json` `b548c8cea2c485256a9b4bd8499aa0eb29db3b48`, `token_format.md` `175c68c75602321c0eff50fb7b698fabb1ea83cb`, both unchanged. Client script: none (change 2). Tests: `tools/test_token_stop.py` `f4887b91ce5690a8c5effa6f6c25bdbf5765a105` and `tools/test_tool_allowlist.sh` `8974d71e36c72d820b257b130747ac0eda55bc18`, unchanged by this change. |
| Criterion version | W-C02-20's acceptance block, merged into `main` by PR #293 (`b679568`), unchanged at `527ae11` (only its `execution:` line changed since). W-C02-21's block, merged by PR #317 (`527ae11`). |
| Input (the case list) | `tools/test_token_stop.py` (`W20-*`: 412 lines, 387 judged and 25 `info`) and the W-C02-21 block of `tools/test_tool_allowlist.sh` (`W21-*`, 76 lines), within the whole suite (1310 lines). |
| Raw output | Sections D and E: the second producer's runs at the last edit, counts and final lines (section C: the first producer's, at the checkpoint). The full outputs are in the producer's scratch directory and are not kept; the executor's own run at the pushed head (W-C02-20 point 8) is the run of record. |
| Raw evidence ID | **The executor fills it** (its point 8 run). |
| Independence level | Producer: same session, fresh-context subagent (declared, Ek A 5.3); its runs are a self-check. A fresh-context checker that took no part in the change, its tests or the conditions judges both items at the head (W-C02-20 point 13; W-C02-21 point 10). |

## A. W-C02-20, change 1: the stop (rule L4)

### A.1 Point 1: every outbound channel, listed from the guard's code at the head

**Sources and how each was searched.** (1) The guard at the head, read in full: the allow lists `ALLOWED_PREFIXES` (G:95 to G:100, four MCP prefixes), `ALLOWED_NON_MCP` (G:104 to G:112, 28 names), `LOCAL_TOOLS` (G:120 to G:124, the listed tools whose input stays in the session) and `USER_TOOLS` (G:125); what each MCP server may do in `decide()` (G:2093), `session_checks()` (G:1485) and `github_checks()` (G:1579); the shell in `shell_checks()` and `command_checks()`; the push in `push_checks()`, `pushed_blocks()` (G:1925) and `push_leak_checks()` (G:1976). (2) A program that imports the head's guard and prints these lists and the set L4 reads [obs], its output:
```text
ALLOWED_PREFIXES (4): mcp__github__, mcp__claude-code-remote__, mcp__Supabase_DevOS_Salt-okuma__, mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__
ALLOWED_NON_MCP (28): Agent, Bash, Edit, EnterPlanMode, Glob, Grep, NotebookEdit, PushNotification, Read, ReadNotifications, ReportFindings, SendUserFile, Skill, StructuredOutput, SubagentHandback, Task, TaskCreate, TaskGet, TaskList, TaskOutput, TaskStop, TaskUpdate, TodoWrite, ToolSearch, WebFetch, WebSearch, Workflow, Write
USER_TOOLS: AskUserQuestion, ExitPlanMode
LOCAL_TOOLS (23), not read by L4: Agent, Edit, EnterPlanMode, Glob, Grep, NotebookEdit, Read, ReadNotifications, ReportFindings, Skill, StructuredOutput, SubagentHandback, Task, TaskCreate, TaskGet, TaskList, TaskOutput, TaskStop, TaskUpdate, TodoWrite, ToolSearch, Workflow, Write
LOCAL_TOOLS not on the list: none
listed and read by L4 (5): Bash, PushNotification, SendUserFile, WebFetch, WebSearch; and every tool under the 4 prefixes
session tools the guard can allow: create_session, add_repo, create_trigger, get_session, set_session_tags, archive_session, delete_trigger, fire_trigger, get_event, get_trigger, interrupt_session, list_events, send_message, set_session_title, unarchive_session, update_trigger, list_environments, list_repos, read_documentation, send_later, subscribe_pr_activity, unsubscribe_pr_activity
GitHub tools denied by name: create_repository, fork_repository; reads: actions_get, actions_list, get_me, issue_read, pull_request_read and the prefixes get_, list_, search_
Monitor listed: False; in USER_TOOLS: False; L4 in LEAK_WITHHELD: True; L4 in RULES: True
```
(3) `tests/C02/W-C02-20/README.md` section 2's table, compared row by row with (1) and (2): the same tools, the same marks; the 22 session tools above are the README's 4 kept by the bridge and 18 denied by it. (4) The tools' input fields: the tools reference [doc], as the README's section 2 used it.

**The design choice.** The stop reads a call when its tool is under an allowed MCP prefix, or is on `ALLOWED_NON_MCP` and not in `LOCAL_TOOLS` (G:2105). So a tool later added to the allow list is read unless it is also named local: the list of exceptions, not the list of outbound tools, is the one a reviewer must extend. A tool on neither list is denied by T1 or M1 and is not read (`Monitor` among them).

| Tool (where the guard allows it) | Outbound | Read by L4 | Fields that carry text out | Reason for "not", or residual and the layer left |
|---|---|---|---|---|
| `Bash` (`shell_checks`) | yes | yes, its whole input (README R5) | `command`, and every other string | Residual: text the command builds at run time or reads from a file, and text sent from inside an interpreter, a script or a background job (A.3); layer left: the scans after the fact (W-C02-12 point 9, W-C02-18 point 11, EV-C02-003 section 14) |
| a push inside `Bash` (`push_checks`, `pushed_blocks`) | yes | yes, in `push_leak_checks()` (G:1990) | each pushed commit's message, paths and added lines, and the pushed branch names, as L1 reads them | The branch names are also in `command` |
| `WebFetch` | yes | yes | `url`, `prompt` | — |
| `WebSearch` | yes | yes | `query`, `allowed_domains`, `blocked_domains` | — |
| `SendUserFile` | yes | yes | the files' names, the caption | Residual: the files' content leaves too, and the guard reads the call, not the files; no layer is left in the session (README section 2) |
| `PushNotification` | yes | yes | `message` | — |
| `mcp__github__` writes to devos (`github_checks`, then `leak_tool_checks`) | yes | yes, before M2's and L3's checks and before L1 | every string field at any depth | — |
| `mcp__github__` reads | yes | yes | query, path, every field | — |
| `mcp__claude-code-remote__`, the 22 tools above | yes | yes, before S1 to S5 | every string field (a message, a prompt, a title, a query) | — |
| the read-only database connection, both prefixes (`decide()`, M1 allow at G:2117) | yes | yes, before M1's allow | every string field, object keys included | — |
| `Read`, `Glob`, `Grep` | no | no (`LOCAL_TOOLS`) | — | They read local files; a path or pattern stays in the container |
| `Write`, `Edit`, `NotebookEdit` | no | no | — | They write local files; text leaves only by a later push or GitHub write, which L4 reads |
| `Agent`, `Task`, `Workflow` | no | no | — | In-process: a subagent's or workflow agent's own calls pass the guard |
| `Skill` | no | no | — | Loads a skill from the checkout's `.claude/skills/` (T4); none exists at the head (B.5) |
| `ToolSearch`, `StructuredOutput`, `SubagentHandback`, `ReportFindings` | no | no | — | The session's own tool list, and results handed to the calling conversation |
| `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate`, `TaskStop`, `TaskOutput`, `TodoWrite`, `EnterPlanMode`, `ReadNotifications` | no | no | — | The session's own task list, background tasks, mode and notification queue |
| `AskUserQuestion`, `ExitPlanMode` (`USER_TOOLS`) | no | no | — | Shown to the user in the session itself (README section 9) |
| `Monitor` (not on the list at the head) | by its behaviour yes (`command` runs a shell command; `ws` opens a WebSocket), but no call is allowed | no: T1 denies every `Monitor` call before L4 is weighed | none reaches a channel | Not a channel at the head: denied by T1 (W-C02-21; section B). Were it put back on `ALLOWED_NON_MCP`, L4 would read its whole input, since it is not in `LOCAL_TOOLS` (G:2105), but no shell rule would read its `command`, and text the command builds at run time or sends from a script would pass unread; that is why W-C02-21 denies it rather than leaving it to L4 |

### A.2 Point 2: what the stop reads, where it runs, and the results

**What it reads.** `input_strings()` (G:1875) yields every string of the decoded tool input at any depth, object keys included, from the object `main()` decodes with `json.loads` (so a `\u` escape is read decoded; README R4). `token_stop()` (G:1888) applies both finder patterns to each string as it is. Nothing passes through `redact()`, `summary()` or `REDACT` first, and the stop does not use them. For a push, `push_leak_checks()` applies the same stop to the pushed branch names and to every block `pushed_blocks()` gives (each commit's message, its paths, and the lines it adds), after they are read and before L1's comparison.

**Where it runs.** First inside `decide()`'s rules (G:2105 to G:2106), for every call it reads: before the NUL check (moved after it, so that not even a G0 denial can repeat a format string from an outbound call), before the MCP branches (S1 to S5, M2 to M7, L3, L1 and the database connection's M1 allow), and before `Bash`'s B10, B0 to B11, L2 and L1's push allow, and the final T1 allow of `WebFetch`, `WebSearch`, `SendUserFile` and `PushNotification`. Every "allow" an outbound call can get comes after it.

**Its denial.** Rule L4, title "no string of a DevOS token format in outbound text" (`RULES["L4"]`, G:361). The detail names the format only (environment or claim) and says that neither the string nor the field holding it is shown; for a push, "the push (its branch names and commits) carries …". The guard's docstring names L4 among the rule families (G:28 to G:32).

**Results at the head** [obs] (section D, run 1, the same counts as section C, run 1; each case on `PreToolUse` and `PermissionRequest` unless named; the case groups are the README's section 3):

| Group | Lines | Result |
|---|---|---|
| T-W20-2, `P2-*`: 40 shapes, both formats, each denied with its twin allowed (R1) | 160 | all `ok` |
| `P2N-*`: the ✔ near-misses (the markers alone, one character short, no marker, other systems' key shapes, the shared patterns used or quoted, the shared file's path, ordinary research reads, an ordinary push, an ordinary query, N-221 step 5's call shape, an ordinary `send_later`) | 52 | all `ok` (allowed) |
| T-W20-3c1, `P3c1-*`: point 3's cases change 1 already denies | 18 | all `ok` |
| T-W20-4, `P4-*`: 14 fault states × 3 calls, whole-file and follow controls | 132 (+1 `info`) | all `ok` |
| T-W20-5, `P5-*`: nothing repeated | 9 | all `ok` |
| T-W20-6, `P6-*`: the other checks' planted controls | 12 (+1 `info`) | all `ok` |
| T-W20-7, `P7-*`: the scan | 4 | all `ok` |
| `P2R-*`: residuals | 18 `info` | each observed allowed, labelled residual (below) |
| `P1N-*`: channels marked not outbound | 5 `info` | each observed allowed |

**The residuals, never counted as stopped** (W-C02-20 point 2's third bullet; README section 5) [obs, each on both formats, observed allowed]: a string percent-encoded (the marker's `_` as `%5F`, `r-pct-underscore`; every character, `r-pct-all`); base64-encoded (`r-base64`); split across two fields (`r-split-fields`) or across lines (`r-split-lines`); split by a backslash-newline that bash joins (`r-continuation`); built from a shell variable (`r-variable`), by a command substitution (`r-substitution`), or read from a file the command names (`r-file`). The finder patterns do not match the raw input in any of them, so the stop does not see them; the layer left is the scans after the fact, which see only what is stored in the clear (`token_format.md` section 8: they do not decode). The block's "Not covered" (c) names them residuals under D-003 and D-008. Beside them: text that leaves from inside an interpreter or a script, or from a background job, and `SendUserFile`'s file content (A.1).

### A.3 Point 4: the formats from the shared files; missing, unreadable and partial input

`token_finders()` (G:1851) reads, at every call, `scan_patterns.json`'s `token_patterns` object and `token_format.md`'s section 3 (from its heading `## 3.` to `## 4.`), both in `tests/C02/W-C02-07/shared/` under the root two directories above the hook (`TOKEN_FILES`, G:1847). For each of `env_token_find` and `claim_token_find` it requires a string that section 3 also holds in a code span (so the two files agree), and compiles it as written, its case-insensitive marker group included. No copy of a pattern is kept in the guard. Any `OSError` (missing, a directory, a link loop), `ValueError` (invalid JSON or text, no `token_patterns` object, no section 3, the files disagreeing), `KeyError` (a pattern missing), `TypeError` or `re.error` (a pattern that does not compile) raises L4 with the detail "could not check: the token formats cannot be read from <the folder> (<the error>); every call this rule reads is denied until scan_patterns.json and token_format.md section 3 are whole and agree". It is never an allow, and it differs from a match's detail, which never holds the words "could not check" (README R2). The stop loads the patterns before it reads any string, so even a call with an empty input is denied under a fault.

[obs] Every `P4-f-*` case (14 fault states, each in its own scratch tree: the pattern file missing, a directory, a link to itself, cut in half, `token_patterns` not an object; each finder missing; a finder that does not compile in both files and in the pattern file only; the two files disagreeing either way; `token_format.md` missing, a directory, cut before section 3) was denied as "could not check" for an ordinary `WebFetch`, an ordinary comment and a `curl` holding a format string, on both events (84 lines `ok`). In a tree with whole files the controls are allowed (`P4-whole-P2N-*`, 42 lines) and a format string is denied as a match (`P4-whole-stop`); in a tree whose two files alike raise the finder's minimum by four, a string of the old minimum is allowed and one of the new minimum denied (`P4-follow-min`, `P4-follow-stop`), so the stop reads the files beside it. A `Read` under a fault is allowed (`P4-f-json-missing-read`, `info`): L4 does not read it.

**Where the markers may appear** stays as `token_format.md` section 7 states it (only that file and `scan_patterns.json`); this change does not touch it, and `P7-markers` is `ok` at the head.

### A.4 Point 5: nothing repeated

L4 is in `LEAK_WITHHELD` (G:376), so `summary()` (G:459) answers "[withheld: a L4 denial does not repeat the call's text]" for the decision log, the denial's "What was attempted" and `tools/guard_report.py`; the detail (A.2) names no string and no field. Because the stop runs before every other rule of an outbound call (A.2), no other rule's denial of such a call can repeat a format string either. [obs] Every `P5-*` case `ok`: after each of eight planted calls (a web read's query on each event, a `curl` path on each event, an issue's title, a database query, a pushed branch name, a web search), the denial's text, the decision log's record and `guard_report.py`'s output held no format string, and `P5-ctl` showed the search finds one.

**"What to do instead"** (`RULES["L4"]`, verbatim): "Do not send the string by another route. A synthetic test string or planted control is recorded as synthetic in your log entry, and is made at run time inside a program or statement, not written into the call. Any other match is reported to the executor as a finding, without the string; for the environment token's format, EV-C02-003 section 2.2 and plan 6.3 apply: the token is revoked and renewed. If the detail says the shared files cannot be read or disagree, restore both to their text on main (this rule does not read the Read and Write tools) and report it to the executor." The test's word check on this line is a format gate (README T-W20-5); the checker reads the sentence.

### A.5 Point 6: the other checks' planted controls under the stop

| Control (source) | Channel it crosses | Read by L4 | How it is made under the stop, so that it is still made and counted |
|---|---|---|---|
| The log check's part 2 positive control (EV-C02-003 section 14; N-221 steps 6 and 8) | The read-only database connection | yes | **Decided here (N-245 item (2)):** built inside the statement at run time, never written into the call: the statement concatenates the environment marker with a random part the database draws, and fails on it (`P6-log-built`, allowed; its literal form `P6-log-literal` is denied). The count-only search names the marker alone (`P6-log-count`, allowed) |
| W-C02-12 point 9's control (the scan of the repository, branches, issue #6 and the records) | `Bash` if a command held it; a GitHub write or a push if it were planted on GitHub | yes | Planted by a program that reads the shared file and writes the control into the scan's scratch copies of the fetched text (`P6-scan-generated`, allowed; a shell command holding it, `P6-scan-literal`, is denied). Never planted on GitHub: `token_format.md` section 7 forbids a format string in any file, and L4 denies the write |
| W-C02-07 point 7's control (`T-W07-7SCAN`) | `Bash`, running a program that plants at run time | the command holds no format string | As it is (`P6-scan-7scan`, allowed) |
| W-C02-18 point 11's control | as W-C02-12 point 9's | yes | as W-C02-12 point 9's |
| EV-C02-003 section 3.2's scratch file | the `Write` tool (not read); `Bash` (read) | `Write`: no; `Bash`: yes | By a program that makes it (`P6-scan-generated`'s form). The `Write` tool is not read (`P6-scan-write`, observed allowed), but with it the session types the string into its own transcript, which the program form avoids; which form N-221 step 5 uses is the executor's |
| W-C02-20 point 9's own live try | `WebFetch`, `Bash` | yes | Denied by design: that is its purpose |

**Why the built form, and no exception.** An exception for the literal form would have to be as narrow as point 3's, with ✘ cases of its own, for one statement shape on one connection; the built form needs none, crosses the same connection and fails in the same way, and no format string is ever typed into a call. Its premise is the README's open question (1): that Postgres's error for the built value carries that value into the logs, as EV-C02-003 section 14 infers for the literal form [inf, unobserved]. If part 2's first count does not count the built control, the count is "could not check" by section 14's own rule, never zero, and the executor then chooses another form (an exception through a guard change with its own cases is one). The tool that reads the count (open question (2)) is N-221 step 3's to read; L4 allows a count-only search naming the marker alone on any tool of the connection. This answers N-245 item (2)'s question, "how part 2's synthetic control relates to W-C02-11's format stop once it is live", before sitting A is posted.

### A.6 Point 10: class high, and the texts the change makes untrue

The change touches `.claude/` (the guard) and the working order, both class high, so it merges only with a fresh-context checker's verdict at the head that adds it. The guard's docstring names L4 among its rule families (A.2). The texts, each through `plan/decisions/PC-49.md`:

- **Working order section 10, "What it does", the opening paragraph:** unchanged. "Every denial states the rule ID, what was attempted (redacted), …" holds: an L4 denial states its rule, and its attempt is withheld, which the new bullet says.
- **Its rule list:** changes. A new bullet "Token formats" (L4) after the leak check's (PC-49 place 2): the rule list did not name the stop.
- **The leak check's paragraph:** its bullet in the rule list is unchanged (it describes L1 to L3; L4 has its own bullet, PC-49 alternative B). Its "Not caught" bullet under "Not protected" changes in one item: "outbound URLs (a web read whose address carries library text; …)" gains "a string of a DevOS token format there is L4's" (PC-49 place 4); it stays true for library text.
- **"Not protected", "web reads can carry data in their URLs":** changes: "though not a string of DevOS's two token formats, which L4 stops on every outbound route within the limits its rule states" (PC-49 place 3).
- **Plan 6.7's network row (P:734):** changes: its enforcement cell says the stop reads every outbound field and pushes, names the rule and the item, and widens the residual from "data hidden by encoding" to encoding, splitting, building at run time and sending from inside a program; its last cell names W-C02-20's cases and point 9 (PC-49 place 5).
- **N-209:** closed; PC-49 names PC-40 (PR #280) as the carrier of its corrections (1) to (3) and carries none of them.

### A.7 Point 11: PC-23, the parameters that decide when dependent work can start

The critical path's next steps (N-221, at `main` `527ae11`): step 5, the working session's first call over the client path, waits for the identity chain's first part to be built (W-C02-08 and W-C02-09, `planned`) and applied through the migration path (W-C02-03, `running`, L-308), for the log check's part 1 (step 3), and for Batu's step 4 (sitting A, asked after step 3). Step 5 also waits for W-C02-20's acceptance (N-221's line of 2026-10-12, L-294).

| Parameter | Time it adds on the critical path | Its reason's source, and the source's date | Check against Batu's later decisions | What would end it sooner at the same quality, and whose call |
|---|---|---|---|---|
| (a) The deadline: before N-221 step 5, and before any session runs in `devos-calisma`, `devos-denetim` or `devos-sinav` | Change 1: none [inf]. It can merge with W-C02-21 at this head, while step 5 waits on W-C02-08, W-C02-09 and W-C02-03, none of which waits on it. Change 2: from the client script's merge to change 2's merge, about the time this change took (its tests written about 02:24Z to 03:43Z, the producer and the checker after; a few hours) [inf]; it adds time to step 5 only if Batu's step 4 is done before change 2 merges, since step 4 is asked after step 3 and his answer takes hours or days (his steps so far) | EV-C02-003 section 1.6 ("W-C02-11 (before task 7)") and section 1.7; N-221's line "Step 5 also waits for W-C02-20's acceptance" (2026-10-12, L-294); W-C02-20's body (owner and deadline, 2026-10-12); plan 6.7's network row (P:734, its cells as PC-40 left them, 2026-10-12) | D-033 (answered 2026-10-12T19:50Z) concerns how a user's words are read and does not bear on the guard or the order; D-034 to D-037 are open questions, not decisions; D-030 (C01's combined scenario, answered 2026-10-12T06:04Z), D-031 (the form of a "no" discipline answer, accepted) and D-032 (withdrawn) do not bear on it either (their front matter, read 2026-10-13). No later decision of Batu's changes the deadline | Change 2's tests written as soon as the client script's path, its call forms and how it learns its host are known (README section 7, "Needed from the producer before writing"), in parallel with the wait for Batu's step 4. The executor's call |
| (b) The split into two changes | None for change 1; change 2's time as in (a) | W-C02-20's body: "The item may land in two changes" (2026-10-12, b341700, PR #293); the client script does not exist on `main` | As in (a) | None at the same quality: change 2 needs the script's merge commit, which W-C02-09 makes. The executor's call |
| (c) `depends_on` W-C02-07 and W-C02-11 (whole acceptance), though the item uses only W-C02-07's shared files and W-C02-11's settled guard | None now: W-C02-11 was accepted with W-C02-20's admission (2026-10-12T19:03Z, b341700; CHK-C02-022) and W-C02-07 on 2026-10-13 (L-306, CHK-C02-046); W-C02-20's work started at about 02:24Z (L-308). The wait from admission to W-C02-07's acceptance, about six and a half hours, was off the critical path, since step 5 waited, and waits, on later work [inf] | W-C02-20's front matter (2026-10-12); the ledger's frontier rule (working order section 4 step 1) | As in (a) | Depending on the merge commit of the two shared files rather than on W-C02-07's acceptance, as the item does for the client script; it would have changed nothing here, since the files reached `main` with W-C02-07's acceptance. The executor's call |
| (d) The merge order with W-C02-21 (W-C02-21 point 7 (a)) | None: both changes merge at one head, judged by one checker (L-309), so W-C02-20's point 8 (a suite with no `BAD` line, which holds W-C02-21's cases) is met by the same merge | W-C02-21 point 7 (a) and L-309 (2026-10-13) | As in (a) | None: a separate merge of W-C02-21 first would add a checker cycle. The executor's call |

### A.8 Fault handling's own residual, and findings outside the item (reported, not done)

- **The stop's patterns live on a class-normal path, read from the live tree** [obs: `tools/merge_gate.py`'s `HIGH_PREFIXES` do not include `tests/`; the guard's F1 and B5 guard `.claude/`, `tools/` and `.git/` of the live tree, not `tests/`]. A change to `tests/C02/W-C02-07/shared/` on `main` merges without a checker verdict and takes effect at the next sync; a session's edit of the live tree's copies takes effect at once. Two equal edits that weaken a finder (a longer minimum, say) weaken the stop without any "could not check"; one that breaks or deletes a file denies every outbound call, `Bash` included, until a `Write` or `Edit` (not read by L4) restores it. The working order's new bullet states this (PC-49 place 2). Making that folder class high is a change of `tools/merge_gate.py`, outside this item: reported to the executor.
- **`tools/test_merge_gate.py` fails with the stop** [obs, run 3 in section C, and section D, run 3]: its fixture copies only `tools/merge_gate.py` and the guard into a scratch repository, without the shared files, so the guard's merge cases there are denied by L4 as "could not check": `MERGE_GATE_TEST FAIL (73/78)`, the five failures being (1g), (2g), (10), (23g) and (23h). On a scratch copy whose fixture also writes the two shared files, the same guard gives `MERGE_GATE_TEST PASS (78/78)`. The fix is a two-path addition to that fixture's file list in `tools/test_merge_gate.py` (class high), outside this item's files: reported to the executor. `tools/test_tool_allowlist.sh`'s own fixture checkout (the T4 skill cases) calls only the `Skill` tool, which L4 does not read, and its shallow-checkout case holds the shared files, so the suite is unaffected.
- **N-269 (a `tool_input` that is a string or a list crashes the denial) is unchanged by this change** [obs: the code at the head; `W21-c-input-string` and `W21-c-input-list` `ok` in section D's run]. `decide()` still answers G0 for such an input before the stop is weighed (G:2101 to G:2102), and `summary()` then fails while the denial is built, as before: exit 2 on `PreToolUse`, the wrapper's deny on `PermissionRequest`, no log record. The change moved only the NUL-byte check, which reads an input already known to be an object: it now runs after the stop and raises `Bad("G0", …)` inside the `try`, which `decide()` returns as the same deny with the same detail. For a tool L4 does not read (`Monitor` among them) the result is as before; for one it reads, a format string is denied first by L4, withheld, and otherwise G0 follows; under a fault of the shared files the call is denied by L4 as "could not check" rather than by G0. No path reaches `summary()` with a non-object input in a new way, so the change neither fixes N-269 nor makes it worse; its fix stays with the first guard change after this one (N-269's deadline).

### A.9 Point 7: no format string in the change, no marker outside its files

[obs, section C, runs 1 and 4, and section D, runs 1 and 6] `P7-ctl` showed the scan finds a planted synthetic string of each format, and each marker, in a scratch copy; then `P7-change` (the files of the change against `origin/main`, untracked files included), `P7-tree` (every file of the working tree) and `P7-markers` were `ok`. The producer's own scan of every file it wrote or changed, with both finder patterns read at run time from the shared file and the two markers taken from them, found no format string and no marker (section C, run 4). This record, PC-49 and the guard name the formats only through the shared files.

## B. W-C02-21: the guard denies `Monitor`

### B.1 The change

The guard's diff takes `"Monitor"` off `ALLOWED_NON_MCP` and writes the reason beside the list (G:113 to G:115): its command runs in the same shell as `Bash`'s and its `ws` input opens a WebSocket to any address, while no shell rule (B1 to B11, G0, L1, L2) reads it, and L4, were it listed, would check only the two token formats; nothing in the installation needs it; to wait, use `Bash` with `run_in_background`, or `send_later`. No other name is removed or added, `USER_TOOLS` is unchanged, and no allowed MCP prefix covers `Monitor` (A.1's output). T1's text is unchanged; the working order's "Tools" bullet names `Monitor` and the means to use instead (PC-49 place 1). The other changes of this diff (L4, `LOCAL_TOOLS`, the NUL check's place) are W-C02-20's; none changes a decision of a call that holds no format string, as point 2's comparison shows (B.3).

### B.2 Points 1 and 2: the cases at the head [obs, section D, run 1]

Every `W21-x-*` line (14 inputs on both events, 28 lines, and `W21-x-list`) `ok`: denied by T1. Every `W21-c-*` line (6) `ok`. Every `W21-ok-*` line (41: `Bash` with the same commands allowed under B0 or denied by its own rule; the list check; each of the 28 other listed tools denied by T1 on neither event; both matchers covering `Monitor`) `ok`. 76 of 76.

### B.3 Point 2: the suite at the head and at the base

The base is `a527a29` (the branch's commit holding both items' tests on `main` `527ae11`'s guard, blob `956f1b3`). [obs, section D, runs 1 and 2] The head's run is the working clone's at the last edit; the base's ran in a copy of the same tree (`cp -a`, so the same `origin`, the GitHub repository) with only the guard replaced by `a527a29`'s:

| | `ok` | `BAD` | `info` | Last lines |
|---|---|---|---|---|
| Base | 977 | 307 | 26 | `TOKEN_STOP_TEST FAIL (ok 109, BAD 278, info 25)`, `ALLOWLIST_TEST FAIL` |
| Head | 1284 | 0 | 26 | `TOKEN_STOP_TEST PASS (ok 387, BAD 0, info 25)`, `ALLOWLIST_TEST PASS` |

At the base, 278 `BAD` lines are W-C02-20's (`W20-*`, its stop not on `main`) and 29 are W-C02-21's (`W21-*`); at the head none is. Outside the `W20-*` and `W21-*` lines, the 822 lines of the two runs have the same status line for line once temporary paths are normalised; the only text that differs is the suite's count line "… denials, each with rule, attempt, reason, place, alternative and log entry", `ok` in both, whose number counts the run's denials and so grows with the stop. So no other decision changed. With W-C02-20 merged at the same head, no `BAD` line belongs to an unmerged item. (The first producer's comparison ran in `git clone` copies whose `origin` was a local path: 975/309/26 at the base and 1282/2/26 at the head, the two extra `BAD` lines being push controls that such a clone denies by B3, as W-C02-21's README section 7 found; section C.)

### B.4 Point 4: the text the finding makes untrue

**Every hit of `git grep -n -w Monitor` at the head**, with its disposition (taken by the first producer over its working tree, which is the head's content, and taken again by the second at its last edit, every line number below confirmed; section D):

| File: lines | What it is | Disposition |
|---|---|---|
| `.claude/hooks/tool_allowlist.py`: 113 | the reason beside the allow list (this change, G:113 to G:115) | true as written |
| `DURUM.md`: 20; `plan/ledger.md`: 27 | the generated Turkish summary (`summary_tr`): "`Monitor` aracı … kabuk komutu çalıştırabiliyordu; araç kapatılacak" | true as written at the head; the executor's next `summary_tr` records the merge |
| `plan/ledger.md`: 36, 177 | W-C02-21's title in the generated item lists | true as written |
| `evidence/C01/checks/CHK-C01-051.md`: 116; 136, 138 | line 116 (the verdict); the annotation's own lines | 116: **annotated** (below the verdict, dated, naming W-C02-21); 136, 138: the annotation |
| `evidence/C01/checks/CHK-C01-052.md`: 44, 54; 118, 120 | lines 44 and 54 (the verdict); the annotation's own lines | 44, 54: **annotated** (below the verdict); 118, 120: the annotation |
| `evidence/C01/routine/runs/*/OPENING.md` (9 files: CS1 :13, CS2 :13, P1 :19, P2 :13, P3 1420Z :9, P3 1448Z :13, P4 :13, R1a :23, R1b :23) | each C01 routine run's own list of the tools it was offered (2026-10-11 and 2026-10-12) | true as written: a record of what was offered then, which says nothing of the guard's decision |
| `evidence/C02/EV-C02-006_session_tools_bridge.md`: 98; 315, 317 | line 98; the annotation's own lines | 98: **annotated** (a dated section at the end of the file; the line kept); 315, 317: the annotation |
| `evidence/C02/raw/W-C02-11_executor_tool_list_before_20261012.md`: 18 | the working session's tool list before the bridge (a self-report of 2026-10-12) | true as written |
| `plan/Installation_Working_Order.md`: 137 | section 10's "Tools" bullet | **corrected** through PC-49 place 1: it now names `Monitor` as denied, with its reason |
| `plan/decisions/PC-49.md`: 3, 4, 11, 12, 14, 31, 33, 89 | this change's plan-change record | true as written |
| `plan/ledger/C02-log.md`: 321, 323, 324, 325 | L-309, the append-only entry that records the finding and the decision | true as written |
| `plan/work/W-C02-21.md`: 26 lines | the item | true as written |
| `tests/C02/W-C02-20/README.md`: 15 lines, among them section 2's table (line 45) | W-C02-20's tests, as revised for W-C02-21 | true at the head: `Monitor` is denied by T1 |
| `tests/C02/W-C02-21/README.md`: 31 lines | W-C02-21's tests | true as written |
| `tools/test_token_stop.py`: 289, 291 | the comment on the two withdrawn cases | true as written |
| `tools/test_tool_allowlist.sh`: 28 lines (782 to 887) | the `W21-*` block | true as written |
| this record: every hit in it | this record's own text | true as written |

**At least the four named:**
- `evidence/C02/EV-C02-006_session_tools_bridge.md` line 98: **annotated** (a dated section at the end of the file, naming W-C02-21; the line kept). `Monitor` does not only act on the session's own background work; the line's other statements stand.
- `evidence/C01/checks/CHK-C01-051.md` line 116: **annotated** below the verdict (a dated section at the end; the verdict not edited).
- `evidence/C01/checks/CHK-C01-052.md` lines 44 and 54: **annotated** below the verdict, one dated section for both lines. Line 54's recommendation ("wait inside the turn (Monitor, allowed T1)") did not go into any instruction: `evidence/C01/routine/CONTROL.md`'s P1 item 1 says "wait for its completion before item 2" and names no means, and the search below finds no instruction naming `Monitor`. So no instruction changes.
- `tests/C02/W-C02-20/README.md` section 2's table: its `Monitor` row ("denied by T1 under W-C02-21") is true at the head: true as written.

**Working order section 10.** The "Tools" paragraph changes (PC-49 place 1): "among others" kept it true, but `Monitor` is the one denied tool a record told sessions to use, so it is named with its reason and the means to use instead. The "Shell" paragraph does not change: it names the shell rules, not the tools they read, and with `Monitor` denied `Bash` is the only listed tool whose input is a shell command (PC-49, "Places checked").

**✘ Looked for: no instruction names `Monitor` as a means a session should use** [obs, section C, run 7, and section D]. `git grep -n -i -w monitor` over `CLAUDE.md`, `.claude/agents/`, `.claude/skills/` (absent at the head), `plan/Installation_Working_Order.md`, `plan/DevOS_Kurulum_Plani.md`, `plan/Ek_*.md` and `evidence/C01/routine/CONTROL.md`: the only hits are the working order's "Tools" bullet as PC-49 changes it, which names `Monitor` as denied, not as a means.

### B.5 Point 5: the same failure class by other routes

**The failure class:** a tool the guard allows by name whose input runs a command or opens a network connection, which none of the guard's shell or network rules reads.

**Each other tool on `ALLOWED_NON_MCP` at the head** (sources: the tools reference, workflows, skills and plugin component pages of `https://code.claude.com/docs/en/`, read 2026-10-13 at about 03:50Z by the first producer [doc]; not re-read by the second, which had no web reader; where no page describes a tool, the answer is "could not check"):

| Tool | Does its documented input or behaviour run a command or open a connection? | Source | What reads it |
|---|---|---|---|
| `Bash` | yes, by design | tools reference, `Bash` row | the shell rules and L4 |
| `WebFetch`, `WebSearch` | yes: each opens a connection (a URL; a search) | tools reference, their rows | L4 (the two formats only); any other data in a URL is D-008 cost 1's residual (working order section 10, "Not protected") |
| `SendUserFile` | yes: "Delivery runs through Anthropic-hosted infrastructure" to the user's device | tools reference, its row | L4 reads the names and caption; the files' content is a residual (A.1) |
| `PushNotification` | yes: "Push delivery runs through Anthropic-hosted infrastructure" | tools reference, its row | L4 reads its message |
| `Workflow` | no: "No direct filesystem or shell access from the workflow itself … Agents read, write, and run commands" | workflows page, "Behavior and limits" | its agents' calls pass the guard (T3, T4) |
| `Skill` | **yes**: a skill's text can hold lines of the form "!" followed by a command in backticks, which "runs shell commands before the skill content is sent to Claude", through the Bash tool; "Claude Code checks each one against your permission rules"; whether the guard's `PreToolUse` hook sees them is not stated: **could not check** | skills page, "Inject dynamic context" and "How injected commands run" | T4 admits only a skill under the checkout's `.claude/skills/` (none exists at the head, so every `Skill` call is denied), and `.claude/` is class high, so such a line would reach the merge gate's checker; the setting `disableSkillShellExecution`, which replaces each such command with a placeholder, is not set |
| `TaskStop` | no: "Stops a running background task by ID" | tools reference, its row | — |
| `TaskOutput` | no: "Retrieves output from a background task" | tools reference, its row | — |
| `NotebookEdit` | no: it replaces, inserts or deletes one cell's source; nothing says it runs a cell | tools reference, "NotebookEdit tool behavior" | — |
| `Read`, `Glob`, `Grep`, `Write`, `Edit` | no: they read, find, search or write files | tools reference, their rows | — |
| `Agent` | no: it spawns a subagent, whose own calls pass the guard | tools reference, `Agent` row | T2, T4 |
| `Task` | **could not check**: the tools reference has no `Task` row; the guard treats it as the `Agent` tool (`SUBAGENT_TOOLS`) | — | T2, T4 |
| `ToolSearch` | no: "Searches for and loads deferred tools" | tools reference, its row | — |
| `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate`, `TodoWrite` | no: the task list | tools reference, their rows | — |
| `EnterPlanMode` | no: "Switches to plan mode" | tools reference, its row | — |
| `ReportFindings` | no: renders a list of findings | tools reference, its row | — |
| `SubagentHandback` | no: delivers a subagent's final report | tools reference, its row | — |
| `StructuredOutput` | **could not check**: no page read describes it; observed input: 11 calls in this session's decision log, each a result object for a workflow's output schema [obs] | — | — |
| `ReadNotifications` | **could not check**: no page read describes it; observed input: 7 calls in this session's decision log, each with an empty input [obs] | — | — |

**Plugin monitors.** "Plugins can declare monitors that start automatically when the plugin is active"; such a monitor "is a shell command that runs in the background for the whole session" [doc: tools reference, "Monitor tool"; plugin components page, "Monitors"]. It starts with no tool call, so the guard never sees it. The layer that covers it is PC-35's handling of account-level plugins (working order section 10, "Hooks from plugins enabled at account level"): `.claude/settings.json` turns ECC off for this repository's sessions (`enabledPlugins`, `ecc@synced: false`), whose effect for an account-level plugin is observed, not documented; any other plugin's monitors are a **residual**. [obs, 2026-10-13, this container] No plugin under `/root/.claude/plugins` declares a monitor: no `monitors` folder or `monitors*.json` file, and none of the 36 `plugin.json` manifests (hidden folders included) holds a `monitors` or `experimental` key. The opening check of working order section 3 counts plugin hooks, not monitors.

**`Monitor` on `.claude/settings.json`'s deny list as a second layer: not added in this change.** The guard denies every `Monitor` call by T1 on both events (both matchers are `.*`; `W21-ok-matcher`), and W-C02-21 point 6 observes it live; a permission-layer deny would add a class-high file and its tests for a tool the installation does not use. Whether a deny rule would also keep plugin monitors from starting (the plugin page says they do not start where the `Monitor` tool is "unavailable" for provider or telemetry reasons) is not stated: could not check. The executor may revisit it.

**Which of them are in the class.** The class needs both halves: the tool runs a command or opens a connection, and no shell or network rule reads it. `Bash` is read by the shell rules and L4. `WebFetch`, `WebSearch`, `SendUserFile` and `PushNotification` open their connections by design and are read by L4, for the two token formats only; all their other data is the stated residual of D-008 cost 1 (working order section 10, "Not protected", third bullet), and `SendUserFile`'s file content is A.1's residual. `Skill` is "yes" with "could not check" on whether the guard sees its injected commands. `Task`, `StructuredOutput` and `ReadNotifications` are "could not check". The plugin monitors (above) are in the class and outside every guard rule.

**Proposed stage notes for the executor** (point 5: a "yes" or a "could not check" becomes a stage note on `plan/work/C02.md`, or an item, with its owner; this item does not fix them, and neither producer writes that file): (0) `WebFetch`, `WebSearch`, `SendUserFile` and `PushNotification`: L4 is their only content check in the guard, for the two formats only, and their other data is D-008 cost 1's residual, whose negative test is C03 test 3; the note records that, since point 5 asks one of every "yes". (1) `Skill`'s injected command lines: whether the guard's hook sees them, and whether `.claude/settings.json` sets `disableSkillShellExecution`, before the first repository skill is added. (2) `Task`, `StructuredOutput` and `ReadNotifications`: their behaviour from a primary source, or a decision to take them off the list. (3) Plugin monitors in sessions with plugins other than ECC: a count of monitors at the opening check beside the count of hooks, or a stated residual. Owner: the executor.

### B.6 Point 7: PC-23

- **(a) The order with W-C02-20:** kept as one merge at one head (A.7 (d)); it adds no time to W-C02-20, and so none to N-221 step 5. What would end it sooner at the same quality: none. Source: W-C02-21 point 7 (a) and L-309, 2026-10-13. The executor's call.
- **(b) This item's deadline:** set by the executor (W-C02-21's body). Proposed: with W-C02-20's change 1, and in any case before N-221 step 5 and before any session runs in `devos-calisma`, `devos-denetim` or `devos-sinav`, since W-C02-20's channel table leaves `Monitor` out on the premise that T1 denies it, and until then a `Monitor` command can send what the stop does not read. Source: W-C02-20's deadline (2026-10-12) and README section 11 (2026-10-13). No later decision of Batu's bears on it (A.7 (a)).
- **(c) `depends_on: []`:** nothing waits on this item but W-C02-20's point 8 (a), and the README's `Monitor` row's premise.

### B.7 Point 9: evidence

The envelope above covers both items: the source commit and the guard's blob (the executor fills them), `.claude/settings.json` (unchanged) and `tools/test_tool_allowlist.sh` (unchanged by the change), the criterion version (`527ae11`), the input (the `W21-*` block), the raw output (section C), the raw evidence ID (the executor's) and the independence level.

## C. The first producer's runs (2026-10-13, at the checkpoint's working tree; observed; a self-check)

The second producer did not take these as checked: it re-ran the suite at the head, the base comparison, the merge gate's test, the scan and breaks W20 (a), (b), (g), (h) and W21 (i) at its last edit (sections D and E). Where a number below differs from D or E, D and E hold.

1. **The whole suite at the head**, `bash tools/test_tool_allowlist.sh` at the working clone's root, 03:58:23Z to 04:01:21Z: `ok 1284, BAD 0, info 26`; `W20-*` 387 `ok`, `W21-*` 76 `ok`; last lines `TOKEN_STOP_TEST PASS (ok 387, BAD 0, info 25)` and `ALLOWLIST_TEST PASS`; exit 0. No output line holds a format string (`P7-*`; the program prints no input).
2. **`python3 tools/test_token_stop.py` alone at the head:** `TOKEN_STOP_TEST PASS (ok 387, BAD 0, info 25)`.
3. **`python3 tools/test_merge_gate.py`:** at `a527a29`'s guard, `MERGE_GATE_TEST PASS (78/78)`; at the head, `MERGE_GATE_TEST FAIL (73/78)` (A.8); on a scratch copy whose fixture holds the shared files, `MERGE_GATE_TEST PASS (78/78)`.
4. **The scan of the change's files** and the final runs at the last edit: section D.
5. **The base in a scratch clone** (B.3): `ok 975, BAD 309, info 26`.
6. **The head in a scratch clone** (B.3): `ok 1282, BAD 2, info 26`.
7. **The `Monitor` searches** (B.4).
8. **The breaks** (W-C02-20 README section 4; W-C02-21 README section 3), each in its own scratch clone with only the guard edited, deleted after: section E.

## D. At the last edit (the second producer's final runs, 2026-10-13; observed; a self-check)

Where: the working clone `cw90`, branch `claude/c02-w20-stop` at `397a39f` with the second producer's edits uncommitted (the change's last state, which the executor commits as the head); its `origin` is the GitHub repository. Each command at the clone's root unless named. Full outputs stayed in the producer's scratch directory and are not kept; the executor's run at the pushed head (W-C02-20 point 8) is the run of record.

1. **`bash tools/test_tool_allowlist.sh`:** `ok 1284, BAD 0, info 26`; `W20-*` 387 `ok` and 25 `info`; `W21-*` 76 `ok` (among them `W21-c-input-string` and `W21-c-input-list`, which read the fail-closed block and the wrapper's deny, N-269); last lines `TOKEN_STOP_TEST PASS (ok 387, BAD 0, info 25)` and `ALLOWLIST_TEST PASS`; exit 0.
2. **The base** (B.3): the same suite in a `cp -a` copy of the clone with only the guard replaced by `a527a29`'s: `ok 977, BAD 307, info 26` (`W20-*` 278, `W21-*` 29, no other); `TOKEN_STOP_TEST FAIL (ok 109, BAD 278, info 25)`, `ALLOWLIST_TEST FAIL`.
3. **`python3 tools/test_merge_gate.py`:** `MERGE_GATE_TEST FAIL (73/78)`, the `BAD` cases (1g), (2g), (10), (23g) and (23h), each a guard call in the test's fixture repository denied by L4 as "could not check" (A.8). In a `cp -a` copy whose fixture list (`tools/test_merge_gate.py` line 90) also names the two shared files, the same guard gives `MERGE_GATE_TEST PASS (78/78)`: the cause is the fixture's missing files, which the stop answers by failing closed, as point 4 asks.
4. **`python3 tools/records.py render --check`:** `DISCIPLINES OK: 151 of 151 log entries from L-159 on carry the nine answers`, `RENDER DIFFERS: plan/ledger.md`, exit 1. Rendered in a scratch copy, the difference is the generated plan-change list's new row for PC-49 and the "Rendered" time (and `DURUM.md`'s update line): generated files that the executor renders in the commit carrying this change; neither producer writes them.
5. **`bash tools/check_service_names.sh`:** `SERVICE_NAMES CLEAN (pattern derived from 3cd686a; 12 terms)`, exit 0.
6. **The scan of W-C02-20 point 7**, a program in the producer's scratch directory that reads the finder patterns and the markers at run time from the shared files (through `tools/test_token_stop.py`'s `load_formats`), plants its controls in a temporary directory outside every repository and prints paths and counts only: each planted string of each format found once; the two markers alone found, holding no format string; a clean file holding neither. Then the 12 files that differ from `main` `527ae11` (both items' tests, the guard, the record, PC-49, the plan texts and the annotations) and the 4 that differ from the checkpoint `397a39f`: no format string. The whole tree (1039 files): no format string; the markers only in `tests/C02/W-C02-07/shared/scan_patterns.json` and `token_format.md`, the two files `token_format.md` section 7 allows. The outputs of every run in this section and in E: no format string.
7. **The `Monitor` searches** (B.4): `git grep -n -w Monitor`, every line number of B.4's table confirmed at the last edit; `git grep -n -i -w monitor` over the instruction files of B.4's last paragraph: the one hit, the working order's line 137.
8. **Plugin monitors** (B.5), re-checked with the Glob and Grep tools: 36 `plugin.json` manifests under `/root/.claude/plugins`, none with a `monitors` or `experimental` key, and no `monitors` folder; the files whose names hold "monitor" are ECC's hook scripts and their tests, not monitor declarations.
9. **PC-49's texts:** a program compared each Old text of PC-49 with `main` `527ae11` and each New text with the working tree: each Old text occurs once on `main` and not at the head, each New text once at the head and not on `main`; the two plan files differ from `main` in the five places PC-49 names and nowhere else; the line numbers PC-49 cites hold at `527ae11`.

## E. The breaks (a self-check; the checker builds them again from `git show` of the head)

**The first producer** made each break in its own `git clone` of the working clone with the head's guard diff applied, then edited only the guard (the edit script and the clones lived in its scratch directory, outside every repository, and were deleted after). For W-C02-20, `python3 tools/test_token_stop.py` ran at the clone's root (its `FAIL` turns the suite's last line to `ALLOWLIST_TEST FAIL`, since the suite counts it); for W-C02-21, the whole suite. Counts are lines; each case runs on both formats and both events unless named.

**The second producer rebuilt breaks W20 (a), (b), (g), (h) and W21 (i) at its last edit** [obs], each in its own `cp -a` copy of the working clone (so the same `origin` and the change's last state), in its scratch directory outside every repository, with only the guard edited by a script that requires each edited text to occur once; the whole suite ran at each copy's root, and the copies were deleted after. Every one ended `ALLOWLIST_TEST FAIL`. Its results are marked "second producer" in the rows below; outside the `W20-*` and `W21-*` lines each of its runs had the base's statuses line for line (section D run 2; temporary paths normalised; only the count line of denials differs in its number). The rows not so marked are the first producer's alone: the guard code they exercise is unchanged since (the second producer changed only the comment beside the allow list), but they were not rebuilt.

| Break | The edit | Result | Cases turned `BAD` |
|---|---|---|---|
| W20 (a) the stop removed | both `token_stop` calls removed | `TOKEN_STOP_TEST FAIL (ok 109, BAD 278, info 25)` | exactly the base's 278 `W20-*` `BAD` lines (compared line for line): every ✘ case. **Second producer** (the call in `decide()` replaced by `pass`, the push's call deleted): the same `TOKEN_STOP_TEST` line; suite `ok 1006, BAD 278, info 26`; its 278 `BAD` lines identical, line for line, to the base's `W20-*` `BAD` lines; no `W21-*` line `BAD` |
| W20 (b) the stop on the redacted text | each string passed through `redact()` first | `FAIL (ok 349, BAD 38)` | `P2-wf-token-eq`, `-wf-sk`, `-gh-header`, `-gh-title-ghp`, `-sh-curl-header`, `-sh-curl-sk`, `-sh-wget-header`; `P3c1-p3-curl-live`, `-curl-test`, `-curl-other`, `-beside`, `-env-live`: the README's list, nothing else. **Second producer** (`for t in map(redact, texts)` in `token_stop()`): `TOKEN_STOP_TEST FAIL (ok 349, BAD 38, info 25)`, suite `ok 1246, BAD 38, info 26`; the same twelve case IDs, nothing else |
| W20 (c) the marker matched in one case only | the patterns compiled without their case-insensitive group | `FAIL (ok 359, BAD 28)` | `P2-wf-query-upper`, `-gh-pr-upper`, `-gr-path-mixed`, `-push-path`, `-st-message-upper`, `-sh-wget-path-upper`, `-sh-git-remote-mixed`: the README's list |
| W20 (d) `Bash`'s command not read | `Bash` skipped by the call-level stop | `FAIL (ok 293, BAD 94)` | every `P2-sh-*`, every `P3c1-*`, every `P4-f-*-curl-string`, `P5-curl-path-*`, `P6-scan-literal`; the push cases stay `ok` |
| W20 (d) the push's commits not read | the push's stop removed | `FAIL (ok 375, BAD 12)` | `P2-push-line`, `-msg`, `-path`; `P2-push-branch` stays `ok` (its name is in the command) |
| W20 (d) the database connection not read | its two prefixes skipped | `FAIL (ok 372, BAD 15)` | `P2-db-*`, `P5-db-query-claim`, `P6-log-literal` |
| W20 (d) `PushNotification` not read | the tool skipped | `FAIL (ok 379, BAD 8)` | `P2-pn-*` |
| W20 (g) "could not check" taken as no match | a fault answered with no patterns | `FAIL (ok 303, BAD 84)` | every `P4-f-*` (84 lines), nothing else. **Second producer** (`return []` as the first line of `token_finders()`'s `except`): `TOKEN_STOP_TEST FAIL (ok 303, BAD 84, info 25)`, suite `ok 1200, BAD 84, info 26`; all 84 `P4-f-*`, nothing else |
| W20 (h) the denial not withheld | L4 taken out of `LEAK_WITHHELD` | `FAIL (ok 379, BAD 8)` | every `P5-*` but `P5-ctl`. **Second producer** (the same edit): `TOKEN_STOP_TEST FAIL (ok 379, BAD 8, info 25)`, suite `ok 1276, BAD 8, info 26`; the eight `P5-*` cases other than `P5-ctl`, nothing else |
| W20 (i) nested fields not read | only the input's top-level string values read | `FAIL (ok 367, BAD 20)` | `P2-ws-glued`, `-gh-nested-cut`, `-db-nested-glued`, `-db-key`, `-uf-name-cut` |
| W20 (j) the bytes on standard input read | the finder applied to the hook's raw standard input | `FAIL (ok 383, BAD 4)` | `P2-wf-uescape` |
| W20 (k) the patterns from another tree | the folder written as the working clone's shared folder, whatever tree the hook is in | `FAIL (ok 301, BAD 86)` | every `P4-f-*` and `P4-follow-min` |
| W21 (i) `Monitor` back on the list | `"Monitor"` added to `ALLOWED_NON_MCP` | `ok 1253, BAD 31`, `ALLOWLIST_TEST FAIL` | all 28 `W21-x-*` decision lines and `W21-x-list`; besides them only the clone's two local-origin push controls, as at the clone's base. **Second producer** (`"Monitor"` put back between `"TodoWrite"` and `"WebFetch"`): suite `ok 1255, BAD 29, info 26`, `TOKEN_STOP_TEST PASS (ok 387, BAD 0, info 25)`, `ALLOWLIST_TEST FAIL`; the 28 `W21-x-*` decision lines and `W21-x-list`, nothing else; every `W21-c-*` and `W21-ok-*` `ok` |

A first attempt of the second producer at W21 (i) is not counted: its edit appended a comment in the middle of the list's line, which also took `WebSearch`, `EnterPlanMode` and `SendUserFile` off the list, so `W21-ok-list`, `W21-ok-listed` and W-C02-20's `WebSearch` and `SendUserFile` cases turned `BAD` as well. The row above is the corrected edit's run, in a fresh copy.

The W-C02-20 breaks (d) for `WebFetch`, `WebSearch`, `SendUserFile`, the GitHub tools and the session tools were built by neither producer, nor were W-C02-21's breaks (ii) to (iv); the checker builds every break.
