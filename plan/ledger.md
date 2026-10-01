# DevOS installation ledger: state file

**What this file is.** The builder's single, short, always-current state file during installation (Builder Operating Model §3.3). Log entries are in `plan/ledger/<stage>-log.md` (append-only), evidence in `evidence/<stage>/`, and Batu's status page is `DURUM.md`. Until the ledger is transferred to the database at the end of C02 (plan Section 9), these files are the authoritative installation record.

**Rules**

1. `devos` is public: only safe summaries and identifiers. No library text, no conversation transcripts, no key or token values. The exception is Batu's own decisions, constraints and expectations, which are recorded verbatim in Turkish with an English interpretation (plan 0.6 item 2).
2. Until the translation fidelity review passes, the Turkish plan package is binding (plan 0.6).
3. Acceptance conditions are written and merged **before** work on an item starts and are never loosened afterwards. If loosening is needed, the earlier result is void and the test is repeated (plan Section 9; 8.6; 14).
4. Every access or permission statement names its enforcement layer and its verification status (FND-001).
5. **Numbering.** `K<n>`/`B<n>`: Batu's formal decisions only (K1–K9, B1–B3). Not decisions: the plan's capability sections `K-1`…`K-11` and Appendix C's test IDs `K01`…`K13`. `PC-<n>`: the builder's plan changes; the parts that are Batu's own decisions are marked "[Batu, date]". `D-<n>`: decision records. `L-<n>`: log entries. `W-<stage>-<nn>`: work items. `EV-…`: evidence. `G-…`: gaps. `OI-…`: open items. `FND-…`: findings. `T-…`: tests.
6. Nothing exists until it is written here or in the log or evidence **and merged into `main`** (Builder Operating Model §3.2, §3.4).

---

## 1. Current state

| Item | State | As of |
|---|---|---|
| Stage | **C00** in progress. W-C00-05 (builder operating model) is in progress; heavy C00 items wait for the weekly usage reset (D-001). | 2026-10-01T18:40Z |
| Run lock | `session_016Hi3ZYgAf2amYNGc43a3tr` (the first builder session; started by Batu). Expires 2026-10-01T22:16Z unless renewed. | 2026-10-01T19:16Z |
| Next action | Finish W-C00-05: narrow re-check R-C00-BOM-6 of the v1.6 fixes (L-023); on PASS merge PR #4, hand over to a fresh run, then tests T-B1, T-A2, T-H7 and the Batu issue (D-002, D-003). | 2026-10-01T19:35Z |
| Usage | `seven_day` `allowed_warning`; resets 2026-10-03T17:00Z. Light work only, under D-001; a scheduled wake-up is set for 2026-10-03T17:15Z. | 2026-10-01T18:40Z |
| Waiting for Batu | Nothing blocking. One decision will be raised with the operating-model briefing: D-002, a standing usage policy. | 2026-10-01T18:40Z |
| Binding plan text | Turkish plan package plus recorded changes PC-01 to PC-05 | 2026-10-01 |

---

## 2. Work list: C00

Acceptance conditions are written before work starts. Status: todo / doing / done / blocked-Batu / blocked.

| ID | Item | Acceptance condition | Status | Evidence |
|---|---|---|---|---|
| W-C00-01 | Read the plan package | Every file read completely before any change | done | L-001 |
| W-C00-02 | Preparation verification (plan C00 step 1) | Every preparation item verified at a stated level | done | EV-C00-002, L-010 |
| W-C00-03 | Gap and contradiction list | First version recorded; final version with a disposition per gap at W-C00-10 | doing (v1 done) | EV-C00-003 |
| W-C00-04 | Premise inventory (plan C00 step 6) | Every premise has an origin, a validity check and the from-scratch test | done (v1) | EV-C00-004 |
| W-C00-05 | Builder operating model (PC-04) | (a) Design and premises written; (b) independent counter-design compared, with a disposition per difference; (c) tests T-A1a, T-A1b, ~~T-A1c~~, T-H1, T-H2, T-E1 pass; T-B1, T-A2 and T-E2 pass, or their limits are written. **Acceptance change, before closure (R-C00-BOM-2 M5; high-impact, reviewed in R-C00-BOM-3):** T-A1c tested a premise (BP-04) that was falsified and withdrawn, so it is not a test to re-pass. It is replaced by T-H3, T-H4 and T-H5, which test the barrier that replaced the premise. T-H1 counts only for the session it was observed in. (d) independent review PASS (or PASS-WITH-CONDITIONS, with the conditions met); (e) merged into `main`, with `DURUM.md` live; (f) plan and Appendix F updated by recorded plan change; **added before results, from R-C00-BOM-1 M7:** (g) one short Turkish briefing to Batu saying what changes for him and which decisions are his; (h) the "Batu'dan beklenenler" issue opened and assigned to Batu (T-D1) | doing | L-015 onward; EV-C00-005 |
| W-C00-06 | Translate the plan package (plan C00 step 0) | Every file translated; a separate fidelity-review session compares each section with the Turkish original; every finding gets a disposition; review passes; improvements recorded separately as proposals | todo (heavy) | — |
| W-C00-07 | ECC function comparison (plan C00 step 3) | Every ECC component compared with DevOS needs: adopt / disable / undecided, with reasons | todo (heavy) | — |
| W-C00-08 | Independent plan review (plan C00 step 4) | A session that sees only the plan, criteria and sources reviews it; findings returned through the repository; each gets a disposition | todo (heavy) | — |
| W-C00-09 | Independent counter-design of DevOS (plan C00 step 5) | A session that does not see the plan designs DevOS's working structure and data-model scope; the comparison is recorded with dispositions | todo (heavy) | — |
| W-C00-10 | Decide on the results (plan C00 step 7) | Every finding of W-C00-03, 07, 08 and 09 has a disposition; plan changes are recorded per plan Section 14 | todo | — |
| W-C00-11 | Stage closure review | A session that did no C00 work checks every C00 acceptance condition against the evidence: PASS | todo | — |

---

## 3. Acceptance conditions

### C00

Translated verbatim from plan Section 9, C00, "Kabul". The conditions were fixed in plan 2.1 (29 September 2026), and the Turkish text is binding. This copy was entered on 2026-10-01, after the observations in L-002 and L-003, which bear on conditions 4 and 5. Those observations did not change the conditions.

Legend, as in the plan (Section 8.2): ✔ marks a condition that must be shown; ✘ marks something that must not happen. Neither mark is a result.

- ✔ The translation fidelity review has passed; changes proposed during translation are recorded separately.
- ✔ Every item of the preparation list is verified with evidence.
- ✔ The ECC table, the independent review, the counter-design comparison and the premise inventory are recorded; the disposition of every finding is written.
- ✘ The builder wrote nothing to the library repositories.
- ✘ No secret is visible in a repository, an environment variable or the chat.

Criteria served by C00 (plan): 18, 21, 25–27, 29, 34.

---

---

## 4. Decisions and plan changes (index)

| ID | What | Owner | Record |
|---|---|---|---|
| D-001 | C00 heavy work waits for the weekly usage reset; light work now | Batu (answered) | C00-log L-007 |
| PC-01 | Installation rhythm: each stage under a `/goal` target with three stop conditions. **[Batu, 2026-10-01]:** use `/goal`; the three stop conditions. Builder: a met goal is not acceptance. Superseded in part by PC-04 (Batu no longer types `/goal`). | Batu + builder | C00-log L-004 (filed as "K10" before renumbering) |
| PC-02 | Branch management. **[Batu, 2026-10-01]:** the builder creates, merges and deletes branches; Batu gives no merge approvals. Builder: PR-only into `main`; never touch library repositories; log every merge. | Batu + builder | C00-log L-011, L-013 (filed as "K11") |
| PC-03 | Continuity: merge into `main` before every stop | builder (after Batu's concern) | C00-log L-014 |
| PC-04 | Builder operating model for the installation period (`plan/Builder_Operating_Model.md`) | builder; **[Batu, 2026-10-01]**: the requirement and expectations 1–5 | C00-log L-015 onward |
| D-003 | Residual risk: the connector barrier is a hook the builder can edit; it stops accidents and injection, not deliberate bypass. Accept for installation, or make an account-level change. The brief to Batu must list the routes he would accept: the operating model §9 "Not protected" list. | Batu (to be asked in the issue batch) | C00-log L-019 |
| PC-05 | Technical approval of high-impact changes moves from Batu to independent review. Places: plan 4 K-11 item 7, 5.5, 5.6 (İhtiyaç and Seçim), 6.1, 6.7 (two), 6.8 item 5, 6.9, 7.4, C01 row 11; Appendix A DR12 and §6 step 7; Appendix C K11; Appendix E §8. **[Batu, 2026-10-01]**, expectation 2. | Batu | C00-log L-015, L-016 |

---

## 5. Open items

| ID | Item | Builder's position and where it is resolved |
|---|---|---|
| OI-001 | It is untested whether the session enforces `access: "read"` for `agentic-os-search`, either through the git proxy or through the GitHub tools. The session's permission classifier denied a preparatory command for a git-proxy probe, and no safe probe exists for the GitHub tools. | **Technical position:** a probe is not needed now. The plan's protection model does not rely on session-level enforcement (plan Section 0.5 accepts technical write access). The repository is already treated as writable, and a real write test is ruled out. A git-proxy probe would cover only one of the channels. Revisit this together with the effect-channel inventory (plan Section 0.3, item 13) and C01 row 12. No decision from Batu is requested. |
| OI-002 | Safeguard 2 of plan Section 0.5 (independent monitoring of machine-account commits in the library) is probably not in place. | See G-001. The technical response is the builder's to decide in the C00 gap list. |
| OI-003 | Environment variables named `GH_TOKEN` and `GITHUB_TOKEN` exist in the builder session (EV-C00-001, row 8). Whether they are usable credentials, and with what scope, is unknown. | The C00 key inventory (plan Section 12: owner, location, scope and revocation path, never values). C00 step 1, against the preparation item "GitHub erişim anahtarının silinmesi" (deleting the GitHub access key). C00 condition 5. C03 test (3). The effect-channel inventory (plan Section 0.3, item 13). |
| OI-004 | The session's local git commit identity is `Claude <noreply@anthropic.com>`, not the machine account (EV-C00-001, row 8). Plan C01 row 11 expects the system's commits to appear under the machine account. | C00 step 1 (B3 check); C01 row 11 |
| OI-005 | Which credential the session's git proxy uses (machine account or Claude GitHub App installation) is unknown. This decides whether safeguard 3 closes the session's git path. | C01 row 12; the effect-channel inventory |
| OI-006 | EV-C00-001 has no raw-evidence reference (plan Section 8.9; Appendix B, `EvidenceEnvelope`). | Re-observe and store the raw output when the raw-evidence store exists (C02). Until then, EV-C00-001 is context only and cannot close a condition. |
| OI-007 | FND-001 needs a class-level regression test (plan Section 6.11; Appendix C, C0). **Examples:** (a) this case; (b) "the builder's Supabase connection is read-only", asserted from the connector's name. **Negative control:** an access statement without an enforcement layer and verification status is rejected. **Positive control:** a correctly labelled statement passes. **Break test:** remove the requirement, and the negative example must then pass. | Structural part (a format gate on effect-channel inventory records): C02/C03. Behavioural part (the DR10 hidden exam, prepared by the exam environment): C05. |
| ~~OI-008~~ (closed, L-009/L-010) | Preparation items not visible from the builder session: `devos-backup` exists; extra usage is off; phone apps are set up; the GitHub access key was deleted (EV-C00-002, items 4, 13, 14, 16). | Sent to Batu on 2026-10-01 after D-001 was answered, together with G-010 (whether the preparation plan H0–H10 has items beyond Section 12); both are preparation verification, so one topic. Needed for C00 acceptance condition 2. |

Gaps: see EV-C00-003 (G-001 to G-015). Findings: FND-001 in `plan/ledger/C00-log.md`.
