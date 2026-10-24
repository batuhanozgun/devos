# Records / Persistent Information — Vertical Synthesis

**Status:** sufficiently complete for current foundation purpose  
**Date:** 2026-09-01  
**Scope:** consolidated first-principles Records / persistent-information research; not a SOUL architecture, schema or implementation decision.

## 0. What this synthesis is

This document consolidates the bounded results of the Records vertical after:

1. foundational recordhood research;
2. object-boundary / artifact / identity research;
3. minimum preservation-closure research;
4. change / status / temporal research;
5. organisation / derived-view / retrieval research;
6. recurrent requirement-profile derivation;
7. mechanism-pattern landscape comparison;
8. retention / appraisal / disposition research;
9. vertical completeness / omission red-team.

It does **not** claim a universal records ontology or complete records-management standard.

The purpose is to make later SOUL research/design unable to silently assume simplistic persistence semantics such as:

- `record = file`;
- `store forever = safe`;
- `current row = enough`;
- `versioning = history solved`;
- `search hit = authoritative/current`;
- `metadata = fields embedded in object`;
- `delete = object disappeared from primary UI`.

---

# 1. Core domain result

The strongest current working frame is:

> **Records research concerns persistent information-bearing resources and the contextual roles, identities, histories, relationships, preservation obligations, access structures and governed lifecycle semantics required for those resources to remain correctly interpretable/reconstructable/retrievable for stated purposes over time.**

`Persistent information resource` remains a working umbrella label, not a final ontology term.

`Record` is narrower than `persistent information resource` in the current evidence.

A provisional recordhood synthesis is:

> **A record is a persistent/recoverable information representation whose relation to an activity/occurrence/context and continuing recordkeeping/reference/evidence/accountability/information function gives it record status/meaning.**

Recordhood is therefore not adequately explained by bytes, file extension, row shape or mere persistence.

---

# 2. Object / identity model — anti-collapse rules

The evidence is strong enough to keep these dimensions separate when relevant:

```text
higher-level information/resource identity
    ├─ version / revision identity
    │    └─ representation / instantiation / copy
    ├─ semantic derivation / derived resource
    └─ aggregation / set / contextual grouping

record role/status can apply contextually over these identities
```

This is not a required class hierarchy.

## Load-bearing distinctions

- resource identity ≠ version identity;
- version identity ≠ representation/copy identity;
- same bits ≠ same record status;
- new file ≠ automatically new record/version;
- representation migration ≠ semantic derivation;
- derivation ≠ revision;
- aggregation/order can carry independent meaning;
- current/designated standing ≠ historical existence;
- authenticity/integrity ≠ factual correctness.

## `Artifact`

Unqualified `artifact` is not retained as the foundational super-category because it has incompatible meanings across archives, software, forensics and other domains.

Qualified concepts such as `information artifact` remain valid where their ontology is explicit.

The repository path `records-artifacts/` remains historical/provisional until later synthesis justifies a rename.

---

# 3. Persistence result — minimum preservation closure

The research rejected one universal object-local metadata envelope.

The stronger architecture-neutral concept is:

> **Minimum preservation closure** = the smallest set of information, relationships, interpretive dependencies, controls and reliable bindings required for a specified future use of a specified resource class at a specified horizon/risk level.

The closure boundary is logical, not necessarily physical.

Required knowledge may be:

- embedded in the representation;
- externally linked;
- represented in relation/provenance structures;
- inherited from controlled aggregate/system context;
- supplied by preserved rules;
- deterministically reconstructable from preserved inputs.

External/inherited/reconstructable knowledge is sufficient only while its binding, version, interpretability, availability and transfer/materialisation requirements remain protected.

## Recurring obligation families

When activated by a profile, requirements can concern:

1. referential identity / exact binding;
2. interpretability / representation information;
3. origin / provenance / contextual history;
4. temporal / version / standing reconstructability;
5. integrity / continuity assurance;
6. relations / aggregation / derivation;
7. rights / access / use constraints;
8. organisation / descriptive/access views;
9. retrieval sufficiency / coverage/freshness;
10. retention / disposition history;
11. transfer / portability / dependency survivability;
12. preservation objectives / significant properties under transformation.

These are **obligation families, not mandatory fields/components**.

---

# 4. Change / status / temporal result

Generic `update`, one universal status enum and one universal timestamp are not adequate for evolving persistent information.

## Change kinds that can differ semantically

- creation/generation;
- capture/registration;
- revision/versioning;
- representation migration/re-instantiation;
- semantic derivation;
- supersession;
- correction;
- retraction/reliance withdrawal;
- access removal;
- transfer/custody change;
- destruction/disposition.

The vocabulary is source/domain dependent. The load-bearing issue is the **semantic effect**, not the label.

## Standing/status is multidimensional

When relevant, distinguish:

- version/lineage;
- role/context-scoped currentness/designation;
- reliance/editorial standing;
- availability/presence;
- preservation/custody history.

A simple profile may merge dimensions that cannot vary independently for its protected use.

## Time

The strongest general temporal distinction is:

- **effective/applicable time** — when a standing/fact/relation applies in the governed/modelled domain;
- **system-known/recorded time** — when a managing system learns/records/asserts it.

Creation, capture, publication, correction, migration, retraction, destruction etc. are usually typed event times rather than universal separate axes.

Records preserves current/historical standing and system-known history where needed. It does not establish factual truth.

## Reconstructability obligation

> Preserve enough typed change facts, standing assertions, identity/lineage relations, temporal semantics and provenance bindings to reconstruct the views required by the profile.

This does not prescribe event sourcing or temporal databases.

---

# 5. Organisation result

One canonical hierarchy/taxonomy is not the natural structure of all Records information.

At least three semantic functions can differ:

1. **context/provenance-preserving organisation** — relations/order/grouping that explain creation/activity/context;
2. **descriptive / knowledge organisation** — labels, subjects, classifications, vocabularies;
3. **access / retrieval organisation** — indexes, projections, finding aids, search structures.

They may coexist in one physical system or be separate. Separation is semantic, not architectural.

A resource can participate in multiple sets/views without becoming multiple underlying resources merely because it is organised several ways.

---

# 6. Derived views / source-bearing relations

`Canonical vs derived` was too binary.

Keep separate when relevant:

- derivation relation;
- access/discovery role;
- own persistent-resource/record identity;
- designated recordkeeping/source role for a bounded purpose;
- exact source/version/standing binding;
- freshness/as-of/coverage semantics.

A summary/index/query output can be derived **and** become a record in its own right.

The key requirement is not `derived objects can never be authoritative`.

It is:

> **A view/output must not silently stand for a different source/version/standing or support stronger claims than its binding, coverage and freshness justify.**

Who assigns a designated-source/authority role remains outside Records.

---

# 7. Retrieval result

`Retrievable` is claim-relative.

Materially different retrieval contracts include:

- known-item / exact identity;
- structured attribute/filter retrieval;
- semantic/topical discovery;
- exhaustive/high-recall retrieval;
- current-standing retrieval;
- historical/domain-as-of retrieval;
- system-known-as-of retrieval;
- provenance/derivation traversal;
- aggregate/case/thread reconstruction.

## Hit/miss discipline

A retrieval hit does not by itself establish:

- exact intended identity;
- current/designated standing;
- authority;
- factual truth;
- evidential sufficiency.

A miss does not by itself prove absence.

Strong absence inference requires sufficient bounds on:

- corpus/domain coverage;
- identity/alias scope;
- matching sensitivity/recall;
- freshness/as-of state;
- accessibility/permissions where relevant.

A closed complete exact-ID registry can support much stronger absence claims than open semantic search.

## Staleness

Stale/historical views are not inherently wrong.

Failure occurs when a view's actual freshness/as-of/coverage semantics do not match the claim/use made from it.

---

# 8. Recurrent Records Requirement Profile

The vertical does not support a permanent universal Records checklist.

The more stable process is:

> **recurrent context-bound appraisal → dated Records Requirement Profile / contract**

## Derivation inputs

A profile can be derived from:

1. resource / identity boundary;
2. protected use/outcome;
3. retrieval/reconstruction contract;
4. horizon / expected environmental change;
5. material consequence/risk dimensions;
6. external legal/policy/security/privacy/archival constraints;
7. change/standing characteristics;
8. transformation/migration/transfer exposure;
9. dependency/aggregation structure;
10. target users / knowledge baseline / interoperability boundary.

Begin with any applicable inherited baseline/mandate floor. Local context cannot waive a valid external obligation by preference.

## Requirement decision states

- **REQUIRED**;
- **NOT REQUIRED FOR CURRENT PROFILE**;
- **UNKNOWN / NEEDS EVIDENCE**.

## Satisfaction is a separate dimension

A required obligation can be satisfied:

- intrinsically;
- externally/linked;
- through relations;
- through inherited context;
- reconstructably;
- by system/control capability.

`Required` therefore does not mean `object-local metadata field`.

## Acceptance discipline

Every material required obligation should be linked to:

- protected use or external mandate;
- failure it prevents;
- required assurance/depth;
- satisfaction mode/dependency;
- observable acceptance/falsification outcome.

Profiles require re-appraisal when assumptions/context/constraints/users/horizon/transformations/retrieval requirements materially change.

---

# 9. Retention / appraisal / disposition result

Correct Records management includes knowing when continued persistence should end or custody should change.

`Keep everything forever` is not neutral.

## General disposition-rule semantics

A governed disposition context can require:

1. record/population scope;
2. applicable rule/authority identity + version/scope;
3. eligibility trigger / retention-clock start condition;
4. retention/transfer duration or condition;
5. hold/freeze/extension/override state;
6. final action;
7. execution/outcome evidence;
8. residual identity/history where required.

## Load-bearing distinctions

- appraisal/value ≠ duration;
- long-lived temporary ≠ permanent preservation;
- trigger ≠ execution;
- due/eligible ≠ currently permitted under holds/constraints;
- transfer ≠ destruction;
- supersession can affect current standing and independently start retention;
- removal/hide ≠ irreversible destruction;
- primary deletion ≠ destruction if in-scope recoverable copies remain;
- residual destruction evidence can remain after payload destruction and has its own retention profile;
- disposition rules/schedules themselves are versioned/applicability-bound information.

Source-specific terms such as NARA's `temporary/permanent/cutoff` are not promoted as universal ontology.

## Terminal outcome

A profile requiring destruction should define the observable scope/outcome, e.g.:

> in-scope payload must no longer be recoverable while the specified residual disposition evidence remains available.

How that outcome is technically achieved is later implementation assurance.

---

# 10. Mechanism landscape result

No reviewed mechanism pattern natively supplies all Records obligations.

## Native strengths differ

- mutable current-state store → present operational state;
- temporal/system-versioned store → some system-time history/as-of;
- event/change history → transition/replay semantics when events are complete;
- versioned object store → representation/version recovery;
- content-addressed DAG → exact content/snapshot/branch lineage;
- preservation layout (e.g. OCFL-like) → versioned object inventory/fixity/rebuildability;
- graph representation → heterogeneous relations/context traversal;
- search/index projection → discovery/ranking/filtering.

## Critical anti-myths

- MVCC version ≠ durable business/record history;
- `temporal` ≠ automatically effective-time/bitemporal semantics;
- append-only events ≠ complete provenance;
- object version ≠ business currentness;
- immutable/content-addressed ≠ trustworthy/current/retained forever;
- WORM ≠ authenticity/truth;
- graph ≠ provenance/authority merely by structure;
- index version ≠ source-record version;
- preservation layout ≠ complete Records system.

These describe **native semantics**, not hard technology ceilings. A concrete platform can instantiate multiple patterns and additional controls.

## Profile-first selection rule

```text
context/appraisal
→ Records Requirement Profile
→ observable requirements/failures
→ compare mechanism patterns
→ compose/select mechanisms
→ concrete technology/schema/topology
```

The reverse order is storage-first architecture.

## Hybrid/composition

Hybrid roles often make sense because obligations differ, but hybrid is not universally required and creates new binding/synchronisation/disposition/freshness failure modes.

Semantic role separation does not imply several physical services.

---

# 11. What is foundationally covered

For the current SOUL foundation purpose, the vertical now exposes the major problem classes needed to prevent hidden assumptions about:

- what the persistent thing/record is;
- identity and granularity;
- representation/copy/version/derivation/aggregation;
- context/provenance/interpretability;
- change/currentness/history/time;
- preservation and integrity closure;
- organisation and access views;
- retrieval sufficiency and absence claims;
- context-specific requirement derivation;
- retention/appraisal/disposition;
- mechanism-family trade-offs.

This maps directly back to the original research concern:

> What are Records? How is information preserved, managed, organised and reached again?

---

# 12. What remains unresolved — classified

## A. Refinements, not missing foundational dimensions

### Neutral umbrella term

`persistent information resource` is a working label. `information object`, `information content entity`, qualified `information artifact` and other options remain open.

### Transformation identity thresholds

No universal rule decides same representation vs new version vs new derived resource. The threshold is profile/domain dependent on protected significant properties/functions/semantic effects.

### Assurance calibration

How strong integrity/history/availability evidence must be for a concrete domain remains profile-specific.

---

## B. Implementation assurance / later mechanism verification

- durability / replication / backup / disaster recovery;
- distributed consistency / concurrency-control implementation;
- encryption / cryptographic key lifecycle;
- concrete access-control/security implementation;
- trustworthy-repository certification/audit;
- performance/scale/cost;
- concrete metadata schema/serialization;
- actual deletion/cryptographic-erasure guarantees;
- product/configuration-specific behavior.

These are critical, but requirement/profile semantics already state what outcome must be verified.

---

## C. Cross-vertical / outside Records

- who/what performs Work on records;
- creator/custodian/approver/verifier Actor model;
- authority/delegation/permissions ownership;
- who declares current/designated/authoritative standing;
- approval and destruction workflow;
- evidential sufficiency for claims/decisions;
- factual truth / reasoning correctness;
- orchestration and recovery process.

Records can preserve supplied facts/rules/decisions about these, but cannot derive their semantics alone.

---

# 13. Deferred relations to later verticals

The Records vertical has repeatedly exposed, but deliberately not solved:

```text
Actor creates/asserts/observes/verifies/custodies Record
Work produces/reads/transforms/supersedes/disposes Record
Policy/Authority constrains Actor ↔ Work ↔ Record relations
Record may support/challenge Claim or Decision
```

These are hypotheses/relations for later independent Work and Actors research, not validation of a final three-part ontology.

Later verticals can falsify or reshape the Records model.

---

# 14. How later work should use this vertical

## Do

- use the anti-collapse distinctions as research constraints;
- derive a Records Requirement Profile before judging storage/search mechanisms;
- recover load-bearing claims to the pass source ledgers and primary sources;
- reopen Records if Work/Actors/architecture reveals a counterexample;
- distinguish semantic requirement from mechanism/control.

## Do not

- copy this synthesis into SOUL as a component list;
- create a universal Record schema from the obligation families;
- assume every resource requires every capability;
- treat source-specific terminology as universal ontology;
- select technology solely because it matches one pattern discussed here;
- treat `sufficiently complete` as independently verified final truth.

---

# 15. Completeness verdict

After the dedicated omission review and retention/disposition pass:

> **The Records / persistent-information vertical is SUFFICIENTLY COMPLETE FOR THE CURRENT FOUNDATION PURPOSE.**

Meaning:

- no currently identified omitted candidate exposes another first-order Records semantic dimension that would materially restructure the model;
- remaining issues are bounded refinements, implementation assurance, profile-specific decisions or cross-vertical questions;
- the vertical should stop expanding by default to avoid infinite literature accumulation and architecture drift.

This verdict is a bounded research judgment/self-review, not independent proof.

## Reopen condition

Reopen Records if later research produces a counterexample that:

1. cannot be represented by current object/identity/change/organisation/retention semantics;
2. introduces a materially new Records failure/capability dimension;
3. cannot be handled as a profile-specific requirement, mechanism assurance or cross-vertical relation.

---

# 16. Next research direction

The next Layer-1 vertical should be chosen outside this synthesis according to the already-agreed independent-foundations sequence.

The Records result does **not** prove that Work or Actors are the correct final ontological primitives. It only makes Records sufficiently mature to stop foundational expansion and allow the next independent vertical to proceed without importing Records conclusions as unquestioned truth.