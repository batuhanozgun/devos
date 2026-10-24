# Roman Analojisi: Kullanıcı Talebinden Yaşayan İş Tanımına

SOUL üzerine düşünürken ortaya çıkan temel problemlerden biri şuydu: Kullanıcının söylediği şey ile gerçekten yapılması gereken iş aynı şey değildir.

Bir kullanıcı sisteme bir talepte bulunur. Bu talep genellikle eksik, dar, sonuçları düşünülmemiş veya yalnızca kullanıcının o anda ifade edebildiği kadardır. Kullanıcının sistemden daha az bilgiye sahip olması olağandır; hangi soruların sorulması gerektiğini, işin hangi bağımlılıklarının bulunduğunu veya talebinin ilerleyen aşamalarda hangi başka problemleri doğuracağını bilmesi beklenemez.

Bu nedenle SOUL'a gelen ilk talebi doğrudan Work kabul etmek sorunludur.

Bunu anlamak için kullandığımız ana analoji roman yazmak oldu.

Bir kullanıcı gelip “Bir roman yazmak istiyorum.” dediğinde yüzeydeki talep açıktır: roman yazılacaktır. Fakat “roman yazmak” gerçekte ne demektir?

İlk bakışta konu, karakterler, anlatı yapısı, dönem, üslup, bölüm planı ve metnin kendisi düşünülebilir. Ancak romanın neden yazıldığı sorulduğunda problem alanı genişleyebilir. Roman yalnızca kişisel olarak yazılacak bir metin mi olacaktır? Bitmiş bir elyazması mı hedeflenmektedir? Basılacak mıdır? Yayıncı bulunacak mıdır? Okura ulaşması mı amaçlanmaktadır? Dağıtım, fiyatlama, reklam, PR, sosyal medya veya yazarlık kariyeri gibi konular işin parçası mıdır?

Bunların hiçbiri kullanıcının ilk cümlesinde bulunmak zorunda değildir.

Bu yüzden kullanıcının söylediği ilk talep ile sistemin üzerinde çalışacağı gerçek problem alanı arasında bir keşif süreci gerekir.

Buradaki önemli nokta, SOUL'un kullanıcının söylediğini keyfî biçimde genişletmesi değildir. “Roman yaz” denildi diye otomatik olarak yayıncılık şirketi kurmak veya bütün olası konuları işe dahil etmek doğru olmaz. Kullanıcı gerçekten yalnızca kendisi için bir roman yazmak istiyor olabilir.

Ama sistem bu ihtimallerin varlığından habersiz de olmamalıdır.

Dolayısıyla SOUL'un görevi yalnızca verilen talebi uygulamak değil, talebin hangi sonuca ulaşmak için verildiğini, hangi kapsamın gerçekten gerekli olduğunu ve hangi belirsizliklerin işi değiştirebileceğini keşfetmektir.

Roman analojisinin ikinci ve daha önemli tarafı burada ortaya çıkar.

Bu keşfin tamamen bitmesini bekleyip sonra execution'a geçmek de doğru değildir.

Klasik ve fazla basit model şöyle düşünülebilir:

Talebi anla → planı tamamla → execution'a başla

Roman örneği bunun neden yetersiz olduğunu gösteriyor.

Bir romanın yazılmaya başlanabilmesi için bütün yayıncılık sürecinin önceden çözülmesi gerekmez. Romanın konusu, yönü ve gerekli temel yaratıcı kararları yeterince anlaşılmışsa ilk bölüm yazılabilir.

Yani problem tanımı bütünüyle kapanmamış olsa bile ilk Work'ü güvenli biçimde başlatmak için yeterli bilgi oluşmuş olabilir.

Fakat execution başladığında yeni bilgiler ortaya çıkar.

Örneğin başlangıçta romanın dağıtımı ayrı bir iş olarak düşünülmüş olabilir. Daha sonra bir yayıncıyla çalışılacağı öğrenilir ve yayıncının dağıtımı zaten yönettiği anlaşılır. Bu durumda önceden Work listesinde bulunan “dağıtım şirketi bul” işi tamamen ortadan kalkabilir.

Ya da roman yazılırken ortaya çıkan yaratıcı bir karar kitabın hedef kitlesini değiştirir. Hedef kitlenin değişmesi yayıncılık stratejisini, editoryal yaklaşımı veya tanıtım yöntemini değiştirebilir.

Burada INFORMATION yalnızca Work'ü beslememektedir. Work de yeni INFORMATION üretmektedir. Bu yeni bilgi tekrar problem tanımını değiştirir. Problem tanımındaki değişiklik Work'ü yeniden planlatır.

Ortaya çıkan yapı doğrusal değil, döngüseldir:

Kullanıcı talebi → anlamlandırma → yeterli problem tanımı → Work → yeni bilgi → problem tanımının değişmesi → Work'ün yeniden düzenlenmesi → yeni Work → yeni bilgi...

Dolayısıyla “anlama” ve “execution” birbirinden kesin sınırlarla ayrılan iki faz değildir.

Daha doğru yaklaşım şudur: Sistem, mevcut bilgiyle hangi işlerin artık güvenle yapılabileceğini belirler. İlk işin değişmesini gerektirecek kritik belirsizlikler yeterince azaldığında o işi başlatır. Fakat aynı anda problem tanımının henüz tamamen kapanmadığını bilir.

İlk Work yürütülürken ortaya çıkan bilgi tekrar değerlendirilir. Eğer yeni bilgi yalnız sonraki işleri etkiliyorsa plan güncellenir ve ilerlenir. Eğer yeni bilgi yapılan ilk işi de geçersiz hale getiriyorsa, gerektiğinde ilk iş yeniden yapılır.

Bu nedenle başlangıç koşulu “Problemi tamamen anladık.” değildir. Daha doğru koşul şuna yakındır:

“Mevcut anlayışımız, sıradaki işi yapmanın makul olduğuna yetecek kadar güçlü ve o işi değiştirebilecek kritik belirsizliklerin farkındayız.”

Bu ayrım SOUL için önemlidir çünkü gerçek dünyadaki büyük işler çoğu zaman baştan eksiksiz tanımlanamaz. Araştırma, tasarım, yazılım geliştirme, şirket kurma veya roman yazma gibi işlerde sistem hem çalışır hem öğrenir. Öğrendikleri yalnız mevcut işi nasıl yapacağını değil, aslında hangi işin yapılması gerektiğini de değiştirebilir.

Bu yüzden SOUL'un Work sistemi statik bir görev listesi gibi düşünülemez. Work yaşayan bir yapıdır.

Aynı şekilde INFORMATION da yalnızca başlangıçta toplanan bağlam değildir. Work sırasında sürekli üretilen, problem tanımını ve sonraki işleri değiştirebilen aktif bir sistem bileşenidir.

Roman analojisi esas olarak iki fikri görünür hale getirir:

Birincisi: Kullanıcının söylediği talep, gerçek Work değildir. Önce talebin arkasındaki amaç ve problem alanı keşfedilmelidir.

İkincisi: Bu keşif tamamlanıp kapatıldıktan sonra execution başlamaz. Problem tanımı, INFORMATION ve Work execution boyunca birbirlerini değiştirmeye devam eder.

Kısacası SOUL'dan beklenen çalışma biçimi şuna benzer: yeterince anlayınca hareket etmek, hareket ederken öğrenmek ve öğrendikçe hem işi hem de işin tanımını gerektiğinde yeniden kurmak.
