# İlk keşif — Araştırma yönünü değiştiren gözlemler

**Tarih:** 2026-09-07. **Statü:** orientation + sınırlandırılmış çıkarım; bütün sistem modeli değil. Kaynak kimlikleri [defterdedir](../SOURCE-LEDGER.md).

## O01 — Tek bir chat veya prompt paketi olarak araştırmak yetersiz

**TARGET CLAIM / OBSERVATION:** H01 farklı girişleri, araç ortamlarını, kalıcı bellek/skills ve zamanlanmış işleri tanıtıyor. H02, CLI/gateway/ACP/batch/API/Python yollarını ve ortak AIAgent katmanını gösteriyor. T00/T01 ayrıca apps/desktop, web, native ve ayrı TUI yüzeylerini doğrudan listeliyor.

**INFERENCE:** İnceleme nesnesi yalnız LLM döngüsü değildir; işi kabul eden, çalıştıran, kaydeden ve yeni işi etkileyen bir yazılım sistemidir. Ortak çekirdek iddiası, bütün girişlerin aynı davranacağı sonucunu vermez.

**Plan etkisi:** Native kaynak aileleri yanında yürütme yüzeyi matrisi. U01 ilk sondajdır; geri kalan ürün onun alt başlığı yapılmaz.

## O02 — Belge kendi içinde veya başka belgeyle uyumsuz olabilir

H01 README, geçmiş aramayı FTS5 + LLM özetleme şeklinde tanıtıyor. H03'ün Session Search bölümü ise gerçek DB mesajları, LLM özetleme olmaması ve kaydırarak okuma anlatıyor. H02'nin genel çizimi terminal için altı backend derken aynı dosyanın ilerisi yedi diyor.

Bunlar runtime arızası kanıtı değildir; **kaynak-temsil uyuşmazlığıdır**. Sonraki araştırma actual session-search ve backend registry/dispatch koduyla ilgili yolu çözmelidir. Sayıları envanter ölçümü gibi kullanmıyoruz. Uyumsuzluğun hangi değişiklikten doğduğu henüz araştırılmadı.

## O03 — 'Öğrenme' tek sonuç değil, ayrı geçişler

H03 belgeleri frozen memory snapshot, canlı tool state, skill değişikliği, onay kuyruğu, review, journey ve external provider rollerini ayırıyor. H04'ün kodu buna farklı-model digest ve cache-parity fork ekliyor; H05/H06 autonomous origin ile kullanıcı tarafından üretilmiş skill sahipliğini ayırıyor.

**INFERENCE:** deneyim → aday ders → yazılabilir hedef → onay/uygulama → gelecekte bağlama girme → daha iyi sonuç zinciri kurulmadan bir learning-loop iddiası değerlendirilmiş sayılmaz. Bu geçişlerin hepsinin aynı durumda gerçekleştiği varsayılmayacak.

İlk kaynak notu [02-BACKGROUND-LEARNING](02-BACKGROUND-LEARNING.md). Bu zincirin yalnız orta bölümü yeterince görünür hale geldi; trigger, mutator/replay ve sonraki kullanım açıktır.

## O04 — Güvenlik politikası araştırmanın analiz birimini büyütüyor

**TARGET POLICY:** H13, in-process onay/scanner/allowlist mekanizmalarını adversarial LLM'e karşı containment sınırı saymıyor. Terminal-backend izolasyonu ile bütün proses ağacını kapsayan OS-level wrapper'ı ayırıyor; shell/file yolu dışındaki kod/MCP/plugin etkileri özellikle önemli.

Aynı politika session ID'lerini authorization değil routing aracı sayıyor; bir adapter'ın yetkilendirilmiş kullanıcılarını kendi içinde eşit güvenilen kişiler kabul ediyor. Bu, ayrıntılı per-caller yetki modelinin varlığını varsaymamamızı gerektirir. Polikanın tarif ettiği kuralların bütün kod yollarında sağlandığı henüz doğrulanmadı.

**Plan etkisi:** profile/session, çağrı onayı ve OS erişim sınırı farklı sorular. Review whitelist'inden tüm ajan güvenliği hakkında sonuç çıkarmama; gateway/UI/IPC girişlerinin kendi auth ve çıktı yollarına inme.

## O05 — Gstack yönteminin hangi kısmı taşınıyor?

Taşınan: immutable snapshot; mekanizma tabanlı okuma; provenance ağı; alt-sistem → ilişkiler → çekirdek sentezi; kaynaklara geri dönerek omission/distortion kontrolü; geç Foundation projeksiyonu.

Taşınmayan: Gstack'in 11 kümesi, SDLC sırası, çekirdek operating loop'u veya belirli bir testin yeterliliği. HERMES'te beklenen arka plan/persistence/kanal/kurulum yolları kendi kanıtından ayrıştırılacak. G01/G02 referansları Gstack'in study dosyalarıdır, agent-control rotaları değildir.

## İlk keşfin sınırı

Repo'nun bütün dosyaları okunmadı; bütün testler veya release çıktıları görülmedi. İlk plan dar kaynak örneğine dayanıyor ve genişletilecek. Buna rağmen ilk karşı okuma, araştırmanın 'memory + skills özellik listesi' halinde yürütülmesinin önemli geçişleri kaybettireceğini gösteriyor. Bounded sonuç budur; HERMES'in üstünlüğü veya genel güvenilirliği hakkında hüküm değildir.
