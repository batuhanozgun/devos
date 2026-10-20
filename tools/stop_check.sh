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
echo "      branch: ${br:-none (detached HEAD)} (information only)"
if [ -n "$om" ] && [ "$(git rev-parse HEAD)" = "$om" ]; then ok "HEAD equals origin/main (${om:0:12})"
else bad "HEAD is not at origin/main (head $(git rev-parse --short HEAD), origin/main ${om:0:12})"; fi

[ -z "$(git status --porcelain)" ] && ok "working tree clean" || bad "uncommitted changes: $(git status --porcelain | head -5 | tr '\n' ' ')"

rd=$(python3 -B tools/records.py render --check 2>&1); rdc=$?
printf '%s\n' "$rd" | sed 's/^/      /'
[ $rdc -eq 0 ] && ok "records.py render --check: views current, log entries carry the nine answers (D-016)" || bad "records.py render --check: exit $rdc (its lines above say why)"

gr=$(python3 tools/guard_report.py 2>&1); grc=$?
printf '%s\n' "$gr" | sed -n '1,5p' | sed 's/^/      /'
[ $grc -eq 0 ] && ok "guard_report: decision log read" || bad "guard_report: no decision log for this session"

# W-C02-25 (SB-COR 3.5): the agent hooks' liveness for this session; its claim is only "scripts present and working;
# hooks live as of the last finished run's records" (re-read after a worker restart).
lv=$(python3 tools/guard_report.py --liveness 2>&1); lvc=$?
printf '%s\n' "$lv" | sed 's/^/      /'
[ $lvc -eq 0 ] && ok "guard_report.py --liveness: LIVENESS PASS" || bad "guard_report.py --liveness: exit $lvc (2 is could not check; its lines above say why)"

today=$(date -u +%Y-%m-%d)
d=$(TZ=UTC git log -1 --format=%cd --date=format-local:%Y-%m-%d origin/main -- DURUM.md 2>/dev/null)
[ "$d" = "$today" ] && ok "DURUM.md updated today ($today, UTC) on main" || bad "DURUM.md last changed on main ${d:-never}, not today ($today, UTC)"

# PC-23: the newest log entry (highest L-number in plan/ledger/*-log.md; it ends at the next heading of level 1 to 3,
# as records.py reads it) carries a "- **Wait:** " line.
ln=$(grep -h '^### L-[0-9]' plan/ledger/*-log.md 2>/dev/null | sed 's/^### L-\([0-9]*\).*/\1/' | sort -n | tail -1)
lf=$(grep -l "^### L-${ln} " plan/ledger/*-log.md 2>/dev/null | head -1)
if [ -n "$ln" ] && [ -n "$lf" ] && awk -v h="### L-${ln} " 'index($0,h)==1{f=1;next} f&&/^(#|##|###) /{exit} f' "$lf" | grep -q '^- \*\*Wait:\*\* '
then ok "newest log entry L-$ln carries its Wait line (working order section 7; PC-23)"
else bad "newest log entry L-${ln:-?} has no '- **Wait:** ' line (working order section 7; PC-23)"; fi

echo "main=${om:0:12} head=$(git rev-parse --short HEAD) at $(date -u +%Y-%m-%dT%H:%MZ)"
[ $fail -eq 0 ] && echo "STOP_CHECK PASS" || echo "STOP_CHECK FAIL"
exit $fail
