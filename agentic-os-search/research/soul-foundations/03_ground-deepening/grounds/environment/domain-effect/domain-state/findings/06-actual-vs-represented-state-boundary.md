# Domain State Finding 06 — Actual State Is Not Its Representation

**Status:** active-node boundary finding  
**Date:** 2026-09-02

## Question

Does deeper State research require `observed`, `reported`, `specified`, `desired`, `modeled` or `recorded` state to become Domain-State children?

## Finding

**No. These are representation/epistemic relations to Domain State, not additional realized-State children.**

Keep at least:

```text
actual realized Domain State
≠ desired/specification state
≠ observed/measured state
≠ inferred/believed state
≠ reported/cached status
≠ simulated/forecast state
≠ persistent Record of state
```

The representations can be excellent, poor, delayed or absent while the actual domain still has whatever realized structure/condition obtains.

## Digital/software falsifier

Current Kubernetes documentation makes this distinction unusually concrete:
- a Pod specification supplies desired state;
- kubelet reconciles desired state against the actual/current runtime state of containers;
- API-visible Pod status can lag the instant runtime reality because status is produced through polling/reporting mechanisms.

Therefore even a system explicitly built around `state` has multiple non-identical state surfaces.

## Configuration-management counterframe

NIST/NASA configuration-management practices maintain baselines, inventories and configuration-status records. These are operationally valuable because they attempt to describe/control system configuration.

But their very audit/status-accounting functions expose the distinction:
- documented baseline/inventory can be wrong or stale;
- audits compare documentation against built/implemented configuration;
- current configuration records are representations whose correctness must be maintained/verified.

Thus CM evidence is useful for State research only if we do **not** equate baseline/configuration records with actual reality.

## Digital-twin counterframe

National Academies digital-twin work explicitly distinguishes the real/physical counterpart from virtual information constructs and stresses fit-for-purpose model fidelity, parameter/state estimation and uncertainty.

This supports:

> more detailed state representation does not erase the reality/model boundary.

## Social / institutional correction

The boundary is not:

> `real = metaphysically independent of all representation`.

Institutional/social facts can depend on collective rules, roles, practices or acceptance. The relevant project rule is narrower:

> **an actual institutional/domain standing is not identical to any one Record, report, belief or model that represents it.**

Example pattern:
- an institutional status may be constituted through a rule/collective practice;
- a database entry may nevertheless be stale or incorrect about whether that status currently obtains.

## Why this is not a child branch

The same actual-versus-representation problem applies to both current children:
- actual structure vs architecture/inventory/topology model;
- actual condition/status vs observation/report/measurement.

It also directly touches the future Information ground.

Therefore it is a **cross-cutting boundary/control requirement**, not a third State child.
