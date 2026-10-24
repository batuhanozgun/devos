# Work Environment — Configuration / State / Reproducibility Source Ledger

**Role:** evidence trace for `findings/02-configuration-state-reproducibility.md`  
**Date:** 2026-09-02  
**Warning:** derived retrieval aid; inspect primary sources for exact claims.

## S1 — Reproducible Builds definition

**Source:** reproducible-builds.org, *Definitions — When is a build reproducible?*  
**URL:** https://reproducible-builds.org/docs/definition/

**Load-bearing use:**
- reproducibility depends on same source, build environment and instructions;
- relevant build-environment attributes include dependencies/versions, flags and environment variables;
- relevance is claim-relative rather than every physical property being identical.

## S2 — Guix reproducible computational environments

**Source:** Vallet et al., *Toward practical transparent verifiable and long-term reproducible research using Guix*, Scientific Data / PMC, 2022.  
**URL:** https://pmc.ncbi.nlm.nih.gov/articles/PMC9532446/

**Load-bearing use:**
- version labels do not capture complete dependency graphs;
- build-time and run-time dependency closure matters;
- containers can capture runtime environments without making their own build provenance/reconstruction complete;
- versioned recipes/dependency graph can permit reconstruction of a computational environment.

## S3 — Practical computational reproducibility stack

**Source:** Grüning et al., *Practical Computational Reproducibility in the Life Sciences*, Cell Systems, 2018 / PMC.  
**URL:** https://pmc.ncbi.nlm.nih.gov/articles/PMC6263957/

**Load-bearing use:**
- containers improve isolation/reproducibility but still depend on host kernel/hardware;
- virtual machines can capture a broader execution stack;
- reproducibility mechanisms form layers with trade-offs.

## S4 — Nix reproducible builds

**Source:** NixOS Reproducible Builds.  
**URL:** https://reproducible.nixos.org/

**Load-bearing use:**
- deterministic dependency references and sandboxing are strong prerequisites but do not alone guarantee reproducible outputs;
- nondeterminism can remain.

## S5 — Nix sandbox/environment behavior

**Source:** Official NixOS Wiki, Nix package manager / sandboxing.  
**URL:** https://wiki.nixos.org/wiki/Nix_Package_Manager

**Supporting source:** Nix dev shell / flake environment documentation.  
**URLs:**
- https://wiki.nixos.org/wiki/Development_environment_with_nix-shell
- https://wiki.nixos.org/wiki/Flakes

**Load-bearing use:**
- isolated environment suppresses hidden dependencies;
- declarative environment definitions can create reproducible development shells;
- reproducibility depends on controlling input dependencies.

## S6 — OCI Runtime Specification

**Source:** Open Container Initiative Runtime Spec.  
**URLs:**
- https://specs.opencontainers.org/runtime-spec/
- https://specs.opencontainers.org/runtime-spec/runtime/
- https://specs.opencontainers.org/runtime-spec/config/

**Load-bearing use:**
- explicit configuration → create runtime environment → lifecycle distinction;
- configuration contains process/environment/sandboxing/resource metadata;
- post-create configuration changes do not automatically mutate the already-created container under the specified lifecycle.

## S7 — Development Containers / Codespaces

**Source:** GitHub Docs, *Introduction to dev containers*.  
**URL:** https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers

**Load-bearing use:**
- development environment instances are created from configuration;
- configuration can be changed and the environment rebuilt;
- multiple configurations can exist for one project/repository.

## S8 — 2026 Development Environment as Code study

**Source:** *Using development environment as code for enhancing developer experience: An action design research study*, Journal of Systems and Software 236 (2026), 112803.  
**URL:** https://www.sciencedirect.com/science/article/pii/S0164121226000373

**Load-bearing use:**
- setup/configuration of development environments is error-prone;
- repeatable predefined environment setup improves consistency;
- configuration drift and misconfiguration are practical environment failures.

**Caveat:** study concerns local software-development environments; generalization is comparative, not direct.

## S9 — Configuration differences / works-on-my-machine empirical study

**Source:** Nazário, Bonifácio & Pinto, *Works on My Machine! Managing Configuration Differences between Development and Production Environments*, 2023 preprint/SSRN.  
**URL:** https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4571017

**Load-bearing use:**
- configuration differences between environments produce inconsistent behavior and errors;
- automation, containers and virtualization are used to mitigate environmental differences.

**Strength caveat:** preprint/interview study; used as supporting evidence, not sole basis.

## S10 — USENIX WIP on environment replication assumptions

**Source:** Lorin Hochstein, *You don't have a production environment* (USENIX ;login: Online WIP).  
**URL:** https://www.usenix.org/publications/loginonline/you-don%E2%80%99t-have-production-environment-wip

**Load-bearing use:**
- challenges assumptions that environment boundaries/state can always be completely captured and replicated;
- useful adversarial frame against naive environment-replication claims.

**Strength caveat:** practitioner/essay format, not empirical standard.

## S11 — PiGx / Guix reproducibility

**Source:** Wurmus et al., *PiGx: reproducible genomics analysis pipelines with GNU Guix*, GigaScience, 2018 / PMC.  
**URL:** https://pmc.ncbi.nlm.nih.gov/articles/PMC6275446/

**Load-bearing use:**
- complete software environment specifications can recurse through full dependency graph;
- isolated builds expose only specified dependencies, reducing hidden environmental inputs.

## S12 — Reproducibility barriers in geoscientific analysis (2026)

**Source:** *Overcoming barriers to reproducibility in geoscientific data analysis: Challenges and practical implementation strategies*, Environmental Modelling & Software, 2026.  
**URL:** https://www.sciencedirect.com/science/article/abs/pii/S136481522600109X

**Load-bearing use:**
- computational environment includes hardware and logical/software layers;
- OS, dependencies, code, hardware/resources can all affect reproducibility.

## Source synthesis rule

No source justifies treating one file/image/container as the universal environment boundary. The finding's four-view separation (definition → resolution → realized state → ambient context) is a comparative synthesis across these sources and is subject to later falsification.
