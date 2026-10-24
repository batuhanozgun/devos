# Informational Dynamics / Formation–Transition — Integrated Synthesis

**Status:** bounded synthesis / awaiting user evaluation  
**Date:** 2026-09-05  
**Scope:** Informational Dynamics node only; no architecture/ontology/implementation decision

## Executive result

The completed node pass supports a three-region structure:

```text
Informational Dynamics / Formation–Transition
    ├─ Informational Formation / Acquisition
    ├─ Informational Derivation / Transformation
    └─ Informational Selection / Exposure
```

The key discovery is that informational dynamics are not exhausted by content transformation. A system may hold correct source information yet expose the wrong subset/version/context. That creates a first-order failure region distinct from both acquisition and derivation.

## 1. What Dynamics means here

The node concerns **informational transitions**: processes/relations whose focal effect is that information becomes instantiated, changes, or becomes available/visible under a use/reference frame.

A transition may change:

- existence/instantiation;
- content/form;
- identity/version/equivalence;
- applicability/standing/currentness;
- visibility/availability;
- provenance/lineage;
- consumer-visible working set.

Not every transition changes content.

## 2. Formation / Acquisition

Formation is the source-interface problem.

It asks how something outside or prior to the informational state—phenomenon, signal, assertion, source resource—becomes an in-scope informational state.

Its distinctive risks are observability, sampling, detectability, capture/parsing fidelity and procedure/source/result binding.

A well-defined output format does not prove sound formation.

## 3. Derivation / Transformation

Transformation is the state-to-state problem.

It asks how existing information contributes to a new/changed state or standing and what semantic effect the operation has.

It includes, when focal:

- computation/inference;
- translation/normalization/migration;
- aggregation/projection/compression;
- revision/correction/retraction/supersession;
- reconciliation/merge.

The central discipline is to identify what was preserved, added, removed, reinterpreted, re-scoped or rebound, and to preserve enough lineage to understand that effect.

## 4. Selection / Exposure

Selection is the availability/use-interface problem.

It asks which already-existing informational states become eligible and visible to the relevant consumer/use.

It includes, when focal:

- retrieval/query/filtering;
- ranking;
- context/view formation;
- publication/exposure/delivery;
- downstream current-vs-stale visibility.

This branch exists because source correctness and transformation correctness do not guarantee that decision-critical information reaches the working view.

## 5. Why the branches are not event classes

A single real operation can touch more than one branch.

Examples:

- fetching an external page may instantiate a local representation (Formation) and select one source among candidates (Selection);
- summarization may depend on selected inputs (Selection) and derive a summary state (Transformation);
- communication may translate a message (Transformation), expose it (Selection), and instantiate a receiver-side copy (Formation).

The correct routing unit is the **protected informational question and reference frame**, not the API verb.

## 6. Specializations not promoted

### Revision / standing change

Deep and important, but mainly specializes state-to-state transformation and then often requires downstream exposure/propagation. It is not a disjoint fourth population.

### Communication

Composite across Transformation, Selection/Exposure, receiver-relative Formation, Actors and Environment.

### Propagation / synchronization

Crosses recomputation/invalidation and downstream exposure. It is a dependency pattern across C2/C3.

### Persistence / Records

Persistence creates additional future-usability/history/retention/disposition obligations across State and every Dynamics branch; it remains an explicit deep specialization/profile.

## 7. Cross-cutting dimensions

The three branches do not eliminate transition dimensions. Later reasoning may need:

- origin/trigger;
- inputs/outputs/cardinality;
- semantic effect;
- identity/version effect;
- applicability/standing effect;
- visibility/availability effect;
- provenance/lineage;
- time/order;
- determinism/reproducibility;
- reversibility/reconstructability;
- freshness/propagation lag;
- source/consumer/authority relations.

These are dimensions/relations, not automatic children.

## 8. Neighbor boundaries

- **Informational State:** owns what the resulting representation is/about/means and its constitution/qualification.
- **Environment:** owns actual realized domain/runtime conditions and capabilities.
- **Work:** owns goal-directed pursuit, commitment, execution, verification and acceptance.
- **Actors:** owns identity, role, capability, authority and participation.
- **Records:** owns persistence-specific protected outcomes and obligations.

Dynamics may be caused/governed by those regions without absorbing them.

## 9. External falsification result

Materially different traditions were used:

- metrology supported acquisition/process vs result distinctions;
- W3C PROV supported generation and derivation/change distinctions;
- belief revision supported state-change specialization;
- TREC supported query/use-relative ranked selection;
- Web Annotation supported source vs selector/specific representation distinctions;
- NARA records lifecycle provided a persistence-specific holdout.

No source tradition forced a stable fourth universal child.

## 10. Naming result

The accepted qualifier `Formation–Transformation` is too narrow because it under-signals Selection/Exposure and standing/availability transitions.

Recommended refinement:

> **Informational Dynamics / Formation–Transition**

`Transition` is used as a broad research descriptor, not as an ontology class. It covers formation, state-to-state change and availability/visibility transitions without enumerating every mechanism.

## 11. Verification / epistemic status

This is a bounded Foundation research synthesis supported by:

- current canonical internal evidence;
- accepted sibling/Records results;
- selected candidate-study holdouts;
- materially different external primary/authoritative sources;
- same-model N6 adversarial audit.

It is **not independently replicated**. User approval changes sequencing/acceptance, not verification independence.

## 12. Current stop point

The node is ready for user evaluation. No proposed child is authorised for deeper research until a separate transition is selected.
