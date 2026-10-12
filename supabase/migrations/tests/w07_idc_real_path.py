#!/usr/bin/env python3
"""T-W07-IDC, its Data API part (spec: tests/C02/W-C02-07/T-W07-IDC_identity_chain.md, part B), and one file look.

Synthetic test data (plan Section 8 item 13): the tokens this program uses are synthetic tokens that the migration
job's devos-test step issues and commits for this run, hands over on standard input, and revokes after the run
(EV-C02-003 §6.3; the executor's decision 3). They are held only in memory and never printed, logged or written; no
header is printed. Inputs to functions are labelled 'w07_fixture SYNTHETIC W-C02-07'.

Cases:
  IDC-file1      no file under supabase/migrations/ (tests/ excluded) calls issue_env_token or revoke_env_token
                 (W-C02-09 point 3; plan 6.3); definitions and grants of the functions are allowed.
  IDC-fmt-<rc>   each issued token has the environment token's exact format (embedded below; T-W07-7SCAN's 7SCAN-pf5
                 checks that it equals shared/scan_patterns.json).
  IDC-h-<rc>     the real path, per role class: a Data API call to token_role_class() with the token in the header
                 x-devos-env-token is processed as that class (W-C02-09 point 3: "at least one call per role class goes
                 through the real path").
  IDC-h-missing  the same call with no token is refused with reason code missing.
  IDC-dd-<rc>    deployment_drift over the Data API (EV-C02-003 §4.1 row deployment_drift: devos_ci only); a caller over
                 HTTP is never the migration job's direct login, so the derivation applies. devos_ci passes the role
                 gate; the five others get a role refusal.
Runs: by the migration job's runner inside its devos-test step, from the repository root, as
  python3 -I supabase/migrations/tests/w07_idc_real_path.py < <one JSON object on standard input>
(README section 5.1 (b); note N-255 on plan/work/C02.md). The input is the job's one JSON object:
  {"endpoint": "<the project's API base URL>", "apikey": "<the publishable key>" or null,
   "tokens": {"<role class>": "<token>", ...}, "revoked_token": "<token>"}
exactly those four keys (N-255, "The key's source, decided"). apikey null means the key is not stored yet: every
Data API case is then "could not check", exit 3, with that reason. This program declares no need of the database,
so the job runs it under env -i, with no environment.
Without the endpoint, the publishable key or a token it needs, every Data API case is "could not check", and the
line says which input is missing (never a value).
This program uses the tokens of all six role classes. The wrong-role-class reason code is interface v1's
role_class_not_permitted (README section 8). It holds the token format's pattern itself (ENV_TOKEN_EXACT_PARTS), so
no class-normal file is read at run time and a class-normal change cannot alter this class-high check (phase C3).
Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK; the last line is "W07_IDC_REAL_PATH PASS|FAIL|COULD NOT CHECK (...)".
"""
import json
import os
import re
import sys
import urllib.error
import urllib.request

sys.dont_write_bytecode = True
TEST = "W07_IDC_REAL_PATH"
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", ".."))
CLASSES = ["devos_calisma", "devos_denetim", "devos_sinav", "devos_kurulum", "devos_ci", "devos_backup"]
TOKEN_CODES = {"missing", "empty", "malformed", "unknown", "revoked", "header_unreadable"}
LABEL = "w07_fixture SYNTHETIC W-C02-07"
# The environment token's exact format, embedded (phase C3; C1's open 5). Its parts joined equal
# shared/scan_patterns.json's token_patterns.env_token_exact, which T-W07-7SCAN checks (7SCAN-pf5). The marker is split
# so that only the two shared files hold it literally (README section 6).
ENV_TOKEN_EXACT_PARTS = ("dv", "env1_", "[A-Za-z0-9_-]{43}")
results = []


def case(cid, outcome, detail):
    results.append(outcome)
    print(TAB.join((str(cid), str(outcome), str(detail))))


def statements(sql):
    """Split SQL into statements on ';' outside quotes, dollar quotes and comments."""
    out, buf, i, n, q = [], [], 0, len(sql), None
    while i < n:
        ch = sql[i]
        if q is None:
            if sql.startswith("--", i):
                j = sql.find(NL, i); i = n if j < 0 else j; continue
            if sql.startswith("/*", i):
                j = sql.find("*/", i + 2); i = n if j < 0 else j + 2; continue
            m = re.match("[$][A-Za-z_]*[$]", sql[i:])
            if m:
                q = m.group(0); buf.append(q); i += len(q); continue
            if ch == "'":
                j = i + 1
                while j < n and not (sql[j] == "'" and not sql.startswith("''", j)):
                    j += 2 if sql.startswith("''", j) else 1
                buf.append(sql[i:j + 1]); i = j + 1; continue
            if ch == ";":
                out.append("".join(buf)); buf = []; i += 1; continue
            buf.append(ch); i += 1
        else:
            if sql.startswith(q, i):
                buf.append(q); i += len(q); q = None; continue
            buf.append(ch); i += 1
    out.append("".join(buf))
    return out


def file_look():
    mig = os.path.join(ROOT, "supabase", "migrations")
    if not os.path.isdir(mig):
        case("IDC-file1", "could_not_check", "supabase/migrations/ is absent"); return
    calls, nfiles = [], 0
    name = re.compile("(?<![A-Za-z0-9_])(issue|revoke)_env_token(?![A-Za-z0-9_])", re.I)
    allowed = re.compile('(?<![A-Za-z0-9_])function[' + WS + ']+(?:"?devos_private"?[.])?"?(issue|revoke)_env_token'
                         '(?![A-Za-z0-9_])', re.I)
    for d, dirs, files in os.walk(mig):
        dirs[:] = [x for x in dirs if os.path.join(d, x) != os.path.join(mig, "tests")]
        for fn in sorted(files):
            if not fn.endswith(".sql"):
                continue
            nfiles += 1
            try:
                text = open(os.path.join(d, fn), encoding="utf-8").read()
            except (OSError, UnicodeDecodeError) as e:
                case("IDC-file1", "could_not_check", f"{fn} cannot be read ({type(e).__name__})"); return
            for st in statements(text):
                if len(name.findall(st)) > len(allowed.findall(st)):
                    calls.append(os.path.relpath(os.path.join(d, fn), ROOT))
    if nfiles == 0:
        case("IDC-file1", "could_not_check", "no migration file to look at"); return
    case("IDC-file1", "bad" if calls else "ok",
         f"{nfiles} migration files; statements that call issue_env_token or revoke_env_token: "
         + (", ".join(sorted(set(calls))) if calls else "none"))


def rpc(cfg, fn, body, token, method="POST"):
    """(status, parsed body or None, PostgREST error code or None). Never prints or returns a header."""
    url = cfg["endpoint"].rstrip("/") + "/rest/v1/rpc/" + fn
    data = json.dumps(body).encode() if method == "POST" else None
    req = urllib.request.Request(url, data=data, method=method)
    req.add_header("apikey", cfg["apikey"])
    req.add_header("Content-Type", "application/json")
    req.add_header("Content-Profile", "devos_api")
    req.add_header("Accept-Profile", "devos_api")
    if token is not None:
        req.add_header("x-devos-env-token", token)
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            st, raw = r.status, r.read()
    except urllib.error.HTTPError as e:
        st, raw = e.code, e.read()
    except (urllib.error.URLError, OSError) as e:
        return None, None, f"transport {type(e).__name__}"
    try:
        js = json.loads(raw.decode("utf-8")) if raw else None
    except (ValueError, UnicodeDecodeError):
        js = None
    code = js.get("code") if isinstance(js, dict) and st >= 300 else None
    return st, js, code


def scrub(text, cfg):
    for t in cfg.get("tokens", {}).values():
        if t:
            text = text.replace(t, "[w07: presented value]")
    return text


def refusal(js):
    if isinstance(js, dict) and (js.get("status") == "refused" or js.get("refused") is True or "reason_code" in js):
        return js.get("reason_code", "refused_without_code")
    return None


def role_of(js):
    if isinstance(js, str):
        return js
    if isinstance(js, dict) and refusal(js) is None:
        return js.get("role_class")
    return None


def http_cases(cfg):
    exact = re.compile("".join(ENV_TOKEN_EXACT_PARTS))
    role_codes = {"role_class_not_permitted"}
    toks = cfg["tokens"]
    for rc in CLASSES:
        if not toks.get(rc):
            case(f"IDC-fmt-{rc}", "could_not_check", "no synthetic token given for this class"); continue
        case(f"IDC-fmt-{rc}", "ok" if exact.fullmatch(toks[rc]) else "bad",
             "the issued token has the environment token's exact format" if exact.fullmatch(toks[rc])
             else "the issued token does not have the exact format of shared/token_format.md section 3")
    for rc in CLASSES:
        if not toks.get(rc):
            case(f"IDC-h-{rc}", "could_not_check", "no synthetic token given"); continue
        st, js, code = rpc(cfg, "token_role_class", {}, toks[rc])
        if st is None or (code and str(code).startswith("PGRST")):
            case(f"IDC-h-{rc}", "could_not_check", f"the Data API path did not answer the function: {st} {code}")
        else:
            got = role_of(js)
            case(f"IDC-h-{rc}", "ok" if st == 200 and got == rc else "bad",
                 f"HTTP {st}; role class {got or 'none'} (wanted {rc}); refusal {refusal(js) or '-'}")
    st, js, code = rpc(cfg, "token_role_class", {}, None)
    if st is None or (code and str(code).startswith("PGRST")):
        case("IDC-h-missing", "could_not_check", f"the Data API path did not answer the function: {st} {code}")
    else:
        case("IDC-h-missing", "ok" if st == 200 and refusal(js) == "missing" else "bad",
             f"HTTP {st}; refusal {refusal(js) or '-'} (wanted missing); role class {role_of(js) or 'none'}")
    body = {"expected": {"commit": "w07fixture", "migrations": [], "functions": [], "label": LABEL}}
    for rc in CLASSES:
        if not toks.get(rc):
            case(f"IDC-dd-{rc}", "could_not_check", "no synthetic token given"); continue
        st, js, code = rpc(cfg, "deployment_drift", body, toks[rc])
        if st is None or (code and str(code).startswith("PGRST")):
            case(f"IDC-dd-{rc}", "could_not_check", f"the Data API path did not answer the function: {st} {code}"); continue
        ref = refusal(js)
        if rc == "devos_ci":
            ok = st == 200 and ref not in role_codes | TOKEN_CODES
            case(f"IDC-dd-{rc}", "ok" if ok else "bad", f"HTTP {st}; refusal {ref or '-'} (wanted: past the role gate)")
        else:
            ok = st == 200 and ref in role_codes
            case(f"IDC-dd-{rc}", "ok" if ok else "bad", f"HTTP {st}; refusal {ref or '-'} (wanted a role refusal)")


NL, TAB = chr(10), chr(9)
WS = " " + chr(9) + chr(10) + chr(11) + chr(12) + chr(13)  # the whitespace class, written without a backslash
# The job's input (note N-255 on plan/work/C02.md, with "The key's source, decided"): one JSON object on standard input
# with exactly the keys endpoint, apikey (a string or null), tokens (role class to token) and revoked_token. Nothing of
# it is printed: a missing or wrong key is named, never a value.
INPUT_KEYS = ("endpoint", "apikey", "tokens", "revoked_token")


def read_input():
    """(the object, None), or (None, the reason by name only)."""
    if sys.stdin is None or sys.stdin.isatty():
        return None, "no JSON object on standard input: the migration job's devos-test step gives it (N-255)"
    try:
        raw = sys.stdin.read()
    except (OSError, ValueError):
        return None, "standard input could not be read"
    if not raw.strip():
        return None, "no JSON object on standard input: the migration job's devos-test step gives it (N-255)"
    try:
        cfg = json.loads(raw)
    except ValueError:
        return None, "the input on standard input is not JSON (N-255)"
    raw = None
    if not isinstance(cfg, dict):
        return None, "the input is not one JSON object (N-255)"
    missing = [k for k in INPUT_KEYS if k not in cfg]
    extra = sum(1 for k in cfg if k not in INPUT_KEYS)
    if missing or extra:
        return None, ("the input's keys are not exactly " + ", ".join(INPUT_KEYS) + " (N-255): missing "
                      + (", ".join(missing) or "none") + "; " + str(extra) + " other key(s), not named")
    if cfg["apikey"] is not None and not isinstance(cfg["apikey"], str):
        return None, "apikey is neither a string nor null (N-255)"
    if not isinstance(cfg["tokens"], dict):
        return None, "tokens is not an object from role class to token (N-255)"
    return cfg, None

def api_lacks(cfg, classes, revoked=False):
    """What a Data API program lacks in the job's input, by name, or None. apikey null: N-255's key not stored yet."""
    if cfg["apikey"] is None:
        return ("apikey is null: the job holds no publishable key for devos-test yet (N-255, The key's source, "
                "decided), so no Data API case can run")
    out = [] if cfg["apikey"] else ["apikey (empty)"]
    if not isinstance(cfg["endpoint"], str) or not cfg["endpoint"]:
        out.append("endpoint")
    out += ["tokens." + c for c in classes if not isinstance(cfg["tokens"].get(c), str) or not cfg["tokens"].get(c)]
    if revoked and (not isinstance(cfg["revoked_token"], str) or not cfg["revoked_token"]):
        out.append("revoked_token")
    return ("the job's input has no " + ", ".join(out)) if out else None


def main():
    print(f"{TEST}: Data API part and file look (synthetic tokens from the job; no value or header is printed)")
    file_look()
    cfg, lack = read_input()
    if cfg is not None:
        lack = api_lacks(cfg, CLASSES)
    if lack:
        case("IDC-http", "could_not_check", lack)
    else:
        try:
            http_cases(cfg)
        except Exception as e:  # never a pass; the message is scrubbed of any token
            case("IDC-http", "could_not_check", scrub(f"the Data API part failed: {type(e).__name__}", cfg))
    cfg = None
    nb, nc, n = results.count("bad"), results.count("could_not_check"), len(results)
    if nb:
        print(f"{TEST} FAIL ({nb} bad, {nc} could not check, of {n})"); return 1
    if nc or not n:
        print(f"{TEST} COULD NOT CHECK ({nc} of {n} could not be checked)"); return 3
    print(f"{TEST} PASS ({n}/{n})"); return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:
        print(f"{TEST} COULD NOT CHECK (the program failed: {type(e).__name__})"); sys.exit(3)
