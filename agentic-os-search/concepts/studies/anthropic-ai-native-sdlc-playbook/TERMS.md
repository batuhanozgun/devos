# Anthropic AI-Native SDLC Playbook — Bağlamlı kullanım kayıtları

2026-09-20, **B6-T13 / KALICI-AKTARIM-TAMAM / PACKAGE-COMPLETE**. Gerçek kaynak/okuma hesabı [READING.md](READING.md)'dedir.

Bu dosya `research/studies/anthropic-ai-native-sdlc-playbook/` araştırmasındaki terim ve kavramsal ayrımları **bu araştırmanın kendi kullanımında** kaydeder. Claude/Anthropic ürünlerinin current resmî sözlüğü, SOUL/Development OS architecture kararı veya Foundation taxonomy değildir.

İki concepts riski görünür tutulur: önemli anlam seçimleri/dayanaklar izlenebilir olmalı; aynı kelimeyi kullanmak aynı kavramı garanti etmediğinden user approval, source usage ve extractor interpretation birbirinin yerine konmamalı.

## 1. Paket-geneli operating-model dili

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| SDLC01 — AI-Native SDLC Playbook | Agentic implementation throughput'unu artifact, control, verification, observability ve human governance ile birlikte yeniden düzenleyen software-domain operating-model prior art. | META/STATE/00/01. General SOUL architecture değil. |
| SDLC02 — software-domain operating system prior art | Software work için task-specific operating system benzeri concrete model; SOUL'un Genesis/Core'unu ikame etmez. | META/STATE/03. |
| SDLC03 — six-stage SDLC | Plan, Design, Build, Test, Deploy, Maintain başlıkları. | 01 §3; 04 F1. Domain organizing frame, universal Work ontology değil. |
| SDLC04 — play dependency graph | Twelve play'in prerequisite/dependency ilişkileri; stage membership ile aynı değil. | 01 §4; Academy companion. |
| SDLC05 — machine-readable persistent state transition | Work state'in conversation memory yerine committed/versioned artifacts üzerinden sonraki stage'e taşınması. | 01 §3. |
| SDLC06 — committed artifact chain | source signal/intent → spec → plan → code/tests → PR/review → deployment evidence → incident/new intent zinciri. | 01 §3/§17. Existence correctness guarantee değil. |
| SDLC07 — artifact-bound handoff | Sonraki actor/session'ın exact persisted artifact üzerinden work devralması. | 00/01. |
| SDLC08 — throughput bottleneck shift | Build throughput hızlanınca planning/review/test/deploy/control kapasitesinin yeni bottleneck olması. | 01 §2. |
| SDLC09 — throughput-aware system design | Production capacity arttığında review/control/integration capacity'nin de sistem düzeyinde yeniden düşünülmesi. | 01 §2/§18; 04 F10. |

## 2. Intent, specification, plan ve artifact identity

| ID / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SDLC10 — `intent.md` | What/why/who/constraints/open questions taşıyan originator-intent representation. | 01 §5. Outcome'un kendisi değil. |
| SDLC11 — accepted intent | Human/product-owner review sonrası downstream design için kabul edilen intent representation. | 01 §5–6. Work admission ile broader project authority aynı olmayabilir. |
| SDLC12 — `spec.md` | Accepted intent'in design/specification representation'a dönüştürülmüş hali; policy constraints uygulanabilir. | 01 §6. |
| SDLC13 — `plan.md` | Implementation öncesi files/order/risks/tests/proof gibi plan bilgisini taşıyan committed artifact. | 01 §7.1. |
| SDLC14 — ex-ante plan | Mutation öncesi accepted plan revision. | 01 §7.1; 04 F4. |
| SDLC15 — implementation deviation | Execution sırasında accepted plan'dan sapma. | 01 §7.1; 04 F4. |
| SDLC16 — revised plan / as-built state | Yeni evidence/gerçek execution sonrası planın güncel veya as-built representation'ı. | 01 §7.1; 04 F4. Ex-ante planla sessizce collapse edilmemeli. |
| SDLC17 — artifact identity / exact revision | Intent/spec/plan/diff/review/eval'in hangi exact version/commit'e ait olduğu. | 03/04 open questions. |
| SDLC18 — derivation / transformation fidelity | Artifact B'nin A'dan türemiş olması ile A'nın meaning/authority'sini faithfully taşıması arasındaki ayrım. | 04 F2. |
| SDLC19 — source of truth | Belirli artifact/fact için authoritative home. | 04 F3. İki mutable equal authority problemli. |
| SDLC20 — working copy / mirror / transition state | Authoritative source'a bağlı ama kendisi authority olmayan migration/sync representation. | 04 F3. |
| SDLC21 — unresolved divergence | İki representation/source farklılaştığında conflict'in first-class state olması. | 04 F3. |

## 3. Context, memory, rules ve Skills

| ID / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SDLC22 — `CLAUDE.md` | Project commands/conventions/architecture/common mistakes/local rules gibi persistent model-visible project context. | 01 §7.2; ledger D09. Hard enforcement değil. |
| SDLC23 — auto-memory | Sessions arasında model-visible information taşıyan context/memory surface. | 01 §7.2. Enforced configuration değil. |
| SDLC24 — rules / path-scoped rules | Project/nested/path-scoped instructions/context surfaces. | 01 §7.2. |
| SDLC25 — Skill / `SKILL.md` | Conditionally relevant/invoked procedural/institutional instruction package. | 01 §7.3; ledger D06. |
| SDLC26 — always-relevant context | Her session/turn için sürekli model-visible project guidance. | 01 §7.3. |
| SDLC27 — conditionally relevant procedure | Yalnız relevant/invoked olduğunda context'e giren procedure/skill content. | 01 §7.3. |
| SDLC28 — advisory guidance | Modeli yönlendiren fakat action'ı mechanically block etmeyen context/instruction layer. | META/01 §10.1. |
| SDLC29 — enforced configuration / hard control | Model choice'tan bağımsız mechanically constrain/block eden control layer. | 01 §7.2/§10; 04 F7. |
| SDLC30 — instruction accretion | Repeated failures'a sürekli yeni prose ekleyerek instruction file'ın büyümesi. | 01 §7.2. Missing knowledge vs mechanical invariant ayrımı gerekir. |

## 4. Hooks, permissions, sandbox ve control layers

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| SDLC31 — Hook | Tool/action event'i öncesi/sonrası observe/block/validate/approval logic çalıştırabilen deterministic event-linked control. | 01 §7.4/§10.2. Complete boundary değil. |
| SDLC32 — PreToolUse Hook | Action başlamadan block/approval/validation için kullanılan hook yüzeyi. | 00/01. Exact product semantics time-sensitive. |
| SDLC33 — permission rule | Tool/command kullanımını allow/ask/deny gibi action-policy ile sınırlayan control. | 01 §10.3; ledger D22. |
| SDLC34 — sandbox | Filesystem/network/process effect'lerini OS-level sınırlandıran environment control. | 01 §10.4; ledger D23. |
| SDLC35 — managed settings | Organization-controlled configuration/precedence surface. | 01 §10.6; ledger D17/D21. |
| SDLC36 — customization lockdown | Local/project user'ın critical plugin/skill/hook/agent/MCP/settings sources'ını genişletememesine yönelik enterprise control. | 01 §10.6. |
| SDLC37 — managed MCP / tool admission | Hangi external MCP/tool servers'ın available olduğu üzerinde centralized control. | 01 §10.5; ledger D25. |
| SDLC38 — network restriction / allowlist | Shell/process gibi alternate path'lerin external effect üretmesini lower-level ağ politikasıyla sınırlandırma. | 01 §10.4; 04 F7. |
| SDLC39 — branch protection / external gate | Repo/production transition'ını model instruction'dan ayrı external system control ile sınırlama. | 01 §9.2/§17. |
| SDLC40 — control hierarchy / layered control architecture | Context/Skill → Hook → permission → sandbox → managed settings/identity/tool/network → external/human gate gibi farklı strength ve scope'taki control layers. | META/00/01/03. Anthropic product ontology'si değil; research synthesis. |
| SDLC41 — alternate-path closure | Protected effect'e giden materially equivalent action paths'ın tümünün control boundary'den geçip geçmediğini sınama. | 03 §5.2; 04 F7. |

## 5. Actors, sessions, subagents ve authority

| ID / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SDLC42 — Claude Code session | Software work'ü yürüten agent execution/session yüzeyi. | 01 §7.5. Current product semantics time-sensitive. |
| SDLC43 — parallel full sessions | Isolated worktrees üzerinde aynı engineer tarafından steer edilen multiple full sessions. | 01 §7.5; 04 F10. |
| SDLC44 — worktree isolation | Parallel mutation streams için file/branch workspace isolation. | 01 §7.5. Merge semantics ayrıca gerekir. |
| SDLC45 — subagent | Main session altında scoped context/tool limits ile bounded helper execution. | 01 §7.5; ledger D13. |
| SDLC46 — fresh verifier subagent | Producer trajectory'sinden ayrı fresh context ile final check yapan, report-but-not-repair role. | 01 §8.2. Fresh context ≠ independence. |
| SDLC47 — product owner | Intent/design review ve correction yapan human role. | 01 §5–6. |
| SDLC48 — policy owner | Policy conflicts/value constraints için human authority role. | 01 §6. |
| SDLC49 — engineer as orchestrator | Parallel sessions'ı steer/merge/review eden human engineer. | 01 §7.5; 03 §4.6. SOUL hedefindeki no-hidden-owner ile gerilimli. |
| SDLC50 — code owner / release manager / service owner | Review/deploy/production human authority roles. | 01 §9/§12–14. |
| SDLC51 — scoped identity | Agent/tool execution'ın limited credential/identity ile bağlanması. | META/01 §9.2/§13. |
| SDLC52 — direct permission | Actor'ın kendi tool/action yüzeyinden doğrudan yapabildiği etki. | 00/01/04 F8. |
| SDLC53 — effective / transitive authority | Actor'ın reachable agents/tools/channels üzerinden indirekt olarak cause edebileceği etki. | META/STATE/01 §13.3/04 F8. |
| SDLC54 — reachable action path | Actor→channel/tool/other actor→effect zinciri. | 04 F7–F8. Future design pressure, accepted authority graph değil. |

## 6. Autonomy, environment ve gates

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| SDLC55 — tiered autonomy | Environment/action/risk'e göre farklı izin ve gate düzeni. | 01 §9.2; 03 §5.3. |
| SDLC56 — environment-tiered autonomy | Development, CI ve production'ın aynı permission modelini paylaşmaması. | META/STATE/03. |
| SDLC57 — autonomy relation | Actor/role + action class + target environment + risk + evidence/gate state kombinasyonuna bağlı allowed/ask/deny/escalate. | 03 §5.3/DP-04. Project synthesis. |
| SDLC58 — production gate | Agent'ın production etkisine geçmeden önce external/human release authority'ye takıldığı boundary. | 01 §9.2. |
| SDLC59 — human approval gate | High-impact action için human authority decision. | 00/01/03. Technical verification ile aynı değil. |
| SDLC60 — actual target state / operating reality | Repo/spec/model representation dışında, action anındaki gerçek production/database/environment condition. | 00 §7; 01 §15; 04 F11. |
| SDLC61 — pre-execution precondition check | High-impact action öncesi live veya sufficiently faithful target state'i doğrulama. | 03 DP-05; 04 F11. |
| SDLC62 — environment readiness / sufficiency | Tool/config varlığından ayrı, Work için actual usable/safe operating condition. | 03 Foundation comparison/04 questions. |

## 7. Verification, feedback ve evals

| ID / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SDLC63 — producer self-feedback | Agent'ın build/test/screenshot/runtime inspect ederek kendi work'ünü iteratively düzeltmesi. | 01 §8.1. Independent verification değil. |
| SDLC64 — fresh verifier | Fresh context + limited tools ile separate final-check role. | 01 §8.2; 04 F6. Independence guarantee değil. |
| SDLC65 — failing-test-before-fix | Bug'ı önce red test olarak reproduce edip sonra implementation değiştirme. | 01 §8.3. |
| SDLC66 — protected oracle/test | Fix sırasında agent'ın test/oracle'ı değiştirmesinin engellendiği evidence pattern. | 01 §8.3; 04 F5. |
| SDLC67 — red→green evidence | Reproduced failure'ın test conditions altında artık oluşmadığına dair strong bounded evidence. | 04 F5. Universal bug-proof değil. |
| SDLC68 — exact-target verification | Verification result'ın exact artifact/version/configuration'a bağlanması. | 03 §4.2; Development OS comparison. |
| SDLC69 — stale verdict | Target/config material change sonrası eski verification result'ın current sayılması riski. | 03 §4.2/DP-01. |
| SDLC70 — PR review | Diff/policy/risk/findings için review layer. | 01 §9.1. Verification/human acceptance ile aynı değil. |
| SDLC71 — human technical review | Human'ın gerçekten technical evidence'i inspect ettiği durum. | 04 F9. Human approval ile ayrı. |
| SDLC72 — configuration regression | `CLAUDE.md`, Skills, Hooks, prompts, model/config değişince agent behavior'ın regression göstermesi. | STATE/01 §8.4/03 §5.1. |
| SDLC73 — configuration eval suite | Agent-steering configuration değişikliklerini real tasks/expected outcomes ile test eden suite. | 01 §8.4. |
| SDLC74 — configuration identity | Hangi exact instructions/Skills/Hooks/model/prompts sürümünün eval edildiği. | 03 DP-01. |
| SDLC75 — incident-derived eval | Production incident/failure'ın permanent regression/challenge case'e çevrilmesi. | META/STATE/01 §8.4/§12. |
| SDLC76 — challenge-set aging/freshness | Model/system geliştikçe eski eval cases'in discriminative value kaybetmesi ve yeni failure cases gerekmesi. | 01 §8.4; 03 DP-06; 04 F13. |
| SDLC77 — shadow mode | Candidate reviewer/control'un authority almadan observation/compare modunda çalıştırılması. | 03 §5.5. |
| SDLC78 — sampled audit | Automated approvals/controls'un bounded random/targeted human/external audit ile gözlenmesi. | 03 §5.5. |

## 8. Observability ve operational evidence

| ID / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SDLC79 — observability | Artifact yanında action/control/tool/permission/runtime path'in izlenebilir olması. | META/STATE/01 §11. |
| SDLC80 — OpenTelemetry trace/event surface | Tool decisions/results, permission mode, MCP, Skill, Hook, plugin, errors/retries, subagent lineage vb. operational events. | 01 §11; ledger D28. Event schema time-sensitive. |
| SDLC81 — subagent lineage | Parent/child agent execution ilişkilerinin telemetry'de izlenmesi. | 01 §11. |
| SDLC82 — control-plane audit | Hangi control/hook/permission/tool path'in actual action'da devreye girdiğini reconstruct etme. | 03 DP-07. |
| SDLC83 — SIEM/compliance activity | Operational/security activity'nin external audit/retention surfaces'a aktarılması. | 01 §11; ledger D28/D30. |
| SDLC84 — observability evidence infrastructure | Telemetry'nin semantic correctness değil, diagnosis/governance için evidence substrate olması. | 04 F18. |
| SDLC85 — loop observability | Final artifact'ın yanı sıra decisions/actions/controls/lineage'in uçtan uca gözlenebilmesi. | META/STATE. |

## 9. Maintain, incident ve evolution loop

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| SDLC86 — production signal | Control-band breach, ticket, channel event, schedule veya recurring scan gibi new Work tetikleyici. | 01 §12. |
| SDLC87 — governed work generation | Operating signal'ın deterministic trigger + bounded diagnosis + persistent evidence/intent üzerinden controlled lifecycle'a dönmesi. | 01 §12. |
| SDLC88 — control band | Metric/condition threshold'larına göre response tier belirleme. | 01 §12/04 F14. Metric truth değildir. |
| SDLC89 — response tier | Low=log, medium=read-only diagnosis, high=proposal/PR/pre-approved runbook gibi bounded action level. | 01 §12. |
| SDLC90 — incident → new intent | Operational failure diagnosis'ın yeni persistent intent/work input üretmesi. | 01 §12/§14. |
| SDLC91 — failure-to-eval evolution | Incident fix/failure class'ın agent configuration eval suite'e durable case olarak eklenmesi. | STATE/01 §12/03. |
| SDLC92 — closed-loop maintenance | Production observation → diagnosis/work → fix → verify/deploy → new observation döngüsü. | META/01 §12/§17. Automatic safe self-improvement değil. |

## 10. Source-of-truth, reality ve falsifier dili

| ID / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SDLC93 — repository truth / declared state | Git/artifact'ta kayıtlı intended/declared state. | META/00/01 §15/04 F11. |
| SDLC94 — deployed / operating reality | Real production data/configuration/clients/capacity/locks/policies vb. actual state. | Atlas counter-read; 04 F11. |
| SDLC95 — repo–reality gap | Repo artifacts/testlerin correct iken live target conditions yüzünden action'ın unsafe/failing olabilmesi. | META/STATE/00/01 §15/04 F11. |
| SDLC96 — live-state binding | Plan/action'ın execution-time target conditions'a as-of binding/check ile bağlanması. | 03 DP-05/04 F11. Candidate pressure. |
| SDLC97 — rollback | Önceki state'e geri dönüş yolu olarak kullanılan operational concept. | 01 §9.2/04 F12. Always true inverse değil. |
| SDLC98 — compensation / forward repair | Irreversible/external effects için inverse rollback yerine corrective action. | 04 F12. Work research relation. |
| SDLC99 — reversible vs recoverable | Bir effect'in gerçekten undo edilebilir olması ile alternative recovery/compensation bulunması arasındaki ayrım. | 04 F12. |

## 11. System formation ve platform assumptions

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| SDLC100 — platform assumption | Affected service/owner/reviewer/context/blast radius/gates'in already resolvable olduğu örtük prerequisite. | Port counter-read; 00 §8/01 §16/04 F15. |
| SDLC101 — system formation / Genesis gap | Good domain workflow tanımlamanın arbitrary objective için doğru system/actors/context/controls'u derive etmekten farklı olması. | 00 §8; 01 §16; 03 §1/§4.7; 04 F15. |
| SDLC102 — domain operating profile | Six-stage/playbook shape'in software-domain task-specific operating model olarak kullanılması. | STATE/03. Core/universal workflow değil. |
| SDLC103 — external prior art / design pressure | Later authorised design'da mechanism/falsifier/example olarak kullanılabilecek research evidence. | META/STATE/03. Adoption değil. |

## 12. Source credibility / evidence status

| ID / ifade | Yerel kullanım |
|---|---|
| SDLC104 — first-party operational claim | Anthropic'ın kendi productivity/adoption/practice gözlemleri; “Anthropic reports…” statüsünde. |
| SDLC105 — independent efficacy evidence | Anthropic dışı/local controlled evidence; package'ta first-party claims için çoğunlukla yok. |
| SDLC106 — bounded vendor falsifier | Atlas/Port gibi commercial incentive taşıyan source'un useful problem/counterexample kısmı. |
| SDLC107 — problem evidence vs proposed remedy | Vendor critique'teki structural problem'i vendor product solution recommendation'dan ayırma. |
| SDLC108 — revalidation map | Current product/API/setting/telemetry claims'i later decision öncesi official source'tan tekrar kontrol etme listesi. |

## 13. Assessment'in design-pressure dili

Aşağıdakiler **accepted requirements değil**, project-specific candidate pressures:

- **DP01 — configuration regression lifecycle:** agent-control configuration'ın code-like version/eval/change gate taşıması.
- **DP02 — transitive authority:** effective action surface'in reachable actors/tools/channels üzerinden değerlendirilmesi.
- **DP03 — advisory vs deterministic control classification:** load-bearing policy'nin context/advisory/detectable/blockable/verified/externally-authoritative statüsünün açıklanması.
- **DP04 — relational autonomy:** autonomy'nin actor/action/environment/risk/evidence/gate relation'ı olarak ele alınması.
- **DP05 — live precondition verification:** high-impact action'da actual target state'in action sınırına yakın doğrulanması.
- **DP06 — challenge freshness:** eval/control suites'in coverage/freshness/retirement/new-failure admission lifecycle'ı.
- **DP07 — observe the loop:** governance claims için runtime decisions/actions/control paths'ın da evidence olması.

## 14. Paket içi katmanlı mekanizma görünümü

Araştırmanın synthesized layer view'i:

1. **Purpose / Work Representation** — intent/spec/plan/code/tests/PR/incident.
2. **Context / Knowledge** — CLAUDE.md/rules/Skills/memory/repository/linked sources.
3. **Actors / Execution** — sessions/subagents/humans/CI agents.
4. **Control** — Hooks/permissions/settings/sandbox/identity/branch protection/MCP/network/human gates.
5. **Verification / Evaluation** — self-feedback/verifier/PR review/CI/evals/security scans/production measures.
6. **Observability / Evidence** — Git/PR/tool/session/OTel/analytics/SIEM.
7. **Evolution / Closed Loop** — incident→diagnosis→intent→fix→eval/config update.

Bu layer view **Anthropic'ın resmî ontology'si değildir**; source mechanisms'i açıklamak için araştırmacı synthesis'tir.

## 15. Kapanış

B6-T13'te 8/8 package source file tam okundu ve source role/statüleri ayrıldı. Somut kullanım eksiği bulunmadı.

Paketin core source-bounded sonucu:

> **Agent-native software work, yalnız LLM + coding tool değil; persistent work state, context/knowledge surfaces, bounded actors, layered controls, verification/evaluation, observability, evolution, human authority ve actual execution environment'in birlikte işletilmesidir.**

Bu conclusion candidate study synthesis'idir; SOUL/Development OS architecture acceptance veya universal SDLC law değildir.
