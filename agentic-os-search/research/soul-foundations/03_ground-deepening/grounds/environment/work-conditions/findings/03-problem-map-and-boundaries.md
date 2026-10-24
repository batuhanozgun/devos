# Work Conditions Finding 03 — Problem Map and Boundary Rules

**Status:** current substantive finding
**Date:** 2026-09-03

## Core question

> Which realized circumstances are load-bearing for whether and how focal Work can be performed?

The useful unit is not `everything around the Work`. A fact belongs in the Work-Conditions view only when there is a defensible coupling to a protected Work question such as feasibility, method, safety, pace, reliability, resource sufficiency, quality or continuation/recovery.

## Explicit internal problem regions — not current children

### P1 — Required support surface

What capabilities, services, equipment, materials, facilities, space, energy, communication, logistical support or other resources must actually be available for this Work?

Important anti-collapse distinctions:
- exists ≠ relevant;
- relevant ≠ bound/depended upon;
- bound ≠ currently available;
- available ≠ sufficient.

Failure examples:
- required tool/service/material missing;
- support exists but not for the required use;
- critical remote dependency omitted;
- sufficient nominal capability but inadequate current capacity.

### P2 — Access, interface and usable coupling

Through what actual path can the relevant Actor/system/Work use the support condition?

Examples:
- physical access to a site/equipment;
- technical connectivity/API/interface;
- permitted operation under current access policy;
- logistical route;
- procedural access window;
- compatible interaction surface.

Boundary:
- interface/access condition belongs in Work Conditions when it materially shapes usable support;
- identity, standing authority and permission semantics remain Actor/control concerns;
- policy/rule text and evidence about permission remain Information concerns.

### P3 — Current availability, readiness and sufficiency

A support element can exist and be reachable but still not satisfy the protected use.

Relevant distinctions may include:
- initialized / ready;
- available / degraded / unavailable;
- sufficient / under-capacity;
- compatible / incompatible;
- safe / unsafe for protected use;
- within / outside required tolerance.

These are purpose-relative condition judgments, not proposed universal status fields.

### P4 — Constraints, hazards and interference

Which realized conditions narrow safe, permitted or effective execution?

Examples:
- temperature, noise, radiation, contamination, weather;
- congestion/contention;
- unsafe equipment or facility state;
- regulatory/procedural prohibition in its realized applicability role;
- confidentiality/isolation restrictions;
- inadequate staffing/support coverage in its condition role;
- communication disruption;
- physical or social interference.

Hazard/constraint is not a separate substance type. The same underlying variable may be enabling at one level and constraining at another.

### P5 — Dependencies, shared support and failure propagation

Which load-bearing conditions depend on other support systems/resources/services?

Questions:
- is readiness local or dependency-wide?
- which shared resource creates contention/common-mode risk?
- can one support service degrade while another remains usable?
- what hidden dependency invalidates the apparent Work condition?

TWE provides deep technical examples; NASA operational support and work-system traditions show the problem is broader than software.

### P6 — Temporal validity and continuity

When do the conditions hold?

Examples:
- access/service/facility available only in a time window;
- weather/tide/traffic window;
- filing/procedural window;
- staff/equipment availability period;
- support degrades during execution;
- temporary emergency authorization/resources.

Boundary:
- Work schedule/deadline structure remains Work-local when it defines the Work plan/obligation;
- the realized external window/resource availability is Work Conditions when it constrains feasible execution;
- their relation is later composition.

### P7 — Situational fit / actionability boundary

A condition alone does not determine what is possible.

Full actionability depends on:
- realized Work Conditions;
- Actor capabilities/limitations;
- Actor authority/permission;
- Work requirements/purpose/method;
- relevant interaction surface.

Therefore:

```text
Actor capability ≠ Work Condition
Work Condition ≠ full actionability
```

Work Conditions should preserve the condition-side facts without claiming the whole feasibility relation.

### P8 — Reference, boundary and role switching

The same concrete thing can change analytical role without changing identity.

Examples:
- CI platform supports product development → Work Condition;
- same CI platform under repair → Domain Reality;
- hospital equipment supports treatment → Work Condition;
- same equipment under maintenance → Domain Reality;
- road/weather constrains transport Work → Work Condition;
- road/weather becomes study/repair target → Domain Reality.

Role is relative to focal Work and can be both when both questions are load-bearing.

## Cross-ground non-collapse boundaries

### Work Conditions versus Domain Reality

Domain Reality:
> what realized condition/dynamics is the Work about or judging outcomes against?

Work Conditions:
> which realized circumstances materially shape whether/how the Work can be performed?

Same fact may carry both roles. Do not duplicate identity merely because role differs.

### Work Conditions versus Work

Work owns questions such as:
- what Work is required/selected/committed;
- Work dependencies/ordering/coordination as Work structure;
- planned method;
- internal readiness/blocked/suspended state;
- deadlines and schedules as Work control semantics;
- effort/duration/waiting/closure semantics.

Work Conditions owns the external/realized circumstances that make the Work ready/blocked/safe/unsafe/etc.

Example:
- `Work item is blocked` → Work state/judgment;
- `required backend is unavailable` → Work Condition;
- relation `backend unavailability blocks this Work` → later cross-ground composition.

### Work Conditions versus Actors

Actors owns:
- bearer identity;
- capability/competence;
- authority/permission/obligation;
- participation/decision/accountability roles.

Work Conditions can include:
- actual staffing/support availability;
- presence/absence of a needed service person/team in a support-condition role;
- current access mechanism/policy effect.

Do not turn `a person is available to help` into ownership of that person's identity/capability/authority semantics.

### Work Conditions versus Information

Information owns:
- rule/policy/specification text;
- observation/report/model of conditions;
- evidence/confidence/freshness;
- claims about availability or safety.

Work Conditions concerns the realized condition itself.

Examples:
- permit document says access is allowed → Information;
- authority relation that makes permission valid → Actor/control;
- access is currently permitted and gate is open → realized Work Condition where load-bearing;
- dashboard reports service green → Information/evidence;
- service actually available → Work Condition.

## Load-bearing relevance rule

A candidate condition belongs in the Work-Conditions view only if changing it within a plausible range could materially change at least one protected Work property:
- feasibility/start/continuation;
- available/permitted method;
- safety/exposure;
- pace/waiting/throughput;
- reliability/failure/recovery;
- resource sufficiency;
- achievable quality/precision.

Otherwise it is ambient reality, not a Work Condition for the focal analysis.

This materiality rule is purpose-relative and does not imply that irrelevant facts cease to exist.

## Current structural implication

These problem regions repeatedly interact and overlap. None currently has a stable enough boundary to become an immediate universal child. They are retained explicitly for holdout/audit testing.