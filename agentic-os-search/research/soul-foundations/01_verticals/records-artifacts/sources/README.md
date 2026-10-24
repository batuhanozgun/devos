# Records — Source / Evidence Trace Layer

**Document role:** EVIDENCE_TRACE_ROUTER  
**Vertical revision:** `records-foundation-2026-09-01-r2`

This directory contains topic/pass-specific source-reading ledgers used by the Records vertical.

## Important correction

There is **no single vertical-wide consolidated source ledger** in this package.

The root `SOURCES.md` is the **foundational-pass source ledger only**. It is evidence history for Pass 1, not an authority over later pass ledgers.

Later passes have their own ledgers under this directory, for example:

- `object-boundaries-recordhood.md`
- `minimum-envelope.md`
- `change-status-temporal-semantics.md`
- `organisation-retrieval-semantics.md`
- `requirement-profile-derivation.md`
- `mechanism-pattern-landscape.md`
- `retention-disposition.md`
- `vertical-completeness-omission-review.md`

Other files provide additional source lenses or counterframes.

## Ledger role

A ledger should separate where possible:

- source + URL;
- why the source was read / source role;
- direct material observations;
- research inference/use;
- caveat / domain limit.

A ledger is a **derived retrieval aid**, not a primary source and not a synthesis.

## Exact-claim recovery

For a load-bearing or exact claim:

1. start from the current topic synthesis under `../synthesis/current/`;
2. use the relevant countercheck if the interpretation needs challenge;
3. open the relevant ledger here to recover source scope and URL;
4. read the primary source itself.

If two ledgers appear inconsistent, do not silently pick one. Return to their primary sources and the current topic synthesis.

## Currentness

Source observations can remain valid while the research interpretation built from them changes. Therefore a source ledger's date does not make its old synthesis current.

Use `../DOCUMENT-STATUS.md`, `../CURRENT-REVISION.md`, and `../INDEX.md` for current routing.