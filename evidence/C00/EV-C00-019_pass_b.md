# EV-C00-019 · W-C00-08 pass B: the plan reviewed against the research library

**What this is.** The record of pass B of the independent plan review (plan C00 task 4: a fresh-context checker that has not seen the plan author's reasons "criticises the plan only against the criteria and the sources; scans the Foundation and the candidate studies; checks whether a path that was tried before and failed is being proposed again"). Pass A (criteria traceability, CHK-C00-022; premises and frame, CHK-C00-023) ran on 2026-10-05 without the library; pass B waited for it (N-061) and for the interim leak check (W-C00-14). The findings of both passes get their dispositions at W-C00-10 round 2.

## 1. Inputs and independence

- **Plan:** the binding English plan package at `main` = `4d569155e7e71493a890a83a06319a6b482dc2b5` (first workflow) and `31074d11e1b315d45171e67d9a3c3a912f7ff00f` (follow-up); the plan files are the same at both.
- **Library:** `/home/user/agentic-os-search` at `941f027d3a15497b90e60d752303c0463a9feab5`, read-only, attached 2026-10-06 (D-014, L-155).
- **Reviewers:** fresh-context `checker` subagents in workflows of the working session, each told to read only the plan package and its lens of the library, and not the plan author's reasons or the builder's records (the rationale documents, `plan/work`, the ledger, the decisions, evidence, briefs, the working order); each lens says at its end whether it kept that rule (all seven say they did; the critic was told the same and does not say). Independence: "same session, fresh-context subagent (declared, Ek A 5.3)"; one model family (U-3).
- **Public output:** each verdict is a public write drawn on the library, so each was told to quote no library text and to cite sources by path and section; the guard's L1 checks every push.

## 2. The verdicts

| Verdict | Lens | Library read | Verdict | Conditions |
|---|---|---|---|---|
| CHK-C00-046 | B1 Foundation | research/soul-foundations (review layers, state files, verticals where a plan choice depends on them), research/soul-context | PASS-WITH-CONDITIONS | 7 |
| CHK-C00-047 | B2 candidate studies | research/studies (all but ECC), concepts/studies | PASS-WITH-CONDITIONS | 5 |
| CHK-C00-048 | B3 paths tried before | development-os/attempts, explorations EXP-001 to EXP-006, the pre-Claude archive, the separation maintenance, concepts | PASS-WITH-CONDITIONS | 3 |
| CHK-C00-051 | coverage critic over B1 to B3 and N-060 | (what none of them read) | PASS-WITH-CONDITIONS | 2: no library heading in B1; the unread areas read, or listed with a stage |
| CHK-C00-053 | B4 Appendix D and its source | agent/protocols, AGENT.md (as data) | PASS-WITH-CONDITIONS | 5 |
| CHK-C00-054 | B5 earlier working-system drafts | EXP-004 artifacts, EXP-002 and EXP-003 consolidations, the Academy concept | PASS-WITH-CONDITIONS | 6 |
| CHK-C00-055 | B6 scheduled work, continuity, composition | hermes-agent continuity files, Foundation composition and grounds, soul-context reviews | PASS-WITH-CONDITIONS | 5 |
| CHK-C00-056 | B7 search, delivery, capacity | representation and knowledge-strategy studies, gstack, superpowers, gastown, ECC notes, flowable, openproject | PASS-WITH-CONDITIONS | 7 |
| `pass_b/N-060_ecc_study.md` | N-060: the library's ECC study against EV-C00-011 (researcher) | research/studies/ecc | (not a verdict) | 30 points |

Each verdict ends with a "Coverage" section: what it read in full, skimmed and did not open. The critic's condition 2 was met by route (a): the follow-up lenses B4 to B7 read the areas it listed (its items 1 to 9, and of item 10 the two studies on reopening and cancellation) against the plan sections it named. Left for C04, as the plan says: the old experiment repositories (C00 task 4, second sentence). Archives inside the library (a ZIP of the pre-Claude transfer) were read only where a member could be listed; B3 says which.

## 3. The redaction before filing

The raw outputs could not be published as written: the fingerprint scan found lines matching 8-word runs of the library in all of them (library paths and section headings cited word for word, a few phrases), and the critic found headings quoted in B1. So each output was filed in redacted form:
1. A producer subagent per output rewrote only what had to change (paths shortened with keys, headings replaced by section numbers or locators of its own, echoing phrases restated), looping on `tools/leak_fingerprints.py scan` until it printed 0 lines, and listed every change (`evidence/C00/pass_b/redaction/<key>.changes.md`).
2. A fresh checker judged each redacted copy against its original: same claims, places, types, conditions and evidence; sources still identifiable; nothing dropped or added; scan clean; no library heading word for word at any length. **CHK-C00-052: FAIL** (B1 and B2 still quoted headings shorter than the scan sees; the critic's copy had an unlisted newline); B3 and N-060 passed. A second round fixed them; **CHK-C00-058: PASS-WITH-CONDITIONS** (one heading left in each of B1 and B2), its two conditions met by the executor; **CHK-C00-057** (the follow-up lenses B4 to B7): PASS-WITH-CONDITIONS, its one condition (a heading in B6) met by the executor. CHK-C00-057's own text was redacted in two lines (library paths) before filing.
3. The originals of B4 to B7 that the producers redacted were their copies of the reviewers' outputs; they were compared with the workflow's own record of each output and differ only by a final newline.
4. Each filed verdict carries a comment after its front matter that says it is a redacted copy. The unredacted originals stay container-local, unpublished.

Method notes: two subagents probed which words matched by importing the guard's normalisation in their own scripts (the B2 producer and the history-scan classifier); they printed only their own text or nothing, not library text, and neither result is published. The tool `tools/subagent_audit.py` does not reach workflow agents' transcripts; the outputs were taken from the workflows' results.

## 4. What follows

- **W-C00-10 round 2:** every finding and condition of CHK-C00-046 to CHK-C00-048, CHK-C00-051, CHK-C00-053 to CHK-C00-056 and every point of the N-060 output gets a disposition (a plan change, new work, a stage note, Batu, or no change with the reason), as round 1 did (EV-C00-014).
- **W-C00-08** is accepted after those dispositions exist (its acceptance: "each gets a disposition").
- **C04:** the same question for the old experiment repositories, added to the C00 record, as plan C00 task 4 says.

## Addendum 2026-10-06: CR-C2 by route (b) for the remainders (EV-C00-021, T-58; L-159)

W-C00-10 round 2 decided this (`evidence/C00/EV-C00-021_w10_round2_dispositions.md`, row T-58; with CHK-C00-059 condition 4 and CHK-C00-060 condition 6). The register items are in `evidence/C00/EV-C00-020_w10_round2_register.md`.

Section 2 says the critic's condition 2 (item CR-C2) was met by route (a), with its items 1 to 9 read. That overstates. Route (a) is a read of areas 1 to 5 of the critic's section A against the plan sections of its section B. The follow-up lenses B4 to B7 read areas 1, 2, 4, 6, 7 and 9, and the plan sections they named. They read areas 3, 5, 8 and 10 only in part, and no lens named four plan places of section B. So route (a) holds only in part. Route (b) applies to the remainders. Each remainder below is not checked. Its row names the stage before which it is checked and how it stays readable once the machine account's library access ends. Section 2 is left as written; this addendum is what the record now says.

| Remainder (register item) | Why it is not checked | Checked against | Before | Readable after the access ends |
|---|---|---|---|---|
| Area 3: the archived guides, members of the archive's ZIP file (CR-FA3) | B4 and B5 did not open the ZIP under their rules; B5 read the Academy note only | Appendix A's role contracts and its sections 3.3–3.4, 5 and 8; K-4 | C05 | C04's ingested copy; task 1 ingests the archive's members |
| Area 5: the Foundation's environment findings and information sub-packages (CR-FA5) | Not opened; B6 read the syntheses | 6.6; K-6; K-8 items 1–2; Section 5's environment premises | C04 closes | C04's ingested copy |
| Area 8: six earlier reviews (CR-FA8) | Seen by banner only | The plan sections of register row CR-FA8 | C06 | C04's ingested copy |
| Area 10: the maintenance inventories (CR-FA10) | Not read | C04's ingestion scope and 6.6 (with T-66) | C04 task 1 | Checked while direct access holds |
| Area 10: the writing guide (CR-FA10) | Not read | Appendix E beyond its section 3 | C06 | C04's ingested copy |
| Plan 5.5 (CR-FB12) | No lens named it | The ingested library | C06 | C04's ingested copy |
| Plan 5.7 items 4–5: the storage budget and the restore drill (CR-FB4) | No lens checked them; B6 and B7 checked items 1 to 3 | The ingested library | C04 task 6, where the backup size and budget are calculated | C04's ingested copy |
| Appendix E beyond its section 3 (CR-FB12) | B4 and B5 named its section 3 only | The ingested library, with the writing guide | C06 | C04's ingested copy |
| Plan Section 13 (CR-FB12) | No lens named it | The ingested library | C11 | C04's ingested copy |

**How they stay readable.** The machine account's library access is removed in C04, after ingestion (plan 0.5; Section 12 item 2). The maintenance inventories are checked before C04 task 1, while direct access holds. Every other remainder is checked against C04's ingested copy. The C04 note has task 1 ingest every file these checks read, the archive's members included, and the ingestion's verification confirms them before the access is removed. Appendix D's sources take the same route (T-70). The stage notes carry the checks: N-094 (C04), N-095 (C05), N-096 (C06) and N-100 (C11).

**No check needed.** The concept studies of area 10: B2-F8 (f) found plan 0.7 unchanged. Area 10's two studies on reopening, cancellation and compensation were read by B7.

**Process.** This addendum is made before W-C00-08 is accepted; W-C00-08 is accepted after it and EV-C00-021 (that record's section 6). The old experiment repositories stay for C04, as section 4 says.

## Addendum 2026-10-06: the coverage critic's level (CHK-C00-065 finding 7; CHK-C00-069 finding 7; L-161, L-162)

Section 1 says that the critic was told not to read the builder's records, the working order among them, and does not say whether it kept that rule. Its verdict (`evidence/C00/checks/CHK-C00-051.md`, line 119) cites `plan/Installation_Working_Order.md` by line, so it read the working order, and its stated level is narrowed: it was not blind to the working order. The citation concerns the leak check's 8-word length, and the critic was a coverage critic, not a plan lens. Section 1 is left as written; this addendum is what the record now says.
