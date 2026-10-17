#!/usr/bin/env python3
"""devos_rpc.py: one call of a devos_api function over the live project's Data API (W-C02-09; the client path of
evidence/C02/EV-C02-013_w09_interface.md section 4 and evidence/C02/EV-C02-003_identity_chain_and_environments.md
sections 1.1 and 1.6). N-221 step 5's self-check uses it: `token_role_class` from the installation environment.

It sends one Data API remote procedure call, `POST https://<devos host>/rest/v1/rpc/<function>`, to the host of the
live project `devos` only (EV-C02-003, "Names this design fixes"; a session never calls `devos-test`, section 1.5),
with the publishable key in the `apikey` header, read only from the environment variable DEVOS_PUBLISHABLE_KEY.
It sets no token header: the agent proxy adds `x-devos-env-token` from the environment's network secret after the
request leaves the session (section 1.1), so this program never holds the environment token, and no DevOS credential is
read from a variable (section 1.1: none goes into any environment variable). It never prints a request header, the
key, or a token, and writes nothing to a file.

Usage: python3 -I tools/devos_rpc.py <function> < arguments.json
  <function>   a devos_api function name, lower-case letters, digits and underscores (e.g. token_role_class)
  stdin        a JSON object of the function's named arguments; empty input means no arguments (use < /dev/null)
Output: the function's answer as one line of JSON. A `claim_token` in the answer is withheld from the printed line
(a Python caller gets the whole answer from call()). Any string of a DevOS token format left in printed text is
removed. Exit: 0 the answer's status is ok; 1 a refusal or another status; 2 usage or input; 3 could not call (no key,
the network, an HTTP error, an answer that is not a JSON object).
"""
import json
import os
import re
import sys
import urllib.error
import urllib.request

HOST = "zyqgltzfzkdvrmvxlamz.supabase.co"  # devos, the live project (EV-C02-003, "Names this design fixes"; P:630)
KEY_VAR = "DEVOS_PUBLISHABLE_KEY"  # the publishable key's variable (EV-C02-003 section 7, sitting A)
FUNCTION = re.compile(r"[a-z_][a-z0-9_]{0,62}")
# The finder patterns of tests/C02/W-C02-07/shared/token_format.md section 3, the markers written in pieces so that only
# that file and the scan's pattern file hold them literally (tests/C02/W-C02-07/README.md section 6).
TOKEN_FIND = re.compile("(?i:" + "dv" + "(?:env|clm)" + "1_)[A-Za-z0-9_-]{16,}")
WITHHELD = "[claim token withheld: use devos_rpc.call() from Python]"


class CallError(Exception):
    """The call could not be made or its answer could not be read; the message holds no header, key or token."""


def call(function, args=None, timeout=30):
    """Call devos_api.<function> with the named arguments `args`; return the answer, a dict, unchanged."""
    if not isinstance(function, str) or not FUNCTION.fullmatch(function):
        raise ValueError("the function name must be lower-case letters, digits and underscores")
    if args is None:
        args = {}
    if not isinstance(args, dict):
        raise ValueError("the arguments must be a JSON object")
    key = os.environ.get(KEY_VAR) or None
    if key is None:
        raise CallError(f"{KEY_VAR} is not set")
    req = urllib.request.Request(f"https://{HOST}/rest/v1/rpc/{function}", data=json.dumps(args).encode("utf-8"),
                                 method="POST")
    req.add_header("apikey", key)
    req.add_header("Content-Type", "application/json")
    req.add_header("Accept", "application/json")
    req.add_header("Content-Profile", "devos_api")
    req.add_header("Accept-Profile", "devos_api")
    key = None
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            status, raw = r.status, r.read()
    except urllib.error.HTTPError as e:
        status, raw = e.code, e.read()
    except (urllib.error.URLError, OSError) as e:
        raise CallError(f"transport: {type(e).__name__}") from None
    finally:
        req = None
    try:
        answer = json.loads(raw.decode("utf-8")) if raw else None
    except (ValueError, UnicodeDecodeError):
        answer = None
    if status != 200:
        code = answer.get("code") if isinstance(answer, dict) else None
        raise CallError(f"HTTP {status}" + (f", PostgREST code {code}" if isinstance(code, str) else ""))
    if not isinstance(answer, dict):
        raise CallError("the answer is not a JSON object")
    return answer


def printable(answer):
    """The answer as one JSON line, with a claim token withheld and any token-format string removed."""
    shown = dict(answer)
    if "claim_token" in shown:
        shown["claim_token"] = WITHHELD
    return TOKEN_FIND.sub("[token-format string removed]", json.dumps(shown, sort_keys=True))


def main(argv=None):
    argv = sys.argv[1:] if argv is None else argv
    if len(argv) != 1 or not FUNCTION.fullmatch(argv[0]):
        print("usage: python3 -I tools/devos_rpc.py <function> < arguments.json", file=sys.stderr)
        return 2
    text = sys.stdin.read() if not sys.stdin.isatty() else ""
    try:
        args = json.loads(text) if text.strip() else {}
    except ValueError:
        print("devos_rpc: standard input is not JSON", file=sys.stderr)
        return 2
    text = None
    if not isinstance(args, dict):
        print("devos_rpc: standard input must be a JSON object of named arguments", file=sys.stderr)
        return 2
    try:
        answer = call(argv[0], args)
    except CallError as e:
        print("devos_rpc: could not call devos_api." + argv[0] + ": " + TOKEN_FIND.sub("[removed]", str(e)),
              file=sys.stderr)
        return 3
    finally:
        args = None
    print(printable(answer))
    return 0 if answer.get("status") == "ok" else 1


if __name__ == "__main__":
    sys.exit(main())
