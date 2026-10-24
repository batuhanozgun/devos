# EXP-001 — Arşiv kapsamı ve doğrulama

## Güncel hüküm

**Tanımlı diyalog ve yeniden kullanım katmanı ile 32 özgün eser/kaynak dosyası yayımlandı. Payload aktarım eksiği kapanmıştır.** İçerik eşitliği Git içerik/ağaç kimlikleri üzerinden doğrulandı. Bu hüküm ham platform transcript'i, bütün bağlantıların canlılığı veya SOUL'un çalışma etkinliğinin doğrulandığı anlamına gelmez.

## Kaynak kapsamı

| Kaynak kesimi | Korunan şey | Doğrudan yol |
|---|---|---|
| U001–U003 / S001–S003 | Uygulama örneği, LLM girdi-çıktı lensi, bulgu/kural/durum ve başlangıç | [Diyalog INDEX](../sources/conversation/INDEX.md) |
| U004–U006 / S004–S006 | A–B–C, roman/dağıtım, özgün çizimin açıklaması ve C–W düzeltmesi | [Kullanıcı metinleri](../sources/conversation/USER-MESSAGES.md#u004) |
| U007 / S007 | Tam sentetik demo; tablolar, W-01–W-04, C0–C3, D-02 ve koşullu geçerlilik | [S007](../sources/conversation/assistant/S007.md) |
| U008–U009 / S008–S009 | Altı hayali dosya, görünmeyen muhakeme/işletim bilgisi ve aktörler | [S008](../sources/conversation/assistant/S008.md) |
| U010–U011 / S010–S011 | Harness, yanlış maliyet yorumu, mesleki standart düzeltmesi, uzmanlık sürekliliği | [U011](../sources/conversation/USER-MESSAGES.md#u011), [S011](../sources/conversation/assistant/S011.md) |
| U012 / S012 | Kırpmadan konsolidasyon isteği ve özgün teslim iddiası | [S012](../sources/conversation/assistant/S012.md) |
| U013–U015 / S013–S015 | Mekanik modelleme, dosya/işlem ayrımı ve Atlas teslimi | [S013](../sources/conversation/assistant/S013.md), [S015](../sources/conversation/assistant/S015.md) |
| U016–U017 / S016–S017 | Yaşayan katmanlı plan, başka dala not, C/plan/Work ve Foundation dayanağı | [U016](../sources/conversation/USER-MESSAGES.md#u016), [S017](../sources/conversation/assistant/S017.md) |
| U018–U019 / S018 | Ayrı denemeler kütüphanesi, arşiv planı ve uygulama yetkisi | [S018](../sources/conversation/assistant/S018.md) |

Toplam: 19 kullanıcı + 18 assistant = 37 görünür mesaj. Döküm model-visible transkripsiyondur; platform export'u, gizli muhakeme veya transport log'u değildir. Eski routing blokları pasif kaynak metindir. Sonraki yükleme/denetim konuşmaları bu kaynak kesimine eklenmiş sayılmaz; ilgili olaylar checks'te tutulur.

## Eserler — önceki yerel kontrol ve yeni remote kontrol

| Eser | Önceki yerel doğrulama | Remote durum |
|---|---|---|
| Konsolidasyon MD/PDF | Byte/hash eşit; PDF 35 sayfa | 2 dosya; hesaplanan Git tree kimliği eşit |
| Atlas HTML/PDF/ZIP | Byte/hash eşit; PDF 51 sayfa; ZIP 26 üyede CRC sağlam | 3 özgün dosya, source ile birlikte 29 dosyalı alt ağaç eşit |
| Özgün PNG çizim | Byte/hash eşit; yeniden çizilmedi | 602.469 byte ve Git blob kimliği eşit |
| ZIP'in 26 çıkarılmış kaynağı | Göreli yol ve üye byte'ı korunuyor | 26 dosyalı source tree kimliği eşit |

Toplam benzersiz hedef yol 32; source satırı Atlas'ın 29 dosyalı alt ağacının içindedir ve ikinci kez sayılmaz. Payload toplamı 6.176.086 byte.

Atlas modelinin ilk aktarım turundaki sayımı: 41 node (22 işlem + 11 bilgi + 8 genel grup), 71 ilişki, 7 görünüm, 10 demo adımı, 12 açık mekanizma ve 21 kayıt. Bu kapsam kontrolüdür; eski DOGRULAMA.json'un 24 UI kontrolü yeni aktarım kontrolünde yeniden çalıştırılmadı.

## Önceki metin yayınının tarihsel kontrolleri

- Main güncellemeleri force:false ile gerçekleştirildi; helper branch oluşturulmadı.
- `917d981d40ea0d1159543caac6c3fc27308cb36c` → `55499db9d5dc425cd1a2b505d978e1c719d40c28`: 7 commit ileride, 0 geride; 37 dosya root README, explorations ve research/INDEX kapsamındaydı. Research INDEX değişikliği 4 ek satır, 0 silme.
- Assistant kaynak tree'si `ada897358b70741e31709595a5d9b5a0ef51433b`, S001–S018'in tamamını truncation=false listeledi.
- USER-MESSAGES `baf8f24d784841daf135e148d0a3c9387d528a20` blob'u parçalara ayrılarak okundu; U006 aktarım düzeltmesi ve U019 görüldü. S007 D-02/W-03 ve S011 mesleki standart düzeltmesi seçici geri okundu.
- Daha sonraki `c163836d959e3ada2f31afd353bb364671b5fb32` checkpoint'i kapsam raporunu ve PARTIAL durumunu kaydetti. Bu checkpoint payload yayını değildi.

Bu kontroller bütün diyalog için bağımsız ikinci araştırmacı veya ham platform export'una karşı sadakat doğrulaması değildir.

## Yeni payload yüklemesi ve kapanış kontrolü

Kullanıcı yüklemesi: `a3987312bbfbb8aa0fbf4ea6fd8a1113d467f415`; ebeveyn `26067fc364f9813683aa5c4ebc6435279eeceb8e`. GitHub compare yalnız manifestte beklenen 32 dosyanın eklendiğini gösterdi; mevcut dosya silme/değiştirme yok.

Taşıma ZIP'i, iç manifesti ve tüm 32 özgün payload'ın boyut/SHA-256/Git blob kimlikleri yerel byte'lardan yeniden hesaplandı. Beklenen Git alt ağaçları, GitHub'ın bu commit'e bağladığı alt ağaçlarla eşleşti; çizim blob'u da eşleşti. Kaynak MANIFEST.sha256 metni connector üzerinden ayrıca okundu. Bir-byte değişikliği, dosya eksiltme ve isim değiştirme negatif örnekleri kimlik uyuşmazlığı verdi. [Ayrıntılı kanıt](PAYLOAD-VERIFICATION.md).

**Yöntem sınırı:** Doğrudan HTTPS DNS erişimi başarısız; bütün remote ikili dosyaları yeniden indirme/SHA-256 hesaplama yapılmadı. Kapanış, özgün içerikten hesaplanan Git içerik kimliğiyle remote kimlik eşleşmesine dayanır. Bu, dosya adı kontrolüne indirgenmediği gibi ayrı indirme denetimiyle de karıştırılmaz. Kullanıcı yüklemesi ile bu metadata kapanışı farklı commit olaylarıdır.

## Taşıma paketi ve helper geçmişi

EXP001_Artefakt_Tamamlama_Paketi.zip: 3.416.116 byte, 37 ZIP girdisi (32 payload + 5 yardımcı); CRC sağlam. SHA-256 `054983b46aaa6ac33b226445ce194c1125ff89e5a7a1e4bdbc11cb579783a5a2`. Manifest SHA-256 `f694d43923ec28e190f985aa30de6b9eefbe739bd00f0c773695785ee1a9e42c`.

Helper için önceki 9 yerel kontrolün kapsamı PAYLOAD-TRANSFER'da korunur. Helper commit/push veya kimlik doğrulama yapmaz; güvenlik sertifikasyonu değildir. Taşıma ZIP'inin kendisinin yeniden yüklenmesi gerekmiyor; kalıcı hedefi 32 payload'dı.

## Kalan sınırlar — aktarım eksiği değiller

1. Ham platform export'u yok; visible transcription sadakat sınırı devam eder.
2. Tarihsel citation kimlikleri global tekil kaynak kimliği değildir; kalıcı kaynak yolları ayrı tutulur. Bütün eski dış linklerin güncel canlılığı doğrulanmadı.
3. Bütün Markdown fragment'leri bağımsız tarayıcı/crawler ile yeniden test edilmedi.
4. Tam remote binary indirme/SHA-256 tekrar denetimi bu ortamda yapılmadı; Git kimlik denetimi kullanıldı.
5. Atlas sonrası yaşayan plan araştırması yalnız aday sorudur. Bu kapanış yeni araştırma, Atlas revizyonu veya ürün implementasyonu başlatmaz.

Arşiv aktarımı için açık sonraki iş kalmadı. Yeni kapsam ayrı kullanıcı yönü gerektirir.
