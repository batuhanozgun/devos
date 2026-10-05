# Evaluation of the ChatGPT review and the 2.1 revision list

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*

**Date:** 29 September 2026 · **Reviewed:** Installation plan 2.0 and Appendices A–G · **Reviewer:** ChatGPT (source fidelity) · **Evaluator:** The session that wrote the plan

**Method:** The same as for the Claude review: weighed with the warning about a tendency to defend (Appendix D, D2); the overlapping findings of the two reviews were merged.

**Summary:** 23 findings. 20 accepts, 3 partial accepts, 0 rejects. ChatGPT openly wrote down its own bias risk (#1, #2, #6, #7: the risk of defending the old controller design). I read these findings not as "bring back the old component" but as "behaviour that must be preserved"; all of them can be met on the chosen platform.

---

## Finding-by-finding evaluation

| # | Decision | Rationale and the change to be made |
|---|---|---|
| 1 | **Accept (critical)** — merged with Claude #4 and #5 | The identity chain was missing. Design: (a) the environment token gives the role class (the mechanism in Claude #4); (b) **claim token:** the `claim` operation produces a one-time secret value returned only to that session; the database stores only its hash; every effect made under that claim requires this value. Another session in the same environment cannot act with someone else's claim. (c) The session ID stays declaration-based and is labelled as such. Testing: call attempts with another session's claim and with a fake session ID. |
| 2 | **Accept (critical)** | Recovery only cut off access to the new database; the old routines' and sessions' path of effect to GitHub stayed open. To the recovery steps: stopping the old routines, revoking the old environment tokens, the release check reading the current authority epoch in the new project. Acceptance test: with the old system left reachable, an attempt to affect `main` is rejected, and the new work succeeds. |
| 3 | **Accept** — merged with Claude #7 | "At most one hour lost" was an undemonstrated claim. A contract for rebuilding from events, a separate backup of the bodies in the file storage, and monitoring of transfer success will be designed. Until it is demonstrated, it will be written as a "target". |
| 4 | **Accept (critical)** — merged with Claude #2 | Batu's decision K6 (b): `devos` stays public. So the check is moved to before the first public write: a check that runs inside the session before every `git push`, PR and issue write, and rests on code, not on the model's judgement (a Claude Code hook + git's own pre-push hook). The remaining gap will be written down honestly: because the check runs inside the session, a determined agent can get around it. This remaining risk has been accepted by Batu's decision K6. C03 #7 will be run with fake "secret" text. |
| 5 | **Partial accept** | Correct: content derived from a private source is not automatically publishable. But a separate publication decision for every document would be heavy bureaucracy; Batu also said that there is no personal data in the work (K7). Rule: the public repository may contain DevOS's own synthesis and source IDs; verbatim or close-in-meaning transfer from a private source is forbidden; transfer from Batu's private conversations is forbidden. Raw evidence and the parts of the installation ledger that may carry private content are kept not in the public repository but in the database and the private file storage; only a safe summary and the ID go into the public repository. |
| 6 | **Accept** | The uncertain outcome of starting a routine had not been designed; the routine API offers no idempotency key. A start intent, the observed session ID, an uncertain state and a reconciliation record will be added. Given the limit of 15 runs a day, this is part of the capacity design (A1 below). |
| 7 | **Accept** — merged with Claude #27 | A successful PR check does not guarantee the authority at the moment of merge. Design: a release job does the merge and rereads the authority in the database just before merging; the remaining window is measured and written down explicitly. Test: a scenario that puts a permission revocation between the check success and the merge. |
| 8 | **Accept** | In stage B, the path for reading the full body of a source was undefined. A function that reads a body by version and range will be added to `devos_api` (with a confidentiality check). The archive may also be read for auditing adaptation fidelity; not as instructions to apply. |
| 9 | **Accept** | The original P4 §21.11 counterexample (the check working correctly while its own mandatory requirement definition is incomplete) had been lost. The approval test in K11 is kept; the original counterexample is added as well. |
| 10 | **Accept** | The structural part of F02 (database) and its qualifier interpretation part (semantic) will be labelled as separate evidence layers; the first one passing will not close the second. |
| 11 | **Accept** | The basis set of a verdict (source, decision and policy versions) and the verdict going stale when these change will be added to the data model. |
| 12 | **Accept** | A common evidence envelope: commit, configuration, criterion version, input, observation and raw evidence ID together. A "passed" record at a different version cannot close a new installation. |
| 13 | **Accept** — merged with Claude #12 | C07 criterion 1 will change: in a controlled exam, finding the hidden gap is mandatory; in a real task, "found no gap" is not a failure on its own. Batu's purpose and acceptance assessment and the technical verification will be recorded separately. |
| 14 | **Accept** | In the search benchmark, the tuning questions and the final acceptance questions will be separated; a final evaluation set unaffected by the selection will be used. |
| 15 | **Accept** | The "always two alternatives" quota was a wrong carry-over. What is mandatory is the **research** into alternatives; if after the research only one feasible path remains, a justified exception; if the option space is not yet known, an open exploration state. This does not reduce effort depth. |
| 16 | **Accept** | A capability gap **candidate** can be recorded from a single event; it becomes definite through reproduction, causal separation and a counterexample, not through the number of events. |
| 17 | **Accept** | The trigger timing had been narrowed. Fix: at the start of every new request, work item or round, and after every material change, **all** nine questions are evaluated before the main work; if a required discipline file cannot be accessed, the affected work stops. |
| 18 | **Accept** | Audit trail: the complete result of the nine questions (loaded / skipped and why), the discipline version, and the work and round ID are written to the database; how the checker will access them is specified. It is not shown to Batu. |
| 19 | **Accept** | It is stated that some built-in helper agents do not load `CLAUDE.md`. All carriers will be tested in C01 and C05; a carrier that does not receive the common discipline will not be given role work, or the text will be given to it explicitly. (The claim will be verified in C01.) |
| 20 | **Accept** | For the continuation of a bounded relation query, binding to the same snapshot or an explicit restart will be defined. |
| 21 | **Accept** | Source type, the epistemic status of the statement and today's authority to act will be three separate fields. An old real observation will not turn into "an idea only" because it sits in a historical document. |
| 22 | **Accept** | Acceptance conditions for transferring the installation ledger to the database: idempotency, continuing after an interruption, link and version parity, the old ledger ceasing to be a write surface. |
| 23 | **Accept** | The DR12 difference in Appendix A was presented wrongly; the source already defined it mechanically. It will be corrected. |
| Appendix D overall verdict | Noted | The content of the nine disciplines was found faithful; what is missing is the activation scheme and the audit trail (#17–19). |
| Appendix A three limits | Noted | Found faithful; the note "a short summary is not a ceiling" will be kept. |

**Partial accepts:** #5 (a rule consistent with decisions K6 and K7, without turning into bureaucracy), and the presence of a claim to be verified in #4 and #19. (#4 partly: because Batu made the public repository decision, the root solution is not applied.)

---

## The two reviews together: the 2.1 revision list

### A. To be redesigned (no solution found yet)

| # | Topic | Source findings | Status |
|---|---|---|---|
| A1 | **Wake-up and capacity architecture:** flow without Batu with 15 routine runs a day; the number of environments; the uncertain outcome of a start; the limits shared with Batu's own Claude usage | Claude #3, #5, #6, #17, #20; ChatGPT #6 | Research first: Claude Code Projects, messaging between sessions, a long-lived session, one-shot scheduled runs that are reported not to count toward the limit, GitHub Actions, extra usage. The options will come to Batu with their costs |
| A2 | **Identity chain:** environment token + claim token | Claude #4, #5; ChatGPT #1 | Design above; to be written in 2.1 |
| A3 | **Exam execution path:** a separate exam environment and role | Claude #6 | Together with A1's number of environments |
| A4 | **Backup and recovery:** excluding reproducible data, body backup, rebuilding from events, closing the old paths, reconnection, Actions minutes budget | Claude #7, #14, #15; ChatGPT #2, #3 | Design in 2.1 |
| A5 | **Check before the first write to the public repository** | Claude #2; ChatGPT #4, #5 | Design in 2.1; the remaining risk was accepted with K6 |

### B. To be corrected (design known)

Removing the connectors from routines and environments, and the effect channel inventory (Claude #1); notification and backup channel (Claude #11); bringing Batu's approvals down to the purpose level (Claude #12, ChatGPT #13); the format gate label (Claude #13); completing the API table (Claude #18); second-model gateway (Claude #19); tying role activation to need (Claude #21); acceptance conditions for criteria 2, 3, 13, 18, 20, 24 (Claude #9, #22, #23); memory measurement (Claude #24); label corrections (Claude #25, #26); key inventory (Claude #28); internal contradictions (Claude #29, heading note); the authority window between the PR and the merge (Claude #27, ChatGPT #7); body-reading function (ChatGPT #8); the P4 §21.11 counterexample (ChatGPT #9); F02 layers (ChatGPT #10); verdict basis (ChatGPT #11); evidence envelope (ChatGPT #12); final evaluation set in the search benchmark (ChatGPT #14); the rule of research into alternatives (ChatGPT #15); capability gap candidate (ChatGPT #16); discipline trigger and audit trail (ChatGPT #17, #18); carrier testing (ChatGPT #19); query continuation (ChatGPT #20); the status triple (ChatGPT #21); ledger transfer (ChatGPT #22); DR12 correction (ChatGPT #23); model access layer (Claude #10); self-disabling routine and independent monitoring (Claude #16).

### C. New principles

1. **Current platform reading:** Every platform behaviour the plan relies on is read from the current version of the official documentation, with its date.
2. **Effect channel inventory:** Every channel through which the agent can produce effects, in a single list; for each one, a limit and a negative test.

### D. Batu's decisions (given in this round) (original: TR-A1)

- **K6 = (b):** `devos` stays public. Record: the risk of private research content being exposed by accident was accepted in the form reduced by code-based pre-checks.
- **K7 = (a):** The "only fake data" rule covers personal and business data; DevOS's own research library can be used in measurements. Batu: there is no personal data in the work.

---

## Turkish originals of Batu's decisions

**TR-A1** · Section "D. Batu's decisions (given in this round)": the heading and its two list items · 
> ### D. Batu kararları (bu turda verildi)
>
> - **K6 = (b):** `devos` açık kalır. Kayıt: özel araştırma içeriğinin kazara açığa çıkma riski, koda dayalı ön kontrollerle azaltılmış haliyle kabul edildi.
> - **K7 = (a):** "Yalnız sahte veri" kuralı kişisel ve iş verisini kapsar; DevOS'un kendi araştırma kütüphanesi ölçümlerde kullanılabilir. Batu: çalışmada kişisel veri yok.
