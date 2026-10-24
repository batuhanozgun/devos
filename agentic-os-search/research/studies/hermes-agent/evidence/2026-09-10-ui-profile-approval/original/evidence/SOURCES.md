# UI kaynak defteri — U01-M3

2026-09-10. Tüm upstream kaynaklar `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` pin'indendir. Bağlantı biçimi: `https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/<path>`.

Tam dosya isteğinin yanıtı büyük dosyalarda ilk görünümde kesildi. Bu dosyalar FULL sayılmaz; aşağıdaki semboller/aralıklar açıkça yeniden getirildi. Blob SHA pinned dosyayı tanımlar; yerel tam byte eşitliği yalnız UI05 için bu tur doğrulandı. UI kimlikleri diğer araştırma defterlerinin yerine geçmez.

| ID | Path | Pinned blob | Gerçek okuma / yürütme |
|---|---|---|---|
| UI01 | hermes_cli/cli_commands_mixin.py | 7061fdcc564214ac3236d0e6d54c19e9c2b9702e | SELECTED: `_handle_memory_command`, `_save_write_approval`, skills pending dispatch; ilgili full-resource arama pencereleri ve giriş yardımcıları. NOT EXECUTED. |
| UI02 | gateway/slash_commands.py | bc7aaabb668f3067cbe8fa03a84efd67186a2fc6 | SELECTED: `_handle_memory_command`, `_handle_skills_command` gate-off/common-call kesiti, `_write_approval_setter`, `_cached_agent_for`, `_resident_agent_for`. NOT EXECUTED. |
| UI03 | gateway/run_inbound.py | 1208221fc56dd161d9a17da33cbfae8d010b0b87 | SELECTED: giriş/_hm_admit_event, canonical ve busy slash-access callsites, idle handler dispatch, profile-scoped preprocessing. Bütün hook/command-rewrite ve internal-event üreticileri incelenmedi. |
| UI04 | gateway/run_busy.py | 57e19f825009bf3326dafe3e9a90d74a67cb9846 | SELECTED: 590–810, 890–1000; özellikle command tables, `_dispatch_busy_slash_command`, `_check_slash_access`. NOT EXECUTED. |
| UI05 | gateway/slash_access.py | 07204201e411f29f912bb9bba6beec0566acab9d | FULL READ, 5666-byte exact local Git identity, EXECUTED AP01–AP06. Stdlib bağımlılıkları; config/source/user girdileri sentetik. |
| UI06 | gateway/authz_mixin.py | cd53d3aa3950abb0a7b291d623a843249059dba7 | FULL READ by overlapping 1–200, 200–330, 330–501, 500–EOF. NOT EXECUTED; platform/adapter/secret bağımlılıkları koşulmadı. |
| UI07 | gateway/run_adapters.py | 3ea22ad640118acdf8a69cd48c590e05a1e360d2 | SELECTED: callback wiring ve 1120–1360, özellikle primary/secondary message wrapper ve route stamping. 1650–1840 boş aralık isteği okuma kapsamına eklenmez. NOT EXECUTED. |
| UI08 | gateway/run.py | d6bfc83ec1271dbd3ee7193ca1b2af794b7844e5 | SELECTED: `_profile_runtime_scope` setter/secret-scope başlangıcı, `_is_user_authorized_for_source` sözleşme/giriş, `_gateway_config_home` navigasyonu ve giriş. Tam helper closure veya bütün runner okunmuş/koşulmuş değildir. |
| UI09 | gateway/profile_routing.py | ae19d6a808c76576e8efa7a39be316ebd838c04e | FULL READ; matching/specificity/parsing. NOT EXECUTED; WhatsApp alias/profile resolver bağımlılıkları sınanmadı. |
| UI10 | gateway/run_agent_cache.py | cac5714863ecabf7eebcaf83f3c64471b760eb9d | SELECTED başlangıç: `_extract_cache_busting_config`, `_agent_config_signature`; tam cache-hit/turn/reload yolu açık. NOT EXECUTED. |
| UI11 | tests/gateway/test_slash_config_writes_routed_profile.py | c1893156f527d06cde26e74172f98654286f3e34 | FULL TEST SOURCE INSPECTED. NOT RUN. Test mode-toggle içindir; önceden scope kurar ve cache eviction'ı no-op yapar. |

## Önceki canonical M2 kaynaklarına dönüş

`91af4415c22e05b80484b935383ceeb04a3c5b7b` içindeki `evidence/2026-09-09-memory-pending/upstream/` byte kopyaları, daha önce yayımlanmış ZIP ile geri açıldı. ZIP SHA-256 `d7d79d0d77099e1f2401174aa34837de4529093b88d1489cc5568fffcfd5fcfd`, canonical PUBLICATION ile eşleşir. Yeni upstream HEAD alımı değildir.

- `memory_tool.py` / `8028ffd88a91b1625e1f1cebe500c37c6e6842a7`: load_on_disk_store 47–61 yeniden okundu.
- `write_approval_commands.py` / `150b72dfd17696ab7a64f97057b7405128f5b352`: common dispatch/apply 35–107 yeniden okundu; önceki tam kaynak bu konuşmada vardır.
- `write_approval.py` / `f1e99b46e934595c002c2bc659143fcbc1f9fe8d`: discard/origin/gate/callback 110–210 yeniden okundu.
- `LICENSE` / `75410e73319c72cd3e991a501c5455eb78f38375`: exact eski lisans yeni UI05 kopyasıyla korunur.

Bu kaynaklar bu tur yeniden yürütülmedi. M2/N sonuçları eski araştırma kanıtıdır; AP koşusuyla karıştırılmaz.

## Navigasyon ve erişim sınırı

Default-branch search `cfdbbb6e35010ace89fbe8243ee82fa4de143e10` sonuçları verdi; yalnız dosya/sembol keşfinde kullanıldı. Yük taşıyan dosyalar primary pin'den yeniden açıldı. Moving HEAD'in güvenlik/kurulu sürüm doğrulaması yapılmadı.

Büyük pinned dosyayı yerelde otomatik elde etme girişimleri: urllib DNS hatası; web raw açılışı cache miss; download aracı 'url not viewed' koşulu nedeniyle başarısız. GitHub connector kaynak okumaları çalıştı. Kaynağın okunabilmesi ile tam dosyanın otomatik yerel materyalizasyonu farklıdır. UI05 elle aktarıldı, fakat importtan önce tam dosya Git blob kimliği eşleşti; beklenen hash değiştirilmedi.

Agent-control dosyaları araştırma corpus'una dahil değildir. Gerçek hesap, credential, kurulum, provider/model veya upstream mutation yoktur.
