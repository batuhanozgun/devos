# Domain Structure — Source / View Ledger

**Status:** preserved source/view ledger for bounded Structure pass; awaiting user evaluation  
**Date:** 2026-09-03  
**Scope:** Environment → Domain Reality → Domain State → Domain Structure

> **Pass provenance:** the inherited planning label was `Domain Structure / Composition`. Deeper research refines the bounded result to `Domain Structure` with two immediate candidate branches. This ledger records evidence used to discriminate/falsify that result; sources do not independently validate the project hierarchy.

---

# 1. Exact canonical pre-pass binding

This pass began from the following Domain State surfaces:

- parent `../STATE.md`: blob `9c72eb836c164d574fe36deeff1dbc8b0127993f`
- parent `../CURRENT-SURFACES.md`: blob `c4f190f9d11dfa97ab94e2ed351f1c74b64e2b2c`
- parent `../KEY.md`: blob `1c7ea731c2629a132d06a43ef3d9f9d90825c02e`
- parent `../FINDINGS-MAP.md`: blob `29d01710810399ce81b79051b1fb0840da13acf4`
- frozen Structure plan `../DOMAIN-STRUCTURE-RESEARCH-PLAN.md`: blob `fc402ad7dd0259cec4a831586766e0c1a1cfdad4`
- parent synthesis: blob `2fb261ec3a4522f8482421674d4c12e9c584eb9b`
- parent completion audit: blob `4564baf491b6f2b6a7465d26b19fc80ad1769348`
- preserved parent source ledger: blob `352c75725f8e19fc751cc60ba07cd37a0891e2b6`

The inherited result is evidence/history, not authority for the Structure decomposition.

---

# 2. Inherited project evidence

## A1 — Domain State parent package

Key paths:
- `../STATE.md`
- `../KEY.md`
- `../FINDINGS-MAP.md`
- `../findings/03-structure-composition-child.md`
- `../findings/04-condition-status-child.md`
- `../findings/05-identity-constraints-granularity-crosscut.md`
- `../findings/06-actual-vs-represented-state-boundary.md`
- `../findings/08-rival-decomposition-and-child-result.md`
- `../findings/09-domain-state-problem-map.md`
- `../synthesis/DOMAIN-STATE-SYNTHESIS.md`
- `../synthesis/COMPLETENESS-OMISSION-CHECK.md`
- `../OPEN-QUESTIONS.md`
- `../DEFERRED-RELATIONS.md`

Carries:
- bounded parent split `Structure / Composition` versus `Condition / Status`;
- initial Structure subproblem map: constituent presence, part-whole/nesting, relations/topology/arrangement, structural integrity;
- cross-cutting identity, constraints and granularity;
- actual-versus-represented boundary;
- explicit reopen condition if deeper Structure research cannot contain membership/composition/topology without forced fit.

Limitation:
- those Structure subregions were discovered, not themselves researched as children.

---

# 3. External source families

## B1 — Current SEBoK Structure glossary

Source:
- https://sebokwiki.org/wiki/Structure_(glossary)

Observed:
- SEBoK v2.14 (released 18 May 2026) includes definitions of structure as component layout/internal-external connections and as system elements plus relationships.

Discriminates:
- F1 node coherence;
- F2 constituents versus relational organization;
- parent-label choice.

Carries:
- evidence that `Structure` is broad enough to contain both constituents and their relations;
- supports moving `Composition` below the broad parent rather than using it as a full synonym.

Limitations:
- systems-engineering vocabulary, not universal ontology;
- some entries are architecture/design oriented and therefore representations/plans unless realized-state evidence is separately established.

## B2 — Stanford Encyclopedia of Philosophy: Mereology

Source:
- https://plato.stanford.edu/entries/mereology/

Currentness:
- substantive revision 27 June 2026.

Observed:
- mereology is explicitly devoted to parthood, part-to-whole and part-to-part relations;
- decomposition and composition principles form substantial independent areas.

Discriminates:
- F2 split versus merge;
- F3 spatial/part-whole ambiguity;
- adversarial objection that part-whole is itself a relation.

Carries:
- strong counterframe that constitution/part-whole is a coherent problem family in its own right;
- warning that the project split cannot be based on relation arity because parthood itself is formally relational.

Limitations:
- philosophical/formal ontology solves a different problem from this project's reasoning hierarchy;
- cannot by itself establish a project child.

## B3 — NIST SP 800-160v1r1: Engineering Trustworthy Secure Systems

Source:
- https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1r1.pdf

Observed:
- system described through arrangement of parts/elements and relationships/interactions;
- a general hierarchical representation is presented but NIST explicitly notes that not all systems, such as networks, are hierarchical;
- non-hierarchical systems need models reflecting relationships among constituent elements;
- a system element may itself be a system, enabling recursive nesting;
- interfacing systems exchange resources through interfaces, with one-way or bidirectional relations.

Discriminates:
- F2 membership/composition versus relation/topology;
- F4 hierarchy/nesting versus network/topology;
- F5 interfaces/boundaries/couplings;
- F9 scale/nesting;
- cross-domain infrastructure holdout.

Carries:
- hierarchy is a structural form, not a universal child;
- non-hierarchical relational organization remains necessary even when constituents are known;
- nested composition recurs across levels;
- interfaces can be structurally represented without requiring a standalone universal child.

Limitations:
- systems-engineering/security context;
- many claims concern models/design/realization processes, not direct observations of realized Domain Structure;
- used as discrimination evidence only after representation correction.

## B4 — NIST CPS / IoT unified components and interactions

Sources:
- https://www.nist.gov/publications/cyber-physical-systems-and-internet-things
- https://www.nist.gov/programs-projects/cyber-physical-systems-and-internet-things-foundations
- https://www.nist.gov/publications/framework-cyber-physical-systems-volume-1-overview

Observed:
- CPS/IoT can comprise interacting logical, physical, transducing and human components;
- NIST describes unified component and interaction perspectives and framework concerns including composition and boundaries.

Discriminates:
- F10 type-based children;
- hybrid holdout;
- composition/relationship distinction across heterogeneous component kinds.

Carries:
- heterogeneous physical/digital/human types can coexist inside one structure;
- type diversity does not force type-based universal children.

Limitations:
- framework/analysis methodology, not realized-state ontology;
- interaction can refer to behavior/dynamics as well as structural relation, so role correction is required.

## B5 — Kubernetes Service / live backend membership

Source:
- https://kubernetes.io/docs/concepts/services-networking/service/

Observed:
- Deployments create/destroy Pods dynamically;
- the actual Pod set can change moment to moment;
- Service defines a logical set of endpoints and access policy;
- EndpointSlices are updated as selected Pods change;
- health/readiness and membership/access are distinguishable operational concerns.

Discriminates:
- F2 composition versus relational organization;
- F6 presence/absence versus condition;
- F7 identity/continuity pressure;
- F11 actual versus represented;
- software holdout.

Carries:
- constituent membership can change independently of the abstraction clients use;
- a member-set problem can be distinguished from access/routing and from member health.

Limitations:
- Kubernetes API/control-plane objects are representations/control mechanisms, not runtime reality by identity;
- one software platform cannot define universal Structure semantics.

## B6 — NASA configuration management / configuration audits

Sources:
- https://www.nasa.gov/reference/6-5-configuration-management/
- https://nodis3.gsfc.nasa.gov/displayAll.cfm?Internal_ID=N_PR_7123_001B_&page_name=ALL

Observed:
- NASA distinguishes product/as-deployed baselines and configuration-status documentation;
- configuration verification/audits inspect documents, products and records;
- requirements explicitly call for confirming that actual work-product configuration matches documented configuration.

Discriminates:
- F11 representation boundary;
- actual constituent/relationship structure versus baseline/architecture/inventory.

Carries:
- strong operational evidence that actual realized configuration and documentation can diverge;
- a baseline is therefore not actual Domain Structure by identity.

Limitations:
- engineered-product/configuration-management domain;
- audit processes establish comparison requirements, not a universal Structure taxonomy.

## B7 — OGC GeoSPARQL 1.1 / spatial topology

Sources:
- https://www.ogc.org/standards/geosparql/
- https://docs.ogc.org/is/22-047r1/22-047r1.html

Observed:
- GeoSPARQL defines standard topological/spatial relation families;
- RCC8 relations include equality, disconnection, external connection, partial overlap and proper-part variants;
- other families include touches, within, contains, crosses, intersects and overlaps.

Discriminates:
- F3 Spatial Arrangement / Containment as standalone child;
- part-of versus spatial relation ambiguity.

Carries:
- spatial organization is a rich relation family that cannot be reduced casually to simple constituent membership;
- supports keeping spatial structure explicit inside Relational Organization rather than promoting a universal third child.

Limitations:
- semantic/geospatial representation standard;
- describes formal predicates, not direct realized-world evidence.

## B8 — Supply Chain Reference Ontology / network representation

Source:
- https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=928051

Observed:
- supply chains represented as networks;
- partnering organizations represented as nodes;
- edges denote material/information flows;
- a particular supply chain can be defined as a group of organizations participating in production of a specific product.

Discriminates:
- F2 membership/participation versus links;
- F5 flow/link versus Dynamics boundary;
- market/supply-network holdout.

Carries:
- participating organization set and relation/flow structure are separately recoverable aspects;
- supports non-physical network holdout.

Limitations:
- ontology/modeling paper; network representation is not the supply chain itself;
- flows are occurrents in the source ontology and therefore must not be collapsed into standing Structure in this project.

## B9 — SEC market-structure material

Sources:
- https://www.sec.gov/featured-topics/market-structure-analytics/research-analysis-market-structure
- https://www.sec.gov/newsroom/speeches-statements/2014-spch060514mjw

Observed:
- equity trading is fragmented across multiple venues;
- SEC material discusses proliferation of venues, interconnectedness and order routing;
- current market-structure analytics remains an active SEC research area.

Discriminates:
- cross-domain non-physical holdout;
- constituent venues versus interconnection/routing structure.

Carries:
- market `structure` cannot be reduced to participant/venue inventory alone;
- correct participant set and wrong routing/interconnection remain distinct analytical possibilities.

Limitations:
- regulatory/market-specific usage;
- older speeches support background while the analytics page confirms continued current relevance;
- market quality belongs Condition and must not be merged into Structure.

## B10 — Stanford Encyclopedia of Philosophy: Social Institutions

Source:
- https://plato.stanford.edu/entries/social-institutions/

Observed:
- roles, rules and other simpler social forms can be constitutive elements of institutions;
- many institutions are organizations or systems of organizations;
- the entry discusses structured/unitary institutions and relations among institutions while separately addressing agency/power.

Discriminates:
- F12 institutional Structure versus Actors/Information;
- F10 type-based children;
- social/institutional holdout.

Carries:
- institutional structure can be realized and structurally relevant without all authority/agency semantics becoming Structure;
- type-specific Structure child is unnecessary.

Limitations:
- philosophical accounts of institutions are contested;
- institutional facts can be socially constituted by rules/acceptance, so `actual ≠ representation` must not be overstated as metaphysical independence from all representational practices.

## B11 — Biology / ecology structure and interaction networks

Sources:
- https://www.nature.com/articles/s44358-025-00056-7
- https://www.nature.com/articles/s44358-026-00159-9
- https://pmc.ncbi.nlm.nih.gov/articles/PMC8990247/
- https://www.nature.com/scitable/knowledge/community-ecology-13228209/

Observed:
- recent ecological-network work distinguishes how nodes/species are aggregated from what information links carry;
- 2026 review work describes ecological-network rewiring and separates topology from interaction strength;
- biological-structure literature defines structure through arrangement of components, including interactions/connections and spatial positions across levels;
- community ecology treats communities through species and networks of influence/interactions.

Discriminates:
- F2 across non-engineered domains;
- F3 spatial arrangement;
- F4 hierarchy/network forms;
- F9 multi-scale;
- biological/ecological holdout.

Carries:
- composition/species participation and relational organization both matter;
- structural relations can change even with overlapping constituent sets;
- scale is recurrent but not an independent child.

Limitations:
- ecological networks are often inferred/represented rather than exhaustively observed;
- `interaction` can refer to Dynamics, not merely standing Structure;
- biological literature varies in terminology and level.

## B12 — Network-topology counterframes

Sources:
- https://technav.ieee.org/area/network-topology/
- https://www.cisco.com/site/us/en/learn/topics/networking/what-is-network-topology.html
- https://www.rfc-editor.org/rfc/rfc8345.html

Observed:
- network-topology sources often define topology as arrangement of nodes **and** links/connections;
- RFC 8345 topology data models explicitly contain nodes, edges/links and termination points.

Discriminates:
- label validity of `Relational Organization / Topology`;
- adversarial challenge that topology itself includes membership-like elements.

Carries:
- warning that `Topology` cannot be the formal boundary-defining term for the project child;
- supports using `Relational Organization` as the primary semantic label, with `Topology` only an explanatory companion.

Limitations:
- computer-network/design/data-model context;
- does not undermine a semantic failure/recovery split between participant set and organization.

## B13 — Mereotopology counterframe

Source:
- https://www.sciencedirect.com/science/article/pii/S0169023X96000171

Observed:
- formal mereotopology explores ways of combining parthood and topological wholeness/connectedness, including accounts where one has priority or where both are independent but related.

Discriminates:
- strongest merge counterframe against the two-child result;
- F2 split/merge;
- F3 part-whole versus topology.

Carries:
- formal unification of part-whole and topology is possible;
- therefore project separation must not be presented as primitive ontology;
- the project split survives only because it protects different reasoning/recovery questions.

Limitations:
- 1996 formal ontology paper;
- source age is acceptable for the stable conceptual counterframe but gives no current empirical evidence.

---

# 4. Pass evidence trajectory

## Early phase

Inherited evidence suggested a broad Structure node combining constituents and relations.

Fresh coherence search confirmed:
- `Structure` remains broad and stable enough;
- `Composition` is too narrow as a full parent synonym;
- mereology/assembly/member-set questions have independent content;
- systems/network sources make relational organization independently necessary.

## Middle phase

The strongest candidate became:

```text
Domain Structure
    ├─ Constituent Composition / Membership
    └─ Relational Organization / Topology
```

Third-child probes tested:
- spatial structure;
- hierarchy versus network;
- interfaces/boundaries/couplings;
- identity;
- constraints;
- scale/granularity;
- type-based branches.

These mostly mapped to the two children or remained cross-cutting.

## Late adversarial phase

New challenge sources exposed terminology ambiguity rather than a missing child:
- `Topology` can include nodes + links;
- part-whole is itself formally a relation;
- mereotopology can unify part-whole and connectedness.

These challenges corrected the interpretation:
- the split is **not** relation arity, node/edge primitives or ontology;
- `Relational Organization` is the semantic primary label;
- the children are retained because constituent-set and organization failures independently alter diagnosis/recovery.

No late source forced a third universal Structure-local region or parent reopen.

---

# 5. Bounded source judgment

The current source set is sufficiently diverse for the immediate-child discovery purpose:
- systems engineering;
- formal ontology/philosophy;
- software/runtime systems;
- configuration management;
- geospatial topology;
- manufacturing/system nesting;
- supply networks;
- financial markets;
- social institutions;
- biology/ecology;
- hybrid CPS/IoT;
- network-data-model counterframes.

Further broad search now has lower expected information gain than targeted future research on the two discovered children or independent verification.

No source independently validates the project hierarchy. The same-model completion audit remains non-independent.
