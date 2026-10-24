# Informational State / Representational Constitution — N5 External and Cross-Domain Falsifiers

**Status:** COMPLETE; no external tradition forces an immediate child split  
**Date:** 2026-09-05  
**Dependency:** `N4-BOUNDARY-ANTI-COLLAPSE.md`

## 1. Purpose

N5 attacks the provisional result:

> `Informational State / Representational Constitution` is a bounded leaf for the current Foundation depth, with explicit internal constitution dimensions/relations rather than immediate children.

The goal is not vocabulary agreement. External sources are used to seek:

- a stable missing first-order child;
- a case where reference/content/identity/qualification form independent peer regions;
- evidence that a qualification/standing branch must be promoted;
- a domain where the leaf map creates forced-fit semantics;
- a reason to reopen the parent State/Dynamics boundary.

Primary/authoritative sources are preferred where available. External schemas are falsifiers/mechanism evidence, not SOUL taxonomy authority.

---

# 2. Metrology — result constitution bundles referent, values and qualification

## Source

JCGM/BIPM VIM 3:

- measurement result: https://jcgm.bipm.org/vim/en/2.9.html
- measurement uncertainty: https://jcgm.bipm.org/vim/en/2.26.html

## Structural observation

VIM defines a measurement result as a set of quantity values **attributed to a measurand together with other available relevant information**. It notes that a result is generally expressed with measurement uncertainty.

This packages several State questions together:

```text
measurand / referent
+ attributed value(s) / content
+ uncertainty / qualification
+ contextual relevant information
```

The result is not reduced to a bare value.

## Falsifier effect

A plausible `Content` vs `Qualification` child split is not forced here: uncertainty and attribution are part of what makes the measurement result usable/interpretable, while still being distinguishable facets.

**Effect:** strengthens leaf-with-explicit-dimensions; no child forced.

---

# 3. RDF 1.2 — reference, relation, object and assertion mode are structurally intertwined

## Sources

- RDF 1.2 Concepts and Abstract Data Model, W3C Candidate Recommendation Snapshot 7 Apr 2026: https://www.w3.org/TR/rdf12-concepts/
- RDF 1.2 Schema / triple-term reification: https://www.w3.org/TR/rdf12-schema/

RDF 1.2 is current Candidate Recommendation material, not yet the latest Recommendation baseline; it is used as a current falsifier, not sole authority.

## Structural observation

RDF graphs are sets of subject–predicate–object triples used to express descriptions of resources. The subject/predicate/object structure means what a statement is **about** and what it **says** are not cleanly separable child populations; they jointly constitute the statement.

RDF 1.2 triple terms add another useful distinction: a triple can be referenced as a proposition without that reference itself asserting the triple. Assertion mode depends on how the triple participates in the graph, not on creating a new universal object species.

## Falsifier effect

This pressures three candidate children:

- `Referent` cannot be cleanly separated from content semantics;
- `Mode/Stance` is decision-critical but can be modeled as a representational relation/status;
- `Representation form` is separate from the abstract graph structure but does not form a universal State child.

**Effect:** supports constitution facets rather than a stable child hierarchy.

---

# 4. RDF Dataset Canonicalization — equivalence is a relation over the whole constituted dataset

## Source

W3C Recommendation, RDF Dataset Canonicalization, 21 May 2024:

https://www.w3.org/TR/rdf-canon/

## Structural observation

The specification exists because the same RDF information can be serialized in different ways. Canonicalization transforms isomorphic datasets to the same canonical form; blank-node identifiers in concrete syntaxes are not themselves portable semantic identities.

## Falsifier effect

This is a strong holdout against promoting `Identity / Equivalence` as an independent child region:

- semantic/structural equivalence depends on the dataset as a whole;
- concrete identifiers/serialization can differ while represented information is equivalent;
- stable comparison requires an explicit equivalence criterion/algorithm;
- byte/identifier identity and informational identity are not the same.

Identity remains extremely load-bearing but behaves as a **comparison/individuation relation over constituted State**, not a disjoint State branch.

**Effect:** strengthens no-child result.

---

# 5. Web Annotation — target, selector, source state and scope compose one specific representation

## Source

W3C Recommendation, Web Annotation Data Model:

https://www.w3.org/TR/annotation-model/

## Structural observation

The model introduces `SpecificResource` to represent a more specific segment/state/use of a source resource. It can combine:

- source;
- selector;
- desired state/representation;
- scope;
- purpose;
- rendering/style constraints.

The specification explicitly notes that the identity of the SpecificResource is separate from the descriptions of its constraints.

## Falsifier effect

This directly attacks the idea that `reference/scope`, `identity`, and `qualification` are stable sibling children. In this domain they are composable constraints/relations that jointly specify **which informational target/state is intended**.

It also shows that a source resource and a specific state/segment/representation of it can require separate identity.

**Effect:** strong support for the leaf model; no universal child forced.

---

# 6. W3C PROV — identity is aspect-, time- and perspective-sensitive

## Sources

- PROV-DM: https://www.w3.org/TR/prov-dm/
- PROV Constraints: https://www.w3.org/TR/prov-constraints/

## Structural observation

PROV entities have fixed aspects for the interval in which they are described. `specializationOf` and `alternateOf` express cases where different entities fix more specific or different aspects of the same underlying thing. PROV explicitly notes that different provenance descriptions or perspectives may fix different aspects.

## Falsifier effect

This pressures a naive identity child:

- one underlying thing may be represented by multiple entities with different time/context/aspect boundaries;
- identity/sameness depends on which aspects are fixed;
- specialization/alternate relations are themselves cross-entity relations;
- attribution/provenance can differ without requiring a new semantic object taxonomy.

**Effect:** identity, temporal applicability and perspective remain mutually dependent constitution/relational dimensions; no child forced.

---

# 7. Verifiable Credentials 2.0 — content, subject, issuer, validity and status coexist; verification != truth

## Source

W3C Recommendation, Verifiable Credentials Data Model v2.0, 15 May 2025:

https://www.w3.org/TR/vc-data-model-2.0/

A v2.1 Working Draft exists in 2026, but v2.0 Recommendation is used here as the stable normative baseline.

## Structural observation

The credential model includes, among other properties:

- claims / credential subject;
- issuer;
- identifiers/types/context;
- validity period;
- credential status;
- schema/securing information.

The specification makes an especially important distinction:

> cryptographic/verifiable status and currency do not imply the truth of the claims; a verifier separately validates claims for a particular use under its own policies.

It also distinguishes issuer, holder, subject and verifier roles.

## Falsifier effect

This is a strong cross-domain case for keeping together but distinguishing:

```text
content / claims
referent / subject
source / issuer
currentness / validity / status
authenticity / verification
truth / use-specific validation
```

The model does not imply that `Standing`, `Source`, `Validity` or `Evidence` are independent informational object branches. They qualify/relate a credential and interact with external Actor/use policies.

**Effect:** strongly supports State qualification as explicit dimensions/relations without forcing an immediate child.

---

# 8. DCAT 3 — version, coverage, status and attribution are facets of dataset description

## Source

W3C Data Catalog Vocabulary (DCAT) Version 3:

https://www.w3.org/TR/vocab-dcat-3/

## Structural observation

DCAT describes datasets and series using recurring properties such as:

- temporal/spatial coverage and resolution;
- qualified attribution;
- status;
- version / current version / previous version / replacement;
- generation relations.

Dataset series group separately published datasets that share characteristics while differing, for example, by time or spatial footprint.

## Falsifier effect

This is another domain where State identity/currentness/coverage/source relations matter materially but remain **facets and relations around datasets/series** rather than a universal child taxonomy.

It also reinforces that version identity and temporal applicability are not one generic `timestamp` problem.

**Effect:** no missing child forced.

---

# 9. Cross-domain comparison

| Tradition | Reference/content jointly constituted? | Identity/equivalence relational? | Qualification/standing bundled? | Universal State child forced? |
|---|---:|---:|---:|---:|
| Metrology / VIM | yes — value attributed to measurand | use/context dependent | uncertainty/relevant info yes | no |
| RDF 1.2 | yes — subject/predicate/object | graph/term semantics | assertion mode can vary | no |
| RDF Canonicalization | whole-dataset equivalence | explicitly yes | n/a | no |
| Web Annotation | source/target/selector/scope compose specificity | explicitly separate identity + constraints | purpose/state/scope relations | no |
| W3C PROV | entity aspects define represented state | alternate/specialization relations | time/context/provenance matter | no |
| VC 2.0 | subject + claims | credential/claim identity distinct | issuer/validity/status/verification | no |
| DCAT 3 | dataset + coverage/description | versions/series relations | status/attribution/coverage | no |

The sources are not evidence that one universal data model exists. Their value is the opposite: **materially different domains package State constitution differently while repeatedly needing the same kinds of facets.**

---

# 10. Strongest falsifier candidates and outcome

## Candidate child — `Reference / Scope`

Rejected as universal child because RDF, annotations, credentials and measurements often make the subject/target/measurand part of the expressed state itself.

## Candidate child — `Identity / Equivalence`

Rejected as universal child because canonicalization, PROV and version/series models treat sameness/specialization/equivalence as relations over whole constituted resources/states under criteria.

## Candidate child — `Qualification / Standing`

Rejected provisionally as universal child because metrology and VC show qualifications can be essential to a state while truth/evidence/authority/use remain partly external/relational. Different domains package qualification differently.

## Candidate child — `Assertion / Claim`

Rejected as universal child because RDF 1.2 can reference a proposition without asserting it, and credentials distinguish claims from credential/verification status. Assertion mode is load-bearing but behaves as a mode/stance of representation.

## Candidate child — `Representation Form`

Rejected as universal child because RDF canonicalization directly shows different serializations can carry equivalent abstract information; form matters when interpretation/precision/identity demands it, but is not a disjoint first-order population.

---

# 11. N5 verdict

No examined external tradition forces a stable immediate child inside Informational State.

The strongest cross-domain convergence is:

> **A usable informational state is usually constituted by a coupled set of reference/applicability, content/interpretation/form, mode, identity/equivalence and qualification relations. Different disciplines factor these differently, but none of the examined factors forms a clean universal first-order partition.**

This strengthens the N3/N4 leading result:

```text
Informational State / Representational Constitution   ← bounded-leaf candidate strengthened

No immediate child promoted.
```

N6 must now run a same-model adversarial omission/reduction/rival audit, explicitly trying to defeat this no-split result rather than merely restating the supporting sources.
