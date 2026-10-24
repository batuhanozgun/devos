# U04 — Çok turlu iş, devam kararı ve yeniden uyanma

**2026-09-11 / yeni kaynak incelemesi + sınırlı yeni yürütme kanıtı.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Current release veya bütün ürün doğrulaması değil.

Başlangıç: [RESEARCH](RESEARCH.md) → [SOURCES](SOURCES.md). Üst açıklama: [üçüncü geçici sentez](../../synthesis/03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md). [SPEC](SPEC.md) çalıştırmadan önce Git nesnesi olarak kaydedildi. [RESULT-SUMMARY](RESULT-SUMMARY.json) yalnız türetilmiş gezinme görünümüdür.

## Tam kanıt ve yeniden üretim

[diagnostic-evidence.tar.xz](diagnostic-evidence.tar.xz), Git blob `89b1c87027f7e794133697ff07259474591affa4`, 9 özgün dosya içerir: tam ham RESULT.json, probe.py, INPUTS.json, tam heartbeat.py, manuel Kanban seçkisi, MIT lisansı, iki çıktı günlüğü ve yeniden üretim README'si. [MANIFEST](MANIFEST.json) her dosyanın kimliğini verir. Eski sohbet dosyasına ihtiyaç yoktur.

Arşivi yeni bir dizine açıp kodu inceleyin. `python probe.py --output fresh-result.json > fresh-stdout.txt 2> fresh-stderr.txt` özgün evidence/RESULT.json'u korur. Çalıştırma standart kütüphane ve geçici SQLite kullanır; ağ/model/süreç başlatma yapılmaz. Kendi test ortamındaki sonuç, üretim HERMES çalışması değildir.

G01–G10 manuel kopyalanmış tam bir işlevin kontrol akışını, sentetik judge/task/run/block callback'leriyle çalıştırır; full-parent byte/AST sadakati doğrulanmamıştır. H01–H05, Git kimliği eşleşen TAM heartbeat.py dosyasını çalıştırır; çevresindeki goals DB erişimi geçici SQLite adaptörü, saat sentetiktir. Gerçek Hermes SessionDB, Kanban DB, worker, gateway/CLI driver, profile, provider ve OS cancellation çalıştırılmadı.

15 grubun sabit beklentileri ve üç sınırlı negatif kontrol eşleşti. Bu sayı ürün başarı puanı değildir; eski K/N/M4/A/SA/AP veya diğer suite'ler tekrar çalıştırılmadı. stderr içindeki set_meta hatası H04'te bilinçli oluşturuldu; gizlenmiş kurulum hatası değildir. [PUBLICATION](PUBLICATION.md) aktarım ile davranış kanıtını ayırır.
