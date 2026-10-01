# Builder Operating Model (installation period)

**Version:** 1.1 · **Date:** 2026-10-01 · **Status:** [Proposal] until the independent review passes (W-C00-05, test T-E2). It becomes binding through plan change PC-04.

**History:**
- v1.0 was drafted and fixed (commit `a58413a`, SHA-256 `e37de022…afb4`) before the independent counter-design was read.
- v1.1 adds the counter-design's improvements and the probe results (§14).

**Why this exists.** Plan 2.1 designs DevOS's working structure in detail but treats the builder as "a session that executes the plan". On day one this caused five failures, all named by Batu on 2026-10-01:
1. the builder waited after every step;
2. work stayed on a branch;
3. Batu had to carry a message between chats;
4. Batu was asked a technical approval question;
5. rules were added piecemeal.

This document designs the builder's operating model as a whole. Every mechanism names the problem it solves, the assumption it rests on, its cost and how it fails (plan 6.12).

**Scope.** Installation (C00–C12). Once a DevOS component exists and is tested (for example the audit environment from C03, or routines from C06), it takes over the matching part of this model.

**Main insight (frame review, from the counter-design).** Most of the five failures were not missing automation. The builder did not know it was *allowed* to proceed. The decision-routing rule in §6 matters more than any continuity mechanism: **if a perfect engineer would not need Batu's preference to answer a question, it is not Batu's question.**

---

## 1. Premises

| ID | Premise | Origin | Status |
|---|---|---|---|
| BP-01 | Batu is not a message carrier. He decides only his own matters and sees status without asking. | Batu, 2026-10-01 | requirement |
| BP-02 | `main` of `devos` is the only source of truth; a conversation or a branch is not memory. | plan D7; PC-03 | design choice |
| BP-03 | A session whose first message is `/goal <condition>` runs under that goal, even when another session created it. | T-A1a, T-A1c (observed) | observed |
| BP-04 | Sessions created by the builder with `create_session` carry no account connectors. | T-A1c: the session's own report listed only the GitHub server and the session tools | observed (self-report) |
| BP-05 | Routine sessions created through the session tool carry no connectors and no tools at all, have no repository, and **run on a smaller default model** (Sonnet), not the configured one. | T-A1b (observed) | observed |
| BP-06 | Permission rules and hooks in `.claude/settings.json` are enforced by the harness. | T-H1, T-H2 (observed) | observed |
| BP-07 | Separate sessions give thinking independence, not authority independence (same model family, same account). | plan K-7 | design limit |
| BP-08 | The weekly usage limit is shared with Batu. Its status is readable from any session record; the fraction used is not. | observed | observed |
| BP-09 | Batu receives GitHub notifications on his phone from issues where the machine account mentions or assigns him. | plan 5.5 and 6.9; EV-C00-002 item 14 | documented; tested by T-D1 |

---

## 2. Continuity: runs, lease, dispatcher (A)

**Problem.** Work stopped until Batu typed (failures 1 and 5).

### 2.1 Runs

- Work happens in **runs**. A run is a builder session created with `create_session` on `devos` `main`, with the configured model passed explicitly (`claude-opus-5-5`; BP-05), and a first message `/goal <run template>` (Appendix R1).
- A run takes work items from the work list (§4) in priority order. It ends at the first of these stop conditions:
  - **S1, stage done:** all items are done, the closure review has passed, and everything is merged.
  - **S2, Batu:** the only remaining items need Batu, and his batch has been sent (§6).
  - **S3, blocker:** a blocker the builder cannot pass, including a loop limit or no progress (§4.4).
  - **S4, hand-over:** the context is over 50% used, or a natural boundary where a fresh context is better.
  - **S5, usage hold:** the usage policy (§8) requires waiting.
- **Successor.** At S4, and at S1 when the next stage can start, the run's last act after merging is to create its successor run. At S5 it schedules a one-shot wake-up instead (§2.3). Batu types nothing.

### 2.2 Lease

- The state file `plan/ledger.md` has a **Run lock** row: the holder's session ID, plus an expiry of the last checkpoint plus 3 hours, renewed at every checkpoint merge.
- A booting session treats the lease as live if it has not expired **and** `get_session` shows the holder working. Otherwise it may take over.
- Two sessions taking over at once collide on the lease row when they merge. Git serialises the merges, so the loser exits.

### 2.3 Dispatcher and heartbeat

- **Why a dispatcher:** routine sessions have no tools, no repository and a smaller model (BP-05), so a routine cannot do builder work or even start a run.
- **Dispatcher session:** a small, long-lived session created by the builder, with `devos` checked out and the configured model. Its only job is the **dispatch check**:
  - read `main`;
  - if the lease is stale, work is pending, nothing is waiting for Batu, and usage allows, start a run;
  - otherwise update the heartbeat line in `DURUM.md`.
- **Heartbeat:** a recurring routine bound to the dispatcher session (`persistent_session_id`), every 6 hours. It is created through the tool, so it carries no connectors.
- **Usage-limit waits:** one-shot wake-ups (`send_later`) into the dispatcher at the reset time plus 15 minutes.

**Assumptions.**
- A recurring routine that fires into an existing session delivers a message there. This is documented; whether it counts toward the 15 daily runs is unknown, which is a C01 row 5 item. At most 4 runs per day are used.
- The dispatcher's context grows slowly. It is replaced by a fresh dispatcher when its context exceeds 30%.

**Cost.** About 4 short dispatcher turns per day; run boot reads of about 30–60k tokens.

**How it fails, and what catches it:**

| Failure | What catches it |
|---|---|
| A run dies without a successor | The next heartbeat, within 6 hours |
| The dispatcher dies | Runs recreate it when missing (boot step 7). `DURUM.md` shows the last heartbeat time, so Batu sees silence without asking. |
| The heartbeat routine is disabled | Same visibility; the next run recreates it |

**Rejected:**
- *Claude Code Projects:* availability unknown, no authority separation, not needed. Reconsider at C01 row 14.
- *Batu typing `/goal`:* replaced, since self-start is observed.
- *A heartbeat every 2 hours:* 12 routine runs a day would crowd out the routine budget DevOS needs from C06 and spend shared usage; 6 hours is enough for a resume latency that Batu does not watch.
- *Pure routine-started runs:* wrong model and no tools (BP-05).

---

## 3. Memory and a single source of truth (B)

### 3.1 Boot (every session, in this order)

`CLAUDE.md` at the repository root points every session to this list, so even a session started with only "continue" boots correctly.

1. `plan/Builder_Operating_Model.md` §3 (this procedure) and Appendix R1.
2. `plan/ledger.md`, the **state file**: current state, run lock, work list, open items, decisions index.
3. The lease: continue, take over, or exit (§2.2).
4. The latest stage digest (`plan/ledger/<stage>-digest.md`, written at closure), then the log entries of the current stage since the last hand-over entry (`plan/ledger/<stage>-log.md`).
5. `DURUM.md`, which must agree with the state file. On disagreement the state file wins, and the mismatch is recorded as a finding.
6. Batu's answers: comments by Batu's GitHub account (`batuhanozgun`) on the "Batu'dan beklenenler" issue. Comments from any other account are ignored and noted (§6).
7. If the dispatcher or the heartbeat is missing, recreate it (§2.3).
8. The plan sections the next work item names, read in full (D8).

The session states what it found (one paragraph in its log entry) before it acts.

### 3.2 `main` and the working branch

- **Record PRs** (state file, log, evidence, `DURUM.md`) are merged at once.
- **Change PRs** (anything a work item produces) are merged when the item's acceptance condition is shown with evidence. If the change is high-impact, a review PASS is also required (§5).
- **Checkpoint:** after each finished item, and before any stop, everything is merged. Nothing stays unmerged across a stop (PC-03).
- **Boot check:** list unmerged `claude/` branches of `devos`. Merge each one, or record it as abandoned with a reason.

### 3.3 Files and keeping the ledger from sprawling

| File | Role | Rule |
|---|---|---|
| `plan/ledger.md` | State file | Short, and rewritten to stay current. Closed items move to the log. |
| `plan/ledger/<stage>-log.md` | Log entries `L-nnn` | Append-only. A single writer at a time is guaranteed by the lease. |
| `plan/ledger/<stage>-digest.md` | Stage digest: decisions, plan changes, open risks | Written at stage closure; boot reads digests instead of old logs |
| `evidence/<stage>/` | Evidence records `EV-…` | One file per claim |
| `DURUM.md` | Turkish status page for Batu (§7) | Rewritten at every checkpoint |
| `CLAUDE.md` | Boot pointer for every session | Short; replaced by the common rules of plan Appendix D at C05 |

**Rejected:** one file per log entry, as the counter-design proposed. The lease already removes concurrent writers, and one file per stage is easier for a reader to follow. Reconsider if conflicts appear.

### 3.4 Compaction, and the `/goal` evaluator seeing only the conversation

- **Write-ahead:** before a long step, its intent and its acceptance check are committed. After a compaction, the session re-runs boot steps 2–5 instead of trusting its summary.
- **Hand-over at 50% context** (S4) keeps compaction rare.
- **Stop report:** the run pastes the unedited output of `tools/builder_check.sh`, which checks a clean tree, no unmerged commits, the required files on `main`, `DURUM.md` being current and the run lock row. It adds the stop condition and the evidence IDs. The run template (R1) says the goal is met only when that output ends in `BUILDER_CHECK PASS` and a stop condition is named. So the evaluator judges machine output, not a claim.
- **A met goal ends a session; it never marks anything done.** "Done" is set only in the state file, with evidence (§4.3).

---

## 4. Work tracking (C)

1. **Work list.** At stage start, the first work item splits the stage's tasks and acceptance conditions into items `W-<stage>-nn`. Each item has: acceptance condition, dependencies, impact class (normal or high), Batu needs, status, evidence. The list is merged **before** any change work on its items: git order proves the conditions came first.
2. **Priority.** First, plan dependency order. Then, items that produce Batu needs, so his batch goes out early. Then, items that retire the riskiest assumption (probes before builds). Then, heavy items, scheduled under the usage policy.
3. **Done.** An item is done when its acceptance condition is shown with an evidence record, review PASS is in hand if high-impact, and it is merged. A stage is done when every item is done and the closure review has passed. Changing an acceptance condition after work started is a high-impact change and needs a review PASS.
4. **Loop limits.** Each item states an effort budget in runs. Two consecutive checkpoints with no progress on the same item, or an exceeded budget without a recorded reason, stops the run with S3.
5. **Process overhead check.** At stage closure the closure review reports the share of runs and items that were process (records, reviews, heartbeats) rather than stage work. Above about a quarter, it is flagged as a finding. This guards against process becoming its own goal (plan K-10).

---

## 5. Independence and quality (E)

| What | Reviewer | When |
|---|---|---|
| High-impact change: rules, roles, schema, security settings, `.claude/**`, `CLAUDE.md`, this document, the review prompt, acceptance-condition changes | Review session | Before merge |
| Stage closure | Closure-review session that did no work in the stage; it also asks whether the stage achieves its purpose in the plan, not just its item list | At S1 |
| C00 specials: translation fidelity, plan review, DevOS counter-design | Separate sessions with restricted input | Per stage |
| Non-binding checks during work | Fresh-context subagents (label: thinking independence, same session) | Any time |

- **How a review starts.** The builder calls `create_session` with the fixed prompt in `plan/builder/REVIEW_PROMPT.md`, filled with the review ID, the target (PR or files), the criteria and an output path. The template is high-impact, so softening it needs a review.
- **How the result arrives.** The reviewer commits `evidence/<stage>/reviews/<ID>.md` to its own branch `claude/review-<ID>`, with verdict PASS, FAIL or PASS-WITH-CONDITIONS and reasons. It cannot see the builder's conversation. The builder fetches the branch (in the same run, or a later run at boot), merges the verdict file in a record PR, and writes a disposition for every finding. Batu carries nothing.
- **Disagreement.** The builder may answer in a file; a second, fresh reviewer decides. Only a disagreement about purpose or scope goes to Batu.
- **Recorded independence:** same model family, separate session, restricted input. This is thinking independence (BP-07). From C03, the audit environment's verdicts replace review sessions for binding approvals.

---

## 6. Decision routing (D)

| Class | Who decides | Examples |
|---|---|---|
| Technical, normal | Builder, with a log entry | file layout, item split, scripts, ordering |
| Technical, high-impact | Builder proposes; **independent review approves** (PC-05) | `.claude/**`, schema migrations, roles, this document |
| Batu's | **Batu** | purpose, scope, money or paid features, his accounts and his other work (including how much shared usage the builder may spend), acceptance of results (for example C07 value, C12 handover) |

**Test for "is it Batu's?":** would a perfect engineer still need Batu's preference to answer it? If not, it is not his.

**Channel.**
- **One** GitHub issue, "Batu'dan beklenenler", opened by the machine account and assigned to Batu.
- Each batch is a comment that mentions him. It contains numbered decisions in Appendix E §3 format (Turkish) and numbered account actions, given step by step.
- He answers in the issue. Only comments by `batuhanozgun` count (the repository is public). Answers go into the log verbatim, with the English interpretation.
- An answer given in a builder chat is also accepted and recorded.

**Batching.** Batu's needs collect in the state file. They are sent when one becomes blocking, or once per stage, whichever comes first. A run never waits on one Batu item while other work is possible.

**Silence.** Plan Appendix E §8 applies: one reminder through the second channel after 24 hours (4 hours if work is blocked). Silence is never approval. A stated default applies only if it is reversible and free.

**Numbering (J).**
- `K`/`B` numbers are Batu's formal decisions only (K1–K9, B1–B3). New Batu decisions are recorded as `D-nnn` decision records, owner Batu.
- The builder's plan changes are `PC-nn`, with Batu's own parts marked "[Batu, date]".
- Renumbering: K10 becomes PC-01, K11 becomes PC-02 (with its correction), the continuity rule becomes PC-03, this model PC-04, and the approval clause PC-05.

---

## 7. Status page (expectation 5)

`DURUM.md`, Turkish, at most about 20 lines, rewritten at every checkpoint. It shows:
- the stage and the active run;
- the time of its last update and of the last heartbeat;
- what was done last (up to three items);
- what comes next;
- **what is expected from Batu**: "nothing", or a link to the issue;
- usage status;
- up to two risks.

Boot step 5 checks it, and `builder_check.sh` checks that it is not older than the ledger.

---

## 8. Usage and capacity (G)

- **Read** `rate_limit_info` at boot and before each heavy item, and record it in the state file.
- **Standing policy.** This is Batu's decision D-002; the default below applies until he answers.
  - `allowed`: proceed; review sessions may run in parallel (at most 2).
  - `allowed_warning`: one session at a time, light items only, and heavy items wait for the reset.
  - `rejected`, or a session failing on the limit: S5, and a wake-up at the reset time plus 15 minutes.
  - Heavy work is preferably started between 23:00 and 08:00 Turkey time.
- **Informing Batu.** `DURUM.md` always shows the status. Batu gets a decision only if a choice would affect his own use beyond D-002.
- **Record.** Each run's hand-over entry logs the usage status and the session's reported cost figure, as a relative measure only.

---

## 9. Security (H)

Three layers, each enforced outside the model:

1. **Structural.** Runs, reviewers and the dispatcher are created through the session tool, so they carry no account connectors (BP-04). Routines carry none either (BP-05).
2. **Harness.** `.claude/settings.json`:
   - (a) deny rules for every known account connector (observed effective, T-H1);
   - (b) a `PreToolUse` hook, `.claude/hooks/tool_allowlist.py`, that allows only the GitHub tools, the session tools and the read-only Supabase tools, and blocks every other `mcp__*` tool, including connectors added later. It is observed effective (T-H2), and a broken hook fails closed.
3. **Database.** The builder's Supabase role is read-only (observed).

**Residual risks:**
- A session can edit its own `.claude/**`. Such changes are high-impact: review before merge, and visible in git.
- Write access to the library repository is still protected by a rule only (L-003).
- Sessions Batu opens himself outside `devos` are outside this barrier.

---

## 10. Thinking discipline (F)

| Discipline | How it applies to the builder |
|---|---|
| D1 Decision-critical assumptions | Each work item lists the assumptions it depends on; probes come first (§4.2) |
| D2 Free of non-evidential pressure | Batu's approval, urgency and the `/goal` verdict are never evidence. Batu's suggestions are weighed, not obeyed as facts. |
| D3 Goal alignment | The closure review asks the purpose question; `DURUM.md` states the stage purpose |
| D4 Verification validity | Conditions come before results; reviewers re-run checks; the closure reviewer did not do the work |
| D5 Source vs. view | Every statement is labelled observed, documented or assumed (ledger rule 4) |
| D6 Causal depth | Every failure gets a cause analysis; a repeated cause becomes a plan change |
| D7 Continuity | §2–§3 |
| D8 Pre-work state | Boot (§3.1); the session states what it found before acting |
| D9 Library use | Design items name the library notes they consulted, or say "none relevant" |

The trigger check of the nine questions is recorded as one line per work item when the item starts.

**Frame review of this model.** The premises are in §1. The counter-design is the first frame test (§14). A second mechanism proposed for a problem one mechanism already covers is a squeeze signal and needs a frame review first.

---

## 11. Failure handling (I)

| Failure | Detection | Response |
|---|---|---|
| Session dies | Lease expiry plus `get_session` | Dispatcher or the next run takes over; work since the last checkpoint is redone |
| Branches diverge | Boot branch listing; merge conflict | Merge `main` into the branch (no rebase on shared branches); otherwise record the branch as abandoned |
| Ledger conflict | Merge conflict on the state file | Regenerate the state file from `main`'s log and evidence; log a finding |
| Wrong "goal met" | The check output is missing or FAIL at the next boot; the closure review | Reopen the item; log a finding; tighten R1 |
| Batu silent | Issue older than 24 hours (4 if blocking) | One reminder; continue unblocked work; `DURUM.md` puts it in its first line |
| Usage limit | Status at boot; failed session | S5, a wake-up at the reset time; `DURUM.md` shows the hold |
| Reviewer never delivers | No commit on its branch after 2 hours | One replacement reviewer; a second failure is S3 |
| Classifier denial | Tool error | Record it; try a compliant route; otherwise mark the item blocked with the exact denial |
| Dispatcher or heartbeat lost | Boot step 7; `DURUM.md` heartbeat age | Recreate it |

---

## 12. What changes for Batu

- He types no commands.
- He reads `DURUM.md` for status.
- He answers only in the "Batu'dan beklenenler" issue, which arrives as one batch, step by step.
- He gives no technical approvals.
- He decides only his own matters; the first is D-002, the standing usage policy.

---

## 13. Tests (acceptance written before results)

| ID | Claim | Acceptance | Result |
|---|---|---|---|
| T-A1a | A builder-created session can run under `/goal` | Goal set and evaluated in the session record | **PASS** (`session_018kpRnAaG9R3vaRTg5wMyye`) |
| T-A1b | A tool-created one-shot routine starts a goal session with no connectors | Goal set; the session reports no connector servers | **PASS**, with a finding: the routine session ran on a smaller model and had no tools or repository (BP-05) |
| T-A1c | A builder-created session has no account connectors | The session's own list shows no mail, calendar or file servers | **PASS** (self-report: the GitHub server and the session tools only) |
| T-H1 | Repository deny rules remove connector tools | The tools become unavailable in the running session | **PASS** |
| T-H2 | The allowlist hook blocks non-listed MCP tools before execution and allows listed ones | A temporary hook blocked `mcp__github__get_me`; with only the allowlist hook installed, the same call succeeded. Unit inputs: three blocked, five allowed, unreadable input blocked. | **PASS** |
| T-E1 | A review session's result reaches the builder through the repository | The counter-design file was fetched from `claude/counter-design-builder-model` with no involvement from Batu | **PASS** |
| T-E2 | An independent review of this model returns through the repository and is acted on | The verdict file is on its review branch; a disposition is written for every finding | pending |
| T-B1 | A new session continues correctly from `main` alone | A fresh session started with only "continue" boots via `CLAUDE.md`, and names the next action pre-registered in `evidence/C00/EV-C00-005` before the test, without doing other work | pending |
| T-A2 | Work continues without Batu typing | The dispatcher, triggered by a one-shot routine, runs the dispatch check and records its decision in the repository | pending |
| T-D1 | Batu's channel works | The issue exists and is assigned to Batu; the machine account's mention produces a notification. Only Batu can confirm receipt, so this is checked with his first answer. | pending |

---

## 14. Counter-design comparison

The counter-design (`briefs/builder-operating-model/COUNTER_DESIGN.md`, commit `73baa5a`, written by a session that saw only the brief) converged with v1.0 on the core:
- self-started goal sessions;
- a liveness lock;
- `main` as the only memory, with merges at every checkpoint;
- a Turkish status page;
- one GitHub channel for Batu;
- review results through branches;
- a separate prefix for plan changes;
- a harness-level connector barrier.

| Difference | Counter-design | v1.0 | Disposition in v1.1 |
|---|---|---|---|
| What fixes the failures | Permission to proceed (decision routing) more than automation | Continuity first | **Adopted** as the main insight and the "perfect engineer" test |
| `/goal` evidence | The goal is met only with a pasted check-script output | A stop report with git output | **Adopted:** `tools/builder_check.sh` and R1 |
| Boot entry | `CLAUDE.md` points to boot, so a session started with "continue" works | Boot listed only in this document | **Adopted** |
| Lease | Expiry plus liveness; git as the lock | Run lock without expiry | **Adopted** |
| Heartbeat | Recurring routine every 2 hours doing the work | Daily routine doing the work | **Changed after probes:** routine sessions cannot work (BP-05), so a dispatcher session receives the heartbeat every 6 hours |
| Connector barrier | Allowlist hook (connector names are opaque) | Deny list | **Adopted both:** deny list plus allowlist hook (T-H1, T-H2) |
| Ledger | One file per entry plus digests | One log per stage | **Digest adopted**; one file per entry rejected (the lease removes concurrent writers; readability) |
| Batu channel | One pinned issue with batch comments | One issue per batch | **Adopted** (simpler for Batu) |
| Review prompt | Fixed template file, high-impact | Ad hoc prompts | **Adopted:** `plan/builder/REVIEW_PROMPT.md` |
| Disagreement | Second fresh reviewer | Not covered | **Adopted** |
| Record vs. change PRs | Distinguished | Not distinguished | **Adopted** |
| Process overhead | Flag it if over about a quarter of the work | Not covered | **Adopted** (§4.5) |
| Usage | A standing usage policy decided once by Batu | Inform at the first warning | **Adopted** as D-002 |
| Item granularity | One leg per item | A run per several items, hand-over at 60% | Middle ground: hand-over at 50% or at natural boundaries |
| Model of runs | Not covered | Not covered | **New from the probes:** always pass the configured model explicitly |

Reading v1.0 against the counter-design shows v1.0's main blind spot: it treated Batu's failures as a continuity problem. The counter-design framed them as a problem of permission to act. Both are needed; v1.1 states the second first.

---

## Appendix R1 · Run template

```text
/goal You are a DevOS builder run on the devos repository. Follow the boot in plan/Builder_Operating_Model.md section 3.1, take or confirm the lease in plan/ledger.md, then work through the work list by priority, merging into main at every checkpoint. Stop at the first stop condition S1-S5 of section 2.1. This goal is met only when your last message names the stop condition, lists the evidence IDs of items closed in this run, and contains the unedited output of tools/builder_check.sh ending in BUILDER_CHECK PASS. Before stopping, update DURUM.md and start the successor run or schedule the wake-up if section 2 requires it. Never use account connectors. Batu's silence is never approval.
```

## Appendix R2 · Dispatch check (dispatcher session, on each heartbeat)

```text
Dispatch check. Read devos main: plan/ledger.md (run lock, work list, waiting-for-Batu, usage) and DURUM.md. Check the lease holder with get_session. Start a run (create_session on devos main, model claude-opus-5-5, first message: Appendix R1) only if: the lease is stale, work is pending, nothing blocking waits for Batu, and the usage status allows it under section 8. Otherwise start nothing. In both cases update the heartbeat line in DURUM.md through a record PR, and log one line of your decision.
```
