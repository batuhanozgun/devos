#!/usr/bin/env python3
"""T-W07-6TK, its Data API part (spec: tests/C02/W-C02-07/T-W07-6TK_token_reasons.md, part B).

Synthetic test data (plan Section 8 item 13): the tokens are synthetic tokens the migration job's devos-test step
issues for this run (one devos_denetim token and one revoked token), hands over on standard input and revokes after
the run (EV-C02-003 §6.3; the executor's decision 3). The malformed and unknown values are made from the given token in
memory, at run time. Nothing secret is printed: no token, no altered token, no header.

Cases (each on POST /rest/v1/rpc/token_role_class; the refusal must come back as the function's answer, HTTP 200, so
that its RejectedAttempt record commits; a refusal by error means the record was rolled back and is "bad"):
  6TK-http-missing    no header                                  -> reason code missing
  6TK-http-empty      header with an empty value                 -> empty ("could not check" if the route delivers it as missing)
  6TK-http-malformed  the token cut by one character             -> malformed
  6TK-http-unknown    one character of the random part changed   -> unknown
  6TK-http-revoked    a revoked token                            -> revoked
  6TK-http-ok         the valid audit token                      -> accepted as devos_denetim (positive control)
  6TK-http-get1       GET with no header: the Data API runs GET read-only, so the refusal cannot be recorded; named
                      result: never accepted (a refusal or an error), and never a role class (N-244 item (2)).
header_unreadable is not made here: the Data API always sets request.headers, so it cannot arise on this path; the SQL
part plants it (w07_6tk_token_reasons.sql, 6TK-hu0 to hu4).
Runs: by the migration job's runner inside its devos-test step, from the repository root, as
  python3 -I supabase/migrations/tests/w07_6tk_http_reasons.py < <one JSON object on standard input>
(README section 5.1 (b); note N-255 on plan/work/C02.md). The input is the job's one JSON object:
  {"endpoint": "<the project's API base URL>", "apikey": "<the publishable key>" or null,
   "tokens": {"<role class>": "<token>", ...}, "revoked_token": "<token>"}
exactly those four keys (N-255, "The key's source, decided"). apikey null means the key is not stored yet: every
Data API case is then "could not check", exit 3, with that reason. This program declares no need of the database,
so the job runs it under env -i, with no environment.
Without the endpoint, the publishable key or a token it needs, every Data API case is "could not check", and the
line says which input is missing (never a value).
This program uses tokens.devos_denetim and revoked_token. Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK; the last line is
"W07_6TK_HTTP_REASONS PASS|FAIL|COULD NOT CHECK (...)" (README section 3).
"""
import json
import sys
import urllib.error
import urllib.request

sys.dont_write_bytecode = True
TEST = "W07_6TK_HTTP_REASONS"
results = []


def case(cid, outcome, detail):
    results.append(outcome)
    print(TAB.join((str(cid), str(outcome), str(detail))))


def call(cfg, token, method="POST", send_empty=False):
    url = cfg["endpoint"].rstrip("/") + "/rest/v1/rpc/token_role_class"
    req = urllib.request.Request(url, data=b"{}" if method == "POST" else None, method=method)
    req.add_header("apikey", cfg["apikey"])
    req.add_header("Content-Type", "application/json")
    req.add_header("Content-Profile", "devos_api")
    req.add_header("Accept-Profile", "devos_api")
    if token is not None or send_empty:
        req.add_header("x-devos-env-token", token or "")
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


def refusal(js):
    if isinstance(js, dict) and js.get("status") == "refused":  # interface v1 (README section 8)
        return js.get("reason_code", "refused_without_code")
    return None


def role_of(js):
    if isinstance(js, dict) and js.get("status") == "ok":  # interface v1: {status: ok, role_class}
        return js.get("role_class")
    return None


def judge(cid, cfg, token, want, send_empty=False):
    st, js, code = call(cfg, token, send_empty=send_empty)
    if st is None or (code and str(code).startswith("PGRST")):
        case(cid, "could_not_check", f"the Data API path did not answer the function: {st} {code}"); return
    ref = refusal(js)
    if want == "empty" and st == 200 and ref == "missing":
        case(cid, "could_not_check", "the route delivered the empty header as no header; empty is shown by the SQL part"); return
    if want.startswith("devos_"):
        ok = st == 200 and role_of(js) == want
        case(cid, "ok" if ok else "bad", f"HTTP {st}; role class {role_of(js) or 'none'} (wanted {want})"); return
    ok = st == 200 and ref == want
    case(cid, "ok" if ok else "bad", f"HTTP {st}; refusal {ref or '-'} (wanted {want}); role class {role_of(js) or 'none'}")


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
    print(f"{TEST}: Data API part (synthetic tokens from the job; no value or header is printed)")
    cfg, lack = read_input()
    if cfg is not None:
        lack = api_lacks(cfg, ["devos_denetim"], revoked=True)
    den = cfg["tokens"]["devos_denetim"] if not lack else None
    if lack:
        case("6TK-http", "could_not_check", lack)
    else:
        rnd = den[-43:]
        alt = "B" if rnd[10] == "A" else "A"
        judge("6TK-http-missing", cfg, None, "missing")
        judge("6TK-http-empty", cfg, None, "empty", send_empty=True)
        judge("6TK-http-malformed", cfg, den[:-1], "malformed")
        judge("6TK-http-unknown", cfg, den[:-43] + rnd[:10] + alt + rnd[11:], "unknown")
        judge("6TK-http-revoked", cfg, cfg["revoked_token"], "revoked")
        judge("6TK-http-ok", cfg, den, "devos_denetim")
        st, js, code = call(cfg, None, method="GET")
        if st is None or (code and str(code).startswith("PGRST2")):
            case("6TK-http-get1", "could_not_check", f"the Data API path did not answer the function: {st} {code}")
        else:
            case("6TK-http-get1", "ok" if role_of(js) is None and (st >= 300 or refusal(js)) else "bad",
                 f"GET, no header: HTTP {st}; refusal {refusal(js) or '-'}; error code {code or '-'}; role class {role_of(js) or 'none'}")
        den = rnd = None
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
