# EXP-002 — Arşivleme çalışma planı

**Durum:** COMPLETE — tanımlı kaynak kesimi ve yeniden kullanım metinleri yayımlandı; bounded uzak kontrol kaydı [PUBLICATION](checks/PUBLICATION.md) içinde. Önceki yarım yayın [RECOVERY-LOG](checks/RECOVERY-LOG.md) ile ayrı tarihçe olarak korunur.

**Yetki:** 16 Eylül 2026 görünür konuşmasının U019 mesajı: konuşmayı baştan sona okuma, EXP-001'i gerekli derinlikten devralma ve EXP-002 olarak repository'ye yansıtma. U005 denemelerin birbirine bağlanmasını; U017 değerlendirmelerin otomatik araştırma yönü olmamasını; U018–U019 ileride toplu okumayla Development OS hazırlığına girdi olmasını açıklar. Kesinti sonrası kullanıcı arşivlemeye devam istedi.

**İlk planın başlangıç snapshot'ı:** `1bcaf145bc7169ac8f46573380f98ff269c981ed`.  
**Kesinti sonrası doğrudan gözlenen snapshot:** `10fc114b53c6896f145b2a7de41d1ba3fa2f6fe6`.  
**Paket:** `explorations/EXP-002-soul-baz-yapi-ve-entelektuel-taban/`.  
**Tür:** Kavramsal diyalog, düşünce gelişimi ve hazırlık değerlendirmesi. Gerçek ajan deneyi veya benimsenmiş mimari değildir.

## Teslimatların kapanışı

| Adım | Gerçek karşılık | Durum |
|---|---|---|
| 1. Görünür konuşmayı tam okuma ve kaynağı koruma | U001–U019 / S001–S018; [Diyalog INDEX](sources/conversation/INDEX.md) ve [manifest](SOURCE-MANIFEST.json). Yayın olayları kaynak tartışmadan ayrı. | Tamam |
| 2. EXP-001'i gerekli derinlikten devralma | Giriş/durum/öğrenme/evrim ve yük taşıyan özgün S011/S017; [devir haritası](sources/PREDECESSOR-EXP001.md). Eski kaynak/eserler değişmedi. | Tamam; bütün eski eserleri yeniden tam okuma iddiası yok |
| 3. Kaynak yerine geçmeyen açıklayıcı metinler | Konsolidasyon; 13 öğrenme; 14 gelişim evresi; dokuz açık soru grubu; terimler ve 12 ayrı arşiv nitelendirmesi. | Tamam |
| 4. Yeniden bulma ve birikimli okuma | Konu haritası, research path/blob referansları, [74 mesajlık toplu okuma yolu](retrieval/CUMULATIVE-READING.md). | Tamam |
| 5. Kütüphane girişleri | `explorations/INDEX.md` ve `CATALOG.md` EXP-002 ve EXP-001 bağlantısını içerir. | Tamam |
| 6. Yayın ve kapsam denetimi | Uzak source tree/kimlikler; korunmuş kaynakların tam geri okuması; yeni kaynaklardan S012/S018; tam konsolidasyon geri okuması; bağlantı düzeltmeleri ve izinli path karşılaştırması. | Tamam; ayrıntılı kanıt sınırı PUBLICATION'da |

## Başarı ölçütü ve sınırı

Yeni oturum, sohbet hafızasına gerek kalmadan özgün görünür diyaloğa, bu diyaloğun nasıl geliştiğine, EXP-001 bağlantılarına, son taslak anlayışa ve henüz karara bağlanmayan alanlara ulaşabilir. Kaynak aktarımı ile assistant'ın arşivleme sırasındaki değerlendirmeleri ayrı dosyalardadır.

Bu, ham platform export'u veya bağımsız transcript eşitliği değildir. Her yeni kaynak dosyasının ikinci kez tam uzak içerik karşılaştırması, tüm browser fragment'leri ve bütün dış linklerin canlılık testi yapılmadı. Kaynak kapsamı ile konsept/mimari yeterlilik ayrı tutuldu.

## Yazma sınırı

Yalnız EXP-002 paketi ve explorations kütüphanesinin gerekli iki giriş yüzeyi değiştirildi. `AGENT.md`, `agent/**`, `research/**`, EXP-001 kaynak/eserleri ve Development OS repository'leri bu işin kapsamına alınmadı. Denemeden yeni araştırma kuyruğu, kabul edilmiş mimari veya davranış protokolü üretilmedi.

## Sonraki sorumluluk

Bu aktarım için yeni payload/ZIP veya tekrar yükleme gerekmiyor. Sonraki kullanıcı yönüyle yeni deneme veya toplu kaynak okuması yapılabilir. Development OS kurulumu ve araştırma yönü ayrı yetki ve güncel canonical state gerektirir. Bu plan artık açık aktarım kuyruğu değildir.
