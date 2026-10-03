# W-C00-12 · 12 · Tranche plan, gates, finding coverage and revision-3 basis (object O6)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq` (revision 3), answering R-W12-1 B7, M1 and m3 (cause K4), and revised the same day after a critic pass (§8). **Rule applied:** proportionality is judged by **timing** as well as by count. A mechanism is built now only if a W-C00-12 acceptance clause requires it or a failure that occurred admits it. Everything else waits for a named trigger.

## 1. Why tranches, and how each one lands

The redesign replaces parts of the operating model in reviewable steps, not in one migration PR (R-W12-1 B7). Each part:
- is one change PR;
- has its gate tests (§2) run on the PR's head, with results pasted into an evidence file;
- passes a review before merge. A PR of impact class high (W-R7) gets a **session** Verifier bound to its head commit. That includes every PR touching `.claude/**`, `CLAUDE.md`, the governing builder documents, the floor files, `tools/check_records.py`, `tools/records.py`, `tools/builder_check.sh`, `tools/boot_map` or `.github/workflows/**`.

**Rollback and break-glass** (R-W12-1 M1; critic finding 9).
- Any part is undone by a revert PR. Ruleset 24194116 allows a PR with 0 approvals, so any session, or Batu from the GitHub web interface, can merge one.
- An **exact revert** of one merge commit that touches only executable carriers is impact class normal (W-R7). So a broken checker, brief generator or hook can be reverted without the session Verifier that the breakage may be blocking. It carries a `break-glass:` log line, and the stop check fails until a session verdict on the revert exists. A revert that touches a record file is classified like any other diff (R-W12-2 B-1 a).
- The dangerous case is a 1c hook bug that blocks every session's writes. A revert branch for each 1b and 1c merge is pushed before the merge and named in the merge's log entry and in `DURUM.md`'s risk line. Batu can merge it from the web; no session is needed.
- The operating model v1.7 stays in force for whatever a part has not yet replaced. The state file's Governing-documents row says which documents govern (M-R2).

**The operating model is not rewritten** (critic finding 16). Tranche 1c makes v1.8 a short delta with three parts:
- the header points to the state file for status (M-R2);
- a supersession table names, for each v1.7 section, the rule IDs that replace it;
- `plan/builder/mechanisms.md` (the register and the map's carrier tables, moved there in 1b-i) and the pieces 02–05 and 07 become governing documents in place, moved under `plan/builder/design/` without change to any rule. Their only change is the header: each candidate status line is replaced by the M-R2 pointer `Status: see plan/ledger.md, Governing documents`, recorded as a supersession line (R-W12-2 B-2: `docstatus` would otherwise fail the 1c PR).

One home per rule (M-R1): a v2.0 restatement would be a second copy.

## 2. Tranche 1: parts, contents, gates

**When C00's heavy items resume** (critic finding 1). The state file's Stage row says that no C00 run starts until W-C00-12 is done. Revision 3 keeps that order. W-C00-12 is accepted only when all of these hold:
1. every part below has merged with its gate tests passing;
2. every active rule has at least one passing gate test (`check_ids.py` checks the assignment);
3. a **composition review** by a session Verifier passes. It judges acceptance (d) "purpose and robustness" on the built system, together with the observations of §2.3.

Only then do W-C00-06 to 11 enter the frontier. This is encoded, not only written: the 1b-i migration gives each of them `depends_on: W-C00-12`, and lifting that edge any other way is class high (W-R7; T-W15, T-W9). Revision 3's first draft and the R-W12-1 dispositions said "after tranche 1 is merged". That would have let C00 resume with W-C00-12's acceptance open, so it is withdrawn.

**Dependency on P-W12-4, stated** (R-W12-2 M-2; revised after the critic of `13`, finding 1). The detector (C-R8) is the only tranche-1 mechanism that needs a workflow file. If P-W12-4 fails, Batu gets one item in his batch, candidate D-005 with no default by silence (`05_continuity.md` §2.2): he adds the file, or he accepts the residual of no independent stall detection until C06. W-C00-12's acceptance and the dispatcher's retirement (C-R7) wait for one of the two; that is one decision, not an open-ended account action. Under his option (b), C-R8 is deferred with the trigger "the file is on `main`", and T-C6, T-C7, T-23 and the detector clause of T-21 are deferred with it. The main-definition check (C-R9) is deferred (§3), so nothing else depends on the probe.

### 2.1 Parts

| Part | Contents (mechanism IDs) | Impact | Review |
|---|---|---|---|
| **1a probes** | **P-W12-4**: can this environment push `.github/workflows/`? A harmless file is pushed to a probe branch, which is then recorded as abandoned. One live `send_later` response sample for M-R11. **OI-012 measurement**: whether `main`'s history, and not only the review branches, holds the unredacted service names (§8, finding 3). **Deferred out of 1a (L-044):** the probe-branch rule H-PRB and the probe P-W12-3 that needed it. The classifier refused the push of the test fixtures of H-PRB (deferred) as self-modification; a refusal is S3 for that action and is not routed around (R-R21). P-W12-3 observes hook events (`PreCompact`, `Stop`, the `compact` source); since R-W12-2 the compaction arrow is typed I until observed, so no active rule's gate depends on it (its findings feed R-R19 and R-R20, both deferred). | evidence only | the run reads probe transcripts, not summaries; the 1b-i session Verifier checks the deferral |
| **1b-i records and render** | migration of the work list, decisions and OI-011 notes into `plan/work/` and `plan/decisions/` (M-R3, W-R16), with `depends_on: W-C00-12` on W-C00-06 to 11; `tools/records.py` (render, brief including the run brief and the verifier brief's required fields, durum, lease); generated frontier, zoom and views (W-R2, W-R3, W-R5, W-R11, W-R15); the register and the map's carrier tables moved to `plan/builder/mechanisms.md`, 07 keeping a pointer | high (`tools/records.py`) | session Verifier |
| **1b-ii checks and stop** | `tools/check_records.py` (`chain`, `kinds`, `views`, `work`, `impact`, `docstatus`, `stamps`, `claims`, `decisions`, `map`): M-R1, M-R2, M-R4, M-R5, M-R6, M-R14, M-R15, M-R16, M-R19, W-R1, W-R4, W-R7, W-R9, R-R3, R-R5, R-R10. The extended `tools/builder_check.sh`: C-R1 (without the 1d part), C-R11, M-R13, A-07. | high | session Verifier |
| **1c hooks, `CLAUDE.md`, roles** | `.gitattributes` union (M-R10); the recorder covering `send_later` (M-R11); the brief gate (W-R6); the `SessionStart` boot map (M-R18); `CLAUDE.md` with the floor import and map pointer (R-R6); `.claude/agents/{verifier,triager,researcher,critic}.md`; `plan/builder/roles/{counter-designer,probe}.md`; `REVIEW_PROMPT.md` extended (R-R3a); `FAILURE_PATTERNS.md`, with the review asked to qualify each pattern (R-R7); the operating model v1.8 delta with R-R4, R-R8, R-R9, R-R16, R-R17, R-R21, C-R2, C-R3, C-R5, C-R6, C-R10 written into it | high | session Verifier, with T-R1 planted problems |
| **1d workflows, retirement, plan text** | the detector `watchdog.yml` (C-R8), if P-W12-4 passed; otherwise D-005 goes to Batu in his batch (§2). C-R9 is deferred (§3). The dispatcher's retirement (C-R7), **after** T-C2 passes and only once C-R8 is on `main` or D-005 is answered. The plan-change candidates for plan §9 item 1 and Ek F (R-W12-1 M7): they now describe a retired dispatcher, so they are decided here by a verifier (technical owner, plan §14), not at W-C00-06. | high | session Verifier |

### 2.2 Gates

Every active test of `11_test_register.md` §2 appears in exactly one gate. A part merges only when its gate tests pass.

| Gate | Tests |
|---|---|
| 1a | — (evidence only; its former gate test is deferred with H-PRB, §3) |
| 1b-i | T-W10, T-W15, T-W2, T-W5, T-W7, T-W12 |
| 1b-ii | T-R20, T-M1, T-M2, T-M3, T-M4, T-M5r, T-M6r, T-M7a, T-M7b, T-M7c, T-M11, T-M14, T-M15, T-W1, T-W3r, T-W4, T-W9, T-R4, T-R9, T-R11, T-MAP1, T-MAP2, T-MAP3, T-MAP5, T-MAP7 |
| 1c | T-H4, T-M8, T-M12, T-M17, T-W6, T-R1, T-R2, T-R3, T-R5, T-R8, T-R12, T-R18, T-R19, T-R21, T-R22, T-C2, T-C4 |
| 1d | T-C1, T-C3, T-C5, T-C6, T-C7, T-21, T-R7, T-R10, T-R17, T-MAP4, T-M9, T-M10 |
| composition | T-R6 (stamina, from the long 1b and 1c runs), T-R16, and part (c) of the 1c boot-map test when a compaction has occurred; T-23 starts here as an observation over C01–C03 |

T-C1 is gated in 1d, because its re-run is the S4 hand-over of the 1c run, read by the 1d session Verifier.

### 2.3 What stays observation after acceptance, stated

Three tests cannot be forced:
- T-23: seven days of operation across C01–C03;
- T-R16 and T-M17 (c): they need a compaction, which a message cannot trigger (P-W12-2).

Every mechanism they cover also has a gate test that passes: C-R8 has T-C6 and T-C7 (unless D-005 (b) defers C-R8 with them); R-R9 has T-R20 (the mechanical hand-over signal); M-R18 has the boot-map test's parts (a) and (b). So acceptance (e) is met by the gate tests, and these three are additional observations with reopen triggers. R-W12-2 (M-6) judged this reading acceptable on two conditions, both adopted: the compaction arrow stays typed I until observed, and the composition review lists T-R16 and T-M17 (c) as **unobserved**, not as passed. A rule bundle does not carry an untested part through a test of another part: R-R16 and R-R3a now have their own tests (T-R21, T-R22).

### 2.4 Budget

Tranche 1 has a budget of four runs after the re-review passes: 1a with 1b-i, 1b-ii, 1c, and 1d with the composition review. Two checkpoints with no progress on one part, or an exceeded budget without a recorded reason, stop the run at S3. The narrow re-review is one round. If it fails again on the same causes (K1–K4), that is a squeeze signal: the run stops at S3 and records a frame review (`FR-01`) instead of revising a fourth time.

## 3. Later tranches, each with its trigger

| ID | Mechanism | Tranche | Re-admitted when | Observer of the trigger |
|---|---|---|---|---|
| M-R12 | scope label on every record | 2 | a record is found used in the wrong scope once | each tranche Verifier; closure review (W-C00-11) |
| M-R16 (c) | session-event claims checked against read receipts | 2 | a claim about another session is found wrong once more after 1b, despite T-R19 | the Producer recording a probe (T-R19); each tranche Verifier |
| M-R17 | log header by script | 2 | a log header date fails M-R14 twice | stop check (M-R14 failures on log headers) |
| W-R8 | prerequisite brake | 2 | an unnecessary prerequisite delays an item once | each tranche Verifier; closure review |
| W-R10 | basis hashes at section anchors | W-C00-06 | W-C00-06 starts | the W-C00-06 run at its start |
| W-R12 | usage filter in the frontier | 2 | the first `allowed_warning` reading | stop check (Usage row) |
| W-R13 | decomposition depth check | 2 | the closure review finds an item split far ahead of its work | closure review |
| W-R14 | `relies_on:`, CD T-05 and T-06 (both deferred with it) | 3 | with R-R11 (deferred) | with R-R11 (deferred) |
| R-R11 | lenses with dispositions | 3 | after C00 closes; built last, kept only if T-07 (deferred with it) passes | closure review |
| R-R13 | role profiles in the hook | 2 | a remaining spawned role acts beyond its role once (`04_roles.md` §7) | each tranche Verifier; closure review |
| R-R14 | squeeze block | 2 | the third patch of one mechanism without a frame review | stop check: the `patch:` count per mechanism (M-R5; R-W12-2 M-7) |
| R-R15 | sampling of routine record PRs (adaptive k, session verifier) | 2 | the closure review finds a routine record wrong that the checks passed | closure review |
| R-R18 | boot gate, with break-glass | 2 | an unbooted session writes a wrong record again (after M-R13) | stop check (M-R13 finds an unrecorded answer) |
| R-R19 | compaction gate | 2 | a compaction is observed and a post-compaction session errs | T-M17 (c) observer; each tranche Verifier |
| R-R20 | transcript-size warning | 2, or 1c | P-W12-3 observes its carrier (then it joins 1c) | P-W12-3's result (1a) |
| C-R12 | keeper session | 2 | the detector reports a real stall that the self-watchdog did not resume; probe P-08 first | the detector's alerts (C-R8), read by the next run; if C-R8 is deferred under D-005 (b), the closure review |
| H-PRB | probe-branch rule (deferred after the classifier refusal, L-044) | 2 | a probe needs `.claude/` changes on its own branch, and Batu has decided how the builder may change its own guardrails (the refused action is not retried before that) | the run that schedules such a probe; closure review |
| C-R9 | main-definition record check (deferred after R-W12-2 M-2) | 2 | a merged PR is found to have weakened a check it was judged by, or C03 begins (comparison D-08) | each tranche Verifier; the C03 start |

Every trigger names its observer (R-W12-2 M-7). Triggers that no script counts are on the checklist of each tranche part's session Verifier and of the closure review.

**Size, measured** (critic finding 16), from `11_test_register.md` by script (rule rows of §1 counted by their Status cell; test IDs of §2 counted when their State cell says neither retired nor deferred; the command is in L-044):
- 46 active rules, 16 deferred, 7 retired;
- 62 active tests, each gated (§2.2).

The previous figures ("47 active rules"; "59 active tests", where the reviewer counted 60 on `08459af` and the post-target test T-W14 made 61) are superseded: C-R9 is deferred and T-C8 with it; T-W15, T-R21 and T-R22 are added (R-W12-2 B-1, M-6); H-PRB and its test T-W14 are deferred after the classifier refusal (L-044).

**Size is not the measure; fit is** (`briefs/w-c00-12/BATU_VERSIONS_NOT_SIZE_TR.md`, Batu, 2026-10-03). Tranche 1 is the **first version**, not a small one: each mechanism is judged by demand, test, need now, and removability (plan §6.12 item 4), and between versions a **compaction review** asks which mechanisms can be merged or replaced at the same quality, as well as which must be added. The composition review of W-C00-12 records the first such list.

The reviewer judged "about twenty" proportionate if each answered a recurring failure, and that is not what this is. The active rules fall into three groups:
1. **Required by a W-C00-12 acceptance clause** (most of them): (a2) W-R2–W-R5, W-R9, W-R15; (g) W-R1, R-R4, C-R7; (i) R-R3, R-R5; (j) M-R18, R-R7; (k) R-R3a, R-R6, R-R8, R-R9, W-R6; (l) M-R1, M-R2, M-R4–M-R6, M-R15; (m) M-R19; (b) through OI-011: C-R3 (item 5), M-R11 (item 24), M-R10 (items 2 and 23).
2. **Admitted by recurring failures:** M-R14, M-R16, W-R7, W-R11, C-R1.
3. **One incident or one reviewer finding:** C-R2, C-R5, C-R8, M-R13, R-R16, R-R17, R-R21, W-R16, C-R6, C-R10, C-R11, R-R10, M-R3.

Cuts made after the critic:
- the v2.0 rewrite is replaced by a delta;
- R-R2 and C-R4 are merged into other rules;
- M-R12's record-level check is deferred;
- 1b is split in two.

Not cut, with reasons:
- C-R3: needed before the first Batu batch, which 1d may send;
- the zoom view: (a2);
- R-R10's check: OI-011 items 9 and 14.

R-W12-2 was asked to name any group 3 rule it would defer, and named C-R9 (M-2). C-R9 is deferred (table above).

## 4. Finding coverage (self-check S-1)

Every R-W12-1 finding, with where revision 3 answers it.

| Finding | Where answered |
|---|---|
| B1 dispatcher retirement on a false premise; L-039 | `05_continuity.md` §1, §2.2–2.4, §3 (C-R5, C-R8; K1 fired); T-21 restated and made runnable (`11` §2.4); map X-26; retirement only after T-C2 (§2.1, 1d) |
| B2 path class blind to relocated high-impact changes | `03_work_model.md` W-R7 (field class, existing acceptance blocks, the full path list), W-R16; T-W9, T-W10 |
| B3 one timestamp rule rejects lease expiries and quotes | `02_memory.md` M-R14 (typed fields, `sched:` in prose, written-at stamps), checked against the whole log by a prototype (L-042); T-M7a–c |
| B4a reading gate regresses floor delivery | `04_roles.md` §4 (R-R6 import; R-R12 retired); T-R5 per subagent role |
| B4b no failure patterns at boot after migration | `04_roles.md` §4 (R-R7); `02_memory.md` §4 and M-R18; T-R12, T-M17 |
| B5 mechanisms without tests; tests of superseded mechanisms | `11_test_register.md` (every active rule has a test, and every active test a gate, §2.2); T-M5, T-M6, T-M7, T-W3 and T-MAP6 retired; T-W3 (retired) replaced by T-W3r, not dropped, because M3 keeps status-based staleness |
| B6 change list; contradictions between files | pieces 02–05 rewritten in place; 07 and 08 corrected (§5); `check_ids.py`; the critic's check of the seven examples (§8) |
| B7 one big-bang migration | §1–§3 of this file |
| M1 boot gate without break-glass | the boot gate is deferred (R-R18) and ships with break-glass; for tranche 1, exact reverts are class normal and revert branches are prepared (§1) |
| M2 read receipts false failures | `02_memory.md` M-R16 (claims scoped; no file-`Read` requirement) |
| M3 basis hashes stale everything at W-C00-06 | `03_work_model.md` §4, W-R9, W-R10 (deferred to W-C00-06) |
| M4 F-2 mislabelled; issue-read dependency | `02_memory.md` M-R13; L-041 correction; `06` F-2 corrected |
| M5 log cites evidence not on `main` | M-R16 (a); T-M14; verdicts copied in L-041; map X-27 |
| M6 Batu's conversation session has no row | `04_roles.md` §2, R-R17 (one rule after the critic); T-R10 |
| M7 plan §9 and Ek F name the old model | the paths are kept until W-C00-06 (`02_memory.md` §3); plan §9 item 1 and Ek F's dispatcher text are decided in 1d (§2.1) |
| M8 checks run from an editable tree | `07` labels every working-tree carrier M\*; D-15 corrected in `06`; the main-definition check C-R9 (`05_continuity.md` §2.3), first answered as active with its result read by C-R1, is now deferred (R-W12-2 M-2) |
| m1 comparison misdescriptions | `06` D-05, D-13, §8 corrected |
| m2 counter-design items without disposition | `06` §3a, one line each |
| m3 admission rule admits nearly everything | `11` §1, Basis and Cost columns; §3's measured size and three groups |
| m4 expected-text rule lacks check-ins | `05` C-R6, five forms |
| m5 check-ins stop after 24 hours | M-R15's template; `02` §6 |
| m6 T-C1 observer and L-039 | T-C1 evidence annotated (L-041, L-042); `11` T-C1 not counted until re-run after 1c |
| m7 no scope per adopted rule | every rule table in 02–05 and the register has a Scope column, checked by `check_ids.py` |
| m8 H5 number missing | `07` §3 keeps a retired H5 row (since 1b-i the row is in `plan/builder/mechanisms.md` §2.2) |

**K3 re-read findings (fresh-context subagent, this run), answered:**

| Premise or failure | Finding | Answer |
|---|---|---|
| P1 no run stalled | contradicted (L-039) | `05` §1, §2 |
| P7 no spawned session beyond its role | weakened (L-033: the dispatcher's hand edit and false report) | `04` §7, R-R13's deferral restated for the re-review; map X-28 |
| P8 no producer-written criterion drifted | weakened (L-018, L-021→L-023, L-030, L-033) | W-R7 makes every change to an existing acceptance block high; W-R1 refuses retired tests; `03` §1 |
| P10 no accidental protected-path edit | weakened (L-033; tree switches to probe branches in L-037 and L-039) | map X-28, X-29; the probe-branch hook rule H-PRB (now deferred) was moved into tranche 1a because P-W12-3 adds hooks on its probe branch (F-042-3); after the classifier refused its test fixtures (L-044), H-PRB and P-W12-3 are deferred (§3), and the working-tree rule stays instructed, as R-W12-2 had accepted |
| P12 no spawned session wrote a shared artefact | contradicted (dispatcher log PRs; the recorder) | D-35 corrected in `06`; the subject retired (C-R7); the recorder file merges by union (M-R10) |
| P13 failures not in 07 §5 | 25 items | `07` §5 rows X-26 to X-40, grouped where they share a missing arrow |
| P14 human orchestration | listed | `05` §5 residual; R-R17 |
| P15 usage and context readings conflict | L-039 against L-040; cost fields absent | `04` §6 item 3 (`used_tokens` is measurable after the first turns; a 0 reading is unknown; corrected in revision 3); `05` §4; T-R17 |

## 5. Corrections made to 06–08 in revision 3 (consistency pass)

- **06:**
  - F-2 relabelled (authenticated by the proxy);
  - D-05, D-13 and §8 misdescriptions corrected (m1);
  - D-15's description of the counter-design corrected (M8);
  - D-35's basis corrected (P12);
  - a new §3a gives the m2 items one line each;
  - §3b maps every disposition to its current rules and supersedes the revision-2 text of the rows it changes;
  - §7 points to the rewritten pieces.
- **07:**
  - cells cite rule IDs from 02–05 and carrier IDs from `11` §1.5 (since 1b-i: `plan/builder/mechanisms.md` §1.5);
  - carriers in the working tree are M\* (critic finding 6);
  - H12 no longer requires the successor ID;
  - X-20 cites markers without a phrase warning;
  - H5 kept as a retired row; the Critic is H8;
  - B1 cites R-R7;
  - failures X-26 to X-40 added.
- **08:**
  - item 6 cites T-R8;
  - items 3 and 20 cite deferred role profiles (R-R13);
  - item 8 follows R-R17;
  - the migration table follows §2 of this file.

## 6. Revision-3 decision-and-basis record

- **Consulted:**
  - R-W12-1 in full and its dispositions; pieces 00–10;
  - the K3 re-read of L-016 to L-041, by a fresh-context subagent given fifteen premises (summarised in §4, not copied);
  - the counter-design's positions on the m1 and m2 items, by a second subagent, with line numbers;
  - a critic subagent's sixteen findings on the first draft of revision 3 (§8);
  - a prototype of M-R14 run over the whole log (L-042);
  - the library at `941f027`, by a Researcher subagent, which opened (statuses as each study states them):
    - `context-memory-harness-engineering/03-HARNESS-ENGINEERING.md` (bounded research package complete, user evaluation pending): harness components encode assumptions that go stale; admit by failure class, with ablation;
    - `anthropic-ai-native-sdlc-playbook/01-PLAYBOOK-RESEARCH.md` (bounded external-target research complete, adoption not authorised): adopt in dependency order; critical control state must not be writable by the component it constrains;
    - `beads/FINDINGS.md` and `gastown/FINDINGS.md` (bounded-complete, first-wave): liveness, leases, separate monitor roles;
    - `hermes-agent/…/2026-09-11-cron-scheduling-delivery/RESEARCH.md` (active, partial): heartbeat false positives; interrupted runs marked unknown;
    - `gstack/syntheses/…` (bounded research complete, adversarially audited): silence read as current; fail-open gates;
    - `context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md` and `soul-foundations/…/CHANGE-STATUS-TEMPORAL-COUNTERCHECK.md` (adversarial supplement, not independent verification): valid time versus record time.
- **Library gaps stated:**
  - no comparison of watchdog designs for LLM session chains;
  - no evidence on tranche versus all-at-once roll-out;
  - no source on checks from a trusted definition versus the producer's tree;
  - no source separating quoted historical times from observation times.

  Where the library is silent, the design takes the cheapest option that can be measured, and measures it.
- **Not consulted:** `superpowers`, the `hermes-agent` delegation notes and `ecc`. They are reading for the keeper's design if C-R12 is re-admitted. The library was not registered as a session root.
- **Premises, from scratch:**
  - the reviewer's tranche cut is a starting point, not an authority (deviations: workflows in 1d behind a probe; the `builder/` move deferred; the claims check scoped; a delta instead of a rewrite);
  - C00 resumes only after W-C00-12's acceptance (the Stage row; critic finding 1).
- **Alternative frame:** build nothing new and resume C00 under v1.7 with three patches (issue read, typed times, union merge). That is cheaper now. It is rejected because acceptance (a2), (e), (g), (j), (k), (l) and (m) cannot be met by patches, and patching is the cause W-C00-12 exists to end (L-034). Its cost remains the strongest argument against this design. The re-review may weigh it.
- **Reopen if:** tranche 1 exceeds its budget; the re-review judges it still too heavy; a deferred mechanism's trigger fires.

## 7. D-004 (candidate for Batu's batch; not sent now)

- **What:** whether the builder may use an automated restart of a stalled chain, meaning a GitHub Actions workflow that starts a Claude session itself. It would need a credential, likely an API key, which concerns his accounts and possibly money.
- **When it is sent:** with tranche 1d's result, in his batch, in Appendix E format (operating model §6).
- **Default until he answers:** none is built; the detector alerts him (C-R8, or, if P-W12-4 fails, as he decides in D-005). The default is free and reversible.

## 8. Critic pass on revision 3 (non-binding; fresh-context subagent; 16 findings)

| # | Finding (short) | Severity | Response |
|---|---|---|---|
| 1 | C00 would resume before W-C00-12 is accepted; many active tests in no gate; the dispatcher retired before T-C2 | blocking | **Accepted.** §2: acceptance first; the gate table; `check_ids.py` checks the gates; retirement after T-C2 |
| 2 | M-R14 still rejects ordinary records (`expiry 20:53Z` in prose; Usage As-of; log headers carry dates only) | blocking | **Accepted.** A prototype over the whole log showed 18 future times, 7 misclassified even by a broad keyword list; M-R14 now uses typed fields, `sched:` in prose, written-at stamps, and header dates; T-M7a–c revised |
| 3 | M-R16 (b) fails on today's redacted verdicts; the public review branches hold unredacted names | blocking | **Accepted.** (b) applies to verdicts the PR adds, and is redaction-aware; T-M15 (c), (d). The branch exposure is recorded as OI-012 and measured in 1a (§2.1) |
| 4 | "About 30 times per entry" was an unmeasured figure | material | **Accepted.** Measured: 9 and 8. Finding F-042-2 (failure patterns 1 and 6 in a justification). The deviation is re-decided on the measured basis (`02` §7) |
| 5 | The map check cannot run against the register; missing rows; no rule ID | material | **Accepted.** M-R19: the map's carrier tables are the checked source; T-MAP1–4 |
| 6 | Working-tree carriers labelled M; C-R9's report (C-R9 now deferred) read by nobody | material | **Accepted.** `07` relabelled M\*; C-R1 reads the results of C-R9 (now deferred) from 1d; T-C5 (e). Superseded by R-W12-2 M-2: C-R9 and T-C5 (e) are deferred |
| 7 | W-R7 path list incomplete; "governing documents" undefined | material | **Accepted.** `03` W-R7 lists the paths; T-W9 (f), (g) |
| 8 | Producer acceptance through a self-written "deterministic" file | material | **Accepted.** W-R1 re-runs the named command; T-W1 |
| 9 | The brief gate can deadlock on a `records.py` bug | material | **Accepted.** Exact reverts are class normal; revert branches prepared for 1b and 1c (§1); T-W9 (h) |
| 10 | T-R1 omits roles; T-R6 cited for compaction; fact markers untested; triage after the fact | material | **Accepted.** T-R1 covers every role; T-R16 for compaction; T-M1 (c); R-R5 at `running` |
| 11 | Critical-path I arrows untested (usage copy, refusals, claims) | material | **Accepted.** T-R17, T-R18 (R-R21), T-R19 pre-registered and gated |
| 12 | The issue cursor can skip an answer | material | **Accepted.** M-R13 accounts for every comment; T-M6r (d) |
| 13 | Batu's conversation session defined three ways | material | **Accepted.** One rule, R-R17; the relayed form in C-R6; `08` item 8 aligned. The dispositions file's M6 line ("run boot without the lease step") is superseded by R-R17 (recorded in L-042) |
| 14 | Stale or garbled text in 04–08 | minor | **Accepted**, each fixed (L-042 lists them) |
| 15 | Evidence claims: T-C1 counted against its own rule; the write-ahead's "git order is the proof" | minor | **Accepted.** T-C1 not counted until re-run after 1c; the write-ahead states what git order shows |
| 16 | Tranche 1 still about 48 active rules; 1b and 1c are big units; every new item would be high | material | **Accepted in part.** Measured at 47; a delta instead of the v2.0 rewrite; R-R2 and C-R4 retired and merged into other rules; M-R12 deferred; 1b split; new acceptance blocks are normal. The size is otherwise driven by the acceptance clauses (§3 groups), and the re-review is asked to name further deferrals |
