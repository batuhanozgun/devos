# Informational Dynamics / Formation–Transformation — N3 Immediate-Child Discovery

**Status:** COMPLETE; leading three-child split promoted provisionally for N4–N6 attack  
**Date:** 2026-09-05  
**Dependency:** `N2-FIRST-PRINCIPLES-PROBLEM-INVENTORY.md`

## 1. Question

Can the N2 problem families be compressed into stable first-order Dynamics branches without importing a lifecycle/pipeline taxonomy or turning transition dimensions into fake children?

## 2. N2 problem families recovered

```text
D1  source/phenomenon → informational formation
D2  encoding/interpretation/representation formation
D3  derivation/computation/inference
D4  semantic transformation/normalization/translation
D5  aggregation/projection/compression
D6  selection/retrieval/ranking/context formation
D7  communication/publication/exposure/receipt
D8  revision/correction/supersession/retraction/invalidation
D9  conflict detection/reconciliation/merge
D10 propagation/synchronization/downstream update
D11 persistence/recall/forgetting/disposition transitions
```

The task is not to make every item mutually exclusive. It is to find first-order branches with distinct protected questions and failure families.

---

# 3. Rival A — lifecycle verb list

Candidate:

```text
Capture
Create
Transform
Store
Retrieve
Communicate
Update
Delete
```

## Strength

Readable and common across information systems.

## Failure

It mixes mechanism/lifecycle verbs at different semantic levels:

- `store` and `delete` are persistence-mechanism/lifecycle actions;
- `retrieve` can include selection, ranking and exposure;
- `update` can mean content revision, standing change, index refresh or propagation;
- `communicate` can copy, expose or transform;
- `create` can be assertion, observation, derivation or copy instantiation.

The categories are neither semantically disjoint nor stable across domains.

**Verdict: reject as Foundation child hierarchy.**

---

# 4. Rival B — Formation vs Transformation

Candidate:

```text
1. Formation / Acquisition
2. Transformation / Change
```

## Strengths

- simple;
- distinguishes initial formation from state-to-state change;
- aligns superficially with the accepted `Formation–Transformation` label.

## Failure — selection/exposure residual

A source corpus can remain unchanged while:

- retrieval selects a different subset;
- ranking changes order;
- permission/filtering changes eligibility;
- context assembly changes model-visible information;
- publication/communication changes audience/availability.

Calling all of these `transformation` is possible only by making transformation mean “any informational transition,” which destroys the branch's protected meaning.

The failure family is different:

- transformation fidelity asks what content/meaning changed;
- selection/exposure asks what became visible/available and what was omitted.

**Verdict: too coarse.**

---

# 5. Rival C — Formation / Transformation / Selection–Exposure

Candidate:

```text
Informational Dynamics
    ├─ Informational Formation / Acquisition
    ├─ Informational Derivation / Transformation
    └─ Informational Selection / Exposure
```

Labels are provisional; protected questions matter more than nouns.

## C1 — Informational Formation / Acquisition

Protected question:

> **How does a phenomenon, source act, signal, assertion or source resource become a newly instantiated informational state, and what formation limits or distortions arise before/while that state comes into existence?**

Primary N2 load:

- D1 source/phenomenon → formation;
- formation-side D2 encoding/interpretation.

Distinct failures:

- biased sampling / partial observability;
- procedure-result binding loss;
- observation vs assertion confusion;
- primary vs copied/derived origin confusion;
- signal/source-to-representation mapping failure.

Why distinct:

The protected question concerns **how an informational state first becomes instantiated from its source/origin**, not how an already-available informational state is subsequently changed or selected for use.

## C2 — Informational Derivation / Transformation

Protected question:

> **How do one or more existing informational states contribute to a new or changed informational state/standing, and what semantic, identity, lineage or applicability effect does that transformation have?**

Primary N2 load:

- D3 derivation/inference;
- D4 semantic transformation;
- D5 aggregation/projection/compression;
- D8 revision/standing change;
- D9 reconciliation/merge;
- transformation-side D2.

Distinct failures:

- invalid inference/computation;
- lossy normalization/translation;
- summary/aggregation distortion;
- correction/revision erases history or misstates standing;
- merge invents consensus;
- transformation loses lineage/source binding.

Why distinct:

The branch concerns **semantic/state transition from existing informational inputs to new/changed informational outputs**, not merely exposure of unchanged source states.

## C3 — Informational Selection / Exposure

Protected question:

> **How do existing informational states become eligible, selected, ranked, filtered, communicated or otherwise exposed to a consumer/use, and what omission, coverage, visibility or ordering failures arise without requiring the source content itself to change?**

Primary N2 load:

- D6 selection/retrieval/context formation;
- D7 communication/exposure/receipt;
- substantial D10 propagation/synchronization load.

Distinct failures:

- relevant state exists but is not exposed;
- wrong version/rank dominates working context;
- source absence is inferred from retrieval miss;
- delivery occurs without interpretability;
- correction exists but downstream views remain stale;
- different consumers see incompatible subsets despite unchanged source universe.

Why distinct:

This branch protects a failure class where **availability/visibility/selection changes while source informational content may remain intact**.

---

# 6. Rival D — add Revision / Standing Change as fourth child

Candidate:

```text
Formation
Transformation
Selection / Exposure
Revision / Standing Change
```

## Promotion argument

Revision has strong specialist traditions:

- belief revision;
- correction/retraction/supersession;
- currentness/invalidation;
- version lifecycle.

Its failures differ from ordinary format conversion.

## Anti-promotion argument

Revision is defined by the **semantic effect** on maintained information, not by a disjoint transition topology.

A revision can occur through:

- new observation/acquisition;
- derived inference;
- direct content edit/transformation;
- standing-only update;
- conflict reconciliation;
- propagation to selected views.

Correction/retraction/supersession can therefore cross C1–C3 and especially specialize C2 rather than form a universal peer population.

The Records corpus also warns that correction/retraction labels are domain-sensitive.

**Verdict: retain as load-bearing transition mode/specialization, not immediate fourth child provisionally.**

---

# 7. Rival E — transition topology labels

Candidate:

```text
1. source / phenomenon → state
2. state(s) → state(s)
3. state(s) → consumer-visible state
```

## Strength

This is structurally close to Rival C and avoids domain nouns.

## Failure

The topology alone is not enough:

- source resources can themselves be informational states;
- consumer-visible context is itself an informational state;
- communication can create copies rather than only expose references;
- standing changes can occur without obvious source/output cardinality change.

**Verdict:** useful formal lens for Rival C, but not sufficiently explanatory as the user-facing Foundation branch labels.

---

# 8. Rival F — no split / one Dynamics leaf

Candidate:

> Keep Dynamics as one leaf with transition dimensions only.

## Strengths

- avoids arbitrary lifecycle taxonomy;
- many operations genuinely overlap;
- transition dimensions can describe heterogeneous mechanisms.

## Failure

Three failure families remain materially separable:

1. **formation validity** — was the informational state formed from the source/phenomenon appropriately?
2. **transformation fidelity/validity** — did existing informational states produce the output soundly and with known semantic effect?
3. **selection/exposure sufficiency** — did the right existing information become visible/available for the use?

A system can pass two and fail the third:

- correct source states + valid transformation + wrong retrieval context;
- correct retrieval of a biased observation;
- sound acquisition + complete context + invalid inference;
- correct transformed state stored, but correction not propagated to consumer views.

Collapsing these loses decision-critical diagnosis.

**Verdict: too coarse at current Foundation purpose.**

---

# 9. Where do cross-cutting N2 families go?

## D2 encoding/interpretation

Crosses C1 and C2:

- source/signal → initial representation = formation;
- representation → equivalent/different representation = transformation.

## D5 aggregation/projection/compression

Primarily C2 when a derived output is created. Can feed C3 when used to construct a view/context.

## D8 revision/standing change

Primarily a C2 transition mode, sometimes triggered by C1 and propagated through C3.

## D9 conflict/reconciliation

Conflict is a cross-state condition; reconciliation/merge is mainly C2 and may require Work/Actor authority.

## D10 propagation/synchronization

Crosses C2/C3: downstream views may need recomputation, invalidation or re-exposure after source change.

## D11 persistence lifecycle

Records/persistence specialization crossing all three:

- capture/write can instantiate persistent state;
- update/migrate/revise transforms it;
- retrieval/recall exposes it;
- disposition changes availability/existence/standing under persistence-specific obligations.

---

# 10. Candidate cross-cutting transition dimensions

Remain explicit but unpromoted:

- origin/trigger;
- input/output cardinality;
- semantic effect;
- identity/version effect;
- applicability/standing effect;
- visibility/availability effect;
- provenance/lineage;
- effective/system-known/event time;
- determinism/reproducibility;
- reversibility/reconstructability;
- propagation lag/freshness;
- authority/source/consumer relation.

---

# 11. Label implication

The accepted node label `Formation–Transformation` under-signals C3 `Selection / Exposure`.

Possible closure refinements:

- `Informational Dynamics / Formation–Transformation–Exposure` — explicit but cumbersome;
- `Informational Dynamics / Formation–Transition` — structurally broad, concise but abstract;
- retain `Informational Dynamics / Formation–Transformation` with explicit protected scope — continuity-preserving.

No rename is promoted yet. N4–N6 must test whether C3 survives before changing the label.

---

# 12. N3 verdict

**Leading immediate-child decomposition for attack:**

```text
Informational Dynamics / Formation–Transformation
    ├─ Informational Formation / Acquisition
    ├─ Informational Derivation / Transformation
    └─ Informational Selection / Exposure
```

Status:

- C1: **PROVISIONAL CHILD CANDIDATE**;
- C2: **PROVISIONAL CHILD CANDIDATE**;
- C3: **PROVISIONAL CHILD CANDIDATE**;
- Revision / Standing Change as fourth child: **REJECTED PROVISIONALLY; retain as transition mode/specialization**;
- Records/persistence as Dynamics child: **REJECTED PROVISIONALLY; retain cross-cutting specialization/profile**;
- no-split rival: weakened because three independent failure families survive.

N4 must now attack this structure against State, Environment, Work, Actors, Records and role-switching cases.
