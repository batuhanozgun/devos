# Cross-Ground Transition / Propagation — P7 Adversarial Closure

**Status:** COMPLETE / BOUNDED CHILD CLOSURE  
**Date:** 2026-09-06  
**Verification class:** same-model adversarial review; NOT independent replication

## 1. Closure target

Attack the P6 result:

```text
Cross-Ground Transition / Propagation
    ← bounded leaf
    ← no immediate child promoted
```

A successful attack must change the structure or reopen an upstream boundary, not merely produce another useful profile.

## 2. Attack — `Realization` and `Propagation` are two children

### Argument
One question asks whether a target changed; another asks whether change spread.

### Counter-analysis
For this **cross-ground** child, realized transition is the core object and propagation is the relation among realized changes across ground boundaries/dependencies. Splitting them would produce:
- one child that is merely the parent's semantic core;
- one child that carries the defining cross-ground shape.

A Work action → Environment effect case may have only one downstream effect, but the cross-ground question is already whether the change realized across the Work/Environment boundary.

### Disposition
**Attack fails.**

## 3. Attack — Convergence deserves an immediate child

### Argument
In distributed systems, convergence can be the main correctness problem with distinct evidence and recovery Work.

### Counter-analysis
This is domain-important but not Foundation-universal.

`Converged` requires:
- an applicable target/scope set;
- a criterion defining acceptable agreement/state;
- current realized transition facts;
- reference time and possibly evidence.

This has the form of Composite Standing.

Furthermore:
- some systems intentionally remain heterogeneous;
- different targets can correctly receive different results;
- convergence can be partial/graded/unknown;
- reconciliation Work is distinct from convergence truth.

### Disposition
**Attack fails.** Keep convergence as Transition dimension + Standing profile.

## 4. Attack — Invalidation is a missing child

### Argument
Dependency change causing stale/invalid prior decisions is sufficiently important to deserve its own branch.

### Counter-analysis
The exact transition fact is:

```text
validity dependency D changed at scope/time S
```

The resulting consequences differ:
- previous assessment stale;
- standing false;
- standing unchanged;
- control applicability changed;
- unknown pending re-evaluation;
- no material consequence.

No coherent Transition-only protected question remains after Standing/Control ownership is restored.

### Disposition
**Attack fails.**

## 5. Attack — Recovery / rollback / compensation is a missing child

### Argument
Failures and reversals have distinct lifecycle/evidence semantics.

### Counter-analysis
Recovery decomposes without loss:
- recovery/rollback/compensation/reconciliation activity → Work;
- governing retry/rollback policy → Control;
- actual changed state → one or more new Transition episodes;
- restored/acceptable/converged → Standing.

Crucially:

```text
rollback != time reversal
compensation != reversal
```

A separate Recovery child would mix Work with realized results.

### Disposition
**Attack fails.**

## 6. Attack — The leaf is just a generic dynamics bucket

### Argument
The grammar is broad enough to absorb any change.

### Counter-analysis
Routing is intentionally restrictive:

```text
ground-local dynamics
!= cross-ground Transition / Propagation
```

The child requires irreducible cross-ground semantics such as:
- Work execution versus Environment realization;
- Control change versus endpoint/behavioral effect;
- authority/binding change versus downstream qualification/use;
- Information change versus Work/Actor/Environment response where the transition question spans them.

If other-ground anchors can be removed without changing the protected question, route locally.

### Disposition
**Attack fails.** Protected question remains non-generic.

## 7. Attack — `effective` is too ambiguous for a coherent grammar

### Argument
Legal effectiveness, technical application, behavioral effect and causal effectiveness differ.

### Counter-analysis
Agreed; therefore `effective` is never accepted unqualified.

Required discipline:

```text
effective for what / where / whom / which operation / which time?
```

Causal effectiveness is explicitly routed to Causal Effect/Contribution.

The ambiguity is a reason for exact scope/meaning, not for structural collapse.

### Disposition
**Attack fails; terminology guardrail retained.**

## 8. Attack — Continuous transitions break transition identity

### Argument
The model is secretly discrete-event based.

### Counter-analysis
P1 explicitly permits baseline/trajectory rather than mandatory before/after points. Transition identity can refer to a continuous/gradual material change at selected resolution.

No universal event boundary or timestamp is required.

### Disposition
**Attack fails.**

## 9. Attack — Multiple origins/no source break propagation

### Argument
Propagation language implies one source broadcasting a change.

### Counter-analysis
The grammar does not require one source. A propagation episode can contain:
- multiple initiating transitions;
- mutually dependent changes;
- emergent change;
- scope-specific effective changes;
- no authoritative `commit` event.

Typed Binding/dependency semantics determine how transition instances relate.

### Disposition
**Attack fails.**

## 10. Attack — Propagation relation smuggles causation

### Argument
Saying A propagated to B already claims A caused B.

### Counter-analysis
The child must distinguish:
- temporal/order relation;
- dependency/application relation;
- synchronization/distribution relation;
- realized downstream change.

It may state a propagation/dependency episode without proving a causal explanation. Strong causal attribution remains sibling work.

```text
transition path / dependency sequence
!= causal proof
```

### Disposition
**Attack fails with explicit boundary.**

## 11. Attack — Unknown applicable scope makes full propagation unusable

### Argument
If the endpoint/dependent universe is incomplete, propagation completeness cannot be established.

### Counter-analysis
Correct. The appropriate result may be `unknown / not fully evaluated`, not forced false/true.

This is a Standing/evidence issue and reinforces frame-blindness discipline:

```text
observed all known targets updated
!= all materially applicable targets known
!= full propagation established
```

### Disposition
**Attack fails; uncertainty boundary strengthened.**

## 12. Attack — External holdouts are software-heavy

### Argument
AWS/Google/OpenTelemetry could bias the grammar toward distributed computing.

### Counter-analysis
NASA configuration management and institutional rule effective/compliance staging independently reproduce the core non-collapse without state-replication assumptions:

```text
approved/published
!= incorporated/effective
!= implemented/complied-with
!= verified/observed
```

W3C PROV adds information/provenance pressure.

### Disposition
**Attack fails.** More domain holdouts may still reopen later if they break the routing test.

## 13. Attack — Rename to `Realized Transition / Propagation`

### Argument
Current label could be read as planned transitions.

### Counter-analysis
`Realized` is the canonical gloss and should remain prominent. Renaming is not structurally necessary and would create churn without eliminating all ambiguity.

### Disposition
**No rename forced.** Preserve label and gloss.

## 14. Upstream reopen audit

### Relational Binding
No missing distinction found.

### Composite Standing
No reopen. Convergence/completeness/currentness correctly remain Standing-facing.

### Control
No reopen. Control-change rollout is Transition; governing meaning remains Control.

### Environment / Information / Work / Actors
No boundary theft that requires a ground reopen.

### Transition / Effect / Feedback parent
Three-child structure remains coherent.

### Four-ground adequacy
No fifth ground exposed.

## 15. Remaining sibling sequencing adversarial check

Candidates:
1. Cross-Ground Causal Effect / Contribution
2. Cross-Ground Feedback / Adaptation

### Case for Feedback next
Transition facts are sufficient to ask whether observations returned and changed later behavior; causal analysis of the original effect is not always necessary.

### Case for Causal Effect next
- exact realized effect identity is now available, removing its main prerequisite;
- control-effectiveness, incident explanation, prevention/detection and responsibility-adjacent questions are high-pressure residuals;
- feedback/adaptation can overclaim learning or improvement if post-intervention change is mistaken for causal impact;
- causal analysis can later help discriminate whether persistent adaptation actually produced the claimed outcome change.

### Judgment

> **Cross-Ground Causal Effect / Contribution remains the stronger next child.**

This is sequencing recommendation only; it is not active.

## 16. Verification boundary

This closure is:
- source-grounded in accepted repository surfaces;
- externally pressure-tested across multiple traditions;
- same-model adversarially reviewed.

It is **not**:
- independent second-researcher/model replication;
- proof that no future domain can force a split;
- an ontology/schema/architecture validation.

## 17. Final bounded judgment

```text
Cross-Ground Transition / Propagation
    ← BOUNDED LEAF / READY FOR USER EVALUATION
    ← no immediate child promoted
```

Stable shortest rule:

> Preserve the exact realized change, its scope/time and propagation dependencies; never infer realization from request/approval/record, global effect from local change, or observation from occurrence.

## 18. Recommended next frontier if accepted

> **Cross-Ground Causal Effect / Contribution**

Do not activate automatically.
