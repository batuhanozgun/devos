# EXP-001 — Özgün eser aktarımı: kapanmış devam noktası

**Güncel durum: TAMAMLANDI — 32 dosya yayımlandı ve Git içerik kimlikleri doğrulandı.** Kullanıcının yeniden ZIP göndermesi veya aynı klasörleri tekrar yüklemesi gerekmiyor. [STATE](../STATE.md), [PAYLOAD-VERIFICATION](PAYLOAD-VERIFICATION.md).

## Gerçekleşen devir

İlk turda diyalog, öğrenme/değişim kayıtları ve retrieval metinleri yayımlandı; altı özgün eser/ek ve kaynak ZIP'inin 26 üyesi eksik kaldı. Bu nedenle o tarihte PARTIAL hükmü doğruydu.

Kullanıcı, verilen tamamlama paketinin `repo-overlay/explorations/` klasörünü repository köküne yükledi. `a3987312bbfbb8aa0fbf4ea6fd8a1113d467f415` commit'i yalnız beklenen 32 yeni dosyayı içeriyor. Sonraki assistant turu, bu commit'i sabitleyip özgün paketten yeniden hesaplanan Git kimlikleriyle karşılaştırdı; metadata kapanışı bunun ardından yapılır. Yükleme ile doğrulama/kayıt güncellemesi ayrı olaylardır.

## Taşıma paketinin kimliği

- ZIP: `EXP001_Artefakt_Tamamlama_Paketi.zip`, 3.416.116 byte.
- ZIP SHA-256: `054983b46aaa6ac33b226445ce194c1125ff89e5a7a1e4bdbc11cb579783a5a2`.
- İçindeki PAYLOAD-MANIFEST.json SHA-256: `f694d43923ec28e190f985aa30de6b9eefbe739bd00f0c773695785ee1a9e42c`.
- Payload: 32 dosya, toplam 6.176.086 byte. Tekrarlanan HTML/PDF/Markdown, özgün ZIP yapısının byte-eşit kopyalarıdır; farklı canonical sürümler değildir.

Bu taşıma ZIP'inin kendisini repository'ye ayrıca yüklemek şart değildi. Kalıcı içerik olan 32 dosya beklenen yollarındadır; Atlas'ın özgün kaynak ZIP'i de bu 32 dosyanın içindedir.

## Önceki engel ve korunmuş yöntem sınırı

İlk aktarımda `create_tree → create_commit → update_ref(force=false)` metin yolu çalışmış, yerel büyük dosyaları doğrudan alan köprü bulunamamıştı. Yerel standart HTTPS/Git erişimi DNS hatası vermişti. Kimlik bilgileri başka kanala taşınmadı; büyük payload'lar bozuk literal metne dönüştürülmedi.

Önceki plan tüm dosyaları remote'dan indirerek SHA-256 denetimi öngörüyordu. Kapanışta doğrudan ağın DNS engeli sürdü. Bunun yerine **önceden hazırlanmış manifestteki ve özgün byte'lardan yeniden hesaplanan Git blob/ağaç kimlikleri**, GitHub connector'ünün pinned tree/path kimlikleriyle karşılaştırıldı. 32/32 eşleşme içerik-kimliği denetimidir; yalnız dosya sayısı değildir. Tam binary yeniden-indirme/SHA-256 denetimi yapılmış gibi yazılmadı. Bu yöntemin ayrıntı ve sınırı PAYLOAD-VERIFICATION'dadır.

İlk aktarım planının tam tarihsel sürümü: `c163836d959e3ada2f31afd353bb364671b5fb32` commit'indeki aynı dosya. Artık o sürümdeki “yeniden yükle” adımları güncel iş kuyruğu değildir.

## Önceki helper kontrolleri

Tamamlama paketindeki `tamamla.py <checkout>` dry-run/--apply/--verify kopyalama yardımcısıydı; commit/push yapmıyordu. Önceki 9 yerel kontrol: dry-run yazmama, eksik verify, 32 eşit kopya, tam verify, aynı içerikte idempotence, farklı hedefte durma, symlink reddi, yanlış repo origin reddi, bozuk kaynak reddi. Bu kontroller burada yeniden çalıştırılmış veya GitHub yüklemesini gerçekleştirmiş sayılmaz.

## Yeniden denetim gerektiğinde

Özgün dosyalar değiştirilmeden SOURCE-MANIFEST ve kaynak ZIP/manifest ile karşılaştırılır. Çelişen bir hash veya eksik yol çıkarsa yalnız ilgili arşiv işi yeniden açılır. Ham platform export'u elde edilirse diyalog sadakati ayrıca denetlenebilir; kaynak mesajlar sessizce düzeltilmez. Yaşayan plan araştırması, Atlas v0.2 ve ürün implementasyonu bu aktarımın devamı değildir.
