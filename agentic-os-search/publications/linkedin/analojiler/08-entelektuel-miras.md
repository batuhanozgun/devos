# Entelektüel Miras: Actor'ın Bilgiye Erişmesi Yetmez, O Bilgiyle Düşünmesi Gerekir

SOUL üzerine düşünürken bir noktada şu ayrım benim için önemli hale geldi:

Bir Actor'ın bilgiye erişebilmesi ile o bilginin Actor'ın düşünme biçiminin parçası olması aynı şey değildir.

Bu farkı anlatmak için LLM'in kendi eğitim bilgisini analoji olarak kullanmıştım.

Bir LLM'i açtığımda model sıfır bilgiyle başlamıyor. Ben ona “Memory nedir?” diye sorduğumda önce gidip bir dosyadan memory kavramının varlığını öğrenmesi gerekmiyor.

Model zaten eğitim sürecinden gelen çok geniş bir bilgi tabanıyla çalışıyor. Ben bunun üzerine conversation context, project instructions, repository dosyaları ve yeni araştırmalar ekleyebiliyorum. Ama temel model bunlardan önce de bir dünya bilgisiyle “doğuyor”.

SOUL Actor'ları için düşündüğüm şey biraz buna benziyor.

Diyelim SOUL'un araştırma repository'sinde memory konusunda çok sayıda çalışma var: Karpathy örnekleri, Hermes, agent memory sistemleri, Foundation Information çalışmaları, geçmiş exploration'lar, başka studies.

Ve yeni bir Actor'a “Repository'ye erişebilirsin.” diyoruz.

Teknik olarak bu Actor bilgiye erişebilir. Ama şu iki Actor aynı değildir:

Actor A: Memory problemi geldiğinde yalnız eğitim bilgisinden cevap verir. Ancak açıkça “Repository'de memory araştırması var, git oku.” denirse onları açar.

Actor B: Memory problemi gördüğünde doğal olarak “Bu konuda bizim daha önce araştırmalarımız vardı. Hangi çalışmalar relevant olabilir? Foundation ne söylüyor? Studies tarafında hangi mekanizmaları incelemiştik?” diye düşünür.

İkinci Actor'ın davranışı benim istediğim yapıya daha yakın. Çünkü burada araştırma yalnız erişilebilir değildir. Araştırmanın varlığı Actor'ın düşünme eğilimine dahil olmuştur.

Bilginin adresini bilmek ile o bilginin perspektifini taşımak farklıdır.

Örneğin bir Actor'a “Memory araştırmaları research/studies altında.” notu vermek retrieval bilgisi sağlar. Ama “Memory problemi tek bir storage ürünü seçme problemi değildir; yaşam döngüsü, retrieval, provenance, stale bilgi, continuity ve change-impact gibi boyutları olabilir.” düşüncesini sağlamaz.

İkinci tür bilgi daha derindir. Çünkü artık Actor yalnız “Nerede dosya var?” sorusunu bilmiyor; “Bu probleme hangi açılardan bakılması gerektiğini” de öğrenmiş oluyor.

Benim “entelektüel miras” derken kastettiğim şey buna yakın.

Uzun bir araştırma programının amacı yalnız çok sayıda belge üretmekse ciddi bir sorun var. Yeni Actor geldiğinde yüzlerce dosyayı yeniden okuyup “Burada önemli ayrım neydi?” diye sıfırdan keşfetmek zorunda kalabilir.

Bu pahalıdır. Daha da önemlisi, farklı Actor'lar aynı araştırmadan farklı ve eksik çıkarımlar yapabilir.

Bu yüzden araştırmadan yalnız arşiv değil, yeniden kullanılabilir entelektüel birikim çıkması gerektiğini düşünüyorum.

Bir bilim alanındaki eğitim gibi. Bir fizikçi her yeni probleme başlarken Newton'un bütün özgün metinlerini yeniden okuyup mekaniği sıfırdan keşfetmez. Alan içindeki eğitim, yöntemler ve kavramsal ayrımlar sonraki çalışmanın başlangıç tabanına dönüşür.

SOUL araştırmasının da benzer bir rolü olabilir.

Actor “biz bu konuda ne öğrendik?” bilinciyle başlamalı.

Örneğin verification problemi geliyor. Actor yalnız “Test yazabiliriz.” dememeli. Araştırma birikimimizden dolayı maker ile verifier'ın aynı hata kaynağını taşıyabileceğini, testin yeşil olmasının tek başına yeterli olmadığını, oracle'ın yanlış şeyi ölçebileceğini, criterion'un sonuçtan sonra değişmiş olabileceğini veya doğrulamanın gerçekten yanlış durumda kırmızı verebilmesi gerektiğini düşünmeye eğilimli olmalı.

Bunların her birini o anda bütün kaynakları okuyarak yeniden keşfetmek zorunda olmaması ideal olur.

Actor'ın başlangıç bakışında bu tür araştırılmış ayrımların izleri bulunmalıdır. Sonra önemli karar gerektiğinde özgün kaynaklara geri dönebilir.

Bu iki katmanı ayırmak önemli:

entelektüel miras → ilk bakış ve soru üretimi
özgün kaynak → kritik hüküm ve doğrulama

“Entelektüel miras” demek repository'deki bütün eski sonuçları dogma gibi Actor'ın içine yazmak değildir.

Araştırmanın önemli derslerinden biri eski sonuçların koşullu, eksik, superseded, yanlış veya yalnız belirli bir bağlama ait olabileceğidir.

Dolayısıyla miras yalnız “Şu doğrudur.” tipinde sonuçlardan oluşmamalıdır. Daha değerlisi bazen “şu ayrımı unutma”, “şu failure mode'u kontrol et”, “şu varsayımı sessiz kabul etme”, “burada özgün kaynağa dönmek gerekebilir” gibi düşünme alışkanlıkları ve problem lens'leridir.

Bir mimarı projeye çağırdığımızda yalnız “Mimarın bütün kitapları şu klasörde.” demeyiz. Mimar o kitaplardan, eğitimden ve deneyimden zaten etkilenmiştir. Bir probleme baktığında yük, kullanım, malzeme, insan davranışı veya yapı ilişkileri gibi şeyleri doğal olarak düşünür.

Kitaplar gerektiğinde açılabilir. Ama mimarın değeri yalnız kitaplara erişebilmesi değildir. Hangi soruları sorması gerektiğini öğrenmiş olmasıdır.

SOUL Actor'ı için de benzer bir seviye istiyorum.

Bir Actor'a “Memory çözümleri arasında RAG, vector DB, dosya tabanlı memory gibi yöntemler var.” demek bilgi vermektir. Ama araştırmalarımızdan istediğim şey daha fazlası.

Actor şöyle bir bakış taşımalı:

“Memory çözümü seçmeden önce neyi memory olarak yönettiğimizi anlamalıyım. Persistence ile retrieval aynı şey değil. Bilginin varlığı ile current Actor'ın onu kullanması aynı şey değil. Revision ve append farklı olabilir. Provenance ve continuity önemli olabilir.”

Bu Actor artık yalnız çözüm isimleri bilen biri değildir. Problem alanını araştırmaların oluşturduğu daha olgun bir çerçeveyle görüyor.

Yalnız baz SOUL'un bu entelektüel birikime sahip olması yetmez. SOUL yeni bir çalışma sistemi kurduğunda oluşturduğu Actor'ların da gerekli kısmını taşıması gerekir.

Baz SOUL çok güçlü reasoning yapabilir. Ama oluşturduğu Actor'a yalnız “Sen frontend developer'sın.” deyip bırakırsa kendi araştırma birikimini ve düşünme standardını aşağıya aktarmamış olur.

Bu durumda SOUL'un zekâsı system-level intelligence haline gelmez. Merkezde kalan intelligence olur.

Actor'ın ortak tabanı yalnız underlying LLM'den gelmeyebilir. Şunların bileşiminden gelebilir:

base model knowledge
+ SOUL research heritage
+ role-specific knowledge
+ current Work context

Bu dört katman aynı şey değildir.

Research repository'nin değeri yalnız bugünkü SOUL tasarımına katkı vermek değildir. Araştırmalar zamanla Actor'ların entelektüel tabanını güçlendirebilir.

Bugün verification hakkında yeni bir failure mode öğreniriz. Bu yalnız bir belgeye yazılmaz. Gelecekte ilgili Actor'ların “Bunu kontrol etmem gerekiyor.” dediği doğal düşünme repertuarına eklenebilir.

Böylece research finding olarak başlayıp reusable reasoning capability haline gelir.

Ama her araştırma otomatik olarak mirasa dönüşmemeli. Bir şey repository'ye yazıldı diye hemen bütün Actor'ların kalıcı düşünme kültürüne dahil edilmemeli. Araştırma yanlış çıkabilir, provisional olabilir veya çok dar koşullarda geçerli olabilir.

Dolayısıyla research evidence → qualified finding → reusable principle/lens → Actor formation material → runtime reasoning dönüşümünün kendisi de kontrollü olmalıdır.

Bilgiye erişim ≠ bilgiyi kullanma eğilimi.

Bilgiyi kullanma eğilimi ≠ onu sorgulanamaz doğru kabul etmek.

SOUL'un araştırmaları yalnız Actor'ların okuyabileceği bir kütüphane olmamalı; zamanla Actor'ların neyi düşünmeye değer gördüğünü, hangi soruları sorduğunu ve hangi failure mode'lara doğal olarak dikkat ettiğini şekillendiren bir entelektüel mirasa dönüşebilmelidir.
