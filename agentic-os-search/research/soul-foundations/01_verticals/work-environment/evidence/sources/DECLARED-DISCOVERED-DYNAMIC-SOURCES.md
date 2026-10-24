# Work Environment — Declared / Discovered / Dynamic Source Ledger

**Role:** evidence trace for `findings/08-declared-discovered-dynamic.md`  
**Date:** 2026-09-02

## S1 — NIST/CNSSI computing environment

NIST CSRC Glossary, `computing environment`.  
https://csrc.nist.gov/glossary/term/computing_environment

Relevant evidence:
- computing environment can be described directly as host + OS + peripherals + applications;
- no explicit declarative manifest/profile is required by the definition.

Use role: simple counterexample to `profile is necessary for environment existence`.

## S2 — 2026 Development Environment as Code study

*Using development environment as code for enhancing developer experience: An action design research study*, Journal of Systems and Software 236 (2026), 112803.  
https://www.sciencedirect.com/science/article/pii/S0164121226000373

Relevant evidence:
- traditional environment setup/configuration can be manual, laborious and error-prone;
- declarative/automated environment-as-code is an improvement/control strategy, not the historical prerequisite for development-environment existence.

## S3 — Google Cloud managed development environments

Google Cloud, *Cloud Workstations*.  
https://cloud.google.com/workstations

Relevant evidence:
- managed environments expose stable configuration/capability controls while provider infrastructure can remain operationally opaque to users;
- supports partial implementation visibility without denying environment existence.

## S4 — Consul dynamic service discovery

HashiCorp Developer, *Consul compared to other configuration management tools*.  
https://developer.hashicorp.com/consul/docs/use-case/config-management

Relevant evidence:
- static provisioning/configuration and dynamic service discovery are separate mechanisms;
- service discovery tracks changing service state and can dynamically route away from unhealthy nodes;
- active service membership can change after provisioning.

## S5 — Nacos dynamic service/configuration discovery

Nacos documentation, `What is Nacos?` / overview.  
https://nacos.io/en/docs/v2.3/what-is-nacos/  
Current overview: https://www.nacos.io/en/docs/latest/overview/

Relevant evidence:
- dynamic service discovery;
- configuration management/update/rollback;
- services/capabilities can be discovered and governed at runtime.

## S6 — Envoy dynamic configuration / xDS

Envoy Documentation, *xDS configuration API overview*.  
https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/operations/dynamic_configuration

Relevant evidence:
- static and dynamic configuration modes;
- listeners/routes/clusters/endpoints can be updated/discovered dynamically.

## S7 — Azure dynamic configuration

Microsoft Learn, *Use dynamic configuration in a .NET background service*.  
https://learn.microsoft.com/en-us/azure/azure-app-configuration/enable-dynamic-configuration-dotnet-background-service

Relevant evidence:
- running services can refresh configuration from external store after startup;
- effective configuration need not be frozen at environment creation.

## S8 — Self-adaptive runtime resource research

Grohmann et al., *SARDE: A Framework for Continuous and Self-Adaptive Resource Demand Estimation*, ACM Transactions on Autonomous and Adaptive Systems 15(2), 2021.  
https://doi.org/10.1145/3463369

Relevant evidence:
- runtime environments and resource demand change continuously;
- observation/adaptation must account for evolving resource state.

## S9 — Dynamic/self-adaptive resource scheduling

*Formal Modeling of Self-Adaptive Resource Scheduling in Cloud*, Computers, Materials & Continua 74(1), 2022/2023.  
https://doi.org/10.32604/cmc.2023.032691

Relevant evidence:
- cloud resources can be provisioned/adapted at runtime based on changing load/state.

Use role: strengthens time-varying realized resource surface, not a universal environment-definition claim.

## S10 — Observability sources

See `FAILURE-HEALTH-SOURCES.md` for Kubernetes probes, Google Cloud/AWS observability and TRE monitoring.

Relevant evidence:
- actual state is inferred through observations/telemetry;
- observation can be incomplete or misconfigured.

## Synthesis caution

The three-way separation `declared/intended → discovered/observed → actual realized state` and the claim that realized support context is conceptually primary are vertical synthesis. Sources establish the counterexamples and mechanisms; they do not publish this exact general model.
