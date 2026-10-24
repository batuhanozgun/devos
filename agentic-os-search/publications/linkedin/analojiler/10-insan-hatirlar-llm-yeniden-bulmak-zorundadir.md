# İnsan Hatırlar, LLM Yeniden Bulmak Zorundadır: Hafızanın Mekanik Erişim Zinciri

SOUL ve Development OS açısından memory üzerine düşünürken benim için önemli hale gelen ayrımlardan biri şu oldu:

İnsan açısından bir bilgiye sahip olmak ile LLM tabanlı bir Actor açısından bir bilginin dışarıda saklanmış olması aynı şey değildir.

Bunu biyolojik insan hafızasının eksiksiz veya otomatik çalıştığı şeklinde literal bir iddia olarak söylemiyorum. İnsan da unutur, yanlış hatırlar, çağrışımlarla çalışır.

Buradaki analoji daha temel bir sistem farkını görünür kılmak için.

Bir insan bir şeyi öğrenip hayatına dahil ettiğinde, o bilgi artık aynı kişinin geçmiş deneyiminin parçasıdır. Daha sonra düşünürken bu geçmiş birikime doğal bir süreklilik içinde erişebilir.

LLM tabanlı bir Actor için ise dışarıya yazılmış bilgi böyle otomatik bir sürekliliğe dönüşmez.

Bir Actor bugün “X kararını Y gerekçesiyle aldık.” bilgisini öğrenebilir ve bunu bir dosyaya yazabilir. Session kapanır. Yarın aynı underlying model yeniden çalıştırılır. Dosya hâlâ disktedir. Ama yeni Actor instance'ının o dosyayı görmesini sağlayan hiçbir şey yoksa, çalışma açısından bilgi fiilen mevcut değildir.

Dolayısıyla çok önemli bir ayrım ortaya çıkar:

Bilginin var olması ile Actor'ın o bilgiye erişebilmesi aynı şey değildir.

Bir adım daha ileri gidersek Actor'ın bilgiye erişebilmesi ile gerektiği anda o bilgiye erişmesi de aynı şey değildir.

İnsan eski bir deneyimini hatırladığında gündelik olarak şöyle düşünmeyiz:
1. hangi klasörde olduğunu bul,
2. index'ten dosya adresini öğren,
3. dosyayı aç,
4. ilgili paragrafı retrieve et,
5. current düşünce context'ine ekle,
6. sonra reasoning'e devam et.

İnsan açısından bunların önemli bir bölümü bilişsel sistemin içinde görünmez biçimde gerçekleşir.

LLM tabanlı sistemde ise benzer sürekliliği kurmak istiyorsak bu mekanik zincirin parçalarını dışarıda tasarlamamız gerekebilir:

Work başlar → Actor hangi bilgiye ihtiyaç duyduğunu fark eder → ilgili memory alanını bulur → doğru kaydı seçer → kaydın current olup olmadığını kontrol eder → gereken kısmı okur → bilgiyi current context'e getirir → reasoning içinde kullanır

Bu zincirin herhangi bir parçası yoksa, bilginin diskte bulunması yeterli olmayabilir.

Bu yüzden LLM memory'sinde asıl problem yalnızca “Bilgiyi nereye yazacağız?” değildir. Daha zor soru şudur: “Bir sonraki Actor bu bilginin varlığını nasıl fark edecek?”

Bir Actor çalışma sırasında çok iyi bir bulgu üretebilir. Bunu düzgün bir dosyaya yazar. Teknik olarak persistence sağlanmıştır. Fakat yeni session başladığında Actor yalnız kullanıcının yeni mesajını görüyorsa bu bilgi reasoning'e girmeyebilir.

Böylece sistem tuhaf bir duruma düşer: Bilgiye sahiptir ama bilmiyormuş gibi davranır.

Bu nedenle persistence ile memory arasında bir boşluk vardır.

write ≠ remember
stored ≠ retrievable ≠ retrieved ≠ used

Stored: Bilgi bir yerde fiziksel olarak duruyor.
Retrievable: Bilgiye ulaşmanın bir yolu var.
Retrieved: Current Work sırasında bilgi gerçekten geri getirildi.
Used: Actor bilgiyi yalnızca gördü değil; mevcut muhakemede doğru biçimde kullandı.

Gerçek memory sisteminin bu zincirin tamamını düşünmesi gerekiyor.

Burada recursive bir problem de ortaya çıkıyor. Diyelim önemli bilgi memory/project-decisions/D042.md dosyasında. Yeni Actor bunu nasıl bulacak? Belki bir INDEX.md vardır. O zaman Actor önce INDEX.md dosyasını okumalıdır. Peki INDEX.md okunması gerektiğini nasıl bilecek? Belki başlangıç prompt'u söyler. Belki bir AGENT.md söyler. Belki hook otomatik olarak getirir. Belki retrieval engine Work'e bakıp ilgili memory alanını seçer. Belki başka bir Actor context hazırlayıp verir.

Yani bir bilginin saklanması yalnızca başlangıçtır. Asıl mekanizma “Bilgiye giden yolun kendisi nasıl hatırlanacak?” sorusuna kadar uzanır.

Bu nedenle memory architecture'da bir çeşit bootstrap problemi vardır.

Bir dosyanın fiziksel olarak yeniden yaratılması gerekmez. Ama Actor'ın kullanılabilir memory kümesi açısından o bilgi her session yeniden görünür hale gelmek zorundadır.

Disk açısından file already exists olabilir. Fakat Actor açısından information becomes available now olayı yeniden gerçekleşir.

Bu yüzden external memory'de retrieval'ı yalnız arama olarak değil, bilginin çalışma dünyasına yeniden sokulması olarak düşünmek yararlı olabilir.

Buradan context construction'ın memory'nin parçası olduğu sonucu çıkar. Zincir şöyle görünür:

experience → record → persistent memory → retrieval → context construction → reasoning → new experience → memory update

Bu bir döngüdür. Memory yalnız geçmişe bakmaz. Bir sonraki reasoning'in hazırlanmasına hizmet eder.

Bu problem fark edildiğinde kolay ama yanlış bir çözüm ortaya çıkabilir: “O zaman bütün memory'yi her session başında modele verelim.” Bunu istemiyorum.

Uzun ömürlü bir SOUL'da memory büyüdükçe bu yöntem gereksiz context, dikkat dağılması, stale bilgi, çelişkili kayıtlar, yüksek maliyet ve önemli sinyalin gürültü içinde kaybolması gibi sorunlar üretebilir.

İnsan analojisinden “Her şeyi hatırla.” sonucu çıkmamalı. Daha doğru hedef “Gerektiğinde doğru şeyi hatırlayabil.” olmalıdır.

Burada intelligence yalnız içerikte değil, retrieval kararında da gerekir.

Retrieval problemini yalnız “Query'ye benzeyen kayıtları getir.” şeklinde düşünmek de yetersiz olabilir. Bazen Actor'ın ihtiyacı olan bilgi current prompt'taki kelimelere hiç benzemeyebilir. Kullanıcı yeni bir özellik isteyebilir; relevant memory ise “Geçen ay bu subsystem'in şu bağımlılığı değiştirilmemeli diye karar verildi.” olabilir.

Kelime benzerliği zayıf olsa bile karar kritiktir.

Bir başka fark da şudur: Bir LLM Actor bugün bir sonuç üretebilir, çok iyi reasoning yapar, sonucu dosyaya yazar. Yarın aynı model yeni session'da çalışır. O sonucu üreten model olmasına rağmen, geçmiş session context'i verilmezse kendi ürettiği sonucu bilmiyor olabilir.

Bu nedenle Actor continuity ile model identity aynı şey değildir.

Same model ≠ same Actor history.

Aynı underlying modelin kullanılması Actor continuity sağlamaz. Actor'ı sürdürülebilir hale getiren şey model + role + current Work + recovered information + history + authority birleşimine daha yakın olabilir.

Development OS uzun sürecek. SOUL da uzun süren işler yürütecek. Bu sistemlerde çok iyi reasoning yapan Actor tek başına yeterli değil. Reasoning sonucu zaman içinde kayboluyorsa sistem sürekli yeniden düşünür.

Bu üç farklı maliyet yaratır:
1. Tekrar maliyeti: aynı araştırma veya karar yeniden yapılır.
2. Drift: yeni Actor aynı problemi başka framing ile ele alıp geçmiş kararlarla çelişebilir.
3. Yanlış süreklilik: Actor eski sonucu bilir ama neden öyle karar verildiğini bilmez.

Gerçek continuity yalnız sonucu değil, gerektiği ölçüde gerekçeyi, kaynağı, koşulları, belirsizliği ve yetkiyi de recover edebilmelidir.

İnsanda büyük ölçüde içeride olan geçmiş, deneyim, çalışma alışkanlığı, öğrenilmiş ders ve unfinished business farkındalığı LLM agent sisteminde dosya, database, router, index, state, handoff, retrieval ve context builder gibi dış yapılara dönüşebilir.

Bu yapılar modelin yerine düşünmez. Ama modelin daha önce öğrenilmiş şeyleri kullanarak düşünmeye devam edebilmesini sağlar.

SOUL için “memory var mı?” sorusu fazla zayıf geliyor. Daha doğru sorular şunlar:
- Bilgi nereye yazılıyor?
- Kim yazıyor?
- Hangi statüyle yazılıyor?
- Daha sonra bu bilginin varlığını kim fark ediyor?
- Actor hangi Work için hangi memory'yi arayacağını nasıl biliyor?
- Retrieved bilginin current olup olmadığını nasıl anlıyor?
- Session değiştiğinde Work continuity gerçekten recover edilebiliyor mu?

Bunlardan yalnız ilki cevaplandıysa henüz memory problemini çözmüş sayılmamalıyız.

Hafıza, bilginin bir yerde mevcut olması değil; geçmiş bilginin gelecekteki düşünceye güvenilir biçimde yeniden katılabilmesidir.
