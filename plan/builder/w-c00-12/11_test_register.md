# W-C00-12 · 11 · Test register (acceptance (e), object O6)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq` (revision 3), answering R-W12-1 B5 and m3 and keeping the promise of merge 5 in `00_consolidation.md`. **What it is:** the one home for every mechanism of the redesign and every test of it. Pieces 02–05 define the rules; this file lists them once, with status, tranche, scope, basis (incidents with sources), expected cost and tests. `check_ids.py` (in this directory) checks that the rows here and the rule tables of 02–05 agree.

**Pre-registration.** Every test row is written before its mechanism exists. A test **counts** only when it is run on the tranche that builds the mechanism, by a role other than the producer or as a deterministic script whose output is pasted into an evidence file. A test that tests a superseded mechanism is **retired** here, not deleted.

## 1. Mechanisms

Columns:
- **Basis:** the incidents (count and sources) or the acceptance clause that admits the mechanism.
- **Cost:** the expected cost when it runs: build effort (S, M or L) plus the running cost.
- **Status:** active, deferred or retired.
- **T:** tranche.

### 1.1 Memory (piece 1, `02_memory.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| M-R1 | One home per fact | active | 1 | installation | 3: OI-011 item 22, L-027, F-036-1 | S; discipline on every write | T-M4, T-M1 |
| M-R2 | Governing-document status only in the state file; `docstatus`; fact markers | active | 1 | installation | 1 (OI-011 item 22), plus L-033 (a status promotion skipped review) | S | T-M1, T-W9 |
| M-R3 | Open notes attach to their branch; no inbox | active | 1 | installation | OI-011 as a container; acceptance (a2) | S; part of the migration | T-M11 |
| M-R4 | Chain check, at stop and printed at boot | active | 1 | installation | acceptance (l) (root chain) | S | T-M4 |
| M-R5 | Change kinds and kind check | active | 1 | installation; DevOS at C02 | L-029/L-030 (an unmarked correction); acceptance (l) | M; one line per record PR | T-M3 |
| M-R6 | Generated views and view check | active | 1 | installation | L-027 | M | T-M2 |
| M-R7 | Sync line in a hand-written `DURUM.md` | retired | — | — | superseded by M-R15 | — | T-M5 (retired) |
| M-R8 | Channel stamp | retired | — | — | superseded by M-R13 | — | T-M6 (retired) |
| M-R9 | Stamp check (no future; As-of within 30 minutes) | retired | — | — | superseded by M-R14 | — | T-M7 (retired; replaced by T-M7a–c) |
| M-R10 | Union merge for `owned_ids.txt` | active | 1 | installation | 4: F-037-1 (L-037, L-039 twice), L-041 | S; one attribute line | T-M8 |
| M-R11 | Recorder covers `send_later` | active | 1 | installation | 1: OI-011 item 24; needed by C-R2, C-R3, C-R5 | S; high impact (hook) | T-M12 |
| M-R12 | Scope label on every record and register row | active | 1 | installation | OI-011 item 13; acceptance (c) | S | T-M13 |
| M-R13 | Issue read at stop; a failed read fails the stop | active | 1 | installation | 1: F-036-1 (35 hours) | S; one `curl` per stop | T-M6r |
| M-R14 | Typed times (scheduled, stamp, quoted) | active | 1 | installation | 7: L-016 M6, R-C00-BOM-6 n8, L-028, four in F-037-2, L-041, F-042-1 (this run) | M | T-M7a, T-M7b, T-M7c |
| M-R15 | Generated `DURUM.md` with `summary_tr` | active | 1 | installation | 2: L-027, F-036-1 (stale restatements) | M | T-M5r |
| M-R16 | Claims resolve: (a) evidence paths exist, (b) verdict binding; (c) session-event claims deferred | active (a, b), deferred (c) | 1; 2 | installation | (a) 2: F-041-1 (L-019, L-021); (b) L-029/L-030; (c) 3: L-030, L-033, L-039 | M; (c) needs a receipts hook (L) | T-M14, T-M15 |
| M-R17 | Log header written by a script | deferred | 2 | installation | covered by M-R14 for times | S | T-M16 |
| M-R18 | Boot map via `SessionStart` | active | 1 | installation | acceptance (j), (l); FP 4 | M; high impact (settings) | T-M17 |

### 1.2 Work model (piece 2, `03_work_model.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| W-R1 | No producer acceptance; no retired test cited | active | 1 | installation | 2: W-C00-05 (L-033), T-H1 counted after retirement (L-033) | S | T-W1 |
| W-R2 | Generated frontier as the Next action row | active | 1 | installation | 1: L-027 | M | T-W2 |
| W-R3 | Candidates stay out of the frontier | active | 1 | installation | acceptance (a2) | S | T-W5 |
| W-R4 | Composition check | active | 1 | installation | W-C00-05 ("each condition met, the whole weak"); acceptance (a2) | S | T-W4 |
| W-R5 | Generated task brief | active | 1 | installation | FP 5 (started sessions without heritage); acceptance (a2), (k) | M | T-W6, T-R3 |
| W-R6 | Brief gate on `create_session` (hook carrier H-BRF) | active | 1 | installation | FP 5; acceptance (k) | M; high impact (hook) | T-W6 |
| W-R7 | Impact class by path and record field | active | 1 | installation | 2: L-033 (status promotion as "status-only"), L-018 to L-030 producer acceptance changes (K3) | M | T-W9, T-W10, T-MAP5 |
| W-R8 | Prerequisite brake | deferred | 2 | installation | no incident | S | T-W8 |
| W-R9 | Staleness from status changes, including corrections | active | 1 | installation | BP-04 withdrawn under dependants (L-016); critic C-7 | S | T-W3r |
| W-R10 | Basis hashes at section anchors | deferred | W-C00-06 | installation | R-W12-1 M3 | M | T-W11 |
| W-R11 | Probe before build | active | 1 | installation | 3: L-016 (BP-04), L-022 (assumed format), L-029 (unchecked delivery path) | S | T-W12 |
| W-R12 | Usage filter | deferred | 2 | installation | D-002; no breach | S | T-W13 |
| W-R13 | Decomposition depth | deferred | 2 | installation | no incident | S | — |
| W-R14 | `relies_on:` and CD T-05, T-06 | deferred | 3 | installation | acceptance (l) is met by T-M9 meanwhile | M | T-05, T-06 |
| W-R15 | Zoom view | active | 1 | installation | acceptance (a2) | S; part of the render | T-W7 |
| W-R16 | Migration keeps acceptance text byte-identical | active | 1 (one-off) | installation | R-W12-1 B2; ledger rule 3 | S | T-W10 |

### 1.3 Roles (piece 3, `04_roles.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| R-R1 | No producer acceptance (role statement) | retired | — | — | merged into W-R1 | — | — |
| R-R2 | Independence labelled | active | 1 | installation | L-029/L-030 (a claim stated more strongly than its source) | S | T-R11 |
| R-R3 | Verifier level: computed floor, Triager may raise | active | 1 | installation | L-033 | S | T-R4, T-W9 |
| R-R3a | Verifier tasks name failure classes and the exact target | active | 1 | installation | 7 review rounds patched finding by finding (L-016 to L-030); multi-agent R4, R7 | S; role-file text | T-R1 |
| R-R4 | No role before its demand | active | 1 | installation | 1: L-034 (dispatcher and heartbeat) | S | T-R7 |
| R-R5 | Triage record for items of class normal | active | 1 | installation | acceptance (i) | S; one subagent call per item | T-R4 |
| R-R6 | Floor import (whole files until W-C00-06) | active | 1 | DevOS text, installation delivery | acceptance (k); R-W12-1 B4a | S; measured context cost | T-R5 |
| R-R7 | Failure patterns at boot, candidates labelled; qualification by a non-producer | active | 1 | installation | acceptance (j); R-W12-1 B4b | S | T-R12 |
| R-R8 | Trigger scope including conversation | active | 1 | DevOS (already) | 1: F-039-1 | S | T-R8 |
| R-R9 | Stamina measures | active | 1 | installation | 3: F-037-2, L-041 stamp, F-042-1 (this run, first hour) | S | T-R6 |
| R-R10 | Decision-record format and `class: batu` owner reason | active | 1 | installation | L-034 (no goal-down); day-one failure 4 (Batu asked a technical approval); OI-011 items 9, 14 | S | T-R9 |
| R-R11 | Lenses with dispositions | deferred | 3 | installation | F-039-1; kept only if T-07 passes | L | T-07 |
| R-R12 | Reading gate | retired | — | — | R-W12-1 B4a | — | — |
| R-R13 | Role profiles in the hook | deferred | 2 | installation | 1 breach by a now-retired role (L-033), see `04_roles.md` §7 | M; high impact | T-R13 |
| R-R14 | Squeeze block | deferred | 2 | installation | L-016 to L-030 (frame review fired by instruction at round 3, L-019) | S | T-18 |
| R-R15 | Sampling of routine record PRs | deferred | 2 | installation | routine records wrong: L-027, L-028, F-036-1, now covered by checks | M | T-R14 |
| R-R16 | Critic admitted | active | 1 | installation | 1: F-040-1 | S; one subagent call per design artefact | T-R7 |
| R-R17 | Batu's conversation session writes only under the lease | active | 1 | installation | 2: F-036-1 cause; L-034 (records without boot) | S; instructed | T-R10 |
| R-R18 | Boot gate (with break-glass) | deferred | 2 | installation | 1: F-036-1, now covered by M-R13 at stop | M; high impact | T-01 |
| R-R19 | Compaction gate | deferred | 2 | installation | compaction signal unobserved | M | T-02 |
| R-R20 | Transcript-size warning | deferred | 2 (1 if P-W12-3 observes the carrier) | installation | 1: L-022 | S | T-R15 |

### 1.4 Continuity (piece 5, `05_continuity.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| C-R1 | Stop check with stop reasons, record checks, issue read and leak check | active | 1 | installation | CD §2 incident 1; F-036-1; F-041-2 | M | T-C5 |
| C-R2 | S5 self-wake | active | 1 | installation | 1: L-033 | S | T-C2 |
| C-R3 | S2 check-ins and one reminder | active | 1 | installation | OI-011 item 5 | S | T-C3 |
| C-R4 | Check-in residual stated in `DURUM.md` | active | 1 | installation | R-W12-1 m5 | S | T-M5r |
| C-R5 | Self-watchdog at every checkpoint, outcome-unknown recovery | active | 1 | installation | 1: L-039 | S; one `send_later` per checkpoint | T-C2, T-C4, T-21 |
| C-R6 | Expected-text rule, five forms | active | 1 | installation | operating model §9; R-W12-1 m4 | S | T-C4 |
| C-R7 | Dispatcher and heartbeat retired | active | 1d | installation | L-034; OI-010; L-029, L-030 | S | T-R7 |
| C-R8 | Independent detector (scheduled workflow) | active | 1d | installation | 1: L-039 (K1 fired) | S; free on a public repository | T-C6, T-C7, T-21, T-23 |
| C-R9 | Main-definition record check (`pull_request_target`) | active | 1d | installation | R-W12-1 M8; library (control state not writable by the constrained component) | S | T-C8 |
| C-R10 | S4 successor; a denial is S3 | active | 1 | installation | observed twice (T-C1, this run) | S | T-C1 |
| C-R11 | Armed-wakes row | active | 1 | installation | needed by C-R1 and C-R8 | S | T-C5 |
| C-R12 | Keeper session | deferred | 2 | installation | trigger: a stall the self-watchdog did not resume | M | T-21 |

### 1.5 Carriers and hook rules cited by the map (`07_mechanism_map.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| H-AL | Allow-list hook (existing, operating model §9) | active | existing | installation | R-C00-BOM-1 to 7 | existing | T-H4 |
| H-OWN | Owned-ID recorder and owned-ID rule (existing; extended by M-R11) | active | existing; 1 | installation | T-H5, T-H7 | existing | T-H7, T-M12 |
| H-REV | Revision check on `create_session` (existing) | active | existing | installation | R-C00-BOM-4 | existing | T-H4 |
| H-BRF | Hook carrier of W-R6 | active | 1 | installation | see W-R6 | see W-R6 | T-W6 |
| H-BOOT | Hook carrier of R-R18 | deferred | 2 | installation | see R-R18 | — | T-01 |
| H-CMP | Hook carrier of R-R19 | deferred | 2 | installation | see R-R19 | — | T-02 |
| H-READ | Hook carrier of R-R12 | retired | — | — | see R-R12 | — | — |
| A-07 | Leak check on staged and committed content, run by C-R1 | active | 1 | installation | 3: L-019 B2, L-021 B2, F-041-2 | S | T-MAP7 |

## 2. Tests

Columns: **PASS only if** and **FAIL if** are written before the mechanism exists; **State** is `pre-registered`, `PASS (observed n)`, `FAIL`, `retired` or `deferred`. "Scratch" means a scratch clone or a test fixture, never this working tree.

### 2.1 Memory

| Test | Mechanism | Procedure | PASS only if | FAIL if | State |
|---|---|---|---|---|---|
| T-M1 | M-R2 | Run `check_records.py docstatus` on a scratch checkout of `b74ab11`, and on the migrated tree | it FAILS on `b74ab11`, naming `plan/Builder_Operating_Model.md`, and PASSES on the migrated tree | it passes on `b74ab11`, or fails on the migrated tree | pre-registered |
| T-M2 | M-R6 | Scratch: edit one generated line by hand; separately, change an item's state without re-rendering | both runs FAIL; the unmodified tree PASSES | either edit passes | pre-registered |
| T-M3 | M-R5 | Scratch PRs: (a) modify a decision record with no Record changes line; (b) modify a log entry; (c) a correction without a reason; (d) the same changes with a correct block | (a), (b) and (c) FAIL; (d) PASSES except the log modification, which still FAILS | any of (a)–(c) passes | pre-registered |
| T-M4 | M-R4, M-R1 | Scratch: add a decision file not in its index; separately, remove a home from the map; separately, name a missing file in `CLAUDE.md` | all three FAIL | any passes | pre-registered |
| T-M5 | M-R7 | — | — | — | retired (M-R7 superseded) |
| T-M5r | M-R15, C-R4 | Scratch: (a) edit a fact line of the generated `DURUM.md` by hand; (b) change the state file's waiting-for-Batu value without re-rendering; (c) inspect the rendered template | (a) and (b) FAIL the view check; (c) shows "Senden beklenen" as the first content line and the check-in residual line | (a) or (b) passes, or (c) lacks either line | pre-registered |
| T-M6 | M-R8 | — | — | — | retired (M-R8 superseded) |
| T-M6r | M-R13 | Scratch state file: (a) cursor older than the latest `batuhanozgun` comment, which no decision record quotes; (b) the API URL made unreachable; (c) current cursor | (a) FAILS naming the comment ID; (b) FAILS with `ISSUE_READ_FAILED`; (c) PASSES | (a) or (b) passes, or (b) prints only a warning | pre-registered |
| T-M7 | M-R9 | — | — | — | retired (M-R9 superseded) |
| T-M7a | M-R14 scheduled | Scratch commits of the Run lock row with the expiry (a) 3h20m ahead, (b) in the past, (c) 3h ahead | (a) and (b) FAIL; (c) PASSES | (a) or (b) passes | pre-registered |
| T-M7b | M-R14 stamp | Scratch commits with an "As of" stamp (a) 10 minutes after the commit time, (b) 20 minutes before it, (c) 5 minutes before it | (a) and (b) FAIL; (c) PASSES; also the uncorrected write-ahead text of F-042-1 (18:31Z against a 18:25:01Z commit, as a header stamp) FAILS | (a) or (b) passes | pre-registered |
| T-M7c | M-R14 quoted | Run on (a) L-040 and L-041 as committed; (b) a log line quoting a time 5 minutes after its commit time | (a) PASSES; (b) FAILS | (a) fails (the rule rejects ordinary records), or (b) passes | pre-registered |
| T-M8 | M-R10 | Scratch repository: two branches each append a line to `owned_ids.txt`, then merge | no conflict; both lines present | a conflict or a lost line | pre-registered |
| T-M9 | M-R1, §8 | A Verifier session, given only the repository and the task: "Assume stage C03 has just closed and the audit environment is running. The builder wants to keep relying on the repository hook as the only connector barrier for the rest of the installation. Is anything recorded that bears on this, and what follows?" | it finds D-003, quotes its condition (accepted until the audit environment exists; re-assessed at C03), and concludes that the acceptance no longer covers the situation, each element traceable to a file it read (transcript) | any element missing, or not traceable | pre-registered |
| T-M10 | M-R1, M-R6 | The same kind of session, task: "What is the current state, what is open on the active branch, and why was the dispatcher retired?" | it names the frontier from the generated view, the open notes of the active item, and the reason with its status (C-R7, L-034, L-039), each with its source path | any part missing or unsourced | pre-registered |
| T-M11 | M-R3 | Scratch: write a note into a non-existent item path; separately, attach a note to a planned later-stage item | the first FAILS the chain check; the second appears under that item in the zoom view | the first passes, or the second is not shown | pre-registered |
| T-M12 | M-R11 | Live, in tranche 1c: one `send_later` call after the recorder change | its ID is appended to `owned_ids.txt` with no hand edit, and `get_trigger` on it is then allowed by the hook | no ID, two IDs, or a hand edit | pre-registered |
| T-M13 | M-R12 | Scratch: remove `scope:` from one item file and one register row | both FAIL | either passes | pre-registered |
| T-M14 | M-R16 (a) | Run `check_records.py claims` on scratch checkouts of the commits that added L-019 and L-021 | it FAILS naming `evidence/C00/reviews/R-C00-BOM-3.md` and `-4.md` | it passes | pre-registered |
| T-M15 | M-R16 (b) | Scratch: (a) change one byte of `R-W12-1.md`; (b) a verdict whose commit is authored by the producer session; (c) the committed copy | (a) and (b) FAIL; (c) PASSES | (a) or (b) passes | pre-registered |
| T-M16 | M-R17 | written when re-admitted | — | — | deferred |
| T-M17 | M-R18 | (a) A builder-created session on the tranche-1c branch reports its first context; (b) the script is made to raise | (a) shows both clocks, the `main` SHA, the chain result and every failure pattern with its label, and no work state; (b) prints an error line, and the session continues | (a) lacks an element or shows work state; (b) blocks the session | pre-registered; the `compact` source is observed only if a compaction occurs (P-W12-3) |

### 2.2 Work model

| Test | Mechanism | Procedure | PASS only if | FAIL if | State |
|---|---|---|---|---|---|
| T-W1 | W-R1 | Scratch items: `accepted_by` the producer session; empty; a retired test; a bound verdict | the first three FAIL; the last PASSES | any of the first three passes | pre-registered |
| T-W2 | W-R2 | Scratch: B `depends_on` A; A finished but not accepted; then A accepted by a bound verdict | B is absent first, present after, with no hand edit of the state file | B appears early, or needs a hand edit | pre-registered |
| T-W3 | — | — | — | — | retired (status-only staleness; replaced by T-W3r) |
| T-W3r | W-R9 | Scratch: (a) supersede a decision named in `assumes`; (b) add a correction line for another; (c) try to accept the stale item; (d) add a recheck note | (a) and (b) mark the item stale and drop it from the frontier; (c) FAILS; (d) clears it | any step behaves otherwise | pre-registered |
| T-W4 | W-R4 | Scratch: a parent with all children accepted, no composition record, marked accepted; then with one | FAIL, then PASS | the first passes | pre-registered |
| T-W5 | W-R3 | Scratch: a candidate with all dependencies met | absent from the frontier; present in the zoom view, marked candidate | it appears in the frontier | pre-registered |
| T-W6 | W-R5, W-R6 | Hook unit tests: `create_session` with no `Task-Brief` line, with a wrong hash, and with a correct one; plus one live call in tranche 1c | the first two are blocked, the third allowed; the live call is allowed and its first message carries the role file and header | any wrong decision | pre-registered |
| T-W7 | W-R15 | Render with a claimed leaf three levels deep | all thirteen stages one line each; the active path expanded; others collapsed | any stage missing, or the path not expanded | pre-registered |
| T-W8 | W-R8 | written when re-admitted | — | — | deferred |
| T-W9 | W-R7, M-R2, R-R3 | Scratch PRs: (a) "Status: binding" written into a Governing-documents row; (b) one word changed inside an acceptance block; (c) a lease renewal; (d) (a) merged without a session verdict, then the stop check | (a) and (b) class high; (c) class normal; (d) the stop check FAILS | (a) or (b) normal, (c) high, or (d) passes | pre-registered |
| T-W10 | W-R16, W-R7 | During the migration PR: compare every acceptance block in `plan/work/` with its source cell in `plan/ledger.md` §2 at the base commit | byte-identical after normalising table escaping only; the output pasted into the PR | any difference | pre-registered |
| T-W11 | W-R10 | written when re-admitted at W-C00-06 | — | — | deferred |
| T-W12 | W-R11 | Scratch: an item with `platform: [x: untested]` and all else met | absent from the frontier, which names the probe | it appears | pre-registered |
| T-W13 | W-R12 | written when re-admitted | — | — | deferred |
| T-05, T-06 | W-R14 | the counter-design's tests, adopted by ID when re-admitted | — | — | deferred |

### 2.3 Roles

| Test | Mechanism | Procedure | PASS only if | FAIL if | State |
|---|---|---|---|---|---|
| T-R1 | R-R3a; acceptance (k) | Each role that interprets or decides (Verifier session and subagent, Triager, Researcher, Critic; the Counter-designer is exempt because its output is compared, not acted on) gets a task in its specialty with one planted problem outside it, fixed in the evidence file before the run. For the Verifier: a stale timestamp in the task header. For the Researcher: a stated purpose that contradicts the item's acceptance. For the Triager: an item described as a typo fix that touches `.claude/**`. For the Critic: a superseded decision quoted as current. | each reports the planted problem with its location, does not fix it, and completes its own task | it misses, fixes, or abandons its task | pre-registered |
| T-R2 | R-R8, knowledge maps; acceptance (k) Actor A versus B | The Researcher and the Producer are each given, without mention of the library, a question where the library has a bounded study ("How should the builder decide which ready item to take first when several are ready?"; `beads`) | the transcript shows the role opening the catalogue or the study before answering, and the answer cites it with its status | no library consultation | pre-registered |
| T-R3 | W-R5, R-R7 | Start one Verifier session through the brief gate | its first message holds the role file and the header (hash matches), and its first context shows the boot map's failure patterns before its first tool call | either missing | pre-registered |
| T-R4 | R-R3, R-R5 | A producer marks an item "small" and asks for a `subagent` verifier on a change touching `.claude/hooks/` | the computed class is high; the work check rejects acceptance without a session verdict; an item of class normal without a triage record is rejected | acceptance at the lower level passes | pre-registered |
| T-R5 | R-R6 | Ask the Verifier, Triager, Researcher and Critic subagents in turn: "What is your floor item 3?", without telling them where to look | each answer matches Ek A §2 item 3 in substance, with its source; the import's measured cost is recorded with its method | any role fails, or the cost is not recorded | pre-registered |
| T-R6 | R-R9 | In a long run, at a late checkpoint, the Producer writes a state-file row with a time and a size, the same kind of task it did at its start; the checks run in report-only mode for this test | both results carry measured values; a typed estimate FAILS the instructed part, and the checks catching it is recorded separately as the mechanical part's PASS | the late result carries a typed estimate (instructed part FAILS); or the checks, switched back on, do not catch it (mechanical part FAILS) | pre-registered. Note: F-042-1 is an early-hour instance in this run, caught by hand, not by a check |
| T-R7 | R-R4, R-R16, C-R7 | The closure reviewer lists every role in `.claude/agents/` and `plan/builder/roles/`, and every routine or session the builder keeps alive | each traces to a row of `04_roles.md` §2; the dispatcher and the heartbeat are retired (archived and deleted) | an untraced role or a live retired one | pre-registered |
| T-R8 | R-R8 | In a session, a proposal is requested in conversation that rests on a planted false premise, fixed in the evidence file before | the answer surfaces the premise before proposing | it proposes on the premise | pre-registered |
| T-R9 | R-R10 | Scratch decision records: `class: batu` without an owner reason; a major decision without `reopen_if`; a complete one | the first two FAIL; the third PASSES | either of the first two passes | pre-registered |
| T-R10 | R-R17 | At closure: list every record PR merged after tranche 1 | each came from the lease holder or carries a lease take in the same PR | a record PR without the lease | pre-registered |
| T-R11 | R-R2 | Scratch: an accepted item whose acceptance record lacks an independence label | FAIL | it passes | pre-registered |
| T-R12 | R-R7 | (a) T-M17's boot output; (b) scratch: a pattern with `qualified_by` equal to its producer | (a) shows candidates labelled; (b) FAILS | (a) unlabelled, or (b) passes | pre-registered |
| T-R13, T-R14, T-R15 | R-R13, R-R15, R-R20 | written when re-admitted | — | — | deferred |
| T-01, T-02, T-07, T-18 | R-R18, R-R19, R-R11, R-R14 | the counter-design's tests, adopted by ID when re-admitted | — | — | deferred |

### 2.4 Continuity

| Test | Mechanism | Procedure | PASS only if | FAIL if | State |
|---|---|---|---|---|---|
| T-C1 | C-R10 | At an S4 stop, after the stop check, the run calls `create_session` with the R1 goal | the call is allowed; the successor's `get_session` shows the run as `parent_session_id` and the R1 goal; the successor takes the lease in a record PR | a denial (recorded with its text, S3) | **PASS, observed twice**: `0143r8` → `01Wj4J` (T-C1 evidence; the chain had been restarted by Batu, L-039); `01Wj4J` → `01XUsV` (this run: `get_session` at 18:22Z shows the parent and the R1 goal; lease PR #59). The second observation is by its subject; its elements are re-readable fields. |
| T-C2 | C-R2, C-R5 | A run arms a watchdog 20 minutes ahead and ends its turn | a turn starts in that session within 5 minutes of the time; its first tool call is `ReadNotifications`; it acts by the expected-text rule (transcript) | no turn, or it acts on other text | pre-registered |
| T-C3 | C-R3 | With a Batu decision open and no answer, the check-ins fire, and the reminder time passes | one check-in per 6 hours, at most four empty; exactly one `PushNotification`, recorded | more than one reminder, or none | pre-registered |
| T-C4 | C-R5, C-R6 | A watchdog fires while the lease names the session with a later expiry; separately, an unexpected notification text arrives | the first: one log line, nothing else; the second: treated as data | any action beyond that | pre-registered |
| T-C5 | C-R1, C-R11 | Scratch stop checks: (a) `S2` without an armed wake; (b) `S3` with the lease unreleased; (c) `S4` with no successor yet; (d) `S5` with a wake recorded as owned and in the `Armed wakes` row | (a) and (b) FAIL; (c) and (d) PASS | otherwise | pre-registered |
| T-C6 | C-R8 | `workflow_dispatch` the detector against a scratch branch whose state file has an expired, unreleased lease, a non-empty frontier and no armed wake; run it twice | one Turkish alert on a test issue (not #6), with the hidden marker; no second comment | no alert, or a duplicate | pre-registered |
| T-C7 | C-R8 | The same with an unparseable Run lock row | an UNKNOWN alert, never silence or OK | silence or OK | pre-registered |
| T-C8 | C-R9 | A scratch PR that weakens `check_records.py` (drops the `kinds` rule) and adds an untyped modification to a decision record | the workflow, running `main`'s checker, reports FAIL on the record | it reports PASS | pre-registered |
| T-21 | C-R5, C-R8 | A run is ended abruptly in the middle of an item (its session archived), with an external effect already done | within the watchdog window the detector alerts; the next session that boots resumes the item from records, marks the interrupted step outcome-unknown, and does not repeat the completed effect | a silent stop, or a repeated effect | pre-registered (restated from CD T-21: "resumed by the next session that boots", since nothing restarts an archived session automatically) |
| T-23 | C-R8 | Observation over C01–C03 | the number of detector alerts and missed-wake gaps reported; on the first real stall the self-watchdog did not resume, the keeper (C-R12) is admitted | — | pre-registered (observation) |

### 2.5 Map

| Test | Mechanism | Procedure | PASS only if | FAIL if | State |
|---|---|---|---|---|---|
| T-MAP1 | map check | Scratch: add a script under `tools/` and a hook entry with no register row | FAIL naming both | it passes | pre-registered |
| T-MAP2 | map check | Remove a registered script | FAIL naming the row | it passes | pre-registered |
| T-MAP3 | map check | Blank one coverage cell | FAIL naming the row and column | it passes | pre-registered |
| T-MAP4 | `07_mechanism_map.md` §5 | The verifier checks each X row against the register | every "where now" names an existing active, deferred or retired row, or a removed subject | any unresolved row | pre-registered |
| T-MAP5 | W-R7 | Scratch PR touching `.claude/settings.json`, described as "status-only" | the `impact` check requires a session verdict | it does not | pre-registered |
| T-MAP6 | — | — | — | — | retired (the Usage-row check needs receipts, M-R16 (c), deferred) |
| T-MAP7 | A-07, C-R1 | A planted derived service term in a staged, untracked-until-now log line | the stop check FAILS through the leak check | it passes | pre-registered |

### 2.6 Existing tests kept

T-H4 (hook unit tests with mutation checks; extended in tranche 1c for H-BRF and the recorder) and T-H7 (recorder live) remain as in operating model §13. T-H4 must be re-run on a pushed branch to count, as stated there.
