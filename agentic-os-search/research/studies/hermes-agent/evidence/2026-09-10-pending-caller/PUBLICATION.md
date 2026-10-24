# U01-M3 pending-caller — Yayın ve eşzamanlı kayıt uzlaştırması

**Yayın tarihi:** 2026-09-10. Bu kayıt sohbet ZIP'inde kalan M3-S/SA tesliminin aktarımıdır; yeni araştırma veya deney tekrarı değildir. Current iş otoritesi [STATE](../../STATE.md); current giriş [13 notu](../../notes/13-PENDING-CALLER-EVIDENCE-RECONCILIATION.md).

## Özgün teslimin bütünlüğü

`hermes-pending-caller-2026-09-10.zip`, 33.277 byte; SHA-256 `7e773b94c4c71d2cd6a9386fc7b368dcb8cf12940d6bd9449337934926f5e84a`. CRC ve özgün verify_delivery.py kontrolü başarılı: 17 manifest girdisi boyut/SHA-256/Git blob ile eşleşti; manifest dahil 18 özgün dosya korunur. Bu verifier HERMES kodunu çalıştırmaz.

13 özgün evidence dosyası bu dizinde tutulur. ZIP kökündeki dört dosya ve özgün 12 numaralı taslak, içerikleri değiştirilmeden delivery altında arşivlenir. Özgün manifestteki yollar ZIP düzenine aittir. Eski verifier'ı çalıştırmak için geçici bir dizinde özgün ZIP düzenini yeniden kur; delivery altında doğrudan çalıştırılması bu düzeni sağlamaz. Özgün taslağın göreli linkleri current router değildir; düzeltilmiş giriş 13 notudur.

Yerel exact byte'lardan bağımsız hesaplanan ve GitHub'dan geri okunan tree kimlikleri:

- 13 özgün evidence dosyası: `15b169fbc5b85b2987e589f9ff2fce85b85fbd4c`.
- 13 evidence + dört kök teslim dosyası: `3b075ad1865a24fd764760aac997673e8ea257a0`.
- Özgün 12 taslağı da delivery altına alındıktan sonra bütün 18 özgün dosya: `246a833b3a13414be817a02fa58f4b5259126fb0`.

Üç kimlik de eşleşti. PUBLICATION ve TRANSFER-CHECK özgün manifest dışında yeni yayın ekleridir. Araştırma, kaynak, kod, sonuç ve loglar yeniden yazılmadı; deneyler tekrar edilmedi.

## Main ilerlemesi ve iki ayrı M3 kaydı

Hazırlık tabanı `91af4415c22e05b80484b935383ceeb04a3c5b7b` idi. İlk hazırlanmış detached commit `e91745f3b537aa3d00330645fe969ebe11a61584`, main'e bağlanmadan önce son ref kontrolünde main'in `159936556f34e7e0e1dafcb54c087bef994cf5ba` noktasına ilerlediği görüldü. Eski ağaç zorla yayımlanmadı. Nihai yayın yeni main ağacı üzerine yeniden birleştirildi.

Yeni main'de `evidence/2026-09-10-ui-profile`, `notes/12-UI-PROFILE-AND-APPROVAL-CALLERS.md`, exact SOURCE-LEDGER-THROUGH-V0.9 ve plan v0.10 vardır. Bunlar korunur. Gönderilen ZIP ise ayrı `2026-09-10-pending-caller` / M3-S01–S13 / SA01–SA08 kaydıdır. 12 numarası kullanıldığından yeni current giriş **13** olur; özgün taslak delivery içinde byte olarak saklanır. Plan **v0.11**, bu teslimi v0.10'un üzerine ekler ve aynı onaydan-prompt/request araştırma yönünü korur.

**İki koşuyu birleştirme:** UI/A01–A08 koşusu UTC `2026-09-10T05:42:55.258536+00:00`; bu teslimin M3-S/SA01–SA08 koşusu UTC `2026-09-10T05:12:08.954654+00:00`. İkisi aynı 5666-byte slash_access.py blob'unu kullanır, fakat senaryoları, kodu, sonuçları ve negatif kontrolleri farklıdır. UI kaydındaki always-allow mutant kontrolü SA koşusuna mal edilmez; SA06 profile-only/supplied-config ve SA08 chat_type ayrımları da A koşusunun sonucu diye sunulmaz. Örtüşen kaynak gözlemleri bağımsız doğrulama sayılmaz; sayılar ürün PASS toplamına çevrilmez.

## Güncel anlam ve sonraki iş

Kaynak/kanıt kapsamları değişmez: büyük caller/prompt modülleri SELECTED source trace; SA koşusunda yalnız tam slash-policy modülü yürütülür, config/source holder'ları sentetiktir. Gerçek gateway/CLI/profil/kimlik/provider/credential/request veya bütün ürün koşusu yoktur. SA06 deployment izolasyon açığı, SA08 normal adapter hatası kanıtı değildir.

İlk teknik iş Q07/Q22 onaydan prepared-request görünürlüğüdür. M3-S12/S13 üzerine `agent/conversation_loop.py::_restore_or_build_system_prompt`, compression/keep-prompt, cached-agent reuse/eviction ve invalidation/rebuild zinciri açılır. Yeni store'un eski stored prompt'u kullanıp kullanmadığı peşinen kabul edilmez. Provider/model/credential/kurulum yetkisi genişletilmez. Q26/Q29 full-original/whole-worker ve ledger/sync/skill-cache/curator/F01–F12 açık sınırları korunur.

Özgün README, ACCESS-AND-PUBLICATION, delivery ve RESEARCH içindeki NOT PUBLISHED / eski plan / önce yayın ifadeleri teslim anına aittir; güncel yorum bu dosya ve STATE'tir. Sohbet ZIP'ine veya kullanıcı tarafından elle aktarıma gerek kalmaz.

## Yayının doğrulanması

Bu denemede connected GitHub create_blob/create_tree/create_commit eylemleri çalıştı. Önceki Resource not found olayının teknik nedeni doğrulanmadı; ayar/izin değiştirilmedi, Codex'e neden atfedilmedi. Main hareketinin kaynağı varsayılmadı.

Nihai commit bu dosyanın main Git geçmişindeki ekleme commit'idir. Sadece blob/tree/detached commit publication sayılmaz. Ref force=false ile ilerletilir; değişiklik kapsamı, main ref'i, evidence ve current girişler geri okunur. Yayın yalnız HERMES paketi ve katalogdaki HERMES satırını değiştirir; önceki 01–12 notları ve bütün önceki evidence korunur.
