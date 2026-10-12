#!/usr/bin/env python3
"""T-W07-5A part B: devos_private is not among the Data API's exposed schemas; devos_api is.

Synthetic test data (plan Section 8 item 13): the requests carry no data of their own; the positive control uses one
synthetic devos_calisma token that the migration job's devos-test step issued for this run and revokes after it
(EV-C02-003 section 6.3; note N-255 on plan/work/C02.md). No token, key or header is printed or written; only HTTP
statuses and PostgREST error codes are.

Specification: tests/C02/W-C02-07/T-W07-5A_no_direct_writes.md (part B). Serves W-C02-08 point 4 (the catalogue look
"devos_private not among the Data API's exposed schemas", where the setting is not readable in the database).
Runs: by the migration job's runner inside its devos-test step, from the repository root, as
  python3 -I supabase/migrations/tests/w07_5a_exposed_schema.py < <one JSON object on standard input>
(README section 5.1 (b); N-255). Python's standard library only. The input is the job's one JSON object:
  {"target": "devos-test", "endpoint": "<the project's API base URL>", "publishable_key": "<key>",
   "tokens": {"<role class>": "<token>", ...}, "revoked_token": "<token>"}
This program uses endpoint, publishable_key and tokens.devos_calisma. Without them it gives COULD NOT CHECK and says
which is missing (never a value). Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK; the last line is
"W07_5A_EXPOSED_SCHEMA PASS|FAIL|COULD NOT CHECK (...)" (README section 3).
"""
import json
import sys
import urllib.error
import urllib.request

sys.dont_write_bytecode = True
NAME = "W07_5A_EXPOSED_SCHEMA"
TABLES = ("event", "rejected_attempt", "work", "relation")  # README section 8's table names; no rows are read
results = []


def case(cid, outcome, detail):
    results.append(outcome)
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


def request(url, headers, data=None):
    req = urllib.request.Request(url, data=data, headers=headers, method="POST" if data is not None else "GET")
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            return resp.status, resp.read().decode("utf-8", "replace")
    except urllib.error.HTTPError as err:
        return err.code, err.read().decode("utf-8", "replace")
    except (urllib.error.URLError, OSError) as err:
        return None, type(err).__name__


def run(cfg):
    base, key = cfg["endpoint"].rstrip("/"), cfg["publishable_key"]
    tok = cfg["tokens"]["devos_calisma"]
    # Positive control: devos_api is exposed and a verified token's read function answers (interface v1: status ok).
    status, body = request(f"{base}/rest/v1/rpc/token_role_class",
                           {"apikey": key, "Content-Type": "application/json", "Content-Profile": "devos_api",
                            "Accept-Profile": "devos_api", "x-devos-env-token": tok}, data=b"{}")
    tok = None
    if status is None:
        case("5A-B-pos", "could_not_check", f"the Data API could not be reached ({body})")
        return
    try:
        js = json.loads(body)
    except ValueError:
        js = None
    ok = status == 200 and isinstance(js, dict) and js.get("status") == "ok" and js.get("role_class") == "devos_calisma"
    case("5A-B-pos", "ok" if ok else "bad", f"POST rpc/token_role_class in devos_api: HTTP {status}")
    for table in TABLES:
        status, body = request(f"{base}/rest/v1/{table}?select=*&limit=0", {"apikey": key, "Accept-Profile": "devos_private"})
        try:
            code = json.loads(body).get("code")
        except (ValueError, AttributeError):
            code = None
        if status is None:
            case(f"5A-B-exposed:{table}", "could_not_check", f"the Data API could not be reached ({body})")
            continue
        ok = status >= 400 and code == "PGRST106"
        case(f"5A-B-exposed:{table}", "ok" if ok else "bad", f"GET with Accept-Profile devos_private: HTTP {status}, "
             f"code {code} (PGRST106: the schema is not exposed)")


def main():
    cfg = read_input()
    toks = (cfg or {}).get("tokens") if isinstance((cfg or {}).get("tokens"), dict) else {}
    missing = [k for k, v in (("endpoint", (cfg or {}).get("endpoint")), ("publishable_key", (cfg or {}).get("publishable_key")),
                              ("tokens.devos_calisma", toks.get("devos_calisma"))) if not v]
    if cfg is None:
        case("5A-B", "could_not_check", "no JSON object on standard input: the migration job's devos-test step gives it (N-255)")
    elif missing:
        case("5A-B", "could_not_check", "the job's input has no " + ", ".join(missing))
    else:
        run(cfg)
    cfg = toks = None
    nb, nc, n = results.count("bad"), results.count("could_not_check"), len(results)
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
