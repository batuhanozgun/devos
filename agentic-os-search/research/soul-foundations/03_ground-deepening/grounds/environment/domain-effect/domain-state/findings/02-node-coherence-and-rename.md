# Domain State Finding 02 — Node Coherence and Rename

**Status:** active-node finding; provisional until closure  
**Date:** 2026-09-02

## Question

Does the inherited label `Domain State / Configuration` describe one coherent problem node, or does deeper research require a split or reframe before child discovery?

## Current result

The node remains coherent **if its broad meaning is the realized domain snapshot/situation at a selected scope and time**, but the paired label `State / Configuration` is unnecessarily ambiguous.

Strongest working reframe:

> **Domain State**

with `state` explicitly defined here as **realized domain condition at the selected reference/time**, not as a mandatory formal state vector, database row, reported status object or configuration specification.

## Why drop `Configuration` from the parent label

External and project evidence use `configuration` in at least two different ways:
- arrangement/composition/topology of elements and relationships;
- settings/parameters or a documented baseline/specification.

That ambiguity matters because the current research needs to separate:
- **realized structure/composition**;
- **realized properties/condition/status**;
- represented or desired configuration information.

Keeping `Configuration` in the parent label makes it harder to tell whether a later child distinction is structural, condition-oriented or representational.

## Rival labels tested

### `Domain State / Configuration`
Useful inherited label, but overly bundled. Weakened.

### `Realized Domain Condition`
Strong reality emphasis but `condition` is too easily read as only health/status/quality, understating composition/structure.

### `Domain Situation`
Broad enough for constituents, relations and properties, but risks collision with selective context/situation semantics and can obscure the State-versus-Dynamics sibling distinction.

### `Domain Snapshot`
Intuitive but implies an observed/recorded capture and can accidentally pull representation semantics into Environment.

### `Domain State`
Best current working label if explicitly architecture-neutral and reality-side.

## Candidate immediate split

Current evidence most strongly supports testing:

```text
Domain State
    ├─ Domain Structure / Composition
    └─ Domain Condition / Status
```

This is not yet final in this finding. The split must survive child-promotion, cross-domain and omission tests.

## Anti-collapse rule

`Domain State` does not mean every fact that can be encoded in one formal state vector. A reasoning/model state is a selected representation and may be purpose-relative. The Environment node concerns the realized facts that such a representation attempts to track when those facts are materially in scope.
