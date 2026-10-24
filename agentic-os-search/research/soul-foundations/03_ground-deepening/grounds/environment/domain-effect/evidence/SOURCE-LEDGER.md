# Domain Reality — Source Ledger

**Status:** preserved source/view recovery ledger for the closed Domain Reality pass; not active work  
**Date:** 2026-09-02  
**Scope:** Environment → Domain Reality node, started under the label `Domain / Effect Reality`

> **Pass provenance:** This ledger preserves the evidence recovery used during the Domain Reality pass. Later Domain State refinement does not retroactively rewrite this pass evidence. Current hierarchy/status is in `../STATE.md`, `../KEY.md`, and `../domain-state/STATE.md`.

### Exact pass-input snapshot

For historical reconstruction, the Environment parent state **immediately before the Domain Reality pass began** is content-addressed by the Environment `CURRENT-SURFACES.md` blob:

- pass-input manifest blob: `d5dd0bd7f4c3663d5d41b71b7f616f83ad229456`
- containing commit: `223de2c5f710f5a1ce5968147682f10f3bff5f02`

Interpretation:
- the relative paths below are **current navigation paths** to the corresponding evidence families;
- the blob above is the **exact historical parent snapshot** for reconstructing what was current when this pass was planned/entered;
- later edits to parent `STATE`/`KEY`/router files must not be mistaken for the pass-input state.

## Purpose

Track which source families carry which claims while keeping external taxonomies distinct from the project hierarchy.

No source independently validates the project's eventual child map. External material is used for discrimination, falsification and boundary tests.

---

## A. Project evidence

### A1 — Current Environment parent corpus at the time of this pass

Paths:
- `../../STATE.md`
- `../../KEY.md`
- `../../FINDINGS-MAP.md`
- `../../synthesis/ENVIRONMENT-GROUND-SYNTHESIS.md`
- parent findings 02–10 as relevant

Carries:
- Environment parent boundary;
- Domain/Effect vs Work-Condition role distinction;
- actual condition vs representation;
- dynamics/disturbance;
- actual effect vs Work closure;
- boundary/nesting/role switching;
- two-role parent result.

Limitation:
- `Domain / Effect Reality` was only identified at parent depth; its own immediate-child structure remained unresolved.

### A2 — Archived operating-world corpus

Paths:
- `../../../../../history/superseded/operating-world-environment/corpus/KEY.md`
- `../../../../../history/superseded/operating-world-environment/corpus/FINDINGS-MAP.md`
- routed boundary/state/actionability/reduction findings from that archived corpus

Carries:
- boundary-relative world/domain state;
- actual state vs observation/belief/Record;
- exogenous dynamics;
- actionability as relational;
- world-state reduction failure.

Limitation:
- historical and superseded for original fourth-vertical purpose; prior evidence only.

---

## B. External source families

### B1 — Cognitive Work Analysis / Work Domain Analysis

Representative sources:
- ScienceDirect Topics, `Work Domain Analysis`: https://www.sciencedirect.com/topics/computer-science/work-domain-analysis
- National Academies, *Human-System Integration in the System Development Process*, CWA table: https://www.nationalacademies.org/read/11893/chapter/9
- applied WDA examples recovered during search.

Observed content:
- work domain = physical and purposive constraints within which activity takes place;
- WDA is activity/actor independent;
- abstraction and decomposition are orthogonal dimensions;
- the same domain can be described at multiple abstraction levels;
- WDA does not itself describe tasks, strategies, actions or actors.

Carries:
- evidence that a domain problem exists separately from Work/activity;
- warning that purpose/function/object categories may be abstraction views rather than child problem regions;
- part-whole decomposition and abstraction are distinct axes.

Limitation:
- WDA often includes purpose/value semantics that this project's top-level Work/Information boundaries may place elsewhere; do not import its hierarchy wholesale.

### B2 — Systems engineering / SEBoK / NASA

Representative sources:
- SEBoK Operational Environment glossary: https://sebokwiki.org/wiki/Operational_Environment_(glossary)
- SEBoK Concepts of Systems Thinking: https://sebokwiki.org/wiki/Concepts_of_Systems_Thinking
- SEBoK Introduction to System Fundamentals: https://sebokwiki.org/wiki/Introduction_to_System_Fundamentals
- NASA Systems Engineering Handbook Appendix: https://www.nasa.gov/reference/system-engineering-handbook-appendix/
- NASA SE Fundamentals: https://www.nasa.gov/reference/2-0-fundamentals-of-systems-engineering/

Observed content:
- problems/opportunities exist in an operational environment relative to a system;
- state is a configuration/set of attributes at a time;
- behavior/dynamics concern change, response and effects;
- system structure concerns elements/relationships;
- measures of effectiveness/outcomes are distinct engineering evaluation concepts.

Carries:
- structure/state/behavior distinctions;
- outcome/effect vocabulary as behavior/result rather than a separate surrounding object class;
- reference/boundary discipline.

Limitation:
- system-centric and engineering-oriented; Domain Reality can also be natural, social or institutional and may not form one engineered system.

### B3 — Control and dynamical systems

Representative sources:
- Åström & Murray, *Feedback Systems*: https://www.cds.caltech.edu/~murray/books/AM08/pdf/fbs-public_25Jun20.pdf
- CaltechAUTHORS book record: https://authors.library.caltech.edu/records/yzs24-xsx88
- MIT Dynamic Systems and Control: https://dahleh.lids.mit.edu/lectures-on-dynamic-systems-and-control/

Observed content:
- dynamic systems evolve with time and are described through states, inputs, outputs and dynamics;
- disturbances can change trajectories;
- state estimation/observability are separated from actual process behavior;
- control actions influence a controlled process rather than becoming the process itself.

Carries:
- state/dynamics/transition grammar;
- action and disturbance as distinct sources of change;
- actual process vs estimate/model separation.

Limitation:
- mathematical system models are representations; project must not equate model variables with reality by identity.

### B4 — STAMP / systems-theoretic control

Representative source:
- Leveson/Thomas STPA Handbook: https://psas.scripts.mit.edu/home/get_file.php?name=STPA_handbook.pdf

Observed content:
- controller, controlled process, control action and feedback are separated;
- control actions affect the state of the controlled process;
- controller's process model is updated by feedback and can diverge from real process state;
- disturbances can affect the controlled process.

Carries:
- target/controlled-process framing as one useful Domain Reality case;
- actual state vs controller model;
- Work/action effect as process-state change, not proof of causal sufficiency.

Limitation:
- control-centric framing is too narrow for purely observational/diagnostic Work.

### B5 — Situation calculus / AI state-transition traditions

Representative sources:
- Stanford Encyclopedia of Philosophy, Logic-Based AI: https://plato.stanford.edu/archives/sum2026/entries/logic-ai/
- John McCarthy, `Actions and Other Events in Situation Calculus`: http://www-formal.stanford.edu/jmc/sitcalc.pdf
- Poole & Mackworth, State Spaces: https://www.cs.ubc.ca/~poole/aibook/3e/html/ArtInt3e.Ch3.S2.html

Observed content:
- world/situation states support truths about a world at a time;
- actions transform states;
- events other than agent actions can also change situations;
- state-transition formalisms separate current state, actions/events and resulting state.

Carries:
- evidence against treating `effect` as a separate reality region;
- effect can be represented as a transition/change in domain state associated with an action/event;
- exogenous/non-Work changes must remain possible.

Limitation:
- symbolic state-space assumptions are representation choices and may assume full observability/determinism in simpler formulations.

### B6 — Causal inference

Representative sources:
- Cambridge/PMC `Methods in causal inference. Part 3`: https://pmc.ncbi.nlm.nih.gov/articles/PMC11588564/
- Stanford STATS 361 notes: https://web.stanford.edu/~swager/stats361.pdf
- National Academies causal effect chapter: https://www.ncbi.nlm.nih.gov/books/NBK225543/
- Pearl, *Causality* source recovered in web search.

Observed content:
- causal effects are defined as contrasts between potential/counterfactual outcomes under different interventions/exposures;
- a causal effect is not simply a pre/post change in an observed unit;
- one potential outcome is counterfactual/unobserved for a given unit.

Carries:
- strong falsifier against `Effect Reality` as a self-contained actual-state child;
- actual resulting condition and causal attribution must remain distinct;
- causal effect semantics cross realized domain state with intervention/action and evidential/counterfactual assumptions.

Limitation:
- statistical causal-inference formalisms are not universal project architecture.

### B7 — Observation versus intervention in science

Representative source:
- `Intervention and experiment`: https://pmc.ncbi.nlm.nih.gov/articles/PMC11906572/

Observed content:
- scientific investigation can be genuinely non-interventionist;
- observation/natural experiments/model-based studies challenge the claim that intervention is constitutive of experiment/science.

Carries:
- Domain Reality must exist for Work that aims only to understand/assess and has no intended domain effect;
- `effect` cannot be a mandatory co-equal semantic part of every domain case.

### B8 — Systems modeling views / SysML

Representative sources:
- OMG SysML v1: https://www.omg.org/sysml/sysmlv1/
- OMG SysML v2: https://www.omg.org/sysml/sysmlv2/

Observed content:
- systems models distinguish structure, behavior, requirements and parametrics;
- structure uses blocks/parts/connectors; behavior uses activities/interactions/state machines.

Carries:
- structure and behavior are repeatedly useful distinct views;
- warning that a modeling-view taxonomy is not automatically a project research-child taxonomy.

### B9 — Formal ontology counterframe

Representative sources:
- BFO 2020: https://bfo-ontology.github.io/BFO-2020/
- BFO ontology repository definitions: https://github.com/BFO-ontology/BFO
- Laboratory for Applied Ontology DOLCE: https://www.loa.istc.cnr.it/index.php/dolce/

Observed content:
- BFO distinguishes continuants and occurrents;
- DOLCE distinguishes endurants, perdurants, qualities and abstracts;
- formal ontologies provide alternative top-level partitions of reality.

Carries:
- object/process and entity/event distinctions are real modeling/ontology concerns;
- disagreement in upper-ontology decompositions is evidence against importing one as the Domain Reality child tree without project-specific decision value.

Limitation:
- ontology engineering solves a different problem from this research hierarchy.

### B10 — Social / institutional reality

Representative sources:
- Stanford Encyclopedia of Philosophy, Social Ontology: https://plato.stanford.edu/entries/social-ontology/
- Social Institutions: https://plato.stanford.edu/entries/social-institutions/

Observed content:
- social/institutional facts can be real while being constituted or sustained through collective attitudes/rules/representational practices;
- social entities may have causal effects despite mind-/representation-dependence.

Carries:
- correction to an overly strong `actual reality must be representation-independent` formula;
- project distinction should be `actual institutional condition ≠ any particular observation/model/Record of it`, not universal ontological independence from representation.

Limitation:
- contested philosophical field; used to prevent false exclusion, not to settle project ontology.

### B11 — Digital twin reality/model distinction

Representative source:
- National Academies, *The Digital Twin Landscape*: https://www.ncbi.nlm.nih.gov/books/NBK605499/

Observed content:
- physical/real system state and quantities of interest are distinguished from virtual representation/model parameters;
- fit-for-purpose representation and uncertainty are emphasized.

Carries:
- reality/model distinction in an engineering lineage;
- purpose-relative selection of relevant state without equating selected representation with actual reality.

---

## C. Pass evidence trajectory

Early discriminators:
- `Domain / Effect` did not appear to be two self-contained reality regions;
- causal effect appeared relational/counterfactual while actual result was a domain condition/trajectory;
- structure/state/process/dynamics distinctions recurred, but external traditions treated them as different kinds of views/categories rather than converging on one child hierarchy;
- social/institutional cases required a more careful reality/representation boundary;
- observational Work showed that Domain Reality does not require intended intervention/effect.

These were pass-time discriminators under adversarial test. Closure established the bounded `Domain Reality → Domain State + Domain Dynamics / Processes` result; later Domain State refinement is routed from the current package surfaces.