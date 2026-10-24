# Context / Memory / Harness — Bağlamlı kullanım kayıtları

**Durum: KAYNAK-SÜRÜMLÜ KALICI KAYIT TAMAM — B6-T4, 2026-09-19.** Bu dosya context kayıtlarını ve diğer parçalara giriş yolunu taşır. **[TERMS-MEMORY.md](TERMS-MEMORY.md), [TERMS-HARNESS.md](TERMS-HARNESS.md) ve [TERMS-SYNTHESIS.md](TERMS-SYNTHESIS.md) ayrıca tam okunur.** Güncel kaynak/kapsam ve kapanış hesabı [READING.md](READING.md)'dedir. Yöntem [v0.3-working](../../METHOD.md); global kapsam [SCOPE.md](../../SCOPE.md). Tamamlanma yalnız bu sekiz dosyalı araştırmanın kullanım çıkarımına aittir; ortak tanım veya bütün studies kapanışı değildir.

Parçalardaki B6-T2/B6-T3 tarihli PAKET-KISMİ, D4 bekliyor ve eski pilot eşleştirmesi yapılmadı ifadeleri o üretim turlarının checkpoint'leridir. Bugünkü kapanışı bunlardan devralma: D4/H22.c bu turun sentez parçasında, bellek pilot kimliklerinin güncel erişim eşleştirmesi bu dosyanın §11'inde, gerçek paket durumu READING'dedir. Kaynak kullanım gövdeleri tarihsel kayıtları silmek için yeniden yazılmadı.

## Amaç ve kaynak sınırı

Bu dosya terimlerin genel/doğru tanımını araştırmaz. Belirli araştırmanın belirli bağlamda neyi anlattığını, kimden aktardığını ve hangi ayrımları koruduğunu kaydeder. Bir ifadeyi burada kalıcılaştırmak ortak kavram kabulü veya SOUL/Development OS mimari kararı değildir.

Pilot kaynak sürümü: **batuhanozgun/agentic-os-search@ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a**. Sekiz dosyanın kimliği S1 kapsamındaki 9b46155e904560c90b89e657f3d0d4e00e2e46cf sürümüyle aynı; bu yalnız kaynak eşitliğidir, güncel dış literatür veya runtime doğrulaması değildir. Kaynak dosyalardaki 2026-09-03 araştırma ve proje değerlendirmeleri tarihlidir. Eski research/<paket> yol ifadeleri bugünkü research/studies/<paket> konumuna göre çözülür; özgün metin değiştirilmedi.

Kullanıcı okuma sırasındaki anlam seçimlerini denetleyemediğinden önemli yorumlar ve sınırlar görünürdür. Ortak sözcüklerin aynı anlamı taşıdığı varsayılmaz; kullanıcı onayı, kaynağın kullanımı ve çıkarıcının açıklaması teknik doğruluğun yerine geçmez.

## Okuma anahtarı

- **Kullanım kimliği:** P1-T1/T3'ün K ve C kimlikleri korunur. .a/.b gibi alt adresler farklı kullanımları ayrı tutar; üst kimlik eski kayıt grubuna yönlendirir. Kimlik sayısı kavram sayısı değildir.
- **Atıf:** araştırma dosyası açıklamayı adlandırılmış dış kaynağa atfeder. Bu tur dış asıl kaynak yeniden okunmadı; burada birinci el teknik doğrulama iddiası yoktur.
- **Araştırma:** önceki araştırma yazarının tanımı, sentezi, ayrımı, değerlendirme sorusu veya proje yorumu. Ürünün/resmî kaynağın tanımı olarak sunulmaz.
- **Yeni yorum:** bu çıkarım sırasında kaynakta biçimsel olarak tanımlanmayan bir sınır yorumlanmışsa ayrıca söylenir. Tablolardaki Türkçe açıklamalar aksi belirtilmedikçe kaynak bağlantılı parafrazdır; doğrudan alıntı değildir.
- Aynı satırdaki iki işlem ayrı alt adres taşır. Birlikte gösterilmek eş anlamlılık kararı değildir. Kaynağın verdiği güven etiketi, bu aktarımın bağımsız doğrulaması sayılmaz.

## Kaynak noktaları

| Kod | Sabit kaynak | Kalıcı kayıt durumu |
|---|---|---|
| D0 | [00-WHY-THIS-RESEARCH.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/00-WHY-THIS-RESEARCH.md) | B6-T1 tam okuma; B6-T4'te başlangıç, hipotez, kaynak ve sınırları paket-geneli kontrol edildi. Sentez parçası §9'a bak. |
| D1 | [01-CONTEXT-ENGINEERING.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/01-CONTEXT-ENGINEERING.md) | B6-T1 tam geri okuma; aşağıdaki context kayıtlarının ana kaynağı. |
| D2 | [02-AGENT-MEMORY-ENGINEERING.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md) | B6-T2 kaynak kontrollü yeniden üretim: [bellek parçası](TERMS-MEMORY.md). B6-T4 pilot adres eşleştirmesi §11'de. |
| D3 | [03-HARNESS-ENGINEERING.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/03-HARNESS-ENGINEERING.md) | B6-T3 tam geri okuma ve pilot karşılaştırması: [harness parçası](TERMS-HARNESS.md). H22.c'nin D4 kısmı artık sentez parçasında. |
| D4 | [04-CROSS-LAYER-SYNTHESIS.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md) | B6-T4 tam okuma ve §1–25 kontrolü: [paket-geneli parça](TERMS-SYNTHESIS.md). G/X/İ, H22.c, kalıcılık ve araştırma dili kayıtları tamam. |

D1'in kendi S1'i Anthropic context-engineering yazısı, S2'si OpenAI harness-engineering yazısı, S3'ü SWE-agent çalışması, S4'ü önceki ai-knowledge-strategies paketidir. Bunlar D1 §24'ün atıf kimlikleridir; diğer dosyaların aynı numaralarıyla veya pilot kullanım kimlikleriyle karıştırılmaz. D0 §12 ayrı bir kaynak listesi taşır.

## 1. Aynı başlığın iki kapsamı

| Kimlik / özgün ifade | Bu araştırmadaki karşılık | Kaynak rolü, nokta ve sınır |
|---|---|---|
| K01 — Context Engineering | Model sampling sırasında mevcut tokenların sınırlı model kapasitesi altında yararını optimize etme problemi. | D1 §2, ilk paragraf: S1'e atıf. Araştırma tarafından aktarılan dış kaynak çerçevesi; bu tur asıl kaynaktan yeniden doğrulanmadı. |
| K02 — Context Engineering | Her inference/agent adımında görünür çalışma kümesinin bilgi, talimat, durum, araç sonucu, bellek, kanıt ve metadata bileşimini; miktarını, sırasını, temsil sadakatini ve güven/otorite işaretlerini tasarlama ve yönetme disiplini. | D1 §2, araştırma için verilen operasyonel tanım. K01'in birebir alıntısı değildir; araştırmanın genişletmesi olarak ayrı tutulur. |

K01 ve K02 aynı yazımı taşır fakat aynı kaynak rolüne sahip değildir. Aralarındaki ilişki araştırmanın dar çerçeveden operasyonel açılıma geçişidir; bütün araştırmalar için seçilmiş ortak tanım değildir.

## 2. Bağlam, mevcut çalışma kümesi ve içerik türleri

| Kimlik / ifade | Bağlamdaki karşılık | Kaynak ve açıklama statüsü |
|---|---|---|
| C01 — Context | Belirli çağrıda modelin gerçekten görebildiği token/bilgi kümesi. Başka yerde tutulmak ile o çağrıda görünür olmak ayrılır. | D1 §2: S1'e atfedilen tanım ve araştırmanın model-visible açıklaması. Kalıcı depodaki bilginin dünyada yokluğu iddia edilmez. |
| C02 — Model-visible working set / working context | Mevcut model adımı için görünür talimat, bilgi, durum ve sonuçların çalışma kümesi. | D1 §2–3: araştırmanın operasyonel adlandırması. C01'le ilişkili kullanım; ayrı bir fiziksel bellek bileşeni icat edilmez. |
| C03 — Prompt Engineering | Özellikle talimatın rol, hedef, kısıt, örnek ve çıktı biçimi tarafını düzenlemek. | D1 §3: araştırmanın karşılaştırması. Kesin endüstri standardı sınırı kurulmadığı D1 §23'te açık. |
| C04 — Control / instruction context | Davranışı yönlendiren talimatlar, politika, görev kısıtları, araç kuralları ve kabul ölçütleri. | D1 §5.1: araştırmanın içerik sınıfı. Bu araştırma metinleri mevcut assistant için talimat otoritesi değildir. |
| C05 — Current work state | Güncel hedef, aşama, açık sorular, yetkili sonraki eylem ve aktif plan/ilerleme bilgisi. | D1 §5.2: araştırmanın içerik sınıfı. Bir durumun yazılı olması doğruluğunu ayrıca göstermiyor. |
| C06 — External evidence | Kaynak belgeler, web sonuçları, repo dosyaları, veri tabanı satırları ve API yanıtları. | D1 §5.3: araştırmanın kaynak sınıfı. Evidence etiketi içerik doğruluğunu sertifikalamaz. |
| C07 — Memory recall | Önceki karar, kalıcı not, olgu, olay ve prosedür bilgisinin mevcut bağlama geri getirilmesi. | D1 §5.4 ve §10: araştırmanın kullanımı; structured note-taking bağlantısı S1'e atfediliyor. Bellek yaşam döngüsünün bütünü değildir. |
| C08 — Tool interface context | Kullanılabilir araç adları, şemaları, açıklamaları, izinleri ve eylem olanakları. | D1 §5.5: araç arayüzünü anlatan içerik. Araçtan dönen veriyle aynı yüzey değil. |
| C09 — Tool result context | Komut çıktısı, günlük, iz, arama sonucu ve test sonucu gibi araç gözlemleri. | D1 §5.6: sonuç/gözlem yüzeyi; C08 ile ayrılır. |
| C10.a — Derived context | Özet, getirilen parça, grafik görünümü, sıkıştırılmış geçmiş veya alt aktör sentezi gibi dönüştürülmüş bağlam. | D1 §5.7: araştırmanın içerik sınıfı. |
| C10.b — Derived view | Başka bir kaynak/izden seçim veya özetleme ile oluşturulan görünüm. | D1 §11: compaction sonucunu niteleyen araştırma açıklaması. Kaynağın kendisi veya kayıpsız kopyası sayılmaz. |

Kaynak bu sınıfları farklı sadakat, güncellik ve otorite sorunlarını konuşmak için kullanıyor; bu dosya onlardan evrensel, tamamen ayrık bir veri modeli üretmez.

## 3. Erişim, seçim, dönüştürme ve sunum

| Kimlik / ifade | Bağlamdaki karşılık | Kaynak rolü ve sınır |
|---|---|---|
| C11 — Just-in-time loading / retrieval | Her şeyi baştan yüklemek yerine dosya yolu, bağlantı veya saklanmış sorgu gibi hafif referanslardan ihtiyaç anında içeriğe ulaşmak. | D1 §6, S1'e atıf. Her retrieval işleminin mutlaka bu stratejiyi uyguladığı söylenmez. |
| C12.a — Progressive retrieval | Giriş/yönlendirme bilgisinden mevcut işin gerektirdiği kaynak derinliğine ilerlemek. | D1 §19: tarihli proje yorumu. Güncel Development OS uygulamasının bu tur denetimi değil. |
| C12.b — Progressive disclosure | Kısa harita ve yapılandırılmış kayıt düzeninden gerekli ayrıntıyı açma yaklaşımı. | D1 §19, S2'ye atfedilen örnek. C12.a ile ilişkili; bütün bağlamlarda eş anlamlı ilan edilmez. |
| C13.a — Retrieval correctness | Doğru belgeyi veya içeriği bulma sorusu. | D1 §7: araştırmanın ayrımı. |
| C13.b — Context correctness | Bulunan içeriğin kapsam, sürüm, niteleyici, sıra ve otorite bilgisi korunarak mevcut bağlamda kullanılabilir olması sorusu. | D1 §7–8: araştırmanın daha geniş değerlendirme yüzeyi. C13.a tek başına bunu sağlamıyor. |
| C14 — Context assembly | Seçilmiş kaynakların ve sonuçların modelin göreceği çalışma kümesinde bir araya getirilmesi. | D1 §7 işlem dizisi. Kaynak seçimi, retrieval ve model kullanımıyla aynı adım değil. |
| C15.a — Context ordering | Bağlam parçalarının sıralanması. | D1 §14: araştırmanın aday düzenleme boyutu. Evrensel sabit sıra verilmemiş. |
| C15.b — Salience | Önemli içeriğin bağlam içinde dikkat açısından öne çıkması veya gömülü kalması. | D1 §7, §14: başlık ve örneklerden kaynak bağlantılı açıklama; ayrıca ölçülmüş nicel tanım yok. |
| C16 — Compaction | Büyüyen geçmişi özetleyip yeni bağlamda devam etme yöntemi. | D1 §11'in yöntemi S1'e atıf; bunun kayıplı/türetilmiş görünüm ve sadakat problemi olarak ele alınması araştırmanın açıklaması. Tanımın varlığı doğru sıkıştırma garantisi değil. |
| C17 — Tool output shaping | Araç gözleminin modele hangi biçim, ayrıntı ve hacimle sunulduğunu düzenlemek. | D1 §12: arayüz örnekleri S3'e atıf, context/harness ilişkisi araştırma yorumu. Bu tur performans testi yok. |
| C18.a — Sub-agent isolation | Alt aktörün göreve özgü ayrı çalışma bağlamı kullanması. | D1 §13, S1'e atfedilen yaklaşım. İşletim sistemi güvenlik yalıtımı olarak tanımlanmıyor. |
| C18.b — Context partitioning | Kaynak bağlamının alt aktörlerde işlenip ana aktöre yoğunlaştırılmış sonuç olarak taşınması. | D1 §13: araştırmanın ilişki açıklaması. Özet aktarımındaki anlam kaybı ve bağımlılık açık. |
| C19 — Context pollution / contamination | Eski plan, geçersiz kaynak, aşırı günlük veya desteklenmemiş iddiaların bağlamın kullanımını bozması. | D1 §15: araştırmanın hata başlığı. Her tarihsel bilginin gereksiz olduğu sonucu çıkarılmaz. |
| C20 — Epistemic status collapse | Kaynak, çıkarım, plan ve spekülasyonun statüleri ayırt edilmeden aynı metin yüzeyinde görünmesi. | D1 §15: araştırmacının adlandırdığı risk. |

## 4. İlk dökümün ayrıntı kayıtları

C21–C28, P1-T3'te eklenmiş kayıtlardır. Birlikte anılan farklı işlemler şimdi alt adreslerle korunur; bu, yeni genel kavram araştırması değildir.

| Kimlik / özgün ifadeler | Yerel anlam ve ayrı adresler | Kaynak / statü |
|---|---|---|
| C21 — Erişim seçenekleri | C21.a exact path read; C21.b keyword search; C21.c semantic retrieval; C21.d graph traversal; C21.e API query; C21.f human clarification. Bağlamı kurarken bilgi edinmenin farklı yolları olarak listeleniyor. | D1 §6. Araştırma listesi; bütün algoritmaların ayrıntılı tanımı yok. Hepsi vector similarity diye birleştirilmez. |
| C22 — Seçim/dönüştürme işlemleri | C22.a source selection: hangi kaynakların seçileceği; C22.b rerank/filter: getirilenlerin yeniden sıralanması/elenmesi; C22.c query rewrite: sorgunun yeniden yazılması. | D1 §7. İşlem dizisi ve hata açıklaması; sorgu değişikliğinin problem çerçevesini kaydırabilmesi ayrıca belirtiliyor. |
| C23 — Taşınması gereken niteleyiciler | C23.a chunk qualifier: parçanın anlamını sınırlayan bilgi; C23.b source identity: ad/yol/sürüm; C23.c authority metadata: kaynak otoritesine ilişkin bilgi; C23.d source boundaries: kaynakların ayrımının görünür olması. | D1 §7–8. Araştırmanın kayıp/risk soruları; uygulanmış metadata şeması değil. |
| C24 — İki farklı amaç | C24.a context completeness: gerekli bilgi eksik olmasın; C24.b context minimality: gereksiz içerik bağlamı doldurmasın. | D1 §4.1. Araştırmanın gerilim açıklaması; tek bir başarı ölçütüne indirgenmez. |
| C25 — Kapasite ile etkili kullanım | C25.a accepted context capacity: kabul edilebilen bağlam hacmi; C25.b workload-effective context: belirli işte etkili kullanılabilen bağlam. | D1 §8, önceki ai-knowledge-strategies araştırmasına atıf. Bu aktarım o paketin kendi çıkarımını tamamlamaz. |
| C26 — Bütçe kullanımları | C26.a context budget: görünür küme için ayrılan sınırlı hacim; C26.b attention budget: dikkat yükü/kaynak sınırı anlatımı; C26.c context budget curve: farklı bütçelerde kalite karşılaştırması, E-CTX-08'e bak. | D1 §4, §15, §17.8. Kaynakta ortak sayısal bütçe veya tek ölçüm tanımı seçilmemiş. |
| C27 — Trust boundary | Dış içerik, yetkili kontrol talimatı, canonical durum, türetilmiş içerik ve kullanıcı iddiasının ayrı statülerde ele alınması. | D1 §16. Araştırma önerisi. Etiketleme tek başına çalışma zamanı uygulaması değil. |
| C28 — Bilgi düzeni ve işletim | C28.a context information architecture: bilginin/erişim yollarının düzenlenmesi; C28.b context-loading enforcement: gerekli yüklemenin gerçek yürütmede uygulanması. | D1 §19. Tarihli proje sentezi; bugünkü uygulamanın doğrulanmış iki modülü diye gösterilmez. |

### İlgili fakat bu bölümde genel tanımı kurulmamış adlar

D1 §8'de source eligibility ve permission filter; §10'da select/rank/compress/frame/inject; §14'te pruning; §18'de context builder, graph neighborhood, long-context package ve cached stable prefix adları geçer. Kaynak bunları erişim/seçim/sunum sorularıyla ilişkilendirir; her biri için bağımsız genel tanım veya yeni bileşen şartı vermez. Bu isimler yok sayılmadı; C14/C21–C28 ve aşağıdaki ilişki görünümüyle bağlanır.

LLM, model, inference, token, policy, workflow, affordance ve agent step ifadeleri D0/D1'de kullanılır. Bu dosyalar bütün terimlerin bağımsız sınırını kurmadığından genel sözlük bilgisiyle doldurulmaz. RAG, Knowledge Graph, CAG, Long Context ve Fine-Tuning adlarının paket-geneli G kayıtları artık TERMS-SYNTHESIS'te, D4 kaynak kontrolüyle bulunur. Model çağrısı, mevcut çalışma kümesi ve harici kalıcılık aynı nesne sayılmaz.

## 5. Bağlama ilişkin değerlendirme dili

P1'de açıklanmış fakat ayrı kimliği olmayan D1 §17 değerlendirme başlıkları burada E-CTX adreslerini alır. Yeni test veya yeni standart oluşturulmadı. Tamamı araştırma yazarının önerdiği değerlendirme sorularıdır; bu tur çalıştırılmış ölçümler değildir.

| Kimlik / ifade | Neyi sorguluyor? | Kaynak |
|---|---|---|
| E-CTX-01 — Sufficiency / recall | Gerekli kanıt mevcut çağrının bağlamına girdi mi? | D1 §17.1 |
| E-CTX-02 — Precision / noise | Karar açısından ilgisiz içeriğin yükü ne kadar? | D1 §17.2 |
| E-CTX-03 — Authority correctness | Yalnız konu benzerliği değil, uygun güncel/otoritatif kaynak korunuyor mu? | D1 §17.3 |
| E-CTX-04 — Freshness | Değişebilir durumun doğru sürümü kullanılıyor mu? | D1 §17.4 |
| E-CTX-05 — Fidelity | Özet, parça veya araç çıktısı kaynağın anlamını koruyor mu? | D1 §17.5 |
| E-CTX-06 — Position robustness | Önemli kanıt farklı konumlarda da kullanılabiliyor mu? | D1 §17.6 |
| E-CTX-07 — Conflict robustness | Güncel canonical bilgiyle makul tarihsel çelişki birlikteyken statü ayrımı korunuyor mu? | D1 §17.7 |
| E-CTX-08 — Context budget curve | Kalite farklı bağlam bütçelerinde nasıl değişiyor? | D1 §17.8; C26.c ile aynı kullanıma ek adres |
| E-CTX-09 — Negative control | Gerekli kanıt çıkarıldığında sınama olumsuz sonuç verebiliyor mu? | D1 §17.9 |
| E-CTX-10 — Security | Güvenilmeyen talimat benzeri içeriğin kontrol davranışını değiştirip değiştirmediği. | D1 §17.10; C27'nin trust-boundary ayrımıyla ilişkili |

Bu başlıkların bulunması, bağımsız doğal-dil yeterlilik ölçütünün kurulmuş veya bütün kontrollerin uygulandığı anlamına gelmez. D1 §22 açık sorular ve §23 sınırlar bunu korur.

## 6. Context bölümünün kaynak-içi ilişki görünümü

Bu görünüm D0/D1 içindir; D4'ün paket-geneli kayıtları TERMS-SYNTHESIS'te ayrıca okunur.

**İçerik varlığı → erişim/seçim → dönüştürme/sıralama → modelin gördüğü çalışma kümesi → model kullanımı.** D1 §2, §6–7, §10. Dosyada tutulmak, retrieval ile bulunmak ve çağrıda doğru biçimde görünmek ayrı aşamalardır. Oklar bizim için benimsenmiş bir yazılım mimarisi değil, araştırmanın açıkladığı ilişkidir.

D1 §10 bellek tarafında write/update/consolidate/retain/forget işlemlerini anıp recall candidates üzerinden select/rank/compress/frame/inject ve model çağrısına geçer. Bu ilişki belleğin tamamını context'e indirgemez. Aynı son hatanın bellek güncellemesi, geri çağırma, bağlam kurma veya model kullanımıyla ilişkili olabileceği kaynakta alternatif açıklamalar olarak kalır; burada yeni neden teşhisi yapılmadı.

D1 §12–13 araç çıktısının biçimini ve alt aktör özetini context sorununun içine alır; D0 §4 harness'in bunları işleten daha geniş bir düzen olabileceği hipotezini verir. Bunlar üç bağımsız ve eş düzey zorunlu katman değildir. RAG, önbellek ve Long Context ile kurulan ilişkilerin kapsamı D1 §6–10'dadır; diğer kaynak paketleri henüz seri çıkarımda okunmuş sayılmaz.

D1 §18'in Candidate SOUL context gate'i bir karar çerçevesi önerisidir; SOUL'un kurulmuş kontrol mekanizması veya yeni uygulama yetkisi değildir. D0 §6 ve D1 §19'un Development OS sözleri, araştırmanın yazıldığı tarihteki repo yaklaşımına ilişkin yorumlardır; bugün Development OS'nin inşa edildiğini göstermez.

## 7. B6-T1 aktarım izi — tarihsel checkpoint

**B6-T1:** P1-T1/T2/T3 görünür konuşma çıktılarına geri dönüldü; K01/K02 ve C01–C28'in bağlamları D0/D1 üzerinden yeniden kontrol edildi. Eski kimlikler korundu. Çoklu satırlardaki ayrı işlemler .a/.b alt adresleriyle ayrıldı; bu yeni evrensel kavram üretimi değil, v0.3 kayıt açıklığıdır. E-CTX-01–10 önceki açıklanmış değerlendirme dilini adresler. Yeni bir bağımsız etkinlik kanıtı eklenmedi.

**Korunan maddi sınırlar:** K01'in atfedilen dar tanımı ile K02'nin araştırma genişletmesi; kaynak bilgi ile türetilmiş görünüm; araç arayüzü ile araç sonucu; retrieval doğruluğu ile context doğruluğu; mevcut bağlam hacmi ile işte etkili kullanım; bilgi düzeni ile runtime uygulaması. Source confidence ifadeleri yeni doğrulama sonucuna yükseltilmedi.

**B6-T1 sonunda henüz aktarılmamış olanlar:** K03–K08, M01–M28, H01–H27, G01–G06, X01–X03 ve P1'in paket-geneli ilişki kayıtları. Bu tarihsel liste bugünkü kayıtları yok saymaz; sonraki turların erişim ve aktarım sınırları aşağıdadır.

## 8. B6-T2 — Bellek parçası ve tarihsel erişim sınırı

[TERMS-MEMORY.md](TERMS-MEMORY.md), D2'nin otuz bölümünün tam okumasına ve kaynak tarafından kapsam kontrolüne dayanır. Sistem/yaşam döngüsü, disiplin ve tekil kayıt; yazma/yönetme/okuma; zaman ve metadata alanları; ilgili mekanizmalar; on bir değerlendirme sorusu; sekiz aday proje sınıfı; bellekten bağlama aktarım ve koşullu işletim ilişkileri kaydedildi. D2'nin dış atıfları ve önceki araştırmacı yorumları yeni teknik doğrulama yapılmış gibi sunulmadı.

**B6-T2'nin kimlik ve erişim sınırı:** O turun kaydı, P1'in özgün bellek dökümünün erişilebilir görünümünde bulunmadığını belirtir. İçerik sabit kaynaktan yeniden üretildi ve D2-* adresleri aldı. K03/K04/K08, M01–M28 veya H17 ile özgün satır düzeyinde eşleşme o tur tahmin edilmedi. Bu tarihsel kayıt korunur. **B6-T4'te görünür pilot satırlarıyla yapılan güncel adres eşleştirmesi §11'dedir; bu, B6-T2'nin geriye dönük birebir kopya ilan edilmesi değildir.**

C07/C14/C27 ve context değerlendirme kayıtları değiştirilmedi; D2'nin ilişkili kullanımları ayrı kaynak noktalarıyla eklendi. D2'nin internal/external memory genişliği ile parametrik uyarlama ayrımı, canonical state'in kalıcılık/otorite gerilimi ve kullanım yolundan çıkarma/türetilmiş kopya silme ayrımı bellek parçasında açık. Bunlar erken ortak kavram kararı değildir.

## 9. B6-T3 — Harness parçasının tarihsel aktarımı

[TERMS-HARNESS.md](TERMS-HARNESS.md), D3'ün §1–31 tam okuması, o tur görünür P1-T1/P1-T3 harness dökümleri ve kaynak tarafından kapsam kontrolüyle üretildi. K05–K07 ve H01–H27 üst adresleri korunur; faaliyet/nesne, amaç/sağlanmış özellik, farklı handoff ve rollback kullanımları alt adreslerle görünürdür. Dokuz aday sorumluluk alanı, on hata başlığı ve yedi değerlendirme sorusu zorunlu mimari veya yapılmış test olarak sunulmaz.

H17 D2-U36'ya kaynak-içi bağlantıdır. B6-T3'te bekleyen H22.c'nin cache identity/invalidation kısmı, D4 §7 üzerinden **TERMS-SYNTHESIS/H22.c.1–5** ile B6-T4'te karşılandı. Harness dosyasının B6-T3 tarihli bekliyor cümleleri bu yeni kayıt tarafından güncellenen devam geçmişidir; yeni açık iş değildir. Context ve bellek kullanım gövdeleri bu nedenle değiştirilmedi.

## 10. B6-T4 — Paket-geneli kayıt ve kapanış

[TERMS-SYNTHESIS.md](TERMS-SYNTHESIS.md), G01–G06, X01–X03, İ01–İ05 ve H22.c'yi D4'ün tam kaynağıyla ilişkilendirir. Persistence/memory/context/continuity, ilişki matrisi etiketleri, governance kullanımları, açık karar soruları, anti-pattern adları ve D0/META/STATE/INDEX'in araştırma dili ayrıca kayıtlıdır.

D0–D4 ile üç giriş dosyasından bütün parçalara kapsam kontrolü yapıldı. D4 bu tur tamamen; META/STATE/INDEX tamamen; D0 1–160 yeniden getirildi, kalan D0 ve D1/D2/D3'ün aynı konuşmada erişilebilir tam kaynak metinleri ve önceki kayıtları kullanıldı. Bütün paketin bu tur sıfırdan sekiz yeni tam okuması yapıldığı iddia edilmez. Kaynağın çözmediği genel kavramlar çözülmüş gösterilmedi. Güncel source/delta ve tamamlanma gerekçesi READING'dedir.

Maddi açıklıklar: matris etiketi etki ölçümü değildir; NOT SAME ilişkisizlik değildir; D4'teki geniş memory etkisi cümlesi parametrik kullanıma evrensel yasa olarak genişletilmez; tarihli external control plane/Development OS anlatımı bugünkü ürün kurulumuna çevrilmez. Aynı kaynak sentezinin tekrarı yeni bağımsız destek sayılmaz.

## 11. B6-T4 — Görünür P1 bellek kimlikleri için adres eşleştirmesi

Bu tur P1-T1 ve P1-T3'ün özgün görünür bellek satırları D2 kaynak metni ve kalıcı bellek parçasıyla karşılaştırıldı. Tablo **erişim/eşleştirme tablosudur**, birebir metin arşivi veya iki adın evrensel eş anlamlılık kararı değildir. Bir pilot grubu birden çok kalıcı adrese açılabilir. D2-* adresleri TERMS-MEMORY'de; D4-* adresi TERMS-SYNTHESIS'tedir. B6-T2'deki erişim sınırı geçmişte neyin yapıldığının kaydı olarak korunur; aşağıdaki kontrol bugün eksik kimlik bağlantısını tamamlar.

| Eski pilot adresi / konu | Kalıcı karşılık |
|---|---|
| K03 — Agent memory yaşam döngüsü | D2-U01; D2-U05–U12 |
| K04 — Agent Memory Engineering | D2-U02/U03; kaynak etiketi ile genişletilmiş disiplin tanımı ayrı |
| K08 — Tekil memory kaydı | D2-U04 |
| M01 — Candidate formation | D2-U05 |
| M02 — Write/encode | D2-U06; D2-REP |
| M03 — Validate/qualify | D2-U07; D2-Q |
| M04 — Consolidate/organize | D2-U08 |
| M05 — Update | D2-U09.a; D2-UP |
| M06 — Supersession | D2-U09.b; D2-MD03/MD04 |
| M07 — Contradiction/temporal update | D2-U09.c/U20 |
| M08 — Retain/expire/forget | D2-U10/U29 |
| M09 — Read/retrieve | D2-U11; D2-R |
| M10 — Inject/use | D2-U12/U36 |
| M11 — Episodic | D2-U13 |
| M12 — Semantic/fact | D2-U14 |
| M13 — Procedural/workflow | D2-U15 |
| M14 — Working/session state | D2-U16 |
| M15 — Canonical project state | D2-U17/U18; D2-P01–P08 ve kalıcılık/otorite açıklığı |
| M16 — Parametric memory | D2-U26.a |
| M17 — External memory | D2-U27 |
| M18 — Reflection memory | D2-U28 |
| M19 — Session persistence/Sessions | D2-U33 |
| M20 — Poisoning/self-reinforcement | D2-U32 |
| M21 — Temsil seçenekleri | D2-REP01–REP08 |
| M22 — Memory substrate/store | D4-U07; D2-U22/U27'nin ilgili temsil bağlamları |
| M23 — Güncelleme seçenekleri | D2-UP01–UP05 |
| M24 — Geri çağırma koşulları | D2-R01–R07 |
| M25 — Zaman/yer değiştirme alanları | D2-T01–T05; D2-MD03/MD04 |
| M26 — Retention/deletion/access scope | D2-U29–U31; D2-MD07/MD08 |
| M27 — Environment experience/gotchas/verification learning | D2-U34.b/U34.e; D2-P06 |
| M28 — Virtual context/tiers/stream/episodic buffer | D2-U25/U28/U13; D2-N03/S2/S4/S6 — kaynak adı/aktarılmış kullanım sınırıyla |
| H17 — Bellekten bağlama bilgi devri | D2-U36 ve TERMS-HARNESS/H17 |

Önceden numarasız açıklanan bellek değerlendirme adları D2-E01–E11; temel kaynağa atfedilen yetenekler D2-E-SRC01–05; örnek zaman/kaynak/tür alanları D2-T/MD adresleriyle korunur. Bu eşleştirme bütün eski yanıtların sözcüğü sözcüğüne kopyalandığını göstermez; önemli kullanım, niteleyici ve kaynak rolünü kaybetmeden bulunabilmelerini sağlar.

**Güncel sonuç:** CMH'nin sabit sekiz dosyasından kalıcı kullanım çıkarımı kapanmıştır. Sıradaki seri paket ve yetki global concepts/STATE.md'dedir. Somut yeni atlama veya kaynak değişikliği ilgili kaydı yeniden açabilir; genel kavramları daha derin araştırma veya ortak referansa erken geçme yetkisi doğmaz.
