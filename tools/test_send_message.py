#!/usr/bin/env python3
"""Tests of guard rule T6 (SendMessage) and of the role files' messaging lines: W-C02-27 (SB-COR 3.6b), new version
for W-C02-27.1 (T6's key check against the input the platform really delivers to the hook).

Synthetic test data (plan Section 8 item 13): every agent ID, session ID, name and message here is made up for the
test and holds no personal or business data. The agent IDs are "a" + 16 hex derived from a fixture label, the form of
the IDs the guard log shows; the session IDs carry "W27FIXTURE". The token-format string of cases L4-1 and L4-2 is
built at run time and is not a token. Not made up: the guard record number #4295, the transcript's tool-use ID and the
Claude Code version in the shape witness's provenance (key names, record number, tool-use ID and version only; no
text of that call is held here, the repository being public).

Written by the items' test designers before any product (ledger rule 3; working order section 4 step 2). The
acceptance conditions (plan/work/W-C02-27.md, and plan/work/W-C02-27.1.md, which this version answers) pin the
interface these tests read. In short:
  - the guard is run through the commands .claude/settings.json holds at hooks.PreToolUse[0] and
    hooks.PermissionRequest[0], with the script path replaced by the hook under test (as tools/test_tool_allowlist.sh
    does); every SendMessage case runs on both events and must get the same decision and rule;
  - rule IDs: T6 (allow), T6.0 (error inside T6), T6.1 (an input key not admitted: a key outside {to, message,
    summary, type, recipient, recipient_kind, content}, or a partial set of the four platform keys), T6.2 (`to` not
    one string), T6.3 (`to` missing or empty), T6.4 (`to` is "*"), T6.5 (`to` a session reference), T6.6 (`to` not an
    agent ID held in this session's registry), T6.7 (the caller is not allowed for that target), T6.8 (a message to
    the caller's own ID, or main to main), T6.9 (no readable registry for this session), T6.10 (a platform key
    disagrees with to and message, or message is not one string; checked after T6.6 and T6.7, last before the allow);
    a decision's rule is read from the guard's own log record of the call, and where the output text carries a rule
    it must agree;
  - the shape witness SHAPE_WITNESS below is the one source of the platform shape (W-C02-27.1 C1); platform_shape()
    is the one builder generated from it; no platform-shape input is written by hand in the three suites
    (tools/test_tool_allowlist.sh and tools/test_agent_hooks.py call this builder: `--shape`, `platform_shape`);
  - the texts and the record's format pinned by this version (W-C02-27.1 A7, B1) are the constants T61_*, T610_*,
    LOG_RE below;
  - the registry is W-C02-25's: <DEVOS_GUARD_LOG_DIR>/<session key>.agents, JSON Lines with that item's fixed keys;
  - T6.0 is driven in-process by replacing the guard's module function send_message_checks(data, args) with one
    that raises; CT-1 replaces redact() for calls made from summary() with one that raises.

Usage, from the root of a devos clone:
    python3 tools/test_send_message.py [--hook PATH] [--base REV] [--only guard|roles]
    python3 tools/test_send_message.py --shape TO MESSAGE [SUMMARY]   (prints the builder's JSON tool input)
--hook defaults to .claude/hooks/tool_allowlist.py; --base (for the role-file diff) defaults to the merge base of HEAD
and refs/remotes/origin/main. Prints one "ok" or "BAD" line per check, "NOT RUN" for a check that could not run, and
a last line "W271 PASS <n> checks" (exit 0) or "W271 FAIL ..." (exit 1). A NOT RUN line makes the run fail: a check
that did not run never reads as green.
"""
import argparse, hashlib, importlib.util, io, json, os, re, shutil, subprocess, sys, tempfile, time  # one line: the leak check matched the one-per-line form (L-450)
from contextlib import redirect_stdout

ROOT = os.getcwd()
GUARD_REL = ".claude/hooks/tool_allowlist.py"
ROLES = ("producer", "researcher", "prober", "checker", "test-designer")
OLD_SENDBACK = "Until a later change allows direct messages (W-C02-27)"
REC_KEYS = ("time", "event", "agent_id", "agent_type", "name", "item", "form", "tool_use_id", "prompt_sha256",
            "run", "outcome", "missing", "receipt", "package")   # W-C02-25 approach, "Fixed keys"
MAIN = object()      # the caller is the main conversation: no agent_id in the hook input

R = {"allow": "T6", "error": "T6.0", "keys": "T6.1", "shape": "T6.2", "empty": "T6.3", "star": "T6.4",
     "session": "T6.5", "unknown": "T6.6", "caller": "T6.7", "self": "T6.8", "noreg": "T6.9", "tie": "T6.10"}

RESULTS = {"ok": 0, "bad": 0, "notrun": 0}

# ---------------------------------------------------------------- the shape witness (W-C02-27.1 C1; one source)
OBS = "observed from #4295"
INF = "inferred from the transcript and the program text"
SHAPE_WITNESS = {
    "provenance": {"guard_record": 4295, "tool_use_id": "toolu_01Tii7PmwDMAu5gR9YkSfPGU", "claude_code": "2.1.304",
                   "event": "PreToolUse"},
    # each key: the rule that makes it from the caller's to and message, and its label
    "keys": {
        "to": {"rule": "to", "relation": "the caller's to, unchanged", "label": OBS},
        "message": {"rule": "message", "relation": "the caller's message, present at the hook", "label": INF},
        "summary": {"rule": "summary", "relation": "the caller's own when one string not blank, else the first line "
                    "of the trimmed message; longer than 200 characters: its first 199 and an ellipsis",
                    "label": OBS},
        "type": {"rule": "type", "relation": "the constant message", "label": INF},
        "recipient": {"rule": "recipient", "relation": "equal to to", "label": OBS},
        "recipient_kind": {"rule": "recipient_kind", "relation": "main when to is main; agent for an agent ID "
                           "(observed for the shape a + 16 hex); session for a session reference; name otherwise",
                           "label": OBS, "value_labels": {"agent": OBS, "main": INF, "session": INF, "name": INF}},
        "content": {"rule": "content", "relation": "the message when at most 50 characters, else its first 49 and "
                    "an ellipsis", "label": INF},
    },
    "branches": {
        "empty_message": {"relation": "no summary is derived when the trimmed message's first line is empty",
                          "label": INF},
        "to_not_string": {"keeps": ["to", "message", "summary"], "relation": "no key is added when to is absent or "
                          "not a string", "label": INF},
    },
}
ABSENT = object()
SUMMARY_MAX, CONTENT_MAX, ELLIPSIS = 200, 50, "…"


def _summary(c):
    s, m = c["summary"], c["message"]
    if isinstance(m, str) and (not isinstance(s, str) or not s.strip()):
        first = m.strip().split("\n")[0].strip()
        if first:
            s = first
    if isinstance(s, str) and len(s) > SUMMARY_MAX:
        s = s[:SUMMARY_MAX - 1] + ELLIPSIS
    return s if isinstance(s, str) else ABSENT


def _kind(to):
    if to == "main":
        return "main"
    if to.startswith(("session_", "cse_")):
        return "session"
    return "agent" if re.fullmatch(r"a[0-9a-f]{16}", to) else "name"


SHAPE_RULES = {
    "to": lambda c: c["to"],
    "message": lambda c: c["message"],
    "summary": _summary,
    "type": lambda c: "message",
    "recipient": lambda c: c["to"],
    "recipient_kind": lambda c: _kind(c["to"]),
    "content": lambda c: c["message"] if len(c["message"]) <= CONTENT_MAX else
    c["message"][:CONTENT_MAX - 1] + ELLIPSIS,
}


def platform_shape(to, message, summary=None):
    """The builder: the tool input the hook receives at the witness's version for this to and message (a string),
    with the caller's own summary when given. Generated from SHAPE_WITNESS: one key per witness key, by its rule."""
    if not isinstance(message, str):
        raise TypeError("the builder takes a string message; structured messages are planted on its output")
    c = {"to": to, "message": message, "summary": summary}
    keep = None if isinstance(to, str) else set(SHAPE_WITNESS["branches"]["to_not_string"]["keeps"])
    out = {}
    for k, spec in SHAPE_WITNESS["keys"].items():
        if keep is not None and k not in keep:
            continue
        if k == "to" and to is ABSENT:
            continue
        v = SHAPE_RULES[spec["rule"]](c)
        if v is not ABSENT:
            out[k] = v
    return out


# ---------------------------------------------------------------- the pinned texts and record format (A7, B1)
T61_TITLE = "an input key not admitted"
T61_TODO = "If you sent only to and message, report this denial to the executor as a guard finding"
T61_DETAIL_KEYS = "the input keys not admitted: "                 # then the keys, sorted, cut as T6.1 cuts them
T61_DETAIL_PARTIAL = "a partial set of the platform's keys (present: {p}; missing: {m})"
T610_TITLE = "a platform key disagrees with to and message, or message is not one string"
T610_DIFFERS = "the key {k} disagrees (observed {v})"            # type and recipient_kind; v is json.dumps(value)
T610_RECIPIENT = "the key recipient disagrees with to"
T610_NOT_STRING = "the key {k} is not one string"
FORBIDDEN_T6_TEXT = ("outside to and message", "outside {to, message}", "only to and message are admitted",
                     "Send only the keys to", "the legacy keys are not admitted")
TIES = ("message", "type", "recipient", "recipient_kind", "content", "summary")
_W = r"(?:agrees|absent|not one string|differs \(observed .{1,40}?\)|differs)"
LOG_RE = re.compile(r"; keys \[(?P<keys>[^\]]*)\](?: \(\+(?P<more>\d+) more\))?; ties "
                    + ", ".join(f"{t} (?P<{t}>{_W})" for t in TIES) + r"$")


def rule_part(detail):
    return (detail or "").split("; keys [")[0]


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
        self.last_output = p.stdout + p.stderr
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


LONG = ("Fixture message W271, longer than the platform's summary cut: " + "please read point 3 of the fixture "
        "item and answer in your hand-over; " * 6).strip()          # one line, over 200 characters

LOGS = {}      # cid -> (tool input, the PreToolUse log record, the PreToolUse output text)
RUN_IDS = set()


def both(fx, cid, label, tool_input, caller, dec, rule, also=None):
    """A SendMessage case on PreToolUse and its PermissionRequest twin: same decision, same rule."""
    RUN_IDS.add(cid)
    for ev in ("PreToolUse", "PermissionRequest"):
        got = fx.call(tool_input, caller=caller, event=ev)
        if ev == "PreToolUse":
            LOGS[cid] = (tool_input, got[3], got[2])
        ok = got[0] == dec and got[1] == rule
        why = f"exp={dec} {rule} got={got[0]} {got[1]}" + ("" if ok else f" ({got[2][:300]!r})")
        if ok and also:
            bad = also(got)
            ok, why = (not bad), (bad or why)
        report(ok, f"{cid} [{ev}] {label}", why)


def twin_of(tool_input):
    """The platform-shape twin of a W-C02-27 raw input (A5): the builder's output for its to, message and summary."""
    return platform_shape(tool_input.get("to", ABSENT), tool_input.get("message", ""), tool_input.get("summary"))


# W-C02-27's deny cases of its points 1 and 2 (57), and the ten that get no /p twin (A5)
W27_DENY_IDS = ([f"N-K{i}" for i in range(1, 10)] + [f"N-S{i}" for i in range(1, 7)] + ["N-E1", "N-E2", "N-B1", "N-B2"]
                + [f"N-R{i}" for i in range(1, 4)] + ["N-129"] + [f"N-N{i}" for i in range(2, 14)]
                + [f"N-C{i}" for i in range(1, 14)] + [f"N-M{i}" for i in range(1, 4)] + ["L4-1"]
                + [f"N-G{i}" for i in range(1, 5)] + ["N-L1"])
NO_TWIN = [f"N-K{i}" for i in range(1, 10)] + ["L4-1"]
TWIN_IDS = [c + "/p" for c in W27_DENY_IDS if c not in NO_TWIN]


def deny27(fx, cid, label, tool_input, caller, rule, also=None):
    """A W-C02-27 deny case in its raw shape, then its /p twin in the platform shape, same decision and rule."""
    both(fx, cid, label, tool_input, caller, "deny", rule, also)
    if cid not in NO_TWIN:
        both(fx, cid + "/p", label + " [platform shape]", twin_of(tool_input), caller, "deny", rule, also)


def names_keys(keys):
    """A3: the T6.1 detail's own part (before the record's key list) names each key."""
    def chk(g):
        part = rule_part((g[3] or {}).get("detail"))
        miss = [k for k in keys if k not in part]
        return f"the T6.1 detail does not name {miss}: {part[:200]!r}" if miss else None
    return chk


def names_tie(key):
    """A4: the T6.10 detail's own part names the key."""
    def chk(g):
        part = rule_part((g[3] or {}).get("detail"))
        return None if f"the key {key} " in part else f"the T6.10 detail does not name {key}: {part[:200]!r}"
    return chk


def plant(base, **changes):
    """The builder's output with planted changes (ABSENT removes a key): never a hand-written platform shape."""
    d = dict(base)
    for k, v in changes.items():
        if v is ABSENT:
            d.pop(k, None)
        else:
            d[k] = v
    return d


def guard_tests(hook):
    # the denominators first: the witness, the builder, the twins (WIT-1, WIT-2, A5)
    keys = SHAPE_WITNESS["keys"]
    report(len(keys) == 7 and set(keys) == {"to", "message", "summary", "type", "recipient", "recipient_kind",
                                            "content"} and all(v.get("label") in (OBS, INF) for v in keys.values()),
           "WIT-2 the witness holds exactly the seven keys, each labelled observed from #4295 or inferred",
           f"keys {sorted(keys)} labels {[v.get('label') for v in keys.values()]}")
    n7, n6, n3 = (len(platform_shape(A["checker"], LONG)), len(platform_shape(A["checker"], "")),
                  len(platform_shape(7, "x")))
    report((n7, n6, n3) == (7, 6, 3), "WIT-1 the builder's key count: 7 for a string message whose first line is not "
           "blank, 6 for an empty message, 3 for a to that is not a string", f"got {(n7, n6, n3)}")
    texts = {}
    for rel in ("tools/test_tool_allowlist.sh", "tools/test_agent_hooks.py"):
        try:
            texts[rel] = open(os.path.join(ROOT, rel), encoding="utf-8").read()
        except OSError as exc:
            texts[rel] = None
            report(False, f"WIT-3 {rel} is readable", str(exc))
    if all(t is not None for t in texts.values()):
        sh, py = texts["tools/test_tool_allowlist.sh"], texts["tools/test_agent_hooks.py"]
        hand = [rel for rel, t in texts.items() if "recipient_kind" in t or '"recipient"' in t]
        report(not hand and sh.count("tools/test_send_message.py --shape") >= 2 and "platform_shape(" in py,
               "WIT-3 every twin in the other two suites is made by the builder (they call it; no platform key "
               "written by hand)", f"hand-written in {hand}")
    report(len(W27_DENY_IDS) == 57 and len(TWIN_IDS) == len(W27_DENY_IDS) - len(NO_TWIN) == 47,
           "A5-N the /p twins number W-C02-27's deny cases of points 1 and 2 less the ten (N-K1 to N-K9, L4-1): 47",
           f"{len(W27_DENY_IDS)} deny cases, {len(TWIN_IDS)} twins")

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

    # A2: over-blocking controls (each allowed by T6), the raw shape and its platform-shape twin
    pos = [("P-1", "the executor to a finished checker (a scoped re-review resume)", A["checker"], MAIN),
           ("P-2", "the executor to a producer", A["producer"], MAIN),
           ("P-3", "the executor to a test designer", A["test-designer"], MAIN),
           ("P-4", "the executor to a researcher", A["researcher"], MAIN),
           ("P-5", "a researcher to a registered prober", A["prober"], A["researcher"]),
           ("P-6", "a prober to a registered researcher", A["researcher2"], A["prober"]),
           ("P-7", "a researcher to main", "main", A["researcher"]),
           ("P-8", "a producer to main", "main", A["producer"]),
           ("P-9", "a checker to main", "main", A["checker"]),
           ("P-10", "a checker to a registered researcher (any registered caller)", A["researcher"], A["checker"]),
           ("P-11", "a registered general-purpose caller to a prober", A["prober"], A["general"])]
    for cid, label, to, caller in pos:
        both(fx, cid, label, msg(to), caller, "allow", R["allow"])
    for cid, label, to, caller in pos:
        tw = twin_of(msg(to))
        also = None
        if to == "main":
            also = lambda g, tw=tw: None if tw.get("recipient_kind") == "main" and tw.get("recipient") == "main" \
                else "the twin to main does not carry recipient main and kind main"
        both(fx, cid + "/p", label + " [platform shape]", tw, caller, "allow", R["allow"], also)
    both(fx, "P-12", "only the key to (a subset of the allowed keys)", {"to": A["researcher"]}, MAIN, "allow", R["allow"])
    both(fx, "P-13", "an explicit null agent_id is the executor", msg(A["producer"]), None, "allow", R["allow"])
    both(fx, "P-13/p", "an explicit null agent_id is the executor [platform shape]", twin_of(msg(A["producer"])), None,
         "allow", R["allow"])
    pr1 = platform_shape(A["checker"], LONG)
    pr1_ok = (len(pr1) == 7 and len(pr1["summary"]) == 200 and pr1["summary"].endswith(ELLIPSIS)
              and pr1["content"].endswith(ELLIPSIS) and len(LONG) > 200)
    both(fx, "P-R1", "the incident replayed with fixture IDs: the executor to a registered checker, the builder's "
         "seven keys for a message over 200 characters", pr1, MAIN, "allow", R["allow"],
         also=lambda g: None if pr1_ok else "the input is not the seven-key shape with a cut summary and content")
    both(fx, "PP-S1", "a caller's own short summary [platform shape]",
         platform_shape(A["researcher"], "Fixture message W271.", summary="fixture note"), MAIN, "allow", R["allow"])
    both(fx, "PP-S2", "a caller's own summary of 201 characters (synthetic: the guard sets no limit) [platform shape]",
         plant(platform_shape(A["researcher"], "Fixture message W271."), summary="s" * 201), MAIN, "allow",
         R["allow"])
    sh_in = platform_shape(A["researcher"], "Short fixture message W271.")
    both(fx, "PP-Sh", "a message of at most 50 characters (inferred from the program text) [platform shape]", sh_in,
         MAIN, "allow", R["allow"], also=lambda g: None if sh_in["content"] == sh_in["message"] else "content differs")
    both(fx, "PP-M", "a multi-line message (inferred from the program text) [platform shape]",
         platform_shape(A["researcher"], "Fixture line one W271.\nFixture line two.\n\nFixture line four."), MAIN,
         "allow", R["allow"])
    e_in = platform_shape(A["researcher"], "")
    both(fx, "PP-E", "an empty message: no summary, content empty (inferred from the program text) [platform shape]",
         e_in, MAIN, "allow", R["allow"],
         also=lambda g: None if "summary" not in e_in and e_in.get("content") == "" else "not the empty-message shape")
    both(fx, "P-S0", "W-C02-27's N-K2 input {to, message, summary} from the executor to a researcher: now allowed",
         msg(A["researcher"], summary="s"), MAIN, "allow", R["allow"])
    print("note N-K2 is retired: P-S0 replaces it (W-C02-27.1 A2)")

    # K-2: with no remote session ID the key is the hook's session_id, and T6 reads the registry under that key
    fx2 = Fixture(hook, remote=None, local="w27fixture-local-0003")
    try:
        key2, want2 = fx2.find_key()
        report(key2 == want2, f"K-2 with no remote ID, the guard log's key is the hook's session_id ({want2})",
               f"got {key2}")
        fx2.write_registry(standard_registry())
        both(fx2, "P-K2", "no remote ID: the executor to a researcher in that key's registry", msg(A["researcher"]),
             MAIN, "allow", R["allow"])
        both(fx2, "P-K2/p", "no remote ID: the executor to a researcher in that key's registry [platform shape]",
             twin_of(msg(A["researcher"])), MAIN, "allow", R["allow"])
    except Exception as exc:
        not_run("K-2", f"the second fixture failed ({exc})")

    # A3: T6.1, keys not admitted (raw, kept) and in a full platform set; partial sets
    r = A["researcher"]
    base = twin_of(msg(r))
    deny27(fx, "N-K1", "notify_when_idle", msg(r, notify_when_idle=True), MAIN, R["keys"], names_keys(["notify_when_idle"]))
    for i, k in enumerate(("type", "recipient", "recipient_kind", "content", "request_id", "approve"), 3):
        deny27(fx, f"N-K{i}", f"legacy key {k} (a single platform key is a partial set)", msg(r, **{k: "x"}), MAIN,
               R["keys"], names_keys([k]))
    deny27(fx, "N-K9", "an unknown key", msg(r, cc=A["prober"]), MAIN, R["keys"], names_keys(["cc"]))
    for cid, k, v in (("N-K1/p", "notify_when_idle", True), ("N-K7/p", "request_id", "x"), ("N-K8/p", "approve", True),
                      ("N-K9/p", "cc", A["prober"])):
        both(fx, cid, f"{k} added to a full platform set whose ties agree", plant(base, **{k: v}), MAIN, "deny",
             R["keys"], names_keys([k]))
    both(fx, "N-P1", "a partial platform set: three of the four keys (no content)", plant(base, content=ABSENT), MAIN,
         "deny", R["keys"], names_keys(["type", "recipient", "recipient_kind"]))
    both(fx, "N-P2", "a partial platform set: two of the four keys (type and recipient)",
         plant(base, content=ABSENT, recipient_kind=ABSENT), MAIN, "deny", R["keys"], names_keys(["type", "recipient"]))

    # A5: W-C02-27's target shapes (T6.2 to T6.5), raw and /p
    for cid, label, to in [("N-S1", "a list of one ID", [r]), ("N-S2", "a list of two IDs", [r, A["prober"]]),
                           ("N-S3", "an object", {"id": r}), ("N-S4", "a number", 7),
                           ("N-S5", "null", None), ("N-S6", "a boolean", True)]:
        deny27(fx, cid, f"to is {label}", msg(to), MAIN, R["shape"])
    deny27(fx, "N-E1", "to is empty", msg(""), MAIN, R["empty"])
    deny27(fx, "N-E2", "no to", {"message": "x"}, MAIN, R["empty"])
    deny27(fx, "N-B1", "to is * (broadcast)", msg("*"), A["researcher"], R["star"])
    deny27(fx, "N-B2", "to is * from the executor", msg("*"), MAIN, R["star"])
    deny27(fx, "N-R1", "a session_ reference", msg("session_01W27FIXTUREPEER0003"), MAIN, R["session"])
    deny27(fx, "N-R2", "a cse_ reference", msg("cse_01W27FIXTUREPEER0003"), MAIN, R["session"])
    deny27(fx, "N-R3", "this session's own remote ID", msg(fx.remote), A["researcher"], R["session"])

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
        deny27(fx, cid, label, msg(to), MAIN, R["unknown"], also=no_hint(to))

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
        deny27(fx, cid, label, msg(to), caller, R["caller"])
    deny27(fx, "N-M1", "a researcher to its own ID", msg(r), A["researcher"], R["self"])
    deny27(fx, "N-M2", "a prober to its own ID", msg(A["prober"]), A["prober"], R["self"])
    deny27(fx, "N-M3", "main to main", msg("main"), MAIN, R["self"])

    # A4: ties (T6.10); each from a caller and to a target W-C02-27's rules allow, so T6.10 is the only refusal
    both(fx, "N-T1", "recipient another registered ID", plant(base, recipient=A["prober"]), MAIN, "deny", R["tie"],
         names_tie("recipient"))
    both(fx, "N-T2", "recipient a session reference", plant(base, recipient="session_01W27FIXTUREPEER0003"), MAIN,
         "deny", R["tie"], names_tie("recipient"))
    both(fx, "N-T3", "recipient the ID with a trailing space", plant(base, recipient=r + " "), MAIN, "deny", R["tie"],
         names_tie("recipient"))
    both(fx, "N-T3", "recipient the ID in upper case", plant(base, recipient=r.upper()), MAIN, "deny", R["tie"],
         names_tie("recipient"))
    both(fx, "N-T4", "recipient null", plant(base, recipient=None), MAIN, "deny", R["tie"], names_tie("recipient"))
    both(fx, "N-T4", "recipient a list", plant(base, recipient=[r]), MAIN, "deny", R["tie"], names_tie("recipient"))
    for cid, kind in (("N-T5", "name"), ("N-T6", "session"), ("N-T7", "main")):
        both(fx, cid, f"recipient_kind {kind} with a registered to", plant(base, recipient_kind=kind), MAIN, "deny",
             R["tie"], names_tie("recipient_kind"))
    both(fx, "N-T8", "recipient_kind agent with to main, from a registered caller",
         plant(twin_of(msg("main")), recipient_kind="agent"), A["researcher"], "deny", R["tie"],
         names_tie("recipient_kind"))
    both(fx, "N-T9", "type shutdown_request", plant(base, type="shutdown_request"), MAIN, "deny", R["tie"],
         names_tie("type"))
    both(fx, "N-T10", "type another value", plant(base, type="note"), MAIN, "deny", R["tie"], names_tie("type"))
    both(fx, "N-T11", "type not a string (null)", plant(base, type=None), MAIN, "deny", R["tie"], names_tie("type"))
    both(fx, "N-T11", "type not a string (a list)", plant(base, type=["message"]), MAIN, "deny", R["tie"],
         names_tie("type"))
    both(fx, "N-T12", "content not a string", plant(base, content=5), MAIN, "deny", R["tie"], names_tie("content"))
    both(fx, "N-T13", "summary not a string [platform shape]", plant(base, summary=7), MAIN, "deny", R["tie"],
         names_tie("summary"))
    both(fx, "N-T13", "summary not a string [raw shape]", msg(r, summary=7), MAIN, "deny", R["tie"],
         names_tie("summary"))
    both(fx, "N-T14", "message an object [raw shape]", msg(r, message={"text": "x"}), MAIN, "deny", R["tie"],
         names_tie("message"))
    both(fx, "N-T15", "message an object, type taken from it, no request_id or approve [platform shape]",
         plant(base, message={"type": "shutdown_request", "reason": "fixture"}, type="shutdown_request",
               summary=ABSENT), MAIN, "deny", R["tie"])
    for v, what in ((None, "null"), (7, "a number"), (["x"], "a list")):
        both(fx, "N-T16", f"message {what} [raw shape]", msg(r, message=v), MAIN, "deny", R["tie"],
             names_tie("message"))
    both(fx, "N-T17", "the target is never read from recipient: to a name, recipient a registered ID, kind agent",
         plant(twin_of(msg("someone")), recipient=r, recipient_kind="agent"), MAIN, "deny", R["unknown"])

    # A5's order cases: T6.10 is checked after T6.6 and T6.7, last before the allow
    both(fx, "O-1", "N-129's name with kind name", plant(twin_of(msg("someone")), recipient_kind="name"), MAIN, "deny",
         R["unknown"])
    both(fx, "O-1", "N-129's name with kind agent", plant(twin_of(msg("someone")), recipient_kind="agent"), MAIN,
         "deny", R["unknown"])
    both(fx, "O-2", "a researcher to a registered producer, recipient disagreeing",
         plant(twin_of(msg(A["producer"])), recipient=A["prober"]), A["researcher"], "deny", R["caller"])
    both(fx, "O-3", "a session_ value in to, kind session",
         plant(twin_of(msg("session_01W27FIXTUREPEER0003")), recipient_kind="session"), MAIN, "deny", R["session"])
    both(fx, "O-4", "an unknown key plus a disagreeing type", plant(base, cc=A["prober"], type="note"), MAIN, "deny",
         R["keys"])
    both(fx, "O-6", "the executor to main with kind agent", plant(twin_of(msg("main")), recipient_kind="agent"), MAIN,
         "deny", R["self"])

    # A6: L4 still reads the text (SendMessage is not a local tool), in the message and in a caller's own summary
    tok = "dvenv1" + "_" + "Q" * 43
    deny27(fx, "L4-1", "a DevOS token-format string in the message", msg(r, message="see " + tok), MAIN, "L4")
    both(fx, "L4-1/p", "a DevOS token-format string in the message [platform shape]",
         platform_shape(r, "see " + tok), MAIN, "deny", "L4")
    both(fx, "L4-2", "a DevOS token-format string only in a caller's own summary, the message clean [platform shape]",
         platform_shape(r, "Fixture message W271.", summary="see " + tok), MAIN, "deny", "L4")

    # B2's markers: no message text in the record or the hook's output
    marks = ("W271MARKMSG", "W271MARKCONTENT", "W271MARKSUMMARY")

    def marked(to):
        return plant(platform_shape(to, f"Fixture message {marks[0]}: please check point 3.",
                                    summary=f"{marks[2]} fixture"), content=f"{marks[1]} fixture")
    log4 = []

    def log4_case(cid, tool_input, caller, f=None):
        f = f or fx
        for ev in ("PreToolUse", "PermissionRequest"):
            got = f.call(tool_input, caller=caller, event=ev)
            seen = json.dumps(got[3], ensure_ascii=False) + getattr(f, "last_output", "")
            log4.append((f"{cid} [{ev}]", got[3] is not None, [m for m in marks if m in seen], got[:2]))
    log4_case("P-R1", plant(marked(A["checker"]), message=f"{marks[0]} " + LONG), MAIN)
    log4_case("N-K9/p", plant(marked(r), cc=A["prober"]), MAIN)
    log4_case("N-129/p", marked("someone"), MAIN)
    log4_case("N-T1", plant(marked(r), recipient=A["prober"]), MAIN)

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
        deny27(fx, f"N-G{n}", f"the registry is {label}: denied, no registry", msg(r), MAIN, R["noreg"],
               also=noreg_text)
        if n == 1:
            both(fx, "O-5", "no registry, plus a disagreeing tie", plant(base, recipient=A["prober"]), MAIN, "deny",
                 R["noreg"])
            log4_case("N-G1/p", marked(r), MAIN)
        now = [fx.call(a, tool=t)[:2] for t, a in unrelated]
        report(now == baseline, f"C-{n} the registry {label}: every unrelated call decided as with a sound registry",
               f"{now} != {baseline}")
    if os.path.isdir(regpath):
        os.rmdir(regpath)
    fx.write_registry(standard_registry())
    both(fx, "P-14", "the sound registry restored: allowed again", msg(r), MAIN, "allow", R["allow"])

    # the registry under the writer's exclusive lock: the read does not go round the lock
    holder = subprocess.Popen([sys.executable, "-c", "import fcntl,sys,time\nf=open(sys.argv[1],'a')\n"
                               "fcntl.flock(f,fcntl.LOCK_EX)\nprint('locked',flush=True)\ntime.sleep(400)", regpath],
                              stdout=subprocess.PIPE, text=True)
    try:
        holder.stdout.readline()
        for cid, ti in (("N-L1", msg(r)), ("N-L1/p", twin_of(msg(r)))):
            RUN_IDS.add(cid)
            t0 = time.monotonic()
            got = fx.call(ti, timeout=150)
            took = time.monotonic() - t0
            report(got[:2] == ("deny", R["noreg"]) and took < 150,
                   f"{cid} the registry held under LOCK_EX by a writer: denied T6.9 within the bounded wait"
                   + (" [platform shape]" if cid.endswith("/p") else ""), f"got {got[:2]} after {took:.1f} s")
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
        got = fx.call(msg(r), event=ev, env_extra=pp)
        report(got[0] == "deny" and got[1] in (R["error"], R["noreg"]),
               f"C-5 [{ev}] a planted error in the registry read: denied as T6.0 or T6.9, never G0 or a block",
               f"got {got[:2]}")
    now = [fx.call(a, tool=t, env_extra=pp)[:2] for t, a in unrelated]
    report(now == baseline, "C-6 under the planted error, every unrelated call decided as before", f"{now} != {baseline}")
    shutil.rmtree(site, ignore_errors=True)

    # every /p twin A5 lists was run (the denominator: a missing twin cannot pass)
    miss = [t for t in TWIN_IDS if t not in RUN_IDS]
    report(not miss, "A5-R every one of the 47 /p twins was run", f"not run: {miss}")

    # B1: the record's key names and tie results (LOG-1, LOG-2, LOG-3, LOG-6); B3 (LOG-5); B2 (LOG-4)
    def parsed(cid):
        ti, lr, _ = LOGS.get(cid, (None, None, None))
        m = LOG_RE.search((lr or {}).get("detail") or "")
        return ti, lr, m
    ti, lr, m = parsed("P-R1")
    report(bool(m) and m.group("keys") == "content, message, recipient, recipient_kind, summary, to, type"
           and all(m.group(t) == "agrees" for t in TIES),
           "LOG-1 P-R1's record lists the seven keys sorted and six ties that read agrees",
           f"detail {((lr or {}).get('detail') or '')[-260:]!r}")
    ti, lr, m = parsed("P-1")
    report(bool(m) and m.group("message") == "agrees" and all(m.group(t) == "absent" for t in TIES if t != "message"),
           "LOG-2 P-1's raw-shape record reads absent for the four platform ties and for summary",
           f"detail {((lr or {}).get('detail') or '')[-260:]!r}")
    _, lr9, m9 = parsed("N-T9")
    _, lr5, m5 = parsed("N-T5")
    report(bool(m9) and m9.group("type") == 'differs (observed "shutdown_request")' and bool(m5)
           and m5.group("recipient_kind") == 'differs (observed "name")',
           "LOG-3 N-T9's record names the observed type, and N-T5's the observed recipient_kind",
           f"{((lr9 or {}).get('detail') or '')[-160:]!r} / {((lr5 or {}).get('detail') or '')[-160:]!r}")
    log6 = [("T6", "P-R1"), ("T6.1", "N-K9/p"), ("T6.2", "N-S1/p"), ("T6.3", "N-E1/p"), ("T6.4", "N-B2/p"),
            ("T6.5", "N-R1/p"), ("T6.6", "N-129/p"), ("T6.7", "N-C1/p"), ("T6.8", "N-M3/p"), ("T6.9", "N-G1/p"),
            ("T6.10", "N-T1")]
    bad6 = []
    if len(log6) != 11 or len({x for x, _ in log6}) != 11:
        bad6.append(f"the decision set is not the eleven (allow, T6.1 to T6.10): {len(log6)}")
    for want_rule, cid in log6:
        ti, lr, m = parsed(cid)
        names = sorted(str(k)[:40] for k in (ti or {}))
        if not lr or lr.get("rule") != want_rule:
            bad6.append(f"{cid}: rule {(lr or {}).get('rule')}, not {want_rule}")
        elif not m or m.group("keys") != ", ".join(names[:8]):
            bad6.append(f"{cid}: no key list and ties in the pinned format ({(lr.get('detail') or '')[-160:]!r})")
    report(not bad6, "LOG-6 one case per decision (the allow and T6.1 to T6.10, eleven): keys and ties in detail",
           "; ".join(bad6))
    bad4 = [f"{c}: no record" if not hasrec else f"{c}: holds {found}" for c, hasrec, found, _ in log4
            if not hasrec or found]
    report(len(log4) == 10 and not bad4, "LOG-4 the markers planted in message, content and summary are in no field "
           "of the record and in none of the hook's output (P-R1, N-K9/p, N-129/p, N-T1, N-G1/p; both events)",
           f"{len(log4)} calls; " + "; ".join(bad4))
    _, lr, _ = parsed("P-R1")
    s = (lr or {}).get("summary") or ""
    want5 = [f'"to": "{A["checker"]}"', f'"recipient": "{A["checker"]}"', '"recipient_kind": "agent"',
             '"type": "message"']
    report(len(A["checker"]) == 17 and all(w in s for w in want5),
           "LOG-5 P-R1's record summary holds to (17 characters, uncut), recipient, recipient_kind and type in full",
           f"summary {s[:320]!r}")

    # A7: the texts (TXT-1, TXT-2), in the denial text and in the record's reason
    def text_ok(cid, title, detail_part=None, todo=None):
        _, lr, out = LOGS.get(cid, (None, None, ""))
        reason = (lr or {}).get("reason") or ""
        bad = []
        for where, t in (("the denial text", out or ""), ("the record's reason", reason)):
            if f": {title})" not in t:
                bad.append(f"{where} lacks the title")
            if todo and todo not in t:
                bad.append(f"{where} lacks the instruction")
        if detail_part is not None and rule_part((lr or {}).get("detail")) != detail_part:
            bad.append(f"detail {rule_part((lr or {}).get('detail'))!r} is not {detail_part!r}")
        return bad
    b = text_ok("N-K9/p", T61_TITLE, T61_DETAIL_KEYS + "cc", T61_TODO)
    report(not b, "TXT-1 T6.1's title, its detail naming the key not admitted, and its instruction to report a "
           "to-and-message-only denial as a guard finding (N-K9/p)", "; ".join(b))
    b = text_ok("N-P2", T61_TITLE, T61_DETAIL_PARTIAL.format(p="recipient, type", m="content, recipient_kind"))
    report(not b, "TXT-1 T6.1's detail naming the partial platform set (N-P2)", "; ".join(b))
    b = text_ok("N-T9", T610_TITLE, T610_DIFFERS.format(k="type", v='"shutdown_request"'))
    report(not b, "TXT-2 T6.10's title, and its detail naming the key type and the observed value (N-T9)",
           "; ".join(b))
    b = text_ok("N-T5", T610_TITLE, T610_DIFFERS.format(k="recipient_kind", v='"name"'))
    report(not b, "TXT-2 T6.10's detail naming recipient_kind and the observed value (N-T5)", "; ".join(b))
    b = text_ok("N-T1", T610_TITLE, T610_RECIPIENT)
    report(not b, "TXT-2 T6.10's detail naming recipient (N-T1)", "; ".join(b))
    b = text_ok("N-T12", T610_TITLE, T610_NOT_STRING.format(k="content"))
    report(not b, "TXT-2 T6.10's detail naming a key that is not one string (N-T12)", "; ".join(b))

    # in-process: T6.0, the RULES entries, CT-1
    os.environ.update(DEVOS_GUARD_LOG_DIR=fx.dir, CLAUDE_CODE_REMOTE_SESSION_ID=fx.remote)
    sys.dont_write_bytecode = True   # the import leaves no __pycache__ beside the guard

    def load_guard(name):
        found = importlib.util.spec_from_file_location(name, hook)   # the guard file under test
        built = importlib.util.module_from_spec(found)               # a fresh module, not put in sys.modules
        found.loader.exec_module(built)
        return built
    try:
        g = load_guard("w27_guard_under_test")
    except Exception as exc:
        not_run("T6.0", f"the guard could not be imported ({type(exc).__name__}: {exc})")
        return
    rules = getattr(g, "RULES", {})
    t6_texts = " ".join(" ".join(map(str, v)) for k, v in rules.items() if re.fullmatch(r"T6(\.\d+)?", k))
    hits = [p for p in FORBIDDEN_T6_TEXT if p in t6_texts] + \
        (["summary ... not admitted"] if re.search(r"\bsummary\b[^.]{0,80}\bnot admitted", t6_texts) else [])
    report(bool(t6_texts) and not hits, "TXT-1 no T6 text says only to and message are admitted, or that summary is "
           "not admitted", f"found {hits}")
    miss = [v for k, v in R.items() if k not in ("allow", "tie") and v not in rules]
    report(not miss, "T6-R every T6 deny ID T6.0 to T6.9 has its own RULES entry", f"missing {miss}")
    report("T6.10" in rules, "T6-R T6.10 has its own RULES entry", "missing T6.10")
    report("SendMessage" in getattr(g, "ALLOWED_NON_MCP", ()) and "SendMessage" not in getattr(g, "LOCAL_TOOLS", ()),
           "T6-S SendMessage is in ALLOWED_NON_MCP and not in LOCAL_TOOLS")

    # CT-1: redact() raising when summary() calls it; the decision and its record are kept
    try:
        g2 = load_guard("w271_guard_ct1")
        orig = g2.redact

        def raising_redact(s, _orig=orig):
            if sys._getframe(1).f_code.co_name == "summary":
                raise RuntimeError("planted by CT-1 in tools/test_send_message.py")
            return _orig(s)
        g2.redact = raising_redact
        nt1 = plant(base, recipient=A["prober"])
        for cid, ti, want in (("P-R1", pr1, ("allow", "T6")), ("N-T1", nt1, ("deny", "T6.10"))):
            for ev in ("PreToolUse", "PermissionRequest"):
                data = {"session_id": fx.local, "cwd": ROOT, "hook_event_name": ev, "tool_name": "SendMessage",
                        "tool_input": ti, "tool_use_id": "toolu_w271ct1"}
                res = g2.decide(data)
                text = g2.deny_text(data, res[1], res[2]) if res[0] == "deny" else f"allowed by rule {res[1]}"
                where = g2.log_decision(data, res[0], res[1], res[2], text)
                with open(os.path.join(fx.dir, fx.key + ".jsonl"), encoding="utf-8") as f:
                    last = json.loads(f.read().splitlines()[-1])
                ok = (res[:2] == want and where.startswith("#") and last.get("tool_use_id") == "toolu_w271ct1"
                      and last.get("rule") == want[1] and str(last.get("summary")).startswith("[not shown: "))
                report(ok, f"CT-1 [{ev}] {cid}'s input with redact raising inside summary(): {want[0]} {want[1]}, "
                       "logged, summary not shown", f"got {res[:2]}, log {where}, summary {str(last.get('summary'))[:80]!r}")
    except Exception as exc:
        report(False, "CT-1 could run", f"{type(exc).__name__}: {exc}")

    if not callable(getattr(g, "send_message_checks", None)):
        report(False, "T6.0 the guard has a module function send_message_checks(data, args)", "absent")
        return

    def boom(*a, **k):
        raise ZeroDivisionError("planted inside T6 by tools/test_send_message.py")
    g.send_message_checks = boom
    for ev in ("PreToolUse", "PermissionRequest"):
        for shape, ti in (("", msg(r)), ("/p", base)):
            data = {"session_id": fx.local, "cwd": ROOT, "hook_event_name": ev, "tool_name": "SendMessage",
                    "tool_input": ti}
            try:
                res = g.decide(data)
            except Exception as exc:   # escaped decide(): main() would deny it as G0, the guard-wide path
                res = ("escaped", type(exc).__name__)
            report(res[:2] == ("deny", R["error"]), f"T6.0{shape} [{ev}] an exception inside T6: decide() denies T6.0"
                   + (" [platform shape]" if shape else ""), f"got {res[:2]}")
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
    ap.add_argument("--shape", nargs="+", metavar="ARG", help="TO MESSAGE [SUMMARY]: print the builder's tool input")
    a = ap.parse_args()
    if a.shape:
        if len(a.shape) not in (2, 3):
            ap.error("--shape takes TO MESSAGE [SUMMARY]")
        print(json.dumps(platform_shape(*a.shape), ensure_ascii=False))
        return 0
    hook = os.path.abspath(a.hook)
    if a.only != "roles":
        guard_tests(hook)
    if a.only != "guard":
        role_tests(a.base)
    n = RESULTS["ok"] + RESULTS["bad"]
    if RESULTS["bad"] or RESULTS["notrun"] or n == 0:
        print(f"W271 FAIL {RESULTS['bad']} BAD, {RESULTS['notrun']} NOT RUN, {RESULTS['ok']} ok")
        return 1
    print(f"W271 PASS {n} checks")
    return 0


if __name__ == "__main__":
    sys.exit(main())
