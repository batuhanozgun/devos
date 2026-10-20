---
id: EV-C02-030
title: "W-C02-25 (M2, with M3a) and W-C02-27 (M3b): team triage, round 1, the SendMessage probe, and the integrated approaches (version 1)"
stage: C02
kind: observation
source: "the five triage notes (producer a219e82ff883cf66f, researcher ad67bb232bb50343b, prober abc86b55790c7fd15, checker a5309384b6fd9cecb, test designer a312472717fb8bd4f), each taken with tools/subagent_audit.py last after its end status, DISCIPLINES OK; the executor's ToolSearch probe; the executor's integration"
---

# EV-C02-030 · M2, M3a and M3b: the team triage and the approaches

Filed by the executor (L-447). The notes are verbatim but for library paths written as `[library id: …]` where the leak check matched a path (the researcher's note; the paths are in the library's index), and the asks' library lines likewise. No note quotes the common floor's heading. Parts 2 to 6 are the round-1 notes; part 8 the probe; part 9 the integration, whose two approach blocks are pasted by tool into `plan/work/W-C02-25.md` and `plan/work/W-C02-27.md`.

## 1. The task

The five tasks share the text below; each adds one role-specific ask (part 1.1) before the take-up line and the discipline block (working order section 9, verbatim, not repeated here).

Item: plan/work/W-C02-25.md, plan/work/W-C02-26.md and plan/work/W-C02-27.md (none is on `main` yet; this is their team triage, one round)

**Purpose:** DevOS installation, C02, side branch SB-COR (`plan/SB-COR_Correction_Plan.md`; Batu's directions `plan/decisions/D-039.md`, `D-040.md`, `D-041.md`). PR-A1 (W-C02-22) merged; PR-A2 (W-C02-23, the role packages) and M1 (W-C02-24, guard rule T5, the type narrowing, the whole-tool Workflow deny, the merge gate's verdict forms) have agreed approaches (EV-C02-028 part 10) and are being built. This triage covers SB-COR's remaining mechanisms, in parallel with those builds:
- **W-C02-25 = M2** (SB-COR 3.2 to 3.5): the registry of this session's agents (SubagentStart and PostToolUse on Agent writing `/tmp/devos-guard/<session>.agents`); presence at start (`.claude/hooks/subagent_start.py`: the header `DevOS role package: <role>@<sha256-12>` from W-C02-23's constants, the package, the agent ID, the nonce on the last line; the executor's package by the SessionStart hook); the hand-over at the end (`.claude/hooks/subagent_stop.py`: one block per run when the disciplines block, a hand-over heading, the receipt or the nonce is missing; never traps an agent); liveness at every opening (`tools/guard_report.py`, `tools/stop_check.sh`, `tools/records.py`); depends on W-C02-23 and W-C02-24.
- **W-C02-26 = M3a** (SB-COR 3.6a): settings only: `SendMessage` out of `permissions.deny` in `.claude/settings.json`, `isolatePeerMachines` true, `ListAgents` denied and `crossSessionInbound: refuse` kept; the guard's T1 still denies `SendMessage`; PC-45's note; depends on W-C02-25.
- **W-C02-27 = M3b** (SB-COR 3.6b): guard rule T6 (`SendMessage` only to an agent ID in this session's registry or to `main` from a non-null caller; a producer's ID only from that item's consumers or the executor, naming the item T5 recorded), the roles' `tools:` lines gaining `SendMessage`, the working order's text; depends on W-C02-26.
With SB-COR 3.7's fallbacks for each. Batu has asked that the whole correction be finished today (2026-10-20, Turkey time); the executor will not cut a binding check to get there, and asks each role to say where a part is larger than it needs to be, where two parts can be joined or one dropped with its reason, and what can run in parallel. The open question: for each item, what should be built, how, against what condition, checked how deeply, on what knowledge; whether it is wrongly framed, needs another method, or is not needed; what you object to. Must hold for `main` at the head named under Inputs and Claude Code 2.1.304.

**Acceptance:** none yet; after this round the executor integrates one approach per item (a second round only where a defect or missing evidence is still open), the test designer writes each condition, and they merge together before any product.

**Consumer:** the executor, who integrates your note into each item's approach block with a disposition where it decides across fields; then the test designer, the producer and each binding checker.

**Inputs:** `plan/SB-COR_Correction_Plan.md` 1.2, 3.2 to 3.7, E and G; `evidence/C02/EV-C02-023_platform_capability.md` (the capability rows these items rest on, most unobserved); `evidence/C02/EV-C02-028_pra2_m1_triage.md` part 10 (PR-A2's and M1's agreed approaches: the constants, T5's forms, the registry's need for `launch`, the whole-tool Workflow deny) and part 9 (the round-2 notes); `plan/Installation_Working_Order.md` sections 3, 4, 9 and 10; `.claude/settings.json`, `.claude/hooks/tool_allowlist.py`, `.claude/hooks/reread_after_compact.py`, `tools/guard_report.py`, `tools/stop_check.sh`, `tools/subagent_audit.py`, `tools/records.py`. `main` is `449df84316b3bd4dd12e48c48b53d274a59cb983` (W-C02-23's condition is on branch `claude/c02-w23-acceptance` at `a2af2479da9ac5189aec8831e15bc05dc369d480`, under its binding check). Your library line is above.

`Teammates:` this round runs in parallel; PR-A2's and M1's triage roles are in EV-C02-028 parts 9 and 10. No teammate is reachable by message (T1 denies `SendMessage`).

**Output:** your final message, which the executor takes with `tools/subagent_audit.py last` and files verbatim (but for identifiers that match the leak check, and any quotation of the common floor's heading, which is withheld at filing) in the items' triage evidence record (a new `EV-C02-0nn`). In its product part, for each item separately: (1) your view from your field, numbered, each `PROCEED` or `DEFECT: <what, and the observation that would show it fixed>`, `MISSING_EVIDENCE: <what>`, `PREFERENCE: <what and why>`, `SCOPE_CONFLICT: <what>`; only a defect or missing evidence blocks; (2) the role-specific ask above; (3) where the item can be smaller, joined or dropped, and what can run in parallel.

**Writer or reader:** reader. No writes in `/home/user/devos` or any repository; no commits; no GitHub writes; a fresh scratch clone with literal paths if needed. The library clone `/home/user/agentic-os-search` is read-only; copy no library text (cite by path and section).

**Limits:** about 50 tool calls.

**Constraints:** (a) During this run, do not open (Read, Grep, Glob on, or name in a shell command) your own file under `/home/user/devos/.claude/agents/`, `/home/user/devos/CLAUDE.md`, `plan/decisions/PC-53.md`, `plan/work/W-C02-22.md` or `evidence/C02/EV-C02-026_pra1_triage.md`, and read `plan/Ek_D_Dusunme_Protokolleri.md` only from line 69 on (Read with offset 69). Reason: this run may be an observation W-C02-22 point 10 counts, whose counting rule makes a run countable only if those files are not opened before the report; a reading order for an observation's independence. (b) The reader's limits above.

### 1.1 The role-specific asks

- **producer** (`a219e82ff883cf66f`): **Role-specific ask (producer, your field: the method).** For each of W-C02-25, W-C02-26 and W-C02-27: the production method (which files change, which functions, reuse of the guard's session-key function and `DEVOS_GUARD_LOG_DIR`, the registry's file format and locking), the interfaces the test designer can pin, liveness and lock-out (a SubagentStop hook that could trap an agent; a start hook that could refuse every role), its cost, and whether parts should be joined (for example M3a with M3b, or M2's liveness report with M1's guard report) or dropped, with your reason. Library line (from your map): `research/studies/spec-kit/FINDINGS.md`, `research/studies/superpowers/CORE.md` with `notes/U04-testing-diagnosis-and-verification.md`, `research/studies/gstack/CORE.md` (liveness: P7). Start there; search further by need.
- **researcher** (`ad67bb232bb50343b`): **Role-specific ask (researcher, your field: what the sources state).** For each of W-C02-25, W-C02-26 and W-C02-27: the dated platform facts each rests on, labelled [V] with page, heading and reading date, or "not stated" with the windows read: SubagentStart's and SubagentStop's inputs and outputs (`additionalContext`, the 10,000-character cap and preview, `last_assistant_message`, a block's `reason` and its size limit, whether a block is honoured, the matcher for custom agents), SessionStart's sources (`startup`, `resume`, `clear`, `compact`), `SendMessage`'s input schema and target field, resuming a finished subagent by message, `isolatePeerMachines`, `crossSessionInbound`, `permissions.deny` for `SendMessage`; and what the library says on start-time context injection, hand-over checks at stop and agents messaging each other, with counter-evidence. Library line (from your map): [library id: research index], [library id: studies catalogue]; `research/studies/context-memory-harness-engineering/`; `research/studies/superpowers/` (U03); multi-agent-patterns' assessment (section 7, C3 to C5); EXP-006's P4-01 and S1-03 under `explorations/`. Start there; search further by need.
- **prober** (`abc86b55790c7fd15`): **Role-specific ask (prober, your field: platform behaviour, by a discriminating observation).** For each of W-C02-25, W-C02-26 and W-C02-27: which platform facts it rests on (from capability record 1.2's rows), labelled [V], [O] or unobserved; for each unobserved one, the discriminating observation and negative control you would make, written before observing, from this session's own agents only (D-017, D-020: no surveillance, negative cases synthetic), placed at its first natural occurrence after the item's merge and sync; which of SB-COR 3.7's fallbacks each red outcome selects; and whether any observation can be made now, before the build, without a planted case. Library line (from your map): `research/studies/gstack/CORE.md` (P5 to P7, F2 to F4); `research/studies/ecc/METHOD-CASE.md`; [library id: work-environment vertical KEY]. Start there; search further by need.
- **checker** (`a5309384b6fd9cecb`): **Role-specific ask (checker in triage, your field: the depth and reading mode of the check; non-binding contribution form; you are excluded from these three items' binding verdicts).** For each of W-C02-25, W-C02-26 and W-C02-27: your triage for its binding check (the claim, the failure classes that could make it false, the cheapest discriminating evidence and its counted environment, the depth, the reading mode, whether Ek A 3.2 (c) is asked, `floor:`; a hook that can block or deny is a floor path, SB-COR 2.6 (b)); whether parts can share one verdict or must be split for the check; and where the check can be smaller without going below the floor. Library line (from your map): multi-agent-patterns' assessment (its critic sections); `research/studies/superpowers/CORE.md` with `notes/U04-testing-diagnosis-and-verification.md`; `research/studies/gstack/CORE.md` (F1 to F5, P7). Start there; search further by need.
- **test-designer** (`a312472717fb8bd4f`): **Role-specific ask (test designer, your field: the criterion).** For each of W-C02-25, W-C02-26 and W-C02-27: the condition you would write (claim M as a property of the flow; its breaks, each turning red if the mechanism is removed or bypassed; the over-blocking controls, among them an agent that is never trapped by the stop hook and a message to this session's own helper that is allowed; every negative case as a synthetic hook input asserting its own rule ID; the counted environment per claim, program logic against platform delivery; the plan 6.12 item 4 line; "Not covered: use; it rests on consumer row <n> of 2.8"), the interfaces you need the producer to state first, and which of SB-COR 3.7's fallbacks each condition must name. Library line (from your map): `research/studies/anthropic-ai-native-sdlc-playbook/` (falsifiers F7, F8); `research/studies/gstack/CORE.md` (P6, P7, F4); [library id: work-environment vertical KEY] and its finding 02. Start there; search further by need.

## 2. The producer's note (`a219e82ff883cf66f`), verbatim

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. All three items hold: the plan names each one's mechanism, and the open question is how to build each, which is my field (method). Each item has defects to fix in its approach, listed below, but none is wrongly framed. One plan premise is false: the guard has no session-key function to import (W-C02-25 point 2). One plan statement contradicts itself: the nonce must be reused but only its hash is stored (W-C02-25 point 4). The order the plan sets can be shortened by joining W-C02-26 into W-C02-25's pull request.

## Disciplines (D1–D9)
D1: yes: I weighed the alternatives the plan leaves open (one hook script or two; per-start nonce, stored nonce or derived nonce; registry state or `stop_hook_active` for one block per run; M3a on its own or joined into M2) and made each conditional on rows that are still unobserved.
D2: uncertain: Batu wants it finished today, so I proposed only cuts that remove no binding check, and gave each cut its reason.
D3: yes: I checked each mechanism against its claim M and the consumer chain. That found the uncheckable "that item's consumers" rule in T6 and the test-designer resume route.
D4: yes: I named, for each item, what its tests can show and what they cannot (hook-script logic in the container, not platform delivery), and where a planned check would misreport (the late-receipt rule).
D5: yes: I did not rely on the researcher's summary of the hooks page in EV-C02-023 for the load-bearing facts. I fetched the page myself and read the SubagentStart and SubagentStop sections and the failure rules.
D6: no
D7: no
D8: yes: I confirmed the live tree is at `main` `449df843…` and read the code at that head. I did not read the W-C02-23 branch, so PR-A2's constants are taken from EV-C02-028 part 10.
D9: yes: I read my library line (spec-kit FINDINGS 5, 7, 15; superpowers CORE 3 to 5 and U04 F28, F30, F32; gstack CORE P5 to P7, F2 to F4). They justified the liveness design and limited the claims, and changed no fact.

Read, and what each changed:
- `plan/SB-COR_Correction_Plan.md` (all): defined the three items and set the claims I judged.
- `evidence/C02/EV-C02-023_platform_capability.md` (all): gave the [V] rows. Its items 2.2, 2.6, 2.7, 2.10 and 2.21 shaped the start-hook dedupe point, the matcher, the stop-hook design and the schema dependency.
- `evidence/C02/EV-C02-028_pra2_m1_triage.md` part 10 only (lines 2634 to 2670): gave PR-A2's constants (RESERVE, header form, trigger set) and M1's ROLE_TYPES, T5 forms and the `launch` subcommand. It changed: the registry binds agent ID to `tool_use_id`, and the coordination of `tools/merge_gate.py`. Parts 2 to 9 were not read (budget).
- `plan/Installation_Working_Order.md` sections 3, 4 (lines 32 to 73), 9 (lines 185 to 205) and 10 (lines 206 to 236): gave the passages M3a and M3b must change (section 4 step 4's "the guard denies resuming a helper"; section 9's `Teammates:`; section 10 line 211, PC-45's sentence) and table row 7.
- `.claude/settings.json`: the current hooks and the deny list. Every new hook must stay outside the guard's `onFailure: block` shape.
- `.claude/hooks/tool_allowlist.py` lines 40 to 129, 410 to 429, 783 to 800 and 2138 to 2346: no session-key function exists (premise corrected). `LOG_DIR` is guarded for writes. T1 denies `SendMessage`. `decide()` is shared with PermissionRequest.
- `.claude/hooks/reread_after_compact.py`, `tools/guard_report.py`, `tools/stop_check.sh`: the shapes I would extend.
- `tools/subagent_audit.py` lines 84 to 123 and 283 to 407: `block_problem`, `last_text` and `DISC_HEAD` can be reused by the stop hook.
- `tools/test_tool_allowlist.sh` lines 20 to 70 and its `SendMessage` lines: the harness drives hook commands read from settings by index `[0]`, and its settings checks are where M3a's assertions go.
- `tests/C02/W-C02-22/breaks.py` lines 244 to 248: break B19 adds `SendMessage` to a role's `tools:` line. This changed W-C02-27 point 4.
- Front matter only of `.claude/agents/{checker,researcher,prober,test-designer,counter-designer}.md`: each `name:` equals its file name, and no role's `tools:` line has `SendMessage` yet.
- `plan/Ek_D_Dusunme_Protokolleri.md` from line 69: the trigger questions, D1 to D5 full texts, section 5. These set the method.
- Web: https://code.claude.com/docs/en/hooks.md, fetched 2026-10-20 with curl (lines 2533 to 2620, 463, 517, 788, 873 to 943, 1913 to 1927). It changed: one block per run uses `stop_hook_active`; the matcher must equal front-matter `name:`; the start hook cannot block; dedupe on re-run.
- Library: as listed under D9.
- Deliberately not read, per constraint (a): my file under `.claude/agents/`, `plan/decisions/PC-53.md`, `plan/work/W-C02-22.md`, `evidence/C02/EV-C02-026_pra1_triage.md`, and Ek D before line 69. `CLAUDE.md` was not opened; the harness delivered it as context. Also not read: the W-C02-23 branch, the sub-agents and settings-reference pages, `tools/records.py` beyond a grep, `tools/merge_gate.py`.

Relied on:
- No session-key function exists. The key is built inline in `log_decision` as `CLAUDE_CODE_REMOTE_SESSION_ID` normalised by `norm()` (`cse_` read as `session_`), else `session_id`, sanitised to `[A-Za-z0-9_-]`, 80 characters (`.claude/hooks/tool_allowlist.py:415-417, 2260-2262`). `tools/guard_report.py:28-33` normalises but does not sanitise. [observed]
- `LOG_DIR` is among the guarded write roots (`tool_allowlist.py:791`); reads there are not guarded. [observed, from code]
- `SendMessage` is not in `ALLOWED_NON_MCP` (`tool_allowlist.py:106-114`), so T1 denies it (`:2193-2194`; test `tools/test_tool_allowlist.sh:129`). [observed]
- PermissionRequest uses the same `decide()` (`tool_allowlist.py:2308-2332`). [observed]
- Importing the guard module costs 0.019 to 0.052 s with `python3 -I` 3.13.16 here. [observed]
- SubagentStart cannot block. Its input is `agent_id` and `agent_type` only, and its matcher uses the front-matter `name`, not the file name. When it runs again for the same subagent, the context is injected only if the earlier copy is gone. (hooks.md lines 2535 to 2569) [V]
- SubagentStop input has `stop_hook_active`, `last_assistant_message` and `agent_transcript_path`. A block is `decision: "block"` with `reason`, or exit 2. It uses Stop's loop protections, which include an 8-consecutive-continuation cap. (hooks.md lines 2577, 2604, 2730, 2811) [V]
- On events other than those with `onFailure: "block"`, a failed or timed-out hook is a non-blocking error. (hooks.md lines 517, 788, 908, 943) [V]
- A background Agent launch's PostToolUse response carries `agentId`, `prompt` and `outputFile`. (hooks.md line 1925) [V]
- PR-A2's `RESERVE = 200`, the header form, the constants in `tools/check_role_packages.py`, the trigger set in `tools/merge_gate.py`, and that W-C02-25 adds its start hook to that set (EV-C02-028 part 10.1, agreed (4) and (5)). [stated in record]
- M1a's `ROLE_TYPES` and its writes to `tool_allowlist.py`; M1b's writes to `tools/merge_gate.py` and `subagent_audit.py launch` (EV-C02-028 part 10.2). [stated in record]
- `tests/C02/W-C02-22/breaks.py:246` (B19) treats `, SendMessage` added to a role's `tools:` line as a break. [observed]
- That B19's suite is re-run at later heads. [inferred; not settled]
- That a tool removed by `permissions.deny` cannot be loaded with `ToolSearch` until the deny goes. [inferred]

Unsure:
- Whether a `permissions.deny` change, and an edited role file's `tools:` line, take effect mid-session. No capability row covers either; R-01 says the second is not shown. A post-sync observation settles each (W-C02-26 point 2, W-C02-27 point 5).
- What the platform compares when it "already holds the copy": the text, or the hook. Unobserved. Point 4's derived nonce makes the answer irrelevant.
- Whether `tool_input.name` and `tool_response.agentId` appear in this session's PostToolUse-on-Agent input. Row 1.2's first-record observation settles it.
- Whether W-C02-22's suite is a standing check. The test designer settles it.
- The exact `SendMessage` input keys. The executor's raw schema read after M3a settles them.
- The W-C02-23 branch's constants as built. Read at PR-A2's merge.

For: the executor, who integrates these notes into the approach blocks of W-C02-25, W-C02-26 and W-C02-27 with dispositions. After that: the test designer, who pins the interfaces below; the producer who builds; and each binding checker, who gets the floor list and the liveness breaks.

Received from / Returned to: none received. Outside my scope, reported here and not done:
1. M1b (W-C02-24, being built) owns `tools/merge_gate.py`. I ask the executor to have M1b add the M2 hook path, `.claude/hooks/agent_hooks.py`, to PR-A2's trigger-set constant now. Then M2 does not write `tools/merge_gate.py` and both can be built in parallel. An absent path in the set is harmless.
2. To the test designer: W-C02-22's B19 against W-C02-27 (W-C02-27 point 4).
3. To the executor: once M2's registry exists, M2 can bind a writer-form launch to its agent ID. EV-C02-028 part 10.2 disposition (1) names that as the reopen condition for `subagent_audit.py launch`'s route. That reopening is not M2's scope.

Product:

**W-C02-25 (M2: registry, start and stop hooks, liveness)**

(1) View from my field
1. PROCEED: the four parts reach claim M within their limits. The registry records who exists. The start hook puts the package and a nonce into the agent's context. The stop hook makes a report without its parts get completed. The liveness report shows any of these that did not run.
2. DEFECT: the plan's premise "import the guard's own session-key function" is false; the key is computed inline. Seen fixed when: the approach names a guard function `session_key(data)` used by `log_decision`, imported by the hooks and by `tools/guard_report.py`; and a test shows the log file's path for synthetic inputs (remote ID set with `cse_`, unset, with characters outside `[A-Za-z0-9_-]`) is byte-identical before and after the refactor and equal to the registry file's stem.
3. DEFECT: the Auto-window piece (the guard denies a `SubagentHandback` that lacks hand-over parts) can trap an agent. A PreToolUse deny has no `stop_hook_active` and no continuation cap, so a parser bug repeats the denial for as long as the agent retries. Auto is only a named single-action window (D-034 (b)), so a role run inside one is rare. Seen fixed when: the piece is dropped and the liveness report marks such a run "hand-over not checked: SubagentHandback". Or else a synthetic case shows a second `SubagentHandback` by the same agent run is allowed whatever its content.
4. DEFECT: the nonce rule contradicts itself. 3.3 says the nonce is created once per agent and reused on resumes, while the registry stores only its hash; to reuse it, the raw value must be kept somewhere. Seen fixed when: the method states where the reused value comes from. My method: nonce = the first 16 hex characters of HMAC-SHA256 over `agent_id`, keyed with 32 random bytes in `LOG_DIR/<session_key>.nonce-key`, created once with `O_EXCL` and mode 0600 (tool writes there are denied by B5/F rules). The stop hook recomputes it, so no nonce or hash is stored. Two synthetic SubagentStart inputs for the same `agent_id` give byte-identical `additionalContext`, so the platform's dedupe works whatever it compares. The key is readable like the registry; the nonce proves that the text arrived, and it was never a secret.
5. DEFECT: 3.4 and 3.5 count "a receipt obtained only after a block" as "Start not delivered", and `stop_check.sh` fails on it. But the block's reason never carries the nonce, and only the start hook's text holds it. So a nonce given after a block proves the text was delivered; only the hand-over was late. A dead start hook can never produce a late receipt, so the rule protects nothing and makes stop_check fail on a sound case. Seen fixed when: a synthetic run whose first Stop lacks the nonce and whose second Stop has it is reported "delivered; hand-over completed after one block", stop_check passes it, and "Start not delivered" means no nonce in any Stop of the run.
6. PREFERENCE: the stop hook does not block for what the agent cannot supply. If the report says `Package: none delivered` and has no nonce, a block cannot get one: the agent never had it. The hook records "Start not delivered" for liveness and blocks only for parts the agent can supply: the disciplines block, the hand-over headings or the checker's verdict front-matter keys, and the `Package:` line. Without this, a dead start hook costs one useless block in every run.
7. PROCEED, with a conditional recipe: the launch-to-start join rests on `tool_response.agentId` in PostToolUse on `Agent`/`Task` ([V] for background launches; this session's record shape is row 1.2, unobserved). If the row shows `agentId`, join by it. If not, the launch record has no agent ID, so no item is bound to it, and W-C02-27's producer rule denies messages to that producer (closed; the return goes by the hand-over).
8. PREFERENCE (an interface W-C02-27 needs): record `item` and the `Writer or reader:` form for every launch whose prompt has an `Item:` line, not only for producers. Parse them with M1a's T5 functions imported from the guard (one parser).
9. PROCEED, with a pinned check: the SubagentStart and SubagentStop matcher compares the front-matter `name:`, not the file name (hooks.md line 2535). A test asserts that the matcher's alternatives equal M1a's `ROLE_TYPES` and the role files' `name:` values (they match today for the four files I opened).

(2) Method, interfaces, liveness, cost
- Files:
  - `.claude/hooks/tool_allowlist.py`: adds `session_key(data)`, `registry_path(data)`, `registry_append(data, rec)` and `registry_read(data)`, about 40 lines. They are pure functions, and `decide()` calls none of them until W-C02-27. Keeping them in the guard keeps one source for the format, and T6 reads them without the guard importing any other file. A guard that imports a sibling module would deny every call if that module broke: a new lock-out.
  - New `.claude/hooks/agent_hooks.py <Event>`: one script whose command names its event, as the guard's PermissionRequest command does. It covers SubagentStart, SubagentStop, PostToolUse on Agent and SessionStart. It imports the guard module (under 0.06 s), `tools/subagent_audit.py` (`block_problem`, `DISC_HEAD`) and `tools/check_role_packages.py` (header form, RESERVE). This is my choice over the plan's two scripts: one parser, one test harness, one trigger-set path.
  - Unchanged: `.claude/hooks/reread_after_compact.py`.
  - `.claude/settings.json`: adds the four hook entries.
  - `tools/guard_report.py`, `tools/stop_check.sh`, `tools/records.py` (the role-file front-matter lint), new `tools/test_agent_hooks.py`.
  - The working order's sections 4 (table row 7), 9 (`Teammates:` from the registry; the hand-over parts the hook checks) and 10 (the hooks and what they do not protect), through a PC-53 addendum.
- Registry: `LOG_DIR/<session_key>.agents`, JSON Lines, append-only, one record per event. Writes take `fcntl.flock` `LOCK_EX` on the file itself (as `log_decision` does); reads take `LOCK_SH` and fold by `agent_id`. Fixed keys: `time`, `event` (`launch|start|stop|session_start`), `agent_id`, `agent_type`, `name`, `item`, `form`, `tool_use_id`, `prompt_sha256`, `run` (the count of start records), `outcome` (`emitted|oversize|pass|block|could_not_check`), `missing` (part names), `receipt` (`present|late|absent|not_delivered`), `package` (`<role>@<sha12>`). It holds no text, nonce or nonce hash. No hash chain: B5 protects the directory, and the guard log and the transcript are the audit trail.
- Hook entries, each with a `"timeout"` of 15 and no `onFailure`:
  - SubagentStart and SubagentStop, matcher `^(producer|researcher|prober|checker|test-designer)$`.
  - PostToolUse, matcher `^(Agent|Task)$`.
  - SessionStart, matcher `startup|resume|clear|compact`, beside the existing compact entry.
  - Each command: `python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/agent_hooks.py" <Event> || true`.
  - The guard stays at index `[0]` of PreToolUse and PermissionRequest (`tools/test_tool_allowlist.sh:21-24` reads it there).
- SubagentStart output: on exit 0, stdout `{"hookSpecificOutput":{"hookEventName":"SubagentStart","additionalContext":TEXT}}`. TEXT is: the header line `DevOS role package: <role>@<sha12>`, the package file's bytes, `Your agent ID: <id>`, then `Nonce: <16 hex>` as the last line. If TEXT is over 9,500 bytes in UTF-8, the hook prints nothing and records `oversize`. A test pins that the three added lines fit in RESERVE for the longest role name and agent ID.
- SubagentStop output: if `stop_hook_active` is true, no output (the run ends) and a `pass` record. Otherwise it checks the parts of point 6, and on a miss prints `{"decision":"block","reason":R}`.
  - R is at most 1,000 characters, names the missing parts and the package path, and never holds the nonce.
  - Because R is always short, the "reason too long" fallback and its capability row are not needed.
  - First run against later runs: `run` from the registry. Later runs need at least `Received from / Returned to`, as the test designer pins. If the registry cannot be read, the result is `could_not_check`, and the run ends.
  - Output goes in one write at the end. A crash before it prints nothing, so the agent stops.
- SessionStart output: plain stdout, the header plus `executor.md`, and a `session_start` record with its source and `<sha12>`. PR-A2's limit already budgets the combined size with the compact message.
- PostToolUse output: none. It writes only a `launch` record.
- Liveness and lock-out:
  - The start hook cannot refuse a role: SubagentStart cannot block [V], and `|| true` turns every failure into no output. Worst case, the package is missing; with point 6 that costs no block, and the report shows it.
  - The stop hook cannot trap. There are four independent layers: `stop_hook_active` (stateless, so a registry fault cannot cause a second block), the platform's 8-continuation cap, `|| true` with JSON-only blocking (a missing script or a crash exits 0 with no output), and the 15 s timeout, which is non-blocking without `onFailure`.
  - The tests drive the commands read from `settings.json` with a missing script, a crash, malformed JSON and a timeout. In every case the agent stops.
  - The guard change is pure functions plus a refactor of `log_decision`, pinned by point 2's path test and the existing suite.
- `tools/guard_report.py` additions:
  - Every hook command path in settings exists.
  - A self-test of `agent_hooks.py` with `DEVOS_GUARD_LOG_DIR` set to a scratch directory: a Start gives the header first and the nonce last, at most 9,500 bytes; an incomplete Stop with `stop_hook_active` false gives a block; the same with true gives no output.
  - Per run: start, stop, outcome, receipt and item.
  - Flags: `NO_START` (an `agent_id` in the guard log without a start record; this covers hooks that never loaded), `BLOCK_NO_STOP` and `NOT_DELIVERED`.
  - The executor's SessionStart records and their hashes.
  - The excluded types named.
- `tools/stop_check.sh`: one check calling `guard_report.py --liveness`. Exceptions come from pinned lines `- **Liveness:** <agent id>: <reason>` in the newest log entry, read the way the Wait line is read. That line form goes in the PC addendum.
- Cost (my estimate from the code, not measured): about 40 lines in the guard, 200 in the hook script, 90 in guard_report, 12 in stop_check, 25 in records.py, 30 in settings; about 350 lines of tests; one producer, one test designer, one binding checker (floor: a hook that can block, and the guard).

(3) Smaller, joined, dropped, parallel
- Drop:
  - The `SubagentHandback` guard denial (point 3).
  - The mechanical staleness of capability rows in `guard_report.py`. It would need a machine-readable row format in EV records, a new mechanism, for what the opening check already does by reading the version.
  - The "SendMessage allows and denials, T5's rule IDs" output: `guard_report.py` already prints the allowed calls by rule and every denial.
  - The `Plan` case in `tools/test_tool_allowlist.sh`, which M1a adds (EV-C02-028 10.2).
  - The block-reason size row (see SubagentStop output above).
- Join W-C02-26 into this pull request (see W-C02-26 point 3).
- Parallel: this item's condition and approach can be written now. The build starts after PR-A2 (packages, constants) and M1a (`tool_allowlist.py` has one writer) merge. M1b can be built at the same time if it pre-adds the hook path to the trigger set ("Received from / Returned to" item 1).

**W-C02-26 (M3a: settings only)**

(1) View from my field
1. PROCEED: inert as planned. With `SendMessage` out of `permissions.deny`, T1 still denies it on PreToolUse and on PermissionRequest (`tool_allowlist.py:106-114, 2193-2194, 2308-2332`; test line 129). An `isolatePeerMachines` ask in this session is a PermissionRequest, which the guard decides.
2. MISSING_EVIDENCE: before W-C02-27, M3a's only purpose is the executor's raw schema read. That rests on a permissions change in `.claude/settings.json` taking effect mid-session; P-2 and 3.7 cover hooks, not permissions, and no 1.2 row exists. Needed: a row and a conditional recipe in the acceptance. After the sync, the executor searches for `SendMessage` with `ToolSearch`. Found: the schema is filed raw. Not found: W-C02-27's build waits for a new session (section 8, one line to Batu with options), and returns go by the hand-over meanwhile.
3. PREFERENCE: join M3a into M2's pull request. Both change the floor path `.claude/settings.json`, and M3a adds no lock-out surface. This saves one class-high verdict and one sync cycle (P-5), and the schema row can then be read right after M2's sync, which shortens W-C02-27's critical path.
4. PREFERENCE (EV-C02-028 10.2 disposition (8) reopens here): add no settings deny for `Workflow`, the built-in types or `Agent(fork)`. The guard already denies them and fails closed (`onFailure: block`). A second layer would protect only against a guard bug that allows them, which the guard's own tests pin, and every re-admission would then need two changes.

(2) Method, interfaces, liveness, cost
- `.claude/settings.json`: `"SendMessage"` removed from `permissions.deny`; top-level `"isolatePeerMachines": true`; `"ListAgents"` and `"crossSessionInbound": "refuse"` unchanged.
- `tools/test_tool_allowlist.sh`'s settings block (lines 33 to 41) asserts the four facts.
- The working order's section 10 line 211 (PC-45's sentence) is changed to say `SendMessage` left the settings layer, with a PC-45 annotation: the guard's T1, and from W-C02-27 T6, is its only layer. Lock-out: none, since nothing becomes reachable.
- Cost: 2 settings lines, one sentence, about 10 test lines.

(3) Smaller, joined, dropped, parallel: joined into W-C02-25 (point 3). It cannot be joined with W-C02-27, because T6's key list needs the schema, which can be read only after the deny goes.

**W-C02-27 (M3b: guard rule T6, the roles' `tools:` lines, the working order's text)**

(1) View from my field
1. PROCEED: the shape of T6 is right: IDs only, from this session's registry, `main` only from a non-null caller, and a producer reached only within its item.
2. DEFECT: "a producer's ID only from that item's consumers" has no machine-readable source; the approach's `consumer:` line is free text. Seen fixed when: the rule is mechanical. A caller may message a producer launched for item X only if the caller is `main` or its registry `launch` record carries `item` X (W-C02-25 point 8), and the message text holds that item's path. Synthetic cases: a checker launched with `Item:` X is allowed; with item Y or no item it is denied with T6's own rule ID.
3. DEFECT: the same resume route is open for the test designer, whose launch T5 also checks. A message to a finished test designer resumes it without an Agent call, for any item. Every route to the same effect should get the same decision (SDLC playbook F7, as the plan cites it). Seen fixed when: the producer rule covers every type T5 checks (`producer`, `test-designer`), and a synthetic case shows a non-`main` caller without the matching item denied when messaging a registered test-designer ID.
4. MISSING_EVIDENCE: `tests/C02/W-C02-22/breaks.py:246` (B19) treats `, SendMessage` added to a role's `tools:` line as a break, and W-C02-27 makes exactly that change. Needed (test designer's field): whether that suite is run again at later heads. If it is, W-C02-27's condition names B19 as a control that flips, changed in the same pull request; W-C02-22's acceptance stays tied to its own head, so nothing is loosened.
5. MISSING_EVIDENCE: whether an edited role file's `tools:` line takes effect for the next launch in the same session (R-01: not shown; W-C02-02 item 4 [R]: a role file added mid-session was not offered at once). Needed: the observation "the tool is present in a role", already first on 3.6b's list, made at the first launch after the sync, with a recipe for red (a new session, section 8). Until then, returns go by the hand-over.
6. PROCEED, with pins:
   - Any error inside T6 gives its own "could not check" (`T6.0`) and denies only that call. A missing or unreadable registry denies with "no registry for this session; return it in your hand-over's Received from / Returned to".
   - A message to the caller's own ID is denied, and so is `to: "main"` from `main`.
   - The input keys must be a subset of one constant taken from the executor's raw schema record, and a test compares the two.
   - `SendMessage` stays out of `LOCAL_TOOLS`, so L4 reads its whole input; a test sends a token-format string in a message and expects L4's denial.
7. PREFERENCE: keep the hint that maps a name to its ID in the denial, but expect it to fire rarely: `name` exists only if the executor sets it, and IDs travel in the `Teammates:` line.

(2) Method, interfaces, liveness, cost
- `tool_allowlist.py`: `SendMessage` added to `ALLOWED_NON_MCP` (not to `LOCAL_TOOLS`), and a `send_checks(data, args)` branch in `decide()` that uses `registry_read(data)` from W-C02-25. Rule IDs: `T6` (allow), one denial ID per refusal (name, unknown ID, list or empty value, extra key, self, `main` from `main`, producer or test designer outside its item, no registry), and `T6.0`.
- Runs unchanged on PermissionRequest through the shared `decide()`.
- `.claude/agents/*.md` `tools:` lines gain `SendMessage` for the five roles; `counter-designer` is unchanged.
- The working order's section 4 step 4 changes ("the guard denies resuming a helper" becomes the T6 rule, and same-checker scoped re-review becomes allowed), as do section 9's `Teammates:` line and section 10's T-rules, through a PC-53 addendum.
- Lock-out: T6 governs one tool. Its worst over-blocking is "no messaging", which is today's state, and the hand-over return is the fallback (3.7).
- Cost: about 90 guard lines, about 60 synthetic cases in `tools/test_tool_allowlist.sh`, 5 front-matter lines, the working-order text. One producer, one test designer, one binding checker (floor: the guard).

(3) Smaller, joined, dropped, parallel: no part to drop. Its triage can run now, with point 6's key list written as "the keys of the schema record at path P", filled in once M3a's row exists. The build comes after W-C02-25's merge (the registry functions; `tool_allowlist.py` has one writer).

**Order across the three:** PR-A2 and M1a, now. Then M1b, in parallel with the build of W-C02-25 + W-C02-26 as one pull request. Then the schema row and the "role file reloaded" row. Then W-C02-27.

**Files:** none written or deleted in any repository. Scratch only: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/web/hooks.md`, the official hooks page fetched for reading.

**Tests:**
- `python3 -I -c "import sys; sys.path.insert(0,'/home/user/devos/.claude/hooks'); import tool_allowlist"`, timed with Python's `time.monotonic`, three runs: exit 0, 0.052 s, 0.019 s, 0.024 s.
- `curl -sS --max-time 60 -o hooks.md https://code.claude.com/docs/en/hooks.md`: exit 0, 4,232 lines.
- No product tests exist yet; none were run.

**Where it ran:** both in this session's container, as this subagent. The import timing used `python3` 3.13.16 (`python3 --version`). The fetch used `curl` through the agent proxy.

Guard denials: none

## 3. The researcher's note (`ad67bb232bb50343b`), verbatim

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. The task holds. The source questions are bounded, and each answer feeds the items' approach blocks and the test designer's conditions. Depth: a primary-source re-read of the official pages today, plus the library route. I re-read the pages because EV-C02-023 section 3 is another agent's summary from this morning. Re-reading turned up four facts it does not carry and one parity mismatch. The library route was needed for the start, stop and messaging questions. I did not open the files Constraint (a) forbids, and I read Ek D only from line 69.

## Disciplines (D1–D9)
D1: yes: I kept apart what the pages state and what the plan assumes. Where an assumption could reverse a design choice (that the agent IDs are the same string, the size of a block reason, where a resumed agent's reply goes), I stated it conditionally and gave the observation that settles it.
D2: yes: the "finish today" pressure did not change any label. The ID-equality point stays missing evidence even though it costs a first-run observation.
D3: yes: each finding is shaped as a row the executor can drop into each item's approach and the test designer can turn into a condition, split by item.
D4: yes: everything here is [V] (documentation) or a single [O] from this session's guard log. I name which rows still need a live observation and claim no hook behaviour as observed.
D5: yes: I re-read the raw pages instead of relying on EV-C02-023's summary. That found four new facts (SubagentStop's `additionalContext`, the 8-continuation cap, SessionStart's `fork` source, the per-hook cap measurement) and the session-ID mismatch.
D6: no
D7: no
D8: yes: I confirmed `main` is at 449df84 and the library at 941f027. The session in this run's guard log differs from EV-C02-023's parity header; I report that to the executor below.
D9: yes: I read the library route the task named. Its findings justify the presence-only Stop check, the IDs-only rule and records over messages. They limit what start injection can claim. They change no platform fact; the harness study's own freshness note sends runtime questions to primary sources.

Read, and what each changed:
- Official pages, raw markdown fetched with curl at about 2026-10-20 10:47Z. The pages carry no version stamp, so the read date is their version; the session runs Claude Code 2.1.304 (EV-C02-023 section 1). Abbreviations used below:
  - H: https://code.claude.com/docs/en/hooks.md. Sections read: Matcher patterns, Common input fields, Exit code output, onFailure ("Block the action when a hook fails"), JSON output, Add context for Claude, SessionStart, PreToolUse "Agent", SubagentStart, SubagentStop, Stop input, Stop decision control, Workspace trust. Product; changed the work (four new facts).
  - SA: https://code.claude.com/docs/en/sub-agents.md. Sections: Available tools (background filter), What loads at startup (sibling roster), Resume subagents. Product.
  - CSM: https://code.claude.com/docs/en/cross-session-messaging.md. Sections: Message another session, Message delivery, Restrict cross-session messaging, Availability. Product; changed the work (container reach).
  - SR: https://code.claude.com/docs/en/settings-reference.md. Entries `crossSessionInbound` and `isolatePeerMachines`. Product.
  - TR: https://code.claude.com/docs/en/tools-reference.md. Rows `ListAgents`, `SendMessage`, `SubagentHandback`. Product.
  - permissions.md: fetched, grep found no `SendMessage` mention; bore on nothing.
  - changelog.md: fetched but not re-read. For changelog items I rely on EV-C02-023 section 3 [R].
- `/home/user/devos/plan/SB-COR_Correction_Plan.md` 3.1 to 3.7, E, F, G: defined the questions.
- `/home/user/devos/evidence/C02/EV-C02-023_platform_capability.md` (whole): the baseline I compared against; limited the work to deltas and confirmations.
- `/home/user/devos/evidence/C02/EV-C02-028_pra2_m1_triage.md`, grep only (registry, launch, SendMessage, SubagentStart): confirmed workflow agents' Start and Stop are "not stated". Part 10 was not read in full.
- `/home/user/devos/.claude/settings.json` (whole): the current deny list, `crossSessionInbound`, and the hooks in place (SessionStart matcher `compact` only; the PreToolUse wrapper exits 2 when it fails).
- `/home/user/devos/.claude/hooks/tool_allowlist.py`, grep only: `LOG_DIR` and the remote session-ID key.
- Guard log `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, last two records (#987 and #988): the observed `agent_id` format and `mode`; changed the work (ID format, session parity).
- `/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md` from line 69 (sections 3 and 3-full): set the method.
- Library at `/home/user/agentic-os-search` (941f027):
  - `research/INDEX.md` (classes, authority) and `research/studies/CATALOG.md` (grep): routing.
  - `[library id: multi-agent-patterns, its assessment file]` C3 to C5 (lines 799 to 832): justified the T6 producer clause and the Received/Returned lines.
  - `research/studies/superpowers/SOURCE-LEDGER-U03.md` (head) and `notes/U01B-host-delivery-and-continuity.md` (headings F07, F08, F12, line 113): limited what start injection can claim.
  - `[library id: context study, META]` freshness section, [library id: context study, file 03 (harness)] section 12 and F-HRN-07/08, [library id: context study, file 01] near line 571: justified the liveness re-test and records over messages.
  - `[library id: EXP-006, P4-01]` lines 1, 19, 34, 96, 101 and section 7 table rows 131 to 133: justified 3.3 and 3.4's division of labour; counter-points on messaging.
  - `[library id: EXP-006, S1-03]` K4: limited the work (a role's text is not its runtime conditions).
  - `research/studies/gastown/FINDINGS.md` grep (the claim/liveness point near line 35): counter-evidence for the registry.
- Deliberately not read: the forbidden files of Constraint (a); `plan/Installation_Working_Order.md`; `tools/guard_report.py`, `tools/stop_check.sh`, `tools/subagent_audit.py`, `tools/records.py`, `.claude/hooks/reread_after_compact.py` (code is the producer's and checker's field, not what the sources state); the workflows page; earlier versions of the pages.

Relied on:
- H "SubagentStart" (lines 2535 to 2569): fires at spawn, at a resume, and per message to an in-process teammate. Input adds only `agent_id` and `agent_type`. It cannot block. Output is `additionalContext`, added before the first prompt. On a later run the text is injected again only if the earlier copy is gone (for example after auto-compaction). For custom agents the matcher is the front-matter `name`, not the file name. Stated.
- H "SubagentStop" (2573 to 2604): input has `stop_hook_active`, `agent_id`, `agent_type`, `agent_transcript_path`, `last_assistant_message`. `decision: "block"` with a `reason`, or exit 2 with stderr, keeps the subagent running with the reason as its next instruction. `hookSpecificOutput.additionalContext` also keeps it running, as non-error feedback. Stated.
- H "Stop input" (2730 to 2732) and "Stop decision control" (2794 to 2811): `stop_hook_active` is true while continuing because of a stop hook. After eight consecutive continuations the next block is overridden; the count resets on any tool call; `CLAUDE_CODE_STOP_HOOK_BLOCK_CAP` raises it. The cap text sits under Stop; that it applies to SubagentStop is interpreted from H:2604 ("same decision control format") and H:2811 (the same loop protections).
- H "JSON output" (1042 to 1046): `additionalContext`, `systemMessage`, `initialUserMessage` and plain stdout are capped at 10,000 characters. Each field of each hook is measured on its own, even when several hooks run for the same event. Above the cap the text goes to a file, with the path and a preview of up to 2,000 characters; no setting raises it; Claude is not asked to read the file. `reason` is not in the list. Stated.
- H "Matcher patterns" (291 to 297, 312, 315): a matcher of letters, digits, `_`, `-`, spaces, `,` and `|` is an exact list; any other character makes it an unanchored JavaScript regex. Stated.
- H 2579 to 2581: internal agents report the session's agent name or an empty `agent_type`; a matcher naming types does not match an empty value. Stated.
- H "SessionStart" (1232 to 1256): sources are `startup`, `resume`, `clear`, `compact` and `fork` (`--fork-session`, `/fork`, `/branch`, moving a conversation to the background). Stated.
- H onFailure section (about 944 to 958): `onFailure` has no effect on Stop or SubagentStop hooks. H:802: an exit 2 with empty stdout and a "No such file" stderr is a non-blocking error. H exit-2 table (988, 999, 1000): exit 2 blocks on SubagentStop; on SubagentStart and SessionStart it only shows stderr to the user. Stated.
- H "Agent" under PreToolUse (about 1903 to 1925): input `prompt`, `description`, `subagent_type`, `model`. A foreground PostToolUse response has `agentId` and `content`. A background one has `status: async_launched`, `agentId`, `description`, `prompt`, `outputFile`, `resolvedModel`. Stated.
- H "Workspace trust" (4161 to 4166): interactive sessions hold back settings hooks until trust is accepted; `-p` and SDK sessions are treated as trusted. H:720: hook edits are "normally" picked up by the file watcher. Stated.
- SA:444: a background subagent keeps `SendMessage` and `ToolSearch`. Stated.
- SA:1107: the sibling roster lists `main` and named agents by name, only if the subagent has `SendMessage` and another agent is named; it is a snapshot at start. Stated.
- SA:1131: `SendMessage` uses `to` (an ID or a name); it does not need agent teams, except for structured team-protocol messages. The same tool reaches the user's other sessions where cross-session messaging is on. Stated.
- SA:1143: a message to a completed subagent resumes it in the background without an Agent call; the same holds once a TaskStop-stopped run has exited. SA:1147: a user-stopped agent is refused. Stated.
- SA:1145: in an interactive session the resumed agent reports to the subagent that resumed it. Stated (interactive only).
- SA:1153: a name is checked against the agent it reached earlier; IDs are advised. SA:1157: transcripts are named `agent-{agentId}.jsonl`. Stated.
- TR:49: `SendMessage` takes an optional `summary`, previewed and truncated past 200 characters. CSM:92: it takes `notify_when_idle`. The full input schema is not on the pages. Stated.
- TR:36: `ListAgents` lists the session's subagents, local sessions and, with Remote Control, cloud and remote sessions. Stated.
- CSM:284 to 300: deny rules take the bare names `SendMessage` and `ListAgents`; denying `SendMessage` also removes messaging to subagents. A project-level `refuse` applies over every other source. Stated.
- CSM:272 to 282 and SR:5138 to 5154: `isolatePeerMachines: true` asks for approval before a message leaves this machine, even in `bypassPermissions`. A `true` from any scope applies. There is no prompt for same-machine messages. Stated.
- CSM 149 to 153: a session in a container and one on the host cannot reach each other; two sessions in the same container can. CSM:312: sessions beyond this machine are found only from a session connected to Remote Control. Stated.
- SR:5098 to 5115: `crossSessionInbound` takes `accept`, `hold` or `refuse`; a project value applies only when stricter. Stated.
- Guard log #988: this subagent's `agent_id` is a 17-character hex string; `mode` is `default`; the session key is `session_01JDJ8fJQmrKpXfiRh1yEoxv`. Observed.
- EV-C02-023 line 15 names session `session_01JPgLGMqfEiAks5dTpBsCdB`. Observed (the record). That this run is in a different session than the parity header is inferred from the two.

Unsure:
- Whether the `agent_id` given to SubagentStart and SubagentStop, the `agentId` in PostToolUse on Agent, the guard's `agent_id` and the form `SendMessage`'s `to` accepts are the same string. The doc examples differ ("agent-abc123", "def456", "a4d2c8f1e0b3a297"); only the guard's form is observed. Settled by the first live run's Start, PostToolUse and guard records for one agent.
- Whether this cloud session counts as interactive or `-p`/SDK. That decides the trust rule (already met in practice: the guard runs) and the reply route for a resumed agent. Settled by the prober's planned observation.
- The size limit of a SubagentStop `reason`: not stated.
- Whether the 8-continuation cap applies to SubagentStop exactly as to Stop: interpreted, not stated.
- Whether this cloud session is connected to Remote Control, which decides whether other machines are reachable at all: not stated, not observed.
- The order in which SubagentStart and PostToolUse on a background Agent fire: not stated.
- Whether SubagentStart and SubagentStop fire for workflow agents: not stated (as EV-C02-028 also records).
- The changelog was not re-read today.

For: the executor, who integrates these rows into each item's approach block (W-C02-25, W-C02-26, W-C02-27) with a disposition across fields; then the test designer (fixtures and break cases must use observed forms, not the docs' examples), the producer and each binding checker (which claims are [V] and which still need [O]).

Received from / Returned to: none taken or returned. One point outside my scope, reported to the executor and not acted on: EV-C02-023's parity header (line 15) names session `session_01JPgLGMqfEiAks5dTpBsCdB`, but this run's guard log is keyed `session_01JDJ8fJQmrKpXfiRh1yEoxv` (#987, #988). By that record's own rule (line 11), rows made in another session do not count. R-01 to R-03, and any condition resting on them, may need re-stating for the current session. That is the executor's call, as the owner of EV-C02-023.

Product:

**Question** and the decision it serves. For each of M2 (W-C02-25), M3a (W-C02-26) and M3b (W-C02-27): what the official pages state today about the platform facts each rests on, what the library says on start-time injection, stop-time hand-over checks and agents messaging each other, and where each item can be smaller, joined or run in parallel. This serves the executor's decision on one approach per item, and the test designer's conditions.

**Findings.** Labels: [V] is a page statement read 2026-10-20 (page abbreviations as listed under "Read" above); [O] is observed here; [I] is my inference.

W-C02-25 (M2)

(1) View from my field
1. PROCEED: SubagentStart as the package carrier. The input is only `agent_id` and `agent_type` [V H "SubagentStart input"]; output is `additionalContext` before the first prompt; it cannot block. It fires again on a resume, and re-injects only when the earlier copy is gone [V H:2535, 2569]. That fits a per-agent nonce reused on resumes.
2. DEFECT: the SessionStart matcher `startup|resume|clear|compact` leaves out `fork` [V H:1240, 1256]. An executor session forked with `/branch`, `/fork` or `--fork-session` would start without its package. Fixed when: the settings entry has no matcher or includes `fork`, and a test drives a `source: "fork"` input through the command read from `settings.json`.
3. PROCEED (stricter than needed): the 9,500-byte limit. The cap is 10,000 characters; bytes are never fewer than characters, so the limit is safe [V H "JSON output"]. Each hook's field is measured on its own, even with several hooks on one event [V H:1044]. So 3.3's "combined output under 9,500" between the existing re-read hook and the new SessionStart hook is not a platform need. See (3).
4. PREFERENCE: return SubagentStop's check as `hookSpecificOutput.additionalContext` rather than `decision: "block"` with a `reason`. Both keep the subagent running [V H:2604]. `additionalContext` has a documented cap and preview [V H:1042 to 1046], while `reason`'s limit is not stated. It also shows as "Stop hook feedback" with no hook-error notice [V H:2811]. This makes 3.7's "block reason too long" fallback moot and closes the open 1.2 row by documentation. Whether the model treats feedback text as firmly as a block is not stated [I]; the first live block would show it.
5. PROCEED, with a guard to add: one block per run. The platform also has `stop_hook_active` and an 8-consecutive-continuation backstop [V H:2730 to 2732; applied to SubagentStop by interpretation]. The hook should never block when `stop_hook_active` is true. That is a second, documented way to make "never traps an agent" hold.
6. PROCEED, with a test note: `onFailure` has no effect on SubagentStop. Exit 2 there sends the agent back; a missing script with ENOENT on stderr and empty stdout is non-blocking [V H onFailure section, H:802]. So the Stop hook's command must not reuse the PreToolUse wrapper in `settings.json`, which exits 2 when it fails [O settings.json]. 3.4's tests (missing script, crash, malformed input) cover this if they drive the command from `settings.json`.
7. PROCEED: the matcher. The anchored `^(producer|researcher|prober|checker|test-designer)$` takes the regex path and matches whole names [V H "Matcher patterns"]. The bare list `producer|researcher|prober|checker|test-designer` is an exact list and equally correct. The type compared is each role file's front-matter `name` [V H:2535]. Tests should include an empty `agent_type` (internal agents [V H:2579 to 2581]) and a near-miss such as `producer-x`.
8. MISSING_EVIDENCE: that SubagentStart's `agent_id`, PostToolUse-on-Agent's `agentId` and the guard's `agent_id` are one string. The registry joins on it and T6 compares against it. The docs' examples differ; the guard's form is a 17-character hex string [O guard #988]. Fixed when: the first live role run shows the same value in its Start record, its PostToolUse record and its guard records. Fixtures must use that observed form. Not a blocker for writing code; it must be named in the acceptance condition.
9. PROCEED: the registry's sources. The item for a producer can only come from the Agent call (PreToolUse `prompt` [V H "Agent"], or a background PostToolUse's `prompt` [V H:1925]); SubagentStart carries no prompt. The order of SubagentStart and PostToolUse is not stated, so the writer must accept either order under `flock` [I].
10. PREFERENCE: the `SubagentHandback` branch of 3.4 applies only in auto mode [V TR:53; H:2583]. This run is `default` [O #988]. If the working order already keeps role launches out of named auto windows, the branch can be dropped, with that limit stated.

(2) Role-specific ask, M2

| Platform fact | Stated? | Source |
|---|---|---|
| SubagentStart input | `agent_id`, `agent_type` only | [V] H "SubagentStart input" |
| SubagentStart output | `additionalContext` | [V] H 2554 to 2558 |
| SubagentStart blocking | cannot block; exit 2 shows stderr to the user only | [V] H 2554; exit-2 table, 999 |
| SubagentStart firing | spawn, resume, per teammate message | [V] H 2535 |
| SubagentStart re-injection | only when the earlier copy is gone | [V] H 2569 |
| Output cap | 10,000 characters per field per hook; file plus 2,000-character preview; no setting; Claude not asked to read the file | [V] H "JSON output" 1042 to 1046 |
| SubagentStop input | `last_assistant_message`, `agent_transcript_path`, `stop_hook_active` | [V] H 2577 |
| SubagentStop block | honoured: the agent keeps running with the reason as its next instruction | [V] H 2604, "Stop decision control" |
| SubagentStop feedback | `additionalContext` also keeps it running | [V] H 2604, 2811 |
| SubagentStop loop cap | 8 consecutive continuations | [V] H 2732 (applies to SubagentStop by interpretation) |
| `reason` size limit | not stated | windows read: H "JSON output", "Stop decision control", "SubagentStop" |
| Matcher for custom agents | front-matter `name`; exact-list versus regex rules | [V] H 2535, "Matcher patterns" 291 to 297 |
| Internal agents | empty `agent_type` | [V] H 2579 to 2581 |
| SessionStart sources | `startup`, `resume`, `clear`, `compact`, `fork` | [V] H 1234 to 1240, 1256 |
| `onFailure` | no effect on SubagentStop | [V] H onFailure section |
| Workflow agents and Start/Stop | not stated | windows: H "SubagentStart", "SubagentStop" |

Library on start-time injection:
- Superpowers U01B separates delivery, discovery, invocation and execution (F07), and gives re-injection and refresh different lifetimes (F08). Its suggested questions run from "what reached the actor" through "what was actually done" (line 113). This supports 3.3's narrow claim (the text arrived and its last line was echoed, not that it was applied).
- EXP-006 P4-01's section 7 table gives SubagentStart role and task identity and context, explicitly not a creation gate. This is a historical draft, per its own line 1.
- S1-03 K4 notes that a role's written definition is not the same as its real tools and session conditions; this is historical and was not re-tested.
- The harness study's F-HRN-08 says harness parts carry model-specific assumptions and need re-testing after upgrades. That supports 3.5's staleness on a version change.

Library on stop-time hand-over checks:
- P4-01 section 7 keeps two things apart: keeping a child running, and delivering its result to the parent. It says the background return route must be observed on the target. It wants Stop-time checks bounded and never looping.
- Multi-agent C5 asks what failure would turn a critic red. Superpowers U03 (S37) treats a report's own claims as unverified.
- Both support 3.4 checking presence only, with content left to the consumer.

Counter-evidence on liveness: gastown FINDINGS (near line 35) separates a claim from liveness. A registry record shows an agent was registered, not that it is alive or delivered anything. 3.5's per-run Start and Stop pairing addresses this; the registry alone would not.

(3) Smaller, joined or dropped; parallel
- Drop the "combined SessionStart output" limit: per-hook is the documented measure.
- With item 4 taken, drop 3.7's "block reason too long" fallback.
- Item 10 may drop the handback branch.
- Parallel: fix the registry file's line format first (fields, ID form placeholder, `flock`); then the start and stop hooks, the liveness checks, and M3b's T6 code and tests can be written in parallel.

W-C02-26 (M3a)

(1) View from my field
1. PROCEED: removing the `SendMessage` deny. A deny takes the bare name and removes subagent messaging too [V CSM:287, 300], so the item is needed for M3b at all.
2. PROCEED: `isolatePeerMachines: true`. It asks before a message leaves this machine, even in bypass mode; a project `true` cannot be turned off below; there is no prompt on the same machine [V SR:5138 to 5154; CSM:272 to 282]. In this container, "the same machine" means sessions inside this container only. A container and its host cannot reach each other [V CSM:149 to 153]. So the uncovered same-machine set is narrow here [I]; T6 remains the main layer, as 3.6b says.
3. PROCEED: keep `crossSessionInbound: "refuse"` (a project `refuse` wins over every other source [V CSM:286; SR:5115]) and keep `ListAgents` denied. `ListAgents` is the discovery tool for other sessions [V TR:36]; the in-session roster does not need it [V SA:1107].
4. PROCEED: the schema row after the deny is removed. The pages show `to`, `summary` and `notify_when_idle` but not the full input [V SA:1131, TR:49, CSM:92]. While denied, the tool is removed, so the schema cannot be loaded before M3a [V CSM:300; I].

(2) Role-specific ask, M3a

| Platform fact | Stated? | Source |
|---|---|---|
| `permissions.deny` for `SendMessage` | bare name; also removes subagent messaging | [V] CSM "Turn off cross-session messaging" 284 to 300 |
| `isolatePeerMachines` | as in item 2 above | [V] SR "isolatePeerMachines"; CSM "Require approval for cross-machine messages" |
| `crossSessionInbound` | `accept`/`hold`/`refuse`; precedence; project `refuse` wins | [V] SR "crossSessionInbound"; CSM:286 |
| Whether this cloud session is connected to Remote Control (and so can reach other machines at all) | not stated | windows: CSM "Availability" |

Library on messaging: P4-01 (historical) treats messaging as a temporary carrier that does not replace the durable work record (line 101). That supports keeping the deny's replacement narrow.

(3) Smaller, joined; parallel. Join M3a into M2's pull request. Both edit `.claude/settings.json`; M3a makes nothing reachable (T1 still denies `SendMessage` [O settings and guard]). Order still forces "M3a, sync, schema, M3b", but joining saves one pull request and one binding verdict, and lets the schema row be filed while M3b is being built. The PC-45 note on working order section 10 travels with it. Lock-out risk does not grow: the guard is unchanged [I].

W-C02-27 (M3b)

(1) View from my field
1. MISSING_EVIDENCE: the `SendMessage` input schema (the body field's name and type; whether `message` can be a structured object). T6's key allowlist must come from the loaded schema, not from the pages. Fixed when the raw schema row is filed (3.6a). Structured team-protocol messages need agent teams [V SA:1131]; T6 should deny them. `notify_when_idle` concerns watching other sessions [V CSM:92]; T6 should deny it unless the schema row shows a use inside the session [I].
2. MISSING_EVIDENCE: the same ID-equality point as M2 item 8. T6 compares `to` with registry IDs. The pages accept "an agent ID or name" but do not fix the form: transcripts are `agent-{agentId}.jsonl` [V SA:1157], while H's example is "agent-abc123". T6 must not normalise a prefix on a guess. Fixed when the first allowed message's guard record shows the `to` value equal to the registry ID.
3. PROCEED: the producer clause. A message to a finished subagent resumes it with no Agent call [V SA:1143], so T5 would not see it. SubagentStart does fire on a resume [V H:2535], so M2's start record covers resumed runs. The resumed run keeps its first tool set [V SA:1143]; a user-stopped agent is refused [V SA:1147].
4. PROCEED: IDs only. A name is re-checked against its earlier target and IDs are advised [V SA:1153]. Names given before a compaction need the ID (2.1.299 fix [R: EV-C02-023 section 3]). The roster lists names, not IDs [V SA:1107], so IDs travel in `Teammates:`. 3.7's fallback is now the expected route, not a fallback.
5. PROCEED: adding `SendMessage` to the roles' `tools:` lines. Background subagents keep `SendMessage` [V SA:444]. Whether the tool is deferred, needing `ToolSearch`, is not stated; 3.7's fallback covers that.
6. PREFERENCE, open: the reply route for a resumed sibling. "Reports to the subagent that resumed it" is stated for interactive sessions only [V SA:1145]; which kind this cloud session is remains unknown. Already a prober observation with a fallback in 3.7; not blocking.

(2) Role-specific ask, M3b

| Platform fact | Stated? | Source |
|---|---|---|
| `SendMessage` target field | `to` (ID or name) | [V] SA "Resume subagents" 1131 |
| Other input keys | `summary` | [V] TR `SendMessage` row |
| | `notify_when_idle` | [V] CSM 92 |
| Body field and full schema | not stated | windows: SA "Resume subagents", TR tools table, CSM "Message another session" |
| Resume by message | stated; also after TaskStop once exited; user-stopped refused | [V] SA 1143, 1147 |
| Reply route | interactive only | [V] SA 1145 |
| Sibling roster | names, snapshot | [V] SA 1107 |

Library on agents messaging each other:
- In favour, historical: EXP-006 P4-01 lines 19 and 96 plan direct messages to existing named roles.
- Counter-condition: P4-01 line 34 says the team alternative is reopened only on lost contributions or constant user messages, and that parallelism alone is no reason. The plan records that trigger as fired (L-426), which is the executor's record, not mine to re-judge.
- Multi-agent C3 asks parallel branches for an explicit merge contract and provenance; the Received/Returned lines carry that. C4 says a spawn ability must not silently widen scope or capability; a resuming message is spawn-like [I], so T6's producer clause is consistent with C4.
- The harness study (01, near line 571) lists critical detail lost in subagent hand-off. P4-01 line 101 says messages are temporary carriers. Both support "messages are not records" (3.6).

(3) Smaller; parallel
- Smaller alternative (PREFERENCE): instead of binding producer IDs to items through T5's launch record, deny every `SendMessage` whose `to` is a producer ID ("launch a new producer; T5 checks it"). This removes T6's dependency on T5's recorded item and one test family. The cost is that a fix round cannot resume a producer with its context. The executor weighs that against today's deadline.
- The "name held once gets its ID in the denial" convenience can be dropped too, since IDs travel in `Teammates:`.
- Parallel: T6's code and planted synthetic tests can be written alongside M2 once the registry line format is fixed. Only the key allowlist waits for the schema row.

**Counter-evidence and alternatives.**
- Bypassing `SubagentStart` entirely: the 3.7 fallback (the guard requires the role file byte for byte in the prompt) rests only on PreToolUse on Agent, which is observed. It would avoid the ID-equality question for start delivery, at the cost of prompt size.
- `additionalContext` against `block` on Stop: whether a model treats feedback as firmly as a block is not stated.
- Gastown's claim/liveness split: the registry is not proof of life.
- P4-01's reopen condition: parallelism alone does not justify messaging.
- Superpowers F12: re-entering a procedure is not recovering the work. Re-injection after compaction does not restore what a run had done.

**For the decision.**
- New since EV-C02-023: SessionStart's `fork` source (a defect in 3.3's matcher list); SubagentStop's `additionalContext` with a documented cap (can replace `reason` and drop a fallback); the 8-continuation backstop and `stop_hook_active` (a second guard against trapping); the per-hook, per-field cap measurement (drops the combined-size limit); the container's reach (narrows what `isolatePeerMachines` leaves uncovered here).
- Blocking items: one shared missing-evidence point (ID equality across Start, PostToolUse, guard and `to`), and M3b's schema row. Both need first-run or schema observations named in the acceptance conditions.
- To fit today: join M3a into M2. Fix the registry line format first so M2 and M3b can be built in parallel.

Guard denials:
- G0 (readable call), decision log #882: a shell grep with an unbalanced backtick in its pattern. Instead I repeated the search with the Grep tool. I could not record it with `tools/guard_report.py` (read-only role); the executor may record it from the log.

## 4. The prober's note (`abc86b55790c7fd15`), verbatim

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. The task asks me to triage three items from the platform side and to say which observations can be made now. That holds. The inputs could be read, and the observations it asks for need only this session's own agents and files. One thing I must report first: I broke the reading-order constraint (a) twice. Details are under "Received from / Returned to".

## Disciplines (D1–D9)
D1: yes: the plan puts M3a before M3b because the `SendMessage` schema could only be read after the settings deny is removed; I found the installed code already gives the input keys, so I propose a different split and state it conditionally.
D2: uncertain: there is pressure to finish today (2026-10-20), so I lowered no observation to fit the day and named each live row that may only be seeable in the next session.
D3: yes: for each mechanism I followed the chain past "merged" to the point where its live row can actually be seen (settings picked up, role files reloaded), which is where two of the defects below come from.
D4: yes: for every unobserved fact I wrote the discriminating observation, the negative control and what each outcome selects before observing, and I flagged one liveness check that would go red on a sound case.
D5: yes: I went back to the primary surfaces (this session's guard log records, the platform's meta files, the installed binary's text) instead of EV-C02-023's summary, and labelled the binary reading as code text, not the tool definition a model is shown.
D6: no
D7: no
D8: yes: I confirmed `main` is 449df84, that this session (`session_01JDJ8fJQmrKpXfiRh1yEoxv`) is not the one in EV-C02-023's parity header, and that `.claude/roles/` does not exist, before relying on any row.
D9: yes: I read gstack CORE (P5 to P7, F2 to F4), ecc METHOD-CASE (section 4, case B; section 6 table) and the work-environment vertical's KEY; they supported the small discriminating observations with negative controls, the point that a registered hook is not a hook that runs, and naming the session's source configuration as part of the counted environment.

Read, and what each changed:
- `plan/SB-COR_Correction_Plan.md`, read in full: it defined the rows and the fallbacks I checked (P-2, P-3, P-8, 1.2, 3.2 to 3.7, E, G).
- `evidence/C02/EV-C02-023_platform_capability.md`, read in full: gave the labels. Its rows R-01 to R-03 come from another session, and its section 3 holds the [V] items 2.1 to 2.22 I cite.
- `evidence/C02/EV-C02-028_pra2_m1_triage.md`: part 10 (lines 2634 to 2670) in full, plus a grep for session IDs. It gave PR-A2's and M1's agreed constants and T5's outcome table. It also showed that the session change and my B7 slip are already-known failure classes (lines 615, 668, 672).
- `.claude/settings.json`, read in full: no `isolatePeerMachines`; `SendMessage` and `ListAgents` denied; SessionStart only on `compact`; PostToolUse only on two remote tools.
- `.claude/hooks/tool_allowlist.py`, lines 96 to 135 and 2240 to 2345: `SendMessage` is denied by omission from `ALLOWED_NON_MCP` (lines 106 to 114). The log key is the normalised `CLAUDE_CODE_REMOTE_SESSION_ID`, else the input `session_id` (lines 2260 to 2261). The log does not record `agent_type`.
- `.claude/hooks/reread_after_compact.py`, `tools/guard_report.py`, `tools/stop_check.sh`, all read in full; `tools/subagent_audit.py`, lines 1 to 60: the transcript and meta layout, and the rule that the end is not marked in a subagent's own transcript.
- `tools/test_tool_allowlist.sh`, grep only: lines 28 and 129 assert the `SendMessage` deny.
- `plan/Installation_Working_Order.md`, grep only: lines 51, 56, 209 and 211. Line 51's text on resuming a helper changes with M3b.
- `plan/ledger/C02-log.md`: L-439 by grep, and line 1577. This session started with devos as its only source and the library was attached mid-session; PR-A1 got a new session because mid-session loading of role files is not shown.
- `evidence/C02/EV-C02-006_session_tools_bridge.md`, lines 150, 152, 218 and 298: a deny changed mid-session may leave definitions the model already saw unchanged; `refuse` cannot be confirmed from inside the session.
- `evidence/C01/EV-C01-016_W-C01-37_row9_hooks_one_repository.md`, line 73: hooks do not load in a session that has several repositories.
- `evidence/C01/EV-C01-017_W-C01-38_guard_fails_closed.md`, line 194: on SubagentStop, exit 2 sends the agent back to work.
- `plan/Ek_D_Dusunme_Protokolleri.md`, lines 69 to 128 and 151 to 340: the method. (A heading grep also touched earlier lines; see below.)
- Library at 941f027: gstack `CORE.md` lines 410 to 467 (P5 to P7, F2 to F4); ecc `METHOD-CASE.md` (grep: sections 3, 4 and 6); work-environment `KEY.md` in full. These justified the method and changed no facts.
- This session's own records: guard log records #1, #83, #854 and #886, plus agent-ID and event counts; the 20 `agent-*.meta.json` files under `/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/subagents/`; a grep of the installed binary `/opt/claude-code/bin/claude` (read only, never run).
- Deliberately not read: my own agent file, `CLAUDE.md` (it arrived as context), PC-53, W-C02-22, EV-C02-026 (but see the breach below), and the web pages (I re-checked no [V] row against today's pages; EV-C02-023 section 3 did that today).

Relied on:
- This session's hook input for a subagent's PreToolUse carries the main session's `session_id` (`e177dd92-…`) and the env session ID. Observed: guard log #1 (main, `agent_id` null) against #854 and #886 (`agent_id` `abc86b55790c7fd15`, me).
- An internal agent with a non-null `agent_id` (`a09ec86c0620c940f`) made one guard-visible call (`ScheduleWakeup`, denied by T1, 09:18:32Z) and has no transcript or meta under `subagents/`. Observed: guard log #83 and a directory listing.
- The platform writes a session-scoped meta file per role run, holding `agentType`, `toolUseId`, `requestShape: background`, `requestNonInteractive: true`, `spawnDepth: 1`. All 20 role runs of this session have one, and all 20 are background. Observed: the meta files.
- No workflow agents in this session (there is no `subagents/workflows/` directory). Observed.
- No `SendMessage` and no `SubagentHandback` records in this session's guard log; 1,055 PreToolUse records and 1 PermissionRequest. Observed.
- The installed binary's text names the `SendMessage` input keys `to`, `message` and `notify_when_idle`. It also has a normaliser that deletes the legacy keys `type`, `recipient`, `recipient_kind`, `content`, `request_id` and `approve`. Observed in code text, not as a tool definition presented to a model. The version is taken as 2.1.304 from L-439 (stated); I did not observe it.
- The guard log and the registry are container-local: only this session's log is in `/tmp/devos-guard/`. Observed.
- The guard denies `SendMessage` through T1 by omission. Observed in code (`tool_allowlist.py` lines 106 to 114, test line 129).
- The SubagentStart, SubagentStop, cap, re-injection, PostToolUse-shape, `SendMessage`-deny and resume facts are stated, as EV-C02-023 section 3 items 2.2 to 2.21 give them [V].
- Mid-session loading of role files is not shown (EV-C02-023 R-01's note; C02-log line 1577). Stated, from the record.
- Hooks do not load in a session with several repositories (EV-C01-016 line 73). Stated.
- `requestNonInteractive: true` means the "interactive session" route for a resumed agent's reply may not apply here. Interpreted.

Unsure:
- The Claude Code version: not observed by me (B7). The executor's `get_session` settles it.
- Whether settings changes are picked up after a mid-session library attach: undocumented and unobserved. M2's first launch after sync settles it (observation A below).
- Whether the platform's legacy-key normaliser runs before or after PreToolUse: unobserved. The first natural `SendMessage` record settles it; T6 denying unknown keys is safe either way.
- Whether `SendMessage` is a deferred tool for roles: unobserved. M3b's first role run settles it, if the discriminator in W-C02-27 point 1 is built.
- Whether this run counts for W-C02-22 point 10, given the breach below: the executor's and test designer's call.

For: the executor, who integrates these points into the approach blocks of W-C02-25 to W-C02-27 with dispositions where it decides across fields. Then the test designer, who pins the observations and controls into each condition's "if row X shows Y" recipes, and the producer and binding checkers.

Received from / Returned to:
- Constraint (a) was breached twice, reported so the executor can decide on counting.
  - (1) A Grep for "file watcher|mid-session" with the globs `plan/work/*.md` and `evidence/**/*.md` covered `plan/work/W-C02-22.md` and `evidence/C02/EV-C02-026_pra1_triage.md`. Its output was file names only; I opened no content of either.
  - (2) A heading Grep over the whole of `plan/Ek_D_Dusunme_Protokolleri.md` returned heading lines 1 to 49 (headings only, the common-floor heading among them) before I read from line 69.
- To the executor, outside my field: working order line 51 says the guard denies resuming a helper, so a fresh helper is the only route. That becomes false when M3b allows resumes, and it interacts with M2's stop-hook block. It needs M3b's working-order text.
- To the executor, already known (EV-C02-028 lines 615 and 672): EV-C02-023's parity header and its rows R-03 onward are from another session.
- No teammate requests were received; none returned.

Product:

**Test and claim.** This is a triage, not a run of a pre-written test, so no pass criteria apply. Each observation below is written before observing. The observations I made now are self-observations of this session's own files at their first natural occurrence; nothing was planted. Environment: 2026-10-20, about 10:47 to 11:05 UTC; `main` 449df84316b3bd4dd12e48c48b53d274a59cb983, clean tree; session `session_01JDJ8fJQmrKpXfiRh1yEoxv` (local `e177dd92-42b7-5480-8039-2655653745ba`); model claude-opus-5-5 (stated by the system); Claude Code version not observed (2.1.304 per L-439); guard mode recorded `default` for my calls, effort `high`.

**Steps** (exit codes were not echoed; each output shown is complete unless noted):
- S1. `ls .claude/roles/`, `git rev-parse HEAD`, `ls plan/work`, `ls evidence/C02`, `.claude/protocols`, `date -u`. Result: `.claude/roles/` absent; HEAD 449df84; W-C02-25 to W-C02-27 are not files on `main`; `.claude/protocols/` absent; 10:47:09Z. (My first form of this command also had a version read and was denied, #854.)
- S2. Guard log record #1, Read with limit 1: main session, 09:13:39Z, `acceptEdits`, with `session` and `local_session` as above.
- S3. `sed -n '854p;886p'` on the guard log: my records carry `agent_id` `abc86b55790c7fd15` and the same `session` and `local_session` as #1.
- S4. My own `agent-abc86b55790c7fd15.meta.json`: `agentType` prober, `requestShape` background, `requestNonInteractive` true, `spawnDepth` 1, `toolUseId` present.
- S5. Agent IDs in the guard log (21) against meta files (20), and #83: one ID, `a09ec86c0620c940f`, has no meta or transcript (`ScheduleWakeup`, T1 deny). All 20 role runs are background. The script's second "without a meta file" list was wrong (an `ls` exit-code bug) and was superseded by the direct check of `a09ec86c0620c940f`.
- S6. `ls -d ~/.claude/projects/*/*/`: the session directory equals `local_session`.
- S7. Guard-log counts: 0 `SendMessage`, 0 `SubagentHandback`, 1,055 PreToolUse, 1 PermissionRequest.
- S8. Grep of `/opt/claude-code/bin/claude` for the `SendMessage` definition and `notify_when_idle`: the key names and normaliser as stated under Relied on.

**Not run:** any hook-dependent observation (no SubagentStart, SubagentStop, PostToolUse-on-Agent or SessionStart-on-startup hook exists yet); any `SendMessage` or `ToolSearch` call (I hold neither, and the deny is in force); any synthetic run of the guard (the tests cover it, and it is the build's job).

**W-C02-25 (M2)**

(1) View from my field
1. DEFECT: plan 3.5's liveness check, "a guard-log `agent_id` with no registry Start record", and `stop_check.sh`'s failure on it would go red on a sound session. This session already has an internal agent with a non-null `agent_id` and no subagent files (#83). The guard log has no `agent_type`, so "internal agents excluded" cannot be applied as written. Shown fixed when: the liveness report, run on a fixture copied from this session's shape, classes an ID with no `subagents/` meta as "internal, excluded" and still fails a fixture role ID that has a meta file but no Start record. The method is the producer's: a meta cross-check, or the guard logging `agent_type`.
2. DEFECT: 3.7 has no branch for "SubagentStop fires but `last_assistant_message` is not the report", although 1.2 lists that row. A transcript can end with a tool call after the last text (`subagent_audit.py` lines 15 to 17). Shown fixed when: the condition's recipe reads "if the hashes differ, the hook reads `agent_transcript_path` (EV-C02-023 item 2.7) with `subagent_audit.py`'s `last` logic".
3. DEFECT: an empty registry would make the stop hook block a sound report. The registry and its nonce hashes are container-local (S5 and S7 context; the 2.1.300 changelog entry on container replacement). After a replacement, a resumed agent has no registry record, so "nonce missing" would block it and then count it as a late delivery. Shown fixed when: a test with no registry record and a complete report gives no block and one "could not check: no registry record" line.
4. PREFERENCE: drop the "block reason size" row by design. Cap the reason at a small size (path only, for example 1,000 bytes or less) with a static test. The undocumented limit (item 2.8) then stops mattering, and 3.7's "reason too long" fallback becomes the design.
5. PREFERENCE: drop 3.4's SubagentHandback branch. It changes the guard (a lock-out surface) for Auto windows only (item 2.9), and this session has none (S7). A line in the window rule would do instead: no role run is launched or running across an Auto window.
6. PREFERENCE (another method for 3.2): the platform already writes a session-scoped record per agent, the meta file (S4 to S6). Use it as the registry's cross-check and as 3.7's discriminator: meta present with no hook record means settings were not picked up, while no meta means the launch failed. It is undocumented, so mark it stale on a version change; `subagent_audit.py` has relied on it since 2026-10-06.
7. PROCEED on keying: the guard's key function gives one file for main and for roles (S2, S3). The Start and Stop hooks should record both keys, because their env is unobserved [I].
8. PROCEED, with a requirement on the counted environment: it must name this session's configuration, "devos only at start, library attached mid-session". Hooks do not load with several repositories at start, and after a worker restart the session may start with two sources.

(2) Platform facts M2 rests on
| Fact | Label | Settled by |
|---|---|---|
| F1 SubagentStart fires for a background role | [V 2.2] | A |
| F2 its context reaches the model | [V 2.2] | B |
| F3 settings hooks are picked up mid-session | [V, "normally"; P-2] | A |
| F4 SubagentStop fires on the anchored matcher | [V 2.6] | C |
| F5 a block is honoured | [V 2.7] | D |
| F6 `last_assistant_message` equals the report | [V field] | C |
| F7 the size limit of a block reason | undocumented | not needed if point 4 is taken |
| F8 the shape of a PostToolUse-on-Agent record | [V 2.11] | A |
| F9 the hook `session_id` against the guard key | [O] for PreToolUse (S2, S3); [I] for Start and Stop | E |
| F10 SessionStart `source` values | unobserved (N-193) | F |
| F11 the 10,000-character cap | [V 2.4] | synthetic size test only |
| F12 re-injection after compaction | [V 2.3] | G |
| F13 internal agents | [V 2.6]; [O] #83 | made now |
| F16 meta files | [O] S4 to S6 | made now |
| F17 roles run in the background | [O] S5 | made now |

The observations below are written now. A, B and C all come from the first role launch after M2's merge and sync, so they need no extra run.
- A (F1, F3, F8): read the registry lines and the meta file for that `agent_id`.
  - Start and PostToolUse records both present: green.
  - PostToolUse only: Start does not fire → 3.7's `skills:` preload, and the nonce check switches to the marker.
  - Neither record, meta present: settings not picked up → a new session (Batu's action, with PR-A1's precedent), and 3.4 waits.
  - Neither record, no meta: an environment failure; observe again at the next launch.
  - Negative controls, natural: roles launched before the sync have no Start record and say `Package: none delivered` (this run is one); internal agents like #83 get no Start record under the anchored matcher.
- B (F2): at that agent's first Stop, compare the `Nonce:` line's hash with the registry and the header's hash with the package at HEAD, with no block before.
  - Header present, nonce absent → the cap or preview cut it → the size test fails the build.
  - Header absent while a Start record exists → 3.7's preload.
  - Control: a synthetic wrong nonce gives a block.
- C (F4, F6): a Stop record whose `sha256(last_assistant_message)` equals the hash of `subagent_audit.py last` (without its trailing newline).
  - No Stop record → 3.7's hand-over fallback.
  - Hashes differ → point 2's branch.
- D (F5): only at the first natural incomplete report, never planted. A block, then a later event and a second Stop of the same run.
  - Red: the end notification arrives with no later event → the after-check, which is today's state.
  - Until then: "not yet observed".
- E (F9): the Start record's keys equal the guard records' `session` and `local_session`. Red → fix the key function (program logic).
- F (F10): at the working session's first compaction after sync, or the next opening, whichever comes first. A SessionStart record with its `source` and the package hash; the executor's log entry quotes the header it received. Red → the executor re-reads `executor.md` by working order section 3, the existing route.
- G (F12): only if a role auto-compacts. Red → the role re-reads its package by its file's procedure.

Can any be made now, before the build, without a planted case? Yes, and I made them: F9 for PreToolUse, F13, F16, F17 and the absence of handback records. Every hook-dependent row needs the build.

(3) Smaller, joined, parallel
- Take points 4 and 5 (one row and one guard branch fewer).
- Take point 6 as a cross-check rather than a third recorder.
- The test designer can write M2's condition now, in parallel with the PR-A2 and M1 builds, from EV-C02-028 10.1 (4)'s constants. The merge still waits for PR-A2.

**W-C02-26 (M3a)**

(1) View from my field
1. PROCEED: settings only; T1 still denies `SendMessage` (`tool_allowlist.py` lines 106 to 114; test lines 28 and 129 stay denials).
2. PREFERENCE (join): fold M3a into M2's pull request. M2 already writes `.claude/settings.json` (one writer per file, PC-24); one sync and one pickup observation then cover both. The schema read still comes after the deny is removed.
3. PROCEED: `isolatePeerMachines` is not observable and not to be tried (plan 1.2). `refuse` cannot be confirmed from inside the session (EV-C02-006 line 218). M3a's claim stays static: the settings diff plus T1's deny case.

(2) Platform facts
- The deny takes the bare name and removes subagent messaging [V 2.16].
- `isolatePeerMachines` and `refuse` [V 2.17].
- T1 [O code].
- The tool appearing after a deny is removed mid-session: unobserved. By analogy with EV-C02-006 line 152, definitions the model already saw may not change.
- The schema: [O code] from S8 (`to`, `message`, `notify_when_idle`).

Observation, written now: the executor's `ToolSearch` load of `SendMessage` after the sync (no call).
- Schema returned with `to` → T6's recipe A.
- Returned without a readable target → 3.7: `SendMessage` stays denied; returns go by the hand-over.
- Not found → the settings change was not picked up → the next session. No harm in the meantime, because T1 still denies.
- Negative control: the same load before the sync returns nothing, unless a record on file (EV-C02-006's tool lists) already shows that.

Nothing can be made now beyond S8.

(3) Join into M2, as point 2 says.

**W-C02-27 (M3b)**

(1) View from my field
1. DEFECT: role files' `tools:` lines changed mid-session are not shown to load (EV-C02-023 R-01's note; C02-log line 1577). So 3.6b's done line may be unobservable in the session that merges M3b. Also, "`SendMessage` absent in a role" has two causes that 3.7 does not tell apart: the file was not reloaded (→ a new session) or the tool is deferred (→ `ToolSearch` in `tools:`). Shown fixed when: the condition names the session in which the live row counts, and M3b changes one body line of each role file in the same commit. The first role run after sync then reports its tool list and whether its system prompt holds that line (R-01's method).
   - New line present, tool absent → `ToolSearch`.
   - Old body → a new session.
   - Control: the pre-M3b tool lists (R-01; this run: Read, Grep, Glob, Bash).
2. DEFECT: T6's "to `main` from a non-null caller" admits callers that are not roles; #83 is a non-null internal agent. Shown fixed when: a synthetic caller ID that is not in the registry, sending to `main`, is denied with its own rule ID.
3. DEFECT: 3.7 has no fallback for "PreToolUse does not see `SendMessage`". Shown fixed when: the condition names it. If a transcript shows a `SendMessage` call with no matching guard record, T6 is no control, and the settings deny is restored by revert.
4. PREFERENCE: T6 allows only `to` and `message`. The binary's text gives `notify_when_idle` as main-only and about cross-session idle notices (S8). Inputs with legacy keys are denied; that is safe whether the platform's normaliser runs before or after the hook.
5. PREFERENCE: T6 takes the caller's type from the registry or meta by `agent_id`. The guard has never logged `agent_type`, and the input field is unobserved.
6. PROCEED: the roster. Role launches carry a description and no name (20 meta files), so the roster is likely empty, and IDs travel in the `Teammates:` line, which is already the fallback. Reply routing: the documented route covers interactive sessions only, and these runs are `requestNonInteractive: true`, so 3.7's return-state fallback stands.

(2) Platform facts
- Schema: [O code] S8; the live definition is unobserved (M3a's observation).
- The tool present in a role without `ToolSearch`: unobserved (point 1's discriminator).
- A message to a finished agent resumes it [V 2.18].
- A resumed agent's reply route [V 2.19], interactive only.
- Roster form [V 2.20].
- PreToolUse sees `SendMessage` with `to`: unobserved.
- Role-file reload mid-session: not shown [R].

Observations, written now, each at its first natural occurrence after the merge and sync, in the session where role files load:
- O1, tool present: point 1's discriminator and outcomes.
- O2, the first natural `SendMessage`: compare T6's record (with `to` in its summary) with the caller's tool-use input from `subagent_audit.py calls`.
  - A call with no record → point 3's fallback.
  - Control: the synthetic tests.
- O3, the executor's first natural resume of a finished role (for example a scoped re-review by the same checker, 2.6 (c)): a Start record for the same `agent_id` with the nonce reused, and the reply notification arriving at `main`.
- O4, the first natural role-to-role request: both transcripts and main's notifications show who got the reply.
  - Reply at `main` → the return state, per 3.7.

Nothing can be made now beyond S8 and the meta and roster point.

(3) Smaller, joined, parallel
- M3b's triage and condition can run now, from S8's keys.
- Build after M2's registry merges.
- Its live rows most likely ride the next session switch together with any of M2's rows still open; one opening observes them all.

Guard denials:
- #854, rule B7: my first Bash command included a version read through the CLI. I ran the other parts without it and took the version as stated (L-439). Not tried another way. This is the known failure class F1 of EV-C02-028 line 668.
- #886, rule B5: a `python3 -c` reader that named the guard log directory. I did not run an interpreter on it again; I read the log only with the Read tool, `sed -n` and `grep`, the readers the denial's own "What matched" names as allowed. The executor may judge whether that counts as the same effect.
- Not a denial: I read the installed binary's text with the Grep tool and never ran it.

## 5. The checker in triage's note (`a5309384b6fd9cecb`), verbatim

Non-binding contribution: this instance does not give W-C02-25's, W-C02-26's or W-C02-27's binding verdict.

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. The task is a triage contribution in my field: the depth and reading mode of the check. It names a purpose, inputs, a consumer and an output form. It does not ask me for a verdict and does not steer one. The reading-order constraint (a) comes with its reason, so it binds, and I kept to it. My role file sets a 50-call budget, and I used about 30 tool calls. No start header arrived, and `/home/user/devos/.claude/roles/checker.md` does not exist at 449df84. I worked from my system prompt, `CLAUDE.md` as delivered in context (not opened) and the task.

## Disciplines (D1–D9)
D1: yes: I tested the plan's frame that the settings deny is a second layer independent of the guard against L-430, found the two fail together when settings are not loaded, and changed my W-C02-26 view to match.
D2: yes: Batu's "today" pulls toward fewer or lighter checks, so I suggested shortening only through order, splitting and dropping parts, and kept every floor item for each binding check.
D3: yes: I kept each check tied to its item's claim and the end-to-end chain (hook fired, then text reached the model, then echoed), and kept "not read, not applied" outside every claim.
D4: yes: I built each triage around the error that would turn each check red, with own breaks and over-blocking controls, and limited each merge claim to what the counted environment shows (platform rows go to acceptance).
D5: yes: the platform facts come from EV-C02-023, a researcher's [V] rows, not observations; I went back to the code at 449df84 for the session key, T1, settings.json, the audit parser and stop_check, and I label which facts are only [V].
D6: yes: I took L-430's cause layer (the session's working directory moved, so `.claude/settings.json` was not loaded) to judge what M3a really removes, and stopped there because going deeper does not change the triage.
D7: no
D8: yes: I confirmed the working tree is at 449df84, clean, with none of the three item files present (as the task says); the local `main` ref is stale at 62d2be8, so I read every file with `git show 449df84:`.
D9: yes: I read my library line; it changed four points (W-C02-25 points 5 and 6, W-C02-26 point 2, the binding checks' claim limits) and justified one (3.3's claim limit), as listed below.

Read, and what each changed:
- `plan/SB-COR_Correction_Plan.md` at 449df84: Phase 1 (1.0 to 1.2), Phase 3 (3.1 to 3.7), E, F, G. Defines the claims I triaged.
- `evidence/C02/EV-C02-023_platform_capability.md` at 449df84, in full:
  - R-01 and R-03 changed W-C02-25 point 3 and W-C02-27 point 5.
  - Version-tie rows 2, 6, 7, 10, 11, 16 to 21 set what is only [V].
- `evidence/C02/EV-C02-028_pra2_m1_triage.md`:
  - Part 10 (both approach blocks v2), read in full. Changed: W-C02-25 points 8 and 12, W-C02-26 point 5, W-C02-27 point 3.
  - Part 9.6, about 130 lines of the round-2 checker answer. Read for form and so as not to repeat it; changed nothing.
- `plan/Installation_Working_Order.md` at 449df84: section 4 step 4 and section 10's tools and sessions bullets (grep-located lines only). Bore on W-C02-26 point 2 and W-C02-27 point 7.
- `plan/ledger/C02-log.md` L-430 (first lines). Changed W-C02-26 point 2 and W-C02-25 point 6.
- `.claude/settings.json` at 449df84. Bore on W-C02-26, and on the fact that both W-C02-25 and W-C02-26 write this file.
- `.claude/hooks/tool_allowlist.py` at 449df84: lines 60 to 75, 100 to 132, 415 to 422, 2160 to 2200, 2250 to 2345, and grep hits. Changed W-C02-25 points 9 and 11.
- `.claude/hooks/reread_after_compact.py`, `tools/guard_report.py`, `tools/stop_check.sh`, all in full. Changed W-C02-25 points 5 and 6.
- `tools/subagent_audit.py` at 449df84: docstring, `block_problem` and `disciplines`. Changed W-C02-25 points 3 and 4.
- `tools/test_tool_allowlist.sh`: grep for SendMessage. Changed W-C02-26 point 3.
- `.github/workflows` listing. Bore on whether `records.py` and `stop_check.sh` are CI gates: they are not.
- `plan/Ek_D_Dusunme_Protokolleri.md`, from line 69 on only (sections 3 and 4). Set the method.
- Library at 941f027:
  - `research/studies/multi-agent-patterns/SOUL-DEVELOPMENT-OS-ASSESSMENT.md`: 6.2's warning, section 8 (the three critic functions, cross-system critics), C5, R4, R7. C5 shaped every "turns red" line; R4 shaped W-C02-27 point 4; R7 kept W-C02-26's check small.
  - `research/studies/gstack/CORE.md`: P6, P7, F1 to F5. F4 changed W-C02-25 point 6; F3 changed W-C02-26 point 2 and W-C02-27's failure classes; F2 justified the claim limits at merge.
  - `research/studies/superpowers/CORE.md` sections 4 and 5. Section 5's chain justified 3.3's claim limit; section 4 (branch success is not merged-state success) bore on the counted environments.
  - `notes/U04-testing-diagnosis-and-verification.md`: F28, F30, F32, F33. F30 changed W-C02-25 point 5 and the binding of live rows to runs that start after sync; F28 limits each break to one defect.
- Deliberately not read:
  - The files constraint (a) excludes, and Ek D before line 69.
  - `tools/records.py` and `tools/merge_gate.py` bodies: not needed for depth and mode.
  - `.claude/agents/` files, including my own.
  - W-C02-23's acceptance branch: it is under its own check.

Relied on:
- The guard log key is computed inline in `log_decision`: `norm(CLAUDE_CODE_REMOTE_SESSION_ID)`, else `session_id`, then sanitised. There is no separate session-key function (`.claude/hooks/tool_allowlist.py:2260-2261`, `norm` at 415). Observed.
- `SendMessage` is not in `ALLOWED_NON_MCP`, so T1 denies it (`tool_allowlist.py:107-114`, 2193-2194). The existing test asserts a denial without a rule ID, on PreToolUse, from main only (`tools/test_tool_allowlist.sh:129`). Observed.
- `SubagentHandback` is an allowed local tool (`tool_allowlist.py:112, 125`). Observed.
- settings.json at 449df84: SessionStart has only the `compact` matcher; the guard's two hook commands carry a fail-closed wrapper; `SendMessage` and `ListAgents` are in `permissions.deny`; `crossSessionInbound` is `refuse`. Observed.
- `subagent_audit.py`'s parser checks only the disciplines block, not the hand-over headings (`block_problem`, lines 330-347). Observed.
- `stop_check.sh` holds no per-run check today. Observed.
- L-430: after a worker restart the session's working directory moved, the repository's `.claude/settings.json` and its hooks were not loaded, and the guard logged nothing. Stated (`plan/ledger/C02-log.md:1520-1525`).
- Readers may read `/tmp/devos-guard`; writes there are denied. Stated (`tools/subagent_audit.py` docstring) and observed (`tool_allowlist.py:304, 837`).
- From the plan and EV-C02-023 (labels as filed):
  - SubagentStart cannot block (row 2).
  - On SubagentStop, exit 2 sends the agent back (row 10).
  - A message to a finished subagent resumes it (row 18).
  - Rows 1.2 for delivery are unobserved.
  - A changed role file mid-session is not shown to load (R-01).
  - R-03: `last` once returned a later short message instead of the report.
- From W-C02-24 v2 (3), stated: T5 logs only the prompt's byte length and SHA-256. It does not record the item.
- From W-C02-23 v2 (5), stated: W-C02-25 adds its start hook to the merge gate's trigger set; `tools/merge_gate.py` has one writer at a time.
- That M2's hooks would be held to SubagentStart's and SessionStart's documented inability to block: inferred from [V] rows only.

Unsure:
- Whether settings hooks are picked up mid-session, and whether a changed `tools:` line loads mid-session. Both are unobserved, and either could require a new session (Batu's action) before the live rows can exist. Settled only by the first natural occurrence after each sync.
- Whether W-C02-22 carried L-430's "liveness after every worker restart" into the working order. Constraint (a) bars me from W-C02-22. The executor can settle it from the merged text.
- The role files' own output forms for producer, researcher, prober and test designer. Not opened, by constraint and because they were not needed for depth. The test designer settles them from the role files at the head.
- Where `isolatePeerMachines` sits and whether a project-level value takes effect: only [V] (row 17), and not observable under 1.2.

For: the executor, who integrates this into the approach block of W-C02-25, W-C02-26 and W-C02-27 with a disposition where it decides across fields. Then the test designer, who writes the conditions (controls and breaks below), the producer, and each binding checker, who reads this triage only after its own pass and never goes below the floors given here.

Received from / Returned to: I took this round's task from the executor in full and returned nothing. Outside my scope, for the executor: in this worktree the local `main` ref resolves to 62d2be8 (PR #401) while HEAD is 449df84. This was already reported in EV-C02-028 part 9.6, and it still holds.

Product:

W-C02-25 (M2: registry, start, stop, liveness)

(1) View from my field

1. PROCEED on the frame (3.2 to 3.5 with 3.7's fallbacks), with the points below.
2. DEFECT (3.3, reusing the nonce against storing only its hash).
   - The start hook must give a resumed agent the same nonce, but the registry keeps only `sha256(nonce)`, which cannot be inverted.
   - Storing the nonce in plain text under `/tmp/devos-guard` would let any reader role read it, and so report a receipt without delivery.
   - Shown fixed when the approach says where the reusable secret lives and who can read it. For example, an HMAC of `agent_id` under a key file that the guard denies to every caller's Read, Grep and Bash.
   - Tests: a resume fixture for the same `agent_id` emits a byte-identical last line, and a subagent-caller Read of the key file is denied.
   - Blocks: the producer task.
3. DEFECT (3.4, what a block does to verbatim filing).
   - After a block, the agent's next final message is what `tools/subagent_audit.py last` returns. If the agent answers only with the missing part, a binding verdict or a hand-over is filed as a fragment.
   - Shown fixed when the block reason asks for the whole final message again with the part added, and a test asserts that wording.
   - Live row: the first `last` after a real block passes `disciplines` and carries the whole form.
   - Blocks: the producer task.
4. DEFECT (3.4, over-blocking controls per output form).
   - The required parts differ by form. My binding verdict carries lower-case front-matter keys (`package:`, `nonce:`, `received_returned:`) with the disciplines block after the front matter. The non-binding form carries headings. Each other role has its own form.
   - Shown fixed when the condition lists one complete fixture per role per form, taken from the role files at the head, each ending with no block. The verdict-form fixture must also pass the merge gate's verdict parsing.
   - Blocks: the producer task (the condition).
5. DEFECT (3.5, `stop_check.sh` over-blocking runs that finished before the hooks went live).
   - Every run finished earlier in the same session, today's triage runs included, has no Start or Stop record.
   - U04 F30: a query on occurrences accepts earlier events unless it is bound to the current operation.
   - Shown fixed when a recorded cutoff exists (the sync's time or the first registry record). Fixtures: a run that finished before the cutoff is not counted; one after it without records fails.
   - Blocks: the producer task.
6. DEFECT (3.5's done line, "shown live at every opening", says more than its evidence).
   - A hook path existing and a synthetic run show that the scripts work, not that the platform loaded the settings. L-430's failure (settings not loaded) passes both. This is gstack F4.
   - Shown fixed by either of two:
     - (a) the done line narrowed to "scripts present and working; hooks live as of the last finished run's records";
     - (b) `tools/guard_report.py` adds a self-witness: its own Bash call's guard record must be the newest and recent, or it fails. Break: a log whose newest record is old gives FAIL.
   - With either, the liveness triggers include a worker restart, as L-430 carried.
   - Blocks: the producer task.
7. DEFECT (3.4's Auto-window rule in the guard).
   - Denying an incomplete `SubagentHandback` carries neither the one-block-per-run limit nor the never-trap property that the stop hook has, so an agent in an Auto window can loop on the denial.
   - Shown fixed when either the rule is dropped (point 11), or one deny per run is stated, with a test that a second incomplete handback of the same run is allowed and recorded.
   - Blocks: the producer task.
8. DEFECT (an interface with W-C02-27: the producer's item).
   - 3.6b reads "the item T5 recorded", but T5 as agreed records no item (W-C02-24 v2 (3)).
   - Only M2's PostToolUse-on-Agent recorder sees the prompt (3.2; row 11).
   - Shown fixed when W-C02-25's approach pins the registry's item field, parsed with T5's `Item:` grammar from the PostToolUse prompt, as the interface W-C02-27 reads: one shared parse function, or a test across both.
   - Blocks: the producer task.
9. PREFERENCE (owner: the producer). The session key without a guard edit.
   - No session-key function exists to import (only inline code at 2260-2261). Drive the guard command and the hook command on the same synthetic input, in a scratch log directory, and assert the same file stem.
   - This keeps M2 off `tool_allowlist.py`, which M1a and M3b own, and takes the guard out of M2's floor.
10. PREFERENCE (owner: the producer and the test designer). Compare W-C02-23's constants (`RESERVE`, the header form) by test rather than importing them from `tools/` at runtime: a broken `tools/` file would otherwise take the start hook down with it.
11. PREFERENCE (owner: the executor). A smaller design: drop the Auto-window guard rule.
    - Auto windows are named single actions (D-034 (b)). State that no role is launched inside one, and keep the after-check `last` already makes on a handback.
12. PROCEED, with an order note. M2 also writes `tools/merge_gate.py` (the trigger set) and `tools/subagent_audit.py` (the `Package:` line check), both M1b's files. Its producer therefore starts after M1b's merge, not after M1a's (PC-24).
13. PROCEED on 3.3's claim limit: "reached the model and its last line was echoed", not read or applied (superpowers CORE section 5).

(2) Triage for the binding check

- Claim at merge, in program logic only:
  - Both hooks write the registry under the guard's key, with `flock`.
  - The start hook gives the header, package, agent ID and the nonce as its last line, in at most 9,500 bytes. It refuses above that, and reuses the nonce on resume.
  - The stop hook blocks once per run on a missing part. It never traps: a missing script, a crash, malformed input, an unreadable registry or an oversized message all end with exit 0 and the agent stopping. It passes complete reports of every form.
  - The liveness lines, `stop_check.sh` and `records.py` refusals work, with the settings wiring as written.
  - Not claimed at merge: platform delivery. The 1.2 rows are: Start fires and reaches the model; settings are picked up mid-session; Stop fires and its block is honoured; `last_assistant_message` equals the report (R-03 is a counter-signal); the size limit on a block reason; `session_id` against the log key.
  - Acceptance waits for those rows (4.5); a red row selects 3.7's fallback.
- Failure classes:
  - the session key differs between the registry and the log;
  - the matcher drifts to `.*` or matches an empty `agent_type`;
  - a new nonce on resume;
  - a nonce a reader can read;
  - size counted in characters, or a last line cut by the platform cap;
  - exit 2 or another non-zero code on SubagentStop;
  - repeated blocks;
  - a valid form blocked;
  - a block reason that asks only for the fragment;
  - pre-live runs flagged;
  - liveness shown by file presence only;
  - a settings edit that changes the guard's two hook commands;
  - stray stdout from a hook entering the context;
  - writes without `flock`;
  - the new `.agents` file writable by tools.
- Cheapest discriminating evidence:
  - tests that drive the hook commands as `settings.json` holds them (as `test_tool_allowlist.sh` does);
  - a byte comparison of the existing PreToolUse and PermissionRequest entries between base and head;
  - a full run of `bash tools/test_tool_allowlist.sh` at the head;
  - a size test at the boundary: a package of exactly LIMIT bytes with the longest role name and a maximum-length ID is emitted; LIMIT+1 is refused. This also settles W-C02-23 disposition (6).
- Own breaks, one commit each in a scratch clone, each red in its named test:
  - (a) the stop hook exits 2 when the nonce is missing;
  - (b) the per-run block memory removed;
  - (c) the matcher set to `.*` against an empty-type fixture;
  - (d) a new nonce on each Start;
  - (e) the nonce moved above the package;
  - (f) the key read from `session_id` only, with the remote ID set;
  - (g) `stop_check.sh`'s cutoff removed;
  - (h) the SubagentStop entry deleted from settings, or the script renamed;
  - (i) a Bash append to the `.agents` file, which must stay denied.
  - A red shows sensitivity to that one defect only (U04 F28).
- Counted environment:
  - Program logic: the container's `python3` (version named) via the settings commands, in a full scratch clone at the head, with `DEVOS_GUARD_LOG_DIR` in scratch.
  - Platform: the working session after sync, own agents only, each row bound to a run that started after sync.
- Depth: deep on the stop hook, settings.json, `stop_check.sh` and `records.py`. A reading plus one fixture each for the recorder's and `guard_report.py`'s display lines.
- Reading mode: product only first (from `settings.json` and the scripts: is the wiring what 3.2 to 3.5 claim, and would each role's complete report pass?). Then design-knowing against 3.2 to 3.5, 3.7, W-C02-23 v2 (4) to (6) and W-C02-24 v2 (3) and (9). Separate headings, no single score.
- Ek A 3.2 (c): asked (gstack P7, F2 and F4; superpowers CORE section 5).
- Declare FC9: the stop hook judges the binding checker's own output form.
- `floor: hook that can block (.claude/hooks/subagent_stop.py); .claude/settings.json; tools/ oracles (stop_check.sh, records.py, subagent_audit.py, the merge_gate.py trigger set); the guard if touched; public text`

Sharing a verdict, or splitting:
- I recommend one item with two pull requests, each with its own verdict (as W-C02-24 did):
  - M2a: the registry, the PostToolUse recorder, the start hook, SessionStart extended, their liveness lines and the trigger-set line. No hook here can block (SubagentStart and SessionStart cannot [V]; the recorder runs `|| true`), so its check is lighter. Its live rows (settings picked up mid-session; Start fires and reaches) decide 3.7's branch for M2b and M3, one build earlier.
  - M2b: the stop hook, the `stop_check.sh` and `records.py` gates, the `Package:` audit, and the handback rule if it is kept. It holds the only blocking hook and gets the deep check.
  - Each can be reverted alone.
- One pull request with one verdict also holds, if that verdict's budget covers the whole floor list above. If it cannot, split.

(3) Where it can be smaller, and what can run in parallel

- Smaller: no guard edit (points 9 and 11). `guard_report.py`'s display lines get a reading plus fixtures, not a break each. The `Plan` test case is diff-confirmable.
- Parallel: W-C02-27's build can run beside M2b against M2a's merged registry format.

W-C02-26 (M3a: settings only)

(1) View from my field

1. PROCEED. In program logic, nothing becomes reachable while the guard runs: T1 denies `SendMessage` (`tool_allowlist.py:2193`).
2. PROCEED, with a corrected ground, and a PREFERENCE on the text (owner: the executor).
   - The settings deny is not independent of the guard in L-430's failure: both live in `.claude/settings.json`, so both are gone when it is not loaded. Its unique cover is a guard bug only (gstack F3).
   - The loss is therefore narrower than "a second layer". The PC-45 annotation should say the layer shared the guard's failure mode with respect to settings loading.
3. MISSING_EVIDENCE (the test behind "T1 still denies").
   - `tools/test_tool_allowlist.sh:129` asserts a denial with no rule ID, on PreToolUse, from main only.
   - The condition should add `lt` T1 cases for `SendMessage` on PreToolUse and PermissionRequest, from a null caller and from a subagent `agent_id`.
   - Blocks: the producer task (the condition).
4. PROCEED, with a claim limit. `isolatePeerMachines` can be judged only as "set as documented" (row 17 is [V]; 1.2 says it is not observable). The verdict claims no more.
5. DEFECT (a missing step).
   - W-C02-24 v2 disposition (8) reopens, at M3a, a settings-level deny of `Workflow` and the built-in type names.
   - Shown fixed when M3a's approach records its disposition (taken or not, with the reason).
   - My view of the merits: a deny in the same file shares the failure mode of point 2, so its value is modest either way.
   - Blocks: the producer task.
6. PREFERENCE (owner: the executor). Order.
   - There is no technical dependency on W-C02-25: T1 denies regardless of the registry.
   - Run M3a now, in parallel with the PR-A2 and M1 builds. Neither of them lists settings.json in its `writes:`. It must merge before M2's producer writes settings.json (one writer per file).
   - This takes the schema row (the `ToolSearch` load) off the critical path, so W-C02-27's triage pins T6 on [O] rather than on conditional recipes.
   - The load after sync also gives an early signal on settings picked up mid-session. That signal covers permissions, not hooks, and is an inference.

(2) Triage for the binding check

- Claim:
  - The JSON-level difference between base and head is exactly: "SendMessage" removed from `permissions.deny`, and `isolatePeerMachines: true` added at its documented place.
  - All else is equal: `ListAgents`, `crossSessionInbound: refuse`, and the hooks byte-identical.
  - T1 denies `SendMessage` for every event and caller.
  - The section 10 and PC-45 text is true at the head.
- Failure classes:
  - invalid JSON, or an edit that drops the guard's hooks (the whole guard is lost);
  - a key at the wrong level, silently ignored;
  - other deny entries lost;
  - the guard admitting `SendMessage`.
- Cheapest evidence: one read-only `python3` comparison of the two parsed files, minus the two intended changes; the guard test suite.
- Own breaks:
  - (a) add `SendMessage` to `ALLOWED_NON_MCP`: the new `lt` T1 cases turn red;
  - (b) corrupt `settings.json`: the settings-driven hook tests turn red.
- Counted environment: the container's `python3` in a scratch clone at the head.
- Depth: small, about ten calls.
- Reading mode: product only (the difference), then a short design-knowing reading against 3.6a, PC-45 and rows 16 and 17.
- Ek A 3.2 (c): asked, short (gstack F3).
- `floor: .claude/settings.json (own breaks); public text`

Sharing a verdict, or splitting: one small verdict on its own (if run now). Otherwise join M2a's pull request: same file, and the parts can be checked side by side. Do not join M3b, which would bring the schema row back onto the critical path.

(3) Smaller, joined, or parallel: as point 6. It is already minimal.

W-C02-27 (M3b: T6, the `tools:` lines, the working-order text)

(1) View from my field

1. PROCEED on the shape. An allow-list of the session's own registry IDs is the right control for "only this session".
2. DEFECT ("that item's consumers" has no machine form).
   - `consumer:` lines are prose, so T6 cannot decide who is a consumer.
   - Shown fixed when the approach pins T6's derivation (a grammar, refused when unreadable), or narrows producer messages to the executor alone (my preference: smaller, and no grammar needed).
   - Blocks: the producer task.
3. DEFECT (where the item comes from). T5 records no item (W-C02-24 v2 (3)), so T6 reads M2's registry field (W-C02-25 point 8).
   - Shown fixed when 3.6b's wording and the approach name that field.
   - Blocks: the producer task.
4. DEFECT (the integrity of verdicts).
   - A message to a finished binding checker resumes it (row 18), and changes what `last` returns, which is the route by which verdicts are filed verbatim. This is the multi-agent assessment's R4: a target that moves after review.
   - Shown fixed when T6 lets only the executor message a checker run (fixture: sibling to checker ID denied; executor to checker ID allowed), or the filing reads the report of the run's first end status, with a test.
   - Blocks: the producer task.
5. MISSING_EVIDENCE (a changed `tools:` line loaded mid-session). R-01 does not show it, and W-C02-02 item 4 is a counter-signal.
   - The done line (a real message exchanged) may need a new session. The acceptance should name that branch and its time.
   - Blocks: the acceptance, not the merge.
6. PROCEED. T6 runs unchanged on PermissionRequest, because `decide()` already runs there.
7. PROCEED, with check points in the same pull request:
   - working order section 4 step 4's "the guard denies resuming a helper (`SendMessage`)" sentence, and its "only once the guard allows resuming" clause, change with T6;
   - the binding checker declares FC9, because `checker.md`'s `tools:` line changes.

(2) Triage for the binding check

- Claim:
  - T6 allows `SendMessage` only to a registry ID of this session, or to `main` from a non-null caller, with only the schema's keys.
  - Producer IDs are reachable only from the derivation that point 2 pins, naming the registry's item.
  - Every other case is denied, each with its own rule ID, on both events.
  - The roles' `tools:` lines gain `SendMessage`, and the working-order sentences are true.
- Failure classes:
  - names accepted;
  - normalisation that admits near-IDs;
  - another session's registry read (the key);
  - empty, list, `*`, `session_` or `cse_` targets accepted;
  - extra input keys passing;
  - `main` from a null caller;
  - a producer resumed by a non-consumer (gstack F3: T5 sees only Agent calls);
  - a binding checker resumed by a sibling;
  - a T6 error that escapes to the guard-wide failure path (it needs containment like T5.0);
  - an unreadable registry that does not deny;
  - over-blocking: a message to one's own registered helper denied.
- Cheapest evidence: synthetic hook inputs through the settings command, in a fixture holding a registry file. The target field is the schema row from M3a, if it is [O] before the recipe is pinned; otherwise 1.1's conditional recipe applies. An unreadable field fails closed, which is safe.
- Own breaks:
  - (a) names accepted;
  - (b) the registry lookup removed;
  - (c) the producer rule removed;
  - (d) `main` allowed from a null caller;
  - (e) extra keys ignored;
  - (f) the containment removed;
  - (g) the key read from `session_id` only.
  - Each turns red in its own fixture.
- Over-blocking controls, which must pass: the executor to a registered checker; a checker to `main`; a role to a registered sibling; the executor resuming a finished producer that names its item.
- Counted environment: program logic as in W-C02-25; platform, 3.6b's observation order, own agents only.
- Depth: deep (a guard deny rule).
- Reading mode: product only first (from the guard and the text: can a role reach its sibling; can anything reach another session?), then design-knowing.
- Ek A 3.2 (c): asked (gstack F3; the multi-agent assessment's 6.2 warning, for messages that are not records).
- `floor: .claude/hooks/tool_allowlist.py (own breaks); .claude/agents/*.md tools lines (FC9 for checker.md); the working-order text; public text`

Sharing a verdict, or splitting: T6, the `tools:` lines and the text share one verdict. None is useful alone: T6 without the lines is unreachable, and the lines without T6 are denied by T1.

(3) Smaller, joined, or parallel

- Smaller: producer messages only from the executor (point 2).
- Parallel: build beside M2b, against M2a's merged registry format.
- If M3a is not run now, join it here rather than run it as a separate step. Joining is safe because T6 fails closed on an unknown field.

Across the three items (for the executor's disposition)

- Path A:
  - now: M3a, beside PR-A2 and M1;
  - after M1b: M2a, then its live rows;
  - M2b and M3b built in parallel.
  - That makes four verdicts (two of them light) against the plan's three, with a shorter critical path.
- Path B:
  - M2 as one pull request;
  - M3a joined to M3b.
  - That makes two deep verdicts and no early platform row.
- I prefer A. Neither path removes the real risk to finishing today: two unobserved rows (settings picked up mid-session; role files reloaded) may each need a new session. Observing them early is the only lever that does not cut a check.

Guard denials: none

## 6. The test designer's note (`a312472717fb8bd4f`), verbatim

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED, for all three items. Each item holds as framed: the mechanism is real, its claim can be limited to what a mechanism can show, and the plan already has the order (M2, then M3a, then the schema row, then M3b). The points below are fixes inside that frame, so I return no `WRONGLY_FRAMED`. W-C02-26 may need a different order or a merge with W-C02-27; one cheap probe decides that, and it is the executor's call (W-C02-26 point 2). My role file says to read `/home/user/devos/.claude/roles/test-designer.md` when no header arrives. `.claude/roles/` does not exist at `449df84` (I ran `ls`), so I worked from my role file and the common floor in my context.

## Disciplines (D1–D9)
D1: yes: I found three assumptions that would each change a condition and named the probe or interface that settles each: where the reused nonce lives, which live rows hold acceptance, and whether the `SendMessage` schema can be read while the deny stands.
D2: yes: Batu wants this finished today, so I kept every binding check and named the rows that cannot occur today, instead of loosening any condition to fit the day.
D3: yes: I traced each mechanism from start to finish (registry written, then read by T6 and the liveness report; start text sent, then echoed, then compared at the stop; deny removed, then schema read, then T6) and found the links that are missing.
D4: yes: I gave every oracle a break that turns it red. I flagged one break that cannot be made reliable (`flock` under real concurrency), and two existing cases that would pass for the wrong reason (`t deny SendMessage` at `tools/test_tool_allowlist.sh:129`).
D5: yes: I did not take the plan's summaries for granted. I went back to the guard, `guard_report.py`, `subagent_audit.py`, the role files and today's hooks page for every fact a condition rests on, and that turned up `stop_hook_active` and the second session-key derivation.
D6: yes: I asked by which routes the hooks could trap an agent (any exit 2, the hand-back deny, the platform's own loop protection ignored) instead of trusting "exits 0 on failure".
D7: no
D8: yes: I confirmed that `HEAD` is `449df84316b3bd4dd12e48c48b53d274a59cb983` with a clean tree, that `.claude/roles/` is absent, that four role files have no `SendMessage`, and I read W-C02-23's condition at `a2af247` for the constants it pins.
D9: yes: I read playbook F7 and F8, gstack CORE P5 to P7 and F1 to F4, and work-environment KEY and finding 02 §1 to §3 and §6. They shaped the route lists, the producer-ID and checker-anchoring points, the rule that "could not check" must never read green, the never-trap and bounded-wait cases, the per-run liveness, and the split between program logic and platform delivery.

Read, and what each changed:
- `plan/SB-COR_Correction_Plan.md`, read in full. It sets the claims; it changed the scope point (W-C02-25 point 7), the acceptance-row point (point 8) and the nonce point (point 2).
- `plan/Ek_D_Dusunme_Protokolleri.md` from line 69 on (the trigger questions and D1 to D9). This was my method.
- `evidence/C02/EV-C02-023_platform_capability.md`, read in full. Its rows 2.2, 2.6, 2.7, 2.9, 2.10, 2.11, 2.18, 2.20 and 2.21 give the platform facts; its parity header gives the counted environment.
- `evidence/C02/EV-C02-028_pra2_m1_triage.md`: part 10 in full (both lines cut at 6,000 characters, then the rest read), and part 9.7 in full (the earlier test designer's round 2 and package). The outline only of parts 1 to 9.6. Part 10 changed: RESERVE and HEADER as one source, disposition 6 (per-line maxima moved to W-C02-25), and M1's need for `launch`. Part 9.7 gave the failure classes FC1 to FC15 and the form I answer in.
- `git show a2af247…:plan/work/W-C02-23.md`, the acceptance block (Terms through point 12). It changed: the constants I must not redefine, the trigger set W-C02-25 extends, and the precedent for live rows.
- `plan/Installation_Working_Order.md` lines 20 to 236 (sections 2 to 10). It changed: table rows 1 to 7 (row 7 is the hand-over; there is no package row), the task form's `Teammates:` line, the `SendMessage` sentences in section 4 step 4 and in section 10.
- `.claude/settings.json`, read in full. It justified: only one SessionStart entry exists (matcher `compact`); `SendMessage` and `ListAgents` are denied; there is no `isolatePeerMachines` key.
- `.claude/hooks/reread_after_compact.py`: `MESSAGE` and the exit-0 pattern.
- `.claude/hooks/tool_allowlist.py`, by grep and the ranges 2250 to 2285, 415 to 417 and 785 to 795. It changed W-C02-25 point 5 (there is no session-key function) and confirmed that `LOG_DIR` is a guarded zone.
- `tools/guard_report.py` by grep. It changed point 5 (a different key derivation).
- `tools/stop_check.sh`, read in full. It justified the exemption-grammar interface.
- `tools/subagent_audit.py`: `DISC_HEAD`, `block_problem`, `last_text`, `last`, `end_problem`. It changed point 4 (the definition of a finished run) and point 6 (only the disciplines heading is a constant today).
- `tools/records.py`, function list: it has no role-file check yet.
- `tools/test_tool_allowlist.sh` by grep. It changed W-C02-26 point 3 (`:129` uses `t`) and confirmed that the tests read hook commands from `settings.json` (`:21-24`).
- `plan/Ek_C_Testler.md` C0. It justified the case form and the "filled but meaningless" case.
- `plan/decisions/D-041.md` lines 1 to 12. It is used in the 6.12 item 1 lines.
- `.claude/agents/producer.md`, `checker.md`, `prober.md`, `researcher.md`, `counter-designer.md`, by grep on `name:`, `tools:` and the Output headings. It changed point 6 and point 12, and the `tools:` observation.
- The hooks page, https://code.claude.com/docs/en/hooks.md, fetched 2026-10-20 to the scratchpad and grepped: SubagentStart, SubagentStop input (`stop_hook_active`), the 8-continuation cap, SessionStart `source`, the PostToolUse-on-Agent fields. It changed point 3 and the run-identity interface.
- Library: the SDLC playbook's file 04, §8 (F7) and §9 (F8); `research/studies/gstack/CORE.md` §10 P5 to P7 and §11 F1 to F4; the work-environment vertical's `KEY.md` and its finding 02 §1 to §3 and §6. They worked as stated under D9.
- Not read on purpose: the files that constraint (a) names; the Environment ground and finding 07 (the counted-environment split was already settled by finding 02 and the plan's 1.1); the other roles' round-1 notes in EV-C02-028 (their fields).

Relied on:
- The guard computes its log key inline in `log_decision`. The remote session ID is normalised (`cse_` becomes `session_`), the result has every character outside `[A-Za-z0-9_-]` replaced by `_`, and it is cut at 80 characters (`.claude/hooks/tool_allowlist.py:2260-2262`, `norm` at `:415-417`). There is no reusable function. Observed.
- `tools/guard_report.py:29,33` builds the session as `"session_" + x[4:]` with no character replacement and no cut. Observed. Inferred: a session ID with other characters, or more than 80, gives a different file.
- `LOG_DIR` is in the guarded write zones (`tool_allowlist.py:791`), and `DEVOS_GUARD_LOG_DIR` overrides it (`:68`). Observed.
- `SendMessage` is denied by T1, because it is not in `ALLOWED_NON_MCP` (`tool_allowlist.py:106-112`, `:2194`). The existing case asserts only the decision: `t deny '{"tool_name":"SendMessage",…"to":"someone"…}'` (`tools/test_tool_allowlist.sh:129`, with `t` at `:87`). Observed.
- `SubagentHandback` is allowed by T1 today (`tool_allowlist.py:112`, `:125`). Observed.
- The tests read hook commands from `.claude/settings.json` (`tools/test_tool_allowlist.sh:21-24`). Observed.
- `.claude/settings.json`: `SendMessage` and `ListAgents` are in `permissions.deny`; `crossSessionInbound` is `refuse`; there is no `isolatePeerMachines`; SessionStart has only `compact`, running the re-read hook with `|| true`. Observed.
- The role files at `449df84` have no `SendMessage` in `tools:` (`producer.md:4`, `checker.md:4`, `prober.md:4`, `researcher.md:4`). Observed. Mine was not opened (constraint a).
- Ten hand-over headings, `Take-up:` included, appear in `producer.md:56-69`, `checker.md:108-118`, `prober.md:59-72` and `researcher.md:62-76`. SB-COR 2.2 (4) lists them without `Take-up:`. Observed.
- `name:` is `producer`, `checker`, `prober`, `researcher` and `counter-designer` in those files. Observed.
- `tools/subagent_audit.py` has only `DISC_HEAD` as a heading constant (`:86`). `block_problem` checks nine answers (`:330-347`). `end_problem` reads the platform's end status, and only `completed` counts as finished (`:242-280`). Observed.
- From the hooks page, read 2026-10-20 [V], not observed here:
  - SubagentStop input carries `stop_hook_active`, `agent_id`, `agent_type`, `agent_transcript_path` and `last_assistant_message`. The Stop input says `stop_hook_active` is true when the agent is already continuing because of a stop hook, and advises checking it.
  - An 8-consecutive-continuation cap applies, reset by any tool call.
  - SubagentStart fires on spawn and on resume. Its context is re-injected only when the earlier copy is gone. Its input carries only `agent_id` and `agent_type`, and `agent_type` is the front-matter `name`.
  - SessionStart's `source` is one of `startup`, `resume`, `clear`, `compact`, `fork`.
  - A background PostToolUse on Agent carries `status: async_launched`, `agentId`, `prompt` and `outputFile`.
  - On SubagentStop, exit 2 sends the agent back. Only exit 2 with an empty stdout and a "No such file" stderr counts as a non-blocking error.
- W-C02-23's condition pins `RESERVE = 200`, `LIMIT = 9500 - RESERVE` and `HEADER = "DevOS role package: {role}@{sha12}"` in `tools/check_role_packages.py`, and the trigger set that "W-C02-25 adds its start hook to" (`a2af247:plan/work/W-C02-23.md`, Terms and point 8). Stated.
- EV-C02-028 part 10.1 disposition 6 defers RESERVE's per-line maxima to W-C02-25 (header 47 bytes, agent-ID line about 33). Part 10.1 also defers the packages' consumer row to W-C02-25. Part 10.2 disposition 1 reopens if M2's registry can bind writes to the launch form. Stated.
- EV-C02-023 2.21: the pages show only `to` and `notify_when_idle` for `SendMessage`, so the full schema is unknown. EV-C02-023 2.20: the sibling roster lists names, not IDs. EV-C02-023 2.18: a message to a finished subagent resumes it. Stated, all [V].

Unsure:
- Whether the executor's `ToolSearch` finds `SendMessage` while the settings deny is in force. That decides W-C02-26's place (point 2). It is settled by one `ToolSearch` at the current head, with no call made, filed raw.
- Whether a blocked agent's next Stop always arrives with `stop_hook_active` true when it called tools in between (the page says the cap resets on a tool call; it does not say whether the flag does). This is why I ask for both the flag and per-run state. It is settled at the first natural block, as a row of 1.2.
- Constraint (a): one shell command, `grep -l '2026-10-20' plan/decisions/*.md`, searched every file in `plan/decisions/`, `PC-53.md` included. Its output named that file as a match and showed none of its content. Whether this makes this run uncountable for W-C02-22 point 10 is for the test designer and the binding checker of that point. I also ran `ls .claude/agents` (names only) and read four other role files by explicit path. My own file was never opened, grepped or named.
- The value grammars of the producer's rule IDs and reason tokens are not stated, so every negative below names its rule by function; the IDs are pinned once the producer states them.

For: the executor, who integrates this into the three approach blocks with dispositions where it decides across fields (points 2W26, 8W25 and 6W27 cross into the plan's order, SB-COR 4.5 and the checker's field). Then me or the next test designer, who pins each condition from the agreed block. Each producer, who states the interfaces listed per item first. Each binding checker, who reads the breaks (the floor: these hooks can block or deny, SB-COR 2.6 (b)).

Received from / Returned to: none received; none returned. Noticed outside my scope, reported here to the executor and not done:
- (a) Constraint (a)'s contact, above. Owner: the executor and W-C02-22 point 10's checker.
- (b) T6 as drafted lets a producer message the binding checker of its own item (any registered ID is allowed). That opens a new anchoring route (D4 item 10) that the `shared_with_producer` line only declares. Owner: the checker's field (depth and independence); see W-C02-27 point 6.
- (c) If W-C02-25 extends the role-package trigger set, it writes `tools/merge_gate.py`, which M1b also writes (one writer at a time, PC-24). Owner: the executor's ordering.
- (d) SB-COR 2.2 item 6 put `SendMessage` into the roles' `tools:` lines in PR-A1. It is absent at `449df84` in the four files I checked, and W-C02-27 now carries it. Whether PR-A1 dropped it on purpose is for the executor to record, so that the two texts agree.

Product:
- **Files:** none written in any repository. Scratch only: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/hooks.md` (the hooks page as fetched on 2026-10-20, for the binding checker to re-read).
- **Coverage:**
  - W-C02-25 answers SB-COR 3.2 to 3.5, 3.7 (Start delivery, Hand-over, Block reason), 1.1, 1.2's rows for Start, Stop, `last_assistant_message`, the block reason and the session key, and W-C02-23's deferrals (the consumer row, the trigger set, the per-line maxima).
  - W-C02-26 answers SB-COR 3.6a, the PC-45 sentence (CHK-C02-121 finding 12) and 3.7's settings fallback.
  - W-C02-27 answers SB-COR 3.6b, 3.6's "Messages are not records" and its done line, and 3.7's messaging fallbacks.
  - What each condition does not cover is under each item.
- **Open:**
  - The defects and missing evidence below.
  - The contradiction in SB-COR 3.3: the nonce is reused on resume, yet the registry stores only its hash.
  - The two lists of hand-over parts (SB-COR 2.2 (4) against the role files).
  - SB-COR 4.5's "its live row" against a row that only a natural incomplete report can produce.

W-C02-25 (M2): (1) view from my field

1. PROCEED, on the frame. The registry, the start hook, the stop hook and liveness are the minimum that move package delivery and hand-over presence out of the executor's task text (SB-COR B's frame question). Claim M can be limited to "injected, and its last line echoed" and "parts present", which a mechanism can show.
2. DEFECT, on SB-COR 3.3: nonce reuse against a registry that holds only the hash. Re-emitting the same nonce on a resume (needed because the platform re-injects only when the earlier copy is gone [V]) needs the nonce or a way to rebuild it, and no place for it is stated. What would show it fixed:
   - The producer states the store, or a derivation (for example a keyed hash of the agent ID with a per-session key file).
   - Case S-R1: a second SubagentStart for the same `agent_id` emits a byte-identical last line.
   - Case S-R2: the registry file holds no nonce text, only its SHA-256.
   - Case S-R3: another `agent_id` gets a different nonce.
   - The condition names the limit: anything in the guard's log directory is readable by Read, so the nonce shows a dead Start hook, not a fabricating agent.
3. DEFECT, on SB-COR 3.4: "never traps an agent" has three open routes.
   - (a) The hook ignores the documented `stop_hook_active` input ([V], hooks page, SubagentStop and Stop input, 2026-10-20).
   - (b) Any exit 2 from the script blocks with its stderr as the reason, again at every Stop. Only exit 2 with an empty stdout and a missing-file stderr is documented as non-blocking.
   - (c) The Auto-window hand-back deny in the guard has no per-run cap, so a parser that over-blocks traps a handing-back agent where the stop hook could not.
   - What would show it fixed: the command maps every non-zero exit to exit 0 with nothing on stdout; no block when `stop_hook_active` is true; at most one hand-back denial per run. Each comes with its case and break (part (2), C-cases).
4. DEFECT, on SB-COR 3.5: "per finished run" is undefined. A run stopped by TaskStop, lost with the container or killed has a Start record and no Stop record. What would show it fixed:
   - One definition, used by `guard_report.py` and `stop_check.sh`. My proposal: the platform's end status as `subagent_audit.py`'s `end_problem` reads it; no end status means still going and not counted.
   - Cases: a running run is not counted; a `completed` run with no Stop record gives FAIL; a stopped run with a logged reason line gives PASS.
5. DEFECT, on SB-COR 3.2's "import the guard's own session-key function": there is no such function. The key is inline (`tool_allowlist.py:2260-2262`), and `guard_report.py:29,33` derives it differently (no character replacement, no 80-character cut). What would show it fixed:
   - One function, imported by the guard, both hooks, `guard_report.py`, `subagent_audit.py` and T6.
   - Cases K1 to K5 give the same key in every consumer: a `cse_` environment ID, a `session_` one, no environment with `session_id`, an ID with `.` or `/`, and an ID of 100 characters.
   - Break: one consumer keeps its own derivation, and K4 and K5 turn red.
6. DEFECT: two lists of required parts. SB-COR 2.2 (4) omits `Take-up:`; all four role files I checked list ten headings including it. What would show it fixed:
   - One constant in `subagent_audit.py`, imported by the stop hook.
   - A test extracts the backticked headings of each role file's Output list and compares them with the constant.
   - The checker's binding verdict is recognised by its front-matter keys (section 9's template), and its non-binding contribution by the headings.
   - Break: one heading dropped from the constant turns the role-file comparison red.
7. DEFECT, scope. W-C02-23's agreed approach defers two things to W-C02-25: the packages' consumer row in working order section 4's table, and the start hook in the merge gate's trigger set. This item's text lists neither. What would show it fixed:
   - `writes:` holds `plan/Installation_Working_Order.md` (row 7's "from W-C02-25" text, and a row 8: package → the role at take-up → the start hook delivers it and the stop hook checks the receipt, presence only → break: the start hook removed) and the PC addendum.
   - `writes:` also holds `tools/merge_gate.py` and `tools/test_merge_gate.py` if the trigger set grows, ordered after M1b.
8. DEFECT: which live rows hold acceptance. SB-COR 4.5 keeps an item "execution finished, not accepted" until its live row is recorded. The block-honoured row can only come from a natural incomplete report (1.2: never planted), which may not occur for days. What would show it fixed:
   - The approach names the rows that hold acceptance. My proposal:
     - Start delivered: the nonce echoed at the first Stop of an `agent_id`, with no block before it.
     - A Stop record whose `last_assistant_message` SHA-256 equals that of `subagent_audit.py last` for the same run.
     - The registry file's key equals the key of the guard log that holds that agent's calls.
     - A PostToolUse-on-Agent record.
   - The rows recorded at first natural occurrence, not holding acceptance: the block honoured; the block reason delivered, and its size. A red row reopens the item and selects its 3.7 fallback.
   - Precedent: W-C02-23's disposition 5. This reads SB-COR 4.5, so the disposition is the executor's.
9. PREFERENCE: check the per-line maxima where a change to them runs.
   - The start hook imports `HEADER` and `RESERVE` from `tools/check_role_packages.py` and declares its line maxima as literal constants.
   - The check reads them by `ast` and asserts their sum is at most `RESERVE`.
   - The trigger set gains `.claude/hooks/subagent_start.py` and the SessionStart script.
   - Otherwise only the runtime refusal holds, and it fails at delivery, not at the merge (FC13).
10. PREFERENCE: drop the `Plan` case from this item, because M1a's agreed approach already adds it. Drop the Auto-window hand-back deny. Replace it either by one guard deny of role-type Agent launches while the hook input's `permission_mode` is `auto` (it cannot trap anyone), or by naming the window's hand-overs as `subagent_audit.py`'s after-check. Reason: Auto windows are single actions named in advance (D-034 (b)), and the deny adds a guard lock-out surface and a trap route for a rare case. If it is kept, point 3 (c) applies.
11. PREFERENCE: `tools/records.py`'s role-file refusals do not depend on the hooks and can go in any pull request.
12. PROCEED, on the matcher `^(producer|researcher|prober|checker|test-designer)$`. `agent_type` is the front-matter `name` [V], and the four files I checked carry `name:` equal to their stem (observed). The static case below covers all five.

W-C02-25 (M2): (2) role-specific ask: the condition I would write

**Claim M** (a property of the flow, from the merge and sync):
- (M-a) Every role-type launch in this session leaves registry records in `<LOG_DIR>/<key>.agents`, under the guard log's own key.
- (M-b) Every run of a role type starts with the header, its package, its agent ID and the nonce on the last line, within 9,500 UTF-8 bytes. The executor gets its package at `startup`, `resume`, `clear` and `compact`.
- (M-c) A run's first Stop that lacks its required parts is blocked once, with a fixed-word reason that does not carry the nonce. The run's next Stop is allowed whatever it holds. No failure of a hook holds any agent.
- (M-d) Every opening shows, for each finished run, its Start and Stop records, blocks, late deliveries and orphan agent IDs, and `stop_check.sh` fails on them unless the log gives a reason.
- Limit: the claim is "the injected text reached the model and its last line was echoed", not that it was read or applied.

**Breaks** (each turns its cases red; run in a scratch copy of the head, one rule edited at a time):
- Registry:
  - the session key taken from the hook input's `session_id` while the environment ID is set (K1, K2);
  - `DEVOS_GUARD_LOG_DIR` ignored (case R-dir: the record lands outside the fixture directory, and the live directory's hash changes);
  - PostToolUse and Start records not merged by `agent_id` (case R-order: either arrival order gives the same merged view).
- Start hook:
  - the nonce not on the last line (S-last);
  - the nonce regenerated on resume (S-R1);
  - the nonce stored in plain text (S-R2);
  - no refusal above 9,500 bytes (S-size: a package at `LIMIT` plus a 64-character agent ID either fits or refuses with its failure record; it never emits more and never truncates);
  - the header's `sha12` computed over other bytes (S-hash: it equals the first 12 hex of the SHA-256 of the file bytes, by `HEADER`);
  - a role mapped to another role's file (S-map).
- Stop hook:
  - each part check removed: the disciplines block, each of the ten headings, the receipt, the nonce (C1 to C13);
  - the nonce compared with the current package's hash instead of the one delivered at Start (C-mid: a package changed after Start, and the report names the Start hash, is allowed);
  - the per-run cap removed (C-twice);
  - `stop_hook_active` ignored (C-flag);
  - the exit mapping removed (C-exit2);
  - the late-delivery record removed (C-late);
  - the reason carrying the nonce or the package text (C-reason);
  - the matcher widened to `.*` (M-static).
- Liveness:
  - the missing-script detection removed (L1);
  - orphan `agent_id` detection removed (L2);
  - `stop_check.sh`'s late-delivery and block-with-no-later-run FAILs removed (L3, L4);
  - the exemption-line check removed (L5);
  - the opening's synthetic run writing to the live registry (L6: the live file's SHA-256 is equal before and after).
- `records.py`: each forbidden key (`omitClaudeMd`, `hooks`, `memory`, an unknown key) and the subfolder rule removed (RF1 to RF5).

**Negative cases.** Every one is a synthetic hook input, driven through the command as `.claude/settings.json` holds it, against a fixture `DEVOS_GUARD_LOG_DIR`. Each asserts its own reason token or rule ID, which the producer states. They are:
- each missing part (C1 to C11);
- a wrong nonce (C12);
- a `Package:` hash that is not the delivered one (C13);
- a receipt only after a block, recorded as "Start not delivered" (C-late);
- a second Stop in the same run after a block, which is allowed (C-twice);
- `stop_hook_active` true, which is allowed (C-flag);
- a missing script, an uncaught exception, malformed JSON, a planted `sys.exit(2)`, and the registry lock held past the hook's bounded wait (C-exit2, C-crash, C-json, C-lock). In each the agent stops, and a "could not check" record is written.
- if kept, a hand-back lacking its parts denied once, then allowed (H1, H2);
- `records.py` RF1 to RF5;
- a fixture `settings.json` naming a missing script (L1);
- a guard log with an agent ID that has no registry Start record (L2).

**Over-blocking controls:**
- A complete hand-over, copied by tool from a filed EV record at a pinned commit (one source; EV-C02-028 part 9.7 is one), is allowed with no block.
- A checker's binding verdict in section 9's form, and a non-binding contribution, are both allowed.
- A take-up return (`NOT_NEEDED`, with Product `none`) is allowed.
- A resumed run's reply holding only the disciplines block and `Received from / Returned to:` is allowed. I pin these two as a resumed run's required parts, under SB-COR 3.4's "1.1 pins them".
- The "filled but meaningless" case (Ek C C0): every heading present with empty or `none` values passes, and is named as landing in the consumer's take-up and the stage close's sample.
- An agent that is never trapped by the stop hook: across C-twice, C-flag, C-exit2, C-crash, C-json and C-lock, no run gets more than one block, and none gets a block caused by the hook's own failure.
- Types that are never matched: `counter-designer`, `general-purpose`, `""` (internal agents [V]) and `Explore` do not match the matcher read from `settings.json` (M-static), and all five role names do.
- The six real role files pass `records.py`.
- At the head, every hook command path in `settings.json` exists.
- Static checks: each new hook entry carries a `timeout` and no `onFailure: block`.

**Counted environment:**
- Program logic: the container's `python3` (3.13.16 at writing) as the hook command in `settings.json` calls it, and git 2.43.0, in a full clone at the head, with a fixture `DEVOS_GUARD_LOG_DIR` and `CLAUDE_CODE_REMOTE_SESSION_ID` set and unset. Another interpreter is exploratory for these claims.
- Platform delivery: the working session after sync, at Claude Code 2.1.304, on Opus 5.5, in the mode the guard records (`acceptEdits` or `default`; EV-C02-023's header), with background in-process role runs, own agents only, first natural occurrence. A version change makes the rows stale.
- Not counted: `flock` under real concurrency. A break there cannot be made to turn red reliably, so it is judged by reading and named as such.

**Plan 6.12 item 4 line:**
- It compensates for: package delivery and hand-over parts resting only on the executor's task text and the role's own care (L-426 departures (3) and (4); EXP-006 S1-03 K5).
- Premise: settings hooks are picked up mid-session (P-2), and SubagentStart and SubagentStop fire for this session's background role runs with the documented fields (P-3; EV-C02-023 2.2, 2.7).
- Removal condition, measured at the C02 stage close from `guard_report.py` over the runs since the sync:
  - If no run needed a block, the stop hook is proposed for removal (its presence check duplicates `subagent_audit.py disciplines`).
  - If `Package:` and `Nonce:` are no more often correct with the start hook than the role file's own read gave before it, the start hook is proposed for removal.

**Plan 6.12 item 1 line** (the block is a hand-off parameter):
- Time added per blocked run: one continuation turn, measured from the first Stop record to the next and reported per block.
- Source: SB-COR 3.4 (2026-10-19/20).
- Checked against Batu's later decisions:
  - D-039 (the work took too long because of constant checking): one block replaces a discarded run and a rerun.
  - D-041: no bearing.
  - Today's request to finish: the one-block cap bounds the cost.
- `stop_check.sh`'s exemption needs one log line per exempt run.

**Not covered:**
- "Not covered: use; it rests on consumer rows 7 and 8 of 2.8" (row 8 added by this item).
- The hand-over's content, which is the consumer's take-up.
- That a role read or applied its package.
- Re-delivery after a compaction inside a run (only at the next run [V]).
- Internal agents, `counter-designer`, the built-in types and workflow agents (all denied).
- A session fork (`fork` is not in the SessionStart matcher).
- The nonce's secrecy from an agent that reads the store.
- `flock` under real concurrency.
- C06's routine sessions (this working session's rows do not count for them).

**Fallbacks the condition must name** (SB-COR 3.7):
- Start delivery:
  - A PostToolUse record without a Start record selects the `skills:` preload, with a marker in place of the nonce and a control role without the preload.
  - Neither record means the settings were not picked up, which selects a new session (one line to Batu), and 3.4 and 3.6a wait with it.
  - If the preload is red too, the guard requires the role's package byte for byte under its hash header in every role-type Agent prompt. There is no `updatedInput` rewrite.
- Hand-over: SubagentStop does not fire, or its block is not honoured. Then the guard checks the producing run's hand-over at the consumer's dependent Agent call, reading the run's transcript or `outputFile`, with `subagent_audit.py` as the after-check.
- Block reason too long or not delivered: the reason carries the path only, and the agent reports the hash it read.

**Interfaces the producer must state first:**
- the session-key function: its module, signature and every consumer;
- the registry record schema per event, how a run is identified (my proposal: `agent_id` plus its Start ordinal), the bounded lock wait, the nonce store, and whether it records `tool_use_id`, the prompt's SHA-256, the `Item:` line and the launch form (this answers M1's disposition 1 reopen);
- the start hook's exact line forms and maxima, its failure record, and its role-to-file map;
- the SessionStart layout (one script or two) and its combined size rule;
- the stop hook's required-part constants (first run and resumed run), its reason tokens, its record forms (allow, block, late, could not check), its timeout and the wrapper command;
- the definition of a finished run;
- `stop_check.sh`'s exemption-line grammar;
- `records.py`'s allowed front-matter keys and refusal IDs;
- whether the trigger set grows;
- each `settings.json` entry (event, matcher, command, timeout);
- the hand-back rule, if kept, with its cap.

W-C02-25 (M2): (3) smaller, joined, dropped, parallel
- Drop the `Plan` case (M1a carries it) and the hand-back deny (point 10).
- `records.py`'s refusals can move to any pull request.
- An optional split: M2a (registry, start hook, SessionStart, PostToolUse recorder, liveness) and M2b (stop hook and `stop_check.sh`). The split would show the Start row before the nonce check is built, so M2b would pin "nonce or marker" on an observed row instead of a conditional recipe. It costs one more class-high verdict (P-5). Under today's deadline I would keep one pull request with the conditional recipe; my condition supports either.
- In parallel: this condition and its tests can be written now against the stated interfaces. The build needs PR-A2 merged (the packages). Its guard edits (the session-key function, a hand-back rule) start after M1a's merge, because `tool_allowlist.py` has one writer at a time.

W-C02-26 (M3a): (1) view from my field

1. PROCEED. The change is settings only, T1 still denies every `SendMessage` call, and the change is minimal.
2. PREFERENCE, with a cheap probe first: the dependency on W-C02-25 is ordering, not technical. Nothing in M3a reads the registry. What the order buys is a readable schema, and only if the deny hides the tool from `ToolSearch`. The executor runs one `ToolSearch` for `SendMessage` at the current head (no call) and files the result raw.
   - If the schema is found: M3a has no reason to stand alone. Join it to W-C02-27 in one pull request. That removes the window where T1 is the only layer and the interim PC-45 annotation, and saves one class-high verdict.
   - If not found: run M3a first and alone, in parallel with W-C02-25's build. Its sync also gives an early, partial P-2 reading: the permission layer reloaded mid-session.
   - The order is the executor's call. I would write the condition for either.
3. DEFECT: the only control of "nothing becomes reachable" asserts only the decision (`tools/test_tool_allowlist.sh:129` uses `t`). What would show it fixed:
   - Cases asserted with `lt` and T1's rule ID, in PreToolUse and in PermissionRequest form, from the main session (`agent_id` null) and from a subagent, with `to` as an agent ID, as `main` and as a name.
   - Break: `SendMessage` added to `ALLOWED_NON_MCP`, and every case turns red.
   - `:28`'s matcher control (the hooks cover `SendMessage`) stays.
4. DEFECT, on the removal condition: if W-C02-27 is dropped, or 3.7's "SendMessage stays denied" is selected, the removed deny is PC-45's second layer lost for nothing. What would show it fixed: the condition's 6.12 item 4 line states that M3a is reverted (the deny restored and the annotation withdrawn) in those cases, and the approach names its owner.
5. PROCEED: the `isolatePeerMachines` claim is limited to its presence in the file. Its prompt is not observable and not to be tried (1.2).

W-C02-26 (M3a): (2) role-specific ask: the condition I would write

**Claim M:** after the sync, the permission layer no longer removes `SendMessage`. The guard still denies every `SendMessage` call under T1, in both events, so no message can be sent. `isolatePeerMachines` is true, `ListAgents` stays denied, and `crossSessionInbound` stays `refuse`.

**Program logic:**
- (A1) A static test on the head's `settings.json`: the deny list equals the base's list minus `"SendMessage"`, element for element; `ListAgents` is present; `crossSessionInbound` is `refuse`; `isolatePeerMachines` is `true`; every other key is byte-identical to the base.
- (A2) The T1 cases of point 3.
- Breaks:
  - `ListAgents` dropped (A1 red);
  - another deny entry dropped (A1 red);
  - `SendMessage` admitted by the guard (A2 red).

**Platform:**
- (P1) After the sync, the executor's `ToolSearch` load of `SendMessage` (no call) is filed raw as the schema row.
- If it fails while the base's probe also failed, that selects 3.7's settings fallback (a new session, one line to Batu).

**Text:**
- (X1) Working order section 10's PC-45 sentence no longer lists `SendMessage` among the settings denies, or carries a dated annotation saying T1 is the only layer for `SendMessage` until W-C02-27 is merged and synced.
- PC-45 carries the annotation.
- Section 4 step 4's "the guard denies resuming a helper (`SendMessage`)" stays true and unchanged.

**Over-blocking control:** none applies, because M3a allows nothing. Every other tool's decision is unchanged: the existing suite reads `ok`.

**Counted environment:** program logic as in W-C02-25. P1 in the working session after sync.

**Plan 6.12 item 4 line:**
- It compensates for nothing by itself: it removes the permission-layer deny so that T6 can allow some calls and the schema can be read.
- Premise: T1 denies every `SendMessage` call until W-C02-27 is merged and synced.
- Removal: reverted in the cases of point 4, or at the C02 close if no T6 allow has occurred.

**Plan 6.12 item 1 line** (only if M3a stands alone):
- Time added before M3b's recipes can pin: one pull request, verdict and sync.
- Source: SB-COR E item 5 (2026-10-19).
- Checked against D-039: point 2's probe can remove this time.

**Not covered:** "Not covered: use; M3a puts nothing into the flow, and messaging's use rests on consumer row 7 of 2.8 once W-C02-27 is in force". Also the effect of `isolatePeerMachines` and `crossSessionInbound`, and delivery to other sessions.

**Fallbacks to name:**
- settings not picked up (3.7: a new session, with M2);
- the schema without a readable target field: M3b's "SendMessage stays denied", which reverts M3a;
- a narrowing that cannot be made strict: to Batu with options.

**Interfaces:** the exact settings diff and where `isolatePeerMachines` goes; the working-order sentence and the PC-45 annotation text; T1's rule ID as asserted.

W-C02-26 (M3a): (3) smaller, joined, dropped, parallel
- Join it to W-C02-27 if the probe finds the schema now; otherwise run it alone and first, in parallel with W-C02-25.
- It touches `.claude/settings.json` like W-C02-25, so the two builds merge in order: one writer per file.

W-C02-27 (M3b): (1) view from my field

1. PROCEED, on the frame: IDs only, read from this session's registry; producers bound to their item, so a resume by message cannot route around T5 (SA:1132 [V]); PermissionRequest runs the same `decide()`.
2. MISSING_EVIDENCE: the schema row (EV-C02-023 2.21). The target field, the message field and the full key set are unknown, so the recipes stay "if the row shows key set K, then exactly K is allowed, otherwise fallback". It comes from W-C02-26's P1, or from the probe now.
3. DEFECT: "a producer's ID only from that item's consumers" has no mechanical source, because the approach's `consumer:` line is prose. What would show it fixed:
   - A stated relation T6 can compute. My proposal: the caller is the executor (`agent_id` null), or a registered agent whose own launch prompt carried the same `Item:` line (recorded by W-C02-25's PostToolUse recorder), producers excluded.
   - Cases:
     - a checker launched with item X messaging X's producer, naming X: allowed;
     - a researcher launched with no `Item:` line: refused;
     - a checker launched with item Y: refused.
4. DEFECT: "names the item T5 recorded" has no grammar. Neither where T6 reads the producer's item nor how a message names it is stated. What would show it fixed:
   - The producer states both. My proposal: the registry's item for that producer, and a whole line `Item: plan/work/W-…md` in the message text, the same grammar as T5.
   - Cases: the right item allowed; another item refused; no item line refused.
5. DEFECT: the existing `t deny SendMessage` (`:129`) stays green under T6 for any reason. What would show it fixed:
   - It is asserted with `lt` and T6's name-refusal ID.
   - A containment case: the registry unreadable or malformed refuses only `SendMessage`, as "could not check" with T6's own ID, while an unrelated call is decided exactly as before.
6. PREFERENCE, outside my field and reported to the checker's: T6 allows a producer to message the binding checker of its own item, which is a new anchoring route (D4 item 10). One rule closes it: deny `SendMessage` to a checker whose registry item equals the caller's item when the caller is a producer, with its own ID. Otherwise the condition names the route as not covered, carried only by the verdict's `received_returned` line.
7. PROCEED, on the route list (playbook F7):
   - `SendMessage` in both events;
   - the session tools' `send_message`, still denied by S rules and settings;
   - the Agent tool, whose producer launches pass T5 and with no type T4;
   - `send_later`, which only reaches this session;
   - Workflow, denied whole.

W-C02-27 (M3b): (2) role-specific ask: the condition I would write

**Claim M:** from the merge and sync, a `SendMessage` call is allowed only in these cases:
- to an agent ID held in this session's registry, or to `main` from a caller whose `agent_id` is not null;
- with only the keys the schema row shows;
- to a producer's ID only from the executor or a registered agent of the same item, with the message naming that item.
Every other call is denied, each with its own rule ID. A denied name that the registry holds exactly once gets that ID in "what to do instead".

**Negative cases** (synthetic hook inputs through the command in `settings.json`, with a fixture registry and log directory, each asserting its own ID):
- a name as `to`;
- a session reference (`session_…`, `cse_…`);
- a sibling name equal to a session name;
- a list as `to`; an empty `to`; `*`;
- an ID present only in another session's registry file;
- an ID differing by case or whitespace;
- an extra key not in the schema;
- `main` from the main session;
- a producer's ID from a non-consumer;
- a producer's ID from a consumer naming another item;
- a producer's ID with no item named;
- the containment case;
- the PermissionRequest twin of each, which must decide the same.

**Breaks:**
- T6 removed and `SendMessage` allowed: all negatives turn red.
- An ID-shape test in place of the registry read: the other-session case turns red.
- The key check removed: the extra-key case turns red.
- The null-caller check removed: the main-from-main case turns red.
- The producer rule removed: both producer cases turn red.
- The hint removed: the hint case turns red.
- The registry read under the hook input's `session_id` instead of the shared key: K1 and K2 of W-C02-25 turn red.

**Over-blocking controls** (each allowed with its allow ID):
- a message from the executor to this session's own registered helper (a checker's ID);
- a role to a registered sibling's ID;
- a role to `main`;
- the executor to a producer's ID naming its item;
- a same-item checker to that producer naming the item;
- a name held once: denied, and the denial's text carries exactly that ID;
- a name held twice: denied with no ID, as ambiguous.

**Static:**
- each role file's `tools:` gains `SendMessage`; `counter-designer.md` stays byte-identical;
- `:28`'s matcher control stays;
- the role files' other lines are byte-identical to the base.

**Counted environment:**
- Program logic as in W-C02-25.
- Platform delivery: the prober after the sync, own agents only, in SB-COR 3.6's order:
  1. the tool present in a role;
  2. the first record's target field;
  3. the executor resuming a finished role by ID;
  4. a role messaging a sibling by ID, and who receives the reply.
- Done line (3.6): a T6 allow from a role to a registered sibling's ID, answered, with the Received and Returned lines in both hand-overs. Until a real request occurs the row stays "not yet observed" and the close says so (4.5).

**Plan 6.12 item 4 line:**
- It compensates for contributions lost between subagents and returns relayed by the executor (EXP-006 P4-01's trigger, which fired: L-426; D-040 19:57Z).
- Premise: the schema shows the target in a readable field, roles can call the tool, and W-C02-25's registry holds the IDs.
- Removal: at the C02 close, if no T6 allow carried a real request with its Received and Returned lines, T6's allow branch is removed and W-C02-26 reverted.

**Plan 6.12 item 1 line:**
- "Launch a new producer; T5 checks it" puts a fresh producer launch in place of a message for each follow-up to a producer. The time it adds is one launch, measured from the first case that occurs.
- Source: SB-COR 3.6b (platform researcher P2 O4, 2026-10-19).
- Checked against D-039: it adds a launch, not a check.

**Not covered:**
- "Not covered: use; it rests on consumer row 7 of 2.8" (the hand-over's Received and Returned lines; messages are not records; no content gate).
- A message's content: "a message is input, never scope" rests on each role file's send-back step.
- Machines beyond this one: they rest on `isolatePeerMachines` [V, unobserved].
- The producer-to-checker route, unless point 6 is taken.

**Fallbacks to name** (SB-COR 3.7):
- `SendMessage` absent in a role: `ToolSearch` added to those roles' `tools:` lines.
- The target not in a readable field: `SendMessage` stays denied, the return goes by the hand-over's return state, and W-C02-26 is reverted.
- A resumed sibling's reply goes to `main`: the return goes by the return state, not an executor relay.
- The roster lists names only: IDs travel in the task's `Teammates:` line from the registry.
- The narrowing cannot be made strict: to Batu with options.

**Interfaces the producer must state first:**
- the schema row;
- T6's allow and refusal rule IDs, and "could not check";
- the item-naming grammar and where T6 reads a producer's item;
- the consumer relation of point 3;
- the agent-ID grammar and the exact-match rule;
- which session-reference patterns are refused;
- the hint's form;
- which roles gain `SendMessage`;
- the working-order passages changed (section 4 step 4's resume text and scoped re-review, and section 10's "T6 is the only layer for sessions on the same machine and the main one everywhere"), with the PC addendum.

W-C02-27 (M3b): (3) smaller, joined, dropped, parallel
- Join it with W-C02-26 if the probe finds the schema now.
- Its condition can be pinned in parallel with W-C02-25's build once W-C02-25's producer states the registry format and the schema row exists. Its tests use a fixture registry in that format.
- The build waits for W-C02-25's merge (the registry) and for the guard's single writer (after M1a and after M2's guard edits).
- The critical path is PR-A2, then M2's build and verdict, then M3b's build and verdict. M3a can come off it entirely.
- "Finished today" can honestly mean merged, with the Start rows recorded. The block row and the sibling-message row may stay "not yet observed", named at the close (SB-COR 4.5). None of these conditions is lowered to reach the day.

Guard denials: none.

## 7. Not asked

None: all five roles were asked.

## 8. The `SendMessage` probe (the test designer's W-C02-26 point 2)

The executor, 2026-10-20 about 11:00Z, in the working session, `main` `5225d5e`: one `ToolSearch` with the query `select:SendMessage`, no call. The raw result begins: "No matching deferred tools found." (the rest of the result lists MCP servers of the account that failed to connect, unrelated). So while `SendMessage` stands in `permissions.deny`, its schema cannot be read in this session.

## 9. Integration, version 1 (the executor; one round, every objection disposed)

One round was asked (the task's "Acceptance"): a second round only where a defect or missing evidence stays open. Every defect and every missing-evidence point below is taken into a block, or answered by a disposition that names what was given up and what reopens it, so no second round is run (working order section 4 step 1a: the approach is agreed when every asked role's last answer is `PROCEED` or its objection has a disposition in the block).

**Item numbering.** W-C02-26 (M3a) is not created as its own item: its scope (SB-COR 3.6a) joins W-C02-25's pull request and condition (disposition W25-1). W-C02-27 then depends on W-C02-25. This is a correction to SB-COR plan 1.0's item list, recorded here and in L-447; it changes no claim.

### 9.1 W-C02-25 (M2, with M3a), approach version 1

<!-- approach -->
base: 449df84316b3bd4dd12e48c48b53d274a59cb983
asked: producer a219e82ff883cf66f (W25 DEFECT 2 to 5 taken; PREFERENCE 6 and 8 taken; W26 MISSING_EVIDENCE 2 taken as a row; W26 PREFERENCE 3 and 4 taken); researcher ad67bb232bb50343b (W25 DEFECT 2 taken; MISSING_EVIDENCE 8 taken as an acceptance row; PREFERENCE 4 disposed (W25-6); PREFERENCE 10 taken); prober abc86b55790c7fd15 (W25 DEFECT 1 to 3 taken; PREFERENCE 4 and 5 taken; PREFERENCE 6 taken as a cross-check; W26 PREFERENCE 2 taken); checker in triage, excluded from the binding verdict, a5309384b6fd9cecb (W25 DEFECT 2 to 8 taken; PREFERENCE 9 disposed (W25-3); PREFERENCE 10 disposed (W25-9); PREFERENCE 11 taken; W26 DEFECT 5 and MISSING_EVIDENCE 3 taken; PREFERENCE 2 taken; PREFERENCE 6 disposed (W25-1)); test designer a312472717fb8bd4f (W25 DEFECT 2 to 8 taken; PREFERENCE 9 disposed (W25-9); PREFERENCE 10 and 11 taken; W26 DEFECT 3 and 4 taken; PREFERENCE 2 answered by the probe (W25-1)). One round; each note verbatim in evidence/C02/EV-C02-030_m2_m3_triage.md parts 2 to 6, the probe in part 8, this integration in part 9; every objection taken or disposed here.
not_asked: none (all five roles were asked)
library: the roles read the hooks and sub-agents pages (2026-10-20), superpowers U01B (F07, F08) and CORE 4 and 5 with U04 (F28, F30, F32), gstack CORE (P5 to P7, F2 to F4), the multi-agent assessment (C3 to C5, R4, R7), the harness study (F-HRN-07, F-HRN-08), gastown FINDINGS, EXP-006 P4-01 and S1-03 (K4), spec-kit FINDINGS (5, 7, 15), ecc METHOD-CASE, the work-environment vertical (KEY, finding 02) and the SDLC playbook's falsifiers (F7, F8). They changed: the cutoff before which runs are not counted (U04 F30), the narrowed liveness claim and the worker-restart trigger (gstack F4), the settings deny read as sharing the guard's failure mode, not a second independent layer (gstack F3), the per-run Start and Stop pairing instead of the registry as proof of life (gastown), the delivery claim "reached the model and its last line was echoed" (superpowers CORE 5, U01B F07); they justified presence-only checks at stop with content left to the consumer (multi-agent C5, U03) and the staleness of these rows at a version change (F-HRN-08).
agreed: **One pull request, one binding verdict**, for M2 (SB-COR 3.2 to 3.5) and M3a (3.6a). **Method (the producer's).** One hook script, `.claude/hooks/agent_hooks.py <Event>`, for SubagentStart, SubagentStop, PostToolUse on `Agent|Task`, and SessionStart. Each command is `python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/agent_hooks.py" <Event> || true`, with `"timeout": 15` and no `onFailure`, never the guard's fail-closed wrapper. The guard stays at index `[0]` of PreToolUse and PermissionRequest. The matcher of SubagentStart and SubagentStop is `^(producer|researcher|prober|checker|test-designer)$`, equal by test to M1a's `ROLE_TYPES` and to the role files' `name:`. SessionStart has no matcher, or one that lists `startup|resume|clear|compact|fork`. **Session key:** one function `session_key(data)` in `.claude/hooks/tool_allowlist.py`, used by `log_decision` (the refactor keeps the log path byte-identical, shown by a test) and imported by the hooks, `tools/guard_report.py` (whose own derivation goes) and `tools/subagent_audit.py`; cases K1 to K5 (a `cse_` ID, a `session_` ID, no environment ID, an ID with `.` or `/`, an ID of 100 characters) give one key in every consumer. **Registry:** `<LOG_DIR>/<session_key>.agents`, JSON Lines, append-only. Writes take `fcntl.flock` `LOCK_EX` with a bounded wait; reads take `LOCK_SH`; `DEVOS_GUARD_LOG_DIR` is honoured. Fixed keys: `time`, `event` (`launch|start|stop|session_start`), `agent_id`, `agent_type`, `name`, `item`, `form`, `tool_use_id`, `prompt_sha256`, `run`, `outcome`, `missing`, `receipt`, `package`. It holds no text and no nonce. The PostToolUse record carries `item` and the `Writer or reader:` form for every launch whose prompt has an `Item:` line, parsed with M1a's T5 functions imported from the guard (one parser). It joins on `tool_response.agentId` when present; otherwise it binds no item. Either arrival order of the launch and Start records gives the same merged view. **Nonce:** the first 16 hex of HMAC-SHA256 over `agent_id`, keyed by 32 random bytes in `<LOG_DIR>/<session_key>.nonce-key` (created once with `O_EXCL`, mode 0600). The guard denies any call by a non-null `agent_id` whose text names that file. The stop hook recomputes the nonce, so nothing is stored. Two Starts for one `agent_id` give a byte-identical last line, and another `agent_id` gives another nonce. **SubagentStart:** `additionalContext` holds the header `DevOS role package: <role>@<sha12>` (`HEADER` and `RESERVE` from `tools/check_role_packages.py`), the package's bytes, `Your agent ID: <id>`, and `Nonce: <16 hex>` as the last line. Above 9,500 UTF-8 bytes it emits nothing and records `oversize`. A test shows that the three added lines fit in `RESERVE` for the longest role name and a 64-character agent ID. **SessionStart:** plain stdout, the header plus `executor.md`, and a `session_start` record with its source and hash. **SubagentStop:** with `stop_hook_active` true, no output (a `pass` record). Otherwise the hook checks the parts the agent can supply: the disciplines block; the hand-over headings of its form, from one constant in `tools/subagent_audit.py` that a test compares with each role file's Output list, `Take-up:` included, or, for a binding verdict, section 9's front-matter keys; the `Package:` line; and the nonce when `Package:` names a delivery. If the report says `Package: none delivered` with no nonce, it records "Start not delivered" and does not block for the nonce. On a miss it blocks once: `{"decision":"block","reason":R}`, R at most 1,000 characters, naming the missing parts and the package path. R asks for the whole final message again with the parts added (so the filing by `subagent_audit.py last` stays whole) and never carries the nonce. A resumed run's required parts are the disciplines block and `Received from / Returned to:`. "Start not delivered" means no nonce in any Stop of the run. A nonce after one block is "delivered; hand-over completed after one block", not a blocker. An unreadable registry or a missing record gives `could_not_check`, with no block. If `last_assistant_message` differs from the report, the hook reads `agent_transcript_path` with `subagent_audit.py`'s `last` logic. Every failure exits 0 with no stdout. **A finished run** is one with the platform's end status as `subagent_audit.py`'s `end_problem` reads it. **Liveness** (`tools/guard_report.py`, and `tools/stop_check.sh` through `--liveness`): every hook command path in `settings.json` exists; a self-test of `agent_hooks.py` runs in a scratch log directory, never against the live registry; per finished run, its Start, Stop, outcome, receipt and item; flags `NO_START` (a guard-log `agent_id` with a platform meta file and no Start record; an ID with no meta file is internal and excluded), `BLOCK_NO_STOP` and `NOT_DELIVERED`; the executor's SessionStart records; the excluded types named. A cutoff (the first registry record) means a run that finished before it is not counted. Exemptions come from pinned lines `- **Liveness:** <agent id>: <reason>` in the newest log entry. The done line is narrowed to "scripts present and working; hooks live as of the last finished run's records", re-read after a worker restart. `tools/records.py` refuses a role file whose front matter has an unknown key, or `omitClaudeMd`, `hooks` or `memory`, or that sits in a subfolder. **M3a:** `"SendMessage"` leaves `permissions.deny`; top-level `"isolatePeerMachines": true`; `ListAgents` and `"crossSessionInbound": "refuse"` unchanged, every other key byte-identical. `lt` T1 cases cover `SendMessage` on PreToolUse and PermissionRequest, from a null caller and from a subagent, with `to` as an ID, as `main` and as a name; the case at `tools/test_tool_allowlist.sh:129` becomes `lt`. Working order section 10's PC-45 sentence changes, with a PC-45 annotation: the settings deny shared the guard's settings-loading failure mode, and T1 is `SendMessage`'s only layer until T6. No settings deny is added for `Workflow`, the built-in types or `Agent(fork)` (W-C02-24 disposition (8), reopened here and not taken). M3a is reverted (the deny restored, the annotation withdrawn) if W-C02-27 is dropped or selects "SendMessage stays denied". **Text:** working order section 4's table row 7 ("from W-C02-25") and a new row 8: the package, used by the role at take-up, delivered by the start hook with its receipt checked by the stop hook (presence only), its break being the start hook removed. Also section 9's `Teammates:` from the registry, section 10's hooks and what they do not protect, and a window rule: no role run is launched or running across an Auto window. All through a PC-53 addendum. **Trigger set:** `.claude/hooks/agent_hooks.py` joins PR-A2's trigger set in `tools/merge_gate.py`, with its case in `tools/test_merge_gate.py`. **Not built:** the `SubagentHandback` guard deny; mechanical staleness of capability rows; new counts in `guard_report.py` beyond the lines above; the `Plan` case (M1a adds it); the block-reason size row. **Claim at merge:** program logic only. **Acceptance rows** (holding the item's acceptance, each at its first natural occurrence after the sync, own agents only, a run that started after the sync): (i) Start delivered: the nonce echoed at the first Stop of an `agent_id` with no block before it; (ii) a Stop record whose `last_assistant_message` SHA-256 equals that of `subagent_audit.py last` for the run; (iii) the registry file's key equals the key of the guard log holding that agent's calls, and the `agent_id` string is the same in its Start, PostToolUse and guard records; (iv) a PostToolUse-on-Agent record. **Recorded when they occur, not holding acceptance:** a block honoured; a block reason delivered; the executor's SessionStart record; the schema row (the executor's `ToolSearch` load of `SendMessage` after the sync, no call, filed raw; W-C02-27's input). A red row reopens the item and selects its fallback. **Fallbacks named** (SB-COR 3.7): a PostToolUse record without a Start record selects the `skills:` preload with a marker; neither record means the settings were not picked up, so a new session (one line to Batu, with options) and the settings-dependent parts wait; the preload red as well means the package byte for byte in every role-type Agent prompt, checked by the guard; SubagentStop not firing, or its block not honoured, means the hand-over is checked at the consumer's dependent Agent call, with `subagent_audit.py` as the after-check. **Counted environment:** program logic, the container's `python3` (version named) through the commands as `settings.json` holds them, and git, in a full clone at the head, with `DEVOS_GUARD_LOG_DIR` in scratch and `CLAUDE_CODE_REMOTE_SESSION_ID` both set and unset; `flock` under real concurrency is judged by reading and named as such. Platform: the working session after the sync, at Claude Code 2.1.304, own agents only, with the session's source configuration named (devos at start, the library attached mid-session). **Order:** the producer's task starts after PR-A2's and M1a's merges and this item's acceptance merge. `tools/merge_gate.py` and `tools/subagent_audit.py` are written only after M1b's merge: by this task if M1b has merged by then, or else by a second producer task before the binding check (PC-24).
writes: .claude/hooks/agent_hooks.py; .claude/hooks/tool_allowlist.py; .claude/settings.json; tools/guard_report.py; tools/stop_check.sh; tools/records.py; tools/subagent_audit.py; tools/merge_gate.py; tools/test_agent_hooks.py; tools/test_tool_allowlist.sh; tools/test_merge_gate.py; tools/test_subagent_audit.py; tools/test_records_disciplines.py; plan/Installation_Working_Order.md; plan/decisions/PC-53.md; plan/decisions/PC-45.md
consumer: every role run (its package at start, its hand-over's presence at stop); the executor (its package at session start; liveness at opening and in `tools/stop_check.sh`); W-C02-27's T6 (the registry, its IDs and its caller records); each binding checker (the `Package:` line against the registry); the stage close (the per-run records)
dispositions: (W25-1) M3a joins this pull request. Notes: producer, researcher and prober said join; the test designer said join M3b if the schema is readable now, else run M3a alone and first; the checker said run M3a now, alone. The probe (part 8) shows the schema cannot be read while the deny stands, so joining M3b falls away. Running M3a alone now would put a second writer on the working order while M1 builds it (M1's `writes:`) and on `settings.json`, which this item writes (PC-24). Given up: the early schema read and the early permissions-pickup signal. Still holds: the schema row comes only after this pull request's sync, so W-C02-27's condition pins its keys as a recipe on that row, with the binary's keys (prober S8, code text) as the expected set. Reopens if M1's working-order change has merged before this item's producer starts and a separate M3a would then shorten W-C02-27's path. (W25-2) One pull request, not M2a and M2b (the checker's split; the test designer's option). Given up: the platform rows of M2a one build earlier. Still holds: the binding verdict must cover the checker's whole floor list (part 5). Reopens if the binding checker says its budget cannot hold it; the split is then made. (W25-3) The session key lives in the guard (the producer's method, the producer's field) rather than staying out of the guard with an equality test (the checker's preference). Given up: keeping the guard out of this item's floor. The guard is in the floor anyway for the key-file deny (W25-4), and one function removes `guard_report.py`'s divergent derivation (the test designer's DEFECT 5). (W25-4) The nonce key is denied to subagent calls (the checker's DEFECT 2), against the producer's "the nonce was never a secret" and the test designer's named limit. A receipt that any role could compute would show nothing about delivery. Given up: a guard edit of a few lines. Still holds: a read made inside an interpreter is not caught (working order section 10, "Not protected"). (W25-5) The `SubagentHandback` deny is dropped (all four who spoke), replaced by the window rule in the working order's text. Given up: a check of a hand-over made inside an Auto window, which `subagent_audit.py` then checks after the fact. Reopens if a role run is ever needed inside a window. (W25-6) The stop hook blocks with a short reason (the producer's method), not `additionalContext` feedback (the researcher's preference). R is at most 1,000 characters, so the undocumented size limit does not matter, and the size row and 3.7's "reason too long" fallback are dropped. Still holds: whether a block is honoured is an acceptance-free row (recorded when it occurs). (W25-7) A late receipt is not a blocker, and no block is made for a nonce the agent never had (the producer's DEFECT 5 and PREFERENCE 6). This departs from SB-COR 3.4's and 3.5's wording ("a receipt obtained only after a block is recorded as Start not delivered and counted as a blocker"), because the block's reason never carries the nonce, so a later nonce proves delivery. Reopens if a run shows a nonce it could only have had from somewhere other than the start text. (W25-8) Which rows hold acceptance (the test designer's DEFECT 8), a reading of SB-COR 4.5 made by the executor across fields. Rows (i) to (iv) hold it. A block honoured, a block reason delivered and the executor's SessionStart record are recorded when they occur, because only a natural incomplete report or a later opening can make them (1.2: never planted). Precedent: W-C02-23's disposition (5). Still holds: they stay "not yet observed" at the close, named. (W25-9) The start hook imports `HEADER` and `RESERVE` from `tools/check_role_packages.py` (one source; the producer's method and the test designer's PREFERENCE 9 in part), against the checker's PREFERENCE 10 to compare them by test. A broken `tools/` file then makes the hook emit nothing, which `|| true` contains and liveness shows. No `ast` check of line maxima is added to `tools/check_role_packages.py`, PR-A2's file: a test of this item pins the maxima against `RESERVE`. Reopens if a `tools/` change ever breaks delivery. (W25-10) EV-C02-023's rows made in another session (the researcher and the prober, already noted in W-C02-23's `open:`) are not counted for this session. The conditions rest on [V] rows and this session's observations. (W25-11) The producer asked that M1b pre-add the hook path to the trigger set. Not taken: W-C02-24's approach is under its binding check and is not reopened for one line. This item adds the path after M1b's merge.
open: the acceptance rows (i) to (iv), owner the executor with the prober at first natural occurrence; the rows recorded when they occur; the new-session branch if the settings are not picked up (Batu's action, one line with options); W-C02-24's `launch` reopen condition (disposition (1) there), now that the registry binds a launch's form to its agent ID, owner the executor
<!-- /approach -->

### 9.2 W-C02-27 (M3b), approach version 1

<!-- approach -->
base: 449df84316b3bd4dd12e48c48b53d274a59cb983
asked: producer a219e82ff883cf66f (W27 DEFECT 2 answered by W27-1; DEFECT 3 taken; MISSING_EVIDENCE 4 answered by W27-5; MISSING_EVIDENCE 5 taken as an acceptance row; PREFERENCE 7 disposed (W27-4)); researcher ad67bb232bb50343b (W27 MISSING_EVIDENCE 1 taken as a recipe on the schema row; MISSING_EVIDENCE 2 taken as a row; PREFERENCE 6 taken as 3.7's fallback; the smaller alternative taken (W27-1)); prober abc86b55790c7fd15 (W27 DEFECT 1 to 3 taken; PREFERENCE 4 and 5 taken); checker in triage, excluded from the binding verdict, a5309384b6fd9cecb (W27 DEFECT 2 taken by W27-1; DEFECT 3 answered by W27-1; DEFECT 4 taken; MISSING_EVIDENCE 5 taken as a row); test designer a312472717fb8bd4f (W27 MISSING_EVIDENCE 2 taken as a recipe; DEFECT 3 and 4 answered by W27-1; DEFECT 5 taken; PREFERENCE 6 taken by W27-1). One round; each note verbatim in evidence/C02/EV-C02-030_m2_m3_triage.md parts 2 to 6, this integration in part 9; every objection taken or disposed here.
not_asked: none (all five roles were asked)
library: the roles read the sub-agents, cross-session messaging, settings and tools pages (2026-10-20), the multi-agent assessment (C3, C4, R4, the 6.2 warning), gstack CORE (F3), the SDLC playbook's falsifiers (F7), EXP-006 P4-01 (its reopen condition, line 34) and the harness study (01, hand-off loss). They changed: checker runs reachable only from the executor (R4: a target that moves after review), routes to the same effect given the same decision (F7: the test designer's resume route), and T5 seen only on Agent calls (gstack F3); they justified "messages are not records" (P4-01 line 101, the harness study) and IDs only (sub-agents page: names are re-checked, IDs advised).
agreed: **T6 in the guard.** `SendMessage` joins `ALLOWED_NON_MCP` (not `LOCAL_TOOLS`, so L4 reads its whole input). A call is allowed only when all of these hold: the input keys are a subset of `{to, message}`, or of the keys the schema row shows if it shows fewer; any other key is denied, `notify_when_idle` and the legacy keys included; `to` is an agent ID held in this session's registry (read through W-C02-25's `session_key` and registry functions), matched exactly, with no prefix normalisation; names, lists, empty values, `*` and session references are each denied with their own rule ID; the caller is allowed for that target: an ID registered as `producer`, `test-designer` or `checker` takes messages only from `main` (the executor, `agent_id` null); a `researcher` or `prober` ID takes messages from `main` or from a registered caller; `main` as a target takes messages only from a caller registered in this session's registry; a message to the caller's own ID is denied, and so is `main` to `main`. A missing or unreadable registry denies with "no registry for this session; return it in your hand-over's Received from / Returned to". Any error inside T6 denies only that call, as `T6.0`. T6 runs unchanged on PermissionRequest, through `decide()`. The `t deny SendMessage` case (`tools/test_tool_allowlist.sh:129`) becomes `lt` with T6's name-refusal ID, and a containment case shows an unrelated call decided as before while the registry is broken. **Role files:** the `tools:` lines of `producer`, `researcher`, `prober`, `checker` and `test-designer` gain `SendMessage`; `counter-designer.md` stays byte-identical. Each of the five also changes one body line, named in the condition, so that the first role run after the sync shows whether the file was reloaded (the prober's discriminator): the new line present and the tool absent selects `ToolSearch` in `tools:`; the old body selects a new session (one line to Batu). **Working order:** section 4 step 4 (a helper is resumed by message under T6; a scoped re-review by the same checker), section 9's `Teammates:` line, and section 10's T-rules ("T6 is the only layer for sessions on the same machine and the main one everywhere"), all through a PC-53 addendum. **Fallbacks named** (SB-COR 3.7): `SendMessage` absent in a role: by the discriminator above; PreToolUse does not see `SendMessage` (a transcript shows a call with no guard record): T6 is no control, so the settings deny is restored by revert; the schema row has no readable target field: `SendMessage` stays denied, the return goes by the hand-over's return state, and M3a is reverted; a resumed sibling's reply goes to `main`: the return state, not an executor relay; the roster lists names only: IDs travel in `Teammates:`; a narrowing that cannot be made strict: to Batu with options. **Not built:** the name-to-ID hint in a denial; item-bound producer messages; `notify_when_idle`. **Claim at merge:** program logic only. **Acceptance rows**, at first natural occurrence after the sync, own agents only: (i) the tool present in a role's first run, with the discriminator's result; (ii) the first allowed `SendMessage` record, whose `to` equals the registry ID; (iii) SB-COR 3.6's done line: a message allowed by T6 from a role to a registered sibling's ID, answered, with the Received and Returned lines in both hand-overs. Until it occurs, the row stays "not yet observed" and the close says so (SB-COR 4.5). **Counted environment:** program logic as in W-C02-25; platform, the working session after the sync (or the new session the discriminator selects). **Order:** the triage is done; the condition is written once W-C02-25's producer has stated the registry format, which the condition may pin from W-C02-25's approach; the build comes after W-C02-25's merge (the registry functions; `tool_allowlist.py` has one writer); the key set is pinned from the schema row filed after W-C02-25's sync.
writes: .claude/hooks/tool_allowlist.py; tools/test_tool_allowlist.sh; .claude/agents/producer.md; .claude/agents/researcher.md; .claude/agents/prober.md; .claude/agents/checker.md; .claude/agents/test-designer.md; plan/Installation_Working_Order.md; plan/decisions/PC-53.md
consumer: every role and the executor, who send and receive messages only within this session's registry; each hand-over's Received and Returned lines, which keep the record (messages are not records, K-7 item 2); the binding checker, whose run only the executor may resume
dispositions: (W27-1) Producer, test-designer and checker IDs take messages only from the executor (the checker's and the researcher's smaller design; the checker's DEFECT 4 on verdict integrity; the test designer's PREFERENCE 6 on anchoring), against the producer's and the test designer's item-bound consumer relation. Given up: a consumer resuming a producer within its item, and a checker asking a producer directly; such requests go through the executor or a fresh launch that T5 checks. The item grammar and the consumer relation (producer DEFECT 2, test designer DEFECT 3 and 4) are no longer needed. Reopens if a fix round needs a consumer to resume a producer with its context. (W27-2) `main` is reachable only from a registered caller (the prober's DEFECT 2), not from any non-null caller as SB-COR 3.6b wrote: an internal agent with a non-null ID exists in this session (guard #83). (W27-3) Keys `to` and `message` only (the prober and the researcher), pinned against the schema row when it exists; legacy keys are denied whichever way the platform's normaliser runs. (W27-4) The name-to-ID hint is dropped (the prober and the researcher), against the producer's PREFERENCE 7 to keep it and SB-COR 3.6b's text: role launches carry no name (20 meta files), and IDs travel in `Teammates:`. (W27-5) W-C02-22's break B19 (`tests/C02/W-C02-22/breaks.py:246`, `SendMessage` added to a role's `tools:` line) is that item's fixture, run at its own head, not a standing check: no gate or `tools/stop_check.sh` runs it. W-C02-22's acceptance stays tied to its own head, and this item's condition names B19's premise as changed. W-C02-22's own approach moved `SendMessage` in `tools:` to this item (its disposition (2)), which answers the test designer's point (d). (W27-6) The done line holds the acceptance as SB-COR 3.6 writes it, so the item may stay "execution finished, not accepted" at the branch's close, named there (4.5).
open: the schema row (owner the executor, after W-C02-25's sync); the acceptance rows (i) to (iii), owner the executor with the prober; the new-session branch if role files do not reload (Batu's action, one line with options)
<!-- /approach -->


## Addendum, 2026-10-20 (W-C02-27.1, disposition W271-9; EV-C02-039)

Lines 484, 495 and 617 above read the platform's program as having a normaliser that deletes the six legacy keys of `SendMessage`'s input before the hook, and concluded that denying those keys is safe whichever way it runs; W-C02-27's disposition W27-3 and its cases N-K2 to N-K8 rest on that reading. It was a misreading. At Claude Code 2.1.304 the strip-only function is a fallback used when the tool cannot be resolved; the live path, `backfillObservableInput`, deletes any caller-sent legacy key and then adds `type`, `recipient`, `recipient_kind` and `content` back, derived from `to` and `message`, to the copy the hook receives, after `coerceInput` has derived `summary` (W-C02-27.1's researcher `ac276961647514c80`, findings 1 to 4 and 8, stated in code; EV-C02-039). The first real call after W-C02-27's sync was therefore denied by T6.1 (guard record #4295; EV-C02-023 R-26), and every call would be. The lines above stay as written; this addendum is their correction, and W-C02-27.1 rewrites T6's key check against the input the platform delivers.
