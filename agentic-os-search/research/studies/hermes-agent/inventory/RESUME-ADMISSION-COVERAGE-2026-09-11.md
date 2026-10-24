# U06 — Devam kabulü kapsamı ve yeniden yön verme

2026-09-11 / plan v0.19. [STATE](../STATE.md) authority; [U05](LEASE-RECOVERY-COVERAGE-2026-09-11.md), [U04](CONTINUITY-COVERAGE-2026-09-11.md), [U02 F01–F12](CORE-COVERAGE-2026-09-10.md) korunur. [U06](../evidence/2026-09-11-resume-admission/RESEARCH.md)/[SOURCES](../evidence/2026-09-11-resume-admission/SOURCES.md). Bu tam repo census veya tamamlanma yüzdesi değildir.

| Alan | Gerçek yeni ilerleme | Hâlâ açık |
|---|---|---|
| F03 / Q40 history | Actual DB selector, model/display projection, marker/sidecar; gateway load/live-cache→agent caller | Quiet no-wait history ve final request ölçümü; actual DB/engine variants |
| F03/F08 / Q43 ownership | Actual holder-write guard/flush; process-local vs durable ayrımı; tam native registry L01–L07 | Task-run→session ownership, bütün writers/OS effects, actual DB holder-loss fault |
| F03 / Q41 rotation | Doğru tip'e write-adoption, native registry alias/conflict | L03 gerçek DB compaction değildir; migration fault/profiles/full-host rebind açık |
| F09/F10 / Q42 restart | Active marker promotion, fresh/authorized origin, startup gate/task, actual loop watcher/heartbeat command, post-turn complete | Startup preclaim/drain→actual admission receipt; tick-turn identity; OS crash/restart; heartbeat rotation watch |
| F09 / Q46 compute vs delivery | Startup obligation claim/redelivery ve resume_pending bastırma kaynakları | Ledger transaction/reconnect/profile/ambiguous send; gerçek user delivery |
| F01/F02/F11 | Gateway normal history/prompt/host sınırları genişledi | Quiet/API/TUI/native tüm yollar eşdeğer değil; Q07/Q22 final wire açık |
| F04/F05/F06/F07/F12 | Önceki açıklamalar korunur, yeni closure yok | Skill-ledger/sync/quality, provider/profile, tools/full-worker, backend/native, install/eval |

## Araştırma önceliği

En değerli **dar entegrasyon challenge'ı** Q42 startup preclaim→adapter carrier/drain→actual agent kabulüdür; gerekirse Q40 actual-DB/history consumer'ı birlikte izlenir. Tek kontrollü normal ve interrupted yolun acceptance/receipt'ini ayırmak hedeflenir. Tam kaynak+bağımlılık kurulamazsa bunu fixture ile kapatma; kaynak açıklaması ve executed coverage ayrı kalsın.

Bu kenar için tüm DB/OS arıza uzayını bitirme koşulu yoktur. **Sonraki geniş native araştırma adayı F10 cron/scheduler→run→delivery**: session'a bağlı tekrar ile host'tan bağımsız schedule/run kaydı aynı mı; iş nasıl başlar/sonuç kabul edilir/teslim edilir? Ardından provider/backend/delegation ve learning/ledger/sync kapsamı yeniden tartılır. Bunlar tamamlandı veya yeni mimari olarak benimsenmiş değildir.

U05 messages429 kaynak engeli artık current değildir. U06'nın yalnız tek süreç-içi modülü koşturmuş olması, önceden açık actual-DB/whole-restart kontrollerini kapatmaz. Test sayısını artırmak yerine açıklanamayan geçişe gidilir; nihai CORE/dört-alan/SOUL projeksiyonu için hâlâ erken.
