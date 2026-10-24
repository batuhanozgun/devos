# Üçüncü video — Kaynak, kimlik ve gerçek okuma kapsamı

**Gözlem:** 2026-09-16. **Girdi main:** `0e797706ec68b9c7e687b2c671c4524c028c89e1`. Nesne, seçilen üçüncü video ve yalnız gerekli tamamlayıcı kaynaklardır. Önceki videoların okuma/test derinlikleri bu dosyayla artmaz.

## V01 — yüklenen video

- Kimlik: `PxuMqeIqCEo`; URL: https://www.youtube.com/watch?v=PxuMqeIqCEo
- Dosya: `AI Agent Memory Masterclass ｜ How Agents Remember and Forget [PxuMqeIqCEo].mp4`.
- Ölçülen boyut: 57,554,310 byte. SHA-256: `d900521274c1ba78d59f485befdb16b96dd77dff6bdda68d58ec24b649fd8177`.
- ffprobe: kapsayıcı 1637.814 saniye; video stream 1637.791667 saniye; 1920×1080, AV1 video ve Opus audio. Yaklaşık 27 dakika 18 saniye.
- 22 ayrı zamanda kare çıkarılıp üç temas sayfasında incelendi; 245s ve 1350s ayrıca tam çözünürlükte açıldı. Zamanların tamamı [MEDIA](evidence/MEDIA-READING.json) içindedir. Temas sayfası okuması ile tam ses doğrulaması aynı değildir.
- YouTube canlı sayfası eşlikçi yazıdan izlenirken retrieval hatası döndü. Yayın tarihi/native-caption kimliği doğrulanmadı. Arama sonucu aynı başlığı keşif düzeyinde gösterdi, fakat tam video kanıtı veya yayın sırası sayılmadı.

## V02 — yüklenen İngilizce SRT

- Dosya: `AI Agent Memory Masterclass ｜ How Agents Remember and Forget [PxuMqeIqCEo].en.srt`.
- Boyut: 46,295 byte. SHA-256: `0870a3a0fd164924b56af11f51536d3f41c84ebff6d19f3152ec9b53a26fb16c`.
- 636 cue'nin tamamı 1–220, 221–440 ve 441–636 ardışık metin görünümlerinde okundu. İlk cue 00:00:01,964; son cue bitişi 00:27:18,228. Son etiket kapsayıcı süresinden yaklaşık 0.414 saniye uzundur; bunu ses hizalamasıyla düzeltmedik.
- Cue'ler örtüşür; her cue bağımsız iddia değildir. CrikIT ve kişi/ürün adları farklı ve gürültülü yazılmıştır. 04:05 kare ve W01 yazısı isim/kural yazımını destekler; sesin tam olarak ne söylediğine dair sertifika değildir.
- Örnek proje özel/sadeleştirilmiş anlatımdır. Asıl issue thread, özel repo ve gerçek otomasyon yürütmesi doğrulanmadı. `@codex implement`, yayıncının anlattığı yerel workflow sözleşmesidir; evrensel ürün talimatı gibi kullanılmaz.

## W01 — ayrı yayıncı yazısı

https://www.thecarbonlayer.com/agent-memory-architecture/ — *Agent memory is context assembly over time*.

İşlevler, örnek, bakım ve beş soru dâhil bütün kısa render edilmiş metin okundu. Yazı doğrudan aynı YouTube kimliğine bağlantı veriyor. Temmuz 2026 / No.02 bilgisi yazı metadatasıdır; üçüncü seçtiğimiz videonun YouTube yayın sırası değildir. Yazı görsellerin sayfa için yeniden çizildiğini söylüyor; bütün deck ayrıca incelenmedi ve yeniden çizimler video karesi yerine kullanılmadı.

Bu yazı video ile aynı yayıncı ailesidir; bağımsız doğrulama veya birebir transkript değildir. CrikIT yazımı, örneğin klasörleri ve kaynak bağlantıları için kullanıldı. SRT'nin yaklaşık 19:19 bölümünde proposal geçerken yazılı iyi-cevap örneği proposal ve onay işaretini birlikte içerir; bu ek ifadeyi sesin yerine koymadık. Kaynağın diğer ürün/yayın bağlantıları ayrı araştırma yetkisi değildir.

## Dar birincil-kaynak karşı kontrolleri

Aşağıdaki sayfalar 2026-09-16'da görülen web temsilleridir; ürün kodu veya bağımlılık sürümü sabitlenmiş runtime testleri değildir.

| ID | Kaynak | Gerçek okuma ve görevi |
|---|---|---|
| D01 | https://arxiv.org/html/2309.02427v3 — *Cognitive Architectures for Language Agents*, v3, 2024-03-15 | Abstract/sürüm kimliği; §4 giriş ve §4.1 Memory tam ilgili metin, parse satırları yaklaşık 149–174. Bitişik grounding metni de yüzeye geldi. Working memory'nin çağrılar arası veri yapısı olması ve procedural memory'nin ağırlık/kod kapsamı için kullanıldı. Bütün makale, şekiller veya kaynakça araştırılmadı; yeni makale kampanyası başlatılmadı. |
| D02 | https://docs.langchain.com/oss/python/concepts/memory | Yaklaşık 23–100 ve 135–179: thread/state, kısa/uzun kapsam, semantic memory/search farkı, prosedür ve bakım/depo notları. Örnekler çalıştırılmadı. Giriş yolu https://docs.langchain.com/oss/python/langchain/long-term-memory baş/usage/storage bölümlerinden geldi; tüm API ve tutorial okunmadı. |
| D03 | https://hermes-agent.nousresearch.com/docs/user-guide/features/memory | How It Works / frozen snapshot / session boundary, yaklaşık 49–107; Session Search, 228–251. Başlangıçtaki doküman ana sayfası yalnız keşif içindi. Sabit prompt görünümü, disk güncellemesi ve tool-result canlı görünümü ayrımı; ürünün bütün hafıza sağlayıcıları veya kodu incelenmedi. Sayısal hız/limit ve güvenlik tarama iddiaları doğrulanmış performans diye kullanılmadı. |
| D04 | https://help.getzep.com/graphiti/getting-started/overview | Yaklaşık 75–104: zamansal graph, historical context, episode/provenance ve karma retrieval açıklaması. Performans/rakip karşılaştırma tablosu araştırılmadı veya benimsenmedi. |
| D05 | https://help.getzep.com/graphiti/core-concepts/adding-episodes | Seçilmiş reference_time örneği ve Loading Episodes in Bulk uyarısı, yaklaşık 95–125 ve 190–194. Zaman girdisi ile bulk invalidation sınırı için okundu; kod çalıştırılmadı ve implementasyonun bütün yolları izlenmedi. |

Parse satırları yalnız gözlem çıpasıdır; kalıcı dönüş için URL ve bölüm adları kullanılır. D01 daha eski ve daha geniş bir kavramsal çerçeve, W01 ise pratik daraltmadır. Birinin terimini diğerine sessizce eşitlemeyiz. HERMES güncel dokümanı sabit sürümlü mevcut HERMES araştırmasını güncellemez. Graphiti API uyarısı canlı hata gözlemi değildir.

## Kütüphane ve yetki geri kazanımı

AGENT güncel main'den okundu; aynı conversation'da tam okunmuş dokuz gerekli protokol etkin kaldı. Control dosyaları araştırma kanıtı değildir. Kanal STATE/META/INDEX/METHOD/VIDEO-CATALOG ve shared CATALOG güncel girdi ref'inden tam okundu. Önceki ikinci-video state/kapsamı ile META/PLAN/README, yalnız kullanıcının uygunluk değerlendirmesini doğru kaydetmek için geri kazanıldı.

Katalogdan `context-memory-harness-engineering/META.md` tam okundu: mevcut alan ayrımını zaten araştırdığımızı ve yeni videonun tüm kavramları ilk kez keşfetmediğini gösteren kapsam kaydıdır. Alt sentezi, uygulaması veya önceki sonuçlarının birincil kaynakları bu tur yeniden denetlenmedi. HERMES/GSTACK/foundation kampanyaları sürdürülmedi. Proje yorumu ilk-ilgi düzeyinde; current Foundation/DevOS tasarımı açılmadı.

## Yürütme ve kalıcılık

Gerçek yerel işler: dosya boyutu/SHA-256, ffprobe, SRT parse/metin görünümü, ffmpeg kare çıkarma, temas sayfası oluşturma. OCR, dış transcription hizmeti veya dış medya yüklemesi yok. Hafıza sistemi, retrieval benchmark, provider/model, veritabanı, ürün kurulumu, agent otomasyonu veya güvenlik testi çalıştırılmadı.

Orijinal MP4/SRT ve türetilen kareler konuşma ortamındaki dosyalardır; repository'ye arşivlenmiş medya değildir. Bu dosya ile MEDIA kimliği ve kapsamı saklar, gelecekte byte'ları var etmez. Tam transkript veya üçüncü taraf uygulama kodu yeniden yayımlanmıyor. Bulgular kaynaklara dayalı kendi açıklamamızdır. Repository yayını ayrıca gerçek diff/main/readback ile kontrol edilir.
