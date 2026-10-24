# U01-M2 — Bellek görünümleri ve bekleyen onayın yaşam döngüsü

**Araştırma ve yayın tarihi:** 2026-09-09. **Statü:** RECOVERED BOUNDED FIVE-FULL-MODULE EXECUTION. Yayın yeni deney veya tam HERMES doğrulaması değildir. Primary pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` korunur.

[Deney girişi](../evidence/2026-09-09-memory-pending/README.md), [tam araştırma](../evidence/2026-09-09-memory-pending/RESEARCH.md), [M2 kaynak defteri](../evidence/2026-09-09-memory-pending/SOURCES.md), [N01–N12 ham sonuç](../evidence/2026-09-09-memory-pending/RESULT.json), [kod](../evidence/2026-09-09-memory-pending/probe.py), [ölçütler](../evidence/2026-09-09-memory-pending/SPEC.md), [yayın/uzlaştırma](../evidence/2026-09-09-memory-pending/PUBLICATION.md), [aktarım bütünlüğü](../evidence/2026-09-09-memory-pending/TRANSFER-CHECK.json).

## Kaydedilen kanıt

Koşu UTC `2026-09-09T08:10:46.824877+00:00`, Python 3.13.5/Linux. Tam memory_tool_store, memory_tool, write_approval, write_approval_commands ve skill_provenance dosyaları Git blob kimlikleriyle doğrulandı. Geçici dosyalar ve Linux fcntl dalı gerçek; home/config/registry/terminal callback, zararsız sentinel tarayıcısı ve temp-write yardımcısı taklittir. Gerçek UI/AIAgent/provider/credential veya tehdit tarayıcısı çalıştırılmadı. Yayın sırasında hiçbir koşu tekrarlanmadı.

07/M01–Q27: hedef dosyayı değiştirmeden oluşturulan yazma hatasında disk eski, canlı store yeni, frozen snapshot eski kaldı. Tool yükseltti; ortak approve komutu hatayı bildirdi ve pending kaydı korudu. Reload/retry toparlanması gözlendi. Bu sessiz başarı veya tüm canlı caller'larda etki süresi iddiası değildir.

07/M02–Q28: aynı zararsız sentinel single new_text ve batch content ön taramasında reddedildi, batch new_text o taramaya uğramadan yazılabildi. Explicit reload aynı sentetik tarayıcıyla snapshot'ı maskeledi; raw/live içerik korundu. Gerçek tehdit algılama, modele zararlı içerik ulaşması veya üretim olayı doğrulanmadı.

N08–N12: staging, uygulama, hata raporu ve pending temizleme ayrıldı. N11'de yazı uygulandıktan sonra unlink hatası Approved 1 metniyle birlikte pending kaydı bırakabildi; tekrar add kayıt çoğaltmadı. N10 yalnız supplied-store flag kontrolüdür, gerçek UI config refresh değildir. N06 sıralı iki-store reload örneğidir, yarış testi değildir. Okunamayan dosyayı koruma ve hatalı/final-budget batch'te no-write gibi çalışan korumalar da kanıtta korunur.

## Mevcut araştırmayla birlikte okuma

Bu çalışma ZIP'te beklerken ayrı U01-D3 [10 notu](10-REVIEW-ADMISSION-AND-MIDDLEWARE-FAILURES.md) ve v0.8 yayımlandı; onlar değiştirilmedi. M2'nin [ayrı review kaynak notu](../evidence/2026-09-09-memory-pending/REVIEW-ADMISSION.md) J defterindeki çalışmanın bağımsız tekrarı değildir. D3'ün 22 manuel-range AST kontrolü vardır; tam E01/E02 orijinalleriyle verify_excerpts.py ve whole-worker entegrasyonu hâlâ açık. M2 bu boşluğu kapatmaz.

Özgün teslimin 10 numaralı taslağı ve NOT PUBLISHED/v0.7 metinleri evidence/delivery altında tarihsel kayıt olarak korunur. Current giriş bu 11 notudur. Güncel plan v0.9, M2 kanıtını mevcut v0.8 üzerine ekler; geriye dönmez.

## Sonraki aktif iş

Pinned gerçek CLI/gateway pending caller → onaylayan kimlik → home/profil → supplied live/fresh store → hata/sonuç/pending kapanışı. Ardından compression/reload/prompt/gerçek istek görünümü. Ortak command/store deneyi bu gerçek arayüz zincirinin yerine geçmez; aynı 12 fixture'ı çoğaltmak yeni entegrasyon kanıtı değildir. Q26/Q29 için ileri yeniden-açma koşulları, ledger/sync/skill-cache/curator ve F01–F12 genişliği korunur. Yetki ve sıra [STATE](../STATE.md), [plan](../RESEARCH-PLAN.md), kapanış [METHOD](../METHOD.md).
