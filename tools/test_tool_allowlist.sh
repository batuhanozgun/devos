#!/usr/bin/env bash
# Unit test for .claude/hooks/tool_allowlist.py (negative and positive controls; plan Section 8).
# Usage: tools/test_tool_allowlist.sh [hook-path]
hook="${1:-.claude/hooks/tool_allowlist.py}"
fail=0
t() { r=$(printf '%s' "$2" | python3 "$hook" 2>/dev/null; echo $?); r=${r##*$'\n'}
      if [ "$r" = "$1" ]; then echo "ok   exp=$1 $2"; else echo "BAD  exp=$1 got=$r $2"; fail=1; fi; }
# negative controls: must block (2)
t 2 '{"tool_name":"mcp__9c01eb9f-d108-4a67-8a1c-59fbea9a1f7c__send_message"}'
t 2 '{"tool_name":"mcp__1a59c906-04da-521d-bda7-7f71b9f9e01c__update"}'
t 2 '{"tool_name":"mcp__Gmail__send_message"}'
t 2 '{"tool_name":"mcp__github_evil__x"}'
t 2 '{"tool_name":"mcp__github__create_or_update_file","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 2 '{"tool_name":"mcp__github__create_pull_request","tool_input":{"owner":"batuhanozgun","repo":"soul"}}'
t 2 '{"tool_name":"mcp__github__create_repository","tool_input":{"name":"x"}}'
t 2 '{"tool_name":"mcp__github__push_files"}'
t 2 '[]'
t 2 '"x"'
t 2 '{}'
t 2 '{"tool_name":null}'
t 2 'garbage'
# positive controls: must allow (0)
t 0 '{"tool_name":"mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__execute_sql"}'
t 0 '{"tool_name":"mcp__claude-code-remote__create_session"}'
t 0 '{"tool_name":"mcp__github__get_me"}'
t 0 '{"tool_name":"mcp__github__get_file_contents","tool_input":{"owner":"batuhanozgun","repo":"agentic-os-search"}}'
t 0 '{"tool_name":"mcp__github__create_pull_request","tool_input":{"owner":"batuhanozgun","repo":"devos"}}'
t 0 '{"tool_name":"mcp__github__merge_pull_request","tool_input":{"owner":"batuhanozgun","repo":"devos","pullNumber":4}}'
t 0 '{"tool_name":"Bash"}'
[ $fail -eq 0 ] && echo "ALLOWLIST_TEST PASS" || echo "ALLOWLIST_TEST FAIL"
exit $fail
