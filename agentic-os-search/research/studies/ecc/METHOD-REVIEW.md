# ECC — Method Evaluation and Evolution

**Purpose:** araştırma yöntemini sonuçlardan bağımsız dokunulmaz kılmamak; iyi/kötü değişiklikleri gerçek etkileriyle gelecekte kullanılabilir vaka olarak korumak. Current method METHOD'dadır; burada revision rationale ve etki kaydı tutulur. Henüz effectiveness doğrulaması yoktur.

## What will be evaluated

| Boyut | Bakılacak somut işaret | Yanlış başarı ölçüsü |
|---|---|---|
| Amaç ve kapsam | Seçilen soru ana açıklamayı değiştirdi mi; kritik production/consumer/etki perspektifi kaçtı mı? | Çok dosya okumak veya çok yeni başlık açmak |
| Kaynak ve anlam | Bir üst sonucu exact kaynağa ve caveat'ine geri götürebiliyor muyuz? | Link bulunması veya özetin akıcılığı |
| Keşif / karşı-sınama | Yeni aile/alternatif eski frame'i düzeltti mi; aleyhte bulgu gerçekten arandı mı? | Her checklist satırına evet yazılması |
| Devralma | Repo-only girişte doğru amaç, yetki, açık iddia ve sonraki soru recover edildi mi? | Dosyaların yalnız var olması |
| Verim / yük | Tekrar okuma, gereksiz state kopyası veya kayıt gecikmesi bounded ilerlemeyi engelliyor mu? | Token/commit sayısını tek başına minimize etmek |
| Revizyon yararı | Değişiklikten sonraki birimde beklenen fark gerçekten gözlendi mi? | Yöntem dosyasının değiştirilmesi |

Bu boyutlar tek bir maturity skoru üretmez. Negatif veya inconclusive sonuç da korunur. Aynı assistant'ın gözlemi independent verification diye sunulmaz.

## MR00 — 2026-09-17 — Initial design review

**Trigger/evidence:** Kullanıcı repo merkezli süreklilik ve araştırmayla birlikte değerlendirilen yöntem istedi. gstack/Hermes/Superpowers yöntemleri full-read edildi. Foundation discussion handoff, mevcut bir araştırma perspektifinin ilk açıklamada yeterince kullanılmadığını ve owner müdahalesiyle düzeltildiğini kaydediyor. Bu tek olay yöntemimizin neden işe yarayacağını kanıtlamaz; salt kaynak varlığına güvenmemek için somut uyarıdır.

**Alternatives considered:**

- Flat file-by-file summary: coverage izi kolay, fakat aynı davranışın dağınık kaynakları ve ilişkileri kaybolabilir.
- Gstack yöntemini aynen kopyalama: iyi başlangıç, fakat ECC host/materialization farklarını ve bu yöntemin kendi gelişim kaydını yeterince ayırmaz.
- Baştan kapsamlı runtime/test kampanyası: bazı güçlü iddialar için yararlı, fakat mevcut planlama aşamasını aşar; source study'yi kurulum/ürün doğrulama işine çevirebilir.
- Seçilen: mekanizma-temelli sentez + host/lifecycle farkları + ayrı yöntem-değerlendirme döngüsü; testler iddia ve yetkiye orantılı.

**Pre-publication analytical challenges and resulting choices:**

| Challenge | v0.1'de karşılığı | Şu anda kanıtlanan sınır |
|---|---|---|
| İlk 'meta-harness' tanımı ilgisiz olmayan başka çalışma ailesini bastırırsa? | P1 native discovery; yedi aile provisional; holdout/reopen | Tasarım tercihi; gerçek omission azaltımı NOT YET OBSERVED |
| Gelecek oturum plan yazıldı diye U01'i veya installation'ı otomatik başlatırsa? | STATE'te next logical / next authorized ve açık non-authorized işler | Metinsel authority ayrımı; live-agent obedience NOT TESTED |
| Aynı skill üç kopyada görünürse üç bağımsız kanıt mı sayılacak? | Source identity/producer/consumer ve varyant test mantığı | Yöntem kuralı; actual ECC kopya taraması U01'de |
| Eski roadmap'teki bug veya alpha ifadesi bugünün gerçeği sayılırsa? | Dated screening ledger + exact source/current-path revalidation | Ön tarama overclaim riski düzeltildi; bug current state araştırılmadı |
| Bir schema testi yeşilse semantic başarı mı denecek? | Evidence class/oracle/negative-control ayrımı | Test stratejisi; ECC testi NOT RUN |
| Çok dosyalı kayıt kendi kendini kopyalayıp stale kalırsa? | Her current gerçeğe bir owner dosyası; derived index; append-only tarihçe | Yapısal tasarım; çok-tur bakım yükü NOT YET OBSERVED |

**Selected change:** METHOD/PLAN v0.1 ile baseline kuruldu; eski method sürümü varmış gibi gösterilmez. U00 review ileride bağımsız önceden-kayıtlı deney diye sayılmaz.

**Expected effect:** U01 daha az marketing-anchored bir source map üretsin; tur kapanışları claim/source/authority ayrımını korusun; yöntem sorunu çıktığında somut revizyon ve sonraki-etki kontrolü mümkün olsun.

**Observed effect so far:** Ön taramadaki bazı güçlü sınıflandırmalar soru/hipotez statüsüne çekildi; current HEAD direct ref ile sabitlendi; partial okumalar full'den ayrıldı. Bu, araştırma disiplininin başlangıçta uygulanmasıdır; uzun dönem odak, öğrenme veya genel yöntem başarısı değildir.

**Next effect check:** U01 sonunda actual family map başlangıç şemasından farklı mı; method değişimi gerekli mi; kayda ayrılan yük üretkenliği engelledi mi; başka oturumda repo-only devam denenirse doğru work/authority recovery oldu mu? Gerçek sonuç geldiğinde MR00'a bağlı yeni kayıt eklenir.

## Future revision record

`MR-ID / date / related unit and Q / old→new method or plan version`

Tetikleyici gözlem ve kaynak; değişen varsayım; gerçek alternatifler; seçilen değişiklik ve kapsam; korunacak eski bulgular; beklenen etki; nasıl/nerede gözleneceği; sonraki actual sonuç; confound/bağımsızlık sınırı; retain/revert/split/unknown kararı.

Bir tur yöntemi değiştirmediyse gerekçeli 'mevcut birim için yeterli' kısa kaydı RESEARCH-LOG'da yeterlidir. Her tur zorunlu yenilik veya method version artışı yoktur.

## Reusable case output, later

P6'da yalnız sonuçları değil, başarısız ilk çerçeveyi, gerekli source reopen'ı, boşa çıkan prosedürü ve continuity sınırını da içeren birkaç gerçek örnek seçilecek. Genel aktarılabilir çekirdek, ECC'ye özgü host/memory/installation ekleri ve henüz doğrulanmamış varsayımlar ayrılacak. Kendi örneğimizden evrensel 'en iyi yöntem' sonucu çıkarılmayacak; global control değişikliği ayrıca yetkilendirilmeli.

## MR01 — 2026-09-17 — U01-A

**Related questions:** Q01/Q02/Q03/Q08/Q10. **Versions:** METHOD 0.1 retained; PLAN 0.1 → 0.2. MR00's earlier NOT YET OBSERVED statements remain historical, not competing current assessments.

**Trigger and evidence:** [Note 01](notes/01-SURFACES-AND-CODEX-CACHE.md) and [S02–S25/E01](evidence/U01-A-SOURCES.md). The source map separated npm/Node dispatch, Rust ecc2 and a native Workflow pilot. S02's host-wide Codex instruction-backed label conflicted with the provider manifest/local README's specific SessionStart projection. S25's verifier collected four manifest reference fields while the actual manifest contained a hooks reference outside that set.

**Alternatives and decision:** Continuing the broad tree scan without resolving this seam would leave the initial host label carrying the model. Calling Codex wholly native would invert rather than fix that overgeneralization. A full live-host/installation campaign would exceed the current evidence need and practical authority. The selected path was to follow the declaration and wrappers, inspect the upstream test's oracle, then run a three-case presence-only cache probe in temporary fixtures. U01 was split so that a publishable bounded result did not masquerade as the complete inventory.

**Observed effect in this unit:** The earlier instruction-only description was corrected to an event/channel/source-specific projection with host trust/consumption still untested. A source prediction of the omitted-hook path became an observed local false-green: C1 missing hook exited 0, while C2 missing checked MCP exited 1. This demonstrates one substantive correction and a bounded falsifier produced while applying the method. It does not establish that this method is superior to alternatives, that all relevant omissions were found or that long-run research focus improved.

**What changed and what did not:** PLAN now carries U01-A/U01-B and Q01a/Q01b. The existing METHOD already required source/consumer distinctions, proportional tests and honest coverage; no new method version is manufactured for this sequencing change. Broad U01 discovery remains PARTIAL. The original full recursive discovery objective is not retrospectively counted as satisfied by a shallow map. Unexpanded regions are preserved in TREE-FRONTIER rather than silently discarded.

**Cost and limitations observed:** Connector display truncation required recovering the full root response. A direct container acquisition failed at DNS while the connector worked; offline execution was still possible. Exact checker/manifest materialization required blob identity checks. Entry/log maintenance and multi-file publication add real work; this unit supplies no timing comparison or proven optimal record count. We should not repeat unchanged full entry files merely to demonstrate activity; stable identities and selective re-entry preserve the existing progressive-retrieval method.

**Causal and verification boundary:** The checker omission is directly visible and locally exercised. A wider story about manifest evolution outrunning verifier maintenance remains a hypothesis, not an established historical root cause. The local probe was designed after reading source and used a pre-execution criterion; it is source-informed exploratory work by the same assistant, not blind independent replication. This was same-conversation re-entry, not a fresh-session comprehension test.

**Next effect check — U01-B:** Does the next map preserve all known delivery/runtime families instead of turning into a Codex bug hunt? Do source→materialization→consumer paths actually explain the distinction, or require another question split? Can U01-A's tested/unexamined boundary be recovered without rerunning and double-counting E01? Record actual outcomes, including an inconclusive result; do not reward method revision merely because it exists.

## MR02 — 2026-09-17 — U01-B

**Versions/question:** METHOD 0.1 retained; PLAN 0.2 → 0.3. Q01b/Q03a/Q08/Q10. Evidence [Note 02](notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md), [S26–S44/W01–W02](evidence/U01-B-SOURCES.md).

**MR01 effect check — observed:** U01-B did not rerun E01 or turn into a cache-defect campaign. It distinguished three delivery channels, explicit versus synthetic selection granularity, materialization transformations, Kimi ownership preflight, sequential multi-target partial results, derived health and a separately required memory CLI. The earlier Node/Rust/native-workflow distinctions remained open rather than being erased. This is one observed broadening of the source model, not a controlled comparison proving that the method caused better research.

**Problem/alternatives:** A single large recursive response was acquired but not usable as a completely reviewed inventory. Options were repeated large-response recovery, declaring the inventory complete, stopping all mechanism inquiry, or carrying the explicit frontier while proceeding through a discovered dependency. False completion was rejected. Further blanket retrieval was not the highest-value next action; stopping all mechanism research would also overstate the inventory's role as a prerequisite.

**Decision and scope:** PLAN 0.3 closes only U01-B's bounded comparison and selects U02-A ownership/partial-state recovery with a Kimi contrast. P1/full inventory remains incomplete and must be accounted for before final synthesis/closure. Bounded subtree discovery can accompany mechanism dependencies. This is an explicit sequencing decision, not a retroactive relaxation of the closure criterion. The existing METHOD already permits mechanism-first, variable-depth and source-aware inquiry, so a new method version is not manufactured.

**What remains unproven:** no new ECC execution, host test, independent cold-start or quantified efficiency comparison. More detailed records may still create maintenance/re-reading overhead; neither file count nor source volume demonstrates benefit. Current official documentation is a different temporal surface from the research pin. A compressed working view is not an exact code or blob oracle; load-bearing entry/operation/failure sections were returned to directly before finalizing the note.

**Next effect check — U02-A:** Can the ownership/state helper closure explain one changed/unowned/partial-write case without assuming all guards apply to all channels? Does Kimi provide a genuine consumer contrast rather than a new name on the same untested claim? Is P1 debt still visible, and does the study leave installation family B after a bounded useful slice rather than exhaust every variant? Retain inconclusive/negative outcomes; method revision is not itself success.

## MR03 — 2026-09-17 — U02-A

**Versions/questions:** METHOD 0.1 retained; PLAN 0.3 → 0.4. Q03a/Q03b/Q03c/Q08/Q10, next Q04. Evidence [Note 03](notes/03-OWNERSHIP-CHECKPOINTS-AND-PROJECTION.md) and [S45–S55](evidence/U02-A-SOURCES.md).

**MR02 effect check — observed:** Kimi supplied a genuine caller-policy contrast: a previous managed pathname is enough for the common copy guard to remain updateable, whereas guided preflight additionally requires operation identity and current digest. The initially-identical test case separates compatibility from ownership. Opening the actual bridge producer corrected the prior migration-specific framing: the non-Claude branch also creates bridge state. A bounded state-store listing was fully usable and preserved three newly discovered files as unread rather than claiming complete repository coverage.

**Alternatives and decision:** Treating the helper filename as its effect boundary would retain an inaccurate model. Exhausting every lifecycle variant would delay understanding Work/session control. Running a new experiment merely to produce another test count was unnecessary for the source-local predicate comparison. The selected course completes the bounded ownership explanation, retains the interrupted-guided-retry prediction as unexecuted Q03b, defers full repair/uninstall and crash/concurrency in Q03c, and selects U03-A. Source findings are not weakened merely because no new runtime experiment was run; their claim scope remains source-level.

**Observed result and limits:** The method's producer→record→consumer discipline generated a material correction and a cross-path comparison. It also exposed the difference between a pending recovery operation and a completed effect. These are same-assistant observations, not a controlled demonstration that this method outperforms alternatives. Test fixtures included narrowed copy plans, stubbed projection and injected provider functions; no assertion was counted as a pass. The exact two-file failure/second guided attempt remains untested.

**Record cost:** Continuity required updating several derived status surfaces and replacing growing append-only log files through a whole-file connector API. This is a real maintenance burden, not evidence that more records always improve focus. New source/note files were published before final metadata closure to avoid one large unpublished batch. No numerical efficiency comparison or claim of optimal file count is made. Preserve progressive retrieval; reorganize logs only if growth materially impairs use, not as an automatic side project.

**Next effect check — U03-A:** Does the next source unit leave installation family B while preserving Q03b/Q03c and P1 debt? Does it recover actual session/work producers and consumers instead of assuming that installation JSON/projection semantics govern every other entity? Does a recorded status correspond to a query, an approval condition or an actual effect? Record an inconclusive answer rather than forcing a control-plane narrative. Method version changes remain evidence-driven, not a quota.

## MR04 — 2026-09-17 — U03-A

**Versions/questions:** METHOD 0.1 retained; PLAN 0.4 → 0.5. Q04a–d/Q08/Q10. Evidence [Note 04](notes/04-WORK-SESSION-RECORDS-AND-CONTROL.md), [S56–S69/W03–W04](evidence/U03-A-SOURCES.md), [E02](evidence/u03-a-work-item-probe/README.md).

**MR03 effect check — observed:** The investigation left installation without erasing Q03b/c or P1. Actual card writes, optional session foreign keys, snapshot writer candidates, factory exports, SQLite reader shape and status exit signalling were recovered. The JSON-authority pattern from installation was not presumed to govern every session record. The default adapter recording path and reader contract were compared explicitly; other ingestion/runtime controls were not declared globally absent.

**Alternatives and decision:** Merely summarizing the CLIs would conflate running labels with running workers. Expanding immediately into every controller/provider would leave the first record contract unresolved. An all-environment installation campaign would exceed the current need. The selected slice followed producer→schema/query→consumer, then used one unchanged dependency-free helper with a store double to distinguish consequential claim/move hypotheses. Source-only findings about sync and persistence were kept separate from that execution.

**Observed probe and limits:** Six source-informed criteria written before execution matched in E02, including blocked pickup/reassignment/reopen and a done-card refusal with zero writes. These results do not establish exclusive claims, authentication, SQL/FK behavior, concurrency or usefulness. The same assistant designed the fixture after source reading; it is exploratory, not blind independent verification. Synthetic prerequisite metadata is not ECC schema evidence. Session test assertions were read but not counted as passes.

**Model correction and rival:** Claim/move flexibility may be intentional for an operator board. Different default stores may be explicitly bridgeable. Neither observation justifies the broader negative claim that ECC has no useful control. Conversely, schema validity, a row update or snapshot file is insufficient to claim runtime execution. Next U03-B must inspect the actual launcher/collector/acceptance path before a stronger system-level judgment.

**Continuity and cost:** Source search exposed another default-branch ref, so discovered bodies were retrieved at the pin rather than silently mixing versions. Bounded tests listing worked; state-store's five bodies are now read, not the whole repository. Whole-file log replacement and shared-row maintenance still impose repeated work. Two bounded publication stages and a non-force branch/PR fallback protect durable results under concurrency; their existence is not evidence of optimal efficiency or improved future-session understanding. No record restructuring or method version was manufactured.

**Next effect check — U03-B:** Does reading actual process/worker control change or refine the record-level picture? Can task/status/handoff artifacts be traced to real effects and acceptance without importing local-card pickup semantics? Do we advance system breadth rather than only collecting more false-green/record defects, while preserving unresolved sync/ingestion and installation limits? Record inconclusive and contrary outcomes. Independent cold-start, method comparison and general efficacy remain untested.

## MR05 — 2026-09-17 — U03-B

**Versions/questions:** METHOD 0.1 retained; PLAN 0.5 → 0.6. Q04d/e, Q08/Q10, next Q05. Evidence [Note 05](notes/05-EXECUTION-HANDOFF-AND-RECOVERY.md), [S70–S76/W05–W07](evidence/U03-B-SOURCES.md), [E03](evidence/u03-b-worker-probe/README.md).

**MR04 effect check — observed:** Opening the real execution path refined the picture materially: ECC does provision Git worktrees/tmux panes and invoke created-resource rollback, rather than only mutate cards. Following the worker wrapper into the actual parser separated process completion, raw handoff and extracted evidence. Worktree input also includes mutable overlays rather than only a base ref. This advances one runtime family; it does not close every controller or the whole source inventory.

**Alternatives and decision:** Trusting the started/completed labels would overstate their contracts; assuming record-level limits imply no runtime control would understate them. An unbounded real-provider swarm test would add effects/cost beyond the source question. The chosen experiment kept two original source files byte-identical and replaced only the provider, allowing controlled exit/output variations and a missing-task negative case. Setup/rollback/locator conclusions remain source-derived, not promoted by that separate experiment.

**Observed result and oracle boundary:** Five pre-execution criteria matched. The failed-verification text still had completed process status; unrecognized formatting retained raw content but erased extracted fields; nonzero exit and missing task produced actual failed results. This excludes a narrow mistaken interpretation of these exact components. It does not measure live model behavior, test quality, format frequency, sandbox compliance or end-to-end orchestration efficacy. The same assistant chose the source-informed cases; no blind independent replication or method comparison occurred.

**Scope/revision:** Q04d is bounded for the documented helper composition. Q04e carries acceptance/supervision/resume, locator consistency and output retention instead of hiding those gaps. PLAN advances to U04-A memory for breadth while preserving Q03b/c, Q04b/c/e and P1. Existing METHOD already supports this producer/consumer and proportional-test discipline, so no method version is manufactured. No closure condition was relaxed.

**Continuity and cost:** Exact local plan/runner/results hashes were checked against the prepared GitHub blobs. The first non-force main write was rejected after concurrent Superpowers work; expected-head PR #5 preserved that work and integrated six new ECC files. This is a real publication-control observation, not independent research review. Whole-file history replacement continues to impose overhead; no log restructuring was added as an unrequested side project. No quantitative efficiency or global continuity guarantee is claimed.

**Next effect check — U04-A:** Can memory be explained through its own save/review/retrieval/consumer contracts rather than importing installation JSON authority or assuming a stored handoff resumes an agent? Does the investigation extend breadth while retaining material runtime integration questions, and distinguish procedural guidance from implemented acceptance? Record absent, contradictory or inconclusive links without forcing an integrated-system narrative. The final method case remains unvalidated beyond these same-assistant observations.
