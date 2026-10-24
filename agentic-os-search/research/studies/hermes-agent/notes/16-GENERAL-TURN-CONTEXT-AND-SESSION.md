# U02 — Genel ajan turu, bağlam ve oturum

**2026-09-10 / SOURCE-BASED MECHANISM TRACE.** [Araştırma](../evidence/2026-09-10-turn-lifecycle/RESEARCH.md), [kaynaklar](../evidence/2026-09-10-turn-lifecycle/SOURCES.md), [ikinci geçici sentez](../synthesis/02-TURN-CONTEXT-AND-SESSION-PROVISIONAL.md), [kapsam/sonraki iş](../inventory/CORE-COVERAGE-2026-09-10.md).

Bu tur yeni HERMES deneyi değil, gerçek genel çalışma zincirinin genişletilmiş kaynak okumasıdır. Ordinary loop ve normal gateway path'inde girdi/lease/history → agent cache/build → turn context → API-message assembly → attempt middleware/transport → tool persistence/execute → stop/finalize → host persist/delivery ilişkisi açıldı. Her alt helper ve platform eşdeğer sayılmadı.

**M4'e önemli ek:** Normal admitted compaction, invalidate/reload ardından prompt'u gerçekten yeniden oluşturuyor; keep-prompt yalnız byte-equality durumunda eski nesneyi koruyor. C13 actual caller, eski V04 artificial invalidate→restore dizisinin gerçek compression sırası olmadığını gösteriyor. Yeni prompt'un turn/API-message taşıyıcısı kaynakta bağlandı; son provider/network readback ve actual UI timing hâlâ açık.

**Kontrol kapsamı:** DB-backed tool path'inde flush False etkiden önce durdurur; isolated/no-DB None path farklıdır. Persisted transcript, api_content, cached/frozen prompt, per-turn recall ve final delivery farklı görünümlerdir. completed, task kabulü/durability/delivery için tek genel doğruluk biti değildir.

**Yeni genişleme:** Kanban terminal-tool guard + task timeout kaydı, goal/loop/heartbeat göçleri bir tur-üstü iş katmanını görünür kıldı. İlk sonraki yetkili source birimi kanban task claim/run/terminal receipt ve tüketicisi; amaç iç model döngüsünü kullanıcı işinin kalıcı kabulüne bağlamak. Q26/Q29, SQLite/transport/CLI/alternate-platform/quality ve genel F01–F12 açık sınırları korunur. İş otoritesi [STATE](../STATE.md), plan v0.14.
