# İlk Work İşi Yapmak Değil, Yapılacak İşi Keşfetmektir

SOUL üzerine düşünürken büyük işlerle ilgili önemli bir farkındalık ortaya çıkmıştı:

Kullanıcı bir hedef söylediğinde, sistemin ilk işi çoğu zaman o hedef üzerinde doğrudan çalışmaya başlamak değildir.

İlk iş: Gerçekte hangi işlerin yapılması gerektiğini ortaya çıkarmaktır.

Bunu ilk fark ettiğimde “Aslında ilk iş işi yapmaya başlamak değil, işi ortaya çıkarmak oldu galiba.” şeklinde ifade etmiştim.

Bu ayrım SOUL ile sıradan task-execution agent arasında temel bir fark yaratıyor.

Bir kullanıcı “Bir eğitim yılı boyunca kullanılacak kapsamlı bir 4. sınıf matematik soru bankası üret.” diyebilir.

Bunu doğrudan task listesine çevirmek çok kolaydır:
1. Müfredatı araştır
2. Soruları yaz
3. Kontrol et
4. Yayınla

Ama burada sistem çok düzenli biçimde yanlış işi yapabilir.

Çünkü henüz hangi müfredat, kim kullanacak, “kapsamlı” ne demek, çözümler gerekiyor mu, dijital mi basılı mı, kaliteyi kim kabul edecek, hangi yasal kısıtlar var veya yıl boyunca güncellenecek mi bilmiyoruz.

Dolayısıyla request received ile work understood aynı şey değildir.

Bu durumda ilk production Work soru yazmak olmayabilir. İlk Work Mission Qualification olabilir.

Yani sistem önce hedefin yeterince anlaşılmasını sağlamaya çalışır. Hedef kullanıcıyı netleştirir, müfredat otoritesini belirler, başarı kriterini tanımlar, yayın biçimini netleştirir, kabul mekanizmasını belirler.

Bu noktada henüz ürün üretilmiyor olabilir. Ama sistem boş durmuyor. Çalışılabilir bir çalışma sistemi oluşturuyor.

Sonra daha derin bir ayrım çıktı. Sistemin ilk sorusu bile doğrudan “Hangi task'ları yapacağız?” olmamalı.

Daha önce şu soruyu sorması gerekebilir:

“Hedefin gerçekleşmesi için dünyada hangi koşulların doğru hale gelmesi gerekiyor?”

Örneğin içerik doğru müfredatı kapsamalı, sorular pedagojik olarak uygun olmalı, matematiksel doğruluk sağlanmalı, yayın ortamı hazır olmalı, hatalar sonradan düzeltilebilmeli.

Bunlar henüz task değildir. Bunlar Need / required condition seviyesindedir.

Bir condition'ı sağlamak için farklı yöntemler olabilir. Dolayısıyla daha doğru zincir şu olabilir:

Target → Needs / Conditions → Possible Methods → Decisions → Work → Actions

Bu ayrım önemli çünkü otherwise ihtiyacı task sanıp erken çözüm seçebiliriz.

Büyük işlerde yapılması gereken işlerin tamamı başlangıçta görünmeyebilir.

Örneğin sistem “Doğru kapsam için authoritative curriculum lazım.” diye fark eder. Buradan yeni Work çıkar: Curriculum'u edin ve analiz et.

Bu Work yapılırken müfredatta prerequisite ilişkileri olduğu öğrenilir. Yeni ihtiyaç çıkıyor. Yeni Work: prerequisite ilişkilerini analiz et.

Bu Work başka bir ihtiyacı ortaya çıkarabilir.

Dolayısıyla Work discovery tek seferlik planning fazı değildir. Recursive bir yapı oluşabilir:

bir Work keşfet → çalış → yeni gerçeklik öğren → yeni ihtiyaç fark et → yeni Work keşfet → devam et

Bu yüzden SOUL'un Work modeli tamamen başlangıçta oluşturulmuş bir task graph olmamalı.

Burada başka kritik bir ayrım var: Plan, Work'ün kendisi değildir. Plan büyük ölçüde Work hakkında Information'dır.

PLAN.md “Curriculum analysis complete.” yazabilir ama gerçek Work hâlâ yapılmamış olabilir.

Bu yüzden planned, admitted, ready, executing, completed gibi durumları birbirine karıştırmamak gerekir.

SOUL bir Work ihtiyacı fark etti diye o Work otomatik olarak yürütülmemeli. Örneğin “500 öğretmenle pilot yapalım.” faydalı olabilir ama pahalı, scope dışı veya authorization gerektiriyor olabilir.

Dolayısıyla şu ayrım gerekir:

Discovered Work → Proposed Work → Qualified / Selected → Admitted Work

Faydalı görünen iş ile yapılmasına karar verilen iş aynı şey değildir.

Bir Work kabul edilmiş olabilir ama henüz başlanabilir olmayabilir. Örneğin Curriculum interpretation yapılması gerektiği kabul edilmiş olsun. Ama authoritative curriculum source henüz elde edilmemişse Work ready değildir.

Gerçek readiness; gerekli prerequisite Work, gerekli Information, uygun Actor, Environment capability ve Control izninin birlikte değerlendirilmesini gerektirebilir.

OPEN ile READY aynı şey değildir.

Büyük işlerde tek bir next task da olmayabilir. Aynı anda birkaç Work başlanabilir durumda olabilir. Bu yüzden daha doğru model Actionable Frontier olabilir.

Ama burada bile:

Ready ≠ High priority ≠ Selected ≠ Assigned ≠ Executing

Bu durumları birbirine karıştırmamak gerekir.

Bu yaklaşım Actor tasarımını da değiştiriyor.

Başlangıçta “Researcher lazım, verifier lazım, coordinator lazım.” diye rol isimleri uydurmak kolaydır. Daha sağlam yol şu:

Work demand → required capability → role → Actor

Önce gerçek Work ihtiyacı ortaya çıkar. Sonra o Work'ün hangi capability'ye ihtiyacı olduğu anlaşılır. Sonra role tasarlanır. Sonra Actor oluşturulur.

Bu, Actor yapısının tasarımcının kafasından değil, işin gerçek talebinden türemesini sağlar.

Task runner'a “Bunları yap.” denir. SOUL'dan beklediğim daha zor:

Hedef bu. Önce hangi koşulların gerekli olduğunu keşfet. Sonra hangi Work'lerin gerektiğini çıkar. Hangi Work'lerin gerçekten kabul edilmesi gerektiğini değerlendir. Hangilerinin ready olduğunu bul. Sonra doğru Actor yapısını oluştur ve execution'a geç.

Bu nedenle SOUL'un zekâsı yalnız task execution'da ölçülmemelidir. Belki daha zor capability şudur: Doğru Work'ü bulmak.

Planning başlangıçta biten bir faaliyet değildir. Daha çok:

anla → Work keşfet → plan oluştur → çalış → öğren → yeni Work keşfet → planı değiştir → devam et

şeklinde bütün yaşam döngüsüne dağılır.

Development OS'un da aynı hataya düşmemesi gerekir. Hedef “SOUL'u yaratmak.” Bundan doğrudan memory sistemi yap, agent yap, UI yap, orchestration yap gibi task listesi çıkarmak erken olabilir.

Development OS'un ilk gerçek işi SOUL'un ortaya çıkabilmesi için hangi koşulların, mekanizmaların ve Work'lerin gerektiğini keşfetmek olmalıdır.

Intent ≠ Work.
Need ≠ Work.
Discovered Work ≠ Admitted Work.
Admitted Work ≠ Ready Work.
Ready Work ≠ Selected Work.
Selected Work ≠ Executed Work.

Ve en önemlisi: Work discovery'nin kendisi de Work'tür.
