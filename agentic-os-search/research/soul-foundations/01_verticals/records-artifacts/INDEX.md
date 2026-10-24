# Records / Persistent Information — INDEX

**Document role:** ROUTER  
**Vertical revision:** `records-foundation-2026-09-01-r2`

## Status/currentness first

- `STATE.md` — status, scope, remaining uncertainty, reopen condition.
- `CURRENT-REVISION.md` — exact blob binding for current reading surfaces.
- `DOCUMENT-STATUS.md` — role/currentness classification when a file is found directly.

These are not substantive evidence layers.

## Content-depth route

### L0 — Key
`KEY.md`

Shortest bounded orientation.

### L1 — Findings map
`FINDINGS-MAP.md`

Choose the problem area and deeper route.

### L2 — Integrated vertical synthesis
`synthesis/RECORDS-VERTICAL-SYNTHESIS.md`

Use when several Records dimensions interact or the integrated result matters.

### L3 — Current topic synthesis
Use the relevant file under `synthesis/current/`. These integrate the material corrections that survived the corresponding adversarial pass.

### L4A — Adversarial / research audit
Use when asking `how was this result challenged?`:

- corresponding `*-COUNTERCHECK.md`;
- exact historical pass blob named by the legacy synthesis stub when reconstruction of the pre-countercheck reasoning matters.

L4A is not independent verification.

### L4B — Evidence trace
Use when asking `where did this claim come from and what was the source scope?`:

- relevant pass/topic ledger under `sources/`;
- `SOURCES.md` only for the foundational pass.

A source ledger is a derived retrieval aid, not a primary source.

### L5 — Primary source
Read the exact standard/specification/paper/guidance named by the ledger for load-bearing or exact claims.

## Topic routing

| Question | Current L3 | L4A audit | L4B evidence trace |
|---|---|---|---|
| What is the persistent thing / record / identity? | `synthesis/current/OBJECT-IDENTITY.md` | legacy object blob + `synthesis/ARTIFACT-COUNTERCHECK.md` | `sources/object-boundaries-recordhood.md`, `sources/artifact-counterframe.md` |
| What must survive for future use? | `synthesis/current/PRESERVATION-CLOSURE.md` | legacy minimum-envelope blob + `synthesis/MINIMUM-ENVELOPE-COUNTERCHECK.md` | `sources/minimum-envelope.md`, relevant preservation ledgers |
| Change / currentness / history / time | `synthesis/current/CHANGE-TIME-STANDING.md` | legacy change blob + `synthesis/CHANGE-STATUS-TEMPORAL-COUNTERCHECK.md` | `sources/change-status-temporal-semantics.md`, `sources/provenance-identity-time-versioning.md` |
| Organisation / derived views / retrieval | `synthesis/current/ORGANISATION-RETRIEVAL.md` | legacy organisation blob + `synthesis/ORGANISATION-RETRIEVAL-COUNTERCHECK.md` | `sources/organisation-retrieval-semantics.md` |
| How are Records requirements derived? | `synthesis/current/REQUIREMENT-DERIVATION.md` | legacy requirement blob + `synthesis/REQUIREMENT-PROFILE-COUNTERCHECK.md` | `sources/requirement-profile-derivation.md` |
| Which mechanism patterns fit which requirements? | `synthesis/current/MECHANISM-LANDSCAPE.md` | legacy mechanism blob + `synthesis/MECHANISM-PATTERN-COUNTERCHECK.md` | `sources/mechanism-pattern-landscape.md` |
| Retention / transfer / destruction | `synthesis/current/RETENTION-DISPOSITION.md` | legacy retention blob + `synthesis/RETENTION-DISPOSITION-COUNTERCHECK.md` | `sources/retention-disposition.md` |
| Failure surfaces | `synthesis/current/FAILURE-SURFACES.md` | relevant topic audits + superseded failure blob if historical comparison is needed | relevant topic ledgers |
| Why is the vertical considered sufficiently complete? | `synthesis/current/COMPLETENESS.md` | `synthesis/VERTICAL-COMPLETENESS-COUNTERCHECK.md` | `sources/vertical-completeness-omission-review.md` |
| Remaining bounded uncertainty | `OPEN-QUESTIONS.md` | relevant topic audit | relevant topic ledger |
| Deliberately deferred relations | `DEFERRED-RELATIONS.md` | relevant Records audit only | relevant Records ledger |

## Layer rule

Higher layers are intentionally lossy. Descend when:

- an omitted caveat could change the decision;
- a claim is load-bearing;
- two views appear inconsistent;
- exact terminology/source scope matters;
- a falsifier/counterexample must be checked.

Do not descend merely to maximize file/source count when the bounded question is already safely answered.

## Direct-search rule

Search rank does not establish currentness. If a search lands on an unfamiliar file, read its role/status header or `DOCUMENT-STATUS.md` before using it.

Historical/superseded synthesis paths intentionally retain exact old blob SHAs and route to current replacements.

## Epistemic status

- L0/L1/L2/L3 are derived research views at different compression levels.
- L4A is adversarial self-review/audit, not independent verification.
- L4B is source trace, not primary evidence.
- L5 is the primary-source layer.
- Research findings are not architecture decisions.