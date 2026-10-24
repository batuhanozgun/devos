# Relation / Control / Composition — C1 Semantic-Kind Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Question

What fundamentally different research objects are currently being mixed under the phrase `typed relations / control / transitions`?

The objective is not to freeze vocabulary. It is to prevent category collapse before pairwise and multi-ground relation discovery.

## 2. Candidate A — Relational Binding

Protected question:

> What typed connection holds among already-distinguished ground anchors, under what role/scope/time/reference frame?

Examples:
- Information represents Environment condition;
- Actor participates in Work;
- Work targets Environment condition;
- Work uses/produces Information;
- Actor is source/holder/asserter of Information;
- Work depends on Environment condition;
- Actor acts on behalf of another Actor in a Work context.

Characteristic failure modes:
- wrong endpoint type or reference frame;
- wrong directionality;
- role collapse (`performer = authorizer`);
- scope/time loss;
- relation inferred from co-occurrence;
- relation represented in Information but mistaken for actual standing;
- generic `related-to` hiding materially different semantics.

Current judgment:

**Distinct research object.** It asks how anchors are semantically connected, not whether a composite status follows or whether a transition is allowed/occurs.

## 3. Candidate B — Derived Standing / Qualification

Protected question:

> What criterion-relative or use-relative standing follows only from a constellation of ground states/relations rather than belonging intrinsically to one ground?

Examples:
- `actionable now`;
- `authorized for this action in this context`;
- `verified against criterion C at target version V`;
- `validated / fit for intended use`;
- `accepted by authorized party`;
- `goal/outcome satisfied`;
- `evidence sufficient for decision D`;
- `current/relevant/usable for this Work`.

Characteristic failure modes:
- attaching the standing to one ground as an intrinsic property;
- omitted criterion/reference/use;
- stale evidence or target version;
- authority omitted from acceptance;
- actual Environment outcome omitted from attainment;
- permission confused with situated actionability;
- a represented status treated as the standing itself.

Important rule:

```text
composite standing
!= a single local status copied from one ground
```

Current judgment:

**Distinct research object.** These standings behave more like evaluated/computed cross-ground qualifications than ordinary binary relations.

## 4. Candidate C — Control / Constraint

Protected question:

> What structures govern which transitions/actions are permitted, required, blocked, gated, escalated or conditioned, and how are normative standing, decision logic and realized enforcement kept distinct?

Examples:
- Actor authority to approve Work transition;
- policy/rule constraining an operation;
- Work gate requiring verification evidence;
- Environment sandbox/network restriction blocking an otherwise capable Actor;
- separation-of-duty condition;
- escalation/ask-human threshold;
- obligation triggering Work.

Characteristic failure modes:
- policy text mistaken for effective control;
- authority mistaken for technical reach;
- technical blocking mistaken for institutional prohibition;
- control decision mistaken for actual enforcement;
- local denial bypassed by another path;
- human involvement assumed to imply authority;
- obligation and permission collapsed.

Protected non-collapse:

```text
policy representation
!= normative authority
!= authorization decision
!= technical enforcement
!= observed compliance
```

Current judgment:

**Distinct research object.** Control is not merely a descriptive relation because it concerns admissible/required transition structure and failure/bypass behavior.

## 5. Candidate D — Transition / Effect / Feedback

Protected question:

> How do changes in one or more grounds lead to, condition or become related to changes in other ground states over time?

Examples:
- Work attempt → Environment change;
- Environment event → Information observation;
- Actor decision → Work admission;
- new evidence → verification/acceptance standing change;
- revoked authority → changed allowed Work path;
- incident → diagnosis Work → changed control/configuration;
- Work provisioning → changed Work Conditions;
- delegation → changed Actor standing and reachable execution path.

Characteristic failure modes:
- sequence mistaken for causation;
- intended effect mistaken for realized effect;
- informational update mistaken for world change;
- derived standing change mistaken for local state change;
- missing trigger/precondition;
- propagation/freshness lag ignored;
- feedback loop described without exact state/evidence/authority transitions.

Current judgment:

**Distinct research object.** A static relation snapshot cannot fully answer how the composed system changes, recurs or propagates effects.

## 6. Candidate E — Evidence / Provenance as a separate immediate region?

Evidence and provenance are clearly load-bearing but do not currently justify their own peer at this parent level.

Why:
- source/derivation/attribution are typed relational bindings;
- evidential sufficiency is a derived standing relative to a claim/criterion/use;
- provenance can change or be generated through transitions;
- verification/acceptance can place controls around evidence use.

Therefore evidence/provenance currently behaves as an **important semantic family spanning A–D**, not a fifth peer region.

Reopen if later probes show provenance/evidence has a protected question not recoverable through those regions without forced loss.

## 7. Candidate F — Causation as a separate immediate region?

Causation is materially different from generic correlation/sequence, but current evidence does not yet justify a separate parent child.

Causal claims appear primarily in:
- binding semantics (`contributed-to`, `caused`);
- transition/effect analysis;
- derived confidence/attribution standings;
- control/effectiveness reasoning.

Causation therefore remains a **cross-cutting semantic dimension** entering C2/C3, not an accepted immediate child.

## 8. Candidate G — Participation / role as separate from relational binding?

Actor participation/role is highly important but is already a deep Actors-local distinction. Cross-ground participation behaves as a specialized relational binding:
- Actor performs Work;
- Actor authorizes Work;
- Actor is affected/beneficiary in relation to Environment/Work;
- source/holder/asserter positions relative to Information.

No separate composition child is currently required merely because participation relations are rich.

## 9. Candidate H — Mechanism / implementation

Mechanism must be explicitly excluded from parent semantics.

Examples that are **not** Foundation composition kinds by themselves:
- graph edge storage;
- relational-table foreign key;
- policy engine;
- workflow engine;
- event bus;
- agent router;
- vector retrieval;
- CI gate implementation;
- sandbox product;
- OAuth token format.

These can realize one or more composition semantics but cannot define the research map.

## 10. Provisional four-region frame entering C2/C3

```text
Cross-Ground Composition
├─ Relational Binding
├─ Derived Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

**Status:** PROVISIONAL ONLY.

This frame earns continued testing because the four regions have distinct protected questions and failure modes.

It is not yet promoted as the parent’s immediate-child structure.

## 11. Key diagnostic tests

When encountering a candidate composition statement, ask:

1. Is it primarily saying **what is connected to what and in what role**? → Binding candidate.
2. Is it saying **what standing follows when several facts/relations/criteria are jointly considered**? → Derived-standing candidate.
3. Is it saying **what is allowed/required/blocked/gated and by what authority/enforcement structure**? → Control candidate.
4. Is it saying **what changed, what triggered/effected it, or how the loop propagates over time**? → Transition candidate.

Multiple answers may be `yes`. The regions are problem perspectives, not exclusive event buckets.

## 12. C1 judgment

The phrase `relations / control / transitions` was too compressed.

A meaningful parent composition problem exists, and the provisional four-region frame is stronger than a flat relation list.

However, C2 pairwise probes and C3 multi-ground hard cases must now test whether:
- the regions are complete enough;
- they are too overlapping to serve as children;
- one region is merely a dimension of another;
- evidence/provenance/causation forces another region;
- multi-ground cases invalidate the frame.

Proceed to C2.