#!/usr/bin/env python3
"""T-W07-5A part B: devos_private is not among the Data API's exposed schemas; devos_api is.

Synthetic test data (plan Section 8 item 13): the requests carry no data of their own; the positive control uses one
synthetic devos_calisma token the migration job's devos-test step issued (EV-C02-003 section 6.3). No token, key or
header is printed or written; only HTTP statuses and PostgREST error codes are.

Specification: tests/C02/W-C02-07/T-W07-5A_no_direct_writes.md (part B). Serves W-C02-08 point 4 (the catalogue look
"devos_private not among the Data API's exposed schemas", where the setting is not readable in the database).
Runs: by the migration job's runner inside its devos-test step (README 5.1 (b); the executor's decision 3), with
`python3 -I`; standard library only. Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK; the last line says which.
Inputs from the job's environment (never printed): W07_DATA_API_URL, W07_PUBLISHABLE_KEY, W07_TOKEN_CALISMA.
"""
import json
import os
import sys
import urllib.error
import urllib.request

NAME = "T-W07-5A part B"
TABLES = ("event", "rejected_attempt", "work", "relation")  # synthetic probes: names only, no rows are read


def request(url, headers, data=None):
    req = urllib.request.Request(url, data=data, headers=headers, method="POST" if data is not None else "GET")
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            return resp.status, resp.read().decode("utf-8", "replace")
    except urllib.error.HTTPError as err:
        return err.code, err.read().decode("utf-8", "replace")
    except (urllib.error.URLError, OSError) as err:
        return None, type(err).__name__


def finish(kind, text):
    print(f"{NAME} {kind} ({text})")
    sys.exit({"PASS": 0, "FAIL": 1, "COULD NOT CHECK": 3}[kind])


def main():
    base, key, tok = (os.environ.get(k) for k in ("W07_DATA_API_URL", "W07_PUBLISHABLE_KEY", "W07_TOKEN_CALISMA"))
    if not (base and key and tok):
        finish("COULD NOT CHECK", "the job gave no endpoint, publishable key or synthetic token")
    base = base.rstrip("/")
    results = []
    # Positive control: devos_api is exposed and a verified token's read function answers.
    status, body = request(f"{base}/rest/v1/rpc/token_role_class",
                           {"apikey": key, "Content-Type": "application/json", "Content-Profile": "devos_api",
                            "x-devos-env-token": tok}, data=b"{}")
    if status is None:
        finish("COULD NOT CHECK", f"the Data API could not be reached ({body})")
    ok = status == 200 and "devos_calisma" in body
    results.append(ok)
    print(f"5A-B-pos\t{'ok' if ok else 'bad'}\tPOST rpc/token_role_class in devos_api: HTTP {status}")
    for table in TABLES:
        status, body = request(f"{base}/rest/v1/{table}?select=*&limit=0",
                               {"apikey": key, "Accept-Profile": "devos_private"})
        try:
            code = json.loads(body).get("code")
        except (ValueError, AttributeError):
            code = None
        ok = status is not None and status >= 400 and code == "PGRST106"
        results.append(ok)
        print(f"5A-B-exposed:{table}\t{'ok' if ok else 'bad'}\tGET with Accept-Profile devos_private: HTTP {status}, "
              f"code {code} (PGRST106: the schema is not exposed)")
    n_bad = results.count(False)
    if n_bad:
        finish("FAIL", f"{n_bad} bad of {len(results)}")
    finish("PASS", f"{len(results)}/{len(results)}")


if __name__ == "__main__":
    main()
