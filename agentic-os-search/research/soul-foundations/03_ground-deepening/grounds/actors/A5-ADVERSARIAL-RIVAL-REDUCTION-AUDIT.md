# Actors Ground Audit — A5 Adversarial Rival / Reduction Audit

**Status:** COMPLETE — SAME-MODEL ADVERSARIAL REVIEW / NOT INDEPENDENT  
**Date:** 2026-09-05

## 1. Purpose

Attack the emerging no-gap result by trying to eliminate, replace, split or simplify the Actors ground.

A5 is same-model adversarial review. It does not become independent verification merely because the framing is hostile.

---

# 2. Rival R1 — Actors is only a residual of Environment + Information + Work

## Claim

Perhaps there is no independent Actors ground:

- capability can be Environment;
- identity/role can be Information records;
- participation can be Work assignment;
- authority/obligation can be control policy;
- accountability can be audit information.

## Reduction test

Hold neighboring facts roughly fixed while varying Actor-side relations.

### Case A — same Work, same Environment, different authority

The same deployment Work can exist against the same production environment and same artifact/evidence while the authorized release manager changes.

The Work, target and evidence need not change for the authority-bearing relation to change.

### Case B — same role record, different actual standing

The same stale directory/token can remain while actual delegation has been revoked.

Information can remain fixed while Actor standing changes.

### Case C — same technical capability, different obligation

Two equally competent engineers with identical access can differ because only one is on duty/on call or holds a fiduciary/organizational obligation.

Environment capability can remain fixed while obligation differs.

### Case D — same action, different principal/attribution

The same operational action can be performed on own behalf, under delegation, through impersonation, or as an automated action institutionally attributed to another bearer.

Observed Work/Environment effect does not determine the Actor relation.

## Verdict

**Reduction fails.**

Actors remains irreducible as a problem ground because bearer/standing/participation/normative/representation/attribution relations can vary independently of neighboring ground state.

---

# 3. Rival R2 — Replace Actors with `Parties / Stakeholders / Standing`

## Motivation

The old `Actor` word can imply active doers, while the corpus needs beneficiaries, affected parties, rights holders, principals, forums and accountable parties who may not perform an action.

## Strength

This rival correctly exposes a naming danger:

> `Actors` must not be read as `only entities that take positive actions`.

## Failure as a full replacement

`Parties/Stakeholders` under-signals:

- operational agency;
- decision participation;
- delegation/representation;
- capability/competence;
- shared/corporate agency;
- non-human operational participation;
- responsibility/attribution.

`Standing` alone also under-signals episode-specific participation and action/omission.

## Verdict

No replacement is clearly superior at current Foundation level.

Current label remains usable **only with its qualifier and warning**:

> `Actors / Agency–Participation–Authority` names a broad relational problem region, not a class of active doer entities.

Orientation should explicitly include non-performing semantically relevant parties/stake positions.

---

# 4. Rival R3 — Capability belongs entirely to Environment

## Claim

If capability depends on tools/resources/runtime, perhaps Actor capability is redundant.

## Counterexample

Two bearers in the same environment can differ in:

- skill;
- competence;
- qualification;
- learned/model capability;
- decision ability;
- domain knowledge.

Conversely, the same bearer capability can remain while Environment access/resources change.

## Verdict

**Reduction fails.**

Keep:

```text
bearer capability/competence
!= realized Environment affordance/access
!= situated actionability
```

Detailed capability taxonomies remain residual/domain-specific.

---

# 5. Rival R4 — Authority/obligation belong entirely to later control/composition

## Claim

Authority is relational and policy-dependent, so perhaps it should be removed from Actors and studied only in a later control layer.

## Test

A control system must still answer Actor-semantic questions such as:

- who/what is principal;
- who is delegate;
- whose role/office carries authority;
- who is obligated;
- who can authorize whom;
- who is accountable to which forum;
- whether the same bearer acts for self or another.

These are not supplied by the existence of a policy or enforcement mechanism.

## Verdict

**Reduction fails.**

Authority/obligation relations are legitimate Actors-local semantics, while their policy sources, Work gates, evidence and Environment enforcement are cross-ground composition.

---

# 6. Rival R5 — Attribution/accountability are only Information/audit problems

## Claim

If attribution and accountability are known through logs/records, perhaps they are informational states rather than Actors relations.

## Test

A log can state `A approved`, but:

- A may have been impersonated;
- the approval may be outside authority scope;
- a different principal may be institutionally represented;
- accountability may attach to a forum/office despite operational action by another system;
- causal contribution and legal attribution can diverge.

## Verdict

**Reduction fails.**

Information can represent/evidence attribution/accountability, but does not replace the underlying typed relation/standing.

---

# 7. Rival R6 — Non-human agency requires a separate top-level ground

## Claim

Highly autonomous AI/software agents may be so different from humans/organizations that one Actors ground is misleading.

## Test

The same analytical questions remain useful across human, organizational and software bearers:

- what identity/continuity matters;
- what role is active;
- how does it participate;
- what can it do;
- what may/must it do;
- on whose behalf does it act;
- how is action attributed;
- who is responsible/accountable;
- is a collective/joint system the relevant analysis unit?

What differs is the answer and normative regime, not the first-order question family.

## Verdict

**Separate non-human ground not justified.**

Operational non-human agency remains a strong counterexample preventing human-centric collapse.

---

# 8. Rival R7 — One simpler frame: `bearer + typed relations`

## Claim

Maybe the long multi-anchor map can collapse to:

```text
bearer
+ typed relations
+ context/time
```

## Strength

This is a useful high-level compression and is close to the current research conclusion.

## Limitation

It is too lossy if interpreted as one entity-centric graph because some load-bearing loci are not safely reduced to bearer-to-bearer relations:

- situation/episode;
- possible/expected conduct for omissions;
- role/office positions that persist independently of occupants;
- Work participation positions;
- collective/shared/corporate organization;
- accountability forum/process;
- delegation history/scope.

## Verdict

Useful orientation, not a replacement for the preserved distinctions.

---

# 9. Rival R8 — `episode + participants` eliminates persistent Actors

## Strength

Episode-centered analysis cleanly separates performer, decider, authorizer, principal and affected parties.

## Fatal counterexamples

- standing authority before any episode;
- ongoing role/office obligations;
- identity continuity across episodes;
- delegation/revocation state;
- omission/non-action where the relevant positive event never occurs;
- corporate continuity through changing participants.

## Verdict

**Rejected**, consistent with the original vertical's late omission falsifier.

The situation/episode anchor is necessary but not sufficient.

---

# 10. Rival R9 — `principal-agent / delegation network` as universal frame

## Strength

Excellent for representation, authority and transitive-agent cases.

## Failure

Does not naturally exhaust:

- peer/shared agency;
- non-delegated cooperation;
- beneficiaries/affected parties;
- causal contribution;
- competence without representation;
- accountability forums;
- organizations acting through internal procedures;
- non-human joint systems with no principal-agent semantics.

## Verdict

Important relation family, not universal replacement.

---

# 11. Rival R10 — Promote a clean immediate-child hierarchy

Several candidate decompositions were attacked.

## Candidate A — `Actor Standing` / `Actor Participation`

### Appeal

Standing covers identity/role/authority/obligation; participation covers episode action/decision.

### Failure

- capability can be standing or episode-conditioned;
- delegation is standing + episode + scope/history;
- omission requires standing duty/capability + episode/non-event;
- responsibility/accountability can be standing or retrospective episode relations;
- collective agency spans persistent organization and episode participation.

**Reject as universal sibling split.**

---

## Candidate B — `Bearer & Identity` / `Authority & Representation` / `Participation & Agency` / `Attribution & Responsibility`

### Appeal

Matches several topic clusters.

### Failure

The clusters overlap structurally:

- role belongs with bearer identity and authority;
- delegation couples representation, authority and participation;
- accountability couples bearer/role, past participation and forum relation;
- collective/non-human agency cuts across every branch;
- context/time qualifies all four.

Promoting this tree would turn cross-cutting analytical dimensions into falsely disjoint populations.

**Reject.**

---

## Candidate C — `Individual` / `Collective` / `Non-human`

### Failure

These are bearer/analysis-level categories, not independent semantic problem families. The same authority/participation/attribution questions recur across them.

**Reject.**

---

## Candidate D — `Operational Agency` / `Normative Standing`

### Appeal

Captures action/capability vs permission/obligation/accountability.

### Failure

- representation/delegation links both;
- institutional attribution links operational action to normative bearer;
- omission combines capability/action possibility with duty;
- shared/corporate agency involves both operational and institutional structure.

**Reject as universal split.**

---

## Candidate E — `Identity/Standing State` / `Agency/Participation Dynamics`

### Appeal

Mirrors State/Dynamics thinking and could distinguish persistent standing from episode change.

### Failure

It does not produce stable sibling problem regions:

- role activation is both standing and episode dynamics;
- authority delegation/revocation is state plus transition;
- responsibility can arise from episode history but persist as standing;
- collective bearer identity is generated/maintained through organizational processes;
- omission is defined partly by non-occurrence and standing expectation.

The distinction is useful as a lens but not a justified immediate-child hierarchy.

**Reject for current depth.**

---

# 12. Rival R11 — `Actors` is too broad to be coherent

## Attack

The region includes identity, capability, authority, participation, delegation, omission, accountability, collective agency and non-human systems. Perhaps this is only a grab-bag of `who-related things`.

## Coherence test

A common protected question remains:

> **Which bearers/positions/parties are implicated in a situation, in what capacity and standing, through which agency/participation/representation relations, and how are action/non-action, authority/obligation and attribution/responsibility distributed across them?**

This question has stable failure modes that the neighboring grounds cannot answer alone:

- identity-role collapse;
- capability-authority collapse;
- performer-authorizer collapse;
- delegate-principal collapse;
- action-omission blindness;
- causal-accountability collapse;
- aggregate-group-agent collapse;
- operational-AI/personhood collapse.

## Verdict

Actors remains a coherent bounded problem ground despite being multidimensional.

---

# 13. Reopen test for effective/transitive authority

A5 specifically tried to revive H4 as a missing family.

Result:

- direct authority remains Actor-side;
- delegated authority remains Actor-side;
- reachable effect power is a path property;
- whether a path exists is partly Environment;
- why it is traversed is partly Work/orchestration;
- whether policy legitimizes it requires authority/control composition;
- evidence of the path is Information.

No stable new Actor-only primitive appears.

**H4 closed as a first-order gap; retained as a high-priority later composition/control relation.**

---

# 14. Naming judgment

Current label:

> **Actors / Agency–Participation–Authority**

A5 finds no sufficiently superior replacement.

However the short word `Actors` must carry an explicit warning:

- not only active doers;
- not one Actor primitive;
- includes non-performing relevant parties/positions when agency, standing, representation or attribution makes them material.

Potential alternative labels such as `Agency / Participation / Standing` may be worth reconsidering during top-level adequacy/synthesis, but renaming now is not required by a structural falsifier.

---

# 15. A5 conclusion

The no-gap result survives adversarial reduction.

No rival successfully:

- eliminates Actors into Environment/Information/Work;
- reduces all semantics to one bearer/role/event/delegation primitive;
- justifies a separate non-human ground;
- forces a broader Parties/Stakeholders ground;
- produces a stable universal immediate-child hierarchy.

Strongest structural result:

```text
Actors / Agency–Participation–Authority
    ← coherent Foundation problem ground
    ← rich relational / multi-anchor internal map
    ← no stable universal immediate-child hierarchy promoted
```

This is a bounded-leaf judgment at the current Foundation depth, not a claim that Actors concepts are shallow.

## Verification limitation

A5 is same-model adversarial review and **not independent verification**.

A6 should close only as bounded sufficiency and preserve reopen triggers.
