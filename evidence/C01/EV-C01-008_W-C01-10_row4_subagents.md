# EV-C01-008 · W-C01-10: row 4, probe part: subagents in a session started by the routine (R1b, 2026-10-11)

**What this is.** The record W-C01-10 asks for: the probe part of plan C01 row 4, observed by R1b, the second working run of the routine `devos-c01-rutin` (`CONTROL.md` version 2, step R1b items 1 and 5, section 5.1). "P2" in the row and in the acceptance block reads as this routine, and "the probe environment" as `devos-kurulum` (PC-21 items 1 and 2; `ROUTINE_DESIGN.md` section 11). Row 4's documentation part is W-C01-09 (EV-C01-001, accepted); it is used here, not redone. R1b's records are copied verbatim under `evidence/C01/routine/runs/R1b-20261011T0913Z/`. Line numbers below are those of the copies (`R1b/<file>`), which are the same blobs as `c01-run/R1b/<file>` at the run branch's head (checked with `git rev-parse` for all seven files).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `fdaf4e50c360994ea2cb8be3a4ade92fa0a0035c`, the commit R1b read (`STAMP.md`:11). At it: `evidence/C01/routine/CONTROL.md` version 2 (blob `7def650`), `CLAUDE.md` (blob `5884a32`), `.claude/agents/prober.md` (blob `aa6da2d`), the guard `.claude/hooks/tool_allowlist.py` (blob `35c23f7`) and `tools/guard_report.py` (blob `cf8a263`). This record is written at `main` `680031a`, where all of these but `CONTROL.md` (now version 3) are the same blobs |
| Deployment configuration | The routine `devos-c01-rutin` in the cloud environment `devos-kurulum` (`DEVOS_ENVIRONMENT` read by name: `match`, `OPENING.md`:14). Repository `batuhanozgun/devos` only: the starting checkout's remote and the session's repository scope; the count of other checkouts was denied (#19, B5) and not tried another way (`OPENING.md`:15). Connectors removed: the only MCP servers are the platform's own `claude-code-remote` (3 tools) and the built-in `github` (54 tools) (`OPENING.md`:24). Session `cse_014hehG4ta6ADXdHPSDCSTs1` (`STAMP.md`:5), started by Batu's one Run now press and seen by the session as "scheduled" (section 1). Model: two statements of its context, kept unresolved (`OPENING.md`:17); permission mode "auto" by its context; effort `xhigh` as the guard counts it; the repository's hooks as at `fdaf4e5` (`OPENING.md`:41), the guard live (`OPENING.md`:8). **Claude Code version**, each as it shows on 2026-10-11: in the run, `not visible` (`OPENING.md`:20); in the working session `session_01XyxvJd3RayQk4HCrjurbVH`, `get_session` reported `external_metadata.container_cc_version` 2.1.296 at about 06:03Z that day (EV-C01-004:29, guard record #960) and again at 08:53Z (recorded in L-202, on `main`) |
| Criterion version | W-C01-10's acceptance block, last changed in `ea525d9` (W-C01-01; merged with PR #189 at `4113915`) and unchanged since: the re-plan `44cef4e` (W-C01-31) changed only its `depends_on` and added the flag that PC-21 item 2 reads "P2" as the routine. Read with plan C01 row 4 (last changed in `c793752`, 2026-10-06), the PC-21 note under the C01 table (items 1, 2 and 9), and `ROUTINE_DESIGN.md` section 7, "Row 4, probe part (W-C01-10)". All are the same at `fdaf4e5` and `680031a` |
| Input | `CONTROL.md` version 2 at `fdaf4e5`: step R1b items 1 and 5; section 5.1 items 1 to 4; the synthetic package 6.2 (marker `kestrel-417`) and the subagent tasks 6.3 (R4-T, R4-C). All labelled synthetic (plan Section 8 item 13) |
| Actual observation | R1b's opening record part B, `PACKAGE.md`, `ROW4.md` and closing record (section 2 below); R1a's part B for the same agent list in a run started by the schedule |
| Raw evidence ID | Branch `claude/probe-c01-r1b-20261011T0913Z`, head `568cf6a1bf5ad96002bf41d0423ddd6edda7217f`. Commits: `c2d8bbf` stamp, `ac7afaf` opening record, `44af4bc` package (and opening record times), `06a20e3` continuity, `b9e15c2` Q3, `f690ea2` Q4, `942481d` hand-over, `047991a` row 4 (background completion pending), `50a2218` row 4, `568cf6a` closing record. Copies: `evidence/C01/routine/runs/R1b-20261011T0913Z/`. R1a's part B: branch `claude/probe-c01-r1a-20261011T0808Z`, head `67fcd98`; copy `evidence/C01/routine/runs/R1a-20261011T0808Z/R1a/OPENING.md` |
| Independence level | Verified by self-observation (D-017 item 2(a)): what R1b records of its own session (agent types offered, statuses, times, notifications, the guard's report), dated 2026-10-11. Each subagent's answer on `CLAUDE.md`, and what the probers say they did, is that subagent's own report, a hint (`ROW4.md`:5). Read by a fresh-context producer subagent of the executor's working session; judged by a fresh-context checker (declared, Ek A 5.3) |

## 1. How R1b started

R1b's start time S is 2026-10-11T09:13:03Z (`STAMP.md`:6). Its stamp reads: "Fire reason as the session sees it: scheduled; the turn opens with the scheduler's notice that it was started automatically by a schedule (an automated firing of a configured prompt)." (`STAMP.md`:9).

It was in fact started by Batu's one Run now press. This is known from two things outside the session. First, his comment on issue #6 at 09:13:31Z, from `batuhanozgun`, comment `6107475020`: "Bastım. Çalışmaya başladı. Yeni oturum açtı." ("I pressed it. It started working. It opened a new session."); D-021, answered (a). Second, S matches no schedule time: the daily schedule is 08:07Z, and it had already started R1a at 08:08:23Z that day (EV-C01-005). So a run's stamp does not tell a Run now press from the schedule (D-021, "Answer"; `ROUTINE_DESIGN.md` section 6).

Row 4 asks for "a session started by a routine"; a Run now press of the routine starts one. CHK-C01-043 (on `main`, finding 1) judged that rows 1 and 4 "observe the session (queue, hand-over, subagent completion), not the trigger", so the press does not change row 4.

## 2. Point by point (W-C01-10's acceptance)

### 2.1 The `.claude/agents/` definitions load: met

- Part B lists the repository's five definitions among the agent types the Agent tool offers: "`repository`: checker, counter-designer, prober, producer, researcher." (`OPENING.md`:33). R1a, started by the schedule, lists the same (`R1a/OPENING.md`:33).
- The `prober` ran as its definition says. Foreground: "Marker line in the result: yes, `Marker: kestrel-417`." and "`## Disciplines (D1–D9)` block: yes" (`ROW4.md`:11, 12). Background: the same (`ROW4.md`:21, 22). The Disciplines block is the output form `.claude/agents/prober.md` asks for (its "Output" section, lines 34 to 42 at `fdaf4e5`), the form 5.1 item 1 names. The other parts of that output form were not recorded.
- Consistent with the role file being in force, by the probers' own reports: each made a shell call that the guard denied for the `claude` command line (#58 and #79, rule B7; `ROW4.md`:14, 24). That matches the role file's step "Record the environment: date and time (UTC), the commit SHA, and the versions you can observe (Claude Code, model)" (`prober.md` line 19). The denials are in the run's guard report. That they were the probers' calls rests on the run (they are not its own calls) and on the probers' reports (`ROW4.md`:43).

### 2.2 The synthetic package can be loaded at opening: met

- `PACKAGE.md`:5: "The role package, loaded at opening (right after part B; between the measured times 2026-10-11T09:14:42Z and 09:15:14Z), read from section 6.2 of `evidence/C01/routine/CONTROL.md` (Version 2) at `main` commit `fdaf4e5`". The package follows verbatim, labelled: "SYNTHETIC PACKAGE C01-R4 (plan Section 8 item 13)" (`PACKAGE.md`:8).
- The branch shows the same order: the package commit `44af4bc` comes after the opening record `ac7afaf` and before the continuity record `06a20e3` and any queue work.
- The package reached the subagents through their task: both prober results carry its marker (2.1).
- What the stand-in shows: a session started by the routine reads a package at opening and carries it into a subagent's task. It does not show how a real role package reaches a session; that exists only from C05.

### 2.3 The built-in helpers that do not load `CLAUDE.md`, by name: met, as the helpers' own reports

Six built-in types, one foreground call each with task R4-C (`ROW4.md`:28 to 37):

- **Explore**: "no"; tool-use count and duration "not shown" (`ROW4.md`:34).
- **Plan**: "no (by its report, its context held the account note, the commit attribution reminder, the environment details and the skills list)"; counts "not shown" (`ROW4.md`:36).
- `claude`, `claude-code-guide`, `general-purpose`, `statusline-setup`: "yes", each quoting `# DevOS: common rules (installation period)`, the first line of `CLAUDE.md` at `fdaf4e5`; tool-use count 1 each, which three of them (`claude`, `general-purpose`, `statusline-setup`) report as the hand-back call only (`ROW4.md`:32, 33, 35, 37). So for those three, at least, the line did not come from reading the file with a tool.
- Both probers, repository definitions, also answered "yes" with the matching line, from the copy in their context (`ROW4.md`:13, 23).
- Two helpers (`claude`, `general-purpose`) added that they had not answered the nine trigger questions that `CLAUDE.md` asks of helpers (`ROW4.md`:39). Naming that demand of `CLAUDE.md` supports their "yes".

The built-in helpers that do not load `CLAUDE.md`: **Explore** and **Plan**. Plan Section 6.5 item 5 keeps such helpers out of role work.

### 2.4 How a subagent call completes: observed; it can return before the subagent has finished

**Foreground** (the prober, task R4-T):

> "Made: after 2026-10-11T09:16:34Z (the last time taken before the call). Returned: by 09:18:03Z (the first time taken after it). The tool's own duration: 75 658 ms." (`ROW4.md`:9)
>
> "Status the tool returned: completed; the tool result said the report was delivered as a message from the subagent's hand-back call and did not repeat it; the report arrived as that message." (`ROW4.md`:10)

The foreground call returned when the subagent had finished, as far as the platform's status and duration show. Its report came not in the tool result but as a separate hand-back message. The six built-in helpers were called in the foreground in one message; all had returned by 09:18:31Z, "Each answer arrived as a hand-back message from the subagent." (`ROW4.md`:28).

**Background** (the prober, task R4-T):

> "Background option: yes. The Agent tool's description says subagents run in the background by default, and it has a `run_in_background` parameter." (`OPENING.md`:42; the same in `R1a/OPENING.md`:42)
>
> "Made: after 2026-10-11T09:18:03Z. The status returned at once (by 09:18:07Z): the agent was launched asynchronously, working in the background, with a notice that the run would be told automatically when it completes and an output file path." (`ROW4.md`:19)
>
> "Completion, and how it reached the run: the run did other work (the row 4 record draft, pushed at `047991a`), took the time 09:19:09Z, and ended its turn to wait. The completion then reached the run twice, both after 09:19:09Z: first as the subagent's hand-back message, which woke the session as a new turn (time taken on reading it: 09:19:24Z); then as a task notification with status `completed`, the tool's own duration 67 164 ms (launch to finish, so finished about 09:19:10Z) and a tool-use count of 8. The run waited for it before closing." (`ROW4.md`:20)

So the background call returned within about 4 seconds, and the subagent finished about 63 seconds later. Meanwhile the run made the six helper calls and wrote and pushed its draft row 4 record to its branch (`047991a`, committed 09:19:05Z). It then ended its turn. The end opened a new turn and reached the caller by two signals: the hand-back message, then the task notification. The boot ID did not change, and the wait was 09:19:09Z to 09:19:24Z (`CLOSING.md`:20, 21).

The record made at the time shows that no result had reached the run when it pushed its draft: at `047991a` (committed 09:19:05Z), `c01-run/R1b/ROW4.md`:20 still reads "Completion: see below.", and the background prober's lines there carry no marker or result yet.

The report reached the caller before the end status. The hand-back is a call the subagent makes: by the run's record, the foreground tool result named it so ("a message from the subagent's hand-back call", `ROW4.md`:10), and three helpers count it as their single tool use (`ROW4.md`:32, 35, 37; their own reports). In the background, by the run's account, the hand-back message with the report came first, and the task notification with status `completed` after it (`ROW4.md`:20).

On EV-C01-001's open questions for this part:
- The foreground can be obtained in a session started by the routine. So the documented fork mode, in which "Claude can't ask for the foreground", was not in effect for this call (an inference from one call).
- Whether the foreground calls set the background option off or left it out is not recorded (`ROW4.md`:9, 28; `CONTROL.md` version 2, 5.1 item 1 asked only for "not in the background"). So the default was not observed. That the default is the background is the tool description's statement (`OPENING.md`:42), not an observation.
- The session's turn can end while a background subagent runs, and the completion opens a new turn (observed once, after a 15-second wait).
- What happens to a background subagent's writes when it is stopped, fails or its machine is reclaimed: not observed. No subagent was stopped, and the probers wrote no file, by their own reports.
- `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS`: not tried (`ROUTINE_DESIGN.md` section 10 sets no such variable).
- EV-C01-001's reading names a completion notification only; it does not mention the subagent's hand-back message. That message may be described on pages the reading did not read (EV-C01-001 section 5).

### 2.5 Whether the hook input identifies a subagent and its role: could not check

> "The report names no subagent and no agent type for any call: the attribution of calls to a subagent and an agent type is `not shown by the report`." (`ROW4.md`:43)

Why, from the guard's code at `fdaf4e5` (the same blobs at `680031a`): the guard writes the hook input's `agent_id` into each decision record (`.claude/hooks/tool_allowlist.py` line 2030), but not `agent_type`; `tools/guard_report.py` prints neither. The run's decision log stayed in its own container (`/tmp/devos-guard` by default, `tool_allowlist.py` line 57) and was not copied. So whether the hook input in the routine's session carried `agent_id` and `agent_type` could not be checked; this guard could not have shown `agent_type` at all.

The cause is the probe step's design: `CONTROL.md` version 2, section 5.1 item 4, asked only for the guard's report, and the step read only that report, so as designed it could not show either field. An inference, not tried: the run's own decision log, readable with a file reader, would have shown `agent_id`, but never `agent_type`.

What the record does show: the guard decided tool calls made inside the subagents in the routine's session (denials #58 and #79, which the run says it did not make and the probers' reports claim; `ROW4.md`:43). So the hooks ran for subagent calls there. That is not identification.

Context, not a stand-in: in an earlier working session, which no routine started, the guard's records of a researcher subagent's calls carried its `agent_id` (C00 log, L-119, 2026-10-05). On authority, the documentation leaves the fields without any statement of authority, so the documentation branch of the fail path does not fire (EV-C01-001 sections 3 and 4, accepted under W-C01-09).

### 2.6 The Claude Code version: in the probe session, could not check; in the working session, 2.1.296

- Probe session: "Claude Code version: not visible (no `get_session`; the `claude` command line was denied, #22, B7)." (`OPENING.md`:20). "Part A item 4: the Claude Code version is not visible, so R4V's rule cannot hold against this run's record." (`CLOSING.md`:72).
- Working session: 2.1.296 by `get_session` on 2026-10-11, at about 06:03Z (EV-C01-004:29, guard record #960) and at 08:53Z (L-202, on `main`).
- That R1b ran 2.1.296 is not shown. Both sessions run in `devos-kurulum`, but in different containers.
- Effect: R4V's rule in `CONTROL.md` version 3 (section 4, line 78) reads "if either is `not visible`, the rule does not hold" (version 2, which R1b read, said "both being visible", `fdaf4e5` line 78). The rule compares against part A item 4 of the latest closed R1b or R4V run, and R1b's is `not visible`, so after R1b the rule cannot hold at all and R4V cannot open from a run's record. Within C01, a version change is then seen only through the working session's `get_session`, which is N-111's trigger. The version to record with this observation, for N-111's comparisons: 2.1.296 as the working session reports it; the routine session's is not visible.

## 3. Against K-7 items 3–4 and Section 6.5 items 5–6

Yes: a subagent call can return before the subagent has finished, and its completion is signalled otherwise than those items assume.

- The background call returned in about 4 seconds; the subagent finished about 63 seconds later. In this session the Agent tool describes the background as its default (`OPENING.md`:42).
- K-7 item 3 ("Only one writer writes to a product at any one time") and Section 6.5 item 6 ("a product is written by only one subagent at a time") order writers in time. K-7 item 4 passes a chunk on with a hand-over. None says how the coordinator knows that a subagent has stopped. Section 6.5 item 5's task definition names the writer and the record the result goes to, but not whether the call runs in the foreground or the background, or how its end is waited for. This record reads the items as if a call's return were the subagent's end; the items themselves say nothing about a call's return. The completion branch does not rest on that reading: it fires on the observation alone, that a call can return before its subagent has finished.
- What was observed instead: the return can come first. The end arrives later, as a message in a new turn, by two signals (the hand-back message, then the task notification). Even in the foreground the result came as a separate hand-back message, not in the tool result. The caller went on working, and pushed to its own branch, while the background subagent ran (`047991a`).

So the fail path's completion branch applies: K-7 items 3–4 and Section 6.5 items 5–6 are corrected through plan Section 14, and C06's three tests (T-61, N-096 on `plan/work/C06.md`) are designed from this observation before C06. The plan change is the executor's. The documentation already said that a background call returns at once (EV-C01-001 section 4); that reading left the branch to this observation, which confirms it in a session started by the routine. For T-61's design, two further points are on record here: the end reached the caller by two signals, the hand-back message with the report, then a completion notification with status, duration and tool-use count; whether the notification carried the report again is not recorded (`ROW4.md`:20). K-7 Testing's retried call ("the same result delivered twice (a retried subagent call) is recorded and used once") is the nearest case. And the caller wrote to its branch while a background subagent was running.

## 4. What this record cannot show

- A subagent's answer on `CLAUDE.md`, and what a prober says it did, are its own report (2.3, 2.1).
- The run's Claude Code version (2.6).
- That R1b was started by a Run now press: known from Batu's word and from S, not from the session, which saw "scheduled" (section 1). CHK-C01-043 judged that this does not change row 4.
- That the foreground call returned only when the subagent had finished rests on the platform's status and duration. No foreground prober call after the return can be excluded from the guard's report, which does not attribute calls (2.5).
- One run, one call of each kind. Not observed: a background subagent that runs longer than the machine's idle pause, or one stopped mid-work, and what then happens to its writes.
- The times in `OPENING.md` and `PACKAGE.md` were corrected from estimates to measured values with a shell `sed -i` (`CLOSING.md`:70, a rule 1.1 deviation, commit `44af4bc`). The package's place at opening also rests on the commit order (2.2).
- Whether the hook input identifies a subagent and its role (2.5).

## 5. Facts taken from the documentation (PC-21 item 9)

1. "Foreground subagents block the main conversation until complete"; "Background subagents run concurrently"; "a background launch returns immediately"; the status is `"completed"` for foreground and `"async_launched"` for background subagents; "A background subagent's results reach Claude as a completion notification in a later turn". Guaranteed by platform (documented in the official Claude Code documentation, site `code.claude.com`, path `docs/en/`, pages `sub-agents` and `hooks`, read 2026-10-06; EV-C01-001 section 1); not independently tested. R1b observed both modes and a later completion in a session started by the routine (2.4); it recorded `completed` for the foreground call and for the background notification (`ROW4.md`:10, 20). It paraphrased the background launch's status, so `async_launched` is not shown.
2. When a subagent calls a tool, the hook input "carries the `agent_id` and `agent_type` common input fields that identify the subagent"; no statement makes them authoritative. Guaranteed by platform (documented in the same documentation, pages `hooks` and `sub-agents`, read 2026-10-06; EV-C01-001 sections 2 and 3); not independently tested. In R1b's session: could not check (2.5).
3. In cloud sessions "Subagents work the same way they do locally"; when a cloud machine is reclaimed, background work such as subagents is not restored; routines "run autonomously as full Claude Code cloud sessions". Guaranteed by platform (documented in the same documentation, pages `claude-code-on-the-web` and `routines`, read 2026-10-06; EV-C01-001 section 1); not independently tested.
4. `.claude/agents/` arrive with the clone; the repository's hooks and permission rules load in a session with one repository. Guaranteed by platform (documented in the same documentation, page `cloud-environments`, "What carries over from your setup", read 2026-10-10; `ROUTINE_DESIGN.md` F10); not independently tested. R1b's part B lists the definitions, and its guard was live (2.1; `OPENING.md`:8).
5. An idle session's machine pauses after a few minutes, with its files saved, and can later be reclaimed. Guaranteed by platform (documented in the same documentation, page `cloud-environments`, "Time limits", read 2026-10-10; `ROUTINE_DESIGN.md` F11); not independently tested.

Qualifiers. The pages carry no date of their own. At the 2026-10-06 reading the changelog's newest release was 2.1.291, and the pages describe the current release, not a given session's version (EV-C01-001); the working session now reports 2.1.296. Per environment only the variables, secrets and network setting are separate; the GitHub identity and the account's connectors are shared across the account; an environment's variables are readable inside its own sessions; the channel to the model's own service stays open whatever the network setting; routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12; N-111 at a version change).

## 6. Result

| Part (W-C01-10's acceptance) | Result |
|---|---|
| The `.claude/agents/` definitions load, in a session started by the routine | Met (2.1) |
| The synthetic package, labelled synthetic, can be loaded at opening | Met (2.2) |
| The built-in helpers that do not load `CLAUDE.md`, by name | Met, as the helpers' own reports: Explore, Plan (2.3) |
| Whether a call returns only when the subagent has finished or can run in the background, and how completion is signalled | Observed: a background call returns at once; the end comes later as the subagent's hand-back message in a new turn, then a task notification; a foreground call returns `completed` at the end, its report as a hand-back message (2.4) |
| Whether the hook input identifies a subagent and its role | Could not check (2.5); handled as a failed part |
| The Claude Code version, as the probe session shows it and as `get_session` reports it | Probe session: could not check (`not visible`); handled as a failed part. Working session: 2.1.296 on 2026-10-11 (2.6) |

**The probe part is not met.** Two parts could not be checked, and a part that could not be checked is never met (plan Section 8 item 14; W-C01-10's acceptance). Reading the probe session's `not visible` as the version it shows would loosen the criterion after the result was seen (plan Section 14). Under the acceptance block, a plan-change decision is taken and recorded: PC-24 (`plan/decisions/PC-24.md`, plan Section 14), the executor's. PC-24 applies the fail path's completion branch. The hook-input and version parts are failed parts, handled with no plan text change:

1. **Completion (section 3).** The fail path's completion branch fires on the observation itself, whatever happens to the other parts. PC-24 corrects K-7 items 3–4 and Section 6.5 items 5–6, and T-61's three tests are designed from this record before C06 (deadline: C06's start, N-096).
2. **Hook input (2.5): a failed part, with no plan text change.** Its components exist in C01: the routine's session, subagents in it, and a guard that already logs `agent_id`. What limited the observation was the probe step's own design (`CONTROL.md` version 2, 5.1 item 4). So the route for components that "cannot be stood in for" (W-C01-10's acceptance; plan C01, the paragraph after the probe setup) does not apply. No branch of the fail path fires: the documentation branch does not (EV-C01-001 section 4), nor does the role-texts branch (item 4). The plan already takes the unfavourable case: the role name rests on self-declaration and no authority decision rests on it, and subagents in a session share one identity (K-9 item 2 (c) and (d)); no plan text names `agent_id` or `agent_type`. So no re-read is triggered, and there is no guard change or rerun now: observing the fields again in C01 (the guard logging `agent_type`, its report showing both, a step rerunning 5.1) would cost a class-high change and a run for a fact no decision needs. The work its fail path comes before is C03's tests of the guard (N-060 point 10). For C06's trace, a line for T-78 on N-096 asks that the fields be observed first in a routine-started session if the trace attributes calls by them.
3. **Version (2.6): a failed part, with no plan text change.** Its components exist in C01; what limited the observation was that the run had no `get_session` and the guard's rule B7 denies the `claude` command line. No branch of the fail path is about the version. The version recorded with this observation is 2.1.296, as the working session's `get_session` reported it on 2026-10-11 (EV-C01-004:29, guard record #960; L-202, 08:53Z). R4V cannot open from a run's record (2.6), so the re-observation "whenever the Claude Code version changes" rests on the working session's `get_session` (N-111; W-C01-30 point 8). If the working session's version changes before C01 closes, this probe part is observed again (W-C01-10's acceptance). A run reading its own version needs no guard change if it uses a file reader: in the working session, each transcript event carries the version and the guard allows a file reader to read it (a same-session check by a researcher subagent, 2026-10-11). It would need a checked change to `CONTROL.md` part A item 4, and whether a routine session's transcript carries the version is not observed. N-148 on `plan/work/C01.md` carries R4V's rule and this option.
4. **The role-texts branch** ("The role texts are loaded explicitly in the session; evidence of the loading is recorded") does not fire. The definitions and the package loaded (2.1, 2.2; `ROUTINE_DESIGN.md` section 7 ties this branch to their not loading).
5. **N-096.** The evidence ID of this observation, EV-C01-008, goes to C06's T-61 by a dated line on N-096 in `plan/work/C06.md`, with T-61's design points and a line for T-78 (PC-24).
