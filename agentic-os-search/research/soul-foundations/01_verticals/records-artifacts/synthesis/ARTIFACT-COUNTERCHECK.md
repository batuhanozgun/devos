# Artifact Verdict — Adversarial Counter-Check

**Status:** supplement to `OBJECT-BOUNDARIES.md`  
**Date:** 2026-09-01  
**Scope:** refines the artifact conclusion; does not replace the full object-boundaries synthesis.

## Trigger

The main object-boundaries synthesis found that `artifact` has incompatible meanings across archives, software/systems engineering, evidence/assessment contexts, and forensics. Before finalising the conclusion, an adverse search tested whether coherent artifact ontologies exist outside those usages.

They do.

## Counter-evidence

- Philosophy has a long-running ontology of artifacts as intentionally made objects, often understood through purpose/function and maker/author relations.
- Philosophy of technology treats `technical artifact` as a coherent functional/structural category.
- Biomedical information ontologies reuse the Information Artifact Ontology / `information content entity` family to model documents, data, identifiers, measurement data, and similar informational entities while distinguishing content from material bearer/concretization.

Therefore the evidence does **not** justify saying that `artifact` is inherently incoherent or unusable.

## Refined verdict

The object-boundaries result should be read as:

> **DISCARD the unqualified term `artifact` as the foundational super-category of the Records vertical. RETAIN qualified artifact concepts as legitimate candidates when their ontology is explicit.**

In particular, `information artifact` remains a candidate in the unresolved search for a neutral category broader than `record`.

This refinement does not reverse the original operational conclusion because:

1. `artifact` without qualification still maps to materially different properties across domains;
2. a generic artifact ontology includes many non-information objects and is therefore broader than the present vertical;
3. software `artifact` often encodes work-product semantics, creating cross-vertical leakage;
4. information-artifact ontologies themselves distinguish information content from material bearer, confirming that the single word does not remove the need for object-boundary distinctions.

## Implication for repository naming

`records-artifacts/` should **not** be renamed automatically now.

Two facts are simultaneously true:

- the current unqualified `artifact` label is not supported as a foundational Records primitive;
- the correct broader category above/around records is still unresolved (`persistent information resource`, `information object`, `information content entity`, `information artifact`, or another frame).

A package rename should follow that broader-domain result rather than pre-empt it.

## Source trail

See:

- `../sources/object-boundaries-recordhood.md`
- `../sources/artifact-counterframe.md`

The original synthesis remains valid subject to this narrower reading of the artifact verdict.