# ECC — Maintenance, shared configuration and recovery uses

2026-09-23 · **C6 post-U12 transfer / U16-A1–A2 extraction.** Bu dosya common managed maintenance ile shared configuration/legacy ownership-recovery kullanımlarını bağlamıyla taşır. ML kimlikleri evrensel installation lifecycle veya SOUL design primitive'i değildir.

Source packages:
- U16-A1 Note37 + U16-A1 sources + MR38 + publication.
- U16-A2 Note38 + U16-A2 sources + MR39 + publication.
Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
Tests inspected, not run; no installation/update/repair/uninstall execution by Concepts.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-ML01–ML28 | [Note37](../../../research/studies/ecc/notes/37-MANAGED-MAINTENANCE-OWNERSHIP-AND-PREVIEW.md) §§1–8 → [U16-A1 ledger](../../../research/studies/ecc/evidence/U16-A1-SOURCES.md) → [MR38](../../../research/studies/ecc/ROUND-U16-A.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U16-A1.md) | SOURCE OBSERVATION + TEST SOURCE INSPECTED + explicitly conditional lifecycle inference; no maintenance command run. |
| ECC-ML29–ML63 | [Note38](../../../research/studies/ecc/notes/38-SHARED-CONFIGURATION-OWNERSHIP-AND-LEGACY-RECOVERY.md) §§1–9 → [U16-A2 ledger](../../../research/studies/ecc/evidence/U16-A2-SOURCES.md) → [MR39](../../../research/studies/ecc/ROUND-U16-A2.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U16-A2.md) | SOURCE OBSERVATION + inspected tests + conditional shared-file/legacy recovery inference; no user files changed. |

A correctly implemented local control in one writer is not imported as evidence for another writer unless the cited source chain connects them.

## 1. Common managed maintenance

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-ML01 — managed maintenance lifecycle | Existing install-state discovery→inspect/doctor→repair/update/uninstall→state/projection continuation. | Native provider/legacy sync veya all-host lifecycle ile aynı contract değil. |
| ECC-ML02 — doctor | Recorded operations/content/version/module standing'ini inspect eden public command. | Current source equivalence, host loading veya useful capability certificate değil. |
| ECC-ML03 — saved-digest health | Valid contentSha256 varsa installed bytes'i saved digest'le compare etme. | Current source bytes'e eşitlik veya latest-version correctness değil. |
| ECC-ML04 — current-source fallback comparison | Usable saved digest yoksa current source/transformed expectation ile compare etme. | Historical installed intent guarantee değil. |
| ECC-ML05 — version-label check | Package/manifest version labels comparison. | Recorded repoCommit/current HEAD veya every file identity binding değil. |
| ECC-ML06 — zero checked population | No discovered valid install state ile doctor checkedCount=0/no issues/CLI exit0 path'i. | Healthy installed system proof değil; human output no-state bilgisini taşır. |
| ECC-ML07 — repair source selection | Record content/legacyMode'a göre recorded operations veya regenerated current manifest request seçimi. | One universal repair plan policy değil. |
| ECC-ML08 — regenerated repair plan | Current request/module/target sources üzerinden desired operations rebuild. | Historical management authority veya previous user-owned exclusion'u otomatik preserve etmez. |
| ECC-ML09 — user-owned install guard | Ordinary apply'da existing unrecorded copy destination'ı skipped/unowned bırakma. | Repair'ın every regenerated path'te same guard'ı çağırdığı guarantee değil. |
| ECC-ML10 — repair ownership adoption | Previously unowned desired copy'nin regenerated repair set'e managed operation olarak girebilmesi. | Observed user-file takeover değil; conditional source path. |
| ECC-ML11 — equal-byte ownership change | Repair write yapmadan current equal bytes'i refreshed state'te managed digest ile kaydedebilme. | No semantic change veya original authority established demek değil. |
| ECC-ML12 — bridge state refresh | Repair target writes öncesinde readable destinations'ın current hashes ile install-state bridge yazabilmesi. | Successful file repair receipt değil. |
| ECC-ML13 — baseline redefinition before effect | Managed user edit'in hash'i bridge'e yeni installed baseline olarak yazılıp later repair failure sonrası kalabilmesi. | Every repair failure causes loss değil; source ordering condition. |
| ECC-ML14 — apply preserveUnwrittenFiles | Ordinary failed apply checkpoint'inde untouched managed copies'in prior metadata/digest'ini preserve eden control. | General repair bridge aynı guarantee'yi inherit etmez. |
| ECC-ML15 — root global dry-run | Leading root `--dry-run` ile env flag set edip prefix'i child argv'den çıkarma. | Central mutation suppression değil. |
| ECC-ML16 — local dry-run | Child command'ın own parsed `--dry-run` option consumption. | Root env flag automatically consumed değil. |
| ECC-ML17 — preview propagation gap | Prefix dry-run repair/update'da child env'i decision için okumayınca mutating path'e girebilme. | Suffix repair/uninstall behavior veya observed mutation incident değil. |
| ECC-ML18 — dual-position uninstall preview | Uninstall'ın env + local flag iki formu da consume etmesi. | All destructive subcommands same support'a sahip demek değil. |
| ECC-ML19 — recorded-operation repair | LegacyMode/non-copy operation varsa entire record için saved operation set kullanma. | Every copy current source'dan regenerated/upgraded değil. |
| ECC-ML20 — no-op repair | No file changes halinde old installedAt/source metadata retain etme. | Current source verified/current installation demek değil. |
| ECC-ML21 — auto-update checkout validation | Candidate source root'un package/install-script/name predicates ile validate edilmesi. | Provider provenance/exact release artifact authority değil. |
| ECC-ML22 — fetch/pull replay | Git fetch/prune + ff-only pull sonrası saved selections ile target reinstall. | Exact release qualification veya all-target transaction değil. |
| ECC-ML23 — nested child status | Auto-update child result error/numeric nonzero status check'i. | signal+null-status path root CLI ile same refusal guarantee değil. |
| ECC-ML24 — removal candidate | Recorded managed operation whose current state qualifies for uninstall action. | Actual removed path veya safe-to-delete accepted outcome değil. |
| ECC-ML25 — drift-preserving uninstall | Modified/missing-digest/final-symlink copies'i retained path olarak bırakma. | Whole uninstall complete veya retained capability functional guarantee değil. |
| ECC-ML26 — partial uninstall state retention | Some removals + retained paths halinde install-state record'ın korunması. | Remaining-work-only cursor veya already-completed-step journal değil. |
| ECC-ML27 — planned removals | Dry-run'da recorded candidate set. | Actual drift-sensitive deletion set veya final effect guarantee değil. |
| ECC-ML28 — projection reconciliation | Repair/uninstall sonrası derived store projection refresh. | Target filesystem desired-state convergence veya host availability proof değil. |

## 2. Shared settings and hook ownership

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-ML29 — event+ID hook ownership | Claude settings'te managed hook contribution identity'si event + stable entry ID. | Authenticated author/user approval veya whole-file ownership değil. |
| ECC-ML30 — hook metadata sidecar | Stable IDs/descriptions + matcher/handler fingerprint alignment. | Cryptographic authorship/signature veya permission authority değil. |
| ECC-ML31 — desired hook validation | New desired entries için strict event/handler/global-ID predicates. | Historical recorded entries must pass same current contract değil. |
| ECC-ML32 — recorded hook validation | Removal/repair için looser historical structure acceptance. | Entry currently valid/useful for host değil. |
| ECC-ML33 — identical hook adoption | Existing exact event/ID/content entry'nin managed desired entry olarak adopted standing'i. | General file ownership policy; ordinary copy guard identical unowned file'ı acquire etmez. |
| ECC-ML34 — normal hook upgrade | Same event/ID old entry previous recorded bytes'e eşitse new desired form'a update. | Differing user-modified entry overwrite guarantee değil. |
| ECC-ML35 — retired hook removal | Old recorded entry still exact ise remove. | Same ID other event veya modified entry owned/removeable demek değil. |
| ECC-ML36 — explicit hook repair | Desired same event/ID differing entry'yi repair mode'da overwrite edebilme. | Normal merge policy veya outer human authorization ile aynı değil. |
| ECC-ML37 — cooperative settings lock | ECC writers arasında lock-file lifecycle/recovery/release. | Non-ECC editors obey lock veya universal mutual exclusion değil. |
| ECC-ML38 — snapshot retry | Settings file late change tespitinde fresh snapshot ile bounded retry. | CAS/transaction across settings+copied files+install-state değil. |
| ECC-ML39 — exclusive staging + rename | Private temp, flush/close, parent checks, rename replacement. | Whole-lifecycle crash durability veya concurrent logical update serializability değil. |
| ECC-ML40 — retained hook entry | Modified managed hook uninstall sırasında settings'te retained. | Its local executable dependencies retained/functional guarantee değil. |
| ECC-ML41 — retained-config/dependency split | Hook text retained olsa da unchanged managed bootstrap/helper copies same uninstall'da removed olabilir. | Observed host hook failure değil; concrete source dependency condition. |

## 3. JSON/MCP payload ownership

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-ML42 — mergePayload | General merge-json operation'ın recorded JSON subset/payload identity'si. | Pre-install before-image veya filtered written payload olmak zorunda değil. |
| ECC-ML43 — install-time MCP filter | ECC_DISABLED_MCPS ile cloned source payload'dan selected servers removal before merge. | Live host toggle/revocation veya persisted operation mutation değil. |
| ECC-ML44 — filtered-output/unfiltered-record mismatch | Written config filtered olurken install record original full mergePayload'ı preserve edebilmesi. | Observed server connection/data egress değil. |
| ECC-ML45 — doctor subset expectation | merge-json doctor'ın recorded payload subset'ini expected current config olarak kullanması. | Installation-time filter intent'i hatırlar demek değil. |
| ECC-ML46 — repair payload replay | Recorded-operation repair'ın original unfiltered mergePayload'ı reapply edebilmesi. | Same exclusion env automatically re-filters değil. |
| ECC-ML47 — omitted patch key retention | Deep merge patch'te absent source key existing target key'i remove etmez. | Live revocation semantics veya clean replacement değil. |
| ECC-ML48 — recursive JSON subtraction | Removal matching recorded leaves/exact arrays'i subtract eder, differing/unrelated values preserve eder. | Three-way restore veya pre-install value recovery değil. |
| ECC-ML49 — before-image absence | Normal PLAN/APPLY merge operation pre-existing overwritten user leaf'i record etmez. | Later generic remove original A value'yu reconstruct edebilir demek değil. |
| ECC-ML50 — explicit previousContent branch | Producer supplied previous-value/content metadata varsa whole saved state restore path'i. | Normal MCP producer actually supplies it guarantee değil. |

## 4. Legacy Codex ownership and continuation

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-ML51 — legacy ownership manifest | Pre-ECC file snapshots, installed hashes and lifecycle state carrying separate legacy sync record. | General managed-install JSON veya authenticated owner certificate değil. |
| ECC-ML52 — pre-ECC snapshot | First sync before-image bytes/mode/absence retained for eventual uninstall. | Current user intent veya semantic validity proof değil. |
| ECC-ML53 — installed hash | Successful sync sonrası produced file content baseline. | Original pre-ECC bytes veya future user edit identity değil. |
| ECC-ML54 — per-attempt rollback snapshot | Repeat install attempt öncesi immediately previous installed state. | Original user baseline ile same object değil. |
| ECC-ML55 — legacy begin/finalize | Attempt state setup + installed hashes publication and rollback data cleanup. | Crash-safe transaction across arbitrary termination değil. |
| ECC-ML56 — trap rollback | ERR/INT/TERM shell handlers'ın attempt snapshot restore path'i. | SIGKILL/power-loss/all abrupt failures coverage değil. |
| ECC-ML57 — legacy uninstall restore | Current bytes installed hash'e eşitse original whole-file before-image restore/remove. | Modified current bytes overwrite/delete guarantee değil. |
| ECC-ML58 — core.hooksPath restore | Current pointer expected ECC value ile eşitse old configured pointer restore. | Hook files restore edilince pointer automatically correct değil. |
| ECC-ML59 — manifestless marker cleanup | Explicit legacy cleanup'ta one unambiguous marker block outside fences removal. | Filename/name alone ownership veya authenticated authorship değil. |
| ECC-ML60 — partial legacy uninstall | Some paths restored/removed, others retained; manifest remains unchanged. | Completed progress cursor veya outstanding-only state değil. |
| ECC-ML61 — restored-path retry mismatch | Successfully restored P later old installed hash(E)'ye mismatch olduğundan second partial uninstall'da retained olabilir. | Restored data loss değil; continuation/progress-record mismatch. |
| ECC-ML62 — newly-created removed retry | First pass'te created file deleted ise next run missing path skip. | Every partial retry same blocker'a sahip değil. |
| ECC-ML63 — rollback vs uninstall predicate | Rollback attempt snapshot restores partial writer even when completed installed digest yok; uninstall installed baseline match arar. | Same recovery authority/condition değil. |

## 5. U16 non-collapse

- healthy historical copy ≠ current source copy;
- doctor ≠ update;
- desired plan membership ≠ historical management authority;
- equal bytes ≠ ownership;
- bridge-state write ≠ file repair success;
- error return ≠ no persistent state change;
- global preview request ≠ consumed preview;
- repaired paths/result arrays ≠ complete effect journal;
- retained settings entry ≠ retained executable dependency;
- installed filter ≠ recorded filter provenance;
- subset subtraction ≠ original-state restoration;
- pre-ECC baseline ≠ previous installed attempt state;
- rollback ≠ uninstall;
- retained manifest ≠ resumable per-path progress cursor;
- lock/atomic replace ≠ whole-lifecycle transaction.

U16 source packages provide bounded lifecycle/ownership explanations. Stronger installed identity, authority, concurrency, crash durability, host effect and useful outcome remain source-study residuals, not automatic Concepts tests.
