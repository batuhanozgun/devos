# Work Environment — Boundary / Identity Source Ledger

**Role:** evidence trace for `findings/01-boundary-and-identity.md`  
**Date:** 2026-09-02  
**Warning:** this is a retrieval aid, not primary evidence itself.

## S1 — NIST / ECMA SEE reference model

**Source:** NIST SP 500-211, *Reference Model for Frameworks of Software Engineering Environments (Technical Report ECMA TR/55, 3rd Edition)*, 1993.  
**Publisher:** National Institute of Standards and Technology / ECMA.  
**Landing page:** https://www.nist.gov/publications/reference-model-frameworks-software-engineering-environments-technical-report-ecma-tr55  
**Report:** https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication500-211.pdf

**Load-bearing use:**
- SEE as a system providing automated support;
- distinction among underlying platform, tools and framework/infrastructure capabilities;
- integration as the strongest differentiator from tools merely executing together;
- sub-environments, resource restriction and overlapping scoped views;
- environments can be instantiated/adapted/customized.

**Scope caveat:** historical software-engineering-specific reference model; not evidence that its full service model is domain-general or current architecture guidance.

## S2 — SEI integration report

**Source:** Alan W. Brown, Peter H. Feiler, Kurt C. Wallnau, *Understanding Integration in a Software Development Environment*, CMU/SEI-91-TR-031, 1992.  
**URL:** https://www.sei.cmu.edu/library/understanding-integration-in-a-software-development-environment/

**Load-bearing use:**
- software development environment as a unifying framework of services;
- integration occurring at mechanism, end-user service and process/practice levels.

**Scope caveat:** software development and historical SDE research; integration is not assumed to be necessary for minimal execution environments.

## S3 — ISO/IEC 15940 SEE services

**Source:** ISO/IEC 15940:2013, *Systems and software engineering — Software Engineering Environment Services*.  
**URL:** https://www.iso.org/standard/60100.html

**Load-bearing use:**
- SEE services as a collection of services, partly or fully automated by software tools, supporting human activities in systems/software engineering;
- current standard remains published but is under revision.

**Freshness note:** ISO/IEC CD 15940 Edition 3 is under development: https://www.iso.org/standard/93381.html

## S4 — NIST platform glossary

**Source:** NIST CSRC Glossary, `Platform`.  
**URL:** https://csrc.nist.gov/glossary/term/Platform

**Load-bearing use:**
- platform as hardware/device and/or associated operating system or virtual environment on which software can be installed or run.

**Inference boundary:** used to distinguish substrate/platform from a richer work-support environment; NIST does not state the project synthesis directly.

## S5 — NIST sandbox glossary

**Source:** NIST CSRC Glossary, `Sandbox`.  
**URL:** https://csrc.nist.gov/glossary/term/Sandbox

**Load-bearing use:**
- restricted/controlled execution environment;
- permissions/resources may be deliberately constrained.

**Reason for inclusion:** falsifies a strong claim that every technical environment must be a large integrated multi-tool system.

## S6 — OCI Runtime Specification

**Source:** Open Container Initiative, *Runtime Specification*, current standards-track version.  
**Overview:** https://specs.opencontainers.org/runtime-spec/  
**Runtime/lifecycle:** https://specs.opencontainers.org/runtime-spec/runtime/  
**Configuration:** https://specs.opencontainers.org/runtime-spec/config/

**Load-bearing use:**
- explicit separation of container configuration, execution environment and lifecycle;
- concrete container created from configuration and addressed with an identifier;
- environment includes resource/process/isolation configuration.

**Scope caveat:** container execution environments only; not a general work-environment definition.

## S7 — Development Containers / GitHub Codespaces

**Source:** GitHub Docs, *Introduction to dev containers*.  
**URL:** https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers

**Supporting source:** *Adding a dev container configuration to your repository*.  
**URL:** https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration

**Load-bearing use:**
- repository can contain one or multiple development-environment configurations;
- concrete codespaces are created from a selected configuration;
- configuration can be changed and environment rebuilt.

**Scope caveat:** concrete contemporary implementation/specification family; used as counterexample/instance evidence, not defining anchor.

## S8 — Devfile specification

**Source:** Devfile schema / open standard for containerized development environments.  
**Current site:** https://devfile.io/  
**Schema example:** https://devfile.io/docs/2.3.0/devfile-schema

**Load-bearing use:**
- environment/workspace structure includes components, commands, events, projects, variables and parent/template relationships;
- supports declarative environment descriptions and composition.

**Scope caveat:** cloud-native development environments, not universal work environments.

## S9 — Virtual Research Environment definition

**Source:** Oxford-hosted historical VRE definition page.  
**URL:** https://users.ox.ac.uk/~mikef/rts/vre/text2.html

**Key scope:** VRE as online tools, systems and processes interoperating to facilitate/enhance research within and across institutional boundaries.

**Load-bearing use:**
- logical/distributed boundary;
- integration of tools/systems/processes rather than one machine or UI.

**Source-strength caveat:** historical web surface; corroborated with later VRE/science-gateway literature below.

## S10 — Virtual Research Environments / research infrastructure distinction

**Source:** *Mapping heterogeneous research infrastructure metadata into a unified catalogue for use in a generic virtual research environment*, Future Generation Computer Systems, 2019/2020.  
**URL:** https://www.sciencedirect.com/science/article/abs/pii/S0167739X19302699

**Load-bearing use:**
- VREs as integrated online environments supporting actual use of data/services/facilities;
- distinction between VRE, research infrastructure and e-infrastructure;
- remote compute/storage can support an environment without being the visible workspace.

## S11 — Science gateways / VRE global survey

**Source:** *The global impact of science gateways, virtual research environments and virtual laboratories*, Future Generation Computer Systems 95 (2019).  
**URL:** https://www.sciencedirect.com/science/article/pii/S0167739X18314018

**Load-bearing use:**
- digital environments providing integrated access to software, data, collaboration tools, workflows, instrumentation and HPC, typically through web/mobile interfaces.

## S12 — ACCESS / SDSC science gateway descriptions

**Sources:**
- San Diego Supercomputer Center: https://www.sdsc.edu/services/science_gateways.html
- ACCESS FAQ: https://access-ci.atlassian.net/wiki/spaces/ACCESSdocumentation/pages/575963137/Science+Gateways+FAQs

**Load-bearing use:**
- gateways integrate tools/applications/data and connect diverse remote resources;
- interface/gateway and underlying resources are distinguishable.

## S13 — ISO 6385 terminology collision

**Source:** ISO 6385:2016, *Ergonomics principles in the design of work systems*.  
**Official page:** https://www.iso.org/standard/63785.html

**Load-bearing use:**
- `work system` is an integrated ergonomics concept involving worker(s), equipment, workspace, work environment and tasks;
- bare `work environment` belongs to a broad surrounding-factors meaning in this tradition.

**Purpose in this vertical:** rival-frame and terminology guardrail only; not evidence that the intended technical phenomenon should be modeled as an ergonomic work system.

## S14 — 2026 Development Environment as Code study

**Source:** *Using development environment as code for enhancing developer experience: An action design research study*, Journal of Systems and Software 236 (2026), 112803.  
**URL:** https://www.sciencedirect.com/science/article/pii/S0164121226000373

**Load-bearing use in later state/identity work:**
- environment setup/configuration is error-prone;
- predefined/automated environments can be repeated and made more consistent;
- environment configuration drift is a practical failure surface.

**Scope caveat:** local software development environments and developer experience; not a domain-general definition.

## Source-role summary

- **Primary/authoritative standards/specifications:** S1, S3, S4, S5, S6, S8, S13.
- **Authoritative institutional technical reports/docs:** S2, S7, S12.
- **Peer-reviewed research:** S10, S11, S14.
- **Historical definition support:** S9.

No single source supplies the domain-general synthesis in the finding. The finding is a comparative inference across the sources above and must remain open to counterexamples.
