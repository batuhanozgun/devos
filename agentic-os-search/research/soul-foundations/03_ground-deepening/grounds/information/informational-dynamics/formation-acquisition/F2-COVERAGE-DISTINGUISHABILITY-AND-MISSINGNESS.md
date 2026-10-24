# F2 — Coverage, Distinguishability and Missingness

**Date:** 2026-09-12  
**Status:** bounded analysis plus finite constructive checks

## 1. There is more than one denominator

An acquisition claim can concern a target universe, a reachable or listed source frame, encountered opportunities, emitted signals, received messages, or instantiated records. Completeness at one surface does not establish completeness at the others.

Case C2 processes every emitted record from two named units. The explicitly supplied target set contains four units. Processing coverage is one; target coverage is one half. Nothing about correct processing restores the absent two units. The point is not that every acquisition must cover a whole population. It is that the denominator must match the claim.

Survey-methodology sources distinguish population/frame/respondent issues from measurement and processing issues [S5, S9]. These are important contrary pressure against an undifferentiated ingestion-success judgment. Their specialized error taxonomies and numerical thresholds are not promoted to Foundation children or universal acceptance rules.

```
all acquired records processed != all source opportunities encountered
all listed sources checked != all materially relevant sources listed
no omitted received message != no unobserved target event
```

Selecting what to observe before a record exists and selecting an already-existing record for a consumer are not automatically the same protected inquiry. One real procedure may instantiate both. The object and reference frame, not the word selection, resolve the diagnostic route.

## 2. What can a fixed record distinguish?

Let X be an explicitly stated class of possible source situations, h map each situation to the available record, and q be the property whose value is sought. A record-only exact decoder d exists on X precisely when q is constant on every fibre of h:

```
h(x) = h(x')  implies  q(x) = q(x')
```

Necessity: a decoder receives the same record for x and x', so it cannot return two different exact answers. Sufficiency: assign each record the common q-value of its fibre. This is a mathematical property of a declared observation model and candidate class, not proof that an actual acquisition system has known h or known X.

Case C3 enumerates four binary source worlds. The record preserves the first bit and omits the second. It checks all sixteen Boolean target functions against a separately enumerated set of possible decoders. The fibre criterion and decoder existence agree for every target. The visible bit is identifiable; the hidden bit is not.

This is stronger and narrower than saying that imperfect information prevents reasoning. Additional assumptions may legitimately restrict X; another measurement or side information may refine h; logical analysis can reveal consequences that were not initially obvious. Prediction can be useful without exact identification. What cannot be inferred is unique discrimination between still-compatible alternatives from that same record alone.

The practical diagnostic question is therefore: **which unresolved alternatives remain observationally indistinguishable, and would they change the decision?** A bigger or better-formatted record does not necessarily discriminate them; a small targeted observation may.

## 3. Negative evidence is conditional, not forbidden

No recorded detection can mean no event, incomplete coverage, detector insensitivity, outage, suppressed reporting, or loss after detection. These are alternative source-to-record paths, not claims that all paths occurred.

Case C12 deliberately includes both directions. In the complete perfect-detector fixture, a negative result excludes the event. In the always-empty observation fixture, the same negative result is compatible with event presence and absence. This defeats both universal rules: no record always proves absence, and no record can never be evidence of absence.

Actual systems usually require more than this binary example: a justified observation interval, source coverage, detector capability/health, known failure modes and uncertainty. This research does not supply their empirical values or a universal probability threshold.

## 4. Missing, null, unknown and zero

An absent field, explicit null, an unknown response and a recorded numeric zero can convey different acquisition outcomes. Their exact semantics depend on the source contract. A source may define null as not applicable; another may leave it ambiguous. Do not replace ambiguity with a confident value or impose one global null vocabulary.

Case C4 preserves four stipulated outcomes. A deliberately faulty zero replacement is rejected. This tests the supplied contract only. The broader conclusion is to preserve or explicitly map source distinctions when they affect the target claim; it is not a mandatory database enum.

AAPOR's response guidance supplies human-source pressure for preserving nonresponse versus substantive answer distinctions [S5]. The Formation claim should state what was obtained, not silently impute missing observations and present them as captured responses. Imputation may be legitimate Derivation if its status and assumptions remain visible.

## 5. Unknown target coverage

Unlike the fixture, real target scope may itself be only partly known. A percentage with a known-source denominator cannot certify coverage of unknown sources. Report the bounded claim and remaining uncertainty instead of pretending that source discovery is complete.

Repeated acquisition can broaden coverage or simply repeat the same blind spot. More observations can improve inference under an appropriate design without repairing systematic omissions automatically. This is a scope boundary; it does not select a sampling estimator or require exhaustive collection.

## 6. Relation to the strongest child split

Coverage/reach and individual-result fidelity can fail separately. That is substantive pressure for separate research regions, not a fact to dismiss. F4 evaluates whether they require immediate children or are independent claim dimensions of the same Formation relation. In either organizational outcome the findings map must expose them separately; a leaf cannot make coverage disappear into a generic quality score.

**Sources:** S5/S9 in SOURCE-LEDGER; C2/C3/C4/C12 in checks. The fibre proposition is the original explicit argument above; no empirical identification guarantee is inferred from it.
