# Cross-Ground Feedback / Adaptation — F5 External + Candidate Holdouts

**Status:** COMPLETE / TWO-CHILD SPLIT SURVIVES EXTERNAL PRESSURE  
**Date:** 2026-09-11

## Objective

Pressure-test the provisional structure with materially different traditions without treating any source as taxonomy authority.

```text
Cross-Ground Feedback / Adaptation
├─ Feedback / Returned Influence
└─ Persistent Adaptation / Future-Response Change
```

## 1. WHO patient-safety reporting and learning systems

Primary source:
- WHO, *Patient safety incident reporting and learning systems: technical report and guidance* (2020)
- https://www.who.int/publications/i/item/9789240010338

WHO explicitly distinguishes incident reporting/data collection from true learning that achieves sustainable reductions in risk and patient-safety improvement.

Pressure:

```text
incident observed/reported
!= learning achieved
!= sustainable risk reduction
```

This strongly supports the persistent-adaptation boundary: representation and analysis can exist without durable future-response change.

It also supports the Feedback child because reporting must feed into downstream analysis/action to become behaviorally influential.

## 2. FAA Safety Management System

Primary sources:
- FAA SMS overview/components
- https://www.faa.gov/about/initiatives/sms/explained/components
- https://www.faa.gov/about/initiatives/sms/explained/basis

FAA Safety Assurance includes information acquisition, data analysis, system assessment, monitoring control effectiveness and identifying improvement opportunities. SMS is described as enabling adaptation to change and continuous improvement.

Pressure:

```text
operational outcome
→ assurance information
→ analysis/system assessment
→ improvement opportunity
→ changed risk-control/process state
```

But each arrow is contingent. Monitoring alone is not adaptation; identified opportunity is not implemented change.

This supports the two-child structure rather than one undifferentiated loop.

## 3. NIST CSF 2.0 Improvement

Primary surfaces:
- NIST CSF 2.0 / CSRC filters for `Improvement (ID.IM)`
- https://csrc.nist.gov/Projects/cybersecurity-framework/Filters

NIST distinguishes improvements identified from tests/exercises and operational execution from the underlying operations themselves.

Examples include using assessment findings and lessons learned to improve future incident response/business continuity processes.

Pressure:

```text
finding / lesson identified
!= improvement implemented
!= future behavior changed
```

Again, feedback inputs and persistent process adaptation are related but non-identical.

## 4. NASA adaptive-control tradition

Primary NASA-hosted sources:
- *Adaptive Control* (NASA-hosted historical report)
- *System parameter adaptation via a learning procedure*
- learning/adaptive-control V&V material in NTRS.

Strong pressure:
- a feedback controller can react under a fixed control law;
- an adaptive controller changes control law/parameters in response to measured system/environment change;
- learning/adaptation raises convergence and stability questions.

Foundation translation:

```text
feedback control
!= adaptive control by identity

adaptation
!= stable / safe / convergent by identity
```

This is the strongest independent structural pressure for two distinct children.

## 5. Google SRE postmortem culture

Primary/public operational sources:
- https://sre.google/workbook/postmortem-culture/
- https://sre.google/resources/practices-and-processes/incident-management-guide/

Google emphasizes written postmortems, owned action items and follow-through; postmortems are useful when acted upon and used to drive system change/prevent recurrence.

Pressure:

```text
incident documented
!= action item completed
!= system behavior durably changed
```

Google also routes corrective action items back into team backlog, which demonstrates Work mediation between feedback and persistent system change.

## 6. Candidate study — gstack

The candidate study reports an evolutionary pattern:

```text
prose/local convention
→ real failure
→ named distinction
→ reusable helper/runtime rule
→ invariant/scanner
→ behavioral/environment E2E
→ CI/release consequence
```

This is a strong real-system example of persistent adaptation across Information, Work, Control and Environment.

But candidate limitations matter:
- historical change does not itself prove every change was beneficial;
- repository evolution can miss unobserved runtime outcomes;
- adaptation effectiveness remains a causal/Standing question.

## 7. Candidate study — Anthropic AI-native SDLC

The study preserves incident→diagnosis→new intent/fix→permanent eval/configuration/control loops and recommends evaluating agent configuration itself.

Pressure:

```text
production signal
→ feedback into work/governance
→ durable eval/control/config change
```

But its own falsifier set warns:

```text
incident followed by guardrail
and later fewer incidents
!= guardrail causal effectiveness automatically established
```

Thus adaptation occurrence and adaptation benefit remain separate.

## 8. Does external pressure force a third child?

Tested:

### Stability / Convergence
No. Criterion/effect profile of feedback/adaptation, consumed by Standing and causal analysis.

### Organizational Learning
No. One realization/scope of persistent adaptation involving human/organizational Actors, Work and Information.

### Evolution
No stable separate protected question yet. Long-run repeated/recursive adaptation remains a strong reopen trigger.

### Evaluation / Assurance
No. Primarily Standing/Work/evidence-facing.

### Continuous Improvement
No. A domain/program framing that composes feedback + Work + adaptation + causal effectiveness + Standing.

### Self-Modification / Meta-Learning
No. Recursive locus/depth of adaptation, not a distinct truth condition at current Foundation depth.

## 9. External holdout verdict

The provisional two-child structure strengthens:

```text
Cross-Ground Feedback / Adaptation
├─ Feedback / Returned Influence
└─ Persistent Adaptation / Future-Response Change
```

The two regions have:
- different protected questions;
- different characteristic failures;
- different evidence requirements;
- independent variation in real systems;
- cross-domain recurrence;
- no safe reduction into each other.

No third child or upstream reopen is forced by current external/candidate pressure.