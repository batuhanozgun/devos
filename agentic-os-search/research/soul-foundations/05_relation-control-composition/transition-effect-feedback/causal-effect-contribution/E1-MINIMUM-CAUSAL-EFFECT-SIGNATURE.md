# Cross-Ground Causal Effect / Contribution — E1 Minimum Causal-Effect Signature

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Determine the minimum semantic structure needed for a decision-critical causal claim without forcing one causal-inference methodology onto every domain.

The active question is not:

> What fields should a causal database record have?

It is:

> What distinctions must remain recoverable so that a causal claim cannot silently collapse into chronology, correlation, attribution or unsupported certainty?

## 2. Exact explanandum/effect is mandatory

A causal claim must bind to the **exact realized effect being explained**.

Examples:

```text
service became unavailable for 18 minutes
```

is not the same explanandum as:

```text
one request timed out
```

Likewise:

```text
role revocation failed to block one stale session
```

is not the same explanandum as:

```text
protected effect remained reachable through any path
```

Therefore the causal child inherits exact effect identity/scope/time from accepted Transition / Propagation.

Mandatory rule:

```text
ambiguous effect target
→ ambiguous causal question
```

## 3. Candidate contributor identity is mandatory

A causal claim must identify what is proposed to have mattered causally.

A contributor can be:
- an event/action;
- a condition/state;
- a Work choice or omission;
- an Environment condition;
- an Information state/absence/misrepresentation;
- an Actor action/decision/position;
- a Control presence/absence/failure;
- another prior transition/effect.

This does **not** create new grounds. Causal Effect composes accepted-ground phenomena around one realized effect.

## 4. Generic `caused` is sometimes too lossy

Decision-critical analysis can require the causal role to remain distinguishable.

Candidate roles include:
- produced/directly generated;
- enabled / made possible;
- increased likelihood / amplified severity;
- triggered/initiated;
- failed to prevent;
- failed to detect/contain;
- mitigated/reduced;
- was necessary under the relevant contrast;
- was sufficient jointly or independently;
- contributed as one member of a causal set.

Not every domain requires all labels, and these labels are not yet children.

But this collapse is unsafe:

```text
trigger
= enabling condition
= prevention failure
= direct mechanism
= systemic condition
```

when intervention choice changes depending on the role.

## 5. Relevant causal context/scope is mandatory when it changes the claim

Causal claims are often context-relative.

Examples:

```text
configuration X caused outage
```

may be true only under:
- Environment condition E;
- traffic level L;
- dependency version V;
- specific Actor/tool path;
- a disabled safety control;
- a particular time window.

The context is not decorative if changing it changes whether the contributor matters causally.

Therefore preserve relevant:
- target/scope;
- temporal window/order;
- boundary conditions;
- interacting contributors;
- baseline/reference or population/unit where material.

## 6. A causal contrast is conceptually load-bearing, but need not always be explicitly formalized

Causal effect claims implicitly compare alternatives:

```text
with contributor X
versus
without / changed X
```

or:

```text
under action A
versus
under action B / baseline
```

For deterministic mechanism investigation the contrast may be obvious from physical/engineering knowledge and not require an explicit statistical estimand.

For observational population data, the contrast can be central and difficult to identify because confounding/selection determine whether the observed comparison approximates the causal contrast.

Foundation result:

> **Causal contrast/reference semantics are conceptually load-bearing when the causal question depends on what would differ under an alternative condition, but Foundation must not require one universal counterfactual notation.**

This prevents both extremes:

```text
counterfactual model required for every causal statement     ← too strong
mere temporal/mechanistic story always enough                ← too weak
```

## 7. Evidence basis is mandatory for an asserted causal conclusion

An actual causal relation and our evidence for it remain distinct:

```text
causal contribution exists
!= evidence says it exists
```

Evidence may include, depending on domain:
- direct physical/mechanistic observation;
- intervention or randomized experiment;
- controlled comparison;
- natural experiment;
- statistical association after confounding control;
- dose-response / consistency / temporal evidence;
- fault injection / removal test;
- replay/reproduction;
- barrier/control analysis;
- logs/telemetry/provenance;
- expert/domain theory;
- counterfactual model;
- elimination of competing explanations.

No one evidence type is universally sufficient.

## 8. Competing explanations must remain representable when evidence is non-discriminating

CDC pressure makes this especially clear for observational analysis:

```text
observed association
← could arise from causal effect
← or chance
← or selection bias
← or information bias
← or confounding
← or analysis/investigator error
```

Incident analysis has analogous alternatives:

```text
outage after deployment
← deployment defect
← dependency failure
← traffic spike
← environment drift
← interaction among several
```

Therefore a causal claim may need:
- competing hypotheses;
- disconfirming evidence;
- unresolved alternatives;
- tests/observations that would discriminate them.

`one plausible story` is not the same as `causal model established`.

## 9. Causal confidence is decision-critical but not a new epistemology ground

A system may need to say:

```text
high-confidence causal contributor
probable contributor
plausible but unresolved
insufficient evidence
alternative explanations remain
```

Exact scales are domain-specific.

The Foundation requirement is weaker:

> Do not force a binary causal verdict when evidence does not discriminate sufficiently.

This resembles Standing's `true / unknown / stale / not evaluated` discipline but is specific here because unresolved **causal alternatives** directly affect intervention choice and recurrence predictions.

## 10. Causal depth is part of adequacy, not contributor identity

A proximate cause can be true:

```text
request failed because dependency returned malformed response
```

while a deeper explanation matters:

```text
why was malformed response accepted?
why was schema drift not prevented?
why was detection absent?
why did the system depend on an unversioned contract?
```

Depth is not an infinite hierarchy requirement.

Project stop rule applies:

> Go deeper while the added causal layer materially changes intervention, recurrence risk, control design, responsibility boundary or decision outcome.

Thus causal depth is an analysis dimension/adequacy criterion, not yet an immediate child.

## 11. Actual causation and population causal effect are related but not identical query forms

The child must support at least two broad query shapes:

### Actual episode causation

> What contributed to this realized effect in this specific episode?

Typical evidence:
- timeline + mechanism;
- fault reconstruction;
- barrier analysis;
- counterfactual actual-cause reasoning;
- system investigation.

### Population/policy causal effect

> What would changing X do to Y across a relevant population/context?

Typical evidence:
- randomized or quasi-experimental intervention;
- observational causal inference;
- confounding adjustment;
- statistical estimands.

The Foundation child should not split them prematurely because they share:
- exact outcome/effect semantics;
- contributor/exposure/action semantics;
- contrast/context;
- evidence/alternatives;
- intervention relevance.

But later passes must test whether this difference warrants children.

## 12. Provisional minimum signature

The strongest current reusable grammar is:

```text
Cross-Ground Causal Effect / Contribution
├─ exact realized effect / explanandum
├─ candidate contributor(s)
├─ typed causal role(s) where decision-critical
├─ relevant context / scope / time / interacting conditions
├─ causal contrast / reference semantics where material
├─ evidence basis and discriminating tests
├─ competing explanations / confounding / alternatives where material
├─ calibrated confidence / unresolvedness
└─ causal depth sufficient for the decision/intervention
```

Not universally mandatory as separate fields:
- `root cause`;
- explicit counterfactual notation;
- statistical effect size;
- one mechanism graph;
- one universal depth taxonomy;
- one primary cause.

## 13. E1 conclusion

A Foundation-safe causal claim requires more than a relation label but less than one universal formal causal model.

The minimum is best understood as **an exact effect-centered causal claim grammar plus evidence/alternative/depth discipline**.

Proceed to E2 to determine whether recurring causal roles/depths form stable children or remain overlapping analysis roles.