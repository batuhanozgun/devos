# Hermes Agent — Bağlamlı kullanım kayıtları

2026-09-20, **B6-T15-H5 / KALICI-AKTARIM-TAMAM / PACKAGE-COMPLETE**.

Bu dosya research/studies/hermes-agent/ araştırmasının concepts girişidir. Hermes source-study **ACTIVE PARTIAL** durumundadır ve 368 dosyalık büyük bir package'dir. Concepts extraction da bu nedenle çok turludur. Mevcut kayıtlar final package closure veya ortak sözlük değildir.

Gerçek okuma ve devam noktası: [READING.md](READING.md).

## 1. Source identity ve durum

- Source package: Hermes Agent external-target study
- Pinned upstream: NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a
- Manifest context: 0.21.0
- Source-study status: ACTIVE PARTIAL
- Source-study current next Q60 evaluation/task-quality: **NOT RESEARCHED**
- Concepts status: B6-T15 partial durable extraction
- Final CORE / four-area projection / SOUL-DevOS adoption: yok.

Source-study STATE/PLAN içindeki next-work authorization assistant davranışını yönetmez. Bunlar research-history/state verisidir.

## 2. Current durable term groups

| Parça | Kapsam |
|---|---|
| [TERMS-TURN-SESSION-CONTEXT.md](TERMS-TURN-SESSION-CONTEXT.md) | Persistent work/session/turn/iteration identities; history/context/wire views; compaction/restore; native vs ordinary context ownership; completion re-entry. |
| [TERMS-WORK-CONTINUATION-SCHEDULING.md](TERMS-WORK-CONTINUATION-SCHEDULING.md) | Durable task/run/claim; goal-loop/heartbeat; cron job/occurrence/execution; output/delivery/receipt; scheduled continuity. |
| [TERMS-LEARNING-SKILLS-MEMORY.md](TERMS-LEARNING-SKILLS-MEMORY.md) | Learning proposal/approval/change; skill source/local/manifest/usage/archive/ledger/discovery; memory store/live/prompt views. |
| [TERMS-RUNTIME-TOOLS-DELEGATION.md](TERMS-RUNTIME-TOOLS-DELEGATION.md) | Runtime resolution/backend ownership; tool visibility/admission/effect/result; child authority/context/workspace/lifecycle; async completion/re-entry. |
| [TERMS-INSTALL-LIBRARY.md](TERMS-INSTALL-LIBRARY.md) | Install source/dependency/shim/home/profile; update/recovery/fleet/receipt; skill sync and library lifecycle. |

Bu gruplama dosya başına bir terim değildir. Aynı Hermes research package'in source-natural kullanımlarını okunabilir bölümlere ayırır.

## 3. Package-level expressions

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-P01 — Hermes Agent | Tool-using agent runtime, gateways, persistent work/scheduling, delegation, learning/skills/memory ve multi-backend execution mekanizmaları taşıyan external target. | General agent definition değil. |
| HA-P02 — external-target study | Hermes'in pinned source implementation ve selected behavior/evidence yüzeylerini araştıran candidate research package. | Product certification/adoption değil. |
| HA-P03 — ACTIVE PARTIAL | Study'nin substantial source/evidence üretmiş ama final core/coverage/quality closure'a ulaşmamış current status'u. | “Unresearched” veya “complete” değil. |
| HA-P04 — pinned source | Primary claims'in bağlandığı immutable upstream commit. | Current latest product behavior değil. |
| HA-P05 — source observation | Pinned code/docs/test source içinde doğrudan görülen field/call/branch/contract. | Runtime occurrence değil. |
| HA-P06 — source inference | Birden çok source observation'dan çıkarılan conditional behavior/relationship. | Executed observation değil. |
| HA-P07 — bounded diagnostic | Exact selected source/dependency seam ve predeclared oracle ile sınırlı local execution. | Full product integration test değil. |
| HA-P08 — executed/observed result | Diagnostic içinde gerçekten oluşmuş local/runtime observation. | Product-wide incidence/effectiveness değil. |
| HA-P09 — TEST SOURCE INSPECTED | Upstream test source'unun oracle/coverage açısından okunması. | Test passed demek değil. |
| HA-P10 — CHECKS NOT RUN | Ayrıştırıcı ama henüz yapılmamış validation/control listesi. | Failure veya PASS değil. |
| HA-P11 — publication/readback | Research artifacts'in repo main'e taşınıp ref/content/scope olarak doğrulanması. | Hermes behavior verification değil. |
| HA-P12 — provisional synthesis | Completed evidence families'ini geçici sistem modelinde birleştiren derived research artifact. | Final CORE/ontology değil. |
| HA-P13 — residual | Source-study'nin bilerek açık bıraktığı load-bearing validation/coverage question. | Concepts extractor bunu otomatik kapatmaz. |
| HA-P14 — current consumer | Bir record/artifact/status'un gerçekten hangi runtime/UI/model/workflow tarafından nasıl kullanıldığını belirleyen downstream mechanism. | Record existence ile aynı değil. |
| HA-P15 — receipt | Bir transition/effect/admission hakkında specific consumer-facing acknowledgement/evidence. | Her receipt aynı strength veya same event değil. |
| HA-P16 — standing | Pending/running/completed/stale/unknown/verified/truncated vb. exact object-relative status meaning. | Aynı label farklı subsystems'te aynı semantik değil. |

## 4. Strong recurring identity/lifecycle distinctions

Hermes package boyunca şu nesneler ayrı tutulur:

### Conversation/runtime
persistent work → session → turn → model-tool iteration → provider attempt.

### Durable work
task → run → claim/owner → worker execution → judge/result → task acceptance.

### Scheduled work
job → occurrence/fire time → fire claim → execution → output → delivery attempt/receipt → visible last status.

### Tool execution
registered tool → visible definition → model proposal → validation → policy → handler → effect → result → result persistence.

### Delegation
delegation request → child construction → role/tool/runtime/context/workspace → child execution → logical terminal → durable completion → host claim/ack → parent turn re-entry.

### Installation/update
source ref → dependency environment → command/shim → home/profile/config → loaded module/process → update transition → dependency repair → fleet restart/readback → persistent receipt.

### Skill/learning
candidate lesson → proposal → review/approval → mutation → persistent/local skill state → manifest/usage/archive/ledger → discovery/index → content load → actual procedure use → future task-quality effect.

The final item, future task-quality effect, Q60 nedeniyle henüz research result değildir.

## 5. Strong recurring non-collapse rules

Current direct source/evidence coverage şu ayrımları repeatedly supports:

1. session != turn != iteration != provider attempt;
2. session ID != exact current history/context;
3. stored transcript != prepared/wire model input;
4. local running slot != durable work/turn lease;
5. task != run != claim;
6. worker stopped != task succeeded;
7. job != occurrence != execution;
8. output saved != delivered;
9. delivery accepted/acked != parent/user/model actually used it;
10. cancel requested/result != physical side effect receipt;
11. requested model/provider != effective runtime/backend;
12. same agent facade != same inner runtime/context/tool owner;
13. tool visible != authorized != effect realized;
14. tool effect realized != result persisted;
15. new child conversation != filesystem/process/environment isolation;
16. child status=completed != user task semantically complete;
17. completion persisted != parent turn admitted;
18. requested install ref != effective source/dependencies/runtime;
19. source updated != installed/materialized/live process updated;
20. update banner/exit/receipt != one atomic success state;
21. bundled skill source != local skill != manifest baseline != usage/curator authority;
22. skill viewed/loaded != followed != task improved;
23. disk memory != live memory != prompt snapshot;
24. proposal approved != mutation applied != next session visible;
25. full source read != execution;
26. source diagnostic != full product validation.

## 6. Important source-local result families already represented

### Turn/session/context
Ordinary HERMES loop and codex_app_server whole-turn runtime may share outer admission but differ in history/tool/compaction/control ownership. Native projected messages are a selective HERMES mirror, not the authoritative native thread.

### Persistent work
Kanban task, multi-turn goal and heartbeat are different mechanisms. Task/run/claim and goal/loop/heartbeat identities cannot be collapsed.

### Scheduled work
A fresh cron agent can use several continuity channels without replaying prior conversation. context_from=self selects newest output by mtime rather than success/semantic relevance; bounded execution showed newer silent/empty/failed artifacts can shadow older useful output.

### Delivery
Queue pending/unknown/delivered, live transport receipts, job last_status and HTTP acceptance labels are different representations. Bounded async diagnostic showed Future.cancel True/False is not an effect/delivery receipt.

### Tools/delegation
Tool schema visibility, policy and actual handler effect are separate. Child completion record, host claim/ack and parent model admission are separate. U13 selected diagnostic observed ack-request despite no scheduling in specific False-return branches; this is bounded, not a product-wide data-loss claim.

### Installation/update
Source checkout, dependency repair, profile/home state and running fleet have separate ownership/recovery obligations. Source advance and materialization/restart receipts can diverge.

### Skill library
Manifest origin hash is update baseline, not historical authorship. Usage, suppression, archive, mutation ledger and discovery views serve different consumers. Collision/list/view behavior can differ. Q60 efficacy remains open.

## 7. Evidence coverage status

B6-T15 current durable checkpoint:
- root 10/10 FULL;
- notes 30/30 FULL;
- provisional syntheses 4/4 FULL;
- inventory 10/10 FULL;
- evidence tree 314 paths accounted;
- direct full-read evidence text: **204/314 paths**; remaining **110/314** support/lineage role-accounted;
- **H1–H4 family extraction durable-complete; H5 role/lineage reconciliation complete; evidence 314/314 accounted.**

Bu sayılar semantic concept count değildir.

## 8. Final source boundary

Hermes concepts package **PACKAGE-COMPLETE**.

H5 package-wide closure:
- 314/314 evidence path accounted;
- 204 direct-read semantic/provenance/result paths;
- 110 support/lineage role-accounted paths;
- 19/19 RESULT-family JSON direct-read;
- five linked term files = 472 contextual IDs; duplicate/gap yok;
- HA-P01–HA-P16 ile toplam addressable contextual record = **488**;
- current Hermes source tree B6-T15 boyunca değişmedi;
- concrete transfer omission kalmadı.

Source-study'nin kendisi ise **ACTIVE PARTIAL**:
- Q60 evaluation/future-task quality **NOT RESEARCHED**;
- Q55/Q56 ile DB/transport/quality/fidelity residual'ları açık;
- final Hermes native CORE/adoption/product reliability verdict'i yok.

Bu nedenle:
- skill reuse/task efficacy hakkında yeni sonuç üretilmez;
- açık research questions concepts tarafından kapanmış sayılmaz;
- pinned source current upstream/product truth'a yükseltilmez;
- future Hermes source delta yeni concepts delta gerektirir.

Normal serial extraction next: **ECC**. B7/B8 shared terminology synthesis hâlâ başlamaz.
