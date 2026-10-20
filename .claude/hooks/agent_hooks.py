#!/usr/bin/env python3
"""agent_hooks.py <Event>: this session's agent registry, the role package at start, the hand-over's presence at stop
(W-C02-25; SB-COR 3.2 to 3.5). One script for four hooks of .claude/settings.json, each run as
`python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/agent_hooks.py" <Event> || true` with a 15-second timeout:

  PostToolUse   (matcher Agent|Task)  a `launch` record: the prompt's SHA-256, never its text; the `Writer or reader:`
                form and the `Item:` path parsed by the guard's own T5 functions (one parser); the agent ID from
                tool_response.agentId, and with no agent ID no item is bound.
  SubagentStart (the five role types) additionalContext: the header (tools/check_role_packages.py's HEADER), the package
                .claude/roles/<role>.md byte for byte, `Your agent ID: <id>`, and `Nonce: <16 hex>` as the last line;
                above 9,500 UTF-8 bytes nothing, recorded `oversize`. A `start` record with its run number.
  SubagentStop  (the five role types) a `stop` record, and at most one block per run: {"decision": "block",
                "reason": R} when a part the agent can supply is missing (the disciplines block; the hand-over
                headings of tools/subagent_audit.py's HANDOVER_HEADINGS, or a checker's binding verdict's
                VERDICT_KEYS; the nonce when `Package:` names a delivery). R names the missing parts and the package
                path, asks for the whole final message again and never carries the nonce or package text.
  SessionStart  (every source) plain stdout: the executor's header and .claude/roles/executor.md; a `session_start`
                record with the source (in `outcome`) and the package hash.

The registry is <LOG_DIR>/<session key>.agents (LOG_DIR: $DEVOS_GUARD_LOG_DIR, else /tmp/devos-guard; the key from the
guard's session_key), JSON Lines, append-only, each record with exactly the fourteen keys of KEYS. Writers take
fcntl.flock LOCK_EX, readers LOCK_SH, each with a bounded wait of LOCK_WAIT seconds; a line that is not a JSON object
makes the registry unreadable. The nonce is the first 16 hex of HMAC-SHA256 over the agent ID, keyed by the 32 random
bytes of <LOG_DIR>/<session key>.nonce-key (created once, O_EXCL, mode 0600); the stop hook recomputes it, so no nonce
is stored. The guard (F6) denies a subagent's call that names the key file.

Containment: the guard, tools/check_role_packages.py and tools/subagent_audit.py are loaded from this file's own
checkout, never the working directory. Every failure, a missing module included, ends with exit 0 and nothing on
stdout; a stop that cannot be judged (no start record, an unreadable registry or key file) is recorded
`could_not_check` and never blocked. The output is built whole before one write.
"""
import fcntl
import hashlib
import hmac
import importlib.machinery
import importlib.util
import json
import os
import sys
import time
from datetime import datetime, timezone

sys.dont_write_bytecode = True   # no __pycache__ in the checkout's .claude/hooks/ or tools/
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))       # the checkout this hook is in
LOG_DIR = os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard"
LIMIT = 9500          # UTF-8 bytes of additionalContext emitted whole (W-C02-23)
REASON_MAX = 1000     # characters of a block's reason (W25-6)
LOCK_WAIT = 4.0       # seconds per lock; a hook takes at most one lock wait, well inside its 15-second timeout
KEYS = ("time", "event", "agent_id", "agent_type", "name", "item", "form", "tool_use_id", "prompt_sha256", "run",
        "outcome", "missing", "receipt", "package")
_MODULES = {}


class Unreadable(Exception):
    pass


def module(rel, name):
    """A module of this checkout, loaded once from its path (never imported from sys.path)."""
    if name not in _MODULES:
        ldr = importlib.machinery.SourceFileLoader(name, os.path.join(ROOT, rel))
        mod = importlib.util.module_from_spec(importlib.util.spec_from_loader(name, ldr))
        ldr.exec_module(mod)
        _MODULES[name] = mod
    return _MODULES[name]


def guard():
    return module(os.path.join(".claude", "hooks", "tool_allowlist.py"), "devos_guard_for_agent_hooks")


def packages():
    return module(os.path.join("tools", "check_role_packages.py"), "devos_role_packages_for_agent_hooks")


def audit():
    return module(os.path.join("tools", "subagent_audit.py"), "devos_subagent_audit_for_agent_hooks")


def sha256(b):
    return hashlib.sha256(b).hexdigest()


def now():
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def record(event, **kw):
    rec = dict.fromkeys(KEYS)
    rec.update(time=now(), event=event, **kw)
    return rec


# ---------------------------------------------------------------- the registry

def registry_path(key, log_dir=None):
    return os.path.join(log_dir or LOG_DIR, f"{key}.agents")


def lock(f, kind):
    """flock with a bounded wait; False when the wait ran out."""
    end = time.monotonic() + LOCK_WAIT
    while True:
        try:
            fcntl.flock(f, kind | fcntl.LOCK_NB)
            return True
        except BlockingIOError:
            if time.monotonic() >= end:
                return False
            time.sleep(0.05)


def parse(data):
    """The records of a registry's bytes; Unreadable when a non-blank line is not a JSON object."""
    out = []
    for raw in data.splitlines():
        if raw.strip():
            try:
                r = json.loads(raw)
            except ValueError:
                raise Unreadable("a registry line is not JSON")
            if not isinstance(r, dict):
                raise Unreadable("a registry line is not a JSON object")
            out.append(r)
    return out


def read_registry(path):
    """The records, read under LOCK_SH with a bounded wait (the reader's interface); Unreadable on any failure."""
    try:
        with open(path, "rb") as f:
            if not lock(f, fcntl.LOCK_SH):
                raise Unreadable("the registry's lock was not given within the bounded wait")
            return parse(f.read())
    except OSError as e:
        raise Unreadable(f"cannot read the registry: {e.strerror}")


def transact(key, decide):
    """Under LOCK_EX: read the records (None when unreadable), call decide(records) -> (new records, result), append
    the new records, return the result. Raises when the registry cannot be opened or locked."""
    os.makedirs(LOG_DIR, exist_ok=True)
    with open(registry_path(key), "a+b") as f:
        if not lock(f, fcntl.LOCK_EX):
            raise Unreadable("the registry's lock was not given within the bounded wait")
        f.seek(0)
        try:
            recs = parse(f.read())
        except Unreadable:
            recs = None
        new, result = decide(recs)
        for r in new:
            f.write((json.dumps(r, ensure_ascii=False) + "\n").encode("utf-8"))
        f.flush()
        return result


def merged_view(records):
    """{agent_id: {"agent_type", "item", "form", "package", "runs"}}: launch and start records joined on the agent ID,
    the same for either arrival order (a field comes from one event type only; the type from a start when one exists)."""
    view = {}
    for r in records:
        aid = r.get("agent_id")
        if not isinstance(aid, str) or not aid or r.get("event") not in ("launch", "start"):
            continue
        v = view.setdefault(aid, {"agent_type": None, "item": None, "form": None, "package": None, "runs": 0,
                                  "_start_type": None})
        if r["event"] == "launch":
            v["item"] = v["item"] or r.get("item")
            v["form"] = v["form"] or r.get("form")
            v["agent_type"] = v["agent_type"] or r.get("agent_type")
        else:
            v["runs"] += 1
            v["package"] = r.get("package")
            v["_start_type"] = v["_start_type"] or r.get("agent_type")
    for v in view.values():
        v["agent_type"] = v.pop("_start_type") or v["agent_type"]
    return view


# ---------------------------------------------------------------- the nonce

def nonce_key(key, create):
    """The 32 bytes of the key file, created once with O_EXCL and mode 0600 when create is true."""
    path = os.path.join(LOG_DIR, f"{key}{guard().NONCE_KEY_SUFFIX}")
    if create:
        os.makedirs(LOG_DIR, exist_ok=True)
        try:
            fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        except FileExistsError:
            pass
        else:
            k = os.urandom(32)
            with os.fdopen(fd, "wb") as f:
                os.fchmod(f.fileno(), 0o600)
                f.write(k)
            return k
    for _ in range(40):              # another hook may have created it and not yet written it
        with open(path, "rb") as f:
            k = f.read()
        if len(k) == 32:
            return k
        time.sleep(0.05)
    raise Unreadable("the nonce key file does not hold 32 bytes")


def nonce(key_bytes, agent_id):
    return hmac.new(key_bytes, agent_id.encode("utf-8"), hashlib.sha256).hexdigest()[:16]


# ---------------------------------------------------------------- PostToolUse on Agent|Task: the launch record

def on_launch(data):
    if data.get("tool_name") not in ("Agent", "Task"):
        return None
    args = data.get("tool_input") if isinstance(data.get("tool_input"), dict) else {}
    resp = data.get("tool_response")
    aid = resp.get("agentId") if isinstance(resp, dict) else None
    aid = aid if isinstance(aid, str) and aid else None
    role = args.get("subagent_type") if isinstance(args.get("subagent_type"), str) else None
    prompt = args.get("prompt") if isinstance(args.get("prompt"), str) else None
    form = item = None
    if prompt is not None:
        g = guard()
        try:
            form = g.t5_form(prompt)
        except g.Bad:
            pass
        try:                         # the [T] pin: a writer-form producer, the reader form, a test-designer; else null
            if aid and (role in ("producer", "test-designer") or form == "reader"):
                item = g.t5_item(role or "", prompt)[1]
        except g.Bad:
            pass
    tid = data.get("tool_use_id")
    rec = record("launch", agent_id=aid, agent_type=role, item=item, form=form,
                 name=args.get("name") if isinstance(args.get("name"), str) else None,
                 tool_use_id=tid if isinstance(tid, str) else None,
                 prompt_sha256=sha256(prompt.encode("utf-8")) if prompt is not None else None)
    transact(guard().session_key(data), lambda recs: ([rec], None))
    return None


# ---------------------------------------------------------------- SubagentStart: the package, agent ID and nonce

def read_package(role):
    try:
        with open(os.path.join(ROOT, ".claude", "roles", f"{role}.md"), "rb") as f:
            return f.read()
    except OSError:
        return None


def on_start(data):
    aid, role = data.get("agent_id"), data.get("agent_type")
    if not isinstance(aid, str) or not aid or role not in guard().ROLE_TYPES:
        return None
    key = guard().session_key(data)
    pkg = read_package(role)
    ctx, outcome, package = None, "no_package", None
    if pkg is not None:
        package = f"{role}@{sha256(pkg)[:12]}"
        text = pkg.decode("utf-8")
        ctx = (packages().HEADER.format(role=role, sha12=sha256(pkg)[:12]) + "\n" + text
               + ("" if text.endswith("\n") else "\n")
               + f"Your agent ID: {aid}\nNonce: {nonce(nonce_key(key, create=True), aid)}")
        outcome = "emitted"
        if len(ctx.encode("utf-8")) > LIMIT:
            ctx, outcome = None, "oversize"

    def decide(recs):
        run = None if recs is None else 1 + sum(1 for r in recs if r.get("event") == "start"
                                                and r.get("agent_id") == aid)
        return ([] if recs is None else [record("start", agent_id=aid, agent_type=role, run=run, outcome=outcome,
                                                package=package)]), None
    try:
        transact(key, decide)
    except Exception:   # noqa: BLE001  delivery does not wait on the registry; liveness shows the missing record
        pass
    if ctx is None:
        return None
    return json.dumps({"hookSpecificOutput": {"hookEventName": "SubagentStart", "additionalContext": ctx}},
                      ensure_ascii=False)


# ---------------------------------------------------------------- SubagentStop: the hand-over's parts

def pick(seq, prefix):
    """The entry of a constant of tools/subagent_audit.py that starts with prefix (no heading is restated here)."""
    return next(x for x in seq if x.startswith(prefix))


def front(text):
    """The top-level `key: value` lines of a verdict's front matter (between its first two `---` lines)."""
    lines = text.split("\n")
    out = {}
    for ln in lines[1:]:
        if ln == "---":
            break
        if ":" in ln and not ln.startswith((" ", "\t")):
            k, v = ln.split(":", 1)
            out.setdefault(k, v.strip())
    return out


def line_value(text, heading):
    for ln in text.split("\n"):
        if ln.startswith(heading):
            return ln[len(heading):].strip()
    return None


def echoed(value, want):
    """True when value (a Nonce: line's or nonce: key's value) gives the nonce want as its first word; the word
    `Nonce:` (the start header's whole last line) and backticks may stand around it."""
    if not isinstance(value, str) or not want:
        return False
    v = value.strip().strip("`").strip()
    nl = pick(audit().HANDOVER_HEADINGS, "Nonce")
    if v.startswith(nl):
        v = v[len(nl):].strip()
    words = v.split()
    return bool(words) and words[0].strip("`") == want


def judge(role, text, run, want):
    """(missing parts, receipt, nonce checkable) of one report: what a role can supply, by its form."""
    sa = audit()
    resumed = run > 1
    missing = []
    if role == "checker" and text.startswith("---\n"):          # a binding verdict
        fm = front(text)
        need = [pick(sa.VERDICT_KEYS, "received")] if resumed else list(sa.VERDICT_KEYS)
        missing += [k for k in need if k not in fm]
        pkg, got, nonce_part = fm.get(pick(sa.VERDICT_KEYS, "package")), fm.get(pick(sa.VERDICT_KEYS, "nonce")), \
            pick(sa.VERDICT_KEYS, "nonce")
    else:
        lines = text.split("\n")
        need = [pick(sa.HANDOVER_HEADINGS, "Received")] if resumed else list(sa.HANDOVER_HEADINGS)
        missing += [h for h in need if not any(ln.startswith(h) for ln in lines)]
        pkg = line_value(text, pick(sa.HANDOVER_HEADINGS, "Package"))
        got = line_value(text, pick(sa.HANDOVER_HEADINGS, "Nonce"))
        nonce_part = pick(sa.HANDOVER_HEADINGS, "Nonce")
    if sa.block_problem(text) is not None:
        missing.insert(0, sa.DISC_HEAD)
    if want is not None and echoed(got, want):
        return missing, "delivered", True
    if resumed or pkg is None:
        return missing, None, True
    if pkg.lower().startswith("none"):
        return missing, "not_delivered", True
    if want is None:                    # a delivery is named but the key file cannot be read: not checkable
        return missing, None, False
    if nonce_part not in missing:
        missing.append(nonce_part)
    return missing, None, True


def reason(role, missing):
    parts = "; ".join(missing)
    head = "DevOS stop hook (W-C02-25): your final message lacks: "
    tail = (f". Your role package is .claude/roles/{role}.md and your role file's Output section lists every part. "
            "Give your whole final message again, complete, with the missing parts added, so that the filed copy is "
            "whole. This is asked once per run.")
    room = REASON_MAX - len(head) - len(tail)
    return head + (parts if len(parts) <= room else parts[:room - 3] + "...") + tail


def on_stop(data):
    aid, role, msg = data.get("agent_id"), data.get("agent_type"), data.get("last_assistant_message")
    if not isinstance(aid, str) or not aid:
        return None
    key = guard().session_key(data)
    digest = sha256(msg.encode("utf-8")) if isinstance(msg, str) else None
    active = data.get("stop_hook_active") is True

    def decide(recs):
        base = dict(agent_id=aid, agent_type=role if isinstance(role, str) else None, prompt_sha256=digest)
        if recs is None:
            return [record("stop", outcome="pass" if active else "could_not_check", **base)], None
        starts = [i for i, r in enumerate(recs) if r.get("event") == "start" and r.get("agent_id") == aid]
        if not starts or not isinstance(msg, str) or role not in guard().ROLE_TYPES:
            return [record("stop", outcome="pass" if active else "could_not_check", **base)], None
        run = len(starts)
        blocked = any(r.get("event") == "stop" and r.get("agent_id") == aid and r.get("outcome") == "block"
                      for r in recs[starts[-1] + 1:])
        try:
            want = nonce(nonce_key(key, create=False), aid)
        except Exception:   # noqa: BLE001  an unreadable key file: the nonce cannot be checked
            want = None
        try:
            missing, receipt, checkable = judge(role, msg, run, want)
            if missing:
                alt = transcript_text(data, msg)
                if alt is not None:
                    m2, r2, c2 = judge(role, alt, run, want)
                    if len(m2) < len(missing):
                        missing, checkable = m2, c2
                    receipt = receipt or r2
        except Exception:   # noqa: BLE001  e.g. tools/subagent_audit.py without its constants: not judged
            return [record("stop", run=run, outcome="pass" if active else "could_not_check", **base)], None
        if active:
            outcome = "pass"
        elif not checkable:
            outcome = "could_not_check"
        elif blocked:
            outcome = "allow_after_block"
        elif missing:
            outcome = "block"
        else:
            outcome = "complete"
        rec = record("stop", run=run, outcome=outcome, missing=missing, receipt=receipt, **base)
        out = json.dumps({"decision": "block", "reason": reason(role, missing)}) if outcome == "block" else None
        return [rec], out
    return transact(key, decide)


def transcript_text(data, msg):
    """The report as tools/subagent_audit.py's `last` reads it from agent_transcript_path, when it differs from msg."""
    path = data.get("agent_transcript_path")
    if not isinstance(path, str) or not os.path.isfile(path):
        return None
    try:
        sa = audit()
        t = sa.last_text(sa.jsonl(path)[1])
    except Exception:   # noqa: BLE001  an unreadable transcript leaves the message as the report
        return None
    return t if isinstance(t, str) and t != msg else None


# ---------------------------------------------------------------- SessionStart: the executor's package

def on_session_start(data):
    key = guard().session_key(data)
    pkg = read_package("executor")
    source = data.get("source") if isinstance(data.get("source"), str) else None
    package = f"executor@{sha256(pkg)[:12]}" if pkg is not None else None
    out = None
    if pkg is not None:
        out = packages().HEADER.format(role="executor", sha12=sha256(pkg)[:12]) + "\n" + pkg.decode("utf-8")
    try:
        transact(key, lambda recs: ([record("session_start", outcome=source, package=package)], None))
    except Exception:   # noqa: BLE001  delivery does not wait on the registry
        pass
    return out


HANDLERS = {"PostToolUse": on_launch, "SubagentStart": on_start, "SubagentStop": on_stop,
            "SessionStart": on_session_start}


def main():
    args = sys.argv[1:]
    event = args[0] if len(args) == 1 else ""      # the one argument: the hook event's name
    data = json.loads(sys.stdin.buffer.read())
    if event not in HANDLERS or not isinstance(data, dict):
        return
    out = HANDLERS[event](data)
    if out:
        sys.stdout.buffer.write(out.encode("utf-8"))
        sys.stdout.flush()


if __name__ == "__main__":
    try:
        main()
    except BaseException:   # noqa: BLE001  never hold an agent: every failure ends with exit 0 and no output
        pass
    os._exit(0)
