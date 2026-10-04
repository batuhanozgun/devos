#!/usr/bin/env python3
"""DevOS guard: the PreToolUse and PermissionRequest hook of every DevOS session (Builder Operating Model,
section 9; Batu's decision D-008; item W-C00-12.6).

Sessions run in Accept edits mode, without Claude Code's auto-mode classifier (D-008). This script is the
written rule file that decides every tool call instead. It allows the call, or it denies it with a reason
that states the rule, what was attempted, why the rule exists, where it is written and what to do instead.
It never asks. Every decision is appended to a per-session decision log (LOG_DIR), so that what was allowed
or denied, and why, can be audited afterwards; tools/guard_report.py prints a session's denials.

Rule families (the IDs are the keys of RULES):
  T  tools: non-MCP tools are an allow list; subagents run in-process only; Workflow only without an
     isolation option; AskUserQuestion and ExitPlanMode are passed to the user, who answers them by design.
  M  MCP: only the listed servers; GitHub writes only to batuhanozgun/devos and never onto main; no
     auto-merge; no approving reviews; a merge names the full head SHA and, for a class-high head, needs a
     covering review verdict (the merge gate, `tools/check_records.py gate`).
  S  session tools: owned IDs only; new sessions are full devos checkouts in the builder environment, on
     main or this session's branch, carrying .claude/settings.json, on claude-opus-5-5 in acceptEdits.
  F  files: no writes to this working tree's .claude/ (the guard itself), to any .git/ directory, to
     Claude Code's own configuration, or to credential files.
  B  shell: explicit bans (main, remote history, branch space, the live working tree, guarded directories,
     sending data out, credential-bearing command lines, credentials, critical paths, the sandbox); every
     other command is allowed.

Threat model (section 9): accidents and injected instructions, not a session that deliberately edits this
file. A deliberate bypass stays visible in git and is a stated residual risk (D-003). The shell analysis is
lexical: a command it cannot parse is denied, and a directory it cannot tell is treated as the live tree.

Exit: 0 with a JSON decision on stdout (nothing for a call passed to the user). An internal error on
PreToolUse exits 2, so the call is blocked; on PermissionRequest it prints a deny decision. The settings
wrapper maps any other non-zero exit to 2, so a guard that cannot run also blocks.
"""
import json
import os
import re
import shlex
import subprocess
import sys
from datetime import datetime, timezone

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))          # the live working tree: its .claude/ is this guard
HOME = os.path.expanduser("~")
LOG_DIR = os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard"
BUILDER_ENV = "env_01AMBDuHjjTsXMeXFyYgk1zR"           # devos-kurulum
MODEL = "claude-opus-5-5"                              # D-008
MODE = "acceptEdits"                                   # D-008
DEVOS_URL = re.compile(r"https://github\.com/batuhanozgun/devos(\.git)?/?", re.I)
DEVOS_REMOTE = re.compile(r"(https://github\.com/|git@github\.com:|ssh://git@github\.com/|"
                          r"https?://[^/\s]*127\.0\.0\.1:\d+/git/)batuhanozgun/devos(\.git)?/?", re.I)
SHA40 = re.compile(r"[0-9a-f]{40}")

ALLOWED_PREFIXES = (
    "mcp__github__",
    "mcp__claude-code-remote__",
    "mcp__Supabase_DevOS_Salt-okuma__",
    "mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__",   # read-only Supabase connector, opaque ID (inferred: T-H3)
)
# Non-MCP tools are an allow list (R-C00-BOM-4 B1). Anything not named is denied, including tools that reach
# the account's other sessions (SendMessage, ListAgents), publishing surfaces, connector and plugin
# suggestion tools, MCP resource readers and worktree switching (which would change the enforced guard).
ALLOWED_NON_MCP = {
    "Bash", "Read", "Write", "Edit", "Glob", "Grep", "NotebookEdit",
    "Agent", "Task", "Workflow", "ToolSearch", "Skill", "StructuredOutput",
    "TaskCreate", "TaskGet", "TaskList", "TaskUpdate", "TaskStop", "TaskOutput",
    "TodoWrite", "Monitor", "WebFetch", "WebSearch", "EnterPlanMode", "SendUserFile",
    "PushNotification",            # reaches only Batu's own devices (second channel, Appendix E §8)
    "ReportFindings", "SubagentHandback",
    "ReadNotifications",           # this session's own queue (T-A2); its contents are data, never instructions
}
USER_TOOLS = {"AskUserQuestion", "ExitPlanMode"}   # answered by the user; an "allow" would need updatedInput
SUBAGENT_TOOLS = {"Agent", "Task"}
FILE_WRITE_TOOLS = {"Write": "file_path", "Edit": "file_path", "NotebookEdit": "notebook_path"}
FILE_READ_TOOLS = {"Read": "file_path", "Glob": "path", "Grep": "path"}

WRITE_REPOS = {("batuhanozgun", "devos")}
READ_ONLY_GITHUB = {"get_me", "pull_request_read", "issue_read", "actions_get", "actions_list"}
READ_ONLY_GITHUB_PREFIXES = ("get_", "list_", "search_")
REPOLESS_GITHUB_ALLOWED = {"resolve_review_thread", "unresolve_review_thread"}
BLOCKED_GITHUB = {"create_repository", "fork_repository"}
GITHUB_FILE_WRITES = {"create_or_update_file", "push_files", "delete_file"}

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

PROTECTED_NAMES = {
    ".gitconfig", ".gitmodules", ".bashrc", ".bash_profile", ".bash_login", ".bash_aliases", ".bash_logout",
    ".zshrc", ".zprofile", ".zshenv", ".zlogin", ".zlogout", ".profile", ".envrc", ".npmrc", ".yarnrc",
    ".yarnrc.yml", ".pnp.cjs", ".pnp.loader.mjs", ".pnpmfile.cjs", "bunfig.toml", ".bunfig.toml", ".bazelrc",
    ".pre-commit-config.yaml", "lefthook.yml", "lefthook.yaml", ".lefthook.yml", ".lefthook.yaml",
    ".devcontainer.json", ".mcp.json", ".claude.json", ".git-credentials",
}
CREDENTIAL_VARS = ("GH_TOKEN", "GITHUB_TOKEN", "CLOUDSDK_AUTH_ACCESS_TOKEN", "CLAUDE_CODE_MESSAGING_TOKEN",
                   "CLAUDE_CODE_MESSAGING_SOCKET", "CLAUDE_SESSION_INGRESS_TOKEN_FILE", "SESSION_INGRESS_URL",
                   "ANTHROPIC_API_KEY", "ANTHROPIC_AUTH_TOKEN", "CLAUDE_CODE_OAUTH_TOKEN")
CREDENTIAL_EXPANSION = re.compile(r"\$\{?!?(" + "|".join(CREDENTIAL_VARS) + r")\b")
CREDENTIAL_PATHS = (".git-credentials", ".config/gh/hosts.yml", "/proc/self/environ")
ACCOUNT_CLIS = {"gh", "gcloud", "gsutil", "bq", "claude"}
NET_TOOLS = {"ssh", "scp", "sftp", "nc", "ncat", "netcat", "socat", "telnet", "ftp", "rsync"}
SHELLS = {"bash", "sh", "zsh", "dash"}
DEST_COMMANDS = {"cp", "install", "ln"}            # only the destination is written
WRITE_COMMANDS = {"mv", "rm", "rmdir", "touch", "truncate", "chmod", "chown", "mkdir", "tee", "unzip"}
IN_PLACE_COMMANDS = {"sed", "perl"}                # write only with -i
LIVE_BANNED_GIT = {"checkout", "switch", "reset", "rebase", "cherry-pick", "revert", "am", "apply", "stash",
                   "restore", "clean", "commit", "merge", "pull", "mv", "rm", "update-ref", "symbolic-ref",
                   "read-tree", "checkout-index", "filter-branch", "filter-repo", "replace", "notes"}

RULES = {  # id: (title, why the rule exists, where it is written, what to do instead)
    "G0": ("readable call", "The guard could not read or parse the call, so it cannot decide it safely; it "
           "fails closed.", "operating model section 9 (fail closed)",
           "Repeat the call in a well-formed way; for the shell, write the command so that its quotes balance."),
    "T1": ("non-MCP tool allow list", "Only the tools a DevOS session needs are allowed. A tool not named here, "
           "including tools that reach the account's other sessions, publishing surfaces, connector and plugin "
           "tools, MCP resource readers and worktree switching, is denied, so nothing new appears unguarded.",
           "operating model section 9, Non-MCP tools", "Use an allowed tool. A new tool is added only by a "
           "reviewed change to this file."),
    "T2": ("subagents in-process only", "A subagent with an isolation mode runs in another worktree or as a new "
           "cloud session, outside the session-tool rules.", "section 9; R-C00-BOM-5 N-B1",
           "Call Agent or Task without an isolation field."),
    "T3": ("workflows in-process only", "A workflow agent with an isolation option runs in another worktree or "
           "environment, outside this guard's view.", "section 9; D-008",
           "Write the workflow without any isolation option."),
    "M1": ("MCP server allow list", "Only the GitHub tools, the session tools and the read-only database "
           "connector are allowed. Account connectors (mail, calendar, files and others, some under opaque IDs) "
           "are never used by DevOS.", "CLAUDE.md; section 9; D-003",
           "Do the work without that server."),
    "M2": ("GitHub write scope", "GitHub writes may target only batuhanozgun/devos; repository creation and "
           "forking are blocked.", "section 9, GitHub writes", "Write only to batuhanozgun/devos."),
    "M3": ("main changes only through a merged pull request", "A file written straight onto main skips the pull "
           "request, its checks and its review.", "PC-02; section 3.2",
           "Commit to a claude/ branch and open a pull request."),
    "M4": ("no auto-merge", "Auto-merge merges later, without the merge gate's check at that moment.",
           "section 9 (D-008)", "Merge with merge_pull_request when the gate's conditions hold."),
    "M5": ("no approving reviews", "A GitHub approval is given in the account owner's name. The builder's "
           "independent review is a verdict file from a review session (section 5), never a GitHub approval.",
           "section 5; D-006; D-007", "Use a COMMENT review if a comment is needed."),
    "M6": ("merge exactly the reviewed head", "A merge names the full 40-character head SHA (expectedHeadSha), so "
           "that a head that moved after review is not merged, and uses the merge method, because squash and "
           "rebase create commits that no verdict names (section 2.3: the short-SHA failure of T-A2).",
           "section 3.2; section 9 (D-008)", "Pass expectedHeadSha with the full SHA and merge_method merge."),
    "M7": ("merge gate for class-high changes", "A change to rules, hooks, tools, governing documents or "
           "acceptance conditions (class high) merges only with an independent session verdict that covers its "
           "head. This written check replaces the classifier's 'merge without review' rule.",
           "section 5; PC-05; tools/check_records.py gate (W-R7, M-R16 b)",
           "Get the review verdict (plan/builder/REVIEW_PROMPT.md), merge the reviewer's recorder line, merge "
           "main into the branch, copy the verdict into the pull request, then merge."),
    "S1": ("session tools on owned IDs only", "Session tools reach every session and routine of the account; "
           "DevOS acts only on the ones it created (owned_ids.txt, filled by the recorder hook).",
           "section 9, Session tools; Owned-ID list", "Act only on sessions and routines this builder created."),
    "S2": ("new sessions carry the barrier", "A new session is guarded only if it checks out devos fully, in "
           "the builder environment, at a revision that carries .claude/settings.json, and never pushes to main.",
           "section 9, Session tools; PC-02", "Create the session on main, in the builder environment, with "
           "source_url https://github.com/batuhanozgun/devos and no sparse checkout."),
    "S3": ("Opus 5.5 in Accept edits for every new session", "Batu's standing rule: every session the builder "
           "opens runs on claude-opus-5-5 at ultracode effort, in Accept edits, where this guard decides every "
           "call. Routines that start a fresh session cannot set the model (BP-05).", "D-008",
           "Pass model claude-opus-5-5 and permission_mode acceptEdits; bind routines to an owned session."),
    "S4": ("routines", "A routine runs later without a person; it must carry no connectors and fire only into "
           "the builder's own sessions in the builder environment.", "section 9, Session tools",
           "Create the routine without connectors, bound to an owned session."),
    "S5": ("repositories", "Only devos may be attached, and the research library read-only.",
           "section 9, Session tools; CLAUDE.md", "Attach only devos, or the library with access read."),
    "F1": ("live guard files", "This working tree's .claude/ holds the guard itself, its settings and the "
           "owned-ID list; a change there takes effect at once, without review.",
           "section 9, Working-tree rule; PC-05", "Edit in a scratch clone outside this working tree, open a "
           "pull request, get its review verdict, merge, then run tools/sync_worktree.sh."),
    "F2": ("git internals", "Files under .git/ belong to git; editing them can rewrite history or plant git "
           "hooks that run on later commands.", "section 9", "Use git commands."),
    "F3": ("Claude Code's own configuration", "User settings, shell start-up files and the protected "
           "configuration files decide how sessions start and what they may do; a change there is a "
           "permission change.", "section 9; D-008", "None from a session: such a change is not made here."),
    "F4": ("credentials", "The session's credential files reach the account's other sessions and services.",
           "section 9 (R-C00-BOM-5 R-1)", "Use the session tools and the GitHub tools, which are scope-checked."),
    "B1": ("no push to main", "main changes only through a merged pull request.", "PC-02; section 3.2",
           "Push to a claude/ branch and open a pull request."),
    "B2": ("no remote history rewriting", "Force pushes, mirror and prune pushes and remote branch deletion "
           "destroy history that other sessions and the records rely on.", "section 9 (D-008); section 11",
           "Push new commits; leave an abandoned branch in place and record it (section 3.2)."),
    "B3": ("builder branch space", "The builder pushes only to claude/ branches of devos, named explicitly, so "
           "that every push is visible to the boot branch check and nothing reaches another repository.",
           "section 3.2; section 9", "Run git push <devos remote> <branch> with a claude/ branch, in a directory "
           "written literally."),
    "B4": ("the live working tree stays at main", "The guard and owned_ids.txt are read from this working tree; "
           "a checkout, reset, commit or similar here would swap the enforced rules or hide them.",
           "section 9, Working-tree rule", "Work in a scratch clone or worktree outside this working tree and "
           "use git -C <literal path>; to update this tree, run tools/sync_worktree.sh."),
    "B5": ("no shell writes into guarded directories", "The live .claude/ (the guard), the live .git/ and "
           "Claude Code's configuration (~/.claude) change only through a reviewed merge or not at all.",
           "section 9, Working-tree rule; D-008", "Change files in a scratch clone and merge them through a "
           "reviewed pull request."),
    "B6": ("no sending data out", "Uploads and raw network tools can carry data out of the container; once the "
           "classifier is gone (D-008), a hidden instruction in a read document is the main way this happens.",
           "section 9; D-008", "Read with curl or wget without upload options; write to GitHub with the GitHub "
           "tools."),
    "B7": ("no command lines that carry account credentials", "gh, gcloud, gsutil, bq and the claude command line "
           "act with the account's credentials outside the scope checks of this guard.",
           "section 9 (R-C00-BOM-5 R-1); D-003", "Use the GitHub tools and the session tools."),
    "B8": ("no credentials in the shell", "The session's tokens, token files and environment reach the "
           "account's other sessions and services; printing them would also put them in the transcript.",
           "section 9 (R-C00-BOM-5 R-1)", "Do not read credentials; the tools that need them hold them."),
    "B9": ("critical paths", "Removing the filesystem root, a top-level directory, the home directory or this "
           "working tree destroys the session's state.", "section 9; Claude Code critical paths",
           "Remove only specific paths inside a scratch directory."),
    "B10": ("the sandbox stays on", "Disabling the sandbox for a command removes a layer this guard relies on.",
            "section 9 (D-008)", "Run the command without dangerouslyDisableSandbox."),
}


class Bad(Exception):
    """A denial: Bad(rule, detail)."""

    def __init__(self, rule, detail):
        super().__init__(detail)
        self.rule, self.detail = rule, detail


# ---------------------------------------------------------------- helpers

def within(path, base):
    path, base = os.path.realpath(path), os.path.realpath(base)
    return path == base or path.startswith(base.rstrip(os.sep) + os.sep)


def live(path):
    """True when path is inside the live working tree and not in Claude's own worktrees there."""
    return within(path, ROOT) and not within(path, os.path.join(ROOT, ".claude", "worktrees"))


def owned_ids():
    with open(os.path.join(HERE, "owned_ids.txt")) as f:
        return {l.strip() for l in f if l.strip() and not l.startswith("#")}


def norm(i):
    i = str(i or "")
    return "session_" + i[4:] if i.startswith("cse_") else i


def git(*args, cwd=ROOT, timeout=20):
    return subprocess.run(["git", "-C", cwd, *args], capture_output=True, text=True, timeout=timeout)


def credential_values():
    """The paths of the session's token file and messaging socket, read from the environment at run time."""
    vals = []
    for k in ("CLAUDE_SESSION_INGRESS_TOKEN_FILE", "CLAUDE_CODE_MESSAGING_SOCKET"):
        v = os.environ.get(k)
        if v and len(v) > 4:
            vals.append(v)
    return vals


REDACT = [re.compile(p) for p in (r"gh[pousr]_[A-Za-z0-9]{20,}", r"github_pat_[A-Za-z0-9_]{20,}",
                                  r"sk-[A-Za-z0-9_\-]{20,}", r"(?i)bearer\s+[A-Za-z0-9._\-]{12,}",
                                  r"(?i)(token|secret|password|passwd|api[_-]?key)(\s*[=:]\s*)\S+")]


def redact(s):
    for r in REDACT:
        s = r.sub(lambda m: (m.group(1) + m.group(2) + "[redacted]") if m.re.groups == 2 else "[redacted]", s)
    for v in credential_values():
        s = s.replace(v, "[credential path]")
    return s


def summary(name, args):
    if name == "Bash":
        s = str(args.get("command", ""))
    elif name in FILE_WRITE_TOOLS or name in FILE_READ_TOOLS:
        s = str(args.get(FILE_WRITE_TOOLS.get(name) or FILE_READ_TOOLS.get(name)) or "")
    else:
        keep = {k: v for k, v in args.items() if k not in ("content", "files", "prompt", "message", "body",
                                                             "new_string", "old_string", "script")}
        s = json.dumps(keep, ensure_ascii=False, sort_keys=True)
    s = redact(s.replace("\n", " ⏎ "))
    return s if len(s) <= 300 else s[:297] + "..."


# ---------------------------------------------------------------- shell analysis

HEREDOC = re.compile(r"(?<!<)<<(?!<)-?\s*(['\"]?)([A-Za-z_][A-Za-z0-9_]*)\1")
PUNCT = set(";&|()<>")


def strip_heredocs(cmd):
    """Here-document bodies are data, not commands: drop them before the analysis."""
    out, lines, i = [], cmd.split("\n"), 0
    while i < len(lines):
        out.append(lines[i])
        delims = [d for _, d in HEREDOC.findall(lines[i])]
        i += 1
        for d in delims:
            while i < len(lines) and lines[i].strip() != d:
                i += 1
            i += 1
    return "\n".join(out)


def newlines_to_separators(t):
    """Unquoted newlines end a command; unquoted comments are dropped."""
    out, q, esc, comment, prev = [], None, False, False, " "
    for ch in t:
        if comment:
            if ch == "\n":
                comment = False
                out.append(" ; ")
            prev = ch
            continue
        if esc:
            out.append(ch)
            esc = False
        elif ch == "\\" and q != "'":
            out.append(ch)
            esc = True
        elif q:
            q = None if ch == q else q
            out.append(ch)
        elif ch in "'\"":
            q = ch
            out.append(ch)
        elif ch == "#" and (prev.isspace() or prev in ";&|()"):
            comment = True
        else:
            out.append(" ; " if ch == "\n" else ch)
        prev = ch
    return "".join(out)


def tokens(text):
    text = newlines_to_separators(strip_heredocs(text).replace("\\\n", " "))
    lex = shlex.shlex(text, posix=True, punctuation_chars=";&|()<>")
    lex.whitespace_split = True
    lex.commenters = ""
    out = []
    for tok in lex:
        if tok and set(tok) <= PUNCT:   # split grouped punctuation such as ");" or "&&("
            run = ""
            for ch in tok:
                if ch in "()":
                    if run:
                        out.append(run)
                        run = ""
                    out.append(ch)
                else:
                    run += ch
            if run:
                out.append(run)
        else:
            out.append(tok)
    return out


SEPARATORS = {";", "&&", "||", "|", "&", "|&", ";;", ";&", ";;&"}
REDIRECT_OUT = {">", ">>", ">|", "&>", "&>>"}
REDIRECT_OTHER = {"<", "<<", "<<<", "<>", ">&", "<&", "<<-"}


def simple_commands(toks):
    cmds, cur = [], []
    for t in toks:
        if t in SEPARATORS or t in ("(", ")"):
            if cur:
                cmds.append(cur)
                cur = []
            if t in ("(", ")"):
                cmds.append([t])
        else:
            cur.append(t)
    if cur:
        cmds.append(cur)
    return cmds


def resolve_dir(d, arg):
    """The directory a cd moves to; None when it cannot be told from the text."""
    if d is None or arg is None:
        return None
    if any(c in arg for c in "$`*?") or arg == "-":
        return None
    if arg == "~" or arg.startswith("~/"):
        arg = HOME + arg[1:]
    elif arg.startswith("~"):
        return None
    return os.path.normpath(os.path.join(d, arg))


def target_path(d, arg):
    if any(c in arg for c in "$`"):
        return None
    if arg == "~" or arg.startswith("~/"):
        return HOME + arg[1:]
    if os.path.isabs(arg):
        return arg
    return None if d is None else os.path.join(d, arg)


def guarded_zone(p):
    if within(p, os.path.join(ROOT, ".claude")) and not within(p, os.path.join(ROOT, ".claude", "worktrees")):
        return "the live guard files (.claude/ of this working tree)"
    if within(p, os.path.join(ROOT, ".git")):
        return "the live repository's .git/"
    if within(p, os.path.join(HOME, ".claude")):
        return "Claude Code's own configuration (~/.claude)"
    if os.path.basename(p) in PROTECTED_NAMES:
        return f"the protected configuration file {os.path.basename(p)}"
    return None


def critical(p):
    if p.endswith("/*"):           # a glob directly under a directory counts as that directory
        p = p[:-2]
    rp = os.path.realpath(p.rstrip("/") or "/")
    if rp in ("/", os.path.realpath(HOME)) or rp.count("/") == 1:
        return True
    root = os.path.realpath(ROOT)
    return root == rp or root.startswith(rp.rstrip("/") + "/")


def strip_wrappers(a):
    """Drop leading variable assignments and wrapper commands; return (argv, bare_env)."""
    while a:
        b = os.path.basename(a[0])
        if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*=.*", a[0]):
            a = a[1:]
        elif b == "env":
            a = a[1:]
            while a and (a[0].startswith("-") or re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*=.*", a[0])):
                a = a[2:] if a[0] in ("-u", "--unset", "-C", "--chdir", "-S", "--split-string") else a[1:]
            if not a:
                return [], True
        elif b in ("sudo", "command", "exec", "nohup", "time", "builtin", "stdbuf", "ionice", "unbuffer"):
            a = a[1:]
            while a and a[0].startswith("-"):
                a = a[2:] if a[0] in ("-u", "-g", "-o", "-i", "-e", "-c", "-n") and b in ("sudo", "stdbuf",
                                                                                      "ionice") else a[1:]
        elif b == "timeout":
            a = a[1:]
            while a and a[0].startswith("-"):
                a = a[2:] if a[0] in ("-s", "--signal", "-k", "--kill-after") else a[1:]
            a = a[1:]                       # the duration
        elif b == "nice":
            a = a[1:]
            if a and a[0] in ("-n", "--adjustment"):
                a = a[2:]
            elif a and re.fullmatch(r"-n?-?\d+", a[0]):
                a = a[1:]
        elif b == "xargs":
            a = a[1:]
            while a and a[0].startswith("-"):
                a = a[2:] if a[0] in ("-I", "-n", "-P", "-L", "-d", "-E", "-s", "-a") else a[1:]
        else:
            break
    return a, False


def shell_checks(command, cwd, depth=0):
    """Raise Bad for the first ban the command breaks."""
    for v in credential_values():
        if v in command:
            raise Bad("B8", "the command names the session's token file or messaging socket")
    m = CREDENTIAL_EXPANSION.search(command)
    if m:
        raise Bad("B8", f"the command expands the credential variable {m.group(1)}")
    if any(p in command for p in CREDENTIAL_PATHS) or re.search(r"/proc/[^/\s]+/environ", command):
        raise Bad("B8", "the command reads a credential store or a process environment")
    try:
        toks = tokens(command)
    except ValueError as e:
        raise Bad("G0", f"the shell command could not be parsed ({e})")
    d, stack = cwd, []
    for argv in simple_commands(toks):
        if argv == ["("]:
            stack.append(d)
            continue
        if argv == [")"]:
            d = stack.pop() if stack else d
            continue
        args, outs, i = [], [], 0
        while i < len(argv):
            t = argv[i]
            if t in REDIRECT_OUT:
                if i + 1 < len(argv):
                    outs.append(argv[i + 1])
                i += 2
            elif t in REDIRECT_OTHER:
                i += 2
            else:
                args.append(t)
                i += 1
        for o in outs:
            p = target_path(d, o)
            z = p and guarded_zone(p)
            if z:
                raise Bad("B5", f"a redirection writes into {z} ({o})")
        args, bare_env = strip_wrappers(args)
        if bare_env:
            raise Bad("B8", "env without a command prints the whole environment, including credentials")
        if not args:
            continue
        prog = os.path.basename(args[0])
        if prog in ("cd", "pushd"):
            d = resolve_dir(d, args[1] if len(args) > 1 else "~")
            continue
        if prog == "popd":
            d = None
            continue
        if prog in SHELLS and "-c" in args[1:]:
            i = args.index("-c", 1)
            if i + 1 < len(args) and depth < 3:
                shell_checks(args[i + 1], d, depth + 1)
            continue
        if prog == "eval" and depth < 3:
            shell_checks(" ".join(args[1:]), d, depth + 1)
            continue
        command_checks(prog, args, d)


def command_checks(prog, args, d):
    if prog in ACCOUNT_CLIS or any("@anthropic-ai/claude-code" in a for a in args):
        raise Bad("B7", f"'{prog}' acts with the account's credentials")
    if prog == "printenv":
        raise Bad("B8", "printenv prints the environment, including credentials")
    if prog in NET_TOOLS:
        raise Bad("B6", f"'{prog}' opens a raw or remote connection")
    if prog == "curl":
        for a in args[1:]:
            if a.startswith("--data") or a in ("--form", "--form-string", "--upload-file", "--json") or \
                    a.startswith(("--form=", "--json=", "--upload-file=")):
                raise Bad("B6", f"curl {a} sends data")
            if re.fullmatch(r"-[A-Za-z]+", a) and set(a[1:]) & set("dFT"):
                raise Bad("B6", f"curl {a} sends data")
            if re.fullmatch(r"(-X|--request=?)\s*(POST|PUT|PATCH|DELETE)", a, re.I):
                raise Bad("B6", f"curl {a} sends a writing request")
        for i, a in enumerate(args[1:-1], 1):
            if a in ("-X", "--request") and args[i + 1].upper() in ("POST", "PUT", "PATCH", "DELETE"):
                raise Bad("B6", f"curl {a} {args[i + 1]} sends a writing request")
    if prog == "wget":
        for a in args[1:]:
            if a.startswith(("--post-data", "--post-file", "--method", "--body-data", "--body-file")):
                raise Bad("B6", f"wget {a} sends data")
    if prog in ("rm", "rmdir"):
        for a in args[1:]:
            if a.startswith("-") and a != "-":
                continue
            p = target_path(d, a)
            if p and critical(p):
                raise Bad("B9", f"{prog} targets the critical path {a}")
    written = []
    plain = [a for a in args[1:] if not a.startswith("-")]
    if prog in DEST_COMMANDS:
        tdir = [args[i + 1] for i, a in enumerate(args[:-1]) if a in ("-t", "--target-directory")]
        tdir += [a.split("=", 1)[1] for a in args if a.startswith("--target-directory=")]
        written = tdir or plain[-1:]
    elif prog in WRITE_COMMANDS:
        written = plain
    elif prog in IN_PLACE_COMMANDS and any(a.startswith(("-i", "--in-place")) for a in args[1:]):
        written = plain
    elif prog == "dd":
        written = [a.split("=", 1)[1] for a in args[1:] if a.startswith("of=")]
    for a in written:
        p = target_path(d, a)
        z = p and guarded_zone(p)
        if z:
            raise Bad("B5", f"{prog} writes into {z} ({a})")
    if prog == "git":
        git_checks(args, d)


def git_checks(args, d):
    e, i = d, 1
    while i < len(args):
        a = args[i]
        if a == "-C" and i + 1 < len(args):
            e = resolve_dir(e, args[i + 1])
            i += 2
        elif a == "-c" and i + 1 < len(args):
            i += 2
        elif a in ("--git-dir", "--work-tree", "--namespace") and i + 1 < len(args):
            if a == "--work-tree":
                e = resolve_dir(e, args[i + 1])
            elif a == "--git-dir":
                g = resolve_dir(e, args[i + 1])
                e = os.path.dirname(g) if g and g.endswith(".git") else None
            i += 2
        elif a.startswith("--work-tree="):
            e = resolve_dir(e, a.split("=", 1)[1])
            i += 1
        elif a.startswith("--git-dir="):
            g = resolve_dir(e, a.split("=", 1)[1])
            e = os.path.dirname(g) if g and g.endswith(".git") else None
            i += 1
        elif a.startswith("-"):
            i += 1
        else:
            break
    if i >= len(args):
        return
    sub, rest = args[i], args[i + 1:]
    where = "an unknown directory (written with a variable or not literally)" if e is None else e
    if sub == "credential":
        raise Bad("B8", "git credential reads or writes stored credentials")
    if sub == "push":
        push_checks(rest, e)
    if sub == "fetch" and "--update-head-ok" in rest:
        raise Bad("B4", "git fetch --update-head-ok can move the checked-out branch")
    in_live = e is None or live(e)
    if not in_live:
        return
    if sub in ("merge", "pull"):
        plain = [x for x in rest if x != "--ff-only"]
        if "--ff-only" in rest and plain == (["origin/main"] if sub == "merge" else ["origin", "main"]):
            return
        raise Bad("B4", f"git {sub} in {where}; only a fast-forward to origin/main is allowed there")
    if sub == "stash" and rest[:1] in (["list"], ["show"]):
        return
    if sub in LIVE_BANNED_GIT:
        raise Bad("B4", f"git {sub} in {where}")
    if sub == "branch" and any(x in ("-f", "--force", "-D", "-d", "--delete", "-m", "-M", "--move", "-c", "-C",
                                     "--copy") for x in rest):
        raise Bad("B4", f"git branch {' '.join(rest)[:60]} in {where}")
    if sub == "remote" and rest[:1] and rest[0] in ("add", "set-url", "remove", "rm", "rename", "set-head",
                                                    "set-branches"):
        raise Bad("B4", f"git remote {rest[0]} in {where} would change what this tree fetches")


def push_checks(rest, e):
    flags, pos, i = [], [], 0
    while i < len(rest):
        a = rest[i]
        if a in ("-o", "--push-option", "--repo", "--receive-pack", "--exec"):
            flags.append(a)
            if a == "--repo" and i + 1 < len(rest):
                pos.insert(0, rest[i + 1])
            i += 2
        elif a.startswith("--"):
            flags.append(a)
            if a.startswith("--repo="):
                pos.insert(0, a.split("=", 1)[1])
            i += 1
        elif a.startswith("-") and len(a) > 1:
            flags.append(a)
            i += 1
        else:
            pos.append(a)
            i += 1
    for f in flags:
        name = f.split("=", 1)[0]
        if name in ("--force", "--force-with-lease", "--force-if-includes", "--mirror", "--prune", "--delete",
                    "--all", "--branches") or (re.fullmatch(r"-[A-Za-z]+", f) and set(f[1:]) & set("fd")):
            raise Bad("B2", f"git push {f}")
        if name in ("--receive-pack", "--exec"):
            raise Bad("B3", f"git push {f} runs another program on the remote")
    if not pos:
        raise Bad("B3", "git push names no remote and no branch")
    remote, refspecs = pos[0], pos[1:]
    if e is None:
        raise Bad("B3", "git push from a directory the guard cannot tell, so its remote cannot be checked")
    if "://" in remote or remote.startswith("git@"):
        url = remote
    else:
        r = git("remote", "get-url", remote, cwd=e)
        url = r.stdout.strip() if r.returncode == 0 else ""
    if not DEVOS_REMOTE.fullmatch(url):
        raise Bad("B3", f"git push to remote '{remote}' ({url or 'unknown URL'}), which is not batuhanozgun/devos")
    if not refspecs:
        raise Bad("B3", "git push names no branch")
    for s in refspecs:
        if s.startswith("+"):
            raise Bad("B2", f"git push {s} forces the update")
        src, dst = s.split(":", 1) if ":" in s else (s, s)
        if src == "" or s.startswith(":"):
            raise Bad("B2", f"git push {s} deletes a remote branch")
        if dst in ("HEAD", "@"):
            r = git("rev-parse", "--abbrev-ref", "HEAD", cwd=e)
            dst = r.stdout.strip() if r.returncode == 0 else ""
        dst = dst[len("refs/heads/"):] if dst.startswith("refs/heads/") else dst
        if dst in ("main", "master"):
            raise Bad("B1", f"git push {s} updates {dst}")
        if not dst.startswith("claude/") or dst.startswith("refs/"):
            raise Bad("B3", f"git push {s} updates '{dst or 'a detached HEAD'}', which is not a claude/ branch")


# ---------------------------------------------------------------- tool rules

def file_checks(name, args):
    key = FILE_WRITE_TOOLS.get(name) or FILE_READ_TOOLS.get(name)
    p = str(args.get(key) or "")
    if not p:
        return ("T1", f"{name} without a path stays in the working directory")
    p = os.path.join(ROOT, p) if not os.path.isabs(p) else p
    for v in credential_values():
        if within(p, v):
            raise Bad("F4", f"{name} on the session's token file or messaging socket")
    if any(x in p for x in CREDENTIAL_PATHS):
        raise Bad("F4", f"{name} on a credential store ({p})")
    if name in FILE_READ_TOOLS:
        return ("T1", f"{name} is a read")
    if within(p, os.path.join(ROOT, ".claude")) and not within(p, os.path.join(ROOT, ".claude", "worktrees")):
        raise Bad("F1", f"{name} {p}")
    if ".git" in os.path.realpath(p).split(os.sep):
        raise Bad("F2", f"{name} {p}")
    if within(p, os.path.join(HOME, ".claude")):
        raise Bad("F3", f"{name} {p}")
    if os.path.basename(p) in PROTECTED_NAMES:
        raise Bad("F3", f"{name} {p} (protected configuration file)")
    return ("T1", f"{name} outside the guarded paths")


def merge_checks(args):
    sha = str(args.get("expectedHeadSha") or "").strip().lower()
    if not SHA40.fullmatch(sha):
        raise Bad("M6", f"merge_pull_request without the full 40-character expectedHeadSha (got '{sha or 'none'}')")
    if str(args.get("merge_method") or "merge") != "merge":
        raise Bad("M6", f"merge_pull_request with merge_method {args.get('merge_method')}")
    pr = args.get("pullNumber")
    if not isinstance(pr, (int, float)) or int(pr) != pr or pr <= 0:
        raise Bad("M6", "merge_pull_request without a pull request number")
    tool = os.path.join(ROOT, "tools", "check_records.py")
    try:
        r = subprocess.run([sys.executable, tool, "gate", "--pr", str(int(pr)), "--head", sha], cwd=ROOT,
                           capture_output=True, text=True, timeout=300)
    except subprocess.TimeoutExpired:
        raise Bad("M7", "the merge gate did not finish within 300 seconds; failing closed")
    out = (r.stdout + r.stderr).strip()
    if r.returncode != 0:
        raise Bad("M7", "the merge gate said:\n" + out[-1500:])
    return ("M7", out.splitlines()[-1] if out else "gate passed")


def session_checks(tool, args):
    owned = owned_ids()
    if tool == "create_session":
        if not DEVOS_URL.fullmatch(str(args.get("source_url", ""))):
            raise Bad("S2", "create_session needs a full checkout of batuhanozgun/devos (source_url)")
        if args.get("sparse_checkout_paths"):
            raise Bad("S2", "create_session with a sparse checkout runs without the barrier")
        if args.get("environment_id") not in (None, BUILDER_ENV):
            raise Bad("S2", "create_session only in the builder environment")
        if args.get("extra_allowed_tools"):
            raise Bad("S2", "create_session may not widen permissions (extra_allowed_tools)")
        if str(args.get("outcome_branch", "")).strip().lower() in ("main", "refs/heads/main"):
            raise Bad("S2", "create_session may not push to main (outcome_branch)")
        if args.get("model") != MODEL:
            raise Bad("S3", f"create_session with model '{args.get('model')}', not {MODEL}")
        if args.get("permission_mode") != MODE:
            raise Bad("S3", f"create_session with permission_mode '{args.get('permission_mode')}', not {MODE}")
        if not revision_has_barrier(args.get("source_revision")):
            raise Bad("S2", "create_session only on main or this session's branch, and only if that revision "
                            "carries .claude/settings.json")
        return ("S2", "a guarded devos session on Opus 5.5 in Accept edits")
    if tool == "add_repo":
        owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
        if (owner, repo) == ("batuhanozgun", "devos"):
            return ("S5", "devos")
        if (owner, repo) == ("batuhanozgun", "agentic-os-search") and args.get("access", "read") == "read":
            return ("S5", "the library, read-only")
        raise Bad("S5", f"add_repo {owner}/{repo} with access {args.get('access', 'read')}")
    if tool == "create_trigger":
        if args.get("connectors") not in (None, []):
            raise Bad("S4", "a routine with connectors")
        if args.get("create_new_session_on_fire"):
            raise Bad("S3", "a routine that starts a fresh session cannot set the model (BP-05)")
        if args.get("persistent_session_id") and norm(args["persistent_session_id"]) not in owned:
            raise Bad("S4", "a routine may fire only into a builder-owned session")
        if args.get("environment_id") not in (None, BUILDER_ENV):
            raise Bad("S4", "routines only in the builder environment")
        return ("S4", "a routine without connectors, into an owned session")
    if tool == "update_trigger" and "model" in args and args.get("model") != MODEL:
        raise Bad("S3", f"update_trigger to model '{args.get('model')}'")
    if tool == "get_session":
        if "session_id" in args and norm(args["session_id"]) not in owned:
            raise Bad("S1", "get_session only on this session or builder-owned sessions")
        return ("S1", "get_session on this or an owned session")
    if tool == "set_session_tags":
        ids = args.get("session_ids") or []
        if not isinstance(ids, list) or not {norm(i) for i in ids} <= owned:
            raise Bad("S1", "set_session_tags only on builder-owned sessions")
        return ("S1", "owned sessions")
    if tool in OWNED_TARGET_FIELDS:
        target = norm(args.get(OWNED_TARGET_FIELDS[tool]))
        if target not in owned:
            raise Bad("S1", f"{tool} on '{target}', which is not a builder-owned ID (owned_ids.txt)")
        return ("S1", f"{tool} on an owned ID")
    if tool in DEVOS_PR_TOOLS:
        if (str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()) != ("batuhanozgun", "devos"):
            raise Bad("S1", f"{tool} only for batuhanozgun/devos")
        return ("S1", "a devos pull request")
    if tool in FREE_SESSION_TOOLS:
        return ("S1", f"{tool} acts on no other session")
    raise Bad("S1", f"session tool '{tool}' is not on the allow list")


def revision_has_barrier(rev):
    """The remote revision a new session will check out must carry .claude/settings.json.
    It is fetched first (R-C00-BOM-4 m2); a failed fetch blocks."""
    if rev in (None, "", "main"):
        ref = "main"
    elif rev == git("rev-parse", "--abbrev-ref", "HEAD").stdout.strip():
        ref = rev
    else:
        return False
    if git("fetch", "-q", "origin", ref).returncode != 0:
        return False
    return git("cat-file", "-e", "FETCH_HEAD:.claude/settings.json").returncode == 0


def github_checks(tool, args):
    if tool in BLOCKED_GITHUB:
        raise Bad("M2", f"'{tool}' is not allowed for DevOS sessions")
    if tool in READ_ONLY_GITHUB or tool.startswith(READ_ONLY_GITHUB_PREFIXES):
        return ("M2", "a GitHub read")
    if tool in REPOLESS_GITHUB_ALLOWED and "repo" not in args and "owner" not in args:
        return ("M2", "a review-thread tool without a repository field")
    owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
    if (owner, repo) not in WRITE_REPOS:
        raise Bad("M2", f"GitHub write tool '{tool}' targets {owner}/{repo}, which DevOS may not write")
    if tool in GITHUB_FILE_WRITES:
        b = str(args.get("branch") or "").strip()
        b = b[len("refs/heads/"):] if b.startswith("refs/heads/") else b
        if b in ("", "main", "master"):
            raise Bad("M3", f"{tool} onto '{b or 'the default branch'}'")
    if tool == "enable_pr_auto_merge":
        raise Bad("M4", "enable_pr_auto_merge")
    if tool == "pull_request_review_write" and str(args.get("event") or "").upper() == "APPROVE":
        raise Bad("M5", "pull_request_review_write with event APPROVE")
    if tool == "merge_pull_request":
        return merge_checks(args)
    return ("M2", "a write to batuhanozgun/devos")


def decide(data):
    """(decision, rule, detail): decision is allow, deny or pass (left to the user)."""
    if not isinstance(data, dict):
        return "deny", "G0", "the hook input is not an object"
    name = data.get("tool_name")
    if not isinstance(name, str) or not name:
        return "deny", "G0", "the hook input names no tool"
    args = data.get("tool_input") or {}
    if not isinstance(args, dict):
        return "deny", "G0", "the tool input is not an object"
    cwd = data.get("cwd") if isinstance(data.get("cwd"), str) and os.path.isabs(data.get("cwd") or "") else ROOT
    try:
        if name.startswith("mcp__"):
            if not name.startswith(ALLOWED_PREFIXES):
                raise Bad("M1", f"'{name}' is not an allowed MCP server for DevOS sessions")
            if name.startswith("mcp__claude-code-remote__"):
                rule, why = session_checks(name[len("mcp__claude-code-remote__"):], args)
            elif name.startswith("mcp__github__"):
                rule, why = github_checks(name[len("mcp__github__"):], args)
            else:
                rule, why = "M1", "the read-only database connector"
            return "allow", rule, why
        if name in USER_TOOLS:
            return "pass", "T1", f"{name} is answered by the user"
        if name not in ALLOWED_NON_MCP:
            raise Bad("T1", f"tool '{name}' is not on the allow list")
        if name in SUBAGENT_TOOLS:
            if args.get("isolation") is not None:
                raise Bad("T2", f"{name} with isolation '{args.get('isolation')}'")
            return "allow", "T2", "an in-process subagent"
        if name == "Workflow":
            text = str(args.get("script") or "")
            sp = args.get("scriptPath")
            if sp and os.path.isfile(str(sp)):
                with open(str(sp), errors="replace") as f:
                    text += f.read()
            if re.search(r"\bisolation\b", text):
                raise Bad("T3", "the workflow script sets an isolation option")
            return "allow", "T3", "an in-process workflow"
        if name == "Bash":
            if args.get("dangerouslyDisableSandbox"):
                raise Bad("B10", "dangerouslyDisableSandbox is set")
            shell_checks(str(args.get("command", "")), cwd)
            return "allow", "B0", "no shell ban matched"
        if name in FILE_WRITE_TOOLS or name in FILE_READ_TOOLS:
            rule, why = file_checks(name, args)
            return "allow", rule, why
        return "allow", "T1", f"{name} is on the allow list"
    except Bad as b:
        return "deny", b.rule, b.detail


# ---------------------------------------------------------------- output and log

def log_decision(data, decision, rule, detail, text):
    try:
        os.makedirs(LOG_DIR, exist_ok=True)
        remote = norm(os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID") or "")   # the cloud session's ID
        sid = re.sub(r"[^A-Za-z0-9_-]", "_", remote or str(data.get("session_id") or "unknown"))[:80]
        path = os.path.join(LOG_DIR, f"{sid}.jsonl")
        n = 1
        if os.path.exists(path):
            with open(path, "rb") as f:
                n = f.read().count(b"\n") + 1
        rec = {"n": n, "time": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
               "event": data.get("hook_event_name"), "session": remote or data.get("session_id"),
               "local_session": data.get("session_id"),
               "tool_use_id": data.get("tool_use_id"), "agent_id": data.get("agent_id"),
               "mode": data.get("permission_mode"), "cwd": data.get("cwd"),
               "tool": data.get("tool_name"), "decision": decision, "rule": rule,
               "summary": summary(str(data.get("tool_name")), data.get("tool_input") or {}),
               "detail": redact(detail), "reason": text if decision == "deny" else ""}
        with open(path, "a") as f:
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        return f"#{n} in {path}"
    except Exception as exc:   # the log never decides; a failed write is reported in the reason
        return f"(not logged: {type(exc).__name__})"


def deny_text(data, rule, detail):
    title, why, where, todo = RULES.get(rule, RULES["G0"])
    tool = str(data.get("tool_name"))
    return (f"DevOS guard: DENIED by rule {rule} ({title}).\n"
            f"What was attempted: {tool}: {summary(tool, data.get('tool_input') or {})}\n"
            f"What matched: {redact(detail)}\n"
            f"Why this rule exists: {why}\n"
            f"Where it is written: {where}; the rule file is .claude/hooks/tool_allowlist.py.\n"
            f"What to do instead: {todo}\n"
            "This is the repository's written rule, not a classifier verdict. It changes only through a reviewed "
            "pull request (operating model section 5, PC-05). Do not pursue the denied effect through another "
            "tool, wording or session (section 11); record the denial in your log entry "
            "(tools/guard_report.py).")


def main():
    data, event = {}, "PreToolUse"
    try:
        data = json.load(sys.stdin)
        if isinstance(data, dict) and data.get("hook_event_name") == "PermissionRequest":
            event = "PermissionRequest"
        decision, rule, detail = decide(data)
    except Exception as exc:
        decision, rule, detail = "deny", "G0", f"guard error {type(exc).__name__}: {exc}"
    ctx = data if isinstance(data, dict) else {}
    text = deny_text(ctx, rule, detail) if decision == "deny" else f"allowed by rule {rule}: {detail}"
    where = log_decision(ctx, decision, rule, detail, text)
    if decision == "pass":
        return 0
    if decision == "deny":
        text += f"\nDecision log: {where}."
    if event == "PermissionRequest":
        d = {"behavior": "allow"} if decision == "allow" else {"behavior": "deny", "message": text}
        print(json.dumps({"hookSpecificOutput": {"hookEventName": "PermissionRequest", "decision": d}}))
    else:
        print(json.dumps({"hookSpecificOutput": {"hookEventName": "PreToolUse", "permissionDecision": decision,
                                                 "permissionDecisionReason": text}}))
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as exc:  # fail closed: on PreToolUse exit 2 blocks the call
        print(f"tool_allowlist: guard error {type(exc).__name__}; blocking (operating model section 9).",
              file=sys.stderr)
        sys.exit(2)
