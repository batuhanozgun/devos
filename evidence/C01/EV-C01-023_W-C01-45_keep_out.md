# EV-C01-023 · W-C01-45: plugins the repository does not provide kept out of DevOS's sessions from the repository (PC-35 "Routing" items 1 and 2; 2026-10-11)

**What this is.** The record that W-C01-45's acceptance block asks for in its last paragraph. It covers items 1 to 4 with the evidence envelope, and it meets the two conditions of CHK-C01-092:
- C1, the documentation facts in PC-21 item 9's form: section "Documentation facts".
- C2, the over-blocking that T4 adds: section "Over-blocking".

Two fresh-context checkers judged the change itself before the merge, both at `4daf915`: CHK-C01-091 (PASS) and CHK-C01-092 (PASS-WITH-CONDITIONS). This record does not judge the change again. It records the change, a test run at the merged head, and item 4, which can only be done after the merge.

Conventions:
- Lines are cited at `f607b0b`: `guard:` is `.claude/hooks/tool_allowlist.py`, `test:` is `tools/test_tool_allowlist.sh`, `settings:` is `.claude/settings.json`, and `WO:` is `plan/Installation_Working_Order.md`.
- Documentation is cited as `<page>.md:<line>` in the fetched copies named under "Documentation facts".
- Records `#n` are records of the working session's guard decision log, `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl`.
- This record does not spell out the workflow option's key for an agent type, nor the Agent tool's field for it. A workflow prompt that quotes this record is then not denied by T4 (over-blocking item (5)).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `f607b0b5fc4e5827cc8a84fb9978da10a23d9115`, the merge of pull request #241 (2026-10-11T17:30:37Z). The verdicts' head is `4daf9151f0091d8fd42a41fd182ffa7488241b41`. Between `4daf915` and `f607b0b`, `git diff --stat` touches 10 record files only. It touches nothing under `.claude/` or `tools/`, and neither the working order nor `plan/work/W-C01-45.md`. The blobs are the same at both commits: `.claude/settings.json` `62ef9b79d763ea8bac5037e43013c251ec574fbe`, `.claude/hooks/tool_allowlist.py` `956f1b34ccf674138bf0d10b3fdd1bb77ccb8666`, `tools/test_tool_allowlist.sh` `4aec421e738865a27b6b70f115c71793a0e866c9`, `plan/Installation_Working_Order.md` `0af59c99390c67fbf6c586c4f2c41647066ebaa1`. The working session's live tree is at `f607b0b` with a clean `git status` (the confirmation report, finding 1) |
| Deployment configuration | Items 1 to 3: the files in the repository. The tests run the guard as a plain process outside the platform; the test reads the two guard hook commands from `.claude/settings.json`. The test ran in the Linux container of the working session `session_01XyxvJd3RayQk4HCrjurbVH`, in this producer's clone. Item 4: that working session, a cloud session opened from the app. It synced `f607b0b` at 17:30:44Z, mid-session. Its account's plugins were synced into its user-level plugins folder at its start, on 2026-10-10 at about 20:58 by the container clock (PC-35 P3). It has not started again since the merge (the working session's statement) |
| Criterion version | W-C01-45's acceptance block, blob `ce09c8cc4cf2f31bdcd712ef70a845f6c9ceed77`. The SHA-256 of the block, from `<!-- acceptance -->` to `<!-- /acceptance -->` inclusive, is `1c5c600f64c50157cead78bce0669765a7b5429c702bc643f5f5b5128c2bc416`. The block is byte-identical from `584af0d` (2026-10-11T16:22:32Z, before the change was made) to `f607b0b`. It is read with PC-35 (blob `c5e669bd619d5ad2b4c62e61c86900abfe96a294`) "Routing" items 1, 2 and 4, with PC-21 item 9 (plan line 973), with plan Section 8 items 7, 9 and 14, and with CHK-C01-092's conditions C1 and C2 |
| Input | (1) `bash tools/test_tool_allowlist.sh`, then `python3 -B tools/test_merge_gate.py`, at `f607b0b` in this producer's clone (branch `claude/c01-w45-record`, not on the remote), 17:39:20Z to 17:41:54Z. (2) The checkers' runs at `4daf915` (CHK-C01-091 finding 1; CHK-C01-092 finding 5). (3) Decision-log records #9745 to #9775 and #9876 to #9888, read with `sed -n`, and `tools/guard_report.py --since 2026-10-11T17:30:44Z`. (4) The post-sync confirmation report of workflow `wf_f9eb3d74-902`, a checker subagent of the same session. (5) The documentation pages that CHK-C01-092 fetched; this producer re-read the quoted lines and did not fetch them again. (6) ECC's synced manifest and `scripts/lib/hook-flags.js`, read with Grep, and the times of ECC's three log files at 17:42:23Z |
| Actual observation | Test at `f607b0b`: 814 `ok`, 0 `BAD`, 1 `info` (3 controls skipped, branch not on the remote), final line `ALLOWLIST_TEST PASS`, exit 0, standard error empty. Merge gate: `MERGE_GATE_TEST PASS (24/24)`, exit 0. At `4daf915` (both checkers): 817 `ok`, 0 `BAD`, 0 `info`, nothing skipped. Item 4 is in its section |
| Raw evidence ID | SHA-256 of this producer's outputs: test standard output `fc3e5a35550a4c7e943af731c360d6a258cd175981ff1b7239056dd0dd5ab213` (816 lines); test standard error `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (empty); merge-gate output `30ad3d87e8aa9940ed1e99a25684928c7ab16195bdf8a29ce2e2caef886d7177`. These outputs and the confirmation report (`w45_postsync_confirm.md`) are kept only in the session's scratchpad, not in the repository. A re-run gives the same counts, not the same bytes, because the output carries temporary paths. The decision log and the session's transcript live on the platform's side |
| Independence level | Everything is from the same session. Items 1 to 3: the change's producer, and two fresh-context checker subagents at `4daf915` (declared, Ek A 5.3; PC-06). This producer re-ran the test at the merged head: the same session's own test (plan Section 8 item 7). Item 4: the working session observing itself (its own decision log and statements), and a fresh-context checker subagent of the same session (the confirmation report). This producer re-read the decision-log records and the three log files' times. All of these share the model, the session, the documentation copies and the sources. No separate session and no second model family looked at it; that is missing coverage, not agreement (plan Section 8 item 7). A later fresh-context checker judges this record (the block's last paragraph) |

## Item 1. The guard: skills and agent types the repository provides (T4)

**What the change does, by element** (CHK-C01-092 finding 5; CHK-C01-091 findings 2 to 4):
- **Skill.** The tool is allowed only for an exact directory name under `.claude/skills/` of the guard's own checkout (guard:1973, :2040).
  - Today that is one skill, `synthetic-word-tally`, whose front-matter name is the same.
  - Denied in probes: a trailing space, a case change, `.`, `..`, an absolute path, a plugin's namespaced skill, a user-level skill name, a list, null.
- **Agent and Task.** The type must be defined in `.claude/agents/`, by file stem or declared name. Today those are the five roles: checker, counter-designer, producer, prober, researcher. Otherwise it must be one of the four built-in types the guard names: general-purpose, claude, claude-code-guide, statusline-setup (guard:119, :1982, :2032-2038). A call that names no type counts as general-purpose and is allowed. A type that is not one name is denied.
- **Workflow.** T4 reads the same text as T3: the `script` text and the file at `scriptPath` (guard:2062). Every mention of the agent-type word there must open the option's key, followed by one quoted name and `,` or `}` (guard:120-121). The name must be one of the types above. Anything else is denied.
- **The rule entry.** It gives the reason, where the rule is written, and what to do instead (guard:212-221).

**The tests** (test:165-206):
- **Planted negatives, denied:**
  - a plugin's skill;
  - a plugin's agent type in Agent and in Task;
  - a plugin's agent type in an inline workflow script and in a `scriptPath` script;
  - five forms of the option that the guard cannot read.
- **Counterparts, allowed:**
  - the repository's skill;
  - each of the five roles;
  - general-purpose, and a call with no type;
  - the executor's workflow form for its checkers, with the option set to one quoted `'checker'` and with no option.
- **"Each built-in type the executor uses."** The executor's 65 Agent calls name only its roles (checker 37, producer 23, researcher 5); none names a built-in type (CHK-C01-091 finding 3). The built-in it reaches is general-purpose, through a call with no type, and the tests allow it.

**The counts:**

| Run | Commit | `ok` / `BAD` / `info` | Skipped | Final line, exit | Standard error | Merge gate |
|---|---|---|---|---|---|---|
| CHK-C01-091 (finding 1) | `4daf915` | 817 / 0 / 0 | none | `ALLOWLIST_TEST PASS`, 0 | empty | `MERGE_GATE_TEST PASS (24/24)` |
| CHK-C01-092 (finding 5) | `4daf915` | 817 / 0 / 0 | none | `ALLOWLIST_TEST PASS`, 0 | no SyntaxWarning | `MERGE_GATE_TEST PASS (24/24)` |
| This producer | `f607b0b` | 814 / 0 / 1 | 3 (branch not on the remote) | `ALLOWLIST_TEST PASS`, 0 | empty | `MERGE_GATE_TEST PASS (24/24)`, 0 |

- 814 + 3 = 817, and the guard and test blobs are the same at both commits (envelope).
- Against `main` before the change (`5c1aee8`), the suite had 772 `ok`. The 45 new lines are 31 T4 decisions (12 allow, 19 deny), 2 warnings-as-errors controls and 12 wrapper controls (CHK-C01-091 finding 1).
- **Break test** (CHK-C01-091 finding 1). The branch suite was run against `main`'s guard. It ends `ALLOWLIST_TEST FAIL`, and every new T4 deny line turns `BAD`. So the tests would catch a guard without T4.
- **Lock-out** (CHK-C01-091 finding 5). There were 144 runs of both live hook commands, under `/bin/sh` and bash. Each gave exit 0 and one answer in its event's form.
  - Role Agent calls and the checker workflow form are allowed.
  - Of the executor's 21 saved workflow scripts, 17 are allowed. The other 4 are denied only because prompt prose uses the agent-type word (over-blocking item (5)).

**Item 1's result: met.** The counts are recorded above.

## Item 2. `.claude/settings.json`

- **The plugin off** (settings:9-11): `"enabledPlugins": {"ecc@synced": false}`.
  - The key's form `<name>@synced` is the one the documentation gives for a plugin synced from the account (facts D2 and D3 below).
  - The documentation does not define `<name>` for a synced plugin (fact D5). So the name comes from the synced manifest. Its entry for the plugin reads `"name": "ecc"`, `"marketplaceName": "ECC"`, `"installationPreference": "available"` (`~/.claude/plugins/synced/<id>/manifest.json`:141, 145, 146, read by this producer with Grep; also CHK-C01-092 finding 3).
- **Its own switch for its hooks** (settings:5-8): `"ECC_HOOKS_ENABLED": "false"` in `env`.
  - ECC's synced code reads that variable first: `areHooksEnabled` at `scripts/lib/hook-flags.js`:65-67, in both synced copies of the plugin, with the default true at :6. A value of "false" makes `isHookEnabled` (:122) return false (CHK-C01-092 finding 3).
  - Not read: whether every ECC hook goes through `isHookEnabled` (CHK-C01-092 finding 3). Item 4 observes the effect in part.
- **Validity.** The file is valid JSON (the suite's `json.load` of it passes).
  - The `hooks` object is byte-identical to the one before the change, so both guard hooks are as they were (CHK-C01-091 finding 7; CHK-C01-092 finding 5).
  - The change added only `env.ECC_HOOKS_ENABLED` and `enabledPlugins`.
- **The documentation facts** carry PC-21 item 9's claim in "Documentation facts" below (C1).

**Item 2's result: met.** The PC-21 form for item 2 is in "Documentation facts".

## Item 3. The working order (sections 3, 9 and 10)

- **Section 3** (WO:35): the opening check counts the hooks the repository does not provide that the session can see. They are counted by event, not named, or recorded as "could not read", and never as zero for a folder not read.
- **Section 9** (WO:95): the Guard line names the denials made by any hook other than the guard since the previous entry, with their count and what each denied.
- **Section 10** (WO:154): "Not protected" names hooks from plugins enabled at account level.
- These meet item 3 (CHK-C01-092 finding 4).
- Two points for the next opening count, owed by that opening and not by this record (CHK-C01-092 finding 4):
  - WO:35 reads "the plugins under the user-level plugins folder", where PC-35 item 1 (c) says "the user-level synced plugins". The folder also holds a stale ECC directory (listed in the manifest's `staleDirs`) and a `.trash` entry. So the first opening entry after the merge states which directories it counts and how.
  - The guard denies `python3` naming `~/.claude` (B5). That count is made with readers or a `tools/` script.

**Item 3's result: met.**

## Item 4. After the merge

### 4.1 The merge and the sync

- **The merge.** The merge call is #9746 (17:30:35Z, the GitHub merge tool, allow, rule M7). Its detail reads "GATE PASS: PR #241 head 1365ed2bc12c". The merge commit is `f607b0b` (17:30:37Z).
  - `1365ed2` merges `main` into the branch on top of `6681d4b`. `6681d4b` adds only the two verdicts and the log entry L-238 to `4daf915`.
- **The sync.** `tools/sync_worktree.sh` ran at 17:30:44Z and printed "SYNC OK: f607b0b = origin/main" (the working session's fact).
  - The sync's own call is #9750 (17:30:43Z, allowed). The reflog dates the fast-forward to 17:30:44Z.
  - `.claude/settings.json` and the guard have the modification time 17:30:44 (the confirmation report, finding 1).

### 4.2 The guard report right after the sync (N-173 (e))

Records #9749 to #9760. "Working session" means `agent_id` null. Read by this producer with `sed -n`; the confirmation report's finding 2 gives the same table.

| # | Time (Z) | Tool | Decision | Rule | Whose |
|---|---|---|---|---|---|
| 9749 | 17:30:40 | Bash | allow | B0 | working session: the guard report before the sync |
| 9750 | 17:30:43 | Bash | allow | B0 | working session: the sync's own call |
| 9751, 9752 | 17:30:44, 17:30:46 | Bash | allow | B0 | two subagents |
| 9753 | 17:30:47 | Bash | allow | B0 | working session: the guard report after the sync (with the HEAD and the `enabledPlugins` count) |
| 9754 to 9756 | 17:30:50 to 17:30:53 | Bash | allow | B0 | two subagents |
| 9757 | 17:30:57 | Write | allow | T1 | working session: the first creation of a new file (4.5) |
| 9758, 9759 | 17:30:57, 17:31:01 | Bash | allow | B0 | two subagents |
| 9760 | 17:31:06 | Bash | allow | B0 | working session |

- **The report's output.** That #9753's report showed the hash chain intact is the working session's statement; the record holds the command, not its output.
- **This producer's own report.** `tools/guard_report.py --session session_01XyxvJd3RayQk4HCrjurbVH --since 2026-10-11T17:30:44Z` was run at about 17:40Z. It printed:
  - "4 denied, 159 allowed, 0 passed to the user";
  - "Allowed by rule: B0 130, L1 1, T1 26, T2 1, T3 1";
  - "Hash chain: intact";
  - "Last record: #9913".
- **The denials after the sync.** None is by T4:
  - #9777 (L2), the working session's own push, which shared its call with another command;
  - #9815 (G0) and #9841 (B5), one subagent;
  - #9851 (G0), another subagent.

**So after the sync, the merged guard is live in the working session and allows its calls.**

### 4.3 One allowed Agent call of a repository role

- **The call.** #9878, 2026-10-11T17:37:36Z, tool Agent, decision allow, rule T2. Its detail reads "an in-process subagent of the type 'producer' (T4)". Its `agent_id` is null, so the working session made it. It runs in the background, with the description "W-C01-45 evidence file (EV-C01-023)".
- **What it started.** It started this record's producer, whose first call is #9879 (17:37:39Z).
- **Which record it is.** It is the most recent record with tool Agent and `agent_id` null before that first call. It is the "T2 1" in the report since the sync (4.2).
- **The decision-log number.** `tools/guard_report.py` counts allowed calls only by rule, so the record number is given here (CHK-C01-092 finding 8 (a)).

### 4.4 One allowed Workflow call (the lock-out check)

- **The call.** #9772, 2026-10-11T17:31:43Z, tool Workflow, decision allow, rule T3. Its detail reads "an in-process workflow (T4: checker)". Its `agent_id` is null.
- **What it ran.** It is the post-sync confirmation workflow `wf_f9eb3d74-902`. Its script file's modification time is 17:31:43, and its checker's first call is #9774 at 17:31:46Z (the confirmation report, finding 5).
- **Which record it is.** It is the "T3 1" in the report since the sync.

**So a role Agent call and the executor's checker workflow form both pass the merged guard in the session that synced it.**

### 4.5 PC-35 "Routing" item 2's observation, in the running session

The facts, with their source and level:

| # | Fact | Source and level |
|---|---|---|
| a | Before the merge, ECC's first-creation gate (PC-35 P2) denied the first creation of every new file. Its own count reached "denial #79 this session"; the last of these was at 17:29:28.937Z | The session's transcript, read by the confirmation report's checker (finding 3). The working session's self-observation, read by a fresh-context subagent |
| b | After the sync, #9757 (17:30:57Z) created a new file, and no hook denied it. The transcript shows 7 `PreToolUse:Write` hook results, all successful with exit 0, then "File created successfully". After it there is no gate message and no blocking hook error. The file's birth time and modification time are both 17:30:57.378Z | The transcript and `stat` (confirmation report, finding 3) |
| c | ECC's hook commands still start. Six of those seven hook results are ECC's own commands. After the Write, the transcript has 20 runs of ECC hooks, the last at 17:32:01Z, all with exit 0 and empty output | The transcript (confirmation report, finding 3) |
| d | ECC's three log files (a command log and a cost log under `~/.claude`, and a tool-usage file under `~/.claude/metrics`) were last modified at 17:30:45.010Z to 17:30:45.030Z. Their last lines record the sync's own call, #9750. No line has been added since, although many Bash calls followed. Before the sync these files recorded subagents' calls too, so silence after it is a signal that could have shown growth | `stat` and the files' last lines, read by the confirmation report's checker up to about 17:35Z (finding 4). This producer at 17:42:23Z: the same three modification times (`ls`), with 7007, 7007 and 9446 lines |
| e | The running session's lists of skills and agent types were set at its start, and they still include ECC's. T4 denies them (item 1) | The working session's statement, 2026-10-11. It is not in the confirmation report. Before the merge, CHK-C01-091 (finding 3) saw ECC's namespaced agent types in the session's agent listing |
| f | No new start has happened since the merge | The working session's statement |

**Classification in PC-35's terms, for the running session: not "Out", "Inert".**
- "Out" needs ECC's skills and agent types to be no longer offered. They are still offered (e).
- "Inert" is "they are offered, and no hook of it acts". Both halves are shown:
  - no denial by any ECC hook after the sync (b);
  - no growth of its log files (d).
- **The residual.** ECC's code still starts on every call (c). This is what PC-35 option (D) foresaw for its switch: "its hooks still start, read the switch and do nothing".

**Which setting made it inert is not shown.**
- The inference is ECC's own switch, which `hook-flags.js`:66 reads first.
- Two things point there:
  - The hook commands still start (c), so in the running session the plugin was not unloaded.
  - By the settings reference, project `env` values apply "again when a saved change alters the merged `env`" (fact D6), which the sync did.
- Two things are not known:
  - whether the `enabledPlugins` entry acts at a fresh start;
  - when a running session takes up a plugin change (PC-35 P3).
- So the running session cannot show whether the repository's entry keeps ECC out.

**The fresh-session case is still to observe.**
- At the working session's first start after the merge (a changed boot ID, or a new sync time in the user-level plugins folder), the executor records:
  - whether ECC's skills or agent types are still offered (Out or Inert);
  - whether any ECC hook acts;
  - section 3's count at that start (CHK-C01-092 finding 8 (b), (d)).
- P4's run (W-C01-46, `execution: planned`) observes a routine session.
- If no new start comes before C01's stage close, the observation is recorded as not made, and PC-35 "Routing" item 4 applies.

### 4.6 PC-35 "Routing" item 4's trigger: does not fire now

- **What the trigger names.** A DevOS session "after item 1 has merged", namely "the working session after item 2's start, or P4's run". The session must still offer ECC's skills or agent types, or show one of its hooks acting.
- **Why it does not fire.** Neither session it names exists yet:
  - item 2's start is the working session's first start after the merge, which has not happened (4.5 f);
  - P4 has not run.
- **The hook half.** In the running session no ECC hook acts (4.5 b, d). So that half would not fire it even there.
- **The other reading.** If the running session is read as a session the trigger names, the trigger fires now, because ECC's skills and agent types are still offered there (4.5 e). The account question would then go to Batu with option (b)'s "made inert by its own switch if item 2 shows that the switch holds" supported by 4.5.
- **Why this record does not take that reading:**
  - the running session's lists were fixed at a start before the merge, so they cannot show whether the change works;
  - PC-35 "Routing" item 5 foresees exactly this ("The working session may keep ECC's hooks until it next starts").
- The checker judges this.

**Item 4's result.**
- **The report after the sync: met.** It has allowed-call records after the sync, among them one allowed Agent call of a repository role (#9878) and one allowed Workflow call (#9772).
- **Item 2's observation.** It is recorded earlier, for what the running session shows (Inert: the hooks are inert, the code still starts). Two readings of the block follow:
  - **(A), this record's reading.** The observation item 2 asks for, whether ECC's skills or agent types are still offered, can only be made at a new start. So it is still owed: at the first start after the merge, or as "not made" before C01's stage close, after which item 4 of the routing applies. On (A), item 4 is met in part, and W-C01-45 cannot be accepted before that observation or its "not made" record.
  - **(B).** The block's "or earlier if the running session already shows the change" is met by 4.5. On (B), item 4 is met, and the fresh-start case is left to the routing's item 4 trigger.
  - The trigger does not fire now on either reading (4.6). The checker judges which reading holds.

## Documentation facts (PC-21 item 9; CHK-C01-092 C1)

**The sources.** These are the Claude Code documentation pages that CHK-C01-092's checker fetched on 2026-10-11 into the session's scratchpad (`docs092/`). This producer re-read each quoted line in those copies on 2026-10-11 between 17:39Z and 17:43Z and did not fetch them again. Line numbers refer to those copies.

| Page | URL | Fetched (Z) | Lines | SHA-256 of the copy |
|---|---|---|---|---|
| `settings-reference.md` | https://code.claude.com/docs/en/settings-reference | 17:06:49 | 6442 | `632ca58b63afeac3dde90eef93e55f4b91039dc49d8c39754e31760de7f74e1c` |
| `plugins-loading.md` | https://code.claude.com/docs/en/plugins/loading | 17:07:07 | 395 | `981414aeb654516276a878dc8f8942f251b279ba36b9003fe77355e4e24484a5` |
| `settings.md` | https://code.claude.com/docs/en/settings | 17:06:34 | 768 | `a8cc395af5e0938659ddfd38a703bdc8a5151640216c5230098408e30625e380` |
| `cloud-environments.md` | https://code.claude.com/docs/en/cloud-environments | 17:06:49 | 794 | `8a249b9094768984a50cd4d13bdac75ddf96bc719ad43f3f2cb02a2b44cb1a7d` |
| `sub-agents.md` | https://code.claude.com/docs/en/sub-agents | 17:06:35 | 1420 | `dd3f22aa021a3525f48227321c34eab28b322d7ab77cb3d5fc01ddd048e8f6ea` |
| `skills.md` | https://code.claude.com/docs/en/skills | 17:06:35 | 1217 | `35fd2c11f870fbe1497a53796de31b2a6b760645e724bda58894525356d4602a` |

**The facts behind the key and the switch (item 2):**
- **D1. The key.** `enabledPlugins`: "Turn individual plugins on or off, keyed by `plugin-name@marketplace-name`", with scope "Any file" (settings-reference.md:4633, 4635). Guaranteed by platform (documented in https://code.claude.com/docs/en/settings-reference, read 2026-10-11); not independently tested.
- **D2. A synced plugin's key.** Claude Code downloads the plugins enabled for the claude.ai account "into `~/.claude/plugins/synced/` at the start of terminal sessions where you sign in with your claude.ai account and in Cowork sessions, and loads each one as `<name>@synced`" (settings-reference.md:4287). "To turn off one synced plugin rather than all of them, set `"<name>@synced": false` in `enabledPlugins`" (:4295). Guaranteed by platform (documented in https://code.claude.com/docs/en/settings-reference, read 2026-10-11); not independently tested.
- **D3. When a synced plugin loads.** It is "On unless the manifest sets `defaultEnabled: false` or a settings file sets `"<name>@synced": false`. A plugin your organization marks as required loads regardless" (plugins-loading.md:54). "Synced plugins load in Cowork sessions and in terminal sessions where you sign in with your claude.ai account" (:99). Guaranteed by platform (documented in https://code.claude.com/docs/en/plugins/loading, read 2026-10-11); not independently tested.
- **D4. The repository's route.** "To keep the plugin out of a project in every environment, set the same key in the project's committed `.claude/settings.json`" (plugins-loading.md:127). Project settings take precedence over user settings, and "Plugins force-enabled by managed settings can't be disabled this way" (settings-reference.md:4658). Guaranteed by platform (documented in https://code.claude.com/docs/en/plugins/loading and https://code.claude.com/docs/en/settings-reference, read 2026-10-11); not independently tested.
- **D5. `<name>`.** For a marketplace plugin, `<name>` is the entry name in `marketplace.json`; for `@inline` and `@skills-dir` it is the `name` in the plugin's manifest (plugins-loading.md:56). The page gives no rule for `@synced`. Guaranteed by platform (documented in https://code.claude.com/docs/en/plugins/loading, read 2026-10-11); not independently tested.
- **D6. `env`.**
  - It sets environment variables "for every session and for the subprocesses Claude Code starts from it" (settings-reference.md:2879).
  - Values from project and local settings apply "after you trust the workspace … and again when a saved change alters the merged `env`" (:2907).
  - "most `env` values apply only after each teammate trusts the folder" (settings.md:721).
  - Guaranteed by platform (documented in https://code.claude.com/docs/en/settings-reference and https://code.claude.com/docs/en/settings, read 2026-10-11); not independently tested.
- **D7. A session with several repositories.** In an Anthropic-hosted environment it "reads only the `enabledPlugins` and `extraKnownMarketplaces` keys from each repository's `.claude/settings.json`, not permission rules, hooks, `env`, or other keys" (settings.md:754). Guaranteed by platform (documented in https://code.claude.com/docs/en/settings, read 2026-10-11); not independently tested.
- **D8. Cloud sessions.** "A cloud session doesn't install the plugins a repository turns on under `enabledPlugins`" (cloud-environments.md:284). The page's table has no row for plugins synced from the account. "Cloud sessions automatically load skills you enable on claude.ai" (:287). Guaranteed by platform (documented in https://code.claude.com/docs/en/cloud-environments, read 2026-10-11); not independently tested.

**The facts behind T4 (item 1):**
- **D9. Built-in agent types.**
  - "Explore and Plan skip your CLAUDE.md files … Every other built-in and custom subagent loads both, unless its definition sets … `omitClaudeMd`" (sub-agents.md:33). No role file sets that field (CHK-C01-092 finding 1).
  - The other built-ins are listed: claude, statusline-setup, claude-code-guide (:77-79).
  - "Claude starts a fork by requesting the `fork` subagent type through the Agent tool" (:1160).
  - "When Claude doesn't request a type, it gets the general-purpose subagent" (:1214).
  - Guaranteed by platform (documented in https://code.claude.com/docs/en/sub-agents, read 2026-10-11); not independently tested. The guard's comment carries the same claim (guard:115-118).
- **D10. The Skill tool.**
  - The permission rule's parameter form is `Skill(skill:deploy)` (skills.md:861). The guard reads the tool's input key `skill` from it; that the input key is `skill` is an inference from that form. If it were wrong, every Skill call would be denied, which fails closed (CHK-C01-092 finding 2).
  - A plugin's skill is namespaced (`/my-plugin:review`), and "The bare `/fancy` also invokes the skill unless another command already uses that name" (:452, :456).
  - "A few built-in commands are also available through the Skill tool, including `/init` and `/security-review`" (:829).
  - Guaranteed by platform (documented in https://code.claude.com/docs/en/skills, read 2026-10-11); not independently tested.

**The qualifiers C1 names:**
- **(a) Where synced plugins are documented.** The settings reference (`syncClaudeAiPlugins`, settings-reference.md:4287) and the plugin loading page (:99) document synced plugins, loaded as `<name>@synced`, only for terminal sessions signed in with a claude.ai account and for Cowork sessions.
  - Cloud sessions opened from the app are not named, and DevOS's working session is one.
  - The working session's container nevertheless holds the synced folder (PC-35 P3, observed).
  - So whether the key acts there is observed (PC-35 "Routing" item 2; 4.5 here), not documented. For the running session it is not yet shown either way (4.5).
  - WO:154 says the repository route "is observed, not documented". The more exact statement is CHK-C01-092's (finding 2): documented for terminal and Cowork sessions; DevOS's cloud sessions are not named, so observed. WO:154 is class high and is left as written here.
- **(b) The committed-settings sentence and its exception.** The plugin loading page says "To keep the plugin out of a project in every environment, set the same key in the project's committed `.claude/settings.json`" (:127). The same page says a plugin the organization marks as required loads regardless (:54). ECC's manifest entry reads `"installationPreference": "available"` (manifest.json:146). That "available" means "not marked as required" is an inference.
- **(c) Where `ecc` comes from.** The documentation defines `<name>` only for marketplace, inline and skills-dir plugins (plugins-loading.md:56). So `ecc` comes from the synced manifest's `name` field (manifest.json:141), not from the documentation.
- **(d) Several repositories, and folder trust.** A session with several repositories reads only `enabledPlugins` and `extraKnownMarketplaces` from the repository, not `env` or hooks (settings.md:754).
  - In such a session the switch does not apply, and neither does the guard (WO:149).
  - Most `env` values apply only after folder trust (settings.md:721; settings-reference.md:2907).

**PC-21 item 9's own qualifiers stand:**
- per environment, only the variables, secrets and network setting are separate;
- the GitHub identity and the account's connectors are shared across the account;
- an environment's variables are readable inside its own sessions;
- the channel to the model's own service stays open whatever the network setting;
- routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).

The facts hold for the version the pages describe. The working session's container reported Claude Code 2.1.296 earlier (EV-C01-004 line 29); this record did not read it again.

## Over-blocking T4 adds (CHK-C01-092 C2)

Each item says what T4 denies that is not a plugin's, and whether that is intended.

1. **The built-in types Explore and Plan. Intended.**
   - By the subagents page they skip CLAUDE.md (fact D9), and CLAUDE.md binds every subagent here.
   - Plan line 679 and Ek D §5 already keep built-in helpers that do not load CLAUDE.md out of role work. T4 is stricter, because it denies the type itself.
   - The guard's comment states this (guard:115-118). No role file and no executor call names a built-in type (CHK-C01-091 finding 3).
2. **The `fork` type. Not intended by the change, which does not name it; kept as safe.**
   - A fork is requested through the Agent tool (fact D9), and T4 denies it as an unnamed type.
   - A fork carries its parent's context, so it cannot be a fresh-context checker (PC-06).
   - The executor's 65 Agent calls name only its roles, so none is a fork (CHK-C01-091 finding 3).
3. **Bundled skills and built-in commands reached through the Skill tool (for example `init`), and skills synced from claude.ai. Intended.**
   - PC-35 option (B) foresaw it: "Over-blocking a built-in skill a session needs (none is named now; a checked change would name it)".
   - A skill synced from the account is not reviewed for DevOS, which is the reason T4 gives (guard:212-215).
   - Their descriptions still stand in the session's skill listing, since cloud sessions load skills enabled on claude.ai (fact D8). Only their loading through the Skill tool is denied.
   - It shows to the executor only in T4's denial detail. The executor's transcript has no Skill call (CHK-C01-091 finding 2).
4. **A repository skill called by any name other than its exact directory name. Not intended as such; accepted.** That includes a leading `/`, a front-matter name that differs, and an alias or display name (facts D10).
   - Exact matching fails closed.
   - It has no effect today: the one repository skill's name equals its directory name (item 1).
   - A future skill whose front-matter name differs from its directory would be denied under that name until it is renamed.
5. **Workflow text. Not intended for prose; accepted, because it fails closed.** This is any text in a workflow script that the rule reads as an agent-type word but that is not the option's key followed by one quoted name and `,` or `}`.
   - The rule matches the camel-case key and its snake-case form anywhere in the script, case-insensitively. That includes the Agent tool's field name, which contains the snake-case form (guard:120).
   - **What gets denied:**
     - prompt prose that names the option or the field;
     - a prompt that quotes W-C01-45's acceptance block, which writes the option twice (CHK-C01-092 finding 6, probed);
     - 4 of the executor's 21 saved scripts (CHK-C01-091 finding 5).
   - **What still passes:** prose that writes "agent type" or "agent-type".
   - **Why it is accepted.** At text level the guard cannot tell prose from code. T4's "what to do instead" names the rewrite ("do not write the word elsewhere in the script"). So the cost is one denied call, not a lock-out.
   - **The executor's practice from L-238.** Workflow prompts do not use those words in prose. A checker prompt points at the block's file instead of quoting it.
   - This record avoids the words for the same reason.

- **Where the executor sees these items.** Today: this record, the guard's comment (item 1) and T4's denial text (items 3 and 5).
- **The working order.** Section 10's "Known over-blocking" (WO:159) does not list them yet (CHK-C01-091 finding 5; CHK-C01-092 finding 4). That file is class high and is not changed by this record (see "Open").

## Additions beyond W-C01-45 (CHK-C01-092 finding 9)

The change also carries two things that neither W-C01-45 nor PC-35 asks for:
- **The escape fix.** guard:1044 now reads `"\\;"` instead of `"\;"`.
  - The value is unchanged.
  - It removes the `SyntaxWarning` that every earlier run printed (EV-C01-017). Under warnings-as-errors, that warning would have made the guard fail closed on every call (CHK-C01-085 finding 6; CHK-C01-091 finding 6).
  - This producer's run at `f607b0b` has empty standard error.
- **The controls at test:1020-1024 and :1100-1114** (CHK-C01-092 finding 9 counts four of them).
  - Two lines check the guard under warnings treated as errors: it compiles, and a Read is allowed.
  - Twelve lines check both wrappers. A valid answer alone passes; a stray line before it, or a newline only, is blocked or denied. That is three cases on both events, under both shells (CHK-C01-091 finding 1).
  - They come from CHK-C01-085 findings 4 and 6, which L-233 took to this change (EV-C01-017, B4).

## What this record cannot show

- **The fresh-session case** (4.5): whether the repository's `enabledPlugins` entry keeps ECC out of a session that starts after the merge, and whether its skills and agent types leave the listing.
- **The platform's side.** The test runs the guard as a plain process. That the platform honours the key, applies the switch, and runs the hooks and acts on their answers rests on the documentation and on 4.5, not on the test.
- **The cause of the inertness** (4.5): an inference, not shown. Also unread: whether every ECC hook goes through `isHookEnabled`.
- **T4's text-level gaps** (CHK-C01-091 finding 4). These let through a computed key, a bracket assignment, a key with a unicode escape, `Object.fromEntries`, `JSON.parse` with escapes, and options passed through the call's `args`, which the guard never reads.
  - All but the `args` route need a deliberate construction.
  - T3 has the same class of gap.
  - This is under-blocking, outside the block's literal scope (the script text and the `scriptPath` file).
- **Names T4 cannot tell apart:**
  - A skill of the same name at another level (CHK-C01-091 finding 2). The check of the user-level folder was not made (denial #9689).
  - A synced plugin that defines an agent with a bare name equal to an admitted built-in (CHK-C01-092 finding 10). W-C01-46's per-plugin count of agent definitions can check the names.
- **Hooks the count does not see.** A hook from the organization's server-managed settings is not in the user-level folder and is not counted (PC-35 option (D)).
- **The decision log.** It is self-reported and lives in the container (WO:150). The independent record is the session's transcript on the platform.

## Result

| Block item | Result | Where |
|---|---|---|
| 1. T4 for Skill, Agent and Workflow, with planted negatives and counterparts; all guard and merge-gate tests pass, counts recorded | met: 817 `ok`, 0 `BAD` at `4daf915` (both checkers); 814 `ok`, 0 `BAD`, 3 skipped at `f607b0b`; `MERGE_GATE_TEST PASS (24/24)` | Item 1 |
| 2. ECC off through `enabledPlugins` and its own switch in `env`; PC-21 item 9's claim; the file valid, both guard hooks as they were | met | Item 2; Documentation facts |
| 3. Working order sections 3, 9 and 10 | met | Item 3 |
| 4. The guard report after the sync, with an allowed role Agent call and an allowed Workflow call | met: #9878 (Agent, producer, allow, T2) and #9772 (Workflow, allow, T3) | 4.2 to 4.4 |
| 4. PC-35 "Routing" item 2's observation | recorded for the running session: Inert (not Out), its code still starting; the fresh-start case is owed on reading (A), at the first start after the merge or as "not made" before C01's stage close; on reading (B), met. The checker judges | 4.5 |
| PC-35 "Routing" item 4's trigger | does not fire now; it would fire now only if the running session is read as a session it names | 4.6 |
| Last paragraph: evidence envelope | met | Envelope |
| Last paragraph: a fresh-context checker at a fixed head, with its independence level | to come | |
| CHK-C01-092 C1 | met: D1 to D10 in PC-21 item 9's form, each with page, URL and reading date; qualifiers (a) to (d) and PC-21's own | Documentation facts |
| CHK-C01-092 C2 | met: items (1) to (5), each said intended or not | Over-blocking |

- **Not accepted here.** W-C01-45 is not accepted by this record. A fresh-context checker judges it against the unchanged block and PC-35 at a fixed head.
- **No plan change and nothing for Batu.** No change to `plan/DevOS_Kurulum_Plani.md` follows. No decision is Batu's now: the account question goes to him only on "Routing" item 4's trigger (4.6).
