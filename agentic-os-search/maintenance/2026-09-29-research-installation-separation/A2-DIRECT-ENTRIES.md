# A2 — doğrudan teslim, mesaj ve alan girişleri

**Tarih:** 29 Eylül 2026. **Kapsam:** A2'nin ikinci alt kümesi; 21 kaynak dosyasına tarihli statü/yönlendirme eki. A2 bütünü ve depo geneli denetim henüz tamamlanmadı.

## 1. Yetki ve başlangıç

[REQUEST.md](REQUEST.md) §3.2, §3.5, §4 ve §5 ile Batu'nun “Tamam. Devam et lütfen” mesajı bu bakımın yetkisidir. Yalnız `batuhanozgun/agentic-os-search` değiştirilir. DevOS kurulmaz; dış plan veya diğer depolar değiştirilmez. `AGENT.md` ve `agent/**` bu işin değişiklik kapsamı dışındadır.

Bu turun başlangıç main'i **`8612f1320dbfeeef089964d4c48025051f1bb0e6`**, root tree **`b24e8b293559c673e7861aee31170b8ddb8e96a4`** olarak geri okundu; önceki turdan sonra araya commit girmemişti. Bütün bakımın ilk karşılaştırma tabanı `8cd01e4afdcd0d37960b05930c91e1244678be6e` değişmez. Önceki 13 ana giriş değişikliği [A2-CORE](A2-CORE.md)'da kayıtlıdır; bu tur onların kaynak gövdelerini yeniden değiştirmez.

## 2. Değişen kaynak dosyaları — tam liste

Her satırdaki özgün gövde yerinde kalır. Yeni metin, dosyanın başındaki altı satırlık tarihli statü notu ve ayırıcıdır. Gövdedeki kullanıcı sözleri, test iddiaları, öneriler, kaynaklar ve eski bağlantılar yeniden yazılmaz. Satır numaralarının altı artması, özgün metnin değişmesi değildir.

| # | Dosya | Başlangıç blob'u | Gerekçe |
|---|---|---|---|
| 1 | `explorations/EXP-006-development-os-calisma-duzeni/work/P4-01-cloud-runtime-and-workspace-design.md` | `02f69a34d16ea830637b7b7e8426b9b104896834` | Eski Claude taslağının aynı ortam adı nedeniyle tekrar geçerli kurulum sanılmasını önlemek |
| 2 | `explorations/EXP-006-development-os-calisma-duzeni/work/P4-02-soul-derived-report-v2.md` | `b570b486b076218b51073644a6a3dc6ea1f71141` | V2 mimari önerisi ve eski qualification sırasını tarihsel teslim olarak ayırmak |
| 3 | `explorations/EXP-006-development-os-calisma-duzeni/work/P4-03-unbounded-stress-test-handoff.md` | `fd0b79783f66e7d322d4688168ec48b00c1569f9` | Yarım v3'ün yeniden başlama talimatını kapatmak; o anki erişim sorunu ile sonraki v3 teslimini karıştırmamak |
| 4 | `explorations/EXP-006-development-os-calisma-duzeni/work/P4-04-unbounded-stress-test-report-v3.md` | `26dfc4806a972586c12d6958a0621585072eb43c` | V3 teslim/kanıt kaydını yeni kurulum veya yeni testten ayırmak |
| 5 | `explorations/EXP-006-development-os-calisma-duzeni/work/P4-05-codex-environment-revision-v4.md` | `ccce30ad109da25f9facb032b8e85ecfbb900da6` | D027 Codex ve P5 sonraki-aşama yönünün D030 sonrasında geçersiz olduğunu doğrudan girişte göstermek |
| 6 | `explorations/EXP-006-development-os-calisma-duzeni/work/P5-01-codex-build-installation-package.md` | `640cbf04494d7a0eaffbb2c74b1bbc4ceb0b2e92` | Eski S00 görevini kapatmak; 74 sayfalık S paketiyle 40 sayfalık K paketini ve gerçek erişimle teslim beyanını ayırmak |
| 7 | `development-os/attempts/001/BRIEF.md` | `a1bc16f39b7923452a28c019d5dd1748c57c58da` | Eski amaç/son kullanıcı yönü/yetkili işi yeni kurucuya verilmiş görev saymamak |
| 8 | `development-os/attempts/001/METHOD.md` | `3758ce29d49b72d9b23ada9a9c2b4be6edc964e8` | Eski yöntem ve okuma paylaşımını etkin kontrol/bugünkü tasarım sırası olmaktan ayırmak |
| 9 | `development-os/attempts/001/EXCHANGE.md` | `f8f9eb74ed190b7bd3d45a62c902a0320f473a19` | Eski iki-repo kanalını yeni iletişim veya yeniden gönderim yetkisi olmaktan ayırmak |
| 10 | `development-os/attempts/001/REVIEW.md` | `4a28d6ef4dbca3bcd9a1fbcc6d5c2ff003f9829e` | Dersleri korurken eski yöntem/sonraki kanıt yükünü güncel iş sanmamak |
| 11 | `development-os/attempts/001/messages/research/R-001.md` | `c75f5f5c707462770c277060e557d6366efea36c` | Eski C-001 isteğini ve hedef alıcısını yeniden etkinleştirmemek |
| 12 | `development-os/attempts/001/messages/research/R-002.md` | `8021500816bc4359b1d4a840b17f0d6cb8103738` | D01/E19 eleştirisi ve C-002 isteğini tarihsel kaynak olarak tutmak |
| 13 | `development-os/attempts/001/messages/research/R-003.md` | `f15538ce0992b5ced63a8091ae1c3a94b8ee39f9` | M1–M3, C-003 ve eski deney planının yeni görev sanılmasını önlemek |
| 14 | `development-os/attempts/001/messages/research/R-004.md` | `8ad723104b8b9fb7ea380dc0479828fe0f2e7247` | Eski bütün-korpus kampanyası ve iş paylaşımını yeniden başlatmamak |
| 15 | `development-os/attempts/001/messages/research/R-005.md` | `b28b11abd30a9bd2c53faf6dfa33305a85127506` | Alındı ve okuma sınırlarını korumak; eski paylaşımı yeni yetkiye dönüştürmemek |
| 16 | `development-os/attempts/001/messages/research/R-006.md` | `3301991d09113e4804023457ff114ea26bf6b00d` | Eski D1/D2 tasarım ve karşı katkı isteğini yeniden açmamak |
| 17 | `research/soul-context/current/claude-code-devos-preparation/WORK.md` | `65cc5017b3cc64aad8ef772a03527bffe4062253` | Tarihsel etiketli dosyanın hâlâ DEVOS-001'i güncel devam göstermesini ayırmak |
| 18 | `research/soul-context/current/claude-code-devos-preparation/CLAUDE-TASK-01.md` | `2f7e6d0d5f1c658ceee12957c8914ff78a53c18f` | Eski TASK-01 → R-001 “yeni kanal” yönünün de tarihsel olduğunu belirtmek |
| 19 | `research/INDEX.md` | `167d8df1f3d29544065388ff915a6c24518772e6` | Etkin araştırma yönlerini korurken eski Codex/DevOS/soul-production hedeflerini tarihsel ayırmak |
| 20 | `explorations/INDEX.md` | `dd1432c145487372c81d8b30372524f038a33418` | EXP-006 girişini ve tarihsel kurulum sınırını görünür kılmak; kavramsal denemeleri topluca kurulum arşivi yapmamak |
| 21 | `explorations/CATALOG.md` | `f05f0a443f239860fac9f314db082f5ea63ee9c2` | EXP-006 satırındaki ve son açıklamasındaki Codex/S00/current beyanlarını tarihli ayırmak; diğer paket statülerini korumak |

Bakım kayıtları ayrıca değişir: bu dosya yeni eklenir; kökteki `REPOSITORY-TRANSITION.md` ilerleme ve tek devam noktası için güncellenir. Bu kaynak grubunda yeni belge üretilmedi, dosya taşınmadı veya silinmedi. `MOVES.md` değişmez. Kaynak raporların kendileri ve ZIP arşivleri bu statü turunda eklenmedi.

## 3. Okuma ve karşılaştırma

Yukarıdaki 21 dosyanın tamamı değişiklik öncesinde kaynak ref'ine bağlı olarak okundu. Uzun P4-01 ve P5-01 okumaları aralıklara ayrıldı; kesilmiş çıktılar tamamlandı. Altı R mesajı kendi tam metniyle incelendi. Bu tam okuma, mesajların atıf yaptığı bütün dış kaynakların veya eski testlerin yeniden incelendiği anlamına gelmez.

İçerik doğrulama adayı: **`ac026aba9de076dbf0181c748b51a1a279c01783`**, tree **`93f422340cec206ca4efd802d3d77c50aa1a8f2e`**, parent başlangıç main'i. GitHub compare: **21 dosya; her birinde 6 ek satır, 0 çıkarılan satır; toplam 126 ek satır**. Commit'in bütün kaynak farkları okundu; her hunk dosya başlangıcındadır (`@@ -1,3 +1,9 @@`), özgün gövdeye müdahale yoktur.

İlk yayımlanmamış P4/P5 adayındaki P5 boş satır ve dosya-sonu farkları giderildi. R-003 kopyasındaki istemdışı sözcük farkı da son karşılaştırmadan önce giderildi. Başarısız ara kopyalar main'e yayımlanmadı. Başlangıçtan doğrulama adayına son fark esas alınır; ara nesne oluşturmak tamamlanmış yayın sayılmaz.

Yeni bağlantılar D030'un açık HTML kimliğine, mevcut bakım planına ve kaynak kayıtlarına yönelir. Göreli yol düzeyleri dosyanın dizinine göre kontrol edildi. Eski gövdelerdeki bütün bağlantıların çalışması bu alt kümede yeniden test edilmedi; A4/A5 yüküdür. Dış plan bağlantısı görevdeki tek adrestir; plan bu depoya kopyalanmadı ve yeni v2.1 içerik denetimi yapılmadı.

Başlangıç ve yazma öncesi main kapsamındaki `batuhanozgun-devos` author/committer sorguları sonuç döndürmedi. Bu dar gözlem bütün dallarda veya başka kimlikle yazılmış commit'lerde yokluk ispatı değildir. Yayından hemen önce yeni main/delta kontrolü yapılır; başka aktörün değişikliği üzerine force push uygulanmaz.

## 4. Yeni okuyucu yürüyüşü ve korunmuş karşı durumlar

- Doğrudan eski P4-01 veya P4-02 açılırsa: aynı Claude ortam adının eski taslağı yeniden etkinleştirmediği, D030 ve dış plan açık.
- Doğrudan P4-03 açılırsa: yarım çalışma ve sonraki v3 teslimi farklı tarihsel olaylar; eski yeniden başlatma tarifi güncel görev değil.
- P4-04/P4-05/P5-01 açılırsa: bulgu/test/öneri kaynak olarak kalır; eski P5 sırası ve Codex kararı devralınmaz. K ve S paketleri karışmaz.
- DEVOS-001 rol/yöntem/kanal veya R mesajı açılırsa: eski hedef ve yanıt beklentisi yeniden yürütülemez; mesajın özgün kanıtı korunur.
- Tarihsel hazırlık WORK/TASK açılırsa: tarihsel dosyadan yine tarihsel DEVOS-001'e giden bağ yeni devam rotası değildir.
- Research ve explorations kökleri açılırsa: kavramsal ve temel araştırma kendi statüsünü korur; yalnız eski kurulum yönleri tarihsel ayrılır. Araştırmanın current ifadesi, yeni DevOS'un canlı durumu sayılmaz.

Bu bir kaynak metni/diff/yönlendirme incelemesidir; gerçek Claude kurucusuyla davranış testi veya bağımsız doğrulama değildir. Sadece önek eklemek bütün repository'nin retrieval görünümünü otomatik güvenli yapmaz. Daha derin eski görevlere doğrudan giriş, kesilmiş görünümler, arşiv erişimi ve bütün bağlantılar A2'nin kalanı ile A4/A5'te ayrıca değerlendirilecektir.

## 5. Kalan kapsam ve tek devam noktası

**A2 açık kalır. Sonraki tek iş: `research/soul-context/current/**` altındaki kalan eski bootstrap, koordinasyon, brief ve review girişlerini envanterleyip statü/yön bakımından kapatmak.** Bu tur yalnız `claude-code-devos-preparation/WORK.md` ve `CLAUDE-TASK-01.md` değişti. Aynı dizindeki OWNER-CONTEXT/SOURCE-REGISTER ile diğer current alt dizinleri bu tur tam okunmuş veya düzeltilmiş değildir. DEVOS-001 `reading/` girişlerinin ve EXP-006'nın P1/P2/P3 gibi diğer doğrudan okuma yollarının statü ihtiyacı da kalan kapsamda kontrol edilir; araştırma gövdeleri değiştirilmez.

Current alt ağacının API envanter çıktısı kesilmişti; görünen dosyalardan “bütün dosyalar görüldü” sonucu çıkarılmadı. Yeni tur envanteri eksiksiz alır, dosya başına okuma/kapsam ve gerekçeli koruma veya düzeltme kaydı tutar. Aynı R/P4/P5 gövdeleri sırf yeni tur başladı diye yeniden yazılmaz.

A3 yedi rapor/paket ailesinin gerçek arşiv erişimi; A4 tüm repository taraması; A5 başlangıç–son farkı ve tam teslim ayrı işlerdir. Bunlar bu alt kümede kapanmış değildir. `AGENT.md`/`agent/**`, Foundation, studies, concepts, yayınlar ve başka depolar değiştirilmez.

Yayının tamamlanması için son commit'in main'e bağlanması ve geri okunması gerekir. Bu belgenin bulunduğu main commit'i gerçek yayın kimliğidir; yukarıdaki içerik doğrulama adayı tek başına main yayını olarak sunulmaz.
