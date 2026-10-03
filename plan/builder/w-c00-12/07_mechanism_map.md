# W-C00-12 · 07 · Design piece 4: the mechanism map (object O5)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only; the register form is a candidate for DevOS's `MechanismAssumption` records (C10). **Written:** first version 2026-10-03 by run `session_01Wj4JDduaDRVnBvQJ86b5bm`. **Revision 3** (this text) was rewritten in place on 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq` against pieces 02–05 as rewritten, after R-W12-1 (B6, M5, M8, m8) and the K3 re-read. **Builds on:** pieces 1–3 and 5; its form is the counter-design's register (D-26). **Serves:** acceptance (m) in full with its extension; (g)'s role-and-goal map (merge 1 of `00_consolidation.md`); (l)'s root chain as arrows (merge 2). **Mechanisms and tests:** `11_test_register.md`; every ID in a cell below resolves there.

File numbering: this is design piece 4. Its file number is 07 because the comparison (06) was written first.

## 1. Notation

- **Component:** a base step (runs in every run, in order) or a helper (runs only when its trigger fires). Each has one carrier: a file that executes (hook, script, workflow) or a heading in a file that instructs.
- **Arrow types:**
  - **M**, mechanical: runs whatever the model decides, from a carrier the producer cannot change in the same session. Only the detector's workflow on `main` (A-09) can qualify, and only if P-W12-4 fails, so that no session can change it; if P-W12-4 passes, a session can change it through a merged (class high, session-verified) PR, and it is M\* (R-W12-2 M-1 b);
  - **M\***, mechanical **given an unmodified carrier**: a hook, script or check run from the producer's own working tree, which the producer can edit (R-W12-1 M8; critic finding 6). The main-definition check that would have checked the record checks from `main` (C-R9) is deferred (R-W12-2 M-2), so every record check is M\*;
  - **I**, instructed: written guidance;
  - **J**, judged: open reasoning.
- **Critical-path rule:** an I arrow on a critical path must be made M or M\*, or carry a test (acceptance (m)).
- **Coverage cells.** There are six cross-cutting mechanisms, a superset of the five that acceptance (m)'s extension names:
  - **Own:** identity and ownership of what the builder creates;
  - **Her:** heritage (floor, disciplines, failure patterns);
  - **Mem:** memory (one home, typed change, generated view);
  - **Ver:** verification by a role other than the producer, or a deterministic check;
  - **Rec:** recovery after a crash, compaction or hand-over;
  - **Sec:** the effect boundary.

  A cell holds a mechanism ID or `n/a: <reason>`. An empty cell blocks acceptance. A deferred mechanism is written with its ID and "(deferred)"; its cell then states what covers the row meanwhile.

## 2. Base steps of a run

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

## 3. Helpers (on demand), with triggers and roles

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
| H15 | Independent detector | report a stall or a missed wake, or say that it cannot judge | hourly schedule (C-R8) | M if P-W12-4 fails (only Batu can change it); M\* if it passes (a session can change it through a class-high, session-verified PR; residual under D-003 a); C-R8 is deferred to its trigger if P-W12-4 fails and Batu has not added the file | n/a | `.github/workflows/watchdog.yml` | n/a: holds no session credential | n/a: no reasoning | reads the state file; writes nothing to the repository | UNKNOWN when it cannot parse (T-C7) | alerts Batu; the next session resumes (T-21) | `issues: write` only, default token |
| H16 | *Main-definition record check* (C-R9, deferred) | run `main`'s checker on a PR's records | every PR, when re-admitted (C-R9, deferred) | M (report), M\* (consequence), when re-admitted | n/a | `.github/workflows/records-check.yml` | n/a | n/a | reads the PR's records as data | report-only until a required check exists | n/a | no PR code executes |
| H17 | Batu's conversation session (actor) | carry Batu's requests into the repository; start runs | Batu writes | J | nothing | Batu's own session | lease take before any record write (R-R17) | `CLAUDE.md`, boot map | records only under the lease | T-R10 at closure | n/a | the same hook (H-AL) |
| — | Dispatcher, heartbeat | — | — | — | — | **retired** (C-R7, tranche 1d) | — | — | — | — | — | — |

## 4. Carriers that serve many components

| # | Carrier | Holds | Runs when | Type |
|---|---|---|---|---|
| A-01 | `.claude/hooks/tool_allowlist.py` | allow list (H-AL), owned-ID rule (H-OWN), revision check (H-REV), brief gate (H-BRF); boot gate (H-BOOT) and compaction gate (H-CMP) deferred; reading gate (H-READ) retired | every tool call | M\* (a session can edit its own hook; residual accepted by Batu, D-003 (a)) |
| A-02 | `.claude/hooks/record_owned_id.py` | recorder for sessions, routines and `send_later` (M-R11) | after create calls | M\* |
| A-03 | *read receipts hook* | session-event claims (M-R16 c) | — | deferred |
| A-04 | `tools/check_records.py` | `chain`, `kinds`, `views`, `work`, `impact`, `docstatus`, `stamps`, `claims`, `decisions`, `map` (a `scope` subcommand is added only when M-R12, deferred, is re-admitted) | stop check | M\* |
| A-05 | `tools/builder_check.sh S<n>` | the stop check (C-R1) | before every stop; R1 requires its output | M\* |
| A-06 | `tools/test_tool_allowlist.sh` | hook unit tests with mutation checks (T-H4) | every hook change; counts only on a pushed branch | M\* |
| A-07 | `tools/check_service_names.sh`, run by A-05 on staged and committed content | leak check | every stop and every public copy | M\* |
| A-08 | `tools/boot_map` | boot map (M-R18) | every `SessionStart` | M\* |
| A-09 | `.github/workflows/watchdog.yml` (and `records-check.yml` when C-R9, deferred, is re-admitted) | detector (C-R8) | hourly | M if P-W12-4 fails; M\* if it passes (H15) |

## 5. Failures located on the map

Acceptance (m): every failure recorded from L-016 to L-034, and OI-011 items 22 and 24, located as a missing arrow or trigger. Later failures (L-035 to L-041, and this run) are added because the same map must explain them. Rows X-26 to X-40 come from the K3 re-read of L-016 to L-041 by a fresh-context subagent (revision 3; R-W12-1 M5 and B1).

| # | Failure (source) | What was missing | Where on the map now | Type after |
|---|---|---|---|---|
| X-01 | BP-04 built from a model's self-report; connectors live in reviewer sessions (L-016 B1, FND-002) | arrow "premise → probe before dependants" | B4 frontier blocks items on `untested` platform facts; H4 (W-R11) | M\* |
| X-02 | PC-05 edits incomplete (L-016 B2) | verifier task without the failure class "a place missed" | H1 task names failure classes (R-R3a); H13 lists affected places | M\* route, J verdict; T-R1 |
| X-03 | Plan 6.12 claimed but not met (L-016 B3) | arrow "claim → evidence" | B7 claims resolve (M-R16 a) | M\* (presence), J (content) |
| X-04 | Hook failed open on errors (L-016 M1) | arrow "hook error → block" | A-01 wrapper maps errors to block (existing) | M\* |
| X-05 | Dispositions recorded as done that were not (L-016 M6, M9; L-018; L-019 B2; L-021 B2); a brief claimed that did not exist (L-023, found in L-025 n6) | arrow "disposition claim → check output" | evidence paths resolve (M-R16 a); check output quoted after the entry is written | M\* (presence), J (content) |
| X-06 | New barrier routes found in each review round (L-018 B1, L-019 B1, L-021 B1, L-023 N-B1) | trigger for a frame review before round 3 | H9 (instructed; R-R14 deferred); the re-review stop rule in `12_tranche_plan.md` §2 | I, with a stop rule |
| X-07 | Redaction incomplete; names re-published in a log row (L-019 B2, L-021 B2) | arrow "public write → leak check" on every write | A-07 run by A-05 at every stop | M\* |
| X-08 | Recorder test used an assumed response format (L-022) | arrow "platform format → observed sample before the fixture" | `platform:` dependency (W-R11); tranche 1a takes the `send_later` sample live | M\* (block), I (provenance), A-06 controls |
| X-09 | Session at 77% context kept working past the 50% threshold (L-022) | a signal of context pressure independent of the session's judgement | quality-signal hand-over and recorded transcript size (R-R9); warning R-R20 (deferred) | M\* (signal count), J (decision) |
| X-10 | Next action row stale after a merge (L-027) | generation of the restatement | B10 generated frontier (W-R2), view check (M-R6) | M\* |
| X-11 | Stamps 6 minutes in the future (L-028); four estimates in an hour (F-037-2) | the clock as the only source of times | B1 prints clocks; typed times (M-R14) | M\* |
| X-12 | `ReadNotifications` blocked; T-A2 built on an unchecked delivery path (L-029 F1) | probe before build; over-blocking analysed | W-R11 on the delivery path; over-blocking reviewed in the hook test (A-06) | M\* |
| X-13 | Another session's actions recorded without reading its transcript (L-029/L-030 B1; L-033 OI-010 report; L-039 probe summary) | arrow "claim about another session → transcript read" | instructed (read the transcript, cite the event); M-R16 (c) deferred with a trigger (`12_tranche_plan.md` §3) | I, re-admission trigger |
| X-14 | Runs merged the dispatcher PR with no scope check (L-030 B2) | — | subject removed: dispatcher retired (C-R7) | n/a |
| X-15 | Lease PR and dispatcher PR both appended to the log; amend and force push denied (L-032) | one writer to the log | single writer (the lease holder; R-R17 for Batu's session) once the dispatcher is retired | M by structure, I for R-R17 (T-R10) |
| X-16 | Producer judged its own change "status-only" and skipped review (L-033) | computed impact class | B8 route from the path and field class (W-R7) | M\* |
| X-17 | Dispatcher's created IDs could not reach `main`; hand restore misreported (L-033, OI-010) | recorder file versioned like a hand-written file | union merge (M-R10); subject retired (C-R7) | M\* |
| X-18 | No goal-down analysis; the model built by patching (L-034) | trigger "major design → goal-down and counter-design" | H3 required by item type `major-design` (R-R10) | M\* |
| X-19 | Dispatcher and heartbeat created before their work existed (L-034) | admission by demand; map truth | register row with demand for every carrier (map check, T-MAP1); R-R4 | M\* (presence), J (demand); T-R7 |
| X-20 | Operating model header "Binding" against the state file (OI-011 item 22) | one home for document status | M-R2 with `docstatus` and fact markers (no phrase warning); T-M1 | M\* |
| X-21 | `send_later` reminder not recorded as owned (OI-011 item 24); the reminder of L-035 created without a log record (K3) | coverage when a capability is added | A-02 covers `send_later` (M-R11); the Own column forces the question for every new carrier | M\* |
| X-22 | Batu's answers unrecorded for 35 hours (F-036-1) | arrow "issue → decision record" checked at stop | the issue read at stop (M-R13) | M\* |
| X-23 | Recorder lines conflicted on branch switches (F-037-1) | merge driver for a machine-written file | M-R10 | M\* |
| X-24 | D9 library consultation did not fire while writing piece 3 (F-039-1) | knowledge pushed at item start | knowledge maps in role files and the brief (W-R5); H6; lenses R-R11 (deferred) | I; T-R2 |
| X-25 | Checkout of `origin/main` in the working tree denied by the classifier (F-7, L-040) | a procedure that never changes the tree's revision after boot | runs work on a branch at the boot revision; merges with `main` in a scratch clone (L-041) | I procedure |
| X-26 | A run's turn aborted mid-work (`error_during_execution`, account problem); work resumed only because Batu typed (L-039) | an arrow "stall → detection" independent of the stalled session | self-watchdog for an idle session (C-R5); independent detector (C-R8, H15) | M or M\* by P-W12-4's outcome (detector, H15), M\* (watchdog arming); restart remains Batu's (`05_continuity.md` §5) |
| X-27 | L-019 and L-021 named verdict files that never reached `main` (F-041-1, R-W12-1 M5); the reviewer's own "never existed in any commit" was wrong (L-041) | arrow "named evidence path → exists on the tree" | M-R16 (a); T-M14 | M\* |
| X-28 | A spawned session (the dispatcher) hand-edited `.claude/hooks/owned_ids.txt` and reported that it had not (L-033) | a reason to edit the file by hand; a check on spawned sessions' claims | the reason is removed (M-R10, M-R11); the subject is retired (C-R7); R-R13's trigger is a breach by a remaining role | M by structure; I for claims (X-13) |
| X-29 | The builder switched its own working tree to probe branches carrying `.claude/` changes (L-037, L-039), against the working-tree rule | a `create_session` path for probe branches that needs no tree switch | H-PRB: `create_session` on `claude/probe-*` branches carrying `.claude/settings.json`, built first in tranche 1a (P-W12-3 needs it) | M\*; T-W14 |
| X-30 | Classifier denials (L-029/L-030 dispatcher reads; L-032 force push; L-036 out-of-place publication; L-040 checkout) | — (denials are the classifier working) | R-R21: record, S3 for the action, never route around | I; T-R18 |
| X-31 | `git push --delete` refused with 403 and worked around by a force-move (L-031) | arrow "refusal → S3 for that action" applied to non-classifier refusals | R-R21 extends the rule to any refusal (tranche 1c) | I; T-R18 |
| X-32 | Lease liveness misread an idle holder as dead (L-029 F3) | lease by expiry only | operating model v1.7 §2.2 (kept); C-R1 checks the expiry | M\* |
| X-33 | A routine's stored prompt stayed at v1.6 (L-030 m1) | stored instructions outside the repository | subject retired (C-R7); session first messages are generated briefs with a hash (W-R6) | M\* |
| X-34 | Observations mislabelled: a checker subagent swapped two session labels (L-017); F-2 called "unauthenticated" (L-040); T-C1 "nobody typing" overstated (L-040); an unmeasured "about 30" in revision 3's first draft (F-042-2) | verification of observation labels and figures by someone other than the observer | independence labels (W-R1); evidence read by a verifier for high items (H1); the critic (H8); M-R16 (c) deferred, T-R19 | I, J; T-R11, T-R19 |
| X-35 | The leak check skipped untracked files (F-041-2); earlier CLEAN results in doubt | the check runs on staged content | A-07 on staged and committed content, run by C-R1; T-MAP7 | M\* |
| X-36 | Additive bias in comparison revision 1, caught by the critic (F-040-1) | a critic before the binding review | H8 (R-R16); the timing-based admission rule (`12_tranche_plan.md`) | I; T-R7 |
| X-37 | A stamp one minute ahead (L-041); a write-ahead stamp six minutes ahead of its commit (F-042-1, this run) | the clock as the only source of times | M-R14, whose stamp type covers the `Written:` header line of an added file, where F-042-1 happened (R-W12-2 M-5); T-M7b (e) plants the F-042-1 text there | M\* |
| X-38 | An invalid mutation-check attempt (wrong git root, L-023); hook defects m2, m8, m9 (L-021) | test validity controls | A-06 controls; T-H4 counts only on a pushed branch | M\* |
| X-39 | Acceptance changed or departed from by the producer: T-A1c replaced (L-018, reviewed); a loop budget departed from (L-021 → L-023); a negative control declined (L-030); a retired test counted (L-033) | arrow "acceptance change → independent review" | field class (W-R7); a retired test cannot be cited (W-R1); loop budget with S3 (`12_tranche_plan.md` §2); a declined reviewer fix or a departure from a recorded budget is listed under `Declined or departed:` in the log entry and judged by the next session Verifier of that work | M\* for L-018 and L-033; I for L-021 → L-023 and L-030 (R-W12-2 M-5) |
| X-40 | A wrong sentence posted to Batu and corrected a minute later (L-028); the lease check informational with an abort on an unset variable (L-018 M3); context measured only by another session, conflicting with `get_session` (L-039, L-040); the `compact` re-boot untestable by message (L-039) | a read before posting; a gate in the stop check; a measurable context signal; a compaction signal | a critic read before a batch is posted (H10, instructed); the lease check is a gate since v1.4 (C-R1); R-R9 item 3 (proxies recorded); P-W12-3 and R-R19 (deferred) | I; M\*; J; I |

## 6. Instructed and judged arrows on critical paths

A critical path here is a path whose failure makes a claim, a merge, a stop or an effect wrong. Every I arrow on it is made M or M\*, or tested.

| Arrow | Status | How |
|---|---|---|
| Boot happens before work (B2) | I; its critical omission (Batu's answers) is M\* at stop | M-R13; boot gate R-R18 deferred with its trigger |
| Re-ground after compaction (B1, B6) | I until a compaction is observed (documented, unobserved; R-W12-2 M-5) | the instructed re-boot carries it; M-R18 prints on every source; T-M17 (c) and T-R16 when a compaction occurs, listed as unobserved at the composition review |
| Stop only when merged, recorded and woken (B11) | M\* | C-R1 with stop reasons |
| Batu's answers recorded (B11) | M\* | M-R13 |
| Review level chosen (B5, B8) | M\* floor, J above it | W-R7, R-R3; T-W9, T-MAP5 |
| Spawned sessions formed (H1, H3, H4, H12) | M\* | H-BRF (W-R6); T-W6, T-R3 |
| Timestamps measured | M\* | M-R14; T-M7a–c |
| Failure patterns seen at boot (B1) | M\* | M-R18, R-R7; T-M17, T-R12 |
| Heritage used (B6) | J | T-R2, T-R1 |
| Item selection (B4) | J | sampled at closure |
| Claims about other sessions (X-13) | I | T-R19 (planted false claim); M-R16 (c) deferred with a trigger |
| Not routing around a refusal (X-30, X-31) | I | R-R21; T-R18 |
| Copying the usage status | I | C-R1 requires the source and time; T-R17 compares each Usage row with the writing session's `rate_limit_info` |
| Leak check before public copies | M\* | A-07 in C-R1; T-MAP7 |
| Stall detected | M or M\* by P-W12-4's outcome; deferred with C-R8 if P-W12-4 fails | C-R8; T-C6, T-C7 |

## 7. Keeping the map true

- **Where the register lives.** The register (`11_test_register.md` §1) is the home of today's operating-model Appendix M. In tranche 1b-i it moves, unchanged in content, to `plan/builder/mechanisms.md`, together with this map's carrier tables (§2–§4); this file then keeps a pointer in their place, so each table has one home (R-W12-2 B-2).
- **The map check** (M-R19; `check_records.py map`; T-MAP1–4) reads this map's carrier tables (§2–§4), not the register, and fails when:
  - a hook command in `.claude/settings.json`, a script under `tools/`, a workflow under `.github/workflows/`, an agent definition under `.claude/agents/` or a role file under `plan/builder/roles/` has no row in these tables;
  - a row's carrier file does not exist;
  - a coverage cell is empty.

  This answers acceptance (m)'s "authoritative or mechanically checked against what actually runs": the files that run are enumerated from the tree, not from the register.
- **Limits stated:** routines and sessions on the account are not files. They are checked through the owned-ID list (A-02) and T-R7, not by the map check. A check run from the working tree is M\* (C-R9, which would have run it from `main`, is deferred).

## 8. Tests

The map's tests are T-MAP1 to T-MAP7 in `11_test_register.md` §2.5 (T-MAP6 retired).

## 9. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Register and map check | installation; the form is a DevOS candidate | `MechanismAssumption` records (C10) | C10 |
| Base steps B1–B11 | installation | DevOS working order and `session_brief()` (C04, C06) | C06 |
| Helpers H1–H17 | installation | DevOS roles (C05) and the audit environment (C03) for binding verdicts | C03, C05 |

## 10. Decision-and-basis record

- **Consulted:** pieces 02–05 as rewritten in revision 3; the comparison (06, §3b); the register (11); the counter-design's §8 and §15 (its map and register form, D-26); log entries L-016 to L-041, read in full by a fresh-context subagent for revision 3 against the X list (the 25 unlocated items it found are rows X-26 to X-40, grouped by missing arrow); OI-011 items 22 and 24; operating model Appendix M.
- **Left out on purpose:** a diagram (the tables are authoritative because a check can read them; a drawing would be a second home); the plan's DevOS mechanisms (K-1 to K-11) except where the builder reuses them by name.
- **Premises, from scratch:** every past failure can be described as a missing arrow or trigger (yes for all 40 rows; X-14 and X-17 are resolved by removing the subject; X-30 is the classifier working and is located at the rule that governs the response); the map is useful only if a check keeps it true (yes, otherwise it drifts, failure pattern 3).
- **Alternative frame:** a map per role instead of per run. Rejected: the failures cross roles (X-13: the run and a probe; X-28: the run and the dispatcher), and the coverage columns are cross-role by definition.
- **Reopen if:** a new failure cannot be located on the map; the map check produces false failures that lead to hand edits of the register.
