#!/usr/bin/env python3
"""check_role_packages.py: the static check of the six role packages in .claude/roles/ (W-C02-23, PR-A2; SB-COR 2.3).

Usage (standard library only; run with python3 -I):
  check_role_packages.py --root DIR   read the tree under DIR
  check_role_packages.py --rev SHA    read revision SHA of the repository of the working directory through git

It checks: exactly the six files producer.md, researcher.md, prober.md, checker.md, test-designer.md and
executor.md, with no subfolder and no other entry; each strict UTF-8 without NUL; a first line that is not `---`;
no line starting `name:` or `## `; no line of 2,000 or more characters; at most LIMIT UTF-8 bytes, and for
executor.md at most LIMIT minus the UTF-8 bytes of the compaction hook's MESSAGE and its newline (MESSAGE read from
.claude/hooks/reread_after_compact.py at the same tree or revision by ast.literal_eval of its assignment, never
imported or run); every cited EV, CHK, L and N ID resolving at the same tree or revision. Its claim is "every cited
ID resolves", nothing about the content of a cited record.

Output: one line per file, `ROLE_PACKAGE <name> bytes=<n> limit=<m> PASS|FAIL <reasons>`, then
`ROLE_PACKAGES PASS` (exit 0), `ROLE_PACKAGES FAIL` (exit 1) or `ROLE_PACKAGES COULD NOT CHECK: <cause>` (exit 2).
Reason tokens: size, utf8, nul, front-matter, name-line, heading, long-line, unresolved <IDs>, missing, extra.
RESERVE, LIMIT and HEADER are the one source for W-C02-25's start hook; importing this module runs nothing.
"""
import argparse
import ast
import os
import re
import subprocess
import sys

RESERVE = 200
LIMIT = 9500 - RESERVE
HEADER = "DevOS role package: {role}@{sha12}"   # sha12: the first 12 hex of the file's SHA-256

ROLES_DIR = ".claude/roles/"
ROLES = ("producer.md", "researcher.md", "prober.md", "checker.md", "test-designer.md", "executor.md")
HOOK = ".claude/hooks/reread_after_compact.py"
ID_RE = re.compile(r"(?<![A-Za-z0-9-])(EV-C\d\d-\d{3}|CHK-C\d\d-\d{3}|L-\d+|N-\d+)(?!\d)")
RECORD_NAME = re.compile(r"((?:EV|CHK)-C\d\d-\d{3})[_.-]")   # an evidence file name that resolves the ID


class CouldNotCheck(Exception):
    pass


class Root:
    """A tree on disk."""

    def __init__(self, root):
        self.root = os.path.abspath(root)
        if not os.path.isdir(self.root):
            raise CouldNotCheck(f"{root} is not a directory")
        self.paths = []
        for d, dirs, files in os.walk(self.root):
            rel = os.path.relpath(d, self.root).replace(os.sep, "/")
            rel = "" if rel == "." else rel + "/"
            self.paths += [rel + f for f in files]
            if not dirs and not files and rel:
                self.paths.append(rel)   # an empty folder is an entry too (it can stand only under --root)

    def read(self, paths):
        out = {}
        for p in paths:
            f = os.path.join(self.root, p)
            if os.path.isfile(f):
                with open(f, "rb") as fh:
                    out[p] = fh.read()
            else:
                out[p] = None
        return out


class Rev:
    """A revision of the repository of the working directory, read through git, never from the disk."""

    def __init__(self, rev):
        r = subprocess.run(["git", "rev-parse", "--verify", "-q", f"{rev}^{{commit}}"], capture_output=True, text=True)
        if r.returncode:
            raise CouldNotCheck(f"revision {rev} is not a commit this repository holds")
        self.sha = r.stdout.strip()
        r = subprocess.run(["git", "ls-tree", "-r", "-z", "--name-only", self.sha], capture_output=True)
        if r.returncode:
            raise CouldNotCheck(f"git ls-tree {self.sha[:12]} failed")
        self.paths = [p.decode("utf-8", "surrogateescape") for p in r.stdout.split(b"\0") if p]

    def read(self, paths):
        paths = list(paths)
        data = "".join(f"{self.sha}:{p}\n" for p in paths).encode("utf-8", "surrogateescape")
        r = subprocess.run(["git", "cat-file", "--batch"], input=data, capture_output=True)
        if r.returncode:
            raise CouldNotCheck(f"git cat-file at {self.sha[:12]} failed")
        out, i, buf = {}, 0, r.stdout
        for p in paths:
            j = buf.index(b"\n", i)
            head = buf[i:j].split()
            if len(head) != 3:   # "<name> missing" or "ambiguous"
                out[p], i = None, j + 1
                continue
            n = int(head[2])
            out[p] = buf[j + 1:j + 1 + n] if head[1] == b"blob" else None
            i = j + 2 + n
        return out


def message_bytes(tree):
    """UTF-8 bytes of the hook's MESSAGE plus its newline; CouldNotCheck unless MESSAGE is one string literal."""
    src = tree.read([HOOK])[HOOK]
    if src is None:
        raise CouldNotCheck(f"{HOOK} absent")
    try:
        mod = ast.parse(src)
    except (SyntaxError, ValueError):
        raise CouldNotCheck(f"{HOOK} does not parse, so MESSAGE cannot be read")
    def binds(n):
        return isinstance(n, ast.Name) and n.id == "MESSAGE" and isinstance(n.ctx, ast.Store)
    # Exactly one binding of MESSAGE anywhere in the hook, and it is a top-level assignment.
    stores = [n for n in ast.walk(mod) if binds(n)]
    assigns = [s for s in mod.body if isinstance(s, ast.Assign) and any(binds(t) for t in s.targets)]
    try:
        if len(stores) != 1 or len(assigns) != 1:
            raise ValueError
        msg = ast.literal_eval(assigns[0].value)
        if not isinstance(msg, str):
            raise ValueError
        return len((msg + "\n").encode("utf-8"))
    except (ValueError, TypeError, SyntaxError, MemoryError, RecursionError, UnicodeEncodeError):
        raise CouldNotCheck(f"MESSAGE in {HOOK} is not one assignment of a string literal")


def resolver(tree):
    """A function telling whether a cited ID resolves in the tree, by the approach's rules (agreed (4))."""
    ev = {m.group(1) for p in tree.paths if p.startswith("evidence/")
          for m in [RECORD_NAME.match(p.rsplit("/", 1)[-1])] if m}
    logs = [p for p in tree.paths if p.startswith("plan/ledger/") and p.count("/") == 2 and p.endswith("-log.md")]
    items = [p for p in tree.paths if p.startswith("plan/work/") and p.count("/") == 2 and p.endswith(".md")]
    texts = tree.read(logs + items)
    log_text, item_text = ("\n".join((texts[p] or b"").decode("utf-8", "replace") for p in ps) for ps in (logs, items))

    def resolves(i):
        if i.startswith("L-"):
            return re.search(rf"^### {i} ", log_text, re.M) is not None   # a log heading
        if i.startswith("N-"):
            return f"<!-- note {i} " in item_text   # a note's opening, as tools/records.py's NOTE_RE reads it
        return i in ev
    return resolves


def reasons(data, limit, resolves):
    """The reason tokens of every rule the file breaks; the text rules only on strict UTF-8."""
    why = ["size"] if len(data) > limit else []
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError:
        return why + ["utf8"]
    lines = text.split("\n")
    why += [tok for tok, broken in (
        ("nul", "\0" in text),
        ("front-matter", lines[0].rstrip() == "---"),
        ("name-line", any(x.startswith("name:") for x in lines)),
        ("heading", any(x.startswith("## ") for x in lines)),
        ("long-line", any(len(x) >= 2000 for x in lines))) if broken]
    missing = list(dict.fromkeys(i for i in ID_RE.findall(text) if not resolves(i)))
    return why + (["unresolved " + " ".join(missing)] if missing else [])


def check(tree):
    """(ok, lines)."""
    limits = {n: LIMIT for n in ROLES}
    limits["executor.md"] = LIMIT - message_bytes(tree)
    entries = sorted(p[len(ROLES_DIR):] for p in tree.paths if p.startswith(ROLES_DIR))
    data = tree.read(ROLES_DIR + n for n in ROLES if n in entries)
    resolves = resolver(tree)
    lines, ok = [], True
    for n in ROLES:
        b = data.get(ROLES_DIR + n)
        why = ["missing"] if b is None else reasons(b, limits[n], resolves)
        ok = ok and not why
        size = "-" if b is None else len(b)
        lines.append(f"ROLE_PACKAGE {n} bytes={size} limit={limits[n]} " + ("FAIL " + " ".join(why) if why else "PASS"))
    other = [e for e in entries if e not in ROLES]
    sizes = tree.read(ROLES_DIR + e for e in other)
    for e in other:
        b = sizes[ROLES_DIR + e]
        lines.append(f"ROLE_PACKAGE {e} bytes={'-' if b is None else len(b)} limit=- FAIL extra")
    ok = ok and not other
    return ok, lines


def main(argv=None):
    ap = argparse.ArgumentParser(prog="check_role_packages.py")
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--root")
    g.add_argument("--rev")
    a = ap.parse_args(argv)
    try:
        ok, lines = check(Root(a.root) if a.root is not None else Rev(a.rev))
    except (CouldNotCheck, OSError, ValueError) as e:
        print(f"ROLE_PACKAGES COULD NOT CHECK: {e}")
        return 2
    print("\n".join(lines))
    print(f"ROLE_PACKAGES {'PASS' if ok else 'FAIL'}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
