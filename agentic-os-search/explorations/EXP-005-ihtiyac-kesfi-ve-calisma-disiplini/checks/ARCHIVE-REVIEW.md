# EXP-005 — Arşiv denetimi ve yayın kaydı

**Tarih:** 2026-09-22. **İnceleme türü:** Kaynak karşılaştırmalı aynı-assistant self-review + sınırlı deterministik kimlik/sayım kontrolleri + GitHub doğrudan tree/ref okuması. Ayrı native reviewer kullanılmadı. Bu, DevOS davranış deneyi veya bağımsız konuşma transkripsiyon doğrulaması değildir.

## 1. Sabit kapsam

Kullanıcının son yetkisi yalnız EXP-005 ders arşividir. Geliştirme iptalinin kaldırılması, DevOS PR #1'e müdahale, agent-control değişikliği veya araştırma/deney başlatma bu kapsamda değildir. [WORK-PLAN](../WORK-PLAN.md), kaynak aktarımından önce ayrı branch'te `5d35479cde91f87dfe803fde7125dda4db72aae7` ile kaydedildi.

Başlangıç main: `4d8b8b1aba963d5503676bdcb73b7d68b40045d7`. Paket ve keşif dosyalarının tamamlanması ile main'de yayımlanması ayrı sonuçtur.

## 2. Gerçekten yapılan kontroller

| Kontrol | Gözlem / yöntem | Kapsam ve sınır |
|---|---|---|
| Kaynak konuşmanın sırası | U001–U048 ve A001–A047 görünür gövdeler on dosyada sıra ve konuşmacıyla aktarıldı; önemli geçişler kaynaklara karşı yeniden incelendi | Model-visible normalize aktarım; export veya gizli/eksik tool geçmişi değil |
| Sayım ve kimlik metadata'sı | Python ile manifest için kullanılan aralıklar, benzersiz ID'ler, on dosya ve 4+4+8+4+28+16+12+12+4+3 = 95 toplamı kontrol edildi; 48 U, 47 A | Bu test dosya gövdelerindeki bütün karakterleri veya bütün anchor'ları programatik karşılaştırmaz; metadata tutarlılığını sınar |
| Uzak kaynak kimliği | `0727ddfd671bb7042bc7f90c5e587210911c35c1` snapshot'ının paket tree'sinden on kaynak dosyasının blob SHA ve byte boyutları alındı; toplam 185.140 byte, manifestte kayıtlı | Hash arşiv byte'ını tanımlar; özgün platform mesajının byte sadakati veya anlamsal doğruluk kanıtı değildir |
| Özgün görev belgesi | Yerelde gerçek 20.369 byte ekten SHA-256 ve Git blob SHA hesaplandı. Uzak dosyanın blob'u `e66bd561bd48219a6de5141c21fa08b3b9f2fda4` aynı çıktı | Belgenin değiştirilmediğini destekler; belgedeki görev uygulanmış veya geçerli demek değildir |
| Görsel ekler | İki PNG doğrudan görüntülendi; boyut/hash hesaplandı. Metin envanteri kaynak notuyla karşılaştırıldı; OCR kullanılmadı | Git'te özgün PNG byte'ları yok; bu eksik gizlenmez |
| Özgün ekler paketi | `EXP-005-original-attachments.zip` oluşturuldu; ZIP CRC kontrolü ve içindeki üç dosyanın SHA-256 karşılaştırması geçti | Konuşma teslimidir; kalıcı GitHub kopyası değildir |
| Yönlendirme | Kaynak/konu/kümülatif okuma bağlantıları yazılan dosya yolları ve Git tree'siyle içerik incelemesinde karşılaştırıldı; EXP-004 kümülatif yolunun varlığı doğrudan okundu | Bağımsız crawler veya bütün tarihsel dış URL'lerin güncellik kontrolü yapılmadı |
| Kaynak–yorum ayrımı | U006/U007 ve özgün sözleşme ile A045/A047 karşılaştırıldı: plan/izin vardı; fiilî hazırlık ayrı. U033'ün dört-vaka sonucu genel yeterliğe yükseltilmedi | Aynı-assistant yorum; teknik derslerin kullanıcı tarafından ayrıca kabulü değil |
| Hassas içerik | Kaynak aktarımında credential değerleri, sistem/developer metinleri ve gizli muhakeme alınmadı; cihaz hostname'i maskelendi | Tarihsel görevlerde yalnız değişken adı ve repo/çalışma yolu korunur |
| Değişiklik kapsamı | `4d8b8b1… → 6a5a821e…` GitHub compare sonucu yalnız EXP-005 altında 20 yeni dosya ve explorations INDEX/CATALOG'da eklemeler gösterdi; önceki dosyalarda silme yok | Bu denetim kaydı 21. paket dosyasıdır. Son arşiv PR'si toplam 23 dosya, 5289 eklenen satır, sıfır silinen satır bildirdi |

Kaynak gövdeleri için ayrıca container'a otomatik indirme yolu denendi; DNS erişimi sağlanamadı. Bu girişim başarılı indirme, yerel tam-corpus lint veya otomatik full-byte transcription testi diye sunulmaz. GitHub connector okumaları ve kimlik karşılaştırmaları kullanıldı. Kaynak kapsamı ve normalizasyon [ORIGIN](../sources/ORIGIN-AND-ATTACHMENTS.md)'de açık tutulur.

## 3. Nitelendirilerek korunan iddialar

- A002/A003'te eksik merkezi motor teşhisi güçlüydü; A006'da kendisi sınırladı. Arşiv yeni engine zorunluluğu ilan etmez.
- Görev sözleşmesi vardı. Kullanıcının “plansızlık” itirazı ve önceki assistant'ın özrü, belge hiç yokmuş gibi geçmişi yeniden yazmak için kullanılmaz.
- U007'de gönderim/benimseme bildirildi. Bütün sonraki uygulamanın yetkisiz olduğu hükmü verilmez; yetki, hazır olma ve fiilî uygulama ayrılır.
- Dar yamanın küçük olması kendiliğinden tercih nedeni veya ret nedeni değildir. Bildirilen v2 sonucu yalnız o aday ve o test kapsamındadır.
- `401`, `404`, `command not found`, local commit araması ve eski PR görünümü kendi kapsamından daha büyük yokluk/ürün yetersizliği kanıtına dönüştürülmez.
- Yalnız son öz değerlendirme değil, o değerlendirmeyi sınırlayan ilk görev eseri ve önceki cevaplar da bulunabilir.
- U045 iptali ile U048 arşiv yetkisi ayrı tutulur; eski devam cümleleri güncel iş kuyruğu değildir.

## 4. Arşiv sınırları

Tam platform export'u, bağımsız transkripsiyon denetimi, tam Codex native çalışma günlükleri veya bütün önceki EXP kaynaklarının yeniden okuması yoktur. Görsellerin Git metin temsili, özgün görüntü dosyasına eşdeğer değildir. Tarihsel dış bağlantılar güncel kullanım rehberi olarak yeniden doğrulanmadı. Bu sınırlar yalnız burada değil paket STATE/INDEX ve kaynak notunda da görünürdür.

## 5. Gerçek yayın ve kapanış

- Research arşiv PR'si: **[#33](https://github.com/batuhanozgun/agentic-os-search/pull/33)**. DevOS PR #1'e müdahale değildir.
- İncelenen head: **`e46e0f9187c51d362b34114dbb416980f64d133b`**. Başlangıç main yeniden okundu ve değişmemişti; head sabitlenerek normal merge yapıldı.
- Merge yanıtı: `merged=true`, **`5e1b991866a7930448a0bd2f5ac58715776fedf1`**.
- Merge sonrasında exact commit tree'si ve STATE doğrudan geri okundu. `e46e0f9… → 5e1b991…` GitHub compare sonucu **sıfır dosya farkı** verdi; arşiv payload'ı değişmeden main'e ulaştı.
- Ardından STATE makbuzu `cbab3788e5ea57bf339f18e5e52130e8ebef3ad6`, WORK-PLAN kapanışı `63d9de911eda0cb3a9135bc163e326897ee3cf1b` ile kaydedildi. Bu son checks makbuzu kendi henüz oluşmamış hash'ini içine yazmaz; exact sürümü Git geçmişinden/nihai teslimden bulunur.

Kapanış kayıtları yalnız bu üç durum/denetim yüzeyini değiştirir; on kaynak dosyası, özgün görev eseri, dersler, manifest ve kütüphane bağlantıları aynı kalır. Son commit'teki üç kapanış kaydı ve main ref'i teslimden önce ayrıca geri okunur; geçmiş makbuzlar yeni kaynak iddiası oluşturmaz.

**Sonuç:** Arşivleme işi belirtilen kaynak kapsamıyla tamamlandı. Geliştirme hattı iptal, araştırma sorusu açık, yeni yetkili çalışma yok. İçerik yazıcılığı bırakıldı; bu makbuzların geri okuması ve kullanıcıya teslim dışında iş veya gözetimsiz süreç başlatılmadı.
