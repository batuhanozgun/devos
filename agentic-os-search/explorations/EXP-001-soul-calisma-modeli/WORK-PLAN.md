# EXP-001 — Yaşayan aktarım planı

**Güncel durum otoritesi:** [STATE.md](STATE.md). Bu plan toplam işi ve alt görevlerin durumunu görünür tutar. Yerel kopya, remote yayın, içerik kimliği ve kaynak sadakati tek hükme indirilmez.

## 1. Kaynakları güvenceye al

| Alt iş | Durum | Not |
|---|---|---|
| 1.1 Altı özgün dosyayı bul, byte-eşit koru, hash'le | TAMAM | SOURCE-MANIFEST altı özgün kimliği taşır; orijinaller değiştirilmedi. |
| 1.2 ZIP'i güvenle aç, üyeleri karşılaştır | TAMAM | CRC sağlam; 26 üye, orijinal ad/göreli yol korunuyor. |
| 1.3 U001–U019 görünür kullanıcı metinlerini aktar | MAIN ÜZERİNDE | 19 mesaj; ham platform export'u değil. |
| 1.4 S001–S018 substantive cevapları aktar | MAIN ÜZERİNDE | 18 ayrı dosya; tarihsel yanlışlar sonradan sessizce düzeltilmedi. |
| 1.5 Kaynak kesimi ve normalizasyonu açıkla | MAIN ÜZERİNDE | Aktarım hatası düzeltme notu; araç/private içerik dışarıda. |
| 1.6 Özgün 32 payload'ı remote'a yayımla | TAMAM | Kullanıcı yüklemesi: a3987312bbfbb8aa0fbf4ea6fd8a1113d467f415. |
| 1.7 Yüklemeyi özgün pakete karşı denetle | TAMAM / GİT İÇERİK KİMLİĞİ | 32/32 dosya, sıfır eksik/uyuşmazlık; yöntem sınırı aşağıda. |

## 2. Düşünce gelişimini işle — MAIN ÜZERİNDE

2.1 LEARNINGS: 15 kaynak bağlantılı kazanım ve sınırı.  
2.2 EVOLUTION: 13 çerçeve/değişim evresi; özellikle kullanıcı düzeltmeleri.  
2.3 Konsolidasyon, Atlas ve sonraki yaşayan plan tartışmasının ayrı kesimleri.  
2.4 OPEN-QUESTIONS: 9 açık konu; araştırma/uygulama yetkisine çevrilmedi.

## 3. Yeniden çağırma yolları — MAIN ÜZERİNDE

3.1 Root README → explorations INDEX/CATALOG → EXP-001 INDEX/STATE.  
3.2 Research root'unda ayrı denemeler kütüphanesine kısa cross-link.  
3.3 TOPIC-MAP: roman, mimar, kulübe, alet çantası, D-02, C bitmeden başlama ve başka dala not gibi hatırlama ipuçları.  
3.4 RESEARCH-REFERENCES: tarihsel snapshot/blob ve güncel kaynak yolları.  
3.5 Sonraki EXP'ler için builds_on/revises/contrasts_with ilişkileri; tekrar bağımsız kanıt değildir.  
3.6 Eser INDEX: artık yüklenmiş MD/PDF/HTML/ZIP/PNG ve çıkarılmış kaynaklara doğrudan bağlantılar.

## 4. Doğrulama — KAPSAMA GÖRE AYRI

| Kontrol | Durum |
|---|---|
| 37 görünür kaynak mesajının sıra/kimlik kapsamı | Önceki arşivleme turunda kaynak dizini/tree üzerinden denetlendi. |
| Önemli kaynak metinlerinin remote okuması | Önceki turda kullanıcı metinleri, D-02 ve mesleki standart düzeltmesi seçici okundu. |
| Kaynak metninin ham platform export'una byte diff'i | YAPILMADI / export yok. |
| Yerel altı orijinalin hash, PDF sayımı ve ZIP CRC'si | İlk aktarımda tamam; kapanışta taşıma ZIP'i ve 32 payload hash'i yeniden kontrol edildi. |
| Kopyalama helper'ının kontrolleri | Önceki 9 yerel kontrol; bu tur yeniden çalıştırılmış sayılmaz. |
| Remote 32 payload'ın yol ve Git içerik/ağaç kimliği | TAMAM; özgün byte'lardan hesaplanan kimlikler pinned GitHub snapshot'ıyla eşit. |
| Tüm remote ikili dosyaları yeniden indirip SHA-256 hesaplama | YAPILMADI; doğrudan ağda DNS engeli. Bunun yerine Git içerik kimliği doğrulaması uygulandı. |
| Kimlik denetiminin negatif kontrolleri | 1 byte değişikliği, eksik dosya ve yanlış isim örnekleri uyuşmazlık verdi. |
| Kullanıcı yüklemesinin kapsamı | Parent→upload compare: yalnız 32 yeni payload, mevcut dosyalarda değişiklik yok. |
| Bütün tarihsel URL/sandbox linklerinin canlılığı | İddia edilmiyor. |
| Her Markdown fragment'inin bağımsız tarayıcı testi | YAPILMADI; bütün linkler geçti iddiası yok. |
| SOUL/Atlas çalışma etkinliği veya yeni UI testi | BU ARŞİV KAPANIŞININ KAPSAMI DIŞINDA. |

## Kapanış ve sonraki iş

[PAYLOAD-VERIFICATION](checks/PAYLOAD-VERIFICATION.md) yükleme kanıtını ve yöntem sınırını taşır. Önceki 32 dosyayı yeniden yükleme işi kalmadı; kullanıcıdan yeni ZIP beklenmiyor. [PAYLOAD-TRANSFER](checks/PAYLOAD-TRANSFER.md) artık tarihsel aktarım kaydıdır.

Planın kaynak arşivleme, eser yayını ve Git içerik-kimliği doğrulaması tamamlandı. Ham platform export'una karşı sadakat, tarihsel tüm bağlantıların canlılığı ve sistem etkinliği bununla doğrulanmış olmadı. Yeni deneme, yaşayan plan araştırması veya Atlas v0.2 ancak ayrı kullanıcı yönüyle başlatılır.
