#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): every value, file and commit planted here is made up
# for the test and is no credential of anyone. Not made up, because the tool under test names them: the guard's
# credential variable names, the token file variable and the documented placeholder "proxy-injected".
"""test_credential_value_scan.py: planted cases for tools/credential_value_scan.py (CHK-C00-070 condition 1).

A fixture repository holds a planted value in a blob, another in a commit message, a third only in an object no
ref reaches, a fourth only in a tree entry's name and a fifth only in an annotated tag's message; a fixture
directory holds a value inside a file, values split across the tool's 1 MiB read boundary at several points, and a
file whose own name holds a value. The built-in scopes (--session-transcripts, --guard-log) are pointed at fixtures
through $DEVOS_AUDIT_HOME and $DEVOS_GUARD_LOG_DIR. The tool runs in a child process whose environment holds only
the planted variables and a token file.
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
TAGV = plant("AnnotatedTagOnly" + "Value98765")
TREEV = plant("TreeEntryNameOnly" + "Value4321")
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
    second = git(repo, "rev-parse", "HEAD")
    dangling = git(repo, "hash-object", "-w", "--stdin", data=("orphan " + FILEV + "\n").encode())
    Path(repo, TREEV + ".txt").write_text("plain content\n")
    git(repo, "add", "-A")
    git(repo, "commit", "-q", "-m", "third")
    tree = git(repo, "rev-parse", "HEAD^{tree}")
    git(repo, "tag", "-a", "t1", "-m", "tag carries " + TAGV)
    tag = git(repo, "rev-parse", "t1")
    tdir = os.path.join(d, "transcripts")
    os.makedirs(os.path.join(tdir, "sub"))
    Path(tdir, "one.jsonl").write_text('{"text": "x ' + MSG + ' y"}\n')
    big = b"x" * ((1 << 20) - 8) + GHV.encode() + b"tail\n"
    Path(tdir, "sub", "big.jsonl").write_bytes(big)
    splits = (1, 5, 13, len(MSG) - 1)
    for k in splits:
        Path(tdir, "sub", f"split{k}.bin").write_bytes(b"y" * ((1 << 20) - k) + MSG.encode() + b"\n")
    Path(tdir, "named-" + MSG + ".txt").write_text("again " + MSG + "\n")
    Path(tdir, "clean.jsonl").write_text("nothing\n")
    tokfile = os.path.join(d, "token-file")
    Path(tokfile).write_text(FILEV + "\n")
    env = {"CLAUDE_CODE_MESSAGING_TOKEN": MSG, "GH_TOKEN": GHV, "GITHUB_TOKEN": "proxy-injected",
           "ANTHROPIC_API_KEY": SHORT, "SESSION_INGRESS_URL": "https://fake.example.invalid/session/abcdefghijk",
           "CLAUDE_CODE_MESSAGING_SOCKET": "/tmp/fake-socket-path-for-test", "CLAUDE_SESSION_INGRESS_TOKEN_FILE": tokfile,
           "CLOUDSDK_AUTH_ACCESS_TOKEN": TAGV, "ANTHROPIC_AUTH_TOKEN": TREEV}
    rc, out = run(env, "--repo", repo, "--dir", tdir)
    case("exit 0 and DONE", rc == 0 and out.rstrip().endswith("CREDENTIAL_VALUE_SCAN DONE"))
    case("searched: messaging token, GH_TOKEN, token file, with lengths",
         f"CLAUDE_CODE_MESSAGING_TOKEN: length {len(MSG)}" in out and f"GH_TOKEN: length {len(GHV)}" in out
         and f"the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE: length {len(FILEV)}" in out)
    case("not searched: placeholder, short, URL, path",
         "GITHUB_TOKEN: not a candidate" in out and "ANTHROPIC_API_KEY: not a candidate" in out
         and "SESSION_INGRESS_URL: not a candidate" in out and "CLAUDE_CODE_MESSAGING_SOCKET: not a candidate" in out)
    blob = git(repo, "rev-parse", second + ":b.txt")
    case("repo: blob match located", f"CLAUDE_CODE_MESSAGING_TOKEN: 1 objects hold it: {blob}" in out)
    case("repo: tree entry name and tag message found",
         f"ANTHROPIC_AUTH_TOKEN: 1 objects hold it: {tree}" in out
         and f"CLOUDSDK_AUTH_ACCESS_TOKEN: 1 objects hold it: {tag}" in out)
    case("repo: commit-message match located", f"GH_TOKEN: 1 objects hold it: {second}" in out)
    case("repo: object no ref reaches", f"the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE: 1 objects hold it: {dangling}" in out)
    line = next(x for x in out.splitlines()
                if x.strip().startswith("CLAUDE_CODE_MESSAGING_TOKEN") and "files hold" in x)
    case("dir: file match and every split point found",
         line.strip().startswith(f"CLAUDE_CODE_MESSAGING_TOKEN: {2 + len(splits)} files hold it")
         and "one.jsonl" in line and all(f"sub/split{k}.bin" in line for k in splits))
    case("dir: a path that holds a value is withheld", "(a path that holds a value)" in line)
    case("dir: match across the 1 MiB boundary", "GH_TOKEN: 1 files hold it: sub/big.jsonl" in out)
    case("dir: token-file value absent there", "the file named by CLAUDE_SESSION_INGRESS_TOKEN_FILE: 0 files hold it" in out)
    case("dir: files counted", f"transcripts: {4 + len(splits)} files read" in out)
    case("no planted value or 6-character piece in the output", not pieces_in(out))
    case("positive control: the piece check sees a planted value", bool(pieces_in("x" + MSG[2:11] + "x")))

    rc, out = run({}, "--dir", tdir)
    case("nothing to search: none, exit 0", rc == 0 and "Values searched for: none" in out)

    rc, out = run(env, "--repo", os.path.join(d, "not-a-repo"))
    case("a scope that cannot be read: ERROR, INCOMPLETE, exit 2",
         rc == 2 and "ERROR, not read" in out and out.rstrip().endswith("INCOMPLETE") and not pieces_in(out))
    rc, out = run(env, "--dir", os.path.join(d, "missing-dir"))
    case("a missing --dir: ERROR, INCOMPLETE, exit 2", rc == 2 and "ERROR, not read" in out
         and out.rstrip().endswith("INCOMPLETE"))
    os.makedirs(os.path.join(d, "empty-dir"))
    rc, out = run(env, "--dir", os.path.join(d, "empty-dir"))
    case("an empty --dir: ERROR, INCOMPLETE, exit 2", rc == 2 and out.rstrip().endswith("INCOMPLETE"))

    home = os.path.join(d, "home")
    os.makedirs(os.path.join(home, ".claude", "projects", "p1"))
    Path(home, ".claude", "projects", "p1", "s.jsonl").write_text('{"t": "' + MSG + '"}\n')
    glog = os.path.join(d, "guardlog")
    os.makedirs(glog)
    Path(glog, "session.jsonl").write_text('{"call": "nothing secret"}\n')
    rc, out = run(dict(env, DEVOS_AUDIT_HOME=home, DEVOS_GUARD_LOG_DIR=glog), "--session-transcripts", "--guard-log")
    case("built-in scopes: transcripts under <home>/.claude/projects and the guard log",
         rc == 0 and f"directory {os.path.join(home, '.claude', 'projects')}: 1 files read" in out
         and f"directory {glog}: 1 files read" in out
         and "CLAUDE_CODE_MESSAGING_TOKEN: 1 files hold it: p1/s.jsonl" in out and not pieces_in(out))
    rc, out = run(dict(env, DEVOS_AUDIT_HOME=os.path.join(d, "nohome")), "--session-transcripts")
    case("built-in scope missing: ERROR, INCOMPLETE, exit 2", rc == 2 and out.rstrip().endswith("INCOMPLETE"))

    os.makedirs(os.path.join(d, "t2", "tools"))
    shutil.copy(TOOL, os.path.join(d, "t2", "tools", "credential_value_scan.py"))
    rc, out = run(env, "--dir", tdir, tool=Path(d, "t2", "tools", "credential_value_scan.py"))
    case("guard file missing: exit 2, error line only",
         rc == 2 and out.startswith("CREDENTIAL_VALUE_SCAN ERROR") and len(out.strip().splitlines()) == 1)

case("no bytecode cache in tools/", not (TOOL.parent / "__pycache__").exists() or not any(
    p.name.startswith("credential_value_scan") for p in (TOOL.parent / "__pycache__").iterdir()))
print("CREDENTIAL_VALUE_SCAN_TEST " + ("PASS" if all(RESULTS) else "FAIL"))
sys.exit(0 if all(RESULTS) else 1)
