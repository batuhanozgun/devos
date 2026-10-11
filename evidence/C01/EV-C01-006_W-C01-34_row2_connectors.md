# EV-C01-006 · W-C01-34: row 2, the connector barrier (the routine's first run; the repository's permission layer)

**What this is.** The record W-C01-34 asks for, under PC-21 item 3: the routine's session records the tools it has, and with its connectors removed no connector tool may appear (the session observing itself, D-017 item 2(a)); the repository's permission layer is shown by reading its configuration; the fail path is unchanged. The routine's layer and the guard's layer are kept apart below (plan C01 row 2).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | For the run: `main` `5d0cc58a9bff5a88087bee3c509a851628e642e0`, the commit R1a read (its stamp). For the configuration read here: `main` `48ad43d8221eccfd7f2c0fad00d5dc7191ddf020`. The two configuration files are the same blobs at both commits: `.claude/settings.json` `ce7d09dd9f55d427969398d01d30064f638971cb` (last changed in `5223552`, 2026-10-05) and `.claude/hooks/tool_allowlist.py` `35c23f7421783ddfe892b01bc0a3d9c5720f74f9` (last changed in `1764100`, 2026-10-06) |
| Deployment configuration | The routine `devos-c01-rutin` in the cloud environment `devos-kurulum`, created by Batu with every connector removed (his step 22, `ROUTINE_DESIGN.md` section "Batu's step"; his report, issue #6 comment `6105974865`); its run session `session_01P5d7WNny3Jpuabt2A2V3Bm`, with the repository's hooks configured as at `5d0cc58` and the guard live (EV-C01-005) |
| Criterion version | W-C01-34's acceptance block as merged with the C01 re-plan (W-C01-31, L-182), unchanged since |
| Input | `CONTROL.md` version 1, opening record part A item 5 (the tools, MCP servers by rule 1.4) and the opening gate of section 3.2 ("no `other-server-*`") |
| Actual observation | R1a's opening record, part A item 5 and its gates (below) |
| Raw evidence ID | Branch `claude/probe-c01-r1a-20261011T0808Z`, commit `a15313c` (opening), head `67fcd98a8ec84f3a2269f4227cca6cdbbbc9b251`; copy `evidence/C01/routine/runs/R1a-20261011T0808Z/R1a/OPENING.md` |
| Independence level | Verified by self-observation (D-017 item 2(a)): the run session's record of itself (an observation of its own tool list), dated 2026-10-11; the configuration read by the executor; judged by a fresh-context checker (declared, Ek A 5.3) |

## Point 1 (✘). A run of the routine records the tools its session has, and no connector tool appears among them

Met by R1a, the routine's first run (2026-10-11, started 08:08:23Z), opening record part A item 5, taken at 08:10:30Z to 08:11:31Z:
- Built-in tools loaded at start: 18, by name. Built-in tools offered as deferred: 30, by name.
- MCP servers: `claude-code-remote`, the platform's own session tools, 3 tools; `github`, the built-in GitHub tools, 54 tools ("connecting at start, then offered as deferred"). "No other server."
- The run's gate "no `other-server-*`" passed ("All three pass").

What would have been a connector tool: an account connector (mail, calendar, files and others) reaches a session as an MCP server of its own, beside these two; in a session that keeps the account's connectors they appear that way (T-H3, EV-C00-005: connectors seen under prefixes of their own in a builder-created session; this working session shows the same). None appears in R1a's list. Two built-in tools concern connectors, `ListConnectors` and `SuggestConnectors` (both deferred): they list or suggest connectors and are not a connector's own tools; the guard denies both in a session that has this repository alone, the only kind in which the repository's hooks load (rule T1, below; `ROUTINE_DESIGN.md` F10; plan PC-21 item 5). The account-level plugin `other-plugin-1` brought 24 skills and no MCP server of its own (OPENING part B item 2; part A item 5, "No other server").

Limits: one run's record of its own tool list, at its start, written by the session itself (a hint as to completeness, D-017 item 2(a)). Every later working run records its tool list again and ends at its opening gate, its step left open, if a server that may be a connector appears (`CONTROL.md` 3.2, "Gates"; `ROUTINE_DESIGN.md` section 5 item 5); such a record reopens this row under its fail path (point 3).

## Point 2 (✔). The repository's permission configuration that keeps connector tools out, read and recorded with its commit

At `main` `48ad43d8221eccfd7f2c0fad00d5dc7191ddf020` (and unchanged since `5d0cc58`, which R1a read):
- `.claude/settings.json` holds no permission rule that names a connector: its `permissions` block sets only `"defaultMode": "acceptEdits"`. The layer is its `PreToolUse` hook, matcher `.*`, which runs `python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/tool_allowlist.py"` for every tool call and turns any non-zero exit into a denial (`exit 2`), with a 600-second timeout; and its `PermissionRequest` hook, matcher `.*`, which runs the same file (lines 12 to 35).
- `.claude/hooks/tool_allowlist.py`, rule M1 ("MCP server allow list", lines 196 to 199): a tool whose name starts with `mcp__` is denied unless it starts with one of four prefixes (lines 86 to 91, 1961 to 1963): the GitHub tools, the platform's session tools, and the read-only database connector under its name and, by inference only, under an opaque ID (the guard's own comment at line 90, "inferred: T-H3"; `evidence/C00/probes/T-H3.md`, "by inference"; R-C00-BOM-2 M8). Every other MCP server is denied, account connectors included, "some under opaque IDs" (the rule's own text). Non-MCP tools are an allow list, rule T1 (lines 92 to 103): `ListConnectors`, `SuggestConnectors` and the plugin suggestion tools are not on it, so they are denied.
- One account connector is allowed by M1: the read-only database connector (under its opaque ID by inference only, above). It is read-only by its database role, not by the hook (working order section 10, "Not protected"). It did not appear in the routine's session, where every connector was removed.

The two layers, apart: the routine's layer (its connectors removed at creation) is what R1a observed: no connector server was present at all, so no connector tool could be called and the guard had none to deny. The guard's layer is shown by its configuration above (PC-21 item 3); it was live in the routine's session (its decision log existed, hash chain intact; EV-C01-005).

## Point 3. The fail path

No connector tool appeared, so row 2's fail path ("Account-level options to Batu (with their effect on his other chats)") does not apply. It applies if a later run's tool list shows an `other-server-*` or a named server that is a connector (point 1, limits).

## Facts taken from the documentation (PC-21 item 9)

- A routine's creation form sets its prompt, repositories, environment, connectors and triggers; all connected connectors are included by default and can be removed; Claude can use every tool of an included connector, writes included, without asking. Guaranteed by platform (documented in https://code.claude.com/docs/en/routines, "Create from the web", read 2026-10-10; `ROUTINE_DESIGN.md` F1); not independently tested.
- Anything a routine does through the connected GitHub identity or connectors appears as the account owner. Guaranteed by platform (documented in https://code.claude.com/docs/en/routines, read 2026-10-10; EV-C01-003 section 4); not independently tested.
- Qualifiers: per environment only the variables, secrets and network setting are separate; the GitHub identity and the account's connectors are shared across the account; an environment's variables are readable inside its own sessions; the channel to the model's own service stays open whatever the network setting; routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).

## Result

Row 2 succeeds on R1a's record: in a routine with its connectors removed, and with the repository's permission rules, no connector tool appeared, so none could be called; the repository's layer, read at `48ad43d`, denies every MCP server but the four allowed prefixes. No plan change follows from row 2.
