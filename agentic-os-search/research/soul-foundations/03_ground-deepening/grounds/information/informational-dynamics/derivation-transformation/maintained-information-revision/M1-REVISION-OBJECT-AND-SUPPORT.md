# M1 — Revision object, change targets and support

**Date:** 2026-09-13. **Standing:** bounded analysis; structure compared in M3.

## 1. What is being maintained?

The object is a continuing informational focus: a body of assertions, a working interpretation, a maintained account of an event, a set of live hypotheses, or a designation of what may currently be relied upon for a specified purpose. Continuity does not require unchanged bytes, permanent storage or a human-like mental state. The investigation relates a prior state, an admitted change basis and a successor state while preserving the distinctions needed to understand that relation.

A new source message is not automatically an instruction to believe its proposition. Faithfully recording that a person reported P, accepting P as a factual premise, accepting a user's authoritative decision about project status, and installing a resulting maintained state are different acts. Authority may settle a designation without settling world truth. Conversely, a well-supported factual correction does not grant its author every permission to rewrite a managed corpus. Formation, Warrant, Actors and Control retain those separate questions.

Retaining a claim can be an appropriate response to new information. No-op content does not prove that no reconsideration occurred, nor prove that it did. A changed plausibility or support structure may leave the currently stated conclusion unchanged. The target must identify what state is claimed to have changed: payload, asserted commitments, support, alternatives, scope, or reliance designation.

## 2. Three withdrawal targets that must not collapse

A source-level removal asks whether one assertion occurrence or support route remains admitted. A proposition-level contraction asks for a successor in which a particular proposition is no longer derivable under the declared semantics. Revision by its negation asks for a different successor that accepts the contrary claim, subject to its own basis. These are semantic profiles, not proposed children or universal implementation operations.

C02 has a direct assertion q and an independent input a with a retained rule a→q. Removing the direct q assertion leaves q derivable. Removing the remaining positive basis eliminates that derivation, but does not derive not-q. A direct-delete operation could therefore satisfy the source-removal request and fail the proposition-removal request. Whether the rule itself should change is another explicit part of the contract; the fixture holds it fixed.

This refines, rather than rediscovering, Warrant's undercutting-versus-rebuttal distinction. Warrant can assess that a route no longer supports the claim. Revision must additionally identify the intended maintained-state effect and its complete relevant support paths. A bibliography of source names is insufficient when supports are joint, alternative, contextual or themselves withdrawn. The distinction does not require a specific provenance database.

## 3. Prevent derived conclusions from becoming their own new ground

Under least-fixed-point positive Horn semantics, a→b and b→a have no consequence without a seed. C03 first derives both from a, then withdraws the seed. Recomputing from admitted premises produces an empty closure. Reusing an old derived b as an unquestioned new premise regenerates a and preserves the obsolete pair.

The failure is not simply a stale text string. A distinction between admitted basis and derived consequence has been lost. Deleting only the displayed original assertion cannot repair that path if its old consequence has already become an independent premise. The appropriate scope of reconsideration follows support semantics, not merely which file was edited. This is not a blanket prohibition on recursion, mutual constraints or justified fixed points.

Reiter/de Kleer's consistency-based maintenance account [S1] supplies a separate formal tradition for assumption-qualified support and explicit consistency. Its guarantees are relative to clauses actually supplied to the maintenance component. We do not implement that general system or assume that an operational agent exposes all of its supports. If the support set is incomplete, the completeness of a revision cannot be certified merely by traversing the known edges.

## 4. Current answers can omit revision-relevant state

C01 constructs two states with the same current preferred world and different orderings of less-preferred alternatives. Applying the same revision operator to the same new input gives different next beliefs. Thus current-belief equality is too weak for a claim of equal future revision behavior.

C12 re-performs a published example [S2]: two operators agree on the current answer after one input and disagree after another. The example's expected results are external to our test authoring, but selecting and coding the example remain our work. It does not verify all iterated revision postulates.

A useful distinction is therefore between an answer-preserving summary of a state and a revision-preserving representation of it. Given a declared transition U, observable beliefs B and permitted future input sequences σ, states e and e' are behaviorally indistinguishable only when B(U*(e,σ)) = B(U*(e',σ)) for every such σ. Equality at the empty sequence establishes only current agreement. This is a bounded restatement of the behavioral perspective in [S2], not new mathematics, a computable universal test, or a requirement to store all possible worlds.

The practical issue is what additional basis, priorities or alternatives the intended future revisions need. Keeping the entire chronological conversation is neither automatically necessary nor sufficient: a compact adequate state can suffice, while a long history with missing interpretation or authority can still fail. Historical accountability and future revision behavior are distinct preservation purposes.

## 5. Alternatives may need to coexist without being jointly asserted

C11 admits context {a}, which supports p, and context {b}, which supports not-p, while excluding their combination. Each context is coherent; merging all its conclusions into an unconditional set creates a contradiction. Preserving alternatives is not a defective attempt at consensus. An explicit adjudication may later select an alternative, but simply concatenating the records does not perform that adjudication.

The same issue can arise in branch-specific or actor-perspective records. Before treating two states as contradictory, align referent, interval, modality and context using the accepted State result. Separate contexts are not an excuse to ignore a genuine conflict within one required scope. A revision can properly leave the result unresolved when its basis does not select a single successor.

## 6. Scope of the common object

A qualified old-to-new relation retains the continuing focus; prior state; change trigger and target; admitted evidence or authority; support and compatibility conditions; applicable selection/retention rule; resulting state; time and realization scope; and evidence of the transition. These are conditional semantic questions, not mandatory fields. M3 tests whether this common relation hides an independent research region. No leaf is justified merely by making the checklist long enough.
