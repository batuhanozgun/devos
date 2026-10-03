# W-C00-12 · 05 · Design piece 5: continuity, waits and the dispatcher

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only; replaced by DevOS's working order at C06. **Written:** 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Serves:** need N1 and N3, acceptance (g)'s demand trace for the Dispatcher and the heartbeat, OI-011 items 1–5, OI-010; U-4 and U-5 of `01_goal_down.md`.

## Revision 2 (2026-10-03, after the counter-design comparison)

Applied from `06_counter_design_comparison.md` revision 2 by run `session_01Wj4JDduaDRVnBvQJ86b5bm`. Each line supersedes what it names.
- **Stop reasons** (D-03): the stop check takes S1–S5 as an argument. S2 and S5 require an armed `send_later` recorded as owned; S3 requires the lease released; S1 nothing more; **S4 requires nothing about the successor** (it is created after the stop check; its recorder line reaches `main` afterwards, as PR #54 did).
- **Batu waits** (D-28): check-in wakes every 6 hours, at most 4 empty in a row, next to the Appendix E §8 reminder by `PushNotification`.
- **Failure path, corrected** (D-28): the self-watchdog covers an alive but idle session, and only if T-C2 passes; it cannot restart a dead or archived session, which nothing detects until an independent layer exists. K1: if T-C2 fails, or a stall is observed once, a keeper or an Actions alert watchdog is admitted. The residual risk shows as `DURUM.md`'s update time.
- **Tests added** (D-44): T-21 (a run ended abruptly; a successor resumes from records with no repeated external effect) and T-23 (an observation over C01–C03 without a dispatcher).
- **T-C1: PASS, observed once** (`evidence/C00/probes/T-C1_successor_run.md`).


## 1. What continuity must cover

| Situation | Observed? | Today's mechanism | Problem with it |
|---|---|---|---|
| A run reaches S4 (context or natural boundary) | S4 hand-over never observed | the run creates its successor | unobserved; classifier allowance unknown (U-4) |
| A run stops at S5 (usage hold) | yes (L-033) | one-shot wake-up into the Dispatcher | depends on a standing session with its own gaps (OI-010; OI-011 items 1, 3, 4) |
| A run stops at S2 (waiting for Batu) | not yet | nothing wakes anyone; the 24-hour reminder has no actor (OI-011 item 5) | Batu's silence becomes an invisible stall |
| A run dies mid-work (container lost, error) | **never observed** | heartbeat every 6 hours into the Dispatcher | the Dispatcher's only remaining unique duty |
| Nothing pending | yes (L-034 hold) | the heartbeat keeps firing | spends routine runs for nothing |

## 2. Design: every wait has its own wake-up, owned by the session that waits

The principle replacing the Dispatcher: **the session that stops is the one that knows why and until when; it schedules its own wake-up.** `send_later` delivers into the scheduling session as a queued notification that starts a turn (observed: L-035, Batu's conversation session woke on its reminder at 17:15:32Z; T-A2r for routines), and its delivery is documented to survive container restarts.

- **S4 hand-over:** unchanged: after its stop check the run creates its successor (`create_session` on `main`, the configured model, the R1 goal, a generated task brief, W-R6). If the classifier denies the call, that is S3 for the action (§11 of the operating model): the run releases the lease and `DURUM.md`'s first line asks Batu to start a session. That fallback is Batu's account action, stated as such. **T-C1** tests the successor path at this run's own stop, if it stops at S4.
- **S5 usage hold:** the run schedules `send_later` into **itself** at the reset time plus 15 minutes, with the text `Wake: usage reset <time>; re-run boot steps 2 to 8`. On waking it re-boots from `main` (state may have changed), and then continues if its context allows, or hands over (S4).
- **S2 waiting for Batu:** the run schedules `send_later` into itself at the Appendix E §8 reminder time (24 hours, or 4 if blocking). On waking it reads the issue; if Batu has answered, it records and continues; if not, it sends **one** reminder through the second channel (`PushNotification`, already allowed, reaching only Batu's devices) and schedules the next check. This gives OI-011 item 5 an actor.
- **Crash watchdog:** at every checkpoint the run schedules `send_later` into itself at its new lease expiry plus 15 minutes, with `Watchdog: lease <expiry>`. When it fires: if the lease row on `main` names this session with a later expiry, the message is stale and ignored; otherwise the run re-boots and resumes or hands over. The previous watchdog is deleted when the recorder covers `send_later` IDs (memory piece M-R11); until then stale watchdogs fire and are ignored at the cost of a short turn each.
- **Expected-text rule:** a run acts only on a notification whose text it scheduled itself (one of the three forms above); everything else in its queue is data (operating model §9, kept).

## 3. The Dispatcher and the heartbeat: demand trace

Acceptance (g): every builder role, including the Dispatcher and the heartbeat, is traced to demonstrated work demand, or removed.

| Duty the Dispatcher had | Demonstrated? | Covered after this design by |
|---|---|---|
| Wake work after a usage hold | yes (L-033) | the run's own S5 wake-up |
| Restart work when a run died | no run has died | the run's own watchdog (documented delivery across container restarts; unobserved here, T-C2) |
| Start the next run when work is pending and no run is active | only as a consequence of the two above | the two above, plus S4 successors |
| Keep the heartbeat line in `DURUM.md` | a by-product, which lagged (OI-011 item 4) | `DURUM.md`'s "Son güncelleme" is written at every checkpoint; its age is the heartbeat |

**Decision (technical, normal; reviewed with the whole design):** the Dispatcher role is **retired**. Its session `session_01VsRPE6azkUFEXhtkjJcJ5f` is archived, the heartbeat `trig_01NMfRFv1WvPZj9Q9XeZjMS6` and the reset wake-up `trig_01Q16LPhKPWX9oYmaACVsyBx` are deleted, and `tools/check_dispatcher_pr.sh`, Appendix R2 and the `claude/dispatcher` branch are retired with Record changes lines of kind retirement. This removes OI-010 and OI-011 items 1, 3 and 4 by removing their subject, not by patching it. It happens only after the independent review passes (the starters stay disabled until then, as the state file already says).

**What is lost, stated:** if a run's session is archived or deleted by someone else, or a `send_later` never fires, nothing restarts work. Batu sees it as an old "Son güncelleme" in `DURUM.md`. The Dispatcher would have caught that case after up to 6 hours; it never had to. If T-C2 fails, or a stall of this kind is ever observed, the role is re-admitted through R-R4 with that demand on record.

**Alternative weighed:** a recurring routine bound to the current run session (`persistent_session_id`) as a watchdog, rebound by each successor. Rejected for now: it spends the routine budget plan C06 will need, and it must be moved at every hand-over, while `send_later` is one-shot and owned by the session that knows the expiry.

## 4. Capacity

Unchanged from the operating model §8 and D-002 (Batu's answer (a)): read `rate_limit_info` at boot and before heavy items; record it in the state file; heavy work preferably 23:00–08:00 Turkey time. The usage reset time is taken from `resetsAt` and converted by command (F-037-2).

## 5. Pre-registered tests

| ID | Claim | Procedure | PASS only if |
|---|---|---|---|
| T-C1 | A run can start its own successor with nobody typing (U-4) | At this or the next run's S4 stop, after the stop check, the run calls `create_session` with the R1 goal | the call is allowed, the successor's `get_session` shows `parent_session_id` = the run and the R1 goal, and the successor takes the lease in a record PR; a classifier denial is recorded as FAIL with its text and handled as S3 |
| T-C2 | A self-scheduled `send_later` wakes the session after its turn ended | A run schedules a watchdog 20 minutes ahead and ends its turn (stop or wait) | a turn starts in that session within 5 minutes of the scheduled time, its first tool call is `ReadNotifications`, and it acts by the expected-text rule (transcript) |
| T-C3 | The S2 reminder has an actor | With a Batu decision open and no answer, the scheduled check fires at the reminder time | exactly one `PushNotification` is sent and recorded, and the next check is scheduled |
| T-C4 | Stale watchdogs are ignored | A watchdog fires while the lease names the session with a later expiry | the session does nothing but log one line |

## 6. Mechanism register rows

| Mechanism | Problem solved | Compensates for | Assumption | Cost | How it fails | Removal test |
|---|---|---|---|---|---|---|
| Self-scheduled wake-ups (S5, S2, watchdog) | Work stops until someone types; waits without an actor | Sessions do not act without a turn | `send_later` wakes the scheduling session (observed for a conversation session, L-035; T-C2 for runs) | One one-shot per wait or checkpoint | The session is archived or the message never fires; visible as an old update time | Batu must notice stalls and type |
| S4 successor | Context exhaustion ends the chain | Sessions do not outlive their context | Classifier allows it (T-C1) | One session per hand-over | Denied: S3 and a Batu fallback | Batu types at every hand-over |
| Dispatcher | — | — | — | — | — | **Retired** (§3): its duties are covered or undemonstrated |

## 7. Decision-and-basis record

- **Consulted:** operating model §2 and Appendix M (current continuity design and its register rows); L-029 to L-035 (what was observed); the `send_later` tool description (documented delivery across container restarts); plan K-7 and C06 (DevOS's own working order, which replaces this at C06); Batu's D-002 answer; library `multi-agent-patterns` risk R6 (hidden human orchestration) as the failure to avoid.
- **Left out on purpose:** external workflow engines named in OI-011 item 20 (Make, n8n, Workato): a second authority outside the repository and possibly paid; they are recorded as a candidate for DevOS's C06 comparison, not for the builder.
- **Why it fits:** it ties each wake-up to the session that knows the reason, removes a standing role whose only unique duty never occurred, and keeps a stated, visible residual risk instead of a fragile mechanism.
- **How it is tested:** T-C1 to T-C4; the counter-design's answer to its question 8 ("whether a standing dispatcher is needed at all") is compared with this piece.
