# A2 — kalan dokuz eski görev şartnamesi

**Tarih:** 30 Eylül 2026. **İş:** REPO-SEPARATION-20260929 / A2. **Kapsam:** `research/soul-context/current/briefs/` altındaki son dokuz belgenin statü ve yönlendirme incelemesi. Bu alt kümenin içerik/diff denetimi tamam; A2 bütünü, arşivleme ve depo genelindeki son denetim açık.

## 1. Yetki ve başlangıç

Yetki: [Batu'nun görev belgesi](REQUEST.md) §3.2, §4–§6 ve bu konuşmadaki “devam et” mesajı. Yazma yalnız `batuhanozgun/agentic-os-search` içindedir. DevOS kurulmaz; güncel Claude planı kopyalanmaz veya değiştirilmez; diğer depolara ve hizmetlere yazılmaz. `AGENT.md` ve `agent/**` değişiklik kapsamı dışındadır.

Başlangıç main'i **`cd35ef63d9a80dd6ff224726d2b083fa386a3c59`**, root tree **`ec8db132b6e620f99bfb8c8e4ba4df2ae2efb3b7`** doğrudan geri okundu. Önceki yayından sonra main ilerlememişti. Genel bakımın karşılaştırma tabanı `8cd01e4afdcd0d37960b05930c91e1244678be6e` değişmez. D030'un karar tarihi 29 Eylül; bu notların uygulama tarihi 30 Eylül'dür.

Önceki [A2-CURRENT-INVENTORY](A2-CURRENT-INVENTORY.md) 41 başlangıç dosyasının kimlikli listesini taşır. Bu tur o listenin **03–05 ve 10–15** satırları tamamlandı. `briefs/` içindeki diğer dört belge önceki `cd35ef6` yayınında işlenmişti; yeniden yazılmadı.

## 2. Değişen kaynakların tam listesi ve gerekçeleri

Aşağıdaki dokuz yolun ortak öneki **`research/soul-context/current/briefs/`**'dir. Her dosyanın başına altı satırlık tarihli not ve ayırıcı eklendi; özgün gövde ve dosya sonu korundu. Toplam özgün kaynak büyüklüğü **103.829 byte**.

| Envanter | Dosya | Başlangıç blob'u | Byte | Statü notunun gerekçesi |
|---|---|---|---:|---|
| 03 | `CODEX-COORD-01-NATIVE-HANDOFF.md` | `8bdd1cb3592c9971c71ca1f7887e9c1db136dca8` | 12428 | Eski C1/native yardımcı pilotunu, yerel çıktı iznini ve görev sözleşmesini yeni koordinasyon işi olmaktan ayırmak |
| 04 | `CODEX-COORD-02-PERSIST-ENTRY.md` | `031df0addf1640214d06fd7f03f6956df5e43f03` | 7865 | Eski yerel dal ve iki kayıt dosyası yazma yetkisini bugünkü kurulumdan ayırmak; tarihsel fresh-session NOT RUN sınırını korumak |
| 05 | `CODEX-COORD-03-PUBLISH-ENTRY.md` | `ebf8b7a9369577ecdae15064edc559853ad0e40b` | 9178 | Eski özel aday dalına push/geri okuma iznini yeni yayın yetkisi saymamak |
| 10 | `CODEX-G0-D1-BOUNDARY-DIAGNOSIS.md` | `cefef3a72b46809faebdc46b6e43f6d50dfe027a` | 12682 | Tarihli macOS/Codex teşhisini, sentetik probe'ları ve hipotezleri güncel Claude yeterliği veya yeni koşu izni olmaktan ayırmak |
| 11 | `CODEX-G1-PURPOSE-PILOT.md` | `b6e235b5a4cb0c54624ac10d86dc137da652cda4` | 13297 | Eski P0/P1, yerel aday dalı, korumalı kaynak ve T1–T4/R(P1) pilotunu yeniden başlatmamak |
| 12 | `CODEX-G1-R1-LAUNCHER-CONTINUATION.md` | `3d367e17329869036fdaea0fe36ba6d0a39dda43` | 10057 | Başlatıcı onarımı ve ek bütçeden bugünkü devam yetkisi türetmemek; parser testi ile aktör davranışını ayırmak |
| 13 | `CODEX-STAGE-1-BOOTSTRAP-DESIGN.md` | `83f09e8622e2f2706f56e63ea53143b3af3da30a` | 12048 | Eski minimum başlangıç çerçevesinin bugünkü kapsamı ve kalite hedefini belirlemesini önlemek |
| 14 | `CODEX-STAGE-1A-STARTER-CONTRACT.md` | `4eb655c6e67287ae21cde28bdbaec434f7e1a138` | 10223 | Üç belge adayı ve reviewer düzenini güncel Claude kontrolü veya uygulama sırası olmaktan ayırmak |
| 15 | `CODEX-STAGE-2-G0-EXPERIMENT.md` | `ffe265bce5248ef3dbb3383369678be0f6cfb322` | 16051 | Eski yerel branch/AGENTS değişikliği, C0/C1 ve deney izinlerini yeni kurucunun yetkisi sanmamak |

Ayrıca bu bakım kaydı eklendi; `A2-CURRENT-INVENTORY.md` başına tarihli ilerleme düzeltmesi kondu; `REPOSITORY-TRANSITION.md` güncellendi. Kaynak belgelere yapılan ekler araştırma içeriği veya yeni DevOS planı değildir. Dosya silinmedi/taşınmadı; `MOVES.md` değişmedi.

## 3. Gerçek okuma kapsamı

Dokuz kaynağın tamamı başlangıç commit'inden okundu. Büyük dosyalar aralıklara bölündü; kesilen sonuçların eksikleri örtüşen aralıklarla tamamlandı. COORD-01'de özellikle sonuç/devir bölümü, Stage-1'de son kaynak sınırı ve G0'da T1–T4/kapanış bölümü ayrıca getirildi. Dosya gövdelerinde anlatılan eski görevler uygulanmadı.

Bu okuma; kaynakların atıf yaptığı bütün araştırmaların, dış ürün belgelerinin veya eski ZIP/deney kayıtlarının yeniden tam incelendiği anlamına gelmez. Eski model, izin, platform ve bütçe ifadeleri güncel teknik gerçek olarak doğrulanmadı. Görev şartnamesindeki izin, bu bakımın izni sayılmadı.

## 4. Değişiklik doğrulaması

Düzeltilmiş içerik doğrulama adayı: **`3a371a2b653b6eb37b0c78cd5921b8f24e3c510f`**; tree **`7cf7d124d62e06cc2a6f112dd9efafde0745755c`**; parent başlangıç main'idir.

GitHub compare: **9 dosya, her birinde 6 ek satır ve 0 çıkarılan satır; toplam 54 ek satır**. Commit'in birleşik diff'i tam okundu: dokuz fark da yalnız `@@ -1,3 +1,9 @@` başlangıç hunk'ıdır. Eski gövde içinde değişiklik veya dosya-sonu farkı kalmadı.

İlk yayımlanmamış aday `2369810b96d2bbcab2b4b0a90f229109332da5b4` dört dosyada son satır sonunu kaybetmişti. Karşılaştırma bunu yakaladı; özgün LF geri kondu ve yukarıdaki yeni adayla tekrar denetlendi. Kusurlu aday main'e bağlanmadı. Doğrulama adayı da tek başına main yayını değildir; bakım kayıtları eklendikten sonraki nihai commit'in main'e bağlanması ve geri okunması ayrı adımdır.

Doğrulama ağacında `AGENT.md` blob'u `aea3dd845e0f0bbcfb34465edb23782e99f95c80`, `agent/` tree'si `24fb60959380ca072a2ade392be23931886e0dfe` olarak aynı kaldı. Değişiklik listesi bu dokuz kaynakla sınırlıdır; Foundation, studies, concepts, development-os, explorations ve publications bu kaynak turunda değiştirilmedi. Nihai bakım ağacında araştırma alt ağacının aynı kimlikte kalması ayrıca karşılaştırılır.

## 5. Bağlantı ve okuyucu denetimi

Her yeni not D030'a ve kök bakım planına bağlanır. Dokuz dosyanın iki göreli bağlantısı için **18 yol çözümü** yerelde hesaplandı; hepsi beklenen kök yollarına çözüldü. Bu yalnız yol matematiğidir. D030 hedefinin açık HTML kimliği başlangıç commit'inden ayrıca okundu; bakım planı da aynı commit'ten tam okundu. Güncel dış planın adresi görev belgesindeki adrestir; v2.1 planın içeriği bu tur yeniden değerlendirilmedi.

Doğrudan bir brief açan okuyucu önce tarihli uyarıyı görür: eski yerel görev ve izin uygulanmaz, yeni kurulum tek dış plandadır, araştırma deposu Claude/DevOS için salt okunurdur. Alt metindeki kaliteli muhakeme, kanıt, kontrol ve karşı örnek ayrımları kaynak olarak kalır; tarihsel statü bunları yanlış veya değersiz ilan etmez.

Bu metin/diff incelemesidir; bağımsız denetçi veya gerçek Claude kurucusuyla davranış deneyi değildir. Arama sonucunun öneki atladığı görünümler, eski gövde bağlantıları ve depo genelindeki bütün doğrudan girişler A4/A5'te ayrıca değerlendirilmelidir.

Başlangıç commit'inde `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` sorguları boş döndü. Bu dar gözlem bütün dal ve kimliklerde yokluk ispatı değildir. Yayından önce main/delta ve bu hesap kontrolleri yenilenir; araya giren çalışma ezilmez, force push yapılmaz.

## 6. Sonuç ve tek devam noktası

`current/briefs/` grubundaki **13 görev belgesinin** doğrudan giriş statüsü önceki dört ve bu dokuz belgeyle ele alındı. 41 başlangıç dosyasının 19'u ilgili turlarda işlendi; **22 `current/reviews/` dosyasının içerik/statü incelemesi hâlâ açık**. Yeni current README'nin varlığı bu açığı kapatmaz.

**Tek sonraki iş: `research/soul-context/current/reviews/` altındaki 22 dosyayı, envanterin 20–41 satırlarını, kaynak ve eski devam yönü açısından incelemek.** Kaynak aktarımları, gerçek gözlemler, yorum ve tarihsel kabul sınırları korunacak; Python dosyasının bulunması onu çalıştırma izni sayılmayacak. Gerekçeli koruma da sonuçtur.

Ardından A2'nin DEVOS-001 `reading/` ve EXP-006 P1/P2/P3 doğrudan girişleri kontrol edilir. A3 arşiv, A4 depo geneli tarama ve A5 son karşılaştırma açık kalır. Güncel bakım devamı yalnız [REPOSITORY-TRANSITION](../../REPOSITORY-TRANSITION.md)'dedir; bu not ileride eski bir devir görevi olarak uygulanmaz.
