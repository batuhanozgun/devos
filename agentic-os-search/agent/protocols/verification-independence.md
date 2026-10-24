# Doğrulama Geçerliliği, Bağımsızlığı ve Hata-Duyarlılığı

## Amaç

Bir review, eleştiri, re-check, test, metric veya verifier hükmünün ürettiği güveni olduğundan güçlü saymayı önle.

Amaç her doğrulamada farklı model veya farklı ajan kullanmak ya da her testi kusursuz kabul etmek değildir. Amaç, **doğrulamanın hangi hata yollarını gerçekten dışlayabildiğini; ne kadar bağımsız, hata-duyarlı, uygun oracle'a dayalı, kapsamlı, kriter-bütünlüğü korunmuş, challenge yüzeyi güncel ve verdict'i taze olduğunu değerlendirerek güven artışını hak ettiği seviyede tutmaktır.**

## Temel Ayrım

Aşağıdakileri birbirine karıştırma:

- tekrar düşünme ile bağımsız doğrulama,
- farklı ajan etiketi ile epistemik bağımsızlık,
- farklı model ile otomatik doğruluk,
- yeşil test ile hata yakalama kapasitesi,
- metric üretmek ile doğru özelliği ölçmek,
- aynı sonuca tekrar ulaşma ile yeni kanıt,
- eleştiri üretme ile hatayı gerçekten dışlama,
- bir kontrolün varlığı ile gerekli çalışma kiplerinde gerçekten devreye girmesi,
- önceden belirlenmiş başarı ölçütü ile sonucu gördükten sonra uyarlanmış ölçüt,
- keşifsel bulgu ile önceden belirlenmiş doğrulama,
- aynı challenge setini tekrar koşmak ile değişen risk yüzeyini yeniden sınamak,
- azalan bulgu sayısı ile azalan gerçek hata sayısı,
- geçmişte geçerli bir verdict ile bugün hâlâ geçerli verdict.

Bir doğrulama yararlı olabilir; fakat ürettiği güven yalnız bağımsızlığına değil, yanlış durumda kırmızı verebilmesine, doğru şeyi ölçmesine, başarı kuralının sonuçtan sonra sessizce değiştirilmemiş olmasına ve kullanılan challenge'ın hâlâ ilgili hata yüzeyine duyarlı olmasına da bağlıdır.

## Protokol

### 1. Doğrulamanın Güven Üretip Üretmediğini Belirle

Bir review, eleştiri, ikinci-pass kontrol, test, metric, benchmark, oracle veya verifier hükmü cevabın doğruluğuna, mekanizmanın etkililiğine ya da artefaktın güvenilirliğine duyulan güveni anlamlı biçimde artırmak için kullanılıyorsa doğrulamanın geçerliliğini değerlendir.

Salt stil düzeltmesi, açıklık kontrolü veya sonucu değiştirmeyen proofreading bu protokolün merkez problemi değildir.

### 2. Doğrulama İddiasını ve Nesnesini Ayır

Önce doğrulamanın neyi kanıtlamasının beklendiğini belirle:

- belirli bir hesap doğru mu,
- belirli bir artefakt spesifikasyonu karşılıyor mu,
- bir mekanizma gerçekten belirli failure mode'u engelliyor mu,
- bir test suite regresyonu yakalıyor mu,
- bir metric kullanıcı değerini temsil ediyor mu,
- bir verifier belirli hata sınıflarını dışlıyor mu.

Doğrulama nesnesi ve iddia belirsizse yeşil sonuçtan geniş güven üretme.

### 3. Bağımsızlığı Sına

İlk hükmün veya üretici yolunun hangi epistemik bileşenlere dayandığını ayır:

- temel varsayımlar,
- problem çerçevesi,
- decomposition / çözüm yolu,
- kullanılan kaynaklar,
- ara çıkarımlar,
- testler veya oracle'lar,
- kabul kriterleri.

İkinci hüküm veya verifier bunların büyük ölçüde aynısını paylaşıyorsa ortak nedenli hata üretebilir.

Mümkün olduğunda doğrulama yolunu maddi biçimde ayrıştır:

- farklı ve bağımsız kaynak kullan,
- sonucu yeniden hesapla,
- artefaktı doğrudan yeniden çalıştır veya reperformance yap,
- deterministik ya da dış oracle kullan,
- farklı decomposition veya çözüm tekniği uygula,
- maker'ın açıklamasına ankrajlanmadan artefaktı incele,
- uygun olduğunda farklı model veya aktör kullan.

Başka bir ajan, başka bir oturum veya başka bir model tek başına bağımsız doğrulama kanıtı değildir.

### 4. Hata-Duyarlılığını / Falsifiability'yi Sına

Bir kontrolün yeşil vermesi ancak yanlış durumda kırmızı verebildiği ölçüde anlamlıdır.

Şu karşı-olgusal testi uygula:

**“İddia veya mekanizma ilgili biçimde yanlış olsaydı, bu doğrulama yolu gerçekten başarısızlık sinyali üretir miydi?”**

Mümkün ve güvenliyse bunu kasıtlı bozma, negatif örnek, karşı örnek, mutation, ters senaryo veya bilinen-hatalı fixture ile sınayarak kontrolün kırmızıya dönebildiğini göster.

Bir test yanlış durumda da yeşil kalıyorsa testin varlığı güven üretmez; en fazla ölçmediği şey hakkında bilgi verir.

### 5. Oracle Geçerliliğini Kontrol Et

Bir doğrulama ancak ölçtüğü yüzey iddia edilen özelliği gerçekten temsil ediyorsa anlamlıdır.

Şunları kontrol et:

- Test kendi ürettiği değeri yine kendi beklenen sonucu olarak mı kullanıyor?
- Fixture gerçek üretim verisi veya davranışıyla yeterince biçim-eş mi?
- Metric gerçekten hedeflenen başarıyı mı ölçüyor, yoksa kolay ölçülebilen bir proxy'yi mi?
- Benchmark gerçek kullanım dağılımına genellenebilir mi?
- Kontrol yalnız biçimi ölçüp içerik doğruluğu hakkında hüküm mü üretiyor?
- Kod veya sistem kendi oracle'ı olarak dairesel biçimde mi kullanılıyor?

Oracle zayıfsa yeşil sonucu daha güçlü bir iddiaya yükseltme.

### 6. Kriter Bütünlüğünü ve Post-Hoc Uyarlamayı Kontrol Et

Doğrulama sonucu; başarı kriteri, metric, threshold, dışlama kuralı, fixture, test veya oracle sonucu görüldükten sonra değiştirildiyse bu değişikliği epistemik olarak ayrı değerlendir.

Şu soruları sor:

- Başarı ölçütü veya eşik sonuç görülmeden önce mi belirlenmişti?
- Sonuç kötü çıktığı için threshold, kapsam veya kabul tanımı gevşetildi mi?
- Kabul kriterinin metni sabit kalırken onu doğrulayan test veya oracle daha kolay geçecek biçimde yeniden tanımlandı mı?
- İstenmeyen koşular sonuç görüldükten sonra “teknik contamination”, “outlier” veya “kapsam dışı” diye örneklemden çıkarıldı mı?
- Bir metriğin paydası, pencere uzunluğu, segmenti veya aggregation yöntemi sonucu gördükten sonra seçildi mi?
- Yeni kriter gerçek bir tasarım düzeltmesi mi, yoksa mevcut sonucu geçerli göstermek için outcome-dependent bir uyarlama mı?

Post-hoc değişiklik otomatik olarak yasak değildir. Gerçek bir kusur fark edildiğinde kriter, test veya oracle düzeltilebilir.

Ancak temel kural şudur:

**Sonucu gördükten sonra değiştirilen doğrulama kuralı, aynı sonuç tarafından bağımsız biçimde doğrulanmış sayılamaz.**

Yeni kriter önemliyse mümkün olduğunda fresh evidence, yeni koşu, holdout, bağımsız örnek veya yeniden-performans üzerinde tekrar sınanmalıdır.

Bu mümkün değilse sonucu confirmatory doğrulama gibi değil, keşifsel / post-hoc bulgu olarak etiketle ve güven dilini buna göre sınırla.

Önceden belirlenmiş criterion ile sonradan keşfedilen iyileştirmeyi birbirine karıştırma. Exploratory analiz yeni hipotez üretmek için değerlidir; fakat aynı veri üzerinde sonradan optimize edilmiş hipotezi önceden belirlenmiş doğrulama gibi sunma.

### 7. Coverage ve Çalışma Kipi Kontrolü Yap

Bir güvence teorik olarak doğru olsa bile gerekli çalışma kiplerinde hiç devreye girmiyorsa ilgili risk için koruma sağlamaz.

Şu soruyu sor:

**“Bu kontrol hangi önemli durumda hiç koşmuyor, atlanıyor, yanlış yüzeye bağlanıyor veya yalnız daha sonraki bir evrede tetikleniyor?”**

Özellikle:

- hata kontrolün tetiklenmesinden önce oluşabiliyor mu,
- belirli platform, veri biçimi veya durum kontrol yolunu atlıyor mu,
- retry/fallback yolu doğrulamayı by-pass ediyor mu,
- yalnız happy-path test edilmiş mi,
- kontrolün coverage'ı iddia edilen kapsamı gerçekten taşıyor mu

değerlendir.

### 8. Doğrulama Ritüelleşmesini ve Challenge Freshness'ını Kontrol Et

Aynı review biçimi, adversarial lens, checklist, fixture seti veya challenge paketi tekrar tekrar kullanıldığında düşük bulgu sayısını otomatik olarak düşük gerçek hata sayısı kabul etme.

Özellikle insan/LLM değerlendirmeleri, adaptif sistemler, değişen ürün yüzeyleri ve sabit fixture'larla yapılan tekrar koşularında şu soruyu sor:

**“Bu doğrulama yöntemi hâlâ bugünkü yük taşıyan hata sınıflarını ayırt edebiliyor mu, yoksa aynı bakış açısı tekrarlandığı için ritüelleşmiş olabilir mi?”**

Şunları kontrol et:

- nesne veya risk yüzeyi değiştiği halde challenge seti aynı mı kaldı,
- önceki incelemelerde bulunan hata sınıfları kontrol listesini domine edip yeni sınıfları görünmez mi kılıyor,
- aynı reviewer / prompt / fixture kombinasyonu öğrenilmiş veya öngörülebilir hale gelmiş olabilir mi,
- bulgu sayısının düşmesi gerçek iyileşmeden mi, verifier körleşmesinden mi kaynaklanıyor,
- değişiklik-delta'sı biliniyorsa challenge özellikle değişen yüzeye yöneltilmiş mi,
- nadir fakat yüksek etkili hata sınıfları düşük frekans nedeniyle challenge'dan düşmüş mü.

Gerekliyse challenge'ı değişiklik-delta'sına, yeni failure mode'lara, karşı örneklere veya holdout/variant örneklere göre tazele.

Ancak şu ayrımı koru:

**Deterministik, kapsamı ve oracle'ı açık, ilgili hata sınıfına karşı hâlâ duyarlı bir test sırf tekrarlandığı için bayat değildir.**

Ama kod, veri, risk yüzeyi, fixture dağılımı veya tehdit modeli maddi biçimde değiştiyse sabit test setinin hâlâ yeterli coverage taşıdığını yeniden değerlendir.

Ritüelleşme riski özellikle doğrulama yönteminin kendi kör noktalarının ölçülmediği durumlarda yüksektir.

### 9. Verdict Freshness'ını Kontrol Et

Doğrulanan artefakt, veri, kaynak, runtime, test/oracle, criterion, konfigürasyon veya başka yük taşıyan bağımlılık maddi biçimde değiştiyse eski doğrulama hükmünü otomatik olarak güncel sayma.

Güveni artıran verdict, doğruladığı nesne ve gerekli dependency closure ile birlikte düşünülmelidir.

### 10. İlk Sonuca Ankrajlanmayı Azalt

Verifier'a yalnız maker'ın sonucunu tekrar savundurmak yerine problemi veya artefaktı yeniden sınat.

Özellikle:

- önceki cevabın özgüvenini kanıt sayma,
- önceki gerekçeyi tek değerlendirme çerçevesi yapma,
- yalnız “hata bul” diye sorup aynı öncülleri değişmeden koruma,
- ilk sonucun dilini ikinci hükmün kabul kriterine dönüştürme.

### 11. Doğrulama Yolu Sınırlıysa Güven İddiasını Sınırla

Gerçek bağımsızlık, hata-duyarlılığı, uygun oracle, criterion integrity, challenge freshness veya coverage kurulamadıysa kontrolü olduğundan güçlü adlandırma.

Gerekirse sonucu:

- `self-review`,
- `second pass`,
- `cross-check`,
- `limited test evidence`,
- `post-hoc / exploratory finding`,
- `stale challenge set`,
- `not independently verified`,
- `not falsification-tested`

gibi sınırlı statülerle ifade et.

Aynı sonuca tekrar ulaşılması veya testlerin yeşil olması yararlı sinyaller olabilir; ancak tek başına bağımsız ve geçerli doğrulama değildir.

## Kanıt Gücü İlkesi

Doğrulama iddiasının gücü, kullanılan doğrulama yolunun:

- bağımsızlığını,
- hata-duyarlılığını,
- oracle geçerliliğini,
- kriter bütünlüğünü,
- challenge freshness'ını,
- coverage'ını,
- verdict freshness'ını

aşmamalıdır.

Örneğin:

- aynı çözümü tekrar okumak → sınırlı self-review,
- farklı yöntemle aynı hesabı yeniden yapmak → daha güçlü cross-check,
- sonucu gördükten sonra threshold değiştirip aynı veriyi yeniden değerlendirmek → post-hoc / exploratory evidence,
- değişen risk yüzeyinde yıllardır aynı checklist'i hiç varyant üretmeden tekrar etmek → potansiyel ritüelleşmiş doğrulama,
- kasıtlı yanlış durumda kırmızı verdiği gösterilmiş, kriteri önceden sabitlenmiş, güncel risk yüzeyine uygun bağımsız oracle/reperformance → daha güçlü verification.

Bu örnekler mutlak bir seviye sistemi değildir; temel ilke, **güven artışını doğrulamanın gerçekten dışlayabildiği hata alanıyla, criterion'un ne ölçüde outcome'dan bağımsız belirlendiğiyle ve challenge'ın mevcut risk yüzeyine ne kadar duyarlı kaldığıyla orantılı tutmaktır.**

## Nihai Kontrol

Bir doğrulama confidence artırmak için kullanılıyorsa şu soruları değerlendir:

1. Doğrulama hangi iddiayı ve nesneyi gerçekten sınadı?
2. Üreticiyle hangi hata kaynaklarını ortak taşıyor?
3. İddia yanlış olsaydı kontrol gerçekten kırmızı verebilir miydi?
4. Oracle veya metric doğru özelliği mi ölçüyor?
5. Başarı kriteri, threshold, test veya dışlama kuralı sonucu görmeden önce sabit miydi; değilse yeni criterion fresh evidence üzerinde yeniden sınandı mı?
6. Gerekli çalışma kiplerinde kontrol gerçekten koşuyor mu?
7. Aynı challenge tekrar kullanılıyorsa hâlâ güncel hata yüzeyine duyarlı mı, yoksa ritüelleşmiş olabilir mi?
8. Doğrulama hükmü hâlâ aynı nesne, criterion ve bağımlılıklar için güncel mi?
9. Bu sınırlara göre güven dilim yeterince kalibre mi?

## Temel İlke

**Yeşil sonuç, ancak ilgili yanlışı ayırt edebilen, doğru şeyi ölçen, sonucu gördükten sonra sessizce yeniden tanımlanmamış ve mevcut risk yüzeyine hâlâ duyarlı geçerli bir doğrulama yolundan geldiğinde güven üretir.**

Doğrulamanın değeri aktör sayısından veya test sayısından değil; bağımsız, hata-duyarlı, uygun oracle'a dayalı, criterion bütünlüğü korunmuş, challenge'ı güncel ve geçerli kapsamda çalışarak ilgili hata ihtimalini gerçekten azaltmasından gelir.