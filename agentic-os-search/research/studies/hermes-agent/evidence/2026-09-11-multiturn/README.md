# U04-B — Ayrı 21-durumlu teslimin kalıcı kaydı

**2026-09-11 / PUBLICATION RECONCILIATION, NOT A NEW EXPERIMENT.** Bu dizin, sohbetten teslim edilmiş `HERMES_U04_Cok_Turlu_Sureklilik_2026-09-11.zip` paketinin 33 özgün dosyasını [delivery/](delivery/) altında değiştirmeden korur. [Uzlaştırma](RECONCILIATION.md), [teslim kimliği](DELIVERY-MANIFEST.json), [current STATE](../../STATE.md).

## Okuma girişi

[Araştırma](delivery/RESEARCH.md) → [kaynak defteri](delivery/SOURCES.md) → [özgün SPEC](delivery/evidence/SPEC.md) → [tam ham RESULT](delivery/evidence/RESULT.json) → [probe](delivery/evidence/probe.py). Paket-local [sentez](delivery/SYNTHESIS.md), [kapsam](delivery/COVERAGE.md) ve [karşı okuma](delivery/ADVERSARIAL-REVIEW.md) da korunur.

Burada **U04-B:G01–G12 / H01–H09** denir. Önceden yayımlanan [U04-A](../2026-09-11-multi-turn-continuity/README.md) ise G01–G10 / H01–H05 taşır. A/B etiketleri bu yayın uzlaştırmasının disambiguation adlarıdır; özgün dosyalardaki ID'ler değiştirilmemiştir. Aynı G/H numarası aynı deney anlamına gelmez. İki paket toplanarak ürün testi skoru veya bağımsız doğrulama sayılmaz.

## Tarihsel dosyalar ve güncel otorite

`delivery/README.md`, `PUBLICATION-HANDOFF.md`, `publication_manifest.json` ve `repo-updates/` ilk teslim anının durumunu korur. İçlerindeki “yayımlanmadı”, eski v0.15 tabanı, v0.16 adayları ve proposed note18/synthesis03 yolları **güncel çalışma yönlendirmesi değildir**. `prepare_repository.py` eski hash'lere bağlıdır; bu yayın için uygulanmadı. Mevcut note18, synthesis/03 ve A kanıtları ezilmedi. Güncel giriş [note19](../../notes/19-U04-DELIVERY-RECONCILIATION.md) ve package STATE'tir. B'nin paket-local sentezi dördüncü completed synthesis olarak sayılmaz.

Yeni HERMES koşusu, kaynak araştırması, upstream değişikliği veya bağımsız replication yapılmadı. Yapılan kontroller aktarım/hash, JSON/Python parse ve recorded probe/SPEC/input tutarlılığıdır. Yalnız heartbeat modülünün tam upstream byte kimliği B'nin özgün kanıtında doğrulanmıştır; diğer iki kaynak manuel seçki, çevre kontrollü fixture'dır. Gerçek SessionDB/worker/OS/model/driver ve kalite doğrulaması değildir.

## Devam

İlk teknik devam değişmedi: `agent/turn_facade.py` → `agent/turn_facade_lease.py::admit_durable_turn_lease`, actual SessionDB/history ve rotation/restart driver bağlantısı. B:H08/H09, manager migration sorusuna sınırlı ek kayıt sağlar; actual SessionDB entegrasyonu yerine geçmez. A:S10'un admission history substitution bulgusu korunur; basit same-session veya history-loss hükmü yoktur.

Dosyalar native Git metinleri olarak saklandığından eski sohbet ZIP'i gerekmez. Yayın başarısı bu dizinin bağlı olduğu gerçek main commit'i ve ref/content readback ile belirlenir; tek başına blob/tree oluşturulması yayın değildir.
