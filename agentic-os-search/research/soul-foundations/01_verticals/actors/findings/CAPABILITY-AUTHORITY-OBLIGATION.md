# Actors Finding — Capability, Competence, Permission, Authority and Obligation

**Status:** current topic finding  
**Scope:** Actors-local distinctions; not a SOUL authorization model

## Current finding

`Can do`, `is competent to do`, `may do`, `has authority to do`, and `must/ought to do` are not one property family with interchangeable labels.

The research found independent reasons from access control, law and legal-capacity doctrine to preserve these distinctions.

## Distinctions to preserve

### 1. Operational capability ≠ authorization

A subject or system may technically be capable of an action without being permitted or authorized to perform it. Conversely, formal permission does not guarantee practical competence or operational capability.

NIST ABAC evaluates authorization from attributes of the subject, object, operation and sometimes environment under policy. Authorization is therefore an outcome of a context-sensitive relation, not a bare intrinsic property of the subject.

### 2. Identity ≠ permission

NIST RBAC separates users from roles and permissions. Permissions are assigned to roles; users receive them through role assignment and activation subject to constraints.

### 3. Authority may be scoped and relational

Agency law treats authority as power to act on behalf of a principal. It distinguishes express, implied and apparent authority. Apparent authority can bind a principal even when actual authority is absent because the relevant fact concerns a third party's reasonable inference from the principal's conduct.

This shows that `authority` can depend on relation, scope, representation and the perspective of another party.

### 4. Authority may be combinatorial

Separation-of-duty rules show that an action may require distinct authorized participants or prohibit one participant from combining roles. A transaction's authorization state can therefore depend on a configuration of participants rather than a single Actor property.

### 5. Legal capacity ≠ decision-making skill

The UN Committee on the Rights of Persons with Disabilities explicitly distinguishes legal capacity—legal standing and legal agency—from mental capacity/decision-making skills.

For this research, the important general lesson is semantic rather than doctrinal: the word `capacity` can refer to normatively different concepts. Skill/competence must not silently stand in for legal or institutional standing/authority.

### 6. Permission/authority ≠ obligation

Being permitted or empowered to act does not by itself create a duty to act. Likewise, being responsible for an area may create duties without giving unilateral authority to execute every related action.

The evidence does not justify collapsing these into a generic `responsibility` or `capability` property.

## Decision-critical implication

The initial normative-collapse assumption is rejected.

A later synthesis must preserve typed relations or otherwise preserve the semantic differences among:

- technical/causal capability;
- skill or competence;
- legal/institutional standing;
- permission;
- authority/power;
- obligation/duty;
- constraints on combinations of authority.

Exact vocabulary and representation remain later design questions.

## Evidence used

### NIST SP 800-162 — ABAC

Inspected view:
- NIST CSRC official publication page and abstract for SP 800-162, including current update status.
- Publication definition of authorization as evaluation over subject, object, operation and environment attributes against policy/rules/relationships.

Source:
- https://csrc.nist.gov/pubs/sp/800/162/upd2/final

Supports:
- authorization is policy/context dependent;
- subject identity alone does not determine authorization.

Does not establish:
- competence, moral responsibility or legal agency outside access-control scope.

### NIST RBAC

Inspected view:
- NIST CSRC RBAC FAQ, including role activation and separation-of-duty components.

Source:
- https://csrc.nist.gov/Projects/role-based-access-control/faqs

Supports:
- user, role and permission are separable;
- permission may be constrained by session and role combination.

### Cornell Legal Information Institute — agency/authority

Inspected views:
- Agency, current Wex web view.
- Apparent authority / ostensible authority, current Wex web views.

Sources:
- https://www.law.cornell.edu/wex/agency
- https://www.law.cornell.edu/wex/apparent_authority
- https://www.law.cornell.edu/wex/authority

Supports:
- actual/implied/apparent authority are distinct;
- authority to act on another's behalf is relational and scoped;
- third-party reliance can matter.

Does not establish:
- a universal non-legal definition of authority.

### CRPD Committee General Comment No. 1 (2014)

Inspected view:
- official OHCHR PDF, page 3 of the document as rendered, paragraphs 12–14.

Source:
- https://docstore.ohchr.org/
- Document symbol: CRPD/C/GC/1

Supports:
- explicit doctrinal distinction between legal capacity/legal agency and mental capacity/decision-making skill.

Use limitation:
- this is a disability-rights legal doctrine, used here only as a strong counterexample to semantic collapse of `capacity`; it is not generalized into a universal competence theory.

## Residual uncertainty

- `Competence` itself is domain-specific and may require skill, qualification, certification or demonstrated performance distinctions later.
- The boundary between institutional permission and authority/power differs across legal, organizational and technical contexts; the foundation result is that they cannot be assumed identical.
