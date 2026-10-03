# The first work is finding the work: intent, need, discovered, admitted, ready (input to W-C00-12)

**Provenance.** Batu had ChatGPT write this text from his own thinking. He gave it to builder session `session_016Hi3ZYgAf2amYNGc43a3tr` on 2026-10-03 as the last text of this series, for all three scopes (installation, DevOS, SOUL). The Turkish text below is the message as Batu gave it, with line breaks preserved and lists set as Markdown lists; the builder's assessment follows.

## Original (Turkish, verbatim)

SOUL üzerine düşünürken büyük işlerle ilgili önemli bir farkındalık ortaya çıkmıştı:

Kullanıcı bir hedef söylediğinde, sistemin ilk işi çoğu zaman o hedef üzerinde doğrudan çalışmaya başlamak değildir.

İlk iş:

Gerçekte hangi işlerin yapılması gerektiğini ortaya çıkarmaktır.

Bunu ilk fark ettiğimde şu şekilde ifade etmiştim:

“Aslında ilk iş işi yapmaya başlamak değil, işi ortaya çıkarmak oldu galiba.”

Bu ayrım bana göre SOUL ile sıradan task-execution agent arasında temel bir fark yaratıyor.

⸻

Ham talep Work değildir

Bir kullanıcı şöyle diyebilir:

“Bir eğitim yılı boyunca kullanılacak kapsamlı bir 4. sınıf matematik soru bankası üret.”

Bunu doğrudan task listesine çevirmek çok kolaydır:

1. Müfredatı araştır
2. Soruları yaz
3. Kontrol et
4. Yayınla

Ama burada sistem çok düzenli biçimde yanlış işi yapabilir.

Çünkü henüz bilmiyoruz:

* hangi müfredat,
* kim kullanacak,
* “kapsamlı” ne demek,
* çözümler gerekiyor mu,
* dijital mi basılı mı,
* kaliteyi kim kabul edecek,
* hangi yasal kısıtlar var,
* yıl boyunca güncellenecek mi.

Dolayısıyla:

request received

ile:

work understood

aynı şey değildir.

⸻

İlk Work bazen Mission Qualification’dır

Bu durumda ilk production Work soru yazmak olmayabilir.

İlk Work şöyle olabilir:

Mission Qualification

Yani sistem önce hedefin yeterince anlaşılmasını sağlamaya çalışır.

Bu da gerçek bir Work’tür.

Örneğin:

* hedef kullanıcıyı netleştir,
* müfredat otoritesini belirle,
* başarı kriterini tanımla,
* yayın biçimini netleştir,
* kabul mekanizmasını belirle.

Bu noktada henüz ürün üretilmiyor olabilir.

Ama sistem boş durmuyor.

Çalışılabilir bir çalışma sistemi oluşturuyor.

Bu ayrım önemli.

⸻

Need ile Work aynı şey değil

Sonra daha derin bir ayrım çıktı.

Sistemin ilk sorusu bile doğrudan:

“Hangi task’ları yapacağız?”

olmamalı.

Daha önce şu soruyu sorması gerekebilir:

“Hedefin gerçekleşmesi için dünyada hangi koşulların doğru hale gelmesi gerekiyor?”

Örneğin:

* içerik doğru müfredatı kapsamalı,
* sorular pedagojik olarak uygun olmalı,
* matematiksel doğruluk sağlanmalı,
* yayın ortamı hazır olmalı,
* hatalar sonradan düzeltilebilmeli.

Bunlar henüz task değildir.

Bunlar:

Need / required condition

seviyesindedir.

Bir condition’ı sağlamak için farklı yöntemler olabilir.

Dolayısıyla daha doğru zincir şu olabilir:

Target

→ Needs / Conditions

→ Possible Methods

→ Decisions

→ Work

→ Actions

Bu ayrım önemli çünkü otherwise ihtiyacı task sanıp erken çözüm seçebiliriz.

⸻

Work discovery’nin kendisi Work’tür

Büyük işlerde yapılması gereken işlerin tamamı başlangıçta görünmeyebilir.

Örneğin:

Doğru kapsam için authoritative curriculum lazım.

Buradan yeni Work çıkar:

Curriculum’u edin ve analiz et.

Bu Work yapılırken öğreniyoruz ki:

Müfredatta prerequisite ilişkileri var.

Yeni ihtiyaç çıkıyor.

Yeni Work:

Prerequisite ilişkilerini analiz et.

Bu Work başka bir ihtiyacı ortaya çıkarabilir.

Dolayısıyla:

Work discovery

tek seferlik planning fazı değildir.

Şöyle recursive bir yapı oluşabilir:

bir Work keşfet

→ çalış

→ yeni gerçeklik öğren

→ yeni ihtiyaç fark et

→ yeni Work keşfet

→ devam et

Bu yüzden SOUL’un Work modeli tamamen başlangıçta oluşturulmuş bir task graph olmamalı.

⸻

Plan Work değildir

Burada başka kritik bir ayrım var:

Plan, Work’ün kendisi değildir.

Plan büyük ölçüde Work hakkında Information’dır.

Örneğin PLAN.md:

Curriculum analysis complete.

yazabilir.

Ama gerçek Work hâlâ yapılmamış olabilir.

Bu yüzden:

planned

admitted

ready

executing

completed

gibi durumları birbirine karıştırmamak gerekir.

Aksi halde çalışma temsilini gerçek çalışma sanabiliriz.

⸻

Keşfedilen her Work hemen yapılmamalı

SOUL bir Work ihtiyacı fark etti diye o Work otomatik olarak yürütülmemeli.

Örneğin:

500 öğretmenle pilot yapalım.

faydalı olabilir.

Ama:

* çok pahalı olabilir,
* scope dışı olabilir,
* authorization gerektirebilir,
* başka yöntemle aynı ihtiyacı karşılamak mümkün olabilir.

Dolayısıyla şu ayrım gerekir:

Discovered Work

→ Proposed Work

→ Qualified / Selected

→ Admitted Work

Bu önemli çünkü faydalı görünen iş ile yapılmasına karar verilen iş aynı şey değildir.

⸻

Admitted Work bile Ready olmayabilir

Bir Work kabul edilmiş olabilir ama henüz başlanabilir olmayabilir.

Örneğin:

Curriculum interpretation

yapılması gerektiği kabul edilmiş olsun.

Ama authoritative curriculum source henüz elde edilmemişse Work ready değildir.

Dolayısıyla readiness başka bir durumdur.

Gerçek readiness kabaca şu koşulları içerebilir:

* gerekli prerequisite Work tamamlandı mı,
* gerekli Information var mı,
* uygun Actor var mı,
* Environment gerekli capability’yi sağlıyor mu,
* Control execution’a izin veriyor mu.

Yani:

OPEN

ile:

READY

aynı şey değildir.

⸻

“Sıradaki task” yerine actionable frontier

Büyük işlerde tek bir next task olmayabilir.

Aynı anda birkaç Work başlanabilir durumda olabilir.

Örneğin:

* curriculum araştırması,
* pedagojik araştırma,
* production-capacity değerlendirmesi,
* publication ortamı araştırması

paralel ilerleyebilir.

Bu yüzden daha doğru model:

Actionable Frontier

olabilir.

Yani:

Şu anda hangi Work’ler gerçekten başlanabilir?

Ama burada bile bir ayrım var.

Ready

demek:

High priority

demek değildir.

High priority

demek:

Selected

demek değildir.

Selected

demek:

Assigned

demek değildir.

Assigned

demek:

Executing

demek değildir.

Bu durumları birbirine karıştırmamak gerekir.

⸻

Actor listesi bile Work’ten türemeli

Bu yaklaşım Actor tasarımını da değiştiriyor.

Başlangıçta şunu yapmak kolay:

Researcher lazım, verifier lazım, coordinator lazım.

Ama bunlar hayal edilmiş roller olabilir.

Daha sağlam yol şu:

Work demand

→ required capability

→ role

→ Actor

Yani önce gerçek Work ihtiyacı ortaya çıkar.

Sonra o Work’ün hangi capability’ye ihtiyacı olduğu anlaşılır.

Sonra role tasarlanır.

Sonra Actor oluşturulur.

Bu, Actor yapısının kullanıcı veya tasarımcının kafasından değil, işin gerçek talebinden türemesini sağlar.

⸻

SOUL neden task runner değildir?

Bu farkın özü burada.

Task runner’a şu verilir:

Bunları yap.

SOUL’dan beklediğim daha zor:

Hedef bu.
Önce hangi koşulların gerekli olduğunu keşfet.
Sonra hangi Work’lerin gerektiğini çıkar.
Hangi Work’lerin gerçekten kabul edilmesi gerektiğini değerlendir.
Hangilerinin ready olduğunu bul.
Sonra doğru Actor yapısını oluştur ve execution’a geç.

Bu nedenle SOUL’un zekâsı yalnız task execution’da ölçülmemelidir.

Belki daha zor capability şudur:

Doğru Work’ü bulmak.

⸻

Planning başlangıçta biten bir faaliyet değildir

Bu modelde planning şöyle olmaz:

plan hazırla

→ execution

→ bitir

Daha çok:

anla

→ Work keşfet

→ plan oluştur

→ çalış

→ öğren

→ yeni Work keşfet

→ planı değiştir

→ devam et

Bu yüzden planning bütün yaşam döngüsüne dağılır.

Bir anlamda Work discovery, SOUL’un sürekli çalışan fonksiyonlarından biri olur.

⸻

Development OS açısından anlamı

Development OS’un da aynı hataya düşmemesi gerekir.

Hedef:

SOUL’u yaratmak.

Bundan doğrudan:

memory sistemi yap,
agent yap,
UI yap,
orchestration yap

gibi task listesi çıkarmak erken olabilir.

Development OS’un ilk gerçek işi şudur:

SOUL’un ortaya çıkabilmesi için hangi koşulların, mekanizmaların ve Work’lerin gerektiğini keşfetmek.

Bu yüzden Development OS’un ilk Work’lerini ne kullanıcı tek başına, ne de tek bir assistant tek başına uydurmalı.

Kurulan çalışma sistemi:

* araştırmalardan,
* Foundation’dan,
* geçmiş exploration’lardan,
* mevcut hedef ve kısıtlardan

yararlanarak onları ortaya çıkarmalı.

Yani Development OS’un değerini gösteren ilk şey:

“SOUL’u yaptı.”

olmadan önce:

“SOUL’u yapmak için doğru işi bulabildi.”

olabilir.

⸻

Kısa formül

Bunu bugün şu ayrımla ifade ederdim:

Intent ≠ Work.

Need ≠ Work.

Discovered Work ≠ Admitted Work.

Admitted Work ≠ Ready Work.

Ready Work ≠ Selected Work.

Selected Work ≠ Executed Work.

Ve en önemlisi:

Work discovery’nin kendisi de Work’tür.

Büyük bir hedef geldiğinde SOUL’un ilk sorusu:

“Ne yapmaya başlayayım?”

değil,

“Bu hedefin gerçekleşmesi için gerçekte hangi işlerin yapılması gerektiğini nasıl keşfederim?”

olmalıdır.

Benim için bu, SOUL’u sıradan bir task-execution sisteminden ayıran temel özelliklerden biridir.

## Builder's assessment (English)

**The DevOS plan already has almost all of this (checked).** `plan/DevOS_Kurulum_Plani.md` K-1 ("Doğru işi keşfetmek") is this text as a mechanism:
- a `Need` record that carries its parent goal, whether it is required by the goal or only by the chosen method, evidence for and against, alternatives and readiness;
- a discovery protocol (role DR01, `methods/rpd.md`) that writes the raw request beside its current interpretation and searches alternative methods, each with its own prerequisites;
- a frame review by a clean session that did not do the discovery.
DR01's output includes "the startable discovery frontier", which is Batu's actionable frontier. `plan/Ek_B_Veri_Modeli.md` §3.3 keeps execution, qualification, acceptance and effect as separate axes, and readiness is a query result re-checked at claim time. Batu's chain is Recursive Prerequisite Discovery, the method acceptance (a) of W-C00-12 already names. The protocol also covers the risk on the other side of Batu's text: an *unnecessary-prerequisite brake* (K-1 item 3). Every prerequisite must answer "which decision or action would be wrong without this?", or it is rejected. There is also a *stop rule* (item 5): proceed when the remaining uncertainty does not materially change the currently authorised action.

**The builder (observed).**
- *W-C00-12 is mission qualification for the builder.* Acceptance (a) asks for a goal-down look before any design. That already applies this text.
- *The builder's work list collapses the states.* The status column of `plan/ledger.md` holds free text: "todo", "todo (heavy)", "todo (first)", "done", "done (v1)" and one long sentence. Discovered, admitted, ready, selected, executing, finished and accepted are not separated. The single "Next action" row is one next task, not a frontier. The W-C00-05 status contradiction (OI-011 item 22) is partly this: "done" was used where "finished, not accepted" was true.
- *Roles imagined before demand.* The builder created the dispatcher session and the heartbeat routine to start runs without Batu, before the work they serve was understood. It then had to disable the routines that drive them, leaving the dispatcher session idle, because the structure under them was weak (L-034). Under this text, they must be derived again from a demonstrated work demand, or removed.

**Challenges and limits.**
1. *Discovery has its own failure mode.* Batu's text warns against executing too early. Its mirror is discovering too long. K-1 answers with the unnecessary-prerequisite brake and the stop rule, and both apply to the builder now.
2. *A stop-rule reading of this conversation.* The installation has been on hold since 2026-10-02 12:03Z while inputs were gathered.
   - The early inputs changed the design materially: terminal goals, context activation, common floor, memory and growth with framing (the counter-design gap).
   - The last three, the living plan, heritage and this one, were largely covered by the plan already. They confirmed and sharpened; they did not redirect.
   - Under K-1's stop rule, that is the signal that input-gathering for W-C00-12 has reached its useful end, and the work itself should start. Batu has also said this text is the last of the series.
3. *Separating states costs effort.* Seven states for a list of twelve items is bureaucracy. Proportionate for the builder: separate only the states whose confusion has caused a failure. Those are finished versus accepted (W-C00-05) and discovered versus admitted (roles created before demand). Ready versus selected can wait until there is real parallel work.

**Consequence for W-C00-12.** No new condition. Before the work starts:
- (a2) is extended: the work list separates at least "finished" from "accepted" and "discovered" from "admitted", and the Next action row becomes the list of currently startable items.
- (g) is extended: every builder role, including the dispatcher and the heartbeat, is traced to a demonstrated work demand, or removed.
