#!/usr/bin/env python3
"""merge_gate.py: the merge gate that guard rule M7 runs before every merge (D-010; PC-06;
plan/Installation_Working_Order.md).

Usage, from the repository root: python3 tools/merge_gate.py --pr N --head SHA

It fetches main and the pull request's head from origin; the head must be SHA (40 characters). A head whose
diff from its merge base with main touches no class-high path passes. A class-high head passes only when its
own tree holds a checker verdict file evidence/<stage>/checks/CHK-<stage>-<nnn>.md whose front matter names in
reviewed_head the head, or a commit X that is an ancestor of the head with X..head touching only class-normal
paths; has verdict PASS or PASS-WITH-CONDITIONS; and has the independence and checker_run fields. Anything else
fails closed, with the reason.

Class-high paths: .claude/**, tools/**, .github/workflows/**, CLAUDE.md, .gitattributes,
plan/Installation_Working_Order.md (successor of the retired plan/Builder_Operating_Model.md),
plan/Ek_A_Rol_Sozlesmeleri.md and plan/Ek_D_Dusunme_Protokolleri.md. A change to .claude/hooks/owned_ids.txt
that only adds recorder lines (session_... or trig_...) is class normal.

Output: reason lines, then GATE PASS (exit 0) or GATE FAIL (exit 1); GATE ERROR (exit 2) when it cannot run.
"""
import argparse
import difflib
import re
import subprocess
import sys

sys.dont_write_bytecode = True

HIGH_PREFIXES = (".claude/", "tools/", ".github/workflows/")
HIGH_FILES = {"CLAUDE.md", ".gitattributes", "plan/Installation_Working_Order.md", "plan/Ek_A_Rol_Sozlesmeleri.md",
              "plan/Ek_D_Dusunme_Protokolleri.md"}
OWNED = ".claude/hooks/owned_ids.txt"
RECORDER_LINE = re.compile(r"(session|trig)_[A-Za-z0-9]+")
VERDICT_PATH = re.compile(r"evidence/([^/]+)/checks/CHK-\1-\d{3,}\.md")
SHA40 = re.compile(r"[0-9a-f]{40}")
COVERING = {"PASS", "PASS-WITH-CONDITIONS"}


class GateError(Exception):
    pass


def git(*args, ok=False):
    """stdout of a git command; None on failure when ok, otherwise GateError."""
    r = subprocess.run(["git", *args], capture_output=True, text=True)
    if r.returncode:
        if ok:
            return None
        raise GateError(f"git {' '.join(args)[:100]}: {r.stderr.strip()[:200]}")
    return r.stdout


def show(rev, path):
    r = subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True, text=True)
    return "" if r.returncode else r.stdout


def changed(base, head):
    return [p for p in git("diff", "--name-only", "-z", "--no-renames", base, head).split("\0") if p]


def recorder_only(old, new):
    """True when new differs from old only by added recorder lines."""
    a, b = old.splitlines(), new.splitlines()
    return all(t == "equal" or (t == "insert" and all(RECORDER_LINE.fullmatch(x.strip()) for x in b[j1:j2]))
               for t, _, _, j1, j2 in difflib.SequenceMatcher(None, a, b, autojunk=False).get_opcodes())


def high_paths(base, head):
    """The class-high paths that base..head touches; empty means class normal."""
    out = []
    for p in changed(base, head):
        if p == OWNED:
            if not recorder_only(show(base, p), show(head, p)):
                out.append(f"{p} (not only added recorder lines)")
        elif p.startswith(HIGH_PREFIXES) or p in HIGH_FILES:
            out.append(p)
    return out


def front(text):
    """The top-level `key: value` lines of the front matter (quotes stripped); None when there is none."""
    if not text.startswith("---\n") or "\n---" not in text[3:]:
        return None
    lines = (re.match(r"([a-z_]+):(.*)", line) for line in text[4:text.index("\n---", 3)].splitlines())
    return {m.group(1): m.group(2).strip().strip("\"'") for m in lines if m}


def cover(head, in_pr):
    """(verdict file, reviewed commit, why): the verdict covering head, (None, None) when none does, and why the
    verdict files the pull request adds or changes do not cover it."""
    why = []
    listing = git("ls-tree", "-r", "-z", "--name-only", head, "--", "evidence")
    for vf in sorted(p for p in listing.split("\0") if VERDICT_PATH.fullmatch(p)):
        meta = front(show(head, vf))
        x = (meta or {}).get("reviewed_head", "")
        if meta is None:
            problem = "no front matter"
        elif meta.get("verdict") not in COVERING:
            problem = f"verdict {meta.get('verdict')!r} is not PASS or PASS-WITH-CONDITIONS"
        elif not (meta.get("independence") and meta.get("checker_run")):
            problem = "the independence or checker_run field is missing"
        elif not SHA40.fullmatch(x):
            problem = f"reviewed_head {x!r} is not a full 40-character SHA"
        elif x != head and git("merge-base", "--is-ancestor", x, head, ok=True) is None:
            problem = f"reviewed_head {x[:12]} is neither the head nor an ancestor of it"
        elif x != head and (hp := high_paths(x, head)):
            problem = f"{x[:12]}..head touches class-high paths: {', '.join(hp[:4])}"
        else:
            return vf, x, why
        if vf in in_pr:
            why.append(f"{vf}: {problem}")
    return None, None, why


def gate(pr, head):
    """(ok, lines)."""
    if not SHA40.fullmatch(head):
        return False, [f"--head {head!r} is not a full 40-character SHA"]
    if (git("rev-parse", "--is-shallow-repository", ok=True) or "").strip() == "true" and \
            git("fetch", "-q", "--unshallow", "origin", ok=True) is None:
        return False, ["cannot unshallow the repository, so ancestry cannot be checked"]
    if git("fetch", "-q", "origin", "+refs/heads/main:refs/remotes/origin/main", ok=True) is None:
        return False, ["cannot fetch main from origin"]
    if git("fetch", "-q", "origin", f"+refs/pull/{pr}/head:refs/devos-gate/pr-{pr}", ok=True) is None:
        return False, [f"cannot fetch the head of pull request #{pr}"]
    got = git("rev-parse", f"refs/devos-gate/pr-{pr}").strip()
    if got != head:
        return False, [f"pull request #{pr} has head {got}, not the SHA given; the head moved"]
    base = (git("merge-base", "origin/main", head, ok=True) or "").strip()
    if not base:
        return False, [f"{head[:12]} has no merge base with origin/main"]
    high = high_paths(base, head)
    if not high:
        return True, [f"class normal: {base[:12]}..{head[:12]}"]
    lines = ["class high: " + ", ".join(high[:6]) + (" ..." if len(high) > 6 else "")]
    vf, x, why = cover(head, set(changed(base, head)))
    if vf:
        return True, lines + [f"covered by {vf} (reviewed_head {x[:12]})"]
    return False, lines + why + [
        "no checker verdict file in the head's tree covers it (evidence/<stage>/checks/CHK-<stage>-<nnn>.md with "
        "reviewed_head the head or an ancestor X where X..head is class normal, verdict PASS or "
        "PASS-WITH-CONDITIONS, independence and checker_run)"]


def main(argv=None):
    ap = argparse.ArgumentParser(prog="merge_gate.py")
    ap.add_argument("--pr", type=int, required=True)
    ap.add_argument("--head", required=True)
    a = ap.parse_args(argv)
    try:
        ok, lines = gate(a.pr, a.head)
    except (GateError, OSError, ValueError) as e:
        print(f"GATE ERROR: {type(e).__name__}: {e}")
        return 2
    for line in lines[:-1]:
        print(f"  {line}")
    print(f"GATE {'PASS' if ok else 'FAIL'}: PR #{a.pr} head {a.head[:12]}: {lines[-1]}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
