# Work — Source Ledger

## Role

Claim-to-source recovery ledger for the independent Work vertical.

This ledger records both the **source** and the **view actually inspected**. Publisher abstracts, bibliographic records and search/retrieval views are not treated as equivalent to a full primary source.

### View grades

- **A — primary/authoritative full or normative view inspected:** full paper/specification/standard/handbook content or authoritative full HTML sufficient for the claim.
- **B — primary publication abstract / institutional publication record inspected:** only claims directly supported by that view are carried forward.
- **C — bibliographic/context view only:** corroborating context; never sole load-bearing evidence.

## Sources

### S01 — OMG CMMN overview
- **Source:** Object Management Group, *Case Management Model and Notation (CMMN)*.
- **URL:** https://www.omg.org/cmmn/
- **View:** A, authoritative standards-body overview.
- **Supports:** unpredictable activity order; evolving situations; event-centered/adaptive case work.

### S02 — OMG CMMN 1.0 specification
- **Source:** Object Management Group, *Case Management Model and Notation, Version 1.0*, formal/2014-05-05.
- **URL:** https://www.omg.org/spec/CMMN/1.0/PDF
- **View:** A, normative PDF; planning/discretionary-item, applicability, sentry and lifecycle sections inspected with rendered pages.
- **Supports:** possible/discretionary work versus runtime-planned work; applicability; requiredness; Available/Enabled/Disabled/Active/Suspended/Failed/Completed/Terminated distinctions; event/criterion-driven transitions.
- **Caution:** existence proof for distinctions, not a proposed universal SOUL state machine.

### S03 — Declarative process management / ConDec
- **Source:** Maja Pesic & Wil M. P. van der Aalst (2006), *A Declarative Approach for Flexible Business Processes Management*.
- **DOI:** 10.1007/11837862_18
- **URL:** https://link.springer.com/chapter/10.1007/11837862_18
- **View:** B, publisher abstract.
- **Supports:** imperative over-specification risk; declarative constraints can specify what must hold without prescribing one route.

### S04 — Hierarchical Task-Network planning
- **Source:** Kutluhan Erol, Dana Nau & James Hendler (1993), *Toward a General Framework for Hierarchical Task-Network Planning (Extended Abstract)*.
- **URL:** https://cdn.aaai.org/Symposia/Spring/1993/SS-93-03/SS93-03-005.pdf
- **View:** A, full primary PDF plus rendered pages.
- **Supports:** task versus goal-like achievement expressions; task networks; partial order; methods as alternative refinements.

### S05 — Coordination theory
- **Source:** Thomas W. Malone & Kevin Crowston (1994), *The Interdisciplinary Study of Coordination*, ACM Computing Surveys 26(1), 87–119.
- **DOI:** 10.1145/174666.174668
- **Primary PDF:** https://crowston.syr.edu/sites/default/files/acmcs94.pdf
- **View:** A, full paper plus rendered dependency tables/pages.
- **Supports:** coordination as dependency management; shared resources; prerequisite/producer-consumer; simultaneity; task/subtask; sequencing/tracking/scheduling/synchronization.

### S06 — Object-centric process mining
- **Source:** Wil M. P. van der Aalst (2019), *Object-Centric Process Mining: Dealing with Divergence and Convergence in Event Data*.
- **DOI:** 10.1007/978-3-030-30446-1_1
- **URL:** https://link.springer.com/chapter/10.1007/978-3-030-30446-1_1
- **View:** B, publisher abstract.
- **Supports:** multiple candidate case identifiers; events related to multiple cases; information loss/disconnected views caused by flattening.

### S07 — Work-as-Imagined / Work-as-Done
- **Source:** Erik Hollnagel & Robyn Clay-Williams (2022), *Work-as-imagined and work-as-done*.
- **DOI:** 10.4324/9781003109945-52
- **Institutional record:** https://researchers.mq.edu.au/en/publications/work-as-imagined-and-work-as-done/
- **View:** B, institutional abstract/publication record.
- **Supports:** planned/expected work versus actual work; gap is not automatically evidence that actual work should be forced to match imagined work.

### S08 — Activity theory and work analysis
- **Source:** Yrjö Engeström (2000), *Activity theory as a framework for analyzing and redesigning work*, Ergonomics 43(7), 960–974.
- **DOI:** 10.1080/001401300409143
- **URL:** https://pubmed.ncbi.nlm.nih.gov/10929830/
- **View:** B, primary abstract via PubMed.
- **Supports:** short-lived goal-directed actions versus durable object-oriented activity systems; alternative unit of analysis.

### S09 — Articulation work / CSCW
- **Source:** Kjeld Schmidt & Liam Bannon (1992), *Taking CSCW Seriously: Supporting Articulation Work*.
- **DOI:** 10.1007/BF00752449
- **URL:** https://link.springer.com/article/10.1007/BF00752449
- **View:** B, publisher abstract.
- **Supports:** articulation/coordination work as a real requirement of cooperative work.

### S10 — Little's Law
- **Source:** John D. C. Little (1961), *A Proof for the Queuing Formula: L = λW*, Operations Research 9(3), 383–387.
- **DOI:** 10.1287/opre.9.3.383
- **URL:** https://pubsonline.informs.org/doi/10.1287/opre.9.3.383
- **View:** B/A for theorem statement and assumptions through publisher view.
- **Supports:** system-level relation among average number in system, arrival/throughput rate and time in system under stated assumptions.
- **Caution:** does not itself prescribe WIP policy or prioritization.

### S11 — Sagas / compensation
- **Source:** Hector Garcia-Molina & Kenneth Salem (1987), *Sagas*, SIGMOD '87, 249–259.
- **DOI:** 10.1145/38713.38742
- **Primary PDF:** https://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf
- **View:** A, full primary PDF plus rendered pages.
- **Supports:** long-running partial effects; compensating transactions; compensation not necessarily exact restoration; recovery after partial execution.
- **Caution:** database mechanism used as a counterexample for recovery semantics, not a general Work implementation proposal.

### S12 — NASA Systems Engineering Handbook appendix
- **Source:** NASA, *Systems Engineering Handbook: Appendix*.
- **URL:** https://www.nasa.gov/reference/system-engineering-handbook-appendix/
- **View:** A, authoritative handbook sections.
- **Supports:** distinction among verification, validation, acceptance testing and certification/readiness activities.

### S13 — PMI current project definition
- **Source:** Project Management Institute, *What is a Project, Examples and the Project Lifecycle*.
- **URL:** https://www.pmi.org/about/what-is-a-project
- **View:** A, current authoritative overview.
- **Supports:** project as temporary endeavor for a unique result; bounded project regime.

### S14 — PMI project / operations contrast
- **Source:** PMI learning-library article, *The organizational cube*, quoting PMBOK definitions.
- **URL:** https://www.pmi.org/learning/library/design-sustainability-project-management-office-1406
- **View:** B, PMI-hosted secondary/older-standard quotation.
- **Supports:** stable bounded-project versus ongoing/repetitive-operations contrast only.
- **Freshness caution:** exact wording is not treated as current normative terminology.

### S15 — PMI Practice Standard for Scheduling, Second Edition
- **Source:** Project Management Institute (2011), *Practice Standard for Scheduling — Second Edition*.
- **URL:** https://www.pmi.org/-/media/pmi/documents/public/pdf/certifications/practice-standard-scheduling.pdf
- **View:** A, full PDF plus rendered pages.
- **Supports:** progressive elaboration; effort/work as labor units distinct from duration; duration-percent-complete can diverge from work effort; level-of-effort activities that support other work rather than directly producing the terminal result.
- **Freshness caution:** older edition used only for stable conceptual distinctions, not current compliance requirements.

### S16 — Situated action context
- **Source:** Lucy A. Suchman (1987), *Plans and Situated Actions: The Problem of Human-Machine Communication*.
- **ACM record:** https://dl.acm.org/doi/abs/10.5555/38407
- **View:** C, bibliographic/publisher context only.
- **Supports:** background for plan-versus-situated-action framing; no load-bearing claim depends solely on it.

### S17 — Interruptions and task transitions
- **Source:** Sophie Leroy, Aaron M. Schmidt & Nora Madjar (2020), *Interruptions and Task Transitions: Understanding Their Characteristics, Processes, and Consequences*.
- **DOI:** 10.5465/annals.2017.0146
- **URL:** https://doi.org/10.5465/annals.2017.0146
- **View:** B, publisher abstract.
- **Supports:** interruptions/task transitions as work phenomena linked to goal systems and cognitive/performance consequences.

### S18 — Interruption changeover time
- **Source:** Itai Gurvich, Kevin J. O'Leary, Lu Wang & Jan A. Van Mieghem (2020), *Collaboration, Interruptions, and Changeover Times: Workflow Model and Empirical Study of Hospitalist Charting*.
- **DOI:** 10.1287/msom.2019.0771
- **URL:** https://pubsonline.informs.org/doi/10.1287/msom.2019.0771
- **View:** B, publisher abstract.
- **Supports:** collaborative task switching can create measurable changeover/resumption costs.

### S19 — Official Kanban Guide
- **Source:** Kanban University / Mauvius Group, *The Official Kanban Guide* (2022 PDF).
- **URL:** https://kanban.university/wp-content/uploads/2023/04/The-Official-Kanban-Guide_A4.pdf
- **View:** A, full PDF plus rendered pages.
- **Supports:** options before commitment; vetting against urgency/capacity; commitment point; pull when capacity is available; WIP/flow distinctions; classes of service.
- **Caution:** existence proof for demand/commitment/flow distinctions, not a universal Work method prescription.

### S20 — PMI Standard for Portfolio Management, Third Edition
- **Source:** Project Management Institute (2013), *The Standard for Portfolio Management — Third Edition*.
- **URL:** https://www.pmi.org/-/media/pmi/documents/public/pdf/certifications/standard-for-portfolio-management-third-edition.pdf
- **View:** A, full PDF plus rendered sections.
- **Supports:** candidate/proposed components; evaluation, selection, prioritization, authorization and resource allocation; competition for scarce resources; distinction from execution.
- **Freshness caution:** newer edition exists; used only for stable conceptual distinctions, not current compliance requirements.

### S21 — ISO maintenance terminology
- **Source:** ISO Online Browsing Platform, maintenance terms in ISO/TR 12489 drawing on ISO/IEC terminology.
- **URL:** https://www.iso.org/obp/ui?_escaped_fragment_=iso%3Astd%3Aiso%3Atr%3A12489%3Aed-1%3Av1%3Aen
- **View:** A, authoritative terminology page.
- **Supports:** preventive maintenance at intervals/criteria and corrective maintenance after fault detection; retain/restore required function.
- **Countercheck result:** maps to continuing/recurring/triggered Work and recovery; no new first-order Work dimension required.

### S22 — Workflow Patterns
- **Source:** Wil M. P. van der Aalst, Arthur H. M. ter Hofstede, Bartek Kiepuszewski & Alistair P. Barros, *Workflow Patterns*.
- **Primary author-hosted PDF:** https://www.vdaalst.com/publications/p108.pdf
- **View:** A, full primary PDF plus rendered page inspection.
- **Supports:** control-flow pattern families including branching/synchronization, structural patterns, multiple concurrent instances, temporal relations, state-based patterns, cancellation and inter-workflow synchronization; also explicitly separates control-flow, data, resource and operational perspectives.
- **Countercheck result:** classic imperative workflow complexity maps to already identified structure/concurrency/time/state/cancellation/coordination axes; it did not expose a missing first-order Work dimension.

### S23 — Work design: interdependence and autonomy
- **Source:** B. Sebastian Reiche (2023), *Between interdependence and autonomy: Toward a typology of work design modes in the new world of work*, Human Resource Management Journal.
- **DOI:** 10.1111/1748-8583.12495
- **URL:** https://onlinelibrary.wiley.com/doi/full/10.1111/1748-8583.12495
- **View:** A, full publisher HTML inspected.
- **Supports:** work design spans tasks, activities, relationships and responsibilities at task/process/organization levels; interdependence and autonomy are distinct work-design dimensions; work may be emergent/social/self-initiated.
- **Countercheck result:** interdependence is already first-order in the Work findings; autonomy/discretion reinforces adaptive-control distinctions but its holder, authority and accountability are Actors/cross-vertical questions rather than a new isolated Work dimension.

### S24 — ASQ Plan-Do-Check-Act cycle
- **Source:** American Society for Quality, *What is the Plan-Do-Check-Act (PDCA) Cycle?*
- **URL:** https://asq.org/quality-resources/pdca-cycle
- **View:** A, current authoritative professional-body HTML.
- **Supports:** repeated plan → do → check → act cycle; results/learning feed subsequent action and replanning.
- **Countercheck result:** feedback-loop framing reinforces plan/execution/evaluation/adaptation as a coupled cycle but does not require a distinct first-order Work dimension beyond the existing axes.

### S25 — NASA closed-loop process assessment
- **Source:** NASA Software Engineering Handbook, *SWE-204 — Process Assessments*.
- **URL:** https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695538/SWE-204%2B-%2BProcess%2BAssessments
- **View:** A, authoritative current handbook HTML.
- **Supports:** identify/analyze non-conformance, assess root/contributing causes, implement corrective action, verify effectiveness through follow-up; closed-loop process connects failure, corrective work and verification.
- **Countercheck result:** monitoring/feedback generates evaluation and corrective/recovery work already represented by the current Work frame rather than a separate new axis.

## Claim-level recovery map

| Finding | Primary / authoritative anchors |
|---|---|
| Task is not equivalent to purpose or method | S04, S08 |
| Hierarchical/alternative decomposition and partial order | S04 |
| Single task/item is not universal analysis unit | S04, S05, S08, S10 |
| Single-case flattening can distort multi-context work | S06 |
| Bounded versus ongoing Work regimes | S08, S13, S14 |
| Work definition/plan can evolve during execution | S01, S15 |
| Plan/prescription differs from actual situated work | S07; S16 contextual only |
| Fixed imperative flow is not universal | S01, S03 |
| Dependencies/coordination/articulation are first-order | S05, S09 |
| Concurrency/synchronization/partial order matter | S04, S05, S22 |
| Interruptions/resumption create work effects | S17, S18, S02 |
| System-level flow/capacity observables differ from item state | S10, S19 |
| Lifecycle semantics exceed todo/doing/done | S02, S22 |
| Completion, verification, validation and acceptance differ | S02, S12 |
| Termination, rollback, compensation, retry/recovery differ | S02, S11, S22 |
| Failure can generate new recovery work | S02, S11, S25 |
| Effort/work quantity differs from duration and elapsed/waiting time | S15 |
| Support/enabling activity can be Work without directly creating terminal deliverable | S05, S09, S15 |
| Candidate work differs from committed/in-progress work | S02, S19, S20 |
| Selection/prioritization/resource admission differ from execution | S19, S20 |
| Priority is contextual/relational under scarcity | S19, S20 |
| Maintenance/recurrence fits existing boundedness/trigger/recovery axes | S21 with S02/S08/S14 |
| Work-design autonomy does not collapse into interdependence | S23 |
| Feedback/control-loop framing composes existing planning, execution, evaluation, adaptation and recovery axes | S24, S25 with S01/S07/S12 |

## Evidence limits

- This is interdisciplinary foundations research, not a statistical meta-analysis of all scholarship on work.
- Foundational older sources are used where the relevant distinction is stable; age is explicitly separated from current normative/compliance status.
- Several sources were inspected only through primary publisher/institutional abstracts; claims from them are bounded accordingly.
- Standards, formal models and professional methods are used as **existence proofs for distinctions and failure modes**, not as evidence that SOUL should implement them.
- Source fidelity does not imply source infallibility; where possible, important conclusions are supported across more than one tradition.
- The final omission/red-team pass is a **same-model adversarial self-review**, not independent verification.
