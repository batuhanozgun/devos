# Constituent Composition — Source / View Ledger

**Status:** substantive-pass source/view ledger  
**Date:** 2026-09-04  
**Selected node at pass start:** `Constituent Composition / Membership`  
**Frozen plan:** `../CONSTITUENT-COMPOSITION-MEMBERSHIP-RESEARCH-PLAN.md` @ `eac741f457d0505830cafbafa80a4534c510507f`

## Source rule

External sources are used to discriminate live rivals, not to import an ontology/taxonomy as the project answer.

The pass distinguishes:
- actual constituent composition;
- representations/specifications/registries of composition;
- source vocabulary from project semantic role.

## Canonical project inputs

| Role | Surface | Bound SHA / status |
|---|---|---|
| Root pre-pass state | `../../../../../../../STATE.md` | `b25e4c381a1603805e2db331dc76bc8fa192f6a7` |
| Ground Deepening pre-pass state | `../../../../../../STATE.md` | `a1a3b8f0c626d9b3f5b17d5ad97ec61cef2b8a59` |
| Environment pre-pass state | `../../../../../STATE.md` | `220cdba418dd0d867709ce20288407ade716deb0` |
| Environment completion review | `../../../../../completion-review/CURRENT-SURFACES.md` | `447f3e79b2b7e38b51c37665d0b8e1490c125889` |
| Structure parent pre-pass state | `../STATE.md` | `a69e73f90e2714ab8945529d309db99fedfda6be` |
| Structure parent key | `../KEY.md` | `9815af79146027447a02b4e654b8797edc6bf424` |
| Structure freshness | `../CURRENT-SURFACES.md` | `8bd8d0b1e7e26f10d007d4e2c3702f0787d25619` |
| Structure residual questions | `../OPEN-QUESTIONS.md` | `a7a94666fac213c5fecc55086afaa14affd93d19` |
| Promoting finding | `../findings/02-composition-membership-child.md` | `27842a0cc64b242c2ca4b5d2b00227b757c22a4e` |
| Hierarchical method | `../../../../../HIERARCHICAL-DEEPENING-METHOD.md` | `4d964c09a70ebe5f114d597f5413b41193ce650b` |

These bindings are historical pass inputs. Later current-state propagation must not replace them.

## External sources / views

### 1. Stanford Encyclopedia of Philosophy — Mereology
Canonical URL: https://plato.stanford.edu/entries/mereology/  
Current view used: substantive revision 27 June 2026.

Decision use:
- parthood is a substantive relation family;
- ordinary `part` language also covers material constitution, mixture composition and group membership, but their mereological status is disputed;
- group membership is explicitly treated by some accounts as fundamentally distinct from parthood.

Discrimination value:
- strongly rejects treating `part-of`, constitution, mixture and group membership as one primitive relation by vocabulary alone;
- also weakens a simple universal two-child `parthood vs membership` split because the relation space contains additional contested forms.

### 2. SEBoK v2.14 — System Element glossary
Canonical URL: https://sebokwiki.org/wiki/System_Element_%28glossary%29  
Release view: SEBoK v2.14, 18 May 2026.

Decision use:
- a system element is described as a member of a set of elements that constitutes a system;
- element kinds can include hardware, software, data, humans, processes, procedures, facilities, materials and natural entities.

Discrimination value:
- independent systems-engineering counterframe showing membership and composition can share one higher constituent question without requiring type-based children.

### 3. SEBoK / ISO/IEC/IEEE 21839 — Systems of Systems
Canonical URL: https://sebokwiki.org/wiki/Systems_of_Systems_%28SoS%29  
Related standard surface: https://www.iso.org/standard/71955.html

Decision use:
- constituent systems can participate in one or more SoS;
- constituents remain useful systems in their own right;
- SoS formation need not be permanent.

Discrimination value:
- challenges integral-physical-parthood assumptions;
- supports simultaneous, autonomous and temporary constituency as scope/time semantics inside the node rather than a new universal child by itself.

### 4. OMG SysML v2.0 Language Specification
Canonical URL: https://www.omg.org/spec/SysML/2.0/Language/PDF

Decision use:
- distinguishes composite from referential usages;
- supports multiplicity/cardinality on usages;
- examples distinguish integral vehicle wheels from a referential road.

View warning:
- this is a modeling language/specification, not evidence that a modeled composition equals actual composition.

Discrimination value:
- shows that composition relation semantics and multiplicity are separable modeling concerns;
- does not by itself justify project children.

### 5. Kubernetes EndpointSlice documentation
Canonical URLs:
- https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/
- https://kubernetes.io/docs/reference/kubernetes-api/discovery/endpoint-slice-v1/

Decision use:
- EndpointSlices represent a set of Service endpoints selected from Pods;
- endpoint conditions such as `ready`, `serving`, `terminating` are represented separately.

View warning:
- EndpointSlice is a representation/control-plane object, not the underlying actual structure by identity.

Discrimination value:
- operational counterframe for membership-set versus current Condition separation;
- supports treating present-but-not-ready separately from absent/non-member.

### 6. W3C Organization Ontology
Canonical URL: https://www.w3.org/TR/2013/CR-vocab-org-20130625/

Decision use:
- separates direct organizational membership from role/post structure;
- supports a membership relation with role and optional duration;
- posts can exist independently of current holders.

View warning:
- ontology/representation, not project-tree authority.

Discrimination value:
- challenges collapse of membership into Actor role/authority;
- shows temporal validity can qualify membership without requiring a new parent problem by itself.

### 7. Stanford Encyclopedia of Philosophy — Social Ontology
Canonical URL: https://plato.stanford.edu/entries/social-ontology/

Decision use:
- social groups may persist through membership change;
- set, fusion, parthood, constitution and structured-group accounts remain contested;
- the classic transitivity objection illustrates why a person's bodily parts do not automatically become group members.

Discrimination value:
- strong warning against transferring mereological inference rules to group membership;
- supports preserving relation semantics explicitly while avoiding premature universal ontology choice.

### 8. Basic Formal Ontology / OBO Relation Ontology counterframe
Canonical surfaces:
- https://github.com/BFO-ontology/BFO/blob/master/bfo_classes_only.obo
- https://oborel.github.io/obo-relations/temporal-semantics/
- https://github.com/oborel/obo-relations/blob/master/ro-full.obo

Decision use:
- BFO models object aggregates using `member_part` semantics;
- OBO notes that continuant parthood can change over time and should be interpreted with temporal care.

View warning:
- formal ontology implementation is a counterframe, not independent validation of the project hierarchy.

Discrimination value:
- prevents claiming that membership must always be non-mereological;
- shows temporal qualification is not unique to social/open membership.

### 9. Ecological-community counterframes
Sources:
- Looijen & van Andel, *Ecological communities: conceptual problems and definitions* (1999): https://www.sciencedirect.com/science/article/pii/S1433831904700244
- Anderson et al. discussion of presence/absence vs relative abundance in beta diversity (2011): https://doi.org/10.1111/J.1461-0248.2010.01552.X
- Stroud et al. review of community definitions (2015): https://pmc.ncbi.nlm.nih.gov/articles/PMC4662321/

Decision use:
- community membership need not require interaction;
- ecological boundaries can be non-discrete/scale-sensitive;
- presence/absence and abundance carry different analytical information.

Discrimination value:
- strong boundary test against collapsing composition into topology/interactions;
- boundary/scale ambiguity behaves like reference selection rather than a stable new child;
- abundance vocabulary is a warning that external `composition` terminology can include quantitative Condition-like values.

### 10. IUPAC Gold Book 5th edition (2025 online)
Canonical terms:
- amount fraction: https://goldbook.iupac.org/terms/view/A00296
- component: https://goldbook.iupac.org/terms/view/C01209
- fraction: https://goldbook.iupac.org/terms/view/F02494

Decision use:
- a mixture has constituents/components and can be described through amount/mass/volume fractions.

Discrimination value:
- exposes continuous/non-token composition cases;
- also forces the Structure–Condition boundary: a constituent identity question and a realized concentration/fraction value need not belong to the same project branch merely because chemistry calls both composition.

### 11. NASA Systems Engineering Handbook — Configuration Management
Canonical URL: https://www.nasa.gov/reference/6-5-configuration-management/

Decision use:
- configuration management aims to keep product information consistent with actual/approved product configuration;
- NASA explicitly distinguishes the product/configuration from its documentation and baselines.

Discrimination value:
- strong actual-versus-represented composition boundary;
- a BOM/configuration record is evidence/model, not the actual constituent composition by identity.

### 12. NIST SBOM glossary
Canonical URL: https://csrc.nist.gov/glossary/term/software_bill_of_materials

Decision use:
- an SBOM is a formal record enumerating software components used in building software.

Discrimination value:
- reinforces representation boundary; enumeration record is not automatically the currently deployed constituent set.

### 13. Supply-chain network counterframes
Sources:
- Perera, Bell & Bliemer (2017), Applied Network Science: https://link.springer.com/article/10.1007/s41109-017-0053-0
- 2026 Applied Network Science topology study: https://link.springer.com/article/10.1007/s41109-026-00785-4

Decision use:
- firms are modeled as nodes and transactional relations as links;
- network boundary/subnetwork context affects which firms count in a selected network.

Discrimination value:
- membership/participant-set and relational topology remain analytically distinguishable even when membership can be inferred from relational evidence.

## Verification status

This ledger supports a **same-model cross-source synthesis**. No listed source independently validates the exact SOUL research hierarchy or the eventual node label/leaf judgment.
