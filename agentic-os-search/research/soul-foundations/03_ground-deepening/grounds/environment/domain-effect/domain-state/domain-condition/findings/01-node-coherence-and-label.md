# Domain Condition Finding 01 — Node Coherence and Label

**Status:** ACTIVE-PASS FINDING  
**Date:** 2026-09-03

## Question

Does the inherited `Domain Condition / Status` node survive deeper research, and what should its primary label be?

## Finding

**The node survives, but the stronger parent label is `Domain Condition`.**

The inherited phrase `Condition / Status` usefully signaled breadth during the Domain State pass, but deeper research shows that `status` is too overloaded to remain a co-primary synonym for the whole node.

Across domains, `status` can mean:
- a categorical realized standing;
- a current operating/lifecycle marker;
- an API/database field reporting a condition;
- a summary classification derived from other facts;
- a legal/institutional standing constituted by rules.

Those are not equivalent.

`Condition` better carries the broader reality-side question:

> **What materially relevant non-structural current facts obtain for the selected constituent/domain whole at the selected scope and time?**

This includes current characteristics, values, qualities, modes and criterion-relative standings when they are materially part of the realized domain situation.

## Why the node remains distinct from Structure

The accepted sibling distinction survives:
- the right constituents and structural relations can exist while temperature, pressure, load, price, chemical concentration, mode, health or legal standing is wrong;
- correct current condition facts do not establish that the right constituents or structural organization are present.

No new evidence forces `Domain Condition` to merge back into `Domain Structure`.

## Why `Status` is demoted rather than deleted

`Status` remains useful below the parent because some current facts are genuinely categorical or standing-like.

However, Kubernetes provides a strong warning against making the word itself reality-defining: a Pod's API `status.conditions` is an information surface that records condition markers, with timestamps and observed generation. The API surface is useful precisely because it represents aspects of the underlying runtime state; it is not the underlying reality by identity.

Institutional sources produce the opposite but compatible warning: a business may genuinely have a legal standing such as `good standing`, constituted relative to an institutional rule system. That standing is a realized domain fact even though a certificate or registry entry is only a representation of it.

Therefore:

```text
Domain Condition
≠ every thing called "status"
```

and:

```text
realized standing/status
≠ status field / report / certificate / dashboard by identity
```

## Node-coherence judgment

The reduction rival fails:

```text
Condition → Structure + Dynamics + representation
```

because a current non-structural reality problem remains after all three are removed. A system may have a particular temperature, mode, current load, market spread, ecological chemical condition or institutional standing at a selected time regardless of whether that fact is represented correctly.

**Result:** retain and rename the node to **Domain Condition**.
