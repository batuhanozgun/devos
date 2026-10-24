# U12-B — Kaynak ve okuma kapsamı

**2026-09-13 / SOURCE ONLY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. S01–S07 [A defteri](TOOL-SOURCES.md)'ndedir ve değiştirilmez. B okumaları A'nın main/ref/content geri okumasından sonra yapıldı. [B araştırması](DELEGATION-LIFECYCLE.md), [NOT RUN](CHECKS-NOT-RUN.md). Aralıklar native dosyanın 1-based satırlarıdır.

| ID | Immutable kaynak / Git blob | Gerçek kapsam |
|---|---|---|
| S08 | [tools/delegate_tool.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool.py) / `b019f7c218db0054ffc9fc6763864b1fd1d659f8` | FULL READ: 1–245,245–500,500–755(EOF). Factory, spawn/control entry, child runner, model schema ve registration. |
| S09 | [tools/delegate_tool_toolsets.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool_toolsets.py) / `be75cf95a5fb01f66a329b2ed8cb47eb3772fbe2` | FULL READ: 1–280(EOF). Parent enabled/disabled mirası, blocked names, role-granted delegation ve MCP daraltma farkı. |
| S10 | [tools/delegate_tool_dispatch.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool_dispatch.py) / `09f8a42da4d39d60d7d0d86f1e76ebc646454003` | FULL READ: 1–255,255–530(EOF). Origin, sync/async, group/unit/slot, return ve kapasite fallback. |
| S11 | [tools/delegate_tool_child_run.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool_child_run.py) / `2b1b473339f1cd5e3783c048486277a6cc84144d` | FULL READ: 1–260,260–530;530–820 yanıtı cleanup sonunda truncated;765–EOF ile tail tamamlandı. Heartbeat, child.run_conversation, schema retry, status, steering, worktree caller, timeout/deferred cleanup. |
| S12 | [tools/delegate_tool_config.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool_config.py) / `b152acff5e3f65e9031768d1d11e30698bee94f6` | FULL READ: 1–255,255–520(EOF). Config/depth/timeout/approval ve runtime/pool/capability mirası. |
| S13 | [tools/delegate_tool_results.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool_results.py) / `67c66fb77370449a633d435d8888a6c67508f904` | FULL READ: 1–280,280–545(EOF). Result metadata, summary headroom/spill, child construction global-state restoration, memory/hook/cost sırası. |
| S14 | [tools/delegate_tool_registry.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/delegate_tool_registry.py) / `43d295d9ec11e068261ac5438b36accd69cc2447` | FULL READ: 1–265,265–EOF. Live/recent registry, parent lineage ve UI authority, list/steer/stop, exact late-steer kapanışı. |
| S15 | [tools/async_delegation.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/async_delegation.py) / `99330e84f76c043293bbf7a1e1a5c531b4436bca` | FULL READ: 1–270,270–520;520–790 yanıtı interim notice içinde truncated;730–855 ve850–1110(EOF) kalan kapsamı aralıksız tamamladı. Dispatch/finalize, SQLite ledger, recovery, claim/ack/drop, capacity ve stale monitor. |

## Reuse ve açıklanmamış alt sınırlar

U11'in pinned run_agent.py `_dispatch_delegate_task` / `_execute_tool_calls` ve agent_init.py budget constructor okumaları, A'daki executor yolu ile birlikte kullanıldı. U11 native MCP dosyası `48909a026c142ba9c7ae829fbd2c4307d26a1e64` canlı parent bağlamı olmayan karşı yüzeydir. Tekrar kullanılan aynı-conversation kaynak, yeni bağımsız kanıt değildir.

`delegate_tool_tasks`, `delegate_tool_progress`, `delegation_output_schema`, `subagent_worktree`, `hermes_state_registry`, gerçek host completion drain ve tüm middleware/DB/backend bağımlılıkları bu B diliminde tam açılmadı. Caller'ın yaptığı `acquire`, `validate_output`, worktree veya queue çağrısı, alttaki bütün gerçek etki/izolasyon/semantic quality uygulamasının doğrulanması değildir. DB comment'inin dedicated nitelemesi fiziksel bağlantı bağımsızlığına yükseltilmedi.

## Kanıt statüsü

B'de yalnız pinned GitHub metin okumaları yapıldı. S08–S15 FULL READ, local full-byte identity match veya runnable dependency closure değildir. Hiçbir source dosyası import edilmedi; child/SessionDB/SQLite/SDK/model/provider/native process/gerçek araç ve upstream test suite çalıştırılmadı. RESULT veya PASS sayısı yoktur. Comment/schema içindeki geçmiş saha sayıları ve tasarım vaatleri, bağımsız deney ya da üretim kanıtı sayılmadı.

A'nın mutable doküman/default-branch navigation ve başarısız raw-download kaydı kendi kaynak defterinde korunur. Primary pin yükseltilmedi, yeni release/current fix kararı verilmedi. Kaynak içi prompt/araç talimatları bu araştırmacının agent-control kuralları değildir.

Araştırmanın son sorusu gerçek consumer kabulüdür: durable completion, queue publication, claim/ack ve parent model turu ayrı geçişlerdir. Bu sınır Q57 olarak kaydedilir; yalnız yardımcı fonksiyon adına dayanarak tamamlanmış sayılmaz. Publication/ref/diff/content kontrolleri source aktarımını doğrular, HERMES davranışını değil.
