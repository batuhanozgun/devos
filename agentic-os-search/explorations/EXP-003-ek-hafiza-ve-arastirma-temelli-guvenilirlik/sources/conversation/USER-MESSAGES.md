# EXP-003 — Kullanıcı mesajları

**Kaynak:** 18 Eylül 2026 tarihli bu konuşmada modele görünür kullanıcı metinlerinin aktarımı. Ham platform export'u değildir. U001–U011 kimlikleri arşiv adreslemesi içindir; yazım ve yerel terimler korunmuştur. U011 arşivleme yönünde biter. Sistem/developer yönergeleri, araç günlükleri ve ilgisiz profil içeriği dahil değildir. Aktarım sınırları: ../../checks/TRANSCRIPTION-NOTE.md yerine paket kökündeki checks/TRANSCRIPTION-NOTE.md.

## U001

henüz explorations'a aday olduğunu iddia etmiyorum ama bir konuda konuşmak istiyorum. 

Önce terimleri bu konuşma için belirleyelim ki konuşmamız karışmasın;

- LLM'in eğitimle gelen sabit bilgisini hafıza olarak adlandırmıyorum, ona sabit bilgi ya da eğitim bilgisi diyeceğim. 
- LLM'in konuşurken bağlamında olan bilgiye bağlam diyeceğim. 
- LLM'in konuşurken daha sonra oturumlarda okuyup bağlamı zengileştireceği dosyalara "ek hafıza" diyeceğim. Memory diye de geçiyor. Aslında foundation tarafındaki INFORMATION tarafına girebilecek bir olgudan bahsediyorum. "Ek Hafıza" diyorum çünkü claude code ya da codex de çalışırken "auto memory" gibi bir özellikten dolayı hafıza diyeceğimiz bir yapı da orda oluşuyor. 
- Terimler karışmasın diye ayırıyorum, burada irdelemek istediğim kısım ek hafıza kısmı. karpathy'nin wiki-llm konusu olabilir, hermesin mermory özelliği olabilir ya da diğer başka örnekler de olabilir. 
- Yani ek hafıza aslında kullanıcı ve agent'ın birlikte oluşturduğu, agent'ın eğitim bilgisi dışında kullanacağı üstüne çalışılan yapıyla ilgili ya da agent'ın çalışma disiplini, kurallarıyla ilgili bilgiler. aslında sonradan oluşturmuş tüm dosyalar bu kategoriye girebilir. 

Bu kısımda net misin? Neyden bahsettiğimi anladıysan, bu ek hafıza yapısıyla ilgili standart bir yapı olmadığını düşünüyorum, yani bilimsel ya da akademik bir kabul yok bu konuda diye düşünüyorum. herkes o ek hafızayı nasıl yönetecek, nasıl kullanacak, agent'ın ne zaman ve nasıl oluşturacağı, ne zaman okuyacağı, ne zaman düzenleyeceği falan hepsi ortaya bir yöntem çıkarmak ya da mevcut yöntemleri kullanarak oluşturuluyor. Şimdi bu konuyu küçük turlarla, irelemek istiyorum seninle. 

Beni anladığını göster bana önce, ne anladın, ne yöne gideceğimizi düşünüyorsun ve bu konuşmada nasıl ilerleyeceğiz? Önce bu konuda birbirimize yaklaşmak için konuşalım.

## U002

anladım. O zaman şunu ekleyeyim konuşmaya. Ben konuya hakim olarak konuşmuyorum, zaten amaç benim ne bildiğim ile neyi doğru bildiğim ve neyi ne kadar bildiğimi anlamak için yapacağımız bir konuşma bu. Ben burada bir şeyler ortaya atacağım, hem benim bu ortaya attığım şey konuyla ilgili neyi bildiğimi sanıp yazdığımı ortaya çıkaracak -bunu konuşurken fark edeceğiz, şu anda ben de bilmiyorum zaten ne bilip bilmediğimi- hem de konuyu bu yolla biraz da somutlaştırmış olacağız. 

Konuşurken de sen de araştırıp değerlendirirsin bir yandan. 

İlk tur için sorunu alıyorum, yerinde bir soru, bilginin yaşam döngüsü olarak ele alalım bence. ben de direkt oradan girecektim konuya ama öncesinde bir ayrımı ortaya atmak istiyorum;

Ben "eğitim bilgisi" ile "ek hafıza" arasındaki farklı şöyle konumlandırıyorum. 

Şimdi eğitim bilgisi de bir nevi hafıza, günün sonunda sen elindeki bilgiye ulaşıyorsun, bir girdiye cevap vermek için içerideki bilgi kümesinden "arama" yapıp (arama kelimesine takılma, cevap vermek için içerideki mekanizmaya verdiğim isim gibi düşün) sonra bana çıktıyı veriyorsun. 

Ek hafıza da aslında aynı mekanizma için var, sonuçta senin eğitiminde benin adımın Batu olduğu yazmıyor, o bilgiyi ancak bir ek hafıza dosyası ile elde edebilirsin. 

Buradan da şuna atlıyorum; senin eğitim bilgine ulaşman eğitim bilginin yani o sabit hafızanın (hafıza diye nitelendireyim sadece bu cümlemi kurabilmek için) oluşturulması, kurgulanması, muazzam bir çalışmanın sonucu, OpenAI'ın bir firma olarak ve OpenAI'ın çalışanlarının mesaileri ile ve de milyarlarca para harcanarak oluşturulmuş bir sistem. Ek hafıza dediğimiz şey ise senin bu eğitim bilginin içine koyabileceğim bir bilgi değil, eğer onu yapmak isteseydim LLM modelini eğitmem gerekirdi, yani kabaca OpenAI'da işe girip, modeli eğitmem gerekirdi. O yüzden bence modelin hafıza yapısı için "top" yapıyı eğitim yapısı olarak konumlandırırsak, ek hafızanın eğitim yapısından içeri alınması mümkün değil. o yüzden eğitim sonra süreçte yani LLM'in ilk kullanıma açıldığı andan itibaren, kurulabilecek bir yapı olarak düşünmek lazım. Sorunu hatırlatmak gerekirse, ben de ek hafızanın özünü depolanan bilgi olarak görmüyorum bu konuşmada, daha çok o bilginin yaşan döngüsünü yönetem mekanizma olarak görüyorum. 

Özellikle de o mekanizmaya neden ihtiyaç duyulduğunu da iyi tanımlamak gerektiğini düşünüyorum. 

Bu arada AI dünyasındaki öncü insanlar bu konuda ne aşamaya geldi ben bilmiyorum, zaten repoda bununla ilgili araştırmalarımız devam ediyor. Ben kendimce benim düşüncemi seninle karşılıklı olarak sorgulamak ve sorgulamalarımızın karşılığı var mı bunu anlamak istiyorum. 

Öncelikle bana göre en temelde, en tepede ek hafıza dediğimiz şeyle ilgili üç bacak var bence, "yaratmak", "okumak" ve "düzenlemek". Ek hafızayla ilgili tüm mekanizma bundan ibaret. Bu kadar az demek istemiyorum. hafızayla başka bir şey yapılmaz, yapılan her şey, bu üçünden en az biridir demek istiyorum. 

Evet, şimdi top sende, bakalım sen nasıl bakıyorsun konuya? yaklaştık mı birbirimize konuya bakış açısı olarak?

## U003

öncelike yaratma, okuma ve düzenleme konusundaki bakışı tartışalım. sen haklısın ama ileri gittiğin için konuları oraya getirdin. düzenleme farklı sebeplerden olabilir, ondan bahsetmiyorum, silmek de düzenlemedir doğru, bölmek de, yeninden sınıflandırmakta da ve diğer bütün saydığın aksiyonlar. Bahsettiğim şey, bir dosya ile başka bir şey yapamazsın demek istiyorum, yani dosyayı kopyalamak yaratma altına olabilir, (yani tartışılabilir tabi ki) bu üç başlık bir şey yapılacaksa o yapılacak şeyin kümesinin adı olabilir demek istiyorum. 

Manage dediğin şey tabi ki düzeltme demek değil, zaten yönetmek bu üç şeyi birlikte ve bir amaç uğruna kullanmak diye düşünürsek, o amaçlarların her birinin tanımını ortaya çıkarıp her amaca göre hangisinin (yarat, düzenle, oku) nasıl kullanılacağını  kurguladığın yapı da mekanizma oluyor zaten. (benim fikrim akademik, bilimsel kural değil, tartıştığımız için rahatlıkla söylüyorum bunları) 

Policy dedin mesela, policy dediğin de aslında bir dosya ve o da yaratılmış ve başka dosya yaratırken, okunurken ya da düzenlenirken, okunan bir dosya. policy  okumak, yazmak, düzenlemek gibi bir şey değil. mekanizmanın parçası olabilir ama okumak, yazmak, düzenlemek gibi bir şey değil bence. 

Henüz aynı kafaya gelmedik, ek hafızaya neden ihtiyaç vardır sorusu erken. 

Şimdi değerlendir, odağı tutturamıyorsan da söyle, netleştirelim birlikte. ben doğruyum demiyorum zaten.

## U004

Evet şimdi aynı kafaya ulaştık çünkü yaratma ile düzenleme farklı mı diye soruyorsun haklısın bu soruyu sormakta. 

o zaman burada işin içine bence hafızadaki "bilgi" diyeceğimiz şey giriyor işin içine. 

Bunu şöyle yorumlayabilirim; dosya yaratmak ile dosya değiştirmek kavramlarını, boş dosyanın içine bilgi yaratmak ve dosyanın içindeki bilgiyi değiştirmek kavramları ile karşılaştır. 

Hafıza neyden oluşur? Dosya mı dosyanın içindeki bilgiden mi? ikisini birbirinden ayrılmaz diyeceksin bence buna, dediğini varsayarak devam edeyim; bu durumda yaratmak dosya yaratmak mıdır? yoksa dosya + içindeki bilgiyi ilk defa yazmak mıdır? şimdi burada o dosyanın "ek hafıza mekanizması" içindeki kullanımı da düşünülmelidir. mekanizma için dosyanın varlığı da bir bilgidir, bu bilgi yine mekanizma içinde bir index.md için bilgi olarak yer alabilir. Bir yazma (yaratma) aşamasını bence burada ikiye ayırmak lazım. dosyayı yaratmak ve dosyanın içine ilk defa bilgi koymak ayrı ayrı yaratmalardır. Şöyle düşün, mevcut bir dosya var, o dosyanın içinde de ilk defa yaratılmış bilgi var. sonra dosyayı düzenlemek için açtın ve mevcut bilgide değişiklik yapmadan sadece altına bir cümle daha ekledin. Dosyayı düzenledin demekle içine yeni bilgi yazdın demek arasındaki fark ne? fark var mı? devam ediyorum, aynı dosyayı açtın, en alta eklediğin cümledeki kelimeyi eş anlamlısıyla değiştirdin, bu durumda dosyayı düzelttin, bilgiyi de düzelttin ama aynı zaman da bir kelimeyi de sildin. 

Örnek vereyim, dosyada şu yazıyordu. 

T=0 anında,
Create: bilgi.md
Dosyanın içindeki bilgi: Top yuvarlaktır, saha yeşildir.

T=1 anında,
Open: bilgi.md
Read: bilgi.md
Dosyanın içindeki bilgi: Top yuvarlaktır, saha yeşildir.
Sil: Top yuvarlaktır, saha yeşildir.
Ek bilgi: Sporcu forması kırmızıdır.
Yaz: Top yuvarlaktır, saha yeşildir. Sporcu forması kırmızıdır.
Save: bilgi.md

T=2 anında
Open: bilgi.md
Read: bilgi.md
Dosyanın içindeki bilgi: Top yuvarlaktır, saha yeşildir. Sporcu forması kırmızıdır.
Sil: Top yuvarlaktır, saha yeşildir. Sporcu forması kırmızıdır.
Yaz: Top yuvarlaktır, saha yeşildir. Sporcu forması mavidir.
Save: bilgi.md

Şimdi ben kendimce uydurdum yaşanacak mekanizmayı, dosya nasıl yazılır, mekanizma nasıl çalışır, içindeki bilgi nasıl değiştirilir bilmiyorum, sen gerçekte olan ile değiştir bu örneği, doğrusunu yaz. nasıl alternatiflerle anlatılır bu örnek sen daha iyi biliyorsun.

## U005

Aslında ulaşacağımız nokta şu, bu LLM'deki ek hafızayı yönetmek için çeşitli yöntemler mevcut, şu an internetten araştırsan bir çok örnek, bir çok yöntem karşına çıkar. Ben bu hafıza yönetimini konuşmak için en temel yapı taşlarına kadar ayırıp konuşmayı temelden yapılandırmak için bu konuya girdim. şu an bu ayrımın farkında olmamız bile yöntemleri değerledirmeye başlamak için bir zemin. 

Bahsettiğim şu, her seferinde sadece eğitim bilgisi ile başlayan bir ajan için bu ek hafızayı yönetmek için yöntem üretmeye çalıştığımızı düşün, yöntem üreteceğiz demiyorum, bu yöntemle neyi aslında yönetmeye çalışacağız, internetteki örnekler "aslında" neyi yönetmek için oluşturulmuş. Mesela şu ana kadar konuştuğumuz şeylere bak, dosyayı mı yönetiyor dosyanın içindeki bilgiyi mi yönetiyor diye sorabilmek için yukarıdaki konuşmayı yapmamız gerekiyormuş. 

Ben en temelde ek hafıza yönetiminin en büyük probleminin şu olduğunu düşünüyorum, LLM yapısı neredeyse insansı bir düşünme metodolojisine sahip (insani tarafa daha yakın) ama kullandığı materyaller mekanik dünyanın materyalleri. Hafıza diyoruz ama aslında dosya ve içindeki içerikten oluşuyor, yaratmak diyoruz insanı yönden yaratmak yoktan var etmek ya da bir kaç şeyi birleştirip bir ortaya çıkarmak gibi ama bilgisayar dilinde CREATE bilgi.md.mpt RENAME bilgi.md.tmp to bilgi.md gibi çok deterministik şekilde yapılıyor. İnsan bilgiyi ürettiğinde, onu otomatik olarak hatırlar, LLM için aynı şey geçerli değil, hatırlaması için aslında yeniden okumasını sağlayacak başka bir dosyayı okuması gerekir, o ilk dosyayı da okumak için başka dosya ya da yeni bir prompt ya da bir hook ya da bir başka agent vs. yani aslında dosya her seferinde agent için yeninden ortaya çıkar, bu create demek değil ama "agent'ın ek hafızası" diyeceğimiz şey ne ise o hafıza kümesi için bir anda exist olacak bir nevi hafıza tarafında create edilmiş ya da insert edilmiş olacak. 

Ben ek hafıza mekanizmasına bu yönden yaklaşmaya çalışıyorum. çünkü hafıza kullanılmak içindir bence, saklanmak için değil. o yüzden bu konuyu irdeliyorum, çünkü development os, soul ya da soul'un ortaya çıkaracağı çalışma düzeni hep bu ek hafızayı kullanmak zorunda kalacak, hem yazacak, hem düzenleyecek hem de okuyacak. hafıza olmadan reasoning soyut kalır. O yüzden hafıza öyle bir yapıda olmalı, hiç bozulmamalı, hiç yıpranmamalı. Bu demek değil ki herşey her an bağlamda olsun, ama öyle bir yapı olmalı ki en ufak değişiklik bütün kümedeki etkisi düşünülerek yapılmalı, illa her dosya değişir demiyorum ama bir bilgi geldiğinde doğru şekilde içeri girmeli ve ihtiyaç anında o bilginin varlığı ve kullanılabilirliği sorgulanarak gerektiğinde bilginin kendisine gidilebilmeli. 

Benim burada aklıma katmanlı bir hafıza geliyor ama tabi sadece katman da değil, aynı zamanda kategori yapısı da geliyor. yani mesela, sen bir LLM'sin sürdürülebilir yaptığın iş kullanıcılarla konuşmak. Farz etki SOUL seni oluşturmuş. Sen öyle ortaya çıkmışsın. Seni yaratma amacı da LLM ihtiyacını karşılamak olsun, yani kullanıcılar seninle konuşacak sen de eğitim bilgileri üzerinden cevap vereceksin. aslında gerçek hayattaki rolünün benzeri. Şimdi bu aşamada SOUL'un senin için seni yaratırken bir ek hafıza yapısı kurduğunu düşün, uyduruyorum, kullanıcılar diye bir md dosyan var, içinde batu, alin, kemal var. sonra batu diye bir dosyan var, o da batu'yla ilgili bilgileri tutuyor, ama madde madde detay yok. işi, eğitimi, cinsiyeti, yaşı, üslubu, karakteri falan gibi tek kelimelik ya da cümlelik notlar. sonun altında batu_eğitim, batu_iş, batu_karakter diye dosyalar olduğunu düşün. bir konuda çalışırken, farz et ki batu sana bir iş verdi, batuya cevap vereceksin, ama önce kullanıcılara gittin, batu diye kullanıcın olduğunu buldun, sonra batu klasörüne gittin genel bilgiyi edindin, sonra cevap vermeden önce bir de karakteri okuyayım da cevabımı ona göre kısa, uzun, sert, basit, teknik gibi alternatif şekilde verebilirim diye düşündün. diğer dosyaları okumaya ihtiyaç duymadın yani eğitim ya da iş ile ilgili detay dosyaları okumadın, ama batu dosyasını okuduğun için onlarında var olduğunu artık biliyorsun. insan da böyle bir bakıma, sabah uyanınca, neleri biliyorum diye sırayla alfabeyi sayıp sayıları sayıp sonra okuduğu kitapları sayıp ne biliyorsa sayıp sonra güne başlamıyor ama kitap okduğunu biliyor, ihtiyaç olursa oturup düşünür eksik fazla hatırlar. eğer bir liste tutarsa gidip bakar asıl önemli olan o listenin ya da hafızanın farkında olması. 

Buradaki örnekte saçma bir konuda örnek vermiş olabilirim ama bilginin ulaşılabilir olabilmesinden bahsediyorum. Bunun için de dosya yaratmak, düzenlemek, okumak kadar basit üç seçenekle yapılabilecek büyük bir mimari olabileceğininden asıl kritik olanın bu üç seçenekle neler yapılabileceğini düşünenin derinliği olduğunu ifade etmeye çalışıyorum. 

Mesela karpathy llm-wiki'yi ortaya attı, başka örnekler de vardır, hermes ya da internette bir sürü memory yönetimi diye yapılar var, bence burada iki olasılık var, ya benim kadar dipten işin felsefesinden almadılar konuyu o yüzden hala bu memory konusu akademik kabul olarak net bir şekilde mimari olarak kurulamadı ya da ben herkesin geçtiği yoldan geçiyorum ve bu örneklere ulaşacağım. ya da gerçekten farklı bir noktadan yakaladım ve SOUL içinde çok stable bir yapı kurmanın zeminini oluşturacak bu konuşma.

## U006

O zaman bu aşamada foundation atındaki INFORMATION bacağını okumanı öneririm. bu konuşmamıza ne kadar faydası olacak hem anlamış da oluruz. Biraz zorla kendini, yani girip çık dosyaların içine, "bir dosya buldum okudum geldim bu da cevabım" deme bana. bir dosya oku, sonra başka bir tane oku, belki INFORMATION konusundan ENVIROMENT'te atlayacaksın belki AKTOR'e ya da WORK tarafına bakacaksın onu bilemem. ama göz ucuyla bakma dosyalara, baktığın dosyayı önce hızlıca tara, sonra gerekirse tam okuma yap. 

hadi bak bakalım foundation'a, araştırmamız bize ne fayda sağlıyor göreceğiz burda.

## U007

anladım. Foundation bizim bu konuşmada yapacağımız bir şey farkındalık konuşmasını çoktan yapmamızı sağlamış anladığım kadarıyla. 

Peki önerim şu; şu anda foundationdaki bu bilgilerle wiki-llm tarafındaki karpathy yaklaşımını sınayalım mı? 

Yani bizm bu foundation açısından karpathy ne yapmış neyi yapmamış diye bakalım mı? Sence bu aşamada mıyız?

## U008

hadi bak

## U009

bu konuşma sonrasında karpathy'nin wiki-llm'ini baz olarak alıp eksiklerini kapatmak istesek sence karpathy'nin sistemine ne seviyede bir ekleme yapmış oluruz. yani şöyle düşün karpathy %100 olsa, bizin foundation'ın getirdiği bilgi ve farkındalık seviyesi ile % kaç olur? yani mesela 3'e mi katlanır, yoksa %120 gibi bir gelişim mi olur?

## U010

peki studies klasörüne geç şimdi, orda dolaş biraz, neler var diye bak. bunun kapsamlı bir istek olduğunun farkındayım ama foundation + karpathy + studies'teki her bir klasör birleştirilse nereye varırız acaba? yani studies bize marjinal fayda olarak ne getirebilir biraz bunu anlamaya çalışıyorum. her bir studies araştırması bize marjinal olarak yüksek fayda getiriyorsa memory konusunda biraz daha araştırma yapıp, artık marjinal faydanın çok azaldığını görünce araştırmayı azaltmayı düşünüyorum.

## U011

anladım. 
yani şuna varacağımızı düşünüyorum ben; "bu araştırmalar sonucunda, karpathy'den, hermes'ten ya da diğer memory yönetimi içeren yapılardan daha sağlam bir yapı kurduk, bunların eksiklerini diğer örneklerden elde ettiğimiz yapıları yeninden düşünerek ve uygulayarak ve foundation'ın bize kazandırdığı bakış açılarını kullanarak, çok daha sağlam, sürdürülebilir bir yapı kurduk, bu yapı agent'ların kullanımı için şu ana kadar bu kadar araştırma ve örnek toplamadan sonra yapabileceğimiz en iyi yapı ve araştırmalardaki örneklerin açıklarını içermiyor" 

buna ulaşabilmek en temel amacım ama bunun için daha çok iş var, bu konuşma explorations altında olabilir ya da olmayabilir dememin sebebi buydu. (konuşmanın ilk mesajını oku) 

Şimdi istersen bu konuşmayı baştan oku ve EXP-003 olarak kayıt altına alalım diye düşün lütfen.
