# Üçüncü video — SOUL ve Development OS için aday öğretiler

**2026-09-16.** Kaynak incelemesine dayalı ilk ilgi değerlendirmesi; güncel Foundation veya Development OS mimari/implementasyon denetimi değildir. Kaynağın açıklaması ve karşı kontroller [RESEARCH](RESEARCH.md), kimlikler [SOURCE](SOURCE.md) içindedir. Aşağıdaki aday çıkarımlar, kaynakta uygulanmış bir SOUL tasarımı gibi okunmamalıdır.

## 1. Geçmişi korumak ile bugünü yönetmek

Videonun aynı issue için geçmişte onay yokken sonradan onay bulunması örneği, geçmiş doğru bilginin bugünkü yanlış eyleme dayanak olabileceğini gösteren bir açıklamadır. SOUL açısından aday soru: bir kayıt yalnız içeriğiyle mi, yoksa hangi işe, zamana, kaynağa ve kullanım sınırına ait olduğuyla mı taşınacak? [V02 08:27–14:02; 21:36–22:49]

**Analitik örnek:** önceki inceleme işin onaysız olduğunu kaydeder. Daha sonra geçerli onay gelir. Eski kaydı silmek geçmişte neden durulduğunu açıklama imkânını kaybettirir; eski kaydı güncel kabul etmek de yeni işi yanlış durdurur. Tarihsel olay ve güncel karar dayanağı ayrı kalabilir. Bunun için belirli bir grafik veri tabanı veya zorunlu veri modeli seçilmiş değildir.

Yakın konuşmada düzeltilen kanal→video sahipliği de anlaşılır bir hatırlatma sağlar: eski araştırma konumu tarihsel olarak doğru kalırken yeni çalışmanın sahibi farklı bir yoldan bulunur. Bu benzetme bir bellek algoritmasının başarı deneyi değildir; önceki repo onarımını yeniden açma veya bütün proje durumunu bu dört hafıza kutusuna dönüştürme gerekçesi de değildir.

## 2. Araştırma birikimi doğrudan talimata dönüşmemeli

Kaynak oturumların özetlere, daha genel bilgiye ve yöntemlere dönüşebileceğini anlatır. Bizim aday çıkarımımız, bu geçişlerde içeriğin epistemik statüsünün korunmasıdır. Bir çalışmada önerilen hipotezin sonraki özetlerde doğrulanmış bulguya, bir örneğin bütün işler için kurala dönüşmesi yanlış öğrenme üretebilir. [V02 24:06–24:55; analitik sınır]

SOUL araştırma kütüphanesi bir aktöre açıklama, bir başkasına karşı örnek, başka bir işe de koşullu yöntem sağlayabilir. Bunların hepsinin aynı prompt'a veya aynı kalıcı tercih listesine girmesi gerekmez. Uygun mekanizma, işteki bilgi ihtiyacına göre seçilebilir; daha fazla saklamak tek başına daha iyi kullanım değildir.

## 3. Yöntem hafızası, bildiğimiz kuralı nasıl uyguladığımızı görünür kılıyor

Onay gerektiğini söylemek ile onayın hangi işe ve öneriye bağlı olduğunu doğrulayan bir çalışma sırası farklıdır. Development OS için bunun aday değeri, yalnız önceki sonucun değil, nasıl kontrol edildiğinin ve hangi koşullarda kullanılabileceğinin de devredilmesidir. [V02 14:02–16:48]

**Analitik örnek:** eski bir işte uygulanan prosedür doğrudan kod yazmaya izin verirken yeni işte inceleme ve öneri istenmiş olabilir. Eski prosedürün başarılı olmuş olması yeni yetkiyi yaratmaz. Gerekli olan her işi daha ağır bir prosedüre bağlamak değil, bu işteki geçerli kapsamı ve yöntemi ayırmaktır.

Araç şeması, prosedür metni ve dışarıda uygulanan kontrol aynı güvence değildir. Geçerli biçimde yazılmış bir onay ID'sinin hangi gerçek koşulu karşıladığı ayrıca önemlidir. Bu çalışma herhangi bir mevcut DevOS kontrolünün açık verdiğini saptamamıştır.

## 4. Unutmanın nesnesi seçilmeli

Videonun unutma bölümü, bütün geçmişi yok etmekten çok artık yardımcı olmayan içeriğin önceliğini azaltmayı, özetlemeyi, değiştirmeyi ve bakımını yapmayı anlatıyor. SOUL için aday soru yalnız neyi hatırlayalım değil, **neyi saklayıp bugünkü karara hükmettirmeyelim?** [V02 22:49–25:27]

Eski politika tarih olarak tutulabilir; artık geçerli olmayan yöntem aktif seçimden çıkarılabilir; kapsamlı bir olay kaydı günlük kullanım için özetlenebilir. Bunlar aynı işlem değildir. Kritik bir kanıtı fiziksel olarak silmekle her prompt'a eklememek arasında büyük fark vardır. Veri silme veya unutma hakkının bütün kopyalara uygulanmasına dair bir politika bu videodan türetilmedi.

## 5. Dört tür, zorunlu dört bileşen değil

Kaynağın çalışma/olay/bilgi/yöntem ayrımı hangi sorunun cevaplanacağını açıklamaya yarıyor. Aynı dosya farklı roller taşıyabilir; tek depo yeterli olabilir; bazı görevler yalnız mevcut bağlam ve kesin kaynak okumasıyla yürüyebilir. D01'in daha geniş working-memory tanımı da terimlerin mekanizma ve ürün sınırlarıyla birebir örtüşmediğini gösteriyor. [RESEARCH §§3,7]

Bu nedenle SOUL için dört servis, dört agent veya dört veri tabanı seçilmedi. Foundation alanlarına ilişki yalnız provisional retrieval hint'tir. İşin anlamını öğrenmeden bir hafıza ürünü seçme veya mevcut repo klasörlerini bu kategoriye göre yeniden düzenleme kararı yoktur.

## 6. Daha sonra hangi sorularla kullanılır?

Bir uygulama kararı doğarsa, önce belirli iş ve tüketici için şu ayrımlar önem kazanabilir: saklanan kayıt ile gerçekten sunulan içerik; kayıt zamanı ile geçerlilik zamanı; geçmiş onay ile güncel yetki; prosedürün yüklenmesi ile etkili uygulanması; otomatik özet ile doğrulanmış bilgi. Şimdiki sonuç bir kriter kümesidir, uygulanmış bir sistem değildir.

Ölçülecek şey yalnız retrieval hit veya hatırlanan kelime sayısı olmamalı: seçilmiş işte doğru güncel bilgiyi kullanmak, gerektiğinde kaynağa dönmek, yanlış onayı reddetmek ve meşru işi gereksiz engellememek gibi sonuçlar ayrıca değerlendirilebilir. Bunlar olası gelecek değerlendirme sorularıdır; bu tur test edilmedi ve otomatik çalışma kuyruğuna alınmadı.

Kaynak ilk harness ve sandbox anlatılarına kendisi bağlanıyor; bunu kaydettik. İlk videonun açık işleri aynı dosyada kaldı. İkinci videoya kullanıcının verdiği uygunluk araştırma değerlendirmesidir. Burada ayrıca tamamlanmış üç-video sentezi veya ürün entegrasyonu iddia edilmiyor. Sonraki soruyu [collection STATE](../../STATE.md) ve kullanıcının değerlendirmesi belirler.
