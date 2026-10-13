# W-C02-20 · Tests of the guard's stop of both token formats (change 1, the stop)

Synthetic test data (plan Section 8 item 13): this file holds no token, no marker, no pattern and no example of either DevOS token format. It names the formats only through `tests/C02/W-C02-07/shared/token_format.md` ("the shared file") and its machine copy `shared/scan_patterns.json`. "The environment marker" and "the claim marker" below are names for the two markers of the shared file's sections 1 and 2, not values.

## 0. What this is

- **Serves** `plan/work/W-C02-20.md`: point 1's channel list (section 2 here), points 2, 4, 5 and 6 (section 3), point 3's cases that change 1 already denies (section 3, T-W20-3c1), point 7's breaks (section 4), point 2's residuals (section 5) and point 6's list (section 6). Change 2's cases (point 3's exception) are specified in section 7 and written once the client script is on `main`.
- **Written** by the test designer (a fresh-context `test-designer` subagent that does not produce the change) on 2026-10-13, from the guard at `main` `c09797ff630ab357cb33b0ed9fe8c503bede86ac`, before any change to the guard exists (point 7). **Revised** on 2026-10-13 by W-C02-21's test designer, another fresh-context `test-designer` subagent, before any run against a stop. `Monitor` is no longer a channel the stop reads, and R3 records the executor's reading. Section 11 says what changed and why this does not loosen anything.
- **Files.** `tools/test_token_stop.py` holds every case (Python 3, standard library only). One added line in `tools/test_tool_allowlist.sh` runs it, so that its final line (`ALLOWLIST_TEST PASS` or `FAIL`) counts these cases. This file holds their form-C0 text.
- **How to run.** At a checkout's root: `bash tools/test_tool_allowlist.sh` (the whole guard suite), or `python3 tools/test_token_stop.py [hook-path]` alone. Each case prints one line: `ok   `, `BAD  ` or `info `, then `W20-<case ID>`, the channel in brackets, the format (`env`, `claim`, or `-` for none), what the call carries (with the word "synthetic"), and the event (`PreToolUse` or `PermissionRequest`). No line prints a case's input. The program's last line is `TOKEN_STOP_TEST PASS` or `FAIL` with its counts; it exits 1 on any `BAD`.
- **Expected against a guard without the stop** (the guard at `c09797f`): every ✘ case of points 2, 3 (change 1), 4 and 5, and point 6's two ✘ cases, are `BAD`. Every ✔ control is `ok`. Point 7's scan is `ok`. Residuals and records are `info`. The executor's record carries that run.

## 1. The facts the tests are written to, and the readings this file takes

**Fixed by the executor** (the producer builds to the same facts):
1. Two changes. Change 1, the stop: points 1, 2, 4 to 8 and 10 to 12. Change 2, the client path's exception (point 3): once W-C02-09's client script is on `main`. Under change 1, every string of either format in a channel the stop reads is denied, the live host's included.
2. At every call, the stop reads the finder patterns from `tests/C02/W-C02-07/shared/scan_patterns.json` and from section 3 of `token_format.md`. Both paths are resolved against the root two directories above the hook file (`.claude/hooks/tool_allowlist.py`), so a copy of the hook in a scratch tree reads that tree's files. The two files must agree. Any fault of point 4 gives "could not check", which denies every call the stop reads, with a reason distinct from a match's. The guard keeps no copy of the patterns.
3. The stop reads the raw tool input as the hook receives it: the whole input object, every string at any depth. It reads it before `redact()`, `summary()` or any masking, for every call whose channel point 1 marks outbound. It runs before every rule that answers "allow" for such a channel. Its denial withholds the call's text, as L1's does.
4. Tests go in `tools/test_token_stop.py`, run by one line of `tools/test_tool_allowlist.sh`, with their text in this file. Every format string is made at run time from `scan_patterns.json`, labelled synthetic, never printed.
5. No case touches the network. Point 9's live try is the executor's, after the merge.

**Readings this file takes.** Each is the designer's decision, and a checker may judge it.
- **R1 Isolation by a twin.** Every ✘ case has a twin: the same call, with only the marker replaced by a word of the same length and shape that is no marker (for example the letters turned to `q`). A ✘ case is `ok` only when the planted call is denied and its twin is allowed. Then the denial is shown to come from the format string, not from another rule (the idea of W-C02-12 point 7). A twin that is not allowed answers `BAD`. The test does not name the stop's rule ID, which is the producer's to choose.
- **R2 "Could not check" in words.** Point 4's denial must say so: its text holds the words "could not check" (any case). A match's denial must not hold them. Neither may be a guard error (`guard error`, which the guard's own internal-error deny prints) or the settings wrapper's fail-closed deny (`failing closed`). A stop that crashes on a match is therefore never counted as stopping.
- **R3 "Never written to a file."** The format strings are made at run time and never printed. A few cases cannot be made without the disk: the push cases (the stop must read pushed commits, which live in a repository), point 4's scratch trees, point 7's planted copy, and the guard's own decision log of this run. Those writes all stay inside one temporary directory outside the repository (mode 700), which the program removes before it ends. W-C02-07's `T-W07-7SCAN` set the same precedent ("written only into a scratch directory outside the repository and deleted before the program ends"). The block's own point 7 asks for a planted string "in a scratch copy", which is a file. Against a guard without the stop, the decision log of the run holds the ✘ cases' strings until that directory is removed.
  **The executor's reading of point 7's "never written to a file"** (decided 2026-10-13; recorded here by W-C02-21's test designer; the checker judges this reading). A format string is made at run time. It is never written into a file of the repository or of the change, and it is never kept. During a run it may pass through files that the run itself makes in one temporary directory outside every repository and removes at the end. Those files are: the push cases' git objects, point 4's scratch trees, point 7's planted copy, and the guard's decision log in a temporary log directory. `T-W07-7SCAN` does the same. The files are needed because point 2 asks for pushed forms (a push is read from commits) and point 5 asks for a search of the decision log.
- **R4 "Every string at any depth."** Read as: the object keys too, and the decoded input object, not the bytes on standard input. Cases `P2-db-key` (a key) and `P2-wf-uescape` (the hook input's JSON writes the marker's last character as a `\u` escape) test this reading.
- **R5 The shell as a whole is outbound.** The guard's reading of a command is lexical. It cannot tell which command sends data: `curl`, `wget`, git remotes and pushes, interpreter one-liners, DNS tools, a script. So the table marks Bash outbound with its whole input, and a local command holding a format string is denied too. Point 6's controls follow from this (section 6).
- **R6 Terminology.** Appendix C's form C0 calls "Negative control" the check that the wrong solution is caught, and "Positive control" the check that the right solution is allowed. The block's point 2 calls the allowed near-misses "negative controls" (calls with no format string). In the C0 tables below, the block's ✘ cases fill "Negative control" and its ✔ near-misses and the twins fill "Positive control".

## 2. Point 1's channel table (the guard at `c09797f`)

**Sources, and how each was searched.**
- `.claude/hooks/tool_allowlist.py` at `c09797f`, read in full (lines 1 to 2175) in a scratch clone. The allow lists are `ALLOWED_PREFIXES` (lines 91 to 96: four MCP prefixes), `ALLOWED_NON_MCP` (lines 100 to 108) and `USER_TOOLS` (line 109, passed to the user). What each MCP server may do is in `decide()` (lines 2018 to 2027), `session_checks()` (lines 1455 to 1515) and `github_checks()` (lines 1549 to 1578). The shell is in `shell_checks()` and `command_checks()` (lines 935 to 1213), and the push in `push_checks()`, `pushed_blocks()` and `push_leak_checks()` (lines 1346 to 1406 and 1837 to 1910). Masking is in `REDACT` and `redact()` (lines 416 to 426), `summary()` (lines 429 to 445) and `LEAK_WITHHELD` (line 346).
- `.claude/settings.json` at `c09797f`: the bridge's deny list (76 entries), read with a JSON reader. Kept session tools: `evidence/C02/EV-C02-006_session_tools_bridge.md`'s table (rows `add_repo`, `get_session`, `read_documentation`, `send_later`) and working order section 10.
- Tools' input fields: the platform's tools reference, `https://code.claude.com/docs/en/tools-reference.md`, read 2026-10-13. Its rows and sections were used for Monitor (`command`, or `ws` with `url`), SendUserFile (files, a caption, `display`), PushNotification, WebFetch and WebSearch (`allowed_domains`, `blocked_domains`). Documented, not independently tested.
- GitHub's and the Supabase connector's field names were not read from a schema. The stop reads every string at any depth, so the table names fields by example. The cases use fields that `tools/test_tool_allowlist.sh` already uses, or invented ones, which the guard accepts as it accepts any field.

**"Outbound"** means that the text leaves the session's container for a place other than the session's own transcript: the web, GitHub, the database, another session or routine, or Batu's devices. The platform's own reading of the session is not a channel here; it is the block's "Not covered" (c).

| Tool (where the guard allows it) | Outbound | Fields that carry text out | Reason for "not", or residual | Cases |
|---|---|---|---|---|
| Bash (`ALLOWED_NON_MCP`; `shell_checks`) | yes | `command`, all of it (R5), and every other string field | — | `P2-sh-*`, `P3c1-*`, `P6-scan-literal` |
| a push inside Bash (`push_checks`, `pushed_blocks`) | yes | each pushed commit's message, paths and added lines, and the pushed branch names, as L1 reads them | The branch name is also in `command` | `P2-push-*` |
| Monitor: **denied by T1 under W-C02-21** (on `ALLOWED_NON_MCP` at `c09797f` and at `3262699`) | not a channel the stop reads | none: the tool's `command` runs in a shell like Bash's and its `ws.url` opens a WebSocket, but W-C02-21 takes `Monitor` off the list, so rule T1 denies every `Monitor` call, whatever its input | Closed by T1, not by the stop. W-C02-21's cases (`W21-*` in `tools/test_tool_allowlist.sh`) run in the same suite, so this row holds only at a head where they pass (section 11) | none here (`P2-mon-*` withdrawn, section 11); `W21-*` |
| WebFetch | yes | `url`. `prompt` goes to the platform's extraction model | — | `P2-wf-*`, `P2R-r-pct-underscore` |
| WebSearch | yes | `query`, `allowed_domains`, `blocked_domains` | — | `P2-ws-*` |
| SendUserFile | yes | the files' names and the caption | **Residual:** the files' content leaves as well, and the guard reads the call, not the files. No layer is left in the session; the content goes to Batu's device | `P2-uf-*` |
| PushNotification | yes | `message` | — | `P2-pn-*` |
| `mcp__github__` writes to devos (`github_checks`, after `leak_tool_checks`) | yes | every string field at any depth (body, title, content, `files[].path` and `files[].content`, message, branch) | — | `P2-gh-*`, `P2R-r-base64`, `-r-split-*` |
| `mcp__github__` reads (`get_`, `list_`, `search_`, `READ_ONLY_GITHUB`) | yes | query, path and every other field, which go into the request to GitHub's API | — | `P2-gr-*` |
| `mcp__claude-code-remote__` tools the bridge keeps: `send_later`, `read_documentation`, `get_session`, `add_repo` | yes | `send_later`'s message (a routine on the account), `read_documentation`'s query, and every other field. `get_session`'s ID passes only if owned (S1); `add_repo` passes only devos or the library (S5); so a format string there is already denied | — | `P2-st-send-later`, `P2-st-docs-cut` |
| `mcp__claude-code-remote__` tools the bridge denies and the guard allows (`create_session`, `create_trigger`, `update_trigger`, `send_message`, `set_session_title`, `set_session_tags`, `interrupt_session`, `archive_session`, `unarchive_session`, `list_events`, `get_event`, `fire_trigger`, `delete_trigger`, `get_trigger`, `subscribe_pr_activity`, `unsubscribe_pr_activity`, `list_environments`, `list_repos`) | yes (the guard is the second layer) | every string field (prompt, message, title) | — | `P2-st-message-upper` |
| `mcp__Supabase_DevOS_Salt-okuma__` and `mcp__86834617-…__`, the read-only database connection (`decide()` line 2026) | yes | every string field (query, project ID, filters, search terms), keys included (R4) | — | `P2-db-*`, `P6-log-*` |
| Read, Glob, Grep | no | — | They read local files. Their path and pattern stay in the container | `P1N-read-path`, `P1N-grep-pattern` (`info`) |
| Write, Edit, NotebookEdit | no | — | They write local files. Text leaves only by a later push or GitHub write, which the stop reads | `P1N-write-content`, `P6-scan-write` (`info`) |
| Agent, Task | no | — | In-process subagent: its prompt stays in the session (the block's own example). The subagent's own calls pass the guard | `P1N-agent-prompt` (`info`) |
| Workflow | no | — | In-process workflow (T3). Its agents' calls pass the guard | — |
| Skill | no | — | Loads a skill from the checkout's `.claude/skills/` (T4) | — |
| ToolSearch | no | — | Searches the session's own deferred tool list | — |
| StructuredOutput, SubagentHandback, ReportFindings | no | — | Hand a result to the calling conversation in the same session | — |
| TaskCreate, TaskGet, TaskList, TaskUpdate, TaskStop, TaskOutput, TodoWrite | no | — | The session's own task list and background tasks | `P1N-todo` (`info`) |
| EnterPlanMode | no | — | Changes the session's mode | — |
| ReadNotifications | no | — | Reads the session's own queue (inbound) | — |
| AskUserQuestion, ExitPlanMode (passed to the user, `USER_TOOLS`) | no | — | Shown to the user in the session itself (section 9) | — |

**Residuals by channel** (the block: "or the record names it as a residual with its reason and the layer left for it"):
- SendUserFile's file content (above).
- Text a command builds at run time, in Bash (section 5). A Monitor command is not a residual here: W-C02-21 denies every Monitor call.
- Text that leaves from inside an interpreter or a script, from a file a command reads, or from a background job. This is the block's "Not covered" (c). The layer left is the scans after the fact: W-C02-12 point 9, W-C02-18 point 11, EV-C02-003 section 14's log check.

## 3. Form C0, one entry per case group

### T-W20-2 · Point 2: the stop, on the raw input, by channel and form

| Field | Content |
|---|---|
| **ID and claim** | T-W20-2 (`P2-*`, `P2N-*`). The guard denies any call on a channel table 2 marks outbound that carries a string of either format, in every form point 2 names. It reads the raw input before any masking, on `PreToolUse` and on `PermissionRequest`, before every allow. It allows the same calls without the format string, and the near-misses a careless rule would stop. |
| **Failure class rule** | A string of a DevOS token format leaves the session because the check does not see it where it is. The places: a channel left out; a field nested, listed or used as a key; text masked before the check (`REDACT`, `summary()`); a marker in another case; a cut or glued copy; a pushed commit rather than the call. Or the check stops what is no token at all. |
| **Examples** | 40 call shapes, each for both formats (80 cases, each on both events; 42 and 84 before section 11's revision withdrew the two Monitor shapes). (1) The original need (EV-C02-003 §1.6; P:734): a URL carrying the string (`P2-wf-path`, `P2-sh-curl-query-cut`, `P2-sh-wget-query`). (2) Another manifestation, masking (`token_format.md` §6): the header line (`P2-gh-header`, `P2-sh-curl-header`, `P2-sh-wget-header`), `token=` (`P2-wf-token-eq`), a REDACT sequence in the random part (`P2-wf-sk`, `P2-gh-title-ghp`, `P2-sh-curl-sk`). (3) Another, the channels: GitHub writes (`P2-gh-*`, a nested field `P2-gh-nested-cut`), GitHub reads (`P2-gr-*`), the push's added line, message, path and branch name (`P2-push-*`), the database connection (`P2-db-*`, a key `P2-db-key`), the session tools (`P2-st-*`), SendUserFile and PushNotification (`P2-uf-*`, `P2-pn-*`), and the shell: `curl` and `wget` in path, query and header option, `git` in a remote URL, `python3 -c` and `node -e` (`P2-sh-*`). (4) The forms across the channels: whole, cut to the finder's minimum (`-cut`), marker in upper case (`-upper`) and mixed case (`-mixed`), glued (`-glued`), and a `\u`-escaped input (`P2-wf-uescape`, R4). Each case's input is self-checked before the run: the planted call holds a finder match, its twin holds none, and in a masked form `redact()` of the call holds none (the case is what its label says). |
| **Negative control** (C0: the wrong is caught) | Every `P2-*` case: the planted call is denied by a denial that is not a guard error, not the wrapper's and not "could not check" (R2), and its twin is allowed (R1). |
| **Positive control** (C0: the right is allowed) | Each twin. The block's ✔ near-misses, `P2N-*`, each allowed on both events: each marker alone (`n-marker-wf`, `n-marker-gh`); each marker and one alphabet character fewer than the finder needs (`n-short-wf`, `n-short-sh`); a string of the random part's length and alphabet with no marker (`n-nomarker-sh`, `n-nomarker-gh`); key-like strings of other systems, of the Supabase publishable-key and GitHub-token shapes, made at run time (`n-other-pub`, `n-other-gh`); commands and writes that use or quote the shared file's patterns (`n-pattern-grep`, `n-pattern-gh`, and `n-scan-py`, EV-C02-003 §3.2's scan reading the shared file); a write that names the shared file's path (`n-shared-path`); ordinary research reads (`n-read-wf`, `-ws`, `-curl`, `-gh`); an ordinary push (`n-push`; plan C03's Tests, test 3); an ordinary query (`n-db`); N-221 step 5's call shape with no format string (`n-client-like`); an ordinary `send_later` (`n-send-later`). |
| **Break attempt** | Section 4: (a), (b), (c), (d), and the designer's (i) and (j). |
| **Stage and environment** | C02, change 1. Any checkout of `devos` at the head under test, with Python 3, git and a POSIX shell. No network, no credential, no token. The guard runs through `.claude/settings.json`'s two wrapper commands, as `tools/test_tool_allowlist.sh` runs it. |
| **Independence level** | Written by the test designer (a fresh-context subagent, not the producer). Run against `main` by the designer, as a self-check, and against the head by the fresh-context checker of point 13, who also builds the breaks. Shared with the producer: the acceptance block, the executor's five facts and the model lineage. Not shared: the change's code (it did not exist). |
| **Evidence layer** | Structural: the guard's decision on synthetic hook inputs. Not behavioural: that the platform runs the hook on every call is shown by point 9's live try and point 8's run. |
| **Evidence envelope** | Target commit: the head judged. Configuration: the blobs of `.claude/hooks/tool_allowlist.py`, `.claude/settings.json`, the two shared files and `tools/test_token_stop.py`. Criterion version: the `main` commit of the acceptance block. Input: this program at its blob (the case list). Observation: the run's raw output. Raw evidence ID: the executor's, in the record. |

### T-W20-2R · Point 2's residuals (recorded, never counted as stopped)

| Field | Content |
|---|---|
| **ID and claim** | T-W20-2R (`P2R-*`). For each form the finder patterns cannot see in the raw input, the record states the guard's observed result, labelled residual. |
| **Failure class rule** | A format string hidden by encoding, by splitting, or by building it at run time, which a lexical reading of the call cannot match (P:734 "data hidden by encoding is a residual"; `token_format.md` §8; working order section 10, "Not protected"). |
| **Examples** | Section 5's nine forms, each for both formats. |
| **Negative control** | Not applicable: the case is a record (`info`), never `ok`. Its expected result is stated (allowed), and its input self-check confirms that the finder patterns do not match the raw call, so that it really is a residual. |
| **Positive control** | `P2-*`: the same strings, unencoded, are denied. |
| **Break attempt** | None needed: a record cannot pass or fail. If the stop ever decodes one form, the `info` line shows "observed deny", and the record may then name that form as stopped, with that run as its evidence. |
| **Stage and environment** | As T-W20-2. |
| **Independence level** | As T-W20-2. |
| **Evidence layer** | Structural. It shows what the guard decides; it does not show that the encoded string would still be usable by its receiver. |
| **Evidence envelope** | As T-W20-2. |

### T-W20-3c1 · Point 3's cases that change 1 already denies

| Field | Content |
|---|---|
| **ID and claim** | T-W20-3c1 (`P3c1-*`). Under change 1, a claim-token-format string sent anywhere is denied: to the live host by `curl` or `wget`, to `devos-test`'s host, to another host, through a script at any path, or beside or piped from a client-like call. So is an environment-token-format string sent to the live host. |
| **Failure class rule** | The future client path's exception, or any rule, letting a format string out by a route that is not the client script's own call to the live host. |
| **Examples** | `p3-curl-live` (the string as an RPC parameter in a GET's query to the live host), `p3-wget-live` (in a header option), `p3-curl-test` (`devos-test`'s host), `p3-curl-other`, `p3-copy-path` (a client-like script at a scratch path), `p3-other-script`, `p3-env-live` (the environment format to the live host), `p3-beside` (`&&`), `p3-pipe` (a pipe). The hosts are the projects' public names (EV-C02-003 line 28; P:630). |
| **Negative control** | Each denied, with its twin allowed (R1), on both events. |
| **Positive control** | The twins. `P2N-n-client-like`: the client call's shape with no format string is allowed under change 1. |
| **Break attempt** | (a) turns them all `BAD`; (b) turns `p3-curl-live`, `-curl-test`, `-curl-other`, `-beside` (their `p_claim_token=` is masked by REDACT's last pattern) and `-env-live` `BAD`. With change 2, the same cases stay ✘ and become the bed of break (e) (section 7). |
| **Stage and environment** | As T-W20-2. |
| **Independence level** | As T-W20-2. |
| **Evidence layer** | Structural. |
| **Evidence envelope** | As T-W20-2. |

### T-W20-4 · Point 4: the formats from the shared files; missing, unreadable and partial input

| Field | Content |
|---|---|
| **ID and claim** | T-W20-4 (`P4-*`). The stop takes the finder patterns from the two shared files beside the hook at every call (fact 2). On any fault of those files, every call the stop reads is denied as "could not check" (R2), never allowed. With whole files, the controls are allowed, and a format string is denied as a match, not as "could not check". |
| **Failure class rule** | A check that cannot read its input and answers "nothing found" (plan Section 8 item 14). Or a check that keeps its own copy, which drifts from the source the rest of DevOS reads. |
| **Examples** | Fourteen fault states, each in its own scratch tree: a copy of the hook under test at `.claude/hooks/tool_allowlist.py` and copies of the two shared files, then one fault. `f-json-missing`, `f-json-dir` (unreadable: a directory at its path), `f-json-loop` (unreadable: a link to itself), `f-json-invalid` (cut in half), `f-json-partial` (`token_patterns` not an object), `f-env-missing`, `f-claim-missing`, `f-env-nocompile` (both files alike), `f-claim-nocompile` (the pattern file only), `f-disagree-md`, `f-disagree-json`, `f-md-missing`, `f-md-dir`, `f-md-partial` (cut before its section 3). Each is self-checked to be in its fault state. In each tree, three calls on both events: an ordinary WebFetch, an ordinary comment (neither holds a format string), and a `curl` holding one. The test runs as root here, so "unreadable" is made by the path's kind, not by permissions. |
| **Negative control** | Every `P4-f-*` call denied, its text holding "could not check". |
| **Positive control** | `P4-whole-P2N-*`: the controls allowed in a tree with whole files. `P4-whole-stop`: there a format string is denied as a match, without "could not check", and its twin allowed. `P4-follow-min` and `P4-follow-stop`: in a tree whose two files alike raise the finder's minimum by four, a string of the old minimum is allowed and one of the new minimum denied, so the stop reads the files beside it and keeps no copy. `P4-f-json-missing-read` records (`info`) what a Read, which table 2 marks not outbound, gets under a fault. |
| **Break attempt** | (g), and the designer's (k). |
| **Stage and environment** | As T-W20-2. Each tree is a `git init` repository without devos's history, so the leak check derives no service names there (working order section 10: "a complete repository without that revision (a test fixture) checks none"). |
| **Independence level** | As T-W20-2. |
| **Evidence layer** | Structural. |
| **Evidence envelope** | As T-W20-2. |

Where the markers may appear: `token_format.md` section 7 is unchanged by these tests. Case `P7-markers` checks it as it stands (both markers only in the two shared files).

### T-W20-5 · Point 5: nothing repeated

| Field | Content |
|---|---|
| **ID and claim** | T-W20-5 (`P5-*`). After each planted case, three outputs are searched with both finder patterns and hold no format string: the denial's text, the decision log's record of the call, and `tools/guard_report.py`'s output. The denial withholds the call's text, as L1's and L2's do. Its "What to do instead" says that a synthetic case is recorded as such and that any other match is reported to the executor as a finding, and names EV-C02-003 §2.2 and plan 6.3's revocation and renewal for the environment format. |
| **Failure class rule** | A guard output repeats the string it stopped: in the summary, the detail, the log or the report. |
| **Examples** | Eight planted calls, each in its own decision-log directory: WebFetch query (`P5-wf-query`, environment format on `PreToolUse`, claim format on `PermissionRequest`), `curl` path (`P5-curl-path`, both events), an issue's title (`P5-issue-title`), a database query (`P5-db-query`), a pushed branch name (`P5-push-branch`), a web search (`P5-websearch`). Each is a field `summary()` would show if not withheld. |
| **Negative control** | Each case answers `BAD` naming what failed: not denied by the stop; the denial, the log or the report holds a format string; no log record; the report did not run; or "What to do instead" lacks one of `synthetic`, `executor`, `finding`, `2.2`, `6.3`, `revo`, `renew`. |
| **Positive control** | `P5-ctl`: the search finds a planted synthetic string of each format in a scratch copy of a log line. Against a guard without the stop, the log records of `P5-wf-query`, `-curl-path`, `-issue-title`, `-db-query` and `-websearch` hold the string and are reported so; that shows the search sees it. `P5-push-branch`'s log at `c09797f` holds no string, because the guard withholds the summary of every L1 decision, allows included. |
| **Break attempt** | (h). |
| **Stage and environment** | As T-W20-2. |
| **Independence level** | As T-W20-2. |
| **Evidence layer** | Structural. |
| **Evidence envelope** | As T-W20-2. |

**Format gate.** The word check on "What to do instead" is a format gate. A meaningless sentence holding the seven words, for example "synthetic executor finding 2.2 6.3 revoke renew", passes it. The checker reads the actual sentence (sample review); this test does not judge its meaning.

### T-W20-6 · Point 6: the other checks' planted controls under the stop

| Field | Content |
|---|---|
| **ID and claim** | T-W20-6 (`P6-*`). Each other check's planted synthetic control can still be made under the stop: written literally into a channel the stop reads, it is denied; built at run time, it is allowed. |
| **Failure class rule** | A check's positive control silently stopped by the stop, so that the check later answers "none found" without having been shown to find anything (plan Section 8 item 14). |
| **Examples** | `log-literal` (the log check's part 2 control written literally in a failing read-only statement), `scan-literal` (a scan's control written by a shell command that holds it). Section 6 lists each control. |
| **Negative control** | `P6-log-literal`, `P6-scan-literal`: denied, twins allowed. |
| **Positive control** | `P6-log-built` (the control built inside the statement at run time: the call holds the environment marker followed by a quote, no format string), `P6-log-count` (the count-only search naming the marker), `P6-scan-generated` (a program that reads the shared file and writes the control into a scratch file), `P6-scan-7scan` (`T-W07-7SCAN`, which plants its own control at run time): each allowed. `P6-scan-write` records (`info`) the Write tool's case, which table 2 marks not outbound. |
| **Break attempt** | (a) turns the two ✘ cases `BAD`. (d) for the database connection turns `P6-log-literal` `BAD`. |
| **Stage and environment** | As T-W20-2. Nothing is executed: no statement reaches a database. |
| **Independence level** | As T-W20-2. |
| **Evidence layer** | Structural: what the guard decides. That Postgres logs the built string in its error is not shown (section 6). |
| **Evidence envelope** | As T-W20-2. |

### T-W20-7 · Point 7's scan: no format string in the change, no marker outside its two files

| Field | Content |
|---|---|
| **ID and claim** | T-W20-7 (`P7-*`). The scan finds a planted synthetic string of each format, and each marker, in a scratch copy. Then the files of the change hold no format string (`P7-change`). The working tree holds none (`P7-tree`). Each marker appears, in any case, only in `token_format.md` and `scan_patterns.json` (`P7-markers`). |
| **Failure class rule** | A token, or a copy of the format's marker, written into a file of the public repository. |
| **Examples** | `P7-ctl`: copies of this program with a planted string of the environment format, then of the claim format; a file with both markers alone. `P7-change`: the files that differ from `origin/main` (against the merge base, with uncommitted and untracked files): tests, guard, record, fixtures, whatever the head holds. `P7-tree`: every tracked and untracked file. |
| **Negative control** | `P7-change`, `P7-tree`, `P7-markers`: `BAD` naming the paths (never the text) when a string or a misplaced marker is found, or when a file cannot be read. |
| **Positive control** | `P7-ctl` finds each planted string and marker, and nothing in a clean file. |
| **Break attempt** | Plant a line holding a format string, made at run time, into a scratch copy of the head tree, and run the program there: `P7-change` and `P7-tree` turn `BAD`. A marker alone in another file turns `P7-markers` `BAD`. |
| **Stage and environment** | As T-W20-2. |
| **Independence level** | As T-W20-2. |
| **Evidence layer** | Structural: strings in files. Not history, not other branches (W-C02-12 point 9), not encoded copies. |
| **Evidence envelope** | As T-W20-2. |

## 4. The breaks of point 7, as specifications

**How each is built.** Copy the whole head tree into a scratch directory, so that the stop finds the shared files two directories above the hook. Edit only the guard there, then run `bash tools/test_tool_allowlist.sh` at that copy's root, each break on its own. Each must end `TOKEN_STOP_TEST FAIL` and `ALLOWLIST_TEST FAIL`, with the named cases `BAD`. For the breaks section 10 names, the reference stop also showed that no other case turns `BAD`. The unchanged head must pass again after.

| Break | The edit | Cases that turn `BAD` |
|---|---|---|
| (a) the stop removed | The stop's call removed | Every ✘ case: `P2-*`, `P3c1-*`, `P4-f-*`, `P4-whole-stop`, `P4-follow-stop`, `P5-*`, `P6-log-literal`, `P6-scan-literal`. This is the state at `c09797f` |
| (b) the stop applied to the redacted text | Each string the stop reads passed through `redact()` first | `P2-wf-token-eq`, `P2-wf-sk`, `P2-gh-header`, `P2-gh-title-ghp`, `P2-sh-curl-header`, `P2-sh-curl-sk`, `P2-sh-wget-header`, `P3c1-p3-curl-live`, `-curl-test`, `-curl-other`, `-beside`, `-env-live` |
| (c) the marker matched in one case only | The finder patterns compiled without their case-insensitive group (or the marker compared case-sensitively) | `P2-wf-query-upper`, `P2-gh-pr-upper`, `P2-gr-path-mixed`, `P2-push-path`, `P2-st-message-upper`, `P2-sh-wget-path-upper`, `P2-sh-git-remote-mixed` |
| (d) each outbound channel left out, one at a time | That channel's tools skipped by the stop | That channel's cases in table 2's last column. For example: PushNotification `P2-pn-*`. The database connection `P2-db-*`, `P5-db-query-claim`, `P6-log-literal`. The push's commits not read: `P2-push-line`, `-msg`, `-path` (`P2-push-branch` stays `ok`, since the branch name is also in the Bash command). Bash's command not read, the push's own reading kept: `P2-sh-*`, `P3c1-*`, every `P4-f-*-curl-string`, `P5-curl-path-*`, `P6-scan-literal` (the push cases stay `ok`) |
| (e) the exception widened | Change 2 | Section 7 |
| (f) the exception removed | Change 2 | Section 7 |
| (g) "could not check" taken as no match | A fault of the shared files answered as "no pattern, no match" | Every `P4-f-*` case |
| (h) the stop's denial not withheld | The stop's rule not withheld in `summary()` (not in `LEAK_WITHHELD`, or its equivalent) | Every `P5-*` case except `P5-ctl` |
| (i) designer's: nested fields not read | Only top-level string fields read | `P2-ws-glued`, `P2-gh-nested-cut`, `P2-db-nested-glued`, `P2-db-key`, `P2-uf-name-cut` |
| (j) designer's: the stdin bytes read | The finder applied to the hook's standard input, not to the decoded object | `P2-wf-uescape` |
| (k) designer's: a copy of the patterns | The patterns read from anywhere but the files two directories above the hook (a copy in the guard, or another tree's files) | `P4-follow-min` and every `P4-f-*` case |

A stop that crashes on a match (a guard error) also turns every `P2-*` ✘ case `BAD` (R2).

## 5. Point 2's residuals (`P2R-*`, each for both formats)

Expected result for every row: **allowed**, labelled residual, never counted as stopped. The finder patterns do not match the raw input; each case's input self-check confirms it before the run.

| Case | Form | Channel | Why the finder cannot see it | Layer left |
|---|---|---|---|---|
| `r-pct-underscore` | percent-encoded: `%5F` for the marker's `_` | WebFetch URL query | The marker needs `_` | Scans after the fact see only what is stored decoded |
| `r-pct-all` | every character percent-encoded | `curl` URL path | No marker in the text | as above |
| `r-base64` | base64 of the string | comment body | No marker in the text | W-C02-12 point 9's scan does not decode (`token_format.md` §8) |
| `r-split-fields` | marker and ten characters in an issue's title, the rest in its body | GitHub write | Neither field holds 16 characters after the marker | as above |
| `r-split-lines` | marker at a line's end, random part on the next line | pull request body | A newline follows the marker | as above |
| `r-continuation` | a backslash-newline inside a double-quoted URL, which bash joins before `curl` runs | Bash | The raw command holds a backslash after the marker | none in the session |
| `r-variable` | the marker in a shell variable, expanded into the URL | Bash | The marker is followed by `;`, and the expansion holds no marker | none in the session |
| `r-substitution` | `$(printf %s <marker> <random part>)` | Bash | A space follows the marker | none in the session |
| `r-file` | `$(cat <file>)` in the URL, the file holding the string | Bash | The call holds no part of it | none in the session |

The block's "Not covered" (c) names these as residuals under D-003 and D-008.

## 6. Point 6: the other checks' planted controls, the channel each crosses, and the open question

The stop is taken as fixed in section 1 (every format string in an outbound channel denied, the shell as a whole outbound). "Literal" means the control's string is written into the call. "Built" means a program or statement makes it at run time.

| Control (source) | Channel it crosses | Denied by the stop? | How it can be made under the stop | Open question for the producer (an exception, if any, is the producer's to design and the test designer's to test after) |
|---|---|---|---|---|
| The log check's part 2 positive control: a failing read-only statement whose error carries a synthetic string into `devos`'s Postgres logs (EV-C02-003 §14; N-221 steps 6 and 8) | The read-only database connection (`execute_sql` or the tool that runs the statement) | Literal: yes (`P6-log-literal`) | Built inside the statement: the call holds the environment marker followed by a quote, and the database concatenates a random part of the alphabet (`P6-log-built`, allowed). The count-only search names the marker alone (`P6-log-count`, allowed) | (1) Does Postgres's error for the built form carry the built string into the logs, as §14 infers for the literal form? `[Inf]`, unobserved. (2) Which tool and fields read the count. (3) This answers N-245 item (2)'s question ("how part 2's synthetic control relates to W-C02-11's format stop once it is live") only if the producer adopts the built form. Otherwise an exception as narrow as point 3's is needed, with its own ✘ cases |
| W-C02-12 point 9's positive control (the scan of the repository, branches, issue #6 and the records) | Bash, if a command holding the string writes it (`P6-scan-literal`, denied). GitHub write or push, if it were planted in issue #6 or a branch: denied, and it would publish a format string (`token_format.md` §7 forbids it) | Literal: yes | A program that reads the shared file and writes the control into a scratch copy of the fetched text (`P6-scan-generated`, allowed) | Whether W-C02-12's scan plants its control in a scratch copy of issue #6's fetched text and of each branch, rather than on GitHub |
| W-C02-07 point 7's control (`T-W07-7SCAN`) | Bash: the command runs the program, which plants at run time from `os.urandom` in a scratch directory | No (`P6-scan-7scan`, allowed) | As it is | None |
| W-C02-18 point 11's control (the scan of every C02 record, branch, test, fixture and log entry) | As W-C02-12 point 9's | Literal: yes | As W-C02-12 point 9's | As W-C02-12 point 9's |
| EV-C02-003 §3.2's scratch file ("a synthetic string of the token format, labelled synthetic and made by the session, into a scratch file") | Write tool: not outbound (table 2). Bash: outbound | With Write: no (`P6-scan-write`, `info`, observed allowed at `c09797f`). With a shell command holding it: yes (`P6-scan-literal`) | With Write, or by a program that makes it (`P6-scan-generated`) | If the stop also reads Write, step 1 needs the program form. With Write, the session types the string into its own transcript (the platform's reader, "Not covered" (c)); the program form avoids that. Which form N-221 step 5 uses is the executor's call |
| W-C02-20 point 9's own live try (a WebFetch and a `curl` to a `.invalid` host with a synthetic string in the query) | WebFetch, Bash | Yes, by design: that is its purpose | — | None. `P2-wf-query-upper` and `P2-sh-curl-query-cut` are its decision-level counterparts |

## 7. Change 2: the client path's exception (point 3), to be written once the script is on `main`

Not written now: the script, its path, the merge commit that adds it, and how it learns its host do not exist yet. When they do, the test designer writes these cases into the same program, in form C0, before change 2, from the block's point 3.
- **✔ Positive control.** The client script at its path in the live tree, run as N-221 step 5 runs it (`token_role_class()`, with no format string), and with a claim-token-format string as a call's parameter to the live host: allowed, and the decision log names the rule that allowed it.
- **✘ Each denied:**
  - an environment-token-format string in the client script's call;
  - a claim-token-format string sent to `devos-test`'s host or any other host, through the script with its host changed by an argument, a variable or a file the session controls;
  - with `curl` or `wget` to the live host (`P3c1-p3-curl-live`, `-wget-live` stay);
  - through a copy of the script at another path (`P3c1-p3-copy-path` stays), or a changed copy at the same relative path in another clone (a scratch clone whose script differs by one line);
  - beside the client call in the same command: a pipe, `;`, `&&`, a command substitution, or the script's output piped to a network command (`P3c1-p3-beside`, `-p3-pipe` stay, with the real script's path);
  - the named script missing or unreadable where the guard looks for it: the stop holds.
- **Breaks.** (e) the exception widened to any command that names the script, or to any host: every ✘ case of point 3. (f) the exception removed: the positive control.
- **Needed from the producer before writing:** the script's path; how the guard identifies the script's call (the exact command forms it accepts); and how the script learns its host.

## 8. Clause table

| The block's text | Cases |
|---|---|
| Point 1, every outbound channel listed, from the guard's code | Section 2 (a record, not a case); `P1N-*` (`info`) |
| 2: "applies both finder patterns to the raw tool input … before `redact()`, `summary()`" | `P2-wf-token-eq`, `-wf-sk`, `-gh-header`, `-gh-title-ghp`, `-sh-curl-header`, `-sh-curl-sk`, `-sh-wget-header`; `P2-wf-uescape` (R4) |
| 2: "runs before every rule that answers allow … the read-only connection's and the GitHub tools' allows included" | `P2-db-*`, `P2-gh-*`, `P2-gr-*`, `P2-st-*` |
| 2 ✘ forms: whole, cut, upper case, glued, URL path, URL query, header line and `token=`, REDACT sequence | the `P2-*` suffixes and ID names (T-W20-2, Examples) |
| 2 ✘: GitHub write body (comment, PR body, file content) and nested field | `P2-gh-comment`, `-gh-pr-upper`, `-gh-file-glued`, `-gh-nested-cut` |
| 2 ✘: pushed file's added line, commit message, pushed branch name | `P2-push-line`, `-push-msg`, `-push-branch` (and `-push-path`) |
| 2 ✘: a field of the read-only database connection | `P2-db-query`, `-db-nested-glued`, `-db-key` |
| 2 ✘: `curl` and `wget` in path, query, header option; `git` remote URL; interpreter one-liner | `P2-sh-*` |
| 2 ✘: "Each is denied on `PreToolUse` and on `PermissionRequest`" | every ✘ case runs on both events |
| 2 ✔ near-misses | `P2N-*` (T-W20-2, Positive control) |
| 2: encoded, split, built at run time | `P2R-*` (section 5) |
| 3 (change 1's part) | `P3c1-*`; the rest in section 7 |
| 4 ✘ and ✔ | `P4-*` |
| 4: "Where the markers may appear … stays as `token_format.md` section 7 states it" | `P7-markers` |
| 5 | `P5-*` |
| 6 | `P6-*`; section 6 |
| 7: written first, form C0, synthetic, run against `main` showing ✘ `BAD` | this file; `TOKEN_STOP_TEST` against `c09797f` |
| 7: the scan shown to catch a planted string, then no format string in the change and no marker outside its files | `P7-ctl`, `P7-change`, `P7-tree`, `P7-markers` |
| 7: breaks (a) to (h) | Section 4 |

## 9. What these tests do not cover, and why

- **Point 3's exception** (change 2): section 7.
- **Point 8's three properties, point 9's live try, and points 10 to 12's records:** the executor's record. These tests are one input to point 8's run.
- **The tools' real schemas.** The cases use field names the guard accepts; whether the platform's GitHub, session and database tools name their fields so is not read. The stop reads every string at any depth (fact 3), so a field's name does not matter to it.
- **AskUserQuestion and ExitPlanMode.** They pass to the user without a decision, and table 2 marks them not outbound. A format string typed there would reach the session's own transcript, which plan 6.3 also forbids ("not written into the chat"). That is not this item's channel.
- **Monitor's other gap.** At `c09797f` the guard allows Monitor by name with no shell rule (B1 to B11 do not read its `command`), although the platform runs that command like Bash's. That is outside this item; it is reported to the executor, not tested here. *(Revision, 2026-10-13: the executor confirmed it and carries it as W-C02-21, which denies Monitor by T1; its cases are `W21-*` in `tools/test_tool_allowlist.sh`. See section 11.)*
- **The REDACT sequence by chance** (7.5 in 100,000 tokens, `token_format.md` §6). The cases plant it on purpose; none relies on chance.
- **The meaning of the denial's guidance** (the format gate in T-W20-5).
- **A real token.** None is used; whether one ever reaches a channel is shown only by the scans after the fact (the block's "Not covered" (g)).

## 10. Self-check by the test designer (not a result)

- **Against the guard at `main` `c09797f`, 2026-10-13, in the designer's scratch clone.** `python3 tools/test_token_stop.py`: `TOKEN_STOP_TEST FAIL`. Every ✘ case of points 2, 3 (change 1), 4 and 5, and point 6's two, was `BAD`. Every ✔ control was `ok`, and so was point 7's scan; residuals and records were `info`. The output held no format string (searched with both finder patterns). The counts and final lines of the whole suite are in the executor's record.
- **That the cases can pass, and that the breaks bite.** Before any change existed, the designer wrote a throwaway minimal stop into a scratch copy of the tree, outside the repository. It is not handed over and was deleted after; it shares nothing with the producer's change. Against it every case was `ok` (`TOKEN_STOP_TEST PASS`). Each break in turn made `BAD` exactly the cases section 4 names, and no others: (b), (c), (d) for Monitor, for Bash's command, for the push's commits and for the database connection, (g), (h), (i), (j) and (k). Not run on the reference: (d) for the other channels, and (a), which is the state of the guard at `c09797f` (above).
- *(Annotation, 2026-10-13, section 11.)* The two bullets above are the first designer's record of a run before the revision, and they are kept as written. That run still held the two `P2-mon-*` shapes: they were among (c)'s and (i)'s cases, and "(d) for Monitor" is withdrawn with them. The revision was not run against a reference stop. Section 11 gives its run against `main`.

## 11. Revision for W-C02-21 (2026-10-13)

Made by W-C02-21's test designer (a fresh-context `test-designer` subagent, neither this item's producer nor its first test designer), before any run of these tests against a stop.

**What changed.**
1. `tools/test_token_stop.py`: the two point-2 shapes `mon-cmd-mixed` and `mon-ws` are withdrawn. That is four cases, eight lines; a comment marks the place.
2. Section 2's table: `Monitor`'s row reads "denied by T1 under W-C02-21", a tool that is not a channel the stop reads. The residuals line names `Bash` only.
3. T-W20-2's count is now 40 shapes and 80 cases. Section 4's breaks (c), (d) and (i) no longer list the `Monitor` cases.
4. Section 9's "Monitor's other gap" names W-C02-21.
5. R3 records the executor's reading of point 7's "never written to a file".
6. Section 10 is annotated, not rewritten.

**Why.** W-C02-21 (`plan/work/W-C02-21.md`) takes `Monitor` off `ALLOWED_NON_MCP`, so rule T1 denies every `Monitor` call whatever its input. Under that change the two cases could not pass. R1 needs each case's twin to be allowed, and the twin, being a `Monitor` call too, is denied. If they were kept, they would turn `BAD` at every head after W-C02-21 for a reason outside this item.

**Why this does not loosen anything** (ledger rule 3; Appendix G G8 item 3).
- The acceptance block of `plan/work/W-C02-20.md` is unchanged. Its point 1 lists the tools the guard allows at the head and asks that each outbound one be read by the stop or named as a residual. `Monitor` will not be one of them.
- No result of these tests against any stop has been seen. Their only runs are against `main`: `c09797f` by the first designer, and `3262699` for this revision. The guard's blob, `956f1b3`, is the same at both. Against `main`, every ✘ case is `BAD` by design.
- The claim the two cases carried was that a format string does not leave through `Monitor`'s command or its WebSocket. A stronger rule now carries it: W-C02-21's cases (`W21-*` in `tools/test_tool_allowlist.sh`) require every `Monitor` call to be denied, whatever it carries, and they run in the same suite.

**What follows.**
- (a) This item's point 8 asks for a run of `tools/test_tool_allowlist.sh` with no `BAD` line, and that suite holds `W21-*`. So point 8 cannot pass before W-C02-21's change is merged. W-C02-21's point 7 (a) records that order and the time it adds.
- (b) If W-C02-21 is cancelled, or `Monitor` returns to the list, the two shapes come back as they were at `a2e5a53` (`git show a2e5a53:tools/test_token_stop.py`), and `Monitor`'s row goes back to "yes", read by the stop.

**Run against the guard at `main` `3262699`** (2026-10-13, in the executor's scratch clone `cw90`, branch `claude/c02-w20-stop` at `a2e5a53` plus this revision, uncommitted; the guard's and settings' blobs equal `main`'s).
- `TOKEN_STOP_TEST FAIL (ok 109, BAD 278, info 25)`. Before the revision, at `a2e5a53`, the same run gave `ok 109, BAD 286, info 25`.
- The 8 lines withdrawn were all `BAD`. Every other `W20-*` line has the same status and label as before. The only differences are the file counts that `P7-change` and `P7-tree` print, which now include the revision's files. Both stay `ok`.
- No output line holds a format string. Labels print no inputs, and `P7-change` and `P7-tree` stayed `ok` over the revision's files.
