# EV-C01-021 · W-C01-20: row 13, plugin and skill inventory (P2 and P3, 2026-10-11)

**What this is.** The record W-C01-20 asks for: plan C01 row 13, taken from two runs of the C01 routine, P2 and P3, and from the skill and plugin inventories that the earlier runs R1a, R1b and P1 recorded in their opening records, item by item against W-C01-20's acceptance block. P3 ran twice: its first attempt closed `not started` before task K, and its second attempt is P3's row 13 try (section "CHK-C01-073 C2"). Run records are cited as `<file>:<line>` under `evidence/C01/routine/runs/<run>/<step>/`. The copies were made on 2026-10-11 from the branches below, in the layout of the R1a, R1b and P1 copies: the files under `c01-run/` on each branch, unchanged.

| Copy | Branch | Head | Files |
|---|---|---|---|
| `runs/P2-20261011T1354Z/P2/` | `claude/probe-c01-p2-20261011T1354Z` | `be9bac74d8f30e7c0210ea974cad931572eee55d` | STAMP, OPENING, K, ROW13, K2, CLOSING |
| `runs/P3-20261011T1420Z/P3/` | `claude/probe-c01-p3-20261011T1420Z` | `38733f3b46c88aa86466e6954581f434b4d39dcb` | STAMP, OPENING, CLOSING |
| `runs/P3-20261011T1448Z/P3/` | `claude/probe-c01-p3-20261011T1448Z` | `e971713ba0c53c76058d5724b7e56699d261bf06` | STAMP, OPENING, K, ROW13, K2, CLOSING |

Each of the 15 files was compared with `cmp` against `git show <head>:c01-run/<step>/<file>` and is byte-identical. Each branch adds nothing else to the `main` commit it started from (`git diff --name-status <merge base> <head>` lists only these files, all added).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | **P2** read `main` `aeb5fd0a9d86597256da45ef6ad7a6a903a9f1eb` (STAMP.md:11) with `CONTROL.md` version 7 (STAMP.md:12; blob `3feb839`). **P3, first attempt,** read `528d9e2dc0502c9a65324fdddc3ac8612801d1df` with version 8 (blob `43120ba`). **P3, second attempt,** read `aabb9c977949e89118bdce54f479dfa548161261` with version 9 (STAMP.md:11-12; blob `d9f3795`). Each branch's merge base with `main` is the commit its stamp names. At all three commits `AFTER_K.md` is blob `59214f1` (its version 2), the probe skill `.claude/skills/synthetic-word-tally/SKILL.md` is `3e89b09`, `CLAUDE.md` is `5884a32` and `plan/Ek_D_Dusunme_Protokolleri.md` is `e4456ce`. Versions 7 to 9 differ only in five lines (section "CHK-C01-054 C4"); P2 and P3 item 1, part B (3.3), task K (6.5) and `AFTER_K.md` are the same text for both runs. This record is written at `main` `daa7c34`, where those five files have the same blobs as at `aabb9c9` |
| Deployment configuration | **Routine:** `devos-c01-rutin` (ROUTINE_DESIGN.md section 1). The run records do not name it; each session saw a scheduled-task framing of a stored prompt (STAMP.md:9 in all three). **Environment:** `devos-kurulum`, from `DEVOS_ENVIRONMENT` read by name: `match` in P2 and in P3's second attempt (OPENING.md:8 in each); not read in P3's first attempt, whose read was denied (OPENING.md:6). **Repositories:** the starting checkout's remote is `batuhanozgun/devos`, with 0 other git checkouts (OPENING.md:9 in each; P3's second attempt adds that the session's GitHub scope names only that repository). **Connectors:** none. The MCP servers are the platform's own: `github` (54 tools, deferred), `claude-code-remote` (3) and `ccd_session` (2), with no `other-server-*` (P2 OPENING.md:14; P3 OPENING.md:14-15). **Claude Code version:** `2.1.296`, from the `"version"` field of each session's own transcript records (OPENING.md:10 in each). **Sessions:** P2 `01UozfgezhSzzBoSBJ2RL4r6`, from its decision-log file name under rule 1.2 (STAMP.md:5); P3's first attempt `01NQAPxB23e6jxxA7q22i7v7`, the same way; P3's second attempt `cse_01DQTqGV1bRoa7HFeBxiLqDJ`, read with version 9's command (STAMP.md:5), with decision log `session_01DQTqGV1bRoa7HFeBxiLqDJ.jsonl` (OPENING.md:7). **Model:** Opus 5.5, as each session's context names it (OPENING.md:10); the routine's configured model is the one D-008 sets. **Mode and effort:** auto mode, as the session's instructions say; effort `xhigh`, as the guard counts the harness's field; ultracode not shown. **Hooks:** the repository's, as at the commit read, with the guard live (decision log present, hash chain intact; OPENING.md:7). **Start:** Batu's Run now presses under D-027 (a). P2's S is 13:54:20Z (his words in the working session, L-211; issue #6, comment `6109755510` at 13:54:43Z). P3's first S is 14:20:42Z (after "P3 hazır", comment `6109965514`; L-218). P3's second S is 14:48:43Z (after "P3 tekrar hazır"; L-221). None matches the schedule time, 08:07Z |
| Criterion version | W-C01-20's acceptance block at `daa7c34` (`plan/work/W-C01-20.md`, blob `4ce52dc`, the same at `aeb5fd0` and `aabb9c9`). The block's text is unchanged since `62f9e46` (2026-10-06), before any run: its checksum is the same at `62f9e46`, `44cef4e`, `3a652ac` and `daa7c34`. It is read with plan C01 row 13 (plan line 956), the paragraph after the probe setup (line 940), the PC-21 note items 1, 2 and 9 (lines 964, 965, 972), plan 5.9 (line 587), Section 8 items 9, 13 and 14 (lines 837, 841, 842), Section 12 item 6 (line 1226) and Section 14. The number of tries, and what success and failure mean for them, are in `ROUTINE_DESIGN.md` section 7, "Row 13" (line 115 at `daa7c34`). That paragraph was written in `f8a1531` (2026-10-10T22:59:58Z), an ancestor of every commit the runs read; its dated notes (lines 117-121) came with `CONTROL.md` versions 4 and 5 |
| Input | The stored prompt (ROUTINE_DESIGN.md section 3). `CONTROL.md`'s P2 and P3 text (lines 119-123) and task K (6.5, line 180): "Tally the synthetic word list W1: lark, wren, lark, finch, wren, lark. Write the tally to `c01-run/<step>/K.md`." `AFTER_K.md` version 2, with task K2 in its item 3: "Tally the synthetic word list W2: oak, elm, oak. Write the tally to `c01-run/<step>/K2.md`." The probe skill (blob `3e89b09`): description "Use when asked to tally a synthetic word list.", marker `probe-skill: ran`. All are synthetic and labelled so (plan Section 8 item 13): `CONTROL.md` section 6's heading, `AFTER_K.md`:3, and SKILL.md:6 ("SYNTHETIC test skill (plan Section 8 item 13)"). Text with the start: none in P2 or in P3's first attempt; "yes (content not recorded)" in P3's second attempt (STAMP.md:10; Assumption 3) |
| Actual observation | The runs' own records, as copied, and R1a's, R1b's and P1's part B (their copies under `runs/`). Also the producer's direct reads of git: the commits on each branch, their order and dates; branch bases; blobs; the commit subjects on `main`; the diff between the two `main` commits; rule 2.2's count on each branch; and a re-run of the service-name pattern on every probe branch |
| Raw evidence ID | The branches and heads in the table above. Commits: P2 `dd1ad25` stamp, `b2a143d` part A, `0d8c5b7` `K.md`, `9ca093d` `ROW13.md` item 1, `bf9c33d` part B, `bbeab41` `K2.md` and `ROW13.md` items 3-4, `be9bac7` closing record. P3's first attempt `c3edcd6` stamp, `5040c4d` part A, `38733f3` closing record. P3's second attempt `be100b5` stamp, `68d8ae1` stamp attempt line and part A, `b95be68` `K.md`, `6c0b8d5` `ROW13.md` item 1, `8013c78` part B, `e73da75` `K2.md` and `ROW13.md` items 3-4, `e971713` closing record. The copies' blobs, the same as on the branches: P2 STAMP `3fe9bd5`, OPENING `a7253a7`, K `fd47fd5`, ROW13 `44f5401`, K2 `cd53aee`, CLOSING `7fa229d`; P3's first attempt STAMP `0a54a7a`, OPENING `c777eec`, CLOSING `a42543a`; P3's second attempt STAMP `939ca23`, OPENING `cb6112d`, K `fd47fd5`, ROW13 `d5db191`, K2 `cd53aee`, CLOSING `3dec53c` |
| Independence level | What each run records of its own session is self-observation (D-017 item 2(a); the same session's own test, Section 8 item 7), dated 2026-10-11: its lists, its account of why it invoked the skill, its times. `K.md` and `K2.md` carry the skill's marker, which only the skill's text gives; that is the one observation of the tries that does not rest on the run's own account. The producer is a fresh-context producer subagent of the executor's working session. It shares the design and the criterion with the runs' designer, read from git, and did not invoke the probe skill. A fresh-context checker judges this record (declared, Ek A 5.3) |

## How the criterion is read

- **Which note governs.** PC-21's note governs where it and the row differ (plan line 963). Its item 2 lists row 13: "Unchanged in substance; 'P2' reads as the routine of item 1." So "the probe session" reads as the routine's sessions. For the list, every working run lists what its session has (part B); P2 and P3 make the tries.
- **Two meanings of P2 and P3.** Here they are the routine's steps (`CONTROL.md` table 4: P2 "Row 13, first run (W-C01-20)", P3 "Row 13, second run"). They are not the plan's probe-setup items P2 and P3, which PC-21 item 1 reduces or does not build.
- **"As many times as W-C01-03's design fixes."** W-C01-03 is cancelled and replaced by W-C01-32 (`plan/work/W-C01-03.md`, "Cancelled"; `plan/work/W-C01-32.md`: "Replaces W-C01-03 under PC-21 item 1"). W-C01-32's design (ROUTINE_DESIGN.md:115) fixes the tries, its success and its failure:

  > Tries, fixed here: two of each kind, one per run in P2 and P3; in each run the unprompted try (task K, worded to match the probe skill's description, without naming it) comes before anything else in the step, then the named try (task K2). Success: everything loaded is listed under rule 1.4; whether account-level plugins and skills reach a routine session (items marked `other`); the probe skill is listed, and triggers the same way in both tries of each kind (unprompted: invoked both times or neither; named: invoked both times). Failure: a conflicting plugin or connector is found, or the probe skill does not load, or triggers differently between the two tries of a kind, or not when named.

  Its section 11 disposes of W-C01-20's wording the same way: "read as the two tries of each kind in P2 and P3 of this routine."
- **"Reliably."** The block fixes it before the observation: repository skills do not trigger reliably when "the probe skill does not trigger the same way in every try that W-C01-03's design fixes".
- **"Unprompted" and "named".** Unprompted is task K: worded to match the skill's description, without naming it, with nothing the run reads before it naming the skill, its marker or task K2 (ROUTINE_DESIGN.md:117-118). Named is task K2, given in `AFTER_K.md` after `K.md` is pushed.
- **"Could not check."** Plan Section 8 item 14 and the block: a part that could not be observed is never met. It is handled as a failed part, or moved to the stage where its components exist when they cannot be stood in for.
- **The disposition.** This reading is the disposition that W-C01-20's re-plan flag asks for when the item starts (CHK-C01-051 finding 12; CHK-C01-052 finding 13); the executor records it.

## Item 1. The probe skill: synthetic, added by a change merged through the merge gate with a fresh-context checker verdict at its head, before its probe runs

Met.

- **The skill.** `.claude/skills/synthetic-word-tally/SKILL.md`, added in `3a652ac` (2026-10-11T12:08:56Z) with `CONTROL.md` version 4 and `AFTER_K.md` (L-204). It is labelled synthetic: "SYNTHETIC test skill (plan Section 8 item 13): the probe skill of DevOS C01 row 13, added by W-C01-20 and removed by W-C01-29. It holds no real data and does nothing but the tally below." (SKILL.md:6).
- **Verdicts at its head.** CHK-C01-051 (design fidelity) and CHK-C01-052 (the runs walked through) both name `reviewed_head: 3a652acedccc49d874fbb17583b4427006cde273`, with verdict PASS-WITH-CONDITIONS, `independence: "same session, fresh-context subagent (declared, Ek A 5.3)"` and a `checker_run`.
- **Through the merge gate.** Pull request #223 merged as `9bd17a3` (2026-10-11T12:27:22Z), with parents `f957519` and `1ac2053`. `.claude/**` is class high (`tools/merge_gate.py`, docstring). On top of `3a652ac`, `1ac2053` adds only the two verdict files, the log entry and generated files (`git diff --stat 3a652ac 1ac2053`: `evidence/C01/checks/CHK-C01-051.md`, `CHK-C01-052.md`, `plan/ledger/C01-log.md`, `plan/ledger.md`, `DURUM.md`), all class normal, and the pull request adds the verdict files. So the gate's rule holds by form, as checked here from git: a verdict whose `reviewed_head` is a commit X of the pull request, with X..head class normal. Assumption: the gate ran and passed at this merge. The guard runs it before every merge (rule M7; `plan/Installation_Working_Order.md` section 4 step 5); its decision record was not read for this record.
- **Before its probe.** `9bd17a3` is an ancestor of `aeb5fd0` and of `aabb9c9` (`git merge-base --is-ancestor`), so the commit graph orders the skill before P2 and P3. By the clocks it merged 1 h 27 min before P2's S. The skill's blob is `3e89b09` at every commit the runs read (pinned by CHK-C01-052 C2, CHK-C01-067 and -068 C2, CHK-C01-072 C2 and CHK-C01-073 C1).
- **The skill matches task K and task K2.** CHK-C01-051 finding 7 checked it ("I checked it": both tasks match the description, and the marker is in the skill) and noted that L-204 does not record the executor's own match check; CHK-C01-052 finding 12 found the same match.

## Item 2. The evidence envelope

Met: the table above. Its deployment configuration names the probe environment (`devos-kurulum`, read as `match`), the routine (`devos-c01-rutin`, from the design; the sessions do not name it), the repository attached (`batuhanozgun/devos` only) and the Claude Code version (`2.1.296`, from the sessions' own transcripts). Its raw evidence is the probe sessions' own records on their `claude/probe-c01-…` branches.

## Item 3. Every plugin, skill, subagent and hook loaded into the probe session, listed without naming a service connected to Batu's account

Partly met. Every working run lists the agent types, the skills, the plugins as far as names show them and the MCP servers, and none names a service. The hooks are listed only from the repository's settings: whether a hook from another source was loaded could not be checked.

| Run (`main` commit read) | Agent types (repository / built-in / other) | Skills (repository / built-in / other) | Plugins, as names show them | MCP servers | Hooks listed | Hook output at start | Where |
|---|---|---|---|---|---|---|---|
| R1a (`5d0cc58`) | 5 / 6 / 0 | 0 / 17 / 24 | `other-plugin-1` (24 skills) | the platform's own only | the four of `.claude/settings.json` | none | OPENING.md:24, 26, 32-41 |
| R1b (`fdaf4e5`) | 5 / 6 / 0 | 0 / 17 / 24 | the same | the same | the same four | none | OPENING.md:24, 26, 32-41 |
| P1 (`63e166c`) | 5 / 6 / 0 | 1 / 17 / 24 | the same | the same | the same four | none | OPENING.md:20-27, 32-40 |
| P2 (`aeb5fd0`) | 5 / 6 / 0 | 1 / 17 / 24 (stated total 42) | the same | the same | the same four | none | OPENING.md:14, 16, 22-28 |
| P3, second attempt (`aabb9c9`) | 5 / 6 / 0 | 1 / 17 / 24 (stated total 43) | the same | the same | the same four | none | OPENING.md:14-15, 17, 23-32 |

- **Subagents (agent types).** Eleven in each run: the five of `.claude/agents/` (checker, counter-designer, prober, producer, researcher), marked `repository`, and six built-in (claude, claude-code-guide, Explore, general-purpose, Plan, statusline-setup). None is marked `other`.
- **Skills.** The same 17 built-in names in each run; the repository's probe skill from P1 on (it merged before P1); and 24 skills under one plugin prefix in every run. P2 writes them as `other-skill-1` to `other-skill-24` (OPENING.md:26). P2's stated total, 42, is the sum of its list. P3's second attempt states 43 skills (OPENING.md:27) but lists 1 + 17 + 24 = 42 (OPENING.md:28-30). Assumption 4 treats the difference.
- **Plugins.** One, `other-plugin-1`, "as far as names show them": the shared prefix of the 24 `other` skills. The runs did not call `ListPlugins`, which the guard's allow list does not include (`ALLOWED_NON_MCP`, `.claude/hooks/tool_allowlist.py`:95-103). So a plugin that brings no skill, agent type or MCP server would not appear in any list. P3's second attempt adds: "The user-level skills and plugins folders each also hold one entry named `synced`, not opened." (OPENING.md:31).
- **MCP servers.** Only the platform's own (`github`, `claude-code-remote`, `ccd_session`), with no `other-server-*`; this is row 2's matter (W-C01-34, accepted). `other-plugin-1` brought no MCP server and no agent type into any of the routine's sessions.
- **Hooks.** Every run lists the four hooks of the repository's `.claude/settings.json` at the commit it read, as part B item 3 asks (`CONTROL.md` 3.3): `PreToolUse` `.*` and `PermissionRequest` `.*` (the guard), `PostToolUse` on `create_session|create_trigger`, and `SessionStart` `compact`. Each records that no hook output reached the session at its start (part A item 7). No run lists hooks from any other source, and part B does not ask for them. The documentation read for row 9 names one other hook source in an Anthropic-hosted environment: "Claude Code runs hooks from the repository and from your organization's server-managed settings"; user and local settings files are not read (EV-C01-016, "Facts taken from the documentation", read 2026-10-11). As quoted there, it does not say whether a plugin synced from the account brings hooks. A hook from another source that printed nothing at the start would show in no record. So "every hook loaded into the probe session" could not be checked beyond the repository's four (plan Section 8 item 14).
- **No service named; the service-name check passes on every probe branch.** Every run counts the plugin and its skills under rule 1.4 instead of naming them; P1 and P3 give the reason: "because some of its skill names name outside services" (P1 OPENING.md:39), "since several of its skill names name outside services" (P3 OPENING.md:30). The guard's leak check, rule L1, which carries the service-name check, allowed every push that P2 and P3's second attempt recorded (P2 CLOSING.md:15-27; P3 CLOSING.md:8-15). The closing record's own push is not in either record, but its commit is on the branch. Assumption: the guard checks a push before it is made, so a push it denied would not be on the remote. Re-checked for this record: the pattern that `tools/check_service_names.sh` derives (12 terms from `3cd686a`, never printed) was run with `git grep -i -E` on `c01-run/` of all six probe branches (R1a, R1b, P1, P2 and both P3 branches), with 0 lines on each, and on the 15 copies, with 0 lines. Positive control: the same pattern matched 12 of 12 lines of a scratch file that held each term in a sentence (deleted afterwards). The tool's own limits hold: the terms are a snapshot of the account's connectors at `3cd686a`, and generic words are left out.

## Item 4. Whether plugins and skills enabled at account level, marketplace skills included, reach a session started by a routine; plan 5.9's mark

Answered for what reached: an account-level plugin's skills reach every session the routine started. Could not check: whether any other plugin or skill is enabled at account level and did not reach, the marketplace and partner skills that N-005 names in particular.

- **Observed.** In all five working runs (R1a at 08:08Z, R1b at 09:13Z, P1 at 13:37Z, P2 at 13:54Z and P3 at 14:48Z, 2026-10-11), the session offered 24 skills under one plugin prefix, `other-plugin-1`. Neither the repository (`.claude/skills/` holds one entry, the probe skill: P2 ROW13.md:31; P3 ROW13.md:28) nor the built-in set provides them. No agent type and no MCP server came with them (Item 3).
- **Assumption: `other-plugin-1` is enabled at account level.** It is not in the repository, its prefix is one the built-in skills do not carry, and it appears in sessions on freshly booted machines (a different boot ID in each run) whose user-level plugins folder holds an entry named `synced` (P3 OPENING.md:31). The documentation read for the design says "skills enabled on claude.ai load in cloud sessions" (ROUTINE_DESIGN.md F10). Removing every connector when the routine was created did not remove it.
- **Assumption: it is a marketplace plugin**, since plugins are installed from a marketplace. The runs do not show its source.
- **The mark.** Plan 5.9 (line 587) reads: "**[Awaiting verification: C01 #13. A probe in C00 saw account plugins and marketplace skills not reach a cloud session, as the current documentation says (note N-005 on `plan/work/W-C00-07.md`)]**". For sessions started by a routine, the observation contradicts "account plugins … not reach": one account-level plugin's skills reach every such session. N-005's probe saw a builder-created session only (the block's own words). What the runs cannot show is which plugins and skills the account has enabled: one that is enabled and did not reach would appear in no list, and whether the marketplace and partner skills N-005 names are still enabled is not known here. The mark's text changes only through plan Section 14 (N-186 on `plan/work/C01.md`).

## Item 5. Whether the probe skill loads in a session started by a routine, and how it triggers

Met. It loads, and it triggers the same way in every try the design fixes: unprompted from its description in both tries (task K in P2 and in P3), and when named in both tries (task K2).

| Run | Listed in part B | Task K (unprompted): invoked? | `K.md`, first tally line | Task K2 (named): invoked? | `K2.md`, first tally line |
|---|---|---|---|---|---|
| P2 | yes, marked `repository`, with the description "Use when asked to tally a synthetic word list." (OPENING.md:24; ROW13.md:46-47) | yes, through the Skill tool, "because its listed description ("Use when asked to tally a synthetic word list.") matched the task; it was not named to the run by any file" (ROW13.md:10) | `probe-skill: ran` (K.md:3) | yes, by its name, through the Skill tool; "The tool marked it a re-invocation" (ROW13.md:32) | `probe-skill: ran` (K2.md:3) |
| P3, second attempt | yes, marked `repository` (OPENING.md:28; ROW13.md:42-43) | yes, through the Skill tool: "The session's skill list offered it with a description that matched task K …, and the run invoked it through the Skill tool, with the word list as its argument, as it would for any ordinary task that a listed skill covers." (ROW13.md:9) | `probe-skill: ran` (K.md:3) | yes, by its name, through the Skill tool; "The launch was marked a re-invocation" (ROW13.md:29) | `probe-skill: ran` (K2.md:3) |

- **Judged as the design defines it** (ROUTINE_DESIGN.md:115, quoted above). Listed: yes in both runs, and in P1, which made no try. Unprompted: invoked both times. Named: invoked both times. So the design's success holds for the probe skill, and none of its failures for the skill does ("does not load, or triggers differently between the two tries of a kind, or not when named").
- **How it triggers.** "Unprompted from their description", the row's first alternative. Since it triggered unprompted, "only when named" does not describe it; it also ran when named.
- **The marker as evidence.** `K.md` and `K2.md` each begin the tally with `probe-skill: ran`, after rule 1.7's line, in both runs. Nothing a run may read before task K names that marker (ROUTINE_DESIGN.md:117), and neither run reports a read that could give it. So the marker shows that the skill's text was loaded during task K, apart from each run's account of why.
- **What reached each run before `K.md` was pushed** (`AFTER_K.md` item 1; the tests of rules 2.2 and 2.6 and `tools/guard_report.py` aside):
  - P2: `plan/Ek_D_Dusunme_Protokolleri.md` (one Grep and one Read of its section 3, which P2 and P3 item 1 allow), the skill's text through the Skill tool, `CLAUDE.md` in the session's context from its start, and git commands that read no file content (ROW13.md:11-16). Appendix D names nothing of the probe (CHK-C01-053 finding 5; blob `e4456ce` at both commits).
  - P3: the skill's text through the Skill tool, `CLAUDE.md` in the session's context, and git metadata, among it "the one-line subjects of the last three commits on `HEAD` and on the local `main`" (ROW13.md:10-14). It did not read Appendix D before task K.
  - In both runs part A came before task K (P2: `b2a143d`, then `0d8c5b7`; P3: `68d8ae1`, then `b95be68`). P2's own D1 asks whether that order is right (CLOSING.md:34). It is the order the control file gives: part A and its gates decide whether the step starts at all (3.2: "A step not started stays open"); task K is "the step's first item, before part B and before anything else in the step" (P2 and P3 item 1, line 121); and part A lists tools, not skills.
- **Times** (commit times, the sessions' own clocks). P2's task K ran from 13:56:18Z to 13:56:40Z (22 s); P3's from 14:50:47Z to 14:51:02Z (15 s).
- **The tallies, as the runs wrote them** (synthetic values): W1 gives lark 3, wren 2, finch 1; W2 gives oak 2, elm 1. They are the same in both runs and correct for the lists given.
- **Consistent with the earlier observation** in a builder-created session: a repository skill loaded and ran when named, once, on 3 October 2026 (L-037; plan row 13).
- **Limits**, kept apart: why each run invoked the skill is its own report (Assumption 1); both named tries were re-invocations in a session that had already loaded the skill in task K (Assumption 2); and P3's second start carried text whose content is not recorded (Assumption 3).

## Item 6. T-13's C01 part answered, and the evidence ID given to C05 by a dated line on N-077

Met.

- **T-13** (`evidence/C00/EV-C00-013_findings_register.md`, row T-13; N-073 on `plan/work/C01.md`; N-077 on `plan/work/C05.md`): "Compare Claude Code skills with plain files and agent definitions as the package format of DevOS's methods. First probe whether repository skills load in cloud sessions and how reliably they trigger." C01's answer, for sessions started by a routine: a skill in the repository's `.claude/skills/` loads (listed in P1, P2 and P3) and triggers unprompted from its description, and when named, the same way in each of the two tries of each kind that the design fixes (Item 5).
- **The dated line.** N-077 in `plan/work/C05.md` now carries a line dated 2026-10-11 that gives C05 this record's ID, EV-C01-021, with the two facts its per-method decision needs from it: a skill triggers from its description without being named; and an account-level plugin's skills sit beside the repository's in the same listing, invoked through the same Skill tool (Item 4; N-187).

## The fail path

The block fixes, before the observation, the results that apply the fail path even when every part is observed and recorded: (a) "a conflicting plugin or connector is found"; (b) "repository skills do not load in a session started by a routine, or do not trigger reliably".

- **(b) does not apply.** The probe skill loads and triggers the same way in every try (Item 5). So this row does not take the branch "methods stay in plain files; C05 decides per method". C05 still decides per method (N-077).
- **(a) could not be checked; it is handled as a failed part.**
  - The session's list holds one plugin that the repository does not provide, `other-plugin-1`, with 24 skills. Whether it "conflicts with DevOS's rules, 5.9; for example one that brings tools, hooks or instructions that the guard or `CLAUDE.md` does not allow" depends on what it brings. In the routine's sessions it brought no MCP server and no agent type (Item 3). It brings 24 skills, several of whose names name outside services (P1 OPENING.md:39; P3 OPENING.md:30). Their text, which is instructions by design, was not read and is in no record. Whether it brings hooks was not observable (Item 3, "Hooks").
  - `CLAUDE.md` says: "Never use account connectors (mail, calendar, files and similar)". The guard allows the Skill tool for every skill, the repository's and the plugin's alike, by name, with no check of which skill (`ALLOWED_NON_MCP`, `.claude/hooks/tool_allowlist.py`:95-103; CHK-C01-051 finding 11). Item 5 shows that a skill whose description matches a task is invoked unprompted. So the plugin's skill texts can enter a DevOS session as instructions without passing DevOS's merge gate. Whether any of them instructs something the guard or `CLAUDE.md` does not allow is not shown.
  - Plan Section 8 item 14 keeps "could not check" apart from "clean", and the block handles it as a failed part. Read so, the fail path's first branch applies: "To a decision; if needed, turning them off at account level."
  - **Seen by the producer, not by a run** (kept apart). The producer is a subagent of the executor's working session, which keeps the account's connectors; the routine has them removed. The producer's own context carries instructions from four MCP servers under one plugin prefix, each named for an outside service (counted, not named). Assumption: this is the plugin the runs count as `other-plugin-1`; the runs did not write its prefix, so the two cannot be compared. If it is, then in a session that keeps the account's connectors the plugin brings MCP tools that the guard's rule M1 denies (`ALLOWED_PREFIXES`, `.claude/hooks/tool_allowlist.py`:86-91). That is the block's own example of a conflict ("one that brings tools … that the guard … does not allow"), so the conflict would be found, not only unchecked. Either way the first branch applies.
  - The only reading under which (a) does not apply counts the unread skill texts and the unobserved hooks as clean, which plan Section 8 item 14 rules out.
- **The success condition is not met either.** "It counts as met only when every part of it is observed and recorded", and two parts could not be checked: hooks from sources other than the repository (Item 3) and account-level items that did not reach (Item 4). Their components exist now, in the routine's sessions, so neither moves to a later stage under the paragraph after the probe setup (plan line 940); both are handled as failed parts. The block: "If the success condition is not met, a plan-change decision is taken and recorded that applies the fail path above."
- **The plan-change record this requires** (the block: "a plan-change record `plan/decisions/PC-<nn>.md` (plan Section 14; working order section 6) and, where the fail path sends a choice to a decision that is Batu's (working order section 8), its decision record as well"). It is the executor's to write, not this record's. It records row 13's result as this record gives it (the old and new plan text, the rationale and the affected stages: plan 5.9's mark, N-186; C03 and C05 by N-187 and N-077). It applies the first branch: a decision on `other-plugin-1` and on the two parts that could not be checked. If turning the plugin off at account level is needed, that is Batu's step, with its effect on his other chats written out in advance (plan Section 12 item 6; `plan/work/C01.md`, Batu's steps, the row "Only if row 2 or row 13 finds a conflicting plugin or connector"), and the choice goes to him as a decision record in the Appendix E format (working order section 8). It does not apply the second branch. Options it may weigh, not chosen here: turning the plugin off at account level (Batu's step); keeping it, with the residual stated (its MCP tools denied by rule M1 where they appear; its skill texts open to the Skill tool); or first observing more, in a new checked step that records, counted and not named, what the plugin brings (its hook entries and its skills' descriptions); rule 2.7 repeats a closed step only when a checked change adds it again under a new ID.

## Conditions this record carries

### CHK-C01-051 C1 and CHK-C01-052 C5: the commit subjects at the `main` commit each run read

Met. Run in the producer's scratch clone:

```
$ git log --oneline -5 aeb5fd0a9d86597256da45ef6ad7a6a903a9f1eb      # P2
aeb5fd0 Merge pull request #227: C01 control file version 7 and P1's close (L-209, L-210)
853c82a C01: P1 closed; D-022 answered; version 7 verdict filed; D-027 opened (L-210)
835878d C01: control file version 7 (P1 and a denied call) (L-209)
63e166c Merge pull request #226: C01 control file version 6 (L-207)
d44dbe4 C01: control file version 6 checked (L-207)

$ git log --oneline -5 528d9e2dc0502c9a65324fdddc3ac8612801d1df      # P3, first attempt
528d9e2 Merge pull request #229: C01 control file version 8 (L-214, L-217)
2008263 Merge main into the control file version 8 branch; version 8 checked (L-217)
561c3b3 C01: control file version 8 checked; verdicts filed (L-214)
9378591 Merge pull request #228: C01 row 6 accepted (L-211, L-215)
228be19 C01: row 6 accepted on its check (W-C01-13; PC-33; L-215)

$ git log --oneline -5 aabb9c977949e89118bdce54f479dfa548161261      # P3, second attempt
aabb9c9 Merge pull request #231: C01 control file version 9 (L-218, L-221)
3aeae32 Merge main into the control file version 9 branch; version 9 checked (L-221)
47a8e01 Merge pull request #230: C01 seven record items accepted (L-208, L-220)
afea8f2 Merge remote-tracking branch 'origin/main' into claude/c01-w15-row8
4888d36 C01: seven record items accepted (L-220)
```

- No subject names the skill (`synthetic-word-tally`), its marker (`probe-skill: ran`), "probe skill", task K2 or a row 13 result; nor does any merged branch name in them (`claude/c01-w15-row8`). A case-insensitive search of the subjects and bodies of these 15 commits for those terms, and for "skill", "tally" and "marker", finds nothing.
- The nearest subject on `main` that names one of them is `3a652ac` ("… the probe skill; …"): 14th in `git log --oneline` at `aeb5fd0`, 23rd at `528d9e2` and 50th at `aabb9c9`.
- Commits that reached `main` during P3's second attempt, before its `K.md` push (14:51:02Z): `9025ecc` (14:50:43Z) and the seven commits it merges (`a139306`, `0e162c1`, `58dfb64`, `cf834f7`, `e929a19`, `20c7277`, `90bcc4e`; branch `claude/c01-n149-helper-end`). None of their subjects or bodies names any of the terms. `daa7c34` merged at 14:52:43Z, after the `K.md` push.
- P3's second attempt read the subjects of the last three commits on `HEAD` (ROW13.md:13): the first three of its list above.
- So neither run's unprompted try is "possibly primed" under these conditions.

### CHK-C01-052 C4: P2's `Result:` line before P3's task K

Met by its first option. Since version 5, rule 2.2 counts the line without showing it (CHK-C01-053 finding 3; CHK-C01-054 finding 3). P3's second attempt records only the counts: "R1a, R1b, P1 and P2 each have a branch whose `CLOSING.md` counts a `Result: done|partial` line" (STAMP.md:7). P2's line itself reads `9. Result: done` (CLOSING.md:32) and carries no text about skills, task K or task K2.

### CHK-C01-054 C4: what P3 read before task K, between P2's `main` commit and P3's

Met.

```
$ git diff --stat aeb5fd0a9d86597256da45ef6ad7a6a903a9f1eb aabb9c977949e89118bdce54f479dfa548161261 -- evidence/C01/routine/CONTROL.md plan/Ek_D_Dusunme_Protokolleri.md CLAUDE.md
 evidence/C01/routine/CONTROL.md | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
```

With `evidence/C01/routine/AFTER_K.md` and `.claude/skills` added to the paths, the output is the same. `plan/Ek_D_Dusunme_Protokolleri.md` (`e4456ce`), `CLAUDE.md` (`5884a32`), `AFTER_K.md` (`59214f1`) and the skill file (`3e89b09`) are the same blobs at both commits. `CONTROL.md` (`3feb839` to `d9f3795`) changes in five lines, each replaced whole; what the word diff adds, exactly:

1. Line 3, the version line. "Version 7 (CHK-C01-055 C1, …" becomes "Version 9 (L-218, 2026-10-11; version 8: CHK-C01-054 C3, 2026-10-11; version 7: CHK-C01-055 C1, …". Added after the list of versions: "Version 9 gives the exact command for reading each of the two named variables, the session ID and `DEVOS_ENVIRONMENT`, each a test that prints one line, and says that `printenv`, `env`, `set` and `export` are not used, because the guard denies them (rule 1.2, part A item 2); nothing else changes. Version 8 had rule 2.2 count a `Result:` line that follows the closing record's item number (`9. Result: done`) as well as one at the start of a line, and had section 3.4 item 9 say how to write it so that it is counted (rule 2.2, section 3.4 item 9; CHK-C01-054 C3). Version 7 said". Version 7's sentence ends "(P1 items 1 and 3; CHK-C01-055 C1)." where it ended "… C1); nothing else changes."
2. Line 8, rule 1.2. Added: "Read each with exactly the command given here, as a Bash call of its own, and with no other command: never `printenv`, `env`, `set` or `export`, which the guard denies (rule B8). The session ID: `if [ -n "${CLAUDE_CODE_REMOTE_SESSION_ID:-}" ]; then echo "session id: $CLAUDE_CODE_REMOTE_SESSION_ID"; else echo "session id: unset"; fi`. The environment: part A item 2's command."
3. Line 20, rule 2.2. "`Result: partial`." becomes "`Result: partial` at the start of a line, or right after the closing record's item number (`9. Result: done`)."; the pattern `'^Result: (done|partial)'` becomes `'^([0-9]+\. +)?Result: (done|partial)'`.
4. Line 36, part A item 2. "read by name," becomes "read by name with exactly this command, as a Bash call of its own: `if [ -z "${DEVOS_ENVIRONMENT+x}" ]; then echo absent; elif [ "$DEVOS_ENVIRONMENT" = devos-kurulum ]; then echo match; else echo different; fi`;"; "recorded as" becomes "recorded as the word it prints:"; added at the end: "If the guard denies this command, record the denial (rule 1.5), and the gate is not met."
5. Line 62, section 3.4 item 9. Added: "Write it as `9. Result: done` (or `partial`, `not started`), or on a line of its own that starts with `Result:`, so that rule 2.2's count finds it; nothing may come before `Result:` on its line but the item number."

No added text names the skill, its marker, task K2's content or a row 13 observation of P2. A case-insensitive search of the added lines for the skill's name, the marker, "probe skill", K2, W2, "oak", "elm", "row 13", "skill", "tally", "marker", "unprompted" and "invok" finds nothing. "P2" occurs seven times in the old and seven times in the new version line, all in the unchanged account of version 5. Assumption: the example `9. Result: done` is the form P2's closing record used (L-214), but the text does not say whose record it was, and rule 2.2's count tells P3 in any case that P2 closed `done` or `partial`. P3 read neither `AFTER_K.md` nor the skill file before its `K.md`; the skill's text reached it through the Skill tool (ROW13.md:11, 14).

### CHK-C01-073 C2: the two P3 branches

Met.

- **`claude/probe-c01-p3-20261011T1420Z`** (head `38733f3`; S 14:20:42Z; `main` `528d9e2`, version 8) closed `not started` before task K: "9. Result: not started (environment gate: `DEVOS_ENVIRONMENT` was not read, guard denial #9, rule B8). P3 stays open." (CLOSING.md:17). Its read of `DEVOS_ENVIRONMENT` with `printenv` was denied by the guard (#9, rule B8; OPENING.md:6), as was its read of the session ID (#8, rule B8); "The step's own items (task K, `AFTER_K.md`, part B) were not reached" (CLOSING.md:5). This is L-218. Rule 2.2's count on it prints nothing, exit 1 (L-218, at 14:31:00Z; again for this record).
- **`claude/probe-c01-p3-20261011T1448Z`** (head `e971713`; S 14:48:43Z; `main` `aabb9c9`, version 9): its task K is P3's row 13 try, and its task K2 is P3's named try. Its stamp names the earlier branch, "Attempt: after `claude/probe-c01-p3-20261011T1420Z`" (STAMP.md:8). It read nothing of that branch but rule 2.2's count, which gave nothing, and rule 2.6's path test, which showed `CLOSING.md` there without reading it.
- The first attempt was another session; it made no try, and its records hold no skill list, since it did not reach part B.

### Version 9's count after P3 (CHK-C01-054 C3, CHK-C01-067 C3, CHK-C01-068 C3, read for version 9 as L-223 says)

Met. The executor ran rule 2.2's version 9 command word for word on P3's second branch at 14:53:59Z:

```
$ git grep -c -E '^([0-9]+\. +)?Result: (done|partial)' origin/claude/probe-c01-p3-20261011T1448Z -- c01-run/P3/CLOSING.md
origin/claude/probe-c01-p3-20261011T1448Z:c01-run/P3/CLOSING.md:1
```

Exit 0, at head `e971713ba0c53c76058d5724b7e56699d261bf06`. P3's line reads `9. Result: done` (CLOSING.md:20), so the count recognises the record and the next run will not take P3 again. Reproduced in the producer's scratch clone: the same output and exit 0; on P3's first branch nothing, exit 1; on P2's branch `…:c01-run/P2/CLOSING.md:1`. No run repeated P2 or P3: the only `claude/probe-c01-p2-*` and `-p3-*` branches are the three copied here.

### CHK-C01-073 C1, last sentence: P3's second stamp reads Version 9

Met. STAMP.md:12 of the second attempt: `- Control file version line: "Version 9 (L-218, 2026-10-11; ...)" (version 9).` So that run is judged under version 9. In the same way, P3's first stamp reads "Version 8 (CHK-C01-054 C3, 2026-10-11; …)" (STAMP.md:12), as CHK-C01-067 C1 asks, and P2's reads "Version 7 (CHK-C01-055 C1, 2026-10-11; …)" (STAMP.md:12).

## What the evidence does not show, and the inferences made

These are kept apart from the observations above.

1. **Assumption: nothing but the skill's description led each run to invoke it in task K.** Why it invoked the skill is the run's own report (P3's own D4, CLOSING.md:25). The marker shows that the skill's text was loaded during task K; that the run chose the skill from its description, and not from some other cue, rests on its account and on the reads it reports. Basis: nothing the runs report reading before task K names the skill or its marker; the subjects are neutral (above); `CONTROL.md` names skills only as things part B lists.
2. **Assumption: a re-invocation by name is the named trigger the design asks for.** Both named tries came after the same session had loaded the skill in task K, and the Skill tool marked each a re-invocation (P2 ROW13.md:32; P3 ROW13.md:29). A named invocation in a session that had not already loaded the skill is not observed in P2 or P3; L-037 saw one in a builder-created session. The design orders the tries this way (K before K2 in each run).
3. **Assumption: the text that arrived with P3's second start did not name the skill, its marker or task K2.** P3's second stamp says "Text arrived with the start: yes (content not recorded)" (STAMP.md:10); P2 and P3's first attempt recorded `no` under a start of the same kind. D-027's steps asked Batu to send no text ("Metin kutusu açılırsa boş bırakıp onayla", "if a text box opens, leave it empty and confirm"), and nothing addressed to him there names the skill, its marker or task K2. Text sent with Run now arrives wrapped and labelled as untrusted data (ROUTINE_DESIGN.md F4), and the stored prompt's ban 5 makes it data. If it did name them, P3's unprompted try would be possibly primed, the unprompted kind would rest on P2's one try, and the design's "two of each kind" would not hold for it.
4. **Assumption: P3's stated total of 43 skills is a slip of the count.** It lists 42 (OPENING.md:27-30); P2 lists the same 42 under the same marks. If it is not a slip, one skill P3's session offered is missing from its list. Either way it does not change Item 3's result, which already has a part that could not be checked.
5. **Assumption: `other-plugin-1` is enabled at account level, and is a marketplace plugin** (Item 4, with their bases).
6. **Assumption: the closing records' own pushes were allowed by the guard,** since their commits are on the branches (Item 3).
7. **Assumption: the merge gate ran and passed at `9bd17a3`** (Item 1).
8. **Assumption: the four plugin MCP servers in the producer's context belong to `other-plugin-1`** (The fail path).
9. **The Claude Code version** rests on a Grep output cut at 20 matches in each run (P2's and P3's own D5); a second version further in a transcript would not show.
10. **The times are the sessions' own.** No outside clock timed the tries; the commit dates come from the same clocks.

## What the runs noticed that bears on other rows or stages (pointers)

- **Plan 5.9's mark** is answered for routine sessions (Item 4). Its text changes through plan Section 14; N-186 is added on `plan/work/C01.md`, owner the executor, deadline C01's stage close.
- **Skills that the repository does not provide, in DevOS sessions.** An account-level plugin's 24 skills are in every routine session; skills trigger from their description; the guard allows the Skill tool for any skill. Plan Section 13's risk row (line 1260) names this: "Account plugins loading by themselves | Conflicting hooks or skills changing behaviour | C01 inventory, C00 decision; when a plugin version changes, the related exams are run again". The fail path's decision settles this one plugin; any skill or plugin enabled at account level later takes the same route. No open note covers it. N-187 is added on `plan/work/C03.md` (K-9's need: "for content coming from outside not to be processed as instructions").
- **T-13** goes to C05 by the dated line on N-077 (Item 6). N-073 on `plan/work/C01.md` says "T-13 stays with W-C01-20"; its line is the executor's.
- **The session's mode.** P3 records that `.claude/settings.json` sets `permissions.defaultMode` to `acceptEdits` while the session's own instructions say auto mode is active (OPENING.md:32). This is covered by N-167 on `plan/work/C01.md`. Neither P2 nor P3 met a denial by anything but the guard (CLOSING.md item 8).
- **`ccd_session` arriving mid-run** (P2 OPENING.md:14) is covered by N-181 on `plan/work/C02.md`.
- **The session ID.** P2 read it with `printenv`, denied (#7, rule B8), and used rule 1.2's fallback; version 9 fixed the command (L-218), and P3's second attempt read it with that command, allowed (STAMP.md:5; 0 denials, CLOSING.md:19). The ID it read carries a `cse_` prefix where its decision-log file has `session_`, as P1's did; nothing in row 13 rests on it.
- **The Claude Code version** `2.1.296` in P2 and P3 is N-148's baseline, so R4V stays closed. A pointer only.

## Facts taken from the documentation (PC-21 item 9)

- `.claude/agents/` and `.claude/skills/` arrive with the clone; skills enabled on claude.ai load in cloud sessions; plugins that a repository turns on are not installed. Guaranteed by platform (documented in https://code.claude.com/docs/en/cloud-environments, "What carries over from your setup", read 2026-10-10; ROUTINE_DESIGN.md F10); not independently tested, beyond what Items 4 and 5 observe: the repository's skill arrived and loaded, and one account-level plugin's skills loaded.
- In an Anthropic-hosted environment, Claude Code runs hooks from the repository and from the organization's server-managed settings; user and local settings files are not read. Guaranteed by platform (documented in https://code.claude.com/docs/en/cloud-environments, "Setup scripts vs. SessionStart hooks", and https://code.claude.com/docs/en/settings, "Settings in cloud sessions", read 2026-10-11; EV-C01-016); not independently tested.
- Text supplied with Run now or an API call arrives wrapped and labelled as untrusted data. Guaranteed by platform (documented in https://code.claude.com/docs/en/routines, "Trigger a routine", read 2026-10-10; ROUTINE_DESIGN.md F4); not independently tested.
- Qualifiers:
  - Per environment, only the variables, secrets and network setting are separate.
  - The GitHub identity and the account's connectors are shared across the account.
  - An environment's variables are readable inside its own sessions.
  - The channel to the model's own service stays open whatever the network setting.
  - Routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).
  - The pages showed no last-updated date.

## Result

| Part of the block | Result | Where |
|---|---|---|
| The probe skill, synthetic and labelled so, added through the merge gate with a fresh-context checker verdict at its head, before its probe runs | met | Item 1 |
| The common evidence envelope, naming the probe environment, the routine, the repository and the Claude Code version, with the runs' own records as raw evidence | met | Item 2; envelope |
| Every plugin, skill, subagent and hook loaded into the probe session, listed without naming a service (the service-name check passes on every probe branch) | agent types, skills, MCP servers and plugins (as far as names show them) listed, no service named, the check passes; hooks from sources other than the repository: could not check | Item 3 |
| Whether account-level plugins and skills, marketplace skills included, reach a routine session; plan 5.9's mark | answered: one account-level plugin's 24 skills reach every routine session; account-level items that did not reach: could not check | Item 4; N-186 |
| Whether the probe skill loads, and how it triggers, two tries of each kind | met: it loads; unprompted from its description, 2 of 2; when named, 2 of 2 | Item 5 |
| T-13's C01 part, and the evidence ID on N-077 | met | Item 6 |
| Fail path (a): a conflicting plugin or connector | could not check, handled as a failed part; the first branch applies | The fail path |
| Fail path (b): repository skills do not load or do not trigger reliably | does not apply | The fail path |

Row 13's success condition is not met: two of its parts could not be checked, and whether the one plugin the repository does not provide conflicts with DevOS's rules could not be checked from the runs' records. The fail path's first branch applies ("To a decision; if needed, turning them off at account level"); its second does not, since the repository's skill loads and triggers the same way in every try. Under the block, the executor records a plan-change decision, `plan/decisions/PC-<nn>.md`, that applies the first branch, and, if turning the plugin off at account level is needed, Batu's decision record in the Appendix E format with its effect on his other chats written out in advance (The fail path).
