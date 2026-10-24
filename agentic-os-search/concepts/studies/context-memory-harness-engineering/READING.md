# Context / Memory / Harness — Okuma ve kalıcı kayıt durumu

2026-09-19, **B6-T4 / CMH-SOURCE-BOUNDED-DURABLE-EXTRACTION-COMPLETE**. Bu dosya concepts içindeki CMH paketinin yerel okuma ve kapanış kaydıdır. Kaynak araştırmanın STATE'ini, global concepts/STATE.md'yi veya bütün studies kapsamını ikame etmez.

## 1. Güncel sonuç ve okunacak parçalar

Sabit sekiz dosyalı CMH araştırmasının kalıcı kullanım çıkarımı tamamlandı: [TERMS.md](TERMS.md), [TERMS-MEMORY.md](TERMS-MEMORY.md), [TERMS-HARNESS.md](TERMS-HARNESS.md), [TERMS-SYNTHESIS.md](TERMS-SYNTHESIS.md) birlikte çıktıdır ve kullanım devralırken tamamı okunur. Yalnız ana dosyayı okumak bütün paket çıktısını okumak değildir.

B6-T2/T3 parça başlıkları ve içlerindeki PAKET-KISMİ/D4-bekliyor/eski-kimlik-eşleşmedi ifadeleri üretildikleri anın kayıtlarıdır. Güncel kapanış burada, güncel parça ve kimlik yönlendirmesi ana TERMS'in giriş/§10–11'indedir. D4'e bağlı H22.c tamamlandı. O tur yeniden üretilen D2 kaydının geçmişi silinmedi; bu tur görünür P1 satırlarıyla bellek kimlikleri için erişim eşleştirmesi ayrıca tamamlandı. Çıktılar eski konuşmanın sözcüğü sözcüğüne arşivi değildir.

**Sonraki seri iş:** global STATE ve SCOPE sırasına göre Superpowers kalıcı aktarımı. Bu CMH kapanışı B7/B8'i başlatmaz; mimari, ortak tanım, yeni ürün araştırması veya kaynak araştırmanın kullanıcı kabulü değildir. Superpowers'ın tamamlanmış pilotu yeniden yapılacak yöntem denemesi değildir.

İki neden korunur: kullanıcı okuma anındaki anlam seçimlerini denetleyemiyor; önemli yorum/dayanak/belirsizlik/değişiklik görünür olmalı. Ortak sözcükler ortak anlamı garanti etmiyor; kullanıcı onayı, kaynak kullanımı ve çıkarıcının açıklaması teknik doğruluğun yerine geçmez.

## 2. Kaynak bağlama ve kapsam

- Repository: batuhanozgun/agentic-os-search.
- Kaynak öneki: research/studies/context-memory-harness-engineering/.
- P1 kaynak ref'i: **ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a**.
- S1 kapsam ref'i: **9b46155e904560c90b89e657f3d0d4e00e2e46cf**.
- Paket tree: **e32d7736c4a3b31f123ab84eaafe053b0b2ca08e**.
- [Sekiz yapraklı değişmez manifest](https://api.github.com/repos/batuhanozgun/agentic-os-search/git/trees/e32d7736c4a3b31f123ab84eaafe053b0b2ca08e).
- B6-T4 başlangıç main: **a29b8a1a983d1b82a2f30320eaadcced04fa91f7**.

Başlangıçtaki güncel contents listesinin sekiz path/blob'u manifestle ve eski okuma tablosuyla eşleşti. Contents yanıtının son bağlantı kuyruğu araç görünümünde kesildi; ayrıca tam dönen, truncated=false olan sekiz girdili Git tree alındı. Paket alt dizin/binary içermez; sekiz dosya düz metin Markdown'dır. Önceki tree yeniden hesaplaması bu tur tekrarlanmış sayılmaz.

Kaynakların hepsindeki araştırma tarihi 2026-09-03'tür. META/STATE/INDEX güncel başlangıç commit'inden tam geri okundu; blob'lar eski kaynak ref'iyle aynıydı. Araştırma kendi STATE'inde bounded COMPLETE/user evaluation pending olarak kalır. Eski research/<paket> yol yazımları current studies konumuyla çözüldü; özgün metinler yeniden yazılmadı.

## 3. Tam dosya envanteri ve gerçek okuma

Bütün kipler 100644. P1 sekiz dosyanın önceki konuşma pilotu okumasıdır; B6 ayrı kalıcılaştırma turlarıdır. EOF gerçek kaynak sonunu görmeyi belirtir; istek üst sınırı dosya satır sayısı değildir.

| Dosya / kod | Blob SHA | Kalıcılaştırma için gerçek kaynak okuması | B6-T4 kapanış rolü |
|---|---|---|---|
| META.md | 55e8d5abe294e9c9b4ae0cd121c1cea3a74b7007 | B6-T1 tam; B6-T4 1–EOF yeniden tam | Study türü, relevance/reuse ipuçları, atıf ve otorite sınırı. |
| STATE.md | 298c0b1c6af6523a1da6b9bb0be018c5579573b2 | B6-T1 tam; B6-T4 1–EOF yeniden tam | Araştırma sonucu, yapılmamış deneyler ve eski yetki/return condition ayrı. |
| INDEX.md | 72c9756038330a499077fe8a6abebda5f280c79e | B6-T1 tam; B6-T4 1–EOF yeniden tam | Kaynak yönlendirmesi ve özetin alt dosyaları ikame etmemesi. |
| 00-WHY-THIS-RESEARCH.md / D0 | be59481ee543f3b1244262664d8e01ac26dec030 | B6-T1: 1–160, 161–340, 341–EOF. B6-T4: 1–160 yeniden; kalan tam araç metni aynı konuşmada mevcut. | §1–13 kaynak/hipotez/amaç/sınır hesabı tamam. |
| 01-CONTEXT-ENGINEERING.md / D1 | eed5603460ae9e74d4601b9204bf9502963b9be7 | B6-T1: 1–190, 191–390, 391–620, 621–EOF. | Aynı konuşmadaki tam kaynak ve mevcut TERMS karşılaştırıldı; sekiz yeni okuma iddiası yok. |
| 02-AGENT-MEMORY-ENGINEERING.md / D2 | 6203b06fe56cad61354e9093d0b404a1ee3592c7 | B6-T2: 1–220, 221–440, 441–660, 661–880, 881–EOF (son istek 1040). | Tam kaynak/metin ve TERMS-MEMORY; P1 bellek satırları için yeni erişim eşleştirmesi. |
| 03-HARNESS-ENGINEERING.md / D3 | 53f3cbcfbc934155553c9ae6c4ff931126b00876 | B6-T3: 1–220, 221–440, 441–660, 661–880, 881–EOF (son istek 1100). | Tam kaynak ve TERMS-HARNESS; H22.c D4 ile tamamlandı, yanlış D3 atfı üretilmedi. |
| 04-CROSS-LAYER-SYNTHESIS.md / D4 | 293ca01ac04952417d9d56b3c79c5f195dd6da35 | **B6-T4: 1–220, 221–440, 441–660, 661–880, 881–EOF (son istek 1100), tam.** | §1–25 ve görünür P1 G/X/İ kayıtları TERMS-SYNTHESIS ile karşılaştırıldı. |

Atıf yapılan bütün dış makale, SDK, video ve başka araştırma paketleri bu tur yeniden okunmuş değildir. Ham deney/kod yok; mevcut kaynakların hiçbir teknik deneyini yeniden çalıştırmadık. Okuma/aktarım doğruluğu dış kaynak doğruluğuyla aynı iddia değildir.

## 4. Önceki bölüm kontrolleri ve korunmuş kayıtları

| Kaynak | Kapanmış bölüm hesabı | Ayrıntılı değişmez okuma kaydı |
|---|---|---|
| D1 §1–25, D0/girişlerin ilgili bağlamı | K01/K02, C01–C28, E-CTX-01–10; kaynak sınıfları, işlemler, değerlendirme, proje ve sınırlar. | [B6-T1 READING](https://github.com/batuhanozgun/agentic-os-search/blob/faea7163b3ac72a2d9ec80182cd9b79eb907f798/concepts/studies/context-memory-harness-engineering/READING.md) |
| D2 §1–30 | D2-U01–U37; REP/Q/UP/R/T/MD/E/P/CB/EX/N grupları; kaynak rolleri, zaman, kapsam, değerlendirme ve iki handoff. | [B6-T2 READING](https://github.com/batuhanozgun/agentic-os-search/blob/429990ceb7e1ef6b328f16a9fd97dceba3724e7b/concepts/studies/context-memory-harness-engineering/READING.md) |
| D3 §1–31 | K05–K07, H01–H27; D3-F/E/P/N; faaliyet/nesne, amaç/sonuç, rol ve kontrol, aday alt sistemler. | [B6-T3 READING](https://github.com/batuhanozgun/agentic-os-search/blob/b52cba0c73894188eebe80e5d30d4414f4326fa2/concepts/studies/context-memory-harness-engineering/READING.md) |

Bu bağlantılardaki eski next/açık durumlar tarihseldir. Bugünkü kapanış için yalnız geçmiş durum notlarına güvenilmedi: erişilebilir tam D0/D1/D2/D3 kaynak içerikleri ve dört kalıcı kullanım parçası karşılaştırıldı. Ayrıntılı eski kontrol tabloları kaybolmasın diye bu değişmez kayıtlarda tutulur; burada aynı uzun tabloların ikinci current kopyası üretilmez.

## 5. D4 ve girişlerden kayıtlara son kapsam kontrolü

Kontrol, yalnız terim listesinin düzgün görünmesine değil, kaynak bölüm/liste/tablo/örnek/atıflarından kayıttaki karşılığa dönmeye dayanır. Aynı assistant'ın kaynak taraflı kontrolüdür; bağımsız doğrulama değildir.

| Kaynak bölümü | Kalıcı karşılık / kontrol sonucu |
|---|---|
| D4 §1–3 | İ01–İ03, D4-N01, kaynak-içi harita açıklaması. Problem/mekanizma/model uyarlaması ayrılır; ASCII harita mimari yapılmaz. |
| D4 §4 | G01 ve erişim/sunum/işletim soruları. RAG okuma yolu, bütün bellek yaşam döngüsü değildir. |
| D4 §5 | G02, D4-KG01–08. Sorgu görünümleri ile kalıcı ilişki örnekleri; graph edge'in bilgi statüsü korunur. |
| D4 §6 | G03, D4-FT01–05, İ04. Parametrik adlandırma ile harici işletim ve seçme/yönetme ilişkileri. |
| D4 §7 | G04, H22.c.1–5. Dar CAG, hesaplama yeniden kullanımı; kimlik, geçersizleştirme, sürüm, izin ve kararlı/değişken ayrımı. |
| D4 §8 | G05, D4-LC01–06. Kapasite, kaynak paketi, maliyet ve koşullu kullanım; kalıcılıkla eşitlenmez. |
| D4 §9 | Beş satırlı kaynak matrisi ve PRIMARY/STRONG/INDIRECT/NOT SAME açıklamaları. Sayısal etki veya kesin üyelik değil. |
| D4 §10 | G06.a–d, İ05. Bellek/bağlam/harness/kaynak yönetimi; tek bir yeni modül yapılmaz. |
| D4 §11 | D4-U01–U06; kalıcılık, bellek, görünürlük, yetkili durum, erişim ve devamın farklı nesneleri. |
| D4 §12–13 | D4-N01/N02. İhtiyaçtan mekanizma seçeneklerine geçiş; yanlış policy örneği varsayımsal açıklama alanlarıdır, yeni arıza teşhisi değil. |
| D4 §14–17 | X01/X02, D4-P01–03; koşula göre yapılandırma sorusu, tarihli repo/control-plane yorumu ve gelecekteki audit. Yeni yetki yok. |
| D4 §18–19 | İ01/İ04 ve paket ilişki/yönlendirme sınırları. Eski beşli araştırma iptal edilmez, kendi concepts çıkarımı yapılmış sayılmaz. |
| D4 §20 | D4-Q01–06; iş, kaynak, bellek, bağlam, işletim ve model soru boyutları. Formül/eşik veya karar verilmez. |
| D4 §21 | AP-01–10 kaynak uyarıları; yeni hata olayları veya evrensel yasalar değil. |
| D4 §22 | F-X-01–12 kaynak bulguları/etiketleri; önceki anlamları tekrar eder, yeni bağımsız destek değil. |
| D4 §23 | Q01–09 ve ilgili G/H/D2 kayıtları; on beş açık sorunun özellikle promotion, fidelity threshold ve meta-level verification adları açık. |
| D4 §24–25 | Sınırlı sentez kapanışı, tekrarlar, tarihsel next/return. Mevcut concepts kapanışıyla karıştırılmaz. |
| D0 §1–4 | K/C/G/İ, D0-R01 ve D4-U07. Başlangıç hipotezi, olgunluk iddiası ve bellek zemini adları; atıf/güncellik sınırı. |
| D0 §5–6 | X01/X02, tarihli repo ve gelecekteki sistem amacı. Bugün inşa edilmiş ürün varsayımı yok. |
| D0 §7–10 | D0-R02/R03; on beş araştırma sorusu, kaynak sınıfları, dosya planı ve yedi hipotez. Bölüm kayıtlarıyla bağlantılı; yeni araştırma yükümlülüğü değil. |
| D0 §11–13 | Mimari sınırlar, C/M/H atıfları ve tarihsel handoff. G/K/X ve parça kaynak listeleriyle karşılanır. |
| META | P-META01/02, X03; focused-topic, potential relevance/reuse/revisit ve otorite sınırı. |
| Kaynak STATE | P-STATE01/02; bounded COMPLETE/pending, verification sınırları, next logical/authorised ve return condition. Özet tekrarları bağımsız delil değil. |
| Kaynak INDEX | P-INDEX01; routing ve kaynaklara dönüş, eski yol yazımları, kısa sonuç ve authority sınırı. |

D1/D2/D3 için eski kontrol tablosunun işaretlenmesiyle yetinilmedi: özellikle K01/K02 atıf-genişletme; K07 faaliyet/nesne/amaç; D2 canonical-state/parametrik kapsamı; üç handoff; zaman alanları; ayrı değerlendirme başlıkları; yalnız adı geçen temel terimler; source listeleri ve tarihsel proje anlatımları kalıcı parçalarda yeniden karşılaştırıldı. Maddi tersine çeviren yorum hatası saptanmadı. D4'ün retrieve/select/inject cümlesinin bütün parametrik belleğe genişletilmemesi ek kapsam nitelemesi olarak görünür kılındı.

## 6. Pilot kimlikleri ve yorum değişiminin kapanışı

Görünür P1-T1/T2/T3 çıktılarıyla kalıcı kayıtlar arasındaki hesap: K01/K02 ve C01–C28 ana TERMS'te; K05–K07/H01–H27 harness parçasında; G01–G06/X01–X03/İ01–İ05 sentez parçasında. Numara taşımayan değerlendirme ve ek alan adları ilgili E/REP/T/MD/N gruplarında karşılık bulur. H22.c D4'e yanlış atıf yapmadan tamamlanmıştır.

**B6-T2'nin bellek erişim sınırı korunur, yeni bağlantı ayrı kaydedilir.** Bu tur görünür K03/K04/K08 ve M01–M28 satırları sabit D2 içeriği ve TERMS-MEMORY ile karşılaştırılarak ana TERMS §11'e yönlendirme tablosu yazıldı. D2-* kimlikleri yeniden numaralanmadı. Bir eski gruba birden çok yeni adres düşmesi birebir metin eşitliği değildir; eşleştirme eski kullanımın kaybolmamasını ve bulunmasını sağlar. M22'nin substrate/store bağlamı D4-U07 ve D0/D2 kaynaklarıyla ayrıca adreslenir. Bu çalışma B6-T2'de aslında eski yanıt görünüyordu iddiası değildir.

Bellek parçasının trajectory/scoped-memory düzeltmeleri ve yerel bölüm atfı cd2e8f5ab00bfae915f97336778c24946848a85a sürümünde aynen korunur. Bu tur bellek/harness kullanım gövdelerine ortak tanım yazılmadı. Parçaların tarihli açık durumları ana TERMS girişinde açıkça tarihsel sayıldı; güncel yetki/sonraki iş bu READING ve global STATE'dedir.

## 7. Kapanış kararı ve neyi kanıtlamadığı

**CMH kalıcı kaynak kapsamı kapalıdır.** Sekiz dosyanın tamamının okuma hesabı vardır; kullanımlar kaynaklarına bağlıdır; kaynak tarafından bölüm/liste/örnek/atıf kontrolü yapılmıştır; bulunan D4/kimlik/sınır açıklıkları kaydedilmiştir; bu pakette okunamamış dosya veya çözülmemiş somut aktarım eksiği bırakılmamıştır. Kaynağın kendisinin genel tanım vermediği veya araştırma sorusu olarak bıraktığı anlamlar açık statüsüyle çıktıdır.

Bu karar sıfır atlama garantisi, bağımsız araştırmacı incelemesi, dış kaynakların güncel doğruluğu, yeni-oturum davranış testi, ürün etkinliği veya genel terminoloji çözümü değildir. Somut yeni atlama bulunursa ilgili kullanım; yeni/değişmiş dosya varsa ilgili delta yeniden açılır. Soyut olarak daha fazla bilgi edinilebilir olması, bu sınırlı çıkarımı sürekli açık tutma gerekçesi değildir.

Kaynak araştırmanın kabul durumu değiştirilmedi. Başka study atıfları o çalışmanın çıkarımı sayılmadı. Bu kapanış SCOPE/S1'deki 33 birimden yalnız ilkine aittir; büyüklükleri farklı paketler için dosya/terim sayısından ilerleme yüzdesi hesaplanmaz.

## 8. Yayın ve kaynak deltası

Başlangıçtaki kaynak envanteri P1/S1 ile aynıydı. Yayın öncesi **a29b8a1… → 217004f21c86da272e75416bc48098561bac8fbe** karşılaştırması yalnız iki concepts yazımızı ve eşzamanlı ecc/ROUND-U12-A.md ile ecc/STATE.md değişikliklerini gösterdi. CMH kaynağı, Superpowers kaynağı ve kontrol dosyaları değişmedi. ECC değişiklikleri korunur; S1'e sessizce karıştırılmaz ve ilgili paket işlenirken/B7'de tekrar geri kazanılır.

Yeni TERMS-SYNTHESIS içerik commit'i **c7df9370c7b67c06296656711a30e9db58283a72**; ana TERMS güncellemesi **217004f21c86da272e75416bc48098561bac8fbe**. Yeni parça 1–60, 61–120, 121–EOF aralıklarıyla tamamen geri okundu. Ana TERMS'in mevcut context kullanım satırları korunarak kaynak durumları ve tarihsel/güncel bağlantılar güncellendi; gerçek diff ve son geri okuma global kapanışta ayrıca kontrol edilir.

Bu READING henüz bilinmeyen kendi commit'ini veya yapılmamış yayın kontrolünü içermez. Yazma kapsamı yeni TERMS-SYNTHESIS, ana TERMS, bu READING ve global concepts/STATE'dir. METHOD/PLAN/SCOPE/INDEX, TERMS-MEMORY/TERMS-HARNESS, kaynak studies ve agent-control değişmez. Son yayın geri okumaları ve main/gerçek commit farkı görünür sonuçta ve global STATE'de kendi kontrol anına göre ayrılır.

## 9. Devralma

CMH yeniden yapılacak çalışma değildir. Global concepts/INDEX → STATE → SCOPE üzerinden sıradaki Superpowers kalıcı aktarımına gidilir. Superpowers paketine girerken güncel kaynak tree/dosya envanteri ile pilot ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847** ve tree **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12** karşılaştırılır. Kendi META/STATE/INDEX'i ve gerekli kaynak derinliği geri kazanılır; görünür P2-T1–T5 ekleri kontrol edilir. Yalnız geçmiş STATE özetiyle SP satırı uydurulmaz. Eski yanıt erişilemiyorsa METHOD §8 kaynak kontrollü yeniden üretim yolu kullanılır.

Sonraki paket bu CMH ilişki şemasına uydurulmaz. Superpowers için kendi READING/TERMS dosyaları gerçekten oluşturulana kadar var veya tamamlanmış gösterilmez. Bütün studies kapsamı ve deltaları bitmeden B7/B8'e geçilmez.
