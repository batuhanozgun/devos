# Constituent Composition Finding 03 — Multiplicity / Amount and the Condition Boundary

**Status:** bounded child-pass finding  
**Date:** 2026-09-04

## Question

Does constituent count, multiplicity, amount, abundance or proportion form a second immediate child distinct from constituent inclusion/membership?

## Result

**No stable universal immediate child is justified.**

The apparent candidate splits into two different semantic cases:

1. **structural multiplicity of actual constituents** — remains inside Constituent Composition when the protected question is how many constituent instances participate/make up the selected whole;
2. **realized quantitative characteristic** — belongs to Domain Condition when the protected question is a value such as concentration, fraction, abundance, load or another characteristic of the whole/constituent.

Therefore `Multiplicity / Amount` is not one clean Composition-local child.

## Why the candidate was initially strong

Several external traditions separately encode identity/presence and amount:
- SysML v2 supports part usages and multiplicity;
- manufacturing BOM practice pairs component identity with quantity-per-assembly;
- ecology distinguishes presence/absence from abundance-weighted composition;
- chemistry describes mixture constituents and their amount/mass/volume fractions.

That cross-domain recurrence shows that quantity is load-bearing, but vocabulary overlap does not settle project ownership.

## Structure case — structural multiplicity

Examples:
- this realized vehicle has four wheel constituents;
- this deployed cluster contains three instances of a particular structural worker component;
- this assembly contains two identical fasteners at the selected structural granularity.

When the question is effectively the cardinality of the constituent set/multiset, it is a facet of actual composition.

If individual tokens are fully identified, count may be derivable from membership. If tokens are represented by type + multiplicity, multiplicity is needed to recover the same structural fact.

## Condition case — realized amount / proportion / concentration

Examples:
- carbon concentration;
- amount fraction in a mixture;
- relative abundance of a biological constituent;
- load or other quantitative state of an included constituent.

The accepted Domain Condition result already protects materially relevant `quantities` and `concentration` under `Realized Characteristics / Values` when those values are the question.

Thus external fields calling a value `composition` does not make it Structure in this project.

## Boundary rule

Use the protected question:

```text
How many constituent instances are actually in this structural whole?
→ Constituent Composition

What quantitative value / fraction / concentration does the whole or constituent currently have?
→ Domain Condition, unless a later child pass proves a stronger structural rule
```

Some descriptions may support both views at different granularities. That is a reference/semantic-role issue, not evidence for a new universal child.

## Normative multiplicity

`Vehicle shall have four wheels` or a BOM quantity is a specification/representation. It does not establish that the actual vehicle has four wheels.

Actual cardinality belongs to reality-side Structure; required/allowed multiplicity belongs to criterion/specification surfaces until realized satisfaction is assessed.

## Falsifier judgment

- F10 multiplicity/cardinality as stable immediate child → **rejected**.
- F11 normative membership leakage → **rejected** with actual-versus-required distinction.
- F13 Condition leakage → **rejected** by protected-question routing.

## Retained internal problem

Structural multiplicity/cardinality remains explicit inside `Constituent Composition`, but does not currently justify its own recursive child pass.
