# 1–6'dan 1.1–1.5'e: Yaşayan, Katmanlı ve Kademeli Work Planı

SOUL üzerine düşünürken bir noktada şu eksikliği fark etmiştim:

Kullanıcı talebini daha iyi anlayıp gerçek amacı ortaya çıkarmak yetmiyor. Actor'ları oluşturmak yetmiyor. Information sistemini kurmak da yetmiyor.

Bütün bunlardan sonra hâlâ şu soru açık kalıyor: Bu büyük işi fiilen hangi anlamlı adımlarla yürüteceğiz?

Bu problemi anlatmak için yine roman örneğini kullandım ama bu sefer romanın kendisi değil, planın yapısı önemliydi.

Bir roman yazılacağını düşünelim. İlk bakışta şöyle bir üst seviye plan oluşturabilirim:

1. Romanın konusunun belirlenmesi
2. Romanın kısa hikâye örüntüsünün çıkarılması
3. Bölümlerin belirlenmesi
4. Ana karakterlerin belirlenmesi
5. Karakterlerin özelliklerinin geliştirilmesi
6. Romanın yazılması

Bu liste mükemmel olmak zorunda değildir. Hatta büyük ihtimalle eksiktir. Ama işin bütününü ilk anda görünür hale getiren bir çalışma haritası sağlar.

Buradaki ana fikir şudur: Büyük işin bütünü görünür olmalı, fakat bütün iş aynı anda aynı detay seviyesine indirilmemelidir.

Diyelim ilk Work “Romanın konusunu belirlemek.” Bunun üzerinde gerçekten çalışmaya başladığımızda bu maddeyi daha ayrıntılı hale getirebiliriz:

1.1 Romanın tek cümlelik mesajını belirle
1.2 Ana fikri belirle
1.3 Geçtiği dönemi belirle
1.4 Dokunmak istediği temel hisleri belirle
1.5 Bunları birleştirerek romanın konusunu oluştur

Bu sırada ana listedeki diğer maddeler hâlâ vardır. Ama henüz hepsinin altına 20'şer görev açmayız. Çünkü onları ayrıntılandırmak için henüz yeterli bilgi olmayabilir.

Bütün görünür kalır; aktif dal ayrıntılanır.

Büyük bir işi en başta yüzlerce göreve bölmek ilk bakışta disiplinli görünebilir. Ama henüz işi yapmaya başlamadan önce sonraki aşamalar hakkında yeterli bilgimiz olmayabilir.

Böyle yaparsak başlangıçtaki belirsizliğimizi görev listesine betonlaştırmış oluruz.

Plan yapmak belirsizliği yok etmez. Bazen yalnızca belirsizliği task isimlerinin içine gizler.

Bu nedenle planın ayrıntısı da bilgiyle birlikte gelişmelidir.

Ama bunun tersi hata da var. “Önce 1. işi yapalım, sonra ne yapacağımıza bakarız.” yaklaşımı yeterli değil. Çünkü o zaman Actor yalnız lokal görevini görür. Bütün işin yönü kaybolur.

Dolayısıyla iki uçtan da kaçınmak gerekiyor:
- Her şeyi baştan ayrıntılandırma.
- Yalnızca sıradaki mikro işi de görme.

Bunu bir haritaya benzetmek mümkün. Ülke haritasına baktığında bütün şehirler görünür. Bir şehre girdiğinde ilçeler açılır. Bir ilçeye girdiğinde sokaklar görünür. Ama bütün ülkenin bütün sokaklarını aynı anda görmek istemezsin.

Work planının da buna benzer olması gerektiğini düşünüyorum. Üst seviyede bütün işin yapısı görülür. Current Work'e yaklaştıkça detay artar. Uzaktaki işler ise henüz yeterli çözünürlükte değil olarak kalabilir.

Bu yüzden planın detay seviyesi eşit olmak zorunda değildir.

Daha önemli nokta şu: Bu plan yalnızca ayrıntılanmaz. Değişebilir.

Örneğin 1. madde üzerinde çalışırken 3 ile 4'ün sırasının değişmesi, yeni bir 7. madde eklenmesi, 5. maddenin iki ayrı Work olması veya 6'nın altında ileride yapılması gereken bir alt görevin ortaya çıkması mümkündür.

Current Work başka dallar hakkında bilgi üretebilir. Plan bunu absorbe edebilmelidir.

Plan yalnızca sıra listesi değildir. Beynin dışındaki bir çalışma hafızası gibi davranır. Bir fikir geldiğinde “Bunu sonra unutmamalıyım.” dersin ve doğru yere yazarsın. Böylece current düşünceyi bölmeden gelecekteki Work'ü koruyabilirsin.

SOUL Actor'ları için bu daha da önemli olabilir. Actor değişebilir, session bitebilir, context daralabilir. Dolayısıyla “Ben bunu aklımda tutarım.” güvenilir bir continuity mekanizması değildir.

Planın kendisi gelecekteki Work'e ilişkin düşünceleri taşımalıdır.

Bu nedenle Work planı ile memory tamamen ayrı şeyler değildir. “Bölüm 4'e geldiğimizde X problemi kontrol edilmeli.” bilgisi yalnız genel memory'ye yazılırsa gelecekte unutulabilir. Ama ilgili Work dalına bağlanırsa doğru zamanda yeniden görünür olabilir.

Burada plan Work'ün kendisi değildir. Plan üzerinde “1.5 Romanın konusunu yaz” yazması, bu işin yapıldığı anlamına gelmez. Bu yalnızca Work'ün temsilidir.

Plan planned, in progress ve actually completed durumlarını birbirine karıştırmamalıdır.

“Yaşayan plan” demek her Actor istediği gibi task listesini değiştirsin demek de değildir. Plan değişikliklerinde authority ve reasoning gerekebilir. Actor değişiklik adayı üretir, gerekçesini kaydeder, yetkili Actor değerlendirir ve sonra plan güncellenir.

Dolayısıyla living plan mutable olmalıdır ama uncontrolled olmamalıdır.

İlk planın kullanıcı tarafından verilmesini de beklemiyorum. Kullanıcı “Roman yazmak istiyorum.” der. Kullanıcının doğru WBS'yi, dependency'leri veya görev sırasını bilmesi gerekmez. Planı işi bilen Actor'lar oluşturmalıdır.

Ama bütün uzmanların yalnız kendi dalını planlaması da yeterli değildir. Çünkü dalların nasıl birleştiğini gören bir üst bütünlük gerekir.

Bu plan analojisinden önemli başka bir ayrım çıkar. Diyelim 1.1–1.4 bitti: mesaj, ana fikir, dönem ve hisler belirlendi. Bu dört görevin tamamlanması “romanın konusu oluşturuldu” anlamına gelmez. Hâlâ bunları tutarlı bir konu tanımına dönüştürme işi gerekebilir.

Büyük işlerde task decomposition bazen şu hataya yol açar: bütün child task'lar yeşil → parent goal tamam. Bu her zaman doğru değildir. Alt sonuçların üst sonuçta sentezlenmesi gerekebilir.

Decomposition yalnız parçalama değildir. Composition da gerekir.

İyi Work sistemi iki görünümü de korumalı:

Yatay görünüm: büyük Work'ün ana dalları.
Dikey görünüm: current dalın ayrıntıları.

Yalnız yatay görünüm olursa plan fazla yüzeysel kalır. Yalnız dikey görünüm olursa Actor bütünün içinde nerede olduğunu kaybeder.

Bir Actor Work aldığında yalnız mikro görevi değil, parent amacı, sibling Work'leri ve downstream relevance'ı da gerektiği ölçüde görebilmeli.

Bu, futbolcu analojisindeki dar mevki + geniş oyun görüşü fikriyle de bağlantılı.

SOUL büyük işi bir kerede bütün ayrıntısıyla planlamamalı; büyük resmi kaybetmeden, çalıştığı dalı gerektiği kadar açmalı ve Work sırasında öğrendikçe planını yeniden şekillendirebilmelidir.
