#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): every input below is made up for this test and holds no
# personal or business data and no credential: the versions 2999..., the names w03_fixture_*, the repository name
# w03-fixture-owner/w03-fixture-repo, the token text, the run and job ids 9..., the commits git makes in scratch
# repositories, the report lines, the log lines and the planted workflow text. Not made up, because the rules under test
# name them: DevOS's workflow paths, job and step ids, the path supabase/migrations/, the report line's form (migrate.yml,
# step `report`), deployment_drift's result kinds, and the job list's shape as GitHub gave it (the executor's observation
# of 2026-10-13, run 38319371450 of migrate.yml; a skipped job's log answering 404, job 115043525608).
"""test_workflow_guards.py: N-265's two guards; tests/C02/W-C02-03/T-W03-15_workflow_guards.md.

G1 (W03_RUN_EXPR_TEST) READS every workflow file at the top of .github/workflows/ with PyYAML and refuses any
   expression opener (a dollar sign, then two opening braces) in a step's `run:` value: GitHub evaluates it before the
   runner receives the body, so the body that runs is not the text every offline check runs (CHK-C02-029 F-1). Its
   break: copies of the folder with one opener planted, each of which must fail on that file, job and step; and
   controls that must not (the opener outside `run:`, or split by a space).
G2 (W03_PR_INPUTS_TEST) RUNS step `pr_inputs`' own body, read from migration-checks.yml at the head, as a program in
   scratch git repositories against a stub of GitHub's REST API on 127.0.0.1, then feeds its outputs to `pr_decide`'s
   own body through pr_decide's `env:` wiring, and checks the verdict and the records' state per case: (a) quoted
   names, (b) a failed diff, (c) positive controls, (d) the job list as GitHub gives it, (e) a ran job's log answering
   404. Nothing reaches GitHub: every other host goes to a dead proxy. Its breaks: the head's body with a prelude that
   takes one rule out of effect; each must turn its own cases red and leave the cases it cannot touch as they were.
Options: --repo PATH (default: three levels above this file); --impl pr_inputs=FILE (run FILE instead of the head's
   body; the final line then names a break-copy run, never a result of the workflow); --self-check (wrong-by-
   construction inputs: synthetic workflow folders for G1; for G2 the frozen body of main d33c8e9, which must pass (a),
   (b), (c) and the negative controls of (d) and fail the rest of (d) and (e), a body that always reports a clean
   state, a crashing body, and repositories without the workflow).
Output: one line per case, copy and break ("ok", "BAD", "CNC" for could not check, "n/a"), then one final line per
   test: W03_RUN_EXPR_TEST and W03_PR_INPUTS_TEST, each PASS, FAIL or COULD NOT CHECK. Exit 1 if either fails, else 3
   if either could not check, else 0. --self-check ends with W03_GUARDS_SELF_CHECK PASS (exit 0) or FAIL (exit 1).
"""
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlsplit

sys.dont_write_bytecode = True

OPEN = "$" + "{{"  # the expression opener; built from two parts, as migration-checks.yml's workflow_check does
WORKFLOWS = ".github/workflows"
CHECKS = ".github/workflows/migration-checks.yml"
MIGRATE = ".github/workflows/migrate.yml"
HIGH_PREFIXES = (".claude/", "tools/", ".github/workflows/", "methods/", "supabase/migrations/", "supabase/functions/",
                 "pipelines/")
HERE = Path(__file__).resolve().parent
FROZEN = "d33c8e9"
FROZEN_INPUTS = HERE / "breaks" / f"G2_pr_inputs_{FROZEN}.py"
FROZEN_DECIDE = HERE / "breaks" / f"G2_pr_decide_{FROZEN}.py"


class Tally:
    def __init__(self, name, quiet=False):
        self.name, self.quiet, self.ok, self.bad, self.cnc = name, quiet, 0, 0, 0

    def say(self, tag, label, detail=""):
        if tag == "ok":
            self.ok += 1
        elif tag == "BAD":
            self.bad += 1
        elif tag == "CNC":
            self.cnc += 1
        if not self.quiet:
            print(f"{tag:<4} {self.name} {label}" + (f": {detail}" if detail else ""))


def yaml_module():
    try:
        import yaml
        return yaml
    except ImportError:
        return None


# ==== G1: no expression opener in a run: value ======================================================================

def step_label(s, i):
    return str(s.get("id") or s.get("name") or f"#{i + 1}")


def g1_scan(folder):
    """(problems, could-not-check, run values read, files read) over the top-level .yml and .yaml files of folder."""
    yaml = yaml_module()
    if yaml is None:
        return [], ["PyYAML is not installed"], 0, 0
    if not folder.is_dir():
        return [], [f"{WORKFLOWS} is absent"], 0, 0
    paths = sorted(p for p in folder.iterdir() if p.suffix in (".yml", ".yaml") and p.is_file())
    if not paths:
        return [], [f"{WORKFLOWS} holds no .yml or .yaml file"], 0, 0
    problems, cnc, runs = [], [], 0
    for p in paths:
        rel = f"{WORKFLOWS}/{p.name}"
        try:
            wf = yaml.safe_load(p.read_text(encoding="utf-8"))
        except Exception as exc:  # unreadable, not UTF-8, or not YAML: could not check, never a pass
            cnc.append(f"{rel}: not readable as YAML ({type(exc).__name__})")
            continue
        jobs = wf.get("jobs") if isinstance(wf, dict) else None
        if not isinstance(jobs, dict):
            cnc.append(f"{rel}: not a workflow this test reads (no mapping of jobs)")
            continue
        for jid, job in jobs.items():
            if not isinstance(job, dict):
                cnc.append(f"{rel}: job {jid} is not a mapping")
                continue
            steps = job.get("steps")
            if steps is None:
                if "uses" not in job:
                    cnc.append(f"{rel}: job {jid} has neither steps nor uses")
                continue
            if not isinstance(steps, list):
                cnc.append(f"{rel}: job {jid}'s steps are not a list")
                continue
            for i, s in enumerate(steps):
                if not isinstance(s, dict):
                    cnc.append(f"{rel}: job {jid} step #{i + 1} is not a mapping")
                    continue
                if "run" not in s:
                    continue
                v = s["run"]
                if isinstance(v, (list, dict)):
                    cnc.append(f"{rel}: job {jid} step {step_label(s, i)}: its run: value is not text")
                    continue
                runs += 1
                text = "" if v is None else str(v)
                n = text.count(OPEN)
                if n:
                    line = next(k for k, ln in enumerate(text.split("\n"), 1) if OPEN in ln)
                    problems.append(f"{rel}: job {jid} step {step_label(s, i)}: its run: value holds {n} expression "
                                    f"opener(s), the first on line {line} of the value; GitHub evaluates it before the "
                                    f"runner receives the body")
    return problems, cnc, runs, len(paths)


def dump_yaml(data):
    yaml = yaml_module()

    class Dumper(yaml.SafeDumper):
        pass

    def text(dumper, v):
        return dumper.represent_scalar("tag:yaml.org,2002:str", v, style="|" if "\n" in v else None)

    Dumper.add_representer(str, text)
    return yaml.dump(data, Dumper=Dumper, sort_keys=False, allow_unicode=True, width=1 << 16)


PLANT_ESCAPED = """name: w03-fixture-planted-escape
on:
  pull_request:
jobs:
  w03-fixture-job:
    runs-on: ubuntu-24.04
    steps:
      - id: w03_fixture_escaped
        run: "echo \\x24{{ github.sha }}"
"""

PLANT_BLOCK = """name: w03-fixture-planted-block
on:
  pull_request:
jobs:
  w03-fixture-job:
    runs-on: ubuntu-24.04
    steps:
      - id: w03_fixture_block
        shell: bash
        run: |
          python3 - <<'EOF'
          print("w03 fixture")
          x = "OPEN github.token }}"
          EOF
""".replace("OPEN", OPEN)

CONTROL = """name: w03-fixture-control OPEN github.workflow }}
on:
  pull_request:
env:
  W03_FIXTURE: OPEN github.sha }}
jobs:
  w03-fixture-job:
    runs-on: ubuntu-24.04
    if: OPEN github.event_name == 'pull_request' }}
    steps:
      - id: w03_fixture_spaced
        name: w03 fixture OPEN github.sha }}
        env:
          W03_FIXTURE_VALUE: OPEN github.sha }}
        run: |
          echo "$ {{ github.sha }} is not an expression"
          echo "${ { github.sha }} is not one either"
          echo "$W03_FIXTURE_VALUE ${HOME} {{ w03 }}"
  w03-fixture-call:
    uses: w03-fixture-owner/w03-fixture-repo/.github/workflows/w03-fixture.yml@0123456789abcdef0123456789abcdef01234567
    with:
      w03_fixture_input: OPEN github.sha }}
""".replace("OPEN", OPEN)


def g1_copies(folder):
    """The break and the controls on copies of the head's folder: (label, 'ok'|'BAD'|'CNC', detail)."""
    yaml = yaml_module()
    base_p, base_c, _, _ = g1_scan(folder)
    base = set(base_p)
    out = []
    paths = sorted(p for p in folder.iterdir() if p.suffix in (".yml", ".yaml") and p.is_file())
    with tempfile.TemporaryDirectory(prefix="w03g1-") as d:
        n = [0]

        def copy_folder():
            n[0] += 1
            dst = Path(d, f"copy{n[0]}", ".github", "workflows")
            dst.mkdir(parents=True)
            for p in paths:
                shutil.copyfile(p, dst / p.name)
            return dst

        def judge(label, dst, want):
            p, c, _, _ = g1_scan(dst)
            new = set(p) - base
            if set(c) != set(base_c):
                out.append((label, "CNC", f"the copy could not be read ({sorted(set(c) - set(base_c))})"))
            elif want is None:
                out.append((label, "ok" if not new else "BAD",
                            "passes, as it must" if not new else f"is refused, but must pass: {sorted(new)}"))
            elif new and all(x.startswith(want) for x in new):
                out.append((label, "ok", f"fails on its own file, job and step, as it must ({sorted(new)[0][:110]}...)"))
            else:
                out.append((label, "BAD", f"does NOT fail on {want!r} ({sorted(new) or 'it passes'})"))

        for p in paths:  # the break: one opener planted in a head file, in its last job's last run: value
            wf = yaml.safe_load(p.read_text(encoding="utf-8"))
            target = None
            for jid, job in (wf.get("jobs") or {}).items() if isinstance(wf, dict) else []:
                for i, s in enumerate((job or {}).get("steps") or [] if isinstance(job, dict) else []):
                    if isinstance(s, dict) and isinstance(s.get("run"), str):
                        target = (jid, i, s)
            if target is None:
                out.append((f"planted copy of {p.name}", "CNC", "no run: value to plant in"))
                continue
            jid, i, s = target
            s["run"] = s["run"] + ("" if s["run"].endswith("\n") else "\n") + f'echo "w03 fixture {OPEN} github.event_name }}}}"\n'
            dst = copy_folder()
            (dst / p.name).write_text(dump_yaml(wf), encoding="utf-8")
            judge(f"planted copy of {p.name} (job {jid}, step {step_label(s, i)}, a block scalar)", dst,
                  f"{WORKFLOWS}/{p.name}: job {jid} step {step_label(s, i)}:")
        for name, text, want in (
                ("w03-fixture-planted-escape.yml", PLANT_ESCAPED,
                 f"{WORKFLOWS}/w03-fixture-planted-escape.yml: job w03-fixture-job step w03_fixture_escaped:"),
                ("w03-fixture-planted-block.yml", PLANT_BLOCK,
                 f"{WORKFLOWS}/w03-fixture-planted-block.yml: job w03-fixture-job step w03_fixture_block:"),
                ("w03-fixture-control.yml", CONTROL, None)):
            dst = copy_folder()
            (dst / name).write_text(text, encoding="utf-8")
            what = {"w03-fixture-planted-escape.yml": "planted file: the opener written as a YAML escape (\\x24)",
                    "w03-fixture-planted-block.yml": "planted file: the opener inside a heredoc in a block scalar",
                    "w03-fixture-control.yml": "control: openers in name:, env:, if:, with: only, and '$ {{' split by a "
                                               "space in run:"}[name]
            judge(what, dst, want)
    return out


def g1(repo, tally):
    folder = repo / WORKFLOWS
    problems, cnc, runs, files = g1_scan(folder)
    for x in problems:
        tally.say("BAD", "run: value", x)
    for x in cnc:
        tally.say("CNC", "could not check", x)
    if not problems and not cnc:
        tally.say("ok", f"{WORKFLOWS}", f"{runs} run: values in {files} files, none holding an expression opener")
    copies = g1_copies(folder) if folder.is_dir() and not (cnc and not runs) else []
    for label, tag, detail in copies:
        tally.say(tag, label, detail)
    planted = sum(1 for label, tag, _ in copies if tag == "ok" and not label.startswith("control"))
    controls = sum(1 for label, tag, _ in copies if tag == "ok" and label.startswith("control"))
    if problems or tally.bad:
        what = f"{len(problems)} run: value(s) hold an expression opener" if problems else "a copy did not turn red"
        print(f"W03_RUN_EXPR_TEST FAIL ({what}; {tally.bad} bad, {tally.cnc} could not check)")
        return 1
    if cnc or tally.cnc or not copies:
        print(f"W03_RUN_EXPR_TEST COULD NOT CHECK ({tally.cnc or len(cnc)} could not be read or made; none passed in "
              f"their place)")
        return 3
    print(f"W03_RUN_EXPR_TEST PASS (no run: value holds an expression opener: {runs} values in {files} files; "
          f"{planted} planted copies red, {controls} control passes)")
    return 0


# ==== G2: pr_inputs' own body against git and a stub of GitHub's REST API ==========================================

REPO_NAME = "w03-fixture-owner/w03-fixture-repo"
TOKEN = "w03-fixture-token-not-a-credential"
RUN_ID = 9000000001
OBSERVED_ORDER = ("devos-test", "check-devos-test", "check-devos", "devos")  # GitHub's order, run 38319371450
JOB_IDS = {j: 9100000001 + i for i, j in enumerate(OBSERVED_ORDER)}
OWN = {"devos-test": "devos-test", "check-devos-test": "devos-test", "devos": "devos", "check-devos": "devos"}
DISPLAY_AT_FROZEN = {"devos-test": "devos-test (apply, compare, test)", "devos": "devos (compare, decide, apply)",
                     "check-devos-test": "check-devos-test (compare and search; applies nothing)",
                     "check-devos": "check-devos (compare and search; applies nothing)"}
SHAPES = {  # "ran" is not a shape GitHub gives: (a) to (c) use it so that they do not depend on (d)'s rule
    "ran": (("devos-test", "success"), ("devos", "success")),
    "push": (("devos-test", "success"), ("check-devos-test", "skipped"), ("check-devos", "skipped"),
             ("devos", "success")),
    "schedule": (("devos-test", "skipped"), ("check-devos-test", "success"), ("check-devos", "success"),
                 ("devos", "skipped")),
}
EVENT = {"ran": "push", "push": "push", "schedule": "schedule"}
PROJECTS = ("devos-test", "devos")


def v(n):
    return f"299901010000{n:02d}"


MIG = "supabase/migrations/"
FILES = {
    "plain": (v(1), MIG + v(1) + "_w03_fixture_alpha.sql"),
    "nonascii": (v(2), MIG + v(2) + "_w03_fixture_caf\u00e9.sql"),
    "tab": (v(3), MIG + v(3) + "_w03_fixture_tab\there.sql"),
    "quote": (v(4), MIG + v(4) + '_w03_fixture_quote"d.sql'),
    "backslash": (v(5), MIG + v(5) + "_w03_fixture_back\\slash.sql"),
    "newline": (v(6), MIG + v(6) + "_w03_fixture_new\nline.sql"),
    "nonutf8": (v(7), MIG + v(7) + "_w03_fixture_" + os.fsdecode(b"\xff") + ".sql"),
    "pending": (v(8), MIG + v(8) + "_w03_fixture_pending.sql"),
}
APPLIED = [v(n) for n in range(1, 8)]  # applied in both projects
PENDING = v(8)  # merged, unapplied in both projects (on_main_not_applied)
NEW = MIG + v(9) + "_w03_fixture_gamma.sql"
DOC = "docs/w03_fixture_note.md"
BOTH = {"devos-test": "read", "devos": "read"}


def case(cid, what, ops, verdict, kind="merge", shape="ran", missing=None, read=None, cnc_reason=False):
    return {"id": cid, "what": what, "ops": ops, "verdict": verdict, "kind": kind, "shape": shape,
            "missing": missing, "read": read or {}, "cnc_reason": cnc_reason}


CASES = [
    # (a) quoted names, merged migrations applied in both projects: fail
    case("A0", "control: a plain-named migration modified, applied in both", [("M", "plain")], "fail"),
    case("A1", "a non-ASCII name modified, applied in both", [("M", "nonascii")], "fail"),
    case("A2", "a non-ASCII name removed, applied in both", [("D", "nonascii")], "fail"),
    case("A3", "a non-ASCII name renamed, applied in both", [("R", "nonascii")], "fail"),
    case("A4", "a name holding a tab modified, applied in both", [("M", "tab")], "fail"),
    case("A5", "a name holding a double quote removed, applied in both", [("D", "quote")], "fail"),
    case("A6", "a name holding a backslash renamed, applied in both", [("R", "backslash")], "fail"),
    case("A7", "a name holding a newline modified, applied in both", [("M", "newline")], "fail"),
    case("A8", "a name holding a byte that is not UTF-8 modified, applied in both", [("M", "nonutf8")], "fail"),
    # (b) git diff fails: fail, and the reason says could not check
    case("B1", "git diff fails: the checked-out commit has no parent (an added migration and a document)",
         [("A", None), ("doc", None)], "fail", kind="root", cnc_reason=True),
    case("B2", "git diff fails: a depth-1 checkout lacks the merge commit's parent (the same change)",
         [("A", None), ("doc", None)], "fail", kind="shallow", cnc_reason=True),
    # (c) positive controls, in a job list of the two jobs that ran
    case("C1", "positive control: a new migration added; the records' state is stated", [("A", None)], "pass",
         read=BOTH),
    case("C2", "positive control: a merged migration removed while the report shows it unapplied in both (M16)",
         [("D", "pending")], "pass", read=BOTH),
    # (d) the job list as GitHub gives it: four jobs, completed, two of them skipped
    case("D1", "push run's job list (two jobs skipped): C1's addition", [("A", None)], "pass", shape="push",
         read=BOTH),
    case("D2", "push run's job list (two jobs skipped): C2's removal", [("D", "pending")], "pass", shape="push",
         read=BOTH),
    case("D3", "scheduled run's job list (two jobs skipped): C1's addition", [("A", None)], "pass", shape="schedule",
         read=BOTH),
    case("D4", "scheduled run's job list (two jobs skipped): C2's removal", [("D", "pending")], "pass",
         shape="schedule", read=BOTH),
    case("D5", "negative control: push run's job list, a migration applied in both modified", [("M", "plain")], "fail",
         shape="push"),
    case("D6", "negative control: scheduled run's job list, a migration applied in both modified", [("M", "plain")],
         "fail", shape="schedule"),
    # (e) a job that ran, whose own log answers 404
    case("E1", "push run: devos-test ran but its log answers 404; C2's removal",
         [("D", "pending")], "fail", shape="push", missing="devos-test", read={"devos-test": "cnc", "devos": "read"}),
    case("E2", "scheduled run: check-devos ran but its log answers 404; C2's removal",
         [("D", "pending")], "fail", shape="schedule", missing="check-devos",
         read={"devos-test": "read", "devos": "cnc"}),
]
A_Q = [f"A{n}" for n in range(1, 9)]
A_ALL = ["A0"] + A_Q
B_ALL, C_ALL, D_ALL, E_ALL = ["B1", "B2"], ["C1", "C2"], [f"D{n}" for n in range(1, 7)], ["E1", "E2"]
# (id, prelude kind, what the copy does, cases it must turn red, cases it cannot touch and must leave as they were)
BREAKS = [
    ("BRK-a", "quoted", "reads the changed files from git's line output, where git quotes such names (the class of "
     "CHK-C02-035 C2)", A_Q, ["A0"] + B_ALL + C_ALL + D_ALL + E_ALL),
    ("BRK-b", "diff_failed_as_empty", "reads a failed git diff as an empty list of changes", B_ALL,
     A_ALL + C_ALL + D_ALL + E_ALL),
    ("BRK-c1", "added_as_modified", "reports an added migration as modified", ["C1", "D1", "D3"],
     A_ALL + B_ALL + ["C2", "D2", "D4", "D5", "D6"] + E_ALL),
    ("BRK-c2", "report_without_differences", "reads each job's report without its list of differences",
     ["C2", "D2", "D4"], A_ALL + B_ALL + ["D5", "D6"]),
    ("BRK-d", "skipped_404_as_clean", "does not tell a skipped job from one that ran, and reads a skipped job's 404 "
     "as an empty clean report", ["D2", "D4"], A_ALL + B_ALL + C_ALL),
    ("BRK-e", "ran_404_as_clean", "folds a ran job's 404 into an empty clean report ('no difference')", E_ALL,
     A_ALL + B_ALL + C_ALL + D_ALL),
]

PRELUDE = r'''# ---- T-W03-15 break prelude (__KIND__), tests/C02/W-C02-03/test_workflow_guards.py; not the workflow's code ----
import email.message as _w03_em, io as _w03_io, json as _w03_json, os as _w03_os, re as _w03_re
import subprocess as _w03_sp, urllib.error as _w03_ue, urllib.request as _w03_ur, urllib.response as _w03_uresp
_W03_KIND = "__KIND__"


def _w03_mark(what):
    with open(_w03_os.environ["W03_BREAK_MARK"], "a", encoding="utf-8") as f:
        f.write(what + "\n")


def _w03_swap(out, pairs):
    for old, new in pairs:
        out = out.replace(old, new) if isinstance(out, str) else out.replace(old.encode(), new.encode())
    return out


_w03_run0 = _w03_sp.run


def _w03_run(*a, **k):
    args = a[0] if a else k.get("args")
    args = [str(x) for x in args] if isinstance(args, (list, tuple)) else None
    if not args or _w03_os.path.basename(args[0]) != "git" or "diff" not in args[1:]:
        return _w03_run0(*a, **k)
    if _W03_KIND == "quoted" and "-z" in args:
        args2 = [x for x in args if x != "-z"]
        if a:
            a = (args2,) + tuple(a[1:])
        else:
            k = dict(k, args=args2)
        r = _w03_run0(*a, **k)
        _w03_mark("quoted")
        if r.stdout is not None:
            r.stdout = _w03_swap(r.stdout, (("\t", "\0"), ("\n", "\0")))
        return r
    r = _w03_run0(*a, **k)
    if _W03_KIND == "diff_failed_as_empty" and r.returncode:
        _w03_mark("diff_failed_as_empty")
        empty = "" if isinstance(r.stdout, str) else b""
        return _w03_sp.CompletedProcess(r.args, 0, empty, empty)
    if _W03_KIND == "added_as_modified" and not r.returncode and r.stdout:
        sep, add, mod = ("\0", "A", "M") if isinstance(r.stdout, str) else (b"\0", b"A", b"M")
        fields = r.stdout.split(sep)
        if add in fields:
            _w03_mark("added_as_modified")
            r.stdout = sep.join(mod if f == add else f for f in fields)
    return r


_w03_sp.run = _w03_run
_w03_open0 = _w03_ur.OpenerDirector.open


def _w03_resp(url, data):
    h = _w03_em.Message()
    h["Content-Type"] = "text/plain; charset=utf-8"
    return _w03_uresp.addinfourl(_w03_io.BytesIO(data), h, url, 200)


def _w03_open(self, fullurl, *a, **k):
    url = fullurl.full_url if hasattr(fullurl, "full_url") else str(fullurl)
    path = url.split("?", 1)[0]
    try:
        r = _w03_open0(self, fullurl, *a, **k)
    except _w03_ue.HTTPError as e:
        kind = e.headers.get("X-W03-Fixture") if e.headers is not None else None
        if e.code == 404 and path.endswith("/logs") and (
                (_W03_KIND == "skipped_404_as_clean" and kind == "skipped")
                or (_W03_KIND == "ran_404_as_clean" and kind == "missing")):
            _w03_mark(_W03_KIND)
            line = _w03_json.dumps({"project": e.headers.get("X-W03-Fixture-Project"),
                                    "commit": e.headers.get("X-W03-Fixture-Commit"), "result": "no_difference",
                                    "applied_versions": [], "differences": []}, separators=(",", ":"))
            return _w03_resp(url, ("2026-10-13T06:41:30.0000000Z W03REPORT " + line + "\n").encode())
        raise
    if _W03_KIND == "skipped_404_as_clean" and _w03_re.search(r"/actions/runs/\d+(/attempts/\d+)?/jobs$", path):
        data = _w03_json.loads(r.read())
        jobs = data.get("jobs") or []
        ran = [j for j in jobs if j.get("conclusion") != "skipped"]
        for i, j in enumerate(jobs):
            if j.get("conclusion") == "skipped" and ran:
                jobs[i] = dict(ran[0], id=j.get("id"), name=j.get("name"), url=j.get("url"))
        return _w03_resp(url, _w03_json.dumps(data).encode())
    if _W03_KIND == "report_without_differences" and path.endswith("/logs"):
        out = []
        for ln in r.read().decode("utf-8", "replace").splitlines(True):
            m = _w03_re.match(r"^(\S+ W03REPORT )(\{.*\})(\s*)$", ln)
            if m:
                rep = _w03_json.loads(m.group(2))
                rep.pop("differences", None)
                ln = m.group(1) + _w03_json.dumps(rep, separators=(",", ":")) + m.group(3)
                _w03_mark("report_without_differences")
            out.append(ln)
        return _w03_resp(url, "".join(out).encode())
    return r


_w03_ur.OpenerDirector.open = _w03_open
# ---- end of the prelude; the step's body follows unchanged ----
'''


def with_prelude(code, kind):
    lines = code.splitlines(True)
    cut = 0
    for k, ln in enumerate(lines):  # a `from __future__` import must stay first
        if re.match(r"\s*from\s+__future__\s+import\b", ln):
            cut = k + 1
    return "".join(lines[:cut]) + PRELUDE.replace("__KIND__", kind) + "".join(lines[cut:])


class SetupError(Exception):
    pass


def git_env(home, author=False):
    e = {"PATH": os.environ.get("PATH", "/usr/bin:/bin"), "HOME": str(home), "LANG": "C.UTF-8", "LC_ALL": "C.UTF-8",
         "GIT_CONFIG_NOSYSTEM": "1", "GIT_CONFIG_GLOBAL": os.devnull, "GIT_TERMINAL_PROMPT": "0"}
    if author:
        for who in ("AUTHOR", "COMMITTER"):
            e[f"GIT_{who}_NAME"] = "w03-fixture"
            e[f"GIT_{who}_EMAIL"] = "w03-fixture@example.invalid"
            e[f"GIT_{who}_DATE"] = "2026-10-13T00:00:00Z"
    return e


def git(cwd, env, *args):
    try:
        r = subprocess.run(["git", *args], cwd=cwd, env=env, capture_output=True, timeout=60)
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise SetupError(f"git {args[0]}: {type(exc).__name__}")
    if r.returncode:
        raise SetupError(f"git {args[0]}: exit {r.returncode}: {r.stderr.decode('utf-8', 'replace').strip()[:160]}")
    return r.stdout.decode("utf-8", "replace").strip()


def write(root, rel, text, append=False):
    p = Path(root, rel)
    p.parent.mkdir(parents=True, exist_ok=True)
    with open(p, "a" if append else "w", encoding="utf-8") as f:
        f.write(text)


def renamed(rel):
    return rel[:-len(".sql")] + "_renamed.sql"


def main_tree(root):
    for key, (ver, rel) in FILES.items():
        write(root, rel, f"-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-15\n-- {ver} {key}\n"
                         f"select 1;\n")
    write(root, DOC, "w03 fixture note\n")


def apply_ops(root, ops, env):
    for op, key in ops:
        if op == "A":
            write(root, NEW, "-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-15\nselect 9;\n")
        elif op == "doc":
            write(root, DOC, "w03 fixture change\n", append=True)
        elif op == "M":
            write(root, FILES[key][1], "-- w03 fixture change\n", append=True)
        elif op == "D":
            Path(root, FILES[key][1]).unlink()
        elif op == "R":
            git(root, env, "mv", "--", FILES[key][1], renamed(FILES[key][1]))


def build(c, base, home):
    """The checkout pr_inputs runs in: (work tree, main's head, HEAD). origin is a bare repository in base."""
    env = git_env(home, author=True)
    d = Path(base, c["id"])
    origin, work = d / "origin.git", d / "work"
    work.mkdir(parents=True)
    git(d, env, "init", "-q", "--bare", "-b", "main", str(origin))
    git(work, env, "init", "-q", "-b", "main")
    git(work, env, "remote", "add", "origin", str(origin))
    main_tree(work)
    if c["kind"] == "root":
        apply_ops(work, c["ops"], env)
        git(work, env, "add", "-A")
        git(work, env, "commit", "-q", "-m", "w03 fixture: a commit with no parent")
        head = git(work, env, "rev-parse", "HEAD")
        git(work, env, "push", "-q", "origin", "HEAD:refs/heads/main")
        return work, head, head
    git(work, env, "add", "-A")
    git(work, env, "commit", "-q", "-m", "w03 fixture: main")
    main = git(work, env, "rev-parse", "HEAD")
    git(work, env, "push", "-q", "origin", "HEAD:refs/heads/main")
    git(work, env, "checkout", "-q", "-b", "w03-fixture-pr")
    apply_ops(work, c["ops"], env)
    git(work, env, "add", "-A")
    git(work, env, "commit", "-q", "-m", "w03 fixture: the pull request's change")
    git(work, env, "checkout", "-q", "--detach", main)
    git(work, env, "merge", "-q", "--no-ff", "--no-edit", "w03-fixture-pr")  # as GitHub's merge commit: parent 1 is main
    head = git(work, env, "rev-parse", "HEAD")
    if c["kind"] == "shallow":
        git(work, env, "push", "-q", "origin", "HEAD:refs/heads/w03-fixture-merge")
        shallow = d / "shallow"
        git(d, env, "clone", "-q", "--depth", "1", "--branch", "w03-fixture-merge", origin.as_uri(), str(shallow))
        return shallow, main, head
    return work, main, head


def report_line(project, event, commit):
    rep = {"project": project, "event": event, "run_id": str(RUN_ID), "commit": commit, "head": "yes",
           "credential_present": "yes", "connection": "ok", "listing_count": "12", "result": "differences",
           "differences": [{"kind": "on_main_not_applied", "version": PENDING}], "applied_versions": list(APPLIED)}
    return json.dumps(rep, separators=(",", ":"))


def log_text(project, event, commit):
    return "".join(f"2026-10-13T06:41:{i:02d}.{i:07d}Z {ln}\n" for i, ln in enumerate((
        "##[group]Runner Image", "Image: ubuntu-24.04", "##[endgroup]", "##[group]Run import json, os",
        "shell: /usr/bin/python {0}", "##[endgroup]", "W03REPORT " + report_line(project, event, commit),
        "Cleaning up orphan processes")))


def stub_state(c, main_head, api, display):
    shape, event = SHAPES[c["shape"]], EVENT[c["shape"]]
    run = {"id": RUN_ID, "name": "migrate", "path": ".github/workflows/migrate.yml", "head_branch": "main",
           "head_sha": main_head, "event": event, "status": "completed", "conclusion": "success", "run_attempt": 1,
           "created_at": "2026-10-13T06:41:00Z", "updated_at": "2026-10-13T06:49:00Z",
           "jobs_url": f"{api}/repos/{REPO_NAME}/actions/runs/{RUN_ID}/jobs"}
    jobs, logs, skipped, missing = [], {}, {}, {}
    for name, conclusion in shape:
        jid = JOB_IDS[name]
        ran = conclusion != "skipped"
        jobs.append({"id": jid, "run_id": RUN_ID, "workflow_name": "migrate", "head_branch": "main",
                     "head_sha": main_head, "status": "completed", "conclusion": conclusion, "name": display[name],
                     "url": f"{api}/repos/{REPO_NAME}/actions/jobs/{jid}", "run_attempt": 1,
                     "started_at": "2026-10-13T06:41:00Z", "completed_at": "2026-10-13T06:48:00Z" if ran else
                     "2026-10-13T06:41:00Z", "labels": ["ubuntu-24.04"],
                     "runner_name": "GitHub Actions 1000000001" if ran else None,
                     "steps": [{"name": "report", "status": "completed", "conclusion": "success", "number": 20}]
                     if ran else []})
        if not ran:
            skipped[jid] = (OWN[name], main_head)
        elif c["missing"] == name:
            missing[jid] = (OWN[name], main_head)
        else:
            logs[jid] = log_text(OWN[name], event, main_head)
    return {"runs": [run], "jobs": jobs, "logs": logs, "skipped": skipped, "missing": missing}


class Stub:
    """GitHub's REST API as pr_inputs reads it, on 127.0.0.1: workflow runs, a run's jobs, a job's log (302 to a blob
    for a job that ran; 404 for a skipped job and for a ran job whose log is missing)."""

    def __init__(self):
        self.state, self.unrouted = {}, []
        stub = self

        class Handler(BaseHTTPRequestHandler):
            def log_message(self, *a):
                pass

            def do_GET(self):
                stub.route(self)

        self.httpd = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
        self.url = f"http://127.0.0.1:{self.httpd.server_address[1]}"
        threading.Thread(target=self.httpd.serve_forever, daemon=True).start()

    def close(self):
        self.httpd.shutdown()
        self.httpd.server_close()

    def route(self, h):
        def send(code, body=b"", ctype="application/json; charset=utf-8", headers=()):
            h.send_response(code)
            h.send_header("Content-Type", ctype)
            h.send_header("Content-Length", str(len(body)))
            for k, val in headers:
                h.send_header(k, val)
            h.end_headers()
            h.wfile.write(body)

        def js(obj, code=200, headers=()):
            send(code, json.dumps(obj).encode(), headers=headers)

        not_found = {"message": "Not Found",
                     "documentation_url": "https://docs.github.com/rest/actions/workflow-jobs", "status": "404"}
        u = urlsplit(h.path)
        path, q = u.path.rstrip("/"), {k: val[-1] for k, val in parse_qs(u.query).items()}
        st, pre = self.state, re.escape(f"/repos/{REPO_NAME}/actions")
        page = q.get("page", "1")
        first = page == "1"
        if re.fullmatch(pre + r"(/workflows/migrate\.yml)?/runs", path):
            runs = [r for r in st.get("runs", [])
                    if all(q.get(k) in (None, str(r.get(f))) for k, f in (("branch", "head_branch"),
                                                                           ("head_sha", "head_sha"), ("event", "event")))
                    and q.get("status") in (None, r.get("status"), r.get("conclusion"))]
            return js({"total_count": len(runs), "workflow_runs": runs if first else []})
        m = re.fullmatch(pre + r"/runs/(\d+)", path)
        if m:
            run = [r for r in st.get("runs", []) if str(r["id"]) == m.group(1)]
            return js(run[0]) if run else js(not_found, 404)
        m = re.fullmatch(pre + r"/runs/(\d+)(?:/attempts/\d+)?/jobs", path)
        if m:
            jobs = st.get("jobs", []) if m.group(1) == str(RUN_ID) else []
            return js({"total_count": len(jobs), "jobs": jobs if first else []})
        m = re.fullmatch(pre + r"/jobs/(\d+)", path)
        if m:
            job = [j for j in st.get("jobs", []) if str(j["id"]) == m.group(1)]
            return js(job[0]) if job else js(not_found, 404)
        m = re.fullmatch(pre + r"/jobs/(\d+)/logs", path)
        if m:
            jid = int(m.group(1))
            if jid in st.get("logs", {}):
                return send(302, headers=[("Location", f"{self.url}/w03-fixture-blob/{jid}")])
            for kind in ("skipped", "missing"):
                if jid in st.get(kind, {}):
                    proj, commit = st[kind][jid]
                    return js(not_found, 404, headers=[("X-W03-Fixture", kind), ("X-W03-Fixture-Project", proj),
                                                       ("X-W03-Fixture-Commit", commit)])
            return js(not_found, 404)
        m = re.fullmatch(r"/w03-fixture-blob/(\d+)", path)
        if m and int(m.group(1)) in st.get("logs", {}):
            return send(200, st["logs"][int(m.group(1))].encode(), "text/plain; charset=utf-8")
        self.unrouted.append(path)
        return js(not_found, 404)


def parse_output(text):
    out, lines, i = {}, text.splitlines(), 0
    while i < len(lines):
        m = re.match(r"^([A-Za-z_][A-Za-z0-9_-]*)<<(.+)$", lines[i])
        if m:
            name, delim, buf = m.group(1), m.group(2), []
            i += 1
            while i < len(lines) and lines[i] != delim:
                buf.append(lines[i])
                i += 1
            out[name] = "\n".join(buf)
        elif "=" in lines[i]:
            k, val = lines[i].split("=", 1)
            out[k.strip()] = val.strip()
        i += 1
    return out


def step_env(home, work, api, head):
    """The environment GitHub gives a step, with every host but 127.0.0.1 sent to a dead proxy."""
    e = git_env(home)
    dead = "http://127.0.0.1:9"
    e.update({"http_proxy": dead, "https_proxy": dead, "HTTP_PROXY": dead, "HTTPS_PROXY": dead,
              "no_proxy": "127.0.0.1", "NO_PROXY": "127.0.0.1", "CI": "true", "GITHUB_ACTIONS": "true",
              "GITHUB_REPOSITORY": REPO_NAME, "GITHUB_API_URL": api, "GITHUB_SERVER_URL": dead,
              "GITHUB_EVENT_NAME": "pull_request", "GITHUB_SHA": head, "GITHUB_REF": "refs/pull/1/merge",
              "GITHUB_WORKSPACE": str(work), "GITHUB_RUN_ID": "9000000099", "GITHUB_JOB": "migration-checks"})
    return e


def run_body(code, env, cwd):
    with tempfile.TemporaryDirectory(prefix="w03g2-step-") as d:
        prog, out, summary = Path(d, "step.py"), Path(d, "github_output"), Path(d, "step_summary")
        prog.write_text(code, encoding="utf-8")
        out.write_text("", encoding="utf-8")
        summary.write_text("", encoding="utf-8")
        e = dict(env, GITHUB_OUTPUT=str(out), GITHUB_STEP_SUMMARY=str(summary), RUNNER_TEMP=d)
        try:
            r = subprocess.run([sys.executable, "-I", str(prog)], env=e, cwd=cwd, capture_output=True, timeout=120)
        except subprocess.TimeoutExpired:
            return {"exit": None, "stdout": "", "stderr": "timeout", "outputs": {}}
        return {"exit": r.returncode, "stdout": r.stdout.decode("utf-8", "replace"),
                "stderr": r.stderr.decode("utf-8", "replace"),
                "outputs": parse_output(out.read_text(encoding="utf-8", errors="replace"))}


def state_entries(state):
    entries = {}
    for part in (state or "").split("; "):
        name, sep, rest = part.partition(": ")
        if sep and name in PROJECTS:
            entries[name] = rest
    return entries


def judge(c, inputs, decide):
    """The problems of one case's result; empty means it gave what the case asks."""
    problems = []
    verdict = decide["outputs"].get("verdict")
    if verdict != c["verdict"]:
        problems.append(f"verdict {verdict!r}, wanted {c['verdict']!r}")
    if c["verdict"] == "pass":
        if inputs["exit"] != 0:
            problems.append(f"pr_inputs exited {inputs['exit']} (on GitHub the job would fail)")
        if decide["exit"] != 0:
            problems.append(f"pr_decide exited {decide['exit']}")
    entries = state_entries(decide["outputs"].get("state"))
    for p, want in c["read"].items():
        entry = entries.get(p)
        if entry is None:
            problems.append(f"the state does not name {p}")
        elif want == "read":
            if "could not check" in entry:
                problems.append(f"{p}: {entry[:90]!r}; wanted its records' state, read from the job that ran")
            elif PENDING not in entry:
                problems.append(f"{p}: the state {entry[:90]!r} does not name {PENDING}, which its report lists")
        elif "could not check" not in entry:
            problems.append(f"{p}: {entry[:90]!r}; wanted could not check (its job's log answered 404)")
    if c["cnc_reason"]:
        rest = decide["stdout"].replace(decide["outputs"].get("state") or "\0", "")
        if "could not check" not in rest:
            problems.append("pr_decide's reason does not say could not check")
    return problems


class G2Run:
    """Builds every case's checkout once, and runs bodies against them with the stub."""

    def __init__(self, display):
        self.display = display
        self.tmp = tempfile.TemporaryDirectory(prefix="w03g2-")
        self.home = Path(self.tmp.name, "home")
        self.home.mkdir()
        self.stub = Stub()
        self.built = {}
        for c in CASES:
            try:
                self.built[c["id"]] = build(c, Path(self.tmp.name, "repos"), self.home)
            except (SetupError, OSError) as exc:
                self.built[c["id"]] = exc

    def close(self):
        self.stub.close()
        self.tmp.cleanup()

    def run(self, c, inputs_code, decide_code, inputs_env, decide_wiring, kind=None):
        """(problems, the prelude fired, detail) or a SetupError for a checkout that could not be made."""
        b = self.built[c["id"]]
        if isinstance(b, Exception):
            return b
        work, main_head, head = b
        self.stub.state = stub_state(c, main_head, self.stub.url, self.display)
        self.stub.unrouted = []
        env = step_env(self.home, work, self.stub.url, head)
        mark = Path(self.tmp.name, "mark")
        mark.write_text("", encoding="utf-8")
        e1 = dict(env, W03_BREAK_MARK=str(mark))
        ctx = {"github.token": TOKEN, "github.repository": REPO_NAME, "github.api_url": self.stub.url,
               "github.event_name": "pull_request", "github.sha": head}
        for k, val in inputs_env.items():
            e1[k] = ctx[val[1]] if isinstance(val, tuple) else val
        inputs = run_body(with_prelude(inputs_code, kind) if kind else inputs_code, e1, work)
        e2 = dict(env)
        for k, name in decide_wiring.items():
            e2[k] = inputs["outputs"].get(name, "")
        decide = run_body(decide_code, e2, work)
        problems = judge(c, inputs, decide)
        fired = bool(mark.read_text(encoding="utf-8").strip())
        detail = (f"verdict {decide['outputs'].get('verdict')!r}; state {decide['outputs'].get('state', '')[:150]!r}"
                  + (f"; requests the stub does not serve: {sorted(set(self.stub.unrouted))}" if self.stub.unrouted
                     else "")
                  + (f"; pr_inputs stderr: {inputs['stderr'].strip().splitlines()[-1][:120]!r}"
                     if inputs["stderr"].strip() else ""))
        return problems, fired, detail


EXPR = re.compile(re.escape(OPEN) + r"\s*([A-Za-z0-9_.-]+)\s*\}\}")


def step_code(repo, step):
    run = step.get("run")
    if not isinstance(run, str):
        return None, "the step has no run body"
    if OPEN in run:
        return None, "its run body holds an expression opener, so GitHub runs another text than this (G1)"
    if step.get("shell") == "python":
        return run, None
    words = shlex.split(run.strip()) if "\n" not in run.strip() else []
    if len(words) in (2, 3) and words[0] == "python3" and (len(words) == 2 or words[1] == "-I"):
        rel = words[-1]
        if rel.startswith(HIGH_PREFIXES) and ".." not in rel.split("/") and (repo / rel).is_file():
            return (repo / rel).read_text(encoding="utf-8"), None
        return None, f"{rel} is not a class-high file at this head"
    return None, "the step is neither shell: python nor a one-line python3 <class-high file>"


def wiring_of(repo):
    """(inputs code, decide code, inputs env, decide wiring, display names) or (None, reason)."""
    yaml = yaml_module()
    if yaml is None:
        return None, "PyYAML is not installed"
    for rel in (CHECKS, MIGRATE):
        if not (repo / rel).is_file():
            return None, f"{rel} is absent"
    try:
        checks = yaml.safe_load((repo / CHECKS).read_text(encoding="utf-8"))
        migrate = yaml.safe_load((repo / MIGRATE).read_text(encoding="utf-8"))
    except Exception as exc:
        return None, f"a workflow does not parse ({type(exc).__name__})"
    steps = {}
    for job in ((checks or {}).get("jobs") or {}).values():
        for s in (job or {}).get("steps") or []:
            if isinstance(s, dict) and s.get("id") in ("pr_inputs", "pr_decide"):
                steps.setdefault(s["id"], s)
    for sid in ("pr_inputs", "pr_decide"):
        if sid not in steps:
            return None, f"{CHECKS} has no step with id {sid}"
    codes = {}
    for sid in ("pr_inputs", "pr_decide"):
        code, why = step_code(repo, steps[sid])
        if code is None:
            return None, f"{sid}: cannot run the step's own code: {why}"
        codes[sid] = code
    inputs_env = {}
    for k, val in (steps["pr_inputs"].get("env") or {}).items():
        val = str(val)
        m = EXPR.fullmatch(val.strip())
        if m and m.group(1) in ("github.token", "github.repository", "github.api_url", "github.event_name",
                                "github.sha"):
            inputs_env[k] = ("expr", m.group(1))
        elif OPEN in val:
            return None, f"pr_inputs' env {k} is not a form this test fills ({val[:60]!r})"
        else:
            inputs_env[k] = val
    decide_wiring = {}
    for k, val in (steps["pr_decide"].get("env") or {}).items():
        m = EXPR.fullmatch(str(val).strip())
        if not m or not m.group(1).startswith("steps.pr_inputs.outputs."):
            return None, f"pr_decide's env {k} is not taken from steps.pr_inputs.outputs ({str(val)[:60]!r})"
        decide_wiring[k] = m.group(1).rsplit(".", 1)[1]
    jobs = (migrate or {}).get("jobs") or {}
    if set(jobs) != set(OBSERVED_ORDER):
        return None, (f"{MIGRATE}'s jobs {sorted(jobs)} are not the four the observed job list names; the shape this "
                      f"test stubs no longer describes the workflow (the test designer revises it)")
    display = {j: str((jobs[j] or {}).get("name") or j) for j in OBSERVED_ORDER}
    return (codes["pr_inputs"], codes["pr_decide"], inputs_env, decide_wiring, display), None


def g2_cases(runner, tally, inputs_code, decide_code, inputs_env, decide_wiring):
    """Runs every case on the given bodies; returns {case id: 'ok' | 'red' | 'cnc'}."""
    status = {}
    for c in CASES:
        r = runner.run(c, inputs_code, decide_code, inputs_env, decide_wiring)
        label = f"{c['id']} {c['what']}"
        if isinstance(r, Exception):
            tally.say("CNC", label, f"the checkout could not be made: {r}")
            status[c["id"]] = "cnc"
            continue
        problems, _, detail = r
        tally.say("BAD" if problems else "ok", label, "; ".join(problems) + (" | " if problems else "") + detail)
        status[c["id"]] = "red" if problems else "ok"
    return status


def g2_breaks(runner, tally, base, inputs_code, decide_code, inputs_env, decide_wiring):
    shown = not_shown = 0
    for bid, kind, what, must_red, must_stay in BREAKS:
        reds, still, spill, unfired, fired_any, already = [], [], [], [], False, []
        for c in CASES:
            if c["id"] not in must_red and c["id"] not in must_stay:
                continue
            r = runner.run(c, inputs_code, decide_code, inputs_env, decide_wiring, kind=kind)
            if isinstance(r, Exception):
                continue
            problems, fired, _ = r
            fired_any = fired_any or fired
            if c["id"] in must_red:
                if base.get(c["id"]) != "ok":
                    already.append(c["id"])
                elif not fired:
                    unfired.append(c["id"])
                elif problems:
                    reds.append(c["id"])
                else:
                    still.append(c["id"])
            elif problems and base.get(c["id"]) == "ok":
                spill.append(f"{c['id']} ({problems[0][:70]})")
        label = f"break {bid} (a copy that {what})"
        if still or spill:
            tally.say("BAD", label, (f"does NOT turn {still} red" if still else "") + ("; " if still and spill else "")
                      + (f"turns cases it cannot touch red: {spill}" if spill else ""))
        elif reds:
            shown += 1
            tally.say("ok", label, f"turns {reds} red, as it must, and leaves the {len(must_stay)} cases it cannot "
                                   f"touch as they were" + (f"; not shown on {already}: the head already fails them"
                                                            if already else "")
                      + (f"; the copy's change was not reached in {unfired}" if unfired else ""))
        elif already and not unfired:
            not_shown += 1
            print(f"n/a  G2 {label}: not shown: the head already fails {already}")
        else:
            tally.say("CNC", label, "the break could not be made on this body: the call it changes was not reached"
                      + (f" ({unfired})" if unfired else "") + ("" if fired_any else "; it never fired"))
    return shown, not_shown


def g2(repo, tally, impl=None):
    w, why = wiring_of(repo)
    if w is None:
        tally.say("CNC", "pr_inputs and pr_decide", why)
        print(f"W03_PR_INPUTS_TEST COULD NOT CHECK ({why}; none passed in its place)")
        return 3
    inputs_code, decide_code, inputs_env, decide_wiring, display = w
    head = "W03_PR_INPUTS_TEST"
    tail = ""
    if impl:
        inputs_code = Path(impl).read_text(encoding="utf-8")
        head += " (break-copy run)"
        tail = f"; {impl} ran instead of the workflow's pr_inputs; not a result of the workflow"
    try:
        runner = G2Run(display)
    except OSError as exc:
        print(f"{head} COULD NOT CHECK (the stub could not start: {type(exc).__name__}{tail})")
        return 3
    try:
        base = g2_cases(runner, tally, inputs_code, decide_code, inputs_env, decide_wiring)
        shown, not_shown = (0, 0) if impl else g2_breaks(runner, tally, base, inputs_code, decide_code, inputs_env,
                                                         decide_wiring)
    finally:
        runner.close()
    red = [k for k, s in base.items() if s == "red"]
    if tally.bad:
        print(f"{head} FAIL ({len(red)} of {len(CASES)} cases red{': ' + ', '.join(red) if red else ''}; "
              f"{tally.bad} bad in all, {tally.cnc} could not check{tail})")
        return 1
    if tally.cnc:
        print(f"{head} COULD NOT CHECK ({tally.cnc} could not be checked; none passed in their place{tail})")
        return 3
    print(f"{head} PASS ({len(CASES)}/{len(CASES)} cases; breaks: {shown} shown, {not_shown} not shown, of "
          f"{len(BREAKS)}{tail})")
    return 0


# ==== self-check ===================================================================================================

ALWAYS_CLEAN = ("import os\nwith open(os.environ['GITHUB_OUTPUT'], 'a') as f:\n"
                "    f.write('changed<<W03EOF\\n[]\\nW03EOF\\nrun_report<<W03EOF\\n\\nW03EOF\\nmain_head<<W03EOF\\n\\n"
                "W03EOF\\n')\n")
CRASH = "raise SystemExit(1)\n"
FROZEN_WIRING = ({"GH_TOKEN": ("expr", "github.token")},
                 {"CHANGED": "changed", "RUN_REPORT": "run_report", "MAIN_HEAD": "main_head"})


def self_check():
    results = []
    yaml = yaml_module()
    with tempfile.TemporaryDirectory(prefix="w03self-") as d:
        # G1 on synthetic folders
        def folder(name, files):
            f = Path(d, name, ".github", "workflows")
            f.mkdir(parents=True)
            for fn, text in files.items():
                (f / fn).write_text(text, encoding="utf-8")
            return f
        clean = folder("g1clean", {"w03-fixture-control.yml": CONTROL})
        for label, f, want in (
                ("G1 control file (openers outside run:, '$ {{' split): pass", clean, "pass"),
                ("G1 opener in a heredoc in a block scalar: fail", folder("g1block", {"a.yml": PLANT_BLOCK}), "fail"),
                ("G1 opener as a YAML escape: fail", folder("g1esc", {"a.yml": PLANT_ESCAPED}), "fail"),
                ("G1 a file that is not YAML: could not check",
                 folder("g1bad", {"a.yml": CONTROL, "b.yml": "jobs: [w03 fixture\n"}), "cnc"),
                ("G1 a run: value that is a list: could not check",
                 folder("g1list", {"a.yml": "on: push\njobs:\n  j:\n    steps:\n      - run: [a, b]\n"}), "cnc"),
                ("G1 no workflows folder: could not check", Path(d, "g1none", ".github", "workflows"), "cnc")):
            p, c, _, _ = g1_scan(f)
            got = "fail" if p else "cnc" if c else "pass"
            results.append((label, got == want, f"{got}: {(p or c or ['-'])[0][:100]}"))
        planted = g1_copies(clean)
        results.append(("G1 break and controls on a clean synthetic folder",
                        all(tag == "ok" for _, tag, _ in planted) and len(planted) == 4,
                        "; ".join(f"{label}: {tag}" for label, tag, _ in planted)[:200]))
        # G2
        if yaml is None:
            results.append(("G2", False, "PyYAML is not installed"))
        elif not (FROZEN_INPUTS.is_file() and FROZEN_DECIDE.is_file()):
            results.append(("G2 frozen bodies", False, f"{FROZEN_INPUTS.name} or {FROZEN_DECIDE.name} is absent"))
        else:
            inputs, decide = FROZEN_INPUTS.read_text(encoding="utf-8"), FROZEN_DECIDE.read_text(encoding="utf-8")
            runner = G2Run(DISPLAY_AT_FROZEN)
            try:
                for label, code, want in (
                        (f"G2 main {FROZEN}'s pr_inputs: (a), (b), (c), D5, D6 pass; D1 to D4, E1, E2 red", inputs,
                         {**{k: "ok" for k in A_ALL + B_ALL + C_ALL + ["D5", "D6"]},
                          **{k: "red" for k in ["D1", "D2", "D3", "D4"] + E_ALL}}),
                        ("G2 a body that always reports no change and no report: (a), (b) and the controls red",
                         ALWAYS_CLEAN, {**{k: "red" for k in A_ALL + B_ALL + C_ALL}}),
                        ("G2 a crashing body: every positive control red", CRASH,
                         {k: "red" for k in ["C1", "C2", "D1", "D2", "D3", "D4"]})):
                    t = Tally("G2", quiet=True)
                    got = g2_cases(runner, t, code, decide, *FROZEN_WIRING)
                    wrong = sorted(k for k, s in want.items() if got.get(k) != s)
                    results.append((label, not wrong, f"as stated" if not wrong else f"differs on {wrong}: "
                                    f"{ {k: got.get(k) for k in wrong} }"))
                # the breaks on the frozen body: each must turn red what it can, or be not shown where already red
                t = Tally("G2", quiet=True)
                base = g2_cases(runner, t, inputs, decide, *FROZEN_WIRING)
                tb = Tally("G2", quiet=True)
                stdout = sys.stdout
                try:
                    sys.stdout = open(os.devnull, "w")
                    g2_breaks(runner, tb, base, inputs, decide, *FROZEN_WIRING)
                finally:
                    sys.stdout.close()
                    sys.stdout = stdout
                results.append((f"G2 the breaks on main {FROZEN}'s body: none BAD, none could not be made",
                                tb.bad == 0 and tb.cnc == 0, f"{tb.ok} shown, {tb.bad} bad, {tb.cnc} could not check"))
            finally:
                runner.close()
            for label, files, wantfrag in (
                    ("G2 a repository without the workflows: could not check", {}, "is absent"),
                    ("G2 pr_inputs' body holding an expression opener: could not check",
                     {"x": None}, "expression opener")):
                r = Path(d, "g2repo" + str(len(results)))
                (r / ".github" / "workflows").mkdir(parents=True)
                if files:
                    src = Path(__file__).resolve().parents[3]
                    for rel in (CHECKS, MIGRATE):
                        if (src / rel).is_file():
                            shutil.copyfile(src / rel, r / rel)
                    if (r / CHECKS).is_file():
                        wf = yaml.safe_load((r / CHECKS).read_text(encoding="utf-8"))
                        for job in wf["jobs"].values():
                            for s in job.get("steps") or []:
                                if s.get("id") == "pr_inputs":
                                    s["run"] = s["run"] + f"\n# {OPEN} github.sha }}}}\n"
                        (r / CHECKS).write_text(dump_yaml(wf), encoding="utf-8")
                    else:
                        results.append((label, False, f"{CHECKS} is not at this head to copy"))
                        continue
                w, why = wiring_of(r)
                results.append((label, w is None and wantfrag in (why or ""), why or "it was run"))
    for label, good, detail in results:
        print(f"{'ok  ' if good else 'BAD '} self-check {label} ({detail})")
    good = all(g for _, g, _ in results)
    print(f"W03_GUARDS_SELF_CHECK {'PASS' if good else 'FAIL'} ({sum(1 for _, g, _ in results if g)}/{len(results)})")
    return 0 if good else 1


def main(argv):
    repo = Path(__file__).resolve().parents[3]
    impl = None
    args = list(argv)
    while args:
        a = args.pop(0)
        if a == "--repo" and args:
            repo = Path(args.pop(0)).resolve()
        elif a == "--impl" and args:
            k, _, val = args.pop(0).partition("=")
            if k != "pr_inputs" or not val:
                print("--impl takes pr_inputs=FILE")
                return 2
            impl = val
        elif a == "--self-check":
            return self_check()
        else:
            print(f"unknown argument {a}")
            return 2
    print("note: G1 reads the workflows and does not run them; G2 runs pr_inputs' and pr_decide's own bodies against "
          "scratch git repositories and a stub of GitHub's REST API on 127.0.0.1")
    a = g1(repo, Tally("G1"))
    b = g2(repo, Tally("G2"), impl)
    return 1 if 1 in (a, b) else 3 if 3 in (a, b) else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
