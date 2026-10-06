# DevOS installation ledger: state file

**What this file is.** The builder's single, short, always-current state file during installation (`plan/Installation_Working_Order.md` section 4). Work items and stages are in `plan/work/<ID>.md`, decisions in `plan/decisions/<ID>.md`, log entries in `plan/ledger/<stage>-log.md` (append-only), evidence in `evidence/<stage>/`, and Batu's status page `DURUM.md` is generated from these homes by `tools/records.py render` (since W-C00-12 tranche 1b-i). Blocks between `<!-- generated:<name> -->` and `<!-- /generated -->` are generated; edit their homes, not the blocks. Until the ledger is transferred to the database at the end of C02 (plan Section 9), these files are the authoritative installation record.

**Rules**

1. `devos` is public: only safe summaries and identifiers. No library text, no conversation transcripts, no key or token values. The exception is Batu's own decisions, constraints and expectations, which are recorded verbatim in Turkish with an English interpretation (plan 0.6 item 2).
2. Until the translation fidelity review passes, the Turkish plan package is binding (plan 0.6).
3. Acceptance conditions are written and merged **before** work on an item starts and are never loosened afterwards. If loosening is needed, the earlier result is void and the test is repeated (plan Section 9; 8.6; 14).
4. Every access or permission statement names its enforcement layer and its verification status (FND-001).
5. **Numbering.** `K<n>`/`B<n>`: Batu's formal decisions only (K1–K9, B1–B3). Not decisions: the plan's capability sections `K-1`…`K-11` and Appendix C's test IDs `K01`…`K13`. `PC-<n>`: the builder's plan changes; the parts that are Batu's own decisions are marked "[Batu, date]". `D-<n>`: decision records. `L-<n>`: log entries. `W-<stage>-<nn>`: work items. `EV-…`: evidence. `G-…`: gaps. `OI-…`: open items. `FND-…`: findings. `T-…`: tests.
6. Nothing exists until it is written here or in the log or evidence **and merged into `main`** (`plan/Installation_Working_Order.md` section 4).


---

## 1. Current state

| Item | State | As of |
|---|---|---|
| Stage | **C00 accepted** on CHK-C00-075 (L-167; its sixth condition provisional on N-109); **C01 running** in the working session `session_01WKJi23FwAjFtiyD1DbQ2Rs` (opened 2026-10-05, L-136): its work list accepted (W-C01-01, CHK-C01-006, L-169); the key inventory (W-C01-02), row 4's documentation part (W-C01-09) and N-110 (W-C01-28, PC-20) accepted (L-170, L-171); the probe design and the phase-A probe under way; then Batu's probe setup and rows 1 to 4 and 17. | 2026-10-06T15:30Z |
| Next action | Generated: the startable frontier in section 2 (`plan/Installation_Working_Order.md` section 4). It is not written by hand. | 2026-10-05T18:59Z |
| Usage | `five_hour` `allowed` at 2026-10-06T15:06Z (`get_session`, working session), resets 2026-10-06T19:50Z (`resetsAt` 1791316200); `isUsingOverage` false. D-002: proceed; read again before each heavy batch. Readings per stage: the "Usage" section of `plan/work/<stage>.md`. | 2026-10-06T15:06Z |
| Waiting for Batu | Generated: open decisions of class `batu` in section 4, and the first line of `DURUM.md`. Issue #6 was answered on 2026-10-02T06:27Z (D-002, D-003). | 2026-10-03T19:50Z |
| Binding plan text | The English plan package (W-C00-06 accepted on CHK-C00-020; plan 0.6 item 1: the Turkish text was binding until the fidelity review passed and is removed from the repository by this merge, history at `3de3a17`), with recorded changes PC-01 to PC-06 (PC-01 superseded by PC-06) | 2026-10-05 |
| answers seen through | issue #6 comment `6010051563` (2026-10-06T05:33Z, `batuhanozgun`): "> D-009: a" on the withdrawn D-009, disregarded at his word in the working session (`plan/decisions/D-009.md`). Working session, 2026-10-06 to 05:57Z: D-015 (the form of questions), D-014 answered, questions on D-013 answered there (L-155). Working session about 06:10Z: D-013 declined as not his, decided (a) by the builder (L-156). Working session about 06:29Z: the e-mails turned on, "sanırım" (D-014, L-157). Working session to about 09:00Z: D-016 (the thinking disciplines); the branch setting turned on (L-159). Working session 10:11Z to 10:39Z: a question about the machine account's e-mail address and a new repository of his other work (L-162); the language of messages to him (L-169). | 2026-10-06T14:42Z |
| summary_tr | Senden beklenen: yok. <br>Durum: C01'de (platform doğrulaması) üç iş denetlenip kabul edildi: anahtar envanteri, alt ajanların nasıl bittiğine dair resmi belgelerin okunması ve düşünme disiplini araçlarının takip işi (artık her görevde dokuz soru bloğunun tam metni aranıyor; durma denetimi kayıtları da kontrol ediyor). Deneme tasarımı ve küçük ön deneme sürüyor. Tasarım bitince senden iki deneme ortamı kurmanı isteyeceğim; adımları issue #6'ya tek seferde, adım adım yazacağım. <br>Belgelerden öğrenilen: ortamlar silinemiyor, yalnız arşivleniyor; C01 sonunda kaldırma adımları buna göre yazılacak. <br>C00'ın "sır görünmüyor" koşulu, platform anahtarının oturum dışına uzanmadığı C01'de gösterilene kadar şarta bağlı. | 2026-10-06T15:30Z |
| Rendered | Written by `tools/records.py render` from the clock; `DURUM.md`'s update line comes from here. | 2026-10-06T16:10Z |

---

## 2. Next action: the startable frontier

<!-- generated:frontier -->
**Ready (startable now):**
- `W-C01-03` Probe design: the setup P1 to P3, each probe, N-109's check and Batu's steps
- `W-C01-25` Phase-A probe (PC-16)

**Running:**
- none

**Not ready, with the first unmet condition:**
- `W-C01-04`: depends on W-C01-03 (not accepted)
- `W-C01-05`: depends on W-C01-03 (not accepted)
- `W-C01-06`: depends on W-C01-05 (not accepted)
- `W-C01-07`: depends on W-C01-04 (not accepted)
- `W-C01-08`: depends on W-C01-04 (not accepted)
- `W-C01-10`: depends on W-C01-05 (not accepted)
- `W-C01-11`: depends on W-C01-04 (not accepted)
- `W-C01-12`: depends on W-C01-05 (not accepted)
- `W-C01-13`: depends on W-C01-03 (not accepted)
- `W-C01-14`: depends on W-C01-05 (not accepted)
- `W-C01-15`: depends on W-C01-04 (not accepted)
- `W-C01-16`: depends on W-C01-04 (not accepted)
- `W-C01-17`: depends on W-C01-06 (not accepted)
- `W-C01-18`: depends on W-C01-06 (not accepted)
- `W-C01-19`: depends on W-C01-04 (not accepted)
- `W-C01-20`: depends on W-C01-05 (not accepted)
- `W-C01-21`: depends on W-C01-06 (not accepted)
- `W-C01-22`: depends on W-C01-06 (not accepted)
- `W-C01-23`: depends on W-C01-06 (not accepted)
- `W-C01-24`: depends on W-C01-06 (not accepted)
- `W-C01-26`: depends on W-C01-03 (not accepted)
- `W-C01-27`: depends on W-C01-06 (not accepted)
- `W-C01-29`: depends on W-C01-06 (not accepted)
- `W-C01-30`: depends on W-C01-03 (not accepted)

Selection among ready items: critical path first, one logged sentence of reason (`plan/Installation_Working_Order.md` section 4). Candidates never appear here; they are in the zoom view.
<!-- /generated -->

### Zoom

<!-- generated:zoom -->
**Horizontal: every stage, one line each.**

| Stage | Title | State | Items by state | Open notes |
|---|---|---|---|---|
| `C00` | Start, function comparison and independent review of the plan | accepted | accepted 15, cancelled 6 | 0 |
| `C01` | Platform verification | running | accepted 4, blocked 24, ready 2 | 13 |
| `C02` | Data model, rule gate and identity chain | planned | no items | 9 |
| `C03` | Trust boundaries and effect channels | planned | no items | 8 |
| `C04` | Knowledge, search and context | planned | no items | 11 |
| `C05` | Common rules, roles and methods | planned | no items | 5 |
| `C06` | Working order, audit and decision channel | planned | no items | 5 |
| `C07` | First real loop: the cognitive gate | planned | no items | 5 |
| `C08` | Model access layer, release, whole product and the SOUL repository | planned | no items | 7 |
| `C09` | Outage, backup, restore and reconnection | planned | no items | 5 |
| `C10` | Learning, purpose audit, process limit and assumption inventory | planned | no items | 4 |
| `C11` | Integrated testing, unattended operation, capacity and provider independence | planned | no items | 4 |
| `C12` | Hand-over | planned | no items | 1 |

**Vertical: the active branch expanded; siblings one line; the rest collapsed.**

- no claimed item; no active branch
<!-- /generated -->

### Work index

Each item's acceptance condition, front matter and notes are in its file (`plan/work/<ID>.md`). The status column of the v1.7 work list is kept verbatim in each item's `legacy_status`.

<!-- generated:work-index -->
| ID | Item | State | v1.7 status (verbatim) | Evidence | File |
|---|---|---|---|---|---|
| `W-C00-01` | Read the plan package | accepted | done | L-136 (the current plan package text, at 1c16dd7); L-001 (only the text at 6186e5d) | `plan/work/W-C00-01.md` |
| `W-C00-02` | Preparation verification (plan C00 step 1) | accepted | done | EV-C00-002, L-010 | `plan/work/W-C00-02.md` |
| `W-C00-03` | Gap and contradiction list | accepted | doing (v1 done) | EV-C00-003 (first version; final version 2026-10-06); EV-C00-014 addendum 2; CHK-C00-039 (one condition, C1); CHK-C00-040 finding 15 (C1 met) | `plan/work/W-C00-03.md` |
| `W-C00-04` | Premise inventory (plan C00 step 6) | accepted | done (v1) | EV-C00-004 (revised 2026-10-05, L-139); CHK-C00-004 (conditions); CHK-C00-006 (conditions met) | `plan/work/W-C00-04.md` |
| `W-C00-05` | Builder operating model (PC-04) | cancelled | done by the producer's own judgement (L-033), not independently accepted; superseded in substance by W-C00-12 (principle 11, `briefs/w-c00-12/BATU_TERMINAL_GOALS_TR.md`) | L-015 to L-033; EV-C00-005 (T-A2r, T-E2) | `plan/work/W-C00-05.md` |
| `W-C00-06` | Translate the plan package (plan C00 step 0) | accepted | todo (heavy) | EV-C00-006 (conventions, revisions 2 and 3); EV-C00-007 (proposals); EV-C00-008 (verdicts and dispositions); CHK-C00-007 to CHK-C00-019; CHK-C00-020 (final) | `plan/work/W-C00-06.md` |
| `W-C00-07` | ECC function comparison (plan C00 step 3) | accepted | todo (heavy) | EV-C00-011; CHK-C00-021 (conditions); CHK-C00-024 (conditions met) | `plan/work/W-C00-07.md` |
| `W-C00-08` | Independent plan review (plan C00 step 4) | accepted | todo (heavy) | CHK-C00-022, CHK-C00-023 (pass A); EV-C00-019 (pass B), with CHK-C00-046 to CHK-C00-048, CHK-C00-051, CHK-C00-053 to CHK-C00-056, with CHK-C00-052, CHK-C00-057, CHK-C00-058 on the redaction; dispositions at W-C00-10 round 2 (L-158) | `plan/work/W-C00-08.md` |
| `W-C00-09` | Independent counter-design of DevOS (plan C00 step 5) | accepted | todo (heavy) | EV-C00-009 (brief); EV-C00-010 (counter-design, independence declared low); EV-C00-012 (comparison with dispositions); CHK-C00-027 | `plan/work/W-C00-09.md` |
| `W-C00-10` | Decide on the results (plan C00 step 7) | accepted | todo | EV-C00-013, EV-C00-014 (round 1); EV-C00-020, EV-C00-021 (round 2); PC-07 to PC-17; CHK-C00-059, CHK-C00-060, CHK-C00-062 to CHK-C00-066 (L-160) | `plan/work/W-C00-10.md` |
| `W-C00-11` | Stage closure review | accepted | todo | CHK-C00-067 (closure verdict, PASS-WITH-CONDITIONS); EV-C00-022 (its conditions 1 and 2); CHK-C00-068 (the probe tool) (L-161); CHK-C00-069 (PASS-WITH-CONDITIONS); PC-18 (L-162); CHK-C00-070 (PASS-WITH-CONDITIONS); PC-18 revised; the value scan, CHK-C00-071 (L-163); CHK-C00-073 (PASS-WITH-CONDITIONS; L-164); the repeated probe and value scan, EV-C00-022 section 1c (L-165); CHK-C00-074 (PASS-WITH-CONDITIONS; L-166); CHK-C00-075 (PASS; accepted, L-167) | `plan/work/W-C00-11.md` |
| `W-C00-12` | Holistic redesign of the builder's operating model (before any heavy C00 item) | cancelled | doing: R-W12-1 FAIL (L-041); revision 3 with test register and tranche plan (L-042); narrow re-review R-W12-2 PASS-WITH-CONDITIONS (L-043); dispositions and C1–C6 text fixes done, conditions judged per part; H-PRB and P-W12-3 deferred after a classifier refusal (L-044); tranche 1a done (L-045); 1b-i next | L-036 to L-045; `plan/builder/w-c00-12/`; P-W12-1, P-W12-2, T-C1; R-W12-1, R-W12-2 | `plan/work/W-C00-12.md` |
| `W-C00-12.1` | Tranche 1a: probes | cancelled | — | — | `plan/work/W-C00-12.1.md` |
| `W-C00-12.2` | Tranche 1b-i: records and render | accepted | — | — | `plan/work/W-C00-12.2.md` |
| `W-C00-12.3` | Tranche 1b-ii: checks and stop | accepted | — | — | `plan/work/W-C00-12.3.md` |
| `W-C00-12.4` | Tranche 1c: hooks, CLAUDE.md, roles | cancelled | — | — | `plan/work/W-C00-12.4.md` |
| `W-C00-12.5` | Tranche 1d: workflows, retirement, plan text | cancelled | — | — | `plan/work/W-C00-12.5.md` |
| `W-C00-12.6` | Permission model by D-008: the guard decides every call with a written reason; sessions in Accept edits on Opus 5.5 at ultracode effort | cancelled | — | — | `plan/work/W-C00-12.6.md` |
| `W-C00-13` | Turkish summary for Batu (plan 0.6 item 1) | accepted | — | plan/Summary_for_Batu_TR.md; CHK-C00-025 (conditions); CHK-C00-026 (conditions met, K1 and K2 in L-144) | `plan/work/W-C00-13.md` |
| `W-C00-14` | Interim leak check in the guard for C00–C04 (W-C00-10 T-01) | accepted | — | .claude/hooks/tool_allowlist.py (L1–L3); tools/leak_fingerprints.py; tools/test_tool_allowlist.sh; plan/Installation_Working_Order.md section 10; CHK-C00-033 (FAIL, fixed); CHK-C00-037 (PASS); merged in PR | `plan/work/W-C00-14.md` |
| `W-C00-15` | No-mechanism baseline before C02 (W-C00-10 T-24) | accepted | — | EV-C00-016 (pre-registration, revisions 1 and 2); evidence/C00/baseline/ (texts, materials, criteria, checks, runs, scoring, check3_record.md); EV-C00-017 (results); CHK-C00-041 to CHK-C00-044; evidence/C00/baseline/audit/; step-10 check CHK-C00-045 (PASS-WITH-CONDITIONS, conditions met in EV-C00-017, L-156) | `plan/work/W-C00-15.md` |
| `W-C01-01` | Stage work list | accepted | — | — | `plan/work/W-C01-01.md` |
| `W-C01-02` | Key inventory (N-105) | accepted | — | — | `plan/work/W-C01-02.md` |
| `W-C01-03` | Probe design: the setup P1 to P3, each probe, N-109's check and Batu's steps | ready | — | — | `plan/work/W-C01-03.md` |
| `W-C01-04` | Probe-only guard rule | blocked: depends on W-C01-03 (not accepted) | — | — | `plan/work/W-C01-04.md` |
| `W-C01-05` | Probe setup in place: Batu's C01 steps (Section 12 item 0) | blocked: depends on W-C01-03 (not accepted) | — | — | `plan/work/W-C01-05.md` |
| `W-C01-06` | Row 1: session duration and chunked work (C01 #1) | blocked: depends on W-C01-05 (not accepted) | — | — | `plan/work/W-C01-06.md` |
| `W-C01-07` | Row 2: connector barrier (C01 #2) | blocked: depends on W-C01-04 (not accepted) | — | — | `plan/work/W-C01-07.md` |
| `W-C01-08` | Row 3: environment token (C01 #3) | blocked: depends on W-C01-04 (not accepted) | — | — | `plan/work/W-C01-08.md` |
| `W-C01-09` | Row 4, documentation part: how a subagent call completes, and what the hook input says (C01 #4) | accepted | — | — | `plan/work/W-C01-09.md` |
| `W-C01-10` | Row 4, probe part: subagents in a session started by a routine (C01 #4) | blocked: depends on W-C01-05 (not accepted) | — | — | `plan/work/W-C01-10.md` |
| `W-C01-11` | Row 17: control surface across environments (C01 #17) | blocked: depends on W-C01-04 (not accepted) | — | — | `plan/work/W-C01-11.md` |
| `W-C01-12` | Row 5: daily routine limit (C01 #5) | blocked: depends on W-C01-05 (not accepted) | — | — | `plan/work/W-C01-12.md` |
| `W-C01-13` | Row 6: notification (C01 #6) | blocked: depends on W-C01-03 (not accepted) | — | — | `plan/work/W-C01-13.md` |
| `W-C01-14` | Row 7: embedding model, the session part (C01 #7) | blocked: depends on W-C01-05 (not accepted) | — | — | `plan/work/W-C01-14.md` |
| `W-C01-15` | Row 8: release chain (C01 #8) | blocked: depends on W-C01-04 (not accepted) | — | — | `plan/work/W-C01-15.md` |
| `W-C01-16` | Row 9: single- and multi-repository sessions; the guard hook (C01 #9) | blocked: depends on W-C01-04 (not accepted) | — | — | `plan/work/W-C01-16.md` |
| `W-C01-17` | Row 10: usage observation (C01 #10) | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-17.md` |
| `W-C01-18` | Row 11: identity (C01 #11) | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-18.md` |
| `W-C01-19` | Row 12: repository access limit; the git credential (C01 #12) | blocked: depends on W-C01-04 (not accepted) | — | — | `plan/work/W-C01-19.md` |
| `W-C01-20` | Row 13: plugin and skill inventory (C01 #13) | blocked: depends on W-C01-05 (not accepted) | — | — | `plan/work/W-C01-20.md` |
| `W-C01-21` | Row 14: dynamic workflows and Projects (C01 #14) | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-21.md` |
| `W-C01-22` | Row 15: library transfer, moved to C04 (C01 #15) | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-22.md` |
| `W-C01-23` | Row 16: second model, the free tier's terms (C01 #16) | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-23.md` |
| `W-C01-24` | Row 18: platform-side readers (C01 #18) | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-24.md` |
| `W-C01-25` | Phase-A probe (PC-16) | ready | — | — | `plan/work/W-C01-25.md` |
| `W-C01-26` | N-109: do the platform's session credentials act beyond the session? | blocked: depends on W-C01-03 (not accepted) | — | — | `plan/work/W-C01-26.md` |
| `W-C01-27` | N-063: the counter-design rows decided from C01's observations | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-27.md` |
| `W-C01-28` | N-110: follow-ups of D-016's carriers | accepted | — | — | `plan/work/W-C01-28.md` |
| `W-C01-29` | C01's combined scenario; probe setup removed when C01 ends | blocked: depends on W-C01-06 (not accepted) | — | — | `plan/work/W-C01-29.md` |
| `W-C01-30` | Stage close review | blocked: depends on W-C01-03 (not accepted) | — | — | `plan/work/W-C01-30.md` |
<!-- /generated -->

---

## 3. Acceptance conditions

The C00 acceptance conditions, with their legend and source, are the acceptance block of `plan/work/C00.md` (moved byte-identical in W-C00-12 tranche 1b-i). Each later stage's conditions enter its file when the stage starts.

---

## 4. Decisions and plan changes (index)

The numbering rule (rule 5 above) is unchanged. K1–K9 and B1–B3 are recorded in the plan itself.

<!-- generated:decisions-index -->
| ID | What | Class | Status | File |
|---|---|---|---|---|
| `D-001` | C00 heavy work waits for the weekly usage reset; light work now | batu | answered | `plan/decisions/D-001.md` |
| `D-002` | Standing usage policy (Builder Operating Model section 8) | batu | answered | `plan/decisions/D-002.md` |
| `D-003` | Residual risk: the connector barrier is a hook the builder can edit | batu | answered | `plan/decisions/D-003.md` |
| `D-006` | One step: start a new installation run (the session chain is at its lineage limit) | technical | declined | `plan/decisions/D-006.md` |
| `D-007` | One permission: let this run edit the builder's own rule texts for tranche 1c | technical | declined | `plan/decisions/D-007.md` |
| `D-008` | Sessions leave auto mode: a written rule file allows or denies every tool call with a detailed reason; every session the builder opens runs on Opus 5.5 at ultracode effort | batu | answered | `plan/decisions/D-008.md` |
| `D-009` | Starting sessions under D-008: may one builder session, whose only job is to start runs and review sessions, run in auto mode? | batu | withdrawn | `plan/decisions/D-009.md` |
| `D-010` | The installation runs in one working session that delegates to role-defined subagents and workflows; the old builder operating model is retired; one /goal for the whole installation | batu | answered | `plan/decisions/D-010.md` |
| `D-011` | Library access for the working session: the platform attaches the research library only with a person's approval, which a session in Accept edits (D-008) cannot give | batu | superseded | `plan/decisions/D-011.md` |
| `D-013` | The names of services connected to Batu's account are in the public history of devos (OI-012, L-147): accept, rewrite the history, or recreate the repository | technical | declined | `plan/decisions/D-013.md` |
| `D-014` | Reading the research library directly before C04, and on what terms (supersedes D-011; absorbs the unposted draft D-012) | batu | answered | `plan/decisions/D-014.md` |
| `D-015` | The form of questions to Batu: one sentence each, on issue #6 as usual; details only on request | batu | answered | `plan/decisions/D-015.md` |
| `D-016` | The thinking disciplines D1 to D9 in the installation: all nine trigger questions answered by every agent at the start of each work item, the answers recorded and their presence checked; the content is the agent's judgment, sampled by checkers | technical | answered | `plan/decisions/D-016.md` |
| `FR-02` | Frame review: why an operational step (D-006) and a technical permission (D-007) reached Batu as decisions, and the routing fix | technical | accepted | `plan/decisions/FR-02.md` |
| `FR-03` | Frame review of F-088-2: the live part of gate 1c runs on main after the merge, under the reviewed hook, before acceptance | technical | withdrawn | `plan/decisions/FR-03.md` |
| `PC-01` | Installation rhythm: each stage under a `/goal` target with three stop conditions | batu | superseded | `plan/decisions/PC-01.md` |
| `PC-02` | Branch management | batu | answered | `plan/decisions/PC-02.md` |
| `PC-03` | Continuity: merge into `main` before every stop | technical | answered | `plan/decisions/PC-03.md` |
| `PC-04` | Builder operating model for the installation period | technical | answered | `plan/decisions/PC-04.md` |
| `PC-05` | Technical approval of high-impact changes moves from Batu to independent review | batu | answered | `plan/decisions/PC-05.md` |
| `PC-06` | The installation runs in one working session: plan text for D-010 (working order in section 9, binding review until C03 by a fresh-context checker subagent, one installation-wide /goal) | batu | answered | `plan/decisions/PC-06.md` |
| `PC-07` | Leak control and safeguards for C00–C04: the "before the first public write" claims corrected; the interim fingerprint check in the guard until C04; the semantic layer in C04; safeguard 2 and the C00–C04 residual to Batu (D-014); the threshold tuned in C04 and issue writing tested in C03 | technical | answered | `plan/decisions/PC-07.md` |
| `PC-08` | What C02 builds: every record family, function group and scheduled job carries the stage that activates it; the context package, Grant, the request protocol between sessions and the Premise table deferred; the ready-marking job and devos_batu removed; ProtocolAudit bounded; the audit gate on effort reduction justified, with standing policies; the format-gate sample, impact-class rules, the enforced single-writer unit, the squeeze signal, the FrameReview seal and the Appendix B details settled | technical | answered | `plan/decisions/PC-08.md` |
| `PC-09` | The plan's text before C01: probe setups for C01 and the Batu steps they need, the effect channel inventory channel by channel, the stage-B guard hook, the migration path and the answer-key rule | technical | answered | `plan/decisions/PC-09.md` |
| `PC-10` | Principles and mechanisms decided now for later stages: a bounded "first form of the SOUL core"; SOUL requirements handed over; approval of high-impact merges by a required check; rule-change proposals; authenticated answers; the counter-design commissioned at admission; search option A; the same-model limit of C00 and a later second-model frame review; usage in U-5 and G9; two new open problems; the interpretation of criterion 23; the counter-designer role file corrected | technical | answered | `plan/decisions/PC-10.md` |
| `PC-11` | Editorial and consistency changes with no intended change of meaning: section citations in the checker verdict form, statements brought to the state after the translation, a legend for the acceptance marks, attribution notes after labelled passages, editorial fixes across the plan package, a terms section, and the platform-side readers of the session in the effect channel inventory | technical | answered | `plan/decisions/PC-11.md` |
| `PC-12` | Criterion 20 gets a mechanism, a stage and acceptance conditions (test data is synthetic and labelled, reviewed in C08 and C11); Section 0.5's access list is reconciled with option (a) of Section 5.5 (the machine account on Batu's other repositories) | technical | answered | `plan/decisions/PC-12.md` |
| `PC-13` | C00's acceptance block gets the condition PC-10 added to the plan; the platform-side readers of Section 6.7 get a label for every platform statement and a C01 row that reads the platform documentation (C01 #18); the follow-up points of CHK-C00-038 and CHK-C00-037 | technical | answered | `plan/decisions/PC-13.md` |
| `PC-14` | Questions to Batu in one sentence, with the details in the linked decision record (D-015); the stage work list copies the binding English conditions (N-086 item 1); D-014 = (a) recorded in Sections 0.5 and 12, and Appendix F step 1 on library access corrected (N-084, T-05); a question whose recommended option asks nothing of Batu becomes one line of information (from D-013, N-089); the Turkish summary follows | technical | answered | `plan/decisions/PC-14.md` |
| `PC-15` | The installation's exit rule for C00 step 7 and the loop limit of its own review-and-revision cycles, in the working order and cited from Section 9; C01 row 4 also reads and probes how a subagent call completes and what the hook input says about a subagent (W-C00-10 round 2: T-60, T-61, T-83) | technical | answered | `plan/decisions/PC-15.md` |
| `PC-16` | The stage order shown against C07's measures, with a bounded phase-A probe as a C01 task; "could not check" kept apart from "clean" and "fail"; a recorded defect in a decision's basis reopens it; applied migrations compared with main from C02; review records name what the reviewer shared and missing coverage; informed_of and relations carry how they were made and what they show (W-C00-10 round 2: T-62, T-63, T-64, T-65, T-20, T-34, T-68) | technical | answered | `plan/decisions/PC-16.md` |
| `PC-17` | Appendix D made faithful to its source: the D1, D2, D4 and D5 trigger questions widened back to the source's scope; re-evaluation also at a new constraint and before the first step of a new kind of action; each loss of the condensed texts written back into its Dn or accounted in the section 1 table, with rows for the orientation checkpoint and the trigger-list rules; D1 says what follows a failed from-scratch test (W-C00-10 round 2: T-70, T-64) | technical | answered | `plan/decisions/PC-17.md` |
| `PC-18` | C00's sixth acceptance condition interpreted: a "secret" is a key, token or password issued for Batu's accounts or for DevOS's resources; in the session's environment only, the credentials the Claude Code platform places in every session for its own channels are outside it, and only while they are confined to the session (checked by N-109 before C02 builds DevOS's environments); in a repository, a record or the chat every key counts, the platform's own included (CHK-C00-069 condition 1; CHK-C00-070 conditions 1 to 4) | technical | answered | `plan/decisions/PC-18.md` |
| `PC-19` | D-016's permanent carriers: the working order says how every agent answers the nine thinking-discipline questions, how their presence is checked, and that the stage close samples them; the log and verdict formats carry the block; the stage work list reads the stage's open notes; the role files and CLAUDE.md carry the rule; two tool checks (N-104) | technical | answered | `plan/decisions/PC-19.md` |
| `PC-20` | N-110, the follow-ups of D-016's carriers: what follows a DISCIPLINES MISSING result; the remedy for a log entry without the Disciplines line that reaches main (a correction entry, which render --check counts, and the stop check runs render --check); helpers' reports live only in the container's transcripts; the task check compares the whole discipline block; planted cases for the six surviving mutants | technical | answered | `plan/decisions/PC-20.md` |
<!-- /generated -->

---

## 5. Open notes

Open items became notes attached to the item or stage they concern (M-R3); OI-011 is retired as a container. Each note keeps its OI number as `origin`.

<!-- generated:open-notes -->
| Note | On | Origin | Status | First line |
|---|---|---|---|---|
| `N-028` | `C01` | OI-001 | open | **Item:** It is untested whether the session enforces `access: "read"` for `agentic-os-search`, either through the git proxy or through t... |
| `N-029` | `C01` | OI-004 | open | **Item:** The session's local git commit identity is `Claude <noreply@anthropic.com>`, not the machine account (EV-C00-001, row 8). Plan ... |
| `N-030` | `C01` | OI-005 | open | **Item:** Which credential the session's git proxy uses (machine account or Claude GitHub App installation) is unknown. This decides whet... |
| `N-047` | `C01` | relay-2026-10-03 | open | **Effort level of created sessions** (from Batu's conversation session `session_016Hi3ZYgAf2amYNGc43a3tr`, relayed by `session_01WcVuDQhD... |
| `N-048` | `C01` | relay-2026-10-03 | open | **Barrier premise in multi-repository sessions** (same relay as N-047). The cited settings documentation says a session with several repo... |
| `N-063` | `C01` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-073` | `C01` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-02 (whether... |
| `N-091` | `C01` | EV-C00-021 | open | T-49: each stage file lists Batu's steps from C01. The direction is decided now. The topic's reason is in its row of EV-C00-021 section 1... |
| `N-102` | `C01` | N-086 | open | **C01 #18 and the D-008 cost text** (carried from N-086 item (2) on `plan/work/C00.md` by CHK-C00-067 condition 3; N-086 came from CHK-C0... |
| `N-105` | `C01` | CHK-C00-067 | open | **The key inventory** (plan Section 12, "Key inventory": "The builder keeps a single inventory in C00"; CHK-C00-067 condition 4(c), findi... |
| `N-109` | `C01` | PC-18 | open | **Do the platform's session credentials act beyond the session?** (PC-18 place 5; CHK-C00-070 condition 2; 2026-10-06, L-163). C00's sixt... |
| `N-122` | `C01` | CHK-C01-006 | open | **Recommendations of CHK-C01-006 for C01's last items** (findings 4, 5 and 10; 2026-10-06, L-169; not conditions). (1) **Row 4's version,... |
| `N-124` | `C01` | CHK-C01-007 | open | **A probe token's revocation before C02** (CHK-C01-007 finding 8; 2026-10-06, L-170). Plan C01 row 3's fail path says "a token found outs... |
| `N-031` | `C02` | OI-006 | open | **Item:** EV-C00-001 has no raw-evidence reference (plan Section 8.9; Appendix B, `EvidenceEnvelope`). |
| `N-032` | `C02` | OI-007 | open | **Item:** FND-001 needs a class-level regression test (plan Section 6.11; Appendix C, C0). **Examples:** (a) this case; (b) "the builder'... |
| `N-064` | `C02` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-074` | `C02` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31 (strengt... |
| `N-092` | `C02` | EV-C00-021 | open | T-36, T-37 and T-77: ECC-80's revision binding, ECC-149's flag-and-keep, and the due occurrences of every scheduled job and routine check... |
| `N-112` | `C02` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-125` | `C02` | CHK-C01-007 | open | **Batu's steps for the installation environment's token and the CI role's key** (CHK-C01-007 finding 13(a); 2026-10-06, L-170). `plan/key... |
| `N-127` | `C02` | CHK-C01-009 | open | **Two planted cases owed to the discipline checks** (CHK-C01-009 finding 3; 2026-10-06, L-171). Two mutants of the PC-20 tools survive th... |
| `N-128` | `C02` | EV-C01-003 | open | Owner: the executor. Deadline: this stage's work list. |
| `N-033` | `C03` | 06#3a-g | open | **Counter-design hand-over note** (`plan/builder/w-c00-12/06_counter_design_comparison.md` section 3a row g, adopted; that file is retire... |
| `N-039` | `C03` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): agent governance and activity monitoring (... |
| `N-065` | `C03` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-075` | `C03` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31 (as for ... |
| `N-093` | `C03` | EV-C00-021 | open | T-81 and T-37: the audit verdict binds to the reviewed high-impact content, and the checks run on the PR combined with `main`; ECC-63's w... |
| `N-107` | `C03` | PC-18 | open | **The platform's own session credentials in test 3 and the effect channel inventory** (PC-18 place 3; CHK-C00-069 condition 1; CHK-C00-07... |
| `N-113` | `C03` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-123` | `C03` | CHK-C01-006 | open | **The audit environment's routine and row 4's version comparison** (CHK-C01-006 finding 10; 2026-10-06, L-169). N-111 (on `plan/work/C05.... |
| `N-034` | `C04` | OI-011#18 | open | (18) a bounded scan of the connector catalogue as an outside-in discovery method (Batu's suggestion; it complements need-first selection)... |
| `N-035` | `C04` | OI-011#19 | open | (19) the hook's blanket block of catalogue tools. The search tools (`SearchMcpRegistry`, `SearchPlugins`, `SearchSkills`) are read-only, ... |
| `N-036` | `C04` | OI-011#21 | open | (21) the structure that makes knowledge visible, for context activation (principle 12). The library's own structure is a pyramid, propose... |
| `N-066` | `C04` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-076` | `C04` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31 (as for ... |
| `N-090` | `C04` | L-157 | open | **The fingerprint layer matches common code** (2026-10-06, L-157; guard record #4610). The interim leak check (W-C00-14) denied a push be... |
| `N-094` | `C04` | EV-C00-021 | open | T-35, T-66, T-67, T-68, T-69, T-70 and T-58: source standing and study maturity in the catalogue; benchmark classes and a navigation arm;... |
| `N-103` | `C04` | CHK-C00-067 | open | **C00 task 4's C04 part: paths tried before and failed, in the old experiment repositories** (CHK-C00-067 condition 4(a), finding 9; 2026... |
| `N-108` | `C04` | CHK-C00-069 | open | **The corrected identity test, on new data** (CHK-C00-069 condition 4; 2026-10-06, L-162). C00's fifth condition ("The builder wrote noth... |
| `N-114` | `C04` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-126` | `C04` | CHK-C01-007 | open | **Batu's step for the ingestion role's key** (CHK-C01-007 finding 13(b); 2026-10-06, L-170). `plan/key_inventory.md` row 25: plan Section... |
| `N-046` | `C05` | OI-007 | open | **Pointer** to N-032 on `C02` (verbatim there): the behavioural part of the FND-001 regression test (the DR10 hidden exam) belongs to C05. |
| `N-067` | `C05` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-077` | `C05` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-13 (methods... |
| `N-095` | `C05` | EV-C00-021 | open | T-71, T-72, T-73, T-74, T-75, T-76, T-25, T-40, T-66, T-70, T-58, T-36 and T-37: exam design (a baseline arm, the grading method and a pr... |
| `N-111` | `C05` | CHK-C01-004 | open | **Row 4 is observed again whenever the Claude Code version changes** (plan C01 row 4, PC-15; CHK-C01-003 condition 2(a); CHK-C01-004 cond... |
| `N-040` | `C06` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): workflow engines and observability; voice ... |
| `N-068` | `C06` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-078` | `C06` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-37 (t... |
| `N-096` | `C06` | EV-C00-021 | open | T-30, T-34, T-61, T-78, T-58, T-36 and T-37: claim-generation-bound branches and merges; "seen" apart from "sent"; three subagent-complet... |
| `N-115` | `C06` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-041` | `C07` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): conversational agent builders as SOUL comp... |
| `N-087` | `C07` | EV-C00-017 | open | **The no-mechanism baseline for the removal test** (plan 6.12 item 4; W-C00-15, 2026-10-06, L-155). `evidence/C00/EV-C00-017_baseline_res... |
| `N-097` | `C07` | EV-C00-021 | open | T-07 and T-79: 1.2 item 2's bound and 10.3's entry on outcomes against reality outside the records; one rule for confirming a capability ... |
| `N-101` | `C07` | CHK-C00-063 | open | C01's phase-A probe works one real SOUL development question and records its question, its result and its checker's verdict before C02 (C... |
| `N-116` | `C07` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-042` | `C08` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): deployment hosts. |
| `N-044` | `C08` | 06#3a-g | open | **Pointer** to N-038 on `C09` (verbatim there): the recovery drill also restores the builder's state (06 section 3a row g names C08–C09). |
| `N-069` | `C08` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-079` | `C08` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-46 (t... |
| `N-085` | `C08` | CHK-C00-040 | open | **Real identifiers in the guard's test fixtures** (CHK-C00-040 C1, 2026-10-06, L-153; plan Section 8 item 13, criterion 20). The syntheti... |
| `N-098` | `C08` | EV-C00-021 | open | T-46 and T-80: the equivalence each portability test protects, a real workflow, host-enforced controls and gateway proof (C11's places to... |
| `N-117` | `C08` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-038` | `C09` | 06#3a-g | open | **Counter-design hand-over note** (`plan/builder/w-c00-12/06_counter_design_comparison.md` section 3a row g, adopted; that file is retire... |
| `N-070` | `C09` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-080` | `C09` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-48 (t... |
| `N-099` | `C09` | EV-C00-021 | open | T-65 and T-82: export marked only after read-back; freshness by content identity; restore lists derived from the inventories. The directi... |
| `N-118` | `C09` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-071` | `C10` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-081` | `C10` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-50 (a... |
| `N-088` | `C10` | EV-C00-017 | open | **The no-mechanism baseline for the removal test** (plan 6.12 item 4; W-C00-15, 2026-10-06, L-155). `evidence/C00/EV-C00-017_baseline_res... |
| `N-119` | `C10` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-043` | `C11` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): model hubs. |
| `N-082` | `C11` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-49 (c... |
| `N-100` | `C11` | EV-C00-021 | open | T-58: plan Section 13 checked against the ingested library. The direction is decided now. The topic's reason is in its row of EV-C00-021 ... |
| `N-120` | `C11` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |
| `N-121` | `C12` | CHK-C01-005 | open | **Pointer** to N-111 on `C05` (verbatim there): C01 row 4 is observed again whenever the Claude Code version changes (CHK-C01-005 conditi... |

Notes `answered` (answered inside W-C00-12, which D-010 cancelled on 2026-10-05; kept on their items as history): 19 (N-006, N-007, N-008, N-009, N-010, N-011, N-012, N-013, N-014, N-015, N-016, N-017, N-018, N-019, N-020, N-022, N-023, N-024, N-025).
Notes `closed` (closed with their disposition): 29 (N-027, N-045, N-058, N-062, N-084, N-086, N-106, N-104, N-110, N-037, N-001, N-002, N-003, N-004, N-005, N-061, N-060, N-072, N-083, N-089, N-051, N-056, N-059, N-021, N-026, N-049, N-050, N-052, N-053).
<!-- /generated -->

Gaps: see EV-C00-003 (G-001 to G-017; final version with a disposition per gap). Findings: FND-001 in `plan/ledger/C00-log.md`.
