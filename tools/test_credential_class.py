#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): every value planted in this file is made up for the
# test and is no credential of anyone. Not made up, because the tool under test names them: the guard's credential
# variable names, the documented placeholder "proxy-injected" and the public token prefixes.
"""test_credential_class.py: planted cases for tools/credential_class.py (N-027; CHK-C00-067 condition 1).

The tool runs in a child process whose environment holds only the planted variables. The cases check each class
and the "unset" and "empty" lines, that a variable whose name is not credential-like is not listed, that a
credential-like name outside the guard's list is, the equality line, the exit when the guard file is missing, that
the names come from this checkout's guard in its order, and that no planted value, nor any 6-character piece of
one, reaches the output. Prints one line per case and CREDENTIAL_CLASS_TEST PASS only if every case passes.
"""
import os, sys, shutil, tempfile
import subprocess as sp
sys.dont_write_bytecode = True
from pathlib import Path  # noqa: E402

TOOL = Path(__file__).resolve().parent / "credential_class.py"
GUARD = Path(__file__).resolve().parent.parent / ".claude" / "hooks" / "tool_allowlist.py"
RESULTS, PLANTED = [], []


def plant(v):
    PLANTED.append(v)
    return v


def run(env, tool=TOOL):
    base = {"PATH": "/usr/bin:/bin", "LANG": "C.UTF-8"}
    base.update(env)
    p = sp.Popen([sys.executable, "-I", str(tool)], env=base, stdout=sp.PIPE, stderr=sp.STDOUT, text=True)
    out = p.communicate(timeout=60)[0]
    return p.returncode, out


def case(name, ok):
    RESULTS.append(ok)
    print(("PASS " if ok else "FAIL ") + name)


def leaks(out):
    pieces = {v[i:i + 6] for v in PLANTED for i in range(0, max(1, len(v) - 5)) if len(v) >= 6}
    return sorted(p for p in pieces if p in out and p != "proxy-")


GH_FAKE = plant("ghp_" + "Q7xK2mN9pR4sT1vW8yZ3bC6dF0hJ5kL2nP9qR")
PAT_FAKE = plant("github_pat_" + "11ABCDEFG0zYxWvUtSrQpOnMlKjIhGfEdCbA9876543210")
ANT_FAKE = plant("sk-ant-" + "api03-fakefakefakeXyZ123abcDEF456ghiJKL789")
SK_FAKE = plant("sk-" + "proj-fakeOnlyForTest0123456789abcdef")
JWT_FAKE = plant("eyJhbGciOiJIUzI1NiJ9" + "." + "eyJzdWIiOiJmYWtlLXRlc3QifQ" + "." + "c2lnbmF0dXJlLWZha2U")
PATH_FAKE = plant("/run/fake-session/token-file-for-test")
URL_FAKE = plant("https://fake-ingress.example.invalid/session/xyz")
OTHER_FAKE = plant("plainFakeValueQwertyAsdfgh0987")
NOTCRED_FAKE = plant("colourOfTheFakeHarbourLantern")

# 1. The documented placeholder in both variables.
rc, out = run({"GH_TOKEN": "proxy-injected", "GITHUB_TOKEN": "proxy-injected"})
case("placeholder in both: class and length", rc == 0
     and "GH_TOKEN: set, length 14, class: the documented placeholder" in out
     and "GITHUB_TOKEN: set, length 14, class: the documented placeholder" in out)
case("placeholder in both: equal yes", "GH_TOKEN and GITHUB_TOKEN equal: yes" in out)
case("placeholder itself not printed", "proxy-injected" not in out)

# 2. A GitHub token in one, the other unset.
rc, out = run({"GH_TOKEN": GH_FAKE})
case("GitHub prefix", rc == 0 and f"GH_TOKEN: set, length {len(GH_FAKE)}, class: GitHub token prefix" in out)
case("unset line", "GITHUB_TOKEN: unset" in out)
case("no equality line when one is unset", "equal:" not in out)

# 3. Every other class, through the guard's variables and other credential-like names.
env = {"GH_TOKEN": PAT_FAKE, "GITHUB_TOKEN": GH_FAKE, "ANTHROPIC_API_KEY": ANT_FAKE,
       "CLAUDE_CODE_OAUTH_TOKEN": JWT_FAKE, "CLAUDE_SESSION_INGRESS_TOKEN_FILE": PATH_FAKE,
       "SESSION_INGRESS_URL": URL_FAKE, "ANTHROPIC_AUTH_TOKEN": "", "FAKE_SERVICE_API_KEY": SK_FAKE,
       "FAKE_DB_PASSWORD": OTHER_FAKE, "HARBOUR_LANTERN_COLOUR": NOTCRED_FAKE, "GIT_AUTHOR_NAME": "Fake Author"}
rc, out = run(env)
case("fine-grained prefix", "GH_TOKEN: set, length %d, class: GitHub fine-grained token prefix" % len(PAT_FAKE) in out)
case("Anthropic prefix", "ANTHROPIC_API_KEY: set, length %d, class: Anthropic key prefix" % len(ANT_FAKE) in out)
case("JWT-shaped", "CLAUDE_CODE_OAUTH_TOKEN: set, length %d, class: JWT-shaped" % len(JWT_FAKE) in out)
case("absolute path", "CLAUDE_SESSION_INGRESS_TOKEN_FILE: set, length %d, class: an absolute path" % len(PATH_FAKE)
     in out)
case("URL", "SESSION_INGRESS_URL: set, length %d, class: a URL" % len(URL_FAKE) in out)
case("empty", "ANTHROPIC_AUTH_TOKEN: set, empty" in out)
case("other credential-like name listed, sk- class",
     "FAKE_SERVICE_API_KEY: set, length %d, class: another sk- key prefix" % len(SK_FAKE) in out)
case("other credential-like name listed, other class",
     "FAKE_DB_PASSWORD: set, length %d, class: other" % len(OTHER_FAKE) in out)
case("non-credential name not listed", "HARBOUR_LANTERN_COLOUR" not in out and "GIT_AUTHOR_NAME" not in out)
case("equal no", "GH_TOKEN and GITHUB_TOKEN equal: no" in out)
case("no planted value or 6-character piece in the output", not leaks(out))
case("positive control: the piece check sees a planted value", bool(leaks("x" + OTHER_FAKE[3:12] + "x")))

# 4. Nothing credential-like outside the guard's list.
rc, out = run({})
case("none line", rc == 0 and "Other variables whose name looks like a credential's: none" in out)

# 5. The names are the guard's, in its order.
import ast  # noqa: E402
tree = ast.parse(GUARD.read_text(encoding="utf-8"))
names = next(ast.literal_eval(n.value) for n in tree.body if isinstance(n, ast.Assign)
             and any(getattr(t, "id", None) == "CREDENTIAL_VARS" for t in n.targets))
listed = [l.strip().split(":")[0] for l in out.splitlines()[1:1 + len(names)]]
case("names from the guard, in order", listed == list(names) and len(names) >= 2)

# 6. The guard file missing: exit 2, nothing else read.
with tempfile.TemporaryDirectory() as d:
    (Path(d) / "tools").mkdir()
    shutil.copy(TOOL, Path(d) / "tools" / "credential_class.py")
    rc, out = run({"GH_TOKEN": GH_FAKE}, Path(d) / "tools" / "credential_class.py")
case("guard missing: exit 2 and an error line only",
     rc == 2 and out.startswith("CREDENTIAL_CLASS ERROR") and "GH_TOKEN" not in out)

# 7. No bytecode written next to the tool.
case("no bytecode cache in tools/", not (TOOL.parent / "__pycache__").exists() or not any(
    p.name.startswith("credential_class") for p in (TOOL.parent / "__pycache__").iterdir()))

print("CREDENTIAL_CLASS_TEST " + ("PASS" if all(RESULTS) else "FAIL"))
sys.exit(0 if all(RESULTS) else 1)
