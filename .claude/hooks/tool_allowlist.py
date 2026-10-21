#!/usr/bin/env python3
"""DevOS guard: the PreToolUse and PermissionRequest hook of every DevOS session (described in
plan/Installation_Working_Order.md; Batu's decisions D-008 and D-010).

Sessions run in Accept edits mode, without Claude Code's auto-mode classifier (D-008). This script is the
written rule file that decides every tool call instead. It allows the call, or it denies it with a reason
that states the rule, what was attempted, why the rule exists, where it is written and what to do instead.
It never asks. Every decision is appended to a per-session decision log (LOG_DIR), so that what was allowed
or denied, and why, can be audited afterwards; tools/guard_report.py prints a session's denials.

Rule families (the IDs are the keys of RULES):
  T  tools: non-MCP tools are an allow list; subagents run in-process only; AskUserQuestion and ExitPlanMode are
     passed to the user, who answers them by design; the Skill tool only for the repository's skills, and the
     Agent tool only for the five role types whose files the checkout holds (T4, PC-35, W-C02-24); the Workflow
     tool is denied as a whole (TW); a producer or test-designer task passes the gate before work (T5, W-C02-24).
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
     a clone of the library may exist in one place only, and no GitHub tool is aimed at it. L4, the token stop
     (W-C02-20): no string of either DevOS token format in any field of a call that leaves the session, or in a
     commit or branch name a push would publish, read raw before any masking, by the finder patterns of
     tests/C02/W-C02-07/shared/ read at every call; while those files cannot be read or disagree, every such call
     is denied. L5, L4's one exception (W-C02-20 point 3): a string of the claim token's format in the arguments
     of the client script's own call to the live host (tools/devos_rpc.py as merged, its content pinned), and
     nowhere else; that call's text is never repeated.

Threat model (plan/Installation_Working_Order.md): accidents and injected instructions, not a session that
deliberately edits this file. A deliberate bypass stays visible in git and is a stated residual risk (D-003).
The shell analysis is lexical: a command it cannot parse is denied, and a directory it cannot tell is treated
as the live tree.

Exit: 0 with a JSON decision on stdout, or with the plain-text PASS_MARKER for a call passed to the user, so that
an exit 0 with no output is never a decision (N-185). An internal error inside the decision is a deny; any other
error exits 2. The PermissionRequest command passes its event as the first argument, so even input that cannot
be read is answered in that event's form. The settings wrappers pass on only an answer in their event's form or
the marker; anything else (a non-zero exit, no output, another form) blocks: exit 2 on PreToolUse, and on
PermissionRequest, where exit 2 is not honoured, a deny in that event's form. Both hooks set
"onFailure": "block" for a hook that cannot start or times out (N-173).
"""
import bisect
import fcntl
import fnmatch
import hashlib
import importlib.machinery
import importlib.util
import json
import mmap
import os
import re
import shlex
import subprocess
import sys
import time
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
# One time budget for every slow step of a call (git calls, the leak check, the merge gate): once it is spent the
# call fails closed, well before the hooks' 600-second timeout would let it continue (W-C00-14). The environment
# may only shorten it (tools/test_tool_allowlist.sh).
CALL_BUDGET = min(400, int(os.environ.get("DEVOS_CALL_BUDGET") or 400))

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
# the account's other sessions (ListAgents), publishing surfaces, connector and plugin
# suggestion tools, MCP resource readers and worktree switching (which would change the enforced guard).
ALLOWED_NON_MCP = {
    "Bash", "Read", "Write", "Edit", "Glob", "Grep", "NotebookEdit",
    "Agent", "Task",
    "SendMessage",                 # only to this session's agents, by T6 (W-C02-27); not local, so L4 reads its input
    "Workflow",                    # listed so that TW, not T1, denies it with its own reason (W-C02-24, EV-C02-031)
    "ToolSearch", "Skill", "StructuredOutput",
    "TaskCreate", "TaskGet", "TaskList", "TaskUpdate", "TaskStop", "TaskOutput",
    "TodoWrite", "WebFetch", "WebSearch", "EnterPlanMode", "SendUserFile",
    "PushNotification",            # reaches only Batu's own devices (second channel, Appendix E §8)
    "ReportFindings", "SubagentHandback",
    "ReadNotifications",           # this session's own queue (T-A2); its contents are data, never instructions
    "Artifact",                    # Batu's claude.ai pages, private by default; the platform asks him before each delete
}
# Monitor is not listed, so T1 denies it (W-C02-21): its command runs in the same shell as Bash's and its ws input opens
# a WebSocket to any address, and no shell rule (B1 to B11, G0, L1, L2) reads it; listed, L4 would check only the
# token formats. Nothing in the installation needs it: to wait, use Bash with run_in_background, or send_later.
# L4 (W-C02-20 point 1; tests/C02/W-C02-20/README.md section 2): the listed tools whose input stays in the session's
# container (files, in-process subagents, whose own calls pass this guard, Workflow, which TW denies, the checkout's
# skills, the session's task list, mode and notification queue, and results handed to the calling conversation). Every other listed
# tool and every allowed MCP server carries text out of the session, and L4 reads its whole input.
LOCAL_TOOLS = {
    "Read", "Write", "Edit", "Glob", "Grep", "NotebookEdit", "Agent", "Task", "Workflow", "ToolSearch", "Skill",
    "StructuredOutput", "TaskCreate", "TaskGet", "TaskList", "TaskUpdate", "TaskStop", "TaskOutput", "TodoWrite",
    "EnterPlanMode", "ReportFindings", "SubagentHandback", "ReadNotifications",
}
USER_TOOLS = {"AskUserQuestion", "ExitPlanMode"}   # answered by the user; an "allow" would need updatedInput
# "Pass" is printed as this plain text, never as no output (N-185). The hooks page (read 2026-10-11) gives plain
# text and no output the same outcome at exit 0 ("Success": no decision, the normal permission flow) and says
# plain text "isn't a failure"; the settings wrappers match it exactly, so it must not start with "{" or hold "'".
PASS_MARKER = "DevOS guard: pass, no decision: the user answers this tool (N-185)"
SUBAGENT_TOOLS = {"Agent", "Task"}
# T4 (PC-35 "Routing" item 1; W-C02-24 A1): an Agent or Task call names one of the five role types, exactly, and the
# guard's checkout holds its file .claude/agents/<type>.md. Every built-in type (general-purpose, claude,
# claude-code-guide, statusline-setup, Explore, Plan, fork), counter-designer (until C05), a plugin's type and a call
# with no type are denied: a helper without a role package (Ek A 3.3; W-C02-24 disposition 3).
ROLE_TYPES = ("producer", "researcher", "prober", "checker", "test-designer")
# T5, the gate before work (W-C02-24 A3; SB-COR 3.1): the grammars as the acceptance block pins them. A prompt's lines
# are its "\n"-separated parts; a "\r" stays part of its line. Every pattern is matched at column 0.
T5_TYPES = ("producer", "test-designer")
T5_FORM = re.compile(r"(?:\*\*)?Writer or reader:(?:\*\*)?[ \t]*([A-Za-z]*)")
T5_ITEM = re.compile(r"(?:\*\*)?Item:")
T5_WHOLE = re.compile(r"(?:\*\*)?Item:(?:\*\*)?[ \t]+(plan/work/W-C\d\d-\d\d(?:\.\d+)?\.md)[ \t]*")   # fullmatch
T5_PATH = re.compile(r"plan/work/W-C\d\d-\d\d(?:\.\d+)?\.md")
T5_KEYS = ("base", "asked", "not_asked", "library", "agreed", "writes", "consumer", "dispositions", "open")
T5_KEY = re.compile(r"(" + "|".join(T5_KEYS) + r"):(?: |$)")
T5_EV = re.compile(r"evidence/C\d\d/[A-Za-z0-9_.-]+\.md")
APPROACH = ("<!-- approach -->", "<!-- /approach -->")
ACCEPTANCE = ("<!-- acceptance -->", "<!-- /acceptance -->")
# tools/records.py's NOTE_RE, held here because the guard reads only its own checkout's git objects (W-C02-24 A3)
NOTE_RE = re.compile(r"<!-- note (N-\d+)((?: [a-z_]+=[^ >]+)*) -->\n(.*?)\n<!-- /note -->", re.S)
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
    "T4": ("skills and agent types the repository provides", "A skill or a subagent type brings its own text into the "
           "session as instructions. Only the repository's own skills (a directory under .claude/skills/) and the five "
           "role types, each with its file in .claude/agents/, are admitted: a built-in type, counter-designer (until "
           "C05) or a plugin's skill or agent type is a helper without a role package, not reviewed for DevOS.",
           WO + " section 10; PC-35; W-C01-45; W-C02-24",
           "Use a skill under .claude/skills/ by its exact directory name; launch an Agent or Task call with "
           "subagent_type set to exactly one of " + ", ".join(ROLE_TYPES) + ". A new skill or agent type is added "
           "only by a reviewed change to the repository and to this file."),
    "TW": ("the Workflow tool is denied as a whole", "A workflow's agents run their own calls, and its script chooses "
           "agent types and options this guard cannot read before they run; the roles run through the Agent tool, "
           "where the guard decides each launch (W-C02-24 disposition 2).",
           WO + " sections 2, 4 step 3 and 10; W-C02-24",
           "Run each part through the Agent tool, one call per role, with subagent_type one of " +
           ", ".join(ROLE_TYPES) + " and no isolation field; independent calls can be made together in one message, and long work can run "
           "in the background. Re-admitting workflows needs a checked guard change."),
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
    "F6": ("the nonce key file is not for subagents", "The start hook keys each role run's nonce from the session's "
           "<session>.nonce-key file in the guard's log directory; a receipt that any role could compute from that "
           "file would show nothing about delivery (W-C02-25 disposition W25-4).", WO + " section 10; W-C02-25",
           "Echo the Nonce: line your start header gave you, or write \"Nonce: none delivered\"; never read, "
           "search or name the key file."),
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
           "merge, rebase, reset, fetch, a script, a shell), or a wait (sleep) during which a background job could, "
           "would change what is pushed after the check.",
           WO + "; W-C00-14", "Run the push as its own Bash call: git -C <literal path> push origin <claude/ "
           "branch>, alone or with cd, echo and readers such as tail."),
    "L3": ("the library clone in its one place", "The leak check compares public writes with fingerprints of "
           "one clone of the private research library, at " + LIBRARY_DIR + ", and fails closed while that clone "
           "exists without a fresh store. A clone, copy or fetch of the library anywhere else, or a GitHub tool "
           "aimed at it (a read of it, or a search scoped to it or to its owner as a whole), would bring its text "
           "into the session with no store behind it.",
           WO + "; W-C00-14", "Clone the library only to " + LIBRARY_DIR + ", read it there, and rebuild the "
           "store with python3 tools/leak_fingerprints.py build. A GitHub tool may name the library in its text (L1 "
           "checks that text), but not aim at it: no owner or repo field naming it, and no search qualifier repo:, "
           "user:, org: or owner: on it or on batuhanozgun; scope a search with repo:batuhanozgun/devos."),
    "L4": ("no string of a DevOS token format in outbound text", "The environment token and the claim token are "
           "DevOS credentials. A string of either format (the finder patterns of tests/C02/W-C02-07/shared/"
           "token_format.md section 3 and scan_patterns.json, read at every call) in any field of a call that leaves "
           "the session (the shell, a web read or search, a GitHub tool, a session tool, the database connection, a "
           "notification or a file sent to the user), or in a commit or branch name a push would publish, would carry "
           "one out. The raw input is read before any masking, and the string is never shown or logged. While the two "
           "shared files are missing, unreadable, incomplete or in disagreement, every such call is denied.",
           WO + "; EV-C02-003 sections 1.6 and 1.7; plan 6.3 and 6.7; W-C02-20",
           "Do not send the string by another route. A synthetic test string or planted control is recorded as "
           "synthetic in your log entry, and is made at run time inside a program or statement, not written into the "
           "call. Any other match is reported to the executor as a finding, without the string; for the environment "
           "token's format, EV-C02-003 section 2.2 and plan 6.3 apply: the token is revoked and renewed. If the detail "
           "says the shared files cannot be read or disagree, restore both to their text on main (this rule does not "
           "read the Read and Write tools) and report it to the executor. A claim token goes to devos_api only by the "
           "client path (rule L5)."),
    "L5": ("the client path, L4's one exception", "A string of the claim token's format may leave only in the "
           "arguments of the client script's own call to the live project's host: python3 -I tools/devos_rpc.py "
           "<function>, alone in its Bash call, run from the checkout's root, with its arguments in a single-quoted "
           "here-string or a quoted here-document, and the script as merged into main (its content is pinned in this "
           "guard). The call's text is never repeated, so another rule's denial of it names only that rule.",
           WO + "; EV-C02-003 sections 1.6 and 1.7; W-C02-20 point 3",
           "Run the client call alone, in exactly that form. If the script was changed on purpose, the exception "
           "follows it only through a guard change of its own; report it to the executor."),
}
# T5's refusals, one entry each (W-C02-24 A3): a shared why and where, and per check a title and what to do instead
T5_WHY = ("A producer starts writing only with its item's agreed approach (SB-COR 3.1; D-039): its task carries the "
          "Item: line and that item's approach block byte for byte as the guard's checkout holds it at HEAD, and the "
          "item has an acceptance condition and no open blocking note. A producer's reader task and a test designer's "
          "task name their item. The guard reads only its own checkout, never the call's cwd or the network.")
T5_TASK = "Write the task by working order section 9's template: "
RULES.update({rule: ("the gate before work: " + title, T5_WHY, WO + " sections 9 and 10; W-C02-24", todo)
              for rule, title, todo in (
    ("T5.0", "could not check", "The guard could not check this call (the detail names the error) and refuses this "
     "call only. Launch again; if it repeats, report it to the executor as a guard finding (working order section 10, "
     "the lock-out route)."),
    ("T5.1", "no Writer or reader: line", T5_TASK + "one line at column 0, with no bullet, reading **Writer or "
     "reader:** writer ... or **Writer or reader:** reader ...."),
    ("T5.2", "more than one Writer or reader: line", "Keep exactly one Writer or reader: line at column 0; indent any "
     "quoted one."),
    ("T5.3", "the first word is neither writer nor reader", "Begin the Writer or reader: line's text with the word "
     "writer or reader."),
    ("T5.4", "no prompt in the tool input", "Launch the role with its task in the Agent call's prompt."),
    ("T5.5", "no Item: line", T5_TASK + "a line Item: plan/work/W-C<dd>-<dd>.md at column 0, with no bullet."),
    ("T5.6", "more than one Item: line in the writer form", "A writer task names one item: keep one Item: line at "
     "column 0; a triage of several items is a reader task."),
    ("T5.7", "the Item: line is not well formed", "In the writer form the line is exactly Item: plan/work/"
     "W-C<dd>-<dd>[.<n>].md, with nothing after the path; in the reader form, and for a test designer, an Item: line "
     "names such a path."),
    ("T5.8", "the item file is absent at HEAD", "Check the Item: path. A new item's file is merged into main first "
     "(its acceptance and approach pull request), then this checkout is brought forward with tools/sync_worktree.sh; "
     "an uncommitted file does not count."),
    ("T5.9", "the item file is on origin/main but not at HEAD: sync first", "Sync first: run tools/sync_worktree.sh, "
     "then launch again."),
    ("T5.10", "no approach block in the item file", "Agree the approach (working order section 4 step 1a; \"no team "
     "round needed, because ...\" is a valid result), merge it into the item file, sync, and paste it by tool."),
    ("T5.11", "more than one approach block in the item file", "Keep one approach block in the item file, through a "
     "checked change."),
    ("T5.12", "a malformed approach block", "Correct the item's block through a checked change: its two markers as "
     "whole lines, in order, and the keys " + ", ".join(T5_KEYS) + " at column 0, once each, in that order."),
    ("T5.13", "the approach block is not in the task byte for byte", "Paste the block by tool from git show "
     "HEAD:<item file>, its markers included, with LF line ends and no edit, under the Item: line of the same item."),
    ("T5.14", "library: is empty", "Fill the block's library: line (what the library changed, limited or justified, or "
     "\"none bore, because ...\") through a checked change of the item."),
    ("T5.15", "asked: names no evidence record", "Name in asked: the record under evidence/C<dd>/ that holds the "
     "roles' notes, through a checked change of the item."),
    ("T5.16", "an asked: record is absent at HEAD", "Merge the record that asked: names, sync, and launch again; or "
     "correct its path in the item."),
    ("T5.17", "no acceptance block in the item file", "Merge the item's acceptance condition before its product "
     "(working order section 4 step 2), sync, and launch again."),
    ("T5.18", "an empty acceptance block", "Write the item's acceptance condition into its block, merge it, sync, and "
     "launch again."),
    ("T5.19", "an open blocking note on the item", "Close the note by a disposition in the approach (working order "
     "section 4 step 2a), merge, sync, and launch again."),
)})
# T6, messages between agents (W-C02-27; SB-COR 3.6b): one entry per refusal, a shared why and where
T6_WHY = ("SendMessage reaches only agents of this session: an agent ID held in this session's registry (written by "
          ".claude/hooks/agent_hooks.py), or main, by the caller rules of W-C02-27's approach; producer, test-designer "
          "and checker IDs take messages only from the executor. to alone names the target; the keys the platform "
          "adds (type, recipient, recipient_kind and content) are admitted only all together and only when they agree "
          "with to and message, and message is one string (W-C02-27.1). T6 is the only layer for sessions on the same "
          "machine and the main one everywhere. Messages are not records: a request taken or returned is written in "
          "the hand-overs' Received from / Returned to lines.")
T6_RETURN = "return it in your hand-over's Received from / Returned to"
T6_FINDING = ("If you sent only to and message, report this denial to the executor as a guard finding, and "
              + T6_RETURN)
RULES.update({rule: ("messages to this session's agents only: " + title, T6_WHY,
                     WO + " sections 9 and 10; W-C02-27; W-C02-27.1; SB-COR 3.6b", todo) for rule, title, todo in (
    ("T6.0", "could not check", "The guard could not check this call (the detail names the error) and refuses this "
     "call only; " + T6_RETURN + ", and report it to the executor as a guard finding."),
    ("T6.1", "an input key not admitted", "Give to (one agent ID, or main) and message (one string), and a summary "
     "only as one string; the platform itself adds type, recipient, recipient_kind and content, all four together. "
     "Any other key, or only some of those four, is refused. " + T6_FINDING + "."),
    ("T6.2", "to is not one string", "Give to as one string: one agent ID from your task's Teammates: line, or main."),
    ("T6.3", "to is missing or empty", "Give to as one string: one agent ID from your task's Teammates: line, or main."),
    ("T6.4", "to is * (broadcast)", "Message one agent by its ID; a broadcast is not admitted."),
    ("T6.5", "to is a session reference", "Other sessions are not reachable; message an agent of this session by its "
     "ID, or " + T6_RETURN + "."),
    ("T6.6", "to is not an agent ID held in this session's registry", "Use the agent ID from your task's Teammates: "
     "line exactly as written; names and other sessions' IDs are not resolved. Without an ID, " + T6_RETURN + "."),
    ("T6.7", "the caller is not allowed for that target", "A producer, test-designer or checker ID takes messages only "
     "from the executor; a researcher or prober ID from the executor or an agent registered in this session; main "
     "only from an agent registered in this session; any other type none. Send the request to main (the executor), "
     "or " + T6_RETURN + "."),
    ("T6.8", "a message to the caller itself", "Do not message your own ID; the executor does not message main."),
    ("T6.9", "no registry for this session", "No registry for this session; " + T6_RETURN + "."),
    ("T6.10", "a platform key disagrees with to and message, or message is not one string", "Give message as one "
     "string, never a structured message, and do not set type, recipient, recipient_kind or content yourself. "
     + T6_FINDING + "."),
)})
LEAK_WITHHELD = {"L1", "L2", "L4", "L5"}   # rules whose call text is never repeated (it may hold the matched text)


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


class OverBudget(subprocess.SubprocessError):
    pass


DEADLINE = [None]   # the time.monotonic() by which the call's slow steps must be done (main(): CALL_BUDGET)


def budget(limit):
    """limit, cut to what is left of the call's time budget; OverBudget once the budget is spent."""
    if DEADLINE[0] is None:
        return limit
    left = DEADLINE[0] - time.monotonic()
    if left <= 0:
        raise OverBudget(f"the call's time budget of {CALL_BUDGET} seconds is spent")
    return min(limit, left)


def git(*args, cwd=ROOT, timeout=20, raw=False, input=None):
    """git in cwd, within its own limit and the call's budget; the output as UTF-8 text, or bytes when raw."""
    try:
        return subprocess.run(["git", "-C", cwd, *args], capture_output=True, input=input, timeout=budget(timeout),
                              **({} if raw else {"encoding": "utf-8", "errors": "replace"}))
    except subprocess.TimeoutExpired:
        budget(timeout)      # OverBudget when the call's budget, not this step's own limit, ran out
        raise


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
    is never repeated there, nor is the call text of a leak denial (W-C00-14), nor a tool input that is not an
    object, which G0 denies before any rule (L4 included) has read it (N-269). It never raises: a text it cannot
    read is not shown, so that the denial built from it keeps its rule and the call keeps its log record (N-269)."""
    if rule in LEAK_WITHHELD:
        return f"[withheld: a {rule} {'decision' if rule == 'L5' else 'denial'} does not repeat the call's text]"
    if not isinstance(args, dict):
        return f"[not shown: the tool input is a {type(args).__name__} value, not an object]"
    try:
        if name == "Bash":
            s = str(args.get("command", ""))
        elif name in FILE_WRITE_TOOLS or name in FILE_READ_TOOLS:
            s = str(args.get(FILE_WRITE_TOOLS.get(name) or FILE_READ_TOOLS.get(name)) or "")
        elif name == "SendMessage":   # no message text (W-C02-27.1, W271-5); to, recipient, recipient_kind, type shown
            shown = dict(args)
            for text_key in ("message", "content", "summary"):
                shown.pop(text_key, None)
            s = json.dumps(shown, ensure_ascii=False, sort_keys=True)
        else:
            keep = {k: v for k, v in args.items() if k not in ("content", "files", "prompt", "message", "body",
                                                                 "new_string", "old_string", "script")}
            s = json.dumps(keep, ensure_ascii=False, sort_keys=True)
        if withheld(s):
            return "[withheld: the call's text matches the library fingerprints or names a service]"
        s = redact(s.replace("\n", " ⏎ "))
    except Exception as exc:   # never lose the denial's rule and the log record to the text shown (N-269)
        return f"[not shown: the call's text could not be read ({type(exc).__name__})]"
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


NONCE_KEY_SUFFIX = ".nonce-key"   # <LOG_DIR>/<session key>.nonce-key, written by .claude/hooks/agent_hooks.py


def names_nonce_key(name, args):
    """F6 (W-C02-25, W25-4): the call's path or command text names a nonce key file. Read, Grep and Glob paths, the
    file tools' paths and the shell command are read; a file's content (Write, Edit) and a Grep pattern are not, so a
    scratch copy of the hook can still be written and searched. A read inside an interpreter that builds the name, or
    a glob that does not spell it, is not caught (working order section 10, "Not protected")."""
    keys = ("file_path", "notebook_path", "path", "glob", "command") + (("pattern",) if name == "Glob" else ())
    return any(isinstance(args.get(k), str) and NONCE_KEY_SUFFIX[1:] in args[k] for k in keys)


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
            while k < len(rest) and rest[k] not in (";", "+", "\\;"):
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
                           capture_output=True, text=True, timeout=budget(MERGE_GATE_TIMEOUT))
    except (subprocess.TimeoutExpired, OverBudget):
        raise Bad("M7", f"the merge gate did not finish within {MERGE_GATE_TIMEOUT} seconds or within what was left "
                        f"of the call's {CALL_BUDGET}-second budget; failing closed")
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


# A search qualifier that scopes a GitHub search to the library, or to its owner as a whole (which includes it).
# A negated qualifier (-repo:, -user:) excludes it and does not match.
LIBRARY_QUALIFIER = re.compile(r'(?<![\w-])(repo:\s*"?[^\s"]*agentic-os-search|(user|org|owner):\s*"?batuhanozgun'
                               r'(?![\w.-]))', re.I)


def library_target(args):
    """What aims a GitHub tool at the research library, or "": an owner or repo field naming it, or a search query
    scoped to it or to its owner as a whole (W-C00-14, L3)."""
    for k in ("owner", "repo"):
        if LIBRARY_NAME.search(str(args.get(k) or "")):
            return f"its {k} field"
    return "its search query's qualifier" if LIBRARY_QUALIFIER.search(str(args.get("query") or "")) else ""


def github_checks(tool, args):
    if tool in BLOCKED_GITHUB:
        raise Bad("M2", f"'{tool}' is not allowed for DevOS sessions")
    # The library is read only through its one clone, which the leak check is tied to (W-C00-14): a GitHub tool
    # aimed at it, a read or a search included, would bring its text into the session with no store behind it.
    # Text that merely names it (a PR body, a comment) is not aimed at it; L1 checks that text.
    t = library_target(args)
    if t:
        raise Bad("L3", f"GitHub tool '{tool}' is aimed at the research library ({t}); it is read only through "
                        "its clone")
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
PUSH_COMPANIONS = PURE_READERS | {"cd", "pushd", "echo", "printf", "true", ":"}   # no sleep: no waiting (L2)
EMPTY_TREE = {40: "4b825dc642cb6eb9a060e54bf8d69288fbee4904",       # a root commit's first parent, by hash length
              64: "6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321"}
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
    try:
        r = git("grep", "-h", "-I", "-F", "--no-color", *[x for l in lines for x in ("-e", l)], ref, "--",
                cwd=repo, timeout=30)   # substring matches; only whole-line equality counts below
    except subprocess.TimeoutExpired:   # its command holds the lines: fail closed with a text-free reason
        raise TimeoutError("the search of the main branch for the lines that name a service timed out; its "
                           "command holds those lines, so it is not shown") from None
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
        budget(0)                           # stop (OverBudget) once the call's time budget is spent
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
        raise Bad("L1", f"the leak check could not run ({type(exc).__name__}: {exc}); failing closed")
    if found:
        leak_deny(f"GitHub write '{tool}' to devos", found)


# ---------------------------------------------------------------- token stop (L4; W-C02-20)
# EV-C02-003 sections 1.6 and 1.7; plan 6.7's network row. The finder patterns are read from W-C02-07's shared files in
# this guard's own checkout at every call (no copy is kept here), and applied to the raw input: every string at any
# depth, object keys included, of the decoded hook input, before redact() or summary() masks anything (token_format.md
# section 6: REDACT can mask a string of either format). The denial withholds the call's text (LEAK_WITHHELD). The two
# files agree only when each finder of scan_patterns.json equals the code span of its own row in section 3's Finder
# table; an edit of both alike is followed (EV-C02-010 sections A.3 and A.8; note N-270).

TOKEN_FILES = os.path.join(ROOT, "tests", "C02", "W-C02-07", "shared")
TOKEN_FINDERS = {"env_token_find": ("environment token's", "Environment token"),   # key: (format, its Finder row)
                 "claim_token_find": ("claim token's", "Claim token")}


def token_finders():
    """[(format, compiled finder)] from scan_patterns.json, each equal to the code span of its own row in the Finder
    table of token_format.md section 3 (CHK-C02-056 C1); Bad(L4, "could not check ...") when a file is missing,
    unreadable or incomplete, a pattern is missing or does not compile, the two files disagree, or any other error is
    raised while they are read or checked, a RecursionError from a deeply nested file among them (plan Section 8 item
    14: never an allow, and never a guard error, whose text and log are not withheld)."""
    try:
        with open(os.path.join(TOKEN_FILES, "scan_patterns.json"), encoding="utf-8") as f:
            pats = json.load(f)["token_patterns"]
        with open(os.path.join(TOKEN_FILES, "token_format.md"), encoding="utf-8") as f:
            sec3 = re.search(r"^## 3\..*?(?=^## 4\.)", f.read(), re.S | re.M)
        # the Finder table: the run of table lines that first follows section 3's paragraph opening "**Finder"
        table = re.findall(r"^\*\*Finder\b.*\n(?:(?!\|).*\n)*?((?:\|.*\n?)+)", sec3.group(0), re.M) if sec3 else []
        if not isinstance(pats, dict) or len(table) != 1:
            raise ValueError("no token_patterns object in scan_patterns.json, or no section 3 with one Finder table in "
                             "token_format.md")
        out = []
        for key, (what, row) in TOKEN_FINDERS.items():
            spans = re.findall(r"^\|[ \t]*" + re.escape(row) + r"[ \t]*\|[ \t]*`([^`\n]+)`[ \t]*\|[ \t]*$", table[0],
                               re.M)
            if len(spans) != 1 or pats[key] != spans[0]:
                raise ValueError(f"{key} of scan_patterns.json is not the code span of the {row} row of "
                                 "token_format.md section 3's Finder table: the files disagree")
            out.append((what, re.compile(spans[0])))
        return out
    except Exception as exc:   # any error while the files are read or checked, RecursionError included (CHK-C02-056 C1)
        raise Bad("L4", f"could not check: the token formats cannot be read from {TOKEN_FILES} ({type(exc).__name__}: "
                        f"{exc}); every call this rule reads is denied until scan_patterns.json and token_format.md "
                        "section 3 are whole and agree")


def input_strings(v):
    """Every string of a decoded tool input at any depth, object keys included (W-C02-20 README R4)."""
    stack = [v]
    while stack:
        x = stack.pop()
        if isinstance(x, str):
            yield x
        elif isinstance(x, dict):
            stack += [y for kv in x.items() for y in kv]
        elif isinstance(x, list):
            stack += x


def token_stop(texts, what="the call", claim_ok=()):
    """L4: deny when any of texts holds a string of either DevOS token format; neither the string nor where it is is
    named in the detail. The texts of claim_ok (the client path's arguments, L5) are read for the environment token's
    format only."""
    finders = token_finders()
    for t in texts:
        for fmt, rx in finders:
            if rx.search(t):
                raise Bad("L4", f"{what} carries a string of the {fmt} format (tests/C02/W-C02-07/shared/"
                                "token_format.md section 3); neither the string nor the field holding it is shown")
    for t in claim_ok:
        for fmt, rx in finders:
            if fmt != TOKEN_FINDERS["claim_token_find"][0] and rx.search(t):
                raise Bad("L4", f"the client path's arguments carry a string of the {fmt} format (tests/C02/W-C02-07/"
                                "shared/token_format.md section 3); neither the string nor where it is is shown")


# The client path's exception (L5; W-C02-20 point 3; EV-C02-003 sections 1.6 and 1.7): a string of the claim token's
# format only, and only in the arguments of the client script's own call to the live host. The call is one simple
# command, exactly `python3 -I tools/devos_rpc.py <function>` with its arguments in a single-quoted here-string or a
# quoted here-document (data the shell does not expand), run from this guard's own tree, whose client is the script as
# merged: its content is pinned, because the script names its one host in its own text (HOST and its request line), so
# any change of the client turns the exception off until a guard change follows it. The rest of the call (the command
# outside those arguments and every other field) and the environment token's format everywhere stay under L4.
CLIENT_REL = os.path.join("tools", "devos_rpc.py")
CLIENT_SHA256 = "30c8cf431d32df6c7e93b62e3b9e5f2e475c706b23c1068b16ff1da4dcbbe102"   # blob e450b90b557c: added by
#                                                         9af14f1, merged into main by 7a6f3ea (PR #352)
CLIENT_CALL = re.compile(r"python3 -I tools/devos_rpc\.py [a-z_][a-z0-9_]{0,62} (?:<<< '(?P<s>[^']*)'|"
                         r"<<(?P<q>['\"])(?P<d>[A-Za-z_][A-Za-z0-9_]*)(?P=q)\n(?P<b>.*)\n(?P=d))\n?", re.S)


def client_args(args, data):
    """L5: (start, end) of the client path's arguments in the Bash call's command, or None when the call is not the
    client path: another form, a directory other than the guard's tree, or a client missing, unreadable or changed."""
    cmd, cwd = args.get("command"), data.get("cwd")
    if not isinstance(cmd, str) or not isinstance(cwd, str) or not os.path.isabs(cwd) or \
            os.path.realpath(cwd) != os.path.realpath(ROOT):
        return None
    m = CLIENT_CALL.fullmatch(cmd)
    if not m or (m.group("d") and m.group("d") in m.group("b").split("\n")):   # a body line that ends the document
        return None
    try:
        with open(os.path.join(ROOT, CLIENT_REL), "rb") as f:
            if hashlib.sha256(f.read(1 << 20)).hexdigest() != CLIENT_SHA256:
                return None
    except OSError:
        return None
    return m.span("s") if m.group("s") is not None else m.span("b")


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
    its diff against its first parent adds (a root commit against the empty tree). Each commit is read on its own,
    so no byte of a message or a file can move a boundary: the list from rev-list, the messages from cat-file's
    sized records, one diff-tree per commit split on newlines only. Every file is read as text (--text), so neither
    binary bytes nor a .gitattributes entry such as binary or -diff can keep a file's added lines from the check.
    Returns (blocks, number of commits)."""
    opts = ("--no-replace-objects", "-c", "core.quotepath=false")
    r = git(*opts, "rev-list", *shas, *(["--not", ref] if ref else []), "--", cwd=e, timeout=60)
    if r.returncode != 0:
        raise ValueError("git rev-list of the pushed commits failed")
    commits = r.stdout.split()
    r = git(*opts, "cat-file", "--batch", cwd=e, timeout=60, raw=True,
            input="".join(c + "\n" for c in commits).encode())
    if r.returncode != 0:
        raise ValueError("git cat-file of the pushed commits failed")
    out, i, blocks = r.stdout, 0, []
    for sha in commits:
        j = out.find(b"\n", i)
        head = out[i:j].split() if j >= 0 else []
        if len(head) != 3 or head[0] != sha.encode() or head[1] != b"commit" or not head[2].isdigit():
            raise ValueError(f"git cat-file did not return commit {sha[:12]}")
        obj, i = out[j + 1:j + 1 + int(head[2])], j + 2 + int(head[2])
        hdr, _, msg = obj.partition(b"\n\n")
        hdr = [x.partition(b" ") for x in hdr.split(b"\n") if not x.startswith(b" ")]
        parents = [v.decode() for k, _, v in hdr if k == b"parent"]
        enc = next((v.decode("ascii", "replace") for k, _, v in hdr if k == b"encoding"), "utf-8")
        try:
            msg = msg.decode(enc, "replace")
        except LookupError:
            msg = msg.decode("utf-8", "replace")
        d = git(*opts, "diff-tree", "-p", "--text", "--no-color", "--no-ext-diff", "--no-textconv", "--no-renames",
                "--src-prefix=a/", "--dst-prefix=b/", parents[0] if parents else EMPTY_TREE.get(len(sha), ""), sha,
                "--", cwd=e, timeout=60, raw=True)
        if d.returncode != 0:
            raise ValueError(f"git diff-tree of commit {sha[:12]} failed")
        c = "commit " + sha[:12]
        files, cur, hunk = {}, None, False
        for line in d.stdout.split(b"\n"):
            if line.startswith(b"diff --git "):
                cur, hunk = line[len(b"diff --git "):].decode("utf-8", "replace"), False
                files.setdefault(cur, [])
            elif line.startswith(b"@@") and cur is not None:
                hunk = True
            elif hunk and line.startswith(b"+"):
                files[cur].append(line[1:].decode("utf-8", "replace"))
        blocks += [(c + " message", msg), (c + " paths", "\n".join(files))]
        blocks += [(f"{c} lines added to {p.rsplit(' b/', 1)[-1]}", "\n".join(a)) for p, a in files.items() if a]
    return blocks, len(commits)


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
        token_stop(["\n".join(refspecs)] + [text for _, text in blocks], "the push (its branch names and commits)")
        found = leak_found([("the pushed branch names", "\n".join(refspecs))] + blocks, store, e, ref)
    except (OSError, ValueError, subprocess.SubprocessError) as exc:
        raise Bad("L1", f"the leak check could not read the push ({type(exc).__name__}: {exc}); failing closed")
    if found:
        leak_deny(f"the push from {e} ({n} commit(s) read)", found)
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


def repo_skills():
    """T4: the skills the guard's own checkout provides, the directory names under its .claude/skills/."""
    d = os.path.join(ROOT, ".claude", "skills")
    try:
        return {n for n in os.listdir(d) if os.path.isdir(os.path.join(d, n))}
    except OSError:
        return set()


def agent_type_check(name, args):
    """T4: the call names exactly one of ROLE_TYPES, and the guard's checkout holds its file (W-C02-24 A1)."""
    if "subagent_type" not in args:
        raise Bad("T4", f"{name} names no subagent_type (the platform's default is a built-in type)")
    t = args["subagent_type"]
    if not isinstance(t, str):
        raise Bad("T4", f"{name} with a subagent_type that is not one name")
    if t not in ROLE_TYPES:
        raise Bad("T4", f"{name} names the agent type {t!r}, which is not one of the role types "
                        f"{', '.join(ROLE_TYPES)} (a built-in, a plugin's or counter-designer, for example)")
    if not os.path.isfile(os.path.join(ROOT, ".claude", "agents", t + ".md")):
        raise Bad("T4", f"{name} names the role type '{t}', whose file .claude/agents/{t}.md the guard's checkout does "
                        "not hold")
    return t


def head_object(rev, path):
    """T5: the object rev:path in the guard's own checkout, as (type, raw bytes), or None when it is absent there.
    One git call, its output read raw; a git failure raises (T5.0)."""
    r = git("cat-file", "--batch", raw=True, input=f"{rev}:{path}\n".encode())
    head, _, rest = r.stdout.partition(b"\n")
    parts = head.split()
    if r.returncode == 0 and parts[-1:] == [b"missing"]:
        return None
    if r.returncode != 0 or len(parts) != 3 or len(rest) < int(parts[2]):
        raise RuntimeError(f"git cat-file did not read {rev}:{path}")
    return parts[1].decode("ascii"), rest[:int(parts[2])]


def marked(lines, marks):
    """The (open, close) line numbers of whole-line marker pairs, and the lines that start like a marker but are not
    one whole (indented, or with text after it)."""
    opens = [n for n, l in enumerate(lines) if l == marks[0]]
    closes = [n for n, l in enumerate(lines) if l == marks[1]]
    near = [n for n, l in enumerate(lines) if l not in marks and l.strip().startswith(marks)]
    return opens, closes, near


def t5_form(prompt):
    """T5's form line (W-C02-24 A3): "writer" or "reader"; Bad (T5.1 to T5.3) when it does not parse."""
    forms = [m for m in map(T5_FORM.match, prompt.split("\n")) if m]
    if not forms:
        raise Bad("T5.1", "no line at column 0 starts with Writer or reader: (optionally in **)")
    if len(forms) > 1:
        raise Bad("T5.2", f"{len(forms)} lines start with Writer or reader:; exactly one is read")
    form = forms[0].group(1).lower()
    if form not in ("writer", "reader"):
        raise Bad("T5.3", "the Writer or reader: line's first word is neither writer nor reader")
    return form


def t5_item(t, prompt):
    """T5's grammar, read without the item file (W-C02-24 A3): (form, item path) for agent type t; Bad (T5.1 to
    T5.7) when it does not parse. The one parser of a task's form and item: t5_check and agent_hooks.py's launch
    record both use it (W-C02-25)."""
    form = t5_form(prompt)
    items = [l for l in prompt.split("\n") if T5_ITEM.match(l)]
    if not items:
        raise Bad("T5.5", "no line at column 0 starts with Item: (optionally in **)")
    if t == "test-designer" or form == "reader":
        named = [m.group(0) for m in map(T5_PATH.search, items) if m]
        if not named:
            raise Bad("T5.7", "no Item: line names a path plan/work/W-C<dd>-<dd>[.<n>].md")
        return form, named[0]
    if len(items) > 1:
        raise Bad("T5.6", f"{len(items)} Item: lines in the writer form; exactly one is read")
    m = T5_WHOLE.fullmatch(items[0])
    if not m:
        raise Bad("T5.7", "the writer form's Item: line is not exactly Item: plan/work/W-C<dd>-<dd>[.<n>].md")
    return form, m.group(1)


def t5_check(t, prompt):
    """T5's checks in the pinned order (W-C02-24 A3): (rule, detail) for an allowed call; Bad for a refusal."""
    form, path = t5_item(t, prompt)
    if t == "test-designer" or form == "reader":
        return "T5R", (f"the reader form ({t}, {form} line): an Item: line names {path}; the item file is not "
                       "read, on main or not")
    obj = head_object("HEAD", path)
    if obj is None:
        if head_object("refs/remotes/origin/main", path) is not None:
            raise Bad("T5.9", f"{path} is at the local origin/main but not at HEAD: sync first")
        raise Bad("T5.8", f"{path} is absent at HEAD of the guard's checkout")
    if obj[0] != "blob":
        raise RuntimeError(f"{path} is a {obj[0]} at HEAD, not a file")
    text = obj[1].decode("utf-8")                       # strict: an item that is not UTF-8 is T5.0
    L = text.split("\n")
    opens, closes, near = marked(L, APPROACH)
    if not (opens or closes or near):
        raise Bad("T5.10", f"{path} at HEAD holds no approach block")
    if len(opens) > 1 or len(closes) > 1:
        raise Bad("T5.11", f"{path} at HEAD holds {max(len(opens), len(closes))} approach blocks")
    if near or len(opens) != 1 or len(closes) != 1 or closes[0] < opens[0]:
        raise Bad("T5.12", f"{path} at HEAD: an approach marker is not a whole line, is missing or is out of order")
    body, vals, key = L[opens[0] + 1:closes[0]], {}, None
    for l in body:
        k = T5_KEY.match(l)
        if k:
            key = k.group(1)
            vals[key] = [l[k.end():]]
        elif key:
            vals[key].append(l)
    if tuple(T5_KEY.match(l).group(1) for l in body if T5_KEY.match(l)) != T5_KEYS:
        raise Bad("T5.12", f"{path} at HEAD: the block's key lines are not " + ", ".join(T5_KEYS) +
                  ", once each, in that order")
    if "\n".join(L[opens[0]:closes[0] + 1]) not in prompt:
        raise Bad("T5.13", f"the approach block of {path} at HEAD, markers included, is not in the task byte for byte")
    if not "\n".join(vals["library"]).strip():
        raise Bad("T5.14", f"the approach block of {path} has an empty library: line")
    asked = list(dict.fromkeys(T5_EV.findall("\n".join(vals["asked"]))))
    if not asked:
        raise Bad("T5.15", f"the approach block of {path}: asked: names no path evidence/C<dd>/<name>.md")
    for a in asked:
        if git("cat-file", "-e", f"HEAD:{a}", raw=True).returncode != 0:
            raise Bad("T5.16", f"the approach block of {path}: asked: names {a}, which is absent at HEAD")
    opens, closes, _ = marked(L, ACCEPTANCE)
    end = next((c for c in closes if opens and c > opens[0]), None)
    if end is None:
        raise Bad("T5.17", f"{path} at HEAD holds no acceptance block")
    if not "\n".join(L[opens[0] + 1:end]).strip():
        raise Bad("T5.18", f"{path} at HEAD holds an empty acceptance block")
    if text.count("<!-- note ") != len(NOTE_RE.findall(text)):
        raise Bad("T5.0", f"could not check: a note marker in {path} does not match tools/records.py's note format")
    for nm in NOTE_RE.finditer(text):
        attrs = dict(a.split("=", 1) for a in nm.group(2).split())
        if attrs.get("status", "open") == "open" and attrs.get("blocks") == "true":
            raise Bad("T5.19", f"{path} holds the open blocking note {nm.group(1)} (a note with no status is open)")
    return "T5", (f"the writer form: {path} at HEAD, its approach block in the task byte for byte, its asked: records "
                  "present, its acceptance block present, no open blocking note")


def t5(data, args, t):
    """T5, the gate before work, for a producer or test-designer call (W-C02-24 A3). The record's detail carries the
    input's key names and the prompt's UTF-8 byte length and SHA-256, never its text. Any error inside T5 refuses this
    call only, as T5.0 (containment; never G0)."""
    meta = (f"input_keys={','.join(sorted(map(str, args)))}; "
            f"hook_keys={','.join(sorted(map(str, data)))}")
    try:                                                 # T5's one catch: removed, T5.0's cases would reach G0
        prompt = args.get("prompt")
        if not isinstance(prompt, str):
            raise Bad("T5.4", "the tool input holds no prompt string")
        b = prompt.encode("utf-8")                       # a prompt that cannot be encoded raises: T5.0
        meta += f"; prompt_bytes={len(b)}; prompt_sha256={hashlib.sha256(b).hexdigest()}"
        rule, why = t5_check(t, prompt)
    except Bad as e:
        raise Bad(e.rule, f"{e.detail}; {meta}")
    except Exception as exc:
        raise Bad("T5.0", f"could not check ({type(exc).__name__}); this call only is refused; {meta}")
    return rule, f"{why}; {meta}"


# T6 (W-C02-27; SB-COR 3.6b): SendMessage only to an agent of this session's registry, by the approach's caller rules
T6_KEYS = ("to", "message", "summary", "type", "recipient", "recipient_kind", "content")   # W-C02-27.1 (W271-1)
T6_PLATFORM = ("content", "recipient", "recipient_kind", "type")   # added by the platform all together (2.1.304)
T6_TIES = ("message", "type", "recipient", "recipient_kind", "content", "summary")   # the record's order (B1)
T6_FROM_MAIN_ONLY = ("producer", "test-designer", "checker")   # W27-1
T6_FROM_REGISTERED = ("researcher", "prober")
_AGENT_HOOKS = []


def agent_hooks():
    """W-C02-25's registry functions: .claude/hooks/agent_hooks.py of this guard's own checkout, loaded once."""
    if not _AGENT_HOOKS:
        sys.dont_write_bytecode = True   # no __pycache__ in the checkout's .claude/hooks/ (as agent_hooks.py keeps it)
        ldr = importlib.machinery.SourceFileLoader("devos_agent_hooks_for_guard", os.path.join(HERE, "agent_hooks.py"))
        mod = importlib.util.module_from_spec(importlib.util.spec_from_loader(ldr.name, ldr))
        ldr.exec_module(mod)
        _AGENT_HOOKS.append(mod)
    return _AGENT_HOOKS[0]


def send_message_checks(data, args):
    """(rule, why) for an allowed SendMessage call; Bad(T6.1 to T6.10) for a refused one. to alone names the target
    (W-C02-27's rules); every other key is admitted only when the platform adds it and it agrees with to and message
    (W-C02-27.1). The keys are decided before the registry is read, the ties (T6.10) last, after T6.6 and T6.7; a
    disagreement is refused, never resolved by picking a field, and the input is never rewritten. The registry is read
    under its shared lock with W-C02-25's bounded wait, under the guard's session_key. Every detail ends with the
    sorted key names (cut as T6.1 cuts them) and each tie's result, never a value of message, content or summary.
    decide() refuses any other exception raised here as T6.0, for this call only."""
    to = args.get("to")
    kind = "main" if to == "main" else "agent"   # the platform's kind for a to that passes T6.6 (premise, inferred)
    want = {"message": lambda v: isinstance(v, str), "type": lambda v: v == "message",
            "recipient": lambda v: isinstance(v, str) and v == to, "recipient_kind": lambda v: v == kind,
            "content": lambda v: isinstance(v, str), "summary": lambda v: isinstance(v, str)}
    ties, fails = {}, []                  # fails: in T6_TIES's fixed order, every failed tie, each named once
    for k in T6_TIES:
        if k not in args:
            ties[k] = "absent"
        elif want[k](args[k]):
            ties[k] = "agrees"
        elif not isinstance(args[k], str):
            ties[k] = "not one string"
            fails.append(f"the key {k} is not one string")
        elif k in ("type", "recipient_kind"):    # an enumeration: the observed value, as JSON, at most 40 characters
            seen = json.dumps(args[k])
            seen = seen if len(seen) <= 40 else seen[:37] + "..."
            ties[k] = f"differs (observed {seen})"
            fails.append(f"the key {k} disagrees (observed {seen})")
        else:                                    # recipient, a string other than to
            ties[k] = "differs"
            fails.append(f"the key {k} disagrees with to")

    def cut(keys):   # key names as T6.1 cuts them: each to 40 characters, sorted, the first 8, then the count left
        names = sorted(str(k)[:40] for k in keys)
        return ", ".join(names[:8]), f" (+{len(names) - 8} more)" if len(names) > 8 else ""
    shown, more = cut(args)
    tail = f"; keys [{shown}]{more}; ties " + ", ".join(f"{k} {ties[k]}" for k in T6_TIES)
    try:
        extra = [k for k in args if k not in T6_KEYS]
        present = [k for k in T6_PLATFORM if k in args]
        keys_bad = []
        if extra:
            keys_bad.append("the input keys not admitted: " + "".join(cut(extra)))
        if present and len(present) < len(T6_PLATFORM):
            keys_bad.append(f"a partial set of the platform's keys (present: {', '.join(present)}; missing: "
                            f"{', '.join(k for k in T6_PLATFORM if k not in args)})")
        if keys_bad:
            raise Bad("T6.1", "; ".join(keys_bad))
        if "to" not in args:
            raise Bad("T6.3", "the input has no to")
        if not isinstance(to, str):
            raise Bad("T6.2", f"to is a {type(to).__name__} value, not one string")
        if to == "":
            raise Bad("T6.3", "to is the empty string")
        if to == "*":
            raise Bad("T6.4", "to is *, a broadcast")
        if to.startswith(("session_", "cse_")):
            raise Bad("T6.5", "to is a session reference (session_ or cse_)")
        hooks = agent_hooks()
        try:
            records = hooks.read_registry(hooks.registry_path(session_key(data), LOG_DIR))
        except hooks.Unreadable as e:
            raise Bad("T6.9", f"no registry for this session ({e}); {T6_RETURN}")
        caller = data.get("agent_id")
        if caller is None and to == "main":
            raise Bad("T6.8", "main to main")
        if caller is not None and to == caller:
            raise Bad("T6.8", "a message to the caller's own ID")
        registered ={aid: v["agent_type"] for aid, v in hooks.merged_view(records).items()
                      if isinstance(v.get("agent_type"), str) and v["agent_type"]}
        if to == "main":
            target = "main"
        elif to in registered:
            target = registered[to]
        else:
            raise Bad("T6.6", "to is not an agent ID held in this session's registry (matched exactly; no name is "
                              "resolved)")
        ctype = registered.get(caller) if isinstance(caller, str) else None
        who = "the executor (main)" if caller is None else f"a registered {ctype}" if ctype else \
            "an agent this session's registry does not hold"
        if target == "main":
            ok = ctype is not None
        elif target in T6_FROM_MAIN_ONLY:
            ok = caller is None
        elif target in T6_FROM_REGISTERED:
            ok = caller is None or ctype is not None
        else:
            ok = False
        what = "main" if target == "main" else f"a registered {target}"
        if not ok:
            raise Bad("T6.7", f"a message to {what} from {who}")
        if fails:
            raise Bad("T6.10", "; ".join(fails))
    except Bad as b:
        b.detail += tail
        raise
    return "T6", f"a message to {what} from {who}, in this session's registry" + tail


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
    span = client_args(args, data) if name == "Bash" else None   # L5, the client path (W-C02-20 point 3)
    try:
        if span:
            s, e = span
            cmd = args["command"]
            token_stop(input_strings({**args, "command": cmd[:s] + " " + cmd[e:]}), claim_ok=[cmd[s:e]])
        elif name.startswith(ALLOWED_PREFIXES) or (name in ALLOWED_NON_MCP and name not in LOCAL_TOOLS):
            token_stop(input_strings(args))   # L4 before every other rule of an outbound call (W-C02-20 point 2)
        if any(isinstance(v, str) and "\x00" in v for v in args.values()):
            raise Bad("G0", "the tool input contains a NUL byte, which no real path or command needs")
        if data.get("agent_id") is not None and names_nonce_key(name, args):
            raise Bad("F6", f"a subagent's {name} call names the nonce key file (*{NONCE_KEY_SUFFIX})")
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
        if name == "SendMessage":
            try:                                         # T6's one catch: removed, T6.0's cases would reach G0
                rule, why = send_message_checks(data, args)
            except Bad:
                raise
            except Exception as exc:
                raise Bad("T6.0", f"could not check ({type(exc).__name__}); this call only is refused")
            return "allow", rule, why
        if name == "Workflow":
            raise Bad("TW", "the Workflow tool, whatever its input; the roles run through the Agent tool")
        if name in SUBAGENT_TOOLS:
            if args.get("isolation") is not None:
                raise Bad("T2", f"{name} with isolation '{args.get('isolation')}'")
            t = agent_type_check(name, args)
            if t in T5_TYPES:
                rule, why = t5(data, args, t)
                return "allow", rule, f"an in-process subagent of the role type '{t}' (T2, T4); {why}"
            return "allow", "T2", f"an in-process subagent of the role type '{t}' (T4)"
        if name == "Skill":
            s = args.get("skill")
            if not isinstance(s, str) or s not in repo_skills():
                raise Bad("T4", f"the skill '{s}' is not a directory under .claude/skills/ of the guard's checkout (a "
                                "plugin's or a built-in skill, for example)")
            return "allow", "T4", f"the repository's skill '{s}'"
        if name == "Bash":
            if args.get("dangerouslyDisableSandbox"):
                raise Bad("B10", "dangerouslyDisableSandbox is set")
            del CALL[:], PUSHES[:]
            shell_checks(str(args.get("command", "")), cwd)
            if PUSHES:
                push_alone()
                return "allow", "L1", push_leak_checks()
            if span:
                return "allow", "L5", ("the client path: tools/devos_rpc.py as merged, from the guard's tree, its "
                                       "arguments in a quoted here-string or here-document; no shell ban matched")
            return "allow", "B0", "no shell ban matched"
        if name in FILE_WRITE_TOOLS or name in FILE_READ_TOOLS:
            rule, why = file_checks(name, args)
            return "allow", rule, why
        return "allow", "T1", f"{name} is on the allow list"
    except Bad as b:
        if span and b.rule not in LEAK_WITHHELD:   # the client path's text is never repeated, nor a detail built from it
            return "deny", "L5", f"rule {b.rule} ({RULES.get(b.rule, RULES['G0'])[0]}) denies the client path's call"
        return "deny", b.rule, b.detail


# ---------------------------------------------------------------- output and log

def key_of(session):
    """The file-name key of a session ID: cse_ read as session_, every character outside [A-Za-z0-9_-] as _, at
    most 80 characters."""
    return re.sub(r"[^A-Za-z0-9_-]", "_", norm(session) or "unknown")[:80]


def session_key(data):
    """The one session key (W-C02-25): the guard log's file name without .jsonl, and the name of the session's agent
    registry and nonce key file. The cloud session's ID ($CLAUDE_CODE_REMOTE_SESSION_ID) when set, else the hook
    input's session_id. Imported by .claude/hooks/agent_hooks.py, tools/guard_report.py and tools/subagent_audit.py."""
    remote = norm(os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID") or "")   # the cloud session's ID
    local = data.get("session_id") if isinstance(data, dict) else None
    return re.sub(r"[^A-Za-z0-9_-]", "_", remote or str(local or "unknown"))[:80]


def log_decision(data, decision, rule, detail, text):
    try:
        os.makedirs(LOG_DIR, exist_ok=True)
        remote = norm(os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID") or "")   # the cloud session's ID
        sid = session_key(data)
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
    data, event, unread = {}, "PreToolUse", "the hook input is not JSON"
    raw = sys.stdin.read()
    try:
        data = json.loads(raw)
    except ValueError:
        data = None
    except RecursionError:   # nested deeper than the JSON reader reads: denied by G0 and logged like any other (N-269)
        data, unread = None, "the hook input is nested deeper than the guard's JSON reader reads"
    if sys.argv[1:] == ["PermissionRequest"] or (isinstance(data, dict)
                                                 and data.get("hook_event_name") == "PermissionRequest"):
        event = "PermissionRequest"    # the command names its event, for input that cannot be read (N-173)
    if data is None:
        decision, rule, detail = "deny", "G0", unread
    else:
        DEADLINE[0] = time.monotonic() + CALL_BUDGET   # the decision's slow steps share one budget (W-C00-14)
        try:
            decision, rule, detail = decide(data)
        except Exception as exc:   # an internal error: fail closed, and say so (the test asserts there are none)
            decision, rule, detail = "deny", "G0", f"guard error {type(exc).__name__}: {exc}"
        DEADLINE[0] = None         # withholding and logging below keep their own short limits
    if withheld(detail):           # the L details are built without text; any other detail is checked (W-C00-14)
        detail = "[withheld: the detail holds text that matches the library fingerprints or names a service]"
    ctx = data if isinstance(data, dict) else {}
    text = deny_text(ctx, rule, detail) if decision == "deny" else f"allowed by rule {rule}: {detail}"
    where = log_decision(ctx, decision, rule, detail, text)
    if decision == "pass":
        print(PASS_MARKER)         # an explicit answer: an exit 0 with no output is a failure (N-185)
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
