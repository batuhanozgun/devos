# Work Conditions — DEFERRED RELATIONS

**Status:** relation obligations discovered during bounded Work Conditions research; not a final relation taxonomy

## 1. Work ↔ Work Conditions

Need later composition to express relations such as:
- this Work requires this support condition;
- this realized condition makes Work ready/blocked/degraded/unsafe;
- this condition changes available/permitted method;
- this capacity/window constrains timing or throughput;
- this Work creates/restores/degrades a support condition for later Work.

Guardrail:
- Work internal state and the external condition causing it remain distinct relata.

## 2. Domain Reality ↔ Work Conditions role switching

The same concrete fact/system can carry:
- Domain Reality role for Work about/against that reality;
- Work Condition role for Work depending on it;
- both roles simultaneously.

Later composition must preserve one concrete identity while attaching reference-relative roles.

## 3. Actors ↔ Work Conditions ↔ actionability

Later reasoning may need to combine:
- Actor capability/competence;
- Actor permission/authority;
- Work requirements/method;
- realized Work Conditions;
- available interaction/access surfaces.

Full `can act / can perform Work now` is relational. Do not reduce it to Actor capability or Environment condition alone.

## 4. Information ↔ Work Conditions

Need later relations between:
- actual realized condition;
- observation/report/monitoring signal;
- inferred readiness/sufficiency judgment;
- policy/specification/expected condition;
- confidence/freshness/provenance.

Do not substitute a report or green dashboard for the realized condition.

## 5. Institutional rules / authority / realized constraint

Later composition must separate:
- rule/policy text and interpretation → Information;
- issuer/enforcer/authority/standing → Actors/control;
- realized current applicability/prohibition/access effect → Work Condition where execution-relevant;
- Work obligation/deadline/control semantics → Work.

## 6. Dependency / support closure

Need typed support/dependency relations such as:
- local support depends on remote service/resource;
- several Work episodes share a support dependency;
- contention/failure propagates through a shared resource;
- support substitution preserves or breaks protected equivalence.

Do not automatically place all transitive dependencies inside one environment boundary.

## 7. Work-created conditions

Setup/provisioning/support Work can create later Work Conditions.

Examples:
- provision test environment;
- erect scaffolding;
- decontaminate site;
- establish temporary communications;
- stage materials/equipment.

Keep separate:
- setup activity → Work;
- resulting support state → Work Condition;
- evidence setup succeeded → Information;
- actor authorization/accountability → Actors/control.

## 8. Causality / attribution

`Condition X existed when Work failed` does not establish `X caused the failure`.

Later composition needs explicit causal/evidential treatment for:
- condition caused blockage/delay;
- resource shortage contributed to failure;
- intervention restored feasibility;
- support degradation altered outcome.

## 9. Time-window relation

Need later relation between:
- Work deadline/order/schedule;
- realized external access/service/weather/permit window;
- Actor availability when relevant;
- current condition validity period.

Do not collapse these into one timestamp field.

## 10. Specialization relation

Technical Work Environment should remain linked as a deeply researched technical specialization/profile under the broader Work Conditions problem without implying:
- every Work has a TWE;
- type specializations are universal immediate children;
- research hierarchy determines implementation inheritance.

## Guardrail

These are recoverable relation obligations for later composition research only.

Do not create the final relation vocabulary, graph schema, ontology, control system or architecture in this pass.