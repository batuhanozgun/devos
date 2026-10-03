# The working system as a program: a mechanism map, base steps and on-demand helpers (input to W-C00-12)

**Provenance.** On 2026-10-02/03 Batu gave builder session `session_016Hi3ZYgAf2amYNGc43a3tr` two pieces, for all three scopes (installation, DevOS, SOUL). The first is his own chat message introducing the text: base mechanism versus on-demand helper mechanisms (the enzyme or catalyst analogy). The second is a text he had ChatGPT write from his own thinking: the program analogy. Both are given verbatim in Turkish, with line breaks preserved and lists set as Markdown lists, and the builder's assessment follows.

## Original 1: Batu's chat message (Turkish, verbatim; spelling slips kept)

Evet, hattın değişmesi için yöntem belli ama o yöntemin mekanizmada ne zaman devreye gireceği de tanımlı olmalı, mekanizmanın kalıcı bir adımı mı yoksa ajanın ihtiyaç duyduğu bir anda çağrılan bir mekanizma mı? Bunu basit -belki saçma- bir örnekle anlatayım. İş benim sana yazı yazmam olsun, kurulumu yapmak için şu an konuşmamız gib, mekanizma ne ben yazarım, sen okursun, düşünürsün, işine yarayabilecek fikirleri kullanmak için kurulum aşamasında bulabileceğin yerlere yazarsın, sonra kurulumda zamanı geldiğinde okursun, belki değerli bulursan ya da ihtiyaç görürsen bununla ilgili kurulum pipeline’ına bir yapı, dosya, mekanizma adına ne dersen onu kurarsın. Bu örnek tabi şu anda bu tanımlı bir çalışma şekli ya da bir mekanizma değil be mesaj yazdığım anda sen böyle tanımlanmış bir akış işletmiyorsun ama bağlam seni böyle yönlendiriyor, yazdıklarımla birlikte bağlamı da alıp bu yönde davranmanı sağlayam bir çıktı veriyorsun. Benim bahsettiği bu yapının kapıt üstünde tanımlı olması. Devam edeyim asıl vermek istediğim örneğe. Ben yazarken benim açımdan “benim mekanizmam” da şu, düşünürüm, okurum, araştırırım, yazacağım şeyin sendeki uyandıracağı bağlamları, token’ları düşünürüm, aklımdaki akıl yürütme yapımda yazacaklarımı değerlendirirm, yeniden düşünürüm daha uygun, mesajın sende uyandıracağı şeyler tahmin etmeye çalışarak düzenlerim ve yazarım. Bunu benim yazma mekanizmam olarak düşünelim. -gerçekten de niraz böyle- ama sana yazarken bazı kelimelerin nasıl yazıldığını hatırlayamayabilirim, yazımına bakmak için sözlüğe bakıp, hatırlayıp ya da öğrenip ya da bazen kelimeyi bilmesem bile olguyu bilip başka bir LLM’e “şu şu anlama gelen bir şey var mı?” diye sorar, terimi ya da kavramın formal ya da official halini öğrenir sonra sana mesaj yazmaya o terimi kullanarak devam ederim. Ama benim sabit mekanizmamda her kelimeyi sözlükten bakarak yazmak diye bir mekanizma olmaz ama mekanizmamın içinde bir şey yazarken yazmak istediğim şeyi yazabilmek için gerektiğinde çalıştırdığım ek ya da yardımcı mekanizmalar vardır. Bu sayede asıl iş olan yazma işini daha kaliteli hale getirmemi sağlayabilirim. Bu mekanizma ben yazmaya başladığımda otomatik çalışmaz ama orda öyle bir mekanizmam olduğunu bilirim. Yani mekanizmamım bütününde yetkinlik ve yeteneklerim tanımlı ve baz bir çalışma düzenim vardır (buradaki çalışmak, sadece yaratmak değil, sadece yazmak değil, düşünmek de çalışmanın bir adımı, ilk andan son ana kadar çalışma bütün olarak ela alıyorum) bu baz çalışma düzenin içinde ek, yardımcı, destekleyici mekanizmalar vardır. Tıpkı biyolojideki enzimler gibi sanırım katalizör deniyordu onlara.

İşte bunu anlatan bir yazı aslında vereceğim yazı. Tani ki hem senin hem devos’un hem de soul’un içinde kullanabileceğin bir bakış açısı olabilir diye veriyorum.

## Original 2: the program analogy (Turkish, verbatim)

SOUL üzerine düşünürken bir noktada aklıma şu analoji gelmişti:

Biz LLM ile doğal dil üzerinden konuşuyoruz. Kullanıcı kelimelerle bir talep veriyor; model yine kelimelerle cevap veriyor veya GitHub’a bağlanmak, dosya oluşturmak, araç çağırmak gibi aksiyonlar alıyor.

Yüzeyden bakıldığında bu oldukça “insansı” veya akışkan görünüyor.

Ama biraz daha mekanik bakınca ortada aslında şuna benzeyen bir yapı var:

girdi → çalışan yapı → çıktı

Bu açıdan SOUL’un çalışma biçimini bir programın çalışma mimarisine benzetmiştim.

Bu, “SOUL aslında deterministik bir yazılımdır” demek değildir.

LLM’in üretimi olasılıksaldır; aynı input her zaman birebir aynı output’u vermeyebilir.

Analojinin amacı başka:

SOUL’un davranışını oluşturan görünmez parçaları ve aralarındaki geçişleri, bir programın mimarisini inceler gibi açık hale getirebilir miyiz?

⸻

Bir programı neden anlayabiliyoruz?

Bir yazılım sistemini incelerken yalnız son çıktıya bakmayız.

Şunları görebiliriz:

* input nereden geliyor,
* hangi modül önce çalışıyor,
* hangi fonksiyon hangi fonksiyonu çağırıyor,
* hangi veri nerede okunuyor,
* hangi koşul hangi branch’e götürüyor,
* hangi çıktı başka bir modülün girdisi oluyor,
* hata halinde hangi yol izleniyor.

Örneğin çok kabaca:

input

→ validate

→ process

→ database

→ result

gibi bir akış olabilir.

Daha karmaşık sistemde bir modül başka dosyadaki fonksiyonu çağırır.

O fonksiyon başka bir veri kaynağını okur.

Onun çıktısı ilk akışa geri döner.

Programı yalnız ekrandaki sonuç olarak değil, birbirine bağlı çalışan mekanizmalar bütünü olarak görürüz.

Ben SOUL’a da buna benzer gözle bakmanın faydalı olabileceğini düşündüm.

⸻

LLM Actor’da da aslında bir çalışma zinciri var

Bir Actor’a kullanıcı talebi geldiğinde yalnızca kullanıcının son mesajı çalışmıyor.

Actor’ın davranışını etkileyebilecek birçok başka girdi olabilir:

* sistem talimatları,
* project instructions,
* conversation history,
* current Work,
* repository state,
* AGENT.md gibi yönlendiriciler,
* ilgili protokoller,
* kullanıcı mesajındaki tokenlar,
* retrieval sonucu getirilen bilgi,
* tool çıktıları,
* başka Actor’lardan gelen sonuçlar.

Dolayısıyla yüzeyde:

Kullanıcı → LLM → cevap

gibi görünen şey gerçekte daha çok şuna benzeyebilir:

User request

→ control/context

→ state recovery

→ relevant information

→ reasoning

→ tool/action

→ new evidence

→ reasoning

→ output

Bunun tam sırası ve yapısı sistem tasarımına göre değişebilir.

Ama önemli nokta şu:

Modelin cevabı boşlukta oluşmuyor.

Bir çalışma mekanizmasının içinde oluşuyor.

⸻

AGENT.md başka bir dosyaya yönlendiriyorsa bu bir çağrı ilişkisine benziyor

Analojiyi düşünürken özellikle şöyle bir örnek vermiştim:

Bir programda bir kod parçası başka dosyadaki fonksiyonu çağırabilir.

SOUL benzeri bir sistemde de bir control dosyası:

“Bu durumda şu protokolü oku.”

diyebilir.

O protokol:

“Şu durumda canonical state’e dön.”

diyebilir.

State başka bir araştırma router’ına yönlendirebilir.

Router ilgili kaynağa götürebilir.

Bu teknik olarak function call ile aynı şey değildir.

Ama mimari olarak benzer bir yönlendirme ilişkisi vardır:

A görünür

→ B'yi aktive eder

→ B, C'ye gitmeyi gerektirir

→ C current reasoning'e yeni bilgi getirir

Bu ilişkileri çizilebilir hale getirirsek SOUL’un çalışma biçimi daha az mistik görünür.

⸻

Doğal dil talimatını “işlem sözleşmesi” gibi düşünmek

Örneğin şöyle bir çalışma kuralımız olduğunu düşünelim:

Yeni kullanıcı talebini kaydet; fakat henüz üstlenme kararı verilmediyse aktif Work gibi gösterme.

Bu yalnızca güzel yazılmış bir cümle değildir.

Aslında davranışsal bir mekanizma tarif ediyor.

Bir talep geldi.

Sistem bazı ayrımlar yapmalı:

* talep geldi mi?
* kayda geçti mi?
* değerlendirilmiş mi?
* üstlenildi mi?
* Work’e dönüştü mü?
* plan içinde mi?

Böylece tek bir doğal dil kuralının altında farklı state’ler vardır.

Kabaca:

REQUEST_RECEIVED

→ RECORDED

→ EVALUATED

→ ACCEPTED

→ WORK_ADMITTED

gibi bir akış düşünülebilir.

Bütün bunların gerçek implementasyonda enum veya state machine olması gerektiğini söylemiyorum.

Ama SOUL’u tasarlarken bu şekilde düşünmek çok faydalı olabilir.

Çünkü:

“Agent talebi doğru değerlendirsin.”

gibi soyut bir cümle yerine:

“Hangi bilgi hangi durumda hangi kararı tetikliyor?”

sorusunu sorabiliriz.

⸻

Bir düşünce balonu ile loading ikonunu bağlamak

Ben bunu görsel olarak da hayal etmiştim.

Kullanıcı talebi bir “düşünce balonu” olsun.

Bu balon doğrudan:

“Work başladı.”

kutusuna gitmesin.

Önce bir değerlendirme mekanizmasına bağlansın.

Buradan farklı yollar çıkabilsin:

* talep geldi ama yalnız kaydedildi,
* talep değerlendiriliyor,
* talep reddedildi,
* talep kabul edildi ama henüz planlanmadı,
* talep aktif Work’e dönüştü.

Yani SOUL’un kavramsal ilkelerini görsel bir işlem ağı halinde gösterebiliriz.

Bir kutuya baktığımızda:

* girdisi nedir,
* ne yapar,
* çıktısı nedir,
* hangi koşulda çalışır,
* neyi değiştirebilir

görülebilir.

Bir oka baktığımızda:

* hangi koşul bu geçişi oluşturdu,
* ne taşındı,
* hangi state değişti

sorularına cevap verebiliriz.

Bu, SOUL’u daha incelenebilir hale getirir.

⸻

“Mekanizmayı görmek” neden önemli?

Doğal dil ile sistem tasarlarken ciddi bir risk var.

Bir cümle kulağa doğru gelebilir:

“SOUL önce kullanıcı amacını anlamalıdır.”

Ama bunun gerçekten çalışan bir sisteme karşılığı nedir?

Ne zaman “anlamış” sayılır?

Hangi bilgiye bakar?

Belirsizliği nasıl temsil eder?

Eksik bilgi olduğunda ne yapar?

Ne zaman Work başlatabilir?

Yeni bilgi gelirse eski anlayışı nasıl değiştirir?

Bu sorular cevaplanmadıkça elimizde ilke vardır ama mekanizma olmayabilir.

Program analojisi bizi şunu sormaya zorluyor:

“Tamam, bu ilke sistem içinde nasıl akıyor?”

Bu soru çok değerlidir.

Çünkü soyut prensip ile işletilebilir sistem arasındaki boşluğu görünür hale getirir.

⸻

Her şeyi kodlamak değil, her şeyi ilişkilendirebilmek

Bu analojinin yanlış anlaşılmasını istemem.

Amaç:

“SOUL’daki bütün reasoning’i if/else’e dönüştürelim.”

değildir.

LLM’in değerli taraflarından biri zaten açık uçlu reasoning yapabilmesidir.

Her davranışı deterministik workflow’a kapatırsak SOUL’un asıl yeteneğini kaybedebiliriz.

Benim istediğim daha çok şu:

Olasılıksal reasoning’in hangi sistemsel sınırlar ve bilgi akışları içinde gerçekleştiğini anlayabilelim.

Örneğin Actor’ın hangi cevabı vereceğini önceden bilemeyebiliriz.

Ama şunları belirleyebiliriz:

* hangi kaynakları görmesi gerekiyor,
* hangi authority sınırında,
* hangi Work üzerinde,
* hangi rol amacıyla,
* hangi doğrulama sonrasında,
* hangi state’i güncelleyerek.

Yani:

çıktının içeriği olasılıksal olabilir; çalışma mekanizmasının bazı sözleşmeleri açık olabilir.

Bu ikisini ayırmak önemli.

⸻

Deterministik çevre, olasılıksal düşünme

Bunu daha net formüle edersek:

LLM Actor’ın reasoning’i olasılıksal olabilir.

Ama çevresindeki bazı şeyler daha deterministik tasarlanabilir:

* hangi canonical state okunacak,
* hangi Actor hangi authority’ye sahip,
* hangi Work current,
* hangi kayıt değiştirildi,
* hangi verifier sonucu üretildi,
* hangi kullanıcı kararı mevcut.

Bu sayede bütün sistemi tamamen deterministik hale getirmeden, Actor’ın serbest reasoning yaptığı kontrollü bir çalışma alanı oluşturabiliriz.

Program analojisi burada işe yarıyor.

Kod:

“Model şu cevabı verecek.”

demez.

Ama:

“Bu durumda model şu bilgiyle, şu role bağlı ve şu authority sınırında çalışacak.”

diyebilir.

⸻

Bir mekanizma haritası neyi gösterir?

Eğer SOUL’un çalışma biçimini bir yazılım mimarisi gibi görselleştirseydik, yalnız component isimleri koymak yeterli olmazdı.

Şunları görmek isterdim:

Nesneler

* User Request
* Mission / Goal
* Work
* Actor
* Information
* Decision
* Evidence
* Artifact
* Environment

İşlemler

* keşfet,
* değerlendir,
* kabul et,
* planla,
* ata,
* çalıştır,
* kontrol et,
* doğrula,
* revize et,
* kapat.

İlişkiler

* hangi Work hangi Goal’a bağlı,
* hangi Actor hangi Work üzerinde,
* hangi bilgi hangi kararın dayanağı,
* hangi sonuç hangi verifier tarafından kontrol edildi,
* hangi değişiklik başka hangi Work’ü etkiledi.

Ve özellikle:

geçiş koşulları.

Çünkü mekanizma yalnız kutular değildir.

Çoğu zaman sistemin davranışı kutuların arasındaki ilişkilerdedir.

⸻

Bu yaklaşım hata bulmayı da kolaylaştırır

SOUL yalnız metinsel prensipler halinde anlatıldığında bazı eksikler görünmeyebilir.

Örneğin:

* “Work doğrulanır.”
* “Actor gerekli bilgiye ulaşır.”
* “Yeni bilgi planı değiştirir.”

kulağa mantıklı gelir.

Ama mekanizma olarak çizdiğimizde sorular ortaya çıkar:

Work → Verification oku var.

Peki verifier’ı kim seçiyor?

Verifier hangi kaynakları görüyor?

Verification sonucu başarısızsa nereye dönüyor?

Yeni bir Work mü açılıyor?

Eski Work yeniden mi açılıyor?

Kararı kim kabul ediyor?

Bu nedenle görselleştirme yalnız sunum amacı taşımaz.

Bir tasarım testi haline gelir.

Mekanizmayı obje haline getirince boşluklar görünür olmaya başlar.

⸻

Reasoning’i yok etmek değil, reasoning’in etrafını tasarlamak

Burada önemli bir ilke ortaya çıkıyor.

SOUL’un amacı LLM reasoning’ini mekanik kurallarla değiştirmek değildir.

Daha çok:

Reasoning’in etrafındaki çalışma sistemini açık hale getirmektir.

Bir Actor’ın yaratıcı veya analitik düşünmesi gereken yerde düşünmesine izin verilir.

Ama sistem:

* neden orada olduğunu,
* ne üzerinde çalıştığını,
* hangi kaynakların önemli olduğunu,
* hangi yetkiye sahip olduğunu,
* çıktının nereye gideceğini,
* daha sonra kimin kontrol edeceğini

biliyor olmalıdır.

Bu şekilde intelligence ile structure birbirinin alternatifi olmaz.

Birbirlerini tamamlarlar.

⸻

“SOUL bir uygulamadır” demiyorum

Bu analojiyi kurarken özellikle bir sınır koymuştum:

SOUL’u bir program mimarisi gibi düşünmek:

“SOUL normal bir uygulamadır.”

demek değildir.

Ama bir uygulama mimarisini:

* kutular,
* ilişkiler,
* data flow,
* state transitions,
* process flow

ile inceleyebiliyorsak, LLM tabanlı çalışma sistemini de benzer açıklıkla incelemek mümkün olabilir.

Bu, düşünceyi somutlaştırmak için kullanılan bir lens’tir.

Lens gerçek nesnenin tamamı değildir.

⸻

Development OS için daha da önemli

Bu yaklaşım Development OS açısından özellikle değerli.

Çünkü Development OS yalnız SOUL hakkında konuşmamalı.

SOUL’u gerçekten inşa edecekse şunu yapabilmeli:

Soyut ilkeleri çalışabilir mekanizmalara dönüştürmek.

Örneğin araştırmadan:

“Verifier builder’dan epistemik olarak ayrılmalıdır.”

bulgusu geliyor.

Development OS bunu yalnız dokümana yazmamalı.

Şunu sormalı:

* bu ayrım hangi Actor düzeniyle sağlanacak,
* hangi context ayrılacak,
* hangi bilgi paylaşılacak,
* verification ne zaman tetiklenecek,
* verdict neyi değiştirecek?

Yani:

research finding

→ design principle

→ mechanism

→ implementation

→ verification

geçişinin kendisi görünür olmalı.

⸻

Bu analojinin ana fikri

Benim için “SOUL’u program gibi düşünmek” analojisinin özü şu:

LLM sistemini sihirli bir kutu gibi görme.

Kullanıcı mesajı girip mucizevi biçimde doğru sonuç çıkan bir kara kutu tasarlamak istemiyoruz.

Arada:

* context,
* bilgi,
* state,
* Work,
* Actor,
* authority,
* reasoning,
* validation,
* feedback

gibi birçok mekanizma var.

Bunların birbirleriyle nasıl etkileştiğini görünür hale getirirsek SOUL’u:

* daha iyi tasarlayabilir,
* daha iyi sorgulayabilir,
* eksiklerini daha kolay görebilir,
* davranışının hangi kısmının modele, hangi kısmının sisteme ait olduğunu daha iyi ayırabiliriz.

Kısacası:

SOUL’un düşünmesini tamamen deterministik hale getirmek değil; SOUL’un hangi mekanizma içinde düşündüğünü incelenebilir hale getirmek istiyorum.

Program analojisinin benim için değeri burada.

## Builder's assessment (English)

**Principles.**
1. The working system is defined on paper in advance. That covers which steps always run (the base mechanism) and which helpers run only when needed (on-demand mechanisms, the "enzymes"). For each helper, it also states what triggers it. Even the way the pipeline changes itself has a defined place and trigger.
2. Deterministic surroundings, probabilistic thinking. The content of an actor's output cannot be fixed. Its contract can: what it sees, its role, its work, its authority, what verifies it and which state it updates.
3. A mechanism map makes the system inspectable. It shows objects, operations, relations and, above all, the transition conditions on the arrows. Drawing it is a design test: gaps show up on the arrows.
4. A principle is not a mechanism. The chain research finding → principle → mechanism → implementation → verification must itself be visible.

**What the DevOS plan already has (checked).** This is close to a sentence already in the plan. `plan/Calisma_Duzeni_Karsilastirmali_Arastirma.md` compares "graph engineering" (an explicit state machine) and concludes: "DevOS is a mixed order: control and authority transitions are a deterministic state machine in the database; the thinking inside the nodes is left to the agent. This distinction must be kept deliberately." `plan/DevOS_Kurulum_Plani.md` §6.2 ("Kural kapısı") makes every state transition a database function that checks role, work, authority, version, prerequisites and required evidence. `plan/Ek_B_Veri_Modeli.md` defines states and transitions per record family, for example the Work axes `execution`, `qualification`, `acceptance` and `effect` (§3.3). Ek A gives each role a contract with input, output, consumer and authority, which is a box in Batu's sense. What the plan does not seem to have (by grep, not by full reading) is one drawn map that ties these together across families and roles.

**The builder's working system has no map, and today's failures sit on its arrows.** The builder's system is prose: `CLAUDE.md` → `plan/Builder_Operating_Model.md` → `plan/ledger.md` → logs, hooks and scripts. Read as a map, the failures recorded since L-016 are missing arrows or arrows without a trigger:
- *Compaction → re-boot.* The rule exists (§3.4), but nothing fires it. A helper with no trigger.
- *Producer → acceptance.* In L-033 the producer's own judgement was the arrow; there was no separate verifier box on it.
- *State file change → restated copies.* The operating model's status line and `DURUM.md` were not updated with the state file (OI-011 item 22). An arrow with no check.
- *`send_later` → owned-ID record.* The recorder watches `create_trigger` but not `send_later` (OI-011 item 24). A missing arrow, which blocks the builder from checking its own reminder.
- *Log → boot.* The failure log is written but has no arrow back into the next session (`BATU_SCALE_AND_EXPERTISE_TR.md`).
Hypothesis, not yet tested: drawing the map first would have exposed most of these before they happened.

**The builder's main addition: type the arrows.** In an LLM system, an arrow is not one kind of thing. Three kinds matter:
- *Mechanical:* the platform, a hook or a script fires it every time. Examples: `CLAUDE.md` loading, the allow-list hook, `builder_check.sh` when it is run.
- *Instructed:* a text tells the actor to do it. Examples: "read the state file", "re-boot after compaction". It can be skipped, shortened or misread.
- *Judged:* the actor decides whether it is needed. This is the enzyme: looking up a word, calling a skill, consulting the library.
Most of the failures above are instructed arrows on a critical path. A rule for W-C00-12 follows from this: every instructed arrow on a critical path either gets a test that shows it fires, or is promoted to a mechanical one. Judged arrows stay judged, because forcing them makes the system rigid (Batu's own warning), but each needs a cue that makes the need noticeable, such as a skill's description or a router entry.

**Challenges and limits.**
1. *A map is one more copy that drifts* (`BATU_MEMORY_LIFECYCLE_TR.md`). It is useful only if it is authoritative (rules point to it) or mechanically checked against what actually runs (`.claude/settings.json`, hooks, scripts, routines). A hand-drawn map nobody checks becomes decoration.
2. *Granularity.* Mapping every step is bureaucracy. Map transitions that change state or authority, and the triggers of helpers, and leave the inside of a node to the actor.
3. *"Defined in advance" must leave room for change.* The map has to include the arrows by which the map itself changes (principle 1). Otherwise the predefined system freezes, which is the production line that cannot turn back that Batu ruled out.

**Consequence for W-C00-12.** Acceptance (m), added before the work starts, covers the builder's working system:
- A mechanism map that marks base steps and on-demand helpers.
- A type for every arrow: mechanical, instructed or judged.
- For each helper, what triggers it.
- Each failure recorded from L-016 to L-034, and OI-011 items 22 and 24, located on the map as a missing arrow or trigger.
- Every instructed arrow on a critical path either tested or made mechanical.
- The map authoritative or checked mechanically against what actually runs.

The map may also become the backbone that makes the other conditions concrete and lighter to check: the roles of (g), the root chain of (l), the triage of (i).
