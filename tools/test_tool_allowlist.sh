#!/usr/bin/env bash
# Unit test for .claude/hooks/tool_allowlist.py, run through the same wrapper
# command as .claude/settings.json (negative and positive controls; plan Section 8).
# Usage: tools/test_tool_allowlist.sh [hook-path]
hook="${1:-.claude/hooks/tool_allowlist.py}"
fail=0
run() { printf '%s' "$1" | bash -c "python3 \"$hook\"; rc=\$?; [ \$rc -eq 0 ] || exit 2" 2>/dev/null; echo $?; }
t() { r=$(run "$2"); if [ "$r" = "$1" ]; then echo "ok   exp=$1 $2"; else echo "BAD  exp=$1 got=$r $2"; fail=1; fi; }
D='"owner":"batuhanozgun","repo":"devos"'
# --- negative controls: must block (2)
t 2 '{"tool_name":"mcp__9c01eb9f-d108-4a67-8a1c-59fbea9a1f7c__send_message"}'
t 2 '{"tool_name":"mcp__1a59c906-04da-521d-bda7-7f71b9f9e01c__update"}'
t 2 '{"tool_name":"mcp__Gmail__send_message"}'
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
t 2 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative","connectors":["Gmail"]}}'
t 2 '{"tool_name":"mcp__claude-code-remote__set_session_tags","tool_input":{"session_ids":["session_SOMEONE_ELSE"]}}'
t 2 '{"tool_name":"Artifact","tool_input":{"action":"publish"}}'
t 2 '{"tool_name":"DesignSync"}'
t 2 '[]'
t 2 '"x"'
t 2 '{}'
t 2 '{"tool_name":null}'
t 2 'garbage'
# --- positive controls: must allow (0)
t 0 '{"tool_name":"mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__execute_sql"}'
t 0 '{"tool_name":"mcp__claude-code-remote__get_session"}'
t 0 '{"tool_name":"mcp__claude-code-remote__send_later","tool_input":{"delay_minutes":5,"message":"x"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","prompt":"x"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__create_session","tool_input":{"source_url":"https://github.com/batuhanozgun/devos","environment_id":"env_01AMBDuHjjTsXMeXFyYgk1zR"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__add_repo","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search","access":"read"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__send_message","tool_input":{"session_id":"session_016Hi3ZYgAf2amYNGc43a3tr","message":"x"}}'
t 0 '{"tool_name":"mcp__claude-code-remote__create_trigger","tool_input":{"name":"x","prompt":"x","initiation":"own_initiative"}}'
t 0 '{"tool_name":"mcp__github__get_me"}'
t 0 '{"tool_name":"mcp__github__actions_list","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 0 '{"tool_name":"mcp__github__get_file_contents","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 0 "{\"tool_name\":\"mcp__github__create_pull_request\",\"tool_input\":{$D}}"
t 0 '{"tool_name":"mcp__github__merge_pull_request","tool_input":{"owner":"BatuhanOzgun","repo":"DevOS","pullNumber":4}}'
t 0 '{"tool_name":"mcp__github__resolve_review_thread","tool_input":{"threadId":"x"}}'
t 0 '{"tool_name":"Bash"}'
# --- wrapper: a hook that cannot run must still block
tmp=$(mktemp -d); printf 'def broken(:\n' > "$tmp/syntax.py"; printf 'import does_not_exist_xyz\n' > "$tmp/imp.py"
for h in "$tmp/syntax.py" "$tmp/imp.py" "$tmp/missing.py"; do
  r=$(printf '{"tool_name":"mcp__Gmail__x"}' | bash -c "python3 \"$h\"; rc=\$?; [ \$rc -eq 0 ] || exit 2" 2>/dev/null; echo $?)
  [ "$r" = "2" ] && echo "ok   wrapper blocks broken hook $(basename "$h")" || { echo "BAD  wrapper did not block $(basename "$h") ($r)"; fail=1; }
done
r=$(printf '{}' | env PATH=/nonexistent /bin/bash -c "python3 x; rc=\$?; [ \$rc -eq 0 ] || exit 2" 2>/dev/null; echo $?)
[ "$r" = "2" ] && echo "ok   wrapper blocks when python3 is missing" || { echo "BAD  python3 missing not blocked ($r)"; fail=1; }
rm -rf "$tmp"
[ $fail -eq 0 ] && echo "ALLOWLIST_TEST PASS" || echo "ALLOWLIST_TEST FAIL"
exit $fail
