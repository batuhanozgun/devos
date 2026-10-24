# Multi-Agent Patterns — Bağlamlı kullanım kayıtları

2026-09-20, **B6-T12 / KALICI-AKTARIM-TAMAM / PACKAGE-COMPLETE**. Gerçek kaynak/okuma hesabı [READING.md](READING.md)'dedir.

Bu dosya `research/studies/multi-agent-patterns/` araştırmasındaki terim ve ilişki kullanımlarını **o araştırmanın kendi bağlamında** kaydeder. Image taxonomy'sinin doğrulanmış endüstri standardı olduğu, SOUL/Development OS mimarisine kabul edildiği veya aşağıdaki adların evrensel kavram sınırları olduğu iddia edilmez.

İki concepts riski burada da geçerli: okuma sırasındaki anlam seçimleri kullanıcı tarafından anlık denetlenemediği için maddi yorum/dayanak görünür tutulur; aynı kelimeyi kullanmak aynı anlamı garanti etmediğinden kullanıcı onayı, kaynak kullanımı ve extractor yorumu teknik doğruluğun yerine konmaz.

## 1. Paket-geneli temel düzeltme

Kaynak konuşmanın ana düzeltmesi şudur:

> **Sequential, Parallel, Hierarchical, Generator–Critic, Human-in-the-Loop ve Composite altı peer architecture değildir.**

Araştırma bunları farklı abstraction levels / relation dimensions olarak yeniden okur:

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| MAP01 — Sequential | Later work'ün earlier work sonucuna bağlı olduğu execution/dependency ordering. | Conversation §1. Multi-agent olmak zorunda değil. |
| MAP02 — Parallel | Birden fazla work execution'ın birbirini beklemeden ilerleyebildiği concurrency structure. | Conversation §2. Parallel decomposition ve redundancy ayrı. |
| MAP03 — Hierarchical | Who delegates/co-ordinates/assigns/owns responsibility sorusunu taşıyan authority/delegation/coordination topology. | Conversation §3. Sequential/Parallel'ın karşıtı değil. |
| MAP04 — Generator–Critic | Bir role artefact üretir, diğer role challenge/review eder; repair loop oluşabilir. | Conversation §4. Critic otomatik verifier değil. |
| MAP05 — Human-in-the-Loop | Defined point'te human judgement/authority/approval'ın sisteme girmesi. | Conversation §5. Human technical verifier olmak zorunda değil. |
| MAP06 — Composite | Yukarıdaki coordination/control structures'ın task'a göre birlikte kullanılması. | Conversation §6. Sixth peer pattern değil; composition. |
| MAP07 — mixed abstraction levels | Image etiketlerinin execution order, concurrency, authority, review, governance ve composition gibi farklı türleri aynı düzlemde göstermesi. | Conversation intro/§8/§10. |
| MAP08 — minimum sufficient complexity | Work'ün gerçekten koruması gereken dependency/uncertainty/authority/verification/risk kadar topology kullanma ilkesi. | Conversation §6/§8; Assessment §10/C1. Project synthesis, architecture rule değil. |

## 2. Sequential ve Parallel kullanımları

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP09 — dependency ordering | Aşağıdaki step/work'ün yukarıdaki exact output/state'e gerçekten ihtiyaç duyması nedeniyle oluşan sıra. | Conversation §1; Assessment §4–5. |
| MAP10 — deterministic ordering | Step sırasının fixed/known olması. | Conversation §1. LLM output'unun deterministic olduğu anlamına gelmez. |
| MAP11 — error propagation | Erken step'teki yanlış frame/premise'in downstream work'e inherited state olarak taşınması. | Conversation §1. |
| MAP12 — transition quality | Upstream output'un provenance/confidence/validity'sinin downstream geçişte korunması. | Conversation §1; Assessment §5. |
| MAP13 — parallel decomposition | Different agents farklı subproblems üzerinde eşzamanlı çalışır. | Conversation §2.A. Coverage/speed amacı. |
| MAP14 — parallel redundancy / ensemble | Multiple agents aynı question'a bağımsız yollarla saldırır; outputs karşılaştırılır. | Conversation §2.B. Speed zorunlu amaç değil. |
| MAP15 — concurrency / parallelism | Multiple executions'ın zaman bakımından overlap etmesi. | Conversation §7. Gerçek parallel vs concurrent implementation source'a göre değişebilir. |
| MAP16 — merge | Parallel outputs'u usable next state'e reconcile etme. | Conversation §2/§7; Assessment §6. First-class reasoning/control problem. |
| MAP17 — merge contract | Parallel başlamadan shared base, allowed mutations, output contract, conflict semantics, merge authority, provenance ve verification ihtiyacının belirlenmesi. | Assessment C3. Candidate requirement. |
| MAP18 — majority vote | Multiple agent output'larında sayısal çoğunlukla sonucu seçme. | Conversation §2. Epistemik doğruluk guarantee değil. |
| MAP19 — epistemic independence | Error pathways/sources/assumptions/methods/models/tools/oracles'ın gerçekten ne kadar bağımsız olduğu. | Conversation §2/§7/§8; Assessment §6/C8. Agent count ile aynı değil. |
| MAP20 — disagreement detection | Parallel redundancy'nin value'sunun bir parçası; differing conclusions'ı görünür kılmak. | Conversation §2.B. Disagreement çözümü ayrıca gerekir. |

## 3. Thread, agent, subagent ve execution boundary

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP21 — Agent | Executing reasoning/working role. | Conversation §7. Model identity ile birebir aynı değil. |
| MAP22 — Subagent | Başka agent/orchestration layer tarafından spawned/delegated agent execution. | Conversation §7. “Sub” daha zayıf model demek değil. |
| MAP23 — Thread | Kendi context'i olan distinct work/conversation line. | Conversation §2/§7. Product terminology değişebilir. |
| MAP24 — Session | Thread'den daha broader/product-dependent runtime/work surface terimi. | Conversation §2. Exact product contract olarak sabitlenmiyor. |
| MAP25 — parent agent / subagent topology | User çoğunlukla parent work surface ile konuşurken parent'ın internal delegation yapması. | Conversation §2. |
| MAP26 — multiple independent threads | User/higher orchestrator'ın ayrı work lines'ı ayrı agent executions ile yönetmesi. | Conversation §2. |
| MAP27 — user-visible conversation boundary vs agent-execution boundary | UI'daki tek conversation ile runtime'daki agent execution sayısının aynı olmak zorunda olmaması. | Conversation §2. |

## 4. Hierarchy, Manager ve delegation

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP28 — Manager | Objective'i decompose eden, role/task atayan, dependencies izleyen, outputs alan ve integration/routing yapan coordination role. | Conversation §3/§7. |
| MAP29 — delegation | Bir role/work unit'in başka agent/role'a bounded work vermesi. | Conversation §3; Assessment §7. |
| MAP30 — hierarchy depth | Delegation tree'deki nested coordination levels. | Conversation §3. Universal ideal depth yok. |
| MAP31 — recursion | Subagent/submanager'ın yeniden subwork/agent oluşturabilmesi. | Conversation §3; Assessment C4/R5. |
| MAP32 — bounded recursion | Spawn depth/breadth/budget/authority'nin explicit sınırlarla kontrol edilmesi. | Assessment C4/R5. Candidate requirement. |
| MAP33 — authority propagation | Üst role verilen yetkinin alt role hangi kapsamda devredildiği. | Assessment §7/C4. Hierarchy position bunu otomatik belirlemez. |
| MAP34 — manager decomposition error | Worker'lar iyi olsa da manager'ın yanlış work decomposition yapması. | Conversation §3; Assessment §7/R2. |
| MAP35 — manager integration error | Valid local outputs'ın yanlış global conclusion/state'e birleştirilmesi. | Conversation §3; Assessment §7. |
| MAP36 — manager as systemic failure point | Coordination layer'ın local success'leri global failure'a dönüştürebilmesi. | Assessment §7. Root-cause frequency claim değil. |

## 5. Generator–Critic, review ve verification

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP37 — Generator | Artefact/solution üreten role. | Conversation §4. |
| MAP38 — Critic | Produced work'ü challenge/review eden role. | Conversation §4. Independent verifier demek değil. |
| MAP39 — self-critique | Aynı agent'ın generate edip sonra kendi output'unu critique etmesi. | Conversation §4. En düşük separation biçimi. |
| MAP40 — separate-agent review | Distinct context/execution'ın aynı veya farklı model family ile review yapması. | Conversation §4. Separation independence guarantee değil. |
| MAP41 — cross-model / cross-system review | Bir system/model produced artefact'ı başka system/model'in review etmesi. | Conversation §4; Assessment §8/C8. Diversity tool, proof property değil. |
| MAP42 — deterministic verifier | Test/schema/calculation/execution/source check gibi mechanically falsifiable verifier path. | Conversation §4; Assessment §8. Applicable olduğunda stronger oracle olabilir. |
| MAP43 — review / critique | Plausible issues, assumptions ve quality problems arayan challenge function. | Assessment §8. |
| MAP44 — verification | Explicit claim/criterion'in appropriate evidence ile supported olup olmadığını belirlemeye çalışma. | Conversation §7; Assessment §8. |
| MAP45 — adversarial challenge | Normal criterion-conformance'ın kaçırabileceği failure modes'u intentionally arama. | Assessment §8. Verification ile aynı değil. |
| MAP46 — detectable failure class | Critic/verifier'ın hangi error class'ı gerçekten red'e çevirebildiği. | Conversation §4; Assessment C5. “Critic var”dan daha load-bearing. |
| MAP47 — exact-target binding | Review/verification'ın exact artefact/version/commit üzerinde yapılması. | Assessment §8/§11/R4. Development OS comparison language. |
| MAP48 — stale verdict | Review/verification target değiştikten sonra eski green result'ın current sayılması problemi. | Assessment R4. |
| MAP49 — repair creates new target | Critic/verifier sonrası material repair'in yeni artefact version'ı yaratması ve fresh verification gerektirebilmesi. | Assessment §8/§11. |

## 6. Cross-system orchestration

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP50 — orchestration bridge | Claude/Codex gibi ayrı systems'in birbirini native subagent sanmadan external control ile sequence edilmesi. | Conversation §4. |
| MAP51 — external orchestrator | Shell/Python/CI/service vb. ile processes başlatan, bekleyen, outputs toplayan ve next execution'ı tetikleyen control layer. | Conversation §4; Assessment value matrix. |
| MAP52 — completion signal | Bir execution'ın review/next stage için hazır olduğunu orchestration layer'a bildiren observable condition. | Conversation §4. |
| MAP53 — process sequencing | Bir process finish → başka process start biçiminde external execution ordering. | Conversation §4. |
| MAP54 — orchestration state | Hangi process/branch/review/gate'in current olduğu bilgisi. | Assessment R9/C7. Tek product context'ine gömülmemeli. |

## 7. Human-in-the-Loop ve authority

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP55 — Human-in-the-Loop | Defined point'te human judgement/authority/approval insertion. | Conversation §5. |
| MAP56 — human authority / governance | Değer, sorumluluk, legal/organizational authority, irreversible/high-impact choice nedeniyle human kararının gerekli olması. | Conversation §5.A; Assessment §9. |
| MAP57 — human verification / error detection | Human'ın technical evidence'i inspect edip ek error-detection sağlaması. | Conversation §5.B. Authority gate ile aynı değil. |
| MAP58 — approval | Human'ın belirli action/decision'a izin vermesi. | Conversation §5; Assessment §9. Technical claim verified demek değil. |
| MAP59 — hidden human orchestration | Agentic system görünürken human'ın outputs taşıması, conflict çözmesi, state hatırlaması, next work seçmesi. | Assessment §9/R6. Anti-goal. |
| MAP60 — rubber-stamp approval | Human'ın technical evidence inspect etmeden sadece approve etmesi. | Conversation §5. Governance olabilir ama verification değeri düşük olabilir. |
| MAP61 — human gate | Genuine value/authority/risk boundary'de system progression'ı insan kararına bağlayan gate. | Assessment C6. Generic uncertainty fallback değil. |

## 8. Composite, Router ve Orchestration

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| MAP62 — Input | Sisteme work olarak giren user request, issue, API event, document, incident, schedule vb. | Conversation §6. |
| MAP63 — Router | Input'un hangi path/handling/topology'ye girmesi gerektiğini seçen role/mechanism. | Conversation §6. |
| MAP64 — Manager vs Router | Router “hangi path?”, Manager “path içinde nasıl decompose/coordinate?” sorusunu taşır. | Conversation §6. Tek component ikisini oynayabilir. |
| MAP65 — Orchestrator | Sequencing, concurrency, dependency, retry, timeout, state transfer, task assignment, cancellation, merge, error routing ve gates'i işleten control machinery. | Conversation §6/§7. |
| MAP66 — Composite topology | Several relation/control structures'ın conditional composition'ı. | Conversation §6; Assessment §10. Fixed ordered mega-pipeline değil. |
| MAP67 — task-specific topology | Work properties'e göre oluşan concrete coordination/delegation/verification/human-control düzeni. | Assessment §4/§10/§15. |
| MAP68 — topology derivation | Dependency, uncertainty, capability, risk, authority, verification need, environment capacity ve coordination cost'tan topology çıkarma problemi. | Assessment §10/§18. |
| MAP69 — topology transition | Work ilerlerken single-agent→parallel→repair→human gate gibi structure change. | Assessment C7/open Q10. |
| MAP70 — topology as persistent state | Material current topology/branches/acceptance/next responsibility'nin session loss sonrası recover edilebilir olması. | Assessment C7. |
| MAP71 — no multi-agent complexity needed | Bir task için tek bounded agent + tool + deterministic verification gibi simple topology'nin geçerli sonuç olması. | Assessment C10. |

## 9. Assessment'in kullandığı orthogonal relation dimensions

Assessment, image label'larını şu daha genel relation questions'a çevirir:

| ID | Dimension | Yerel anlam |
|---|---|---|
| MAP72 — dependency ordering | Ne, neden önce/sonra gelmeli? |
| MAP73 — concurrency structure | Neler birbirini beklemeden yürüyebilir? |
| MAP74 — delegation/authority topology | Kim kime work verir; kim neye karar verebilir? |
| MAP75 — challenge/verification topology | Produced work hangi bağımsız/challenging path'lerden geçer? |
| MAP76 — human governance topology | Hangi action/decision'da human authority zorunlu? |
| MAP77 — routing/composition policy | Bu work için hangi relation structures birlikte gerekli? |

Bu altılı yeni accepted SOUL ontology'si değildir; assessment'in design-pressure language'ıdır.

## 10. Work topology, Actor topology ve Environment

| ID / ifade | Bu araştırmadaki karşılık |
|---|---|
| MAP78 — Work topology | Sequential/parallel/dependency/wait/retry gibi work/control relations. |
| MAP79 — Actor topology | Manager/builder/verifier/owner gibi role/participation relations. |
| MAP80 — role ≠ authority ≠ capability ≠ accountability | Position label'ın permission, competence, responsibility veya accountable owner'ı tek başına belirlememesi. |
| MAP81 — environment feasibility | Parallel/hierarchical topology'nin gerçek concurrency, isolation, permissions, resources, credentials ve recovery imkanlarına bağlı olması. |
| MAP82 — shared-state race | Parallel executions'ın aynı mutable state üzerinde uncontrolled interaction riski. |
| MAP83 — isolation | Branch/worktree/workspace gibi mutation boundaries'in parallel work için ayrılması. |
| MAP84 — coordination cost | Agent count, handoff, context, merge, observability ve recovery'nin ek sistem yükü. |
| MAP85 — complexity budget | Ek agent/layer'in protected value'ya değip değmediğini sınırlayan candidate control. |

## 11. Candidate requirements ve risk-language statüsü

Assessment'in C1–C10 ve R1–R10 kayıtları terim kaynağıdır fakat **accepted requirements değildir**.

Öne çıkan kullanım adresleri:

- **MAP86 — protected value:** topology complexity'nin latency, coverage, independence, authority, safety, continuity veya recoverability gibi bir requirement'ı koruması.
- **MAP87 — spawn governance:** breadth/depth/cost/permission/capability creation sınırları.
- **MAP88 — correlated-agent false confidence:** agents aynı framing/source/model defect'i paylaşırken agreement'ın yanlış güven üretmesi.
- **MAP89 — merge contamination:** doğru local outputs'ın yanlış integration ile global state'i bozması.
- **MAP90 — reviewer ritualization:** Falsifying method'i olmayan critic'in pahalı approval ritual'a dönüşmesi.
- **MAP91 — context/provenance degradation through hierarchy:** manager summaries ilerledikçe load-bearing nuance/source binding'in kaybolması.
- **MAP92 — fixed-pattern overfitting:** “research=parallel, coding=hierarchical” gibi domain label→fixed topology eşlemesinin system formation'ı template catalogue'a çevirmesi.

## 12. System formation

| ID / ifade | Bu araştırmadaki kullanım | Sınır |
|---|---|---|
| MAP93 — system formation | Intended outcome için gereken minimum working coordination/delegation/verification/human-control structure'ını task'a göre türetme. | Assessment §4/§19. SOUL'un kabul edilmiş architecture implementation'ı değil; assessment'in güçlü relevance conclusion'ı. |
| MAP94 — derived topology | SOUL product identity'sini “hierarchical multi-agent” diye sabitlemek yerine task'a göre topology'nin oluşturulması. | Assessment §15.1. |
| MAP95 — production topology vs verification topology | Work'ü üreten organization ile exact-target verification/adversarial/human path'in farklı olabilmesi. | Assessment §15.3. |
| MAP96 — observability of coordination decisions | Material topology/authority/target/dependency/completion kararlarının yalnız model context'inde kalmaması. | Assessment §15.2. |
| MAP97 — manual precursor | Development OS'nin formal multi-agent runtime olmadan sequential roles, verifier separation, human gates ve repository state ile benzer relations'ı zaten elle taşıması. | Assessment §11.6/§16. Architecture equivalence değil. |

## 13. Product-specific ve açık bırakılan alanlar

Conversation, 2026-09-03 tarihli Codex/Claude Code depth/concurrency/CLI observations içerir. Kaynak bunları açıkça **time-sensitive implementation observations** olarak sınırlar. Concepts kaydı bunları stable definitions veya current facts olarak yükseltmez.

Image'in altındaki MCP/A2A “2026 Production Stack” bölümü konuşmada substantively değerlendirilmemiştir. Bu nedenle MCP/A2A hakkında bu package'dan concept definition çıkarılmadı.

## 14. Kaynak-içi ilişki görünümü

Araştırmanın en güçlü ilişki modeli:

**work properties / dependency / uncertainty / risk / authority / verification need / environment capacity → topology derivation → work execution/delegation → merge/integration → verification/challenge → human authority where required → persistent current state / next responsibility**

Her ok automatic component veya zorunlu SOUL architecture değildir.

Aynı real system içinde:
- Sequential ve Parallel farklı work branches'te coexist edebilir;
- Hierarchy bunların coordination/authority layer'ı olabilir;
- Generator–Critic ayrı review topology ekleyebilir;
- Human-in-the-Loop belirli authority gate'te girebilir;
- Composite bu relations'ın conditional composition'ıdır.

## 15. Kapanış

B6-T12'de üç package dosyası tam okundu ve source roles ayrıştırıldı. Somut kullanım eksiği bulunmadı. Paket-level core conclusion source'a sadık biçimde korunur:

> **Agent sayısını veya topology sophistication'ını optimize etme; actual work'ün gerektirdiği coordination, delegation, verification ve human-control structure'ını türet ve gerekçelendir.**

Bu conclusion assessment'in project-facing synthesis'idir; universal multi-agent law veya adopted SOUL/Development OS architecture değildir.
