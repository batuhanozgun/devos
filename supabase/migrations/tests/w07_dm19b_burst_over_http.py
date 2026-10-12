#!/usr/bin/env python3
"""T-W07-DM19B part B: a burst of Data API calls without a verified token adds no rows beyond the count.

Synthetic test data (plan Section 8 item 13): the calls carry synthetic tokens that the migration job's devos-test
step issued for this run and revokes after it (EV-C02-003 section 6.3; note N-255 on plan/work/C02.md); the malformed
and unknown forms are made here at run time from one of them, in memory. No token, key or header is printed, logged or
written; only role classes, reason codes and counts are (README sections 4 and 6).

Specification: tests/C02/W-C02-07/T-W07-DM19B_burst_count.md. Serves W-C02-09 point 3.
Runs: by the migration job's runner inside its devos-test step, from the repository root, as
  python3 -I supabase/migrations/tests/w07_dm19b_burst_over_http.py < <one JSON object on standard input>
(README section 5.1 (b); N-255). Python's standard library only. The input is the job's one JSON object:
  {"target": "devos-test", "endpoint": "<the project's API base URL>", "publishable_key": "<key>",
   "tokens": {"<role class>": "<token>", ...}, "revoked_token": "<token>"}
This program uses endpoint, publishable_key, tokens.devos_calisma, tokens.devos_denetim (which reads RejectedAttempt,
EV-C02-003 section 4.1) and revoked_token. Without them it gives COULD NOT CHECK and names what is missing (never a
value). Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK; the last line is "W07_DM19B_BURST_OVER_HTTP PASS|FAIL|COULD NOT CHECK
(...)" (README section 3).
Interface assumed (README section 8, v1): devos_api.token_role_class() and devos_api.read_rejected_attempts(since
timestamptz), the latter returning {status: ok, rows: [...]} whose rows carry function_name, role_class, reason_code,
counted_hour and count; a refusal is returned with HTTP 200 as {status: refused, reason_code}.
"""
import datetime
import json
import sys
import urllib.error
import urllib.request

sys.dont_write_bytecode = True
N = 50  # calls per reason code, fixed before any run
FUNCTION = "token_role_class"
NAME = "W07_DM19B_BURST_OVER_HTTP"
results = {}


def case(cid, outcome, detail):
    results[cid] = outcome
    print(f"{cid}\t{outcome}\t{detail}")


def read_input():
    """The job's one JSON object on standard input (N-255), or None. Nothing of it is printed."""
    if sys.stdin is None or sys.stdin.isatty():
        return None
    try:
        raw = sys.stdin.read()
        return json.loads(raw) if raw.strip() else None
    except (ValueError, OSError):
        return None


def rpc(base, key, fn, body, token, send_header=True):
    """POST one remote procedure call; returns (status, parsed body or None). Never prints a header."""
    headers = {"apikey": key, "Content-Type": "application/json", "Content-Profile": "devos_api",
               "Accept-Profile": "devos_api"}
    if send_header and token is not None:
        headers["x-devos-env-token"] = token
    req = urllib.request.Request(f"{base.rstrip('/')}/rest/v1/rpc/{fn}", data=json.dumps(body).encode(),
                                 headers=headers, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            raw, status = resp.read().decode("utf-8", "replace"), resp.status
    except urllib.error.HTTPError as err:
        raw, status = err.read().decode("utf-8", "replace"), err.code
    except (urllib.error.URLError, OSError):
        return None, None
    try:
        parsed = json.loads(raw) if raw else None
    except ValueError:
        parsed = None
    return status, parsed


def other_char(c):
    """Another character of the same class, so the token keeps its format and only its value is unknown."""
    if c == "9": return "0"
    if c in "fF": return chr(ord(c) - 5)
    if c in "zZ": return "g" if c == "z" else "G"
    if c in "-_": return "_" if c == "-" else "-"
    if c.isalnum(): return chr(ord(c) + 1)
    return c


def refused(status, body):
    """Interface v1: a refusal is returned (HTTP 200) as status refused; an HTTP error is a refusal the record lost."""
    return status is not None and (status >= 400 or (isinstance(body, dict) and body.get("status") == "refused"))


def tally(base, key, denetim, since):
    status, body = rpc(base, key, "read_rejected_attempts", {"since": since}, denetim)
    if status is None or status >= 400 or not isinstance(body, dict) or body.get("status") != "ok":
        return None
    rows = body.get("rows")
    if not isinstance(rows, list):
        return None
    out = {}
    for r in rows:
        if r.get("function_name") not in (FUNCTION, "devos_api." + FUNCTION):
            continue
        k = (str(r.get("reason_code")), str(r.get("role_class")), r.get("counted_hour") is None)
        rec = out.setdefault(k, {"rows": 0, "total": 0})
        rec["rows"] += 1
        rec["total"] += int(r.get("count") or 0)
    return out


def run(cfg):
    base, key = cfg["endpoint"], cfg["publishable_key"]
    cal, den = cfg["tokens"]["devos_calisma"], cfg["tokens"]["devos_denetim"]
    forms = {"missing": None, "empty": "", "malformed": cal[: max(len(cal) // 2, 1)],
             "unknown": cal[:-1] + other_char(cal[-1]), "revoked": cfg["revoked_token"]}
    since = (datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(hours=2)).isoformat()
    start = datetime.datetime.now(datetime.timezone.utc)
    before = tally(base, key, den, since)
    if before is None:
        case("DM19B-B", "could_not_check", "devos_api.read_rejected_attempts could not be read with the denetim token")
        return
    status, body = rpc(base, key, FUNCTION, {}, cal)
    pos_ok = status == 200 and isinstance(body, dict) and body.get("status") == "ok" and body.get("role_class") == "devos_calisma"
    case("DM19B-B-pos", "ok" if pos_ok else "bad", f"verified devos_calisma token: HTTP {status}")
    counts = {}
    for form, tok in forms.items():
        counts[form] = sum(refused(*rpc(base, key, FUNCTION, {}, tok, send_header=tok is not None)) for _ in range(N))
    forms = cal = None
    end = datetime.datetime.now(datetime.timezone.utc)
    after = tally(base, key, den, since)
    den = None
    if after is None:
        case("DM19B-B", "could_not_check", "devos_api.read_rejected_attempts could not be read after the burst")
        return
    hours = 1 + int(end.replace(minute=0, second=0, microsecond=0) > start.replace(minute=0, second=0, microsecond=0))
    for form in counts:
        k = (form, "none", False)
        rows = after.get(k, {}).get("rows", 0) - before.get(k, {}).get("rows", 0)
        total = after.get(k, {}).get("total", 0) - before.get(k, {}).get("total", 0)
        per_call = sum(v["rows"] for kk, v in after.items() if kk[0] == form and (kk[1] != "none" or kk[2])) - sum(
            v["rows"] for kk, v in before.items() if kk[0] == form and (kk[1] != "none" or kk[2]))
        ok = counts[form] == N and rows <= hours and total == N and per_call == 0
        case(f"DM19B-B-{form}", "ok" if ok else "bad", f"{N} calls, refused {counts[form]}; counted rows +{rows} "
             f"(bound {hours}); total +{total}; per-call rows +{per_call}")


def main():
    cfg = read_input()
    toks = (cfg or {}).get("tokens") if isinstance((cfg or {}).get("tokens"), dict) else {}
    need = (("endpoint", (cfg or {}).get("endpoint")), ("publishable_key", (cfg or {}).get("publishable_key")),
            ("tokens.devos_calisma", toks.get("devos_calisma")), ("tokens.devos_denetim", toks.get("devos_denetim")),
            ("revoked_token", (cfg or {}).get("revoked_token")))
    missing = [k for k, v in need if not v]
    if cfg is None:
        case("DM19B-B", "could_not_check", "no JSON object on standard input: the migration job's devos-test step gives "
             "it (N-255); until then part B is could not check and the claim rests on part A and on W-C02-12")
    elif missing:
        case("DM19B-B", "could_not_check", "the job's input has no " + ", ".join(missing))
    else:
        run(cfg)
    cfg = toks = None
    vals = list(results.values())
    nb, nc, n = vals.count("bad"), vals.count("could_not_check"), len(vals)
    if nb:
        print(f"{NAME} FAIL ({nb} bad, {nc} could not check, of {n})"); return 1
    if nc or not n:
        print(f"{NAME} COULD NOT CHECK ({nc} of {n} could not be checked)"); return 3
    print(f"{NAME} PASS ({n}/{n})"); return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:  # never a pass; no input value is printed
        print(f"{NAME} COULD NOT CHECK (the program failed: {type(e).__name__})"); sys.exit(3)
