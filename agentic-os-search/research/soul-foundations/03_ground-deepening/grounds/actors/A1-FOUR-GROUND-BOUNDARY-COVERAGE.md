# Actors Ground Audit — A1 Four-Ground Boundary / Coverage

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Question

Does the prior Actors corpus remain coherent when the now-accepted Information, Environment and Work boundaries are applied, or does it absorb facts that belong elsewhere?

## 2. Protected Actors-local question

The strongest boundary that survives is not `things that act`.

A more robust research-level question is:

> **Which persistent bearers/positions and typed participation, agency, authority/obligation, representation/delegation, attribution/responsibility and collective/non-human standing relations are relevant in a situation, and how can those relations vary independently across context and time?**

This remains distinct from:

- what the world/runtime actually permits or contains (Environment);
- what representations say about those bearers/relations (Information);
- what pursuit is selected, structured, executed or closed (Work).

The `Actors` label remains an umbrella/retrieval label, not proof of one natural Actor entity class.

---

## 3. Actors ↔ Information

### 3.1 Standing vs representation of standing

Examples:

- a directory says Alice has role `release-manager`;
- a token contains a delegation claim;
- a repository file says a reviewer is authorized;
- a log says Agent B performed an action;
- an audit report says Team X is accountable.

All are informational states.

They can be current, stale, forged, incomplete, scoped differently or interpreted incorrectly.

Therefore:

```text
identity/role/authority/delegation/accountability representation
!= actual identity/role/authority/delegation/accountability standing
```

Actors owns the semantic distinction being asserted; Information owns the representation and its identity/source/freshness/derivation/exposure properties.

### 3.2 Evidence of participation vs participation

A trace/log can support a claim that a bearer performed/decided/approved, but trace existence is not the episode relation itself.

This matters for:

- missing logs;
- shared credentials;
- impersonation/proxying;
- stale role data;
- incorrectly attributed automated action.

### 3.3 Delegation token vs delegation relation

RFC-like token/claim structures are useful evidence/mechanisms but do not make the delegation relation purely informational. The claim can be invalid, expired, outside scope or inconsistent with the relevant institutional authority.

### A1 result

**No Actors boundary failure.**

Boundary correction:

> Actor standing/relations and Information about them must be explicitly separable.

This strengthens rather than falsifies the prior Actors multi-anchor frame.

---

## 4. Actors ↔ Environment

### 4.1 Capability/competence vs realized actionability

The prior corpus correctly separated capability/competence from permission/authority, but accepted Environment research makes another distinction explicit:

```text
Actor capability / competence
!= Environment resource/tool/interface/access condition
!= situated actionability
```

Examples:

- an engineer is competent to deploy but the production endpoint is unavailable;
- an agent can reason about a database but lacks network access;
- a bearer is authorized to sign but the signing key is inaccessible;
- a model can call a tool in principle but the runtime has disabled it.

The actor-side fact and environment-side fact can vary independently.

### 4.2 Permission/authority vs technical enforcement

A bearer may be institutionally unauthorized yet technically able to act because credentials or network paths are over-permissive.

Conversely, a bearer may be authorized while a sandbox or policy-enforcement layer blocks the operation.

Therefore:

```text
institutional/normative authority
!= technical ability to cause effect
!= runtime enforcement outcome
```

Technical enforcement is an Environment/control condition; authority/permission remains a typed Actors/normative relation.

### 4.3 Non-human actor vs enabling substrate

An AI/software participant is not identical to:

- the model binary;
- the process/container;
- the credential;
- the tool set;
- the host/network;
- the orchestration runtime.

Those Environment constituents can materially determine what the operational participant can actually do.

### A1 result

**No Actors boundary failure.**

The term `capability` must be kept scoped. Actors-local capability/competence concerns bearer capacities; situated executable possibility is a cross-ground result involving Environment.

---

## 5. Actors ↔ Work

### 5.1 Participation/assignment vs Work identity/state

A Work pursuit can persist while performers change. A bearer can participate in many Work contexts.

Therefore:

```text
Actor assignment/participation
!= Work identity
!= Work admission/execution state
```

Reassignment does not inherently create a new Work pursuit; participant continuity and Work continuity are separable questions.

### 5.2 Work admission vs Actor obligation/authorization

Accepted Work research established:

```text
Work selected/admitted/required
!= Actor obligated/authorized
```

A candidate may be admitted without a particular bearer owing a duty; an Actor may have a standing duty before a specific Work instance is admitted; an Actor may be authorized but not assigned; assigned but not authorized; obligated but unable to act.

This resolves a dual-use risk around `commitment`.

For Work, prefer selection/admission/undertaking semantics.

For Actors, preserve promise/obligation/authority/representation semantics where relevant.

### 5.3 Acceptance standing vs authority to accept

A Work item can reach a state where acceptance is required, but that does not determine who has authority to accept it.

The acceptance act/judgment may be Work; authority to make it is Actors-side; evidence/decision artifact is Information; target condition may be Environment.

### 5.4 Continuing Work vs continuing responsibility

A service or stewardship activity can continue while role occupants change. Conversely, an Actor can retain accountability for a bounded past episode after execution has ended.

Therefore continuing Work and continuing responsibility are not the same temporal regime.

### A1 result

**No Actors boundary failure.**

The prior participation/authority/accountability distinctions become cleaner once Work standing is kept separate.

---

## 6. Effective / transitive authority boundary

The strongest new agentic pressure is a path such as:

```text
Agent A
  can invoke Agent B
Agent B
  can use privileged tool/credential
=> Agent A may produce an effect it could not produce directly
```

It is tempting to call this `A has transitive authority`.

That phrase is dangerous because several facts can differ:

1. A's **institutional authority** may still be absent.
2. A may have **technical reachability/actionability** through B.
3. B may have its own authority/capability.
4. A→B invocation may or may not constitute valid delegation.
5. The system may mechanically permit a path that policy forbids.
6. Responsibility/accountability may remain with A, B, a principal, an owner or another forum-dependent party.

Therefore effective power/effect reach is currently best understood as a **derived cross-ground path property**, not a new primitive authority type:

```text
Actor relations
+ Environment access/capability graph
+ Work/orchestration path
+ policy/authorization conditions
→ effective ability to cause an effect
```

### A1 result

H4 remains a live audit case, but **not yet a missing Actors-local family**.

The prior corpus already supplies:

- relational/scoped authority;
- combinatorial authorization;
- delegation chain/history;
- performer/principal separation;
- operational vs legal/institutional attribution.

What is newly sharpened is the need not to infer authority from effective technical reach.

---

## 7. Responsibility / accountability under four-ground divergence

A useful failure case is:

- Work says a review was required;
- Information records that a reviewer approved;
- Environment actually ran a privileged effect;
- Actors evidence later shows the approving identity lacked authority or was impersonated.

No single ground can settle the whole claim.

Actors must preserve:

- whose identity/role/authority was relevant;
- who actually participated if recoverable;
- who was represented;
- which responsibility/accountability regime applies.

It must **not** own:

- the log itself;
- actual environment effect;
- Work closure state.

This boundary is coherent.

---

## 8. Boundary status of A0 hypotheses

### H1 — Actors steals Information

**Rejected as necessary.** The current Actors semantics can remain distinct from their representations. Explicit anti-collapse rule added.

### H2 — Actors steals Environment actionability

**Rejected as necessary.** Actor capability/authority vs Environment conditions vs situated actionability can be separated. Explicit anti-collapse rule added.

### H3 — Actors steals Work semantics

**Rejected as necessary.** Participation/assignment/obligation/authority can remain distinct from Work admission/requiredness/state.

### H4 — Effective/transitive authority missing

**Still live but weakened.** Current evidence favors a cross-ground derived path property rather than a new Actors family.

### H5–H10

Remain for A2/A3.

---

## 9. A1 boundary corrections retained

```text
Actor standing
!= representation/evidence of Actor standing

Actor capability/competence
!= Environment availability/access
!= situated actionability

Actor authority
!= technical ability/effective reach
!= runtime enforcement outcome

Actor participation/assignment
!= Work identity/admission/execution

Work requiredness
!= Actor obligation

Work acceptance state
!= authority to accept

operational effect by system
!= legal/institutional attribution
!= accountability
```

## 10. A1 judgment

The Actors problem region survives the accepted neighboring grounds without becoming residual or duplicative.

The new boundaries **sharpen** the old corpus rather than forcing a top-level split or elimination.

No targeted Actors deepening is justified by boundary theft alone.

Next: A2 first-order omission/gap test.
