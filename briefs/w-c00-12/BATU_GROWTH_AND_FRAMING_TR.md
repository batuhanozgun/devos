# Vertical and horizontal growth; every framing lights and limits (input to W-C00-12)

**Provenance.** Batu had ChatGPT write this text from his own thinking. He gave it to builder session `session_016Hi3ZYgAf2amYNGc43a3tr` on 2026-10-03, for all three scopes (installation, DevOS, SOUL). The Turkish text below is the message as Batu gave it, with line breaks preserved and lists set as Markdown lists; the builder's assessment follows.

## Original (Turkish, verbatim)

SOUL üzerine düşünürken bir noktada “SOUL büyüyen, genişleyen bir yapı” ifadesini kullanmıştım.

Bu ifade ilk bakışta doğru geliyordu.

Ama sonra şunu fark ettim:

Doğru bir ifade bile düşünme alanını yanlış biçimde daraltabilir.

“SOUL büyür” dediğimde bunun doğal çağrışımı şuna kayabilir:

Yeni ihtiyaç çıktıkça SOUL’a yeni parçalar eklenir.

Bu yanlış değil.

Ama eksik.

Çünkü benim kastettiğim büyüme yalnızca yeni modüller, yeni Actor’lar veya yeni fonksiyonlar eklemek değildi.

SOUL’u daha çok iki eksende genişleyen bir yapı gibi hayal ediyordum:

* dikey genişleme
* yatay genişleme

⸻

Dikey genişleme: yeni capability ortaya çıkması

Dikey genişleme daha sezgisel olan taraf.

SOUL’un baz halinde sahip olmadığı yeni bir ihtiyaç ortaya çıkar.

Örneğin sistem başlangıçta:

* araştırma,
* planlama,
* basit üretim

yapabiliyor olsun.

Sonra yeni Work nedeniyle:

* güvenlik uzmanlığı,
* yeni bir domain bilgisi,
* farklı bir verification yöntemi,
* özel bir tool kullanımı

gereksin.

Böylece sisteme yeni bir Actor, yöntem veya capability eklenir.

Bu:

dikey büyüme

gibi düşünülebilir.

SOUL yeni bir şeyi yapabilir hale gelmiştir.

⸻

Yatay genişleme: mevcut fonksiyonların kapsamının genişlemesi

Ama yalnızca yeni capability eklemek yetmez.

Yeni Actor veya yeni çalışma yüzeyi sisteme girdiğinde mevcut fonksiyonların bazıları da onu kapsayacak şekilde genişlemek zorunda kalabilir.

Örneğin baz SOUL’da iki dosya üzerinde çalışan basit bir kontrol mekanizması olduğunu düşünelim.

Sonra yeni bir Actor sisteme dahil edildi.

Bu Actor:

* yeni dosyalar okuyor,
* yeni dosyalar yazıyor,
* yeni kararlar üretiyor.

SOUL yalnızca:

“Yeni Actor ekledim.”

deyip bırakamaz.

Daha önce var olan:

* context management,
* memory,
* provenance,
* verification,
* authorization,
* Work tracking,
* continuity,
* change-impact

mekanizmalarının bir bölümü artık bu yeni Actor’ın ürettiği yüzeyleri de kapsamalıdır.

Yani yeni parçanın eklenmesi, mevcut sistemin geri kalanında kapsam genişlemesi yaratır.

Bu yatay genişlemedir.

⸻

Yeni Actor yalnızca yeni bir kutu değildir

Bir sistem diyagramında yeni bir Actor eklemek kolay görünür.

Yeni kutu çizilir:

Security Actor

ve bitti sanılır.

Ama gerçekte bu Actor’ın sisteme katılması başka sorular üretir:

* Hangi Work’ü görebilecek?
* Hangi bilgiye erişecek?
* Ürettiği bilgi memory’ye nasıl girecek?
* Kim onun çıktısını doğrulayacak?
* Hangi authority’ye sahip?
* Session değiştiğinde state’i nasıl recover edilecek?
* Onun değiştirdiği artefaktların impact’i nasıl takip edilecek?

Dolayısıyla:

yeni Actor = yalnızca yeni capability değildir.

Yeni Actor mevcut mekanizmaların kapsaması gereken yeni bir sistem yüzeyidir.

Bu nedenle SOUL’un büyümesini yalnız component sayısıyla düşünmek eksik kalır.

⸻

Dikey büyüme yatay adaptasyonu tetikleyebilir

Bu ilişkiyi şöyle düşünebiliriz:

```
Yeni ihtiyaç
    ↓
Yeni capability / Actor
    ↓
Yeni bilgi ve Work yüzeyleri
    ↓
Mevcut kontrol mekanizmalarının kapsamı değişir
    ↓
SOUL'un mevcut yapısı yatay olarak genişler
```

Yani dikey büyüme çoğu zaman yatay büyümeyi de tetikleyebilir.

Sistemin yeni parçası çevresindeki mevcut ilişkileri değiştirmeden izole biçimde eklenemeyebilir.

⸻

Plugin eklemek ile sistemi gerçekten genişletmek aynı şey değil

Bu ayrım başka bir probleme de ışık tutuyor.

Bir sisteme yeni bir tool veya plugin eklemek teknik olarak capability artışıdır.

Ama SOUL açısından gerçek genişleme olup olmadığı ayrı sorudur.

Örneğin yeni bir browser tool’u geldi.

Bu yalnızca:

“Artık web’e erişebiliyoruz.”

demek değildir.

Şunlar da değerlendirilmelidir:

* web’den gelen kaynak nasıl sınıflandırılacak,
* provenance nasıl korunacak,
* stale bilgi nasıl anlaşılacak,
* external evidence hangi kararları değiştirebilir,
* web erişimi olmayan Actor’larla bilgi nasıl paylaşılacak?

Dolayısıyla capability addition ile system integration aynı şey değildir.

⸻

Framing problemi burada fark edildi

Bu düşünceyi konuşurken benim için daha meta bir farkındalık ortaya çıktı.

Ben:

“SOUL genişleyecek.”

dediğimde, söylediğim şey yanlış değildi.

Ama “genişleme” kelimesi cevabın dikkatini yalnız:

yeni şeyler eklemek

tarafına çekebilirdi.

Oysa benim zihnimde:

mevcut sistemin kapsamının da yeniden oluşması

vardı.

Burada şunu fark ettim:

Bir cümle modele yararlı bir perspektif verirken aynı anda olası başka perspektifleri arka plana itebilir.

Bu çok önemli.

⸻

Context yalnız bilgi eklemez, option space’i de şekillendirir

Bir modele:

“SOUL büyüyen bir sistemdir.”

dediğimizde context’e bir bilgi eklemiş oluruz.

Ama aynı zamanda problemin framing’ini de değiştirmiş oluruz.

Model artık doğal olarak:

* expansion,
* new components,
* scaling

gibi kavramlara daha fazla ağırlık verebilir.

Fakat:

* replacement,
* contraction,
* integration,
* cross-cutting adaptation,
* removal,
* reconfiguration

gibi başka olasılıklar daha az görünür hale gelebilir.

Dolayısıyla context engineering yalnız:

doğru bilgiyi vermek

değildir.

Aynı zamanda:

verilen bilginin düşünce alanını nasıl şekillendirdiğini fark etmek

problemidir.

⸻

Doğru bilgi bile bias üretebilir

Buradaki mesele yanlış prompt değildir.

Prompt doğru olabilir.

Sorun daha ince:

Doğru bir framing eksik bir dünya modeli yaratabilir.

Örneğin:

“Bu problemi güvenlik açısından değerlendir.”

yararlı olabilir.

Ama yalnız güvenlik lens’i aktive olursa:

* usability,
* maintainability,
* performance

gibi başka yük taşıyan boyutlar geri planda kalabilir.

Benzer şekilde:

“SOUL büyür.”

demek doğrudur.

Ama:

“SOUL bazı durumlarda küçülür, birleşir, eski mekanizmayı kaldırır veya mevcut fonksiyonların kapsamını yeniden tanımlar.”

olasılıklarını görünmez yapmamalıdır.

⸻

SOUL yalnız büyümemeli, yeniden şekillenebilmeli

Buradan önemli bir sonuç çıkıyor:

SOUL’un adaptasyonu yalnız additive olmamalıdır.

Yeni ihtiyaç geldiğinde sistem her zaman:

+ yeni Actor

+ yeni tool

+ yeni dosya

şeklinde büyürse zamanla gereksiz karmaşıklık oluşabilir.

Bazen doğru adaptasyon:

* iki rolü birleştirmek,
* eski bir yöntemi bırakmak,
* redundant capability’yi kaldırmak,
* mevcut Actor’ın kapsamını değiştirmek

olabilir.

Dolayısıyla “genişleyen SOUL” daha doğru ifadeyle:

ihtiyaca göre yeniden şekillenen SOUL

olabilir.

⸻

Yeni capability’nin acceptance problemi

Yeni Actor veya fonksiyon ortaya çıktığında bir başka soru var:

SOUL bunu hemen kendi parçası mı sayacak?

Bence hayır.

Yeni capability:

* denenebilir,
* sınanabilir,
* qualification’dan geçebilir,
* sonra kabul edilebilir.

Bu açıdan bana Git branch yapısını çağrıştıran bir fikir ortaya çıkmıştı.

Bir değişiklik:

main

üzerine doğrudan yazılmak yerine:

branch

gibi izole bir alanda geliştirilebilir.

Sonra:

* diff görülür,
* test edilir,
* review edilir,
* kabul edilirse merge edilir.

Ben branch’i burada literal olarak zorunlu implementation seçimi olarak önermiyorum.

Analojinin değeri şu:

Değişiklik ile kabul edilmiş sistem durumu ayrı tutulabilir.

⸻

Candidate state ile accepted state ayrımı

SOUL için de benzer bir ayrım düşünülebilir:

current accepted system

ve

candidate change

aynı şey değildir.

Yeni yöntem keşfedildi.

Bu henüz SOUL’un yöntemi değildir.

Yeni Actor tasarlandı.

Bu henüz production Actor değildir.

Yeni memory yapısı önerildi.

Bu henüz current architecture değildir.

Önce değerlendirme alanında bulunabilir.

Sonra acceptance gerçekleşirse current state’e geçer.

Bu, yaşayan bir sistemin kendisini kontrollü biçimde değiştirebilmesi açısından önemli.

⸻

Branch analojisinin sınırı

Burada dikkatli olmak gerekir.

Git branch:

* dosya diff’lerini,
* commit history’yi,
* merge’i

çok iyi temsil eder.

Ama SOUL değişikliği:

* davranış,
* reasoning,
* role identity,
* information flow

gibi yalnız dosya diff’iyle ölçülemeyen şeyler içerebilir.

Dolayısıyla:

Git branch = SOUL adaptation mechanism

demiyorum.

Sadece branch’in:

“değişiklik önce ayrı tutulur, gözlemlenir ve sonra kabul edilir”

mantığının yararlı bir zihinsel model olduğunu söylüyorum.

⸻

Bunun Development OS açısından anlamı

Development OS SOUL’u kurarken yeni fikirleri doğrudan architecture’a eklememeli.

Örneğin araştırmadan yeni bir mechanism çıktı.

Şu zincir düşünülebilir:

research finding

→ candidate design

→ bounded implementation

→ verification

→ acceptance

→ current system

Bu ayrım kaybolursa:

öneri ile adopted architecture

aynı şeye dönüşür.

Bu da araştırma sisteminde çok tehlikeli.

⸻

Yatay ve dikey büyümenin birlikte kontrolü

SOUL’a yeni bir Actor eklenirken yalnız:

“Actor çalışıyor mu?”

test edilmemeli.

Aynı zamanda:

Mevcut sistem onun varlığını doğru şekilde kapsıyor mu?

sorusu da sorulmalı.

Örneğin Actor başarılı sonuç üretiyor.

Ama:

* memory sistemi çıktısını kaydetmiyor,
* verifier onu görmüyor,
* authority sınırı yok,
* recovery sistemi onu bilmiyor.

Bu durumda lokal capability çalışıyor olabilir ama SOUL’a gerçekten entegre olmamıştır.

Bu yüzden success kriteri yalnız component-level olmamalı.

System-level integration da sınanmalı.

⸻

Framing’e karşı ikinci bakış

Bu konuşmanın benim için en değerli meta sonucu ise şuydu:

Ben bir şey söylediğimde, söylediğim şeyin yalnız doğru olup olmadığını değil:

“Bu cümle düşünceyi hangi yöne çekiyor ve hangi olasılıkları sessizce görünmez yapıyor?”

sorusunu da sormalıyız.

Bu kullanıcı için de geçerli.

Assistant için de geçerli.

Research finding için de geçerli.

Bir kavram:

* güçlü bir lens olabilir,
* ama lens aynı zamanda görüş alanını sınırlar.

Dolayısıyla SOUL önemli kararlarda tek framing’e çok hızlı kilitlenmemeli.

⸻

Yararlı framing ile eksiksiz framing aynı şey değildir

Örneğin:

“SOUL genişleyen sistem.”

yararlı framing.

Ama eksiksiz değil.

Daha geniş frame:

SOUL yeni capability ekleyebilir, mevcut capability’lerini genişletebilir, bazılarını değiştirebilir veya kaldırabilir.

Bu daha iyi.

Ama onun da başka eksikleri olabilir.

Dolayısıyla amaç sonsuz framing üretmek değil.

Kararı maddi biçimde değiştirebilecek alternatif frame’lerin farkında olmak.

⸻

Kısa formül

Bu analojiden benim için iki temel ilke çıkıyor.

1. SOUL’un adaptasyonu iki yönlüdür

Dikey:

Yeni capability, Actor veya yöntem.

Yatay:

Mevcut Information, Work, control ve continuity mekanizmalarının yeni sistemi kapsayacak şekilde genişlemesi.

Gerçek expansion ikisinin birlikte çalışmasını gerektirebilir.

2. Her framing aynı anda hem aydınlatır hem sınırlar

Bir cümle:

“SOUL büyür.”

önemli bir gerçek gösterebilir.

Ama aynı anda:

“SOUL yeniden düzenlenir, küçülür veya mevcut fonksiyonlarını genişletir.”

olasılıklarını arka plana itebilir.

Bu nedenle SOUL’un reasoning sistemi yalnız:

“Verilen context doğru mu?”

diye değil,

“Bu context hangi başka makul bakışları görünmez yapıyor?”

diye de gerektiğinde bakabilmelidir.

Bunu tek cümlede özetlersem:

SOUL’un gelişmesi yalnız yeni parçalar eklemek değildir; yeni parçalar geldikçe sistemin mevcut ilişkileri de yeniden kapsam kazanmalıdır ve bu süreci düşünürken kullandığımız framing’in olası çözüm alanını sessizce daraltmasına karşı dikkatli olmalıyız.

## Builder's assessment (English)

**Principles.**
1. Growth has two axes. *Vertical:* a new capability, actor or method. *Horizontal:* the existing cross-cutting mechanisms (context, memory, provenance, verification, authority, work tracking, continuity, change impact) widen to cover the new surface. A component that works locally but is not covered by them is not integrated.
2. Adaptation is not only additive: merging, narrowing, replacing and removing are also growth.
3. A candidate change and the accepted system are different states. A change is kept apart, observed and tested, and only then accepted.
4. Every framing lights and limits. A true statement can still narrow the option space. Important decisions should look for frames that would change the decision materially, not for endless frames.

**What the DevOS plan already has (checked).** `plan/DevOS_Kurulum_Plani.md` §6.12 ("Çerçeve denetimi ve mekanizma varsayım envanteri") is close to this text:
- a premise inventory for every major design, with the test "would we choose this again from scratch today?";
- a *squeeze signal*: when a design starts producing new mechanisms, rules or exceptions at a limit, a frame review is mandatory first;
- an *independent counter-design*: a clean-context session that does not see the current design, only the goal, constraints and criteria, produces its own design, and the differences are closed with reasons;
- a *mechanism assumption inventory*: each mechanism states what it compensates for in the model, and is removed if removing it does not make results worse.
Candidate versus accepted is in K-10's method-change flow and in the `candidate / current / superseded` statuses of Ek B. The builder's own repository already works this way for files: a branch, a pull request, then `main`.

**The builder (observed).**
- *Horizontal growth was missed, twice.* When the builder added `send_later` reminders (vertical), the owned-ID recorder (a cross-cutting mechanism) was not widened to cover them, so the builder cannot check its own reminder (OI-011 item 24). When it added reviewer, probe and dispatcher sessions, the thinking disciplines and known failures were not extended to them (`BATU_INTELLECTUAL_HERITAGE_TR.md`).
- *Additive bias in this very conversation.* Every input from Batu so far has led to an addition: a new principle, a new acceptance condition or an extension, going from (a) to (m). None led to a removal or a merger, although the builder began folding extensions into existing conditions two inputs ago. Under the squeeze signal of §6.12, a growing list of conditions is itself a reason for a frame review.
- *Framing of the redesign session.* The first message for W-C00-12 will route to eleven briefs written in Batu's lenses and assessed in the builder's. Whatever it says first will frame the session. This is the risk the text describes, applied to the builder's next step.

**What follows (recommendation, not yet decided).**
1. *An independent counter-design for W-C00-12,* as §6.12 item 3 prescribes for major designs. A clean session sees the goal, the constraints, the plan and the outside research, but not the briefs' assessments or the builder's draft. It produces its own design of the builder's working system, and the two are compared. Today acceptance (d) asks only for an independent *review*, which sees the design and is therefore anchored by it. W-C00-05 had a counter-design condition; W-C00-12 has none. This is the one place where the text points to a real gap in the conditions.
2. *A coverage check when something is added.* Every new component on the mechanism map of (m) shows which cross-cutting mechanisms cover it (ID recording, heritage, memory, verification, recovery). A component with an uncovered row is not accepted. This belongs inside (m), not as a new condition.
3. *Consolidation before addition.* The redesign session starts by asking which of (a) to (m) can be merged or dropped. For example, the mechanism map of (m) may carry (g)'s role-and-goal map and (l)'s root chain.

**Challenges and limits.**
1. *Looking for alternative frames can become endless.* The text says so itself. The stopping rule: only frames that would change the decision materially, and one counter-design for a major decision, not one per sentence.
2. *A counter-design costs a session and usage.* For W-C00-12 it is proportionate: this is the most foundational design of the installation, and its predecessor W-C00-05 was weak in exactly the way a frame review would have caught.
3. *Branches cover files, not behaviour.* Batu notes this limit himself. For the builder, a pull request shows the diff of a rule, but not how a session will behave under it. Behaviour needs the pre-registered tests of (e).

**Consequence for W-C00-12.** Before the work starts, (d) is extended with an independent counter-design (§6.12 item 3) and (m) with the coverage check. The consolidation question is put first in the redesign session's first message. No new condition is added.
