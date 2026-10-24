# Work Environment — Finding 04: Composition, Sharedness, Isolation and Lifecycle

**Status:** current topic finding; independent vertical; not architecture  
**Date:** 2026-09-02

## 1. Result in one paragraph

Technical work environments can be **composed, nested, federated, shared and isolated in combinations that defeat simple container-style models**. A shared substrate can host many mutually isolated project environments; a single environment can itself be multi-user; one environment can provision or extend a satellite environment on external infrastructure; and several modules can have partly independent lifecycles while participating in one larger environment. Sharedness and isolation are therefore separate axes rather than opposites. Lifecycle also requires separating **definition, provisioning, active availability, suspension/stopping, resumption, reconfiguration/rebuild, migration/transfer and retirement/deletion**, because persistence of state and environment identity can behave differently across these transitions.

## 2. Composition does not imply one physical or administrative unit

VRE/TRE and science-gateway cases show at least four composition forms:

- **contained/sub-environment:** a scoped environment inside a larger environment;
- **shared-substrate isolation:** multiple logically separated environments over common infrastructure;
- **federated/mediated composition:** one environment exposes or governs capabilities supplied by externally operated infrastructure;
- **modular composition:** environment modules/services have partially independent deployment and lifecycle while contributing to a larger working setting.

NIST's SEE reference model supports sub-environments and overlapping resource views. D4Science deploys multiple VRE managers/instances across nodes and gives communities different feature sets. Recent TRE work shows secure environments can extend controlled boundaries to external compute through provisioned satellite environments.

Therefore an environment cannot safely be identified with one host, tenant, process, project, provider or administrative owner.

## 3. Sharedness and isolation are independent dimensions

ERICA supports many isolated project spaces within one instance. Charité describes isolated project workspaces on shared multi-tenant infrastructure. TRE studies also report both per-user isolated VMs and shared multi-user systems.

This supports several combinations:

- shared substrate + isolated environment;
- shared environment + isolated user/project scopes;
- dedicated substrate + multi-user environment;
- dedicated environment + single user;
- shared services + private state;
- shared state + role-restricted operations.

Thus:

> **shared ≠ unisolated** and **isolated ≠ dedicated physical infrastructure**.

Isolation itself has multiple possible boundaries: network, filesystem/data, process/runtime, identity/permission, namespace, resource quota, secrets, or administrative policy. No one boundary is universally sufficient.

## 4. Multi-tenancy is an implementation relation, not environment identity

A platform can be multi-tenant while exposing distinct environments to different groups. Conversely, one environment can deliberately be shared by many users.

Therefore:

- tenant identity ≠ necessarily environment identity;
- project identity ≠ necessarily environment identity;
- underlying infrastructure instance ≠ necessarily environment identity;
- user session ≠ necessarily environment identity.

These identities may align in a particular system, but the research should not collapse them in the general concept.

## 5. Composition can preserve or change environment identity at different levels

Consider provider/resource substitution. If a remote compute backend changes while the exposed capability/interface/constraint contract remains equivalent, the **support-profile identity** may remain stable even though infrastructure/component identity changed. If the substitution changes limits, behavior, interfaces or security boundaries, behavioral/capability equivalence may fail.

Similarly, adding a new sub-environment can:
- extend a larger environment without replacing it;
- create a distinct environment under the same profile family;
- change the effective support surface enough to constitute a new profile.

No universal threshold follows from current evidence. Identity remains relative to the protected distinctions from Finding 01.

## 6. Environment lifecycle is not one scalar status

Concrete systems distinguish materially different transitions. Codespaces can be created, connected/disconnected, stopped, restarted, rebuilt and deleted. Vagrant distinguishes suspend/resume from ordinary stop/start and provisioning. VRE literature distinguishes establishment/prototype/development/operation/transfer/dismantling at a larger service level.

A general environment lifecycle therefore needs more than `active/inactive` when the distinction matters.

Candidate transition families include:

1. **define/profile** — establish intended structure/configuration;
2. **resolve/provision/create** — allocate substrate and realize dependencies;
3. **configure/initialize** — make the instance ready for use;
4. **available/active** — environment can provide its support surface;
5. **suspend/stop** — active execution ceases while some state may persist;
6. **resume/restart** — reactivate an existing retained instance/state;
7. **reconfigure/mutate** — change a live or retained instance;
8. **rebuild/reprovision** — replace/recreate some or all realized environment from a definition;
9. **snapshot/restore/migrate/transfer** — preserve or move selected state/profile;
10. **retire/delete/teardown** — end availability and release some or all resources/state.

This is a research synthesis; no claim is made that every environment implements every transition.

## 7. Running state, availability, persistence and retention do not collapse

Codespaces are a clear counterexample:
- closing a browser tab does not stop the remote environment;
- stopping ends running processes but preserves saved work;
- rebuilding can preserve workspace state while replacing container state;
- deletion removes the environment and unpushed local work;
- inactivity can lead to automatic deletion after a retention period.

Therefore keep separate when relevant:

- **session connectivity** — is a participant connected?
- **execution/running state** — are environment processes/resources active?
- **service availability** — can the environment provide required capabilities?
- **state persistence** — which state survives stop/rebuild?
- **retention** — how long is retained state kept?
- **instance existence** — does the environment instance still exist?

An environment can exist while stopped; be running while inaccessible to a particular user; retain state while not available; or be rebuilt into a new realization while preserving selected persistent state.

## 8. Ephemeral and durable environments are both valid

Recent TRE work includes ephemeral satellite environments provisioned on external infrastructure and torn down after use. Development-container/codespace workflows also support short-lived disposable environments, while VREs may operate for years.

Thus ephemerality is not evidence that something is merely a session rather than an environment. It is a lifecycle/retention property.

Likewise durability does not imply immutability: long-lived environments can be patched, expanded, migrated or reconfigured.

## 9. Shared environments introduce environment-specific interference risks

When infrastructure/resources/state are shared, one environment or user can affect another through:

- resource contention;
- noisy-neighbor performance effects;
- namespace/state collisions;
- accidental data/state leakage;
- shared-cache contamination;
- conflicting version/configuration changes;
- quota exhaustion;
- provider-wide outages;
- administrative changes propagated across tenants/instances.

Isolation mechanisms reduce selected interference channels but do not make shared substrate irrelevant. The relevant question is which dependencies/resources remain coupled.

## 10. Environment composition needs at least three boundaries

Current evidence supports distinguishing:

- **support boundary:** capabilities/services/resources presented as one working setting;
- **isolation boundary:** what state/actions/effects are separated from other environments/users;
- **administrative/provider boundary:** who operates or controls underlying components/resources.

These can diverge. A service may lie outside the provider boundary of the environment operator but inside the support boundary; two project environments may share one provider boundary but have separate isolation boundaries.

This three-boundary distinction is a synthesis and should be tested further.

## 11. Rival reductions tested

### One environment = one machine/container/VM
**Rejected.** Distributed, multi-node, federated and shared-substrate environments contradict it.

### One project/tenant = one environment
**Rejected as universal.** A project can use several environments; a multi-user environment can serve several projects/scopes.

### Shared = not isolated
**Rejected.** Shared multi-tenant substrate with isolated project environments is established practice.

### Stopped = environment no longer exists
**Rejected.** Environments can retain instance/state while execution is stopped.

### Rebuild = same as restart
**Rejected.** Rebuild/reprovision can replace environment components and clear selected state while restart resumes an existing realization.

### Ephemeral = not an environment
**Rejected.** Controlled disposable environments remain environments during their bounded lifecycle.

## 12. Strengthened current frame

The vertical now supports treating a technical work environment as having separable dimensions of:

- support composition/boundary;
- isolation/sharedness;
- provider/administrative topology;
- instance/profile identity;
- lifecycle state/transitions;
- persistence/retention behavior.

None of these is a mandatory class hierarchy. They are anti-collapse dimensions needed when differences materially change the environment's effective support surface or continuity.

## 13. Open questions carried forward

- How should environment health/readiness/availability be distinguished from mere existence/running state?
- Which observations are necessary to know the environment's actual state?
- How do partial failures propagate through composed/federated environments?
- When is provider substitution transparent versus an environment change?
- Which environment failures are independent of the work performed within it?
- Are secrets/credentials/environment variables configuration, state, resources, or interface bindings depending on use?
- Does a better final term than `Work Environment` emerge after failure/completeness tests?

## 14. Epistemic status

**Supported topic result:** environments may be nested, distributed, federated and multi-instance.

**Supported topic result:** shared substrate and environmental isolation can coexist.

**Supported topic result:** stop/suspend/rebuild/delete/persistence are not interchangeable lifecycle semantics.

**Cross-source synthesis:** support, isolation and administrative/provider boundaries should be separable.

**Not established:** universal lifecycle state machine, universal isolation boundary, or final composition ontology.
