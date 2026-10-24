# U01-D2 — Canonical yayın ve devam uzlaştırması

**Yayın tarihi:** 2026-09-09. **Araştırma/koşu tarihi:** 2026-09-08. Bu dosya aktarımın güncel açıklamasıdır; yeni HERMES deneyi veya tüm ürün doğrulaması değildir. Güncel iş otoritesi [STATE](../../STATE.md), mekanizma girişi [09 notu](../../notes/09-WORKER-POLICY-EXECUTION-BOUNDARY.md).

## 1. Teslimin kaynağı ve bütünlüğü

Konuşmada teslim edilen `hermes-worker-policy-2026-09-08.zip` açıldı. ZIP boyutu 53.655 byte, SHA-256 kimliği `f9a18ac43009a28d2b76c2d6c4df928666f3f768c5c23d5e7758317d7aba72c7`; CRC kontrolü başarılıdır. Özgün MANIFEST'in 25 içerik girdisi boyut/SHA-256 ile eşleşir. MANIFEST dahil 26 özgün dosya değiştirilmeden korunur.

GitHub'a aktarılmış özgün dosyaların recursive tree kimliği `d6ea71085c402744afbf80b1f9f4553eb97fbdb4` olarak geri okundu. Aynı tree kimliği, ZIP'ten açılan dosyalardan yerelde Git blob/tree biçimiyle bağımsız olarak hesaplandı ve eşleşti. Bu karşılaştırma özgün 26 dosyanın yollarını, kiplerini ve içeriklerini birlikte bağlar. [TRANSFER-CHECK.json](TRANSFER-CHECK.json) denetim sonucunu taşır. PUBLICATION ve TRANSFER-CHECK, özgün manifestin dışında sonradan eklenen yayın dosyalarıdır.

Bu kontroller veri aktarımını doğrular. Deneyler yeniden çalıştırılmadı; sonuçların kapsamı büyümedi. Elle aktarılan seçkilerin tam upstream dosyalarıyla AST eşitliği bu tur sınanmadı.

## 2. Deney kimliği ve sınırı değişmedi

C01–C14 koşusu UTC `2026-09-08T19:31:50.677314+00:00`; ayrı V01–V05 koşusu `2026-09-08T19:36:58.555297+00:00`; gerçek kaynak-kimliği ret kontrolü `2026-09-08T19:36:24.270992+00:00`. Kayıtlı ortam Python 3.13.5/Linux'tur. Bunlar eski koşuların yayımlanmasıdır, yeni veya bağımsız tekrar değildir.

Tam kimliği doğrulanan pool/context/name-validator modülleri; büyük executor/plugins modüllerinden elle aktarılmış seçili tanımlar ve açık sınır taklitleriyle birlikte kullanılmıştır. Tam AIAgent/review inşası, tam executor/PluginManager/middleware, gerçek valid-name kümesi/profil/registry/transport entegrasyonu henüz doğrulanmamıştır. `verify_excerpts.py` hazırlanmış fakat orijinal tam kaynaklara karşı çalıştırılmamıştır. İlk RESULT'taki hash eşitsizliği ile ayrı IDENTITY-CHECK'teki gerçek pre-import reddi birbirinin yerine geçirilmez.

## 3. Tarihsel metinler ve doğru giriş

Özgün README, RESEARCH, PUBLICATION-HANDOFF ve CONTINUATION-DELTA içindeki NOT PUBLISHED/NOT APPLIED, v0.6 ve eski devam ifadeleri teslim anının tarihsel durumudur. Bu yayınla eski deney metni yeniden yazılmaz; güncel yorum STATE, plan v0.7, bu dosya ve 09 girişi üzerinden yapılır. `REPO-NOTE-09.md`, notes dizinine yerleştirilmek üzere hazırlanmış tarihsel taslaktır; içindeki göreli yolları bulunduğu evidence dizininden güncel router gibi takip etme. Düzeltilmiş güncel giriş `notes/09-WORKER-POLICY-EXECUTION-BOUNDARY.md` dosyasıdır.

U01B, U01B2 ve önceki transport kanıtı ile 01–08 notları korunur. E01–E07, C01–C14 ve V01–V05 kimlikleri bu yeni dilime aittir; eski H/S/W/D/P defterlerini yeniden numaralandırmaz. Durum/test sayıları toplanıp ürün PASS veya tamamlanma yüzdesi üretilmez.

## 4. Repo ve çalışma sınırı

Hazırlık tabanı `36f1b7e6ae07da5c1d9d57ff9633d48473c42537`. Değişiklik kapsamı HERMES paketi ve studies katalog satırıdır; Foundation, SOUL context/Development OS, agent-control ve başka study içeriklerine müdahale edilmez. Yayın commit'i Git geçmişinde bu dosyanın ekleme kaydıdır; tek başına blob/tree oluşturulması main yayını sayılmaz. Yayın sonucu, commit kapsamı ile main referansı ve giriş dosyaları geri okunarak doğrulanır.

Kullanıcı 2026-09-09'da önce bu teslimin kaydedilmesini, sonra repo'nun sonraki araştırmaya hazır edilmesini istedi. Bu tur o yayın/süreklilik işi yürütülür; yeni HERMES deneyi başlatılmaz. Sonraki yetkili teknik iş, kaynak seçkisinin sadakati ve gerçek review kurulumu/araç-adı kümesi/worker-policy bağındaki artık boşluktur; ayrıntı plan v0.7'dedir. Aynı dar fixture'ı çoğaltmak tam entegrasyon yerine geçmez.

Bu tur GitHub Git veri yazma eylemleri kullanılabildi. Önceki araç sunumu/çağrı hatasının kök nedeni doğrulanmış değildir. Kullanıcının Codex'i başka repository üzerinde kullandığı açıklaması korunur; geçmiş main hareketleri Codex'e atfedilmez. İzin/uygulama ayarı değiştirilmedi. Kullanıcının ZIP'i elle taşıması gerekmez.
