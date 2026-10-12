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
Interface (the executor's decision 3): python3 -I tests/C02/W-C02-07/bin/6tk_http_reasons.py < <JSON> with
{"endpoint": ..., "apikey": ..., "tokens": {"devos_denetim": ...}, "revoked_token": ...}.
Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK.
"""
import json
import sys
import urllib.error
import urllib.request

sys.dont_write_bytecode = True
TEST = "T-W07-6TK"
results = []


def case(cid, outcome, detail):
    results.append(outcome)
    print(f"{cid}\t{outcome}\t{detail}")


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
    if isinstance(js, dict) and (js.get("status") == "refused" or js.get("refused") is True or "reason_code" in js):
        return js.get("reason_code", "refused_without_code")
    return None


def role_of(js):
    if isinstance(js, str):
        return js
    if isinstance(js, dict) and refusal(js) is None:
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


def main():
    print(f"{TEST}: Data API part (synthetic tokens from the job; no value or header is printed)")
    cfg = None
    if not sys.stdin.isatty():
        try:
            raw = sys.stdin.read()
            cfg = json.loads(raw) if raw.strip() else None
            raw = None
        except ValueError:
            cfg = None
    den = (cfg or {}).get("tokens", {}).get("devos_denetim") if isinstance((cfg or {}).get("tokens"), dict) else None
    if not cfg or not cfg.get("endpoint") or not cfg.get("apikey") or not den or not cfg.get("revoked_token"):
        case("6TK-http", "could_not_check", "no endpoint, publishable key, audit token and revoked token on standard input: "
             "the migration job's devos-test step does not run this program yet (the executor's decision 3)")
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
