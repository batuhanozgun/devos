# Work Conditions Finding 05 — Cross-Domain Holdouts

**Status:** same-model adversarial scenario challenge; not independent verification
**Date:** 2026-09-03

## Candidate under attack

```text
Environment / Operating Reality
    ├─ Domain Reality
    └─ Work Conditions
         ↳ Technical Work Environment [technical specialization/profile]
```

No universal Work Conditions immediate child is currently promoted.

## Holdout 1 — Software / repository development

Focal Work:
- change/test/review/deploy software.

Domain Reality role:
- codebase/product/runtime behavior actually being changed or judged.

Work Conditions:
- repository/CI/service availability in support role;
- credentials/secrets/access path;
- build/test runtime;
- network/backend availability;
- quotas/capacity;
- compatible interfaces;
- shared-service contention.

Boundary:
- repository content/provenance → Information when treated as representation/record;
- developer/tool-agent capability/authority → Actors;
- `build is blocked` → Work state;
- backend outage causing block → Work Condition.

Result:
- Work Conditions branch productive;
- TWE specialization strongly useful;
- resource/access/readiness do not require separate universal children.

## Holdout 2 — Physical maintenance under adverse conditions

Focal Work:
- inspect/repair a machine or infrastructure asset.

Domain Reality:
- damaged asset condition and dynamics.

Work Conditions:
- site access;
- temperature/noise/lighting/weather;
- safe isolation/lockout condition;
- lifting/support equipment availability;
- replacement materials;
- workspace/clearance;
- hazard exposure;
- support capacity/time window.

Result:
- no technical-only reduction;
- resource, physical condition, access and hazard overlap materially;
- no forced child.

## Holdout 3 — Clinical treatment

Focal Work:
- diagnose/treat a patient.

Domain Reality:
- patient physiology/pathology and treatment response.

Work Conditions:
- equipment/medication/facility availability;
- current staffing/support coverage in support-condition role;
- room/bed/access constraints;
- contamination/isolation conditions;
- scheduling/service capacity;
- institutional/procedural conditions affecting feasible treatment.

Boundary:
- clinician identity/capability/authority → Actors;
- protocols/orders/reports → Information;
- treatment process → Work;
- patient state → Domain Reality.

Result:
- SEIPS-style interaction survives boundary separation;
- people/organization cannot simply become Work Conditions object classes;
- no missing child.

## Holdout 4 — Field / laboratory science

Focal Work:
- observe, sample, measure or experiment.

Domain Reality:
- specimen/phenomenon/system under study.

Work Conditions:
- instrument/facility state;
- calibration/service availability as realized support;
- consumables/sample-handling capacity;
- weather/site conditions;
- site/collection access;
- power/network/logistics;
- safety constraints;
- permit applicability in execution-condition role.

Boundary:
- calibration certificate/permit text → Information;
- issuing authority → Actors/control;
- actual instrument availability/access/safe site condition → Work Conditions.

Result:
- technical, physical, logistical and institutional conditions combine in one case;
- type-based children would fragment one support closure.

## Holdout 5 — Logistics / transport operation

Focal Work:
- move goods/persons from origin to destination.

Work Conditions:
- route/infrastructure availability;
- vehicle/fuel/charging capacity;
- weather/traffic/port/terminal condition;
- handling/storage capacity;
- customs/inspection availability;
- timing windows;
- communications/support services.

Result:
- timing, capacity, access, physical environment and institutional conditions are coupled;
- `prerequisite versus ongoing condition` can switch during the journey;
- no stable split forced.

## Holdout 6 — Legal / institutional filing or compliance work

Focal Work:
- submit a filing, obtain a decision, satisfy a procedure.

Domain Reality:
- actual legal/institutional standing or matter status when that is the target.

Work Conditions:
- filing portal/office availability;
- jurisdictional/applicability condition insofar as it constrains feasible procedure;
- submission window / office opening / service availability;
- accepted filing channel;
- required access mechanisms.

Boundary:
- deadline/obligation as Work control requirement can be distinct from the realized filing window;
- statute/rule text → Information;
- authority/competence of institution/representative → Actors/control;
- actual service/access/window condition → Work Conditions.

Result:
- institutional Work Conditions survive without turning rules/authority into Environment-owned semantics.

## Holdout 7 — Emergency response

Focal Work:
- stabilize/respond to an incident.

Domain Reality:
- fire/flood/injury/system failure and evolving consequences.

Work Conditions:
- road/site accessibility;
- communications;
- protective equipment/resources;
- temporary facilities;
- hazard/exposure;
- available personnel/support capacity in condition role;
- temporary permissions/control arrangements as realized execution constraints;
- changing weather/terrain.

Result:
- support conditions are dynamic and can be created/removed during Work;
- no `static conditions` interpretation survives;
- role/boundary changes are first-order dimensions, not children.

## Holdout 8 — Automated / nonhuman Work

Focal Work:
- automated agent/robot executes an assigned operation.

Work Conditions:
- power/battery/charging availability;
- network/compute/service dependencies;
- sensor/action interface condition;
- physical access/terrain;
- resource capacity;
- imposed safety/geofence constraints.

Boundary:
- intrinsic robot/agent capability belongs to Actor/agency analysis when that distinction is load-bearing;
- external/current support conditions remain Work Conditions.

Result:
- `Work Conditions` cannot be defined only as human employment conditions;
- the node generalizes beyond workplace/job-quality literature.

## Holdout 9 — Nontechnical manual work

Focal Work:
- handcraft/repair/field activity that does not require a meaningful software/technical environment.

Work Conditions:
- materials;
- workspace;
- lighting/weather;
- tool availability;
- access;
- time/resource window;
- hazards.

Result:
- Work Conditions exists without Technical Work Environment;
- TWE is optional specialization/profile, not universal immediate child.

## Holdout 10 — Same concrete system, different role

CI platform:
- supports product development → Work Condition;
- itself under repair → Domain Reality;
- can be both during live repair.

Hospital equipment:
- supports treatment → Work Condition;
- under maintenance → Domain Reality.

Result:
- role switching survives if roles are relational/non-exclusive;
- intrinsic object taxonomy would fail.

## Holdout 11 — Exists but unusable

Examples:
- equipment exists but cannot be accessed;
- service reachable but permission denied;
- available service lacks quota/capacity;
- staff nominally assigned but unavailable at needed time;
- route exists but closed;
- filing portal exists but submission window closed.

Result:
- existence/inventory is insufficient;
- access/availability/sufficiency are load-bearing dimensions;
- no need to make each a child.

## Holdout 12 — Work creates its own future Work Conditions

Examples:
- setup Work provisions a test environment;
- scaffolding Work creates safe access for repair;
- decontamination makes a site usable;
- a temporary network or command post is established for response.

Boundary:
- setup/provisioning activity → Work;
- resulting realized support surface → Work Condition for later Work;
- record that setup succeeded → Information;
- actor who authorized setup → Actors.

Result:
- Work and Work Conditions can causally affect one another without semantic collapse.

## Holdout verdict

Across software, physical, clinical, scientific, logistical, institutional, emergency, automated and nontechnical cases:
- the Work Conditions question remains distinct and useful;
- no recurrent case requires a universal immediate child;
- candidate category splits repeatedly cross-cut one another;
- Technical Work Environment remains a strong specialization but is not universal.

Current candidate survives as a bounded leaf, subject to final falsifier disposition and omission audit.