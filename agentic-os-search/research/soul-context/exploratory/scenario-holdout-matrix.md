# SOUL Research Dimension Holdout — external scenario families

**Status:** first external/domain holdout complete; not proof of completeness  
**Date:** 2026-08-30

## Purpose

Challenge the D1–D10 research-dimension map with domains that were **not** used to derive the KEEL/SOUL historical failure taxonomy.

The aim is not to import these domains' process architectures into SOUL. Authoritative domain guidance is used as a **problem/property holdout**:

- What important work properties exist here?
- Can D1–D10 represent them without software-development language?
- Does the holdout expose a missing dimension or force a dimension to change?

## Source-fidelity boundary

These sources are standards/guidance/prior art for their domains, not empirical proof that their prescribed mechanisms are optimal and not evidence that SOUL should copy them.

They may support:
- existence/materiality of a problem class,
- domain vocabulary and lifecycle properties,
- explicit distinctions such as authority, uncertainty or temporal replanning.

They do **not** by themselves prove:
- a SOUL mechanism,
- causal effectiveness in LLM agents,
- generalisation across domains,
- architectural necessity of a particular role/process.

# Holdout S1 — Analytical decision support under uncertainty

## External source

NASA Systems Engineering Handbook web guidance, **6.8 Decision Analysis**.  
Source: `https://www.nasa.gov/reference/6-8-decision-analysis/`  
Accessed: 2026-08-30.

## Domain properties observed

NASA's decision-analysis guidance treats analysis as support to a distinct decision authority. It begins by understanding the decision in mission/system context and intended outcome, then defining decision criteria, identifying alternatives, selecting methods/tools, evaluating alternatives and their uncertainties, and reporting recommendations/assumptions/limitations to the decision maker.

Two properties are especially relevant to SOUL Research:

1. **Rigor is decision/risk dependent.** Not all decisions justify the same amount of analysis.
2. **Uncertainty reduction has a value-of-information boundary.** More analysis is warranted when uncertainty could credibly change the ranking/decision and when reducing it is worth the schedule/resource cost.

NASA also distinguishes decision-maker preferences/values from technical analysis supporting the choice.

## D1–D10 coverage

- D1: intended outcome, decision definition, criteria and preferences.
- D4: explicit decision authority and value/preference boundary.
- D5: evidence, assumptions, uncertainty, sensitivity, documented rationale.
- D10: risk-proportional analysis depth and choice of next analytical work.
- D2: task-specific decision-analysis methods are capabilities that may need to be derived/assembled rather than hard-coded into core.

## Did it force a new dimension?

**No, provisionally.**

A tempting addition is `decision analysis / trade-off reasoning` as a new core dimension. That would likely confuse a **task-specific capability family** with a stable system property. D2 must be able to derive such a capability when the user outcome is a decision; D1/D4/D5/D10 supply the cross-cutting system obligations around it.

This judgement is falsifiable: if multiple materially different domains show that alternative-evaluation/trade-off synthesis requires invariant architecture properties not expressible through D1/D2/D4/D5/D10, the dimension set must reopen.

## Holdout lesson for research stopping

A stronger research-stopping question is:

> Could plausible reduction of this uncertainty change the downstream ranking/work/design decision enough to justify the cost/delay of collecting more evidence?

This is better than source-count or vague saturation alone.

---

# Holdout S2 — Open-ended evidence synthesis / systematic research

## External sources

Cochrane Handbook for Systematic Reviews of Interventions, current **Chapter 4: Searching for and selecting studies**, version 6.5.1 / chapter last updated March 2025.  
Source: `https://training.cochrane.org/handbook/current/chapter-04`  
Accessed: 2026-08-30.

PRISMA 2020 official site for reporting-systematic-review structure.  
Source: `https://www.prisma-statement.org/prisma-2020`  
Accessed: 2026-08-30.

## Domain properties observed

Cochrane separates studies from their potentially multiple reports, requires planned/comprehensive searching and documentation, and explicitly treats search development as iterative.

Its stopping discussion is useful precisely because it is **not** a universal rule:

- new-term searches may stop when they yield no new relevant records;
- relative recall/citation searching can probe completeness;
- sparse evidence calls for more caution;
- qualitative synthesis may use saturation-style reasoning;
- complex review types may have different completeness priorities;
- stopping reasons should be documented;
- even formally described stopping approaches have limited evaluation evidence.

PRISMA is reporting guidance rather than a search-completeness oracle; it supports transparent record of why a review was done, what methods were used and what results were found.

## D1–D10 coverage

- D1: explicit research question / eligibility boundary.
- D3: source identity vs representation (`study` versus multiple reports), retrieval, completeness and freshness.
- D5: provenance, method transparency, evidence selection, uncertainty/limitations.
- D8: reconstructable search/selection trace.
- D10: iterative search work, stopping and rerun/update decisions.
- D9: methods/stopping rules vary by review type, challenging one fixed workflow.

## Did it force a new dimension?

**No.**

It instead invalidates a simplistic global stopping rule. Research completion must be **question/method/risk dependent**. `No new sources appeared` can be evidence in one method but is not a universal completion condition.

## Holdout lesson for research package design

The research package needs to preserve enough source-level trace to distinguish:

- source/study/entity from multiple representations/reports;
- searched space from retrieved subset;
- excluded evidence from never-observed evidence;
- stopping justification from a claim of objective completeness.

This strengthens D3/D5 and the F-AR-011 omission-awareness lesson.

---

# Holdout S3 — Dynamic incident/operations work

## External sources

NIST SP 800-61 Rev. 3, **Incident Response Recommendations and Considerations for Cybersecurity Risk Management**, final April 2025.  
Source landing page: `https://csrc.nist.gov/pubs/sp/800/61/r3/final`  
NIST project overview: `https://csrc.nist.gov/projects/incident-response`  
Accessed: 2026-08-30.

FEMA National Incident Management System / Incident Action Planning guidance and current NIMS resource-management materials.  
Representative sources:
- `https://emilms.fema.gov/is_822/groups/410.html`
- `https://www.usfa.fema.gov/a-z/nims/managing-resources.html`
Accessed: 2026-08-30.

## Domain properties observed

NIST's current incident-response model explicitly moved away from an older, more isolated circular response model because modern incidents can be frequent, broad, complex and dynamic. Incident response is integrated across organizational risk-management activity; lessons may need to be propagated before final recovery and continuous improvement is emphasized.

FEMA incident action planning is organized around ongoing situational awareness and repeated operational periods:

1. understand current situation,
2. establish incident objectives,
3. develop the plan,
4. prepare/disseminate,
5. execute, evaluate and revise.

Objectives and resource assignments are valid for an operational period; changing conditions can require shorter planning horizons. Plans are made using the best information currently available rather than waiting indefinitely for future information. Resource state, assignments, times and locations are tracked through deployment and demobilization.

## D1–D10 coverage

- D1: current incident objectives and priorities.
- D3: changing external information/state, freshness and operational validity.
- D4: command/delegation/authority and resource responsibility.
- D6: failure/incident state, response, containment and recovery.
- D7: lessons/improvement while and after work proceeds.
- D8: situational/resource/status observability.
- D10: repeated plan → execute → evaluate → revise; work/resource selection under time pressure.
- D9: domain-specific tactics are not stable-core architecture.

## Did it force a new dimension?

**Not yet, but it forced D3 and D10 to widen.**

The first D3 wording was overly repository/context-centric. Dynamic operations require a distinction between:

- durable institutional/project state,
- currently observed **external-world state**,
- freshness/validity horizon of observations,
- assumptions used by the current plan.

D10 must likewise include **replanning when external state invalidates assumptions**, not only sequencing a static backlog.

A separate `environment sensing / temporal adaptation` dimension is **not yet justified**. The current evidence can be represented by widened D3 + D10 + D6/D8. If another materially different operational domain reveals important external-state properties that still do not fit, a new dimension should be added rather than forcing the fit.

---

# Holdout matrix summary

| Holdout | Main stress on D1–D10 | Missing dimension? | Revision forced |
|---|---|---|---|
| S1 analytical decision support | D1/D4/D5/D10; uncertainty and decision authority | no, provisional | strengthen value-of-information stopping rule |
| S2 systematic evidence synthesis | D3/D5/D8/D10; completeness and method-specific stopping | no | reject one universal stopping/saturation rule; strengthen source-coverage trace |
| S3 dynamic incident/operations | D3/D6/D7/D8/D10; changing world state and replanning | candidate only | widen D3 to external-state freshness; widen D10 to assumption-triggered replanning |

# What the holdout does and does not establish

## Established at this stage

- The ten dimensions can represent important properties in three materially different work families without importing their domain workflows into SOUL core.
- Stage-2 D10 is independently supported outside software-development history: decision-analysis depth selection and incident operational replanning both require explicit work-selection/lifecycle reasoning.
- Research stopping cannot be one fixed source-count/saturation rule. It depends on decision sensitivity, evidence method, risk, uncertainty and cost.
- External-world freshness is a real generality challenge to an internally focused state/context model.

## Not established

- D1–D10 are complete.
- Any listed domain process is causally optimal.
- These three families are sufficient evidence of SOUL generality.
- The same control mechanism should implement a property across domains.
- A research line is complete merely because one authoritative domain source maps cleanly to the taxonomy.

# Revised provisional stopping principle

For decision-oriented SOUL Research, a useful default is now:

> Continue while a material uncertainty remains for which plausible additional evidence could change the authorised next-work/design decision enough to justify the evidence-collection cost and delay. Stop or defer when the remaining uncertainty is decision-insensitive at the required risk level, when the research method's own completeness/stopping tests are satisfied, or when the unresolved uncertainty requires a different method/phase rather than more of the same search.

Every package should document the **stopping rationale and residual uncertainty**; it should not claim universal completeness unless the method actually supports such a claim.

# Next challenge

Before freezing D1–D10:

1. revise D3/D10 wording to include external-state freshness and assumption-triggered replanning;
2. classify which subquestions must be answered **before Phase 1–3** versus later architecture/evaluation phases;
3. run an omission red-team: which important property in S1–S3 was only made to fit by broad wording?
4. decide whether a fourth holdout family is needed to escape a remaining hidden `knowledge work / incident management` frame.