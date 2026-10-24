# Relational Binding — B1 Binding Object / Minimum Semantic Signature

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Question

Is a binding adequately represented, at Foundation-semantic level, as:

```text
relation type + endpoint A + endpoint B
```

or are additional dimensions required to preserve decision-critical meaning?

## 2. Result in one sentence

> A binding is not universally defined by a flat binary edge; the strongest current minimum semantic core is **exact anchors occupying typed semantic positions under a binding meaning and applicability frame**, with additional temporal, arity and qualification structure when changing those dimensions would change whether the binding is the same binding or whether it validly applies.

This is a semantic signature, not a storage schema.

## 3. Exact anchors are load-bearing

### Why

Many Foundation failures come from binding a correct relation word to the wrong thing:
- evidence bound to the wrong Work/artifact version;
- representation bound to the wrong referent/time slice;
- authority record bound to the wrong bearer;
- Work target bound to a specification rather than the actual Environment target;
- delegation carried forward after Actor/Work identity changed.

### Judgment

**Anchor identity is universal/core.**

A binding must be evaluable against the exact anchors whose identities matter for the claim.

`Exact` does not imply one universal identifier system. It means the identity/equivalence claim needed by the binding cannot be silently replaced by a nearby copy/version/role bearer.

## 4. Typed semantic positions are more fundamental than generic direction

Consider:

```text
Actor A --participates--> Work W
```

This hides whether A is:
- performer;
- requester;
- decider;
- authorizer;
- verifier;
- beneficiary;
- accountable party.

Likewise:

```text
Information I --related-to--> Actor A
```

is insufficient to distinguish:
- source;
- holder;
- asserter;
- transmitter;
- recipient;
- represented subject;
- principal.

### Direction attack

Could `A → B` plus an inverse relation name fully replace role semantics?

No, because many bindings have several non-interchangeable positions and not all are naturally `subject/object` pairs. Inverse naming can encode some binary asymmetry but does not eliminate the need to know **which semantic position each anchor occupies**.

### Judgment

**Role-labeled/typed positions are universal/core.**

Direction/order is **derived or conditional**:
- for some bindings, ordered positions are semantically necessary;
- for symmetric bindings, arrow direction is not;
- for n-ary bindings, a single arrow is often meaningless.

So preserve ordered/typed positions rather than treating `direction` as one mandatory independent field.

## 5. Binding meaning/type is universal but names are not

`related-to`, `influences`, `uses`, `supports` and `participates-in` are often too broad.

A generic link loses different correction paths:
- wrong referent binding → fix source/target semantics;
- wrong participant role → fix participation/standing relation;
- wrong dependency/support relation → fix feasibility/dependency model;
- wrong provenance attribution → fix source/derivation/association binding.

### Judgment

**A binding must preserve the protected semantic question of the connection.**

This does not require one final universal relation vocabulary. It requires relation semantics strong enough that replacing the binding with a generic link would expose what meaning has been lost.

## 6. Applicability frame is load-bearing, but not always represented the same way

Bindings often hold only relative to:
- focal Work;
- analytical/system boundary;
- claim/question;
- purpose/use;
- method/stage;
- Environment/reference frame;
- operation being requested;
- source universe or population.

Examples:
- a repository is a Work Condition for one Work and a Domain target for another;
- an Actor is verifier for one Work step and performer for another;
- Information is relevant evidence for one claim but irrelevant to another;
- a resource supports one method but not another.

### Attack

Could all scope/reference semantics simply belong to the anchors rather than the binding?

No. The same anchors can bear different valid relations under different focal Work/reference frames without either anchor changing identity.

### Judgment

**Applicability frame is universal as a semantic requirement**, but it may be explicit or inherited when unambiguous.

The rule is:

> A binding is incomplete when changing the omitted frame would change whether the binding meaningfully holds.

## 7. Time is conditionally first-order

Examples:
- A was authorized/assigned/holder at `t1` but not `t2`;
- representation `I` was current for Environment condition at `t1`, stale at `t2`;
- resource supported Work only during an availability interval;
- an Actor participated in the same Work under different roles at different times.

### Attack

Could time always be derived from endpoint histories?

Not safely. Two persistent anchors may retain identity while the relation between them begins, ends or changes independently.

### Judgment

**Temporal applicability is conditionally load-bearing Binding semantics.**

It is not a universal mandatory timestamp. It becomes part of binding identity/applicability when relation validity changes over time.

Time remains cross-cutting across Foundation; Binding owns only the time semantics necessary to say when this connection holds.

## 8. Arity is structural, not a universal `cardinality` field

Some bindings are safely binary:
- representation `I` is about Environment condition `E` under an already fixed frame;
- Actor `A` is source of Information `I`.

Other cases require additional semantic positions:
- Actor `A` participates in Work `W` **as role R**;
- Information `I` is evidence for claim `C` **about target/version T**;
- resource `R` supports Work `W` **for method/stage M**;
- delegation connects delegator, delegatee, authority/scope and sometimes represented principal.

### Binary-decomposition attack

Could these always be decomposed into several binary links?

Only if the representation preserves **which qualifiers belong to the same relation instance**. Otherwise binary decomposition can create false combinations.

Example:

```text
A performs W during t1
A verifies W during t2
```

Independent edges `A—role→performer`, `A—role→verifier`, `A—Work→W`, `A—time→t1/t2` do not tell which role belongs to which interval.

### Judgment

**Arity/qualification is a structural property of a binding instance.**

It is not a separate child by default and does not imply a particular n-ary data model. Semantically, all anchors/qualifiers needed to prevent cross-combination must remain bound together.

## 9. Cardinality and multiplicity are mostly type-/context-level constraints

Questions such as:
- one verifier or several?
- one principal or multiple?
- exactly one target version?
- can several sources support the same claim?

can be important, but they often concern:
- constraints on allowed binding sets;
- completeness requirements;
- standing/control conditions;
- domain-specific relation rules.

### Judgment

**Cardinality is not universal instance-level Binding core.**

Retain multiplicity where changing it changes the semantic claim, but do not force generic min/max cardinality semantics into every binding.

## 10. Qualifier/context is conditional and may be the relation's semantic key

Qualifiers include:
- role;
- method;
- operation;
- purpose;
- criterion;
- location;
- stage;
- reference frame;
- delegation scope;
- target version.

Some are better understood as additional semantic positions; others refine applicability.

### Judgment

Do not create one generic `qualifier` bucket. Ask:

> If this value changes, do we still have the same binding claim?

If no, the qualifier is part of the binding's semantic signature.

## 11. Actual binding versus representation/claim about binding

A repository can contain:

```text
"Actor A is authorized for Work W"
```

That informational state does not prove that the authority relation actually holds.

Similarly:
- status says `assigned` ≠ actual participation;
- provenance record says `generatedBy` ≠ source claim automatically authentic;
- plan says Work targets Environment condition ≠ actual Work execution/effect relation;
- context says resource available ≠ actual availability.

### Judgment

Binding research must separate:

```text
actual cross-ground binding
!= informational representation/assertion of that binding
!= evidence sufficient to establish that binding
```

The last distinction belongs partly to Information/Composite Standing. Binding must not solve evidential sufficiency itself.

## 12. Modality/status of the relation claim is not one Binding-local enum

`planned`, `asserted`, `inferred`, `hypothetical`, `historical`, `actual` may describe very different things:
- an Information claim about a relation;
- a Work plan/intention;
- a derived inference;
- an actual realized binding;
- a past binding reconstructed from evidence.

### Judgment

Do **not** collapse these into a universal Binding `mode` attribute.

Binding should identify the semantic relation being discussed; whether/why it is believed, asserted, planned or established is supplied by the relevant ground/composition semantics.

## 13. Provenance/evidence of the relation claim is adjacent, not universal core

A decision may require proof that a binding holds, especially for:
- authority/delegation;
- exact target/version;
- provenance/attribution;
- past Environment conditions;
- Work participation/history.

But evidence supporting `binding B holds` is itself Information and may involve additional Work/Actor/Environment anchors.

### Judgment

Evidence/provenance is **not automatically a slot inside every binding**.

It remains a relation family and later Composite Standing concern. Binding must remain source/view-safe without absorbing evidence sufficiency.

## 14. Refined binding semantic signature

Strongest current formulation:

```text
Binding instance
├─ semantic meaning / protected relation question
├─ exact anchors
│   └─ each occupying a typed semantic position
├─ applicability frame
│   └─ scope / reference / focal use needed for the binding to hold
└─ conditional semantic structure
    ├─ temporal applicability, when relation validity changes over time
    ├─ additional anchors / n-ary qualification, when pairwise form loses association
    ├─ exact version/equivalence conditions, when identity is version-relative
    └─ other qualifiers whose change changes the binding claim
```

Not universal Binding-core fields:
- one arbitrary arrow direction;
- generic cardinality constraints;
- epistemic confidence;
- evidence sufficiency;
- permission/obligation;
- derived standing;
- transition/event history;
- storage/reification mechanism.

## 15. Boundary with neighbouring composition children

### Binding asks

What is connected to what, in what positions/frame/validity?

### Composite Standing asks

Given bindings + criteria/facts, what standing holds?

### Control asks

What makes a transition/action permitted, required, blocked or gated?

### Transition asks

What changed, when, by what event/effect/feedback path?

Encoding any of the latter as a relation edge does not make it Binding research.

## 16. B1 judgment

F1 `type+A+B is sufficient`: **REJECTED**.

F2 role/direction redundant: **PARTIAL** — role/ordered position is core; generic arrow direction is not independently universal.

F3 scope/reference is not relation-local: **REJECTED** where frame changes validity.

F4 time is not relation-local: **REJECTED conditionally**; temporal applicability matters when binding changes independently of anchor identity.

F5 n-ary qualification is only modeling artifact: **NOT SUPPORTED**; semantic association among qualifiers can be lost by naive binary decomposition.

Current conclusion:

> Relational Binding has a coherent semantic object and a reusable signature. The next question is whether relation-family candidates form stable immediate children or remain overlapping families under one bounded Binding node.

Proceed to B2.