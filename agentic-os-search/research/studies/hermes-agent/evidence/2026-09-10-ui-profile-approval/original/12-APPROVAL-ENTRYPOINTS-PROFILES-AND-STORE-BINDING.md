# U01-M3 — Gerçek onay girişleri, profil ve bellek bağlama

**2026-09-10 / PINNED SOURCE TRACE + BOUNDED ACCESS-POLICY EXECUTION.** Primary pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Tam HERMES doğrulaması değildir.

Bu dosya notes/ altına konacak giriş taslağıdır; publication durumu ayrı doğrulanmalıdır. Hedef kanıt yolu `../evidence/2026-09-10-ui-profile-approval/`.

Gerçek CLI memory handler'ı varsa live agent store'unu, yoksa yeni disk store'unu verir. Gateway memory handler'ı yeni disk store kullanır. Common apply/cleanup ile approval-mode config değişimi ayrıdır; gateway mode setter'ı session cache eviction çağırırken approve dalı o setter'ı çağırmaz. Sonraki model isteğinin hangi bellek sürümünü kullandığı açık kalır.

Gateway'de normal mesaj kabulü ve canonical komut erişimi farklıdır. Primary multiplex adapter wrapper'ı admitting transport home'u ile routed runtime home'u ayırır. Memory/skills standard busy dispatch'te mid-run handler'a sahip değildir; bu yerel kontrol bütün diğer yazarları dışlayan global kilit değildir.

Tam slash_access.py kimlik doğrulamasıyla altı AP tanılayıcı durum çalıştırıldı. Config/source/user girdileri sentetik; gateway, CLI, actual pending handler, provider veya gerçek hesap çalıştırılmadı. Empty admin-list → disabled slash gate; canonical command granularity; DM/group admin ayrımı ve command-list fallback gözlendi. Bu, bütün internet erişiminin açık olduğu veya gerçekleşmiş yetki ihlali değildir.

M2/N01–N12 tekrarlanmadı. Q26/Q29 full-source/whole-worker açık statüsü, önceki 01–11 notları ve F01–F12 kapsamı korunur. İlk sonraki teknik soru artık aynı-session pending approve → cached-agent seçimi → memory reload/frozen snapshot → cached prompt → request construction bağıdır; API/model çağrısı gerekmeden kaynak ve kontrollü request hazırlama düzeyinde ilerlenir. Secondary/relay varyantları ve skill apply origin/ownership/default-name bağlantısı ayrı residual sorulardır.
