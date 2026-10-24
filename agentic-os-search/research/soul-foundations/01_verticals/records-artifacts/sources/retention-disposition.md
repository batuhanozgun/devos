# Source Ledger — Records Retention / Appraisal / Disposition

**Pass:** retention / appraisal / disposition  
**Access date:** 2026-09-01  
**Status:** source ledger; not synthesis

## Source-selection rule

Use records-management/appraisal authorities to establish semantics of retention and final disposition. Jurisdiction-specific authority rules are evidence/counterexamples, not universal legal prescriptions for SOUL.

---

## 1. ISO 15489-1:2016 — Records management

Source:
- https://www.iso.org/standard/62542.html

Observed:
- records management includes creation, capture and management of records over time;
- records requirements and controls must be identified independently of storage form/technology.

Research use:
- retention/disposition belongs to records management rather than being reducible to storage garbage collection.

---

## 2. ISO/TR 21946:2018 — Appraisal for managing records

Sources:
- https://www.iso.org/standard/72274.html
- ISO committee overview for appraisal

Observed:
- appraisal analyses functions/context, identifies records requirements and uses risk to decide what records need creation/capture and how long they need to be retained;
- requirements derive from business, legal and societal needs and appraisal is recurrent as context changes.

Research use:
- retention is an appraisal outcome/requirement, not an intrinsic lifetime attached to file type;
- recurrence means retention classification/schedules can require re-appraisal.

---

## 3. NARA — Scheduling Records

Source:
- https://www.archives.gov/records-mgmt/scheduling/sch-records

Observed:
- every federal record in scope must be covered by approved disposition authority; unscheduled records are treated as permanent until scheduled;
- a schedule describes content/context and whether/when records may be destroyed or must be transferred for permanent preservation;
- `disposition` is final fate after current business use; temporary disposition leads to destruction, permanent disposition to transfer to the National Archives;
- a disposition instruction includes disposition class, cutoff/start condition and retention or transfer period;
- cutoff can be age-based or event-based (`case closed`, `superseded`, `obsolete`, etc.);
- vague `destroy when no longer needed` instructions risk both over-retention and premature destruction and are difficult to automate;
- schedule changes are required when record content/function/scope/format or disposition/retention decisions materially change.

Research use:
- strong semantic decomposition: eligibility trigger/cutoff + duration/condition + final action;
- `permanent` is a final-disposition category, not merely a large duration;
- rules/schedules themselves have applicability/supersession history.

---

## 4. NARA — Preparing Disposition Instructions

Source:
- https://www.archives.gov/records-mgmt/scheduling/instructions

Observed:
- final-disposition timing must be clear and not left to chance/interpretation;
- temporary records use a specific destruction period after age/cutoff/event;
- permanent records use explicit transfer instructions;
- lengthy retention is explicitly not equivalent to permanent status;
- event-based retention examples include completion, publication, supersession, revision/cancellation, audit, settlement.

Research use:
- retention is often a rule over events/conditions, not simply `created_at + N years`;
- transition semantics from Pass 4 can directly drive retention eligibility.

---

## 5. NARA — Scheduling/Appraisal FAQ and Record Values

Sources:
- https://www.archives.gov/records-mgmt/faqs/records-mgmt/faqs/scheduling-appraisal
- https://www.archives.gov/records-mgmt/scheduling/values
- https://www.archives.gov/records-mgmt/scheduling/appraisal

Observed:
- temporary records can require very long retention without becoming permanent;
- permanent records are selected for archival value, including evidence of rights, government actions and national experience;
- temporary disposal supports security/privacy, storage economy and searchability;
- retention for legal value can depend on duration of rights/commitments/risk, limitation periods, regulatory requirements, appeals and availability of equivalent information elsewhere.

Research use:
- `keep forever is safest` is false across privacy/security/search/cost and archival appraisal;
- value is multidimensional and can change required retention independently of format.

---

## 6. NARA — Implementing Schedules / Records Control Schedules

Sources:
- https://www.archives.gov/records-mgmt/scheduling/implementation
- https://www.archives.gov/records-mgmt/rcs

Observed:
- disposition authorities are mandatory in the federal scope;
- more recent authority can supersede older authority for the same records/system;
- temporary records should be disposed when their retention expires subject to exceptions;
- before implementing disposition, users must verify they are applying the current disposition authority.

Research use:
- retention/disposition policy is versioned/applicability-bound state;
- historical/current rule binding matters to automated disposition.

---

## 7. NARA — Freeze / hold semantics

Sources:
- https://www.archives.gov/frc/arcis/freeze-faq
- NARA 825 Holds on Operational Records

Observed:
- a freeze/hold temporarily suspends normal disposition because of legal, audit, investigative or reappraisal circumstances;
- affected records are not eligible for destruction while freeze/hold applies;
- normal disposition can resume when the hold/freeze is formally lifted;
- freeze can be scoped to particular series/accessions and may be created when reappraisal may change a schedule.

Research use:
- hold/freeze is an **eligibility override/constraint**, not record currentness or factual validity;
- retention eligibility needs exception state/history separate from underlying schedule.

---

## 8. NARA — Backup copies / electronic systems

Sources:
- General Records Schedule 3.2 / Transmittal 26 and older GRS 20 guidance
- https://www.archives.gov/files/records-mgmt/grs/grs-trs26.pdf
- https://www.archives.gov/records-mgmt/grs/faqs.html

Observed:
- backup copies can themselves be records but can have different disposition instructions from the master/source record;
- backups of permanent records can be temporary and deleted after replacement/transfer conditions are met;
- backup copies of temporary records can be deleted when source/backup replacement conditions are met;
- conversion source records can sometimes be destroyed after successful conversion/verification if they are not independently required and schedule permits it; source records with unique uncaptured information remain independently scheduled.

Research use:
- not every physical/logical copy/version requires identical retention duration;
- disposition must preserve required information/record function, not blindly mirror source policy across every duplicate;
- conversion/verification/significant-information capture affects whether source representation can be disposed.

---

## 9. National Archives of Australia — Compliant destruction

Source:
- https://www.naa.gov.au/information-management/disposing-information/information-disposal/compliant-destruction-australian-government-information

Observed:
- destruction must be authorised, irreversible/appropriate, secure, timely and documented;
- agencies should record what was destroyed, when, how and under which records authority;
- relevant contextual information about disposal should remain in endorsed systems;
- destruction decisions/reasons for longer retention should be documented;
- cloud contracts should require destruction of all copies under retention/disposal requirements;
- master control records containing metadata about destroyed information can themselves be retained as national archives.

Research use:
- payload destruction and destruction-history retention are independent;
- `destroy record` can require cross-copy/custody scope and residual evidentiary metadata;
- destruction is an event with provenance/authority/rule binding, not merely a missing object.

---

## 10. National Archives of Australia — Disposal freezes and retention notices

Source:
- https://www.naa.gov.au/information-management/disposing-information/disposal-freezes-and-retention-notices

Observed:
- relevant records can become temporarily non-destroyable despite ordinary disposal authority because of controversial issues, proceedings or compliance need;
- normal disposal permissions are suspended for the affected scope.

Research use:
- external override/hold is a separate disposition constraint state;
- retention schedule alone does not determine current destruction eligibility.

---

# Cross-source synthesis signals

A Records-side disposition decision can be decomposed into at least:

1. **appraisal / governing disposition classification** — temporary vs permanent/transfer or equivalent scoped result;
2. **applicable rule/authority identity + version/scope**;
3. **eligibility trigger/cutoff** — age or event/condition;
4. **retention/transfer period or additional condition**;
5. **override/hold/freeze state**;
6. **final action** — transfer/custody change, destruction, donation/other authorized action;
7. **execution evidence** — what happened, when/how, to what scope, under which rule;
8. **residual history/identity** where accountability/reconstruction requires it.

These are semantic responsibilities, not universal database fields.

The evidence also strongly rejects:

- `permanent = very long temporary`;
- `delete = hide/remove from current view`;
- `all copies share identical retention`;
- `schedule age alone decides eligibility`;
- `hold changes record content/currentness`;
- `destruction history must always disappear with payload`.