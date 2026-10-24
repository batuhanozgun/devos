# Taslak 07 — Futbolcu kartı ve ortak entelektüel taban

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../07-futbolcu-karti-analojisi.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1648
- Üst sınır: 2800

---

Agent rollerini düşünürken futbol oyunlarındaki oyuncu kartları aklıma geliyor.

Forvet:
Şut 9
Bitiricilik 9
Kalecilik 2

Kaleci:
Refleks 10
Pozisyon 9
Şut 3

Bunda problem yok. Zaten uzmanlaşma dediğimiz şey bu.

Agentic sistemlerde de security agent’ın güvenlik reasoning’i çok yüksek, production coding’i daha düşük olabilir. Builder kodda güçlüdür, researcher kaynak taramada.

Ama futbol kartlarında bir de mevkiye özel olmayan özellikler var.

Oyun görüşü.
Karar verme.
Pozisyon farkındalığı.
Takım oyunu.
Dayanıklılık.

Forvet de bunlara ihtiyaç duyuyor, kaleci de.

Ben agent’larda da böyle ortak bir entelektüel taban olması gerektiğini düşünüyorum.

Her agent her işi yapabilsin demiyorum.

Tam tersine, rolü mümkün olduğunca net olsun.

Ama rolü dar diye görüşü de daralmasın.

Bir verifier yalnız önündeki test case’i çalıştırıp yeşil gördüğünde geçmemeli; bu test gerçekten doğru şeyi mi ölçüyor diye bakabilmeli.

Researcher yalnız kaynak bulmamalı; kaynağın ne kadar güçlü olduğunu ayırabilmeli.

Builder yalnız task’ı kapatmamalı; yaptığı değişikliğin sistemin başka bir yerini etkileyebileceğini fark edebilmeli.

Bunlar role özgü uzmanlık değil. Daha çok ortak “oyun görüşü”.

Multi-agent sistemlerde bazen rolleri çok iyi ayırıyoruz ama her rolü kendi küçük kutusuna da hapsediyoruz. Sonra herkes lokal görevini başarıyla tamamlıyor, sistem seviyesinde kimse oyunu görmüyor.

Bence iyi agent tasarımı şu iki şeyi aynı anda istiyor:

Dar ve açık bir terminal amaç.
Geniş bir sistem görüşü.

Futbol diliyle:

Mevkisi belli olsun, ama kafasını kaldırıp sahayı da görsün.

Uzmanlaşma düşünme kalitesinin daralması anlamına gelmemeli.
