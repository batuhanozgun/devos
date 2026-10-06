#!/usr/bin/env python3
"""Where the session's own credential values occur, never the values (CHK-C00-070 condition 1; PC-18).

PC-18 reads C00's sixth acceptance condition so that the credentials the platform places in the session's
environment are outside it only there: a value of one of them written into a repository, a record or the chat breaks
it. This script checks that by value, without showing a value. Inside its own process it takes:
  - every variable of the guard's CREDENTIAL_VARS (read from the guard file of this checkout) whose value is a
    candidate: set, at least MIN_LEN characters, not the documented placeholder, not an absolute path, not a URL;
  - the content of the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE (the session's token file), stripped, if it is
    a regular file of at most 64 KiB and its content is a candidate.
It then counts, for each value, the places that hold it:
  --repo PATH   every object in the object store of the git repository at PATH (blobs, commits with their messages,
                trees, tags; reachable or not), read with `git cat-file --batch-all-objects --batch`;
  --dir PATH    every regular file under PATH, read in chunks;
  --session-transcripts   the same, under <home>/.claude/projects: the session's transcripts, which hold the chat,
                every tool call and every subagent ($DEVOS_AUDIT_HOME, default the home directory, as
                tools/subagent_audit.py finds them);
  --guard-log   the same, under the guard's decision log ($DEVOS_GUARD_LOG_DIR, default /tmp/devos-guard, as
                tools/guard_report.py reads it).
The two built-in scopes are read, never written, as the other tools read them; their paths are derived here and are
not given on the command line, which the guard's B5 denies for every non-reader command.
Output: each value's label and length; each scope's size; for each value and scope, the number of objects or files
that hold it, and for a match the object IDs or the file paths (a path that itself holds a value is withheld),
never their content. No value, part of one or hash of one is printed. Encoded forms (base64, URL-encoding, escaped
JSON) are not decoded: a value held only in such a form is not found; nor is a part of the token file's content
written alone. Exit 0 when every scope was read and none was empty; 2 on an error, a missing or empty scope, or a
scope that could not be read (then the last line is CREDENTIAL_VALUE_SCAN INCOMPLETE).
Usage: python3 -I tools/credential_value_scan.py [--repo PATH]... [--dir PATH]... [--session-transcripts] [--guard-log]
"""
import argparse
import ast
import os
import re
import subprocess
import sys
from pathlib import Path

sys.dont_write_bytecode = True
GUARD = Path(__file__).resolve().parent.parent / ".claude" / "hooks" / "tool_allowlist.py"
PLACEHOLDER = "proxy-injected"
TOKEN_FILE_VAR = "CLAUDE_SESSION_INGRESS_TOKEN_FILE"
MIN_LEN = 16
CHUNK = 1 << 20


def guard_credential_vars():
    tree = ast.parse(GUARD.read_text(encoding="utf-8"))
    for node in tree.body:
        if not isinstance(node, ast.Assign):
            continue
        if "CREDENTIAL_VARS" in [getattr(t, "id", None) for t in node.targets]:
            return tuple(ast.literal_eval(node.value))
    raise ValueError("CREDENTIAL_VARS not found")


def candidate(v):
    return (len(v) >= MIN_LEN and v != PLACEHOLDER and not v.startswith("/")
            and not re.match(r"[a-z][a-z0-9+.-]*://", v, re.I))


def values(env):
    """[(label, bytes)] for the candidate values, and lines saying which variables gave none and why."""
    out, notes = [], []
    for name in guard_credential_vars():
        v = env.get(name)
        if v is None or v == "":
            notes.append(f"{name}: no value")
        elif candidate(v):
            out.append((name, v.encode("utf-8", "surrogateescape")))
        else:
            notes.append(f"{name}: not a candidate (placeholder, path, URL or shorter than {MIN_LEN})")
    p = env.get(TOKEN_FILE_VAR)
    label = f"the file named by {TOKEN_FILE_VAR}"
    if p and os.path.isfile(p) and os.path.getsize(p) <= 65536:
        with open(p, "rb") as f:
            v = f.read().strip()
        if len(v) >= MIN_LEN:
            out.append((label, v))
        else:
            notes.append(f"{label}: content shorter than {MIN_LEN}")
    else:
        notes.append(f"{label}: no regular file of at most 64 KiB")
    return out, notes


def scan_repo(path, vals):
    hits = {label: [] for label, _ in vals}
    p = subprocess.Popen(["git", "-C", path, "cat-file", "--batch-all-objects", "--batch"],
                         stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
    n = 0
    out = p.stdout
    while True:
        head = out.readline()
        if not head:
            break
        parts = head.split()
        if len(parts) != 3:
            raise ValueError("unexpected cat-file header")
        size = int(parts[2])
        data = out.read(size)
        out.read(1)
        n += 1
        for label, v in vals:
            if v in data:
                hits[label].append(parts[0].decode())
    if p.wait() != 0:
        raise ValueError("git cat-file failed")
    if n == 0:
        raise ValueError("no object read")
    return n, hits


def scan_dir(path, vals):
    if not os.path.isdir(path):
        raise ValueError("not a directory")
    hits = {label: [] for label, _ in vals}
    keep = max([len(v) for _, v in vals] + [1]) - 1
    n = 0
    for root, _dirs, files in os.walk(path):
        for fn in sorted(files):
            fp = os.path.join(root, fn)
            if not os.path.isfile(fp) or os.path.islink(fp):
                continue
            n += 1
            found, tail = set(), b""
            with open(fp, "rb") as f:
                while True:
                    block = f.read(CHUNK)
                    if not block:
                        break
                    buf = tail + block
                    for label, v in vals:
                        if v in buf:
                            found.add(label)
                    tail = buf[-keep:] if keep else b""
            rel = os.path.relpath(fp, path)
            raw = rel.encode("utf-8", "surrogateescape")
            shown = "(a path that holds a value)" if any(v in raw for _, v in vals) else rel
            for label in found:
                hits[label].append(shown)
    if n == 0:
        raise ValueError("no file read")
    return n, hits


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--repo", action="append", default=[])
    ap.add_argument("--dir", action="append", default=[])
    ap.add_argument("--session-transcripts", action="store_true")
    ap.add_argument("--guard-log", action="store_true")
    a = ap.parse_args()
    if a.session_transcripts:
        home = os.environ.get("DEVOS_AUDIT_HOME") or os.path.expanduser("~")
        a.dir.append(os.path.join(home, ".claude", "projects"))
    if a.guard_log:
        a.dir.append(os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard")
    try:
        vals, notes = values(dict(os.environ))
    except (OSError, SyntaxError, ValueError) as e:
        print(f"CREDENTIAL_VALUE_SCAN ERROR: the values could not be taken ({type(e).__name__})")
        return 2
    print("Values searched for:" + ("" if vals else " none"))
    for label, v in vals:
        print(f"  {label}: length {len(v)}")
    for line in notes:
        print("  (" + line + ")")
    ok = True
    for kind, paths, fn in (("repository", a.repo, scan_repo), ("directory", a.dir, scan_dir)):
        for path in paths:
            try:
                n, hits = fn(path, vals)
            except (OSError, ValueError) as e:
                print(f"{kind} {path}: ERROR, not read ({type(e).__name__})")
                ok = False
                continue
            unit = "objects" if kind == "repository" else "files"
            print(f"{kind} {path}: {n} {unit} read")
            for label, _ in vals:
                where = hits[label]
                print(f"  {label}: {len(where)} {unit} hold it" + (": " + ", ".join(where) if where else ""))
    print("CREDENTIAL_VALUE_SCAN " + ("DONE" if ok else "INCOMPLETE"))
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(main())
