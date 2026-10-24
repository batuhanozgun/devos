# Builder–Verifier Ayrımı: Aktörün Çalışma Rolünde Tek ve Çelişkisiz Amaç

SOUL ve Development OS üzerine düşünürken önem verdiğim konulardan biri, bir agent'ın veya daha genel ifadeyle bir aktörün hangi motivasyonla çalıştığıdır.

Burada “motivasyon” derken karakter özelliği, kişilik veya prompt'a yazılmış yüzeysel bir rol tanımını kastetmiyorum. Daha temel bir şeyden bahsediyorum: Bir aktör, belirli bir işi yaparken hangi sonuca doğru çekiliyor? Neyi başarmaya çalışıyor?

Bunu ilk olarak “bir agent'ın birden fazla motivasyonu olmamalı” şeklinde ifade etmiştim. Sonra bunun fazla kaba bir ifade olduğunu fark ettik ve ayrımı daha doğru yere taşıdık.

Asıl mesele aynı temel modelin yalnızca tek işi yapabilmesi değildir. Aynı model farklı zamanlarda farklı görevleri üstlenebilir. Aynı agent altyapısı bir işte yazılımcı, başka bir işte verifier, başka bir işte araştırmacı olabilir.

Fakat belirli bir çalışma anında üstlendiği rolün terminal amacı çelişkili olmamalıdır.

Bunu anlamak için kullandığım basit örnek yazılım geliştirme ve test etme örneğiydi.

Bir agent'a “Bu yazılımı yaz.” dediğimizi düşünelim. Bu aktörün doğal çalışma yönü uygulamayı ortaya çıkarmaktır. Problemleri çözmek, eksikleri tamamlamak, çalışan bir sonuç üretmek ve işi ilerletmek ister. Kabaca amacı “Ürünü ortaya çıkar.” şeklindedir.

Fakat aynı aktöre aynı çalışma bağlamında bir de “Kodda hata kalmadığından emin ol. Her şeyi sorgula, hataları bul.” dediğimizi düşünelim.

Burada farklı bir çalışma yönü ortaya çıkar.

Gerçek bir verifier'ın amacı işi mümkün olduğunca hızlı bitirmek değildir. Tam tersine, “bitti” denilen şeyin gerçekten bitmiş olup olmadığını sorgulamalıdır. Onun görevi hata aramak, varsayımları sorgulamak, beklenmeyen durumları denemek, yanlış pozitif başarıyı engellemek, gerekirse işi yeniden açtırmak ve üreticinin gözden kaçırdığı problemleri bulmaktır.

Bu nedenle verifier'ın doğal yönü kabaca şöyledir: “Henüz bitmiş kabul etme; yanlış olabileceği yerleri bul.”

Bu iki davranış da gereklidir. Sorun bunların ikisinin de gerekli olması değildir. Sorun, aynı çalışma rolünün içinde birbirine ters iki terminal amacı aynı anda taşımaya çalışmaktır.

Bir tarafta “İşi tamamla, çalışan ürünü ortaya çıkar.” Diğer tarafta “İşin tamamlandığı iddiasına güvenme, hata bulmaya devam et.”

Bunları tek bir rol kimliğine sıkıştırdığımızda yapısal bir gerilim oluşur. Agent kodu yazarken kendi yaptığı çözümü ilerletmek ister. Bir çözüm yolu seçer, ona yatırım yapar, kararlar verir ve tamamlanmaya doğru hareket eder. Sonra aynı bilişsel çerçeveyle kendi çözümünü doğrulamaya çalıştığında, gerçekten bağımsız bir verifier gibi davranması beklenir.

Ama artık çözümün üreticisidir. Seçtiği yaklaşımı bilir. Neden o yolu seçtiğini bilir. Kendi varsayımlarını taşır. Kendi yaptığı işin tamamlanmasını ister. Ve aynı anda bunlardan bağımsızmış gibi çözümün neden yanlış olabileceğini araştırması beklenir.

Bu, yalnızca “agent yeterince iyi düşünürse aşılacak” basit bir problem değildir. Çalışma sisteminin tasarımında dikkate alınması gereken yapısal bir gerilimdir.

Bir aktörün birden fazla fonksiyonu olabilir. Bir yazılımcı kod yazabilir, çalıştırabilir, temel testleri yapabilir, hata görürse düzeltebilir, dokümantasyon yazabilir. Bunların hepsi aynı rolün içinde bulunabilir.

Dolayısıyla “tek motivasyon” demek “Bir agent yalnızca tek fonksiyon yapmalıdır.” demek değildir. Sorun fonksiyonların çokluğu değil, terminal amaçların çatışmasıdır.

Bir builder kod yazarken test çalıştırabilir. Bu testler kendi üretim faaliyetinin parçası olabilir: “Yaptığım şeyi yeterince sağlam biçimde ortaya çıkarayım.” Ama sistem gerçekten “Builder'ın doğru olduğuna inanmak için yeterli sebebimiz var mı?” sorusunu sormak istiyorsa artık farklı bir epistemik görev başlamıştır.

Bu görevde aktörün amacı builder'ın işini bitirmesine yardım etmek değil, onun iddiasını sınamaktır.

Bu yüzden şu formül daha doğru geliyor:

Bir aktörün belirli bir çalışma rolündeki terminal amacı tek ve çelişkisiz olmalıdır. Çelişen terminal amaçlar farklı aktörlere veya açıkça ayrılmış farklı rol-instantiation'larına bölünmelidir.

Aynı temel model yeniden kullanılabilir. Aynı LLM builder olarak çalışabilir, sonra başka bir bağlamda verifier olabilir. Fakat o anda “Ben builder mıyım, verifier mıyım?” sorusunun cevabı belirsiz olmamalıdır.

Başlangıçta meseleyi “Her agent'ın tek motivasyonu olmalı.” şeklinde kuruyordum. Daha doğru ifade şu: Teklik, kalıcı agent kimliğine değil, aktörün o çalışma için üstlendiği role uygulanmalıdır.

Self-check yararlıdır. Builder kendi kodunu test etmelidir. Araştırmacı kendi argümanındaki açıkları aramalıdır. Planlayan aktör kendi planındaki riskleri değerlendirmelidir. Fakat bunların yapılması “Artık bağımsız verification'a gerek yok.” anlamına gelmez.

Çünkü üretici ile verifier aynı framing'i, aynı varsayımları ve aynı kör noktaları paylaşabilir.

Bu fikir yalnızca yazılım testiyle ilgili değildir. Araştırmacı ile karar verici, plan üretici ile plan eleştirmeni, yazar ile editör, hipotez üretici ile falsifier arasında da benzer terminal amaç gerilimleri ortaya çıkabilir.

SOUL büyük bir işi yürütüyorsa çalışma sistemi birbiriyle gerilimli amaçları tanımalı ve bu gerilimi tek bir aktörün belirsiz motivasyonuna bırakmamalıdır.

Bu düşünceden otomatik olarak “Her rol için ayrı bir sürekli çalışan agent process'i olmalıdır.” sonucu çıkmaz. Ayrım farklı agent'lar, aynı modelin ayrı oturumları, ayrı context'ler, ayrı rol-instantiation'ları veya başka mekanizmalarla gerçekleştirilebilir.

Korunması gereken ilke mekanizmadan daha üst seviyededir: Çelişen terminal amaçların birbirlerini sessizce bozmasına izin verme.

Verifier'ın görevi builder'ın başarılı olmasını sağlamak değildir. Görevi gerçeğe ilişkin güveni artırmaktır. Builder gerçekten doğruysa verifier'ın bunu kabul etmesi gerekir. Builder yanlışsa da işin uzamasına, yeniden açılmasına veya reddedilmesine yol açmaktan çekinmemelidir.

Dolayısıyla verifier açısından işin uzaması başarısızlık değildir. Hata bulunması da başarısızlık değildir. Tam tersine, gerçekten var olan bir hatanın bulunması verifier'ın görevini yaptığı anlamına gelir.

Development OS'u tasarlarken yalnızca “Hangi agent hangi işi yapacak?” sorusunu sormak yeterli olmayabilir. Daha temel soru şudur: “Bu Work üzerinde hangi farklı epistemik ve üretim amaçlarının bulunması gerekiyor ve bunlardan hangileri aynı çalışma rolünde güvenli biçimde birleşebilir?”

Özetle: Aynı model birçok rol oynayabilir. Aynı aktör birçok fonksiyon gerçekleştirebilir. Fakat belirli bir çalışma rolünün terminal amacı açık ve çelişkisiz olmalıdır. Builder üretmeye, verifier ise gerçeği sınamaya çalışmalıdır. Sistem bu ayrımı korumazsa “kontrol” varmış gibi görünürken gerçekte üreticinin kendi sonucunu yeniden onayladığı bir döngü oluşabilir.
