#!/usr/bin/env python3
"""PostToolUse hook: when this session creates a session or a routine, append the
returned ID to owned_ids.txt automatically (R-C00-BOM-4 M2). The model never
has to add IDs by hand, so a hand edit of owned_ids.txt is never routine and
stays a high-impact change. Never blocks; on any doubt it records nothing.

The response is parsed, not searched (R-C00-BOM-5 N-M1). The new ID is taken
only from its observed place (L-022, L-024): "ccr.id" for create_session (seen on get_session and
create_session), "trigger.id" for create_trigger, or a top-level "id" when that
object is absent; for send_later only the top-level "trigger_id" (M-R11, P-W12-5). If the parsed payloads name no ID or more than one, nothing
is recorded.
"""
import json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
WATCH = {"mcp__claude-code-remote__create_session": ("ccr", "session_"),
         "mcp__claude-code-remote__create_trigger": ("trigger", "trig_"),
         # M-R11: send_later answers one flat object whose only identifier is the top-level trigger_id
         # (observed once, evidence/C00/probes/P-W12-5_send_later_sample.md)
         "mcp__claude-code-remote__send_later": ("trigger_id", "trig_")}


def norm(i):
    i = str(i or "")
    return "session_" + i[4:] if i.startswith("cse_") else i


def payloads(resp):
    """Observed format (L-022): a list of {"type": "text", "text": "<JSON string>"}.
    Text items that are not JSON objects are skipped."""
    if isinstance(resp, str):
        try:
            resp = json.loads(resp)
        except ValueError:
            return []
    if isinstance(resp, dict) and isinstance(resp.get("content"), list):
        resp = resp["content"]          # a wrapped content list (R-C00-BOM-6 n3)
    if isinstance(resp, dict):
        return [resp]
    if isinstance(resp, list):
        texts = [i.get("text") for i in resp if isinstance(i, dict) and isinstance(i.get("text"), str)]
    else:
        return []
    out = []
    for t in texts:
        try:
            p = json.loads(t)
        except ValueError:
            continue
        if isinstance(p, dict):
            out.append(p)
    return out


def new_id(tool, resp):
    key, prefix = WATCH[tool]
    found = set()
    for p in payloads(resp):
        if key == "trigger_id":           # send_later: the named top-level field and nothing else
            i = norm(p.get("trigger_id"))
        else:
            obj = p.get(key) if isinstance(p.get(key), dict) else p
            i = norm(obj.get("id"))
        if re.fullmatch(re.escape(prefix) + r"[A-Za-z0-9]+", i):
            found.add(i)
    return found.pop() if len(found) == 1 else None


def main():
    try:
        d = json.load(sys.stdin)
        if d.get("tool_name") not in WATCH:
            return 0
        i = new_id(d["tool_name"], d.get("tool_response"))
        if not i:
            return 0
        path = os.path.join(HERE, "owned_ids.txt")
        with open(path) as f:
            ids = {l.strip() for l in f}
        if i not in ids:
            with open(path, "a") as f:
                f.write(i + "\n")
    except Exception:
        pass
    return 0


if __name__ == "__main__":
    sys.exit(main())
