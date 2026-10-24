# Roket Kademesi Gibi Ayrılmayan SOUL: Baz Sistemden İşe Özgü Yaşayan Organizmaya

SOUL üzerine düşünürken bir noktada zihnimdeki yapıyı anlatmak için uzaya giden bir roket/mekik analojisi kullanmıştım.

Kabaca şöyle bir ayrımdan şüphe etmeye başladım:

SOUL → başka bir çalışma sistemi kurar → o sistem işi yapar

Bu model ilk bakışta mantıklı.

SOUL merkezde bir “system former” olur; kullanıcı talebini alır, gerekli agent'ları, Work yapısını, Information düzenini ve araçları kurar; sonra oluşturduğu sistem işi yürütür.

Fakat benim zihnimdeki yapı bundan biraz farklıydı.

SOUL, bir çalışma sistemi kurup sonra roketin atılan kademesi gibi ondan ayrılmıyor olabilir.

Tam tersine, iş geldikçe kendisini genişletiyor olabilir.

Uzaya giden bir rokette bazı parçalar belirli bir aşamaya kadar görev yapar. Sonra görevlerini tamamlarlar ve ana araçtan ayrılırlar.

SOUL'u böyle hayal etmiyorum.

SOUL → Work System yaratır → Work System bağımsız hale gelir → SOUL artık dışarıda kalır

gibi keskin bir kopuş bana doğru gelmiyor.

Daha çok şöyle bir yapı hayal ediyorum:

BASE SOUL → bir Mission ile karşılaşır → ihtiyaçları keşfeder → Work oluşturur → Actor'lar ekler → Information düzeni kurar → araçlar ve Environment bağlar → kontrol ve verification yolları oluşturur → EXPANDED SOUL

Yani ortaya çıkan şey SOUL + ayrı sistem değil, işe göre genişlemiş SOUL olabilir.

Baz SOUL henüz belirli bir kullanıcı işi yokken genel yeteneklere sahiptir: talebi anlamlandırma, Work keşfetme, Actor oluşturma, Information hazırlama, araç/capability bağlama, doğrulama, continuity ve adaptation.

Sonra Mission gelir. Örneğin “Bir roman yaz.”, “Bir yazılım sistemi geliştir.” veya “Bir yıllık soru bankası üret.”

SOUL artık bu işe özgü yapılar oluşturmaya başlar:
- Mission state
- Work structure
- domain Actor'ları
- domain Information
- karar kayıtları
- tool bağlantıları
- verification düzeni
- memory

Bu yapı işi yürütmeye başladığında artık baz SOUL'dan daha büyüktür. Ama bu yeni yapı SOUL'dan kopmuş değildir. SOUL'un mevcut çalışma hali olmuştur.

Örneğin SOUL'un belirli bir işte güvenlik uzmanlığına ihtiyacı olduğunu fark ettiğini düşünelim. Yeni bir Security Actor oluşturuyor.

Bunu “SOUL Security Agent yaratır.” şeklinde düşünmek kolay. Ama sistem perspektifinden başka türlü bakabiliriz.

Security Actor geldiği anda SOUL'un toplam yapısı artık Security Actor'ı, onun Work'ünü, eriştiği Information'ı, authority sınırlarını, ürettiği kayıtları, verifier ilişkilerini ve kullandığı tools'u içerir.

Dolayısıyla SOUL yeni bir Actor yaratmakla yalnızca dışarıya worker göndermiyor; kendi çalışma organizmasını genişletiyor.

Aynı şey bilgi için de geçerli. SOUL bir domain hakkında araştırma yapıyor, yeni kaynaklar buluyor, kararlar veriliyor, çalışma sırasında yeni deneyim oluşuyor. Bütün bunlar sistemin Information alanını büyütüyor.

Benzer şekilde Work de dışarıdaki task listesi değildir. Ne yapılacağını, neyin açık olduğunu, hangi dependency'lerin bulunduğunu, neyin ready olduğunu ve kimin ne üzerinde çalıştığını taşıyorsa SOUL'un mevcut durumunun önemli bir parçasıdır.

Bu nedenle SOUL sabit bir beyin + dışarıdaki proje yönetim sistemi şeklinde olmak zorunda değildir. Daha çok Mission geldikçe Work, Actor, Information ve Environment ilişkileriyle şekillenen yaşayan çalışma organizması gibi düşünülebilir.

Konuşurken “SOUL” ve “SOUL'un oluşturduğu çalışma sistemi” diye ayırmak hâlâ kullanışlı olabilir. Fakat bu kavramsal kolaylık, mimaride mutlaka iki ayrı sistem bulunduğu anlamına gelmemeli.

Belki analitik olarak bunlar aynı sistemin farklı oluşum evreleridir.

SOUL sürekli genişliyorsa “SOUL'u SOUL yapan sabit şey nedir?” sorusu da çıkar.

Her Work için yeni Actor'lar, yeni Information ve yeni araçlar geliyorsa SOUL herhangi bir agent swarm'a dönüşebilir mi?

Burada baz yapının önemini görüyorum.

SOUL'un kalıcı tarafı muhtemelen belirli domain bileşenleri değil, daha üst seviyedeki çalışma kabiliyetleridir:
- hedefi anlamlandırma,
- Work keşfetme,
- doğru Actor düzenini oluşturma,
- Information lifecycle yönetme,
- authority ve control kurma,
- verification yapma,
- continuity koruma,
- değişiklikten öğrenme.

Yani SOUL'un kimliği hangi Actor'ların o anda bulunduğunda değil, Actor/Work/Information/Environment ilişkilerini hangi prensiplerle oluşturup sürdürebildiğinde yatıyor olabilir.

Yeni capability mevcut sistemle bütünleşir, Information dolaşımına katılır, kontrol mekanizmalarına bağlanır ve sistemin geri kalanını etkiler.

Bu yüzden entegrasyon capability creation kadar önemlidir.

Örneğin Security Actor çalışıyor ve harika rapor üretiyor. Ama SOUL'un Work sistemi raporu bilmiyor, decision mechanism raporu kullanmıyor, memory onu kaydetmiyor, verifier sonuçlarını görmüyor veya başka Actor'ların context'ine gerektiğinde girmiyorsa Security Actor teknik olarak vardır ama SOUL'un gerçek parçası olmamıştır.

Dolayısıyla yeni capability'nin gerçek kabul koşulu yalnız “Çalışıyor mu?” değildir. Şu da gerekir: “SOUL'un geri kalan çalışma sistemiyle doğru ilişkilere girmiş mi?”

SOUL büyürken kontrol sistemi de büyümeli. Yeni Actor varsa authority kontrolü onu kapsamalı. Yeni Information varsa provenance ve memory onu kapsamalı. Yeni tool varsa Environment/access mekanizması onu kapsamalı. Yeni Work varsa planning ve continuity onu kapsamalı.

Bu nedenle SOUL'un genişlemesi yalnız capability accumulation değildir. Governance, Information, Work ve control topology'sinin beraber genişlemesidir.

Mission tamamlandığında işe özgü genişlemiş SOUL'un tamamı kalıcı olmak zorunda değildir. Bazı parçalar kapanabilir, arşivlenebilir, başka işlerde yeniden kullanılabilir, genel öğrenmeye dönüştürülebilir veya tamamen bırakılabilir.

Daha doğru lifecycle belki şudur:

BASE → FORM → EXPAND → OPERATE → ADAPT → COMPLETE → RETAIN / GENERALIZE / ARCHIVE / RELEASE

Bu da SOUL'un statik bir ürün değil, yaşayan bir çalışma sistemi olması fikrini güçlendiriyor.

Bir Mission sırasında çok iyi bir verification yöntemi keşfedildiğinde bu yöntem gerçekten genel ve doğrulanmışsa SOUL'un baz capability'sine aktarılabilir. Böylece Mission-specific expansion zamanla general SOUL improvement üretebilir.

Ama her proje bilgisini baza taşımak yanlış olur. Roman yazarken öğrenilen “karakterin adı Derya'dır” bilgisi baz SOUL'un parçası olmamalıdır. Buna karşılık uzun anlatılarda geç ortaya çıkan motivasyon değişikliklerinin geçmiş sahnelere semantik etkisinin taranması gibi genel bir yöntem yeniden kullanılabilir.

Dolayısıyla mission-specific knowledge ile reusable learning ayrılmalıdır.

Development OS'un amacı SOUL için hazır bir sabit agent paketi üretmek olmamalı olabilir. Daha temel hedef, iş geldiğinde kendisini doğru çalışma organizmasına dönüştürebilen baz SOUL'u üretmek olabilir.

Ürün “20 predefined agent + 50 workflow + 10 tool = SOUL” gibi değil; Mission'ı anlayan, Work keşfeden, Actor oluşturan, Information hazırlayan, Environment bağlayan, Control kuran ve bu Mission'ın gerektirdiği çalışma sistemine dönüşen bir baz kapasite olmalıdır.

SOUL bir organizasyon kurup sonra kapının dışından yöneten danışman olmamalı. Kurulan organizasyon SOUL'un güncel hali olmalı.

Roket kademesinde bir parça görevini yapar, ayrılır; diğer sistem yoluna devam eder. SOUL için sezgim bunun tersidir: Baz SOUL Mission ile karşılaşır, gerekli parçaları oluşturur ve onlarla birlikte yeni bir çalışma hali kazanır.

SOUL'un görevi kullanıcı işi için kendisinden bağımsız bir sistem üretip çekilmek değil; Mission'ın gerektirdiği Actor, Work, Information, capability ve kontrol yapılarını kendi yaşayan çalışma organizmasına dahil ederek o işi yapabilecek hale dönüşmek olabilir.
