# U01B2 — canonical yayın ve mevcut state ile uzlaştırma

**Tarih:** 2026-09-08. Bu dosya U01B2 tesliminin repository yayın kaydıdır; özgün `PUBLICATION-HANDOFF.md` tarihsel teslim durumunu taşır.

## Kaynak ve bütünlük

Kullanıcının konuşmada erişilebilir `hermes-u01b2-2026-09-08.zip` dosyası açıldı. ZIP CRC kontrolü ve özgün MANIFEST içindeki 14 dosyanın byte boyutu/SHA-256 kontrolü başarılıydı. MANIFEST'in kendisiyle birlikte 15 özgün dosya bu dizinde korunur. Üç upstream dosya önceki U01B arşivindeki aynı Git blob nesneleriyle bağlanmıştır; kaynak değiştirilmemiştir. Probe ve RESULT blob'ları yerel dosyalardan hesaplanan kimliklerle eşleşmiştir.

Bu kontroller aktarım bütünlüğüdür; yeni HERMES koşusu, bağımsız davranış doğrulaması veya upstream freshness değildir. Eski koşu UTC `2026-09-08T15:48:02.995262+00:00` olarak kalır. SPEC/harness/RESULT/loglar yeniden üretilmedi.

## Çakışmasız yerleşim

İlk hazırlık tabanı `29ab9b816843bab6f9e5f5b5815590fbac2b1713`. Bu commit'teki 06 caller ve 07 memory notları ile context-transfer kanıtı korunur. ZIP'teki özgün `06-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md` bu kanıt dizininde tutulur; güncel araştırma giriş rotası [08 notudur](../../notes/08-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md). Böylece mevcut 06/07 adları ve anlamları değişmez.

`README.md`, `MANIFEST.json`, `ACCESS-LOG.json`, özgün araştırma notu ve `PUBLICATION-HANDOFF.md` teslimin tarihsel metinleridir. İçlerindeki NOT_PUBLISHED, eski main, eski plan ve erişim ifadeleri güncel repository durumuna alternatif değildir. Güncel çalışma otoritesi [STATE](../../STATE.md)'dir. Bu dizinin Git geçmişindeki ekleme commit'i gerçek yayın kimliğini taşır.

README'nin 'upstream yeniden kopyalanmayabilir' önerisine rağmen teslim manifestinin tüm dosyaları burada aynı blob'larla korunur. Hem `python probe.py --source-dir upstream --output NEW-RESULT.json` hem README'nin mevcut eski-arşiv yolu kullanılabilir; bu yayın turunda ikisi de çalıştırılmadı. Özgün not içindeki önerilen göreli kanıt rotası artık tarihsel öneridir; bu dizindeki README ve 08 girişi kullanılır.

## Current work korunması

Bu işlem yayın/süreklilik onarımıdır; yeni araştırma fazı değildir. V0.6 planı ve ilk actual executor/whitelist doğrulama sırası korunur. U01B2 bulguları sonraki pending replay ve rollback/diğer-yazar kontrollerine ek kanıt olarak bağlanır. U01B2'nin sentetik adapter/reentry'si gerçek caller kanıtı yerine geçmez. U01B, U01B2 ve transport deneyleri ayrı kapsam ve zamanlarıyla tutulur; toplam bir ürün PASS sayısı üretilmez.

Yazma araçları bu denemede yeniden keşfedildi ve GitHub Git veri yazma eylemleri tarafından kabul edildi. Önceki turda neden sunulmadıkları doğrulanmadı; kullanıcı izin hatası veya kalıcı arıza tanısı konmadı. Kullanıcının ZIP'i elle repoya taşıması gerekmez. Foundation, context/Codex, agent-control ve diğer çalışmalar bu yayının kapsamında değildir.

## Yayın öncesi eşzamanlı değişiklik kontrolü

İlk hazırlanmış commit `75afdf0b5320827f29cad4a9c1d5ddb420365b12` main'e taşınmadan önce main'in `4ad34d7429e5c63f2cbc327e79f3a0038c5568de` noktasına ilerlediği görüldü. `29ab9b8...` ile farkı yalnız research root ve soul-context altındaki dört dosyaydı; studies değişmemişti. Eski main'e force yapılmadı. Hazır studies değişiklikleri yeni root ağacına bağlandı, dört eşzamanlı değişiklik korundu ve yayın commit'inin ebeveyni `4ad34d7429e5c63f2cbc327e79f3a0038c5568de` olarak alındı. Diğer dosyalardaki `29ab9b8...` taban ifadesi bu ilk HERMES hazırlık tabanıdır; güncel yayın ebeveyni bu bölümde ayrılır. `75afdf0...` bir hazırlık nesnesidir, main yayın kimliği değildir.
