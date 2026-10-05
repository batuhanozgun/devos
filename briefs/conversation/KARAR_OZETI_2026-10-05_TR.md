# Karar özeti: kurulumun nasıl yürüyeceği

**Durum:** Batu onayladı, 5 Ekim 2026 (konuşma oturumu `session_01Q32nLatKbtDDY1zSVQZiKX`): "Onaylıyorum, 34, 35 ve 36 da tamam". Bu metin onaylanan sürümdür (v2); sonraki düzeltmeler en alttaki "Ek" bölümündedir. İngilizce karşılığı: `briefs/conversation/DECISION_SUMMARY_2026-10-05_EN.md`. Karar kaydı: `plan/decisions/D-010.md`.

Kaynak: Batu ile konuşma oturumu, 5 Ekim 2026, 10:36Z'den itibaren. v1, konuşmayı görmemiş üç taze göze (Batu'nun sözlerine sadakat, kanıt, plana uyum) kontrol ettirildi; bu sürüm onların bulgularıyla düzeltildi.
Etiketler: (B) Batu söyledi ya da onayladı · (K) kurucunun teknik kararı, kanıta dayalı · (B+K) ihtiyaç Batu'dan, ayrıntı kurucudan · (BK) Batu'nun kararı gerekiyor, henüz verilmedi.

## A. Teşhis
1. (K) Plan, ne yapılacağını (C00–C12) ve DevOS'un kendi çalışma düzenini ayrıntılı yazıyordu. Kurulum işi için sıralama ilkesi, defter ve aşama kapanışı vardı; ama süreklilik, devir ve oturum başlatma yoktu ("Kurucu Claude Code oturumu: Belgenin tamamını ve bütün ekleri okur, C00'dan başlar"; inceleme oturumlarını Batu'nun adım adım yardımıyla açmak). Kurucu bu boşluğu kendi tasarladığı oturum zinciriyle doldurdu; zincir platform sınırlarına çarptıkça mekanizma ekledi ve planın asıl işi askıya alındı.
2. (B) Batu kararları kurucuya bıraktı; kurucu işi büyüttükçe büyüttü. Büyüme sorun değil; sorun konudan sapmak. Önemli olan, açılan dal büyüdükten sonra onu kapatıp devam edebilmek. Asıl kötü olan, açılan dalın ana iş hattından uzaklaştırması.

## B. Batu'nun ilkeleri (çalışma oturumu ve her alt ajan bunlara uyar)
3. (B) "Kendi kendine ilerlemek" = plana sadık kalarak son adıma kadar gelip DevOS'u kurmak; çalışırken "şu dosyaya yazayım mı, bunu okuyabilir miyim" diye sormadan çalışmak.
4. (B) Kurulumun iki temeli: (a) işi planlanan adımlara göre ilerletmek; (b) plandan kopmadan, drift yaşamadan, nerede kaldığını unutmadan ilerlemek.
5. (B) Batu teknik karar vermez. Teknik kararları kurucu, araştırmaya ve kanıta dayanarak verir. Batu'nun sözleri teknik şartname değildir; örneğin "ayrı oturum" ya da "o işi yapmamış bir oturum" derken teknik olarak ayrı bir oturumu kastetmedi.
6. (B) Akıl yürütme ilkesi: anomaliler (ör. oturumun ölmesi; "olursa yapacak bir şey yok") standart akışla karıştırılmaz; ikisini karıştırmak kararları baltalar. Standart akışta düzenli yaşanacaklar (ör. kullanım limiti) ise standart akışın parçası olarak tasarlanır.
7. (B) Akıl yürütme ilkesi: her yan dal kapanır ve ana iş hattına dönülür (madde 2).
8. (B) Batu ile iletişim: kısa cevaplar; adım adım birlikte; konuyu dağıtmamak; soru sorarak konuyu dağıtmamak.
9. (B) Önce çalışma oturumunun nasıl çalışacağı belirlenir ("kurulumun kurulması"), sonra kurulur; C00'a bundan önce dönülmez. "Kurmak"tan anlaşılan konuştukça netleşebilir; bu özet o yüzden değişebilir.

## C. Yapı
10. (K) Kurulum, süreklilik ve bağlayıcı olmayan kontroller için tek bir çalışma oturumunda yürür; iş alt ajanlara ve workflow'lara dağıtılır. Her adımda yeni oturum açan zincir bırakılır. Gerekçe (kanıt): Accept edits'teki bir oturum yeni oturum açamıyor ve hatırlatma kuramıyor (5 Ekim'de gözlendi, platform belgesi doğruluyor); düşünme bağımsızlığı taze bağlamlı alt ajanla sağlanıyor (plan ve kütüphane aynı şeyi söylüyor); "nerede kaldım" bilgisini oturum değil kayıt (ana dal, plan, defter) taşıyor.
11. (K) Sınırı: tek oturum C03'e kadar tam geçerli. Planın gerektirdiği ayrı oturum ya da ortamlar şunlar için kalır: geçişin bir kerelik bağımsız incelemesi (madde 29), C01'de gözlenen oturum ve routine'ler, C03'ten itibaren denetim ortamı, C04'ün gizli arama soru seti, sınavlar (C05, C07, C10). Bunları başlatma ihtiyacı geldiğinde Batu'ya tek ve dar bir soru olarak gelir (ilk kez C01'de).
12. (B) Çalışma oturumunu Batu uygulamadan bir kez açar ve kurucunun hazırladığı ilk mesajı yapıştırır. Açılışta model, effort ve ultracode ayarları kontrol edilir. [Varsayım: uygulamadan açılan oturumda bu ayarlar görünür olacak; kurucunun açtığı oturumlarda ultracode ayarı hiç görünmüyordu, bu yokluğu değil görünmezliği gösterir. Depo ayarı effort'u xhigh'a sabitliyor.]
13. (B) Batu doğrudan çalışma oturumuyla konuşur; bu konuşma oturumu devirden sonra kapanır. Batu'ya ait kararlar ve işler yine tek GitHub issue'sunda toplanır, durum yine DURUM.md'de güncel tutulur.
14. (K) Her aşama /goal hedefiyle ve PC-01'in üç duruş koşuluyla yürür (aşama bitti; Batu'nun kararı ya da işlemi gerekiyor; aşılamayan engel). PC-01 değişmez.

## D. Roller (temel alındı, henüz doğru kabul edilmedi)
15. (B+K) Kurulum için önceden tanımlı roller olacak (fikir ve içerik Batu'nun: yetki, akıl yürütme prosedürü, zamanlama, yasak). Roller planın adımlarından çıkarıldı.
16. (K) Ana oturum = yürütücü (rol değil): planı kendisi okur, sıradaki adımı plan sırasıyla seçer, işi böler, alt ajanlara görev yazar, ana dala yazan tek odur, yan dalı açar ve kapatır, Batu'ya yalnız onun kararlarını getirir.
17. (K) Alt ajan rolleri: Üretici (yazar), Araştırmacı (okur, karar vermez), Sınayıcı (platformu gözler, önceden yazılmış testleri çalıştırır), Test tasarımcısı (kabul koşullarını ve testleri sonuçtan önce yazar), Denetçi (taze göz; değerlendirir, düzeltmez; yan dal açılırken, kapanırken ve aşama sonunda "plandan koptuk mu?" diye de bakar), Karşı tasarımcı (planı görmeden tasarlar; yalnız C00 adım 5; planı görmemesi araç kısıtıyla sağlanır, sağlanamazsa bağımsızlık düzeyi düşük olarak yazılır).
18. (K) Rol dosyasında tanımlananlar: yetki (araç listesi, model, effort), prosedür (rol metni), yasaklar (araç listesi; guard'ın genel kuralları), sınır (adım sayısı). Zamanlamayı yürütücü belirler; workflow yardımcıdır.
19. (K) Geçişte yalnız C00 ve C01'in gerektirdiği roller yazılır (Üretici, Araştırmacı, Sınayıcı, Denetçi, Karşı tasarımcı); Test tasarımcısı C02'de. Bunlar kurucunun yardımcılarıdır, Ek A'nın DevOS rolleri değildir; C05'te DevOS'un rol kümesi kurulurken kaldırılır ya da devredilir.

## E. Çalışma düzeni (harness)
20. (B+K) İki katman: (a) planı işletme, mekanik: iş listesi (kabul koşulları önceden yazılı), nerede kaldım, sıradaki adım plan sırasıyla, ana dala alma, deftere yazma, özetlemeden sonra plan ve defteri yeniden okutan kanca, duruş koşulları; (b) üst seviye akıl yürütme, adımın içinde: işi bölmek, rolü seçmek, sonucu yorumlamak, teknik kararı vermek, plandaki boşluğu fark etmek, takılınca çerçeveyi sorgulamak.
21. (K) Sınır: akıl yürütme yan dal önerebilir; dalın gerekçesi o anki plan adımına bağlıdır, dönüş noktası yazılıdır, sınırı vardır; dal kapanmadan sonraki plan adımına geçilmez.
22. (K) Planı değiştirmenin yolu planın kendi 14. bölümüdür: eski metin, yeni metin, gerekçe, etkilenen aşamalar; kabul koşulu sonuç görüldükten sonra gevşetilmez; [Batu kararı] etiketli metin yalnız Batu'nun kararıyla değişir.
23. (K) Akıl yürütme katmanı: Batu'nun ilkeleri (B bölümü) + planın Ek D'sindeki düşünme disiplinleri ve oturum açılış/kapanış kuralları + Ek G'nin uygun kısımları (G4, G8, G10). Bunlar DevOS için yazıldı; kurulum için uyarlanarak ödünç alınır, C05'in kurulumu yerine geçmez. Ek D'nin "uzun oturumun özetlemesine güvenme, devirle geç" kuralı yerine bu özetin kararı geçerlidir (tek oturum + yeniden okuma kancası).

## F. Geçiş (kurulumun kurulması)
24. (B) Bu oturum (kurucu) ortamı hazırlar ve dosyaları yazar, sonra devreder. Gerekçe (Batu): tek bir oturumun akıl yürütmesi bunların hepsini aynı anda taşıyamaz; özeti yeni bir oturuma vermek birçok inceliği kaybettirir. Bu yüzden iş tek turda değil, alt ajanlarla yapılır.
25. (K) İnceliği korumak için: bu özet tek kaynak olarak ana dala yazılır; alt ajanların görevlerini konuşmanın tamamını bilen yürütücü (bu oturum) yazar ve her çıktıyı konuşmaya karşı da kontrol eder.
26. (K) Adımlar: 0 bu karar özeti (Batu niyetini onaylar) → 1 envanter: alt ajanlar repoyu tarar, yürütücü her şey için "kalsın, kalksın, değişsin" der → 2 yeni dosyalar (Üretici alt ajanlar): kısa kural metni (yeni CLAUDE.md), 5 rol dosyası, yeniden okuma kancası, guard değişikliği, plan değişikliği kaydı → 3 her dosyaya Denetçi kontrolü ("kararda olmayan bir şey eklenmiş mi?") → 4 bütün geçişe bir kez bağımsız inceleme → 5 ana dala alma ve devir (ilk mesaj; çalışma oturumu C00'dan başlar).
27. (K) Ana dala alma sırası: 0 ve 1'in çıktıları kendi başına alınır. 2 ve 3'ün çıktıları (kural metni, .claude/ dosyaları, guard) yüksek etkilidir; yalnız 4'ün onayından sonra, birlikte alınır.
28. (K) Eski düzen yanında bırakılmaz; envanter neyin kalkacağına karar verir. Kesin kalanlar: plan (bağlayıcı), guard'ın özü (yazılı gerekçeli izin/ret; connector yasakları; .claude/ dosyalarının oturum içinde düzenlenmesine karşı koruma), birleştirme kapısı (koşulu değişir: ayrı oturum kararı yerine Denetçi kararı, bağımsızlık düzeyiyle; bu D-008'de sana söylenen güvenceyi korur), defter geçmişi, kanıtlar.
29. (K) Neden bir kez ayrı inceleme: geçiş, eski kurallarla onaylanmalı; yoksa yeni düzen kendi kendini onaylamış olur. Eski kural, yüksek etkili değişikliklere ayrı bir inceleme oturumunun kararını şart koşuyor. Bunun için Batu'nun kararı gerekiyor (madde 34).
30. (K) Açık uçların kapanışı: W-C00-01, 02 ve 04 yeniden yapılmaz, kabule sunulur. W-C00-05 (eski çalışma düzeni) ve W-C00-12 (yeniden tasarım ve alt kalemleri) gerekçesiyle kayda geçen bir iptal/kapanışla kapanır (kabul koşulu gevşetilmez); böylece C00 askısı kalkar. PR #86 kapanır. D-009 geri çekilir; oturum başlatma ihtiyacı C01'de daha dar bir soru olarak geri gelir (madde 11).

## G. Plan değişiklikleri (14. bölüme göre kayda geçecek)
31. Plan 9. bölümdeki kurucu çalışma düzeni (PC-04 bloğu) ve ona bağlı yerler (başlıktaki değişiklik listesi, 11.1, Ek F'nin çalışma düzeni paragrafı) yeni düzenle değiştirilir. PC-04'ün Batu'ya ait kısmı (gereksinim ve 1–5 beklentileri) korunur; bir kerelik istisna: çalışma oturumunu Batu açar ve ilk mesajı yapıştırır (madde 12).
32. Kurulumda (C03'e kadar) bağlayıcı onay ve aşama kapanışı: "ayrı inceleme oturumu" yerine Denetçi alt ajanı; her kararda bağımsızlık düzeyi açıkça yazılır ("aynı oturum, taze bağlam"). Bu PC-05'i ve ona bağlı metinleri değiştirir (plan 419, 573, 780, 786, 788; Ek A 373). C03'ten sonrası planda yazdığı gibi kalır (denetim ortamı).
33. "Ayrı oturum" geçen yerlerden yalnız düşünme bağımsızlığı için olanlar değişir (çeviri sadakati, plan incelemesi, karşı tasarım gibi). Gizlilik ya da yetki ayrılığı için olanlar değişmez (C04 gizli soru seti, sınavlar, denetim ortamı).

## H. Batu'nun kararı gerekenler (henüz verilmedi)
34. (BK) Geçişin bir kerelik bağımsız incelemesi için bu konuşma oturumunun yaklaşık 1 dakika Auto'ya alınması. Bu, D-008'den ("sistem otomatik modda çalışmaz") tek seferlik bir istisna; inceleme oturumu açılınca geri Accept edits'e alınır. Başka temiz yol yok: birleştirme kapısı yalnız kurucunun açtığı bir inceleme oturumunun kararını tanıyor.
35. (BK) G bölümündeki plan değişiklikleri; özellikle PC-04 ve PC-05'in Batu'ya ait kısımlarına dokunanlar (madde 31 ve 32).
36. (BK) Maliyet: workflow'lar ve paralel alt ajanlar normal çalışmadan daha fazla kullanım harcar; haftalık limit (seninle ortak) daha hızlı dolabilir.

## I. Varsayımlar ve ilk sınananlar (standart akışın parçası)
37. [Varsayım] Tek oturum özetlemeyle günlerce sürebilir ve yeniden okuma kancasıyla plandan kopmaz. Opus 5.5'te özetleme kaybı ölçülmedi; plan bunu C01'in ilk satırında ölçmeyi öngörüyor.
38. Kullanım limiti: rutin bir durum. Önce platformun belgelenmiş otomatik devam ayarı denenir. Çalışmazsa, limit sıfırlandıktan sonra işi sürdürmek için Batu'nun bir mesajı gerekir; bu bilinen bir maliyet olarak kayda geçer.
39. İlk plan işi C00 adım 0 (çeviri): hem plan işi hem düzenin ilk sınaması; ayrı bir "düzen testi" dalı açılmaz.

## Ek: onaydan sonraki düzeltmeler (5 Ekim 2026)
E1. (B) PC-01 Batu'nun kararı değil. Batu: "Ben '/goal' kararını vermedim ... PC01 kararı ne ise (benim o karardan bile haberim yok, ben koymadım o kararı) uymak zorunda değilsin." Kayıtlar da bunu destekliyor: 1 Ekim'de "K10 ve K11'i ... yeniden numaralandır" diyerek onları kurucunun plan değişikliği saymış ve "`/goal` bir araç, ama her aşamada benim bir komut yazmama bağımlı kalmamalısın" demişti (`briefs/builder-operating-model/BATU_ORIGINAL_TR.md`). Madde 14 bu nedenle değişir.
E2. (K, Batu "Üç madde mantıklı ... İtirazım yok" dedi) Madde 14'ün yerine: bütün kurulum için tek bir `/goal`; Batu onu çalışma oturumunu açarken ilk mesaj olarak bir kez yapıştırır. Oturumu ileri iten, arka planda biten alt ajan ve workflow'ların kendiliğinden başlattığı yeni turlar ve iş bitmeden boşta kalınca `/goal`'un yeniden dürtmesidir. Aşama geçişlerinde durulmaz. Hedef metni, Batu'yu beklemeyi, kullanım limitini ve engeli geçici "henüz değil" durumu olarak tanımlar.
E3. (B) Standart akışta Batu'nun yazdığı yerler: (1) başta bir kez ilk mesaj; (2) kendi kararlarının cevabı (çalışma oturumuna yazar); (3) 5 saatlik ya da haftalık kullanım limiti dolduğunda, sıfırlanmadan sonra bir "devam" mesajı (bulut oturumları limit sonrası kendiliğinden devam etmiyor; otomatik devam ayarı yalnız etkileşimli oturumlarda çalışıyor). Madde 38'deki bilinen maliyet budur. Bunu kaldırmanın gözlenmiş tek yolu çalışma oturumunu Auto'da çalıştırmak; bu D-008'i değiştirir ve şimdilik seçilmedi.
