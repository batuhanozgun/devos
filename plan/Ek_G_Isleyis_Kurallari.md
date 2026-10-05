# Appendix G — Detailed operating rules

**Version:** 1.0 · **Date:** 29 September 2026 · **Status:** [Proposal]. Applied in the relevant stages; the tests in Appendix C show that the rules work.

**Source:** P4 v4 report §8.4, §9.3, §11.3–11.5, §12, §15, §16, §17, §18.2–18.3, §19; adapted to Claude Code cloud, Supabase and GitHub.

---

## G1. Staleness and renewal of the context package

1. **The cache key** is not the question text alone. It includes: the work and the use type, the target and source revisions, the permission view, the role class and scope, the common rules and the role and method versions, the search index and the embedding model version.
2. **Events that make a package stale:** When any element of the key changes, the package becomes `stale`. Staleness based on time alone is not used; time is an additional upper bound against changes that were not recorded.
3. **Rebuild order:** First the use type is determined; then the mandatory needs and the permissions; then the candidate sources (direct access by identifier, keyword and semantic search, relation neighbours); the candidate set first passes through the authority filter and, after selection, through the sufficiency review. The result is a new package revision, not a prompt that changes silently.
4. **If a source cannot be found**, a gap record is created. Acceptance work that requires completeness stops; discovery to close the gap can begin.
5. **If the budget narrows**, repetitive and low-decision-value content is reduced first. Mandatory counter-evidence and the authority limit are not removed to gain room. If that is not enough, the work is split or the reading is divided into stages.
6. **After session compaction or a restart**, the past conversation is not reduced to the shortest summary; the current purpose, the authority, the open decisions, the expected contributions, the external effects that have taken place and the source access path are rebuilt from the database, and a new package is derived. That the old package was accepted does not mean that it is accepted for a new claim or a new policy.
7. **Visibility limit:** A Claude session also adds its own system instruction, its conversation history and its tool results to the context. So "the package was correct" and "the model saw only this input" are kept apart; if the full input cannot be observed, the independence claim is narrowed accordingly.

## G2. Completeness of relation queries

1. **Two separate services:** `affected_entities` returns, over an authorised snapshot, the affected **unique** records and, for each of them, at least one explanatory path. `explain_paths` runs only when explicitly requested, with a limit on the number of paths and on depth. The day-to-day staleness-marking flow does not use the path-counting query (F04).
2. **Completeness flag:** Every result that reaches a limit carries `complete = false`. An incomplete result is never used to say "no other affected record" or "no obstacle". A partial positive result may start a review; a negative verdict requires a complete result.
3. **Limits are applied inside the query.** Adding only a row limit to the outer query does not count as an execution budget, because the underlying query can still run for the most part.
4. **Authority:** The existence of the root record and the authority to access it are checked; the names or contents of nodes that cannot be seen are not leaked in the result. If the region that cannot be seen limits completeness, this is stated without revealing content. A safe "unknown" is not the same as a wrong "none".
5. **Live change:** No external effect is made directly from a query result; the effect function re-checks the current conditions.
5a. **Continuation:** The continuation of a limited query is bound to the same snapshot (revision, policy, remaining search limit). If the data changes in the meantime, the continuation information becomes invalid and the query explicitly starts again; parts coming from different snapshots are not combined and called "complete".
6. **Looking beyond the relations:** The relation record finds recorded links; it does not find semantic effects that were never recorded. In large product changes, the affected parts are also read separately, alongside the relation query. A missing recorded relation is a maintenance finding, not a verdict of "no semantic relation".

## G3. Release and interruption windows

The change in Git and the record in the database are not a single transaction. Each interruption window is handled separately:

| Window | State | What to do |
|---|---|---|
| 1. Before the intent record | No authorised operation record; candidate content may exist | The candidate content is kept; the work starts again |
| 2. After the intent record, before the PR | The operation exists, the external effect is unknown | First the branch and the PR are looked for on GitHub; if there are none, the work continues |
| 3. After the PR is opened or a merge is attempted, before the result record | **The most dangerous window** | Before any new attempt is made, the real state is read from GitHub (the PR state, the current commit of `main`, the merge commit). The observation is recorded, then a decision is made |
| 4. After the result record, before the consumer | Repeated events and repeated consumer runs | Consumers recognise repeats by the same identifier; they produce no second effect |
| 5. After the consumer, before delivery to the user | Delivery notification | Delivery and use are observed separately |

**Permission withdrawal race:** Mandatory checks do not re-run by themselves at the moment of merge; between the moment a check passed and the merge, the permission or the epoch in the database may change. So the merge is done by the release job in the single queue, which re-reads the current permission and epoch just before merging (plan 6.8). The remaining window (the time between the re-read and the merge on GitHub) is measured and written down; it cannot be brought to zero, because the database and GitHub are not in a single transaction.

**Compensation:** Rolling back is not always a real rollback; published content may already have been seen. Compensation is recorded as a new authorised operation; the history is not deleted.

**Uncertain effect:** If there is no safe way to observe, the system does not guess "it happened" or "it did not happen"; it stops, opens a comprehensive recovery work item, and brings Batu into the process only if it is truly necessary.

## G4. Long and composite products

1. **Composite product snapshot:** It is recorded which part, at which revision, in which order and according to which design intent forms a whole. The design state, the working state and the delivered state are separate; a change in one does not mean that the other has come about.
2. **Two reading modes:** A review that knows the design tests whether the implementation follows the design; a review that reads only the product tests what a reader can see from the product itself. Seeing the design information early can make the reviewer complete in their mind a link that the text does not actually build; so in the second mode the design is not shown. The two verdicts are not reduced to a single score.
3. **Reading pass record:** Which snapshot, which ranges of it, read with which question; the topics left open and the stopping point. An earlier reading is not silently carried over to a new snapshot.
4. **Types of objection:** A reviewer's concern is not directly an order to fix. First its type is determined: a factual or technical defect (requires repair), insufficient sources (requires additional evidence), a difference of preference (requires an authorised decision), a scope conflict (may reopen the higher purpose).
5. **Decision continuity:** If the same preference debate keeps going round without new information, the existing decision is recalled first. A new source or a changed target, on the other hand, is not excluded out of an instinct to protect the old decision.
6. **Holistic acceptance:** Part tests and link checks do not verify the effect of a large product. If the claim requires it, an assessment by an independent reader or a domain expert is needed; if this cannot be done, the claim is limited.

## G5. Reopening, cancellation, reassignment and deadlock

1. When the basis of a decision changes, the affected work items are taken into the **candidate review set**; they are not all automatically counted as wrong or cancelled. The review determines for which use the earlier output is still valid.
2. The late result of a cancelled or expired claim is kept as candidate evidence; it does not mix into the current product.
3. That a cancel command has been sent does not mean that the external effect path has really stopped; this is verified by observation.
4. **On reassignment**, first the authorised result object, the request link and the last dispatch record are checked: if a result has been produced, the work moves on to the consumer's review; if not, a new claim is opened. The same research is not repeated blindly.
5. **Cycles and deadlock:** Where A waits for B, and B waits for a decision that A has not yet produced, it is first established whether this is a real dependency cycle, a request for information or a malformed request. Asking for a limited draft or an explicit assumption instead of a final decision can open the cycle; this change does not make an unauthorised assumption real.

## G6. Recovery sequence

1. **Closing the old paths:** The routines in the old project are stopped; the old environment tokens are revoked; the release job is reconnected so that it reads the current authority from the new project. That the old system remains reachable must not mean that it can produce effects on shared external targets (GitHub); the acceptance test tries this while the old system is still up.
2. **Recovery inventory:** The identifier and schema version of the backup, the Git commits of the product, the list of source and evidence bodies, the current permission and policy, the pending external effects, the open claims and requests. If the inventory does not guarantee a single consistent snapshot, the consistency limit is written down, and it is stated which records are to be reconciled by which read. Reproducible data (vectors, the ingested library) is regenerated from the source commit and the model version.
3. **Reconnection:** The environments, routines, CI and the backup job are connected to the new project's address and to the new tokens (Batu's steps in plan Section 12).
4. **Three outcomes for each active work item:** continue with a new claim for the same purpose; review the candidate result at hand with the new source and authority; cancel, with reasons, work that is no longer valid.
5. **Gradual opening:** First the management and observation paths; then source and policy access and the read-only views; then low-impact discovery and candidate production; release comes last. The current retention policy is applied again before the search and context service is opened.
6. **Success criterion:** The correct purpose, the remaining work, the valid authority, the sources and the real state of external effects are restored; no work can be done with the old authority or from the old system; the right new work can make progress. A system that refuses everything is safe but not adequate.

## G7. Degraded modes

Degradation is not reported as normal operation; it is made visible which guarantees are kept and which are suspended.

| Situation | Continues | Stops | Visibility |
|---|---|---|---|
| Semantic search is unavailable | Keyword and relation search, direct access by identifier | Discoveries that need semantic search are treated as incomplete | A "no semantic search" note in context packages |
| Supabase cannot be reached | The session only tries to write its own local work to a branch as a candidate and to leave its closing note | Claim, state transition, external effect | The session closes; the next scheduled session starts the recovery when access returns |
| The routine limit is used up | The work of open sessions | Starting new sessions | A limit record and a wait visible to Batu |
| A routine's GitHub connection is lost (after 72 hours the routine turns itself off) | The other routines | That routine's sessions | The independent monitoring path checks the time of the last session and opens an issue for Batu; Batu renews the GitHub connection and turns the routine back on |
| GitHub Actions minutes are used up | Sessions | Backup and ingestion jobs | The independent monitoring path checks the time of the last backup and ingestion; options go to Batu with their cost |
| Session duration shorter than expected | Chunked work and structured hand-over | — | Usage report; an additional working session from the reserve budget |
| Silent failure (checks green, work heading in the wrong direction) | Everything | — | Weekly sample audit; if found, a system review and a failure class record |
| The Claude usage allowance is used up | — | All sessions | A recorded wait; when the allowance renews, the next scheduled session continues. This limit is shared with Batu's own Claude usage; its effect is visible in the usage report |
| GitHub cannot be reached | Discovery and candidate work on the database | Release and PRs | Pending operations are recovered in window 2 or 3 |
| The second model is unavailable | Everything | Second opinion | A "second opinion could not be obtained" note on the decisions concerned |

## G8. Method combinations and changing its own rules

1. Two methods that are each useful on their own can be harmful together. For example, one compresses the context and the other turns every claim into a short assurance sentence; together they cause the conditions and the counter-evidence to be lost. The active set of methods and the order in which they are applied are also an object of testing.
2. When a method changes, the exam may have stayed the same and so have become sensitive only to old errors. Exams are refreshed with the new failure classes the change may affect. Fewer findings may not mean fewer errors; the reviewer's growing blindness is assessed separately.
3. DevOS changing one of its own checks or evaluation criteria is not an ordinary product change. It cannot, on its own authority, make a criterion it fails easier and then count the same result as verified under the new criterion. The change may be legitimate; in that case the old result remains exploratory in nature and the new criterion is tested with new evidence. Changes to checks, authority and policy are high-impact changes.

## G9. Capacity and work classes

1. Capacity is not reduced to a single number; discovery latency, production quality, review cost, source access, the release queue and the recovery load affect one another.
2. Work classes have separate acceptance profiles: a short direct query, deep research, review of a large composite product, long production, a high-impact release, recovery.
3. The priority order does not starve normal work by always letting recovery dominate.
3a. **Routine budget:** The limit of 15 runs a day is distributed according to the table in plan Section 6.4; session duration measurement and usage observation change the budget, with reasons. If the budget is going to be exceeded, the working order itself is questioned first (plan 6.12); then the options come to Batu.
3b. **Loop limits:** Every work loop has an upper limit, an effort budget and "no progress" detection; a triggered loop stops and is recorded.
4. **What is measured:** Mechanical (claim conflicts, the stale rebase rate, request turnaround latency, query incompleteness, time spent uncertain in release, rejection of the old authority after recovery) and work value (discovery of material gaps, the rate of unnecessary prerequisites, research contributions consumed, holistic product defects, technical load carried to Batu, regression in method transfer). These are not added up into a single score. Thresholds are written down before measuring.

## G10. Work list hygiene

A setup that is busy with itself produces a growing work list. Maintenance work regularly flags: work items that no longer have a link to any higher purpose, work items that have not progressed for a long time, and work items that serve only other maintenance work. Each flag goes as a decision not to Batu but to the coordination role; a work item that cannot show that it serves the mission is closed with reasons (process limit, plan K-10).

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*
