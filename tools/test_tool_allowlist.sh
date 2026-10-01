#!/usr/bin/env bash
# Unit test for .claude/hooks/tool_allowlist.py, run through the same wrapper
# command as .claude/settings.json (negative and positive controls; plan Section 8).
# Usage: tools/test_tool_allowlist.sh [hook-path]
hook="${1:-.claude/hooks/tool_allowlist.py}"
fail=0
# The command and matcher are read from .claude/settings.json, so a changed wrapper or matcher is tested too.
cmd=$(python3 -c 'import json;print(json.load(open(".claude/settings.json"))["hooks"]["PreToolUse"][0]["hooks"][0]["command"])')
matcher=$(python3 -c 'import json;print(json.load(open(".claude/settings.json"))["hooks"]["PreToolUse"][0]["matcher"])')
cmd="${cmd//\$CLAUDE_PROJECT_DIR\/.claude\/hooks\/tool_allowlist.py/$hook}"
run() { printf '%s' "$1" | CLAUDE_PROJECT_DIR="$PWD" sh -c "$cmd" 2>/dev/null; echo $?; }
for n in mcp__x__y Artifact SendMessage ListAgents EnterWorktree ReadMcpResourceTool Bash SomeFutureTool; do
  python3 -c "import re,sys; sys.exit(0 if re.fullmatch(sys.argv[1], sys.argv[2]) else 1)" "$matcher" "$n" && echo "ok   matcher covers $n" || { echo "BAD  matcher misses $n"; fail=1; }
done
t() { r=$(run "$2"); if [ "$r" = "$1" ]; then echo "ok   exp=$1 $2"; else echo "BAD  exp=$1 got=$r $2"; fail=1; fi; }
D='"owner":"batuhanozgun","repo":"devos"'
# --- negative controls: must block (2)
t 2 '{"tool_name":"mcp__9c01eb9f-d108-4a67-8a1c-59fbea9a1f7c__send_message"}'
t 2 '{"tool_name":"mcp__1a59c906-04da-521d-bda7-7f71b9f9e01c__update"}'
t 2 '{"tool_name":"mcp__SomeConnector__send_message"}'
t 2 '{"tool_name":"mcp__github_evil__x"}'
t 2 '{"tool_name":"mcp__github__create_or_update_file","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 2 '{"tool_name":"mcp__github__create_pull_request","tool_input":{"owner":"batuhanozgun","repo":"soul"}}'
t 2 '{"tool_name":"mcp__github__create_repository","tool_input":{"name":"x"}}'
t 2 '{"tool_name":"mcp__github__push_files"}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"prompt":"x"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/agentic-os-search","prompt":"x"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","sparse_checkout_paths":["briefs"]}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","environment_id":"env_011CUMdS4hfVHjgVkjUZ5fEY"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","access":"push"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"soul"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__send_message","tool_input":{"session_id":"session_SOMEONE_ELSE","message":"x"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__fire_trigger","tool_input":{"trigger_id":"trig_SOMEONE_ELSE"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__update_trigger","tool_input":{"trigger_id":"trig_SOMEONE_ELSE","prompt":"x"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","connectors":["SomeConnector"]}}'
t 2 '{"tool_name":"mcp__claude-code-remote__set_session_tags","tool_input":{"session_ids":["session_SOMEONE_ELSE"]}}'
t 2 '{"tool_name":"Artifact","tool_input":{"action":"publish"}}'
t 2 '{"tool_name":"DesignSync"}'
t 2 '{"tool_name":"mcp__github__fork_repository","tool_input":{"owner":"batuhanozgun","repo":"devos"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"9ae67ef"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"claude/some-other-branch"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","persistent_session_id":"session_SOMEONE_ELSE"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","create_new_session_on_fire":true,"environment_id":"env_OTHER"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","connectors":""}}'
t 2 '{"tool_name":"mcp__claude-code-remote__list_events","tool_input":{"session_id":"session_SOMEONE_ELSE"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__get_event","tool_input":{"session_id":"session_SOMEONE_ELSE","event_uuid":"x"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__get_trigger","tool_input":{"trigger_id":"trig_SOMEONE_ELSE"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__list_sessions"}'
t 2 '{"tool_name":"mcp__claude-code-remote__list_triggers"}'
t 2 '{"tool_name":"mcp__claude-code-remote__some_future_write_tool","tool_input":{"session_id":"session_SOMEONE_ELSE"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__get_session","tool_input":{"session_id":"session_SOMEONE_ELSE"}}'
t 2 '{"tool_name":"ReadMcpResourceTool","tool_input":{"server":"9c01eb9f","uri":"x"}}'
t 2 '{"tool_name":"ListMcpResourcesTool"}'
t 2 '{"tool_name":"SendMessage","tool_input":{"to":"someone","message":"x"}}'
t 2 '{"tool_name":"ListAgents"}'
t 2 '{"tool_name":"EnterWorktree"}'
t 2 '{"tool_name":"SuggestPluginInstall"}'
t 2 '{"tool_name":"SomeFutureTool"}'
t 2 '{"tool_name":"mcp__claude-code-remote__subscribe_pr_activity","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","pullNumber":1}}'
t 2 '{"tool_name":"mcp__github__resolve_review_thread","tool_input":{"owner":"batuhanozgun","repo":"soul","threadId":"x"}}'
t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos\n"}}'
t 2 "{\"tool_name\":\"mcp__claude-code-remote__create_session\",\"tool_input\":{\"source_url\":\"https://github.com/batuhanozgun/devos\",\"source_revision\":\"$(git rev-parse --abbrev-ref HEAD)\",\"permission_mode\":\"bypassPermissions\"}}"
t 2 '[]'
t 2 '"x"'
t 2 '{}'
t 2 '{"tool_name":null}'
t 2 'garbage'
# --- positive controls: must allow (0)
t 0 '{"tool_name":"mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__execute_sql"}'
t 0 '{"tool_name":"mcp__claude-code-remote__get_session"}'
t 0 '{"tool_name":"mcp__claude-code-remote__send_later","tool_input":{"delay_minutes":5,"message":"x"}}'
br=$(git rev-parse --abbrev-ref HEAD)
t 0 "{\"tool_name\":\"mcp__claude-code-remote__create_session\",\"tool_input\":{\"source_url\":\"https://github.com/batuhanozgun/devos\",\"source_revision\":\"$br\"}}"
if git cat-file -e origin/main:.claude/settings.json 2>/dev/null; then
  t 0 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","prompt":"x"}}'
else
  t 2 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","prompt":"x"}}'
  echo "info main has no .claude/settings.json yet: a session on main is correctly blocked"
fi
t 0 "{\"tool_name\":\"mcp__claude-code-remote__create_session\",\"tool_input\":{\"source_url\":\"https://github.com/batuhanozgun/devos\",\"source_revision\":\"$br\",\"environment_id\":\"env_01AMBDuHjjTsXMeXFyYgk1zR\"}}"
t 0 '{"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","access":"read"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__send_message","tool_input":{"session_id":"session_016Hi3ZYgAf2amYNGc43a3tr","message":"x"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__get_session"}'
t 0 '{"tool_name":"mcp__claude-code-remote__list_events","tool_input":{"session_id":"cse_016Hi3ZYgAf2amYNGc43a3tr"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","persistent_session_id":"session_016Hi3ZYgAf2amYNGc43a3tr"}}'
t 0 '{"tool_name":"mcp__github__get_me"}'
t 0 '{"tool_name":"mcp__github__actions_list","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 0 '{"tool_name":"mcp__github__get_file_contents","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 0 "{\"tool_name\":\"mcp__github__create_pull_request\",\"tool_input\":{$D}}"
t 0 '{"tool_name":"mcp__github__merge_pull_request","tool_input":{"owner":"BatuhanOzgun","repo":"DevOS","pullNumber":4}}'
t 0 '{"tool_name":"mcp__github__resolve_review_thread","tool_input":{"threadId":"x"}}'
t 0 '{"tool_name":"Bash"}'
t 0 '{"tool_name":"PushNotification","tool_input":{"message":"x"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__subscribe_pr_activity","tool_input":{"owner":"batuhanozgun","repo":"devos","pullNumber":4}}'
# --- wrapper: a hook that cannot run must still block (the settings command, run under sh)
tmp=$(mktemp -d); printf 'def broken(:\n' > "$tmp/syntax.py"; printf 'import does_not_exist_xyz\n' > "$tmp/imp.py"
for h in "$tmp/syntax.py" "$tmp/imp.py" "$tmp/missing.py"; do
  c="${cmd//$hook/$h}"
  r=$(printf '{"tool_name":"mcp__SomeConnector__x"}' | CLAUDE_PROJECT_DIR="$PWD" sh -c "$c" 2>/dev/null; echo $?)
  [ "$r" = "2" ] && echo "ok   wrapper blocks broken hook $(basename "$h")" || { echo "BAD  wrapper did not block $(basename "$h") ($r)"; fail=1; }
done
r=$(printf '{}' | CLAUDE_PROJECT_DIR="$PWD" env PATH=/nonexistent /bin/sh -c "$cmd" 2>/dev/null; echo $?)
[ "$r" = "2" ] && echo "ok   wrapper blocks when python3 is missing" || { echo "BAD  python3 missing not blocked ($r)"; fail=1; }
rm -rf "$tmp"
# --- PostToolUse recorder: appends own IDs, never blocks
cp .claude/hooks/owned_ids.txt "$tmp.owned" 2>/dev/null
rd=$(mktemp -d); cp .claude/hooks/record_owned_id.py "$rd/"; printf 'x\n' > "$rd/owned_ids.txt"
printf '{"tool_name":"mcp__claude-code-remote__create_session","tool_response":{"ccr":{"id":"session_TESTREC123","parent_session_id":"session_PARENT"}}}' | python3 "$rd/record_owned_id.py"; r1=$?
printf '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_response":"{\\"trigger\\":{\\"id\\":\\"trig_TESTREC456\\"}}"}' | python3 "$rd/record_owned_id.py"
printf '{"tool_name":"mcp__claude-code-remote__send_message","tool_response":{"id":"session_SHOULDNOT"}}' | python3 "$rd/record_owned_id.py"
if [ "$r1" = "0" ] && grep -qx session_TESTREC123 "$rd/owned_ids.txt" && grep -qx trig_TESTREC456 "$rd/owned_ids.txt" && ! grep -q SHOULDNOT "$rd/owned_ids.txt" && ! grep -q session_PARENT "$rd/owned_ids.txt"; then echo "ok   recorder appends created IDs only"; else echo "BAD  recorder"; fail=1; fi
rm -rf "$rd"
[ $fail -eq 0 ] && echo "ALLOWLIST_TEST PASS" || echo "ALLOWLIST_TEST FAIL"
exit $fail
