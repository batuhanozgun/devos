# M3 kaynak ve okuma defteri

**Tarih:** 2026-09-10. **Research tabanı:** `91af4415c22e05b80484b935383ceeb04a3c5b7b`.
**Tek teknik pin:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.

Her primary bağlantı `https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/<path>` biçimindedir. Aşağıdaki Git blob kimlikleri connector tarafından döndürülmüştür. Tam dosya isteğinin yapılması tam okunma/yürütme değildir: büyük dosyaların yalnız aşağıdaki anlam taşıyan işlevleri/aralıkları incelendi. Bu tur bu dosyalar topluca yerelde materyalize edilmedi.

| ID | Primary path | Git blob | Gerçek kapsam |
|---|---|---|---|
| M3-S01 | hermes_cli/cli_commands_mixin.py | 7061fdcc564214ac3236d0e6d54c19e9c2b9702e | SELECTED: imports/helpers; _handle_memory_command, _handle_skills_command, _save_write_approval. Full stored response içinde ilgili semboller ardışık retrieval ile açıldı. CLI çalıştırılmadı. |
| M3-S02 | gateway/slash_commands.py | bc7aaabb668f3067cbe8fa03a84efd67186a2fc6 | SELECTED: _write_approval_setter, _handle_memory_command, _handle_skills_command (3000-character truncation kuyruğu dahil); _cached_agent_for/_resident_agent_for. Gerçek gateway/UI çalıştırılmadı. |
| M3-S03 | gateway/run_adapters.py | 3ea22ad640118acdf8a69cd48c590e05a1e360d2 | SELECTED: 900–1170 wiring; 1190–1420 profile/default message wrappers, route rejection and scoped dispatch. Startup/reconnect gövdelerinin görünmesi runtime testi değildir. |
| M3-S04 | gateway/run_inbound.py | 1208221fc56dd161d9a17da33cbfae8d010b0b87 | SELECTED: _hm_admit_event, pre-dispatch hook, _handle_message giriş/idle dispatch bağlantıları; 650–910 command resolution/access/hook ve 910–970 handler-table dispatch. Tam inbound/adapter birleşimi çalıştırılmadı. |
| M3-S05 | gateway/run_busy.py | 57e19f825009bf3326dafe3e9a90d74a67cb9846 | SELECTED: 680–890 command tables/busy dispatch; 892–934 _check_slash_access; ayrıca 320–520 ve 1030–EOF içindeki karşılaştırma yüzeyleri. Tam dosya kapsamı veya bütün busy yolları iddiası yok. |
| M3-S06 | gateway/run.py | d6bfc83ec1271dbd3ee7193ca1b2af794b7844e5 | SELECTED symbols: _is_user_authorized_for_source, _gateway_config_home, _async_profile_runtime_scope; reset token kuyruğu. Scope helper'ın bütün secret-loader bağımlılığı çalıştırılmadı/denetlenmedi. |
| M3-S07 | gateway/authz_mixin.py | cd53d3aa3950abb0a7b291d623a843249059dba7 | SELECTED: 1–260, 260–590 isteğinin _is_user_authorized sonuna kadar görülen bölümü. Transport ownership, scoped-env reads, pairing source.profile lookup, grants/deny dalları. Kuyruk _get_unauthorized_dm_behavior tam okunmuş sayılmaz. |
| M3-S08 | hermes_constants.py | 353764b6ea5ed60418af0df246d412a949777e86 | SELECTED: ContextVar home setter/getter/reset, get_hermes_home/get_process_hermes_home ve fallback. Tam modül materyalizasyonu veya gerçek profil resolver testi yok. |
| M3-S09 | gateway/slash_access.py | 07204201e411f29f912bb9bba6beec0566acab9d | FULL READ + yerelde 5666-byte Git hash eşleşmesi + bu tur SA01–SA08 EXECUTED. Yalnız stdlib; config/source nesneleri sentetik. |
| M3-S10 | tests/gateway/test_slash_config_writes_routed_profile.py | c1893156f527d06cde26e74172f98654286f3e34 | FULL READ / TEST SOURCE INSPECTED, NOT EXECUTED. Test profile scope'u elle açıyor, source=None event ve cache eviction no-op kullanıyor. |
| M3-S11 | docs/design/multiplexing-gateway.md | cb9c5da63e6314aa1171b904d0a4f520feac640c | FULL READ / TARGET DESIGN CLAIM. Kaynak zincirine navigasyon; canlı uygulama garantisi değildir. |
| M3-S12 | agent/system_prompt.py | 9bd52f03fc7568990f2bf157dc1301f9c81adbbb | SELECTED: 1–230; 430–495 _memory_parts; 530–EOF build/invalidate/reconstruct. 850+ boş yanıt EOF dışında istektir; yeni kaynak kanıtı değildir. |
| M3-S13 | agent/turn_context.py | 6dfad44e56d2cde0868d4d728b5a0eda33f8dc81 | SELECTED: 1–240, 460–640, 720–875. build_turn_context cached-prompt koşulu source-backed; bütün wire/provider request gözlemi yok. |

M3-S01/S02'nin sembol okumaları connector'ın saklanan tam yanıtındaki retrieval üzerinden açıldı; source line ranges'ini uydurmak yerine sembol sınırı kaydedildi. Diğer aralıklar source line numaralarıdır, chat JSON satır numaraları değildir.

## Önceki arşivin bu tur yeniden kullanımı

M2 paketinin yerel ZIP kopyası açıldı; README, SOURCES ve RESEARCH sınırları yeniden okundu. `write_approval.py` staging/list/get/discard ve `write_approval_commands.py` common handler/apply/cleanup bölümleri source zincirini birleştirmek için tekrar okundu. Bu iki arşiv dosyasının Git blob'ları sırasıyla `f1e99b46e934595c002c2bc659143fcbc1f9fe8d` ve `150b72dfd17696ab7a64f97057b7405128f5b352` olarak yerelde yeniden hesaplanır. M2'nin N01–N12 koşusu BU TUR TEKRARLANMADI. N11 cleanup ve N02/N09 live-store bulguları eski, scope-bound girdidir.

## Yeni koşunun tam sınırı

Sadece S09 ithal edilip çalıştırıldı. Büyük CLI/gateway/run/authz/system_prompt modülleri testte çalıştırılmadı. SA senaryolarının source/config nesneleri `SimpleNamespace`; gerçek kullanıcı, platform doğrulaması, profil/sır dosyaları, pending write, model/provider ve network yok. Source hash kontrolü importtan öncedir. İlk transkripsiyonda docstring'deki dört gereksiz escape byte'ı hash uyuşmazlığı verdi; kaynakta görülen gerçek quote biçimine dönülünce beklenen sabit hash elde edildi. Beklenen hash değiştirilmedi; ilk uyuşmayan dosya import edilmedi. Ayrı kasıtlı bir-byte değişiklik gerçek guard tarafından reddedildi.

## Freshness ve erişim

Default-branch araması bu tur `425b00174d0ad7f311819695e86684376b76b008` ve sonra `cfdbbb6e35010ace89fbe8243ee82fa4de143e10` sonuçları döndürdü. Bunlar yalnız dosya bulmak içindir; bütün yük taşıyan kaynaklar tekrar primary pin'den açıldı. Current HEAD davranışı veya kurulu release doğrulanmadı.

Raw URL'nin yerel otomatik indirilmesi DNS/cache/download erişim hataları verdi; bununla source'un GitHub connector üzerinden okunabilirliği karıştırılmadı. Tarihsel okuma/yazma hataları ürün kusuru değildir. Bu tur teknik analiz pinned GitHub kaynakları ve tek exact local module execution'a dayanır; başarısız web okumaları teknik kanıt değildir.
