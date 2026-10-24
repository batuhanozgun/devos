# U11 — Kaynak ve okuma kapsamı

**2026-09-12 / Dilim A / SOURCE ONLY.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. GitHub connector okumaları aşağıdaki immutable path/ref/blob ve gerçek aralıklarla bağlanmıştır. Satır aralıkları repository dosyasının 1-based aralıklarıdır; web parser satırları değildir. Kaynak okuma, byte materyalizasyonu, dependency closure ve execution ayrı statülerdir.

| ID | Immutable kaynak / Git blob | Gerçek okuma |
|---|---|---|
| S01 | [hermes_cli/runtime_provider.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/runtime_provider.py), `db1d8dc8bcc084e49ebef6c7055c77d6b1440c0c` | SELECTED. İlk full-file yanıtında başlangıç, API-mode helper'ları, _maybe_apply_codex_app_server_runtime ve runtime-builder girişleri görüldü; full file denmez. 400–660 yanıtında pool/explicit builders ve OAuth başlangıcı; sonu truncated, OAuth devamı 640–780 ile kurtarıldı. 780–EOF resolver/ladder/compat tam okundu. Exact kullanılan semboller RESEARCH içinde. |
| S02 | [agent/agent_init.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/agent_init.py), `562dfcc32866840ab9c84244595927239b790bd7` | SELECTED: 1–240, 300–500, 755–1035; 2010–EOF yanıtı init ortasında truncated, devamı 2280–EOF ile kurtarıldı. Routing/client/primary snapshot/init orchestrator okundu. Bütün compression/config helper'ları veya alt SDK'lar tam okunmadı. |
| S03 | [agent/turn_facade.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/turn_facade.py), `5f147c62cf99cc35c6a92399db9f67a148ab465b` | FULL READ; 1–260 isteği EOF'u içerdi. Admission→inner loop→finally ve Codex forwarder. Alt lease/relay bağımlılıkları yeniden tam doğrulanmadı. |
| S04 | [agent/conversation_loop.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/conversation_loop.py), `2e88c103275d756cfe8cb0e092b309f5f4406cb2` | SELECTED: 1–270, 400–690, 900–1150; asıl run_conversation 1380–1478 + 1450–EOF örtüşen okumalarla tam görüldü. Normal loop dispatch ve Codex early return incelendi; bütün phase helper'ları okunmadı. |

## Canonical recovery ve reuse

AGENT main'den taze okundu; blob değişmedi. Aynı conversation'da tam canonical okunmuş R01–R09 sürümleri uygulanır, araştırma kanıtı değildir. Current ref/STATE/METHOD/META/INDEX/catalog/root router geri okundu; v0.23 plan ve U10 PUBLICATION mevcut aynı-conversation full read + unchanged path kontrolüyle korundu. Başlangıç state/plan yayını d3a4baeeb7afd97d38588c674c4842f01e87c6f0 main/ref ve değişen içerik geri okumalarıyla bağlandı; yalnız iki HERMES dosyası.

U10 SOURCES, RESEARCH 1–63 +64–EOF, NOT RUN; synthesis02 ve synthesis04 yeniden okundu. Note25 önceki aynı-conversation immutable full read'dir. U04–U10'un eski ham koşularına yeni hüküm verilmedi veya tekrar koşulmadı; korunmuş raw kimlikleri current STATE rotalarındadır.

## Erişim ve güncellik

Default-branch search, `b7b35a84b7fbe1aa2e223a6ce726a2471300d0a4` üzerinde Codex runtime/session/doc pointer'ları verdi. Yalnız navigation; current fix/release/adoption revalidation değil. Primary yükseltilmedi.

S02 raw public URL'si web üzerinde açılabildi; parser 2193 satır bildirdi (blank-line dönüşümü nedeniyle native satırlarla aynı sayılmaz). Tam yerel byte indirmesi başarılı olmadı. S04 raw web isteği cache-miss verdi. Bu araç hataları pinned connector source okumalarının yerine yokluk kanıtı yapılmadı. Alternatif credential veya izin denemesi yok; çalışma kaynak-only olarak sürdü.

Yeni behavioral execution yok. Hiçbir HERMES modülü import edilip çalıştırılmadı; API/credential/model/client/subprocess ve upstream test suite koşulmadı. Bu nedenle RESULT.json veya başarı sayısı üretilmedi. Local hash/link ve yayın kontrolü ileride yapılırsa source davranış deneyi sayılmaz.
