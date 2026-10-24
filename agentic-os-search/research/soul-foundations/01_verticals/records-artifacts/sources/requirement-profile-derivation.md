# Source Ledger — Records Requirement Profile / Derivation

**Pass:** requirement-profile / derivation  
**Access date:** 2026-09-01  
**Status:** source ledger; not synthesis

## Source-selection rule

Use authoritative records-management, appraisal, system-requirements, preservation and metadata sources to test how requirements are derived and tailored. The pass does not copy any one standard as the universal profile.

---

## 1. ISO 15489-1:2016 — Records management: concepts and principles

Source:
- https://www.iso.org/standard/62542.html

Observed:
- ISO 15489 explicitly includes recurrent analysis of business context and identification of records requirements among the core concepts/principles.
- It applies regardless of record structure/form or technological environment and over time.

Research use:
- requirements are derived from context rather than from one storage/schema model;
- requirement identification is recurrent rather than a one-time immutable profile.

Limitation:
- public ISO preview exposes high-level scope, not the full detailed method.

---

## 2. ISO/TR 21946:2018 — Appraisal for managing records

Source:
- https://www.iso.org/standard/72274.html
- ISO committee summary: https://committee.iso.org/sites/tc46sc11/home/news/content-left-area/news-about-standarization-in-t-1/iso-tr-21946-appraisal-for-manag.html

Observed:
- appraisal establishes scope, analyses business functions/context, identifies records requirements, relates requirements to functions/work processes, and uses risk assessment for records decisions;
- the committee summary describes appraisal as evaluating activities to determine which records need creation/capture and how long they need to be kept;
- resulting requirements can arise from business needs, legal requirements and societal expectations;
- appraisal is recurrent because context, activities and risk change over time.

Research use:
- strongest direct support for context/risk-based requirement derivation and recurring re-appraisal;
- rejects reducing requirements to record type or retention horizon alone.

Vertical boundary:
- this pass uses business/activity context as an input to Records requirements but does not model Work itself.

---

## 3. ISO 16175-1:2020 and ISO/TS 16175-2:2020

Sources:
- https://www.iso.org/standard/74294.html
- https://www.iso.org/standard/74293.html

Observed:
- Part 1 gives model/high-level functional requirements for software applications that manage digital records, including business applications whose primary purpose is not records management;
- Part 2 guides decision making for selecting/designing/implementing/maintaining software according to ISO 15489 principles;
- Part 1 explicitly does not replace dedicated long-term-preservation requirements.

Research use:
- records requirements can be expressed independently of a dedicated records-management product;
- operational recordkeeping requirements and dedicated long-term preservation requirements overlap but are not identical;
- architecture selection should follow requirement understanding rather than define it.

---

## 4. ISO 23081-1:2017 / ISO 23081-2:2021 — Metadata for managing records

Sources:
- https://www.iso.org/standard/73172.html
- https://www.iso.org/standard/81600.html
- ISO committee overview: https://committee.iso.org/sites/tc46sc11/home/projects/published/iso-23081-metadata-for-records.html

Observed:
- records metadata principles apply to records, processes affecting them, systems in which they reside and organisations responsible for them;
- Part 2 supplies a framework for defining metadata elements and explicitly discusses decision points/options in implementation;
- committee guidance emphasizes defining metadata needed to interpret an electronic object in business/people context and to support integrity/authenticity/reliability/usability assertions.

Research use:
- `requirement` should describe information/semantic need before choosing its metadata representation;
- contextual and event/history requirements can cross object/system boundaries.

---

## 5. NARA Universal Electronic Records Management Requirements v3

Source:
- https://www.archives.gov/records-mgmt/policy/universalermrequirements

Observed:
- requirements are baseline high-level business needs and a **starting point** for agencies developing system requirements;
- agencies are expected to tailor final requirements with records-management and IT/procurement participation;
- requirements distinguish program vs system requirements and Must Have vs Should Have;
- sections cover capture, maintenance/use, disposal, transfer, metadata and reporting.

Research use:
- even a mature baseline requirement set is not treated as a context-free final implementation specification;
- requirement role/strength needs explicit classification;
- some Records obligations can be program/procedure responsibilities rather than system-local functions.

Vertical boundary:
- this pass can classify a requirement as requiring governance/authority elsewhere without designing that governance.

---

## 6. NARA — Metadata Requirements for Permanent Electronic Records

Source:
- https://www.archives.gov/records-mgmt/policy/metadata-compiled

Observed:
- NARA consolidates different metadata requirements for different permanent-record transfer contexts, including general transfer, digitization, audiovisual/cartographic materials and classified records;
- the source is actively maintained as regulations/guidance change.

Research use:
- one `permanent-record metadata` profile is still context-sensitive by record class/security/transfer case;
- legal/regulatory profile inputs can override a generic minimal profile.

---

## 7. National Archives of Australia — Building trust in the public record

Sources:
- https://www.naa.gov.au/information-management/information-management-policies/building-trust-public-record
- https://www.naa.gov.au/information-management/information-management-policies/building-trust-public-record/2-implement-fit-purpose-information-management-processes-practices-and-systems

Observed:
- `fit-for-purpose` information management depends on specific business needs, information type, value, stakeholders/users and special characteristics such as sensitivity;
- agencies differ in business responsibilities, resources, risk tolerances, capabilities and information environments;
- systems should meet identified information-management needs rather than one universal maximal requirement set;
- migration/decommissioning must consider future information need.

Research use:
- validates a multi-parameter profile input rather than a single risk or horizon score;
- stakeholder/reuse and sensitivity can materially change requirements.

---

## 8. National Archives of Australia — Business System Assessment Framework

Source:
- https://www.naa.gov.au/information-management/managing-information-assets/business-system-assessment-framework

Observed:
- risk-based assessment explicitly recognizes that records differ in value and risk;
- preliminary assessment determines whether full assessment is warranted from risk/value;
- functionality assessment covers trust/findability, accountable disposal, export/import and reporting;
- remedies can include functionality, system integration, export or governance/policy; response to gaps depends on risk tolerance.

Research use:
- requirement satisfaction is not equivalent to one software feature;
- assessment depth/control strength can be proportional to risk/value;
- a gap can be handled through different control locations, so derivation must separate obligation from mechanism.

---

## 9. National Archives of Australia — Minimum metadata set

Source:
- https://www.naa.gov.au/information-management/standards/australian-government-recordkeeping-metadata-standard/minimum-metadata-set

Observed:
- cumulative Core / Additional / Transfer levels vary with value and expected longevity;
- lower-value records can still require higher-level properties because of separate business/security requirements;
- transfer introduces additional rights/integrity requirements.

Research use:
- horizon/value are important but not dominant universal axes;
- independent constraints can activate otherwise non-core obligations;
- profile derivation needs additive/conditional rules rather than one linear maturity score.

---

## 10. OAIS Reference Model, CCSDS 650.0-M-3 (December 2024)

Source:
- https://ccsds.org/Pubs/650x0m3.pdf

Observed:
- OAIS targets information deemed to need Long Term Preservation for a Designated Community;
- Preservation Objectives must be specific, actionable and measurable;
- Designated Community, its Knowledge Base and Preservation Objectives can change over time;
- Preservation Planning applies approved standards/objectives to specific holdings/submissions and can require new AIP designs/strategies for uncovered submissions.

Research use:
- long-term Records/preservation requirements should be derived from intended future capability and assumed knowledge, then made testable;
- profiles require review when community/knowledge/objectives/environment changes;
- one archive may need different preservation treatment for different holdings.

Limitation:
- archival long-term frame; should not dominate short-lived operational records.

---

## 11. CCSDS 653.0-M-1 — Information Preparation to Enable Long-Term Use (IPELTU), December 2024

Source:
- https://ccsds.org/Pubs/653x0m1.pdf

Observed:
- captures/generates Additional Information across initiating, planning, executing and closing project phases rather than only at final archival transfer;
- information is updated from plans to what actually happened;
- captures potential uses, Designated Community/Knowledge Base, Representation Information, reference/provenance/context/fixity/rights/package/descriptive information and potential preservation risks;
- explicitly notes that Additional Information itself requires preservation/authenticity consideration.

Research use:
- requirements can emerge/refine over time and should be captured when knowledge is available;
- expected reuse and transformations influence what information must be collected;
- requirement derivation should include lifecycle triggers and re-appraisal, not only initial classification.

Limitation:
- project/long-term-use context is stronger than many ordinary operational-record contexts.

---

## 12. PREMIS 3 / Understanding PREMIS

Sources:
- https://www.loc.gov/standards/premis/v3/
- https://www.loc.gov/standards/premis/understanding-premis-rev2017.pdf
- https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf

Observed:
- PREMIS distinguishes Semantic Units (information a repository needs to know) from metadata elements (how it is recorded);
- repositories do not have to support every PREMIS entity type;
- a repository can know a required value by storage, mapping, registry reference, inference, default or other mechanism and still provide it when needed;
- conformance can be mapping/export/internal-schema based rather than requiring one internal representation.

Research use:
- obligation inclusion and satisfaction mechanism must be separate dimensions;
- `mandatory` does not imply object-local field;
- profiles should be able to say `required, satisfied externally/inherited/reconstructably`.

---

# Cross-source synthesis signals

Across these sources, requirement derivation repeatedly depends on combinations of:

- purpose/business/future use;
- record/resource type and structure;
- value and consequence/risk;
- legal/policy/societal/security constraints;
- retention horizon and environmental change;
- transfer/interoperability needs;
- transformation/preservation objectives;
- users/stakeholders/Designated Community and assumed knowledge;
- required trust, findability, disposal and reconstruction outcomes.

No source supports reducing all of these to one permanent universal profile or one scalar risk score.

Requirement **necessity**, **strength**, **satisfaction location**, and **verification method** appear to be separate decisions.