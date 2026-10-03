# Gate 1c, deterministic part, and the 1b-ii gate re-run (W-C00-12 tranche 1c)

**Written:** 2026-10-03T22:59Z by run `session_011NtZnNGjojkTcmuzMRLtvL`. **What it is:** the unedited outputs of `python3 tools/test_1c.py` (T-M8, T-R12 (b), T-M17 (b) and its script part of (a), T-R22), `bash tools/test_tool_allowlist.sh` (T-H4 with the T-W6 unit part and N-053 (b)) and `python3 tools/test_check_records.py` (the 1b-ii gate with N-053's planted cases), each run on the clean, pushed head named in its first line. The live tests of gate 1c (intent 16 §3) are not here; this file does not claim them. Preconditions of the 1b-ii gate: full history and every `claude/review-*` ref fetched after the reviewers' last pushes.

## Outputs

### Gate 1c, deterministic part

`python3 tools/test_1c.py`, unedited output:

```text
HEAD 5a28bdb6882899dca0b1a650864e6dd947ba1e6d (clean)
PASS  T-M8 two appended recorder lines merge without conflict and both are present
PASS  T-R12 (b) control: the file as committed passes chain
PASS  T-R12 (b) FP-01 qualified by its own producer fails chain
PASS  T-R12 (b) FP-01 qualified without a qualifier fails chain
PASS  T-R12 (b) control: FP-01 qualified by another reviewer passes chain
PASS  T-M17 (b) the script made to raise prints an error line and the hook exits 0
PASS  T-M17 (a, script part) clocks, main SHA, chain result and every pattern with its label; no work state
PASS  T-R22 (a) without target_sha refuses with an error
PASS  T-R22 (a2) with a blank target_sha refuses with an error
PASS  T-R22 (a2) with a target_sha that resolves to no commit refuses with an error
PASS  T-R22 (b) with an empty failure_classes refuses with an error
PASS  T-R22 (c) with both, the header names the claims, the failure classes and the SHA
--- per test
T-M8 PASS (1/1 outcomes)
T-R12 PASS (4/4 outcomes)
T-M17 PASS (2/2 outcomes)
T-R22 PASS (5/5 outcomes)
GATE 1c (deterministic part) PASS
```

### T-H4: hook unit tests with the brief gate and the recorder

`bash tools/test_tool_allowlist.sh`, unedited output:

```text
ok   matcher covers mcp__x__y
ok   matcher covers Artifact
ok   matcher covers SendMessage
ok   matcher covers ListAgents
ok   matcher covers EnterWorktree
ok   matcher covers ReadMcpResourceTool
ok   matcher covers Bash
ok   matcher covers SomeFutureTool
ok   recorder matcher covers mcp__claude-code-remote__create_session
ok   recorder matcher covers mcp__claude-code-remote__create_trigger
ok   recorder matcher covers mcp__claude-code-remote__send_later
ok   exp=2 {"tool_name":"mcp__9c01eb9f-d108-4a67-8a1c-59fbea9a1f7c__send_message"}
ok   exp=2 {"tool_name":"mcp__1a59c906-04da-521d-bda7-7f71b9f9e01c__update"}
ok   exp=2 {"tool_name":"mcp__SomeConnector__send_message"}
ok   exp=2 {"tool_name":"mcp__github_evil__x"}
ok   exp=2 {"tool_name":"mcp__github__create_or_update_file","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}
ok   exp=2 {"tool_name":"mcp__github__create_pull_request","tool_input":{"owner":"batuhanozgun","repo":"soul"}}
ok   exp=2 {"tool_name":"mcp__github__create_repository","tool_input":{"name":"x"}}
ok   exp=2 {"tool_name":"mcp__github__push_files"}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"prompt":"x"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/agentic-os-search","prompt":"x"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","sparse_checkout_paths":["briefs"]}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","environment_id":"env_011CUMdS4hfVHjgVkjUZ5fEY"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","access":"push"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"soul"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__send_message","tool_input":{"session_id":"session_SOMEONE_ELSE","message":"x"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__fire_trigger","tool_input":{"trigger_id":"trig_SOMEONE_ELSE"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__update_trigger","tool_input":{"trigger_id":"trig_SOMEONE_ELSE","prompt":"x"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","connectors":["SomeConnector"]}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__set_session_tags","tool_input":{"session_ids":["session_SOMEONE_ELSE"]}}
ok   exp=2 {"tool_name":"Artifact","tool_input":{"action":"publish"}}
ok   exp=2 {"tool_name":"DesignSync"}
ok   exp=2 {"tool_name":"mcp__github__fork_repository","tool_input":{"owner":"batuhanozgun","repo":"devos"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"9ae67ef"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"claude/some-other-branch"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","persistent_session_id":"session_SOMEONE_ELSE"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","create_new_session_on_fire":true,"environment_id":"env_OTHER"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","connectors":""}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__list_events","tool_input":{"session_id":"session_SOMEONE_ELSE"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__get_event","tool_input":{"session_id":"session_SOMEONE_ELSE","event_uuid":"x"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__get_trigger","tool_input":{"trigger_id":"trig_SOMEONE_ELSE"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__list_sessions"}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__list_triggers"}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__some_future_write_tool","tool_input":{"session_id":"session_SOMEONE_ELSE"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__get_session","tool_input":{"session_id":"session_SOMEONE_ELSE"}}
ok   exp=2 {"tool_name":"ReadMcpResourceTool","tool_input":{"server":"9c01eb9f","uri":"x"}}
ok   exp=2 {"tool_name":"ListMcpResourcesTool"}
ok   exp=2 {"tool_name":"SendMessage","tool_input":{"to":"someone","message":"x"}}
ok   exp=2 {"tool_name":"ListAgents"}
ok   exp=2 {"tool_name":"EnterWorktree"}
ok   exp=2 {"tool_name":"SuggestPluginInstall"}
ok   exp=2 {"tool_name":"SomeFutureTool"}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__subscribe_pr_activity","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","pullNumber":1}}
ok   exp=2 {"tool_name":"mcp__github__resolve_review_thread","tool_input":{"owner":"batuhanozgun","repo":"soul","threadId":"x"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos\n"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"claude/run-w12-1c","permission_mode":"bypassPermissions"}}
ok   exp=2 {"tool_name":"Agent","tool_input":{"description":"x","prompt":"x","isolation":"remote"}}
ok   exp=2 {"tool_name":"Task","tool_input":{"description":"x","prompt":"x","isolation":"remote"}}
ok   exp=2 {"tool_name":"Agent","tool_input":{"description":"x","prompt":"x","isolation":"worktree"}}
ok   exp=2 {"tool_name":"Agent","tool_input":{"description":"x","prompt":"x","isolation":"some_future_value"}}
ok   exp=2 {"tool_name":"Workflow","tool_input":{"script":"export const meta = {name:\"x\",description:\"x\"}"}}
ok   exp=2 {"tool_name":"mcp__github__resolve_review_thread","tool_input":{"owner":"batuhanozgun","threadId":"x"}}
ok   exp=2 []
ok   exp=2 "x"
ok   exp=2 {}
ok   exp=2 {"tool_name":null}
ok   exp=2 garbage
ok   exp=0 {"tool_name":"mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__execute_sql"}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__get_session"}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__send_later","tool_input":{"delay_minutes":5,"message":"x"}}
ok   exp=0 {"tool_name":"Agent","tool_input":{"description":"x","prompt":"x","subagent_type":"general-purpose"}}
ok   exp=0 branch control with a generated brief
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos-x","source_revision":"claude/run-w12-1c"}}
ok   exp=2 {"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"claude/run-w12-1c","outcome_branch":"main"}}
ok   exp=0 (T-W6 c) a correct item brief on main
ok   exp=2 (T-W6 a) no Task-Brief line
ok   exp=2 (T-W6 b) a wrong hash
ok   exp=2 (N-053 b) a brief whose text differs from its hash (hand-pasted, valid-looking hash)
ok   exp=2 (T-W6 e) an invented item ID
ok   exp=0 (T-W6 d) a correct run brief from the lease holder session_011NtZnNGjojkTcmuzMRLtvL
ok   exp=2 (T-W6 f) a correct run brief from a session the Run lock row does not name
ok   exp=0 (T-W6 c2) a correct verifier brief
ok   exp=2 (T-W6 c3) a verifier brief with a failure class edited in the message
ok   exp=0 branch control in the builder environment with a generated brief
ok   exp=0 {"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","access":"read"}}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__send_message","tool_input":{"session_id":"session_016Hi3ZYgAf2amYNGc43a3tr","message":"x"}}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative"}}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__get_session"}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__list_events","tool_input":{"session_id":"cse_016Hi3ZYgAf2amYNGc43a3tr"}}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","persistent_session_id":"session_016Hi3ZYgAf2amYNGc43a3tr"}}
ok   exp=0 {"tool_name":"mcp__github__get_me"}
ok   exp=0 {"tool_name":"mcp__github__actions_list","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}
ok   exp=0 {"tool_name":"mcp__github__get_file_contents","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}
ok   exp=0 {"tool_name":"mcp__github__create_pull_request","tool_input":{"owner":"batuhanozgun","repo":"devos"}}
ok   exp=0 {"tool_name":"mcp__github__merge_pull_request","tool_input":{"owner":"BatuhanOzgun","repo":"DevOS","pullNumber":4}}
ok   exp=0 {"tool_name":"mcp__github__resolve_review_thread","tool_input":{"threadId":"x"}}
ok   exp=0 {"tool_name":"Bash"}
ok   exp=0 {"tool_name":"ReadNotifications"}
ok   exp=0 {"tool_name":"PushNotification","tool_input":{"message":"x"}}
ok   exp=0 {"tool_name":"mcp__claude-code-remote__subscribe_pr_activity","tool_input":{"owner":"batuhanozgun","repo":"devos","pullNumber":4}}
ok   wrapper blocks broken hook syntax.py
ok   wrapper blocks broken hook imp.py
ok   wrapper blocks broken hook missing.py
ok   wrapper blocks when python3 is missing
ok   recorder reads the observed list-of-text format
ok   recorder records session_PRETTY1
ok   recorder records session_CSEFORM2
ok   recorder records session_NEWAFTER3
ok   recorder records session_NEW4
ok   recorder records session_WITHPROSE7
ok   recorder records trig_LIST8
ok   recorder records session_WRAPPED11
ok   recorder records session_ENCLIST12
ok   recorder records trig_SENDLATER13
ok   recorder ignores session_FOREIGN
ok   recorder ignores session_PARENTX
ok   recorder ignores session_AMBIG5
ok   recorder ignores session_AMBIG6
ok   recorder ignores session_OTHER
ok   recorder ignores cse_CSEFORM2
ok   recorder ignores session_WRONGPREFIX9
ok   recorder ignores env_WRONGPREFIX10
ok   recorder ignores trig_NOTTHEFIELD14
ok   recorder ignores trig_TWO15
ok   recorder ignores trig_TWO16
ok   recorder appends created IDs only
ALLOWLIST_TEST PASS
```

### Gate 1b-ii re-run with N-053's planted cases

`python3 tools/test_check_records.py`, unedited output:

```text
HEAD 5a28bdb6882899dca0b1a650864e6dd947ba1e6d (clean)
run at 2026-10-03T22:59:25Z
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
PASS  T-M15 (f1) a Written: stamp 10 minutes after its review-branch commit fails stamps
PASS  T-M15 (f2) a Written: stamp 5 minutes before its review-branch commit passes
PASS  T-M15 (e1, e2) a copy stays bound after a later push to its review branch, with the owned list read on the checked tree
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
PASS  T-W4 a verdict with the word 'composition' but no '**Composition of:**' line fails (N-053 g)
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
PASS  T-W9 (z) R-W12-6 B-1: the self-accepted last child and its verdict copied into W-C00-12: class high
PASS  T-W9 (z) the reason names the work check of child W-C00-12.5 at the PR head
PASS  T-W9 (z2) R-W12-6 B-1 with the composition marker: the self-accepted last child and its verdict copied into W-C00-12: class high
PASS  T-W9 (z2) the reason names the work check of child W-C00-12.5 at the PR head
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
T-M15 PASS (10/10 outcomes)
T-W1 PASS (9/9 outcomes)
T-W3r PASS (5/5 outcomes)
T-W4 PASS (4/4 outcomes)
T-W9 PASS (43/43 outcomes)
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

### Mutation checks run by hand (not part of the scripts above)

- **N-053 (g), (e), (f) and R-R7, before their fixes.** The scratch fixtures clone the committed `HEAD`, so each new planted case was first run with the checker committed before its fix: T-W9 (z) and (z2) reported class normal (FAIL) with `HEAD` at `644fb20`, whose checker is `main`'s and `9d0fb72`'s (`git diff --stat 9d0fb72 origin/main -- tools/` is empty); the fix is `dd49171`. T-M15 (e1, e2) reported `UNBOUND` and (f1) no stamp failure with `HEAD` at `dd49171`; the fix is `df39b33`. T-M8 conflicted with `HEAD` at `df39b33`, before `.gitattributes` (`98b2090`). Commit order on the branch shows each fix after its case was written; the pre-fix runs themselves are recorded only in this run's transcript and in L-058, not as files.
- **Brief gate disabled** (`brief_gate` returning at once), in a scratch clone: T-H4 printed `BAD` for T-W6 (a), (b), (e), (f), (c3) and N-053 (b), and `ALLOWLIST_TEST FAIL`.
- **Recorder field rule disabled** (`send_later` parsed like `create_trigger`): T-H4 printed `BAD  recorder missed trig_SENDLATER13` and `BAD  recorder recorded trig_NOTTHEFIELD14`, and `ALLOWLIST_TEST FAIL`.
