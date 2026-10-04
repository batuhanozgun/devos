# W-C00-12 · 05 · Design piece 5: continuity, waits and failure detection

**Status:** see `plan/ledger.md`, Governing documents. **Scope:** installation only; replaced by DevOS's working order at C06. **Written:** first version 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Revision 3** (this text) was rewritten in place on 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq`, after review R-W12-1 (B1, m4, m5, m6) and the K3 re-read. It is one design; earlier revisions are in git. **Serves:** needs N1 and N3; acceptance (g)'s demand trace for the dispatcher and the heartbeat; OI-011 items 1–5; OI-010; U-4 and U-5 of `01_goal_down.md`. **Tests:** `11_test_register.md`.

## 1. What continuity must cover, from what happened

| Situation | Observed? | Source |
|---|---|---|
| A run reaches S4 and starts its successor | **yes, twice**: `0143r8` → `01Wj4J` (T-C1), and `01Wj4J` → this run (this run's own boot, L-042: `get_session` `parent_session_id`, created 2026-10-03T18:22:03Z; observed by its subject). Both successor calls were untyped. The first chain had been restarted by Batu five minutes earlier (L-039). | T-C1; L-042 |
| A run stops at S5 (usage hold) | yes (L-033) | L-033 |
| A run stops at S2 (waiting for Batu) | not yet | — |
| **A run's turn aborts mid-work** | **yes, once.** At 17:46:47Z (L-039) a run's turn ended with `error_during_execution` (an account subscription problem). Work resumed only because Batu typed "Sorun çözüldü devam et". Revision 2 said "no run has died"; that premise was false (R-W12-1 B1). | L-039 |
| A run's session is archived or deleted mid-work | not observed | — |
| A spawned session cannot act on its trigger | yes (L-029: the dispatcher could not read its message) | L-029 |
| Nothing is pending | yes (L-034 hold) | L-034 |

**Library lessons applied** (Researcher report, revision 3; `12_tranche_plan.md` §6):
- A claim of work in progress is not proof of life (beads and gastown liveness).
- A health signal that cannot observe must say UNKNOWN, never OK (gstack's "silence read as current" incident; Hermes' scheduler heartbeat, which reports loop success, not delivery).
- Recovery after an interruption marks the outcome unknown and does not retry blindly, because a blind retry can repeat an external effect (Hermes).

## 2. Design: three layers

1. **Every wait has a wake-up owned by the session that waits** (C-R2, C-R3). The session that stops knows why and until when.
2. **Every checkpoint arms a self-watchdog** (C-R5). It covers a session that is alive but idle, which is the L-039 case: the container was alive and the turn had ended.
3. **An independent detector reads `main` hourly** (C-R8). It covers what the first two cannot: a session that is archived or dead, a wake-up that never fires, an account problem that also stops scheduled delivery. It does not depend on any session being alive. It **alerts**; it cannot restart. Restarting needs a credential that can create a Claude session, which an Actions workflow does not hold (§5, residual).

### 2.1 Stops

- **S4 hand-over** (C-R10): after its stop check, the run creates its successor with `create_session` on `main`, the configured model, the R1 goal and the generated run brief, `Task-Brief: run producer <hash>` (W-R5, W-R6; `03_work_model.md` §9). A classifier denial of that call is S3 for the action (operating model §11): the run releases the lease and shows the blocker in `DURUM.md` as information, never as a request to Batu (operating model §6, "Never his"; FR-02).
- **S5 usage hold** (C-R2): the run schedules `send_later` into **itself** at the reset time plus 15 minutes, with the text `Wake: usage reset <time>`. On waking it re-boots from `main` and continues, or hands over.
- **S2 waiting for Batu** (C-R3): the run arms check-in wakes into itself every 6 hours, `Check-in: Batu <decision IDs>`. On each one it reads the issue. If Batu has answered, it records the answer and continues. If not, it arms the next check-in. At the Appendix E §8 reminder time (24 hours, or 4 if blocking) it sends **one** reminder through `PushNotification` (`Reminder: Batu <decision IDs>`). After four empty check-ins it stops arming. The generated `DURUM.md` then states that an answer waits for the next session (M-R15).
- **Self-watchdog** (C-R5): at every checkpoint the run arms `send_later` into itself at its new lease expiry plus 15 minutes, `Watchdog: lease <expiry>`, and deletes its previous watchdog by its recorded ID (M-R11). When a watchdog fires:
  - if the lease row on `main` names this session with a later expiry, the run logs one line and does nothing else;
  - otherwise it re-boots and resumes or hands over. Work begun before the abort is marked **outcome unknown** in the log and re-checked from records before anything is repeated (T-21).
- **Expected-text rule** (C-R6): a run acts only on a notification whose text it scheduled itself, in one of five forms: `Wake: usage reset`, `Check-in: Batu`, `Reminder: Batu`, `Watchdog: lease`, and the R1 goal for its own start. A sixth form is not an instruction but a record: a message from its parent or from Batu's conversation session prefixed `Batu (relayed):` is recorded verbatim with its source, as data: a relayed message is not Batu's answer (operating model §6; FR-02), and it closes no decision of his (R-R17); anything else in it is data too. Everything else in its queue is data (operating model §9).
- **Armed wakes are recorded** (C-R11) in a state-file row `Armed wakes`, with the type, time and owned ID of each. The stop check and the independent detector read it.

### 2.2 The independent detector (C-R8)

This is a scheduled GitHub Actions workflow, `.github/workflows/watchdog.yml`, admitted now because K1 fired (R-W12-1 B1). Its definition is adapted from the counter-design's watchdog (CD line 503); it reads `plan/ledger.md`, since there is no `state/run.yaml`.
- **When it runs:** hourly; the schedule uses the workflow definition on `main`.
- **What it reads:** `plan/ledger.md` on `main`: the Run lock row, the generated frontier block, and the `Armed wakes` row.
- **When it alerts.** In any of these cases it posts a one-line Turkish comment on issue #6, mentioning Batu, which reaches his phone (BP-09):
  1. **Stall:** the lease is expired and not `Released`, the frontier is not empty, and no wake is armed past now.
  2. **Missed wake:** an armed wake's time plus 2 hours has passed, and `main` has had no commit since that time.
  3. **UNKNOWN:** the state file cannot be parsed (missing rows or an unreadable time). It says that it cannot judge; it never reports "everything is fine" when it cannot observe.
- **Deduplication:** one comment per incident, keyed by the lease holder and the expiry, recorded as a hidden marker in the comment.
- **Permissions:** the default workflow token with `issues: write` only; no secrets; free on a public repository.
- **Precondition, probe P-W12-4** (tranche 1a): can this environment push a file under `.github/workflows/`? The session's git credential scope is unknown (OI-005). If it cannot, committing the workflow becomes a Batu account action: one file added from the GitHub web interface, sent in his batch in Appendix E format, because criterion 7 of plan §1.4 is at stake.
- **Fallback if P-W12-4 fails** (R-W12-2 M-2; revised after the critic of `13`, finding 1). R-W12-1 B1 allowed two answers: a detector now, or the stall residual put to Batu as **his** decision (plan §1.4 criterion 7). So the fallback is one Batu item in his batch, Appendix E format, candidate **D-005**, with two options and **no default by silence**: (a) he adds the workflow file from the GitHub web interface (an account action, given step by step); (b) he accepts the residual "no independent stall detection until DevOS's own monitoring (C06); a stall is visible only through the self-watchdog and `DURUM.md`'s update time". Until he answers, C-R8 is not built, the dispatcher is **not** retired (C-R7 waits for C-R8 on `main` or for D-005's answer), and W-C00-12's acceptance waits on D-005, which is one decision, not an open-ended account action. Under (b), C-R8 is deferred with the trigger "the file is on `main`", and its tests T-C6, T-C7, the detector part of T-21 (its first PASS clause) and T-23 are deferred with it; T-21's recovery part stays and is run with a hand-written stall alert.
- **Type of the workflow arrow** (R-W12-2 M-1 b; revised after the critic of `13`, findings 5 and 6). The detector is **M\*** whatever P-W12-4 shows: a failed `git push` does not show that a session cannot change the file through the GitHub contents API or the MCP write tools, which the probe deliberately does not try. Every change under `.github/workflows/**` is class high (W-R7) and never qualifies for break-glass, so it needs a session verdict before merge; that verdict is the layer against a session weakening the detector. This is a residual of the same kind as any reviewed `.claude/**` change, stated here; it is not covered by D-003 (a), which concerns the connector-barrier hook.

### 2.3 The main-definition record check (C-R9, deferred)

This answers R-W12-1 M8: every mechanical arrow so far runs from the producer's own working tree, which the producer can edit. **Deferred** after R-W12-2 M-2, to comparison D-08's original trigger: a merged PR is found to have weakened a check it was judged by, or C03 begins. Reason: it shares P-W12-4 with the detector, so a failed probe would hold W-C00-12's acceptance on a Batu action for a report-only check; and its result has no reader that the producer cannot edit (R-W12-2 M-1 a), so its consequence would be M\* anyway. Until it is re-admitted, every working-tree check stays labelled M\* (07 §1). The design below is kept for re-admission.
- **What it is:** a workflow `.github/workflows/records-check.yml` on `pull_request_target`. That event takes the workflow file from the base branch, so a PR cannot change the checker that judges it.
- **What it runs:** it checks out `main`'s `tools/` and runs `check_records.py` from that copy against the PR head's files, read as data only. No PR code executes.
- **Permissions** (R-W12-2 m-6): `permissions: contents: read, pull-requests: read`. The `impact` subcommand's `git revert` runs in a scratch clone with hooks disabled (`core.hooksPath=/dev/null`), on PR content read as data.
- **Status:** report-only. It is not a required check, because ruleset 24194116 has no status-check rule, and adding one is a repository-settings change for a later decision. It shares P-W12-4 with the detector.
- **Type when re-admitted:** "M (report), M\* (consequence)": it runs from `main`, but what acts on its result (C-R1) runs from the producer's tree (R-W12-2 M-1 a). The detector does not alert Batu on its result, because a failed record check is a technical failure, not his decision (BP-01).

### 2.4 What an L-039-class abort meets under this design

The turn aborts at time t, while the run holds the lease to expiry e.
1. At e + 15 minutes, the self-watchdog fires into the session. If the account problem is over and `send_later` delivers to an idle session (T-C2), the run re-boots and resumes with nobody typing.
2. If it does not fire, the detector's next hourly run after e posts the stall alert. Batu then starts a session: that is typing, but he no longer has to notice the stall himself.
3. The cost is visible: up to 3h15m plus one hour between the abort and the alert. It is stated in `DURUM.md` and in §5.

## 3. The dispatcher and the heartbeat: demand trace

Acceptance (g): every builder role, including the dispatcher and the heartbeat, is traced to a demonstrated work demand, or removed.

| Duty the dispatcher had | Demonstrated? | Covered after this design by |
|---|---|---|
| Wake work after a usage hold | yes (L-033) | the run's own S5 wake (C-R2) |
| Restart work when a run stalled or died | **a stall occurred** (L-039), and Batu restarted it; the dispatcher was disabled at the time (L-034) and did not catch it | the self-watchdog for an idle session (C-R5); the independent detector for everything else (C-R8). A detector **alerts**; neither layer restarts a dead session. |
| Start the next run when work is pending and no run is active | as a consequence of the two above | the two above, plus S4 successors (observed twice) |
| Keep the heartbeat line in `DURUM.md` | a by-product, which lagged (OI-011 item 4) | the generated `DURUM.md` update time (M-R15) and the detector |

**Decision (C-R7; technical, normal; reviewed with the whole design):** the dispatcher role is **retired**, after tranche 1d lands, and only once the detector is on `main` or Batu has answered D-005 (§2.2; critic of `13`, finding 1). The steps:
- archive its session `session_01VsRPE6azkUFEXhtkjJcJ5f`;
- delete the heartbeat `trig_01NMfRFv1WvPZj9Q9XeZjMS6` and the reset wake-up `trig_01Q16LPhKPWX9oYmaACVsyBx`;
- retire `tools/check_dispatcher_pr.sh`, Appendix R2 and the `claude/dispatcher` branch, each with a retirement line.

The dispatcher would not have restarted L-039's run any sooner: it was disabled, and when enabled its heartbeat was every 6 hours. The detector alerts within an hour of the lease expiry, and the self-watchdog may restart an idle session with nobody typing.

**Keeper (C-R12, deferred).** The counter-design's K1 keeper is a session woken by a routine every 8 hours, whose only goal is to keep one run alive. It is deferred. It is re-admitted when the detector posts a real stall alert (not a release) whose stalled session the self-watchdog did not resume. Its routine budget is unsettled: sources conflict on 15 runs per day against 100 per hour (CD U8). So probe P-08 (the observed routine limit) runs before it is built.

## 4. Capacity

Capacity follows operating model §8 and D-002 (Batu's answer (a)):
- read `rate_limit_info` at boot and before heavy items, and record it in the state file with its source (`get_session`) and time;
- heavy work preferably 23:00–08:00 Turkey time;
- take the reset time from `resetsAt` and convert it by command (F-037-2).

**Limit, from the K3 re-read:** the usage reading at 17:35Z showed `allowed` eleven minutes before L-039's abort on an account problem. So a usage reading does not predict account-level failures, and the detector is the layer for those.

## 5. Residual risks, stated

- **No automated restart of a dead or archived session.** The detector alerts, and Batu starts a session. The alternative is an Actions workflow that starts a Claude session itself. It would need a credential, likely an API key, which concerns money and Batu's accounts. It is therefore a Batu decision: candidate D-004, prepared in `12_tranche_plan.md` §7 and sent in his batch with tranche 1d's result, not before (operating model §6 batching).
- **The detector's own failure** (who watches the watchdog; a library gap). GitHub disables scheduled workflows on repositories without activity for 60 days, and scheduled runs can be delayed. Mitigation: the detector writes nothing to the repository, so its last run is visible only in the Actions tab. `DURUM.md` states the residual.
- **Hidden human orchestration.** Batu's conversation session wrote records and started runs (L-031, L-034, L-035). R-R17 limits its writes to the lease. The chain counts as unattended only from a run that no human restarted; T-23 measures it.

## 6. Rules

Status and tranche as in piece 1 §7. Every active rule has a test in `11_test_register.md`.

| ID | Rule | Status | Tranche | Scope | Test |
|---|---|---|---|---|---|
| C-R1 | **Stop check with stop reasons** (D-03). `builder_check.sh S<n>` runs, in addition to today's checks: the record checks (`check_records.py` all subcommands), the issue read (M-R13), the leak check on staged and committed content (A-07, F-041-2), and the reason's own conditions: S2 and S5 need an armed wake recorded as owned and in the `Armed wakes` row; S3 needs the lease released; S1 needs no open item; S4 needs nothing about the successor (it is created after the check); S3 with the reason `ISSUE_READ_FAILED` passes when the MCP read is logged (M-R13). It fails at every stop after a break-glass revert until a session verdict on that revert exists (W-R7). It prints, without failing, the `patch:` count per mechanism (M-R5). *Deferred with C-R9:* reading the main-definition check's result on the head of every PR merged since the run's boot. The Usage row's observation is quoted with its source and time (`get_session`), tested by T-R17. | active | 1 | installation | T-C5, T-R17 |
| C-R2 | **S5 self-wake** (§2.1). | active | 1 | installation | T-C2 |
| C-R3 | **S2 check-ins and one reminder** (§2.1). | active | 1 | installation | T-C3 |
| C-R4 | *The check-in residual stated in `DURUM.md`.* | retired | — | — | merged into M-R15 (one template) |
| C-R5 | **Self-watchdog at every checkpoint, with outcome-unknown recovery** (§2.1). | active | 1 | installation | T-C2, T-C4, T-21 |
| C-R6 | **Expected-text rule, five forms, plus relayed answers recorded as data** (R-W12-1 m4; R-R17). | active | 1 | installation | T-C4 |
| C-R7 | **Dispatcher and heartbeat retired** (§3). | active | 1d | installation | T-R7 |
| C-R8 | **Independent detector** (§2.2); if P-W12-4 fails, Batu's D-005 decides between his adding the file and his accepting the residual (then deferred to its trigger). | active | 1d (after P-W12-4) | installation; replaced by DevOS's own monitoring at C06 | T-C6, T-C7, T-21, T-23 |
| C-R9 | *Main-definition record check* (§2.3; deferred after R-W12-2 M-2 to D-08's trigger: a merged PR found to have weakened a check it was judged by, or C03 begins). | deferred | 2 | installation; replaced by the audit environment's checks (C03) | T-C8 (deferred) |
| C-R10 | **S4 successor, with the run brief under the brief gate; a denial is S3, shown in `DURUM.md` as information (FR-02).** T-C1's two observations ran under v1.7, without the brief gate, and the second is by its subject; T-C1 counts for C-R10 only when re-run after tranche 1c and read by someone other than the successor. | active | 1 | installation | T-C1, T-W6 |
| C-R11 | **Armed-wakes row** in the state file (§2.1). | active | 1 | installation | T-C5 |
| C-R12 | *Keeper session (CD K1).* | deferred | 2 | installation | T-21 (when admitted); probe P-08 first |

## 7. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Self-scheduled wakes and the self-watchdog | installation | DevOS routines and its working order (C06) | C06 acceptance |
| Independent detector | installation | DevOS monitoring of its own runs (C06; observability candidates in OI-011 item 20 are attached to C06) | C06 |
| Main-definition record check | installation | the audit environment's checks with their own credential (C03) | C03 |
| S4 successor | installation | DevOS's single-writer working order | C06 |

Before C11's seven-day unattended run, every builder wake and the detector are disabled, so that the builder is not what keeps DevOS alive (open note on C11, D-33).

## 8. Decision-and-basis record

- **Consulted:**
  - operating model §2 and Appendix M;
  - L-029 to L-041, re-read for this revision by a fresh-context subagent (K3) against fifteen premises. It found the L-039 abort and Batu's restart, the dispatcher's unreadable trigger (L-029), two untyped successor calls, and a usage reading that did not predict the abort;
  - the `send_later` tool description (delivery documented across container restarts);
  - the counter-design's §10 watchdog and keeper, extracted by a subagent: hourly, reads the state file, alerts in Turkish, cannot restart, K1 on first fire;
  - library, by a Researcher subagent: `beads/FINDINGS.md` §7 and `gastown/FINDINGS.md` §§2 and 11–13 (status: bounded-complete, first-wave; no live failure injection) on leases, heartbeats and separate monitor roles; `hermes-agent/evidence/2026-09-11-cron-scheduling-delivery/RESEARCH.md` (status: active, partial) on heartbeat false positives and on marking interrupted runs unknown; `gstack/syntheses/repository-self-development-generation-upgrade-release.md` and `multi-agent-cross-model-coordination.md` (status: bounded research complete, adversarially audited) on "silence read as current" and on a stall caused by an unenforced synchronisation property;
  - plan K-7 and C06.
- **Library gaps:** no source compares an external cron watchdog, self-scheduled wakes and a standing supervisor for LLM session chains; there is no data on silent session deaths or on scheduled-trigger lateness. The design therefore admits the cheapest independent layer and measures it (T-23).
- **Left out on purpose:** external workflow engines (OI-011 item 20: a second authority outside the repository and possibly paid), recorded as a C06 candidate; an automated restart (a Batu decision, §5).
- **Premises, from scratch:** a run never dies (false: L-039); `send_later` wakes an idle run (unobserved: T-C2); Actions can be pushed from here (unknown: P-W12-4); the issue comment reaches Batu's phone (BP-09; T-D1 confirmed his channel).
- **Alternative frames:** (a) keep the dispatcher with a 1-hour heartbeat: rejected, because a standing session has its own failure modes (OI-010, L-029, L-030), spends routine runs, and is not independent of the account problem that caused L-039; (b) the keeper now: deferred to its trigger; (c) accept the stall as Batu-visible residual risk only: rejected, because the detector is free and the stall already occurred once.
- **Reopen if:** T-C2 fails; P-W12-4 fails and Batu declines the web commit; the detector produces a false stall alert twice; a stall is detected that the self-watchdog did not resume (which admits the keeper).
