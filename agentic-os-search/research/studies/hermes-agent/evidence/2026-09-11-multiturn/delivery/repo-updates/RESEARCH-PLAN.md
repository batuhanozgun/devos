# Hermes Agent — Araştırma planı

**v0.16 / 2026-09-11 — U04 multi-turn continuation.** İş otoritesi [STATE](STATE.md); yöntem/kapanış [METHOD](METHOD.md). [V0.15 plan](https://github.com/batuhanozgun/agentic-os-search/blob/13e00420d27547998475ac3d1bcd0d4a492f2229/research/studies/hermes-agent/RESEARCH-PLAN.md) tarihsel sıra ve sınırları korur.

## 1. Mevcut açıklama katmanı

Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. Önce native model; daha sonra dört-alan ve SOUL/Development OS. Öğrenme/değişim, genel turn/context/session ve kalıcı iş/continuation için üç **provisional** sentez vardır; bütün sistemin tamamı veya runtime/kalite/adoption kararı yoktur.

## 2. Bu dilimin teslimi

[18/U04](notes/18-MULTITURN-CONTINUATION-AND-REACTIVATION.md), gerçek quiet CLI→Kanban goal-loop→run-status ilişkisini session goal/loop/heartbeat kaynakları ve seçili host yollarıyla karşılaştırır. [RESEARCH](evidence/2026-09-11-multiturn/RESEARCH.md), [SOURCES](evidence/2026-09-11-multiturn/SOURCES.md), [kapsam](evidence/2026-09-11-multiturn/COVERAGE.md).

G01–G12 ve H01–H09 yeni bounded diagnostics'tir; bir tam byte-verified heartbeat modülü, iki manuel Kanban seçkisi, gerçek geçici SQLite ve açık fixture'lar kullanır. Kaynak sadakati, execution kapsamı ve semantic oracle birbirine yükseltilmez. Ayrıntılı pre-run SPEC, raw RESULT, code ve negatif kontroller pakettedir. Eski suite'ler yeniden sayılmaz.

## 3. İlk sonraki birim: kayıtlı durumdan yeniden çalışabilirliğe

**Soru:** Bir manager durumunu sakladığında, session değiştiğinde veya host yeniden başladığında bu iş hangi gerçek kayıt ve tetikleme koşullarında devam eder?

Actual SessionDB `get_meta`/`set_meta` ve onları kullanan manager save/load/clear sözleşmelerinden başla. Sonra actual compaction/session migration consumer'ı, parent/child yazım sırası ve yeniden yüklenen manager'ın route/watch/queue bağına ilerle. Normal yol ile child-write failure veya yarım kalmış awaiting_response gibi bir karşı yolu ayır. Kaynak seviyesinde `True` veya kayıt varlığı, canlı scheduler kurulmuş ya da yeni tur kabul edilmiş anlamına gelmez.

Gerekli offline deney gerçek persistence consumer'ı sınamalı; U04 MetaDB fixture'ının yeniden koşulması actual SessionDB entegrasyonu sayılmaz. AIAgent/provider/credential/kurulum yetkisi genişlemez. En küçük yeterli gerçek kaynak bağımlılığı bulunamıyorsa açıklanmayan halkalar görünür tutulur.

Durma ölçütü: write→durable read→session migration/lineage→fresh load→host admission zincirinin sahibi, kabul/red ve recovery geçişleri kaynakla yeniden kurulabiliyor olmalı. Bütün database/OS/ürün fault matrisi ön koşul değildir.

## 4. Geniş kapsam ve yeniden açma

U04, bütün F01–F12'yi kapatmadı. Session persistence/lease/restart/search ilk güçlü köprü; cron/scheduler, provider/backend/delegation, skill ledger/backup/sync/reuse, alternate UI/native/ACP ve install/eval sürer. Sıra yeni kanıtla yeniden değerlendirilir; her ilginç hata bütün planı ele geçirmez.

U03/K ve U04 Kanban seçkilerinin full-parent fidelity'si güçlü runtime/security/adoption hükmünden önce yeniden açılacak borçtur. Q26/Q29 full-original worker NOT RUN. Q07/Q22 ordinary compaction→API-message kaynak bağı geçerli; last-wire/timing/allvariants açık. Üçüncü provisional sentez ilk ikiyi ezmez veya nihai mimariye dönüştürmez.

## 5. Süreklilik ve yayın

Yalnız Hermes study ve HERMES catalog row. Önceki notlar, evidence, Foundation/control/context/exploration yolları değişmez. Yeni dilim kaynak okuması, yeni execution, synthesis ve publication olarak ayrı raporlanır. Publication current HEAD üzerinde non-force ref ve readback ile kapanır; yerel v0.16 hazırlığı main'e uygulanmadan canonical güncelleme sayılmaz.
