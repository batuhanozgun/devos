# EXP-001 — Kullanıcı mesajları

**Kaynak:** Bu oturumda modele görünür kullanıcı metinleri. **Biçim:** konuşmacı sırası korunarak aktarım; platformun ham export'u değildir. Yazım biçimleri düzeltilmemiştir; tespit edilen aktarım hataları kaynak ifadeye göre giderilir ve checks/TRANSCRIPTION-NOTE.md içinde kaydedilir. U001–U019 kesimi bu arşivleme turunu başlatan kullanıcı mesajında biter. Aralara sonradan eklenen başlıklar yalnız adresleme içindir. Araç mesajları, gizli bağlam ve diğer proje konuşmaları bu dosyada yoktur.

## U001

Biraz sohbet edelim. Konumuz işi takip etme konusu. Araştırma repomuzdan kesinlikle yararlan bu konuyu konuşurken, ayrıca yine de internetten de bakabilirsin. Küçük bir soruyla başlayalım. Soruyu örnek üzerinden soracağım. Soul gibi bie yapımız olduğunu düşün, çok adımlı ve detaylı yönetilmesi gereken ama basit bir iş düşünüyorum mesela kullanıcıdan bilg aldığımız bir form olacak, adı, mail adresi, spor yaparken ısınmak için yaptığı üç hareketi seçecek ve gönderecek. Uygulama bu kadar. Amaç bu bilgiden bir dashboaed hazırlayıp uygulamada ikinci sayfa olarak göstermek. Yani uygulama bilgi al sonra toplandığın bilgilerden bir rapor göster amacında olan bir uygulama. Şimdi soru şu, bunu yapmak için soul yapısında bu proje nasıl işletilir? İşletmekten kastım da şu, work ve infirmation bacağı nasıl bir yapıda olur. Ortada bir iş talebi var, bunu iş olarak ortaya koymak lazım bir de bu işi kayıt altında tutarak agent ekibinin ortak iş üstünde çalışabilmesini sağlamak lazım.

Bir hayal et mesela, talep geldi, sonra ne olur konuşarak bulmaya çalışalım. Küçük adımlarla gideceğiz bir kere de çözmeye çalışma. Bir kerede çözmeye çalışımca yüzeysel oluyor çözüm. Ben derin gidip detayları yakalamak istiyorum.

## U002

Anlamaya çalıştığım şu, örnek uygulama odağımda değil odağımdaki konu repodaki araştırma ve LLM bu araştırmadan veya kendi bilgilerinden ya da internetten yatarlanarak Soul’u nasıl bir yapı gibi düşünüyor, onu düşündüğünde nasıl bir çalışma düzeni kuruyor. Yani en dipte örnek uygulamayı yaparken LLM’in token sistemi nasıl uyarılıyor ve ne çıktı üretiyor bunu anlamak. Çünkü ilk konuşmamızda “hava bugün çok…” örneğinde güzel kelimesini ortaya çıkaran senin mekanizman ama onun çıkmasına sebep olan hava, bugün, çok tokenlarıydı. Şimdi de örnek uygulama, araştırmaların hava, bugün, çok tokenları gibi girdi oluyor, soul yapısı girdi oluyor ve work ve information bacağını yönetmek çıktı oluyor gibi düşünerek soruyorumbu soruları.

## U003

İşte bunu biraz simüle edelim.

Benim şu anda taslak düşüncem şu, önce talep net olarak ortaya konmalı. Ama bir cümle ya da tanım değil, bu uygulama bittiğinde ne vardır ortada bunu düşünmek lazım. Şundan bahsetmiyorum ekranda şu olur, veri şöyle yazılır gibi şeylerden bahsetmiyorum, ama işin büyüklüğünü anlayıp işi öyle tanımlamak lazım bence. Sonra o tanımlamaya göre iş adımları ortaya çıkar. Ekran tasarımı yapılacak, teknoloji seçilecek, veriler saklanacak, ver tabanı lazı , uygulama nerde olacak, app mi web app mi falan filan? İki sorum var yani soul böyle mi düşünecek ve daha da önemli soru böyle mi olması gerekiyor ben sadece akıl yürüttüm bu düşüncede.

Yani (1) böyle mi başlanır bir işe work araştırması ne diyor? Doğrusu ne? Doğruysa (2) soul bunu böyle yapmayı akıl eder mi?

## U004

Evet bundan bahsediyorum. Yani ben kullanıcınıcı olarak A diyorum ama aslında istedğim şey B olarak düşünüyorum, tüm detayları aktaramıyorum ya da aktarmıyorum ya da aktarmam gerektiğini düşünmüyorum ya da o detaylardan haberdar bile değilim. Dolayısı ile aslımda C olması gereken tanım benim düşündüğüm B yazdığım A oluyor. Şimdi Soul’un A’dan C’ye ulaşması gerekiyor. Yani Soul’u yaptık şimdi test ediyoruz anlamında konuşmuyoruz. O yüzden rahat konuşabilirsin olması gereken ya da olmasını hayal ettiğimiz bir konuşma yapıyoruz. Bu konuşma ile hem senin hem benim aynı frekansta bir bağlam yapısma ulaşmasınlazım. Bu konuşma seni eleştirebileceğim bir konuşma değil, biraz hayal biraz akıl yürütüme ve araştırmalar bize ne söylüyor. Aynı zamanda sen de bie LLM olduğun için Soul yapısında LLM’in girdi-çıktı arasındaki düşünce yapısını, yönelimini az çok hayal edebiliyorsun. Bunları eritip bir konuşma serüveni yaşmaya çalışıyorum. Bir yerde bir farkındalık yaşarız diye yapıyorum bunu.

## U005

Evet işte bundan bahsediyorum zaten. “SOUL’a gelen A’yı doğrudan Work kabul etmek bana artık yanlış görünüyor.” Zaten yanlış bence. Kullanıcı hep az bilir, az açıklar, akıl etmez detayları. Ben bunu roman yazmaya benzetiyorum kullanıcı gelip de sana roman yaz dese bu A olur. C ise senin roman ile ilgili, yaıncılık ile ilgili, baskı, basım, dağıtım, raflarda bulunma, fiyatlama, sponsorluk, reklam, PR anlaşmaları, sosyal medya gibi 10’laeca konuyu ele alman demek. Roman deyince okuyucu ve yazar ve konu gibi düşünülebilir ama roman yazmak deyince iş büyüyor, olay roman yazmaktan öteye gidiyor. Ama yazar olarak ben hala roman yazma derdindeyim ama ortaya çıkan roman sadece yazılma eylemini tetiklediğinde yazışmış bir roman oluyor. Ne olacak sonra bu roman, öylece word dokümanı olarak mı kalacak, bir roman ne den yazılır ki? -devam etmiyorum bence anladın amacımı-

Sen daha iyi anladıkça ben onaylayan konumda kalacağım sen ilerlet konuşmayı şimdi doğru kanala girdin, yermizde saymayalım hızlı gidersen yavaşlatırım, oyalanırsan ya da beni aynalarsan fark eder seni düşünmeye teşcik ederm.

## U006

**Ek adresi (arşiv notu):** Bu mesajda özgün el çizimi vardı. Kaynak dosya `sources/original-sketch.png`; byte kimliği SOURCE-MANIFEST.json'da. Görselin remote payload durumu manifestten ayrıca kontrol edilmelidir.

Bence yeterince anladım execution's geçelim hiç bitmeyen bir süreç. Belki zamanla "anlama" işi daha az olacak belki bir yerde bitecek, belki de bir yerde bilerek değiştirilecek ama "bitti, artık execution" yapalım yaklaşımı bence doğru bir yaklaşım değil, mesela romanın içeriği ile dağıtımın olup olmayacağının hiç bağlantısı yok bence. dağıtılacak da olsa dağıtılmayacak da olsa yazılacak romanının içine yazılacak metin kullanıcının yazmak istediği konuyla bağlantılı. yani bazı işler için C'nin içinde "roman yazılacak" denmesi roman yazmaya başlamak için yeterliyken, bazı tanımlar iş ilerledikçe değişebilir. Bu C'nin ne olduğuna sonra karar veririz demek değil ama yapılacak iş ile tanım arasındaki sürekli bir mekanizma var demek.

İnsan roman yazarken, bir yandan da nasıl dağıtacağım acaba bunu diye düşünür, aklının bir kenarındadır ama dağıtılacağının farkında olup, bir ara sürecin bir noktasında o aşamaya gelmesi gerektiğini bilir. Hatta dağıtımcı bulduğu aşamayı düşünelim, belkide bu dağıtım işi yazar tarafından değil, yayıncı kurum tarafından yönetilen bir iş olduğu ortaya çıktığında, C'nin içinde yayıncı konusu hiç düşünülmemişken, birden yayıncı bulunması dağıtım yapacak firma bulmanın önüne geçer hatta dağıtım konusu C'nin içinden çıkar çünkü yayıncı bulunca dağıtım da yapıldığı ortaya çıkmıştır. Bu demek değil ki ilk gün dağıtım yapılacağını ya da yayıncı yapılacağını bulmaya/farkında olmuş olmaya ihtiyaç yoktur ya da illa bulunması gerekir demek istemiyorum. ama bir yerde execution'a başlansa bile C'nin tanımı değişebilir. Önemli olan work tarafında sıralamayı buna göre düzenlemek, yeniden planlamak yani work ve information ikisinden birinin tetiklemesiyle de değişebilir. Bu durumda "bitti, başlayalım execution'a" demek için koşul "C bitti" yerine şu anda "C'ye göre adımlar bunlar, ilk adımı attığımda, ilk adımın değişmeyeceği bir C'ye sahip olduğumu düşünüyorum, eğer ilk adım değişirse ilk adım en baştan bir daha yapılır, değişmezse, ilk adım sonunda (ya da içinde) C yeninden tanımlanabilir ya da ikinci adıma geçilebilir" bilincinde olarak work ve information yönetilmeli. Bunu da yöneten zaten ACTORLER, actor'e girmeyelim ama burada WORK de, INFORMATION'da kendi kendine oluşmuyor sadece bu aklıma geldi birden.

Görselde en başta bir A var, tam gözükmese de sonra senin dediğin gibi C1, C2, C3 var, bahsettiğin gibi work discovery sonunda belki bir C4 oluşuyor, sonra ilk adımı atmak için yeterli sayıldığında Work başlıyor, work ilerlerken, C4 tanımının yeterli olmadığı anlaşılıyor C5 oluşturuluyor, tabi work de değişiyor, work değişiyor c'yi de değiştirebiliyor, ya da C değişiyor yapılacak work de değişiyor. ama ilerledikçe yani iş yapıldıkça aslında zamanla C daha az değişir bence, yani bir işin başında daki A ile C farkı zaman A~=C olmaya başlar bence, çünkü iş ilerledikçe hayal edilen gerçeğe dönüştükçe oluşan gerçeklik C'nin kalan kısmı için daha az olasılıklar yaratılmasına, daha tutarlı senaryolar üretilmesine ve karar verilmesine sebebiyet vereceği için gittikçe stabil hale gelir C. Zaten iş bittiğinde A = C ya da A < C olur. işin başında A > C olacaktır bence, çünkü bilinmezler çok fazla olacaktır, ama zamanla azalır. Önemli olan C'nin oluştuğu hangi an execution'nın başlayacağı andır. Yani ne zaman Information ve Work birlikte ilerlemeye başlar. Ben burda information'ı A ve C olarak düşündüm, C bir aşamaya gelince artık Work başlar ve Information ve Work birlikte etkileşim içinde yürür gibi düşündüm.

## U007

**Bir Work'ün “şimdi başlanabilir” olduğuna SOUL hangi bilgileri kullanarak karar vermeli?**

İşte bunun için deneme yapalım diyorum ben de.

Bu konuşmayı baştan sona tam oku. Bahsettiğim uygulama için bunu konuşalım. Ben seni yönlendirmemek için bir şey yazmayacağım. Bu bildiğim anlamına gelmiyor, aksine bilmediğim için seni dar kalıbın içine sokmak istemiyorum. Sen bir SOUL ajanı olarak ya da birden fazla SOUL ajanın rollerini taklit ederek süreci bir yere kadar getir. İlla uygulamayı yaz demiyorum. Modeli bir deneyelim. Mesela ne düşündün, ne sorguladın, hangi bilgiyi hangi dosyaya yazdın (hayali olarak yazıyorsun gerçekten yazmıyorsun) sonra ilerlet düşünceyi, karşına ne C konusu çıktı, W nasıl değişti, bunları deneyelim.

Önce düşün, araştırmalardan da yararlan, bu seni denemek değil, yani bakalım ne kadar başarılısın ya da akıllısın diye bakmayacağız, bu modelimizi denemek. Bu deneme daha işin başı, yani "tamam oldu" diyeceğimiz bir şey de değil, bu konuşmadaki token'ların sende uyandırdığı yaklaşım ve araştırmalardan elde edeceğin bilgi ile uygulama konusunda nasıl ilerleyebiliyorsun buna baktığımızda aslında bütün bunlar bir LLM'de ne doğuruyor, nasıl çalışmasını sağlıyor bir demosu.

Okuman bitince sanki ben bir kullanıcı olarak SOUL ortamında çalışan ajana "kullanıcılardan, ad, email ve spor yapmadan önce insanların kaslarını ısındırmak için yaptığı üç hareket seçtikleri ve tüm seçimlerin dashboard'da gösterildiği, böylece diğer spor yapmak isteyen insanlara çoğunluğun hangi hareketi yaptığını gösteren bir rapor ekranı olan uygulama yapmanı istiyorum."dediğimi hayal et ve bu konuşmamız boyunca konuştuğumuz konuyu uygula bakalım nasıl bir sonuca varacaksın.

## U008

İtiraz etmiyorum ya da eksiklik buldum diye yanıt vermiyorum. Bu cevabını okuduğumda şunu fark ettim, -bence akış kendi kendine çalışan bir mekanizmaya benziyor, yani SOUL için umut vaad eden bir demo oldu- bu akıştaki kullanılan hayali dosyalar hep işle ilgiliydi, bunları INFORMATION tarafında konumlandırırsak, INFORMATION tarafında bu dosyaları üretmeye yarayan mekanizmanın dosyaları yoktu demonda. Belki olduğunu varsayarak demoyu kurguladın belki de aklına gelmedi ama hayali demondaki kullanılan dosyaları bir liste yapmayı dene, sadece görünür kılmak için yap bunu, yani doğru ya da yanlış diye değil, bu demodaki dosyaları listelediğinde bence yazmadığımız dosyalar var, o dosyaların yerine zaten bu konuşma ve araştırma reposundaki bilgilerle bu demo yapıldı ama SOUL'un github'da kendi kendine durduğunu düşünürsek, SOUL ajanlarının başvuracağı bu konuşma ya da araştırma reposu olmayacak, (bu arada araştırma reposunu SOUL'un hangi bilgisayarda olursa olsun arada oraya başvurmasını sağlamak da kötü bir fikir değil, yani SOUL github'da private olmayan bir repo olduğunu düşün insanların SOUL ile istediği gibi proje yaptığını düşün, kendi bilgisayarına kurdukları SOUL üzerinden üstünde çalıştıkları projede SOUL ajanları bizim araştırma reposuna gidip yararlanabilir de. Çok başka konuya çektim konuyu, burda susuyorum) dolayısıyla SOUL ajanlarının uyduğu ya da yararlandığı bir muhakeme sistemi de olmalı bence.

Hadi dosyaları listele, demo'da hiç adını anmadığımız dosyaları da düşünelim daha görünür olur o zaman bu çalışma modelinin gerçekleri.

## U009

aslında SOUL'da aktör'lerin kullanacağı dosyalar gibi bunlar

## U010

Katılıyorum.
Demo bize bir dünya gösterdi, ama bu dünya tabi ki SOUL'ın bitmiş kapsamlı bir hali değil ama bize küçültülmüş bir mantıkta çalışma prensibi konusunda fikir verdi.

Ben bir de şunu hissettim, yapılan işten çok işi agent'ların yapması için gerekli ortamın büyüklüğü işin hacminden daha büyük gibi duruyor. Yani iş küçük başlıyor belki ama ortam hiç de küçük durmuyor gibi. agent'lar, bilgiler, işin işle ilgili bilgilerini dışarda tuttuğumuzda işin sürdürülebilmesi için gerekli yönergeler, çok fazla kural ve kaide var gibi. Harness dedikleri bu mu oluyor acaba? Sanki işi yapmak kolay kalıyor bunları düşündüğümde. Yani Kullanıcı formu yazmak/kodlamak iş bile değil artık bunların yanında. Asıl o kodlamanın yapılırken etrafında akan çalışma düzenin bozulmadan devam edebilmesi sanki mesele

## U011

Ben aslında büyük olmasından dolayı yakınmadım. Aksine bu işin kapsamlı bir iş olması gerektiğini anladığımı söylemeye çalıştım. Kodlamayı küçümsemedim sadece kodlamada daha ön görülebilir bir dünya var demek istedim.

Bir işin iyi yapılması için bazı kriterlerin işten bağımsız olarak hep en üst kalitede olması gerekir, yani şundan bahsediyorum, örneğin ben bir tek katlı ev yapacaksam da göktelen yapacaksam  her ikisi içinde sağlamlığı için düşünme, akıl yürütme, mimari çizimlerine verdiğim önem, mimari kararlarda verdiğim detay, sorgulama yapım bence en üst seviyede olmalı. Ev için kazacağım temel X metre iken göktelen için kazacağım temel 10X metre olabilir ama her ikisi için de temelin gerekliliği, kolonları ya da inşaat mühendisliğine verdiğim önem değişmez, çalışma disiplinim, başarısız olma kaygım ya da işi hakkıyla yapamama korkum ve bunları ortadan kaldıracak muhakeme yetkinliğimi hep en üst seviyede tutarım. Bu işten bağımsız ama en az yapılacak iş kadar önemlidir demek istiyorum. Gökdelen değil ev yapılacak diye tesisat çizimlerini tesisat ustasına yaptırmam, yine mimara yaptırırım, çünkü mimarlık uzmanlığı burda da mutlaka lazımdır, hatta örneği daha da ileri götüreyim, köpek kulübesi yaptırıyorum diye mimar ihtiyacım olmaz dememeliyim, normal olanı işi boyutundan ziyade uzmanın görüşünün alınması ve o işe ne kadar dahil olacağına uzmanın karar vermesidir, uzman gerek yok derse gerek yoktur ama işi isteyen ya da yöneten kişi olarak işin gereksinimlerini ben değil uzman vermelidir. Bu anlamda kulübe yapılacaksa, mimar belki çok zorlanmaz ama yine de köpeğin cinsi ile kulübenin kapısı arasındaki boyut konusundan yola çıkarak kulübenin kullanımı konusunda mimari bir karar verebilir. Diğer türlü mimarın sorumluluğunu alacak "uzman" kalmaz, sorumluluk ya da fonksiyon uzman olmayan biri tarafından karşılanırsa hep değil ama bazen sorun çıkabilir, mimar olduğunda da sorun çıkabilir ama en azından sorulusu ve muhatabı belli bir sorun olur.

Bu örneğimi şöyle düşün, mimar rolü sadece bir aktör, ama mimarın eğitimi, dosyaları, çalışma defterleri, eğitimi, eski tecrübeleri hepsi mimarın etrafında. Mimar çağırmakla aslında onları çağırmış oluyoruz. SOUL'da bir agent yaratmak sadece agent yaratmak değil. agent mimardan farklı olarak kalıcı hafızası yok, o yüzden mimarın universite, yüksek lisans, doktora, meslek tecrübesi hayatı boyunca edindiği bilgiyi agent her seferinde yeninden öğrenecek, her tur ona geldiğinde ya da oturum ona açıldığında ya da başka bir ajan ondan iş istediğinde. Benim büyüklükten kastım buydu.

ama bunun dışında, ürünle ilgili bir karar versiyon / faz olarak dar kapsamlı olarak karar verilebilir, daha basit iş yapılabilir, bir tuşa basınca tuşun görevini yerine getirmesi yeterli bulunabilir ya da tuşa basınca göze hoş gelen bir animasyon oynatılarak tuşun yaptığı iş kullanıcıda UX/UI deneyimi yaşatmayı amaçlayabilir bunlar tabi ki küçülüp büyüyebilir ama çalışma kültürü, disiplini, işe ve işle ilgili materyallere olan bakış değişmez, sadece çivi çakılacak diye düşünüp usta sadece bir çekiç alıp gitmez, alet çantası hazırdır.


Bunu biraz düşün. yön ver konuşmamıza.

## U012

Evet. Bence bu konuşmadaki varılan noktalar, çıkarılan ilkeler artık bir paragrafa sığacak seviyeyi geçti, bu konuşmanın tamamı bize soul için birşeyler söylüyor. Bunları konsolide etmemiz lazım ama konsolide etmekle özetlemek ya da daraltmak, kırpmak aynı şey değil. Bunu bir diyalog formatından okunabilir bir bütünlüğe döndüştürmek.

## U013

Dokümanı okuyorum, şu an 6. sayfayı bitiriyorum. Bir şey oluştu kafamda, o da şu; bu dokümanda bahsedilen şeyler bir sistem gibi geldi bana, yani LLM ile kelimelerle konuşuyoruz ve LLM'de sözlerle ya da bazı aksiyonlarla (github'a bağlanmak, pdf oluşturmak vb. aksiyonlar da alabiliyor) çıktı veriyor. Aslında bu yapı kodlama ile aynı mekaniğe sahip, yani girdi ve çıktıdan oluşuyor. Kodlardan oluşmuş bir dosyada kodun bir çalışma şekli var, bilmediğim için uyduracağım; mesela yukardan aşağı çalışıyor, çalışırken kodun ortalarında başka bir dosyadaki başka bir kodu çalıştırıp, onun çıktısını kullanmak var mesela. Sen bu örneği çok daha kapsamlı düşünebilirsin. Bu örneği SOUL'a uyguladığında (yani aslında LLM'e uyguladığında) her şeyi kod dosyası ya da kod parçası gibi düşünebiliriz. Yani biraz daha mekanikleştirmekten bahsediyorum, bu mekanikleştirmeyi SOUL bir uygulamadır demek için söylemiyorum, bunu bir uygulamanın mimarisi gibi düşünsek diyorum, yani agent'a talep geldiğinde bu bir input, çalışan yapı agent'ın sistem yönergeleri + history (varsa) + kullanıcı yönergeler (project insturactions mesela) + talepteki tokenlar + agent.md dosyası ve agent.md dosyası agent'i nereye yölendirirse, o dosya, ordan başka dosya, ordan bir dosya daha vb. bir yapı, bu bir programın yaptığı bir şey değil mi? Biz bir programın nasıl çalıştığını bir şema olarak gösterebiliyorsak, SOUL'un çalışma şeklini de bir mekanizma gibi gösterebiliriz, uygulamada tabiki bağlantıyı gösteren çizginin olasılıksal olarak olmama ihtimali yok, çünkü kodda yazanlar zaten bağlantıyı net bir şekilde veriyor, bir anlamda deterministik ama SOUL'unda olmasını hayal ettiğimiz yapıyı deterministik gibi varsayarak hayal edebiliriz. Yani (ilk 6 sayfayı okuduğum için örneklerim buralardan olacak ama sen tüm yapı için düşün bunu) 2.2 Araştırma bulgusu ile işletim kuralı arasındaki geçiş başlığında bahsettiğin şey şu aslında "kullanıcı talebi = bir düşünce balonu icon'u" bu icon, işin "Yeni talebi kaydet; fakat üstlenme
kararı verilmediyse yürütülüyormuş gibi gösterme. Somut bir durumda da “talep geldi,
henüz üstlenme kararı yok” bilgisi bulunabilir. Modelin sonraki çıktısı, bu üç ayrı içeriğin
birlikte kullanılmasından doğar: araştırma ayrımı, benimsenmiş çalışma kuralı ve anlık
durum" = "loading iconu" ile bağlantılı, bu aşamada talep değerlendirili, sonra üç farklı yol, talep geldi kaydet, talep geldi kaydetin ama üstlenme kararı yok, üstlendin ama plana dahil etmedin falan gibi sonuçları olabilir, o da sonra farklı bir akış gibi olabilir.

Bu gözle bakmayı dener misin? Yeteri kadar hayal etmeni sağlayabildim mi emin değilim? Hemen yapmak zorunda değilsin bunu, konseptten emin olmadıysan konuşalım biraz daha ben de tam ve mantıklı bir şey istememiş olabilirim. Okurken akılıma gelen bir histi bu.

## U014

Anladım. Seninle benziyor yaklaşımımız konuya. Değerlendirmelerin de yerine benim basitçe anlattıklarımın için açmışsın. böyle bir yapıyı bir görsel dosyası olarak hazırlaman mümkün olmayabilir belki benim aklımda detaylı bir şey hazırlamak gerekir o kadar öğe de görsele sığmaz gibi düşündüm ama sen yine de görsel olasılığını eleme. Yine de bir pdf ya da benim aklıma gelmeyen ama bu yapıyı objeleştiren bir hale getirmeye çalışsak belki yine bazı gerçekler su yüzüne çıkar. Böyle bir doküman/görsel/akış adına ne dersen de hazırlayabilir misin? Sence ne olmalı bu dosyanın türü?

## U015

mantıklı, iyi buldun. yapacak mısın artık?

## U016

Bu çok iyi oldu, ben şimdi şu ana kadar konuştuğumuz şeylerin aslında bir program olsaydı nasıl akacağını görmüş olduğumuzu düşünüyorum. Hiç de küçük bir yapıdan bahsetmiyoruz bence ki daha taslak ve detaylandırılmamış bir taslak.

Ben burda bir konuyu görünce fark ettim, onu sormak istiyorum. Bunu tam doğru kelimelerle ifade edemeyebilirim o yüzden örnek üstünden anlatacağım.

Mesela roman yazılacak örneğini düşünelim, ben kendimce bir genel bir plan çıkaracağım şimdi;

1. Romanın konusunun belirlenmesi
2. Romanın kısa hikaye olarak örüntüsünün çıkarılması
3. Romanın bölümlerinin belirlenmesi (her bölümün bir paragraflık içerik özeti/bölümde geçecek konunun temel fikri)
4. Romandaki ana kahramanların belirlenmesi
5. Kahramanların karakterlerinin belirlenmesi (romanın anlatımına yön verecektir mutlaka)
6. Romanın yazımı



Mesela yukarıdaki ilk anda benim aklıma gelenler. Sonra bu plan ve sıra o an için mantıklı geliyorsa, Romanın konusunun belirlenmesi üzerine iş başladığında temel bir alt liste yapardım;
1.1. romanın tek cümlelik mesajının yazılması
1.2. romanın ana fikrinin belirlenmesi
1.3. romanın geçtiği dönemin belirlenmesi
1.4. romanın dokunacağı hislerin belirlenmesi
1.5. romanın konusunun yazılması

Bu iş yapılırken tabi ki bizim C-W arasındaki bağlantılar, diğer konuştuklarımız baki onlara itiraz etmiyorum. Belki ana listeye 7. maddeyi eklemek aklıma gelirdi, beki 3 ile 4. maddenin yerini değiştirirdim. Belki bu maddeyi yaparken aklıma başka bir şey gelirdi, ana listedeki 6. maddenin altına alt madde yazıverirdim sonra unutmayayım diye.

Böyle bir listeyi işi yaparken gözümün önünde tutardım, hangi işi hangi kapsamda yapacağım diye.

Muhtemelen bu ya da bu anlattığımın asıl amacına hizmet eden bir şey vardır bu atlas'ta ama ben okuyunca anlayamadım.

öncelikle benin verdiğim örnekten ne anladığını söyle lütfen sonra da atlasta var mı yok mu? ne kadarı var gibi anlat bana.

## U017

Bu sence de üstüne düşünülmesi ve dahil edilmesi gereken bir şey değil mi?
Agent'ların çalışma yapısı düşünüldüğünde, tümden detaya inen bir planın görünür olması, gerektiğinde değiştirilebilir olması, işin uzmanının tarafından yapılması açısından da önemli bence. Burada belki bir iş takip ya da proje takip uygulaması ya da metodolojisi araştırmak yararlı olabilir. Bizim foundation'da work'u nasıl araştırdık, bu açıdan araştırma yaptık mı?

Bir işi yapmak için başı ve sonu belliyken yani bir nevi C ortada görünürken C'ye giden yolun da anlamlı dilimlere ayrıştırılmış olması, görünür takip edilebilir ve sonraki agent işinin belirlenmesinde ya da o işin amacının, kapsamının bilinmesinde fayda sağlar diye düşünüyorum.

Bir de şunu hissettim bunu yazarken; kullanıcının bir talebi A vardı, bahsettiğimiz modelde biz onu C yapıyoruz, sonra o C yaşıyor buraya kadar tamam ama sonra C'nin ortaya çıkması için gerekli plan ortaya çıkmıyor, aslında C'nin ne olduğunu bulmak için sorguladığımız şeyler aynı zamanda planın da adımları ya da içeriği olabilir ya da bunun sinyalini verebilir. Yani kullanıcı roman yazılacak dediğinde biz eğer ki roman yazmak talebinden, talebin netleşmesinde kariyer yolunda yazarlığı seçen birinin romanı yazılacak gibi bir C'ye ulaşıyorsak, burada sadece iyi bir C tanımı ya da uzmanlardan çalışan bir agent takımı kurmak bu bahsettiğin atlastaki yapıyı kurmak tabi ki gerekir ama işin tanımı ile çalışmanın katmanlı (layer demek istiyorum) ya da kademeli bir planı da olsa, sanki iş listeleri, yapılacak işler, adımlar, daha net olur gibi geliyor bana.

Asana, jira, trello ya da sap pr modülü gibi bu tarz uygulamaların belli bir metodolojisi vardır bunlarla ilgili. Ama daha da iyi kaynağın bizim repodaki foundation'da work tarafında verilmiş olacağını düşünüyorum.

nedir yorumun bu konuda?

## U018

Harika. Son vardığın nokta bence bizi yine araştırmaya devam etmeye teşvik ediyor. Konuşmamız bir antrenman oldu bizim için, foundation bittiğinde development os ve soul için bu konuşmanın çok daha detayını ve çok oturumlusunu yapacağız. bu bir denemeydi, kendimizi sınamış olduk, senin repoya bakışını, yaptığımız araştırmayı kullanış şeklini, soul'a bakışını, benim düşünme felsefemi, soul'un hacimini biraz görmüş olduk.

O zaman bir hazırlık  daha yapmanı istiyorum. Şu aşamaya kadar getirdiğimiz süreci, kurduğumuz taslak modeli, agent, research seviyesinde üçüncü bir klasörde bu tarz denemelerimizin olacağı, öğretileri pekiştirdiğimiz, beyin jinlastiği yaptığımız bir çalışmalar bütünü olarak saklayalım. bu da bunun ilk örneği olsun.

Repoya işle bu oturumu, ileride "hani konuşmuştuk ya" diyebileceğimiz zaman geldiğinde detaylarına en dibine kadar ulaşabilelim. Bir turda bitiremeyebileceğin olasılığını da düşün.

repoda araştırma dışında bir de böyle bağımsız denemelerimiz olabilir, bu ilk denemeydi.

Bunu önce planla, repoya nasıl yansıtacağını, daha sonra nasıl kullanacağını düşün. Bu da research gibi daha sonra başvuracağımız hem de kendi düşüncelerimizi içeren bir kaynak haline dönüşebilir. ve bunlardan sık sık yaptıkça, her yaptığımız bir sonrakine daha çok ışık tutacaktır.

## U019

Anlaştık, hadi başlayalım. Operasyonel sınırına kadar çalış.
