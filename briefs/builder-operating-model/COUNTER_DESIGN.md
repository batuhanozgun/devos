# Counter-design: the builder's operating model for the installation period

Author: independent design session. Inputs: `BRIEF.md` and `BATU_ORIGINAL_TR.md` only. No other directory and no git history were read.

## 0. The design in one paragraph

`main` is the only memory. The builder works in short **relay legs**: each leg is a fresh, tool-created cloud session that boots from `main`, holds a lease, completes one bounded work item, merges its records to `main`, and either schedules its own next leg or lets a heartbeat routine start it. Done means: acceptance conditions written before the work, a check whose output is committed, and a verdict file from a session that did not do the work. Batu sees one Turkish page and one GitHub issue; he is asked only K-class questions, batched. Connectors are kept out structurally (tool-created sessions carry none) and by a harness-enforced hook, not by instruction.

## 1. Premises

| # | Premise | Origin | From-scratch test |
|---|---|---|---|
| P1 | Anything not on `main` does not exist for the next session. | Batu's failure (2); sandbox can resume from a fresh copy. | Would a new session with only `main` know it? If no, it is lost. |
| P2 | A conversation is not memory; it is compacted, killed, and invisible to other sessions. | Compaction and sandbox facts; `/goal` evaluator sees only the conversation. | Delete the transcript. Does work still continue correctly? |
| P3 | Batu's attention is the scarcest resource; the second scarcest is the shared usage allowance. | Batu's expectations 1–3; Max plan shared. | Does this mechanism ever require Batu to type, copy, or check something technical? |
| P4 | A self-judgement of "done" is not evidence, whether from the builder, the `/goal` evaluator, or Batu. | Expectation 4; evaluator reads only the conversation. | Could a wrong "done" pass this gate if the builder honestly believed it? |
| P5 | Instruction is not a barrier. A barrier is something the harness or platform enforces. | Brief §H. | If the model ignores the rule, does the action still fail? |
| P6 | Tool-created sessions and routines carry no connectors. | Observed for routines; **assumed** for `create_session` (test T4). | Inspect the new session's tool list. |
| P7 | One writer per repository at a time avoids most conflicts; append-only files avoid the rest. | Single-writer constraint; ledger conflict failure. | Can two legs write the same file? |
| P8 | Quality is fixed; speed is the variable. | Constraint §3. | When capacity is short, does a mechanism skip review or evidence? It must not. |

## 2. The design

### A. Continuity

**Mechanism A1 — relay legs.** One leg = one work item (target: fits comfortably in one session without compaction). The leg's last act, after merging to `main`, is to start the next leg with `create_session` (repository checkout, fresh branch) and a first message `/goal <next item's goal text from main>`. The current leg then ends.
- Solves: stopping after every step; dependence on Batu typing. Avoids long sessions, so compaction rarely happens.
- Rests on: self-started `/goal` works (observed, T-A1a); a session can create a sibling.
- Cost: boot overhead per leg (reading ~5 short files). Small.
- Fails when: the leg dies before starting its successor. Covered by A2.

**Mechanism A2 — heartbeat routine.** One recurring routine, created through the tool (therefore connector-free), every 2 hours (12 runs/day, under the 15 cap). Each firing starts a fresh session that runs the boot procedure (B1). If the lease (A3) is live, it exits in one turn. If the lease is stale, it becomes the next leg.
- Solves: dead sessions, lost successors, usage-limit stalls (it resumes after reset without Batu).
- Rests on: recurring routines start fresh sessions; an empty check costs little.
- Cost: up to 12 near-empty sessions per day. Recovery latency up to 2 hours.
- Fails when: the routine is disabled or itself rate-limited. The status page shows "last heartbeat" time, so Batu sees silence without asking.

**Mechanism A3 — lease.** `builder/LEASE.md` on `main`: holder session id, item, expiry (now + 3 h), renewed by commit at each checkpoint. A booting session treats the lease as live if not expired **and** `get_session` shows the holder working.
- Solves: two builders writing at once (heartbeat plus a leg's successor).
- Rests on: `main` merges are serialised; `get_session` reflects liveness.
- Fails when: both read before either merges. The second merge conflicts on `LEASE.md`; the loser exits. Git is the lock.

**Rejected or secondary routes.** `send_later` into the same session: used only for short waits inside a leg (e.g., waiting for a reviewer), because a session that keeps waking accumulates context. Claude Code Projects: not used; account state unknown, and nothing here needs it, so no question to Batu. **Usage limit:** nothing can run while the limit is reached; the heartbeat resumes work after reset. That is the limit of this route, stated on the status page.

### B. Memory and single source of truth

**B1 — boot order** (fixed, written in `builder/BOOT.md`, which is linked from `CLAUDE.md` so every session loads it):
1. `builder/BOOT.md` — this procedure and the safety rules (short, rarely changed).
2. `builder/STATE.md` — current stage, current item, next action, blockers, open PRs, waiting Batu items. Regenerated, never appended; under one screen.
3. `builder/LEASE.md` — decide: continue, take over, or exit.
4. The current item file `builder/work/<ID>.md` — goal, acceptance conditions, evidence so far.
5. Only the plan sections the item cites; the last stage digest; ledger entries since that digest.

**B2 — closing the `main` gap.** Rule: an item is not done until its records are on `main`. Two kinds of PR:
- *Record PRs* (state, ledger, item files, status page): opened and merged by the builder immediately; no review needed.
- *Change PRs* (anything the item produces): merged after the item's acceptance check passes and, if high-impact, after a review PASS.
Every boot lists unmerged builder branches; each is merged, or recorded in the ledger as abandoned with a reason. Within a leg, the working branch is pushed at every checkpoint (at most ~30 minutes of work unpushed).
- Rests on: `main` needs a PR but no approval (observed).
- Fails when: a change PR waits on review for long. `STATE.md` on `main` records "waiting: PR #n, review R-…", so the state is still true on `main`.

**B3 — ledger without sprawl.** One file per entry, `builder/ledger/YYYY-MM-DD-NN-slug.md` (append-only, so no merge conflicts). At each stage closure the leg writes `builder/ledger/digest-<stage>.md` (decisions, plan changes, open risks) and boot reads digests, not the raw entries. Raw entries stay for audit.

**B4 — compaction protection.** Write-ahead: before a long step, the intended step and its acceptance check are committed to the item file. After compaction, the session re-runs B1 instead of trusting its summary. Small legs make compaction rare.

**B5 — compensating the `/goal` evaluator.** The goal text never says "when X is done". It says: "Met only when the last assistant message contains the unedited output of `builder/check.sh <ID>` run against `origin/main`, ending in `ITEM <ID> PASS`, and the PR URL of the merged review verdict." The check script reads acceptance results from `main`, so the evaluator judges pasted machine output, not the builder's claim. A "met" verdict still only ends the session; it never marks anything done (see I).

### C. Work tracking

- **Stages to items.** At the start of each stage the builder splits it into items of one leg each, written as `builder/work/<stage>-<n>.md`. The split itself is the first item of the stage.
- **Item file:** goal; acceptance conditions (each a checkable statement with how it will be checked); impact class (normal / high); reviewer required yes/no; Batu needs; evidence links; status.
- **Conditions before results.** Acceptance conditions are committed and merged in a record PR *before* the first change commit. Git order is the proof. Changing a condition after work started is a high-impact change: it needs a review PASS and a ledger entry stating why.
- **Priority:** (1) plan dependency order; (2) items that unblock Batu's batched asks, so his asks go out early; (3) items that retire the riskiest assumption (probes before builds); (4) everything else.
- **Done** = all conditions checked by `check.sh` with output committed; review PASS where required; change merged to `main`; `STATE.md` and status page updated.

### D. Decision routing

| Class | Who decides | Examples |
|---|---|---|
| Technical, reversible | Builder; ledger entry | file layout, scripts, item split, ordering |
| Technical, high-impact | Builder proposes, **independent review approves** | rules, roles, schema migrations, security settings, permission/hook files, this operating model, acceptance-condition changes |
| Batu's (K) | Batu | purpose, scope, money/paid features, anything touching his accounts or other work (including how much of his shared allowance the builder may use), stage acceptance |

Test for "is it Batu's?": would a perfect engineer still need Batu's preference to answer it? If not, it is not his.

**Format for Batu (Turkish, fixed):** Soru · Neden senin kararın · Seçenekler (her biri: amaç, fayda, bedel) · Önerim · Bilmen gerekenler · Cevap vermezsen ne olur.

**Delivery:** one pinned GitHub issue, "Batu'dan beklenenler". The builder appends a batch comment that mentions Batu, which reaches his phone through GitHub notifications. He answers in the same issue. The builder trusts only comments from Batu's GitHub account (the repository is public; anyone can comment). Answers are copied into the ledger as K-entries.

**Batching:** asks are collected in `STATE.md` and sent when a blocking one appears or once per stage, whichever is first; each batch is step-by-step and complete.

### E. Independence and quality

- **When:** every high-impact change before merge; every stage closure; the operating model now (this counter-design is the first instance).
- **How a review starts:** the builder calls `create_session` with the fixed prompt in `builder/review/PROMPT.md` plus only an item id and PR number. The prompt template is itself high-impact, so the builder cannot quietly soften it.
- **What the reviewer does:** reads acceptance conditions from `main` and the change from the PR, tries to falsify each condition, re-runs checks itself, and writes `builder/review/<ID>-R<n>.md` with verdict PASS / FAIL / PASS-WITH-CONDITIONS and reasons, pushed to its own branch `review/<ID>-R<n>`. It cannot see the builder's transcript.
- **How the result arrives:** the builder (in the same leg via `send_later`, or the next leg via boot) fetches the review branch, merges the verdict file into `main` in a record PR, and acts on it. Batu carries nothing.
- **Stage closure** is reviewed by a session that did not do any item of that stage, with an additional end-to-end question: "does the stage achieve the stage purpose in the plan, not just its item list?"
- **Disagreement:** the builder may reply in a file; a second, fresh reviewer decides. Two FAILs on the same point go to Batu only if the disagreement is about scope or purpose.

### F. Thinking discipline applied to the builder

| Discipline | Mechanism |
|---|---|
| Decision-critical assumptions | Item file lists assumptions the item depends on; probes come first (C priority 3). |
| Reasoning free of non-evidential pressure | Batu's approval, urgency, or the `/goal` verdict are never cited as evidence; done needs `check.sh` output. |
| Goal alignment, end-to-end verification | Stage-closure review asks the purpose question; status page states stage purpose. |
| Validity and independence of verification | Conditions before results; reviewer re-runs checks; reviewer did not do the work. |
| Source vs. view | Ledger entries mark each claim as observed / documented / assumed (as the brief's fact table does). |
| Causal depth | Every FAIL or failure-mode event gets a ledger entry with cause, not only fix; a repeated cause becomes a plan change. |
| Work continuity | A–B: relay, lease, write-ahead, boot from `main`. |
| Pre-work state check | B1 boot is mandatory; a leg must state what it found before acting. |
| Research library | Read-only; each item names the library notes consulted, or states "none relevant". |

**Frame review of this model.** (1) Is the problem "continuity" or "permission to proceed"? Most of Batu's five failures were the builder not knowing it was allowed to act; the routing table (D) fixes more than any automation. (2) Risk of overbuilding: process could exceed installation work. Guard: if more than about a quarter of a stage's legs are process (reviews, records, heartbeats with work), the stage-closure review flags it. (3) The model is designed by the builder for the builder; the counter-design and a review of the merged model are its independence.

### G. Usage and capacity

- **Read:** each leg reads the rate-limit status from `get_session` at boot and records it in `STATE.md`.
- **Rules:** status `allowed` → normal, reviews may run in parallel. `allowed_warning` → one session at a time, no parallel reviewers, heavy items deferred to Batu's night hours (assumed Europe/Istanbul). Rejected → stop; heartbeat resumes later.
- **Batu decision once (K):** how much of his weekly allowance the builder may use and his quiet hours. Default if unanswered: builder runs heavy work only 23:00–08:00 and stops at the first `allowed_warning` on the seven-day window until reset.
- **Inform Batu** (status page plus one issue comment, no question) when a warning first appears in a window and when the builder stops for capacity.

### H. Security

Three layers, each enforced outside the model:
1. **Structural:** the working builder is always a tool-created session (relay leg or heartbeat), which carries no connectors (P6). The session Batu opened from the interface only starts the first leg and then stops working.
2. **Harness hook:** `.claude/settings.json` in `devos` with a `PreToolUse` hook that allows only an explicit list of tools (built-in tools, `mcp__github__*`, the session tools, the Supabase read-only tools) and denies every other `mcp__*`. An allowlist, not a denylist, because connector server names are opaque ids.
3. **Database:** read-only role (given); migrations as files only.
- The settings file and hook are high-impact: changes need review PASS.
- Fails when: the hook syntax is wrong (untested here), or the builder edits its own hook in the same PR. Mitigated by T4 and by review of any change under `.claude/`.

### I. Failure modes

| Failure | Detection | Response |
|---|---|---|
| Session dies | Lease expires | Heartbeat takes over; work since last push is redone (≤30 min). |
| Branches diverge | Boot lists unmerged builder branches | Merge `main` into branch (no rebase); or record as abandoned. |
| Ledger conflict | Merge conflict | Cannot happen for entries (one file each); `STATE.md` conflicts are resolved by regenerating it from `main`. |
| Wrong "goal met" | Next boot re-runs `check.sh` on `main` | Item reopens; ledger entry with cause; goal text tightened. |
| Batu silent | Issue unanswered | Builder continues all unblocked items. After 72 h, a stated default applies only if reversible and costs nothing; otherwise the item stays blocked and the status page says so in its first line. |
| Usage limit | Status at boot / rejected calls | Stop cleanly with lease released; heartbeat resumes after reset; Batu informed once. |
| Reviewer never returns | No verdict file after 2 h | Start one replacement reviewer; second failure → ledger and status page. |
| Classifier denial in auto mode | Tool error | Record; try a compliant alternative; if blocked, item marked blocked with exact denial text. |

### J. Numbering

- `K<n>`: only Batu's decisions. K1–K9 stay. **K10 and K11 are retired** and re-filed under the new prefix (or kept as K only if they are genuinely Batu's choice); retired numbers are never reused, so Batu's next decision is K12.
- `PC-<n>`: builder plan changes (each with reason, affected sections, review id if high-impact).
- `R-<item>-<n>`: review verdicts. Ledger entries use dates, not numbers.

### Status page

`DURUM.md` at the repository root, in Turkish, regenerated by each leg from `STATE.md`, at most 15 lines: aşama, son yapılan, sıradaki, senden beklenen (link to the issue), kapasite durumu, son kalp atışı (last heartbeat time). Batu reads it on GitHub mobile.

## 3. First tests

| # | Test | "Works" means |
|---|---|---|
| T1 | Boot from `main`: start a fresh session with only "continue" as its message. | It names the same next action that was sealed in a file before the test, and acts on it. |
| T2 | Review loop: builder starts a reviewer on a deliberately flawed small change. | Reviewer returns FAIL in a file on its branch; builder merges the verdict and reopens the item; the transcripts show no message from Batu. |
| T3 | Unattended run: archive the active leg mid-item. | Heartbeat starts a new leg within 2 h; it finishes the item; zero Batu messages over 24 h. |
| T4 | Connector barrier: list the tools of a tool-created session; then, with the hook installed, call a harmless tool (`mcp__github__get_me`) after temporarily removing it from the allowlist on a test branch. | No connector tools in the session; the call is blocked by the hook before execution. No forbidden connector is touched. |
| T5 | Lease race: start two legs at once. | Exactly one proceeds; the other exits with a ledger entry. |
| T6 | False goal: a goal session whose conversation claims done while `check.sh` fails. | Nothing is marked done; next boot reopens the item. |
| T7 | Batu channel: post a test comment from a non-Batu account in the issue. | Ignored and recorded; a comment from Batu's account is ingested. |

## 4. Open problems

1. **Usage fraction is invisible.** Only a status (`allowed_warning`) is shown, so the builder cannot plan to a budget, only react. Unknown whether a heartbeat firing during a rate limit wastes a run or fails silently.
2. **Reviewer independence is partial.** Same model, same account, started by the builder. The fixed prompt and no shared transcript help, but correlated blind spots remain. Only a human or a different model would remove this, and neither is in scope.
3. **Batu's GitHub identity.** The issue channel assumes Batu has his own GitHub account distinct from the system account and receives notifications on his phone. If not, the only channel is the status page plus him opening a chat, which is weaker.
4. **`create_session` connector inheritance** is assumed, not observed (T4 settles it). If sessions inherit connectors, layer 2 carries the whole barrier.
5. **Self-editing guards.** The builder can technically change its own hook and settings. Review gating makes this visible, not impossible.
6. **Public repository.** Review files and ledger entries are world-visible at once; reviewers and the builder must write safe summaries. No technical check enforces this; a pre-push secret/size scan is a possible later item.
7. **Heartbeat cap.** 12 runs/day leaves little room for other recurring routines DevOS itself may need later in installation.
