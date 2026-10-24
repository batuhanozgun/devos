# Domain State Finding 05 — Identity, Constraints and Granularity Are Cross-Cutting at This Level

**Status:** active-node finding  
**Date:** 2026-09-02

## Question

Do `Identity / Continuity`, `Constraints / Invariants` or `Granularity / State Sufficiency` require promotion to immediate Domain-State children?

## Current finding

**Not at the current level.** All three are load-bearing, but current evidence makes them stronger as cross-cutting problem dimensions/prerequisites than as co-equal State children.

---

## 1. Identity / Continuity

Question:

> What is being treated as the same constituent/domain whole across replacement, mutation, aggregation or boundary change?

Why it matters:
- constituent presence is meaningless without some identity criterion;
- property/status claims require a bearer;
- structural comparison across time requires deciding whether two instances/wholes count as the same relevant thing;
- Dynamics later needs the same identity relation to say that one thing changed rather than one thing disappeared and another appeared.

Why it is not currently a State child:
- it cuts across Structure and Condition;
- it also crosses the State/Dynamics sibling boundary;
- criteria vary by domain and protected reasoning purpose;
- prior Technical Work Environment research found multi-level instance/profile/equivalence identity rather than one universal criterion.

The current SEP `Identity Over Time` treatment independently confirms that persistence through change is a distinct problem, but it is explicitly a through-time problem—another reason not to localize it solely under a current-State child.

**Status:** explicit cross-cutting prerequisite; reopen if a later pass finds stable Domain-local identity semantics requiring a dedicated branch.

---

## 2. Constraints / Invariants

Question:

> What limits which structures/conditions are possible, admissible, stable or valid?

Why they matter:
- constraints can exclude states;
- invariants can hold across all reachable states;
- physical/legal/institutional limits can shape both State and Dynamics.

Why they are not currently a State child:
- a constraint is not generally the same thing as the current state that satisfies or violates it;
- transition-system/control traditions represent invariants/constraints as predicates or limits over state variables and/or transitions;
- many constraints directly govern Dynamics as well as State;
- represented rules/specifications may belong to Information while their realized institutional/physical effect can participate in Domain Reality.

If a current condition is itself `constraint currently active/binding`, that fact can appear under Condition/Status without turning the rule/constraint family into a third child.

**Status:** cross-cutting admissibility/possibility-space dimension.

---

## 3. Granularity / State Sufficiency

Question:

> Which realized facts must be included for a particular reasoning purpose, and at what abstraction/scope?

Why it matters:
- too-coarse state omits load-bearing facts;
- too-fine state can make reasoning intractable;
- current snapshot can be insufficient when hidden history affects the future.

Why it is not currently a reality child:
- formal MDP/state-space traditions define a state representation to contain sufficient information for prediction/decision under a model;
- this is a criterion on the **selected representation of reality**, not evidence that actual reality is intrinsically partitioned by one universal state vector;
- different protected questions can require different state selections from the same realized domain.

Therefore:

```text
actual Domain State
≠ one universally sufficient state representation
```

**Status:** purpose/reference/representation-selection dimension spanning Structure and Condition and touching Information/composition.

---

## Combined result

Current immediate hierarchy remains most economically:

```text
Domain State
    ├─ Domain Structure / Composition
    └─ Domain Condition / Status
```

with explicit cross-cutting dimensions:
- identity/continuity;
- scope/granularity;
- constraints/invariants;
- time index/currentness;
- actual-versus-represented boundary.
