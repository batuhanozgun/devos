# Returned Influence — G2 Operative Use and Evidence

**Status:** COMPLETE / TWO MATERIAL REFINEMENTS  
**Date:** 2026-09-11

## 1. The visible-change requirement fails

The parent's short description could be read as requiring a new external action or a visible before/after difference whenever feedback operates. That reading is too strong.

Kubernetes HPA explicitly evaluates measurements yet skips scaling within an applicable tolerance. FAA's assurance description also distinguishes nonconformance response from conformity returning to routine operation. These accessible primary sources provide different-domain counterpressure; see S3/S6 in `SOURCE-LEDGER.md`.

Constructed generalization:

```text
observe current condition
→ apply relevant response rule
→ hold / continue / inhibit unnecessary action
```

can be an operative feedback response. An unchanged action is not evidence of absence of feedback.

The converse is equally important: unchanged behavior is not proof that the signal was used. A disconnected controller, ignored message, overridden decision and correctly coupled deadband controller can all show the same output.

## 2. Distinguish four claim levels

| Claim | What must be established | What it does not establish |
|---|---|---|
| Feedback structure exists | A relevant return/coupling path is present in the defined system | It is active for this target/time or this input was used |
| Loop/response coupling is operative | Returned observations enter the applicable response process, including hold/inhibition where warranted | Every sample is individually decisive or external output changes |
| Particular episode contribution | This signal or signal configuration causally contributed to the exact response of interest | The downstream action executed or produced the desired outcome |
| End-to-end feedback effect | The relevant response was realized and influenced the claimed outcome | Benefit, safety, full coverage or permanent adaptation |

These are claim scopes, not four immediate children and not a universal chronological lifecycle. A diagram supports a different claim from a delivery receipt or an intervention experiment.

## 3. Delivery, reading and operative use

The following remain distinct:

```text
signal produced
!= signal delivered
!= signal exposed/read
!= signal operatively used
!= signal individually decisive
!= response executed
!= desired outcome achieved
```

A prose claim such as 'I considered the warning' is a report about use. It is not self-authenticating evidence of actual use. A trace can strengthen the claim if it links the exact input to the relevant decision path; a trace that merely logs receipt proves less.

For an LLM, an explanation written after the answer can fit several possible causes. Do not claim access to hidden reasoning or treat fluent retrospective explanation as an independent oracle.

## 4. Evidence should discriminate the alternatives

Ask which uncertainty is live:

- Is the channel disconnected? Check actual delivery/target binding.
- Is the input delivered but ignored? Inspect the relevant execution/decision path where observable, or perform an appropriately controlled perturbation.
- Is the output unchanged because of a legitimate deadband? Establish that the rule is active and that the observed condition falls under its hold branch.
- Does the same response occur without this particular input because another input is redundant? Test the relevant configuration, not only one deletion.
- Was the decision affected but execution blocked? Read the actual downstream state rather than inferring it from the decision record.
- Are two causal explanations compatible with all observed traces? Retain uncertainty and seek a discriminating case.

A perturbation is informative only within its controlled scope. Changing prompt, model, time, target state and feedback simultaneously is a bundle change, not a clean attribution to the feedback alone. No universal method or numerical confidence threshold is prescribed.

## 5. A single but-for test is not universal

Suppose two alarms feed an OR stop condition. When both alarms are present, removing either alone leaves the stop in place. Removing both changes it. The signal configuration is materially relevant even though neither individual removal changes this outcome.

Conversely, proving that a controller can react to an extreme signal does not prove that one particular normal sample caused an observed decision. Structural responsiveness and episode contribution are different claims.

The accepted Actual Causation grammar handles the episode-level question, including joint/redundant contributors. Returned Influence adds the functional return relation; it does not invent another causal theory.

## 6. Response locus and partial closure

Consider a synthetic operational case:

```text
failure observation returned
→ operator diagnoses overload
→ operator decides to reduce traffic
→ action is rejected by a permission gate
→ overload continues
```

The signal may have influenced diagnosis and decision. End-to-end mitigation was not established. Calling the entire feedback loop successful would hide the execution failure; calling the signal unused would hide the real decision-level influence.

Use an exact locus and completion boundary. Evaluation, routing, timing, explicit deferral and inhibition may be meaningful response outputs. Pure archival storage is not promoted to operative feedback merely because a disk bit changed.

## 7. Absence and timeout signals

A missing expected acknowledgment may be interpreted as a timeout and affect later response. The evidence is the bounded observation of no acknowledgment within a relevant interval, not proof that the remote action failed. A delayed acknowledgment, lost channel and failed action remain alternatives.

Thus missing telemetry can be causally operative while the underlying condition remains unknown. Presence of a generated alert also does not establish the source event it purports to report.

## 8. Hold is not blind conservation

The corrected model does not reward always preserving the existing state. The difference is whether preservation follows the applicable evidence and response process or whether the system is simply insensitive to it. A credible feedback system must allow both justified change and justified continuation.

This is especially important for SOUL interpretation: neither 'always revise after critique' nor 'stay internally consistent with the prior answer' is a sufficient success criterion.

## G2 result

The parent needs a narrow current-wording correction: operative returned influence must not be identified with visible output change or an individually decisive sample. A successful decision-side return must not be identified with completed end-to-end actuation. These refinements strengthen rather than replace the Feedback/Adaptation split.
