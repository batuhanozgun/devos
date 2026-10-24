# Records Retention / Appraisal / Disposition — Research Plan

**Status:** active focused pass opened by vertical completeness review  
**Date opened:** 2026-09-01

## Why this pass exists

The prior Records passes covered preservation closure and terminal destruction history, but they did not yet establish a first-principles model for **whether/how long information should continue to exist and what final disposition means**.

The vertical completeness review found this is not merely an implementation concern. Records-management authorities treat appraisal, scheduling, retention, transfer and destruction as first-order records semantics.

## Purpose

Determine the Records-side semantics of:

- appraisal/value and retention need;
- temporary vs permanent disposition;
- active use, cutoff/trigger, retention/transfer period and final action;
- age-based vs event-based retention;
- fixed vs flexible retention bands;
- supersession/obsolescence as retention triggers;
- disposition freezes/holds as constraint state;
- transfer/custody vs destruction;
- logical removal vs payload destruction;
- residual identity/history/destruction evidence;
- disposition across copies/versions/derived views/indexes/backups/external systems;
- schedule/profile version/applicability history.

## Boundaries

Records may define:

- what retention/disposition facts must be represented;
- what event/condition a rule refers to;
- what information must survive destruction;
- what consistency outcome is required across persistent representations;
- what evidence is needed to reconstruct why/when disposition occurred.

Records must **not** decide:

- which Actor has authority to approve schedules/holds/destruction;
- legal interpretation of a specific jurisdiction;
- approval/escalation workflow;
- exact deletion algorithm or cloud/storage implementation.

These are deferred to Actors/Work/governance or implementation.

## Questions

1. Is retention a duration, a condition, an event-triggered rule, or a combination?
2. What is the semantic role of `cutoff` / start-of-retention trigger?
3. How do `temporary`, `permanent`, `long-lived`, `indefinite`, `archival`, and `transfer` differ?
4. How should flexible retention (minimum/maximum/early destruction) be represented without losing risk/constraint semantics?
5. What is the relationship among record currentness/supersession and retention triggers?
6. What does a freeze/hold change: disposition eligibility, record standing, or both?
7. What does `destroy/delete` mean when copies/versions/backups/indexes/caches/derived representations exist?
8. What residual metadata/history should remain after payload destruction, and when can even that be removed?
9. How should disposition authority/rule/version applicability be reconstructable historically without solving authority itself?
10. Can retention/disposition be derived through the Requirement Profile method rather than one global policy?

## Counter-frames

Actively challenge:

- keep everything forever is safest;
- deletion is simply absence of payload;
- `permanent` means merely a very long retention period;
- transfer to archive is equivalent to destruction from the source system;
- every copy/version/index must have the same physical retention rule;
- superseded means immediately destroyable;
- legal hold/freeze changes record truth/currentness;
- one fixed number of years is the natural retention model;
- destruction certificate/tombstone must always survive forever;
- backups can be ignored because they are not primary records;
- a record schedule is timeless after approval.

## Evidence lenses

- ISO 15489 / ISO/TR 21946 appraisal/requirements principles;
- NARA scheduling, appraisal, disposition instructions, implementation and record values;
- National Archives of Australia compliant destruction, records authorities and disposal freezes/retention notices;
- relevant public-sector and digital-record guidance on copies/cloud/destruction evidence;
- prior Records object/change/profile/mechanism passes.

## Operational return condition

Continue until:

1. retention/disposition semantic components are source-grounded;
2. temporary/permanent/transfer/destruction distinctions are explicit;
3. trigger/time model is reconciled with Pass 4 temporal semantics;
4. residual-history and multi-representation disposition are tested;
5. hold/freeze and flexible-retention counterexamples are addressed;
6. the result integrates with Requirement Profile derivation without importing Actor authority;
7. adversarial counter-check is completed;
8. source trace and synthesis are persisted;
9. completeness review can determine whether any other first-order Records dimension remains missing.

This focused pass does not select a deletion/storage architecture.