# Superpowers — Okuma ve kalıcı aktarım durumu

2026-09-20, **B6-T10 / P2-PILOT-CLOSED / DURABLE-TRANSFER-COMPLETE / PACKAGE-COMPLETE**. Bu concepts içindeki yerel kapsam/okuma kaydıdır; kaynak araştırmanın STATE'i ve global concepts/STATE.md ayrı yetki/durum yüzeyleridir.

## 1. Güncel iş ve devam

[TERMS.md](TERMS.md) ve altı bağlı parçası birlikte tam okunur: [ENTRY](TERMS-ENTRY.md), [WORK](TERMS-WORK.md), [VERIFICATION-DELIVERY](TERMS-VERIFICATION-DELIVERY.md), [EVOLUTION-EVALUATION](TERMS-EVOLUTION-EVALUATION.md), [RUNTIME-DISTRIBUTION](TERMS-RUNTIME-DISTRIBUTION.md), [SYSTEM-PROJECTION](TERMS-SYSTEM-PROJECTION.md). **Superpowers için B6 kalıcı bağlamlı kullanım çıkarımı tamamlandı.** Kaynak araştırmanın ve P2 pilotunun kapanışları ayrı statüler olarak korunur; ürün etkinliği, ortak terim referansı veya mimari kabulü bu kapanışın parçası değildir.

B6-T10'da kalan S05/S06 ve SOURCE-LEDGER-U08A/B/C tam okundu. Tarihsel SP150–SP160 grubunun özgün satır metni durable repoda bulunmadığından METHOD §8'e uygun source-controlled regeneration kullanıldı; U08-R adresleri kaynaktan çıkarıldı ve exact legacy-row correspondence iddia edilmedi. Paket-geneli kontrolde READING envanterindeki yinelenmiş S05 satırı da kaldırıldı; bu bir kaynak eksikliği değil yerel kayıt hatasıydı.

**Sıradaki yetkili B6 işi:** `research/studies/ai-knowledge-strategies/` paketine canonical preflight ile girip kendi gerçek dosya ağacını, META/STATE/INDEX durumunu ve kaynak sürümünü recover etmek; ardından aynı yöntemle bağlamlı kullanım çıkarımını başlatmak. Superpowers yeniden yapılacak iş değildir. S1 sonrası gözlenen yeni study yolları ayrıca kapsam deltası olarak korunur ve bütün seri/B7 kapanmadan dışlanamaz.

B7/B8 henüz başlamadı. Bütün research/studies kapsamı, S1 sonrası eklenen/değişen yollar dahil tamamlanmadan ortak referans değerlendirmesine geçilmez.

## 2. Kaynak bağlama ve sürüm

- Repository **batuhanozgun/agentic-os-search**; kaynak öneki **research/studies/superpowers/**.
- P2 kaynak ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**; S1 ref'i **9b46155e904560c90b89e657f3d0d4e00e2e46cf**.
- Paket tree **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**.
- B6-T5 başlangıcı **1108a483a811c3d5e22595f99179e51da8479f16**, research tree **5d0efc37a85722f988937226270aa7a7f88c090e**, studies tree **0693c76d133d256df60b412a07c8481da41ae33d** üzerinden paket kimliği doğrudan doğrulanmıştı.
- B6-T6/T7/T8 kaynak, yayın ve delta ayrıntıları §4'teki değişmez checkpoint'lerde korunur.
- B6-T9 başlangıcı **5229f57b304ed246bbdb471f5091827c68123f01**. Önceki concepts kapanışı **83771eca414eeb90e2c565d1dd00c11fe0e47a01** ile compare bir commit/üç yol gösterdi: studies CATALOG/INDEX değişimi ve yeni `research/studies/ponytail/META.md`. Superpowers, concepts ve agent-control değişmemişti. Tam ağaç keşfi bu tur yeniden yapılmadı.
- B6-T10 başlangıcı **9fdbb21779647ff84bdd2354a7c1cb15b4392f4e**. Pinned research ref → başlangıç main karşılaştırmasında `research/studies/superpowers/**` altında değişiklik yoktu; yalnız concepts ve diğer studies/delta yolları farklıydı. Bu nedenle kalan beş dosya aynı sabit package tree/blob kimliklerinden okundu; eski kayıtlar yeni upstream sürüme sessizce yükseltilmedi.

Değişmez manifestler: [19 kök dosya ve üç alt ağaç](https://api.github.com/repos/batuhanozgun/agentic-os-search/git/trees/56c19a5e2c0deb7b0f5164aac818ed2ba98baf12), [11 not](https://api.github.com/repos/batuhanozgun/agentic-os-search/git/trees/cc9611a59f65ec1175fd99885c01a6efebc202ed), [6 sentez](https://api.github.com/repos/batuhanozgun/agentic-os-search/git/trees/bfb0603d70683e512df789bfa52c929caa67d9ea), [16 betik/sonuç](https://api.github.com/repos/batuhanozgun/agentic-os-search/git/trees/7a5af9c7cf94551a42102bcfd9e2ddd36434cd9a). B6-T5'te tam girdileriyle alınmıştı; tree hash'i bu tur yeniden hesaplanmadı.

**52 dosya: 36 Markdown, 8 betik, 8 JSON sonucu.** Bu dış ürünün bütün dosyaları veya ilerleme yüzdesi değildir. Dış kaynak/başka studies atıfları onların tam okuması sayılmaz. Kontrol ve concepts giriş okumaları bu sayaca eklenmez.

Dış ana hedef **obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797**, manifest bağlamı 6.3.0; lab **prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b**; tarihsel assessor **prime-radiant-inc/gauntlet@db6c8e0fcf80889aa6d9631c99adec698f6c0caa**, ayrı **25a2e3e00431f8d8eb63781162ccb974d43d5405** deltası. Bunlar kaynak araştırmanın kimlikleri, bugünkü kurulum veya her tarihsel koşu için aynı runtime değildir. Kaynak araştırmanın user-evaluated/accepted durumu değişmez.

## 3. Bütün kaynak dosyalarının yerel envanteri

Tüm kipler 100644; yollar kaynak önekine göre. **T5/T6/T7/T8/T9/T10**, kalıcı aktarım için dosyanın tam geri kazanıldığı turdur. Tam okuma bütün çapraz atıfların bağımsız doğrulandığı anlamına gelmez. **15 T5 + 8 T6 + 9 T7 + 7 T8 + 8 T9 + 5 T10 = 52; bekleyen P satırı kalmaz.**

| Yol | Blob SHA | B6 tam geri okuma |
|---|---|---|
| CLOSURE-AUDIT.md | b6178fdc2817eaf93c447434a014ca971a972348 | T5 |
| CORE.md | 0986da960a4b3db5d1e09894c2abfd6d6ca114be | T5 |
| INDEX.md | c170993756d19c2d98831ca1dd371c5aadf3c53a | T5 |
| META.md | 80c32a688127ca811421c9579cd9fef7a1c0d6a9 | T5 |
| METHOD.md | 95f684306f92373dbb51f4ceedaff885394e950b | T5 |
| PLAN.md | ea86caa9144bfd462428a3c8ef3ffb6ab7d5ca00 | T5 |
| SOURCE-LEDGER-U03.md | 76075ba19f8012d9d2b582887a22c9edf2362d2d | T6 |
| SOURCE-LEDGER-U04.md | 113f818cbc47a28105b00a0d5578b73567a18be6 | T7 |
| SOURCE-LEDGER-U05.md | 3066325dda3a9d6f10b4181863ea642ece5eb59f | T7 |
| SOURCE-LEDGER-U06A.md | 3122010a6494f5a8d9b98a8d1a1edc39594a3aa9 | T8 |
| SOURCE-LEDGER-U06B1.md | 90e75d48a02e02c7a6aa55e6b3a8123469dfb690 | T8 |
| SOURCE-LEDGER-U06B2.md | 1e315c6bb3575a0f299d9c5d322fe5c60452c0b5 | T8 |
| SOURCE-LEDGER-U07A.md | d909ec43c39a7810eb5f4d27f8094d158f7c0610 | T9 |
| SOURCE-LEDGER-U07B.md | b91571c78b7152f4f4cb68d480662a3f4b2b1004 | T9 |
| SOURCE-LEDGER-U08A.md | 7d34445f2f1d3defd9af1d33d8c7df39df5822eb | T10 |
| SOURCE-LEDGER-U08B.md | 0213fce532c82b132decbfb95ed35a494fab71ae | T10 |
| SOURCE-LEDGER-U08C.md | fbca2a3b8ac21cc9849216682c95649bd969263f | T10 |
| SOURCE-LEDGER.md | a09cd522f1b51cec1d3fc9c30a017f8931e35dd2 | T5 |
| STATE.md | 472b9f16bd68d0e05a4108fb1b2155ee2b7a2d2f | T5 |
| notes/U01-entry-routing-and-bootstrap.md | 8b8e63451e77d78e7b9be4de190944157a8120f2 | T5 |
| notes/U01B-host-delivery-and-continuity.md | cc2c0ba68f8d90ec6680b9b4b2d7cc0bc3405620 | T5 |
| notes/U02-approval-plan-workspace-handoff.md | 20568d3bfe398e7e0ff43abf2cb29e84925834ae | T6 |
| notes/U03-delegation-review-and-acceptance.md | 4dfe415cf35386650a30fa7104e5537355276977 | T6 |
| notes/U04-testing-diagnosis-and-verification.md | 975d935ad98634624537571e77e38e4ec5268ee7 | T7 |
| notes/U05-delivery-cleanup-and-retention.md | d3e797780ffb14781361194e5d82799033f14b49 | T7 |
| notes/U06A-skill-authoring-and-change-admission.md | 469dbea119e410a11c2130bb94ff4e90ed34a7fc | T8 |
| notes/U06B1-evaluation-evidence-and-verdict.md | 54418ac55a5129cde6f0ee1ddf0c471f361a6a1d | T8 |
| notes/U06B2-assessor-contracts-and-evidence-qualification.md | adb00736fc90b481568a73288c81ce6929ad1f1a | T8 |
| notes/U07A-visual-companion-lifecycle.md | cb87245b449ff383af55af5f9e4dd50a15532c94 | T9 |
| notes/U07B-distribution-versioning-and-support.md | 2de6f304f2d7c3630b27cfdbe7291fe2e7f1b3fc | T9 |
| syntheses/S01-skill-evolution-and-evaluation.md | df93d7bcd127f3d31e82ab8dcc80b9668b0c7231 | T8 |
| syntheses/S02-availability-runtime-and-distribution.md | 0546c46231ef17da3cdb204520d7846176c27cfe | T5 |
| syntheses/S03-intent-planning-and-context-handoff.md | f69f5c99aefa2a6a13b4233ae49afd73dc2ce0ca | T6 |
| syntheses/S04-execution-verification-and-delivery.md | 54c77cc04e9d7f88900918f8ee63dd07dadb0e54 | T7 |
| syntheses/S05-native-system-model.md | 9044ebaa66c913b3b526935850715d62d421d262 | T10 |
| syntheses/S06-project-facing-contribution-and-comparison.md | 8ab988debc34b70efd55b4c6145a06a96c70b256 | T10 |
| evidence/U01-hook-probes-results.json | 0a21d98568b71a7c1d99385b9d8ae88611ebed78 | T5 |
| evidence/U01-hook-probes.py | 9ca0b43739e69c930d1241601bb61b7ef1872ff1 | T5 |
| evidence/U01B-opencode-probes-results.json | fae46fb808c5814fc7039f874f7d9aae5e5b34f3 | T5 |
| evidence/U01B-opencode-probes.mjs | 6a99be598bac4d60943c816857124c907882c089 | T5 |
| evidence/U02-handoff-probes-results.json | c95be67a743b7e8526e9fe30a2198117aee61d50 | T6 |
| evidence/U02-handoff-probes.py | 5cf7d9dd25ade628743a3250158486c8349a6fb5 | T6 |
| evidence/U03-review-probes-results.json | 48ba0976e661c74fe20f9232836fcc2dc2debb19 | T6 |
| evidence/U03-review-probes.py | a1982668d06c8cf22783af60bfb5430839eb1b5c | T6 |
| evidence/U04-diagnostic-probes-results.json | 875f03b27e53b8a6013f2facbace833fd7478cb9 | T7 |
| evidence/U04-diagnostic-probes.py | 37ca1fe7d2ee6c0390e51f9eb56b281a26138eee | T7 |
| evidence/U05-lifecycle-probes-results.json | 565da2eaf7aa293eea5663dce74436c71bb7595b | T7 |
| evidence/U05-lifecycle-probes.py | a59ca7af17737f64fa8ed54c214b77ceecd522a5 | T7 |
| evidence/U07A-companion-client-probes-results.json | 2ceef31098d65cfda54bfa708ab0ed002632f37e | T9 |
| evidence/U07A-companion-client-probes.mjs | 27082457c9e782cfec1e392aa78e02677d54b735 | T9 |
| evidence/U07B-version-probes-results.json | be459537a1e14bbf5f75f4823b5e33d4db88644b | T9 |
| evidence/U07B-version-probes.py | 63763cce58982ab0c22002ca767765eaaec16f9f | T9 |

## 4. Gerçek okuma ve korunmuş geçmiş

[B6-T5 yerel checkpoint](https://github.com/batuhanozgun/agentic-os-search/blob/53cc0647266228e3f5446bbe69a6d55b573a19a4/concepts/studies/superpowers/READING.md) ilk 15 okuma/giriş kontrolünü; [B6-T6](https://github.com/batuhanozgun/agentic-os-search/blob/d34605f570906a674f53b9372f6cad7b66013f2c/concepts/studies/superpowers/READING.md) sekiz U02/U03 okumasını; [B6-T7](https://github.com/batuhanozgun/agentic-os-search/blob/f18fc9b53f6508f663139c1400d1cd08596c8685/concepts/studies/superpowers/READING.md) dokuz U04/U05 okumasını; [B6-T8](https://github.com/batuhanozgun/agentic-os-search/blob/825d3195d09ef2ea7a1739c8809c698fe2c4e158/concepts/studies/superpowers/READING.md) yedi U06 okumasını ve eski bölüm/yorum/delta kayıtlarını korur. Eski next sözleri güncel değildir. [P2/B4 kapanışı](https://github.com/batuhanozgun/agentic-os-search/blob/29b07b6529618f9a654d44a86e3ed6b05b8b40f9/concepts/STATE.md) pilotun gerçek tam okuma checkpoint'lerine gider; kayıtlı okuma yeni aktörün fiilî erişimi yerine geçmez.

| B6-T9 yeni tam kaynak okuması | Gerçek aralık | Kalıcı karşılık |
|---|---|---|
| U07A notu / A | 1–75, 76–EOF; ikinci istek 200'e kadar | RUNTIME-DISTRIBUTION §2–4/§8–9; SP122–134, SP28.visual, U07-A01–03. |
| SOURCE-LEDGER-U07A / LA | 1–EOF | S71–78/E13–14 kimlikleri, geçmiş client ile source-only server ayrımı. |
| U07A-companion-client-probes.mjs | 1–135, 136–EOF; ikinci istek 290'a kadar | Exact-helper aktarım denetimi, fake DOM/WS/clock ve dokuz vakanın ölçütleri. |
| U07A-companion-client-probes-results.json | 1–EOF | Dokuz gözlem, iki karşılanmamış daha güçlü ölçüt; bütün payload/trace alanları. |
| U07B notu / B | 1–75, 76–EOF; ikinci istek 200'e kadar | §5–9; SP135–149/175–176, U07-B01–03 ve kaynak/etkin sürüm. |
| SOURCE-LEDGER-U07B / LB | 1–65, 66–EOF; ikinci istek 160'a kadar | S79–102/E15–16, seçilmiş dış kaynak ve çalıştırılmamış destekler. |
| U07B-version-probes.py | 1–125, 126–EOF; ikinci istek 250'ye kadar | Sekiz JSON-only fixture, bağımsız dosya okuması, kip ve sonuç koşulları. |
| U07B-version-probes-results.json | 1–EOF | Sekiz vaka, bütün stdout/stderr/files alanları; iki başarısız güçlü ölçüt. |

| B6-T10 yeni tam kaynak okuması | Gerçek aralık | Kalıcı karşılık |
|---|---|---|
| syntheses/S05-native-system-model.md | 1–EOF | SYSTEM-PROJECTION §2/§5; native analytical views, development/method loops, composition register, authority ve handoff qualification. |
| syntheses/S06-project-facing-contribution-and-comparison.md | 1–EOF | SYSTEM-PROJECTION §3/§5; project-facing reuse dili, plan/pursuit coverage, adequate+available view, authority/capability ve adaptation ayrımları. |
| SOURCE-LEDGER-U08A.md | 1–EOF | S05 provenance, direct-source re-entry, I01/I02 ve native-model challenge sınırları. |
| SOURCE-LEDGER-U08B.md | 1–EOF | Foundation/comparator snapshot, selective reuse, S06 provenance ve attribution sınırları. |
| SOURCE-LEDGER-U08C.md | 1–EOF | Freshness eşitliği, final reverse-source challenge, I03/I04 ve bounded closure provenance. |

Ek yeniden erişimler: S02 ve S03 tam 1–EOF okundu; zaten T5/T6 satırları olduklarından sekiz yeni dosyaya eklenmez. S01/S04 ve görünür P2-T4/T5 gerçek metinleri mevcut bağlamda kullanıldı. EOF görülen içerik sonudur, istek üst sınırı gerçek satır sayısı değildir. Araştırma betikleri, server/browser, paketleyici, sürüm yardımcısı, host/model veya upstream suite bu tur çalıştırılmadı.

Eksik gerçek canonical kontrol/proje giriş içerikleri tam geri kazanıldı: R02/R03/R04/R05/R07/R08/R09; CHARTER/METHOD/ORIGIN/SETUP-REVIEW ve WORK'ün eksik başlangıcı. Büyük yanıtlardaki kesik sonlar örtüşmeli aralıklarla tamamlandı. R01'in önceki gerçek tam metni, INDEX/PLAN/SCOPE, güncel STATE/READING/TERMS ve önceki parçaların mevcut tam metinleri aynı konuşmadaki kaynak içerikleridir; yalnız özet kullanılmadı. Kontrol ve concepts kayıtlarının okunması araştırma dosya sayacına eklenmedi.

## 5. U07 kaynaklarından kalıcı kayda kapsam kontrolü

Adresler RUNTIME-DISTRIBUTION içindedir. Kaynağın bölüm, tablo, liste, örnek ve deney alanlarından kayda geri gidildi; yalnız eski SP listesinin tekrar onayı yapılmadı.

| Kaynak | Karşılık / korunan sınır |
|---|---|
| A §1–2 | Kaynak anahtarı, SP122/SP28.visual; isteğe bağlı diyalog desteği, araç teklifine kabul ile tasarım onayı. |
| A §3 | SP126/131 ve U07-A01; key/cookie/Origin/file/process kontrolleri, erişim ile named-human authority ayrı; güvenlik testi yok. |
| A §4 | SP124–128/U07-A02; session/project ömrü, occupied-port ve explicit-token, kuyruk/recovery ve yeniden bağlantı. |
| A §5 | SP129/132; normal click/default choice API, truthy alan ve dedicated-file tüketimi; server sonucu source-derived. |
| A §6 | SP133/134; deselect/son tıklama, id/timestamp/screen binding ve eski/yeni helper kuyruğu; yanlış gerçek onay iddiası yok. |
| A §7 | SP123/129/130/U07-A03; mtime, yeni/aynı filename, log/events/HTML ömrü, stop marker/watchdog, lexical tmp ve ortam koşulları. |
| A §8 | SP131; local hosting/remote resource, kapatma/no-referrer ve keyfi HTML sınırı; gerçek telemetry gözlemi yok. |
| A §9–10 | §4/§9; dokuz source-informed vaka, iki unmet criterion, S77 başlığı/gövdesi ve Q41–43. |
| B §1–2 | Kaynak anahtarı, SP135–137; ref+metadata arşivi ile working-tree sync ve host installation farklı. |
| B §3 | SP138/139/176/U07-B01; required metadata/count, publisher ve semantic sınır; attributes/toolchain girdileri; paket yapılmadı. |
| B §4 | SP136/140/175 ve §5; preview/destination korumaları, allowed untracked/dirty kaynak, HEAD permalink ve eski exclusion sınırı. |
| B §5 | SP141–144/§6; check/audit/bump, missing-middle/last, malformed koruma, undeclared old/current ve exit-only oracle. |
| B §6 | SP144–146/U07-B02; acquisition/module cache, native discovery/özel injector, fresh session ve active identity. |
| B §7 | U07-B03; linter/pre-commit/test türü/gerçek release gate ve sentetik eski hook fixture ayrımı. |
| B §8 | SP147–149; process DSL/rendering/execution, template/default review, copied reference/current vendor ve örnek eval JSON'u. |
| B §9 | §8–9; kaynakla sınırlı kapanış/Q44–46, yeni ürün veya genel literatür borcu yok. |
| LA/LB | Kaynak kimliği, full/partial/source-only ayrımı; X08/X09 atfı yeni dış belge okuması değil; kontrol metinleri corpus kanıtı yapılmadı. |
| E13-R/O | Dokuz vaka, classification/observation_verified/criterion_met, fake-DOM/transport/clock ve source-only server sonucu. |
| E15-R/O | Sekiz vaka, mode/exit/stdout/files ve stronger criterion; gerçek production/YAML veya release değil. |
| S02 §1–7 | §5/§7–8 ile kaynak/kanal/aktivasyon, host yolları, recovery ve görsel kanal; gerçek aktör başarısı denmedi. |
| S03 §1/§6–7 ve kaynak girişleri | Görsel diyalog, ayrı görev/karar bağları WORK ile korundu; I01/I02 kamu raporu kaydı U08-A'ya açık kaldı. |
| S01 §2/§7 ve S04 §5 | Support/dağıtım ve version-helper bağları karşılandı; aynı sentez yeni bağımsız destek olmadı. |

U07'nin açıklanmış kullanımlarında bu kontrolde somut açık aktarım eksiği kalmadı. B6-T10'da S05/S06 ve U08-A/B/C de tam okundu; aşağıdaki final kontrol 52 benzersiz package dosyasının tamamını kapsar.

## 6. Pilot bağı ve yorum etkisi

P2-T4/T5'in görünür SP122–SP149/SP175–SP176 ve ilgili SP28 kullanımları kaynakla karşılaştırıldı. Kimlikler korundu; farklı nesne ve olaylar alt adreslerle ayrıldı. Ek occupied-port/explicit-token, stop-marker/watchdog ve lexical tmp koşulları önceki kısaltmanın kapsamını belirginleştirir. Önceki ana açıklamayı tersine çeviren yeni anlam saptanmadı.

Korunan ayrımlar: tool teklifine kabul/tasarım onayı; erişim/insan yetkisi; payload/dedicated dosya/genel log; son tıklama/final küme; endpoint reuse/session içeriği; retained HTML/karar geçmişi; source ref/assembly input/artifact/active procedure; archive/sync; check/audit/bump; failure/rollback; render/workflow execution; şablon varlığı/rolün çağrılması. S77 başlığının daha güçlü test gövdesini gizlememesi ve version helper'ın gerçek koruyucu kontrolleri olumlu malzeme olarak kaldı.

Yeni parça source/pilot aktarımıdır; verbatim arşiv, bağımsız doğrulama veya güncel ürün testi değildir. Somut atlama sonradan bulunursa ilgili kayıt açılır. Kaynağın soru veya genel tanım eksikliği, bu aşamayı sınırsız kavram araştırmasına çeviremez.

## 7. Yayın, delta ve korunmuş kayıtlar

B6-T9 yazma kapsamı: yeni TERMS-RUNTIME-DISTRIBUTION.md; mevcut TERMS.md, bu READING.md ve global concepts/STATE.md. Önceki dört kullanım parçası, global INDEX, METHOD/PLAN/SCOPE/CHARTER/ORIGIN/SETUP-REVIEW, CMH, özgün studies ve agent-control değişmez. Yeni parça ana TERMS'ten bulunur; global INDEX zaten bu girişe bağlıdır. Yeni branch veya duplicate study/META/CATALOG kaydı oluşturulmaz.

Yeni parça **ce70c9c0e2028818b1cbc6c10e559aab5a552e8c** commit'inden 1–55/56–105/106–EOF tamamen geri okundu. Ana TERMS güncellemesi **49412fb2291e3150c8f93c3459de7a2b04031ee6**. Bu dosya kendi henüz bilinmeyen commit'ini veya yapılmamış son kontrolü iddia etmez. Yayımlanan dosyalar son geri okuma/compare ile kontrol edilir.

[B6-T8 global kapanışı](https://github.com/batuhanozgun/agentic-os-search/blob/83771eca414eeb90e2c565d1dd00c11fe0e47a01/concepts/STATE.md) önceki yayın ve ECC/katalog deltalarını; agentmemory/claude-swap/cli-continues META eklerinin bekleyen kapsam hesabını korur. T9 başlangıcında ponytail/META eklenmişti; bu tur içeriği okunmadı veya paket sınıfı/olgunluğu tahmin edilmedi. S1 başlangıç sayısı güncel bütün evrenin toplamı değildir. Dört ek yol, seri kapsam hesabı/B7 öncesinde gerçek ağaç ve kaynaklarıyla ele alınır; burada tamamlanmış concepts paketleri sayılmaz.

## 8. B6-T10 final kaynak, pilot ve delta kontrolü

**Benzersiz dosya hesabı:** 19 kök kayıt + 11 notes + 6 syntheses + 16 evidence = **52**. Önceki tabloda S05 satırının iki kez görünmesi bu tur düzeltildi; hiçbir gerçek kaynak dosyası kayıp değildi. Envanterdeki bütün benzersiz yollar T5–T10 tur kimliği taşıyor.

**Kalıcı kullanım hesabı:** ana TERMS/SP01 ve araştırma/kanıt dili; ENTRY; WORK; VERIFICATION-DELIVERY; EVOLUTION-EVALUATION; RUNTIME-DISTRIBUTION; SYSTEM-PROJECTION birlikte pilotta karşılaşılan bütün kullanım gruplarını ve kaynakta sonradan belirginleşen yerel ayrımları kapsar. Tarihsel SP150–SP160 aralığının birebir satır metni recover edilemedi; bunun yerine METHOD §8 uyarınca source-controlled U08-R regeneration kullanıldı. Bu durum kapanışta gizlenmedi.

**Kaynak taraflı challenge:** S05/S06 ve U08-A/B/C, daha önceki kayıtların route/actor/object/version nitelemelerini tersine çeviren yeni bir kaynak bulmadı. U08-C'nin closure challenge'ı route-specific parallel/SDD ayrımlarını ve compression riskini koruyor; açık Q13/Q20/Q24/Q47 ve empirical limits çözülmüş sayılmıyor. Kaynakta belirsizlik bırakılması, dosyanın okunmamış olması değildir.

**Delta:** B6-T10 başlangıcında research/studies/superpowers package tree'sinin pinned P2 ref ile current main arasında değişmediği kontrol edildi. Concepts yazımları özgün study'yi değiştirmedi. Sonradan somut source delta veya atlanmış kullanım bulunursa ilgili kayıt yeniden açılabilir.

Bu kontroller aynı assistant'ın kaynak/aktarım kontrolüdür; bağımsız verification, sıfır-atlama garantisi veya ürün doğruluğu sertifikası değildir. Buna rağmen METHOD §5/§7/§8'in mevcut kapanış ölçütleri bakımından açık somut aktarım borcu kalmadı.

## 9. Yayın ve korunmuş kayıtlar

B6-T10 yazma kapsamı: yeni `TERMS-SYSTEM-PROJECTION.md`; mevcut `TERMS.md`, bu `READING.md` ve global `concepts/STATE.md`. Önceki beş kullanım parçası, global INDEX, METHOD/PLAN/SCOPE/CHARTER/ORIGIN/SETUP-REVIEW, CMH, özgün studies, Foundation ve agent-control bu iş adına değişmez.

SYSTEM-PROJECTION ilk commit'i **2b15badd54eaa0928d18b361f684a80eaf122b1d**; ana TERMS kapanış güncellemesi **6b3bc091d8c110f73f20c05ec8fd7ba0af422249**. Bu READING kendi henüz bilinmeyen commit'ini uydurmaz. Yayından sonra tam geri okuma, gerçek diff kapsamı ve main'e yerleşim ayrıca doğrulanır.

S1 sonrası bekleyen kapsam deltaları (agentmemory, claude-swap, cli-continues, ponytail ve sonradan eklenecek diğer yollar) Superpowers kapanışıyla çözülmüş sayılmaz; bütün seri ve B7 öncesinde gerçek kaynak ağaçlarıyla hesaba katılır.

## 10. Devralma

AGENT/tetiklenen protokoller → concepts/INDEX'in zorunlu okumaları → güncel global STATE. Superpowers'a yeniden girilecekse bu READING → TERMS ve altı bağlı parça birlikte okunur; paket **durable-complete** olarak devralınır, yeniden araştırılmaz.

Normal seri devam **research/studies/ai-knowledge-strategies/** paketidir. Önce o paketin güncel ağaç/META/STATE/INDEX preflight'ı yapılır; ardından kendi bağlamında kullanım çıkarımı başlar. B7/B8 henüz yetkili sonraki aşama değildir.
