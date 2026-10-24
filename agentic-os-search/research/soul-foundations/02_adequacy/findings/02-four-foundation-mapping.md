# Finding 02 — Mapping the Internal Problem Inventory to the Four Foundations

**Status:** current comparative finding; architecture-neutral  
**Input:** Finding 01 problem inventory + current L0/L2/deferred-relation surfaces of all four verticals

## Mapping vocabulary

- **NATURAL** — primarily explained by one foundation without stretching its researched scope.
- **RELATIONAL** — naturally explained by typed relations among two or more foundations; not evidence of a missing peer region by itself.
- **PARTIAL** — an important part maps naturally, but a decision-critical residue remains outside the researched scope.
- **NO NATURAL FIT** — fitting the problem into the four current scopes would require redefining one of them or collapsing a distinction the research explicitly preserved.

## Problem-by-problem mapping

| Problem family | Mapping | Current judgment |
|---|---|---|
| P1 intended outcome / framing / success meaning | Work + Actors | **RELATIONAL / natural** |
| P2 selection / admission / sequencing / commitment | Work + Actors + Records | **RELATIONAL / natural** |
| P3 capability formation / acquisition / admission | Technical Work Environment + Actors + Work | **RELATIONAL / natural** |
| P4 execution / orchestration / coordination / handoff | Work + Actors + Technical Work Environment | **RELATIONAL / natural** |
| P5 authority / decision ownership / obligation / approval | Actors + Work + Records | **RELATIONAL / natural** |
| P6 durable truth / continuity / selective context | Records for persistence; cross-cutting for context | **PARTIAL** |
| P7 evidence / verification / evaluation / acceptance | Records + Work + Actors | **RELATIONAL / natural** |
| P8 constraints / policy / safety / privilege | Actors + Work + Technical Work Environment + Records | **RELATIONAL / natural** |
| P9 technical means / resource condition / operational readiness | Technical Work Environment | **NATURAL** |
| P10 observability / condition / unknowns / truthful failure states | Work + Technical Work Environment + Records; external-world cases unresolved | **RELATIONAL with conditional gap** |
| P11 failure containment / recovery / rollback / compensation | Work + Technical Work Environment + Actors + Records | **RELATIONAL / natural** |
| P12 learning / adaptation / governed evolution | Work + Records + Actors + Technical Work Environment | **RELATIONAL / natural, control-heavy** |
| P13 external/domain reality / observations / effects | no current foundation naturally represents actual non-technical domain/world state | **NO NATURAL FIT** |
| P14 human values / preferences / affected parties / owner boundary | Actors + Work, with Records for durable decisions | **RELATIONAL / natural** |

---

## P1 — Outcome/framing maps naturally, but not to a single box

Work research explicitly preserves purpose/outcome separately from action/task/method and rejects child-task completion as proof of parent outcome.

Actors contributes the distinction between researchable/derivable questions and human value/authority positions.

Therefore `goal`, `intent`, `preference`, `success criterion` and `owner decision` should not be collapsed into one Work field, but the underlying problem does not currently require a fifth peer region.

**Judgment:** relationally covered.

## P2 — Work selection is strongly covered

The Work vertical independently found candidate/eligible/selected-or-committed/in-progress distinctions, priority contextuality and pre-execution admission semantics.

Actors is needed for who may commit/reject/reprioritise; Records is needed to preserve the decision and reconstruct current standing.

**Judgment:** strong example of a cross-foundation problem, not a missing foundation.

## P3 — Capability formation is not one foundation-local concept

Technical Work Environment covers effective technical capabilities/resources/interfaces and their readiness/constraints.

Actors separately distinguishes bearer capability/competence from permission/authority/obligation.

Work determines what capability is required for a pursuit and whether capability-building itself becomes Work.

Therefore `capability` is best treated as a family of relations/properties across the four grounds rather than as an obvious fifth peer category.

**Judgment:** covered relationally.

## P4 — Execution/coordination is Work-centred but inherently relational

Work research makes coordination/dependency/concurrency first-order Work phenomena; Actors determines participation/responsibility; Technical Work Environment determines technical actionability.

**Judgment:** covered.

## P5 — Governance/authority does not currently justify a fifth peer region

Actors research already carries permission/authority/obligation, representation/delegation, accountability and decision-position distinctions.

Work supplies the decisions/transitions being governed; Records supplies durable policy/decision/evidence state.

Governance remains systemically important, but current evidence makes it look more like **typed authority/control relations over other grounds** than a self-sufficient peer substance.

**Judgment:** covered relationally; keep as a candidate cross-cutting control structure.

## P6 — Persistence is covered; information/context more broadly is not

Records is deliberately about **persistent information-bearing resources** and what must remain knowable/retrievable over time.

SOUL/Development OS also require concepts such as:
- current observation;
- transient context assembled for one responsibility;
- agent/system belief or process model;
- non-persisted intermediate knowledge state;
- ephemeral messages/signals.

These do not automatically become Records merely because they are information.

The four-area hypothesis can survive this only if later work establishes that nonpersistent information semantics are adequately represented as:
- Actor-local/Work-local state;
- relations between actual states and observations;
- or a broader information/representation ground of which Records is the persistent branch.

**Judgment:** partial coverage; **representation/information scope is an unresolved level mismatch.**

## P7 — Verification is a relation-rich composition, not obviously a peer category

Work already separates execution completion, verification, validation and acceptance.

Records supplies evidence/provenance/current binding.

Actors supplies verifier independence, authority and accountability positions.

Technical Work Environment may determine whether a verification mechanism can actually execute, but it does not define the epistemic relation itself.

**Judgment:** covered by relations among the current grounds.

## P8 — Policy/safety/constraints are cross-cutting

The same `constraint` word hides different phenomena:
- normative authority/obligation — Actors;
- work admissibility/acceptance — Work;
- technical access/isolation/quota — Technical Work Environment;
- durable policy/evidence representation — Records.

A universal `Policy` bucket would risk collapsing these distinctions.

**Judgment:** currently better understood as typed constraints/relations than a fifth peer region.

## P9 — Technical actionability is strongly covered

Technical Work Environment directly studies whether capabilities/services/resources/interfaces are effectively available under actual configuration, constraints and condition.

Its six-way separation (`exists`, `reachable`, `bound`, `permitted`, `available`, `sufficient`) maps directly to internal-lineage failures where a declared mechanism existed but was not actually wired/useful.

**Judgment:** strong natural fit.

## P10 — Observability maps differently depending on what is being observed

Technical environment health/readiness observability maps naturally to Technical Work Environment + Records.

Work status/progress observations map to Work + Records.

Actor status/authority evidence maps to Actors + Records.

But observation of an **external/domain world** exposes the same unresolved issue as P13: actual domain state is not automatically a Record and is not necessarily part of the technical support environment.

**Judgment:** covered for internal/technical state; gap reappears for external domain reality.

## P11 — Recovery maps across all four

Work carries retry/repair/compensation/recovery Work semantics.

Technical Work Environment carries restart/rebuild/restore/migrate and environment condition.

Actors supplies authority/responsibility for recovery decisions.

Records supplies the evidence/history needed to know what happened and what remains unresolved.

**Judgment:** relationally covered.

## P12 — Evolution strengthens the need for a relation/control fabric

Learning from failure can:
- generate new Work;
- create/modify Records;
- change Actor authority/responsibility;
- alter Technical Work Environment configuration/capabilities.

Governed evolution therefore cuts across all four.

Current evidence does not require `Evolution` as a peer foundation. It does require explicit relations/state transitions/authority over changes among the grounds.

**Judgment:** relationally covered, but impossible to model correctly without a cross-ground control/transition layer.

## P13 — External/domain reality does not naturally fit the four current scopes

This is the strongest present counterexample.

The current four preserve:
- persistent representations about reality;
- pursuits/actions toward outcomes;
- agents/participants/authority;
- the technical support context enabling work.

None, as currently researched, is the **actual domain/world state that can exist and change independently of the working system**.

Examples:
- a patient's physiological state;
- market prices and availability;
- a production plant's physical/process condition;
- a vehicle's road environment;
- a legal/regulatory state of affairs;
- a live customer/account/system condition outside the controlled work-support boundary.

Reducing these to Records would collapse `world state = representation`. Reducing them to Work would collapse `underlying condition = activity/status/effect`. Reducing them to Technical Work Environment would collapse `subject/operating world = technical support setting`.

The archived broad Environment research independently found precisely these non-collapse rules, although it was superseded only because it answered the wrong **fourth-vertical** question.

**Judgment:** **NO NATURAL FIT. Candidate fifth problem region: Operating World / Work Domain / Domain Reality.**

## P14 — Human values and affected-party structure maps mainly to Actors + Work

Actors already includes beneficiary/affected-party relation as a deferred boundary and separates normative attribution from operational participation.

Work carries purpose/outcome and acceptance.

Durable approvals/preferences may become Records without the Record creating the underlying human value.

**Judgment:** relationally covered; later research may need deeper stakeholder/value semantics but no independent fifth region is yet forced.

---

# Separability test of the four current regions

## Records cannot be reduced to Work

Persistent information can outlive a particular Work episode and has identity/history/retrieval/retention semantics not derivable from Work state.

## Work cannot be reduced to Actors

Possible/committed/continuing work, dependencies, flow and purpose/action/method distinctions exist even when actor allocation is intentionally unspecified.

## Actors cannot be reduced to Work episodes

Standing identity, role, authority, delegation and obligation can exist outside positive action events, and meaningful omission can matter.

## Technical Work Environment cannot be reduced to tools or Work

A realized support context has configuration, live state, interface, isolation, readiness, capacity, lifecycle and equivalence semantics not derivable from a Work description or component list.

### Separability judgment

**All four survive as distinct first-order problem regions at the current analytical level.**

This does not establish that they are exhaustive or that they should become peer ontology classes/modules.

---

# Productive-decomposition test

Each current vertical has already produced a substantial independent lower-level research tree:

- Records → identity/version/representation, preservation closure, change/time/standing, organisation/retrieval, requirement profiles, retention/disposition, mechanism trade-offs;
- Work → purpose/action/method, units, selection/commitment, control regimes, coordination/flow, multidimensional state, completion/acceptance, failure/recovery, continuing work;
- Actors → identity/role/participation, capability/authority/obligation, delegation/representation, omission, attribution/responsibility/accountability, collective/non-human agency;
- Technical Work Environment → boundary/identity, configuration/live state, capabilities/resources/interfaces/constraints, isolation/composition, lifecycle, health/readiness, portability/equivalence, dynamic discovery.

### Productive-decomposition judgment

**PASS.** The four regions are productive research grounds, not empty buckets.

The open adequacy question is therefore not whether they are useful; it is whether they are **collectively sufficient** and at the right abstraction level.

---

# Interim result

For the current SOUL/Development OS lineage:

- 12 of 14 internal problem families map naturally to one or more of the four foundations;
- one family (P6) exposes an unresolved broader information/representation issue;
- one family (P13) exposes a strong current missing-region candidate around actual domain/operating-world state;
- many mapped families require typed relations/controls among foundations.

This is an interim comparative result. External holdouts and rival decompositions must challenge it before any adequacy verdict.
