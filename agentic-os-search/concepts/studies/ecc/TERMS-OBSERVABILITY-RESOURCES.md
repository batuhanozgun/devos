# ECC — Readiness, telemetry, resource and operator-consumer uses

2026-09-23 · **C6 post-U12 transfer / U14-A–C source-family extraction.** Bu dosya ECC research package'indeki U14-A/B/C kullanımlarını bağlamıyla taşır. OR kimlikleri product architecture primitive'i, evrensel observability taxonomy'si veya SOUL/Development OS kararı değildir.

Kaynak:
- Note30 / U14-A sources / MR31 / publication receipt.
- Note31 / U14-B sources / MR32 / publication receipt.
- Note32 / U14-C sources / MR33 / publication receipt.
- Fixed upstream target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
- U14 tests inspected, not run; no new Concepts execution.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-OR01–OR24 | [Note30](../../../research/studies/ecc/notes/30-READINESS-PREDICATES-AND-OPERATOR-PROJECTIONS.md) §§1–8 → [U14-A ledger](../../../research/studies/ecc/evidence/U14-A-SOURCES.md) → [MR31](../../../research/studies/ecc/ROUND-U14-A.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U14-A.md) | Research-author synthesis over fixed-pin SOURCE OBSERVATION, TEST-SOURCE-INSPECTED and dated interface contracts; tests not run. |
| ECC-OR25–OR54 | [Note31](../../../research/studies/ecc/notes/31-TOOL-ACTIVITY-INGESTION-AND-RISK-USE.md) §§1–9 → [U14-B ledger](../../../research/studies/ecc/evidence/U14-B-SOURCES.md) → [MR32](../../../research/studies/ecc/ROUND-U14-B.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U14-B.md) | Research-author synthesis and conditional inference over source/test definitions; no telemetry execution. |
| ECC-OR55–OR82 | [Note32](../../../research/studies/ecc/notes/32-USAGE-COST-CONTEXT-AND-RESOURCE-CONTROL.md) §§1–9 → [U14-C ledger](../../../research/studies/ecc/evidence/U14-C-SOURCES.md) → [MR33](../../../research/studies/ecc/ROUND-U14-C.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U14-C.md) | Research-author synthesis and source-derived arithmetic/conditional paths; no billing/provider/resource-control run. |

The Note carries the researcher's explanation; the ledger carries original path/blob/read/evidence class. MR/receipt are method/publication context, not independent corroboration.

## 1. Readiness and projection

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-OR01 — observability-readiness | Named repository files/markers/example shape üzerinden local source/document preparedness rubric'i. | Live telemetry delivery/readiness sensor değil. |
| ECC-OR02 — readiness check | Rubric içindeki existence/literal-marker/JSON-key predicate. | Referenced behavior'ın çalıştığı veya test edildiği proof değil. |
| ECC-OR03 — readiness point | Check'e assigned fixed weight; ten check toplamı21. | Confidence probability, completion percentage veya impact score değil. |
| ECC-OR04 — readiness score | Passed check weights sum'ı. | Actual observed platform/work quality metric değil. |
| ECC-OR05 — `ready` | O-GATE'te full21-point predicate; O-PLATFORM/O-DASH'te farklı producer predicates de aynı label'ı kullanabilir. | Label equality = predicate equality değil. |
| ECC-OR06 — marker-ready fixture | Literal expected tokens ve minimal JSON shape ile checker contract'ını satisfy eden test fixture. | Runnable telemetry implementation veya production readiness değil. |
| ECC-OR07 — report false / command success | O-GATE CLI report `ready=false` olsa da normal process return'un zero kalabilmesi. | Readiness never gates anything demek değil; test/suite/CI consumer ayrıca vardır. |
| ECC-OR08 — verdict-consuming test | Current-repository readiness JSON'unu parse edip `ready=true` assert eden test path'i. | Test run edildi veya release universally gates on it demek değil. |
| ECC-OR09 — suite propagation | Root test runner'ın failing subprocess/assertion'ı aggregate nonzero'ya taşıması. | All CI/release paths require same suite guarantee değil. |
| ECC-OR10 — platform audit | Git status + selected gh reads + historical document predicates → checks/totals/ready report. | Complete live platform truth veya atomic snapshot değil. |
| ECC-OR11 — skipped source | GitHub/repo source'un explicit skipped standing'i. | Clean/empty source ile aynı değil. |
| ECC-OR12 — failed source with fallback zero | Selected read fail olduğunda zero/empty fallback + error details. | Zero actual population veya clean state değil. |
| ECC-OR13 — `githubErrors` | Platform producer'da selected read failures listesi. | Renderer'ın her view'unda korunacağı guarantee değil. |
| ECC-OR14 — dashboardReady | Operator dashboard'da platformReport.ready projection'ı. | Objective `ready`, publicationReady veya accepted release değil. |
| ECC-OR15 — objective ready | Objective requirements'ın current/complete predicate'i. | platformReady/publicationReady ile aynı değil; ordinary builder bazı rows için terminal state üretemeyebilir. |
| ECC-OR16 — publicationReady | Pinned dashboard builder'da conservative false publication standing'i. | Authenticated release authority veya actual release decision değil. |
| ECC-OR17 — requirement row | Historical/current source/document/probe predicates'ten constructed operator checklist item. | Underlying external activity'nin re-performed evidence'i değil. |
| ECC-OR18 — overview `Current` | Markdown renderer'ın counts/skipped status gibi reduced fields üzerinden high-level label'ı. | Detailed requirement/producer error-free standing'i değil. |
| ECC-OR19 — producer/renderer threshold divergence | Producer configurable `<= max` ile Markdown fixed `<20`/zero threshold'larının ayrışması. | Observed operator mistake değil; source-level projection mismatch. |
| ECC-OR20 — selected population | gh PR/issue returned rows veya discussions first100/comments20 sampling population'ı. | Whole remote population guarantee değil. |
| ECC-OR21 — sample metadata | Discussion helper total/sample count fields. | Downstream verdict completeness gate'i olarak kullanıldığı anlamına gelmez. |
| ECC-OR22 — generatedAt | Report construction timestamp. | Inputs'in aynı anda gözlendiği veya evidence freshness guaranteed demek değil. |
| ECC-OR23 — reported head | Later Git HEAD query/result. | Working-tree/uncommitted/historical inputs'i cryptographically bağlamaz. |
| ECC-OR24 — report write | Optional generated report'in inspection sonrası filesystem write'ı. | Post-write source state'in yeniden doğrulandığı anlamına gelmez. |

## 2. Tool-activity capture, import and visibility

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-OR25 — PostToolUse capture chain | dispatcher/profile → activity tracker → JSONL → StateStore import → tool_log → TUI timeline. | Every host/tool/failure event captured guarantee değil. |
| ECC-OR26 — environment session identity | Tracker'ın ECC_SESSION_ID, fallback CLAUDE_SESSION_ID üzerinden row identity/correlation seçimi. | Native JSON `session_id` consumption veya authenticated identity değil. |
| ECC-OR27 — native tool-call identity | Host contract'taki tool_use_id/session_id gibi event identity. | Tracker'ın generated local row ID'siyle aynı değil. |
| ECC-OR28 — local hook-event ID | Tracker'ın time/random generated row identity'si. | Exactly-once native event identity veya replay dedup key'i değil. |
| ECC-OR29 — output summary | Tracker'ın `tool_output` üzerinden bounded summary'si. | Documented native `tool_response` otomatik taşınır demek değil. |
| ECC-OR30 — placeholder duration | Tracker'ın duration_ms=0 kaydı. | Measured instantaneous duration veya host-provided duration değil. |
| ECC-OR31 — metrics path correspondence | Writer data-home path ile Rust DB-parent-derived metrics path'in aynı file'a işaret etme şartı. | Ortak basename/session label bunu garanti etmez. |
| ECC-OR32 — full-file replay import | Importer'ın JSONL'ı baştan okuyup valid rows'i işlemesi. | Append cursor/exactly-once stream semantics değil. |
| ECC-OR33 — per-pass event uniqueness | Aynı pass içinde first occurrence of hook-event ID'nin aggregate kullanımı. | Native delivery idempotence veya immutable event content değil. |
| ECC-OR34 — persisted tool-log uniqueness | Unique hook_event_id + INSERT OR IGNORE ile existing log row duplication guard. | Current-file counters/projections aynı old row'u ignore eder demek değil. |
| ECC-OR35 — current-file aggregate | Current readable JSONL rows'dan recomputed tool_calls/files_changed counters. | Durable historical total değil. |
| ECC-OR36 — retained historical tool log | Current source file shrink/empty olsa da prior tool_log rows'in DB'de kalabilmesi. | Counters/history same population demek değil. |
| ECC-OR37 — file absent semantics | Metrics source file yoksa importer'ın current counters'ı yeniden hesaplamadan return etmesi. | Zero current activity veya fresh retained counter proof değil. |
| ECC-OR38 — empty/all-invalid source semantics | Existing but no accepted rows ile session counters'ın zero'lanabilmesi. | Historical log silindi veya no activity ever demek değil. |
| ECC-OR39 — files_changed aggregate | Accepted rows'daki unique nonempty file_path sayısı. | Verified modified/committed files değil; Read paths dahil olabilir. |
| ECC-OR40 — deleted-parent replay failure | Deleted session'ın retained JSONL event'i later FK insertion'ı abort edebilen conditional replay path. | Observed incident/frequency veya referential integrity yokluğu değil. |
| ECC-OR41 — partial import effect | Whole importer transaction olmayınca later failure'dan önceki inserts/projections'ın kalabilmesi. | Every error partial effect üretir demek değil. |
| ECC-OR42 — attempted-file signature | TUI'nın source signature'ını import success'ten önce cache'leyebilmesi. | File successfully consumed receipt değil. |
| ECC-OR43 — caller-specific recovery | TUI import error'ını catch edip other enforcers'a devam ederken CLI helper'ın error propagate etmesi. | One universal telemetry retry/freshness policy yok. |
| ECC-OR44 — TUI timeline | Latest bounded stored tool entries'in parsed/rendered operator view'i. | Complete execution archive veya actor uptake/acceptance değil. |
| ECC-OR45 — visible timestamp filter | Stored nonempty timestamp parse edilemiyorsa timeline'da omit edilebilmesi. | Row storage absence değil. |
| ECC-OR46 — query-error empty view | Timeline query failure'ın empty visible list'e collapse edebilmesi. | No stored activity proof değil. |

## 3. Risk, conflict and sanitation

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-OR47 — tool risk score | Tool type + bounded input-summary patterns üzerinden deterministic heuristic score. | Calibrated harm probability veya semantic effect proof değil. |
| ECC-OR48 — SuggestedAction | Risk score/reasons'dan allow/review/confirm/block advice. | Observed PostToolUse path'te pre-action authorization/enforcement değil. |
| ECC-OR49 — retrospective risk | Tool already-reported event üzerinde hesaplanan standing. | Prevention guarantee değil. |
| ECC-OR50 — file conflict control | Typed file activity overlap + configured strategy üzerinden incident/decision/message ve selected session stop effect'i. | Risk SuggestedAction consumer'ı veya accepted merge outcome değil. |
| ECC-OR51 — conflict strategy | Merge/LastWriteWins gibi overlap-control policy choice. | File content correctness/semantic merge proof değil. |
| ECC-OR52 — sanitized input summary | Selected secrets/length/depth controls uygulanmış input-derived representation. | All derived/enriched later fields sanitized guarantee değil. |
| ECC-OR53 — Git-enriched preview | Working-tree diff'ten selected raw lines ile enriched before/after preview. | One tool call'a causally isolated delta veya re-sanitized secret-safe representation değil. |
| ECC-OR54 — working-tree attribution | Git diff'in index'e göre current working-tree change population'ı. | Displayed line'ın current event tarafından üretildiği proof değil. |

## 4. Cost, context and hard-control contracts

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-OR55 — cumulative cost snapshot | Stop-time cost writer'ın session transcript'ten current cumulative total row append etmesi. | Per-turn/per-event delta değil. |
| ECC-OR56 — message-ID usage dedup | Transcript'te same message.id için last usage'yı tutup repeated content lines'i toplamdan ayırma. | Independent request identity veya billing reconciliation değil. |
| ECC-OR57 — last-row cumulative reader | JavaScript bridge'in complete costs file içinde latest matching session row seçimi. | Rust importer'ın aynı contract'ı kullandığı anlamına gelmez. |
| ECC-OR58 — SUM importer | Rust cost importer'ın matching rows'in input/output/cost değerlerini toplaması. | Producer cumulative ise latest represented total değil. |
| ECC-OR59 — cumulative/delta contract mismatch | cost3→cost7 cumulative rows'in JS=7, Rust=10 olması gibi source-derived composition boundary. | Observed overcharge/stop incident değil; genuine delta producer countercase'i vardır. |
| ECC-OR60 — hard-budget predicate | Stored aggregate usage/global limits ve active eligible session standing'i üzerinden stop selection. | Provider billing reservation, zero overshoot veya accepted task outcome değil. |
| ECC-OR61 — budget population | Global aggregate'in terminal dahil stored sessions population'ı. | Daily/project/current-run allowance otomatik değil. |
| ECC-OR62 — token quantity | Rust importer/enforcer'da input+output tokens. | Cache read/write token categories veya provider invoice token definition'ı değil. |
| ECC-OR63 — cost identity priority | Writer/bridge/monitor'ın JSON session_id'yi env IDs'den önce seçmesi. | Tool-activity identity policy'siyle aynı değil. |
| ECC-OR64 — unknown-session cost row | Rust exact UPDATE id eşleşmezse zero affected rows ile geçebilen row. | Tool-log FK missing-parent failure policy'si değil. |
| ECC-OR65 — no-measurement zero | Missing/unreadable/no accepted usage + no cache durumunda newly written zero estimate. | Observed zero usage veya completeness flag değil. |
| ECC-OR66 — retained stale Rust cost | Missing/empty/all-invalid cost source bazı paths'te existing stored values'i bırakabilir. | Fresh current spend proof değil. |
| ECC-OR67 — last-model pricing | Aggregate transcript usage'nın last known model's rate table'ıyla fiyatlanması. | Per-message model attribution veya current provider tariff/billing değil. |
| ECC-OR68 — harness-cost cache | Fresh finite/nonnegative optional cost estimate override. | Built-in statusline tarafından üretildiği, authoritative billing veya same accounting period olduğu guarantee değil. |
| ECC-OR69 — estimate source opacity | Stored row'un transcript vs optional cache source'un hangisinin cost'u sağladığını taşımaması. | Value yanlış olmak zorunda değil; provenance loss'tur. |
| ECC-OR70 — context occupancy sample | Native statusline remaining_percentage'nin shared bridge'de tutulması. | Context semantic usefulness veya complete history değil. |
| ECC-OR71 — shared activity clock | Context freshness check'in field-specific observation age yerine bridge last_timestamp kullanması. | Context value gerçekten güncel proof değil. |
| ECC-OR72 — stale-context refresh | Old context value korunurken later tool bridge update'in shared timestamp'i yenilemesi. | Observed stale warning incident değil. |
| ECC-OR73 — fresh-context stale classification | Statusline fresh context write yapıp bridge timestamp yenilemezken monitor'ın old timestamp nedeniyle değeri stale sayabilmesi. | Every configuration'da oluşmaz; bridge hook selection karşı koşuldur. |
| ECC-OR74 — adjusted context bar | Display denominator'ında fixed16.5-point buffer sonrası rendered used percentage. | Monitor raw threshold veya native true remaining percentage ile aynı değil. |
| ECC-OR75 — unique-temp atomic replacement | Shared bridge write'ta unique temp + rename retry ile structurally complete replacement. | Concurrent read-modify-write logical update preservation/CAS değil. |
| ECC-OR76 — logical lost-update interleaving | Two writers same old snapshot'tan başlayıp later replacement ile each other's newer fields'i overwrite edebilen conditional path. | Executed concurrency incident değil. |
| ECC-OR77 — additionalContext warning | Monitor'ın context/cost/scope/loop advisory output'u. | Acknowledged delivery, model obedience veya process stop değil. |
| ECC-OR78 — warning tier state | Dedup/escalation için last emitted tier persistence. | Consumer receipt veya condition resolution değil. |
| ECC-OR79 — persist-before-delivery | Warning state outer output delivery/uptake'tan önce yazılabilir. | Message delivered guarantee değil; retry suppression etkisi olabilir. |
| ECC-OR80 — informational cost warning | Source text'te explicitly informational advice. | Hard quota enforcement veya budget reservation değil. |
| ECC-OR81 — resource-control stop | Rust budget controller'ın eligible session'ı worktree-preserving stop path'ine göndermesi. | Process-tree gone, useful output preserved veya goal acceptance guarantee değil. |
| ECC-OR82 — warning/control non-collapse | Advisory additionalContext ile Rust hard-control aynı metric family ile ilişkili olsa da distinct purposes/consumers. | Tek universal budget service değildir. |

## 5. U14 relation view

- marker readiness ≠ runtime signal readiness;
- report `ready` ≠ process failure;
- process success ≠ report positive;
- platform error ≠ skipped source ≠ actual zero;
- dashboardReady ≠ objective ready ≠ publicationReady;
- current high-level label ≠ detailed error-preserving view;
- returned sample ≠ whole population;
- generatedAt/head ≠ atomic evidence snapshot;
- native event ID ≠ local row ID;
- stored row ≠ visible row ≠ complete archive;
- replay identity ≠ capture identity;
- current-file counters ≠ retained history;
- importer attempted ≠ importer succeeded;
- risk suggestion ≠ pre-action gate;
- retrospective risk ≠ conflict stop;
- sanitized input ≠ sanitized Git enrichment;
- cumulative snapshot ≠ delta;
- last cumulative row ≠ SUM of cumulative rows;
- estimated cost ≠ billed spend;
- context sample age ≠ shared activity age;
- atomic replacement ≠ serializable logical update;
- warning prepared ≠ warning delivered ≠ warning obeyed;
- informational warning ≠ hard stop;
- hard stop decision ≠ accepted work outcome.

Tests and external docs in U14 remain their original evidence classes. No U14 target code/test was executed by Concepts. Stronger installed/live/completeness/authority/effectiveness questions remain source-study residuals, not automatic Concepts experiments.
