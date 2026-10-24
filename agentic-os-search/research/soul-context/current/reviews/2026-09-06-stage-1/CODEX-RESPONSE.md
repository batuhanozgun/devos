> **30 Eylül 2026 — tarihsel Codex yanıtı; güncel öneri veya görev değildir.** Aşağıdaki metin, 6 Eylül Stage-1 görevi için kullanıcının aktardığı tasarım cevabıdır. Üç yüzeyli başlangıç, eski hedef depolar ve “sonraki iş” önerileri bugünkü kurucuya talimat olmaz. Okuma ve işlem beyanları kaynak yanıtın beyanları olarak korunur; bu bakımda yeniden doğrulanmış değildir.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. [Özgün byte-sadık yanıt](https://github.com/batuhanozgun/agentic-os-search/blob/9620dfdeda71f25580f6945c2bb3a11c19b78703/research/soul-context/current/reviews/2026-09-06-stage-1/CODEX-RESPONSE.md) ayırıcıdan sonra aynen korunur; [REVIEW](REVIEW.md)'daki eski satır/hash kimlikleri yeni not hariç bu gövdeye aittir.

---

**Önerim, üç belge yüzeyiyle başlayan, tek yazıcının yürüttüğü ve sonuçları iddiaya uygun kanıtla değerlendiren küçük bir Development OS.** İlk başarı ölçütü, yeni oturumun kuralları anlatabilmesi değil; önceki sohbeti bilmeden yetkili, anlamlı bir işi tamamlayıp kullanılabilir devir bırakması olmalı.

`DEVOS-BOOTSTRAP-S1-2026-09-06` görev dosyasını belirtilen commit’ten **tam okudum**. İnceleme başlangıcında araştırma reposunun güncel `main` commit’i de `bfe58e7bde8ec9ef58e46fab5c04a7720e207407` idi. Altı zorunlu giriş kaynağı tam okundu; ardından ilgili Foundation ve çalışma paketlerinde seçici derinleşme yapıldı. Yerel Git ağacında yalnız `.gitkeep` bulunması kayıtlı başlangıç durumuyla tutarlı. [Görev dosyası](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-context/current/briefs/CODEX-STAGE-1-BOOTSTRAP-DESIGN.md)

**Bu, kabul veya uygulama sonucu değil, gerekçeli tasarım önerisidir.**

Development OS’nin üstleneceği iş, amacı sınırlı çalışmaya dönüştürmek; gerekli bilgiyi bulmak; yetki içindeki teknik kararları almak; sonucu değerlendirmek ve sürekliliği korumaktır. SOUL’un ürün mimarisini belirlemek, araştırmayı otomatik gereksinime dönüştürmek veya gözetimsiz çalışmak başlangıç sorumlulukları değildir.

Çerçeveye iki itirazım var. Birincisi, “önce Development OS” yaklaşımı, ilk faydalı işten önce tamamlanması gereken büyük bir hazırlık projesine dönüşmemeli. İkincisi, güvenilirlik her işin ayrı araştırmacı, tasarımcı, üretici, eleştirmen ve entegratörden geçirilmesiyle kurulamaz. Ayrımın gerekliliğini değişikliğin etkisi ve doğrulama ihtiyacı belirlemeli.

Kaynaklar; kalıcılık, bağlama yüklenme, doğru kullanım, teknik yaptırım ve kabulün farklı şeyler olduğunu destekliyor. **Benim çıkarımım**, başlangıçta bu ayrımları görünür tutmanın, bunların her biri için ayrı alt sistem kurmaktan daha değerli olduğudur. Context/Memory/Harness araştırması da bu kavramları zorunlu yazılım katmanları olarak sunmuyor. [Araştırma sentezi](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md)

Önerdiğim kalıcı başlangıç yapısı aşağıdaki kadar küçük olabilir. **Bunlar önerilen dosyalardır; oluşturulmadılar.**

| YüzeyTaşıyacağı bilgi ve ihtiyaçDaha basit alternatif; çıkarılırsa kayıp |                                                                                                                                        |                                                                                                                               |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `AGENTS.md`                                                              | Kısa çalışma sözleşmesi: kaynaklara erişim sırası, yetki sınırları, iş seçimi, doğrulama ve durma ilkeleri. `STATE.md`’ye yönlendirir. | Her oturuma başlangıç mesajı vermek. Çıkarılırsa süreklilik tekrar kullanıcıya veya uygulamadaki gizli ayarlara bağımlı olur. |
| `STATE.md`                                                               | Tek güncel proje kontrol noktası: amaç, kabul edilmiş çalışma sözleşmesine referans, aktif iş ve sıradaki yetkili iş bağlantıları.     | Son iş dosyasını veya Git geçmişini aramak. Çıkarılırsa “şimdi hangi iş geçerli?” sorusunun cevabı belirsizleşir.             |
| `work/<iş-kimliği>.md`                                                   | İşin amacı, sınırı, ölçütleri, kaynakları, kararları, kanıtı ve devam noktası birlikte bulunur.                                        | Her şeyi `STATE.md` içine yazmak. Çıkarılırsa güncel yönlendirme ile büyüyen çalışma geçmişi birbirine karışır.               |

İş kaydında zorunlu içerik kısa tutulmalı: **beklenen sonuç; yetki ve izinli etkiler; hedef/kaynak sürümleri; gözlenebilir kabul ölçütleri; mevcut sonuç ve ilk devam adımı**. Alternatifler, ayrıntılı karar gerekçesi ve kurtarma notları yalnız ihtiyaç olduğunda eklenmeli. Küçük bir düzeltme için yeni belge açmak yerine mevcut iş kaydına kısa kayıt yeterli olabilir.

Ayrı karar defteri, protokol klasörü, rol kataloğu, öğrenilmiş hafıza deposu veya iş akışı motoru önermiyorum. Kararlar başlangıçta doğdukları işte yaşar; tekrar kullanılacak kararlar `STATE.md` üzerinden bağlantılanır.

Burada önemli olan **her bilginin tek yetkili evi olmasıdır**:

- Araştırma bulgusu `agentic-os-search` içinde kalır.
- Development OS’nin güncel işi `soul-development-os` içinde yaşar.
- Ürün adayları, kabul edilmiş ürün sürümleri ve ürünün gözlenen davranışı gelecekte `soul-production` bağlamında ayrı değerlendirilir.
- `STATE.md`, iş dosyalarındaki sonuçları ikinci kez yönetmez; onlara yönlendirir.

Araştırma referansı; repository, dosya yolu, commit veya blob SHA, kullanılan bölüm ve tasarıma etkisini taşımalı. İlk sürümde araştırma korpusunu kopyalamaya gerek yok. Daha sonra erişim nedeniyle snapshot gerekirse kaynağı, sürümü ve **türetilmiş kopya** statüsü korunmalı. Eski olması, sabit bir araştırma kaynağını kendiliğinden geçersiz yapmaz; güncel kabiliyet veya durum iddiası için kullanılması yeniden kontrol gerektirebilir.

**Çalışma yetkisi, aday dosyanın kendisini “kabul edildi” diye işaretlemesinden doğmamalı.** İlk çalışma sözleşmesinin yetki dayanağı, kullanıcının belirli kapsam ve sürüme ilişkin kabulüdür. Sonraki oturum, yürürlükteki sözleşmeyle aday ilerleme kaydını ayırmalıdır. Aday branch’te değiştirilmiş `STATE.md`, o adayın kendi yetkisini genişletemez.

Aktör; verilen amacı sorgulamadan uygulayan bir yazıcı olmamalı. Kullanıcının amacı ve yetki kararı belirleyicidir; fakat “bu zaten çalışıyor” gibi betimleyici öncüller gözlemle sınanır. Yanlış öncül bulunursa kanıt gösterilir, hedefe hizmet eden alternatif önerilir. Teknik yöntem yetki içinde değiştirilebilir; amaç, kapsam, bütçe veya başarı ölçütü sessizce değiştirilemez.

İş seçimi için sabit bir aşamalar zinciri yerine şu kısa karar mantığını öneriyorum:

| Gözlenen durumUygun hareket                       |                                                               |
| ------------------------------------------------- | ------------------------------------------------------------- |
| Kararı değiştirebilecek bilgi eksik               | İlgili kaynağa kadar araştır.                                 |
| Amaç açık; yöntemler arasında önemli fark var     | Alternatifleri değerlendir ve yetki içindeki seçimi yap.      |
| İş yetkili, sınırları ve ölçütleri yeterince açık | Uygula.                                                       |
| Çıktı var; sonucu destekleyen kanıt eksik         | Doğrula.                                                      |
| Yetki yetersiz veya etkisi belirsiz bir işlem var | Bağımlı eylemi durdur; etkilenmeyen yetkili çalışmayı sürdür. |

Her bulgu otomatik repair işi olmaz. Önce bulgunun mevcut ölçütü ihlal edip etmediği ve sıradaki kararı değiştirip değiştirmediği değerlendirilir. Sonuç; mevcut iş içinde düzeltme, ek araştırma, sadeleştirme, sonraya bırakma veya gerekçeli durma olabilir.

Varsayılan olarak **tek yazıcı** yeterlidir. Salt okunur araştırma ve karşı inceleme gerektiğinde paralelleştirilebilir. İkinci yazıcı ancak gerçek zaman kazancı veya izolasyon ihtiyacı varsa eklenir; o zaman çalışma alanı ve entegrasyon sorumluluğu açıkça belirlenir. Böylece ortak dosyalarda yarışmayı önlemek için başlangıçta ayrı kilit hizmeti gerekmeyebilir.

Doğrulama da orantılı olmalı. Küçük bir belge düzeltmesinde üreticinin doğrudan kaynak karşılaştırması yeterli olabilir. Yetkiyi, kabul ölçütünü, çalışma davranışını veya önemli doğrulama mekanizmasını değiştiren işte üreticinin özeti yeterli değildir.

Bu ikinci durumda önerdiğim kontrol şudur:

1. Yürürlükteki kabul edilmiş temel **B**, aday değişiklik **C**’den önce belirlenir.
2. C, B’deki yetki ve ölçütlere göre değerlendirilir.
3. Doğrulayıcı, C’nin değiştirdiği talimatlarla başlamaz; B veya ayrıca verilmiş sabit görev kapsamı altında C’yi inceler.
4. Doğrudan kaynaklara ve çalıştırılan kontrollerin sonuçlarına erişir. Üreticinin açıklamasını tekrar etmek doğrulama sayılmaz.
5. C’nin önerdiği yeni ölçütler, ayrıca yetkili biçimde kabul edilmeden C’nin kabulünü belirleyemez.

Örneğin B bir kontrolü zorunlu tutarken C o kontrolü silip kendine PASS yazıyorsa, C’nin yeni denetleyicisini çalıştırmak yeterli değildir. Bu ayrım Foundation’ın kriter, değerlendirme, karar ve yetki ilişkilerinden çıkardığım tasarım sonucudur. [Değerlendirme ve geçerlilik](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-foundations/05_relation-control-composition/composite-standing/S3-EVALUATION-UNCERTAINTY-INVALIDATION.md), [Yetki ve denetim yolları](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-foundations/05_relation-control-composition/control-constraint/K3-MODALITY-GATE-AUTHORITY-PATH-BYPASS.md)

**Bu düzenin yazılı olması teknik engelleme değildir.** Gerçek yaptırım ancak etkin platform izinleri ve koruma mekanizmalarıyla sağlanır. Codex sandbox sınırları, approval davranışı ve GitHub dal koruması ayrı mekanizmalardır; auto-review bir ürün doğruluk testi değildir. GitHub korumalarının kullanılabilirliği, etkinliği ve bypass kapsamı ayrıca doğrulanmalıdır. [Codex güvenlik modeli](https://learn.chatgpt.com/docs/agent-approvals-security), [Auto-review](https://learn.chatgpt.com/docs/sandboxing/auto-review), [GitHub dal koruması](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

Kanıt kaydı şu ayrımları korumalı: **dosya değişti, commit oluştu, PR açıldı, değişiklik birleştirildi, yeni talimat yüklendi ve beklenen davranış gözlendi**. Bunlar birbirinin yerine geçmez. Kanıt ilgili hedef sürümünü, kullanılan ölçütü, yöntemi ve sınırını belirtmeli; çalıştırılmamış kontrol başarılı gösterilmemeli. Yalnız kayıt ekleyen bir commit nedeniyle bütün testleri yeniden koşmak da gerekmez: değişikliğin hangi kanıtı etkilediği açıklanmalıdır.

Gerçek alternatifleri karşılaştırdığımda seçimim şöyle:

| AlternatifDeğerlendirme                                |                                                                                                                                    |
| ------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| Tek büyük başlangıç mesajı veya `AGENTS.md`            | Kurulumu kolay; güncel durum, tarihçe ve kurallar büyüdükçe birbirine karışır.                                                     |
| **Üç belge yüzeyi + mevcut Git/Codex araçları**        | En düşük ek işletim yüküyle sürümlü süreklilik ve incelenebilir çalışma sağlar. **Seçimim bu.**                                    |
| GitHub Issues/Projects merkezli çalışma                | Çok katılımcılı iş takibinde yararlı olabilir; başlangıçta ikinci durum otoritesi ve senkronizasyon ihtiyacı yaratır. Ertelenmeli. |
| Özel SDK, hafıza deposu ve sürekli çalışan orkestratör | Daha geniş otomasyon ihtiyacında değerlendirilebilir; mevcut başlangıç problemini çözmek için gereğinden büyük.                    |

Küçük giriş haritası ve sürümlü kayıt yaklaşımının OpenAI’nin mühendislik deneyiminde de karşılığı var. Bu bir destekleyici örnek; bizim tasarımımızın çalıştığını kanıtlamaz. Anthropic’in uzun görev deneyimi de oturumlar arasında kalıcı ilerleme ve doğrudan davranış doğrulamasının önemini gösteriyor. [OpenAI deneyimi](https://openai.com/index/harness-engineering/), [Anthropic deneyimi](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

**Sonraki sınırlı uygulama işi**, bu üç yüzeyi, başlangıç yetki dayanağını ve aşağıdaki kabul senaryolarını içeren bir bootstrap adayı hazırlamak olmalı. Yeni framework, paket, servis veya scheduler gerekmiyor. Belgeler ilk oluşturulduklarında adaydır; kendi kabul kayıtlarını üreterek yürürlüğe giremezler.

Ardından yeni oturumda yapılacak ilk anlamlı iş olarak **küçük, bağımlılıksız ve salt okunur bir çalışma bağlamı denetleyicisi** öneriyorum. Bu projede yanlış çalışma kopyasına bağlanma zaten yaşandığı için somut bir ihtiyacı karşılar. Denetleyici çalışma dizini, Git kökü/origin, aktif iş bağlantısı ve gerekli referansların bulunabilirliğini kontrol eder. Çıktısı gözlemler ve eksiklerdir; anlamsal doğruluğu, yetkiyi veya bütün OS’nin hazır olduğunu sertifikalandırmaz.

Bu araç ilk üç belgenin önkoşulu değildir. Onun geliştirilmesi, Development OS’nin gerçek bir teknik işi yürütme ve devretme deneyi olur.

Aşağıdaki testler **bu turda uygulanmadı**:

| SenaryoBaşarı sayılacak gözlem      |                                                                                                                                                                               |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Yeni oturum, önceki sohbet yok      | Kısa bir devam isteğinden doğru giriş ve aktif işe ulaşır; yetki sınırını doğru uygular. Sadece kuralları tekrar etmesi yeterli değildir.                                     |
| Normal anlamlı iş                   | Yetkilendirilmiş denetleyiciyi geliştirir; doğru ve yanlış çalışma bağlamını ayırır; ilgili kontrolleri gerçekten çalıştırır ve başka oturumun kullanabileceği devir bırakır. |
| Eksik giriş veya kaynak             | Eksikliği açıkça bildirir; görev tanımını uydurmaz. Bağımsız ve yetkili kalan işi sürdürebilir.                                                                               |
| Yanlış kullanıcı öncülü             | Örneğin “PR açıldı, sonuç tamam” iddiasını gözlenen durum ve kanıtla karşılaştırır; farkı gösterip uygun sonraki işi seçer.                                                   |
| Bayat kanıt                         | Değişmiş hedef veya ölçüt için eski PASS’i otomatik kullanmaz; ilgili kanıtı yeniler veya belirsizliği korur.                                                                 |
| İşlem sonrası, kayıt öncesi kesinti | Gerçek Git/çalışma alanı durumunu inceler; yapılmış işlemi körlemesine tekrarlamaz; kullanıcı değişikliklerini koruyarak doğru noktadan devam eder.                           |
| Aday kendi ölçütünü gevşetiyor      | B’deki ölçüte göre değerlendirme yapılır; adayın kendine verdiği PASS kabul oluşturmaz.                                                                                       |
| Yayınlama yolu kullanılamıyor       | Yerel adayın ve yerel kanıtın durumunu doğru raporlar; push, PR veya CI gerçekleşmiş gibi göstermez.                                                                          |

`AGENTS.md` için ayrıca **otomatik yükleme ile davranış etkisi** ayrılmalı. Resmî belge keşif sırasını, override davranışını ve boyut sınırını tanımlıyor; bu kuralların bizim ortamda beklediğimiz etkiyi verdiği henüz sınanmadı. Yeni oturuma özellikle “AGENTS’i oku” demek otomatik keşfi kanıtlamaz. İlk denemede kısa devam isteğiyle gerçek yönlendirme davranışı gözlenmeli; mümkün olan yükleme kayıtlarıyla desteklenmeli. [AGENTS.md keşfi](https://learn.chatgpt.com/docs/agent-configuration/agents-md)

Kesinti ve geri alma için yeni bir altyapı önermiyorum. Sonuç doğuran işlemden önce hedeflenen etki, ardından gözlenen sonuç mevcut iş kaydına yazılır. Kayıt eksikse gerçek durum incelenmeden tekrar denenmez. Yanlış OS değişikliğinde aday ilerletilmez; kabul edilmiş değişiklikte ise önceki çalışan sürüme kontrollü dönüş ve yeni oturumda tekrar yükleme/doğrulama gerekir. Git değişikliği geri alınmış olması, çalışan oturumun talimatlarının da yenilendiğini kanıtlamaz.

Başlıca açık riskler şunlar:

- **Başlangıç güveni:** İlk kabul edilmiş sürüm ve devredilmiş teknik yetki açıkça kurulmalı.
- **Talimat etkisi:** Dosyalar doğru olsa bile model yanlış yükleyebilir veya uygulayabilir.
- **Ortak hata:** Yeni ajan veya başka model, aynı yanlış öncülü paylaşabilir.
- **Gerçek yaptırım:** Yazma, push, PR, CI ve koruma kapsamı henüz kanıtlanmadı. Bunlar uygulamanın ihtiyaç duyduğu noktada doğrulanacak önkoşullardır.
- **Süreç büyümesi:** Her soruna yeni belge veya rol eklemek yerine mevcut yapının sadeleştirilmesi de değerlendirilmelidir.
- **Sınırlı deney:** Bir başarılı normal iş ve olumsuz senaryolar, sınırsız özerklik veya bütün görevlerde güvenilirlik kanıtı olmaz.

Kaynak izi açısından, araştırma reposundaki aşağıdaki yolların hepsi yukarıdaki sabit commit’e bağlıdır:

- Zorunlu tam okumalar: [research/INDEX.md](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/INDEX.md), [Context STATE](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-context/STATE.md), [Bootstrap bağlamı](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-context/current/DEVELOPMENT-OS-BOOTSTRAP.md), [Foundation STATE](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-foundations/STATE.md), [Foundation INDEX](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/soul-foundations/INDEX.md), [Studies CATALOG](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/studies/CATALOG.md).
- Derinleşme: Context/Memory/Harness paketinin girişleri, çapraz sentezi ve harness çalışması tam; [memory çalışmasının](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/studies/context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md) §§3–8, 17–18, 21–23 bölümleri seçici okundu. Yardımcı araştırmada Foundation Binding/Standing/Control giriş ve sentezleri ile yukarıda bağlantılanan değerlendirme ve yetki çalışmaları tam okundu.
- [Multi-agent değerlendirmesi](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/studies/multi-agent-patterns/SOUL-DEVELOPMENT-OS-ASSESSMENT.md) ve [gstack koordinasyon sentezi](https://github.com/batuhanozgun/agentic-os-search/blob/bfe58e7bde8ec9ef58e46fab5c04a7720e207407/research/studies/gstack/syntheses/multi-agent-cross-model-coordination.md) ilgili bölümler üzerinden kullanıldı. Multi-agent paketinde `STATE.md` ve `INDEX.md` bulunmuyor; mevcut `META.md` üzerinden devam edildi. gstack güncel ürünü benimsenmedi; sürümü belirli karşı örneklerinden yararlanıldı.

**Tasarım, sınırlı bir yerel bootstrap adayının hazırlanmasına geçmek için yeterince somut.** Bir sonraki iş üç belge yüzeyini ve davranış deneyi kapsamını oluşturmak; ardından taze oturumlarla sınamak olmalı. Gözetimsiz çalışma, ürün değişiklikleri ve otomatik yayınlama için henüz yeterli dayanak yok.

Bu turda dosya veya repository değiştirilmedi; commit, branch, issue veya PR oluşturulmadı; test ve uygulama başlatılmadı.