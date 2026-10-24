# Work Environment — Capability / Constraint / Interface Source Ledger

**Role:** evidence trace for `findings/03-capabilities-constraints-interfaces-resources.md`  
**Date:** 2026-09-02

## S1 — NIST/ECMA SEE reference model

NIST SP 500-211 / ECMA TR/55, *Reference Model for Frameworks of Software Engineering Environments*.  
Landing page: https://www.nist.gov/publications/reference-model-frameworks-software-engineering-environments-technical-report-ecma-tr55

Relevant evidence:
- framework services above underlying platform;
- object management, process management, communication, OS, UI, policy-enforcement and administration service families;
- tool registration/integration, sub-environments and resource restriction.

## S2 — ISO/IEC 15940 SEE services

ISO/IEC 15940:2013, *Software Engineering Environment Services*.  
https://www.iso.org/standard/60100.html

Relevant evidence:
- environment services support systems/software lifecycle activities;
- service-centric rather than mere component-list framing.

## S3 — NIST sandbox definition

NIST CSRC Glossary, `Sandbox`.  
https://csrc.nist.gov/glossary/term/Sandbox

Relevant evidence:
- restricted controlled execution environment;
- environment semantics include permitted resource/privilege access and isolation.

## S4 — NERSC science gateways

NERSC Documentation, *Science Gateways*.  
https://docs.nersc.gov/services/science-gateways/

Relevant evidence:
- gateway as interface to HPC/storage;
- shared computation/data access;
- remote resource building blocks;
- critical gateway dependencies inherit availability from underlying infrastructure.

## S5 — SciGaP

Science Gateway Platform as a Service.  
https://scigap.org/  
https://scigap.org/pages/about

Relevant evidence:
- gateways expose distributed computational/data resources while shielding complexity;
- hosted services provide identity, accounts, authorization and access to multiple computational resources through APIs;
- general capabilities can be outsourced/mediated rather than locally implemented.

## S6 — Science-gateway authentication/authorization research

Christie et al., *Managing authentication and authorization in distributed science gateway middleware*, Future Generation Computer Systems 111 (2020).  
https://www.sciencedirect.com/science/article/pii/S0167739X18314729

Relevant evidence:
- authentication/authorization are key gateway features;
- permissions determine access to restricted compute/data/application resources;
- gateways/middleware can integrate third-party identity providers and remote resources via APIs;
- one gateway can use multiple backend systems.

## S7 — Secure VRE example

University of Groningen, *Virtual Research Environment*.  
https://www.rug.nl/digital-competence-centre/it-solutions/analyse-and-compute/virtual-research-workspace?lang=en

Relevant evidence:
- secured collaborative technical environment;
- internet access can be deliberately blocked;
- studies can be isolated from one another;
- compute/memory/graphics capacity can be scaled;
- applications can be added.

Use role: counterexample showing constraints/isolation/capacity can define environment behavior even when tool family remains similar.

## S8 — D4Science 2026 service/access policies

D4Science, *Service Policy* v1.3 (effective 2026-04-01).  
https://www.d4science.org/policies/service-policy

D4Science, *Access and Acceptable Use Policy* v1.1.  
https://www.d4science.org/policies/access-and-acceptable-use

Relevant evidence:
- integrated ecosystem of services, VREs, computational platforms and APIs;
- coherent user-oriented environment from interconnected services;
- access to shared capabilities is governed/controlled.

## S9 — NaaVRE

Zhao et al., *Notebook-as-a-VRE (NaaVRE): From private notebooks to a collaborative cloud virtual research environment*, Software: Practice and Experience, 2022.  
https://onlinelibrary.wiley.com/doi/10.1002/spe.3098

Relevant evidence:
- remote infrastructure automation;
- authentication/authorization infrastructure;
- distributed data interfaces and workflow collaboration;
- environment capabilities can be composed from remote services.

## S10 — NORC Data Enclave

NORC at the University of Chicago, *Data Enclave*.  
https://www.norc.org/services-solutions/data-enclave.html

Relevant evidence:
- technical environment combines computation, role-based access, databases, analytic/visualization tools and secure data sharing;
- supports capacity/access/utility distinction.

## S11 — Devfile / OCI specs

Devfile: https://devfile.io/docs/2.3.0/devfile-schema  
OCI runtime config: https://specs.opencontainers.org/runtime-spec/config/

Relevant evidence:
- components, commands, events/endpoints/resources/variables as explicit configured environment facets;
- runtime configuration specifies process environment, sandboxing and platform-specific resource details.

## S12 — NIST SEE capability modeling

Zelkowitz, *Modeling Software Engineering Environment Capabilities*, Journal of Systems and Software 35(1), 1996.  
https://www.sciencedirect.com/science/article/pii/0164121295000828

Relevant evidence:
- service-based model can formally characterize environment capabilities, interoperability and integration.

## Synthesis caution

The terms `support closure`, `bound dependency`, and the six-state separation `exists → reachable → integrated/bound → permitted → available → sufficient` are vertical synthesis constructs. They are not quoted taxonomies from these sources and must remain open to falsification.
