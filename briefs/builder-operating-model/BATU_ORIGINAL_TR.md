# Batu's message, Turkish original (2026-10-01)

Recorded verbatim (plan Section 0.6, item 2). The English rendering is in `BRIEF.md`, Section 2.

---

Kurucunun çalışma düzeni: önce tasarla, sına ve kur; sonra devam et

Durum. Kurulum planı DevOS'un çalışma düzenini ayrıntılı tasarlıyor, ama DevOS'u kuracak olan senin çalışma düzenini hiç tasarlamıyor. Plan seni "planı uygulayan bir oturum" gibi düşünmüş. Oysa sen de bir çalışma sistemisin; bu işi kaliteli yapabilmek için kendi düzenine ihtiyacın var. Bu eksikliğin sonuçlarını ilk günlerde yaşadık:

1. Her adımdan sonra durup beni bekledin.
2. Defterin ve işin `main`'e alınmadan kendi dalında kaldı.
3. Hazırlık listesine ulaşamadın; ben de sohbetler arasında mesaj taşımak zorunda kaldım.
4. Bana teknik onay sorusu getirdin.
5. Çalışma kuralları bütün olarak tasarlanmadı; ihtiyaç çıktıkça parça parça eklendi (K10, K11).

İstediğim. C00'ın ağır işine devam etmeden önce, kurulum dönemi için kendi çalışma düzenini DevOS'a uyguladığın standartla tasarla, sına ve kur. Bu bir yama değil; C00'ın bir parçası. Azla yetinme. Ama gereksiz karmaşıklık da ekleme: her mekanizma hangi sorunu çözdüğünü ve hangi varsayıma dayandığını yazsın (plan 6.12).

Kesin beklentilerim

1. Ben mesaj taşıyıcısı değilim. Sohbetler ya da oturumlar arasında bilgi taşımam gerekmemeli. Bağımsız inceleme oturumlarının sonuçları sana benim aracılığımla değil, depo üzerinden ulaşmalı (dosya, PR ya da kayıt).
2. Bana yalnız bana ait kararlar gelir: amaç, kapsam, maliyet, hesaplarımı ve diğer işlerimi etkileyen seçimler ve kabul. Teknik kararları sen verirsin. Teknik değişikliklerin onayı bana gelmez: kural, rol, veritabanı şeması ve güvenlik ayarı gibi yüksek etkili değişikliklerin teknik onayını bağımsız denetim verir. Planın bu konudaki maddesini buna göre değiştir.
3. Her adımda beni beklemezsin. Benim yapmam gereken işleri bir araya toplayıp tek seferde ve adım adım istersin.
4. "Bitti" demek kanıta bağlıdır. Benim onayım teknik doğruluğun kanıtı değildir.
5. Durumu görmek için kimseye sormam gerekmemeli. Türkçe, kısa ve her zaman güncel bir durum sayfası olsun: hangi aşamadasın, en son ne yapıldı, sırada ne var, benden ne bekleniyor.

Tasarımın cevaplaması gereken sorular

* A. Süreklilik: Ben yazmadan nasıl ilerleyeceksin? `/goal` bir araç, ama her aşamada benim bir komut yazmama bağımlı kalmamalısın. Şunları değerlendir:
   * `/goal`'u kendin başlatabiliyor musun? Bunu C01'i beklemeden şimdi sına.
   * Kurulum ortamında zamanlanmış bir routine, defterden devam eden bir kurucu oturumu başlatabilir mi?
   * Hesabımda açıksa Claude Code Projects işe yarar mı?
   * Kullanım sınırı dolduğunda iş kendiliğinden devam edebilir mi?
Seçtiğin yolun gerekçesini, bedelini ve sınırını yaz.
* B. Hafıza ve tek doğru kaynak:
   * Yeni bir oturum hangi dosyadan, hangi sırayla başlar?
   * `main` ile çalışma dalı arasındaki fark nasıl kapanır?
   * Defter büyüdükçe dağınıklaşması nasıl önlenir?
   * Bağlam sıkıştırmasında bilgi kaybına karşı ne yapılır?
   * `/goal` değerlendiricisinin yalnız konuşmayı görmesi nasıl telafi edilir?
* C. İş takibi: Aşamalar nasıl iş listesine dönüşür, öncelik nasıl belirlenir, "tamam" ne demektir? Kabul koşulları sonuç görülmeden yazılır; her iş kanıtla kapanır.
* D. Karar yönlendirmesi: Hangi karar türünü kim verir: sen, bağımsız denetim ya da ben? Bana gelen kararın biçimi Ek E'ye uyar.
* E. Bağımsızlık ve kalite:
   * Senin işini kim, ne zaman, nasıl inceler?
   * İnceleme oturumları nasıl başlar; sonuçları bana taşıtmadan sana nasıl ulaşır?
   * Her aşamanın kapanışını, o işi yapmamış bir oturum denetler.
* F. Kendi düşünme disiplinin: Ek D'deki dokuz disiplini kurulum döneminde kendine nasıl uyguluyorsun? Çerçeve denetimini kendi çalışma düzenine de uygula.
* G. Kullanım ve kapasite: Max kullanım hakkımı benimle paylaşıyorsun. Ağır işleri nasıl zamanlıyorsun, kullanımı nasıl izliyorsun, beni ne zaman bilgilendiriyorsun?
* H. Güvenlik: Bu oturumda hesabımdaki connector'lar (e-posta, takvim, dosya) yüklü olabilir. Bunlara karşı yalnız talimat yeterli değil. Kurulum döneminde hangi teknik engeli koyacağını yaz.
* I. Hata halleri: Oturumun düşmesi, dalların birbirinden ayrışması, defterde çatışma, yanlış bir "hedef tamam" kararı, benim uzun süre cevap vermemem, kullanım sınırının dolması.
* J. Numaralandırma: Planda K ile başlayan numaralar benim kararlarım (K1–K9). Kendi plan değişikliklerin için ayrı bir önek kullan. K10 ve K11'i buna göre yeniden numaralandır ve hangi maddelerin benim kararım olduğunu açıkça ayır.

Süreç

1. Tasarla. Dayandığın öncülleri tek tek yaz.
2. Karşı tasarım çıkart. Senin tasarımını görmeyen, yalnız amacı, kısıtları ve benim beklentilerimi bilen bağımsız bir oturum kendi tasarımını çıkarsın; ikisini karşılaştır. Bu oturumu başlatmak için benden bir şey gerekiyorsa tek seferde ve adım adım iste. Sonucunu bana taşıtma.
3. Kur ve sına. En az şunları göster:
   * Yeni bir oturum yalnız `main`'den yola çıkarak doğru yerden devam edebiliyor.
   * Bir inceleme oturumunun sonucu bana taşıtılmadan sana ulaşıyor.
   * İş, benim komut yazmam gerekmeden sürebiliyor; sürmüyorsa bunun sınırı açıkça yazılı.
4. Bana bir kere sun: Türkçe ve kısa. Benim için ne değişiyor, benden ne bekleniyor, varsa hangi noktalarda kararım gerekiyor? Bu bir onay sunumu değil; bilgilendirme. Yalnız benim kararlarımı sor.
5. Planı güncelle. Planı ve Ek F'yi kayıtlı bir plan değişikliğiyle güncelle, deftere yaz ve C00'a bu düzenle devam et.

Teslim edilecekler:

* `devos/plan/` altında kurucu çalışma düzeni belgesi (İngilizce).
* Plan değişikliği kayıtları.
* Türkçe durum sayfası.
* Güncel defter.
