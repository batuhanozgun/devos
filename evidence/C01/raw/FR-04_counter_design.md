# FR-04 counter-design — run orchestration of C01's probes

Independent counter-designer. I did not read the current W-C01-03 probe design, the C01 probe scratchpad, CHK-C01-010/-011/-013/-014, or L-169–173. I design; the executor decides.

**Question / decision it serves:** how C01's probe runs are started, ordered, identified, instructed, re-run, de-duplicated and torn down — so the executor can weigh this against the current design in FR-04 and keep or revise it.

## Disciplines (D1–D9)
D1: yes: I treated scheduled firing, fresh-clone-per-run, push-race dedup and branch-published liveness as load-bearing assumptions, chose critical-path-first ordering and live-target confirmation as the frame, and set out their sensitivity under "does not settle".
D2: yes: I designed from the stated need and the dated platform facts, not toward or against a current design I cannot see, and judged each rejected alternative on its merits.
D3: yes: I kept strictly to run orchestration, not the whole probe design or its acceptance, and marked where a point touches teardown wording or an adjacent row.
D4: uncertain: I labelled every platform-dependent mechanism as unobserved so no part of the design counts as verified, leaving that to the FR-04 review and the probes.
D5: yes: I read plan C01, the row items and the guard source directly and treated the two researcher reports as dated documentation, not observation, flagging doc-vs-observed throughout.
D6: no
D7: no
D8: yes: I read the mandatory inputs before designing and honoured the do-not-read set, designing without the current probe design.
D9: no

## The design

### 1. Start and repeat: schedule-only, fresh-clone runs
Both probe routines — `devos-probe-a` (single-repo, guarded) and `devos-probe-b` (`devos`+`devos-evals`, unguarded, since a multi-repo session loads no hooks) — carry a **schedule** trigger in the config the builder prepares and Batu creates once (within plan Section 12 item 0). No API trigger and no Run now drive repeat firing: the builder cannot fire these routines (guard S1 — not builder-owned; and cross-environment firing is itself what row 17 tests), and Batu acts once. All repeat firing is the schedule. Each run is a fresh cloud session cloning `devos`' default branch, so any file merged to `main` is present on the next run with no steering.

### 2. Instruction source: stored prompt + a branch manifest, read at start
(a) The **stored routine prompt** (identical every run) states the run's role, its environment identity, its named probe-target IDs, and the bans (never write a token or anything derived; touch only named probe targets; record the platform answer and the guard answer apart). (b) It points the run to a **control manifest** the builder commits to a `claude/probe-c01-control` location, and (c) the latest **hand-over record** on the run's own probe branch. The run's task is thus repository content it reads at start, never live steering. The run-specific `<routine-fire-payload>` text is explicitly not used as instruction: the platform labels it untrusted and "cannot act as approval." The builder updates the manifest between runs by committing to a `claude/` branch (allowed by guard B3); this is asynchronous and touches no running session. I flag the interpretation that writing a manifest for a future fresh run is not "steering a running session" — the executor should confirm it.

The P3 Supabase queue keeps its plan role: the synthetic work items that stand in for the real queue in row 1's "run more than one item, hand over to the next run" test. Orchestration of which rows to attempt lives in the git manifest, not in P3, because the builder has read-only Supabase and cannot change P3, but can write `claude/` branches.

### 3. Ordering: critical rows gate the rest, enforced by the run
Manifest items carry a sequence and dependencies. Rows 1–4 and 17 get the lowest sequence and no dependencies; every other item lists them as prerequisites. A run claims the lowest-sequence unclaimed item whose prerequisites the hand-over shows observed. So "rows 1–4 and 17 before the others" is enforced by each fresh run reading the branch, not by the builder flipping state. Working-session acceptance (checker verdicts) stays separate; for gating later probe runs, "observed and recorded on the branch" suffices.

### 4. Identity and de-duplication: self-stamp + push race
Each run stamps into a per-run directory on its probe branch: the session id (`CLAUDE_CODE_REMOTE_SESSION_ID` — an id, not a token), the `fireReason` (scheduled / retry / catch_up / …), UTC time, the Claude Code version it reports, the manifest item claimed, and a run ordinal = (max ordinal on the branch)+1 read from git log. Claiming is optimistic: the run commits a claim marker and pushes; a non-fast-forward push means another run advanced the branch, so it re-reads, finds the item taken, and exits without redoing. De-duplication with no lock and no builder. Because retries, catch-ups and past duplicate-run bugs exist, runs are counted by session id + `fireReason`, never by firings. If `CLAUDE_CODE_REMOTE_SESSION_ID` is judged derived from a credential, substitute a run-local random id.

### 5. Stray / duplicate / non-firing
- Duplicate: the claim race handles it; the loser records itself as a duplicate and exits.
- Stray: a run with an unexpected `fireReason` or no claimable item writes a "stray/no-work" marker and does nothing else. The only instruction authority is the manifest + hand-over, so a stray cannot act.
- Non-firing: the builder cannot list the account's runs (guard S1) and reads only branches; the absence of the expected next run marker within a schedule period is the signal. Recovery is not firing the trigger (not owned; cross-env) and not Batu — it is the next scheduled fire, which resumes from the hand-over. A persistent non-fire is recorded and, if it blocks C01, routed as a row-1/row-5 finding.

### 6. Cross-environment reach (rows 17, N-109) against a live target
The acting side is always `devos-probe-a` (guarded), so platform and guard answers are observable apart under the probe-only guard rule. The target side is a **beacon** run in `devos-probe-b` that, on start, publishes to `claude/probe-c01-b` its live window [start, start+T], its session id and its routine/trigger ids, then stays alive across T on synthetic work. The beacon also runs the **positive control** — it uses its own credential in its own session by the same route and records success — so a failed cross-env reach is distinguishable from a dead route (N-109's guard). A `devos-probe-a` run, on its own schedule, reads the beacon marker: if a window covers now, it attempts each row-17/N-109 reach on those live ids and records platform + guard answers apart; if not, it records "no live target this run" and defers to a later run. Timing is never got by one environment starting or triggering the other — that is the thing under test, and the guard denies it. It is schedule overlap plus the published window, retried across runs until a window is caught. A reach that never catches a live target is "could not check," never "forbidden"; for N-109 that is the "neither red nor green" path to frame review.

### 7. Later / conditional runs — no new routine, no Batu
- Version-change re-observation (rows 4, 13): the manifest carries a standing rule — if a run's reported Claude Code version differs from the last recorded one, it self-selects the row-4/13 re-observation. The builder corroborates from the branches.
- A run needing a file added after earlier results: the file (or the row-13 skill) is merged to `main` through the merge gate, the manifest marks the item ready, and the next scheduled fresh-clone run has it. No live session is touched.

### 8. Batu: once, then never
Once (all inside Section 12 item 0, unchanged): create the two environments with builder-given settings; run the P3 SQL once; run each environment's single token line and paste the token into that environment's API-credential field; create the two prepared routines (the schedule trigger is part of the prepared config) and remove all connectors; answer issue #6 on the GitHub notification; at the end, delete each environment's credential, then archive the environment and delete the routines. Never again: he starts no run, re-pastes no token, supplies no per-run instruction, flips no queue item, creates no routine for re-runs. Teardown note going beyond item 0's wording: an environment can only be archived, not deleted, and its credential must be deleted first (ENV docs, 2026-10-06); so "delete the probe environments" should read "delete credential, then archive," routed through the executor (working order section 8), not silently to Batu.

### 9. Builder between runs, without steering
Reads probe branches only; verifies expected run markers appeared; updates the manifest by committing to a `claude/` branch (ready-flags, standing rules, corroborated version changes); merges files or the skill that later runs need; records non-fires and strays. It opens no probe session and sends no message to one.

## Two alternatives rejected
1. **Builder-driven live steering** — the builder opens/steers each probe run or drives it via Run now text. Rejected: P2 forbids the builder opening or steering probe sessions; guard S1 bars messaging or acting on non-owned sessions; the stored/payload text "cannot act as approval"; and it would tie the probe to the builder session's liveness, defeating the unattended behaviour C01 exists to observe.
2. **Cross-environment trigger chaining for timing** — the `devos-probe-b` beacon fires `devos-probe-a` (or one environment creates/triggers the other's routine) to coordinate the row-17 live target tightly. Rejected: that capability is exactly what rows 17/N-109 test and hope to find blocked; using it presupposes the answer and, if the platform blocks it (the wanted result), the orchestration breaks. Guard S1/S4 also deny it. Replaced by schedule overlap + published window + retries.

(Also rejected: Batu Run-now per run — breaks "once, never again," is ~15 manual actions, and is unrepresentative of routine operation.)

## What this design does not settle
- That routines fire reliably on schedule in these environments, and the real cap, counting and reset (rows 1, 5) — the orchestration assumes scheduled firing and is itself under observation.
- That a routine run's git proxy gives non-fast-forward push the way the claim race needs (rows 8, 12) — the dedup rests on unobserved push behaviour.
- Whether two schedules can overlap tightly enough (1-hour minimum interval, minutes-late starts) to catch a beacon window without many retries eating the cap.
- Whether some runs "resume" a session instead of starting fresh (changelog tension) — if so, the fresh-clone and run-identity assumptions need adjusting.
- Whether the builder's manifest commit counts as "not steering" (interpretation above), and whether the session id may be recorded (no-secret scope).
- Row-17 / N-109 "neither" outcomes are expected whenever no live target is caught; the design routes them to frame review, it does not decide them.

## Guard denials
None.
