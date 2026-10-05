#!/usr/bin/env python3
"""DevOS guard: the PreToolUse and PermissionRequest hook of every DevOS session (described in
plan/Installation_Working_Order.md; Batu's decisions D-008 and D-010).

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
     covering checker verdict (the merge gate, `tools/merge_gate.py`).
  S  session tools: owned IDs only; new sessions are full devos checkouts in the builder environment, on
     main or this session's branch, carrying .claude/settings.json, on claude-opus-5-5 in acceptEdits.
  F  files: no writes to this working tree's .claude/ (the guard itself), to any .git/ directory, to
     Claude Code's own configuration, to credential files, or to the leak check's fingerprint store.
  B  shell: explicit bans (main, remote history, branch space, the live working tree, guarded directories,
     sending data out, credential-bearing command lines, credentials, critical paths, the sandbox); every
     other command is allowed.
  L  leak check (W-C00-14; plan 0.5 item 3, K-9 item 5, 6.7): a push to devos (every commit it would publish)
     and every string field of a GitHub write to devos are compared with fingerprints of the private research
     library and with the service names of tools/check_service_names.sh; a push stands alone in its Bash call;
     a clone of the library may exist in one place only.

Threat model (plan/Installation_Working_Order.md): accidents and injected instructions, not a session that
deliberately edits this file. A deliberate bypass stays visible in git and is a stated residual risk (D-003).
The shell analysis is lexical: a command it cannot parse is denied, and a directory it cannot tell is treated
as the live tree.

Exit: 0 with a JSON decision on stdout (nothing for a call passed to the user). An internal error on
PreToolUse exits 2, so the call is blocked; on PermissionRequest it prints a deny decision. The settings
wrapper maps any other non-zero exit to 2, so a guard that cannot run also blocks.
"""
import bisect
import fcntl
import fnmatch
import hashlib
import json
import mmap
import os
import re
import shlex
import subprocess
import sys
import unicodedata
from datetime import datetime, timezone
from functools import lru_cache

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))          # the live working tree: its .claude/ is this guard
HOME = os.path.expanduser("~")
LOG_DIR = os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard"
LOG_BASENAME = os.path.basename(LOG_DIR.rstrip("/")) or "devos-guard"   # for literal_guarded (R-D008-12 m-1)
BUILDER_ENV = "env_01AMBDuHjjTsXMeXFyYgk1zR"           # devos-kurulum
MODEL = "claude-opus-5-5"                              # D-008
MODE = "acceptEdits"                                   # D-008
DEVOS_URL = re.compile(r"https://github\.com/batuhanozgun/devos(\.git)?/?", re.I)
DEVOS_REMOTE = re.compile(r"(https://github\.com/|git@github\.com:|ssh://git@github\.com/|"
                          r"https?://[^/\s]*127\.0\.0\.1:\d+/git/)batuhanozgun/devos(\.git)?/?", re.I)
SHA40 = re.compile(r"[0-9a-f]{40}")
MERGE_GATE_TIMEOUT = 300   # seconds; the hooks' timeout in .claude/settings.json must not be shorter (W-C00-14)

# Leak check (W-C00-14). The one place a clone of the private research library may be (the sibling of the devos
# checkout, where the session clones it after add_repo), and the fingerprint store, outside every repository and
# guarded (B5, F5). The environment overrides exist for tools/test_tool_allowlist.sh; a session cannot set the
# hook's environment (that is .claude/settings.json, F1).
LIBRARY_DIR = os.environ.get("DEVOS_LIBRARY_DIR") or "/home/user/agentic-os-search"
LEAK_STORE = os.environ.get("DEVOS_LEAK_STORE") or "/home/user/.devos-leak-store"
LIBRARY_NAME = re.compile(r"agentic-os-search", re.I)
SHINGLE_WORDS = 8          # a "long match": one run of 8 consecutive normalised words in common
STORE_VERSION = 1
SERVICE_REV = "3cd686a"    # tools/check_service_names.sh derives the service names from this revision's settings
SERVICE_GENERIC = {"google", "claude", "career", "intelligence", "network", "analytics", "drive", "calendar",
                   "docs", "flow"}   # the generic words that script leaves out
TR_FOLD = str.maketrans({"ı": "i", "İ": "i"})

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
# git is handled by allow lists (R-D008-2 N-1, N-2): the subcommands, global options and settings below. Anything
# else, aliases and git-* helper programs included, is denied, because git expands aliases and reads settings
# that this guard cannot see.
GIT_SUBCOMMANDS = {
    "add", "am", "apply", "archive", "bisect", "blame", "branch", "cat-file", "check-ignore", "checkout", "cherry",
    "cherry-pick", "clean", "clone", "commit", "config", "count-objects", "describe", "diff", "diff-tree", "fetch",
    "for-each-ref", "format-patch", "fsck", "gc", "grep", "help", "init", "log", "ls-files", "ls-remote", "ls-tree",
    "merge", "merge-base", "mv", "name-rev", "notes", "prune", "pull", "push", "range-diff", "rebase", "reflog",
    "remote", "reset", "restore", "rev-list", "rev-parse", "revert", "rm", "shortlog", "show", "show-branch",
    "show-ref", "stash", "status", "switch", "symbolic-ref", "tag", "update-index", "update-ref", "var",
    "verify-commit", "version", "whatchanged", "worktree"}
GIT_GLOBAL_FLAGS = {"--no-pager", "-P", "--paginate", "-p", "--no-optional-locks", "--literal-pathspecs",
                    "--glob-pathspecs", "--noglob-pathspecs", "--icase-pathspecs", "--no-replace-objects",
                    "--version", "--help", "-h"}
GIT_SAFE_KEYS = re.compile(r"(core\.quotepath|color\..*|user\.(name|email)|commit\.gpgsign|tag\.gpgsign|advice\..*|"
                           r"init\.defaultbranch|pull\.(rebase|ff)|merge\.ff|log\.[a-z]+|format\.pretty|"
                           r"diff\.(renames|algorithm|context|noprefix|mnemonicprefix)|safe\.directory|"
                           r"protocol\.version|fetch\.(prune|parallel)|status\.[a-z]+|rebase\.autostash)$", re.I)
GIT_SUB_OPT_DENY = {"--upload-pack", "--receive-pack", "--exec", "--template", "--config", "--separate-git-dir"}
# subcommands that create files or a tree at a location (not an in-place change B4 already covers). They are
# checked coarsely: the directory they run in and every path they name must stay out of the guarded zones
# (R-D008-10 B10-2). Entries not in GIT_SUBCOMMANDS are already denied by the allow list; they are kept here so
# the coarse check still applies if one is ever listed.
GIT_TREE_WRITE = {"clone", "init", "worktree", "submodule", "archive", "format-patch", "bundle", "checkout-index"}
# environment that changes where git, or any program, reads its settings (R-D008-1 B-1; R-D008-2 N-2)
GIT_ENV_OVERRIDE = re.compile(r"(?<![\w$])(HOME|XDG_[A-Z_]+|GIT_(?!(AUTHOR|COMMITTER)_(NAME|EMAIL|DATE)\b|"
                              r"TERMINAL_PROMPT\b|PAGER\b)[A-Z_]+)=")
ACCOUNT_CLIS = {"gh", "gcloud", "gsutil", "bq", "claude"}
NET_TOOLS = {"ssh", "scp", "sftp", "nc", "ncat", "netcat", "socat", "telnet", "ftp", "rsync"}
SHELLS = {"bash", "sh", "zsh", "dash"}
SHELL_FAMILY = {"bash", "sh", "zsh", "dash", "ksh"}   # shells where -s makes stdin the program (R-D008-11 B11-3)
DEST_COMMANDS = {"cp", "install", "ln"}            # only the destination is written
# value-taking SHORT options for the destination writers, so a short cluster is parsed letter by letter and
# stops at the first value-taker: install -gstaff is -g staff, not a -t (R-D008-15 C15-1)
DEST_VALUE_OPTS = {"cp": set("tS"), "install": set("tmogS"), "ln": set("tS")}
WRITE_COMMANDS = {"mv", "rm", "rmdir", "touch", "truncate", "chmod", "chown", "mkdir", "tee", "unzip"}
IN_PLACE_COMMANDS = {"sed", "perl"}                # write only with -i
LIVE_BANNED_GIT = {"checkout", "switch", "reset", "rebase", "cherry-pick", "revert", "am", "apply", "stash",
                   "restore", "clean", "commit", "merge", "pull", "mv", "rm", "update-ref", "symbolic-ref",
                   "read-tree", "checkout-index", "filter-branch", "filter-repo", "replace", "notes",
                   "update-index"}                 # update-index can hide a changed guard file from git status

WO = "plan/Installation_Working_Order.md"   # where the guard's rules are described (D-010)
RULES = {  # id: (title, why the rule exists, where it is written, what to do instead)
    "G0": ("readable call", "The guard could not read or parse the call, so it cannot decide it safely; it "
           "fails closed.", WO + " (fail closed)",
           "Repeat the call in a well-formed way; for the shell, write the command so that its quotes balance."),
    "T1": ("non-MCP tool allow list", "Only the tools a DevOS session needs are allowed. A tool not named here, "
           "including tools that reach the account's other sessions, publishing surfaces, connector and plugin "
           "tools, MCP resource readers and worktree switching, is denied, so nothing new appears unguarded.",
           WO, "Use an allowed tool. A new tool is added only by a reviewed change to this file."),
    "T2": ("subagents in-process only", "A subagent with an isolation mode runs in another worktree or as a new "
           "cloud session, outside the session-tool rules.", WO + "; R-C00-BOM-5 N-B1",
           "Call Agent or Task without an isolation field."),
    "T3": ("workflows in-process only", "A workflow agent with an isolation option runs in another worktree or "
           "environment, outside this guard's view.", WO + "; D-008",
           "Write the workflow without any isolation option."),
    "M1": ("MCP server allow list", "Only the GitHub tools, the session tools and the read-only database "
           "connector are allowed. Account connectors (mail, calendar, files and others, some under opaque IDs) "
           "are never used by DevOS.", "CLAUDE.md; " + WO + "; D-003",
           "Do the work without that server."),
    "M2": ("GitHub write scope", "GitHub writes may target only batuhanozgun/devos; repository creation and "
           "forking are blocked.", WO, "Write only to batuhanozgun/devos."),
    "M3": ("main changes only through a merged pull request", "A file written straight onto main skips the pull "
           "request, its checks and its review.", "PC-02; " + WO,
           "Commit to a claude/ branch and open a pull request."),
    "M4": ("no auto-merge", "Auto-merge merges later, without the merge gate's check at that moment.",
           WO + "; D-008", "Merge with merge_pull_request when the gate's conditions hold."),
    "M5": ("no approving reviews", "A GitHub approval is given in the account owner's name. The independent "
           "check is a checker verdict file (evidence/<stage>/checks/), never a GitHub approval.",
           WO + "; D-006; D-007", "Use a COMMENT review if a comment is needed."),
    "M6": ("merge exactly the reviewed head", "A merge names the full 40-character head SHA (expectedHeadSha), so "
           "that a head that moved after review is not merged, and uses the merge method, because squash and "
           "rebase create commits that no verdict names (the short-SHA failure of T-A2).",
           WO + "; D-008", "Pass expectedHeadSha with the full SHA and merge_method merge."),
    "M7": ("merge gate for class-high changes", "A change to rules, hooks, tools, governing documents or "
           "acceptance conditions (class high) merges only with a checker verdict that covers its head. This "
           "written check replaces the classifier's 'merge without review' rule.",
           WO + "; PC-05 as changed by PC-06; tools/merge_gate.py",
           "Have a checker subagent judge the head, write its verdict verbatim to "
           "evidence/<stage>/checks/CHK-<stage>-<nnn>.md on the branch (reviewed_head: the full SHA it judged), "
           "push, then merge the new head."),
    "S1": ("session tools on owned IDs only", "Session tools reach every session and routine of the account; "
           "DevOS acts only on the ones it created (owned_ids.txt, filled by the recorder hook).",
           WO + "; owned_ids.txt", "Act only on sessions and routines this builder created."),
    "S2": ("new sessions carry the barrier", "A new session is guarded only if it checks out devos fully, in "
           "the builder environment, at a revision that carries .claude/settings.json, and never pushes to main.",
           WO + "; PC-02", "Create the session on main, in the builder environment, with "
           "source_url https://github.com/batuhanozgun/devos and no sparse checkout."),
    "S3": ("Opus 5.5 in Accept edits for every new session", "Batu's standing rule: every session the builder "
           "opens runs on claude-opus-5-5 at ultracode effort, in Accept edits, where this guard decides every "
           "call. Routines that start a fresh session cannot set the model (BP-05).", "D-008",
           "Pass model claude-opus-5-5 and permission_mode acceptEdits; bind routines to an owned session."),
    "S4": ("routines", "A routine runs later without a person; it must carry no connectors and fire only into "
           "the builder's own sessions in the builder environment.", WO,
           "Create the routine without connectors, bound to an owned session."),
    "S5": ("repositories", "Only devos may be attached, and the research library read-only.",
           WO + "; CLAUDE.md", "Attach only devos, or the library with access read."),
    "F1": ("live guard files", "This working tree's .claude/ holds the guard itself, its settings and the "
           "owned-ID list; a change there takes effect at once, without review.",
           WO + "; PC-05 as changed by PC-06", "Edit in a scratch clone outside this working tree, open a "
           "pull request, get its checker verdict, merge, then run tools/sync_worktree.sh."),
    "F2": ("git internals", "Files under .git/ belong to git; editing them can rewrite history or plant git "
           "hooks that run on later commands.", WO, "Use git commands."),
    "F3": ("Claude Code's own configuration", "User settings, shell start-up files and the protected "
           "configuration files decide how sessions start and what they may do; a change there is a "
           "permission change.", WO + "; D-008", "None from a session: such a change is not made here."),
    "F4": ("credentials", "The session's credential files reach the account's other sessions and services.",
           WO + "; R-C00-BOM-5 R-1", "Use the session tools and the GitHub tools, which are scope-checked."),
    "B1": ("no push to main", "main changes only through a merged pull request.", "PC-02; " + WO,
           "Push to a claude/ branch and open a pull request."),
    "B2": ("no remote history rewriting", "Force pushes, mirror and prune pushes and remote branch deletion "
           "destroy history that other sessions and the records rely on.", WO + "; D-008",
           "Push new commits; leave an abandoned branch in place and record it in the stage log."),
    "B3": ("builder branch space", "The builder pushes only to claude/ branches of devos, named explicitly, so "
           "that every push stays visible and nothing reaches another repository.",
           WO, "Run git push <devos remote> <branch> with a claude/ branch, in a directory written literally."),
    "B4": ("the live working tree stays at main", "The guard and owned_ids.txt are read from this working tree; "
           "a checkout, reset, commit or similar here would swap the enforced rules or hide them.",
           WO, "Work in a scratch clone or worktree outside this working tree and "
           "use git -C <literal path>; to update this tree, run tools/sync_worktree.sh."),
    "B5": ("no shell writes into guarded directories", "The live .claude/ (the guard), the live .git/ and "
           "Claude Code's configuration (~/.claude) change only through a reviewed merge or not at all; the leak "
           "check's fingerprint store only through tools/leak_fingerprints.py.",
           WO + "; D-008; W-C00-14", "Change files in a scratch clone and merge them through a reviewed pull "
           "request; rebuild the fingerprint store with python3 tools/leak_fingerprints.py build."),
    "B6": ("no sending data out", "Uploads and raw network tools can carry data out of the container; once the "
           "classifier is gone (D-008), a hidden instruction in a read document is the main way this happens.",
           WO + "; D-008", "Read with curl or wget without upload options; write to GitHub with the GitHub "
           "tools."),
    "B7": ("no command lines that carry account credentials", "gh, gcloud, gsutil, bq and the claude command line "
           "act with the account's credentials outside the scope checks of this guard.",
           WO + "; R-C00-BOM-5 R-1; D-003", "Use the GitHub tools and the session tools."),
    "B8": ("no credentials in the shell", "The session's tokens, token files and environment reach the "
           "account's other sessions and services; printing them, even by a dump such as set, export -p or "
           "declare -x, would also put them in the transcript.",
           WO + "; R-C00-BOM-5 R-1", "Do not read credentials; the tools that need them hold them."),
    "B9": ("critical paths", "Removing the filesystem root, a top-level directory, the home directory or this "
           "working tree destroys the session's state.", WO + "; Claude Code critical paths",
           "Remove only specific paths inside a scratch directory."),
    "B11": ("git only through its allow lists", "git expands aliases and reads settings from files and "
            "environment variables the guard cannot see. A setting (git config, git -c, an alias, or HOME, XDG_ or "
            "GIT_ variables) could send a push to another address than the one the guard checks, run another "
            "program, or change revisions under another name (R-D008-1 B-1; R-D008-2 N-1, N-2). So only listed "
            "subcommands, global options and settings are allowed.", WO + "; D-008",
            "Use a listed git subcommand by its own name, with -C <literal path>; push with git push origin "
            "<claude/ branch>; write only settings such as user.name and user.email."),
    "B10": ("the sandbox stays on", "Disabling the sandbox for a command removes a layer this guard relies on.",
            WO + "; D-008", "Run the command without dangerouslyDisableSandbox."),
    "F5": ("the fingerprint store", "The leak check's store decides what counts as library text; only "
           "tools/leak_fingerprints.py writes it, from the library clone.", WO + "; W-C00-14",
           "Rebuild it with python3 tools/leak_fingerprints.py build."),
    "L1": ("leak check before a public write", "devos is public: what is pushed or written there is visible at "
           "once. Text taken verbatim from the private research library (a run of " + str(SHINGLE_WORDS) +
           " words matching the fingerprints built from the library clone) and the names of the account's "
           "third-party services may not be written there. Every commit a push would publish is read (message, "
           "paths, added lines), and every string field of a GitHub write. While a library clone exists, a "
           "missing, stale or unreadable fingerprint store stops every public write. Text already on origin/main "
           "does not count. The matched text is never shown or logged.",
           WO + "; plan 0.5 item 3, K-9 item 5, 6.7; OI-012; D-013; W-C00-14",
           "Write DevOS's own synthesis and cite the source identifier instead of the library's words; leave the "
           "service name out. Find the matching lines locally with python3 tools/leak_fingerprints.py scan <file>, "
           "and remove them from every commit of the branch (for example, rebuild the branch from origin/main), "
           "not only from the last one. If the store is missing or stale, rebuild it with python3 "
           "tools/leak_fingerprints.py build."),
    "L2": ("a push stands alone in its Bash call", "The leak check reads the commits a push would publish when "
           "the call is decided. Another command in the same call that can create commits or move refs (commit, "
           "merge, rebase, reset, fetch, a script, a shell) would change what is pushed after the check.",
           WO + "; W-C00-14", "Run the push as its own Bash call: git -C <literal path> push origin <claude/ "
           "branch>, alone or with cd, echo and readers such as tail."),
    "L3": ("the library clone in its one place", "The leak check compares public writes with fingerprints of "
           "one clone of the private research library, at " + LIBRARY_DIR + ", and fails closed while that clone "
           "exists without a fresh store. A clone, copy or fetch of the library anywhere else would escape that.",
           WO + "; W-C00-14", "Clone the library only to " + LIBRARY_DIR + ", read it there, and rebuild the "
           "store with python3 tools/leak_fingerprints.py build."),
}
LEAK_WITHHELD = {"L1", "L2"}   # denials whose call text is never repeated (it may hold the matched text)


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
    return subprocess.run(["git", "-C", cwd, *args], capture_output=True, encoding="utf-8", errors="replace",
                          timeout=timeout)


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


def summary(name, args, rule=None):
    """The call as logged and shown in a denial. Text that matches the library fingerprints or names a service
    is never repeated there, nor is the call text of a leak denial (W-C00-14)."""
    if rule in LEAK_WITHHELD:
        return f"[withheld: a {rule} denial does not repeat the call's text]"
    if name == "Bash":
        s = str(args.get("command", ""))
    elif name in FILE_WRITE_TOOLS or name in FILE_READ_TOOLS:
        s = str(args.get(FILE_WRITE_TOOLS.get(name) or FILE_READ_TOOLS.get(name)) or "")
    else:
        keep = {k: v for k, v in args.items() if k not in ("content", "files", "prompt", "message", "body",
                                                             "new_string", "old_string", "script")}
        s = json.dumps(keep, ensure_ascii=False, sort_keys=True)
    if withheld(s):
        return "[withheld: the call's text matches the library fingerprints or names a service]"
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
    """Unquoted newlines end a command; comments are dropped; a backslash-newline is a line continuation
    (removed) unless it is inside a comment or single quotes, where bash does not join it (R-D008-3 R3 S4)."""
    out, i, n, q, comment = [], 0, len(t), None, False
    while i < n:
        ch = t[i]
        if comment:
            if ch == "\n":
                comment = False
                out.append(" ; ")
            i += 1
            continue
        if q == "'":
            out.append(ch)
            if ch == "'":
                q = None
            i += 1
            continue
        if ch == "\\" and q != "'":
            if i + 1 < n and t[i + 1] == "\n":          # line continuation: bash removes both characters
                i += 2
                continue
            if i + 1 < n:
                out.append(ch)
                out.append(t[i + 1])
                i += 2
                continue
            out.append(ch)
            i += 1
            continue
        if q == '"':
            out.append(ch)
            if ch == '"':
                q = None
            i += 1
            continue
        if ch in "'\"":
            q = ch
            out.append(ch)
            i += 1
            continue
        if ch == "#" and (i == 0 or t[i - 1].isspace() or t[i - 1] in ";&|()"):
            comment = True
            i += 1
            continue
        out.append(" ; " if ch == "\n" else ch)
        i += 1
    return "".join(out)


def tokens(text):
    text = newlines_to_separators(strip_heredocs(text))
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
REDIRECT_WRITE_DUP = {">&", "<>"}      # write to a file unless the target is a descriptor (R-D008-5 B-1)
REDIRECT_OTHER = {"<", "<<", "<<<", "<&", "<<-"}
# programs that only read; they may name a guarded path. Everything else that names one is denied (B5),
# because enumerating writers failed five review rounds (R-D008-5 B-1): the ban keys on the guarded target,
# a small fixed set, not on the open set of writing programs. sed/sort are readers only without their
# write option; a write option moves them out.
PURE_READERS = {"cat", "head", "tail", "less", "more", "grep", "egrep", "fgrep", "rg", "wc", "ls", "stat",
                "file", "cmp", "diff", "od", "hexdump", "strings", "nl", "tac", "realpath", "readlink",
                "basename", "dirname", "cut", "tr", "column", "fold", "md5sum", "sha1sum", "sha256sum",
                "cksum", "du", "test", "[", "[[", "jq"}
# readers only WITHOUT a write flag (R-D008-12 B12-6): xxd -r writes, yq -i edits in place, awk/gawk -i inplace
# edits in place; jq has no in-place mode. These get the reader exceptions in command_checks, not a blanket pass.
AWKS = {"awk", "gawk", "mawk", "nawk"}
# copy-like programs: moving a .claude or .git directory tree into place is a guard/internals swap (R-D008-6 B-1,
# the honest-mistake case). The general data-derived write (an archive, a patch) is a stated residual (WO, "Not protected").
COPY_LIKE = {"cp", "rsync", "tar", "cpio", "unzip", "pax", "install", "ln", "scp", "7z", "7za", "unar"}
# interpreters name a script to RUN it, so naming a guarded path is not a write by them; a write performed
# inside their own language is the stated interpreter residual (WO, "Not protected"), not caught here.
INTERPRETERS = {"python", "python3", "python2", "bash", "sh", "zsh", "dash", "ksh", "perl", "ruby", "node",
                "nodejs", "php", "lua", "Rscript", "deno", "bun", "tclsh", "expect"}
# interpreter options that take NO value and run no code or module. Only these may precede the script and keep
# the "running a tools/ script" exemption; anything else (-m, -c, -e, -W/-X and their attached forms -mFOO,
# -cCODE, a value-taker, a bare -) ends the exemption, so the script and every other argument are then checked
# as ordinary paths (R-D008-10 B10-3). The list is read PER INTERPRETER: for a shell, -s and -i are dropped,
# because -s makes standard input the program and a following tools/ path is then its argument, not a script
# being run — one list shared across interpreters with different grammars can otherwise open a hole (R-D008-11
# B11-3). An over-generous entry only over-denies (the script, under tools/, is then checked and denied).
SAFE_INTERP_OPTS = {"-B", "-b", "-bb", "-d", "-E", "-I", "-O", "-OO", "-P", "-q", "-s", "-S", "-t", "-tt",
                    "-u", "-v", "-x"}
# bash reserved words and compound-command punctuation. They stand in command position without being the
# program, so each also ends the current simple command and starts a new one; the real command after them is
# then identified and checked (R-D008-3 R3-1). The set is the full bash list, so a command cannot hide behind
# one. A command word the splitter does not recognise as one of these is treated as a program and checked.
RESERVED = {"!", "{", "}", "if", "then", "elif", "else", "fi", "for", "while", "until", "do", "done", "case",
            "esac", "select", "function", "in", "time", "coproc", "[[", "]]", "((", "))"}
# names whose assignment moves where git or another program reads its settings (R-D008-2 N-2; R-D008-3 R3-2)
PROTECTED_VARS = re.compile(r"(HOME|XDG_[A-Z_]+|GIT_(?!(AUTHOR|COMMITTER)_(NAME|EMAIL|DATE)$|TERMINAL_PROMPT$|"
                            r"PAGER$)[A-Z_]+)$")
SET_BUILTINS = {"read", "mapfile", "readarray", "export", "declare", "typeset", "local", "readonly", "unset",
                "let", "eval", "printf"}


CRED_BASENAMES = {".git-credentials", ".netrc", "_netrc", "credentials"}
INDIRECT = re.compile(r"\$\{!\w+\}")                 # ${!var} reads the variable named by var (R-D008-1)


def substitutions(command):
    """Pull out every command bash would run via substitution, wherever it sits: $(...), `...`, <(...), >(...),
    even inside double quotes (R-D008-3 S1, S2). Returns (text with each replaced by a placeholder, [inner
    commands]). $'...' and single quotes are literal. $((...)) is arithmetic, not a command. Unbalanced -> G0."""
    out, inners, i, n, q = [], [], 0, len(command), None
    while i < n:
        ch = command[i]
        if q == "'":
            out.append(ch)
            if ch == "'":
                q = None
            i += 1
            continue
        if ch == "$" and i + 1 < n and command[i + 1] == "'":   # ANSI-C quoting: a literal string
            out.append("_")
            i += 2
            while i < n and command[i] != "'":
                i += 2 if command[i] == "\\" else 1
            i += 1
            continue
        if q is None and ch == "'":
            q = "'"
            out.append(ch)
            i += 1
            continue
        if ch == '"':
            q = None if q == '"' else '"'
            out.append(ch)
            i += 1
            continue
        if command.startswith("$((", i):
            k = command.find("))", i + 3)
            if k == -1:
                raise Bad("G0", "an unbalanced $(( arithmetic expansion; the guard cannot read the command")
            out.append("0")
            i = k + 2
            continue
        if command.startswith("$(", i) or command.startswith("<(", i) or command.startswith(">(", i):
            j, depth, iq = i + 2, 1, None
            while j < n and depth > 0:
                c = command[j]
                if iq:
                    iq = None if c == iq else iq
                elif c in "'\"":
                    iq = c
                elif c == "(":
                    depth += 1
                elif c == ")":
                    depth -= 1
                j += 1
            if depth != 0:
                raise Bad("G0", "an unbalanced command substitution; the guard cannot read the command")
            inners.append(command[i + 2:j - 1])
            out.append("$_sub_")      # carries a $ so resolve_dir/target_path treat it as unresolvable (B11-1)
            i = j
            continue
        if ch == "`":
            j = i + 1
            while j < n and command[j] != "`":
                j += 2 if command[j] == "\\" else 1
            if j >= n:
                raise Bad("G0", "an unbalanced backtick substitution; the guard cannot read the command")
            inners.append(command[i + 1:j])
            out.append("$_sub_")      # see above (B11-1)
            i = j + 1
            continue
        out.append(ch)
        i += 1
    return "".join(out), inners


def token_credential_check(tok):
    """A single token that reads a credential or a variable's value by indirection (R-D008-3 false-positive fix:
    this runs on tokens, not on the raw command, so a credential name inside a comment or a quoted argument of an
    unrelated command does not trip it)."""
    m = CREDENTIAL_EXPANSION.search(tok)
    if m:
        raise Bad("B8", f"the token expands the credential variable {m.group(1)}")
    if INDIRECT.search(tok):
        raise Bad("B8", "indirect expansion ${!...} can read any variable, credentials included")
    if any(cp in tok for cp in CREDENTIAL_PATHS) or os.path.basename(tok.rstrip("/")) in CRED_BASENAMES \
            or re.search(r"/proc/[^/\s]*/env", tok):
        raise Bad("B8", f"the token reads a credential store or a process environment ({tok[:60]})")


def simple_commands(toks):
    """Split into simple commands, cutting at control operators, grouping and every reserved word, so a command
    after a reserved word (then, do, {, !, ...) is its own segment and gets checked (R-D008-3 R3-1). Grouping
    tokens are emitted so the cwd stack still tracks ( ). A `for`/`select` loop variable is checked (R3-2) and
    its `in` word-list is data, not commands, so it is skipped."""
    cmds, cur, st = [], [], None   # st: forvar (expect variable), forin (expect in/do), forlist (skip data words)
    for tk in toks:
        if st == "forlist" and tk != "do" and tk not in SEPARATORS:
            continue                                   # a data word of the for/select list
        if tk in SEPARATORS or tk in ("(", ")") or tk in RESERVED:
            if cur:
                cmds.append(cur)
                cur = []
            if tk in ("(", ")"):
                cmds.append([tk])
            if tk in ("for", "select"):
                st = "forvar"
            elif tk == "in" and st == "forin":
                st = "forlist"
            elif tk == "do" or tk in SEPARATORS:
                st = None if st in ("forlist", "forin") else st
            elif st in ("forvar", "forin") and tk != "in":
                st = None
            continue
        if st == "forvar":
            if PROTECTED_VARS.match(tk.split("=", 1)[0].split("+", 1)[0]):
                raise Bad("B11", f"the loop variable {tk} changes where programs read their settings")
            st = "forin"
            continue
        cur.append(tk)
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
    if any(c in arg for c in "$`{}"):        # a variable, substitution or brace expansion: unresolvable (B12-5)
        return None
    if arg == "~" or arg.startswith("~/"):
        return HOME + arg[1:]
    if arg.startswith("~"):                  # ~+, ~-, ~user resolve elsewhere: unresolvable here (R-D008-12 B12-4)
        return None
    if os.path.isabs(arg):
        return arg
    return None if d is None else os.path.join(d, arg)


def guarded_roots():
    return [(os.path.join(ROOT, ".claude"), "the live guard files (.claude/ of this working tree)"),
            (os.path.join(ROOT, "tools"), "the live tools/ directory (the merge gate and checks; run them, "
                                          "do not write them)"),
            (os.path.join(ROOT, ".git"), "the live repository's .git/"),
            (os.path.join(HOME, ".claude"), "Claude Code's own configuration (~/.claude)"),
            (os.path.join(HOME, ".config", "git"), "git's user configuration (~/.config/git)"),
            ("/etc/gitconfig", "git's system configuration"),
            (LOG_DIR, "the guard's decision log"),
            (LEAK_STORE, "the leak check's fingerprint store (only tools/leak_fingerprints.py writes it)")]


def guarded_zone(p, remove=False):
    """The guarded place that a write at p (or, with remove, a removal of p) would touch; None when none.
    A glob counts for every path it could match, and a removal also for what lies inside it (R-D008-2 N-5)."""
    parts = [x for x in os.path.normpath(p).split(os.sep) if x]
    real = [x for x in os.path.realpath(p).split(os.sep) if x]
    if ".git" in parts or ".git" in real:
        return "a .git/ directory (git's internals and hooks; R-D008-2 N-4)"
    if os.path.basename(p) in PROTECTED_NAMES:
        return f"the protected configuration file {os.path.basename(p)}"
    worktrees = os.path.join(ROOT, ".claude", "worktrees")
    globbed = any(c in p for c in "*?[")
    for base, label in guarded_roots():
        if not globbed:
            if within(p, base) and not within(p, worktrees):
                return label
            if remove and within(base, p):
                return label + ", which lies inside the removed path"
            continue
        bparts = [x for x in os.path.realpath(base).split(os.sep) if x]
        k = min(len(parts), len(bparts))
        if all(fnmatch.fnmatchcase(bparts[i], parts[i]) for i in range(k)) and (len(parts) >= len(bparts) or remove):
            return label + f" (the glob {p} can match it)"
    return None


def write_guarded(p, remove=False):
    """Kept as the name the write-detection call sites use. The live `tools/` directory is now a guarded root
    (R-D008-7 B7-1, R-D008-8 B8-1), so this is just guarded_zone: writes into tools/ are caught with the same
    glob and ancestor handling as the other zones, while the catch-all exempts readers and interpreters so the
    gate and checks stay runnable."""
    return guarded_zone(p, remove=remove)


def literal_guarded(arg, remove=False):
    """A write target the guard cannot resolve (it holds a shell variable, a substitution placeholder, a brace
    expansion or a non-`~/` tilde) still names a guarded location when a guarded component is literally visible in
    the token (R-D008-11 B11-2, R-D008-12 B12-5): `$PWD/.claude/x`, `$(pwd)/tools/y`, `{tools,tmp}/x`. The token
    is split on `/` and on brace-expansion punctuation (`{ } ,`); components that still contain a `$` or backtick
    are dropped, so a bare variable (`$DEST`) that expands to a guarded path with nothing guarded visible stays
    the lexical residual (WO, "Not protected"). Returns a label or None."""
    parts = [x for x in re.split(r"[/{},]", arg.replace("\\", "/")) if x and "$" not in x and "`" not in x]
    for x in parts:
        if x in (".claude", ".git", "tools", "devos-guard", LOG_BASENAME,  # devos-guard = default log dir (m-1)
                 os.path.basename(LEAK_STORE.rstrip("/"))):
            return f"a guarded location named literally inside an unresolved path ({x} in {arg})"
    for k in range(len(parts) - 1):
        if parts[k] == ".config" and parts[k + 1] == "git":
            return f"git's user configuration named inside an unresolved path (.config/git in {arg})"
        if parts[k] == "etc" and parts[k + 1] == "gitconfig":
            return f"git's system configuration named inside an unresolved path (/etc/gitconfig in {arg})"
    if parts and parts[-1] in PROTECTED_NAMES:
        return f"a protected configuration file named inside an unresolved path ({parts[-1]} in {arg})"
    if remove and ".config" in parts:    # m-2: removing an ancestor of ~/.config/git behind a variable
        return f"an ancestor of git's user configuration in an unresolved removal path (.config in {arg})"
    return None


def guarded_write(d, arg, remove=False):
    """The guarded-location label for a write target, or None. A resolvable path uses write_guarded; a path the
    guard cannot resolve falls back to literal_guarded, so a guarded component behind a variable, substitution,
    brace or tilde is still caught (R-D008-11 B11-2, R-D008-12 B12-4/B12-5)."""
    p = target_path(d, arg)
    if p:
        return write_guarded(p, remove=remove)
    return literal_guarded(arg, remove=remove)


def inplace_flag(args):
    """True if a sed/perl call edits in place: -i, --in-place[=...], or a short-option cluster that contains an
    `i` such as -pi, -ri, -Ei, -0pi, -pi.bak (R-D008-13 B13-2). Over-matching (e.g. perl -Idir, whose value holds
    an i) only over-denies when a guarded path is also named, which is never a daily command here."""
    for a in args[1:]:
        if a == "--in-place" or a.startswith("--in-place="):
            return True
        if a.startswith("-") and not a.startswith("--") and "i" in a:
            return True
    return False


def cluster_opt_value(args, letter):
    """Values of a value-taking short option `letter` bundled in a single-dash cluster: `-rt DIR`, `-ttools`,
    `-uo FILE`, `-otools/x` (R-D008-13/14 B13-2, B14-1, B14-2). For each single-dash word containing `letter`,
    the value is the cluster text after the first `letter` if non-empty, else the next word. Callers UNION this
    with the ordinary destination, so an over-read (the letter also sits inside another option's value) only
    adds a usually harmless extra path to check; it never replaces the real target."""
    vals = []
    for k, a in enumerate(args):
        if not (a.startswith("-") and not a.startswith("--") and len(a) > 1):
            continue
        i = a.find(letter, 1)
        if i == -1:
            continue
        rest = a[i + 1:]
        if rest:
            vals.append(rest)
        elif k + 1 < len(args):
            vals.append(args[k + 1])
    return vals


def target_dirs(prog, args):
    """The -t/--target-directory values for cp/install/ln in any spelling (R-D008-14 B14-1, R-D008-15 C15-1). A
    short cluster is walked letter by letter and stops at the first value-taking option (DEST_VALUE_OPTS), so the
    `t` inside another option's value — install -gstaff is -g staff — is not mistaken for -t. When -t is found,
    its value is the rest of the cluster, else the next word."""
    dirs, valset = [], DEST_VALUE_OPTS.get(prog, set("t"))
    for k, a in enumerate(args):
        if a in ("-t", "--target-directory") and k + 1 < len(args):
            dirs.append(args[k + 1])
            continue
        if a.startswith("--target-directory="):
            dirs.append(a.split("=", 1)[1])
            continue
        if not (a.startswith("-") and not a.startswith("--") and len(a) > 1):
            continue
        j = 1
        while j < len(a):
            c = a[j]
            if c == "t":
                dirs.append(a[j + 1:] if j + 1 < len(a) else (args[k + 1] if k + 1 < len(args) else ""))
                break
            if c in valset:          # another value-taking letter consumes the rest of the cluster
                break
            j += 1
    return [d for d in dirs if d]


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
        if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*\+?=.*", a[0], re.S):
            if PROTECTED_VARS.match(re.match(r"[A-Za-z_][A-Za-z0-9_]*", a[0]).group(0)):
                raise Bad("B11", f"the assignment {a[0].split('=', 1)[0]} changes where programs read their settings")
            a = a[1:]
        elif b == "env":
            a = a[1:]
            while a and (a[0].startswith("-") or re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*=.*", a[0])):
                if a[0] in ("-C", "--chdir") or a[0].startswith(("-C", "--chdir=")):   # R-D008-12 B12-3
                    raise Bad("B5", "env -C/--chdir changes the working directory, which the guard cannot track; "
                                    "run the command in that directory another way")
                if re.match(r"[A-Za-z_][A-Za-z0-9_]*\+?=", a[0]) and \
                        PROTECTED_VARS.match(re.match(r"[A-Za-z_][A-Za-z0-9_]*", a[0]).group(0)):
                    raise Bad("B11", f"the assignment {a[0].split('=', 1)[0]} changes where programs read settings")
                a = a[2:] if a[0] in ("-u", "--unset", "-S", "--split-string") else a[1:]
            if not a:
                return [], True
        elif b in ("sudo", "command", "exec", "nohup", "time", "builtin", "stdbuf", "ionice", "unbuffer", "doas",
                   "setarch", "chrt", "setsid", "catchsegv"):
            vopts = {"sudo": {"-p", "-u", "-g", "-C", "-h", "-r", "-t", "-U", "-R", "-D", "-A", "-c"},
                     "doas": {"-u", "-C"}, "exec": {"-a"}, "stdbuf": {"-i", "-o", "-e"},
                     "ionice": {"-c", "-n"}, "setarch": {"-R"}, "chrt": set()}.get(b, set())
            a = a[1:]
            while a and a[0].startswith("-"):
                if a[0] == "--":
                    a = a[1:]
                    break
                a = a[2:] if a[0] in vopts and len(a) > 1 and "=" not in a[0] else a[1:]
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
    """Raise Bad for the first ban the command breaks. Depth guards against runaway recursion into nested
    substitutions (R-D008-3 S1 to S3)."""
    if depth > 8:
        raise Bad("G0", "the command nests substitutions too deeply for the guard to read")
    for v in credential_values():
        if v and v in command:
            raise Bad("B8", "the command names the session's token file or messaging socket")
    cleaned, inners = substitutions(command)   # a command bash runs via $(...), `...`, <(...) is checked too
    for inner in inners:
        shell_checks(inner, cwd, depth + 1)
    try:
        toks = tokens(cleaned)
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
            if (t in REDIRECT_OUT or t in REDIRECT_WRITE_DUP or t in REDIRECT_OTHER) \
                    and args and args[-1].isdigit():
                args.pop()          # a leading IO number (2>…, 1>…, 2>&1) belongs to the redirection, not the
                                    # command, so it must not stand in as the destination (R-D008-13 B13-1)
            if t in REDIRECT_OUT:
                if i + 1 < len(argv):
                    outs.append(argv[i + 1])
                i += 2
            elif t in REDIRECT_WRITE_DUP:
                tgt = argv[i + 1] if i + 1 < len(argv) else ""
                if not re.fullmatch(r"\d+-?|-", tgt):     # a number or - is a descriptor, not a file
                    outs.append(tgt)
                i += 2
            elif t in REDIRECT_OTHER:
                i += 2
            else:
                args.append(t)
                i += 1
        for o in outs:
            z = guarded_write(d, o)
            if z:
                raise Bad("B5", f"a redirection writes into {z} ({o})")
        args, bare_env = strip_wrappers(args)
        if bare_env:
            raise Bad("B8", "env without a command prints the whole environment, including credentials")
        for tk in args:
            token_credential_check(tk)
        if not args:
            continue
        if args[0] not in ("[", "[[") and any(c in args[0] for c in "$`*?["):
            raise Bad("G0", f"the command name {args[0]} is not a plain word (it uses a variable or a glob), so the "
                            "guard cannot tell which program bash would run")
        prog = os.path.basename(args[0])
        CALL.append((prog, args))                # every command of the call, for L2 (a push stands alone)
        if prog == "trap" and depth < 8:   # trap runs its handler string later; check it as a command (S3)
            for a in args[1:]:
                if not a.startswith("-"):
                    shell_checks(a, d, depth + 1)
                    break
        if prog in ("cd", "pushd"):
            operand = None                              # skip options (-L -P -e -@ --, pushd -n) to the real dir
            for a in args[1:]:                          # (R-D008-12 B12-2: an option was read as the directory)
                if a in ("-L", "-P", "-e", "-@", "--", "-n"):
                    continue
                operand = a
                break
            if operand is None:
                d = resolve_dir(d, "~")                 # cd with no operand -> HOME
            elif operand == "-" or re.fullmatch(r"[+-]\d+", operand):
                d = None                                # previous dir, or pushd stack rotation: unknown
            else:
                nd = resolve_dir(d, operand)
                if nd is None and literal_guarded(operand):   # cd $PWD/tools, cd $(pwd)/.claude (R-D008-12 B12-1)
                    raise Bad("B5", f"{prog} enters a guarded directory named with a variable or substitution "
                                    f"({operand}); the guard cannot track writes made there")
                d = nd
            continue
        if prog == "popd":
            d = None
            continue
        if prog == "eval":
            raise Bad("G0", "eval runs text that is put together at run time, so the guard cannot read it")
        if prog in SHELLS and "-c" in args[1:]:
            i = args.index("-c", 1)
            if i + 1 < len(args) and depth < 3:
                shell_checks(args[i + 1], d, depth + 1)
            continue
        if prog == "find":
            find_checks(args, d)
        command_checks(prog, args, d)


def find_checks(args, d):
    """find runs commands (-exec and similar) and removes files (-delete): check both (R-D008-2 N-3, N-5)."""
    starts, i = [], 1
    while i < len(args) and not args[i].startswith(("-", "(", "!", ")")):
        starts.append(args[i])
        i += 1
    rest, j = args[i:], 0
    targets = [p for p in (target_path(d, s) for s in (starts or ["."])) if p]
    while j < len(rest):
        if rest[j] in ("-exec", "-execdir", "-ok", "-okdir"):
            k, sub = j + 1, []
            while k < len(rest) and rest[k] not in (";", "+", "\;"):
                sub.append(rest[k])
                k += 1
            sub, bare = strip_wrappers(sub)
            if bare:
                raise Bad("B8", "find -exec env prints the whole environment, including credentials")
            if sub:
                if any(c in sub[0] for c in "$`"):
                    raise Bad("G0", f"find runs a computed command {sub[0]}")
                prog = os.path.basename(sub[0])
                CALL.append((prog, sub))
                command_checks(prog, sub, d)
                if prog in WRITE_COMMANDS | DEST_COMMANDS | IN_PLACE_COMMANDS:
                    for p in targets:
                        z = write_guarded(p, remove=True)
                        if z:
                            raise Bad("B5", f"find {p} -exec {prog} writes into {z}")
            j = k + 1
        else:
            j += 1
    if "-delete" in rest:
        for p in targets:
            z = write_guarded(p, remove=True)
            if z:
                raise Bad("B5", f"find {p} -delete removes files in {z}")


PS_VALUE_OPTS = {"-p", "-o", "-O", "-u", "-U", "-g", "-G", "-t", "-C", "-q", "-s", "-k", "--pid", "--ppid",
                 "--format", "--sort", "--user", "--group"}


def command_checks(prog, args, d):
    if prog in ACCOUNT_CLIS or any("@anthropic-ai/claude-code" in a for a in args):
        raise Bad("B7", f"'{prog}' acts with the account's credentials")
    if prog.startswith("git-"):
        raise Bad("B11", f"'{prog}' is a git helper program, which runs outside the guard's git checks")
    if prog == "printenv":
        raise Bad("B8", "printenv prints the environment, including credentials")
    if prog in SET_BUILTINS:
        after_v = False
        for a in args[1:]:
            name = a.split("=", 1)[0].split("+", 1)[0]
            if after_v or prog != "printf":
                if PROTECTED_VARS.match(name):
                    raise Bad("B11", f"{prog} sets or reads {name}, which changes where programs read their settings")
            after_v = (a == "-v")
    rest = args[1:]
    names = [x for x in rest if not x.startswith(("-", "+"))]
    flags = set("".join(x[1:] for x in rest if re.fullmatch(r"[-+][A-Za-z]+", x)))   # -px counts as -p and -x
    if prog == "set" and not rest:
        raise Bad("B8", "set without arguments prints every variable, credentials included")
    if prog == "export" and (not names or "p" in flags):
        raise Bad("B8", f"export {' '.join(rest)} without names (or with p) prints exported variables")
    if prog in ("declare", "typeset", "local", "readonly") and (not names or "p" in flags):
        raise Bad("B8", f"{prog} {' '.join(rest)} prints variables, credentials included")
    if prog == "compgen" and any(x.startswith("-A") or x in ("-v", "-e") for x in rest):
        raise Bad("B8", "compgen lists variables")
    if prog == "ps":
        skip = False
        for x in rest:
            if skip:
                skip = False
            elif x in PS_VALUE_OPTS:
                skip = True
            elif not x.startswith("-") and re.fullmatch(r"[A-Za-z]+", x) and "e" in x:
                raise Bad("B8", f"ps with the BSD option {x} prints process environments")
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
    written, remove = [], prog in ("rm", "rmdir", "mv", "truncate", "shred")
    plain = [a for a in args[1:] if not a.startswith("-")]
    if prog in DEST_COMMANDS:
        tdir = target_dirs(prog, args)            # -t DIR in any spelling, incl. a short cluster (B14-1)
        if tdir:                                  # with -t, every plain arg is a SOURCE and DIR the destination
            dests, srcs, written = tdir, [a for a in plain if a not in tdir], list(tdir)
        else:                                     # no -t: the last plain arg is the destination
            dests, srcs, written = plain[-1:], plain[:-1], list(plain[-1:])
        for dr in dests:                          # a copy INTO a directory writes dir/basename(source):
            for s in srcs:                        # cp -vt /etc /tmp/gitconfig -> /etc/gitconfig (B14-1), while a
                written.append(os.path.join(dr, os.path.basename(s.rstrip("/") or s)))  # tools/ source copied
                                                  # OUT with -t to /tmp stays allowed (R-D008-15 C15-1)
    elif prog in WRITE_COMMANDS:
        written = plain
    elif prog in IN_PLACE_COMMANDS and inplace_flag(args):
        written = plain
    elif prog == "dd":
        written = [a.split("=", 1)[1] for a in args[1:] if a.startswith("of=")]
    for a in written:
        z = guarded_write(d, a, remove=remove)
        if z:
            raise Bad("B5", f"{prog} writes into {z} ({a})")
    if prog == "git":
        git_checks(args, d)
    if prog in COPY_LIKE or prog == "mv":
        library_copy_checks(prog, args, d)
    if prog in COPY_LIKE:
        for a in args[1:]:
            if a.startswith("-"):
                continue
            parts = [x for x in a.replace("\\", "/").split("/") if x]
            hit = any(fnmatch.fnmatch(".claude", c) or fnmatch.fnmatch(".git", c) for c in parts) \
                or (len(parts) >= 2 and parts[-2:] == [".config", "git"])
            if hit:
                raise Bad("B5", f"{prog} moves a .claude, .git or git-config path ({a}); copying guard or git "
                                "internals into place is a guard swap (R-D008-6 B-1)")
    already = prog in DEST_COMMANDS or prog in WRITE_COMMANDS or prog in IN_PLACE_COMMANDS or prog in ("dd", "git")
    reader = prog in PURE_READERS \
        or (prog == "sed" and not inplace_flag(args)) \
        or (prog == "sort" and not (any(a == "-o" or a.startswith(("-o", "--output")) for a in args[1:])
                                    or cluster_opt_value(args, "o"))) \
        or (prog == "xxd" and not any(a in ("-r", "--revert") for a in args[1:])) \
        or (prog == "yq" and not any(a == "--inplace" or (a.startswith("-") and not a.startswith("--")
                                     and "i" in a) for a in args[1:])) \
        or (prog in AWKS and not any("inplace" in a for a in args[1:]))
    if not already and not reader:
        # An interpreter's SCRIPT argument under tools/ is "running", so it is exempt; every other argument it
        # names (an output file, a module data path) still goes through the catch-all, and a script it names under
        # .claude/ or .git/ is not exempt (R-D008-9 B9-1: the exemption must not cover those zones).
        exempt = None
        if prog in INTERPRETERS:
            # For a shell, -s makes standard input the program and -i goes interactive, so a following tools/ path
            # is an argument to that stdin program, not a script being run (R-D008-11 B11-3). The allow list is one
            # set across interpreters, so drop those two for the shells; the rest are no-value, no-code flags.
            safe = SAFE_INTERP_OPTS - {"-s", "-i"} if prog in SHELL_FAMILY else SAFE_INTERP_OPTS
            j = 1
            while j < len(args) and args[j].startswith("-") and args[j] != "-":
                if args[j] in safe:               # a no-value flag: keep scanning for the script argument
                    j += 1
                    continue
                j = None                          # -m, -c, -e, -W, a shell -s/-i, an attached -mFOO/-cCODE, a
                break                             # value-taker: the thing run is not a tools/ script, no exemption
            if j is not None and j < len(args) and not args[j].startswith("-"):
                sp = target_path(d, args[j])
                tools = os.path.realpath(os.path.join(ROOT, "tools"))
                if sp and (os.path.realpath(sp) == tools or os.path.realpath(sp).startswith(tools + os.sep)):
                    exempt = j
        for k, a in enumerate(args[1:], 1):
            if k == exempt:
                continue
            for cand in ([a] if not a.startswith("-") else ([a.split("=", 1)[1]] if "=" in a else
                                                             ([a[2:]] if len(a) > 2 and a[1] != "-" else []))):
                if not cand:
                    continue
                z = guarded_write(d, cand)   # strict zones AND the live tools/ dir (R-D008-8 B8-1); a guarded
                if z:                        # component behind a variable or substitution too (R-D008-11 B11-2)
                    raise Bad("B5", f"{prog} names {z} ({a}); only a reader (cat, grep, sed -n, ...) or an "
                                    "interpreter running a tools/ script may name it; a write uses a listed writer "
                                    "or a redirection the guard checks")


def git_checks(args, d):
    """git through allow lists (R-D008-2 N-1, N-2): global options, -c settings and subcommands must be listed."""
    e, i, cfg = d, 1, []
    while i < len(args):
        a = args[i]
        if a == "-C" and i + 1 < len(args):
            e = resolve_dir(e, args[i + 1])
            i += 2
        elif a == "-c" and i + 1 < len(args):
            if not GIT_SAFE_KEYS.match(args[i + 1].split("=", 1)[0].strip()):
                raise Bad("B11", f"git -c {args[i + 1][:80]}: not a listed setting")
            cfg.append(args[i + 1])
            i += 2
        elif a in GIT_GLOBAL_FLAGS:
            i += 1
        elif a.startswith("-"):
            raise Bad("B11", f"git {a}: not a listed global option (--git-dir, --work-tree, --config-env and "
                             "similar change what git reads)")
        else:
            break
    if i >= len(args):
        return
    sub, rest = args[i], args[i + 1:]
    if sub not in GIT_SUBCOMMANDS:
        raise Bad("B11", f"git {sub}: not a listed git subcommand; the guard does not resolve aliases, so an alias "
                         "is denied too")
    base = e if e is not None else d

    def out_guarded(cand):
        return guarded_write(base, cand)

    # Named output files/directories (R-D008-8 B8-2). --output[=] and --output-directory[=] write a file that B4's
    # in-place checks do not see, on any subcommand (show/log/diff/format-patch); the tree writers also take a
    # short -o. The short-attached value is pulled off non-greedily (R-D008-10 B10-1: a greedy match turned
    # -otools/x into ls/x and let the write through).
    for j2, a2 in enumerate(rest):
        outp = None
        if a2.startswith(("--output=", "--output-directory=")):
            outp = a2.split("=", 1)[1]
        elif a2 in ("--output", "--output-directory") and j2 + 1 < len(rest):
            outp = rest[j2 + 1]
        elif sub in ("archive", "format-patch", "bundle") and re.fullmatch(r"-[A-Za-z]*o", a2) and j2 + 1 < len(rest):
            outp = rest[j2 + 1]                        # -o / -ko ... : value is the next word (only these take an
        elif sub in ("archive", "format-patch", "bundle") and a2.startswith("-") and not a2.startswith("--"):
            m = re.match(r"-[A-Za-z]*?o(.+)$", a2)     # output path; clone -o is a remote name, worktree -b a branch)
            outp = m.group(1) if m else None           # -o<path> / -ko<path> : value attached, matched non-greedily
        if outp:
            z2 = out_guarded(outp)
            if z2:
                raise Bad("B5", f"git {sub} writes its output into {z2} ({outp})")
    # Tree/working-file writers create files at a location. Rather than parse each one's destination slots (which
    # regressed in R-D008-9 and again in R-D008-10 B10-2), deny coarsely: the directory the command runs in, and
    # every path argument or --opt=value it names, must stay out of the guarded zones. There is never a reason to
    # create a tree inside .claude/, tools/ or .git/, so over-denial here is a visible, explained denial, not a
    # hole; a -C directory the guard cannot resolve is denied for the same reason.
    if sub in GIT_TREE_WRITE:
        if e is None:
            raise Bad("B5", f"git {sub} with a -C directory the guard cannot resolve (written with a variable); it "
                            "cannot confirm the tree is not created inside a guarded zone")
        bz = write_guarded(base)
        if bz:
            raise Bad("B5", f"git {sub} runs inside {bz}; it would create files there")
        for a2 in rest:
            cand = a2.split("=", 1)[1] if a2.startswith("--") and "=" in a2 else (None if a2.startswith("-") else a2)
            if cand:
                z2 = out_guarded(cand)
                if z2:
                    raise Bad("B5", f"git {sub} writes a tree or file into {z2} ({cand})")
    for x in rest:
        if x.split("=", 1)[0] in GIT_SUB_OPT_DENY or (sub == "clone" and x in ("-u", "-c")):
            raise Bad("B11", f"git {sub} {x} sets configuration or runs another program")
    if sub in ("clone", "fetch", "pull", "remote", "worktree"):
        library_git_checks(sub, rest, e)
    where = "an unknown directory (written with a variable or not literally)" if e is None else e
    if sub == "push":
        if cfg:
            raise Bad("B11", "git -c on a push: a setting given here is not seen by the guard's address check")
        push_checks(rest, e)
    if sub == "config":
        config_checks(rest, e)
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
    if sub == "reflog" and rest[:1] and rest[0] in ("expire", "delete"):
        raise Bad("B4", f"git reflog {rest[0]} in {where} destroys the record of earlier states")
    if sub in ("gc", "prune") and any(x.startswith("--prune") or x == "--expire" for x in rest + [sub]):
        raise Bad("B4", f"git {sub} with pruning in {where} destroys the record of earlier states")
    if sub in LIVE_BANNED_GIT:
        raise Bad("B4", f"git {sub} in {where}")
    if sub == "branch" and any(x in ("-f", "--force", "-D", "-d", "--delete", "-m", "-M", "--move", "-c", "-C",
                                     "--copy") for x in rest):
        raise Bad("B4", f"git branch {' '.join(rest)[:60]} in {where}")
    if sub == "remote" and rest[:1] and rest[0] in ("add", "set-url", "remove", "rm", "rename", "set-head",
                                                    "set-branches"):
        raise Bad("B4", f"git remote {rest[0]} in {where} would change what this tree fetches")
    if sub == "config" and not any(x in ("--get", "--get-all", "--get-regexp", "--list", "-l", "--show-origin")
                                   for x in rest) and len([x for x in rest if not x.startswith("-")]) >= 2:
        raise Bad("B4", f"git config {' '.join(rest)[:60]} in {where}: a setting here would change what later git "
                        "commands in this tree run")


def config_checks(rest, e):
    """B11: git config writes only of listed settings, and never to global, system or other files."""
    reads = {"--get", "--get-all", "--get-regexp", "--get-urlmatch", "--list", "-l", "--show-origin",
             "--show-scope", "--get-color", "--get-colorbool"}
    words = [x for x in rest if not x.startswith("-")]
    if words[:1] in (["get"], ["list"]) or any(x.split("=", 1)[0] in reads for x in rest):
        return
    if words[:1] in (["set"], ["unset"], ["rename-section"], ["remove-section"], ["edit"]):
        words = words[1:]
    write = bool(words[1:]) or any(x.split("=", 1)[0] in ("--add", "--replace-all", "--unset", "--unset-all",
                                                           "--rename-section", "--remove-section", "--edit", "-e")
                                   for x in rest)
    if not write:
        return
    if any(x.split("=", 1)[0] in ("--global", "--system", "--file", "-f", "--blob", "--worktree") for x in rest):
        raise Bad("B11", f"git config {' '.join(rest)[:80]} writes outside this repository's own settings")
    if not (words and GIT_SAFE_KEYS.match(words[0])):
        raise Bad("B11", f"git config {' '.join(rest)[:80]}: only listed settings may be written")


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
        if name in ("--tags", "--follow-tags"):
            raise Bad("B3", f"git push {f} pushes tags, refs outside the claude/ branches")
        if name in ("--receive-pack", "--exec"):
            raise Bad("B3", f"git push {f} runs another program on the remote")
    if not pos:
        raise Bad("B3", "git push names no remote and no branch")
    remote, refspecs = pos[0], pos[1:]
    if e is None:
        raise Bad("B3", "git push from a directory the guard cannot tell, so its remote cannot be checked")
    if "://" in remote or remote.startswith(("git@", ".", "~")) or "/" in remote or ":" in remote:
        raise Bad("B3", f"git push to the address '{remote}': push only to a named remote, whose push address the "
                        "guard resolves as git will (git rewrites a written address too; R-D008-2 N-2)")
    # the push URLs, after pushurl, insteadOf and pushInsteadOf (R-D008-1 B-1)
    r = git("remote", "get-url", "--push", "--all", remote, cwd=e)
    urls = r.stdout.split() if r.returncode == 0 else []
    bad = [u for u in urls if not DEVOS_REMOTE.fullmatch(u)]
    if not urls or bad:
        raise Bad("B3", f"git push to remote '{remote}', whose push address is "
                        f"{', '.join(bad or ['unknown'])}, not batuhanozgun/devos")
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
    PUSHES.append((e, remote, refspecs))   # its commits are leak-checked once the whole call is read (L2, L1)


# ---------------------------------------------------------------- tool rules

def file_checks(name, args):
    key = FILE_WRITE_TOOLS.get(name) or FILE_READ_TOOLS.get(name)
    p = str(args.get(key) or "")
    if not p:
        return ("T1", f"{name} without a path stays in the working directory")
    p = os.path.expanduser(p)   # ~ expands as the shell would, so the file tools and the shell agree (S5)
    p = os.path.join(ROOT, p) if not os.path.isabs(p) else p
    for v in credential_values():
        if within(p, v):
            raise Bad("F4", f"{name} on the session's token file or messaging socket")
    if any(x in p for x in CREDENTIAL_PATHS):
        raise Bad("F4", f"{name} on a credential store ({p})")
    if name in FILE_READ_TOOLS:
        return ("T1", f"{name} is a read")
    z = write_guarded(p)   # the same guarded places the shell write-ban uses, so the two cannot drift (R-D008-2 N-4)
    if z:
        rule = ("F5" if "fingerprint store" in z else "F1" if ("guard files" in z or "tools/" in z) else
                "F2" if ".git/" in z else "F4" if "decision log" in z else "F3")
        raise Bad(rule, f"{name} {p}: {z}")
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
    tool = os.path.join(ROOT, "tools", "merge_gate.py")
    try:
        r = subprocess.run([sys.executable, tool, "--pr", str(int(pr)), "--head", sha], cwd=ROOT,
                           capture_output=True, text=True, timeout=MERGE_GATE_TIMEOUT)
    except subprocess.TimeoutExpired:
        raise Bad("M7", f"the merge gate did not finish within {MERGE_GATE_TIMEOUT} seconds; failing closed")
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
    elif rev in ("HEAD", "@"):
        return False
    elif rev == git("rev-parse", "--abbrev-ref", "HEAD").stdout.strip():
        ref = rev
    else:
        return False
    if git("fetch", "-q", "origin", ref).returncode != 0:
        return False
    return git("cat-file", "-e", "FETCH_HEAD:.claude/settings.json").returncode == 0


def _strings(v):
    if isinstance(v, str):
        yield v
    elif isinstance(v, dict):
        for x in v.values():
            yield from _strings(x)
    elif isinstance(v, (list, tuple)):
        for x in v:
            yield from _strings(x)


def github_checks(tool, args):
    if tool in BLOCKED_GITHUB:
        raise Bad("M2", f"'{tool}' is not allowed for DevOS sessions")
    # The library is read only through its one clone, which the leak check is tied to (W-C00-14): a GitHub tool
    # that names it, a read or a search included, would bring its text into the session with no store behind it.
    if any(LIBRARY_NAME.search(s) for s in _strings(args)):
        raise Bad("L3", f"GitHub tool '{tool}' names the research library; it is read only through its clone")
    if tool in READ_ONLY_GITHUB or tool.startswith(READ_ONLY_GITHUB_PREFIXES):
        return ("M2", "a GitHub read")
    if tool in REPOLESS_GITHUB_ALLOWED and "repo" not in args and "owner" not in args:
        return ("M2", "a review-thread tool without a repository field")
    owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
    if (owner, repo) not in WRITE_REPOS:
        raise Bad("M2", f"GitHub write tool '{tool}' targets {owner}/{repo}, which DevOS may not write")
    leak_tool_checks(tool, args)     # before every other answer, the merge's included (W-C00-14)
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


# ---------------------------------------------------------------- leak check (W-C00-14)
# Plan 0.5 item 3, K-9 item 5 and 6.7: before a public write the added text is compared with fingerprints of the
# private research library, and a long match stops the write (L1). A fingerprint is a salted 64-bit BLAKE2b hash of
# a run of SHINGLE_WORDS normalised words: case folded, the Turkish dotted and dotless i and every diacritic folded,
# words being runs of letters and digits, so punctuation, Markdown and line breaks do not matter.
# tools/leak_fingerprints.py hashes every such run at the library clone's HEAD with a fresh random salt, drops the
# runs that also occur in devos's origin/main tree, and writes the rest sorted to LEAK_STORE; the guard looks them up
# by binary search in the mapped file. The store holds hashes, the salt and counts, never text. The same routes are
# checked for the service names of tools/check_service_names.sh (OI-012, D-013); a line already on origin/main
# does not count. Neither the matched text nor a fingerprint reaches the decision log, a denial or the repository:
# the L details carry places and counts only, and summary() withholds any call text that matches.

CALL, PUSHES = [], []        # the commands and the pushes of the Bash call being decided (L2, L1)
GIT_READ_SUBS = {"status", "log", "show", "diff", "rev-parse", "rev-list", "ls-remote", "ls-files", "ls-tree",
                 "cat-file", "describe", "show-ref", "for-each-ref", "merge-base", "diff-tree", "shortlog",
                 "name-rev", "blame", "grep", "version", "help"}
PUSH_COMPANIONS = PURE_READERS | {"cd", "pushd", "echo", "printf", "true", ":", "sleep"}
CLONE_VALUE_OPTS = {"-o", "--origin", "-b", "--branch", "--depth", "--reference", "--reference-if-able", "--filter",
                    "--shallow-since", "--shallow-exclude", "-j", "--jobs", "--bundle-uri", "--server-option",
                    "--ref-format", "--separate-git-dir", "--template", "-c", "--config", "-u", "--upload-pack"}


def leak_words(text):
    t = unicodedata.normalize("NFKD", text.translate(TR_FOLD).casefold())
    return re.findall(r"[^\W_]+", "".join(c for c in t if not unicodedata.combining(c)))


def leak_hashes(words, salt):
    """The fingerprint of every run of SHINGLE_WORDS words, in the order of the run's first word."""
    n = SHINGLE_WORDS
    return [int.from_bytes(hashlib.blake2b(" ".join(words[i:i + n]).encode(), digest_size=8, key=salt).digest(),
                           "little") for i in range(len(words) - n + 1)]


@lru_cache(maxsize=1)
def read_store():
    """(meta, salt, sorted fingerprints) of LEAK_STORE; None when it is absent; ValueError when it is unreadable."""
    meta_p, fp_p = os.path.join(LEAK_STORE, "meta.json"), os.path.join(LEAK_STORE, "fingerprints.bin")
    if not os.path.lexists(meta_p) and not os.path.lexists(fp_p):
        return None
    try:
        with open(meta_p) as f:
            meta = json.load(f)
        size, salt = os.path.getsize(fp_p), bytes.fromhex(meta["salt"])
        ok = (meta.get("version") == STORE_VERSION and meta.get("shingle_words") == SHINGLE_WORDS and
              meta.get("byteorder") == sys.byteorder and size == 8 * int(meta["count"]) and len(salt) >= 16)
    except (OSError, ValueError, KeyError, TypeError, AttributeError) as exc:
        raise ValueError(f"the fingerprint store {LEAK_STORE} cannot be read ({type(exc).__name__})")
    if not ok:
        raise ValueError(f"the fingerprint store {LEAK_STORE} does not fit this guard (version, run length, byte "
                         "order or size)")
    if not size:
        return meta, salt, ()
    with open(fp_p, "rb") as f:
        return meta, salt, memoryview(mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ)).cast("Q")


def library_head():
    """The HEAD of the library clone; None when no clone exists; "" when something is there but is not a clone
    whose HEAD can be read."""
    if not os.path.lexists(LIBRARY_DIR):
        return None
    try:
        r = git("rev-parse", "--show-toplevel", "HEAD", cwd=LIBRARY_DIR)
    except (OSError, subprocess.SubprocessError):
        return ""
    out = r.stdout.split()
    ok = r.returncode == 0 and len(out) == 2 and os.path.realpath(out[0]) == os.path.realpath(LIBRARY_DIR)
    return out[1] if ok else ""


def leak_state():
    """The store public writes are checked against, or None when neither a library clone nor a store exists
    (nothing to compare with). Fails closed (L1) when the store is unreadable, or missing or stale while the
    clone exists. Stale: the clone's HEAD is not the one the store was built from."""
    head = library_head()
    try:
        store = read_store()
    except ValueError as exc:
        raise Bad("L1", f"{exc}; every public write fails closed until python3 tools/leak_fingerprints.py build "
                        "rebuilds it")
    if store is None:
        if head is None:
            return None
        raise Bad("L1", f"a library clone exists at {LIBRARY_DIR} but the fingerprint store {LEAK_STORE} is missing; "
                        "every public write fails closed until python3 tools/leak_fingerprints.py build builds it")
    meta = store[0]
    if head is not None and (head != meta.get("library_head") or
                             os.path.realpath(LIBRARY_DIR) != meta.get("library_dir")):
        raise Bad("L1", f"the fingerprint store is stale: it was built from library HEAD "
                        f"{str(meta.get('library_head'))[:12]}, the clone at {LIBRARY_DIR} is at "
                        f"{head[:12] or 'an unreadable HEAD'}; every public write fails closed until python3 "
                        "tools/leak_fingerprints.py build rebuilds it")
    return store


def service_terms(settings_text):
    """The terms tools/check_service_names.sh derives from a settings file's deny list, by the same rules
    (tools/test_tool_allowlist.sh checks that both give the same terms). They are never written anywhere."""
    out = set()
    for n in json.loads(settings_text)["permissions"]["deny"]:
        n = n.replace("mcp__", "")
        for part in n.replace("_-_", "_").split("_"):
            if len(part) >= 4 and part.lower() not in SERVICE_GENERIC:
                out.add(part)
        out.add(n.replace("_", " "))
    return sorted(out)


@lru_cache(maxsize=1)
def service_term_list():
    """The terms, derived at run time from SERVICE_REV. DEVOS_SERVICE_NAMES_EXTRA (tests only) adds the terms of a
    settings-shaped file of fake names."""
    r = git("show", SERVICE_REV + ":.claude/settings.json")
    if r.returncode == 0:
        terms = service_terms(r.stdout)
        if not terms:
            raise ValueError("no service names were derived")
    elif git("rev-parse", "--is-shallow-repository").stdout.strip() == "false" and \
            git("cat-file", "-e", SERVICE_REV + "^{commit}").returncode != 0:
        terms = []       # a complete repository without devos's history (a test fixture): no names to derive
    else:
        raise ValueError(f"the service names cannot be derived (git show {SERVICE_REV} failed)")
    if os.environ.get("DEVOS_SERVICE_NAMES_EXTRA"):
        with open(os.environ["DEVOS_SERVICE_NAMES_EXTRA"]) as f:
            terms += service_terms(f.read())
    return terms


@lru_cache(maxsize=1)
def service_pattern():
    """Whole words in any case, as the script's git grep -i -E with \\b on both sides."""
    terms = service_term_list()
    return re.compile(r"\b(" + "|".join(re.escape(t) for t in terms) + r")\b" if terms else r"(?!)", re.I)


def fingerprint_hits(text, store):
    if not store:
        return 0
    _, salt, view = store
    hits = 0
    for h in set(leak_hashes(leak_words(text), salt)):
        i = bisect.bisect_left(view, h)
        hits += i < len(view) and view[i] == h
    return hits


def lines_on_main(repo, ref, lines):
    """Those of lines that are already, verbatim, a whole line in ref's tree (text on origin/main)."""
    if not ref or not lines or len(lines) > 200:
        return set()
    r = git("grep", "-h", "-I", "-F", "--no-color", *[x for l in lines for x in ("-e", l)], ref, "--",
            cwd=repo, timeout=30)       # substring matches; only whole-line equality counts below
    return set(r.stdout.splitlines()) & set(lines) if r.returncode == 0 else set()


def service_hits(text, repo, ref):
    pat = service_pattern()
    lines = list(dict.fromkeys(l for l in text.splitlines() if pat.search(l)))
    return len(set(lines) - lines_on_main(repo, ref, lines)) if lines else 0


def withheld(text):
    """True when text matches the library fingerprints or names a service, so it is not logged or shown."""
    if not text:
        return False
    try:
        store = read_store()
    except ValueError:
        store = None
    try:
        return bool(fingerprint_hits(text, store) or service_pattern().search(text))
    except (OSError, ValueError, subprocess.SubprocessError):
        return False


def leak_found(blocks, store, repo, ref):
    """The places (labels) whose text matches, each with its counts; never the text."""
    found = []
    for label, text in blocks:
        fp, sv = fingerprint_hits(text, store), service_hits(text, repo, ref)
        if fp or sv:
            what = [f"{fp} run(s) of {SHINGLE_WORDS} words matching the library" if fp else "",
                    f"{sv} line(s) naming a service" if sv else ""]
            found.append(("a place whose name is withheld" if withheld(label) else label) + ": " +
                         " and ".join(w for w in what if w))
    return found


def leak_deny(what, found):
    more = f"; and {len(found) - 6} more" if len(found) > 6 else ""
    raise Bad("L1", f"{'the write' if withheld(what) else what} would publish text that matches the private "
                    f"library or names a service: {'; '.join(found[:6])}{more} (the text itself is not shown)")


def string_fields(v, path=""):
    """(field path, string) for every string value in a tool input, nested lists, objects and JSON text included."""
    if isinstance(v, str):
        yield path or "(input)", v
        if v[:1] in ("[", "{"):
            try:
                yield from string_fields(json.loads(v), path + "(json)")
            except ValueError:
                pass
    elif isinstance(v, dict):
        for k, x in v.items():
            yield from string_fields(x, f"{path}.{k}" if path else str(k))
    elif isinstance(v, list):
        for i, x in enumerate(v):
            yield from string_fields(x, f"{path}[{i}]")


def leak_tool_checks(tool, args):
    """L1 for a GitHub write to devos: every string field it carries."""
    try:
        store = leak_state()
        found = leak_found([("field " + p, s) for p, s in string_fields(args)], store, ROOT, "refs/remotes/origin/main")
    except (OSError, ValueError, subprocess.SubprocessError) as exc:
        raise Bad("L1", f"the leak check could not run ({type(exc).__name__}); failing closed")
    if found:
        leak_deny(f"GitHub write '{tool}' to devos", found)


def git_sub(args):
    i = 1
    while i < len(args):
        if args[i] in ("-C", "-c"):
            i += 2
        elif args[i].startswith("-"):
            i += 1
        else:
            return args[i]
    return None


def push_alone():
    """L2: the push is the only command of its call that could create commits or move refs, so the commits the
    leak check reads are the commits git pushes."""
    if len(PUSHES) > 1:
        raise Bad("L2", "the call runs more than one git push")
    for prog, args in CALL:
        sub = git_sub(args) if prog == "git" else None
        if (prog == "git" and (sub is None or sub == "push" or sub in GIT_READ_SUBS)) or \
                (prog != "git" and prog in PUSH_COMPANIONS):
            continue
        raise Bad("L2", f"the push shares its Bash call with {'git ' + sub if sub else repr(prog)}, which can create "
                        "commits or move refs, or which the guard cannot rule out doing so")


def pushed_blocks(e, shas, ref):
    """(label, text) for every commit reachable from shas and not from ref: its message, its paths and the lines
    its diff adds (a merge against its first parent). Returns (blocks, number of commits)."""
    r = git("--no-replace-objects", "-c", "core.quotepath=false", "log", "--no-color", "--no-ext-diff",
            "--no-textconv", "--no-renames", "--text", "--root", "--no-show-signature", "--diff-merges=first-parent",
            "--src-prefix=a/", "--dst-prefix=b/", "-p", "--format=%x1e%H%x1f%B%x1f", *shas,
            *(["--not", ref] if ref else []), "--", cwd=e, timeout=120)
    if r.returncode != 0:
        raise ValueError("git log of the pushed commits failed")
    blocks, recs = [], r.stdout.split("\x1e")[1:]
    for rec in recs:
        sha, msg, patch = (rec.split("\x1f", 2) + ["", ""])[:3]
        c = "commit " + sha.strip()[:12]
        files, cur, hunk = {}, None, False
        for line in patch.split("\n"):
            if line.startswith("diff --git "):
                cur, hunk = line[len("diff --git "):], False
                files.setdefault(cur, [])
            elif line.startswith("@@") and cur is not None:
                hunk = True
            elif hunk and line.startswith("+"):
                files[cur].append(line[1:])
        blocks += [(c + " message", msg), (c + " paths", "\n".join(files))]
        blocks += [(f"{c} lines added to {p.rsplit(' b/', 1)[-1]}", "\n".join(a)) for p, a in files.items() if a]
    return blocks, len(recs)


def push_leak_checks():
    """L1 for the one push of the call: the branch names and every commit it would publish. Returns the detail."""
    e, remote, refspecs = PUSHES[0]
    try:
        store = leak_state()
        ref = f"refs/remotes/{remote}/main"
        if git("rev-parse", "-q", "--verify", ref + "^{commit}", cwd=e).returncode != 0:
            ref = None                        # no origin/main here: every commit of the branch is read
        shas = []
        for s in refspecs:
            r = git("rev-parse", "-q", "--verify", s.split(":", 1)[0] + "^{commit}", cwd=e)
            if r.returncode == 0:
                shas.append(r.stdout.strip())
        blocks, n = pushed_blocks(e, shas, ref) if shas else ([], 0)
        found = leak_found([("the pushed branch names", "\n".join(refspecs))] + blocks, store, e, ref)
    except (OSError, ValueError, subprocess.SubprocessError) as exc:
        raise Bad("L1", f"the leak check could not read the push ({type(exc).__name__}: {exc}); failing closed")
    if found:
        leak_deny(f"the push from {e}", found)
    if not shas:
        return "the pushed source names no commit here, so git will refuse it; the branch names were checked"
    return (f"the push's {n} commit(s) beyond {ref or 'the root (no origin/main ref)'} carry no library match and no "
            "service name" + ("" if store else " (no library clone and no store: service names only)"))


def names_library(arg, base):
    """True when a git argument names the research library: its name in a URL or path, or a path inside the clone."""
    if LIBRARY_NAME.search(arg):
        return True
    v = arg.split("=", 1)[1] if arg.startswith("--") and "=" in arg else arg
    v = v[len("file://"):] if v.startswith("file://") else v
    p = target_path(base, v) if v and not v.startswith("-") else None
    return bool(p) and within(p, LIBRARY_DIR)


def library_git_checks(sub, rest, e):
    """L3: the library is cloned only to LIBRARY_DIR; no other repository fetches it or names it as a remote, and
    the clone is not checked out elsewhere as a worktree."""
    if sub == "clone":
        pos, i = [], 0
        while i < len(rest):
            if rest[i] in CLONE_VALUE_OPTS:
                i += 2
                continue
            if not rest[i].startswith("-"):
                pos.append(rest[i])
            i += 1
        dst_arg = pos[1] if len(pos) > 1 else None
        if any(names_library(a, e) for a in rest if a != dst_arg):
            dst = dst_arg or re.sub(r"(/\.git|\.git)?/*$", "", pos[0] if pos else "").rsplit("/", 1)[-1]
            p = target_path(e, dst) if dst else None
            if not p or os.path.realpath(p) != os.path.realpath(LIBRARY_DIR):
                raise Bad("L3", f"git clone of the research library to {dst or 'an unknown place'}, not {LIBRARY_DIR}")
        return
    if e is not None and within(e, LIBRARY_DIR):
        if sub == "worktree" and "add" in rest:
            raise Bad("L3", "git worktree add in the library clone checks the library out in another place")
        return
    if any(names_library(a, e) for a in rest):
        raise Bad("L3", f"git {sub} names the research library from {e or 'an unknown directory'}, outside its one "
                        f"clone {LIBRARY_DIR}")
    if sub in ("fetch", "pull") and e is not None:
        r = git("config", "--get-regexp", r"^remote\..*\.url$", cwd=e)
        if r.returncode == 0 and any(names_library(l.split(" ", 1)[-1], e) for l in r.stdout.splitlines()):
            raise Bad("L3", f"git {sub} in {e}, whose remote is the research library: a second clone of it")


def library_copy_checks(prog, args, d):
    """L3: the clone itself (the library directory or its .git) is not copied, archived or moved elsewhere."""
    plain = [a for a in args[1:] if not a.startswith("-")]
    if prog in ("mv", "cp", "install", "ln"):
        tdir = target_dirs(prog, args)
        srcs = [a for a in plain if a not in tdir] if tdir else plain[:-1]
    elif prog in ("rsync", "scp"):
        srcs = plain[:-1]
    else:
        srcs = plain
    lib = os.path.realpath(LIBRARY_DIR)
    for a in srcs:
        p = target_path(d, a)
        if (p and (os.path.realpath(p) == lib or within(p, os.path.join(lib, ".git")))) or \
                re.search(r"(^|/)agentic-os-search/*(\.git/*)?$", a, re.I):
            raise Bad("L3", f"{prog} copies or moves the research library clone ({a}); it stays at {LIBRARY_DIR} only")


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
    if any(isinstance(v, str) and "\x00" in v for v in args.values()):
        return "deny", "G0", "the tool input contains a NUL byte, which no real path or command needs"
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
            sp = str(args.get("scriptPath") or "")
            if sp:
                sp = sp if os.path.isabs(sp) else os.path.join(cwd, sp)
                if not os.path.isfile(sp):
                    raise Bad("T3", f"the workflow script {sp} cannot be read, so it cannot be inspected")
                with open(sp, errors="replace") as f:
                    text += f.read()
            if not text.strip():
                raise Bad("T3", "a workflow without its script text (a saved or built-in name) cannot be inspected")
            if re.search(r"isolation", text, re.I) or re.search(r"[\"'`](worktree|remote)[\"'`]", text):
                raise Bad("T3", "the workflow script names isolation, or a quoted 'worktree' or 'remote' value")
            if re.search(r"\[\s*[\"'`][^\]]*\]\s*:", text):
                raise Bad("T3", "the workflow script builds an object key at run time, which the guard cannot read")
            return "allow", "T3", "an in-process workflow"
        if name == "Bash":
            if args.get("dangerouslyDisableSandbox"):
                raise Bad("B10", "dangerouslyDisableSandbox is set")
            del CALL[:], PUSHES[:]
            shell_checks(str(args.get("command", "")), cwd)
            if PUSHES:
                push_alone()
                return "allow", "L1", push_leak_checks()
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
        f = open(path, "a+b")
        fcntl.flock(f, fcntl.LOCK_EX)           # parallel calls get distinct numbers (R-D008-1 m-6)
        f.seek(0)
        lines = f.read().splitlines()
        n = len(lines) + 1
        prev = hashlib.sha256(lines[-1]).hexdigest() if lines else ""
        eff = data.get("effort") if isinstance(data.get("effort"), dict) else {}
        rec = {"n": n, "prev": prev, "time": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
               "event": data.get("hook_event_name"), "session": remote or data.get("session_id"),
               "local_session": data.get("session_id"),
               "tool_use_id": data.get("tool_use_id"), "agent_id": data.get("agent_id"),
               "mode": data.get("permission_mode"), "effort": eff.get("level"), "cwd": data.get("cwd"),
               "tool": data.get("tool_name"), "decision": decision, "rule": rule,
               "summary": summary(str(data.get("tool_name")), data.get("tool_input") or {}, rule),
               "detail": redact(detail), "reason": text if decision == "deny" else ""}
        f.write((json.dumps(rec, ensure_ascii=False) + "\n").encode())
        f.close()
        return f"#{n} in {path}"
    except Exception as exc:   # the log never decides; a failed write is reported in the reason
        return f"(not logged: {type(exc).__name__})"


def deny_text(data, rule, detail):
    title, why, where, todo = RULES.get(rule, RULES["G0"])
    tool = str(data.get("tool_name"))
    return (f"DevOS guard: DENIED by rule {rule} ({title}).\n"
            f"What was attempted: {tool}: {summary(tool, data.get('tool_input') or {}, rule)}\n"
            f"What matched: {redact(detail)}\n"
            f"Why this rule exists: {why}\n"
            f"Where it is written: {where}; the rule file is .claude/hooks/tool_allowlist.py.\n"
            f"What to do instead: {todo}\n"
            "This is the repository's written rule, not a classifier verdict. It changes only through a pull "
            f"request with a checker verdict ({WO}). Do not pursue the denied effect through another "
            "tool, wording or session; record the denial in your log entry (tools/guard_report.py).")


def main():
    data, event = {}, "PreToolUse"
    raw = sys.stdin.read()
    try:
        data = json.loads(raw)
    except ValueError:
        data = None
    if isinstance(data, dict) and data.get("hook_event_name") == "PermissionRequest":
        event = "PermissionRequest"
    if data is None:
        decision, rule, detail = "deny", "G0", "the hook input is not JSON"
    else:
        try:
            decision, rule, detail = decide(data)
        except Exception as exc:   # an internal error: fail closed, and say so (the test asserts there are none)
            decision, rule, detail = "deny", "G0", f"guard error {type(exc).__name__}: {exc}"
    if withheld(detail):           # the L details are built without text; any other detail is checked (W-C00-14)
        detail = "[withheld: the detail holds text that matches the library fingerprints or names a service]"
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
        print(f"tool_allowlist: guard error {type(exc).__name__}; blocking ({WO}, fail closed).",
              file=sys.stderr)
        sys.exit(2)
