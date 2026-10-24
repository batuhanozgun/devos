# Finding 05 — Reality, representation, criterion and authority boundary

**Status:** supported bounded finding

## Core anti-collapse result

The pass retains the following distinctions:

```text
actual criterion-relative standing
≠ criterion / rule / threshold / standard by identity
≠ assessment procedure by identity
≠ evidence / measurement / observation by identity
≠ score / model output by identity
≠ API status field / dashboard by identity
≠ certificate / report / attestation by identity
≠ authority / adjudicator role by identity
```

## Criterion is not standing

ISO conformity traditions distinguish specified requirements from conformity/nonconformity. A requirement can exist while the object is conforming or nonconforming; therefore the criterion is not the standing.

Criterion applicability also matters:
- standard/version;
- jurisdiction;
- contract/regime;
- target/bearer scope;
- time/currentness;
- exceptions/waivers;
- authority.

Those binding questions are essential for correct recovery, but they are later relation/control/Information/Actors concerns as appropriate rather than a third Domain Condition child.

**F12 and F13: supported as anti-collapse.**

## Assessment result is not necessarily true standing

NIST decision-rule work distinguishes:
- a conformance zone for characteristics that actually conform;
- an acceptance zone for measurement results accepted under a decision rule.

False acceptance and false rejection are possible.

ISO 10576 likewise treats conformity checking as using test/measurement results and uncertainty.

Therefore:

```text
assessment says conforming
```

is evidence/decision output about:

```text
object actually conforms
```

and the two cannot be silently identified.

**F14: rejected.**

## Software representation case

Kubernetes documentation describes Pod/Node conditions as markers/fields used to understand actual state. Readiness may depend on configured gates; pressure conditions map signals to thresholds.

The API object is a representation/control surface. The project treats the reported condition as evidence/operational representation of the current standing, not the world fact by identity.

## Institutional/legal case

Official California and Delaware sources provide the strongest authority-sensitive holdout:
- entity/license `status` or `standing` is current;
- a Certificate of Status / Good Standing or license verification communicates/certifies that current status;
- official web records can be current status views without being identical to the standing itself.

Some institutional standings are partly constituted by law, rules, filings, authority or disciplinary acts. This does not make them mere documents.

Social-institution theory provides a counterframe: institutional facts can depend on constitutive rules and collectively/authoritatively recognized roles. This supports taking institutional facts seriously while also warning that authority and deontic semantics must not be moved wholesale into Domain Condition.

## Authority is not standing

A regulator, board, court or organizational role may have power to:
- establish criteria;
- issue or revoke a license;
- adjudicate a case;
- declare/certify a result.

Those Actor/authority semantics remain distinct from the resulting current standing.

**F20: rejected as collapse.**

## Causal explanation is not standing

`degraded`, `noncompliant` or `suspended` does not by itself answer why that state obtains.

Root cause, mechanism, responsible actor and causal attribution remain separate retrieval problems.

**F18: rejected.**

## Uncertainty / conflict

Uncertainty about whether a standing obtains is normally evidence/knowledge state rather than necessarily part of the standing itself.

A domain may explicitly define `Unknown`, `Pending` or `Under Review` as a real institutional/operational standing; in that case the category can itself be the true current standing. That must not be confused with the research system's uncertainty about which standing is true.

**F15: supported with this distinction.**