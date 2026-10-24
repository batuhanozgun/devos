# U01-B — Discovery delta and unresolved frontier

**Date:** 2026-09-17. **Pin:** `8321021c54d670126ce3b2969d5deb880b4b0c2a`.

Read with [STRUCTURE](STRUCTURE.md) and [TREE-FRONTIER](TREE-FRONTIER.tsv). The TSV preserves U01-A's root-directory identities and pass-time expansion state; the changes below supersede only the named rows. No omitted subtree is silently marked complete.

## New direct-child discovery

- `.agents` tree `0b6fef700821049a86f9cef4b83d4fd06e371bdc`: direct listing read; contains `plugins` and `skills`. Its entire skills subtree was NOT expanded/read.
- `.agents/plugins` tree `e1b52421defb19841308a5c4fcbaa28afdf2fef0`: direct listing read; marketplace file discovered and then fully read.
- That marketplace binds local plugin source to `./`, the repository root. This is source selection, not actual host cache materialization evidence.

## Broader acquisition attempt

A `git/trees/<pin>?recursive=1` request returned a very large connector response. Its model-visible representation was truncated and was not recovered into a completely reviewed, durable file inventory. This record does not assert that the upstream API itself truncated the tree, nor that every returned entry was reviewed. Searching within one large JSON line did not supply a reliable complete inventory.

A separate container acquisition attempt failed at DNS. That is an environment constraint, not evidence of an ECC defect or general GitHub outage. No local checkout or raw recursive manifest is claimed.

## Updated source-to-consumer map

1. User-facing selector → module/dependency/target resolver → managed adapter → planned operations → ownership/consent-filtered application → digested install-state → optional health projection → host consumption (unobserved).
2. Guided native Codex → provider inventory/provenance → marketplace add/upgrade → installed/enabled plugin readback → hook trust/cache loading/usage (not observed).
3. Legacy Codex shell sync → direct copy/config/instruction merge + legacy ownership helper → consumer/retry/uninstall semantics still open.
4. Guided Kimi reuses managed plans but adds preflight identity/digest/writability and write-boundary checks. Its placement in a multi-target sequence does not make the sequence globally atomic.

Details and source IDs: [Note 02](../notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md), [U01-B source ledger](../evidence/U01-B-SOURCES.md).

## Persistent unresolved regions

U01-A's Node/npm, Rust ecc2, native Workflow pilot and external-product boundaries remain distinct. U01-B does not finish their integration, packaging, runtime or consumer analysis. Whole README, broad scripts/lib/tests/schema topology, domain/generated mirrors and major unexpanded subtrees remain selective-reading/frontier obligations.

P1 remains PARTIAL. Next bounded mechanism work may proceed from discovered dependencies, but a final system closure requires accounting for all known material families and revisiting this frontier. A retrieved tree, a list of imports or an attractive diagram is not that closure.
