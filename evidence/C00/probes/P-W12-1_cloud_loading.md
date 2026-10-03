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

(Filled after the probe, from the transcript.)
