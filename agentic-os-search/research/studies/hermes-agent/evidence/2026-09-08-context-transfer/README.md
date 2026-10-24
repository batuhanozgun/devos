# Context-transfer component probe

**Status:** EXECUTED / BOUNDED SYNTHETIC COMPONENT EVIDENCE. Product conformance: NOT ASSESSED.

Three exact MIT-licensed upstream modules from `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` were executed: `tools/thread_context.py`, `tools/daemon_pool.py`, `tools/skill_provenance.py`. Their complete bytes and original LICENSE are retained under `upstream/`. Git blob and SHA-256 identities are in RESULT/MANIFEST.

The terminal callback API, profile marker and thread-local allowlist are synthetic. No actual AIAgent, PluginManager, executor, memory/skill mutator, user profile directory, provider, credential, network call or disallowed tool was executed. `synthetic_not_allowed` is only compared against a set. No system installation was performed.

## Question and result

Does copying ContextVars and the explicitly handled terminal callbacks also copy a separate thread-local policy object?

Seven diagnostic cases distinguish the parent, bare stdlib worker, real daemon pool, daemon pool with the real helper, explicit worker-local policy binding, callback cleanup after exception and the unchanged parent. In this run the real helper/pool carried origin, a synthetic profile ContextVar and callback markers; it did not carry the separate synthetic thread-local allowlist. Explicitly binding that list in the worker made the harmless-name check reject again. Exception cleanup cleared callbacks.

These observations support the transport-level distinction, not a whole-product authorization-bypass verdict. Actual executor/plugin paths were inspected separately and yielded a cross-source control-context discontinuity candidate; see [06 note](../../notes/06-CALLER-DISPATCH-AND-CONTEXT-TRANSFER.md). The next higher-confidence test must use the actual policy consumer and caller with a harmless handler. Seven matched expectations are NOT seven product PASS tests.

## Reproduction and integrity

Run in a disposable working copy with Python 3.13-compatible standard-library internals:

```sh
python harness.py > stdout.txt 2> stderr.txt
```

The script validates source Git blob identities before imports, constructs only synthetic state, and writes a new RESULT.json. Copy the package before rerunning so the recorded result is preserved. Upstream daemon_pool depends on CPython executor internals; a failure on another interpreter/version is not automatically a Hermes finding.

Recorded run: UTC `2026-09-08T15:57:15.365904+00:00`; Python 3.13.5, Linux x86_64. [RESULT.json](RESULT.json) and [stdout.txt](stdout.txt) are byte-identical; stderr is empty. [CHALLENGE.md](CHALLENGE.md) was written before the first probe run, after source inspection: exploratory, not holdout or independent verification. A manual source-transcription mismatch was caught before execution and resolved by re-fetching the canonical blob; expected hashes were not weakened.

The source comments contain their authors' explanations and historical references. Copying or executing these modules does not independently verify those historical claims. The experiment does not establish profile resolver correctness, effect rollback, semantic learning quality, every callback-failure path or every runtime's authorization behavior.

Sources: [D ledger](SOURCES.md). Reading/assertion scope and exact result are authoritative over informal progress messages. Parent state was cleaned after the test. Previous U01B evidence is separate and was not rerun.
