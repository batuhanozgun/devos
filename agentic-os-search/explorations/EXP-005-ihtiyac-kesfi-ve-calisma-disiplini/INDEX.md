# EXP-005 — İhtiyaç keşfi ve çalışma disiplini

**Alt başlık:** İptal edilen geliştirme girişiminden dersler.  
**Tür:** Kavramsal diyalog + kullanıcı tarafından aktarılan gerçek çalışma raporları + kaynak bağlı süreç retrospektifi.  
**Köken:** 22 Eylül 2026 SOUL Research konuşması.  
**Güncel durum:** [STATE.md](STATE.md). **Geliştirme hattı iptal; ihtiyaç keşfi sorusu açık.** Arşivleme ayrı bir iştir; bu paket eski görevi yeniden başlatmaz.

## Neyi koruyor?

Başlangıçta soru, modern AI araç dünyası karşısında SOUL araştırmalarında hiç düşünülmemiş alan bulunup bulunmadığıydı. Konuşma sonra daha temel bir probleme döndü: **Geniş genel bilgi ve zengin araştırma kütüphanesi varken gerekli ihtiyaçları, kaynakları ve çalışma sistemini neden hâlâ kullanıcı hatırlatıyor?**

Assistant önce bunu eksik bir system-formation/need-discovery motoru olarak güçlü biçimde çerçeveledi; mevcut RPD01'i inceledikten sonra bu teşhisi sınırladı. Codex'e görev verildi. Dar bir RPD01/W04 değişikliği, sentetik karşılaştırmalar, kaynak erişimi engelleri, Cloud/local ve yayın/devir sorunları yaşandı. Kullanıcı tekrar tekrar erişimi, araştırma kapsamını ve doğru çalışma durumunu hatırlatmak zorunda kaldı; sonunda çalışma hattını iptal etti. Sonuç çözülmediği halde bu deneyimin ders olarak saklanmasını istedi.

**Bu paketin çıktısı bir çözüm mimarisi değildir.** Yeni engine zorunluluğu, mevcut RPD'nin genel yeterliği, bütün küçük değişikliklerin etkisizliği veya kalıcı Cloud/local/plugin/clone tercihi kabul edilmez.

## Okuma yolu

1. [STATE](STATE.md): İptal, arşiv durumu, kaynak sınırı ve aktif olmayan devam.
2. [Dersler ve açık sorular](reflections/LESSONS-AND-OPEN-QUESTIONS.md): Olay–yorum ayrımıyla D01–D08. Önceki assistant öz değerlendirmesinin aşırı hükümleri de nitelendirilir.
3. [Konu haritası](retrieval/TOPIC-MAP.md): Halk dili sorularından ilgili mesaj ve derse geçiş.
4. [Kaynak konuşma INDEX](sources/conversation/INDEX.md): **48 kullanıcı + 47 assistant = 95 görünür mesaj**, on sıralı dosya. Bütün metni okumak için 01→10.
5. [Köken ve ekler](sources/ORIGIN-AND-ATTACHMENTS.md): Aktarım işlemleri, görsellerin metni/kimliği, dış çalışma bağları ve erişim sınırları.
6. [Özgün görev sözleşmesi](artifacts/DEVOS02-NEED-DISCOVERY-20260922.md): Değişmeden saklanan tarihsel sürüm 1.0. **İptal edilmiştir; talimat olarak uygulanmaz.**
7. [Arşiv denetimi](checks/ARCHIVE-REVIEW.md), [manifest](SOURCE-MANIFEST.json) ve [arşivleme planı](WORK-PLAN.md): Gerçek kapsam, denetim/yayın ve kalan sınırlamalar.
8. [EXP-001→EXP-005 birlikte okuma](retrieval/CUMULATIVE-READING.md): Öncekilerin yerine geçmeden ilişki kurma.

## Özellikle korunacak üç ayrım

**Plan vardı / planlı yürütme doğrulanmadı.** Görev belgesinde amaç, kaynak, alternatif neden, deney ve yetki sınırı bulunuyordu. “Hiç plan yazılmadı” diye geçmişi düzleştirmek doğru değildir. Metindeki koşulların gerçek giriş ve devirde işletilmesi ayrı problemdir.

**Sınırlı eşit test sonucu / genel yeterlik değil.** Aktarılan v2'de iki yöntem dört vakada aynı sonucu aldı; aday geri alındı. Bu, büyük Research birikimini kullanarak açık-dünya ihtiyaç keşfinin çözüldüğünü göstermez.

**İptal / bilgi kaybı değil.** Deney ve yanlış yönlendirmeler korunur. Eski mesajlar ve devam yolları tarihsel kaynaklardır; yeni yetki oluşturmaz.

## Otorite ve kapsam

Bu paket explorations çalışma malzemesidir; agent-control, Foundation sonucu, concepts ortak tanımı veya DevOS current-state otoritesi değildir. U045'teki kullanıcı iptali burada kaynak olarak bulunur; bu arşivleme başka repository'yi veya canlı Codex süreçlerini değiştirmez. Dersler self-review'dür; kullanıcı arşivlemeyi yetkilendirdi diye teknik hükümleri onaylamış sayılmaz.

Konuşma kaydı model-visible normalize edilmiş aktarım olup platform export'u değildir. Eksik araç kesimleri ve tam native trace'ler yeniden uydurulmadı. Görsellerin metin envanteri ve hash'leri repodadır; özgün PNG'lerin erişim durumu [kaynak notunda](sources/ORIGIN-AND-ATTACHMENTS.md) ayrı tutulur.
