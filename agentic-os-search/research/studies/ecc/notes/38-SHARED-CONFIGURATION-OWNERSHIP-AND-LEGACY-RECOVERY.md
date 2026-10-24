# Note38 — Shared configuration ownership and legacy recovery

**2026-09-22 · U16-A2 / Q03c2 · BOUNDED SOURCE ANSWER.** Fixed target `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact source ledger](../evidence/U16-A2-SOURCES.md), [MR39](../ROUND-U16-A2.md), [STATE](../STATE.md). Source observations, inspected test definitions and conditional inference; no target test, installation, update, repair, removal, host/model or E10 execution. Examples describe source paths, not operations performed on user files.

## 1. The unit of management changes between configuration paths

ECC has real shared-configuration mechanisms, not only whole-file copying. They must be distinguished by what identifies the managed contribution and which later operation consumes that evidence.

| Path | Management unit and actual continuation |
|---|---|
| Manual Claude settings | An event plus stable entry ID, with recorded and desired entry contents. Merge, inspection, repair and removal operate on this subset while retaining unrelated settings |
| General JSON/MCP merge | A recorded JSON payload. Installation merges it, inspection tests subset inclusion, repair reapplies it, and removal subtracts equal values unless a separate previous snapshot was supplied |
| Legacy Codex sync with ownership manifest | Whole-file pre-ECC snapshots, installed-content digests and per-attempt rollback records. Removal can restore the original user file rather than simply delete it |
| Explicit legacy cleanup without manifest | One unambiguous marker block outside Markdown fences; other candidate files are retained without ownership evidence |

Sources: SETTINGS, STATE, MCP, LEGACY, LEGACY-CLI, SYNC and the actual APPLY/LIFE/UNINSTALL callers. These are not one universal ownership contract. An identical hook is deliberately adoptable under its event/ID convention, whereas normal copy installation deliberately leaves an identical unowned file unclaimed (Note37). That contrast is explicit behavior, not evidence that one policy is universally wrong.

## 2. Claude's normal path binds metadata, content and a real writer

`hooks-config.js` reads hooks.json and its metadata sidecar. The sidecar carries stable IDs/descriptions aligned by event and position; a short SHA-256 fingerprint of matcher and handler content checks that an ID was not accidentally attached to a reordered/different entry. Count, event and duplicate-ID mismatches reject the merge. The fingerprint-refresh helper also refuses a detectable reorder before recomputing fingerprints. These are meaningful consistency checks, not authenticated authorship or authorization. A missing sidecar returns the raw source; later managed-hook validation still requires IDs.

Materialization rewrites the plugin-root placeholders and the recognized environment-reading command prologue to the actual target root. Unresolved root reads are refused. Desired hooks receive strict event/handler validation and globally unique IDs. Recorded hooks use a looser historical structural validator: an older event/handler can still be removed without first pretending it is a valid new installation. Sources: HOOKS-CONFIG, SETTINGS, STATE and actual PLAN/APPLY consumers.

Normal merge preserves unrelated settings and entries. A missing desired event/ID is appended; an exact existing entry is unchanged/adopted. A changed entry is upgraded only if it still equals the previous recorded managed entry. Ambiguous duplicates or an unexpected modification refuse the normal merge. Retired entries are removed only while equal to the old record. Explicit repair can overwrite a differing same-event desired ID, but the retired-entry drift check still applies. Do not call that deliberate repair behavior an accidental violation of normal-merge policy.

The actual uninstall helper keys by event plus ID and removes only exact recorded entries. Modified entries are retained with their expected/actual contents, while missing entries are reported separately. The same ID under another event is not silently acquired. It removes an empty hooks property without replacing the whole user's settings file. T-SETTINGS explicitly exercises each of these distinctions, including intentional identical-entry adoption and historical-event removal; none of those tests was run here.

## 3. Shared-file mutation has stronger local concurrency controls than a simple write

The settings writer acquires a cooperative ECC lock, reads a regular-file snapshot without following the final symlink, validates descriptor/path identity and raw contents, computes the transform, and rechecks immediately before replacement. The staging writer uses a private exclusive temporary file, flushes/closes it and renames it, with parent identity checks and a final snapshot callback. A detected settings change can trigger up to three attempts using the newly read settings. It is not merely an atomic replacement of a result computed once from stale data. Sources: SETTINGS, LOCK, ATOMIC.

Lock creation publishes a fully written temporary lock through a hard link. Release/recovery verify file identity around quarantine. Recovery distinguishes a no-longer-live recorded PID from an invalid lock older than five minutes. The wrapper preserves a primary update error alongside a release error. T-SETTINGS includes real temporary-file and injected late-edit/parent-replacement cases, nested-writer rejection and simulated Windows/BigInt identity cases. Those definitions are more informative than only asserting that a lock file exists.

These controls are nevertheless local and cooperative. Other editors need not honor the ECC lock; the final read-to-rename interval is not a universal compare-and-swap primitive. Settings, copied runtime files and installation JSON are not one transaction. The Node file-system contract gives fsync a descriptor/device-specific scope, not a certificate for this whole lifecycle. No crash, concurrent process or installed-platform behavior was exercised. D-NODE is a narrow current contract reference, not a replacement for the fixed source.

## 4. A retained modified hook need not retain its executable dependencies

Entry-level preservation and runtime preservation are different effects. LIFE's ordinary uninstall runs every managed operation. For a settings operation it calls `uninstallManagedHooks` and records the settings path as retained if any modified hook remains. It still processes ordinary managed copy operations. Only deletion of install-state is conditional on retainedPaths being empty.

There is a concrete source binding rather than a hypothetical external dependency: sampled hooks.json commands require `scripts/hooks/plugin-hook-bootstrap.js` under the materialized target root. The hooks-runtime module supplies scripts/hooks and scripts/lib; actual helper/plan/apply paths install those copies. A user may change only a handler's timeout, leaving that local executable reference intact. The hook entry then differs from its record and can be retained, while unchanged managed bootstrap/helper copies qualify for removal.

Thus the conditional result is **preserved configuration text plus a removed local dependency**, not a demonstrated working retained hook. The command materializer's fixed root matters: this is not resolved merely by observing that the unmaterialized plugin source contains fallback roots. Conditions include a managed manual installation, the relevant recorded copies, a modification that retains the reference, and successful removal. A self-contained replacement command or an unremoved dependency is a counterexample. The public uninstaller honestly reports partial and preserves install-state; it does not certify that all retained hooks remain executable. No host failure or removed user file was observed. Sources: SETTINGS/LIFE/UNINSTALL, HOOK-SAMPLE, MODULES and HELPERS/PLAN/APPLY.

## 5. An installation-time MCP exclusion is not preserved in the stored merge payload

The source policy explicitly presents ECC_DISABLED_MCPS as an installation/sync output filter, not a live host toggle. The original `.mcp.json` at this pin contains the chrome-devtools entry. Cursor's actual adapter maps that source into a merge-json operation for `.cursor/mcp.json`. PLAN stores the complete source object as mergePayload; STATE deep-clones operation fields. Sources: MCP-POLICY, MCP-SOURCE, CURSOR, PLAN, STATE.

APPLY reads the disabled names from the environment and filters a cloned payload before merging into the current file. The operation's original mergePayload is not replaced with the filtered object in the final installation record. A whole-file content digest can describe the written bytes correctly while that recorded subset still includes the omitted server.

**Conditional normal-to-repair case:** chrome-devtools is absent from the user's target config; a selection producing the Cursor merge operation is installed with that name excluded. The written config omits the source entry, but the managed operation still records it. Doctor's merge-json branch compares against the complete recorded payload and can report drift. Because a managed non-copy operation selects recorded-operation repair, the later repair merges that complete payload without calling the MCP filter. Even with the same exclusion environment present, the server configuration can therefore be reintroduced.

This establishes a configuration transformation mismatch, not an executed MCP connection, process launch or live privacy incident. It does not apply identically to every copy-file MCP path, whose inspection uses a different digest predicate. A normal reinstall through APPLY filters again; no exclusion means the particular mismatch does not arise. The filter itself correctly removes selected source entries, as T-MCP is written to test; its local tests do not follow the persisted operation through doctor and repair.

Filtering a source payload also does not remove an already-present target entry: deep merge preserves a key omitted from the patch. That narrower behavior should not be mistaken for live revocation. No claim is made here that all Codex TOML sync paths share the same JSON algorithm.

## 6. JSON subtraction and backup restoration are different undo contracts

The general merge helper recursively merges objects and replaces scalar/array values. Its inverse-looking removal function is not a three-way restoration: it removes matching recorded leaves, removes arrays only when their length/order/contents match, and preserves differing values and unrelated keys. These are useful subset-preservation rules.

Suppose a pre-existing user leaf is A, the installed managed payload sets it to B, and it remains B at removal. On the normal PLAN/APPLY merge route, no previous value A is recorded by that producer. Removal can delete the equal B leaf; it cannot reconstruct A from the payload alone. A post-install user edit C instead survives the unequal-value check. Consequently, preserving unrelated/currently changed fields and restoring the pre-install state are distinct outcomes. This is a conditional source example, not a performed rollback or a claim about every target's policy.

LIFE does support previousContent/previousValue-style metadata: when actually supplied, that branch restores the whole saved content before considering subset subtraction. The generic branch's existence is not evidence that normal MCP installation supplied such a backup. Legacy Codex has an independently implemented producer that really captures whole-file snapshots; it must not be conflated with the general JSON operation. Sources: LIFE's payload/previous-value readers and repair/removal bodies, PLAN/APPLY, STATE and LEGACY.

## 7. Legacy Codex has real pre-ECC and per-attempt recovery records

The shell sync calls `begin`, then records affected paths before its writes and generators. ERR/INT/TERM handlers invoke rollback; successful processing invokes finalize. Source configuration mergers and Git-hook installer/sanity programs are real calls, but their full transformation or host-effect bodies are not certified by this lifecycle account. SYNC/LEGACY-CLI/LEGACY establish the ownership relationship independently of whether every generated instruction is useful.

Initial snapshots record prior file bytes/mode or absence. Repeated installation requires the previous installed files to remain unchanged and preserves the original pre-ECC snapshots. It also creates separate rollbackPaths and previousInstalledState, so a failed second install can restore the first installed state without losing the original user's baseline for eventual removal. Finalization records installed hashes and discards the temporary attempt records. Tests explicitly distinguish repeated-sync rollback from final uninstall.

Manifest-based removal checks current content against the installed hash, then restores the original whole file or removes an ECC-created file. Modified/unverifiable files remain. Safe-file checks reject final symlinks, unsafe ancestors and multiply linked files; deletion uses an identity-checked quarantine. The global core.hooksPath is restored only under a matching-current-path condition, otherwise a differing nonempty pointer is retained. Git documents this as a hooks-discovery setting, so restoring files and restoring the discovery pointer are separate effects. The tests inject its getter/setter rather than mutate actual Git configuration. Sources: LEGACY, SYNC, T-LEGACY, D-GIT.

The public uninstaller's automatic fallback requires no ordinary managed results, an eligible Codex selection and a legacy manifest. Explicit `--legacy-codex-sync` can reach marker-only cleanup. Without a manifest, the helper recognizes only one ordered marker pair outside fenced code; inline examples, duplicates and ambiguous pairs are not deleted as a known owned block. Other legacy-looking files are retained, not removed merely by name. Marker syntax remains a convention, not authenticated authorship. UNINSTALL/LEGACY and T-LEGACY.

## 8. A successful legacy restore can obstruct a later partial-uninstall retry

The manifest remains unchanged when any path is retained. This preserves recovery information, but it does not record which removal/restoration operations already succeeded.

**Conditional sequence:** F existed before ECC with bytes P; sync changed it to E, where P differs from E. G is another tracked file and has a post-sync user edit. First uninstall successfully restores F to P, retains G and keeps the original manifest. That manifest still records hash(E) for F. After G is otherwise resolved, a second uninstall reads the legitimate restored P, finds it unequal to hash(E), and retains F as modified/unverifiable. The previous success has become a blocker to completing the recorded removal.

This is not loss of P: its preservation is the positive outcome. It is a continuation/state-correspondence problem. A newly created file removed on the first pass is missing on retry and is skipped, so not every partial uninstall has the same problem. If all paths finish on the first pass, the manifest is deleted normally. T-LEGACY tests complete restoration, isolated drift retention, repeat installation and rollback, but does not combine mixed successful restoration with retained G and a second uninstall. No fixture was run here. Sources: LEGACY's manifest loop/state-deletion condition and full T-LEGACY.

Rollback also differs from uninstall: because partially written bytes may lack a completed digest, it restores the captured attempt snapshot rather than first requiring the current bytes to equal an installed baseline. That helps recover an interrupted writer but does not prove protection against unrelated edits made during the attempt. The shell traps do not cover every abrupt termination. Source status applying/installed, file contents and a multi-file completion are not a crash-safe transaction.

## 9. Evidence, bounded closure and next responsibility

The complete shared-settings, lock, atomic-writer, hooks-metadata, hook-consent, MCP-filter, state-record and legacy helper bodies were read, together with the actual legacy wrapper/shell producer. Three test files were fully inspected, not run. Existing full same-conversation APPLY/LIFE/PLAN/adapter/public-uninstaller sources bind the cross-writer findings. The hook source and module listing are selected concrete examples, not all-hook coverage.

Notes37–38 now meet G3's bounded maintenance question: common files and commands, shared entry/payload policies and a separate legacy ownership/recovery path are connected to their actual consumers. Q03c1/c2 keep distinct evidence. Q03b and Q03c3 retain guided Kimi retry, installed identity/authority, remaining material producer/host variants, concurrency, abrupt failure, durability and useful preserved behavior. Unexamined TOML merge, hook execution, complete sidecar-generation/host-validation and alternative adapter bodies remain role-sensitive variants, not silently certified dependencies. No safe-runtime, all-config or universal undo verdict follows.

The next selected responsibility is the already recorded G4, U17-A: representative interpreted procedure/host/generated-source variants, starting from the historical role frontier and actual manifests/generators. Establish a load-bearing source-to-selected-guidance relationship and a consequential variant rather than evaluate every skill or repeat installation. Selection and concrete source recovery belong to that new unit; it has not started. G5 scorecards/optional interfaces and G6 reverse inventory/CORE/joint evaluation remain open. Original Notes01–37, evidence, E06 exclusion and EXP-004 status are unchanged. Publication depends on checked entries/receipt/final STATE, not this note's creation alone.
