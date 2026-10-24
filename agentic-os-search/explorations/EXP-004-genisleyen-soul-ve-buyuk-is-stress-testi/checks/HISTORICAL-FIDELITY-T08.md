# EXP-004 — 21 Eylül 2026 kaynak sadakati düzeltmesi

**Durum:** Önceki tam-kaynak iddiası sınırlandı; özgün assistant yanıtlarının eksiksiz yeniden aktarımı BU TUR YAPILMADI. Bu kayıt yeni bir kaynak transkripti değildir.

## Gözlenen uyuşmazlık

Önceki arşivleme turunda assistant S001–S013 dosyalarını görünür substantive cevapların kaynak aktarımı olarak sundu. Oysa görünür conversation'daki cevaplar ile yazılan metinler karşılaştırıldığında cümle/listelerin kısaltıldığı, bazı kısımların yeniden ifade edildiği ve yer yer başka mesaj/aşamadan yorum eklendiği görülüyor. Bu yalnız boşluk veya arayüz kod-bloku kimliği farkı değildir.

Somut yeniden okuma: `sources/conversation/assistant/S013.md`, blob `0160921f0fb5999165d0ad6543675e01581c331f`. Dosyada test açıklamaları yoğunlaştırılmıştır; sonundaki 'U014 bu yazma yetkisini verdi' ifadesi, özgün S013'ten sonraki kullanıcı mesajına dayanan arşivleme yorumudur. Bu ifade özgün S013'ün kaynak sözü değildir.

S001 de bu konuşmanın ilk cevabının eksiksiz kopyası değildir; sonraki toparlamayla ortaklaştırılmış/kısaltılmış bölümler taşır. Önceki yazma işlemlerinin görünür gövdeleri diğer S dosyalarında da yoğunlaştırmayı gösterir. Bu tur tüm yanıtların satır-satır tam karşılaştırması veya yeniden yazımı yapılmadı.

## Doğru okuma statüsü

- U001–U014: modele görünür kullanıcı mesajlarının metin aktarımı; platform export'u değil.
- S001–S013: ilgili assistant mesajlarına adreslenmiş yoğunlaştırılmış/yeniden ifade edilmiş arşiv görünümleri. Özgün cevapların eksiksiz kelimesi kelimesine kaydı değildir.
- 27 sayısı: kesimin referans verdiği konuşma mesajı sayısı. 27 mesajın bütün gövdelerinin eksiksiz korunduğunu kanıtlamaz.
- EXP-001→004 için 122 toplamı da tam-metne-sadakat kanıtı değildir. Önceki üç EXP bu tur yeniden sadakat denetiminden geçirilmedi.
- SOURCE-MANIFEST hash'leri yayımlanmış dosyaların kimliğidir; conversation'a sadakati kanıtlamaz.
- Başarılı PR/merge/readback dosyaların yayımlandığını doğrular; kaynak aktarımının tamlığını doğrulamaz.

Bu nedenle eski STATE/INDEX/WORK-PLAN/TRANSCRIPTION-NOTE/ARCHIVE-COVERAGE/PUBLICATION/SOURCE-MANIFEST ve kütüphane/cumulative yollarındaki 'tam kaynak', 'kaynak preservation complete' veya bu anlama gelebilecek ifadeler bu sonraki nitelendirmeyle okunmalıdır. Eski yayın kimlikleri ve dosyalar tarihsel olarak korunur; kaynaklar sessizce yeniden yazılmadı.

## Bu tur yapılan dar düzeltme

Bu not oluşturuldu; EXP-004'ün güncel STATE ve INDEX girişlerine kaynak sınırı ve T08 continuation yönü eklenecek. Bu değişiklik, eksik özgün metinleri tamamladığımız veya bütün alt yönlendirme metinlerini düzelttiğimiz anlamına gelmez.

Eksiksiz kaynak okuması gerektiren ileriki kullanımda bu S dosyaları yeterli sayılmamalı. Özgün görünür conversation ya da sağlanmış gerçek export üzerinden ayrı tam aktarım ve karşılaştırma gerekir. Tam onarım açık kalan bir arşiv işidir; önceki kapalı yayın planı bunun tamamlandığını göstermez.

## Devam çalışmasının kapsamı

T08, hâlen bu conversation'da görünür özgün diyalog, güncel Foundation sonuçları ve seçili araştırma kaynaklarıyla devam etti. Eski özetlerin tam-kaynak olduğu varsayımına dayanmadı. T08 notu da açıkça türetilmiş continuation kaydıdır; U/S kesimine yeni özgün mesaj eklenmiş gibi sunulmaz.

Bu hata bir kaynak–görünüm sadakati örneğidir. Onu fark etmek veya nitelendirmek kalıcı davranış iyileşmesini tek başına kanıtlamaz. Gerçek source-recovery, gelecekteki aktarım davranışı ve gerekli kontroller ayrıca sınanmalıdır.
