# gstack — System, self-development and cross-ground mechanism terms

2026-09-20, **B6-T14**. TERMS.md'nin bağlı parçasıdır. Bu dosya gstack research package'in repository self-development, generated/install/runtime/release standings, cross-system composition, four-ground projection ve Qualified Transition Loop dilini taşır.

## 1. Repository self-development and materialization

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-S01 — canonical authored state | Templates, resolvers, HostConfigs ve runtime code'un source-of-authoring rolü. | repository-self synthesis. |
| GST-S02 — generated SKILL.md / compiled view | Canonical authoring sources'tan produced inspectable/runtime representation. | repository-self. Conflict-resolution authority değil. |
| GST-S03 — generation / compilation | Templates + resolvers + host/model config + sections/suppression gibi inputs'tan target behavior artifact üretme. | repository-self/host. |
| GST-S04 — canonical committed render | Reproducible shared repository generated output; local machine detection'e bağlı olmaması amaçlanır. | repository-self. |
| GST-S05 — user-local render | Local capabilities/config'e göre out-of-tree generated behavior view. | repository-self. Canonical source değil. |
| GST-S06 — generated freshness | Tracked output'un current generator inputs ile byte/semantic generation parity standing'i. | repository-self. |
| GST-S07 — setup / materialization | Repository source/generated artifacts'i host-visible installed skills/runtime assets/hooks/settings state'ine dönüştürme. | repository-self. Installer copy değil. |
| GST-S08 — runtime asset | Skill behavior'ın çalışması için sibling binaries/libs/templates/checklists/support files. | repository-self/host. |
| GST-S09 — skill document present ≠ installation complete | SKILL.md varlığının referenced runtime assets'in materialized olduğunu kanıtlamaması. | repository-self. |
| GST-S10 — provenance/ownership before replacement | Same path/name var diye installed artifact'in gstack-owned kabul edilmemesi; mutation authority için ownership evidence aranması. | v1.80 revalidation/repository-self. |
| GST-S11 — atomic user-local render swap | Candidate render successful olursa live path replacement; failure'da last-working render'i koruma. | repository-self. |
| GST-S12 — known-working materialization | Failed regeneration/update sırasında previous usable installed/render state'i korunan state. | repository-self. |
| GST-S13 — manual upgrade | Git/vendored install type'e göre pull/setup/replacement/backup/authority flow'u. | repository-self. |
| GST-S14 — session-start auto update | Throttled/background lock+heartbeat ile source checkout update denemesi. | repository-self. Interactive session availability önceliği farklı. |
| GST-S15 — update-check | Local VERSION ile remote observed version/SHA üzerinden freshness/update standing üretme. | repository-self. |
| GST-S16 — CHECK_FAILED / UNKNOWN | Script crash olduğunda freshness'in bilinmediğini explicit gösteren standing. | repository-self. |
| GST-S17 — remote unavailable → UP_TO_DATE | Invalid/unreachable remote'un cached positive current standing'e collapse edildiği negative behavior. | repository-self. Freshness verified değil. |
| GST-S18 — checkout advancement | Git HEAD/source tree'nin newer revision'a geçmesi. | repository-self. Setup/materialization success ile ayrı. |
| GST-S19 — materialization success | Updated source'un installed/runtime surfaces'a başarılı yansıtılması. | repository-self. |
| GST-S20 — UPDATED marker gap | Session updater setup failure kaydetse de checkout VERSION'a göre update completion markers'ın ilerleyebilmesi. | repository-self negative. |
| GST-S21 — migration | Regeneration/setup ile ifade edilemeyen versioned state transform script'i. | repository-self. |
| GST-S22 — migration journal / done marker | Migration içi idempotent/re-entry progress evidence. | repository-self. |
| GST-S23 — version-window migration selection | Old→new version range'e göre migration eligibility. | repository-self. Outer state can skip unperformed migration. |
| GST-S24 — migration selected ≠ completed | Version window'da görünmek veya outer version ilerlemek migration effect'in gerçekleştiğini kanıtlamaz. | repository-self. |
| GST-S25 — daemon/runtime freshness | On-disk binary current olsa bile long-lived process'in old code çalıştırabilmesi. | repository-self/browser. |
| GST-S26 — FRESH / ALREADY_BUMPED / DRIFT_STALE_PKG / DRIFT_UNEXPECTED | Deterministic version-state classifications. | repository-self. |
| GST-S27 — semantic bump level | micro/patch/minor/major seçiminin release meaning judgment'ı. | repository-self. Deterministic writer'dan ayrı. |
| GST-S28 — version slot | Concurrent PR/worktree branches'ın shared release-number resource claim'i. | repository-self. |
| GST-S29 — queue-aware allocation | Other open claims'i görüp next free version önerme. | repository-self. Reader/reporter. |
| GST-S30 — Version Gate | Base/PR numeric standing + collision view üzerinden CI admission check. | repository-self. Allocator unavailable ise fail-open. |
| GST-S31 — VERSION identity | Product/release version representation. | repository-self. Immutable tag-pinned installed bytes garantisi değil. |
| GST-S32 — branch release identity | Branch'in own shipped change için version/CHANGELOG identity taşıması. | repository-self. |
| GST-S33 — CHANGELOG released view | Final user-visible main-vs-branch capabilities'i temsil eden release artifact. | repository-self. Full development history ledger değil. |
| GST-S34 — document-release | Actual diff'e göre docs/reference/how-to/architecture/version consistency'yi requalify eden post-implementation workflow. | repository-self. Runtime truth değil. |
| GST-S35 — self-development loop | Failure/request → source change → regenerate/install/test/version/release → real use → new failure evidence. | repository-self/cross-system. |

## 2. Cross-system composition language

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-S36 — artifact-mediated system | Subsystems arasındaki current decisions/evidence/standing'in durable artifacts üzerinden taşınması. | cross-system. |
| GST-S37 — qualification-driven work system | Important progression'ın current evidence/standing + authority üzerinden controlled transition olarak kurulması. | cross-system/CORE. Formal kernel değil. |
| GST-S38 — federation of partial state machines | Design/review/test/cache/version/deploy/host vb. local state machines'in tek global enum olmadan artifacts/consumers ile compose olması. | cross-system. |
| GST-S39 — downstream consumer semantics | Persisted artifact'in later workflow tarafından discover/requalify edilip context/gate/control input'a dönüştürülmesi. | cross-system. Artifact existence alone active control değil. |
| GST-S40 — descriptive state | World/work hakkında believed/observed information representation. | cross-system. |
| GST-S41 — normative/control state | Later work'ü constrain etmesi beklenen approved plan/policy/authority/config representation. | cross-system. |
| GST-S42 — qualification state | Başka information/action'ın currentness, readiness, completeness, trust, verification gibi standing'i. | cross-system. |
| GST-S43 — qualification metadata | Payload'ın how-to-use standing'ini taşıyan state. | cross-system. |
| GST-S44 — representation seam | Bir subsystem'in qualified output'unun başka subsystem'e derived view/handoff olarak geçtiği boundary. | cross-system. |
| GST-S45 — qualification-loss seam | Payload survive ederken stale/partial/degraded/control-strength qualifier'ın kaybolduğu boundary. | cross-system. |
| GST-S46 — ceremony provenance | Earlier workflow'un yapılmış olması/historical process path. | cross-system. Current standing ile aynı değil. |
| GST-S47 — current standing outranks ceremony | Control kararının mümkün olduğunda object'in current qualification'ına dayanması, historical ritual attendance'a değil. | cross-system. |
| GST-S48 — authority plane | User/delegated decisions, effect authorization, one-way doors, release authority gibi decision-right structures. | cross-system. |
| GST-S49 — evidence plane | Source/tests/runtime observations/reports/aggregates/current-stale standings. | cross-system. |
| GST-S50 — environment/runtime plane | Repo/worktree/host/process/browser/network/external/production actual conditions. | cross-system. |
| GST-S51 — self-development plane | System'in kendi templates/runtime/generation/install/update/eval/release state'i. | cross-system. |
| GST-S52 — control plane | Routing, standing, policy, authority, aggregation, host negotiation ve release rules. | cross-system. |
| GST-S53 — effect plane | File/git/browser/network/issue/merge/deploy/memory/install/migration actual mutations. | cross-system. |
| GST-S54 — evidence/representation plane | Effects/sources hakkında observable records, statuses, provenance ve derived views. | cross-system. |
| GST-S55 — control–effect–evidence triangle | Authorized action, realized effect ve represented evidence'in birbirini kapatan ama ayrı planes olması. | cross-system. |
| GST-S56 — aggregation as control | Child/evidence inputs'i parse/filter/dedupe/qualify edip progression-facing standing üretme. | cross-system. Formatting değil. |
| GST-S57 — failure polarity | Missing/invalid/degraded state'e block/ask/run-more/degrade/continue gibi context-specific response. | cross-system. |
| GST-S58 — availability-over-freshness trade | Session/update/memory continuity için some failures'ın fail-open/degrade edilmesi. | cross-system. Qualifier korunmalı. |
| GST-S59 — feedback ≠ work | New observation/retro/learning/recommendation'ın admitted pursuit veya obligation olmaması. | cross-system. |
| GST-S60 — recursive application | System'in user work için kullandığı qualification/control principles'i kendi generator/install/eval/release machinery'sine uygulaması. | cross-system/self-development. |

## 3. Native mechanism set

Cross-system synthesis gstack'i şu native mechanism abstractions ile açıklar; bunlar Foundation taxonomy değildir:

| ID / ifade | Yerel anlam |
|---|---|
| GST-S61 — Admission | Ambiguous/candidate activity'yi authorized, bounded Work'e dönüştürme. |
| GST-S62 — Representation / Handoff | Transient reasoning/results'i downstream-consumable durable artifact'e dönüştürme. |
| GST-S63 — Qualification | Currentness/completeness/readiness/validity/confidence gibi standing compute/recompute etme. |
| GST-S64 — Authority | Kimin hangi transition/effect'i decide/authorize edebileceğini belirleme. |
| GST-S65 — Capability / Effect Boundary | Tool/runtime/agent'in neyi fiilen yapabildiği ve bounded effect surface'i. |
| GST-S66 — Verification / Observation | Source/test/browser/judge/external readback ile evidence oluşturma. |
| GST-S67 — Aggregation | Heterogeneous evidence/results'i decision-ready standing'e dönüştürme. |
| GST-S68 — Transition | Edit/commit/issue/spawn/merge/deploy/revert/install/migrate gibi state change effect'i. |
| GST-S69 — Freshness / Invalidation | Prior artifact/evidence/relation/standing'in current object değişince applicability kaybetmesi. |
| GST-S70 — Continuity | Sessions/branches/processes/upgrades/failures boyunca recoverable state/work preservation. |
| GST-S71 — Feedback | Outcome/failure/observation'ın later reasoning/work selection'a dönmesi. |
| GST-S72 — Adaptation / Self-development | Recurrent failure'dan system contracts/runtime/tests'in değiştirilmesi. |

## 4. Qualified Transition Loop

Cross-ground mechanism reduction'in compact source language'i:

| ID / ifade | Bu araştırmadaki karşılık |
|---|---|
| GST-S73 — Qualified Transition Loop | Exact situation binding'den realized-state readback/recovery'ye tekrarlanan distributed semantic loop. |
| GST-S74 — SITUATE / Bind Situation | Exact work/actor/information/environment anchors + role/scope/time/version/operation'ı belirleme. |
| GST-S75 — KNOW / Form & Select Evidence | Source/runtime/user/external state'ten relevant evidence oluşturma ve working set'e seçme. |
| GST-S76 — QUALIFY / Standing Computation | current/complete/ready/verified/applicable/supported gibi current standing'i compute/recompute etme. |
| GST-S77 — GOVERN / Authority Resolution | Kimin decide/authorize edebileceğini belirleme. |
| GST-S78 — GOVERN / Control Resolution | Hangi effect'in hangi basis/objective/enforcement/override semantics ile governed olduğunu belirleme. |
| GST-S79 — ACT / Bounded Effect Execution | Exact scoped mutation/effect attempt'i gerçekleştirme. |
| GST-S80 — VERIFY REALITY / Authoritative Readback | Command/transition attempt sonrası actual target state'i external/runtime evidence ile yeniden okuma. |
| GST-S81 — INVALIDATE / Transform Representations | Prior refs/reviews/cache/generated/deploy/etc. standings'i source/state change sonrası update/invalidate etme. |
| GST-S82 — CONTINUE / RECOVER / ADAPT | New current state'ten next work, repair, fallback, rollback, learning veya stronger system control'a geçme. |
| GST-S83 — qualified, authorized, evidence-grounded transition with realized-state readback | Qualification tek başına yetersiz olduğu için loop'un en compact strengthened formulation'ı. | cross-ground synthesis. |

## 5. Foundation-projection terms used by this study

Bunlar gstack product terimleri değildir; study'nin existing Foundation research ile comparison dili olarak kullandığı kavramlardır.

| ID / ifade | Bu araştırmadaki kullanım | Sınır |
|---|---|---|
| GST-S84 — Information / Representation | gstack artifacts/evidence/context/status views'in Foundation comparison axis'i. | Foundation adoption üretmez. |
| GST-S85 — Informational State / Representational Constitution | Durable/transient representations'ın referent/scope/version/provenance/consumer/standing özellikleri. | four-ground. |
| GST-S86 — Formation / Acquisition | Source/runtime/user/effect'ten usable observation/evidence formation. | four-ground. |
| GST-S87 — Derivation / Transformation | Generated skills, classifications, aggregates, scores, checkpoints gibi representation transforms. | four-ground. |
| GST-S88 — Selection / Exposure | Routing, test selection, memory retrieval, host suppression, filtering ile consumer working set'ini belirleme. | four-ground. |
| GST-S89 — Work | Candidate/admitted/enacted/coordinated/evaluated/recovered pursuits comparison axis'i. | four-ground. |
| GST-S90 — Actors / Agency–Participation–Authority | User, agent instances, temporary roles, delegated participation, capability/authority distinctions comparison axis'i. | four-ground. |
| GST-S91 — Environment / Operating Reality | Repo/process/browser/network/CI/external/production actual state and Work Conditions comparison axis'i. | four-ground. |
| GST-S92 — Relational Binding | Which exact anchors are linked in which semantic positions/scope/time/version relation. | cross-ground comparison. |
| GST-S93 — Composite Standing / Qualification | Meaning'i irreducibly multiple grounds'a dayanan ship readiness/actionability vb. standings. | four-ground. Not every local status composite. |
| GST-S94 — Control / Constraint | Exact effect/behavior'ın basis/authority/decision/enforcement/coverage/monitoring ile governed olması. | four-ground. |
| GST-S95 — Transition / Effect / Feedback parent | Requested/approved/recorded change ile realized/observed effect'i ayıran comparison region. | four-ground. |
| GST-S96 — Transition / Propagation | Change'in multiple exact target transitions üzerinden wider effect'e yayılması pressure case'i. | Study bunu accepted Foundation result yapmaz. |
| GST-S97 — Causal Effect / Contribution | Why an outcome/failure occurred sorusu için future Foundation pressure language. | Inactive research region; no adoption. |
| GST-S98 — Feedback / Adaptation | Outcome'un later system/work'e returned influence yaratması için future pressure language. | Inactive region; gstack example ≠ Foundation conclusion. |
| GST-S99 — criterion-relative standing | Environment bearer'ın health/compatibility/availability gibi exact criterion'a göre local standing'i. | four-ground. Ship readiness ile aynı değil. |
| GST-S100 — assessment ≠ standing ≠ recognition | Object-level reality, evidence-based assessment ve authorized acceptance'in ayrı olması. | four-ground. |

## 6. Transition/realization non-collapse

gstack study'nin en tekrar eden relation'larından biri:

- merge command issued ≠ GitHub merged state;
- deploy triggered ≠ deploy completed;
- deploy completed ≠ service healthy;
- rollback approved ≠ revert pushed ≠ rollback deployed ≠ production restored;
- source HEAD advanced ≠ setup/materialization succeeded ≠ live process current;
- migration eligible ≠ migration executed;
- template changed ≠ all generated hosts/installations/sessions changed;
- VERSION label ≠ immutable tag-pinned installed bytes.

Bunlar aynı term değildir; GST-S68 Transition, GST-S80 Readback ve GST-S96 Propagation farklı kullanımlardır.

## 7. Recursive self-qualification

gstack'in own evolution pattern'i source package'ta şu progression ile açıklanır:

**prose/local convention → concrete failure → named distinction → reusable helper/control → structural scanner/invariant → behavioral test → CI/release consequence.**

Bu history:
- implementation frequency'den Foundation priority çıkarmaz;
- every recurrence class'ın permanently fixed olduğunu kanıtlamaz;
- fakat operating system'in kendi control/evidence machinery'sini de Work gibi qualify etmesi gerektiği fikrini destekleyen source-native pattern'dir.

## 8. System relation view

gstack'in en compact source-recoverable model'i:

**SITUATE exact anchors → FORM/SELECT evidence → QUALIFY current standing → RESOLVE authority/control → EXECUTE bounded effect → READ BACK realized state → INVALIDATE stale representations → CONTINUE/RECOVER/LEARN**, aynı principles'i kendi generation/install/test/release machinery'sine recursive uygulayarak.

Bu, SOUL mimarisi veya evrensel agentic OS definition'ı değildir. gstack araştırmasının source-bounded synthesis dilidir.
