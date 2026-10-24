# Informational State / Representational Constitution — N4 Boundary and Anti-Collapse Tests

**Status:** COMPLETE; provisional bounded-leaf result survives neighbouring-ground and sibling attacks  
**Date:** 2026-09-05  
**Dependency:** `N3-IMMEDIATE-CHILD-DISCOVERY.md`

## 1. Purpose

Attack the N3 leading result:

> `Informational State / Representational Constitution` is a bounded leaf at the current Foundation depth, with explicit internal constitution dimensions rather than promoted immediate children.

The attack asks whether this no-split result:

- steals Environment, Work, Actors, Dynamics or Records semantics;
- hides a stable first-order child;
- fails under role-switching and multi-state cases.

---

# 2. Environment boundary — represented condition vs realised condition

## Case A — room-temperature estimate

State-side questions:

- referent: which room/property?
- applicability: which time/window/reference frame?
- content: 20°C, interval/distribution, model output?
- mode: observation result, estimate, forecast?
- uncertainty/standing: ±0.5°C, confidence/basis?
- source/perspective: sensor/system/operator?

Environment question:

- what temperature condition is actually realised?

### Attack result

All State dimensions can be correct as representation metadata while the represented value is factually wrong. Conversely, the actual condition can be stable while State reference/scope/mode changes.

No State subdimension needs to become an Environment child or vice versa.

**Boundary survives.**

---

# 3. Dynamics boundary — source state, transformation, output state

## Case B — source report → summary

Input State:

- exact source content, scope, mode, identity, attribution.

Dynamics:

- selection, summarisation, translation, aggregation.

Output State:

- new representation with its own scope/content/form/mode/identity/standing.

### Failure probe

The summary may:

- preserve target and meaning correctly;
- alter quantifier/scope;
- lose uncertainty;
- change `reported` into `established` stance;
- collapse two source identities into one apparent fact.

These are output-State constitution failures caused by a Dynamics operation.

### Attack result

The State leaf map can describe both input and output without absorbing the transformation. Identity/standing do not need a child branch to preserve this separation.

**State/Dynamics boundary survives.**

---

# 4. Work boundary — representation of plan/status vs actual Work

## Case C — `done` status

An informational state may represent:

- `planned`;
- `in progress`;
- `done`;
- `verified`;
- `accepted`.

State-side mode/semantics must preserve what the label actually asserts and relative to which Work item/version.

But actual:

- commitment;
- execution;
- verification;
- acceptance

remain Work phenomena.

### Failure probe

Changing the status representation to `done` can leave execution incomplete. Actual completion can occur while the status remains stale.

### Attack result

Normative/operational content does not force a `Plan/Status` State child. It is one representational mode with Work-relative referent and standing.

**Boundary survives.**

---

# 5. Actors boundary — source, holder, belief, authority

## Case D — quoted expert claim

Potential State dimensions:

- content: claim X;
- mode: quoted assertion, not system endorsement;
- origin/source: expert E;
- holder: system store;
- perspective: E's reported position;
- reliability/evidential standing: separately assessed.

Actors owns:

- who E is;
- E's role/capability/authority/obligation;
- delegation/accountability.

### Failure probe

Correct attribution does not establish truth. Actor authority for one role does not make every representation from that Actor universally authoritative.

### Attack result

Attribution/perspective is State-significant but relational; it does not justify a State child that would absorb Actor semantics.

**Boundary survives.**

---

# 6. Records boundary — identity/persistence holdout

## Case E — transient report becomes audit record

Before persistence:

- State already has referent, content, form, mode, identity, attribution, standing.

When persistence obligations activate:

- exact version/representation binding;
- preservation closure;
- survivable provenance/context;
- historical standing;
- retrieval guarantees;
- retention/disposition

become load-bearing.

### Failure probe

A persistent copy can preserve the wrong version or false claim perfectly.

### Attack result

State identity/granularity/equivalence remains needed before and after persistence. Records deepens horizon/lifecycle obligations but does not create an immediate State child.

**Boundary survives.**

---

# 7. Context/view boundary — current visible State vs source universe

## Case F — selected LLM working context

- source repository/web/memory resources → source informational states;
- retrieval/ranking/filter/compression → Dynamics;
- model-visible package → selected/projected informational State;
- current Work/query/purpose → relevance relation;
- permissions/tool availability → Actors/control/Environment dependencies.

### State-side failure

The visible view may be internally coherent but:

- omit a qualifying sentence;
- show the wrong version;
- lose source attribution;
- collapse historical and current content;
- make a hypothesis look like accepted state.

### Attack result

A contextual view is representational State, but `Context` still does not form a State child: the same constitution dimensions apply to source states and selected views.

**No child forced.**

---

# 8. Conflict/plurality attack

## Case G — two temperature reports disagree

Before calling them contradictory, comparison requires:

- same referent/property?
- same applicable time?
- same unit/reference frame?
- same mode (observation vs forecast)?
- same granularity?
- compatible uncertainty intervals?
- distinct sources or copied lineage?

### Result

Conflict is not a self-contained kind of informational state. It is a **relation over constituted states plus comparison criteria**.

Resolution/revision belongs to Dynamics/Work/authority depending on focal question.

**No `Conflict` child forced.**

---

# 9. Truth / evidence / authority anti-collapse

Keep distinct:

```text
state exists
!= state is interpreted correctly
!= represented claim is true
!= state is evidence for target claim
!= source is authoritative for role
!= evidence is sufficient for decision
!= decision is authorised/committed
```

### Result

State standing can encode/represent these relations or statuses, but their force may depend on Environment, other Information, Actors or Work.

A generic `Epistemic Standing` State child would therefore own a mixture of local qualification and cross-ground relation semantics.

**No child forced.**

---

# 10. Identity/equivalence anti-collapse

## Case H — same text, different state

Two byte-identical strings can differ materially because:

- they refer to different target versions;
- one is quoted and one asserted;
- one is current and one historical;
- they originate independently or one is a copy;
- they use different schema/units/interpretation conventions.

## Case I — different representation, same protected content

Different JSON/text/graph encodings can be equivalent for one use but not for another if precision, provenance or structural detail matters.

### Result

Identity/equivalence is deeply load-bearing but fundamentally **relational and purpose-sensitive over multiple constitution dimensions**.

Promoting it as a child would not make those dependencies disappear.

**No child forced.**

---

# 11. Role-switching test

The same concrete artifact can be:

- source State for one transformation;
- derived output State for another;
- evidence relative to a claim;
- context relative to current Work;
- persistent Record under audit obligations;
- representation of an Actor's position;
- representation of an Environment condition.

The concrete artifact need not move among State children because these roles are captured by relations/qualifications around one representational constitution.

This is positive evidence for a leaf-with-dimensions model and against noun/type child taxonomies.

---

# 12. N4 verdict

The provisional no-child result survives boundary and anti-collapse attack.

```text
Informational State / Representational Constitution   ← bounded-leaf candidate strengthened

No immediate child currently required.
```

The internal map remains load-bearing:

- reference/applicability;
- content/interpretation/form;
- mode/stance;
- identity/equivalence/granularity;
- attribution/perspective;
- uncertainty/standing/freshness;
- plurality/conflict relations;
- availability/persistence status where State-side.

N5 must now test materially different external traditions for a hidden structural split or forced-fit case. No external taxonomy may be imported merely because it provides named classes.
