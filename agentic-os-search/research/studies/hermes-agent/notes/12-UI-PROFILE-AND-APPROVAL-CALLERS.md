# U01-M3 — Gerçek CLI/gateway onayı ve profil bağlama

**Tarih:** 2026-09-10. **Pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. **Statü:** PINNED CALLER SOURCE TRACE + BOUNDED FULL SLASH-POLICY MODULE EXECUTION. Tam HERMES veya gerçek kurulum doğrulaması değil.

[Tam araştırma](../evidence/2026-09-10-ui-profile/RESEARCH.md), [UI01–UI13 kaynak/okuma defteri](../evidence/2026-09-10-ui-profile/SOURCES.md), [deney kapsamı](../evidence/2026-09-10-ui-profile/README.md), [A01–A08 sonuçları](../evidence/2026-09-10-ui-profile/RESULT.json), [SPEC](../evidence/2026-09-10-ui-profile/SPEC.md), [kod](../evidence/2026-09-10-ui-profile/policy_probe.py), [yayın](../evidence/2026-09-10-ui-profile/PUBLICATION.md).

## Kaynakla bağlanan mekanizma

CLI `/memory`, varsa aktif ajanın canlı store'unu; yoksa fresh disk store'unu ortak pending handler'a verir. Gateway aynı komutta her seferinde fresh store yükler. Ortak işlem aynı olsa da nesne yaşam süresi farklıdır; M2'nin disk/live/frozen ayrışması iki kullanıcı yüzeyinde aynı süre/etki iddiasına dönüştürülmez.

Normal gateway mesajında ingress kullanıcı denetimi, canonical komut-adı izni ve busy/idle sırası ayrı aşamalardır. Memory/skills idle-only handler'lara bağlanır; bu per-session kural aynı profile'ın bütün yazarlarını kilitlemez. Profile wrapper, admitting transport yetki bağlamı ile storage/runtime home'u ayırır. Pending ve memory yolları active home'a bağlıdır; origin etiketi insan kimliği veya kayıt sahipliği değildir.

Merkez slash policy komut adı seviyesindedir. Non-admin'e `memory` izni verilmesi, merkez katmanda yalnız pending okuma izniyle aynı değildir; yerleşik handler approve/reject/approval mode'u da aynı komut ailesinde işler. Birincil kullanıcı denetimi ve opsiyonel hooks ayrı kalır; bu genel yetkisiz erişim hükmü değildir.

Gateway'de approval/mode ayarını değiştiren callback config yazımı ve ilgili cached-agent eviction yapar. `approve <id>` bu callback'i çağırmaz. Başarılı apply, pending temizleme, cached bellek yenileme ve modele yeni bilgi gönderme ayrı geçişlerdir. Gateway skill diff kesintisi ve sabit `~/.hermes` konum ipucu da gerçek routed home'a eşitlenmez.

## Yeni yürütme ve sınır

UTC `2026-09-10T05:42:55.258536+00:00`, Python 3.13.5/Linux: tam 5666-byte `gateway/slash_access.py`, blob `07204201e411f29f912bb9bba6beec0566acab9d`, sekiz source-informed senaryo ile yürütüldü. Config/source/platform holders sentetik. Değiştirilmiş kaynak importtan önce reddedildi; daima izin veren test mutantını ret oracle'ı yakaladı. Gateway, profile resolver, UI handler, memory mutator veya provider bu tur çalıştırılmadı; eski M2/D3/C/V deneyleri tekrarlanmadı.

## Devam

İlk sonraki iş Q07/Q22: gerçek CLI turn'ü ve cached gateway turn'ünde onaydan sonra disk → store → frozen snapshot → cached prompt → hazırlanan model isteği. Yeni bilgi mutlaka görünmez veya mutlaka görünür varsayımı yapılmaz. Q05/Q23/Q24 normal kaynak zinciri ilerledi ama tüm auth/profile/hook/platform ve hata yolları açık. Q26/Q29 full fidelity/runtime ertelenmiş sınırları korunur. Current authority [STATE](../STATE.md), [plan v0.10](../RESEARCH-PLAN.md); yöntem [METHOD](../METHOD.md).
