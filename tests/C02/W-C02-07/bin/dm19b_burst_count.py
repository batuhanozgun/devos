#!/usr/bin/env python3
"""T-W07-DM19B part B: a burst of Data API calls without a verified token adds no rows beyond the count.

Synthetic test data (plan Section 8 item 13): the calls carry synthetic tokens that the migration job's devos-test
step issues and revokes (EV-C02-003 section 6.3); the malformed and unknown forms are made here at run time from one
of them, in memory. No token, key or header is printed, logged or written; only role classes, reason codes and
counts are (README 4 and 6).

Specification: tests/C02/W-C02-07/T-W07-DM19B_burst_count.md. Serves W-C02-09 point 3.
Runs: by the migration job's runner inside its devos-test step (README 5.1 (b); the executor's decision 3), with
`python3 -I`. Python standard library only. Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK; the last line says which.

Inputs, from the job's environment (never printed):
  W07_DATA_API_URL       the project's API base URL (for example https://<ref>.supabase.co), devos-test only
  W07_PUBLISHABLE_KEY    the publishable key, sent as apikey
  W07_TOKEN_CALISMA      a verified synthetic devos_calisma token
  W07_TOKEN_DENETIM      a verified synthetic devos_denetim token (reads RejectedAttempt, EV-C02-003 section 4.1)
  W07_TOKEN_REVOKED      a synthetic token the job revoked before this run
Interface assumed (the specification's "Interface assumed"): devos_api.token_role_class() and
devos_api.read_rejected_attempts(since timestamptz), the latter returning rows (or a JSON list) with function_name,
role_class, reason_code, counted_hour and count.
"""
import datetime
import json
import os
import sys
import urllib.error
import urllib.request

N = 50  # calls per reason code, fixed before any run
FUNCTION = "token_role_class"
NAME = "T-W07-DM19B"


def finish(kind, text):
    code = {"PASS": 0, "FAIL": 1, "COULD NOT CHECK": 3}[kind]
    print(f"{NAME} {kind} ({text})")
    sys.exit(code)


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
            raw = resp.read().decode("utf-8", "replace")
            status = resp.status
    except urllib.error.HTTPError as err:
        raw = err.read().decode("utf-8", "replace")
        status = err.code
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
    if status >= 400:
        return True
    if isinstance(body, dict):
        return (body.get("ok") is False or str(body.get("status", body.get("outcome", ""))).lower()
                in ("refused", "rejected", "could_not_check", "error") or body.get("reason_code") is not None)
    return False


def tally(base, key, denetim, since):
    status, body = rpc(base, key, "read_rejected_attempts", {"since": since}, denetim)
    if status >= 400 or body is None:
        return None
    rows = body if isinstance(body, list) else body.get("rows") if isinstance(body, dict) else None
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


def main():
    env = {k: os.environ.get(k) for k in ("W07_DATA_API_URL", "W07_PUBLISHABLE_KEY", "W07_TOKEN_CALISMA",
                                          "W07_TOKEN_DENETIM", "W07_TOKEN_REVOKED")}
    missing = [k for k, v in env.items() if not v]
    if missing:
        finish("COULD NOT CHECK", "the job gave no " + ", ".join(missing) + "; until the build's runner gives them, "
               "part B is could not check and the claim rests on part A and on W-C02-12")
    base, key, cal = env["W07_DATA_API_URL"], env["W07_PUBLISHABLE_KEY"], env["W07_TOKEN_CALISMA"]
    forms = {"missing": None, "empty": "", "malformed": cal[: max(len(cal) // 2, 1)],
             "unknown": cal[:-1] + other_char(cal[-1]), "revoked": env["W07_TOKEN_REVOKED"]}
    since = (datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(hours=2)).isoformat()
    start = datetime.datetime.now(datetime.timezone.utc)
    before = tally(base, key, env["W07_TOKEN_DENETIM"], since)
    if before is None:
        finish("COULD NOT CHECK", "devos_api.read_rejected_attempts could not be read with the denetim token")
    status, body = rpc(base, key, FUNCTION, {}, cal)
    pos_ok = not refused(status, body) and "devos_calisma" in json.dumps(body)
    print(f"DM19B-B-pos\t{'ok' if pos_ok else 'bad'}\tverified devos_calisma token: HTTP {status}")
    results = {"DM19B-B-pos": pos_ok}
    counts = {}
    for form, tok in forms.items():
        n_ref = 0
        for _ in range(N):
            s, b = rpc(base, key, FUNCTION, {}, tok, send_header=tok is not None)
            n_ref += refused(s, b)
        counts[form] = n_ref
    end = datetime.datetime.now(datetime.timezone.utc)
    after = tally(base, key, env["W07_TOKEN_DENETIM"], since)
    if after is None:
        finish("COULD NOT CHECK", "devos_api.read_rejected_attempts could not be read after the burst")
    hours = 1 + int(end.replace(minute=0, second=0, microsecond=0) > start.replace(minute=0, second=0, microsecond=0))
    for form in forms:
        k = (form, "none", False)
        rows = after.get(k, {}).get("rows", 0) - before.get(k, {}).get("rows", 0)
        total = after.get(k, {}).get("total", 0) - before.get(k, {}).get("total", 0)
        per_call = sum(v["rows"] for kk, v in after.items() if kk[0] == form and (kk[1] != "none" or kk[2])) - sum(
            v["rows"] for kk, v in before.items() if kk[0] == form and (kk[1] != "none" or kk[2]))
        ok = counts[form] == N and rows <= hours and total == N and per_call == 0
        results[f"DM19B-B-{form}"] = ok
        print(f"DM19B-B-{form}\t{'ok' if ok else 'bad'}\t{N} calls, refused {counts[form]}; counted rows +{rows} "
              f"(bound {hours}); total +{total}; per-call rows +{per_call}")
    n_bad = sum(1 for v in results.values() if not v)
    if n_bad:
        finish("FAIL", f"{n_bad} bad of {len(results)}")
    finish("PASS", f"{len(results)}/{len(results)}")


if __name__ == "__main__":
    main()
