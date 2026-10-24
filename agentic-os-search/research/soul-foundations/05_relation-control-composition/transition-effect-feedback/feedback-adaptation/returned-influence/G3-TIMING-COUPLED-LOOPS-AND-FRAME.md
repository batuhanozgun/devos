# Returned Influence — G3 Timing, Coupled Loops and Frame

**Status:** COMPLETE  
**Date:** 2026-09-11

## 1. The last message is not necessarily the latest condition

Distinguish occurrence/measurement time, delivery time, use time and target/reference time when they affect the claim. A delayed old sample can arrive after a newer observation. Using arrival order as condition order can direct the response toward a state that no longer holds.

This is not a new Time child. Transition/Propagation supplies the realized timing facts; Binding supplies exact target/version applicability; Standing evaluates currentness for the use. Returned Influence asks what input actually entered which response at which point.

A stale signal can genuinely influence. Currentness failure does not erase its causal effect; causal effect does not make it suitable.

## 2. Delay, repetition and amplification

Several responses can be issued before earlier actions become observable. A controller or team may then overcorrect, duplicate work or respond to its own delayed effects. Filtering or stabilization can also delay needed response. S1 and S3 provide control-system pressure; S5 separately distinguishes notification and reset timing.

No numerical delay threshold is universal. Relevant scale depends on the dynamics and decision horizon. A weekly planning review and a machine control loop cannot share one timing standard merely because both use feedback.

'Positive' and 'negative' feedback describe particular reinforcing/counteracting relations under a model; they do not mean good and bad. Existence, stability, safety and benefit remain separate claims.

## 3. Multiple loops are not one monolithic episode

One signal may reach several consumers; several signals may jointly affect one decision. A response in one loop may become an input or disturbance in another. The same observation can have different currentness, scope and significance for different consumers.

Preserve the exact response locus instead of flattening this into `system received feedback`. In a constructed multi-agent case, A's load reduction by delegation can raise B's load. A's local improvement is not the wider system's improvement. Causal Effect/Standing handles that broader judgment; no automatic success follows from local loop closure.

## 4. Causal return is not independent corroboration

A cycle can be operationally useful: output is measured and affects later response. But a claim copied into a summary and repeated by another agent has not thereby acquired a second independent origin.

```text
more messages / reviewers / revisions
!= more independent evidence
```

This does not forbid reasoning again over the same data. A different analysis can reveal an overlooked implication or error. Its value must be credited to that discriminating analysis, not falsely to new source independence.

S8 and S9 offer bounded historical LLM pressure in different task/evaluation settings. They rule out easy slogans: neither 'same-model revision always improves' nor 'all self-feedback is useless' is justified. Their results are not a current-model assessment.

## 5. Internal consistency can preserve a false frame

A system can align its reports, decisions and metrics while all depend on the same mistaken premise or incomplete observation set. Nothing in a closed internal feedback path proves the external referent correct.

Constructed example: a report says all tests ran; a summary copies that report; a reviewer sees the summary and endorses it. The endorsement can genuinely change the release decision while adding no evidence that the tests executed.

The research guardrail is therefore not 'always trust outside feedback'. External sources may also be wrong or share a common dependency. It is: establish relevant source contact, preserve lineage, and assess which error alternatives the evidence actually excludes.

## 6. Scope has two different denominators

```text
all delivered signals handled
!= all observed signals delivered
!= all materially relevant outcomes observed
```

The first may measure workflow throughput. It cannot alone establish coverage of the world or of the user's success criterion. S4/S5 distinguish user-visible monitoring and significant-event coverage from notification volume.

Selection can change after the response: a new policy may reduce reporting rather than reduce incidents, or hide difficult cases. The observed feedback distribution is then partly a product of the loop itself. This is a live framing risk, not an automatic allegation in every system.

## 7. Truth, authority and effect remain separate

A warning can be accurate yet sent by someone without authority to approve a production change. An authorized decision can rely on misleading evidence. A spoofed message can have real influence without valid source standing.

Returned Influence does not grant the message's sender additional authority. Actors and Control still govern who can decide and what may be changed. The present SOUL research likewise does not authorize self-modification of agent-control files.

## 8. Recovery work follows the failed relation

| Observed gap | Candidate investigative/recovery direction, not automatic authorization |
|---|---|
| Relevant outcomes not observed | Revisit observation scope and source access |
| Signal formed but not delivered | Investigate target/route, transport and timing |
| Signal delivered but ignored | Examine relevance, overload, active rule and consumer behavior |
| Response uses wrong/stale referent | Rebind target/time/version; reassess currentness |
| Decision informed, action blocked | Inspect authority, capability and actuation path |
| Action occurred, intended effect absent | Recover realized state and causal alternatives |
| Local measure improved, broader target did not | Revisit system boundary, proxy and spillover |
| Reports agree through one common origin | Seek discriminating evidence rather than count repetitions |

This is a diagnostic map, not a required workflow or evidence hierarchy.

## G3 result

Timing, coupled loops, evidence lineage and observation scope are load-bearing dimensions of returned influence. They do not currently require additional immediate children. They also prevent system consistency from being misused as a substitute for contact with operating reality.
