# U12-A — Kaynak ve okuma kapsamı

**2026-09-13 / SOURCE ONLY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Aralıklar native dosyanın 1-based satırlarıdır. FULL READ metin görme kapsamıdır; full-byte materyalizasyon, dependency closure veya execution değildir. [Araştırma](TOOL-ADMISSION.md).

| ID | Immutable kaynak / blob | Gerçek kapsam |
|---|---|---|
| S01 | [agent/tool_executor.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/tool_executor.py) / `799199c10f9930da77c01da2324373614b27cb78` | FULL READ: 1–220,220–470,470–730,730–990,990–1260,1260–1510,1510–1800(EOF). Policy/middleware, sequential/concurrent/segmented, timeout/result/persistence. Bütün import closure değil. |
| S02 | [agent/turn_tool_round.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/turn_tool_round.py) / `daa009ac80bba9c2cb7eab5da0babae2cc117be0` | SELECTED 1–250: run_tool_round tam; stage_tool_call_message başlangıcı, tail okunmadı. |
| S03 | [agent/turn_tool_validation.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/turn_tool_validation.py) / `db3e89334ebb4302f55357e8063c28f5758becd5` | FULL READ 1–260(EOF). İsim/ID/JSON/mixed-batch/partial-exit; NOT RUN. |
| S04 | [model_tools.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/model_tools.py) / `50944003ed74f0b7147cfe0a22a9473944940c10` | SELECTED 1–250,250–500,540–805,800–1070(EOF). Definitions, bridge, guard/middleware, handler dispatch, post/transform. 501–539 context-length helper tamamı değil. |
| S05 | [tools/registry.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/registry.py) / `b82ae4aeeae9516b3485ec8a8eb5a818d01506a4` | SELECTED 1–220,425–650,650–910. Discovery, ToolEntry, registration/restore/get_entry/definitions/dispatch; scope-merge/check_fn cache iç gövdelerinin bütünü değil. |
| S06 | [tools/file_tools.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/file_tools.py) / `75e8663c50a9899f59146b8335dbb1ac0e341f1b` | SELECTED 1–230,340–585,580–740,1100–1320(EOF). Read handler ve read_file_tool tam; registration bağlantısı, file-ops tail, diğer helpers seçili. 1320–1550 isteği boş/beyond EOF, okuma kapsamı değildir. ShellFileOperations/OS/gerçek dosya okunmadı. |
| S07 | [agent/tool_dispatch_helpers.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/tool_dispatch_helpers.py) / `f994ecfab247490695d75211f93f55688166dc6d` | SELECTED 1–265. Planner, scope/path overlap, bridge peeling; file-mutation-target extraction ve result-wrapper tail ayrı açılmadı. |

## Canonical recovery ve reusable kaynaklar

AGENT ve R01–R09 bu tur canonical main'den tam okundu; control araştırma kanıtı değildir. İlk main ead0d6775bd49808afbf496292f526cae1fb20df, U11 STATE ve current catalog tam geri okundu. U11 makbuzundan fark yalnız Foundation/harness/catalog/index yollarında: aynı conversation'da tam okunmuş root/METHOD/META/INDEX/PLAN/U11 A-B/SOURCES/NOT RUN ve synthesis02/04 değişmeyen sürümleri yeniden kullanıldı.

U04 note19, B README/RECONCILIATION/33-file DELIVERY-MANIFEST, synthesis03, A SOURCES ve RESEARCH (1–95 isteği truncated;80–EOF ile tamamlandı), CONTINUITY-COVERAGE bu tur yeniden tam okundu. Eski raw koşulara yeni test hükmü verilmedi. U10/U11 completed yayınlardır; prepared metinleri tarihsel.

U11'in S13 run_agent.py blob `37b25fd21425f5592f00a0d351abd31743419111` içindeki _execute_tool_calls/_dispatch_delegate_task forwarder okumaları reuse edilir. Native stateless MCP karşı sınırı U11 S15 `48909a026c142ba9c7ae829fbd2c4307d26a1e64` tam okumasıdır. Bu reused okumalar yeni bağımsız kanıt veya bütün caller closure değildir.

## Erişim, freshness ve çalıştırılmayanlar

Resmî mutable delegation belgesi ve default-branch search yalnız navigation/context için kullanıldı; source hükümleri yukarıdaki pin'dendir. Yeni search `d595e636c83aa0b9606d4e914e1140ae9c796897` pointer'ını verdi; current fix doğrulaması veya primary upgrade yapılmadı.

Bir public raw urllib denemesi DNS Temporary failure in name resolution ile başarısız oldu. Kaynaklar connector'dan okunabildi; tam yerel byte kopyası oluşmuş sayılmadı. Hiçbir credential/izin değişikliği veya erişim kısıtı dolaşımı yoktur. Araştırmacının araç erişim sorunu, HERMES bulgusu değildir.

Yeni behavioral execution, HERMES import, full tool/child/provider/DB/SDK/OS koşusu ve upstream suite YOK. Bu yüzden RESULT veya test skoru yoktur. Source comments'teki tarihsel olay/sayılar bağımsız saha ölçümü olarak kullanılmadı. Yayın/ref/diff/readback kontrolleri yalnız aktarım ve süreklilik doğrulamasıdır.
