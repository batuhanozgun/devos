---
id: EV-C02-039
title: "W-C02-27.1 (T6's key check against the platform's real SendMessage input; W-C02-27 row (ii) red at guard record #4295): team triage, two rounds, the integrated approach, and the acceptance condition's hand-over"
stage: C02
kind: observation
source: "round 1: researcher ac276961647514c80, prober a0af1624f9cd84007, producer afa58577986640b22, test designer a9c72999c83948ff1, checker in triage ad97f09223020d9da; round 2: researcher a1e05112ad7090e4e, prober a19dc4c435af738d6, producer a513b866ecf2bbe62, test designer a85385642d3420b60, checker in triage a39b9d35ea84a63f3; each taken with tools/subagent_audit.py last after its end status, DISCIPLINES OK"
---

# EV-C02-039 · W-C02-27.1: the team triage

Filed by the executor. The tasks are copied by tool from each run's first message in the session's transcript, without the discipline block (working order section 9, verbatim, not repeated here); the notes are verbatim as `tools/subagent_audit.py last` returned them, but for a few library paths and one documentation address written as `[library id: …]` or `[docs page: …]`, where the leak check matched a run of them. The integrated approach block is `plan/work/W-C02-27.1.md`'s, merged with this record; its `asked:` line cites this record and its dispositions W271-1 to W271-13 answer every objection below. No role messaged another: `SendMessage` was denied to every caller by T6.1 throughout (the observation that opened the item), so requests went through the executor and the hand-overs' return lines.

**Scratch files the notes name** (under the session's scratchpad, not filed): the round-1 producer's `sm_chunk.txt` and `tool_chunk.txt` hold extracts of the platform's program and are not to be filed in a public repository; the prober's and producer's probe scripts and outputs stay in the container.

## 1. Round 1, researcher `ac276961647514c80`

### Task

Item: plan/work/W-C02-27.1.md

**Purpose:** team triage, round 1, of a new item W-C02-27.1 (working order section 4 step 1a; D-039). The decision it serves: how guard rule T6 (W-C02-27, merged by #439, merge `6a6585c`) must change so that a real `SendMessage` call from the executor (`main`) or from a role registered in this session passes, with the narrowing W-C02-27 agreed kept strict (target only `main` or an agent ID this session's registry holds, matched exactly; the caller rules of T6.7; no other session; the keys checked), and what stays denied.

The observation that opened it (natural occurrence, the first `SendMessage` call after W-C02-27's sync, Claude Code 2.1.304 by `get_session`'s `container_cc_version`): at 2026-10-20T18:32:59Z the executor called `SendMessage` with exactly two keys, `to` (a registered checker's agent ID, `aa8570fed063c7083`) and `message`, to resume that checker after it stopped at its turn limit. The guard denied it, record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, rule `T6.1`, reason: "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}". So the hook's `tool_input` is not what the model sent: the platform adds keys before `PreToolUse` (the "legacy-key normaliser" that W-C02-27's condition point 10 row (ii) asked about: "keys in the record against keys in the input"). The schema row (EV-C02-036, the `ToolSearch` schema: `to`, `message`, optional `summary` and `notify_when_idle`) did not show it. With T6 as merged, every `SendMessage` call is therefore denied, from any caller; there is no direct messaging, and requests go by the hand-overs' `Received from / Returned to` lines. By SB-COR 4.5 a red row reopens W-C02-27 and selects its fallback; the nearest named one is W-C02-27's point 11 recipe ("a required key outside {to, message}, or the body under another name → this condition and the test's `ALLOWED_KEYS` go back to the test designer for a new version"). The executor's own reading, a hint and not evidence: this is an over-blocking defect of T6's key check against the platform's real input, not a reason to drop T6.

Facts not yet settled (each is a role's field): which keys and values the hook sees for a call from `main` and from a subagent, on `PreToolUse` and on `PermissionRequest` (is `message` kept? is `content` equal to it? `recipient` equal to `to`? what `type` and `recipient_kind` hold? is `summary` derived from `message` when the caller sends none?); whether the shape depends on the version; what the guard logs of such a call (its record's `summary` is redacted and truncated).

**Your question (researcher):** what do the primary sources state about the transformation of `SendMessage`'s input before hooks see it, at Claude Code 2.1.304: the official documentation (hooks reference: what `tool_input` holds for a tool; the `SendMessage` and agent-teams pages), the changelog entries naming `SendMessage`, `recipient`, `content`, legacy fields or input normalisation, and the installed Claude Code package itself in this container (find where it is installed; read, never run it) for the code path that builds `SendMessage`'s hook input: which keys it adds, from what, under which conditions (caller main or subagent, a `summary` given or not, `PreToolUse` or `PermissionRequest`), and whether `to` and `message` are kept unchanged. Settle what a source states with path and line, reading date and version; say what is not stated; do not decide the design.

**Acceptance:** none yet: this triage comes before the item's condition, which the test designer writes after the approach is agreed (working order section 4 steps 1a, 2 and 2a). W-C02-27's condition (`plan/work/W-C02-27.md` on `main` `add6608`) stays as merged.

**Consumer:** the executor, who integrates the five round-1 notes into W-C02-27.1's approach block, files them in an EV record that the block's `asked:` cites, and asks round 2; the producer and the test designer, who build and pin against what the platform does.

**Inputs:** `plan/work/W-C02-27.md` (its condition, points 1 to 11, and its approach); `.claude/hooks/tool_allowlist.py` (T6, `decide()`, the logging of a call's summary); `tools/test_send_message.py`; EV-C02-035 (the documentation read before the build), EV-C02-036 (the schema row), EV-C02-037 (the build record); CHK-C02-149; the guard record #4295 (read it yourself); working order section 10 ("Messages between agents"); SB-COR 3.6, 3.6b and 3.7. `main` is at `add6608ef6bcef5d7240a9d6666fe171c6d5e971`. Library line (from your map): `research/studies/context-memory-harness-engineering/` (what a session and its hooks actually see) and `research/INDEX.md` for the route; the question is mainly about the platform's own sources, so the library may bear little: say so in D9 if it does not.

`Teammates:` none reachable by message: `SendMessage` is denied to every caller until this item merges (the observation above). Return anything for another role in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, which the executor takes with `tools/subagent_audit.py last` and files verbatim in W-C02-27.1's triage EV record.

**Writer or reader:** reader: you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 60 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/researcher/` only.

**Constraints:** no `SendMessage` call, for any purpose, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017; negative cases are synthetic only). The installed Claude Code program is read, never executed, because the guard denies `claude` command lines (working order section 10, Shell) and running it would start another session.

Your take-up and returns: see your role file.

### Note (verbatim)

Package: researcher@bfb9d1e8e5e9
Nonce: b27300722d3f31df
Take-up: PROCEED. The question holds and could change the decision. Whether the extra keys come from the platform or from the model, whether `to` and `message` survive, and whether the added values can be derived all decide what T6's key check can admit. Depth chosen: a primary-source check, mainly the installed program, the documentation and the changelog, plus a brief library route. These sources are the only ones that can settle what the hook receives. The library was searched in case it held a counter-case. Reading date for everything is 2026-10-20. Claude Code version is 2.1.304 (the program's chunk headers say "Version: 2.1.304", 299 occurrences).

## Disciplines (D1–D9)
D1: yes: I tested two framings against the code and the transcript ("the model sent the keys" against "the platform adds them before PreToolUse"); only the second fits, and I left the design open.
D2: yes: I treated the executor's reading ("an over-blocking defect, not a reason to drop T6") as a hint, settled only what the sources state, and did not argue for any design.
D3: no
D4: yes: EV-C02-030 claimed that denying the legacy keys is safe whichever way the normaliser runs; I checked that claim against the code (citation fidelity, M5) and found it false (finding 8).
D5: yes: page answers came through the small model or were cut, the guard summary is truncated, and the transcript turned out to be a derived view, so I worked from raw copies, named the windows, and compared the transcript with the hook record key by key.
D6: yes: I traced the cause to two code steps (summary derivation in coerceInput, then the four added keys in backfillObservableInput) rather than stopping at the symptom (the T6.1 denial).
D7: no
D8: yes: the work depends on W-C02-27 as merged and on record #4295; I read the record, the transcript entry and W-C02-27's lines myself rather than relying on the task's summary of them.
D9: yes: I consulted the library: no hits under context-memory-harness-engineering; one ECC note bears only as a general counter-case (a hook written against an assumed input shape); it changed nothing.

Read, and what each changed:
- /opt/node22/bin/claude, which is a symlink to /opt/claude-code/bin/claude (same file, sha256 prefix ea0f135784631619, 288,730,480 bytes). I read it with grep -a and dd and never ran it. Byte offsets used:
  - ~238085913: chunk-kpcfpydw, the legacy-key list, mjo and ujt.
  - ~244854036 to 244856000: JPr and T2n, the coerceInput.
  - ~249178371: PPn and fvr, which parse the input, then validate it, then make the backfill copy.
  - ~249265149: yvr, the PreToolUse runner.
  - ~248825951: the PreToolUse hook input builder.
  - ~248828443: the PermissionRequest hook input builder (VFe).
  - ~248317195 and 248319790: the callers of VFe.
  - ~249306515: the tool-run path that hands observableInput to the hooks and the permission check.
  - ~246287050: OGe and pFo, which revalidate a hook's updatedInput.
  - ~254371860 and 254428938: kd and bd, which backfill the tool_use blocks of messages.
  - ~271284107: the SendMessage tool definition, including backfillObservableInput and Us.
  - ~239205330 and 239210728: Ih="main" and d5s.
  - ~236251096: the agent-ID pattern.
  - ~240016045: the local_ session pattern.
  - ~237603101 and 237609972: the width-truncation helper `as` and its export.
  This changed the work: it is the primary source for findings 1 to 5.
- /tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl:
  - Line 4295 (record #4295): justified the work, and I measured the derived summary in it.
  - All guard logs: there is exactly one SendMessage record, on PreToolUse, from `main`, rule T6.1. There is none on PermissionRequest.
- /root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba.jsonl, the entry for tool_use toolu_01Tii7PmwDMAu5gR9YkSfPGU. I read only key names, lengths and equality tests; no message text is copied here. This changed the work (finding 4).
- The changelog, https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md. I first read the window from 0 to 100,000 through WebFetch. Then I downloaded the whole file (1,057,524 bytes; newest heading 2.1.304) to the scratch folder and searched it in full. This limited the work: nothing names the mechanism (finding 7).
- https://code.claude.com/docs/en/hooks (269,024 characters). Windows 0 to 100,000 and 100,000 to 200,000 went through the model; the window from 200,000 to the end I searched raw. This limited and justified the work (finding 6).
- https://code.claude.com/docs/en/tools-reference, read raw, the SendMessage row at line 49 of the saved copy. It justified the summary rule.
- [docs page: agent-teams], read in full. It bore on nothing about hook input.
- /home/user/devos/.claude/hooks/tool_allowlist.py:473-474 and 2422-2427: T6.1's text and check. Justified the work.
- /home/user/devos/plan/work/W-C02-27.md:37, 65, 92, 95: N-K1 to N-K9, point 10 row (ii), the approach, and W27-3. Changed the work (finding 8).
- /home/user/devos/evidence/C02/EV-C02-030_m2_m3_triage.md:484, 495, 521, 617: the earlier reading of the normaliser. Changed the work (finding 8).
- Library: Grep under [library id: context study] for SendMessage, tool_input and PreToolUse found no files. Grep across research/ found 13 files. Of these I opened [library id: ECC note 10]:25-26 and [library id: soul-context review of 2026-09-07]:52. Bore on nothing beyond a general counter-case.
- Deliberately not read:
  - research/INDEX.md: the question is about the platform's own code.
  - tools/test_send_message.py and EV-C02-035, 036 and 037 in full: that is the test designer's and the producer's ground.
  - The derivation helper `kr` (the first-line rule) and the suffix used by the truncation helper `gt`: their observable outputs settle what is needed.
  - PostToolUse input: outside the question.

Relied on:
- The SendMessage tool defines `backfillObservableInput`, which works on a copy of the input. Stated in code: binary ~271284107.
- That copy is what PreToolUse receives. fvr returns `callInput` (unchanged) and `observableInput` (the backfilled copy). The run path passes `observableInput` to yvr, then to KFe, then to the builder, which sets `tool_input` from it. Stated in code: ~249178371, ~249306515, ~249265149, ~248825951.
- The PermissionRequest hook receives the input of the permission check. That input is the same `observableInput`, or a PreToolUse hook's updatedInput if one was returned. Interpreted from code (~249306515: hvr called with At; ~248319790: VFe called with `updatedInput ?? r`); never observed.
- `summary` comes from coerceInput (T2n), not from the backfill. The coerced input is what the schema parses, so `summary` is in both the call input and the hook input. Stated in code: ~244854720 and the PPn code next to ~249178371.
- No step on this path branches on the caller (`agentId`). Interpreted from code: T2n, backfillObservableInput, Us, fvr, and the PreToolUse input builder, whose agent fields (Rte) sit outside `tool_input`.
- Observed values for the 18:32:59Z call, from the transcript and guard record #4295:
  - The transcript's input keys are content, message, recipient, recipient_kind, to and type.
  - recipient equals to. type is "message". recipient_kind is "agent".
  - content is 50 characters, the start of message, ending in "…".
  - message has 850 characters on one line.
  - The guard record's derived summary is 200 characters ending in "…".
- The documentation and changelog statements cited in findings 6 and 7. Stated.

Unsure:
- I did not observe a subagent's call, a PermissionRequest for SendMessage, a call that supplies its own summary, a structured (object) message, or a `notify_when_idle` call. The code says how each behaves (findings 1 to 3), but these are interpretations. A synthetic or natural record after the fix would settle each.
- Version stability. Nothing documents the backfill (finding 7), so a later version could change it silently. Re-reading the binary at each version, or a pinned record check, would settle it.
- Whether the `message` key reaches the hook unchanged is stated in code and inferred from the T6.1 detail, which lists `to` and `message` as not extra. The guard's own summary leaves out `message` and `content`: its visible part starts at `recipient`, although keys sorted alphabetically would start at `content`. So the record cannot show the body. A test record with the body's length or hash would settle it; that is the producer's ground.
- The exact derivation helper (`kr`). The documentation says the first line is used; I did not read the helper.

For: the executor, who files this verbatim in W-C02-27.1's triage EV record and integrates it into the approach block. It also serves the producer and the test designer, who build and pin against the input the platform really delivers.

Received from / Returned to:
- Taken from the executor: this task. Nothing was returned.
- For the executor: EV-C02-030:484, 495 and 617 rest on a misreading of the binary (finding 8), and W-C02-27 W27-3 and N-K3 to N-K8 inherit it. This is a premise to reopen, not a design call I make.
- For the test designer: `ALLOWED_KEYS` and N-K2 to N-K8 meet the real shape described in findings 1 to 3. W-C02-27 point 10 row (ii) compares two derived views (finding 4).
- For the producer: the guard's logged summary of a SendMessage call leaves out `message` and `content` (observed at #4295).
- None was sent by message (SendMessage is denied).

Product:

**Question.** At 2.1.304, what do the primary sources state about how SendMessage's input is transformed before hooks see it? Which keys are added, from what, and under which conditions, and are `to` and `message` kept? This serves the decision on how T6 must change so that a real call from `main` or from a registered role passes, with the agreed narrowing kept strict.

**Findings.**

1. The four added keys come from the tool's backfill step. Stated in code, binary ~271284107; the conditions use mjo and the legacy-key list at ~238085913.
   - It runs only when `to` is present and either `message` or `notify_when_idle` is present.
   - If `to` is not a string, it deletes the six legacy keys (`type`, `recipient`, `recipient_kind`, `content`, `request_id`, `approve`) and adds nothing.
   - In one repair case it changes nothing: `message` is null or missing, and `summary` holds a slipped `<parameter name="message">` opener.
   - Otherwise it first deletes all six legacy keys, whatever the model sent, and then sets new values:
     - For a string message: `type` = "message", `recipient` = `to`, `recipient_kind` = Us(`to`), and `content` = `message` truncated to a display width of 50.
     - For an object (protocol) message: `type` = the message's `type`, plus `recipient`, `recipient_kind`, `request_id` if it is a string, `approve` if it is boolean, and `content` = the reason or feedback truncated to 50.
     - For a call with `notify_when_idle` and no message: the body is taken as "", so `type` = "message" and `content` = "" are added.
   - Us(`to`) gives:
     - "session" for an address starting with `uds:` or `bridge:`, or one matching `^local_[0-9a-f-]{8,72}$`.
     - "main" when `to` is exactly "main".
     - "agent" when the normalised `to` matches `^a(?:<prefix>-)?[0-9a-f]{16}$` (~236251096).
     - "name" otherwise.
   - `to`, `message`, `summary` and `notify_when_idle` are never touched by this step.

2. Where the backfill applies. Stated in code at ~249178371, ~249306515 and ~248825951; the PermissionRequest part is interpreted at ~248319790.
   - After the tool's own validation, Claude Code copies the input and backfills the copy. The PreToolUse hook gets that copy as `tool_input`.
   - The permission check runs on the same copy, or on a PreToolUse hook's updatedInput. The PermissionRequest hook receives the input of that check.
   - The tool itself runs with the input that was not backfilled (interpreted from the call path).
   - A hook's returned updatedInput is revalidated, and the backfill runs on it again (~246287050, interpreted). The changelog at 2.1.300 states that updatedInput is validated like Claude's own input and unknown keys are dropped.

3. Where `summary` comes from. Stated in code, T2n at ~244854720, with the limit Rbt=200; the documentation agrees (tools reference, SendMessage row).
   - When `message` is a string and `summary` is missing or blank, coerceInput derives `summary` from the message.
   - A summary longer than 200 characters is cut to 199 plus "…".
   - A non-empty summary of 200 characters or less is left as given.
   - The derivation does not depend on the `tengu_deep_feather` flag; that flag only controls the slipped-summary split.
   - So an ordinary call from `main` or from a subagent reaches PreToolUse with seven keys: `to`, `message`, `summary`, `type`, `recipient`, `recipient_kind` and `content`.

4. What the transcript records. Observed, and the record it gives is not the model's raw input.
   - The transcript's tool_use input for the 18:32:59Z call holds the four backfilled keys but no `summary`. Code: kd and bd at ~254371860 and ~254428938 backfill the model's tool_use block before it is passed on.
   - The hook input held `summary` as well (the T6.1 detail).
   - So the transcript is neither what the model sent nor what the hook saw. The comparison W-C02-27 point 10 row (ii) planned ("keys in the record against keys in the input" from `subagent_audit.py calls`) compares two derived views (inference).
   - The observed values match finding 1: content is 50 characters ending in "…"; recipient equals to; kind is "agent"; the summary is 200 characters ending in "…".

5. Main and subagent callers get the same input shape. No step on the path branches on the caller (interpreted from code). Only `main` has been observed.

6. What the documentation states (hooks page, read 2026-10-20; windows named above).
   - PreToolUse receives `tool_name`, `tool_input` and `tool_use_id`.
   - Before hooks run, Claude Code makes `file_path` absolute for Write, Edit and Read, and injects `plan` and `planFilePath` for ExitPlanMode.
   - PermissionRequest receives `tool_input` "like PreToolUse".
   - Not stated anywhere on the hooks page, the tools reference or the agent-teams page: SendMessage's `tool_input`, the legacy keys, or the backfill.
   - The tools reference states that the summary is derived from the first line and capped at 200 characters. It does not say hooks see it.

7. What the changelog states (newest heading 2.1.304, searched in full).
   - No entry names `recipient`, `recipient_kind`, backfill, observable input, or SendMessage's hook input.
   - Nearby entries:
     - 2.1.77: resume with SendMessage({to}).
     - 2.1.89: hooks receive an absolute `file_path`.
     - 2.1.222: a long summary is truncated, not rejected.
     - 2.1.236: the fix for message text slipping into the summary field.
     - 2.1.292: plugin hooks see repaired arguments.
     - 2.1.300: updatedInput is validated.
   - So the backfill is undocumented. When it started, and whether it will change, is not stated.

8. Citation fidelity (M5).
   - EV-C02-030:484 read the binary as having a normaliser that deletes the six legacy keys. Lines 495 and 617 concluded that denying them is safe whichever way it runs.
   - The strip-only function (ujt) is used only as a fallback, when the tool cannot be resolved (bd at ~254371860).
   - The live path is the backfill, which deletes and then re-adds four of the six keys on every ordinary call.
   - W-C02-27 W27-3 ("legacy keys are denied whichever way the platform's normaliser runs") and N-K2 to N-K8 rest on that misreading. That is why every SendMessage call is denied.

**Counter-evidence and alternatives.**
- No source states that the model itself sent the extra keys.
- Three code signatures point to the platform: content cut to 50 characters with "…", summary cut to 200 with "…", and recipient equal to to.
- The tool's own schema row lists only `to`, `message`, `summary` and `notify_when_idle`, which is consistent with keys added outside the model's call.
- Places I looked for counter-evidence: the changelog in full, three documentation pages, EV-C02-030, W-C02-27, guard and transcript records, and the library (13 hits, none on this mechanism; ECC note 10:25-26 shows only the general risk of a hook written against an assumed input shape).
- An alternative reading, that `recipient_kind` or `type` vary by caller, finds no support in the code.

**For the decision.** This changes the premise, not the design, which is not mine to make.
- With T6 as merged, every ordinary call is denied, because the hook always sees `summary`, `type`, `recipient`, `recipient_kind` and `content` besides `to` and `message`.
- At 2.1.304 each added value is a set function of `to` and `message`, or of the caller's own summary, so they can be checked:
  - `recipient` = `to`.
  - `type` = "message".
  - `recipient_kind` follows from Us(`to`); a registered agent ID gives "agent" and "main" gives "main".
  - `content` = the first 50 display columns of `message`.
  - `summary` = the caller's own, or one derived from `message`, capped at 200.
- Because the backfill deletes any legacy keys the model sent before setting its own values, the model cannot plant its own values for those four keys on the ordinary path. It can still send its own `summary`.
- Key presence alone can no longer tell "the model sent it" from "the platform added it".
- The same shape is expected from `main` and from a subagent, and on PermissionRequest (interpreted, never observed).
- Since the mechanism is undocumented, any pin against it depends on the version.

Guard denials: none

## 2. Round 1, prober `a0af1624f9cd84007`

### Task

Item: plan/work/W-C02-27.1.md

**Purpose:** team triage, round 1, of a new item W-C02-27.1 (working order section 4 step 1a; D-039). The decision it serves: how guard rule T6 (W-C02-27, merged by #439, merge `6a6585c`) must change so that a real `SendMessage` call from the executor (`main`) or from a role registered in this session passes, with the narrowing W-C02-27 agreed kept strict (target only `main` or an agent ID this session's registry holds, matched exactly; the caller rules of T6.7; no other session; the keys checked), and what stays denied.

The observation that opened it (natural occurrence, the first `SendMessage` call after W-C02-27's sync, Claude Code 2.1.304 by `get_session`'s `container_cc_version`): at 2026-10-20T18:32:59Z the executor called `SendMessage` with exactly two keys, `to` (a registered checker's agent ID, `aa8570fed063c7083`) and `message`, to resume that checker after it stopped at its turn limit. The guard denied it, record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, rule `T6.1`, reason: "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}". So the hook's `tool_input` is not what the model sent: the platform adds keys before `PreToolUse` (the "legacy-key normaliser" that W-C02-27's condition point 10 row (ii) asked about: "keys in the record against keys in the input"). The schema row (EV-C02-036, the `ToolSearch` schema: `to`, `message`, optional `summary` and `notify_when_idle`) did not show it. With T6 as merged, every `SendMessage` call is therefore denied, from any caller; there is no direct messaging, and requests go by the hand-overs' `Received from / Returned to` lines. By SB-COR 4.5 a red row reopens W-C02-27 and selects its fallback; the nearest named one is W-C02-27's point 11 recipe. The executor's own reading, a hint and not evidence: this is an over-blocking defect of T6's key check against the platform's real input, not a reason to drop T6.

**Your question (prober):** what the platform and environment show now about this, by discriminating observation that plants nothing: (1) the full record #4295 and its neighbours (what the guard logged of the call: key names, values, the `summary` it built; whether a `PermissionRequest` record exists for the same tool use); the executor's own transcript entry for that tool use (`/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba.jsonl`, tool use `toolu_01Tii7PmwDMAu5gR9YkSfPGU`: the input the model sent); and whether any earlier `SendMessage` record exists in this session's guard log or any role transcript since W-C02-27's sync (17:03:04Z). (2) Which facts remain unknown that the design needs (the shape for a subagent caller; on `PermissionRequest`; `content` against `message`), and what observation would settle each without a planted live denial: for example a natural call after the fix, decided in advance, or a reading of the installed program (the researcher reads the sources). (3) Running the merged guard on a synthetic hook input reproducing #4295's shape in a scratch copy: which rule decides it, as a reproduction. Record raw results; state the environment and version for each.

**Acceptance:** none yet: this triage comes before the item's condition, which the test designer writes after the approach is agreed (working order section 4 steps 1a, 2 and 2a). W-C02-27's condition (`plan/work/W-C02-27.md` on `main` `add6608`) stays as merged.

**Consumer:** the executor, who integrates the five round-1 notes into W-C02-27.1's approach block, files them in an EV record that the block's `asked:` cites, and asks round 2; the test designer, who pins the shape you observe.

**Inputs:** `plan/work/W-C02-27.md` (its condition, points 1 to 11, and its approach); `.claude/hooks/tool_allowlist.py` (T6, `decide()`, the logging of a call's summary); `tools/test_send_message.py`; EV-C02-035, EV-C02-036, EV-C02-037; CHK-C02-149; working order section 10 ("Messages between agents"); SB-COR 3.6, 3.6b and 3.7. `main` is at `add6608ef6bcef5d7240a9d6666fe171c6d5e971`. Library line (from your map): `research/studies/ecc/` `METHOD-CASE.md` (small probes that discriminate, with negative controls) and `research/studies/gstack/CORE.md` (whether a check really ran).

`Teammates:` none reachable by message: `SendMessage` is denied to every caller until this item merges. Return anything for another role in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, which the executor takes with `tools/subagent_audit.py last` and files verbatim in W-C02-27.1's triage EV record.

**Writer or reader:** reader: you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 60 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/prober/` only.

**Constraints:** no `SendMessage` call, for any purpose, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017; negative cases are synthetic only); the guard's behaviour on a given input is observed by running the guard script on a synthetic hook input in a scratch copy made by a script into a directory with no `.claude/` tree, because B5 denies a copy-like command naming a `.claude` path (working order section 10, known over-blocking).

Your take-up and returns: see your role file.

### Note (verbatim)

Package: prober@69e1e10d0cd7
Nonce: 5d5bb79c0a24c689
Take-up: PROCEED. The task holds. Part (3) is a reproduction of a test I set myself. Following M1, I wrote its criterion to /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/prober/criterion.txt before any run, and I have not edited it since. Parts (1) and (2) only read records that already exist and plant nothing. I made no SendMessage call.

## Disciplines (D1–D9)
D1: yes: I tested the three ways the extra keys could have arisen (the model sent them, the guard made them up, the platform added them) against three separate sources: the transcript's `wireToolInputs`, the transcript's `input`, and the guard's detail line.
D2: uncertain: the executor's own reading ("over-blocking defect") was a hint, so I fixed the outcome criteria before running and I report only what the platform shows, not a design.
D3: no
D4: yes: I added negative and positive controls (C1, C2, V3). Runs 1 and 2 never reached T6, so I count them as environment failures, not results, and only run 3 counts.
D5: yes: the guard's summary leaves out `message` and `content` and cuts at 300 characters, so I went back to the transcript and list what record #4295 cannot show.
D6: yes: I separated the proximate cause (keys added by the platform) from the detection gaps: the schema row shows what the model sees, `subagent_audit.py` reads the normalised `input`, and the tests pin the legacy keys as denied.
D7: no
D8: yes: before any run I checked that HEAD is `add6608`, that the scratch guard files hash the same as the live ones, and that the guard is live (it logged my own calls, including denial #4341).
D9: yes: I read ecc METHOD-CASE section 4 and gstack CORE P6. They supported labelling each substituted input and counting runs that never reached the check as "did not reach", not as fails.

Read, and what each changed:
- /tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl, records #4270–4300 and searches across all 4,321+ lines. This is the core evidence for part (1).
- /tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.agents, lines 30–42. It gave the checker's registry type, and showed the outside-scope fact about the checker reported below.
- /root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba.jsonl, lines 6879 (the tool use) and 6880 (the result). This changed the frame: it holds two different input shapes for the same call.
- The checker's subagent transcript (`subagents/agent-aa8570fed063c7083.jsonl`), lines 737–746. Outside scope only.
- A search of every transcript in /root/.claude/projects/-home-user-devos/ for SendMessage tool uses. This settled whether any earlier call exists.
- /home/user/devos/.claude/hooks/tool_allowlist.py lines 572–595 (`summary`), 2403–2524 (T6, `decide`), 2566–2572 (`session_key`); /home/user/devos/.claude/hooks/agent_hooks.py lines 97–179. These defined the reproduction.
- /home/user/devos/plan/work/W-C02-27.md lines 35–37, 63–68, 92. Point 10(ii) had foreseen this comparison; N-K3 to N-K8 pin the legacy keys as denied.
- /home/user/devos/tools/subagent_audit.py lines 221 and 379; /home/user/devos/tools/test_send_message.py lines 39–40 and 246. These limit how point 10(ii) can be checked (see Unsure).
- /home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md, sections 2 item 3 and 3 (D1–D9). /home/user/devos/.claude/protocols/ does not exist; section 2 item 3 points there, but the full texts are in section 3 of Ek D, which I used.
- Library: /home/user/agentic-os-search/research/studies/ecc/METHOD-CASE.md section 4 and /home/user/agentic-os-search/research/studies/gstack/CORE.md P5–P7. These supported the approach; they changed no result.
- Deliberately not read: EV-C02-035/036/037, CHK-C02-149, SB-COR, and the installed program under /opt/claude-code. The program's sources are the researcher's to read. I only noted that the directory exists.

Relied on:
- The model sent exactly `{to, message}`. Source: the transcript line 6879 field `wireToolInputs.toolu_01Tii7PmwDMAu5gR9YkSfPGU`. [O]
- The transcript's `input` for the same tool use has keys `to, message, type, recipient, recipient_kind, content`, with no `summary`. Values: `type:"message"`, `recipient:"aa8570fed063c7083"` (equal to `to`), `recipient_kind:"agent"`, and `content` set to the first 49 characters of the message followed by "…". The transcript also shows `input_transformations: []` and `"version":"2.1.304"`. [O]
- The hook's input had the keys `content, recipient, recipient_kind, summary, type` in addition to `to`. Source: the detail of #4295, which is built from the input's keys (`tool_allowlist.py:2425`). [O]
- The hook's `summary` value is the first 199 characters of the message followed by "…" (200 in all), counted from #4295's summary. [O]
- `recipient` in the hook input is "aa8570fed063c7083" and `recipient_kind` is "agent", read from #4295's summary. [O]
- The hook's `type` value is cut off by the guard's 300-character limit (`tool_allowlist.py:595`). [O]
- `message` being present in the hook input is not shown by #4295: the summary leaves it out (line 587) and the check exempts it. It is likely present, because the transcript's `input` has it. [I]
- So there are three shapes. What the model sent: `{to, message}`. The transcript's `input`: that plus four legacy keys. The hook input: that plus `summary`. [O, plus the [I] above]
- Only one SendMessage record exists in this session's guard log (#4295), and only one SendMessage tool use exists across all transcripts in the project directory, including every role transcript. So there was none after the 17:03:04Z sync other than this one. [O]
- No PermissionRequest record exists for SendMessage. The 43 PermissionRequest records carry `tool_use_id: null`, so I matched on tool name; none is SendMessage. [O]
- The hook entry for #4295 records `agent_id: null`, `mode: "default"` and `effort: "high"`. [O]
- In `decide()`, L4 runs before T6 for SendMessage; run 3 shows L4 passed on #4295's shape. [O]
- `subagent_audit.py` reads `b["input"]` (the normalised shape), not `wireToolInputs`. [O]
- `test_send_message.py:40` pins `LEGACY_KEYS` as denied (N-K3 to N-K8), which is the opposite of what the platform sends. [O]

Unsure:
- U1, what a subagent caller sends: never observed, because no subagent has ever called SendMessage. V2 assumes the executor's shape. Settled by: the researcher reading /opt/claude-code (does normalisation and building the hook input depend on the caller?). And/or: decide in advance that the fixed guard logs the sorted key names (and whether each value matches `to`/`message`) for every SendMessage, allowed or denied. Then the first natural subagent call after the fix answers it without planting anything.
- U2, PermissionRequest: not reached, since PreToolUse denied the call. Whether it fires after an allow (the logged mode is now "default"), and with which `tool_input`, is unknown. Settled by: reading the program, or the records of the first natural allowed call.
- U3, `content` against `message`: the hook's `content` value was never logged. Which field the recipient actually receives is unknown. Settled by: reading the program, or the recipient's transcript at the first allowed delivery.
- U4, how `summary` and `content` are derived: is it a fixed cut or a cut at a word, what happens when the message is under 200 characters, and what happens when the model sends its own `summary`. Settled by: reading the program.
- U5, whether the added keys change for `to:"main"` (for example the `recipient_kind` value) or for other versions: only 2.1.304 with an agent-ID target has been seen. V2 assumed "agent". Settled by: reading the program, or a natural call to main after the fix.
- U6, the comparison in point 10(ii) ("keys in the record against keys in the input") cannot be made with `subagent_audit.py calls` as it stands. That script reads the normalised `input`; what the model sent is only in `wireToolInputs`.

For: the executor, who files this in W-C02-27.1's triage EV record and integrates it into the approach block. The test designer, who should pin these shapes: what the model sends `{to, message}`, the transcript `input` with four legacy keys added, and the hook input with `summary` also added. The test designer should also note that the N-K2 to N-K8 cases contradict the platform's real hook input.

Received from / Returned to: I took the task from main. I returned nothing and sent no messages. Outside my scope, for main:
- (a) The checker aa8570fed063c7083 had not stopped when the message was attempted at 18:32:59Z. The registry has no stop record between its run-1 start (17:38:26Z) and a run-2 start at 18:32:37Z. That second start coincides with a background-task notification delivered to the checker (its transcript line 741). The checker kept working (guard #4296, #4298, #4300) and stopped "complete" at 18:35:53Z. So the premise "resume after it stopped at its turn limit" needs checking. [O/I]
- (b) The guard has logged the executor's mode as "default" since #121 (09:27:21Z); the last "acceptEdits" record is #119. CLAUDE.md names Accept edits. This may already be known (F5).
- (c) Denial #4341 (B5) treated an `echo` in a read-only command as a write into ~/.claude. That is over-blocking of the kind known from working order section 10. It is for the executor's guard report.

Product:
- **Test and claim.** Claim: the merged guard (main `add6608`) denies #4295's shape by T6.1, on its key check alone. Environment:
  - Date: 2026-10-20, runs between 18:37:55Z and 18:39:58Z.
  - HEAD: `add6608ef6bcef5d7240a9d6666fe171c6d5e971`.
  - Session: `session_01JDJ8fJQmrKpXfiRh1yEoxv`; guard mode "default", effort "high".
  - Claude Code 2.1.304, as the transcript's `version` field and the task (`get_session`) state it. I did not run the command line.
  - Model: claude-opus-5-5.
  - The container's `python3`; I did not record its version.
  - The scratch guard files have the same sha256 as the live ones: `tool_allowlist.py` dca5ab32…71ac, `agent_hooks.py` 7cc44c91…81a3.
  - Synthetic inputs, all labelled: session key `session_synthW271`, with `CLAUDE_CODE_REMOTE_SESSION_ID` and `DEVOS_GUARD_LOG_DIR` set to scratch; the message cut short; `content` taken from the transcript's preview, not the hook's actual value (unknown); a synthetic registry holding aa8570fed063c7083 as checker and a1111111111111111 as prober.
- **Steps:**
  1. Setup. Clone /home/user/devos into …/w271/prober/src (exit 0). `python3 -I copy.py src g` copied the two hook files into a directory with no `.claude` in its path (exit 0, "copied"). `python3 -I build.py in` wrote R1, C1, C2, V1, V2, V3 and registry.agents (exit 0).
  2. Run 1, `./run.sh` with the guard in `g/`. Every case was denied by L4, "could not check: the token formats cannot be read from …/w271/tests/C02/W-C02-07/shared". This is an environment failure: ROOT is two directories above the hook file. Not a result. Raw output: …/w271/prober/raw_run1.txt.
  3. Run 2, guard in `rt/hooks/`. Same environment failure, with the path now under …/prober/tests. Not a result. Raw output: raw_run2.txt.
  4. Run 3, guard in `rt/c/hooks/` with `rt/tests/C02/W-C02-07/shared` copied from the clone. Every guard exit was 0. Raw output: raw_run3.txt; scratch log records: raw_run3_log.txt. Against the criterion:
     - R1 (#4295 shape, agent_id null): deny T6.1, "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}; only to and message are admitted". This is the same rule and the same detail as #4295, and the summary prefix also matches. Pass: the reproduction holds.
     - C1 (`{to, message}` only, with the registry): allow T6, "a message to a registered checker from the executor (main), in this session's registry". Pass: the added keys alone cause the denial.
     - C2 (`{to, message}` only, no registry): deny T6.9, "no registry for this session (cannot read the registry: No such file or directory)". Pass: the step after the key check runs.
     - V1 (the transcript's `input` form, no `summary`): deny T6.1, listing content, recipient, recipient_kind, type. Pass.
     - V2 (assumed shape: a registered prober sending to main with the added keys): deny T6.1, listing all five. Pass. No caller passes with the added keys.
     - V3 (a prober sending to main with `{to, message}`): allow T6, "a message to main from a registered prober". Pass.
  5. Checked afterwards: the live log still holds exactly one SendMessage record, and the live registry holds no synthetic record.
- **Not run:**
  - Any live SendMessage call (forbidden by the task's constraint).
  - Any reading of /opt/claude-code (the researcher's).
  - Any observation for U1 to U5 (none possible without a natural call).
  - The container `python3` version (not recorded).

Guard denials: #4341, rule B5, at 18:36:1xZ. My command started with `cd /root/.claude/projects/...`, and the guard read the `echo` in it as a write into ~/.claude. I reran it as a reader-only pipeline (`sed -n … | grep -o … | cut`) naming the absolute path, which is the form the rule's own text allows. I did not record it with `tools/guard_report.py`, because I write nothing in /home/user/devos; the executor should record it.

All scratch files are under /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/prober/: criterion.txt, copy.py, build.py, run.sh, in/, raw_run1.txt, raw_run2.txt, raw_run3.txt, raw_run3_log.txt.

## 3. Round 1, producer `afa58577986640b22`

### Task

Item: plan/work/W-C02-27.1.md

**Purpose:** team triage, round 1, of a new item W-C02-27.1 (working order section 4 step 1a; D-039). The decision it serves: how guard rule T6 (W-C02-27, merged by #439, merge `6a6585c`) must change so that a real `SendMessage` call from the executor (`main`) or from a role registered in this session passes, with the narrowing W-C02-27 agreed kept strict (target only `main` or an agent ID this session's registry holds, matched exactly; the caller rules of T6.7; no other session; the keys checked), and what stays denied.

The observation that opened it (natural occurrence, the first `SendMessage` call after W-C02-27's sync, Claude Code 2.1.304 by `get_session`'s `container_cc_version`): at 2026-10-20T18:32:59Z the executor called `SendMessage` with exactly two keys, `to` (a registered checker's agent ID, `aa8570fed063c7083`) and `message`, to resume that checker after it stopped at its turn limit. The guard denied it, record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, rule `T6.1`, reason: "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}". So the hook's `tool_input` is not what the model sent: the platform adds keys before `PreToolUse` (the "legacy-key normaliser" that W-C02-27's condition point 10 row (ii) asked about). The schema row (EV-C02-036) did not show it. With T6 as merged, every `SendMessage` call is therefore denied, from any caller; there is no direct messaging. By SB-COR 4.5 a red row reopens W-C02-27 and selects its fallback; the nearest named one is W-C02-27's point 11 recipe ("a required key outside {to, message}, or the body under another name → this condition and the test's `ALLOWED_KEYS` go back to the test designer for a new version"). The executor's own reading, a hint and not evidence: an over-blocking defect of T6's key check against the platform's real input. The exact keys and values the hook sees for a subagent caller and on `PermissionRequest` are being read by the researcher (sources) and the prober (records) in parallel.

**Your question (producer, triage):** your take-up of the item, and from your field: is a change needed (or another method, or none), and which; reuse; the method you would choose for T6's key check against a normalised input (for example: admit the normaliser's keys only when each is consistent with `to` and `message`, or read the target from one field and refuse disagreement; which field is authoritative when `to` and `recipient` differ; what `type` and `recipient_kind` values pass; whether `summary` stays refused when the caller did not send it); the interfaces the test designer should pin (rule IDs kept or added, the key grammar); the `writes:` paths; lock-out (a T6 bug blocks only `SendMessage`, never the revert route); the cost; whether to split. Say what you need settled first by the researcher's and prober's facts.

**Acceptance:** none yet: this triage comes before the item's condition, which the test designer writes after the approach is agreed (working order section 4 steps 1a, 2 and 2a). W-C02-27's condition stays as merged.

**Consumer:** the executor, who integrates the five round-1 notes into W-C02-27.1's approach block, files them in an EV record that the block's `asked:` cites, and asks round 2; the test designer, who pins the interfaces you state.

**Inputs:** `plan/work/W-C02-27.md` (its condition and its approach); `.claude/hooks/tool_allowlist.py` (T6, `decide()`, the call summary); `tools/test_send_message.py`; `tools/test_tool_allowlist.sh`; EV-C02-035, EV-C02-036, EV-C02-037; CHK-C02-149; working order section 10 ("Messages between agents"); SB-COR 3.6, 3.6b and 3.7. `main` is at `add6608ef6bcef5d7240a9d6666fe171c6d5e971`. Library line (from your map): `research/studies/superpowers/CORE.md` with `notes/U04-testing-diagnosis-and-verification.md` (before you write code against a test) and `research/studies/gstack/CORE.md` (a green result for a check that did not run).

`Teammates:` none reachable by message: `SendMessage` is denied to every caller until this item merges. Return anything for another role in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, which the executor takes with `tools/subagent_audit.py last` and files verbatim in W-C02-27.1's triage EV record.

**Writer or reader:** reader: this is a triage; you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 60 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/producer/` only.

**Constraints:** no `SendMessage` call, for any purpose, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017; negative cases are synthetic only).

Your take-up and returns: see your role file.

### Note (verbatim)

Package: producer@d379362747dd
Nonce: 83616f5288a6917a
Take-up: PROCEED. A change is needed, and it is the one the executor reads: T6.1 refuses every real call. The cause is now shown in the platform's code text and in this session's transcript, not inferred. Claude Code 2.1.304 has a `backfillObservableInput` step that adds keys to what the hook sees. It first deletes any caller-sent legacy keys, then writes `type`, `recipient`, `recipient_kind` and `content` from `to` and `message`. The hook also gets a `summary` that the transcript's tool_use does not hold. W27-3's premise, "legacy keys are denied whichever way the platform's normaliser runs", mixed up two functions. The normaliser (`ujt`, which deletes legacy keys) is real. The backfill adds derived keys back for observers. So a key set of {to, message} cannot be met by any real call. The method I propose stays inside the item's purpose and keeps every narrowing of W-C02-27 except one, which I name below (refusing a `summary` the caller sent). I tried the method in a scratch clone.

## Disciplines (D1–D9)
D1: yes: I weighed four methods (ignore the added keys; rebuild the platform's exact values; read the target from `recipient`; check each added key against `to` and `message`) and chose the last, with my reasons in point 3.
D2: yes: the executor's reading pulled toward "just admit the keys", so I read the binary's backfill and the executor's own tool_use record myself, and found two facts beyond that reading: the transcript is itself backfilled, and `summary` appears only in what the hook sees.
D3: yes: the goal is working messages with the strict narrowing kept, so each v1 rule is kept and shown in the probe (T6.6, T6.7 and T6.1 for `notify_when_idle`, `request_id`, `approve` and unknown keys); the one rule given up (refusing a caller's `summary`) is named, and the platform rows stay open.
D4: yes: W27's 162 green checks never ran the real input shape, so I recommend test fixtures copied literally from record #4295 and the transcript, and I state that my scratch probe is not independent assurance.
D5: yes: the guard's log summary drops `message` and `content` and cuts at 300 characters, so I read the transcript's tool_use input and the binary's text directly instead of relying on the summary.
D6: yes: the fault comes from the platform adding derived keys after the model's input, so the fix targets the key check's premise and checks each added key, rather than adding names to an allow-list.
D7: no
D8: yes: this continues W-C02-27 on the merged state, so I checked that `main` and my scratch clone are both at add6608ef6bcef5d7240a9d6666fe171c6d5e971 before testing.
D9: yes: I read superpowers U04 ("exercise the real behavior"; expected values not derived from the code under test) and gstack CORE P6 (false green); together they justify the literal real-shape fixtures in point 4.

Read, and what each changed:
- /home/user/devos/.claude/hooks/tool_allowlist.py:462-487 (the T6 RULES), :572-595 (`summary()`, which drops `message` and `content`), :2403-2472 (`send_message_checks`) and :2475-2519 (`decide`). These are what the change is made against.
- /home/user/devos/plan/work/W-C02-27.md, whole: points 1, 4, 10 (ii), 11, Not covered, the approach and W27-3. This set the narrowing to keep and showed that point 11's recipe applies.
- EV-C02-036 (the schema row: `additionalProperties:false`, `summary` and `notify_when_idle` optional). It limited the design: the schema does not show the backfill.
- EV-C02-035 (grep for summary and normaliser lines) and EV-C02-030:484, :495 and :617 (the earlier S8 binary reading). These changed the work: they are where the wrong normaliser premise comes from.
- CHK-C02-149, lines 43, 57, 63 and 65, and EV-C02-037 (grep only). No change.
- /home/user/devos/plan/Installation_Working_Order.md:215 (section 10 states "a subset of `to` and `message`"). This adds a write.
- /tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl record #4295. Justified the work.
- /root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba.jsonl, grep of tool_use `toolu_01Tii7PmwDMAu5gR9YkSfPGU` only. This changed the work (see Relied on).
- /opt/claude-code/bin/claude, text greps for the SendMessage tool chunk, `k1r`, `ujt`, `xs`, `Us`, `Ih`, `GBt` and `backfillObservableInput`. This changed the method: it gives the exact values the backfill writes.
- /home/user/devos/tools/test_send_message.py:39-48, :93-247 and :505-507. I reused its harness for my probe.
- tools/test_agent_hooks.py:1091 (G cases send only {to, message}). Reading it shows they are unaffected.
- Library: superpowers/notes/U04 lines 15-21 and 57-68, and gstack/CORE.md P6 and P7. These justified point 4.
- Not read on purpose: the documentation pages (the researcher's) and `tools/subagent_audit.py` output (the prober's). I did not read `tools/test_tool_allowlist.sh` beyond the condition's mention of :129, because T6's cases live in the W27 test.

Relied on:
- [observed] Record #4295 (PreToolUse, `agent_id` null) carries the keys content, message, recipient, recipient_kind, summary, to and type. Its summary shows `recipient` = "aa8570fed063c7083", `recipient_kind` = "agent", and `summary` = the message's first ~200 characters ending in "…".
- [observed] The executor's tool_use in the transcript is stored as {to, message, type:"message", recipient:"aa8570fed063c7083", recipient_kind:"agent", content:"Continue SB-COR 4.5's closing check from where yo…"}, with no `summary`. So the transcript holds the backfilled input, and the hook's input is a further step on (it also has `summary`).
- [observed, code text, 2.1.304] `backfillObservableInput(s)` does the following:
  - It returns at once unless `to` is present with `message` or `notify_when_idle`.
  - If `to` is not a string, it only deletes the legacy keys (`xs`).
  - It then deletes the caller's legacy keys (`xs`).
  - For a string `message` it sets `type`="message", `recipient`=`to`, `recipient_kind`=`Us(to)` and `content`=`as(message,50)`.
  - For an object `message` it sets `type`=`message.type`, `recipient`, `recipient_kind`, `request_id`, `approve`, and `content` from `reason` or `feedback`.
- [observed, code text] `Us(to)` returns "session" for a session scheme or `/^local_[0-9a-f-]{8,72}$/`, "main" when `to` === "main", "agent" when `d5s(to)` holds, and "name" otherwise. `k1r` = [type, recipient, recipient_kind, content, request_id, approve].
- [inferred] A model cannot plant the values of these four keys, because `xs` deletes caller-sent ones first. The consistency check therefore guards against another platform version or code path, not against the caller.
- [inferred] `summary` is filled by the platform from the message's first line, at most 200 characters (`Rbt`=200; the schema text says "Defaults to the first line"). The hook cannot tell it apart from a `summary` the caller sent.
- [observed, scratch] The prototype passes the real shape and keeps every v1 refusal (Product, Tests).

Unsure:
- Where `summary` is added, and whether every hook input carries it. My method takes either case. The researcher can settle it from the binary (`coerceInput` `T2n`, `applySplit`).
- Whether a subagent caller's PreToolUse input and a PermissionRequest input get the same backfill. My method takes both the raw and the backfilled shape. The prober can settle it at the first real calls after the sync, but PermissionRequest may never fire, because PreToolUse decides first.
- Whether every registered ID makes `d5s` true (that is, `recipient_kind` "agent"). This is observed for one ID, `aa8570fed063c7083`. If it fails for some ID, the call is denied T6.10 (fail closed). The researcher can settle it by reading `ug(mo(e))`.
- Whether `message` can be an object for these callers (the schema code reads `Ss(Hs).default(Vs)`). This is my PREFERENCE 3c below.

For: the executor, who folds this into W-C02-27.1's approach block and asks round 2; the test designer, who pins point 4; the researcher and the prober, for the facts listed under Unsure.

Received from / Returned to:
- Taken: this triage, from the executor.
- To the test designer, through the executor (not done by me):
  - (a) W-C02-27 point 10 (ii)'s comparison ("keys in the record against keys in the input" from `subagent_audit.py calls`) cannot show what the model sent, because the transcript stores the backfilled input. Row (ii) needs a new form in W-C02-27.1.
  - (b) The merged W27 test's N-K2 goes red under any fix that admits `summary` (measured: 2 BAD). W-C02-27's test and condition "stay as merged", and they conflict with the fix: SCOPE_CONFLICT for the executor. Point 11's recipe (a new version of the test) settles it.
- To the executor: EV-C02-030 S8's reading (normaliser direction) and W27-3's premise were wrong; that is a record correction. The working order's section 10 sentence (line 215) states the old key set. T6.1's "What to do instead" tells the caller to send only `to` and `message`, which it already did; the text should say "if you sent only to and message, report this denial to the executor as a guard finding".

Product:
Triage note (round 1, M1):
1. Need: DEFECT, and a change is needed. The smallest deliverable is T6's key check rewritten against the platform's real input, plus the test's new version and the section 10 sentence. Left out: role files, `tools/test_agent_hooks.py` and `tools/test_tool_allowlist.sh`. Not needed: a new hook or event; reading the transcript at decision time.
2. Reuse: `send_message_checks` and its T6.0 catch (tool_allowlist.py:2421-2472, :2512-2518), the RULES table pattern (:469-487), and the W27 harness (`Fixture`, `both`, `msg` in tools/test_send_message.py:93-195), which my probe imported unchanged.
3. Method:
   - Chosen: check each added key against `to` and `message`.
   - Admitted keys: `to` and `message`. Then the four backfill keys {type, recipient, recipient_kind, content}, all four together or none. Then `summary`, optional.
   - Each added key must agree:
     - `type` must equal "message".
     - `recipient` must be a string equal to `to` byte for byte.
     - `recipient_kind` must be "main" when `to` is "main", and "agent" otherwise.
     - `content` must be a string.
     - `message` must be a string.
     - `summary`, if present, must be one string.
   - `to` is the field that counts. It is the schema field the send uses, and the platform copies it into `recipient`. A disagreement is denied, never resolved by picking one.
   - `recipient_kind` adds strength: it is the platform's own judgement that `to` will be routed as an agent ID, so a "name", "session" or "local_" reading is refused even before the registry is read.
   - Rejected methods:
     - (i) Ignore the added keys: this leaves a `recipient` disagreement and the platform's routing kind unchecked.
     - (ii) Rebuild the exact `content` and `summary` (50 and 200 character cuts with "…"): this ties the guard to the platform's cutting rules and brings the over-blocking back with each version (FP6 in reverse).
     - (iii) Read the target from `recipient`: that is not the schema field, and it is absent in a raw input.
     - A prefix check of `summary` against the message: kept as a fallback PREFERENCE only, for the same version-coupling reason.
   - Given up from W27-3: refusing a caller's own `summary`. The hook cannot tell it from the platform's default, so refusing it means refusing every call. `summary` is a label "not transmitted" to a subagent target, and L4 still reads it.
   - PREFERENCE 3a: run the `recipient_kind` check after the target is resolved, so that a real name (backfilled with kind "name") still gets T6.6's instruction ("use the ID from Teammates:"). My prototype runs it before the registry read and gives T6.10 (NEG-13).
   - PREFERENCE 3b: a structured message is refused (T6.10 through `type` or `message`). This narrows v1's "Not covered" line on message type.
   - PREFERENCE 3c: require `message`, when present, to be a string even in the raw shape, so the decision does not depend on whether the backfill ran.
4. Interfaces to pin:
   - Rule IDs: T6 and T6.0 to T6.9 keep their meanings.
   - T6.1 covers: a key outside {to, message, summary, type, recipient, recipient_kind, content}; a partial backfill set; `request_id`; `approve`; `notify_when_idle`; any unknown key. Its detail names the keys.
   - New T6.10, "a platform key disagrees with to and message", with the detail naming the key.
   - Order: T6.1, then T6.2 to T6.5, then T6.10 (subject to PREFERENCE 3a), then T6.9, T6.8, T6.6, T6.7.
   - Allow cases on both events: the observed shape copied literally from record #4295 and the transcript (`to`, `message`, `type`:"message", `recipient`=`to`, `recipient_kind`:"agent", or "main" for main, `content` of 49 characters plus "…", `summary` of up to 199 characters plus "…"), from main and from a registered subagent; the same shape without `summary`; and the raw {to, message} (existing P-1 to P-13).
   - Deny cases: each disagreement above; a partial set; `request_id`; `approve`; an object message.
   - New breaks: B-16, the consistency check removed (`recipient` ≠ `to` is allowed); B-17, the target read from `recipient`.
   - Keep N-K1 and N-K3 to N-K9 (a single legacy key is a partial set, so still T6.1; measured). N-K2 flips to allow.
5. Writes:
   - `.claude/hooks/tool_allowlist.py` (T6 constants, `send_message_checks`, RULES T6.1 text and T6.10): the producer.
   - `tools/test_send_message.py` (`ALLOWED_KEYS`, N-K2, new cases): the test designer.
   - `plan/Installation_Working_Order.md` section 10 line 215, through a PC-53 addendum: the executor.
   - `plan/work/W-C02-27.1.md`.
   - The build EV record.
   - No other open item writes these files, as far as I know; the executor should check `writes:` against open items.
6. Lock-out: the new code sits inside `send_message_checks`, under T6's existing catch. Any error becomes T6.0 for that one call; a refusal blocks only `SendMessage`. The revert route (a pull request through the github MCP tools, then `tools/sync_worktree.sh`) does not pass through T6. A future platform version that adds a key fails closed as T6.1 with the key named; its named fallback is point 11's recipe again.
7. Cost (measured on the prototype): 18 lines added and 2 removed in the guard, plus about 2 RULES lines. The test needs about 15 new cases × 2 events and one flipped case (estimate). Then one test-designer run, one producer run and one binding verdict; small on the critical path (estimate).
8. Split: no. One writer per file and one pull request. W-C02-27's platform rows (i) to (iii) cannot happen before this item merges, so W-C02-27.1 should carry them or name them as W-C02-27's open rows.
9. Binding check: in a full clone at the head, container python3 3.13.16, through the two settings commands with a scratch `DEVOS_GUARD_LOG_DIR`. The real-shape allow is first shown live at the first natural `SendMessage` after W-C02-27.1's sync. Its live row compares the guard record with the transcript's backfilled input, never with "the raw model input", which no record holds.

Needed first from the researcher and prober: whether `summary` is always present in the hook input; whether the hook input for a subagent caller and on PermissionRequest has the same shape; and `d5s`'s grammar for registered IDs. None of these blocks the method, which takes either answer. They decide only fixture details and PREFERENCE 3a/3c.

**Files:** none in /home/user/devos. Scratch only, under /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/producer/:
- `patch.py`: the prototype edit.
- `probe.py`: 19 cases × 2 events.
- `clone/`: a fresh clone at add6608, with the prototype applied to `clone/.claude/hooks/tool_allowlist.py`.
- `sm_chunk.txt` and `tool_chunk.txt`: binary text extracts. They hold platform code; do not file them in a public repository.

**Tests:**
- `python3 tools/test_send_message.py --only guard`, in the clone with the prototype: exit 1, "W27 FAIL 2 BAD, 0 NOT RUN, 160 ok". The only BAD is N-K2 on PreToolUse and PermissionRequest (expected deny T6.1, got allow T6), as intended.
- The same run without the prototype: "W27 PASS 162 checks".
- `python3 ../probe.py .claude/hooks/tool_allowlist.py` with the prototype: exit 0, "PROBE PASS 0". OBS-1 to OBS-4 allow T6 on both events. NEG-1 to NEG-15 are denied with their pinned IDs: T6.10, T6.1, and T6.7 and T6.6 kept.
- The probe without the prototype: "PROBE FAIL 30". Every OBS case is denied T6.1, which reproduces #4295.

**Where it ran:** /usr/bin/python3 3.13.16 in this container. The clone is at add6608ef6bcef5d7240a9d6666fe171c6d5e971. The guard was driven through `.claude/settings.json`'s two hook commands, with the script path swapped by the W27 harness and a scratch log directory. The binary read is Claude Code 2.1.304 (from its "// Version: 2.1.304" header).

Guard denials:
- #4411, rule B5. A `python3 -I` one-liner named a path under ~/.claude (the transcript) while reading the denied call's tool_use. I made no write and did not pursue that route. I read the same lines with plain `grep -o` and `sed -n`, which the denial lists as allowed readers. I did not record it with `tools/guard_report.py`, because this task writes nothing in /home/user/devos; the executor should record it.

## 4. Round 1, test designer `a9c72999c83948ff1`

### Task

Item: plan/work/W-C02-27.1.md

**Purpose:** team triage, round 1, of a new item W-C02-27.1 (working order section 4 step 1a; D-039). The decision it serves: how guard rule T6 (W-C02-27, merged by #439, merge `6a6585c`) must change so that a real `SendMessage` call from the executor (`main`) or from a role registered in this session passes, with the narrowing W-C02-27 agreed kept strict (target only `main` or an agent ID this session's registry holds, matched exactly; the caller rules of T6.7; no other session; the keys checked), and what stays denied.

The observation that opened it (natural occurrence, the first `SendMessage` call after W-C02-27's sync, Claude Code 2.1.304 by `get_session`'s `container_cc_version`): at 2026-10-20T18:32:59Z the executor called `SendMessage` with exactly two keys, `to` (a registered checker's agent ID, `aa8570fed063c7083`) and `message`, to resume that checker after it stopped at its turn limit. The guard denied it, record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, rule `T6.1`, reason: "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}". So the hook's `tool_input` is not what the model sent: the platform adds keys before `PreToolUse` (the "legacy-key normaliser" that W-C02-27's condition point 10 row (ii) asked about: "keys in the record against keys in the input"). The schema row (EV-C02-036) did not show it, and W-C02-27's tests built their synthetic inputs from the schema, so they were green against an input shape the platform never sends. With T6 as merged, every `SendMessage` call is denied, from any caller. By SB-COR 4.5 a red row reopens W-C02-27 and selects its fallback; the nearest named one is W-C02-27's point 11 recipe ("a required key outside {to, message}, or the body under another name → this condition and the test's `ALLOWED_KEYS` go back to the test designer for a new version"). The exact keys and values the hook sees for a subagent caller and on `PermissionRequest` are being read by the researcher (sources) and the prober (records) in parallel.

**Your question (test designer, triage):** your take-up; what this item must show and what would show it false: which existing cases of `tools/test_send_message.py` (and `tools/test_tool_allowlist.sh`, `tools/test_agent_hooks.py` where they assert T6) rest on the schema shape and must change or be joined by cases on the normalised shape; the positive cases (a real call from `main` and from a registered role, in the observed shape, allowed), the negative cases kept strict (a `recipient` disagreeing with `to`, a name or another session in either field, an extra key outside the normaliser's, and the rest of W-C02-27's N cases), and the breaks that turn them red; how the test's synthetic input is tied to the real shape (from record #4295 and the sources, not from the schema) so that this class of miss, a test fed a shape the platform does not send, cannot recur silently; the live row that holds acceptance (the first natural allowed `SendMessage` record after the sync), with its outcomes decided in advance; or "no new test, because X already shows it", if that holds. Do not write the condition or the tests yet.

**Acceptance:** none yet: this triage comes before the item's condition, which you write after the approach is agreed (working order section 4 steps 1a, 2 and 2a). W-C02-27's condition stays as merged.

**Consumer:** the executor, who integrates the five round-1 notes into W-C02-27.1's approach block, files them in an EV record that the block's `asked:` cites, and asks round 2.

**Inputs:** `plan/work/W-C02-27.md` (its condition, points 1 to 11, and its approach); `.claude/hooks/tool_allowlist.py` (T6); `tools/test_send_message.py`; `tools/test_tool_allowlist.sh`; `tools/test_agent_hooks.py`; EV-C02-035, EV-C02-036, EV-C02-037; CHK-C02-149; the guard record #4295; working order section 10; SB-COR 1.1, 3.6b and 3.7. `main` is at `add6608ef6bcef5d7240a9d6666fe171c6d5e971`. Library line (from your map): `research/studies/anthropic-ai-native-sdlc-playbook/` (its falsifiers: configuration tested like code; passing tests that fail on the live state) and `research/studies/gstack/CORE.md` (a check that did not run must not read as green).

`Teammates:` none reachable by message: `SendMessage` is denied to every caller until this item merges. Return anything for another role in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, which the executor takes with `tools/subagent_audit.py last` and files verbatim in W-C02-27.1's triage EV record.

**Writer or reader:** reader: this is a triage; you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 60 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/test-designer/` only.

**Constraints:** no `SendMessage` call, for any purpose, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017; negative cases are synthetic only).

Your take-up and returns: see your role file.

### Note (verbatim)

Package: test-designer@9f8557260d35
Nonce: 324e740cfc59bfbc
Take-up: PROCEED. The task holds and needs new tests. No existing case shows the shape the hook actually receives: every T6 case in the three test files builds `{to, message}` from the schema. One correction to the record goes with this answer. It is not a reframing. The platform does not run a "legacy-key normaliser" before the hook. It runs three steps on the input. (1) It deletes any of the six legacy keys the model sends. (2) `coerceInput` builds a `summary` from `message` when the model sent none. (3) `backfillObservableInput` adds `type`, `recipient`, `recipient_kind` and `content`, each derived from `to` and `message`. The transcript is not the hook's input either: it holds six keys and no `summary`. The plan file `plan/work/W-C02-27.1.md` does not exist yet. I worked from the task text and W-C02-27.

## Disciplines (D1–D9)
D1: yes: I weighed three options (ignore or strip the platform's keys; admit them by name only; admit them only when each value matches what the platform derives) and two orders for the new check; the recommendation depends on whether `message` is in the hook input, so I made that conditional and returned it to the researcher.
D2: uncertain: the task says the executor sent "exactly two keys", and there is pressure to get messaging working; I checked the stored transcript input (six keys) and kept every strict case, whatever that does to the unblocking.
D3: yes: I kept the item's purpose (real calls pass, the narrowing stays strict) tied end to end to a live row with its outcomes set in advance, and I wrote no condition.
D4: yes: every new case must turn red on the merged guard or under a named break; each case pins its rule ID; and an independent replay against the platform's own records ties the fixture to reality, because all four earlier reviews shared one source.
D5: yes: I went past the task summary to record #4295, the transcript's tool_use and the binary text; that showed the record cannot show `message` or `content` (cut at 300 characters, those keys left out) and that the transcript is not the hook input.
D6: yes: I split the cause into layers (the fixture came from the schema; the "safe either way" premise was never tested; the log cannot show the full key set; the reviews shared a source) and aimed the fixes at the fixture source and at detection, not only at T6's key list.
D7: no
D8: yes: I checked that `main` is at add6608 and read W-C02-27's condition, the merged T6 and all three test files before the triage; the item file is absent, as noted.
D9: yes: the SDLC playbook (incidents become permanent eval cases; the repository is intent, not what is deployed; a model change should trigger a re-run) and gstack P6 (a check that did not run must not read as green) justified the replay case and the rule that "not yet observed" is not a pass.

Read, and what each changed:
- `plan/Ek_D_Dusunme_Protokolleri.md` §2 item 3 and §3 D1–D9: gave the disciplines block.
- `plan/work/W-C02-27.md`, whole: gave the cases to keep and the break numbering. Its point 10 (ii) and point 11 recipe are the reopening route.
- `evidence/C02/EV-C02-036_sendmessage_schema_row.md`: confirmed the schema is the only source the fixture was built from.
- `.claude/hooks/tool_allowlist.py` :572–595 (`summary()`) and :2403–2519 (T6, `decide()`): showed the record leaves out `message` and `content` and cuts at 300 characters, which limits what #4295 can prove. Showed the merged check order.
- Guard log record #4295 (Read tool, line 4295): the key evidence.
- Transcript `/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba.jsonl`: one grep for `toolu_01Tii7PmwDMAu5gR9YkSfPGU`, key names and short values only, message text masked. Changed the picture: six keys, no `summary`.
- `/opt/claude-code/bin/claude` text: greps for `recipient_kind`, `mjo`, `JPr`, `T2n`, `k1r`, `Rbt` and the backfill count. Gave the derivation rules.
- `tools/test_send_message.py`, whole: listed the cases that change.
- `tools/test_tool_allowlist.sh` :125–159; `tools/test_agent_hooks.py` :1070–1104: listed the cases that change.
- Grep of `tools/`, `.claude/` and `.github/` for where these tests run: none found (FC13).
- `evidence/C02/EV-C02-030_m2_m3_triage.md` lines 484, 495 and 617 via grep: the falsified "deletes / safe either way" premise.
- `CHK-C02-149` header and grep; `EV-C02-037` grep (line 202, the check order).
- Library: `research/studies/anthropic-ai-native-sdlc-playbook/01-PLAYBOOK-RESEARCH.md` §8.4 and §15; `research/studies/gstack/CORE.md` P6. Both justified, as under D9.
- Deliberately not read, to fit the budget: working order section 10, SB-COR 1.1, 3.6b and 3.7, and EV-C02-035 in full. They bind the condition, which comes after the approach, not this triage.

Relied on:
- #4295, `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl` line 4295 [observed]:
  - PreToolUse, `agent_id` null, T6.1.
  - Keys outside `{to, message}`: content, recipient, recipient_kind, summary, type.
  - `recipient` is `aa8570fed063c7083`; `recipient_kind` is "agent".
  - `summary` is exactly 200 characters, the last one "…" (I counted).
  - `to` appears only cut off. `type`'s value is lost at the 300-character cut. `message` and `content` are not shown (`summary()` at :587–589 leaves them out).
- Transcript tool_use `toolu_01Tii7PmwDMAu5gR9YkSfPGU` [observed]: input holds `to`, `message`, `type`:"message", `recipient` equal to `to`, `recipient_kind`:"agent", and `content` of 49 characters plus "…". No `summary`.
- The hook input for a plain message from `main` at this version is therefore those six keys plus `summary`: seven keys [inferred]. That `message` survives into the hook input is inferred from the transcript and the binary; #4295 cannot show it.
- Binary text [documented in code, not independently tested; I could not check its version, B7]:
  - `coerceInput` → `T2n`: "derive_summary" when there is no summary, then cut to `Rbt-1`+"…" with `Rbt=200`.
  - `backfillObservableInput` runs only when `to` is present with `message` or `notify_when_idle`, and `to` is a string.
  - For a string message it sets `type="message"`, `recipient=to`, `recipient_kind` (session, main, agent or name) and `content=as(h,50)`.
  - For an object message it sets `type`, `recipient`, `recipient_kind`, `request_id`, `approve` and `content` from `reason` or `feedback`.
  - `k1r` lists the six legacy keys. Eight tools carry a backfill function.
- Claude Code 2.1.304 [stated, task, via `get_session`].
- Merged check order: keys, shape, registry, self, unregistered, caller [stated, EV-C02-037:202; observed in code :2425–2471].
- None of the three test files is run by a gate, `stop_check` or workflow [observed by grep; a call made indirectly could escape my grep].

Unsure:
- (a) Whether `message` is present in the hook input, and what the `xs(s)` call inside the backfill deletes. The researcher can settle it from the binary; the first allowed record settles it if T6 logs every key name.
- (b) How `summary` and `content` are derived for short or multi-line messages. Not observed. My design makes this irrelevant by checking only that they are strings.
- (c) The hook-side shape for a subagent caller and on PermissionRequest. The researcher (sources) and the prober (records) are reading these. Until a natural record exists, both stay exploratory.
- (d) Whether a registered ID can ever be classified "name" by the platform. Observed "agent" for one real ID.

For: the executor. It folds this note into W-C02-27.1's approach block (round 1), files it in the triage EV record and builds the round-2 questions. Later, I use it to write the condition and the tests.

Received from / Returned to:
- Received: none. `SendMessage` is denied, so nothing came by message.
- Returned to the researcher, through the executor: confirm (a) and (c) above, the derivation in (b), and the list of the eight tools with a backfill function.
- Returned to the prober, through the executor: the transcript is not the hook input (six keys, no `summary`). W-C02-27 point 10 (ii)'s "keys in the record against keys in the input" must allow for that.
- Returned to the producer, through the executor (a proposal, not done):
  - T6 should log every input key name, without values, and the result of each relation check on every SendMessage decision. Today's record cannot serve as a shape witness (FC14).
  - T6.1's "What to do instead" tells the caller to drop keys it never sent. That text needs rewriting.
- To the executor:
  - The "exactly two keys" statement: the stored input has six keys; only the model's raw output, which no record holds, had two.
  - FC13: `tools/test_send_message.py`, `test_tool_allowlist.sh` and `test_agent_hooks.py` have no run point at a change, and a Claude Code version change triggers nothing.
  - New failure class for the package, FC16: a test fed a shape the platform does not send, its fixture built from the schema or docs and not from what the hook receives.
  - Wide view: any guard rule that checks a key set strictly, on any of the eight backfilled tools, needs a case built from a captured hook input.

Product:
- **Files:** none. This is a triage. I wrote nothing in `/home/user/devos` and nothing on GitHub. Scratch directory `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/test-designer/` was made and is empty.
- **Coverage:** what the condition should answer, triage only.
  - **Claims.** (C1) "a real `SendMessage` call from the executor (`main`) or from a role registered in this session passes". (C2) "with the narrowing W-C02-27 agreed kept strict (target only `main` or an agent ID this session's registry holds, matched exactly; the caller rules of T6.7; no other session; the keys checked)". (C3) "and what stays denied". (C4) W-C02-27 point 10 (ii) and SB-COR 4.5: the live row. (C5, from the cause) the miss cannot recur silently.
  - **What could make them false.** The fixture is fed a shape the hook never receives (the miss itself). The shape varies by caller, event, message length or Claude Code version. The guard is loosened as "ignore or strip extra keys", so `recipient`≠`to` passes. T6 routes on `recipient`. `request_id` or `approve` gets admitted, and with them structured messages. A `recipient_kind` of "name" or "session" gets admitted, which opens routing by name ("if the same name also names an in-process agent, the bare name always wins", schema text). A new check placed early makes W-C02-27's negative cases pass for the wrong reason (FC2). The test has no run point (FC13). The live record cannot show the key set (FC14).
  - **Existing cases that rest on the schema shape and must change or get twins.**
    - `tools/test_send_message.py`: lines 39–40 (`ALLOWED_KEYS`, `LEGACY_KEYS`) and `msg()` at :180. Every P case (P-1 to P-14, P-K2) is green only on a shape never sent.
    - N-K2 (`summary`), N-K3 to N-K6 (`type`, `recipient`, `recipient_kind`, `content`, valued "x") change outcome. Measured against W-C02-27's condition this is a loosening, so the test needs a new version, by the executor's decision, and W-C02-27's program-logic claim narrows on those cases. N-K1, N-K7, N-K8 and N-K9 stay T6.1. N-K9's text check changes.
    - N-G1 to N-G4, N-L1, C-1 to C-6, T6.0 and L4-1 use `msg()`. They get platform-shape versions.
    - `tools/test_tool_allowlist.sh:144` (`lt` T6.6) and :149–157 (12 `lt` T6.9 cases), all schema shape, get platform-shape twins. The matcher control at :28 is unchanged.
    - `tools/test_agent_hooks.py` :1082–1095, G1 to G12 (T6.9, schema shape), get twins.
    - RF-1 to RF-9 are unaffected.
  - **Positive cases** (platform shape first).
    - P-R1, the incident replayed with fixture IDs: seven keys, a message over 200 characters, from `main` to a finished checker → allow T6.
    - P-1 to P-11, P-13, P-14 and P-K2 in platform shape. A role to `main` gets `recipient_kind` "main".
    - P-S1, a message of 50 characters or fewer (an inferred branch, labelled so).
    - P-S2, a caller-sent `summary`. This reverses N-K2 and needs a disposition, since `summary` is "not transmitted" (schema) and the platform derives it anyway.
    - Schema-shape P cases kept as secondary only if the team keeps that shape admitted. P-12 (`to` alone, no backfill) is labelled not observed.
  - **Negative cases kept strict**, each on the full seven-key shape, rule pinned. "T6.10" stands for the new relation rule; the ID is the condition's to pin.
    - Keys (T6.1): N-K1, N-K7, N-K8, N-K9.
    - `recipient` against `to`:
      - N-V1a: `to` a registered researcher, `recipient` "someone" → T6.10.
      - N-V1b: a researcher caller, `to` a registered prober, `recipient` a registered producer → T6.10.
      - N-V1c: `to` "someone", `recipient` a registered ID → T6.6.
      - N-V1d: `recipient` differing only by a space or by case → T6.10.
    - `recipient_kind`: N-V2a to N-V2d ("name", "session" or "main" with a registered ID; "agent" with `to`=`main`) → T6.10.
    - `type`: N-V3a and N-V3b (`shutdown_request`, `broadcast`) → T6.10. N-V3c, a message given as an object, needs a disposition: it changes W-C02-27's "Not covered" line on structured messages.
    - N-V4: `content` or `summary` not a string → T6.10. I recommend checking only that these two are strings, not their values against `message`: the short and multi-line derivations are unobserved (FC4, FC15).
    - Every W-C02-27 `to` negative (N-S, N-E, N-B, N-R, N-129, N-N, N-C, N-M) in platform shape, with its W-C02-27 rule ID unchanged. A non-string `to` gets only `{to, message, summary}`, since the platform adds no legacy keys then. One pair proves `recipient_kind` is irrelevant once `to` decides first: N-129 with kind "name" and with kind "agent" both give T6.6.
    - L4-2: a token-format string only in a caller-sent `summary` → L4.
    - The order to pin: T6.1, then T6.2 to T6.5, T6.9, T6.8, T6.6, T6.7, then T6.10 last (reached only when `to` would be allowed), then T6. Every W-C02-27 case keeps its rule.
  - **Breaks.**
    - B-0, the merged guard at add6608: every platform-shape P case red with T6.1. This is the incident as a permanent case, and I show it on a stub before any product.
    - B-16, the relation check removed: N-V1a, N-V1b, N-V1d, N-V2, N-V3 and N-V4 red.
    - B-17, routing on `recipient`: N-V1a red (T6.6), N-V1b red (T6.7), N-V1c red (allow).
    - B-18, any key admitted: N-K1, N-K7, N-K8, N-K9 red.
    - B-19, the kind check removed: N-V2 red. B-20, the type check removed: N-V3 red.
    - B-21, the witness key set edited by one key: the count check red.
    - B-1 to B-15 re-run in platform shape.
  - **Tie to the real shape**, so FC16 cannot recur silently.
    - (1) One source: a committed shape witness in the test. It holds the seven keys, the relations, the branch rules and provenance (#4295 with its n, time and session; the transcript's tool_use ID; 2.1.304; the binary text labelled as documented, not tested). One builder is generated from it, with no hand-written platform inputs elsewhere (FC3), and a count check: exactly 7 keys for a string message, exactly 3 for a non-string `to`.
    - (2) A replay check, in scratch in the build record and run again by the checker. Nothing from the transcript is committed (public repository). Given the real `to` and message, the builder must reproduce the transcript's six key-value pairs byte for byte. Passed through the guard's own `summary()`, it must reproduce #4295's `summary` field byte for byte. Its extra keys, sorted, must equal #4295's detail list. Any red means the builder is wrong, before any case counts.
    - (3) The log as shape witness (the producer return above).
    - (4) After the sync, every natural T6.1 or T6.10 denial is compared with the caller's stored input. A key or value the platform added (other than `summary` when the caller sent none) is a red row: the witness comes back to me for a new version. This check runs on each call; it is not a window.
    - (5) A session at another Claude Code version makes the shape claim exploratory until its first natural record.
    - (6) Name the test's run point (FC13).
  - **Live row holding acceptance**, outcomes set now.
    - R1: the first natural `SendMessage` from `main` after the sync, at the named version.
      - Pass: allow T6; the record's key list equals the witness; `to` equals the registry ID and the transcript's `to`; `recipient`=`to`; then the target's Start record for the same `agent_id`, and its reply.
      - Red, which reopens W-C02-27.1: T6.1 or T6.10 on a call whose stored input holds only the platform's keys; or an allow whose key list differs from the witness, in which case the witness gets a new version and the claim narrows.
      - Neutral: a correct denial of a caller's own mistake, such as a name in `to`, judged from the transcript. The row waits for the next call.
      - No call yet: "not yet observed", and the item stays "execution finished, not accepted".
    - R2: the same row from a registered role, which joins W-C02-27's row (iii).
    - Plan 6.12 item 1: no schedule or hand-off parameter is designed here.
  - **Not covered, with reasons.** The hook shape on PermissionRequest: observing it would need a planted call, and it is likely never reached once PreToolUse allows [inferred]. The subagent shape until R2. Other versions. The exact `summary` and `content` derivation, made irrelevant by checking only types. Structured protocol messages, which are denied. The other seven backfilled tools.
  - **Who judges.** A fresh binding checker, running B-0, B-16 and B-17 itself. The replay against the platform's own records is the independent path, because all reviews are by the same model.
- **Open:**
  - The approach must decide four things: admitting `summary` from the caller; denying object messages; whether to check `recipient_kind`; and whether the schema-only shape stays admitted.
  - The "safe either way" premise (EV-C02-030 lines 495 and 617) is shown false.
  - W-C02-27 point 7 pins its test file as byte-identical at W-C02-27's head only. W-C02-27.1 needs a new version, with its SHA-256 pinned, as the executor decides.
  - FC13 (no run point) and the eight backfilled tools are reported to the executor, not done.

Guard denials:
- #4359, B5: `python3 -c` reading the guard log. I read line 4295 with the Read tool instead.
- #4571, B7: `/opt/claude-code/bin/claude --version`. Not pursued; the binary's version is marked unchecked, and I rely on 2.1.304 as the task states it.

## 5. Round 1, checker in triage `ad97f09223020d9da`

### Task

Item: plan/work/W-C02-27.1.md

**Purpose:** team triage, round 1, of a new item W-C02-27.1 (working order section 4 step 1a; D-039). You are the triage checker: you size the check before the work, and you are therefore excluded from this item's binding verdict. The decision it serves: how guard rule T6 (W-C02-27, merged by #439, merge `6a6585c`) must change so that a real `SendMessage` call from the executor (`main`) or from a role registered in this session passes, with the narrowing W-C02-27 agreed kept strict (target only `main` or an agent ID this session's registry holds, matched exactly; the caller rules of T6.7; no other session; the keys checked), and what stays denied.

The observation that opened it (natural occurrence, the first `SendMessage` call after W-C02-27's sync, Claude Code 2.1.304 by `get_session`'s `container_cc_version`): at 2026-10-20T18:32:59Z the executor called `SendMessage` with exactly two keys, `to` (a registered checker's agent ID, `aa8570fed063c7083`) and `message`, to resume that checker after it stopped at its turn limit. The guard denied it, record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, rule `T6.1`, reason: "the input keys content, recipient, recipient_kind, summary, type are outside {to, message}". So the hook's `tool_input` is not what the model sent: the platform adds keys before `PreToolUse` (the "legacy-key normaliser" that W-C02-27's condition point 10 row (ii) asked about). The schema row (EV-C02-036) did not show it, and W-C02-27's tests built their synthetic inputs from the schema. With T6 as merged, every `SendMessage` call is denied, from any caller. By SB-COR 4.5 a red row reopens W-C02-27 and selects its fallback; the nearest named one is W-C02-27's point 11 recipe. W-C02-27's binding verdicts (CHK-C02-148, CHK-C02-149) passed it on those tests. The exact keys and values the hook sees for a subagent caller and on `PermissionRequest` are being read by the researcher (sources) and the prober (records) in parallel.

**Your question (checker, triage):** the claim this item will make; its failure classes (among them: a fix that admits the normaliser's keys without tying them to `to` and `message`, so a disagreeing `recipient` passes or decides; a fix fitted to the one observed call from `main` that still denies a subagent caller or a `PermissionRequest`; tests again fed a shape the platform does not send; a widening that reaches other sessions); the cheapest discriminating evidence for each; the depth and reading mode of the binding check; and its `floor:` (guard; hook; test oracle, with the paths). Also say, from your field, what the earlier verdicts' miss teaches about the floor for any guard rule that reads a tool's input (a shape observed from the platform before the build, not only the schema). Your output is a labelled non-binding contribution in your role file's triage form.

**Acceptance:** none yet: this triage comes before the item's condition, which the test designer writes after the approach is agreed (working order section 4 steps 1a, 2 and 2a). W-C02-27's condition stays as merged.

**Consumer:** the executor, who integrates the five round-1 notes into W-C02-27.1's approach block, files them in an EV record that the block's `asked:` cites, and asks round 2; the test designer, who writes the condition from your triage; the binding checker, who reads it after its own pass and never goes below your floor.

**Inputs:** `plan/work/W-C02-27.md` (its condition and its approach); `.claude/hooks/tool_allowlist.py` (T6); `tools/test_send_message.py`; EV-C02-035, EV-C02-036, EV-C02-037; CHK-C02-148 and CHK-C02-149; the guard record #4295; working order section 10; SB-COR 1.1, 3.6b and 3.7. `main` is at `add6608ef6bcef5d7240a9d6666fe171c6d5e971`. Library line (from your map): `research/studies/gstack/CORE.md` (F1 to F5: the enforcement point's scope taken for the goal's; an attempted effect taken for the state reached) and `research/studies/superpowers/CORE.md` with `notes/U04-testing-diagnosis-and-verification.md` (two verdicts given one brief can share its gap).

`Teammates:` none reachable by message: `SendMessage` is denied to every caller until this item merges. Return anything for another role in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's triage contribution, which the executor takes with `tools/subagent_audit.py last` and files verbatim in W-C02-27.1's triage EV record.

**Writer or reader:** reader: you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 50 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/checker/` only.

**Constraints:** no `SendMessage` call, for any purpose, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017; negative cases are synthetic only).

Your take-up and returns: see your role file.

### Note (verbatim)

Non-binding contribution: this instance does not give W-C02-27.1's binding verdict.

Package: checker@951789897e85

Nonce: 4b61e23d312fd6b0

Take-up: PROCEED. The task holds. The triage has to size the check before W-C02-27.1's condition is written. Nothing in the task steers a verdict. The no-`SendMessage` constraint comes with its reason (D-020, D-017) and binds me. I was not part of W-C02-27's triage, product or verdicts, and I am excluded from W-C02-27.1's binding verdict.

## Disciplines (D1–D9)
D1: yes: I compared four ways to fix the key check: tie each added key to `to`/`message`, strip them unchecked, copy the platform's derivation exactly, or drop the key list as a control. I asked which one keeps "`to` alone decides" strict, and recommend the tie.
D2: yes: there is pressure to bring messaging back quickly, and W-C02-27's design is already merged; I sized the floor from what the evidence shows, not from wanting the fix to be small.
D3: yes: the aim is that real calls pass and the narrowing stays strict, not that one observed call passes; I listed the cases that a fix fitted to one call would miss (a subagent caller, a message to `main`, PermissionRequest).
D4: yes: two passing verdicts rested on a test oracle fed a shape the platform never sends; I made "the over-blocking input is observed, not built from the schema" a floor item, and asked for a break that runs the merged T6 against the observed shape.
D5: yes: the guard record shows only part of the input (it drops `content` and `message` and cuts at 300 characters), so I went back to the source of the shape, the installed binary's code text, and labelled what it shows as code text, not runtime.
D6: yes: I separated the layers: the proximate cause (T6.1's key set), the prevention gap (an unobserved shape argued "safe either way"), the detection gap (both verdicts shared the brief) and the systemic gap (no floor item for input shape); I named the routes by which the same class could come back.
D7: no
D8: yes: I pinned `main` at add6608ef6bcef5d7240a9d6666fe171c6d5e971 with a clean tree, and the binary at 2.1.304 (its text carries `VERSION:"2.1.304"`, 299 times).
D9: yes: I read gstack CORE F1 to F5 and superpowers U04. F3 and F4 shaped the failure classes and the floor addition, and U04's "a break shows sensitivity to that one defect" limited the breaks' claim.

Read, and what each changed:
- `/home/user/devos/plan/work/W-C02-27.md` (whole). Justified the work: the P cases are the over-blocking controls; point 11's recipe is "back to the test designer for a new version". It also showed that N-K2 to N-K8 deny the very keys the platform adds.
- `/home/user/devos/.claude/hooks/tool_allowlist.py` lines 2403–2524 (T6, `decide()`) and 572–595 (`summary()`). Changed the work: T6.1 rejects every key outside `{to, message}`; the log record drops `content`/`message` and truncates.
- `/home/user/devos/tools/test_send_message.py` lines 176–245. Changed the work: `msg()` builds `{to, message}` only, so P-1 to P-13 never get the platform's shape.
- Guard record #4295 (via `sed -n`). Changed the work: the keys the hook saw are content, message, recipient, recipient_kind, summary, to, type; recipient "aa8570fed063c7083"; recipient_kind "agent"; `summary` is message-derived text ending "…". The values of `type` and `content` are not in the record.
- `/opt/claude-code/bin/claude` code text (grep only). Changed the work decisively; details under Relied on.
- `/home/user/devos/evidence/C02/EV-C02-036_sendmessage_schema_row.md` (whole). Justified the work: the schema shows to, summary, message, notify_when_idle, with additionalProperties false.
- `/home/user/devos/evidence/C02/EV-C02-035_inputs_sendmessage_hooks_agenttype.md` (grep). Limited the work: no page documents `SendMessage`'s `tool_input` as a hook sees it.
- `/home/user/devos/evidence/C02/EV-C02-030_m2_m3_triage.md` (grep lines 484, 495, 617). Changed the work: the normaliser was seen in code text and its order was named unobserved, then argued "safe either way" in the hole direction only.
- `/home/user/devos/evidence/C02/checks/CHK-C02-148.md` and `CHK-C02-149.md` (floor, own_breaks, unsure, C1). Justified the work: both limited the claim to program logic and put row (ii) on acceptance only; neither asked whether the P inputs resemble the real input. Read after my own pass on the failure classes.
- `/home/user/devos/plan/SB-COR_Correction_Plan.md` 1.1, 3.6, 3.7, 4.5. Justified the work: 3.6b says "only the input keys the schema shows"; 3.7's "target not in a readable field" does not fire, because `to` is readable.
- `/home/user/devos/plan/Installation_Working_Order.md` line 215 (section 10, T6). Changed the work: it is public text the fix must change, so it is on the floor.
- `/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md` sections 3 (triggers) and 3 (full texts D1 to D9).
- Library: `research/studies/gstack/CORE.md` 432–471 (F1 to F5) and `[library id: superpowers, note U04]` (grep).
- Not read: EV-C02-037 (the build record; the product's rationale is not needed to size this) and the rest of the working order section 10.

Relied on:
- Hook input keys at 18:32:59Z, from `main`, PreToolUse: content, message, recipient, recipient_kind, summary, to, type; rule T6.1. Source: guard log line 4295. Observed.
- The model sent exactly `to` and `message`. Source: the task. Stated, not checked against the transcript.
- In the 2.1.304 binary, `SendMessage.backfillObservableInput(s)` first deletes any legacy key (`xs`). For a string `to` and a string `message` it then sets `type="message"`, `recipient=s.to`, `recipient_kind=Us(s.to)` (one of "session", "main", "agent", "name") and `content=as(message,50)`. For an object `message` it sets `type` from the object, plus `request_id`, `approve`, and `content` from reason/feedback. It returns early, without deleting anything, when `JPr(s)` is defined (a repair path where `message` is absent or null and `summary` is a string). Source: grep of `/opt/claude-code/bin/claude`. Observed as code text, not as runtime.
- `coerceInput` (`T2n` with `applySplit`) derives `summary` from `message` when it is absent ("derive_summary") and truncates it to 200 characters with "…". It may also rewrite `message` in a "split slipped summary" repair. Same source. Observed as code text.
- The backfill runs on a copy. The call keeps `callInput`; hooks and the permission check get `observableInput` (`zQt(e, n.observableInput, …)`; `y={...h}; e.backfillObservableInput(y)`). Same source. Observed as code text. That the PermissionRequest hook gets `observableInput` too is inferred.
- `isReadOnly(s)` is true when `message` is a string. Same source. Observed. That PermissionRequest therefore rarely or never fires for a string message is inferred.
- Validation runs before the backfill ("validate" phase; `ZOD_VALIDATION`), and the normaliser `ujt` deletes legacy keys when `to` plus `message` are present. Same source. Observed as code text. That a model-sent `recipient` therefore normally never reaches the hook is inferred.
- `summary()` excludes `content` and `message` and truncates at 300 characters. Source: tool_allowlist.py:587–595. Observed.
- T6 and its key set: tool_allowlist.py:2404 and 2425–2428. Observed.
- The test's inputs: test_send_message.py:180–183 and 213–227. Observed.
- The two verdicts limited the claim to program logic and typed row (ii) as acceptance-only. Source: CHK-C02-148 lines 21 and 77; CHK-C02-149 lines 21, 63 and 70. Observed.

Unsure:
- Whether the PermissionRequest hook gets the backfilled copy, and whether it fires at all for a string message. The researcher's code read (`zQt` and the PermissionRequest invocation) would settle it.
- The exact derivation of `content` (which minified `as` is in scope) and of `summary` (`kr`). The researcher's code read, or the first allowed record after the fix (if it logs the key set and the tie results), would settle it.
- The values of `type` and `content` in #4295: the record does not hold them. The main session's transcript entry for `toolu_01Tii7PmwDMAu5gR9YkSfPGU` holds the model's input, not the hook's.
- A subagent caller's hook input: the code text is caller-independent (the backfill reads only the input), but no subagent `SendMessage` record exists yet.
- I did not run the binary or the test suite. This is a triage, not a check.

For: the executor, who files this verbatim in W-C02-27.1's triage EV record and integrates it into the approach block. The test designer, who writes the condition and the new test version from it. The binding checker, who reads it after its own pass and never goes below the floor given here.

Received from / Returned to:
- To the researcher (through the executor, since `SendMessage` is denied): confirm from the 2.1.304 code text (a) which input the PermissionRequest hook receives and whether `isReadOnly` keeps it from firing for a string message; (b) the `content` derivation (`as(h,50)` in the SendMessage chunk) and the `summary` derivation (`kr`); (c) when the `JPr` early return is reachable after validation. Pointers: `backfillObservableInput`, `observableInput`, `zQt(e,n.observableInput`.
- To the prober (through the executor): #4295 carries key names but not the `type`/`content` values (`summary()` drops and truncates). Row (ii) needs a record that names the full key set and each tie's result.
- To the executor (outside my scope; not done): (1) The derived `summary` puts up to 200 characters of message text into the guard log and into T6's denial text, because `summary()` excludes `message` but not `summary`. Guard records filed verbatim into the public repository could carry message text; the library-fingerprint withholding still applies. (2) Read/Write `file_path` is also backfilled (expanded) on the observable copy, so other guard rules already judge the observable input in production. No defect is claimed.
- No request was taken from a teammate.

Product:

Claim the item will make (program logic, counted environment: the container's `python3` through the two `.claude/settings.json` commands, in a full clone at the head; platform: row (ii) after sync, at a named version).
- A `SendMessage` call is allowed on PreToolUse and on PermissionRequest exactly when two things hold.
- First, `to` alone names the target under W-C02-27's rules, unchanged: a registered ID or `main`, matched exactly, by the T6.7 caller rules, not self, not another session.
- Second, every other key in the input is one the platform adds, and each agrees with `to` and `message`: `recipient` equals `to`; `recipient_kind` equals the kind the platform derives from that `to` ("agent" for a registered ID, "main" for `main`); `type` is "message"; `content` is drawn from `message`; `summary` is a string of at most 200 characters.
- Inputs with or without those added keys are both judged this way. Any added key that disagrees, any key outside the set (`notify_when_idle`, `request_id`, `approve`, unknown keys), and any non-string message (a structured protocol message) is denied with its own rule ID.
- The claim does not say that delivery happens (row ii), nor anything for a later Claude Code version, whose derivations may change.

Failure classes, each with the cheapest discriminating evidence (all offline and synthetic unless noted):
- F-A, untied admission: the added keys are admitted without being tied, so a disagreeing `recipient` passes, or decides the target. Evidence: these cases are denied:
  - `to` registered with `recipient` another registered ID;
  - `to` registered with `recipient` a session reference;
  - `to` unregistered or a name with `recipient` registered;
  - `recipient_kind` "session" or "name" with `to` registered.

  Breaks: the recipient tie removed must turn the first two red; `recipient` used as the target (or `to or recipient`) must turn the third red.
- F-B, fitted to the one observed call (`main` to an agent ID). Evidence: allowed cases a researcher to `main` (`recipient_kind` "main", `recipient` "main"); a researcher to a prober; a producer, a checker and a general-purpose agent to `main`; each on both events, with the full added-key shape. Break: `recipient_kind` forced to "agent" must turn the to-`main` case red. The code text shows the backfill is caller-independent (observed); a subagent's real record is a row after sync.
- F-C, the oracle again fed a shape the platform does not send. Evidence:
  - an allowed case O-1 whose key set equals #4295's (content, message, recipient, recipient_kind, summary, to, type), with each value made by the platform's rules from a fixture message;
  - variants with an empty message, a message over 200 characters, and a multi-line message;
  - the raw shape `{to, message}` and `{to, message, summary}` also allowed, because PermissionRequest's input is unconfirmed;
  - break BR-h: the merged guard of add6608 run against the new test must turn O-1 red. This is the regression test for the observed failure. A red here shows sensitivity to that one defect only.
- F-D, a widening that reaches other sessions. Evidence: T6.5 and T6.6 cases unchanged and still red under their breaks; added cases where `recipient` or `recipient_kind` names a session (`session_`/`cse_`, kind "session") with `to` registered are denied. `to` stays the only deciding field.
- F-E, structured messages newly admitted through `type`, `request_id` or `approve`. Evidence: `type` other than "message" (for example "shutdown_request"), `request_id`, `approve`, and an object `message` are each denied. Break: `type` admitted with any value must turn the first red.
- F-F, the tie copies the platform's derivation byte for byte (for example an exact `content` truncation), so the next Claude Code version over-blocks again, or the tie "repairs" a mismatch instead of denying. Evidence: a read of the build. A disagreement denies, never rewrites; a new or changed derived key denies and names itself in the denial (fail-closed), and the item names that recurrence and its fallback (the 3.7 return state).
- F-G, a fix that requires the added keys, so a raw-shape input (on PermissionRequest, or after a platform change) is denied. Evidence: the raw-shape allowed cases above. Break: the added keys made mandatory must turn them red.
- F-H, L4 or T6.0 regress. Evidence: L4-1 and T6-S, the T6.0 cases and C-1 to C-6 re-run unchanged and green.

Depth and reading mode of the binding check:
- Full fresh check of the whole of T6, not a diff-confirmed or scoped check. Changing N-K2 to N-K6 from "denied" to "allowed when tied" loosens oracle cases that already have results (CHK-C02-148 and 149). Loosening after a result voids those results for those cases, so the test is repeated in full as a new version (Appendix G G8 item 3; ledger rule 3). The remaining cases' earlier results narrow to "program logic on the schema's shape".
- Reading: product-only first (the diff, the new test against #4295 and the code text quoted above), then design-knowing (the approach, then this triage), kept apart.
- Ek A 3.2 (c) is asked: yes (a class-high guard change).
- The checker must not be the triage checker (this run, ad97f09223020d9da), W-C02-27.1's producer or test designer, or W-C02-27's checkers a5309384b6fd9cecb and those of CHK-C02-148 and 149, who would be anchored by their own P-case verdicts.

floor: guard (.claude/hooks/tool_allowlist.py: T6, send_message_checks, the T6 RULES entries, decide()); hook (both events, through .claude/settings.json hooks.PreToolUse[0] and hooks.PermissionRequest[0], the file unchanged; .claude/hooks/agent_hooks.py if touched); test oracle (tools/test_send_message.py as a new version, tools/test_tool_allowlist.sh, tools/test_agent_hooks.py G1 to G12 if touched; public text: plan/Installation_Working_Order.md section 10 line 215 and section 9 if touched, the plan/decisions/PC-53.md addendum, role files only if their Send-back line changes). Own breaks at least BR-h, the recipient tie removed, recipient deciding, recipient_kind forced to "agent", type admitted with any value, added keys made mandatory, and T6 skipped on PermissionRequest. Each names the case that must turn red, run in a scratch copy, never the live tree.

What the earlier miss teaches for the floor of any guard rule that reads a tool's input:
- Proximate cause: T6.1's key set came from the schema. The contributing condition was tests built from the same schema.
- Prevention gap: the order of the normaliser was named unobserved (EV-C02-030 lines 495 and 617), then argued "safe either way" in the hole direction only. The qualifier was lost (gstack F1), and over-blocking (package M5) was never weighed.
- Detection gap: two verdicts shared one brief and both took the P cases as over-blocking controls (superpowers U04: two verdicts given one brief share its gap). A green test was taken for "the allow branch is reachable", but a test that exists is not one that ran on real input (gstack F4). The hook judges the observable copy while the call runs the original (gstack F3, the enforcement point's scope); that is safe only while every added field is derived from `to`.
- Systemic gap: no floor item for input shape. Proposed floor item, "input shape observed": a rule's over-blocking controls must include at least one input whose shape was observed from the platform at the counted version. Either a guard record of a real call (key names, since the log truncates values) or the platform's own code text for the input it hands the hook, labelled as such. A control fed only a schema- or docs-built shape counts as not run. Where no observation is possible before the build, the merge claim says "allow branch not exercised on real input", the first real call has a named fallback, and the binding checker records this as `missing evidence` on acceptance.
- The same class can come back in any future rule that reads a tool's input (a new tool, or an upgrade that changes a backfill). The same item covers it.

Objections (non-binding, for the approach and the condition):
1. scope conflict (frame review: the approach) · blocks: none. W27-3 ("keys `to` and `message` only"; N-K2 denies `summary`) and SB-COR 3.6b ("only the input keys the schema shows") cannot hold against the platform's observable input. The platform derives `summary` for every non-empty string message, and a model-sent `summary` looks the same in the hook, so admitting the derived one admits any string `summary` up to 200 characters. The schema says `summary` is "not transmitted", and L4 reads it. The approach should state the replaced narrowing ("`to` alone decides; added keys tied") and say whether 3.7's "narrowing cannot be made strict" applies. My view: it does not, because the tie keeps it strict.
2. scope conflict (frame review) · blocks: none. With the platform's backfill, structured (object) messages always bring `type` other than "message", `request_id` or `approve`, so they were denied in practice. W-C02-27's Not covered left them open in principle. The approach should say outright that they stay denied, so the fix does not admit them by accident (F-E).
3. missing evidence · blocks: the condition (the test designer's version). How the PermissionRequest input is shaped, and the exact `content` and `summary` derivations, are taken from the binary's code text only. Until the researcher confirms them, the condition admits both the raw and the backfilled form on both events and pins agreement, not byte-exact derivation (F-F, F-G). Shown met when the researcher's note cites the code text for each, or the condition is written to agreement only.
4. missing evidence · blocks: acceptance. Row (ii) must be readable from the guard log. Shown met when the first T6 allow record after sync shows the full sorted key set and each tie's result, and it is compared with the caller's tool-use input from `tools/subagent_audit.py calls`. Today's `summary()` drops `content` and `message` and truncates at 300 characters, so a record alone cannot show agreement.
5. defect (for the condition, not a product yet) · blocks: the merge, if the condition omits it. The new test must carry O-1, with #4295's key set and platform-derived values, plus BR-h (the merged T6 at add6608 turns O-1 red). Without them the new version repeats the miss. Shown met when the condition names O-1's key set and BR-h.

Guard denials: #4376, rule B5: a `python3 -I -c` command named the guard log to read it. Instead I read the record with Grep and `sed -n`, the readers the denial's own text allows. I did not pursue the denied effect any other way.

## 6. Round 2, researcher `a1e05112ad7090e4e`

### Task

Item: plan/work/W-C02-27.1.md

**Your field's question (researcher):** does the block state what the sources state, and no more: each platform fact it rests on (the three steps before the hook; the hook sees the observable copy and the tool runs the original; the derived `summary`; `recipient_kind` values; the shape caller-independent; PermissionRequest unconfirmed; version dependence), with the label it carries (stated in code, interpreted, observed)? Where the block's wording goes beyond a source, name it. Also settle, if you can from the program text at 2.1.304 within budget, the two open readings the round-1 notes returned to you: which input the PermissionRequest hook gets and whether `isReadOnly` keeps it from firing for a string message; and when the repair early-return is reachable after validation.

**Purpose:** team triage, round 2, of W-C02-27.1 (working order section 4 step 1a; D-039): every asked role answers the integrated approach block `PROCEED` or with a typed objection (a defect, missing evidence, a preference or a scope conflict), from its own field. The approach is agreed only when each asked role's last answer is `PROCEED` or its objection has a disposition in the block. The decision it serves: T6's key check rewritten against the input the platform really delivers to the hook (W-C02-27 row (ii), red at guard record #4295), with W-C02-27's narrowing kept strict.

**Acceptance:** none yet; the test designer writes the condition after this round (working order section 4 steps 2 and 2a).

**Consumer:** the executor, who files your answer in W-C02-27.1's triage EV record beside round 1, and either merges the agreed block or records a disposition for your objection.

**Inputs:** the integrated block, a draft not yet on `main`: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md` (two placeholders, `ROUND2_ASKED` and `RECORD_ROW_I`, are filled after this round). The five round-1 notes it integrates, each taken with `tools/subagent_audit.py last`, DISCIPLINES OK: researcher `ac276961647514c80` (`w271_r1_researcher.md`), prober `a0af1624f9cd84007` (`w271_r1_prober.md`), producer `afa58577986640b22` (`w271_r1_producer.md`), test designer `a9c72999c83948ff1` (`w271_r1_testdesigner.md`), checker `ad97f09223020d9da` (`w271_r1_checker.md`), all under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/`. Also `plan/work/W-C02-27.md`, `.claude/hooks/tool_allowlist.py` (T6), `tools/test_send_message.py`, and CHK-C02-152 (`evidence/C02/checks/CHK-C02-152.md`, its C3). The installed program is `/opt/claude-code/bin/claude` (read only, never run). `main` is at `81bf65ec32c100b0ec24630c4d67974c4eac7539`. Library line: your role file's map; the round-1 notes name what was read; read further only if your answer needs it.

`Teammates:` none reachable by message: `SendMessage` is denied to every caller by T6.1 until this item merges. Return anything in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, with your answer (`PROCEED`, or each objection typed, with what it blocks and what would meet it) under its product heading; the executor takes it with `tools/subagent_audit.py last`.

**Writer or reader:** reader: you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 35 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/r2/` only.

**Constraints:** no `SendMessage` call, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017). The installed program is read, never executed, because the guard denies `claude` command lines and running it would start another session.

Your take-up and returns: see your role file.

### Note (verbatim)

Package: researcher@bfb9d1e8e5e9
Nonce: 425643f70bfbb198
Take-up: PROCEED. The question holds. If the block says more than the sources do, the tie rule and the reasons in its dispositions would rest on claims nobody checked. The two open readings decide whether the raw-shape positives and the repair edge case need cases at all. Depth: a primary-source check of the installed program at 2.1.304, read with grep and dd and never run, plus the block and the round-1 notes. This rung is enough because the program is the only source that states what the hook receives. Round 1 already covered the library, the docs and the changelog, and nothing in this question needs them again. Reading date 2026-10-20.

## Disciplines (D1–D9)
D1: yes: I tested the "caller-dependent schema" reading I first formed by reading the selector `$V()`; it is a session setting, so I dropped that reading before it reached the product.
D2: no
D3: yes: I kept to the block's fidelity and the two open readings, and offer the design notes as non-blocking wording, not a new method.
D4: yes: I checked whether the block's reason for keeping the raw shapes still matches the code; the code now gives PermissionRequest the same copy, so I flagged the reason as needing new wording.
D5: yes: I re-read the program for each claim taken over from round-1 notes (mine, the checker's, the producer's) instead of relying on their summaries, and named the parts I did not read (NT, Lws, the interior of canUseTool, the zod object mode).
D6: no
D7: no
D8: yes: I checked the block against the code text at the stated version and against the merged guard's output form (tool_allowlist.py:2648-2653), not against the task's summary.
D9: yes: I relied on round 1's library search (no hits on this mechanism under the context and harness study; one ECC note as a general counter-case) and did not search again, because the question is about program text; nothing in the library bore on it.

Read, and what each changed:
- /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md (lines 1-11): the object of the check. Justified the work.
- The w271_r1_researcher.md note (in full) and grep hits in the prober, producer, test designer and checker notes, same scratchpad folder: these gave the open readings returned to me (checker :50, :59; test designer :52-54; producer :46-48; prober :47). They framed the work.
- /opt/claude-code/bin/claude (2.1.304), read only, at these byte offsets:
  - 249178371: PPn (coerce, then schema parse) and fvr (validation, then the copy plus backfill).
  - 271284107: the SendMessage definition (isReadOnly, backfill, xs, Us).
  - 244854036: JPr, Ne and T2n.
  - 238085888 and 238085963: k1r and mjo.
  - 271266200 to 271269700: the schema (Gs, Ss, Je, Vs="", Ee).
  - 249305300 to 249312800: the run path (yvr given At; hvr given At; e.call given Ut).
  - 249261188: hvr, qVr and lxe.
  - 248316400 to 248320600: xgr, qSr and dmo, the PermissionRequest callers of VFe.
  - grep for every `.isReadOnly(` use.
  - 246771126: `$V()`.
  - 239210728: d5s.
  This changed the work: it settles both open readings and supplies notes 1 to 4.
- /home/user/devos/.claude/hooks/tool_allowlist.py:2636-2654: the guard gives an explicit `allow` on PreToolUse. Changed the work, because it decides which branch of qVr runs.
- /home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md:69-96 and D1 to D5 (155-262). Shaped the method.
- Deliberately not read:
  - NT, Lws, pmo and the interior of canUseTool. The decision there is "ask or not"; I bounded it instead of tracing it.
  - The zod chunk, so I do not know whether `u` strips unknown keys or rejects them.
  - kd and bd again (round 1 cited them).
  - The docs and changelog again.
  - The other test files.

Relied on:
- The hook path runs in this order. coerceInput (T2n: derives summary, caps it at 200) runs on the raw input. The schema parses the coerced input. validateInput runs next. Then a shallow copy is made and backfillObservableInput runs on the copy. Stated in code, PPn and fvr at about 249178371.
- PreToolUse gets the copy (`yvr(Kt,e,At,…)`, with At = observableInput). The tool runs Ut = callInput (`e.call(Ut,…)` at about 249319015). Stated in code.
- The PermissionRequest hooks get `updatedInput ?? input`. In qSr that is `s.updatedInput??r` and in dmo `e.updatedInput??r`. Here r is At, the copy, unless a PreToolUse hook returned updatedInput. Stated in code at about 248319790. That this path is the one taken for SendMessage is interpreted.
- The PermissionRequest hooks run only on an "ask" decision (dmo returns early unless the behaviour is "ask"; qSr is reached from the ask path). After a PreToolUse "allow", qVr sends the call to the permission pipeline only when one of these holds: a deny or ask rule, a safety check, plan mode, requireCanUseTool, or the auto-mode funnel. Stated in code for qVr and lxe; what NT and Lws return for SendMessage is not read.
- isReadOnly is consulted in plan-mode logic: wyn's "plan" case, eet and xEe (about 248312761 and 248357417). It is also used for Bash and file tools and for run-time flags. In this permission flow I found no default or acceptEdits gate that uses it. Observed by grep; the conclusion is interpreted.
- The schema has a message field in every variant. It is a string; in the Xs and gt variants it may also be a protocol object, and an absent message defaults to "" (`Vs=""`). The variants without a default (Ws, We, ft) require it. null fails in all of them. Stated in code at about 271266200; that `o()` is a string schema is interpreted from its `.regex` and `.max` calls.
- The schema variant is chosen by session settings (`$V()` = messagingBeyondOwnAgentsDisabled, `aa()`, `ms()`), not by the caller. Stated in code (`$V` at 246771126); that `Su()` is session-level is interpreted.
- Us(to) returns "agent" only when d5s(to) holds, that is `ug(mo(to))!==null`. Otherwise it returns "name" (or "session" or "main"). Stated in code at 239210728 and 271284107.
- The summary field is described as "not transmitted" only in the s=true schema variant's description text (about 271267258). Stated in tool text; I did not verify it in the delivery code.

Unsure:
- The NT and Lws outcomes for a SendMessage to a registry ID or `main`, so whether any ask arises outside plan mode. A read of NT and Lws would settle it, or the first natural allowed call's records (no PermissionRequest record expected).
- Whether the object schema `u` strips caller-sent legacy keys or rejects them at parse. It changes nothing for the hook, which sees the copy after `xs` has deleted them. It matters only for what the tool runs. Reading the zod chunk's export of `u` would settle it.
- Whether every registry ID passes d5s (the prefix grammar inside `ug`). Observed for one ID shape ('a' plus 16 hex). Reading `ug` would settle it; failure is fail-closed (T6.10).

For: the executor, who files this in W-C02-27.1's triage EV record beside round 1 and merges the block, or folds in the wording notes. The test designer may use findings A and B for the condition's "Not covered" line.

Received from / Returned to:
- Taken from the executor: this task, including the checker's round-1 returns (a) and (c) (w271_r1_checker.md:59) and the test designer's (c) (w271_r1_testdesigner.md:54). Answered below as findings A and B.
- For the test designer, through the executor: at 2.1.304, structured-message negatives can only arrive in sessions whose schema variant admits objects. In a session with messagingBeyondOwnAgentsDisabled the parse rejects them before any hook runs. They stay valid as guard cases.
- Nothing sent by message (SendMessage is denied by T6.1).

Product:

**Question.** Does the integrated block state what the sources state, and no more, on these points:
- the three steps before the hook;
- that the hook sees the copy while the tool runs the original;
- the derived summary;
- the recipient_kind values;
- caller independence;
- PermissionRequest unconfirmed;
- version dependence.

And from the 2.1.304 text: which input PermissionRequest gets, whether isReadOnly stops it firing, and when the repair early-return is reachable. This serves T6's key check, rewritten against the input really delivered, with W-C02-27's narrowing kept strict.

**Answer: PROCEED.** Every platform fact the block states is borne out by the program text, and its labels hold: "stated in code, not observed for a subagent or on PermissionRequest" (w271_approach.md:6). The four notes below are wording corrections, not objections. None of them changes the key rule, the order, the tests or the live rows.

**Findings.**

A. The PermissionRequest input and isReadOnly (checker's (a)).
- The PermissionRequest hook gets the same backfilled copy PreToolUse got, or a hook's or decision's updatedInput if one was returned. Stated in code (qSr and dmo); interpreted as the path taken.
- It fires only when the permission decision is "ask". Our guard answers PreToolUse with an explicit allow (tool_allowlist.py:2652). After that allow, qVr reaches the ask pipeline only through a rule, a safety check, plan mode, requireCanUseTool or the auto-mode funnel. Stated in code for qVr and lxe; interpreted beyond that.
- isReadOnly is not the gate outside plan mode. In plan mode, a string message (isReadOnly true) avoids the plan-mode ask; an object message (isReadOnly false) would not. Interpreted.
- So the checker's inference that "isReadOnly keeps it from firing" is right only for plan mode. The real gate is PreToolUse's allow.
- When PreToolUse denies, no PermissionRequest follows (qVr's deny branch goes to lxe with "deny"). This fits the prober's observation of no PermissionRequest record for SendMessage (w271_r1_prober.md:39).

B. When the repair early-return is reachable (checker's (c)).
- Ne, which JPr relies on, applies only when all of these hold: `message` is undefined or null, `summary` is a string, every key is in {to, summary, message, notify_when_idle}, and the summary holds `</summary>` followed by a non-empty message opener tail (not markup, not JSON). Stated in code at 244854036.
- On the hook path, by the time the backfill runs, the parse has already left `message` as a string (default "" where absent) or an object, or it failed and no hook ran. So the early return is unreachable on the hook path at 2.1.304. Interpreted from PPn, fvr and the schema.
- With the split flag on, coerceInput would also already have split such a summary. The flag defaults to true in code (`k("tengu_deep_feather",!0)`); its live value is not read.
- Inference: the early return serves the transcript backfill of raw tool_use blocks (kd and bd, round 1), which runs before any parse. So no test case is needed for it in T6.

C. Point-by-point fidelity of the block.
1. The three steps (line 6).
   - Accurate as a set. The order in code is: derive summary (coerce, on the raw input), then parse and validate, then delete the legacy keys and add four keys (backfill, on the copy).
   - "Deletes any caller-sent legacy key" is stated for the copy.
   - Whether the parse already drops them from the original is not read. It does not bear on the guard.
2. The hook sees the copy and the tool runs the original. Stated in code for PreToolUse and the tool call. For PermissionRequest it is now read in code as the same copy (finding A).
3. The derived summary.
   - Stated in code: it is derived when none or a blank one is given, but only if the first line of the trimmed message is non-empty; a given summary over 200 characters is cut to 199 plus "…".
   - "If present, one string" covers the whitespace-only message, which gets no summary.
4. recipient_kind.
   - The code gives main, agent, session or name.
   - The block's tie "main for main, agent otherwise" is a guard rule, not a platform statement. It holds only if every registry ID passes d5s. The block does not name this premise. See note 2.
5. Caller independence. The backfill and the coerce step have no caller branch, and the schema variant is session-level. Interpreted, and supported further this round.
6. PermissionRequest unconfirmed. True as "not observed". See note 1 for the reason given in W271-3.
7. Version dependence. Correctly carried (line 10: re-read at each version change).

**Wording notes (non-blocking; each would sharpen a label, not the design).**
1. W271-3 (line 9) and line 6 keep the raw shapes "because PermissionRequest's input … is unconfirmed".
   - The code now says PermissionRequest gets the same backfilled copy (interpreted, not observed). At 2.1.304 neither hook event gets a raw shape for a non-blank string message.
   - Better wording: raw shapes are kept against a later version change and because PermissionRequest is unobserved, though the code reads it as the copy.
   - The design stands.
2. Line 6's kind tie should name its premise: every registry ID matches the platform's agent-ID test (d5s at 239210728; pattern at about 236251096). This is inference; a failure is fail-closed under T6.10.
3. W271-1 (line 9): "it is not transmitted to a subagent target" rests on the tool's schema description text (about 271267258), not on delivery code. Label it as tool text. It is not load-bearing, since "the hook cannot tell it from the platform's default" carries the disposition alone.
4. W271-4 (line 9): structured messages reach the hook only in sessions whose schema variant admits objects. With messagingBeyondOwnAgentsDisabled they fail at parse. This narrows nothing in the guard.

**Counter-evidence and alternatives.**
- I looked for:
  - a caller-dependent schema (found session-level only);
  - an isReadOnly gate in default or acceptEdits (found only plan, Bash and file uses);
  - a hook-path way to a null or absent `message` (found none, because of the "" default and the required field).
- The one live counter-possibility is an ask from NT or Lws (a safety check) for some SendMessage target. That would fire PermissionRequest with the copy, which the block's tie rule already admits.

**For the decision.** Nothing in the findings changes the agreed method, the order, the tests or the live rows. The block can be merged as written, or with the four wording notes folded in. Findings A and B close the checker's (a) and (c) at the level of program text, labelled as interpreted where the path is inferred.

Guard denials: none

## 7. Round 2, prober `a19dc4c435af738d6`

### Task

Item: plan/work/W-C02-27.1.md

**Your field's question (prober):** are the block's platform observations and its live rows right from your field: R1 and R2 with their outcomes decided in advance (pass, red, neutral, not yet observed), the counted environment, what the guard record will let the executor read (key names and tie results, no values), and whether any row could be read off a record or transcript that does not hold what it needs (the transcript is itself backfilled; it holds no `summary`). Name any observation the block relies on that has not been made, and the natural occurrence that would make it.

**Purpose:** team triage, round 2, of W-C02-27.1 (working order section 4 step 1a; D-039): every asked role answers the integrated approach block `PROCEED` or with a typed objection (a defect, missing evidence, a preference or a scope conflict), from its own field. The approach is agreed only when each asked role's last answer is `PROCEED` or its objection has a disposition in the block. The decision it serves: T6's key check rewritten against the input the platform really delivers to the hook (W-C02-27 row (ii), red at guard record #4295), with W-C02-27's narrowing kept strict.

**Acceptance:** none yet; the test designer writes the condition after this round (working order section 4 steps 2 and 2a).

**Consumer:** the executor, who files your answer in W-C02-27.1's triage EV record beside round 1, and either merges the agreed block or records a disposition for your objection.

**Inputs:** the integrated block, a draft not yet on `main`: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md` (two placeholders, `ROUND2_ASKED` and `RECORD_ROW_I`, are filled after this round). The five round-1 notes it integrates, each taken with `tools/subagent_audit.py last`, DISCIPLINES OK: researcher `ac276961647514c80` (`w271_r1_researcher.md`), prober `a0af1624f9cd84007` (`w271_r1_prober.md`), producer `afa58577986640b22` (`w271_r1_producer.md`), test designer `a9c72999c83948ff1` (`w271_r1_testdesigner.md`), checker `ad97f09223020d9da` (`w271_r1_checker.md`), all under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/`. Also `plan/work/W-C02-27.md`, `.claude/hooks/tool_allowlist.py` (T6), `tools/test_send_message.py`, and CHK-C02-152 (`evidence/C02/checks/CHK-C02-152.md`, its C3). `main` is at `81bf65ec32c100b0ec24630c4d67974c4eac7539`. Library line: your role file's map; the round-1 notes name what was read; read further only if your answer needs it.

`Teammates:` none reachable by message: `SendMessage` is denied to every caller by T6.1 until this item merges. Return anything in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, with your answer (`PROCEED`, or each objection typed, with what it blocks and what would meet it) under its product heading; the executor takes it with `tools/subagent_audit.py last`.

**Writer or reader:** reader: you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 30 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/r2/` only.

**Constraints:** no `SendMessage` call, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017).

Your take-up and returns: see your role file.

### Note (verbatim)

Package: prober@69e1e10d0cd7
Nonce: b0a0b28e2f2f5b82
Take-up: PROCEED. The task holds: it asks me to judge, from my field, the block's platform observations and its live rows. I can do that by reading the existing records, and nothing gets planted. I made no SendMessage call. My answer to the block is below: eight typed objections, no PROCEED.

## Disciplines (D1–D9)
D1: yes: I tested whether each live-row outcome can be told apart from the record it is read from, and found three readings the block leaves open: which "stored input", a target that is still running, and an allow that W-C02-27 denies.
D2: uncertain: round 2 and five agreeing roles push toward PROCEED, so I judged each outcome against the records themselves and not against the earlier notes, my own round-1 note included.
D3: yes: R1 and R2 decide W-C02-27's acceptance, so I followed the chain from call to guard record to delivery to reply, and found the delivery link unbinned.
D4: yes: I asked of each red condition "if the guard were wrong, would this turn red?" and found that over-admission has no red outcome, and that a run of the old guard would read as red.
D5: yes: I went back to #4295 itself and found that its 300-character summary cut off the `to` value, and that the transcript's `input` is not the hook's copy (it lacks `summary`).
D6: no
D7: no
D8: yes: before reading I recorded HEAD 81bf65e, the time, Python 3.13.16 and that the guard is live (record #4688 carries my agent_id).
D9: yes: I re-read gstack CORE P6 and F1 (a check that did not run must not read as green; a qualifier lost downstream), which supported the "could not check" outcome and the objection that the transcript's `input` loses the fact that it was backfilled.

Read, and what each changed:
- /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md: the object of my answer.
- /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_r1_prober.md: my round-1 U1 to U6 are the baseline. U6 is not carried into the block (O1).
- w271_r1_testdesigner.md lines 114 to 127, and grep hits in w271_r1_researcher.md and w271_r1_checker.md (same scratchpad directory): where R1 and R2 come from; the inference that PermissionRequest rarely fires (O7). These limited my work.
- /home/user/devos/plan/work/W-C02-27.md lines 64 to 66: row (ii) reads the input through `subagent_audit.py calls` (O1); row (iii) is a role writing to a sibling, not to main (O6). Both changed my answer.
- /home/user/devos/.claude/hooks/tool_allowlist.py lines 572 to 595 (`summary()`), 2575 to 2600 (`log_decision`), 2620 to 2654 (one `decide()` for both events): the basis of O5.
- /home/user/devos/.claude/settings.json lines 1 to 119: no permission rule names SendMessage; both hook commands run the same script (O7).
- /home/user/devos/evidence/C02/checks/CHK-C02-152.md, C3 and P3: the reload lag applies to role files, and guard scripts are read on each call. It bears on R1 only through O3(b).
- The guard log (/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl): #4295 in full, and the newest record. The registry (session_01JDJ8fJQmrKpXfiRh1yEoxv.agents): the records for aa8570fed063c7083. These changed O2 and O5.
- Transcripts: counts of `wireToolInputs` against tool_use lines in the main transcript and in subagent agent-a0af1624f9cd84007.jsonl. This changed O1.
- Ek D section 3, the full texts of D1 to D9.
- Library: /home/user/agentic-os-search/research/studies/gstack/CORE.md lines 416 to 445 (P6, P7, F1). This justified O1 and O3.
- Deliberately not read: /opt/claude-code (the researcher's), and the producer's round-1 note (its method is fixed in the block and not my field).

Relied on:
- The PreToolUse record #4295 carries `tool_use_id` "toolu_01Tii7PmwDMAu5gR9YkSfPGU". Its `summary` field is cut at 300 characters, and the cut fell inside the `to` value ("to": "aa8570fed063c..."). Its `detail` lists the five extra keys. [O, guard log line 4295]
- `detail` is logged after `redact()` only, with no length cut; `summary` is cut at 300 characters. [O, tool_allowlist.py:595, :2595]
- The generic branch of `summary()` drops `content` and `message` but keeps the `summary` key. [O, tool_allowlist.py:587-588]
- PreToolUse and PermissionRequest go through the same `decide()`. [O, tool_allowlist.py:2634, :2648-2653]
- Every tool_use line carries `wireToolInputs`: 1047 of 1047 in the main transcript, 42 of 42 in subagent a0af1624f9cd84007. [O, this run]
- That `wireToolInputs` is what the model sent. [I, from the field's name and its difference from `input` at line 6879, per round 1]
- The registry shows a "start" record (run 2, 18:32:37Z) for aa8570fed063c7083 with no stop record for run 1. It came 22 s before the denied SendMessage, so it was triggered by something else. [O, .agents lines 36-37]
- The guard is live; the newest record is #4688 at 18:48:57Z with my agent_id. HEAD is 81bf65ec32c100b0ec24630c4d67974c4eac7539. Python 3.13.16. [O, this run]
- Claude Code 2.1.304, as stated by the transcript's `version` field (round 1). I did not run the command line.
- `recipient_kind` is "main" when `to` is "main". [stated in code by the researcher; never observed]
- PermissionRequest rarely fires for a string message because of `isReadOnly`. [inferred by the checker]

Unsure:
- Whether a caller's own `summary` survives into the transcript's `input`. Never observed; R1 or R2 settles it, read from `wireToolInputs` against `input`.
- How a SendMessage delivery appears in the target's transcript, and whether resuming a stopped target emits a start record. Neither has been observed; the first allowed R1 call settles both.
- My step-0 question for the count check ("does every tool_use line carry `wireToolInputs`? zero lines without it means R1 and R2 can read the caller's sent keys from the transcript") was written in my reasoning before the run, not in a scratch file. I wrote no scratch files.

For: the executor, who files this beside round 1 in W-C02-27.1's triage EV record and either merges the block amended or records a disposition per objection. Also the test designer, who owns the wording of R1, R2 and the witness.

Received from / Returned to: I took the task from main and returned nothing to anyone; SendMessage is denied by T6.1, and I made no call. Outside my scope, for the executor: none beyond the objections below.

Product:
- **Test and claim.** Claim: the block's R1 and R2, its counted environment and its guard-record design let the executor read each live row without planting anything, and the outcomes cover every case. Environment: 2026-10-20, reads between about 18:45Z and 18:55Z; HEAD 81bf65e; session_01JDJ8fJQmrKpXfiRh1yEoxv; guard mode "default"; Claude Code 2.1.304 as stated by the transcript; container Python 3.13.16.
- **Steps:**
  - Read-only reads of the records and files listed above. All exit codes were 0.
  - `grep -c '"type":"tool_use"'` on the main transcript gave 1047, of which 0 lack `wireToolInputs`. The same count on agent-a0af1624f9cd84007.jsonl gave 42, of which 0 lack it.
  - `python3 --version` gave 3.13.16.
- **Answer: eight typed objections, no PROCEED.**
  - **O1 · defect · blocks: agreement on R1 and R2 (the red and neutral outcomes).** The block's "stored input" names no source.
    - The transcript's `input`, which is also what `tools/subagent_audit.py calls` reads (W-C02-27 row (ii)'s named source), is the backfilled copy without `summary`.
    - It holds the four platform keys for every call. So "holds only the platform's keys" is true of every call, and it cannot show whether a `summary` was the caller's own.
    - Met when R1, R2 and row (ii)'s comparison read what the caller sent from `wireToolInputs.<tool_use_id>`, on the transcript line matched to the guard record's `tool_use_id`, read with grep or sed. The expected relation is: record keys = wire keys plus the four backfilled keys plus `summary`.
    - Red: T6.1 or T6.10 when the wire keys are within {to, message, summary}, the wire `to` is a permitted target and the wire `message` is a string.
    - Neutral: a denial where the wire input itself breaks a rule.
    - Row (ii)'s reference to `subagent_audit.py calls` is marked superseded for this comparison.
  - **O2 · defect · blocks: R1's pass outcome.** "Then the target's Start record for the same `agent_id`" is not a sound condition.
    - It is not necessary: a target that is still running gets no new start record.
    - It is not sufficient: .agents line 37 is a run-2 start triggered by something else 22 s before #4295.
    - An allow with the right keys and no start record falls in no outcome.
    - Met when R1 is split:
      - R1-guard: pass, red, neutral or could not check.
      - R1-delivery: the call's tool result in the caller's transcript, plus the message appearing as a new turn in the target's transcript after the allow record's time. A start record is supporting evidence only, and a delivery failure after an allow goes to the executor as a platform finding, not this item's red.
    - The same split applies to R2.
  - **O3 · defect · blocks: the outcome set.** Three outcomes are missing:
    - (a) Over-admission: an allow on a call that W-C02-27's rules deny (a `to` not in the registry, a caller not permitted, an outside key, a failed tie) should be red. Only over-blocking is red now.
    - (b) Could not check: no guard record for the call's `tool_use_id` (row (ii)'s own branch), or a record in the old format (the old guard ran; F6). This is not red.
    - (c) "An allow whose key list differs from the witness" can only be an allowed raw shape. It should be its own outcome ("pass; the witness gets a new version and narrows to that caller and event"), not reopen the item. As written, the sentence leaves this open.
  - **O4 · missing evidence · blocks: the witness's provenance labels (the test designer's condition), not the approach.**
    - Not observed on the hook side: the `type` value (cut off in #4295), the `content` value and whether `message` is present (both dropped by `summary()`), and the full `to` (cut off in #4295).
    - The transcript's `type` and `content` come from a different copy, since it has no `summary`.
    - `recipient_kind` "main" has never been observed.
    - Met when the witness labels each key: observed from #4295 (the key names, `recipient`, `recipient_kind`, the 200-character `summary`) versus inferred from the transcript and the code (`type`, `content`, `message`, kind "main").
    - Natural occurrence that settles them: R1's record, once O5 holds; for kind "main", the first message from a role to main.
  - **O5 · defect · blocks: whether R1 and R2 can be read from the guard log.**
    - #4295 shows the 300-character cut losing `to`.
    - Met when, for every SendMessage allow and deny:
      - the sorted key names and each tie's result go in `detail` (no length cut), not only in `summary` or the denial text;
      - each tie result can read "absent", so raw and backfilled shapes can be told apart;
      - a failed tie on `type` or `recipient_kind` names the observed value (these are enumerations, not message text), so a red T6.10 can be diagnosed without a planted rerun;
      - `summary()` drops the `summary` key for SendMessage (today it keeps it, :587-588).
  - **O6 · scope conflict · blocks: R2's definition.**
    - W-C02-27 row (iii) is a role writing to a registered sibling's ID (kind "agent"), answered, with Received and Returned lines in both hand-overs.
    - "R2, the same from a registered role" leaves out the role-to-main case, the only path that exercises kind "main".
    - Met when R2a (role to sibling, row (iii), holds acceptance) and R2b (role to main) are both named, and it is decided in advance whether R2b holds acceptance or is recorded as resting on the code read alone.
  - **O7 · missing evidence · blocks: the counted-environment line for the live rows.**
    - Met when the line names the attributes that must match:
      - the version, from the `version` field of the call's line in the caller's transcript;
      - the session ID;
      - the event, PreToolUse;
      - the caller kind (`agent_id` null or a registered ID) and the target kind;
      - the mode as logged ("default" since #121, not acceptEdits), because mode bears on whether PermissionRequest fires.
    - If a PermissionRequest record for the same call appears naturally (matched by time and tool, since its `tool_use_id` is null), it is read as the natural observation of the shape the block calls unconfirmed; its absence is recorded too. No call is planted.
  - **O8 · defect · blocks: the replay check's definition (the test designer's).**
    - "Passes through the guard's own summary to #4295's `summary` field" can only match through the `summary()` of add6608, because the new one drops `summary`, and only within the 300-character cut.
    - "The transcript's six key-value pairs" are the transcript's `input`, not the hook copy.
    - Met when the replay names add6608's `summary()` and the transcript's `input` as its two references.
- **Not run:** any SendMessage call (the task's constraint); any reading of /opt/claude-code (the researcher's); any synthetic hook run (not needed for this answer).

Guard denials: none.

## 8. Round 2, producer `a513b866ecf2bbe62`

### Task

Item: plan/work/W-C02-27.1.md

**Your field's question (producer):** does the block carry your method as you would build it (the admitted keys, the ties, the order with T6.10 last, the raw shapes kept, `message` a string in every shape, structured messages denied), the logging change (the record and denial for `SendMessage` carry sorted key names and tie results, never the values of `message`, `content` or `summary`), the rewritten T6.1 text, the `writes:` line and its split into two pull requests (the tests first by the test designer, then your build), and the lock-out and cost you stated? Name anything the block changed from your note that you cannot build as written.

**Purpose:** team triage, round 2, of W-C02-27.1 (working order section 4 step 1a; D-039): every asked role answers the integrated approach block `PROCEED` or with a typed objection (a defect, missing evidence, a preference or a scope conflict), from its own field. The approach is agreed only when each asked role's last answer is `PROCEED` or its objection has a disposition in the block. The decision it serves: T6's key check rewritten against the input the platform really delivers to the hook (W-C02-27 row (ii), red at guard record #4295), with W-C02-27's narrowing kept strict.

**Acceptance:** none yet; the test designer writes the condition after this round (working order section 4 steps 2 and 2a).

**Consumer:** the executor, who files your answer in W-C02-27.1's triage EV record beside round 1, and either merges the agreed block or records a disposition for your objection.

**Inputs:** the integrated block, a draft not yet on `main`: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md` (two placeholders, `ROUND2_ASKED` and `RECORD_ROW_I`, are filled after this round). The five round-1 notes it integrates, each taken with `tools/subagent_audit.py last`, DISCIPLINES OK: researcher `ac276961647514c80` (`w271_r1_researcher.md`), prober `a0af1624f9cd84007` (`w271_r1_prober.md`), producer `afa58577986640b22` (`w271_r1_producer.md`), test designer `a9c72999c83948ff1` (`w271_r1_testdesigner.md`), checker `ad97f09223020d9da` (`w271_r1_checker.md`), all under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/`. Also `plan/work/W-C02-27.md`, `.claude/hooks/tool_allowlist.py` (T6), `tools/test_send_message.py`, and CHK-C02-152 (`evidence/C02/checks/CHK-C02-152.md`, its C3). `main` is at `81bf65ec32c100b0ec24630c4d67974c4eac7539`. Library line: your role file's map; the round-1 notes name what was read; read further only if your answer needs it.

`Teammates:` none reachable by message: `SendMessage` is denied to every caller by T6.1 until this item merges. Return anything in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, with your answer (`PROCEED`, or each objection typed, with what it blocks and what would meet it) under its product heading; the executor takes it with `tools/subagent_audit.py last`.

**Writer or reader:** reader: this is a triage answer; you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 30 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/r2/` only.

**Constraints:** no `SendMessage` call, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017).

Your take-up and returns: see your role file.

### Note (verbatim)

Package: producer@d379362747dd
Nonce: fb49b4259ac411ef
Take-up: PROCEED. The task holds. It is a round-2 triage answer on an integrated block that carries my round-1 method, so it is in my field. Following package M1, I tested the block's clauses on a scratch prototype instead of only reading them.

## Disciplines (D1–D9)
D1: yes: I checked each clause the block changed from my round-1 note (T6.10 last, `message` a string in every shape, the logging change, two pull requests) against what it does to existing cases, and found that one of them silently flips W-C02-27's P-12.
D2: uncertain: the block takes my method, which pulls toward agreeing with it, so I ran the block as written in a scratch clone and report every case that differs from what the block says.
D3: yes: the purpose is that real calls pass with the narrowing kept strict and readable from the log, so I checked that the prototype keeps every W-C02-27 rule ID, admits the observed shape and the raw shapes, and keeps message text out of the log.
D4: yes: my prototype run is not independent assurance, and I say so; it shows only that the block can be built as written, and the binding check stays the test designer's version plus a fresh checker.
D5: yes: the block summarises five notes, so I read my own round-1 note and the checker's and test designer's notes in full, plus the guard's current `summary()`, `deny_text()` and `log_decision()`, rather than trusting the block's wording about what the record carries.
D6: no
D7: no
D8: yes: I confirmed that the live tree and a fresh scratch clone are both at `81bf65ec32c100b0ec24630c4d67974c4eac7539`, and that the guard and the W27 test are byte-identical between add6608 and 81bf65e.
D9: yes: I read nothing new in the library; the block's library line (superpowers U04, run the real behaviour; gstack P6, no false green) supports running the clauses on a scratch copy, which is what I did.

Read, and what each changed:
- `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md`, whole: this is the object of the answer.
- `w271_r1_producer.md`, `w271_r1_testdesigner.md`, `w271_r1_checker.md` (same scratchpad), whole: the baseline for "what changed from my note". The test designer's order and FC14, and the checker's F-A to F-H, justified the block's changes.
- I did not read `w271_r1_researcher.md` or `w271_r1_prober.md` this round. The block's facts from them (`coerceInput`, the backfill) match what I read from the binary in round 1.
- `/home/user/devos/.claude/hooks/tool_allowlist.py`:
  - :462-487 (the T6 RULES), :572-595 (`summary()`), :2400-2560 (T6 and `decide()`) and :2580-2650 (`log_decision`, `deny_text`, `main`). These showed where the logging change has to go: `summary()` feeds the record's `summary`, the denial text and the record's `reason`. They also showed it can stay inside `summary()`'s own non-raising catch.
- `/home/user/devos/tools/test_send_message.py`: P-12 at :226 and N-K2 at :243. Changed the answer: P-12 is an allow case for `{to}` alone.
- `/home/user/devos/plan/Installation_Working_Order.md`:
  - :52 and :217 (the merge gate and W-C02-24.1's run rule). Changed the answer: these decide which pull request may carry the two `plan/` texts.
  - :215 and :236 (the lock-out residual).
- `/home/user/devos/plan/decisions/PC-53.md`:1010: the same T6 text; its sentence "T6 does not read a message's content or type" becomes false.
- `/home/user/devos/plan/work/W-C02-24.1.md`:241-244 (D2, D3): showed that the two-pull-request split follows the one-writing-run rule now in force.
- Not read on purpose: CHK-C02-152 C3 (W271-8 is the test designer's to decide), and EV-C02-030 (W271-9 is the executor's record correction).

Relied on:
- [observed, scratch] The block as written, applied as a 38-line-added, 8-line-removed patch to `.claude/hooks/tool_allowlist.py` at 81bf65e:
  - The W27 guard test is red only on N-K2 (now allowed, as the block intends) and P-12 (now denied T6.10, which the block does not state).
  - N-K3 to N-K6 stay T6.1, because a single platform key is a partial set.
  - All 23 probe cases pass on both events, among them a name with kind "name" getting T6.6 under T6.10-last, a disagreeing tie from a disallowed caller getting T6.7, and a raw object message getting T6.10.
  - No SendMessage record in the scratch log holds message text.
  - `tools/test_tool_allowlist.sh` and `tools/test_agent_hooks.py` stay green.
- [observed] `summary()` drops `message` and `content` but not `summary` (tool_allowlist.py:587-589). Its output is used in the record (:2594), in the denial text (:2607) and in the record's `reason` (:2595 via `text`). So one `SendMessage` branch inside `summary()`'s try covers all three, and it cannot raise (:576-578, :592).
- [observed] A test-designer run "covers only test and oracle paths… a head that changes another declared path under a run confirmed as a test designer is the checker's refusal" (Installation_Working_Order.md:217).
- [observed] After a route revert, the executor runs `tools/test_tool_allowlist.sh` (Installation_Working_Order.md:217).
- [inferred] Tie results can be computed for every decision T6 makes except T6.0, whose detail is fixed when an exception is caught. A SendMessage call denied before T6 (G0, F6, or L4, which is withheld) carries no tie results.

Unsure:
- Whether the platform's validation ever lets `{to}` through without `message`. Whatever it does, the condition has to pin P-12's outcome. The researcher could settle it from the schema's required list.
- Whether `request_id` and `approve` are set when an object message lacks them. This decides whether a platform-shape structured message gets T6.1 or T6.10. Both are denials. The test designer pins it, and the build follows the pin.

For: the executor, who files this in W-C02-27.1's triage EV record beside round 1 and either merges the block with the points below folded in or records dispositions. The test designer, for the pins named below.

Received from / Returned to:
- Taken: this triage, from the executor. Nothing came from a teammate (`SendMessage` is denied).
- To the executor, outside my field and not done by me:
  - `plan/decisions/PC-53.md`:1010 and `plan/Installation_Working_Order.md`:215 both say "T6 does not read a message's content or type". After this item, T6 checks that `message` is one string and that `type` is "message", so both sentences need the change along with the key-set sentence.
  - The guarantee about log values covers only `message`, `content` and `summary`. The values of `to`, `recipient`, `recipient_kind`, `type` and any unknown key are still shown, within 300 characters. R1 needs `to`'s value. Recorded so that nobody reads the guarantee as wider than it is.

Product:
Answer to round 2, clause by clause. The block carries my method, and every change it made from my note can be built. My PREFERENCE 3a (T6.10 last), 3b (structured messages denied) and 3c (`message` a string in every shape) are taken and shown working. The logging change and the two-pull-request split can be built. Below are four points: two defects, one missing statement, and one preference.

1. PROCEED on `agreed:` (the key rule).
   - Covered: the seven admitted keys; the four platform keys all together or none; the ties; disagreement denied, never resolved; the raw shapes kept; structured messages denied; T6.10 after T6.7 and last before the allow.
   - The prototype keeps every W-C02-27 negative's rule ID, and a name still gets T6.6.

2. DEFECT, on `agreed:` "`message` a string" and W271-3. Blocks the condition, because the test designer cannot pin a rule the block does not decide.
   - Requiring `message` to be a string in every shape also denies `{to}` alone. W-C02-27's P-12 allows that today (test_send_message.py:226), and the prototype gives it T6.10.
   - T6.10's title, "a platform key disagrees with to and message", does not cover a missing or non-string `message`, which is not a platform key.
   - It is met when the block states that P-12 becomes a denial (a narrowing), names its rule, and words T6.10's title to cover the case. My proposal is T6.10, titled "a platform key disagrees with to and message, or message is not one string", with the detail "message is absent or not one string".

3. DEFECT, on `agreed:` "T6.1's 'What to do instead' is rewritten". Blocks the build as written.
   - T6.1's title, "an input key outside to and message" (tool_allowlist.py:473), and its detail, "only to and message are admitted" (:2427), become false under the new key set.
   - Rewriting only the "What to do instead" text would leave a denial whose title contradicts the rule.
   - It is met when the block says T6.1's title and detail change as well. Proposed title: "an input key not admitted". The detail names the keys not admitted, or "a partial set of the platform's keys (…)". The test designer pins the exact texts, and I build to them.

4. MISSING_EVIDENCE, on the block as a whole: the lock-out and cost I stated in round 1 are not in the block. This blocks the binding checker's liveness reading. It is met when the block carries these two sentences or equivalents:
   - Lock-out: "The key and tie checks sit inside `send_message_checks`, under T6's catch (any error is T6.0 for that call only), and the log change sits inside `summary()`'s non-raising catch. A refusal blocks only `SendMessage`. The revert route (a pull request through the GitHub tools, then `tools/sync_worktree.sh`) does not pass through T6. A key a later platform version adds fails closed as T6.1 with the key named, and its fallback is W-C02-27 point 11's recipe."
   - Cost: "The guard change is about 38 lines added and 8 removed (measured on a prototype). Two writing runs (the test designer's, then the producer's), a test verdict at PR1, the binding verdict at PR2 (a full fresh check of T6), and the replay in scratch. PR2 is built only after PR1 is merged and synced. A test fault found during the build goes back to the test designer as a new tests pull request before PR2, never into PR2."
   - My round-1 cost (18+2 lines, one pull request) no longer holds: the block added the logging, the T6.1 and T6.10 texts and the second pull request.

5. PROCEED on the logging change (W271-5), with one clarification I would build unless told otherwise.
   - The sorted key names (at most 12 shown) and each tie's result are appended to the detail of every decision T6 makes, the allow and T6.1 to T6.10.
   - T6.0 carries neither, because its detail is fixed in the catch.
   - A SendMessage call denied before T6 (G0, F6, L4) keeps those rules' texts.
   - Every SendMessage record and denial omits the values of `message`, `content` and `summary`, through the `summary()` branch.
   - The prototype's allow record reads: `…; keys [content, message, recipient, recipient_kind, summary, to, type]; ties message agrees, type agrees, recipient agrees, recipient_kind agrees, content agrees, summary agrees`, and its `summary` field is `{"recipient": …, "recipient_kind": "agent", "to": …, "type": "message"}`.
   - The test designer should pin this format so that R1's "key list equal to the witness" can be read mechanically.

6. PREFERENCE, on `writes:` and W271-6 (two pull requests). Blocks nothing. I accept the split; my round-1 "one pull request" did not account for the test designer writing the tests under the one-writing-run rule. Two things the block should say:
   - (a) PR1 can hold only `tools/test_*` paths, because Installation_Working_Order.md:217 makes any other declared path under a test-designer run the checker's refusal. So `plan/Installation_Working_Order.md` and `plan/decisions/PC-53.md` go in PR2, as the executor's record paths, and `.claude/hooks/tool_allowlist.py` is my run's only path there.
   - (b) Between PR1's merge and PR2's, `main` holds tests that are red against the live guard, in all three files. The executor's post-revert read-back of `tools/test_tool_allowlist.sh`, and any other item's checker, would see that red for this reason. The block should name the window and its expected red cases, and keep other floor merges out of it.

**Files:** none in `/home/user/devos`. Scratch only, under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/r2/`:
- `patch2.py`: the block's prototype, not the build. Diff SHA-256 a84c1eddf0b57a917e521fcc6a7d320452c02acb3a8d15f6f5701ee96c862c38.
- `probe2.py`: 23 cases × 2 events, plus a log check.
- `clone/`: a fresh clone at 81bf65e with the patch applied.
- `tal.out`, `tah.out`: the outputs of the two other test files.

**Tests:**
- `python3 tools/test_send_message.py --only guard` in the patched clone: "W27 FAIL 4 BAD, 0 NOT RUN, 158 ok". The four BAD are P-12 on both events (expected allow T6, got deny T6.10) and N-K2 on both events (expected deny T6.1, got allow T6). The exit code was not captured, because the output was piped through grep.
- `python3 ../probe2.py .claude/hooks/tool_allowlist.py` in the clone: "PROBE PASS 0".
  - "SendMessage records: 46 | records holding message text: 0".
  - OBS-1 to OBS-4, RAW-1 and RAW-2 are allowed T6. NEG-1 to NEG-17 are denied with their pinned IDs; NEG-13 (a name with kind "name") gets T6.6.
- `bash tools/test_tool_allowlist.sh`: exit 0, "ALLOWLIST_TEST PASS".
- `python3 tools/test_agent_hooks.py`: exit 0, "103 cases, 0 BAD", "AGENT_HOOKS_TEST PASS".

**Where it ran:** /usr/bin/python3, Python 3.13.16, in this container, in the scratch clone at 81bf65ec32c100b0ec24630c4d67974c4eac7539. The guard was driven through the W27 harness, which calls the `.claude/settings.json` hook commands with a scratch `DEVOS_GUARD_LOG_DIR`.

Guard denials: none.

## 9. Round 2, test designer `a85385642d3420b60`

### Task

Item: plan/work/W-C02-27.1.md

**Your field's question (test designer):** (1) can you write this item's condition and its tests from the block as integrated (the shape witness, the cases, the breaks B-0 and B-16 to B-21, the replay check, the twins, the live rows R1 and R2 with their outcomes), and where does the block depart from your round-1 note? (2) The block's disposition W271-8 is yours to fill: CHK-C02-152 C3 (scope conflict) says W-C02-27 point 10 (i) reads "the old line" as "role files not reloaded, a new session", but the first role run after W-C02-27's sync (producer `a9519e914534ff414`, launched 17:04:56Z, 1 min 52 s after the merge `6a6585c` at 17:03:04Z) ran the old `producer.md` (no `SendMessage`, the old body size), while later runs in the same session (researcher `a738e84458e67d309` at 17:11:21Z, checker `ae6f06283aba18948` at 17:18:28Z, checker `aa8570fed063c7083` at 17:38:26Z) held `SendMessage` and the new Send-back line: a reload lag the row did not foresee. State how row (i) reads that sequence and which run records it, as one line the executor puts in W271-8; or return it, with your reason, if it is not yours.

**Purpose:** team triage, round 2, of W-C02-27.1 (working order section 4 step 1a; D-039): every asked role answers the integrated approach block `PROCEED` or with a typed objection (a defect, missing evidence, a preference or a scope conflict), from its own field. The approach is agreed only when each asked role's last answer is `PROCEED` or its objection has a disposition in the block. The decision it serves: T6's key check rewritten against the input the platform really delivers to the hook (W-C02-27 row (ii), red at guard record #4295), with W-C02-27's narrowing kept strict.

**Acceptance:** none yet; you write the condition after this round (working order section 4 steps 2 and 2a).

**Consumer:** the executor, who files your answer in W-C02-27.1's triage EV record beside round 1, and either merges the agreed block or records a disposition for your objection.

**Inputs:** the integrated block, a draft not yet on `main`: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md` (two placeholders, `ROUND2_ASKED` and `RECORD_ROW_I`, are filled after this round). The five round-1 notes it integrates, each taken with `tools/subagent_audit.py last`, DISCIPLINES OK: researcher `ac276961647514c80` (`w271_r1_researcher.md`), prober `a0af1624f9cd84007` (`w271_r1_prober.md`), producer `afa58577986640b22` (`w271_r1_producer.md`), test designer `a9c72999c83948ff1` (`w271_r1_testdesigner.md`), checker `ad97f09223020d9da` (`w271_r1_checker.md`), all under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/`. Also `plan/work/W-C02-27.md`, `.claude/hooks/tool_allowlist.py` (T6), `tools/test_send_message.py`, and CHK-C02-152 (`evidence/C02/checks/CHK-C02-152.md`, its C3 and its relied_on 4). `main` is at `81bf65ec32c100b0ec24630c4d67974c4eac7539`. Library line: your role file's map; the round-1 notes name what was read; read further only if your answer needs it.

`Teammates:` none reachable by message: `SendMessage` is denied to every caller by T6.1 until this item merges. Return anything in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's hand-over, with your answer (`PROCEED`, or each objection typed, with what it blocks and what would meet it) and the W271-8 line under its product heading; the executor takes it with `tools/subagent_audit.py last`.

**Writer or reader:** reader: this is a triage answer; you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 30 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/r2/` only.

**Constraints:** no `SendMessage` call, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017).

Your take-up and returns: see your role file.

### Note (verbatim)

Package: test-designer@9f8557260d35
Nonce: d62c366e58bce8e9
Take-up: PROCEED. I can write the item's condition and tests from the block as integrated. Before I write the test recipes, the block needs one interface point pinned (O1) and one checker-floor item disposed of (O2). O3 is a preference and blocks nothing. The W271-8 line is in my field and is given under Product.

## Disciplines (D1–D9)
D1: yes: I weighed three readings of row (i) against each other: "old line", so a new session; recorded by the first later run holding the new text; recorded on a fresh run after the reading is fixed. I chose the third because the second gives up the ordinal after its result was seen.
D2: yes: it would be easier to close W-C02-27 by counting the researcher run already seen, so I named that reading as a loosening and kept a fresh repeat.
D3: yes: I read row (i) by its claim (W-C02-27's role files take effect in this session) and followed the chain merged, synced, loaded, used; it breaks only in timing at "loaded".
D4: yes: the evidence for "new line" is a size, not the text, so I checked that +245 matches the body diff exactly (+258 in the file, 13 of it on the `tools:` line) and kept the verbatim quote as the text witness.
D5: yes: I did not rely on CHK-C02-152's summary. I read the subagent prefix records and the 6a6585c diff myself, which showed the researcher run is the second run after the sync and already holds both.
D6: uncertain: I did not diagnose why the reload lags; knowing the cause would not change how row (i) reads, so it goes to CHK-C02-152 C1's record.
D7: no
D8: yes: I checked that `tool_allowlist.py` has not changed between add6608 and 81bf65e (so B-0's guard is the base's), and the order of every role run after the sync.
D9: uncertain: I did not open the library again. The round-1 sources (the SDLC playbook's "an incident becomes a permanent case", gstack P6) still justify B-0 and the replay, and CHK-C02-152's citation of gstack F2 ("merged and synced is not loaded") bears on the lag; nothing new was needed.

Read, and what each changed:
- The scratch approach block `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md`, in full. It is the object of this round.
- My round-1 note `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_r1_testdesigner.md`, in full. It gave the departures listed below.
- `/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md` §2 item 3 and §3. Gave the disciplines block.
- `/home/user/devos/plan/work/W-C02-27.md` point 10 with rows (i) to (iii), and point 11. Point 10 is the row W271-8 reads.
- `/home/user/devos/evidence/C02/checks/CHK-C02-152.md`: C3, relied_on 4 and 5, unsure (a). These are the facts W271-8 reads.
- `w271_r1_checker.md` and `w271_r1_producer.md`, by grep for the floor and the rule IDs. These produced O1 (the producer's 3c says "when present") and O2 (the checker's ≤200 floor).
- `/home/user/devos/.claude/hooks/tool_allowlist.py` :471–487 and :2422–2518, the T6 rules. They confirmed there is no `message` check today.
- `git log add6608..81bf65e` on the guard and test file: empty, so B-0 is valid at the base.
- `/home/user/devos/tools/test_send_message.py` :181, 226, 242–257. Found that P-12 (`{to}` alone) is "allow" today (O1).
- `git show --stat 6a6585c` and the producer.md diff, plus file sizes before and after the merge for all five role files. Gave the +258 = 13 (`, SendMessage` on the tools line) + 245 (Send-back line) split.
- The session's subagent prefix and meta records under `/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/subagents/`: start time, agent type, `systemCharCount`, `toolNames`. These decided which run comes first and what each held.
- Deliberately not read: the researcher's and the prober's round-1 notes beyond what the block carries, and the library. Neither bears on the two questions.

Relied on:
- Run order after the 17:03:12Z sync of 6a6585c [observed, prefix and jsonl records]:
  - producer a9519e914534ff414, 17:04:56.340Z: no SendMessage, 9479 characters (the size before W-C02-27).
  - researcher a738e84458e67d309, 17:11:20.974Z: SendMessage present, 11059 characters, which is the earlier researcher size 10814 plus 245.
  - checker ae6f06283aba18948, 17:18:28Z: 19896 characters, which is 19651 plus 245.
  - checker aa8570fed063c7083, 17:38:26Z: 19896 characters, which is the W-C02-27 size, not yet W-C02-24.1's 21996.
  - No other role run falls in that window.
- First producer run holding both: afa58577986640b22 at 18:35:53Z, 9724 characters (9479 plus 245) [observed]. Every role run from 18:35Z on holds SendMessage and the +245 [observed].
- At 6a6585c each role file grew by 258 characters: 13 on the `tools:` line (`, SendMessage`) and 245 on the Send-back line [observed]. That the system-prompt delta of 245 is that line [inferred: the size matches exactly; the text is not compared].
- The sync time 17:03:12Z [stated, CHK-C02-152 relied_on 4, from the reflog].
- The verbatim Send-back line, as received by aa8570fed063c7083 [stated, CHK-C02-152 relied_on 5].
- The guard is unchanged from add6608 to 81bf65e [observed].
- P-12, `{to}` alone, is "allow" under the merged T6 [observed, test_send_message.py:226].
- The producer's 3c says "`message`, when present, a string" [stated, w271_r1_producer.md:84]. The checker's floor says "`summary` a string of at most 200 characters" [stated, w271_r1_checker.md:69].

Unsure:
- The cause of the reload lag, and whether it works per file or per session. Observed only at 1 min 44 s (missed, producer.md), 4 min 02 s (missed, checker.md after 9fdd9c2) and 8 min 09 s (taken up, researcher.md). It would be settled by a platform statement on when agent definitions refresh, or by more dated runs; CHK-C02-152 C1's record owns it.
- Whether the researcher run a738e84458e67d309 quoted its Send-back line in its own report. I did not check; W271-8 does not depend on it.

For: the executor. It files this beside round 1 in W-C02-27.1's triage EV record, gives O1 and O2 a disposition or folds them into the block, puts the W271-8 line in, and merges the block. I then write the condition and the tests from it.

Received from / Returned to:
- Received: none (SendMessage is denied by T6.1).
- Returned to the executor, with the producer (O1): the rule ID and scope of the `message` check.
- Returned to the executor, with the checker (O2): the `summary` length floor.
- Outside my scope, for the executor: other items' rows that read "the first run after the sync" of a changed role file, such as W-C02-24.1's checker.md text, which aa8570fed063c7083 did not yet hold. Under the same lag those rows can misread. This belongs to CHK-C02-152 C1; I did not act on it.

Product:
- **Files:** none. This is a triage answer; nothing was written in `/home/user/devos`, on GitHub or in scratch.
- **Coverage:** the answer to question (1), the departures from my round-1 note, and the W271-8 line.
  - **O1 · defect · blocks:** my test pull request's recipes for these cases (W271-6, its first pull request). The block says "`message` must be a string in every shape", but the producer's 3c, which it adopts, says "when present", and no rule ID is given.
    - Today `{to}` alone (P-12) and `{to, summary}` are allowed, and `message` is not checked at all.
    - Met when the block states, in one sentence:
      - (a) the outcome of `message` absent: allowed as P-12, or denied with a named rule;
      - (b) that `message` not a string, in the raw shape or the platform shape, is T6.10 with the key `message` named, in T6.10's place (last).
    - If P-12 flips to deny, W271-7 must also name P-12 as a tightening of W-C02-27's case, so its earlier result on P-12 narrows.
  - **O2 · missing disposition · blocks:** the condition, which never asks less than the checker's triage. The checker's floor has "`summary` a string of at most 200 characters"; the block has "one string", and no disposition gives up the length limit.
    - Met by a line under W271-1, either way.
    - I recommend giving it up, with this reason: a caller's `summary` is not sent to a subagent target, its value is no longer logged (W271-5), and 200 is the platform's cutting rule, which the block chose not to couple to. The condition would then carry a 201-character caller `summary` as a positive case.
  - **O3 · preference · blocks:** nothing. My round-1 item (4) was dropped: the live rows look only at the first occurrence.
    - Proposal: add to W271-1's reopen list: any later natural T6.1 or T6.10 denial whose stored input holds only the platform's keys reopens this item.
    - It costs nothing. It catches over-blocking on call shapes R1 and R2 do not reach: another caller kind, message length, PermissionRequest.
  - **Carried into the condition by me (no block change needed):**
    - The replay passes the built input through `summary()` of the guard at the base (= add6608, which wrote #4295), not the new build's, which drops values.
    - Record-content cases: distinctive values of `message`, `content` and `summary` are absent from the guard record and the denial text, and the sorted key names and tie results are present. Break B-22: values logged again, red. R1 rests on this (FC14).
    - The tests pull request is red against the live guard by design (B-0). The checker judges it on a stub build. The test files have no gate run point (FC13, N-321), so its merge is not blocked by that red.
  - **Other departures from round 1, all accepted:**
    - A caller's `summary` is admitted (my P-S2).
    - Structured messages are denied (my N-V3c, W271-4).
    - Raw shapes are kept (my open point).
    - Two pull requests, tests first (W271-6).
    - Logging key names and tie results with no values (W271-5) goes beyond what I asked.
  - **Not covered:** as the block names it. I add that the cause of the reload lag is not covered by row (i).
  - **W271-8 line (for the executor to put in as written):**

    W271-8: Row (i) is read by its claim (W-C02-27's role files take effect in this working session at 2.1.304), not by its ordinal, and the sequence is a reload lag, an outcome the row did not list; the "old line" branch (not reloaded, a new session) does not apply, because the next run of the same session refutes its premise. The first role run after the 17:03:12Z sync, producer `a9519e914534ff414` (17:04:56Z, 1 min 44 s later; prefix record: no `SendMessage`, systemCharCount 9479, the size before W-C02-27), is recorded as the lag's observation, not as a row result. The earliest run holding both is researcher `a738e84458e67d309` (17:11:20.974Z, 8 min 09 s after the sync; prefix toolNames with `SendMessage`, systemCharCount 11059 = 10814 + 245, the new Send-back line's exact size, the role-file diff at 6a6585c being +258 characters of which 13 are `, SendMessage` on the `tools:` line outside the prompt), with checker `aa8570fed063c7083`'s verbatim quote (CHK-C02-152 relied_on 5) as the text witness. Because the ordinal is given up after its result was seen, this reading is a loosening (ledger rule 3; Ek G G8 item 3): those runs stand as exploratory, and row (i) is recorded, by the executor's decision, on the first role run launched after this block merges, from its prefix record (toolNames holds `SendMessage`) and its hand-over's quote of the Send-back line, byte-equal to its role file's line at the synced head; every role run since 18:35Z already holds both, so this adds no time on the critical path. The claim narrows: a synced role-file change was taken up by a run 8 min 09 s after the sync (researcher.md) and missed by runs 1 min 44 s (producer.md) and 4 min 02 s (checker.md, after 9fdd9c2) after it; the lag's cause and bound go to CHK-C02-152 C1's record (owner the executor), not to row (i).
- **Open:**
  - O1 and O2 as above.
  - The lag affects any row elsewhere that reads "the first run after the sync" of a changed role file. Reported to the executor under CHK-C02-152 C1; not done.

Guard denials: none

## 10. Round 2, checker in triage `a39b9d35ea84a63f3`

### Task

Item: plan/work/W-C02-27.1.md

**Your field's question (checker, triage; you are excluded from this item's binding verdict):** does the block carry the round-1 triage's claim, failure classes F-A to F-H, depth (a full fresh check of the whole of T6, product-only reading first), floor and exclusion list, and the five objections it raised (each taken, or disposed of with its reason)? Is anything the block now claims beyond what its evidence can show (for example the caller-independence of the shape, or PermissionRequest), and is the two-pull-request split (W271-6) right for the merge gate's `producer_run` rule? Your output is a labelled non-binding contribution in your role file's triage form.

**Purpose:** team triage, round 2, of W-C02-27.1 (working order section 4 step 1a; D-039): every asked role answers the integrated approach block `PROCEED` or with a typed objection (a defect, missing evidence, a preference or a scope conflict), from its own field. The approach is agreed only when each asked role's last answer is `PROCEED` or its objection has a disposition in the block. The decision it serves: T6's key check rewritten against the input the platform really delivers to the hook (W-C02-27 row (ii), red at guard record #4295), with W-C02-27's narrowing kept strict.

**Acceptance:** none yet; the test designer writes the condition after this round (working order section 4 steps 2 and 2a).

**Consumer:** the executor, who files your answer in W-C02-27.1's triage EV record beside round 1, and either merges the agreed block or records a disposition for your objection; the binding checker, who reads the triage after its own pass.

**Inputs:** the integrated block, a draft not yet on `main`: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md` (two placeholders, `ROUND2_ASKED` and `RECORD_ROW_I`, are filled after this round). The five round-1 notes it integrates, each taken with `tools/subagent_audit.py last`, DISCIPLINES OK: researcher `ac276961647514c80` (`w271_r1_researcher.md`), prober `a0af1624f9cd84007` (`w271_r1_prober.md`), producer `afa58577986640b22` (`w271_r1_producer.md`), test designer `a9c72999c83948ff1` (`w271_r1_testdesigner.md`), checker `ad97f09223020d9da` (`w271_r1_checker.md`), all under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/`. Also `plan/work/W-C02-27.md`, `.claude/hooks/tool_allowlist.py` (T6), `tools/test_send_message.py`, `tools/merge_gate.py`, `.claude/agents/checker.md`, and CHK-C02-152 (`evidence/C02/checks/CHK-C02-152.md`). `main` is at `81bf65ec32c100b0ec24630c4d67974c4eac7539`. Library line: `research/studies/gstack/CORE.md` (F1 to F5) and `research/studies/superpowers/CORE.md` with `notes/U04-testing-diagnosis-and-verification.md`; the round-1 checker read both; read further only if your answer needs it.

`Teammates:` none reachable by message: `SendMessage` is denied to every caller by T6.1 until this item merges. Return anything in your hand-over's `Received from / Returned to:`.

**Output:** your final message, your role file's triage contribution, with your answer (`PROCEED`, or each objection typed, with what it blocks and what would meet it); the executor takes it with `tools/subagent_audit.py last`.

**Writer or reader:** reader: you write nothing in `/home/user/devos` and nothing on GitHub; scratch files only.

**Limits:** about 30 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/r2/` only.

**Constraints:** no `SendMessage` call, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017).

Your take-up and returns: see your role file.

### Note (verbatim)

Non-binding contribution: this instance does not give W-C02-27.1's binding verdict.

Package: checker@951789897e85

Nonce: af8b92ef0ef54a09

Take-up: PROCEED. The task holds. It asks for a round-2 triage answer from the checker's field. It does not steer a verdict and does not ask for a binding verdict, which I am excluded from. The no-`SendMessage` constraint comes with its reason (D-020, D-017) and binds me. Depth chosen: I checked the block's text against the five round-1 notes, `tools/merge_gate.py`, the working order section 10 and SB-COR 3.6b and 3.7. I ran no tests and made no breaks, because no product exists yet.

## Disciplines (D1–D9)
D1: yes: I set W271-6's two pull requests against one pull request and against the producer writing the tests too, and confirmed the split on the trace rule. I then asked what new steps the split creates.
D2: yes: the block takes most of my own round-1 objections, so I checked each against the block's text rather than its "taken" labels.
D3: yes: I asked whether the split leaves a next condition unverified (which pull request gets the full fresh check, and main's state between the two merges) and found it does (R2-2).
D4: yes: I applied item 3 (would a check turn red) to the break list and found it models only holes beyond B-0, not over-blocking (R2-5). Item 10 limits my reading: I am judging a block that integrates my own role's round-1 note.
D5: yes: the block is a derived view of five notes, so I compared its source labels with the researcher's own labels and found three "interpreted" facts carried as "stated in code" (R2-1).
D6: no
D7: no
D8: yes: I pinned `main` and HEAD at 81bf65ec32c100b0ec24630c4d67974c4eac7539 with a clean tree, and read the round-1 notes and the gate source myself.
D9: yes: I used gstack F1 (a dropped qualifier) and superpowers U04 (a break shows sensitivity to one defect) as the round-1 checker recorded them. I did not reopen the library, because the question is whether this block carries its notes faithfully.

Read, and what each changed:
- `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach.md` (whole). This is the target.
- `.../scratchpad/w271_r1_checker.md` (whole). Gave me the claim, F-A to F-H, depth, floor, exclusions and objections 1 to 5 to trace.
- `.../scratchpad/w271_r1_researcher.md` (whole). Changed the work: its labels (finding 2's PermissionRequest part and "the tool runs the original" are interpreted; finding 5, caller-independence, is interpreted) give R2-1.
- `.../scratchpad/w271_r1_testdesigner.md` and `w271_r1_producer.md`, grep only. The producer's "Split: no. One writer per file and one pull request" (line 103) sits against W271-6. The test designer's lines 104 and 127 justify B-0.
- `/home/user/devos/tools/merge_gate.py` lines 10–49 and 440–502. Justified W271-6: the gate checks `producer_run`'s form only, and two open items listing one path are covered by a verdict for either.
- `/home/user/devos/plan/Installation_Working_Order.md` lines 190 and 217. Changed the work: the one-writing-run rule and the test designer's `tools/test_*` scope confirm the split. Line 217 shows `tools/test_tool_allowlist.sh` as the read-back after a revert merges, which gives R2-2 (b).
- `evidence/C02/checks/CHK-C02-148.md`, `-149.md`, `-152.md` (front matter, conditions). Confirmed that a4d19adf834c366b6 and a819a6c7b206b9b67 are W-C02-27's binding checkers. aa8570fed063c7083 (CHK-C02-152) judged branch SB-COR, not T6's key check, and needs no exclusion.
- `plan/work/W-C02-27.md` B-1 to B-15 (line 50). Limited R2-5: B-12 covers L4-1 and T6-S, and B-15 covers T6 skipped on PermissionRequest, so F-H and that floor break are carried.
- `plan/SB-COR_Correction_Plan.md` lines 161 and 168. Changed the work: this is 3.6b's "only the input keys the schema shows" and 3.7's Batu point. The block names neither (R2-4).
- `.github/workflows/` (grep). No workflow runs the T6 test files, so a red test on main is not blocked by CI.
- `plan/Ek_D_Dusunme_Protokolleri.md` section 3 (trigger questions) and the full texts of D4 and D5.
- Not read: the prober's note in full, and the library. The round-1 checker read the library line, and this question does not need more.

Relied on:
- The block labels findings 1 to 4 "stated in code, not observed for a subagent or on PermissionRequest". Source: w271_approach.md line 6. Observed.
- The PermissionRequest hook receiving the backfilled copy is "Interpreted from code … never observed". The tool running the un-backfilled input is "interpreted from the call path". Caller-independence is "interpreted from code". Source: w271_r1_researcher.md lines 55, 57, 105 and 121. Observed (as the researcher's labels).
- W271-1 leaves `content` untied because "it is observer-only: the tool runs the original input". Source: w271_approach.md line 9. Observed.
- A test designer's run covers only `tests/` and `tools/test_*`, with one writing run per pull request. Source: working order line 217. Observed. All three test files in `writes:` match `tools/test_*`. Observed.
- The gate reads each item's `writes:` at the merge base and treats two open items listing one path as covered by a verdict for either. Source: merge_gate.py lines 41–45 and 493–497, and working order line 217. Observed.
- After a route revert merges, the executor runs `tools/test_tool_allowlist.sh` and records the read-back. Source: working order line 217. Observed.
- SB-COR 3.6b's key clause and 3.7's "if the narrowing cannot be made strict … goes to Batu with options". Source: SB-COR lines 161 and 168. Observed.
- B-0 makes every platform-shape positive red under the merged guard. At the tests pull request's head that guard is the live one, so those cases are red there by design. Inferred.

Unsure:
- Whether anything other than the post-revert read-back and other checkers' suite runs treats a red `tools/test_tool_allowlist.sh` on main as a regression. I found no workflow that does. A full grep of the working order and the role packages for runs of the suite would settle it.
- How the platform shapes an empty message (whether `summary` is absent or ""). The researcher's code read, or a test the test designer derives from the witness, would settle it.
- I did not check the prober's note against the block.

For: the executor, who files this in W-C02-27.1's triage EV record beside round 1 and either amends the block or records a disposition for each objection below. Then the test designer, who writes the condition, and the binding checkers, who read this after their own pass.

Received from / Returned to:
- Taken from the executor: this task. Nothing was returned and nothing was sent by message (T6.1 denies `SendMessage`).
- To the executor, outside my scope and not done: the producer's round-1 "Split: no … one pull request" (w271_r1_producer.md line 103) gets no disposition by name in W271-6. W271-6 gives the trace reason only. The other alternative, the producer writing the tests too, is ruled out by test-designer independence, which W271-6 does not say.

Product:

Answer: not yet PROCEED. Three defects block, each closable by a change to the draft block. One scope conflict needs a disposition line. Two preferences do not block. The design itself (the tie, the raw shapes kept, T6.10 checked last, the log carrying key names only) I would not change.

(1) Does the block carry round 1?
- Claim: carried in "agreed".
- F-A: B-16, B-17 and the tie negatives.
- F-B: platform-shape positives from `main` and from registered roles, `to` "main" with kind "main", and R2.
- F-C: the shape witness, P-R1, B-0 and the raw shapes. The empty-message and multi-line variants are missing (R2-5).
- F-D: T6.5 and T6.6 kept, and the recipient tie.
- F-E: W271-4 and B-20.
- F-F: "never resolved by picking a field and never rewritten", and byte-exact derivation deliberately not built. A fallback at a version change appears only as "read at each version change" under open.
- F-G: the raw shapes kept, but no break tests them (R2-5).
- F-H: B-12 and B-15 re-run in the platform shape.
- Depth and reading: carried in W271-10.
- Floor and own-break minimum: not in the block. They reach the binding checker through the filed triage, whose floor binds as a minimum, so this is not an objection.
- Exclusion list: correct for round 1, but the round-2 checker is missing (R2-3).
- Objection 1: taken in part. W271-1 states the replaced narrowing; the SB-COR 3.6b and 3.7 part remains (R2-4).
- Objection 2: taken (W271-4).
- Objection 3: taken (W271-3, agreement only), but see the labels in R2-1.
- Objection 4: taken (W271-5, R1's key list and tie results).
- Objection 5: taken (P-R1, the witness, B-0).

(2) Claims beyond the evidence:
- PermissionRequest, caller-independence and "the tool runs the original" are carried as stated in code; the researcher labelled all three interpreted (R2-1).
- The design does not depend on them: the raw shapes stay admitted, R2 settles callers at acceptance, and PermissionRequest is listed as not observed.
- The wording would still pass into the condition and the merge claim.

(3) W271-6 and `producer_run`:
- The split is right. With one pull request, the test designer's writes to the three `tools/test_*` files would be untraced in the producer's `calls`, which is missing evidence that blocks the merge.
- The tests pull request names the test designer (`launch --item W-C02-27.1`, "TEST-DESIGNER CONFIRMED"); the build pull request names the producer.
- The gate passes both under item W-C02-27.1's `writes:`.
- What is missing is the steps the split creates (R2-2).

Objections:

R2-1 · type: defect · blocks: producer task (the test designer's condition is written from these lines) · closure: diff-confirmed.
- The defect: "agreed" labels findings 1 to 4 "stated in code". The researcher labels three facts interpreted: that the PermissionRequest hook receives the backfilled copy, that the tool runs the un-backfilled input, and that the shape does not depend on the caller (findings 2 and 5). W271-1's reason for leaving `content` untied rests on the second.
- Met when: the block labels each of the three as interpreted from code, and W271-1's `content` reason says it rests on that interpretation and names what reopens it.

R2-2 · type: defect · blocks: merge (the tests pull request) · closure: diff-confirmed.
- The defect: W271-6 and W271-10 do not say the following.
  - (a) Which pull request the "full fresh check of the whole of T6" judges, and what the tests pull request's verdict claims. At that head B-0 is the live state, so that verdict can show only that the new tests are red exactly where the merged guard over-blocks and that W-C02-27's negatives stay green with their IDs.
  - (b) That between the two merges, main carries tests that are red by design, including the twins in `tools/test_tool_allowlist.sh`. That suite is the read-back after a route revert (working order line 217) and the regression suite other guard checks run. A revert of the build would return main to that state.
  - (c) In whose build record the replay sits, and which checker re-runs it.
  - (d) That the exclusions hold for both binding checks.
- Met when: the block names (a) to (d), including the expected red set at the tests head by case ID.

R2-3 · type: defect · blocks: merge · closure: diff-confirmed.
- The defect: W271-10's exclusion list names only the round-1 triage checkers. This run, a39b9d35ea84a63f3, took part in this item's triage, plus any other round-2 checker.
- Met when: W271-10 lists every checker run of both rounds.

R2-4 · type: scope conflict · blocks: none (frame review; the approach) · closure: diff-confirmed.
- The defect: this is the rest of round-1 objection 1. The block replaces SB-COR 3.6b's "with only the input keys the schema shows" (line 161) without naming it. It also does not say whether 3.7's Batu point fires ("if the narrowing cannot be made strict, the choice … goes to Batu with options", line 168).
- My view: it does not fire. `to` alone decides, and no admitted key can reach another session; a caller's own `summary` is not transmitted and L4 reads it.
- Met when: a dispositions line names 3.6b's replaced clause and 3.7's state, with the reason.

R2-5 · type: preference · blocks: none (to the test designer) · closure: diff-confirmed.
- The defect: beyond B-0, every new break (B-16 to B-21) models a hole. The incident was over-blocking.
- Suggested additions:
  - "the backfilled keys made mandatory", which must turn the raw-shape positives red;
  - "`recipient_kind` forced to agent", which must turn the to-`main` positive red;
  - round-1 F-C's empty and multi-line message variants.
- Why it does not block: the round-1 floor already puts the first two on the binding checker's own breaks.

R2-6 · type: preference · blocks: none (to the executor) · closure: diff-confirmed.
- The defect: the replay depends on this container's session transcript and guard log.
- Met when: the block names what the binding checker writes if they are gone ("could not confirm", as in working order section 10).

Guard denials: none

## 11. The acceptance condition, test designer `a0e78f233c1b9c3d3`

### Task

Item: plan/work/W-C02-27.1.md

**Purpose:** write W-C02-27.1's acceptance condition (working order section 4 steps 2 and 2a): the item's agreed approach block is final after two triage rounds; the condition, the block and the triage record merge in one pull request before any test or product is written. The decision it serves: T6's key check rewritten against the input the platform really delivers to the hook (W-C02-27 row (ii), red at guard record #4295), with W-C02-27's narrowing kept strict; the tests then follow in their own pull request (W271-6), by a test designer, before the producer's build.

**Acceptance:** none yet; you write it. It is never loosened after a result is seen (ledger rule 3).

**Consumer:** the executor, who copies your acceptance block by tool, byte for byte, into `plan/work/W-C02-27.1.md` between the markers; the test designer of the tests pull request, who writes the cases from it; the producer, who learns what evidence the check will want; the two binding checkers (the test verdict and the build's full fresh check), who judge against it.

**Inputs:** the agreed approach block, final: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach_final.md` (its `agreed:` and dispositions W271-1 to W271-13 decide the content: the key rule, T6.10, the T6.1 texts, the record format, the two pull requests and their expected red window, the shape witness, the replay, the breaks, the live rows R1-guard, R1-delivery, R2a, R2b and row (i) by W271-8, the counted environment, what is not built). The ten triage notes it integrates, under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/`: round 1 `w271_r1_researcher.md`, `w271_r1_prober.md`, `w271_r1_producer.md`, `w271_r1_testdesigner.md`, `w271_r1_checker.md`; round 2 `w271_r2_researcher.md`, `w271_r2_prober.md`, `w271_r2_producer.md`, `w271_r2_testdesigner.md`, `w271_r2_checker.md`. The checkers' triage gives the floor and failure classes F-A to F-H you write the condition from (round 1, with round 2's R2-1 to R2-6). Also `plan/work/W-C02-27.md` (its condition's form and point numbering, a model for yours), `plan/work/W-C02-24.1.md` (the latest condition in this form, with its parts, `✘ Break` lines, `[pinned here]` and `[test commit: …]` markers, "Not covered", and its E-part on acceptance), `.claude/hooks/tool_allowlist.py` (T6), `tools/test_send_message.py`, `tools/test_tool_allowlist.sh`, `tools/test_agent_hooks.py`, guard record #4295 in `/tmp/devos-guard/session_01JDJ8fJQmrKpXfiRh1yEoxv.jsonl`, and EV-C02-023 section 4 (rows R-25 and R-26). `main` is at `a668c39f3961145b2caf936c66cea31510142afa`. Library line (from your map): `research/studies/anthropic-ai-native-sdlc-playbook/` (its falsifiers: an incident as a permanent eval case; configuration tested like code) and `research/studies/gstack/CORE.md` (a check that did not run must not read as green).

`Teammates:` none reachable by message: `SendMessage` is denied to every caller by T6.1 until this item merges. Return anything in your hand-over's `Received from / Returned to:`.

**Output:** the acceptance block, from `<!-- acceptance -->` to `<!-- /acceptance -->` inclusive, as one file `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/cond/acceptance.md`, and your role file's hand-over as your final message (taken with `tools/subagent_audit.py last`), naming that file with its SHA-256.

**Writer or reader:** writer of the one scratch file under Output only; nothing in `/home/user/devos`, nothing on GitHub.

**Limits:** about 60 tool calls; no commit, push or GitHub write; scratch files under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/cond/` only. No tests are written in this task: the tests are the next pull request's.

**Constraints:** no `SendMessage` call, because every such call is now denied by T6.1 and a call made only to observe it would plant a live denial (D-020, D-017). The condition must not ask less than the checkers' triage floor except where the block disposes of it with its reason (W271-1 gives up the 200-character `summary` limit), because the working order makes the triage's floor a minimum.

Your take-up and returns: see your role file.

### Hand-over (verbatim)

Package: test-designer@9f8557260d35
Nonce: a1eb5dc3f55c6c47
Take-up: PROCEED. The approach block is final and settles every choice the condition depends on. The checkers' floor and failure classes F-A to F-H, with R2-1 to R2-6, can each be turned into a checkable point. Nothing in the task makes me producer or checker of this item. No `SendMessage` call was made (the constraint binds me, for the reason the task gives).

## Disciplines (D1–D9)
D1: yes: I compared a "red where it over-blocks" set with one that also counts tests passing for the wrong reason; I chose the second because, under the merged guard, every platform-shape negative fails with `T6.1`, not with its own rule (E1 (b)).
D2: yes: there is pressure to get messaging back, and I am integrating my own role's earlier notes, so I checked every point against the checkers' floor and the block's text, not against those notes' "taken" labels.
D3: yes: I followed the chain from guard record to delivery to reply into Part F, so that both W-C02-27's rows and this item's acceptance can be checked.
D4: yes: every new case is assigned to a group by how it behaves under the merged guard (B-0), every break names the cases that must turn red, and the replay ties the fixture to the platform's own records.
D5: yes: I went back from the block to the ten notes, guard record #4295, the T6 code and EV-C02-023 R-25/R-26; that turned up the producer's measured fact that N-K3 to N-K6 stay `T6.1` and the researcher's empty-message branch.
D6: yes: the condition goes after the cause (a fixture built from the schema) through the witness, the single builder, the replay and B-0, not only after T6's key list.
D7: no
D8: yes: I checked that `main` is at a668c39 and that the guard, the three test files and the settings file are unchanged since add6608 (empty diff), so B-0's guard is PR1's base guard.
D9: yes: I read the library line's two studies, which justified B-0, the replay and the "could not confirm" outcomes; details below.

Read, and what each changed:
- `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271_approach_final.md` (whole): decided the content.
- The scratchpad's `w271_r1_checker.md` and `w271_r2_checker.md` (whole): the floor, F-A to F-H, the minimum set of own breaks, the exclusions and R2-2's red window.
- `w271_r1_testdesigner.md` and `w271_r2_testdesigner.md` (whole): the case families and the replay; O1 to O3.
- `w271_r2_prober.md` (whole): the live-row outcomes, the `wireToolInputs` reference and the witness labels.
- `w271_r2_producer.md` (whole): showed that N-K3 to N-K6 stay `T6.1` (partial set), which changed A3 and A5's exceptions; also the logging form and the cost.
- `w271_r2_researcher.md` (whole) and `w271_r1_researcher.md` (grep): the empty-message branch (no `summary`), the unreachable repair path, and the agent-ID premise. These limited the claims and filled "Not covered".
- Not read: `w271_r1_prober.md` and `w271_r1_producer.md` in full (only a grep of the producer note). The block and the round-2 notes carry them.
- `/home/user/devos/plan/work/W-C02-27.md` (whole) and `/home/user/devos/plan/work/W-C02-24.1.md` (whole): the form, the IDs, the break numbering and Part D/E's structure.
- `/home/user/devos/.claude/hooks/tool_allowlist.py` lines 466–489, 570–596 and 2400–2473: the rule texts, the `summary()` drop and its catch, and the check order.
- `/home/user/devos/tools/test_send_message.py` lines 1–60 and 176–255; `/home/user/devos/tools/test_tool_allowlist.sh` lines 144–158; `/home/user/devos/tools/test_agent_hooks.py` lines 1080–1096: the twins and how they are counted.
- Guard record #4295 (Read tool, one line).
- `/home/user/devos/evidence/C02/EV-C02-023_platform_capability.md` lines 195–233.
- `/home/user/devos/plan/Installation_Working_Order.md` lines 215 and 217.
- `/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md` section 3, and the full texts of D1 to D9.
- Library, read 2026-10-20:
  - [library id: SDLC playbook, file 03 (its development OS assessment)] lines 346–358 ("incidents become permanent eval cases"; configuration tested like code) justified B-0 and the replay.
  - `research/studies/gstack/CORE.md` P6 and F4 (a check that did not run must not read as green; a test that exists is not a test that ran) justified "could not check" / "could not confirm" and the `NOT RUN` rule.

Relied on:
- The guard at a668c39 is byte-identical to add6608's: `git diff` is empty. Observed.
- #4295 is `deny T6.1`. Its detail lists content, recipient, recipient_kind, summary and type, and its `summary` field cuts the `to` value. Guard log line 4295. Observed.
- `summary()` drops `message` and `content` but not `summary`, cuts at 300 characters, and catches every exception (tool_allowlist.py:581–595). Observed.
- A single legacy key gives `T6.1` under the block's rule. w271_r2_producer.md:33. Stated, measured by the producer.
- An empty message gets no `summary`. w271_r2_researcher.md:101. Stated in code by the researcher.
- For a `to` that is not a string, the platform adds no keys. w271_r1_researcher.md:89. Stated in code; the condition labels it inferred.
- Every tool_use line carries `wireToolInputs`. w271_r2_prober.md:35. Observed by the prober.
- The 13 T6 lines in test_tool_allowlist.sh (:144 and :149–157) and G1–G12 in test_agent_hooks.py (:1082–1095). Observed.
- No workflow, gate or stop_check runs the three test files. w271_r2_checker.md:30; w271_r1_testdesigner.md:49. Stated.

Unsure:
- CT-1 assumes that replacing `redact` in-process shows the SendMessage branch is inside `summary()`'s catch. That holds only if the producer's branch calls `redact` after its own code. The producer can contest this before the build, or the binding checker reads it.
- Whether `/p` twins for the empty `to` and the `*` cases get the right `recipient_kind` depends on the builder's agent-ID rule, which is inferred. The expected rules do not depend on it, because T6.10 is checked last.
- E2's "no other floor merge in the window" can only be checked after the fact. Keeping other merges out is the executor's sequencing.

For:
- The executor, who copies the block by tool, byte for byte, into `plan/work/W-C02-27.1.md`.
- PR1's test designer, who writes the cases, IDs, witness, builder, stub and replay from it.
- The producer, who learns the pinned rule IDs, the order, the `[test commit]` items and the evidence wanted.
- The test-verdict checker and the binding checker, who judge against Parts A to G.

Received from / Returned to:
- Taken from the executor: this task. Nothing was received or sent by message (`SendMessage` is denied by T6.1).
- To the executor, outside my scope and not done:
  - (1) [pinned here] The test-verdict checker is also excluded from the binding verdict (anchoring, Ek D, D4 item 10). This goes beyond W271-10; tell me if you do not accept it.
  - (2) `plan/work/W-C02-27.1.md` does not exist in the working tree at a668c39, so the markers this block is copied between are not there yet.
  - (3) EV-C02-023 R-26 still says "Not shown … the keys the model emitted", but `wireToolInputs` shows them (prober round 2). This is a record correction for the executor.

Product:
- **Files:** `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w271/cond/acceptance.md`, SHA-256 `d9fceb9d3ecf01e8a5193d717fbd2917bd9ec07292fc7eaa30fea6867fade1e4`, 385 lines. It is the acceptance block from `<!-- acceptance -->` to `<!-- /acceptance -->`, inclusive:
  - Part A: the key rule, with positives, `T6.1` keys, `T6.10` ties, the platform-shape twins of W-C02-27's negatives, the pinned order, L4 and containment, and the texts.
  - Part B: the record.
  - Part C: the witness, the builder and the replay.
  - Part D: B-0 and B-16 to B-26, plus B-1 and B-3 to B-15 re-run.
  - Part E: PR1's test verdict with the expected red set by case ID, the red window, the order, the binding verdict and exclusions, what the item does not touch, and the public texts.
  - Part F: the live rows R1-guard, R1-delivery, R2a, R2b, row (i), the standing reopen condition and W-C02-27's rows.
  - Part G: the counted environment, the added time (plan 6.12 item 1), acceptance, and "Not covered".
- **Coverage:**
  - The block's `agreed:` and W271-1 to W271-13.
  - The checkers' F-A (A4, B-16, B-17), F-B (P-x/p, P-7/p to P-9/p, R2a/R2b), F-C (P-R1, PP-*, the witness, B-0), F-D (N-T2, the T6.5 twins), F-E (N-T9 to N-T11, N-T14 to N-T16, B-20), F-F (no exact derivation; disagreement denied), F-G (raw shapes, B-23) and F-H (A6).
  - The round-1 floor and its own-break minimum (E4 and Part D).
  - R2-1 (labels in Terms and C1), R2-2 (E1, E2, C2, E4), R2-3 (E4), R2-5 (B-23, B-24, PP-E, PP-M) and R2-6 (C2).
  - The prober's O1 to O8 (Part F, B1, C1, C2) and the test designer's O1 to O3 (P-12, PP-S2, F5).
  - Given up with its reason: only the 200-character `summary` floor (W271-1).
  - Not covered: as listed at the block's end. In short: exact derivations, PermissionRequest observed, other versions, the seven other backfilled tools and a run point (N-321), and SB-COR's own text.
- **Open:**
  - Pins the producer may contest before the build: the twin ID scheme (`/p`, `G<n>p`, ` [platform shape]`), N-T15's `T6.10`, B-23 to B-26, and CT-1's injection point.
  - Left to the test commit: the exact T6.1 and T6.10 texts, the detail format, the PASS marker, and how twins in the other two files get their inputs.
- Plan contradictions found: none beyond A5's correction. A legacy key added to a full platform set is a tie, so it gets `T6.10`, not `T6.1` (the producer's measurement). That is why N-K1 to N-K9 have no `/p` twins.

Guard denials: none
