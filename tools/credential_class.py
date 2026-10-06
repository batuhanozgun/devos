#!/usr/bin/env python3
"""The class of the session's credential variables, never their values (N-027; CHK-C00-067 condition 1).

Plan C00's sixth acceptance condition asks that no secret be visible in an environment variable. The session's
environment holds GH_TOKEN and GITHUB_TOKEN (EV-C00-001 row 8). The platform's documentation describes two cases:
when the environment's owner set neither, both read as the placeholder string "proxy-injected" and the GitHub proxy
attaches the real credential outside the session; when the owner set one, it reaches the session unchanged
(the Claude Code documentation's page on cloud environments, its section on GitHub, read on 2026-10-06; the
page shows no date). The guard denies every plain route that would read or print them (B8). This
script tells the two cases apart without showing a value: it reads the variables inside its own process and prints,
for each, only whether it is set, its length and a class from the fixed list below.

Which variables: the guard's CREDENTIAL_VARS, read from the guard file of this checkout, and every other variable
whose name looks like a credential's (CREDENTIAL_NAME). Their names are printed; a name is not a secret.

Classes (the first that fits): the documented placeholder; a GitHub token prefix (ghp_, gho_, ghu_, ghs_, ghr_) or
the fine-grained prefix (github_pat_); an Anthropic key prefix (sk-ant-); another sk- key; JWT-shaped (three
dot-separated base64url parts); an absolute path; a URL; other. For GH_TOKEN and GITHUB_TOKEN it also prints
whether the two values are equal. It prints labels, names and integers only: no value, no part of one, no hash.
Usage: python3 -I tools/credential_class.py     Exit 0, or 2 when the guard file cannot be read.
"""
import ast
import os
import re
import sys
from pathlib import Path

sys.dont_write_bytecode = True
GUARD = Path(__file__).resolve().parent.parent / ".claude" / "hooks" / "tool_allowlist.py"
PLACEHOLDER = "proxy-injected"
CREDENTIAL_NAME = re.compile(r"TOKEN|SECRET|PASSW|API_?KEY|ACCESS_?KEY|PRIVATE_?KEY|CREDENTIAL|AUTH(?!OR)|COOKIE"
                             r"|SESSION_?KEY", re.I)
GITHUB_PREFIX = re.compile(r"(ghp|gho|ghu|ghs|ghr)_")
B64URL = re.compile(r"[A-Za-z0-9_-]+")


def guard_credential_vars():
    """CREDENTIAL_VARS as the guard file assigns it, read without running the guard."""
    tree = ast.parse(GUARD.read_text(encoding="utf-8"))
    for node in tree.body:
        if not isinstance(node, ast.Assign):
            continue
        if "CREDENTIAL_VARS" in [getattr(t, "id", None) for t in node.targets]:
            return tuple(ast.literal_eval(node.value))
    raise ValueError("CREDENTIAL_VARS not found")


def value_class(v):
    if v == PLACEHOLDER:
        return "the documented placeholder"
    if GITHUB_PREFIX.match(v):
        return "GitHub token prefix"
    if v.startswith("github_pat_"):
        return "GitHub fine-grained token prefix"
    if v.startswith("sk-ant-"):
        return "Anthropic key prefix"
    if v.startswith("sk-"):
        return "another sk- key prefix"
    parts = v.split(".")
    if len(parts) == 3 and all(p and B64URL.fullmatch(p) for p in parts):
        return "JWT-shaped"
    if v.startswith("/"):
        return "an absolute path"
    if re.match(r"[a-z][a-z0-9+.-]*://", v, re.I):
        return "a URL"
    return "other"


def describe(name, env):
    if name not in env:
        return f"{name}: unset"
    v = env[name]
    if v == "":
        return f"{name}: set, empty"
    return f"{name}: set, length {len(v)}, class: {value_class(v)}"


def main():
    try:
        named = guard_credential_vars()
    except (OSError, SyntaxError, ValueError) as e:
        print(f"CREDENTIAL_CLASS ERROR: the guard's CREDENTIAL_VARS could not be read ({type(e).__name__})")
        return 2
    env = dict(os.environ)
    print("The guard's credential variables:")
    for name in named:
        print("  " + describe(name, env))
    others = sorted(n for n in env if n not in named and CREDENTIAL_NAME.search(n))
    print("Other variables whose name looks like a credential's:" + ("" if others else " none"))
    for name in others:
        print("  " + describe(name, env))
    if "GH_TOKEN" in env and "GITHUB_TOKEN" in env:
        print("GH_TOKEN and GITHUB_TOKEN equal: " + ("yes" if env["GH_TOKEN"] == env["GITHUB_TOKEN"] else "no"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
