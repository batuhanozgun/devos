# U01-M3 — Ayrı pending-caller tesliminin geri kazanılması

**Yayın:** 2026-09-10. **Statü:** RECOVERED SOURCE TRACE + BOUNDED EXACT SLASH-POLICY EVIDENCE. Bu yayın yeni deney değildir. Primary pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` korunur.

[Tam araştırma](../evidence/2026-09-10-pending-caller/RESEARCH.md), [M3-S kaynak defteri](../evidence/2026-09-10-pending-caller/SOURCES.md), [SA01–SA08 ham sonuç](../evidence/2026-09-10-pending-caller/POLICY-RESULT.json), [SPEC](../evidence/2026-09-10-pending-caller/SPEC.md), [kod](../evidence/2026-09-10-pending-caller/policy_probe.py), [yayın uzlaştırması](../evidence/2026-09-10-pending-caller/PUBLICATION.md), [aktarım kontrolü](../evidence/2026-09-10-pending-caller/TRANSFER-CHECK.json).

## İki kaydı ayır

[12 UI/profile çalışması](12-UI-PROFILE-AND-APPROVAL-CALLERS.md), `159936556f34e7e0e1dafcb54c087bef994cf5ba` commit'iyle main'e girmiştir; korunur. Bu 13 girişi, sohbet ZIP'inde kalan ayrı `pending-caller` teslimini kaydeder. İki çalışma da U01-M3 adını kullanmıştı; karışıklığı önlemek için 12'nin **UI01–UI13/A01–A08** ve bu teslimin **M3-S01–S13/SA01–SA08** kimlikleri kendi defterlerinde tutulur.

SA koşusu UTC `2026-09-10T05:12:08.954654+00:00`; A koşusu UTC `2026-09-10T05:42:55.258536+00:00`. Ortak tam slash_access.py blob'u `07204201e411f29f912bb9bba6beec0566acab9d`, 5666 byte. Kodlar, senaryolar ve sonuçlar farklıdır. A kaydındaki always-allow mutant kontrolü SA kaydına aktarılmaz. Örtüşen kaynak gözlemleri bağımsız doğrulama veya sayılar ürün PASS toplamı değildir. Hiçbiri bu yayın turunda tekrar koşulmadı.

## Bu teslimin kapsamı

Actual CLI live/fallback ve gateway fresh store; normal ingress/slash/busy-idle/caller/home/pending ve prompt yenileme kaynak bağlantıları incelenmiştir. Büyük caller modülleri SELECTED source trace'tir. Yalnız tam slash-policy modülü SA01–SA08 ile çalıştırılmış; config/source holder'ları sentetiktir. Gerçek gateway/CLI/kimlik/profile/provider/request veya bütün ürün çalıştırılmamıştır.

SA06 aynı supplied config ile yalnız source.profile değişiminin kararı değiştirmediğini, config değişiminin değiştirdiğini gösterir; deployment izolasyon açığı değildir. SA08 boş/None chat_type davranışıdır; gerçek adapter'ların hatalı veri ürettiğini göstermez. M3-S12/S13 memory_parts/build/invalidate/cached-turn kaynak bağlantısını taşır; outbound request kanıtı değildir. Önceki M2 ve worker/middleware sınırları korunur.

## Yayın ve devam

Özgün 18 dosya byte olarak korunur; eski 12 taslağı ve teslim kök dosyaları evidence/delivery altında arşivlenir. Oradaki NOT PUBLISHED/NOT APPLIED ve eski plan ifadeleri tarihsel teslim durumudur. Current giriş bu 13 notu, yayın açıklaması PUBLICATION, iş otoritesi [STATE](../STATE.md) ve [plan v0.11](../RESEARCH-PLAN.md)'dir.

12'nin yönü korunur: Q07/Q22 onaydan prepared-request görünürlüğü. Bu teslimin kaynak rotasıyla ilk exact soru `agent/conversation_loop.py::_restore_or_build_system_prompt`; ardından compression/keep-prompt, cached-agent reuse/eviction ve invalidation/rebuild. Yeni store'un eski stored prompt'u kullanıp kullanmadığı peşinen varsayılmaz. Provider/model/credential/kurulum yetkisi genişletilmez; Q26/Q29 full-original/full-worker ve ledger/sync/skill-cache/curator/F01–F12 açık kalır.
