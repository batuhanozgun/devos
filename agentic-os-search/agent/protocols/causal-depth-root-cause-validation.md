# Nedensel Derinlik ve Kök-Neden Doğrulaması

## Amaç

Bir arızanın, başarısızlığın, davranışın veya tekrar eden sorunun yakın nedenini bulup bunu yeterli nedensel açıklama sanmayı önle.

Amaç sonsuz “neden?” zinciri üretmek veya her probleme tek bir kök neden dayatmak değildir. Amaç, **bulunan nedenin müdahale, tekrar riski, kontrol tasarımı veya karar sonucu açısından yeterince derin olup olmadığını sınamak; yalnız semptomu kapatan çözümleri kök çözüm gibi sunmamaktır.**

## Temel Ayrım

Aşağıdakileri birbirine karıştırma:

- semptom ile neden,
- yakın neden ile sistemik neden,
- tetikleyici olay ile onu mümkün kılan koşullar,
- bir hata noktası ile detection/prevention kontrolünün neden başarısız olduğu,
- düzeltmenin semptomu kaldırması ile tekrar riskini azaltması,
- tek bir neden bulmak ile yeterli nedensel model kurmak.

Bir yakın neden tamamen doğru olabilir ve yine de karar için yetersiz kalabilir.

## Protokol

### 1. İncelenen Sonucu Netleştir

Önce hangi olay veya başarısızlığın açıklanması gerektiğini belirle.

Örneğin:

- sistem neden çöktü,
- kullanıcı neden yanlış sonuç gördü,
- süreç neden tıkandı,
- kontrol neden hatayı yakalamadı,
- önerilen çözüm neden aynı sorunun tekrarını önleyecek.

Belirsiz bir “neden?” sorusunda farklı sonuçları tek zincirde karıştırma.

### 2. Yakın Nedeni Belirle ama Orada Durma

İlk mekanik veya doğrudan nedeni belirle.

Örneğin:

- timeout oluştu,
- yanlış veri okundu,
- görev kapatılmadı,
- kontrol tetiklenmedi,
- bağımlılık güncel değildi.

Bu neden doğruysa kabul et; fakat şu soruyu ayrıca sor:

**“Bu yakın nedenin ortaya çıkmasını ne mümkün kıldı veya bunun kullanıcıya/sonuca kadar ilerlemesini hangi eksik kontrol engelleyemedi?”**

### 3. Nedensel Katmanları Ayır

Gerekli olduğunda nedenleri farklı rollerle sınıflandır:

- **proximate cause:** olayın doğrudan mekanik nedeni,
- **contributing condition:** nedeni mümkün veya daha olası yapan koşul,
- **prevention failure:** olay oluşmadan önce engellemesi gereken kontrolün açığı,
- **detection failure:** olay oluştuktan sonra yakalaması gereken kontrolün açığı,
- **systemic / framing cause:** aynı hata sınıfını tekrar üretebilecek daha üst tasarım, teşvik, varsayım veya karar çerçevesi.

Her problemde bütün sınıfların bulunması gerekmez. Tek bir “root cause” üretmek için gerçek yapıyı zorlamadan çoklu nedenlere izin ver.

### 4. Çift-Neden Testi Uygula

Önemli bir failure analizinde en az iki farklı soruyu ayır:

1. **“Bu olay neden oldu?”**
2. **“Bu olayın oluşmasına veya bu kadar ilerlemesine neden izin verdik; bunu neden daha önce önlemedik veya yakalamadık?”**

İkinci soru çoğu zaman mevcut problem çerçevesinin dışındaki control, incentive, assumption veya architecture kusurunu açar.

İlk neden doğru olduğu için ikinci soruyu atlama.

### 5. Önerilen Düzeltmeyi Nedensel Zincire Bağla

Bir fix, workaround veya plan önerildiğinde hangi nedensel katmanı değiştirdiğini açıkça değerlendir.

Şunları sor:

- Yalnız semptomu mu bastırıyor?
- Yakın nedeni mi ortadan kaldırıyor?
- Tekrarı mümkün kılan koşulu mu azaltıyor?
- Prevention/detection kontrolünü mü güçlendiriyor?
- Aynı failure class başka bir yoldan yine oluşabilir mi?
- Çözüm aynı kusurun daha genel bir biçimini mi yaratıyor?

Bir workaround operasyonel olarak yararlı olabilir. Ancak yalnız semptomu kapatıyorsa onu kök çözüm diye adlandırma.

### 6. Alternatif Nedensel Açıklamaları Koru

Bir olayın birden fazla yeterli veya katkıda bulunan nedeni olabilir.

İlk makul açıklamayı seçip diğerlerini otomatik dışlama. Özellikle şu durumlarda alternatifleri koru:

- kanıt birkaç farklı mekanizmayla uyumluysa,
- birden fazla kontrol aynı anda başarısız olduysa,
- hata yalnız belirli koşullar birleştiğinde oluşuyorsa,
- veri gözlemsel ve nedensellik zayıfsa.

Nedensel güven düzeyini kanıtın ayırt etme gücüyle kalibre et.

### 7. Kök-Neden Dilini Kanıtla Orantıla

“Root cause”, “asıl neden”, “temel sebep” gibi güçlü ifadeleri yalnız daha sığ açıklamalardan ayrıştırılmış ve müdahale açısından yük taşıyan bir neden için kullan.

Kanıt yalnız yakın nedeni destekliyorsa bunu yakın neden olarak adlandır.

Daha üst açıklama çıkarımsa:

- hangi gözlemlerin desteklediğini,
- hangi alternatiflerin açık kaldığını,
- hangi ek kanıtın ayrıştıracağını

gerektiğinde belirt.

### 8. Sonsuz Neden Zincirini Önle

Daha derine gitmek her zaman daha iyi değildir.

Şu durma ölçütünü kullan:

**Daha derine gitmek; önerilen müdahaleyi, recurrence riskini, kontrol tasarımını, sorumluluk sınırını veya karar sonucunu artık maddi biçimde değiştirmiyorsa mevcut nedensel derinlik yeterlidir.**

Ayrıca mevcut görev için eyleme geçirilemez, kanıtlanamaz veya yalnız felsefi bir “nihai neden” arayışına dönüşen zinciri sürdürme.

### 9. Düzeltmeden Sonra Tekrar Riskini Yeniden Değerlendir

Bir neden kapatıldığında şu soruyu sor:

**“Bu değişiklikten sonra aynı failure class başka bir yol üzerinden hâlâ makul biçimde ortaya çıkabilir mi?”**

Cevap evetse zincirin hangi kısmının açık kaldığını belirt.

Tek bir bug fix'in daha geniş failure mode'u kapattığını varsayma.

## R01 ve R03 ile Ayrım

Bu protokol karar-kritik varsayım yönetiminin veya amaç–yöntem doğrulamasının yerine geçmez.

- R01, hangi nedensel varsayımların sonucu değiştirdiğini ve alternatif açıklamaları yönetir.
- R03, önerilen fix veya yöntemin gerçek hedefe ulaşıp ulaşmadığını sınar.
- Bu protokol ise **doğru bir neden bulunduğunda bile nedensel açıklamanın yeterince derin olup olmadığını** ve fix'in hangi nedensel katmanı gerçekten değiştirdiğini sınar.

## Nihai Kontrol

Bir failure veya neden analizi sonucu taşıyorsa şu soruları değerlendir:

1. Bulduğum şey semptom mu, yakın neden mi, daha üst neden mi?
2. Bu yakın neden neden mümkün oldu?
3. Prevention veya detection kontrolü neden engellemedi/yakalamadı?
4. Tek neden varsayarak katkıda bulunan koşulları kaçırıyor muyum?
5. Önerilen fix nedensel zincirin hangi halkasını değiştiriyor?
6. Aynı failure class başka yoldan tekrar edebilir mi?
7. Daha derine gitmek kararı veya müdahaleyi hâlâ maddi biçimde değiştiriyor mu?

## Temel İlke

**Doğru bir yakın neden bulmak, yeterli nedensel açıklamaya ulaşıldığı anlamına gelmez.**

Nedensel analiz, problemi açıklamaktan öte hangi müdahalenin tekrar riskini gerçekten azaltacağını ayırt edecek kadar derin; fakat karar değerini artırmayan sonsuz “neden?” zincirinden kaçınacak kadar sınırlı olmalıdır.
