# Environment Finding 09 — Cross-Domain Holdouts and Omission Challenge

**Status:** current Environment-ground adversarial finding  
**Verification class:** same-model scenario challenge; not independent verification

## Purpose

Try to force a missing first-order Environment region or make the current two-role parent collapse under materially different domains.

Current candidate:

```text
Environment / Operating Reality
    ├─ Domain / Effect Reality
    └─ Work Conditions / Enabling–Constraining Environment
```

Roles are non-exclusive.

## Holdout 1 — Clinical treatment

### Domain / Effect
- patient physiology;
- disease/injury trajectory;
- actual treatment effects and adverse effects.

### Work Conditions
- operating room/lab/bed availability;
- equipment, medication and supply availability;
- physical layout/lighting/noise;
- system/service availability;
- realized staffing/capacity conditions in their execution-condition role.

### Ambiguity
Patient accessibility or infection state can be both target reality and execution constraint.

**Result:** two roles sufficient; no third branch.

## Holdout 2 — Software development / Development OS

### Domain / Effect
- actual product/system/repository behavior being researched, changed and evaluated;
- defects and runtime/product properties that Work is intended to alter.

### Work Conditions
- GitHub/tool access;
- CI/test/runtime services;
- credentials/licences;
- compute/storage/network capacity;
- development/test environment state.

### Ambiguity
CI itself becomes Domain/Effect reality during CI-maintenance Work.

**Result:** role switching is necessary; two roles sufficient.

## Holdout 3 — Scientific experiment

### Domain / Effect
- specimen/phenomenon;
- actual causal process under study;
- experimental effects on specimen/system.

### Work Conditions
- laboratory availability;
- instrument readiness;
- calibration/environmental stability;
- contamination, temperature and power conditions;
- compute/analysis support where execution depends on it.

### Ambiguity
Temperature may be experimental variable or uncontrolled condition depending on Work purpose.

**Result:** two roles sufficient.

## Holdout 4 — Logistics / delivery

### Domain / Effect
- goods/location/destination state;
- shipment/customer fulfillment state;
- traffic/network state when routing Work is explicitly about navigating it.

### Work Conditions
- vehicle availability;
- fuel/charging capacity;
- warehouse access;
- weather/road closure as execution constraints when not themselves the target;
- communications/GPS/support services.

**Result:** seemingly `ambient` conditions map by role; no third family.

## Holdout 5 — Emergency / disaster response

### Domain / Effect
- fire/flood/damage/victim state;
- evolving hazard and intended containment/rescue effect.

### Work Conditions
- responder access;
- equipment/water/communications availability;
- visibility/weather;
- route capacity;
- mutual-aid availability in its support-condition role.

### Ambiguity
Fire and weather can jointly be domain dynamics and execution constraints.

**Result:** multi-role representation is required; two roles survive.

## Holdout 6 — Legal / regulatory knowledge work

### Domain / Effect
- actual legal/institutional/business situation the Work is trying to determine, change or comply within;
- real jurisdiction/applicability/standing conditions where material.

### Work Conditions
- deadlines/access/court or filing availability;
- realized procedural constraints;
- tools/research services;
- resource/capacity constraints.

### Cross-ground boundary
Law text, evidence and interpretations are Information; issuing/deciding authority involves Actors/control.

**Result:** Environment does not need to absorb normative semantics to retain realized-condition role.

## Holdout 7 — Autonomous robotics / driving

### Domain / Effect
- terrain/road/objects/traffic;
- target locations;
- dynamic surrounding state and actual effects of movement.

### Work Conditions
- technical support such as remote compute/development/simulation when relevant to focal Work;
- onboard capability state if it is treated as an execution condition outside the selected controlled/action boundary;
- weather/friction/visibility can occupy both roles depending on analytic purpose.

### ODD distinction
A specified operational design domain is an Information/requirement envelope; actual conditions may be inside/outside/unknown relative to it.

**Result:** actual-vs-specified distinction is mandatory; no new branch.

## Holdout 8 — DevOps / self-maintaining infrastructure

### Domain / Effect
- cluster/service state being repaired or optimized.

### Work Conditions
- remaining diagnostic/control channels;
- privileged access;
- external monitoring/support services;
- spare capacity.

### Ambiguity
The same cluster can partly remain a support substrate while also being the repair target.

**Result:** exclusive classification fails; role-relative branches survive.

## Holdout 9 — Market/decision support

### Domain / Effect
- prices, liquidity, orders, customer/market state relevant to the decision/outcome.

### Work Conditions
- market-open state as execution window where appropriate;
- data/service connectivity;
- execution venue availability;
- limits/capacity in their realized constraint role.

### Cross-ground boundary
Observed price feeds and forecasts are Information, not the market state itself.

**Result:** two roles sufficient.

---

# Targeted omission probes

Explicit missing-family candidates:
- physical environment;
- social environment;
- institutional/legal environment;
- economic/resource environment;
- ecological/natural environment;
- ambient/background conditions;
- hazards/risk environment;
- infrastructure/tool environment;
- other agents/systems;
- temporal/spatial environment;
- specified operating envelope;
- uncertainty/unknown environment.

## Result

No candidate currently forces another first-order branch.

They map through:
- Domain/Effect role;
- Work-Condition role;
- both roles;
plus deferred cross-ground semantics where necessary.

`uncertainty`, `belief`, `specified envelope` and `context representation` are not additional Environment branches; they concern what is known/represented about Environment.

## Important failure criterion

The two-role result would fail if a recurrent condition family is decision-critical but can only be placed by stretching both roles or by saying `Environment because it is relevant` without a target/effect or execution-condition explanation.

No such family emerged in this holdout set.

## Information-gain trajectory

- early pass: corrected the second branch from positive `support` to neutral enabling–constraining Work Conditions;
- later diverse holdouts: predominantly clarified dual-role cases and cross-ground exclusions rather than opening a new Environment-local family.

This is evidence for a bounded stop, not proof of universal completeness.