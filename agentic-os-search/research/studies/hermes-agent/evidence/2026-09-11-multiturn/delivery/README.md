# HERMES U04 — Çok turlu iş sürekliliği

**2026-09-11. Yeni araştırma ve deney tamamlandı; bu paketin GitHub yayını tamamlanmadı.**

Okuma başlangıcı: [ara sentez](SYNTHESIS.md) → [ayrıntılı araştırma](RESEARCH.md) → [kaynak kapsamı](SOURCES.md). [Kapsam/sonraki birim](COVERAGE.md) ve [karşı okuma](ADVERSARIAL-REVIEW.md) açıklamanın sınırlarını taşır.

Kanban goal-mode, oturum goal/loop/heartbeat ve gerçek CLI/gateway çağırıcıları incelendi. 21 tanılayıcı senaryo gerçekten çalıştırıldı; [ham sonuç](evidence/RESULT.json), [çalıştırma kodu](evidence/probe.py), [önceden sabitlenen SPEC](evidence/SPEC.md), [kaynak kimlikleri](evidence/INPUTS.json) birlikte korunur. Bunlar bütün HERMES'in çalıştırılması veya semantik iş kalitesi doğrulaması değildir.

Yalnız `source/heartbeat.py` tam upstream dosyasıyla byte düzeyinde eşleşir. Kanban goal-loop ve run-status manuel seçkileridir; full-parent fidelity açık kalır. Gerçek geçici SQLite, taklit task-writer/judge/model/clock/SessionDB-adapter sınırları ayrıntılarda belirtilir.

`repo-updates/` içindekiler **main'e uygulanmamış v0.16 aday metinlerdir**. Güncel canonical HERMES planı son karşılaştırmada v0.15'tir. Ana dal araştırma sırasında `e335438...` noktasına ilerlemiştir; karşılaştırmada yalnız Foundation değişiklikleri görülmüştür. Bu pakette o yollara müdahale yoktur.

[PUBLICATION-HANDOFF](PUBLICATION-HANDOFF.md) ve `publication_manifest.json`, dosyaları konuşma geçmişi veya eski ZIP'lerden yeniden üretmeden birleştirmeyi sağlar. `prepare_repository.py` yerel bir clone'da önce bütün hedeflerin hash/kapsam kontrollerini yapar; varsayılanı yalnız kontrol raporudur. Ağ çağrısı, commit veya push yapmaz. Repo yayını gerçek non-force ref/content readback ile ayrıca kapanmalıdır.

[REPRODUCTION](REPRODUCTION.md) deneyin nasıl yeniden çalıştırılacağını açıklar. Orijinal RESULT dosyasını değiştirmemek için yeni bir kopyada çalıştırılmalıdır. [MANIFEST.sha256](MANIFEST.sha256) teslim bütünlüğü içindir; davranış kanıtının yerine geçmez.
