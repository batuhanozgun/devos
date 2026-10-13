#!/usr/bin/env python3
"""T-W07-7SCAN: W-C02-07 point 7's scan of the test files and fixtures (spec: tests/C02/W-C02-07/T-W07-7SCAN_test_file_scan.md).

Synthetic test data (plan Section 8 item 13): every string this program plants is made at run time from os.urandom or
fixed synthetic words, labelled SYNTHETIC W-C02-07, written only into a scratch directory outside the repository, and
deleted before the program ends. It never prints a matched string, a part of one, its length or a hash of one: only
paths, line numbers, pattern keys, classes and counts.

Order (README section 6): (1) the pattern file and its agreement with shared/token_format.md and the guard file;
(2) the positive and negative controls in a scratch copy, with point 6's missing, unreadable and partial inputs;
(3) the scan of the subject: tests/C02/W-C02-07/** (with the staged job files under job/) and any copy
    supabase/migrations/tests/w07_* under --root;
(4) tools/credential_value_scan.py over the same directories, recording only its exit code and match counts.
Result wording: "none found by the scanned patterns", never "no secret".
Usage: python3 -I tests/C02/W-C02-07/bin/7scan_test_files.py --root <repository root>
Exit: 0 PASS, 1 FAIL, 3 COULD NOT CHECK (and 3 on any error of the program itself).
"""
import argparse
import ast
import base64
import json
import os
import re
import shutil
import stat
import subprocess
import sys
import tempfile

sys.dont_write_bytecode = True
TEST_ID = "7SCAN_TEST_FILES"  # README section 3: the file name, upper case
MAX_BYTES = 8 * 1024 * 1024  # a file larger than this is read only in part: "could not check" (partial)
SUBJECT_DIR = os.path.join("tests", "C02", "W-C02-07")
SQL_DIR = os.path.join("supabase", "migrations", "tests")  # the build items' byte-for-byte copies, once made
STAGED_DIR = os.path.join(SUBJECT_DIR, "job")  # README 5.1 (c): the staged SQL files and programs (phase C5)
PATTERN_FILE = os.path.join(SUBJECT_DIR, "shared", "scan_patterns.json")
FORMAT_FILE = os.path.join(SUBJECT_DIR, "shared", "token_format.md")
GUARD_FILE = os.path.join(".claude", "hooks", "tool_allowlist.py")
VALUE_SCAN = os.path.join("tools", "credential_value_scan.py")
# Phase C3 (C1's open 5): the class-high IDC program embeds the environment token's exact pattern; 7SCAN-pf5 checks
# that the embedded copy, read with ast and never run, equals the pattern file's.
IDC_PROGRAM = os.path.join(STAGED_DIR, "w07_idc_real_path.py")
EMBED_NAME = "ENV_TOKEN_EXACT_PARTS"
STRIP = "\"'`,;.()[]{}"

results = []  # (case_id, outcome, detail); outcome in ok / bad / could_not_check


def case(cid, outcome, detail):
    results.append((cid, outcome, detail))
    print(f"{cid}\t{outcome}\t{detail}")


class Cnc(Exception):
    """The program could not make its observation."""


# ---------------------------------------------------------------- (1) patterns
def load_patterns(root):
    p = os.path.join(root, PATTERN_FILE)
    if not os.path.isfile(p):
        raise Cnc(f"7SCAN-pf1: the pattern file {PATTERN_FILE} is missing")
    try:
        with open(p, encoding="utf-8") as f:
            pat = json.load(f)
        tok = pat["token_patterns"]
        comp = {
            "tok": {k: re.compile(tok[k]) for k in ("env_token_exact", "claim_token_exact", "env_token_find",
                                                     "claim_token_find")},
            "redact": [re.compile(x) for x in pat["guard_redact"]],
            "vars": tuple(pat["guard_credential_vars"]),
            "extra": {k: re.compile(v) for k, v in pat["extra_value_patterns"].items() if not k.startswith("_")},
            "name_words": {w.lower() for w in pat["classify_rule"]["name_words"]},
            "raw": pat,
        }
    except (OSError, ValueError, KeyError, TypeError, re.error) as e:
        raise Cnc(f"7SCAN-pf2: the pattern file cannot be read or is malformed ({type(e).__name__})")
    if len(comp["redact"]) != 5:
        raise Cnc("7SCAN-pf2: the pattern file does not hold the guard's five REDACT patterns")
    return comp


def check_agreement(root, comp):
    """7SCAN-pf3 (token_format.md) and 7SCAN-pf4 (the guard file): the copies agree with their sources."""
    fp = os.path.join(root, FORMAT_FILE)
    try:
        with open(fp, encoding="utf-8") as f:
            fmt = f.read()
    except OSError as e:
        raise Cnc(f"7SCAN-pf3: {FORMAT_FILE} cannot be read ({type(e).__name__})")
    ticks = set(re.findall(r"`([^`]+)`", fmt))
    missing = [k for k, v in comp["raw"]["token_patterns"].items() if v not in ticks]
    if missing:
        raise Cnc(f"7SCAN-pf3: the pattern file's {', '.join(sorted(missing))} differ from {FORMAT_FILE} section 3")
    case("7SCAN-pf3", "ok", "the four token patterns equal shared/token_format.md section 3")
    gp = os.path.join(root, GUARD_FILE)
    try:
        with open(gp, encoding="utf-8") as f:
            tree = ast.parse(f.read())
    except (OSError, SyntaxError) as e:
        raise Cnc(f"7SCAN-pf4: the guard file cannot be read ({type(e).__name__})")
    redact, cvars = None, None
    for node in tree.body:
        if isinstance(node, ast.Assign):
            names = [getattr(t, "id", None) for t in node.targets]
            if "CREDENTIAL_VARS" in names:
                cvars = tuple(ast.literal_eval(node.value))
            if "REDACT" in names and isinstance(node.value, ast.ListComp):
                it = node.value.generators[0].iter
                redact = [ast.literal_eval(e) for e in it.elts] if isinstance(it, ast.Tuple) else None
    if redact is None or cvars is None:
        raise Cnc("7SCAN-pf4: REDACT or CREDENTIAL_VARS not found in the guard file")
    if redact != comp["raw"]["guard_redact"] or cvars != comp["vars"]:
        raise Cnc("7SCAN-pf4: the pattern file's guard patterns differ from the guard file; the pattern file is revised first")
    case("7SCAN-pf4", "ok", "REDACT and CREDENTIAL_VARS equal the guard file's")


def embedded_copy(path):
    """The joined parts of the pattern the IDC program embeds, read with ast (never run); raises Cnc."""
    try:
        with open(path, encoding="utf-8") as f:
            tree = ast.parse(f.read())
    except (OSError, SyntaxError, ValueError, UnicodeDecodeError) as e:
        raise Cnc(f"the program cannot be read ({type(e).__name__})")
    for node in tree.body:
        if isinstance(node, ast.Assign) and any(getattr(t, "id", None) == EMBED_NAME for t in node.targets):
            try:
                parts = ast.literal_eval(node.value)
            except ValueError:
                raise Cnc(f"{EMBED_NAME} is not a literal")
            if not isinstance(parts, tuple) or not parts or not all(isinstance(p, str) for p in parts):
                raise Cnc(f"{EMBED_NAME} is not a tuple of strings")
            return "".join(parts)
    raise Cnc(f"no {EMBED_NAME} in the program")


def compare_embedded(path, comp):
    """('equal' | 'differ' | 'could_not_check', why)."""
    try:
        got = embedded_copy(path)
    except Cnc as e:
        return "could_not_check", str(e)
    same = got == comp["raw"]["token_patterns"]["env_token_exact"]
    return ("equal" if same else "differ"), ""


# ---------------------------------------------------------------- the scan itself
def classify(key, text, before, comp):
    """Return 'VALUE' or 'NAME' by scan_patterns.json classify_rule, fixed before the run."""
    if key.startswith("tok:") or key in ("redact1", "redact2", "redact3", "redact4", "jwt_like", "supabase_key_like",
                                         "connection_string_with_password"):
        return "VALUE"
    if key == "redact5":
        m = re.match(r"(?is).*?(?:token|secret|password|passwd|api[_-]?key)\s*[=:]\s*(\S+)", text)
        v = (m.group(1) if m else "").strip(STRIP)
        if (not v or v[0] in "$<{[%(`" or v.lower() in comp["name_words"] or len(v) < 16
                or not re.search(r"\d", v)):
            return "NAME"
        return "VALUE"
    if key == "credential_var":
        return "NAME"
    if key == "long_hex":
        if len(set(text.lower())) == 1 or re.search(r"(commit |sha |@|blob |at )", before[-8:]):
            return "NAME"
        if not re.search(r"\d", text) or not re.search(r"[A-Fa-f]", text):
            return "NAME"
        return "VALUE"
    if key == "long_base64":
        if len(set(text)) == 1 or not (re.search(r"\d", text) and re.search(r"[A-Z]", text)
                                        and re.search(r"[a-z]", text)):
            return "NAME"
        return "VALUE"
    return "VALUE"


def scan_text(data, comp):
    """[(key, class, line)] for one decoded file."""
    out = []
    cv = re.compile(r"\$\{?!?(" + "|".join(map(re.escape, comp["vars"])) + r")\b")
    pats = [("tok:" + k, r) for k, r in comp["tok"].items() if k.endswith("_find")]
    pats += [(f"redact{i + 1}", r) for i, r in enumerate(comp["redact"])]
    pats += [("credential_var", cv)] + list(comp["extra"].items())
    hexspans = set()
    for key, rx in pats:
        for m in rx.finditer(data):
            if key == "long_hex":
                hexspans.add(m.span())
            if key == "long_base64" and any(a <= m.start() and m.end() <= b for a, b in hexspans):
                continue
            line = data.count("\n", 0, m.start()) + 1
            out.append((key, classify(key, m.group(0), data[max(0, m.start() - 8):m.start()], comp), line))
    return out


def subject_files(root):
    """The files of the subject, or raise Cnc (missing input)."""
    base = os.path.join(root, SUBJECT_DIR)
    if not os.path.isdir(base):
        raise Cnc(f"the subject directory {SUBJECT_DIR} is missing")
    files = []
    for d, _dirs, fs in os.walk(base):
        for fn in sorted(fs):
            files.append(os.path.join(d, fn))
    sql = os.path.join(root, SQL_DIR)
    if os.path.isdir(sql):
        files += [os.path.join(sql, fn) for fn in sorted(os.listdir(sql)) if fn.startswith("w07_")]
    if not files:
        raise Cnc("the subject holds no file")
    return files


def scan_tree(root, comp):
    """('clean' | 'fail' | 'could_not_check', hits, problems, nfiles). Never 'clean' when a file was not read in full."""
    try:
        files = subject_files(root)
    except Cnc as e:
        return "could_not_check", [], [str(e)], 0
    hits, problems = [], []
    for fp in files:
        rel = os.path.relpath(fp, root)
        try:
            st = os.stat(fp)  # follows links: a dangling link raises here
            if not stat.S_ISREG(st.st_mode):
                problems.append(f"{rel}: not a regular file, not read (unreadable)")
                continue
            if st.st_size > MAX_BYTES:
                with open(fp, "rb") as f:
                    f.read(MAX_BYTES)
                problems.append(f"{rel}: larger than {MAX_BYTES} bytes, read only in part (partial)")
                continue
            with open(fp, "rb") as f:
                raw = f.read(MAX_BYTES + 1)
            if len(raw) != st.st_size:
                problems.append(f"{rel}: the read returned another size than the file's (partial)")
                continue
        except OSError as e:
            problems.append(f"{rel}: cannot be read ({type(e).__name__}) (unreadable)")
            continue
        for key, cls, line in scan_text(raw.decode("utf-8", "surrogateescape"), comp):
            hits.append((rel, line, key, cls))
    if any(h[3] == "VALUE" for h in hits):
        return "fail", hits, problems, len(files)
    if problems:
        return "could_not_check", hits, problems, len(files)
    return "clean", hits, problems, len(files)


# ---------------------------------------------------------------- (2) controls in a scratch copy
def rnd(n, alphabet=None):
    b = base64.urlsafe_b64encode(os.urandom(64)).decode().rstrip("=")
    while len(b) < n:
        b += base64.urlsafe_b64encode(os.urandom(64)).decode().rstrip("=")
    s = b[:n]
    if alphabet == "alnum":
        s = re.sub(r"[-_]", "x", s)
    if alphabet == "hex":
        s = os.urandom(n // 2 + 1).hex()[:n]
    return s


def marker(comp, key):
    """The marker, read from the pattern file at run time (never written in this file)."""
    return comp["raw"]["token_patterns"][key].split("[", 1)[0]


def make_tree(top, files):
    d = os.path.join(top, SUBJECT_DIR)
    os.makedirs(d, exist_ok=True)
    for name, text in files.items():
        with open(os.path.join(d, name), "w", encoding="utf-8") as f:
            f.write(text)
    return d


def controls(comp, scratch_parent):
    lab = "SYNTHETIC W-C02-07 planted control: "
    env_m, clm_m = marker(comp, "env_token_exact"), marker(comp, "claim_token_exact")
    planted = {  # case id -> (file text, expected key, expected class)
        "7SCAN-p1": (lab + env_m + rnd(43) + "\n", "tok:env_token_find", "VALUE"),
        "7SCAN-p2": (lab + clm_m + rnd(43) + "\n", "tok:claim_token_find", "VALUE"),
        "7SCAN-p3": (lab + "cut copy " + env_m + rnd(20) + "\n", "tok:env_token_find", "VALUE"),
        "7SCAN-p4": (lab + env_m.upper() + rnd(43) + "\n", "tok:env_token_find", "VALUE"),
        "7SCAN-p5": (lab + "gh" + "p_" + rnd(36, "alnum") + "\n", "redact1", "VALUE"),
        "7SCAN-p6": (lab + "github" + "_pat_" + rnd(40, "alnum") + "\n", "redact2", "VALUE"),
        "7SCAN-p7": (lab + "s" + "k-" + rnd(40, "alnum") + "\n", "redact3", "VALUE"),
        "7SCAN-p8": (lab + "Bear" + "er " + rnd(40, "alnum") + "\n", "redact4", "VALUE"),
        "7SCAN-p9": (lab + "pass" + "word=" + rnd(12, "alnum") + "7" + rnd(12, "alnum") + "\n", "redact5", "VALUE"),
        "7SCAN-p10": (lab + "postgresql://w07_fixture:" + rnd(20, "alnum") + "@localhost/w07\n",
                      "connection_string_with_password", "VALUE"),
        "7SCAN-p11": (lab + "ey" + "J" + rnd(20) + "." + rnd(30) + "." + rnd(30) + "\n", "jwt_like", "VALUE"),
        "7SCAN-p12": (lab + "a3" + rnd(62, "hex") + "\n", "long_hex", "VALUE"),
        "7SCAN-p13": (lab + "sb_" + "secret_" + rnd(30) + "\n", "supabase_key_like", "VALUE"),
    }
    names = {  # must be reported as NAME and must not make a finding
        "7SCAN-n1": (lab + "the reason code is tok" + "en: missing\n", "redact5"),
        "7SCAN-n2": (lab + "never expand $" + "GH_TOKEN in a test\n", "credential_var"),
        "7SCAN-n3": (lab + "a" * 64 + "\n", "long_hex"),
    }
    top = tempfile.mkdtemp(prefix="w07_7scan_", dir=scratch_parent)
    counts = {"clean": 0, "fail": 0, "could_not_check": 0}
    try:
        # negative control of the scan: a clean tree gives clean, with zero hits
        t0 = os.path.join(top, "clean")
        make_tree(t0, {"w07_clean.md": "SYNTHETIC W-C02-07 clean control: no credential-like string.\n"})
        ans, hits, probs, _ = scan_tree(t0, comp)
        counts[ans] += 1
        case("7SCAN-neg0", "ok" if ans == "clean" and not hits else "bad", f"clean tree answered {ans}, {len(hits)} hits")
        for cid, (text, key, cls) in planted.items():
            t = os.path.join(top, cid)
            make_tree(t, {"w07_planted.md": text})
            ans, hits, probs, _ = scan_tree(t, comp)
            counts[ans] += 1
            got = [(h[2], h[3]) for h in hits]
            ok = ans == "fail" and (key, cls) in got
            case(cid, "ok" if ok else "bad", f"planted {key} answered {ans}; found {sorted(set(got))}")
        for cid, (text, key) in names.items():
            t = os.path.join(top, cid)
            make_tree(t, {"w07_name.md": text})
            ans, hits, probs, _ = scan_tree(t, comp)
            counts[ans] += 1
            got = [(h[2], h[3]) for h in hits]
            ok = ans == "clean" and (key, "NAME") in got and not any(c == "VALUE" for _, c in got)
            case(cid, "ok" if ok else "bad", f"planted name {key} answered {ans}; found {sorted(set(got))}")
        # point 6 (i): missing, unreadable and partial inputs must answer could_not_check, never clean
        t = os.path.join(top, "missing")
        os.makedirs(t)
        ans, *_ = scan_tree(t, comp)
        counts[ans] += 1
        case("7SCAN-m1", "ok" if ans == "could_not_check" else "bad", f"subject directory absent answered {ans}")
        t = os.path.join(top, "empty")
        os.makedirs(os.path.join(t, SUBJECT_DIR))
        ans, *_ = scan_tree(t, comp)
        counts[ans] += 1
        case("7SCAN-m2", "ok" if ans == "could_not_check" else "bad", f"subject without files answered {ans}")
        t = os.path.join(top, "dangling")
        d = make_tree(t, {"w07_clean.md": "SYNTHETIC W-C02-07 clean.\n"})
        os.symlink(os.path.join(top, "w07_absent_target"), os.path.join(d, "w07_dangling.md"))
        ans, *_ = scan_tree(t, comp)
        counts[ans] += 1
        case("7SCAN-u1", "ok" if ans == "could_not_check" else "bad", f"a dangling link answered {ans}")
        t = os.path.join(top, "fifo")
        d = make_tree(t, {"w07_clean.md": "SYNTHETIC W-C02-07 clean.\n"})
        try:
            os.mkfifo(os.path.join(d, "w07_fifo"))
            ans, *_ = scan_tree(t, comp)
            counts[ans] += 1
            case("7SCAN-u2", "ok" if ans == "could_not_check" else "bad", f"a file that is not regular answered {ans}")
        except (OSError, AttributeError) as e:
            case("7SCAN-u2", "could_not_check", f"a FIFO could not be planted ({type(e).__name__})")
        t = os.path.join(top, "big")
        d = make_tree(t, {"w07_clean.md": "SYNTHETIC W-C02-07 clean.\n"})
        with open(os.path.join(d, "w07_big.txt"), "wb") as f:
            f.write(b"x" * (MAX_BYTES + 1))
        ans, *_ = scan_tree(t, comp)
        counts[ans] += 1
        case("7SCAN-pa1", "ok" if ans == "could_not_check" else "bad", f"a file read only in part answered {ans}")
        t = os.path.join(top, "bigvalue")
        d = make_tree(t, {"w07_clean.md": "SYNTHETIC W-C02-07 clean.\n"})
        with open(os.path.join(d, "w07_big.txt"), "wb") as f:
            f.write(b"x" * (MAX_BYTES + 1))
        with open(os.path.join(d, "w07_planted.md"), "w") as f:
            f.write(lab + env_m + rnd(43) + "\n")
        ans, *_ = scan_tree(t, comp)
        counts[ans] += 1
        case("7SCAN-pa2", "ok" if ans == "fail" else "bad", f"a finding beside a partial read answered {ans} (fail wins)")
        # 7SCAN-pf5's own controls (phase C3): its comparison answers equal, differ and could not check.
        exact = comp["raw"]["token_patterns"]["env_token_exact"]
        cut = len(exact) // 2
        for cid, text, want in (
                ("7SCAN-ec-same", f"{EMBED_NAME} = ({exact[:cut]!r}, {exact[cut:]!r})", "equal"),
                ("7SCAN-ec-diff", f"{EMBED_NAME} = ({exact[:cut]!r}, {(exact[cut:] + 'x')!r})", "differ"),
                ("7SCAN-ec-missing", "W07_OTHER_NAME = ('w07_fixture',)", "could_not_check")):
            p = os.path.join(top, cid + ".py")
            with open(p, "w", encoding="utf-8") as f:
                f.write("# SYNTHETIC W-C02-07 planted control" + chr(10) + text + chr(10))
            ans, _ = compare_embedded(p, comp)
            case(cid, "ok" if ans == want else "bad", f"a planted copy answered {ans}, wanted {want}")
    finally:
        shutil.rmtree(top, ignore_errors=True)
    print(f"7SCAN answers seen in the controls: clean {counts['clean']}, fail {counts['fail']}, "
          f"could not check {counts['could_not_check']}, of {sum(counts.values())}")
    return not os.path.exists(top)


# ---------------------------------------------------------------- (4) credential_value_scan
def value_scan(root):
    tool = os.path.join(root, VALUE_SCAN)
    if not os.path.isfile(tool):
        return "could_not_check", f"{VALUE_SCAN} is missing"
    args = [sys.executable, "-I", tool, "--dir", os.path.join(root, SUBJECT_DIR)]
    if os.path.isdir(os.path.join(root, SQL_DIR)):
        args += ["--dir", os.path.join(root, SQL_DIR)]
    try:
        p = subprocess.run(args, capture_output=True, text=True, timeout=300)
    except (OSError, subprocess.TimeoutExpired) as e:
        return "could_not_check", f"the tool did not run ({type(e).__name__})"
    nvals = 0 if "Values searched for: none" in p.stdout else len(re.findall(r"^  [^(].*: length \d+$", p.stdout, re.M))
    held = sum(int(n) for n in re.findall(r": (\d+) files hold it", p.stdout))
    detail = f"exit code {p.returncode}; values searched {nvals}; files holding a value {held}"
    if p.returncode != 0:
        return "could_not_check", detail
    if held > 0:
        return "bad", detail
    if nvals == 0:
        return "ok", detail + " (no session credential value exists in this environment: vacuous, stated)"
    return "ok", detail


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", required=True)
    a = ap.parse_args()
    root = os.path.abspath(a.root)
    print(f"{TEST_ID}: scan of {SUBJECT_DIR} and {SQL_DIR}/w07_* under the given root (synthetic controls only)")
    try:
        comp = load_patterns(root)
        case("7SCAN-pf1", "ok", "pattern file present")
        case("7SCAN-pf2", "ok", "pattern file well formed")
        check_agreement(root, comp)
        ans, why = compare_embedded(os.path.join(root, IDC_PROGRAM), comp)
        case("7SCAN-pf5", {"equal": "ok", "differ": "bad"}.get(ans, "could_not_check"),
             f"{IDC_PROGRAM}: {EMBED_NAME}, joined, "
             + {"equal": "equals", "differ": "differs from"}.get(ans, "could not be compared with")
             + " the pattern file's env_token_exact" + (f" ({why})" if why else ""))
    except Cnc as e:
        case(str(e).split(":", 1)[0], "could_not_check", str(e))
        return finish()
    scratch = tempfile.gettempdir()
    if os.path.commonpath([os.path.realpath(scratch), root]) == root:
        case("7SCAN-ctl", "could_not_check", "the scratch directory lies inside the repository")
        return finish()
    removed = controls(comp, scratch)
    case("7SCAN-ctl-clean", "ok" if removed else "bad", "the scratch copy was deleted" if removed else "the scratch copy remains")
    ans, hits, probs, n = scan_tree(root, comp)
    for rel, line, key, cls in hits:
        print(f"hit\t{rel}:{line}\t{key}\t{cls}")
    for p in probs:
        print(f"not read in full\t{p}")
    nv = sum(1 for h in hits if h[3] == "VALUE")
    detail = (f"{n} files; {nv} VALUE hits, {len(hits) - nv} NAME hits; {len(probs)} not read in full; "
              + ("none found by the scanned patterns" if ans == "clean" else f"answer {ans}"))
    case("7SCAN-s1", {"clean": "ok", "fail": "bad"}.get(ans, "could_not_check"), detail)
    outcome, detail = value_scan(root)
    case("7SCAN-s2", outcome, "tools/credential_value_scan.py: " + detail)
    return finish()


def finish():
    nb = sum(1 for r in results if r[1] == "bad")
    nc = sum(1 for r in results if r[1] == "could_not_check")
    n = len(results)
    if nb:
        print(f"{TEST_ID} FAIL ({nb} bad, {nc} could not check, of {n})")
        return 1
    if nc or not n:
        print(f"{TEST_ID} COULD NOT CHECK ({nc} of {n} could not be checked)")
        return 3
    print(f"{TEST_ID} PASS ({n}/{n})")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:  # the program's own fault is never a pass
        print(f"{TEST_ID} COULD NOT CHECK (the program failed: {type(e).__name__})")
        sys.exit(3)
