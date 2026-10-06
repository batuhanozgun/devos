#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixture records and log entries in this file are
# made up for the test and hold no personal or business data. Not made up, because the format under test names
# them: the log's heading and line forms and the D-016 answer forms.
"""test_records_disciplines.py: planted cases for the discipline check of tools/records.py (D-016; N-104).

A fixture repository in a temporary directory holds a minimal plan/ tree (an empty plan/work/, a ledger with the
five generated blocks and a section 1, two logs), and records.py runs in it as a child process, rendered once so
that its views match. One log holds one planted entry per case; every entry's answers carry a marker string that
no output may contain. Then the check runs, by import, on this checkout's real log: no entry from L-159 on may
fail, and every such entry must be counted. Prints one line per case and RECORDS_DISCIPLINES_TEST PASS only if
every case behaves as written.
"""
import importlib.util
import re
import subprocess
import sys
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
}
LOG = "# FX log (append-only)\n\n## Entries\n\n" + "".join(
    entry(n, *lines) + ("## Findings\n\n### FND-001 · fixture finding\n\n" + GOOD + "\n\n## Entries\n\n"
                        if n == 167 else "") for n, (_, lines, _) in PLANTED.items())
LOG2 = "# FY log (append-only)\n\n" + entry(168, GOOD) + entry(169, f"- **Work.** {MARKER}")   # a second log


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {detail[-800:]}"))
    RESULTS.append(ok)


def run(cwd, *args):
    r = subprocess.run([sys.executable, "-I", "-B", str(TOOL), *args], cwd=cwd, capture_output=True)
    out = r.stdout.decode("utf-8") + r.stderr.decode("utf-8")
    OUTPUTS.append(out)
    return r.returncode, r.stdout.decode("utf-8").splitlines(), out


def logs(root, first, second=""):
    (root / "plan/ledger/FX-log.md").write_text(first, encoding="utf-8")
    (root / "plan/ledger/FY-log.md").write_text(second or "# FY log (append-only)\n", encoding="utf-8")


def main():
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        (root / "plan/work").mkdir(parents=True)
        (root / "plan/ledger").mkdir()
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
             "exit 1", rc == 1 and len(got) == sum(1 for l in lines if l.startswith("DISCIPLINES: ")) == 8
             and "DISCIPLINES FAIL: 3 of 11 log entries from L-159 on carry the nine answers" in lines
             and lines[-1] == "RENDER VIEWS MATCH; not OK, because the discipline check failed"
             and "RENDER OK" not in lines, out)

        ledger = (root / "plan/ledger.md").read_text(encoding="utf-8")
        (root / "plan/ledger.md").write_text(ledger.replace("**Ready (startable now):**", "**Ready:**"),
                                             encoding="utf-8")
        rc, lines, out = run(root, "render", "--check")
        case("(3) failing entries and views that differ: both reported, exit 1",
             rc == 1 and lines[-1] == "RENDER DIFFERS: plan/ledger.md"
             and sum(1 for l in lines if l.startswith("DISCIPLINES: ")) == 8, out)
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
             and len(per_entry[0]) == 8
             and "warning: 8 log entries from L-159 on lack the nine discipline answers (D-016); rendered anyway"
             in lines and rc2 == 1 and lines2[-1].startswith("RENDER VIEWS MATCH"), out + out2)

        case("(6) no output contains an entry's text", len(OUTPUTS) >= 6 and not any(MARKER in o for o in OUTPUTS),
             "\n".join(o for o in OUTPUTS if MARKER in o))

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
