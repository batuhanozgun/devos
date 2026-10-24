# gstack — Coordination, delegation and portability terms

2026-09-20, **B6-T14**. TERMS.md'nin bağlı parçasıdır. Bu dosya gstack araştırmasındaki multi-agent/cross-model coordination, child handoff/liveness, host/model adaptation ve portability fidelity kullanımlarını taşır.

## 1. Multi-agent modes and context separation

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-C01 — multi-agent | gstack'te tek bir team abstraction değil; fresh-context specialization, parallel fan-out, workflow delegation, cross-model challenge, remote pairing ve optional worktree execution gibi farklı forms. | multi-agent synthesis. |
| GST-C02 — fresh-context specialization | Child/reviewer'ın parent trajectory'nin bütün context'ini almadan bounded role ile yeniden okuması. | multi-agent. Independence garantisi değil. |
| GST-C03 — context separation | Agent executions arasında information/history exposure'ının intentionally farklı tutulması. | multi-agent. |
| GST-C04 — de-anchoring | Prior review/reasoning'i child'dan withheld ederek first-path anchoring'i azaltma amacı. | Autoplan/CSO. |
| GST-C05 — parallel specialist fan-out | Same diff/work object üzerinde farklı review lenses'i sibling agents'a concurrent dispatch etme. | Review Army. |
| GST-C06 — parallel generative fan-out | Same design problem için intentionally different candidate variants üretme. | design-shotgun. Verification fan-out ile aynı değil. |
| GST-C07 — sibling concurrency | Bir parent message içindeki multiple foreground Agent calls'ın sibling olarak concurrent yürüyebilmesi. | multi-agent. |
| GST-C08 — foreground relative to parent | Child completion parent continuation için blocking; sibling'lerle aynı anda çalışabilir. | multi-agent. |
| GST-C09 — Review Army | Diff signals/hit rates ile selected specialist agents'ın findings üretip aggregation'a girdiği review topology. | multi-agent/review. |
| GST-C10 — MULTI-SPECIALIST CONFIRMED | Duplicate finding'in multiple specialists tarafından independently-ish surfaced edilmesi sonrası heuristic confidence annotation. | multi-agent. Statistical independence guarantee değil. |
| GST-C11 — Red Team child | Initial merged findings sonrası missed failure classes arayan additional challenge role. | multi-agent/review. |
| GST-C12 — Design Shotgun | Multiple candidate directions üreten generative diversity workflow. | multi-agent. More agents ≠ stronger truth. |

## 2. Spawned workflow delegation and handoff contracts

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-C13 — spawned workflow delegation | Parent'ın named full subworkflow'u fresh child context'e verip machine-readable result consume etmesi. | ship→document-release. |
| GST-C14 — SESSION_KIND: spawned | Child'ın interactive human bulunmayan machine-consumed mode'da çalıştığını belirleyen session standing. | multi-agent. |
| GST-C15 — spawned decision adaptation | Spawned child'ın normal AskUserQuestion yerine recommended/conservative bounded choice yapıp decisions'i parent'a kaydetmesi. | multi-agent. |
| GST-C16 — direct session-kind trust trigger | Spawned mode'un arbitrary page/file text'inden değil child'ın own gstack-skill-start result'ından accepted edilmesi. | multi-agent. |
| GST-C17 — workflow delegation with authority subtraction | Child full workflow'u yürütürken VERSION/CHANGELOG/base merge/force-push gibi parent-owned effects'in açıkça çıkarılması. | multi-agent. |
| GST-C18 — child result contract | files_updated/commit_sha/pushed/documentation_section/decisions/error gibi typed final JSON handoff. | multi-agent. |
| GST-C19 — success / no-op / failure handoff | Child completion'ın prose yerine machine-consumable distinct states taşıması. | multi-agent. |
| GST-C20 — untrusted child payload | Child markdown/result content'in parent instruction authority'si kabul edilmemesi. | multi-agent. |
| GST-C21 — parent result validation | Field types/schema/standing doğrulanmadan child output'un parent control state'e alınmaması. | multi-agent. |
| GST-C22 — partial child effect | Child fail/timeout olsa bile commit/staged/uncommitted mutation bırakmış olabilmesi. | multi-agent. |
| GST-C23 — reconciliation | Parent'ın pre-dispatch HEAD/state ile post-child effects'i karşılaştırıp realized partial changes'i vet etmesi. | multi-agent. |
| GST-C24 — no duplicate child | Original child hâlâ mutating olabilirken retry child spawn etmeme rule'u. | multi-agent. Shared-state integrity. |
| GST-C25 — bounded wait | Expected foreground result gelmezse limited status-check interval/window ile child liveness'i izleme. | multi-agent. |
| GST-C26 — cancellation before continuation | Deadline sonrası child'ı durdurmadan shared-state parent work'e devam etmeme. | multi-agent. |
| GST-C27 — liveness | Parent/child work dependency'sinin operational olarak completion/wait/timeout/cancel/recover semantics ile kapanması. | multi-agent/cross-system. |

## 3. v1.79 coordination regression language

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-C28 — stranded-parent regression | Host Agent default'u background'a değişince synchronous-result bekleyen parent workflow'un liveness kaybetmesi. | multi-agent pinned v1.79 causal record. |
| GST-C29 — proximate cause | Agent dispatch'te run_in_background:false'ın explicit olmaması under changed host default. | multi-agent. |
| GST-C30 — recurrence class | Aynı foreground/synchronous assumption failure'ının third occurrence olarak görülmesi. | multi-agent. |
| GST-C31 — prevention/design failure | Load-bearing synchronization semantics'in first-class enforced interface invariant olmaması. | multi-agent causal synthesis. |
| GST-C32 — foreground dispatch contract | Parent'ın result'a ihtiyaç duyduğu Agent calls'ta explicit synchronous completion expectation. | multi-agent. |
| GST-C33 — carrier pin | Generated locations/contracts'ta foreground guidance'in structurally present olmasını test eden source-level guard. | multi-agent/testing. |
| GST-C34 — structural dispatch scanner | Agent-dispatch language olup foreground semantics eksik sites'i source scan ile yakalama. | multi-agent. |
| GST-C35 — captured tool-call E2E | Real agent'in actual Agent invocation args'ında foreground flag bulunduğunu doğrulama. | multi-agent/testing. |
| GST-C36 — runtime enforcement gap | Foreground semantics'in tüm sites/hosts için tool/runtime düzeyinde universally enforced olmaması. | multi-agent residual. |

## 4. Cross-model coordination

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-C37 — outside-model voice | Claude same-family child'dan farklı olarak Codex üzerinden model-diversity challenge. | multi-agent. |
| GST-C38 — Codex availability standing | disabled/under_codex/not_installed/not_authed/broken_install/model_unusable/ready gibi preflight states. | multi-agent. |
| GST-C39 — missing voice | Outside-model pass unavailable/timeout olduğunda “no finding” yerine missing coverage standing'i. | multi-agent. |
| GST-C40 — under-Codex nesting guard | Already Codex host altında nested Codex review'u same-model duplicated cost/diversity failure olarak suppress etme. | multi-agent. |
| GST-C41 — model diversity | Different model family/provider path'in potential challenge diversity sağlaması. | multi-agent. Independent oracle değil. |
| GST-C42 — cross-model consensus | Claude/Codex findings'in agreement/disagreement synthesis'i. | multi-agent. Common object/orchestration dependencies korunur. |
| GST-C43 — asymmetric context | Claude fresh child ile Codex accumulated prior-findings context'inin deliberately farklı olması. | Autoplan. |
| GST-C44 — degradation label | Codex/unavailable voice kaybını single-model/subagent-only gibi explicit tag ile taşımak. | multi-agent. |
| GST-C45 — same-family fallback | Outside-model unavailable olduğunda fresh Claude context kullanıp diversity loss'u açık tutma. | multi-agent. |
| GST-C46 — fresh context ≠ independent verification | Context separation'ın model/source/oracle common causes'i ortadan kaldırmaması. | multi-agent/testing. |

## 5. Isolation as a resource-specific property

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-C47 — context isolation | Child'ın parent history'sinden ayrı context'e sahip olması. | multi-agent. |
| GST-C48 — browser-tab isolation | Pair-agent own-only policy ile resource-scoped tab authority. | multi-agent/browser. |
| GST-C49 — filesystem/worktree isolation | Separate worktree/workspace üzerinden mutation conflicts'i ayırma. | multi-agent/host. Universal subagent default değil. |
| GST-C50 — process isolation | Child/test/runtime processes'in lifecycle/resource boundaries'i. | testing/runtime. |
| GST-C51 — memory isolation | Agent/project contexts arasında persistent information bleed'in sınırlanması. | memory/multi-agent. |
| GST-C52 — model separation | Same/different model family distinction. | multi-agent. |
| GST-C53 — fresh context ≠ side-effect isolation | Child new context'te olsa bile same repository working tree üzerinde commits/staging bırakabilmesi. | ship docs handoff. |
| GST-C54 — resource-specific isolation | “isolated agent” claim'inin hangi resource/state plane için geçerli olduğunun belirtilmesi. | multi-agent core correction. |

## 6. Host/model portability and compilation

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-C55 — host | Claude/Codex/Factory/Kiro/OpenCode/Slate/Cursor/OpenClaw/Hermes/GBrain gibi runtime/tool surface. | host synthesis. Model ile aynı değil. |
| GST-C56 — model overlay | Host'tan bağımsız model-specific behavioral/configuration adaptation. | host synthesis. |
| GST-C57 — host ≠ model | Runtime/platform tool semantics ile LLM model identity'nin separate axes olması. | host synthesis. |
| GST-C58 — HostConfig | Paths/frontmatter/rewrites/resolver suppression/runtime assets/learn-mode gibi host adaptation declarations. | host synthesis. |
| GST-C59 — portability compiler | Canonical template/resolver source'u host/model target'a preserve/rewrite/suppress/inline/weaken/unsupported kararlarıyla generate eden system. | host synthesis. |
| GST-C60 — canonical source contract | Template/resolver/runtime behavior semantics'in authoring source side. | host/repo-self. |
| GST-C61 — generated host surface | Target host için compiled/generated skill representation. | host synthesis. |
| GST-C62 — preserve | Source contract semantic/content'in host'ta doğrudan korunması. | host synthesis. |
| GST-C63 — rewrite | Host-specific path/tool/vocabulary ile contract'i translate etme. | host synthesis. |
| GST-C64 — suppress | Unsupported/invalid cross-model/GBrain/etc. behavior block'un host render'dan çıkarılması. | host synthesis. |
| GST-C65 — inline | Claude carved/on-demand section yerine external host monolith'e content embed etme. | host synthesis. |
| GST-C66 — weaken to advisory | Mechanical Claude hook semantics'in non-hook host'ta prose Safety Advisory'ye dönüşmesi. | host/guarded. |
| GST-C67 — unsupported / known gap | Generated surface'in required host primitive'i faithfully realize edememesi. | host synthesis. |
| GST-C68 — registered host | Typed registry'de entry bulunması. | host synthesis. |
| GST-C69 — generated host | Host-specific output üretilebilmesi. | host synthesis. |
| GST-C70 — installable host | Setup/materialization path'inin host için mevcut olması. | host synthesis. |
| GST-C71 — runtime-capable host | Generated instructions'ın ihtiyaç duyduğu runtime assets/tools/capabilities'in actual host'ta mevcut olması. | host synthesis. |
| GST-C72 — behaviorally exercised host | Real host workflow E2E'de intended behavior'ın çalıştırılmış olması. | host synthesis. |
| GST-C73 — failure-path exercised host | Host-specific failure/recovery semantics'in test edilmiş olması. | host synthesis. |
| GST-C74 — support tier | Host registry üyeliğinden farklı operational maturity/install contract class. | host synthesis. |
| GST-C75 — first-class install arm | Setup'ın generated skills + runtime roots/assets'i gerçek host install path'ine materialize etmesi. | host synthesis. |
| GST-C76 — methodology/instruction-tier integration | OpenClaw/Hermes gibi full Claude-style install yerine instruction/method delegation contract. | host synthesis. Inferior değil; farklı. |
| GST-C77 — external mod integration | GBrain gibi separate repo capability'sine aware render/mod surface. | host synthesis. |
| GST-C78 — runtime asset surface | Generated instruction'ın later dereference edeceği binaries/templates/checklists/support files. | host synthesis. |
| GST-C79 — installation topology | Skill aliases/runtime roots/sidecars/copies/symlinks'in host'a nasıl materialize olduğu. | host synthesis. |
| GST-C80 — generation health | Target surface'in syntactically/structurally coherent generate olması. | host synthesis. Runtime behavior equivalence değil. |
| GST-C81 — portability fidelity | Source contract'in target host/model/runtime'da hangi semantic standing'le gerçekten realized olduğu. | host synthesis. |
| GST-C82 — semantic leakage | Claude-specific primitive/argument/assumption'ın target host render'a kalıp executable olmaması. | Codex ship Step-18 example. |
| GST-C83 — capability adaptation | Literal tool rename yerine target host'ta native equivalent/inline/skip kararıyla semantic behavior'ı realize etme. | host synthesis. |
| GST-C84 — declarative registry / imperative setup drift | HostConfig architecture ile hand-coded setup arms'ın aynı host modelini farklı kaynaklarda taşıyıp drift edebilmesi. | host synthesis. |
| GST-C85 — aspirational/stale documentation | ADDING_A_HOST gibi docs'un intended fully-config-driven architecture'ı current implementation'dan stronger göstermesi. | host synthesis. |

## 7. Portability evidence ladder

gstack package şu ladder'ı kaynak içinde ayırır:

**config validates < generated output parses < paths/assets structurally pinned < setup installs coherent runtime < actual host loads skill < actual host completes workflow < failure/recovery semantics exercised < independent validation.**

Bunun sonucu:
- “host supported” tek bir binary property değildir.
- Skill adı aynı kalırken control strength değişebilir.
- Claude'da behaviorally verified contract external host'ta yalnız structurally generated olabilir.
- Green generated host tree semantic parity kanıtlamaz.
- Codex periodic CI all-skip gibi false-green external-runtime standing'i ayrıca korunmalıdır.

## 8. Coordination/portability relation view

**parent work → choose coordination mode → select child/model/context → bind authority/resource scope → execute with host-specific semantics → receive typed result/evidence → aggregate/reconcile → preserve degradation/missing coverage → continue or stop.**

Host adaptation aynı zincire ikinci dimension ekler:

**canonical contract → host capability profile → preserve/rewrite/suppress/inline/weaken/unsupported → install/runtime materialization → actual host execution → host-specific verification standing.**

Bu nedenle “agent”, “subagent”, “host”, “model”, “isolation”, “support” ve “verification” burada birbirinin yerine kullanılmaz.
