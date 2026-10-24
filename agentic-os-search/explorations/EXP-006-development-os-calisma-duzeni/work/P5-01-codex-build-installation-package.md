> **29 Eylül 2026 — tarihsel P5 S00–S12 teslim kaydı; kurulum için uygulanmaz.** Aşağıdaki S00 başlangıcı, Codex runtime ve açık sağlayıcı/hesap kapıları eski pakete aittir. [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri) sonrasında DevOS'un kurucusu ve çalışma ortamı Claude Code cloud'dur; tek geçerli plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır (devir sürümü 2.1).
>
> Bu kayıttaki **74 sayfalık S00–S12 paketi**, konuşmada erişilebilen **40 sayfalık K00–K15 paketinden farklıdır**. Aşağıdaki dosya/QA beyanları tarihsel teslim kaydıdır; bu statü notu S paketinin bulunduğu, hash'inin yeniden doğrulandığı veya arşive eklendiği anlamına gelmez. Gerçek erişim [A3 arşiv işinde](../../../REPOSITORY-TRANSITION.md) ayrı doğrulanır; kayıt veya hash'ten eksik paket üretilmez. Claude Code ve DevOS bu depoyu yalnız okur. Özgün kullanıcı sözleri ve metnin tamamı aşağıda korunur.

---

# P5-01 — Codex inşa ve kurulum paketi

**28 Eylül 2026 / release P5-1.0.0 / REHBER VE KAYNAK PAKETİ HAZIR / ACTUAL İNŞA BAŞLAMADI.**
**Üst iş:** [WORK/P5](../WORK.md). **Başlangıç ref:** `fdd44fdb849b49bd882950b52297cd63de40adfc`.

Bu kayıt paket provenance'ı ve devir yüzeyidir; tam rehber, production kod veya hedef kabulü yerine geçmez.

## 1. Kullanıcı yetkisi

P4 raporu ve P5→Codex uygulama akışı konuşulduktan sonra kullanıcı:

> Anladım. Zaten öyle olsun. Yine Codex çalışsın. SOUL yapısı gereyi Codex ya da Claude Code fark etmeksizin çalışır ama DevOS Codex'te çalışır.
>
> Bu durumda P5'e geçebilirsin. Ama azla yetinen bir karakterde çalışmanı istemiyorum. Kesinlikle yüksek kalitede iş yapmalısın. PDF'i ya da başka dokümanlara ihtiyacın varsa söyle.

Bu görünür kullanıcı mesajı D029'dur. Codex hem builder hem DevOS runtime olarak ele alındı. SOUL'un provider bağımsızlığı ürün hedefi olarak korundu, çalıştırılmış sonuç sayılmadı. Yetki P5 inşa şartnamesini/rehberini hazırlamaktır; gerçek repo/hizmet/maliyet/veri/yayın scope'u olmadan dış kurulum yapılmadı. İlk gerçek SOUL backlog'u seçilmedi.

## 2. Kaynak ve P4 devri

P4 v4'ün 1020 satırlık tam Markdown gövdesi; EXP-006 STATE/INDEX/HANDOFF/WORK/DECISIONS ve P4-05 tam okundu. Gerçek v4 ZIP/Markdown/PDF kimlikleri ve iç 95 manifest girdisi kontrol edildi. Sözleşmeler ve mevcut kanıt sınırları P5'in kaynak bağını kurdu. P4 v4'ün gövdeleri değiştirilmeden paket provenance'ında korundu; önceki 53 test bu P5 turunda yeniden koşturulmadı.

Studies yeniden kullanımı seçicidir: context-memory-harness-engineering META ve cross-layer synthesis'in 250–390 satırları; anthropic-ai-native-sdlc-playbook META, özellikle guidance/enforcement ayrımı ve configuration-as-test-target. Tüm Foundation/studies korpusu veya eski external-target ürünler yeniden araştırılmış sayılmaz. Bu kaynaklar P5'i sabit bir Claude workflow'una dönüştürmedi.

Güncel resmî OpenAI Agents API overview/architecture, multi-agent/function tools, configuration, hosted/security/lifecycle, sessions/webhooks/files, plugin/skills ve Codex AGENTS kaynakları; PostgreSQL transaction/RLS/locking; GitHub refs/merge/protection kaynakları gereken kapsamda okundu. Exact kaynak/URL/okuma sınırı pakette `provenance/` ve docs'tadır. Son yeniden açmada configuration/files sayfalarının cache-miss vermesi önceki seçici okumayı yeni tam okuma yapmaz; S02 target doğrulamasını kaldırmaz.

P4 v4 §26.1'in eski `DevOS_v3.md` current-file ifadesi gerçek v4 gövdesiyle uyumsuz tarihsel kalıntıdır; P5 doküman fark kaydında belirtildi, orijinal kaynak sessizce düzeltilmedi. Chat'te örneklenen bir dizin şeması veya R01–R09 benzeri ortak kontrol, P4'te zaten kesin kabul edilmiş tasarım sayılmadı.

## 3. P5'in somut teslimi

Paket 13 dependency-bound inşa aşamasını (S00–S12), her aşamanın çıktısını, giriş şartını, olumlu/olumsuz kanıtını, durma ve geri alma yolunu taşır. Ayrıntılı phase'ler:

| ID | Teslim/qualification |
|---|---|
| S00 | Kaynak, target ve yetkiyi sabitle |
| S01 | Tekrar üretilebilir inşa alanı |
| S02 | Gerçek Codex bağlama deneyi |
| S03 | PostgreSQL ve kalıcı kayıt temeli |
| S04 | Yetkili komut kapısı ve fencing |
| S05 | İlişkiler ve güvenilir sorgular |
| S06 | Yönerge, rol ve yöntem release'i |
| S07 | Kaynak, memory ve context yolu |
| S08 | Dayanıklı K1/K2 orkestrasyonu |
| S09 | Üretim, review ve bütün ürün |
| S10 | Korunan uzak yayın |
| S11 | Restore, işletim ve kapasite |
| S12 | Birleşik prova ve ayrı P6 planına devir |

18 DR rol profili P4 §29 sözleşmelerine bağlı yazıldı. 6 ortak P5 protokolü ve 7 method/skill metni; mandatory common/role bağlama, Work context ve optional method seçimiyle ayrıldı. Passive `builder/AGENTS.md`, mevcut target kontrolünü otomatik ezmez; Research agent-control değişmedi.

30 mantıksal veri ailesi, 33 application command ve 33-varyant envelope şeması bulunur. Bu veri modeli çalıştırılmış PostgreSQL migration'ı, şema geçerliliği de authentication/authorization değildir. 67 target senaryosu ve stage criterion hash'leri makinece izlenebilir. Gerçek app/migration/native test kodunu builder ilgili aşamada yazıp targetta çalıştıracaktır.

## 4. Yeni teknik seçimler ve gerekçeleri

**Runtime sınırı:** Resmî multi-agent belgesi native subagent'ların application function tools kullanamadığını; MCP tools, credentials ve allowed-tool kapsamını miras aldığını belirtir. P5 bu sınır nedeniyle farklı yetki, application function erişimi veya gerekli bilgi izolasyonu isteyen rolleri ayrı root session/uygun environment'a bağlar. Native child yalnız aynı güven sınırındaki helper işi taşır. Bu statü bağımsız security principal veya epistemik reviewer yaratmaz. Actual S02/H-AUTH gerekir. Kaynak: https://developers.openai.com/api/docs/guides/agents-api/multi-agent .

**Yönerge/config:** Ortak protokol + rol sözleşmesi + Work context + gerektiğinde method release bileşimi artık P5'te yazılı ve doğrulama nesnesidir. Skill'in diskte bulunması yüklendiğini, yüklenmesi kullanıldığını veya faydalı olduğunu göstermez. Agent/session configuration değişikliği eski oturuma retroaktif uygulanmış sayılmaz; ilgili yeni session ve davranış regresyonu gerekir.

**Referans altyapı:** Typed application/control plane + PostgreSQL live state + private body store + ayrı protected publisher + restored DB'den bağımsız authority fence + managed Codex harness adapter. Bütün uygulamayı veya policy truth'unu worker credential'ına bırakmaz. Alt teknoloji/host/provider seçimleri C kapıları ve actual tests ile sabitlenir. Supabase seçilmiş değildir.

**Yayın ve recovery:** Local Git CAS, GitHub remote base-CAS garantisi olarak taşınmaz. GitHub merge `sha` kontrolü head'e aittir; refs force=false fast-forward kontrolü genel expected-old-CAS değildir. Base değişimi, bypass, unknown effect, eski credential ve actual remote readback S10/S11'de sınanır. Event sıra sayısı global commit watermark sayılmaz. Restore sadece DB açılması değildir; eski effect yolları kapanır, yeni yetkili iş gerçekten başlayabilir.

**Builder/runtime/ürün:** Codex uygulaması builder veya operatör yüzeyi olabilir; programatik API runtime ayrı erişim, veri işleme ve bütçe koşulu taşır. SOUL portable domain sözleşmeleri Codex session kimliği veya native tool tiplerine zorla eşitlenmez. Bu hazırlık farklı sağlayıcıda SOUL çalıştırmış değildir.

Bu seçimler P5 technical specification'dır; yeni owner tercihi veya P4'te zaten kabul edilmiş ayrıntı değildir. Kanıt değiştirdiğinde ilgili karar/phase yeniden açılır; current Codex kullanıcı kararı sessizce Claude'a çevrilmez.

## 5. Yerel araçlar, gerçek test ve sınırlar

`verify_package.py` inventory/hash/path kontrolünü; `check_blueprint.py` stage DAG, criterion, role/method/policy/schema ve P4/F/H bağlarının yapısal tutarlılığını; `evidence_lint.py` beklenen pinned stage/target/implementation/config/epoch/criterion/prerequisite ve ham kanıt kimliklerini kontrol eder.

Evidence linter **en fazla `ELIGIBLE_FOR_REVIEW`** döndürür. Owner kabulü, gerçek runner kimliği, logun olgusal doğruluğu, bağımsız değerlendirme veya semantic adequacy üretmez. Expected pin'ler raporun kendisinden değil güvenilir çağırandan gelmelidir. Hash'leri kendi yazdığı rapora uydurmak test başarısı sayılmaz. NOT_RUN/boş template reddedilir; yanlış target/criterion/case/raw evidence reddi test edilir.

**Gerçek koşu:** `python -m unittest discover -s tests -v` altında 50 adlandırılmış paket-araç testi geçti. 33 komut-varyant alt sınaması target deneyi olarak ayrıca sayılmadı. Yapısal blueprint denetimi geçti. Kod/test/rehber aynı assistant'ın üretimidir; bağımsız güvence yoktur. Ham çıktı, komut, exit code, ortam ve dosya hash'leri `qa/execution-manifest.json` ve `qa/package-tests.txt` içindedir.

**Hedef koşuları:** 67 senaryonun tamamı NOT_RUN; gerçek Codex session/child/function, PostgreSQL migration/ACL/locking, Supabase, protected remote Git, authority fence, restore, gerçek uzun ürün ve bilişsel yeterlik test edilmedi. Yerel ortamda psql/PostgreSQL/Docker veya actual native servis koşusu varmış gibi davranılmadı. P4 tarihsel testleri korunmuş kaynaktır, bu tur yeni sonuç değildir.

İlk schema/fixture test düzeltmeleri ve PDF'de cover satırsonu/code-box padding düzeltmeleri `qa/history/` ve `qa/development-notes.md` içinde korunur. Hedef geçiş ölçütleri testler yeşil olsun diye gevşetilmedi.

## 6. Dosyalar ve kimlikler

| Dosya | Byte | SHA-256 |
|---|---:|---|
| `EXP-006_P5_Codex_Kurulum_Rehberi.pdf` | 346149 | `23869514aed4cac88ab135874d7d899d03ba76ddf56668bbb30d4b251d8b8d79` |
| `EXP-006_P5_Codex_Kurulum_Rehberi.md` | 199205 | `2208394f898037305e10939c400a6bfbffae0da4461514e76226ddf62d9aa5f9` |
| `EXP-006_P5_Codex_Insa_ve_Kurulum_Paketi.zip` | 4209549 | `40aee0e270e683b12ee7316406dfb2254a7bf64d8aeffcf215dcd6b54b62c36b` |
| `EXP-006_P5_CODEX_START.md` | 3326 | `a4b9e42158780d98a3fdbfd4ab7000c68047ca9b15837612ce30f408df43ff00` |

**PDF:** 74 sayfa, kaynakta 22763 kelime; 1345/1345 beklenen metin birimi extraction'da bulundu. 228 bookmark, 60 internal TOC bağlantısı ve 28 external link sayıldı. Out-of-page text, replacement/null glif veya geçersiz internal link bulunmadı. External link availability veya tagged-PDF accessibility bu QA'nın kanıtı değildir.

**Görsel kontrol:** Bütün 74 sayfa contact sayfalarında; 1, 6, 9, 22, 29, 37, 47, 61, 73 ayrıntılı incelendi. Final Poppler render önceki incelenmiş görüntülerle karşılaştırıldı: değişen 1/8/22 yeniden açıldı, kalan 71 sayfa piksel eşitti. Cover ve code-background taşması giderildi. Görsel QA genel mimari doğruluk değildir.

**Paket:** 125 dosya = 124 MANIFEST girdisi + MANIFEST. CRC, güvenli yeniden açma ve 124 üyenin hash/boyutu eşleşti. İç içe kaynak arşivlerinde yazı tipi dosyası gönderilmedi. External `EXP-006_P5_Teslim_Kimligi.json` final kimlik/yayın kaydıdır; ZIP'nin kendi hash'i içine dairesel yazılmaz.

**Erişim sınırı:** Tam PDF/Markdown/125 dosyalık paket bu konuşma teslimindedir, repository'ye tamamı yüklenmedi. Repository current kayıtları ve [CODEX_START](p5/CODEX_START.md) kopyasını taşır. Ayrıntılı yeni oturum/target inşası için gerçek ZIP veya hash-eşit gövdeler gerekir; summary/hash paket yerine geçmez. Exact v4 kaynaklar ZIP'nin provenance alanındadır.

## 7. Açık owner/target kapıları

C01 target repository/yazma sınırı; C02 API access/veri koşulu; C03 PG/body sağlayıcısı ve bölge; C04 application/publisher/fence barındırma; C05 bütçe/concurrency; C06 publication target/identity; C07 RPO/RTO/retention; C08 kabul owner/review yolu. Bunlar halen unresolved template girdileridir.

Builder teknik gerçekleri araştırır, seçenek ve gerekçeyi getirir. Kullanıcı teknik oracle değil, değer/yetki/bütçe/veri/kabul owner'ıdır. C01 safe S01'i açabilirken başka aşamalar kendi material C kapılarını bekler; bütün soruları gereksiz yere tek ilk ankette doldurmak veya eksik yetkiyi varsaymak doğru değildir. Secret/key'ler sohbetten istenmez. Güvenli bağlı setup/secret yolu actual ihtiyaçta kullanılır.

## 8. Devam ve kapanış sınırı

**Mevcut teslim:** P5 Codex build specification/runbook, pasif yönerge kaynakları, sözleşmeler, test/kanıt programı ve yerel QA araçları hazır. **Actual DevOS kurulumu başlamadı; P6 kabulü yoktur.**

**Sonraki anlamlı iş:** Codex'e gerçek ZIP ve başlangıç metni verildiğinde S00 kaynak/target/authority preflight. Paket rehberi eksik target'ı tahmin etmez; Research repo varsayılan kurulum hedefi olmaz. Geçerli kurulum yetkisiyle S01–S12 ilerler. S12 sınırlı commissioning ve P6 planını teslim eder, SOUL'un ilk gerçek backlog'unu seçmez.

P5 tasarımının kullanıcı değerlendirmesi yeni revizyon gerektirebilir. Eski P4'ün “P5 rehberi sıradaki” current'ı artık tarihsel kalır. Research agent-control, studies/Foundations, concepts ve başka EXP'ler değişmez. Bu kaydın uzak yayın/readback başarısı ayrı tool işlemiyle doğrulanır; önceden olmuş gibi yazılmaz.
