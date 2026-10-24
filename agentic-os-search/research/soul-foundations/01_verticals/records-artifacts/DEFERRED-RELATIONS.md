# Records / Artifacts — Deferred Relations

**Rule:** These questions were exposed by Records research but are not solved here. They are recorded so vertical isolation does not become artificial blindness.

## DR-01 — Record ↔ activity/work

Observed signal:
- archival/records-management definitions repeatedly associate records with actions, transactions, events or business activities;
- archival bond arises from records generated/accumulated through the same activity;
- W3C PROV relates entities to activities that use/generate them;
- records-continuum theory has a transactional/function/activity axis distinct from the recordkeeping/evidence axis.

Deferred question:
- Is a record fundamentally relative to an activity/work context, or are there important record classes whose identity does not require that relation?
- If relation is required, should it be intrinsic metadata, provenance relation, or external Work linkage?

Do not resolve until Work vertical has independent results.

## DR-02 — Record ↔ actor/originator

Observed signal:
- provenance and authenticity models use creator/author/originator/responsible-agent information;
- W3C PROV includes attribution/association/delegation through agents;
- records-continuum theory separately models identity/institutional actors.

Deferred question:
- Is actor identity constitutive of some records' authenticity/identity or merely provenance metadata?
- How should human, software, organisational and delegated actors differ?

Do not resolve until Actors vertical has independent results.

## DR-03 — Authority / permissions

Observed signal:
- ISO/NARA/OAIS include access/permissions/rights as records-management concerns.

Deferred question:
- Is authority a property of the record, an Actor↔Record relation, a policy over Work/Actors/Records, or a separate primitive?

This is cross-cutting and must not be answered from the Records lens alone.

## DR-04 — Evidence relation

Observed signal:
- records are often valued as evidence, but `evidence` is relational to a claim/question/decision.

Deferred question:
- Should evidence be represented as a record subtype or as a relationship such as `record supports/challenges claim/decision`?

This may depend on Work/decision semantics and is deferred.

## DR-05 — Records Continuum convergence with the three verticals

Observed signal:
- records-continuum literature independently describes a recordkeeping/evidence axis, a transactional purpose/activity axis, and an institutional/actor identity axis.

Deferred question:
- Does this provide independent theoretical support for Records / Work / Actors as a useful decomposition, or is the similarity specific to recordkeeping theory and therefore an artefact of this vertical?

Important:
- Do **not** promote this convergence as validation of the SOUL three-leg ontology. It is a hypothesis for later cross-vertical synthesis after Work and Actors have been researched independently.

## DR-06 — Provenance graph ownership

Observed signal:
- provenance relates entities, activities and agents and can itself have provenance.

Deferred question:
- Does provenance belong inside Records, or is it a cross-system relation layer spanning Records, Work and Actors?

Current vertical may research provenance requirements, but final ownership/location is deferred.

## DR-07 — Retention/disposition authority

Observed signal:
- records lifecycle requires explicit decisions about retention, deletion and permanent preservation.

Deferred question:
- Who/what is authorised to establish or execute disposition rules, and what Work/Actor controls are needed for irreversible destruction?

Records research can define lifecycle semantics; decision authority belongs to later synthesis.

## DR-08 — Derived record creation

Observed signal:
- summaries, transformations, extracted facts and generated views can become persistent and provenance-bearing.

Deferred question:
- When does a derived view become a new record/work output rather than merely an access representation of an existing record?

This depends on both record identity and Work semantics and remains deferred.

## DR-09 — `Artifact` ↔ Work-product semantics

Observed signal:
- software/systems-engineering sources often use `artifact` to mean a work product produced, consumed or modified by project activity;
- archival usage often means a physical/man-made object or a resource whose material object has intrinsic value;
- formal `information artifact` ontologies can define a disciplined informational category, but only with explicit qualification.

Deferred question:
- Should later cross-vertical synthesis use `artifact` specifically as a Work-produced object relation, rather than as the Records super-category?
- If a qualified `information artifact` concept is retained inside Records, how is it distinguished from a Work artifact/work product?

Current consequence:
- do not let software work-product usage determine the Records taxonomy before Work is independently researched.

## DR-10 — Recordkeeping/current-source designation authority

Observed signal:
- organisation/retrieval research shows a derived output, query result, finding aid or other representation can have its own recordhood and may be designated as a recordkeeping source for a bounded role;
- current/designated standing is role/context scoped rather than a purely intrinsic property of bytes;
- access views must preserve exact binding to the resource/version/standing they describe, but Records semantics alone cannot determine who may establish or change that designation.

Deferred question:
- Who/what is authorised to designate a resource/version/representation as the recordkeeping copy, current source, authoritative source for a role, or replacement for another source?
- What approval, delegation, conflict-resolution or review rules govern that designation?

Records may preserve the designation relation, its scope, history and provenance. Authority and workflow for establishing it remain deferred to Actors/Work/policy synthesis.