# Transition / Effect / Feedback — T5 Authoritative External + Candidate Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Method

External traditions are used as hostile holdouts against the project decomposition, not imported as Foundation taxonomy.

Three provisional children entering T5:

```text
Cross-Ground Transition / Propagation
Cross-Ground Causal Effect / Contribution
Cross-Ground Feedback / Adaptation
```

T5 asks whether independent traditions collapse, split or expose a missing peer.

---

## 2. W3C PROV — event/influence/ordering pressure

Primary sources:
- https://www.w3.org/TR/prov-o/
- https://www.w3.org/TR/prov-constraints/
- https://www.w3.org/TR/prov-sem/

PROV distinguishes:
- entities, activities, agents;
- generation, usage, invalidation, start/end events;
- ordering constraints;
- influence/derivation/communication relations.

Important pressure:

```text
ordered event semantics
!= one generic influence relation
```

PROV supports exact transition/event identity and ordering while separately preserving influence semantics.

### Disposition
Supports **Transition / Propagation** and the separation from causal/influence claims. Does not force a fourth child.

---

## 3. Lamport — distributed order and causal order

Primary source:
- https://www.microsoft.com/en-us/research/publication/time-clocks-ordering-events-distributed-system/

Lamport's `happened-before` relation provides a partial order corresponding to potential causal influence, while a consistent total order can be constructed for system purposes.

Pressure:

```text
total order / timestamp order
!= causal order
```

### Disposition
Strongly supports separating **what order/propagation occurred** from **what causal conclusion follows**.

No Temporal-Ordering child is needed; ordering remains a cross-cutting dimension of Transition and Causation.

---

## 4. OpenTelemetry — occurrence versus observation time

Primary source:
- https://opentelemetry.io/docs/specs/semconv/general/events/

Current event semantics distinguish event Timestamp (occurrence time) from ObservedTimestamp (observation/receipt time).

Pressure:

```text
event occurred
!= event observed/received
```

### Disposition
Supports Transition temporal grammar and source-view separation. Does not imply OpenTelemetry's event model should become Foundation representation.

---

## 5. AWS / Google IAM — propagation and revocation holdout

Primary sources:
- https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_revoke-sessions.html
- https://docs.cloud.google.com/iam/docs/access-change-propagation

Both providers document eventual propagation of IAM changes. Google explicitly notes recent revocations/denials may not be effective everywhere immediately and gives different propagation characteristics for policy/group/nested-group changes. AWS documents propagation/caching delay and designs active-session revocation around that delay.

Pressure:

```text
central control change committed
!= control effective everywhere now
```

### Disposition
Very strong holdout for **Cross-Ground Transition / Propagation** after accepted Control.

Also supports the distinction:

```text
control-objective coverage problem
!= control-update propagation problem
```

---

## 6. NASA mishap investigation — events versus causal factors

Primary source:
- https://nodis3.gsfc.nasa.gov/displayAll.cfm?Internal_ID=N_PR_8621_0001_&page_name=ALL

NASA mishap procedures include Events and Causal Factors Diagramming to reconstruct an event and develop associated root cause(s), alongside sequential event plotting, change analysis and fault-tree analysis.

Pressure:

```text
event reconstruction
!= causal-factor/root-cause explanation
```

### Disposition
Supports **Cross-Ground Causal Effect / Contribution** as a distinct diagnostic problem rather than a transition attribute.

---

## 7. FAA root cause / safety management — causal depth and recurrence

Primary sources:
- https://academy.faa.gov/catalog/CPNT/Details/20
- https://www.faa.gov/about/initiatives/sms/explained/basis

FAA root-cause material emphasizes causal factors, recurrence prevention and sustaining corrective actions. FAA SMS explicitly treats organizational decisions as causal factors and links data/reporting to analysis, risk control, control monitoring and continuous improvement.

Pressure:

```text
proximate event explanation
!= recurrence-relevant causal model
```

and:

```text
monitoring control
!= demonstrated continuous improvement
```

### Disposition
Supports both **Causal Effect / Contribution** and **Feedback / Adaptation**.

---

## 8. CDC causality — association/temporality are insufficient

Primary sources:
- https://www.cdc.gov/field-epi-manual/php/chapters/analyze-interpret-data.html
- https://www.cdc.gov/field-epi-manual/php/chapters/interventions.html

CDC field epidemiology warns that statistical significance/association do not establish cause and recommends considering temporality, consistency, plausibility, confounding and other evidence when inferring causation.

Pressure:

```text
association
!= causal effect

temporal precedence
!= sufficient causal proof
```

### Disposition
Strongly supports causal semantics being a separate protected question with calibrated confidence rather than derived from event order.

---

## 9. NIST SP 800-61r3 — continuous incident learning

Primary source:
- https://csrc.nist.gov/pubs/sp/800/61/r3/final

NIST's 2025 revision treats incident response as integrated into cybersecurity risk management rather than a separate circular lifecycle; lessons should be shared as identified and continuous improvement is increasingly necessary.

Pressure:

```text
incident occurred/recovered
!= organization learned
```

Learning requires returned findings to influence ongoing risk-management behavior.

### Disposition
Supports **Feedback / Adaptation** without requiring one fixed lifecycle loop.

---

## 10. NIST continuous monitoring / AI RMF — observation consumed into change

Primary sources:
- https://csrc.nist.gov/projects/risk-management/about-rmf/monitor-step
- https://airc.nist.gov/airmf-resources/playbook/manage/

NIST RMF Monitor expects monitoring outputs to be analyzed/responded to and used in ongoing authorization/risk decisions. AI RMF material calls for monitoring and feedback mechanisms, external feedback capture, root-cause analyses and continuous improvements that can change technical or organizational procedures.

Pressure:

```text
monitoring data exists
!= feedback consumed
!= system/procedure improved
```

### Disposition
Strong support for **Feedback / Adaptation** and for keeping observation/evidence distinct from loop closure.

---

## 11. WHO patient-safety reporting and learning

Primary source:
- https://www.who.int/publications/i/item/9789240010338

WHO emphasizes the limitations of incident reports and notes that using reporting systems for true learning that produces sustainable risk reduction/safety improvement remains a substantive challenge.

Pressure:

```text
incident reported
!= learning achieved
!= sustained improvement achieved
```

### Disposition
Excellent cross-domain falsifier against collapsing Information/reporting into Feedback/Adaptation.

---

## 12. Candidate study — Anthropic AI-native SDLC

Canonical project package:
`research/studies/anthropic-ai-native-sdlc-playbook/`

Reusable holdout:

```text
production incident
→ diagnosis
→ new Work/intent
→ code/config/control change
→ permanent eval case
```

The package explicitly treats `failure should change the system` as a strong SOUL/DevOS alignment and notes incidents can become permanent evaluation cases.

Pressure:
- signal must be consumed;
- persisted test/control/configuration change provides evidence of system adaptation;
- telemetry alone does not establish learning;
- effect of the adaptation still requires later verification.

### Disposition
Supports Feedback/Adaptation, but does not define universal feedback architecture.

---

## 13. Candidate study — Context / Memory / Harness Engineering

Relevant pressure:
- runtime retries/stop conditions and orchestration are Work/harness mechanisms;
- persistence/context changes do not prove downstream behavior changed;
- model-visible context, persisted memory and deterministic runtime controls remain distinct.

### Disposition
Supports Transition boundaries:

```text
configuration/state persisted
!= behavior change effective

context changed
!= target Environment changed
```

---

## 14. Holdout matrix

| Holdout | Transition / Propagation | Causal Effect / Contribution | Feedback / Adaptation |
|---|---|---|---|
| W3C PROV | strong | conditional influence pressure | weak |
| Lamport | strong | strong boundary pressure | weak |
| OpenTelemetry | strong | weak | weak |
| AWS/Google IAM | very strong | conditional | weak |
| NASA mishap | strong | very strong | conditional |
| FAA RCA/SMS | conditional | strong | strong |
| CDC causality | conditional | very strong | weak |
| NIST incident/RMF/AI RMF | strong | conditional | very strong |
| WHO patient safety | conditional | conditional | very strong |
| Anthropic study | strong | conditional | strong |

No tested lineage collapses all three protected questions.

---

## 15. Missing-child test

Potential new peers tested:

### Observation / Monitoring
Rejected as a child: observation is Information formation/exposure plus Binding; whether it closes a loop belongs Feedback.

### Temporal Alignment
Rejected: cross-cutting dimension across all three.

### Recovery / Compensation
Rejected: recovery/compensation activity is Work; resulting cross-ground changes are Transition; causal/effect analysis remains applicable.

### Evolution
Rejected as separate peer: persistent adaptation/evolution is the deeper end of Feedback / Adaptation, not every feedback loop.

### Provenance
Rejected: already primarily Binding/Information with transition evidence; no stable new protected question.

---

## 16. T5 judgment

External/candidate holdouts **strengthen rather than collapse** the three-region decomposition:

```text
Transition / Effect / Feedback
├─ Cross-Ground Transition / Propagation
├─ Cross-Ground Causal Effect / Contribution
└─ Cross-Ground Feedback / Adaptation
```

T6 should decide whether to promote these as immediate diagnostic children and whether the parent then counts as sufficiently researched at current Foundation depth.
