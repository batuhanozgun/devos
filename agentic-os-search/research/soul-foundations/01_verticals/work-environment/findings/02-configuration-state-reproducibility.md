# Work Environment — Finding 02: Configuration, State, Reproducibility and Drift

**Status:** current topic finding; independent vertical; not architecture  
**Date:** 2026-09-02

## 1. Result in one paragraph

A technical work environment cannot be understood only from a nominal label or a configuration file. The evidence requires separating **declared/intended environment definition**, **resolved/provisioned composition**, **live realized state**, and **ambient/host dependencies**. Reproducibility is achieved only to the extent that all behaviorally relevant inputs and dependencies are controlled or characterized; it is therefore safer to treat reproducibility as **purpose- and fidelity-relative**, not as an unqualified binary property of an environment. Environment drift is any materially relevant divergence over time or across instances between intended/resolved/live environmental conditions that changes protected behavior, capability or compatibility.

## 2. Definition/profile, resolution and realized state are different

A declarative environment definition may state desired tools, versions, services, variables, resources or components. It does not automatically prove what was actually instantiated.

The following layers should remain separable when relevant:

1. **definition/profile** — what the environment is intended to contain/expose;
2. **resolution/closure** — the concrete dependency graph, images, packages, services and substrate choices selected from that definition;
3. **realized instance state** — what is actually running/available now, including mutable state and runtime configuration;
4. **ambient/host context** — undeclared host/kernel/hardware/network/external-service conditions that may still affect behavior.

OCI makes configuration and created runtime environment distinct lifecycle concepts. Reproducible-build and Guix research shows why a list of top-level versions is not a complete dependency closure.

## 3. Environment configuration is not necessarily complete

Guix reproducibility research shows that software/library version labels can omit large recursive build-time and run-time dependency graphs. Container images can capture a runtime stack while still failing to preserve enough information to rebuild the image itself. Other reproducibility research notes that containers continue to depend on host kernels and underlying hardware.

Therefore:

> **declared configuration ≠ complete causal environment closure**

A configuration may be sufficient for one protected behavior and insufficient for another.

Examples of potentially hidden/relevant dependencies include:
- transitive packages and build tools;
- OS/kernel behavior;
- hardware/architecture/GPU drivers;
- locale/timezone/environment variables;
- network availability and reachable external services;
- mutable caches or local state;
- dynamically resolved versions or remote images/tags.

This list is illustrative, not a universal required envelope.

## 4. Reproducibility is relative to a protected equivalence

Reproducible-builds.org defines a reproducible build by holding relevant source, build environment and instructions fixed and checking bit-identical specified artifacts. Importantly, the relevant environmental attributes are defined relative to the reproducibility claim.

For work environments more generally, there may be several possible equivalence targets:

- **bit/content equivalence** — exact binaries/files;
- **configuration equivalence** — same relevant declared/resolved configuration;
- **capability equivalence** — same relevant operations/resources/services available;
- **behavioral equivalence** — same relevant observable behavior under protected scenarios;
- **performance/resource equivalence** — sufficiently similar timing/capacity characteristics where those matter.

Two environments can satisfy one equivalence target and fail another. Thus `reproducible` without specifying the protected equivalence can be misleading.

## 5. Isolation reduces uncontrolled inputs but does not guarantee closure

Sandboxes, containers, virtual environments and functional/declarative package systems all reduce environmental variation in different ways.

- Nix sandboxing blocks access to undeclared resources to reduce hidden dependencies.
- Guix captures recursively defined build/run dependencies and versioned package recipes.
- Containers isolate/capture much of the software environment, but can still share host kernel/hardware properties.
- Virtual machines can capture more of the machine stack at additional cost/complexity.

Therefore:

> **isolation ≠ reproducibility**, though isolation can improve reproducibility by narrowing uncontrolled inputs.

Likewise:

> **reproducibility ≠ immutability** and **reproducibility ≠ persistence**.

An ephemeral environment can be highly reproducible; a long-lived environment can drift badly.

## 6. Environment drift is broader than file/config drift

The 2026 Development Environment as Code study treats configuration consistency and reduction of configuration drift as practical development-environment concerns. The broader evidence suggests several distinct drift classes:

- **definition drift:** intended specification changes;
- **resolution drift:** same loose definition resolves to different concrete versions/dependencies over time;
- **instance drift:** a live environment is manually or automatically changed after creation;
- **ambient drift:** host, external service, network, hardware or other undeclared conditions change;
- **cross-instance divergence:** instances expected to be equivalent are not;
- **interface/policy drift:** exposed endpoints, permissions, limits or policies change while components appear unchanged.

Not every difference is harmful. Drift is decision-relevant when it breaks a protected equivalence, capability, compatibility or expected behavior.

## 7. Rebuild and mutation have different identity implications

An environment can evolve by:

- mutating an existing instance;
- rebuilding/recreating an instance from the same definition;
- rebuilding from an updated definition;
- replacing underlying substrate while preserving a profile;
- snapshotting/restoring a prior resolved state.

These operations reinforce the multi-level identity result from Finding 01:

- instance identity may be lost while profile identity is preserved;
- profile identity may remain nominally unchanged while resolution changes;
- instance identity may remain the same while behavioral equivalence is broken by drift.

Therefore environment change cannot be modeled safely as one scalar `version` or one boolean `same/different` flag.

## 8. Reproducibility requires a closure question, not a tool choice

A container, lock file, package manager, VM, image, manifest or declarative configuration is a mechanism. None is universally equivalent to “the environment.”

A stronger research question is:

> **What environmental attributes and dependencies must be controlled, bound, observed or reconstructed so that the claimed equivalence remains valid for the protected use?**

This is intentionally mechanism-neutral.

The relevant closure can include lower layers only when they can materially change the protected behavior. For one activity, package versions may suffice; for another, CPU architecture, GPU driver, locale, network policy or external service version may be load-bearing.

## 9. Failure surfaces established by this pass

Environment-specific failure classes include:

- missing or incompatible dependency;
- unpinned/dynamically resolved dependency;
- undeclared host dependency;
- inconsistent configuration across instances;
- mutable instance contamination;
- stale/corrupt environment state;
- host/kernel/hardware mismatch;
- external service or interface version mismatch;
- insufficient or changed resource allocation;
- environment definition that cannot be reconstructed because sources/inputs disappeared;
- false reproducibility claim caused by testing only one instance or one host.

These failures can manifest elsewhere, but their proximate cause lies in the technical environment's composition/state/closure.

## 10. Rival reductions tested

### Environment = configuration file
**Rejected.** A configuration is a representation/definition; the realized environment and hidden dependencies can differ.

### Environment = installed package list
**Rejected.** Build-time/runtime/host dependencies and non-package state can remain material.

### Environment = container image
**Rejected as universal identity.** Image is one capture mechanism; host/kernel/hardware and image provenance/rebuildability can remain outside it.

### Environment = immutable snapshot
**Rejected as universal requirement.** Environments can be intentionally mutable; immutability is a control strategy, not the phenomenon itself.

### Reproducible = identical everywhere
**Rejected without a stated equivalence target.** Exact sameness may be impossible or irrelevant; the relevant attributes depend on what behavior/result must be preserved.

## 11. Current strengthened frame

The boundary result can now be refined:

> A technical work environment is not only a configured support/exposure boundary; it is a **realized and evolving instance of such a boundary**, whose behavior depends on the resolution of its definition plus relevant live and ambient state.

This implies at least two necessary views:
- **declarative/structural view:** what is supposed to be present/exposed;
- **operational/state view:** what is actually present/exposed now.

Neither view alone is sufficient when environment consistency matters.

## 12. Open questions carried forward

- Which capability/constraint families are first-order environment dimensions?
- What is the boundary rule for intentionally consumed remote services versus accidental ambient dependencies?
- How should access/policy/resource limits be represented as environment properties rather than merely external conditions?
- How do shared environments create interference, contention or contamination?
- Which lifecycle states matter beyond create/rebuild/delete?
- Can environment health/readiness be characterized independently of the activity using it?
- What terminology best captures the technical phenomenon without implying broad ergonomic surroundings?

## 13. Epistemic status

**Strong topic result:** definition/profile, resolved composition, realized state and ambient dependencies cannot safely be collapsed when reproducibility/consistency matters.

**Strong topic result:** isolation, persistence, immutability and reproducibility are distinct properties.

**Strong topic result:** configuration mechanisms do not by themselves establish complete environmental closure.

**Cross-source synthesis:** reproducibility should be stated relative to protected equivalence/behavior rather than as an unqualified binary label.

**Not established:** one universal minimum environment specification or one universal reproducibility mechanism.
