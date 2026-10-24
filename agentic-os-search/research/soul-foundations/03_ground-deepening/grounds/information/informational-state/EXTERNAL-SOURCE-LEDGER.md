# Informational State / Representational Constitution — External Source Ledger

**Status:** N5 source ledger  
**Observation date:** 2026-09-05  
**Purpose:** exact external source routing for load-bearing State claims

External models below are used as **falsifiers, structural evidence and holdout cases**. They are not imported as Foundation taxonomy authority.

## S1 — JCGM/BIPM VIM 3: measurement result

- URL: https://jcgm.bipm.org/vim/en/2.9.html
- Source type: international metrology vocabulary / authoritative terminology surface
- Stable observation used:
  - measurement result = quantity values attributed to a measurand together with other available relevant information;
  - result is generally expressed with measurement uncertainty.
- Research role:
  - tests referent + content + qualification bundling;
  - falsifies bare-value and universal Content-vs-Qualification partition assumptions.
- Freshness: conceptually stable; exact wording/source should be rechecked if quoted.

## S2 — JCGM/BIPM VIM 3: measurement uncertainty

- URL: https://jcgm.bipm.org/vim/en/2.26.html
- Source type: international metrology vocabulary
- Stable observation used:
  - uncertainty characterizes dispersion of values attributed to a measurand based on information used.
- Research role:
  - uncertainty is state-significant but attached to interpreted measurement/result context rather than a disjoint informational kind.

## S3 — W3C RDF 1.2 Concepts and Abstract Data Model

- URL: https://www.w3.org/TR/rdf12-concepts/
- Current publication observed: Candidate Recommendation Snapshot, 2026-04-07
- Source type: W3C standards-track current specification
- Stable observation used:
  - RDF graph = set of subject-predicate-object triples;
  - triples express descriptions/relationships of resources;
  - abstract structure can be encoded using different concrete syntaxes.
- Research role:
  - tests reference/content coupling and form-vs-abstract-information distinctions.
- Freshness caveat:
  - RDF 1.2 is not yet the latest Recommendation baseline; do not treat current CR details as immutable.

## S4 — W3C RDF 1.2 Schema / triple-term reification

- URL: https://www.w3.org/TR/rdf12-schema/
- Current publication observed: 2026 standards-track material
- Source type: W3C current specification
- Stable observation used:
  - a triple term can refer to a proposition without itself asserting that proposition;
  - assertion depends on whether the triple is asserted in the graph.
- Research role:
  - falsifies `claim text/content = assertion status` collapse;
  - supports mode/stance as representational relation/status.
- Freshness caveat: standards-track 1.2 material; revalidate exact status later.

## S5 — W3C RDF Dataset Canonicalization

- URL: https://www.w3.org/TR/rdf-canon/
- Publication: W3C Recommendation, 2024-05-21
- Source type: W3C Recommendation
- Stable observation used:
  - same information can occur in different serializations;
  - canonicalization produces the same canonical result for isomorphic datasets;
  - concrete blank-node identifiers are not portable semantic identities.
- Research role:
  - strong identity/equivalence holdout;
  - distinguishes byte/syntax identity from abstract informational equivalence.

## S6 — W3C Web Annotation Data Model

- URL: https://www.w3.org/TR/annotation-model/
- Source type: W3C Recommendation
- Stable observation used:
  - `SpecificResource` combines source with constraints such as Selector, State, Scope and Purpose;
  - identity of the SpecificResource is separate from descriptions of those constraints;
  - States can identify a desired representation/version of a changing resource.
- Research role:
  - tests referent/scope/identity/qualification composition;
  - strong holdout against treating those as universal sibling State children.

## S7 — W3C PROV-DM

- URL: https://www.w3.org/TR/prov-dm/
- Source type: W3C Recommendation
- Stable observation used:
  - entities have fixed aspects;
  - specialization and alternate relations can describe different aspects/versions of the same underlying thing.
- Research role:
  - tests identity, aspect/context and version/specialization semantics;
  - preserves entity vs activity separation inherited from parent Information.

## S8 — W3C PROV Constraints

- URL: https://www.w3.org/TR/prov-constraints/
- Source type: W3C Recommendation companion constraint model
- Stable observation used:
  - different entities/perspectives may fix different aspects of the same thing;
  - entity attributes are expected to hold over an entity duration;
  - changing relevant aspects may require multiple entity descriptions.
- Research role:
  - tests temporal/perspective-sensitive individuation and specialization.

## S9 — W3C Verifiable Credentials Data Model v2.0

- URL: https://www.w3.org/TR/vc-data-model-2.0/
- Publication: W3C Recommendation, 2025-05-15
- Current family note: a v2.1 Working Draft exists as of 2026; v2.0 is used as stable Recommendation baseline.
- Source type: W3C Recommendation
- Stable observations used:
  - credential expresses claims about subject(s) and has issuer/validity/status/schema/securing properties;
  - issuer, holder, subject and verifier are distinct roles;
  - verification checks authentic/current statement properties but does **not** imply truth of claims;
  - validation/reliance is use/policy-specific.
- Research role:
  - strong qualification/standing/truth/authority anti-collapse holdout.

## S10 — W3C DCAT Version 3

- URL: https://www.w3.org/TR/vocab-dcat-3/
- Source type: W3C Recommendation/data-catalog vocabulary
- Stable observations used:
  - dataset descriptions can carry temporal/spatial coverage, qualified attribution, status, versions, current/previous version and generation relations;
  - dataset series group related releases with differing characteristics such as time/spatial footprint.
- Research role:
  - tests version/currentness/coverage/attribution as facets around data resources rather than a universal State child structure.

## Source diversity note

The corpus deliberately spans materially different problem traditions:

- metrology/measurement;
- semantic/graph representation;
- canonical identity/equivalence;
- web annotation/targeting;
- provenance/version/aspect modeling;
- digital credential claims/trust/currentness;
- dataset lifecycle/catalog description.

Several W3C sources share institutional provenance but represent different technical traditions and are paired with independent metrology evidence. The result remains bounded, not universal proof.

## Verification boundary

N5 source recovery increases falsifier coverage and source fidelity. It does **not** independently verify the final Foundation decomposition. N6 remains same-model adversarial review unless a genuinely independent reviewer/model is later introduced.
