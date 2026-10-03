# P-W12-2: `CLAUDE.md` imports, subagent inheritance and the compaction hook (pre-registration)

**Item:** W-C00-12, design piece 3 (`plan/builder/w-c00-12/04_roles.md` §4 and §6.2). **Written:** before the probe session exists (time in the commit). **Producer:** run `session_0143r88Vc9e5RbsQmqjYWgwa`.

**Why.** Piece 3 would carry the common floor by reference through a `CLAUDE.md` `@path` import, and would re-ground sessions after compaction with a `SessionStart` hook on the `compact` source. Both rest on untested platform behaviour in builder-created cloud sessions.

**Set-up.** A probe branch `claude/probe-w12-imports` cut from `main` adds, and nothing else:
- `plan/builder/w-c00-12/probe_import.md`, holding the phrase `PROBE-IMPORT-MARKER-3J`;
- one line appended to `CLAUDE.md`: `@plan/builder/w-c00-12/probe_import.md`;
- in `.claude/settings.json`, a `SessionStart` hook with matcher `compact` that prints `PROBE-COMPACT-MARKER-8V` and writes the UTC time to `/tmp/devos_probe_compact`;
- `.claude/agents/devos-probe-agent2.md`, whose body tells it to answer from its context only, without tools.

The `PreToolUse` allow-list hook script is unchanged. The branch is never merged. The probe session gets a first message with questions 1–3; after its first turn the builder sends it `/compact` with `send_message`, then a second message with question 4.

**Questions:**
1. Before any tool call: does your context contain `PROBE-IMPORT-MARKER-3J`? Quote the surrounding line.
2. Call the Agent tool with `subagent_type` `devos-probe-agent2` and the prompt: "Without using any tool, does your context contain a phrase starting with PROBE-IMPORT-MARKER? If yes, quote it; if no, say no. Also: does your context contain the heading 'DevOS: session entry point'?" Quote the reply.
3. Call the Agent tool with `subagent_type` `general-purpose` and the same prompt. Quote the reply.
4. (after `/compact`) Run `cat /tmp/devos_probe_compact` and say whether your context contains `PROBE-COMPACT-MARKER-8V`.

**Acceptance, fixed now** (read from the transcript with `list_events`, not from the session's summary):

| ID | Claim | PASS only if | FAIL if |
|---|---|---|---|
| P-W12-2a | `@path` imports in `CLAUDE.md` resolve in a builder-created cloud session | answer 1 quotes the marker before any tool call that could have read the file | no marker, or only after a read |
| P-W12-2b | A custom subagent receives `CLAUDE.md` with its imports | the `devos-probe-agent2` reply quotes the marker and confirms the heading, with no tool call inside the subagent | the subagent reports neither, or used a tool |
| P-W12-2c | A built-in subagent receives `CLAUDE.md` with its imports | same for `general-purpose` | same |
| P-W12-2d | A `SessionStart` hook with the `compact` source fires after `/compact` sent as a message | a `SessionStart` hook event with the compact source appears in the events after the `/compact` message, and `/tmp/devos_probe_compact` holds a time after that message | no such event (if `/compact` is not processed as a command at all, d is recorded as **untestable by this method**, not as FAIL) |

Observed once at most; a FAIL changes the design (piece 3 §4 falls back to an instructed read tested by T-R5; §6.2 stays instructed).

## Result

(Filled after the probe, from the transcript.)
