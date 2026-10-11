# EV-C01-025 · W-C01-27: the counter-design rows C01's observations decide (N-063; 2026-10-11)

**What this is.** This is the record W-C01-27 asks for. Note N-063 on `plan/work/C01.md` says that this stage decides eighteen rows of the counter-design comparison (`evidence/C00/EV-C00-012_counter_design_comparison.md`, "EV-C00-012" below): D01, D07, D16, D18 and D24 from its section 3, and P3, P4, U1 to U7, UK, N4, Q1 and B4 from its section 4. For each row this record gives the row's question and the counter-design's candidate, a disposition, the C01 evidence it rests on, and the plan change that settles it or the note that carries it. All of that evidence is accepted on `main`. For UK it marks each [K] item as relied on by the plan or not, and reads each one the plan relies on from current official documentation (section 3). The counter-design itself is `evidence/C00/EV-C00-010_counter_design.md` ("EV-010").

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `c7b2aafe5665b900e021da4b968c364fccc49ecb` (PR #245, row 10 and PC-36 accepted, L-245 and L-246), read in a scratch clone on branch `claude/c01-w27-counter-design`. All the plan, work-file and evidence line numbers below are at this commit |
| Deployment configuration | None. No session, routine or environment ran for this item. The record reads accepted C01 records at the source commit. The UK pages were fetched with `curl` through the working session's network proxy into a scratch directory outside the repository; their copies are not filed |
| Criterion version | W-C01-27's acceptance block at `c7b2aaf` (`plan/work/W-C01-27.md`, blob `6ca326d9f4fc6cf9ab5c6c71b95a8bf9d358abcc`), read with note N-063 (`plan/work/C01.md`:258-262) and EV-C00-012 sections 1a, 3, 4 and 5 |
| Input | The executor's task to a producer subagent: the item's file, N-063, EV-C00-012 sections 3 to 5, and the item's map from rows to C01 row items. The task text is not filed |
| Actual observation | (1) The C01 records and plan changes each row cites, read at `c7b2aaf` only as far as the row needs: EV-C01-001, -002, -003, -004, -007, -008, -009, -011, -016, -018, -019, -020, -022 (with -022a), -024 (with -024a); PC-21, PC-25, PC-28, PC-32, PC-33, PC-34, PC-36; D-020; notes N-131 and N-136 (C02), N-150 (C03), N-179 (C04), N-138 (C05), N-139, N-157, N-178, N-190 and N-068 (C06), and N-145 and N-063 (C01). (2) Official documentation, fetched 2026-10-11 between 18:54Z and 18:56Z. Its URLs are in section 3 |
| Raw evidence ID | The C01 evidence IDs above. The UK pages are cited by their URLs; each is quoted in at most one sentence |
| Independence level | Written by a fresh-context producer subagent of the executor's working session. The producer is not blind: it read the plan and the records it disposes of. Each disposition rests on a record that a checker accepted, and this record adds no observation of the platform beyond the UK pages. Each UK page was read once, by the same model family that wrote the plan: "documented, read 2026-10-11; not independently tested". A fresh-context checker judges this record (declared, Ek A 5.3; PC-06) |

## How the criterion is read

1. **Dispositions.** Each row, or each part of a row whose parts differ, gets exactly one of these: *adopted into the plan*; *rejected*; *settled by a named plan change* (or by a named decision of Batu's); *decided, no change* (the observation supports the plan as written); or *undecided*. An undecided row names the reason, the note that carries it, the stage that decides it and the work it comes before.
2. **"C01 did not make the deciding observation".** This also covers a fact the documentation does not state, where PC-21 took the row's fail path as the design. In that case the design is recorded here, but the row's question stays undecided until the stage that tests it.
3. **Carrying notes.** An accepted row item may already carry a row by name to its stage, in a note that names the work it comes before. That note is cited here, not copied, so that each fact has one authoritative copy (Ek D, D7 item 2). Rows that no note names yet are carried by the new note N-193 on `plan/work/C06.md` (section 5).
4. **Batu.** No row's disposition needs a decision of Batu's now. B4 needs one only if its condition arises at C02 (section 2, B4).

## 1. Rows of EV-C00-012 section 3

### D01: the run budget

- **Question and candidate** (EV-C00-012:60; 5.1). The counter-design runs Lead 7, Check 4, Exam and maintenance 1 and reserve 3 a day, with each Lead run bounded by an 80/100-minute time box (EV-010 §7.2). The plan runs working 3, audit 3, exam 1 and reserve up to 8, changed with C01's session-duration measurement. Both splits are assumptions resting on the real session duration and the run limit. Rows 1 and 5 measure those, C06 sets the split, and the counter-design's split is an input.
- **What C01 observed.** *Run limit* (row 5; EV-C01-022 sections 1.1 and 1.3; EV-C01-022a): since 2026-09-30 the documentation states no daily run cap, only hourly limits on starting runs and the shared five-hour and weekly usage, and Batu's account pages show no routine-run line. *Session duration* (row 1; EV-C01-007 point 2 and "Plan 6.4's starting budget"): two routine sessions on synthetic items, 5 min 2 s and 6 min 38 s, each of which ended because its work was done. The longest a session can run was not measured. *Capacity* (row 10; EV-C01-024): a session cannot see its share of the usage allowance.
- **Disposition.** The *run-limit part* is settled by **PC-34** (accepted). 6.4 and every plan place that rested on "15 runs a day" now carry the documented hourly limits; the figures are unchanged. The *session-duration part* is undecided. Row 1 did not measure the longest duration, and **N-145** (`plan/work/C01.md`:349-351) replaces K-7's two markers before C01's stage close, naming where the longest duration is observed. The *split itself* is **undecided**. No C01 observation chooses between more, shorter runs and fewer, longer ones: the length of real working sessions is unmeasured, and capacity is worked out by estimate (PC-36). The split is carried to C06 by **N-193**, before C06 has the routines created (C06 tasks, plan line 1052; 6.4's table), with the counter-design's split and time box as an input. The plan is unchanged.

### D07: how a role is identified

- **Question and candidate** (EV-C00-012:66; 5.1). The counter-design gives each role its own database user: Supabase Auth users with the role in `app_metadata`, or custom Postgres roles through a JWT, chosen after reading the documentation (EV-010 §9; U3). The plan carries an environment token in a separate header; the database keeps the token's hash and derives the role class from it (plan 6.3, line 646). The plan's fallback is an Edge Function gate (row 3, line 947).
- **What C01 observed.** Row 3 (W-C01-35; EV-C01-002 sections 1 and 4) found from the documentation that the token can take two forms. As an environment variable, the environment's own sessions can read it. As a network secret (Pro and Max plans), the agent proxy attaches it in a header and sessions use it without reading it. W-C01-42 (EV-C01-004 S5; N-136) chose the network secret with a custom header for its structure.
- **Disposition: undecided.** The token's form and row 3's fail path are C02's token design (PC-21 item 4). **N-131** items (2) and (3) on `plan/work/C02.md` carry D07 by name, with N-136, to be decided before C02 task 3 builds the identity chain. The counter-design's per-role database users are read there, from current Supabase documentation, beside the Edge Function gate (EV-C01-002 section 4(b)).

### D16: the decision channel's primary and backup channels

- **Question and candidate** (EV-C00-012:75; 5.1). The counter-design's primary channel is a pinned issue (a GitHub mobile push) plus a daily Check-run message in the Claude app; GitHub's own e-mail is the backup; each channel is confirmed once with Batu (EV-010 §6.5). The plan's primary is the GitHub app; a decision not opened in time is repeated through a second channel (5.5; 6.9).
- **What C01 observed.** Row 6 (W-C01-13; EV-C01-019 sections 1 and 2): the machine account opened issue #222 on `devos` and assigned it to Batu, and it reached him as a GitHub app notification on his phone, by his report. When it arrived, and whether the creation or the assignment triggered it, is not shown (EV-C01-019 section 6). The second channel has no sending mechanism before C06 (section 4).
- **Disposition.** The *primary channel*: decided, no change. The plan's GitHub app channel was observed reaching Batu once, with the limits above, so the plan keeps it. The *backup channel*: **undecided**. It is carried to C06 by **N-178**, to be observed and its reliable candidate recorded before the decision channel is relied on. **PC-33** (accepted) already settled Appendix E section 8's text. N-193 adds the counter-design's daily Claude-app message to N-178's candidates for criterion 23's "Claude app".

### D18: hook-driven session discipline

- **Question and candidate** (EV-C00-012:77; 5.1). The counter-design drives continuity by hooks: SessionStart injects the brief at start, resume and compaction; a hook renews the lease on tool calls and pushes work in progress every 15 minutes and at turn end; a Stop hook refuses to end until the work is pushed and checkpointed (EV-010 §2.3; U2). The plan gives the brief by instruction, names no sender for the liveness signal (Appendix B line 154), writes progress "at frequent intervals" and makes the closing hand-over a discipline (6.5 item 11, line 685).
- **What C01 observed.** No hook output reached either routine session at its start, and no compaction or resume occurred. The repository configures only a SessionStart hook with matcher `compact`, so the result shows nothing about SessionStart at resume or compaction (EV-C01-007 point 4). Stop blocking, UserPromptSubmit, the platform's treatment of a hook error and the session ID in the hook input were not observed (EV-C01-016 point 3). Section 3, item 1 gives the documentation's reading of the input fields and exit codes.
- **Disposition: undecided.** The events this mechanism would rest on were not observed in a routine session. The choice of mechanism is already C06's by plan text: C06 tasks, "who sends the claim's liveness signal, and how (EV-C00-012 D18)" (line 1052), and Appendix B line 154 (PC-08). **N-193** carries the observation: before C06 fixes the liveness signal's sender and form and the mechanism of the closing hand-over, each hook event the choice relies on is observed in a DevOS routine session, or the choice does not rely on it.

### D24: usage observability

- **Question and candidate** (EV-C00-012:83; 5.1). The counter-design takes per-run usage to be unobservable and uses run duration, limit incidents and runs a day as proxies (EV-010 §7.2; N4). The plan observes usage in C01 #10 and falls back to estimates.
- **What C01 observed.** Row 10 (W-C01-17; EV-C01-024 sections 1, 2, 4 and 6; EV-C01-024a): a session sees its own token counts and `cost_usd`, and one usage window's state at a time. It does not see the fraction of the window used, or DevOS's share against Batu's.
- **Disposition: settled by PC-36** (accepted; CHK-C01-097; L-246). Capacity and the share of the allowance are worked out by estimate, and the uncertainty is recorded (K-7 item 9, 6.4, U-5 and its PC-36 note, C11, Appendix G). This agrees with the counter-design's premise as to the share. The estimate also uses what a session does see, beside the counter-design's proxies. No further change.

## 2. Items of EV-C00-012 section 4

### P3: three routines with separate environments and credentials

- **Question and candidate** (EV-C00-012:148; 5.2). The counter-design gives each routine its own environment and credential (EV-010:763; U1). The plan has the same design (6.3), to be verified by C01 rows 3 and 12.
- **What C01 observed.** *Row 3* (EV-C01-002 section 4(b)): per-environment variables and secrets are documented. *Row 12* (EV-C01-018 section 3): the GitHub connection is one per Claude account, is used by every environment, and its credential never enters a session, so no GitHub-level separation between environments is counted (PC-32). *Row 17* (EV-C01-003 section 5(a)): the documentation states no limit by environment on the account's control surface, so the fail path is the design, and Batu chose to keep all three environments in his account (D-020 (a), L-185). W-C01-42 gave that choice its structure (EV-C01-004; N-136).
- **Disposition: settled by PC-21 (items 4, 6 and 7) and PC-32, with D-020 (a).** The plan keeps three environments, each with its own token (6.3). As far as C01 can show, separation between environments rests on per-environment secrets (documented) and on DevOS's own measures; it does not rest on GitHub. The real tokens are C02's: **N-131** and **N-136** carry them, the identity chain before task 3 and the environments before task 7 and before any session runs in them. No further change.

### P4: one repository per session; which repositories the exam and audit sessions attach

- **Question and candidate** (EV-C00-012:149; 5.2). The counter-design has one repository per session and reaches the library through Supabase. The plan does the same (1.3 B), but left open which repositories the exam and audit sessions attach.
- **What C01 observed.** Row 9 (W-C01-37; EV-C01-016 points 1 and 3), documented and read 2026-10-11: a repository's hooks and permission rules load only in a session with one repository.
- **Disposition: decided, settled by PC-21 item 5** (plan line 969: one repository per session, row 9's fail path as the design) **and PC-32** (7.3: answer keys in the database schema only the exam token reads). The exam and audit routines attach `devos` only, and exam material lives in the database. **N-138** (`plan/work/C05.md`) and **N-139** (`plan/work/C06.md`) apply this.

### U1: secrets one session cannot read from another

- **Question and candidate** (EV-C00-012:165; 5.2). Under the counter-design (EV-010:785), routines can be bound to distinct environments with distinct secrets, and a routine session cannot read another environment's secrets. Its authority independence depends on this.
- **What C01 observed.** The documentation states per-environment secrets, and that sessions cannot read network secrets. It states nothing across environments (EV-C01-002 sections 1.1, 1.2, 2 item 1). The GitHub credential never enters a session, but it is the same for every environment (EV-C01-018 section 3). There is no limit by environment on the account's control surface (EV-C01-003 section 5(a)). No trial was made (FR-05; PC-21).
- **Disposition: undecided.** The cross-environment part was neither stated nor observed. The design takes the fail path: under D-020 (a) every pair of environments is kept apart only by DevOS's own measures, criterion 30 is claimed only at that level, and the residual is re-assessed with D-003 at C03. N-136 gives the structure. **N-131** items (1) and (2) and **N-136** carry U1 to C02, whose tests (Appendix C N04, F06) and Acceptance line on each environment's real token show it before task 3 and before sessions run in the three environments (task 7). Row 12's part is met at the documentation level (EV-C01-018).

### U2: hook events in routine sessions

- **Question and candidate** (EV-C00-012:166; 5.2). Which hook events hold in routine sessions: SessionStart at resume and compaction, PreToolUse allow and deny without a prompt, interception of the Agent tool, Stop blocking, UserPromptSubmit, the treatment of a hook error, and the session ID in the input.
- **Disposition by part.**
  - **PreToolUse allows and denies with no prompt:** decided, no change. Observed in routine sessions R1a and R1b ("0 passed to the user"; EV-C01-007 point 4; EV-C01-016 point 2).
  - **Interception of the Agent tool and of subagents' calls:** decided, no change. The guard decided the Agent tool's calls and calls inside subagents (EV-C01-016 point 2; EV-C01-008 section 2.5). Whether the hook input identifies the subagent could not be checked in the session (EV-C01-008 section 2.5). The documentation describes `agent_id` and `agent_type` and does not call them authoritative (EV-C01-001).
  - **SessionStart at resume or compaction:** undecided, not observed (EV-C01-007 point 4).
  - **Stop blocking and UserPromptSubmit:** undecided, not observed; no such hook is configured (EV-C01-016 point 3).
  - **The treatment of a hook error:** documented, not observed. Section 3 item 1: on any exit code other than 0 or 2 the action goes ahead. The guard's own fail-closed behaviour is W-C01-38's tests, not this row.
  - **The session ID in the input:** documented as a common input field (section 3 item 1), not observed in a routine session. Whether it differs inside a subagent is not stated (EV-C01-001).
  - The undecided parts go with D18 to C06 by **N-193**, before C06 fixes the liveness signal's sender and form.

### U3: per-role database access over HTTPS; reachability through the session's proxy

- **Question and candidate** (EV-C00-012:167; 5.2). The counter-design gives each role a database user over the HTTPS API under the current key system, reached through the session's proxy. The plan uses the header token and 6.3's network setting.
- **Disposition by part.** *Reachability*: decided, no change. It is met at the documentation level: Full network reaches any domain, and a secret's host is reachable at every level (EV-C01-002 sections 1.3 and 4(b)). *The database mechanism*: **undecided**, carried with D07 to C02 by **N-131** (2), for C02 tasks 3 and 4.

### U4: query-side embedding with a multilingual model

- **Question and candidate** (EV-C00-012:168; 5.2). Can a session embed queries with a multilingual model? The plan's choice is an open multilingual model (5.4), and C01 row 7 checks it.
- **What C01 observed.** Row 7's session part (W-C01-14; EV-C01-020, "Result"): both candidate models, named with their revisions, loaded and embedded the synthetic Turkish and English sample in a routine session, in 21 s and 43 s against the 600 s limit fixed before the run.
- **Disposition.** The *session part*: decided, no change. The *Actions part and the model choice*: **undecided**. They are carried to C04 by **N-179**, before task 1 (the ingestion jobs), and by 5.4's comparison in C04.

### U5: the routine's API trigger: its token, and whether its runs count against the limit

- **Question and candidate** (EV-C00-012:169; 5.2). What token type does the routine's API trigger use, and do API-triggered runs count against "the 15 runs"?
- **What C01 observed.** From the documentation (EV-C01-022 section 2.2; EV-C01-022a): an API fire counts against the routine's 30 an hour, a count it shares with Run now and one-off re-arms, and against the account's 100 API fires an hour, counted separately from Run now. There is no daily cap. Adding an API trigger issues a token, so C01's routine has none (EV-C01-022 section 2.2, citing ROUTINE_DESIGN.md:17).
- **Disposition.** The *documentation part* is settled by **PC-34**: the premise of "15 runs a day" is gone, and 6.4 lists the hourly limits. The *account part* (what the account shows for an API-started run) is **undecided**. It is carried to C06 by **N-190**, before the reserve budget's API trigger is relied on. The *token-type part* (which token the routine's API trigger issues and uses) is **undecided**: C01 made no dated reading of it, and ROUTINE_DESIGN.md:17's "it would issue a token" is a design note, not a reading. It is carried to C06 by **N-193**, before C06 enters the reserve budget's API trigger key (CHK-C01-098 condition C1).

### U6: GitHub access from a session

- **Question and candidate** (EV-C00-012:170; 5.2). Can a session work with branches, pull requests, issues and auto-merge on a public repository under GitHub Free, and are unattached repositories unreachable?
- **What C01 observed.** Row 8 (W-C01-15; EV-C01-009): pushes, pull requests and merges of the installation's own work succeeded. The platform does not limit a routine's pushes to `claude/` branches. Auto-merge is documented as available on public repositories under GitHub Free (EV-C01-009:87; re-read in section 3 item 5a). Row 6: the machine account opened and assigned an issue (EV-C01-019 section 1). Row 12 (EV-C01-018 section 3): "unattached repositories unreachable" is stated for API requests but not for git, and a session can attach more repositories.
- **Disposition: settled by PC-25 and PC-32.** PC-25: 5.6 names the guard and GitHub's rules as the layers that hold the `claude/` limit, and Section 12 lists the auto-merge setting step for C03 test 5. PC-32: unattached repositories are treated as reachable. *Whether auto-merge works with the session's connection*: **undecided**. **N-150** carries it to C03 test 5; 6.8's marker at line 748 stays as written, and W-C01-30 point 5 judges it (PC-25, "Not changed on purpose").

### U7: whether the Claude app notifies when a routine session finishes

- **Question and candidate** (EV-C00-012:171; 5.2). Does the Claude app notify Batu when a routine session finishes? The counter-design relies on it for its daily Claude-app message; the plan names it as a second-channel candidate.
- **What C01 observed.** Row 6 observed only the GitHub app channel (EV-C01-019 sections 1, 2 and 4). None of the C01 records read here observes a Claude app notification at a routine's end.
- **Disposition: undecided.** It is carried to C06 by **N-193**, to be observed with N-178's second channel, before the decision channel relies on a Claude app notification.

### UK: the [K] items

See section 3. Every [K] item the plan relies on was read on 2026-10-11. One reading answers a plan mark: **PC-37** (proposed) replaces 5.7 item 4's `[Assumption]` on the 2,000 Actions minutes. The other readings confirm plan text that carries no mark, and change nothing.

### N4: usage per run cannot be observed

- **Question and candidate** (EV-C00-012:177; 5.2). The counter-design's premise is that per-run usage is unobservable. The plan checks this in C01 #10, with an estimate fallback.
- **Disposition: settled by PC-36**, for the same reasons and on the same evidence as D24 (EV-C01-024; EV-C01-024a). The share is not observable, so capacity is worked out by estimate. A session does see its own cumulative figures.

### Q1: the fallback if U1 fails

- **Question and candidate** (EV-C00-012:182; 5.2). If U1 fails, which fallback applies (EV-010:825-830)? (a) a second machine account for the checker; (b) the checker and examiner in a private repository's Actions with Batu's subscription token; (c) Projects; (d) independence by convention only, which the counter-design does not count as solved.
- **Disposition: undecided.** U1 is undecided (above), so no fallback is chosen. Row 3's fail path is decided in C02's token design: **N-131** (2) carries Q1 by name. Of the candidates, (c) is out, because **PC-28** does not use Projects (enablement could not be checked from a session). (a) and (b) need Batu's accounts or credential; they are B4. Row 12's part is not applicable: row 12 needs no fallback beyond its own fail path (EV-C01-018 section 3).

### B4: a second machine account, or the subscription token in a private repository

- **Question and candidate** (EV-C00-012:190; 5.2). Only if U1 fails: a second machine account, or Batu's subscription token in a private repository, each with its gain, cost and alternative (EV-010:840).
- **Disposition: undecided, and a decision of Batu's if it arises.** It arises only if C02's token design or tests show that U1 fails and a fallback needing his accounts or his credential is reached. **N-131** (2) carries it with Q1 to C02, before task 3. It then goes to Batu as his decision (working order section 8; Appendix E section 3); the producer does not decide it. **D-020 (a)** answered a related question, separate Claude accounts for the environments. It did not offer B4's two options, so it does not decide B4. Nothing goes to Batu now.

## 3. UK: each [K] item, relied on or not, and its reading

The list is EV-010:800-808, which EV-C00-012:173 summarises. "Relied on" means a plan place states or uses the fact. The plan places were found by searching `plan/DevOS_Kurulum_Plani.md`, its appendices and the working order for each item's terms. Each page was read on 2026-10-11 between 18:54Z and 18:56Z. The GitHub article pages were fetched through the documentation site's article-body endpoint (`https://docs.github.com/api/article/body?pathname=…`), except the auto-merge and REST pages, which were fetched as HTML. Each reading is "documented, read 2026-10-11; not independently tested".

| # | [K] item | Relied on by the plan? | Plan place | Reading (URL; date; at most one quoted sentence) | Effect |
|---|---|---|---|---|---|
| 1 | Hook exit codes, input fields and snapshotting at startup | **Exit codes and input fields: yes.** The guard is "default deny, fail closed, never "ask"" and decides from the hook input. **The session ID** in the input: not now (D18's choice at C06 may come to rely on it). **Snapshotting: no.** No plan place relies on it; the only snapshots in the plan are of reviews and inputs | plan line 604 (`.claude/hooks/`); C01 row 9 (line 953); PC-21 item 5 (line 969) | https://code.claude.com/docs/en/hooks (fetched as `hooks.md`), read 2026-10-11. On a non-blocking error: "your hook exits with any other code, or fails in some other way, such as not starting or printing invalid JSON." The same page says the action then goes ahead; that exit 2 is a blocking error; that a hook can be set to block when it fails (`onFailure`); and it lists `session_id` among the common input fields. It has no statement on snapshotting | Confirms that fail-closed must come from the guard itself or from that setting (W-C01-38's tests). No plan change |
| 2 | The Postgres Turkish text-search configuration | **Yes** | K-6 item 3 (line 362): "a Turkish stemmer for Turkish" | https://www.postgresql.org/docs/current/textsearch-psql.html (PostgreSQL 18 documentation), read 2026-10-11. Its `\dFd` example lists `turkish_stem` as a "snowball stemmer for turkish language" | Confirms that standard PostgreSQL ships a Turkish stemmer. Whether the Supabase project has it is seen when C04 builds keyword search (not checked here). No plan change |
| 3 | Supabase Auth `app_metadata` roles and custom-role JWTs | **No.** The plan identifies roles by an environment token in a separate header, with its hash in the database; the fallback is an Edge Function gate | 6.3 "Key arrangement" (line 646); C01 row 3 (line 947) | Not read. If C02's token design (N-131 (2)) comes to rely on either mechanism, it is read there with its date (EV-C01-002 section 4(b)) | None |
| 4 | GitHub numeric user ids | **Yes** | 6.9 (line 754): the intake path "checks his numeric GitHub user id" | https://docs.github.com/en/rest/users/users ("Get a user using their ID"), read 2026-10-11: "This method takes their durable user ID instead of their login, which can change over time." Row 11 recorded both accounts' ids and the rename page (EV-C01-011:113-116), and N-157 carries them to C06 | Confirms the plan's choice of the id over the login. No plan change |
| 5a | Auto-merge under GitHub Free | **Yes** | 5.6; 6.8 items 4 and 5; line 748's marker (moved to C03 test 5 by N-150) | https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/automatically-merging-a-pull-request, read 2026-10-11: "Auto-merge for pull requests is available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server." | Availability confirmed for public `devos`. Whether it works with the session's connection stays with C03 test 5 (N-150). No plan change |
| 5b | Push protection under GitHub Free | **Not by name.** No plan place names push protection. The plan relies on secret scanning being on | criterion 27 (line 237, Batu's decision; cited, not changed); 6.7 (line 717) | For the reliance the plan has: https://docs.github.com/en/code-security/secret-scanning/introduction/about-secret-scanning, read 2026-10-11, "Public repositories: Secret scanning runs automatically for free." | Confirms the plan's secret scanning on public `devos`. No plan change |
| 6 | Actions minutes for public repositories | **Yes** | 5.7 item 4 (line 568): "the 2,000 free minutes a month", marked `[Assumption: no dated primary source recorded; …]`; 5.6's checks run in Actions on public `devos` | https://docs.github.com/en/billing/concepts/product-billing/github-actions, read 2026-10-11: "GitHub Actions usage is free for self-hosted runners and for public repositories that use standard GitHub-hosted runners." The same page's table includes 2,000 minutes a month for GitHub Free, reset at the start of each month | Answers line 568's mark: **PC-37** (proposed). C04 task 6 still reads it again with its date when the budget is calculated |
| 7 | Scheduled workflows disabled for inactivity | **Yes, as to its scope.** The plan's scheduled GitHub jobs are the hourly and daily exports and the ingestion in the private `devos-backup`, which must keep running | K-6 item 1 (line 360); 5.7 items 2 and 3 (lines 566-567) | https://docs.github.com/en/actions/how-tos/manage-workflow-runs/disable-and-enable-workflows, read 2026-10-11: "In a public repository, scheduled workflows are automatically disabled when no repository activity has occurred in 60 days." | The rule as stated covers public repositories, not the private `devos-backup`. No plan change. If a scheduled workflow is ever placed in public `devos`, this rule applies to it |
| 8 | Branches visible as soon as they are pushed | **Yes** | line 101 ("visible to everyone the moment it is pushed"); 6.7 (line 715: the leak check before writing to the public repository); Appendix C N06 | https://docs.github.com/en/repositories/creating-and-managing-repositories/about-repositories, read 2026-10-11: "Public repositories are accessible to everyone on the internet." | Supports the plan's reading. The page does not speak of a branch at the moment of its push; that it is visible at once is an inference consistent with the plan's stricter rule. No plan change |

## 4. The plan change: PC-37

`plan/decisions/PC-37.md` (`status: proposed`, `class: technical`). It changes one place: 5.7 item 4 (line 568). The `[Assumption: no dated primary source recorded; …]` on the 2,000 Actions minutes becomes a `[Verified: …]` that names this reading and keeps C04 task 6's re-reading. No figure, budget or acceptance condition changes, and no text labelled [Batu kararı] changes: 5.7's Choice is a [Proposal] (line 563).

No other row changes the plan. D24, N4, P3, P4, U5 and U6 rest on accepted plan changes: PC-21, PC-25, PC-32, PC-34 and PC-36. PC-25 and PC-32 still carry `status: proposed` in their own files, although their plan text is on `main` and their items are accepted (L-220); that is reported, not changed here.

## 5. Notes

- **New: N-193 on `plan/work/C06.md`.** It carries the rows no note named: D01's split (before C06 has the routines created); D18 and U2's unobserved hook events (before C06 fixes the liveness signal's sender and form and the closing hand-over's mechanism); and U7, with D16's counter-design candidate (with N-178, before the decision channel relies on a Claude app notification).
- **Existing notes that carry rows by name or by part, cited and not copied:** N-131 and N-136 (C02; D07, U1, U3 database side, Q1, B4; P3's credentials), N-150 (C03; U6 auto-merge), N-179 (C04; U4 Actions part), N-178 and N-190 (C06; D16 backup, U5 account part), N-145 (C01; D01 session duration, by C01's stage close), N-138 and N-139 (C05, C06; P4 applied).
- N-063 on `plan/work/C01.md` stays open until this record is accepted; its closing line is the executor's.

## 6. For Batu

Nothing now. B4 becomes his decision only if C02 shows that U1 fails and a fallback needing his accounts or credential is reached (N-131); the executor then brings it to him under working order section 8.

## 7. Summary

| Row | Disposition | C01 evidence | Plan change, or carrying note |
|---|---|---|---|
| D01 | Run limit settled; split undecided; duration undecided | EV-C01-022, -022a, -007, -024 | PC-34; N-193 (C06); N-145 (C01) |
| D07 | Undecided | EV-C01-002, -004 | N-131, N-136 (C02, before task 3) |
| D16 | Primary decided, no change; backup undecided | EV-C01-019 | PC-33; N-178, N-193 (C06) |
| D18 | Undecided | EV-C01-007, -016, -008, -001 | N-193 (C06) |
| D24 | Settled | EV-C01-024, -024a | PC-36 |
| P3 | Settled | EV-C01-002, -018, -003, -004 | PC-21, PC-32, D-020 (a); N-131, N-136 |
| P4 | Settled | EV-C01-016 | PC-21 item 5, PC-32; N-138, N-139 |
| U1 | Undecided (row 12 part met) | EV-C01-002, -018, -003 | D-020 (a); N-131, N-136 (C02) |
| U2 | Partly decided; rest undecided | EV-C01-007, -016, -008, -001 | N-193 (C06) |
| U3 | Reachability decided; mechanism undecided | EV-C01-002 | N-131 (C02) |
| U4 | Session part decided; Actions part undecided | EV-C01-020 | N-179 (C04) |
| U5 | Documentation part settled; account part and token type undecided | EV-C01-022, -022a | PC-34; N-190 (C06); N-193 (C06) |
| U6 | Settled; auto-merge undecided | EV-C01-009, -019, -018 | PC-25, PC-32; N-150 (C03) |
| U7 | Undecided | EV-C01-019 | N-193 (C06) |
| UK | Read (section 3); one mark answered | this record, section 3 | PC-37 (proposed) |
| N4 | Settled | EV-C01-024, -024a | PC-36 |
| Q1 | Undecided | EV-C01-002, -018 | PC-28 (option c out); N-131 (C02) |
| B4 | Undecided; Batu's if it arises | EV-C01-002, -003 | N-131 (C02); D-020 (a) does not decide it |

## 8. What this record cannot show

- It reads the C01 records only as far as each row needs. A part of a record not read could bear on a row, but each row's deciding section was read at its source.
- The UK readings are one fetch each, by one reader. The pages can change; plan 0.3 item 12 repeats a reading when the platform changes.
- Whether the Supabase project's Postgres has the Turkish stemmer, and whether auto-merge works with the session's connection, are not shown here (C04; C03 test 5).
