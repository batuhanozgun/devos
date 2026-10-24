# Tarihsel DevOS kaynak arşivi — kısmi

**1 Ekim 2026 / 6 aile arşivde; yalnız P5 S00–S12 kalıcı açık kaynak erişim sınırıdır.** Burası güncel DevOS kurulum planı değildir. Tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır; devir sürümü 2.1. [D030](../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri) ve [bakım planı](../../REPOSITORY-TRANSITION.md) yetki ve devam sınırını taşır.

## 1. Gerçek içerik ve kalanlar

**Batu'nun yüklediği [kaynak ZIP'i](A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip) `main` üzerinde doğrulandı.** Beş kaynak ailesinin 19 özgün dosyası artık bu repository'de bulunur: dört P4/P5 ailesi ZIP üyeleri olarak, Academy hem ZIP üyesi hem ayrı Markdown dosyası olarak. SOUL ve DevOS ayrıca özgün Markdown dosyası olarak eklendi; yalnız S00–S12 eksiktir. ZIP içindeki dosyaların varlığı, bunların ayrı repository yollarında açıldığı anlamına gelmez.

| Kaynak ailesi | Repository erişimi | Statü |
|---|---|---|
| P4 v3 | ZIP içinde `p4-v3/` ailesi: Markdown, PDF, özgün kaynak/kanıt ZIP'i ve teslim kimliği | Tarihsel; uygulama kaynağı değil |
| P4 v4 | ZIP içinde `p4-v4/` ailesi: Markdown, PDF, özgün kaynak/kanıt ZIP'i ve teslim kimliği | Tarihsel; mimari kaynak; Codex ortam kararı geçersiz |
| P5 K00–K15 | ZIP içinde `p5-k00-k15/` ailesi: rehber MD/PDF, özgün paket, başlangıç metni ve teslim kimliği | Tarihsel; yeni kurulum talimatı değil |
| P5 S00–S12 | Özgün paket bulunamadı; yalnız eski teslim kaydındaki beklenen kimlikler var | Tarihsel; senaryolar ileride sınav fikri olabilir; K paketi bunun yerine geçmez |
| P5 v2 Codex arayüzü | ZIP içinde `p5-v2-interface/` ailesi: rehber MD/PDF, özgün paket, başlangıç metni ve teslim kimliği | Tarihsel; yeni kurulum talimatı değil |
| SOUL ve DevOS | [Kullanıcının verdiği özgün rapor](soul-and-devos/SOUL_ve_DevOS.md); bağımsız repository dosyası, ZIP üyesi değil | Tarihsel kaynak; SOUL tanımı yeni planda güncellendi |
| SOUL Academy | ZIP içinde `academy/` ve [ayrı özgün metin](academy/SOUL_ACADEMY_EXPLORATORY_CONCEPT_NOTE.md) | Keşif notu; karar veya iş açma yetkisi değil |

SOUL ve DevOS dışındaki ZIP aile adlarının önüne ZIP içinde **`archives/devos-pre-claude-2026-09-29/`** gelir. Dosya başına tam ad, boyut, SHA-256 ve Git blob kimliği [SOURCE-IDENTITIES.json](SOURCE-IDENTITIES.json) içindedir. ZIP’teki 19 özgün dosyanın **kesin ZIP üye yolu**, bu kayıttaki `archive_container.member_prefix` ile `artifact.path` birleştirilerek elde edilir; 19 yolun tamamı gerçek ZIP üyeleriyle karşılaştırıldı.

Örnek: P4 v3 raporunun ZIP içindeki tam yolu `archives/devos-pre-claude-2026-09-29/p4-v3/EXP-006_DevOS_v3.md`'dir. Bu yol ZIP üyesidir; aynı adlı bağımsız GitHub dosyası oluşturulmuş sayılmaz. Kaynak okunacaksa önce bu repository'deki ZIP alınır, sonra tam adı verilen üye veri olarak açılır. İçerideki eski başlangıç veya kurulum metinleri çalıştırılmaz.

**Kimlik kaydının sürümü 3'tür.** `VERIFIED_STANDALONE`, ZIP dışında bağımsız dosya olarak eklenen SOUL ve DevOS raporunu ifade eder. `VERIFIED_IN_REPOSITORY_ARCHIVE` ZIP içinde yayınlanmış özgün gövdeyi; `VERIFIED_STANDALONE_AND_ARCHIVE` ayrıca bağımsız repository dosyasını ifade eder. S ailesinin `expected_unverified` değerleri yeniden elde edilmiş dosyadan hesaplanmış değildir. ZIP içindeki eski `SOURCE-IDENTITIES.json` ve `CONVERSATION-COPY.md` tarihli aktarım kayıtlarıdır; içlerindeki eski yayın durumu, ZIP dışındaki güncel envanterin yerine geçmez.

## 2. Yükleme ve doğrulama kaydı

**Aşağıdaki gözlemler `b0339e77713c2182988e635859ed6d6d79b19cb7` ile kaydedilen yükleme doğrulamasına aittir; yeni kaynak erişim incelemesi §4'tedir.**

**Yükleme commit'i:** [`93216f73ea565ed3ba22e4ba0e18e2144e1368c4`](https://github.com/batuhanozgun/agentic-os-search/commit/93216f73ea565ed3ba22e4ba0e18e2144e1368c4), `Add files via upload`. Önceki main `0548bd4a55ef3b87fbb3674cf075c2f6d8e639ec` ile fark yalnız bu ZIP'in eklenmesidir. Commit yazarı `batuhanozgun`, committer GitHub'dır; incelenen yeni commit `batuhanozgun-devos` hesabından değildir. Başlangıç root tree `1e61aa9baddfe65844e85bfab938f7bc84320cfe`.

| Kontrol | Gözlem |
|---|---|
| Uzak repository yolu | `archives/devos-pre-claude-2026-09-29/A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip` |
| Uzak boyut | `20275988` byte |
| Uzak Git blob SHA-1 | `547522120893c25d5c709deb5c0e18f57ebe7806` |
| Yerel özgün ZIP'in yeniden hesaplanan SHA-256'sı | `8b06cb2b3dca5875cab0ad72595701e3e0d4d756d0c80fa2f49041df48aa9b17` |
| Yerel özgün ZIP ↔ uzak nesne | Yeniden hesaplanan Git blob kimliği ve boyut birebir eşleşti |
| ZIP üyeleri | 21: 19 özgün kaynak + tarihli kimlik anlık görüntüsü + açıklama |
| Özgün dosyalar | 19/19 boyut, SHA-256 ve Git blob kimliği eşleşti; P4 v3: 4, P4 v4: 4, P5 K: 5, P5 v2: 5, Academy: 1 |
| Yapı denetimi | CRC geçti; 21 üye adı benzersiz ve güvenli; beklenen üye kümesi eksiksiz |
| Eski kimlik anlık görüntüsü | `db2fb9829de6ce39888dde65aca045c081e10ba1`; yükleme anındaki repository envanteriyle byte kimliği aynı |
| Olumsuz kimlik kontrolü | ZIP'e tek sıfır byte eklenmiş kopyanın kimliği eşleşmedi |

**Kanıt sınırı:** Uzak ikili dosya bu tur yeniden indirilmedi. GitHub'dan okunan yol/boyut/Git nesne kimliği, yerelde gerçek byte'ları açılan özgün ZIP ile bağlandı; üyeler bu kimliği eşleşmiş yerel kopyada denetlendi. Bu nedenle uzaktan yeniden indirilmiş byte'lar üzerinde ayrıca SHA-256 hesaplandığı iddia edilmez. Kimlik doğrulaması, kaynağın iddialarının doğruluğu, PDF görünümü, eski testlerin yeniden koşulması veya Claude kurucusunun kütüphaneye içe almasının sınanması değildir. Hiçbir tarihsel kod ya da kurulum betiği çalıştırılmadı.

## 3. Kullanım ve koruma sınırı

Özgün gövdeler değiştirilmez; bu README ve güncel kimlik kaydı onların yan kayıtlarıdır. Arşive almak mimari benimseme, canlı sistem yeterliği veya geçmiş testleri yeniden çalıştırma değildir. Kaynaklardaki eski current/next, rol ve kontrol metinleri pasif tarihsel malzemedir. Platformdan bağımsız bulgu veya kullanıcı kararının tarihçesi sırf tarihsel olduğu için geçersiz sayılmaz.

Görev, P4/P5'in bazı bölümlerinin yeni plana aktarıldığını bildirir; A3 bu aktarımın eksiksizliğini yeniden doğrulamıyor. Academy'nin kendi başlangıç statüsü ve §24/§27 sınırları korunur: notun karar yolundan geçmeden doğrudan iş veya kurulum açılmaz. Metindeki eski `soul` bağlamı tarihsel kaynaktır; yeni ürün deposu `soul-system`'dir.

Bu çalışma yalnız özel araştırma deposuna yazar; kaynakları açık ürün depolarına taşımaz. Kullanıcının yüklediği ZIP, Academy gövdesi, araştırma ve kontrol dosyaları bu güncellemede değiştirilmez; dosya silinmez veya taşınmaz. 30 Eylül erişim değerlendirmesinin kapsamı tarihsel kayıtta korunur; 1 Ekim kapanışında SOUL ve DevOS dosyası ve kimlik envanteri ayrıca eklendi/güncellendi. Foundation’daki iki değişiklik yalnız başlangıç statü notudur.

## 4. Erişim engelleri ve bakım sonrası durum

Önceki aktarım engeli ve tek seferlik yükleme talebi [`0548bd4` sürümünde](https://github.com/batuhanozgun/agentic-os-search/blob/0548bd4a55ef3b87fbb3674cf075c2f6d8e639ec/archives/devos-pre-claude-2026-09-29/README.md) aynen bulunur. **Bu yükleme ihtiyacı karşılanmıştır; Batu'dan aynı ZIP yeniden istenmez.** [A3-INTAKE](../../maintenance/2026-09-29-research-installation-separation/A3-INTAKE.md) ilk alımın tarihli kaydıdır.

**SOUL ve DevOS erişim engeli kapandı.** Batu, beş maddelik kapanış düzeltmesinde bu dosyanın istenen rapor olduğunu açıkça teyit etti ve 1 Ekim 2026 devam konuşmasında dosyayı sağladı. Özgün baytlar değiştirilmeden `soul-and-devos/SOUL_ve_DevOS.md` yoluna kopyalandı. Mevcut ZIP değiştirilmedi.

| Kimlik | Değer |
|---|---|
| Boyut | `147006` byte |
| SHA-256 | `0f8221445a59eccf1a52efa3d2fe3c7fac642d1370aff99acdc1894fbcfdc3c2` |
| Git blob SHA-1 | `bcf79ccfcc21e1b8c294bd60cc17b065ce19e15a` |

**Arşiv 6/7 aileyle kısmi; tek kalıcı açık sınır P5 S00–S12’dir.** K00–K15 paketi onun yerine geçmez. Beklenen S kimlikleri yeniden doğrulanmış dosya kimlikleri değildir. Yeni özgün kaynak veya somut yeni erişim kanıtı gelmedikçe sonuçsuz aramalar tekrarlanmaz.

[A3-ACCESS-GAPS](../../maintenance/2026-09-29-research-installation-separation/A3-ACCESS-GAPS.md) önceki erişim incelemesinin tarihsel kapsamını korur. [A5 final teslimi](../../maintenance/2026-09-29-research-installation-separation/A5-FINAL-DELIVERY.md) kullanıcı tarafından aktarılan tüm-repo taramasını ve beş kapanış düzeltmesinin sonucunu taşır. A4/A5 tamamlandı; aktif bakım işi kalmadı.
