# Taslak 03 — Evrensel küme / bilinmeyen bilinmeyenler

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../03-gorsel-evrensel-kume-analojisi.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1838
- Üst sınır: 2800

---

Bir sistem tasarlarken beni en çok tedirgin eden eksiklik “bunu henüz araştırmadık” değil.

“Bunun varlığını hiç düşünmedik.”

İkisi aynı şey değil.

Bir ara büyük bir AI ekosistemi görseline bakarken bunu fark ettim. Görseli doğru mimari kabul etmek için değil, bir çeşit dış ayna gibi kullandım.

Üç durum vardı:

Bir alanı biliyoruz ve araştırmışız.
Bir alanı biliyoruz ama henüz araştırmamışız.
Bir alanın varlığı aklımıza bile gelmemiş.

İkinci durum normal bir açık iş olabilir.

Üçüncüsü daha tehlikeli, çünkü ortada açılacak task bile yok.

Agentic sistemlerde de aynı problem var. Planner yalnız bildiği ihtiyaçları plana koyabilir. Researcher yalnız fark ettiği soruları araştırabilir. Verifier yalnız kendisine verilen kriterleri sınayabilir.

Sistemin kör olduğu bir ihtiyaç alanı varsa bütün agent’lar görevlerini doğru yapıp yine eksik bir sistem üretebilir.

O yüzden requirement discovery bence “kullanıcı ne istedi?” sorusundan daha geniş bir problem.

Bazen sistemin şu soruyu da sorabilmesi gerekiyor:

“Bu işi doğru yapabilmek için henüz hangi problem sınıflarının varlığını bile hesaba katmadım?”

Burada dış kaynaklar, başka mimariler, uzman görüşleri, geçmiş failure’lar, checklist’ler veya tamamen farklı bir domain’den gelen örnekler coverage probe gibi çalışabilir.

Ama amaç her şeyi context’e doldurmak değil.

Çünkü 500 dosyaya erişim vermek, 500 dosyadaki perspektiflerin gerektiğinde akla geleceği anlamına gelmiyor.

Bilgi mevcut olabilir ama aktive olmayabilir.

Bu yüzden agentic bir sistemde knowledge base kadar “hangi durumda hangi bilgi dünyasına bakmalıyım?” mekanizması da önemli.

Bence unknown unknowns tarafında en tehlikeli cümle şu:

“Bu konuda eksiğimiz yok.”

Bunu diyebilmek için yalnız bildiklerimizi saymak yetmiyor.

Neleri düşünmediğimizi bulmaya çalışan bir mekanizmaya da ihtiyaç var.
