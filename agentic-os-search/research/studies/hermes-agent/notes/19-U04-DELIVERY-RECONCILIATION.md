# 19 — U04 tesliminin ayrı kaydı ve uzlaştırılması

**2026-09-11 / PUBLICATION ONLY.** Kullanıcının yeniden gönderme isteği üzerine 21-durumlu özgün teslim [U04-B](../evidence/2026-09-11-multiturn/README.md) olarak kayda alınır. [Uzlaştırma](../evidence/2026-09-11-multiturn/RECONCILIATION.md), [33-dosya manifesti](../evidence/2026-09-11-multiturn/DELIVERY-MANIFEST.json), [tam ham RESULT](../evidence/2026-09-11-multiturn/delivery/evidence/RESULT.json), [araştırma](../evidence/2026-09-11-multiturn/delivery/RESEARCH.md).

Önceden main'de bulunan [18/U04-A](18-MULTI-TURN-GOAL-LOOP-AND-HEARTBEAT.md) 15 grup; B, G01–G12/H01–H09 olmak üzere 21 durum taşır. Ham kayıtlar, SPEC'ler ve probelar farklıdır. Aynı G/H numarası aynı deney değildir; A:G06 ile B:G10 gibi çapraz karşılıklar uzlaştırmada açıklanır. Ortak kaynaklar ve örtüşen koşullar bağımsız replication veya ürün başarı toplamı sayılmaz.

B:H08/H09 manager migration'ın normal/selective child-write fault kayıtlarıdır; yalnız tam heartbeat modülü, gerçek geçici SQLite ve azaltılmış adaptör sınırında geçerlidir. Gerçek SessionDB/compaction/driver doğrulanmış değildir. A:H05 stale-manager deneyi ile A:S10 history substitution kaynak bağı korunur. İki manuel Kanban seçkisinin tam parent byte/AST sadakati açık kalır.

Özgün 33 dosya `delivery/` altında byte değişmeden saklanır. İçlerindeki eski yayın-engeli/v0.16 adayları ve proposed note18/synthesis03 yolları tarihsel artefakttır, current authority değildir. Merkezi synthesis/03 ve eski evidence/notlar değiştirilmez; bu transfer dördüncü sentez veya yeni deney değildir. Güncel plan v0.17 publication reconciliation, teknik sıra değişmeden actual session lease/history → gerekli persistence/migration/driver recovery'dir. [STATE](../STATE.md), [PLAN](../RESEARCH-PLAN.md).
