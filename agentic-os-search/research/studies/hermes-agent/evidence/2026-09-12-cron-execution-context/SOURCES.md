# U10 — Kaynak, yürütme ve erişim defteri

**2026-09-12.** Project baseline `938359a1c4b0a01dd7bab5f4647e0474872b2078`; primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Manifest 0.21.0, güncel release/kurulu ürün değil. S ID'leri yalnız U10'a aittir. [RESEARCH](RESEARCH.md), [SPEC](SPEC.md), [RESULT](RESULT.json), [MANIFEST](MANIFEST.json).

## Pinned kaynaklar ve gerçek okuma

| ID | Immutable kaynak ve Git blob | Kapsam |
|---|---|---|
| S01 | [cron/scheduler.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler.py) — `3a1b3839521b3a6fcb687c4875d446b184a82f20` | SELECTED: 1230–3100 içindeki caller/helper gövdeleri, örtüşen range okumaları; 3800–EOF split-module bağları. 300–660 yanıtında görülen toolset işlevleri seçili; tüm aralık full-read değildir. 1–220 ve 660–930 ek navigasyon/incidental. Büyük parent full-byte/AST materyalize edilmedi, NOT EXECUTED. |
| S02 | [cron/scheduler_prompt.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_prompt.py) — `91d673649d6dca8ba3120d10671a8966e67a01ce` | FULL READ: 1–245 + 245–EOF; 350 satır, 16.049 byte. FULL BYTE MATCH; yalnız _inject_context_from BOUNDED EXECUTION. Diğer işlevler source-only. |
| S03 | [cron/monitor.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/monitor.py) — `301bb39918d198f92ec9700151195f8c5aab7003` | FULL READ 1–EOF (1–260 isteği); source/hash/snapshot/persistence. NOT EXECUTED. |
| S04 | [cron/notepad.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/notepad.py) — `a84c37b36311f55e0f73e554abe1108867fa7944` | FULL READ 1–EOF (1–260 isteği); profile/job-keyed SQLite ve prompt render. Alt executions helpers/SQLite NOT EXECUTED. |
| S05 | [cron/scheduler_script.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_script.py) — `04e66ae8eff510ab4631f22b8a39033a5add42ed` | FULL READ 1–275 + 275–EOF (545 isteği). Path/interpreter/cwd/Popen/timeout/redaction/heartbeat. NOT EXECUTED; env-builder/process-kill bağımlılıkları full closure değil. |
| S06 | [cron/scheduler_preflight.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_preflight.py) — `d964132dc7a060b0331fc8bb70fe6d0595f0ec4a` | FULL READ 1–225 + 225–EOF. Affirmative-only checks, fallback/presence/route ayrımı. NOT EXECUTED. |
| S07 | [agent/agent_init.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/agent_init.py) — `562dfcc32866840ab9c84244595927239b790bd7` | SELECTED: 1030–1415 tools/session/memory tüketicileri; 2000–EOF içinde init_agent orkestrasyonu tam görüldü. 1–205, 1690–1910 incidental routing/context helpers; 480–755 yanıtı truncated, görünen state tables dışında full range sayılmadı. NOT EXECUTED/full dependency closure yok. |
| S08 | [cron/scheduler_detached_worker.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_detached_worker.py) — `921a5e6f2004cc22ebfefdd0eae8afc33e6d6603` | FULL READ. Future-dependent deferred teardown. NOT EXECUTED. |
| S09 | [run_agent.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/run_agent.py) — `37b25fd21425f5592f00a0d351abd31743419111` | SELECTED 240–370: __init__ forwarder, lazy recall DB, _ensure_db_session. Full-file request truncated; bütün facade okunmuş sayılmaz. NOT EXECUTED. |
| S10 | [LICENSE](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/LICENSE) — `75410e73319c72cd3e991a501c5455eb78f38375` | FULL READ + BYTE MATCH. MIT notice raw arşivde; davranış kanıtı değil. |

FULL READ, byte materyalizasyonu, dependency closure ve execution aynı statü değildir. **Bu tur yalnız S02 selector işlevi çalıştırıldı.** Raw arşiv S02/S10'u içerir; diğer büyük parent dosyalarının tam yerel kopyaları varmış gibi davranılmamalı. Kaynak yorumlarında anlatılan eski saha olayları bağımsız olay kanıtına çevrilmedi.

## Canonical devralma ve önceki kanıt

Güncel main/AGENT ile U09 STATE, root research/studies router ve catalog, Hermes META/INDEX, U09 SOURCES/NOT RUN, güncel MAP/OPEN-QUESTIONS/SOURCE-LEDGER tam geri okundu. Aynı konuşmada tam okunmuş METHOD, v0.22 plan, U08/U09 RESEARCH ve yayın makbuzları korundu; yeni çalışma eski ZIP/yayın tekrarı değildir. R06 canonical protokolü tekrar tam yüklendi; aynı konuşmanın değişmemiş diğer zorunlu protokolleri uygulandı. Agent-control araştırma kanıtı değildir.

Yeni synthesis04 için synthesis03 ve note22 tekrar tam okundu; U08 note23/source/RESEARCH ve U09 note24/RESEARCH önceki aynı-conversation canonical okumalarına bağlandı. U07/U08'in exact deney iddiaları kendi SPEC/RESULT/MANIFEST/ham arşivlerine yönlendirilir; yeni C testleri onların tekrarı değildir. U04-A/B eş numaralı vakalar birleşmez; 33 özgün B dosyası korunur.

## Yeni yürütmenin kimliği

S02 SHA-256 `bc5fecf6dc019ad7dec221c4a0913685d07e33a3a9a974e5fca0cb5962c6654c`.
SPEC SHA-256 `3d9e523beef612f0e9f150187817bb0ce6293bd6fca85210b2e251c98a4fa472`.
Probe SHA-256 `d73dc4640fce950ef6b073eab1d9ee4d4398afa6172f7b4032909ffe2c22e428`.
Raw RESULT SHA-256 `cdf30b7cb1b599b3b87d2d757bfaa26ed93508669f0c26f0b6c639b95b0537f7`.
Recorded UTC `2026-09-12T07:25:53.109130+00:00`–`2026-09-12T07:25:53.118497+00:00`; Python 3.13.5.

C01–C06 gerçek pathlib/glob/stat/read ve fixed-mtime yerel fixture'larla çalıştı. Synthetic root ve kullanılmayan import seams açık; seçim kararını fake üretmedi. N00 identity, N01/N02 explicit source mutation kontrolleri. Predeclared expectations karşılandı; immutable fixture byte/mtime readback eşleşti; raw stderr 0 byte, audit violation yok. Bir başarılı behavioral run; istatistiksel başarı oranı veya bağımsız replication değil.

Attempt-00, probe son print ifadesinde sözdizimi hatasıyla parse aşamasında durdu; target/fixture/case başlamadı. Yalnız kapanış işareti düzeltildi; SPEC/source/oracles değişmedi. Özgün probe/log ve HARNESS-REVISION arşivde. Yerel tar/hash/link kontrolleri yeni davranış deneyi değildir.

## Erişim, güncellik ve kapsam

Raw download için tek urllib girişimi DNS Temporary failure in name resolution ile kullanılabilir kaynak üretmedi. Credential/endpoint dolaşması yapılmadı. S02, başarılı pinned connector tam metninden materyalize edilip Git kimliğiyle doğrulandı. Bu ortam engeli source-only diğer dosyaların okunmadığı anlamına gelmez; onları full-byte executable closure yapmaz.

Default-branch search bu tur `28326a6ccd7484f37bbcd19c9f32658c2368b370` üzerinde prompt/monitor/init/toolset pointer'ları döndürdü; navigation only. Resmî mutable cron/automation docs araması, yeni-session açıklamasını ve daha yeni continuity ifadelerini navigasyon olarak gösterdi; current fix/release doğrulaması yapılmadı. Pin yükseltilmedi. Harici AGENTS/prompt metni researcher control olarak kullanılmadı.

Native GitHub write eylemleri bu tur sunuldu. Gerçek yayın sonucu PUBLICATION'dan okunur; yalnız discovery veya local artifact varlığı yayın değildir. Yetki/izin ayarı değiştirilmedi. Model/provider/NAS/HTTP, yeni upstream test suite, gerçek SessionDB veya script subprocess deneyi yoktur. Q40/Q42/Q47/Q48/Q50 ve eski fidelity/quality borçları kapanmaz.
