# Builder mechanisms: the register and the map's carrier tables

**Status:** see `plan/ledger.md`, Governing documents. **Scope:** installation only; the register form is a candidate for DevOS's `MechanismAssumption` records (C10). **What it is:** the one home of the mechanism register and of the mechanism map's carrier and coverage tables. Both were moved here unchanged in content in W-C00-12 tranche 1b-i (`plan/builder/w-c00-12/12_tranche_plan.md` section 2.1; R-W12-2 B-2), from `plan/builder/w-c00-12/11_test_register.md` section 1 and `plan/builder/w-c00-12/07_mechanism_map.md` sections 2–4. Those files keep a pointer in their place. The rules themselves are defined in the design pieces `02_memory.md` to `05_continuity.md`, the tests in `11_test_register.md` section 2, the map's notation, failures and critical-path arrows in `07_mechanism_map.md` sections 1 and 5–10. `plan/builder/w-c00-12/check_ids.py` checks that the register here, the pieces' rule tables and the tests agree; the map check (M-R19, tranche 1b-ii) will read the carrier tables here.

## 1. Register (formerly `11_test_register.md` section 1)

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
| M-R12 | Scope label on every record's front matter (rules carry scope in their tables, checked by `check_ids.py`) | deferred | 2 | installation | OI-011 item 13; acceptance (c) is met by the rule tables | S | T-M13 |
| M-R13 | Issue read at stop; a failed read fails every stop except S3 with the reason `ISSUE_READ_FAILED` and a logged MCP read | active | 1 | installation | 1: F-036-1 (35 hours) | S; one `curl` per stop | T-M6r |
| M-R14 | Typed times: scheduled fields (S5 wakes bounded like resets) and `sched:` in prose; written-at stamps, including the `Written:` header of added files; quoted times | active | 1 | installation | 7: L-016 M6, R-C00-BOM-6 n8, L-028, four in F-037-2, L-041, F-042-1 (this run); walk-through over the whole log in L-042 | M | T-M7a, T-M7b, T-M7c |
| M-R15 | Generated `DURUM.md` with `summary_tr` | active | 1 | installation | 2: L-027, F-036-1 (stale restatements) | M | T-M5r |
| M-R16 | Claims resolve: (a) evidence paths exist (root-anchored), (b) verdict binding for verdicts the PR adds, redaction-aware; (c) session-event claims deferred, instructed meanwhile | active (a, b), deferred (c) | 1; 2 | installation | (a) 2: F-041-1 (L-019, L-021); (b) L-029/L-030; (c) 3: L-030, L-033, L-039 | M; (c) needs a receipts hook (L) | T-M14, T-M15, T-R19 |
| M-R17 | Log header written by a script | deferred | 2 | installation | covered by M-R14 for times | S | T-M16 |
| M-R18 | Boot map via `SessionStart` | active | 1 | installation | acceptance (j), (l); FP 4 | M; high impact (settings) | T-M17 |
| M-R19 | Map check against the map's carrier tables | active | 1 | installation | acceptance (m) (map mechanically checked); L-034 (roles without demand) | M | T-MAP1, T-MAP2, T-MAP3, T-MAP4 |

### 1.2 Work model (piece 2, `03_work_model.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| W-R1 | No producer acceptance; no retired test cited; independence label required; deterministic evidence re-run | active | 1 | installation | 2: W-C00-05 (L-033), T-H1 counted after retirement (L-033); L-029/L-030 (a claim stated more strongly than its source) | S | T-W1, T-R11 |
| W-R2 | Generated frontier as the Next action row | active | 1 | installation | 1: L-027 | M | T-W2 |
| W-R3 | Candidates stay out of the frontier | active | 1 | installation | acceptance (a2) | S | T-W5 |
| W-R4 | Composition check | active | 1 | installation | W-C00-05 ("each condition met, the whole weak"); acceptance (a2) | S | T-W4 |
| W-R5 | Generated task brief | active | 1 | installation | FP 5 (started sessions without heritage); acceptance (a2), (k) | M | T-W6, T-R3, T-R22 |
| W-R6 | Brief gate on `create_session` (hook carrier H-BRF) | active | 1 | installation | FP 5; acceptance (k) | M; high impact (hook) | T-W6 |
| W-R7 | Impact class by path and record field; new acceptance blocks normal, changed ones high; readiness-gate fields and the Stage row high; every script high; exact reverts of executable carriers only normal, with a break-glass line and a verdict after the fact | active | 1 | installation | 2: L-033 (status promotion as "status-only"), L-018 to L-030 producer acceptance changes (K3); R-W12-2 B-1 | M | T-W9, T-W10, T-W15, T-MAP5 |
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
| R-R2 | Independence labelled | retired | — | — | merged into W-R1 | — | T-R11 (under W-R1) |
| R-R3 | Verifier level: computed floor, Triager may raise | active | 1 | installation | L-033 | S | T-R4, T-W9 |
| R-R3a | Verifier tasks name failure classes and the exact target | active | 1 | installation | 7 review rounds patched finding by finding (L-016 to L-030); multi-agent R4, R7 | S; role-file text | T-R1, T-R22 |
| R-R4 | No role before its demand | active | 1 | installation | 1: L-034 (dispatcher and heartbeat) | S | T-R7 |
| R-R5 | Triage record before work on items of class normal | active | 1 | installation | acceptance (i) | S; one subagent call per item | T-R4 |
| R-R6 | Floor import (whole files until W-C00-06) | active | 1 | DevOS text, installation delivery | acceptance (k); R-W12-1 B4a | S; measured context cost | T-R5 |
| R-R7 | Failure patterns at boot, candidates labelled; qualification by a non-producer | active | 1 | installation | acceptance (j); R-W12-1 B4b | S | T-R12 |
| R-R8 | Trigger scope including conversation | active | 1 | DevOS (already) | 1: F-039-1 | S | T-R8 |
| R-R9 | Stamina measures, with a mechanical hand-over signal counted at checkpoints; re-ground after compaction instructed until observed | active | 1 | installation | 3: F-037-2, L-041 stamp, F-042-1 (this run, first hour) | S | T-R20, T-R6, T-R16 |
| R-R10 | Decision-record format and `class: batu` owner reason | active | 1 | installation | L-034 (no goal-down); day-one failure 4 (Batu asked a technical approval); OI-011 items 9, 14 | S | T-R9 |
| R-R11 | Lenses with dispositions | deferred | 3 | installation | F-039-1; kept only if T-07 passes | L | T-07 |
| R-R12 | Reading gate | retired | — | — | R-W12-1 B4a | — | — |
| R-R13 | Role profiles in the hook | deferred | 2 | installation | 1 breach by a now-retired role (L-033), see `04_roles.md` §7 | M; high impact | T-R13 |
| R-R14 | Squeeze block | deferred | 2 | installation | L-016 to L-030 (frame review fired by instruction at round 3, L-019) | S | T-18 |
| R-R15 | Sampling of routine record PRs | deferred | 2 | installation | routine records wrong: L-027, L-028, F-036-1, now covered by checks | M | T-R14 |
| R-R16 | Critic admitted | active | 1 | installation | 1: F-040-1 | S; one subagent call per design artefact | T-R7, T-R21 |
| R-R17 | Batu's conversation session writes only under the lease | active | 1 | installation | 2: F-036-1 cause; L-034 (records without boot) | S; instructed | T-R10 |
| R-R18 | Boot gate (with break-glass) | deferred | 2 | installation | 1: F-036-1, now covered by M-R13 at stop | M; high impact | T-01 |
| R-R19 | Compaction gate | deferred | 2 | installation | compaction signal unobserved | M | T-02 |
| R-R20 | Transcript-size warning | deferred | 2 (1 if P-W12-3 observes the carrier) | installation | 1: L-022 | S | T-R15 |
| R-R21 | A refusal is S3 for that action, never routed around (any tool, not only the classifier) | active | 1 | installation | 1: L-031 (403 worked around by a force-move); operating model §11 | S; instructed | T-R18 |

### 1.4 Continuity (piece 5, `05_continuity.md`)

| ID | Mechanism | Status | T | Scope | Basis | Cost | Tests |
|---|---|---|---|---|---|---|---|
| C-R1 | Stop check with stop reasons, record checks, issue read, leak check, break-glass verdict, `patch:` count; reading the main-definition check's results is deferred with C-R9 | active | 1 | installation | CD §2 incident 1; F-036-1; F-041-2; critic finding 6 | M | T-C5, T-R17 |
| C-R2 | S5 self-wake | active | 1 | installation | 1: L-033 | S | T-C2 |
| C-R3 | S2 check-ins and one reminder | active | 1 | installation | OI-011 item 5 | S | T-C3 |
| C-R4 | Check-in residual stated in `DURUM.md` | retired | — | — | merged into M-R15 | — | T-M5r (under M-R15) |
| C-R5 | Self-watchdog at every checkpoint, outcome-unknown recovery | active | 1 | installation | 1: L-039 | S; one `send_later` per checkpoint | T-C2, T-C4, T-21 |
| C-R6 | Expected-text rule, five forms, plus relayed answers recorded as data | active | 1 | installation | operating model §9; R-W12-1 m4; R-R17 | S | T-C4 |
| C-R7 | Dispatcher and heartbeat retired | active | 1d | installation | L-034; OI-010; L-029, L-030 | S | T-R7 |
| C-R8 | Independent detector (scheduled workflow); if P-W12-4 fails, D-005 (Batu) decides, and under its option (b) it is deferred to its trigger | active | 1d | installation | 1: L-039 (K1 fired) | S; free on a public repository | T-C6, T-C7, T-21, T-23 |
| C-R9 | Main-definition record check (`pull_request_target`) | deferred | 2 | installation | R-W12-1 M8; library (control state not writable by the constrained component); deferred after R-W12-2 M-2 to D-08's trigger | S | T-C8 |
| C-R10 | S4 successor with the run brief under the brief gate; a denial is S3 | active | 1 | installation | observed twice under v1.7 (T-C1); the brief-gate part untested | S | T-C1, T-W6 |
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
| H-PRB | Probe-branch rule: `create_session` allowed on `claude/probe-*` branches whose fetched revision carries `.claude/settings.json`; deferred after the classifier refused its test fixtures (L-044) | deferred | 2 | installation | 2: L-037, L-039 (tree switched to probe branches); P-W12-3 needs `.claude/` changes | S; high impact (hook) | T-W14, T-H4 |
| A-07 | Leak check on staged and committed content, run by C-R1 | active | 1 | installation | 3: L-019 B2, L-021 B2, F-041-2 | S | T-MAP7 |

## 2. Carrier tables of the mechanism map

Notation (arrow types M, M\*, I, J; coverage columns Own, Her, Mem, Ver, Rec, Sec): `plan/builder/w-c00-12/07_mechanism_map.md` section 1.

### 2.1 Base steps of a run (formerly `07_mechanism_map.md` section 2)

| # | Step | Arrow into the step | Carrier | Own | Her | Mem | Ver | Rec | Sec |
|---|---|---|---|---|---|---|---|---|---|
| B1 | Session starts; boot map printed | M\* (`SessionStart`, observed once, P-W12-1) | `.claude/settings.json` → `tools/boot_map` (M-R18) | n/a: reads only | failure patterns with labels (R-R7); floor import (R-R6) | home table from `MEMORY_MAP.md`; chain result (M-R4) | chain check printed (M-R4) | clocks and `main` SHA; for the documented `compact` source the re-ground is I until observed (T-M17 c, T-R16) | n/a: no effects |
| B2 | Boot: lease, unmerged branches, Batu's answers, frontier, digest, plan sections the brief names | I (`CLAUDE.md`, operating model §3.1); boot gate R-R18 (deferred) | `CLAUDE.md` | lease row names the session (B3) | boot map (B1) | state file and generated views (M-R6) | a skipped issue read fails the stop (M-R13), so the omission cannot reach `main` | the same boot after a watchdog wake (C-R5) | allow list (H-AL) |
| B3 | Lease take or renew | M\* (`tools/records.py lease`; a merge conflict on the row serialises) | record PR touching the state file | lease row (M-R1) | n/a | state file row; typed times (M-R14) | stop check verifies the lease (C-R1) | expiry at most 3h15m; self-watchdog armed (C-R5) | n/a: repository write only |
| B4 | Select item from the frontier; brief generated | M\* frontier (W-R2) and brief (W-R5); J choice with a logged sentence | `tools/records.py render`, `brief` | `claimed_by` field | the brief's purpose chain and role file (W-R5) | frontier, notes of item and ancestors (M-R3) | choice sampled at closure | the frontier is the re-entry point | n/a |
| B5 | Impact class and triage | M\* class (W-R7); J triage content | `check_records.py impact`; Triager (`.claude/agents/triager.md`) | n/a: subagent | Triager's role file and knowledge map | `impact`, `triage:` fields | R-R5 refuses acceptance without triage; R-R3 the Triager may only raise | recorded on the item | high class for protected paths and fields (W-R7) |
| B6 | Work (reasoning, writing, probes, research) | J | the run; helpers H3, H4, H6, H8 | recorder (H-OWN, M-R11) | floor import (R-R6); trigger at every material change (R-R8) | write-ahead commit before long steps (operating model §3.4) | claims checked at finish (B7) | self-watchdog (C-R5); quality-signal hand-over (R-R9) | allow list (H-AL) |
| B7 | Finish: claims resolve | M\* | `check_records.py claims` (M-R16 a, b) | n/a | n/a | `execution: finished` with evidence paths | evidence paths exist; verdicts bound; session-event claims instructed (M-R16 c, deferred) | n/a: a record step | n/a |
| B8 | Acceptance routed | M\* (class and fields decide the route) | `check_records.py work`, `impact` | n/a | verifier tasks name failure classes (R-R3a) | `acceptance` field (W-R1) | verifier level (R-R3); independence label (W-R1); verdict binding (M-R16 b) | n/a | n/a |
| B9 | PR, checks, merge | M\* at stop (C-R1); the main-definition check on the PR (C-R9) is deferred | `tools/builder_check.sh` | n/a | n/a | kinds (M-R5), views (M-R6), chain (M-R4), docstatus (M-R2), times (M-R14); scope (M-R12, deferred: the rule tables' Scope column, checked by `check_ids.py`, covers rules meanwhile) | leak check on staged content (A-07); session verdict on class-high PRs (W-R7) | merge at every checkpoint (operating model §3.2) | GitHub writes limited to `devos` (H-AL) |
| B10 | Record: log entry, views rendered, `DURUM.md` generated | M\* generation; J prose | `tools/records.py render`, `durum` | owned IDs reach `main` with the record PR (M-R10) | n/a | Record changes block (M-R5); generated `DURUM.md` (M-R15) | view check (M-R6) | the log is the successor's history | n/a |
| B11 | Stop or continue | M\* (stop check with the stop reason) | `tools/builder_check.sh S<n>` (C-R1) | wake and successor IDs owned (M-R11, H-OWN) | n/a | state file, `Armed wakes` row (C-R11), `DURUM.md` | the `/goal` evaluator judges the pasted output (R1) | wake armed (C-R2, C-R3) or successor created (C-R10) | n/a |

### 2.2 Helpers (on demand), with triggers and roles (formerly 07 section 3)

The roles of `04_roles.md` §2 appear here as helpers. Their terminal goals and acceptance edges are the role-and-goal layer of acceptance (g).

| # | Helper | Terminal goal | Trigger (named) | Trigger type | May accept | Carrier | Own | Her | Mem | Ver | Rec | Sec |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| H1 | Verifier, session | find where the claim about this exact commit is false | impact class high; acceptance-block change; stage closure; W-C00-12 composition; T-M9, T-M10 (W-R7, R-R3) | M\* (route computed) | items and PRs whose route names it | `plan/builder/REVIEW_PROMPT.md` (role file) + generated brief (W-R5) | recorder (H-OWN) | role file, floor import (R-R6), boot map (R-R7) | verdict on its branch, copied with `git show` (M-R16 b) | n/a: it is the verifier; its verdict is bound (M-R16 b) | replacement after 2 h without a commit (operating model §11) | allow list (H-AL); brief gate (H-BRF) |
| H2 | Verifier, subagent | the same, for normal items | route says `subagent` (R-R3) | M\* | normal items | `.claude/agents/verifier.md` | n/a: in-process | agent file; floor import (R-R6) | verdict recorded by the run, quoted | labelled `subagent` (W-R1) | re-run in the next session if lost | hook applies inside subagents (observed once, narrowly, L-037) |
| H3 | Counter-designer | the best design from goal and constraints, blind to the incumbent | item type `major-design` (R-R10) | M\* | nothing; compared | `plan/builder/roles/counter-designer.md` | recorder | role file, floor | its file copied unchanged after the leak check (A-07) | comparison closes every difference; outside review judges | left idle until the comparison is read | allow list; brief gate |
| H4 | Probe | report what the platform did, from evidence | an `untested` platform fact blocks an item (W-R11) | M\* | nothing; its observation is evidence | `plan/builder/roles/probe.md` | recorder; probe branch recorded as abandoned | role file | pre-registration before the session exists | the run reads the transcript, not the summary (instructed; M-R16 c deferred) | n/a: one-shot | allow list; brief gate |
| H5 | *Recoverer* | — | — | — | — | **retired** (D-32); T-M9 and T-M10 are run by H1 | — | — | — | — | — | — |
| H6 | Researcher | open the evidence space with each source's status | the brief or the D9 question shows a bearing study | I; tested by T-R2 | nothing | `.claude/agents/researcher.md` | n/a | knowledge map | consulted and left-out sources in the decision record (R-R10) | the producer cites; the verifier may open the source | n/a | read-only tools |
| H7 | Triager | judge how much of each expertise the item needs | item start, class normal (R-R5) | M\* | nothing; can only raise | `.claude/agents/triager.md` | n/a | role file and study catalogue | `triage:` field | a lowering needs a second call (R-R3) | n/a | read-only |
| H8 | Critic (non-binding) | find what a draft gets wrong before a binding review | before H1 on a design artefact (R-R16) | I | nothing | `.claude/agents/critic.md` | n/a | floor import | findings answered in the artefact | non-binding, labelled | n/a | read-only |
| H9 | Frame review | find the premise that created a repeated limit | instructed at the third patch (R-R14 deferred); mandatory if the narrow re-review fails on the same causes (`12_tranche_plan.md` §2) | I | nothing | `FR-nn` decision record (R-R10) | n/a | the squeeze-signal lens | its own record | the next review checks it | n/a | n/a |
| H10 | Batu batch | bring Batu only his decisions and account actions | a frontier item waits on a `class: batu` decision or action | M\* (the frontier marks it); J writing | Batu decides his own | issue #6 comment, Appendix E format | n/a: the issue exists | Appendix E | decision record with `answer_original_tr` | the owner reason is checked (R-R10); a critic read before posting (instructed, X-40) | check-ins and one reminder (C-R3) | machine-account mention only |
| H11 | Wake arming | a session wakes for a wait it owns | stop reason S2 or S5; every checkpoint (C-R2, C-R3, C-R5) | M\* (the stop check requires it) | n/a | `send_later` into the run itself | `send_later` ID recorded (M-R11) | n/a | `Armed wakes` row (C-R11) | the stop check verifies (C-R1) | the wake is the recovery path | expected-text rule (C-R6) |
| H12 | Successor | the chain continues at S4 | stop reason S4 | I, after the stop check (C-R10); the stop check requires nothing about the successor (C-R1) | n/a | `create_session` with the generated brief | recorder (observed, T-C1) | generated brief (W-R5) | hand-over log entry | the successor's boot checks the lease and `main` | T-C1 observed twice under v1.7, not counted for C-R10 (C-R10 counts it only after 1c) | brief gate (H-BRF); revision check (H-REV) |
| H13 | Plan-change candidate | record discovered work outside the plan | discovered work outside an admitted stage's scope; a plan contradiction | I, with a format gate (W-R3) | the owner decides (`03_work_model.md` §5) | candidate item and `PC-nn` record | n/a | n/a | candidate never in the frontier (W-R3) | technical: a verifier; Batu-class: H10 | n/a | n/a |
| H14 | Pattern qualification | promote a candidate failure pattern | tranche 1c's review; afterwards at stage closure | I; checked by T-R12 | the qualifier, not the producer (R-R7) | verifier session or subagent | n/a | the pattern itself | `status` with `qualified_by` | `qualified_by` ≠ producer (R-R7) | n/a | n/a |
| H15 | Independent detector | report a stall or a missed wake, or say that it cannot judge | hourly schedule (C-R8) | M\* (a session can change it through a class-high, session-verified PR, whatever P-W12-4 shows); if P-W12-4 fails, Batu's D-005 decides whether it exists | n/a | `.github/workflows/watchdog.yml` | n/a: holds no session credential | n/a: no reasoning | reads the state file; writes nothing to the repository | UNKNOWN when it cannot parse (T-C7) | alerts Batu; the next session resumes (T-21) | `issues: write` only, default token |
| H16 | *Main-definition record check* (C-R9, deferred) | run `main`'s checker on a PR's records | every PR, when re-admitted (C-R9, deferred) | M (report), M\* (consequence), when re-admitted | n/a | `.github/workflows/records-check.yml` | n/a | n/a | reads the PR's records as data | report-only until a required check exists | n/a | no PR code executes |
| H17 | Batu's conversation session (actor) | carry Batu's requests into the repository; start runs | Batu writes | J | nothing | Batu's own session | lease take before any record write (R-R17) | `CLAUDE.md`, boot map | records only under the lease | T-R10 at closure | n/a | the same hook (H-AL) |
| — | Dispatcher, heartbeat | — | — | — | — | **retired** (C-R7, tranche 1d) | — | — | — | — | — | — |

### 2.3 Carriers that serve many components (formerly 07 section 4)

| # | Carrier | Holds | Runs when | Type |
|---|---|---|---|---|
| A-01 | `.claude/hooks/tool_allowlist.py` | allow list (H-AL), owned-ID rule (H-OWN), revision check (H-REV), brief gate (H-BRF); since D-008 an explicit allow or deny with a written reason for every call, `PermissionRequest` answers, file and shell bans, the decision log, and the call to the merge gate (W-C00-12.6); boot gate (H-BOOT) and compaction gate (H-CMP) deferred; reading gate (H-READ) retired | every tool call | M\* (a session can edit its own hook; residual accepted by Batu, D-003 (a)) |
| A-02 | `.claude/hooks/record_owned_id.py` | recorder for sessions, routines and `send_later` (M-R11) | after create calls | M\* |
| A-03 | *read receipts hook* | session-event claims (M-R16 c) | — | deferred |
| A-04 | `tools/check_records.py` | `chain`, `kinds`, `views`, `work`, `impact`, `docstatus`, `stamps`, `claims`, `decisions`, `map` (a `scope` subcommand is added only when M-R12, deferred, is re-admitted); helper modes `all`, `merged` (the stop check's per-merge checks), `answers` (M-R13), `leak` (A-07 on staged and untracked content) and `gate` (the merge gate the guard runs before every merge, W-C00-12.6) | stop check; every merge | M\* |
| A-05 | `tools/builder_check.sh S<n>` | the stop check (C-R1) | before every stop; R1 requires its output | M\* |
| A-06 | `tools/test_tool_allowlist.sh` | hook unit tests with mutation checks (T-H4); since D-008 the guard's decisions, bans and reasons (T-G1) | every hook change; counts only on a pushed branch | M\* |
| A-07 | `tools/check_service_names.sh`, run by A-05 on staged and committed content | leak check | every stop and every public copy | M\* |
| A-08 | `tools/boot_map` | boot map (M-R18) | every `SessionStart` | M\* |
| A-09 | `.github/workflows/watchdog.yml` (and `records-check.yml` when C-R9, deferred, is re-admitted) | detector (C-R8) | hourly | M\* (H15) |
| A-10 | `tools/test_records.py` | gate tests of tranche 1b-i (T-W10, T-W15, T-W2, T-W5, T-W7, T-W12) with mutation checks | every change to `tools/records.py`; output pasted into `evidence/C00/tests/1b-i_gate.md` | M\* |
| A-11 | `tools/test_check_records.py` | gate tests of tranche 1b-ii (12 section 2.2) in scratch repositories, with mutation checks | every change to `tools/check_records.py` or `tools/builder_check.sh`; output pasted into `evidence/C00/tests/1b-ii_gate.md` | M\* |
| A-12 | `tools/check_dispatcher_pr.sh` | scope check of the dispatcher's standing record PR (operating model v1.7 §2.3) | at boot, while a dispatcher PR is open; removed when C-R7 (1d) retires the dispatcher | M\* |
| A-13 | `tools/guard_report.py` | the guard's decision report: denials with rule and reason, allowed calls counted by rule (W-C00-12.6 (c); D-008) | at every checkpoint and stop of a run, into its log entry | M\* |
| A-14 | `tools/sync_worktree.sh` | the only way the live working tree moves: a fast-forward to `origin/main` that loses no owned ID (guard rule B4; W-C00-12.6) | when a session needs `main`'s current guard or records in its own tree | M\* |
| A-15 | `tools/test_merge_gate.py` | planted cases of the merge gate with a mutation check (T-G2) | every change to the gate in `tools/check_records.py` | M\* |
