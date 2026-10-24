# Domain State — Source Ledger

**Status:** preserved source/view recovery ledger for the closed Domain State pass; not active work  
**Date:** 2026-09-02  
**Scope:** Environment → Domain Reality → Domain State, started under the label `Domain State / Configuration`

> **Pass provenance:** This ledger preserves the evidence recovery used during the Domain State pass. Current hierarchy/status is in `../STATE.md`, `../KEY.md`, `../FINDINGS-MAP.md`, and `../CURRENT-SURFACES.md`. Pass-time language below is evidence history, not current authorization.

### Exact pass-input snapshot

For historical reconstruction, the Domain Reality parent state **immediately before the Domain State pass began** is content-addressed by the Domain Reality `CURRENT-SURFACES.md` blob:

- pass-input manifest blob: `74f893b631700d89bdfd409382aa6fc2c9383e86`
- containing commit: `58cb4e01fd4d182e39edaf76bddbe0d5f8cfa2c1`

Interpretation:
- the relative paths below are **current navigation paths** to the corresponding evidence families;
- the blob above is the **exact historical parent snapshot** for reconstructing what was current when this pass was planned/entered;
- later Domain State closure/refinement edits to parent `STATE`/`KEY`/router files must not be mistaken for the pass-input state.

## Purpose

Track which sources discriminate among State-child hypotheses while keeping modeled/documented state distinct from realized Domain State.

No external source independently validates the project's child hierarchy.

---

## A. Project evidence

### A1 — Domain Reality parent package at the time of this pass

Key paths:
- `../../STATE.md`
- `../../KEY.md`
- `../../FINDINGS-MAP.md`
- `../../findings/04-state-configuration-vs-dynamics-processes.md`
- `../../findings/08-domain-reality-problem-map.md`
- `../../synthesis/DOMAIN-REALITY-SYNTHESIS.md`
- `../../OPEN-QUESTIONS.md`

Carries:
- State/Configuration versus Dynamics/Processes separation;
- constituents/properties/relations as current State concerns;
- explicit reopen questions for Structure, Identity, Constraints and granularity;
- actual-versus-representation boundary.

Limitation:
- deeper State child structure was intentionally unresolved.

### A2 — Technical Work Environment prior evidence

Key paths:
- `../../../../../../01_verticals/work-environment/findings/01-boundary-and-identity.md`
- `../../../../../../01_verticals/work-environment/findings/02-configuration-state-reproducibility.md`
- relevant source ledgers when needed.

Carries:
- instance/profile/equivalence identity are distinct and purpose-relative;
- declared definition, resolved composition and realized live state can diverge;
- configuration records/manifests are representations, not realized environment by identity.

Limitation:
- Work Conditions specialization; used only as analogy/falsifier, not as Domain-State authority.

---

## B. External source families

### B1 — SEBoK: state, structure and systems fundamentals

Sources:
- https://sebokwiki.org/wiki/State_(glossary)
- https://sebokwiki.org/wiki/Structure_(glossary)
- https://sebokwiki.org/wiki/Concepts_of_Systems_Thinking
- https://sebokwiki.org/wiki/Introduction_to_System_Fundamentals
- https://sebokwiki.org/wiki/System_(glossary)

Observed content:
- `state` is described through values of qualities/properties at a time and practical current/future potential/health;
- `structure` is described through elements and their relationships/layout/connections;
- systems fundamentals connect allowable configurations of relationships to system state;
- system properties emerge from parts/properties plus relationships/interactions.

Carries:
- strong discrimination between a structure/composition question and a condition/property question;
- evidence that elements + relationships belong together as structure rather than necessarily separate project children;
- warning that terminology differs even within systems traditions (`configuration` can participate in state semantics).

Limitations:
- systems/system-of-interest centered;
- definitions are not universal ontology;
- current SEBoK article `Structure, Identity, and Function in Systems` explicitly acknowledges drafting support by OpenAI ChatGPT and is **not used as load-bearing independent evidence** in this pass.

### B2 — Work Domain Analysis / Cognitive Work Analysis

Sources:
- https://www.sciencedirect.com/topics/computer-science/work-domain-analysis
- https://www.sciencedirect.com/science/article/pii/S0925753522002612

Observed content:
- WDA separates abstraction and decomposition as orthogonal dimensions;
- decomposition handles whole/part structure;
- descriptions of physical resources may include number/type/configuration/material properties/topography/spatial distribution/connections;
- WDA does not simply reproduce task/activity trajectories.

Carries:
- evidence that composition/part-whole and property descriptions are distinct useful analyses;
- warning against turning abstraction/decomposition/modeling axes into this project's child tree automatically.

### B3 — NASA / NIST configuration management

Sources:
- NASA Systems Engineering Handbook CM: https://www.nasa.gov/reference/6-5-configuration-management/
- NIST SP 800-171r3 baseline configuration: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/800-171r3/NIST.SP.800-171r3.html
- NIST SP 500-161 legacy SCM: https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication500-161.pdf

Observed content:
- configuration management separately identifies configuration items/content, topology/placement/connectivity, settings and status-accounting concerns;
- configuration audits/verification compare controlled/documented descriptions with implemented/built configurations;
- configuration-status accounting maintains current/historical information about configuration items and changes.

Carries:
- operational evidence that composition/configuration errors and status/settings errors require separate management/recovery questions;
- strong source-fidelity warning: baselines, inventories and status-accounting records are **representations/control artifacts**, not actual Domain State by identity.

### B4 — NIST asset condition / prognostics and health management

Sources:
- https://www.nist.gov/publications/asset-condition-management-framework-smart-health-ready-manufacturing-systems
- https://www.nist.gov/publications/adaptive-multi-scale-phm-robotic-assembly-processes
- https://www.nist.gov/publications/adaptive-multi-scale-prognostics-and-health-management-smart-manufacturing-systems

Observed content:
- Asset Condition Management focuses on current/future state of health, condition awareness, diagnostics/prognostics;
- PHM work separately uses hierarchical component/system relationships and health states.

Carries:
- cross-domain evidence that structural hierarchy/composition and current condition/health are operationally distinct concerns.

### B5 — Kubernetes current-vs-desired/reporting boundary

Source:
- https://kubernetes.io/docs/reference/node/kubelet-sync-loop/

Observed content:
- kubelet reconciles desired Pod specification with actual/current running-container state;
- API-visible status may lag instant runtime reality because status is produced through polling/event mechanisms.

Carries:
- strong digital holdout for:
  `actual runtime condition ≠ desired specification ≠ reported/API-visible status`;
- evidence that a live Domain-State question cannot be reduced to a status Record.

Limitation:
- Kubernetes itself is one technical domain and does not define universal State decomposition.

### B6 — National Academies digital twins

Sources:
- https://www.ncbi.nlm.nih.gov/books/NBK605515/
- https://www.ncbi.nlm.nih.gov/sites/books/NBK605499/
- https://www.ncbi.nlm.nih.gov/books/NBK605502/

Observed content:
- digital twins use virtual information constructs that mimic structure/context/behavior of a real counterpart;
- virtual representations are fit-for-purpose and use selected parameters/states/quantities of interest;
- real/physical counterpart and virtual representation remain distinct.

Carries:
- reality/model boundary;
- evidence that state-variable selection/granularity is representation-purpose dependent;
- caution against treating a model's `state` dimensions as intrinsic child regions of reality.

### B7 — AI state-space / Markov sufficiency

Sources:
- Poole & Mackworth 3e State Spaces: https://www.cs.ubc.ca/~poole/aibook/3e/html/ArtInt3e.Ch3.S2.html
- Sequential Probability Models: https://www.cs.ubc.ca/~poole/aibook/3e/html/ArtInt3e.Ch9.S6.html

Observed content:
- a modeled state contains the information needed to predict action effects and evaluate goals in a state-space problem;
- under a Markov model, state carries the history information relevant to the future.

Carries:
- `state sufficiency` is tied to a reasoning/modeling purpose and assumptions;
- strong warning against promoting granularity/sufficiency as an intrinsic reality child.

### B8 — Transition systems / invariants / constraints

Sources:
- Stanford transition-system/invariant work: https://theory.stanford.edu/~sipma/papers/svmcai05.pdf
- MIT Underactuated notes on state/input constraints: https://underactuated.csail.mit.edu/intro.html

Observed content:
- invariants are assertions that hold over reachable states;
- constraints limit admissible state/input regions or trajectories.

Carries:
- evidence that constraints/invariants are generally predicates/limits **over** state and transitions rather than the current state itself;
- supports cross-cutting treatment at this level.

### B9 — Identity / persistence

Source:
- Stanford Encyclopedia of Philosophy, `Identity Over Time`: https://plato.stanford.edu/entries/identity-time/

Observed content:
- persistence through change raises a distinct identity problem;
- accidental versus identity-ending change is a classic fault line.

Carries:
- identity/continuity must remain explicit;
- because the question inherently spans change/time and criteria vary by kind/domain, it is not safely localized as a State-only child.

### B10 — Properties, relations, facts / state-of-affairs counterframe

Sources:
- https://plato.stanford.edu/entries/properties/
- https://plato.stanford.edu/archives/fall2025/entries/relations/
- https://plato.stanford.edu/entries/facts/
- https://plato.stanford.edu/archives/spr2024/entries/states-of-affairs/

Observed content:
- properties can be attributed to objects;
- relations hold between objects;
- fact/state-of-affairs traditions can treat obtaining situations as involving objects plus properties/relations.

Carries:
- strong counterframe against automatically promoting `Constituents`, `Relations` and `Properties` into three universal project children merely because formal ontology distinguishes them;
- supports testing the more economical structure/composition + condition/status split.

Limitation:
- philosophical ontology is contested and solves a different problem from the project's research-routing hierarchy.

### B11 — Social / institutional reality

Sources:
- https://plato.stanford.edu/entries/social-institutions/index.html
- https://plato.stanford.edu/entries/social-institutions/

Observed content:
- institutions can be analyzed through structures of positions/roles/norms/relations;
- institutional facts/status functions can depend on collective rules/acceptance.

Carries:
- institutional cases can contain realized structural and status/standing questions;
- actual-versus-representation must not be overstated as metaphysical independence from all representation.

### B12 — Ecology holdout

Source:
- US EPA Ecological Condition: https://www.epa.gov/report-environment/ecological-condition

Observed content:
- ecological condition includes physical, chemical and biological characteristics;
- ecosystems include living and nonliving constituents and interactions/processes;
- boundaries can be scientifically/managerially selected.

Carries:
- non-engineered holdout for composition/constituents + current condition distinctions;
- reminder that domain vocabularies may bundle State and Dynamics differently.

### B13 — Market/business holdout

Sources:
- SEC Market Structure Analytics: https://www.sec.gov/featured-topics/market-structure-analytics
- SEC market-structure background: https://www.sec.gov/newsroom/speeches-statements/us-equity-market-structure

Observed content:
- market structure research examines fragmentation/venues/interconnection issues;
- market quality/condition uses measures such as liquidity, spreads, depth and volatility.

Carries:
- non-physical holdout distinguishing organization/structure from current condition/quality.

Limitations:
- financial-market-specific terminology; no claim that SEC defines the project hierarchy.

---

## C. Pass evidence trajectory

Early search produced meaningful structural information:
- `State / Configuration` should likely be shortened to `Domain State`;
- realized Structure/Composition and realized Condition/Status appeared to have distinct first-order questions/failures;
- actual-vs-represented state was a cross-ground boundary, not a child;
- identity, constraints and granularity appeared explicit but cross-cutting at this level.

Later cross-domain probes refined these boundaries rather than producing a third immediate child. Closure established:

```text
Domain State
    ├─ Domain Structure / Composition
    └─ Domain Condition / Status
```

Use the package `STATE.md`, `KEY.md`, synthesis and `CURRENT-SURFACES.md` for the current bounded result and authorization state.