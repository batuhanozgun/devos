# 18 — Kalıcı işten çok turlu devam, bekleme ve yeniden etkinleştirmeye

**U04 / 2026-09-11.** [RESEARCH](../evidence/2026-09-11-multiturn/RESEARCH.md), [SOURCES](../evidence/2026-09-11-multiturn/SOURCES.md), [SPEC](../evidence/2026-09-11-multiturn/evidence/SPEC.md), [RESULT](../evidence/2026-09-11-multiturn/evidence/RESULT.json), [synthesis/03](../synthesis/03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md).

Kanban goal-mode task'ın belirli run'ı için yerel çok turlu döngüdür; session `/goal`, `/loop` ve `/heartbeat` başka state/tetik/stop kuralları taşır. Judge done doğrudan task receipt değildir. Own-run review/superseded çıkışı eski çalışanı durdurabilir; callback outcome, durable acceptance, süreç çıkışı ve delivery aynı kapanış değildir. Gateway heartbeat watch ile persisted loop scan farklı yeniden etkinleştirme yollarıdır.

G01–G12 ve H01–H09 yeni bounded evidence: tam upstream-byte-verified heartbeat modülü, iki manuel Kanban seçkisi, gerçek temporary SQLite ve açık fixture'lar. Full-parent fidelity yalnız heartbeat için; actual SessionDB/AIAgent/OS/judge/host runtime/semantic quality doğrulanmış değildir. Normal kontroller ve negatif karşı yollar birlikte saklanır. Yeni kanıt eski suite'lerin tekrarı veya bağımsız corroboration değildir.

Sıradaki birim actual state_meta persistence, session migration/lineage ve host restart sonrası reactivation. Önceki notlar ve ilk iki sentez korunur; üçüncü sentez provisional'dır. Yetki, publication ve açık borç [STATE](../STATE.md)/[PLAN](../RESEARCH-PLAN.md)'dadır.
