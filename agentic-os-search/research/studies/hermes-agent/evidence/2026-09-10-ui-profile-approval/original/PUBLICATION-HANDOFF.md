# U01-M3 — Yayın engeli ve sonraki oturuma devir

**Tarih:** 2026-09-10. **Durum: NOT PUBLISHED.** Bu teslim GitHub yayınının yerine geçmez. Bu tur yeni bir branch/ref/commit veya canonical dosya değişikliği başarıyla oluşmadı.

## Güncel canonical taban

Repository: `batuhanozgun/agentic-os-search`, branch `main`.
Son doğrudan ref kontrolü: `91af4415c22e05b80484b935383ceeb04a3c5b7b`.
HERMES planı: v0.9. Önceki U01-M2 bellek/pending kanıtı ve U01-D3 review/middleware çalışması zaten yayımlanmıştır; eski ZIP'lerin yeniden aktarılması gerekmez.

Son kullanıcı yetkisi HERMES araştırmasına operasyonel sınıra kadar devam etmektir. Ardından kullanıcı çalışmanın durup durmadığını sordu. Bu tur araştırma yapıldı; yayın için aşağıdaki gerçek çağrılar başarısız oldu. Hatanın nedeni Codex'e, hesap yetkisine veya kullanıcı ayarına atfedilmedi; hiçbir izin/ayar değiştirilmedi.

## Yapılmış çalışma

`evidence/RESEARCH.md` actual CLI/gateway pending callsite'larını, mesaj kabulü/komut erişimi ayrımını, primary multiplex transport/runtime profil bağını, live/fresh store tercihini ve approval-mode/approve/cache farkını açıklar. `evidence/SOURCES.md` UI01–UI11 için pinned blob ve gerçek okuma derinliğini taşır.

Yeni AP01–AP06 koşusu UTC `2026-09-10T05:40:37.183963+00:00`, Python 3.13.5/Linux. Tam slash_access.py Git blob kimliği doğrulandı; yalnız bu upstream modül, sentetik config/source/user-id girdileri ve standard-library bağımlılıklarıyla çalıştırıldı. Gerçek gateway, CLI, profil çözümleyici, pending yazımı veya model isteği çalıştırılmadı. Önceki N/MW/C/V deneyleri yeniden koşulmadı.

## Gerçek yayın denemeleri

1. Taze araç keşfinde görünen `GitHub.create_blob` çağrısı: `Resource not found: GitHub.create_blob`.
2. Yeniden keşiften sonra inline SPEC içeren `GitHub.create_tree`: `Resource not found: GitHub.create_tree`.
3. Taze tam şema keşfinden sonra, `main` üzerinde yeni SPEC yolu için `GitHub.create_file`: `Resource not found: GitHub.create_file`.

Bu yanıtlar başarılı GitHub yazımı, GitHub'dan permission reddi veya bekleyen commit değildir. Araçların şemada görünmesi, çağrının çalıştığına kanıt sayılmadı. Son `main` ref'i aynı kaldı. Çağrı zamanı ve backend kök nedeni bilinmediğinden tahminle doldurulmadı.

## Yayın tekrar mümkün olduğunda dosya eşlemesi

- Bu paketin `evidence/**` içeriklerini `research/studies/hermes-agent/evidence/2026-09-10-ui-profile-approval/**` altına aktar; özgün deney, SPEC, sonuç ve kaynak byte'larını koru.
- Kökteki `12-APPROVAL-ENTRYPOINTS-PROFILES-AND-STORE-BINDING.md` **taslaktır**. Güncel notes envanterini kontrol et; 12 boşsa notes altına yerleştir, değilse yeni numara kullan ve bağları düzelt. Taslak/publication cümlesini gerçek yayın durumuyla uzlaştır.
- Bu handoff ve `ACCESS-LOG.json` tarihsel yayın girişimi kayıtlarıdır. Yeni publication belgesiyle uzlaştır; bunları current-state otoritesi sanma.
- Yeni local manifestler artifact bütünlüğüdür; GitHub yayını veya ürün davranış doğrulaması değildir. Upstream blob kimlikleri research repo'sunda henüz var olmayabilir; yalnız foreign SHA'ya referans vermek yerine içeriği gerçekten oluştur.

## Etkilenen retrieval ve state yüzeyleri

Önce güncel main'i ve HERMES META/STATE/INDEX/PLAN ile kaynak defterini yeniden oku. Bu paket v0.9 tabanına dayanır; daha yeni ilerlemeyi ezme.

Yalnız HERMES paketi ve CATALOG'daki HERMES satırını güncelle. STATE'te M3 source trace/AP koşusunu M2 ve D3'ten ayır. INDEX ve SOURCE-LEDGER'a UI01–UI11/AP01–AP06 girişlerini ekle. META ve OPEN-QUESTIONS'ta normal CLI/gateway'in hangi store'u verdiğinin kaynakta çözüldüğünü, gerçek next-request etkisinin açık kaldığını göster. Uygun plan revizyonu, mevcut daha yeni sürüm yoksa v0.10 olabilir; bu teslim herhangi bir canonical sürümü şimdiden değiştirmiş değildir.

Q26/Q29 full-original/whole-worker soruları açık kalır. AP koşusu bunları kapatmaz. Foundation, SOUL context, Codex, başka study veya agent-control dosyalarını değiştirme. Kurulum/provider/credential/upstream/adoption yetkisi çıkarma.

## İlk sonraki teknik iş

Aynı gateway session'ında memory pending approve sonrası cached-agent seçimi → MemoryStore reload/frozen snapshot → cached system prompt → request oluşturma zinciri. Yazıyı onaylamak ve approval mode değiştirmek ayrı senaryolardır; `Approved 1` tek başına model-visible yenilik ölçüsü değildir.

Bu, önceki 12 N örneğini veya yeni altı AP örneğini tekrar tekrar çoğaltma görevi değildir. Secondary/relay varyantları, skill apply origin/ownership/default-name ve sonraki ledger/sync/cache/curator bağlantıları ayrı açık sorular olarak korunur. Geniş F01–F12 araştırması ve önce HERMES-native model sonra dört-alan/SOUL/Development OS sırası değişmez.

## Yayın kapanış koşulu

Başarılı dosya/blob üretimi yeterli değildir. Commit kapsamı yalnız yetkili yolları içermeli; güncel main üzerine non-force yayın yapılmalı; ref, yeni giriş dosyası ve kanıt kimlikleri GitHub'dan geri okunmalıdır. Bunlar olmadan 'repoya kaydedildi' veya 'yeni oturum yalnız repoyla bu turu görebilir' denmemelidir.
