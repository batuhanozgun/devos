#!/usr/bin/env python3
"""check_records.py: deterministic record checks (W-C00-12 tranche 1b-ii; carrier A-04).

Run from the repository root. Write-ahead and formats: plan/builder/w-c00-12/15_tranche_1b-ii_intent.md.

Tree checks (the working tree):
  chain      M-R4, M-R1   homes exist, files indexed, named files exist, no record outside a home
  views      M-R6, M-R15  generated blocks and DURUM.md equal a fresh render
  docstatus  M-R2         governing documents carry no status of their own; fact markers match their home
  decisions  R-R10        decision-record fields present (presence, not content)
  map        M-R19        every running file has a carrier row; carriers exist; no blank cell
  work       W-R1, W-R4, W-R9, R-R3, R-R5   acceptance, composition, staleness, verifier level, triage
Diff checks (--base ... --head, or --worktree):
  kinds      M-R5         Record changes lines for every changed record; the log is append-only
  impact     W-R7         impact class of the diff (prints the class; the verdict is required at stop)
  stamps     M-R14        typed times in changed lines
  claims     M-R16 a, b   evidence paths resolve (whole tree); added verdicts match their review branch
Helpers:
  all        the tree checks plus the diff checks on one range
  merged     the diff checks for every first-parent commit of main after the baseline, the verdict
             requirement for class-high merges and break-glass reverts (W-R7), and the patch: count (M-R5)
  answers    Batu's comments on issue #6 accounted for (M-R13)
  leak       derived service terms in staged and untracked content (A-07)

Output: PASS/FAIL/INFO lines, then RECORDS PASS (exit 0), RECORDS FAIL (exit 1) or RECORDS ERROR (exit 2).
"""
import argparse
import atexit
import difflib
import fnmatch
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timedelta, timezone
from pathlib import Path

import yaml

sys.dont_write_bytecode = True  # no __pycache__ in the tree (it would be an untracked file)
sys.path.insert(0, str(Path(__file__).resolve().parent))
import records as R  # noqa: E402

# The last main commit before tranche 1b-ii's branch. Commits after it are checked by `merged`.
# Moving it is a tools/** change, so it is class high (W-R7).
BASELINE = "f72b973"

POINTER = "see plan/ledger.md, Governing documents"
GOVERNING_FIXED = ["plan/Builder_Operating_Model.md", "plan/builder/REVIEW_PROMPT.md", "plan/builder/mechanisms.md",
                   "plan/builder/MEMORY_MAP.md", "plan/builder/heritage/FAILURE_PATTERNS.md", "plan/builder/roles/*",
                   "plan/builder/design/*", "plan/Ek_A_Rol_Sozlesmeleri.md", "plan/Ek_D_Dusunme_Protokolleri.md"]
LABELS = {"deterministic", "subagent", "session", "audit-environment"}
SESSION_LABELS = {"session", "audit-environment"}
ADD_KINDS = {"addition", "annotate"}
MOD_KINDS = {"correction", "supersession", "retirement", "annotate"}
KINDS = ADD_KINDS | MOD_KINDS
ISSUE_URL = "https://api.github.com/repos/batuhanozgun/devos/issues/6/comments?per_page=100"
BATU = "batuhanozgun"
PART_ITEMS = {"1a": "W-C00-12.1", "1b-i": "W-C00-12.2", "1b-ii": "W-C00-12.3", "1c": "W-C00-12.4", "1d": "W-C00-12.5"}

# never break-glass: the stop check (13 section 5 #4). tools/check_records.py stays eligible, as T-W9 (h) was
# pre-registered: with the base == M condition a revert restores exactly the reviewed M^1 version (critic #5)
BG_NEVER = {"tools/builder_check.sh"}
LOG_RE = re.compile(r"^plan/ledger/[^/]+-log\.md$")
VERDICT_PATH = "evidence/*/reviews/*.md"
VERDICT_RE = re.compile(r"Verdict:?\**\s*\**\s*(PASS-WITH-CONDITIONS|PASS|FAIL)")
SHA_RE = re.compile(r"(?<![0-9a-zA-Z])[0-9a-f]{7,40}(?![0-9a-zA-Z])")
TIME_RE = re.compile(r"(?<![\w:])(?:(\d{4}-\d{2}-\d{2})T)?(\d{2}):(\d{2})(?::(\d{2}))?Z(?![A-Za-z0-9])")
EVID_RE = re.compile(r"(?<![\w/.-])evidence/[A-Za-z0-9_./-]*[A-Za-z0-9_/-]")
RECORDER_LINE = re.compile(r"^(session|trig)_[A-Za-z0-9]+$")
RULE_ID_RE = re.compile(r"\b[MWRCH]-R\d+[a-z]?\b")
TR_MONTHS = ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım",
             "Aralık"]


class CheckError(Exception):
    pass


class Out:
    def __init__(self):
        self.fails, self.infos = [], []

    def fail(self, sub, msg):
        self.fails.append((sub, msg))

    def info(self, msg):
        self.infos.append(msg)


# ---------------------------------------------------------------- git helpers

_cache = {}


def git(*args, ok=False, raw=False):
    r = subprocess.run(["git", *args], capture_output=True)
    if r.returncode != 0:
        if ok:
            return None
        raise CheckError(f"git {' '.join(args)[:120]}: {r.stderr.decode(errors='replace').strip()[:200]}")
    return r.stdout if raw else r.stdout.decode("utf-8", "replace")


def resolve(rev):
    key = ("resolve", rev)
    if key not in _cache:
        out = git("rev-parse", "--verify", "-q", f"{rev}^{{commit}}", ok=True)
        _cache[key] = out.strip() if out else None
    return _cache[key]


def is_ancestor(a, b):
    key = ("anc", a, b)
    if key not in _cache:
        _cache[key] = subprocess.run(["git", "merge-base", "--is-ancestor", a, b], capture_output=True).returncode == 0
    return _cache[key]


def content(rev, path, raw=False):
    """File content at a revision, or in the working tree when rev is None; None when absent."""
    if rev is None:
        p = Path(path)
        if not p.is_file():
            return None
        return p.read_bytes() if raw else p.read_text(errors="replace")
    key = ("show", rev, path, raw)
    if key not in _cache:
        r = subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True)
        _cache[key] = None if r.returncode else (r.stdout if raw else r.stdout.decode("utf-8", "replace"))
    return _cache[key]


def changed(base, head):
    """[(status, path)] for base..head; head None means the working tree, including untracked files."""
    key = ("changed", base, head)
    if key in _cache:
        return _cache[key]
    args = ["diff", "--name-status", "--no-renames", base] + ([head] if head else [])
    out = []
    for line in git(*args).splitlines():
        st, p = line.split("\t", 1)
        out.append((st[0], p))
    if head is None:
        for p in git("ls-files", "--others", "--exclude-standard").splitlines():
            out.append(("A", p))
    _cache[key] = out
    return out


def line_changes(old, new):
    """(removed lines, [(1-based line number in new, text)] added lines)."""
    a = (old or "").splitlines()
    b = (new or "").splitlines()
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    removed, added = [], []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag in ("replace", "delete"):
            removed += a[i1:i2]
        if tag in ("replace", "insert"):
            added += [(j + 1, b[j]) for j in range(j1, j2)]
    return removed, added


def front(text):
    if text is None:
        return None, None
    try:
        return R.split_front(text, "?")
    except (R.RecordError, yaml.YAMLError):
        return None, None


def tracked_files(rev, prefix):
    if rev is None:
        base = Path(prefix)
        return sorted(str(p) for p in base.rglob("*") if p.is_file()) if base.exists() else []
    out = git("ls-tree", "-r", "--name-only", rev, "--", prefix, ok=True) or ""
    return out.split()


def blame_times(rev, path):
    args = ["blame", "--line-porcelain"] + ([rev] if rev else []) + ["--", path]
    out = git(*args, ok=True)
    now = datetime.now(timezone.utc)
    if out is None:
        return None
    times, cur = [], None
    for line in out.splitlines():
        if line.startswith("author-time "):
            cur = int(line.split()[1])
        elif line.startswith("\t"):
            times.append(datetime.fromtimestamp(cur, timezone.utc) if cur else now)
    return times


def sessions_in(base, head):
    msgs = git("log", "--format=%B", f"{base}..{head}" if head else base, ok=True) or ""
    return set(re.findall(r"Claude-Session:\s*\S*?(session_[A-Za-z0-9]+)", msgs))


# ---------------------------------------------------------------- paths and classes (W-R7)

def exec_part(p):
    return p.startswith((".claude/", "tools/")) or p in (".gitattributes", "CLAUDE.md") or \
        (p.startswith("plan/builder/") and p.endswith(".py"))


def governing_path(p):
    return any(fnmatch.fnmatch(p, g) for g in GOVERNING_FIXED)


def high_path(p):
    if p == ".claude/hooks/owned_ids.txt":
        return False  # judged by its diff in impact()
    return exec_part(p) or p.startswith(".github/workflows/") or governing_path(p)


def target_class(targets):
    """Class of an item from its `targets:` list (03 section 2; R-W12-2 m-2): empty is high."""
    if not targets:
        return "high"
    for t in targets:
        t = str(t)
        if high_path(t) or any(fnmatch.fnmatch(g, t) or fnmatch.fnmatch(t, g) for g in GOVERNING_FIXED) or \
                t.startswith((".claude", "tools", ".github/workflows")) or t in ("plan/ledger.md",):
            return "high"
    return "normal"


def deps_norm(meta):
    out = []
    for d in R.deps(meta or {}):
        out.append((str(d["id"]), str(d["on"]), str(d["reason"])))
    return out


def work_metas(rev):
    key = ("metas", rev)
    if key not in _cache:
        metas = {}
        for p in tracked_files(rev, "plan/work"):
            if p.endswith(".md"):
                m, _ = front(content(rev, p))
                if m:
                    metas[p] = m
        _cache[key] = metas
    return _cache[key]


def edge_targets(rev):
    out = set()
    for m in work_metas(rev).values():
        if m.get("hold_until"):
            out.add(str(m["hold_until"]))
        for d in deps_norm(m):
            out.add(d[0])
    return out


def finished_targets(rev):
    return {d[0] for m in work_metas(rev).values() for d in deps_norm(m) if d[1] == "finished"}


def ledger_rows(text):
    try:
        return R.state_rows(text) if text else {}
    except IndexError:
        return {}


def verdict_ok_text(text):
    if not text:
        return False
    m = VERDICT_RE.search(text)
    if not m or m.group(1) == "FAIL":
        return False
    return any(resolve(s) for s in set(SHA_RE.findall(text)))


def break_glass_target(base, head):
    files = changed(base, head)
    paths = {p for _, p in files}
    if not paths or not all(exec_part(p) for p in paths):
        return None
    merges = (git("rev-list", "--first-parent", "--merges", "-n", "300", base, ok=True) or "").split()
    for m in merges:
        mp = f"{m}^1"
        part = {p for _, p in changed(mp, m) if exec_part(p)}
        if not part or part & BG_NEVER or paths != part:
            continue
        # exact inverse: the base still holds M's result, and the head restores M^1 (no rollback past later merges)
        if all(content(base, p, raw=True) == content(m, p, raw=True) and
               content(head, p, raw=True) == content(mp, p, raw=True) for p in part):
            return m
    return None


def impact(base, head, allow_bg=True):
    """(class, reasons, break-glass target merge or None)."""
    key = ("impact", base, head, allow_bg)
    if key in _cache:
        return _cache[key]
    bg = break_glass_target(base, head) if allow_bg else None
    if bg:
        _cache[key] = ("normal", [f"exact inverse of the executable-carrier part of merge {bg[:7]} (break-glass)"], bg)
        return _cache[key]
    reasons = []
    hmetas = None
    for st, p in changed(base, head):
        if p == ".claude/hooks/owned_ids.txt":
            rem, add = line_changes(content(base, p), content(head, p))
            if rem or any(not RECORDER_LINE.match(t.strip()) for _, t in add):
                reasons.append(f"{p}: not only appended recorder lines")
            continue
        if high_path(p):
            reasons.append(f"path {p}")
            continue
        if p == "plan/ledger.md":
            b, h = ledger_rows(content(base, p)), ledger_rows(content(head, p))
            for k in sorted(set(b) | set(h)):
                if (k == "Stage" or k.startswith("Governing documents")) and \
                        (b.get(k, ("", ""))[0] != h.get(k, ("", ""))[0]):
                    reasons.append(f"plan/ledger.md row '{k}' changed")
            continue
        if not (p.startswith("plan/work/") and p.endswith(".md")):
            continue
        if st == "A":
            continue
        if st == "D":
            reasons.append(f"{p}: item file deleted")
            continue
        bt, ht = content(base, p), content(head, p)
        bm, bb = front(bt)
        hm, hb = front(ht)
        if bm is None or hm is None:
            reasons.append(f"{p}: front matter unreadable")
            continue
        iid = bm.get("id")
        bd, hd = deps_norm(bm), deps_norm(hm)
        if any(d not in hd for d in bd):
            reasons.append(f"{p}: a depends_on entry modified or deleted")
        if any(d not in bd and d[1] == "finished" for d in hd):
            reasons.append(f"{p}: an edge with on: finished added")
        bw, hw = [str(x) for x in bm.get("waits_for") or []], [str(x) for x in hm.get("waits_for") or []]
        if any(w not in hw for w in bw):
            reasons.append(f"{p}: a waits_for entry modified or deleted")
        if bm.get("hold_until") != hm.get("hold_until"):
            reasons.append(f"{p}: hold_until changed")
        for f in ("parent", "kind"):  # the tree decides W-R4's children and the stage hold (self-check after R-W12-5)
            if bm.get(f) != hm.get(f):
                reasons.append(f"{p}: {f} {bm.get(f)} -> {hm.get(f)}")
        if bm.get("admission") != hm.get("admission"):
            carried = bool(git("log", "--format=%H", "-G", "waits_for", base, "--", p, ok=True) or "") or bool(bw)
            if not (bm.get("admission") == "candidate" and hm.get("admission") in ("admitted", "declined")
                    and not carried and not hw):
                reasons.append(f"{p}: admission {bm.get('admission')} -> {hm.get('admission')}")
        if hm.get("execution") == "cancelled" and bm.get("execution") != "cancelled" and \
                bm.get("admission") == "admitted":
            reasons.append(f"{p}: an admitted item cancelled")
        ba, ha = R.ACC_RE.search(bb or ""), R.ACC_RE.search(hb or "")
        if ba and (not ha or ha.group(1) != ba.group(1)):
            reasons.append(f"{p}: an existing acceptance block changed")
        if hmetas is None:
            hmetas = edge_targets(head)
        if bm.get("execution") != hm.get("execution") and iid in finished_targets(head):
            reasons.append(f"{p}: execution of the target of an on: finished edge changed")
        if (bm.get("acceptance"), bm.get("accepted_by"), bm.get("composition_by")) != \
                (hm.get("acceptance"), hm.get("accepted_by"), hm.get("composition_by")):
            if iid in hmetas:
                why = exemption_problems(base, head, p, hm)
                if why:
                    reasons.append(f"{p}: acceptance of an edge or hold target changed without its own session "
                                   f"verdict (W-R7, N-049): {'; '.join(why)}")
    _cache[key] = ("high" if reasons else "normal", reasons, None)
    return _cache[key]


def exemption_problems(base, head, item_path, hm):
    """W-R7 (ii) (R-W12-4 C-1, R-W12-5 C-1): the acceptance change of an edge or hold target is class normal only
    when, at the PR head, the item is accepted by a session verdict, the work check of that item passes there
    (item_work_problems: W-R1 binding, W-R4 composition and closed children, R-R3, W-R9), and every verdict the
    item names is bound by M-R16 (b) to a review session that made no commit of the PR. Empty list: exempt."""
    out = []
    if hm.get("acceptance") != "accepted":
        return [f"acceptance '{hm.get('acceptance')}' is not accepted, so no verdict can exempt it"]
    if hm.get("acceptance_label") not in SESSION_LABELS:
        out.append(f"acceptance_label '{hm.get('acceptance_label')}' is not a session label")
    named = [("accepted_by", str(hm.get("accepted_by") or ""))]
    if hm.get("composition_by"):
        named.append(("composition_by", str(hm.get("composition_by"))))
    for field, vf in named:
        if not fnmatch.fnmatch(vf, VERDICT_PATH):
            out.append(f"{field} {vf or '(empty)'} is not a verdict under evidence/*/reviews/")
        elif not verdict_bound_at(vf, base, head):
            out.append(f"{field} {vf} is not bound to its review branch by an owned reviewer session outside "
                       "this PR (M-R16 b)")
    try:
        iid = str(hm.get("id"))
        out += [f"work check at the PR head: {x}" for x in work_problems_at(iid, head)]
        items = records_at(head)[0]
        for k in sorted(R.children(items, iid), key=lambda k: R.sortkey(k["id"])):  # R-W12-6 B-1, N-053 g
            out += [f"work check of child {k['id']} at the PR head: {x}" for x in work_problems_at(k["id"], head)]
    except (R.RecordError, yaml.YAMLError, subprocess.CalledProcessError, OSError) as e:
        out.append(f"work check at the PR head could not run: {e}")
    return out


def verdict_bound_at(vf, base, head):
    """M-R16 (b) for a verdict at the PR head: claims (b) on the range when the range adds or changes it, and the
    commit that added it otherwise. A verdict only in the working tree is never bound."""
    if any(p == vf for _, p in changed(base, head)):
        if head is None:
            return False
        o = Out()
        check_claims_diff(base, head, o, only=vf)
        return not [f for f in o.fails if f[0] == "claims"]  # a late Written: stamp (stamps) does not unbind
    if not verdict_bound(vf, head or "HEAD"):
        return False
    rid = Path(vf).stem
    ref = next((r for r in (f"refs/remotes/origin/claude/review-{rid}", f"refs/heads/claude/review-{rid}")
                if resolve(r)), None)
    rc = review_commit_for(ref, vf, content(head or "HEAD", vf, raw=True)) if ref else None
    msg = (git("log", "-1", "--format=%B", rc, ok=True) or "") if rc else ""
    ss = re.findall(r"Claude-Session:\s*\S*?(session_[A-Za-z0-9]+)", msg)
    return bool(ss) and ss[-1] not in sessions_in(base, head or "HEAD")  # R-W12-5 m-2


def verdict_files(rev):
    return [p for p in tracked_files(rev, "evidence") if fnmatch.fnmatch(p, VERDICT_PATH)]


def verdict_bound(vf, tree_rev):
    """The commit that added vf passed claims (b) for it (critic of 1b-ii #2): only such verdicts can cover."""
    key = ("bound", vf, tree_rev)
    if key not in _cache:
        add = (git("log", "--diff-filter=A", "--format=%H", "-1", tree_rev, "--", vf, ok=True) or "").strip()
        o = Out()
        if add:
            ps = (git("rev-list", "--parents", "-n1", add) or "").split()
            check_claims_diff(ps[1] if len(ps) > 1 else add, add, o, only=vf, owned_rev=tree_rev)
        _cache[key] = bool(add) and not [f for f in o.fails if f[0] == "claims"]  # stamps do not unbind (1c Critic 1)
    return _cache[key]


def covered(m2, tree_rev, strict=None):
    """A verdict on tree_rev that covers the PR head m2 (15 section 2): PASS or PASS-WITH-CONDITIONS, bound by
    claims (b), naming a commit X that is m2 or an ancestor of it, with X..m2 class normal without the break-glass
    exception. strict: a set of commits; then X must be one of them (a break-glass revert's own head or merge)."""
    key = ("covered", m2, tree_rev, tuple(sorted(strict)) if strict else None)
    if key in _cache:
        return _cache[key]
    found = None
    for vf in verdict_files(tree_rev):
        t = content(tree_rev, vf)
        m = VERDICT_RE.search(t or "")
        if not m or m.group(1) == "FAIL":
            continue
        for s in sorted(set(SHA_RE.findall(t))):
            x = resolve(s)
            if not x or not (x == m2 or is_ancestor(x, m2)):
                continue
            if strict is not None and x not in strict:
                continue
            if (x == m2 or impact(x, m2, allow_bg=False)[0] == "normal") and verdict_bound(vf, tree_rev):
                found = (vf, x)
                break
        if found:
            break
    _cache[key] = found
    return found


# ---------------------------------------------------------------- kinds (M-R5)

def is_record(p):
    return p == "plan/ledger.md" or p.startswith(("plan/work/", "plan/decisions/", "plan/ledger/", "evidence/"))


def mask_ledger(t):
    if t is None:
        return None
    t = re.sub(r"(<!-- generated:[\w-]+ -->\n).*?(\n<!-- /generated -->)", r"\1(generated)\2", t, flags=re.S)
    return "\n".join(line for line in t.splitlines() if not line.startswith("| Rendered |"))


def record_segments(lines):
    out = []
    for line in lines:
        if line.startswith("- **Record changes:**"):
            for seg in line[len("- **Record changes:**"):].split(";"):
                if seg.strip():
                    out.append(seg.strip())
    return out


def parse_segment(seg):
    fields = [f.strip() for f in seg.split("·")]
    kind = fields[1].split()[0] if len(fields) > 1 and fields[1].split() else ""
    return fields[0], kind, fields[2:]


def names(target, path, allow_glob=True):
    t = target.replace("`", "")
    if path in t:
        return True
    for tok in re.split(r"[\s,()]+", t):
        # a glob names records only for additions, and only under a named directory (critic of 1b-ii #10)
        if allow_glob and tok and ("*" in tok or "?" in tok) and "/" in tok.split("*")[0] and \
                fnmatch.fnmatch(path, tok):
            return True
    stem = Path(path).stem
    return bool(re.search(r"(?<![\w./-])" + re.escape(stem) + r"(?![\w-]|\.\d)", t)) and len(stem) >= 4


def added_log_lines(base, head):
    out = []
    for st, p in changed(base, head):
        if LOG_RE.match(p) and st != "D":
            _, add = line_changes(content(base, p) if st != "A" else None, content(head, p))
            out += [t for _, t in add]
    return out


def check_kinds(base, head, out):
    files = changed(base, head)
    for st, p in files:
        if LOG_RE.match(p) and st != "A":
            rem, _ = line_changes(content(base, p), content(head, p) if st != "D" else None)
            if rem:
                out.fail("kinds", f"{p}: {len(rem)} existing log line(s) modified or deleted; the log is append-only "
                                  f"(M-R5); first: {rem[0][:80]}")
    segs = [parse_segment(s) for s in record_segments(added_log_lines(base, head))]
    for target, kind, rest in segs:
        if kind not in KINDS:
            out.fail("kinds", f"Record changes line '{target[:60]}' has unknown kind '{kind}'")
        if kind == "correction" and not [r for r in rest if r and not r.startswith(("supersedes", "patch:"))]:
            out.fail("kinds", f"correction of '{target[:60]}' gives no reason (M-R5)")
    for st, p in files:
        if not is_record(p) or LOG_RE.match(p):
            continue
        old = content(base, p) if st != "A" else None
        new = content(head, p) if st != "D" else None
        if p == "plan/ledger.md":
            old, new = mask_ledger(old), mask_ledger(new)
        rem, add = line_changes(old, new)
        if not rem and not add:
            continue
        need = MOD_KINDS if rem else ADD_KINDS
        if not any(kind in need and names(target, p, allow_glob=not rem) for target, kind, _ in segs):
            what = "modified or deleted lines" if rem else "appended lines"
            out.fail("kinds", f"{p}: {what} without a Record changes line of kind {'|'.join(sorted(need))} naming it")


def patch_counts(main_ref):
    frs = [p for p in tracked_files(main_ref, "plan/decisions") if re.search(r"/FR-\d+\.md$", p)]
    since = None
    for p in frs:
        c = (git("log", "--diff-filter=A", "--format=%H", "-1", main_ref, "--", p, ok=True) or "").strip()
        if c and (since is None or is_ancestor(since, c)):
            since = c
    counts = {}
    if since:
        lines = added_log_lines(since, main_ref)
    else:
        lines = []
        for p in tracked_files(main_ref, "plan/ledger"):
            if LOG_RE.match(p):
                lines += (content(main_ref, p) or "").splitlines()
    for line in lines:
        for m in re.finditer(r"patch:([A-Z]-?[A-Z]?-?R?\d+[a-z]?|[A-Z]+-[A-Z]*\d+)", line):
            counts[m.group(1)] = counts.get(m.group(1), 0) + 1
    return counts, since


# ---------------------------------------------------------------- stamps (M-R14)

def parse_time(m, ct):
    d = m.group(1) or ct.strftime("%Y-%m-%d")
    try:
        return datetime.strptime(f"{d}T{m.group(2)}:{m.group(3)}:{m.group(4) or '00'}",
                                 "%Y-%m-%dT%H:%M:%S").replace(tzinfo=timezone.utc)
    except ValueError:
        return None


def is_sched(line, m):
    return line[max(0, m.start() - 6):m.start()] == "sched:"


def quoted_problems(text, ct, skip=()):
    out = []
    for m in TIME_RE.finditer(text):
        if is_sched(text, m) or m.start() in skip:
            continue
        t = parse_time(m, ct)
        if t is None:
            out.append(f"unreadable time '{m.group(0)}'")
        elif t > ct:
            out.append(f"time '{m.group(0)}' is later than the commit time {ct:%Y-%m-%dT%H:%M:%SZ} and not marked "
                       "sched:")
    return out


def stamp_window(t, ct):
    return t <= ct and t + timedelta(seconds=60) >= ct - timedelta(minutes=15)


def resets_of(rows):
    m = re.search(r"resets (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", rows.get("Usage", ("", ""))[0])
    return datetime.strptime(m.group(1), "%Y-%m-%dT%H:%MZ").replace(tzinfo=timezone.utc) if m else None


def ledger_line_problems(line, ct, resets):
    cells = [c.strip() for c in re.split(r"(?<!\\)\|", line.strip())[1:-1]] if line.startswith("| ") else []
    if len(cells) != 3 or cells[0] in ("Item", "") or cells[0].startswith("---"):
        return quoted_problems(line, ct)
    name, state, asof = cells
    out = []
    am = re.fullmatch(r"(\d{4}-\d\d-\d\dT\d\d:\d\dZ)", asof)
    if not am:
        out.append(f"row '{name}': As-of cell '{asof[:30]}' is not a stamp")
    else:
        t = datetime.strptime(am.group(1), "%Y-%m-%dT%H:%MZ").replace(tzinfo=timezone.utc)
        if not stamp_window(t, ct):
            out.append(f"row '{name}': As-of {asof} is not within 15 minutes before the commit time "
                       f"{ct:%Y-%m-%dT%H:%M:%SZ}")
    skip = set()
    sched = []
    if name == "Run lock":
        sched = [(m, "lease") for m in re.finditer(r"Expires (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", state)]
    elif name == "Usage":
        sched = [(m, "resets") for m in re.finditer(r"resets (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", state)]
    elif name == "Armed wakes":
        sched = [(m, m.group(1)) for m in re.finditer(r"([A-Za-z][\w-]*) (\d{4}-\d\d-\d\dT\d\d:\d\dZ) [\w-]+", state)]
    for m, kind in sched:
        g = m.group(m.lastindex)
        skip.add(m.start(m.lastindex))
        t = datetime.strptime(g, "%Y-%m-%dT%H:%MZ").replace(tzinfo=timezone.utc)
        if t <= ct:
            out.append(f"row '{name}': scheduled time {g} is not in the future at commit time")
        elif kind == "lease" and t - ct > timedelta(hours=3, minutes=15):
            out.append(f"row '{name}': lease expiry {g} is more than 3h15m ahead")
        elif kind == "resets" and t - ct > timedelta(days=7):
            out.append(f"row '{name}': reset {g} is more than 7 days ahead")
        elif kind == "S5":
            if resets is None or t != resets + timedelta(minutes=15):
                out.append(f"row '{name}': S5 wake {g} is not the recorded resets time plus 15 minutes")
        elif kind not in ("lease", "resets") and t - ct > timedelta(hours=25):
            out.append(f"row '{name}': wake {g} of type {kind} is more than 25 hours ahead")
    if name == "Armed wakes" and state not in ("none", "") and not sched:
        out.append(f"row '{name}': no entry of the form '<type> <time> <owned ID>'")
    out += quoted_problems(state, ct, skip)
    return out


def durum_update_time(line):
    m = re.search(r"\*\*Son güncelleme:\*\* (\d+) (\w+) (\d{4}), (\d\d):(\d\d)", line)
    if not m or m.group(2) not in TR_MONTHS:
        return None
    t = datetime(int(m.group(3)), TR_MONTHS.index(m.group(2)) + 1, int(m.group(1)), int(m.group(4)),
                 int(m.group(5)), tzinfo=R.TR)
    return t.astimezone(timezone.utc)


def line_problems(path, line, ct, resets, added_file=False):
    """M-R14 for one changed line (the function T-M7c (a) calls directly)."""
    if path == "plan/ledger.md":
        return ledger_line_problems(line, ct, resets)
    if path == "DURUM.md":
        if line.startswith("**Son güncelleme:**"):
            t = durum_update_time(line)
            if t is None:
                return ["DURUM.md update line unreadable"]
            return [] if stamp_window(t, ct) else [f"DURUM.md update time {t:%Y-%m-%dT%H:%MZ} is not within 15 "
                                                   f"minutes before the commit time {ct:%Y-%m-%dT%H:%M:%SZ}"]
        if line.startswith("**Kurulu uyandırmalar:**"):
            return []  # generated from the Armed wakes row, which is checked as a scheduled field
        return quoted_problems(line, ct)
    if LOG_RE.match(path):
        h = re.match(r"### L-\d+ · (\d{4}-\d{2}-\d{2})", line)
        if h and h.group(1) > ct.strftime("%Y-%m-%d"):
            return [f"log header date {h.group(1)} is later than the commit's UTC date"]
        return quoted_problems(line, ct)
    if added_file and "Written:" in line:
        return quoted_problems(line, ct)
    return []


def check_stamps(base, head, out):
    hl = content(head, "plan/ledger.md")
    resets = resets_of(ledger_rows(hl))
    for st, p in changed(base, head):
        if st == "D":
            continue
        is_added = st == "A" and p.startswith(("plan/", "evidence/")) and p.endswith(".md")
        if not (p in ("plan/ledger.md", "DURUM.md") or LOG_RE.match(p) or is_added):
            continue
        new = content(head, p)
        _, added = line_changes(content(base, p) if st != "A" else None, new)
        times = blame_times(head, p)
        now = datetime.now(timezone.utc)
        for ln, text in added:
            if is_added and not (LOG_RE.match(p) or p in ("plan/ledger.md", "DURUM.md")) and "Written:" not in text:
                continue
            ct = times[ln - 1] if times and ln - 1 < len(times) else now
            for prob in line_problems(p, text, ct, resets, added_file=is_added):
                out.fail("stamps", f"{p}:{ln}: {prob}")


# ---------------------------------------------------------------- claims (M-R16 a, b)

def leak_terms():
    """The leak check's derived terms (same derivation as tools/check_service_names.sh; the stop check compares
    the two term counts, so a drift between them fails)."""
    if "leak" in _cache:
        return _cache["leak"]
    raw = content("3cd686a", ".claude/settings.json")
    if raw is None:
        raise CheckError("cannot derive the leak check's terms (3cd686a not in this clone)")
    d = json.loads(raw)["permissions"]["deny"]
    terms = set()
    for n in d:
        n = n.replace("mcp__", "")
        for part in n.replace("_-_", "_").split("_"):
            if len(part) >= 4 and part.lower() not in {"google", "claude", "career", "intelligence", "network",
                                                       "analytics", "drive", "calendar", "docs", "flow"}:
                terms.add(part)
        terms.add(n.replace("_", " "))
    # longest first, so that a phrase is matched whole rather than by a shorter term inside it
    pat = re.compile(r"\b(" + "|".join(re.escape(t) for t in sorted(terms, key=lambda x: (-len(x), x))) + r")\b", re.I)
    _cache["leak"] = (pat, len(terms))
    return _cache["leak"]


def redacted_match(branch_bytes, copy_bytes):
    pat, _ = leak_terms()
    b = branch_bytes.decode("utf-8", "replace").split("\n")
    c = copy_bytes.decode("utf-8", "replace").split("\n")
    if len(b) != len(c):
        return False
    for bl, cl in zip(b, c):
        if bl == cl:
            continue
        spans = [m.span() for m in pat.finditer(bl)]
        if not spans:
            return False
        rx, pos = "", 0
        for s, e in spans:
            rx += re.escape(bl[pos:s]) + "(.+?)"
            pos = e
        rx += re.escape(bl[pos:])
        m = re.fullmatch(rx, cl)
        if not m or any(pat.search(g) for g in m.groups()):
            return False
    return True


def check_claims_tree(out):
    files = [p for p in tracked_files(None, "plan/ledger") if LOG_RE.match(p)] + \
        [p for p in tracked_files(None, "plan/work") if p.endswith(".md")] + \
        [p for p in tracked_files(None, "plan/decisions") if p.endswith(".md")]
    for f in files:
        for n, line in enumerate(Path(f).read_text(errors="replace").splitlines(), 1):
            for m in EVID_RE.finditer(line):
                p = m.group(0)
                if not Path(p).exists():
                    out.fail("claims", f"{f}:{n}: names {p}, which does not exist (M-R16 a)")


def review_commit_for(ref, p, cb):
    """The newest commit of the review branch whose blob of p equals the copy cb, or matches it up to pattern
    substitutions (N-053 e: a later push to the review branch does not unbind an earlier copy)."""
    for c in (git("log", "--format=%H", ref, "--", p, ok=True) or "").split():
        bb = content(c, p, raw=True)
        if bb is not None and (bb == cb or redacted_match(bb, cb)):
            return c
    return None


def stamp_after_commit(text, c):
    """N-053 f: the verdict's own Written: stamp must not be later than its review-branch commit (M-R14)."""
    line = next((l for l in text.splitlines() if "Written:" in l), None)
    ct = datetime.fromtimestamp(int((git("log", "-1", "--format=%at", c, ok=True) or "0").strip() or 0), timezone.utc)
    return quoted_problems(line, ct) if line else []


def check_claims_diff(base, head, out, only=None, owned_rev=None):
    prod = sessions_in(base, head or "HEAD")
    # owned before the range: a recorder line the same change appends cannot vouch for its own verdict (self-check
    # after R-W12-5; the recorder line reaches main in its own record PR first, R-W12-4 m-8). owned_rev: the tree
    # being checked, for a verdict judged after the change that added it (verdict_bound; N-053 e)
    owned = set((content(owned_rev or base, ".claude/hooks/owned_ids.txt") or "").split())
    hc = resolve(head or "HEAD")
    for st, p in changed(base, head):
        if st not in "AM" or not fnmatch.fnmatch(p, VERDICT_PATH) or (only and p != only):
            continue
        rid = Path(p).stem
        ref = next((r for r in (f"refs/remotes/origin/claude/review-{rid}", f"refs/heads/claude/review-{rid}")
                    if resolve(r)), None)
        if ref is None:
            out.fail("claims", f"{p}: no review branch claude/review-{rid} to bind the verdict (M-R16 b)")
            continue
        cb = content(head, p, raw=True)
        if not (git("log", "-1", "--format=%H", ref, "--", p, ok=True) or "").strip():
            out.fail("claims", f"{p}: not on its review branch {ref.split('refs/')[-1]}")
            continue
        rc = review_commit_for(ref, p, cb)
        if rc is None:
            out.fail("claims", f"{p}: differs from every review-branch version beyond pattern substitutions (M-R16 b)")
            continue
        for prob in stamp_after_commit(cb.decode("utf-8", "replace"), rc):
            out.fail("stamps", f"{p}: Written: stamp later than its review-branch commit {rc[:7]}: {prob} (M-R14, "
                               "N-053 f)")
        shas = [resolve(s) for s in set(SHA_RE.findall(cb.decode("utf-8", "replace")))]
        if not any(x and (x == hc or is_ancestor(x, hc)) for x in shas):
            out.fail("claims", f"{p}: names no reviewed commit that is an ancestor of the head (M-R16 b)")
        msg = git("log", "-1", "--format=%B", rc, ok=True) or ""
        ss = re.findall(r"Claude-Session:\s*\S*?(session_[A-Za-z0-9]+)", msg)
        if not ss:
            out.fail("claims", f"{p}: its review-branch commit carries no Claude-Session trailer (M-R16 b)")
        elif ss[-1] in prod:
            out.fail("claims", f"{p}: committed on its review branch by {ss[-1]}, a session of this change (D-07)")
        elif ss[-1] not in owned:
            out.fail("claims", f"{p}: its review-branch session {ss[-1]} is not an owned session before this change "
                               "(recorder; M-R16 b)")


# ---------------------------------------------------------------- docstatus (M-R2)

def governing_rows(text):
    out = {}
    for k, (v, _) in ledger_rows(text).items():
        m = re.match(r"Governing documents: `([^`]+)`", k)
        if m:
            sm = re.search(r"status:\s*([^;]+)", v)
            out[m.group(1)] = (sm.group(1).strip() if sm else "", v)
    return out


def header_of(text):
    lines = text.splitlines()
    i = next((n for n, l in enumerate(lines) if l.startswith("# ")), None)
    if i is None:
        return ""
    para = []
    for line in lines[i + 1:]:
        if not line.strip():
            if para:
                break
            continue
        para.append(line)
    return " ".join(para)


def check_docstatus(out):
    lt = content(None, "plan/ledger.md") or ""
    rows = governing_rows(lt)
    docs = set()
    for pat, (status, _) in rows.items():
        if not status.lower().startswith("candidate"):
            docs.update(p for p in tracked_files(None, ".") if fnmatch.fnmatch(p.lstrip("./"), pat)) \
                if any(ch in pat for ch in "*?") else docs.add(pat)
    for g in GOVERNING_FIXED:
        if any(ch in g for ch in "*?"):
            d = g.split("*")[0]
            docs.update(p for p in tracked_files(None, d.rstrip("/")) if fnmatch.fnmatch(p, g))
        elif Path(g).exists():
            docs.add(g)
    for d in sorted(docs):
        t = content(None, d)
        if t is None:
            out.fail("docstatus", f"governing document {d} does not exist")
            continue
        h = header_of(t)
        m = re.search(r"\*\*Status:\*\*\s*(.*?)(?=\s\*\*[A-Z][\w -]*:\*\*|$)", h)
        if m:
            val = m.group(1).replace("`", "").strip().rstrip(".")
            if val != POINTER:
                out.fail("docstatus", f"{d}: header Status '{val[:60]}' is not the pointer '{POINTER}' (M-R2)")
        elif re.search(r"\b(binding|candidate|proposal|accepted|draft)\b", h, re.I):
            out.fail("docstatus", f"{d}: header carries a status word of its own (M-R2)")
    for f in tracked_files(None, "."):
        if not f.endswith(".md"):
            continue
        for n, line in enumerate((content(None, f) or "").splitlines(), 1):
            for m in re.finditer(r"<!--fact:([^>]+?)-->(.*?)<!--/fact-->", line):
                if line[:m.start()].count("`") % 2 == 1:
                    continue  # inside inline code: an example, not a marker
                key, val = m.group(1).strip(), m.group(2).strip()
                km = re.fullmatch(r"govdoc-status:(.+)", key)
                if not km:
                    out.fail("docstatus", f"{f}:{n}: fact marker with unknown key '{key}'")
                elif km.group(1) not in rows:
                    out.fail("docstatus", f"{f}:{n}: fact marker '{key}' names no Governing-documents row")
                elif rows[km.group(1)][0] != val:
                    out.fail("docstatus", f"{f}:{n}: fact marker '{key}' says '{val[:40]}', its home says "
                                          f"'{rows[km.group(1)][0][:40]}'")


# ---------------------------------------------------------------- chain (M-R4) and map (M-R19)

def table_rows(text, header_word):
    """Rows of every markdown table in text whose header has a cell equal to header_word:
    [(header cells, row cells)]."""
    out, hdr = [], None
    for line in text.splitlines():
        if not line.startswith("|"):
            hdr = None
            continue
        cells = [c.strip() for c in re.split(r"(?<!\\)\|", line.strip())[1:-1]]
        if hdr is None:
            hdr = cells if header_word in cells else False
            continue
        if hdr is False or all(re.fullmatch(r":?-+:?", c) for c in cells):
            continue
        out.append((hdr, cells))
    return out


def expand_braces(tok):
    m = re.search(r"\{([^}]+)\}", tok)
    if not m:
        return [tok]
    return [x for alt in m.group(1).split(",") for x in expand_braces(tok[:m.start()] + alt + tok[m.end():])]


def pathlike(tok):
    return bool(re.fullmatch(r"\.?[\w.-]*(/[\w.{},*<>…-]+)+/?|[\w.-]+\.(md|json|py|sh|yml|yaml|txt)", tok))


def backtick_paths(cell):
    out = []
    for bt in re.findall(r"`([^`]+)`", cell):
        tok = bt.split()[0] if bt.split() else ""
        if pathlike(tok):
            out.extend(expand_braces(tok))
    return out


def pending_parts():
    """{part: (tokens, rule IDs)} for tranche parts that have not started (their item is `planned`)."""
    if "pending" in _cache:
        return _cache["pending"]
    t = content(None, "plan/builder/w-c00-12/12_tranche_plan.md") or ""
    sec = t.split("### 2.1 Parts", 1)[1].split("### 2.2", 1)[0] if "### 2.1 Parts" in t else ""
    metas = {m.get("id"): m for m in work_metas(None).values()}
    out = {}
    for hdr, cells in table_rows(sec, "Part"):
        pm = re.match(r"\*\*(1[a-d](?:-i+)?)\b", cells[0])
        if not pm:
            continue
        part = pm.group(1)
        item = metas.get(PART_ITEMS.get(part, ""), {})
        if item.get("execution") != "planned":
            continue
        toks = set()
        for bt in re.findall(r"`([^`]+)`", cells[1]):
            for tok in expand_braces(bt.split()[0] if bt.split() else ""):
                toks.add(tok)
                toks.add(Path(tok).name)
        out[part] = (toks, set(RULE_ID_RE.findall(cells[1])))
    _cache["pending"] = out
    return out


def pending_for(path, row_text=""):
    """A later part builds it, and it did not exist at the baseline (critic of 1b-ii #6: an existing carrier that
    disappears is never pending)."""
    if resolve(BASELINE) and git("cat-file", "-e", f"{BASELINE}:{path.rstrip('/')}", ok=True) is not None:
        return None
    for part, (toks, ids) in pending_parts().items():
        if path in toks or Path(path).name in toks or (RULE_ID_RE.findall(row_text) and
                                                       set(RULE_ID_RE.findall(row_text)) & ids):
            return part
    return None


def home_table():
    if Path("plan/builder/MEMORY_MAP.md").exists():
        src, t = "plan/builder/MEMORY_MAP.md", content(None, "plan/builder/MEMORY_MAP.md")
    else:
        src = "plan/builder/design/02_memory.md"
        t = (content(None, src) or "")
        t = t.split("## 3.", 1)[1].split("\n## 4.", 1)[0] if "## 3." in t else ""
    rows = []
    for hdr, cells in table_rows(t, "Authoritative home"):
        ci = hdr.index("Authoritative home")
        if ci < len(cells):
            rows.append((cells[0], cells[ci], backtick_paths(cells[ci])))
    return src, rows


def home_prefix(tok):
    cut = min([tok.find(c) for c in "<…*" if c in tok] or [len(tok)])
    if cut == len(tok):
        return tok
    return tok[:cut].rsplit("/", 1)[0] + "/"


FP_FILE = "plan/builder/heritage/FAILURE_PATTERNS.md"


def failure_pattern_rows(text):
    """Rows of the failure-pattern table: (id, status, produced_by, qualified_by) (R-R7)."""
    rows = []
    for line in (text or "").splitlines():
        if re.match(r"\| FP-\d+ \|", line):
            c = [x.strip().strip("`") for x in re.split(r"(?<!\\)\|", line.strip())[1:-1]]
            if len(c) == 8:
                rows.append((c[0], c[5], c[6], c[7]))
            else:
                rows.append((c[0], "?", "", ""))
    return rows


def check_failure_patterns(out):
    """R-R7: a pattern is qualified only by someone other than its producer; candidates stay labelled."""
    t = content(None, FP_FILE)
    if t is None:
        return
    for fid, status, prod, qual in failure_pattern_rows(t):
        q = "" if qual in ("", "—", "-") else qual
        if status not in ("candidate", "qualified"):
            out.fail("chain", f"{FP_FILE}: {fid} has status '{status}', not candidate or qualified (R-R7)")
        elif status == "qualified" and not q:
            out.fail("chain", f"{FP_FILE}: {fid} is qualified without a qualifier (R-R7)")
        elif q and q == prod:
            out.fail("chain", f"{FP_FILE}: {fid} is qualified by its own producer {prod} (R-R7)")


def check_chain(out):
    check_failure_patterns(out)
    seen = {}  # R-W12-5 m-3: a log entry ID is unique across the log files (a lease entry cut from main can collide)
    for f in sorted(Path("plan/ledger").glob("*-log.md")):
        for n in re.findall(r"(?m)^### (L-\d+) ", f.read_text()):
            if n in seen:
                out.fail("chain", f"log entry {n} appears twice ({seen[n]} and {f}) (M-R5)")
            seen.setdefault(n, str(f))
    src, rows = home_table()
    if not rows:
        out.fail("chain", f"{src}: no home table found")
    prefixes = []
    for fam, cell, toks in rows:
        for tok in toks:
            pre = home_prefix(tok)
            prefixes.append(pre)
            if not Path(pre).exists():
                part = pending_for(pre, cell)
                if part:
                    out.info(f"[chain] home {pre} of '{fam}' pending (built in {part})")
                else:
                    out.fail("chain", f"home {pre} of family '{fam}' does not exist (M-R4)")
    lt = content(None, "plan/ledger.md") or ""

    def block(name):
        m = re.search(R.GEN_RE.format(name=re.escape(name)), lt, re.S)
        return m.group(2) if m else ""
    shown = block("work-index") + block("zoom")
    for p in tracked_files(None, "plan/work"):
        if p.endswith(".md"):
            m, _ = front(content(None, p))
            if m and m.get("kind") == "root":
                continue
            if f"`{Path(p).stem}`" not in shown:
                out.fail("chain", f"{p} is missing from its generated index (work index and zoom)")
    di = block("decisions-index")
    for p in tracked_files(None, "plan/decisions"):
        if p.endswith(".md") and f"`{Path(p).stem}`" not in di:
            out.fail("chain", f"{p} is missing from the generated decisions index")
    named = [("CLAUDE.md", tok) for tok in backtick_paths(content(None, "CLAUDE.md") or "")]
    if src.endswith("MEMORY_MAP.md"):
        named += [(src, tok) for tok in backtick_paths(content(None, src) or "")]
    for f, tok in named:
        if any(c in tok for c in "<…*{") or ("/" not in tok and not Path(tok).exists()):
            continue  # a pattern, or a bare file name that is not a path claim
        if not Path(tok).exists() and not pending_for(tok):
            out.fail("chain", f"{f} names {tok}, which does not exist (M-R4)")
    homes = [p for p in prefixes if p.endswith("/")]
    for f in (git("ls-files", ok=True) or "").splitlines() + \
            (git("ls-files", "--others", "--exclude-standard", ok=True) or "").splitlines():
        if not f.endswith(".md") or any(f.startswith(h) for h in homes if h in ("plan/work/", "plan/decisions/")):
            continue
        t = content(None, f)
        if t and t.startswith("---\n"):
            m, _ = front(t)
            if m and "id" in m:
                out.fail("chain", f"{f} is a record (front matter with id) outside every record home (M-R4)")
    if "plan/work/" not in homes or "plan/decisions/" not in homes:
        for d in ("plan/work/", "plan/decisions/"):
            if d not in homes and tracked_files(None, d.rstrip("/")):
                out.fail("chain", f"files under {d} lie outside every home of {src} (M-R4)")


def check_map(out):
    t = content(None, "plan/builder/mechanisms.md") or ""
    sec = t.split("\n## 2.", 1)[1] if "\n## 2." in t else ""
    rows = table_rows(sec, "Carrier")
    if not rows:
        out.fail("map", "plan/builder/mechanisms.md section 2: no carrier table found")
    named = set()
    for hdr, cells in rows:
        rid = cells[0] if cells else "?"
        for i, c in enumerate(cells):
            if c == "":
                out.fail("map", f"row {rid}: cell '{hdr[i] if i < len(hdr) else i}' is blank (M-R19)")
        if "Carrier" not in hdr or hdr.index("Carrier") >= len(cells):
            continue
        cell = cells[hdr.index("Carrier")]
        row_text = " | ".join(cells)
        inactive = re.search(r"\b(retired|deferred)\b", " ".join(cells[:2] + [cell])) is not None
        for p in backtick_paths(cell):
            named.add(p)
            if any(ch in p for ch in "<…*"):
                continue
            exists = Path(p).exists() or ("/" not in p and any(Path(x).name == p for x in tracked_files(None, ".")))
            if not exists and not inactive:
                part = pending_for(p, row_text)
                if part:
                    out.info(f"[map] row {rid}: carrier {p} pending (built in {part})")
                else:
                    out.fail("map", f"row {rid}: carrier {p} does not exist (M-R19)")
    running = set()
    try:
        s = json.loads(content(None, ".claude/settings.json") or "{}")
    except json.JSONDecodeError:
        out.fail("map", ".claude/settings.json is not valid JSON")
        s = {}
    for groups in (s.get("hooks") or {}).values():
        for g in groups:
            for h in g.get("hooks", []):
                running.update(re.findall(r"\.claude/hooks/[\w.-]+", h.get("command", "")))
    for d in ("tools", ".github/workflows", ".claude/agents", "plan/builder/roles"):
        for p in tracked_files(None, d):
            if "__pycache__" not in p and not p.endswith(".pyc"):
                running.add(p)
    names_ = {Path(n).name for n in named if "/" not in n}
    for p in sorted(running):
        if p not in named and Path(p).name not in names_:
            out.fail("map", f"{p} runs but has no carrier row in plan/builder/mechanisms.md section 2 (M-R19)")


# ---------------------------------------------------------------- decisions (R-R10)

def check_decisions(out):
    legacy = set()
    if resolve(BASELINE):
        legacy = set(tracked_files(BASELINE, "plan/decisions"))
    for p in tracked_files(None, "plan/decisions"):
        if not p.endswith(".md"):
            continue
        m, _ = front(content(None, p))
        if m is None:
            out.fail("decisions", f"{p}: front matter unreadable")
            continue
        if m.get("class") == "batu" and not m.get("owner_reason"):
            out.fail("decisions", f"{p}: class batu without an owner reason (R-R10)")
        if p in legacy:
            continue
        major = m.get("class") == "batu" or m.get("kind") == "plan-change" or \
            re.match(r"FR-\d+$", str(m.get("id"))) or m.get("major") is True
        if major:
            miss = [f for f in ("premises", "alternatives", "chosen_because", "reopen_if", "consulted") if not m.get(f)]
            if miss:
                out.fail("decisions", f"{p}: major decision without {', '.join(miss)} (R-R10)")
    for p, m in work_metas(None).items():
        if m.get("type") == "major-design" and not m.get("counter_design"):
            out.fail("decisions", f"{p}: a major-design item without counter_design (R-R10)")


# ---------------------------------------------------------------- work (W-R1, W-R4, W-R9, R-R3, R-R5)

def register_states(rev=None):
    """The test register's State cells at rev (None: the working tree; R-W12-6 m-2, N-053 h)."""
    t = content(rev, "plan/builder/w-c00-12/11_test_register.md") or ""
    out = {}
    for line in t.splitlines():
        m = re.match(r"\| (T-[\w-]+) \|", line)
        if m:
            cells = [c.strip() for c in re.split(r"(?<!\\)\|", line.strip())[1:-1]]
            out[m.group(1)] = cells[-1]
    return out


def item_class(meta):
    c = target_class(meta.get("targets"))
    return "high" if meta.get("impact") == "high" or c == "high" else "normal"


def first_running_commit(path, rev=None):
    for c in (git("log", "--reverse", "--format=%H", rev or "HEAD", "--", path, ok=True) or "").split():
        m, _ = front(content(c, path))
        if m and (m.get("execution") in ("running", "waiting", "finished") or m.get("acceptance") == "accepted"):
            return c
    return None


def merge_of(c, ref="HEAD"):
    for m in (git("rev-list", "--first-parent", ref, ok=True) or "").split():
        ps = (git("rev-list", "--parents", "-n1", m) or "").split()[1:]
        if m == c:
            return m, m
        if len(ps) > 1 and is_ancestor(c, ps[1]) and not is_ancestor(c, ps[0]):
            return m, ps[1]
    return None, None


def deterministic_problems(item_path, text, rev=None):
    out = []
    cmd = re.search(r"(?m)^Deterministic-Command:\s*(.+)$", text)
    sha = re.search(r"(?m)^Deterministic-Commit:\s*([0-9a-f]{7,40})", text)
    res = re.search(r"(?m)^Deterministic-Result:\s*(.+)$", text)
    if not (cmd and sha and res):
        return ["deterministic evidence lacks Deterministic-Command, -Commit or -Result"]
    c = resolve(sha.group(1))
    if not c:
        return [f"deterministic commit {sha.group(1)} does not resolve"]
    if re.search(r"[;&|<>`$(){}\\\n*?!]", cmd.group(1)):
        return ["deterministic command contains shell metacharacters; only '<interpreter> <script> [args]' runs"]
    argv = cmd.group(1).split()
    scripts = [tok for tok in argv if tok.startswith(("tools/", "plan/builder/"))]
    if not scripts or argv[0] not in ("python3", "bash") or argv[1] != scripts[0]:
        return ["deterministic command is not '<python3|bash> <script under tools/ or plan/builder/> [args]'"]
    run = first_running_commit(item_path, rev)
    for script in scripts:
        last = (git("log", "-1", "--format=%H", c, "--", script, ok=True) or "").strip()
        if not last:
            return [f"{script} does not exist at {c[:7]}"]
        if not (run and is_ancestor(last, run) and last != run):
            m, m2 = merge_of(last, rev or "HEAD")
            if not m or not covered(m2, rev or "HEAD"):
                out.append(f"{script}'s last change {last[:7]} is neither pre-registered nor in a merge a verdict "
                           "covers (W-R1)")
    tmp = tempfile.mkdtemp(prefix="cr-det-")
    try:
        subprocess.run(["git", "clone", "-q", "--shared", ".", tmp], check=True, capture_output=True)
        subprocess.run(["git", "-C", tmp, "checkout", "-q", "--detach", c], check=True, capture_output=True)
        r = subprocess.run(argv, cwd=tmp, capture_output=True, text=True, timeout=600)
        lines = [x for x in r.stdout.splitlines() if x.strip()]
        if not lines or lines[-1].strip() != res.group(1).strip():
            out.append(f"re-run of '{cmd.group(1)[:60]}' at {c[:7]} ended '{(lines[-1] if lines else '')[:60]}', "
                       f"not '{res.group(1).strip()[:60]}'")
    except (subprocess.SubprocessError, OSError) as e:
        out.append(f"re-run failed: {e}")
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
    return out


def binding_problems(meta, item_path, vf, text, after=(), rev=None):
    """The verdict is this item's (critic of 1b-ii #1): it names the item's ID and a reviewed commit X with the
    item's first running commit an ancestor of X (and every path in `after` last changed before X), X an ancestor
    of the head; the item is finished; no other item uses the same file. rev: the tree to judge (None: the working
    tree on HEAD; impact() passes the PR head, R-W12-4 C-1)."""
    out = []
    iid = str(meta.get("id"))
    if meta.get("execution") != "finished":
        out.append(f"accepted while execution is '{meta.get('execution')}', not finished (W-R1)")
    if not re.search(r"(?<![\w.-])" + re.escape(iid) + r"(?![\w-]|\.\d)", text):
        out.append(f"{vf} does not name {iid} (W-R1: a verdict binds to its item)")
    run = first_running_commit(item_path, rev)
    head = resolve(rev or "HEAD")
    lasts = [(git("log", "-1", "--format=%H", rev or "HEAD", "--", a, ok=True) or "").strip() for a in after]
    ok = False
    for s in set(SHA_RE.findall(text)):
        x = resolve(s)
        if x and run and (x == run or is_ancestor(run, x)) and (x == head or is_ancestor(x, head)) and \
                all(not l or l == x or is_ancestor(l, x) for l in lasts):
            ok = True
            break
    if not ok:
        out.append(f"{vf} names no reviewed commit at or after the commit where {iid} started"
                   + (" and after its children's last changes" if after else "") + " (W-R1)")
    users = [m.get("id") for m in work_metas(rev).values()
             if vf in (str(m.get("accepted_by") or ""), str(m.get("composition_by") or ""))]
    if users != [iid] and not (after and set(users) <= {iid}):
        out.append(f"{vf} is used by {', '.join(sorted(map(str, users)))}; one verdict accepts one item (W-R1)")
    return out


def acceptance_problems(meta, item_path, states, rev=None):
    out = []
    ab = str(meta.get("accepted_by") or "")
    lab = meta.get("acceptance_label")
    if not ab or "session_" in ab:
        return [f"accepted_by '{ab}' is empty or a session (W-R1: no producer acceptance)"]
    if not ab.startswith("evidence/") or content(rev, ab) is None:
        return [f"accepted_by {ab} is not an existing file under evidence/ (W-R1)"]
    text = content(rev, ab) or ""
    if lab not in LABELS:
        out.append(f"acceptance_label '{lab}' missing or not one of {', '.join(sorted(LABELS))} (W-R1)")
    if fnmatch.fnmatch(ab, VERDICT_PATH):
        if not verdict_ok_text(text):
            out.append(f"{ab} has no PASS verdict naming a commit (W-R1)")
        out += binding_problems(meta, item_path, ab, text, rev=rev)
        if lab is not None and lab not in SESSION_LABELS:
            out.append(f"{ab} is a session verdict but the label is '{lab}'")
    elif "Deterministic-Command:" in text:
        if lab != "deterministic":
            out.append(f"{ab} is deterministic evidence but the label is '{lab}'")
        out += deterministic_problems(item_path, text, rev)
    elif lab == "subagent":
        out.append("a subagent verdict has no binding in tranche 1 (the producer could write it), so it cannot accept "
                   "(W-R1; critic of 1b-ii #9)")
    else:
        out.append(f"{ab} is neither a verdict file nor deterministic evidence naming a command (W-R1)")
    tl = re.search(r"(?m)^Tests:\s*(.+)$", text)
    for tid in re.findall(r"T-[\w-]+", tl.group(1) if tl else ""):
        if states.get(tid, "").startswith("retired"):
            out.append(f"{ab} cites {tid}, which the register lists as retired (W-R1)")
    if item_class(meta) == "high" and lab not in SESSION_LABELS:
        out.append(f"class high, but acceptance label '{lab}' is below a session verdict (R-R3)")
    return out


def composition_marked(text, iid):
    """A composition verdict identifies itself by a line `**Composition of:** <ID>` naming the parent (N-053 g)."""
    return bool(re.search(r"^\*\*Composition of:\*\* `?" + re.escape(iid) + r"`?\s*$", text or "", re.M))


def item_work_problems(iid, items, decisions, changes, states, rev=None):
    """The work check of one item (W-R1, W-R4, W-R9, R-R3, R-R5) on the tree at rev (None: the working tree).
    check_work runs it on every item at a stop; impact()'s W-R7 (ii) exemption runs it on the PR head, so the
    PR-time and the stop-time checks are this one function (R-W12-5 C-1)."""
    out = []
    m = items[iid]
    p = m["_path"]
    if m.get("kind") not in ("item", "stage"):
        return out
    if m.get("impact") == "normal" and target_class(m.get("targets")) == "high":
        out.append("impact normal is below the class its targets compute (R-R3)")
    if m.get("kind") == "item" and item_class(m) == "normal" and \
            (m.get("execution") in ("running", "waiting", "finished") or m.get("acceptance") == "accepted"):
        tr = m.get("triage")
        if not tr or content(rev, str(tr)) is None:
            out.append(f"class normal at {m.get('execution')} without a triage record (R-R5)")
    if m.get("acceptance") != "accepted":
        return out
    out += acceptance_problems(m, p, states, rev)
    q, why = R.qualification(m, decisions, changes)
    if q == "stale":
        out.append(f"accepted while stale ({why}) (W-R9)")
    kids = R.children(items, iid)
    if kids and m.get("kind") == "item":
        cb = str(m.get("composition_by") or "")
        if not cb or not fnmatch.fnmatch(cb, VERDICT_PATH) or not verdict_ok_text(content(rev, cb)):
            out.append("a parent accepted without a composition verdict (composition_by) (W-R4)")
        else:
            ct = content(rev, cb) or ""
            if not composition_marked(ct, iid):  # structural, not the word anywhere (R-W12-6 B-1, N-053 g)
                out.append(f"{cb} is not a composition verdict of {iid}: no line '**Composition of:** {iid}' (W-R4)")
            for prob in binding_problems(m, p, cb, ct, after=[k["_path"] for k in kids], rev=rev):
                out.append(f"composition: {prob}")
        for k in kids:
            if not R.is_closed(k):
                out.append(f"accepted while child {k['id']} is not accepted, cancelled or declined (W-R4)")
    return out


_TREES = []
atexit.register(lambda: [shutil.rmtree(d, ignore_errors=True) for d in _TREES])


def records_at(rev):
    """(items, decisions, changes, root) of the records at rev; rev None: the working tree. A commit's records are
    read from an export of its plan/ and evidence/ in a temporary directory."""
    key = ("records", rev)
    if key in _cache:
        return _cache[key]
    if rev is None:
        root = Path(".")
    else:
        root = Path(tempfile.mkdtemp(prefix="cr-tree-"))
        _TREES.append(root)
        a = subprocess.run(["git", "archive", rev, "plan", "evidence"], capture_output=True, check=True)
        subprocess.run(["tar", "-x", "-C", str(root)], input=a.stdout, capture_output=True, check=True)
    saved = R.ROOT_FOR_ACCEPT[0]
    try:
        items, decisions = R.load_records(root)
        changes = R.record_changes(root)
    finally:
        R.ROOT_FOR_ACCEPT[0] = saved
    _cache[key] = (items, decisions, changes, root)
    return _cache[key]


def work_problems_at(iid, rev):
    items, decisions, changes, root = records_at(rev)
    if iid not in items:
        return [f"{iid} not found at {rev or 'the working tree'}"]
    saved = R.ROOT_FOR_ACCEPT[0]
    R.ROOT_FOR_ACCEPT[0] = root  # is_accepted() of the children reads accepted_by files under this root
    try:
        return item_work_problems(iid, items, decisions, changes, register_states(rev), rev)
    finally:
        R.ROOT_FOR_ACCEPT[0] = saved


def check_work(out):
    items, decisions = R.load_records(Path("."))
    changes = R.record_changes(Path("."))
    states = register_states()
    for iid in sorted(items, key=R.sortkey):
        for prob in item_work_problems(iid, items, decisions, changes, states):
            out.fail("work", f"{iid}: {prob}")


# ---------------------------------------------------------------- views (M-R6, M-R15)

def check_views(out):
    items, decisions = R.load_records(Path("."))
    changes = R.record_changes(Path("."))
    text = content(None, "plan/ledger.md") or ""
    new = R.render_ledger(text, items, decisions, changes)
    if new != text:
        for name in ("frontier", "zoom", "work-index", "decisions-index", "open-notes"):
            a = re.search(R.GEN_RE.format(name=re.escape(name)), text, re.S)
            b = re.search(R.GEN_RE.format(name=re.escape(name)), new, re.S)
            if (a and a.group(2)) != (b and b.group(2)):
                out.fail("views", f"plan/ledger.md generated block '{name}' differs from a fresh render (M-R6)")
    d = R.durum(new, items, decisions, changes)
    cur = content(None, "DURUM.md")
    if cur != d:
        a, b = (cur or "").splitlines(), d.splitlines()
        n = next((i for i in range(max(len(a), len(b))) if (a[i] if i < len(a) else None) !=
                  (b[i] if i < len(b) else None)), 0)
        out.fail("views", f"DURUM.md differs from a fresh render at line {n + 1} (M-R6, M-R15)")


# ---------------------------------------------------------------- answers (M-R13) and leak (A-07)

def fetch_comments(url):
    out = []
    for page in range(1, 11):
        u = url if page == 1 else f"{url}&page={page}"
        r = subprocess.run(["curl", "-sS", "-f", "--max-time", "20", u], capture_output=True, text=True)
        if r.returncode != 0:
            raise CheckError(f"ISSUE_READ_FAILED: curl exit {r.returncode}: {r.stderr.strip()[:120]}")
        try:
            data = json.loads(r.stdout)
        except json.JSONDecodeError:
            raise CheckError("ISSUE_READ_FAILED: the response is not JSON")
        if not isinstance(data, list):
            raise CheckError("ISSUE_READ_FAILED: the response is not a list of comments")
        out += data
        if len(data) < 100 or url.startswith("file:"):
            break
    return out


def check_answers(out, url):
    try:
        comments = fetch_comments(url)
    except CheckError as e:
        out.fail("answers", str(e))
        return
    dec = "".join(content(None, p) or "" for p in tracked_files(None, "plan/decisions"))
    logs = "".join(content(None, p) or "" for p in tracked_files(None, "plan/ledger") if LOG_RE.match(p))
    nd = set(re.findall(r"not a decision:\s*([\d, ]+)", logs))
    nd = {x for s in nd for x in re.findall(r"\d+", s)}
    cursor = ledger_rows(content(None, "plan/ledger.md") or "").get("answers seen through", ("", ""))[0]
    seen = 0
    for c in comments:
        if (c.get("user") or {}).get("login") != BATU:
            continue
        seen += 1
        cid = str(c.get("id"))
        if not re.search(r"(?<!\d)" + cid + r"(?!\d)", dec) and cid not in nd:
            out.fail("answers", f"comment {cid} by {BATU} is neither quoted in a decision record nor logged "
                                "'not a decision' (M-R13)")
    out.info(f"[answers] {len(comments)} comment(s), {seen} by {BATU}; cursor: {cursor[:60]}")


def check_leak(out):
    pat, n = leak_terms()
    hits = []
    diff = git("diff", "--cached", "-U0", ok=True) or ""
    cur = None
    for line in diff.splitlines():
        if line.startswith("+++ "):
            cur = line[6:] if line.startswith("+++ b/") else line[4:]
        elif line.startswith("+") and not line.startswith("+++") and pat.search(line):
            hits.append(f"staged {cur}")
    for f in (git("ls-files", "--others", "--exclude-standard", ok=True) or "").splitlines():
        t = content(None, f)
        for i, line in enumerate((t or "").splitlines(), 1):
            if pat.search(line):
                hits.append(f"untracked {f}:{i}")
    for h in hits:
        out.fail("leak", f"derived service term in {h} (A-07)")
    out.info(f"[leak] terms {n}")


# ---------------------------------------------------------------- merged (stop) and main

def check_merged(since, main_ref, out):
    sb = resolve(since)
    mr = resolve(main_ref)
    if not sb or not mr:
        out.fail("merged", f"cannot resolve the baseline {since} or {main_ref}")
        return
    log_added = added_log_lines(sb, mr)
    commits = (git("rev-list", "--first-parent", "--reverse", f"{sb}..{mr}") or "").split()
    exc = []  # (failing commit prefix, subcommand, index of the commit that added the line)
    for i, c in enumerate(commits):
        ps = (git("rev-list", "--parents", "-n1", c) or "").split()[1:]
        for line in added_log_lines(ps[0], c):
            m = re.search(r"record-check exception:\s*([0-9a-f]{7,40})\s+(\w+):", line)
            if m:
                exc.append((m.group(1), m.group(2), i))
    reverts = {}
    for ci, c in enumerate(commits):
        ps = (git("rev-list", "--parents", "-n1", c) or "").split()[1:]
        base, m2 = ps[0], (ps[1] if len(ps) > 1 else c)
        sub = Out()
        check_kinds(base, c, sub)
        check_stamps(base, c, sub)
        check_claims_diff(base, c, sub)
        cls, reasons, bg = impact(base, c)
        if bg:
            reverts[bg] = c
            cov = covered(m2, mr, strict={m2, c})
            if cov:
                out.info(f"[break-glass] {c[:7]} reverts {bg[:7]}; verdict {cov[0]}")
            else:
                out.fail("break-glass", f"{c[:7]} is a break-glass revert of {bg[:7]} and no session verdict covers "
                                        f"it yet (W-R7)")
        elif cls == "high":
            cov = covered(m2, mr)
            if cov:
                out.info(f"[impact] {c[:7]} high; covered by {cov[0]} at {cov[1][:7]}")
            else:
                out.fail("impact", f"merged {c[:7]} is class high ({reasons[0][:70]}) and no session verdict covers "
                                   f"its head {m2[:7]} (W-R7)")
        for s, msg in sub.fails:
            reviews = s == "claims" and "evidence/" in msg and "/reviews/" in msg
            if not reviews and any(c.startswith(x) and s == y and i > ci for x, y, i in exc):
                sess = ",".join(sorted(sessions_in(base, c)))
                out.info(f"[exception] merged {c[:7]} {s}: {msg[:100]} (sessions {sess})")
                print(f"EXCEPTION {c[:7]} {s} sessions={sess}")
            else:
                out.fail(s, f"merged {c[:7]}: {msg}")
    for line in log_added:
        for m in re.finditer(r"break-glass:\s*([0-9a-f]{7,40})", line):
            t = resolve(m.group(1))
            if not t or t not in reverts:
                out.fail("break-glass", f"log line break-glass: {m.group(1)} names no revert found on main")
    counts, frc = patch_counts(mr)
    out.info("[patch] count since " + (f"FR record {frc[:7]}" if frc else "the start of the log") + ": " +
             (", ".join(f"{k} {v}" for k, v in sorted(counts.items())) or "none"))


def run(out, subs, base=None, head=None):
    for s in subs:
        n = len(out.fails)
        fn = {"chain": lambda: check_chain(out), "views": lambda: check_views(out),
              "docstatus": lambda: check_docstatus(out), "decisions": lambda: check_decisions(out),
              "map": lambda: check_map(out), "work": lambda: check_work(out),
              "kinds": lambda: check_kinds(base, head, out), "stamps": lambda: check_stamps(base, head, out),
              "claims": lambda: (check_claims_tree(out), check_claims_diff(base, head, out)),
              "impact": lambda: out.info("[impact] {} -> {}: class {}{}".format(
                  base[:7], (head or "worktree")[:8], impact(base, head)[0],
                  "".join(f"; {r}" for r in impact(base, head)[1][:5])))}[s]
        fn()
        if len(out.fails) == n:
            print(f"PASS  {s}")


def main(argv=None):
    ap = argparse.ArgumentParser(prog="check_records.py")
    ap.add_argument("sub", choices=["chain", "views", "docstatus", "decisions", "map", "work", "kinds", "impact",
                                    "stamps", "claims", "all", "merged", "answers", "leak"])
    ap.add_argument("--base")
    ap.add_argument("--head")
    ap.add_argument("--worktree", action="store_true", help="diff against the working tree (default for all)")
    ap.add_argument("--since", help="merged: override the baseline (printed; builder_check.sh refuses it in a run)")
    ap.add_argument("--main", default="origin/main")
    ap.add_argument("--url", default=os.environ.get("ISSUE_API_URL", ISSUE_URL))
    a = ap.parse_args(argv)
    out = Out()
    try:
        head = None if (a.worktree or (a.sub == "all" and not a.head)) else (a.head or "HEAD")
        base = a.base
        if a.sub in ("kinds", "impact", "stamps", "claims", "all") and not base:
            mb = git("merge-base", a.main, "HEAD", ok=True)
            if not mb:
                raise CheckError(f"no merge base with {a.main}; give --base")
            base = mb.strip()
        elif base:
            base = resolve(base) or base
        if a.sub == "all":
            run(out, ["chain", "views", "docstatus", "decisions", "map", "work", "kinds", "impact", "stamps",
                      "claims"], base, head)
        elif a.sub == "merged":
            since = a.since or BASELINE
            if a.since:
                print(f"INFO  baseline overridden: {a.since} (default {BASELINE})")
            check_merged(since, a.main, out)
            if not any(s for s, _ in out.fails):
                print("PASS  merged")
        elif a.sub == "answers":
            check_answers(out, a.url)
            if not out.fails:
                print("PASS  answers")
        elif a.sub == "leak":
            check_leak(out)
            if not out.fails:
                print("PASS  leak")
        else:
            run(out, [a.sub], base, head)
    except (CheckError, R.RecordError, OSError, ValueError, yaml.YAMLError, KeyError, IndexError) as e:
        for s, msg in out.fails:
            print(f"FAIL  [{s}] {msg}")
        print(f"FAIL  [error] {type(e).__name__}: {e}")
        print("RECORDS ERROR")
        return 2
    for i in out.infos:
        print(f"INFO  {i}")
    for s, msg in out.fails:
        print(f"FAIL  [{s}] {msg}")
    print("RECORDS FAIL" if out.fails else "RECORDS PASS")
    return 1 if out.fails else 0


if __name__ == "__main__":
    sys.exit(main())
