# F3 — Fidelity, Mode, Time and Observer Effects

**Date:** 2026-09-12  
**Status:** bounded analysis

## 1. Fidelity is relative to a protected meaning

Exact byte transfer is a powerful test for a byte-preservation claim, but not a universal semantic oracle. A source may be encoded, ambiguous, multi-part or context dependent. A transform may change bytes while preserving relevant meaning. Conversely, a parser can emit valid syntax while dropping a negation, unit, scope, source identity or uncertainty qualifier.

In C7, both captures parse as JSON; only one retains the full source sentence. The negation-deleting substitute is rejected by comparison to the supplied source. The test does not solve general semantic equivalence, transcription quality or hidden interpretation. It demonstrates why syntax success is too weak for that particular fidelity claim.

Name what is protected: exact document/version, utterance wording, reported value/unit, source assertion and mode, selected fragment with its surrounding qualifier, or another explicitly bounded result. Existing State and Binding research governs the meaning and identity of that object.

## 2. Two truth questions, not one

A faithful record that an actor asserted P can support the assertion-occurrence claim without establishing P. A credential or authenticated source can also be genuine while its subject-matter claims need separate evaluation; the W3C credential model makes this boundary explicit [S7].

The converse matters too. A source may be misquoted into a statement that happens to be true. World truth does not repair the false attribution or capture history. This yields four possibilities for capture fidelity and subject-matter truth. A single trusted/untrusted bit cannot preserve them.

Authority is another question. Correctly recording an instruction does not establish that its issuer had governing authority; even valid authority does not make factual assertions universally true. Formation preserves the record and source roles, while Actors, Control, causal inquiry and Standing retain their own questions.

## 3. Interpretation can be constitutive of acquisition

An indication does not become a quantity value without an interpretation and, where needed, a model or calibration. In C11 the same raw number yields different values under two stipulated scale interpretations. The test supplies the correct scale; it does not validate a real measuring model.

It would be equally mistaken to assume that all acquired content is numerical. VIM's measurement definition has a narrower quantity scope [S1]; Formation also needs assertions, categorical responses, imported text, images and other informational modes. A measurement-only child tree would omit rather than explain these cases.

A method may both obtain signals and derive a result. Therefore source binding and derivation validity can both be required within a single acquisition episode. Neither calling the result raw nor attributing it to a sensor removes model assumptions. A computationally produced result may still be useful evidence, but its evidential role must match what the process actually supports.

## 4. Observation labels and generated content

SSN/SOSA's broad observation vocabulary and non-normative forecast example are intentionally scoped modeling choices [S4]. They are counterpressure against treating the word observation as a guarantee of direct contemporaneous contact with the referent.

C10 faithfully acquires a forecast artifact produced at time 10 about time 20. The fixture contains no observation of that future condition. Artifact existence, production time, target reference time and evidential mode remain separate. Capturing a prediction is an acquisition; validating the predicted event is a different claim.

This does not declare forecasts false, generated information worthless, or any named ontology defective. It prevents source vocabulary from silently changing the claim made by Foundation research.

## 5. Time and repeated delivery

At least source-reference time, production/completion time and receiver-observation time may be material. OpenTelemetry explicitly distinguishes source event time from collection observation time [S8]. Our common-clock C6 fixture shows that receipt-latest can be reference-oldest.

Real clocks may not be comparable; publication and effective time can differ; historical reports can be acquired later; a forecast may refer forward. Do not impose one universal timestamp order or use freshness as a property of the arrival field alone. A valid as-of request can deliberately seek an older representation.

C5 separates delivery identity from origin identity and payload equality. This does not prove that distinct origins are independent: several origins can share upstream evidence or common error. It only prevents repeated deliveries from being counted as new source episodes by identity.

## 6. The act of acquisition can change the source

VIM's measurand notes expressly allow the measuring system and conditions to affect the phenomenon [S2]. AAPOR's questionnaire guidance supplies a different, human-source case in which the acquisition setup matters [S5].

C8 increments a count when it is probed, then records the new value. It is an explicit observer-effect construction, not a sensor experiment. The record is accurate for the under-probe state and not for the pre-probe target. A correction could be justified if the effect model is established; the current result cannot merely relabel the two targets as identical.

Acquisition need not be passive to be valid. Intervention or elicitation can be exactly the intended method. The important distinction is what target the resulting information supports and what acquisition conditions are constitutive of it.

## 7. Interpretation and causal-depth limits

If a source qualifier was lost, fixing the parser can repair that pathway. It does not repair omitted sources, an inappropriate target definition, source dishonesty or a probe that changed the target. Conversely, collecting more data does not fix a systematic decoding error. These distinctions help locate a remedy without asserting a universal root cause for every failure.

No single method-specific fix is claimed to close the entire Formation failure class. The upstream frame and serious alternatives remain part of the exact claim whenever they could change its result.

**Sources:** S1/S2/S4/S5/S7/S8 in SOURCE-LEDGER; C5–C8/C10/C11. All source interpretations are bounded to the stated passages; no implementation is adopted.
