# Taslak 11 — “Hava bugün çok…” ve context aktivasyonu

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../11-hava-bugun-cok-analojisi.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1820
- Üst sınır: 2800

---

“Bugün hava çok…” diye bir cümleyi tek kelimeyle tamamlatırsanız LLM’in “güzel” deme ihtimali yüksek.

Bu örneği uzun süredir başka bir şeyi düşünmek için kullanıyorum.

“Güzel” kelimesi prompt’ta yok. Ama “bugün + hava + çok” modeli belli bir olasılık alanına itiyor.

Agentic sistemlerde context bence biraz böyle çalışıyor.

Bir modelin bir şeyi biliyor olması ile o bilgiyi bu işte kullanması aynı şey değil.

Diyelim agent’ın erişebildiği repository’de verification, memory, authority, context pollution, change impact hakkında aylarca araştırma var.

Yeni bir problem geliyor.

Agent repository’ye teknik olarak erişebiliyor ama yalnız kendi training bilgisinden cevap veriyor. İki klasör ötede problemin tam kendisini anlatan araştırma duruyor.

Dosya var.
Bilgi var.
Erişim var.

Ama düşünceye girmedi.

Burada retrieval’ı sadece “soruya benzeyen belgeyi bul” diye düşünmek bana eksik geliyor.

Daha zor soru şu:

“Bu işi doğru düşünmek için agent’ın neyi görmesi gerekiyor?”

Aynı model yetersiz context ile yüzeysel, yanlış context ile yanlış yönlenmiş, doğru context ile çok daha derin çalışabiliyor.

Tabii buradan “her şeyi prompt’a basalım” sonucu da çıkmıyor. O zaman context’i bilgiyle değil gürültüyle dolduruyoruz. Eski karar, yeni karar gibi görünebilir. Gereksiz kaynak önemli sinyali bastırabilir.

Dolayısıyla harness tarafında asıl işlerden biri yalnız memory tutmak değil, çalışma anında context oluşturmak.

Mevcut work ne?
Hangi kararlar relevant?
Hangi kaynaklar current?
Hangi geçmiş failure burada önemli olabilir?
Hangi bilgi bu agent için gereksiz?

Bunları seçip görünür hale getirmek.

“Hangi model daha iyi?” sorusu tabii ki önemli.

Ama agentic sistemlerde bir soru daha var:

Bu model ne görerek düşünüyor?

Bazen kapasite problemi sandığımız şey aslında context assembly problemidir.
