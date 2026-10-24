# HERMES'i neden araştırıyoruz?

**Tür:** dış hedef araştırması. **Tarih:** 2026-09-07. **Statü:** amaç ve kapsam kaydı; sonuç değil.

## Kullanıcıdan gelen ihtiyaç

SOUL Research, Foundation araştırması ve Development OS'nin kurulması sürerken HERMES ve OpenClaw'ın iki ayrı candidate study olarak incelenmesi önerildi. Öncelik, yeni araştırmanın diğer işlerin durumunu veya sırasını karıştırmamasıdır. İlk hedef HERMES seçildi; kullanıcı kaynak toplayıp aşağıdan yukarı bir araştırma planı geliştirmeyi, kanıt geldikçe yöntemi revize etmeyi ve araştırmayı yürütmeyi yetkilendirdi.

Bu seçim HERMES'in diğer sistemlerden üstün olduğu veya kurulması gerektiği kararı değildir. Kullanıcının büyüklük uyarısı kapsam yönetimi için önemlidir; karşılaştırılabilir kod/dosya ölçümü yapılmadan 'diğer bütün repolardan daha büyük' sonucu araştırma bulgusu sayılmaz.

## Sorulacak esas soru

**HERMES bir ajan sistemini nasıl çalıştırıyor, sürdürüyor ve değiştiriyor; bunun hangi kısmı açıklama, hangi kısmı uygulanmış mekanizma, hangi kısmı geçerli sonuç kanıtı?**

Başlangıç soruları: görev nereden gelir; hangi model/araç/ortamla yürütülür; hangi bilgi korunur veya kaybolur; kim hangi değişikliği yapabilir; başarısızlık nasıl görünür; elde edilen deneyim gelecekteki işi nasıl etkiler? Bunlar hipotez üretme sorularıdır, sistemde bu özelliklerin iyi çözüldüğü varsayımı değildir.

README'nin öğrenme, beceri üretme ve kalıcı bellek iddiaları araştırmayı özellikle ilginç kılıyor. Fakat şu ayrımlar korunacak:

```text
bir şey kaydetmek ≠ doğru şeyi öğrenmek
beceri metnini değiştirmek ≠ gelecekte başarıyı artırmak
ajanı yeniden çağırmak ≠ bağımsız değerlendirme
bir kontrolün varlığı ≠ bütün ilgili etkileri sınırlandırması
kaynak kodu görmek ≠ o kodun bu ortamda çalıştığını doğrulamak
```

Kaynak dayanağı ve ilk sınamalar: [H01/H03/H04/H07/H13](SOURCE-LEDGER.md), [ilk mekanizma notu](notes/02-BACKGROUND-LEARNING.md).

## Araştırma nesnesinin sınırı

Birincil nesne sabitlenmiş `NousResearch/hermes-agent` repository'sidir. İçindeki istemciler, gateway, bellek/beceri sistemi, araçlar, native/runtime bağlantıları, kurulum/güncelleme ve değerlendirme yüzeyleri kapsam adaylarıdır. Bir dış bağımlılığın içeriğine ancak yük taşıyan iddia onu gerektiriyorsa inilir; bütün ekosistemin sınırsız araştırmasına dönüşülmez.

Nous'un bütün model ailesi, tüm üçüncü taraf plugin/skill katalogları ve OpenClaw'ın tamamı bu study'nin varsayılan kapsamı değildir. Resmî sitenin değişebilir belgeleri pinned kaynakla karşılaştırma girdisidir. Dağıtım/binary doğruluğu ayrıca kanıt ister.

## Beklenen kalıcı sonuç

Amaç uzun dosya özetleri yığını değil, kaynağa geri dönülebilen bir açıklamadır: mekanizma notları; doğal alt-sistemler; aralarındaki ilişkiler; açık karşı örnekler; sonra çekirdek sonuç ve SOUL/Development OS açısından aday değer.

Gstack'in araştırmasından alınan ders, sabit sayıda dosyayı özetlemek değil, bir mekanizmayı taşıyan dosyalar arasındaki bağlantıyı korumaktır. Gstack'in on bir ailesi veya sonuç modeli HERMES'e ithal edilmez. Kaynak: `../gstack/METHOD.md` ve `../gstack/META.md`, bu tur tam okunmuştur.

## Diğer işlerden ayrılık

Bu paketin durumu kendisine aittir. Foundation'ın kabul/sonraki-iş durumu, context köprüsündeki Codex görevleri ve Development OS/Production repository'leri bu çalışmayla değişmez. Bir bulgu değerli çıkarsa kendi epistemik statüsüyle sunulur; mevcut geliştirme işine sessiz bağımlılık eklenmez. OpenClaw için ikinci aktif paket bu tur açılmaz.
