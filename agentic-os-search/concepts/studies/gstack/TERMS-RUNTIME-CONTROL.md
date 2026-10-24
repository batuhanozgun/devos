# gstack — Runtime, environment, authority and control terms

2026-09-20, **B6-T14**. TERMS.md'nin bağlı parçasıdır. Bu dosya browser/device/runtime, guarded-action, security, authority/effect ve Environment/control kullanımlarını taşır.

## 1. Stateful browser/runtime and evidence

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-R01 — $B / browser runtime | QA/ship/design workflows'ün browser evidence ürettiği persistent execution subsystem. | browser synthesis. Thin Playwright wrapper değil. |
| GST-R02 — long-lived daemon | Browser commands arasında yaşayan Bun server/process. | browser synthesis. |
| GST-R03 — BrowserManager | Browser/context/page lifecycle'ını yöneten runtime component. | browser synthesis. |
| GST-R04 — TabSession | Page, refs, snapshot baseline, frame ve loaded-HTML state'i tab-local tutan state object. | browser synthesis. |
| GST-R05 — persistent browser state | Tabs/profile/cookies/storage gibi state'in calls arasında kalması. | browser synthesis. Evidence freshness riskini de yaratır. |
| GST-R06 — headed persistent context | Visible browser + persistent Chromium profile kullanan mode. | browser synthesis. Headless false'tan daha geniş lifecycle semantics. |
| GST-R07 — headless cross-daemon persistence | BROWSE_PERSIST_STATE ile opt-in cookie/URL/storage restore. | browser synthesis. Always-on değil. |
| GST-R08 — snapshot → ref → action | ARIA/current page snapshot'tan semantic refs üretip later actions'ı o refs'e bağlama. | browser synthesis. |
| GST-R09 — stale ref | Navigation/frame change sonrası artık represented element'e güvenilir bağlanmayan ref. | browser synthesis. Fresh snapshot gerekir. |
| GST-R10 — annotation ambiguity / degraded evidence | Screenshot üretilse bile bazı annotation locator'larının ambiguous/unmeasurable olduğunun artifact'ta surfaced edilmesi. | browser synthesis. |
| GST-R11 — command taxonomy | browse commands'ın navigation/read/write/meta gibi documentation/runtime grouping'i. | browser synthesis. Security authority taxonomy'si değil. |
| GST-R12 — capability taxonomy | Actual side effect riskine göre read/write/admin/meta/control scope classification. | browser synthesis. |
| GST-R13 — root token | Local administrative browser authority taşıyan token. | browser synthesis. Tunnel surface'te reject edilir. |
| GST-R14 — scoped token | Bounded client identity + capabilities + domain/tab/rate/expiry restrictions taşıyan token. | browser synthesis. |
| GST-R15 — setup key / pairing ceremony | Remote client'in scoped token alması için short-lived/single-use bootstrap mechanism. | browser synthesis. |
| GST-R16 — scope class | read/write/admin/meta/control capability class. | browser synthesis. Role değil, effect authority dimension. |
| GST-R17 — domain allowlist | Scoped navigation/action'ın permitted domains ile sınırlandırılması. | browser synthesis. |
| GST-R18 — tab policy | Client'in hangi tabs üzerinde operation yapabildiğini belirleyen ownership policy. | browser synthesis. |
| GST-R19 — own-only tab isolation | Pair/tunnel client'in yalnız kendi owned tab'larında read/write yapabilmesi. | browser synthesis. Universal browser-client isolation değil. |
| GST-R20 — shared/local tab policy | Local skill clients'in user's existing tabs üzerinde çalışabilmesi için ownership'i hard boundary yapmayan policy. | browser synthesis. |
| GST-R21 — authority reduction / revocation | Re-pairing daha dar grant verirse broader existing session'ın hemen revoke edilebilmesi. | browser synthesis. |
| GST-R22 — local listener / tunnel listener | Bootstrap/admin surface ile remotely exposed pair/command surface'in ayrı TCP listeners'ta tutulması. | browser synthesis. |
| GST-R23 — tunnel command allowlist | Remote surface'te exposed path/commands'ın closed set ile sınırlandırılması. | browser synthesis. |
| GST-R24 — liveness endpoint vs credential bootstrap | Health/liveness bilgisinin root token/credential bootstrap'tan ayrılması. | browser synthesis. |
| GST-R25 — CDP deny-default | Raw Chrome DevTools methods'in explicit allowlist olmadan exposed edilmemesi. | browser synthesis. |
| GST-R26 — URL/navigation validation | Scheme/metadata/internal-risk target/path/DNS checks ile navigation/fetch effect boundary'sini koruma. | browser synthesis. |
| GST-R27 — shared effect boundary | Goto dışında direct fetch gibi alternate path'lere de aynı URL safety rule'unun taşınması. | browser synthesis. Systemic repair example. |
| GST-R28 — path security | Screenshot/PDF/download/output paths'ında containment/symlink/parent validation. | browser synthesis. |
| GST-R29 — remote file-serving boundary | Local writable/readable project paths ile remotely downloadable files'ın daha dar policy ile ayrılması. | browser synthesis. |
| GST-R30 — file-permission hardening | Sensitive runtime state'e owner-only permission uygulama çabası. | browser synthesis. Platform-dependent/best-effort. |
| GST-R31 — prompt/content trust envelope | Browser/page-derived content'i untrusted olarak markalayarak instruction authority'den ayırma. | browser synthesis. |
| GST-R32 — optional ML injection classifier | Extra prompt-injection signal üreten sidecar classifier. | browser synthesis. Fail-open defense-in-depth. |
| GST-R33 — persistent audit | Command-level JSONL forensic record. | browser synthesis. Best-effort; command success audit persistence garantisi değil. |
| GST-R34 — live activity stream | Bounded in-memory SSE/history operational visibility. | browser synthesis. Durable complete history değil. |
| GST-R35 — gap detection | Activity consumer cursor evicted range'in gerisinde kaldıysa missing history'nin surfaced edilmesi. | browser synthesis. |

## 2. Guarded action and security control families

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-R36 — /careful | Claude host'ta Bash PreToolUse hook ile destructive command patterns'ı allow/ask/deny sınıflandıran control. | guarded synthesis. |
| GST-R37 — MEDIUM destructive pattern | Çoğu destructive command family için human ask gate üreten class. | guarded synthesis. |
| GST-R38 — HIGH catastrophic pattern | Narrow simple-command classes için hard deny. | guarded synthesis. Universal shell sandbox değil. |
| GST-R39 — uncertainty-to-ask | Malformed/obfuscated/semantically hard shell input'ta silent allow yerine user review. | guarded synthesis. |
| GST-R40 — monotonic safety customization | User/project regex'lerinin baseline protections'ı yalnız güçlendirebilmesi, azaltamaması. | guarded synthesis. |
| GST-R41 — /freeze | Edit/Write tool calls'ını selected directory boundary ile sınırlayan scope lock. | investigate/guarded synthesis. Bash mutation outside boundary. |
| GST-R42 — freeze boundary / freeze-dir | Allowed mutation directory'yi taşıyan runtime state. | investigate synthesis. Explicit /unfreeze gerekebilir. |
| GST-R43 — /unfreeze | Persisted freeze state'i kaldıran explicit lifecycle operation. | investigate synthesis. |
| GST-R44 — /guard | careful Bash + freeze Edit/Write controls'ın composition'ı. | guarded synthesis. Unified sandbox değil. |
| GST-R45 — preventive interposition | Effect gerçekleşmeden tool/action path'inde ask/deny yapan control class. | guarded synthesis. |
| GST-R46 — decision-authority protection | One-way doors gibi human decision right'ını learned convenience preference'tan koruyan control. | guarded synthesis. |
| GST-R47 — detective/advisory security | CSO gibi finding üretip qualification/report veren ama effect'i mechanically stop etmeyen security family. | guarded synthesis. |
| GST-R48 — one-way door | Destructive/high-stakes/reversible-olmayan decision'ın silent auto-decision'a dönüştürülememesi. | guarded synthesis. |
| GST-R49 — two-way question | Clear recommendation + never-ask preference altında auto-decide edilebilen lower-risk/reversible decision class. | guarded synthesis. |
| GST-R50 — typed question registry | Known questions'ın one-way/two-way standing'ini prose wording'den bağımsız kodlanmış source. | guarded synthesis. |
| GST-R51 — keyword one-way classifier | Unregistered questions için conservative secondary safety net. | guarded synthesis. Primary authority source değil. |
| GST-R52 — /cso | Candidate security findings'i filter/verify/qualify/report eden detective security workflow. | guarded synthesis. Runtime prevention değil. |
| GST-R53 — daily security mode | High precision, minimum 8/10 threshold, “zero noise” oriented report mode. | guarded synthesis. |
| GST-R54 — comprehensive security mode | Low threshold ile weak candidates'ı TENTATIVE olarak surfaced eden recall-oriented mode. | guarded synthesis. |
| GST-R55 — severity | Potential impact class. | guarded synthesis. Confidence/status ile ayrı. |
| GST-R56 — confidence | Finding claim'ine assigned evidence confidence. | guarded synthesis. |
| GST-R57 — VERIFIED / UNVERIFIED / TENTATIVE | Security finding verification standing. | guarded synthesis. Severity ile aynı değil. |
| GST-R58 — source-quotation gate | Strong finding emit edilmeden current motivating source lines'ın quote edilebilmesi requirement'ı. | guarded synthesis. |
| GST-R59 — read-only behavioral scope | CSO'nun code mutation yapmaması instruction contract'ı. | guarded synthesis. Write capability report persistence için mevcut; technical sandbox değil. |
| GST-R60 — security report | Timestamped findings/trends/verification labels artifact'i. | guarded synthesis. Current live security standing değil. |
| GST-R61 — remediation authority | Fix/mitigate/accept/defer gibi security response choice'unun user one-way decision olarak kalması. | guarded synthesis. |

## 3. Authority, capability, effect and environment

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-R62 — legitimate authority | Bir actor'un transition/effect'i decide/approve etme hakkı. | cross-system/four-ground. |
| GST-R63 — technical effect power | Runtime/tool/environment üzerinden effect'i fiilen oluşturabilme kapasitesi. | cross-system/four-ground. Authority ile aynı değil. |
| GST-R64 — capability | Actor/model/tool'un bir operation'ı gerçekleştirebilme özelliği. | four-ground Actors/Environment. Availability/actionability ile aynı değil. |
| GST-R65 — Environment availability | Required runtime/tool/resource'un actual current environment'ta mevcut/erişilebilir olması. | four-ground Environment. |
| GST-R66 — situated actionability | Exact actor + work + environment + permission conditions altında action'ın gerçekten mümkün olması. | four-ground comparison. |
| GST-R67 — control objective | Korunmak istenen behavior/effect property. | cross-ground M5 / four-ground Control. |
| GST-R68 — enforcement point | Control'un intercept ettiği exact tool/path/transition. | cross-ground M5. Protected-effect scope ile aynı değil. |
| GST-R69 — governed/protected effect scope | Asıl kontrol edilmek istenen bütün materially equivalent effect routes. | guarded/cross-ground. |
| GST-R70 — one path blocked ≠ effect controlled | Tek tool/route'u kapatmanın aynı effect'e giden alternate paths'ı kapattığını kanıtlamaması. | freeze/Bash, host hook examples. |
| GST-R71 — runtime enforcement | Platform/hook/token/sandbox gibi mechanically effect'i constrain eden control. | guarded/host. |
| GST-R72 — advisory control | Model-facing prose/instruction ile behavior bekleyen ama mechanically enforce etmeyen control. | host portability. |
| GST-R73 — host-relative control strength | Aynı skill contract'ın Claude'da hook, external host'ta Safety Advisory prose olabilmesi. | host synthesis. |
| GST-R74 — fail-closed / ask / degrade / fail-open polarity | Missing/uncertain condition'a verilen farklı control response semantics. | browser/guarded/cross-system. Tek global policy yok. |
| GST-R75 — actual environment state | Repo/record'dan bağımsız real runtime/process/network/service condition. | four-ground Environment. |
| GST-R76 — Domain State / Domain Condition | Foundation projection'da actual constituents/relations ve realized current characteristics için kullanılan comparison language. | four-ground synthesis; gstack-native ontology değil. |
| GST-R77 — Work Conditions | Tool/runtime/model/credentials/network/filesystem/OS resources gibi Work'ü mümkün/kısıtlı kılan Environment conditions. | four-ground synthesis. |
| GST-R78 — component present ≠ capability ready | Registered skill/tool/runtime asset'in work için actually ready/sufficient olduğunu kanıtlamaması. | inventory/revalidation/host. |
| GST-R79 — registered / generated / installable / runtime-capable / exercised / validated | Host/capability standing ladder. | host synthesis. Boolean support yerine. |
| GST-R80 — specialized runtime vertical | iOS physical-device family gibi birden çok semantic cluster'ı compose eden product/runtime vertical. | inventory/closure audit. New first-order subsystem değil. |

## 4. Investigation / causal control

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-R81 — /investigate | Evidence-led, hypothesis-driven debugging/corrective workflow. | investigation synthesis. |
| GST-R82 — causal-before-mutation contract | Root-cause hypothesis/evidence olmadan fix'e geçmeme authored policy. | investigation synthesis. Mechanically confirmed-state gated değil. |
| GST-R83 — Root cause hypothesis | Specific/testable claim about mechanism and why symptom occurs. | investigation synthesis. |
| GST-R84 — falsification attempt | Logs/assertions/reproduction ile hypothesis'i yanlışlamaya çalışma. | investigation synthesis. |
| GST-R85 — three-strike escalation | Three failed hypotheses/attempts sonrası automatic agent continuation'ın bitip user/human decision'a dönmesi. | investigation synthesis. Wording hypothesis/fix attempts arasında ambiguous. |
| GST-R86 — minimal causal intervention | Confirmed mechanism'i ortadan kaldıran smallest intended fix. | investigation synthesis. |
| GST-R87 — regression test | Fix olmadan fail, fix ile pass etmesi beklenen recurrence-sensitive test. | investigation synthesis. |
| GST-R88 — fresh original-symptom reproduction | Regression/unit test yanında original observed bug scenario'nun yeniden çalıştırılması. | investigation synthesis. |
| GST-R89 — DONE / DONE_WITH_CONCERNS / BLOCKED | Investigation completion/report standings. | investigation synthesis. |
| GST-R90 — systemic root cause | Occurrence cause yanında prevention/detection/systemic contributor'ları da açıklayan deeper causal account. | investigation qualification. Workflow bunu mandatory guarantee etmez. |
| GST-R91 — proximate causal mechanism | Immediate symptom'u açıklayıp local fix'i justify edebilen cause level. | investigation synthesis. Source bazen buna “root cause” diyebilir. |
| GST-R92 — architectural smell | Recurring failures/cascading fixes/multiple failed hypotheses/large blast radius'ın wrong-layer pressure signal'ı olması. | investigation synthesis. |

## 5. Runtime-control relation view

gstack kaynaklarında control/effect zinciri kabaca:

**actor identity + role → legitimate authority → environment/tool capability → exact enforcement point → bounded effect attempt → runtime/effect observation → current standing → next authority decision.**

Bu zincirde şu non-collapse'lar korunur:

- Role ≠ authority.
- Authority ≠ capability.
- Capability ≠ environment availability.
- Allowed tool call ≠ protected effect controlled.
- Security report ≠ current security state.
- Fresh verifier ≠ independent oracle.
- Runtime effect attempted ≠ target state realized.
