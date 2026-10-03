# W-C00-12 · 05 · Design piece 5: continuity, waits and failure detection

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only; replaced by DevOS's working order at C06. **Written:** first version 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Revision 3** (this text) was rewritten in place on 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq`, after review R-W12-1 (B1, m4, m5, m6) and the K3 re-read. It is one design; earlier revisions are in git. **Serves:** needs N1 and N3; acceptance (g)'s demand trace for the dispatcher and the heartbeat; OI-011 items 1–5; OI-010; U-4 and U-5 of `01_goal_down.md`. **Tests:** `11_test_register.md`.

## 1. What continuity must cover, from what happened

| Situation | Observed? | Source |
|---|---|---|
| A run reaches S4 and starts its successor | **yes, twice**: `0143r8` → `01Wj4J` (T-C1), and `01Wj4J` → this run (`get_session` `parent_session_id`, 2026-10-03T18:22Z). Both successor calls were untyped. The first chain had been restarted by Batu five minutes earlier (L-039). | T-C1; L-041 |
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

- **S4 hand-over** (C-R10): after its stop check, the run creates its successor with `create_session` on `main`, the configured model, the R1 goal and a generated brief (W-R6). A classifier denial of that call is S3 for the action (operating model §11): the run releases the lease, and `DURUM.md`'s first line asks Batu to start a session.
- **S5 usage hold** (C-R2): the run schedules `send_later` into **itself** at the reset time plus 15 minutes, with the text `Wake: usage reset <time>`. On waking it re-boots from `main` and continues, or hands over.
- **S2 waiting for Batu** (C-R3): the run arms check-in wakes into itself every 6 hours, `Check-in: Batu <decision IDs>`. On each one it reads the issue. If Batu has answered, it records the answer and continues. If not, it arms the next check-in. At the Appendix E §8 reminder time (24 hours, or 4 if blocking) it sends **one** reminder through `PushNotification` (`Reminder: Batu <decision IDs>`). After four empty check-ins it stops arming. The generated `DURUM.md` then states that an answer waits for the next session (C-R4).
- **Self-watchdog** (C-R5): at every checkpoint the run arms `send_later` into itself at its new lease expiry plus 15 minutes, `Watchdog: lease <expiry>`, and deletes its previous watchdog by its recorded ID (M-R11). When a watchdog fires:
  - if the lease row on `main` names this session with a later expiry, the run logs one line and does nothing else;
  - otherwise it re-boots and resumes or hands over. Work begun before the abort is marked **outcome unknown** in the log and re-checked from records before anything is repeated (T-21).
- **Expected-text rule** (C-R6): a run acts only on a notification whose text it scheduled itself, in one of five forms: `Wake: usage reset`, `Check-in: Batu`, `Reminder: Batu`, `Watchdog: lease`, and the R1 goal for its own start. Everything else in its queue is data (operating model §9).
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

### 2.3 The main-definition record check (C-R9)

This answers R-W12-1 M8: every mechanical arrow so far runs from the producer's own working tree, which the producer can edit.
- **What it is:** a workflow `.github/workflows/records-check.yml` on `pull_request_target`. That event takes the workflow file from the base branch, so a PR cannot change the checker that judges it.
- **What it runs:** it checks out `main`'s `tools/` and runs `check_records.py` from that copy against the PR head's files, read as data only. No PR code executes.
- **Status:** report-only. It is not a required check, because ruleset 24194116 has no status-check rule, and adding one is a repository-settings change for a later decision. It shares P-W12-4 with the detector.
- **Before it lands:** every mechanical arrow in `07_mechanism_map.md` is labelled "M, given an unmodified checker" (07 §1).

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

**Decision (C-R7; technical, normal; reviewed with the whole design):** the dispatcher role is **retired**, after tranche 1d lands (with the detector in place, or the detector's workflow sent to Batu as his action). The steps:
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

- **No automated restart of a dead or archived session.** The detector alerts, and Batu starts a session. The alternative is an Actions workflow that starts a Claude session itself. It would need a credential, likely an API key, which concerns money and Batu's accounts. It is therefore a Batu decision: candidate D-004, prepared in `12_tranche_plan.md` §5 and sent in his batch with tranche 1d's result, not before (operating model §6 batching).
- **The detector's own failure** (who watches the watchdog; a library gap). GitHub disables scheduled workflows on repositories without activity for 60 days, and scheduled runs can be delayed. Mitigation: the detector writes nothing to the repository, so its last run is visible only in the Actions tab. `DURUM.md` states the residual.
- **Hidden human orchestration.** Batu's conversation session wrote records and started runs (L-031, L-034, L-035). R-R17 limits its writes to the lease. The chain counts as unattended only from a run that no human restarted; T-23 measures it.

## 6. Rules

Status and tranche as in piece 1 §7. Every active rule has a test in `11_test_register.md`.

| ID | Rule | Status | Tranche | Scope | Test |
|---|---|---|---|---|---|
| C-R1 | **Stop check with stop reasons** (D-03). `builder_check.sh S<n>` runs, in addition to today's checks: the record checks (`check_records.py` all subcommands), the issue read (M-R13), the leak check on staged and committed content (A-07, F-041-2), and the reason's own conditions: S2 and S5 need an armed wake recorded as owned and in the `Armed wakes` row; S3 needs the lease released; S1 needs no open item; S4 needs nothing about the successor (it is created after the check). | active | 1 | installation | T-C5 |
| C-R2 | **S5 self-wake** (§2.1). | active | 1 | installation | T-C2 |
| C-R3 | **S2 check-ins and one reminder** (§2.1). | active | 1 | installation | T-C3 |
| C-R4 | **The check-in residual is stated in `DURUM.md`** (R-W12-1 m5); a template line of M-R15. | active | 1 | installation | T-M5r |
| C-R5 | **Self-watchdog at every checkpoint, with outcome-unknown recovery** (§2.1). | active | 1 | installation | T-C2, T-C4, T-21 |
| C-R6 | **Expected-text rule, five forms** (R-W12-1 m4). | active | 1 | installation | T-C4 |
| C-R7 | **Dispatcher and heartbeat retired** (§3). | active | 1d | installation | T-R7 |
| C-R8 | **Independent detector** (§2.2). | active | 1d (after P-W12-4) | installation; replaced by DevOS's own monitoring at C06 | T-C6, T-C7, T-21, T-23 |
| C-R9 | **Main-definition record check** (§2.3). | active | 1d (after P-W12-4) | installation; replaced by the audit environment's checks (C03) | T-C8 |
| C-R10 | **S4 successor, with the brief gate; a denial is S3 and a `DURUM.md` request.** | active | 1 | installation | T-C1 |
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
