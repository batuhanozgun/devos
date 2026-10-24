# U01-M3 — Kaynak, deney ve devam yayını

**Tarih:** 2026-09-10. **Research/yayın hazırlık tabanı:** `91af4415c22e05b80484b935383ceeb04a3c5b7b`. **Primary upstream pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Bu tur yeni kaynak araştırması ve yeni bounded policy deneyi üretti; önceki ZIP aktarım turlarından farklıdır.

## 1. Kanıt ve içerik kimliği

Bu klasördeki on özgün core dosyanın Git tree kimliği `1052daf850945e5644239030d88fc2012305c1c2` olarak yerel byte'lardan hesaplandı. GitHub'da oluşturulan aynı core tree recursive olarak geri okundu; tüm yollar/blob'lar/boyutlar ve tree kimliği eşleşti, `truncated=false`. [MANIFEST.json](MANIFEST.json) bu on dosyanın byte, Git blob ve SHA-256 kimliklerini tutar. Manifest ve bu PUBLICATION dosyası core dışında sonradan eklenen kayıt yüzeyleridir.

Bu karşılaştırma dosya aktarımını bağlar; kaynak iddialarının doğruluğunu veya ürün davranışını kendi başına doğrulamaz. Runtime için ayrı [RESULT](RESULT.json), [SPEC](SPEC.md) ve [probe](policy_probe.py) okunmalıdır.

## 2. Yürütme statüsü

Yeni A01–A08 koşusu UTC `2026-09-10T05:42:55.258536+00:00`, Python 3.13.5/Linux. Tek tam upstream modülü `gateway/slash_access.py`, 5666 byte, Git blob `07204201e411f29f912bb9bba6beec0566acab9d` doğrulandıktan sonra import edildi. Config/source/platform nesneleri sentetiktir. Sekiz beklenti eşleşti; ayrıca gerçek import guard'ında değiştirilmiş kaynak reddi ve ayrı always-allow test mutantına duyarlı ret oracle'ı kaydedildi.

Gerçek CLI/gateway/profile/worker/memory/provider zinciri bu tur çalıştırılmadı. Normal UI caller zinciri pinned kaynakla incelendi; bu SOURCE INSPECTED statüsüdür. UI09 upstream test kaynağı okundu, koşturulmadı. Eski U01B/transport/U01B2/C/V/MW/N ve manuel-range AST deneyleri yeniden yapılmadı. Sonuçlar ürün PASS sayısına birleştirilmez.

## 3. Retrieval ve eski kanıtın korunması

Yeni canonical giriş [12 notu](../../notes/12-UI-PROFILE-AND-APPROVAL-CALLERS.md). STATE/plan/META/INDEX/OPEN-QUESTIONS güncel v0.10 devamını taşır. Önceki 01–11 notları ve eski evidence klasörleri değiştirilmez.

Önceki birikimli SOURCE-LEDGER'in tamamı `dbd340e8de555307fea331d34f457b8266b9d127` blob'uyla aynı package root'unda [SOURCE-LEDGER-THROUGH-V0.9.md](../../SOURCE-LEDGER-THROUGH-V0.9.md) adıyla aynen korunur; göreli kanıt bağlantıları bozulmaz. Yeni SOURCE-LEDGER, bu exact tarihsel defterle yeni UI defterini yönlendiren progressive retrieval yüzeyidir. Eski H/S/W/D/E/J/M2 kimlikleri silinmez veya yeniden numaralandırılmaz. Donmuş dosyanın eski current/next-work metni current authority değildir; STATE/plan v0.10 kullanılır.

## 4. Yayın ve kapanış sınırı

Değişiklik kapsamı yalnız HERMES study ve katalogdaki HERMES satırıdır. Control, Foundation, context/Codex, başka study, upstream veya uygulama/izin ayarları değiştirilmez. Bütün dosyalar güncel tabanın üzerine tek yayın commit'inde bağlanır; branch güncellemesi force olmadan yapılır. Commit kimliği bu dosyanın Git geçmişinden bulunabilir. Yalnız blob/tree oluşturulması main yayını değildir; yayın kapanışı ayrıca main referansı, commit farkı ve giriş/kanıt dosyaları geri okunarak kontrol edilir.

İlk sonraki yetkili araştırma, onaydan sonra gerçek CLI ve cached gateway turn'ünde disk → store → frozen snapshot → cached prompt → hazırlanan request görünürlüğüdür. Mode ayarı/cache eviction ile payload approve ayrımı korunur. Tam UI/profile/hook/transport ve Q26/Q29 ileri doğrulama sınırları açık kalır; bu yayın araştırmayı veya ürün güvenliğini tamamlanmış yapmaz. Yeni oturum bu kayıtları repodan bulabilir; sohbet ZIP'i çalışma otoritesi değildir.
