# U01-M3 — Yayın devri

**Durum: NOT PUBLISHED.** Bu kayıt 2026-09-10 teslim anını anlatır. Mevcut araştırma ref'i `91af4415c22e05b80484b935383ceeb04a3c5b7b`; canonical plan v0.9. Yeni çalışmanın SOURCE TRACE + SA01–SA08 sonuçları bu pakettedir, GitHub'da oldukları iddia edilmiyor.

## Teslim ve hedef

Paket içindeki `research/studies/hermes-agent/evidence/2026-09-10-pending-caller/` dosyaları araştırma notu, kaynak defteri, SPEC, tek tam upstream modül ve lisans, test kodu, ham sonuç, stdout/stderr, arşiv-source kontrolü, erişim/yayın kaydı ve manifesti içerir. Aday note path `notes/12-PENDING-CALLER-AUTHORITY-PROFILE-AND-VISIBILITY.md`'dir. Yeni main'de 12 kullanılmışsa mevcut notu ezme; sonraki uygun adı seçip linkleri uzlaştır.

`DELIVERY-MANIFEST.json` kendisi dışındaki bütün teslim dosyalarını byte/SHA-256/Git blob ile bağlar. Evidence MANIFEST yalnız evidence core dosyalarını içerir. İki manifest de davranış doğrulaması değildir. `verify_delivery.py` yalnız yerel bütünlük denetimidir; network, credential, commit veya repo değişikliği yapmaz.

## Kanıtı koruyarak yayın

Önce canonical AGENT ve gereken protokoller, ardından yeni main, package STATE/META/INDEX/METHOD/plan ve studies CATALOG okunmalı. Bu teslimin eski base ref'ini current main sanma. Önceki 01–11 notları ve bütün eski evidence dizinleri korunmalı; başka study/Foundation/context/Codex/agent-control dosyaları değiştirilmemeli. Bu payload'a ait Git blob'lar hedef repoda yoksa sadece hash'lerini tree'ye koymak yetmez: içerikleri hedef repoda oluşturmak gerekir.

Özgün araştırma/koşu dosyalarını değişmeden sakla. Sonradan PUBLICATION/TRANSFER-CHECK eklenebilir; bunlar eski koşuyu tekrarlanmış veya daha güçlü doğrulanmış yapmaz. Paket NOT PUBLISHED ifadeleri teslim anı olarak korunur; yeni PUBLICATION ve STATE gerçek başarılı yayını açıklamalı.

STATE, RESEARCH-PLAN, META, INDEX, SOURCE-LEDGER, OPEN-QUESTIONS ve yalnız HERMES katalog satırı birlikte uzlaştırılmalı. `CONTINUATION-DELTA.md` gerekli anlamsal değişiklikleri belirtir; otomatik eski dosya üzerine kopyalama talimatı değildir. Plan v0.10 ancak gerçekten yayımlanırsa current diye yazılmalı. Sadece bir STATE checkpoint'inin yazılması tam evidence yayını sayılmaz.

Birden fazla dosya mümkünse tek tree/commit; güncel base tree korunmalı; ref force=false ile taşınmalı. HEAD değişirse son ağaca farklar tekrar birleştirilmeli. Sonunda commit changed-files kapsamı, main ref'i, note12/evidence hash'leri ve cold-start entry dosyaları geri okunmalı. Bağlantıların ve manifestin gerçekten published object'leri gösterdiği doğrulanmalı. Yeni oturum yalnız repo'dan kaynak/test/taklit sınırını ve sıradaki işi recover edebilmelidir.

## Bu tur ne yapılamadı?

Yeniden discovery sonrası create_blob, create_tree, create_file ve update_file gerçek çağrıları Resource not found verdi. Hiçbiri başarılı olmadı; STATE checkpoint'i de yazılmadı. Settings/permissions değiştirilmedi, teknik root cause doğrulanmadı. Eski M2/D3 yayınları geri alınmadı. Main son okumada hâlâ91af441 idi. Bu, tek başına gelecekte de yazılamayacağı anlamına gelmez.

## Teknik ilk devam

M3 actual CLI/gateway çağrı gövdelerini açtı; tekrar yalnız bu gövdeleri keşfetmekten başlama. `agent/conversation_loop.py::_restore_or_build_system_prompt` → compression/keep-prompt → cached-agent reuse/eviction → hazır request/prompt içeriği zincirini primary pin'de aç. Yeni store eski stored prompt'u restore edebilir mi, hangi sınır yeni memory bytes'ını gerçekten API'ye gidecek içeriğe taşır? Provider'a hiçbir istek gönderme. Bütün ürün kurulumu veya credential kullanımı yetkiyi genişletir ve yapılmamalıdır.

Q26/Q29 tam-fidelity/whole-worker işi açık ve source/dependency/reuse tetikleyicileriyle korunur. SA06 bir deployment güvenlik açığı değildir; SA08 normal adapter source construction'ının hatalı olduğu kanıtı değildir. M2'nin ve yeni sekiz senaryonun tekrar sayısını artırmak açık entegrasyon halkasının yerini tutmaz.
