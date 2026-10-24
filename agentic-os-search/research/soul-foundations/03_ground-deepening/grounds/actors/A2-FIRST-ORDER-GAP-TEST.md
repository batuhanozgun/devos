# Actors Ground Audit — A2 First-Order Omission / Gap Test

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Question

After applying the four-ground boundary, does a common Actors-local phenomenon remain that cannot be preserved through the prior multi-anchor distinctions without systematic information loss?

A new family must be more than a useful term or domain-specific relation. It must remain Actors-local, first-order and stable across materially different cases.

---

## 2. Baseline being attacked

The prior Actors corpus is intentionally not a child taxonomy. It preserves separable anchors/relations around:

- bearer identity/continuity;
- role/office/position/membership;
- context/time/situation/episode;
- participation/decision positions;
- capability/competence;
- permission/authority/power/obligation;
- representation/delegation/impersonation;
- action/decision/refraining/omission;
- attribution;
- responsibility/accountability;
- shared/collective/corporate agency;
- non-human operational participation vs normative/legal attribution.

A2 asks whether anything materially different is missing.

---

## 3. Effective / transitive authority

### Challenge

Modern agent systems can create an effect path where A lacks direct privileged capability but can invoke B, and B can invoke a privileged tool.

Does this require a new Actor-local `effective authority` family?

### Decomposition

The case contains several independently variable facts:

- A's own authority/permission;
- A's capability to invoke B;
- A→B delegation/command relation;
- B's authority and capability;
- Environment reachability, credentials and enforcement;
- policy legitimacy of chaining;
- Work/orchestration path;
- attribution/accountability for the resulting effect.

### Result

A new Actors-local family is **not required**.

The important new anti-collapse is:

```text
effective ability to cause an effect through a path
!= authority to cause that effect
```

The prior Actors corpus already covers the Actor-side parts through relational/combinatorial authority, delegation chains, performer/principal separation and typed attribution. The path's realized feasibility crosses Environment and Work.

**Disposition:** high-value cross-ground derived relation / later control concern; not a new first-order Actors family.

---

## 4. Policy-enforced technical agency vs institutional authority

### Challenge

Could `hard permissions` or sandbox rules be a new form of Actors authority distinct from institutional authority?

### Result

No.

Technical enforcement is evidence about what the runtime permits/blocks. It can implement policy, but:

- a mechanically allowed action can be institutionally unauthorized;
- an institutionally authorized action can be mechanically blocked;
- an instruction can request restraint without enforcing it;
- permission enforcement may be misconfigured or stale.

This requires separation, not a new Actor family.

**Disposition:** Actors authority/permission + Environment enforcement + Information policy/config representation.

---

## 5. Epistemic authority / trust / expertise

### Challenge

`Who should we believe?` may seem different from `who is competent?`, `who is authorized?` or `who is responsible?`.

Potential distinctions include:

- expertise/competence;
- institutional mandate to certify/assert;
- source authority for a specific fact;
- reputation/trust;
- evidential reliability;
- permission to make a binding determination.

### Test

These dimensions can vary independently:

- an expert may be highly competent but not institutionally authorized to approve;
- an authorized signer may not be the strongest technical expert;
- a source may be authoritative for current policy but not factually correct;
- a trusted participant may produce weak evidence;
- an informational claim may have strong provenance without its author having decision authority.

### Result

This does expose an important **cross-ground relation cluster**, but not a new Actors-local family.

Actors contributes:

- competence/expertise;
- role/position;
- mandate/authority to assert/certify/decide;
- trust relation where attached to bearer/role.

Information contributes:

- source/provenance;
- claim content;
- evidence role;
- reliability/uncertainty/freshness.

Work contributes:

- whether a certification/review/decision task is required and completed.

**Disposition:** preserve as epistemic-role/source-authority composition; do not promote a new Actor child.

---

## 6. Affected party / beneficiary / recipient / rights holder

### Challenge

A party may be semantically central without acting, deciding or authorizing anything. Does this falsify `Actors`?

Examples:

- beneficiary of a service;
- person affected by an automated decision;
- rights holder whose consent/interest matters;
- recipient of a communication or output;
- principal protected by a fiduciary relation.

### Result

It **does falsify a literal `Actor = doer` interpretation**, but that interpretation was already rejected.

The prior corpus already treats episode relations as broader than performer roles and explicitly left affected/beneficiary positions open. The current ground label includes `Agency–Participation–Authority`, and the protected region is about bearers/parties plus typed standing/participation/attribution relations, not only positive action.

A separate top-level `Stakeholders/Parties` ground is not justified because:

- the same bearer can switch among performer, principal, beneficiary, affected party, rights holder and accountable party;
- many such positions derive meaning from Work/outcome/environment relations;
- no independent dynamics/structure family emerges that is not already a bearer + typed relation case.

**Disposition:** widen Actors orientation to explicitly include semantically relevant non-performing parties/stake positions; no new first-order family.

---

## 7. Continuing / stewardship responsibility

### Challenge

Can responsibility persist without a current action episode or bounded Work item in a way not captured by role/obligation/accountability?

Examples:

- system owner;
- data steward;
- service operator;
- fiduciary/trustee;
- accountable executive;
- on-call or standing responder.

### Result

Standing responsibility is important but maps to existing anchors:

- persistent bearer;
- role/office/position;
- standing obligation/duty;
- scope/context/time;
- accountability relation/forum;
- Work generated when conditions/triggers require action.

The key correction is temporal:

```text
standing Actor responsibility
!= current Work episode
```

**Disposition:** existing normative/role/accountability family; no new family.

---

## 8. Dynamic collective identity / changing membership

### Challenge

Organizations, teams and agent groups can change membership while actions/responsibility continue. Does this require a new first-order continuity family?

### Result

Continuity is genuinely unresolved in detail, but the problem is already recognized under bearer identity plus collective/corporate agency.

The first-order distinction needed is already present:

```text
corporate bearer continuity
!= member continuity
!= current participation set
```

Merger/succession/reorganization rules are domain-sensitive. They may require later modeling but do not expose a missing family.

**Disposition:** residual continuity rule, not new family.

---

## 9. Multi-hop delegation where capability and authority diverge

### Challenge

Suppose:

```text
Principal P → Agent A → Subagent B → Tool/System C
```

At every hop:

- represented principal may differ;
- technical capability may differ;
- permission/authority may differ;
- delegation scope may narrow or accidentally widen;
- identity may be preserved or impersonated;
- accountability may remain elsewhere.

### Result

This is a strong stress test but composes existing first-order distinctions rather than forcing another one:

- bearer/identity;
- delegation/representation/history;
- authority scope/context;
- capability;
- participation;
- attribution/accountability.

What is missing is not another Actor category but later **path-composition semantics** and control validation.

**Disposition:** relation/control composition trigger; not Actors-local gap.

---

## 10. Human-in-the-loop gates

### Challenge

Does `human approval` require a special Human Actor family?

### Result

No.

The important facts are:

- who has authority/judgment responsibility;
- what evidence they see;
- what decision/work gate they participate in;
- whether approval is advisory or mechanically enforced;
- whether the approving identity is distinct from performer/principal/accountable party.

Human status may matter for governance or law, but it does not replace the existing typed participation/authority frame.

**Disposition:** role/authority/participation case; not universal human-vs-agent taxonomy.

---

## 11. High-discretion autonomous/non-human systems

### Challenge

Modern AI agents may:

- choose tools;
- select methods;
- generate subwork;
- delegate to subagents;
- adapt based on observations;
- initiate recovery;
- influence high-impact decisions.

Does this exceed the prior `operational non-human participation` concept?

### Result

It increases the **degree and breadth of operational agency**, but not the semantic family required to analyze it.

The existing framework can ask separately:

- persistent system identity/bearer continuity;
- active role/episode participation;
- capability vs environment actionability;
- delegated/standing authority;
- decision participation;
- representation/principal relation;
- causal/provenance attribution;
- legal/institutional/moral responsibility and accountability.

No evidence supports inferring from increased operational discretion that the system automatically becomes the legal/moral/accountable bearer.

**Disposition:** stronger non-human case inside existing distinction; no new family.

---

## 12. Consent, assent, refusal and veto

### Challenge

Could consent/refusal/veto be a missing Actors family?

### Result

These are important typed participation/normative positions:

- consent can create/condition authorization or representation;
- refusal/refraining is a form of meaningful non-action/decision;
- veto is a decision/authority relation;
- assent may be required for joint/shared activity.

No independent family is forced.

**Disposition:** participation + authority/obligation + action/omission relations.

---

## 13. Communication / signaling among Actors

### Challenge

Does communication create an Actors-local family?

### Result

Communication crosses:

- Actor sender/recipient/representative roles;
- Information content/representation/exposure;
- Work coordination/notification;
- Environment channels/interfaces.

The Actor-side relation matters, but communication as a whole is composite.

**Disposition:** cross-ground relation, not Actors child.

---

## 14. Governance / supervision / oversight

### Challenge

Modern agent systems emphasize supervisor agents, policy owners, human governors and escalation. Is governance a missing Actor family?

### Result

Governance composes:

- roles/offices;
- authority/obligation;
- decision/approval participation;
- accountability/forum relations;
- Work gates/reviews;
- Information evidence/policy;
- Environment enforcement.

It is a major later composition concern, not a new first-order Actors region.

---

## 15. H9 — Is the Actors map a grab-bag?

A coherent protected question survives:

> Which bearers/positions and typed agency, participation, normative, representation and attribution relations are relevant to a situation, and how do they vary across context/time?

The map is multidimensional, but the dimensions are tied by a common problem: **who/what is related to action/non-action, authority/obligation, representation and attribution, in what standing and capacity?**

Environment cannot answer this because actual conditions/capabilities do not determine authority or responsibility.

Information cannot answer it because representations do not determine the underlying standing.

Work cannot answer it because pursuit structure/state does not determine who is authorized, obligated, represented or accountable.

**Disposition:** Actors remains coherent enough as a Foundation ground.

---

## 16. A2 gap result

| Candidate | Result |
|---|---|
| effective/transitive authority | cross-ground derived path; no new Actors family |
| technical enforcement vs institutional authority | boundary distinction; no new family |
| epistemic authority/trust/expertise | cross-ground source/role cluster; no new family |
| affected/beneficiary/rights-holder | explicit non-performing stake positions; no new family |
| stewardship/standing responsibility | role + obligation + accountability; no new family |
| dynamic collective continuity | residual identity/collective issue; no new family |
| multi-hop delegation | existing relations + future composition semantics |
| human gate | typed participation/authority; no human-special primitive |
| high-discretion AI | stronger operational agency case; existing non-collapse holds |
| consent/refusal/veto | typed participation/normative/omission relations |
| communication | composite relation |
| governance/oversight | composite relation/control concern |

## 17. A2 judgment

No material new Actors-local first-order family survives A2.

Several boundary and orientation clarifications are important:

1. `Actors` includes semantically relevant non-performing parties/positions, not only doers.
2. effective effect-reach must not be called authority by default.
3. standing responsibility must remain separable from current Work.
4. epistemic/source authority is a cross-ground composition, not one Actor property.
5. modern AI autonomy increases operational participation/discretion without collapsing normative attribution.

A3 must now use newer candidate studies as **holdouts** to try to falsify this no-gap result.
