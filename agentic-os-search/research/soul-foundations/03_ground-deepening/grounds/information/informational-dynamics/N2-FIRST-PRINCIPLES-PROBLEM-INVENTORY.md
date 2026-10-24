# Informational Dynamics / Formation–Transformation — N2 First-Principles Problem Inventory

**Status:** COMPLETE; problem-family inventory, not child hierarchy  
**Date:** 2026-09-05  
**Dependency:** `N1-NODE-COHERENCE-ATTACK.md`

## 1. Method

N2 asks:

> If informational states can be formed, derived, selected, exposed, revised, invalidated or otherwise changed, which distinct failure/semantic questions must be answerable before importing familiar lifecycle or pipeline labels?

Each region below is a **problem family** only. N3 must later classify it as immediate child, cross-cutting transition dimension, relation, lifecycle specialization or neighboring-ground issue.

## 2. D1 — Source / phenomenon → informational formation

Core problem:

> How did a candidate phenomenon, source act, signal or source resource become a newly instantiated informational state?

Failure cases:

- only a biased/partial sample is captured;
- missing observation is treated as negative evidence;
- assertion and observation are conflated;
- source eligibility is wrong;
- capture procedure modifies the phenomenon;
- a copied state is mislabeled as primary/direct observation;
- a procedure result is detached from the procedure/source that produced it.

Questions:

- what triggered formation?
- source phenomenon, Actor assertion, imported resource, generated simulation or other origin?
- what was observable/detectable?
- what selection/sampling occurred before the result existed?
- does the transition create new content or only instantiate/expose existing content?

## 3. D2 — Encoding / interpretation / representation formation

Core problem:

> How did input signal/source material become a particular representational form and interpreted content?

Failure cases:

- parsing/transcription changes meaning;
- units/schema/vocabulary are misbound;
- format conversion drops qualifiers;
- syntactic success is mistaken for semantic fidelity;
- language/encoding conversion introduces ambiguity;
- machine-readable form cannot express required distinction.

Questions:

- which mapping linked source/signals to representation?
- was interpretation explicit or implicit?
- what semantics were preserved/lost?
- is the output same content in new form or a materially new state?

Potential status: could merge with D1 for formation and D3 for transformation; child status unresolved.

## 4. D3 — Derivation / computation / inference

Core problem:

> How did one or more informational states contribute to a derived informational state?

Failure cases:

- computation is wrong despite correct inputs;
- inference is invalid or assumption-dependent;
- derivation loses source binding;
- circular dependence is mistaken for independent support;
- simulated/predicted output is presented as observed;
- derived result cannot be reproduced because procedure/configuration is missing.

Questions:

- which inputs mattered?
- what rule/model/procedure produced output?
- deterministic, stochastic, heuristic, inferential?
- what assumptions/parameters mediate derivation?
- which information was newly introduced versus propagated?

## 5. D4 — Semantic transformation / normalization / translation

Core problem:

> When information changes form or representation, what semantic effect did the transformation have?

Failure cases:

- normalization merges distinct values;
- translation changes modality/claim strength;
- migration changes identity or applicability;
- schema mapping silently reinterprets fields;
- copy is mistaken for independent information;
- representation-preserving operation is mistaken for content-preserving operation.

Questions:

- preserve, add, remove, reinterpret, re-scope or rebind?
- same informational state/equivalent representation or new state?
- reversible/reconstructable?
- what provenance must survive?

## 6. D5 — Aggregation / projection / compression

Core problem:

> How are multiple states combined or a richer state reduced to a partial/summary view without hiding load-bearing distinctions?

Failure cases:

- summary strengthens/weakens source claim;
- aggregation hides minority/conflicting states;
- averaging destroys uncertainty/distribution shape;
- projection drops time/scope/source qualifiers;
- one aggregate is treated as evidence of each constituent;
- compression removes the exception that changes the decision.

Questions:

- many→one, one→partial, one→many?
- what was intentionally omitted?
- can important lost detail be recovered?
- what coverage/fidelity contract applies?

Potential status: strong D3/D4 specialization, but decision-critical enough to retain for N3 testing.

## 7. D6 — Selection / retrieval / ranking / context formation

Core problem:

> Which available informational states become exposed for a current use, and what does the selection omit or distort?

Failure cases:

- required state exists but is not selected;
- wrong version/rank dominates context;
- retrieval miss is treated as source absence;
- query rewrite drops a qualifier;
- ranking hides adverse evidence;
- context assembly includes stale or unauthorized material;
- selected view is mistaken for complete source universe.

Questions:

- what source universe was eligible?
- selected relative to which Work/Actor/query/purpose?
- exact lookup, semantic retrieval, filtering, ranking, projection?
- what coverage/freshness/as-of guarantee exists?
- does selection create a new informational state/view?

## 8. D7 — Communication / publication / exposure / receipt

Core problem:

> How does information become available across a sender/system/consumer boundary, and what does successful delivery establish?

Failure cases:

- transmitted representation arrives corrupted;
- delivery occurs but receiver cannot interpret it;
- publication exposes wrong version;
- message is visible but not noticed/selected;
- source/attribution is lost in relaying;
- successful transmission is mistaken for shared understanding/agreement.

Questions:

- what changed: location, visibility, holder, audience, representation or interpretation?
- copy vs move vs reference/exposure?
- sender and originator same?
- receipt confirmed at bits, representation, interpretation or acknowledgment level?

Potential status: partly Dynamics, partly Actors/Environment relation; child status unresolved.

## 9. D8 — Revision / correction / supersession / retraction / invalidation

Core problem:

> How does an existing informational state or its standing change after new information, error discovery or lifecycle decision?

Failure cases:

- corrected state exists but stale version remains designated current;
- retraction deletes history rather than withdrawing reliance;
- supersession is mistaken for factual falsity;
- correction silently rewrites prior state;
- effective/applicable time and system-known time are conflated;
- invalidation vocabulary is imported with wrong semantics.

Questions:

- content changed, standing changed, applicability changed, visibility changed or identity/version changed?
- what remains historically recoverable?
- is old state false, obsolete, retracted, superseded, unavailable or merely non-current?
- which transition has authority to change standing?

## 10. D9 — Conflict detection / reconciliation / merge

Core problem:

> What informational transition occurs when multiple overlapping states disagree or must be jointly maintained?

Failure cases:

- conflict is hidden by overwrite/last-write-wins;
- apparent contradiction is actually time/scope/perspective difference;
- merge invents consensus;
- reconciliation discards minority hypothesis;
- same source is double-counted through derived copies;
- unresolved conflict is silently converted into one accepted state.

Questions:

- detect vs resolve vs preserve plurality?
- what rule changes standing?
- what does merge preserve/lose?
- does reconciliation require Work/Actor authority outside Dynamics?

Potential status: transformation/revision specialization plus cross-state condition.

## 11. D10 — Propagation / synchronization / downstream update

Core problem:

> When a source or standing changes, which dependent representations/views/caches/contexts become correspondingly updated or invalidated?

Failure cases:

- correction exists but is not propagated;
- derived index/cache remains stale;
- subscriber misses an update;
- downstream view updates out of order;
- old copy remains apparently authoritative;
- partial propagation creates inconsistent views across consumers.

Questions:

- which dependencies should receive change?
- push, pull, rebuild, invalidate, recompute, re-retrieve?
- ordering/idempotence matters?
- what lag/freshness is acceptable?

Potential status: cross-cutting dynamic relation over derivation/exposure/persistence rather than a clean child.

## 12. D11 — Persistence / recall / forgetting / disposition transitions

Core problem:

> What changes when information must survive, be recalled, cease to be used, or be disposed?

Failure cases:

- write succeeds but later retrieval cannot reconstruct meaning;
- retained state remains available after its permitted/useful horizon;
- forget/delete hides active view but leaves dependent copies;
- disposal destroys required history;
- memory update overwrites provenance/standing;
- persistent source is correct but wrong state is recalled.

Questions:

- write/update/read/forget/dispose are generic Dynamics or persistence-profile operations?
- what transition changes existence vs availability vs role/standing?
- which persistent obligations come from Records rather than generic Information?

Current hypothesis: important specialization/profile crossing multiple Dynamics regions, not immediate child by default.

## 13. Cross-cutting transition dimensions after N2

The inventory repeatedly depends on dimensions that do **not** look like clean child branches:

- trigger/origin;
- input/output cardinality;
- semantic effect: preserve/add/remove/weaken/strengthen/reinterpret/re-scope;
- identity/version effect;
- standing/applicability effect;
- visibility/availability effect;
- lineage/provenance;
- ordering/time/effective-vs-known time;
- determinism/reproducibility;
- reversibility/reconstructability;
- latency/freshness/propagation lag;
- actor/source/authority relation;
- consumer/use relative selection.

## 14. Candidate transition topology

A recurring topology is:

```text
phenomenon / source / assertion
        ↓ formation
informational state(s)
        ↓ derivation / transformation / revision
informational state(s)
        ↓ selection / exposure / communication
consumer-visible / working informational state
```

But real systems loop:

- a context can cause new derivation;
- a derived state can trigger retrieval;
- a correction can invalidate multiple views;
- a communicated state can become a new source;
- persistence operations can occur at every stage.

Therefore topology is a clustering aid, **not a universal pipeline sequence**.

## 15. N2 verdict

Eleven load-bearing problem families are now visible. They do not support an eleven-child hierarchy.

The strongest compression pressure is toward three broad regions:

1. **formation / acquisition** — how an informational state first becomes instantiated/available from a phenomenon, assertion or source;
2. **derivation / transformation / revision** — how existing states contribute to new or changed states/standing;
3. **selection / exposure / distribution** — how existing states become available/visible to a use/consumer without necessarily changing source content.

Encoding, aggregation, conflict resolution, propagation and persistence appear likely to cross or specialize these regions.

N3 must test this three-region compression against rival two-, four- and no-split decompositions.
