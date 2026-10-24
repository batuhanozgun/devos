# Finding 04 — Scale, grade, access, capability and Dynamics boundaries

**Status:** supported bounded finding

## Binary versus graded standing

Binary and graded results do not form separate universal children.

Examples:
- conforming / nonconforming;
- Ready = true/false/unknown;
- well / adequately / under / significantly under / critically under-capitalized;
- good / fair / poor ecological condition.

The result scale may be Boolean, ordinal, graded, categorical or severity-based. That affects expression and decision semantics, but the protected question remains which criterion-relative standing obtains.

**F7: rejected.**

## Whole versus constituent standing

Standing can be borne by:
- one constituent;
- a relation;
- a subsystem;
- an aggregate/whole;
- an institution or organization.

EPA condition assessments explicitly aggregate component indicators into whole/site condition categories. Whole-standing recovery may require an aggregation rule, but this is a bearer/scope and composition issue rather than a universal first-order standing child.

**F9: rejected.**

## Direct versus inferred / modelled / adjudicated access

How we know the standing varies:
- direct checkpoint evaluation;
- sensor/measurement plus decision rule;
- diagnostic or health model;
- audit/inspection;
- regulator/board/court decision;
- authoritative registry;
- statistical assessment.

These access paths create materially different evidence, uncertainty and authority issues, but they do not define different reality-side standings by themselves.

A standing can be:
- true while the evidence is incomplete;
- uncertain to us;
- disputed;
- misreported;
- later corrected.

Those are critical Information/verification concerns, not automatic standing children.

**F10: rejected. F15: supported as anti-collapse.**

## Capability / readiness / availability / reliability

These terms require role-sensitive treatment.

- `Ready` can be a current criterion-relative standing when it means the bearer currently satisfies readiness gates/checkpoints.
- `Capability` is generally an ability/disposition under specified conditions and can span realized structure, dynamics and context.
- `Availability` and `reliability` are often probabilistic and time-indexed/system-performance quantities, not simple current standing categories.

SEBoK v2.14 explicitly defines capability as ability under specified conditions; availability as probability of being operational at a time; reliability as probability of function without failure over a period under stated conditions.

Therefore the family does not justify a new universal standing child.

**F8: rejected.**

## Current standing versus Dynamics

Keep separate:

```text
current standing = degraded       → Criterion-Relative Standing
standing changed healthy→degraded → Dynamics / transition
standing degraded for 2 hours     → standing + temporal history/duration
trend toward failure               → Dynamics / projection, not current standing alone
```

Kubernetes condition representations include `lastTransitionTime`, which is useful evidence that systems often track current condition and transition history separately even when represented together.

**F19: rejected.**

## Conclusion

Scale, grade, access mechanism and temporal form are important dimensions, but none survives as a stable universal immediate-child decomposition.