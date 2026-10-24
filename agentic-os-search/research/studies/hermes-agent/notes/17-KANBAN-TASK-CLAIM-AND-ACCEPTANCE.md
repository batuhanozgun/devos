# 17 — Kanban: kalıcı görev, claim/run ve sonuç kabulü

**U03 / özgün çalışma 2026-09-10; yayın kurtarması 2026-09-11.** [Araştırma](../evidence/2026-09-10-kanban-task/RESEARCH.md), [kaynak rotası](../evidence/2026-09-10-kanban-task/SOURCES.md), [kayıtlı sonuç özeti](../evidence/2026-09-10-kanban-task/RESULT-SUMMARY.json), [özgün kanıt arşivi](../evidence/2026-09-10-kanban-task/original-evidence.tar.xz), [yayın kaydı](../evidence/2026-09-10-kanban-task/PUBLICATION.md).

Genel tur sentezinin üstündeki kalıcı iş katmanı: task birden fazla run taşıyabilir; hazır etiketinin yanında dependency/claim koşulları bulunur; normal worker kimliği task/run/claim/board/workspace olarak aktarılır. Completion'ın kabulü, worker'ın düz metni veya rc=0 çıkışı değildir. Task/run/event transaction'ı, daha sonraki promotion/cleanup/notification ve semantik iş kalitesi ayrı kapanışlardır.

K01–K08'in kurtarılan kaydı; contested claim, stale run rejection, dependency tekrar kontrolü, commit öncesi rollback, commit sonrası exception, optional run guard ve nested-transaction sınırlarını kapsar. Gerçek SQLite kullanılmış kayıtlı deneydir; manuel seçkiler, azaltılmış DDL ve açık taklitler taşır. Full parent byte/AST, gerçek worker/dispatcher/goal judge, OS termination ve delivery doğrulanmış değildir. Bu yayında yeni deney yapılmadı.

[İkinci geçici sentez](../synthesis/02-TURN-CONTEXT-AND-SESSION-PROVISIONAL.md) değişmeden korunur; U03 onun kalıcı iş sınırına ek girdidir, üçüncü tamamlanmış sentez değildir. Sonraki teknik köprü Kanban goal-loop/worker devamı ile goal/loop/heartbeat'in ayrımıdır. Current authorization ve açık doğrulama borcu [STATE](../STATE.md) ve [planda](../RESEARCH-PLAN.md) yer alır.
