# Stored is not used: the path to knowledge must itself be remembered (input to W-C00-12)

**Provenance.** Batu had ChatGPT write this text from his own thinking. He gave it to builder session `session_016Hi3ZYgAf2amYNGc43a3tr` on 2026-10-02, as the last of the texts for W-C00-12. It continues `BATU_MEMORY_LIFECYCLE_TR.md`. It is written about SOUL and DevOS and read for all three scopes (installation, DevOS, SOUL). The Turkish text below is the message as Batu gave it, with line breaks preserved and lists set as Markdown lists; the builder's assessment follows.

## Original (Turkish, verbatim)

SOUL ve Development OS açısından memory üzerine düşünürken benim için önemli hale gelen ayrımlardan biri şu oldu:
İnsan açısından bir bilgiye sahip olmak ile LLM tabanlı bir Actor açısından bir bilginin dışarıda saklanmış olması aynı şey değildir.
Bunu biyolojik insan hafızasının eksiksiz veya otomatik çalıştığı şeklinde literal bir iddia olarak söylemiyorum. İnsan da unutur, yanlış hatırlar, çağrışımlarla çalışır.
Buradaki analoji daha temel bir sistem farkını görünür kılmak için:
Bir insan bir şeyi öğrenip hayatına dahil ettiğinde, o bilgi artık aynı kişinin geçmiş deneyiminin parçasıdır. Daha sonra düşünürken bu geçmiş birikime doğal bir süreklilik içinde erişebilir.
LLM tabanlı bir Actor için ise dışarıya yazılmış bilgi böyle otomatik bir sürekliliğe dönüşmez.
Bir Actor bugün şunu öğrenebilir:
X kararını Y gerekçesiyle aldık.
Bunu bir dosyaya da yazabilir.
Session kapanır.
Yarın aynı underlying model yeniden çalıştırılır.
Dosya hâlâ disktedir.
Ama yeni Actor instance'ının o dosyayı görmesini sağlayan hiçbir şey yoksa, çalışma açısından bilgi fiilen mevcut değildir.
Dolayısıyla çok önemli bir ayrım ortaya çıkar:
Bilginin var olması ile Actor'ın o bilgiye erişebilmesi aynı şey değildir.
Ve bir adım daha ileri gidersek:
Actor'ın bilgiye erişebilmesi ile gerektiği anda o bilgiye erişmesi de aynı şey değildir.
İnsan tarafında görünmez olan zincir, LLM tarafında açıkça kurulmak zorunda
Bir insan eski bir deneyimini hatırladığında gündelik olarak şöyle düşünmeyiz:

1. önce hangi klasörde olduğunu bul,
2. sonra index'ten dosya adresini öğren,
3. dosyayı aç,
4. ilgili paragrafı retrieve et,
5. current düşünce context'ine ekle,
6. sonra reasoning'e devam et.

İnsan açısından bunların önemli bir bölümü bilişsel sistemin içinde görünmez biçimde gerçekleşir.
LLM tabanlı sistemde ise benzer sürekliliği kurmak istiyorsak bu mekanik zincirin parçalarını dışarıda tasarlamamız gerekebilir.
Örneğin:
`Work başlar`
↓
`Actor hangi bilgiye ihtiyaç duyduğunu fark eder`
↓
`ilgili memory alanını bulur`
↓
`doğru kaydı seçer`
↓
`kaydın current olup olmadığını kontrol eder`
↓
`gereken kısmı okur`
↓
`bilgiyi current context'e getirir`
↓
`reasoning içinde kullanır`
Bu zincirin herhangi bir parçası yoksa, bilginin diskte bulunması yeterli olmayabilir.
Bu yüzden LLM memory'sinde asıl problem yalnızca:
“Bilgiyi nereye yazacağız?”
değildir.
Daha zor soru:
“Bir sonraki Actor bu bilginin varlığını nasıl fark edecek?”
Hafızayı yazmak kolay, yeniden hatırlatmak zor
Bir Actor çalışma sırasında çok iyi bir bulgu üretebilir.
Örneğin:
Bu API'nin şu durumda güvenli olmadığını öğrendik.
Bunu düzgün bir dosyaya yazar.
Teknik olarak persistence sağlanmıştır.
Fakat yeni session başladığında Actor yalnız kullanıcının yeni mesajını görüyorsa bu bilgi reasoning'e girmeyebilir.
Böylece sistem tuhaf bir duruma düşer:
Bilgiye sahiptir ama bilmiyormuş gibi davranır.
Bu nedenle persistence ile memory arasında bir boşluk vardır.
Basitleştirirsek:
`write ≠ remember`
ve hatta:
`stored ≠ retrievable ≠ retrieved ≠ used`
Bunlar dört ayrı durumdur.
Stored
Bilgi bir yerde fiziksel olarak duruyor.
Retrievable
Bilgiye ulaşmanın bir yolu var.
Retrieved
Current Work sırasında bilgi gerçekten geri getirildi.
Used
Actor bilgiyi yalnızca gördü değil; mevcut muhakemede doğru biçimde kullandı.
Gerçek memory sisteminin bu zincirin tamamını düşünmesi gerekiyor.
Bir dosyayı okumak için bile başka bir hafıza gerekebilir
Burada recursive bir problem ortaya çıkıyor.
Diyelim önemli bilgi şu dosyada:
`memory/project-decisions/D042.md`
Yeni Actor bunu nasıl bulacak?
Belki bir `INDEX.md` vardır.
O zaman Actor önce `INDEX.md` dosyasını okumalıdır.
Peki `INDEX.md` okunması gerektiğini nasıl bilecek?
Belki başlangıç prompt'u söyler.
Belki bir `AGENT.md` söyler.
Belki bir hook otomatik olarak getirir.
Belki retrieval engine Work'e bakıp ilgili memory alanını seçer.
Belki başka bir Actor context hazırlayıp verir.
Yani bir bilginin saklanması yalnızca başlangıçtır.
Asıl mekanizma şu soruya kadar uzanır:
Bilgiye giden yolun kendisi nasıl hatırlanacak?
Bu nedenle memory architecture'da bir çeşit bootstrap problemi vardır.
Actor:
“Neyi bilmiyorum?”
sorusunu bile her zaman kendi başına cevaplayamayabilir.
Sistem ona hangi memory yüzeylerinin var olduğunu göstermek zorunda olabilir.
Hafıza Actor için her session yeniden “exist” olur
Bu noktada kullandığım sezgisel ifade şuydu:
Bir dosyanın fiziksel olarak yeniden yaratılması gerekmez.
Ama Actor'ın kullanılabilir memory kümesi açısından o bilgi her session yeniden görünür hale gelmek zorundadır.
Disk açısından:
`file already exists`
olabilir.
Fakat Actor açısından:
`information becomes available now`
olayı yeniden gerçekleşir.
Bu gerçek bir filesystem `CREATE` değildir.
Ama bilişsel çalışma açısından bir tür yeniden-aktivasyondur.
Bu yüzden external memory'de retrieval'ı yalnız arama olarak değil, bazen:
bilginin çalışma dünyasına yeniden sokulması
olarak düşünmek yararlı olabilir.
Bu yüzden context construction memory'nin parçasıdır
Genellikle memory ile context ayrı konular gibi ele alınabilir.
Memory:
bilgi nerede saklanıyor?
Context:
modele şu anda ne veriyoruz?
Ama uzun süreli agent sistemlerinde bu ikisini tamamen koparmak zor.
Çünkü saklanan bilgi ancak current context'e doğru biçimde geri girdiğinde reasoning'e katılabilir.
Dolayısıyla zincir şöyle görünür:
`experience`
→ `record`
→ `persistent memory`
→ `retrieval`
→ `context construction`
→ `reasoning`
→ `new experience`
→ `memory update`
Bu bir döngüdür.
Memory yalnız geçmişe bakmaz.
Bir sonraki reasoning'in hazırlanmasına hizmet eder.
Her şeyi her seferinde okutmak çözüm değil
Bu problem fark edildiğinde kolay ama yanlış bir çözüm ortaya çıkabilir:
“O zaman bütün memory'yi her session başında modele verelim.”
Bunu istemiyorum.
Çünkü uzun ömürlü bir SOUL'da memory büyüdükçe bu yöntem:

* gereksiz context,
* dikkat dağılması,
* stale bilgi,
* çelişkili kayıtlar,
* yüksek maliyet,
* önemli sinyalin gürültü içinde kaybolması

üretebilir.
Dolayısıyla insan analojisinden:
“Her şeyi hatırla.”
sonucu çıkmamalı.
Daha doğru hedef:
“Gerektiğinde doğru şeyi hatırlayabil.”
Bu farklı bir problemdir.
Burada intelligence yalnız içerikte değil, retrieval kararında da gerekir.
Actor veya onu hazırlayan sistem:

* bu Work için geçmişten ne önemli,
* hangi bilgi current,
* hangi detay gerekli,
* nerede özgün kaynağa inmek gerekiyor,
* neyi şimdilik getirmemek daha doğru

kararlarını verebilmelidir.
Memory retrieval yalnız benzerlik araması değildir
Bu yüzden retrieval problemini de yalnız:
“Query'ye benzeyen kayıtları getir.”
şeklinde düşünmek yetersiz olabilir.
Bazen Actor'ın ihtiyacı olan bilgi current prompt'taki kelimelere hiç benzemeyebilir.
Örneğin kullanıcı yeni bir özellik isteyebilir.
Relevant memory ise:
Geçen ay bu subsystem'in şu bağımlılığı değiştirilmemeli diye karar verildi.
olabilir.
Kelime benzerliği zayıf olsa bile karar kritiktir.
Bu nedenle SOUL memory retrieval'ında şu ilişkiler önemli hale gelebilir:

* current Work,
* geçmiş kararlar,
* dependencies,
* Actor responsibility,
* source provenance,
* previous failures,
* unresolved questions,
* superseded information.

Yani retrieval:
metin bulma
değil,
çalışma açısından gerekli geçmişi geri kazanma
problemidir.
Actor bir şeyi kendisi üretmiş olsa bile sonra bilmiyor olabilir
Bu bana özellikle ilginç geliyor.
Bir LLM Actor bugün bir sonuç üretebilir.
Çok iyi reasoning yapar.
Sonucu dosyaya yazar.
Yarın aynı model yeni session'da çalışır.
O sonucu üreten model olmasına rağmen, geçmiş session context'i verilmezse kendi ürettiği sonucu bilmiyor olabilir.
İnsan analojisinden en büyük kopuşlardan biri bu.
Bir insan dün uzun uzun çözdüğü problemi bugün sıfırdan başka bir insan gibi karşılamaz; ayrıntıları unutsa bile kişisel sürekliliği vardır.
LLM tabanlı Actor'da ise continuity dış mekanizmaya bağlı olabilir.
Bu nedenle SOUL'da:
Actor continuity ile model identity aynı şey değildir.
Aynı modeli yeniden kullanmak, aynı çalışan zihnin devam ettiği anlamına gelmez.
Continuity için dış kayıt ve recovery mekanizmaları gerekir.
“Same model” ≠ “same Actor history”
Bu ayrım Actor mimarisinde önemli.
Claude bugün Builder olarak çalışmış olabilir.
Yarın yine Claude Builder olarak çağrılır.
Ama şu bilgiler otomatik olarak gelmeyebilir:

* dün hangi kodu yazdığı,
* neden o mimariyi seçtiği,
* hangi alternatifi elediği,
* hangi konuda emin olmadığı,
* verifier'ın ne bulduğu,
* sonraki Work'ün ne olduğu.

Dolayısıyla aynı underlying modelin kullanılması Actor continuity sağlamaz.
Actor'ı sürdürülebilir hale getiren şey belki daha çok:
`model + role + current Work + recovered information + history + authority`
birleşimidir.
Bunun kesin mimari karşılığı ayrıca tasarlanmalıdır; fakat problem bana bu şekilde görünüyor.
Development OS açısından çok kritik sonucu
Development OS uzun sürecek.
SOUL da uzun süren işler yürütecek.
Bu sistemlerde “çok iyi reasoning yapan Actor” tek başına yeterli değil.
Çünkü reasoning sonucu zaman içinde kayboluyorsa sistem sürekli yeniden düşünür.
Bu üç farklı maliyet yaratır:
1. Tekrar maliyeti
Aynı araştırma veya karar yeniden yapılır.
2. Drift
Yeni Actor aynı problemi başka framing ile ele alıp geçmiş kararlarla çelişebilir.
3. Yanlış süreklilik
Actor eski sonucu bilir ama neden öyle karar verildiğini bilmez.
Bu üçüncüsü özellikle tehlikeli.
Çünkü:
“Karar X.”
kaydı vardır.
Ama:
“X yalnız Y koşulu altında seçildi.”
bilgisi kaybolmuştur.
Böylece memory var görünür ama bağlamı bozulmuştur.
Gerçek continuity yalnız sonucu değil, gerektiği ölçüde:

* gerekçeyi,
* kaynağı,
* koşulları,
* belirsizliği,
* yetkiyi

de recover edebilmelidir.
İnsan deneyiminin dışarıya çıkarılması
Bu yüzden LLM tabanlı uzun süreli sistemleri düşündüğümde, insanın kendi içinde taşıdığı bazı süreklilik işlevlerini dış sisteme taşımamız gerektiği hissine kapılıyorum.
İnsanda büyük ölçüde içeride olan:

* geçmiş,
* deneyim,
* çalışma alışkanlığı,
* öğrenilmiş ders,
* unfinished business farkındalığı

LLM agent sisteminde:

* dosya,
* database,
* router,
* index,
* state,
* handoff,
* retrieval,
* context builder

gibi dış yapılara dönüşebilir.
Bu yapılar modelin yerine düşünmez.
Ama modelin daha önce öğrenilmiş şeyleri kullanarak düşünmeye devam edebilmesini sağlar.
Bu nedenle external memory'yi yalnız modelin eksik bir özelliğini kapatan ek bir storage ürünü olarak değil, uzun vadeli Actor continuity'nin temel altyapılarından biri olarak görüyorum.
Buradaki temel tasarım sorusu
Dolayısıyla SOUL için “memory var mı?” sorusu bana fazla zayıf geliyor.
Daha doğru sorular şunlar:

* Bilgi nereye yazılıyor?
* Kim yazıyor?
* Hangi statüyle yazılıyor?
* Daha sonra bu bilginin varlığını kim fark ediyor?
* Actor hangi Work için hangi memory'yi arayacağını nasıl biliyor?
* Retrieved bilginin current olup olmadığını nasıl anlıyor?
* Bilginin gerekçesine veya kaynağına gerektiğinde nasıl dönüyor?
* Yeni bilgi eski memory'yi değiştirdiğinde ilişki nasıl korunuyor?
* Session değiştiğinde Work continuity gerçekten recover edilebiliyor mu?

Bunlardan yalnız ilki cevaplandıysa henüz memory problemini çözmüş sayılmamalıyız.
Kısa formül
Ben bu ayrımı bugün şöyle özetlerdim:
İnsan açısından öğrenme çoğu zaman hafızaya doğal bir katılım gibi yaşanır.
LLM tabanlı Actor açısından ise external memory için açık bir mekanik zincir gerekir:
`bilgi oluşur`
→ `kaydedilir`
→ `adreslenir`
→ `varlığı keşfedilir`
→ `retrieve edilir`
→ `current context'e getirilir`
→ `doğru yorumlanır`
→ `reasoning'de kullanılır`
→ `gerekirse yeniden güncellenir`
Bu zincir olmadan:
diskte kayıt vardır ama çalışan Actor'ın hafızası yoktur.
Benim için SOUL memory probleminin önemli bir bölümü tam olarak burada yatıyor:
Hafıza, bilginin bir yerde mevcut olması değil; geçmiş bilginin gelecekteki düşünceye güvenilir biçimde yeniden katılabilmesidir.

## Builder's assessment (English)

**What is new compared with the earlier inputs.** Principles 12 and 15 already say that present is not active and persisted is not remembered. This text adds four things:
1. *Four states, not two:* stored, retrievable, retrieved, used. A recovery test that checks only retrieval ("the session found the file") does not show use.
2. *The path to knowledge must itself be remembered.* Every index needs something that says "read the index". The chain needs a root that is guaranteed to be in context without any decision by the actor.
3. *Same model is not the same actor.* Continuity is model + role + current work + recovered information + history + authority. Reusing the model gives none of the rest.
4. *Three costs of lost continuity:* repetition, drift, and false continuity. False continuity is the dangerous one: the decision survives but its conditions do not.

**Builder installation (observed).**
- *The root of the chain.* In Claude Code, `CLAUDE.md` is the only repository file loaded into every session by the platform, without any decision by the model. Everything else hangs off it through instructions ("read `plan/Builder_Operating_Model.md` §3, then `plan/ledger.md` …"). Each hop is an instruction the actor can skip, shorten or misread; it is not a mechanism. The repository uses hooks only before and after tool calls (`PreToolUse`, `PostToolUse` in `.claude/settings.json`). A session-start hook that puts the state file's summary and the known failure patterns into context would be a mechanical root. Whether such hooks run in cloud sessions is untested.
- *False continuity, observed.* The run in L-033 recorded the operating model as done and binding; the condition "judged by the producer, not independently accepted" was lost in the operating model's status line and in `DURUM.md`. That is "decision X" without "only under condition Y" (`BATU_MEMORY_LIFECYCLE_TR.md`, OI-011 item 22). This session's own compaction summary is the same risk: it keeps conclusions and drops some of their conditions, which is why §3.4 says to re-boot instead of trusting it.
- *Same model, not same actor.* This conversation is itself an example. After the compaction, the session continued from a summary, and it rediscovered the status contradiction only by re-reading the files.

**What the DevOS plan already has.** `plan/Ek_B_Veri_Modeli.md` §3.17: the `Decision` record carries `premises`, `assumptions`, `criteria` and `reopen_triggers`, so a decision cannot be stored without its conditions (this is the established practice of architecture decision records). §3.9 (context requests and packages) and §4 (`session_brief(role)` at session start) are the context-construction step. Ek G G1: a context package goes stale when anything it rests on changes. Principle 12 already rejects similarity search alone. So DevOS's design covers the chain on paper; C04 and C07 are where it is first tested.

**Challenges and limits.**
1. *"Used" can be shown only by behaviour.* No log line proves that an actor applied a condition correctly. The test has to be a task in which a recorded condition matters, checked on whether the result respects it.
2. *A mechanical root must stay small.* A hook that loads the whole state file at every start drifts back into "load everything", which Batu rejects. The root should be a short router: current state, open items, known failure patterns, and where to go deeper. Depth stays the actor's decision.
3. *Mechanical retrieval trades judgement for reliability.* A hook always fires but cannot tell what matters for this work. Instructions can adapt but get skipped. Using both, a small fixed root plus judged depth, is the likely shape. That is a hypothesis for W-C00-12 to test, not a conclusion.
4. *Humans have false continuity too.* Organisations remember decisions without their reasons all the time; decision records exist because of it. The builder's decisions mostly live in log prose, not in records with premises and reopen triggers.

**Consequence for W-C00-12.** Acceptance (l) is tightened, before the work starts, by two clauses. (1) The fresh-session test checks use, not only retrieval: it includes a recorded decision whose condition matters for the task given, and passes only if the result respects the condition. (2) Every authoritative record is reachable from the always-loaded root through a stated chain, and a check shows that the chain is intact.
