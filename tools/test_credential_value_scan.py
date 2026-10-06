#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): every value, file and commit planted here is made up
# for the test and is no credential of anyone. Not made up, because the tool under test names them: the guard's
# credential variable names, the token file variable and the documented placeholder "proxy-injected".
"""test_credential_value_scan.py: planted cases for tools/credential_value_scan.py (CHK-C00-070 condition 1).

A fixture repository holds a planted value in a blob, another in a commit message and a third only in an object no
ref reaches; a fixture directory holds a value inside a file and another split across the tool's 1 MiB read
boundary. The tool runs in a child process whose environment holds only the planted variables and a token file.
The cases check what is searched for and what is not (placeholder, path, URL, short), the counts and locations
reported, that no planted value or 6-character piece of one reaches the output, and the error exits. Prints one
line per case and CREDENTIAL_VALUE_SCAN_TEST PASS only if every case passes.
"""
import os, sys, shutil, tempfile
import subprocess as sp
sys.dont_write_bytecode = True
from pathlib import Path  # noqa: E402

TOOL = Path(__file__).resolve().parent / "credential_value_scan.py"
RESULTS, PLANTED = [], []


def plant(v):
    PLANTED.append(v)
    return v


def case(name, ok):
    RESULTS.append(bool(ok))
    print(("PASS " if ok else "FAIL ") + name)


IDENT = {"PATH": "/usr/bin:/bin", "GIT_CONFIG_NOSYSTEM": "1"}
for who in ("AUTHOR", "COMMITTER"):
    IDENT["GIT_" + who + "_NAME"], IDENT["GIT_" + who + "_EMAIL"] = "Fixture", "fixture@example.invalid"


def git(repo, *args, data=None):
    p = sp.Popen(["git", "-C", repo, *args], stdin=sp.PIPE, stdout=sp.PIPE, stderr=sp.PIPE, env=dict(IDENT, HOME=repo))
    out = p.communicate(data)[0]
    assert p.returncode == 0, args
    return out.decode().strip()


def run(env, *args, tool=TOOL):
    base = {"PATH": "/usr/bin:/bin", "LANG": "C.UTF-8"}
    base.update(env)
    p = sp.Popen([sys.executable, "-I", str(tool), *args], env=base, stdout=sp.PIPE, stderr=sp.STDOUT, text=True)
    out = p.communicate(timeout=120)[0]
    return p.returncode, out


def pieces_in(out):
    return sorted({v[i:i + 6] for v in PLANTED for i in range(len(v) - 5)} & {out[i:i + 6] for i in range(len(out) - 5)})


MSG = plant("FakeMessagingTok" + "en0123456789abcd")
GHV = plant("ghp_" + "FakeGithubValueForTestOnly0123")
FILEV = plant("eyJmYWtlIjoidGVzdCJ9" + ".fakeTokenFileBody.sig0123")
MSG_ONLY_COMMIT = plant("CommitMessageOnly" + "Value98765")
SHORT = "short-but-set"
with tempfile.TemporaryDirectory() as d:
    repo = os.path.join(d, "repo")
    os.makedirs(repo)
    git(repo, "init", "-q")
    Path(repo, "a.txt").write_text("nothing here\n")
    Path(repo, "b.txt").write_text("line with " + MSG + " inside\n")
    git(repo, "add", "-A")
    git(repo, "commit", "-q", "-m", "first")
    Path(repo, "c.txt").write_text("plain\n")
    git(repo, "add", "-A")
    git(repo, "commit", "-q", "-m", "second carries " + GHV)
    dangling = git(repo, "hash-object", "-w", "--stdin", data=("orphan " + FILEV + "\n").encode())
    tdir = os.path.join(d, "transcripts")
    os.makedirs(os.path.join(tdir, "sub"))
    Path(tdir, "one.jsonl").write_text('{"text": "x ' + MSG + ' y"}\n')
    big = b"x" * ((1 << 20) - 8) + GHV.encode() + b"tail\n"
    Path(tdir, "sub", "big.jsonl").write_bytes(big)
    Path(tdir, "clean.jsonl").write_text("nothing\n")
    tokfile = os.path.join(d, "token-file")
    Path(tokfile).write_text(FILEV + "\n")
    env = {"CLAUDE_CODE_MESSAGING_TOKEN": MSG, "GH_TOKEN": GHV, "GITHUB_TOKEN": "proxy-injected",
           "ANTHROPIC_API_KEY": SHORT, "SESSION_INGRESS_URL": "https://fake.example.invalid/session/abcdefghijk",
           "CLAUDE_CODE_MESSAGING_SOCKET": "/tmp/fake-socket-path-for-test", "CLAUDE_SESSION_INGRESS_TOKEN_FILE": tokfile}
    rc, out = run(env, "--repo", repo, "--dir", tdir)
    case("exit 0 and DONE", rc == 0 and out.rstrip().endswith("CREDENTIAL_VALUE_SCAN DONE"))
    case("searched: messaging token, GH_TOKEN, token file, with lengths",
         f"CLAUDE_CODE_MESSAGING_TOKEN: length {len(MSG)}" in out and f"GH_TOKEN: length {len(GHV)}" in out
         and f"the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE: length {len(FILEV)}" in out)
    case("not searched: placeholder, short, URL, path",
         "GITHUB_TOKEN: not a candidate" in out and "ANTHROPIC_API_KEY: not a candidate" in out
         and "SESSION_INGRESS_URL: not a candidate" in out and "CLAUDE_CODE_MESSAGING_SOCKET: not a candidate" in out)
    blob = git(repo, "rev-parse", "HEAD~1:b.txt")
    head = git(repo, "rev-parse", "HEAD")
    case("repo: blob match located", f"CLAUDE_CODE_MESSAGING_TOKEN: 1 objects hold it: {blob}" in out)
    case("repo: commit-message match located", f"GH_TOKEN: 1 objects hold it: {head}" in out)
    case("repo: object no ref reaches", f"the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE: 1 objects hold it: {dangling}" in out)
    case("dir: file match", "CLAUDE_CODE_MESSAGING_TOKEN: 1 files hold it: one.jsonl" in out)
    case("dir: match across the 1 MiB boundary", "GH_TOKEN: 1 files hold it: sub/big.jsonl" in out)
    case("dir: token-file value absent there", "the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE: 0 files hold it" in out)
    case("dir: files counted", "transcripts: 3 files read" in out)
    case("no planted value or 6-character piece in the output", not pieces_in(out))
    case("positive control: the piece check sees a planted value", bool(pieces_in("x" + MSG[2:11] + "x")))

    rc, out = run({}, "--dir", tdir)
    case("nothing to search: none, exit 0", rc == 0 and "Values searched for: none" in out)

    rc, out = run(env, "--repo", os.path.join(d, "not-a-repo"))
    case("a scope that cannot be read: ERROR, INCOMPLETE, exit 2",
         rc == 2 and "ERROR, not read" in out and out.rstrip().endswith("INCOMPLETE") and not pieces_in(out))

    os.makedirs(os.path.join(d, "t2", "tools"))
    shutil.copy(TOOL, os.path.join(d, "t2", "tools", "credential_value_scan.py"))
    rc, out = run(env, "--dir", tdir, tool=Path(d, "t2", "tools", "credential_value_scan.py"))
    case("guard file missing: exit 2, error line only",
         rc == 2 and out.startswith("CREDENTIAL_VALUE_SCAN ERROR") and len(out.strip().splitlines()) == 1)

case("no bytecode cache in tools/", not (TOOL.parent / "__pycache__").exists() or not any(
    p.name.startswith("credential_value_scan") for p in (TOOL.parent / "__pycache__").iterdir()))
print("CREDENTIAL_VALUE_SCAN_TEST " + ("PASS" if all(RESULTS) else "FAIL"))
sys.exit(0 if all(RESULTS) else 1)
