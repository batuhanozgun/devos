# Top-Level Adequacy Rerun — Q4 Materially Different Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Test whether the four-ground result is overfit to software/agentic/system-design cases by using materially different external domains.

These holdouts are not taxonomy authority. They are counterexample sources.

Selection criteria:

- materially different domain/problem culture;
- authoritative or primary institutional source where possible;
- enough structure to expose actual reality, representations, purposeful activity and parties/authority if those distinctions matter;
- preference for cases that pressure the strongest fifth-ground candidates: goals, governance, resources/actionability, stakeholders and learning/evolution.

## 2. Holdout A — Scientific measurement / metrology

### Sources

BIPM/JCGM VIM current web entries:

- measurement: https://jcgm.bipm.org/vim/en/2.1.html
- measurement procedure: https://jcgm.bipm.org/vim/en/2.6.html
- measurement result: https://jcgm.bipm.org/vim/en/2.9.html

### Relevant source structure

VIM distinguishes:

- **measurement** as an experimental process of obtaining values attributable to a quantity;
- a **measurement procedure** as a detailed description enabling an operator to perform the measurement, based on a method/model and including calculation needed to obtain a result;
- a **measurement result** as values attributed to the measurand together with relevant information, commonly including uncertainty.

It also explicitly ties measurement to measurement conditions and a measuring system.

### Four-ground stress mapping

- **Environment:** actual quantity/measurand and realized measurement conditions/system state relevant to the physical or experimental situation;
- **Information:** measurement result, uncertainty, model and documented procedure representation;
- **Work:** the deliberate measurement process/procedure and calculations performed to obtain a result;
- **Actors:** operator/organizational or institutional roles where performance, authorization or attribution matters.

### What this falsifies

A pure `Information` account is insufficient because the result is attributed to a measurand and can be uncertain/wrong relative to reality.

A pure `Work` account is insufficient because the measurement procedure is not the result or the measurand.

### Fifth-ground pressure

`Measurement` does not need a peer ground. It is a domain-specific composition of Work acting under Environment conditions to produce Information about a referent, with Actor roles as needed.

### Verdict

**Four-ground compatible; no missing peer exposed.**

## 3. Holdout B — Emergency / incident management

### Sources

FEMA / USFA NIMS current guidance and training surfaces:

- NIMS overview: https://www.usfa.fema.gov/a-z/nims/
- resource management: https://www.usfa.fema.gov/a-z/nims/resource-management.html
- incident planning training surfaces under `emilms.fema.gov`, including establishment of incident objectives, situational awareness, delegations of authority, planning, work assignments, resource requirements, execution/evaluation/revision.

### Relevant source structure

Current FEMA material distinguishes at least:

- the changing **incident situation** and resource availability;
- **situational awareness** information and reports;
- **incident objectives**, planning, strategies/tactics and work assignments;
- command/general-staff roles, delegations of authority and resource responsibility;
- resources/capabilities that must be acquired, mobilized, tracked and demobilized.

### Four-ground stress mapping

- **Environment:** actual incident state, hazards, operational conditions and realized resource availability;
- **Information:** situational awareness, plans, reports, maps and resource/status information;
- **Work:** objectives translated into planning, assignments, tactics, execution, evaluation and revision;
- **Actors:** Incident Commander, Unified Coordination Group, section chiefs, personnel, agencies and delegated authority/roles.

### Strong fifth-ground pressure — Goal / Governance

Incident objectives are explicitly high importance and authority-laden. Yet they do not form an isolated peer ontology:

- authorized leaders establish objectives → Actors;
- objectives direct planning/action → Work;
- objectives are informed by situation awareness → Information;
- objectives seek changes/stabilization in the actual incident → Environment.

Similarly, chain of command and delegation do not require a generic Governance ground when role/authority, Work and operational conditions remain separated.

### Verdict

**Four-ground compatible.**

The case strongly supports later relation/control research but does not force Goal or Governance as fifth peer grounds.

## 4. Holdout C — Health care / patient safety and learning systems

### Sources

World Health Organization:

- Patient safety topic/fact sheet;
- Patient Safety Incident Reporting and Learning Systems guidance;
- WHO patient-safety reporting/learning programme pages.

Representative current surfaces:

- https://www.who.int/health-topics/patient-safety/
- https://www.who.int/teams/integrated-health-services/patient-safety/research/incident-reporting-and-learning-systems
- https://www.who.int/publications-detail-redirect/9789240010338

### Relevant source structure

WHO describes patient safety as requiring organized activities, policies, leadership capacity, data, skilled health workers, technologies/environments, and patient/family involvement.

Its incident-reporting guidance warns that report data have strengths and limitations and that conclusions must be drawn cautiously; the purpose is learning that reduces future risk/harm.

### Four-ground stress mapping

- **Environment:** actual patient/clinical/system condition and actual harm/safety state;
- **Information:** incident reports, patient-safety data, analyses, learning artifacts and uncertainty/limitations of reports;
- **Work:** care delivery, incident investigation, risk-reduction activity, process redesign and improvement work;
- **Actors:** health workers, organizational leaders, patients/families, reporting/oversight roles and affected parties.

### Strong fifth-ground pressure — Stakeholders / Learning / Safety

Patients and families can be affected/rights-bearing parties without performing the relevant Work. The accepted Actors formulation already supports semantically relevant non-performing parties/positions.

Safety and learning also cross the frame:

```text
actual harm/safety condition      → Environment
incident/report/analysis          → Information
investigation/improvement         → Work
responsibility/participation      → Actors
feedback loop                     → relation/transition composition
```

A `Safety`, `Stakeholders` or `Learning` peer ground is not forced.

### Verdict

**Four-ground compatible.**

The distinction between actual harm and incident-report information is especially strong evidence for retaining Environment vs Information.

## 5. Holdout D — High-governance AI risk management

### Sources

NIST AI Risk Management Framework current AIRC/NIST surfaces:

- https://airc.nist.gov/airmf-resources/airmf/
- https://airc.nist.gov/airmf-resources/airmf/5-sec-core/
- https://www.nist.gov/itl/ai-risk-management-framework

Current note: AI RMF 1.0 is being revised; this holdout uses the currently exposed Core structure only as a conceptual counterexample, not as a frozen future standard.

### Relevant source structure

NIST's Core uses `Govern`, `Map`, `Measure`, and `Manage`, with Govern explicitly cross-cutting. The material distinguishes:

- organizational policies/processes/accountability structures and roles;
- mapping/context and affected parties;
- measurement/testing/evaluation and documentation;
- management, monitoring, incident response, recovery and continual improvement;
- actual and intended performance in deployed contexts.

### Four-ground stress mapping

The NIST function names are **not** imported as Foundation grounds.

Under the current frame:

- **Environment:** actual deployed context, system behavior/performance and operating risk conditions;
- **Information:** risk documentation, measurements, reports, evidence and monitored results;
- **Work:** map/measure/manage/govern activities, testing, review, incident response and continual-improvement pursuits;
- **Actors:** organizational roles, responsibility, governing authorities, partners/users/affected communities and accountability.

### Strong fifth-ground pressure — Governance / Risk

NIST itself treats governance as cross-cutting across risk-management activity rather than as an isolated object population. This does not prove the SOUL decomposition, but it is a useful independent counterexample to assuming that governance must be a peer ground.

`Risk` likewise links potential Environment consequences, Information estimates/evidence, Actor values/affected parties and Work prioritization/control.

### Verdict

**Four-ground compatible; Governance/Risk remain cross-ground under this holdout.**

## 6. Cross-holdout comparison

| Domain | Actual reality pressure | Information pressure | Work pressure | Actor/party pressure | Fifth-ground result |
|---|---|---|---|---|---|
| Scientific measurement | measurand / conditions | result / uncertainty / model | measurement procedure/process | operator/role where relevant | none |
| Emergency management | incident / hazards / resources | situational awareness / plans / reports | objectives→planning→execution→revision | command/delegation/teams | none |
| Patient safety | patient/system/harm condition | incident reports/data/learning | care/investigation/improvement | clinicians/leaders/patients/families | none |
| AI risk management | deployed system/context/risk effects | measurement/documentation/evidence | map/measure/manage/govern work | roles/accountability/affected parties | none |

The domains are materially different enough that the same mapping cannot be explained merely by software terminology reuse.

## 7. Holdout pressure on the strongest Q1 candidates

### Goal / Value

Emergency objectives, clinical safety goals and AI intended-purpose/risk tolerances are load-bearing, but repeatedly decompose into Actor value/authority + Information criteria + Work direction + Environment result.

### Governance / Control

FEMA command/delegation, WHO policy/leadership and NIST Govern all demonstrate governance importance. None requires collapsing normative authority, documented policy, control activity and realized enforcement into one peer semantic locus.

### Stakeholders / affected parties

WHO patients/families and NIST affected communities strengthen the Actors naming warning, but remain typed bearer/stake positions rather than a distinct ground.

### Learning / evolution

WHO reporting→learning→improvement and NIST monitoring→response→continual improvement instantiate multi-ground feedback loops rather than a fifth Evolution ground.

### Capability / resources

FEMA resource management reinforces the separation between available resources/conditions (Environment), people/credentials/roles (Actors), assignments/planning (Work), and tracking/reporting (Information).

## 8. External-search stopping judgment

Q4 opened a targeted external holdout search because the rerun needed material domain diversity after the ground-deepening work.

The selected authoritative sources produced **boundary reinforcement and relation pressure**, not a live missing-ground hypothesis.

Additional broad domain search would now be expected mainly to add examples and vocabulary unless Q5 generates a specific rival/falsifier requiring discrimination.

## 9. Verification limit

These sources do **not** independently validate the project's exact four-ground synthesis.

This is still same-researcher cross-domain mapping. The value of the holdouts is that they provide materially different structures against which the project frame can fail.

No independent second-researcher/model replication has been performed.

## 10. Q4 verdict

> **The four-ground frame survives materially different scientific, emergency-management, healthcare/patient-safety and governance-heavy AI holdouts.**

No tested holdout forces a fifth peer ground or a top-level merge/split.

The strongest remaining challenge is not omission but **rival decomposition**: perhaps a different four/five-ground frame explains the same cases more cleanly.

## 11. Next

Q5 — adversarial rival top-level decompositions.
