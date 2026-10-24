# U13-A — Kaynak, okuma kapsamı ve sürüm ayrımı

**2026-09-13 / SOURCE ONLY.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Araştırma](RESEARCH.md). Satırlar 1-based primary dosya aralıklarıdır. SELECTED, full dependency/byte materyalizasyon veya execution değildir.

| ID | Immutable primary path / Git blob | Gerçek okuma ve kullanım |
|---|---|---|
| S01 | `tools/async_delegation.py` / `99330e84f76c043293bbf7a1e1a5c531b4436bca` | U12-B S15 aynı-conversation FULL READ yeniden kullanıldı: producer, dispatch ledger, restore/age, claim/complete/release/drop ve interim. Yeni run yok. |
| S02 | `tools/process_registry.py` / `7a0fe442e385683c1164a337d7e8a8b4c4c4cddf` | SELECTED: full request'in görünen başı; doğrudan400–650 constructor restore,1190–1430 actual owns/drain. Navigasyonda650–890,1450–1720,1800–2130(EOF) de açıldı; bunlar full-process audit değildir.2400–2700 boş, kanıt değil. Stored response find yalnız navigation. |
| S03 | `tools/process_registry_notifications.py` / `0e7f82f5e42746c586ec7301a1d69e04e0e56ffa` | SELECTED1–260: delegation single/batch/interim formatter, UI text ve SubagentNotification. Genel process formatting tail ayrı açılmadı. |
| S04 | `tui_gateway/session_notifications.py` / `6524f3e3f11bae3becb988383fddeca635375738` | SELECTED1–250,330–610(EOF): ownership, compression route, dedup, idle-slot, submit, dispatch, poller ve display.251–329 Kanban gövdesi bu tur okunmadı. |
| S05 | `tui_gateway/prompt_turn.py` / `f89bbe8855da9caf31c1de7ea6717bb59ef905f0` | SELECTED1–250,260–417,400–670,690–860,820–1100(EOF): admission ve gerçek bool, postturn helper, scopes/history, invoke_agent, thread schedule/refusal, completion/finalization selected.251–259/671–689 tamamen açılmadı. |
| S06 | `cli.py` / `ab355e2036766d1658c83446bc82477bea3ed65e` | SELECTED1–200 import/MRO girişleri,2900–3130 navigation,3230–3452 owns/drain,3450–3690 actual input/idle/postturn/chat. Yeni ayrı notifications dosyası pin'de yok. |
| S07 | `hermes_cli/cli_chat_turn_mixin.py` / `86b04712fdfbc8f800bbc738ea8d67536ecc4c86` | SELECTED1–230 ve270–435: credential/init→stage→thread→run_conversation/history. Render/settle tüm tail açılmadı. |
| S08 | `agent/turn_facade.py` / `5f147c62cf99cc35c6a92399db9f67a148ab465b` | FULL READ1–240(EOF): actual run_conversation durable lease→history substitution→loop/scopes/finally. Alttaki tüm lease/DB kaynaklarını yeniden çalıştırmadı. |

Her primary path şu köke göre açılır: https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/ . U12 S08/S10 delegation request→goals/context aktarımı ve U05/U06 history/lease sonuçları re-used bounded kaynaklardır; yeni ampirik kanıt değildir.

## W01 — ayrı mutable doküman

2026-09-13 web search ile resmî `https://hermes-agent.nousresearch.com/docs/user-guide/features/delegation` ve `https://hermes-agent.nousresearch.com/docs/guides/delegation-patterns` delegation/completion/lifetime bölümleri görüldü. Arama çıktısı selected navigation/context olarak kullanıldı; full primary implementation değildir. Messaging gateway admission ile model-completion ayrımı current doküman iddiasıdır. Pinned source'a fix veya bütün host eşdeğerliği taşınmadı. Üçüncü taraf haber sonucu kanıt olarak kullanılmadı.

Default-branch search205645ee…,baf1200e…,d21913b0… pointer'ları navigation sağladı; içerik hükümleri yukarıdaki immutable pin'den. `hermes_cli/cli_process_notifications.py` primary pin'de404; gerçek consumer S06 içinde bulundu. Bir public raw urllib denemesi Temporary failure in name resolution verdi; full local source byte download gerçekleşmedi. Erişim/yetki/credential değiştirilmedi.

## Preflight ve yayın

Main74c5e3d1dcd260a1841c64dda5fb1d182f7bb299, önceki U12 makbuzuyla aynıydı. Güncel AGENT tam getirildi; R01–R09 ve U12 current/source/mandatory U04 ayrımı aynı-conversation değişmeyen tam metinlerden reuse edildi. Research root, METHOD ve synthesis02/04 yeniden tam okundu (02 yanıtında yalnız trailing URL metadata truncated; gövde EOF'ye kadar görünür). Control dosyaları araştırma kanıtı değildir.

Başlangıç planı899422ceba05f7b6a577b35baf6a985c317b7cf7 main/ref/tam içerik ve tek-path compare ile doğrulandı. A'da yeni import/behavioral run/RESULT yoktur. Sonradan yapılacak dar diagnostic kendi seçim/fixture/oracle/ham sonuç kaydını taşımalıdır; A bu yüzden geriye dönük EXECUTED yapılmaz.
