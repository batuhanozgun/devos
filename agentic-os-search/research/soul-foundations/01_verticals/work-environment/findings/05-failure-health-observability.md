# Work Environment — Finding 05: Failure, Health, Readiness and Observability

**Status:** current topic finding; independent vertical; not architecture  
**Date:** 2026-09-02

## 1. Result in one paragraph

Environment failure is not reducible to “a tool crashed.” A technical work environment fails whenever its **effective support surface** no longer satisfies a protected environmental expectation: a required capability is absent, inaccessible, incompatible, unhealthy, under-capacity, incorrectly constrained, contaminated, or no longer equivalent to the intended environment. Consequently, **existence, running/liveness, readiness, availability, capacity sufficiency and behavioral correctness must remain separable**. Environment observability is likewise distinct from environment health: logs, metrics, traces, configuration/state inspection and probes are ways of learning about environmental state, but incomplete or misdesigned observation can miss failures or even create them.

## 2. Environment failure has a coherent independent meaning

A component can fail and thereby cause an environment failure, but environment failure is defined at a different level:

> **Does the realized environment still provide the support/capability/constraint contract that is relevant to the protected use?**

Examples where all nominal tools may still “exist” but the environment is materially failed or degraded include:

- required dependency cannot be resolved or loaded;
- remote backend is unavailable;
- network/API interface changed incompatibly;
- permission/policy change makes a capability unusable;
- quota or storage is exhausted;
- shared-resource contention makes required performance impossible;
- host/kernel/hardware mismatch changes behavior;
- mutable state contaminates an otherwise correct configuration;
- isolation failure exposes or corrupts another environment's state;
- configuration drift makes supposedly equivalent instances behave differently.

These are environment failures because the configured/realized support boundary no longer matches the relevant expectation, regardless of which underlying component is the proximate cause.

## 3. Existence, liveness, readiness, availability and sufficiency differ

Operational systems provide strong counterexamples to scalar health models. Kubernetes explicitly separates startup, liveness and readiness: a running application can be alive yet not ready to receive traffic, including because required backend services are unavailable. Codespaces can exist while stopped; remote environments can be unreachable to a participant despite persisted instance state.

A general environment analysis should therefore distinguish when relevant:

- **exists/provisioned:** an environment instance has been allocated/created;
- **running/live:** relevant execution substrate/processes are active and making progress;
- **ready:** required initialization/dependencies are satisfied for a specified support use;
- **reachable/accessible:** the relevant interface can currently be reached by the intended consumer;
- **available:** the promised capability/service is currently deliverable;
- **sufficient:** current capacity/performance/limits satisfy the protected requirement;
- **correct/equivalent:** realized behavior/state satisfies the claimed environment profile/equivalence.

These are not proposed universal status fields. They are anti-collapse distinctions.

## 4. Readiness is dependency-relative

Readiness can depend on more than local liveness. Kubernetes documentation explicitly notes that readiness may need to check required backend services. Science gateways similarly inherit availability from remote infrastructure they critically depend on.

Thus:

> **environment readiness can be a property of a dependency closure, not only a local instance.**

A local environment can be alive and reachable while a load-bearing remote service is unavailable, leaving the effective environment not ready for a protected capability.

This does not imply that every reachable external service must be monitored. Only bound/support-closure dependencies are relevant to the environmental readiness claim.

## 5. Degradation is distinct from binary failure

Shared/multi-tenant systems show that environments can remain operational while their effective properties deteriorate. Empirical and systems research on tenant isolation finds resource contention and noisy-neighbor effects can increase latency, reduce throughput and violate service objectives without a complete outage.

Environment condition may therefore include:

- healthy/nominal;
- degraded but usable;
- partially unavailable;
- insufficient for a particular requirement;
- failed/unavailable;
- state unknown because evidence is insufficient.

This list is illustrative. The main result is that binary `up/down` is often too weak.

## 6. Partial failure is first-order in composed environments

A composed/federated environment may lose one support family while retaining others:

- compute unavailable, storage accessible;
- editor/workspace accessible, remote build backend unavailable;
- read capability intact, write capability denied;
- local runtime healthy, identity provider unavailable;
- one project environment degraded while shared platform remains operational.

Therefore environment health can be **capability-scoped**. A single overall “healthy” flag can conceal material partial failures.

## 7. Failure propagation follows shared dependencies and boundaries

Multi-tenant cloud research shows shared resource dependencies can create contention and cascading effects across tenants. Even strong logical isolation may not fully isolate performance when CPU, memory, disk, network, kernel resources or provider services remain shared.

This reinforces Finding 04:
- isolation boundary does not necessarily equal failure-containment boundary;
- shared substrate creates potential coupling even when namespaces/data are isolated;
- provider-wide services can create common-mode failure across otherwise separate environments.

A useful environment analysis must therefore identify **shared failure dependencies**, not only nominal isolation.

## 8. Observability is the ability to know environment state, not state itself

Cloud/TRE practice treats monitoring, audit logs and operational oversight as explicit environment capabilities. Observability systems collect metrics, logs, traces and configuration changes to infer health, performance and anomalies.

For this vertical, keep separate:

- **actual environment state**;
- **declared/intended state**;
- **observed signals/evidence**;
- **inferred health/readiness judgment**;
- **control action taken in response**.

A dashboard showing green does not make an environment healthy; it is evidence about health. Conversely, an unobservable environment may be healthy but epistemically uncertain.

## 9. Observation has scope and failure modes

Health checks themselves can be incomplete or harmful. Kubernetes warns that incorrectly designed liveness/readiness probes can produce cascading failures or resource starvation.

Environment-observation failures include:

- missing coverage of a load-bearing dependency;
- stale configuration/state view;
- probe checks liveness while protected use requires readiness/capacity;
- aggregation hides partial failure;
- monitoring path differs from real use path;
- sampling misses intermittent drift/contention;
- probe creates enough load to worsen failure;
- observability system itself is unavailable.

Therefore:

> **observed healthy ≠ proven healthy**.

Health confidence depends on whether observations cover the protected environmental claim.

## 10. Recovery actions have different semantics

Environment recovery mechanisms can act at different layers:

- retry/reconnect to a remote service;
- restart a process/service;
- restart an existing environment instance;
- restore retained state/snapshot;
- reconfigure a live environment;
- rebuild/reprovision from definition;
- replace a failed dependency/provider;
- migrate to another substrate;
- discard contaminated state and create a clean instance.

A successful restart does not prove configuration correctness; a rebuild does not prove reproducibility if hidden dependencies remain; provider failover does not preserve equivalence unless the relevant capability/constraint contract survives.

Recovery therefore cannot be represented safely by one generic `restart` concept.

## 11. Environment-specific failure families

Consolidating Findings 01–05, current failure families include:

### A. Definition/resolution failures
- invalid or incomplete definition;
- dependency resolution failure;
- unavailable source/image/package;
- incompatible versions;
- non-reconstructable profile.

### B. Realization/state failures
- provisioning failure;
- initialization failure;
- mutable contamination;
- stale/corrupt state;
- drift from expected profile.

### C. Capability/interface failures
- service unavailable;
- interface incompatibility;
- policy/permission blocks required action;
- remote dependency failure;
- authentication/access path failure.

### D. Resource/capacity failures
- quota exhaustion;
- compute/memory/storage/network shortage;
- noisy-neighbor/resource contention;
- performance below protected threshold.

### E. Isolation/composition failures
- data/state leakage;
- cross-environment interference;
- shared dependency common-mode failure;
- inconsistent nested/federated components.

### F. Observability/control failures
- hidden failure or stale state;
- incorrect health inference;
- failed/unsafe automated recovery;
- insufficient evidence to determine environmental condition.

These families are a synthesis, not a final taxonomy.

## 12. Rival reductions tested

### Environment failure = tool failure
**Rejected.** Capability surface can fail through policy, remote dependency, capacity, drift or shared-substrate effects even when local tools remain intact.

### Running = healthy
**Rejected.** A process/environment can run while unable to provide required capability.

### Healthy = ready
**Rejected.** Local liveness can coexist with missing dependencies or unfinished initialization.

### Available = sufficient
**Rejected.** A service/resource can be available but below required capacity/performance/quota.

### Observable = healthy
**Rejected.** Observation is evidence; scope/quality can be incomplete and probes can themselves fail.

### Isolation = failure containment
**Rejected as universal.** Shared resource/provider dependencies can propagate degradation across logically isolated environments.

## 13. Strengthened current frame

A technical work environment has not only configuration and capabilities but a **current environmental condition** relative to a protected support claim. Its condition can be partially known, partially degraded and dependency-scoped.

The vertical therefore needs to preserve:
- intended support profile;
- realized support surface;
- current condition/availability/capacity;
- observed evidence about that condition;
- recovery/lifecycle action.

Collapsing these into one environment object/status loses decision-relevant distinctions.

## 14. Open questions carried forward

- Can the entire phenomenon be reduced to a relational profile over components/resources/services rather than a first-order `environment` entity?
- Does `Technical Work Environment` remain the best working term after counterframe tests?
- Which conditions are intrinsic to a realized environment versus properties of a particular protected use?
- Is environment readiness always purpose-relative, while liveness can be defined more locally?
- Are portability/migration and provider substitution independent first-order dimensions or consequences of identity/equivalence?
- Do late probes expose any first-order family missing from boundary/configuration/capability/composition/lifecycle/condition?

## 15. Epistemic status

**Supported topic result:** environment existence/running/readiness/availability/sufficiency cannot safely collapse.

**Supported topic result:** composed/shared environments have partial and propagated failure modes not captured by local tool health alone.

**Supported topic result:** observability is evidence about environment state and can itself be incomplete/faulty.

**Cross-source synthesis:** environment failure is best framed as failure of a protected support-surface claim rather than failure of a particular implementation component.

**Not established:** universal environment health state machine, universal health metric or universal recovery strategy.
