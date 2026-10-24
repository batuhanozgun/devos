# Information / Representation State — N4 Boundary and Anti-Collapse Tests

**Status:** N4 COMPLETE; N3 two-child split survives boundary attack  
**Date:** 2026-09-04  
**Dependency:** `N3-IMMEDIATE-CHILD-DISCOVERY.md`

## 1. Purpose

N4 tests whether the leading N3 structure steals semantics from Environment, Work, Actors or Records, or collapses under role-switching cases.

Leading structure under attack:

```text
Information / Representation [proposed parent refinement]
    ├─ Informational State / Representational Constitution
    └─ Informational Dynamics / Formation–Transformation

Records / Persistent Information
    ↳ persistence specialization/profile; not an immediate peer child
```

No architecture, ontology class, schema or implementation inference is permitted.

---

# 2. Environment / actual reality boundary

## Case A — sensor measurement

Scenario:

- actual room temperature exists;
- a sensor/procedure measures it;
- a numeric result with uncertainty is produced;
- the result may later be stored.

Routing:

```text
actual temperature / realized physical condition → Environment
measurement / acquisition process               → Informational Dynamics
measurement result / represented value          → Informational State
uncertainty / freshness / source                 → cross-cutting informational dimensions
persistence of result/history                    → Records specialization when activated
```

### Anti-collapse result

- correct measurement procedure does not guarantee actual truth;
- actual state can remain fixed while informational result changes;
- information can remain stale while actual Environment changes;
- persistent preservation can be correct while represented state is no longer current.

**Boundary survives.**

---

# 3. Work boundary

## Case B — plan/status/commitment representations

A Work item can be represented by:

- a planned status;
- an assertion that execution is complete;
- evidence supporting verification;
- a summary/dashboard view.

But Work itself includes selection/commitment/execution/verification/acceptance semantics not exhausted by those representations.

Routing:

```text
actual Work commitment/execution/acceptance → Work
representation of Work state                → Informational State
query/update/summary of that representation → Informational Dynamics
persistence/history of representation       → Records specialization when required
```

### Failure probe

A dashboard can say `done` while execution is incomplete.

Changing the dashboard does not itself complete the Work. Completing the Work does not guarantee the dashboard changed.

**Information does not absorb Work.**

---

# 4. Actors boundary

## Case C — belief, source and authority

An Actor may:

- hold a belief/model;
- assert a claim;
- be the source of a report;
- be authorised to designate a source as current.

Routing:

```text
Actor identity / role / authority / obligation → Actors
belief/claim content                            → Informational State
belief update / assertion / derivation          → Informational Dynamics
holder/source/attribution relation               → cross-ground relation with informational significance
```

### Anti-collapse result

- Actor capability/authority is not an informational state merely because it can be represented;
- an assertion does not inherit truth from the identity of its source;
- source and current holder can differ;
- a shared informational state need not be reducible to one Actor's private mental state.

**Information does not absorb Actors.**

---

# 5. Claim vs evidence vs decision

## Case D — evidence supporting a decision

A report contains a claim. A second source supports it. A decision is made using both.

Routing:

- claim content → Informational State;
- evidence relation → relation between informational state and target claim/question under a body of other information;
- support/confidence evaluation → Informational Dynamics or cross-cutting standing depending on focal question;
- decision/commitment → Work and/or Actors depending on the decision semantics and authority;
- persistent decision record → Records specialization after the decision exists.

### Result

`Evidence` and `Decision` do not need peer Information children.

The same representation can be evidence for one question and irrelevant for another. Decision force/commitment is not created merely by informational support.

**Anti-collapse survives.**

---

# 6. Source vs derived view

## Case E — source document → summary/dashboard

Routing:

- source informational content → Informational State;
- summarisation/query/aggregation → Informational Dynamics;
- summary/dashboard output → new or derived Informational State;
- provenance/coverage/freshness → cross-cutting relations/dimensions;
- persistence of either source/view → Records specialization when required.

### Failure probe

A derived view can be internally well-formed but:

- omit decisive source material;
- be stale;
- overstate a source claim;
- lose exact source binding.

This requires both state and dynamics semantics; neither alone is sufficient.

**Two-child split strengthened.**

---

# 7. Context / selected working set

## Case F — LLM/agent working context

Available repository/web/memory information is larger than what a model sees at one inference step.

Routing:

- eligible source representations → Informational State;
- retrieval/filter/ranking/compression/context assembly → Informational Dynamics;
- resulting model-visible working set/view → Informational State;
- relevance/coverage/freshness/authority → use-relative cross-cutting dimensions/relations;
- task/goal relative to which context matters → Work;
- permissions limiting eligible sources → Actors/policy/control relation;
- persisted memory/source-of-truth → Records/persistence specialization where activated.

### Result

`Context` is not a stable peer child. It is a **selected/projected informational state produced by context-formation dynamics relative to a use**.

This conclusion is consistent with the separate Context/Memory/Harness study, which distinguishes persistence, memory read/management and model-visible context without making them one ontology hierarchy.

---

# 8. Shared vs Actor-local information

## Case G — local belief and shared model

The same proposition may be:

- believed by Actor A;
- disputed by Actor B;
- stored in a shared system model;
- exposed to neither Actor at a particular moment.

### Result

Holder/sharedness is a relation/dimension on informational state. It does not require separate local-vs-shared child branches.

Information remains distinct from Actor identity/participation.

---

# 9. Transient vs persistent representation

## Case H — transient observation becomes retained evidence

An observation result exists briefly in working memory, then is deliberately stored for future audit.

What changes when persistence is activated?

- preservation horizon;
- identity/version/representation binding;
- provenance survivability;
- history/standing reconstruction;
- retrieval guarantees;
- retention/disposition.

What does **not** become a new peer kind?

- the underlying referent/content suddenly does not stop being informational state;
- later corrections/derivations do not stop being dynamics.

### Result

Persistence is a **semantically major specialization condition** with deep obligations, but it overlays both State and Dynamics rather than partitioning them.

This is the strongest N4 reason not to promote Records as an immediate peer child.

---

# 10. Communication / exposure boundary

## Case I — message delivery

A sender communicates a representation to a receiver.

Routing:

- message/content → Informational State;
- encoding/transmission/exposure/receipt → Informational Dynamics;
- network/channel realised conditions → Environment where focal;
- sender/receiver identities and permissions → Actors;
- shared understanding → not guaranteed merely by delivery.

### Result

Accessibility/exposure is not a standalone child. It is partly a dynamic relation/process and partly a state/availability condition, with cross-ground dependencies.

---

# 11. Normative information / policy / goal representation

## Case J — policy text and obligation

A policy document can represent an obligation or rule.

But:

- the document/content is Informational State;
- its creation/revision/publication is Informational Dynamics and/or Work;
- whether an Actor actually has a binding authority/obligation is Actors/policy/control semantics;
- whether Work is required is Work/control semantics.

### Result

Representing a norm does not make normative force itself an Information-local state.

This prevents the ground from swallowing goals, requirements and authority merely because they are expressed in text/data.

---

# 12. Boundary table

| Focal question | Primary route | Information role |
|---|---|---|
| What is actually true/realised in domain conditions? | Environment | may represent/observe/model it |
| What Work is selected, committed, executed, verified or accepted? | Work | may represent Work state/evidence |
| Who/what bears identity, capability, role, authority or obligation? | Actors | may represent/attribute those facts |
| What informational content/state exists and what does it mean/refer to? | Informational State | primary |
| How was information acquired/generated/changed/selected/communicated? | Informational Dynamics | primary |
| What must survive and remain usable across time? | Records/persistence specialization | activates extra obligations across Information |
| Is a representation evidence for a claim? | cross-cutting Information relation | target/use-relative |
| Is a source authorised? | Actors/policy/control + Information attribution | authority is not truth |
| What is model-visible now? | selected Informational State | produced by context-formation Dynamics |

---

# 13. Child anti-collapse tests

## Can Informational State reduce to Dynamics?

No.

Two states may have the same derivation mechanism but different referents/content/standing. A stable representation can remain available without the generating process remaining active.

## Can Dynamics reduce to State/provenance attributes?

No.

Acquisition, derivation, revision, selection, communication and invalidation have transition semantics and failure modes that are not recovered by merely attaching `source` or `updatedAt` fields to an output.

## Can both reduce to Environment/Work/Actors?

No without repeated loss of mediated-state failure semantics already established in N1.

## Does the split require every implementation to instantiate separate objects/services?

No.

Research branch separation is not architecture separation.

---

# 14. N4 verdict

The leading N3 structure survives the required boundary cases.

```text
Information / Representation [proposed parent refinement]
    ├─ Informational State / Representational Constitution
    └─ Informational Dynamics / Formation–Transformation
```

**N4 status:**

- C1 child candidate: strengthened;
- C2 child candidate: strengthened;
- Records as immediate peer child: further weakened;
- persistence specialization/profile: strengthened;
- context/evidence/source/freshness/access as peer children: rejected at this level;
- parent remains distinct from Environment, Work and Actors under tested cases.

Proceed to N5 external and cross-domain falsifiers.
