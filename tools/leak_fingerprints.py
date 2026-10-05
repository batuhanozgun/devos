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

Normalisation, hashing and the service-name derivation are the guard's own functions, imported from the guard
file of this checkout, so the store and the check cannot drift apart. The guard protects LEAK_STORE from writes
(B5, F5); this script is the only writer.
Usage: python3 tools/leak_fingerprints.py build [--devos PATH] | status | scan FILE...
"""
import argparse
import array
import bisect
import importlib.util
import json
import os
import secrets
import subprocess
import sys
from datetime import datetime, timezone

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_guard():
    spec = importlib.util.spec_from_file_location("devos_guard", os.path.join(REPO, ".claude", "hooks",
                                                                              "tool_allowlist.py"))
    g = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(g)
    return g


def git(repo, *args):
    return subprocess.run(["git", "-C", repo, *args], capture_output=True, check=True).stdout


def tree_texts(repo, rev):
    """The text of every non-binary file in rev's tree."""
    shas = []
    for entry in git(repo, "ls-tree", "-r", "-z", rev).split(b"\0"):
        meta = entry.split(b"\t", 1)[0].split()
        if len(meta) == 3 and meta[1] == b"blob":
            shas.append(meta[2])
    p = subprocess.Popen(["git", "-C", repo, "cat-file", "--batch"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    for sha in dict.fromkeys(shas):
        p.stdin.write(sha + b"\n")
        p.stdin.flush()
        size = int(p.stdout.readline().split()[2])
        data = p.stdout.read(size)
        p.stdout.read(1)
        if b"\0" not in data[:8000]:
            yield data.decode("utf-8", "replace")
    p.stdin.close()
    p.wait()


def build(g, devos):
    lib = g.LIBRARY_DIR
    head = g.library_head()
    if not head:
        sys.exit(f"no library clone at {lib}: clone it there first (the only place the guard allows)")
    if not git(lib, "branch", "-r", "--contains", head).strip():
        sys.exit(f"the clone's HEAD {head[:12]} is on none of its remote branches: the library is read-only; "
                 "check out a revision of its remote and build again")
    main = git(devos, "rev-parse", "--verify", "refs/remotes/origin/main^{commit}").decode().strip()
    salt = secrets.token_bytes(32)
    prints = set()
    for text in tree_texts(lib, head):
        prints.update(g.leak_hashes(g.leak_words(text), salt))
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
            "library_dir": os.path.realpath(lib), "library_head": head, "devos_main": main,
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


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    b = sub.add_parser("build")
    b.add_argument("--devos", default=REPO, help="the devos checkout whose origin/main is excluded (default: this one)")
    sub.add_parser("status")
    s = sub.add_parser("scan")
    s.add_argument("files", nargs="+")
    a = ap.parse_args()
    g = load_guard()
    if a.cmd == "build":
        build(g, a.devos)
    elif a.cmd == "status":
        status(g)
    else:
        return scan(g, a.files)
    return 0


if __name__ == "__main__":
    sys.exit(main())
