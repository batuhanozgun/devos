# Memory is a lifecycle, not a file: persisted is not remembered (input to W-C00-12)

**Provenance.** Batu had ChatGPT write this text from his own thinking. He gave it to builder session `session_016Hi3ZYgAf2amYNGc43a3tr` on 2026-10-02, as the second of two further texts (the first is `BATU_COMMON_FLOOR_TR.md`). It is written about SOUL and DevOS; as with the earlier inputs, it is read for all three scopes (installation, DevOS, SOUL). The Turkish text below is the message as Batu gave it, with line breaks preserved and lists set as Markdown lists; the builder's assessment follows.

## Original (Turkish, verbatim)

SOUL ve Development OS açısından memory konusunu düşünürken, doğrudan “hangi memory framework'ünü kullanalım?” veya “vector database mi kullanalım?” gibi çözüm seviyesinden başlamanın yanlış olabileceğini düşündüm.
Önce daha temel bir soruya indim:
LLM için “ek hafıza” dediğimiz şey aslında nedir?
Bir dosya mı?
Dosyanın içindeki bilgi mi?
Dosyaların birbirleriyle ilişkisi mi?
Bilginin bulunabilmesini sağlayan index mi?
Yoksa bunların tamamını kullanan mekanizma mı?
Bu ayrımı anlamadan memory management çözümü seçersek, aslında neyi yönettiğimizi tam bilmeden yöntem seçmiş olabiliriz.
Bunu anlamak için çok basit bir dosya analojisi kullandım.
Dosya yaratmak ile bilgi yaratmak aynı şey mi?
Bir sistemde şu işlemi yaptığımızı düşünelim:
`Create bilgi.md`
Artık bir dosya vardır.
Ama dosya boşsa hafızada gerçekten yeni bir bilgi oluşmuş mudur?
Sonra dosyaya şunu yazalım:
Top yuvarlaktır.
Saha yeşildir.
Şimdi iki ayrı olay gerçekleşmiş gibi düşünülebilir:

1. fiziksel/teknik taşıyıcı oluşturuldu: `bilgi.md`
2. o taşıyıcının içinde yeni bilgi oluşturuldu.

Bunların ikisine de gündelik dilde “create” diyebiliriz.
Ama aynı tür yaratma değildirler.
Birincisi nesnenin oluşturulmasıdır.
İkincisi semantik içeriğin oluşturulmasıdır.
Memory sistemi tasarlanırken bu ayrım önemlidir.
Çünkü dosyanın varlığı ile içinde doğru bilginin bulunması aynı şey değildir.
Dosyayı değiştirmek ile bilgiyi değiştirmek aynı şey mi?
Şimdi `bilgi.md` dosyamızda şunlar olsun:
Top yuvarlaktır.
Saha yeşildir.
Dosyayı açıp sonuna şunu ekleyelim:
Sporcu forması kırmızıdır.
Teknik açıdan dosya “edit” edilmiştir.
Ama bilgi açısından bakıldığında mevcut iki bilgi değiştirilmemiştir.
Yeni bir bilgi eklenmiştir.
Dolayısıyla:
dosya update edildi
ifadesi ile:
mevcut bilgi update edildi
ifadesi aynı şeyi anlatmaz.
Bunu bir adım daha ileri götürelim.
Dosyada artık:
Top yuvarlaktır.
Saha yeşildir.
Sporcu forması kırmızıdır.
yazıyor.
Sonra:
Sporcu forması kırmızıdır.
ifadesini:
Sporcu forması mavidir.
şeklinde değiştiriyoruz.
Yine teknik düzeyde dosya edit edilmiştir.
Ama semantik düzeyde başka bir olay olmuştur:

* eski bir bilgi artık geçerli değildir,
* onun yerine yeni bir bilgi konmuştur,
* mevcut hafıza durumu değiştirilmiştir.

Bu, yeni bilgi eklemekten farklıdır.
Dolayısıyla tek bir `write` veya `edit` komutunun altında semantik olarak farklı olaylar bulunabilir:

* yeni bilgi oluşturma,
* mevcut bilgiye ek yapma,
* mevcut bilgiyi düzeltme,
* mevcut bilgiyi geçersiz kılma,
* bilgiyi silme,
* bilgiyi yeniden sınıflandırma,
* bilgiyi başka bir bilgiyle ilişkilendirme.

Memory management'i yalnız filesystem operasyonları üzerinden düşünürsek bu ayrımlar görünmez hale gelir.
Teknik işlem ile semantik işlem aynı katman değil
Bence burada çok önemli bir ayrım var.
Bilgisayar dünyası açısından işlem şöyle olabilir:
`OPEN → READ → WRITE → SAVE`
veya:
`CREATE temp → WRITE → RENAME`
Ama insan açısından aynı olay:
“Yeni bir şey öğrendim.”
veya:
“Daha önce bildiğim şeyin yanlış olduğunu öğrendim.”
şeklinde yaşanır.
Bu iki dünya farklıdır.
LLM tabanlı sistemlerin memory problemi biraz da buradan kaynaklanıyor gibi geliyor.
LLM'in reasoning biçimi insan düşünmesine bazı açılardan benzer görünebilir.
Ama kullandığı dış memory materyali tamamen mekaniktir:

* dosya,
* kayıt,
* satır,
* embedding,
* database row,
* index,
* metadata.

İnsan yeni bir bilgi öğrendiğinde o bilgi doğal olarak zihinsel sistemine dahil olur.
LLM tabanlı Actor'da ise yeni bilgi bir dosyaya yazılmış olsa bile Actor'ın onu bildiği sonucu çıkmaz.
Bu ayrım çok önemli.
Bir bilgi diske yazıldı diye Actor'ın hafızasına girmiş olmaz
Bir agent bir bilgi üretip bunu `memory.md` dosyasına yazmış olsun.
Teknik olarak bilgi kalıcıdır.
Ama session bittikten sonra yeni bir Actor instance'ı geldiğinde o dosyanın varlığından haberdar değilse ne olur?
Bilgi vardır.
Ama Actor açısından yoktur.
Dolayısıyla:
`persisted ≠ remembered`
olabilir.
Bilginin gerçekten kullanılabilmesi için Actor'ın bir şekilde o bilgiye yeniden ulaşması gerekir.
Bunun için:

* bir index,
* bir router,
* retrieval mekanizması,
* başlangıç dosyası,
* hook,
* prompt,
* search,
* başka bir Actor

gerekebilir.
Yani memory yalnızca:
“bilgiyi bir yere yazmak”
değildir.
Aynı zamanda:
“gerektiği anda o bilginin varlığını fark etmek ve ona geri ulaşabilmek”
problemidir.
Hafıza saklanmak için değil, kullanılmak için vardır
Benim bu konudaki temel sezgim şu:
Memory'nin amacı yalnızca bilgiyi kaybetmemek değildir.
Hafızanın esas değeri, doğru bilgiye doğru anda tekrar ulaşabilmektir.
Bilgi mükemmel biçimde saklanmış olabilir.
Ama gerektiği anda bulunamıyorsa çalışma sistemi açısından değeri ciddi biçimde azalır.
Dolayısıyla iyi bir memory sistemi en az şu yaşam döngüsünü düşünmek zorundadır:
`oluştur → sakla → adresle → bul → oku → kullan → güncelle → geçersiz kıl / koru → yeniden bul`
Buradaki herhangi bir halkanın kırılması memory'nin pratik değerini azaltır.
“Read” pasif bir işlem değildir
Buradan başka bir sonuç çıkıyor.
Bir dosyanın okunması yalnızca teknik bir I/O işlemi değildir.
SOUL açısından okuma, bilginin çalışma context'ine yeniden girmesi anlamına gelir.
Bilgi depoda yıllardır var olabilir.
Ama Actor'ın current Work'ü sırasında okununca bir anda reasoning'in parçası haline gelir.
Bu açıdan retrieval ve context construction da memory lifecycle'ın parçasıdır.
Memory:
`storage`
ile bitmez.
Şuna daha yakındır:
`storage + addressability + retrieval + context activation`
Bilginin varlığı da bilgi olabilir
Bir başka ilginç ayrım da şu.
`bilgi.md` dosyasının içeriği bilgi taşır.
Ama sistem açısından:
“bilgi.md diye bir dosya vardır ve şu konuda bilgi içerir”
ifadesi de ayrı bir bilgidir.
Bu bilgi örneğin `INDEX.md` içinde bulunabilir.
Dolayısıyla memory sistemi katmanlı hale gelir:

* özgün bilgi,
* bilginin nerede bulunduğuna ilişkin bilgi,
* bilginin durumuna ilişkin metadata,
* hangi durumda okunacağına ilişkin routing bilgisi.

Bu noktada memory yalnızca içerik deposu olmaktan çıkar.
Bir bilgiye erişim sistemi haline gelir.
Memory'de yaratma, güncelleme ve silme semantik olaylardır
Memory lifecycle tasarlanırken yalnız teknik CRUD kelimelerine güvenmemek gerektiğini düşünüyorum.
Örneğin `update` çok kaba bir kelimedir.
Şu olayların hepsi teknik olarak update olabilir:

* yeni bilgi eklemek,
* hatalı bilgiyi düzeltmek,
* eski bilgiyi deprecated yapmak,
* bilgiye kaynak eklemek,
* bilgiye güven seviyesini değiştirmek,
* iki kaydı birleştirmek,
* bilgiyi başka kategoriye taşımak.

Ama bunların SOUL açısından etkileri birbirinden çok farklı olabilir.
Örneğin yanlış bir bilginin değiştirilmesi yalnız o satırı etkilemeyebilir.
Eski bilgi kullanılarak:

* karar verilmiş,
* başka bir Work açılmış,
* başka bir belge yazılmış,
* başka bir Actor yönlendirilmiş

olabilir.
Bu durumda gerçek memory update şunu sormalıdır:
“Bu bilginin değişmesi başka neleri etkiliyor?”
Dolayısıyla memory maintenance yalnız veri mutation değildir.
Change-impact problemi de olabilir.
Append ile correction aynı şey değildir
Bu ayrımı özellikle korumak isterim.
Mevcut bilgiye yeni bir cümle eklemek:
knowledge growth
olabilir.
Ama:
forma kırmızıdır
bilgisini:
forma mavidir
şeklinde değiştirmek:
knowledge revision
olabilir.
İkisi aynı değildir.
Growth durumunda eski bilgi hâlâ geçerli olabilir.
Revision durumunda eski bilgi artık yanlış veya superseded olabilir.
Memory sistemi bunu ayıramıyorsa zamanla çelişkili bilgi biriktirebilir.
Sonra Actor retrieval yaptığında:

* kırmızı,
* mavi

iki bilgiyi de görür ve hangisinin authoritative olduğunu bilmez.
Bu yüzden memory'de yalnız içerik değil:

* zaman,
* sürüm,
* provenance,
* authority,
* supersession

gibi ilişkiler de önemli hale gelebilir.
Bunların tam veri modeli henüz ayrı bir tasarım problemidir; fakat ihtiyaç buradan görünür oluyor.
Silmek bile basit değildir
Aynı şekilde “delete” de basit görünür.
Ama memory açısından şu sorular çıkar:

* bilgi gerçekten yanlış mıydı?
* artık gerekli değil mi?
* tarihsel kayıt olarak korunmalı mı?
* yalnız current view'dan mı çıkarılmalı?
* başka kayıtlar ona referans veriyor mu?
* karar geçmişini anlamak için gerekli mi?

Bir dosyayı silmek kolaydır.
Ama bilgiyi sistemin epistemik geçmişinden silmek başka bir şeydir.
SOUL uzun süre çalışan bir sistem olacaksa bu ayrım önemli hale gelir.
Memory bozulmaması gereken bir çalışma yüzeyidir
Benim daha iddialı beklentim şu:
SOUL ve Development OS için memory bir aksesuar değildir.
Çünkü uzun süreli reasoning ancak çalışma durumu korunabiliyorsa anlamlı olur.
Yeni Actor:

* geçmişte ne yapıldığını,
* hangi kararların neden alındığını,
* hangi kaynakların kullanıldığını,
* hangi şeylerin hâlâ açık olduğunu

geri kazanamıyorsa sistem her session'da yeniden başlar.
Bu yüzden memory'nin mümkün olduğunca:

* tutarlı,
* adreslenebilir,
* provenance-aware,
* güncellenebilir,
* değişiklik etkisi izlenebilir

olmasını isterim.
“Hiç bozulmamalı” derken bunun mutlak teknik hata imkânsızlığı anlamına gelmesi gerekmiyor.
Asıl amaç şu:
Bilgi sistemi sessizce epistemik çürümeye uğramamalı.
Her şey her zaman context'te olmak zorunda değil
Burada önemli bir karşı sınır var.
Memory'nin sağlam olması demek:
“Bütün bilgi her zaman prompt'a yüklensin.”
demek değildir.
Bu hem pratik değildir hem de düşünme kalitesini düşürebilir.
Asıl ihtiyaç şudur:
Bilginin varlığı bilinebilir olsun ve gerektiğinde bilgiye güvenilir biçimde ulaşılabilsin.
Bu nedenle katmanlı yapı fikri doğal olarak ortaya çıkıyor.
Örneğin en üst katmanda:

* hangi bilgi alanları var,
* hangi Work current,
* hangi kayıt authoritative

görülebilir.
Sonra ihtiyaç halinde daha derine inilerek özgün bilgiye ulaşılır.
Yani memory'nin kalitesi:
her şeyi anında hatırlamak
değil,
gerektiğinde doğru şeyi doğru derinlikte recover edebilmek
olarak düşünülebilir.
Hafıza ile reasoning birbirinden ayrı değil
Bence memory'nin önemini anlatan en temel ifade şu:
Hafıza olmadan uzun vadeli reasoning soyut kalır.
Bir Actor çok güçlü reasoning yapabilir.
Ama sonucu kalıcılaştırılmıyorsa sonraki Actor aynı reasoning'i tekrar yapmak zorunda kalır.
Daha kötüsü, önceki reasoning'in sonucunu bilmeden farklı bir sonuca ulaşabilir.
Dolayısıyla uzun süreli SOUL çalışmasında:
`reasoning → memory`
ve:
`memory → yeni reasoning`
arasında sürekli bir döngü vardır.
Bu açıdan memory yalnız geçmişin arşivi değildir.
Gelecekteki reasoning'in girdisidir.
Memory'nin gerçek nesnesi ne?
Bu nedenle Development OS ve SOUL tasarımında şu soruyu açık tutmak istiyorum:
Gerçekte yönettiğimiz şey dosyalar mı, bilgi mi, yoksa bilgi yaşam döngüsü mü?
Dosya yalnızca taşıyıcı olabilir.
Database satırı yalnızca taşıyıcı olabilir.
Vector embedding yalnızca retrieval mekanizmasının parçası olabilir.
Bunların hiçbirini tek başına “memory” ile eşitlememek gerekir.
Daha üst seviyede memory şu yeteneklerden oluşuyor olabilir:

* bilgiyi oluşturma,
* kalıcılaştırma,
* kaynağını bilme,
* adresleme,
* gerektiğinde bulma,
* çalışma context'ine getirme,
* değiştirme,
* değişiklik etkisini düşünme,
* eski ve yeni bilgiyi ayırma,
* gerektiğinde tarihsel izi koruma.

Bu bir veri formatından çok bir yaşam döngüsü problemi gibi görünüyor.
Existing memory ürünlerini değerlendirirken sorulması gereken soru
Bu ayrım çalışmalarımızdaki memory ürünlerini incelerken de yararlı.
Bir framework:
“Agent memory sağlıyoruz.”
diyebilir.
Ama bizim sormamız gereken daha ayrıntılı sorular var:

* Neyi persist ediyor?
* Bir bilgiyi hangi birim olarak görüyor?
* Yeni bilgi ile revision'ı ayırıyor mu?
* Provenance tutuyor mu?
* Eski bilginin superseded olduğunu nasıl biliyor?
* Bilgi yeniden nasıl bulunuyor?
* Retrieval neye göre çalışıyor?
* Actor o memory'nin varlığını nasıl fark ediyor?
* Bilgi değişince eski kullanım alanları etkileniyor mu?
* Memory uzun vadede nasıl temizleniyor veya yeniden organize ediliyor?

Bu soruları ancak:
“dosyayı mı yönetiyoruz, bilgiyi mi?”
ayrımına indikten sonra sormaya başlayabiliyoruz.
Development OS açısından sonuç
Development OS kurulurken memory'yi yalnız:
“session'lar arasında birkaç dosya bırakalım”
seviyesinde çözülmüş saymamak gerekir.
Bu yararlı bir başlangıç olabilir.
Ama asıl başarı kriteri şudur:
Yeni Actor, önceki çalışmadan gerekli olan bilgiyi doğru bağlam ve statüyle recover edip kullanabiliyor mu?
Eğer cevap hayırsa disk üzerinde dosya bulunması tek başına continuity sağlamaz.
Bu nedenle memory tasarımını:
`write file → done`
değil,
`capture → preserve → locate → recover → interpret → use → revise`
döngüsü olarak düşünmek daha doğru geliyor.
Özetle bu analojinin bana söylediği şey şu:
Dosya memory değildir.
Dosyanın içindeki bilgi bile tek başına memory değildir.
Memory, bilginin:

* oluştuğu,
* saklandığı,
* adreslendiği,
* yeniden bulunduğu,
* kullanıldığı,
* değiştirildiği,
* geçmişiyle ilişkilendirildiği

bir yaşam döngüsüdür.
Ve LLM tabanlı sistemlerde en kritik fark şudur:
Bir bilginin bir yere yazılmış olması, Actor'ın onu hatırladığı anlamına gelmez.
SOUL açısından gerçek memory başarısı, bilginin yalnızca kaybolmaması değil; ihtiyaç anında doğru Actor'ın doğru bilgiyi doğru bağlamda yeniden kullanabilmesidir.

## Builder's assessment (English)

**Principles.**
1. The object of memory is the knowledge lifecycle, not the file: capture, preserve, locate, recover, interpret, use, revise.
2. One file operation can hide different semantic events: addition (growth), correction, supersession, retirement, reclassification, linking. Growth leaves old knowledge valid; revision makes it superseded. A store that cannot tell them apart accumulates contradictions.
3. Persisted is not remembered. Knowledge counts only if the right actor can notice it exists and recover it at the right moment, with its status. The existence and location of knowledge is itself knowledge (index, router).
4. A revision has an impact: decisions, work items, documents and actors may rest on the old version. Memory maintenance is partly a change-impact problem.
5. Not everything in context at once: layered access, recover the right thing at the right depth (principle 12, the pyramid).
6. The success test: can a new actor recover what it needs from earlier work, with the right context and status?

**What the DevOS plan already has (checked).** The data model covers most of this for DevOS. `plan/Ek_B_Veri_Modeli.md` §1 item 3: an update never changes an old revision, it creates a new revision with a reason, and references name the revision they point to. §3.4: typed relations including `supersedes` and `derived_from`, with `validity` (current / stale / retracted). §3.8: every source and finding carries `epistemic_status` and `current_authority`, so "red" and "blue" can be told apart. §1 item 11: deletion handles every derived copy (chunks, vectors, indexes, context packages), not a "deleted" flag. Staleness propagates: a verdict goes stale when its basis changes (§3.11), and `affected_entities` answers "what does this change touch?" (`plan/Ek_G_Isleyis_Kurallari.md` G2). §3.14: "a method file existing in the repository does not mean it is active", which is persisted ≠ remembered in Batu's sense. Recovery is tested by D7's new-session test (`plan/Ek_D_Dusunme_Protokolleri.md`). One possible DevOS gap: the revision reason is free text, so growth and correction are not distinguished by type. That is minor and belongs to C02's data-model work.

**The builder's own memory has almost none of this (observed today).** The builder's memory is Markdown in Git: the state file `plan/ledger.md`, the logs, the briefs, the evidence and `DURUM.md`. Git keeps every mechanical change, but no record says what kind of change it was or what it superseded, and no check looks for other copies of a changed fact. While writing this assessment, the builder re-ran the boot reads and found a live red-and-blue case:
- `plan/ledger.md` (W-C00-05 row): the operating model is "done by the producer's own judgement, not independently accepted; superseded in substance by W-C00-12".
- `plan/Builder_Operating_Model.md` line 3 still says "Status: Binding … since 2026-10-01T21:05Z".
- `DURUM.md` still told Batu "belge artık bağlayıcı".
- Three records state one fact; only one was revised. A new session that reads the operating model first sees "binding". The status page is corrected in this change, because keeping it in line with the state file is routine. The operating model's status line is left as it is, on purpose: whether the model is binding during the hold is a design question for W-C00-12, not a one-line fix.
- Other observed cases of the same class: T-B1 failed because the state file's Next action row was stale after the work it named was done (L-027); the builder's own failure log is persisted but never shown at boot (`BATU_SCALE_AND_EXPERTISE_TR.md`); and the OI-011 cell in the state file has grown into one very long paragraph, so it is findable in principle but its signal is diluted.
- *Compaction is a silent memory revision.* This session's earlier context was replaced by a summary. `plan/Builder_Operating_Model.md` §3.4 says to re-run boot steps 2–5 after a compaction instead of trusting the summary. The builder did not do this at once after the compaction; it did so only while writing this assessment, and that is how it found the contradiction above. The rule exists; nothing makes it happen.

**Challenges and limits.**
1. *Typing every write is bureaucracy.* Classify only changes to authoritative records (state file, operating model, plan, decisions); log lines are append-only and already growth by construction. A correction in a log is a new entry that names what it corrects.
2. *Do not build a second history.* Git already keeps the mechanical history. What is missing is the semantics (kind of change, what it supersedes) and the pointers. A second history store would itself become a copy that drifts.
3. *Fewer copies beats tracking copies.* Change impact needs links, and links rot too. The cheaper and more robust first move is one authoritative home per fact, with every other place pointing to it instead of restating it. The status contradiction above exists only because the status was restated in three places. The parts that cannot be single-homed (Batu's Turkish status page restates the state file by design) need a mechanical consistency check. `tools/builder_check.sh` already flags `DURUM.md` being older than the state file, but not content that disagrees.
4. *"Never corrupt" means detectable, not impossible.* Batu says this himself. The DevOS plan has a daily stale-record and broken-link job (Ek B §5); the builder has nothing equivalent.
5. *Memory products.* Batu's ten questions are a ready-made evaluation frame for any memory framework the plan considers (search and memory choices at C02 and C04, `plan/Ek_B_Veri_Modeli.md` §8). They should be applied before any product is compared on features.

**Consequence for W-C00-12.** With both texts in hand, the acceptance conditions are extended (state file, W-C00-12 row): (k) common floor and stamina, from `BATU_COMMON_FLOOR_TR.md`; (l) memory lifecycle for the builder's records, from this text. Both are written before the work starts and only tighten the conditions.
