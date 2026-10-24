# A3 — kaynak kimlikleri, kısmi arşiv ve açık yayın

**30 Eylül 2026 / REPO-SEPARATION-20260929.** Bu tur A3'ün ilk kimlik ve erişim envanteridir; A3 kapanışı değildir. Tek güncel sıra [REPOSITORY-TRANSITION](../../REPOSITORY-TRANSITION.md)'dedir. Kaynak matrisi ve her dosyanın kimliği [arşiv girişinde](../../archives/devos-pre-claude-2026-09-29/README.md) ve [SOURCE-IDENTITIES.json](../../archives/devos-pre-claude-2026-09-29/SOURCE-IDENTITIES.json) içinde tutulur.

## 1. Yetki ve başlangıç

[REQUEST](REQUEST.md) §3.4, §4–§6 uygulanır. Kök bakım planı ve A2-CLOSE tam okundu. Başlangıç main `58eaaf5f1dfe2f22deecdc07420deb503e95f7d6`, root tree `d2417f9279389f57937dfd9539e68a8d80c07015`; önceki A2 kapanışından sonra gözlenen main farkı yoktu. Aynı sabit ref üzerinde `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` sorguları boş döndü. Bu, bütün dal/kimliklerde yokluk kanıtı değildir. Genel denetim tabanı `8cd01e4afdcd0d37960b05930c91e1244678be6e` değişmedi.

Yalnız araştırma arşivi ve bakım kayıtları yazılır. Yeni Claude kurulum planı kopyalanmaz; platform kararı açılmaz; DevOS, SOUL veya hesaplarda işlem yapılmaz. A2 kaynakları yeniden düzenlenmez.

## 2. Gerçek dosya ve kimlik denetimi

Beş aileden **19 özgün dosya** geri kazanıldı: P4 v3 ve P4 v4 için dörder dosya; P5 K ve P5 v2 için beşer dosya; Academy için bir dosya. İki P5 başlangıç metni ilgili ZIP'in `START-HERE.md` üyesinden byte-eşit çıkarıldı; yeni metin yazılmadı. Dört teslim kimliğindeki **14/14 artefakt** boyut ve SHA-256 ile eşleşti. Teslim kimliği dosyalarının kendi kimlikleri ayrıca envanterdedir; kendi içlerindeki yayın/QA beyanları bugün yeniden doğrulanmış kabul edilmez.

| ZIP gövdesi | Manifest girdisi | Sonuç |
|---|---:|---|
| P4 v3 kaynak/kanıt paketi | 76 | Boyut/SHA-256 tamamı eşleşti |
| İç tarihsel v2 paketi | 22 | Boyut/SHA-256 tamamı eşleşti |
| P4 v4 Codex kaynak/kanıt paketi | 95 | Boyut/SHA-256 tamamı eşleşti |
| P5 K00–K15 | 80 | Boyut/SHA-256 tamamı eşleşti |
| P5 v2 Codex arayüzü | 71 | Boyut/SHA-256 tamamı eşleşti |
| Önceki yeni-oturum devir ZIP'i | 5 | Boyut/SHA-256 tamamı eşleşti |

Altı farklı ZIP gövdesi, **349 manifest girdisi**. Dört ana aile 322 girdidir; iki ek tarihsel ZIP 27 girdidir. Aynı iç ZIP birden çok pakette bulunduğunda yeniden ayrı kanıt sayılmadı. CRC kontrolü geçti; mükerrer ad, tehlikeli yol, manifest dışı dosya veya yazı tipi dosyası bulunmadı. ZIP'ler veri olarak açıldı; içlerindeki kod/test/kurulum betikleri çalıştırılmadı. Bu, source assertion, PDF görünümü, semantik aktarım veya hedef davranış doğrulaması değildir.

**Aynı ad, farklı byte:** Çalışma klasörlerindeki bazı P4 PDF'leri teslim sürümüyle farklı SHA-256 taşıyordu; P4 v4'te boyutun aynı olması da eşitliği göstermedi. Seçim dosya adı ya da tarihe göre değil, teslim kimliği ve paket manifestiyle yapıldı. Seçilmeyen dosyalar değiştirilmedi/silinmedi.

**Academy:** Library dosyası `file_00000000215881f495d5e343f56fb757`, sürüm `1`, `raw_file` olarak alındı. 32.834 byte, 1.244 satır; SHA-256 `2d879468005bf2ecdeb6a1bbf85be20e1f4a2457d13b2237c8fe13a3d42af973`; Git blob `c5ff616d696334009f8e67432707c14ffedc7630`. Uzak create_blob sonucu yerelde özgün byte'lardan hesaplanan Git blob kimliğiyle birebir eşleşti. Metin üç parçada sonuna kadar okundu; kendi keşif statüsü, §24 karar vermeme ve §27 promotion yolu korundu. Bu okuma notun içindeki eski gözlem ve mimari iddiaları yeniden doğrulamaz.

## 3. İki geri kazanılamayan aile ve arama sınırı

**P5 S00–S12:** [P5-01 teslim kaydı](../../explorations/EXP-006-development-os-calisma-duzeni/work/P5-01-codex-build-installation-package.md) sabit başlangıçtan tam okundu. S kaydının PDF ve Markdown adları K paketiyle aynıdır; byte ve hash'leri farklıdır. K dosyaları S yerine konulamaz. S için eski kaydın §6'sından alınan dört beklenen kimlik SOURCE-IDENTITIES içinde `expected_unverified` olarak tutulur; bunlar bugün geri kazanılmış dosya kimliği değildir. İddia edilen ZIP `EXP-006_P5_Codex_Insa_ve_Kurulum_Paketi.zip` (4.209.549 byte) bu tur bulunamadı.

**SOUL ve DevOS:** Başlığı ve atıfları bulundu; istenen tam rapor doğrulanmış dosya kimliğiyle bulunamadı. Başka başlıklı SOUL metni, Academy, yeni Claude planı veya kullanıcı beklenti belgesi onun yerine kullanılmadı.

Mounted konuşma dosyaları ve alt klasörleri dosya/kimlik bakımından tarandı; görülen ZIP'ler ve iç ZIP'lerin metinleri hedef ad/işaretler için tarandı. Files üzerinden konuşma ve Library'de başlık/içerik/kimlik aramaları yapıldı. Arama miss'i yokluk sayılmadı: Academy eski bilinen dosya referansından ham dosyayla kurtarıldı. `/guvenilir-ajan-tasarimi` Library klasörünün 10 dosyalık listesi sonuna kadar görüldü; genel Library ve konuşma metadata listeleri bütünüyle tüketilmedi. Repository'nin recursive tree görünümü ve hedef teslim kaydı kullanıldı; bütün depo gövdeleri veya bütün commit geçmişi taranmış değildir. Bir varsayımsal ek manifest yolu 404 döndü; bundan asıl paketin yok olduğu sonucu çıkarılmadı. Bu sınırlar iki kaynağı **erişim açığı** olarak bırakır, evrensel yokluk hükmü üretmez.

## 4. Arşiv yayını ve konuşma kopyası

**Bu yayın grubunda repository'ye alınan özgün gövde yalnız Academy'dir.** Arşiv README'si ve makinece okunur kimlik envanteri beş geri kazanılmış ailenin tamamını açık yayın durumuyla gösterir. Dört P4/P5 ailesinin gövdeleri henüz GitHub'a yayımlanmadı; envanter girdisi gerçek kaynak yerine geçmez.

Bağlı GitHub araçlarında metin/base64 içerikle blob oluşturma var; mounted dosya yolundan doğrudan büyük ikili dosya yükleme eylemi keşfedilmedi. Kurulu plugin araması ek yükleyici getirmedi. Terminalin GitHub ad çözümlemesi başarısızdı. K ZIP'inin yerel Git blob kimliğini mevcut nesne gibi bağlama denemesi `422 not a valid blob` verdi; hash'in GitHub'da gövde bulunduğunu göstermediği doğrulandı. **GitHub yazma bütünüyle kapalı değil:** Academy ve yan kayıtlar desteklenen metin yoluyla yazıldı. Büyük gövde aktarımının açık olması, bu dosyaların kayıp veya bozuk olduğu anlamına gelmez.

Konuşmada ayrıca **`A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip`** hazırlandı: 20.275.988 byte; SHA-256 `8b06cb2b3dca5875cab0ad72595701e3e0d4d756d0c80fa2f49041df48aa9b17`. 19 özgün dosya, kimlik kaydı ve açıklama = 21 üye. ZIP yeniden açıldı, 19 kaynağın byte/SHA-256 kimlikleri ve CRC doğrulandı. Kaynak dosyaya ek byte verilince kimlik karşılaştırmasının eşleşmediği de kontrol edildi. Bu arşiv yeni P5 değildir ve eksik S paketini içermez. Konuşma eki, repository yayınının yerine geçmez; yalnız doğrulanmış özgün kopyaları koruyan aktarım dosyasıdır.

## 5. Koruma, yayın kontrolü ve devam

Bu tur beş repository yolu hedeflenir: arşiv README, SOURCE-IDENTITIES, Academy özgün gövdesi, bu A3-INTAKE ve kök bakım planının ilerleme/devri. Akademi ve envanter blob'ları yerel byte kimlikleriyle eşleşti. Hiçbir eski dosya silinmez veya taşınmaz; araştırma gövdeleri değişmez. `AGENT.md` blob `aea3dd845e0f0bbcfb34465edb23782e99f95c80`, `agent/` tree `24fb60959380ca072a2ade392be23931886e0dfe`, `MOVES.md` blob `23c0c3a020a7f53f5604a9455f5828f80bfaca52` korunur. Nihai diff ve tree kontrol edilir; yayın öncesi ref/yazar kontrolü, yayın sonrası ref ve dosya geri okuması ayrıca yapılır. Aday tree/blob yaratılması main yayını değildir.

**Tek sonraki iş A3'ün gövde yayınını ilerletmektir; ilk aile P4 v3.** Önce bu kayıt, arşiv README/kimlikler ve güncel root plan okunur. Kaynakları yeniden yazmadan mevcut doğrulanmış byte'lar yayımlanır; desteklenmeyen aktarım yolu tahmin edilmez. Dosya yalnız ilgili uzak path ve doğru blob ile geri okunduğunda yayın durumu kapatılır. İki bulunamayan kaynak için yalnız yeni somut referans veya arama kapsamı kazandıran araştırma yapılır; aynı sonuçsuz sorgular döndürülmez. A3 kapanmadı; A4/A5 başlamış veya tamamlanmış sayılmaz.
