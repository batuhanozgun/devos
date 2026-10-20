#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): every fixture in this file is made up for the test and
# holds no personal or business data: the package texts, the record IDs (stage C99, which DevOS does not have), the
# evidence, ledger and work-item files, and the planted compaction hooks. Not made up, because the rules under test
# name them: DevOS's own paths (.claude/roles/, the six package names, .claude/hooks/reread_after_compact.py,
# evidence/, plan/ledger/*-log.md, plan/work/*.md), and the real hook, which the fixtures copy byte for byte from the
# checkout beside this file and change only in its MESSAGE assignment.
"""test_check_role_packages.py: planted cases for tools/check_role_packages.py (W-C02-23, PR-A2; SB-COR 2.3).

Written by W-C02-23's test designer before the tool existed (ledger rule 3; working order section 4 step 2). It
runs the tool as the merge gate and the condition run it, `python3 -I tools/check_role_packages.py --root DIR` or,
from inside a repository, `--rev SHA`, on fixture trees it builds in a temporary directory, and reads only the
interface the condition pins (plan/work/W-C02-23.md, "The pinned interface"): the exit code, the lines
`ROLE_PACKAGE <name> bytes=<n> limit=<m> PASS|FAIL <reason>` and the last line `ROLE_PACKAGES PASS|FAIL|COULD NOT
CHECK`, the reason tokens, and the module constants RESERVE, LIMIT and HEADER.

Form C0 (Appendix C), for the whole file:
- Claim: the check passes a tree whose .claude/roles/ holds exactly the six packages, each strict UTF-8 without NUL,
  without a `---` first line, a `name:` line, a `## ` line or a line of 2,000 or more characters, within its limit in
  UTF-8 bytes (9,300 for the five roles; for executor.md 9,300 minus the UTF-8 bytes of the compaction hook's
  MESSAGE plus its newline, MESSAGE read by ast.literal_eval at the same tree or revision), every cited EV, CHK, L
  and N ID resolving by the approach's rules; it fails every other such tree naming the file and the rule; and it
  says COULD NOT CHECK (exit 2) when it cannot measure. Its claim is resolution, not the content of a cited record.
- Failure classes: an oracle that counts characters, ignores RESERVE, ignores MESSAGE or its newline, or counts
  MESSAGE in characters; a missing, extra, misnamed or nested file passing; each form rule missing; an ID resolved
  by a looser rule (a prefix without its delimiter, a heading or marker in the wrong file); `--rev` reading the disk
  instead of the revision; a non-literal MESSAGE read as anything but "could not check"; the hook imported.
- Examples: at least two per class (S1 to S6, D1 to D5, F1 to F6b, I1 to I11, RV1 to RV3, X1 to X4).
- Negative control: each planted fault, with its exit code, its file's FAIL line and its reason token; a fixture with
  one fault must carry exactly that token, so a case cannot pass for another reason (FC1, FC2).
- Positive control: P1 to P7: sound trees, both reading modes agreeing, the limits exactly met, non-ASCII text under
  its limits, the near misses of every form and ID rule, and the repository's own six packages.
- Break: the condition's table (point 9) names, for each rule of the tool, the edit that removes it and the cases
  that must then read BAD; the test designer showed each against a throwaway sketch before the tool existed.
- Stage and environment: C02; the container's python3 (3.13.x) run with -I and git (2.43.0), in a full clone at the
  head. Another interpreter is exploratory for the size and ID claims.
- Independence: written by the test designer before the product; run by the producer, and by the binding checker,
  who builds the breaks itself from `git show` of the head.
- Evidence layer: behavioural (the tool's output on planted trees); P7 is structural on the real tree.
- Evidence envelope: the head SHA, this file's SHA-256, the command and the raw output, in W-C02-23's record.
Prints one line per case and CHECK_ROLE_PACKAGES_TEST PASS only if every case behaves as written.
"""
import importlib.util
import io
import os
import re
import subprocess
import sys
import tempfile
from contextlib import redirect_stderr, redirect_stdout
from pathlib import Path

sys.dont_write_bytecode = True
REPO = Path(__file__).resolve().parent.parent
TOOL = REPO / "tools" / "check_role_packages.py"
HOOK = ".claude/hooks/reread_after_compact.py"
ROLES = ("producer.md", "researcher.md", "prober.md", "checker.md", "test-designer.md", "executor.md")
# Stated by the approach (EV-C02-028 part 10.1, agreed (4)): LIMIT = 9500 - RESERVE, RESERVE = 200. Written here as a
# number, not read from the tool, so a tool with another RESERVE cannot set its own expectation.
LIMIT = 9300
TOKENS = ("size", "utf8", "nul", "front-matter", "name-line", "heading", "long-line", "unresolved", "missing",
          "extra")
LINE = re.compile(r"ROLE_PACKAGE (\S+) bytes=(\S+) limit=(\S+) (PASS|FAIL)(?: (.*))?")
RESULTS = []

# ---------------------------------------------------------------- the fixture's one source

# The six packages of a sound tree. Each cites every resolving ID form, inside and outside a code span, and carries
# the near misses that must pass: a `---` line that is not the first, a `### ` heading, `name:` inside a line, an en
# dash (three bytes), and strings the ID pattern must not cite (MODEL-404, xN-999, SB-L-404, EV-C99-0011, EV-C99-00).
PACKAGE = """# {role}: package (fixture, made up for the test)

The role file and CLAUDE.md bind; this package informs them and never overrides them.

### Methods
1. Size to the claim (D1–D9 answered first; the field name: stays inside the line).
2. Cases: EV-C99-001, `CHK-C99-002`, L-7, N-5 (6), and EV-C99-009 in a nested raw folder.
---
Not citations: MODEL-404, xN-999, SB-L-404, EV-C99-0011, EV-C99-00.
"""
# Records the IDs resolve against, and the decoys that must not resolve (I5 to I10).
RECORDS = {
    "evidence/C99/EV-C99-001_fixture.md": "fixture evidence\n",
    "evidence/C99/checks/CHK-C99-002.md": "fixture verdict\n",
    "evidence/C99/raw/deep/EV-C99-009-nested.md": "fixture raw file, nested two levels\n",
    "evidence/C99/EV-C99-0035_decoy.md": "a name that starts with EV-C99-003 and goes on with a digit\n",
    "plan/EV-C99-012_misplaced.md": "an EV file outside evidence/\n",
    "plan/ledger/C99-log.md": "# C99 log (fixture)\n\n### L-7 · a fixture entry\n\ntext\n\n### L-40 · a decoy\n",
    "plan/ledger/notes.md": "### L-11 · a heading in a file that is not a *-log.md\n",
    "plan/work/W-T-09.md": ("---\nid: W-T-09\n---\n\n<!-- note N-5 status=closed -->\nfixture note\n<!-- /note -->\n\n"
                            "<!-- note N-60 status=open -->\na decoy note\n<!-- /note -->\n"),
    "plan/notes-decoy.md": "<!-- note N-8 status=open -->\na marker outside plan/work/\n<!-- /note -->\n",
}
MSG_RE = re.compile(r'MESSAGE = """.*?"""', re.S)


def real_hook():
    return (REPO / HOOK).read_text(encoding="utf-8")


def planted_hook(assignment):
    """The real hook with its MESSAGE assignment replaced (the only edit), or None when the hook has no such
    assignment, which makes the cases that need it read BAD."""
    text = real_hook()
    return MSG_RE.sub(lambda _: assignment, text, count=1) if MSG_RE.search(text) else None


def pad(text, n):
    """text as UTF-8, filled with lines of z to exactly n bytes (lines under 2,000 characters, no ID, no `## `)."""
    b = text.encode("utf-8")
    assert len(b) + 1 <= n, (len(b), n)
    r = n - len(b)
    return b + b"".join([b"z" * 99 + b"\n"] * (r // 100)) + (b"z" * (r % 100 - 1) + b"\n" if r % 100 else b"")


def build_tree(root, packages=None, hook=None, extra=None, drop=()):
    """Write a sound tree under root: the six packages, the real hook (or `hook`, a text), RECORDS; `packages` maps
    a name to bytes that replace it; `extra` maps further paths (relative to root) to bytes; `drop` lists paths not
    written. Returns root."""
    root = Path(root)
    files = {f".claude/roles/{n}": PACKAGE.format(role=n[:-3]).encode("utf-8") for n in ROLES}
    files.update({f".claude/roles/{n}": b for n, b in (packages or {}).items()})
    files[HOOK] = (real_hook() if hook is None else hook).encode("utf-8")
    files.update({p: t.encode("utf-8") for p, t in RECORDS.items()})
    files.update(extra or {})
    for p, b in files.items():
        if p in drop:
            continue
        (root / p).parent.mkdir(parents=True, exist_ok=True)
        (root / p).write_bytes(b)
    return root


def hook_bytes(hook_path):
    """The independent oracle for the executor's subtraction: the bytes the hook really writes (MESSAGE and its
    newline), measured by running it, not by reading its source."""
    r = subprocess.run([sys.executable, "-I", str(hook_path)], capture_output=True)
    return len(r.stdout)


def git(cwd, *a):
    r = subprocess.run(["git", "-C", str(cwd), *a], capture_output=True, text=True)
    assert r.returncode == 0, f"git {a}: {r.stderr}"
    return r.stdout.strip()


def commit_tree(root):
    git(root.parent, "init", "-q", "-b", "main", str(root))
    for k, v in (("user.name", "Fixture"), ("user.email", "fixture@example.invalid"), ("commit.gpgsign", "false")):
        git(root, "config", k, v)
    git(root, "add", "-A")
    git(root, "commit", "-q", "-m", "fixture tree")
    return git(root, "rev-parse", "HEAD")


# ---------------------------------------------------------------- running and reading the tool

def run_tool(args, cwd):
    if not TOOL.is_file():
        return None, f"{TOOL.relative_to(REPO)} absent"
    r = subprocess.run([sys.executable, "-I", str(TOOL), *args], cwd=cwd, capture_output=True, text=True,
                       errors="replace")
    return r.returncode, r.stdout + ("\n[stderr] " + r.stderr if r.stderr else "")


def parse(out):
    files, summary = {}, None
    for line in out.splitlines():
        m = LINE.fullmatch(line.strip())
        if m:
            files.setdefault(m.group(1), []).append(m.groups()[1:])
    lines = [x.strip() for x in out.splitlines() if x.strip() and not x.startswith("[stderr]")]
    if lines and lines[-1].startswith("ROLE_PACKAGES "):
        summary = lines[-1]
    return files, summary


def tokens(reason):
    return {t for t in TOKENS if re.search(rf"(?<![\w-]){re.escape(t)}(?![\w-])", reason or "")}


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {detail[-700:]}"))
    RESULTS.append(ok)


def judge(label, rc, out, want_rc, want, faults=None, limits=None, sizes=None, extra_name=None):
    """want: 'PASS' or 'FAIL'. faults: {name: (token, id or None)} for the files that must FAIL; every other one of
    the six must PASS. limits / sizes: {name: expected limit= / bytes= value}. extra_name: a prefix of the name an
    extra entry's FAIL line must carry, with the token `extra`."""
    if rc is None:
        return case(label, False, out)
    files, summary = parse(out)
    why = []
    if rc != want_rc:
        why.append(f"exit {rc}, wanted {want_rc}")
    if summary != f"ROLE_PACKAGES {want}":
        why.append(f"last line {summary!r}, wanted 'ROLE_PACKAGES {want}'")
    faults = faults or {}
    for n in ROLES:
        got = files.get(n)
        if not got or len(got) != 1:
            why.append(f"{n}: {len(got or [])} lines, wanted 1")
            continue
        b, lim, verdict, reason = got[0]
        if n in faults:
            tok, ident = faults[n]
            if verdict != "FAIL" or tokens(reason) != {tok} or (ident and not re.search(
                    rf"(?<![A-Za-z0-9-]){re.escape(ident)}(?!\d)", reason or "")):
                why.append(f"{n}: {verdict} {reason!r}, wanted FAIL with only {tok}" + (f" {ident}" if ident else ""))
        elif verdict != "PASS" or reason:
            why.append(f"{n}: {verdict} {reason!r}, wanted PASS")
        if limits and n in limits and lim != str(limits[n]):
            why.append(f"{n}: limit={lim}, wanted {limits[n]}")
        if sizes and n in sizes and b != str(sizes[n]):
            why.append(f"{n}: bytes={b}, wanted {sizes[n]}")
    if extra_name is not None:
        hits = [(k, v) for k, v in files.items() if k not in ROLES and k.startswith(extra_name)]
        if not hits or any(len(v) != 1 or v[0][2] != "FAIL" or tokens(v[0][3]) != {"extra"} for _, v in hits):
            why.append(f"no single FAIL extra line for an entry starting {extra_name!r}: {hits}")
    elif any(k not in ROLES for k in files):
        why.append(f"lines for entries outside the six: {sorted(k for k in files if k not in ROLES)}")
    case(label, not why, "; ".join(why) + "\n" + out)


def check_root(tmp, name, label, want_rc, want, **kw):
    """Build a tree with build_tree's keyword arguments kw['tree'] and judge `--root` on it, run from an empty
    directory (the tool must read the tree it is given, not its working directory)."""
    tree = build_tree(tmp / name, **kw.pop("tree", {}))
    empty = tmp / f"{name}-cwd"
    empty.mkdir()
    rc, out = run_tool(["--root", str(tree)], empty)
    judge(label, rc, out, want_rc, want, **kw)
    return tree


def couldnot(label, rc, out, must_name):
    """Exit 2 and a last line starting ROLE_PACKAGES COULD NOT CHECK that names must_name; no PASS summary."""
    if rc is None:
        return case(label, False, out)
    _, summary = parse(out)
    last = [x.strip() for x in out.splitlines() if x.strip() and not x.startswith("[stderr]")][-1:] or [""]
    ok = rc == 2 and last[0].startswith("ROLE_PACKAGES COULD NOT CHECK") and must_name in last[0]
    case(label, ok, f"exit {rc}, last line {last[0]!r}, wanted exit 2 and COULD NOT CHECK naming {must_name!r}\n{out}")


# ---------------------------------------------------------------- the cases

def main():
    with tempfile.TemporaryDirectory() as td:
        tmp = Path(td)
        e_real = hook_bytes(REPO / HOOK)            # 222 at base b547565 (MESSAGE 221 bytes and its newline)
        ex = LIMIT - e_real                          # the executor's limit: 9,078 at b547565
        print(f"     (the real hook writes {e_real} bytes, so the executor's limit is {ex})")
        lim = {n: LIMIT for n in ROLES} | {"executor.md": ex}

        # P1, P2: a sound tree passes in both reading modes, with the same output.
        t1 = check_root(tmp, "p1", "(P1) a sound tree passes --root: six PASS lines with their bytes and limits",
                        0, "PASS", limits=lim,
                        sizes={n: len(PACKAGE.format(role=n[:-3]).encode()) for n in ROLES})
        sha = commit_tree(t1)
        rc_r, out_r = run_tool(["--root", str(t1)], tmp)
        rc_v, out_v = run_tool(["--rev", sha], t1)
        case("(P2) --rev of the committed tree gives exit 0 and the same lines as --root",
             rc_v == rc_r == 0 and out_v == out_r, f"--root ({rc_r}):\n{out_r}\n--rev ({rc_v}):\n{out_v}")

        # P3: the limits exactly met pass, with bytes= the byte size.
        check_root(tmp, "p3", f"(P3) producer.md at {LIMIT} bytes and executor.md at {ex} bytes pass", 0, "PASS",
                   tree={"packages": {"producer.md": pad(PACKAGE.format(role="producer"), LIMIT),
                                      "executor.md": pad(PACKAGE.format(role="executor"), ex)}},
                   limits=lim, sizes={"producer.md": LIMIT, "executor.md": ex})

        # P4: non-ASCII under its limits passes; a line of 1,999 three-byte characters is not a long line.
        line1999 = PACKAGE.format(role="prober") + "–" * 1999 + "\n"
        check_root(tmp, "p4", "(P4) a line of 1,999 en dashes (5,997 bytes) passes: line length counts characters",
                   0, "PASS", tree={"packages": {"prober.md": line1999.encode()}},
                   sizes={"prober.md": len(line1999.encode())})

        # P5: the constants, one source for W-C02-25's hook; importing the tool has no side effect.
        if not TOOL.is_file():
            case("(P5) the tool's constants RESERVE, LIMIT and HEADER", False, f"{TOOL.relative_to(REPO)} absent")
        else:
            buf = io.StringIO()
            try:
                spec = importlib.util.spec_from_file_location("check_role_packages_under_test", TOOL)
                mod = importlib.util.module_from_spec(spec)
                with redirect_stdout(buf), redirect_stderr(buf):
                    spec.loader.exec_module(mod)
                hdr = mod.HEADER.format(role="test-designer", sha12="0" * 12)
                ok = (mod.RESERVE == 200 and mod.LIMIT == LIMIT and hdr == "DevOS role package: test-designer@"
                      + "0" * 12 and len((hdr + "\n").encode("utf-8")) == 47 and buf.getvalue() == "")
                detail = f"RESERVE={mod.RESERVE!r} LIMIT={mod.LIMIT!r} HEADER->{hdr!r} output={buf.getvalue()!r}"
            except BaseException as e:  # SystemExit too: importing must not run the check
                ok, detail = False, f"{type(e).__name__}: {e}; output={buf.getvalue()!r}"
            case("(P5) RESERVE == 200, LIMIT == 9300, HEADER gives the 47-byte header line; import prints nothing",
                 ok, detail)

        # P6: the hook is read, never imported or run.
        marked = planted_hook('MESSAGE = """fixture message"""')
        if marked:
            marked = marked.replace("import sys\n", "import sys\nopen(os.path.join(os.path.dirname(os.path.abspath("
                                    "__file__)), 'IMPORTED'), 'w').close()\n", 1)
        if not marked or "IMPORTED" not in marked:
            case("(P6) the hook is read by ast, not imported or run", False, "could not plant the marker hook")
        else:
            t6 = check_root(tmp, "p6", "(P6a) a hook that writes a marker when run: the tree passes", 0, "PASS",
                            tree={"hook": marked})
            case("(P6b) ... and the marker file was not written (the hook was not imported or run)",
                 RESULTS[-1] and not (t6 / ".claude/hooks/IMPORTED").exists(),
                 "P6a did not pass, so P6b shows nothing" if not RESULTS[-1] else "the marker file was written")

        # P7: the repository's own six packages pass at this tree; --root and --rev agree on a clean clone.
        rc, out = run_tool(["--root", str(REPO)], tmp)
        judge("(P7) the repository's own .claude/roles/ passes --root at this tree", rc, out, 0, "PASS", limits=lim)
        dirty = subprocess.run(["git", "-C", str(REPO), "status", "--porcelain"], capture_output=True,
                               text=True).stdout.strip()
        head = subprocess.run(["git", "-C", str(REPO), "rev-parse", "HEAD"], capture_output=True,
                              text=True).stdout.strip()
        rc2, out2 = run_tool(["--rev", head], REPO)
        case("(P7b) on a clean clone, --rev HEAD gives the same exit and lines as --root",
             not dirty and rc == 0 and rc2 == rc and out2 == out,
             ("the working tree is not clean, so P7b cannot compare; run it in a clean clone at the head\n"
              if dirty else "") + f"--root ({rc}):\n{out}\n--rev ({rc2}):\n{out2}")

        # S: the size oracle and its sensitivity.
        check_root(tmp, "s1", f"(S1) producer.md at {LIMIT + 1} bytes fails size with limit={LIMIT} (RESERVE kept)",
                   1, "FAIL", tree={"packages": {"producer.md": pad(PACKAGE.format(role="producer"), LIMIT + 1)}},
                   faults={"producer.md": ("size", None)}, limits={"producer.md": LIMIT},
                   sizes={"producer.md": LIMIT + 1})
        big = PACKAGE.format(role="researcher") + ("–" * 100 + "\n") * 32
        check_root(tmp, "s2", f"(S2) researcher.md of {len(big)} characters but {len(big.encode())} bytes fails size "
                   "(bytes, not characters)", 1, "FAIL", tree={"packages": {"researcher.md": big.encode()}},
                   faults={"researcher.md": ("size", None)}, sizes={"researcher.md": len(big.encode())})
        check_root(tmp, "s3", f"(S3) executor.md at {ex + 1} bytes fails size (MESSAGE and its newline subtracted)",
                   1, "FAIL", tree={"packages": {"executor.md": pad(PACKAGE.format(role="executor"), ex + 1)}},
                   faults={"executor.md": ("size", None)}, limits={"executor.md": ex})
        mb = planted_hook('MESSAGE = """' + "–" * 100 + '"""')
        if mb:
            (tmp / "mbhook.py").write_text(mb, encoding="utf-8")
            e_mb = LIMIT - hook_bytes(tmp / "mbhook.py")   # 9300 - 301 = 8999; by characters it would be 9199
            check_root(tmp, "s4a", f"(S4a) MESSAGE of 100 en dashes: executor.md at {e_mb} bytes passes", 0, "PASS",
                       tree={"hook": mb, "packages": {"executor.md": pad(PACKAGE.format(role="executor"), e_mb)}},
                       limits={"executor.md": e_mb})
            check_root(tmp, "s4b", f"(S4b) ... and at {e_mb + 1} bytes fails size (MESSAGE counted in UTF-8 bytes)",
                       1, "FAIL", tree={"hook": mb, "packages": {"executor.md": pad(PACKAGE.format(role="executor"),
                                                                                   e_mb + 1)}},
                       faults={"executor.md": ("size", None)}, limits={"executor.md": e_mb})
        else:
            case("(S4) a multibyte MESSAGE", False, "the real hook has no MESSAGE = \"\"\"...\"\"\" assignment")
        grown = planted_hook('MESSAGE = """' + real_hook().split('MESSAGE = """', 1)[-1].split('"""', 1)[0]
                             + "x" * 300 + '"""')
        check_root(tmp, "s5", f"(S5) MESSAGE grown by 300 bytes: executor.md at {ex} fails size; producer.md at "
                   f"{LIMIT} still passes", 1, "FAIL",
                   tree={"hook": grown or "", "packages": {"executor.md": pad(PACKAGE.format(role="executor"), ex),
                                                           "producer.md": pad(PACKAGE.format(role="producer"),
                                                                              LIMIT)}},
                   faults={"executor.md": ("size", None)}, limits={"executor.md": ex - 300, "producer.md": LIMIT})
        check_root(tmp, "s6", "(S6) checker.md at 9,350 bytes (under 9,500, over 9,300) fails size", 1, "FAIL",
                   tree={"packages": {"checker.md": pad(PACKAGE.format(role="checker"), 9350)}},
                   faults={"checker.md": ("size", None)}, limits={"checker.md": LIMIT})

        # X: could not check.
        for label, assignment, name in (("(X1) MESSAGE = \"a\" + \"b\" (not a literal)", 'MESSAGE = "a" + "b"', "x1"),
                                        ("(X2) MESSAGE = PREFIX (a name, not a literal)",
                                         'PREFIX = "a"\nMESSAGE = PREFIX', "x2")):
            t = build_tree(tmp / name, hook=planted_hook(assignment) or "")
            rc, out = run_tool(["--root", str(t)], tmp)
            couldnot(f"{label}: exit 2, COULD NOT CHECK naming MESSAGE", rc, out, "MESSAGE")
        t = build_tree(tmp / "x3", drop=(HOOK,))
        rc, out = run_tool(["--root", str(t)], tmp)
        couldnot(f"(X3) the hook absent: exit 2, COULD NOT CHECK naming {HOOK}", rc, out,
                 "reread_after_compact.py")
        rc, out = run_tool(["--rev", "0" * 40], t1)
        couldnot("(X4) --rev of a commit the repository does not hold: exit 2, COULD NOT CHECK naming it", rc, out,
                 "0" * 12)

        # F: the form rules (each on one file; every other file sound).
        base = PACKAGE.format(role="producer")
        forms = (
            ("f1", "(F1) first line ---", "---\n" + base, "front-matter"),
            ("f1b", "(F1b) first line --- with nothing else on the next line", "---\n\n" + base, "front-matter"),
            ("f2", "(F2) a line starting name: (not the first)", base + "name: producer\n", "name-line"),
            ("f2b", "(F2b) the first line starting name:", "name: producer\n" + base, "name-line"),
            ("f3", "(F3) a line starting ## ", base + "## Methods\n", "heading"),
            ("f3b", "(F3b) the last line '## ' with no newline", base + "## ", "heading"),
            ("f4", "(F4) a line of exactly 2,000 characters", base + "y" * 2000 + "\n", "long-line"),
            ("f4b", "(F4b) a line of 2,000 two-byte characters", base + "é" * 2000 + "\n", "long-line"),
        )
        for name, label, text, tok in forms:
            check_root(tmp, name, f"{label}: fails {tok}", 1, "FAIL",
                       tree={"packages": {"producer.md": text.encode("utf-8")}}, faults={"producer.md": (tok, None)})
        raw = base.encode("utf-8")
        for name, label, data, tok in (
                ("f5", "(F5) a 0xFF byte", raw + b"\xff\n", "utf8"),
                ("f5b", "(F5b) an encoded surrogate (ED A0 80)", raw + b"\xed\xa0\x80\n", "utf8"),
                ("f5c", "(F5c) an overlong encoding (C0 AF)", raw + b"\xc0\xaf\n", "utf8"),
                ("f6", "(F6) a NUL byte in a line", raw + b"a\x00b\n", "nul"),
                ("f6b", "(F6b) a NUL byte at the end", raw + b"\x00", "nul")):
            check_root(tmp, name, f"{label}: fails {tok}", 1, "FAIL", tree={"packages": {"producer.md": data}},
                       faults={"producer.md": (tok, None)})

        # D: the six-file denominator.
        check_root(tmp, "d1", "(D1) five files (checker.md absent): checker.md fails missing", 1, "FAIL",
                   tree={"drop": (".claude/roles/checker.md",)}, faults={"checker.md": ("missing", None)})
        check_root(tmp, "d2", "(D2) no package at all: six missing", 1, "FAIL",
                   tree={"drop": tuple(f".claude/roles/{n}" for n in ROLES)},
                   faults={n: ("missing", None) for n in ROLES})
        check_root(tmp, "d3", "(D3) a seventh file notes.md: fails extra", 1, "FAIL",
                   tree={"extra": {".claude/roles/notes.md": b"a note\n"}}, extra_name="notes.md")
        check_root(tmp, "d4", "(D4) a file in a subfolder (sub/producer.md): fails extra", 1, "FAIL",
                   tree={"extra": {".claude/roles/sub/producer.md": PACKAGE.format(role="producer").encode()}},
                   extra_name="sub")
        check_root(tmp, "d5", "(D5) Producer.md instead of producer.md: producer.md missing and Producer.md extra",
                   1, "FAIL", tree={"drop": (".claude/roles/producer.md",),
                                    "extra": {".claude/roles/Producer.md": PACKAGE.format(role="producer").encode()}},
                   faults={"producer.md": ("missing", None)}, extra_name="Producer.md")

        # I: the ID resolution rules (each on prober.md; every other file sound).
        for name, label, text, ident in (
                ("i1", "(I1) EV-C99-404, no such file", "EV-C99-404", "EV-C99-404"),
                ("i2", "(I2) CHK-C99-404, no such file", "CHK-C99-404", "CHK-C99-404"),
                ("i3", "(I3) L-404, no such heading", "L-404", "L-404"),
                ("i4", "(I4) N-404, no such marker", "N-404", "N-404"),
                ("i5", "(I5) EV-C99-003: only EV-C99-0035_decoy.md (no delimiter after the ID)", "EV-C99-003",
                 "EV-C99-003"),
                ("i6", "(I6) L-4: only a heading ### L-40", "L-4", "L-4"),
                ("i7", "(I7) N-6: only a marker N-60", "N-6", "N-6"),
                ("i8", "(I8) N-8: its marker only outside plan/work/", "N-8", "N-8"),
                ("i9", "(I9) L-11: its heading only in plan/ledger/notes.md (not *-log.md)", "L-11", "L-11"),
                ("i10", "(I10) EV-C99-012: its file only outside evidence/", "EV-C99-012", "EV-C99-012"),
                ("i11", "(I11) EV-C99-405 inside a code span", "`EV-C99-405`", "EV-C99-405")):
            check_root(tmp, name, f"{label}: fails unresolved {ident}", 1, "FAIL",
                       tree={"packages": {"prober.md": (PACKAGE.format(role="prober") + f"Case {text}.\n").encode()}},
                       faults={"prober.md": ("unresolved", ident)})

        # RV: --rev reads the revision, never the disk (the gate runs it from main's tree on a pull request head).
        for name, label, committed, disk, fault in (
                ("rv1", "(RV1) a cited ID whose file is only on disk, untracked",
                 {"packages": {"prober.md": (PACKAGE.format(role="prober") + "Case EV-C99-013.\n").encode()}},
                 {"evidence/C99/EV-C99-013_untracked.md": b"untracked\n"}, ("prober.md", "unresolved", "EV-C99-013")),
                ("rv2", f"(RV2) producer.md committed at {LIMIT + 1} bytes, sound on disk",
                 {"packages": {"producer.md": pad(PACKAGE.format(role="producer"), LIMIT + 1)}},
                 {".claude/roles/producer.md": PACKAGE.format(role="producer").encode()},
                 ("producer.md", "size", None)),
                ("rv3", f"(RV3) the hook committed with MESSAGE grown by 300 bytes, the real one on disk; executor.md "
                 f"at {ex}",
                 {"hook": grown or "", "packages": {"executor.md": pad(PACKAGE.format(role="executor"), ex)}},
                 {HOOK: real_hook().encode()}, ("executor.md", "size", None))):
            t = build_tree(tmp / name, **committed)
            sha = commit_tree(t)
            for p, b in disk.items():
                (t / p).parent.mkdir(parents=True, exist_ok=True)
                (t / p).write_bytes(b)
            rc, out = run_tool(["--root", str(t)], tmp)
            judge(f"{label}: --root (the disk) passes", rc, out, 0, "PASS")
            rc, out = run_tool(["--rev", sha], t)
            judge(f"{label}: --rev fails {fault[1]}", rc, out, 1, "FAIL", faults={fault[0]: fault[1:]})

    ok = bool(RESULTS) and all(RESULTS)
    print(f"CHECK_ROLE_PACKAGES_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
