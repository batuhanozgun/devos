#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the agent IDs, session IDs, packages, prompts and
# reports below are made up for the test and hold no personal or business data. Not made up, because the rules under
# test name them: DevOS's own file paths, its role names, the platform's hook and tool names, and two filed records
# read at a pinned commit (EV-C02-030 parts 5 and 6, the one source of the complete hand-over fixtures).
"""test_agent_hooks.py: W-C02-25 (SB-COR 3.2 to 3.5 and 3.6a), written by the item's test designer before the product.

Every hook case drives the command exactly as `.claude/settings.json` holds it (bash -c, `$CLAUDE_PROJECT_DIR` set to
the tree under test), with a synthetic hook input on stdin, against a scratch `DEVOS_GUARD_LOG_DIR`, never the live
registry (SB-COR 1.1: negative cases only as synthetic hook inputs; 1.2: never a planted live report). Hook cases run
in a fixture tree: a copy of the head's `.claude/` and `tools/` (and the working order and ledger) with synthetic
packages under `.claude/roles/`, so that sizes and contents can be planted. Guard cases run the head's guard from the
repository root, as `tools/test_tool_allowlist.sh` does.

Usage: python3 tools/test_agent_hooks.py [--only PREFIX]   (from the root of a full devos clone at the head)
Prints one line per case, `ok   <ID> <label>` or `BAD  <ID> <label>: <why>`, then `AGENT_HOOKS_TEST PASS` (exit 0)
only if every case is ok, else `AGENT_HOOKS_TEST FAIL` (exit 1). A case that cannot run is BAD, never skipped.

The pinned interface this file reads is the acceptance condition's "Pinned interface" list in plan/work/W-C02-25.md;
[A] items come from the approach (EV-C02-030 part 9.1), [T] items are pinned there by the test designer.
"""
import ast
import fcntl
import hashlib
import hmac
import importlib.machinery
import importlib.util
import json
import os
import re
import shutil
import stat
import subprocess
import sys
import tempfile
import threading
import time
import uuid

REPO = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
BASE = "8db05b31c7b727690d3f07b17ef47ec6a68cd68e"      # this condition's base (main when it was written)
EV_SOURCE = "evidence/C02/EV-C02-030_m2_m3_triage.md"  # read at BASE only: the one source of the hand-over fixtures
ROLES = ("producer", "researcher", "prober", "checker", "test-designer")
MATCHER = "^(producer|researcher|prober|checker|test-designer)$"
EVENTS = ("SubagentStart", "SubagentStop", "PostToolUse", "SessionStart")
REG_KEYS = {"time", "event", "agent_id", "agent_type", "name", "item", "form", "tool_use_id", "prompt_sha256",
            "run", "outcome", "missing", "receipt", "package"}
SOURCES = ("startup", "resume", "clear", "compact", "fork")
HOOK_LIMIT = 9500
DISC = "## Disciplines (D1–D9)"

RESULTS = []
ONLY = sys.argv[sys.argv.index("--only") + 1] if "--only" in sys.argv else ""


def case(cid, label, ok, why=""):
    RESULTS.append(bool(ok))
    print(f"ok   {cid} {label}" if ok else f"BAD  {cid} {label}: {why}")


def guarded(cid, label, fn):
    """Run fn() -> (ok, why); an exception is a BAD case (a check that did not run never reads green)."""
    if ONLY and not cid.startswith(ONLY):
        return
    try:
        ok, why = fn()
    except Exception as exc:  # noqa: BLE001
        ok, why = False, f"could not run: {type(exc).__name__}: {str(exc)[:300]}"
    case(cid, label, ok, why)


def load(path, name):
    ldr = importlib.machinery.SourceFileLoader(name, path)
    built = importlib.util.module_from_spec(importlib.util.spec_from_loader(name, ldr))
    ldr.exec_module(built)
    return built


def git(*args, cwd=REPO):
    return subprocess.run(["git", *args], cwd=cwd, capture_output=True, check=True).stdout


def sha(b):
    return hashlib.sha256(b).hexdigest()


# ---------------------------------------------------------------- settings and fixture trees

def settings(root=REPO):
    with open(os.path.join(root, ".claude", "settings.json"), encoding="utf-8") as f:
        return json.load(f)


def agent_entries(event, root=REPO):
    """[(matcher, hook dict)] of every hook of `event` whose command names agent_hooks.py."""
    out = []
    for entry in settings(root).get("hooks", {}).get(event, []):
        for h in entry.get("hooks", []):
            if "agent_hooks.py" in str(h.get("command", "")):
                out.append((entry.get("matcher"), h))
    return out


def command_for(event, root):
    e = agent_entries(event, root)
    if len(e) != 1:
        raise RuntimeError(f"{len(e)} agent_hooks.py entries for {event} in settings.json (one needed)")
    return e[0][1]["command"]


def new_dir():
    return tempfile.mkdtemp(prefix="w25t-")


def fixture(packages=None):
    """A tree with the head's .claude/ and tools/ and synthetic packages. Returns its root."""
    root = new_dir()
    shutil.copytree(os.path.join(REPO, ".claude"), os.path.join(root, ".claude"), symlinks=True)
    shutil.copytree(os.path.join(REPO, "tools"), os.path.join(root, "tools"), symlinks=True,
                    ignore=shutil.ignore_patterns("__pycache__"))
    os.makedirs(os.path.join(root, "plan"), exist_ok=True)
    shutil.copy(os.path.join(REPO, "plan", "Installation_Working_Order.md"), os.path.join(root, "plan"))
    if os.path.isdir(os.path.join(REPO, "plan", "ledger")):
        shutil.copytree(os.path.join(REPO, "plan", "ledger"), os.path.join(root, "plan", "ledger"))
    rd = os.path.join(root, ".claude", "roles")
    os.makedirs(rd, exist_ok=True)
    for role in ROLES + ("executor",):
        text = (packages or {}).get(role, f"Synthetic package of the {role}.\nIts marker: PKG-{role}-7f3a.\n")
        with open(os.path.join(rd, f"{role}.md"), "wb") as f:
            f.write(text.encode("utf-8") if isinstance(text, str) else text)
    return root


class Run:
    """One synthetic session: a scratch log dir, a unique remote session ID, and a fixture tree."""

    def __init__(self, root=None, packages=None):
        self.root = root or fixture(packages)
        self.dir = new_dir()
        self.home = new_dir()
        self.sid = "cse_W25T" + uuid.uuid4().hex[:12]
        self.key = "session_" + self.sid[4:]
        self.local = "local-" + uuid.uuid4().hex[:8]

    def env(self, extra=None):
        env = {k: v for k, v in os.environ.items() if k not in ("CLAUDE_CODE_REMOTE_SESSION_ID",)}
        env.update({"CLAUDE_PROJECT_DIR": self.root, "DEVOS_GUARD_LOG_DIR": self.dir,
                    "DEVOS_AUDIT_HOME": self.home, "CLAUDE_CODE_REMOTE_SESSION_ID": self.sid,
                    "PYTHONDONTWRITEBYTECODE": "1"})
        env.update(extra or {})
        return {k: v for k, v in env.items() if v is not None}

    def hook(self, event, payload=None, raw=None, extra_env=None, timeout=40):
        cmd = command_for(event, self.root)
        data = raw if raw is not None else json.dumps(payload).encode()
        t0 = time.monotonic()
        p = subprocess.run(["bash", "-c", cmd], input=data, capture_output=True, env=self.env(extra_env),
                           cwd=self.root, timeout=timeout)
        return p.returncode, p.stdout.decode("utf-8", "replace"), p.stderr.decode("utf-8", "replace"), \
            time.monotonic() - t0

    @property
    def registry(self):
        return os.path.join(self.dir, f"{self.key}.agents")

    def records(self):
        with open(self.registry, "rb") as f:
            return [json.loads(x) for x in f.read().splitlines() if x.strip()]

    def keyfile(self):
        return os.path.join(self.dir, f"{self.key}.nonce-key")

    def nonce(self, agent_id):
        with open(self.keyfile(), "rb") as f:
            k = f.read()
        return hmac.new(k, agent_id.encode(), hashlib.sha256).hexdigest()[:16]

    def pkg(self, role):
        with open(os.path.join(self.root, ".claude", "roles", f"{role}.md"), "rb") as f:
            return f.read()

    # hook inputs (documented fields, hooks page, read 2026-10-20 [V])
    def start(self, agent_id, role):
        return self.hook("SubagentStart", {"session_id": self.local, "hook_event_name": "SubagentStart",
                                           "agent_id": agent_id, "agent_type": role, "cwd": self.root})

    def stop(self, agent_id, role, message, active=False, transcript=None, extra=None):
        p = {"session_id": self.local, "hook_event_name": "SubagentStop", "stop_hook_active": active,
             "agent_id": agent_id, "agent_type": role, "cwd": self.root,
             "agent_transcript_path": transcript or os.path.join(self.home, "absent", f"agent-{agent_id}.jsonl"),
             "last_assistant_message": message}
        p.update(extra or {})
        return self.hook("SubagentStop", p)

    def launch(self, role, prompt, agent_id=None, tool="Agent", tool_use_id=None):
        resp = {"status": "async_launched", "prompt": prompt, "outputFile": "/nonexistent/out"}
        if agent_id is not None:
            resp["agentId"] = agent_id
        return self.hook("PostToolUse", {"session_id": self.local, "hook_event_name": "PostToolUse",
                                         "tool_name": tool, "agent_id": None,
                                         "tool_use_id": tool_use_id or "toolu_" + uuid.uuid4().hex[:10],
                                         "tool_input": {"subagent_type": role, "prompt": prompt,
                                                        "description": "synthetic", "run_in_background": True},
                                         "tool_response": resp})

    def session_start(self, source):
        return self.hook("SessionStart", {"session_id": self.local, "hook_event_name": "SessionStart",
                                          "source": source})


def modules():
    m = {}
    m["crp"] = load(os.path.join(REPO, "tools", "check_role_packages.py"), "w25_crp")
    m["sa"] = load(os.path.join(REPO, "tools", "subagent_audit.py"), "w25_sa")
    return m


def header(role, data):
    return modules()["crp"].HEADER.format(role=role, sha12=sha(data)[:12])


def ctx_of(out):
    d = json.loads(out)["hookSpecificOutput"]
    if d.get("hookEventName") != "SubagentStart":
        raise RuntimeError("hookEventName is not SubagentStart")
    return d["additionalContext"]


def is_block(out):
    if not out.strip():
        return False
    try:
        d = json.loads(out)
    except ValueError:
        return False
    return d.get("decision") == "block"


# ---------------------------------------------------------------- the report fixtures (one source each)

def ev_part(n):
    """EV-C02-030 part n as filed at BASE: the lines after its heading up to the next part's heading."""
    text = git("show", f"{BASE}:{EV_SOURCE}").decode("utf-8")
    lines = text.split("\n")
    start = next(i for i, ln in enumerate(lines) if ln.startswith(f"## {n}. "))
    end = next(i for i, ln in enumerate(lines) if i > start and re.match(r"## \d+\. ", ln))
    return "\n".join(lines[start + 1:end]).strip("\n") + "\n"


def set_line(text, prefix, value):
    """Replace the first line starting with prefix by prefix + ' ' + value (generated, never hand-edited)."""
    lines = text.split("\n")
    i = next(i for i, ln in enumerate(lines) if ln.startswith(prefix))
    lines[i] = f"{prefix} {value}"
    return "\n".join(lines)


def drop_lines(text, prefix):
    return "\n".join(ln for ln in text.split("\n") if not ln.startswith(prefix))


def drop_disciplines(text):
    lines, out, skip = text.split("\n"), [], 0
    for ln in lines:
        if ln.strip() == DISC:
            skip = 9
            continue
        if skip and re.match(r"(?:[-*] )?D\d:", ln.strip()):
            skip -= 1
            continue
        out.append(ln)
    return "\n".join(out)


def handover(run, agent_id, role, part=6):
    """A complete hand-over with a delivered package and the right nonce, generated from EV part 6 (or 5)."""
    t = ev_part(part)
    t = set_line(t, "Package:", f"{role}@{sha(run.pkg(role))[:12]}")
    return set_line(t, "Nonce:", run.nonce(agent_id))


def minimal(package="none delivered", nonce="none delivered", take_up="NOT_NEEDED: X already shows it",
            product="none", disc=True, extra=None, omit=()):
    parts = [("Package:", package), ("Nonce:", nonce), ("Take-up:", take_up)]
    body = [f"{h} {v}" for h, v in parts if h not in omit]
    if disc:
        body += [DISC] + [f"D{i}: no" for i in range(1, 10)]
    for h, v in [("Read, and what each changed:", "none"), ("Relied on:", "none"), ("Unsure:", "none"),
                 ("For:", "the executor"), ("Received from / Returned to:", "none"), ("Product:", product),
                 ("Guard denials:", "none")]:
        if h not in omit:
            body.append(f"{h} {v}")
    body += list(extra or [])
    return "\n".join(body) + "\n"


def verdict(run, agent_id, drop=()):
    """A binding verdict filled from checker.md's template at the head by a stated fill map."""
    text = open(os.path.join(REPO, ".claude", "agents", "checker.md"), encoding="utf-8").read()
    i = text.index("**Binding verdict:**")
    a = text.index("```\n", i) + 4
    b = text.index("```", a)
    tpl = text[a:b].split("\n")
    fill = {"id": "CHK-C02-999", "reviewed_head": "a" * 40, "verdict": "PASS", "conditions": "none",
            "date": "2026-10-20", "package": f"checker@{sha(run.pkg('checker'))[:12]}",
            "nonce": run.nonce(agent_id), "take_up": "PROCEED: the task holds", "floor": "none",
            "own_breaks": "none", "producer_run": "none", "item": "W-C02-99", "shared_with_producer": "none"}
    out, fm = [], 0
    for ln in tpl:
        if ln == "---":
            fm += 1
            out.append(ln)
            continue
        if fm == 1:
            k = ln.split(":", 1)[0]
            if k in drop:
                continue
            v = ln.split(":", 1)[1].strip() if ":" in ln else ""
            out.append(f"{k}: {fill.get(k, v if '<' not in v else 'synthetic value')}")
            continue
        if ln.startswith("<nine lines"):
            out += [f"D{n}: no" for n in range(1, 10)]
        elif ln.startswith("<one finding"):
            out.append("No finding.")
        elif ln.startswith("C<n>"):
            continue
        else:
            out.append(ln)
    return "\n".join(out) + "\n"


def verdict_keys_from_template():
    text = open(os.path.join(REPO, ".claude", "agents", "checker.md"), encoding="utf-8").read()
    i = text.index("**Binding verdict:**")
    a = text.index("```\n", i) + 4
    block = text[a:text.index("```", a)].split("---")[1]
    return [ln.split(":", 1)[0] for ln in block.strip().split("\n") if ":" in ln]


def output_headings(role):
    text = open(os.path.join(REPO, ".claude", "agents", f"{role}.md"), encoding="utf-8").read()
    sec = text[text.index("\n## Output"):]
    return [m.group(1) for m in re.finditer(r"^- `([^`#][^`]*:)`", sec, re.M)]


# ---------------------------------------------------------------- ST: settings, static (approach "Method"; M3a)

def st_cases():
    s, base = settings(), json.loads(git("show", f"{BASE}:.claude/settings.json"))

    def st1():
        bad = []
        for ev in EVENTS:
            e = agent_entries(ev)
            if len(e) != 1:
                bad.append(f"{ev}: {len(e)} entries")
                continue
            h = e[0][1]
            want = f'python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/agent_hooks.py" {ev} || true'
            if h.get("command") != want:
                bad.append(f"{ev}: command differs")
            if h.get("timeout") != 15 or "onFailure" in h or h.get("type") != "command":
                bad.append(f"{ev}: timeout/onFailure/type")
        return not bad, "; ".join(bad)
    guarded("ST1", "one agent_hooks.py entry per event, the pinned command, timeout 15, no onFailure", st1)

    def st2():
        guard = load(os.path.join(REPO, ".claude", "hooks", "tool_allowlist.py"), "w25_guard_st")
        want = "^(" + "|".join(guard.ROLE_TYPES) + ")$"
        ms = [agent_entries(ev)[0][0] for ev in ("SubagentStart", "SubagentStop")]
        names = sorted(re.search(r"^name: (.+)$", open(os.path.join(REPO, ".claude", "agents", f"{r}.md"),
                                                         encoding="utf-8").read(), re.M).group(1) for r in ROLES)
        ok = ms == [MATCHER, MATCHER] and want == MATCHER and names == sorted(ROLES)
        return ok, f"matchers {ms}, from ROLE_TYPES {want}, names {names}"
    guarded("ST2", "SubagentStart/Stop matcher equals M1a's ROLE_TYPES and the role files' name:", st2)

    def st3():
        m = agent_entries("SubagentStart")[0][0]
        yes = [r for r in ROLES if not re.fullmatch(m, r)]
        no = [t for t in ("counter-designer", "general-purpose", "", "Explore", "Plan", "claude", "fork",
                          "Producer", "producerx", "checker ") if re.fullmatch(m, t)]
        return not yes and not no, f"misses {yes}, matches {no}"
    guarded("ST3", "the matcher covers the five roles and no other type (internal '' included)", st3)

    def st4():
        m = agent_entries("PostToolUse")[0][0]
        ok = all(re.fullmatch(m, t) for t in ("Agent", "Task")) and \
            not any(re.fullmatch(m, t) for t in ("Agents", "Bash", "SendMessage", "Workflow"))
        return ok, f"matcher {m!r}"
    guarded("ST4", "PostToolUse matcher is Agent and Task only", st4)

    def st5():
        m = agent_entries("SessionStart")[0][0]
        ok = m in (None, "") or all(re.fullmatch(m, x) for x in SOURCES)
        return ok, f"matcher {m!r}"
    guarded("ST5", "SessionStart: no matcher, or one covering startup|resume|clear|compact|fork", st5)

    def st6():
        bad = []
        for ev in ("PreToolUse", "PermissionRequest"):
            if json.dumps(s["hooks"][ev][0], sort_keys=True) != json.dumps(base["hooks"][ev][0], sort_keys=True):
                bad.append(f"{ev}[0] changed")
            if len(s["hooks"][ev]) != len(base["hooks"][ev]):
                bad.append(f"{ev} gained or lost an entry")
        for ev, entries in base["hooks"].items():
            for e in entries:
                if json.dumps(e, sort_keys=True) not in [json.dumps(x, sort_keys=True) for x in s["hooks"].get(ev, [])]:
                    bad.append(f"base {ev} entry {e.get('matcher')!r} not kept byte-identical")
        for ev, entries in s["hooks"].items():
            for e in entries:
                if json.dumps(e, sort_keys=True) in [json.dumps(x, sort_keys=True) for x in base["hooks"].get(ev, [])]:
                    continue
                if not all("agent_hooks.py" in h.get("command", "") for h in e.get("hooks", [])):
                    bad.append(f"new {ev} entry that is not agent_hooks.py")
        return not bad, "; ".join(bad)
    guarded("ST6", "guard at index [0] of PreToolUse/PermissionRequest and every base hook entry byte-identical", st6)

    def st7():
        bad = []
        want = [x for x in base["permissions"]["deny"] if x != "SendMessage"]
        if s["permissions"]["deny"] != want:
            bad.append("deny is not the base list minus SendMessage, in order")
        if "ListAgents" not in s["permissions"]["deny"]:
            bad.append("ListAgents not denied")
        if s.get("isolatePeerMachines") is not True:
            bad.append("isolatePeerMachines is not top-level true")
        if s.get("crossSessionInbound") != "refuse":
            bad.append("crossSessionInbound changed")
        for k in set(base) | set(s):
            if k in ("hooks", "permissions", "isolatePeerMachines"):
                continue
            if json.dumps(base.get(k), sort_keys=True) != json.dumps(s.get(k), sort_keys=True):
                bad.append(f"top-level {k} changed")
        for k in set(base["permissions"]) | set(s["permissions"]):
            if k != "deny" and base["permissions"].get(k) != s["permissions"].get(k):
                bad.append(f"permissions.{k} changed")
        return not bad, "; ".join(bad)
    guarded("ST7", "M3a: SendMessage leaves deny; isolatePeerMachines true; ListAgents, crossSessionInbound kept", st7)

    def st8():
        missing = []
        for ev, entries in s["hooks"].items():
            for e in entries:
                for h in e.get("hooks", []):
                    for p in re.findall(r"\$CLAUDE_PROJECT_DIR/([^\"' ]+\.py)", h.get("command", "")):
                        if not os.path.isfile(os.path.join(REPO, p)):
                            missing.append(p)
        return not missing, f"missing {missing}"
    guarded("ST8", "every hook command path in settings.json exists at the head", st8)


# ---------------------------------------------------------------- K: one session key (approach "Session key")

def old_key(env_id, session_id):
    """The base's inline derivation (tool_allowlist.py:2260-2261 at BASE), restated as the independent oracle."""
    remote = ("session_" + env_id[4:] if env_id.startswith("cse_") else env_id) if env_id else ""
    return re.sub(r"[^A-Za-z0-9_-]", "_", remote or str(session_id or "unknown"))[:80]


K_CASES = [("K1", "cse_W25K1ab12", "loc-k1"), ("K2", "session_W25K2cd34", "loc-k2"), ("K3", None, "w25k3-local-uuid"),
           ("K4", "cse_W25K4.a/b", "loc-k4"), ("K5", "cse_" + "W25K5" + "a" * 91, "loc-k5")]


def k_cases():
    for cid, env_id, sid in K_CASES:
        def one(env_id=env_id, sid=sid):
            want = old_key(env_id, sid)
            d = new_dir()
            env = {k: v for k, v in os.environ.items() if k != "CLAUDE_CODE_REMOTE_SESSION_ID"}
            env["DEVOS_GUARD_LOG_DIR"] = d
            if env_id:
                env["CLAUDE_CODE_REMOTE_SESSION_ID"] = env_id
            data = {"session_id": sid, "hook_event_name": "PreToolUse", "tool_name": "TodoWrite",
                    "tool_input": {"todos": []}, "agent_id": None}
            cmd = settings()["hooks"]["PreToolUse"][0]["hooks"][0]["command"]
            subprocess.run(["sh", "-c", cmd], input=json.dumps(data).encode(), capture_output=True,
                           env={**env, "CLAUDE_PROJECT_DIR": REPO}, cwd=REPO, timeout=120)
            logs = [f for f in os.listdir(d) if f.endswith(".jsonl")]
            p = subprocess.run([sys.executable, "-I", "-c",
                                "import json,sys;sys.path.insert(0,sys.argv[1]);import tool_allowlist as g;"
                                "print(g.session_key(json.loads(sys.argv[2])))",
                                os.path.join(REPO, ".claude", "hooks"), json.dumps(data)],
                               capture_output=True, env=env, timeout=60)
            fn = p.stdout.decode().strip()
            r = Run()
            r.sid = env_id
            r.key = want
            r.local = sid
            hook_env = {"CLAUDE_CODE_REMOTE_SESSION_ID": env_id}
            r.hook("PostToolUse", {"session_id": sid, "hook_event_name": "PostToolUse", "tool_name": "Agent",
                                   "agent_id": None, "tool_use_id": "toolu_k", "tool_input":
                                   {"subagent_type": "checker", "prompt": "x", "description": "d"},
                                   "tool_response": {"status": "async_launched", "agentId": "k1agent"}},
                   extra_env=hook_env)
            regs = [f for f in os.listdir(r.dir) if f.endswith(".agents")]
            gr = subprocess.run([sys.executable, os.path.join(REPO, "tools", "guard_report.py"), "--dir", d],
                                capture_output=True, env=env, timeout=60)
            first = gr.stdout.decode().split("\n")[0]
            ok = logs == [want + ".jsonl"] and fn == want and regs == [want + ".agents"] and gr.returncode == 0 \
                and (want + ".jsonl") in first
            return ok, (f"want {want!r}; guard log {logs}; session_key {fn!r} (stderr {p.stderr.decode()[-120:]!r}); "
                        f"registry {regs}; guard_report rc {gr.returncode} {first[:120]!r}")
        guarded(cid, f"one key in guard log, session_key(), registry and guard_report ({env_id!r}, {sid!r})", one)

    def k6():
        bad = []
        for p in ("tools/guard_report.py", "tools/subagent_audit.py", ".claude/hooks/agent_hooks.py"):
            t = open(os.path.join(REPO, p), encoding="utf-8").read()
            if "session_key" not in t:
                bad.append(f"{p} does not use session_key")
        # No text check for a derivation (CHK-C02-134 C5): a literal "cse_" fails a sound consumer that only names it in
        # a comment and passes a derivation written without it. A consumer's own derivation is judged by behaviour in
        # K4 and K5 (where it diverges from the guard's); an identical copy is a named limit (condition point 3).
        g = open(os.path.join(REPO, ".claude", "hooks", "tool_allowlist.py"), encoding="utf-8").read()
        fn = g[g.index("def log_decision"):]
        fn = fn[:fn.index("\ndef ", 10)]
        if "session_key(" not in fn:
            bad.append("log_decision does not call session_key")
        return not bad, "; ".join(bad)
    guarded("K6", "every consumer uses session_key; log_decision calls it", k6)


# ---------------------------------------------------------------- R: the registry (approach "Registry")

W_PROMPT = "Item: plan/work/W-C02-25.md\nWriter or reader: writer of these files\nSecret-marker REGPROMPT-91c2\n"


def r_cases():
    def r1():
        r = Run()
        rc, out, err, _ = r.launch("producer", W_PROMPT, agent_id="r1agent0001", tool_use_id="toolu_r1")
        recs = r.records()
        raw = open(r.registry, "rb").read()
        rec = recs[-1] if recs else {}
        ok = (rc == 0 and out == "" and len(recs) == 1 and set(rec) == REG_KEYS and rec["event"] == "launch"
              and rec["agent_id"] == "r1agent0001" and rec["agent_type"] == "producer"
              and rec["item"] == "plan/work/W-C02-25.md" and rec["form"] == "writer"
              and rec["tool_use_id"] == "toolu_r1" and rec["prompt_sha256"] == sha(W_PROMPT.encode())
              and b"REGPROMPT-91c2" not in raw)
        return ok, f"rc {rc} out {out[:80]!r} records {recs}"
    guarded("R1", "launch record: the fixed keys, item, form, tool_use_id, prompt SHA-256, no prompt text", r1)

    def r2():
        r = Run()
        r.launch("producer", "Item: plan/work/W-C02-25.md (triage)\nWriter or reader: reader, a triage note\n",
                 agent_id="r2agent0001")
        r.launch("checker", "Purpose: check it\nWriter or reader: reader\n", agent_id="r2agent0002")
        a, b = r.records()
        ok = a["item"] == "plan/work/W-C02-25.md" and a["form"] == "reader" and b["item"] is None
        return ok, f"{a} / {b}"
    guarded("R2", "reader form binds its item; a launch with no Item: line binds none", r2)

    def r3():
        r = Run()
        r.launch("producer", W_PROMPT, agent_id=None)
        recs = r.records()
        ok = len(recs) == 1 and recs[0]["agent_id"] is None and recs[0]["item"] is None and not any(
            x.get("agent_id") and x.get("item") for x in recs)
        return ok, f"{recs}"
    guarded("R3", "no tool_response.agentId: agent_id and item null; no item bound to any agent", r3)

    def r4():
        """One parser: the recorder's item and form agree with T5's parse on every grammar case."""
        corpus = [  # (label, role, prompt, expected form, expected item or 'any', T5 rule set that must NOT occur)
            ("plain writer", "producer", "Item: plan/work/W-C02-25.md\nWriter or reader: writer\n", "writer",
             "plan/work/W-C02-25.md"),
            ("bold writer", "producer", "**Item:** plan/work/W-C02-25.md\n**Writer or reader:** WRITER of x\n",
             "writer", "plan/work/W-C02-25.md"),
            ("reader", "producer", "Writer or reader: reader\nItem: plan/work/W-C02-25.md (triage)\n", "reader",
             "plan/work/W-C02-25.md"),
            ("two Item lines", "producer",
             "Item: plan/work/W-C02-25.md\nItem: plan/work/W-C02-24.md\nWriter or reader: writer\n", "writer", None),
            ("trailing text", "producer", "Item: plan/work/W-C02-25.md now\nWriter or reader: writer\n", "writer", None),
            ("CR line end", "producer", "Item: plan/work/W-C02-25.md\r\nWriter or reader: writer\n", "writer", None),
            ("no form line", "producer", "Item: plan/work/W-C02-25.md\n", None, "any"),
            ("other word", "producer", "Item: plan/work/W-C02-25.md\nWriter or reader: maybe\n", None, "any"),
            ("two form lines", "producer",
             "Item: plan/work/W-C02-25.md\nWriter or reader: writer\nWriter or reader: reader\n", None, "any"),
            ("test designer, not whole", "test-designer",
             "Item: plan/work/W-C02-25.md (acceptance)\nWriter or reader: writer of these files\n", "writer",
             "plan/work/W-C02-25.md"),
        ]
        T5_PARSE = {"T5.1", "T5.2", "T5.3", "T5.5", "T5.6", "T5.7"}
        bad = []
        for label, role, prompt, form, item in corpus:
            r = Run()
            r.launch(role, prompt, agent_id="r4agent0001")
            rec = r.records()[-1]
            rule = guard_rule({"tool_name": "Agent", "tool_input": {"subagent_type": role, "prompt": prompt},
                               "agent_id": None})[1]
            t5_item_ok = rule not in T5_PARSE and rule != "T5.0"
            if rec["form"] != form:
                bad.append(f"{label}: form {rec['form']!r} != {form!r}")
            if item != "any" and rec["item"] != item:
                bad.append(f"{label}: item {rec['item']!r} != {item!r}")
            if item not in ("any", None) and not t5_item_ok:
                bad.append(f"{label}: T5 refused the parse ({rule}) where an item is expected")
            if item is None and form is not None and t5_item_ok:
                bad.append(f"{label}: T5 accepted the parse ({rule}) where no item is expected")
        return not bad, "; ".join(bad)
    guarded("R4", "one parser: recorder item/form agree with T5 on ten grammar cases", r4)

    def r5():
        ah = load(os.path.join(REPO, ".claude", "hooks", "agent_hooks.py"), "w25_ah_r5")
        r1, r2 = Run(), Run()
        r1.launch("producer", W_PROMPT, agent_id="r5agent0001")
        r1.start("r5agent0001", "producer")
        r2.root = r1.root
        r2.start("r5agent0001", "producer")
        r2.launch("producer", W_PROMPT, agent_id="r5agent0001")
        a, b = ah.merged_view(r1.records()), ah.merged_view(r2.records())
        v = a.get("r5agent0001", {})
        ok = a == b and v.get("item") == "plan/work/W-C02-25.md" and v.get("agent_type") == "producer" \
            and v.get("runs") == 1 and v.get("form") == "writer"
        return ok, f"{a} vs {b}"
    guarded("R5", "either arrival order of launch and Start gives the same merged view", r5)

    def r6():
        r = Run()
        r.start("r6agent0001", "checker")
        live = os.path.join("/tmp/devos-guard", f"{r.key}.agents")
        return os.path.isfile(r.registry) and not os.path.exists(live), "registry not in the fixture dir, or live"
    guarded("R6", "DEVOS_GUARD_LOG_DIR honoured: the record lands in the scratch dir, never the live one", r6)

    def r7():
        r = Run()
        r.start("r7agent0001", "checker")
        f = open(r.registry, "a+b")
        fcntl.flock(f, fcntl.LOCK_EX)
        try:
            rc1, out1, _, t1 = r.stop("r7agent0001", "checker", "incomplete report")
            rc2, out2, _, t2 = r.start("r7agent0002", "prober")
        finally:
            f.close()
        ok = rc1 == 0 and out1 == "" and rc2 == 0 and t1 < 15 and t2 < 15
        return ok, f"stop rc {rc1} out {out1[:60]!r} {t1:.1f}s; start rc {rc2} {t2:.1f}s"
    guarded("R7", "registry lock held: Stop and Start end within the 15 s timeout, exit 0, no block", r7)

    def r8():
        r = Run()
        def go(i):
            try:
                r.launch("checker", "x", agent_id=f"r8agent{i:04d}")
            except Exception:  # noqa: BLE001  (the count below decides)
                pass
        ths = [threading.Thread(target=go, args=(i,)) for i in range(12)]
        for t in ths:
            t.start()
        for t in ths:
            t.join()
        recs = r.records()
        return len(recs) == 12 and len({x["agent_id"] for x in recs}) == 12, f"{len(recs)} records"
    guarded("R8", "12 parallel launches give 12 whole records (counted; flock itself is judged by reading)", r8)


# ---------------------------------------------------------------- S: the start hook (approach "Nonce", "SubagentStart")

def s_cases():
    def s1():
        r = Run()
        rc, out, _, _ = r.start("s1agent0001", "researcher")
        ctx = ctx_of(out)
        lines = ctx[:-1].split("\n") if ctx.endswith("\n") else ctx.split("\n")
        pkg = r.pkg("researcher").decode()
        body = "\n".join(lines[1:-2]) + "\n"
        ok = (rc == 0 and lines[0] == header("researcher", r.pkg("researcher")) and body == pkg
              and lines[-2] == "Your agent ID: s1agent0001" and lines[-1] == f"Nonce: {r.nonce('s1agent0001')}")
        return ok, f"first {lines[0]!r}; last two {lines[-2:]!r}; body equal {body == pkg}"
    guarded("S1", "header, package bytes, agent ID, HMAC nonce as the last line", s1)

    def s2():
        r = Run()
        r.start("s2agent0001", "prober")
        st = os.stat(r.keyfile())
        return os.path.getsize(r.keyfile()) == 32 and stat.S_IMODE(st.st_mode) == 0o600, \
            f"size {os.path.getsize(r.keyfile())} mode {oct(stat.S_IMODE(st.st_mode))}"
    guarded("S2", "the key file: 32 bytes, mode 0600, <LOG_DIR>/<key>.nonce-key", s2)

    def s3():
        r = Run()
        o1 = ctx_of(r.start("s3agent0001", "checker")[1])
        k1 = sha(open(r.keyfile(), "rb").read())
        o2 = ctx_of(r.start("s3agent0001", "checker")[1])
        o3 = ctx_of(r.start("s3agent0002", "checker")[1])
        last = lambda c: c.rstrip("\n").split("\n")[-1]  # noqa: E731
        k2 = sha(open(r.keyfile(), "rb").read())
        ok = last(o1) == last(o2) and last(o1) != last(o3) and k1 == k2
        return ok, f"{last(o1)} {last(o2)} {last(o3)} key kept {k1 == k2}"
    guarded("S3", "a resume gives a byte-identical last line; another agent ID another nonce; key kept", s3)

    def s4():
        r = Run()
        with open(r.keyfile(), "wb") as f:
            f.write(bytes(range(32)))
        os.chmod(r.keyfile(), 0o600)
        c = ctx_of(r.start("s4agent0001", "producer")[1])
        want = hmac.new(bytes(range(32)), b"s4agent0001", hashlib.sha256).hexdigest()[:16]
        return c.rstrip("\n").endswith(f"Nonce: {want}"), "an existing key file was not used (O_EXCL, created once)"
    guarded("S4", "an existing key file is used, never replaced", s4)

    def s5():
        crp = modules()["crp"]
        aid = "s" * 64
        r = Run()
        rc, out, _, _ = r.start(aid, "test-designer")
        added = len(ctx_of(out).encode()) - len(r.pkg("test-designer"))
        return added <= crp.RESERVE, f"added {added} bytes > RESERVE {crp.RESERVE}"
    guarded("S5", "the three added lines fit in RESERVE (longest role name, 64-character agent ID)", s5)

    def s6():
        aid = "s6" + "x" * 62
        r0 = Run()
        overhead = len(ctx_of(r0.start(aid, "test-designer")[1]).encode()) - len(r0.pkg("test-designer"))
        bad = []
        for total, emit in ((HOOK_LIMIT, True), (HOOK_LIMIT + 1, False)):
            n = total - overhead
            body = ("–" * ((n - 1) // 3)) + "a" * ((n - 1) % 3) + "\n"   # en dashes: bytes != characters
            assert len(body.encode()) == n
            r = Run(packages={"test-designer": body})
            rc, out, _, _ = r.start(aid, "test-designer")
            rec = r.records()[-1] if os.path.exists(r.registry) else {}
            if emit and (rc != 0 or len(ctx_of(out).encode()) != HOOK_LIMIT):
                bad.append(f"{total}: not emitted whole")
            if not emit and (rc != 0 or out != "" or rec.get("outcome") != "oversize"):
                bad.append(f"{total}: out {out[:40]!r} record {rec}")
        return not bad, "; ".join(bad) + f" (overhead {overhead})"
    guarded("S6", "9,500 UTF-8 bytes emitted; 9,501 emits nothing and records oversize (bytes, not characters)", s6)

    def s7():
        r = Run()
        bad = []
        for role in ROLES:
            c = ctx_of(r.start(f"s7{role.replace('-', '')}01", role)[1])
            if c.split("\n")[0] != header(role, r.pkg(role)) or f"PKG-{role}-7f3a" not in c:
                bad.append(role)
        return not bad, f"wrong package or header for {bad}"
    guarded("S7", "each of the five roles gets its own package and header", s7)

    def s8():
        t = open(os.path.join(REPO, ".claude", "hooks", "agent_hooks.py"), encoding="utf-8").read()
        tree = ast.parse(t)
        lits = [n.value for n in ast.walk(tree) if isinstance(n, ast.Constant) and isinstance(n.value, str)]
        assigns = [tg.id for n in ast.walk(tree) if isinstance(n, ast.Assign) for tg in n.targets
                   if isinstance(tg, ast.Name)]
        ok = not any("DevOS role package" in x for x in lits) and "RESERVE" not in assigns and "HEADER" not in assigns
        return ok, "agent_hooks.py restates HEADER or RESERVE instead of importing them (W25-9)"
    guarded("S8", "HEADER and RESERVE imported from tools/check_role_packages.py, not restated", s8)

    def s9():
        r = Run()
        r.start("s9agent0001", "checker")
        r.start("s9agent0001", "checker")
        a, b = [x for x in r.records() if x["event"] == "start"]
        p = f"checker@{sha(r.pkg('checker'))[:12]}"
        ok = set(a) == REG_KEYS and a["run"] == 1 and b["run"] == 2 and a["package"] == p and \
            a["agent_type"] == "checker" and r.nonce("s9agent0001").encode() not in open(r.registry, "rb").read()
        return ok, f"{a} / {b}"
    guarded("S9", "start records: run ordinal, package <role>@<sha12>, no nonce stored", s9)

    def s10():
        r = Run()
        os.remove(os.path.join(r.root, ".claude", "roles", "prober.md"))
        rc1, o1, _, _ = r.start("s10agent001", "prober")
        rc2, o2, _, _ = r.start("s10agent002", "general-purpose")
        return rc1 == 0 and o1 == "" and rc2 == 0 and o2 == "", f"{rc1} {o1[:40]!r} {rc2} {o2[:40]!r}"
    guarded("S10", "a missing package, or a type outside the roles, emits nothing and exits 0", s10)


# ---------------------------------------------------------------- SS: SessionStart (approach "SessionStart")

def ss_cases():
    def ss1():
        r = Run()
        bad = []
        for src in SOURCES:
            rc, out, _, _ = r.session_start(src)
            want = header("executor", r.pkg("executor")) + "\n" + r.pkg("executor").decode()
            if rc != 0 or out.rstrip("\n") != want.rstrip("\n"):
                bad.append(src)
        recs = [x for x in r.records() if x["event"] == "session_start"]
        srcs = [s for s in SOURCES if any(s in [str(v) for v in x.values()] for x in recs)]
        p = f"executor@{sha(r.pkg('executor'))[:12]}"
        if len(recs) != 5 or srcs != list(SOURCES) or any(x.get("package") != p for x in recs):
            bad.append(f"records {recs}")
        return not bad, f"{bad}"
    guarded("SS1", "every source: plain stdout header + executor.md; a session_start record with source and hash", ss1)

    def ss2():
        r = Run(root=fixture(packages={"executor": open(os.path.join(REPO, ".claude", "roles", "executor.md"),
                                                         "rb").read()}))
        out = r.session_start("compact")[1]
        msg = subprocess.run([sys.executable, os.path.join(r.root, ".claude", "hooks", "reread_after_compact.py")],
                             input=b"{}", capture_output=True, timeout=30).stdout
        total = len(out.encode()) + len(msg)
        return out and total <= HOOK_LIMIT, f"compact output {len(out.encode())} + re-read {len(msg)} = {total}"
    guarded("SS2", "at compact, the real executor package and the re-read message fit 9,500 bytes", ss2)


# ---------------------------------------------------------------- C: the stop hook (approach "SubagentStop")

def stopped(r, aid, role, msg, **kw):
    rc, out, err, secs = r.stop(aid, role, msg, **kw)
    recs = [x for x in r.records() if x["event"] == "stop" and x["agent_id"] == aid] if os.path.exists(r.registry) \
        else []
    return rc, out, recs[-1] if recs else {}


def reason_ok(out, r, aid, role, part):
    d = json.loads(out)
    R = d.get("reason", "")
    bad = []
    if len(R) > 1000:
        bad.append(f"reason {len(R)} chars")
    if part not in R:
        bad.append(f"reason does not name {part!r}")
    if f".claude/roles/{role}.md" not in R:
        bad.append("reason does not name the package path")
    if "whole final message" not in R.lower():
        bad.append("reason does not ask for the whole final message")
    if r.nonce(aid) in R or f"PKG-{role}-7f3a" in R:
        bad.append("reason carries the nonce or package text")
    return bad


def c_cases():
    heads = output_headings("producer")   # the role file is the source; H1 ties the constant to it

    def c0():
        r = Run()
        r.start("c0agent0001", "producer")
        rc, out, rec = stopped(r, "c0agent0001", "producer", handover(r, "c0agent0001", "producer"))
        return rc == 0 and out == "" and rec.get("receipt") == "delivered" and \
            rec.get("prompt_sha256") == sha(handover(r, "c0agent0001", "producer").encode()), f"{out[:200]!r} {rec}"
    guarded("C0", "control: a complete hand-over (EV part 6, delivered) ends with no block; receipt delivered", c0)

    for i, h in enumerate(heads, 1):
        def one(h=h, i=i):
            r = Run()
            aid = f"c{i}agent00{i:02d}"
            r.start(aid, "researcher")
            msg = drop_lines(handover(r, aid, "researcher"), h)
            rc, out, rec = stopped(r, aid, "researcher", msg)
            if not is_block(out):
                return False, f"no block: {out[:120]!r}"
            bad = reason_ok(out, r, aid, "researcher", h)
            if rec.get("outcome") != "block" or h not in (rec.get("missing") or []):
                bad.append(f"record {rec}")
            return not bad, "; ".join(bad)
        guarded(f"C{i}", f"heading {h!r} missing: blocked once, with a fixed reason", one)

    def c_disc():
        r = Run()
        r.start("cdagent0001", "prober")
        rc, out, rec = stopped(r, "cdagent0001", "prober", drop_disciplines(handover(r, "cdagent0001", "prober")))
        bad = [] if is_block(out) else ["no block"]
        if not bad:
            bad = reason_ok(out, r, "cdagent0001", "prober", DISC)
        return not bad and DISC in (rec.get("missing") or []), f"{bad} {rec}"
    guarded("C11", "disciplines block missing: blocked", c_disc)

    def c_disc8():
        r = Run()
        r.start("cd8agent001", "prober")
        msg = drop_lines(handover(r, "cd8agent001", "prober"), "D9:")
        return is_block(stopped(r, "cd8agent001", "prober", msg)[1]), "eight answers not blocked"
    guarded("C11b", "a disciplines block with eight answers: blocked (subagent_audit's parser)", c_disc8)

    def c12():
        r = Run()
        r.start("c12agent001", "checker")
        msg = set_line(handover(r, "c12agent001", "checker", part=5), "Nonce:", "0123456789abcdef")
        rc, out, rec = stopped(r, "c12agent001", "checker", msg)
        bad = [] if is_block(out) else ["no block"]
        if not bad:
            bad = reason_ok(out, r, "c12agent001", "checker", "Nonce:")
        return not bad, "; ".join(bad) + f" {rec}"
    guarded("C12", "a wrong nonce with a delivered Package: blocked; the reason never carries the nonce", c12)

    def c13():
        r = Run()
        r.start("c13agent001", "producer")
        msg = set_line(handover(r, "c13agent001", "producer"), "Nonce:", "none delivered")
        return is_block(stopped(r, "c13agent001", "producer", msg)[1]), "Package names a delivery, no nonce: no block"
    guarded("C13", "Package: names a delivery but Nonce: none delivered: blocked", c13)

    def c14():
        r = Run()
        r.start("c14agent001", "producer")
        rc, out, rec = stopped(r, "c14agent001", "producer", ev_part(6))   # Package: none delivered (file absent)
        return rc == 0 and out == "" and rec.get("receipt") == "not_delivered", f"{out[:120]!r} {rec}"
    guarded("C14", "Package: none delivered, no nonce: no block for the nonce; receipt not_delivered", c14)

    def c15():
        r = Run()
        r.start("c15agent001", "producer")
        o1 = stopped(r, "c15agent001", "producer", "short and incomplete")[1]
        rc, o2, rec = stopped(r, "c15agent001", "producer", "still incomplete")
        return is_block(o1) and rc == 0 and o2 == "", f"first {o1[:60]!r} second {o2[:60]!r}"
    guarded("C15", "one block per run: the run's next Stop is allowed whatever it holds", c15)

    def c16():
        r = Run()
        r.start("c16agent001", "producer")
        rc, out, rec = stopped(r, "c16agent001", "producer", "incomplete", active=True)
        return rc == 0 and out == "" and rec.get("outcome") == "pass", f"{out[:60]!r} {rec}"
    guarded("C16", "stop_hook_active true: no output, a pass record", c16)

    def c17():
        r = Run()
        r.start("c17agent001", "producer")
        full = handover(r, "c17agent001", "producer")
        o1 = stopped(r, "c17agent001", "producer", drop_lines(full, "Nonce:"))[1]
        rc, o2, rec = stopped(r, "c17agent001", "producer", full)
        return is_block(o1) and o2 == "" and rec.get("receipt") not in (None, "not_delivered"), f"{rec}"
    guarded("C17", "a nonce after one block is a late delivery, not a blocker", c17)

    def c18():
        r = Run()
        r.start("c18agent001", "researcher")
        stopped(r, "c18agent001", "researcher", handover(r, "c18agent001", "researcher"))
        r.start("c18agent001", "researcher")
        reply = DISC + "\n" + "\n".join(f"D{i}: no" for i in range(1, 10)) + \
            "\nReceived from / Returned to: none\n\nThe answer to the follow-up.\n"
        rc, o1, _ = stopped(r, "c18agent001", "researcher", reply)
        r.start("c18agent001", "researcher")
        o2 = stopped(r, "c18agent001", "researcher", drop_lines(reply, "Received from"))[1]
        return o1 == "" and is_block(o2), f"resumed complete {o1[:80]!r}; resumed without Received {o2[:80]!r}"
    guarded("C18", "a resumed run needs only the disciplines block and Received from / Returned to:", c18)

    def c19():
        r = Run()
        r.start("c19agent001", "checker")
        o0 = stopped(r, "c19agent001", "checker", verdict(r, "c19agent001"))[1]
        bad = [] if o0 == "" else [f"complete verdict blocked: {o0[:120]!r}"]
        for k in ("nonce", "received_returned", "package"):
            r2 = Run(root=r.root)
            r2.start("c19agent002", "checker")
            if not is_block(stopped(r2, "c19agent002", "checker", verdict(r2, "c19agent002", drop=(k,)))[1]):
                bad.append(f"verdict without {k} not blocked")
        return not bad, "; ".join(bad)
    guarded("C19", "a binding verdict filled from checker.md's template passes; without a key, blocked", c19)

    def c20():
        r = Run()
        r.start("c20agent001", "checker")
        out = stopped(r, "c20agent001", "checker", handover(r, "c20agent001", "checker", part=5))[1]
        return out == "", f"{out[:120]!r}"
    guarded("C20", "control: a checker's non-binding contribution (EV part 5, delivered) passes", c20)

    def c21():
        r = Run()
        r.start("c21agent001", "prober")
        out = stopped(r, "c21agent001", "prober", minimal())[1]
        return out == "", f"{out[:120]!r}"
    guarded("C21", "control: a take-up return (NOT_NEEDED, Product none) passes", c21)

    def c22():
        r = Run()
        r.start("c22agent001", "prober")
        msg = minimal(package=f"prober@{sha(r.pkg('prober'))[:12]}", nonce=r.nonce("c22agent001"),
                      take_up="none", product="none")
        out = stopped(r, "c22agent001", "prober", msg)[1]
        return out == "", f"{out[:120]!r}"
    guarded("C22", "filled but meaningless (every heading 'none'): passes, by design (content is the consumer's)", c22)

    def c23():
        r = Run()
        rc, out, rec = stopped(r, "c23agent001", "producer", "incomplete")
        return rc == 0 and out == "" and rec.get("outcome") == "could_not_check", f"{out[:60]!r} {rec}"
    guarded("C23", "no Start record: could_not_check, no block", c23)

    def c24():
        r = Run()
        os.makedirs(r.registry)
        rc, out, _, _ = r.stop("c24agent001", "producer", "incomplete")
        return rc == 0 and out == "", f"{rc} {out[:60]!r}"
    guarded("C24", "unreadable registry (a directory): exit 0, no block", c24)

    def c25():
        r = Run()
        r.start("c25agent001", "producer")
        bad = []
        for label, raw in (("malformed JSON", b"{not json"), ("empty input", b""), ("a list", b"[1,2]"),
                           ("message a list", json.dumps({"hook_event_name": "SubagentStop", "agent_id": "c25agent001",
                                                          "agent_type": "producer", "stop_hook_active": False,
                                                          "last_assistant_message": ["x"]}).encode()),
                           ("no agent_id", json.dumps({"hook_event_name": "SubagentStop", "agent_type": "producer",
                                                       "last_assistant_message": "x"}).encode())):
            rc, out, _, _ = r.hook("SubagentStop", raw=raw)
            if rc != 0 or out != "":
                bad.append(f"{label}: rc {rc} out {out[:40]!r}")
        return not bad, "; ".join(bad)
    guarded("C25", "malformed or odd input: exit 0, nothing on stdout", c25)

    def c26():
        r = Run()
        p = os.path.join(r.root, ".claude", "hooks", "agent_hooks.py")
        src = open(p, encoding="utf-8").read()
        with open(p, "w", encoding="utf-8") as f:
            f.write("import sys\nsys.stdout.write('')\nsys.exit(2)\n" + src)
        rc, out, _, _ = r.stop("c26agent001", "producer", "incomplete")
        os.remove(p)
        rc2, out2, _, _ = r.stop("c26agent001", "producer", "incomplete")
        return rc == 0 and out == "" and rc2 == 0 and out2 == "", f"exit2: {rc} {out!r}; missing: {rc2} {out2!r}"
    guarded("C26", "a planted exit 2 and a missing script: the command exits 0 with no stdout", c26)

    def c27():
        r = Run()
        r.start("c27agent001", "producer")
        full = handover(r, "c27agent001", "producer")
        sub = os.path.join(r.home, "t")
        os.makedirs(sub)
        tp = os.path.join(sub, "agent-c27agent001.jsonl")
        with open(tp, "w", encoding="utf-8") as f:
            f.write(json.dumps({"type": "assistant", "message": {"content": [
                {"type": "tool_use", "id": "toolu_h", "name": "SubagentHandback", "input": {"message": full}}]}}) + "\n")
            f.write(json.dumps({"type": "assistant", "message": {"content": [{"type": "text", "text": "Done."}]}}) + "\n")
        _, out, rec = stopped(r, "c27agent001", "producer", "Done.", transcript=tp)
        # The stop record hashes last_assistant_message as received, never the judged transcript text (CHK-C02-134 C1):
        # otherwise acceptance row (ii) compares last with itself and passes by construction.
        want = sha("Done.".encode())
        return out == "" and rec.get("prompt_sha256") == want, \
            f"out {out[:120]!r}; stop record prompt_sha256 {rec.get('prompt_sha256')!r}, want sha256('Done.') {want}"
    guarded("C27", "last_assistant_message differs: the transcript's last logic decides; the record hashes the message",
            c27)

    def c28():
        r = Run()
        r.start("c28agent001", "producer")
        fm = verdict(r, "c28agent001").replace("checker@", "producer@")
        return is_block(stopped(r, "c28agent001", "producer", fm)[1]), "a producer's front matter judged as a verdict"
    guarded("C28", "the verdict form is the checker's only: a producer's front matter is judged as a hand-over", c28)


# ---------------------------------------------------------------- H: one heading constant (approach "SubagentStop")

def h_cases():
    def h1():
        sa = modules()["sa"]
        bad = [r for r in ROLES if output_headings(r) != list(sa.HANDOVER_HEADINGS)]
        return not bad and "Take-up:" in sa.HANDOVER_HEADINGS, \
            f"differs for {bad}: constant {list(sa.HANDOVER_HEADINGS)}"
    guarded("H1", "HANDOVER_HEADINGS equals each role file's Output list, Take-up: included", h1)

    def h2():
        sa = modules()["sa"]
        return sorted(sa.VERDICT_KEYS) == sorted(verdict_keys_from_template()), \
            f"{sorted(sa.VERDICT_KEYS)} vs {sorted(verdict_keys_from_template())}"
    guarded("H2", "VERDICT_KEYS equals checker.md's binding-template front-matter keys", h2)

    def h3():
        t = open(os.path.join(REPO, ".claude", "hooks", "agent_hooks.py"), encoding="utf-8").read()
        lits = [n.value for n in ast.walk(ast.parse(t)) if isinstance(n, ast.Constant) and isinstance(n.value, str)]
        return not any(x in ("Relied on:", "Guard denials:", "relied_on") for x in lits), \
            "agent_hooks.py restates headings instead of importing the constant"
    guarded("H3", "the stop hook imports the constants (no restated heading)", h3)


# ---------------------------------------------------------------- G: guard cases (M3a's T1; the key-file deny)

def guard_rule(data, perm=False, logdir=None):
    s = settings()
    cmd = s["hooks"]["PermissionRequest" if perm else "PreToolUse"][0]["hooks"][0]["command"]
    env = dict(os.environ, CLAUDE_PROJECT_DIR=REPO, DEVOS_GUARD_LOG_DIR=logdir or new_dir())
    data = dict(data)
    data.setdefault("hook_event_name", "PermissionRequest" if perm else "PreToolUse")
    data.setdefault("session_id", "w25-guard-case")
    p = subprocess.run(["sh", "-c", cmd], input=json.dumps(data).encode(), capture_output=True, env=env, cwd=REPO,
                       timeout=120)
    if p.returncode == 2:
        return "block", "-"
    try:
        d = json.loads(p.stdout)["hookSpecificOutput"]
    except ValueError:
        return "pass", "-"
    t = d.get("permissionDecisionReason") or (d.get("decision") or {}).get("message") or ""
    mm = re.search(r"DENIED by rule ([\w.]+)|allowed by rule ([\w.]+)", t)
    return (d.get("permissionDecision") or (d.get("decision") or {}).get("behavior") or "?",
            (mm.group(1) or mm.group(2)) if mm else "-")


def g_cases():
    n = 0
    for perm in (False, True):
        for caller in (None, "g0agent00001"):
            for to in ("a1b2c3d4e5f6a7b8c", "main", "researcher"):
                n += 1
                # W-C02-27 point 9: no registry is planted, so T6.9 (T6 reads the registry before its self check)

                def one(perm=perm, caller=caller, to=to):
                    got = guard_rule({"tool_name": "SendMessage", "tool_input": {"to": to, "message": "x"},
                                      "agent_id": caller}, perm=perm)
                    return got == ("deny", "T6.9"), f"got {got}"
                guarded(f"G{n}", f"SendMessage {'PermissionRequest' if perm else 'PreToolUse'} from "
                        f"{'a subagent' if caller else 'main'} to {to!r}: deny by T6.9", one)

    def g13():
        d = new_dir()
        kf = os.path.join(d, "session_W25G.nonce-key")
        routes = [("Read", {"file_path": kf}), ("Grep", {"pattern": "x", "path": kf}),
                  ("Bash", {"command": f"cat {kf}"}),
                  ("Bash", {"command": f"xxd {d}/session_W25G.nonce-key"})]
        got = [guard_rule({"tool_name": t, "tool_input": i, "agent_id": "g13agent0001"}, logdir=d) for t, i in routes]
        rules = {g[1] for g in got}
        ok = all(g[0] == "deny" for g in got) and len(rules) == 1 and "G0" not in rules and "-" not in rules
        return ok, f"{got}"
    guarded("G13", "the nonce key file named by a subagent through Read, Grep, Bash: one deny rule, not G0", g13)

    def g14():
        d = new_dir()
        got = guard_rule({"tool_name": "Read", "tool_input": {"file_path": os.path.join(d, "session_W25G.jsonl")},
                          "agent_id": "g14agent0001"}, logdir=d)
        key = guard_rule({"tool_name": "Read", "tool_input": {"file_path": os.path.join(d, "session_W25G.nonce-key")},
                          "agent_id": "g14agent0001"}, logdir=d)
        return got[0] == "allow" and key[0] == "deny", f"log read {got}, key read {key}"
    guarded("G14", "control: a subagent may still read the guard log; only the key file is denied", g14)

    def g15():
        d = new_dir()
        a = guard_rule({"tool_name": "Bash", "tool_input": {"command": f"echo x >> {d}/session_W25G.agents"},
                        "agent_id": None}, logdir=d)
        b = guard_rule({"tool_name": "Bash", "tool_input": {"command": f"echo x >> {d}/session_W25G.jsonl"},
                        "agent_id": None}, logdir=d)
        return a[0] == "deny" and a == b, f"registry append {a}, log append {b}"
    guarded("G15", "the registry is not writable by tools: same deny as the guard log", g15)


# ---------------------------------------------------------------- L: liveness (approach "Liveness")

def note(aid, ts):
    return {"type": "user", "origin": {"kind": "task-notification"}, "timestamp": ts,
            "message": {"content": f"<task-notification><task-id>{aid}</task-id><status>completed</status>"
                                   f"<summary>s</summary></task-notification>"}}


def plant_transcript(home, aid, sess, ts=None, meta=True):
    sub = os.path.join(home, ".claude", "projects", "proj", sess, "subagents")
    os.makedirs(sub, exist_ok=True)
    with open(os.path.join(sub, f"agent-{aid}.jsonl"), "w") as f:
        f.write(json.dumps({"type": "assistant", "message": {"content": [{"type": "text", "text": "r"}]}}) + "\n")
    if meta:
        with open(os.path.join(sub, f"agent-{aid}.meta.json"), "w") as f:
            json.dump({"toolUseId": f"toolu_{aid}"}, f)
    if ts:
        with open(os.path.join(home, ".claude", "projects", "proj", f"{sess}.jsonl"), "a") as f:
            f.write(json.dumps(note(aid, ts)) + "\n")


def plant_guard_log(r, rows):
    prev, lines = "", []
    for n, (aid, ts) in enumerate(rows, 1):
        rec = {"n": n, "prev": prev, "time": ts, "event": "PreToolUse", "session": r.key, "agent_id": aid,
               "tool": "Read", "decision": "allow", "rule": "T2", "summary": "x", "detail": "", "reason": ""}
        raw = json.dumps(rec)
        lines.append(raw)
        prev = sha(raw.encode())
    with open(os.path.join(r.dir, f"{r.key}.jsonl"), "w") as f:
        f.write("\n".join(lines) + "\n")


def liveness(r):
    p = subprocess.run([sys.executable, os.path.join(r.root, "tools", "guard_report.py"), "--liveness",
                        "--dir", r.dir, "--session", r.key], capture_output=True, env=r.env(), cwd=r.root, timeout=120)
    return p.returncode, p.stdout.decode()


def flagged(out, flag, aid):
    return any(flag in ln and aid in ln for ln in out.split("\n"))


def l_world(exempt=None, bad_runs=True, extra_log=()):
    r = Run()
    old, now = "2026-01-01T00:00:00Z", time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime(time.time() + 120))
    plant_guard_log(r, [("l6agent0001", old)] + ([("l2agent0001", now)] if bad_runs else []) + [("l3agent0001", now)]
                    + list(extra_log))
    plant_transcript(r.home, "l6agent0001", "sess", ts=old)            # finished before the cutoff, no Start
    # internal: no meta file, yet in the guard log, finished after the cutoff and with no Start, so that only the
    # meta-file exclusion keeps it from NO_START (CHK-C02-134 C2)
    plant_transcript(r.home, "l3agent0001", "sess", ts=now, meta=False)
    r.launch("producer", W_PROMPT, agent_id="l1agent0001")             # its item, shown on its run's line (L3)
    r.start("l1agent0001", "producer")
    stopped(r, "l1agent0001", "producer", handover(r, "l1agent0001", "producer"))
    plant_transcript(r.home, "l1agent0001", "sess", ts=now)
    r.start("l9agent0001", "producer")                                  # late delivery after one block
    full = handover(r, "l9agent0001", "producer")
    stopped(r, "l9agent0001", "producer", drop_lines(full, "Nonce:"))
    stopped(r, "l9agent0001", "producer", full)
    plant_transcript(r.home, "l9agent0001", "sess", ts=now)
    # still running: no end status, but blocked with no later Stop, and named in the session's transcript after the
    # cutoff (its launch's async result), so that only the running-run exclusion keeps it from BLOCK_NO_STOP (C2)
    r.start("l7agent0001", "prober")
    stopped(r, "l7agent0001", "prober", "incomplete")
    plant_transcript(r.home, "l7agent0001", "sess", ts=None)
    with open(os.path.join(r.home, ".claude", "projects", "proj", "sess.jsonl"), "a") as f:
        f.write(json.dumps({"type": "user", "timestamp": now,
                            "toolUseResult": {"status": "async_launched", "agentId": "l7agent0001"},
                            "message": {"content": [{"type": "tool_result", "tool_use_id": "toolu_l7agent0001",
                                                     "content": "Async agent launched: l7agent0001"}]}}) + "\n")
    if bad_runs:
        plant_transcript(r.home, "l2agent0001", "sess", ts=now)         # NO_START
        r.start("l4agent0001", "checker")                               # BLOCK_NO_STOP
        stopped(r, "l4agent0001", "checker", "incomplete")
        plant_transcript(r.home, "l4agent0001", "sess", ts=now)
        r.start("l5agent0001", "producer")                              # NOT_DELIVERED
        stopped(r, "l5agent0001", "producer", ev_part(6))
        plant_transcript(r.home, "l5agent0001", "sess", ts=now)
    if exempt:
        r.start(exempt, "checker")
        stopped(r, exempt, "checker", "incomplete")
        plant_transcript(r.home, exempt, "sess", ts=now)
        os.makedirs(os.path.join(r.root, "plan", "ledger"), exist_ok=True)
        with open(os.path.join(r.root, "plan", "ledger", "C99-log.md"), "w") as f:
            f.write(f"# C99 log\n\n### L-99999 · 2026-10-20 · synthetic: exemption\n\n- **Liveness:** {exempt}: "
                    f"TaskStop by the executor\n")
    return r


# L7 and L8 (a new version of the suite, after L-458's "A liveness defect"): a run's end time is that of its end-status
# record as `end_problem` reads it (approach: "A finished run is one with the platform's end status as
# `subagent_audit.py`'s `end_problem` reads it"; "a run that finished before it is not counted"), never the latest
# record that merely names the agent's ID. The defect's two observed mention kinds (an executor's Agent call pasting an
# approach block, liveness output) and two that defeat a fix matching any notification holding the ID (another agent's
# completion, as a user event and as a queued_command, whose text names the ID) come after the end status, in the
# session's transcript. Each end-status form `end_problem` reads stands once: a background completion as a user event
# (observed), as a queued_command attachment (observed), and a foreground result (inferred, subagent_audit.py "The end").
LM_OLD = "2026-01-02T00:00:00Z"                                             # before any cutoff a hook writes
LM_DONE = (("m1agent0001", "user"), ("m2agent0001", "queued"), ("m3agent0001", "foreground"))
LM_LATE = "m4agent0001"                     # control: finished before the cutoff, resumed, finished again after it
LM_FLAGS = ("NO_START", "BLOCK_NO_STOP", "NOT_DELIVERED")


def end_record(aid, ts, form):
    """The platform's end-status record, status completed, of an Agent-tool subagent, in one of end_problem's forms."""
    if form == "user":
        return note(aid, ts)
    if form == "queued":
        return {"type": "attachment", "timestamp": ts, "attachment": {
            "type": "queued_command", "commandMode": "task-notification", "origin": {"kind": "task-notification"},
            "prompt": note(aid, ts)["message"]["content"]}}
    return {"type": "user", "timestamp": ts, "toolUseResult": {"status": "completed", "agentId": aid},
            "message": {"content": [{"type": "tool_result", "tool_use_id": f"toolu_{aid}", "content": "r"}]}}


def mentions(ids, ts):
    """Records at ts that only name ids; none is an end status of any of them (end_problem reads none as one)."""
    names = ", ".join(ids)
    other = (f"<task-notification><task-id>mxother0001</task-id><status>completed</status><summary>s</summary>"
             f"<result>asked: {names}</result></task-notification>")
    return [{"type": "assistant", "timestamp": ts, "message": {"content": [
                {"type": "tool_use", "id": "toolu_mxagent", "name": "Agent",
                 "input": {"subagent_type": "checker", "prompt": f"## Approach\nasked: {names}\n"}}]}},
            {"type": "user", "timestamp": ts, "toolUseResult": {"stdout": names, "stderr": "", "interrupted": False},
             "message": {"content": [{"type": "tool_result", "tool_use_id": "toolu_mxbash",
                                      "content": "\n".join(f"NO_START {i}" for i in ids)}]}},
            {"type": "user", "timestamp": ts, "origin": {"kind": "task-notification"}, "message": {"content": other}},
            {"type": "attachment", "timestamp": ts, "attachment": {
                "type": "queued_command", "commandMode": "task-notification", "prompt": other}}]


def lm_world(control=False):
    """The sound L world, plus either LM_DONE (each in the guard log, with a meta file and no Start, finished before
    the cutoff, then named later; L7) or, with control, LM_LATE (the same, but its last end status comes after the
    cutoff; L8), so that L8 is green at the defective product and turns only on a fix that over-corrects."""
    ids = [LM_LATE] if control else [a for a, _ in LM_DONE]
    r = l_world(bad_runs=False, extra_log=[(a, LM_OLD) for a in ids])
    now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime(time.time() + 120))
    sess = os.path.join(r.home, ".claude", "projects", "proj", "sess.jsonl")
    rows = []
    for aid, form in () if control else LM_DONE:
        plant_transcript(r.home, aid, "sess")                    # its transcript and meta file; no end status yet
        rows.append(end_record(aid, LM_OLD, form))
    if control:
        plant_transcript(r.home, LM_LATE, "sess", ts=LM_OLD)     # its first end status, before the cutoff
        rows.append(end_record(LM_LATE, now, "user"))            # the last one decides (subagent_audit.py "The end")
    with open(sess, "a") as f:
        f.write("".join(json.dumps(e) + "\n" for e in rows + mentions(ids, now)))
    return r


def lm_flag_lines(out):
    return [ln for ln in out.split("\n") if any(fl in ln for fl in LM_FLAGS)]


def l_cases():
    def l1():
        r = l_world()
        rc, out = liveness(r)
        want = [("NO_START", "l2agent0001"), ("BLOCK_NO_STOP", "l4agent0001"), ("NOT_DELIVERED", "l5agent0001")]
        miss = [w for w in want if not flagged(out, *w)]
        extra = [a for a in ("l1agent0001", "l3agent0001", "l6agent0001", "l7agent0001", "l9agent0001")
                 if any(f in ln and a in ln for ln in out.split("\n") for f in ("NO_START", "BLOCK_NO_STOP",
                                                                                "NOT_DELIVERED"))]
        last = out.strip().split("\n")[-1] if out.strip() else ""
        return rc == 1 and not miss and not extra and last == "LIVENESS FAIL", \
            f"rc {rc}; missing {miss}; wrongly flagged {extra}; last {last!r}"
    guarded("L1", "per finished run: NO_START, BLOCK_NO_STOP, NOT_DELIVERED; cutoff, internal (finished), running "
            "(blocked), late excluded", l1)

    def l2():
        r = l_world(exempt="l8agent0001", bad_runs=False)
        rc, out = liveness(r)
        ok = rc == 0 and flagged(out, "EXEMPT", "l8agent0001") and not flagged(out, "BLOCK_NO_STOP", "l8agent0001") \
            and out.strip().split("\n")[-1] == "LIVENESS PASS"
        return ok, f"rc {rc}: {out[-400:]!r}"
    guarded("L2", "a pinned '- **Liveness:** <id>: <reason>' line in the newest log entry exempts that run", l2)

    def l3():
        r = l_world(bad_runs=False)
        r.session_start("startup")
        rc, out = liveness(r)
        item = any("l1agent0001" in ln and "plan/work/W-C02-25.md" in ln for ln in out.split("\n"))
        ok = rc == 0 and out.strip().split("\n")[-1] == "LIVENESS PASS" and "session_start" in out.lower().replace(
            "sessionstart", "session_start") and "SELFTEST PASS" in out and item
        return ok, f"rc {rc}; run line with its item {item}: {out[-400:]!r}"
    guarded("L3", "control: only sound runs gives LIVENESS PASS, shows a run's item, SessionStart records, SELFTEST PASS",
            l3)

    def l4():
        r = Run()
        s = settings(r.root)
        s["hooks"]["SubagentStop"][0]["hooks"][0]["command"] = s["hooks"]["SubagentStop"][0]["hooks"][0][
            "command"].replace("agent_hooks.py", "agent_hooks_gone.py")
        with open(os.path.join(r.root, ".claude", "settings.json"), "w") as f:
            json.dump(s, f, indent=2)
        rc, out = liveness(r)
        return rc == 1 and any("MISSING" in ln and "agent_hooks_gone.py" in ln for ln in out.split("\n")), \
            f"rc {rc}: {out[-300:]!r}"
    guarded("L4", "a hook command path that does not exist: MISSING, FAIL", l4)

    def l5():
        r = l_world(bad_runs=False)
        before = {f: sha(open(os.path.join(r.dir, f), "rb").read()) for f in os.listdir(r.dir)}
        liveness(r)
        after = {f: sha(open(os.path.join(r.dir, f), "rb").read()) for f in os.listdir(r.dir)}
        return before == after, f"the self-test touched the registry dir: {set(after) ^ set(before)}"
    guarded("L5", "the self-test runs in a scratch dir: the registry dir is byte-identical after liveness", l5)

    def l6():
        t = open(os.path.join(REPO, "tools", "stop_check.sh"), encoding="utf-8").read()
        return "guard_report.py --liveness" in t and re.search(r"--liveness[^\n]*\n(?:[^\n]*\n){0,4}[^\n]*bad ", t), \
            "stop_check.sh does not run --liveness with a FAIL path"
    guarded("L6", "stop_check.sh runs guard_report.py --liveness and fails on it", l6)

    def l7():
        r = lm_world()
        rc, out = liveness(r)
        lines = out.split("\n")
        flags = lm_flag_lines(out)
        # each of the three runs is left out by the cutoff rule itself, on its own line, not by another exclusion
        by_cutoff = [a for a, _ in LM_DONE if any(a in ln and "cutoff" in ln for ln in lines)]
        last = out.strip().split("\n")[-1] if out.strip() else ""
        return rc == 0 and not flags and len(by_cutoff) == len(LM_DONE) == 3 and last == "LIVENESS PASS", \
            f"rc {rc}; flag lines {flags}; left out by the cutoff {by_cutoff} of {[a for a, _ in LM_DONE]}; last {last!r}"
    guarded("L7", "a run whose end status (user event, queued_command, foreground result) is before the cutoff stays "
            "not counted when later records only name its ID (an Agent call, liveness output, another agent's "
            "notifications): no flag, LIVENESS PASS", l7)

    def l8():
        r = lm_world(control=True)
        rc, out = liveness(r)
        flags = lm_flag_lines(out)
        ok_flags = len(flags) == 1 and "NO_START" in flags[0] and LM_LATE in flags[0]
        late_cut = [ln for ln in out.split("\n") if LM_LATE in ln and "cutoff" in ln]
        last = out.strip().split("\n")[-1] if out.strip() else ""
        return rc == 1 and ok_flags and not late_cut and last == "LIVENESS FAIL", \
            f"rc {rc}; flag lines {flags} (want exactly NO_START {LM_LATE}); cutoff lines for it {late_cut}; last {last!r}"
    guarded("L8", "control for L7: a run whose last end status is after the cutoff (an earlier one before it), named "
            "by the same later records, is counted: exactly one flag, NO_START for it, LIVENESS FAIL", l8)


# ---------------------------------------------------------------- RF: records.py role-file refusals

def rf_cases():
    plants = [("RF1", "unknown", "name: x\ndescription: d\nfoo: bar\n", "foo"),
              ("RF2", "omit", "name: x\ndescription: d\nomitClaudeMd: true\n", "omitClaudeMd"),
              ("RF3", "hooks", "name: x\ndescription: d\nhooks: {}\n", "hooks"),
              ("RF4", "memory", "name: x\ndescription: d\nmemory: project\n", "memory")]
    for cid, fname, fm, token in plants:
        def one(fname=fname, fm=fm, token=token):
            rec = load(os.path.join(REPO, "tools", "records.py"), "w25_records")
            root = new_dir()
            shutil.copytree(os.path.join(REPO, ".claude", "agents"), os.path.join(root, ".claude", "agents"))
            with open(os.path.join(root, ".claude", "agents", f"{fname}.md"), "w") as f:
                f.write(f"---\n{fm}---\n\nBody.\n")
            probs = rec.agent_file_problems(root)
            return any(f"{fname}.md" in p and token in p for p in probs) and len(probs) == 1, f"{probs}"
        guarded(cid, f"records.py refuses a role file with {token}", one)

    def rf5():
        rec = load(os.path.join(REPO, "tools", "records.py"), "w25_records")
        root = new_dir()
        shutil.copytree(os.path.join(REPO, ".claude", "agents"), os.path.join(root, ".claude", "agents"))
        os.makedirs(os.path.join(root, ".claude", "agents", "sub"))
        shutil.copy(os.path.join(root, ".claude", "agents", "prober.md"), os.path.join(root, ".claude", "agents", "sub"))
        probs = rec.agent_file_problems(root)
        return len(probs) == 1 and "sub/prober.md" in probs[0], f"{probs}"
    guarded("RF5", "records.py refuses a role file in a subfolder of .claude/agents/", rf5)

    def rf6():
        rec = load(os.path.join(REPO, "tools", "records.py"), "w25_records")
        return rec.agent_file_problems(REPO) == [], "the head's real role files are refused"
    guarded("RF6", "control: the head's real role files pass", rf6)

    def rf7():
        clone = os.path.join(new_dir(), "c")
        subprocess.run(["git", "clone", "-q", REPO, clone], check=True, capture_output=True)
        ok0 = subprocess.run([sys.executable, "-B", "tools/records.py", "render", "--check"], cwd=clone,
                             capture_output=True, timeout=300).returncode
        with open(os.path.join(clone, ".claude", "agents", "memory-role.md"), "w") as f:
            f.write("---\nname: memory-role\ndescription: d\nmemory: project\n---\n")
        p = subprocess.run([sys.executable, "-B", "tools/records.py", "render", "--check"], cwd=clone,
                           capture_output=True, timeout=300)
        out = (p.stdout + p.stderr).decode()
        return ok0 == 0 and p.returncode != 0 and "memory-role.md" in out, f"clean {ok0}; planted {p.returncode}"
    guarded("RF7", "end to end: records.py render --check fails on a planted role file, passes without it", rf7)


# ---------------------------------------------------------------- MG and X: trigger set, text

def mx_cases():
    def mg1():
        tree = ast.parse(open(os.path.join(REPO, "tools", "merge_gate.py"), encoding="utf-8").read())
        for n in ast.walk(tree):
            if isinstance(n, (ast.Tuple, ast.List, ast.Set)):
                vals = {e.value for e in n.elts if isinstance(e, ast.Constant)}
                if {".claude/hooks/agent_hooks.py", "tools/check_role_packages.py", ".claude/roles/"} <= vals:
                    return True, ""
        return False, "agent_hooks.py is not in the trigger-set constant with the role-package paths"
    guarded("MG1", "the merge gate's role-package trigger set holds .claude/hooks/agent_hooks.py", mg1)

    def x1():
        t = open(os.path.join(REPO, "plan", "Installation_Working_Order.md"), encoding="utf-8").read()
        row = [ln for ln in t.split("\n") if ln.startswith("| 8. ")]
        ok = len(row) == 1 and ".claude/roles/" in row[0] and "start hook" in row[0] and "stop hook" in row[0]
        return ok, f"row 8: {row[:1]}"
    guarded("X1", "working order section 4 has row 8: the package, start hook delivers, stop hook checks", x1)


# ---------------------------------------------------------------- O: the oracles and fixtures themselves (run at the base too)

class _Fake:
    """Stands for a Run in the fixture self-checks: fixed package bytes and nonce, no hook involved."""
    def pkg(self, role):
        return b"fixture package\n"

    def nonce(self, agent_id):
        return "0123456789abcdef"


def o_cases():
    sa = load(os.path.join(REPO, "tools", "subagent_audit.py"), "w25_sa_o")
    heads = output_headings("producer")

    def o1():
        bad = []
        for part in (5, 6):
            t = handover(_Fake(), "o1agent0001", "checker" if part == 5 else "producer", part=part)
            miss = [h for h in heads if not any(ln.startswith(h) for ln in t.split("\n"))]
            if miss or sa.block_problem(t) is not None:
                bad.append(f"part {part}: missing {miss}, block {sa.block_problem(t)}")
        return not bad and len(heads) == 10, f"{bad} ({len(heads)} headings)"
    guarded("O1", "fixture: EV parts 5 and 6 carry every Output heading and a whole disciplines block", o1)

    def o2():
        t = verdict(_Fake(), "o2agent0001")
        fm = t.split("---\n", 2)[1]
        keys = [ln.split(":", 1)[0] for ln in fm.split("\n") if ":" in ln]
        ok = t.startswith("---\n") and sorted(keys) == sorted(verdict_keys_from_template()) and \
            sa.block_problem(t) is None and "<" not in fm
        return ok, f"keys {keys}; block {sa.block_problem(t)}"
    guarded("O2", "fixture: the verdict filled from checker.md has every template key, no placeholder, the block", o2)

    def o3():
        t = handover(_Fake(), "o3agent0001", "producer")
        bad = [h for h in heads if any(ln.startswith(h) for ln in drop_lines(t, h).split("\n"))]
        if sa.block_problem(drop_disciplines(t)) is None or sa.block_problem(drop_lines(t, "D9:")) is None:
            bad.append("disciplines removal leaves a whole block")
        return not bad, f"{bad}"
    guarded("O3", "fixture: each removal really removes its part (so a pass on it is the product's fault)", o3)

    def o4():
        bad = []
        for cid, env_id, sid in K_CASES:
            d = new_dir()
            env = {k: v for k, v in os.environ.items() if k != "CLAUDE_CODE_REMOTE_SESSION_ID"}
            env.update({"DEVOS_GUARD_LOG_DIR": d, "CLAUDE_PROJECT_DIR": REPO})
            if env_id:
                env["CLAUDE_CODE_REMOTE_SESSION_ID"] = env_id
            cmd = settings()["hooks"]["PreToolUse"][0]["hooks"][0]["command"]
            subprocess.run(["sh", "-c", cmd], input=json.dumps({"session_id": sid, "hook_event_name": "PreToolUse",
                           "tool_name": "TodoWrite", "tool_input": {"todos": []}}).encode(), capture_output=True,
                           env=env, cwd=REPO, timeout=120)
            if os.listdir(d) != [old_key(env_id, sid) + ".jsonl"]:
                bad.append(f"{cid}: {os.listdir(d)}")
        return not bad, f"{bad}"
    guarded("O4", "oracle: the restated base derivation names the guard's log file for K1 to K5 (byte-identical)", o4)


def main():
    for fn in (o_cases, st_cases, k_cases, r_cases, s_cases, ss_cases, c_cases, h_cases, g_cases, l_cases, rf_cases, mx_cases):
        try:
            fn()
        except Exception as exc:  # a group that cannot even set up is one BAD line, never silence
            case(fn.__name__.upper(), "group could not set up", False, f"{type(exc).__name__}: {str(exc)[:300]}")
    n_bad = RESULTS.count(False)
    print(f"{len(RESULTS)} cases, {n_bad} BAD")
    print("AGENT_HOOKS_TEST PASS" if RESULTS and not n_bad else "AGENT_HOOKS_TEST FAIL")
    return 0 if RESULTS and not n_bad else 1


if __name__ == "__main__":
    sys.exit(main())
