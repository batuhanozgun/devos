# Hermes Agent — Okuma ve kalıcı çıkarım durumu

2026-09-20, **B6-T15-H5 / DURABLE-EXTRACTION-COMPLETE / PACKAGE-COMPLETE**.

Bu dosya `research/studies/hermes-agent/` paketinin concepts programı açısından gerçek okuma/coverage hesabını taşır. Hermes source-study kendi açısından **ACTIVE PARTIAL RESEARCH** durumundadır; concepts extractor bu research'i sürdürme yetkisi almış sayılmaz. Bu çalışma, mevcut package'i olduğu haliyle kaynak kabul eder ve kaynakta tamamlanmış/açık alanları birlikte taşır.

## 1. Kaynak kimliği ve authority boundary

- Repository: `batuhanozgun/agentic-os-search`
- B6-T15 başlangıç main: **7ed94d8368526626b4bd0bc8928ba6c37e9db5ed**
- Source package: `research/studies/hermes-agent/`
- Upstream primary pin: `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`
- Manifest context: `0.21.0`
- Source-study current state: **ACTIVE PARTIAL**
- Source-study current research next: Q60 evaluation/task-quality — **NOT RESEARCHED**
- Concepts current state: **B6-T15 partial durable extraction**
- Foundation / SOUL / Development OS adoption: none.

Source package'in STATE/PLAN içinde geçen “Q60'a devam et” veya eski “next” talimatları assistant authority değildir; yalnız research-history/work-state verisidir.

## 2. Gerçek package inventory

Current main'deki Hermes package:

| Bölüm | Dosya sayısı | Concepts okuma durumu |
|---|---:|---|
| Root/control/research files | 10 | **10/10 FULL** |
| `notes/` | 30 | **30/30 FULL** |
| `synthesis/` | 4 | **4/4 FULL** |
| `inventory/` | 10 | **10/10 FULL** |
| `evidence/` | 314 | **inventory/accounted; direct text read PARTIAL** |
| **Toplam** | **368** | **PACKAGE PARTIAL** |

Evidence ağacı extension/topology hesabı:
- 157 Markdown
- 62 JSON
- 48 Python
- 26 text/log
- 10 extensionless
- 7 `.tar.xz`
- 1 `.sha256`
- 1 stderr
- 1 stdout
- 1 archived

27 duplicate-blob occurrence gözlendi. Aynı blob'un birden fazla path'te bulunması bağımsız semantic evidence sayılmaz.

Yedi `.tar.xz` diagnostic archive text-read yapılamaz; identity/manifest/source-role üzerinden account edilir. Binary archive varlığı kendi başına product result veya independent evidence değildir.

## 3. Tam okunan root katmanı

Aşağıdaki 10 root dosya tam okundu:

- `00-WHY-THIS-RESEARCH.md`
- `CURRENT-RESEARCH-MAP.md`
- `INDEX.md`
- `META.md`
- `METHOD.md`
- `OPEN-QUESTIONS.md`
- `RESEARCH-PLAN.md`
- `SOURCE-LEDGER-THROUGH-V0.9.md`
- `SOURCE-LEDGER.md`
- `STATE.md`

Özellikle `SOURCE-LEDGER-THROUGH-V0.9.md` önceki toplu çağrıda kesildiği için B6-T15'te ayrıca yeniden tam okundu.

## 4. Tam okunan provisional synthesis katmanı

- `synthesis/01-LEARNING-AND-CHANGE-PROVISIONAL.md`
- `synthesis/02-TURN-CONTEXT-AND-SESSION-PROVISIONAL.md`
- `synthesis/03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md`
- `synthesis/04-SCHEDULED-WORK-AND-CONTEXT-PROVISIONAL.md`

Bunlar **provisional**dır. Final Hermes CORE/four-area projection/adoption değildir. Aynı underlying research evidence'in üst synthesis'te tekrar görünmesi yeni bağımsız evidence üretmez.

## 5. Tam okunan note katmanı

`notes/01`–`notes/30` tamamı tam okundu. Kaynak aileleri:

1. orientation / background learning;
2. skill curation / proposal / approval / mutation;
3. caller/context/pending/memory roundtrips;
4. worker policy / middleware / UI-profile callers;
5. general turn/session;
6. Kanban task/run/claim;
7. goal/loop/heartbeat;
8. session lease/history/recovery/resume;
9. cron scheduling/delivery/occurrence/context;
10. runtime/backend;
11. tool admission/delegation/reentry;
12. install/update/activation;
13. skill-library lifecycle.

Note'lar evidence'in yerini almaz; source-specific claims için evidence/SOURCES/SPEC/RESULT route'u korunur.

## 6. Tam okunan inventory katmanı

Aşağıdaki 10 inventory file full-read:

- `STRUCTURE.md`
- `CORE-COVERAGE-2026-09-10.md`
- `SCOPE-REVIEW-2026-09-10.md`
- `CONTINUITY-COVERAGE-2026-09-11.md`
- `LEASE-RECOVERY-COVERAGE-2026-09-11.md`
- `RESUME-ADMISSION-COVERAGE-2026-09-11.md`
- `CRON-COVERAGE-2026-09-11.md`
- `DELIVERY-RECEIPT-COVERAGE-2026-09-12.md`
- `EXECUTION-CONTEXT-COVERAGE-2026-09-12.md`
- `SCOPE-REVIEW-2026-09-13-U13.md`

Önceki toplu çağrıda kesilen CONTINUITY/LEASE dosyaları ayrıca tam geri okundu.

## 7. Evidence doğrudan okuma — güncel tranche

Evidence inventory 314 dosyadır; tamamı henüz direct-read değildir. B6-T15'te şu human-authored evidence kayıtları tam okundu:

### U15 — skill library lifecycle
- `SYNC-AND-LOCAL-STATE.md`
- `SYNC-SOURCES.md`
- `ARCHIVE-LEDGER-AND-DISCOVERY.md`
- `DISCOVERY-SOURCES.md`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U14 — install/update/activation
- `INSTALL-AND-ACTIVATION.md`
- `INSTALL-SOURCES.md`
- `UPDATE-AND-RECOVERY.md`
- `UPDATE-SOURCES.md`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U13 — delegation re-entry
- `RESEARCH.md`
- `SOURCES.md`
- `DIAGNOSTIC.md`
- `SPEC.md`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U12 — tool admission/delegation
- `TOOL-ADMISSION.md`
- `TOOL-SOURCES.md`
- `DELEGATION-LIFECYCLE.md`
- `DELEGATION-SOURCES.md`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U11 — runtime/backend
- `RESEARCH.md`
- `SOURCES.md`
- `BACKEND-OWNERSHIP.md`
- `BACKEND-SOURCES.md`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U10 — cron execution/context
- `RESEARCH.md`
- `SOURCES.md`

### U09 — cron occurrence admission
- `RESEARCH.md`
- `SOURCES.md`

### U08 — cron drain/receipt
- `RESEARCH.md`
- `SOURCES.md`

### U07 — cron scheduling/delivery
- `RESEARCH.md`
- `SOURCES.md`
- `SPEC.md`

Bu tranche doğrudan **39 text evidence file** eder. Evidence tree'nin geri kalan **275 path'i henüz direct full-read sayılmaz**. Bazıları result/source copy/probe/raw archive/duplicate blob olduğundan semantic role manifest/ledger üzerinden ayrıca sınıflandırılacaktır; fakat package closure için görünmez sayılmayacaktır.

## 7A. Evidence doğrudan okuma — cron reconciliation tranche

B6-T15 continuation'da önceki 39 direct-read evidence file'a **20 unique file** eklendi:

### U10 — cron execution/context
- `SPEC.md`
- `RESULT.json`
- `MANIFEST.json`
- `ARTIFACT-CHECKS.json`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U09 — cron occurrence admission
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

U09 source-only birimdir; RESULT/archive yokluğu eksik publication değil, source-unit tasarımıdır.

### U08 — cron drain/receipts
- `SPEC.md`
- `RESULT.json`
- `MANIFEST.json`
- `ARTIFACT-CHECKS.json`
- `CHECKS-NOT-RUN.md`
- `PUBLICATION.md`

### U07 — cron scheduling/delivery
- `RESULT.json`
- `MANIFEST.json`
- `ARTIFACT-CHECKS.json`
- `PUBLICATION.md`
- `README.md`
- `SOURCES.json`

Bu tranche mevcut TERMS-WORK-CONTINUATION-SCHEDULING ayrımlarını güçlendirdi; yeni contradictory meaning bulunmadı. Özellikle:
- U10 native selector run'ı newest-mtime seçiminin success/semantic-quality aware olmadığını, silent/empty/error docs ve 8k Prompt-first truncation davranışını bounded olarak gözledi; full scheduler/model request çalıştırılmadı.
- U08 actual async bridge diagnostic'te `cancel()==True` effect başlamadı anlamına gelmedi; local effect cancel öncesi gerçekleşebildi. `cancel()==False` da success receipt olmadı; terminal error gözlendi. Enclosing scheduler/transport çalıştırılmadı.
- U07 temp SQLite queue diagnostic pending/delivering/delivered/failed/unknown/tombstone lifecycle'larını exact execution identity altında gözledi; send callback sentetiktir, gateway/network/SessionDB değildir.
- U09 late-callback/claim/rearm konusu source-only kaldı; real store/NAS/provider execution yapılmadı.

Publication/readback kayıtları research transfer authority'sidir; product behavior validation veya independent replication değildir.

## 7B. Evidence doğrudan okuma — U03/U04/U06 continuation checkpoint

Cron tranche sonrasında **17 additional unique file** güvenle full-read olarak sayıldı; connector-output truncation görülen büyük dosyalar full-read sayılmadı.

### U03 — Kanban task/run/claim
Full-read:
- `RESEARCH.md`
- `SOURCES.md`
- `SPEC.md`
- `RESULT-SUMMARY.json`
- `PUBLICATION.md`
- `RECOVERY-MANIFEST.json`

Bu set mevcut task/run/claim ayrımlarını güçlendirdi: task identity, run attempt, current claim/owner, process exit, DB completion, post-commit callbacks ve semantic acceptance ayrı. K06 özellikle caller exception ile durable completion'ın aynı şey olmadığını source-selected SQLite evidence ile ayırır. Raw RESULT binary archive içinde account edilir; derived summary raw detail'in yerine geçmez.

### U04-B — separate multi-turn delivery reconciliation
Full-read:
- `README.md`
- `RECONCILIATION.md`
- `DELIVERY-MANIFEST.json`

A/B aynı U04 adı altında farklı recorded runs'dır; same G/H IDs same experiment değildir. B package local synthesis central synthesis/03'ün yerine geçmez ve bağımsız replication sayılmaz.

### U04-A — multi-turn continuity
Full-read:
- `SOURCES.md`
- `SPEC.md`
- `RESULT-SUMMARY.json`
- `MANIFEST.json`
- `PUBLICATION.md`

`RESEARCH.md` large connector output'ta kesildiği için **henüz full-read sayılmadı**; smaller-range continuation gerektirir.

### U06 — process-local resume lease
Full-read:
- `RESULT.json`
- `MANIFEST.json`
- `PUBLICATION.md`

U06 RESULT, process-local registry'nin same-SID mutual exclusion, wait/timeout, parent-child shared lease, rebind conflict, stale token rejection, cancelled waiter cleanup ve separate registries limitation'ını bounded olarak kaydeder. Actual SessionDB/gateway/model/OS restart çalıştırılmadı.

### Kesilen / henüz full sayılmayanlar
- U04-A `RESEARCH.md`
- U05 `RESEARCH.md`, `SOURCES.md`, `CHECKS-NOT-RUN.md`, `PUBLICATION.md`
- U06 `RESEARCH.md`, `SOURCES.md`, `SPEC.md`

Bunlar next tranche'de range-by-range tamamlanır. Tool truncation'ı “read complete” diye yorumlanmaz.

## 7C. Evidence direct-read — U04-A/U05/U06 truncation closure

Previous output truncation was not treated as completion. The following eight files were then read individually/with bounded ranges and are now counted as FULL:

- U04-A `RESEARCH.md`
- U05 `RESEARCH.md`
- U05 `SOURCES.md`
- U05 `CHECKS-NOT-RUN.md`
- U05 `PUBLICATION.md`
- U06 `RESEARCH.md`
- U06 `SOURCES.md`
- U06 `SPEC.md`

This adds eight to the conservative 76-file checkpoint: **84/314**.

Key source-bound clarifications preserved:
- U05 durable DB lease, process-local/gateway lease, task-run ownership and history selection are different objects/controls.
- Immediate admission does not necessarily reload DB history; waited admission and compression recovery are conditional repair routes, not universal history refresh.
- Persisted loop state and a live driver/watch are separate; heartbeat persistence and watch registration have different restart semantics.
- U06 separates routing key, resolved session ID, process-local TurnLeaseToken, durable DB holder, active-turn marker, loop awaiting_response and delivery obligation.
- Process-local registry serialization does not imply cross-process/durable serialization: two independent registry instances can admit the same SID in the bounded L07 run.
- Startup resume/recomputation and redelivery of already-produced output are separate recovery obligations.
- Publication/checkpoint files prove transfer/readback, not behavioral product conformance.

## 7D. H1 durable checkpoint — U01/U02 ve erken evidence kapanışı

Hermes concepts aktarımı beş parçaya bölündü. **H1 yalnız U01/U02 + erken evidence ailesini kapatır; Hermes package'i bütünüyle kapatmaz.**

H1 sonunda conservative direct-full-read hesabı **187/314 evidence path**; remaining **127 path** H2–H5'te family/role bazında reconcile edilir. Bu sayaç semantic evidence count değildir.

H1 kapanışında:
- U01 approval/memory/pending/worker-policy/review-middleware/UI-profile/prompt-restore ailelerinin human-authored README/RESEARCH/SOURCES/SPEC/PUBLICATION/HANDOFF metinleri direct-read edildi;
- load-bearing raw observations direct-read edildi: worker-policy RESULT/VALIDATION, middleware RESULT/range-fidelity, memory/pending RESULT, slash-policy A/SA/AP results, prompt-restore RESULT, early component/context-transfer/U01B2 results;
- U02 turn-lifecycle research/source/publication/manifest yüzeyi direct-read edildi;
- duplicate source blobs (ör. repeated LICENSE, slash_access.py, write_approval.py, empty stderr) bağımsız semantic evidence sayılmadı;
- probe/harness Python files, stdout/stderr, repeated upstream source copies ve binary/archive taşıyıcıları ancak claim identity/oracle/manifest rolü gerektiği ölçüde account edildi; sırf path sayısını 314'e tamamlamak için yeni kavram kanıtı gibi okunmadı.

H1 source-to-TERMS kontrolü iki somut eksik buldu ve kapattı:

1. **Memory / prompt / approval visibility refinement**
   - stored system prompt;
   - prompt compatibility;
   - prompt restore / invalidation / rebuild;
   - approval mode vs specific payload approval;
   - pending namespace / proposer origin;
   - apply success vs cleanup success;
   - routed runtime home vs transport authorization home;
   - pending apply → store/snapshot → prompt → prepared request visibility chain.
   Bunlar `TERMS-LEARNING-SKILLS-MEMORY.md` içinde HA-L72–HA-L85 olarak kalıcılaştırıldı.

2. **Worker/slash-policy/middleware refinement**
   - advertised/valid tool names vs review whitelist;
   - thread-local whitelist vs worker binding;
   - name acceptance vs later policy admission;
   - middleware `next_call`, short-circuit, pre-next self-failure, downstream failure, saved result and duplicate-next guard;
   - ingress authorization vs slash-command access;
   - canonical command-family granularity;
   - idle/busy command distinction;
   - transport profile vs runtime profile;
   - CLI live-store caller vs gateway fresh-store caller.
   Bunlar `TERMS-RUNTIME-TOOLS-DELEGATION.md` içinde HA-R101–HA-R120 olarak kalıcılaştırıldı.

H1'de previous Hermes interpretations'i tersine çeviren bir source finding çıkmadı. Bunun yerine qualifier'lar sıkılaştı:
- valid tool name ≠ authorized dispatch;
- approval-mode toggle ≠ approve/apply;
- mutation landed ≠ pending cleanup succeeded;
- fresh MemoryStore ≠ fresh model-visible prompt;
- transport admission identity ≠ routed data/profile home;
- same slash command family ≠ per-subcommand authority;
- middleware callback failure ≠ always fail-closed veya always fail-open.

**H1-DURABLE-COMPLETE** bu erken family'lerin concepts aktarımı içindir. Full Hermes evidence closure, source-study Q60 veya product validation değildir.

Beş parçalı devam planı:
- **H1:** U01/U02 + erken evidence — COMPLETE.
- **H2:** U03–U06 persistent work / continuation.
- **H3:** U07–U10 scheduled work / cron.
- **H4:** U11–U15 runtime / tools / delegation / install / skill library.
- **H5:** package-wide raw-role reconciliation, TERMS cross-check, delta/final closure.

## 7E. H2 durable checkpoint — U03–U06 persistent work / continuation

**H2 yalnız U03–U06 family'lerini kapatır; Hermes package hâlâ PARTIAL.**

H2 exact scope:
- U03 `2026-09-10-kanban-task`;
- U04-A `2026-09-11-multi-turn-continuity`;
- U04-B `2026-09-11-multiturn`;
- U05 `2026-09-11-session-lease-recovery`;
- U06 `2026-09-11-resume-admission`.

Recursive H2 subtree hesabı:
- **65 unique path / 65 unique blob**;
- 39 Markdown;
- 11 JSON;
- 6 Python;
- 3 `.tar.xz`;
- 2 text;
- 1 sha256 manifest;
- 1 stderr;
- 1 stdout;
- 1 archived license;
- H2 içinde duplicate blob yok.

H2 closure hesabı:
- **45/65 path direct semantic/provenance/result read**;
- **20/65 path role-accounted**: diagnostic archives, probe/prepare/validate code, stdout/stderr, exact/full or manual-selected source copies, candidate repo-update drafts, hash/catalog artifacts.
- Üç binary diagnostic archive text-read sayılmadı; U03 RECOVERY-MANIFEST, U04-A MANIFEST ve U06 MANIFEST/archive identity/member roles üzerinden account edildi.
- U04-B candidate `repo-updates/*` current authority değildir. Publication manifestte historical prepared-not-published candidate olarak tutulur; current STATE/PLAN/META/QUESTIONS ile byte-equal olmadığı görüldü ve bir candidate note path current aynı path'te yoktur. Bu yüzden duplicate canonical content diye sayılmadı.
- U04-B actual semantic payload `RESEARCH/SOURCES/SYNTHESIS/ADVERSARIAL/COVERAGE/REPRODUCTION/SPEC/RESULT` ve publication/reconciliation records direct-read edildi.
- U04-B `RESULT.json` G01–G12/H01–H09 + negative controls direct-read edildi; 21 matched diagnostic case product PASS skoru değildir.

H2 source-to-TERMS kontrolü iki linked part'ta refinement üretti:

### Persistent Work / Continuation
`TERMS-WORK-CONTINUATION-SCHEDULING.md` HA-W96–HA-W110:
- expected run ID;
- review handoff;
- superseded run;
- loop outcome vs durable transition receipt;
- block attempt vs block acceptance;
- finalize request;
- ownership recheck gap;
- Kanban WAIT-as-continue vs session WAIT barrier;
- persistent manager state vs live reactivation;
- manager-state migration / acknowledgement gap;
- claim heartbeat vs session heartbeat.

### Turn / Session / Recovery
`TERMS-TURN-SESSION-CONTEXT.md` HA-T48–HA-T64:
- routing key vs resolved session ID;
- process-local TurnLeaseToken vs durable DB holder;
- process-local registry vs cross-process admission;
- immediate vs waited admission;
- history refresh on admission;
- active-turn marker / awaiting-response / delivery obligation;
- startup recomputation vs result redelivery;
- restart recovery split;
- stale token / lease rebind / cancelled waiter cleanup.

H2 strongest non-collapse rules:
- task identity ≠ run authority;
- judge verdict ≠ durable task acceptance;
- loop outcome ≠ DB/store transition receipt;
- review handoff ≠ task completion;
- ownership loss ≠ physical execution/effect instantaneously stopped;
- manager state persisted ≠ live watcher/driver reactivated;
- migration helper success ≠ child record durably present;
- same session ID ≠ same current history;
- process-local lease serialization ≠ durable/cross-process serialization;
- state restore ≠ recomputation ≠ redelivery.

Global conservative direct-read evidence count is now **197/314 path**. Remaining **117 path** H3–H5'te family/role bazında reconcile edilir; semantic source count değildir.

**H2-DURABLE-COMPLETE** source-bounded concepts transfer statüsüdür. Actual product reliability, Q60 efficacy, current upstream, independent replication veya Hermes package closure değildir.

Beş parçalı plan:
- H1 — COMPLETE.
- **H2 — COMPLETE.**
- H3 — U07–U10 scheduled work / cron — NEXT.
- H4 — U11–U15 runtime/tools/delegation/install/skill-library — pending.
- H5 — package-wide raw-role reconciliation + cross-TERMS + final delta/closure — pending.

## 7F. H3 durable checkpoint — U07–U10 scheduled work / cron

**H3 yalnız U07–U10 scheduled-work family'lerini kapatır; Hermes package hâlâ PARTIAL.**

H3 exact scope:
- U07 `2026-09-11-cron-scheduling-delivery`;
- U08 `2026-09-12-cron-drain-receipts`;
- U09 `2026-09-12-cron-occurrence-admission`;
- U10 `2026-09-12-cron-execution-context`.

Recursive H3 subtree:
- **36 path / 36 unique blob**;
- U07: 10;
- U08: 11;
- U09: 5;
- U10: 10.

H3 closure:
- **33/36 path direct-read**;
- **3/36 path role-accounted binary diagnostic archive**: U07, U08 ve U10 `.tar.xz`;
- archive contents/manifests/source identities ayrı MANIFEST/PUBLICATION records üzerinden account edildi; binary archives text-read diye etiketlenmedi;
- U09 source-only birimdir; RESULT/archive yokluğu missing evidence değil, study design'ıdır.

Bu H3 turunda daha önce açık kalan dört semantic/provenance file direct-read edildi:
- U08 `README.md`;
- U08 `SOURCES.json`;
- U09 `README.md`;
- U10 `README.md`.

Önceki direct reads ile birlikte H3'ün RESEARCH/SOURCES/SPEC/RESULT/MANIFEST/ARTIFACT-CHECKS/CHECKS-NOT-RUN/PUBLICATION surfaces'i kapanmıştır.

### H3 source-to-TERMS refinement

`TERMS-WORK-CONTINUATION-SCHEDULING.md` HA-W111–HA-W128 eklendi:
- provisioned occurrence identity;
- inbound admission key;
- occurrence identity narrowing;
- active claim protection vs historical occurrence memory;
- late callback;
- duplicate response label;
- scheduled snapshot;
- execution-context channels;
- fresh cron conversation;
- script-only execution;
- wakeAgent gate;
- script working directory;
- monitor detection-time checkpoint;
- execution-context selection quality;
- operational cron success;
- teardown deferral;
- occurrence acceptance vs execution completion.

Strongest H3 non-collapse rules:
- job ≠ occurrence ≠ claim ≠ execution;
- outward job+fire_at identity ≠ inbound job-only admission predicate;
- active claim prevents concurrent owner overlap ≠ historical occurrence dedup memory;
- HTTP accepted/duplicate labels ≠ exact execution/result/delivery receipt;
- fresh cron agent ≠ prior conversation resumed;
- context_from/notepad/memory/prefill/project context are separate continuity channels;
- newest output ≠ last successful/meaningful context;
- monitor detection checkpoint ≠ change handled successfully;
- no_agent/wake gate ≠ no external effect;
- caller return/timeout ≠ worker physically stopped;
- output saved ≠ delivered ≠ user accepted.

Global conservative direct-read evidence count is now **201/314 path**. Remaining **113 path** H4–H5'te family/role bazında reconcile edilir; semantic source count değildir.

**H3-DURABLE-COMPLETE** source-bounded concepts transfer statüsüdür. U09 late-callback path source-only; U07/U08/U10 diagnostics bounded; no live NAS/provider/full scheduler/model product validation.

Beş parçalı plan:
- H1 — COMPLETE.
- H2 — COMPLETE.
- **H3 — COMPLETE.**
- H4 — U11–U15 runtime / tools / delegation / install / skill library — NEXT.
- H5 — package-wide raw-role reconciliation + cross-TERMS + final delta/closure — pending.

## 7G. H4 durable checkpoint — U11–U15 runtime/tools/delegation/install/skill-library

**H4 yalnız U11–U15 family'lerini kapatır; Hermes package hâlâ PARTIAL.**

H4 exact scope:
- U11 `2026-09-12-runtime-backend`;
- U12 `2026-09-13-tool-delegation`;
- U13 `2026-09-13-delegation-reentry`;
- U14 `2026-09-13-install-update`;
- U15 `2026-09-13-skill-library`.

Recursive H4 subtree:
- **34 path / 34 unique blob**;
- U11: 6;
- U12: 6;
- U13: 10;
- U14: 6;
- U15: 6.

H4 closure:
- **33/34 path direct-read**;
- **1/34 path role-accounted binary diagnostic archive**: U13 `diagnostic-evidence.tar.xz`;
- U13 archive MANIFEST 11 member identity, raw RESULT hash, source selections, logs/probe roles ve full-parent-fidelity limitation'ını taşır;
- archive text-read olarak etiketlenmedi.

Bu H4 turunda açık kalan üç U13 surface direct-read edildi:
- `README.md`;
- `MANIFEST.json`;
- `RESULT-SUMMARY.json`.

Önceki B6-T15 reads ile U11/U12/U14/U15 bütün human-authored evidence files ve U13 RESEARCH/SOURCES/SPEC/DIAGNOSTIC/CHECKS/PUBLICATION zaten direct-read durumundaydı.

### H4 source-to-TERMS coverage check

**Yeni term ID gerektiren somut boşluk bulunmadı.** Existing linked terms zaten source-native distinctions'i kapsıyor:

`TERMS-RUNTIME-TOOLS-DELEGATION.md`
- requested/resolved/effective runtime;
- transport vs whole-turn backend ownership;
- ordinary API vs native app-server path;
- runtime snapshot/fallback/retirement;
- tool registry/visibility/availability/proposal/validation/admission/effect/result/persistence;
- middleware/final-argument/guardrail/dispatch-once/batch-plan;
- child construction/role/toolset/context/session/workspace;
- sync/detached delegation;
- logical terminal vs physical close;
- durable completion/queue/claim/token/ack/release/retry/drop/parent re-entry;
- U13 ack-without-schedule, claim-local-slot residue, exception compensation, scheduling refusal ve interim empty-token distinctions.

`TERMS-INSTALL-LIBRARY.md`
- install source/HEAD/dependencies/shim/home/profile/bootstrap;
- update admission/source transition/lock/recovery;
- backup/data/process recovery separation;
- markers/pending obligations;
- loaded module graph/fleet/restart/readback;
- banner/exit/receipt divergence;
- bundled/local/manifest baseline/sync;
- usage/suppression/archive/ledger/discovery/index/view/readiness skill-library states.

U15 source ayrıca `TERMS-LEARNING-SKILLS-MEMORY.md` içindeki skill source/local/manifest/usage/archive/ledger/discovery/load/use/efficacy distinctions ile örtüşür. Bu cross-link yeni ortak terminology sentezi değildir; aynı Hermes package içindeki iki source-natural grouping'in overlap'ıdır.

H4 strongest non-collapse:
- requested provider/model ≠ resolved runtime ≠ constructed client ≠ actual transport/whole-turn owner;
- same AIAgent facade ≠ same history/tool/compaction owner;
- tool visible ≠ accepted name ≠ policy-admitted ≠ handler effect ≠ persisted result;
- fresh child context ≠ environment isolation;
- detached child completed ≠ completion delivered/admitted into parent turn;
- ack requested ≠ new parent turn scheduled;
- install source advanced ≠ dependencies materialized ≠ process reloaded ≠ fleet current;
- update receipt/banner/exit code ≠ one atomic success state;
- bundled source ≠ local skill ≠ manifest baseline ≠ usage/curator authority;
- skill viewed/loaded ≠ procedure followed ≠ task improved.

Global conservative direct-read evidence count is now **204/314 path**. Remaining **110 path** H5'te package-wide role reconciliation/final coverage için değerlendirilir; independent semantic evidence count değildir.

**H4-DURABLE-COMPLETE** source-bounded concepts transfer statüsüdür. U11–U15 source-study residuals, current product truth, Q60 efficacy ve independent verification kapanmış sayılmaz.

Beş parçalı plan:
- H1 — COMPLETE.
- H2 — COMPLETE.
- H3 — COMPLETE.
- **H4 — COMPLETE.**
- H5 — package-wide raw-role reconciliation + cross-TERMS + final delta/closure — NEXT.

## 7H. H5 final closure — package-wide evidence and TERMS reconciliation

H5 yeni Hermes source araştırması yapmadı; mevcut package'in concepts kapanışını doğruladı.

### Evidence accounting

Current evidence tree:
- **314/314 path accounted**;
- **204/314 path direct-read** semantic/provenance/result coverage;
- **110/314 path role/lineage-accounted** support artifacts.

Role-accounted remainder yeni semantic evidence değildir. Başlıca roller:
- diagnostic/probe/harness/verification Python code;
- pinned upstream source copies ve manually selected source excerpts;
- stdout/stderr/log files;
- binary diagnostic archives;
- LICENSE/NOTICE/hash files;
- manifest/access/transfer/identity/package-check/input records;
- historical prepared-not-published repo-update drafts.

JSON cross-check:
- **19/19 RESULT-family JSON** direct-read semantic result surface;
- remaining non-result JSON manifest/source/transfer/access/identity/integrity/provenance roles taşır;
- artifact-integrity veya publication record davranış doğrulaması sayılmaz.

Evidence tree toplam extension/topology:
- 157 Markdown;
- 62 JSON;
- 48 Python;
- 26 text/log;
- 10 extensionless;
- 7 tar.xz;
- 1 sha256;
- 1 stderr;
- 1 stdout;
- 1 archived.

Nine duplicate-blob groups / 36 duplicate-path occurrences bağımsız evidence sayılmadı.

### Package-wide TERMS reconciliation

Linked contextual inventory:
- TURN/SESSION/CONTEXT: **64** ID, HA-T01–HA-T64;
- WORK/CONTINUATION/SCHEDULING: **128** ID, HA-W01–HA-W128;
- LEARNING/SKILLS/MEMORY: **85** ID, HA-L01–HA-L85;
- RUNTIME/TOOLS/DELEGATION: **120** ID, HA-R01–HA-R120;
- INSTALL/LIBRARY: **75** ID, HA-I01–HA-I75.

Toplam linked: **472**; duplicate ID **0**; bütün prefix dizileri kesintisiz. Ana TERMS ayrıca HA-P01–HA-P16 package-level expressions taşır. Toplam addressable contextual record: **488**.

H1–H4 source-to-TERMS checks sonunda açık semantic omission kalmadı. H4'te yeni ID üretilmemesi de explicit result'tur: U11–U15 existing term groups source-native distinctions'i zaten kapsıyordu.

### Source/delta boundary

B6-T15 concepts başlangıç main'i **7ed94d8368526626b4bd0bc8928ba6c37e9db5ed**. H5 source-delta compare:
- `research/studies/hermes-agent/**` change: **0**;
- evidence tree current SHA: `c4713f0f8a9f194950cd8bf5e0f1bb8743807597`;
- notes tree: `cefb52a694c6e73c9bbf019836d3dfe3a36970bc`;
- synthesis tree: `66ecd5f8f060fdfce9df272cbe3f530eff4ed70d`;
- inventory tree: `195cabdd0a74fa675e42af7020db3b12ef91187a`.

Bu nedenle concepts extraction aynı current source package üzerinde tamamlandı; concurrent source mutation ile karışmadı.

### Source-study boundary

Hermes'in kendi current STATE/META'sı hâlâ:
- **ACTIVE PARTIAL RESEARCH**;
- U15 / plan v0.28;
- Q60 evaluation/task-quality **NOT RESEARCHED**;
- final native CORE / adoption / whole-product validation yok.

**Concepts PACKAGE-COMPLETE bu source-study'nin complete olduğu anlamına gelmez.** Anlamı: current repository'de mevcut Hermes research package'inin bağlamlı terim/kullanım aktarımı source-bounded olarak tamamlandı. Future source-study extension veya concrete omission yeni delta olarak yeniden açabilir.

### H5 judgment

Closure conditions passed:
- root/control 10/10 FULL;
- notes 30/30 FULL;
- provisional synthesis 4/4 FULL;
- inventory 10/10 FULL;
- evidence 314/314 accounted;
- load-bearing RESULT semantics direct-read;
- raw/support/archive roles reconciled;
- linked TERMS cross-check complete;
- source-study/open-residual boundaries preserved;
- no concrete transfer omission remains.

**Hermes Agent concepts extraction: DURABLE-COMPLETE / PACKAGE-COMPLETE.**

## 8. Şu ana kadar source-backed bağlam aileleri

İlk durable TERMS parçaları şu current evidence coverage'e dayanabilir:

- turn / model-tool iteration / session / persistent-work identity;
- context/history/api-content/wire views ve compaction/restore boundaries;
- Kanban task/run/claim/acceptance ve goal/loop/heartbeat continuation;
- cron job/occurrence/claim/execution/output/delivery receipt distinctions;
- requested provider/model vs resolved runtime/client/whole-turn backend;
- tool visibility/admission/policy/effect/result;
- child/delegation authority/context/workspace/result/reentry;
- install source/dependency/shim/home/profile/process/update/receipt;
- skill source/local copy/manifest/usage/archive/ledger/index/view/readiness;
- skill proposal/review/approval/mutation/visibility/reuse;
- memory disk/live-store/prompt-snapshot/current-turn differences.

Q60 evaluation/future-task quality **NOT RESEARCHED** olduğu için “skill reuse improves task quality”, “learning efficacy” veya generalized evaluation terminology current Hermes source result olarak üretilmez.

## 9. Evidence-status vocabulary

Hermes source-study'nin kendi epistemic labels'i korunur:

- TARGET CLAIM
- OBSERVATION
- INFERENCE
- HYPOTHESIS / OPEN
- TEST SOURCE INSPECTED
- EXECUTED / OBSERVED RESULT

Ayrımlar:
- full source read ≠ execution;
- test source inspected ≠ test passed;
- source selection diagnostic ≠ full product integration;
- manifest/archive identity ≠ semantic correctness;
- publication/readback ≠ product validation;
- same-researcher/same-model repeated checks ≠ independent replication.

## 10. Raw/result/archive accounting policy

Raw evidence'i “okumadan tamamlandı” saymayız; fakat her raw artefaktı yeni semantic source diye de çoğaltmayız.

Devamda:
1. evidence subdir başına RESEARCH/SOURCES/SPEC/RESULT/PUBLICATION/NOT-RUN rotası recover edilir;
2. JSON RESULT/MANIFEST'teki material observation fields gerektiğinde okunur;
3. Python source/probe copies yalnız claim identity/oracle için gerekiyorsa okunur;
4. duplicate blobs tek evidence lineage olarak hesaba katılır;
5. binary diagnostic archives manifest/member identity üzerinden account edilir, text-read iddiası yapılmaz.

## 11. Current interpretation risks

- Hermes source-study aktif ve partial olduğundan source research'in açık Q/residual'ları concepts tarafından çözülmüş gibi kapatılmamalı.
- Eski “next” cümleleri current concepts authority değildir.
- Aynı terim farklı mechanism'de farklı anlam taşıyabilir: örneğin `completed`, `waiting`, `session`, `claim`, `result`, `memory`, `skill use`.
- UI/profile/status labels actual durable/runtime effect ile eşitlenmemeli.
- User/model/curator/worker/provider gibi actors'in role, technical capability, maintenance authority, current approval ve effect ownership semantics'i ayrılmalı.

## 12. Devam noktası

**Hermes Agent concepts package kapandı.**

Normal seri sonraki paket: `research/studies/ecc/`.

Yeni oturum/tur:
1. current main + concepts STATE/INDEX;
2. ECC package canonical preflight;
3. actual ECC tree + META/STATE/INDEX/cold-start recovery;
4. source-study status ile concepts status'u ayır;
5. study-by-study contextual extraction'a devam et.

Hermes yeniden current work yapılmaz. Yalnız:
- source-study tree değişirse,
- somut transfer omission bulunursa,
- H5 closure hesabında yanlış path/qualifier ortaya çıkarsa

delta olarak yeniden açılır.

B7/B8 shared terminology aşaması hâlâ başlamaz; ECC ve sıradaki studies serial extraction devam eder.
