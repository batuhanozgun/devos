# Work Environment — Failure / Health / Observability Source Ledger

**Role:** evidence trace for `findings/05-failure-health-observability.md`  
**Date:** 2026-09-02

## S1 — Kubernetes liveness/readiness/startup semantics

Kubernetes Documentation, *Liveness, Readiness, and Startup Probes*.  
https://kubernetes.io/docs/concepts/workloads/pods/probes/

Relevant evidence:
- startup, liveness and readiness are deliberately distinct;
- a running container can be live but not ready;
- readiness can depend on required backend services;
- failed readiness removes a workload from service without necessarily killing it;
- incorrect probes can cause cascading failures or resource starvation.

Use role: concrete technical counterexample to scalar `running = healthy = ready` models. Not a universal environment-state standard.

## S2 — GitHub Codespaces lifecycle

GitHub Docs, *Understanding the codespace lifecycle*.  
https://docs.github.com/en/codespaces/about-codespaces/understanding-the-codespace-lifecycle

Relevant evidence:
- environment can exist while stopped;
- connection state, running state, persistence, rebuild and deletion differ.

## S3 — NERSC Science Gateways

NERSC Documentation, *Science Gateways*.  
https://docs.nersc.gov/services/science-gateways/

Relevant evidence:
- gateways critically depending on NERSC infrastructure inherit availability from underlying infrastructure;
- supports dependency-scoped environment readiness/availability.

## S4 — Multi-tenant fault/resource propagation (2026)

Murali, *Hypergraph-based adaptive resource scheduling for fault-resilient multi-tenant cloud allocation*, Journal of Cloud Computing, 2026.  
https://link.springer.com/article/10.1186/s13677-026-00925-2

Relevant evidence:
- shared resource dependencies can cause cascading failures across tenants;
- resource contention and workload imbalance can produce SLO violations.

## S5 — Tenant isolation cross-case analysis

Ochei, Bass & Petrovski, *Degrees of tenant isolation for cloud-hosted software services: a cross-case analysis*, Journal of Cloud Computing, 2018.  
https://link.springer.com/article/10.1186/s13677-018-0121-8

Relevant evidence:
- shared components/resources can create resource contention and tenant performance interference;
- isolation has degrees/effects rather than one boolean property.

## S6 — Workload interference in virtualized environments

*Batch scheduling of consolidated virtual machines based on their workload interference model*, Future Generation Computer Systems 29(8), 2013.  
https://www.sciencedirect.com/science/article/abs/pii/S0167739X13000332

Relevant evidence:
- virtualization provides isolated execution contexts while still allowing performance interference through shared physical resources.

## S7 — 2025/2026 isolation benchmark study

Japke et al., *Investigating the impact of isolation on synchronized benchmarks*, UCC 2025 / TU Berlin repository.  
https://depositonce.tu-berlin.de/items/0e48b2cb-92a8-43f7-863d-119595c5e1fd

Relevant evidence:
- multi-tenant resource contention creates performance variability;
- different isolation strategies reduce interference to different degrees.

## S8 — Charité VRE monitoring / recovery

TEF-Health, *Charité VRE Secure Processing Environment*.  
https://tef.charite.de/services/446

Relevant evidence:
- monitoring, audit logging, operational oversight, backup and recovery are explicit capabilities of a managed secure environment;
- shared infrastructure plus isolated project environments.

## S9 — Google Cloud operational readiness / observability

Google Cloud Architecture Center, *Ensure operational readiness and performance using CloudOps*.  
https://docs.cloud.google.com/architecture/framework/operational-excellence/operational-readiness-and-performance-using-cloudops

Relevant evidence:
- observability uses metrics/logs/traces and resource/application indicators to infer health/performance;
- environment health includes resource utilization/performance signals.

Use role: current operational-practice support for observation/state separation; not the defining source for the vertical.

## S10 — AWS observability guidance

AWS, *Guidance for Observability on AWS*.  
https://docs.aws.amazon.com/solutions/observability-on-aws/

Relevant evidence:
- observability gathers operational data to identify anomalies, performance and configuration changes;
- supports distinction between actual environment state and evidence/signals about that state.

## S11 — Configuration drift guidance

HashiCorp, *Use infrastructure as code — Well-Architected Framework*.  
https://docs.hashicorp.com/well-architected-framework/define-and-automate-processes/define/as-code/infrastructure

Microsoft Azure Well-Architected Framework, *Architecture strategies for using infrastructure as code*.  
https://learn.microsoft.com/en-us/azure/well-architected/operational-excellence/infrastructure-as-code-design

Relevant evidence:
- environment-specific bugs arise from configuration drift;
- declarative desired-state definitions and automation are used to reduce divergence.

## S12 — Prior vertical state/reproducibility sources

See `CONFIGURATION-STATE-SOURCES.md`, especially Guix, Nix, OCI and the 2026 Development Environment as Code study.

Use role:
- dependency mismatch, hidden dependencies, non-reconstructable environment, drift and mutable contamination as failure classes.

## Synthesis caution

The finding's environment-health distinctions and failure-family taxonomy are vertical synthesis, not a direct standard. Kubernetes is used as a falsifying example showing that liveness/readiness must be separable; cloud/TRE sources support shared-dependency, observability and capacity failure surfaces.
