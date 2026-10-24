# Actors Finding — Representation, Delegation, Impersonation and Attribution

**Status:** current topic finding  
**Scope:** Actors-local distinctions; not a universal delegation protocol

## Current finding

Acting, acting on behalf of another, being authorized to act, being represented as another, and having an action attributed to another are distinct semantics.

Delegation is not one homogeneous transfer.

## Distinctions to preserve

### 1. Acting for oneself ≠ acting on behalf of another

Agency law defines the principal-agent relation around one party acting on behalf of and subject to the control of another. The relation requires more than causal performance.

### 2. Delegate/representative ≠ principal

W3C PROV's delegation relation assigns authority and responsibility to a delegate/representative for a specific activity while the principal/on-behalf-of agent retains some responsibility.

The representative can therefore be distinct from the bearer to whom the activity is institutionally connected.

### 3. Delegation ≠ impersonation

IETF RFC 8693 explicitly distinguishes:

- delegation: one party retains its own identity while representing another after receiving rights;
- impersonation: within the relevant rights context the acting party is indistinguishable from the represented subject;
- direct own-behalf action: neither delegation nor impersonation.

This is a strong technical counterexample to any generic `acts-as` relation.

### 4. Subject/principal ≠ current actor ≠ prospective authorized actor

RFC 8693 separately represents:

- the subject on whose behalf a request is made;
- the current actor;
- a party authorized to become an actor;
- delegation history through nested actor claims.

Identity, current participation, standing authorization and history therefore need not coincide.

### 5. Actual authority ≠ apparent authority

Agency law allows apparent authority to exist because a third party reasonably infers authority from the principal's conduct even when actual authority is absent. After an agency relation ends, actual authority can end while apparent authority persists until third parties receive notice.

This is decisive evidence that authority and representation have perspective- and time-sensitive lifecycle semantics.

### 6. Operational production ≠ legal/institutional attribution

UNCITRAL's 2024 Model Law on Automated Contracting attributes actions carried out by automated systems according to an agreed procedure or, by fallback, to the person using the system for that purpose. The guide treats attribution as a rule linking an automated action to a person; it does not require treating the automated system itself as the legal bearer.

This shows that an action can be operationally produced by one system while legal attribution is governed by a distinct rule.

## Decision-critical implication

The initial delegation-transfer and action-attribution assumptions are rejected.

A later synthesis must be able to distinguish, where relevant:

- performer/operator;
- represented subject or principal;
- representative/delegate;
- actual authority;
- apparent/third-party-facing authority;
- authorized prospective actor;
- impersonation/substitution semantics;
- delegation chain/history;
- scope and time of authority;
- causal/operational production;
- legal/institutional attribution.

The finding does not require all systems to implement every relation; it requires later modelling not to erase the distinctions when they matter.

## Evidence used

### IETF RFC 8693 — OAuth 2.0 Token Exchange

Inspected view:
- IETF Standards Track RFC text.
- Section 1.1, Delegation vs. Impersonation.
- Token request semantics for `subject_token` and `actor_token`.
- JWT `act` and `may_act` claim semantics and nested actor history.

Source:
- https://datatracker.ietf.org/doc/html/rfc8693

Supports:
- explicit separation of delegation, impersonation, current actor, subject, prospective actor and history.

Does not establish:
- legal/moral delegation semantics outside OAuth;
- that OAuth claim structure should be copied into SOUL.

### W3C PROV-DM

Inspected view:
- W3C Recommendation, section 5.3.4 Delegation.

Source:
- https://www.w3.org/TR/prov-dm/

Supports:
- delegate and responsible principal can be distinct;
- delegation is activity-specific;
- responsibility can remain with principal.

### Cornell Legal Information Institute — agency lifecycle

Inspected views:
- Agency.
- Apparent authority / ostensible authority.
- Fiduciary relationship, including termination and persistence of apparent authority until notice.

Sources:
- https://www.law.cornell.edu/wex/agency
- https://www.law.cornell.edu/wex/apparent_authority
- https://www.law.cornell.edu/wex/fiduciary_relationship

Supports:
- principal-agent/on-behalf-of relation;
- actual vs apparent authority;
- temporal divergence after termination.

### UNCITRAL Model Law on Automated Contracting with Guide to Enactment

Inspected view:
- official UNCITRAL publication search/extracted text for Article 7 and Guide paragraphs 59 onward; direct PDF open was blocked by the source server during this research pass, so the claim is limited to text exposed by the official UNCITRAL search surface.

Source:
- https://uncitral.un.org/en/mlac
- official PDF publication under uncitral.un.org

Supports:
- automated action and legal attribution are distinct;
- attribution can be determined by party agreement or by a rule assigning the action to the person using the system.

View-fidelity limitation:
- unlike the OHCHR and Christian List PDFs, the current tool could not reopen the UNCITRAL PDF for page-level screenshot verification because the server returned 403. The extracted official source text was inspected, and no broader claim is made from unseen portions.

## Residual uncertainty

- Legal systems differ in representation and liability doctrines; these examples establish non-collapse, not universal legal rules.
- Proxying, substitution, escalation and succession may require distinct later semantics in some domains. Current omission searches did not show that they collapse the above distinctions or create a wholly new first-order family.
