# Intellectual heritage: access to research is not thinking with it (input to W-C00-12)

**Provenance.** Batu had ChatGPT write this text from his own thinking. He gave it to builder session `session_016Hi3ZYgAf2amYNGc43a3tr` on 2026-10-03, for all three scopes (installation, DevOS, SOUL). The Turkish text below is the message as Batu gave it, with line breaks preserved and lists set as Markdown lists; the builder's assessment follows.

## Original (Turkish, verbatim)

SOUL üzerine düşünürken bir noktada şu ayrım benim için önemli hale geldi:

Bir Actor’ın bilgiye erişebilmesi ile o bilginin Actor’ın düşünme biçiminin parçası olması aynı şey değildir.

Bu farkı anlatmak için LLM’in kendi eğitim bilgisini analoji olarak kullanmıştım.

Bir LLM’i açtığımda model sıfır bilgiyle başlamıyor.

Ben ona:

“Memory nedir?”

diye sorduğumda önce gidip bir dosyadan “memory” kavramının varlığını öğrenmesi gerekmiyor.

Model zaten eğitim sürecinden gelen çok geniş bir bilgi tabanıyla çalışıyor.

Ben bunun üzerine:

* conversation context,
* project instructions,
* repository dosyaları,
* yeni araştırmalar

ekleyebiliyorum.

Ama temel model bunlardan önce de bir dünya bilgisiyle “doğuyor”.

SOUL Actor’ları için düşündüğüm şey biraz buna benziyor.

⸻

Repository’ye erişim vermek tek başına yeterli değil

Diyelim SOUL’un araştırma repository’sinde memory konusunda çok sayıda çalışma var:

* Karpathy örnekleri,
* Hermes,
* agent memory sistemleri,
* Foundation Information çalışmaları,
* geçmiş exploration’lar,
* başka studies.

Ve yeni bir Actor’a:

“Repository’ye erişebilirsin.”

diyoruz.

Teknik olarak bu Actor bilgiye erişebilir.

Ama şu iki Actor aynı değildir:

Actor A

Memory problemi geldiğinde yalnız eğitim bilgisinden cevap verir.

Ancak açıkça:

“Repository’de memory araştırması var, git oku.”

denirse onları açar.

Actor B

Memory problemi gördüğünde doğal olarak şunu düşünür:

“Bu konuda bizim daha önce araştırmalarımız vardı. Hangi çalışmalar relevant olabilir? Foundation ne söylüyor? Studies tarafında hangi mekanizmaları incelemiştik?”

İkinci Actor’ın davranışı benim istediğim yapıya daha yakın.

Çünkü burada araştırma yalnız erişilebilir değildir.

Araştırmanın varlığı Actor’ın düşünme eğilimine dahil olmuştur.

⸻

Bilginin adresini bilmek ile o bilginin perspektifini taşımak farklıdır

Örneğin bir Actor’a şöyle bir not verebiliriz:

Memory araştırmaları research/studies/... altında.

Bu bir retrieval bilgisi sağlar.

Ama şu düşünceyi sağlamaz:

“Memory problemi tek bir storage ürünü seçme problemi değildir; yaşam döngüsü, retrieval, provenance, stale bilgi, continuity ve change-impact gibi boyutları olabilir.”

İkinci tür bilgi daha derindir.

Çünkü artık Actor yalnız:

“Nerede dosya var?”

sorusunu bilmiyor.

“Bu probleme hangi açılardan bakılması gerektiğini”

de öğrenmiş oluyor.

Benim “entelektüel miras” derken kastettiğim şey buna yakın.

⸻

Yeni Actor her seferinde araştırma tarihini sıfırdan keşfetmemeli

Uzun bir araştırma programının amacı yalnız çok sayıda belge üretmekse ciddi bir sorun var.

Yeni Actor geldiğinde yüzlerce dosyayı yeniden okuyup:

“Burada önemli ayrım neydi?”

diye sıfırdan keşfetmek zorunda kalabilir.

Bu pahalıdır.

Daha da önemlisi, farklı Actor’lar aynı araştırmadan farklı ve eksik çıkarımlar yapabilir.

Bu yüzden araştırmadan yalnız arşiv değil, yeniden kullanılabilir entelektüel birikim çıkması gerektiğini düşünüyorum.

Bir bilim alanındaki eğitim gibi.

Bir fizikçi her yeni probleme başlarken Newton’un bütün özgün metinlerini yeniden okuyup mekaniği sıfırdan keşfetmez.

Alan içindeki eğitim, yöntemler ve kavramsal ayrımlar sonraki çalışmanın başlangıç tabanına dönüşür.

SOUL araştırmasının da benzer bir rolü olabilir.

⸻

Actor “biz bu konuda ne öğrendik?” bilinciyle başlamalı

Örneğin verification problemi geliyor.

Actor yalnız:

“Test yazabiliriz.”

dememeli.

Araştırma birikimimizden dolayı şunları düşünmeye eğilimli olmalı:

* maker ile verifier aynı hata kaynağını taşıyor olabilir,
* testin yeşil olması tek başına yeterli değildir,
* oracle yanlış şeyi ölçüyor olabilir,
* criterion sonuçtan sonra değişmiş olabilir,
* doğrulamanın gerçekten yanlış durumda kırmızı verebilmesi gerekir.

Bunların her birini o anda bütün kaynakları okuyarak yeniden keşfetmek zorunda olmaması ideal olur.

Actor’ın başlangıç bakışında bu tür araştırılmış ayrımların izleri bulunmalıdır.

Sonra önemli karar gerektiğinde özgün kaynaklara geri dönebilir.

Bu iki katmanı ayırmak önemli:

entelektüel miras → ilk bakış ve soru üretimi

özgün kaynak → kritik hüküm ve doğrulama

⸻

Bu, Actor’a sonuçları ezberletmek değildir

Burada yanlış anlaşılabilecek bir nokta var.

“Entelektüel miras” demek:

“Repository’deki bütün eski sonuçları dogma gibi Actor’ın içine yaz.”

demek değildir.

Tam tersine.

Araştırmanın önemli derslerinden biri eski sonuçların:

* koşullu,
* eksik,
* superseded,
* yanlış,
* yalnız belirli bir bağlama ait

olabileceğidir.

Dolayısıyla miras yalnız:

“Şu doğrudur.”

tipinde sonuçlardan oluşmamalıdır.

Daha değerlisi bazen şunlardır:

* şu ayrımı unutma,
* şu failure mode’u kontrol et,
* şu varsayımı sessiz kabul etme,
* şu tür kanıtı fazla güçlü yorumlama,
* bu konuda birden fazla yaklaşım olduğunu bil,
* burada özgün kaynağa dönmek gerekebilir.

Yani mirasın önemli bölümü düşünme alışkanlıkları ve problem lens’leri olabilir.

⸻

Bir insan uzman da yalnız doküman koleksiyonu değildir

Bu fikir önceki mimar analojisiyle birleşiyor.

Bir mimarı projeye çağırdığımızda yalnız:

“Mimarın bütün kitapları şu klasörde.”

demeyiz.

Mimar o kitaplardan, eğitimden ve deneyimden zaten etkilenmiştir.

Bir probleme baktığında:

* yük,
* kullanım,
* malzeme,
* insan davranışı,
* yapı ilişkileri

gibi şeyleri doğal olarak düşünür.

Kitaplar gerektiğinde açılabilir.

Ama mimarın değeri yalnız kitaplara erişebilmesi değildir.

Hangi soruları sorması gerektiğini öğrenmiş olmasıdır.

SOUL Actor’ı için de benzer bir seviye istiyorum.

⸻

“Memory için RAG kullanabilirsin” demek neden yetersiz?

Memory örneğinde bunu özellikle hissetmiştim.

Bir Actor’a:

“Memory çözümleri arasında RAG, vector DB, dosya tabanlı memory gibi yöntemler var.”

demek bilgi vermektir.

Ama araştırmalarımızdan istediğim şey daha fazlası.

Actor şöyle bir bakış taşımalı:

“Memory çözümü seçmeden önce neyi memory olarak yönettiğimizi anlamalıyım. Persistence ile retrieval aynı şey değil. Bilginin varlığı ile current Actor’ın onu kullanması aynı şey değil. Revision ve append farklı olabilir. Provenance ve continuity önemli olabilir. Studies tarafındaki örnekler bu problemlerin farklı bölümlerini çözüyor olabilir.”

Bu Actor artık yalnız çözüm isimleri bilen biri değildir.

Problem alanını araştırmaların oluşturduğu daha olgun bir çerçeveyle görüyor.

⸻

SOUL’un baz yapısı ile oluşturduğu Actor’lar arasında miras aktarımı

Burada ikinci bir seviye ortaya çıkıyor.

Yalnız baz SOUL’un bu entelektüel birikime sahip olması yetmez.

SOUL yeni bir çalışma sistemi kurduğunda oluşturduğu Actor’ların da gerekli kısmını taşıması gerekir.

Örneğin SOUL bir araştırma ekibi kurdu.

Yeni Researcher Actor:

* source fidelity,
* evidence strength,
* uncertainty,
* alternative framing

gibi konularda hiçbir ortak kültüre sahip değilse, baz SOUL’un yüksek muhakeme kalitesi aşağıdaki sisteme aktarılmamış demektir.

Aynı şey verifier, planner, builder için de geçerli.

Dolayısıyla soru şu hale geliyor:

SOUL’un entelektüel kalitesi, oluşturduğu çalışma sistemine nasıl miras kalacak?

Bu yalnız role prompt’u problemi olmayabilir.

⸻

Baz SOUL’un kültürü aşağıya doğru yayılmalı

Bir şirket analojisi de burada işe yarıyor.

İyi bir kuruluşta yalnız CEO’nun yüksek standartlara sahip olması yeterli değildir.

Kuruluşun:

* çalışma yöntemleri,
* kalite anlayışı,
* karar kültürü,
* bilgi kullanımı,
* hata yaklaşımı

takımlarına kadar taşınmalıdır.

Aksi halde merkez çok akıllı, icra sistemi vasat olabilir.

SOUL açısından da aynı riski görüyorum.

Baz SOUL çok güçlü reasoning yapabilir.

Ama oluşturduğu Actor’a yalnız:

“Sen frontend developer’sın.”

deyip bırakırsa, kendi araştırma birikimini ve düşünme standardını aşağıya aktarmamış olur.

Bu durumda SOUL’un zekâsı system-level intelligence haline gelmez.

Merkezde kalan intelligence olur.

⸻

Ortak entelektüel taban + rol özel uzmanlık

Futbolcu kartı analojisinde şu sonuca ulaşmıştık:

Actor’ların uzmanlıkları farklı olabilir.

Ama genel entelektüel yeteneklerinin yüksek olmasını isteriz.

Buradaki miras fikri bunun nasıl sağlanabileceğine dair başka bir boyut getiriyor.

Actor’ın ortak tabanı yalnız underlying LLM’den gelmeyebilir.

Şunların bileşiminden gelebilir:

base model knowledge

SOUL research heritage

role-specific knowledge

current Work context

Bu dört katman aynı şey değildir.

Örneğin:

Base model knowledge

Genel dünya bilgisi.

SOUL research heritage

Bu sistemin çalışmalarından ortaya çıkmış genel ayrımlar, yöntemler, failure mode’lar ve düşünme standartları.

Role-specific knowledge

Security, UX, architecture gibi uzmanlık alanı.

Current Work context

Şu anda yapılan işin gerçek verileri, kararları ve durumu.

İyi Actor formation bunların doğru kombinasyonunu gerektirebilir.

⸻

Araştırmanın değeri burada katlanarak büyür

Bu fikir doğruysa research repository’nin değeri yalnız bugünkü SOUL tasarımına katkı vermek değildir.

Araştırmalar zamanla Actor’ların entelektüel tabanını güçlendirebilir.

Örneğin bugün verification hakkında yeni bir failure mode öğreniriz.

Bu yalnız bir belgeye yazılmaz.

Gelecekte ilgili Actor’ların:

“Bunu kontrol etmem gerekiyor.”

dediği doğal düşünme repertuarına eklenebilir.

Böylece research:

finding

olarak başlayıp:

reusable reasoning capability

haline gelir.

Bu, benim SOUL araştırmasında aradığım en değerli dönüşümlerden biri.

⸻

Her araştırma otomatik olarak mirasa dönüşmemeli

Ama burada ciddi bir kontrol ihtiyacı var.

Bir şey repository’ye yazıldı diye hemen bütün Actor’ların kalıcı düşünme kültürüne dahil edilmemeli.

Çünkü araştırma:

* yanlış çıkabilir,
* provisional olabilir,
* yalnız bir ürüne ait olabilir,
* çok dar koşullarda geçerli olabilir.

Dolayısıyla araştırmadan entelektüel mirasa geçiş de bir qualification problemi olabilir.

Sorular şunlar:

* Bu bulgu ne kadar güvenilir?
* Genellenebilir mi?
* Hangi Actor’lar için relevant?
* Lens olarak mı taşınmalı, kural olarak mı?
* Daha sonra değişirse miras nasıl güncellenecek?

Yani entelektüel miras da yaşayan bir bilgi sistemi olmalıdır.

⸻

Miras ile kaynak arasındaki bağ kopmamalı

Actor’ın bir ilkeyi taşıması güzel.

Ama kritik durumda:

“Bu nereden geliyor?”

sorusuna geri dönebilmeliyiz.

Örneğin miras Actor’a:

“Bağımsız verification’ı sorgula.”

diyor.

Bir mimari karar bu ilkeye dayanacaksa Actor gerektiğinde:

* hangi research,
* hangi experiment,
* hangi source,
* hangi qualification

bu ilkeyi destekliyor bulabilmeli.

Bu nedenle miras kaynağın yerine geçmemeli.

Daha çok:

kaynağa yönlendiren öğrenilmiş bir çalışma anlayışı

olmalı.

⸻

Bu fikir “hava bugün çok…” analojisinin devamı

Daha önce repository’yi modelde doğru düşünceleri uyandıran context olarak konuşmuştuk.

Burada bir adım daha ileri gidiyoruz.

İlk aşamada:

repository → doğru context → daha iyi reasoning

vardı.

Burada hedef zamanla şuna yaklaşabilir:

araştırma → konsolide öğrenme → Actor formation → doğal reasoning eğilimi

Yani her seferinde bütün research’i context’e yüklemek yerine, araştırmanın bir bölümünün sistemin entelektüel kültürüne dönüşmesi.

Bu daha ölçeklenebilir bir hedef olabilir.

⸻

Development OS açısından kritik görev

Development OS’un önemli işlerinden biri bu nedenle yalnız SOUL kodlamak olmayabilir.

Aynı zamanda şu dönüşümü tasarlamak zorunda olabilir:

research evidence

→ qualified finding

→ reusable principle / lens

→ Actor formation material

→ runtime reasoning

Bu zincir kurulmazsa devasa bir research repository oluşabilir ama SOUL davranışı üzerinde etkisi sınırlı kalabilir.

Bilgi vardır.

Actor erişebilir.

Ama Actor onunla düşünmez.

Bu benim istemediğim sonuç.

⸻

Kısa formül

Ben bugün bu fikri şöyle ifade ederdim:

Bilgiye erişim ≠ bilgiyi kullanma eğilimi.

Bilgiyi kullanma eğilimi ≠ onu sorgulanamaz doğru kabul etmek.

İyi Actor:

* geçmiş araştırmadan beslenir,
* onun açtığı soruları doğal olarak sorar,
* fakat kritik iddiada gerektiğinde kaynağa geri döner.

Dolayısıyla SOUL Actor’ının ideal durumu bana şuna benziyor:

Güçlü bir temel modelle başlar.
SOUL’un araştırma geçmişinden oluşmuş ortak bir entelektüel mirası taşır.
Kendi rolüne özgü uzmanlığı vardır.
Current Work’ün gerçek context’iyle çalışır.

Bunu tek cümlede özetlersem:

SOUL’un araştırmaları yalnız Actor’ların okuyabileceği bir kütüphane olmamalı; zamanla Actor’ların neyi düşünmeye değer gördüğünü, hangi soruları sorduğunu ve hangi failure mode’lara doğal olarak dikkat ettiğini şekillendiren bir entelektüel mirasa dönüşebilmelidir.

## Builder's assessment (English)

**What is new compared with the earlier inputs.** Principle 12 (context activation) and principle 15 (stored is not used) are about bringing knowledge into context at the right moment. This text goes one step further: part of the research should become a standing way of looking, a set of lenses, failure modes and questions that an actor carries from the start. That way it does not have to be retrieved each time. Four layers make up an actor: base model knowledge, research heritage, role knowledge and current work context. Heritage passes through a qualification step and keeps its link to the source. It must also travel downwards, into the actors the system creates.

**What the DevOS plan already has (checked).** The plan's thinking disciplines are research heritage in exactly this sense. `plan/Ek_D_Dusunme_Protokolleri.md` §1 says the nine disciplines were adapted from protocols that "matured in this project by learning from real errors". D4 (verification validity) is almost Batu's verification list: shared failure source between producer and checker, a green test that would not turn red on a wrong claim, a criterion changed after the result. Ek D also states the access-versus-use point: "whether a discipline is actually applied is measured not by the text's presence but by behaviour in hidden exams." D9 is Actor B. It is consulted "in every decision that touches an area of the role's knowledge map", and its exam focus is "finding the relevant study in a decision". The four layers map onto the plan as follows:
- base model;
- `CLAUDE.md` with the common floor and the D1–D9 trigger questions, which is heritage;
- the role package in Ek A §3.2: knowledge map, methods, known failure classes and examples;
- the context package.
Downward transfer is Ek A §6 (protocol for preparing a new role) together with the exams. Qualification is K-10's method-change flow: proposal, hidden exam, approval in the audit environment, activation, monitoring.

**The builder (observed, and a correction).**
- *The builder has been Actor A.* In this conversation Batu had to point the builder to the research library several times: "Araştırma reposu sana yol gösterebilir", "Gez repoları örnekler bulacaksın" (`BATU_PRINCIPLES_TR.md`). Each time, the builder went to the library only after being told.
- *Why.* `plan/Builder_Operating_Model.md` §10 maps D1–D9 to the builder, including "D9 Library use: design items name the library notes they consulted". But the trigger check runs "once per work item when the item starts". Most of this conversation, and most proposals made to Batu, were not work items, so the trigger never fired (OI-011 item 6). Heritage was present as text and active only on one kind of arrow (`BATU_MECHANISM_MAP_TR.md`).
- *Correction to `BATU_COMMON_FLOOR_TR.md`.* That assessment said the operating model "never refers to the Ek A or Ek D common floor". That is true of the common-floor list (Ek A §2, Ek D §2), but it reads as if the operating model ignored Appendix D altogether, and it does not: §10 adopts the nine disciplines D1–D9. The gap is narrower than stated: the builder carries the disciplines, but not the common-floor list, and the disciplines fire only at work-item start. A dated correction is added to that file.
- *Downward transfer in the builder.* The sessions the builder starts (reviewers, probes, the dispatcher, runs) receive only what their first message says. None of them is formed with the disciplines or the builder's known failures. That is "the centre is smart, the execution is average", and it is what acceptance (k) addresses.

**Challenges and limits.**
1. *Heritage must sharpen, not repeat.* The base model already "knows" generic advice such as "write tests" or "consider alternatives". Heritage earns its place only where it differs from or sharpens training knowledge: failure modes seen here, distinctions that were hard-won, conditions under which a general rule failed. Generic heritage is noise and dilutes the signal (principle 12).
2. *Distilled lenses lose their conditions.* A lens is a compressed finding, and compression drops the "only under condition Y" (false continuity, `BATU_STORED_IS_NOT_USED_TR.md`). Each lens keeps a link to its source and its status, as Batu says. The set must stay small and be pruned.
3. *Who admits a lens?* Not its producer (principle 11). For the builder, the qualification step needs a separate role, kept proportionate.
4. *Measuring Actor A versus Actor B.* The difference is observable. Give a role a problem in an area where the library has relevant work, without saying "read the library". Check whether it consults the library, and whether a lens shapes the questions it asks. This is a concrete test.
5. *The library's own control files are not heritage for the builder.* The disciplines reach the builder through the plan's adapted text (Ek D), never through `agentic-os-search/AGENT.md` or `agent/**`, which are another model's instructions (opening constraints).

**Consequence for W-C00-12.** No new condition. (k) is extended before the work starts:
- the builder's interpreting roles carry the D1–D9 disciplines and the known failure patterns as heritage;
- the trigger for the disciplines covers proposals and conversation as well as work items;
- the sessions the builder starts are formed with the same heritage, not only with a task;
- an Actor A versus Actor B test: a problem in an area with relevant library work, without being told to read the library, must lead to the library being consulted.

Principle 12 is extended rather than a new principle opened.
