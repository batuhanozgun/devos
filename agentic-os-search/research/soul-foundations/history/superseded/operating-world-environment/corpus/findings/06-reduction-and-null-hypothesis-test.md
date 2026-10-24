# Environment Finding — Reduction / Null-Hypothesis Test

**Status:** current bounded Environment-local finding  
**Scope:** direct test of whether Records + Work + Actors + relations can absorb the Environment candidate without material loss; not architecture composition

## Null hypothesis

> There is no independent Environment foundation problem region. Everything materially relevant can be represented as Records, Work, Actors and typed relations/qualifiers among them.

This is deliberately stronger than asking whether a separate Environment **module** is needed. A foundation region can survive even if later architecture represents it through relations rather than a dedicated component.

## Test 1 — Hold the three completed verticals fixed; vary external state

Construct two situations with the same:

- Actor identities, roles, competence, authority and obligations;
- Work purpose, method, lifecycle/commitment state and dependencies;
- persistent Records currently available to the system;
- relations among those three sets of facts.

Now vary only a state/process outside the selected system boundary:

- an external API/network is available vs unavailable;
- a physical route is open vs blocked;
- temperature/radiation is within tolerance vs hazardous;
- an external resource has capacity vs is exhausted;
- a market/regulation/external counterparty state changes;
- another Actor outside the selected controlled system changes the shared world state.

The feasible next actions, risks and likely outcomes can change while the three verticals remain locally unchanged.

**Result:** a model whose relata are only existing Records/Work/Actors facts is incomplete unless it introduces the varying external/world condition somewhere.

## Test 2 — Encode the external state as a Record

This preserves a representation/assertion about the condition, not necessarily the condition itself.

Under partial observation, latency or unobserved change, the Record may remain constant while the world changes. The completed Records vertical also explicitly distinguishes what the system recorded/knew from underlying factual truth.

**Result:** `external state = Record` fails as a universal reduction.

## Test 3 — Encode it as Work state

`blocked`, `ready`, `risky` or `failed` can capture consequences for one Work unit, but they do not preserve the shared causal condition. One external outage, regulation or physical condition may affect several Work units differently and can persist independently of any one Work lifecycle.

**Result:** Work status can project environmental consequences but does not replace the underlying condition.

## Test 4 — Encode it as Actor capability/context

Stable Actor capability does not determine situated feasibility. Affordance/runtime evidence shows that actionability depends on current surrounding conditions/interfaces/resources. Conversely, Actor-local `situation/context` anchors do not by themselves define the actual world facts that make conduct possible or impossible.

**Result:** Actor properties/contexts are insufficient as a complete reduction.

## Test 5 — Allow arbitrary typed relations/qualifiers

This is the strongest null-hypothesis variant.

If the relation fabric is allowed to include statements such as:

- `Work W executable-under Condition C`;
- `Actor A has-access-to Resource R`;
- `ExternalSystem X currently exposes Interface I`;
- `WorldState S constrains/affords Action A`;
- `Observation O represents WorldState S`;

then a separate Environment **object bucket or module** may indeed be unnecessary.

But these relations require external/world states, resources, interfaces, processes or conditions as relata. If those relata and their changing state are removed, the relations become labels without a thing/condition to relate to.

**Result:** the null hypothesis succeeds against a *fourth module/object class*, but does not eliminate the underlying Environment problem region. It re-represents that region through typed relations to boundary-relative world/operating-state entities/conditions.

## Test 6 — Other Actors as environment

Multi-agent decision models provide a useful pressure test. From one Actor's policy perspective, other Actors can contribute to non-stationary external dynamics. Yet the Actors vertical must still preserve their identities/authority/attribution where those distinctions matter.

Therefore `environment` cannot be a mutually exclusive ontological class. The same concrete entity can be an Actor in one semantic projection while its behavior contributes to another Actor/system's operating environment.

## Current judgment

The research **rejects the strongest reduction**:

> `Environment adds nothing first-order beyond Records, Work and Actors.`

But it also rejects the stronger four-box interpretation:

> `Environment is a mutually exclusive fourth object class or necessarily a fourth architecture module.`

The evidence currently supports a narrower claim:

> **There is an independent foundation problem region concerning boundary-relative world/operating state and dynamics that may change independently of the controlled system's current Records, Work and Actor facts, affect actionability/outcomes, be only partially observable, and interact with the system through sensing/action/interfaces/resources.**

`Environment` remains a working label for that problem region. `Operating world` / `operating situation` are candidate framings, not accepted terminology.

## Sources / recovery

This reduction test composes only already established local distinctions plus current Environment findings:

- `01-boundary-relative-environment.md`
- `02-context-is-not-environment.md`
- `03-actionability-is-relational.md`
- `04-world-state-observation-and-record.md`
- `05-tools-runtime-infrastructure-are-boundary-roles.md`
- Records `../../records-artifacts/KEY.md` and `synthesis/current/CHANGE-TIME-STANDING.md`
- Work `../../work/KEY.md`, `findings/CONTROL-STATE-CLOSURE-AND-RECOVERY.md`, `findings/COORDINATION-FLOW-AND-SITUATEDNESS.md`
- Actors `../../actors/KEY.md`, `findings/CAPABILITY-AUTHORITY-OBLIGATION.md`, `findings/ACTION-OMISSION-DECISION.md`
- Poole & Mackworth POMDP formulation for state/observation/belief separation.
- NASA physical/support/operational environment examples.
- OECD/Eurostat Oslo Manual external-environment examples for market, policy, social and natural external conditions.
- POSG literature for shared external state and joint-action dynamics.

## What this does not prove

- final SOUL ontology or component count;
- where boundary-relative world state should be stored or computed;
- which environmental facts deserve explicit representation for a given Work system;
- that `Environment` is the best final name;
- that relations/control architecture should be designed now.