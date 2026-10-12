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
  {"endpoint": "<the project's API base URL>", "apikey": "<the publishable key>" or null,
   "tokens": {"<role class>": "<token>", ...}, "revoked_token": "<token>"}
exactly those four keys (N-255, "The key's source, decided"). apikey null means the key is not stored yet: every
Data API case is then "could not check", exit 3, with that reason. This program declares no need of the database,
so the job runs it under env -i, with no environment.
This program uses endpoint, apikey, tokens.devos_calisma, tokens.devos_denetim (which reads RejectedAttempt,
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
    print(TAB.join((str(cid), str(outcome), str(detail))))


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
    base, key = cfg["endpoint"], cfg["apikey"]
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
    cfg, why = read_input()
    if cfg is not None:
        why = api_lacks(cfg, ["devos_calisma", "devos_denetim"], revoked=True)
    if why:
        case("DM19B-B", "could_not_check", why + "; part B's claim then rests on part A and on W-C02-12")
    else:
        run(cfg)
    cfg = None
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
