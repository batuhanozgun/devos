# Domain State — Integrated Synthesis

**Status:** BOUNDEDLY SUFFICIENT FOR CURRENT IMMEDIATE-CHILD PURPOSE; AWAITING USER EVALUATION  
**Date:** 2026-09-02  
**Scope:** Environment → Domain Reality → node previously labeled `Domain State / Configuration`; immediate-child discovery only

## Executive result

The node survives deeper research, but its label and internal decomposition are refined.

Starting label:

```text
Domain State / Configuration
```

Strongest current bounded result:

```text
Domain State
    ├─ Domain Structure / Composition
    └─ Domain Condition / Status
```

The children are analytical problem branches, not object classes, schema sections or mandatory fields.

The core distinction is:

> **What is actually there and how is it organized?**  
> versus  
> **What condition/status actually holds for those constituents or the selected whole?**

This distinction repeatedly changes failure analysis and later reasoning across technical, physical, ecological, institutional, market and hybrid domains.

---

# 1. Why the node is renamed to Domain State

`Configuration` was useful in the parent pass because it signaled that State includes more than scalar health values. Deeper research shows, however, that `configuration` is too ambiguous for the parent label.

Across disciplines it can refer to:
- arrangement/composition/topology;
- settings/parameters;
- a baseline/specification;
- a documented inventory/version;
- a live realized configuration.

These are not equivalent.

The cleaner working node label is therefore:

> **Domain State**

with an explicit project definition:

> **Domain State is the realized domain condition/situation that obtains at a selected reference, scope and time, including materially relevant structural/compositional facts and materially relevant current condition/status facts.**

`State` here does not require:
- one formal state vector;
- full observability;
- one stored snapshot;
- one database object;
- one universal granularity;
- Markov sufficiency.

Those are possible representation/model choices, not the reality node by identity.

---

# 2. Immediate Child A — Domain Structure / Composition

Primary question:

> **What materially relevant constituents are actually present, and how are they actually composed, arranged, connected or structurally related at the selected scope/time?**

Includes when material:
- constituent/member presence;
- part–whole composition;
- nesting/aggregation;
- realized connections/interfaces;
- topology/network organization;
- containment/placement/arrangement;
- structural relations required to characterize the selected whole;
- actual installed/deployed/assembled composition.

## Failure surfaces

- missing/extra/wrong constituent;
- wrong part–whole decomposition;
- stale/wrong topology;
- correct constituent list with wrong organization/connections;
- design/inventory/model mistaken for realized structure;
- structural change silently crossing an identity boundary.

## Why constituents and relations are not separate children

A three-way primitive decomposition was tested:

```text
Constituents
Relations / Topology
Properties / Status
```

It was rejected for current project depth.

Reason:
- elements plus organizing relationships jointly answer the same first-order structural question;
- systems traditions repeatedly bind them together under structure/composition;
- separating them mainly mirrors graph/ontology/data-model primitives;
- their failure recovery normally requires reconstructing the realized organization as a whole.

This does not claim that constituent and relation errors are identical. It says they belong to one first-order structural problem region at the present level.

---

# 3. Immediate Child B — Domain Condition / Status

Primary question:

> **What materially relevant properties, values, qualities, health, mode, status or standing actually hold for the selected constituents/domain whole at the selected scope/time?**

Includes when material:
- current property/value;
- operating/health condition;
- current mode/status;
- physical/chemical/biological condition;
- current quantitative/qualitative values;
- current social/institutional standing in its Domain role;
- current condition of the selected whole as distinct from individual parts.

## Failure surfaces

- stale/wrong property/value/status;
- right structure but degraded/unhealthy condition;
- correct part-level values but wrong whole-state conclusion;
- reported/cached status substituted for actual condition;
- desired/allowed condition substituted for realized condition;
- institutional/Actor/Information semantics incorrectly swallowed into Environment.

## Why property/status types are not separate universal children

Possible subdivisions such as:
- intrinsic properties;
- relational properties;
- quantitative values;
- health;
- institutional standing;
- mode/status
were tested.

They remain domain-specific property families. Their common first-order question is whether the **realized condition currently holding** has been characterized correctly.

A relation can therefore appear in Condition/Status if its semantic role is current standing rather than structural organization. The hierarchy is not based on graph arity.

---

# 4. Why Structure and Condition qualify as children

The split passed the project child-promotion test.

## Distinct first-order questions

- Structure / Composition → **what is present and how is it organized?**
- Condition / Status → **what condition/properties/standing currently hold?**

## Distinct failure modes

Examples:
- correct health over wrong topology;
- correct topology with unhealthy/degraded component;
- correct measured values for an incomplete constituent set;
- correct institutional structure with changed current standing.

## Cross-domain recurrence

The distinction remained useful in:
- deployed software/product systems;
- manufacturing/physical assets;
- ecological systems;
- social/institutional domains;
- financial/market domains;
- scientific specimens/experimental systems;
- hybrid physical/digital systems/digital-twin targets.

## Operationally different external traditions

Configuration/structure disciplines and asset-condition/health disciplines solve different operational problems even when they refer to one system. This is not sufficient by itself to define the project hierarchy, but it is discriminating evidence that the failure distinction is not merely invented by the project.

---

# 5. Actual State versus representations of State

One of the strongest findings is a non-child boundary:

```text
actual realized Domain State
≠ desired/specification state
≠ observed/measured state
≠ inferred/believed state
≠ reported/cached status
≠ simulated/forecast state
≠ persistent Record of state
```

This applies to both children.

## Structure side

```text
actual deployed/installed structure
≠ architecture diagram
≠ configuration baseline
≠ component inventory
≠ topology cache
```

## Condition side

```text
actual condition/status
≠ sensor reading
≠ health estimate
≠ API status
≠ dashboard
≠ database field
```

Current Kubernetes documentation makes the digital case explicit: desired Pod spec, current/actual running-container state and API-visible status are distinct; status may lag instant runtime reality.

Configuration-management practice similarly needs audits/status accounting precisely because controlled descriptions can diverge from implementation.

Digital-twin work explicitly separates the real counterpart from fit-for-purpose virtual representations.

This boundary belongs later to Information/composition rather than becoming a third State child.

---

# 6. Cross-cutting dimensions that were not promoted

## Identity / Continuity

Question:

> What is being treated as the same constituent/domain whole across change/replacement?

Decision-critical, but not State-local because:
- it underlies both Structure and Condition;
- it crosses State into Dynamics;
- criteria are domain/purpose relative.

## Granularity / State Sufficiency

Question:

> Which realized facts must a later reasoning representation select for the protected purpose?

Formal state-space/Markov traditions make sufficiency purpose/model dependent. This is not an intrinsic partition of actual reality.

## Constraints / Invariants

Question:

> Which states/transitions are possible, admissible, stable or valid?

Constraints/invariants generally apply **over** states/transitions. A current fact that a constraint is binding/violated can be a Condition/Status fact without promoting the rule/constraint family itself.

## Scope / Boundary / Time index

Every State claim is indexed by analytical reference and time. These dimensions select the relevant State; they do not form separate universal State children.

## Observability / Evidence / Uncertainty

Actual State can be hidden. Observation, inference, evidence, confidence, conflict and provenance are primarily Information/composition concerns.

## Causal explanation

A degraded/wrong current State can be caused by:
- Structure;
- Dynamics;
- Work;
- Actors;
- Work Conditions;
- external events.

Therefore:

> **what currently obtains ≠ why it obtained**

State research must not treat a descriptive condition as its own root-cause explanation.

---

# 7. Identity and replacement result

The deeper pass confirms that identity cannot be ignored.

Examples can preserve:
- whole/system identity while components change;
- component identity while properties change;
- profile/equivalence while concrete instance identity changes.

But no universal Domain-State identity test emerged.

Thus identity is retained as an explicit cross-cutting prerequisite and reopen trigger rather than a third immediate child.

---

# 8. Constraints and admissibility result

The pass challenged whether `Constraints / Invariants` should be a third child.

It did not survive.

Reasons:
- constraints can govern Structure, Condition and Dynamics;
- invariants are often predicates holding across reachable states rather than one state's content;
- represented rules/specifications can belong in Information;
- realized institutional/physical enforcement can show up as a current Condition or Environment relation.

Thus the project should preserve constraints explicitly without placing them as a co-equal current-State region.

---

# 9. Granularity and `sufficient state`

A crucial distinction:

> **actual Domain State ≠ one universally sufficient state description.**

For a particular decision/problem, a state representation may need enough information to predict relevant effects or make past irrelevant under a Markov assumption. But another reasoning purpose can need a different selection/resolution.

This means:
- too coarse a representation can omit a load-bearing actual fact;
- too fine a representation can be inefficient;
- hidden history may indicate either omitted current variables or genuinely Dynamics-local path dependence.

The correct response is not to turn every possible variable into a universal Domain-State child.

---

# 10. Social / institutional reality

The pass retained the earlier correction:

> actual reality need not be metaphysically independent of all representation.

Institutional realities may depend on collective rules, roles, practices and acceptance.

The required project boundary is:

> **actual institutional/domain condition or structure is not identical to any one Record, assertion, belief or model of it.**

This permits:
- realized institutional structure in Structure/Composition;
- realized standing/status in Condition/Status;
while Actor identity/authority and Information representations retain their own first-order semantics.

---

# 11. Rival decompositions tested

Rejected/weakened:

### State as leaf
Too compressed; loses wrong-organization vs wrong-condition failures.

### Constituents + Relations + Properties
Too close to ontology/graph primitives; over-decomposes current project problem.

### Structure + Condition + Identity
Identity spans children and Dynamics.

### Structure + Condition + Constraints
Constraints govern admissibility/transition as well as current State.

### Structure + Condition + Space/Time
Space/time index the branches rather than forming co-equal universal problem regions.

### physical/digital/social/institutional children
Domain specializations; each re-exposes Structure/Condition questions.

### Situation / State of Affairs replacement
Useful counterframes, but no material project-level improvement over a carefully defined `Domain State`.

Strongest current result remains:

```text
Domain State
    ├─ Domain Structure / Composition
    └─ Domain Condition / Status
```

---

# 12. Updated Environment research hierarchy

```text
Environment (Operating Reality)
│
├─ Domain Reality
│  │
│  ├─ Domain State
│  │  ├─ Domain Structure / Composition
│  │  └─ Domain Condition / Status
│  │
│  └─ Domain Dynamics / Processes
│
└─ Work Conditions / Enabling–Constraining Environment
   └─ Technical Work Environment
```

Epistemic status:
- Environment parent: user-evaluated for continuation;
- Domain Reality: user-authorised for continuation;
- Domain State result: boundedly sufficient, awaiting user evaluation;
- Structure/Composition and Condition/Status: discovered children, **inactive**;
- Domain Dynamics: inactive;
- Work Conditions: inactive.

---

# 13. What this hierarchy does not mean

It does **not** imply:
- State table/schema with two sections;
- every Domain State contains both children materially;
- all facts belong exclusively to one child;
- `Structure` must be static through time;
- `Condition` means a scalar health field;
- one ontology must use these names;
- one snapshot contains sufficient information for every decision;
- Structure/Condition are architecture modules.

A narrow domain may mainly exercise one branch. Some facts can have overlapping structural and condition roles. The branches exist because they protect different research/failure questions, not because reality must be partitioned cleanly into two buckets.

---

# 14. Verification status and closure

The research used:
- current project evidence;
- systems/state/structure traditions;
- configuration-management practice;
- condition monitoring / PHM;
- live software reconciliation;
- digital twins;
- state-space/Markov counterframes;
- invariants/constraints;
- identity/persistence philosophy;
- properties/relations/facts counterframes;
- Work Domain Analysis;
- institutional/social reality;
- ecological and market holdouts.

The completion audit is same-model adversarial self-review, **not independent verification**. No source independently validates this exact project hierarchy.

Late holdouts and fresh challenge cases stopped producing new first-order State regions and mostly refined cross-cutting boundaries. Therefore broad Domain-State search should stop for this research level unless a new falsifier appears.

## Bounded answer

> **The Environment branch previously called `Domain State / Configuration` is better framed as `Domain State`. Its strongest current immediate research decomposition is `Domain Structure / Composition` and `Domain Condition / Status`. Structure asks what is actually present and how it is organized; Condition asks what properties/status actually hold. Identity, constraints, granularity and actual-versus-represented distinctions remain explicit but cross-cutting rather than co-equal children.**
