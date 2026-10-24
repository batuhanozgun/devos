# 30 Eylül 2026 — envanter ilerleme güncellemesi

**Kalan dokuz brief'in statü incelemesi tamamlandı:** aşağıdaki başlangıç envanterinin 03–05 ve 10–15 satırları. Tam dosya listesi, gerekçeler, okuma ve fark denetimi [A2-BRIEFS](A2-BRIEFS.md)'dedir. Böylece `current/briefs/` altındaki 13 görevin tamamı ilgili turlarda işlenmiştir. 41 başlangıç dosyasının 19'u işlenmiş, 22 review/kanıt dosyasının incelemesi açık kalmıştır.

Aşağıdaki tablo ve T/Ö/A işaretleri **29 Eylül'deki envanter ve o turun işlem anlık görüntüsüdür**; tarihsel metadata değiştirilmedi. O an A olan dokuz brief'in sonraki sonucu yukarıdaki yeni kayıttadır. Eski bölüm 5'teki “dokuz brief sonraki iş” ifadesi artık güncel değildir. Bu güncelleme bütün A2'nin veya depo denetiminin kapanışı değildir.

Önceki sekiz not ve current README'nin gerçek yayın commit'i `cd35ef63d9a80dd6ff224726d2b083fa386a3c59` bu turun başında main'den doğrulandı; eski metindeki `ff395e0...` yalnız içerik doğrulama adayıdır. Bu güncelleme ve yeni dokuz notun nihai yayını ayrıca main/ref ve dosya geri okumasıyla doğrulanır.

**Güncel tek devam noktası:** [REPOSITORY-TRANSITION](../../REPOSITORY-TRANSITION.md). Bu turdan sonraki alt küme `current/reviews/` içindeki 22 dosyadır (20–41). Eski denemeler yeniden başlatılmaz.

---

# A2 — eski current alanının envanteri ve ana devir girişleri

**Tarih:** 29 Eylül 2026. **İş:** REPO-SEPARATION-20260929 / A2. **Statü:** KISMİ TAMAMLAMA; bu alanın envanteri tam, bütün içerik denetimi tamam değil.

## 1. Yetki, kaynak sürümü ve kapsam

[REQUEST](REQUEST.md) §3.2, §3.5, §4–§6 ve Batu'nun “Devam et” mesajı uyarınca yalnız `batuhanozgun/agentic-os-search` içinde statü/yönlendirme bakımı yapıldı. Kurulum, yeni mimari veya SOUL işi açılmadı. Dış planın tek adresi `batuhanozgun/devos/plan/`, devir sürümü 2.1; diğer depolara yazılmadı.

Turun başlangıç ve karşılaştırma commit'i **`f690aa6bf5398d90bef2b7ee0b1b74ff52ba96c7`**; root tree **`8635015e545c76b9609ad696b3970eeeb89293c9`**. Önceki yayından sonra main ilerlememişti. Bütün bakımın ilk tabanı `8cd01e4afdcd0d37960b05930c91e1244678be6e` değişmez.

## 2. Eksiksiz yol envanteri — içerik okumasıyla karıştırma

`research/soul-context/current/` kökünün Contents yanıtındaki iki dosya ve üç alt dizin ayrı incelendi. Alt dizinlerin recursive Git tree yanıtları **`truncated=false`** döndü:

| Alt ağaç | Başlangıç tree SHA | Dosya |
|---|---|---:|
| `briefs/` | `8d1450bcbc906e095605555ebd3410281c0bff46` | 13 |
| `claude-code-devos-preparation/` | `d5814c5b070609d189e5d4e128c61fa5626f169a` | 4 |
| `reviews/` | `2c15d63ca63812f00dbca0b3447d8ab8efcbefd9` | 22 |
| Kök dosyalar | Yukarıdaki sabit commit / Contents yanıtı | 2 |

**Toplam: 41 dosya, 494.942 byte; 40 Markdown ve 1 Python dosyası.** Bu sayı kaynak metadata envanteridir, 41 dosyanın tamamının içeriğinin okunduğu anlamına gelmez. Yeni `current/README.md` başlangıç envanterinde yoktur; bu tur eklenen 42. dosyadır.

Aşağıdaki yolların tamamının öneki **`research/soul-context/current/`**'dir. Blob ve boyutlar bu turun başlangıcına aittir; yeni önekli dosyaların kimliği değildir.

**Durumlar:** `T` = bu tur tam okundu, altı satırlık statü notu eklendi ve kaynak farkı denetlendi. `Ö` = önceki turda işlenmiş; bu tur yalnız güncel metadata kimliği kontrol edildi. `A` = yalnız envanterlendi; içerik/statü incelemesi açık, değiştirilmedi. `A`, dosyanın kusurlu veya mutlaka değiştirilecek olduğu hükmü değildir.

| # | Yol | Başlangıç blob'u | Byte | Durum |
|---|---|---|---:|:---:|
| 01 | `COORDINATION-TRANSFER-PLAN.md` | `85ab178803b0e6ba40c9454c288bfb4ccc35e14b` | 14321 | T |
| 02 | `DEVELOPMENT-OS-BOOTSTRAP.md` | `5bb353dc91ce47bf654ef1f4701eff5d7fce15cb` | 19404 | T |
| 03 | `briefs/CODEX-COORD-01-NATIVE-HANDOFF.md` | `8bdd1cb3592c9971c71ca1f7887e9c1db136dca8` | 12428 | A |
| 04 | `briefs/CODEX-COORD-02-PERSIST-ENTRY.md` | `031df0addf1640214d06fd7f03f6956df5e43f03` | 7865 | A |
| 05 | `briefs/CODEX-COORD-03-PUBLISH-ENTRY.md` | `ebf8b7a9369577ecdae15064edc559853ad0e40b` | 9178 | A |
| 06 | `briefs/CODEX-COORDINATION-HANDOFF.md` | `b4e6fff077e5ac9f36b8898e5325a3bea23b3f10` | 10825 | T |
| 07 | `briefs/CODEX-DESIGN-01-FIRST-SOUL-SCENARIO.md` | `42f54428d0234467e51bd97e0e88ff86df5a197d` | 11358 | T |
| 08 | `briefs/CODEX-DEVOS-AGENT-CONTROL.md` | `e34d2b1be43c21982ac882b3ffbfa3437b620885` | 13043 | T |
| 09 | `briefs/CODEX-DEVOS-CONSTRUCTION-PLAN.md` | `ac11ceb6ae2dfea4af7fb9a40bf5f04d47b96382` | 25062 | T |
| 10 | `briefs/CODEX-G0-D1-BOUNDARY-DIAGNOSIS.md` | `cefef3a72b46809faebdc46b6e43f6d50dfe027a` | 12682 | A |
| 11 | `briefs/CODEX-G1-PURPOSE-PILOT.md` | `b6e235b5a4cb0c54624ac10d86dc137da652cda4` | 13297 | A |
| 12 | `briefs/CODEX-G1-R1-LAUNCHER-CONTINUATION.md` | `3d367e17329869036fdaea0fe36ba6d0a39dda43` | 10057 | A |
| 13 | `briefs/CODEX-STAGE-1-BOOTSTRAP-DESIGN.md` | `83f09e8622e2f2706f56e63ea53143b3af3da30a` | 12048 | A |
| 14 | `briefs/CODEX-STAGE-1A-STARTER-CONTRACT.md` | `4eb655c6e67287ae21cde28bdbaec434f7e1a138` | 10223 | A |
| 15 | `briefs/CODEX-STAGE-2-G0-EXPERIMENT.md` | `ffe265bce5248ef3dbb3383369678be0f6cfb322` | 16051 | A |
| 16 | `claude-code-devos-preparation/CLAUDE-TASK-01.md` | `50f9adef674d8e39a2b0eb19935835541f9ff901` | 1830 | Ö |
| 17 | `claude-code-devos-preparation/OWNER-CONTEXT.md` | `5194db5a93559be0587511c751270b0da29e2501` | 4178 | T |
| 18 | `claude-code-devos-preparation/SOURCE-REGISTER.md` | `cb5ce00f3358c9fada4c68e16d976fb89781795e` | 7518 | T |
| 19 | `claude-code-devos-preparation/WORK.md` | `93bdec4ee5034a12d640e9529621a44fce2c24db` | 2256 | Ö |
| 20 | `reviews/2026-09-06-direction/OPENING-VISION-SOURCE.md` | `f8d4aa7c5fb6b09dc3e49ba5f336bb30bc5c4825` | 13690 | A |
| 21 | `reviews/2026-09-06-direction/REVIEW.md` | `d7ea6a8b664ee9f973a8ec9b78c3bcaf14a03222` | 13345 | A |
| 22 | `reviews/2026-09-06-g0/EVIDENCE-EXTRACTS.md` | `f66e20322e8fa3b27aeed4c68331d20cdafd36b3` | 9410 | A |
| 23 | `reviews/2026-09-06-g0/REVIEW.md` | `bb95618266b8d5d31a2b0d327af09331fe1801ad` | 14308 | A |
| 24 | `reviews/2026-09-06-stage-1/CODEX-RESPONSE.md` | `4f64d7a5178ad639c2052a0f144653971b947295` | 21046 | A |
| 25 | `reviews/2026-09-06-stage-1/REVIEW.md` | `b788ee43c01dd8f375c5a02274d29191310f5cd3` | 19273 | A |
| 26 | `reviews/2026-09-06-stage-1a/CODEX-RESPONSE.md` | `7486c3c1034eec067186d1fdc3e5c2cadc61d52a` | 24164 | A |
| 27 | `reviews/2026-09-06-stage-1a/REVIEW.md` | `7091782069c320cdb079347ed3f1943d3772ff5d` | 13815 | A |
| 28 | `reviews/2026-09-07-collaboration/REVIEW.md` | `5d4e06480a17aca2ae22d72ff67814c77a65db59` | 11437 | A |
| 29 | `reviews/2026-09-07-coord-01/CODEX-RESPONSE.md` | `7156154fa795ec2c19b920fe1ba6ec6b5a5b4059` | 8650 | A |
| 30 | `reviews/2026-09-07-coord-01/REVIEW.md` | `cc05adecf3aec58ff451b57a6f5a91d4d04e451a` | 8195 | A |
| 31 | `reviews/2026-09-07-coord-02/FRESH-SESSION-REVIEW.md` | `486a8207dc92be73fa65625d518b4ebe9390aac2` | 10813 | A |
| 32 | `reviews/2026-09-07-coord-02/IDENTITY-RESOLUTION.md` | `550a5971e9746b3382d45a0dc67942cbd0a955bc` | 8828 | A |
| 33 | `reviews/2026-09-07-coord-02/REVIEW.md` | `73f4d62b7b1d094c37e210a9294e26736f0c8be2` | 6528 | A |
| 34 | `reviews/2026-09-07-coord-03/REVIEW.md` | `6b39a486fee6f4b50ae78d75e5566aeca5745137` | 9299 | A |
| 35 | `reviews/2026-09-07-d1/EVIDENCE-EXTRACTS.md` | `42fb4fd8810b2bbf7f2b681faf30265e8729403c` | 8957 | A |
| 36 | `reviews/2026-09-07-d1/REVIEW.md` | `8a2a4d625fa03aceed6b7fe6369ceb668b2edd42` | 10309 | A |
| 37 | `reviews/2026-09-07-g1/EVIDENCE-EXTRACTS.md` | `78f31b8bdb324141168095d643ea183e198758bf` | 8981 | A |
| 38 | `reviews/2026-09-07-g1/PARSER-REGRESSION.py` | `4ac9e88bd9da533f5c9cde81126eb38a27a121b1` | 5331 | A |
| 39 | `reviews/2026-09-07-g1/REVIEW.md` | `527aa6b24543e955d28ce3a7cecb7b383e5415ef` | 9646 | A |
| 40 | `reviews/2026-09-07-method/REVIEW.md` | `d4ec7135f3079f1e589543b7896f2e12e7ee7288` | 12192 | A |
| 41 | `reviews/2026-09-08-devos02-plan/REVIEW.md` | `779bd2a71ee44188c8bfbc3874afd415a90b21c3` | 33101 | A |

Envanter dökümü yerelde benzersiz yollar, 40 karakterlik blob kimlikleri, boyutlar ve durum sayıları açısından kontrol edildi: 8 T + 2 Ö + 31 A = 41. Bu kontrol elle aktarılmış metadata'nın tutarlılığıdır; bağımsız kaynak denetimi veya bütün gövdelerin hash doğrulaması değildir.

## 3. Sekiz değişikliğin gerekçesi

| Envanter satırı | Müdahalenin gerekçesi |
|---|---|
| 01 | Eski Codex pilotu ve B–D geçişlerini güncel koordinasyon planı olarak devralmayı önlemek |
| 02 | CURRENT etiketi, Stage 0–4, eski ürün/DevOS depoları ve geçici insan relay'ini tarihsel bağlama almak |
| 06 | Sürekli koordinasyon mandatı ve aday dal yazma yetkisinin yeni kurucuya taşınmasını önlemek |
| 07 | İlk küçük SOUL senaryosu önerisinin yeni ekibin ilk işi veya kabul edilmiş ürün tercihi sanılmasını önlemek |
| 08 | Proje malzemesindeki kontrol kurma görevinin etkin agent-control veya yeni protokol yazma izni sanılmasını önlemek |
| 09 | `_02` planlama görevi, eski K01–K12 ve yeni mandat önerisinin bugünkü kurulum şartnamesi sanılmasını önlemek |
| 17 | Kullanıcı alıntılarını aynen korurken eski iletişim/ilk görev rollerini bugünkü kullanıcı kararından ayırmak |
| 18 | Tarihli okuma, ZIP, platform ve W01 erişim kayıtlarının bugünkü doğrulama/yetki gibi kullanılmasını önlemek |

Bu sekiz dosyanın tamamı değişiklik öncesi sabit ref'ten okundu. Uzun dosyalar aralıklara bölündü; kesilen araç görünümlerinin eksik aralıkları tamamlandı. Atıf yaptıkları bütün araştırmalar, haricî belgeler veya hedef deneyler yeniden okunmuş/koşulmuş değildir. Özellikle eski OpenAI/Claude kabiliyet ve fiyat ifadeleri bu bakımda güncel olgu olarak doğrulanmadı.

Yeni `research/soul-context/current/README.md`, dizin adının bugünkü statü olmadığını açıklayan giriş ve mevcut geçerli plana bağlantıdır. Yeni DevOS planı, canlı iş listesi veya ikinci karar otoritesi değildir. Yeni envanter dosyası bu bakımın kapsam/kanıt kaydıdır; `REPOSITORY-TRANSITION.md` tek güncel bakım devamını taşır.

## 4. Fark ve bağlantı denetimi

Düzeltilmiş içerik adayı **`ff395e0eefbbc8b1e4de7af609ada4bfa84be1e9`**, tree **`1407d2d265f88c1773256a681df056cb799b0592`**, parent başlangıç main'idir. GitHub compare: **sekiz mevcut dosyanın her birinde 6 ek satır ve 0 çıkarılan satır**; ayrıca 22 satırlık yeni README. Kaynak patch'leri dosya başındaki `@@ -1,3 +1,9 @@` hunk'larıdır. Özgün gövdelere ekleme, çıkarma veya yeniden yazma yoktur; toplam kaynak notu 48 satırdır.

İlk yayımlanmamış aday `c219555...` içinde iki İngilizce brief'e istemeden eklenen dosya-sonu satır sonu saptandı. Bunlar geri alındı; son karşılaştırma yukarıdaki düzeltilmiş aday üzerindedir. İlk aday main'e bağlanmadı. Doğrulama adayı tek başına main yayını değildir; nihai main commit'i ve uzaktan geri okuma ayrıca doğrulanır.

Yeni sekiz D030 bağlantısının göreli yol çözümü yerelde kontrol edildi; D030'un açık HTML kimliği sabit commit'teki DECISIONS girişinden yeniden okundu. README'nin bakım planı ve bu envanter bağlantıları da yol bakımından kontrol edildi. Toplam 10 yerel yol kontrolü, bütün tarihsel bağlantıların veya dış plan içeriğinin denetimi değildir. Kalan eski bağlantılar A4/A5 kapsamındadır.

Başlangıçta `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` ile main commit sorguları boş döndü. Bu yalnız sorgulanan main/kimlik kapsamındaki gözlemdir; bütün dallarda veya başka kimlikle yazılmış kayıtlarda yokluk kanıtı değildir. Yayından hemen önce main/delta ve yazar kontrolü yenilenir; force push yapılmaz, araya giren çalışma ezilmez.

## 5. Korunan sınırlar ve kalan iş

Kaynak dosyası silinmedi veya taşınmadı; `MOVES.md` değişmedi. Bu turdaki kaynak değişiklikleri yalnız yukarıdaki sekiz dosyada statü öneğidir. `AGENT.md`, `agent/**`, Foundation, studies, concepts ve özgün araştırma gövdeleri değiştirilmedi. Başka repository veya hizmete yazılmadı. Eski rapor/ZIP arşivi bu tur kurulmadı; dosya adı, hash veya teslim beyanı gerçek arşiv erişimi sayılmadı.

**Tek sonraki iş:** `briefs/` içindeki dokuz A satırını (03–05, 10–15) kaynaklarına bağlı tam okumayla statü/yön açısından sonuçlandır. Ardından bu alanın 22 `reviews/` dosyası (20–41) aynı bakım kapsamında ele alınacak. Python/kanıt kaydı bulunması onu çalıştırma talimatı değildir; kaynak/kanıt bütünlüğü korunur. Yeni README bu dosyaların bireysel denetiminin yerine geçmez.

DEVOS-001 `reading/` girişleri ve EXP-006 P1/P2/P3 doğrudan yolları A2'nin diğer açık kapsamıdır; bu tur incelenmiş sayılmaz. A3 arşiv, A4 bütün repository taraması ve A5 son karşılaştırma ayrı açık iş paketleridir. Buradaki tamamlanan alt küme, “depoda yanlış güncel yön kalmadı” veya gerçek Claude davranış testi hükmü üretmez.