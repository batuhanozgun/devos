# Dosya mı Hafıza, Bilgi mi? Ek Hafızayı Depolama Değil Yaşayan Bilgi Sistemi Olarak Düşünmek

SOUL ve Development OS açısından memory konusunu düşünürken doğrudan “hangi memory framework'ünü kullanalım?” veya “vector database mi kullanalım?” gibi çözüm seviyesinden başlamanın yanlış olabileceğini düşündüm.

Önce daha temel bir soruya indim: LLM için “ek hafıza” dediğimiz şey aslında nedir?

Bir dosya mı? Dosyanın içindeki bilgi mi? Dosyaların birbirleriyle ilişkisi mi? Bilginin bulunabilmesini sağlayan index mi? Yoksa bunların tamamını kullanan mekanizma mı?

Bu ayrımı anlamadan memory management çözümü seçersek, aslında neyi yönettiğimizi tam bilmeden yöntem seçmiş olabiliriz.

Bunu anlamak için çok basit bir dosya analojisi kullandım.

Bir sistemde Create bilgi.md işlemini yaptığımızı düşünelim. Artık bir dosya vardır. Ama dosya boşsa hafızada gerçekten yeni bir bilgi oluşmuş mudur?

Sonra dosyaya şunu yazalım:

Top yuvarlaktır.
Saha yeşildir.

Şimdi iki ayrı olay gerçekleşmiş gibi düşünülebilir:
1. fiziksel/teknik taşıyıcı oluşturuldu: bilgi.md
2. o taşıyıcının içinde yeni bilgi oluşturuldu.

Bunların ikisine de gündelik dilde “create” diyebiliriz. Ama aynı tür yaratma değildirler.

Memory sistemi tasarlanırken bu ayrım önemlidir. Çünkü dosyanın varlığı ile içinde doğru bilginin bulunması aynı şey değildir.

Şimdi bilgi.md dosyamızda “Top yuvarlaktır. Saha yeşildir.” olsun. Dosyayı açıp sonuna “Sporcu forması kırmızıdır.” ekleyelim.

Teknik açıdan dosya edit edilmiştir. Ama bilgi açısından bakıldığında mevcut iki bilgi değiştirilmemiştir. Yeni bir bilgi eklenmiştir.

Dolayısıyla “dosya update edildi” ifadesi ile “mevcut bilgi update edildi” ifadesi aynı şeyi anlatmaz.

Bir adım daha ileri götürelim. Dosyada “Sporcu forması kırmızıdır.” ifadesini “Sporcu forması mavidir.” şeklinde değiştiriyoruz.

Yine teknik düzeyde dosya edit edilmiştir. Ama semantik düzeyde başka bir olay olmuştur: eski bir bilgi artık geçerli değildir, onun yerine yeni bir bilgi konmuştur, mevcut hafıza durumu değiştirilmiştir.

Bu, yeni bilgi eklemekten farklıdır.

Dolayısıyla tek bir write veya edit komutunun altında semantik olarak farklı olaylar bulunabilir:
- yeni bilgi oluşturma,
- mevcut bilgiye ek yapma,
- mevcut bilgiyi düzeltme,
- mevcut bilgiyi geçersiz kılma,
- bilgiyi silme,
- bilgiyi yeniden sınıflandırma,
- bilgiyi başka bir bilgiyle ilişkilendirme.

Memory management'i yalnız filesystem operasyonları üzerinden düşünürsek bu ayrımlar görünmez hale gelir.

Bilgisayar dünyası açısından işlem OPEN → READ → WRITE → SAVE veya CREATE temp → WRITE → RENAME olabilir. Ama insan açısından aynı olay “Yeni bir şey öğrendim.” veya “Daha önce bildiğim şeyin yanlış olduğunu öğrendim.” şeklinde yaşanır.

LLM tabanlı sistemlerin memory problemi biraz da buradan kaynaklanıyor gibi geliyor.

Bir bilgi diske yazıldı diye Actor'ın hafızasına girmiş olmaz.

Bir agent bugün “X kararını Y gerekçesiyle aldık.” bilgisini öğrenip bir dosyaya yazabilir. Session bittikten sonra yeni Actor instance'ı geldiğinde o dosyanın varlığından haberdar değilse bilgi çalışma açısından fiilen mevcut değildir.

Dolayısıyla persisted ≠ remembered olabilir.

Bilginin gerçekten kullanılabilmesi için Actor'ın bir şekilde o bilgiye yeniden ulaşması gerekir. Bunun için index, router, retrieval mekanizması, başlangıç dosyası, hook, prompt, search veya başka bir Actor gerekebilir.

Yani memory yalnızca bilgiyi bir yere yazmak değildir. Aynı zamanda gerektiği anda o bilginin varlığını fark etmek ve ona geri ulaşabilmek problemidir.

Benim bu konudaki temel sezgim şu: Memory'nin amacı yalnızca bilgiyi kaybetmemek değildir. Hafızanın esas değeri, doğru bilgiye doğru anda tekrar ulaşabilmektir.

Bilgi mükemmel biçimde saklanmış olabilir. Ama gerektiği anda bulunamıyorsa çalışma sistemi açısından değeri ciddi biçimde azalır.

Dolayısıyla iyi bir memory sistemi en az şu yaşam döngüsünü düşünmek zorundadır:

oluştur → sakla → adresle → bul → oku → kullan → güncelle → geçersiz kıl / koru → yeniden bul

Bir dosyanın okunması da yalnızca teknik bir I/O işlemi değildir. SOUL açısından okuma, bilginin çalışma context'ine yeniden girmesi anlamına gelir.

Bilgi depoda yıllardır var olabilir. Ama Actor'ın current Work'ü sırasında okununca bir anda reasoning'in parçası haline gelir.

Bu açıdan retrieval ve context construction da memory lifecycle'ın parçasıdır.

Memory storage ile bitmez. Şuna daha yakındır: storage + addressability + retrieval + context activation.

Bir başka ilginç ayrım da şu: bilgi.md dosyasının içeriği bilgi taşır. Ama sistem açısından “bilgi.md diye bir dosya vardır ve şu konuda bilgi içerir” ifadesi de ayrı bir bilgidir.

Bu bilgi örneğin INDEX.md içinde bulunabilir. Dolayısıyla memory sistemi katmanlı hale gelir: özgün bilgi, bilginin nerede bulunduğuna ilişkin bilgi, bilginin durumuna ilişkin metadata, hangi durumda okunacağına ilişkin routing bilgisi.

Bu noktada memory yalnızca içerik deposu olmaktan çıkar. Bir bilgiye erişim sistemi haline gelir.

Memory lifecycle tasarlanırken yalnız teknik CRUD kelimelerine güvenmemek gerektiğini düşünüyorum. Örneğin update çok kaba bir kelimedir. Yeni bilgi eklemek, hatalı bilgiyi düzeltmek, eski bilgiyi deprecated yapmak, bilgiye kaynak eklemek, güven seviyesini değiştirmek veya iki kaydı birleştirmek teknik olarak update olabilir; fakat SOUL açısından etkileri farklıdır.

Yanlış bir bilginin değiştirilmesi yalnız o satırı etkilemeyebilir. Eski bilgi kullanılarak karar verilmiş, başka bir Work açılmış, başka bir belge yazılmış veya başka bir Actor yönlendirilmiş olabilir.

Bu durumda gerçek memory update şunu sormalıdır: “Bu bilginin değişmesi başka neleri etkiliyor?”

Append ile correction aynı şey değildir. Knowledge growth ile knowledge revision aynı değildir.

Aynı şekilde delete de basit değildir. Bilgi gerçekten yanlış mıydı? Artık gerekli değil mi? Tarihsel kayıt olarak korunmalı mı? Yalnız current view'dan mı çıkarılmalı? Başka kayıtlar ona referans veriyor mu?

Bir dosyayı silmek kolaydır. Ama bilgiyi sistemin epistemik geçmişinden silmek başka bir şeydir.

Memory'nin sağlam olması “Bütün bilgi her zaman prompt'a yüklensin.” demek değildir. Asıl ihtiyaç, bilginin varlığının bilinebilir olması ve gerektiğinde bilgiye güvenilir biçimde ulaşılabilmesidir.

Memory'nin kalitesi her şeyi anında hatırlamak değil, gerektiğinde doğru şeyi doğru derinlikte recover edebilmek olarak düşünülebilir.

Hafıza olmadan uzun vadeli reasoning soyut kalır. Reasoning → memory ve memory → yeni reasoning arasında sürekli bir döngü vardır.

Bu nedenle Development OS ve SOUL tasarımında şu soruyu açık tutmak istiyorum: Gerçekte yönettiğimiz şey dosyalar mı, bilgi mi, yoksa bilgi yaşam döngüsü mü?

Dosya yalnızca taşıyıcı olabilir. Database satırı yalnızca taşıyıcı olabilir. Vector embedding yalnızca retrieval mekanizmasının parçası olabilir.

Bunların hiçbirini tek başına memory ile eşitlememek gerekir.

Dosya memory değildir. Dosyanın içindeki bilgi bile tek başına memory değildir. Memory, bilginin oluştuğu, saklandığı, adreslendiği, yeniden bulunduğu, kullanıldığı, değiştirildiği ve geçmişiyle ilişkilendirildiği bir yaşam döngüsüdür.
