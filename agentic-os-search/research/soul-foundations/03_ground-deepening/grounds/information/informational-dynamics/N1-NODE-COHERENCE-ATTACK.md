# Informational Dynamics / Formation–Transformation — N1 Node Coherence Attack

**Status:** COMPLETE  
**Date:** 2026-09-05  
**Dependency:** `N0-CANONICAL-RECOVERY.md`

## 1. Question

Does `Informational Dynamics / Formation–Transformation` identify one coherent Foundation problem region, or is it only a residual bucket for every process that happens near information?

The node label, scope and level are treated as hypotheses.

## 2. Merge attack — collapse Dynamics into Informational State

Rival:

> A process can be represented by provenance/history attributes on the resulting State; therefore a separate Dynamics node is unnecessary.

Counterexamples:

- a biased acquisition process and a sound acquisition process can produce identically shaped results;
- two derivation paths can produce the same output value with different validity/reproducibility implications;
- a source corpus can remain unchanged while retrieval/context assembly changes what becomes visible;
- a claim's text can remain unchanged while a correction/retraction/supersession transition changes its standing;
- a message can exist unchanged before and after delivery while exposure/receipt changes.

Attaching `source`, `updatedAt` or lineage metadata to outputs does not recover all transition semantics or process failure modes.

**Verdict:** merge rejected. Dynamics remains distinct from State.

## 3. Reduction attack — collapse Dynamics into Work

Rival:

> Acquisition, inference, revision, selection and communication are activities, so they are Work.

Counter-test:

Work asks about pursuit/commitment/execution/evaluation of a protected objective. Dynamics asks what informational transition occurred and with what semantic effect.

Examples:

- an automated sensor may form a result without a Work item being the useful unit of analysis;
- a database query can derive a view regardless of whether the surrounding user activity is modeled as Work;
- a human review is Work, but the correction/retraction it causes has information-change semantics that survive beyond that Work episode;
- retrieval may be embedded inside Work while still having distinct coverage/selection failure semantics.

**Verdict:** Work may cause/govern Dynamics, but does not replace it.

## 4. Reduction attack — collapse Dynamics into Environment

Rival:

> All information processes are ultimately physical/runtime processes in the Environment.

Counter-test:

Environment owns realized physical/runtime conditions and capabilities. Dynamics owns the mediated informational effect when that distinction matters.

Examples:

- the same network can deliver different messages;
- the same sensor hardware can support sound or biased sampling designs;
- the same database/runtime can execute a faithful or semantically lossy transformation;
- the same repository can store both current and stale views.

**Verdict:** implementation substrate does not exhaust informational transition semantics.

## 5. Reduction attack — collapse Dynamics into Actors

Rival:

> Assertion, communication, revision and publication are Actor behaviors.

Counter-test:

Actor identity, role, authority and obligation remain Actors semantics. Dynamics can model the information change caused by an Actor action without absorbing the Actor.

Examples:

- source identity can stay fixed while the asserted state changes;
- two Actors with the same role can perform transformations of different fidelity;
- a receiver may gain exposure without gaining authority or agreement;
- retraction may change an information item's standing while the authority to retract remains an Actor/control question.

**Verdict:** reduction rejected.

## 6. Residual-bucket attack

Concern:

`Dynamics` could become “anything that happens to information,” too broad to guide later reasoning.

N0 evidence suggests a bounded core:

> **processes/transitions whose focal effect is the formation, derivation, transformation, selection/exposure, revision/invalidation or availability/standing change of informational states.**

Excluded or boundary-routed when focal:

- underlying domain change itself → Environment;
- goal selection/commitment/execution → Work;
- Actor identity/authority/participation → Actors;
- informational result constitution → State;
- persistence-specific preservation/retention obligations → Records specialization.

This boundary is narrow enough to avoid residual absorption but broad enough to include non-content-changing informational transitions.

**Verdict:** node remains coherent.

## 7. Label attack — is `Formation–Transformation` too narrow?

Yes, as literal wording it risks under-signaling:

- selection / retrieval / context assembly;
- communication / exposure / receipt;
- standing / validity / currentness transitions;
- invalidation where content is not rewritten.

Possible alternatives:

- `Informational Dynamics / Formation–Change`;
- `Informational Dynamics / Formation–Transition`;
- `Informational Dynamics / Formation–Transformation–Exposure`.

Problems:

- `Change` is broad but readable;
- `Transition` is structurally stronger but abstract;
- enumerating several verbs makes the label brittle and taxonomy-like.

N1 therefore keeps the accepted parent label for continuity but treats its protected scope as broader than literal content transformation. Rename remains an N6/N7 question, not a prerequisite for research.

## 8. Communication / exposure attack

Could communication be entirely relational and therefore outside Dynamics?

Separation:

- sender/receiver identity and authority → Actors;
- channel/runtime condition → Environment;
- message/content → State;
- encoding/transmission/exposure/receipt process → Dynamics when focal;
- successful semantic understanding/agreement → not implied by delivery.

Thus communication is not automatically an immediate child, but its process side is legitimately inside Dynamics.

## 9. Revision / standing-change attack

Could correction/retraction/supersession be only State metadata changes?

No. A transition has typed semantics that may change:

- which state is designated current;
- whether reliance is withdrawn;
- effective/applicable interval;
- availability;
- lineage/version relation;
- source designation.

However, the Records evidence shows these labels are domain-sensitive and must not be universalized as a ready-made child branch.

**Verdict:** revision/standing change is locally real; child status unresolved.

## 10. Formation vs transformation attack

A tempting split is:

```text
Formation → information appears
Transformation → existing information changes into other information
```

This is useful but incomplete:

- retrieval/exposure can change model-visible information without changing source content;
- copying/communication can instantiate a new state while preserving content;
- assertion can be formation even when it repeats existing content;
- observation can involve transformation from signals/readings into interpreted results;
- derivation may aggregate many states or split one state into many views.

Thus `formation vs transformation` is not yet sufficient as the internal hierarchy.

## 11. Strongest N1 framing

For current research, Dynamics is best treated as the problem of **informational transitions**, where a transition may affect one or more of:

- existence/instantiation;
- content/form;
- identity/version/equivalence;
- selection/visibility/availability;
- applicability/standing;
- provenance/lineage;
- consumer-visible working set.

The transition can be caused by observation, computation, retrieval, communication, revision, persistence operations or another mechanism, but those mechanism names are not automatically children.

## 12. N1 verdict

**Node coherence survives.**

`Informational Dynamics / Formation–Transformation` remains a valid bounded research node, with one label caveat: protected scope must include informational transitions that alter availability/standing/exposure without necessarily rewriting content.

N2 should derive failure/problem families from transition semantics rather than importing a lifecycle or ETL vocabulary.
