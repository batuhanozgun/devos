# M2 — Time, revision policy and actual realization

**Date:** 2026-09-13. **Standing:** bounded analysis and native/finite counterexamples.

## 1. Learning about the prior world differs from tracking a changed world

C04 begins with two possibilities: exactly one of a or b held. Learning that a held in that same situation removes the b-only possibility, yielding a and not-b. A different input says an event has now set a true while leaving b unchanged. That produces two possible successor worlds: a/not-b and a/b. The prior exclusivity was a description of the initial state, not an invariant. If an invariant were explicitly imposed, the a/b successor would instead be inadmissible.

The same phrase 'a is true' can therefore require different maintenance depending on whether it corrects an earlier description or reports a state-changing event. A retrospective correction must not manufacture a world transition at the date of correction. Conversely, maintaining an earlier constraint as eternally true can erase a real change.

The classical update/revision distinction is useful pressure, not a mandatory binary tree. Boutilier's event-based account [S3] argues for interaction between explanation, prediction and revision, and challenges universal assumptions behind one update family. A real investigation may discover both that the world changed and that its previous account was mistaken. Our analysis preserves both temporal targets without adopting that paper's full operator or claiming a universal orthogonality theorem.

## 2. 'Change as little as possible' leaves important choices open

Minimality is relative to what is counted, which states are admissible and which information has priority. C05 keeps as many of two old positive literals as possible while respecting not-both. Two repairs tie. Explicit weights favor a or b respectively. The new constraint alone supplies neither preference.

A repair can be minimal in edited characters and excessive in semantic effect, or minimal in lost assertions and inappropriate under a source hierarchy. Logical consistency alone does not establish truth, authorized acceptance or fitness for a Work purpose. The selected preservation/priority rule is part of the revision basis and must not be disguised as a uniquely forced result.

'Latest wins' can be legitimate when the governing domain explicitly defines a current designation that way. It is not a general truth rule. Similarly, automatically rejecting every newer statement is not principled conservatism. Admission, priority and intended revision effect must be evaluated at the actual target.

## 3. Historical record and current account can both be correct at their own scopes

The existing Records research already separates effective/applicable time from system-known/recorded time. The fresh temporal source [S4] supplies a direct check of that distinction; no temporal database is adopted.

C06 actually queries an in-memory SQLite fixture. At known-time15 the recorded account for reference-time15 is ready. At known-time25, a retrospective correction says blocked for the same reference-time15. The original row remains available for the historical query. Both query outputs accurately describe their stipulated record scopes; neither proves what the actual world was.

C07 adds a future-effective version. It is the most recently received record, yet the previous version remains applicable at time15 and the new version applies at35. Reference time, receipt time and applicability are not interchangeable. The fixture uses a shared clock and explicit half-open intervals; real clock ambiguity and unknown boundaries remain untested.

Version lineage is another distinct relation. RFC5829 [S6] permits branching and multiple latest versions under system-defined semantics. A unique current pointer is not universally required. Crossref [S7] illustrates a separate update notice that changes a document's status without making the notice identical to the original. Those documentary examples do not establish a universal retention obligation or prove every retracted proposition false.

## 4. A correct proposal can be wrong to install now

C08 simulates two writers sequentially in actual SQLite. The first reads version1 and forms a proposal. An intervening correction installs version2 with a blocker. Applying the old proposal unconditionally erases the correction; binding it to the observed base version rejects it with zero changed rows. This is real query execution under a stipulated interleaving, not a concurrent process experiment or HTTP test.

RFC9110 [S5] provides an independently specified example of conditional requests designed to avoid lost updates. Our narrower inference is that the applicability of a proposal can depend on the state against which it was constructed. Successful writing of the candidate bytes does not establish that this was the admissible successor of the state actually encountered.

That is not fixed by a universal version check. In C09 the focal object version stays unchanged while a separately required policy changes. The object-only condition passes, while the explicitly declared two-dependency condition fails. The relevant applicability boundary can include source versions, support, scope or current authority beyond the edited object's bytes. We have not established how to discover a complete dependency set for an opaque agent.

Changing the guard repairs one failure path, not all revision failures: it does not validate the new proposition, select a conflict policy, make the operation authorized or ensure consumers receive the new state. These remain separately routed Warrant, Work, Control and Propagation questions.

## 5. Replay and restoration have semantic targets too

C10 executes a duplicate delta twice. Without an operation identity the total changes twice; deduplication by its stipulated identity changes it once. Assigning the same absolute value is already idempotent in that fixture. Replay safety depends on the operation, not merely on a well-formed saved record. No exactly-once external service guarantee is inferred.

Candidate study Note10 supplied a related analytical pressure: historical replay can reproduce an old decision without establishing current authority. Its LangGraph/runtime details were not revalidated or adopted; the local tests do not exercise that framework. Restoring an old informational snapshot also does not undo external effects that happened after it. That boundary is inherited from Propagation, not a new mechanism selected here.

Returning a rejected claim to current status requires a new adequate basis or an explicitly scoped restoration rule; mere re-import of an older copy cannot be counted as new independent evidence. Whether reinstatement is appropriate remains target- and policy-dependent, not universally forbidden.

## 6. What does a successful revision claim cover?

Separate an admissible candidate, its actual installation at a locus, correct reconstruction of historical views, and propagation/exposure to downstream uses. Not every task requires all four, but success at one does not certify the others. A local current-only state can legitimately discard its history when no protected use requires it. A persistent research record generally has different obligations. The relevant question is what this continuing focus must preserve, not which storage fashion it should use.
