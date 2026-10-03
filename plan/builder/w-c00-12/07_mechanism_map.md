# W-C00-12 · 07 · Design piece 4: the mechanism map (object O5)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only; the register form is a candidate for DevOS's `MechanismAssumption` records (C10). **Written:** 2026-10-03 by run `session_01Wj4JDduaDRVnBvQJ86b5bm`. **Builds on:** pieces 1–3 and 5 as revised by the comparison (`06_counter_design_comparison.md` revision 2, §7); its form is the counter-design's register (D-26). **Serves:** acceptance (m) in full with its extension; (g)'s role-and-goal map (merge 1 of `00_consolidation.md`); (l)'s root chain as arrows (merge 2).

File numbering: this is design piece 4; its file number is 07 because the comparison (06) was written first, as the state file's frontier ordered.

## 1. Notation

- **Component:** a base step (runs in every run, in order) or a helper (runs only when its trigger fires). Each has one carrier: a file that executes (hook, script, workflow) or a heading in a file that instructs.
- **Arrow type:** **M** mechanical (runs whatever the model decides), **I** instructed (written guidance), **J** judged (open reasoning). An I arrow on a critical path must be made M or carry a test (acceptance (m)).
- **Coverage cells:** six cross-cutting mechanisms, a superset of the five that acceptance (m)'s extension names: **Own** (identity and ownership of what the builder creates), **Her** (heritage: floor, disciplines, failure patterns, lenses), **Mem** (memory: one home, typed change, generated view), **Ver** (verification by a role other than the producer, or a deterministic check), **Rec** (recovery after a crash, compaction or hand-over), **Sec** (effect boundary). A cell holds a mechanism ID or `n/a: <reason>`. An empty cell blocks acceptance.
- **Mechanism IDs** used in cells: memory piece M-R1 to M-R11; work piece W-R1 to W-R6; roles piece R-R1 to R-R5; comparison dispositions D-nn; hook rules H-AL (allow list), H-OWN (owned-ID recorder and rule), H-REV (revision check on `create_session`), H-BOOT (boot gate, D-01), H-CMP (compaction gate, D-02), H-BRF (brief gate, W-R6), H-READ (reading gate, D-12). Role profiles (D-13) are deferred; cells that would use them name the allow list.

## 2. Base steps of a run

| # | Step | Arrow into the step | Carrier | Own | Her | Mem | Ver | Rec | Sec |
|---|---|---|---|---|---|---|---|---|---|
| B1 | Session starts; boot map printed | M (`SessionStart` hook, observed once, P-W12-1) | `.claude/settings.json` `SessionStart` → `tools/boot_map` | n/a: reads only | qualified failure patterns printed (R-R5 heritage, D-10) | map from `MEMORY_MAP.md` (M-R4 root) | chain check M-R4 | prints clocks and `main` SHA; same output after `compact` (D-02) | n/a: no effects |
| B2 | Boot: lease, unmerged branches, dispatcher-free, Batu answers, frontier, digest; receipt written | M gate (H-BOOT) forces it before any write; the command is named in `CLAUDE.md` | `tools/boot --role <role>` | records the session as lease holder (lease row) | prints the item card's lenses later (B4) | state file and generated views (M-R6) | unrecorded Batu answers detected (D-04) | re-run by `--recover` after compaction (H-CMP) | boot gate H-BOOT; the brief's role line decides what boot prints (D-01) |
| B3 | Lease take or renew | M (in `tools/boot`; merge conflict on the row acts as compare-and-swap) | `tools/boot`, record PR | lease row names the session | n/a | state file row (M-R1) | stop check verifies lease (existing `builder_check.sh`) | expiry at most 3h15m; self-watchdog wake (D-28) | n/a: repository write only |
| B4 | Select item from the frontier; card printed | M frontier and card; J choice (one sentence logged) | `tools/records.py frontier`, `card` | `claimed_by` field | tag-matched lenses and D1–D9 questions on the card (D-10, D-11) | generated frontier (W-R2), notes of item and ancestors (M-R3) | choice sampled at closure (D-06) | the card is the re-entry point after `--recover` | n/a |
| B5 | Triage | M (the work check refuses acceptance without a triage record, R-R5); J content | Triager subagent (`.claude/agents/triager.md`) | n/a: subagent | Triager's role file and knowledge map | `triage:` field | computed path class sets the floor (D-06) | recorded on the item, so a successor reads it | path class marks high-impact items (D-06) |
| B6 | Work (reasoning, writing, probes, research) | J | the run; helpers H3–H6 | recorder logs created IDs (H-OWN, M-R11) | floor read through the reading gate (H-READ, D-12); trigger at every material change (D-11) | write-ahead commit before long steps (operating model §3.4) | read receipts for citations (D-09) | compaction gate (H-CMP); transcript-size warning (D-05) | allow list (H-AL) |
| B7 | Finish: evidence references resolve, lens dispositions given | M format gate; J content | `tools/records.py finish` | n/a | lens dispositions required (D-10) | `execution: finished` with evidence paths | citations checked against receipts (D-09) | n/a: a record step | n/a |
| B8 | Acceptance routed | M (path class and item fields decide the route) | `tools/check_records.py work`, `impact` | n/a | verifier tasks name failure classes (R-R3a) | `acceptance` field (W-R1) | verifier by level (R-R2, R-R3); verdict binding (D-07) | n/a | n/a |
| B9 | PR, checks, merge | M checks at stop (mandatory); CI deferred (D-08) | stop check | n/a | n/a | kind check M-R5, view check M-R6, chain M-R4, markers D-24, stamps M-R9/D-25 | squeeze check D-17; leak check (§4 A-07) | merge at every checkpoint (operating model §3.2) | GitHub writes limited to `devos` (H-AL) |
| B10 | Record: log entry, views rendered, `DURUM.md` generated | M generation; prose J | `tools/records.py log`, `render` | owned IDs reach `main` with the record PR (union merge M-R10) | n/a | Record changes block (M-R5, D-19); `DURUM.md` generated (D-22) | view check (M-R6) | the log is the successor's history | n/a |
| B11 | Stop or continue | M (stop check with stop reason; wake or successor required; no unrecorded answers) | `tools/builder_check.sh` (extended, D-03); `Stop` hook if P-02 passes | wake and successor IDs owned (H-OWN) | n/a | state file and `DURUM.md` current | the evaluator judges the check output (R1) | wake armed (S2, S5), successor created (S4) | n/a |

## 3. Helpers (on demand), with triggers and roles

The roles of `04_roles.md` §2 appear here as helpers; their terminal goals and acceptance edges are the role-and-goal layer of acceptance (g).

| # | Helper | Terminal goal | Trigger (named) | Trigger type | May accept | Carrier | Own | Her | Mem | Ver | Rec | Sec |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| H1 | Verifier, session | find where the claim about this exact commit is false | path class high, acceptance-condition change, stage closure, W-C00-12 composition (R-R3, D-06) | M (route computed) | items whose route names it; composition verdicts | `plan/builder/roles/verifier.md` + generated brief | recorder (H-OWN) | role file, floor import, boot-map patterns | verdict file on its branch, copied by `git show` (D-07) | n/a: it is the verifier; its verdict is checked for binding (D-07) | replacement after 2 h without a commit (operating model §11) | allow list (H-AL); role profiles deferred (D-13) |
| H2 | Verifier, subagent | same, for normal items and samples | route says `subagent`; sample bucket hit (D-06) | M | normal items; samples | `.claude/agents/verifier.md` | n/a: in-process | agent file; floor through the reading gate (H-READ) | verdict recorded by the run with the subagent's output quoted | labelled `subagent` independence (R-R2) | re-run in the next session if lost | hook applies inside subagents (observed once, L-037) |
| H3 | Counter-designer | the best design from goal and constraints, blind to the incumbent | item type `major-design` (D-30) | M (type requires it in the route) | nothing; compared | `plan/builder/roles/counter-designer.md` | recorder | role file, floor | its file copied unchanged after the leak check | comparison closes every difference; the outside review judges | session left idle until the comparison is read | allow list (H-AL) |
| H4 | Probe | report what the platform did, from evidence | an `untested` `platform:` dependency blocks an item (D-27) | M | nothing; its observation is evidence | `plan/builder/roles/probe.md` | recorder; probe branch recorded as abandoned | role file | pre-registration before the session exists | the run reads the transcript, not the summary (D-09 receipts; L-030 rule) | n/a: one-shot | allow list (H-AL) |
| H6 | Researcher | open the evidence space with each source's status | card shows an open question; D9 answered yes; a `question` lens with `consult-source` | I (card-prompted); tested by T-R2 | nothing | `.claude/agents/researcher.md` | n/a | knowledge map | consulted and left-out sources go into the decision-and-basis record (D-30) | the producer cites; the verifier may open the source | n/a | read-only tools |
| H7 | Triager | judge how much of each expertise the item needs | item start (B5) | M | nothing; its record sets the floor of depth | `.claude/agents/triager.md` | n/a | role file and study catalogue | `triage:` field | second Triager call to lower a level (R-R5) | n/a | read-only |
| H8 | Critic (non-binding) | find what a draft gets wrong before a binding review | before H1 on a design artefact | I | nothing | in-process general subagent with a fixed prompt section in the role file | n/a | floor import | findings recorded with responses in the artefact | non-binding by definition; labelled | n/a | read-only |
| H9 | Frame review | find the premise that created a repeated limit | third `Patches: M-x`; a review with five or more findings on one artefact (D-17) | M | nothing | decision record `FR-nn` (D-30 fields) | n/a | the squeeze-signal lens | its own record with premises and alternative frames | the next review checks it | n/a | n/a |
| H10 | Batu batch | bring Batu only his decisions and account actions | a frontier item waits on a Batu-class decision or action | M (frontier marks it); J writing | Batu decides his own | issue #6 comment, Appendix E format | n/a: the issue exists | Appendix E | decision record `D-nnn` with `answer_original_tr` | `class: batu` needs an owner reason (CD §11 check, adopted with D-30) | check-in wakes and the §8 reminder (D-28) | machine account mention only |
| H11 | Wake arming | a session wakes for a wait it owns | stop reason S2 or S5; every checkpoint (watchdog) (D-03, D-28) | M (stop check requires it) | n/a | `send_later` into the run itself | `send_later` ID recorded (M-R11) | n/a | wake recorded in the state file | stop check verifies (D-03) | the wake is the recovery path | expected-text rule for notifications (operating model §9) |
| H12 | Successor | the chain continues at S4 | stop reason S4 | M (stop check requires the successor ID) | n/a | `create_session` with the generated run brief | recorder (observed, T-C1) | generated brief (W-R5) | hand-over log entry | the successor's boot verifies the lease and `main` | T-C1 PASS, observed once | brief gate (H-BRF), revision check (H-REV) |
| H13 | Plan-change candidate | record discovered work outside the plan | discovered work outside an admitted stage's scope; a plan contradiction | I + format gate | the owner decides (piece 2 §5) | candidate item and `PC-nn` record | n/a | n/a | candidate never in the frontier (W-R3) | technical: verifier; Batu-class: H10 | n/a | n/a |
| H14 | Lens qualification | promote a candidate lens or failure pattern | a candidate older than one stage, or used three times | I; checked at closure | the qualifier, not the producer | verifier session or subagent | n/a | the lens itself | `status` field with `qualified_by` | reviewer opens the source | n/a | n/a |
| — | Dispatcher, heartbeat | — | — | — | — | **retired** (piece 5 §3, D-28); re-admitted only on trigger K1 | — | — | — | — | — | — |

## 4. Cross-cutting checks (carriers that serve many components)

| # | Check | Carrier | Runs when | Type |
|---|---|---|---|---|
| A-01 | Allow list, owned IDs, revision check, brief gate, boot gate, compaction gate, reading gate | `.claude/hooks/tool_allowlist.py` (one script) | every tool call | M |
| A-02 | Owned-ID recorder (sessions, routines, `send_later`) | `.claude/hooks/record_owned_id.py` | after create calls | M |
| A-03 | Read receipts | `.claude/hooks/receipts.py` (new, D-09) | after `Read`, session-event reads, create calls, usage reads | M |
| A-04 | Record checks: `chain`, `kinds`, `views`, `work`, `impact`, `verdicts`, `stamps`, `markers`, `squeeze`, `map` | `tools/check_records.py` (one script, subcommands) | stop check | M |
| A-05 | Stop check | `tools/builder_check.sh` (extended) | before every stop; R1 requires its output | M |
| A-06 | Hook test with mutation checks | `tools/test_tool_allowlist.sh` | every hook change | M |
| A-07 | Leak check (service names; no library text) | `tools/check_service_names.sh`, called by A-05 | every stop and every public copy | M (was instructed at closure only) |

## 5. Failures located on the map

Acceptance (m): every failure recorded from L-016 to L-034, and OI-011 items 22 and 24, located as a missing arrow or trigger. Later failures of the W-C00-12 runs are added because the same map must explain them.

| # | Failure (source) | What was missing | Where on the map now | Type after |
|---|---|---|---|---|
| X-01 | BP-04 built from a model's self-report; connectors live in reviewer sessions (L-016 B1, FND-002) | arrow "premise → probe before dependants" | B4 frontier blocks items on `untested` platform facts; H4 trigger (D-27) | M |
| X-02 | PC-05 edits incomplete (L-016 B2) | verifier task without the failure class "a place missed" | H1 task names failure classes (R-R3a); H13 record lists affected places | M route, J verdict, tested by T-R1 style planted case |
| X-03 | Plan 6.12 claimed but not met (L-016 B3) | arrow "claim → evidence" | B7 evidence references must resolve; A-03 receipts (D-09) | M (format), J (content) |
| X-04 | Hook failed open on errors (L-016 M1) | arrow "hook error → block" | A-01 wrapper maps errors to block (existing) | M |
| X-05 | Dispositions recorded as done that were not (L-016 M6, M9; L-018; L-019 B2; L-021 B2) | arrow "disposition claim → check output" | dispositions carry an evidence path resolved by A-04 `work`; check output quoted after the entry is written (L-021 rule) becomes part of B7 | M (presence), J (content) |
| X-06 | New barrier routes found in each review round (L-018 B1, L-019 B1, L-021 B1, L-023 N-B1) | trigger for a frame review before round 3 | H9 triggered by the third patch or a five-finding review (D-17) | M |
| X-07 | Redaction incomplete; names re-published in a log row (L-019 B2, L-021 B2) | arrow "public write → leak check" on every write | A-07 called by A-05 at every stop | M |
| X-08 | Recorder test used an assumed response format (L-022) | arrow "platform format → observed sample before the fixture" | `platform:` dependency on the response format (D-27); fixture provenance named in the test | M (block), I (provenance), tested by A-06 controls |
| X-09 | Session at 77% context kept working past the 50% threshold (L-022) | a signal of context pressure that does not depend on the session's judgement | B6 transcript-size warning (D-05); S4 quality signal (piece 3 §6) | M warning, J decision |
| X-10 | Next action row stale after a merge (L-027) | generation of the restatement | B10 generated frontier (W-R2), view check (M-R6) | M |
| X-11 | Stamps 6 minutes in the future (L-028); four estimates in an hour (F-037-2) | clock as the only source of times | B1 prints clocks; A-04 `stamps` (M-R9, D-25); `tools/records.py log` writes header times (D-34) | M |
| X-12 | `ReadNotifications` blocked; T-A2 built on an unchecked delivery path (L-029 F1) | probe before build; over-blocking analysed | D-27 on the delivery path; over-blocking list reviewed in the hook test | M |
| X-13 | Another session's actions recorded without reading its transcript (L-029/L-030 B1; L-033 OI-010 report; L-039 probe summary) | arrow "claim about another session → transcript read" | A-03 receipts; B7 refuses a citation of an unread event (D-09) | M |
| X-14 | Runs merged the dispatcher PR with no scope check (L-030 B2) | — | subject removed: dispatcher retired (piece 5 §3) | n/a |
| X-15 | Lease PR and dispatcher PR both appended to the log; amend and force push denied (L-032) | one writer to the log | single writer (the lease holder) once the dispatcher is retired; the lease PR touches only the state file (procedure kept) | M by structure, I for the lease-PR rule |
| X-16 | Producer judged its own change "status-only" and skipped review (L-033) | computed impact class | B8 route from the path class (D-06) | M |
| X-17 | Dispatcher's created IDs could not reach `main`; hand restore misreported (L-033, OI-010) | recorder file versioned like a hand-written file | union merge (M-R10); subject removed for the dispatcher | M |
| X-18 | No goal-down analysis; the model built by patching (L-034) | trigger "major design → goal-down and counter-design" | H3 required by item type `major-design` (D-30) | M |
| X-19 | Dispatcher and heartbeat created before their work existed (L-034) | admission by demand; map truth | every running carrier needs a register row with its demand (A-04 `map`, R-R4) | M (presence), J (demand), checked by T-R7 |
| X-20 | Operating model header "Binding" against the state file (OI-011 item 22) | one home for document status | M-R2; markers and phrase warning (D-24); T-M1 | M |
| X-21 | `send_later` reminder not recorded as owned (OI-011 item 24) | coverage when a capability is added | A-02 covers `send_later` (M-R11); the Own column forces the question for every new carrier | M |
| X-22 | Batu's answers unrecorded for 35 hours (F-036-1) | arrow "issue → decision record" checked at stop | B2 and B11 read the issue (D-04) | M |
| X-23 | Recorder lines conflicted on branch switches (F-037-1) | merge driver for a machine-written file | M-R10 | M |
| X-24 | D9 library consultation did not fire while writing piece 3 (F-039-1) | knowledge pushed at item start | B4 card prints lenses; H6 trigger | M (print), J (use), tested by T-07, T-R2 |
| X-25 | Checkout of `origin/main` in the working tree denied by the classifier (F-7, L-040) | a boot procedure that never changes the tree's revision after boot | B2 works on a branch at the boot revision; unreviewed `.claude/**` changes are caught at stop by path class and verdict binding (D-06, D-07) | M check, I procedure |

## 6. Instructed and judged arrows on critical paths

A critical path here is a path whose failure makes a claim, a merge, a stop or an effect wrong. Every I arrow on it is made M or tested.

| Arrow | Status | How |
|---|---|---|
| Boot happens before work (B2) | M | H-BOOT gate |
| Re-boot after compaction (B6) | I until the compaction signal is observed | H-CMP; T-R6 tests it meanwhile |
| Stop only when merged, recorded and woken (B11) | M | A-05 with stop reasons |
| Batu's answers recorded (B2, B11) | M | D-04 |
| Review level chosen (B8) | M floor, J above it | D-06; T-10 of the counter-design adopted as T-MAP5 |
| Spawned sessions formed (H1, H3, H4, H12) | M | H-BRF; T-W6, T-R3 |
| Timestamps measured | M | A-04 `stamps`; T-M7 |
| Heritage pushed at item start (B4) | M | card; T-07 |
| Heritage used (B6, B7) | J | lens dispositions (format M); T-07, T-R2 |
| Item selection (B4) | J | sampled at closure |
| Copying the usage status | M check of an I step | the stop check compares the state file's Usage row with the latest usage value in the receipts (D-16, D-09 carrier); T-MAP6 |
| Researcher consulted when the library bears (H6) | I | T-R2 |
| Leak check before public copies | M | A-07 in A-05 |
| Lease PR touches only the state file | I | low impact (a conflict, not a wrong claim); not critical |

## 7. Keeping the map true

The map's authoritative form after migration is a machine-readable register (one row per component, with the columns of §2 and §3 plus problem, assumption, cost, failure mode, removal test, successor and sunset), the home of today's Appendix M. `tools/check_records.py map` fails when: a hook command in `.claude/settings.json`, a script under `tools/`, a workflow under `.github/workflows/` or an agent definition under `.claude/agents/` has no row; a row's carrier file or heading anchor does not exist; a coverage cell is empty. This answers acceptance (m)'s "authoritative or mechanically checked against what actually runs": the files that run are enumerated from the tree, not from the register. **Limit stated:** routines and sessions that exist on the account are not files; they are checked through the owned-ID list (A-02) and T-R7, not by the map check.

## 8. Pre-registered tests

| ID | Claim | Procedure | PASS only if |
|---|---|---|---|
| T-MAP1 | An unregistered carrier fails the map check | Scratch tree: add a script under `tools/` and a hook entry with no row | FAIL naming both |
| T-MAP2 | A missing carrier fails | Remove a registered script | FAIL naming the row |
| T-MAP3 | An empty coverage cell fails | Blank one cell of one row | FAIL naming the row and column |
| T-MAP4 | Every failure X-01 to X-25 maps to a row that exists after migration | The verifier checks each X row against the register | every "where now" names an existing row or a retired subject |
| T-MAP5 | Path class overrides a producer's label (counter-design T-10) | Scratch PR touching `.claude/settings.json` described as "status-only" | the `impact` check requires a session verdict |
| T-MAP6 | A usage row not backed by a usage read is caught | Scratch run: write a Usage row whose value or time matches no `get_session` result in the receipts | the stop check FAILS naming the Usage row |
| T-MAP7 | The leak check runs at every stop | A planted derived term in a scratch log line | A-05 FAILS through A-07 |

## 9. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Register and map check | installation; the form is a DevOS candidate | `MechanismAssumption` records (C10) | C10 |
| Base steps B1–B11 | installation | DevOS working order and `session_brief()` (C04, C06) | C06 |
| Helpers H1–H14 | installation | DevOS roles (C05) and the audit environment (C03) for binding verdicts | C03, C05 |

## 10. Decision-and-basis record

- **Consulted:** pieces 1–3 and 5; the comparison (06); the counter-design's §8 and §15 (its map and register form, adopted, D-26); log entries L-016 to L-039 in full for the failure list; OI-011 items 22 and 24; operating model Appendix M (the rows this register will hold).
- **Left out on purpose:** a diagram. The tables are the authoritative form because a check can read them; a drawing would be a second home. A generated diagram can be added as a view later. Also left out: the plan's DevOS mechanisms (K-1 to K-11) except where the builder reuses them by name; they belong to DevOS's own map.
- **Premises, from scratch:** every past failure can be described as a missing arrow or trigger (yes for all 25 rows; X-14 and X-17 are resolved by removing the subject, which the map records as such); the map is only useful if a check keeps it true (yes, otherwise it is another document that drifts, failure pattern 3).
- **Alternative frame:** a map per role instead of per run. Rejected: the failures crossed roles (X-13 involves the run and a probe; X-15 the run and the dispatcher), and the coverage columns are cross-role by definition.
- **Reopen if:** a new failure cannot be located on the map; the map check produces false failures that lead to hand edits of the register.
