# Ev, Gökdelen, Köpek Kulübesi ve Alet Çantası: İşin Büyüklüğü ile Düşünme Kalitesini Ayırmak

SOUL ve Development OS üzerine düşünürken önem verdiğim konulardan biri şu ayrımdı:

Yapılacak işin büyüklüğü değişebilir; fakat işi ele alma kalitesinin buna paralel olarak düşmesi gerekmemelidir.

Bunu anlatmak için ev, gökdelen ve hatta köpek kulübesi üzerinden bir analoji kurmuştum.

Bir gökdelen inşa etmek ile tek katlı bir ev yapmak aynı büyüklükte işler değildir. Gökdelenin temeli daha derin olabilir, statik hesabı çok daha karmaşık olabilir, daha fazla uzman gerektirebilir, daha fazla kontrol noktası olabilir ve daha uzun sürmesi gerekebilir.

Tek katlı evde bunların ölçeği küçülür. Ama buradan “Ev küçük olduğu için mühendislik kalitesini de düşürelim.” sonucu çıkmaz.

Evin temeli gökdeleninki kadar derin olmak zorunda değildir. Fakat temel gerekip gerekmediğini doğru değerlendirme, taşıyıcı sistemi düşünme, uygun uzmanlığa başvurma, mimari kararları sorgulama ve güvenliği ciddiye alma standartlarının kendisi “küçük iş” diye ortadan kalkmamalıdır.

Derinlik ve efor ihtiyaca göre ölçeklenir; düşünme standardı değil.

Bu ayrım SOUL için önemli. Çünkü küçük bir görev geldiğinde sistemin “Bu zaten basit bir iş, çok düşünmeye gerek yok.” şeklinde davranmasını istemiyorum.

Doğru yaklaşım daha çok şu olmalı: “Bu iş küçük olabilir. O halde gerekli analiz kısa sürebilir, az sayıda Actor gerekebilir ve az sayıda Work oluşturulabilir. Ama neyin gerekli olduğuna yine yeterli muhakeme kalitesiyle karar verilmelidir.”

İşin karmaşıklığı ile muhakemenin ciddiyeti aynı değişken değildir.

Analojiyi biraz daha ileri götürmüştüm. Tek katlı bir ev yapılacak diye tesisat çizimini doğrudan tesisat ustasına bırakmak zorunda değiliz. Hâlâ mimari veya mühendislik bakışı gerekebilir.

Daha da ileri gidelim: Bir köpek kulübesi yapıyoruz.

İlk tepki şu olabilir: “Bunun için mimara mı ihtiyaç var?” Belki gerçekten yoktur. Ama önemli soru şudur: Mimara gerek olmadığı kararını kim verdi?

Uzman olmayan iş sahibi mi, yoksa problemi gören uzman mı?

Normal olan uzmanın görüşünün alınmasıdır. Uzman işi değerlendirir ve “Burada benim daha fazla dahil olmama gerek yok.” diyebilir. Bu gayet makul bir sonuçtur.

Ama daha problemi görmeden “Bu küçük iş, burada uzmanlık gereksiz.” demek başka bir şeydir.

Köpek kulübesi örneğinde mimar çok karmaşık bir çalışma yapmayabilir. Ancak köpeğin cinsi, vücut ölçüleri, kapı yüksekliği, giriş açısı, havalandırma veya yağmurdan korunma gibi sıradan görünen bir ayrıntıda bile uzman olmayan kişinin aklına gelmeyen basit fakat önemli bir karar verebilir.

Bunun özü şu: Bir uzmanlığın ne kadar gerektiğine, mümkün olduğunca o uzmanlığın problemi görmesinden sonra karar verilmelidir.

Bu düşüncenin SOUL'a karşılığı güçlü. Yeni bir Work ortaya çıktığında önce “Bu görev küçük, şu uzmanlara ihtiyacımız yok.” demek yerine sistem “Bu iş hangi uzmanlık alanlarına dokunuyor ve bu uzmanlıkların burada ne kadar involvement gerektirdiğine nasıl karar vermeliyiz?” diye düşünmeli.

Uzmanın cevabı sonuçta gerçekten “Bana gerek yok.” olabilir. Ama bu, uzmanlığın hiç hesaba katılmamasından farklıdır.

Bu analojinin daha önemli ikinci katmanı şudur: Gerçek dünyada “mimarı çağırmak” dediğimizde yalnızca bir insan bedenini çağırmayız.

Mimar beraberinde üniversite eğitimi, mesleki eğitim, yıllar boyunca biriken deneyim, daha önce yaptığı projeler, hatırladığı hatalar, çalışma yöntemleri, çizim alışkanlıkları, mesleki standartlar, referans dokümanları ve kendine özgü muhakeme biçimini getirir.

Yani Mimar = yalnızca Actor değildir. Mimarın etrafında geniş bir Information ve capability çevresi vardır.

SOUL'da bir agent yaratmak ise doğal olarak aynı sonucu üretmeyebilir. LLM tabanlı bir Actor'ın belirli bir meslek insanı gibi yıllarca biriktirdiği kişisel çalışma geçmişi ve devamlı belleği otomatik olarak mevcut olmayabilir.

Dolayısıyla “Mimar Agent oluşturduk.” demek, gerçek dünyada “Projeye deneyimli bir mimar dahil ettik.” demekle otomatik olarak eşdeğer değildir.

Bir SOUL Actor'ı fiilen şu birleşime daha yakın olabilir:

model + rol amacı + gerekli Information + çalışma geçmişi + yöntemler + protokoller + araçlar + mevcut Work bağlamı + yetki + sınırlar

Bunların hepsinin her durumda ayrı dosya veya ayrı subsystem olması gerektiğini söylemiyorum. Asıl fikir mimari nesne sayısı değil.

Aktörün kalitesi yalnız underlying modelin zekâsından gelmez. Aktörün çalışırken erişebildiği entelektüel çevre de davranışının bir parçasıdır.

Aynı düşünceyi daha kısa başka bir analojiyle de ifade etmiştim: Usta yalnızca bir çivi çakacak diye işe yalnızca çekiç alıp gitmez. Alet çantası hazırdır.

O işte tornavidaya, penseye, metreye veya su terazisine ihtiyaç olmayabilir. Ama usta işi görmeden önce “Bugün sadece çekiç gerekir.” varsayımıyla bütün capability çevresini terk etmez.

Amaç bütün bilgi ve araçları her Work'e yüklemek değildir. Ama gerekli olabilecek capability'lerin ulaşılabilir, discoverable ve gerektiğinde aktive edilebilir olmasıdır.

İyi çalışma düzeni “her şeyi her zaman yükle” değil, “gerektiğini fark et → doğru capability'yi çağır → yeterli derinlikte kullan” şeklinde olmalıdır.

Gökdelen üzerinde çalışan Actor'ın daha fazla hesap yapması doğaldır. Köpek kulübesi üzerinde çalışan Actor'ın daha az hesap yapması da doğaldır. Ama ikisinin de problemi anlamaya çalışması, kritik varsayımları sorgulaması, gerektiğinde uzmanlığa başvurması ve kullanılan bilginin doğruluğunu önemsemesi beklenmelidir.

SOUL'da yüksek kaliteyi “Her işi devasa hale getirmek” olarak değil, “Her işi hak ettiği büyüklükte, fakat aynı epistemik ciddiyetle ele almak” olarak düşünüyorum.

Basit sonuç ile yüzeysel düşünce aynı şey değildir.
