#!/usr/bin/env bash
# sync_worktree.sh: fast-forward the live working tree to origin/main (plan/Installation_Working_Order.md
# section 4, step 5; W-C00-12.6). The guard denies other revision changes in this tree (rule B4).
# The only local change it may discard is .claude/hooks/owned_ids.txt, and only when every ID listed there
# is already on origin/main, so that no owned ID is lost (git refuses a fast-forward over a local change,
# even an identical one). Any other local change, or an ID that is only local, refuses the sync.
set -euo pipefail
root=$(git rev-parse --show-toplevel)
cd "$root"
git fetch -q origin +refs/heads/main:refs/remotes/origin/main
dirty=$(git status --porcelain --untracked-files=no)
if [ -n "$dirty" ]; then
  if [ "$dirty" != " M .claude/hooks/owned_ids.txt" ]; then
    echo "SYNC REFUSED: local changes besides owned_ids.txt:"
    echo "$dirty"
    exit 1
  fi
  missing=$(comm -23 <(grep -v '^#' .claude/hooks/owned_ids.txt | sed '/^$/d' | sort -u) \
                     <(git show origin/main:.claude/hooks/owned_ids.txt | grep -v '^#' | sed '/^$/d' | sort -u))
  if [ -n "$missing" ]; then
    echo "SYNC REFUSED: these owned IDs are only in this working tree; merge their recorder lines first:"
    echo "$missing"
    exit 1
  fi
  git checkout -q -- .claude/hooks/owned_ids.txt
fi
git merge --ff-only -q origin/main
echo "SYNC OK: $(git rev-parse --short HEAD) = origin/main"
