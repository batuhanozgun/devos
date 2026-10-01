#!/usr/bin/env bash
# builder_check.sh: machine check printed in every stop report (Builder Operating Model, 3.4).
# The /goal evaluator sees only the conversation; this output gives it evidence instead of claims.
# Usage: tools/builder_check.sh   (run from the repository root)
set -u
fail=0
ok()  { echo "PASS  $1"; }
bad() { echo "FAIL  $1"; fail=1; }

git fetch -q origin main 2>/dev/null || bad "cannot fetch origin/main"

[ -z "$(git status --porcelain)" ] && ok "working tree clean" || bad "uncommitted changes present"

ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "?")
[ "$ahead" = "0" ] && ok "no commits ahead of origin/main" || bad "$ahead commit(s) not merged into main"

for f in plan/ledger.md DURUM.md plan/Builder_Operating_Model.md CLAUDE.md; do
  git cat-file -e "origin/main:$f" 2>/dev/null && ok "$f present on main" || bad "$f missing on main"
done

l=$(git log -1 --format=%ct origin/main -- plan/ledger.md 2>/dev/null || echo 0)
d=$(git log -1 --format=%ct origin/main -- DURUM.md 2>/dev/null || echo 0)
[ "${d:-0}" -ge "${l:-0}" ] && ok "DURUM.md updated with or after the latest ledger change" || bad "DURUM.md older than the ledger"

lock=$(git show origin/main:plan/ledger.md 2>/dev/null | grep '^| Run lock |' || true)
if [ -z "$lock" ]; then bad "run lock row missing"
else
  ok "run lock row present"
  sid="${CLAUDE_CODE_REMOTE_SESSION_ID:-}"; sid="${sid#cse_}"
  holder=$(printf '%s' "$lock" | grep -oE '`session_[A-Za-z0-9]+`' | head -1 | tr -d '`')
  [ "${BUILDER_RUN:-0}" = "1" ] && echo "MODE  run" || echo "MODE  report"
  if [ -n "$sid" ] && [ "$holder" = "session_$sid" ]; then ok "run lock holder is this session ($holder)"
  elif [ "${BUILDER_RUN:-0}" = "1" ]; then bad "run lock does not name this session (BUILDER_RUN=1)"
  else echo "INFO  run lock does not name this session (expected for reviewers, probes and the dispatcher; runs set BUILDER_RUN=1)"; fi
  exp=$(printf '%s' "$lock" | grep -oE 'Expires [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}Z' | head -1 | cut -d' ' -f2)
  e=$(date -u -d "${exp:-1970-01-01T00:00Z}" +%s 2>/dev/null || echo 0); now=$(date -u +%s)
  if [ "$e" -le "$now" ]; then bad "run lock expiry missing or past (${exp:-none})"
  elif [ $((e - now)) -gt 11700 ]; then bad "run lock expiry $exp is more than 3h15m ahead (Builder Operating Model 2.2)"
  else ok "run lock expiry $exp is within the next 3h15m"; fi
fi
echo "NOTE  this check does not prove that work was done or that DURUM.md content is accurate; see Builder Operating Model 3.4"

echo "main=$(git rev-parse --short origin/main) head=$(git rev-parse --short HEAD) at $(date -u +%Y-%m-%dT%H:%MZ)"
[ $fail -eq 0 ] && echo "BUILDER_CHECK PASS" || echo "BUILDER_CHECK FAIL"
exit $fail
