# Taslak 10 — İnsan hatırlar, LLM yeniden bulur

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../10-insan-hatirlar-llm-yeniden-bulmak-zorundadir.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1770
- Üst sınır: 2800

---

İnsan hafızasıyla LLM memory’sini birebir karşılaştırmak doğru değil ama bir farkı görünür kılmak için işe yarıyor.

Bir insan dün bir karar verdiğinde bugün o karar hayatının geçmişinin parçası.

LLM agent dün karar verdi, D042.md’ye yazdı, session kapandı.

Bugün aynı model yeniden açıldı.

Dosya hâlâ orada.
Model de aynı model.

Ama o dosyayı current context’e getiren hiçbir mekanizma yoksa, agent çalışma açısından o kararı bilmiyor.

Bence external memory’de en önemli ayrımlardan biri bu:

write ≠ remember

stored ≠ retrievable ≠ retrieved ≠ used

Bir bilgi diskte durabilir.
Ulaşılabilir olabilir.
Agent gerçekten retrieve etmiş olabilir.
Ama current reasoning’de doğru biçimde kullanılmamış olabilir.

Dört farklı durum.

Buradan tuhaf bir bootstrap problemi çıkıyor.

Karar D042.md’de.
Agent bunu nasıl bulacak?

INDEX.md’den.

Peki INDEX.md okunması gerektiğini nasıl bilecek?

Project instruction söyleyebilir.
Bir router yönlendirebilir.
Hook otomatik getirebilir.
Başka bir agent work context hazırlayabilir.

Yani memory sadece bilgiyi saklama mimarisi değil, bilgiye giden yolun da mimarisi.

Bu yüzden “agent’ın memory’si var” cümlesi bana artık çok az şey söylüyor.

Session değişince ne recover ediliyor?
Kararın kendisi mi?
Gerekçesi mi?
Kaynağı mı?
Hâlâ current olup olmadığı mı?
Hangi work için relevant olduğu mu?

Aynı modelin kullanılması da continuity sağlamıyor.

Same model ≠ same history.

Uzun süren agentic işlerde continuity, model kimliğinden çok state recovery meselesi.

Ve çözüm “her şeyi her session başında yükle” de değil. Memory büyüdükçe context’i çöplüğe çevirebiliriz.

Hedef her şeyi hatırlamak değil.

Gerektiğinde doğru şeyi, doğru nedenle, doğru work’ün içine geri getirebilmek.

Bence gerçek memory tam burada başlıyor.
