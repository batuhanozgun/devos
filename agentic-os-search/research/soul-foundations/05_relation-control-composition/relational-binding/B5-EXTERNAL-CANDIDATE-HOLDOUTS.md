# Relational Binding — B5 External Authoritative / Candidate-Study Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05  
**Role:** falsification / pressure test; external sources do not define the Foundation taxonomy

## 1. Question

Does materially different external evidence expose:

- a stable Relational Binding child split that internal evidence missed;
- a flaw in the B1/B3 binding-signature grammar;
- evidence that qualified/n-ary relation semantics are merely modeling artifacts;
- a missing relation family that cannot fit the bounded-leaf result;
- boundary theft into Composite Standing, Control or Transition?

## 2. Source set

Authoritative / standards-oriented holdouts:

1. **W3C PROV-O: The PROV Ontology**  
   https://www.w3.org/TR/prov-o/
2. **W3C Working Group Note: Defining N-ary Relations on the Semantic Web**  
   https://www.w3.org/TR/swbp-n-aryRelations/
3. **W3C Web Annotation Data Model**  
   https://www.w3.org/TR/annotation-model/
4. **NIST SP 800-162: Guide to Attribute Based Access Control (ABAC) Definition and Considerations**  
   https://csrc.nist.gov/pubs/sp/800/162/upd2/final

Candidate-study holdouts:

5. `research/studies/anthropic-ai-native-sdlc-playbook/META.md`
6. `research/studies/multi-agent-patterns/META.md`
7. `research/studies/context-memory-harness-engineering/META.md`

The W3C n-ary document is an informative Working Group Note, not a W3C Recommendation; it is used as a modeling/semantic counterframe, not normative taxonomy authority.

---

# 3. W3C PROV-O — qualified relations and role/time pressure

## What the source does

PROV-O has broad unqualified relations such as `wasInfluencedBy`, but also provides **qualified influence** patterns and specific relation kinds including:
- Usage;
- Generation;
- Association;
- Attribution;
- Delegation;
- Derivation;
- Communication;
- Start / End / Invalidation;
- PrimarySource / Revision / Quotation.

Qualified relations can preserve additional semantics such as:
- influencing Entity/Activity/Agent;
- `hadRole`;
- `atTime`;
- `hadPlan`;
- generation/use details.

PROV-O explicitly notes that role cannot always be expressed with only the simpler starting-point relation; e.g. an Activity using an Entity as a particular role can require qualified Usage.

## Pressure on B1/B3

This independently supports:
- relation meaning beyond generic `influence`;
- relation-instance qualification;
- typed semantic positions;
- role as relation-relative rather than only Actor/Entity intrinsic property;
- time as relation/event-relative where material;
- more specific relations preferred over one overly broad influence edge when semantics matter.

## Does PROV create a stable Binding child?

No.

PROV relation kinds span several of the B2 family candidates:
- Association → participation/position;
- Attribution → provenance/attribution;
- Derivation/PrimarySource → provenance;
- Usage → dependency/use/participation;
- Generation/Invalidation → Transition/Effect pressure;
- Delegation → participation + later Control.

This supports **overlapping profiles plus qualified relation grammar**, not a clean universal child partition.

## Falsifier result

- `type + A + B sufficient`: **falsified by external holdout**.
- role/qualification merely presentation: **falsified**.
- provenance as one clean Binding child: **not established**.

---

# 4. W3C n-ary relation note — relation-instance arguments are not just edge decoration

## What the source does

The W3C note starts from RDF/OWL binary properties and addresses cases where the natural relation needs:
- additional attributes of the relation instance such as certainty/strength/relevance;
- more than two participants, such as buyer/seller/object/price;
- ordered argument sequences.

It distinguishes a relation from an **instance of the relation** and presents representation patterns that preserve all arguments belonging to that relation instance.

The note also warns that statement reification and n-ary relation instances are not conceptually identical: extra information may characterize the relation instance itself rather than merely a statement about a binary triple.

## Pressure on B3

This strongly supports the B3 distinction:

> the semantic issue is not `more than two database columns`; it is preserving which arguments/qualifiers jointly constitute one relation instance.

It also independently supports:
- relation-instance individuation;
- ordered roles when order matters;
- qualification as semantic structure;
- naive independent binary links being capable of losing association among qualifiers.

## Boundary correction

The note's ontology patterns are **implementation/representation patterns**, not Foundation requirements.

Relational Binding should retain the semantic need for n-ary/qualified association while remaining neutral about:
- relation-as-class;
- blank nodes;
- RDF lists;
- graph reification.

## Does `N-ary Binding` become a child?

No.

The note's examples show n-ary shape occurring for many semantic relation types. This reinforces B3's result that n-ary/qualification is a **structural dimension**, not a semantic child region.

---

# 5. W3C Web Annotation — exact target, state, selector, role and scope

## What the source does

The Web Annotation Data Model treats an Annotation as a directed relationship involving Body and Target resources. It further recognizes that a Target or Body may need to be more specific than the resource IRI alone.

A `SpecificResource` can capture:
- source resource;
- selected segment via Selector;
- intended state/representation;
- purpose/role in the Annotation;
- scope in which the resource applies;
- rendering/style details where relevant.

The specification explicitly notes use cases where:
- only a segment is targeted;
- a particular state/version of a changing resource is intended;
- the resource plays a role specific to this annotation;
- the annotation applies only in a particular context/scope.

## Pressure on Binding signature

This is a very strong counterexample to:

```text
resource IRI alone = exact relational target
```

It independently supports:
- exact anchor/reference identity being use-relative;
- selector/state/version qualification;
- scope/purpose as relation/application semantics;
- relation-specific roles;
- one persistent source resource yielding different specific targets under different selectors/states/scopes.

## Important source/view warning

The Web Annotation specification also warns that properties of external resources included in the Annotation document are hints and not necessarily authoritative information about those external resources.

This aligns with the Binding rule:

```text
representation/assertion of binding or target metadata
!= actual/current external relation or standing
```

## Does this force a `Reference Binding` child?

It strengthens Reference/Representation as a major profile, but not enough to promote it.

Why:
- the exact-target/qualification grammar it exposes is structurally the same grammar used by Participation and Dependency cases;
- deep `aboutness` semantics are already Information-local;
- Foundation Binding's distinctive job is preserving exact target/role/scope linkage across grounds, not reopening annotation ontology as a child taxonomy.

---

# 6. NIST ABAC — operation/environment context shows Binding/Control boundary

## What the source does

NIST SP 800-162 defines ABAC authorization as evaluation of attributes associated with:
- subject;
- object;
- requested operation;
- in some cases Environment conditions;
against policy, rules or relationships describing allowable operations.

NIST also describes Environment conditions as dynamic factors such as time/location/threat level and notes that object attributes must be assuredly associated/bound to the correct objects.

## Pressure on Binding

ABAC provides a useful hard case because a generic relation:

```text
Actor A can-access Object O
```

loses:
- requested operation;
- environment condition;
- subject/object identity/attributes;
- policy context.

Before Control can evaluate authorization, the composition must know the **exact anchors and operation/context to which the decision applies**.

This supports Binding's role as a prerequisite for Control.

## Boundary protection

ABAC itself is primarily a Control model.

Relational Binding must not import:
- policy evaluation;
- authorization result;
- permit/deny standing;
into Binding merely because the request relation is multi-anchor.

Binding supplies precise subject/object/operation/environment relationships; Control later evaluates allowed/blocked semantics.

## Child effect

No new Binding child forced.

---

# 7. Anthropic AI-native SDLC candidate holdout

Current package pressure relevant to Binding includes:
- committed artifact chain: intent → spec → plan → code/tests → review → deployment/incident;
- exact artifact/version and source-of-truth binding;
- producer/reviewer/human-gate role differentiation;
- subagent/delegation relationships;
- environment-specific permissions/tool access;
- a transitive-authority failure where an agent without direct effect path attempted to reach a stronger agent.

## Binding lessons

### Exact artifact/target

Review/evidence must bind to the correct artifact/version, not merely a project/repository label.

### Role binding

Producer, reviewer, verifier, human gate and release-related positions must not collapse into `participant`.

### Delegation/reachability

Agent-to-agent relation must preserve:
- caller;
- callee;
- task/operation/scope;
- capability/tool path;
- principal/authority context when applicable.

But whether the path is legitimately authorized belongs Control/Standing.

### Result

Supports B1/B3 signature; no child split forced.

---

# 8. Multi-agent patterns candidate holdout

Relevant pressure:
- manager/worker/critic/verifier/integrator role labels;
- handoff;
- decomposition;
- delegation;
- generator–critic relationships;
- orchestration topology.

## Binding lessons

The topology alone does not establish:
- authority;
- competence;
- accountability;
- verification independence.

Therefore:

```text
hierarchy/topology relation
!= authority standing
!= responsibility standing
```

Role-specific Actor↔Work bindings remain important, but do not justify a standalone Participation child because the detailed standing/authority semantics remain Actors/Control concerns.

---

# 9. Context / memory / harness candidate holdout

Relevant pressure:
- source eligibility;
- current context selection relative to Work/query;
- persistent memory versus currently exposed context;
- runtime/tool/permission substrate;
- fresh-session reconstruction.

## Binding lessons

A context item is not simply `related-to Work`.

Decision-critical binding can include:
- source universe;
- selected information state;
- current Work/query/purpose;
- version/freshness reference;
- selection/exposure path.

But `context sufficient for task` is Composite Standing and runtime enforcement belongs Control/Environment.

Again the same Binding signature recurs without a new family boundary.

---

# 10. External challenge to the bounded-leaf hypothesis

## Challenge A — qualified relation standards imply `Qualified Binding` child

**Rejected.** Qualification occurs across provenance, annotation, authorization-request and operational role cases. It is a structural grammar.

## Challenge B — PROV provides many relation categories, so provenance should be a child

**Rejected.** PROV itself mixes association, attribution, derivation, generation, usage, delegation and temporal events; several cross Binding/Transition/Control boundaries.

## Challenge C — Web Annotation proves Reference should be a child

**Not sufficient.** Reference/targeting is a strong profile, but its Binding-specific semantics are the same exact-anchor/role/scope/state grammar, while deep aboutness remains Information-local.

## Challenge D — ABAC proves Access/Authorization should be a Binding child

**Rejected.** Precise request/anchor binding is prerequisite; authorization is Control/Composite Standing.

## Challenge E — n-ary patterns prove relation instance is an ontology entity

**Rejected as Foundation claim.** Relation-instance individuation is semantically necessary; representation mechanism remains open.

---

# 11. External-holdout synthesis

All four authoritative holdouts converge on a narrower claim than a fixed relation taxonomy:

> **A usable relation must preserve the exact participants/targets, their semantic positions, the relation meaning and whatever scope/state/time/operation/role qualifiers are necessary to identify the intended relation instance.**

They also converge on warnings against genericization:
- PROV broad influence vs more specific qualified influences;
- n-ary relations vs naive binary loss;
- Web Annotation generic source IRI vs SpecificResource/Selector/State/Scope;
- ABAC generic subject-object access vs operation/environment/policy-sensitive request.

None establishes a stable universal child taxonomy for Relational Binding.

---

# 12. B5 judgment

External/candidate holdouts **strengthen**, rather than falsify, the B4 provisional result:

```text
Relational Binding
    ← coherent child of Cross-Ground Composition
    ← likely bounded leaf at current Foundation depth
    ← one reusable semantic-signature grammar
    ← overlapping family profiles, not promoted children
```

Strongest retained signature:

```text
Binding semantic instance
├─ binding meaning / relation-type semantics
├─ exact anchors in typed semantic positions
├─ applicability structure
│   ├─ scope/reference frame
│   ├─ effective/reference time when material
│   └─ role/operation/method/state/version qualifiers when material
├─ relation-instance individuation
├─ n-ary/qualified structure when binary decomposition loses association
└─ relation-type inference profile where decision-critical
```

Boundary retained:

```text
binding claim precision
!= evidence that the binding is true/current
!= composite standing
!= authorization/control
!= transition/effect history
```

No external source validates the project's exact Binding synthesis. The evidence is convergent pressure, not external certification.

Proceed to B6 synthesis / immediate-child decision.