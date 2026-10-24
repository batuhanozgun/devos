# Minimum Preservation Closure — Adversarial Counter-Check

**Status:** adversarial supplement to `MINIMUM-ENVELOPE.md`  
**Date:** 2026-09-01  
**Scope:** challenge the pass's own framing before return.

## Purpose

The main synthesis moved from a fixed `minimum metadata envelope` toward a parameterised **minimum preservation closure**. This file tests whether that replacement is itself too broad, too preservation-centric, or missing important qualifiers.

---

# C1 — Does `longer horizon = more metadata` overfit the evidence?

## Challenge

A simple maturity ladder could imply that short-lived information always needs less context/control than long-lived information.

## Counter-evidence

NAA explicitly notes that lower-value information may still require Additional-level properties when another business/security requirement applies. Sensitive/classified information needs Protective Marking regardless of value or length of use.

NARA classified-record guidance similarly adds security-classification metadata because the control problem differs, not because the archival horizon changed.

## Revision

**Retention horizon is only one parameter.**

Minimum closure must also consider:

- consequence/risk;
- confidentiality/security;
- legal/business obligations;
- transformation exposure;
- system-boundary/transfer needs.

The main synthesis includes these variables; do not reduce profiles to a time ladder.

---

# C2 — Is provenance really a universal baseline?

## Challenge

The source set is heavily recordkeeping/preservation oriented and therefore naturally emphasizes creator/provenance.

Some persistent information can remain semantically usable even if its creator is unknown or irrelevant to the intended use.

OAIS itself gives the example that `creator unknown` may be adequate Provenance Information in some holdings.

## Revision

Do not define `known creator` or `detailed provenance` as universal minimum fields.

The stronger obligation is:

> preserve enough **origin/context epistemic state** for the intended use/trust requirement, including an explicit `unknown` where that is adequate.

For uses that do not depend on origin, the provenance burden can be small. For evidential/reproducibility/high-trust uses it can be extensive.

This supports the main synthesis's `depth conditional` wording.

---

# C3 — Does identity require a globally persistent identifier?

## Challenge

FAIR and DataCite privilege globally persistent identifiers, but local operational records may be sufficiently distinguishable by a scoped internal identifier.

PREMIS similarly does not mandate one particular identifier scheme.

## Revision

The baseline obligation is **unambiguous reference within the required domain/horizon plus recoverable scheme/scope**, not necessarily a DOI/global PID for every resource.

Migration/transfer can increase the need for durable globally resolvable identifiers or historical ID mappings.

---

# C4 — Does integrity require per-object fixity?

## Challenge

OAIS makes Fixity Information a required PDI class for long-term AIPs, which could tempt a universal checksum rule.

## Counter-evidence

- PREMIS fixity is optional at the object semantic-unit level;
- NAA puts Integrity Check at the Transfer/archival level, not Core;
- a repository can protect integrity through controlled storage/events/replication without exposing a checksum as per-object descriptive metadata.

## Revision

Preserve an **integrity/continuity assurance capability** proportional to risk/horizon. Do not equate that capability with one fixed checksum/signature field.

---

# C5 — Can external/inherited metadata really satisfy the minimum?

## Challenge

Externalisation introduces dependency loss, stale bindings and transfer failures.

## Supporting evidence for externalisation

- NARA: metadata can be embedded, held in an application, or both;
- NAA: common metadata can be represented through governance documentation / an information asset register at aggregate/system level;
- PREMIS: mandatory can mean repository `needs to know`, not necessarily repeatedly stores;
- FAIR: metadata and infrastructure are distinct from data;
- OAIS: Representation Information may be referenced through a network.

## Failure test

Externalisation fails closure when:

- the referenced registry/schema disappears;
- the pointer resolves to a newer incompatible version;
- membership/inheritance cannot be reconstructed historically;
- a transfer exports objects without materialising context needed by the receiving environment;
- access controls make the dependency unavailable;
- the metadata is correct but bound to the wrong version/representation.

## Revision

External/inherited knowledge is acceptable only if **dependency survivability and exact binding** are themselves protected for the intended horizon.

A further distinction is required:

- **local sufficiency:** repository can interpret/manage because shared rules exist;
- **portable/exchange sufficiency:** enough of those rules/values are exported or resolvably shared so a receiving system can do the same.

PREMIS explicitly supports this distinction: a mandatory value may be implicit in repository rules locally but must be supplied when exchanging PREMIS-conformant metadata.

---

# C6 — Is discovery/retrieval an object property or infrastructure concern?

## Challenge

FAIR's search/index requirements could be misread as requiring descriptive discovery metadata on every object.

## Counterexamples

- known-item retrieval may succeed with identifier + resolver/index only;
- NAA's Core does not require Title;
- Title/Description become more important for richer search/discovery profiles;
- search index entries are derived infrastructure, not necessarily authoritative record content.

## Revision

Keep **retrievability** as a system-level closure obligation. Do not make semantic-discovery metadata universally minimum.

---

# C7 — Does `preservation closure` accidentally absorb all information quality?

## Challenge

If the model includes everything needed for future use, it could become a catch-all for factual correctness, evidential sufficiency, domain validity, or decision quality.

## Boundary test

A record can be:

- perfectly identified;
- interpretable;
- provenance-complete;
- bit-exact;
- historically reconstructed;

and still contain a false claim.

The foundational pass already separated authenticity/integrity from factual correctness.

## Revision

The closure model preserves **identity, meaning, context, history, control constraints and access to information**. It does not guarantee:

- factual truth;
- evidential sufficiency for a claim;
- sound reasoning;
- correct decision.

Those relationships remain outside the Records-only semantics or deferred to evidence/work synthesis.

---

# C8 — Does `minimum preservation closure` solve retention/disposition?

## Challenge

Records management includes retention/disposition, but semantic preservation closure is oriented toward information that continues to be retained.

NAA includes Disposal Class in its Additional level, showing that management over time also needs to know **whether/how long** a record should continue to exist.

## Revision

Retention/disposition is a **separate Records management obligation** that interacts with preservation closure but should not be silently absorbed into it.

The current pass may state what disposition metadata/history needs preservation, but authority/policy for destruction remains deferred.

Therefore this pass does not complete the lifecycle model.

---

# C9 — Is the closure recursively infinite?

## Challenge

OAIS Representation Information Networks are recursive: representation information can itself need representation information.

A naive `preserve every dependency` rule becomes unbounded.

## OAIS stopping principle

Recursion stops when the information is understandable/usable using the Designated Community's Knowledge Base and the Preservation Objectives are satisfied.

## Revision

Closure is **relative to an explicit knowledge baseline and preservation objective**. It is not absolute self-containment.

This is one reason target community/use cannot be omitted from profile derivation.

---

# C10 — Did the original candidate list omit material obligation families?

## Omission search result

Two omissions were material:

### 1. Rights / access / use constraints

OAIS, NARA, NAA and FAIR all expose this under specific uses/horizons.

This is now O7 in the main synthesis.

### 2. Preservation Objectives / significant transformational properties

OAIS and PREMIS show that preservation under transformation requires explicit knowledge of **what properties must remain invariant / what future capability is protected**.

This is now represented as meta-obligation M1/M2.

## Candidates considered but not promoted as universal obligation families

### Factual quality / truth / confidence

Important in many domains, but not a generic record-preservation property. A trustworthy record can faithfully preserve a false assertion. Keep outside the closure core unless a domain profile explicitly requires quality/uncertainty metadata.

### Actor authority / permissions enforcement

Constraint metadata is Records-relevant; deciding/enforcing which actor may act is cross-vertical and deferred.

### Cost / storage efficiency

A design/implementation trade-off, not information identity/preservation semantics.

---

# C11 — Does the new frame still drift toward architecture?

## Check

The pass has not selected:

- object-local versus graph storage;
- relational/document/vector database;
- immutable versus mutable store;
- metadata serialization;
- identifier technology;
- retrieval algorithm;
- SOUL memory architecture.

The terms `external`, `embedded`, `registry`, `graph`, and `inherited` are used only to test **where an information obligation can reside**, not to recommend a topology.

## Verdict

Vertical scope remains Records/persistent-information semantics.

---

# Final adversarial verdict

The `minimum preservation closure` frame survives this round **with constraints**:

1. it is purpose/profile relative, not universal;
2. horizon is not the only scaling variable;
3. obligation family does not imply one metadata field;
4. `need to know` does not imply object-local storage;
5. external/inherited context needs survivability + binding + portable materialisation where required;
6. closure preserves the record/resource's intelligibility and history, not factual truth or evidential sufficiency;
7. recursion stops relative to target knowledge base/preservation objective;
8. retention/disposition remains a neighbouring Records problem rather than being solved by this model.

No counterexample found in this pass requires abandoning the closure framing, but future change/status and retrieval research may force revisions.