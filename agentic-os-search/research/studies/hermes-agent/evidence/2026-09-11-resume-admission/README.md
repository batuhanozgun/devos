# U06 — Devam kabulü ve restart araştırması

2026-09-11. [RESEARCH](RESEARCH.md) → [SOURCES](SOURCES.md) → [SPEC](SPEC.md) → [tam RESULT](RESULT.json) → [MANIFEST](MANIFEST.json). Güncel giriş [not21](../../notes/21-RESUME-ADMISSION-AND-DRIVER-RECOVERY.md), work authority [STATE](../../STATE.md).

Bu **yeni araştırma + sınırlı gerçek bileşen koşusu**dur; önceki U04 tesliminin tekrar yayını değildir. Primary pin değişmedi. Actual messages selector/guard ve gateway restart/command/adapter kaynakları okundu. Yalnız tam byte-matched `gateway/turn_lease.py` L01–L07 senaryolarında çalıştırıldı; gerçek SessionDB, gateway host, process restart, provider/model veya upstream suite çalıştırılmadı.

[diagnostic-evidence.tar.xz](diagnostic-evidence.tar.xz) 11 regular dosyayı korur: tam native module+MIT lisansı, original probe/SPEC/pre-run kaydı, tam RESULT, stdout/stderr ve iki açık mutant. Native SPEC ve RESULT arşivdeki dosyalarla aynı byte'lardır; summary veya yeniden yazılmış deney değildir. Archive SHA-256 `2b62b7b919e5cf710601bffff88bf50a058112add94b8b85bfc038c69779f7db`; raw RESULT `04663c7528a379c27450ddc2c0d91dd2f5182a751984062aa1af5f1a58e696a0`.

## Yeniden üretim

Arşivi ayrı geçici dizine çıkar, dosya kimliklerini MANIFEST ile doğrula, sonra o kopyada `python diagnostic/probe.py > diagnostic/RUN.stdout 2> diagnostic/RUN.stderr` çalıştır. Python standart kütüphanesi yeterlidir. Probe kendi bulunduğu dizinden source/ yolunu çözer; full upstream Git blob'ını import öncesi doğrular. Koşu o kopyadaki RESULT/stdout dosyalarını günceller; original repository ham kaydını değiştirme. Yeni koşunun tarihi/hash'i eski recorded run'la karıştırılmamalıdır.

L01–L07'nin hepsi önceden sabitlenen beklentileri karşıladı. L04 target-conflictte birleşmenin reddedilmesi, L07 iki ayrı registry'nin aynı SID'yi kabul etmesi beklenen **kapsam sınırlarıdır**, evrensel safety PASS değildir. N01/N02 ilgili bozmayı yakaladı, N00 kaynak mutasyonunu import öncesi reddetti. stderr'deki 0s timeout, kısa diagnostic bütçesinin kaynak logundaki yuvarlamasıdır; ürün default timeout'u sıfır değildir.

## Eski kayıtlarla ilişki

U04-A/B ve U05 dosyaları değişmez. U05 CHECKS-NOT-RUN'daki actual-DB/history ve whole-host restart kontrolleri hâlâ yapılmamıştır. U06, önceki messages429 engelini açtı; aynı engel yeniden sıradaki iş gibi gösterilmez. Üç merkezi provisional synthesis, 20 ve 21'in kaynak ekleriyle birlikte okunur. Dördüncü completed model, final CORE veya adoption yoktur. Yayın ref/content doğrulaması ayrıca [PUBLICATION](PUBLICATION.md) kaydında izlenir.

**Yayın yaşam döngüsü:** İlk başarısız girişim tarihsel kayıt olarak [PUBLICATION](PUBLICATION.md) içinde korunur. Kullanıcının yeniden gönderme isteğiyle hazırlanan yayın, aynı özgün U06 kaynak/deney kayıtlarını taşır; yeni HERMES koşusu değildir. Güncel yayın durumu ve gerçek ref/content geri okuması PUBLICATION’ın son makbuz bölümünden okunur.
