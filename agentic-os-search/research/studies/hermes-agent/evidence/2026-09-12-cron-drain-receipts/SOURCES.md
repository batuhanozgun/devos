# U08 — Kaynak, kapsam ve yürütme defteri

2026-09-12. Research main `188095b930ac77f8d2a5dd605191a09a369a57ce`; primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Yayın durumu [PUBLICATION](PUBLICATION.md)'dadır. Bu kaynak kimlikleri current upstream/binary eşitliği değildir. [Makine-okur aralıklar](SOURCES.json), [RESEARCH](RESEARCH.md), [SPEC](SPEC.md), [RESULT](RESULT.json).

## Pinned kaynaklar

| ID | Path / Git blob | Statü | Yük taşıyan kapsam |
|---|---|---|---|
| S01 | [gateway/run.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/gateway/run.py) / `d6bfc83ec1271dbd3ee7193ca1b2af794b7844e5` | SELECTED SOURCE READ; NOT EXECUTED | gateway startup running gate; independent housekeeping launch; per-profile drain and scopes; incidental cached-history selector |
| S02 | [cron/scheduler.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler.py) / `3a1b3839521b3a6fcb687c4875d446b184a82f20` | SELECTED SOURCE READ; NOT EXECUTED | actual drain_delivery_queue wrapper, queue file gate and real _deliver_result callback |
| S03 | [cron/scheduler_delivery.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/scheduler_delivery.py) / `45b9843c4487abd82b41e649dfe2ed552964a945` | SELECTED SOURCE READ; NOT EXECUTED | live route/send, cancellation branches, seeding, native versus relay standalone fallback |
| S04 | [agent/async_utils.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/async_utils.py) / `2bc558fad21eeec736c0283cb7df86304349f222` | FULL READ; FULL BYTE MATCH; BOUNDED EXECUTION | actual safe_schedule_threadsafe bridge returns asyncio thread-safe Future; B01–B03 |
| S05 | [hermes_cli/cron.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/cron.py) / `c56df9b69d87f54c2f6fdb4901a4220a06338ce7` | SELECTED SOURCE READ; NOT EXECUTED | cron_list, _job_rows, _last_run_display, _job_warnings; one concrete CLI observation path |
| S06 | [cron/jobs.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/cron/jobs.py) / `adb75eea2d0317672708da57808c2dc5f0aee93e` | SELECTED SOURCE READ; NOT EXECUTED | list_jobs joins latest execution, _record_run_outcome status inputs, scoped last-status trace |
| S07 | [tests/gateway/test_cron_delivery_housekeeping.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tests/gateway/test_cron_delivery_housekeeping.py) / `ce1dede5bfca7702c36104eb9320701cae46f2a8` | FULL TEST SOURCE READ; TEST NOT RUN | mocked routing/call-argument assertions; not a transport receipt oracle |
| S08 | [LICENSE](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/LICENSE) / `75410e73319c72cd3e991a501c5455eb78f38375` | PREVIOUS PINNED FULL READ REUSE; LOCAL BYTE MATCH | MIT redistribution notice |

Büyük dosyalar için FULL READ veya local-byte materyalizasyonu iddiası yoktur. S01'de whole-file response alınması bütün dosyanın okunduğu anlamına gelmez; gerektiği aralıklar ayrı açıldı. S03 ilk yanıtının standalone kuyruğu kesildi; 1370–1470 doğrudan ikinci okuma bu kısmı tamamladı. Read kapsamı source map'tedir. Kod yorumlarındaki issue olayları bağımsız saha kanıtı değildir.

## Önceki kaynak ve kanıtların reuse'u

[U07 SOURCES](../2026-09-11-cron-scheduling-delivery/SOURCES.md) current main'den tam okundu; U07 RESEARCH ve kuyruk kodunun aynı konuşmadaki önceki okumaları ilgili D01/None/pending ayrımı için kullanıldı. U07 outer scheduler classifier/finish, delivery aggregator/queue branch, native queue ve execution ledger bu turun yeni full-read/execution girdileri değildir. D01–D06 yeniden çalıştırılmadı.

U04-A/B farklı kayıtlardır; U06 L, U07 D, U08 B serileri bağımsız ürün skoru oluşturmaz. Eski selection fidelity, actual SessionDB, startup/OS/quality borçları korunur. Yeni S04 full-byte equality eski seçkilerin sadakatini doğrulamaz.

## P01/P02 — Python API ve yerel runtime karşı okuması

[Python 3.13 asyncio](https://docs.python.org/3.13/library/asyncio-task.html) ve [concurrent futures](https://docs.python.org/3.13/library/concurrent.futures.html) resmi primary API kaynağı olarak kontrol edildi. Belgeler belirli Hermes sürümünün çalıştırılması değildir. Karar-kritik ayrım local CPython gerçek çalıştırmasıyla sınandı; yalnız genel Future metninden ürün sonucu çıkarılmadı.

`RUNTIME-EXCERPTS.json`, çalıştırılan CPython'un `run_coroutine_threadsafe`, `_chain_future` ve `concurrent.futures.Future.cancel` gövdelerini taşır. Tam runtime dosyalarının hash/byte kimlikleri RESULT'tadır; kendileri arşivde tam modül olarak yayımlanmaz. CPython lisans bildirimi ham arşivde bulunur. Bu Python dosyalarının GitHub upstream ref eşleşmesi iddia edilmez.

## Yeni koşu

UTC `2026-09-11T21:12:38.167078+00:00` → `2026-09-11T21:12:38.171479+00:00`; Europe/Istanbul proje tarihi 12 Eylül. Python 3.13.5 / Linux, tam S04 + gerçek loop/thread + fsync edilmiş yerel dosya etkisi. B01 normal receipt; B02 started effect + cancel=True; B03 terminal error + cancel=False. Loop kapandı ve thread join edildi. Ağ/subprocess audit ihlali yok. Stderr 0 byte. Tek recorded run; hiçbir gerçek mesaj gönderilmedi.

N00 source identity gate; N01/N02 fabricated gözlem-kaydı kontrolüdür, source mutant testi değildir. SPEC N00 için 'flip one source byte' der; uygulama kaynağa tek newline byte'ı ekler. İkisi source identity değişikliğini sınar; bu küçük yöntem farkı örtülmez. Kriter değiştirilmedi, araştırma sonucuna göre yeni run üretilmedi.

## Erişim ve güncellik

GitHub default-branch araması `NousResearch/hermes-agent@31d0a2428e9db346d6781da66f5b37ff3e12def2` üzerinde yollar buldu. Bulgu bütünlüğü için actual dosyalar primary pin'den okundu. Daha yeni queued/Bot Chat alanları, external-worker queue ile aynı mekanizma sayılmadı ve primary sessizce yükseltilmedi. Resmi mutable cron dokümanı yalnız navigation; sürüm düzeltmesi iddiası yok.

Ham kaynak indirme denemesi usable full-parent dosya üretmedi (yerel requests DNS failure; web raw open başarısız). S04, connector tam metni ve Git blob kontrolüyle kuruldu. İzin/ağ/credential ayarı değiştirilmedi. Source-read ile publication capability birbirinden ayrıdır: bu tur read araçları çalıştı, write/commit/ref araçları sunulmadı. Yeni token/bağlantı aranmadı; read endpoint ile mutation denenmedi.

## Current proje context'i

AGENT yeniden okundu, blob değişmedi; aynı konuşmada tam okunmuş R01–R09 geçerli kaldı. Main/STATE ve U07 source ledger yeniden okundu. Current METHOD/plan/INDEX/WHY/scope map aynı main'den önceki kullanıcı değerlendirme turunda tam okunmuştu; yeni main farkı yok. Current META/OPEN-QUESTIONS/SOURCE-LEDGER bu tur tekrar tam okundu. Baseline yerel kopyaları yalnız current Git blob eşleşmesiyle kabul edilir; eski ZIP içindeki unpublished current entry'ler canonical sanılmaz.

Son yayın kontrolü: main `a6c47ef3ff697c2d23c492dcf4ccfa32003040da` oldu; native compare yalnız Foundation yollarını değiştirdi, HERMES STATE yeni ref'te yine U07/v0.20 ve aynı blob. U08 için write gerçekleşmedi. Bu head farkı araştırmanın pinned upstream kaynağını değiştirmez.
