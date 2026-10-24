# Taslak 09 — Dosya mı hafıza, bilgi mi?

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../09-dosya-mi-hafiza-bilgi-mi.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1708
- Üst sınır: 2800

---

Memory sistemi kurarken “dosyayı yöneteceğiz” demek bir süre sonra bana çok kaba gelmeye başladı.

Çünkü dosya ile bilgi aynı şey değil.

bilgi.md diye bir dosya yarattım.

İçine:
“Top yuvarlaktır. Saha yeşildir.”
yazdım.

Sonra dosyanın altına:
“Sporcu forması kırmızıdır.”
ekledim.

Teknik olarak file update yaptım.

Ama bilgi açısından mevcut iki cümleyi değiştirmedim; yeni bilgi ekledim.

Sonra “kırmızıdır”ı “mavidir” yaptım.

Yine file update.

Ama bu sefer yeni bilgi eklemedim. Eski bir bilgiyi geçersiz kılıp yerine başka bir bilgi koydum.

Filesystem açısından iki işlem birbirine çok benziyor.
Agentic memory açısından aynı olay değiller.

Çünkü bir bilginin değişmesi başka kararları da etkileyebilir.

Dün “X bağımlılığı değişmeyecek” diye karar verdik. Bugün bu bilgi değişti. Yalnız o satırı update etmek yetmez; o bilgiyle açılmış task’lar, verilmiş kararlar, yazılmış dokümanlar var mı diye bakmak gerekebilir.

Bu yüzden memory’yi yalnız CRUD problemi gibi düşünmek bana eksik geliyor.

Create neyi create ediyor?
Dosyayı mı, bilgiyi mi?

Update neyi değiştiriyor?
Taşıyıcıyı mı, gerçeğe ilişkin kabulümüzü mü?

Delete gerçekten unutmak mı, yoksa yalnız current view’dan kaldırmak mı?

Bir de dosyanın varlığı ayrı bilgi. “Bu konuda şu dosyada kayıt var” bilgisi index’te tutulabilir. Sonra agent’ın o index’i bulması gerekir.

Derken memory storage olmaktan çıkıp lifecycle problemine dönüşüyor:

oluştur → sakla → adresle → bul → oku → kullan → düzelt → supersede et → etkisini takip et → yeniden bul.

Vector DB, markdown dosyası, database… bunlar önemli.

Ama bunlar taşıyıcı.

Agentic sistemde asıl soru bence şu:

Biz dosya mı yönetiyoruz, yoksa bilginin zaman içindeki hayatını mı?
