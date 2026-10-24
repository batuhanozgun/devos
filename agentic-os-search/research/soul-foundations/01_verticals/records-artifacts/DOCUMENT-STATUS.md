# Records — Document Status Manifest

**Document role:** CURRENT_STATUS_MANIFEST  
**Vertical revision:** `records-foundation-2026-09-01-r2`

This manifest answers a different question from `INDEX.md`:

> If a file is found directly, what epistemic/currentness role does it play?

## Status vocabulary

- **CURRENT** — preferred current derived result for its stated layer/topic.
- **HISTORICAL** — prior research-stage output retained for audit/history; not current conclusion.
- **SUPERSEDED** — prior derived view known to contain framing/terminology replaced by later work.
- **ADVERSARIAL_AUDIT** — challenge/countercheck against a synthesis; not independent verification and not the preferred positive result by itself.
- **EVIDENCE_TRACE** — source-reading ledger/retrieval aid; derived from sources and not a primary source.
- **PLAN** — research scope/return-condition history; not a research conclusion.
- **STATE** — current status/boundary/reopen gate; not a substantive evidence layer.
- **ROUTER** — navigation/currentness surface; not substantive evidence.

## Current surfaces

### STATE
- `STATE.md`

### ROUTER
- `README.md`
- `INDEX.md`
- `CURRENT-REVISION.md`
- `DOCUMENT-STATUS.md`

### CURRENT — L0 / L1 / L2
- `KEY.md` — L0
- `FINDINGS-MAP.md` — L1
- `synthesis/RECORDS-VERTICAL-SYNTHESIS.md` — L2 integrated vertical synthesis

### CURRENT — L3 topic results
- `synthesis/current/OBJECT-IDENTITY.md`
- `synthesis/current/PRESERVATION-CLOSURE.md`
- `synthesis/current/CHANGE-TIME-STANDING.md`
- `synthesis/current/ORGANISATION-RETRIEVAL.md`
- `synthesis/current/REQUIREMENT-DERIVATION.md`
- `synthesis/current/MECHANISM-LANDSCAPE.md`
- `synthesis/current/RETENTION-DISPOSITION.md`
- `synthesis/current/FAILURE-SURFACES.md`
- `synthesis/current/COMPLETENESS.md`

### CURRENT — bounded residual/boundary records
- `OPEN-QUESTIONS.md`
- `DEFERRED-RELATIONS.md`

## Historical / superseded positive syntheses

These paths now contain explicit stubs. The exact pre-revision content remains recoverable by the blob SHA recorded in each stub.

### HISTORICAL
- `FOUNDATIONAL-SYNTHESIS.md`
- `synthesis/OBJECT-BOUNDARIES.md`
- `synthesis/MINIMUM-ENVELOPE.md`
- `synthesis/CHANGE-STATUS-TEMPORAL-SEMANTICS.md`
- `synthesis/ORGANISATION-RETRIEVAL-SEMANTICS.md`
- `synthesis/REQUIREMENT-PROFILE-DERIVATION.md`
- `synthesis/MECHANISM-PATTERN-LANDSCAPE.md`
- `synthesis/RETENTION-DISPOSITION-SEMANTICS.md`

### SUPERSEDED
- `synthesis/CONCEPT-BOUNDARIES.md`
- `synthesis/FAILURE-MODES.md`

## Adversarial audit layer

Files matching the focused `*-COUNTERCHECK.md` pattern are **ADVERSARIAL_AUDIT** unless a file explicitly states otherwise.

Current examples include:
- `synthesis/ARTIFACT-COUNTERCHECK.md`
- `synthesis/MINIMUM-ENVELOPE-COUNTERCHECK.md`
- `synthesis/CHANGE-STATUS-TEMPORAL-COUNTERCHECK.md`
- `synthesis/ORGANISATION-RETRIEVAL-COUNTERCHECK.md`
- `synthesis/REQUIREMENT-PROFILE-COUNTERCHECK.md`
- `synthesis/MECHANISM-PATTERN-COUNTERCHECK.md`
- `synthesis/RETENTION-DISPOSITION-COUNTERCHECK.md`
- `synthesis/VERTICAL-COMPLETENESS-COUNTERCHECK.md`

These answer `how was this result challenged?`, not `what is the current positive result?`

## Evidence trace layer

- `SOURCES.md` — **EVIDENCE_TRACE for the foundational pass only**; it is not a vertical-wide consolidated source authority.
- `sources/*.md` — pass/topic-specific **EVIDENCE_TRACE** ledgers.
- `sources/README.md` — source-layer router.

A source ledger is not a primary source. For an exact/load-bearing claim, recover the primary URL/source named by the relevant ledger.

## Plan/history layer

Root files matching research-plan names such as `RESEARCH-PLAN.md`, `*-PLAN.md`, and the completeness plan are **PLAN** documents even when they say a pass was completed. They preserve scope, falsifiers and return conditions; they are not current findings.

## Direct-search rule

If search/retrieval lands on a file without first reading `INDEX.md`:

1. inspect the file's own `Document role` / `Status` header where present;
2. if the file is a historical/superseded stub, follow its current replacement;
3. if it is a countercheck, pair it with the corresponding current L3 topic result;
4. if it is a source ledger, do not treat it as synthesis or primary evidence;
5. if role remains ambiguous, return to `INDEX.md` rather than inferring currentness from filename/path alone.

## Currentness principle

Ease of retrieval does not increase authority. Historical and derived files can rank highly in search. Currentness is determined by this package's current revision/routing plus exact file role, not by recency-looking wording or search rank.