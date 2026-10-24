# Work Environment — Purpose / Control / Portability Source Ledger

**Role:** evidence trace for `findings/07-purpose-control-portability.md`  
**Date:** 2026-09-02

## S1 — Azure Deployment Environments (2026)

Microsoft Learn, *What is Azure Deployment Environments?*  
https://learn.microsoft.com/en-us/azure/deployment-environments/overview-what-is-azure-deployment-environments

Relevant evidence:
- deployment environment = collection of infrastructure resources defined by an environment definition/template;
- environment types such as sandbox/testing/staging/production are separately applied for policy/governance;
- on-demand environments and lifecycle-stage roles.

Freshness note: service documentation states the product is in maintenance mode; conceptual evidence remains useful but is not relied upon for future product recommendations.

## S2 — Azure Deployment Environments key concepts

Microsoft Learn, *Key concepts and roles*.  
https://learn.microsoft.com/en-us/azure/deployment-environments/concept-environments-key-concepts

Relevant evidence:
- environment resource collection, environment definition and environment type are distinct;
- environment definitions combine IaC template + environment metadata;
- environment types are named purpose categories such as dev/test/sandbox/preprod/prod.

## S3 — GitHub deployment environments

GitHub Docs, *Deployment environments*.  
https://docs.github.com/en/actions/concepts/workflows-and-actions/deployment-environments

Relevant evidence:
- production/staging/development are general deployment targets;
- environment target can carry protection rules, branch restrictions and secret-access controls.

Use role: demonstrates purpose label can activate policy/constraint semantics rather than identify one substrate type.

## S4 — Oracle development/deployment environments

Oracle Database 26 documentation, *About Development and Deployment Environments*.  
https://docs.oracle.com/en/database/oracle/oracle-database/26/tdddg/development-and-deployment-environments.html

Relevant evidence:
- development, test, education and production environments defined primarily by purpose/use in application lifecycle.

## S5 — UKHSA environment standards

UK Health Security Agency development standards, *Environments*.  
https://ukhsa-collaboration.github.io/standards-org/development-standards/environments/

Relevant evidence:
- environments vary by purpose, size and data classification;
- environment reproducibility/consistency and promotion processes are explicit concerns.

## S6 — Google Cloud Workstations

Google Cloud, *Cloud Workstations*.  
https://cloud.google.com/workstations

Supporting announcement: https://cloud.google.com/blog/products/application-development/introducing-cloud-workstations

Relevant evidence:
- fully managed development environments;
- administrators centrally provision/manage/secure while users access via browser/local IDE;
- consistent configurations, policies and private service access;
- underlying provider operation can be hidden from everyday environment usage.

Use role: counterexample to `environment requires substrate administration/visibility`.

## S7 — IBM migration environments

IBM Documentation, *Migration environments*.  
https://www.ibm.com/docs/en/max-it/cd.0.0_cd?topic=migration-environments

Relevant evidence:
- development/test/production are distinct source/target environments;
- configuration content is migrated between them;
- moving content/configuration does not imply the same environment instance moved.

## S8 — IBM CICS configuration promotion

IBM Documentation, *Migration through multiple environments*.  
https://www.ibm.com/docs/en/cics-cm/5.3.0?topic=concepts-migration-through-multiple-environments

Relevant evidence:
- configuration/resource definitions propagate from development to test to production as distinct target configurations.

## S9 — Vagrant snapshot/restore

HashiCorp Developer, `vagrant snapshot`.  
https://developer.hashicorp.com/vagrant/docs/cli/snapshot

Relevant evidence:
- point-in-time guest-machine state can be captured/restored;
- snapshot support depends on provider;
- restore semantics differ from provisioning/recreation.

## S10 — Cloud portability / migration research

Opara-Martins et al., *Critical analysis of vendor lock-in and its impact on cloud computing migration: a business perspective*, Journal of Cloud Computing, 2016.  
https://doi.org/10.1186/s13677-016-0054-z

Relevant evidence:
- portability can require moving application/data/components across cloud platforms;
- platform-independent packaging/interfaces can reduce but not eliminate lock-in/migration constraints.

## S11 — GitHub Codespaces secrets

GitHub Docs, *Managing development environment secrets for your repository or organization*.  
https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-development-environment-secrets-for-your-repository-or-organization

Relevant evidence:
- environment may recommend/require secrets such as API keys;
- secrets can be injected/scoped separately from repository/environment definition.

## S12 — QNX floating licensing (2026 docs)

QNX, *Floating License Management Guide — Introduction*.  
https://www.qnx.com/developers/docs/floating_licenses/com.qnx.doc.sdp.floating_license/topic/introduction.html

Relevant evidence:
- installed development tools request lease/token from license server;
- when no license token is available, tool use is denied;
- one shared licensed capability can therefore be capacity/lease constrained at runtime.

Use role: counterexample to `installed component = currently usable capability`.

## S13 — Posit air-gapped/ephemeral licensing

Posit Docs, floating license / license management documentation.  
https://docs.posit.co/floating-license-servers.html

Relevant evidence:
- license files are designed to work in ephemeral, containerized and air-gapped environments;
- floating-license server dependence is one optional binding pattern.

## S14 — Hardware/environment reproducibility

National Academies, *Reproducibility and Replicability in Science* (2019); Guix and computational-reproducibility literature from `CONFIGURATION-STATE-SOURCES.md`.

Relevant evidence:
- hardware architecture and library/driver dependencies can affect computational reproducibility and are part of relevant environment characterization.

## S15 — Edge-to-cloud reproducibility review

*Distributed intelligence on the Edge-to-Cloud Continuum: A systematic literature review*, Journal of Parallel and Distributed Computing / ScienceDirect.  
https://www.sciencedirect.com/science/article/am/pii/S0743731522000843

Relevant evidence:
- heterogeneous hardware/software/network configurations complicate repeatability/reproducibility;
- actual runtime configuration/provenance can matter across heterogeneous edge infrastructure.

## Synthesis caution

`purpose role`, the control-surface decomposition, `binding dependency`, and the portability subtypes are comparative research constructs. No source is claimed to standardize those taxonomies exactly.
