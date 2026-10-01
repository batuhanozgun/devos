# Builder Operating Model (installation period)

**Version:** 1.0 draft · **Date:** 2026-10-01 · **Status:** [Proposal], to be tested (Section 13) and compared with the independent counter-design (Section 14) before it becomes binding through plan change PC-04.

**Why this exists.** Plan 2.1 designs DevOS's working structure in detail but treats the builder as "a session that executes the plan". The builder is itself a working system. Without an operating model, the first day produced five failures (Batu, 2026-10-01): the builder waited for Batu after every step; work stayed on a branch instead of reaching `main`; Batu had to carry a message between chats; the builder brought Batu a technical approval question; and working rules were added piecemeal (K10, K11, now PC-01, PC-02). This document designs the builder's operating model as a whole, to the standard the plan applies to DevOS: every mechanism names the problem it solves, the assumption it rests on, its cost and how it fails (plan 6.12).

**Scope.** Installation period only (stages C00–C12). From C06 onward, DevOS's own working structure (plan 6.3–6.5) takes over the parts it covers. Where the two overlap, the plan wins once the DevOS component exists and is tested.

---

## 1. Premises

| ID | Premise | Origin | From-scratch test |
|---|---|---|---|
| BP-01 | Batu is not a message carrier, decides only his own matters, and must see status without asking. | Batu, 2026-10-01 (expectations 1–5) | Yes: these are requirements, not choices |
| BP-02 | The single source of truth is the `devos` repository's `main` branch. A conversation, a branch or a session's memory is never the source of truth. | prior design (plan D7, K-8) + PC-03 | Yes. A database becomes the live state from C02 on, but the installation records stay in the repository until the ledger transfer. |
| BP-03 | A builder session started by the builder itself, with a first message `/goal <condition>`, runs under that goal without Batu typing. | observed (probe T-A1a) | Yes |
| BP-04 | Fresh sessions are cheaper and safer than one long session: long sessions get compacted and can lose detail. | documented (plan K-7 item 4; research on long-running agents) | Yes |
| BP-05 | Project permission rules in `.claude/settings.json` are enforced by the harness, not the model. | observed (Section 9: the deny rules removed the connector tools from this session at once) | Yes |
| BP-06 | Separate sessions give thinking independence (fresh context, chosen inputs), not authority independence; they run on the same model family. | prior design (plan K-7) | Yes. Authority independence arrives with the audit environment in C02–C03. |
| BP-07 | The weekly usage limit is shared with Batu's own use; its status is readable from any session's record, but the fraction used is not. | observed | Yes |
| BP-08 | GitHub is the only channel Batu reliably sees on his phone, besides the Claude app. | plan 5.5 and 6.9 (decision channel), Batu confirmed the phone apps (EV-C00-002) | Yes |

---

## 2. The run: the unit of continuous work (A)

**Problem.** The builder stopped after each step and waited; continuing depended on Batu typing (failures 1 and 5).

**Mechanism.**

1. Work happens in **runs**. A run is a builder session whose first message is `/goal <run condition>` (Appendix R1 gives the template). The run works through the work list (Section 4) until one of the stop conditions holds:
   - **S1: stage done.** Every acceptance condition of the stage is shown with evidence, the closure review has been requested, and everything is merged.
   - **S2: blocked on Batu.** Every item the run can still do is done, and the rest needs Batu. His items are batched into one request (Section 6).
   - **S3: blocker.** A blocker the builder cannot pass, or the loop limit (Section 4.4) is reached.
   - **S4: hand-over.** The context is more than 60% used, or the work list says a fresh context is better for the next item. The run then starts its successor (item 2).
   - **S5: usage hold.** Under the usage policy (Section 8) the remaining items must wait for the reset.
2. **Starting the next run.** The builder starts its own successor; Batu types nothing.
   - Immediately: `create_session` on `devos` `main` with the run template (observed: T-A1a).
   - Later, for example after a usage reset: a one-shot `send_later` wake-up or a one-shot trigger. Both are observed to exist; one-shot runs are reported not to count toward the 15 daily routine runs.
3. **Safety net (watchdog).** One recurring routine, created through the session tool so that it carries no connectors (observed: T-A1b), runs once a day at 03:30 Turkey time. It checks four things: a run is supposed to be active, no session holding the run lock is alive, nothing is waiting for Batu, and the usage status allows work. If all four hold, it starts a run. Otherwise it only updates the status page. Cost: 1 of 15 daily routine runs.
4. **Run lock.** `plan/ledger.md` "Current state" holds the active run's session ID. A new run starts only if that session is not running, which is checked with `get_session`. This prevents two builders from writing at once (single-writer rule).

**Assumptions.** Self-started goals work (BP-03, observed); tool-created triggers carry no connectors (observed in configuration; T-A1b result in Section 13); one-shot runs do not count toward the routine limit (documented, unverified).

**Cost.** Each run re-reads the start set (Section 3.1), about 30–60k tokens. A daily watchdog session costs a little usage even when it finds nothing to do.

**Failure modes.** A run dies without starting its successor: the watchdog resumes within a day. The `/goal` evaluator judges "met" wrongly: the stop report (Section 3.4) and the closure review catch it, because a met goal is never acceptance. Two runs alive at once: the run lock and the single-writer rule; on conflict, the later run stops.

**Rejected alternatives.**

- *One long session that Batu keeps open.* It depends on Batu and on compaction.
- *Claude Code Projects.* Its availability on Batu's account is unknown, it gives no authority separation (plan 5.2), and the run chain already covers coordination. It will be reconsidered after C01 row 14.
- *Batu typing `/goal` at each stage* (the original PC-01). Replaced, because self-start is observed to work.

---

## 3. Memory and a single source of truth (B)

### 3.1 Start procedure (every run, in this order)

1. `plan/Builder_Operating_Model.md` §3 (this procedure) and Appendix R1.
2. `plan/ledger.md`: current state, run lock, work list, open items, pending Batu items. This is the **state file**: short and always current.
3. The last log entries of the current stage (`plan/ledger/<stage>-log.md`), back to the previous run's hand-over entry.
4. `DURUM.md`. It must agree with the state file; if not, the state file wins and the disagreement is a finding.
5. Batu's answers: the decision issues on GitHub (Section 6) and any chat message in this run.
6. The plan sections named by the next work item, read in full (D8; a summary does not replace the mandatory reading).

**Problem it solves:** a new session must continue correctly from `main` alone (Batu's test 3a).

### 3.2 Closing the gap between `main` and the working branch

- Each run works on its own branch from `main`.
- **Checkpoint:** after every finished work item, and before every stop, the run commits, opens a pull request and merges it into `main` (PC-02, PC-03). A run never stops with unmerged work.
- The branch is deleted once its last merge is done, except a session's harness-designated branch, which is reset to `main` and deleted when that session ends.

**Assumption:** the builder can merge its own pull requests (observed: devos#1–#3). G-015 records that this means no GitHub-level review is enforced.

### 3.3 Keeping the ledger from sprawling

| File | Content | Rule |
|---|---|---|
| `plan/ledger.md` | State file: current state, run lock, work list of the current stage, open items, pending Batu items, index of decisions and plan changes | Kept short. Closed items move to the log. |
| `plan/ledger/<stage>-log.md` | Append-only log entries (L-nnn) of that stage | Never rewritten; corrections are new entries |
| `evidence/<stage>/` | Evidence records (EV-…) | One file per claim |
| `DURUM.md` | Turkish status page for Batu (Section 7) | Rewritten at every checkpoint |

### 3.4 Context compaction, and the `/goal` evaluator seeing only the conversation

- **Write before proceeding.** No decision, result or finding exists until it is written to the state file, a log entry or an evidence record and merged. A run never relies on conversation memory older than its last checkpoint.
- **Hand-over at 60% context (S4),** before compaction is likely.
- **Stop report.** At every stop the run prints a fixed block into the conversation, so the evaluator judges from evidence rather than from claims: the stop condition (S1–S5); the work items closed in this run, with evidence IDs; the output of `git fetch && git status && git log origin/main -1`; and a check that the branch has no commits ahead of `main`.
- **A met goal is not acceptance.** Stage acceptance needs the independent closure review (Section 5).

---

## 4. Work tracking (C)

1. **Work list.** When a stage starts, the builder converts its "Yapılacaklar" and acceptance conditions into a work list in the state file: `W-<stage>-nn`, item, acceptance condition, dependencies, status (todo / doing / done / blocked-Batu / blocked), evidence. Acceptance conditions are written and merged **before** work on the item starts (plan 8.6, Section 9).
2. **Priority.** First, items that resolve the largest uncertainty with the highest cost of being wrong (plan Section 9 ordering principle). Second, items that create Batu actions, so his list is ready early and goes out as one batch. Third, heavy items, which are scheduled under the usage policy.
3. **Done.** An item is done when its acceptance condition is shown with an evidence record and merged. A stage is done when every item is done and the independent closure review has passed.
4. **Loop limits.** Each item has an effort budget, as a rough number of runs or hours stated at start. The run stops (S3) if two consecutive checkpoints show no progress on the same item, or the budget is exceeded without a documented reason.

---

## 5. Independence and quality (E)

| What | Who reviews | When | How the result reaches the builder |
|---|---|---|---|
| High-impact changes: rules, roles, schema, security settings, `.claude/settings.json`, plan changes that alter a guarantee | A separate **review session** that sees only the change, the criteria and the sources, not the builder's reasoning | Before merge | It commits a review file to its own branch `claude/review-<topic>`; the builder fetches that branch. Batu carries nothing. |
| Stage closure | A **closure review session** that did not do the stage's work | At S1 | Same route; the stage is closed only on a pass |
| C00 specials: translation fidelity, plan review, counter-design | Separate sessions with restricted inputs (sparse checkout, a brief) | As the stage requires | Same route |
| Non-binding checks during work | Fresh-context subagents | Any time | In-session; labelled "thinking independence, same session" |

- Review sessions are started by the builder (`create_session`) and inherit the repository's deny rules. Their input restriction is a sparse checkout plus an instruction; that restriction is at instruction level, and it is recorded as such.
- Independence level is recorded in every evidence record. Until the audit environment exists (C02–C03), technical approval comes from review sessions: same model family, thinking independence only (BP-06). From C03 on, the audit environment's verdict replaces them for binding approvals.
- Every review finding gets a written disposition (accepted, accepted in part, rejected, each with a reason).

---

## 6. Decision routing (D)

| Decision type | Who decides | Example |
|---|---|---|
| Technical design, tools, sequencing, technical plan changes | Builder, with written reasons | This document; the migration path (G-004) |
| Technical approval of high-impact changes; stage closure | Independent review session; from C03 the audit environment | `.claude/settings.json` changes |
| Purpose, scope, cost or paid features, choices affecting Batu's accounts or other work (including usage pacing that affects his own use), acceptance of results (for example C07 value, C12 handover) | **Batu** | D-001 |

**Format and channel for Batu:**

- Every Batu decision follows Appendix E §3: question, why it is his, options with purpose, benefit and cost, recommendation, what he needs to know, and what happens if he does not answer.
- It is opened as a **GitHub issue assigned to Batu** by the machine account (plan 6.9; notifications reach his phone), with the Turkish text in the issue and the English record in the ledger.
- Batu answers in the issue; the next run reads the answer and checks that the author is Batu's account. An answer given in a builder chat is also accepted and recorded.
- **Batching:** everything Batu must do, decisions and account actions, is collected into one issue per batch with numbered steps. A run never waits on a single Batu item while other work is possible.

**Plan change numbering (J):** K-numbers are Batu's formal decisions (K1–K9, B1–B3) only. The builder's plan changes are **PC-nn**. Inside a plan change, the parts that are Batu's own decisions are marked "[Batu, date]", with his Turkish words in the log. Renumbering: K10 → PC-01, K11 → PC-02 (including its correction), the continuity rule → PC-03, this operating model → PC-04, and the approval clause (Batu's expectation 2) → PC-05.

---

## 7. Status page (Batu's expectation 5)

`DURUM.md` at the repository root, in Turkish, at most about 25 lines, rewritten at every checkpoint. It contains:

- current stage and run, and when it was last updated;
- what was done last (three items at most, plain words);
- what comes next;
- **what is expected from Batu**: "nothing", or a link to the open issue;
- usage status (normal / warning / hold until …);
- known risks Batu should know about (two at most).

The start procedure checks it against the state file (Section 3.1). A stale page is a finding.

---

## 8. Usage and capacity (G)

- **Reading.** Before every run, and before every heavy item, the builder reads `rate_limit_info` from its own session record.
- **Policy:**
  - `allowed`: proceed.
  - `allowed_warning`: light items only, unless Batu has decided otherwise for that week (D-001 standing rule).
  - `rejected`, or a session failing on the limit: stop with S5 and schedule a one-shot wake-up at the reset time plus 15 minutes.
- **Timing.** Heavy items (translation, review sessions, large reads) run in Turkey night hours (00:00–07:00) where possible, to reduce contention with Batu's daytime use, including the 5-hour limit.
- **Record.** Each run's hand-over entry logs the usage status and the session's reported cost figure (a relative measure only).
- **Informing Batu.** `DURUM.md` always shows the status. Batu gets a decision only when a choice affects his own use: the first warning of a week, or a hold longer than two days.

**Assumption:** the session record's status reflects the shared account limit (observed in several sessions: same `resetsAt`). The fraction used cannot be seen.

---

## 9. Security (H)

1. **Connector barrier, enforced by the harness.** `.claude/settings.json` denies every account connector except the GitHub tools, the session tools and the read-only Supabase connector: mail, calendar, drive, docs, Gamma, Figma, Wispr Flow, RankedIn, Granola and Context7.
   - **Observed:** writing the rules removed those tools from the running session immediately ("Denied by a permission rule").
   - Every session started on `devos` loads the same file.
2. **Routines** are created only through the session tool; the observed configuration stores no connectors.
3. **Supabase:** the builder's connection is read-only at database level (observed, EV-C00-002 item 7).
4. **Residual risks:**
   - A session can edit `.claude/settings.json` itself, because the rule file lives in the repository. Changes to it are high-impact: they go through a pull request with a review session, and any change is visible in git history.
   - GitHub write access to the library repository remains a rule (L-003).
   - Sessions Batu opens himself outside `devos` are outside this barrier.

---

## 10. Thinking discipline (F)

- At the start of each work item the builder runs the nine trigger questions (Appendix D) and records the result as one line in the work-list row, for example `D: 1,3,4,5,7,8 loaded; 2,6,9 not triggered`.
- **D8** is the start procedure; **D7** is the checkpoint rule; **D4** governs the review table; **D2** applies especially to Batu's own suggestions, which are weighed and not adopted because he said so.
- **D9:** design items consult the library: search the catalogue first, read selectively.
- **Frame check on this model.** This model's premises are listed in Section 1. If a second mechanism is ever proposed for a problem one mechanism already addresses, that is a squeeze signal: the builder writes a frame review before adding it (plan 6.12). The counter-design (Section 14) is this model's first frame test.

---

## 11. Failure handling (I)

| Failure | Detection | Response |
|---|---|---|
| A session dies mid-run | The watchdog finds the run lock held by a dead session | A new run starts from `main`. Unmerged work is lost only back to the last checkpoint. |
| Branches diverge | `git status` in the stop report; a merge conflict | Merge `main` into the branch and resolve. The state file is resolved by re-deriving it from the log, which is append-only. |
| Conflict in the ledger | The start procedure's consistency check | The state file is rebuilt from log entries and evidence; the conflict is logged as a finding |
| Wrong "goal met" | The stop report shows open items, or the closure review fails | The next run reopens the items; the event is logged as a finding (FND) |
| Batu silent for a long time | A pending issue is older than 24 hours (4 hours if work is blocked) | Repeat once through the second channel (plan Appendix E §8); work that does not depend on him continues; silence is never approval |
| Usage limit reached | Session failure or status `rejected` | S5, a wake-up at reset + 15 minutes, `DURUM.md` shows the hold |
| A review session fails or is never delivered | No commit on its review branch within the expected time | Restart once; on a second failure, log a blocker (S3) |

---

## 12. What changes for Batu

- He no longer types `/goal`.
- He reads `DURUM.md` (or the GitHub app) to see status.
- He answers decisions in GitHub issues assigned to him; one batched request carries everything he must do.
- He gives no technical approvals.

---

## 13. Tests (acceptance written before results)

| ID | Claim | Acceptance condition |
|---|---|---|
| T-A1a | A builder-started session can run under `/goal` | The session's record shows the goal set and evaluated. **Done:** met (session `session_018kpRnAaG9R3vaRTg5wMyye`). |
| T-A1b | A tool-created one-shot routine starts a session that sets `/goal` and has no connectors | The record shows the goal set, and the session's own answer lists no account connector server |
| T-H1 | Repository deny rules block connectors | In a running session the denied tools become unavailable. **Done:** observed in the builder session. |
| T-B1 | A new session can continue from `main` alone | A fresh run started by the builder with the R1 template, on `main` only, writes a resume report naming the correct next work item, which the builder pre-registers in the state file before the test. It does no other work. |
| T-E1 | A review session's result reaches the builder through the repository | The counter-design session's file is fetched from its branch with no involvement from Batu. |
| T-E2 | An independent review of this model returns through the repository | Same route, with findings and dispositions recorded |

---

## 14. Counter-design comparison

Filled in after the independent counter-design (`briefs/builder-operating-model/COUNTER_DESIGN.md` on branch `claude/counter-design-builder-model`) is in. This draft was fixed before that file was read; its hash is recorded in the log.

---

## Appendix R1 · Run template

```text
/goal You are a DevOS builder run. First follow the start procedure in plan/Builder_Operating_Model.md section 3.1 on the devos repository main branch, and register this session as the active run in plan/ledger.md. Then work through the current stage's work list by priority, merging into main at every checkpoint. Stop only when one stop condition S1-S5 of section 2 holds. At the stop, print the stop report of section 3.4, update DURUM.md, merge everything into main, and start the successor run or schedule the wake-up if section 2 requires it. Never use account connectors. Batu's silence is never approval.
```
