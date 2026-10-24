# Change / Status / Temporal Semantics — Adversarial Counter-Check

**Status:** adversarial supplement to `CHANGE-STATUS-TEMPORAL-SEMANTICS.md`  
**Date:** 2026-09-01  
**Scope:** test the pass's own change/standing/time model; not independent verification.

## Purpose

The main synthesis rejects generic `update` and one universal `status`, replacing them with typed change semantics, identity/lineage relations, several standing dimensions, and a limited temporal model.

This file asks whether that result:

- over-separates vocabulary;
- imports domain-specific publishing/archival terms as universal ontology;
- secretly prescribes event sourcing/bitemporal storage;
- makes `current` falsely singular;
- mishandles disposition or deletion;
- collapses factual truth into status.

---

# C1 — Are the standing dimensions over-separated?

## Challenge

Production state, currentness, editorial standing, availability, and custody can correlate strongly in some systems. A simple operational system may use one status field without obvious failure.

## Counterexample to universal separation

A short-lived local draft may only need `draft/current/final` and never require independent retraction, archival, or availability semantics.

## Counterexample to universal collapse

A scholarly publication can simultaneously be:

- Version of Record;
- retracted;
- publicly available;
- permanently archived.

Those facts cannot inhabit one mutually exclusive status value without loss.

## Revision

The synthesis should not claim every resource needs six stored status fields.

The stronger rule is:

> **Do not collapse semantic dimensions that can vary independently for the protected use.**

A profile may merge dimensions when counterexamples show no material distinction in that domain.

---

# C2 — Are correction/retraction/removal categories merely publishing jargon?

## Challenge

The strongest explicit distinction evidence comes from scholarly publishing.

## Test

The semantic pattern generalises more safely than the labels:

- **correction-like:** prior state is explicitly amended because some part was defective;
- **supersession-like:** another resource becomes preferred/effective for a role;
- **reliance-withdrawal-like:** object remains identifiable/present but governing standing says do not rely on it as before;
- **availability-removal-like:** content becomes inaccessible while identity/history may remain;
- **destruction-like:** payload becomes intentionally irrecoverable while management history may survive.

## Revision

Retain the source terms in source/domain contexts, but make the Records result about **semantic effects**, not a universal vocabulary.

---

# C3 — Does `typed event history` secretly prescribe event sourcing?

## Challenge

The synthesis repeatedly says typed change events must remain reconstructable. This could drift into `store all events and derive state`.

## Counter-models

Equivalent semantic closure can be supplied by:

- version snapshots + transition metadata;
- current snapshot + append-only audit/history;
- temporal relations;
- immutable versions + explicit standing records;
- externally maintained provenance/change history;
- combinations of snapshots and events.

## Revision

The requirement is **recoverable transition semantics**, not an event store.

`Event` in this pass means a historical change fact; storage may materialise it in any form that preserves the required reconstruction capability.

---

# C4 — Does valid/transaction time overfit database facts to Records?

## Challenge

Temporal database theory models facts/entities in databases. Records can be documents, representations, versions, statuses and relations whose truth conditions differ.

## Test

The underlying distinction still survives outside databases:

- a policy is effective on 1 August;
- repository learns/registers it on 10 August.

Or:

- a correction notice published today says a datum in last month's report was wrong for a prior effective period.

The two questions remain distinct:

1. when did the asserted status/fact apply in the governed domain?
2. when did the system know/record that assertion?

## Revision

Use `effective/valid-like` and `system-known/recorded` as **semantic perspectives**, not as mandatory database columns or strict TSQL definitions.

Do not force valid-time semantics on information where no domain applicability interval is meaningful.

---

# C5 — Are many named timestamps actually independent time axes?

## Challenge

Creation, capture, publication, revision, correction, retraction, migration, transfer and destruction dates could produce an unwieldy universal timestamp schema.

## Revision

Treat most as:

> **typed event occurrence times**

and promote separate temporal axes only when they support different reconstruction questions.

The two most generally independent perspectives found are:

- effective/applicable time;
- system-known/recorded time.

Everything else remains event-specific unless the resource profile proves otherwise.

---

# C6 — Can `current` be singular?

## Challenge

The synthesis sometimes talks about `the current version`.

RFC 5829 permits multiple latest versions in branching histories. Other systems can have:

- current version by jurisdiction;
- current language-specific expression;
- current branch;
- current policy for one effective period but another scheduled future version;
- multiple simultaneously authoritative representations.

## Revision

`current/latest/authoritative` must be scoped by:

- role/purpose;
- branch/context/jurisdiction where applicable;
- effective interval;
- selection/designation rule.

Therefore currentness can be **multi-valued** rather than one global pointer.

---

# C7 — Does `latest timestamp` sometimes work?

## Challenge

Rejecting timestamp ordering universally would be equally wrong. Linear local version systems often legitimately define latest as newest timestamp.

## Revision

The claim is not:

`timestamp must never select current`.

It is:

> **timestamp order is sufficient only when the domain's currentness rule explicitly makes it sufficient and branching/effective-time/designation counterexamples do not apply.**

This avoids replacing one universal with another.

---

# C8 — Does retraction equal invalidation in some domains?

## Challenge

Some systems use `invalidate` colloquially to mean `mark not valid`, including still-visible resources.

W3C PROV, however, gives `invalidation` a precise lifecycle meaning: destruction/cessation/expiry and no longer available for use.

## Revision

Never normalize the word itself. Preserve source vocabulary namespace/definition or map to an explicit semantic effect.

The counterexample strengthens the need for semantic axes rather than a global status vocabulary.

---

# C9 — Can historical reconstructability be satisfied by snapshots alone?

## Challenge

The synthesis could over-value transition histories. A sequence of complete dated snapshots may reconstruct all required prior content states.

## Test

Snapshots can reconstruct content but may still lose:

- why standing changed;
- correction/retraction reason;
- relation to an external notice;
- distinction between migration and revision;
- effective date vs system recording date;
- identity/lineage semantics.

But if the protected use does not require those facts, snapshots may be sufficient.

## Revision

Require only the history semantics needed by the future-use profile. Do not require event explanations for changes whose meaning is irrelevant.

---

# C10 — Can event history alone reconstruct current standing?

## Challenge

If all events are kept, can current status always be computed?

Not necessarily.

Failure cases:

- event types are ambiguous or vocabulary changes;
- designation/currentness rules change over time;
- branches create multiple tips;
- correction/retraction notice lacks exact target binding;
- effective time is omitted;
- external status assertion disappears.

## Revision

Either current standing must be materialised with history, or the **rules and inputs necessary to derive it** must themselves remain in preservation closure.

This is the same logical-closure principle from Pass 3.

---

# C11 — Does disposition belong in this pass?

## Challenge

Disposition quickly pulls in retention policy, legal authority, approvals and workflow — outside Records vertical isolation.

## Retained Records-only boundary

This pass uses disposition only to distinguish:

- payload still retained;
- transferred for continued custody/preservation;
- payload intentionally destroyed/irrecoverable;
- identity/history/proof of destruction retained where required.

## Deferred

- who authorises destruction;
- retention duration;
- legal hold rules;
- review/approval process;
- sanctions/compliance.

## Verdict

Disposition remains in scope only as **terminal information-state/history semantics**. Governance remains deferred.

---

# C12 — Does the model reintroduce factual truth through `effective/valid`?

## Challenge

The word `valid` can be mistaken for `factually correct`.

Temporal databases use `valid time` to mean when a fact is modeled as true in the represented reality. Records systems may only know an assertion of effective/valid standing, not objective truth.

## Revision

For Records synthesis prefer:

- **effective/applicable time**, or
- `valid-time-like` only when borrowing database terminology explicitly.

A record can faithfully preserve an assertion that was later found false.

---

# C13 — Does the pass overfit recordkeeping immutability?

## Challenge

Some operational resources legitimately mutate in place and only current state matters.

## Revision

History is required only when the intended future-use profile needs it for accountability, reconstruction, currentness, provenance, correction, audit, or other purpose.

For ephemeral/current-only resources, destructive update may be acceptable if no Records obligation requires prior state.

Therefore:

> **preserve change semantics proportionally to the preservation/reuse profile, not because all persistent information must have maximal history.**

---

# C14 — Did the pass miss a material distinction: scheduled/future standing?

## Challenge

A resource/status can be designated now to become effective later.

Example:

- policy B is published 1 September;
- it supersedes policy A effective 1 October.

A model with only publication/event time and current flag is insufficient.

## Revision

This supports effective-time semantics and role-scoped designation.

It does not require a new universal status dimension; it is representable as a standing assertion with an effective interval.

---

# C15 — Architecture contamination check

The pass has **not selected**:

- event sourcing;
- append-only log;
- temporal/bitemporal database;
- immutable snapshots;
- graph database;
- relational schema;
- status enum;
- identifier technology;
- storage topology;
- SOUL memory/state model.

Temporal database theory, RFC version graphs, PREMIS events, and Crossref metadata are used as falsifying/semantic examples only.

**Verdict:** scope remains Records / persistent-information semantics.

---

# Final adversarial verdict

The main model survives with these constraints:

1. semantic **dimensions are conditional**, not mandatory stored columns;
2. use source/domain status vocabulary only with its meaning intact;
3. typed history does not imply event sourcing;
4. effective/valid-like vs system-known time is a semantic distinction, not a database prescription;
5. most named dates are typed event times, not universal axes;
6. currentness is role/context scoped and may be multi-valued;
7. timestamp ordering can be sufficient in domains that explicitly define it so;
8. disposition is included only at the terminal Records-information boundary;
9. historical reconstruction requirements remain profile-relative;
10. Records preserves standing/history assertions, not factual truth.

No adverse case found requires abandoning the multidimensional change/standing framing.

The counter-check strengthens one next-step signal: now that current/historical standing is semantically distinguished, the next major failure surface is **whether organisation and retrieval surfaces can return the correct identity/version/standing and propagate changes without becoming stale shadow authorities**.