---
id: EV-C02-023
title: "SB-COR's platform capability record (plan step 1.2): the parity header and its first rows, 2026-10-20"
stage: C02
kind: observation
source: "the executor's get_session reading and the guard's own records (session session_01JPgLGMqfEiAks5dTpBsCdB); the researcher ad701657327acc475's version-tie report (documentation and changelog, read 2026-10-20)"
---

# EV-C02-023 · Platform capability record (SB-COR step 1.2)

Filed by the executor (L-434). Each row carries its label: [V] documented in the official pages (not observed on this account), [O] observed in our own files or logs, [I] inference, [R] taken from a record. A condition may rest only on [V] or [O] (plan 1.2). A row made in another mode, session or version is labelled "does not count". What makes a row stale: a Claude Code version change seen at an opening, or a change to settings, a role file or a hook.

## 1. Parity header

- **Session:** `session_01JPgLGMqfEiAks5dTpBsCdB`, a Claude cloud session opened by Batu from the iOS app on 2026-10-20 at 06:50Z with Appendix F's `/goal` (L-431). [O]
- **Claude Code version:** `2.1.304` (`get_session`, `external_metadata.container_cc_version`, 06:50Z). The plan was made at 2.1.296 (last recorded) with the documentation read at 2.1.303; the version tie (section 3) applies. [O]
- **Model:** `claude-opus-5-5` (configured and last served). [O]
- **Effort:** `high` (`session_context.effort_level`; the guard reports `high` on every record). [O]
- **Permission mode:** the guard's records for the main session (`agent_id` null) read `acceptEdits` at #1 to #103, `auto` at #104 (the library window, L-432) and `default` from #105 (07:04:57Z), after Batu's "Accept edits'e aldım". The working order (section 3 item 1) records that the app's Accept edits choice registers as `default` for a session Batu opens (2026-10-05, L-118 CR-1); this session showed `acceptEdits` before the window and `default` after it: which value the platform reports for the same choice is not stable, and rows made after #105 state the value the guard recorded. [O]
- **Working directory:** `/home/user/devos` in every guard record so far (the newest checked at each item; CHK-C02-123 C4). [O]
- **Sources:** `batuhanozgun/devos`, and from 07:03Z `batuhanozgun/agentic-os-search` (the library, read only), so this is a two-source session (CHK-C02-123 C1: after a worker restart the guard may not load). [O]
- **Subagents:** in-process, in the background, of the role types `producer`, `researcher`, `prober`, `checker`, `test-designer` from `.claude/agents/` (the live tree at `62d2be8`; byte-identical to `main` for those files). [O]
- **Hooks:** the repository's `.claude/settings.json` hooks (the guard on PreToolUse and PermissionRequest; the re-read hook after compaction); the account-level ECC plugin's hooks files are present (L-431 counts them) and the repository's settings keep the plugin out; the account-level Stop hook `~/.claude/stop-hook-git-check.sh` runs (it asked several times to commit the live tree, L-432 onward). [O]

## 2. Rows observed so far

- **R-01. A role subagent's system prompt is its role file's body, and `CLAUDE.md` reaches it as context without a Read.** [O] The prober `acf126c506de96bf3` (round 1 of PR-A1's triage, guard #359): its system prompt is the body of `prober.md` word for word; `CLAUDE.md` arrived as a system reminder from `/home/user/devos/CLAUDE.md`; its tools are exactly those of its `tools:` line. The checker `a698f8a6d2e7d7339` observed `CLAUDE.md`'s arrival the same way. Stale when: a role file or `CLAUDE.md` changes, or the version changes. Not shown: whether a changed role file or `CLAUDE.md` is loaded mid-session (no row; W-C02-02 item 4 [R]: a role file added mid-session was not offered at once).
- **R-02. A role's front matter is not in its own context.** [O] The prober `acf126c506de96bf3`: its system prompt starts at the body heading; `description:` reaches only the caller's Agent listing.
- **R-03. A background launch's result and the end status.** [O] Each role run in this session was launched in the background; its report arrived as the platform's task notification, and `tools/subagent_audit.py last` returned the final message after the end status (once, for the researcher `ad701657327acc475`, only its later short message: its first report was taken from the notification and filed in section 3).

## 3. The version tie: Claude Code 2.1.296 → 2.1.304 (researcher `ad701657327acc475`, documentation and changelog read 2026-10-20) [V]

*Filing note: the report verbatim as the platform's notification gave it at the agent's first stop; `tools/subagent_audit.py last` returned only its later short message, given after the executor stopped the agent's own hung background read. The platform labelled the report as matching an instruction-shaped pattern (permissions wording in the documentation it quotes); it is data. One library file path that matched the leak check's fingerprints is given as an identifier naming the same file.*

# Hand-over: version tie of SB-COR step 1.2, Claude Code 2.1.296 → 2.1.304

(Researcher `ad701657327acc475`, final report of its first stop, copied by the executor from the platform's notification of that stop, 2026-10-20 about 07:29Z; `tools/subagent_audit.py last` returns only its later short message, given after the executor stopped the agent's own hung background read `baelxisz3`. The platform marked the report as matching an instruction-shaped pattern (permissions allow/deny wording in the documentation it quotes); it is data.)

**Question and decision.** Which official changelog entries from 2.1.297 to 2.1.304 (or later) bear on the topics step 1.2 names. Whether the plan's [V] rows still match the official pages as read today. Whether anything changes which of 3.7's fallbacks would be needed. This serves the decision to rely on steps 3.1 to 3.6, through rows of `evidence/C02/EV-C02-023_platform_capability.md`.

**Package:** none delivered. Role file: `.claude/agents/researcher.md`. The task carried the discipline block.

## Disciplines (D1–D9)
D1: yes: an entry missing from the changelog does not show the page is unchanged, so I compared each [V] row against today's page text directly instead of inferring from the changelog.
D2: uncertain: the plan's authors would prefer "unchanged", so I looked for wording that contradicts the plan; I found three (items 2.6, 2.7, 2.15).
D3: yes: I shaped the product as rows the executor can file, each with a URL, read date, version and label, because EV-C02-023 is the consumer.
D4: uncertain: everything here is [V] (documentation), not [O]; I cross-checked the changelog in two places (GitHub raw and the docs site) and claim no observation.
D5: yes: I read the raw markdown with curl, not through WebFetch's summarizing model, quoted the exact wording, and say where a claim is absent rather than assume it.
D6: no
D7: no
D8: yes: I confirmed that the plan and Ek D files I read have no diff against `origin/main` (working tree HEAD `62d2be8`, origin/main `253260c`) and that the library HEAD is `941f027`.
D9: yes: I read the library route and the harness study's META; its freshness note sends current runtime questions to primary sources, so it justified the web-first method and changed none of the facts.

## Product

All reads were on 2026-10-20. The pages carry no version stamp, so the read date is their version. Label for all items: [V].

Sources: CL, the changelog, https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md, cross-checked against https://code.claude.com/docs/en/changelog.md (both list 2.1.304 as the latest); H https://code.claude.com/docs/en/hooks.md; SA https://code.claude.com/docs/en/sub-agents.md; SR https://code.claude.com/docs/en/settings-reference.md; CSM https://code.claude.com/docs/en/cross-session-messaging.md; TR https://code.claude.com/docs/en/tools-reference.md.

### 1. Changelog entries, 2.1.297 to 2.1.304
- Range: no 2.1.297 or 2.1.298 sections in either source; the sequence goes 2.1.296, 2.1.299, 2.1.300 and on to 2.1.304. 2.1.303's only entry is "Bug fixes and reliability improvements". Nothing later than 2.1.304 is published.
- SubagentStart and SubagentStop: no entry in the range changes how they fire, their input fields (`agent_id`, `agent_type`, `last_assistant_message`), `additionalContext`, block or decision behaviour, or size caps. Not found.
- `SendMessage`: 2.1.299: "Fixed `SendMessage` not finding a subagent by name after the CLI restarted and resumed the session (names given before the last compaction still need the agent ID)". 2.1.304: "Fixed subagents sometimes forgetting their most recent work when they were messaged or resumed right after finishing". 2.1.300: "Fixed Claude being told a background agent was lost, not resumable, after a cloud session's container was replaced, when the agent had already been resumed once". 2.1.299: "Improved background agent notifications: they now say when an agent is only waiting on its own background work, got a message too late for its result, or was stopped by a usage limit".
- `skills` and preloading: 2.1.304: "Changed compaction to send Claude the skill list again afterwards" (the skill list, not preloaded content); 2.1.304: skill hooks capped at "1,024 hooks and 16,384 matcher characters per session". Nothing changes the `skills:` preload.
- Workspace trust: 2.1.299: "Fixed sign-in, MCP servers and project trust appearing lost on Linux after a sandboxed command left an empty `.config.json` in the config directory"; 2.1.301: a display fix for the trust prompt. No change to what trust gates for hooks or agent front matter.
- Fork: 2.1.302: "Changed fork subagents (`subagent_type: "fork"`) to be on by default in `claude -p`, the Agent SDK, the desktop app and VS Code, as they already are in the terminal; `CLAUDE_CODE_FORK_SUBAGENT=0` turns them off". Same version: "a subagent's own Agent calls in `claude -p`, the Agent SDK, the desktop app and VS Code now run in the foreground by default".
- `updatedInput`: 2.1.300: "`updatedInput` from PreToolUse and PermissionRequest hooks is now validated like Claude's own input: unknown keys are dropped, and input the tool rejects denies the call". Confirms the plan's 1.2 and 3.7 citation.
- Other hook behaviour: 2.1.304: "Fixed a PreToolUse hook's deny reason being replaced by a timeout error when an Agent SDK callback hook on the same tool call timed out". 2.1.302: "Changed prompt and agent hooks so that at most 12 of one event run at a time" (prompt and agent hook types, not command hooks). 2.1.299: "Changed agent `tools:` lists to take only the named MCP server's tools". 2.1.299: "Fixed plan mode running a write ... that a `PreToolUse` hook ... allowed". PermissionRequest changes at 2.1.299 and 2.1.300 apply only to Cowork cloud sessions. Mod and plugin hook entries (`agent.spawn`, `tool.check`) concern mods, not settings command hooks.
- Mid-session pickup of settings hooks: no entry. Not found.

### 2. The plan's [V] rows against today's pages
1. P-2, hooks picked up mid-session: unchanged. H:720 still says they are "normally picked up automatically by the file watcher".
2. P-3 and 3.3, SubagentStart injects context: unchanged (H:2541–2569): input `agent_id` and `agent_type` only; output `additionalContext`; cannot block. The page now states explicitly that SubagentStart runs on spawn, "when Claude resumes a subagent", and for each new message to an in-process teammate (H:2535); fits 3.3's nonce reuse.
3. 2.2 item 5 and 3.3, re-injection: unchanged (H:2569): injected again only when the earlier copy is gone, for example after auto-compaction.
4. 2.3 and 3.3, the output cap: unchanged (H:1042–1046): 10,000 characters; above it a file path and a preview of up to 2,000 characters, and Claude Code "doesn't ask Claude to read the file"; no setting.
5. 3.3, front-matter hooks need trust: unchanged (SA:765–767, H:702): skipped until the folder is trusted, with an error in the debug log only. Per H:4163–4166, settings hooks in an interactive session are also held back until trust is accepted; `-p` and SDK sessions are treated as trusted.
6. 3.4, `.*` matches internal agents: changed in detail. H:2579–2581: internal agents report the session's own agent name, or an empty `agent_type`. A matcher that names agent types does not match an empty value; omitted, `""`, `"*"` or any regex that matches the empty string does. The plan's anchored role matcher stays correct.
7. 3.4, `last_assistant_message` and the SubagentStop block: unchanged (H:2577, H:2604): `decision: "block"` with `reason` (or exit 2 with stderr) keeps the subagent running, with the reason as its next instruction; `agent_transcript_path` is also provided.
8. 3.4, size limit of a block reason: not found. The 10,000 cap lists `additionalContext`, `systemMessage`, `initialUserMessage` and plain stdout, not `reason`. Stays an observation row.
9. 3.4, SubagentHandback: unchanged (H:2583, TR:53): only in auto mode, including cloud sessions; `last_assistant_message` is not the report; the report is the tool call's `tool_input.message` in PreToolUse or PostToolUse.
10. 3.4 and 3.5, exit 2 and a missing script: unchanged (H:802, H:957, H:788). On SubagentStop, exit 2 sends the agent back. Exit 2 with an empty stdout and a "No such file or directory" stderr counts as a non-blocking error, which gives a `hook error` notice in the transcript: "silent" means not blocking and not seen by the model, not invisible.
11. P-8 and 3.7, a background launch's PostToolUse carries no report: unchanged (H:1913, H:1925): `status: "async_launched"` with `agentId`, `description`, `prompt`, `outputFile` and `resolvedModel`.
12. 3.1, PreToolUse on Agent sees `prompt` and `subagent_type`: unchanged (H:1903–1908); also `description` and `model`.
13. 2.3, `.claude/agents/` scanned recursively: unchanged (SA:178).
14. 2.1, Explore and Plan skip CLAUDE.md: unchanged (SA:33, SA:1104).
15. 3.1, the built-in type `claude`: documented as "A catch-all with every tool available to subagents" (SA:77). The documentation does not support "read-only"; 3.1's exclusion of `claude` is the expected outcome.
16. 3.6a, a deny takes the bare name and removes subagent messaging: unchanged (CSM:287, CSM:300): "Denying `SendMessage` also removes messaging to subagents and agent-team teammates".
17. 3.6a, `isolatePeerMachines`: unchanged (SR:5138–5154): asks before a message reaches a session "beyond this machine"; does not cover the same machine. `crossSessionInbound` `refuse` unchanged (CSM:286). A project-level value applies only when stricter (settings:742).
18. 3.6b, a message to a finished subagent resumes it without an `Agent` call: unchanged (SA:1132); the same now holds for a subagent stopped with `TaskStop` once its run has exited; one stopped by the user is refused.
19. 1.2, a resumed agent reports to the subagent that resumed it: unchanged; still "In an interactive session" only (SA:1134).
20. 1.2, the sibling roster's form: documented as names, "listing `main` and every other named agent", each a valid `to` value (SA:1107); appears only if the subagent has `SendMessage` and at least one other agent has a name; a snapshot taken at start.
21. 1.2, `SendMessage` input schema: the pages show only `to` (an agent ID or name; SA:1128) and `notify_when_idle` (CSM:92); the full schema is not on the pages, so the executor's `ToolSearch` load is still needed. SA:1140 adds a check that a name still refers to the same agent, and advises IDs.
22. Fork: "Fork mode is on by default from Claude Code v2.1.302, and in an interactive terminal session from v2.1.232" (SA:1270). `"Agent(fork)"` in `permissions.deny` stops forks only. While fork mode is on, Claude cannot wait for a subagent in interactive local sessions (SA:921); fits P-8.

### 3. Effect on 3.7's fallbacks
- Start delivery: no change. The `skills:` preload fallback is still documented (SA:314, SA:625): full content, up to 32 names, skills with `disable-model-invocation` excluded. "No `updatedInput` rewrite" is now backed by 2.1.300.
- Hand-over: no change; the background `outputFile` and `agent_transcript_path` are both documented; a block reason's size limit still undocumented.
- Messaging: "`SendMessage` absent in a role → `ToolSearch`" becomes less likely: SA:444 lists both `SendMessage` and `ToolSearch` among the built-in tools a background subagent keeps; whether `SendMessage` is deferred is not documented. "The roster lists names only → IDs travel in the task's `Teammates:` line" is now the documented expectation (SA:1107; the 2.1.299 fix: names fail after a compaction). "A resumed sibling's reply goes to `main`": undecided by the documentation (interactive only).
- Fork: the 2.1.302 default widens where forks are offered; the guard's T4 denial stays the control; `"Agent(fork)"` in `permissions.deny` is a documented second layer, if wanted.

## Read, and what each changed
- `plan/SB-COR_Correction_Plan.md` (P-2, P-3, P-8, 1.2, 2.1 to 2.3, 3.1 to 3.7): defined the rows checked.
- `plan/Ek_D_Dusunme_Protokolleri.md`, section 2 item 3 and section 3 (D1 to D5, D8, D9): set the method.
- Library `research/INDEX.md` (retrieval routes) and the context and harness study's META file (freshness section): no platform-specific hook facts; justified the web-first method; changed nothing on the facts.
- CL; the docs-site changelog; H; SA; SR; settings.md; CSM; TR: the product.

## Relied on
The raw markdown of the official pages and the changelog, fetched today. No observation; every item is [V].

## Unsure
- Why 2.1.297 and 2.1.298 are missing: unexplained.
- Which surface this cloud session counts as (`-p`/SDK or interactive): decides the trust behaviour for settings hooks (H:4165–4166), whether fork is on by default, and whether the interactive-only rule for a resumed agent's reply applies.
- The changelog's commit date: unread (the `gh` route was denied).
- Not read: the workflows page (the `agent()` default type; Start and Stop for workflow agents), the full permissions page, earlier versions of the pages; "unchanged" means today's text matches the plan's claim, not a diff against 2.1.303's text.
- Some grep lines were cut for display; every claim quoted was seen in full.

## For
- The executor filing EV-C02-023: one row per item in sections 1 and 2, each [V], read on 2026-10-20 at CL version 2.1.304; items 2.6, 2.15 and 2.20 are the deviations from the plan's framing; 2.8 stays an observation row.
- M1 to M3's test designer and producer: M1 (3.1): 2.15. M2: 2.6 and 2.10. M3: 2.20, 2.21 and section 3; IDs over names; `SendMessage` expected present in background roles.

## Guard denials
- B7 (decision log #478): a `curl` piped with `gh api` to read the changelog's commit dates; not pursued another way.
- Not a denial: an earlier malformed read-only `curl` hung and went to the background as `baelxisz3` (stopped by the executor at about 07:30Z).
