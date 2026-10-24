# Relational Binding — B7 Adversarial Closure

**Status:** COMPLETE / BOUNDED CHILD CLOSURE  
**Date:** 2026-09-05  
**Verification class:** same-model adversarial review; NOT independent replication

## 1. Target under attack

Current B6 hypothesis:

```text
Relational Binding
    ← bounded leaf
    ← no immediate child promoted
    ← reusable semantic-signature grammar
    ← overlapping relation-family profiles
```

Core signature:

```text
binding meaning / relation-type semantics
+ exact anchors in typed semantic positions
+ applicability structure
+ relation-instance individuation
+ qualified/n-ary structure where needed
+ relation-type inference profile where load-bearing
```

---

## 2. Attack A — Binding is still a generic residual `relations` bucket

### Attack

The signature is broad enough to describe almost any relation. Perhaps Binding is only a catch-all between grounds.

### Test

Binding has a narrow diagnostic question:

> What exact cross-ground connection claim is being made, among which anchors in which semantic positions and under what applicability conditions?

It has a stable Binding-local failure family:
- wrong anchor;
- wrong role/semantic position;
- wrong relation meaning;
- lost scope/reference frame;
- stale/wrong temporal applicability;
- qualifier cross-combination;
- unsafe inverse/transitive/symmetry inference;
- generic-link semantic loss;
- represented relation mistaken for actual relation.

It explicitly does **not** decide:
- whether a multi-anchor standing holds;
- whether action is permitted/required/blocked;
- how a relation was established/removed or what effect occurred.

### Result

Binding is broad, but not residual if these boundaries remain enforced.

**Attack rejected with boundary discipline as a closure condition.**

---

## 3. Attack B — Reference / Targeting should be an immediate child

### Attack

Reference/aboutness and target semantics are unusually important and stable.

### Test

They do have distinct local failures, but deeper questions already depend on:
- Information referent/scope/interpretation;
- Work target/outcome semantics;
- exact target/version identity;
- later Standing/Transition when evidence/effect is involved.

A Binding child would mostly re-run accepted Information/Work semantics while reusing the same signature grammar.

### Result

Retain **Reference / Representation / Targeting** as a major profile, not a child.

**Attack rejected.**

---

## 4. Attack C — Participation / Position should be a child

### Attack

Role confusion is a strong independent failure class.

### Test

Participation bindings are critical, but their deep semantics are already substantially Actors-local:
- performer;
- requester;
- verifier;
- principal;
- beneficiary;
- accountable party;
- source/holder/recipient positions.

Binding's distinctive contribution is to preserve which bearer occupies which position relative to which exact Work/Information/Environment anchor under which frame/time.

A new child would risk duplicating the Actors corpus.

### Result

Retain as profile.

**Attack rejected.**

---

## 5. Attack D — Dependency / Support should be a child

### Attack

Dependency and support are operationally central and have separate failure modes.

### Test

Their deep semantics cross:
- Work dependency/coordination;
- Environment Work Conditions/resources/interfaces;
- Information required context/evidence;
- Actor participation/capability;
- later Standing (`ready`, `sufficient`, `actionable`);
- later Control/Transition.

Binding must preserve the exact dependency association and path/method/stage scope, but a universal Dependency child would duplicate existing ground research and quickly become multi-child composition.

### Result

Retain as profile.

**Attack rejected.**

---

## 6. Attack E — Provenance / Attribution should be a child because external standards support it

### Attack

W3C PROV gives provenance a rich standardized vocabulary.

### Test

PROV itself spans:
- association/participation;
- attribution;
- usage;
- generation;
- derivation;
- delegation;
- temporal events.

Those map across Binding, Transition and later Standing/Control questions.

A provenance child under Binding would either:
- absorb Transition generation/derivation;
- absorb evidential Standing;
- duplicate Information Dynamics and Actors participation.

### Result

Provenance/Attribution remains a mandatory cross-cutting profile, not a child.

**Attack rejected.**

---

## 7. Attack F — naive binary edge plus attributes is semantically sufficient

### Attack

Any n-ary/qualified relation can be stored as a binary edge with arbitrary attributes; therefore Binding does not need relation-instance individuation or n-ary semantics.

### Test

This confuses representation equivalence with semantic requirements.

A binary representation may be sufficient **if** it preserves:
- which qualifiers belong to which relation occurrence;
- all semantic positions;
- scope/time/reference associations;
- exact anchors;
- direct/indirect semantics.

If it does, it has represented the same qualified binding semantics by another mechanism.

If it does not, qualifier cross-combination becomes possible.

### Result

Foundation does not mandate n-ary storage. It mandates preservation of the semantic association.

**Attack rejected; implementation neutrality strengthened.**

---

## 8. Attack G — relation-instance individuation smuggles ontology objects

### Attack

Talking about `binding instances` sounds like requiring relation objects/classes.

### Test

The concept is needed even in ordinary natural-language reasoning:

```text
A performs W at t1
A verifies W at t2
```

These are distinct relation claims even if represented as:
- predicates;
- events;
- rows;
- edges with qualifiers;
- nested structures;
- logical formulas.

Foundation only requires that they remain distinguishable.

### Result

No ontology commitment follows.

**Attack rejected.**

---

## 9. Attack H — `actual binding` is epistemically unjustified because systems only see information

### Attack

A system may know relations only through representations/evidence. Perhaps there is no useful Foundation distinction between actual relation and relation claim.

### Test

The accepted Foundation already preserves:

```text
Environment reality != representation
Work state != status representation
Actor standing != record of standing
```

The same source/view distinction must apply to relation claims.

A system may be uncertain about whether the actual binding holds, but uncertainty does not make the claim identical to its referent.

Without this distinction:
- stale assignment record becomes actual assignment;
- authority token becomes authority;
- provenance assertion becomes authentic provenance;
- dashboard dependency becomes realized dependency;
- annotation metadata becomes current target state.

### Result

The distinction is epistemically necessary even when actual relation is not directly observable.

Binding does not claim omniscient access; it preserves the possibility that claim and referent diverge.

**Attack rejected.**

---

## 10. Attack I — scope/reference/time belong entirely to anchors or other grounds

### Attack

Binding should contain only relation type and anchors; all scope/time should be properties of those anchors.

### Test

The same unchanged anchors can bear different relations under:
- different focal Work;
- different role/time intervals;
- different methods/stages;
- different target versions/states;
- different reference frames.

Examples:
- repository target vs support resource depending on focal Work;
- Actor performer at t1, verifier at t2 for same Work;
- resource dependency only under method M;
- annotation about one historical state of a persistent page.

### Result

Applicability cannot always be recovered from anchor state alone.

Binding owns only the frame/time needed to state when the connection holds; assertion/event history remains elsewhere.

**Attack rejected.**

---

## 11. Attack J — relation-type inference profile is formalism leakage

### Attack

Symmetry/transitivity/inverse semantics sound like ontology/logic design rather than Foundation research.

### Test

Unsafe inference changes real decisions:
- `A delegates-to B` + `B delegates-to C` does not automatically establish valid A→C authority;
- indirect support is not necessarily direct dependency;
- source-of is not symmetric;
- participation is not transitive;
- graph reachability through agents/tools does not establish legitimate authority.

Foundation need not formalize these properties in OWL or logic. It only must not permit relation meaning to be silently inferred from topology.

### Result

Inference constraints are semantic guardrails, not formalism commitments.

**Attack rejected with narrower wording: preserve permitted/forbidden relation inference where decision-critical.**

---

## 12. Attack K — relation-family profiles are too loose to be useful

### Attack

If families are not children, the result may become only a generic signature with an arbitrary list of examples.

### Test

Profiles provide retrieval and diagnostic orientation:
- Reference / Representation / Targeting;
- Participation / Position;
- Dependency / Support;
- Provenance / Attribution;
- Situation / Access / Interface;
- Specification / Evidence / Traceability.

But correctness is tested through the same stable signature and Binding-local failures.

The profiles are useful without pretending to be exhaustive partitions.

### Result

Keep profiles explicit in findings/router surfaces with a rule that new families may be added only as profiles unless they meet child-promotion criteria.

**Attack partially succeeds as a documentation requirement, not a structural falsifier.**

---

## 13. Attack L — Binding absorbs Composite Standing

### Attack examples

- `evidence-for` could imply `supports`;
- `authorized-for` can be written as a relation;
- `actionable-with` can be an edge;
- `verified-by` can be a relation.

### Test

Encoding form does not determine problem region.

Ask protected question:

### Binding

What exact anchors/roles/criteria are connected?

### Standing

Does `verified`, `authorized`, `actionable`, `sufficient` actually hold given current bindings/facts/criteria?

If the central failure is omitted prerequisite, stale evidence, missing criterion or insufficient authority, it is Standing rather than Binding.

### Result

Boundary survives.

**Attack rejected.**

---

## 14. Attack M — Binding absorbs Control

### Attack

Delegation/assignment/policy/request relations seem inherently normative.

### Test

Binding can state:
- delegator/delegatee/scope;
- policy applies-to request/subject/object/operation;
- Actor assigned-to Work.

Control asks:
- permitted/required/blocked?
- legitimate authority?
- obligation?
- gate satisfied?
- enforcement active?

### Result

Precise bindings are prerequisites for Control, not Control itself.

**Attack rejected.**

---

## 15. Attack N — Binding absorbs Transition/Effect

### Attack

`generated-by`, `changed-by`, `caused-by`, `derived-from` look like relation types.

### Test

A resulting static linkage can be expressed as Binding, but the questions:
- what event occurred;
- what state changed;
- temporal ordering;
- trigger/precondition;
- causal sufficiency;
- feedback propagation;
belong Transition/Effect.

W3C PROV's generation/use/invalidation examples themselves show event/change semantics beyond static association.

### Result

Boundary survives if Binding does not claim the transition history from the relation label alone.

**Attack rejected.**

---

## 16. Attack O — bounded leaf means no new information beyond parent C2

### Attack

Perhaps the child pass only restated parent relation findings.

### Test

New child-level results include:
- explicit binding semantic signature;
- role-labeled positions preferred over generic arrow direction;
- applicability-frame rule;
- relation-instance individuation;
- qualified/n-ary association as semantic structure rather than child;
- distinction among effective/reference/assertion/event time;
- arity vs cardinality vs completeness distinction;
- type-level inference-profile guardrail;
- relation-family profiles explicitly rejected as child taxonomy;
- external convergence from PROV, n-ary relations, Web Annotation and ABAC.

### Result

Material child-specific information gain exists.

**Attack rejected.**

---

## 17. Attack P — a fifth Foundation/composition region has appeared

### Attack

Maybe `Relation Instance / Context` is a new composition child or top-level ground.

### Test

Relation-instance individuation and applicability are internal Binding structure; they do not create an independent semantic locus analogous to Binding/Standing/Control/Transition or the four grounds.

### Result

No upstream adequacy or parent decomposition reopen.

**Attack rejected.**

---

# 18. Final B7 judgment

Relational Binding survives adversarial closure as:

```text
Relational Binding
    ← BOUNDED LEAF / USER EVALUATION PENDING
    ← no immediate child promoted
    ← rich internal semantic-signature grammar
    ← overlapping relation-family profiles
```

## Stable internal signature

```text
Binding semantic instance
├─ relation meaning / protected semantic question
│   └─ permitted/forbidden inference where decision-critical
├─ exact anchors
│   └─ each occupying typed semantic positions
├─ applicability structure
│   ├─ scope/reference frame
│   ├─ effective/reference time when material
│   └─ operation/method/stage/state/version/role qualifiers when material
├─ relation-instance individuation
└─ qualified/n-ary structure when binary decomposition loses association
```

## Stable profiles

- Reference / Representation / Targeting;
- Participation / Position;
- Dependency / Support;
- Provenance / Attribution;
- Situation / Access / Interface;
- Specification / Evidence / Traceability.

Profiles are not exhaustive ontology classes and may overlap.

## Stable non-collapse rules

```text
generic connectivity != semantic binding

anchor identity != role in binding

represented/asserted binding != actual binding

actual binding != evidence sufficient to establish binding

binding != composite standing
binding != control result
binding != transition/effect history

graph reachability != legitimate transitive relation

binary representation != proof that relation semantics are inherently binary
```

---

# 19. Next-child sequencing pressure exposed by Binding

The parent required re-selection after Binding closure rather than pre-committing the remaining order.

Binding repeatedly terminates in questions such as:
- do these exact bindings make evidence sufficient?
- is Work ready/supported?
- is Actor actionable now?
- is target verified/validated?
- has outcome been attained?
- is source authoritative for this use?

These are **Composite Standing / Qualification** questions.

Control also receives strong pressure from delegation/authorization scope, but it frequently needs a current evaluated standing over precise bindings before permit/require/block questions are well formed.

### Current sequencing recommendation

If the user accepts Relational Binding:

> **Composite Standing / Qualification is the strongest current candidate for the next composition child.**

This is a planning recommendation only. It does not activate that child.

---

# 20. Verification boundary

B7 is same-model adversarial review.

Evidence includes:
- accepted ground and parent research;
- all six pairwise binding probes;
- B1/B3 semantic hard cases;
- rival internal decompositions;
- W3C PROV-O;
- W3C n-ary relation note;
- W3C Web Annotation;
- NIST ABAC;
- selected candidate-study holdouts.

**No independent second-researcher/model replication has validated the exact bounded-leaf conclusion or signature. No external standard publishes this project-specific result.**

User acceptance can close the sequencing gate but does not change verification independence.

# 21. Closure recommendation

Return Relational Binding for user evaluation.

Do not automatically activate:
- Composite Standing / Qualification;
- Control / Constraint;
- Transition / Effect / Feedback;
- architecture;
- ontology/data model/schema;
- implementation.