#!/usr/bin/env bash
# stop_check.sh: evidence for a /goal stop message (plan/Installation_Working_Order.md section 7).
# Run from the root of the live working tree; paste its output unedited. It accepts nothing.
set -u
fail=0
ok()  { echo "PASS  $1"; }
bad() { echo "FAIL  $1"; fail=1; }

git fetch -q origin main 2>/dev/null || bad "cannot fetch origin/main"
om=$(git rev-parse -q --verify origin/main 2>/dev/null || true)
br=$(git branch --show-current 2>/dev/null)
if [ "$br" = "main" ] && [ -n "$om" ] && [ "$(git rev-parse HEAD)" = "$om" ]; then ok "main equals origin/main (${om:0:12})"
else bad "the working tree is not on main at origin/main (branch '${br:-none}', head $(git rev-parse --short HEAD), origin/main ${om:0:12})"; fi

[ -z "$(git status --porcelain)" ] && ok "working tree clean" || bad "uncommitted changes: $(git status --porcelain | head -5 | tr '\n' ' ')"

gr=$(python3 tools/guard_report.py 2>&1); grc=$?
printf '%s\n' "$gr" | sed -n '1,5p' | sed 's/^/      /'
[ $grc -eq 0 ] && ok "guard_report: decision log read" || bad "guard_report: no decision log for this session"

today=$(date -u +%Y-%m-%d)
d=$(TZ=UTC git log -1 --format=%cd --date=format-local:%Y-%m-%d origin/main -- DURUM.md 2>/dev/null)
[ "$d" = "$today" ] && ok "DURUM.md updated today ($today, UTC) on main" || bad "DURUM.md last changed on main ${d:-never}, not today ($today, UTC)"

echo "main=${om:0:12} head=$(git rev-parse --short HEAD) at $(date -u +%Y-%m-%dT%H:%MZ)"
[ $fail -eq 0 ] && echo "STOP_CHECK PASS" || echo "STOP_CHECK FAIL"
exit $fail
