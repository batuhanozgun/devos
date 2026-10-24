# U15-A — Kaynak ve okuma kapsamı

**2026-09-13 / SOURCE ONLY; upstream tests inspected, NOT RUN.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Araştırma](SYNC-AND-LOCAL-STATE.md). Satırlar 1-based; FULL READ metin kapsamıdır, full local-byte/import/dependency closure değildir.

| ID | Primary path / Git blob | Gerçek okuma |
|---|---|---|
| S01 | `tools/skills_sync.py` / `ca774820be589796bb7972679ee070d4e3568acb` | FULL READ1–210,211–425,426–650(EOF). Live paths, v2/v1 manifest/hash, suppression/external/rename/orphan, copy/update/sync/result ve scope guard. |
| S02 | `tools/skills_sync_bundled_ops.py` / `5f66e12025ddc93a98442eac3ad89bcfa6e83f8f` | FULL READ1–220(EOF). Reset/diff/list-modified/opt-out/remove-pristine; actual CLI confirmation/consumer değil. |
| S03 | `tools/skills_sync_optional.py` / `313de12c8805eb4c915ce27015eaae6ba6af6281` | FULL READ1–220,221–430(EOF). Cache filtering, hub lock, official backfill, optional restore backups. Atomic-write/helper/security scanner full değil. |
| S04 | `agent/skill_utils.py` / `fe0b06c69f87d391898a7d6ab98d63a58bd9c7dc` | SELECTED1–230,231–455. Exclusions/support dirs, org-marker helper, platform/environment offering, config/external/create dirs, essential `hermes-agent`, project trust girişleri. Discovery/lookup tail burada okunmadı. |
| S05 | `tests/tools/test_skills_sync.py` / `b532881aac16f52edffa153a4051ad7b7d3c2656` | SELECTED1–225,450–690. Manifest/hash/discovery/scope, seeding/deletion/immediate-copy-error ve reset eş-current-content/removed-source/readonly case. Bütün suite/fixtures veya rmtree-failure tail okunmuş değil. NOT RUN. |

Primary bağlantı kökü: https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/ . Alt dosyalar S01 import/reexport ve S03 üzerinden keşfedildi. Test araması `b6b53c69a6ed49cb099cf1bfe76b5e6edd718e5a` default-branch pointer'ı verdi; içerik exact primary'den getirildi. İlk `test_skills_sync` araması boş döndü, kaynakta test yokluğu sayılmadı; ikinci sembol araması gerçek yolu buldu.

## W01 — ayrı mutable doküman yüzeyi

13 Eylül web araması resmî Skills System, Curator, CLI Commands Reference ve Bundled Skills Catalog sayfalarının selected görünümlerini getirdi. Özellikle https://hermes-agent.nousresearch.com/docs/user-guide/features/skills ve https://hermes-agent.nousresearch.com/docs/user-guide/features/curator . Opt-out/reset/provenance açıklamaları navigation veya target claim'dir; current source/installed behavior doğrulanmış sayılmaz. Belge→pinned source farkı korunur, pin yükseltilmedi.

## Önceki kanıt ve erişim sınırı

U14 A/B ve kaynakları install/update caller'ları için aynı-conversation re-used; synthesis01 ve notes03/04/08 yeniden tam okundu. Notes03'ün kesilen ortası65–95 ve90–EOF ile tamamlandı. Eski diagnostic/approval/source sonuçları yeniden çalıştırılmadı veya bağımsız kanıt sayılmadı. AGENT/R01–R09 bu tur tam getirildi; çalışma corpus'una dahil değildir.

Public raw S01'i local bytes olarak almak için tek urllib isteği DNS `Temporary failure in name resolution` ile başarısız oldu. Yerel original source kopyası oluşmadı; connector metniyle kaynak incelemesi sürdü. İzin/credential veya ağ ayarı değiştirilmedi. Yeni HERMES import/sync/install/curator/model/DB/upstream suite çalıştırması, RESULT/PASS veya binary test arşivi yoktur.

Opening2bcdf606 actual main/ref/full PLAN/one-path compare sonrası A başladı. Yayın source iddialarını behavioral validation'a yükseltmez. V1 ikinci-tur, reset result ve deletion-reintroduction çıkarımları koşullu control-flow composition'dır, gözlenmiş kullanıcı olayı değildir.
