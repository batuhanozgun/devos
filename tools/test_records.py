#!/usr/bin/env python3
"""Gate tests of W-C00-12 tranche 1b-i (T-W10, T-W15, T-W2, T-W5, T-W7, T-W12), with two mutation checks.

Run from the repository root:  python3 tools/test_records.py [--base <commit>]
The procedures are those of plan/builder/w-c00-12/11_test_register.md section 2.2, made concrete in
plan/builder/w-c00-12/14_tranche_1b-i_intent.md section 3. Scratch fixtures live in a temporary
directory, never in the working tree. Prints one PASS or FAIL line per test, then GATE 1b-i PASS or FAIL.
"""
import argparse
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
sys.path.insert(0, str(Path(__file__).resolve().parent))
import records as R  # noqa: E402

results = []


def report(name, ok, detail=""):
    results.append((name, ok))
    print(f"{'PASS' if ok else 'FAIL'}  {name}" + (f": {detail}" if detail else ""))


def git_show(rev, path):
    return subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True, text=True, check=True).stdout


# ---------------------------------------------------------------- T-W10

def source_cells(base_ledger):
    sec2 = base_ledger.split("## 2. Work list: C00", 1)[1].split("\n---", 1)[0]
    out = {}
    for line in sec2.splitlines():
        if line.startswith("| W-C00-"):
            c = [x.strip() for x in re.split(r"(?<!\\)\|", line.strip())[1:-1]]
            out[c[0]] = c[2].replace("\\|", "|")  # normalise table escaping only
    out["C00"] = base_ledger.split("### C00\n", 1)[1].split("\n---", 1)[0].strip("\n")
    return out


def t_w10(root, base_ledger, label="T-W10"):
    src = source_cells(base_ledger)
    items, _ = R.load_records(root)
    bad = []
    for iid, text in src.items():
        if iid not in items:
            bad.append(f"{iid} missing")
        elif items[iid]["_acceptance"] != text:
            bad.append(f"{iid} differs")
        else:
            print(f"      {label} {iid}: identical ({len(text)} characters)")
    report(label, not bad and len(src) == 13, "; ".join(bad) or f"{len(src)} acceptance blocks byte-identical")


# ---------------------------------------------------------------- fixtures

def fixture(tmp, files):
    root = Path(tmp)
    for d in ("plan/work", "plan/decisions", "plan/ledger"):
        (root / d).mkdir(parents=True, exist_ok=True)
    (root / "plan/work/INSTALL.md").write_text("---\nid: INSTALL\nkind: root\npurpose_chain: [SOUL, DevOS, Installation]\n---\n")
    for name, meta in files.items():
        body = "\n<!-- acceptance -->\nA test item.\n<!-- /acceptance -->\n"
        notes = meta.pop("_notes", "")
        (root / f"plan/work/{name}.md").write_text("---\n" + R.yaml.safe_dump(meta, sort_keys=False) + "---\n" + body + notes)
    return root


def stage(sid, **kw):
    d = {"id": sid, "kind": "stage", "parent": "INSTALL", "title": f"Stage {sid}", "admission": "admitted",
         "execution": kw.pop("execution", "planned")}
    d.update(kw)
    return d


def item(iid, parent, **kw):
    d = {"id": iid, "kind": "item", "parent": parent, "title": f"Item {iid}", "admission": "admitted",
         "execution": "planned", "acceptance": "proposed"}
    d.update(kw)
    return d


def frontier_of(root):
    items, decisions = R.load_records(root)
    ch = R.record_changes(root)
    return R.view_frontier(items, decisions, ch), items, decisions, ch


def ready_ids(frontier):
    sec = frontier.split("**Running:**", 1)[0]
    return set(re.findall(r"- `([^`]+)`", sec))


LEDGER_FIXTURE = "# fixture\n\n## 1. Current state\n\n| Item | State | As of |\n|---|---|---|\n\n---\n\n" + \
    "\n\n".join(f"<!-- generated:{n} -->\n(x)\n<!-- /generated -->"
                for n in ("frontier", "zoom", "work-index", "decisions-index", "open-notes")) + "\n"


# ---------------------------------------------------------------- tests

def t_w15(root, label="T-W15"):
    fr, items, decisions, ch = frontier_of(root)
    zoom = R.view_zoom(items, decisions, ch)
    bad = []
    for n in range(6, 12):
        iid = f"W-C00-{n:02d}"
        it = items.get(iid)
        if it is None:
            bad.append(f"{iid} missing")
            continue
        if "W-C00-12" not in [d["id"] for d in R.deps(it)]:
            bad.append(f"{iid} lacks depends_on W-C00-12")
        if iid in ready_ids(fr):
            bad.append(f"{iid} in the frontier")
        zl = [l for l in zoom.splitlines() if f"`{iid}`" in l]
        if not zl or "blocked" not in zl[0] or "W-C00-12" not in zl[0]:
            bad.append(f"{iid} not shown blocked by W-C00-12 in the zoom")
    # The edge layer alone, without the stage hold (critic of 1b-i): each item stays not ready through its edge.
    if not bad:
        c00 = dict(items["C00"])
        c00.pop("hold_until", None)
        no_hold = dict(items, C00=c00)
        for n in range(6, 12):
            r, why = R.readiness(no_hold, decisions, ch, f"W-C00-{n:02d}")
            if r is not False or "W-C00-12" not in why:
                bad.append(f"W-C00-{n:02d} without the stage hold: {r}, {why}")
    report(label, not bad, "; ".join(bad) or "W-C00-06 to 11 carry the edge, are not ready, and show blocked by "
           "W-C00-12; with the stage hold removed, each is still not ready through its edge")


def t_w2(tmp):
    root = fixture(tmp, {"C01": stage("C01", execution="running"),
                         "A": item("A", "C01", execution="finished"),
                         "B": item("B", "C01", depends_on=["A"])})
    ledger = root / "plan/ledger.md"
    ledger.write_text(LEDGER_FIXTURE)
    items, decisions = R.load_records(root)
    ledger.write_text(R.render_ledger(ledger.read_text(), items, decisions, R.record_changes(root)))
    first = "B" in ready_ids(ledger.read_text().split("<!-- generated:frontier -->", 1)[1])
    a = (root / "plan/work/A.md").read_text().replace("acceptance: proposed",
                                                     "acceptance: accepted\naccepted_by: evidence/C00/reviews/R-X.md")
    (root / "plan/work/A.md").write_text(a)

    def rerender():
        items, decisions = R.load_records(root)
        ledger.write_text(R.render_ledger(ledger.read_text(), items, decisions, R.record_changes(root)))
        return "B" in ready_ids(ledger.read_text().split("<!-- generated:frontier -->", 1)[1])

    unresolved = rerender()  # accepted_by names a file that does not exist: unknown, not ready
    (root / "evidence/C00/reviews").mkdir(parents=True)
    (root / "evidence/C00/reviews/R-X.md").write_text("verdict: PASS\n")
    second = rerender()
    report("T-W2", (not first) and (not unresolved) and second,
           f"B in frontier before acceptance of A: {first}; with A accepted but accepted_by naming no file: "
           f"{unresolved}; with the verdict file present: {second} (each state from a re-render, with no hand edit "
           "of the generated block; whether the file is a bound verdict is checked by W-R1 in 1b-ii)")


def t_w5(tmp):
    root = fixture(tmp, {"C01": stage("C01", execution="running"),
                         "A": item("A", "C01", acceptance="accepted", execution="finished"),
                         "R": item("R", "C01", execution="running", claimed_by="session_x"),
                         "K": item("K", "C01", admission="candidate", depends_on=["A"])})
    fr, items, decisions, ch = frontier_of(root)
    zoom = R.view_zoom(items, decisions, ch)
    in_front = "`K`" in fr
    zl = [l for l in zoom.splitlines() if "`K`" in l]
    marked = bool(zl) and "candidate" in zl[0]
    report("T-W5", (not in_front) and marked, f"candidate K in frontier: {in_front}; in zoom marked candidate: {marked}")


def t_w7(tmp):
    files = {f"C{n:02d}": stage(f"C{n:02d}", execution="running" if n == 1 else "planned") for n in range(13)}
    files.update({"W-X": item("W-X", "C01", execution="running"),
                  "W-X.1": item("W-X.1", "W-X", execution="running"),
                  "W-X.1.1": item("W-X.1.1", "W-X.1", execution="running", claimed_by="session_x"),
                  "W-X.2": item("W-X.2", "W-X"),
                  "W-X.2.1": item("W-X.2.1", "W-X.2"),
                  "W-Y": item("W-Y", "C01"),
                  "W-Z": item("W-Z", "C02"),
                  "W-Z.1": item("W-Z.1", "W-Z")})
    root = fixture(tmp, files)
    items, decisions = R.load_records(root)
    zoom = R.view_zoom(items, decisions, R.record_changes(root))
    horiz = zoom.split("**Vertical", 1)[0]
    vert = zoom.split("**Vertical", 1)[1]
    stages_ok = all(len(re.findall(rf"^\| `C{n:02d}` \|", horiz, re.M)) == 1 for n in range(13))
    path_ok = all(re.search(rf"`{i}`", vert) for i in ("C01", "W-X", "W-X.1", "W-X.1.1"))
    sib_collapsed = bool(re.search(r"`W-X.2`.*1 children", vert)) and "`W-X.2.1`" not in vert
    c02 = [l for l in horiz.splitlines() if l.startswith("| `C02` |")]
    other_collapsed = "`W-Z`" not in vert and bool(c02) and [x.strip() for x in c02[0].split("|")][4] == "ready 2"
    report("T-W7", stages_ok and path_ok and sib_collapsed and other_collapsed,
           f"13 stages one line each: {stages_ok}; path C01 → W-X → W-X.1 → W-X.1.1 expanded: {path_ok}; "
           f"sibling W-X.2 one line with its child collapsed: {sib_collapsed}; stage C02's items collapsed to counts: "
           f"{other_collapsed}")


def t_w12(tmp):
    root = fixture(tmp, {"C01": stage("C01", execution="running"),
                         "P": item("P", "C01", platform=[{"fact": "x", "status": "untested", "probe": "P-TEST-1"}])})
    fr, *_ = frontier_of(root)
    absent = "P" not in ready_ids(fr)
    line = [l for l in fr.splitlines() if l.startswith("- `P`")]
    names = bool(line) and "P-TEST-1" in line[0] and "'x'" in line[0]
    report("T-W12", absent and names, f"absent from ready: {absent}; frontier names the probe: {names}"
           + (f" ({line[0]})" if line else ""))


def mutations(tmp, base_ledger):
    root = Path(tmp) / "mut"
    shutil.copytree("plan/work", root / "plan/work")
    shutil.copytree("plan/decisions", root / "plan/decisions")
    shutil.copytree("plan/ledger", root / "plan/ledger")
    p = root / "plan/work/W-C00-08.md"
    s = p.read_text()
    i = s.index("<!-- acceptance -->\n") + len("<!-- acceptance -->\n")
    p.write_text(s[:i] + ("a" if s[i] != "a" else "b") + s[i + 1:])
    n0 = len(results)
    t_w10(root, base_ledger, label="M1 (T-W10 on a copy with one acceptance character changed)")
    m1 = results[n0][1] is False
    p.write_text(s)
    q = root / "plan/work/W-C00-09.md"
    q.write_text(q.read_text().replace("depends_on:\n- W-C00-12\n", ""))
    n0 = len(results)
    t_w15(root, label="M2 (T-W15 on a copy with the W-C00-09 edge removed)")
    m2 = results[n0][1] is False
    items, decisions = R.load_records(root)
    hold_still = R.readiness(items, decisions, R.record_changes(root), "W-C00-09")
    del results[-2:]
    report("Mutations fail as they must", m1 and m2,
           f"M1 failed: {m1}; M2 failed: {m2}; W-C00-09 without its edge is still not ready through the stage hold: "
           f"{hold_still}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", default=None, help="base commit of the migration (default: merge-base with origin/main)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "merge-base", "HEAD", "origin/main"], capture_output=True, text=True,
                                    check=True).stdout.strip()
    head = subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True, text=True).stdout.strip()
    print(f"base {base[:7]}; HEAD {head}; working tree {'clean' if not subprocess.run(['git', 'status', '--porcelain'], capture_output=True, text=True).stdout else 'with changes'}")
    base_ledger = git_show(base, "plan/ledger.md")
    t_w10(Path("."), base_ledger)
    t_w15(Path("."))
    for f in (t_w2, t_w5, t_w7, t_w12):
        with tempfile.TemporaryDirectory() as tmp:
            f(tmp)
    with tempfile.TemporaryDirectory() as tmp:
        mutations(tmp, base_ledger)
    ok = all(r[1] for r in results)
    print("GATE 1b-i PASS" if ok else "GATE 1b-i FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
