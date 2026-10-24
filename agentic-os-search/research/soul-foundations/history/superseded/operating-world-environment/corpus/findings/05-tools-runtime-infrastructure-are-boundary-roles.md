# Environment Finding — Tools, Runtime and Infrastructure Are Boundary-Dependent Roles

**Status:** current bounded Environment-local finding  
**Scope:** tools, execution substrate, infrastructure and system-boundary alternatives; not architecture ownership

## Question

Do tools, runtime systems and infrastructure form an intrinsic Environment object family, and is software execution environment a fundamentally different problem from physical/domain environment?

## Current finding

**The evidence does not support an intrinsic `tool/resource/infrastructure = Environment object` classification.**

A concrete entity can function as:

- an internal system element;
- an external interacting system;
- an enabling/support system;
- infrastructure embedded in practice;
- a tool/mediator used by an Actor;
- a resource whose availability constrains Work;
- part of a larger coupled Actor/system boundary.

Which role is relevant depends on the system-of-interest, analytical purpose, coupling and Work relation.

At the same time, runtime/infrastructure conditions are not semantically empty: they can alter what execution is possible, accessible, isolated or resource-bounded while Actor and Work descriptions remain unchanged.

## Evidence discrimination

### Systems-engineering boundary evidence

NASA distinguishes external interfaces, physical environment, support environment and system/enabling relations. These are meaningful operational/design concerns, but their classification is relative to the system boundary and lifecycle purpose.

### Runtime evidence

OCI specifies configuration and execution conditions for containers; NIST defines container runtime as the environment coordinating OS components that isolate resources/resource usage. Namespaces, mounts, host support, isolation and resource availability change the effective execution surface.

This shows that runtime environment is a concrete instance of **operating conditions and accessible external/supporting state**, not merely a property of the application Work item.

### Infrastructure/practice evidence

Infrastructure studies and activity/distributed-cognition alternatives challenge a fixed object taxonomy: a system can be transparent infrastructure in one practice, a direct Work object in another, or a constitutive component of a coupled system under another analytical boundary.

Clark & Chalmers' extended-mind argument is an intentionally strong counter-frame: sufficiently coupled external resources may be analyzed as constitutive parts of the cognitive system rather than external environment. The present research does not adopt that theory; it uses it to falsify a rigid actor/tool/environment partition.

## Runtime-versus-domain split test

A software runtime and a physical/social operating environment are materially different domains, but current evidence does **not** establish that they are different first-order foundation families.

Both can be modeled at a sufficiently abstract level as:

- boundary-relative operating conditions;
- current states/processes outside the selected controlled system boundary;
- interfaces and accessible resources;
- exogenous constraints/disturbances;
- conditions that alter feasibility or outcomes.

The domain-specific semantics remain important. `namespace`, `temperature`, `regulation`, `network route` and `market condition` are not interchangeable fields. The convergence is at the problem-family level, not the vocabulary level.

## Counter-tests

### Put every tool inside Environment

Fails when the tool is constitutive of the selected system or Actor/Work mechanism. A model/runtime/library can be inside the system boundary in one analysis and an external service in another.

### Put every tool inside Actor capability

Fails when the Actor's competence remains stable but the tool/service is unavailable, inaccessible, revoked, degraded or externally changed.

### Treat runtime as Work detail

Fails when one substrate condition affects many Work units or changes independently of their plans/lifecycles.

### Split technical runtime into a separate foundation by default

Not supported. The same abstract distinctions — boundary, accessible state, interfaces, resources, disturbances and operating constraints — recur in physical and technical environments. A domain-specific implementation split may later be useful, but foundation evidence does not require it.

## Decision-critical implication

The candidate Environment region is better treated as a **boundary-relative operating-world problem** than as a bucket of tools/resources/infrastructure objects.

Roles such as `tool`, `resource`, `infrastructure`, `external system` and `enabling system` are likely relation- and boundary-dependent classifications over concrete entities and conditions.

This strengthens the independent problem-region hypothesis while weakening a fourth-object-class or fourth-module interpretation.

## Sources / recovery

- NASA Systems Engineering Handbook Appendix / Concept of Operations physical and support environment: https://www.nasa.gov/reference/system-engineering-handbook-appendix/
- OCI Runtime Specification: https://github.com/opencontainers/runtime-spec/blob/main/config.md
- NIST SP 800-190: https://csrc.nist.gov/pubs/sp/800/190/final
- NIST `container runtime` glossary: https://csrc.nist.gov/glossary/term/container_runtime
- E10 Star infrastructure and E11 Clark & Chalmers in `../evidence/SOURCE-LEDGER.md`.

## What this does not prove

- a final boundary rule for SOUL;
- that every external service/resource must be explicitly modeled;
- that extended cognition should be adopted;
- that all physical, social and technical environmental semantics share one data structure;
- ownership of tool/resource/infrastructure relations in later architecture.