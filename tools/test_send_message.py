#!/usr/bin/env python3
"""Tests of guard rule T6 (SendMessage) and of the role files' messaging lines: W-C02-27 (SB-COR 3.6b).

Synthetic test data (plan Section 8 item 13): every agent ID, session ID, name and message here is made up for the
test and holds no personal or business data. The agent IDs are "a" + 16 hex derived from a fixture label, the form of
the IDs the guard log shows; the session IDs carry "W27FIXTURE". The token-format string of case L4-1 is built at run
time and is not a token.

Written by the item's test designer before any product (ledger rule 3; working order section 4 step 2). The item's
acceptance condition (plan/work/W-C02-27.md) pins the interface these tests read; [T] marks there what the approach
left open and the condition pins. In short:
  - the guard is run through the commands .claude/settings.json holds at hooks.PreToolUse[0] and
    hooks.PermissionRequest[0], with the script path replaced by the hook under test (as tools/test_tool_allowlist.sh
    does); every SendMessage case runs on both events and must get the same decision and rule;
  - rule IDs: T6 (allow), T6.0 (error inside T6), T6.1 (an input key outside {to, message}), T6.2 (`to` not one
    string), T6.3 (`to` missing or empty), T6.4 (`to` is "*"), T6.5 (`to` a session reference: starts with "session_"
    or "cse_"), T6.6 (`to` not an agent ID held in this session's registry: names included), T6.7 (the caller is not
    allowed for that target), T6.8 (a message to the caller's own ID, or main to main), T6.9 (no readable registry for
    this session); a decision's rule is read from the guard's own log record of the call, and where the output text
    carries a rule it must agree;
  - the registry is W-C02-25's: <DEVOS_GUARD_LOG_DIR>/<session key>.agents, JSON Lines with that item's fixed keys;
    the session key is found as the guard log's own file name for the fixture session (W-C02-25 acceptance row (iii):
    the registry's key equals the key of the guard log holding the calls);
  - T6.0 is driven in-process by replacing the guard's module function send_message_checks(data, args) [T] with one
    that raises.

Usage, from the root of a devos clone:
    python3 tools/test_send_message.py [--hook PATH] [--base REV] [--only guard|roles]
--hook defaults to .claude/hooks/tool_allowlist.py; --base (for the role-file diff) defaults to the merge base of HEAD
and refs/remotes/origin/main. Prints one "ok" or "BAD" line per check, "NOT RUN" for a check that could not run, and
a last line "W27 PASS <n> checks" (exit 0) or "W27 FAIL ..." (exit 1). A NOT RUN line makes the run fail: a check that
did not run never reads as green.
"""
import argparse, hashlib, importlib.util, io, json, os, re, shutil, subprocess, sys, tempfile, time  # one line: the leak check matched the one-per-line form (L-450)
from contextlib import redirect_stdout

ROOT = os.getcwd()
GUARD_REL = ".claude/hooks/tool_allowlist.py"
ALLOWED_KEYS = ("to", "message")            # approach W27-3; re-pinned only if the schema row shows fewer
LEGACY_KEYS = ("type", "recipient", "recipient_kind", "content", "request_id", "approve")   # EV-C02-030 part 4, S8
ROLES = ("producer", "researcher", "prober", "checker", "test-designer")
OLD_SENDBACK = "Until a later change allows direct messages (W-C02-27)"
REC_KEYS = ("time", "event", "agent_id", "agent_type", "name", "item", "form", "tool_use_id", "prompt_sha256",
            "run", "outcome", "missing", "receipt", "package")   # W-C02-25 approach, "Fixed keys"
MAIN = object()      # the caller is the main conversation: no agent_id in the hook input

R = {"allow": "T6", "error": "T6.0", "keys": "T6.1", "shape": "T6.2", "empty": "T6.3", "star": "T6.4",
     "session": "T6.5", "unknown": "T6.6", "caller": "T6.7", "self": "T6.8", "noreg": "T6.9"}

RESULTS = {"ok": 0, "bad": 0, "notrun": 0}


def report(ok, label, why=""):
    RESULTS["ok" if ok else "bad"] += 1
    print(("ok   " if ok else "BAD  ") + label + ("" if ok or not why else f": {why}"))


def not_run(label, why):
    RESULTS["notrun"] += 1
    print(f"NOT RUN  {label}: {why}")


def aid(label):
    return "a" + hashlib.sha256(("w27-fixture-" + label).encode()).hexdigest()[:16]


A = {k: aid(k) for k in ("producer", "test-designer", "checker", "researcher", "prober", "researcher2",
                         "general", "counter", "other-session", "internal")}
TYPES = {"producer": "producer", "test-designer": "test-designer", "checker": "checker", "researcher": "researcher",
         "prober": "prober", "researcher2": "researcher", "general": "general-purpose", "counter": "counter-designer"}


def rec(event, agent_id, agent_type, **kw):
    r = dict.fromkeys(REC_KEYS)
    r.update(time="2026-10-20T12:00:00Z", event=event, agent_id=agent_id, agent_type=agent_type)
    r.update(kw)
    return r


def standard_registry():
    lines = [rec("session_start", None, None, outcome="startup")]
    for label, t in TYPES.items():
        lines.append(rec("launch", A[label], t, name=None, item="plan/work/W-C02-99.md" if t == "producer" else None,
                         tool_use_id="toolu_w27_" + label))
        lines.append(rec("start", A[label], t, package=f"{t}@000000000000"))
    lines.append(rec("stop", A["checker"], "checker", outcome="pass"))       # a finished checker run
    for ln in lines:
        if ln["agent_id"] == A["researcher"] and ln["event"] == "launch":
            ln["name"] = "fixture-helper-r"                                    # a name the registry holds once
    return lines


class Fixture:
    """One scratch log directory; the guard keyed by a remote session ID that differs from the hook's session_id."""

    def __init__(self, hook, remote="cse_01W27FIXTUREREMOTE0001", local="w27fixture-local-0001"):
        self.hook, self.remote, self.local = hook, remote, local
        self.dir = tempfile.mkdtemp(prefix="w27-")
        env = dict(os.environ)
        env.update(DEVOS_GUARD_LOG_DIR=self.dir, DEVOS_LIBRARY_DIR=os.path.join(self.dir, "no-library"),
                   DEVOS_LEAK_STORE=os.path.join(self.dir, "no-store"), CLAUDE_PROJECT_DIR=ROOT)
        env.pop("DEVOS_SERVICE_NAMES_EXTRA", None)
        if remote is None:
            env.pop("CLAUDE_CODE_REMOTE_SESSION_ID", None)
        else:
            env["CLAUDE_CODE_REMOTE_SESSION_ID"] = remote
        self.env = env
        self.key = None

    def find_key(self):
        """Run one read through the guard and take the key from the log file the guard made."""
        self.call({"file_path": os.path.join(ROOT, "plan", "SB-COR_Correction_Plan.md")}, tool="Read")
        logs = [f for f in os.listdir(self.dir) if f.endswith(".jsonl")]
        if len(logs) != 1:
            raise RuntimeError(f"expected one guard log in the fixture directory, found {logs}")
        self.key = logs[0][:-len(".jsonl")]
        src = "session_" + self.remote[4:] if (self.remote or "").startswith("cse_") else (self.remote or self.local)
        want = re.sub(r"[^A-Za-z0-9_-]", "_", src)[:80]
        return self.key, want

    def write_registry(self, lines, key=None, raw=None):
        path = os.path.join(self.dir, (key or self.key) + ".agents")
        with open(path, "w", encoding="utf-8") as f:
            if raw is not None:
                f.write(raw)
            else:
                for ln in lines:
                    f.write(json.dumps(ln) + "\n")
        return path

    def call(self, tool_input, caller=MAIN, event="PreToolUse", tool="SendMessage", env_extra=None, data_extra=None,
             timeout=200):
        data = {"session_id": self.local, "transcript_path": os.path.join(self.dir, "t.jsonl"), "cwd": ROOT,
                "permission_mode": "acceptEdits", "hook_event_name": event, "tool_name": tool,
                "tool_input": tool_input, "tool_use_id": "toolu_w27fixture"}
        if caller is not MAIN:
            data["agent_id"] = caller
        data.update(data_extra or {})
        settings = json.load(open(os.path.join(ROOT, ".claude", "settings.json")))
        cmd = settings["hooks"][event][0]["hooks"][0]["command"]
        if "$CLAUDE_PROJECT_DIR/" + GUARD_REL not in cmd:
            return ("?", None, "the settings command does not name the guard", None)
        cmd = cmd.replace("$CLAUDE_PROJECT_DIR/" + GUARD_REL, self.hook)
        env = dict(self.env)
        env.update(env_extra or {})
        logp = os.path.join(self.dir, f"{self.key}.jsonl") if self.key else None
        before = os.path.getsize(logp) if logp and os.path.exists(logp) else 0
        try:
            p = subprocess.run(["sh", "-c", cmd], input=json.dumps(data), capture_output=True, text=True, env=env,
                               cwd=ROOT, timeout=timeout)
        except subprocess.TimeoutExpired:
            return ("timeout", None, "", None)
        if p.returncode == 2:
            return ("block", None, p.stderr, None)
        try:
            d = json.loads(p.stdout)["hookSpecificOutput"]
        except (ValueError, KeyError, TypeError):
            return ("?", None, p.stdout + p.stderr, None)
        if event == "PreToolUse":
            dec = d.get("permissionDecision") if d.get("hookEventName") == "PreToolUse" else "?"
            text = d.get("permissionDecisionReason") or ""
        else:
            dd = d.get("decision") or {}
            dec = dd.get("behavior") if d.get("hookEventName") == "PermissionRequest" else "?"
            text = dd.get("message") or ""
        m = re.search(r"DENIED by rule ([A-Z][A-Za-z0-9]*(?:\.\d+)?) \(|allowed by rule ([A-Z][A-Za-z0-9]*(?:\.\d+)?):",
                      text)
        out_rule = (m.group(1) or m.group(2)) if m else None
        logrec = None
        if logp and os.path.exists(logp) and os.path.getsize(logp) > before:
            with open(logp, encoding="utf-8") as f:
                logrec = json.loads(f.read().splitlines()[-1])
        if logrec is None or logrec.get("tool") != tool or logrec.get("event") != event or logrec.get("decision") != dec:
            return (dec, None, text + " [no matching guard log record]", logrec)
        if out_rule and out_rule != logrec.get("rule"):
            return (dec, None, text + f" [output rule {out_rule} differs from the log's {logrec.get('rule')}]", logrec)
        return (dec, logrec.get("rule"), text, logrec)


def msg(to, **extra):
    d = {"to": to, "message": "Fixture message W27: please check point 3."}
    d.update(extra)
    return d


def both(fx, cid, label, tool_input, caller, dec, rule, also=None):
    """A SendMessage case on PreToolUse and its PermissionRequest twin: same decision, same rule."""
    for ev in ("PreToolUse", "PermissionRequest"):
        got = fx.call(tool_input, caller=caller, event=ev)
        ok = got[0] == dec and got[1] == rule
        why = f"exp={dec} {rule} got={got[0]} {got[1]}" + ("" if ok else f" ({got[2][:300]!r})")
        if ok and also:
            bad = also(got)
            ok, why = (not bad), (bad or why)
        report(ok, f"{cid} [{ev}] {label}", why)


def guard_tests(hook):
    fx = Fixture(hook)
    try:
        key, want = fx.find_key()
    except Exception as exc:
        not_run("guard section", f"the fixture key could not be found ({exc})")
        return
    report(key == want, f"K-1 the guard log's key for the fixture is the remote session's ({want})", f"got {key}")
    fx.write_registry(standard_registry())
    other = Fixture(hook, remote="cse_01W27FIXTUREOTHER00002", local="w27fixture-local-0002")
    other.dir = fx.dir                                              # another session's registry in the same directory
    other.key = re.sub(r"[^A-Za-z0-9_-]", "_", "session_01W27FIXTUREOTHER00002")
    other.write_registry([rec("start", A["other-session"], "researcher")])

    # over-blocking controls (each allowed by T6)
    for cid, label, to, caller in [
            ("P-1", "the executor to a finished checker (a scoped re-review resume)", A["checker"], MAIN),
            ("P-2", "the executor to a producer", A["producer"], MAIN),
            ("P-3", "the executor to a test designer", A["test-designer"], MAIN),
            ("P-4", "the executor to a researcher", A["researcher"], MAIN),
            ("P-5", "a researcher to a registered prober", A["prober"], A["researcher"]),
            ("P-6", "a prober to a registered researcher", A["researcher2"], A["prober"]),
            ("P-7", "a researcher to main", "main", A["researcher"]),
            ("P-8", "a producer to main", "main", A["producer"]),
            ("P-9", "a checker to main", "main", A["checker"]),
            ("P-10", "a checker to a registered researcher (any registered caller)", A["researcher"], A["checker"]),
            ("P-11", "a registered general-purpose caller to a prober", A["prober"], A["general"])]:
        both(fx, cid, label, msg(to), caller, "allow", R["allow"])
    both(fx, "P-12", "only the key to (a subset of the allowed keys)", {"to": A["researcher"]}, MAIN, "allow", R["allow"])
    both(fx, "P-13", "an explicit null agent_id is the executor", msg(A["producer"]), None, "allow", R["allow"])

    # K-2: with no remote session ID the key is the hook's session_id, and T6 reads the registry under that key
    fx2 = Fixture(hook, remote=None, local="w27fixture-local-0003")
    try:
        key2, want2 = fx2.find_key()
        report(key2 == want2, f"K-2 with no remote ID, the guard log's key is the hook's session_id ({want2})",
               f"got {key2}")
        fx2.write_registry(standard_registry())
        both(fx2, "P-K2", "no remote ID: the executor to a researcher in that key's registry", msg(A["researcher"]),
             MAIN, "allow", R["allow"])
    except Exception as exc:
        not_run("K-2", f"the second fixture failed ({exc})")

    # T6.1: input keys
    both(fx, "N-K1", "notify_when_idle", msg(A["researcher"], notify_when_idle=True), MAIN, "deny", R["keys"])
    both(fx, "N-K2", "summary (documented optional, not admitted)", msg(A["researcher"], summary="s"), MAIN, "deny",
         R["keys"])
    for i, k in enumerate(LEGACY_KEYS, 3):
        both(fx, f"N-K{i}", f"legacy key {k}", msg(A["researcher"], **{k: "x"}), MAIN, "deny", R["keys"])
    both(fx, "N-K9", "an unknown key", msg(A["researcher"], cc=A["prober"]), MAIN, "deny", R["keys"],
         also=lambda g: None if re.search(r"\bto\b", g[2]) and "message" in g[2] else "T6.1's text does not name to "
                                                                                       "and message")
    # T6.2 to T6.5: target shapes
    for cid, label, to in [("N-S1", "a list of one ID", [A["researcher"]]),
                           ("N-S2", "a list of two IDs", [A["researcher"], A["prober"]]),
                           ("N-S3", "an object", {"id": A["researcher"]}), ("N-S4", "a number", 7),
                           ("N-S5", "null", None), ("N-S6", "a boolean", True)]:
        both(fx, cid, f"to is {label}", msg(to), MAIN, "deny", R["shape"])
    both(fx, "N-E1", "to is empty", msg(""), MAIN, "deny", R["empty"])
    both(fx, "N-E2", "no to", {"message": "x"}, MAIN, "deny", R["empty"])
    both(fx, "N-B1", "to is * (broadcast)", msg("*"), A["researcher"], "deny", R["star"])
    both(fx, "N-B2", "to is * from the executor", msg("*"), MAIN, "deny", R["star"])
    both(fx, "N-R1", "a session_ reference", msg("session_01W27FIXTUREPEER0003"), MAIN, "deny", R["session"])
    both(fx, "N-R2", "a cse_ reference", msg("cse_01W27FIXTUREPEER0003"), MAIN, "deny", R["session"])
    both(fx, "N-R3", "this session's own remote ID", msg(fx.remote), A["researcher"], "deny", R["session"])

    # T6.6: not an ID of this session's registry (names, near-IDs, other sessions)
    r = A["researcher"]

    def no_hint(to):   # no name-to-ID hint is built (W27-4): no fixture ID appears unless the call itself held it
        return lambda g: next((f"the denial carries the ID {v}, which the call did not hold" for v in A.values()
                               if v in g[2] and v not in to), None)
    for cid, label, to in [("N-129", "a name (tools/test_tool_allowlist.sh:129's input)", "someone"),
                           ("N-N2", "a role name", "researcher"),
                           ("N-N3", "a name the registry holds once (no hint is built)", "fixture-helper-r"),
                           ("N-N4", "the ID in upper case", r.upper()),
                           ("N-N5", "the ID with a leading space", " " + r),
                           ("N-N6", "the ID with a trailing newline", r + "\n"),
                           ("N-N7", "the ID with an agent- prefix", "agent-" + r),
                           ("N-N8", "a prefix of the ID", r[:-1]),
                           ("N-N9", "the ID with a character added", r + "0"),
                           ("N-N10", "an ID held only in another session's registry", A["other-session"]),
                           ("N-N11", "the text null", "null"),
                           ("N-N12", "an unregistered ID of the right shape", A["internal"]),
                           ("N-N13", "the hook input's own session_id (a session name, no prefix)", fx.local)]:
        both(fx, cid, label, msg(to), MAIN, "deny", R["unknown"], also=no_hint(to))

    # T6.7: the caller is not allowed for the target
    for cid, label, to, caller in [
            ("N-C1", "a researcher to a producer", A["producer"], A["researcher"]),
            ("N-C2", "a prober to a test designer", A["test-designer"], A["prober"]),
            ("N-C3", "a researcher to a checker (verdict integrity)", A["checker"], A["researcher"]),
            ("N-C4", "a producer to a checker (anchoring)", A["checker"], A["producer"]),
            ("N-C5", "a checker to a producer", A["producer"], A["checker"]),
            ("N-C6", "a test designer to a producer", A["producer"], A["test-designer"]),
            ("N-C7", "an unregistered non-null caller to main (guard #83's class)", "main", A["internal"]),
            ("N-C8", "an unregistered non-null caller to a researcher", A["researcher"], A["internal"]),
            ("N-C9", "a caller registered only in another session, to a prober", A["prober"], A["other-session"]),
            ("N-C10", "a researcher to a registered general-purpose agent", A["general"], A["researcher"]),
            ("N-C11", "a researcher to a registered counter-designer", A["counter"], A["researcher"]),
            ("N-C12", "the executor to a registered general-purpose agent (any other type takes none)", A["general"],
             MAIN),
            ("N-C13", "the executor to a registered counter-designer (any other type takes none)", A["counter"], MAIN)]:
        both(fx, cid, label, msg(to), caller, "deny", R["caller"])
    # T6.8: self
    both(fx, "N-M1", "a researcher to its own ID", msg(A["researcher"]), A["researcher"], "deny", R["self"])
    both(fx, "N-M2", "a prober to its own ID", msg(A["prober"]), A["prober"], "deny", R["self"])
    both(fx, "N-M3", "main to main", msg("main"), MAIN, "deny", R["self"])

    # L4 still reads the text (SendMessage is not a local tool)
    tok = "dvenv1" + "_" + "Q" * 43
    both(fx, "L4-1", "a DevOS token-format string in the message", msg(A["researcher"], message="see " + tok), MAIN,
         "deny", "L4")

    # T6.9 and containment: unrelated calls decided as with a sound registry
    unrelated = [("Read", {"file_path": os.path.join(ROOT, "plan", "SB-COR_Correction_Plan.md")}),
                 ("Bash", {"command": "ls"}), ("ListAgents", {}),
                 ("Write", {"file_path": os.path.join(fx.dir, fx.key + ".agents"), "content": "{}\n"}),
                 ("Bash", {"command": f"echo x >> {os.path.join(fx.dir, fx.key + '.agents')}"})]
    baseline = [fx.call(a, tool=t)[:2] for t, a in unrelated]
    fixed = {0: ("allow", "T1"), 2: ("deny", "T1")}
    for i, want in fixed.items():
        report(baseline[i] == want, f"C-0.{i} baseline: {unrelated[i][0]} decided {want}", f"got {baseline[i]}")
    report(baseline[3][0] == "deny" and baseline[4][0] == "deny",
           "C-0.3 a Write and a shell append forging the registry are denied (the existing log-directory rules)",
           f"got {baseline[3]} {baseline[4]}")
    noreg_text = lambda g: None if ("no registry for this session" in g[2] and "Received from / Returned to" in g[2]) \
        else "the denial does not carry the stated text"
    regpath = os.path.join(fx.dir, fx.key + ".agents")
    states = [("missing", lambda: None),            # removed by the loop below before each state is made
              ("a directory", lambda: os.mkdir(regpath)),
              ("a line that is not JSON", lambda: fx.write_registry(None, raw=json.dumps(standard_registry()[1]) +
                                                                     "\n{not json\n")),
              ("a line that is JSON but not an object", lambda: fx.write_registry(None, raw="[1, 2]\n"))]
    for n, (label, make) in enumerate(states, 1):
        if os.path.isdir(regpath):
            os.rmdir(regpath)
        elif os.path.exists(regpath):
            os.remove(regpath)
        make()
        both(fx, f"N-G{n}", f"the registry is {label}: denied, no registry", msg(A["researcher"]), MAIN, "deny",
             R["noreg"], also=noreg_text)
        now = [fx.call(a, tool=t)[:2] for t, a in unrelated]
        report(now == baseline, f"C-{n} the registry {label}: every unrelated call decided as with a sound registry",
               f"{now} != {baseline}")
    if os.path.isdir(regpath):
        os.rmdir(regpath)
    fx.write_registry(standard_registry())
    both(fx, "P-14", "the sound registry restored: allowed again", msg(A["researcher"]), MAIN, "allow", R["allow"])

    # the registry under the writer's exclusive lock: the read does not go round the lock
    holder = subprocess.Popen([sys.executable, "-c", "import fcntl,sys,time\nf=open(sys.argv[1],'a')\n"
                               "fcntl.flock(f,fcntl.LOCK_EX)\nprint('locked',flush=True)\ntime.sleep(400)", regpath],
                              stdout=subprocess.PIPE, text=True)
    try:
        holder.stdout.readline()
        t0 = time.monotonic()
        got = fx.call(msg(A["researcher"]), timeout=150)
        took = time.monotonic() - t0
        report(got[:2] == ("deny", R["noreg"]) and took < 150,
               "N-L1 the registry held under LOCK_EX by a writer: denied T6.9 within the bounded wait",
               f"got {got[:2]} after {took:.1f} s")
    finally:
        holder.kill()
        holder.wait()

    # a planted error inside the registry read (all opens of *.agents raise a non-OSError): contained to that call
    site = tempfile.mkdtemp(prefix="w27site-")
    with open(os.path.join(site, "sitecustomize.py"), "w") as f:
        f.write("import builtins, io, os\n"
                "class PlantedRegistryError(RuntimeError):\n    pass\n"
                "_open, _osopen = builtins.open, os.open\n"
                "def _check(p):\n"
                "    if isinstance(p, (str, bytes, os.PathLike)) and os.fsdecode(p).endswith('.agents'):\n"
                "        raise PlantedRegistryError('planted by tools/test_send_message.py')\n"
                "def _o(file, *a, **k):\n    _check(file)\n    return _open(file, *a, **k)\n"
                "def _oo(path, *a, **k):\n    _check(path)\n    return _osopen(path, *a, **k)\n"
                "builtins.open = _o\nio.open = _o\nos.open = _oo\n")
    pp = {"PYTHONPATH": site + os.pathsep + os.environ.get("PYTHONPATH", "")}
    for ev in ("PreToolUse", "PermissionRequest"):
        got = fx.call(msg(A["researcher"]), event=ev, env_extra=pp)
        report(got[0] == "deny" and got[1] in (R["error"], R["noreg"]),
               f"C-5 [{ev}] a planted error in the registry read: denied as T6.0 or T6.9, never G0 or a block",
               f"got {got[:2]}")
    now = [fx.call(a, tool=t, env_extra=pp)[:2] for t, a in unrelated]
    report(now == baseline, "C-6 under the planted error, every unrelated call decided as before", f"{now} != {baseline}")
    shutil.rmtree(site, ignore_errors=True)

    # T6.0 in-process: an exception raised inside T6 denies that call as T6.0, not G0
    os.environ.update(DEVOS_GUARD_LOG_DIR=fx.dir, CLAUDE_CODE_REMOTE_SESSION_ID=fx.remote)
    sys.dont_write_bytecode = True   # the import leaves no __pycache__ beside the guard
    try:
        spec = importlib.util.spec_from_file_location("w27_guard_under_test", hook)
        g = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(g)
    except Exception as exc:
        not_run("T6.0", f"the guard could not be imported ({type(exc).__name__}: {exc})")
        return
    if not callable(getattr(g, "send_message_checks", None)):
        report(False, "T6.0 the guard has a module function send_message_checks(data, args) [T]", "absent")
        return

    def boom(*a, **k):
        raise ZeroDivisionError("planted inside T6 by tools/test_send_message.py")
    g.send_message_checks = boom
    for ev in ("PreToolUse", "PermissionRequest"):
        data = {"session_id": fx.local, "cwd": ROOT, "hook_event_name": ev, "tool_name": "SendMessage",
                "tool_input": msg(A["researcher"])}
        try:
            res = g.decide(data)
        except Exception as exc:   # escaped decide(): main() would deny it as G0, the guard-wide path
            res = ("escaped", type(exc).__name__)
        report(res[:2] == ("deny", R["error"]), f"T6.0 [{ev}] an exception inside T6: decide() denies T6.0",
               f"got {res[:2]}")
        out = io.StringIO()
        sys_stdin = sys.stdin
        sys.stdin = io.StringIO(json.dumps(data))
        try:
            with redirect_stdout(out):
                g.main() if ev == "PreToolUse" else None
        finally:
            sys.stdin = sys_stdin
        if ev == "PreToolUse":
            report("DENIED by rule T6.0 (" in out.getvalue(), "T6.0 main() prints the T6.0 denial",
                   out.getvalue()[:200])
        res2 = g.decide({**data, "tool_name": "Read",
                         "tool_input": {"file_path": os.path.join(ROOT, "plan", "SB-COR_Correction_Plan.md")}})
        report(res2[:2] == ("allow", "T1"), f"T6.0 [{ev}] with T6 raising, a Read is still allowed T1", f"{res2[:2]}")
    # every T6 deny ID has its own entry in RULES (not G0's fallback text)
    rules = getattr(g, "RULES", {})
    miss = [v for k, v in R.items() if k != "allow" and v not in rules]
    report(not miss, "T6-R every T6 deny ID has its own RULES entry", f"missing {miss}")
    report("SendMessage" in getattr(g, "ALLOWED_NON_MCP", ()) and "SendMessage" not in getattr(g, "LOCAL_TOOLS", ()),
           "T6-S SendMessage is in ALLOWED_NON_MCP and not in LOCAL_TOOLS")


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True, cwd=ROOT)


def role_tests(base):
    agents = os.path.join(ROOT, ".claude", "agents")
    texts = {}
    for role in ROLES + ("counter-designer",):
        p = os.path.join(agents, role + ".md")
        if not os.path.isfile(p):
            report(False, f"RF-0 .claude/agents/{role}.md exists")
            continue
        with open(p, encoding="utf-8") as f:
            texts[role] = f.read()

    def tools_of(text):
        fm = text.split("\n---", 1)[0] if text.startswith("---") else ""
        m = re.findall(r"^tools:[ \t]*(.*)$", fm, re.M)
        return [t.strip() for t in m[0].split(",")] if len(m) == 1 else None

    sendback = {}
    for role in ROLES:
        if role not in texts:
            continue
        t = tools_of(texts[role])
        report(t is not None and t.count("SendMessage") == 1, f"RF-1 {role}: the tools line holds SendMessage once",
               f"tools {t}")
        report(t is not None and "ToolSearch" not in t, f"RF-2 {role}: no ToolSearch in tools (3.7's fallback is a "
               "later change, selected only by the discriminator)", f"tools {t}")
        report(OLD_SENDBACK not in texts[role], f"RF-3 {role}: the old send-back sentence is gone")
        lines = [ln for ln in texts[role].splitlines() if ln.startswith("**Send-back**.")]
        ok = len(lines) == 1 and "SendMessage" in lines[0] and "Received from / Returned to" in lines[0]
        report(ok, f"RF-4 {role}: one Send-back line, naming SendMessage and Received from / Returned to",
               f"{len(lines)} lines")
        if lines:
            sendback[role] = lines[0]
    report(len(set(sendback.values())) == 1 and len(sendback) == len(ROLES),
           "RF-5 the five Send-back lines are the same line (one reload marker for every role)")
    if "counter-designer" in texts:
        t = tools_of(texts["counter-designer"])
        report(t == ["Write"], "RF-6 counter-designer: tools is Write only", f"tools {t}")

    if not base:
        mb = git("merge-base", "HEAD", "refs/remotes/origin/main")
        head = git("rev-parse", "HEAD").stdout.strip()
        base = mb.stdout.strip() if mb.returncode == 0 and mb.stdout.strip() != head else ""
    if not base or git("cat-file", "-e", base + "^{commit}").returncode != 0:
        not_run("RF-7 to RF-9 (diff against the base)", "no base: give --base <the pull request's base SHA>")
        return
    for role in ROLES + ("counter-designer",):
        old = git("show", f"{base}:.claude/agents/{role}.md")
        if old.returncode != 0 or role not in texts:
            report(False, f"RF-7 {role}: readable at the base and the head")
            continue
        if role == "counter-designer":
            report(old.stdout == texts[role], "RF-8 counter-designer.md is byte-identical to the base")
            continue
        a, b = old.stdout.split("\n"), texts[role].split("\n")
        changed = [i for i in range(max(len(a), len(b))) if (a[i] if i < len(a) else None) != (b[i] if i < len(b) else None)]
        kinds = sorted("tools" if a[i].startswith("tools:") else "sendback" if a[i].startswith("**Send-back**.")
                       else f"line {i + 1}" for i in changed if i < len(a))
        ok = len(a) == len(b) and kinds == ["sendback", "tools"]
        if ok:
            ta, tb = tools_of(old.stdout), tools_of(texts[role])
            ok = ta is not None and tb is not None and sorted(tb) == sorted(ta + ["SendMessage"])
        report(ok, f"RF-9 {role}: only the tools line (gaining SendMessage) and the Send-back line differ from the base",
               f"changed {kinds}, lines {len(a)} -> {len(b)}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--hook", default=GUARD_REL)
    ap.add_argument("--base", default="")
    ap.add_argument("--only", choices=("guard", "roles"))
    a = ap.parse_args()
    hook = os.path.abspath(a.hook)
    if a.only != "roles":
        guard_tests(hook)
    if a.only != "guard":
        role_tests(a.base)
    n = RESULTS["ok"] + RESULTS["bad"]
    if RESULTS["bad"] or RESULTS["notrun"] or n == 0:
        print(f"W27 FAIL {RESULTS['bad']} BAD, {RESULTS['notrun']} NOT RUN, {RESULTS['ok']} ok")
        return 1
    print(f"W27 PASS {n} checks")
    return 0


if __name__ == "__main__":
    sys.exit(main())
