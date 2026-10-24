# Environment Hierarchy Refinement — Source Ledger

**Status:** evidence/source recovery for `findings/08-environment-parent-hierarchy.md`, `09-environment-parent-boundary-leak-check.md`, and `10-agent-control-counterframe.md`  
**Date:** 2026-09-02

## Purpose

Recover the load-bearing evidence used to test whether Operating World / Work Domain and Technical Work Environment should be peer top-level grounds or lower branches of one broader environmental ground.

This ledger records source roles and limitations. It is not architecture authority.

## Internal first-party research packages

### Archived operating-world Environment synthesis

Path:
- `../../history/superseded/operating-world-environment/corpus/synthesis/ENVIRONMENT-VERTICAL-SYNTHESIS.md`

Load-bearing use:
- boundary-relative actual world state is distinct from observation/belief/Record/Work state;
- tools/resources/infrastructure are boundary-dependent roles;
- runtime/technical and physical/social/domain environments were tested for a first-order split and the archived pass found no split required at that abstraction level;
- context is not synonymous with environment.

Limitation:
- this corpus was superseded only for the intended fourth-vertical question; it remains historical evidence for the operating-world problem but is not automatically the completed new foundation.

### Archived finding on tools/runtime/infrastructure

Path:
- `../../history/superseded/operating-world-environment/corpus/findings/05-tools-runtime-infrastructure-are-boundary-roles.md`

Load-bearing use:
- technical runtime/support and physical/domain conditions share abstract boundary/state/interface/resource/constraint grammar;
- concrete tools/resources can switch role with analytical boundary;
- strong technical/domain object partition was rejected.

### Current Technical Work Environment synthesis

Path:
- `../../01_verticals/work-environment/synthesis/WORK-ENVIRONMENT-VERTICAL-SYNTHESIS.md`

Load-bearing use:
- Technical Work Environment is a bounded realized technical support context, not a tool list;
- support boundary, actual state, capability exposure, configuration, identity/equivalence, lifecycle, readiness, sharedness/isolation and observability are stable productive semantics;
- realized environment is primary; profile is optional;
- representation can later be relational/compositional without erasing the problem.

Limitation:
- independently scoped to technical work support; does not decide its top-level relation to a broader environment ground.

## External / cross-lineage sources

### NIST CSRC glossary — Enabling System

Source:
- https://csrc.nist.gov/glossary/term/enabling_system

Underlying source:
- ISO/IEC/IEEE 15288:2015 through NIST SP 800-160.

Observed definition/use:
- an enabling system supports life-cycle activities associated with a system-of-interest;
- it does not necessarily contribute directly during operation;
- it need not exist in the system-of-interest's operational environment.

Load-bearing implication:
- a development/test/support system is not universally a subtype of the product/system's operational environment;
- `Technical Work Environment ⊂ Operating World` is therefore too strong as a universal relation.

Source strength:
- strong authoritative terminology relay; direct NIST glossary with ISO/IEC/IEEE source attribution.

### NIST SP 800-160 / system constructs

Source:
- NIST SP 800-160, foundational system-related constructs, accessible through NIST publication/search surfaces.

Observed use:
- distinguishes system-of-interest, enabling systems and other systems in the operational environment;
- examples of enabling systems include modeling/design tools, test harnesses, training tools, compilers and fabrication systems.

Load-bearing implication:
- operational-world systems and support/enabling systems are distinct roles around a focal system/lifecycle;
- they can nevertheless be considered together at a wider context level.

### NASA Systems Engineering Handbook — Appendix / ConOps

Source:
- https://www.nasa.gov/reference/system-engineering-handbook-appendix/

Observed structure:
- ConOps outline separately includes `Physical Environment` and `Support Environment`;
- operational environment is the environment in which the final product operates;
- support environment covers how the envisioned system is supported after fielding.

Load-bearing implication:
- physical/operational and support conditions are separable lower concerns but belong in one wider description of the system-in-context.

Limitation:
- NASA lifecycle/product framing is not a universal ontology for all Work.

### SEBoK — System Context

Source:
- https://sebokwiki.org/wiki/System_Context_(glossary)
- https://sebokwiki.org/wiki/Introduction_to_System_Fundamentals

Observed use:
- system context describes system relationships and environment around a selected system-of-interest;
- wider open-system relationships and external elements are analyzed relative to a boundary.

Load-bearing implication:
- supports a wider parent/context level above specific operational/support relations;
- also reinforces that reference point/boundary is essential.

Limitation:
- `context` in systems engineering differs from broad context-aware-computing usage; term should not be imported unqualified.

### Cognitive Work Analysis / Work Domain Analysis

Sources inspected:
- Sanderson, `Cognitive Work Analysis` overview surfaced via ScienceDirect Topics;
- applied CWA/WDA healthcare and safety literature;
- work-domain descriptions in peer-reviewed/open abstracts.

Observed use:
- work domain described as physical and purposive constraints within which activity takes place;
- WDA is event/actor-independent and precedes activity, organizational and worker-competency analyses;
- some applications describe work environment broadly through physical, organizational, resource and technical constraints.

Load-bearing implication:
- supports a broad environmental/work-domain stratum distinct from activity/actor analysis;
- warns against collapsing Work or Actors into Environment.

Limitation:
- CWA terminology sometimes uses `work domain`, `work environment` and `work ecology` at overlapping levels; exact vocabulary is framework-specific.

### Work System Theory — Alter

Source:
- Steven Alter, `Work System Theory: Overview of Core Concepts, Extensions, and Challenges for the Future`, JAIS 2013.
- Related 2013 Work System Theory material describing the nine-element framework.

Observed structure:
- processes/activities, participants, information and technologies are treated as core work-system elements;
- environment, infrastructure and strategies are distinguished around the work system;
- customers/products-services can cross boundaries.

Load-bearing implication:
- supports multiple distinct environmental/enabling concerns around Work;
- argues against one undifferentiated `Environment = everything` bucket;
- also shows boundaries and role relations can cross simple inside/outside classification.

### SEIPS / sociotechnical work-system models

Sources inspected:
- Holden et al., `SEIPS 2.0: A human factors framework for studying and improving the work of healthcare professionals and patients`, Ergonomics 2013, open via PMC;
- `SEIPS 101 and seven simple SEIPS tools`, BMJ Quality & Safety / PMC;
- Carayon et al. work-system/patient-safety material.

Observed structure:
- SEIPS 2.0 distinguishes person(s), tasks, tools/technologies, organization, internal environment and external environment;
- SEIPS 101 simplifies to people, environments, tools and tasks, with environment including physical, socio-organizational and external aspects.

Load-bearing implication:
- environmental, tool, actor, task and organization semantics can be analytically distinct and interacting;
- therefore the project parent cannot be an exclusive bucket that absorbs tools, Actors or Work;
- a higher parent is viable only if lower distinctions/roles remain explicit.

Limitation:
- SEIPS is a sociotechnical work-system framework, not evidence for the project's exact hierarchy.

### Activity Theory

Sources inspected:
- University of Warwick Institute for Employment Research overview of Activity Theory in work contexts;
- peer-reviewed/open Activity Theory applications and reviews.

Observed structure:
- subject performs activity toward an object/outcome;
- tools/instruments mediate subject-object interaction;
- rules, community and division of labour provide social/organizational mediation.

Load-bearing implication:
- independently preserves **object/target** versus **tool/mediation** distinction;
- provides a strong analogue to Operating World/Work Domain versus Work-Support Environment;
- also reinforces that Actor/community/rules/work organization cannot be swallowed into a generic Environment bucket.

Limitation:
- Activity Theory's `object` can include motive/problem-space semantics and is not identical to the project's Work Domain term.

### ILO Human Factors and Ergonomics

Source:
- https://www.ilo.org/ergonomics

Observed structure:
- work systems include humans, tasks, tools/technologies, organization and work environment;
- physical, cognitive and psychosocial factors interact.

Load-bearing implication:
- lower-level work-environment/tool distinctions remain meaningful even if a higher environmental parent is used.

### Agent / PEAS traditions

Sources inspected:
- Berkeley CS188 introductory agent material;
- Poole & Mackworth, `Artificial Intelligence: Foundations of Computational Agents` online text;
- AIMA-derived teaching material.

Observed structure:
- agent is distinguished from environment/world;
- sensing/perception and action/actuation connect the agent and environment;
- PEAS explicitly distinguishes performance, environment, actuators and sensors.

Load-bearing implication:
- rejects `sensor/actuator/tool = Environment object` as a universal identity;
- technical support mechanisms may sit inside the agent/working system or mediate its world interaction;
- the project merge therefore must remain a higher problem-ground/role synthesis, not an architecture component rule.

### STAMP / control structure

Source:
- STAMP Institute `About STAMP` terminology and control-loop explanation.

Observed structure:
- controller, controlled process, process model, control actions and feedback are distinct;
- controller model can differ from true process/environment state.

Load-bearing implication:
- reinforces target/process reality versus technical control/observation mechanisms and representations;
- rejects collapsing actual world, support mechanism and representation into one lower construct;
- does not by itself determine whether they share a higher project research parent.

### Dey & Abowd — Context

Source:
- Georgia Tech technical report `Towards a Better Understanding of Context and Context-Awareness` (1999/2000), accessible through Georgia Tech publication pages.

Observed definition:
- context is any information usable to characterize the situation of an entity.

Load-bearing implication:
- `Context` is too broad/representation-oriented to serve safely as the preferred parent label because it can include identity, activity, device, location, time and social information and therefore swallow Actors, Work and Information.

Limitation:
- context definitions are field-specific and contested; used here as a counterexample to label breadth, not as universal context theory.

## Evidence synthesis discipline

No single external source validates the project's proposed four-broad-ground map.

The inference arises from convergence plus counterexamples:

- systems engineering strongly rejects a universal `support environment = operational environment` identity but supports sibling operational/enabling relations around a wider focal system/lifecycle;
- archived/internal and CWA evidence supports a common higher-order situated/environmental grammar;
- Work System Theory, SEIPS, Activity Theory and HFE preserve lower target/tool/person/task/organization distinctions;
- agent/control traditions reject turning sensing/acting/support mechanisms into `environment` by component identity;
- context literature warns that `Context` is too broad as the parent term.

Therefore the current hierarchy result is an evidence-backed project synthesis, not an externally established taxonomy.
