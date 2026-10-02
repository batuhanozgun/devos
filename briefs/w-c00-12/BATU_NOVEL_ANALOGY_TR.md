# The novel analogy: request, discovery and living work (input to W-C00-12)

**Provenance.**
- Batu asked ChatGPT to select this analogy from his own conversations about SOUL and to write it up as a message for Claude.
- Batu gave the resulting text to the builder session `session_016Hi3ZYgAf2amYNGc43a3tr` on 2026-10-02, with this instruction: read it not only as a statement about SOUL. It describes a way of working and thinking. The same quality applies in three scopes, and only the uncertainty grows: the builder's installation (most definite output), DevOS (more evaluation), and SOUL (open-ended user requests, within what an LLM-based agent can do).
- The text below is the message as Batu gave it, in Turkish. The builder's assessment follows.

## Original (Turkish, verbatim)

SOUL üzerine düşünürken ortaya çıkan temel problemlerden biri şuydu: Kullanıcının söylediği şey ile gerçekten yapılması gereken iş aynı şey değildir.

Bir kullanıcı sisteme bir talepte bulunur. Bu talep genellikle eksik, dar, sonuçları düşünülmemiş veya yalnızca kullanıcının o anda ifade edebildiği kadardır. Kullanıcının sistemden daha az bilgiye sahip olması olağandır; hangi soruların sorulması gerektiğini, işin hangi bağımlılıklarının bulunduğunu veya talebinin ilerleyen aşamalarda hangi başka problemleri doğuracağını bilmesi beklenemez.

Bu nedenle SOUL'a gelen ilk talebi doğrudan `Work` kabul etmek sorunludur.

Bu problemi anlamak için kullandığımız ana analoji roman yazmak oldu. Bir kullanıcı gelip "Bir roman yazmak istiyorum." dediğinde, yüzeydeki talep oldukça açıktır: roman yazılacaktır. Fakat "roman yazmak" gerçekte ne demektir? İlk bakışta konu, karakterler, anlatı yapısı, dönem, üslup, bölüm planı ve metnin kendisi düşünülebilir. Ancak romanın neden yazıldığı sorulduğunda problem alanı genişleyebilir. Roman yalnızca kişisel olarak yazılacak bir metin mi olacaktır? Bitmiş bir elyazması mı hedeflenmektedir? Basılacak mıdır? Yayıncı bulunacak mıdır? Okura ulaşması mı amaçlanmaktadır? Dağıtım, fiyatlama, reklam, PR, sosyal medya veya yazarlık kariyeri gibi konular işin parçası mıdır? Bunların hiçbiri kullanıcının ilk cümlesinde bulunmak zorunda değildir.

Bu yüzden kullanıcının söylediği ilk talep ile sistemin üzerinde çalışacağı gerçek problem alanı arasında bir keşif süreci gerekir. Buradaki önemli nokta, SOUL'un kullanıcının söylediğini keyfî biçimde genişletmesi değildir. "Roman yaz" denildi diye otomatik olarak yayıncılık şirketi kurmak veya bütün olası konuları işe dahil etmek doğru olmaz. Kullanıcı gerçekten yalnızca kendisi için bir roman yazmak istiyor olabilir. Ama sistem bu ihtimallerin varlığından habersiz de olmamalıdır. Dolayısıyla SOUL'un görevi yalnızca verilen talebi uygulamak değil, talebin hangi sonuca ulaşmak için verildiğini, hangi kapsamın gerçekten gerekli olduğunu ve hangi belirsizliklerin işi değiştirebileceğini keşfetmektir.

Roman analojisinin ikinci ve daha önemli tarafı burada ortaya çıkar. Bu keşfin tamamen bitmesini bekleyip sonra execution'a geçmek de doğru değildir. Klasik ve fazla basit model şöyle düşünülebilir: `Talebi anla → planı tamamla → execution'a başla`. Roman örneği bunun neden yetersiz olduğunu gösteriyor. Bir romanın yazılmaya başlanabilmesi için bütün yayıncılık sürecinin önceden çözülmesi gerekmez. Romanın konusu, yönü ve gerekli temel yaratıcı kararları yeterince anlaşılmışsa ilk bölüm yazılabilir. Yani problem tanımı bütünüyle kapanmamış olsa bile ilk Work'ü güvenli biçimde başlatmak için yeterli bilgi oluşmuş olabilir.

Fakat execution başladığında yeni bilgiler ortaya çıkar. Örneğin başlangıçta romanın dağıtımı ayrı bir iş olarak düşünülmüş olabilir. Daha sonra bir yayıncıyla çalışılacağı öğrenilir ve yayıncının dağıtımı zaten yönettiği anlaşılır. Bu durumda önceden Work listesinde bulunan "dağıtım şirketi bul" işi tamamen ortadan kalkabilir. Ya da roman yazılırken ortaya çıkan yaratıcı bir karar kitabın hedef kitlesini değiştirir. Hedef kitlenin değişmesi yayıncılık stratejisini, editoryal yaklaşımı veya tanıtım yöntemini değiştirebilir.

Burada INFORMATION yalnızca Work'ü beslememektedir. Work de yeni INFORMATION üretmektedir. Bu yeni bilgi tekrar problem tanımını değiştirir. Problem tanımındaki değişiklik Work'ü yeniden planlatır. Ortaya çıkan yapı doğrusal değil, döngüseldir: `Kullanıcı talebi → anlamlandırma → yeterli problem tanımı → Work → yeni bilgi → problem tanımının değişmesi → Work'ün yeniden düzenlenmesi → yeni Work → yeni bilgi...` Dolayısıyla "anlama" ve "execution" birbirinden kesin sınırlarla ayrılan iki faz değildir.

Daha doğru yaklaşım şudur: Sistem, mevcut bilgiyle hangi işlerin artık güvenle yapılabileceğini belirler. İlk işin değişmesini gerektirecek kritik belirsizlikler yeterince azaldığında o işi başlatır. Fakat aynı anda problem tanımının henüz tamamen kapanmadığını bilir. İlk Work yürütülürken ortaya çıkan bilgi tekrar değerlendirilir. Eğer yeni bilgi yalnız sonraki işleri etkiliyorsa plan güncellenir ve ilerlenir. Eğer yeni bilgi yapılan ilk işi de geçersiz hale getiriyorsa, gerektiğinde ilk iş yeniden yapılır.

Bu nedenle başlangıç koşulu "Problemi tamamen anladık." değildir. Daha doğru koşul şuna yakındır: "Mevcut anlayışımız, sıradaki işi yapmanın makul olduğuna yetecek kadar güçlü ve o işi değiştirebilecek kritik belirsizliklerin farkındayız."

Bu ayrım SOUL için önemlidir çünkü gerçek dünyadaki büyük işler çoğu zaman baştan eksiksiz tanımlanamaz. Araştırma, tasarım, yazılım geliştirme, şirket kurma, ürün geliştirme veya roman yazma gibi işlerde sistem hem çalışır hem öğrenir. Öğrendikleri yalnız mevcut işi nasıl yapacağını değil, aslında hangi işin yapılması gerektiğini de değiştirebilir. Bu yüzden SOUL'un Work sistemi statik bir görev listesi gibi düşünülemez. Work yaşayan bir yapıdır. Aynı şekilde INFORMATION da yalnızca başlangıçta toplanan bağlam değildir. Work sırasında sürekli üretilen, problem tanımını ve sonraki işleri değiştirebilen aktif bir sistem bileşenidir.

Roman analojisi esas olarak bu iki fikri görünür hale getirir: Birincisi: Kullanıcının söylediği talep, gerçek Work değildir. Önce talebin arkasındaki amaç ve problem alanı keşfedilmelidir. İkincisi: Bu keşif tamamlanıp kapatıldıktan sonra execution başlamaz. Problem tanımı, INFORMATION ve Work execution boyunca birbirlerini değiştirmeye devam eder.

Dolayısıyla iyi bir SOUL sistemi yalnızca "ne yapacağım?" sorusunu cevaplamamalıdır. Sürekli olarak şunları da değerlendirmelidir:

- Şu anda gerçekten neyi başarmaya çalışıyoruz?
- Mevcut bilgi sıradaki işi yapmak için yeterli mi?
- Hangi belirsizlikler bu işi değiştirebilir?
- Yaptığımız Work bize hangi yeni bilgiyi verdi?
- Bu bilgi problem tanımımızı değiştirdi mi?
- Plan veya Work sırası değişmeli mi?
- Daha önce gerekli sandığımız bir iş artık gereksiz mi?
- Daha önce görmediğimiz yeni bir Work ortaya çıktı mı?

Roman yazan insan da benzer biçimde davranır. Romanı yazarken yalnız mevcut cümleyi düşünmez. Hikâyenin nereye gittiğini, kitabın ne olacağını ve ileride karşılaşacağı sorunları zihninin bir bölümünde taşır. Fakat bütün bu sorunları çözmeden ilk cümleyi yazmayı reddetmez. Aynı zamanda ilk cümleyi yazdıktan sonra da başlangıçtaki planını dokunulmaz kabul etmez.

SOUL'dan beklenen çalışma biçimi de buna benzer: yeterince anlayınca hareket etmek, hareket ederken öğrenmek ve öğrendikçe hem işi hem de işin tanımını gerektiğinde yeniden kurmak.

## Builder's assessment (English)

**Builder installation.** This conversation is an instance of the failure the analogy describes.
- The builder took "design your operating model" as Work and built mechanisms at once. It did not first discover the problem behind the request: the whole installation must run robustly.
- New information from execution (delivery as notifications, the classifier's merge block) was used only to choose the next patch. The builder never asked whether the problem definition had changed.
- The work list in `plan/ledger.md` is a static task table, with no dependencies, no staleness and no invalidation.

**DevOS.** The plan's C00 to C12 sequence is largely linear: understand, then build. Changing the plan is possible (§14, recorded plan changes), but it is treated as an exception, not as the normal course.

**SOUL.** The analogy matches the Foundation research's Work and Information grounds. The RPD study carries the same ideas mechanically: ready versus completed; staleness that propagates when an upstream item changes; resumable open discovery with a return point.

**Limits to design in.**
1. *Thrash.* Re-planning on every new fact prevents progress. Each change must be classified: does it affect only later work, or does it invalidate done work? Each item records the assumptions it rests on, so that a changed assumption marks its dependants stale mechanically.
2. *Scope authority.* Discovery may widen scope (novel → publishing), but the system discovers and proposes; the user decides scope. This is the same split as Batu and the builder: purpose and scope are Batu's, technical choices are the builder's.

**Consequence for W-C00-12** (corrects the builder's own plan). The plan made on 2026-10-02 was to derive all prerequisites for C00 to C12 first, then design, then build. That is the linear model the analogy rejects, an over-correction from patching into over-planning. The start condition is not "we understand everything". It is: "our understanding is strong enough that the next piece is reasonable, and we know the critical uncertainties that could change it." Concretely:
- look at the whole installation enough to name the critical uncertainties;
- build the most foundational, least volatile piece first;
- record what is learned, and re-plan when it changes the problem definition;
- turn the work list into a living structure (dependencies, assumptions per item, staleness).
