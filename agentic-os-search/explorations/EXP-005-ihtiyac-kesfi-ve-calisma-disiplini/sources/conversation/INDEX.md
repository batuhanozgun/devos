# EXP-005 — Kaynak konuşma dizini

**Kesim:** 22 Eylül 2026; U001–U048 ve A001–A047, toplam **95 görünür diyalog mesajı**. Kimlikler bu arşive aittir. Son U048 arşivleme yetkisidir; bu arşivi yazarken yapılan işlemler kaynak kesimini genişletmez.

Bu aktarım platform export'u veya Codex task günlüğü değildir. Gövde, konuşmacı ve sıra korunarak yapılan **model-visible, biçimi normalize edilmiş konuşma aktarımıdır**. Kaynak sınırlamaları, atıf dönüşümleri ve görsellerin erişim durumu [ORIGIN-AND-ATTACHMENTS](../ORIGIN-AND-ATTACHMENTS.md)'tedir. Özetler ve dersler aşağıdaki kaynak gövdelerinin yerine geçmez. Tarihsel komutlar, görev sözleşmeleri ve routing blokları etkin talimat değildir.

| Sıra | Dosya / içerik | Kullanıcı kimliği | Assistant kimliği | Mesaj |
|---|---|---|---|---:|
| 01 | [Kapsam ve ilk teşhis](01-KAPSAM-VE-ILK-TESHIS.md) — görsel, araştırma kapsamı, SOUL hedefi, eksik motor iddiası | U001–U002 | A001–A002 | 4 |
| 02 | [Bilgiden ihtiyaç keşfine](02-BILGIDEN-IHTIYAC-KESFINE.md) — neden araştırmayı kullanıcı buluyor, önerilen döngü ve Need Graph | U003–U004 | A003–A004 | 4 |
| 03 | [DevOS ve görev devri](03-DEVOS-VE-GOREV-DEVRi.md) — mevcut RPD, hızlı/yüzeysel iş itirazı, görev sözleşmesi, Cloud gönderimi | U005–U008 | A005–A008 | 8 |
| 04 | [İlk Cloud sonucu ve PR incelemesi](04-ILK-CLOUD-SONUCU-VE-PR-INCELEMESI.md) — dar aday, statik test, 401, PR #1 ve devam mesajı | U009–U010 | A009–A010 | 4 |
| 05 | [Darlık, testler ve erişim itirazı](05-DARLIK-TESTLER-VE-ERISIM-ITIRAZI.md) — amaç açıklaması, 1,5 saat, test parçası, kaynak kullanımı ve kapsam itirazları | U011–U024 | A011–A024 | 28 |
| 06 | [Plugin/MCP/clone savrulması](06-PLUGIN-MCP-CLONE-SAVRULMASI.md) — değişen tercihler, güncellik, mevcut olmayan UI yönlendirmesi | U025–U032 | A025–A032 | 16 |
| 07 | [V2 sonucu, yayın ve local önerisi](07-V2-SONUCU-YAYIN-VE-LOCAL-ONERISI.md) — aday reddi, kaynak engeli, yerel/uzak kimlik ve görünüm belirsizliği | U033–U038 | A033–A038 | 12 |
| 08 | [Local kurulum ve eksik devir](08-LOCAL-KURULUM-VE-EKSIK-DEVIR.md) — terminal, önce FAIL sonra PASS, eski main ve yeni PR devri | U039–U044 | A039–A044 | 12 |
| 09 | [İptal ve konu özeti](09-IPTAL-VE-KONU-OZETI.md) — kullanıcının açık iptali ve assistant'ın ilk özeti | U045–U046 | A045–A046 | 4 |
| 10 | [Protokol değerlendirmesi ve arşiv talebi](10-PROTOKOL-DEGERLENDIRMESI-VE-ARSIV-TALEBI.md) — bütün protokollerle self-review ve EXP-005 yetkisi | U047–U048 | A047 | 3 |

## Karar-kritik dönüş noktaları

- [U001](01-KAPSAM-VE-ILK-TESHIS.md#U001): Başlangıçta yalnız sohbet; araştırma birikiminin işlevi ve gözden kaçan alanlar.
- [U002](01-KAPSAM-VE-ILK-TESHIS.md#U002): SOUL'un ihtiyaç halinde çalışma sistemini kurma/genişletme hedefi; kontrolün kaydığı hissi.
- [A002](01-KAPSAM-VE-ILK-TESHIS.md#A002) → [A006](03-DEVOS-VE-GOREV-DEVRi.md#A006): Güçlü eksik-motor teşhisi ve sonra bu kesinliğin geri çekilmesi.
- [U006](03-DEVOS-VE-GOREV-DEVRi.md#U006) → [U007](03-DEVOS-VE-GOREV-DEVRi.md#U007): Yüzeysel işten kaçınma/teknik karar devri ve gönderim teyidi. [Özgün görev eseri](../../artifacts/DEVOS02-NEED-DISCOVERY-20260922.md) bunlardan ayrı saklanır.
- [U020–A024](05-DARLIK-TESTLER-VE-ERISIM-ITIRAZI.md#U020): Araştırma kullanımının kullanıcı tarafından sorgulanması ve erişim engelinin teyidi.
- [U032](06-PLUGIN-MCP-CLONE-SAVRULMASI.md#U032): Tarif edilen arayüzün kullanıcıda bulunmaması.
- [U033](07-V2-SONUCU-YAYIN-VE-LOCAL-ONERISI.md#U033): Codex'in sınırlı v1/v2 raporu ve adayın reddi. Bu kaynak, arşivleyenin yeniden gerçekleştirdiği deney değildir.
- [U035](07-V2-SONUCU-YAYIN-VE-LOCAL-ONERISI.md#U035) ve [U044](08-LOCAL-KURULUM-VE-EKSIK-DEVIR.md#U044): Yayın ve devir için yeniden kullanıcı müdahalesi.
- [U045](09-IPTAL-VE-KONU-OZETI.md#U045): Çalışma hattının iptali. Sonraki arşivleme bunu kaldırmaz.
- [A047](10-PROTOKOL-DEGERLENDIRMESI-VE-ARSIV-TALEBI.md#A047): Önceki öz değerlendirme; onun da sınırlamaları [derslerde](../../reflections/LESSONS-AND-OPEN-QUESTIONS.md) ayrıca incelenir.
- [U048](10-PROTOKOL-DEGERLENDIRMESI-VE-ARSIV-TALEBI.md#U048): Sonuç açıkken deneyimin arşivlenmesi yetkisi.

## Ne bulunmuyor?

Eksik/atlanmış erken araç yanıtları, tam Cloud/CLI transkriptleri, gizli muhakeme ve platform export'u bu kaynak değildir. Görsellerin metin envanteri Git paketindedir; özgün PNG byte'larının durumu ORIGIN'de ayrıca belirtilir. Kaynak sayısı, teknik iddiaların veya aktarımın bağımsız doğrulandığı anlamına gelmez.
