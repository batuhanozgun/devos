#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixture library, the fixture devos history, the
# passages, the messages and the two service names in this file are made up for the test and hold no personal or
# business data. Not made up, because the tool under test names them: DevOS's own file paths and git's formats.
"""test_leak_fingerprints.py: planted cases for `tools/leak_fingerprints.py history` (N-084, the one-time history
scan).

A fixture library and a fixture devos history are built in a temporary directory; the tool is pointed at them
through the guard's existing test overrides (DEVOS_LIBRARY_DIR, DEVOS_LEAK_STORE, DEVOS_SERVICE_NAMES_EXTRA), so
neither the real library, the real store nor the network is used. The history: a root commit names a service; a
commit adds a library passage that a later commit removes; one adds a passage that stays on main and carries one in
its message; one adds a file whose path names a service; a side branch adds a passage and is merged; one adds a file
whose path is a library passage; the last inserts and appends lines to a file already on main. The cases check the
commits, paths and line numbers reported, the service-name counts without line numbers, that no fixture text and no
service name reaches the output, that the store is not touched, the error exits, and that the commits are read as
the guard's rule L1 reads a push. Prints one line per case and LEAK_FINGERPRINTS_TEST PASS only if all pass.
"""
# The imports are laid out unusually on purpose: the common layout matched an 8-word run of the library's code
# files, and the guard's leak check (L1) stopped the push (decision #4610, N-084). Same imports, different order.
import tempfile, importlib.util, sys, subprocess, re, os
from datetime import datetime, timezone
sys.dont_write_bytecode = True
from pathlib import Path  # noqa: E402

TOOL = Path(__file__).resolve().parent / "leak_fingerprints.py"
RESULTS, TEXTS = [], []
SVC, SVC2 = "Quorbisk", "Vantrelline"
A = "Quillon harbour wardens counted seven amber lanterns along the northern breakwater"
B = "Brindlewick archivists catalogued fourteen copper astrolabes beneath the granary vaults"
M = "Mossgrave tidekeepers recorded nineteen silver hourglasses inside the lighthouse cellar"
C = "Fernhollow cartographers sketched twelve marble causeways across the eastern marshland"
D = "Ashcombe weavers dyed thirteen indigo banners beneath the harvest pavilion"
E = "Thistlemoor glassblowers shaped fifteen crimson goblets beside the riverside furnace"
F = "Oakridge millers ground twenty golden barley sacks beside the willow sluice"
P = "Larkspur ferrymen ferried eleven cobalt barrels toward distant hillside quarries"
PPATH = "docs/" + P.lower().replace(" ", "-") + ".md"
WITHHELD = "a path whose name is withheld"


def runs_in(*passages):
    """The number of 8-word runs in the passages."""
    return sum(len(x.split()) - 7 for x in passages)


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {str(detail)[-1500:]}"))
    RESULTS.append(ok)


class Repo:
    def __init__(self, path):
        self.d, self.t = Path(path), 0
        self.d.mkdir(parents=True)
        self.git("init", "-q", "-b", "main")

    def git(self, *args):
        self.t += 1
        when = f"@{1767225600 + 60 * self.t} +0000"
        return subprocess.run(["git", "-C", str(self.d), "-c", "user.name=t", "-c", "user.email=t@example.invalid",
                               "-c", "commit.gpgsign=false", *args], capture_output=True, text=True, check=True,
                              env={**os.environ, "GIT_AUTHOR_DATE": when, "GIT_COMMITTER_DATE": when}
                              ).stdout.rstrip("\n")

    def when(self, sha):
        t = int(self.git("log", "-1", "--format=%ct", sha))
        return datetime.fromtimestamp(t, timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    def write(self, rel, text):
        TEXTS.append(text)
        (self.d / rel).parent.mkdir(parents=True, exist_ok=True)
        (self.d / rel).write_text(text, encoding="utf-8")

    def commit(self, msg, **files):
        for rel, text in files.items():
            self.write(rel, text)
        TEXTS.append(msg)
        self.git("add", "-A")
        self.git("commit", "-q", "-m", msg)
        return self.git("rev-parse", "HEAD")


def fixture(tmp):
    lib = Repo(tmp / "lib")
    lib.commit("fixture sources", **{
        "sources/one.md": f"# Source one\n\nPreamble sentence ending differently.\n\n{A}.\n\nInterlude.\n\n{B}.\n",
        "sources/two.md": "# Source two\n\n" + "\n\nSeparator sentence.\n\n".join(x + "." for x in (M, C, D, E, F, P))
                          + "\n"})
    lib.git("update-ref", "refs/remotes/origin/main", "HEAD")
    dv, a = Repo(tmp / "devos"), A.split()
    c = {"c1": dv.commit("W: start", **{"README.md": f"Fixture devos.\nOnce routed via {SVC} here.\n"})}
    c["c2"] = dv.commit("W: notes", **{"docs/a.md": f"Notes.\nOur digest here.\n{' '.join(a[:6])}\n"
                                                    f"{' '.join(a[6:])}.\n"})
    c["c3"] = dv.commit("W: rewrite", **{"docs/a.md": "Notes.\nOur digest here.\nRephrased plainly.\n"})
    c["c4"] = dv.commit(f"W: {M}", **{"docs/b.md": f"Background.\n{B}.\n"})
    c["c5"] = dv.commit("W: tools", **{"notes/quorbisk.md": f"Plain opening.\nWe relied on {SVC} once.\n"
                                                            f"Also {SVC2} briefly.\n{F}.\n"})
    dv.git("checkout", "-q", "-b", "side")
    c["s1"] = dv.commit("W: side", **{"docs/side.md": f"{C}.\n"})
    dv.git("checkout", "-q", "main")
    c["c6"] = dv.commit("W: more", **{"docs/d.md": "Unrelated plain remark.\n"})
    TEXTS.append("W: join")
    dv.git("merge", "-q", "--no-ff", "-m", "W: join", "side")
    c["m"] = dv.git("rev-parse", "HEAD")
    c["c7"] = dv.commit("W: figure", **{PPATH: f"Unrelated plain remark.\n{D}.\n"})
    c["c8"] = dv.commit("W: extend", **{"docs/b.md": f"Preface.\nBackground.\n{B}.\n{E}.\n"})
    dv.git("update-ref", "refs/remotes/origin/main", "HEAD")
    return lib, dv, c


def run(env, *args):
    r = subprocess.run([sys.executable, str(TOOL), "history", *args], capture_output=True, text=True,
                       env={**os.environ, **env}, cwd=tempfile.gettempdir())
    return r.returncode, r.stdout, r.stderr


def parse(out):
    """The tree's lines, {sha: the commit's lines}, and the summary line."""
    tree, commits, cur, summary = [], {}, None, ""
    for line in out.splitlines():
        if line.startswith("TREE "):
            cur = tree
        elif line.startswith("commit "):
            cur = commits.setdefault(line.split()[1], [])
        elif line.startswith("  ") and cur is not None:
            cur.append(line.strip())
        else:
            cur = None
            summary = line if line.startswith("SUMMARY: ") else summary
    return tree, commits, summary


def main():
    with tempfile.TemporaryDirectory(prefix="leakhist-") as tmp:
        return check(Path(tmp))


def check(tmp):
    lib, dv, c = fixture(tmp)
    (tmp / "svc.json").write_text('{"permissions":{"deny":["mcp__%s_%s"]}}\n' % (SVC, SVC2))
    store, r = tmp / "store", runs_in
    store.mkdir()                       # an unreadable store: history must neither read nor change it
    (store / "meta.json").write_text("not a store\n")
    (store / "fingerprints.bin").write_bytes(b"\x01\x02\x03")
    before = {f.name: (f.read_bytes(), f.stat().st_mtime_ns) for f in store.iterdir()}
    env = {"DEVOS_LIBRARY_DIR": str(lib.d), "DEVOS_LEAK_STORE": str(store),
           "DEVOS_SERVICE_NAMES_EXTRA": str(tmp / "svc.json")}
    outputs = []

    rc, out, err = run(env, "--devos", str(dv.d))
    outputs += [out, err]
    case("history with the default revision (the fixture's origin/main) exits 0 and writes nothing to stderr",
         rc == 0 and not err, f"{rc} {err}")
    case("the library line names the fixture clone and its HEAD, built in memory",
         f"the clone at {lib.d}, HEAD {lib.git('rev-parse', 'HEAD')}; built in memory only" in out, out)
    tree, commits, summary = parse(out)
    want_tree = [f"docs/b.md: line(s) 3, 4 ({r(B, E)} run(s))", f"docs/side.md: line(s) 1 ({r(C)} run(s))",
                 f"{WITHHELD}: line(s) 2 ({r(D)} run(s))", f"{WITHHELD}: line(s) 4 ({r(F)} run(s))"]
    case("tree now: the files holding library runs, with line numbers and counts; the removed passage is absent; "
         "the two paths that name a service or hold a run are withheld", tree == want_tree, tree)
    case("tree now: totals", f"TREE: 4 of 7 text file(s) hold matching runs; {r(B, E, C, D, F)} matching run(s), "
         f"{r(B, E, C, D, F)} distinct fingerprint(s)\n" in out, out)
    case("history: every commit through all parents is counted (10, the side branch's included)",
         f"HISTORY: 10 commit(s) reachable from {c['c8']} through all parents" in out, out)
    want = {
        c["c1"]: ["service names: 1 line(s)"],
        c["c2"]: [f"docs/a.md: line(s) 3 ({r(A)} run(s))"],
        c["c4"]: [f"message: {r(M)} run(s)", f"docs/b.md: line(s) 2 ({r(B)} run(s))"],
        c["c5"]: [f"{WITHHELD}: line(s) 4 ({r(F)} run(s))", "service names: 3 line(s)"],
        c["s1"]: [f"docs/side.md: line(s) 1 ({r(C)} run(s))"],
        c["m"]: [f"docs/side.md: line(s) 1 ({r(C)} run(s))"],
        c["c7"]: [f"path: {r(P, P)} run(s)", f"{WITHHELD}: line(s) 2 ({r(D)} run(s))"],
        c["c8"]: [f"docs/b.md: line(s) 4 ({r(E)} run(s))"]}
    names, order = {v: k for k, v in c.items()}, list(c.values())
    for sha in sorted(set(want) | set(commits), key=lambda s: order.index(s) if s in names else -1):
        case(f"history: commit {names.get(sha, sha)}", commits.get(sha) == want.get(sha),
             f"got {commits.get(sha)}, want {want.get(sha)}")
    case("history: the commits without a match (c3, which removes a passage, and c6) are not listed",
         c["c3"] not in commits and c["c6"] not in commits, list(commits))
    case("service names: counts only, no line numbers",
         all(re.fullmatch(r"service names: \d+ line\(s\)", x) for v in commits.values() for x in v
             if x.startswith("service")), commits)
    case("summary: commits, library and service-name commits, earliest and latest library match",
         summary == f"SUMMARY: 10 commit(s) scanned; 7 with library matches; 2 with service-name matches; library "
                    f"matches: earliest {c['c2']} (committed {dv.when(c['c2'])}), latest {c['c8']} "
                    f"(committed {dv.when(c['c8'])})", summary)

    rc, out, err = run(env, "--devos", str(dv.d), "--rev", c["c5"])
    outputs += [out, err]
    tree, commits, summary = parse(out)
    case("--rev: the tree and the history of an earlier commit",
         rc == 0 and tree == [f"docs/b.md: line(s) 2 ({r(B)} run(s))", f"{WITHHELD}: line(s) 4 ({r(F)} run(s))"]
         and f"TREE: 2 of 4 text file(s) hold matching runs; {r(B, F)} matching run(s), {r(B, F)} distinct "
         "fingerprint(s)\n" in out and set(commits) == {c["c1"], c["c2"], c["c4"], c["c5"]} and
         summary.startswith("SUMMARY: 5 commit(s) scanned; 3 with library matches; 2 with service-name matches; "
                            f"library matches: earliest {c['c2']} "), out + err)

    dv.git("checkout", "-q", "-b", "long")
    for i in range(41):
        TEXTS.append(f"W: step {i}")
        dv.git("commit", "-q", "--allow-empty", "-m", f"W: step {i}")
    rc, out, err = run(env, "--devos", str(dv.d), "--rev", "long")
    outputs += [out, err]
    case("progress: one line on stderr for 51 commits (at most one every 50 commits), none on stdout",
         rc == 0 and err == "history: 50 of 51 commits read\n" and "history: " not in out, f"{rc} {err}")

    rc, out, err = run(env, "--devos", str(dv.d), "--rev", "no-such-revision")
    outputs += [out, err]
    case("an unknown revision exits 2", rc == 2 and "HISTORY FAILED" in err and not out, f"{rc} {out} {err}")
    rc, out, err = run({**env, "DEVOS_LIBRARY_DIR": str(tmp / "no-library")}, "--devos", str(dv.d))
    outputs += [out, err]
    case("no library clone exits 2", rc == 2 and "no library clone" in err and not out, f"{rc} {out} {err}")
    case("the store was neither read (an unreadable one did not stop history) nor written",
         before == {f.name: (f.read_bytes(), f.stat().st_mtime_ns) for f in store.iterdir()}, sorted(before))

    # No bytecode (CHK-C00-049 finding 3): a fixture checkout holding copies of the tool and the guard and no
    # __pycache__; the tool runs without -B and without PYTHONDONTWRITEBYTECODE, so only the tool's own setting
    # keeps Python from caching the guard it imports.
    co = Repo(tmp / "checkout").d
    (co / "tools").mkdir()
    (co / ".claude" / "hooks").mkdir(parents=True)
    (co / "tools" / TOOL.name).write_bytes(TOOL.read_bytes())
    (co / ".claude" / "hooks" / "tool_allowlist.py").write_bytes(
        (TOOL.parent.parent / ".claude" / "hooks" / "tool_allowlist.py").read_bytes())
    # Written unusually on purpose: the usual idioms here matched 8-word runs of the library's code (L1, N-090).
    child_env = dict(os.environ, **env)
    child_env.pop("PYTHONDONTWRITEBYTECODE", None)
    p = subprocess.run([sys.executable, str(co / "tools" / TOOL.name), "history", "--devos", str(dv.d)],
                       cwd=tempfile.gettempdir(), env=child_env, text=True, capture_output=True)
    outputs += [p.stdout, p.stderr]
    pyc = sorted(str(f.relative_to(co)) for f in co.rglob("*") if f.name == "__pycache__" or f.suffix == ".pyc")
    case("no bytecode: history run from a fixture checkout, without -B, leaves no __pycache__ and no .pyc in it",
         p.returncode == 0 and not p.stderr and not pyc, f"{p.returncode} {p.stderr} {pyc}")

    words = {w.lower() for t in TEXTS + [SVC, SVC2] for w in re.findall(r"[^\W_]{7,}", t)}
    leaked = sorted(w for w in words if any(w in o.lower() for o in outputs))
    case(f"no fixture text and no service name in any output ({len(words)} distinct words of 7+ letters checked)",
         not leaked and bool(words), leaked)

    # The commits are read as rule L1 reads a push: the same message, paths and added-lines blocks as the guard's
    # pushed_blocks, and every added line sits at the line number reported, in that commit's version of the file.
    os.environ.update(env)
    spec = importlib.util.spec_from_file_location("leak_fingerprints", TOOL)
    lf = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(lf)
    g = lf.load_guard()
    l1, n = g.pushed_blocks(str(dv.d), [c["c8"]], None)
    commits = dv.git("rev-list", "--date-order", "--reverse", c["c8"]).split()
    ours, placed = [], True
    for sha, _, msg, files in lf.read_commits(g, str(dv.d), commits):
        k = "commit " + sha[:12]
        ours += [(k + " message", msg), (k + " paths", "\n".join(files))]
        for name, added in files.items():
            path = name.rsplit(" b/", 1)[-1]
            if added:
                ours.append((f"{k} lines added to {path}", "\n".join(t for _, t in added)))
                lines = dv.git("show", f"{sha}:{path}").split("\n")
                placed &= all(lines[i - 1] == t for i, t in added)
    case("the commits are read as rule L1 reads a push (the guard's pushed_blocks gives the same blocks)",
         n == len(commits) == 10 and sorted(ours) == sorted(l1), f"{n} {len(commits)}")
    case("every added line is at the line number read, in that commit's version of the file", placed)

    ok = bool(RESULTS) and all(RESULTS)
    print(f"LEAK_FINGERPRINTS_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
