# U01-M3 — Gerçek pending çağrısı, yetki, profil ve prompt görünümü

**Araştırma tarihi:** 2026-09-10. **Statü:** PINNED CALLER SOURCE TRACE + BOUNDED EXACT SLASH-POLICY EXECUTION. Bu teslim hazırlandığında canonical yayın tamamlanmadı; dosyanın pakette olması GitHub'da bulunduğu anlamına gelmez.

Primary pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` korunur. [Tam araştırma](../evidence/2026-09-10-pending-caller/RESEARCH.md), [M3 kaynakları](../evidence/2026-09-10-pending-caller/SOURCES.md), [SA01–SA08 ham sonuç](../evidence/2026-09-10-pending-caller/POLICY-RESULT.json), [SPEC](../evidence/2026-09-10-pending-caller/SPEC.md), [kod](../evidence/2026-09-10-pending-caller/policy_probe.py), [yayın/erişim kaydı](../evidence/2026-09-10-pending-caller/ACCESS-AND-PUBLICATION.json).

## Ne ilerledi?

Actual CLI memory onayı canlı store'u, bulunmazsa fresh store'u kullanır; gateway memory handler'ı fresh on-disk store verir. Ortak komutun öncesinde normal dış mesaj kabulü, ek slash yetkisi ve idle/busy dispatch vardır. Transport authorization home, routed runtime home, pairing-store ve komut config seçimi tek profile olgusu değildir.

Exact `gateway/slash_access.py` (5666 byte, Git blob `07204201e411f29f912bb9bba6beec0566acab9d`) ile sekiz kaynak-informed senaryo yürütüldü; beklentiler eşleşti ve değiştirilmiş kaynak gerçek pre-import guard'ıyla reddedildi. Config/source holder'ları sentetik. Boş admin listesinde ek gate kapalı; etkin gate'te DM/group, admin/user-command ve help/whoami ayrımı var. Aynı config ile yalnız source.profile değişimi kararı değiştirmedi; farklı config değiştirdi. Bu gerçek multiplex deployment kusuru veya tam gateway doğrulaması değildir.

Gateway skills diff'i 3000 karakterde kesilebilir ve literal default-home pending JSON yolunu gösterir; record dosyası sabit diff snapshot'ı değildir. Approval mode setter'ının cache eviction yapması, approve işleminin de yaptığı anlamına gelmez. Store reload, cached prompt invalidation/build ve gerçek request seçimi ayrı olaylardır.

## Sınır ve devam

M2 N01–N12, D3 MW ve eski worker deneyleri tekrarlanmadı. Source trace bütün UI yürütmesi değildir; gerçek auth/config/profile/cache yaşam döngüsü ve model isteği çalıştırılmadı. Q26/Q29 tam-orijinal/whole-worker boşluğu kapanmadı. Her iddia için M3 kaynak defterindeki FULL/SELECTED/EXECUTED ayrımı korunur.

Önce bu teslimin yayın/continuity kapanışı. Sonraki teknik birim `agent/conversation_loop.py::_restore_or_build_system_prompt`, compression/keep-prompt ve cached-agent yaşam döngüsünden request/prompt readback'ine geçiştir; provider çağrısı olmadan. Ardından ledger/backup/restore/sync, skill/cache ve curator nested batch/report/cron sırası korunur. Ana çalışma otoritesi repo STATE/plan; bu not tek başına plan v0.10'un yayımlandığı anlamına gelmez.
