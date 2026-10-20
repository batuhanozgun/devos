#!/usr/bin/env bash
# Synthetic test data (plan Section 8 item 13): every repository, record and ID below is made up for the test.
#
# test_sync_worktree.sh: planted cases for tools/sync_worktree.sh (N-315; W-C02-29). Written by the test designer
# before the change. Each case builds a local bare origin and a clone of it on a branch not named main, copies this
# checkout's tools/sync_worktree.sh and tools/records.py into it (committed, so they are that clone's own), plants a
# state, runs the sync as the executor does (bash tools/sync_worktree.sh from the clone's root, unless the case says
# otherwise) and reads only the interface: the exit code, the printed lines and the files' bytes. Prints one line per
# case, "ok" or "BAD", and SYNC_WORKTREE_TEST PASS only if every case behaves as written.
#
# Form C0 (Appendix C):
# - Claim: the sync discards a local change only when it is a render stamp, (ii): plan/ledger.md or DURUM.md, each on
#   its own, unstaged against HEAD, with exactly one line on each side starting with its anchored prefix ("| Rendered |";
#   "**Son güncelleme:** "), only the timestamp token in its strict format replaced ("YYYY-MM-DDTHH:MMZ" in the row's
#   last cell; "D <Turkish month> YYYY, HH:MM" in DURUM.md's line, as records.py writes them), all else byte-equal;
#   only when HEAD is an ancestor of origin/main; never half; and it refuses to act on a tree that is not its own
#   checkout, (i). The interface pinned by W-C02-29's condition:
#     success: exit 0, last line "SYNC OK: <short sha> = origin/main", one line per discarded view,
#              exactly "SYNC DISCARDED: <path> (render stamp only)", <path> being plan/ledger.md or DURUM.md;
#     refusal: exit 1, a line starting "SYNC REFUSED: ", no SYNC OK or SYNC DISCARDED line, HEAD, index, branch and
#              every byte of the working tree (untracked files included) unchanged.
# - Failure class: a sync that discards, or carries forward, a local change that is not a re-render of the committed
#   records, or that acts on a tree other than its own. Examples: L-431's live tree (S02 is a real render; R01 to R21
#   plant the other manifestations); a foreign clone's sync run from the live tree (R22).
# - Negative control: R01 to R23 (refused). Against main 253260c: S02 to S09, S12, R22b and R22c are BAD, the
#   others ok (today's script refuses every view change; R22a refuses only because the tree is dirty).
# - Positive control: S01 to S12 (accepted, the over-blocking controls); S13 (a fast-forward git itself refuses).
# - Break: W-C02-29's condition, point 4, names each guard line's mutation and the cases it turns BAD.
# - Stage and environment: C02; counted: a fresh clone at the pull request's head, the container's bash, git and
#   python3 with PyYAML. Independence: written by the test designer; run by the producer and by the binding checker,
#   who judges. Evidence layer: behavioural (exit code, lines, bytes). It does not show the live tree's run (point 6).
# - Evidence envelope: the raw output with the head SHA, the blobs of this file and of tools/sync_worktree.sh, the
#   versions of bash, git and python3, in the item's evidence record.
set -u
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
SYNC="$HERE/sync_worktree.sh"
RECORDS="$HERE/records.py"
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
export GIT_TERMINAL_PROMPT=0 GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export GIT_COMMITTER_NAME=fixture GIT_COMMITTER_EMAIL=fixture@example.invalid
export GIT_AUTHOR_NAME=fixture GIT_AUTHOR_EMAIL=fixture@example.invalid
OKS=0; BADS=0
BRANCH=claude/fixture-live

ok()  { echo "ok   $1"; OKS=$((OKS+1)); }
bad() { echo "BAD  $1: $(printf '%s' "${2:-}" | tr '\n' '|' | cut -c1-600)"; BADS=$((BADS+1)); }

py() { python3 -I -B -c "$@"; }
# edit FILE OLD NEW: replace the one occurrence of OLD (it must occur exactly once).
edit() { py 'import sys; p,o,n=sys.argv[1:4]; s=open(p,encoding="utf-8").read(); c=s.count(o)
if c!=1: sys.exit(f"edit: {p}: {c} occurrences of {o!r}")
open(p,"w",encoding="utf-8").write(s.replace(o,n))' "$@"; }
# setline FILE PREFIX N NEWLINE: replace the N-th line (1-based) starting with PREFIX; N=0 means "the only one".
setline() { py 'import sys; p,pre,n,new=sys.argv[1:5]; n=int(n); ls=open(p,encoding="utf-8").read().split("\n")
hits=[i for i,l in enumerate(ls) if l.startswith(pre)]
if (n==0 and len(hits)!=1) or len(hits)<max(n,1): sys.exit(f"setline: {p}: {len(hits)} lines start with {pre!r}")
ls[hits[n-1 if n else 0]]=new; open(p,"w",encoding="utf-8").write("\n".join(ls))' "$@"; }
# getline FILE PREFIX N: print the N-th line starting with PREFIX (N=0: the only one).
getline() { py 'import sys; p,pre,n=sys.argv[1:4]; n=int(n); hits=[l for l in open(p,encoding="utf-8").read().split("\n") if l.startswith(pre)]
if (n==0 and len(hits)!=1) or len(hits)<max(n,1): sys.exit(f"getline: {p}: {len(hits)} lines start with {pre!r}")
print(hits[n-1 if n else 0])' "$@"; }
# snap DIR: HEAD, branch, status (untracked and ignored too), the index's content, the stash, and every byte of the
# working tree outside .git (a symlink: its target).
snap() {
  git -C "$1" rev-parse HEAD; git -C "$1" symbolic-ref -q HEAD
  git -C "$1" status --porcelain=v1 --untracked-files=all --ignored
  git -C "$1" diff --cached --binary | sha256sum; git -C "$1" stash list
  py 'import hashlib,os,sys; r=sys.argv[1]; out=[]
for dp,dns,fns in os.walk(r):
    dns[:]=[d for d in dns if not (dp==r and d==".git")]
    for f in fns+[d for d in dns if os.path.islink(os.path.join(dp,d))]:
        p=os.path.join(dp,f)
        out.append(os.path.relpath(p,r)+" "+("link:"+os.readlink(p) if os.path.islink(p) else hashlib.sha256(open(p,"rb").read()).hexdigest()))
print("\n".join(sorted(out)))' "$1"
}

LPRE='| Rendered |'
DPRE='**Son güncelleme:** '
LROW() { echo "| Rendered | Written by \`tools/records.py render\` from the clock; \`DURUM.md\`'s update line comes from here. | $1 |"; }
DLINE() { echo "**Son güncelleme:** $1 (Türkiye saati). Bu sayfa \`tools/records.py durum\` ile durum dosyasından (\`plan/ledger.md\`) üretilir; elle yazılan tek kısım \"Şu an\" bölümüdür."; }

# stamp DIR ISO: set the Rendered row's As-of to ISO and regenerate DURUM.md from it with the clone's own records.py.
stamp() { setline "$1/plan/ledger.md" "$LPRE" 0 "$(LROW "$2")" && (cd "$1" && python3 -B tools/records.py durum > DURUM.md); }

# origin KIND: a bare origin whose main has C0 (tag c0) and C1. KIND:
#   base      C1 adds ID-2 to owned_ids.txt, changes notes.txt and adds added.txt; the views are untouched.
#   rerender  as base, and C1 also re-renders the views with the stamp 2026-01-02T00:00Z (as main does in reality).
#   stale     as base, but C0's committed views are stale: a hand line inside a generated block.
#   double    as base, but C0's ledger and DURUM.md each hold a second line with the stamp prefix.
origin() {
  local k=$1 s="$T/seed-$1"
  git init -q -b main "$s" && mkdir -p "$s/tools" "$s/plan/work" "$s/plan/ledger" "$s/.claude/hooks" || return 1
  cp "$SYNC" "$s/tools/sync_worktree.sh" && cp "$RECORDS" "$s/tools/records.py" || return 1
  printf '%s\n' "# Fixture ledger" "" "## 1. Current state" "" "| Item | Value | As-of |" "|---|---|---|" \
    "| summary_tr | Fixture summary. | 2025-12-31T09:00Z |" "| Usage | none | 2025-12-31T09:00Z |" \
    "| Rendered | x | 2025-12-31T09:00Z |" "" "---" "" "## 2. Views" > "$s/plan/ledger.md"
  for b in frontier zoom work-index decisions-index open-notes; do
    printf '\n<!-- generated:%s -->\n\n<!-- /generated -->\n' "$b" >> "$s/plan/ledger.md"; done
  printf '# FX log (append-only)\n' > "$s/plan/ledger/FX-log.md"
  printf '# owned IDs\nID-1\n' > "$s/.claude/hooks/owned_ids.txt"
  printf 'c0\n' > "$s/notes.txt"
  (cd "$s" && python3 -B tools/records.py render > /dev/null) && stamp "$s" 2026-01-01T00:00Z || return 1
  [ "$(cd "$s" && python3 -B tools/records.py render --check | tail -1)" = "RENDER OK" ] || return 1
  case $k in
    stale)  edit "$s/plan/ledger.md" $'<!-- generated:open-notes -->\n' $'<!-- generated:open-notes -->\nA hand line, stale.\n' || return 1 ;;
    double) printf '%s\n' "$(LROW 2026-01-01T00:00Z)" >> "$s/plan/ledger.md"
            printf '%s\n' "$(DLINE '1 Ocak 2026, 03:00')" >> "$s/DURUM.md" ;;
  esac
  git -C "$s" add -A && git -C "$s" commit -q -m c0 && git -C "$s" tag c0 || return 1
  printf 'ID-2\n' >> "$s/.claude/hooks/owned_ids.txt"; printf 'c1\n' > "$s/notes.txt"; printf 'added on main\n' > "$s/added.txt"
  if [ "$k" = rerender ]; then
    printf '%s\n' "#" "### L-001 · 2026-01-02 · fixture" >> "$s/plan/ledger/FX-log.md"
    (cd "$s" && python3 -B tools/records.py render > /dev/null) && stamp "$s" 2026-01-02T00:00Z || return 1
  fi
  git -C "$s" add -A && git -C "$s" commit -q -m c1 && git clone -q --bare "$s" "$T/origin-$k.git"
}

# live KIND [AT]: a fresh clone of origin KIND on branch claude/fixture-live at AT (default c0), its origin/main ref
# left stale at c0 as in the live tree (the sync fetches); at main it is left current. Prints its path.
live() {
  local d; d=$(mktemp -d "$T/live.XXXXXX") || return 1
  git clone -q "$T/origin-$1.git" "$d" && git -C "$d" checkout -q -b "$BRANCH" "${2:-c0}" \
    && { [ "${2:-c0}" != c0 ] || git -C "$d" update-ref refs/remotes/origin/main "$(git -C "$d" rev-parse c0)"; } && echo "$d"
}
render() { (cd "$1" && python3 -B tools/records.py render > /dev/null); }

# run_sync L [CWD] [SCRIPT] [ENV...]: run the sync, as the executor does; sets OUT and RC.
run_sync() {
  local l=$1 cwd=${2:-$1} script=${3:-tools/sync_worktree.sh}; shift; shift; shift
  OUT=$(cd "$cwd" && env "$@" bash "$script" 2>&1); RC=$?
}
discards() { printf '%s\n' "$OUT" | sed -n -E 's/^SYNC DISCARDED: (plan\/ledger\.md|DURUM\.md) \(render stamp only\)$/\1/p' | sort | tr '\n' ' '; }

# expect_ok ID LABEL "EXPECTED DISCARDS" (sorted, space-separated, trailing space; "" for none)
expect_ok() {
  local want_head; want_head=$(git -C "$L" rev-parse origin/main 2>/dev/null)
  if [ "$RC" -eq 0 ] && [ "$(printf '%s\n' "$OUT" | tail -1)" = "SYNC OK: $(git -C "$L" rev-parse --short HEAD) = origin/main" ] \
     && [ "$(git -C "$L" rev-parse HEAD)" = "$want_head" ] && [ "$want_head" = "$(git -C "$T/origin-$KIND.git" rev-parse main)" ] \
     && [ -z "$(git -C "$L" status --porcelain --untracked-files=no)" ] && [ "$(discards)" = "$3" ] \
     && [ "$(git -C "$L" symbolic-ref -q HEAD)" = "refs/heads/$BRANCH" ] \
     && ! printf '%s\n' "$OUT" | grep -q '^SYNC REFUSED'
  then ok "$1 (accepted) $2"; else bad "$1 (accepted) $2" "exit $RC; discarded [$(discards)], want [$3]; $OUT"; fi
}
# expect_refuse ID LABEL: exit 1, a SYNC REFUSED line, nothing discarded or reported OK, the snapshot unchanged.
expect_refuse() {
  if [ "$RC" -eq 1 ] && printf '%s\n' "$OUT" | grep -q '^SYNC REFUSED: ' && ! printf '%s\n' "$OUT" | grep -q '^SYNC OK' \
     && ! printf '%s\n' "$OUT" | grep -q '^SYNC DISCARDED' && [ "$(snap "$L")" = "$BEFORE" ]
  then ok "$1 (refused) $2"; else bad "$1 (refused) $2" "exit $RC; snapshot $([ "$(snap "$L")" = "$BEFORE" ] && echo same || echo CHANGED); $OUT"; fi
}
# expect_safe ID LABEL: not accepted (exit not 0, no SYNC OK or SYNC DISCARDED line) and the snapshot unchanged.
expect_safe() {
  if [ "$RC" -ne 0 ] && ! printf '%s\n' "$OUT" | grep -q '^SYNC OK' && ! printf '%s\n' "$OUT" | grep -q '^SYNC DISCARDED' \
     && [ "$(snap "$L")" = "$BEFORE" ]
  then ok "$1 (not accepted, untouched) $2"; else bad "$1 (not accepted, untouched) $2" "exit $RC; $OUT"; fi
}
# begin ID KIND [AT]: a fresh live clone in L; on a fixture failure the case is BAD (a case that did not run is red).
begin() { CID=$1; KIND=$2; L=$(live "$2" "${3:-}") || { bad "$1 fixture: no live clone" ""; return 1; }; }
fx() { "$@" || { bad "$CID fixture step failed: $*" ""; return 1; }; }
mark() { BEFORE=$(snap "$L"); }
# two_stamps: the E2E precondition: the render changed exactly the two stamp lines.
two_stamps() { [ "$(git -C "$L" diff --numstat | tr '\t' ' ')" = $'1 1 DURUM.md\n1 1 plan/ledger.md' ]; }

for k in base rerender stale double; do origin "$k" > /dev/null 2>&1 || { bad "fixture: origin $k could not be built (python3, PyYAML, git?)" ""; }; done
[ "$BADS" -eq 0 ] || { echo "SYNC_WORKTREE_TEST FAIL ($OKS/$((OKS+BADS))): the fixture did not build"; exit 1; }

# ---------------------------------------------------------------- accepted (over-blocking controls and the heal)
begin S01 base && { mark; run_sync "$L"; expect_ok S01 "a clean tree fast-forwards" ""; }
begin S02 base && fx render "$L" && fx two_stamps && { run_sync "$L"
  expect_ok S02 "a real render by the tree's own records.py (stamp lines only) is healed, both views discarded" "DURUM.md plan/ledger.md "; }
begin S03 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" && { run_sync "$L"
  expect_ok S03 "the ledger's stamp alone (a valid new token)" "plan/ledger.md "; }
begin S04 base && fx setline "$L/DURUM.md" "$DPRE" 0 "$(DLINE '20 Ekim 2026, 09:57')" && { run_sync "$L"
  expect_ok S04 "DURUM.md's stamp alone, accepted per file (the approach's decision)" "DURUM.md "; }
begin S05 base && fx setline "$L/DURUM.md" "$DPRE" 0 "$(DLINE '5 Ağustos 2026, 14:30')" && { run_sync "$L" "" "" LC_ALL=C
  expect_ok S05 "DURUM.md's stamp with a non-ASCII month and a one-digit day, under LC_ALL=C" "DURUM.md "; }
begin S06 base && fx render "$L" && fx edit "$L/.claude/hooks/owned_ids.txt" $'ID-1\n' $'ID-1\nID-2\n' && { run_sync "$L"
  expect_ok S06 "a render together with an owned_ids.txt change whose IDs are all on main" "DURUM.md plan/ledger.md "; }
begin S07 base main && fx render "$L" && fx two_stamps && { run_sync "$L"
  expect_ok S07 "HEAD already at origin/main, with a render: discarded, OK" "DURUM.md plan/ledger.md "; }
begin S08 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" && { run_sync "$L" "$L/plan" ../tools/sync_worktree.sh
  expect_ok S08 "run from a subdirectory of its own checkout (its toplevel is the script's checkout)" "plan/ledger.md "; }
begin S09 base && fx render "$L" && fx ln -s "$L" "$T/link-S09" && { run_sync "$L" "$T/link-S09" tools/sync_worktree.sh
  expect_ok S09 "its own checkout reached through a symlinked working directory (both sides resolved)" "DURUM.md plan/ledger.md "; }
begin S10 base && fx edit "$L/.claude/hooks/owned_ids.txt" $'ID-1\n' $'ID-1\nID-2\n' && { run_sync "$L"
  expect_ok S10 "owned_ids.txt alone, every ID on main (the existing rule)" ""; }
begin S12 rerender && fx render "$L" && fx two_stamps && { run_sync "$L"
  expect_ok S12 "a render while main has re-rendered the same views (as in reality): discarded, then fast-forwarded" "DURUM.md plan/ledger.md "; }
# S11, the format gate's "filled but meaningless" example: a token in the strict format that no clock writes. Either
# outcome is safe (accepted with its SYNC DISCARDED line, which the log records as a departure; or refused untouched);
# an OK without the line, or any other state, is BAD.
begin S11 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2099-19-39T29:59Z)" && { mark; run_sync "$L"
  if [ "$RC" -eq 0 ]; then expect_ok S11 "a well-formed but meaningless token (2099-19-39T29:59Z): discarded and printed, or refused" "plan/ledger.md "
  else expect_refuse S11 "a well-formed but meaningless token (2099-19-39T29:59Z): discarded and printed, or refused"; fi; }
# S13: a file main adds is untracked here, so git itself refuses the fast-forward. Not a sync refusal: exit not 0, no
# SYNC OK, HEAD and the untracked file unchanged; the stamp may be lost (restored to HEAD) or kept, nothing else.
begin S13 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" && fx cp "$L/notes.txt" "$L/added.txt" && {
  h=$(git -C "$L" rev-parse HEAD); u=$(sha256sum < "$L/added.txt"); run_sync "$L"
  lg=$(git -C "$L" diff --name-only)
  if [ "$RC" -ne 0 ] && ! printf '%s\n' "$OUT" | grep -q '^SYNC OK' && [ "$(git -C "$L" rev-parse HEAD)" = "$h" ] \
     && [ "$(sha256sum < "$L/added.txt")" = "$u" ] && { [ -z "$lg" ] || [ "$lg" = plan/ledger.md ]; }
  then ok "S13 (not fast-forwarded) an untracked file that main adds: HEAD and the file unchanged, at most the stamp lost"
  else bad "S13 (not fast-forwarded) an untracked file that main adds" "exit $RC; changed [$lg]; $OUT"; fi; }

# ---------------------------------------------------------------- refused (planted non-renders)
begin R01 base && fx render "$L" && fx edit "$L/plan/ledger.md" "| Fixture summary. |" "| Fixture summary, edited by hand. |" && { mark; run_sync "$L"
  expect_refuse R01 "a hand edit elsewhere in the ledger (summary_tr) with a render"; }
begin R02 base && fx render "$L" && fx edit "$L/plan/ledger.md" $'<!-- generated:zoom -->\n' $'<!-- generated:zoom -->\nA hand line.\n' && { mark; run_sync "$L"
  expect_refuse R02 "a hand edit inside a generated block with a render"; }
begin R03 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "| Rendered | Written by hand. | 2026-10-20T06:57Z |" && { mark; run_sync "$L"
  expect_refuse R03 "the Rendered row: a valid new token and its text cell edited"; }
begin R04 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z) " && { mark; run_sync "$L"
  expect_refuse R04 "the Rendered row: a valid new token and a trailing space"; }
begin R05 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW garbage)" && { mark; run_sync "$L"
  expect_refuse R05 "the Rendered row: a malformed token (garbage)"; }
begin R06 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57:00Z)" && { mark; run_sync "$L"
  expect_refuse R06 "the Rendered row: a token outside the strict format (seconds)"; }
begin R07 base && fx setline "$L/DURUM.md" "$DPRE" 0 "$(DLINE '20 Ekim 2026, 09:57' | sed 's/(Türkiye saati)/(UTC)/')" && { mark; run_sync "$L"
  expect_refuse R07 "DURUM.md's update line: a valid new token and the rest of the line edited"; }
begin R08 base && fx setline "$L/DURUM.md" "$DPRE" 0 "$(DLINE bilinmiyor)" && { mark; run_sync "$L"
  expect_refuse R08 "DURUM.md's update line: the token 'bilinmiyor' (not the strict format)"; }
begin R08b base && fx setline "$L/DURUM.md" "$DPRE" 0 "$(DLINE '20 October 2026, 09:57')" && { mark; run_sync "$L"
  expect_refuse R08b "DURUM.md's update line: an English month"; }
begin R09 base && fx render "$L" && fx edit "$L/DURUM.md" $'Fixture summary.\n' $'Fixture summary, edited by hand.\n' && { mark; run_sync "$L"
  expect_refuse R09 "a hand edit in DURUM.md's 'Şu an' section with a render"; }
begin R10 base && fx render "$L" && { printf '%s\n' "$(LROW 2026-10-20T06:58Z)" >> "$L/plan/ledger.md"; mark; run_sync "$L"
  expect_refuse R10 "a second Rendered row added (two lines with the prefix on the working side)"; }
begin R11 double && fx setline "$L/plan/ledger.md" "$LPRE" 2 "$(LROW 2026-10-20T06:57Z)" && { mark; run_sync "$L"
  expect_refuse R11 "HEAD's ledger holds two lines with the prefix; only the second one's token changed"; }
begin R11b double && fx setline "$L/DURUM.md" "$DPRE" 2 "$(DLINE '20 Ekim 2026, 09:57')" && { mark; run_sync "$L"
  expect_refuse R11b "HEAD's DURUM.md holds two update lines; only the second one's token changed"; }
begin R12 base && fx render "$L" && fx edit "$L/plan/ledger.md" "$(getline "$L/plan/ledger.md" "$LPRE" 0)"$'\n' "" && { mark; run_sync "$L"
  expect_refuse R12 "the Rendered row removed (no line with the prefix on the working side)"; }
begin R13 base && fx rm "$L/DURUM.md" && { mark; run_sync "$L"
  expect_refuse R13 "DURUM.md deleted (nothing to compare on the working side)"; }
begin R14 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" && fx git -C "$L" add plan/ledger.md && { mark; run_sync "$L"
  expect_refuse R14 "a stamp-only change that is staged"; }
begin R15 base && fx edit "$L/plan/ledger.md" "| Fixture summary. |" "| Fixture summary, staged by hand. |" && fx git -C "$L" add plan/ledger.md \
  && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" && { mark; run_sync "$L"
  expect_refuse R15 "a staged hand edit with a stamp-only change on top in the working tree (MM)"; }
begin R16 base && fx render "$L" && { printf 'local\n' >> "$L/notes.txt"; mark; run_sync "$L"
  expect_refuse R16 "another tracked file changed, with a render"; }
begin R17 base && fx render "$L" && fx edit "$L/.claude/hooks/owned_ids.txt" $'ID-1\n' $'ID-1\nID-9\n' && { mark; run_sync "$L"
  expect_refuse R17 "a render with an owned_ids.txt ID that is only local: nothing discarded"; }
begin R18 base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" && fx edit "$L/DURUM.md" $'Fixture summary.\n' $'Edited.\n' && { mark; run_sync "$L"
  expect_refuse R18 "the ledger's stamp alone and a hand edit in DURUM.md: the ledger is not discarded either"; }
begin R18b base && fx setline "$L/DURUM.md" "$DPRE" 0 "$(DLINE '20 Ekim 2026, 09:57')" && fx edit "$L/plan/ledger.md" "| Fixture summary. |" "| Edited. |" && { mark; run_sync "$L"
  expect_refuse R18b "DURUM.md's stamp alone and a hand edit in the ledger: DURUM.md is not discarded either"; }
begin R19 base && { printf 'local commit\n' > "$L/local.txt"; fx git -C "$L" add local.txt && fx git -C "$L" commit -q -m local; } && fx render "$L" && { mark; run_sync "$L"
  expect_refuse R19 "HEAD diverged from origin/main (a local commit), with a render: nothing discarded"; }
begin R20 stale && fx render "$L" && { mark; run_sync "$L"
  expect_refuse R20 "a render where HEAD's committed views are stale (the generated block changes): refused, safe"; }
# R21: the comparison's helpers print nothing: all of them with exit 0 (R21-0) or exit 2 (R21-2); or only the text
# transformers fail (exit 2) while the comparers (cmp, diff, cat, wc, sha256sum, md5sum) work (R21-x, the shape the
# round-2 triage observed: two empty outputs compare equal). A real hand edit is planted with a valid new stamp, and
# main does not touch the views, so git's own fast-forward check cannot hide a fail-open step.
TX="sed awk gawk mawk grep egrep fgrep tr cut head tail sort uniq comm perl python3 python paste xargs"
CMPS="cmp diff cat wc sha256sum md5sum"
mkdir -p "$T/shim0" "$T/shim2" "$T/shimx"
for t in $TX $CMPS; do printf '#!/bin/sh\nexit 0\n' > "$T/shim0/$t"; printf '#!/bin/sh\nexit 2\n' > "$T/shim2/$t"; done
for t in $TX; do printf '#!/bin/sh\nexit 2\n' > "$T/shimx/$t"; done
chmod +x "$T"/shim0/* "$T"/shim2/* "$T"/shimx/*
for v in 0 2 x; do
  begin "R21-$v" base && fx setline "$L/plan/ledger.md" "$LPRE" 0 "$(LROW 2026-10-20T06:57Z)" \
    && fx edit "$L/plan/ledger.md" "| Fixture summary. |" "| Edited. |" && { mark; run_sync "$L" "" "" "PATH=$T/shim$v:$PATH"
    expect_safe "R21-$v" "text tools print nothing ($v), with a hand edit and a valid stamp: never accepted"; }
done
# R22: a foreign clone's sync, run with this tree as the working directory (the approach's (2)(i)).
B=$(live base main) || bad "R22 fixture: no foreign clone" ""
begin R22a base && fx render "$L" && { mark; hb=$(git -C "$B" rev-parse HEAD); run_sync "$L" "$L" "$B/tools/sync_worktree.sh"
  expect_refuse R22a "another clone's sync by absolute path, this tree with a render"
  [ "$(git -C "$B" rev-parse HEAD)" = "$hb" ] && [ -z "$(git -C "$B" status --porcelain)" ] && ok "R22a' the other clone untouched" || bad "R22a' the other clone untouched" ""; }
begin R22b base && { mark; run_sync "$L" "$L" "$(realpath --relative-to="$L" "$B/tools/sync_worktree.sh")"
  expect_refuse R22b "another clone's sync by relative path, this tree clean (a foreign script must not even fast-forward it)"; }
begin R22c base && fx ln -s "$B/tools/sync_worktree.sh" "$L/tools/foreign_sync.sh" && { mark; run_sync "$L" "$L" tools/foreign_sync.sh
  expect_refuse R22c "another clone's sync reached through a symlink inside this tree (the script's path resolved)"; }
begin R23 base && fx edit "$L/.claude/hooks/owned_ids.txt" $'ID-1\n' $'ID-1\nID-9\n' && { mark; run_sync "$L"
  expect_refuse R23 "owned_ids.txt alone with a local-only ID (the existing rule)"; }

echo "SYNC_WORKTREE_TEST $([ "$BADS" -eq 0 ] && echo PASS || echo FAIL) ($OKS/$((OKS+BADS)))"
[ "$BADS" -eq 0 ]
