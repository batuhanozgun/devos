# Domain Dynamics Finding 04 — External Cross-Lineage Falsification

**Status:** active-pass finding  
**Stage:** D5

## Purpose

Challenge the candidate `Domain Dynamics` leaf result using source traditions that disagree in primitives, formalism and domain rather than looking for a taxonomy that merely confirms it.

## 1 — Hybrid dynamical systems

Goebel, Sanfelice and Teel's hybrid-systems framework models one hybrid system through flow sets/maps and jump sets/maps; purely continuous and purely discrete systems are special cases of the same framework.

Source:
- *Hybrid Dynamical Systems: Modeling, Stability, and Robustness*, Princeton University Press/Oxford Academic, 2012.
- https://academic.oup.com/princeton-scholarship-online/book/21191/chapter-abstract/180817352

Discriminator:
- continuous evolution versus discrete jump can matter operationally;
- nevertheless the formalism explicitly unifies both under one Dynamics object.

Result:
- weakens `Continuous Dynamics` versus `Discrete Events` as universal project children;
- supports retaining them as occurrence/modeling modes unless a domain-independent failure boundary later emerges.

## 2 — Process/event ontology counterframe

The Stanford Encyclopedia of Philosophy's *Process Philosophy* review documents multiple ways of carving dynamic reality: ongoing activities, developments, occurrences and technical senses of `process`; process philosophers disagree over categories and their relationships.

Source:
- Stanford Encyclopedia of Philosophy, *Process Philosophy*, substantive revision 2022.
- https://plato.stanford.edu/entries/process-philosophy/

Discriminator:
- process/event/activity/development distinctions are philosophically substantive;
- their taxonomic boundaries are not stable across theories.

Result:
- the project should preserve occurrence distinctions without importing one ontology as the hierarchy;
- `/ Processes` in the parent label is too privileged, supporting rename to `Domain Dynamics`.

## 3 — Stability, trajectories and hybrid occurrence

MIT Underactuated Robotics material treats limit cycles, fixed points, attraction and stability as properties of trajectories/return maps. Passive and kneed walking examples combine continuous pendulum dynamics with instantaneous collision events inside one gait dynamics.

Source:
- MIT Underactuated Robotics, *Simple Models of Walking and Running*.
- https://underactuated.mit.edu/simple_legs.html

Discriminator:
- stability/regime behavior is load-bearing;
- continuous phases and discrete impacts coexist in a single realized dynamic pattern.

Result:
- `Stability / Regime` is better treated as a Dynamics pattern/property than a child;
- continuous/discrete split remains non-universal.

## 4 — Markov sufficiency counterframe

Stanford CS234 defines a Markov information state as a sufficient statistic of history: future independence from the past is conditional on the chosen present State being sufficient.

Source:
- Emma Brunskill, Stanford CS234 Reinforcement Learning, Lecture 2, Spring 2024, slide on Markov property.
- https://web.stanford.edu/class/cs234/CS234Spr2024/slides/lecture2pre.pdf

Discriminator:
- some apparent history dependence can disappear if relevant current state is expanded;
- therefore history/path dependence cannot be promoted merely because a selected representation omits a variable.

Result:
- `History / Path Dependence` stays an explicit Dynamics dependency question rather than an automatic child.

## 5 — Hysteresis / regime-change counterframe

Ecological literature demonstrates feedback-mediated alternative regimes and abrupt shifts produced by coupled ongoing processes. The same literature connects nonlinear feedback, community dynamics and regime behavior rather than requiring separate process/event reality branches.

Sources:
- Scheffer et al., *Catastrophic shifts in ecosystems*, Nature 2001. https://www.nature.com/articles/35098000
- Bush et al., *Oxic-anoxic regime shifts mediated by feedbacks between biogeochemical processes and microbial community dynamics*, Nature Communications 2017. https://www.nature.com/articles/s41467-017-00912-x

Discriminator:
- gradual processes, feedback and abrupt transition can form one coupled dynamics;
- path dependence/hysteresis can be genuinely reality-side rather than only representational.

Result:
- falsifies any universal assumption that sufficient current State always erases history;
- does not force history, feedback or regime change into separate children.

## 6 — Actual versus represented Dynamics

NIST defines a digital twin as a dynamic, data-driven virtual representation that must connect/synchronize with its physical counterpart.

Source:
- NIST, *Digital Twins — Essential Elements*.
- https://www.nist.gov/digital-twins/essential-elements

Discriminator:
- dynamic representation and counterpart can be tightly synchronized without becoming identical.

Result:
- reinforces `actual Domain Dynamics ≠ model/simulation/twin/forecast`.

## 7 — Control / software-system holdout

Current Kubernetes controller documentation describes non-terminating control loops that observe current state, act toward desired state and operate while the cluster may be changing continuously and may never reach a stable state.

Source:
- Kubernetes Documentation, *Controllers*.
- https://kubernetes.io/docs/concepts/architecture/controller/

Discriminator:
- Work/control action and Domain change can be coupled but are analytically separable;
- a changing system can continue beyond one bounded Work item.

Result:
- supports `Domain Dynamics ≠ Work lifecycle` while preserving Work-coupled transitions as relations.

## 8 — Causal attribution counterframe

Hernán and Robins define causal effects through contrasts among potential/counterfactual outcomes under alternative treatment values; for an individual, only one corresponding outcome is observed.

Source:
- Hernán & Robins, *Causal Inference: What If*, 2024 edition.
- https://www.hsph.harvard.edu/miguel-hernan/wp-content/uploads/sites/1268/2024/04/hernanrobins_WhatIf_26apr24.pdf

Discriminator:
- observing a temporal transition does not itself establish the counterfactual contrast needed for causal effect.

Result:
- `actual change ≠ causal attribution` remains a strong boundary.

## 9 — Institutional/social dynamics counterframe

The Stanford Encyclopedia of Philosophy review of social institutions describes competing accounts in which institutions can be created/maintained through collective acceptance, constitutive or regulative rules, and performative acts.

Source:
- Stanford Encyclopedia of Philosophy, *Social Institutions*, current entry.
- https://plato.stanford.edu/entries/social-institutions/

Discriminator:
- realized institutional change can depend on rule-mediated collective practices;
- the real change is not identical to one textual representation, while Actor authority/collective attitudes remain separately analyzable.

Result:
- social/institutional cases do not break the Dynamics node, but they forbid defining `actual` as metaphysical independence from all representation or collective practice.

## Cross-lineage verdict

No tested lineage produced a stable universal first-order child partition that both:
- survives continuous/discrete/hybrid cases;
- survives process/event ontology disagreement;
- survives history-sufficient and hysteretic cases;
- preserves State/Work/Information/Actors/causality boundaries.

External evidence therefore supports the **bounded leaf** result more strongly than any specific child split. It does not independently validate the project's exact hierarchy.

## Source-quality note

A current SEBoK behavior/dynamics surface was not used as load-bearing independent evidence because it explicitly acknowledges OpenAI drafting support. Its existence may be useful for navigation, but it would weaken independence for this project purpose.
