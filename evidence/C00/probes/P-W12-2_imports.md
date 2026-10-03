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

Probe session `session_01TMLedyxirGnCLa5Em15nND`, created 2026-10-03T17:41:13.54Z on `claude/probe-w12-imports` (`937f26f`), Claude Code 2.1.288, model `claude-opus-5-5`; archived after reading. Read by the builder from the session's events with `list_events` (result written at 17:42Z), parsed with a script that prints every text, tool call, tool result and hook event, including the subagents' own events (`parent_tool_use_id` set).

| ID | Verdict | Transcript evidence |
|---|---|---|
| P-W12-2a | **PASS** | The session's first text (17:41:27.81Z), before any tool call, quotes `PROBE-IMPORT-MARKER-3J: this line is visible only if the CLAUDE.md import resolved.` and names the imported file. |
| P-W12-2b | **PASS** | The `devos-probe-agent2` task's only tool call was its `SubagentHandback`; its hand-back quotes the marker and confirms the heading "DevOS: session entry point (installation period)". |
| P-W12-2c | **PASS** | The `general-purpose` task, likewise with only its hand-back call, quotes the marker and confirms the heading. (The two hand-backs arrived 0.1 s apart; which agent ID belongs to which type was taken from the task events, and both answers are positive, so the verdicts do not depend on the mapping.) |
| P-W12-2d | **UNTESTABLE by this method** | `/compact` sent with `send_message` arrived as a queued cross-session notification, wrapped as data; the session read it with `ReadNotifications`, said `/compact` only works when typed into the session, and took no action. No compaction occurred, so the `compact` hook could not fire. Not a FAIL, as pre-registered. |

**Consequence for W-C00-12.** The common floor can be carried by reference mechanically: one `@path` import in `CLAUDE.md` reaches the session, custom subagents and built-in subagents (observed once). Re-grounding after compaction (piece 3 §6.2) stays an instructed arrow until a compaction can be observed; its test is T-R6, and a natural compaction in a long run is the next chance to observe the `compact` hook.

**Additional observation:** a `send_message` from the builder to its own child arrives as a queued notification, like routine and `send_later` messages (T-A2). The child treated it as data, not an instruction, as the harness frame tells it to.

**Second additional observation (FP 7 evidence):** after archiving, the platform's own `post_turn_summary` for this probe read "awaiting user's three questions for P-W12-2 probe" with `needs_action` "provide the three numbered questions to answer", while the transcript shows all three answered at 17:41:41Z. A session summary produced by the platform can be stale or wrong; claims about another session are taken from its transcript (L-030 rule), never from its summary.
