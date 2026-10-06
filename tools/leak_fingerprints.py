#!/usr/bin/env python3
"""The leak check's fingerprint store (W-C00-14; plan 0.5 item 3, K-9 item 5, 6.7; guard rule L1).

build   Reads every text file at the HEAD of the research library clone (the one place the guard allows,
        LIBRARY_DIR), hashes every run of SHINGLE_WORDS normalised words with a fresh random salt, drops the hashes
        that also occur in the origin/main tree of devos (text already public does not count; their number is
        printed, the retroactive scan's first result), and writes the store to LEAK_STORE, outside every
        repository. The store holds sorted salted 64-bit hashes, the salt and counts, never text.
status  Prints the clone's and the store's state and the number of service-name terms; never text or names.
scan    Prints, for each file given, the line numbers where a matching run starts or a service is named; never
        the text. Use it to find what an L1 denial matched.
history The one-time history scan (N-084; plan 0.5 note, 6.7). Fingerprints the library clone's HEAD in memory
        only, with a fresh salt and nothing dropped (it writes no file and never reads or writes LEAK_STORE). Then
        prints, for REV's tree (default: the origin/main of --devos), each text file's line numbers where a
        matching run starts and its number of matching runs; and, for every commit reachable from REV through all
        parents, read on its own as rule L1 reads a pushed commit (its message, its paths and the lines it adds
        against its first parent, a root commit against the empty tree), the same per path ("message" and "path"
        with a count only) and the number of lines naming a service, never their line numbers (D-013). It prints
        commit IDs, paths, line numbers and counts, never text and never a service name; a path that names a
        service or holds a matching run is printed as withheld. Exit 0 when the scan completed, 2 on an error.

Normalisation, hashing and the service-name derivation are the guard's own functions, imported from the guard
file of this checkout, so the store and the check cannot drift apart. The import writes no bytecode
(sys.dont_write_bytecode), so no command leaves a .claude/hooks/__pycache__ in the checkout. The guard protects
LEAK_STORE from writes (B5, F5); this script is the only writer.
Usage: python3 tools/leak_fingerprints.py build [--devos PATH] | status | scan FILE... |
       history [--devos PATH] [--rev REV]
"""
import argparse
import array
import bisect
import importlib.util
import json
import os
import re
import secrets
import subprocess
import sys
from datetime import datetime, timezone

sys.dont_write_bytecode = True      # importing the guard must leave no .claude/hooks/__pycache__ (CHK-C00-049)
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GIT_OPTS = ("--no-replace-objects", "-c", "core.quotepath=false")   # as the guard reads a push (pushed_blocks)
GIT_TIMEOUT = 300           # seconds, for each git call of history
HUNK = re.compile(rb"@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@")


def load_guard():
    spec = importlib.util.spec_from_file_location("devos_guard", os.path.join(REPO, ".claude", "hooks",
                                                                              "tool_allowlist.py"))
    g = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(g)
    return g


def git(repo, *args, timeout=None, input=None):
    return subprocess.run(["git", "-C", repo, *args], capture_output=True, check=True, timeout=timeout,
                          input=input).stdout


def tree_blobs(repo, rev):
    """(paths, text) for every non-binary blob in rev's tree; a blob at several paths is read once."""
    blobs = {}
    for entry in git(repo, "ls-tree", "-r", "-z", rev).split(b"\0"):
        meta, _, path = entry.partition(b"\t")
        meta = meta.split()
        if len(meta) == 3 and meta[1] == b"blob":
            blobs.setdefault(meta[2], []).append(path.decode("utf-8", "replace"))
    p = subprocess.Popen(["git", "-C", repo, "cat-file", "--batch"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    for sha, paths in blobs.items():
        p.stdin.write(sha + b"\n")
        p.stdin.flush()
        size = int(p.stdout.readline().split()[2])
        data = p.stdout.read(size)
        p.stdout.read(1)
        if b"\0" not in data[:8000]:
            yield paths, data.decode("utf-8", "replace")
    p.stdin.close()
    p.wait()


def tree_texts(repo, rev):
    """The text of every non-binary file in rev's tree."""
    return (text for _, text in tree_blobs(repo, rev))


def library_prints(g):
    """(HEAD, salt, fingerprints): every run of the text files at the library clone's HEAD, hashed with a fresh
    random salt, in memory. ValueError when there is no clone or its HEAD is on none of its remote branches."""
    lib = g.LIBRARY_DIR
    head = g.library_head()
    if not head:
        raise ValueError(f"no library clone at {lib}: clone it there first (the only place the guard allows)")
    if not git(lib, "branch", "-r", "--contains", head).strip():
        raise ValueError(f"the clone's HEAD {head[:12]} is on none of its remote branches: the library is "
                         "read-only; check out a revision of its remote and run again")
    salt = secrets.token_bytes(32)
    prints = set()
    for text in tree_texts(lib, head):
        prints.update(g.leak_hashes(g.leak_words(text), salt))
    return head, salt, prints


def build(g, devos):
    try:
        head, salt, prints = library_prints(g)
    except ValueError as exc:
        sys.exit(str(exc))
    main = git(devos, "rev-parse", "--verify", "refs/remotes/origin/main^{commit}").decode().strip()
    library_total, excluded, files = len(prints), 0, 0
    for text in tree_texts(devos, main):
        common = prints.intersection(g.leak_hashes(g.leak_words(text), salt))
        if common:
            files += 1
            excluded += len(common)
            prints -= common
    os.makedirs(g.LEAK_STORE, mode=0o700, exist_ok=True)
    fp = os.path.join(g.LEAK_STORE, "fingerprints.bin")
    with open(fp + ".tmp", "wb") as f:
        array.array("Q", sorted(prints)).tofile(f)
    os.replace(fp + ".tmp", fp)          # the old meta no longer fits the new file's size: fails closed meanwhile
    meta = {"version": g.STORE_VERSION, "shingle_words": g.SHINGLE_WORDS, "byteorder": sys.byteorder,
            "library_dir": os.path.realpath(g.LIBRARY_DIR), "library_head": head, "devos_main": main,
            "count": len(prints), "library_runs": library_total, "excluded_on_main": excluded,
            "excluded_files": files, "salt": salt.hex(),
            "built": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")}
    mp = os.path.join(g.LEAK_STORE, "meta.json")
    with open(mp + ".tmp", "w") as f:
        json.dump(meta, f)
    os.replace(mp + ".tmp", mp)
    print(f"LEAK STORE BUILT: {len(prints)} fingerprints of {g.SHINGLE_WORDS}-word runs from library HEAD {head[:12]}; "
          f"{excluded} excluded as already on devos origin/main {main[:12]} (in {files} file(s))")


def status(g):
    head = g.library_head()
    print(f"library clone: {'absent' if head is None else 'unreadable' if not head else 'HEAD ' + head[:12]} "
          f"({g.LIBRARY_DIR})")
    try:
        store = g.read_store()
        if store is None:
            print(f"store: absent ({g.LEAK_STORE})")
    except ValueError as exc:
        store = None
        print(f"store: unreadable: {exc}")
    if store:
        m = store[0]
        print(f"store: {m['count']} fingerprints of {m['shingle_words']}-word runs, built {m['built']} from library "
              f"HEAD {m['library_head'][:12]}; {m['excluded_on_main']} excluded as already on devos origin/main "
              f"{m['devos_main'][:12]} (in {m['excluded_files']} file(s)) ({g.LEAK_STORE})")
    try:
        g.leak_state()
        print("public writes: checked" + ("" if store else " for service names only (no clone, no store)"))
    except g.Bad as b:
        print(f"public writes: fail closed: {b.detail}")
    print(f"service-name terms: {len(g.service_term_list())} (derived from {g.SERVICE_REV}, as "
          "tools/check_service_names.sh)")


def scan(g, paths):
    try:
        store = g.read_store()
    except ValueError:
        store = None
    pat, hits = g.service_pattern(), 0
    view = store[2] if store else ()
    for path in paths:
        with open(path, encoding="utf-8", errors="replace") as f:
            lines = f.read().split("\n")
        words, at = [], []
        for k, line in enumerate(lines, 1):
            w = g.leak_words(line)
            words += w
            at += [k] * len(w)
        starts = set()
        if store:
            for i, h in enumerate(g.leak_hashes(words, store[1])):
                j = bisect.bisect_left(view, h)
                if j < len(view) and view[j] == h:
                    starts.add(at[i])
        for k, line in enumerate(lines, 1):
            kinds = (["a matching run of the library starts here"] if k in starts else []) + \
                    (["names a service"] if pat.search(line) else [])
            if kinds:
                hits += 1
                print(f"{path}:{k}: {' and '.join(kinds)}")
    print(f"SCAN: {hits} line(s) matched" + ("" if store else " (no store: service names only)"))
    return 1 if hits else 0


WITHHELD = "a path whose name is withheld"


def runs(g, lines, salt, prints):
    """Every run of SHINGLE_WORDS words in lines (read as their newline join, as the guard reads a text) whose
    fingerprint is in prints, as (index of the line of its first word, index of the line of its last word, print)."""
    words, at = [], []
    for k, line in enumerate(lines):
        w = g.leak_words(line)
        words += w
        at += [k] * len(w)
    n = g.SHINGLE_WORDS
    return [(at[i], at[i + n - 1], h) for i, h in enumerate(g.leak_hashes(words, salt)) if h in prints]


def hidden(g, names, salt, prints, pat):
    """The indices of the names that name a service or hold a word of a matching run (a run may span names)."""
    out = {k for k, name in enumerate(names) if pat.search(name)}
    for a, b, _ in runs(g, names, salt, prints):
        out.update(range(a, b + 1))
    return out


def service_lines(pat, text):
    """The distinct lines of text that name a service, counted as the guard counts them (service_hits), without
    its exclusion of the lines already on origin/main."""
    return len({line for line in text.splitlines() if pat.search(line)})


def numbers(values):
    return ", ".join(str(v) for v in sorted(set(values)))


def read_commits(g, repo, commits):
    """(sha, commit time, message, files) for each commit, read on its own as rule L1 reads a pushed commit (the
    guard's pushed_blocks): the message from cat-file's sized record, decoded by its encoding header; files maps
    each path of the commit's diff against its first parent (a root commit against the empty tree), named
    "a/X b/X" as in the diff header, to the lines the commit adds to it, each as (its line number in the commit's
    version of the file, its text). Every file is read as text."""
    out = git(repo, *GIT_OPTS, "cat-file", "--batch", timeout=GIT_TIMEOUT,
              input="".join(c + "\n" for c in commits).encode())
    i = 0
    for sha in commits:
        j = out.find(b"\n", i)
        head = out[i:j].split() if j >= 0 else []
        if len(head) != 3 or head[0] != sha.encode() or head[1] != b"commit" or not head[2].isdigit():
            raise ValueError(f"git cat-file did not return commit {sha[:12]}")
        obj, i = out[j + 1:j + 1 + int(head[2])], j + 2 + int(head[2])
        hdr, _, msg = obj.partition(b"\n\n")
        hdr = [x.partition(b" ") for x in hdr.split(b"\n") if not x.startswith(b" ")]
        parents = [v.decode() for k, _, v in hdr if k == b"parent"]
        when = next((int(m.group(1)) for k, _, v in hdr if k == b"committer"
                     for m in [re.search(rb" (\d+) [+-]\d{4}$", v)] if m), 0)
        enc = next((v.decode("ascii", "replace") for k, _, v in hdr if k == b"encoding"), "utf-8")
        try:
            msg = msg.decode(enc, "replace")
        except LookupError:
            msg = msg.decode("utf-8", "replace")
        d = git(repo, *GIT_OPTS, "diff-tree", "-p", "--text", "--no-color", "--no-ext-diff", "--no-textconv",
                "--no-renames", "--src-prefix=a/", "--dst-prefix=b/",
                parents[0] if parents else g.EMPTY_TREE.get(len(sha), ""), sha, "--", timeout=GIT_TIMEOUT)
        files, cur, new = {}, None, None
        for line in d.split(b"\n"):
            if line.startswith(b"diff --git "):
                cur, new = line[len(b"diff --git "):].decode("utf-8", "replace"), None
                files.setdefault(cur, [])
            elif line.startswith(b"@@") and cur is not None:
                m = HUNK.match(line)
                if not m:
                    raise ValueError(f"a hunk header of commit {sha[:12]} cannot be read")
                new = int(m.group(1))
            elif new is not None and line.startswith(b"+"):
                files[cur].append((new, line[1:].decode("utf-8", "replace")))
                new += 1
            elif new is not None and line.startswith(b" "):
                new += 1
        yield sha, when, msg, files


def history(g, devos, rev):
    r = subprocess.run(["git", "-C", devos, "rev-parse", "-q", "--verify", rev + "^{commit}"], capture_output=True)
    if r.returncode != 0:
        raise ValueError(f"no commit {rev} in {devos} (fetch first, or name one with --rev)")
    tip = r.stdout.decode().strip()
    pat = g.service_pattern()
    head, salt, prints = library_prints(g)
    print(f"LIBRARY: {len(prints)} fingerprints of {g.SHINGLE_WORDS}-word runs from the clone at {g.LIBRARY_DIR}, "
          f"HEAD {head}; built in memory only, nothing dropped, no file written")

    print(f"TREE {tip}: each text file where a matching run starts (line numbers), with its number of matching runs")
    found, seen, texts, total = [], set(), 0, 0
    for paths, text in tree_blobs(devos, tip):
        texts += len(paths)
        hits = runs(g, text.split("\n"), salt, prints)
        if hits:
            seen.update(h for _, _, h in hits)
            total += len(hits) * len(paths)
            where = f"line(s) {numbers(a + 1 for a, _, _ in hits)} ({len(hits)} run(s))"
            found += [(bool(hidden(g, [p], salt, prints, pat)), p, where) for p in paths]
    for withheld, p, where in sorted(found):
        print(f"  {WITHHELD if withheld else p}: {where}")
    print(f"TREE: {len(found)} of {texts} text file(s) hold matching runs; {total} matching run(s), "
          f"{len(seen)} distinct fingerprint(s)")

    commits = git(devos, *GIT_OPTS, "rev-list", "--date-order", "--reverse", tip, "--",
                  timeout=GIT_TIMEOUT).decode().split()
    print(f"HISTORY: {len(commits)} commit(s) reachable from {tip} through all parents, oldest first, each read on its "
          "own as rule L1 reads a pushed commit: its message, its paths and the lines it adds against its first "
          "parent (a root commit against the empty tree); line numbers are in that commit's version of the file")
    library, service = [], 0
    for k, (sha, when, msg, files) in enumerate(read_commits(g, devos, commits), 1):
        out, names = [], list(files)
        n = len(runs(g, msg.split("\n"), salt, prints))
        out += [f"message: {n} run(s)"] if n else []
        n = len(runs(g, names, salt, prints))
        out += [f"path: {n} run(s)"] if n else []
        hide = hidden(g, names, salt, prints, pat)
        for i, name in enumerate(names):
            added = files[name]
            hits = runs(g, [t for _, t in added], salt, prints)
            if hits:
                out.append(f"{WITHHELD if i in hide else name.rsplit(' b/', 1)[-1]}: "
                           f"line(s) {numbers(added[a][0] for a, _, _ in hits)} ({len(hits)} run(s))")
        if out:
            library.append((sha, when))
        n = service_lines(pat, msg) + service_lines(pat, "\n".join(names)) + \
            sum(service_lines(pat, "\n".join(t for _, t in a)) for a in files.values())
        if n:
            service += 1
            out.append(f"service names: {n} line(s)")
        if out:
            print(f"commit {sha}\n" + "\n".join("  " + o for o in out))
        if k % 50 == 0:
            print(f"history: {k} of {len(commits)} commits read", file=sys.stderr, flush=True)

    def at(c):
        return f"{c[0]} (committed {datetime.fromtimestamp(c[1], timezone.utc):%Y-%m-%dT%H:%M:%SZ})"
    span = f"earliest {at(library[0])}, latest {at(library[-1])}" if library else "none"
    print(f"SUMMARY: {len(commits)} commit(s) scanned; {len(library)} with library matches; {service} with "
          f"service-name matches; library matches: {span}")
    return 0


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    b = sub.add_parser("build")
    b.add_argument("--devos", default=REPO, help="the devos checkout whose origin/main is excluded (default: this one)")
    sub.add_parser("status")
    s = sub.add_parser("scan")
    s.add_argument("files", nargs="+")
    h = sub.add_parser("history")
    h.add_argument("--devos", default=REPO, help="the devos checkout to scan (default: this one)")
    h.add_argument("--rev", default="refs/remotes/origin/main", help="the revision whose tree and history are "
                   "scanned (default: origin/main)")
    a = ap.parse_args()
    g = load_guard()
    if a.cmd == "build":
        build(g, a.devos)
    elif a.cmd == "status":
        status(g)
    elif a.cmd == "history":
        try:
            return history(g, a.devos, a.rev)
        except (OSError, ValueError, subprocess.SubprocessError) as exc:
            print(f"HISTORY FAILED: {type(exc).__name__}: {exc}", file=sys.stderr)
            return 2
        except Exception as exc:          # its message is not shown: it could hold a path or text
            print(f"HISTORY FAILED: {type(exc).__name__}", file=sys.stderr)
            return 2
    else:
        return scan(g, a.files)
    return 0


if __name__ == "__main__":
    sys.exit(main())
