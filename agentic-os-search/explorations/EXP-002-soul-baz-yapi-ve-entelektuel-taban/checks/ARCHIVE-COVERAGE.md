# EXP-002 — Arşiv kapsamı

## Kaynak kesimi

[Kaynak diyalog](../sources/conversation/INDEX.md), U001–U019 ve S001–S018'i içerir: **37 mesaj, 19 kaynak dosyası**. Kullanıcı mesajları tek dosyada, assistant yanıtları 18 ayrı dosyadadır. Dosya boyutları toplamı **105.514 byte**; kimlikler [SOURCE-MANIFEST](../SOURCE-MANIFEST.json) içindedir. Bu sayı arşiv başlıkları dahil yayımlanan dosyaları sayar; özgün platform byte sayısı değildir.

U019'a cevap olarak tamamlanmış bir kaynak S019 yoktur. Arayüzdeki başarısızlık ve son kullanıcı devam mesajı [RECOVERY-LOG](RECOVERY-LOG.md) içinde ayrılır. Bu sınır özgün tartışmayı sonradan oluşan arşivleme olaylarıyla karıştırmaz.

## Dört sorunun kapsanması

| Başlangıç sorusu | Kaynakta karşılığı | Kapsam sınırı |
|---|---|---|
| 1. İlk exploration'ı hatırlama | S001; ardından U002–U005 / S002–S005'te rol amacı ve birbirine bağlı denemeler | EXP-001'in özeti onun tüm kaynak okuması yerine geçmez. Bu turdaki gerekli devir derinliği PREDECESSOR kaydındadır. |
| 2. Geçici SOUL tanımı | S006; U007'nin uygunluk ifadesi | Çalışma sistemi oluşturma/işletme/uyarlama görüşüne uygunluk; somut mimari veya bilimsel doğrulama değil. |
| 3. Tanımı somutlaştırma | S007–S014; ABC örneği, baz SOUL, rol/terim ayrımı ve ortak entelektüel taban | Başta sayılan bütün teknik terimler tek tek tamamlanmadı. Sabit roller, loop/graph engineering ve aktarım mekanizması açık kaldı. |
| 4. Araştırma birikimiyle değerlendirme | S015–S017; U017 sınırı; U018/S018 Development OS bağlantısı | Kavramsal değerlendirme; araştırma yol haritası, nicel hazırlık ölçümü veya uygulama başlangıcı değil. |

**Arşivin tamamlanması, konuşmadaki bütün soruların çözülmesi değildir.** Kaynakta açık kalan konu yeni bir uydurma cevapla kapatılmadı.

## Yeniden kullanım katmanları

- [CONSOLIDATION](../artifacts/CONSOLIDATION.md): on bölümlü bütünlüklü okuma; kaynak mesajlara bağlı.
- [LEARNINGS](../reflections/LEARNINGS.md): 13 yeniden kullanılabilir ayrım, her birinin kullanım ve kanıt sınırı.
- [EVOLUTION](../reflections/EVOLUTION.md): 14 gelişim evresi ve değiştirici kullanıcı girdileri.
- [OPEN-QUESTIONS](../reflections/OPEN-QUESTIONS.md): dokuz açık soru grubu; görev kuyruğu değil.
- [TERMS](../reflections/TERMS.md): terimlerin konuşmadaki geçici anlamları.
- [QUALIFICATIONS](../reflections/QUALIFICATIONS.md): 12 arşivleme-sonrası nitelendirme; özgün konuşma veya kullanıcıca kabul edilmiş ek karar değil.
- [TOPIC-MAP](../retrieval/TOPIC-MAP.md): doğal dil ve örnekten kaynak mesaja erişim.
- [CUMULATIVE-READING](../retrieval/CUMULATIVE-READING.md): EXP-001 → EXP-002, toplam 74 kaynak mesaj için sıralı tam okuma yolu; eser derinliği ayrıca belirtilir.
- [PREDECESSOR-EXP001](../sources/PREDECESSOR-EXP001.md) ve [RESEARCH-REFERENCES](../sources/RESEARCH-REFERENCES.md): önceki denemeden devir ve tarihsel kaynakların yeniden bulunması.

## Koruma ve doğrulama sınırları

Görünür diyalog baştan sona okundu. Aktarım ham platform export'u değildir; bağımsız transcript doğrulaması veya byte-perfect eşitlik iddia edilmez. Özgün yanıtların güçlü ifadeleri kaynakta korunur, sonradan getirilen uyarılar ayrı kalır.

EXP-001'in kaynak/eserleri bu pakete yeniden kopyalanmadı veya değiştirilmedi. Bu tur onun bütün ikili eserleri yeniden indirilmedi/çalıştırılmadı. EXP-002'de yeni özgün medya eki olmadığı için eksik PDF/ZIP aktarım kuyruğu yoktur; konsolidasyon arşiv sırasında üretilmiş Markdown'dır.

Yayın işlemlerinin başarı mesajı ile uzak içerik geri okuması ayrı kayıtlanır. Gerçek file/tree/readback/diff kapsamı [PUBLICATION](PUBLICATION.md) içindedir. Yapılmayan tam tarayıcı-fragment taraması, dış link canlılık taraması veya SOUL davranış testi yapılmış gibi gösterilmez.
