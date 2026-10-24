# Yatay ve Dikey Genişleyen SOUL: Framing'in Açtığı ve Daralttığı Düşünce Alanı

SOUL üzerine düşünürken bir noktada “SOUL büyüyen, genişleyen bir yapı” ifadesini kullanmıştım.

Bu ifade ilk bakışta doğru geliyordu. Ama sonra şunu fark ettim:

Doğru bir ifade bile düşünme alanını yanlış biçimde daraltabilir.

“SOUL büyür” dediğimde bunun doğal çağrışımı “Yeni ihtiyaç çıktıkça SOUL'a yeni parçalar eklenir.” olabilir. Bu yanlış değil. Ama eksik.

Çünkü benim kastettiğim büyüme yalnızca yeni modüller, yeni Actor'lar veya yeni fonksiyonlar eklemek değildi. SOUL'u daha çok iki eksende genişleyen bir yapı gibi hayal ediyordum:

- dikey genişleme
- yatay genişleme

Dikey genişleme daha sezgisel olan taraf. SOUL'un baz halinde sahip olmadığı yeni bir ihtiyaç ortaya çıkar. Sistem başlangıçta araştırma, planlama veya basit üretim yapabiliyor olsun. Sonra yeni Work nedeniyle güvenlik uzmanlığı, yeni bir domain bilgisi, farklı bir verification yöntemi veya özel bir tool kullanımı gereksin.

Böylece sisteme yeni bir Actor, yöntem veya capability eklenir. SOUL yeni bir şeyi yapabilir hale gelmiştir.

Ama yalnızca yeni capability eklemek yetmez.

Yeni Actor veya yeni çalışma yüzeyi sisteme girdiğinde mevcut fonksiyonların bazıları da onu kapsayacak şekilde genişlemek zorunda kalabilir.

Örneğin baz SOUL'da iki dosya üzerinde çalışan basit bir kontrol mekanizması olduğunu düşünelim. Sonra yeni bir Actor sisteme dahil edildi. Bu Actor yeni dosyalar okuyor, yeni dosyalar yazıyor, yeni kararlar üretiyor.

SOUL yalnızca “Yeni Actor ekledim.” deyip bırakamaz. Daha önce var olan context management, memory, provenance, verification, authorization, Work tracking, continuity ve change-impact mekanizmalarının bir bölümü artık bu yeni Actor'ın ürettiği yüzeyleri de kapsamalıdır.

Yani yeni parçanın eklenmesi, mevcut sistemin geri kalanında kapsam genişlemesi yaratır. Bu yatay genişlemedir.

Yeni Actor yalnızca yeni bir kutu değildir.

Bir sistem diyagramında yeni bir Actor eklemek kolay görünür. Yeni kutu çizilir ve bitti sanılır. Ama gerçekte bu Actor'ın sisteme katılması başka sorular üretir:
- Hangi Work'ü görebilecek?
- Hangi bilgiye erişecek?
- Ürettiği bilgi memory'ye nasıl girecek?
- Kim onun çıktısını doğrulayacak?
- Hangi authority'ye sahip?
- Session değiştiğinde state'i nasıl recover edilecek?

Dolayısıyla yeni Actor = yalnızca yeni capability değildir. Yeni Actor mevcut mekanizmaların kapsaması gereken yeni bir sistem yüzeyidir.

Dikey büyüme çoğu zaman yatay büyümeyi de tetikleyebilir:

Yeni ihtiyaç → yeni capability / Actor → yeni bilgi ve Work yüzeyleri → mevcut kontrol mekanizmalarının kapsamı değişir → SOUL'un mevcut yapısı yatay olarak genişler.

Bu ayrım başka bir probleme de ışık tutuyor. Bir sisteme yeni tool veya plugin eklemek teknik olarak capability artışıdır. Ama SOUL açısından gerçek genişleme olup olmadığı ayrı sorudur.

Örneğin yeni bir browser tool'u geldi. Bu yalnızca “Artık web'e erişebiliyoruz.” demek değildir. Web'den gelen kaynak nasıl sınıflandırılacak, provenance nasıl korunacak, stale bilgi nasıl anlaşılacak, external evidence hangi kararları değiştirebilir gibi sorular da ortaya çıkar.

Capability addition ile system integration aynı şey değildir.

Bu düşünceyi konuşurken daha meta bir farkındalık ortaya çıktı. Ben “SOUL genişleyecek.” dediğimde söylediğim şey yanlış değildi. Ama “genişleme” kelimesi cevabın dikkatini yalnız yeni şeyler eklemek tarafına çekebilirdi.

Oysa benim zihnimde mevcut sistemin kapsamının da yeniden oluşması vardı.

Burada şunu fark ettim: Bir cümle modele yararlı bir perspektif verirken aynı anda olası başka perspektifleri arka plana itebilir.

Context yalnız bilgi eklemez, option space'i de şekillendirir.

Bir modele “SOUL büyüyen bir sistemdir.” dediğimizde context'e bir bilgi eklemiş oluruz. Ama aynı zamanda problemin framing'ini de değiştirmiş oluruz.

Model artık expansion, new components, scaling gibi kavramlara daha fazla ağırlık verebilir. Fakat replacement, contraction, integration, removal, reconfiguration gibi başka olasılıklar daha az görünür hale gelebilir.

Dolayısıyla context engineering yalnız doğru bilgiyi vermek değildir. Aynı zamanda verilen bilginin düşünce alanını nasıl şekillendirdiğini fark etmek problemidir.

Doğru bir framing eksik bir dünya modeli yaratabilir.

“SOUL büyür.” demek doğrudur. Ama “SOUL bazı durumlarda küçülür, birleşir, eski mekanizmayı kaldırır veya mevcut fonksiyonların kapsamını yeniden tanımlar.” olasılıklarını görünmez yapmamalıdır.

Buradan önemli bir sonuç çıkıyor: SOUL'un adaptasyonu yalnız additive olmamalıdır.

Yeni ihtiyaç geldiğinde sistem her zaman + yeni Actor, + yeni tool, + yeni dosya şeklinde büyürse zamanla gereksiz karmaşıklık oluşabilir. Bazen doğru adaptasyon iki rolü birleştirmek, eski bir yöntemi bırakmak, redundant capability'yi kaldırmak veya mevcut Actor'ın kapsamını değiştirmek olabilir.

Dolayısıyla “genişleyen SOUL” daha doğru ifadeyle ihtiyaca göre yeniden şekillenen SOUL olabilir.

Yeni capability ortaya çıktığında SOUL bunu hemen kendi parçası mı sayacak? Bence hayır. Yeni capability denenebilir, sınanabilir, qualification'dan geçebilir ve sonra kabul edilebilir.

Bu açıdan bana Git branch yapısını çağrıştıran bir fikir ortaya çıkmıştı. Branch'i burada literal olarak zorunlu implementation seçimi olarak önermiyorum. Analojinin değeri şu: değişiklik ile kabul edilmiş sistem durumu ayrı tutulabilir.

Current accepted system ve candidate change aynı şey değildir.

Yeni yöntem keşfedildi. Bu henüz SOUL'un yöntemi değildir. Yeni Actor tasarlandı. Bu henüz production Actor değildir. Yeni memory yapısı önerildi. Bu henüz current architecture değildir.

Önce değerlendirme alanında bulunabilir. Sonra acceptance gerçekleşirse current state'e geçer.

SOUL'a yeni bir Actor eklenirken yalnız “Actor çalışıyor mu?” test edilmemeli. Aynı zamanda “Mevcut sistem onun varlığını doğru şekilde kapsıyor mu?” sorusu da sorulmalı.

Actor başarılı sonuç üretiyor ama memory sistemi çıktısını kaydetmiyor, verifier onu görmüyor, authority sınırı yok veya recovery sistemi onu bilmiyorsa lokal capability çalışıyor olabilir ama SOUL'a gerçekten entegre olmamıştır.

Bu konuşmanın benim için en değerli meta sonucu ise şuydu: Bir şey söylediğimde, söylediğim şeyin yalnız doğru olup olmadığını değil, “Bu cümle düşünceyi hangi yöne çekiyor ve hangi olasılıkları sessizce görünmez yapıyor?” sorusunu da sormalıyız.

Bir kavram güçlü bir lens olabilir; ama lens aynı zamanda görüş alanını sınırlar.

SOUL'un gelişmesi yalnız yeni parçalar eklemek değildir; yeni parçalar geldikçe sistemin mevcut ilişkileri de yeniden kapsam kazanmalıdır ve bu süreci düşünürken kullandığımız framing'in olası çözüm alanını sessizce daraltmasına karşı dikkatli olmalıyız.
