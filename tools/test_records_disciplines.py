#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixture records and log entries in this file are
# made up for the test and hold no personal or business data. Not made up, because the format under test names
# them: the log's heading and line forms (the correction line's included) and the D-016 answer forms.
"""test_records_disciplines.py: planted cases for the discipline check of tools/records.py (D-016; N-104; N-110).

A fixture repository in a temporary directory holds a minimal plan/ tree (an empty plan/work/, a ledger with the
five generated blocks and a section 1, two logs), and records.py runs in it as a child process, rendered once so
that its views match. One log holds one planted entry per case; every entry's answers carry a marker string that
no output may contain. N-110's cases (a) and (b) (L-170, L-171) kill CHK-C01-001's mutants R8 and R10; L-172 to
L-178 plant correction lines ("Disciplines of L-<n>"). N-127's case X6 (L-179, L-180; CHK-C01-009 finding 3) plants
an entry whose own line is missing or malformed and whose only correction line names that entry itself: it must
still fail, which kills mutant X6 (a correction naming its own entry counts). D-031's case (L-181) plants a
"Dn: no: <text>" answer, which must fail: the form of a "no" stays "Dn: no" with nothing after it (W-C02-15).
Then the check runs, by import, on this checkout's real log:
no entry from L-159 on may fail, and every such entry must be counted. Prints one line per case and
RECORDS_DISCIPLINES_TEST PASS only if every case behaves as written.

N-315 (W-C02-29): records.py refuses a working directory that is not its own checkout. So the fixture holds its own
copy, tools/records.py, and run() runs that copy from the fixture's root, as stop_check.sh runs the live tree's own.
Cases (8) to (13), form C0, written before the change by the test designer:
- Claim: run with a working directory that does not resolve to its own checkout (Path(__file__).resolve().parents[1]),
  records.py, for every subcommand, exits 2 before any read or write: nothing on stdout, exactly one stderr line,
  starting "records.py: refused: " and naming both resolved directories; the tree it was run in is byte-identical.
- Failure class: a script of one checkout reads or writes another tree because it resolves paths from the working
  directory. Examples: L-431 (a scratch clone's render rewrote the live tree's views), (8) and (9); the same script
  reached through a symlink placed in the tree (10); a subdirectory of its own checkout (11).
- Negative control: (8) to (11) against main 253260c fail (it renders into the foreign tree or fails on its records).
- Positive control: (1) to (6) (the fixture's own copy), (12) (its own checkout through a symlinked path), (13) (this
  checkout's records.py from its root, as stop_check.sh runs it), (7) (the import path).
- Break: removing the refusal turns (8) to (11) BAD; placing it after the first read turns (9) BAD; limiting it to
  `render` turns the --check and durum lines of (8) BAD; comparing without resolve() on the script's side turns (10)
  and (12) BAD; accepting any directory inside the checkout turns (11) BAD.
- Stage and environment: C02; counted: a fresh clone at the pull request's head, the container's python3 (3.13) and
  PyYAML; the fixtures are temporary directories, not git trees. Independence: written by the test designer; run by
  the producer and by the binding checker, who judges. Evidence layer: behavioural (exit code, output, bytes).
- Evidence envelope: the run's raw output with the head SHA and this file's blob, in the item's evidence record.
"""
import hashlib
import importlib.util
import os
import re
import shutil
import sys
import subprocess
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
TOOL = Path(__file__).resolve().parent / "records.py"
REPO = TOOL.parent.parent
MARKER = "PLANTED-ENTRY-TEXT-k3Vw"
MISSING = "no line starting '- **Disciplines (D1–D9)'"
RESULTS, OUTPUTS = [], []

LEDGER = "# Fixture ledger\n\n## 1. Current state\n\n| Item | Value | As-of |\n|---|---|---|\n" \
         "| summary_tr | Fixture. | 2026-01-01T00:00Z |\n| Usage | none | 2026-01-01T00:00Z |\n" \
         "| Rendered | x | 2026-01-01T00:00Z |\n\n---\n\n## 2. Views\n" + \
         "".join(f"\n<!-- generated:{b} -->\n\n<!-- /generated -->\n"
                 for b in ("frontier", "zoom", "work-index", "decisions-index", "open-notes"))


def nine(**answers):
    """A discipline answer text: 'no.' for every question not given; a given one is written as it stands."""
    return " ".join(f"D{n}: {answers.get(f'd{n}', 'no.')}" for n in range(1, 10))


def entry(n, *lines):
    return f"### L-{n} · 2026-01-01 · fixture entry\n\n" + "".join(l + "\n" for l in lines) + \
        f"- **Record changes:** none · fixture {MARKER}\n\n"


GOOD = "- **Disciplines (D1–D9):** " + nine(d1=f"yes: {MARKER}.")
PLANTED = {   # number: (case label, the entry's lines, the expected reason or None)
    150: ("an entry below L-159 without a line is ignored", [f"- **Work.** {MARKER}"], None),
    158: ("an entry below L-159 with a malformed line is ignored",
          [f"- **Disciplines (D1–D9):** D1: maybe {MARKER}"], None),
    159: ("L-159's variant heading with nine answers passes",
          ["- **Disciplines (D1–D9)** (first entry under D-016): " + nine(d2=f"uncertain: {MARKER}.")], None),
    160: ("a good entry (no with '.', ';' and nothing; yes and uncertain with text) passes",
          ["- **Disciplines (D1–D9):** " + nine(d1="no;", d2=f"yes: {MARKER}.", d3=f"uncertain: {MARKER};",
                                               d4="no", d9=f"yes: {MARKER} (D9 of N-1).")], None),
    161: ("an entry without the line fails", [f"- **Work.** {MARKER}"], MISSING),
    162: ("a missing question fails", ["- **Disciplines (D1–D9):** " + nine().replace("D4: no. ", "")],
          "D4 missing"),
    163: ("answers out of order fail",
          ["- **Disciplines (D1–D9):** " + nine().replace("D3: no. D4: no.", "D4: no. D3: no.")],
          "D4 out of order"),
    164: ("'yes' without text fails", ["- **Disciplines (D1–D9):** " + nine(d5="yes:")], "D5: 'yes' without text"),
    165: ("'uncertain' with only punctuation fails",
          ["- **Disciplines (D1–D9):** " + nine(d9="uncertain: .")], "D9: 'uncertain' without text"),
    166: ("'no' followed by more text fails", ["- **Disciplines (D1–D9):** " + nine(d2=f"no, {MARKER}.")],
          "D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'"),
    167: ("a line under the next heading (a finding section) does not count for the entry above it",
          [f"- **Work.** {MARKER}"], MISSING),
    170: ("(N-110 a) two lines, the second malformed: the second is checked too and fails",
          [GOOD, "- **Disciplines (D1–D9):** " + nine().replace("D4: no. ", "")], "D4 missing"),
    171: ("(N-110 b) a 'Dn: maybe: <text>' answer fails",
          ["- **Disciplines (D1–D9):** " + nine(d6=f"maybe: {MARKER}.")],
          "D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'"),
    172: ("an entry without the line that a later entry corrects passes", [f"- **Work.** {MARKER}"], None),
    173: ("the correcting entry, with its own line and a correction line naming L-172, passes",
          [GOOD, "- **Disciplines of L-172 (D1–D9):** " + nine(d3=f"yes: {MARKER}.")], None),
    174: ("an entry whose only correction is malformed still fails", [f"- **Work.** {MARKER}"], MISSING),
    175: ("an entry with a malformed correction line naming L-174 passes on its own line",
          [GOOD, "- **Disciplines of L-174 (D1–D9):** " + nine(d5="yes:")], None),
    176: ("an entry with a correction line naming a later entry passes on its own line",
          [GOOD, "- **Disciplines of L-177 (D1–D9):** " + nine()], None),
    177: ("a correction in an earlier entry does not count", [f"- **Work.** {MARKER}"], MISSING),
    178: ("a correction line is not the entry's own line", ["- **Disciplines of L-100 (D1–D9):** " + nine()], MISSING),
    179: ("(N-127 X6) an entry without its own line, whose only correction line names itself with nine good answers, "
          "still fails", ["- **Disciplines of L-179 (D1–D9):** " + nine(d3=f"yes: {MARKER}.")], MISSING),
    180: ("(N-127 X6) an entry with a malformed own line, whose only correction line names itself with nine good "
          "answers, still fails", ["- **Disciplines (D1–D9):** " + nine().replace("D4: no. ", ""),
                                   "- **Disciplines of L-180 (D1–D9):** " + nine(d3=f"yes: {MARKER}.")], "D4 missing"),
    181: ("(D-031) a 'Dn: no: <text>' answer fails: a 'no' stays 'Dn: no' with nothing after it",
          ["- **Disciplines (D1–D9):** " + nine(d9=f"no: {MARKER}.")],
          "D9 is not 'no', 'yes: <text>' or 'uncertain: <text>'"),
}
LOG = "# FX log (append-only)\n\n## Entries\n\n" + "".join(
    entry(n, *lines) + ("## Findings\n\n### FND-001 · fixture finding\n\n" + GOOD + "\n\n## Entries\n\n"
                        if n == 167 else "") for n, (_, lines, _) in PLANTED.items())
LOG2 = "# FY log (append-only)\n\n" + entry(168, GOOD) + entry(169, f"- **Work.** {MARKER}")   # a second log


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {detail[-800:]}"))
    RESULTS.append(ok)


def run(cwd, *args):
    """The fixture's own copy of records.py (copied from this checkout in main()), run from the fixture's root."""
    return run_script(Path(cwd) / "tools/records.py", cwd, *args)[:3]


def run_script(script, cwd, *args, flags=("-I", "-B")):
    r = subprocess.run([sys.executable, *flags, str(script), *args], cwd=cwd, capture_output=True)
    out = r.stdout.decode("utf-8") + r.stderr.decode("utf-8")
    OUTPUTS.append(out)
    return r.returncode, r.stdout.decode("utf-8").splitlines(), out, r.stderr.decode("utf-8").splitlines()[:5]


def tree_bytes(root):
    """Every path under root with the sha256 of its bytes (a symlink: its target), for a before/after comparison."""
    out = {}
    for dp, dns, fns in os.walk(root):
        for n in dns + fns:
            p = Path(dp) / n
            rel = str(p.relative_to(root))
            if p.is_symlink():
                out[rel] = "link:" + os.readlink(p)
            elif p.is_file():
                out[rel] = hashlib.sha256(p.read_bytes()).hexdigest()
            else:
                out[rel] = "dir"
    return out


def refused(rc, stdout, stderr, script, cwd):
    """N-315's interface: exit 2, nothing on stdout, exactly one stderr line, "records.py: refused: " naming the
    script's checkout and the working directory, both resolved."""
    ck, wd = str(Path(script).resolve().parents[1]), str(Path(cwd).resolve())
    return (rc == 2 and stdout == [] and len(stderr) == 1 and stderr[0].startswith("records.py: refused: ")
            and ck in stderr[0] and wd in stderr[0])


def foreign_cases(root):
    """(8) to (13): N-315. root is the fixture, rendered and clean; nothing here writes to it."""
    with tempfile.TemporaryDirectory() as tmp2:
        base = Path(tmp2)
        f1 = base / "f1"                                  # another tree with rendered records, no tools/
        shutil.copytree(root / "plan", f1 / "plan")
        shutil.copy2(root / "DURUM.md", f1 / "DURUM.md")
        rel = os.path.relpath(TOOL, f1)
        for sub in (["render"], ["render", "--check"], ["durum"]):
            for how, script, flags in (("python3 -I -B, absolute path", TOOL, ("-I", "-B")),
                                       ("python3, absolute path", TOOL, ()),
                                       ("python3 -B, relative path", rel, ("-B",))):
                before = tree_bytes(f1)
                rc, out, txt, err = run_script(script, f1, *sub, flags=flags)
                case(f"(8) (N-315) this checkout's records.py {' '.join(sub)} ({how}) with another tree as the "
                     "working directory: refused, exit 2, that tree byte-identical",
                     refused(rc, out, err, f1 / rel if script is rel else script, f1) and tree_bytes(f1) == before,
                     f"exit {rc}: " + " | ".join(txt.splitlines()[:3]))

        f2 = base / "f2"                                  # (9) a record the script cannot read
        shutil.copytree(f1, f2)
        (f2 / "plan/work/W-X-01.md").write_text("no front matter here\n", encoding="utf-8")
        before = tree_bytes(f2)
        rc, out, txt, err = run_script(TOOL, f2, "render")
        case("(9) (N-315) the refusal comes before any read: a foreign tree holding a record that cannot be read gives "
             "the refusal line only", refused(rc, out, err, TOOL, f2) and tree_bytes(f2) == before, f"exit {rc}: " + " | ".join(txt.splitlines()[:3]))

        f3 = base / "f3"                                  # (10) reached through a symlink placed in the tree
        shutil.copytree(f1, f3)
        (f3 / "tools").mkdir()
        (f3 / "tools/records.py").symlink_to(TOOL)
        before = tree_bytes(f3)
        for sub in (["render"], ["render", "--check"]):
            rc, out, txt, err = run_script(f3 / "tools/records.py", f3, *sub)
            case(f"(10) (N-315) this checkout's records.py reached through a symlink at <tree>/tools/records.py, "
                 f"{' '.join(sub)} from that tree: refused (the script's path is resolved), the tree byte-identical",
                 refused(rc, out, err, f3 / "tools/records.py", f3) and tree_bytes(f3) == before, f"exit {rc}: " + " | ".join(txt.splitlines()[:3]))

        before = tree_bytes(root)                         # (11) a subdirectory of its own checkout
        rc, out, txt, err = run_script(root / "tools/records.py", root / "plan", "render")
        case("(11) (N-315) the fixture's own copy run from a subdirectory of its checkout (plan/): refused, exit 2, "
             "the fixture byte-identical", refused(rc, out, err, root / "tools/records.py", root / "plan")
             and tree_bytes(root) == before, f"exit {rc}: " + " | ".join(txt.splitlines()[:3]))

        link = base / "link"                              # (12) its own checkout through a symlinked path
        link.symlink_to(root)
        rc, out, txt, err = run_script(link / "tools/records.py", link, "render", "--check")
        case("(12) (N-315 control) the fixture's own copy, reached and run through a symlink to the fixture: not "
             "refused; RENDER OK, exit 0", rc == 0 and out[-1:] == ["RENDER OK"] and "refused" not in txt,
             f"exit {rc}: " + " | ".join(txt.splitlines()[:3]))

    rc, out, txt, err = run_script(TOOL, REPO, "render", "--check", flags=("-B",))
    case("(13) (N-315 control) this checkout's records.py from its own root, as stop_check.sh runs it: not refused "
         "(exit 0 or 1, no refusal line)", rc in (0, 1) and "records.py: refused" not in txt
         and any(l.startswith("DISCIPLINES ") for l in out), f"exit {rc}: " + " | ".join(txt.splitlines()[-3:]))


def logs(root, first, second=""):
    (root / "plan/ledger/FX-log.md").write_text(first, encoding="utf-8")
    (root / "plan/ledger/FY-log.md").write_text(second or "# FY log (append-only)\n", encoding="utf-8")


def main():
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        (root / "plan/work").mkdir(parents=True)
        (root / "plan/ledger").mkdir()
        (root / "tools").mkdir()
        shutil.copy2(TOOL, root / "tools/records.py")   # its own copy (N-315)
        (root / "plan/ledger.md").write_text(LEDGER, encoding="utf-8")
        logs(root, "# FX log (append-only)\n\n" + entry(159, GOOD) + entry(160, GOOD))

        rc, lines, out = run(root, "render")
        rc2, lines2, out2 = run(root, "render", "--check")
        case("(1) a clean log: render writes without a warning; render --check prints DISCIPLINES OK and RENDER OK, "
             "exit 0", rc == 0 and "rendered plan/ledger.md and DURUM.md" in lines and "DISCIPLINES" not in out
             and "warning" not in out and rc2 == 0 and lines2 == [
                 "DISCIPLINES OK: 2 of 2 log entries from L-159 on carry the nine answers", "RENDER OK"], out + out2)

        logs(root, LOG, LOG2)
        rc, lines, out = run(root, "render", "--check")
        got = dict(re.fullmatch(r"DISCIPLINES: L-(\d+): (.*)", l).groups() for l in lines
                   if l.startswith("DISCIPLINES: "))
        for n, (label, _, want) in PLANTED.items():
            case(f"(L-{n}) {label}", got.get(str(n)) == want, out)
        case("(L-168, L-169) every log file is read: a good entry passes, a missing line fails",
             "168" not in got and got.get("169") == MISSING, out)
        case("(2) failing entries, views that match: one line per failing entry, DISCIPLINES FAIL, no RENDER OK, "
             "exit 1", rc == 1 and len(got) == sum(1 for l in lines if l.startswith("DISCIPLINES: ")) == 16
             and "DISCIPLINES FAIL: 7 of 23 log entries from L-159 on carry the nine answers" in lines
             and lines[-1] == "RENDER VIEWS MATCH; not OK, because the discipline check failed"
             and "RENDER OK" not in lines, out)

        ledger = (root / "plan/ledger.md").read_text(encoding="utf-8")
        (root / "plan/ledger.md").write_text(ledger.replace("**Ready (startable now):**", "**Ready:**"),
                                             encoding="utf-8")
        rc, lines, out = run(root, "render", "--check")
        case("(3) failing entries and views that differ: both reported, exit 1",
             rc == 1 and lines[-1] == "RENDER DIFFERS: plan/ledger.md"
             and sum(1 for l in lines if l.startswith("DISCIPLINES: ")) == 16, out)
        logs(root, "# FX log (append-only)\n\n" + entry(159, GOOD))
        rc, lines, out = run(root, "render", "--check")
        case("(4) a clean log and views that differ: RENDER DIFFERS as before, exit 1",
             rc == 1 and lines == ["DISCIPLINES OK: 1 of 1 log entries from L-159 on carry the nine answers",
                                   "RENDER DIFFERS: plan/ledger.md"], out)

        logs(root, LOG, LOG2)
        rc, lines, out = run(root, "render")
        rc2, lines2, out2 = run(root, "render", "--check")
        per_entry = [[x for x in ls if x.startswith("DISCIPLINES: ")] for ls in (lines, lines2)]
        case("(5) render with failing entries prints the same lines and a warning, and renders anyway",
             rc == 0 and "rendered plan/ledger.md and DURUM.md" in lines and per_entry[0] == per_entry[1]
             and len(per_entry[0]) == 16
             and "warning: 16 log entries from L-159 on lack the nine discipline answers (D-016); rendered anyway"
             in lines and rc2 == 1 and lines2[-1].startswith("RENDER VIEWS MATCH"), out + out2)

        case("(6) no output contains an entry's text", len(OUTPUTS) >= 6 and not any(MARKER in o for o in OUTPUTS),
             "\n".join(o for o in OUTPUTS if MARKER in o))

        logs(root, "# FX log (append-only)\n\n" + entry(159, GOOD))   # a clean, rendered fixture for (8) to (12)
        rc, lines, out = run(root, "render")
        rc2, lines2, out2 = run(root, "render", "--check")
        if not (rc == 0 and rc2 == 0 and lines2[-1:] == ["RENDER OK"]):
            case("(8)-(13) fixture: the fixture's own copy renders it clean (the cases below did not run)", False,
                 out + out2)
        else:
            foreign_cases(root)

    spec = importlib.util.spec_from_file_location("records_under_test", TOOL)
    records = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(records)
    probs, checked = records.discipline_problems(REPO)
    want = sum(1 for p in (REPO / "plan/ledger").glob("*-log.md") for l in p.read_text().splitlines()
               if (m := re.match(r"### L-(\d+)", l)) and int(m.group(1)) >= 159)
    case(f"(7) this checkout's real log: every entry from L-159 on is counted ({checked} of {want}) and none fails",
         want > 0 and checked == want and probs == [], repr(probs))
    ok = bool(RESULTS) and all(RESULTS)
    print(f"RECORDS_DISCIPLINES_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
