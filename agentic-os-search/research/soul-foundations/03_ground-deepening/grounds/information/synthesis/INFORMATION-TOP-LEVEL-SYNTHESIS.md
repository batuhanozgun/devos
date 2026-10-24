# Information / Representation — Top-Level Synthesis

**Status:** bounded synthesis of completed top-level node pass; user-evaluated / accepted  
**Date:** 2026-09-04  
**Scope:** Information top-level research only; not architecture, ontology or implementation

## 0. Why this synthesis exists

The top-level Information pass began from an accepted working hypothesis:

```text
Information / Representation State
    └─ Records / Persistent Information
```

The purpose was not to confirm that shape. The pass attacked:

- whether a distinct Information ground exists at all;
- whether the parent name is coherent;
- whether familiar nouns such as observation, belief, evidence, context and Records are real siblings;
- whether Records is actually an immediate child;
- whether a smaller first-principles structure survives cross-domain challenge.

The final bounded result is a correction, not a restatement of the starting sketch.

---

# 1. Parent result

A coherent first-order research region survives when scoped to:

> **mediated informational access/representation and the semantics/failures of informational states and transformations that can vary independently of the referent, Work or Actor itself.**

This parent should not mean `anything that can be described`.

The accepted current research label is:

> **Information / Representation**

The earlier suffix `State` is dropped because the ground contains both state/result semantics and formation/change dynamics.

The label remains provisional at the level of universal terminology. It is a routing/research label, not a SOUL ontology class.

---

# 2. Core hierarchy result

The accepted current immediate-child structure is:

```text
Information / Representation
    ├─ Informational State / Representational Constitution
    └─ Informational Dynamics / Formation–Transformation
```

## 2.1 Informational State / Representational Constitution

Protected question:

> What informational state/result/representation exists, what is it about, what content/form/identity does it carry, and what makes its interpretation materially distinct from another informational state?

Major problem regions:

- referent/subject/scope binding;
- representational content and interpretation;
- assertion/mode semantics;
- informational identity, granularity and equivalence;
- state-side source/perspective/standing/freshness/conflict/accessibility when material.

Examples:

- measurement result;
- claim/assertion;
- model estimate;
- database/query output;
- selected context view;
- stored or transient informational resource.

The examples are not accepted subtypes.

## 2.2 Informational Dynamics / Formation–Transformation

Protected question:

> How do informational states become available, get generated, selected, transformed, revised, communicated, invalidated or otherwise change?

Major problem regions:

- observation/acquisition;
- derivation/inference/transformation;
- summarisation/aggregation/translation;
- revision/correction/retraction/supersession;
- context/view formation;
- retrieval/exposure/communication;
- conflict handling/merge;
- persistence write/update/forget/disposition operations when activated.

The branch is not equivalent to Work. An informational transformation can be the information-side semantics of a process even when the broader selected/controlled pursuit belongs to Work.

---

# 3. Why the two-child split matters

The split protects a recurring distinction:

> **procedure/process/history ≠ informational result/state**

Examples:

- a measurement procedure may be correct while its result is stale relative to current reality;
- a well-defined result can have missing/incorrect provenance;
- a valid source can be transformed into a misleading summary;
- a belief state can be well-defined while its revision operation is irrational/inconsistent;
- correct persistent storage can preserve a false claim perfectly.

Cross-domain support came from:

- JCGM/BIPM metrology;
- OGC/ISO observation models;
- W3C PROV;
- database provenance;
- belief-revision theory;
- Web Annotation;
- data-quality/stewardship models as contrast cases;
- context-aware computing and situation-awareness models as holdouts.

The convergence is structural, not lexical.

---

# 4. Cross-cutting dimensions — explicit but not children

The pass repeatedly found important dimensions that cut across both immediate children:

- referent/scope;
- source/provenance;
- holder/perspective;
- temporal applicability/freshness;
- uncertainty/confidence;
- epistemic/evidential/authority standing;
- conflict/plurality;
- accessibility/visibility;
- representation form/interpretability;
- persistence horizon;
- derivation lineage.

Why this matters:

A later system can fail because any one of these is wrong, but that does not mean each deserves a universal sibling branch.

For example:

- provenance can describe a state and its generating dynamics;
- freshness qualifies a state but changes through dynamics;
- accessibility depends partly on Actor/policy and Environment;
- evidential status depends on a target claim/question;
- context depends on a use/task/query.

---

# 5. Records correction

The deepest structural correction concerns the prior assumption that Records is an immediate child.

## Prior working sketch

```text
Information / Representation State
    └─ Records / Persistent Information
```

## Current bounded result

> **Records / Persistent Information is better treated as a deep persistence specialization/profile across the Information / Representation ground, not as a universal immediate peer child.**

Persistence activates distinctive obligations because information must survive and remain usable across time/horizon transitions.

Those obligations include:

- identity/version/representation binding;
- preservation closure;
- provenance/history/standing survivability;
- retrieval/reconstruction guarantees;
- retention/transfer/disposition.

But persistent information still has:

- Informational State semantics;
- Informational Dynamics semantics.

Therefore persistence is highly important without forming a clean partition axis at this level.

The existing Records corpus remains valid and reusable; only its **hierarchical role** is refined.

---

# 6. Context result

`Context` is not an Information child.

Strong current formulation:

```text
available / eligible informational states
        ↓ selection / retrieval / ranking / compression
contextual working view/state
        ↓ used relative to
Work / Actor / query / decision / purpose
```

This means context has at least three separable failure surfaces:

1. eligible/source information is wrong or stale;
2. context-formation dynamics select/transform it badly;
3. resulting working view is incomplete/misleading for the current use.

Persistence and memory remain separate from current model-visible context.

---

# 7. Evidence / truth / authority result

These concepts must remain separated:

```text
representation exists
≠ representation is true
≠ representation is evidence for this claim
≠ source is authoritative for this role
≠ evidence is sufficient for this decision
≠ decision is authorised/committed
```

Information can preserve and represent each of these relations/states, but:

- truth refers back to actual reality/model semantics;
- evidential support is target-relative;
- authority belongs partly to Actors/policy/control;
- decision/commitment belongs to Work/Actors.

This boundary is central to preventing SOUL from treating retrieved or persisted content as automatically authoritative knowledge.

---

# 8. Boundary with Environment

Environment owns the actual realised operating/domain condition.

Information owns the mediated representation side when that is focal.

```text
actual condition
    ≠ observation process
    ≠ observation result
    ≠ model/belief
    ≠ forecast
    ≠ persistent record
```

Each can change while others remain fixed.

---

# 9. Boundary with Work

Work owns pursuit/commitment/execution/evaluation semantics.

Information may represent Work:

- planned state;
- status;
- evidence;
- completion assertion;
- decision rationale;
- dashboard/projection.

But changing a representation does not itself change actual Work state unless the Work/control system defines and executes such a relation.

---

# 10. Boundary with Actors

Actors owns:

- bearer identity;
- role/participation;
- capability;
- authority/obligation;
- delegation/accountability.

Information may contain claims/models about these and preserve source/holder relations.

But:

- source identity ≠ source truth;
- source authority ≠ universal authority;
- Actor belief content ≠ Actor identity;
- shared information ≠ one Actor's private state.

---

# 11. Practical diagnostic value for later SOUL work

Without making an architecture decision, the research gives a strong diagnostic frame.

If SOUL produces a wrong outcome, later analysis should be able to distinguish at least:

### Information-state failure

The current informational state is wrong, ambiguous, stale, mis-scoped or semantically incomplete.

### Information-dynamics failure

The acquisition, derivation, retrieval, context assembly, revision or communication process produced the wrong state.

### Persistence/Records failure

Correct information failed to survive, bind, retrieve or dispose correctly over time.

### Environment failure

The actual world/environment condition differs from what the system assumes.

### Work failure

The task/commitment/execution/evaluation process itself is wrong.

### Actor/control failure

Authority, capability, participation or accountability is wrong.

This diagnostic separation is one of the main reasons the hierarchy is useful even before architecture exists.

---

# 12. What is not concluded

This research does **not** establish:

- one universal `Information` class;
- a database schema;
- Knowledge Graph/RAG/memory architecture;
- a context-engineering stack;
- a trust model;
- a final evidence calculus;
- a relation/control taxonomy;
- storage technology;
- SOUL architecture modules;
- Development OS implementation.

Research hierarchy and system architecture remain separate.

---

# 13. Residual questions

Important open questions include:

- exact final label for the parent and children;
- whether deeper research inside State reveals stable immediate children;
- whether deeper research inside Dynamics reveals stable immediate children;
- how persistence specialization should be represented in later cross-ground composition;
- which epistemic/evidence relations need explicit later composition research;
- how context selection relates to Work/Actor responsibility and runtime control;
- how Information state/dynamics should bind to actual Environment state without duplicating it;
- whether independent review finds a third first-order branch.

These are reopen/deepening questions, not reasons to keep the top-level pass open indefinitely.

---

# 14. Completion judgment

The Information top-level node is **boundedly complete for the current foundation-research purpose and user-evaluated/accepted**.

The accepted current result is:

```text
Information / Representation
    ├─ Informational State / Representational Constitution
    └─ Informational Dynamics / Formation–Transformation

Records / Persistent Information
    ↳ deep persistence specialization/profile across Information
```

No substantive child is active. A separate next-work selection/planning decision and explicit authorization are required before substantive research resumes.
