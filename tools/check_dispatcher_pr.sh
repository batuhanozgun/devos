#!/usr/bin/env bash
# Scope check for the dispatcher's standing record PR (Builder Operating Model 2.3; R-C00-BOM-7 B2).
# A run may merge claude/dispatcher only if, against main, it changes nothing but
# the "Son nabız" line of DURUM.md and appended lines in plan/ledger/<stage>-log.md.
# Usage: tools/check_dispatcher_pr.sh [base] [head]  -> "DISPATCHER_PR OK" (exit 0) or "DISPATCHER_PR REFUSE" (exit 1)
set -u
base="${1:-origin/main}"; head="${2:-origin/claude/dispatcher}"
git fetch -q origin main claude/dispatcher 2>/dev/null
mb=$(git merge-base "$base" "$head") || { echo "DISPATCHER_PR REFUSE (no merge base)"; exit 1; }
bad=0
for f in $(git diff --name-only "$mb" "$head"); do
  case "$f" in
    DURUM.md)
      if git diff -U0 "$mb" "$head" -- "$f" | grep -E '^[-+][^-+]' | grep -v 'Son nabız' | grep -q .; then
        echo "refuse: DURUM.md changes lines other than the heartbeat line"; bad=1; fi ;;
    plan/ledger/*-log.md)
      if git diff -U0 "$mb" "$head" -- "$f" | grep -qE '^-[^-]'; then
        echo "refuse: $f has removed or changed lines"; bad=1; fi ;;
    *) echo "refuse: $f is outside the dispatcher's scope"; bad=1 ;;
  esac
done
[ $bad -eq 0 ] && { echo "DISPATCHER_PR OK"; exit 0; } || { echo "DISPATCHER_PR REFUSE"; exit 1; }
