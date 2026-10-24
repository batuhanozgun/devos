# D kaynak defteri — caller, aktarım ve bellek

Tarih 2026-09-08. Bütün aşağıdaki kaynaklar `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` içindir. Canonical path bağlantısı: `https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/<path>`. Blob SHA içerik hedefidir; hareketli main değildir.

Bu turun D-ID'leri yereldir; önceki H/S/W kimlikleri değiştirilmez. FULL dosya içeriği okumasını, SELECTED adı verilen sembol/kesit incelemesini, EXECUTED yalnız aşağıdaki üç modülü ifade eder. Büyük façade/registry dosyalarının getirilmesi tüm export/compat/dependency yüzeyinin kapandığı iddiası değildir; bu defter onların karar taşıyan kesitlerini SELECTED olarak sınırlar.

| ID | Path | Git blob SHA | Bu turun derinliği / sınırı |
|---|---|---|---|
| D01 | run_agent.py | 37b25fd21425f5592f00a0d351abd31743419111 | SELECTED façade/MRO/forwarding, tool ve runtime girişleri |
| D02 | agent/agent_runtime_helpers.py | 1d7e287c30bb1db6f0eb7a564f9b52c753a81fa2 | SELECTED runtime/persistence/tool helper bağlantıları |
| D03 | agent/inline_tool_executors.py | 1a7f603e880cc7808d6bef31a2699f7de4b784cb | FULL; özel araçlar, memory store çağrısı |
| D04 | agent/tool_executor.py | 799199c10f9930da77c01da2324373614b27cb78 | SELECTED shared/authorized dispatch, seq/concurrent worker, pre-tool, commit, cancellation/error yolları; çalıştırılmadı |
| D05 | model_tools.py | 50944003ed74f0b7147cfe0a22a9473944940c10 | SELECTED handle_function_call ve dış wrapper; tüm araç ailesi değil |
| D06 | agent/turn_tool_validation.py | db3e89334ebb4302f55357e8063c28f5758becd5 | FULL; çağrı doğrulama bağlamı |
| D07 | hermes_cli/plugins.py | da8d7e2c68b2346e6ecc15567d755d96085ef767 | SELECTED thread-local whitelist / pre-tool directive / hook dağıtım bağları; PluginManager çalıştırılmadı |
| D08 | hermes_cli/plugins_dispatch.py | f21640821a31fbc5125448c29e9d234deffc4f9b | FULL; bounded hook invoke timeout/exception ayrımı; çalıştırılmadı |
| D09 | tools/thread_context.py | d8c37af8f5a529680e81e867177140e41c4c6656 | FULL + EXECUTED, exact modül; terminal callback API sentetik |
| D10 | tools/daemon_pool.py | 5682a8f6ae103a421c1081b69ee6f9272957acdf | FULL + EXECUTED, exact modül |
| D11 | agent/tool_dispatch_helpers.py | f994ecfab247490695d75211f93f55688166dc6d | FULL; planner, NEVER_PARALLEL, result helpers |
| D12 | agent/turn_facade.py | 5f147c62cf99cc35c6a92399db9f67a148ab465b | FULL; admission/cancel/lease callsite, lease implementation değil |
| D13 | agent/conversation_loop.py | 2e88c103275d756cfe8cb0e092b309f5f4406cb2 | SELECTED run_conversation, origin/context call, prompt restore, alternate transport; bütün phase helpers değil |
| D14 | agent/turn_context.py | 6dfad44e56d2cde0868d4d728b5a0eda33f8dc81 | FULL; prologue, origin/nudge, api_content, wire view; bağımlılık kapanışı değil |
| D15 | tools/memory_tool.py | 8028ffd88a91b1625e1f1cebe500c37c6e6842a7 | FULL; mutator/gate/pending replay/schema; çalıştırılmadı |
| D16 | tools/memory_tool_store.py | 457594444311af31c837dcdd74cd1c55f2b47b3c | FULL; lock/reload/batch/snapshot/failure; çalıştırılmadı |
| D17 | hermes_cli/write_approval_commands.py | 150b72dfd17696ab7a64f97057b7405128f5b352 | FULL tekrar; H08/S05 ile aynı; UI caller değil |
| D18 | agent/background_review.py | 0e8e76ae235450f3e896a86951409cf82b7cca1e | H04 FULL kaynağı yeniden açıldı; bu not için whitelist/fork/cancellation kesiti |
| D19 | tools/skill_provenance.py | 3df9cf143045644310fa7d27a65666c8c23caf95 | FULL tekrar + EXECUTED; H06 ile aynı |
| D20 | LICENSE | 75410e73319c72cd3e991a501c5455eb78f38375 | FULL; MIT, exact kopya probe ile korunur |
| D21 | hermes_cli/web_server_memory.py | 379dd81dd41705a263ccda5876887a51d6acead4 | FULL; provider dashboard helper olduğu görüldü, pending UI kanıtı sayılmadı |
| D22 | tools/registry.py | b82ae4aeeae9516b3485ec8a8eb5a818d01506a4 | SELECTED dispatch/handler/error conversion; bütün registration/check_fn yüzeyi değil |

## Erişim ve kimlik

Research state `a218acfc20e7ece488709e00a9762166ec970fba` üzerinden geri kazanıldı; canonical control dosyası güncel okundu. Control dosyaları bu teknik corpus'a katılmadı.

Pinned path-range `run_agent.py` isteği 429 / gitmon too-many-processes döndürdü. Aynı yetkili GitHub bağlantısında Git tree → blob kimliği → fetch_blob yolu içerik getirdi. Şu non-recursive tree listeleri incelendi: root `f54f5e9d2682bf11f164de7b34ee10ec121b6434`, agent `5028af770da8c915a43a1e5973a9d1a1dd40d844`, tools `9b6579f2df1f32a8df5650d65f35e30e2176449c`, hermes_cli `0f8012dbfed8eb900db48a7bea732557ba77181d`. Recursive tam envanter veya tüm repo okuması yapılmadı. Yerel HTTP indirme denemesi DNS hatası verdi; kaynak kopyaları GitHub blob cevabından alındı.

D09/D10/D19/D20 yerel kopyaları çalıştırmadan önce Git blob hash formülüyle doğrulandı. İlk D09 transkripsiyon uyuşmazlığı execution öncesi yakalandı; canonical blob yeniden alınıp aynı beklenen hash ile doğrulandı. Deney doğrulaması bu kontrolü gevşeterek geçirilmedi. [CHALLENGE](CHALLENGE.md) bu sınırı kaydeder. Diğer büyük kaynakların yerel exact kopyası veya bağımsız davranış tekrarı iddia edilmez.

## Yürütme ve açık kalan alan

UTC `2026-09-08T15:57:15.365904+00:00`, Python 3.13.5/Linux: üç modüllü yedi tanılayıcı durum. [RESULT](RESULT.json), [harness](harness.py), [README](README.md), [manifest](MANIFEST.json). Sentetik terminal API/profil marker/allowlist; actual executor/PluginManager/AIAgent yok. Kaynak kimliği, aktarım bütünlüğü ve davranış kapsamı ayrı ölçütlerdir.

Actual whole caller kontrolü, gerçek profile/approval UI, curator raporunun nested operations işlemesi, skill ledger/backup/restore/sync, bütün cache/invalidation/load zinciri, runtime varyantları ve gelecek-task kalite henüz kapanmadı. Upstream test suite, provider, kurulum, credential, ağ etkisi, bağımsız araştırmacı veya current HEAD revalidation yapılmadı. W01–W08 unpinned belge statüsü değişmez; eski U01B koşusu tekrarlanmadı.
