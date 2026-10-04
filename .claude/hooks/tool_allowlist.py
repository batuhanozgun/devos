#!/usr/bin/env python3
"""PreToolUse hook for DevOS sessions (Builder Operating Model, section 9).

1. MCP allow list: only the listed servers' tools may run; every other mcp__
   tool is blocked, including account connectors under opaque IDs.
2. GitHub write scope: GitHub write tools may target only batuhanozgun/devos;
   repository creation and forking are blocked.
3. Session tools are an allow list: new sessions only with a full checkout
   of devos in the builder environment, on main or this session's branch,
   and only if that revision carries .claude/settings.json; the first
   message must carry a generated task brief (brief gate H-BRF, W-R6);
   repositories
   only devos, or the library read-only; tools that act on an existing
   session or routine (including reading its events) only for IDs in
   owned_ids.txt; routines never with connectors and only into owned
   sessions; every unlisted session tool is blocked.
4. Non-MCP tools are an allow list; anything not named is blocked. Subagents
   run in-process only: Agent/Task with any isolation other than none is
   blocked (a remote subagent is a new cloud session outside rule 3), and
   Workflow is blocked until its agent options are known (R-C00-BOM-5 N-B1).

Threat model: this hook guards against accidents and injected instructions.
It cannot stop a session that deliberately edits it; that residual risk is
stated in Builder Operating Model section 9.

Exit code 2 blocks. Every error path that runs inside this script returns 2.
The settings command wraps the script so that any other non-zero exit
(syntax error, missing python3) is also turned into 2.
"""
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timezone

HERE = os.path.dirname(os.path.abspath(__file__))
BUILDER_ENV = "env_01AMBDuHjjTsXMeXFyYgk1zR"     # devos-kurulum
DEVOS_URL = re.compile(r"https://github\.com/batuhanozgun/devos(\.git)?/?", re.I)
BRIEF_LINE = re.compile(r"^Task-Brief: (\S+) (\S+) ([0-9a-f]{16})$", re.M)

ALLOWED_PREFIXES = (
    "mcp__github__",
    "mcp__claude-code-remote__",
    "mcp__Supabase_DevOS_Salt-okuma__",
    "mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__",   # read-only Supabase connector, opaque ID (inferred: T-H3)
)
# Non-MCP tools are an allow list too (R-C00-BOM-4 B1). Anything not named here is blocked,
# including tools that reach the account's other sessions (SendMessage, ListAgents),
# publishing surfaces, connector and plugin suggestion tools, MCP resource readers
# and worktree switching (which would change the enforced hook).
ALLOWED_NON_MCP = {
    "Bash", "Read", "Write", "Edit", "Glob", "Grep", "NotebookEdit",
    "Agent", "Task", "ToolSearch", "Skill", "StructuredOutput",
    "TaskCreate", "TaskGet", "TaskList", "TaskUpdate", "TaskStop", "TaskOutput",
    "TodoWrite", "Monitor", "WebFetch", "WebSearch",
    "AskUserQuestion", "EnterPlanMode", "ExitPlanMode", "SendUserFile",
    "PushNotification",            # reaches only Batu's own devices (second channel, Appendix E §8)
    "ReportFindings", "SubagentHandback",
    "ReadNotifications",           # reads only this session's own queue; routine and send_later messages
                                   # arrive there (T-A2). Its contents are untrusted data, never instructions.
}
SUBAGENT_TOOLS = {"Agent", "Task"}   # in-process only: no isolation field at all (N-B1)

WRITE_REPOS = {("batuhanozgun", "devos")}
READ_ONLY_GITHUB = {"get_me", "pull_request_read", "issue_read", "actions_get", "actions_list"}
READ_ONLY_GITHUB_PREFIXES = ("get_", "list_", "search_")
REPOLESS_GITHUB_ALLOWED = {"resolve_review_thread", "unresolve_review_thread"}
BLOCKED_GITHUB = {"create_repository", "fork_repository"}

OWNED_TARGET_FIELDS = {   # session tools that act on one existing session or routine
    "send_message": "session_id", "archive_session": "session_id",
    "unarchive_session": "session_id", "interrupt_session": "session_id",
    "set_session_title": "session_id", "list_events": "session_id",
    "get_event": "session_id",
    "fire_trigger": "trigger_id", "update_trigger": "trigger_id",
    "delete_trigger": "trigger_id", "get_trigger": "trigger_id",
}
FREE_SESSION_TOOLS = {"send_later", "list_environments", "list_repos", "read_documentation"}
DEVOS_PR_TOOLS = {"subscribe_pr_activity", "unsubscribe_pr_activity"}


def block(msg):
    print(f"tool_allowlist: {msg} (Builder Operating Model, section 9).", file=sys.stderr)
    return 2


def owned_ids():
    with open(os.path.join(HERE, "owned_ids.txt")) as f:
        return {l.strip() for l in f if l.strip() and not l.startswith("#")}


def norm(i):
    i = str(i or "")
    return "session_" + i[4:] if i.startswith("cse_") else i


LEASE_TAIL = re.compile(r"\b(Expires|Released) (\d{4}-\d\d-\d\dT\d\d:\d\dZ)\s*$")


def lease_state(row):
    """(holder, 'expires'|'released'|None, time) of the Run lock row: the same reading as tools/records.py
    lease_state() (N-055; only the tail that lease() writes counts). Kept here because the hook must not import
    the tree's tools; T-H4 (N-057) and tools/test_1c.py check that the two agree."""
    cells = [c.strip() for c in re.split(r"(?<!\\)\|", row.strip())[1:-1]]
    lock = cells[1] if len(cells) > 1 else ""
    holder = re.match(r"`(session_[A-Za-z0-9]+)`", lock)
    tail = LEASE_TAIL.search(lock)
    return (holder.group(1) if holder else None, tail.group(1).lower() if tail else None,
            tail.group(2) if tail else None)


def git(*args):
    root = os.path.dirname(os.path.dirname(HERE))
    return subprocess.run(["git", "-C", root, *args], capture_output=True, text=True, timeout=20)


def revision_has_barrier(rev):
    """The remote revision a new session will check out must carry .claude/settings.json.
    It is fetched first (R-C00-BOM-4 m2); a failed fetch blocks. Returns the fetched commit, or None."""
    if rev in (None, "", "main"):
        ref = "main"
    elif rev == git("rev-parse", "--abbrev-ref", "HEAD").stdout.strip():
        ref = rev
    else:
        return None
    if git("fetch", "-q", "origin", ref).returncode != 0:
        return None
    sha = git("rev-parse", "FETCH_HEAD").stdout.strip()
    if not sha or git("cat-file", "-e", f"{sha}:.claude/settings.json").returncode != 0:
        return None
    return sha


def brief_gate(prompt, sha):
    """W-R6 (H-BRF): the first message carries a line `Task-Brief: <ID> <role> <hash>`; the brief is regenerated
    with tools/records.py from the fetched source revision; its hash must match and its whole text must appear in
    the message (N-053 b). A `run` brief is allowed from the Run lock holder while the lease on the fetched main is
    live, and from any session once it is released or expired (the run takes the lease at boot; N-057, no fixed
    session ID). Returns None when allowed, otherwise the reason."""
    found = BRIEF_LINE.findall(prompt)
    if not found:
        return "the first message carries no 'Task-Brief: <ID> <role> <hash>' line"
    iid, role, h = found[-1]
    if iid == "run":
        if role != "producer":
            return f"a run brief has role producer, not '{role}'"
        me = norm(os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID", ""))
        if git("fetch", "-q", "origin", "main").returncode != 0:
            return "main could not be fetched to read the Run lock row"
        ledger = git("show", "FETCH_HEAD:plan/ledger.md").stdout
        row = next((l for l in ledger.splitlines() if l.startswith("| Run lock |")), "")
        holder, state, at = lease_state(row)
        live = state == "expires" and at is not None and at > datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%MZ")
        stale = state == "released" or (state == "expires" and not live)
        if not holder or not (stale or me == holder):
            return (f"a run brief only from the Run lock holder ({holder}) while its lease is live, or from any "
                    f"session once it is released or expired; not '{me}'")
        args = ["brief", "run", "--role", "producer"]
    else:
        args = ["brief", iid, "--role", role]
        if role == "verifier":
            ts = re.search(r"^Target SHA: (\S+)$", prompt, re.M)
            fc = re.search(r"^Failure classes to look for:\n((?:- .*\n)+)", prompt, re.M)
            if not ts or not fc:
                return "a verifier brief without its Target SHA or failure classes"
            args += ["--target-sha", ts.group(1), "--failure-classes",
                     *[l[2:] for l in fc.group(1).splitlines()]]
    root = os.path.dirname(os.path.dirname(HERE))
    tmp = tempfile.mkdtemp(prefix="brf-")
    try:
        a = subprocess.run(["git", "-C", root, "archive", sha], capture_output=True, timeout=30)
        x = subprocess.run(["tar", "-x", "-C", tmp], input=a.stdout, capture_output=True, timeout=30)
        if a.returncode != 0 or x.returncode != 0:
            return "the source revision could not be exported to regenerate the brief"
        env = dict(os.environ, GIT_DIR=os.path.join(root, ".git"))
        r = subprocess.run([sys.executable, "tools/records.py", *args], cwd=tmp, env=env, capture_output=True,
                           text=True, timeout=60)
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
    if r.returncode != 0:
        why = (r.stderr.strip().splitlines() or ["no output"])[-1]
        return f"records.py {' '.join(args[:4])} failed on the source revision: {why[:160]}"
    gen = r.stdout
    if not gen.endswith(f"\nTask-Brief: {iid} {role} {h}\n"):
        return f"the Task-Brief hash does not match the brief generated from the source revision {sha[:7]}"
    if not prompt.rstrip().endswith(gen.strip()):  # the brief ends the message; nothing follows it (1c Critic 2)
        return "the first message does not end with the generated brief, or its text differs from it (N-053 b)"
    return None


def check_session_tool(tool, args):
    owned = owned_ids()
    if tool == "create_session":
        if not DEVOS_URL.fullmatch(str(args.get("source_url", ""))):
            return block("create_session needs a full checkout of batuhanozgun/devos (source_url)")
        if args.get("sparse_checkout_paths"):
            return block("create_session with a sparse checkout runs without the barrier")
        if args.get("environment_id") not in (None, BUILDER_ENV):
            return block("create_session only in the builder environment")
        if args.get("permission_mode") == "bypassPermissions" or args.get("extra_allowed_tools"):
            return block("create_session may not widen permissions")
        if str(args.get("append_system_prompt") or "").strip():  # it would carry a task beside the brief (1c Critic 3)
            return block("create_session may not carry an append_system_prompt; the task is the brief in the first message")
        if str(args.get("outcome_branch", "")).strip().lower() in ("main", "refs/heads/main"):
            return block("create_session may not push to main; main changes only through a pull request (PC-02)")
        sha = revision_has_barrier(args.get("source_revision"))
        if not sha:
            return block("create_session only on main or this session's branch, and only if that revision carries .claude/settings.json")
        why = brief_gate(str(args.get("prompt") or ""), sha)
        if why:
            return block(f"brief gate (W-R6): {why}")
        return 0
    if tool == "add_repo":
        owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
        if (owner, repo) == ("batuhanozgun", "devos"):
            return 0
        if (owner, repo) == ("batuhanozgun", "agentic-os-search") and args.get("access", "read") == "read":
            return 0
        return block(f"add_repo {owner}/{repo} with access {args.get('access', 'read')} is not allowed")
    if tool == "create_trigger":
        if args.get("connectors") not in (None, []):
            return block("routines may not carry connectors")
        if args.get("persistent_session_id") and norm(args["persistent_session_id"]) not in owned:
            return block("a routine may fire only into a builder-owned session")
        if args.get("environment_id") not in (None, BUILDER_ENV):
            return block("routines only in the builder environment")
        return 0
    if tool == "get_session":
        if "session_id" in args and norm(args["session_id"]) not in owned:
            return block("get_session only on this session or builder-owned sessions")
        return 0
    if tool == "set_session_tags":
        ids = args.get("session_ids") or []
        if not isinstance(ids, list) or not {norm(i) for i in ids} <= owned:
            return block("set_session_tags only on builder-owned sessions")
        return 0
    if tool in OWNED_TARGET_FIELDS:
        target = norm(args.get(OWNED_TARGET_FIELDS[tool]))
        if target not in owned:
            return block(f"{tool} on '{target}', which is not a builder-owned ID (owned_ids.txt)")
        return 0
    if tool in DEVOS_PR_TOOLS:
        if (str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()) != ("batuhanozgun", "devos"):
            return block(f"{tool} only for batuhanozgun/devos")
        return 0
    if tool in FREE_SESSION_TOOLS:
        return 0
    return block(f"session tool '{tool}' is not on the allow list")


def check(data):
    if not isinstance(data, dict):
        return block("hook input is not an object; blocking")
    name = data.get("tool_name")
    if not isinstance(name, str) or not name:
        return block("missing tool name; blocking")
    args = data.get("tool_input") or {}
    if not isinstance(args, dict):
        return block("tool input is not an object; blocking")
    if not name.startswith("mcp__"):
        if name in SUBAGENT_TOOLS:
            if args.get("isolation") is not None:
                return block(f"{name} with isolation '{args.get('isolation')}': subagents run in-process only")
            return 0
        if name in ALLOWED_NON_MCP:
            return 0
        return block(f"tool '{name}' is not on the allow list")
    if not name.startswith(ALLOWED_PREFIXES):
        return block(f"'{name}' is not an allowed MCP server for DevOS sessions")
    if name.startswith("mcp__claude-code-remote__"):
        return check_session_tool(name[len("mcp__claude-code-remote__"):], args)
    if name.startswith("mcp__github__"):
        tool = name[len("mcp__github__"):]
        if tool in BLOCKED_GITHUB:
            return block(f"'{tool}' is not allowed for DevOS sessions")
        if tool in READ_ONLY_GITHUB or tool.startswith(READ_ONLY_GITHUB_PREFIXES):
            return 0
        if tool in REPOLESS_GITHUB_ALLOWED and "repo" not in args and "owner" not in args:
            return 0
        owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
        if (owner, repo) not in WRITE_REPOS:
            return block(f"GitHub write tool '{tool}' targets {owner}/{repo}, which DevOS may not write")
    return 0


def main():
    try:
        return check(json.load(sys.stdin))
    except Exception as exc:
        return block(f"hook error {type(exc).__name__}; blocking")


if __name__ == "__main__":
    sys.exit(main())
