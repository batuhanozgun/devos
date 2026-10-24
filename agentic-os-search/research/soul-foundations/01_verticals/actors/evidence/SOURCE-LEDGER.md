# Actors — Source and Inspected-View Ledger

**Status:** current evidence-recovery surface  
**Purpose:** distinguish a source's existence from the exact source view actually inspected during this research.

## Reading rule

- `PRIMARY / AUTHORITATIVE` means the source is normative, official, author-hosted primary scholarship, or an authoritative institutional publication for the limited claim used.
- `SCHOLARLY SYNTHESIS` means the source is a current scholarly reference used to expose distinctions or controversy, not a binding standard.
- `VIEW LIMITATION` records where only an abstract, search-extracted text or later scholarly reproduction was inspected.
- A source appearing here does **not** mean every part of it was read. Only the listed view is evidence for this research.

## Ledger

| ID | Source | Status / version checked | Actually inspected | Supports | Material limitation |
|---|---|---|---|---|---|
| S01 | W3C PROV-DM, https://www.w3.org/TR/prov-dm/ | W3C Recommendation, 30 Apr 2013 | Recommendation web text; especially §§5.3.1–5.3.4 Agent, Attribution, Association, Delegation | agent identity vs activity association/role; attribution; activity-specific delegation; principal/delegate distinction | provenance model, not universal Actor ontology or moral/legal theory |
| S02 | IETF RFC 8693, https://datatracker.ietf.org/doc/html/rfc8693 | Standards Track RFC 8693 | RFC text; §1.1 delegation vs impersonation; subject/actor token semantics; `act`/`may_act` claim semantics | subject vs current actor; delegation vs impersonation; prospective authorization; delegation history | OAuth security semantics, not universal legal delegation |
| S03 | NIST SP 800-162 ABAC, https://csrc.nist.gov/pubs/sp/800/162/upd2/final | official NIST publication page; publication originally 2014 with current update surface reflecting later errata/updates | official CSRC publication page/abstract and previously exposed publication text describing subject/object/operation/environment attributes and policy | authorization is policy/context/attribute relation, not intrinsic subject property | access-control scope; no moral/legal responsibility claim |
| S04 | NIST Role Based Access Control FAQ, https://csrc.nist.gov/Projects/role-based-access-control/faqs | current NIST CSRC project surface | FAQ sections on user-role and permission-role assignment, session activation, static/dynamic separation of duty | identity ≠ role ≠ permission; assigned role ≠ active role; combinatorial authority constraints | technical access-control model, not general social ontology |
| S05 | Cornell LII Agency / Authority / Apparent Authority / Fiduciary Relationship, https://www.law.cornell.edu/wex/agency | Wex pages current as displayed; agency last reviewed Oct 2024, fiduciary relationship Nov 2025, principal Jan 2026 where shown | current web text plus Constitution Annotated agency/standing page quoting Restatement (Third) of Agency §1.01 | principal-agent/on-behalf-of; consent/control; actual/implied/apparent authority; third-party reliance; authority lifecycle | U.S. agency-law context; demonstrates non-collapse, not universal legal rule |
| S06 | UN CRPD Committee General Comment No. 1, CRPD/C/GC/1 | official OHCHR document, 2014 | official PDF; page containing paras 12–14 was opened and visually inspected; text lines also recovered | legal capacity/standing/legal agency ≠ mental capacity/decision-making skill | disability-rights legal doctrine used only as counterexample to semantic collapse of `capacity` |
| S07 | UNCITRAL Model Law on Automated Contracting with Guide to Enactment, https://uncitral.un.org/en/mlac | Model Law adopted 11 Jul 2024; current official UNCITRAL publication/search surface | official UNCITRAL page and official search-extracted Article 7 / Guide text; later direct PDF reopen returned 403 | automated action ≠ legal attribution; attribution may follow agreed procedure or fallback to person using system | **VIEW LIMITATION:** no later page-level PDF screenshot; claims restricted to official exposed text |
| S08 | Christian List, `Three Kinds of Collective Attitudes`, https://personal.lse.ac.uk/list/PDF-files/CollectiveAttitudes.pdf | author-hosted LSE PDF | PDF text plus page-level screenshots for aggregate/common/corporate distinction and organizational generation discussion | not every collection is group agent; corporate attitudes can diverge from member majority; organization/decision procedure matters | philosophical theory used as discriminating frame, not imposed ontology |
| S09 | Stanford Encyclopedia of Philosophy, Shared Agency, https://plato.stanford.edu/entries/shared-agency/ | current web entry surface; page reports substantive revision 1 May 2017 | sections contrasting mere aggregation with shared action and discussing participatory intentions / supra-individual subject debate | shared/joint action ≠ mere aggregation; shared action need not entail separate enduring group agent | scholarly synthesis of contested literature |
| S10 | Stanford Encyclopedia of Philosophy, Collective Responsibility, https://plato.stanford.edu/entries/collective-responsibility/ | substantive revision 19 Dec 2022 | current web entry | collective responsibility distinct from locating all responsibility in discrete individuals; group and member responsibility can coexist | philosophical moral-responsibility scope |
| S11 | Stanford Encyclopedia of Philosophy, Moral Responsibility, https://plato.stanford.edu/entries/moral-responsibility/ | substantive revision 3 Jun 2024 | current/recent entry sections separating obligation sense and causal vs moral responsibility | causal contribution ≠ moral responsibility; responsibility word is polysemous | moral philosophy, not universal institutional rule |
| S12 | Stanford Encyclopedia of Philosophy, Epistemic Condition for Moral Responsibility, https://plato.stanford.edu/entries/moral-responsibility-epistemic/ | web entry, substantive revision 4 Oct 2022 as displayed | current web text | control/freedom and epistemic/knowledge conditions can matter to responsibility | used only to show responsibility can depend on conditions beyond role/causation |
| S13 | Stanford Encyclopedia of Philosophy, Action, https://plato.stanford.edu/entries/action/ | current/recent web entry surface | section on intentional omissions/refraining | agency can be expressed through meaningful non-action; positive event-only frame has counterexamples | ontology of omissions remains contested |
| S14 | Stanford Encyclopedia of Philosophy, Moral Responsibility and Alternative Possibilities, https://plato.stanford.edu/entries/alternative-possibilities/ | web entry/archived surface inspected | section on responsibility for omissions | responsibility can concern failures to act and depends on available alternatives/capability in some theories | no specific alternative-possibilities doctrine adopted |
| S15 | Mark Bovens, `Analysing and Assessing Accountability: A Conceptual Framework`, European Law Journal (2007), DOI 10.1111/j.1468-0386.2007.00378.x | foundational scholarly source identified; later Oxford/Wiley scholarly surfaces inspected | actor–forum definition and virtue/mechanism distinction as reproduced/discussed in later scholarly publication views | accountability as actor–forum relation/process, not intrinsic property | **VIEW LIMITATION:** complete 2007 publisher text not inspected; do not infer beyond the exposed formulation |
| S16 | Hollnagel & Woods / Woods on Cognitive Systems Engineering and joint human-machine systems | historical scholarly publications | publisher abstract for `Cognitive Systems Engineering: New wine in new bottles`; accessible text for Woods discussion of joint human-machine cognitive systems | coupled human-machine system can sometimes be a useful operational analysis unit | **VIEW LIMITATION:** not all full publisher texts inspected; supports analysis-unit proposition only |
| S17 | ISO/DIS 37303 / ISO 37301 competence definition, ISO Online Browsing Platform | current DIS page exposed current inherited definition | web definition: competence as ability to apply knowledge and skills to achieve intended results | competence/skill meaning differs from permission/authority/legal capacity | draft/standard terminology used only as semantic support, not adopted taxonomy |
| S18 | NIST trust relationship glossary, https://csrc.nist.gov/glossary/term/trust_relationship | current CSRC glossary | current glossary definitions and cited-source metadata | trust is itself a governed relation between domains/elements and can condition honoring authorizations | omission probe; maps to existing relation/authority family, not elevated to separate Actors primitive |

## Sources deliberately not promoted to load-bearing evidence

### Computational Actor Model descriptions

ACM and secondary scholarly descriptions were inspected to confirm that `actor` is also a message-passing/concurrency term in computing. The original 1973 source was not directly recovered in this pass.

Use:
- terminology-overload example only.

Not used to support:
- any normative or ontological Actor conclusion.

### Generic AI responsibility commentary

Several modern AI-responsibility sources were found. They were not needed to carry the main result because stronger source chains already establish operational action vs attribution, responsibility polysemy, authority, and collective/distributed distinctions.

## Source-recovery rule for later readers

1. Start from `KEY.md` or `FINDINGS-MAP.md` once present.
2. If a conclusion is decision-critical, read the relevant topic finding.
3. Use this ledger to identify the exact source/view actually inspected.
4. For a stronger or broader claim than the topic finding makes, reopen the primary source rather than extending the stored summary by inference.
5. A `VIEW LIMITATION` means the source should be re-recovered before making a claim that depends on unseen detail.
