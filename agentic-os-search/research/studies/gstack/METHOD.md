# gstack Study — Research Method

## Purpose

The target is large, fast-moving and structurally heterogeneous. A flat file-by-file summary would lose system relationships, while a top-down Foundation-first classification would risk confirmation bias. This study therefore uses a **semantic synthesis pyramid with source-level evidence provenance**.

## 1. Canonical snapshot rule

Primary study claims are anchored to:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

All source notes should record path and, where practical, blob SHA. If current HEAD is consulted, label it explicitly as freshness/revalidation evidence rather than silently mixing it into the pinned corpus.

## 2. Natural research unit

The default research unit is **not a fixed number of files**.

A more useful unit is a behavior/mechanism and the evidence surfaces that define or constrain it, for example:

```text
skill / policy contract
       + generated/shared preamble or section
       + orchestration/helper code
       + runtime capability
       + tests/evals/compliance checks
       + durable artifacts / state
```

Not every mechanism has every layer. The point is to avoid equating an instruction file with proven system behavior.

## 3. Synthesis hierarchy

```text
                         CORE MODEL
                            ▲
                 cross-system synthesis
                            ▲
                  subsystem syntheses
                            ▲
            source-grounded mechanism notes
                            ▲
                    pinned source corpus
```

Compression ratios are evidence-driven. No rule such as "10 files -> 1 summary" is imposed.

## 4. Evidence provenance is a graph

Although the synthesis output is hierarchical, evidence lineage is not strictly a tree.

One source can support multiple mechanisms; one mechanism can depend on multiple files; later syntheses may expose a relationship that requires reopening an earlier source.

Therefore preserve:

```text
source -> note -> subsystem -> cross-system -> core
   \        \          \             /
    +-------- backreferences / reopen paths --------+
```

A summary is a derived view, never a replacement for the source.

## 5. Reading order

### Phase A — orientation and corpus topology

Read the repository's governing/orientation surfaces, actual tree, project structure, package/build/eval manifests and major runtime architecture.

Goal: discover natural subsystem boundaries without yet forcing the Foundation frame.

### Phase B — subsystem expansion

For each semantic cluster, read the relevant skill contracts plus the shared/runtime/eval surfaces that make the mechanism operational.

Likely clusters are provisional and may split/merge.

### Phase C — subsystem synthesis

For each sufficiently covered cluster, record:

- what problem gstack thinks exists;
- actors/roles involved in gstack-native terms;
- work stages and gates;
- inputs, outputs and persistent artifacts;
- runtime capabilities and environmental assumptions;
- control/authority boundaries;
- verification/evidence mechanisms;
- failure/recovery paths;
- learning/feedback links;
- source-backed observations vs inference/hypothesis;
- unresolved contradictions or coverage gaps.

### Phase D — cross-system synthesis

Ask how mechanisms connect across clusters. Examples to test, not assume:

- planning artifact -> implementation/review/QA/ship handoff;
- memory -> later planning/review behavior;
- eval failures -> skill/template changes;
- production observation -> follow-up work;
- agent dispatch -> authority/gating -> verification;
- runtime capability -> guarded action -> evidence production.

### Phase E — four-ground projection

Only after the gstack-native model is stable enough, derive separate answers to:

- What does gstack do in Information / Representation?
- What does gstack do in Work?
- What does gstack do in Actors / Agency–Participation–Authority?
- What does gstack do in Environment / Operating Reality?

This is a **projection and explanatory view**, not a claim that gstack itself uses those categories.

### Phase F — neutral cross-ground synthesis

Capture mechanisms that cannot be understood as one-ground-local. Use neutral gstack-native language first. Later Foundation composition concepts may be used as comparison tools only when the relevant Foundation state and authorization permit it.

## 6. Epistemic labels

Use these labels in notes when material:

- **OBSERVATION** — directly supported by pinned source.
- **INFERENCE** — reasoned synthesis from multiple observations.
- **HYPOTHESIS** — plausible interpretation requiring more source or challenge.
- **TARGET CLAIM** — assertion made by gstack documentation/authors, not independently established by this study.
- **NEGATIVE EVIDENCE LIMIT** — search/read coverage is insufficient to infer absence.

## 7. Verification discipline

Verification is layered rather than ceremonial.

For important subsystem conclusions:

1. check more than one source surface where possible;
2. distinguish intended behavior from implemented/runtime behavior;
3. inspect tests/evals for externally checkable criteria where available;
4. search for contradiction, bypass and failure paths;
5. record coverage gaps;
6. reopen original sources before promoting a derived claim into the core synthesis;
7. do not call same-model adversarial review independent replication.

A gstack test written by the same repository is stronger evidence of enforced/expected behavior than documentation alone, but it is still first-party evidence and may have oracle/coverage limitations.

## 8. Freshness discipline

The study is version-bound. Before later load-bearing reuse:

- compare pinned commit to current HEAD;
- identify changed load-bearing files;
- selectively re-read changed mechanisms;
- update `META.md`, `STATE.md`, `SOURCE-LEDGER.md` and affected syntheses if the model changes materially.

## 9. Relationship to Foundation / SOUL / Development OS

The study may:

- provide evidence or counterexamples;
- pressure-test distinctions;
- expose missing failure modes;
- provide candidate mechanisms/patterns;
- show real implementation trade-offs.

It may not, by itself:

- alter Foundation state;
- establish architecture;
- authorize implementation;
- turn an external design choice into a project principle.

## 10. Completion criterion

Do not close the study because a predetermined file quota was read.

A bounded completion judgment requires at least:

- enough source coverage to model all load-bearing subsystem families;
- no major unexplained repository/runtime region known to be relevant;
- upper syntheses remain traceable to source;
- four-ground projection is based on the stabilized gstack-native model;
- cross-ground mechanisms are represented without forced single-ground classification;
- freshness and verification limits are explicit;
- an adversarial omission/distortion pass finds no decision-critical missing first-order mechanism for the study purpose.
