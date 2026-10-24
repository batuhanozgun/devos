# LinkedIn AI Yayın Rehberi — serinin amacı, okuyucusu ve kavramsal yönü

## Bu rehber neyi yönetir?

[Batu Yazım Rehberi](../BATU-YAZIM-REHBERI.md) **nasıl yazılacağını** anlatır.

Bu dosya ise LinkedIn'deki AI yazılarının **neyi anlatmaya çalıştığını, kime konuştuğunu ve yeni bir yazının hangi kavramsal hatta oturması gerektiğini** taşır.

İki rehber birlikte kullanılmalıdır:

- genel üslup ve doğal ses → `publications/BATU-YAZIM-REHBERI.md`
- LinkedIn serisinin amaç/kapsam/okuyucu/mekanizma hattı → bu dosya

## Kaynak corpus

Bu rehber, `publications/linkedin/posts/` altındaki **18 yayımlanmış gönderi** ve `publications/linkedin/articles/` altındaki **5 yayımlanmış makalenin** tamamı okunarak çıkarıldı.

Buradaki kullanım **stil analizi değildir**. Batu, LinkedIn'deki yazıların büyük bölümünün ChatGPT/Claude ile üretildiğini açıkça belirtti. Bu yüzden bu metinler Batu'nun doğal yazım sesine kanıt sayılmaz; fakat yayımlanmış serinin **konu, amaç, seviye ve anlatı rotasına** doğrudan kanıttır.

`Power BI Desktop Bridge` gönderisi alan-özel bir ürün/deneyim paylaşımıdır; ana AI çalışma-prensipleri serisinin normatif örneği sayılmaz. Makale duyuru postları ise dağıtım yüzeyidir; asıl kavramsal içerik bağlı makalelerde değerlendirilir.

---

## Serinin merkezindeki soru

Seri “AI neler yapabiliyor?” sorusundan çok şu soruya cevap arıyor:

> **AI ile gerçekten çalışırken ne oluyor ve bu çalışma ilişkisini güvenilir hale getirmek için neyi tasarlamak gerekiyor?**

İlk seri girişi bunu açıkça kuruyor: kullanıcılar AI'ı kullanmaya başladı fakat sistemin nasıl çalıştığını, nerede bozulduğunu ve neden aynı sorunları tekrar tekrar yaşadığını bilmiyor.

Bu yüzden yayınların temel işi ürün tanıtmak, prompt listesi vermek veya “AI ile şunu da yaptım” demek değildir.

Amaç:

1. kullanıcıların yaşadığı gerçek sürtünmeleri isimlendirmek;
2. bunların kişisel beceriksizlikten mi, model davranışından mı, context/memory sınırından mı, kötü iş tanımından mı kaynaklandığını ayırmak;
3. mekanizmayı gündelik örneklerle görünür hale getirmek;
4. tek konuşmadan project/skills/agentic/harness seviyesine doğru çalışma sisteminin neden gerektiğini göstermek.

## Okuyucu kim?

Ana okuyucu yazılımcı olmak zorunda değildir.

Daha doğru hedef kitle:

- ChatGPT, Claude, Codex veya benzeri sistemlerle iş yapan;
- mail, rapor, araştırma, analiz, sunum, yazılım veya başka profesyonel işler ürettiren;
- “bazen çok iyi, bazen neden dağılıyor?” sorusunu yaşayan;
- AI'ı yalnız sohbet kutusu olmaktan çıkarıp gerçek işinde daha güvenilir kullanmak isteyen;
- fakat agentic/harness terminolojisine hâkim olmak zorunda olmayan profesyonel kullanıcıdır.

Bu nedenle yazı teknik kavramı saklamamalı ama teknik kavramı **önce yaşanan problem üzerinden anlaşılır hale getirmelidir**.

Okuyucudan “SOUL”, Foundation, DevOS veya araştırma reposu gibi iç proje kavramlarını bilmesi beklenmez.

---

## Anlatının ilerlediği merdiven

Yayımlanmış içerik tek tek bağımsız AI ipuçları gibi görünse de altında bir ilerleme var.

### 1. Chat kutusunda yaşanan semptomlar

İlk katman kullanıcının doğrudan yaşadığı sorunları isimlendiriyor:

- **execution bias:** kullanıcı daha anlamaya çalışırken modelin işi bitirmeye koşması;
- **context window:** konuşmanın sonsuz hafıza olmaması;
- **drift:** tek tek mantıklı adımlarla hedeften uzaklaşma;
- **memory yanılgısı:** “hatırla” ile kalıcı çalışma durumunu karıştırma;
- **context pollution:** bir konuşmaya farklı amaçların yığılması;
- **sycophancy:** doğruyu korumak yerine kullanıcıya uyma eğilimi.

Bu katmanın ana mesajı:

> AI'ın davranışını “beni anlamadı / saçmaladı” diye kişileştirmek yerine mekanizmayı gör.

### 2. Konuşmayı değil çalışma çevresini tasarlamak

Sonraki katman tek promptun sınırını aşar:

- project instructions;
- knowledge files;
- proje hafızası;
- konuşmalar arası brifing;
- açık işlerin ve karar gerekçelerinin dışarıda tutulması;
- “bir konuşma = bir bağlam” disiplini.

Burada kullanıcı artık yalnız iyi prompt yazmıyor; **AI'ın çalışacağı bilgi ve continuity ortamını kuruyor.**

### 3. Tekrarlanabilir yöntem

Skills ve metodoloji yazıları şu geçişi yapıyor:

> Bir işi her seferinde yeniden anlatmak yerine çalışma yöntemini dışsallaştır.

Burada yapı:

- prosedür;
- şablon;
- karar kaydı;
- oturum açılış/kapanış disiplini;
- reusable skill;
- semantic / episodic / procedural bilgi ayrımı

gibi öğelere açılıyor.

### 4. Agentic çalışma

“Sahte seçenek” makalesinde anlatı artık tek sohbetten çok-rollü agentic sisteme geçiyor.

Planner, Spec, Code, Designer, Tester, Audit gibi roller aynı projede farklı sözleşmelerle çalışıyor.

Burada yeni problem sınıfı ortaya çıkıyor:

- rol;
- yetki;
- sıra/kuyruk;
- handoff;
- açık iş;
- standby;
- karar gerçekten kullanıcıya mı ait?;
- status doğru mu aktarılıyor?;
- yapan ile kontrol eden aynı mı?

Yeni analoji postları özellikle bu katmana bağlanmalıdır.

### 5. Çıktı kalitesinden iş kalitesine geçiş

“AI Bazen Yanlış Yapmaz; Yanlış Şeyi İyi Yapar” makalesi serinin önemli eksenlerinden biridir.

Burada başarı:

- metnin iyi görünmesi;
- kodun çalışması;
- cevabın kapsamlı olması

değildir.

Asıl sorular:

- Hangi iş bitti?
- Hangi karar kolaylaştı?
- Hangi belirsizlik azaldı?
- Definition of done neydi?
- Acceptance criteria neydi?
- Modelin doldurduğu varsayım alanı ne kadar kaldı?
- Çıktı gerçek hedefe mi optimize oldu, yoksa “iyi görünme” proxy'sine mi?

Bu yüzden yeni yazılar yalnız fikir anlatmamalı; **agentic sistemde doğru işin nasıl tanımlandığı, taşındığı, yapıldığı veya doğrulandığı** sorusuna değmelidir.

### 6. Davranış defolarından sistem tasarımına

“AI'ın Defoları” hattı tekil model davranışlarını birbirine bağlı bir sistem problemi olarak ele alıyor:

- sycophancy;
- mirroring;
- şişme;
- drift;
- sahte menü;
- uydurma;
- self-approval;
- freezing;
- decision loading.

Önemli nokta bunların yalnız isimlerini bilmek değil, **hangi çalışma koşullarının bu davranışları tetiklediğini** anlamak.

Çözüm de yalnız prompt değildir:

- role separation;
- maker-checker;
- context isolation;
- completion criteria;
- mechanical controls;
- bağımsız verification;
- uygun yerde hooks / procedures / contracts.

Bu, harness düşüncesine geçiştir.

### 7. LLM'i insan değil sistem olarak konumlandırmak

“LLM Düşünmez” makalesi bütün serinin zihinsel modelini daha temelden kuruyor:

> LLM'i insan gibi sezmesini beklediğimiz bir varlık değil, verilen girdiler ve çevresindeki sistem üzerinden çıktı üreten olasılıksal bir mekanizma olarak ele al.

Bu yazının sonundaki yön önemlidir:

> Prompt Engineering → Context Engineering → Agentic AI → Harness Engineering

Yeni analoji serisinin doğal yeri büyük ölçüde bu hattın **Agentic AI / Harness Engineering** tarafıdır.

---

## Yeni analoji yazıları ne yapmalı?

Analojiler kendi başlarına felsefi veya proje-yönetimi yazıları olarak kalmamalıdır.

Her yazı şu köprüyü kurmalıdır:

> **somut analoji → görülen ayrım → AI/agentic sistemde karşılığı → çalışma sisteminde hangi mekanizmayı değiştirdiği**

Örneğin “roman yazmak” analojisi yalnız “kullanıcı aslında ne istediğini tam söylemez” fikrine bağlanırsa eksik kalır.

Agentic karşılığı şudur:

- kullanıcı prompt'u doğrudan executable task değildir;
- agentic sistemde prompt'u olduğu gibi task graph'a koyarsan Planner, Researcher, Builder ve Verifier aynı yanlış iş üzerinde son derece düzenli çalışabilir;
- bu nedenle **intent / target / required conditions / work discovery** katmanı gerekir;
- Work, execution sırasında gelen yeni bilgiyle değişebilir;
- plan canlı olmalı;
- yeni Actor ihtiyacı, gerçekten keşfedilmiş Work'ten türemelidir;
- raw request ile current working interpretation aynı kayıt olmamalıdır.

Yani analoginin amacı “güzel fikir” değil, **agentic mekanizmayı görünür hale getirmek** olmalıdır.

## 14 analojinin yayın sırası ve doğal karşılıkları

1. **Roman / talep ≠ gerçek iş** → intent discovery, work discovery, adaptive planning.
2. **İlk Work işi yapmak değil işi keşfetmek** → work discovery, admission, readiness, actionable frontier.
3. **Evrensel küme** → unknown unknowns, requirement discovery, coverage ve dış perspective.
4. **1–6 → 1.1–1.5 planı** → progressive decomposition, living work graph, rolling planning.
5. **Ev–gökdelen–kulübe** → uzman routing'i, iş büyüklüğü ile epistemik kalite standardını ayırmak.
6. **Builder–Verifier** → maker-checker, epistemik bağımsızlık, role separation.
7. **Futbolcu kartı** → specialist agents + ortak reasoning baseline.
8. **Entelektüel miras** → agent bootstrap, reusable reasoning knowledge, policy/knowledge inheritance.
9. **Dosya mı bilgi mi?** → storage ile semantic memory lifecycle'ı ayırmak.
10. **İnsan hatırlar / LLM yeniden bulur** → persistence, retrieval, continuity ve state recovery.
11. **“Hava bugün çok…”** → context activation, retrieval, doğru bilginin doğru anda görünür olması.
12. **SOUL'u program gibi düşünmek** → harness, control flow, state transitions, mekanik guardrail'ler.
13. **Yatay–dikey genişleme** → capability addition + cross-cutting integration / governance.
14. **Roket kademesi gibi ayrılmayan sistem** → base harness'in task-specific working system'e genişlemesi.

Bu sıra aynı zamanda önerilen yayın sırasıdır. Eşleme kesin mimari karar değildir; LinkedIn yazısının hangi agentic problemi görünür kılacağına dair yayın rotasıdır.

---

## Bir postun seriye ait olup olmadığını nasıl anlarız?

Post aşağıdaki sorulardan en az birine somut cevap vermelidir:

- AI neden burada yanlış / yüzeysel / gereksiz davranıyor?
- Tek chat yaklaşımı neden yetmiyor?
- Uzun süren bir AI işi nasıl state tutuyor?
- Birden fazla agent neden ve nasıl ayrılmalı?
- Kullanıcının talebi nasıl gerçek Work'e dönüşüyor?
- Agent neyi bilmesi gerektiğini nasıl buluyor?
- Plan ve Work nasıl güncel kalıyor?
- Kim karar veriyor, kim uyguluyor, kim doğruluyor?
- “Bitti” neye göre deniyor?
- Doğru bilgi / doğru rol / doğru context nasıl eşleşiyor?
- Model davranışının güvenilir olması için prompt dışında hangi sistem yapısı gerekiyor?

Yazı bunlardan hiçbirine bağlanmıyorsa, ilginç bir analoji olabilir ama bu LinkedIn AI serisinin devamı olmayabilir.

## SOUL ve iç araştırma terminolojisi

SOUL bu araştırmanın iç kavramıdır. LinkedIn okuyucusunun onu bilmesi beklenmez.

Bu nedenle varsayılan yayın dili:

- “SOUL Actor” yerine gerektiğinde **agent / rol / worker / verifier**;
- “SOUL Work” yerine **iş / task / work graph / açık iş**;
- “SOUL Information” yerine bağlama göre **proje bilgisi / state / memory / context**;
- “Development OS” yerine gerekiyorsa **agentic çalışma sistemi / harness / çalışma altyapısı**

olmalıdır.

SOUL ancak bizzat SOUL'u tanıtan ayrı bir yayın yapılırsa açıklanarak kullanılmalıdır.

## Soyut fikir ile agentic yazı arasındaki fark

Eksik:

> Kullanıcı ne istediğini her zaman tam anlatamaz. Bu yüzden iş yaşayan bir yapıdır.

Seriye uygun:

> Tek sohbet içinde bu yalnız kötü bir cevap üretir. Çok-rollü agentic sistemde ise daha tehlikeli: ilk prompt yanlış task'a çevrilirse Planner planlar, Researcher araştırır, Builder üretir, Verifier de tanımlanmış kriterlere göre doğrular. Her rol görevini doğru yapar ama sistem yine yanlış işi yapmıştır. Bu yüzden executor'lardan önce “hangi iş gerçekten yapılmalı?” sorusunu taşıyan bir work-discovery mekanizması gerekir.

Serinin beklediği ek değer budur.

## Yazı ne yapmamalı?

- SOUL iç mimarisini okuyucu zaten biliyormuş gibi anlatmamalı.
- Yalnız proje yönetimi / kişisel gelişim / genel felsefe seviyesinde kalmamalı.
- Analojiyi AI'ya son paragrafta zorla bağlamamalı.
- “AI için 5 kural” formatına dönmemeli.
- Araştırma içindeki hipotezi yerleşik bilimsel gerçek gibi sunmamalı.
- Her problemi prompt çözümüyle kapatmamalı.
- Agentic sistemi yalnız “çok agent kullanmak” diye göstermemeli.
- Kodlama dünyasında popüler bir yöntemi bütün AI kullanımına otomatik genellememeli.
- Çıktı hacmini veya mimari karmaşıklığı ilerleme saymamalı.

## 2.800 karakterlik analoji postlarında beklenen yapı

Bu zorunlu şablon değildir; düşünsel kontrol noktasıdır.

İyi bir postta genellikle şunların izi bulunur:

1. Gerçek bir gözlem veya analoji.
2. Analojinin içinden çıkan ayrım.
3. Bu ayrımın AI / agentic sistemde somut failure mode'u.
4. Sistemde hangi mekanizmanın gerekli hale geldiği.
5. Yazının sonunda kazanılmış kısa bir sonuç.

Önemli olan beş başlık görmek değil; okuyucunun analojiden agentic mekanizmaya **doğal olarak geçebilmesi**dir.

## Bu seri sonunda okuyucunun zihninde ne değişmeli?

Okuyucu başlangıçta şöyle düşünüyor olabilir:

> “AI'a iyi prompt yazarsam iyi sonuç alırım.”

Yayın hattının götürmek istediği yer daha çok şudur:

> “Model tek başına çalışma sistemi değil. Güvenilir sonuç; doğru hedef, doğru context, kalıcı state, uygun rol, açık Work, sınırlar, completion criteria, bağımsız verification ve gerektiğinde mekanik kontrollerin birlikte tasarlanmasından çıkıyor.”

Kısacası seri AI'ın **cevap üretme yeteneğinden**, AI ile **çalışma sistemi kurma disiplinine** doğru ilerliyor.

Yeni analoji postları da bu ilerlemeyi devam ettirmelidir.
