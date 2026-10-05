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
| Stage | **C00 running** in the working session `session_01WKJi23FwAjFtiyD1DbQ2Rs` (opened 2026-10-05, L-136): first the checker acceptance of W-C00-01, 02 and 04 (N-051), then step 0, W-C00-06 (plan 0.6). | 2026-10-05T20:27Z |
| Next action | Generated: the startable frontier in section 2 (`plan/Installation_Working_Order.md` section 4). It is not written by hand. | 2026-10-05T18:59Z |
| Usage | `five_hour` `allowed` at 21:14Z (`get_session`, working session), resets sched:2026-10-06T02:10Z (`resetsAt` 1791252600, converted with `date -u -d @`) (D-002: proceed). | 2026-10-05T21:14Z |
| Waiting for Batu | Generated: open decisions of class `batu` in section 4, and the first line of `DURUM.md`. Issue #6 was answered on 2026-10-02T06:27Z (D-002, D-003). | 2026-10-03T19:50Z |
| Binding plan text | The English plan package (W-C00-06 accepted on CHK-C00-020; plan 0.6 item 1: the Turkish text was binding until the fidelity review passed and is removed from the repository by this merge, history at `3de3a17`), with recorded changes PC-01 to PC-06 (PC-01 superseded by PC-06) | 2026-10-05 |
| answers seen through | issue #6 comment `5978009744` (2026-10-04T08:13Z, `batuhanozgun`): D-006 and D-007 declined as not his, recorded in `plan/decisions/D-006.md` and `D-007.md`; D-002's night preference removed (his conversation-session text of about 08:00Z, `briefs/w-c00-12/BATU_CUSTOMER_ROLE_TR.md`), recorded in `plan/decisions/D-002.md` | 2026-10-04T08:33Z |
| summary_tr | Senden beklenen: iki karar, D-014 ve D-013 (D-011'in yerine geçtiler; D-011'e cevap gerekmez). Ayrıntı ve adımlar "Batu'dan beklenenler" issue'sunda. <br>1. D-014: Kütüphaneni C04'ten önce okuyayım mı? Önerim (a): üç koşulla şimdi oku. Koşullar: kütüphanede push e-postalarını açman, bir kez kısa bir Auto penceresi, C04'e kadar yalnız birebir kopya kontrolünü kabul etmen. <br>2. D-013: Hesabına bağlı servislerin adları açık deponun eski kayıtlarında kalıyor; bir kısmını bugün ben yeniden yazmıştım, güncel dosyalardan temizledim. Önerim (a): kabul. <br>3. C00'ın karar adımı sürüyor: plan değişiklikleri denetimden geçti ve ana dala girdi; denetçinin istediği iki küçük düzeltme yapılıyor. Açık depoya yazılanı kodla denetleyen ara kontrol denetimden geçti; ana dala giriyor. <br>**D-014'e cevap gelmezse:** kütüphane bağlanmaz; incelemenin ve karşılaştırma denemesinin kütüphane kısmı bekler, C00 kapanamaz; diğer işler sürer. **D-013'e cevap gelmezse:** hiçbir iş beklemez. | 2026-10-05T23:58Z |
| Rendered | Written by `tools/records.py render` from the clock; `DURUM.md`'s update line comes from here. | 2026-10-05T23:53Z |

---

## 2. Next action: the startable frontier

<!-- generated:frontier -->
**Ready (startable now):**
- none

**Running:**
- `W-C00-08` Independent plan review (plan C00 step 4): claimed by `session_01WKJi23FwAjFtiyD1DbQ2Rs`
- `W-C00-10` Decide on the results (plan C00 step 7): claimed by `session_01WKJi23FwAjFtiyD1DbQ2Rs`
- `W-C00-14` Interim leak check in the guard for C00–C04 (W-C00-10 T-01): claimed by `session_01WKJi23FwAjFtiyD1DbQ2Rs`

**Not ready, with the first unmet condition:**
- `W-C00-03`: finished, waiting for acceptance
- `W-C00-11`: depends on W-C00-03 (not accepted)
- `W-C00-15`: depends on W-C00-14 (not accepted)

Selection among ready items: critical path first, one logged sentence of reason (`plan/Installation_Working_Order.md` section 4). Candidates never appear here; they are in the zoom view.
<!-- /generated -->

### Zoom

<!-- generated:zoom -->
**Horizontal: every stage, one line each.**

| Stage | Title | State | Items by state | Open notes |
|---|---|---|---|---|
| `C00` | Start, function comparison and independent review of the plan | running | accepted 9, blocked 2, cancelled 6, finished 1, running 3 | 12 |
| `C01` | Platform verification | planned | no items | 7 |
| `C02` | Data model, rule gate and identity chain | planned | no items | 4 |
| `C03` | Trust boundaries and effect channels | planned | no items | 4 |
| `C04` | Knowledge, search and context | planned | no items | 5 |
| `C05` | Common rules, roles and methods | planned | no items | 3 |
| `C06` | Working order, audit and decision channel | planned | no items | 3 |
| `C07` | First real loop: the cognitive gate | planned | no items | 1 |
| `C08` | Model access layer, release, whole product and the SOUL repository | planned | no items | 4 |
| `C09` | Outage, backup, restore and reconnection | planned | no items | 3 |
| `C10` | Learning, purpose audit, process limit and assumption inventory | planned | no items | 2 |
| `C11` | Integrated testing, unattended operation, capacity and provider independence | planned | no items | 2 |
| `C12` | Hand-over | planned | no items | 0 |

**Vertical: the active branch expanded; siblings one line; the rest collapsed.**

- `C00` Start, function comparison and independent review of the plan: running · open notes: N-027, N-045, N-062
  - `W-C00-01` Read the plan package: accepted
  - `W-C00-02` Preparation verification (plan C00 step 1): accepted
  - `W-C00-03` Gap and contradiction list: finished, not accepted · open notes: N-002
  - `W-C00-04` Premise inventory (plan C00 step 6): accepted
  - `W-C00-05` Builder operating model (PC-04): cancelled
  - `W-C00-06` Translate the plan package (plan C00 step 0): accepted · open notes: N-003, N-004
  - `W-C00-07` ECC function comparison (plan C00 step 3): accepted
  - `W-C00-08` Independent plan review (plan C00 step 4): running (session_01WKJi23FwAjFtiyD1DbQ2Rs) · open notes: N-061
  - `W-C00-09` Independent counter-design of DevOS (plan C00 step 5): accepted
  - `W-C00-10` Decide on the results (plan C00 step 7): running (session_01WKJi23FwAjFtiyD1DbQ2Rs) · open notes: N-060, N-072
  - `W-C00-11` Stage closure review: blocked: depends on W-C00-03 (not accepted) · open notes: N-051, N-056, N-059
  - `W-C00-12` Holistic redesign of the builder's operating model (before any heavy C00 item): cancelled · 6 children (accepted 2, cancelled 4)
  - `W-C00-13` Turkish summary for Batu (plan 0.6 item 1): accepted
  - `W-C00-14` Interim leak check in the guard for C00–C04 (W-C00-10 T-01): running (session_01WKJi23FwAjFtiyD1DbQ2Rs)
  - `W-C00-15` No-mechanism baseline before C02 (W-C00-10 T-24): blocked: depends on W-C00-14 (not accepted)
<!-- /generated -->

### Work index

Each item's acceptance condition, front matter and notes are in its file (`plan/work/<ID>.md`). The status column of the v1.7 work list is kept verbatim in each item's `legacy_status`.

<!-- generated:work-index -->
| ID | Item | State | v1.7 status (verbatim) | Evidence | File |
|---|---|---|---|---|---|
| `W-C00-01` | Read the plan package | accepted | done | L-136 (the current plan package text, at 1c16dd7); L-001 (only the text at 6186e5d) | `plan/work/W-C00-01.md` |
| `W-C00-02` | Preparation verification (plan C00 step 1) | accepted | done | EV-C00-002, L-010 | `plan/work/W-C00-02.md` |
| `W-C00-03` | Gap and contradiction list | finished, not accepted | doing (v1 done) | EV-C00-003 | `plan/work/W-C00-03.md` |
| `W-C00-04` | Premise inventory (plan C00 step 6) | accepted | done (v1) | EV-C00-004 (revised 2026-10-05, L-139); CHK-C00-004 (conditions); CHK-C00-006 (conditions met) | `plan/work/W-C00-04.md` |
| `W-C00-05` | Builder operating model (PC-04) | cancelled | done by the producer's own judgement (L-033), not independently accepted; superseded in substance by W-C00-12 (principle 11, `briefs/w-c00-12/BATU_TERMINAL_GOALS_TR.md`) | L-015 to L-033; EV-C00-005 (T-A2r, T-E2) | `plan/work/W-C00-05.md` |
| `W-C00-06` | Translate the plan package (plan C00 step 0) | accepted | todo (heavy) | EV-C00-006 (conventions, revisions 2 and 3); EV-C00-007 (proposals); EV-C00-008 (verdicts and dispositions); CHK-C00-007 to CHK-C00-019; CHK-C00-020 (final) | `plan/work/W-C00-06.md` |
| `W-C00-07` | ECC function comparison (plan C00 step 3) | accepted | todo (heavy) | EV-C00-011; CHK-C00-021 (conditions); CHK-C00-024 (conditions met) | `plan/work/W-C00-07.md` |
| `W-C00-08` | Independent plan review (plan C00 step 4) | running (session_01WKJi23FwAjFtiyD1DbQ2Rs) | todo (heavy) | — | `plan/work/W-C00-08.md` |
| `W-C00-09` | Independent counter-design of DevOS (plan C00 step 5) | accepted | todo (heavy) | EV-C00-009 (brief); EV-C00-010 (counter-design, independence declared low); EV-C00-012 (comparison with dispositions); CHK-C00-027 | `plan/work/W-C00-09.md` |
| `W-C00-10` | Decide on the results (plan C00 step 7) | running (session_01WKJi23FwAjFtiyD1DbQ2Rs) | todo | — | `plan/work/W-C00-10.md` |
| `W-C00-11` | Stage closure review | blocked: depends on W-C00-03 (not accepted) | todo | — | `plan/work/W-C00-11.md` |
| `W-C00-12` | Holistic redesign of the builder's operating model (before any heavy C00 item) | cancelled | doing: R-W12-1 FAIL (L-041); revision 3 with test register and tranche plan (L-042); narrow re-review R-W12-2 PASS-WITH-CONDITIONS (L-043); dispositions and C1–C6 text fixes done, conditions judged per part; H-PRB and P-W12-3 deferred after a classifier refusal (L-044); tranche 1a done (L-045); 1b-i next | L-036 to L-045; `plan/builder/w-c00-12/`; P-W12-1, P-W12-2, T-C1; R-W12-1, R-W12-2 | `plan/work/W-C00-12.md` |
| `W-C00-12.1` | Tranche 1a: probes | cancelled | — | — | `plan/work/W-C00-12.1.md` |
| `W-C00-12.2` | Tranche 1b-i: records and render | accepted | — | — | `plan/work/W-C00-12.2.md` |
| `W-C00-12.3` | Tranche 1b-ii: checks and stop | accepted | — | — | `plan/work/W-C00-12.3.md` |
| `W-C00-12.4` | Tranche 1c: hooks, CLAUDE.md, roles | cancelled | — | — | `plan/work/W-C00-12.4.md` |
| `W-C00-12.5` | Tranche 1d: workflows, retirement, plan text | cancelled | — | — | `plan/work/W-C00-12.5.md` |
| `W-C00-12.6` | Permission model by D-008: the guard decides every call with a written reason; sessions in Accept edits on Opus 5.5 at ultracode effort | cancelled | — | — | `plan/work/W-C00-12.6.md` |
| `W-C00-13` | Turkish summary for Batu (plan 0.6 item 1) | accepted | — | plan/Summary_for_Batu_TR.md; CHK-C00-025 (conditions); CHK-C00-026 (conditions met, K1 and K2 in L-144) | `plan/work/W-C00-13.md` |
| `W-C00-14` | Interim leak check in the guard for C00–C04 (W-C00-10 T-01) | running (session_01WKJi23FwAjFtiyD1DbQ2Rs) | — | — | `plan/work/W-C00-14.md` |
| `W-C00-15` | No-mechanism baseline before C02 (W-C00-10 T-24) | blocked: depends on W-C00-14 (not accepted) | — | — | `plan/work/W-C00-15.md` |
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
| `D-013` | The names of services connected to Batu's account are in the public history of devos (OI-012, L-147): accept, rewrite the history, or recreate the repository | batu | open | `plan/decisions/D-013.md` |
| `D-014` | Reading the research library directly before C04, and on what terms (supersedes D-011; absorbs the unposted draft D-012) | batu | open | `plan/decisions/D-014.md` |
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
<!-- /generated -->

---

## 5. Open notes

Open items became notes attached to the item or stage they concern (M-R3); OI-011 is retired as a container. Each note keeps its OI number as `origin`.

<!-- generated:open-notes -->
| Note | On | Origin | Status | First line |
|---|---|---|---|---|
| `N-027` | `C00` | OI-003 | open | **Item:** Environment variables named `GH_TOKEN` and `GITHUB_TOKEN` exist in the builder session (EV-C00-001, row 8). Whether they are us... |
| `N-045` | `C00` | OI-004 | open | **Pointer** to N-029 on `C01` (verbatim there): the commit identity is checked first in C00 step 1 (B3 check), then in C01 row 11. |
| `N-062` | `C00` | CHK-C00-025 | open | **For Batu's next batch: D-003's coverage of OI-012** (from W-C00-13's check, 2026-10-05, L-144). D-003's `reopen_if` (L-045, 2026-10-03)... |
| `N-028` | `C01` | OI-001 | open | **Item:** It is untested whether the session enforces `access: "read"` for `agentic-os-search`, either through the git proxy or through t... |
| `N-029` | `C01` | OI-004 | open | **Item:** The session's local git commit identity is `Claude <noreply@anthropic.com>`, not the machine account (EV-C00-001, row 8). Plan ... |
| `N-030` | `C01` | OI-005 | open | **Item:** Which credential the session's git proxy uses (machine account or Claude GitHub App installation) is unknown. This decides whet... |
| `N-047` | `C01` | relay-2026-10-03 | open | **Effort level of created sessions** (from Batu's conversation session `session_016Hi3ZYgAf2amYNGc43a3tr`, relayed by `session_01WcVuDQhD... |
| `N-048` | `C01` | relay-2026-10-03 | open | **Barrier premise in multi-repository sessions** (same relay as N-047). The cited settings documentation says a session with several repo... |
| `N-063` | `C01` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-073` | `C01` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-02 (whether... |
| `N-031` | `C02` | OI-006 | open | **Item:** EV-C00-001 has no raw-evidence reference (plan Section 8.9; Appendix B, `EvidenceEnvelope`). |
| `N-032` | `C02` | OI-007 | open | **Item:** FND-001 needs a class-level regression test (plan Section 6.11; Appendix C, C0). **Examples:** (a) this case; (b) "the builder'... |
| `N-064` | `C02` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-074` | `C02` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31 (strengt... |
| `N-033` | `C03` | 06#3a-g | open | **Counter-design hand-over note** (`plan/builder/w-c00-12/06_counter_design_comparison.md` section 3a row g, adopted; that file is retire... |
| `N-039` | `C03` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): agent governance and activity monitoring (... |
| `N-065` | `C03` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-075` | `C03` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31 (as for ... |
| `N-034` | `C04` | OI-011#18 | open | (18) a bounded scan of the connector catalogue as an outside-in discovery method (Batu's suggestion; it complements need-first selection)... |
| `N-035` | `C04` | OI-011#19 | open | (19) the hook's blanket block of catalogue tools. The search tools (`SearchMcpRegistry`, `SearchPlugins`, `SearchSkills`) are read-only, ... |
| `N-036` | `C04` | OI-011#21 | open | (21) the structure that makes knowledge visible, for context activation (principle 12). The library's own structure is a pyramid, propose... |
| `N-066` | `C04` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-076` | `C04` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31 (as for ... |
| `N-046` | `C05` | OI-007 | open | **Pointer** to N-032 on `C02` (verbatim there): the behavioural part of the FND-001 regression test (the DR10 hidden exam) belongs to C05. |
| `N-067` | `C05` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-077` | `C05` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-13 (methods... |
| `N-040` | `C06` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): workflow engines and observability; voice ... |
| `N-068` | `C06` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-078` | `C06` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-37 (t... |
| `N-041` | `C07` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): conversational agent builders as SOUL comp... |
| `N-042` | `C08` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): deployment hosts. |
| `N-044` | `C08` | 06#3a-g | open | **Pointer** to N-038 on `C09` (verbatim there): the recovery drill also restores the builder's state (06 section 3a row g names C08–C09). |
| `N-069` | `C08` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-079` | `C08` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-46 (t... |
| `N-038` | `C09` | 06#3a-g | open | **Counter-design hand-over note** (`plan/builder/w-c00-12/06_counter_design_comparison.md` section 3a row g, adopted; that file is retire... |
| `N-070` | `C09` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-080` | `C09` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-48 (t... |
| `N-071` | `C10` | EV-C00-012 | open | **Open items from the counter-design comparison** (W-C00-09, `evidence/C00/EV-C00-012_counter_design_comparison.md`, 2026-10-05, L-145). ... |
| `N-081` | `C10` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-50 (a... |
| `N-043` | `C11` | OI-011#20 | open | **Design reference for this stage** from OI-011 item 20 (N-022 on `W-C00-12`, verbatim there): model hubs. |
| `N-082` | `C11` | EV-C00-014 | open | **Decided at this stage, from W-C00-10 round 1** (`evidence/C00/EV-C00-014_w10_round1_dispositions.md`, 2026-10-05, L-146): T-31, T-49 (c... |
| `N-002` | `W-C00-03` | OI-002 | open | **Item:** Safeguard 2 of plan Section 0.5 (independent monitoring of machine-account commits in the library) is probably not in place. |
| `N-003` | `W-C00-06` | OI-011#10 | open | (10) names that say what a thing is, in all three scopes (installation, DevOS, SOUL), probably as plan section 0.7 like 0.6; |
| `N-004` | `W-C00-06` | OI-011#12 | open | (12) the boundary between DevOS's design files (`plan/`) and the builder's own rules. |
| `N-061` | `W-C00-08` | CHK-C00-022 | open | **Pass A done; pass B waits** (2026-10-05, L-143). Pass A (L-142) ran in two lenses on the binding English text at `8349242`, each a fres... |
| `N-060` | `W-C00-10` | CHK-C00-021 | open | - **Rows it could reopen:** any row whose decision rests on a fact the study contradicts or adds to. First: the five adopt rows (no-progr... |
| `N-072` | `W-C00-10` | CHK-C00-027 | open | **From W-C00-09's check** (CHK-C00-027 findings 2 and 9, 2026-10-05, L-145). (1) The counter-designer's role file (`.claude/agents/counte... |
| `N-051` | `W-C00-11` | R-W12-3#F-11 | open | **How W-C00-01 to W-C00-04 reach acceptance before this item** (R-W12-3 F-11; re-disposed 2026-10-05 by D-010, summary item 30; it replac... |
| `N-056` | `W-C00-11` | R-FR02-2 | open | **Open blockers at stage closure** (R-FR02-2 m4, carried by run `session_017bQAUeV7o6pTvG1Pz3hRHx`; re-pointed 2026-10-05 by D-010 from t... |
| `N-059` | `W-C00-11` | CHK-C00-003 | open | **For the closure review** (from the acceptance verdicts of N-051, 2026-10-05). CHK-C00-003 (W-C00-02) findings F-5 to F-7: W-C00-02's ac... |

Notes `answered` (answered inside W-C00-12, which D-010 cancelled on 2026-10-05; kept on their items as history): 19 (N-006, N-007, N-008, N-009, N-010, N-011, N-012, N-013, N-014, N-015, N-016, N-017, N-018, N-019, N-020, N-022, N-023, N-024, N-025).
Notes `closed` (closed with their disposition): 10 (N-058, N-037, N-001, N-005, N-021, N-026, N-049, N-050, N-052, N-053).
<!-- /generated -->

Gaps: see EV-C00-003 (G-001 to G-015). Findings: FND-001 in `plan/ledger/C00-log.md`.
