# “Hava Bugün Çok…” Analojisi: SOUL Araştırması Modelde Neyi Uyandırmak İçin Var?

SOUL araştırmasını neden bu kadar geniş tuttuğumuzu anlatmak için kullandığım erken analojilerden biri “hava bugün çok…” → “güzel” örneğiydi.

Buradaki amaç LLM'in transformer mimarisini veya token tahmin mekanizmasını teknik olarak birebir tarif etmek değildi. Daha kavramsal bir şeyi anlamaya çalışıyordum:

Bir modelin ürettiği düşünce ve çıktı, önüne gelen bağlam tarafından nasıl yönlendirilir?

Basit bir cümleyi düşünelim: “Hava bugün çok…” Bunun arkasından modelin “güzel” demesi mümkündür.

“Güzel” kelimesi girişte açıkça yazmıyordu. Ama “hava”, “bugün”, “çok” ve bunların oluşturduğu bağlam, modelin içindeki bilgi ve dil örüntülerini belirli bir yönde aktive ederek “güzel” gibi bir devamın ortaya çıkmasını mümkün hale getirir.

Ben SOUL Research repository'sine de buna benzer bir işlev açısından bakıyordum.

Repository'deki araştırmaların amacı yalnızca gelecekte okunacak büyük bir bilgi arşivi oluşturmak değildi. Asıl amaç şuydu:

SOUL hakkında düşünecek LLM'in önüne doğru bağlamı koyarak, modelin aksi halde düşünmeyebileceği önemli mekanizmaları, ayrımları, riskleri ve sistem tasarımlarını düşünce alanına sokmak.

Basitleştirerek:

hava + bugün + çok → güzel

örneğinde olduğu gibi,

kullanıcı talebi + Foundation + studies + geçmiş deneyler + ilgili araştırmalar + SOUL bağlamı → gerekli çalışma sistemine ilişkin daha zengin muhakeme

beklenmektedir.

Bu analojinin önemli tarafı şudur: LLM zaten çok fazla eğitim bilgisine sahip olabilir. Fakat bir bilginin modelin içinde bulunması ile o bilginin mevcut problem üzerinde düşünürken aktif hale gelmesi aynı şey değildir.

Model memory'sinde veya eğitiminde bir kavram bulunabilir ama mevcut context o kavramı çağırmıyorsa cevap oluşturulurken hiç kullanılmayabilir.

SOUL Research'in amaçlarından biri tam olarak bu soruna müdahale etmektir.

Eğer yapılacak şey yalnızca önceden tasarlanmış bir sistemi inşa etmek olsaydı, repository çok daha küçük olabilirdi. Bir mimari doküman yazılırdı, bileşenler tanımlanırdı ve sonra sistem uygulanırdı.

Fakat başlangıç varsayımımız farklıydı: Henüz SOUL'un nasıl olması gerektiğini bilmiyoruz. Daha önemlisi, ne benim teknik bilgim ne de tek bir LLM oturumunun mevcut context'i, SOUL'un ihtiyaç duyabileceği bütün alanları başlangıçta eksiksiz biçimde ortaya koymaya yeterli.

Bu nedenle repository'nin bir başka görevi gelecekte SOUL hakkında düşünecek modele daha zengin bir düşünsel çevre hazırlamak.

Bir araştırmada uzun süreli iş sürekliliği, başka bir araştırmada bellek, başka bir yerde actor authority, başka bir yerde verification, context handoff, planning, multi-agent coordination veya değişiklik etkisi incelenmiş olabilir.

Bu araştırmaların her biri tek başına SOUL mimarisi değildir. Fakat doğru problem üzerinde birlikte görünür hale geldiklerinde modelin “Aslında burada şu problem de var.” demesini sağlayabilirler.

Bu projedeki araştırmaların önemli bir işlevini şu cümleyle tarif etmiştim: SOUL hakkında düşünürken modelin “aslında bu da var” diyebilmesini sağlamak.

Çünkü SOUL gibi büyük bir sistemde en tehlikeli hata yalnızca bildiğimiz bir şeyi yanlış çözmek değildir. Daha tehlikeli hata bazen problemin bir boyutunu hiç düşünmemektir.

Bu fikir “LLM'e mümkün olduğunca çok belge verelim; ne kadar context verirsek o kadar iyi düşünür.” anlamına gelmez. Aşırı context de problem yaratabilir. Gereksiz bilgi sinyali bozabilir. Yanlış araştırma yanlış framing yaratabilir. Eski kararlar güncel karar gibi algılanabilir. Türetilmiş summary özgün kaynağın yerine geçebilir.

Dolayısıyla gerçek hedef maksimum context değil, doğru problem için doğru context'in aktive edilmesi olmalıdır.

Repository bütün araştırmaları her agent'a her zaman okutmak için kurulmuş dev bir prompt değildir. Daha olgun sistemde ihtiyaç şuna dönüşür:

1. Önümüzdeki problem nedir?
2. Bu problem hangi bilgi alanlarını gerektirebilir?
3. Repository'de bununla ilişkili hangi araştırmalar bulunuyor?
4. Hangi derinlikte okumak gerekiyor?
5. Hangi bilgi yalnız aday perspektif, hangisi güçlü bulgu?
6. Hangi özgün kaynaklara geri dönmek gerekiyor?
7. Hangi bilgi bu Work için gereksiz?

Yani yalnız bilgi depolama değil, bağlam oluşturma ve bilgi aktivasyonu problemi vardır.

Bu fikir gelecekte SOUL'un kendisinin de sahip olacağı probleme benzer. SOUL'a yeni bir talep geldiğinde yalnızca kullanıcının mesajı ve modelin eğitim bilgisi üzerinden cevap üretmek yeterli olmayabilir. Talebin gerektirdiği domain bilgisi, geçmiş kararlar, mevcut Work durumu, ilgili araştırmalar, kullanılan yöntemler, hata geçmişi ve başka Actor'ların bulguları arasından doğru olanları bulup çalışma context'ine getirmek gerekebilir.

Dolayısıyla Information yalnızca saklanan şey değildir. Information'ın bir başka görevi vardır: Doğru düşüncenin ortaya çıkabileceği çalışma bağlamını oluşturmak.

Bu nedenle retrieval da yalnız “Sorulan kelimeye benzeyen belgeyi getir.” problemi değildir. Daha zor soru şudur: “Bu işi doğru düşünmek için aktörün neyi görmesi gerekiyor?”

Aynı model yetersiz context altında yüzeysel, yanlış context altında yanlış yönlenmiş, iyi seçilmiş context altında ise çok daha derin bir muhakeme üretebilir.

Dolayısıyla “Hangi model?” sorusu kadar “Bu model ne görerek düşünüyor?” sorusu da önemlidir.

Araştırma repository'sinin değeri yalnız içinde ne bildiğinde değildir. Değeri aynı zamanda doğru zamanda modelin “aslında bu da var” diyebilmesini sağlamasındadır.
