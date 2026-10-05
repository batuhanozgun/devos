# EV-C00-008 · Fidelity review of the plan-package translation: verdicts and the disposition of every finding (W-C00-06)

**What this is.** W-C00-06's acceptance condition asks that "every finding gets a disposition". Thirteen fresh-context checker subagents, none of which translated, compared the English text at `5cf796e40d2684a0593e798884dbad750f388db0` with the Turkish source at `3de3a17a9c230a36c600fb918b6dd76086956527`, section by section (independence: "same session, fresh-context subagent (declared, Ek A 373)"). Their verdicts are in `evidence/C00/checks/`. This record gives the executor's disposition of every finding that is not a plain "no finding". The proposals the checkers noticed about the plan itself are in EV-C00-007, not here. Dispositions: **fixed** (the change is in the translation branch after `5cf796e`), **no change** (with the reason), **process** (about the review itself).

## 1. Verdicts

| Verdict | Range | Result |
|---|---|---|
| CHK-C00-007 | plan sections 0–3, TR-A1 to TR-A23 | PASS |
| CHK-C00-008 | plan section 4, TR-B1 | PASS |
| CHK-C00-009 | plan section 5, TR-C1, TR-C2 | PASS-WITH-CONDITIONS (one condition) |
| CHK-C00-010 | plan sections 6–8 | PASS-WITH-CONDITIONS (one condition) |
| CHK-C00-011 | plan section 9, TR-E1 to TR-E3 | PASS |
| CHK-C00-012 | plan sections 10–14, TR-F1 to TR-F3, closing section | PASS |
| CHK-C00-013 | Appendix A sections 1–3, DR01–DR08, TR-A1 | PASS |
| CHK-C00-014 | Appendix A DR09–DR16, sections 5–8, TR-B1 | PASS |
| CHK-C00-015 | Appendix B | PASS |
| CHK-C00-016 | Appendices C, E, F | PASS |
| CHK-C00-017 | Appendix D | PASS |
| CHK-C00-018 | Appendix G, comparative working-order research | PASS |
| CHK-C00-019 | wake-up and capacity research, the two review assessments | PASS |

## 2. Dispositions

Line numbers are those of the final English text, which equal the Turkish source line numbers (conventions revision 3); the verdicts cite the reviewed commit, where they were two higher.

| Finding | Where | Disposition |
|---|---|---|
| CHK-C00-009 F1 (condition) | plan 513, 5.6 Choice | **fixed**: "routine changes" → "ordinary changes" (conventions revision 2 item 5) |
| CHK-C00-010 item 1 (condition) | plan 665, 6.7 leak check | **fixed**: "stops the push" / "sends the push to review" → "stops the write" / "sends the write to review"; "pushing to a branch" kept for "dala gönderim" |
| CHK-C00-007 F1 | plan 179 (criterion 29) and 644 (6.6) | **fixed**: one rendering of "dış kaynak birikimi" in both: "Accumulated knowledge from outside sources" |
| CHK-C00-008 F3 | plan 326, K-6 item 7 | **fixed**: `read_source(source, version, range)` → `read_source(source, revision, span)`, Appendix B's names (conventions revision 2 item 2); that Appendix B itself has two signatures is a proposal (EV-C00-007) |
| CHK-C00-008 F4 | plan 242, K-1 Testing | **fixed**: "(no unnecessary preparation should be produced)" → "(unnecessary preparation must not be produced)", the same modality as "(it must be found)" |
| CHK-C00-011 F5 | plan 888, C04 item 1 | **fixed**: "operational authority" → "authority to act" (as 6.6) |
| CHK-C00-011 F6 | plan 784, PC-06 item 1 | **fixed**: "secret search question set" → "hidden search question set" |
| CHK-C00-011 F7 | plan 915, C06 Tasks | **fixed**: "the routines created by Batu" → "the creation of the routines by Batu" |
| CHK-C00-011 F8 | plan 804, 903, 904, 906 | **fixed**: "initial (role) set" → "starting (role) set" (as 7.4) |
| CHK-C00-012 F6 | plan 1085, section 13 | **fixed**: "scheduled fallback runs" → "a scheduled reserve run" (conventions revision 2 item 5); what mechanism is meant is a proposal |
| CHK-C00-012 F7 | plan, rule before the closing section | **no change**: the rule follows the source's own separation of top-level sections; codified in conventions revision 3 item 2 |
| CHK-C00-013 F6 | Appendix A 33–35, "Koyduğum üç sınır" | **no change**: the three items are the author's own limits, not Batu's expectations (conventions 3.1); the quoted phrases come from ChatGPT's compilation of his conversations, whose expectations are kept as TR-A1 (section 1 table). The same rule as TR-B1: only what the appendix presents as Batu's expectation is a labelled passage |
| CHK-C00-013 F7 | Appendix A 118, DR02 Output | **fixed**: "which version, identity and context need it depends on is visible" → "the version, identity and context need it depends on are visible" |
| CHK-C00-014 F4 | Appendix A 376, section 5 item 5 | **fixed**: "The decision to combine is justified:" → "The decision to combine carries a rationale:" |
| CHK-C00-014 F9 | Appendix A closing section | **no change**: the missing trailing space after the last "·" of the TR-B1 location is cosmetic; the rule is codified (revision 3 item 2) |
| CHK-C00-014 P1 | line citations ("Ek A 373") | **fixed by conventions revision 3 item 1**: the English keeps the Turkish line numbers, so "Ek A 373" again points to section 5 item 3; the general risk is proposal X2 in EV-C00-007 |
| CHK-C00-015 item 5 | Appendix B 159, 3.9 rule | **fixed**: "repeated content and content of low decision value" → "repeated, low-decision-value content" (keeps the source's single category) |
| CHK-C00-016 item 5 | Appendix C 15, 107, 115 | **no change**: "claim" for "iddia" is also the data model's own field name for it (`Review.claim`, `EvidenceEnvelope.claim`, Appendix B 3.11, 3.15), so the test form stays tied to the data model; the context keeps it apart from a work-item claim |
| CHK-C00-016 item 6 | Appendix E closing section | **no change**: see CHK-C00-012 F7 |
| CHK-C00-017 F5 | Appendix D 217, D5 item 5 | **fixed**: "identities" → "identifiers" (as Appendix D 17 and 21) |
| CHK-C00-018 item 4 | Appendix G 45, 80, 87 ("toparlanma") and G6/G9 ("kurtarma") | **no change in the translation**: both render as "recovery", because the source does not say they differ; translators T08 and T12 raised the same question; whether they are two things is a plan question, recorded as a proposal in EV-C00-007 |
| CHK-C00-018 item 5 | Appendix G 38, G3 window 4 | **fixed**: "Repeated events and consumer runs" → "Repeated events and repeated consumer runs" |
| CHK-C00-018 item 6 | Appendix G 13, "yeterlik incelemesi" → "sufficiency review" | **no change**: the checker found the departure from the glossary correct; the sense is noted for a future glossary revision |
| CHK-C00-019 item 8 | conventions section 3 item 3 | **fixed in the conventions** (revision 3 item 3) |
| Process: CHK-C00-008 F7, CHK-C00-011 item 9, CHK-C00-013 F9, CHK-C00-014 F10 | checkers wrote scratch copies of public plan text into the session scratchpad, against their "write nothing" rule | **process**: the copies were outside the repository and unused for the judgement; the executor deleted them and the producers' leftover helper files on 2026-10-05; recorded in L-140. The common checker task text did not say that shell redirection counts as writing; future checker tasks say so |

All other findings in the thirteen verdicts are "no finding" statements (structure, identifiers, numbers, labels, originals byte-identical, obligations kept) and need no disposition.

## 3. After the fixes

The fixes change only the words named above, plus the move of the translation note (conventions revision 3 item 1). A fresh-context checker that did not translate and did not judge the parts verifies the fixes and the item's acceptance condition at the final head (CHK-C00-020).
