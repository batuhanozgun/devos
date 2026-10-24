# U07 — Kaynak, yürütme ve erişim defteri

> Bu metindeki unpublished durumu ilk U07 teslim anını kaydeder. İlerideki gerçek yayın hükmü ilgili PUBLICATION makbuzu ve güncel canonical STATE üzerinden okunur; raw deney kimlikleri bundan etkilenmez.
2026-09-11. Başlangıç research main: `d928ee14b16a277c010a966816fc2c4097944aab` (U06/v0.19). Primary upstream **`NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`**, manifest 0.21.0. [RESEARCH](RESEARCH.md), [SPEC](SPEC.md), [RESULT](RESULT.json), [MANIFEST](MANIFEST.json). Bu teslim henüz main'de değildir; [PUBLICATION](PUBLICATION.md).

## Primary kaynaklar

ID'ler yalnız U07 içinde anlamlıdır. FULL READ, byte identity, executable dependency closure ve runtime verification aynı statü değildir. Yalnız S06 bu tur çalıştırıldı. Dosya yorumları geçmiş saha vakasının bağımsız kanıtı sayılmadı.

| ID | Immutable kaynak / Git blob | Gerçek kapsam |
|---|---|---|
| U07-S01 | [gateway/run_startup.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/gateway/run_startup.py) — `b20d49e66a30e89888f56d11a5bdfaae8beadee7` | SELECTED 30–190. Resume wrapper'ın adapter dönüşü + görülen task shield'i; startup queue/gate ve bounded wait. Full host/preclaim→drain integration NOT RUN. |
| U07-S02 | [cron/scheduler.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler.py) — `3a1b3839521b3a6fcb687c4875d446b184a82f20` | SELECTED 1–210 + 210–475; 2570–2880 + 2860–3185 + 3180–3505 + 3500–3730 + 3730–3950(EOF). Tick/submit/process-due, run_one_job_body, output/delivery classification, terminal bookkeeping, external worker ownership/ack/wait ve job-registration partial failure. 475–2570 genel run_job/model/script/preflight ve run_one_job outer wrapper kapanmadı; incidental prompt/toolset/comment bölümleri yeni full policy değerlendirmesi değildir. Büyük parent full-byte/AST materyalize edilmedi, çalıştırılmadı. |
| U07-S03 | [cron/executions.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/executions.py) — `f90515337921b4b61178a737f108c6df46dfa82b` | FULL READ 1–220 + 211–450(EOF). SQLite helpers, create/running/adopt/finish, foreign-owner recovery ve selectors. NOT EXECUTED. Alt gateway.status PID/start-time ve WAL fallback doğrulanmadı. |
| U07-S04 | [cron/scheduler_provider.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_provider.py) — `fc02d14fce179a647499bb1ebb9b5aaaa57ab28a` | SELECTED 1–220 + 220–485. Provider interface/register/claim/fire, force/split introspection, misfire backstop, resolver/multiplex fallback, built-in tick loop ve multiplex başı. Multiplex tail, actual gateway bootstrap, plugin implementations ve transport callback auth/due/rearm açık. |
| U07-S05 | [cron/jobs.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/jobs.py) — `adb75eea2d0317672708da57808c2dc5f0aee93e` | SELECTED 1–210 + 210–455; 2200–2388 + 2380–2600 + 2600–2840. Store scope, jobs/fire lock farkı, mark_job_run, finite one-shot claim_dispatch, next-run advance, fire owner token/heartbeat, due scan/catch-up/grace başlangıcı. Full create/parse/load/save/_with_job, outcome helper ve due-scan tail NOT CLOSED; NOT EXECUTED. |
| U07-S06 | [cron/delivery_queue.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/delivery_queue.py) — `689fd620d6193003bbd168a0e62770a0d0306ac6` | **FULL READ + FULL BYTE MATCH + BOUNDED EXECUTION**. 1–210 + 200–455(EOF); full 379 lines, 13,837 bytes. Connector metni yerelde Git blob ve SHA-256 ile eşleşti. Queue SQL/transactions native, temp SQLite/WAL gerçek; alt dependency seams, callback ve process tag sentetik. S03 executions implementasyonu bu koşuda import edilmedi; foreign-owner probe yasaktı. |
| U07-S07 | [cron/scheduler_delivery.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_delivery.py) — `45b9843c4487abd82b41e649dfe2ed552964a945` | SELECTED 850–1100 + 1450–1715(EOF). confirm-adapter-delivery/unverified, target preparation ve full _deliver_result wrapper/queue branch. Full live/standalone transport, continuable mirror/seed ve actual gateway drainer açık. NOT EXECUTED. |
| U07-S08 | [LICENSE](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/LICENSE) — `75410e73319c72cd3e991a501c5455eb78f38375` | Aynı konuşmada önceki pinned okumanın yeniden kullanım kopyası. Arşivde MIT notice; Git blob tekrar eşleşti. Yeni davranış veya güncel lisans araştırması değil. |

Makine-okur path/ref/blob/range eşlemesi [SOURCES.json](SOURCES.json)'dadır. Dış kaynağa erişim yeniden bozulursa bütün büyük dosyaların tam yerel kopyaları varmış gibi davranılmamalı: ham arşiv yalnız S06/S08 ve diagnostic girdilerini taşır.

## Recovered project state ve önceki kanıt

Güncel AGENT yeniden okundu; R06 tam yeniden yüklendi, aynı konuşmada daha önce tam okunmuş diğer protokoller aktif kaldı. STATE/plan, U06 SOURCES ve RESEARCH aralıksız tam geri okundu; INDEX/META/OPEN-QUESTIONS/SOURCE-LEDGER de current ref'ten tam okundu. Root/studies/method ve U04/U05/cold-start ayrımları aynı konuşmada zaten yüklenmiş canonical bağlamdır; bunların hepsi bu tur yeniden upstream full-read veya execution sayılmaz.

U06'nın yayın makbuzu ve v0.19 current entry'leri araştırma başlangıcını taşır. Eski U06 ZIP, yalnız yayımlanmış blob'larla birebir eşleştiği doğrulanan beş entry ve CATALOG baseline'ını yerelde materyalize etmek için kullanıldı; eski unpublished STATE/README/PUBLICATION sürümleri **current baseline'a uygulanmadı**. U04-A/B'nin eş numaraları birleştirilmedi; U05/U06 testleri yeniden çalıştırılmadı.

## Yeni diagnostic kimliği ve yöntem sınırı

Full source SHA-256 `62529e31774f414f9cda886505f0db7f291d13f566cc06982c11cba1da005c4b`.
Pre-run SPEC SHA-256 `13f39fd036f6ee2c96916b0d29b3a4ac2abee0529191c05ffaecceadcdc1bebe`.
Executed probe SHA-256 `fed4ebffda6f15126b13721ba5d6d43fccdbd18e7d141d8c4c8612aef0075bf1`.
Raw RESULT SHA-256 `c53f850cceaad5e84eb800ce88b02c9a4eb227a00d82ee1714aecaefe7b51719`.
Recorded UTC `2026-09-11T14:22:57.364884+00:00`–`2026-09-11T14:22:57.404381+00:00`.

D01–D06 ordinary beklentileri karşılandı; N00 source identity ve N01/N02 explicit mutant oracles ilgili değişiklikleri ayırdı. Aynı araştırmacı, tek başarılı behavioral run; bağımsız replication değildir. Öncesindeki attempt-00 metadata/audit guard hatası vaka veya DB başlamadan oldu. Source/SPEC/oracles değiştirilmeden metadata sorgusu düzeltildi; eski probe/hash/log korunur. Arşivdeki HARNESS-REVISION.md bu değişikliği ayırır.

SQLite'ın kendisi gerçek olsa da test Hermes SessionDB değildir. Alt SQLite-column yardımcı dikişi yalnız fresh schema'yı doğrular; WAL dikişi gerçek WAL kullanır, upstream fallback'i test etmez. Identity redaction ve synthetic start tag ürün güvenliğine kanıt değildir. D01'in callback_count=0 değeri setup açıklamasıdır; ayrı transport instrumentation değildir. D02/D05/D06 callback sayıları gerçekten kayıtlı çağrılardır. Foreign-owner probe sayıları sıfır kalmıştır. timeout=0 gerçek expired dalı seçer; default bekleme süresinin güvenilirliğini ölçmez.

## Erişim / capability / freshness

- `gateway/run.py` 3150–3325 pinned read isteği HTTP429 ile reddedildi. Seri retry yok. Bu turdaki engel o kaynaktır; U05'in eski messages429 engeli current diye yeniden açılmadı.
- Sabit startup raw URL'sini indirme girişimleri kullanılabilir dosya üretmedi: download aracı viewed-URL koşulu nedeniyle reddetti; web raw open Internal Error verdi. Bu turn için DNS teşhisi verilmez; önceki U06 DNS kaydı farklıdır. S06 tam connector metni + Git blob kontrolüyle materyalize edildi.
- Cron directory listesi yalnız navigation, çıktısı truncated: recursive inventory veya bütün dosyalar okunmuş sayılmaz.
- Resmî mutable cron dokümanı araması navigation oldu; pinned davranışın yerine kullanılmadı. [Official docs](https://hermes-agent.nousresearch.com/docs/user-guide/features/cron).
- Default-branch search `04dd80a977f40b05e5b2054111747af07a61886a` üzerinde `drain_delivery_queue`, queued/unverified alanları ve ilgili consumer'lara pointer verdi. Bunlar **navigation only**, pinned kaynağın okunduğu veya bug'ın güncel sürümde düzeldiği iddiası değildir. Özellikle Bot Chat admission kuyruğu ile bu external-worker teslim kuyruğunu sırf aynı queued teriminden eşitleme.
- Current GitHub connector discovery: 48 read/search eylemi, create_tree query boş; full discovery'de write/commit/ref eylemi yok. Plugin search GitHub'ı installed/enabled gösterdi; izin ayarı okunup değiştirilmedi, yeni bağlantı kurulmadı. Repository permission iptali veya önceki safety block teşhisi yok. **Bu tur herhangi bir repository write çağrısı yapılmadı.**

Bu sınırlar nedeniyle native queue diagnostic ile source inference birleştirilse de full-host, end-to-end restart veya current-version adoption doğrulanmadı. Yayın/yerel hash/parse kontrolleri de behavioral evidence sayılmaz.
