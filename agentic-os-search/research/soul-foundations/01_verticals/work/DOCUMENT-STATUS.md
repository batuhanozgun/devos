# Work — Document Status Manifest

**Document role:** CURRENT_STATUS_MANIFEST  
**Vertical revision:** `work-foundation-2026-09-02-r2`

This manifest answers:

> If a Work file is found directly, what currentness/epistemic role does it play?

## Status vocabulary

- **CURRENT** — preferred current derived result for its stated layer/topic.
- **HISTORICAL** — earlier research-stage framing retained for path recovery; not the current conclusion.
- **ADVERSARIAL_AUDIT** — challenge/omission/countercheck surface; not independent verification and not the preferred positive result alone.
- **EVIDENCE_TRACE** — source-reading ledger/retrieval aid; derived from sources, not a primary source.
- **STATE** — current vertical status/boundary/reopen gate; not substantive evidence.
- **ROUTER** — navigation/currentness surface; not substantive evidence.
- **CURRENT_RESIDUAL** — bounded unresolved Work-local questions; not a new research mandate by itself.
- **CURRENT_DEFERRED_RELATIONS** — material cross-foundation relations intentionally left unsolved.

## Current surfaces

### STATE
- `STATE.md`

### ROUTER
- `README.md`
- `INDEX.md`
- `CURRENT-REVISION.md`
- `DOCUMENT-STATUS.md`

### CURRENT — L0 / L1 / L2
- `KEY.md` — L0 intentionally lossy orientation.
- `FINDINGS-MAP.md` — L1 topic routing/current bounded results.
- `synthesis/WORK-VERTICAL-SYNTHESIS.md` — L2 integrated current synthesis.

### CURRENT — L3 topic findings
- `findings/WORK-FRAMES-AND-UNITS.md`
- `findings/INTAKE-SELECTION-COMMITMENT-AND-PRIORITY.md`
- `findings/COORDINATION-FLOW-AND-SITUATEDNESS.md`
- `findings/CONTROL-STATE-CLOSURE-AND-RECOVERY.md`

These are the preferred current topic-detail surfaces. They preserve detailed derivation but defer to the L2 synthesis if an intermediate formulation conflicts with the consolidated result.

### CURRENT_RESIDUAL
- `OPEN-QUESTIONS.md`

### CURRENT_DEFERRED_RELATIONS
- `DEFERRED-RELATIONS.md`

## Historical research orientation

### HISTORICAL
- `orientation/RESEARCH-ORIENTATION.md`

This records the weak starting hypothesis, decision-critical assumptions and strongest alternative framing. Use it for `how did the research direction change?`, not for the current positive result.

## Adversarial / completeness layer

### ADVERSARIAL_AUDIT — L4A
- `synthesis/COMPLETENESS-OMISSION-CHECK.md`

This answers `why was bounded completion judged reasonable and what omission probes were run?`. It is same-model adversarial self-review, explicitly **not independent verification**. Its point-in-time evaluation language does not override current `STATE.md`.

## Evidence trace layer

### EVIDENCE_TRACE — L4B
- `evidence/SOURCE-LEDGER.md`

The ledger records source/view grade and claim-to-source recovery. It is not a primary source and does not gain authority merely by being more detailed.

### L5
For exact or load-bearing claims, recover the primary/authoritative source named by the ledger.

## Direct-search rule

If search/retrieval lands on a Work file without first reading `INDEX.md`:

1. inspect the file's role/status header where present;
2. if it is `orientation/RESEARCH-ORIENTATION.md`, treat it as historical framing;
3. if it is `COMPLETENESS-OMISSION-CHECK.md`, pair it with the current positive synthesis and `STATE.md` rather than treating the audit as current project status;
4. if it is `SOURCE-LEDGER.md`, do not treat it as synthesis or primary evidence;
5. if it is one L3 finding, use the L2 synthesis for integrated/current interpretation when the question spans topics;
6. if role/currentness remains ambiguous, return to `INDEX.md`.

## Parent authority

This manifest classifies Work-local surfaces only. It does not bind or duplicate parent-level project state. Current project purpose, authorization and next responsibility live in:
- `../../STATE.md`
- `../../INDEX.md`

## Currentness principle

Search rank, detail level and file age do not establish authority. Preferred Work-local currentness is determined by this package's routing/status contract and exact revision binding in `CURRENT-REVISION.md`.
