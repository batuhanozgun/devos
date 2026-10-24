# Note37 — Managed maintenance, ownership and preview propagation

**2026-09-22 · U16-A1 / Q03c1 · BOUNDED SOURCE ANSWER.** Fixed target `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U16-A1-SOURCES.md), [MR38](../ROUND-U16-A.md), [STATE](../STATE.md). Original source, inspected test definitions and conditional inference only. No target test, installer, repair, uninstall, update, live host or new E10 ran. Commands below identify source routes, not operations performed or recommended on user files.

## 1. A maintenance lifecycle exists, but its commands answer different questions

This extends Notes02–03 rather than reopening initial installation. Public `ecc` dispatches to concrete doctor, repair, auto-update and uninstall programs. They discover managed installation records for the selected home/project and adapter roots, inspect or mutate actual files and return structured results. Native-provider plugin registration and legacy Codex sync remain distinct channels, not automatically equivalent managed records.

| Operation | Actual object and effect | Boundary |
|---|---|---|
| Doctor | Discover existing state; check recorded operations, paths/content, package/manifest versions and current module resolution | Recorded installation health is not complete equivalence to current source, host loading or useful capability |
| Repair | Choose recorded operations or rebuild a current manifest request; inspect, rewrite selected destinations and refresh state | Restoring known files, importing newly desired paths and accepting their ownership are not the same operation |
| Auto-update | Validate a candidate checkout location; fetch/pull; replay saved target/profile/module/component/hook choices through install-apply | Source advancement and sequential target installation are not one transaction or the release pipeline's exact-archive qualification |
| Uninstall | Apply recorded-operation removal semantics; preserve changed/unverifiable copies; retain state for partial results | Removal candidates, actual effects, retained user work and a completed uninstall differ |

Sources: LIFE, CLI, DOCTOR, REPAIR, UPDATE, UNINSTALL and APPLY. Useful controls are real: adapter-derived roots, safe source paths, regular-file/no-follow checks, descriptor/parent identity checks near writes, quarantine before deletion, content-digest-based preservation and explicit partial/error reporting. These are scoped controls, not a general safety certificate.

## 2. Doctor compares recorded content before it compares current intent

For a copy with a valid saved `contentSha256`, `inspectManagedOperation` compares the installed bytes with that saved digest. It also requires the source path to be safe and present, but does not compare those source bytes when the digest branch is selected. Without a usable digest it compares against the current source, including applicable transformations/link rewriting. Thus a healthy historical copy and a current-source copy have different predicates.

`analyzeRecord` checks package and manifest version labels, not the recorded Git commit against current HEAD. Its regenerated-plan comparison checks selected/skipped module arrays, not the complete desired destination/content set. Changes within a module or at an unchanged package version are therefore not necessarily detected by that part of doctor. This is not a defect merely because doctor is not an updater; its actual object must be preserved in the explanation.

Missing/invalid records and missing files have meaningful distinctions. Discovery represents absent and invalid state separately. The doctor report selects existing records; zero discovered records can yield checkedCount=0 with no issues and CLI exit0, while its human output explicitly says no install-state was found. Warnings as well as errors make the actual doctor CLI fail. This is stronger than a report that only prints a warning, but an empty checked population is not a successful installed-system inspection. LIFE/DOCTOR; T-LIFE selected definitions.

## 3. Repair can claim a file that normal installation deliberately left user-owned

The original common install guard preserves an existing copy destination not recorded as managed. It skips even identical bytes and excludes that path from final/checkpoint ownership. Normal preview and apply both call `prepareUserOwnedFileGuard`; the later successful uninstall does not acquire a right to remove the skipped file. GUARD/APPLY; T-GUARD tests the useful normal path.

General repair has a different composition. For a nonlegacy record containing only managed copy operations, `createRepairPlanFromRecord` regenerates the saved manifest request against current sources. `prepareRepairMigration` invokes `prepareClaudeSkillMigration`, but not the common user-owned-file guard. On a non-Claude target, the migration helper unions previous and newly planned operations by destination, with new entries replacing old metadata. Newly built copy operations are marked managed and carry no installed-content digest yet. LIFE/MIGRATION/PLAN/RUNTIME.

**Conditional countercase:** use an otherwise valid non-Claude, copy-only manifest installation whose saved request still selects file F, but whose initial apply skipped pre-existing user-owned F. Other selected files or the successful apply's state writing supply the valid discoverable record. On ordinary repair, regenerated F re-enters the operation set:

- If its bytes differ from the expected source, repair can classify it as drifted and overwrite it.
- If its bytes already equal the expected transformed source, no write to F is needed. Final `writeRefreshedInstallState` nevertheless records it as managed with its current digest. With no other repairs, status can be ok and repairedPaths empty despite this ownership change.
- A subsequent uninstall now sees a managed, digest-matching F and can remove it. Direct uninstall before that repair would not have selected F.

The key mismatch is historical management authority versus membership in the newly desired plan. Hash equality can be entirely correct while being attached to an ownership claim that normal installation refused. This is not a hash-collision argument or an observed user-file deletion.

The source supplies concrete copy-only routes: the Cursor rules mapping yields copy operations from `rules-core`, whose declared dependency list is empty; the actual ownership test uses that request. The result remains conditional on the regenerated set and safe/readable/writable destinations, not every target/profile. Claude flat-skill migration has its own user-owned-directory/file protection, and legacy OpenCode repair delegates to guarded ordinary apply. Previously managed files are deliberately repairable; this finding is about a previously unowned path becoming managed. CURSOR/HELPERS/MODULES/T-GUARD and LIFE.

## 4. A failed repair can also change the digest used to preserve an existing user edit

There is a second, distinct path even when ownership itself was already legitimate. Normal uninstall retains a modified copy because current bytes differ from the saved installed digest. General repair, however, can refresh a bridge state **before repairing the target files**. Its writer hashes every readable operation destination at that moment, rather than only destinations successfully written in this attempt. LIFE: `writeRefreshedInstallState` → bridge write → `executeRepairOperation`.

**Conditional sequence:** F is managed with old digest H, and now contains a user edit U. Inspection marks it drifted. The state path is writable, so bridge refresh records hash(U). A subsequent file-repair operation fails before overwriting F—for example a readable but unwritable destination or another I/O failure. The outer catch returns error without restoring the old digest. If F remains U and a later uninstall can remove it, its hash now matches the recorded baseline, so the former drift-preservation predicate no longer protects it.

No permission fixture, induced failure or deletion was executed. The conditions matter: successful bridge write, an early failure before F changes, stable later bytes and a successful later removal. Other failure points can produce other outcomes. The bridge is itself a persistent effect; error does not mean no state changed.

This must not be confused with the already explained initial-apply checkpoint. APPLY tracks written destinations and uses `preserveUnwrittenFiles` to retain prior metadata for untouched managed copies. T-GUARD explicitly induces failed reinstall and expects the previous digest plus subsequent user-file retention. That test exercises APPLY, not the general repair bridge. A real local safeguard in one writer therefore does not establish that every maintenance writer preserves the same baseline.

## 5. Global preview intent is not consumed by every destructive subcommand

The root CLI accepts `ecc --dry-run <command>`. It sets `ECC_DRY_RUN=1`, removes the leading flag from command selection and passes remaining arguments to the child. It does not centrally suppress child execution. CLI.

| Source invocation | Consumer behavior at the pin |
|---|---|
| `ecc repair --dry-run` | Repair receives the argument and passes dryRun=true; normal repair mutations are not performed |
| `ecc --dry-run repair` | Repair receives the environment flag but not the argument; its main reads only parsed options.dryRun and can take the ordinary mutating path |
| `ecc --dry-run auto-update` | The updater likewise ignores that environment flag when deciding whether to run Git fetch/pull; those source-repository changes can occur before reinstall |
| Either flag position for uninstall | Uninstall explicitly validates/consumes ECC_DRY_RUN as well as its local flag, preserving the preview boundary |

The updater's child install may have additional flag handling; no stronger assertion about that later branch is needed to establish the earlier Git effect. These are source dispatch paths, not commands we ran. Existing eligible state/source and successful operations are required for actual changes. The suffix repair preview and uninstall's two-position support are positive counterexamples, not all dry runs being broken.

T-GUARD's real subprocess test checks both global/local positions for **uninstall** and preserves bytes/state/database absence. T-LIFE passes dryRun=true directly to the repair function. Neither inspected case checks the root-prefix→repair or root-prefix→auto-update boundary. A global flag declaration and correct behavior in one child do not prove consumption in another.

## 6. Repair and update have distinct source and result semantics

Any managed non-copy operation, or legacyMode, makes ordinary repair choose recorded operations for the entire record. Copy paths then resolve into current source, but retain old digests; template/merge payloads remain recorded. Claude hook hydration is a special current-source branch requiring its own deeper investigation. All-copy manifest repair instead rebuilds the request. Adding one operation kind can therefore change the selection policy for other files too. LIFE.

A no-op repair intentionally keeps old installedAt/source metadata; T-LIFE explicitly expects a remaining version warning. If another repair does change bytes, record-level version labels can be refreshed while other digest-matching historical copies remain. This is not proof every copy was upgraded. In recorded mode the old source object is spread, so an old repoCommit can coexist with refreshed version labels. Per-file identity and whole-install version are not one uniform upgrade verdict.

Auto-update preserves saved selection and hook choice, rejects ambiguous inferred checkout roots, and reports per-target failures. Its checkout validation checks package/install-script presence and a recognized package name; it is not the provider-origin or exact artifact check used by other ECC channels. It runs `git fetch --all --prune` and `git pull --ff-only`, then reinstalls targets sequentially. Git documents pull against the current branch/configured upstream; fast-forward-only is not an assertion that this is the latest reviewed release. D-GIT/UPDATE.

After a child command returns, JSON parsing and lack of a thrown error lead to updated; there is no required post-update doctor or assertion of payload.applied. The local command helper rejects result.error and numeric nonzero status, but not a null status with signal. Node documents signal termination as status=null. With no error and empty stdout, such a result can reach updated with payload=null. The root CLI separately rejects a signaled direct child, so that protection must not be transferred to this nested helper. D-NODE/UPDATE/CLI. This is a conditional contract comparison, not a killed process or false successful update observed here.

## 7. Removal has genuine preservation and partial-progress boundaries

The public ordinary remover always requests preserveDriftedCopies=true. Changed, missing-digest or final-symlink copies are retained; partial output names retained paths and preserves the install-state. CLI returns failure for partial as well as error. Safe unchanged copies can be removed, and parent cleanup stops at the derived root and nonempty directories. LIFE/UNINSTALL.

When some files are removed and others retained, the original operation list remains in the retained state; it is not reduced to outstanding removal steps. A later doctor can see the removed members as missing, and a repair can restore them. That may be useful for recovery, but is not an uninstall cursor or an automatic commitment to finish removal. Dry-run's plannedRemovals is the recorded candidate set before drift-sensitive execution, not a guarantee all listed paths would actually be deleted.

File effects, install-state and the derived database projection are separate. General repair/uninstall catches can return empty repairedPaths/removedPaths after earlier effects occurred. Public repair/uninstall then invoke scoped projection reconciliation; the helper's prior warning-based contract remains in Note03. Its status does not independently prove all target bytes, host availability or desired-state convergence. Ordinary file writes use pinned-descriptor checks followed by truncation/write, not a whole-lifecycle transaction; specialized settings use a different locking/atomic-update path.

## 8. Source and test boundaries; why parent G3 stays open

The complete general lifecycle body, root CLI and doctor/repair/update/uninstall callers, normal apply/ownership/migration/plan and a concrete target path were read. One ownership test file was fully inspected; the large lifecycle suite was read through selected complete relevant tests, with later bodies unexamined. No suite, fixture, filesystem experiment or E10 ran. Original predicates and connected conditional paths are the evidence, not measured incident rates.

U16-A1/Q03c1 answers the common managed maintenance and public-command boundary. It does not finish every branch under Q03c. The source explicitly delegates shared Claude settings/hook reconciliation and backup/merge ownership, and the public uninstaller can invoke a separate legacy Codex ownership cleanup. Those are materially different producers/consumers, not merely unrun runtime checks. U16-A2/Q03c2 should follow those exact helpers, including MCP filtering versus recorded payload where it affects later repair/removal. No outcome for that investigation is preclaimed.

Q03c3 and Q03b retain stronger installed/authority/concurrency/crash/retry/durability claims and the earlier guided Kimi continuation question. Notes02–03/26/28 and original evidence are unchanged; no upstream fix, architecture adoption or live user-environment action follows. Final STATE/PLAN determine publication and next activation.
