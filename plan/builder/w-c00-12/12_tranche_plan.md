# W-C00-12 · 12 · Tranche plan, finding coverage and revision-3 basis (object O6)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq` (revision 3), answering R-W12-1 B7, M1 and m3 (cause K4). **Rule applied:** proportionality is judged by **timing**, not by rule count. A mechanism is built now only if it answers a recurring failure or is something C00's heavy items need. Everything else waits for a named trigger. This is the design's own admission rule applied to time.

## 1. Why tranches, and how each one lands

The redesign replaces the operating model piece by piece, not in one migration PR (R-W12-1 B7). Each tranche:
- is one change PR, or a few;
- has its own tests from `11_test_register.md`, run on the PR's head and pasted into an evidence file;
- passes a review before merge. A PR of impact class high (W-R7) gets a **session** Verifier, bound to its head commit. That includes every PR touching `.claude/**`, `CLAUDE.md`, the governing documents, `tools/check_records.py`, `tools/builder_check.sh` or `.github/workflows/**`.

**Rollback.**
- Any tranche is reverted by a revert PR. Ruleset 24194116 allows a PR with 0 approvals, so any session, or Batu from the GitHub web interface, can merge one.
- The one dangerous case is a tranche-1c hook bug that blocks every session's writes. The hook is read from each session's working tree, so every new session on `main` inherits the bug. **Break-glass** (R-W12-1 M1): Batu merges the revert PR from the GitHub web interface; the PR is prepared in advance, as a branch, for each 1c change. The revert branch name is written into `DURUM.md`'s risk line while 1c is fresh. Until 1c has run for one full run without a hook error, the previous hook's SHA is recorded in the 1c log entry.
- The operating model v1.7 stays in force for whatever a tranche has not yet replaced. The state file's Governing-documents row says which version governs (M-R2).

## 2. Tranche 1: built now, before C00's heavy items resume

Order: probes first, then records and the scripts that check them, then hooks and `CLAUDE.md`, then workflows and retirement. Each layer's tests then run against the layer below (the counter-design's §15 order, probe first, adopted for R-W12-1 m2 item 9).

| Part | Contents (mechanism IDs) | Impact | Review | Gate to the next part |
|---|---|---|---|---|
| **1a probes** | **P-W12-4** (can this environment push `.github/workflows/`? a harmless file pushed to a probe branch, which is then recorded as abandoned); **P-W12-3** (hook events: `PreCompact`, `Stop`, the `compact` source, `PostToolUse` context), already pre-registered; one live `send_later` response sample for M-R11 (the call is free under the hook; the sample is the reminder's own response, with no ID typed by hand) | normal (no change to `main` except evidence) | evidence read by the run; the transcripts read, not summaries (FP 7) | the results are recorded |
| **1b records and checks** | the migration of the work list, decisions and OI-011 notes into `plan/work/` and `plan/decisions/` (M-R3, W-R16); `tools/records.py` (render, brief, durum, lease); `tools/check_records.py` (chain, kinds, views, work, impact, docstatus, stamps, claims a/b, decisions, scope, map) (M-R1, M-R2, M-R4–M-R6, M-R12, M-R14–M-R16, W-R1–W-R5, W-R7, W-R9, W-R11, W-R15, R-R2, R-R5, R-R10); the extended `tools/builder_check.sh` (C-R1, C-R11, M-R13, A-07) | **high** (`tools/check_records.py` and `tools/builder_check.sh` are on W-R7's path list) | session Verifier | tests T-M1–T-M7c, T-M11, T-M13–T-M15, T-W1–T-W12 (active rows), T-R9, T-R11, T-C5, T-MAP1–T-MAP5, T-MAP7 pass on the PR head |
| **1c hooks, `CLAUDE.md`, roles** | `.gitattributes` union (M-R10); the recorder covers `send_later` (M-R11); the brief gate (W-R6, H-BRF); the `SessionStart` boot map (M-R18); `CLAUDE.md` with the floor import and the map pointer (R-R6); `.claude/agents/{verifier,triager,researcher,critic}.md`; `plan/builder/roles/{counter-designer,probe}.md`; `REVIEW_PROMPT.md` extended (R-R3a); `plan/builder/heritage/FAILURE_PATTERNS.md`, with the review asked to qualify each pattern (R-R7); the operating model rewritten in place to v2.0 from pieces 02–05 and 07 (its path is unchanged until W-C00-06) | **high** | session Verifier, with the planted-problem test T-R1 on itself | T-M8, T-M12, T-M17, T-W6, T-R3–T-R5, T-R12 and T-H4 pass; break-glass branch prepared |
| **1d workflows and retirement** | the detector `watchdog.yml` (C-R8) and `records-check.yml` (C-R9), if P-W12-4 passed; otherwise both go to Batu as one account action in his batch; then the dispatcher's retirement (C-R7); T-C6–T-C8 | **high** | session Verifier | C00's heavy items (W-C00-06 to W-C00-11) become startable in the frontier |

**What resumes C00.** C00's heavy items need three things: a work list that shows what is startable (1b); reviewers formed with the floor and heritage (1c); and a chain that is detected when it stops (1d). Nothing in tranches 2 and 3 is needed for them.

**Effort budget (operating model §4.4).** Tranche 1 has a budget of three runs after the re-review passes: one each for 1b and 1c, and one for 1a with 1d. Two checkpoints with no progress on one part, or an exceeded budget without a recorded reason, stop the run at S3. The narrow re-review is one round. If it fails again on the same causes (K1–K4), that is a squeeze signal: the run stops at S3 and records a frame review (`FR-01`) instead of revising a fourth time.

## 3. Later tranches, each with its trigger

| ID | Mechanism | Tranche | Re-admitted when |
|---|---|---|---|
| M-R16 (c) | session-event claims checked against read receipts (needs a receipts hook) | 2 | a claim about another session's action is found wrong once more after 1b (FP 7 was observed in L-030, L-033 and L-039) |
| M-R17 | log header written by a script | 2 | M-R14 fails on a log header time twice |
| W-R8 | prerequisite brake | 2 | an unnecessary prerequisite delays an item once |
| W-R10 | basis hashes at section anchors | W-C00-06 | W-C00-06 starts (its design is part of that item) |
| W-R12 | usage filter in the frontier | 2 | the first `allowed_warning` reading |
| W-R13 | decomposition depth check | 2 | the closure review finds an item split far ahead of its work |
| W-R14 | `relies_on:`, CD T-05 and T-06 | 3 | with R-R11 |
| R-R11 | lenses with dispositions | 3 | after C00 closes, built last and kept only if T-07 passes |
| R-R13 | role profiles in the hook | 2 | a remaining spawned role acts beyond its role once (`04_roles.md` §7) |
| R-R14 | squeeze block | 2 | the third patch of one mechanism without a frame review |
| R-R15 | sampling of routine record PRs | 2 | the closure review finds a routine record wrong that the checks passed |
| R-R18 | boot gate, with break-glass | 2 | an unbooted session writes a wrong record again (after M-R13) |
| R-R19 | compaction gate | 2 | P-W12-3 or a natural compaction observes the signal, and a post-compaction session errs |
| R-R20 | transcript-size warning | 2, or 1c | its carrier is observed by P-W12-3 (then it joins 1c) |
| C-R12 | keeper session | 2 | the detector reports a real stall that the self-watchdog did not resume; probe P-08 first |

## 4. Finding coverage (self-check S-1)

Every R-W12-1 finding, with where revision 3 answers it.

| Finding | Where answered |
|---|---|
| B1 dispatcher retirement on a false premise; L-039 | `05_continuity.md` §1, §2.2–2.4, §3 (C-R5, C-R8; K1 fired); T-21 restated (`11` §2.4); T-C1 annotated earlier (L-041); map X-26 (`07` §5) |
| B2 path class blind to relocated high-impact changes | `03_work_model.md` W-R7 (field class), W-R16 (byte-identical migration); T-W9, T-W10 |
| B3 one timestamp rule rejects lease expiries and quotes | `02_memory.md` M-R14 (typed times) and the K2 walk-through in §7; T-M7a–c |
| B4a reading gate regresses floor delivery | `04_roles.md` §4 (R-R6 import, R-R12 retired); T-R5 per subagent role |
| B4b no failure patterns at boot after migration | `04_roles.md` §4 (R-R7); `02_memory.md` §4 and M-R18; T-R12, T-M17 |
| B5 mechanisms without tests; tests of superseded mechanisms | `11_test_register.md` (every active row has a test; T-M5, T-M6, T-M7, T-W3, T-MAP6 retired; T-W3 replaced by T-W3r, not dropped, because M3 keeps status-based staleness) |
| B6 change list; contradictions between files | pieces 02–05 rewritten in place; `07` and `08` corrected (§5 below); `check_ids.py` |
| B7 one big-bang migration | §1–§3 of this file |
| M1 boot gate without break-glass | the boot gate is deferred (R-R18) and will ship with break-glass; break-glass for 1c in §1 |
| M2 read receipts false failures | `02_memory.md` M-R16 (claims scoped; no file-`Read` requirement) |
| M3 basis hashes stale everything at W-C00-06 | `03_work_model.md` §4, W-R9, W-R10 |
| M4 F-2 mislabelled; issue-read dependency | `02_memory.md` M-R13; L-041 correction; `06` F-2 corrected |
| M5 log cites evidence not on `main` | M-R16 (a); T-M14; verdicts copied in L-041; map X-27 |
| M6 Batu's conversation session has no row | `04_roles.md` §2, R-R17; T-R10 |
| M7 plan §9 and Ek F name the old model | `02_memory.md` §3 (paths kept until W-C00-06; plan-change candidates attached there); `08` migration table |
| M8 checks run from an editable tree | `05_continuity.md` §2.3 (C-R9); `07` §1 labelling rule; D-15 description corrected in `06` |
| m1 comparison misdescriptions | `06` D-05, D-13, §8 corrected |
| m2 counter-design items without disposition | `06` §3a (new), one line each |
| m3 admission rule admits nearly everything | `11` §1, Basis and Cost columns; §2–§3 of this file use them |
| m4 expected-text rule lacks check-ins | `05` C-R6, five forms |
| m5 check-ins stop after 24 hours | `05` C-R4; `02` §6 template |
| m6 T-C1 observer and L-039 | T-C1 evidence annotated (L-041); `11` T-C1 row |
| m7 no scope per adopted rule | every rule table in 02–05 and the register has a Scope column (M-R12) |
| m8 H5 number missing | `07` §3 keeps a retired H5 row |

**K3 re-read findings (fresh-context subagent, this run), answered:**

| Premise or failure | Finding | Answer |
|---|---|---|
| P1 no run stalled | contradicted (L-039) | `05` §1, §2 |
| P7 no spawned session beyond its role | weakened (L-033 dispatcher hand edit and false report) | `04` §7, deferral of R-R13 restated for the re-review; map X-28 |
| P8 no producer-written criterion drifted | weakened (L-018, L-021→L-023, L-030, L-033) | W-R7 field class makes every acceptance-block change high; W-R1 refuses retired tests; `03` §1 |
| P10 no accidental protected-path edit | weakened (L-033; L-037 and L-039 tree switches to probe branches) | map X-28, X-29; the hook's `create_session` rule forced the tree switch for probes. That is a hook-rule gap, recorded as a tranche-2 candidate ("`create_session` on a `claude/probe-*` branch whose fetched revision carries `.claude/settings.json`", trigger: the next probe that needs `.claude/` changes), and P-W12-3 is designed to need none |
| P12 no spawned session wrote a shared artefact | contradicted (dispatcher log PRs; recorder) | D-35 corrected in `06`; the subject is retired (C-R7); the recorder file merges by union (M-R10) |
| P13 failures not in 07 §5 | 25 items | `07` §5 rows X-26 to X-40, grouped where they share a missing arrow |
| P14 human orchestration | listed | `05` §5 residual; R-R17 |
| P15 usage and context readings conflict | L-039 against L-040; cost fields absent | `04` §6 item 3 (S4's 50% is a judgement with recorded proxies); `05` §4 |

## 5. Corrections made to 06–08 in revision 3 (consistency pass)

- **06:** F-2 relabelled (authenticated by the proxy); D-05, D-13 and §8 misdescriptions corrected (m1); D-15's description of the counter-design corrected (M8); D-28 restated (the detector admitted, independent of D-08); D-12 withdrawn; D-35's basis corrected (P12); a new §3a gives the m2 items one line each; §7 points to the rewritten pieces instead of "Revision 2" sections.
- **07:** cells cite rule IDs from 02–05 and carrier IDs from `11` §1.5, with deferred and retired mechanisms marked; H12 no longer requires the successor ID (C-R1); X-20 cites markers without a phrase warning; H5 kept as a retired row; the Critic is H8 with its role row; B1 cites R-R7 for heritage; every M arrow is labelled "given an unmodified checker" until C-R9 lands; failures X-26 to X-40 added.
- **08:** item 6 cites T-R8; item 3 and item 20 cite deferred role profiles (R-R13); the migration table follows §2 of this file (no `builder/` move before W-C00-06; no role profiles; no receipts hook; plan §9 and Ek F as plan-change candidates).

## 6. Revision-3 decision-and-basis record

- **Consulted:**
  - R-W12-1 in full and its dispositions; pieces 00–10;
  - the K3 re-read of L-016 to L-041, by a fresh-context subagent given fifteen premises (its report is summarised in §4, not copied);
  - the counter-design's positions on the m1 and m2 items, by a second subagent, with line numbers;
  - the library at `941f027`, by a Researcher subagent, which opened these sources (statuses as each study states them):
    - `context-memory-harness-engineering/03-HARNESS-ENGINEERING.md` (bounded research package complete, user evaluation pending): harness components encode assumptions that go stale; admit by failure class, with ablation;
    - `anthropic-ai-native-sdlc-playbook/01-PLAYBOOK-RESEARCH.md` (bounded external-target research complete, adoption not authorised): adopt practices in dependency order; critical control state must not be writable by the component it constrains;
    - `beads/FINDINGS.md`, `gastown/FINDINGS.md` (bounded-complete, first-wave): liveness, leases, separate monitor roles;
    - `hermes-agent/…/2026-09-11-cron-scheduling-delivery/RESEARCH.md` (active, partial): heartbeat false positives; interrupted runs marked unknown;
    - `gstack/syntheses/…` (bounded research complete, adversarially audited): silence read as current; fail-open gates;
    - `context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md` and `soul-foundations/…/CHANGE-STATUS-TEMPORAL-COUNTERCHECK.md` (adversarial supplement, not independent verification): valid time versus record time.
- **Library gaps stated:** no comparison of watchdog designs for LLM session chains; no evidence on tranche versus all-at-once roll-out; no source on checks from a trusted definition versus the producer's tree; no source separating quoted historical times from observation times. Where the library is silent, the design takes the cheapest option that can be measured, and measures it.
- **Not consulted:** `superpowers`, the `hermes-agent` delegation notes and `ecc`, which may hold more on liveness and re-entry. They were listed by the Researcher, not opened; they are a reading for the keeper's design if C-R12 is re-admitted. The library was not registered as a session root, so its agent files were not loaded as instructions.
- **Premises, from scratch:** the reviewer's tranche cut is a starting point, not an authority (deviations in §2: workflows in 1d behind a probe; the `builder/` move deferred to W-C00-06; the claims check scoped); C00 heavy work needs only tranche 1 (yes, by §2's three needs).
- **Alternative frame:** build nothing new and resume C00 under v1.7 with three patches (issue read, typed times, union merge). That is cheaper now. It is rejected because W-C00-12's acceptance (a2), (e), (g), (j), (k), (l) and (m) cannot be met by patches, and the patch-by-patch path is the cause W-C00-12 exists to end (L-034).
- **Reopen if:** tranche 1 exceeds its budget; the re-review judges tranche 1 still too heavy; a deferred mechanism's trigger fires.

## 7. D-004 (candidate for Batu's batch; not sent now)

**What:** whether the builder may use an automated restart of a stalled chain, meaning a GitHub Actions workflow that starts a Claude session itself. It would need a credential, likely an API key, which concerns his accounts and possibly money. **When it is sent:** with tranche 1d's result, in his batch, in Appendix E format (operating model §6: a Batu item is sent when it blocks, or once per stage). **Default until he answers:** none is built; the detector alerts him (C-R8). This default is free and reversible.
