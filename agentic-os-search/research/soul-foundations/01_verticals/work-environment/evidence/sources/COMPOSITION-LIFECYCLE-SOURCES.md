# Work Environment — Composition / Sharedness / Lifecycle Source Ledger

**Role:** evidence trace for `findings/04-composition-sharedness-lifecycle.md`  
**Date:** 2026-09-02

## S1 — NIST/ECMA SEE sub-environments

NIST SP 500-211 / ECMA TR/55, *Reference Model for Frameworks of Software Engineering Environments*.  
https://www.nist.gov/publications/reference-model-frameworks-software-engineering-environments-technical-report-ecma-tr55

Relevant evidence:
- one SEE may be divided into sub-environments;
- objects/operations can belong to multiple sub-environments;
- sub-environments restrict visible/usable resources and facilities.

## S2 — GitHub Codespaces lifecycle

GitHub Docs, *Understanding the codespace lifecycle*.  
https://docs.github.com/en/codespaces/about-codespaces/understanding-the-codespace-lifecycle

Relevant evidence:
- create → connect/disconnect → timeout/stop → restart → rebuild → delete distinctions;
- stopped environment can retain saved state;
- rebuild can preserve workspace state while replacing container state;
- deletion and retention are distinct from stopping.

Use role: current concrete counterexample to scalar `active/inactive` lifecycle models.

## S3 — Vagrant environment lifecycle

HashiCorp Developer, *Set up your development environment — Manage the environment lifecycle*.  
https://developer.hashicorp.com/vagrant/tutorials/get-started/setup-project

Relevant evidence:
- suspend preserves VM memory state;
- resume restores it;
- provisioning/reprovisioning differs from suspend/resume and ordinary start/stop.

## S4 — ERICA trusted research environments (2026)

*E-Research Institutional Cloud Architecture (ERICA): An Orchestration Meta-Framework for Establishing Trusted Research Environments Using Public Cloud Computing*, 2026.  
https://pmc.ncbi.nlm.nih.gov/articles/PMC13213532/

Relevant evidence:
- one ERICA instance can host many Project Spaces;
- project spaces are isolated through network/access controls while sharing the larger instance/cloud substrate;
- common code base can produce multiple organisational instances.

## S5 — Charité VRE / Secure Processing Environment

TEF-Health service description, *Charité VRE Secure Processing Environment*.  
https://tef.charite.de/services/446

Relevant evidence:
- isolated project workspaces on shared multi-tenant infrastructure;
- shared underlying compute/storage/authentication/monitoring can coexist with project isolation;
- environments may be dedicated or shared depending on requirements.

## S6 — FRIDGE federated TRE governance (2026)

Machin et al., *FRIDGE Governance - Shared Responsibility and Operational Roles for Trusted Research Environments on AI Supercomputing Infrastructure*, Zenodo, Version 1.0, 2026-05-05.  
https://zenodo.org/records/20040643

Relevant evidence:
- an existing TRE can provision an ephemeral satellite TRE/enclave on external compute;
- lifecycle includes provisioning, active use, teardown and termination;
- support/governance boundary can extend across hosting-organisation boundaries.

## S7 — D4Science/VRE modular deployment

*Virtual Research Environments for Environmental and Earth Sciences: Approaches and Experiences*, Springer chapter.  
https://link.springer.com/chapter/10.1007/978-3-030-52829-4_15

Relevant evidence:
- VRE components can be deployed across multiple nodes/instances;
- multiple VRE Managers can serve different virtual organisations;
- multi-tenancy gives communities different feature sets selected at VRE definition phase.

## S8 — VRE lifecycle literature

Buddenbohm et al., *Success Criteria for the Development and Sustainable Operation of Virtual Research Environments*, D-Lib Magazine, 2015.  
https://www.dlib.org/dlib/september15/buddenbohm/09buddenbohm.html

Relevant evidence:
- VRE lifecycle includes prototype, development, transfer, operation/product and dismantling perspectives;
- modular VRE components can have their own lifecycles while participating in common operation.

Scope caveat: service/infrastructure lifecycle, not necessarily one short-lived runtime instance. Used to test multi-level lifecycle rather than to impose its phases universally.

## S9 — NaaVRE

Zhao et al., *Notebook-as-a-VRE (NaaVRE): From private notebooks to a collaborative cloud virtual research environment*, 2022.  
https://onlinelibrary.wiley.com/doi/full/10.1002/spe.3098

Relevant evidence:
- collaborative cloud VRE combines multiple integrated services and remote infrastructure automation;
- environment composition spans user-facing notebook/workspace and cloud services.

## S10 — TRE implementation trade-offs

*Challenges and opportunities in implementing trusted research environments for health data research*, BMJ Health & Care Informatics / PMC, 2024/2025.  
Relevant retrieval via current literature searches.

Use role:
- reports common use of isolated per-user VMs versus shared multi-user systems;
- supports separation of isolation, sharing and resource capacity trade-offs.

## S11 — AWS TRE/VRE integration

AWS HPC Blog, *Integrating Research and Engineering Studio in Trusted Research Environments built on AWS*.  
https://aws.amazon.com/blogs/hpc/integrating-research-and-engineering-studio-in-trusted-research-environments-built-on-aws/

Relevant evidence:
- isolated projects can provision compute environments inside a broader VRE/TRE functional architecture;
- data and compute environment boundaries can be separate but coordinated.

## Synthesis caution

The finding's distinctions among **support boundary**, **isolation boundary**, and **provider/administrative boundary**, as well as the candidate lifecycle transition families, are comparative synthesis constructs. They are not a direct taxonomy from one source.
