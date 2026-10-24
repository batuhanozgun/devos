# gstack — Evidence, verification, memory and continuity terms

2026-09-20, **B6-T14**. TERMS.md'nin bağlı parçasıdır. Bu dosya gstack araştırmasındaki testing/eval/oracle, memory/learnings/GBrain, freshness/invalidation, evidence provenance ve continuity kullanımlarını taşır.

## 1. Verification pipeline and evidence standing

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-E01 — verification standing | Bir claim/artifact/work result için hangi evidence route/oracle/execution üzerinden ne ölçüde destek bulunduğu. | testing/cross-system. |
| GST-E02 — evidence provenance | Evidence'ın hangi source/effect, command, runtime, branch/SHA, model/judge ve attempt'tan geldiği. | testing/cross-ground. |
| GST-E03 — oracle | Test/review/judge/readback'ın success/failure claim'ini nasıl belirlediği. | testing/review. Oracle validity ayrı question. |
| GST-E04 — structural test | Generated source/frontmatter/config/path/invariant gibi implementation structure'ı deterministic kontrol eden test. | testing. Model workflow behavior'ını otomatik kanıtlamaz. |
| GST-E05 — behavioral E2E | Real agent/runtime üzerinden selected workflow behavior'ını gözleyen test. | testing. External integration real olmak zorunda değil. |
| GST-E06 — real-agent E2E | Separate Claude/Codex process'i gerçek tool calls/transcript/turns ile çalıştıran test family. | testing. |
| GST-E07 — simulated external effect E2E | Real agent çalışırken GitHub/deploy/browser gibi dangerous external boundary'nin promptla simulate edildiği E2E. | testing/deploy. Live integration proof değil. |
| GST-E08 — external-host E2E | Codex/Gemini gibi non-primary host/runtime'ın actual CLI behavior'ını test eden family. | testing/host. Runtime availability load-bearing. |
| GST-E09 — LLM-as-judge | Semantic quality/rubric score'u another model ile değerlendiren probabilistic oracle. | testing. Independent truth değil. |
| GST-E10 — judge calibration | Score thresholds'ın exact judge model/rubric history'sine bağlanması. | testing. Model-independent absolute score değil. |
| GST-E11 — deterministic-first oracle | Parser/schema/direct check ile kurulabilecek facts'i LLM judge'a bırakmama yaklaşımı. | testing. |
| GST-E12 — outcome judge | Known planted ground-truth bugs ile agent report'unu semantic olarak eşleyen judge. | testing. Ground truth strong, matching hâlâ model-mediated. |
| GST-E13 — coverage-routing registry | Hangi skill/test'in gate/periodic verification routes'unda yer aldığını belirleyen metadata surface. | testing. Behavioral confidence score değil. |
| GST-E14 — skill coverage floor | Her skill için minimum generated/frontmatter/body structural checks. | testing. Behavior exercised demek değil. |
| GST-E15 — gate tier | Fast/PR-blocking intended verification tier. | testing. |
| GST-E16 — periodic tier | Deeper/expensive weekly/on-demand verification tier. | testing. Explicit exclusions olabilir. |
| GST-E17 — periodic exclusion | Known never-green/hardware-dependent periodic test'in tracked exception olarak route dışında tutulması. | testing. Controlled debt, evidence gap devam eder. |
| GST-E18 — canonical paid-test set | API/external/e2e cost taşıyan tests'in one authoritative ownership list'i. | testing. Orphan paid tests'i önler. |
| GST-E19 — touchfile selection | Diff/touchfile/dependency metadata ile hangi tests'in selected olacağını belirleme. | testing. |
| GST-E20 — fail-toward-more-work selection | Selector/map/git uncertainty olduğunda fewer tests yerine RUN ALL/keep shard gibi extra work seçme. | testing. |
| GST-E21 — inert demotion | Registry periodic derken test file'ın kendi gate predicate'i yüzünden hiç periodic çalışmaması. | testing. Cross-surface alignment check ile yakalanır. |
| GST-E22 — planner manifest | Paid verification için once-computed selected/skipped shard/slice planı. | testing. |
| GST-E23 — executor slice | Manifest'in assigned partition'ını çalıştıran isolated execution unit. | testing. |
| GST-E24 — fail-closed reconciliation | Planned slice/shard/result artifact eksikse green rapor üretmeyen final reconciler. | testing. |
| GST-E25 — strict output classifier | Process exit status yanında failure lines/unhandled errors/file counts/test counts/pass/skip census'i yorumlayan wrapper. | testing. |
| GST-E26 — process exit 0 ≠ suite passed | Runtime success code'un semantic test success'u tek başına kanıtlamaması. | testing. |
| GST-E27 — execution census | Kaç selected test/file'ın gerçekten executed/pass/skip olduğunu standing'e dahil etme. | testing. |
| GST-E28 — passed-empty / hollow shard | Selected shard exit 0 olsa da zero executed tests bulunması. | testing. EVALS_ALL altında failure. |
| GST-E29 — verified nothing | All-selected tests self-skip olduğunda green process'in positive coverage olmadığını açık etiketleme. | testing. |
| GST-E30 — startup timeout | External agent/API'nin hiç meaningful response başlamadan availability/queue failure'a düşmesi. | testing session runner. |
| GST-E31 — work timeout | Agent work başladıktan sonra execution budget'ın aşılması. | testing. Startup failure ile ayrı. |
| GST-E32 — process-group termination | Timeout/cancel sonrası child subprocesses dahil execution group'un gerçekten öldürülmesi. | testing. Cleanup verification correctness'ın parçası. |
| GST-E33 — eval artifact | Test/eval result + cost/duration/attempt/transcript/model/timing/judge/provenance metadata taşıyan JSON evidence artifact. | testing. |
| GST-E34 — partial eval accumulator | Long run sırasında atomic olarak ilerleme/evidence koruyan _partial artifact. | testing. Completed run değil. |
| GST-E35 — finalized eval result | Run completion sonrası baseline/flake/comparison için eligible artifact. | testing. |
| GST-E36 — partial qualification loss | eval-list/eval-summary gibi consumers'ın _partial artifact'i ordinary run gibi göstermesi. | testing negative finding. |
| GST-E37 — baseline | Current finalized result ile historical comparable result arasındaki reference run. | testing. |
| GST-E38 — NO BASELINE | Comparable matched tests yoksa regression hakkında claim üretmeme standing'i. | testing. |
| GST-E39 — matched-test count | Baseline comparison'ın gerçekten aynı test names üzerinde ne kadar overlap içerdiği. | testing. |
| GST-E40 — flaky retry | İlk attempt fail edip later retry pass olan outcome. | testing. Final green içinde kaybolmaz. |
| GST-E41 — flake history | Retried passes/failure rates'in multi-run time-series reliability standing'i. | testing. |
| GST-E42 — evidence class | Structural, live-agent, external-runtime, browser, judge, source-readback vb. farklı proof strength/topology class. | testing/cross-system. |
| GST-E43 — green as derived view | UI/job/test green'in route/execution/oracle/finality bilgisi olmadan authoritative verification primitive olmaması. | testing core negative. |
| GST-E44 — independent verification | Common-source/model/oracle dependence'den yeterince ayrılmış verification evidence. | testing/multi-agent. Same-family/cross-model agreement tek başına sağlamaz. |

## 2. Memory, learnings and context continuity

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-E45 — memory plural | Checkpoint, local learning, GBrain cache/page ve trust/ingest channels'ın tek generic “memory” sayılmaması. | memory synthesis. |
| GST-E46 — context checkpoint | Session/conversation + git/work summary'ını durable Markdown handoff olarak saklama. | memory synthesis. Current truth değil. |
| GST-E47 — /context-save | No-code-change checkpoint creation workflow. | memory synthesis. |
| GST-E48 — /context-restore | Branch-aware newest checkpoint recovery workflow. | memory synthesis. |
| GST-E49 — branch-aware restore | Current branch checkpoint'ini prefer edip gerekirse other-branch handoff'u mismatch etiketiyle kullanma. | memory synthesis. |
| GST-E50 — checkpoint semantic staleness | Newest checkpoint'in LLM-authored claims'inin current source ile artık doğru olmayabilmesi. | memory synthesis. |
| GST-E51 — local learning | Project-scoped reusable insight row; source/confidence/files/time metadata taşır. | memory synthesis. |
| GST-E52 — observed learning | Model/work observation kaynaklı learning type. | memory synthesis. Age-based confidence decay uygulanabilir. |
| GST-E53 — user-stated learning | Explicit user statement/preference kaynaklı learning type. | memory synthesis. Normal decay uygulanmaz ve cross-project trust için stronger standing alır. |
| GST-E54 — inferred learning | Model inference kaynaklı learning type. | memory synthesis. Decay ve fallibility korunur. |
| GST-E55 — cross-model learning | Another-model observation/challenge kaynaklı learning type. | memory synthesis. |
| GST-E56 — latest-winner | Aynı key+type için append-only history içinden newest row'un operational winner olması. | memory synthesis. |
| GST-E57 — effective-confidence decay | observed/inferred rows'ın age ile lower confidence alması. | memory synthesis. Universal forgetting policy değil. |
| GST-E58 — trusted cross-project learning | Foreign project learning'in ancak trusted===true ise current project search'üne girebilmesi. | memory synthesis. |
| GST-E59 — learning ingestion filter | Instruction-like/prompt-injection-shaped insight'ın persistence öncesi reject edilmesi. | memory synthesis. Heuristic defense. |
| GST-E60 — /learn | Recent/search/add/prune/export/stats gibi local-learning management workflow. | memory synthesis. |
| GST-E61 — pruning / reconciliation | Missing files/contradictions/staleness üzerinden candidate learnings'i user-approved remove/reconcile etme. | memory synthesis. Semantic judgment partly model-assisted. |
| GST-E62 — GBrain | External/typed brain memory surface integrated with planning. | memory synthesis. Semantic correctness independently validated değil. |
| GST-E63 — brain entity | user-profile/product/goals/recent-decisions/salience gibi typed cache/retrieval unit. | memory synthesis. |
| GST-E64 — scope | Entity'nin cross-project veya project-bound applicability'si. | memory synthesis. |
| GST-E65 — TTL | Cache entity'nin time-based freshness window'u. | memory synthesis. |
| GST-E66 — byte budget | Model context'e girecek digest'in bounded size limit'i. | memory synthesis. |
| GST-E67 — per-skill memory subset | Planning skill'in yalnız relevant brain entity classes'ını alması. | memory synthesis. Global context flooding yok. |
| GST-E68 — cache validity | File existence'tan ayrı TTL/schema/endpoint/project/invalidation/meta state ile currentness. | memory synthesis. |
| GST-E69 — warm | Current valid cache digest standing. | memory synthesis. |
| GST-E70 — cold-refreshed | Cache lookup sırasında source'dan refresh edilip current content üretilmesi. | memory synthesis. |
| GST-E71 — stale-fallback | Refresh başarısızken older cached content'in explicit stale status ile kullanılabilir olması. | memory synthesis. |
| GST-E72 — missing | Usable cache/digest bulunmaması. | memory synthesis. |
| GST-E73 — hidden stale qualifier | Cache CLI stale-fallback status'u stderr'de taşırken planning resolver'ın stderr'i suppress edip old payload'ı qualifier'sız inject etmesi. | memory synthesis negative finding. |
| GST-E74 — background refresh | Current invocation'ı block etmeden future invocation için cache'i warm etmeye çalışma. | memory synthesis. Current-turn hidden staleness'i düzeltmez. |
| GST-E75 — salience allowlist | Sensitive categories'i local cache persistence öncesi prefix policy ile exclude eden privacy filter. | memory synthesis. Semantic privacy proof değil. |
| GST-E76 — user-profile cross-project scope | Stable personal calibration'ın deliberate project-crossing entity olması. | memory synthesis. Larger blast radius. |
| GST-E77 — endpoint trust | Brain endpoint'in personal/shared/unset trust standing'i. | memory synthesis. |
| GST-E78 — repo GBrain policy | Per-remote read-write/read-only/deny data-movement authority. | memory synthesis. |
| GST-E79 — unattended policy fail-closed | Batch ingest'te saved policy store unreadable/corrupt ise writes başlamadan hard stop. | memory synthesis. |
| GST-E80 — memory ingest | Transcript/artifact/learnings'i policy, SHA, secret/accounting checks ile persistent brain'e taşıma. | memory synthesis. |
| GST-E81 — evidence-of-effect ingest | Importer exit 0 yerine parseable/accountable result ile actual landed data standing'i arama. | memory synthesis. |
| GST-E82 — sync multidimensional standing | Code index, memory ingest, artifact sync, brain availability, cache freshness'in bağımsız healthy/degraded/absent olabilmesi. | memory synthesis. |
| GST-E83 — active decision input | Brain context'in question selection/recommendation/conflict framing'i değiştirebilmesi. | memory synthesis. Passive search değil. |
| GST-E84 — planned write-back / disabled capability | Calibration write-back contract generated/tested olsa da pinned revision'da feature flag/upstream capability nedeniyle generally inactive olması. | memory synthesis. |

## 3. Freshness, invalidation and representation fidelity

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-E85 — freshness | Representation/evidence/standing'in represented current object/state için hâlâ geçerli olması. | cross-system/cross-ground. |
| GST-E86 — object-relative freshness | Review, plan, cache, daemon, generated skill gibi farklı objects için currentness rule'un farklı olması. | review/memory/self-development. |
| GST-E87 — invalidation | Underlying object/source/context değişince prior refs/cache/review/generated output/standing'in geçersiz kılınması. | cross-system M8. |
| GST-E88 — qualification metadata | Payload'ın current/stale/partial/unverified/trusted/approved vb. epistemic/control standing'ini taşıyan metadata. | cross-system. |
| GST-E89 — qualification loss | Payload downstream view'de kalırken stale/partial/degraded qualifier'ın kaybolması. | GBrain/evals/update/rollback examples. |
| GST-E90 — source→view fidelity | Derived view'in source payload + relevant qualifier/identity/standing'i doğru taşıma derecesi. | multiple syntheses. |
| GST-E91 — representation ≠ referent | Report/status/cache/doc'un actual underlying Work/Environment/effect ile aynı şey olmaması. | four-ground Information. |
| GST-E92 — historical evidence ≠ current standing | Security/deploy/review/checkpoint/retro artifact'in current object condition'ı otomatik temsil etmemesi. | cross-system/four-ground. |
| GST-E93 — provenance | Representation/evidence'ın source, producer, target, version, method/oracle lineage'i. | testing/memory/cross-ground. |
| GST-E94 — confidence | Evidence/learning/finding'in support degree'ünü taşıyan qualification dimension. | memory/security/review. |
| GST-E95 — trust | Cross-project/brain/source eligibility veya authority'de consumer'ın kullanabilme standing'i. | memory/browser. Truth ile aynı değil. |
| GST-E96 — partial / final | In-progress evidence artifact ile completed/finalized evidence artifact'in ayrımı. | testing. |
| GST-E97 — current / stale / unknown | Review/cache/evidence gibi artifacts için current applicability standings. | review/memory. |
| GST-E98 — missing coverage | Optional verifier/model/runtime'ın çalışmamasının “clean” yerine explicit evidence gap olarak surfaced edilmesi. | multi-agent/testing. |
| GST-E99 — no measurement ≠ positive standing | Dead security status, all-skip test, unavailable scanner gibi ölçüm yokluğunun “safe/green” sayılamaması. | browser/testing. |
| GST-E100 — continuity with degraded epistemic status | Work'ü block etmemek için stale/partial evidence kullanabilmek ama degradation qualifier'ını kaybetmeme gereği. | memory/cross-system. |

## 4. Evidence/continuity relation view

gstack'te bir evidence claim'in güçlü anlamı şu zincire bağlıdır:

**source/effect → actual observation/execution → oracle/classifier → provenance + qualifier → aggregation/view → current consumer → decision/control.**

Bir link kaybolduğunda “green”, “current”, “memory”, “verified”, “complete” gibi labels gereğinden güçlü hale gelebilir.

Memory tarafında da:

**prior event/decision → chosen representation → provenance/confidence/scope/freshness → trust/privacy/ingest policy → retrieval/selection → current context → recommendation/decision → optional write-back/invalidation.**

Bu nedenle “memory exists” veya “test exists” kendi başına operational truth değildir.
