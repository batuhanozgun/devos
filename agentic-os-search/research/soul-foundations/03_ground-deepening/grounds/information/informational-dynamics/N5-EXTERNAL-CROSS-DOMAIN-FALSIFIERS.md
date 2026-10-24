# Informational Dynamics / Formation–Transformation — N5 External and Cross-Domain Falsifiers

**Status:** COMPLETE; leading three-child split survives materially different external traditions  
**Date:** 2026-09-05  
**Dependency:** `N4-BOUNDARY-ANTI-COLLAPSE.md`

## 1. Purpose

N5 asks whether materially different traditions expose:

- a missing first-order Dynamics branch;
- a collapse among Formation, Derivation/Transformation and Selection/Exposure;
- a reason to promote Revision, Communication, Propagation or Persistence as a fourth peer;
- or evidence that the Dynamics node itself is wrongly framed.

External taxonomies are falsifiers and mechanism evidence, not imported Foundation structure.

## 2. Metrology — measurement process vs result

Sources:

- JCGM/BIPM VIM 2.1 Measurement: https://jcgm.bipm.org/vim/en/2.1.html
- VIM 2.3 Measurand: https://jcgm.bipm.org/vim/en/2.3.html
- VIM 2.9 Measurement Result: https://jcgm.bipm.org/vim/en/2.9.html

Structural observation:

- measurement is a process of obtaining values;
- the intended measurand is distinct from the process/system and may itself be perturbed by measurement;
- the measurement result is a result attributed to the measurand with relevant information.

Falsifier effect:

This strongly supports a distinct **Formation / Acquisition** problem region. A result can be well-formed while the acquisition relation/procedure is biased or inappropriate.

It does not force acquisition into a broader generic transformation branch without losing observability/sampling/source-interface failures.

**Effect:** strengthens C1.

## 3. W3C PROV — generation vs derivation/change

Sources:

- PROV-DM: https://www.w3.org/TR/prov-dm/
- PROV Constraints: https://www.w3.org/TR/prov-constraints/

Structural observation:

PROV distinguishes entities and activities and separately models generation, use, invalidation and derivation. Generation concerns the production/availability of an entity; derivation connects an entity to pre-existing entities through transformation/update/construction relations.

Falsifier effect:

This independently supports the difference between:

- formation/generation of an informational entity/state;
- state-to-state derivation/transformation.

Invalidation shows that lifecycle/availability effects are real, but it does not force a universal fourth branch; invalidation is entangled with entity lifetime and activities within provenance semantics.

PROV's own `communication` relation is provenance-specific and should not be treated as proof that all communication belongs to one universal child.

**Effect:** strengthens C1/C2; no fourth child forced.

## 4. Belief revision — specialized state-to-state change

Source:

- Stanford Encyclopedia of Philosophy, Logic of Belief Revision, substantive revision 2026-07-29: https://plato.stanford.edu/entries/logic-belief-revision/

Structural observation:

Belief revision theory distinguishes belief states/bases from operations such as contraction, expansion, revision and update. The literature itself distinguishes reasons/types of change rather than collapsing all of them into one generic update.

Falsifier effect:

This supports a first-order **Derivation / Transformation** region and confirms that revision can have deep specialist semantics.

However, those operation families are specific to epistemic belief-change problems and do not generalize cleanly into universal Dynamics siblings beside acquisition and selection/exposure.

**Effect:** strengthens C2; weakens `Revision` as universal fourth child.

## 5. Information retrieval — selection relative to an information need

Sources:

- NIST TREC How To TREC: https://trec.nist.gov/howto.html
- TREC relevance judgments: https://trec.nist.gov/data/reljudge_eng.html

Structural observation:

TREC explicitly distinguishes:

- a topic/information need;
- the query expressing that need;
- a document collection;
- a retrieval-system run producing ranked documents;
- relevance judgments relative to the topic.

The underlying documents can remain unchanged while a different query/system/ranking exposes a different result set.

Falsifier effect:

This is a strong independent holdout for **Selection / Exposure**. The failure question is not whether source states were correctly formed or transformed, but whether the right existing information became visible for a use and with what coverage/ranking.

It also shows that relevance is use-relative, warning against reifying relevance as an intrinsic State type.

**Effect:** materially strengthens C3 and rejects the two-child Formation-vs-Transformation rival.

## 6. Web Annotation — source, selector and intended representation

Source:

- W3C Web Annotation Data Model: https://www.w3.org/TR/annotation-model/

Structural observation:

The model distinguishes a source resource from a SpecificResource, Selectors that determine a desired segment, and State descriptions used to retrieve an intended representation/version of a changing source.

A Selector can identify a segment without modifying the source resource itself.

Falsifier effect:

This reproduces the structural distinction behind C3:

```text
source representation exists
    ≠ which segment/representation is selected for a use
```

It also confirms that selection can depend on state/version recovery without becoming content derivation.

**Effect:** strengthens C3 and the State-vs-selection boundary.

## 7. Records lifecycle — strong specialization, weak universal child candidate

Sources:

- NARA Records Basics: https://www.archives.gov/records-mgmt/scheduling/basics
- 44 U.S.C. Chapter 29 via NARA: https://www.archives.gov/about/laws/records-management.html

Structural observation:

Federal records management distinguishes creation/receipt, maintenance/use and disposition. Maintenance/use includes storage, retrieval and handling; disposition includes destruction/transfer.

Falsifier effect:

At first glance this could suggest a lifecycle-based Dynamics hierarchy. But the categories are explicitly scoped to records management and persistence/custody obligations.

Mapped structurally:

- creation/receipt can involve C1;
- maintenance/change can involve C2;
- retrieval/use can involve C3;
- disposition activates Records-specific obligations and may change availability/existence.

**Effect:** strengthens persistence as a cross-cutting specialization/profile rather than a fourth universal Dynamics child.

## 8. Cross-domain comparison

| Tradition | Formation / Acquisition | Derivation / Transformation | Selection / Exposure | Fourth universal child forced? |
|---|---:|---:|---:|---:|
| Metrology | strong | correction/modeling can occur | weak/conditional | no |
| W3C PROV | generation | derivation/transformation/invalidation | communication/use conditional | no |
| Belief revision | input/new information conditional | strong state-change operations | not primary | no |
| NIST TREC | collection/input assumed | query processing may transform | strong ranked selection | no |
| Web Annotation | source capture conditional | representation/state recovery conditional | strong selector/specific-resource semantics | no |
| Records lifecycle | creation/receipt | maintenance/change | retrieval/use | persistence-specific disposition, not universal |

The convergence is structural, not terminological.

## 9. Strongest external falsifier against the leading split

The strongest challenge is that many real operations span branches:

- retrieving an external source can both acquire and select;
- communicating can expose and create a receiver-side copy;
- correction can derive a new state and trigger downstream re-selection;
- persistence lifecycle can include all three.

External traditions do not resolve this by giving mutually exclusive event types. Instead they repeatedly distinguish **roles/relations/process questions** around the same event.

This supports N4's rule:

> branch routing must follow the protected informational question and reference frame, not the operation verb.

Overlap of events therefore does not by itself collapse the branches.

## 10. N5 verdict

No examined external tradition forces a fourth stable universal Dynamics child or collapses the leading three-child split.

The strongest bounded structure remains:

```text
Informational Dynamics
    ├─ Informational Formation / Acquisition
    ├─ Informational Derivation / Transformation
    └─ Informational Selection / Exposure
```

External evidence improves falsifier diversity but does not prove universality. Proceed to N6 same-model omission/reduction/rival audit.
