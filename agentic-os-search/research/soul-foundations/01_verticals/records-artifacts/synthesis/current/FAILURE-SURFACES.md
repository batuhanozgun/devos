# Records — Current Failure Surfaces

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Replaces as current reading surface:** legacy `FAILURE-MODES.md`.

This is a research-derived inventory of ways a persistent-information design can fail. It is not a universal checklist; a concrete requirement profile selects the material failures for its use/risk.

## 1. Existence / durability

- resource is lost, never captured, or corrupted beyond recovery;
- only part of a multi-part resource/context survives;
- apparent replicas share one hidden failure domain;
- corruption is not detectably bounded at the required assurance level.

## 2. Interpretation / dependency

- bytes survive but formats/software/schema cannot be interpreted;
- terms, units, codes or contextual knowledge drift;
- external dependencies, keys, registries or rules disappear or resolve to the wrong version;
- inherited context cannot be reconstructed after transfer.

## 3. Identity / granularity

- distinct resources/versions are merged;
- one identity silently changes what it denotes;
- file/row/path/storage key is mistaken for the semantic record identity;
- version, representation, copy, derivation or aggregate boundaries are collapsed.

## 4. Change / history / standing

- prior state is silently overwritten when history matters;
- versions survive but current/designated standing cannot be determined;
- correction, revision, migration, derivation, supersession, retraction/removal or destruction are reduced to generic `update`;
- migration preserves readable payload but loses identity, provenance, relations or protected significant properties.

## 5. Time

- timestamps exist but their semantics are ambiguous;
- effective/applicable time is confused with system-known/recorded time;
- ordering information is treated as stronger causal/chronological evidence than the system can guarantee.

The retired terms `current truth`, `historical truth` and `retroactive truth` are not used here. Records preserves standing/state/history, not factual truth by itself.

## 6. Provenance / context

- origin or derivation cannot be recovered;
- a summary/transformation lacks exact source/version binding;
- complex lineage is flattened to one ambiguous `source`;
- provenance claims themselves have no recoverable provenance where that matters;
- aggregation/order/context relations disappear or are falsely reorganised as if intrinsic.

## 7. Trust overclaim

- checksum/fixity is treated as authenticity, correctness or authority;
- authentic information is assumed factually true;
- plausible content is relied on without enough provenance/process evidence for the use;
- transformed/derived output silently stands for a different source/version/standing.

## 8. Organisation / retrieval

- information persists but cannot be found for the required retrieval mode;
- search result/index/summary becomes shadow authority;
- stale or partial view is used for a claim requiring fresher/broader coverage;
- retrieval miss is treated as absence without sufficient coverage/recall;
- retrieval hit is treated as exact/current/authoritative/truth evidence;
- one taxonomy/hierarchy suppresses context-bearing or alternative relations.

## 9. Rights / access

- legitimate future use becomes impossible because keys/permissions/rights knowledge disappear;
- information remains exposed after legitimate access/retention conditions end;
- restrictions needed for preservation, transformation or reuse cannot be reconstructed.

## 10. Retention / disposition

- over-retention becomes the accidental default;
- premature destruction occurs;
- vague conditions delegate disposition to unbounded judgement;
- hide/logical delete/version deletion/irreversible destruction are confused;
- applicable rule/trigger/hold/execution history cannot be reconstructed;
- in-scope copies/indexes/caches defeat the intended destruction outcome;
- residual disposition evidence survives longer or with more identifying detail than its own profile permits.

## 11. Model / mechanism selection

- storage technology determines record identity/history before requirements are known;
- one universal record schema is imposed on heterogeneous protected uses;
- state, evidence, documents, indexes and derived knowledge are collapsed into one undifferentiated persistence/memory concept;
- append-only/immutable or mutable-current-state approaches are treated as universal correctness;
- mechanism labels (`temporal`, `versioned`, `graph`, `WORM`, `searchable`) are treated as proof of semantic guarantees they do not provide by themselves.

## Use

A candidate design should be tested against the failure families activated by its Records requirement profile. The purpose is falsifiability, not ritual coverage.

For the historical detailed inventory, recover the exact pre-revision blob referenced by the legacy `FAILURE-MODES.md` stub. For source-grounded analysis, route through the relevant current topic synthesis → audit/countercheck → source ledger.