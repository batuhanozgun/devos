# EXP-001 — STATE

**Arşiv durumu:** ARCHIVED — tanımlı görünür diyalog kesimi, yeniden kullanım metinleri ve 32 özgün eser/kaynak dosyası `main` üzerinde. Önceki payload aktarım eksiği kapanmıştır.  
**Payload doğrulaması:** 32/32 dosya; özgün paket byte'larından yeniden hesaplanan Git içerik/ağaç kimlikleri, GitHub'daki sabitlenmiş yükleme commit'iyle eşleşti. Tam ikili yeniden-indirme/SHA-256 kontrolü ayrıca yapılmadı; yöntem ve sınır aşağıda.  
**Denemenin statüsü:** Kavramsal prova / sentetik demo / taslak mekanizma modeli. Bağımsız sistem doğrulaması veya mimari kabul değildir.  
**Yetki:** U018 arşivleme talebi, S018 planı, U019 uygulama/devam onayı; devam konuşmasında kullanıcının dosyaları yüklemesi ve kontrol istemesi.  
**Kaynak kesimi:** U001–U019 ve S001–S018. Sonraki aktarım konuşmaları özgün diyalog kesimine eklenmiş sayılmaz; yükleme/kapanış olayları checks altında tutulur.

## Repository'de tamamlanan bölüm

- `agent/` ve `research/` yanında `explorations/` kütüphanesi; root README ve research/INDEX çapraz yönlendirmesi.
- 19 kullanıcı mesajı ve 18 substantive assistant cevabı, konuşmacı/sıra/kimlikleriyle: [Diyalog INDEX](sources/conversation/INDEX.md).
- 15 kaynak bağlantılı öğrenme kaydı, 13 evreli düşünce/düzeltme izi, 9 açık soru grubu, konu haritası ve araştırma kaynak yolları.
- Konsolidasyon, Atlas ve Atlas sonrası yaşayan plan tartışmasının ayrı kesimleri. Eski eserler yeni görüşlerle yeniden yazılmadı.
- Altı özgün dosya: konsolidasyon Markdown/PDF, Atlas HTML/PDF/ZIP ve özgün PNG çizim; ayrıca kaynak ZIP'inin 26 çıkarılmış üyesi. Toplam 32 dosya, 6.176.086 byte. [Eserler](artifacts/INDEX.md).

## Yükleme ve içerik kimliği doğrulaması

Kullanıcı dosyaları `a3987312bbfbb8aa0fbf4ea6fd8a1113d467f415` commit'iyle, beklenen `explorations/EXP-001-soul-calisma-modeli/` yollarına yükledi. Commit'in ebeveyni `26067fc364f9813683aa5c4ebc6435279eeceb8e`; fark yalnız 32 yeni payload dosyasıdır. Var olan konuşma ve araştırma dosyaları bu yüklemeyle değiştirilmedi.

Önceden hazırlanmış tamamlama ZIP'inin SHA-256 kimliği yeniden doğrulandı: `054983b46aaa6ac33b226445ce194c1125ff89e5a7a1e4bdbc11cb579783a5a2`. İçindeki manifest ve 32 dosyanın boyut/SHA-256/Git blob kimlikleri yerel özgün byte'lardan yeniden hesaplandı. Konsolidasyon ve Atlas alt ağaçları ile çizim blob'u GitHub'dan okunan kimliklerle eşleşti. Ayrıntılar: [PAYLOAD-VERIFICATION](checks/PAYLOAD-VERIFICATION.md).

Bu, yalnız dosya adı/sayısı kontrolü değildir; yolları, içerikleri ve dosya modlarını bağlayan Git içerik-kimliğine dayalı doğrulamadır. Doğrudan HTTPS adres çözümlemesi bu ortamda başarısız olduğu için tüm remote ikili dosyalar yeniden indirilip ayrı SHA-256 hesaplanmadı. Bu yapılmış gibi sunulmaz. Önceki aktarım planındaki indirme yöntemi yerine kullanılan kimlik denetimi ve kalan sınır açıkça kaydedildi.

## Kaynak sadakati ve kanıt sınırı

Görünür diyalog, assistant tarafından yapılmış kapsamlı aktarımdır; platformun ham export'u veya bağımsız byte-perfect transcript doğrulaması değildir. Tarihsel citation/sandbox işaretleri korunur; yeni erişim garantisi sayılmaz. [TRANSCRIPTION-NOTE](checks/TRANSCRIPTION-NOTE.md).

Arşiv kapanışı, konuşmadaki modelin doğrulanması değildir. Eski Atlas UI testleri yeniden çalıştırılmadı. Tarihsel bütün dış bağlantıların canlılığı veya bütün Markdown fragment'lerinin tarayıcı testi iddia edilmiyor. [ARCHIVE-COVERAGE](checks/ARCHIVE-COVERAGE.md).

## Sonraki durum

Bu aktarım için kullanıcının yeniden dosya/ZIP göndermesi gerekmiyor. Tamamlama ZIP'i artık geçici taşıma aracıdır; esas erişim yolu repository'dir. [PAYLOAD-TRANSFER](checks/PAYLOAD-TRANSFER.md) kapanmış aktarımın tarihçesini ve yeniden denetim yolunu taşır.

Açık fikirler ve araştırma adayları [OPEN-QUESTIONS](reflections/OPEN-QUESTIONS.md) içinde korunur; bunlar otomatik yürütme kuyruğu değildir. Yaşayan plan araştırması, Atlas v0.2, SOUL veya Development OS implementasyonu başlatılmadı. `AGENT.md`, `agent/**`, Foundation ve diğer studies bu kapanışta değiştirilmez.
