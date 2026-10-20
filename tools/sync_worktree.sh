#!/usr/bin/env bash
# sync_worktree.sh: fast-forward the live working tree to origin/main (plan/Installation_Working_Order.md
# section 4, step 5; W-C00-12.6). The guard denies other revision changes in this tree (rule B4).
# It acts only on its own checkout: unless the working directory's toplevel is the tree this script lives in (both
# resolved), it refuses before fetching (N-315; W-C02-29 (i)).
# It may discard only these local changes, after every check below has passed, and never some of them alone:
# - .claude/hooks/owned_ids.txt, only when every ID listed there is already on origin/main, so that no owned ID is
#   lost (git refuses a fast-forward over a local change, even an identical one);
# - plan/ledger.md and DURUM.md, each on its own, only when HEAD is an ancestor of origin/main and the change is an
#   unstaged render stamp (W-C02-29 (ii)): exactly one line on each side starts with the anchored prefix, and the
#   two sides are byte-equal once that line's timestamp token, in the strict format records.py writes, is replaced.
#   Each such discard prints "SYNC DISCARDED: <path> (render stamp only)"; the executor logs it as a departure.
# Any other local change, an ID that is only local, or a comparison step that fails refuses the sync untouched.
set -euo pipefail
export LC_ALL=C
refuse() { echo "SYNC REFUSED: $1"; [ $# -lt 2 ] || printf '%s\n' "$2"; exit 1; }

self=$(readlink -f -- "${BASH_SOURCE[0]}" 2>/dev/null) || self=
own=; [ -z "$self" ] || own=$(cd -P -- "${self%/*}/.." 2>/dev/null && pwd -P) || own=
top=$(git rev-parse --show-toplevel 2>/dev/null) || top=
[ -z "$top" ] || top=$(cd -P -- "$top" 2>/dev/null && pwd -P) || top=
if [ -z "$own" ] || [ "$own" != "$top" ]; then
  refuse "this script belongs to ${own:-an unresolved checkout}, not to the working tree ${top:-(none)}; run that tree's own tools/sync_worktree.sh"
fi
cd "$top"
git fetch -q origin +refs/heads/main:refs/remotes/origin/main
dirty=$(git status --porcelain --untracked-files=no)
owned=no; views=()
if [ -n "$dirty" ]; then
  while IFS= read -r line; do
    case $line in
      " M .claude/hooks/owned_ids.txt") owned=yes ;;
      " M plan/ledger.md") views+=(plan/ledger.md) ;;
      " M DURUM.md") views+=(DURUM.md) ;;
      *) refuse "local changes besides owned_ids.txt and unstaged changes of plan/ledger.md or DURUM.md:" "$dirty" ;;
    esac
  done <<< "$dirty"
fi
if [ "$owned" = yes ]; then
  missing=$(comm -23 <(grep -v '^#' .claude/hooks/owned_ids.txt | sed '/^$/d' | sort -u) \
                     <(git show origin/main:.claude/hooks/owned_ids.txt | grep -v '^#' | sed '/^$/d' | sort -u))
  if [ -n "$missing" ]; then
    refuse "these owned IDs are only in this working tree; merge their recorder lines first:" "$missing"
  fi
fi

# load VAR SPEC: read HEAD:<path> or the file <path> into VAR byte for byte; fails unless git hashes what was read to
# the source's own object id (so a failed or empty read, a NUL byte or a lost final newline fails, never passes).
load() {
  local -n into=$1; local want got
  if [[ $2 == HEAD:* ]]; then
    want=$(git rev-parse -q --verify "$2") || return 1
    IFS= read -r -d '' into < <(git cat-file blob "$2") || true
  else
    [ -f "$2" ] && [ ! -L "$2" ] || return 1
    want=$(git hash-object --no-filters -- "$2") || return 1
    IFS= read -r -d '' into < "$2" || true
  fi
  got=$(printf '%s' "$into" | git hash-object --stdin) || return 1
  [[ $want =~ ^[0-9a-f]{40}([0-9a-f]{24})?$ ]] && [ "$got" = "$want" ]
}
# norm TEXT PREFIX REGEX: set NORM to TEXT with its stamp token replaced by a fixed word. Fails unless exactly one
# line starts with PREFIX, that line matches REGEX (group 1: before the token; last group: after it), and the split
# puts TEXT back together byte for byte.
norm() {
  local s=$'\n'$1 p=$'\n'$2 re=$3 b r ln a
  [[ $s == *"$p"* ]] || return 1
  b=${s%"$p"*}; r=${s:${#b}+${#p}}
  [[ $b != *"$p"* ]] || return 1
  ln=${r%%$'\n'*}; a=${r:${#ln}}
  [ "$b$p$ln$a" = "$s" ] || return 1
  [[ $2$ln =~ $re ]] || return 1
  NORM=$b$'\n'${BASH_REMATCH[1]}STAMP${BASH_REMATCH[${#BASH_REMATCH[@]}-1]}$a
}
LEDGER_RE='^(\| Rendered \|.*\| )[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}Z( \|)$'
DURUM_RE='^(\*\*Son güncelleme:\*\* )([1-9]|[12][0-9]|3[01]) (Ocak|Şubat|Mart|Nisan|Mayıs|Haziran|Temmuz|Ağustos|Eylül|Ekim|Kasım|Aralık) [0-9]{4}, [0-9]{2}:[0-9]{2}(.*)$'
# stamp_only PATH: the change of PATH against HEAD is its render stamp token only.
stamp_only() {
  local pre re htxt wtxt hnorm
  case $1 in
    plan/ledger.md) pre='| Rendered |'; re=$LEDGER_RE ;;
    DURUM.md) pre='**Son güncelleme:** '; re=$DURUM_RE ;;
    *) return 1 ;;
  esac
  load htxt "HEAD:$1" && load wtxt "$1" || return 1
  norm "$htxt" "$pre" "$re" || return 1
  hnorm=$NORM; NORM=
  norm "$wtxt" "$pre" "$re" || return 1
  [ -n "$hnorm" ] && [ "$hnorm" = "$NORM" ]
}
if [ ${#views[@]} -gt 0 ]; then
  git merge-base --is-ancestor HEAD origin/main \
    || refuse "HEAD is not an ancestor of origin/main; a render's views are discarded only on the way to main"
  for f in "${views[@]}"; do
    stamp_only "$f" || refuse "$f: its change is not a render stamp only (or it could not be compared); nothing was discarded"
  done
fi

[ "$owned" = no ] || git checkout -q -- .claude/hooks/owned_ids.txt
for f in "${views[@]}"; do
  git checkout -q -- "$f"
  echo "SYNC DISCARDED: $f (render stamp only)"
done
git merge --ff-only -q origin/main
echo "SYNC OK: $(git rev-parse --short HEAD) = origin/main"
