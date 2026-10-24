# U04-A — Memory scope, recall and authority

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q05, related Q02/Q07/Q08/Q10. **Evidence:** source observation, test-source inspection and qualified inference. **No new execution.** Exact sources: [S77–S88](../evidence/U04-A-SOURCES.md). Research/method disposition: [U04-A round / MR06](../ROUND-U04-A.md).

## 1. Bounded system explanation

The Memory Vault is a local file-based context-transfer mechanism, not the SQLite work/session store studied in U03-A and not the worktree launcher studied in U03-B. Its core path is:

`caller-supplied context or handoff → fixed active/unreviewed metadata → validated Markdown document → selected vault scope → bounded scan → search excerpt or explicit full read → external consuming workflow`.

The CLI and optional stdio MCP server use the same vault functions, but impose different caller/identity policies and expose different views of results. Saving a handoff does not call the earlier launcher, claim a work item, resume a session or update a governed project decision in this inspected path. A cross-harness recipient is routing metadata, not acknowledgement or acceptance by that recipient.

This is a substantive capability with deliberately limited responsibility: shared inspectable files, deterministic retrieval, create-only writes, diagnostics and a constrained tool surface. It is not evidence that the complete ECC system lacks other consumers or richer control paths.

## 2. Memory type, trust and current status are independent

S80's `MEMORY_KINDS` includes context, decision, fact, handoff, lesson, note, preference and runbook. These names classify content; they do not certify a fact, accept a decision or authorize a runbook. `MEMORY_TRUST_STATES` contains only `unreviewed`; `MEMORY_STATUSES` contains active, rejected and superseded. S79 `normalizeSaveInput` fixes new records to active/unreviewed rather than taking caller-provided trust or status.

S83's document schema agrees on these axes. The core actually normalizes/parses through S80's functions; the presence of a JSON Schema file is not proof that every operation executes that schema. MCP separately validates its own input schemas with Ajv.

S77/S85 explicitly put accepted knowledge in governed repository artifacts outside the vault. There is no review/promotion tool among the CLI commands or the four MCP tools. Human review is a consuming-workflow responsibility, not an implemented identity-verifying approval transition in this core. A committed team memory remains unreviewed. A shell-capable actor can still change files outside these tool methods; an instruction to obtain human review is not an OS access-control boundary.

This corrects the preliminary screening's possible reviewed/unreviewed interpretation: the pinned v1 vault is not a two-state trust ladder. Its intentional path is unreviewed context → evidence review outside the vault → separately governed artifact. Earlier screening remains historical, not silently rewritten.

## 3. What scopes and cross-harness sharing actually mean

S79 resolves the nearest directory containing `.git` (or falls back to the current directory). Default project/team roots are `<project>/.ecc/memory/project` and `team`; user memory is under the operator's home. Explicit project/user-root overrides can align different processes to shared files.

Normal recall includes project/team only. User scope is never implicitly added. Separate worktrees can therefore resolve to separate project vaults; a common repository history alone does not establish a shared memory location. This is a source-derived consequence of root selection, not an executed multi-worktree test. S77 requires participating harnesses to use aligned working directories or root overrides.

Project initialization/write checks the exact protective `.gitignore` content and refuses an unexpected existing file. Team scope is intended for reviewed Git sharing. This is accidental-addition protection, not confidentiality: Git's official documentation says ignore rules do not affect files already tracked (W08). Neither a team directory nor a harness slug authenticates a person.

The core checks trusted-root containment, does not follow accepted memory-file symlinks, compares opened-file identity and bounds input. S82 resolves nearest existing ancestors to detect stable escapes. S85 explicitly excludes hostile same-OS-user concurrent processes from the security guarantee. No path-race, Windows, crash or multi-user test was run here.

## 4. Create-only storage preserves a record, not its truth

CLI body input comes from stdin or a regular non-symlink file rather than an argument containing the body. S79 normalizes the record, checks known secret patterns and location policy, then writes a private exclusive temporary file, fsyncs it, and links it to the destination without overwriting an existing destination. This is a particular local publication sequence, not an assertion of universal crash durability.

`create-only` is the write-path contract, not an immutable journal against every filesystem actor. The exported save function permits a supplied ID; destination uniqueness and corpus-wide duplicate-ID detection are different checks. The reader/doctor explicitly consider duplicates. No global uniqueness guarantee is inferred from create-only file creation.

S80 uses strict known frontmatter fields with JSON-valued entries, validates IDs/scopes/timestamps and bounds body bytes. Read paths also reject/quarantine documents matching known secret shapes and reject a mismatch between scope/kind metadata and physical placement. These are meaningful integrity and safety checks, not factual verification or a complete sensitive-data/prompt-injection classifier.

No producer in the inspected core confirms the truth of a saved completion claim against tests or an issue tracker. Calling a record `fact` or giving it a valid timestamp does not close that evidence gap.

## 5. Relevance, supersession and historical access

S79 search is bounded lexical ranking over title, tags, metadata and body. It filters active status and optional kind/target, sorts by score first and updated time second, then returns metadata plus a bounded excerpt. It does not prove complete semantic recall, inspect current external truth or automatically prefer a later correction over a more relevant old entry.

The structured `links` field contains memory IDs, not a typed revocation relation. A new record linking to an old one does not change the old record's status. S77/S85 require operator review and a manual superseded status for ordinary search to exclude the old entry. The design diagram's supersession language must be read with this implementation, not as an automatic graph transition.

Direct ID reads intentionally allow rejected/superseded records when the scoped scan is complete and the ID is unique and visible. Active backlinks are derived separately and bounded. Consequently a direct read can retrieve history that ordinary search would exclude; the consuming workflow must check status.

There is also a presentation boundary: S78's JSON read returns the complete result including status, while the terminal formatter prints trust, title, ID, source, targets, body and backlink IDs but not status. Thus historical-status information present in the object is absent from that terminal view. This is source-observed formatter behavior, not a measured user/model error.

## 6. Retrieval completeness is enforced differently from search availability

The scan has explicit entry, byte, depth and diagnostic bounds. Invalid/unreadable documents are diagnosed and omitted from search. Directory-traversal failures instead throw an incomplete-lookup error. Hidden-file/symlink exclusions define the scan policy; they are not silently treated as readable documents.

`readMemoryById` refuses a truncated scan or any invalid document in the selected scopes before claiming absence or uniqueness, even if a matching valid record was already found. This protects against an unseen duplicate or incomplete backlinks. S85 calls the availability cost intentional: an unrelated malformed document can prevent a direct read until the authorized vault is repaired. It is not automatically a defect, nor does it provide an atomic snapshot against concurrent edits.

Search permits partial results with diagnostics. The complete route matters:

| Condition | Core / structured surfaces | Plain CLI view |
|---|---|---|
| No match in a complete valid scan | Empty results and zero/false diagnostics | No matching memories found |
| No valid match, but malformed files were excluded | Empty results plus nonzero invalid-file diagnostics | Same no-match text; diagnostics not printed |
| Partial valid matches with invalid/truncated scan | Matches plus diagnostics; CLI JSON and MCP preserve them | Matches/excerpts only; scan diagnostics omitted |
| Incomplete direct ID lookup | `ECC_MEMORY_INCOMPLETE`; MCP maps to `MEMORY_READ_INCOMPLETE` with isError | Error message and nonzero CLI exit |

The second/third rows follow S79 → S78 `printSearch`: normal returns do not become an error merely because diagnostic fields are nonzero. This is a source-derived counter-path, not a newly executed incident. A whole directory-access error is not the same scenario: it throws rather than becoming a successful empty search.

S77 tells consumers to inspect diagnostics, but a plain CLI consumer is not shown them. The mechanism creates the evidence; one representation drops it. Reopen Q05b before relying on default terminal output for absence/currentness or automation. No claim is made that all memory interfaces hide the condition.

Doctor reports structural/scan/duplicate/link/symlink health and performs no repair. Its ok value is not a truth or task-readiness certificate. S78 prints the value but does not set an issue-specific exit code merely because ok is false; consumers must inspect the result rather than assume process success means a healthy vault.

## 7. CLI and MCP are different authority surfaces

The CLI accepts source attribution from flags/environment and applies an optional caller-selected target filter to search. Direct CLI read does not pass a target filter. S84's conformance example explicitly treats this as operator access, not recipient authentication.

S81 requires a configured server harness slug. For MCP save, the server stamps sourceHarness itself; tool arguments cannot override source identity, trust or status. Search/read/doctor pass the server identity to core target filtering. User scope requires server opt-in and an explicit call request; permitting user scope does not add it to default recall. These are real source-level argument/control checks, not just tool descriptions.

However, server identity is operator configuration, not proof of an authenticated human or a distinct hostile-process principal. Core roots still come from the process environment/current directory. S85 requires separate isolation for mutually untrusted local processes. Target routing is not a replacement for that isolation.

The server exposes save/search/read/doctor, not shell execution, review, overwrite, automatic transcript import or session resume. Its initialization instructions call results context rather than instructions. Whether a consuming model obeys that boundary is not established by returning this text. W09 distinguishes MCP protocol errors from tool execution errors; this unit is not a full MCP-version-compliance audit.

## 8. The cross-harness example validates transport and a separate integrity layer

S84/S88 describe and implement a disposable CLI/stdio conformance runner. It configures separate MCP processes with names codex, claude and hermes, compares ordered results against CLI JSON, checks target/scope restrictions, rejects identity/trust overrides and repeats queries after process restart. Those are server identities, not native application sessions. Restart repeatability is not restored agent reasoning or resumed work.

The comparison is useful conformance evidence if executed successfully, but both interfaces share the core; equality alone cannot validate retrieval quality. We read the test source, not a realized passing receipt, and did not execute it. Ajv/dependency identity and real host integration remain separate.

S86 is an example-local verifier over a JSON envelope inside the ordinary body. It checks exact source text, digest, observation time, session and checkpoint against a host-owned synthetic catalog, with workspace/scope supplied separately from the memory. Recomputing a digest inside altered memory is insufficient to pass this independent reference check. Yet the returned status is only source-content-match, not current truth, signed authorship or trust promotion.

Crucially S88 deliberately stores altered envelopes, recalls them, and calls S86 separately to reject them. Neither core save/recall nor MCP automatically invokes that verifier. The example catalog supports bounded fixture identifiers only; it is not a production evidence resolver, durable archive or validation of summaries derived from source text. Do not promote an examples-directory mechanism into an active safeguard for every memory.

## 9. Disposition and candidate use

Q05a is bounded-answered for the local memory document lifecycle and CLI/MCP consumers. Q05b retains completeness/current-status presentation and composition tests; Q05c retains real host uptake, governed-artifact review, work/session integration and ECC2 projections. No automatic handoff acceptance or runtime resumption is established in this traced path. Earlier Q03b/c and Q04b/c/e remain open.

The candidate SOUL/Development OS lesson is to separate stored context, content type, recall eligibility, evidence match, governance acceptance and actual use. A system can share useful information without pretending that storage itself grants authority. Equally, preserving an uncertainty field internally is insufficient when a downstream view drops it. These are research cases, not adopted components.

Next U05-A studies observation/instinct/skill evolution. Memory v1 deliberately avoids promoting context into behavior; the next question is how the separate learning mechanism claims to make that change and what validates it. Broader inventory, memory integrations and final native/system/project-facing synthesis remain open; no whole-study closure follows.
