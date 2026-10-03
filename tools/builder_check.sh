#!/usr/bin/env bash
# builder_check.sh: machine check printed in every stop report (Builder Operating Model, 3.4; C-R1).
# The /goal evaluator sees only the conversation; this output gives it evidence instead of claims.
# Usage: tools/builder_check.sh [S1|S2|S3|S4|S5 [ISSUE_READ_FAILED]] [--since REV]   (run from the repository root)
#   The stop reason is optional while the R1 template calls the script without one (its change is 1c's
#   v1.8 delta); without it, the reason's own conditions are not checked and an INFO line says so.
#   --since overrides the record-check baseline for scratch tests; with BUILDER_RUN=1 it is refused.
# Every FAIL line carries a class tag [class]; R-R9 counts the classes (04_roles.md section 6 item 3).
set -u
fail=0
reason=""; reason2=""; since=""
while [ $# -gt 0 ]; do
  case "$1" in
    S1|S2|S3|S4|S5) reason="$1" ;;
    ISSUE_READ_FAILED) reason2="$1" ;;
    --since) shift; since="${1:-}" ;;
    *) echo "FAIL  [usage] unknown argument '$1'"; fail=1 ;;
  esac
  shift
done
classes=""
ok()  { echo "PASS  $1"; }
bad() { echo "FAIL  [$1] $2"; fail=1; classes="$classes $1"; }

git fetch -q origin main 2>/dev/null || bad fetch "cannot fetch origin/main"

[ -z "$(git status --porcelain)" ] && ok "working tree clean" || bad tree "uncommitted changes present"

ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "?")
[ "$ahead" = "0" ] && ok "no commits ahead of origin/main" || bad ahead "$ahead commit(s) not merged into main"

for f in plan/ledger.md DURUM.md plan/Builder_Operating_Model.md CLAUDE.md; do
  git cat-file -e "origin/main:$f" 2>/dev/null && ok "$f present on main" || bad files "$f missing on main"
done

l=$(git log -1 --format=%ct origin/main -- plan/ledger.md 2>/dev/null || echo 0)
d=$(git log -1 --format=%ct origin/main -- DURUM.md 2>/dev/null || echo 0)
[ "${d:-0}" -ge "${l:-0}" ] && ok "DURUM.md updated with or after the latest ledger change" || bad durum-age "DURUM.md older than the ledger"

sid="${CLAUDE_CODE_REMOTE_SESSION_ID:-}"; sid="${sid#cse_}"
lock=$(git show origin/main:plan/ledger.md 2>/dev/null | grep '^| Run lock |' || true)
released=0
if [ -z "$lock" ]; then bad lease "run lock row missing"
else
  ok "run lock row present"
  holder=$(printf '%s' "$lock" | grep -oE '`session_[A-Za-z0-9]+`' | head -1 | tr -d '`')
  [ "${BUILDER_RUN:-0}" = "1" ] && echo "MODE  run" || echo "MODE  report"
  if [ -n "$sid" ] && [ "$holder" = "session_$sid" ]; then ok "run lock holder is this session ($holder)"
  elif [ "${BUILDER_RUN:-0}" = "1" ]; then bad lease "run lock does not name this session (BUILDER_RUN=1)"
  else echo "INFO  run lock does not name this session (expected for reviewers, probes and the dispatcher; runs set BUILDER_RUN=1)"; fi
  exp=$(printf '%s' "$lock" | grep -oE 'Expires [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}Z' | head -1 | cut -d' ' -f2)
  e=$(date -u -d "${exp:-1970-01-01T00:00Z}" +%s 2>/dev/null || echo 0); now=$(date -u +%s)
  if printf '%s' "$lock" | grep -qE 'Released [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}Z'; then ok "run lock released at a clean stop (Builder Operating Model 2.2)"; released=1
  elif [ "$e" -le "$now" ]; then bad lease "run lock expiry missing or past (${exp:-none})"
  elif [ $((e - now)) -gt 11700 ]; then bad lease "run lock expiry $exp is more than 3h15m ahead (Builder Operating Model 2.2)"
  else ok "run lock expiry $exp is within the next 3h15m"; fi
fi

# ---- record checks (C-R1: every check_records.py subcommand; tranche 1b-ii)
if [ -n "$since" ] && [ "${BUILDER_RUN:-0}" = "1" ]; then bad baseline "--since is refused in a run (BUILDER_RUN=1)"; fi
run_records() {  # $1 label, rest: arguments
  local label="$1"; shift
  local out rc
  out=$(python3 tools/check_records.py "$@" 2>&1); rc=$?
  last_out="$out"
  printf '%s\n' "$out" | grep -E '^(INFO|EXCEPTION)' | sed 's/^/      /'
  while IFS= read -r line; do
    cls=$(printf '%s' "$line" | sed -nE 's/^FAIL  \[([a-z-]+)\].*/\1/p')
    bad "${cls:-records}" "${line#FAIL  \[*\] }"
  done < <(printf '%s\n' "$out" | grep '^FAIL')
  if [ $rc -eq 0 ]; then ok "record checks: $label"
  elif [ $rc -ne 1 ]; then bad records "check_records.py $label crashed (exit $rc)"; fi
}
run_records "all (tree and origin/main..worktree)" all --base origin/main
if [ -n "$since" ]; then run_records "merged since $since" merged --since "$since"; else run_records "merged since the baseline" merged; fi
merged_out="$last_out"

# ---- Batu's answers (M-R13)
aout=$(python3 tools/check_records.py answers 2>&1); arc=$?
printf '%s\n' "$aout" | grep '^INFO' | sed 's/^/      /'
if [ $arc -eq 0 ]; then ok "issue #6: every comment by batuhanozgun is accounted for (M-R13)"
elif printf '%s' "$aout" | grep -q 'ISSUE_READ_FAILED'; then
  lastentry=$(awk '/^### L-[0-9]+/{buf=""} {buf=buf"\n"$0} END{print buf}' $(ls plan/ledger/*-log.md | sort | tail -1))
  if [ "$reason" = "S3" ] && [ "$reason2" = "ISSUE_READ_FAILED" ] && printf '%s' "$lastentry" | grep -q 'issue read by MCP:'; then
    echo "INFO  ISSUE_READ_FAILED, accepted for S3 ISSUE_READ_FAILED: the stop's log entry carries 'issue read by MCP:' (M-R13)"
  else bad answers "ISSUE_READ_FAILED: issue #6 could not be read (M-R13); only S3 ISSUE_READ_FAILED with an 'issue read by MCP:' log line passes"; fi
else
  printf '%s\n' "$aout" | grep '^FAIL' | while IFS= read -r line; do echo "$line"; done
  bad answers "a comment by batuhanozgun is not accounted for (M-R13)"
fi

# ---- leak check on committed, staged and untracked content (A-07)
lk=$(tools/check_service_names.sh 2>&1); lrc=$?
if [ $lrc -eq 0 ]; then ok "leak check, tracked tree: $lk"; else bad leak "leak check, tracked tree: $(printf '%s' "$lk" | head -1)"; fi
lout=$(python3 tools/check_records.py leak 2>&1); lrc2=$?
n1=$(printf '%s' "$lk" | grep -oE '[0-9]+ terms' | grep -oE '[0-9]+'); n2=$(printf '%s' "$lout" | sed -nE 's/.*\[leak\] terms ([0-9]+).*/\1/p')
if [ $lrc2 -eq 0 ]; then ok "leak check, staged and untracked content"
else printf '%s\n' "$lout" | grep '^FAIL' | while IFS= read -r line; do echo "$line"; done; bad leak "derived service term in staged or untracked content"; fi
[ -n "$n1" ] && [ "$n1" = "$n2" ] || bad leak "the two leak derivations disagree on the term count (${n1:-?} and ${n2:-?})"

# ---- the stop reason's own conditions (C-R1, C-R11)
owned=".claude/hooks/owned_ids.txt"
wakes=$(git show origin/main:plan/ledger.md 2>/dev/null | grep '^| Armed wakes |' || true)
wake_owned() {  # $1 type
  printf '%s' "$wakes" | grep -oE "$1 [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}Z [A-Za-z0-9_]+" | awk '{print $3}' | while read -r id; do
    grep -qx "$id" "$owned" 2>/dev/null && echo "$id"; done | head -1
}
case "$reason" in
  "") echo "INFO  no stop reason given: the reason's own conditions (C-R1) are not checked; R1's call changes in 1c's v1.8 delta" ;;
  S1) open=$(python3 -c '
import sys; sys.dont_write_bytecode = True; sys.path.insert(0, "tools"); import records as R
from pathlib import Path
items, d = R.load_records(Path("."))
st = [s for s in items.values() if s.get("kind") == "stage" and s.get("execution") == "running"]
print(" ".join(i for s in st for i in R.descendants(items, s["id"]) if items[i].get("kind") == "item" and not R.is_closed(items[i])))' 2>&1)
      [ -z "$open" ] && ok "S1: no open item in the running stage" || bad reason "S1: open items remain: ${open:0:120}" ;;
  S2) [ -n "$(wake_owned Check-in)" ] && ok "S2: an owned Check-in wake is armed" || bad reason "S2 needs an owned Check-in entry in the Armed wakes row (C-R3, C-R11)" ;;
  S3) [ "$released" = "1" ] && ok "S3: the lease is released" || bad reason "S3 needs the lease released (Builder Operating Model 2.2)" ;;
  S4) ok "S4: nothing is required about the successor (it is created after this check)" ;;
  S5) [ -n "$(wake_owned S5)" ] && ok "S5: an owned S5 wake is armed" || bad reason "S5 needs an owned S5 entry in the Armed wakes row (C-R2, C-R11)" ;;
esac
[ -n "$reason" ] && echo "REASON $reason${reason2:+ $reason2}"

# ---- R-R9 hand-over signal: a failure class counts only on a committed head equal to its upstream
due=0
gd=$(git rev-parse --git-dir 2>/dev/null); store="$gd/builder_check_fails/${sid:-nosession}"
up=$(git rev-parse -q --verify '@{u}' 2>/dev/null || true)
if [ -z "$(git status --porcelain)" ] && [ -n "$up" ] && [ "$up" = "$(git rev-parse HEAD)" ]; then
  if [ -n "${classes// /}" ]; then mkdir -p "$gd/builder_check_fails"; printf '%s\n' "$(printf '%s\n' $classes | sort -u | tr '\n' ' ')" >> "$store"; fi
fi
if [ -f "$store" ] && [ -n "$(tr ' ' '\n' < "$store" | grep -v '^$' | sort | uniq -d)" ]; then due=1; fi
exc=$(printf '%s\n' "$merged_out" | grep '^EXCEPTION' | grep "session_${sid:-none}" || true)
[ -n "$exc" ] && due=1
if [ $due -eq 1 ]; then
  echo "HAND-OVER DUE (R-R9): $( [ -n "$exc" ] && echo "a failure of this session reached main" || echo "a failure class repeated at a checkpoint: $(tr ' ' '\n' < "$store" | grep -v '^$' | sort | uniq -d | tr '\n' ' ')")"
  [ "$reason" = "S4" ] || bad R-R9 "after HAND-OVER DUE only the stop reason S4 is accepted"
fi

echo "NOTE  this check does not prove that work was done or that DURUM.md content is accurate; see Builder Operating Model 3.4"
echo "main=$(git rev-parse --short origin/main) head=$(git rev-parse --short HEAD) at $(date -u +%Y-%m-%dT%H:%MZ)"
[ $fail -eq 0 ] && echo "BUILDER_CHECK PASS" || echo "BUILDER_CHECK FAIL"
exit $fail
