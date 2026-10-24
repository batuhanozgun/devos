# Cross-Ground Transition / Propagation — P5 Authoritative External + Candidate Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Attack the bounded-leaf hypothesis with authoritative, materially different traditions and selected candidate studies. External material is used as hostile pressure, not Foundation taxonomy authority.

## 2. W3C PROV — generation/invalidation and temporal identity

Primary surfaces:
- https://www.w3.org/TR/prov-o/
- https://www.w3.org/TR/prov-constraints/

PROV distinguishes entity generation and invalidation events and provides time semantics for when an entity becomes available or ceases to be available within the provenance model.

Pressure on this child:

```text
entity/version existence interval
!= activity lifetime
!= later observation/report about it
```

Useful support:
- change/event identity can be tied to an exact entity/activity relation;
- invalidation has temporal semantics distinct from generic update;
- event semantics need not become a first-class universal event ontology.

Limitation:
PROV is provenance/information-oriented. Its generation/invalidation vocabulary must not become the universal transition lifecycle.

**Disposition:** supports exact identity/time and invalidation distinction; does not force a child split.

## 3. OpenTelemetry — occurrence time versus observation time

Primary surface:
- https://opentelemetry.io/docs/specs/otel/logs/data-model/

The logs data model distinguishes:
- `Timestamp` — time when the event occurred at the source;
- `ObservedTimestamp` — time when the collection system observed it.

Pressure:

```text
occurrence time != observation time
```

This independently supports the Foundation rule that delayed observation/reporting must not relocate the underlying occurrence in time.

Limitation:
OpenTelemetry is an observability representation model; it does not prove actual-world transition truth merely because a record carries timestamps.

**Disposition:** supports time/observation separation; no child split.

## 4. AWS IAM — source change versus endpoint visibility

Primary surface:
- https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot.html

AWS states that IAM uses eventual consistency and changes can take time to become visible from all endpoints because of distributed propagation and caching. AWS recommends verifying propagation before production workflows depend on the change.

Pressure:

```text
IAM change made
!= change visible/effective at every endpoint immediately
```

This strongly supports:
- realized scope can be partial;
- source success does not establish global effect;
- propagation verification can matter separately from change issuance.

Limitation:
`eventual consistency` is one implementation family, not Foundation vocabulary.

**Disposition:** strong software/distributed holdout; supports shared grammar, not child structure.

## 5. Google Cloud IAM — propagation mechanism changes the delay profile

Primary surface:
- https://docs.cloud.google.com/iam/docs/access-change-propagation

Google documents that access changes are eventually consistent and recently revoked permissions can remain usable temporarily. It also documents that propagation time differs by change mechanism; group/nested-group membership changes can propagate differently, and additions/removals can have asymmetric propagation characteristics.

Pressure:

```text
same high-level access intention
+ different propagation mechanism/path
→ different realized timing/scope behavior
```

Therefore Foundation should preserve mechanism/path relevance when decision-critical without embedding provider-specific timing constants.

New insight:

> propagation latency/completeness is relation/path-relative, not a universal scalar property of the originating change.

**Disposition:** strengthens path/scope/time grammar; no new child.

## 6. NASA Configuration Management — approval versus implementation versus verification

Primary surface:
- https://www.nasa.gov/reference/6-5-configuration-management/

NASA configuration management explicitly describes approved changes being followed by incorporation and verification of implementation, and configuration status accounting tracks changes from initiation to implementation.

Pressure:

```text
change proposed
!= change approved
!= approved change incorporated
!= implementation verified
```

This is valuable because it is systems/configuration-management semantics rather than distributed IAM replication.

Foundation interpretation:
- proposal/approval belongs to Work/Actors/Control/Information depending exact semantics;
- realized incorporation belongs to transition/local state;
- verification result/evidence remains separate from actual implementation;
- status accounting is representation about transition progress, not the transition by identity.

**Disposition:** strongly supports non-collapse across grounds and realization/observation separation; no split.

## 7. Institutional rule holdout — publication, effective date and compliance timing

Representative primary surface:
- Federal Register final-rule material, e.g. https://www.federalregister.gov/documents/full_text/html/2025/12/15/2025-22827.html

The rule distinguishes publication from a later effective date and explains why implementation/compliance time is needed.

Pressure:

```text
rule published
!= rule effective now
!= all affected parties/processes already compliant
```

This falsifies a software-only interpretation of `propagation`.

A cross-ground transition can be institutional/normative:
- Information publication occurs;
- governing Control becomes effective at a specified time/scope;
- Actors/Work/Environment may require later implementation/compliance changes.

No state replication model is necessary.

**Disposition:** strong non-software holdout; supports the generic grammar.

## 8. Candidate study — Anthropic AI-native SDLC

Canonical candidate package:
`research/studies/anthropic-ai-native-sdlc-playbook/`

Useful illustrative pressure already preserved in its META/assessment:
- committed repository/configuration state is not identical to operating reality;
- a changed configuration can require regression evaluation and deployment/operational validation;
- actual target state may drift from repository representation.

This supports:

```text
artifact/config change
!= actual target/environment change
```

It remains illustrative, not load-bearing Foundation authority.

## 9. Candidate study — gstack

Catalog/META reviewed.

The study is active and freshness-sensitive. It is potentially relevant to durable handoffs, runtime/eval/production loops and operational change, but no gstack mechanism is needed to establish the current Foundation result.

Decision:

> do not make gstack load-bearing in this pass; avoid unnecessary fresh-target revalidation when authoritative sources already discriminate the live hypothesis.

## 10. Cross-holdout synthesis

The same minimum separation survives across materially different mechanisms:

### Distributed access-control propagation
```text
source change != remote effect now
```

### Configuration management
```text
approved change != incorporated change != verified implementation
```

### Institutional rule change
```text
published != effective != complied-with/implemented
```

### Observability
```text
occurred != observed
```

### Provenance
```text
generated/invalidated entity state != generic record update
```

These do **not** justify one universal lifecycle.

They justify a shared protected question:

> What exact change actually became real/effective, for which scope, when, through what applicable dependencies/path, and how fully?

## 11. Falsifier disposition after P5

- F1 ground-local collapse → not observed; cross-ground scope/effect semantics remain load-bearing.
- F2 generic event bucket → rejected by exact realized-scope/propagation question.
- F3 universal lifecycle overfit → falsified; no universal stage chain retained.
- F4 Propagation/Convergence child pressure → not forced; convergence remains criterion/Standing-facing.
- F5 Invalidation child pressure → not forced.
- F6 Recovery child pressure → not forced.
- F7 Time child pressure → not forced; time remains cross-cutting.
- F8 Architecture leakage → avoided; distributed vocabulary treated as profile only.
- F9 Observation collapse → independently rejected by OpenTelemetry/NASA/W3C pressure.
- F10 upstream falsifier → none found.

## 12. P5 judgment

External and candidate holdouts support, rather than break, the current bounded-leaf hypothesis.

The strongest reusable insight is broader than eventual consistency:

```text
change defined / issued / approved / recorded
!= change realized
!= change effective for every applicable scope
!= realization observed/verified
```

Proceed to P6 for child-decision synthesis.
