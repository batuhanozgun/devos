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

## 4. Rows of session `session_01JDJ8fJQmrKpXfiRh1yEoxv` (CHK-C02-152 C1; drafted by prober `a8f9de3ef606333a7`, 2026-10-20)

Parity for every row below, unless the row says otherwise:
- Session `session_01JDJ8fJQmrKpXfiRh1yEoxv`, a Claude cloud session opened 2026-10-20T09:13Z (L-439).
- Claude Code 2.1.304 (the executor's `get_session`, 18:35Z; `buildVersion` 2.1.304 in every prefix record read). Model `claude-opus-5-5`.
- Mode `default` and effort `high`, as the guard records them. cwd `/home/user/devos`. Two sources.
- The repository's settings hooks have been in force from W-C02-25's sync (`13d310a`, live tree 15:35:45Z).

R-01 to R-03 were made in session `session_01JPgLGMqfEiAks5dTpBsCdB` and count here only where a row below re-observes them:
- R-01's first half (system prompt = role body) is re-observed by R-25's constant offset.
- R-03's "`last` returns a later short message" recurred here (L-455).
- Sources under `/tmp/devos-guard/` and `/root/.claude/projects/` do not outlive the container.

Package-step cases:
- **R-04. SubagentStart fires for a background role, and its context reaches the model.** [O] The registry `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.agents` holds a `start` record with `outcome: emitted` and a package hash for every role launch since 15:37:39Z (line 1 on). The first counted Stop shows the nonce echoed: W-C02-25 row (i) on test designer `a8839a4c77d1f5235`, line 5, `receipt: delivered`, no block before it (L-459). Every counted run since has `stop complete receipt delivered` (`tools/guard_report.py --liveness`, LIVENESS PASS, L-460; re-run 18:44Z). Each run's transcript shows `hook_success` then `hook_additional_context` at lines 2–3 (re-observed for `aa8570fed063c7083` and for this prober run, which received its start header and nonce). Stale when: the version changes, `.claude/settings.json` or `.claude/hooks/agent_hooks.py` changes, or the session changes. State: observed.
- **R-05. Settings hooks are picked up mid-session, without a restart.** [O] W-C02-25's sync at 15:35:45Z (reflog). `SendMessage` appeared among the main session's deferred tools by 15:36:13Z (EV-C02-036, transcript line 5458). The first Agent call after the sync (guard #3373, 15:37:39Z) produced the registry's first `start` and `launch` records (lines 1–2), and every later launch has both (L-458 row (iii) and (iv)). There is no lag at the first opportunity, unlike R-25. Stale when: a further settings change (each needs its own first-use reading); the version changes; a worker restart or source attachment; another session (this one has two sources, although SET:754 documents a multi-repository exception, EV-C02-035 part 2). State: observed.
- **R-06. SubagentStop fires at a run's normal end.** [O] A `stop` record for every finished run since 15:37:39Z, except R-07's case (registry; liveness 18:44Z: 16 counted runs, `stop complete receipt delivered`). Stale when: the version changes, or the settings or hook change. State: observed.
- **R-07. A stop at the platform's turn limit fires no SubagentStop.** [O]/[R]
  - The closing checker `aa8570fed063c7083`: `launch` and `start` run 1 at 17:38:26Z (registry lines 35–36), with no `stop` for run 1 (registry; liveness flags it).
  - The turn-limit cause is the platform notification as L-464 reports it [R]. The transcript has 149 `tool_use` stops up to line 740 [O], which fits a 150-turn limit [I].
  - Consequence: a run that ends at its turn limit leaves a start without a stop, and the liveness check needs an exemption line (L-464).
  - Stale when: the version changes, or a role's `maxTurns` changes. State: observed (one case).
- **R-08. SubagentStart fires again for the same agent ID when the agent's own background-task notification resumes it. The hook emits the package again, but the platform does not inject it again.** [O]
  - Registry line 37: `start` run 2 at 18:32:37Z, 22 s before the executor's denied message (#4295, 18:32:59Z), so no message caused it.
  - Transcript line 741 (18:32:37.609Z): a `<task-notification>` for its background command `binwf1nef` (`status completed`). Line 742: `hook_success`, `SubagentStart:checker`, with the package in stdout.
  - No `hook_additional_context` follows; the only one in the transcript is at line 3, and there is no compaction. This fits H:2569 [V] (injected again only when the earlier copy is gone).
  - Run 2 then stopped `complete receipt delivered` (line 42), the receipt resting on the copy from run 1.
  - L-464's "(b) … with the package delivered again" is not shown: the hook emitted, the platform did not inject.
  - Stale when: the version changes, or the hook changes. State: observed (one case).
- **R-09. A SubagentStop block is honoured.** [V] H:2604, H:2732 (EV-C02-023 section 3 item 2.7; EV-C02-035 part 2): `decision: "block"` keeps the subagent running, with the reason as its next instruction. No `block` record among the registry's 55 lines: no role report has lacked its parts since the hook came into force. Stale when: the version changes, or the hook changes. State: not yet observed. Rows at first natural occurrence (W-C02-25 point 13; L-463).
  **Annotation, 2026-10-20 (L-473; CHK-C02-155 C1).** [O] Observed twice, at its first natural occurrences: test designer `a85385642d3420b60`'s stop was blocked at 18:52:04Z because its hand-over lacked "Guard denials:" (registry line 69); its transcript (`subagents/agent-a85385642d3420b60.jsonl`) holds at line 94 the hook_blocking_error with the reason, delivered as its next turn, and at line 96 the repaired message; its stop passed at 18:52:36Z (registry line 71). Test designer `a12f48103b1400efd`'s stop was blocked at 19:40:57Z and passed at 19:41:37Z (registry lines 78 and 79). State: observed. SB-COR 3.4's Done line ("a report lacking its parts is completed by the same agent before it ends") is met in fact by these two cases.
- **R-10. `last_assistant_message` equals the report received.** [O] W-C02-25 row (ii) (L-459): `a8839a4c77d1f5235`'s stop record (registry line 5) has `prompt_sha256` `17e03557ec8ee538ebd6f04b58761388a715cbcf3808fc4b0de51754c2db339e`. Re-observed 18:4xZ: the SHA-256 of `tools/subagent_audit.py last a8839a4c77d1f5235` without its final newline is the same. Also re-observed on a resumed run: `aa8570fed063c7083` run 2 (line 42), `c83e68a2914ed1fcb28d217269dc39324a297f706ba0bfb5dced1828281b198c`, equal to its `last` (21,765 bytes, the report filed as CHK-C02-152). Stale when: the version changes, the hook or `subagent_audit.py` changes, or under `SubagentHandback` (auto mode), where it is not the report [V] H:2583. State: observed.
- **R-11. A SubagentStop block reason's size limit and delivery.** [V] No limit is documented: the 10,000-character cap lists `additionalContext`, `systemMessage`, `initialUserMessage` and stdout, not `reason` (EV-C02-023 section 3 item 2.8; EV-C02-035 part 2). No block has occurred (R-09). Stale when: the version changes, or the documentation changes. State: not yet observed. The 3.7 fallback (path only, hash asked) stays named.
  **Annotation, 2026-10-20 (L-473; CHK-C02-155 C1).** [O] Delivery observed: the block reason reached the agent as its next turn (`a85385642d3420b60`'s transcript line 94). Both observed reasons were short, so the size limit stays not yet observed. State: delivery observed; size limit not yet observed.
- **R-12. The hook's `session_id` against the guard's log key.** [O]
  - The key is `CLAUDE_CODE_REMOTE_SESSION_ID` normalised, else the hook input's `session_id` (`.claude/hooks/tool_allowlist.py` `session_key`, line 2566).
  - Every guard record carries `session: session_01JDJ8fJQmrKpXfiRh1yEoxv` and `local_session: e177dd92-42b7-5480-8039-2655653745ba`; `local_session` is the hook input's `session_id` (line 2590), and the same value is the transcripts' `sessionId`.
  - So the hook's `session_id` is not the key; the key is the cloud ID. The registry, guard log and nonce-key files share it, and `a533282bfce7fb08e` is the same string in its start, launch and 22 guard records (W-C02-25 row (iii), L-458).
  - Stale when: a session without `CLAUDE_CODE_REMOTE_SESSION_ID` (the key falls back to `session_id`); the version changes; `session_key` changes. State: observed.
- **R-13. `SendMessage`'s input schema and target field.** [O]
  - Main session: the executor's `ToolSearch select:SendMessage`, 15:36Z, no call (EV-C02-036, transcript line 5458). `to` is a required string (one line, up to 300 characters); `message` is a required string (default `""`); `summary` and `notify_when_idle` are optional; `additionalProperties: false`; `defer_loading: true` (deferred in main).
  - In a role subagent: the same four properties and `required: [to, message]` are in this prober run's own tool list, not deferred (self-observation, `a8f9de3ef606333a7`).
  - The schema is not the hook-side shape (R-26).
  - Stale when: the version changes, or the settings deny changes. State: observed.
- **R-14. Whether a role subagent can call `SendMessage` without `ToolSearch`.** [O]
  - The platform's tool list for role runs started after W-C02-27's role files loaded includes `SendMessage`, and none includes `ToolSearch`. Prefix `toolNames`:
    - researcher `a738e84458e67d309`: Read, Grep, Glob, Bash, WebFetch, WebSearch, SendMessage;
    - checkers `ae6f06283aba18948`, `aa8570fed063c7083`, `ad97f09223020d9da`: Read, Grep, Glob, Bash, SendMessage;
    - prober `a0af1624f9cd84007`: the same;
    - this prober run: `SendMessage` with its full schema in its tool list.
  - So no load is needed. No guard record holds a `SendMessage` call by any `agent_id` other than null (grep; only #4295, by main). Under T6 as merged, every call is denied (R-26).
  - Stale when: the version changes, a role's `tools:` line changes, or T6 changes (W-C02-27.1). State: tool present without `ToolSearch`, observed. A role's call: not yet observed.
- **R-15. Whether a resumed role reports back to the agent that resumed it.** [V] Documented only for interactive sessions (SA:1134/1145; EV-C02-035 part 1 item 4). No role has been resumed by another agent: the executor's resume message was denied (#4295), and R-08's resume was the agent's own notification. Stale when: T6 changes (W-C02-27.1) or the version changes. State: not yet observed (W-C02-27 point 10's "recorded when they occur" rows).
- **R-16. The sibling roster's form.** [V] Names, listing `main` and every other named agent, shown only if the subagent has `SendMessage` and at least one other agent has a name (SA:1107; EV-C02-023 section 3 item 2.20). [O] No roster is in this prober run's context, and all 55 registry records have `name: null`: the executor launches unnamed agents, so the documented condition is not met. Stale when: an agent is launched with a name, or the version changes. State: not yet observed (absence observed while no agent is named). The 3.7 fallback (IDs in `Teammates:`) is in use.
- **R-17. SubagentStart and SubagentStop for workflow agents.** Not applicable: guard rule TW has denied the Workflow tool as a whole since M1a's sync (`23bc1d2`, L-454), and the liveness report lists workflow agents as excluded. Stale when: TW changes. State: not applicable (SB-COR 3.1 keeps roles out of workflows until this row is observed).
- **R-18. A workflow `agent()` call's default type.** Not applicable, for R-17's reason. [V] Not read: the workflows page was not read (EV-C02-023 section 3, Unsure). Stale when: TW changes. State: not applicable.
- **R-19. What the built-in type `claude` may write.** [V] "A catch-all with every tool available to subagents" (SA:77; EV-C02-023 section 3 item 2.15): not read-only. Not applicable for observation: since M1a's sync only the five role types are allowed (L-454), and SB-COR 3.1 excludes `claude` unless shown read-only. Stale when: the guard's role types change, or the version changes. State: not applicable; the [V] reading keeps 3.1's exclusion.
- **R-20. SessionStart at `startup`, `resume`, `clear`, `compact`.** [O]
  - `compact`: registry line 33, `session_start` at 17:19:37Z, `outcome: compact`, package `executor@839747541aa6` (liveness line `session_start … source compact`).
  - `startup`: not applicable in this session, which opened at 09:13Z, before the hook was in force (15:35:45Z).
  - `resume` and `clear`: not yet observed.
  - Per 1.2, this working-session reading does not count for C06's routine sessions.
  - Stale when: the version changes, the settings or hook change, or the session changes. State: `compact` observed; `startup` not applicable here; `resume` and `clear` not yet observed.
- **R-21. The first PostToolUse-on-Agent record's shape.** [O] Registry line 2 (15:37:39Z, after guard #3373): `event: launch` with `agent_id a533282bfce7fb08e`, `agent_type producer`, `item plan/work/W-C02-27.md`, `form writer`, `tool_use_id toolu_01EyMycYf8xUXvDru9bjNeov`, `prompt_sha256 0a2f78f1…ce0d` (W-C02-25 row (iv), L-458). The `agent_id` in it shows that the launch result carried the agent's ID [I]. The raw hook input's key set is not recorded anywhere. [V] H:1913/1925: `status: "async_launched"` with `agentId`, `description`, `prompt`, `outputFile`, `resolvedModel` (EV-C02-023 section 3 item 2.11). Stale when: the version changes, or the hook changes. State: observed as the registry records it; raw key set not yet observed.

Package-step cases (W-C02-22 point 10 version 2.1, red path; EV-C02-034 section 2):
- **R-22. Producer row: red on the package step; P met by start delivery.** [R]+[O] The counted run `a14a3efb001ccc75d` read `.claude/roles/producer.md` whole through Bash `cat` (transcript line 19), not by a Read (EV-C02-034; L-457). By the red path, P is met by W-C02-25's live delivery for the producer: `a533282bfce7fb08e`, `start emitted producer@d379362747dd` (registry line 1), `stop complete receipt delivered` (L-458, L-459). The row claims delivery plus H only. The platform fact it rests on is R-04; the shell read is model behaviour, not a platform fact. Whether P's "a Read" excludes a whole shell read is W-C02-22's condition owner's question (EV-C02-034 section 3). Stale when: R-04 is stale, or point 10 changes. State: observed (delivery); the red P stands as recorded.
- **R-23. Researcher row: the same.** [R]+[O] `a396ce35152701fcc` read its package whole by Bash `cat` (line 18) (EV-C02-034; L-457). P is met by `a738e84458e67d309`: `start emitted researcher@bfb9d1e8e5e9` (line 27), `stop complete receipt delivered` (line 30) (L-460). The row claims delivery plus H only. Stale when: as R-22. State: observed (delivery).
- **R-24. Checker row: the same.** [R]+[O] `a511fc509e57f7b92` read `checker.md` with a Read of `limit: 15` (line 23) and the rest with `sed -n 15,80p` (line 31): the Reads do not cover every line (EV-C02-034; L-457). P is met by `a19bdbc73cfcc8f78`: `start emitted checker@951789897e85` (line 7), `stop complete receipt delivered` (line 8) (L-459). The row claims delivery plus H only. Stale when: as R-22. State: observed (delivery).
- (The test-designer row, `a072ae4c6fedbb95b`, and the prober row, `a7dceb91bd085dc8c`, were recorded on P's letter (EV-C02-034) and need no capability row.)

The reload lag:
- **R-25. Role-file (agent definition) text, front matter included, reaches new runs only after a lag following a sync. Settings hooks, the start hook's packages and the guard do not lag.** [O]
  - Method:
    - A run's `systemCharCount` (its prefix record `/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/subagents/agent-<id>.prefix.json`, written at the run's stop) equals the body of its role file, plus 1,378 characters.
    - The offset is constant in all 14 runs read, across five types: the control.
    - Bodies are from `git show <sha>:.claude/agents/<role>.md` with the front matter cut, counted with `wc -m`:
      - producer 8,101 → 8,346;
      - researcher 9,436 → 9,681;
      - prober 9,942 → 10,187;
      - test-designer 12,157 → 12,402;
      - checker 18,273 → 18,518 → 20,618 at W-C02-24.1's merge.
  - W-C02-27's sync (`6a6585c`, live tree 17:03:12Z, reflog):
    - producer `a9519e914534ff414`, launched 17:04:56Z (+1 min 44 s): 9,479 = the old body, and `toolNames` without `SendMessage`, so the old text;
    - researcher `a738e84458e67d309`, 17:11:20Z (+8 min 08 s): 11,059 with `SendMessage`, so the new text;
    - checker `ae6f06283aba18948`, 17:18:28Z (+15 min 16 s): 19,896, so the new text.
  - W-C02-24.1's sync (`9fdd9c2`, 17:34:24Z):
    - checker `aa8570fed063c7083`, 17:38:26Z (+4 min 02 s): 19,896 = the pre-W-C02-24.1 body, so old;
    - checker `ad97f09223020d9da`, 18:36:31Z (+62 min 07 s): 21,996 = the new body.
  - Bounds: at least 4 min 02 s. At most 8 min 08 s for W-C02-27's change, and at most 62 min 07 s for W-C02-24.1's (no checker run in between). Cause not settled.
  - Controls that did not lag:
    - settings hooks (R-05, at the first opportunity);
    - the delivered package hash equals `.claude/roles/<role>.md` at the head (CHK-C02-152 relied_on 6);
    - the guard and hook scripts are read on each call.
  - Sources: CHK-C02-152 relied_on 4, P3 and unsure (a), re-observed and extended here (the 1,378 offset; `ad97f09223020d9da`'s upper bound).
  - What the lag makes stale:
    - (a) Any statement that role-file text, or a `tools:` line, is "in force from its sync": it is in force from the first run whose prefix shows it. The guard's T6 was in force from #439's sync, but W-C02-27's role-file lines were not (L-459). W-C02-24.1's checker duty texts (the `producer_run` line and the confirmation paragraph) were not in CHK-C02-152's own run (CHK-C02-152 P3).
    - (b) Any row or reading that depends on role-file text and was taken on a run launched within the lag window of a sync (observed up to 62 min), unless that run's prefix shows the new text. This covers W-C02-27 point 10 (i)'s "first role run after the sync" (CHK-C02-152 C3) and any W-C02-22 point 10 reading of a run launched shortly after a role-file sync.
    - (c) R-01's "Not shown: whether a changed role file is loaded mid-session": it is loaded mid-session, after a lag.
    - (d) A prefix check is possible only after the run stops: the prefix file is written at stop (file times 17:15:58Z and 18:35:53Z equal those runs' stop records).
  - Stale when: the version changes; the prefix record's format changes; each new role-file sync (its own reading). State: observed.

`SendMessage` as the hook receives it:
- **R-26. The platform rewrites `SendMessage`'s input before PreToolUse, so the hook sees keys outside the schema's `{to, message}`. With T6 as merged, every call is denied by T6.1. This is W-C02-27 point 10 (ii): red.** [O]
  - The executor's call at 2026-10-20T18:32:59Z to `aa8570fed063c7083`, guard record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`: `deny`, rule `T6.1`, detail "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}" (L-463).
  - Re-observed in the main transcript `/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba.jsonl`, tool use `toolu_01Tii7PmwDMAu5gR9YkSfPGU`: the stored input is already `{to, message, type: "message", recipient, recipient_kind: "agent", content}`, with `content` the message's first line, truncated.
  - `summary` appears at the hook only; its value is the message's first line, which fits a platform default (TR:49, EV-C02-035 part 1).
  - So the legacy-key rewrite runs before the transcript write, and `summary` is added before the hook.
  - Not shown by any record read: the keys the model emitted [I: `to`, `message`], and whether `message` reached the hook (the guard summary drops it).
  - Not retried (D-020, D-017). The fix is W-C02-27.1's (in triage).
  - Stale when: the version changes, or T6 changes. State: observed (one call, main session).
