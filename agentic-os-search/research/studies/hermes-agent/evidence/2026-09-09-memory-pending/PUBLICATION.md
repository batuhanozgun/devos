# U01-M2 — Canonical yayın ve v0.8 ile uzlaştırma

**Yayın tarihi:** 2026-09-09. Bu kayıt, sohbet ZIP'inde kalan bellek/pending çalışmasının aktarımıdır; yeni araştırma koşusu veya bütün ürün doğrulaması değildir. Güncel iş otoritesi [STATE](../../STATE.md); güncel mekanizma girişi [11 notu](../../notes/11-MEMORY-STATE-AND-PENDING-LIFECYCLE.md).

## Özgün içerik ve doğrulama

`hermes-memory-pending-2026-09-09.zip`: 58.383 byte; SHA-256 `d7d79d0d77099e1f2401174aa34837de4529093b88d1489cc5568fffcfd5fcfd`. ZIP CRC ve delivery manifestinin 20 girdisinin byte/SHA-256/Git blob kontrolleri başarılıdır. Manifest dahil 21 özgün dosyanın içerikleri korunur.

Bu dizinin 18 özgün kanıt dosyası için yerelde exact byte'lardan hesaplanan Git tree `8fd2e95ccbdecf60f00b6342464a042952a346c6`, GitHub'dan geri okunan özgün tree ile eşleşir. Ek üç özgün dosya `delivery/` altında korunur: teslim manifesti, eski yayın devri ve önerilmiş 10 numaralı not. Manifestin özgün path alanları tarihsel teslim yollarıdır; yeniden yazılmaz. Yeni PUBLICATION ve TRANSFER-CHECK özgün manifestin parçası değildir.

Bu kontroller aktarım bütünlüğüdür. N01–N12 koşusu UTC `2026-09-09T08:10:46.824877+00:00`, Python 3.13.5/Linux olarak kalır. SPEC, probe, RESULT, loglar ve kaynak kopyaları değiştirilmedi; hiçbir HERMES deneyi veya eski AST verifier yeniden çalıştırılmadı.

## İlerleyen repository ile çakışmasız birleşim

Teslim hazırlanırken research tabanı `9a95b2cf1f8a0460ac6128e1409bf54aa3191022` idi. Yayın hazırlığında main `c0ef2374a34cbb30f5f58a28333f89254931b00f` olarak okundu. Yeni taban U01-D3 review/middleware çalışmasını, 10 numaralı notu ve plan v0.8'i içeriyor. Bunlar bu teslimden ayrı araştırmadır ve korunur.

Özgün M2 notunun 10 numarası güncel notes dizininde kullanılmaz; canonical giriş 11 olarak eklenir. Özgün 10 taslağı `delivery/` içinde byte olarak korunur, fakat oradaki eski göreli linkler current router değildir. Doğru bağlantılar 11 girişi ve bu dosyadadır.

M2'nin REVIEW-ADMISSION notu J kaynak çalışmasıyla örtüşen statik gözlemler taşır; bağımsız tekrar veya yeni MW kanıtı sayılmaz. M2'nin 'AST yapılmadı' ifadesi kendi çalışma dilimini anlatır. Current ayrım: D3'te 22 manuel-range AST cross-check yapılmıştır; tam E01/E02 dosya hash'iyle eski verify_excerpts.py ve whole-runtime entegrasyonu hâlâ açık. Bunlar birbirini silmez veya ikame etmez.

## Güncel anlam ve devam

Plan v0.9, v0.8'e M2 kanıtını ekler: M01/Q27 artık sınırlı write-failure/disk-live/snapshot/reload kanıtına; M02/Q28 sentetik sentinel scanner/alias ve load-time masking karşı-kontrolüne sahiptir. Gerçek CLI/gateway kimlik/home/profil/live-fresh store ve gerçek request görünümü kapanmamıştır. İlk aktif kaynak işi aynı gerçek pending caller sorusudur; mevcut 12 senaryonun sayısını artırmak onun yerine geçmez.

ACCESS-LOG, teslim devri ve özgün nottaki NOT PUBLISHED, eski main/v0.7-v0.8 önerisi ve erişim cümleleri tarihsel kayıttır. Bu yayın tamamlandığında current STATE/plan üzerinden okunur; kullanıcı ZIP'i elle aktarmak zorunda değildir.

Bu turdaki ilk iki tree hazırlığı, henüz hedef repository'de olmayan blob kimlikleri nedeniyle GitHub 422 döndürdü; içerikler yüklenerek düzeltildi. Bu, önceki tool-resource hatasıyla aynı olay değildir. Geçmiş araç sunumu sorununa kesin kök neden, Codex veya ayar açıklaması atfedilmez; ayar/izin değiştirilmedi.

Yayın kapsamı yalnız HERMES paketi ve CATALOG'daki HERMES satırıdır. Önceki 01–10 notları ve evidence dizinleri değişmez. Gerçek yayın commit'i bu dosyanın Git geçmişindeki ekleme commit'idir; blob/tree oluşturulması tek başına main yayını değildir. Ref force kullanılmadan ilerletilir; kapsam, main ve giriş dosyaları geri okunur.
