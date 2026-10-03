# P-W12-1: what loads in a builder-created cloud session (pre-registration)

**Item:** W-C00-12 (RUN_BRIEF §6; G-017; OI-011 items 15 and 16). **Written:** 2026-10-03T17:25Z, before the probe session exists. **Producer:** run `session_0143r88Vc9e5RbsQmqjYWgwa`.

**Why.** Three candidate mechanisms of the redesign rest on platform behaviour nobody has checked here:
- a `SessionStart` hook as the mechanical root of the boot chain (`BATU_STORED_IS_NOT_USED_TR.md`: the path to knowledge must start from something in context without a decision by the actor);
- repository skills (`.claude/skills/`) as the home of on-demand methods ("helpers" on the mechanism map);
- repository agent definitions (`.claude/agents/`) as the home of role environments (plan §7.2 already assumes this, marked "awaiting verification, C01").

**Set-up.** A probe branch `claude/probe-w12-loading` cut from `main` adds, and nothing else:
- in `.claude/settings.json`, a `SessionStart` hook that prints a marker line `PROBE-SS-MARKER-W12 …` and writes the UTC time to `/tmp/devos_probe_sessionstart`;
- `.claude/skills/devos-probe-skill/SKILL.md`, whose body holds the phrase `PROBE-SKILL-BODY-4K`;
- `.claude/agents/devos-probe-agent.md`, with no isolation or tool fields, whose body holds the phrase `PROBE-AGENT-BODY-9Z`.

The `PreToolUse` allow-list hook and its script are unchanged, so the barrier applies in the probe. The branch is never merged. A probe session is created on it with the configured model and a first message that asks the questions below and forbids writes.

**Questions to the probe session** (it answers in its conversation; the builder reads the transcript with `list_events`, per the L-030 rule, and does not rely on the session's summary):
1. Before any tool call: does your context contain a line starting `PROBE-SS-MARKER-W12`? Quote it.
2. Run `cat /tmp/devos_probe_sessionstart`.
3. From your system listing alone, without reading files: is a skill `devos-probe-skill` listed? Is a skill `devos-absent-skill` listed? Is an agent type `devos-probe-agent` listed?
4. Invoke the skill `devos-probe-skill` with the Skill tool and quote what it returns.
5. Call the Agent tool with `subagent_type` `devos-probe-agent` and the prompt "Reply with your marker phrase"; quote the reply.

**Acceptance, fixed now:**

| ID | Claim | PASS only if | FAIL if |
|---|---|---|---|
| P-W12-1a | `SessionStart` hooks from the checkout **run** in a builder-created cloud session | `/tmp/devos_probe_sessionstart` exists with a time after the session's `created_at` (tool output in the transcript) | the file is missing |
| P-W12-1b | Their output **reaches the model's context** | answer 1 quotes the marker before any tool call that could have revealed it | no marker, or the quote appears only after a tool call that read it |
| P-W12-1c | Repository skills load | `devos-probe-skill` is listed (answer 3) **and** the Skill call returns `PROBE-SKILL-BODY-4K` (tool result in the transcript) | either part missing |
| P-W12-1d | Repository agent definitions load | `devos-probe-agent` is listed **and** the Agent call with that type returns `PROBE-AGENT-BODY-9Z` | either part missing |
| Control | The session does not confabulate listings | `devos-absent-skill` is reported as not listed | it is reported as listed (then answers 3 count only where a tool result confirms them) |

A result counts as observed once, in this environment and Claude Code version, not as a property. A FAIL is a finding for the design, not a defect to route around.

## Result

Probe session `session_01VspZNar2hVyLPEos9XSHeD`, created 2026-10-03T17:26:22.68Z on `claude/probe-w12-loading` (`2adb623`), Claude Code 2.1.288, model `claude-opus-5-5`. Read by the builder from the session's events with `list_events` (fetched before 17:28Z; result written at 17:28Z) (all 37 events of its one turn), not from its summary.

| ID | Verdict | Transcript evidence |
|---|---|---|
| P-W12-1a | **PASS** | System event `hook_started` `SessionStart:startup` at 17:26:28.76Z, then `hook_response` exit 0 with stdout `PROBE-SS-MARKER-W12 SessionStart hook ran at 2026-10-03T17:26:28Z`. The Bash tool result of `cat /tmp/devos_probe_sessionstart` is `2026-10-03T17:26:28Z`, six seconds after `created_at`. |
| P-W12-1b | **PASS** | The session's first text (17:26:40.21Z) quotes the line `SessionStart:startup hook success: PROBE-SS-MARKER-W12 SessionStart hook ran at 2026-10-03T17:26:28Z` before its first tool call (17:26:40.77Z). The harness prefixes the hook output with `SessionStart:startup hook success: `, so no line *starts* with the marker; the session said so itself. |
| P-W12-1c | **PASS** | The session listed `devos-probe-skill` as available. The Skill call's tool result is `Launching skill: devos-probe-skill`, and the harness then injected the skill body as a synthetic message beginning `Base directory for this skill: /home/user/devos/.claude/skills/devos-probe-skill` and containing `PROBE-SKILL-BODY-4K`. That is how the Skill tool returns a body; the phrase reached the session through the call. |
| P-W12-1d | **PASS** | The session's init event lists the agent types `claude, claude-code-guide, devos-probe-agent, Explore, general-purpose, Plan, statusline-setup`. The Agent call with `subagent_type` `devos-probe-agent` started a `local_agent` task, which handed back `PROBE-AGENT-BODY-9Z`. |
| Control | **PASS** | `devos-absent-skill` was reported as not listed. |

**Additional observation (not pre-registered, so recorded as an observation only):** the allow-list `PreToolUse` hook fired for the `SubagentHandback` call made **inside** the in-process subagent (`hook_name` `PreToolUse:SubagentHandback`, `parent_tool_use_id` set). Operating model §9 listed "whether hooks run for tool calls made inside in-process subagents" as documented but not observed (R-C00-BOM-5 R-4); it is now observed once.

**What this does not show.** One session, one version. It does not show that a role defined in `.claude/agents/` behaves as its definition intends, that `SessionStart` output is weighed by the model, or that skills are invoked unprompted when relevant (P-W12-1 named them explicitly). Those are behavioural questions for the redesign's own tests.

**Consequence for W-C00-12.** The three platform mechanisms the redesign may rest on exist in builder-created cloud sessions: a mechanical boot root (`SessionStart`), on-demand methods (`.claude/skills/`) and role environments (`.claude/agents/`). G-017's untested premise and plan C01 row 4's first condition are observed once. Agent definitions remain a high-impact change (operating model §9: definitions are not inspected by the hook).
