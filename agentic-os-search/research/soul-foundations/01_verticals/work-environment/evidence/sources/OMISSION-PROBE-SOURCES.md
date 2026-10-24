# Work Environment — Omission / Falsifier Probe Source Ledger

**Role:** evidence trace for the final completeness/omission audit  
**Date:** 2026-09-02  
**Warning:** this ledger supplements, rather than replaces, the topic-specific ledgers.

## Probe A — Offline / air-gapped environments

### Posit license management
https://docs.posit.co/floating-license-servers.html

Evidence:
- license files can support ephemeral/container/air-gapped environments;
- online license-server dependence is not universal.

### Python isolated build tooling
Debian manpage for `pyproject-build` / Python build isolation.  
https://manpages.debian.org/testing/python3-build/pyproject-build.1.en.html

Evidence:
- isolated build environment normally resolves dependencies separately;
- offline/air-gapped operation requires pre-installed/provided dependencies.

**Probe result:** maps to connectivity/interface constraints, dependency closure and update/provisioning strategy. No new first-order dimension.

## Probe B — Secrets / credentials / leases

### GitHub Codespaces development-environment secrets
https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-development-environment-secrets-for-your-repository-or-organization

### QNX floating licenses
https://www.qnx.com/developers/docs/floating_licenses/com.qnx.doc.sdp.floating_license/topic/introduction.html

Evidence:
- capability can depend on runtime-injected secrets/credentials or leased licenses not embedded in ordinary component configuration;
- token/lease exhaustion can prevent an installed tool from being usable.

**Probe result:** refines capability binding, access and capacity. No new first-order dimension.

## Probe C — Snapshot / restore / migration

### Vagrant snapshots
https://developer.hashicorp.com/vagrant/docs/cli/snapshot

### IBM migration environments
https://www.ibm.com/docs/en/max-it/cd.0.0_cd?topic=migration-environments

Evidence:
- point-in-time instance-state restore differs from configuration/content promotion between distinct environments.

**Probe result:** maps to lifecycle, persistence, identity/equivalence and portability. No new first-order dimension.

## Probe D — Managed / opaque development environments

### Google Cloud Workstations
https://cloud.google.com/workstations

Evidence:
- provider-managed environment can expose stable user capabilities/configuration/security controls while underlying infrastructure is centrally administered and partly opaque.

**Probe result:** maps to control surface, administrative/provider boundary and observability. No new first-order dimension.

## Probe E — Dynamic discovery / dynamic configuration

### Consul service discovery
https://developer.hashicorp.com/consul/docs/use-case/config-management

### Nacos
https://www.nacos.io/en/docs/latest/overview/

### Envoy xDS
https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/operations/dynamic_configuration

### Azure App Configuration
https://learn.microsoft.com/en-us/azure/azure-app-configuration/enable-dynamic-configuration-dotnet-background-service

Evidence:
- service membership, endpoints and configuration can be discovered/changed at runtime;
- environment composition need not be frozen at creation.

**Probe result:** produced a material correction: explicit profile is optional and resolution/live state can be dynamic. Captured in Finding 08. After correction, no additional first-order family required.

## Probe F — Hardware / instrument-heavy environments

### Intel oneAPI FPGA development environment
https://www.intel.com/content/www/us/en/docs/oneapi-fpga-add-on/developer-guide/2024-2/installing-the-intel-oneapi-fpga-development.html

### NI Hardware-in-the-Loop systems
https://www.ni.com/en/solutions/transportation/hardware-in-the-loop/what-is-hardware-in-the-loop-.html

### MathWorks HIL environment model
https://www.mathworks.com/help/ecoder/ug/hardware-in-the-loop-hil-simulation.html

Evidence:
- technical environments can integrate physical target hardware, real-time processors, I/O/bus interfaces and software/configuration;
- target hardware/drivers can be load-bearing environment dependencies.

**Probe result:** rejects software-only boundaries but maps to substrate/resources/interfaces/configuration/equivalence. No new first-order dimension.

## Probe G — Heterogeneous edge hardware / topology

### Edge-to-cloud systematic review
https://www.sciencedirect.com/science/article/am/pii/S0743731522000843

Evidence:
- heterogeneous hardware, networks and runtime configurations complicate repeatability and require runtime/environment characterization.

**Probe result:** maps to distribution, substrate, resource/capability, observability and equivalence. No new first-order dimension.

## Probe H — Purpose-role labels

### Azure Deployment Environments
https://learn.microsoft.com/en-us/azure/deployment-environments/concept-environments-key-concepts

### GitHub deployment environments
https://docs.github.com/en/actions/concepts/workflows-and-actions/deployment-environments

Evidence:
- environment definition/resource collection can be separated from purpose types such as dev/test/staging/prod;
- purpose labels can activate policy/protection semantics.

**Probe result:** purpose role is a dimension over profiles/instances, not a separate environment substance. Captured in Finding 07.

## Probe I — Shared infrastructure / isolation / contention

### ERICA 2026
https://pmc.ncbi.nlm.nih.gov/articles/PMC13213532/

### Charité VRE
https://tef.charite.de/services/446

### Tenant isolation research
https://link.springer.com/article/10.1186/s13677-018-0121-8

Evidence:
- shared substrate can host isolated project environments;
- shared dependencies can still create contention/interference.

**Probe result:** maps to composition, isolation, support/provider boundaries, capacity and failure propagation. No new first-order dimension.

## Probe J — Partial failure / readiness / observability

### Kubernetes probes
https://kubernetes.io/docs/concepts/workloads/pods/probes/

### Google Cloud observability
https://docs.cloud.google.com/architecture/framework/operational-excellence/operational-readiness-and-performance-using-cloudops

Evidence:
- liveness, readiness and startup differ;
- observation uses metrics/logs/traces and can be misconfigured.

**Probe result:** maps to environment condition/health, dependency closure and observation. Captured in Finding 05.

## Probe K — Reproducibility / hidden dependencies / nondeterminism

### Reproducible Builds
https://reproducible-builds.org/docs/definition/

### Guix reproducibility research
https://pmc.ncbi.nlm.nih.gov/articles/PMC9532446/

### Nix reproducibility
https://reproducible.nixos.org/

Evidence:
- reproducibility depends on controlled relevant environment attributes and dependency closure;
- isolation/declarative dependencies reduce but do not eliminate nondeterminism.

**Probe result:** maps to definition/resolution/live/ambient state and protected equivalence. No new first-order dimension.

## Probe L — Broad digital workplace / socio-technical surroundings

### Digital workplace integrative review
https://doi.org/10.1016/j.chb.2021.107118

### Digital Work Environment / CSCW
https://mau.diva-portal.org/smash/record.jsf?pid=diva2%3A1821670

Evidence:
- these terms often include practices, culture, human-technology relationships and broader work-environment effects.

**Probe result:** boundary/terminology falsifier. Supports keeping current vertical technical rather than reopening broad surrounding/socio-technical environment.

## Audit interpretation

The probes above were selected to be structurally different from the initial software-development cases. One probe (dynamic/discovered environments) materially corrected the emerging frame. Subsequent probes predominantly map to the corrected established dimensions.

This pattern supports bounded sufficiency, but this remains **same-model adversarial self-review, not independent verification**.
