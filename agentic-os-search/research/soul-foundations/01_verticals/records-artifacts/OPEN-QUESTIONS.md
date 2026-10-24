# Records / Persistent Information — Residual Questions

**Status:** bounded residual uncertainty after vertical completeness review; not an automatic execution queue  
**Date:** 2026-09-01

The Records vertical is **sufficiently complete for the current foundation purpose**. These questions remain visible so later Work/Actors/architecture research can reopen Records when evidence warrants it.

## A. Refinements

### Q1 — Neutral umbrella category

What is the best neutral term around/above `record` for persistent information that may not itself have recordhood?

Candidates remain:
- persistent information resource;
- information object;
- information content entity;
- qualified information artifact;
- another later synthesis term.

**Current decision:** do not force an answer; load-bearing object distinctions do not depend on the label.

### Q2 — Transformation identity / significant-property threshold

For a particular resource/profile, when does change create:
- same representation;
- new representation;
- new version;
- new record/resource;
- semantic derivation?

**Current bounded rule:** decide relative to protected use, significant properties/functions, identity level and semantic effect. No universal file-operation threshold was found.

### Q3 — Assurance calibration

How much integrity, provenance, availability, currentness or retrieval evidence is enough for a concrete profile?

**Current decision:** profile/domain-specific assurance problem; later implementation must verify it.

---

## B. Implementation assurance / mechanism verification

### Q4 — Durability / replication / disaster recovery

What concrete redundancy, repair, recovery and geographic/failure-domain controls satisfy a particular Records Requirement Profile?

### Q5 — Distributed consistency / concurrency

How should a concrete mechanism prevent or represent divergent replicas, lost updates, forks and stale currentness under the required profile?

### Q6 — Security / confidentiality / key survivability

What access-control, encryption and key-lifecycle mechanisms satisfy record-side rights/confidentiality and future recoverability requirements?

### Q7 — Actual deletion / destruction assurance

How can a concrete storage/cloud/backup architecture demonstrate the profile's required scoped irrecoverability while preserving only allowed residual history?

### Q8 — Trustworthy repository / certification

What independent audit/certification evidence is required for a concrete repository profile, including possible ISO 16363-style assurance where applicable?

These are not reasons to expand the foundational Records ontology now.

---

## C. Cross-vertical questions

See `DEFERRED-RELATIONS.md` for detail.

Material questions include:

- Which Work creates, consumes, changes, verifies, transfers or disposes a record?
- Which Actor creates/asserts/custodies/designates/approves/authorizes actions on records?
- Where should authority/policy live?
- When is a persistent record evidence for a claim/decision, and what makes evidence sufficient?
- When does a derived access view become a Work output with independent Records obligations?

These must not be answered by Records alone.

---

## Reopen rule

Reopen foundational Records research only if later work shows a case that:

1. cannot be represented with the current object/identity/preservation/change/organisation/retrieval/retention model;
2. exposes a materially new Records failure/capability dimension;
3. cannot be handled as a profile-specific requirement, implementation-assurance issue or cross-vertical relation.

Otherwise use `synthesis/RECORDS-VERTICAL-SYNTHESIS.md` as the bounded Records input to later research.