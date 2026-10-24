# Informational Dynamics / Formation–Transformation — N4 Boundary and Anti-Collapse Tests

**Status:** COMPLETE; N3 three-child split survives required boundary attack with scope-relative routing caveat  
**Date:** 2026-09-05  
**Dependency:** `N3-IMMEDIATE-CHILD-DISCOVERY.md`

## 1. Leading structure under attack

```text
Informational Dynamics
    ├─ Informational Formation / Acquisition
    ├─ Informational Derivation / Transformation
    └─ Informational Selection / Exposure
```

The three branches are problem regions, not implementation modules or mutually exclusive API operation types.

---

# 2. Environment boundary — sensor measurement

Scenario:

- actual temperature exists;
- a sensor/procedure samples it;
- a measurement result is formed;
- a corrected/converted value may later be computed;
- a dashboard selects the value for display.

Routing:

```text
actual temperature / physical conditions       → Environment
sensor/runtime capability                      → Environment
sampling / measurement-result formation        → Formation / Acquisition
measurement result content/uncertainty          → Informational State
calibration correction / unit conversion        → Derivation / Transformation
which result/version appears on dashboard       → Selection / Exposure
dashboard view content                           → Informational State
```

Independent failures:

- biased acquisition despite correct dashboard;
- correct acquisition but wrong calibration transformation;
- correct stored value but stale/wrong version exposed.

**Result:** three failure regions remain distinct. Environment is not absorbed.

---

# 3. Actor assertion boundary

Scenario:

A user states a requirement or claim; the system captures it; another Actor later quotes or communicates it.

Routing:

- Actor identity/role/authority → Actors;
- assertion act as Work/participation when focal → Work/Actors;
- new represented assertion entering the information space → Formation / Acquisition;
- captured claim content/mode/source attribution → State;
- normalization/summarization of the assertion → Derivation / Transformation;
- exposing it to another Actor/context → Selection / Exposure.

Anti-collapse:

An authoritative Actor can make a false assertion. Correctly capturing the assertion does not make it true. Exposing it does not make it accepted.

**Result:** Dynamics does not absorb Actor authority.

---

# 4. External document retrieval — Formation vs Selection overlap test

Scenario:

An external document exists outside the current system boundary. A tool searches for it and places selected excerpts into working context.

At first glance the same operation looks like both acquisition and selection.

## Reference-relative routing

Two protected questions coexist:

1. **Formation / Acquisition question:** How did the system obtain/bind an informational representation from an external source it did not previously possess in-scope?
2. **Selection / Exposure question:** Given an eligible source universe/results, why did this document/excerpt become visible for the current use and what was omitted?

These questions can be answered independently:

- acquisition can faithfully fetch the document while ranking selects the wrong excerpt;
- ranking can correctly prefer the right URL while fetch/parser formation corrupts content;
- an already-cached exact source requires no new acquisition but still requires selection for context.

**Result:** overlap of operations does not collapse protected problem regions. The branch boundary is system/reference-frame relative and must be stated when material.

---

# 5. State-to-state derivation — LLM inference / database query

Scenario:

Available informational states are used to calculate or infer a new result.

Routing:

- input states → Informational State;
- deliberate reasoning objective/acceptance → Work when focal;
- model/query/runtime capability → Environment when focal;
- computation/inference/query transformation → Derivation / Transformation;
- output claim/view → Informational State;
- later choice to place output in context → Selection / Exposure.

Failure probe:

All required inputs can be selected correctly while inference is invalid. Conversely, a sound inference method can fail because selection omitted a decisive input.

**Result:** C2 and C3 remain non-redundant.

---

# 6. Summary / aggregation / compression

Scenario:

Many reports become one summary.

Routing:

- choosing which reports are eligible/visible → Selection / Exposure;
- aggregation/summarization/compression procedure → Derivation / Transformation;
- summary output → State.

Failure probe:

- perfect selection + distorted summary;
- faithful summary of a biased selected set;
- correct summary stored but stale summary exposed later.

**Result:** selection is not merely one step inside transformation for diagnosis purposes.

---

# 7. Correction / retraction / supersession

Scenario:

An earlier claim has a newly discovered error.

Possible chain:

```text
new observation/report                 → Formation / Acquisition
comparison/diagnosis                   → Work + C2 when informational derivation is focal
corrected claim / standing transition  → Derivation / Transformation
old/new claim states                   → State
propagation to indexes/views/contexts  → C2 recomputation + C3 exposure
who may designate correction/retract   → Actors/control
persistence/history obligations        → Records specialization
```

Why revision is not yet a fourth child:

The revision semantics are load-bearing, but they ride on C2 transformation and then require C3 propagation/exposure. The authority to revise is not Information-local.

**Result:** Revision / Standing Change remains a strong C2 specialization / cross-cutting transition mode, not forced peer child.

---

# 8. Communication / message delivery

Scenario:

A sender communicates an existing informational state to a receiver.

Routing:

```text
message content                         → State
sender/receiver identity & authority     → Actors
channel/network realised conditions      → Environment
translation/re-encoding if semantics move→ Derivation / Transformation
publication/transmission/exposure        → Selection / Exposure
receiver-side newly captured copy        → Formation / Acquisition when focal at receiver boundary
```

Important distinction:

`sent → delivered → available → selected/noticed → interpreted → agreed` are not equivalent states.

The same communication event can touch multiple branches under different focal questions; this is acceptable because branches are failure regions, not mutually exclusive event types.

**Result:** C3 survives; communication need not be a fourth child.

---

# 9. Conflict / reconciliation / merge

Scenario:

Two overlapping states disagree.

Routing:

- coexistence/conflict condition → State relation/qualification;
- detecting conflict → C2 derivation or C3 selected comparison depending mechanism;
- reconciling/merging → Derivation / Transformation;
- choosing which state is displayed/current → Selection / Exposure plus standing relation;
- decision/authority to accept one state → Work/Actors/control.

Failure probe:

A technically valid merge can still be unauthorised; an authorised decision can still be based on incomplete selected evidence.

**Result:** no boundary theft.

---

# 10. Persistent information / Records boundary

Scenario:

A transient state is stored, revised, retrieved and eventually disposed.

Routing:

- persistent state constitution → State + Records specialization;
- capture/write into persistence → C1/C2 depending origin and focal question;
- migration/version transformation → C2;
- retrieval/recall → C3;
- update/correction → C2 + Records history obligations;
- disposal/retention/custody → Records specialization, with Dynamics describing the informational effect where useful.

Why Records is not a Dynamics child:

Persistence-specific obligations apply across all three branches and add protected outcomes such as future interpretability, preservation closure, historical reconstruction and disposition evidence.

**Result:** persistence remains a cross-cutting specialization/profile.

---

# 11. Cache/index invalidation and propagation

Scenario:

A source is corrected but an index/cache/context still exposes the old state.

Routing:

- source correction → C2;
- dependency/index recomputation or invalidation → C2;
- retrieval of current vs stale version → C3;
- exposure to consumer → C3;
- persistent copy/history obligations → Records when applicable.

D10 propagation/synchronization therefore crosses C2 and C3 rather than forcing a fourth child.

**Result:** three-child model handles the case without hiding propagation failure.

---

# 12. Copy / import / migration role-switching test

The verb `copy` is ambiguous.

- external source first enters system scope → C1 formation/acquisition;
- in-scope state is duplicated/migrated into a new representation/resource → C2;
- copy is sent/exposed to a consumer → C3;
- copy becomes durable evidence → Records specialization also activates.

This confirms a key rule:

> **Route by protected informational question and reference frame, not by operation name.**

A branch taxonomy that classifies API verbs instead of failure questions would fail this test.

---

# 13. Boundary table

| Focal question | Primary route |
|---|---|
| How did source/phenomenon/assertion become an informational state? | Formation / Acquisition |
| How did existing information produce/change another state or standing? | Derivation / Transformation |
| Which existing information became visible/available to this use/consumer? | Selection / Exposure |
| What does the resulting state mean/is? | Informational State |
| What actually happened/exists in operating reality? | Environment |
| What pursuit/decision/verification/acceptance occurred? | Work |
| Who has identity/authority/role/obligation? | Actors |
| What must persist/remain reconstructable/be disposed? | Records specialization |

---

# 14. Child anti-collapse tests

## Can C1 reduce to C2?

No without treating all acquisition as transformation of some pre-existing signal/resource and losing the source-interface/observability/sampling failure family.

## Can C2 reduce to C1?

No. State-to-state inference, aggregation, revision and semantic transformation remain meaningful after acquisition is complete.

## Can C3 reduce to C2?

No without making transformation mean any change in availability. Source states can remain unchanged while selection/exposure fails.

## Can C1 reduce to C3?

No. A source can be selected correctly yet fetched/measured/parsed incorrectly. Conversely, correct source formation can later be omitted from context.

## Is reference-relative overlap fatal?

No. The same real operation can instantiate more than one informational relation, but the protected questions and failure signals remain separable. Foundation branches are diagnostic problem regions, not mutually exclusive event-class enums.

---

# 15. N4 verdict

The leading N3 structure survives required boundary and role-switching cases:

```text
Informational Dynamics
    ├─ Informational Formation / Acquisition
    ├─ Informational Derivation / Transformation
    └─ Informational Selection / Exposure
```

Strengthened judgments:

- C1: survives Environment/Actor/import boundary cases;
- C2: survives Work/State/revision/merge cases;
- C3: survives retrieval/context/communication/staleness cases;
- revision/standing change: remains specialization/mode, not forced fourth child;
- propagation/synchronization: crosses C2/C3;
- persistence/Records: remains cross-cutting specialization;
- branch routing is explicitly **focal-question and reference-frame relative** rather than verb-based.

Proceed to N5 external/cross-domain falsifiers.
