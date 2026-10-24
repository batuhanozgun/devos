# U02-A — Ownership, partial-write checkpoints and derived health

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q03a, with Q08 and Q01 dependencies. **Evidence:** source and test-source inspection, not execution. Exact coverage: [U02-A sources](../evidence/U02-A-SOURCES.md).

## 1. Result

ECC's managed ownership is an operational policy, not a universal promise to preserve any user-edited file. The common copy guard and the guided Kimi preflight answer different questions. The former protects an existing destination not recorded as managed, while keeping recorded destinations updateable. The latter additionally requires matching operation identity and current content evidence before trusting a previously recorded destination.

A partial-write checkpoint preserves management and recovery information, but its operation list is not a list of completed effects. The existence of such a checkpoint also does not prove that the next guided retry will be admitted. Separately, canonical installation JSON, its database projection and inspection of current managed-file health are distinct objects with different failure behavior.

These are bounded implementation findings. This unit does not establish a working installation, general security, crash durability, safe adoption or useful agent behavior.

## 2. State validity is not ownership validity

S46 validates `ecc.install.v1`: target identity fields, request/resolution/source fields and operation metadata. `contentSha256` is optional; when present its format must be a SHA-256 hex digest. The validator checks structural conditions, not every destination's live contents or the human authorization behind an operation.

`createInstallState` can assign `installedAt` while constructing a state preview. S52/S44 can persist that preview-derived record before file writes. Therefore neither an `installedAt` field nor a structurally valid operation establishes completed installation. The reader must use the record's actual producer and the relevant consumer rules.

The state writer validates, creates parent directories and uses `fs.writeFileSync`. This function does not implement a temporary-file/rename/fsync commit protocol. Other surrounding checks may matter; this observation is not an experiment demonstrating corruption, but it prevents a caught-exception checkpoint from being advertised as universal power-loss recovery.

## 3. Common guard versus guided Kimi: a real consumer contrast

Source route: ordinary S28 → S32/S38 → S44 → S52/S45. Guided Kimi adds S34's ownership preflight and write-boundary callbacks before entering the common apply engine. S54 binds the actual adapter to project `.kimi-code` with `ecc-install-state.json`; the guided and ordinary paths are not interchangeable merely because they use that same adapter.

| Situation, under otherwise valid paths/plan | Common copy guard S45 | Guided Kimi S34 plus common apply |
|---|---|---|
| Existing file, no previous managed record, different bytes | Skip with warning; exclude destination from bridge/final ownership state | Preflight refuses the conflicting unowned file |
| Existing file, no previous managed record, bytes identical to source | Still skip; identical content alone does not transfer ownership | Preflight may classify `identical`; common guard still preserves it without recording ownership |
| Previous managed record with same current bytes and valid identity | Destination remains updateable | Preflight can admit `managed-update` |
| Previous managed record, but current bytes differ from its digest | This guard does not require digest equality before accepting it as updateable | Matching planned operation fails the current-digest check |
| New unowned file appears after preview | Copy-boundary check refuses it | Rechecks can reject changed classification or collision, including a late identical copy |
| Prior state's target identity/root/state path mismatches | Refuse rather than borrow another target's ownership | Additional target fields, canonical path and snapshot checks apply |

The table describes inspected predicates, not newly executed cases. Other operation-specific checks still apply. S45's collision filter specifically guards `copy-file`; it is not a generic policy for every JSON field, hook setting or operation kind.

S48's Antigravity test explicitly changes a managed destination, reruns installation and expects restoration to the original installed content. Thus a user edit to an already-managed file is not automatically treated like an originally unowned file. This is test intent consistent with the source, not a observed passing result in our environment.

S50's initially-identical-file case is equally important: it expects a complete guided result while leaving that file out of managed state and installing another new file. **Successful batch result does not imply ownership of every requested destination.** Byte equality permits a compatibility judgment; it does not itself grant management authority.

Kimi's previous-state trust uses operation fields (`kind`, `moduleId`, `sourceRelativePath`, `strategy`, `scaffoldOnly`) and current content digest, in addition to target/root/state-path checks. This is stronger evidence binding than pathname membership. It is not a signed authorization, OS access-control boundary or proof that the user wants the proposed change.

## 4. The bridge is not limited to Claude migration

This refines Note 02 §5. That earlier note saw `requiresBridgeState` in the outer apply engine and correctly avoided claiming universal coverage, but described it as migration-specific. Opening its producer changes the scope:

- S52 `prepareClaudeSkillMigration` calls `createDisabledMigration` for non-Claude targets.
- Despite the name and `enabled: false`, this branch combines old and new operations, supplies bridge/final state and sets `requiresBridgeState` whenever the plan has operations.
- S45 subsequently removes skipped unowned destinations and disables bridge persistence for a fully skipped plan.
- S44 persists a required bridge before entering the ordinary file-write loop.

Therefore a nonempty common managed Kimi/Antigravity plan can use the bridge without any Claude flat-skill migration. Native provider plugin installation and the separate legacy Codex sync are still outside this inference. A helper's filename and an `enabled` flag do not define every effect the helper produces.

This correction is additive; U01-B's source observation and historical read limits remain preserved.

## 5. What the checkpoint preserves after a caught failure

The successful path is not just plan→copy→success. S44 builds the filtered effective plan, persists a bridge when required, performs operations, records successfully written destinations, obtains digests of installed content and persists the final state. Transforms, merged JSON and special Claude settings retain their separate code paths.

For a caught failure, S44 combines S45's `preserveUnwrittenFiles` with installed-content hashing limited to destinations marked written. Three cases differ:

1. **An unowned file was skipped or appeared before its copy.** It must not become ECC-owned merely because the attempted plan named its path. The filter removes relevant existing, unwritten, unowned copy destinations from checkpoint ownership.
2. **An old managed file was not written during this attempt.** The previous operation metadata, including its old digest, is retained. A current user edit is not rehashed and relabelled as bytes installed by this failed attempt.
3. **A newly planned destination is still missing.** Its operation can remain in the bridge without an installed-content digest. The record describes pending/recovery scope as well as completed content; it is not an effect journal in which every row means done.

S48 includes assertions for late concurrent user files, skipped paths and preserving prior hashes on an early failed reinstall. It also invokes uninstall in those fixtures to assert preserved user content. We read those tests but did not run them, and have not closed the full removal implementation.

Two limits are explicit. First, this path checkpoints rather than rolling all file effects back. Second, the checkpoint write itself can fail; the engine reports a combined error. Abrupt process termination and storage failures are not covered merely because JavaScript has a `catch` branch.

## 6. Retry selection is not retry admission

S34's coordinator reports which harnesses remain to retry. That says nothing by itself about whether the failing harness's next preflight will accept its current intermediate state.

A source-derived boundary deserves a separate open question (Q03b): consider a fresh two-copy managed plan where the first destination is written and a caught failure occurs before the second. Under the bridge path above, the still-missing second operation can remain in state without a digest. On the same guided Kimi request, S34 `readOwnedDestinations` checks a previously recorded operation matching a current planned destination for both existence and a valid matching content digest. That described intermediate record therefore reaches a refusal condition rather than automatically becoming `create`.

This is an **analytical counter-path, not an executed interrupted install/retry**. The outcome of a complete real fixture, the supported repair/uninstall alternative, prevalence and possible other entry conditions remain unverified. Do not present it as a newly observed production incident or claim that every retry is broken. S50's partial-result tests mostly inject throwing child functions; they do not run the described two-file failed install and its second guided attempt.

For research reuse the established distinction is narrower and valuable: a recovery record can preserve safe refusal and useful cleanup information without making same-command continuation automatic. Universal transparent resumption is not established here.

## 7. JSON authority, database projection and current health

S47 imports the actual S53 export of S49's projection functions. The immediate `projectInstallState` path builds a database record from the supplied state and calls `upsertInstallState`; it does not inspect every installed file. Its `projected` result describes that record operation, not file integrity or host usage.

S49's reconciliation is scoped to discovered target identities:

- missing canonical state removes the corresponding discovered projection;
- unreadable/invalid state or target-identity mismatch removes that projection and adds a warning;
- valid matching state can be projected;
- undiscovered other home/project scopes are deliberately not purged.

Deletion/write failures themselves yield warnings, so a requested projection removal is not an unconditional guarantee that a row disappeared. A retrieval miss outside the discovered scope is not evidence that another installation does not exist.

Current file health is a separate doctor-based inspection. S49 combines selected file-health issues with projected health; a scoped failed health check can produce `canonicalStatus: unverified` instead of preserving an unjustified healthy judgment. The full doctor implementation was not read, so its complete coverage is not inferred from the issue-code list.

S47 treats this database as derived: open/operation errors become warnings; close errors are swallowed to avoid invalidating a completed canonical JSON/file operation. That is an availability trade-off, not proof that the latest projection is durable. S53 has a different atomic database-file persistence routine, but its SQL query bodies, concurrent-writer behavior and full crash semantics were not validated. Do not combine these separate local guarantees into a cross-store transaction.

## 8. Evidence quality and counter-reading

The strongest overly positive explanation would be that an ownership record and a hash protect all user modifications through every channel. The ordinary/guided contrast and the optional digest contract contradict that generalization.

The overly negative explanation would be that differing policies make the guard useless. The common guard does prevent claiming existing unowned copy destinations; the guided path adds substantive identity/content and late-change checks. Their effects should be scoped rather than discarded.

No new local or host experiment was needed to establish the code's different predicates. A new probe would be needed to elevate Q03b's specific end-to-end replay prediction to observed behavior. We did not manufacture an E02, copy code into an alleged full checkout, count test assertions as test passes or rerun U01-A's E01.

Full reads covered S45–S50 and S52–S54; S51 remains selected 1–480, S55 metadata only. The upstream tests use real temporary files for several local cases, but also constructed plans, build exemptions, stubbed projections and injected provider functions. They do not establish model compliance, useful restored context or a whole installed-system safety verdict.

## 9. Research disposition and next unit

Q03a is bounded-answered for common/guided ownership, identity versus content, caught-failure record preservation and projection separation. Q03 remains partial. Q03b retains the described interrupted-guided-retry boundary; Q03c retains full repair/uninstall, merged-JSON ownership and crash/concurrency closure. Reopen these before adoption or when a later mechanism relies on automatic recovery.

The method check is MR03: opening the real producer corrected the apparent Claude-only bridge boundary, Kimi supplied a genuine consumer contrast, and a small state-store directory inventory was usable without a giant recursive response. These are same-assistant observations, not proof of a superior research method.

Next **U03-A / Q04** leaves installation family B for Work/session control: how are sessions and work items produced, persisted, linked and consumed; which records merely describe work and which actually permit or cause continuation? Start with the already-discovered `scripts/sessions-cli.js`, `scripts/work-items.js`, and `scripts/lib/state-store/queries.js`; then follow their real producer/consumer imports. Keep the separate Rust `ecc2` and Node state surfaces distinct. U03-A is not started in this note.

P1 still has broader topology debt; the five-file state-store listing is not the full repository inventory. Foundation and cross-study architecture projection remain later. The candidate lesson is about exact ownership, transition and evidence scope, not a prescribed SOUL component or an authorized deployment.
