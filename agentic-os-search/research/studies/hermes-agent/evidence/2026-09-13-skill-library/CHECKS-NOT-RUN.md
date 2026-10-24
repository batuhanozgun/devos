# U15 — Çalıştırılmamış ayırıcı kontroller

**2026-09-13 / NOT RUN.** [A](SYNC-AND-LOCAL-STATE.md), [B](ARCHIVE-LEDGER-AND-DISCOVERY.md) source research'tür; aşağıdaki planlar gözlenmiş sonuç/PASS değildir. Yeni module/sync/curator/rollback/model/DB/OS/suite yürütmesi yoktur.

| Alan | Ayırıcı kontrol ve neden açık? |
|---|---|
| V1 baseline | Farklı yerel içerikli v1 manifest→iki ardışık actual sync; ilk skip ve sonraki rewrite ayrı ölçülsün. Kaynak çıkarımı, kullanıcı veri kaybı gözlemi değil |
| V2/local deletion/upstream removal | O/U/B kararları; source kaldırma/reintroduction ve kullanıcı silme niyeti. Manifest cleanup kalıcı tombstone değildir |
| Opt-out/essentials | install/startup/update/reset ile aynı profile'da essential exception, suppressed/deleted state ve actual list/view; blank-library genellemesi yok |
| Copy/manifest fault | Partial copy, .bak rotation, failed restore/cleanup, manifest atomic helper failure, concurrent sync, transient read/hash failure |
| Reset/restore contract | restoreFalse U=B ve U≠B; restoreTrue suppression/external/opt-out/copyfail. ok/action ile actual target content ve manifest birlikte ölçülsün |
| Name/path/source identity | Frontmatter adı≠dizin adı, rename/external/hub, official backfill and multiple exact copies; operational provenance vs historical authorship |
| Restore backup visibility | Official optional restore→`.restore-backups`→fresh list/index/bare-name and explicit-path view; actual higher-priority project/caches karşı durumları |
| Archive vs sidecars | Rename/cross-device move→suppression/state/ledger error. Physical visibility ve archived status/re-seeding ayrılmalı |
| Per-edit ledger | Disabled/write failure, full before capture, latest-backup fill fidelity, blob validity/concurrency, all mutation-writer coverage. Sync veya external edits otomatik tracked sayılmaz |
| Single rollback vs whole tree | Safety refusal/missing blob, mid-write failure; usage/suppression/cron/state after rollback. Blob restore policy restoration değildir |
| Whole-tree recovery | Staging/extraction/unstage failures, excluded nested metadata, target retention, concurrent library writer; cron restore failure and rollback result |
| Remote-library governance | Hub/org push/pull/approve/propose/merge, active-org marker freshness, author claim, offline revocation and local edit baseline; only reader-side code inspected |
| Index→view fidelity | first-wins listing vs collision refusal; create_dir-only config; project/external priority; platform/environment/disabled differences |
| Cache and payload | List TTL, index LRU/disk manifest, explicit read/dedup, mutation/compression invalidation, actual first model request and old-context survival |
| Readiness and efficacy | success+setup_needed, use/view/patch generation counters vs tools actually usable, instruction adherence, task acceptance and causal quality improvement |

Test source S05/S14 temporary fixture'lar ve bazı negatif koşulları anlatır; bu tur hiçbiri koşulmadı, tüm suite yokluğu/başarısı iddia edilmedi. Eski approval ve U13 manual-selection diagnostics tekrar çalıştırılmadı. Source/publish/ref kontrolleri runtime güveni değildir.

Q59 source advanced, bütün library/remote/quality kapanışı değil. Q58 install/update; Q57 host/DB/manual fidelity; Q54–56; U10Q49/Q51/Q52; Q40/Q42/Q47/Q48/Q50 ve eski Q07/Q22/Q26/Q29/Q38 korunur. Her fault'u bitirmek geniş araştırmanın ön koşulu değildir; load-bearing reuse veya karşı kanıt exact ölçümü yeniden açar. Bu dosya canlı kullanıcı ortamını değiştirme yetkisi vermez.
