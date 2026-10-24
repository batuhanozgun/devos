# Taslak 14 — Roket kademesi gibi ayrılmayan sistem

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../14-roket-kademesi-gibi-ayrilmayan-soul.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 2004
- Üst sınır: 2800

---

Agentic sistemleri bazen şöyle çiziyoruz:

Bir orchestrator var.
Gerekli agent’ları kuruyor.
Work system oluşuyor.
Sonra ekip işi yapıyor.

Bir süre sonra bunun bana roketin ayrılan kademelerini hatırlattığını fark ettim.

Kademe görevini yapıyor, kopuyor, ana araç devam ediyor.

Ben uzun ömürlü bir agentic sistemi böyle hayal etmiyorum.

Daha çok baz bir harness var.

Mission geliyor.

Sistem work keşfediyor.
Yeni roller oluşturuyor.
Domain bilgisi birikiyor.
Tool’lar bağlanıyor.
Memory oluşuyor.
Verification yolları ekleniyor.

Ortaya “harness + yanında ayrı bir ekip” çıkmıyor.

Harness artık o işe özgü genişlemiş çalışma sistemi haline geliyor.

Örneğin Security Agent ekledin.

Bu agent’ın work’ü, eriştiği bilgi, authority’si, ürettiği kayıtlar, verifier ilişkisi ve tool’ları artık sistemin state’inin parçası.

Yani dışarı bir worker göndermedin sadece.

Sistemin capability topology’sini değiştirdin.

Bu bakışın önemli sonucu şu:

Agent’ın çalışması yetmiyor, sisteme entegre olması gerekiyor.

Harika güvenlik raporu üretti ama memory kaydetmiyor, planner görmüyor, verifier kullanmıyor, sonraki session recover edemiyor.

O agent teknik olarak var.

Ama çalışma organizmasının gerçek parçası değil.

Mission bitince de genişleyen her şeyin sonsuza kadar kalması gerekmiyor.

Bazı şeyler kapanır.
Bazıları archive olur.
Bazıları reusable capability’ye dönüşür.
Bazıları tamamen atılır.

Burada base system ile mission-specific state’i ayırmak önemli.

“Karakterin adı Derya” bilgisi baza dönmemeli.

Ama “uzun anlatıda karakter motivasyonu değiştiğinde geçmiş bölümleri yeniden tara” gibi gerçekten genellenebilir bir yöntem belki dönebilir.

Bu yüzden iyi agentic mimariyi sabit “20 agent + 50 workflow” paketi gibi düşünmek bana eksik geliyor.

Daha temel ürün şu olabilir:

İş geldiğinde kendisini o işin gerektirdiği çalışma organizmasına dönüştürebilen bir harness.

Roket gibi sistem kurup ayrılan değil.

İş geldikçe şekil değiştirip o işin çalışma sistemi haline gelen bir yapı.
