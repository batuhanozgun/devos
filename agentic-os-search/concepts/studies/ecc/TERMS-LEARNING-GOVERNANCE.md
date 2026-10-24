# ECC — Learning, evaluation and governance terms

2026-09-23 · **C3 source-family aktarımı korunur; C6b E04/E05 ham-kanıt refinement'i eklendi.** [TERMS.md](TERMS.md)'nin linked parçasıdır. Bu dosya U05–U06 source package kullanımını taşır.

## 1. Observation and instinct lifecycle

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-L01 — observation | Selected tool/use event'ten bounded serialized evidence record. | Full interaction/transcript değil. |
| ECC-L02 — observation capture | Pre/post tool paths'ından project-scoped observation append etme. | Every interaction recorded guarantee değil. |
| ECC-L03 — observation filter | minimal/disabled/subagent/automated-session vb. paths'i kayıt dışı bırakma policy. | Missing record = no event occurred değil. |
| ECC-L04 — observation truncation | Tool input/output'un bounded 5k representation'a daraltılması. | Full original event değil. |
| ECC-L05 — scrubbed observation | Best-effort secret-pattern removal sonrası stored representation. | Confidentiality/security proof değil. |
| ECC-L06 — observer | Captured observations'ı model-assisted pattern analysis'e çeviren optional component. | Always enabled değil. |
| ECC-L07 — observer enabled | Config gate enabling analysis loop. | Observation recording ile aynı değil. |
| ECC-L08 — instinct | Trigger/action/confidence/evidence metadata taşıyan learned procedural record. | Validated behavior improvement değil. |
| ECC-L09 — personal instinct | Project/personal directory'deki procedural record. | Global promotion değil. |
| ECC-L10 — inherited instinct | Project'te another/global source'tan visible record. | Independent evidence origin garanti değil. |
| ECC-L11 — global instinct | Explicit promotion/auto-promotion sonrası global namespace record. | Universal applicability proof değil. |
| ECC-L12 — confidence | Stored/derived numeric field reflecting heuristic/model-authored certainty/frequency. | Calibrated task-quality probability değil. |
| ECC-L13 — evidence text | Instinct record'daki free-form support text. | Independent verified evidence değil. |
| ECC-L14 — analysis completion marker | Observer loop'un literal final JSON completion signal'i. | Correct learning/inference proof değil. |
| ECC-L15 — sampled analysis window | Tail N observations used by observer analysis. | Archived whole file ile same set değil. |
| ECC-L16 — processed archive | Successful marker sonrası observations file'ın archive'a taşınması. | Every archived observation analyzed guarantee değil. |
| ECC-L17 — retry-retained input | Analysis failure sonrası live observation file'ın retained olması. | Generated instinct side effects rolled back guarantee değil. |

## 2. Promotion and generated artifacts

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-L18 — explicit promote | Operator-selected instinct ID'yi global namespace'e taşıma operation. | Cross-project repeated evidence requirement değil. |
| ECC-L19 — auto-selected promote | Same ID multiple registered projects + average confidence threshold ile promotion candidate. | Semantic agreement/independent evidence guarantee değil. |
| ECC-L20 — project count | Promotion condition'da same ID'nin distinct projects'teki presence count'i. | Distinct underlying learning histories guarantee değil. |
| ECC-L21 — average confidence | Cross-project instances'dan averaged numeric value. | Agreement validity/benefit metric değil. |
| ECC-L22 — evolve | Instinct groups'tan candidate skill/command/agent artifacts üretme process. | Generated artifact installed/used/effective demek değil. |
| ECC-L23 — skill candidate | Trigger-keyword cluster meeting candidate-count rules. | Quality/admission gate değil. |
| ECC-L24 — workflow-command candidate | Higher-confidence rules'la command template candidate. | Runtime use receipt değil. |
| ECC-L25 — agent candidate | Member-count + average-confidence threshold'dan generated agent candidate. | Host support/behavioral correctness değil. |
| ECC-L26 — generated artifact | Evolved directory altında produced file/template. | Active learned-skill directory ile aynı değil. |
| ECC-L27 — learned skill directory | Agent-data home/skills/learned consumer path. | Evolved output automatically copied there guarantee değil. |

## 3. Behavioral context injection

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-L28 — SessionStart instinct selection | Project/global instinct records'i filter/rank/cap edip context'e taşıma. | Current task-aware semantic matching değil. |
| ECC-L29 — relevance boost | Project/location/stack match'e score bonus. | True applicability oracle değil. |
| ECC-L30 — context cap | Delivered instinct/context total char limit. | All selected evidence preserved değil. |
| ECC-L31 — compact action line | Scope/confidence + first action line rendering. | Trigger/evidence/ID/full multiline action korunmaz. |
| ECC-L32 — condition compression | Conditional trigger'ın rendered action view'da kaybolabilmesi. | Model misuse observed demek değil. |
| ECC-L33 — additionalContext | Host hook result'ta model-visible context carrier. | Model obeyed/benefited guarantee değil. |
| ECC-L34 — direct instinct injection | Evolve/global-promotion olmadan personal instinct'in later SessionStart'a girebilmesi. | Validated closed-loop learning değil. |

## 4. Skill outcome and evaluation

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-L35 — skill invocation telemetry | Skill tool event'ten success/failure-labelled run record. | Whole task success değil. |
| ECC-L36 — skill-run tracker | Invocation-level outcome JSONL/state-store producer. | Independent task evaluator değil. |
| ECC-L37 — skill observation | Task/skill/success/feedback/amendment metadata taşıyan improvement record. | Tracker row ile same schema değil. |
| ECC-L38 — outcome label | caller/hook tarafından supplied success/failure standing. | Externally verified outcome değil. |
| ECC-L39 — skill health (improvement) | Failure count'e dayalı healthy/watch/failing summary. | Rolling-rate health ile same metric değil. |
| ECC-L40 — skill health (evolution) | 7/30-day success rates + trend + pending amendments + current version label. | Version-bound experiment değil. |
| ECC-L41 — healthy_skills | Declining olmayan skill count-derived headline. | Sufficient evidence/success quality guarantee değil. |
| ECC-L42 — no-data health edge | Null rates/stable trend ile non-declining sayılabilme. | Positive evidence değil. |
| ECC-L43 — constant-failure health edge | Equal 0% windows → stable/non-declining label. | Healthy task outcome anlamına gelmez. |
| ECC-L44 — amendify proposal | Failure labels/tasks/feedback'ten generated Markdown change suggestion. | Demonstrated causal repair değil. |
| ECC-L45 — insufficient-evidence | No failures/too little data path'inde proposal/eval refusal standing. | Global absence of need değil. |
| ECC-L46 — repeated-failure rationale | Proposal prose'daki “repeated” wording. | Single failure caseinde bile proposal üretilebildiği için source predicate değil. |
| ECC-L47 — baseline variant | evaluate helper'da variant != amended olan records. | Exact baseline bytes/version binding değil. |
| ECC-L48 — amended variant | variant=="amended" records. | Single amendment identity unless selector used değil. |
| ECC-L49 — amendmentId selector | Amended rows'i specific ID ile filter eden control. | Authenticated content binding değil. |
| ECC-L50 — recorded success rate | Labelled rows'dan computed ratio. | Comparable-task independent metric değil. |
| ECC-L51 — promote-amendment | Enough rows + positive rounded rate delta verdict. | Better skill causally proven değil. |
| ECC-L52 — keep-baseline | Zero/negative rate difference verdict. | Baseline globally superior proof değil. |
| ECC-L53 — duplicate-row sensitivity | Same observation IDs duplicated olsa da counts/rates'in artabilmesi. | Independent trials guarantee olmadığını gösterir. |
| ECC-L54 — task comparability gap | Unrelated amended task labels aynı outcomes ile same promote result verebilmesi. | Actual tasks equally easy/hard measured değil. |
| ECC-L55 — mixed-amendment pooling | Selector yoksa multiple amendment IDs'nin aggregate amended group'a girmesi. | One candidate version verdict değil. |
| ECC-L56 — version snapshot | SKILL.md historical snapshot/log mechanism. | Quality/evaluation acceptance değil. |
| ECC-L57 — rollback-to-version | Previous skill snapshot restore + new version creation. | Validated behavioral rollback değil. |

## 5. Configuration protection

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-L58 — config protection guard | Selected linter/formatter basenames'e Write/Edit proposal block predicate. | Universal configuration/security guard değil. |
| ECC-L59 — protected basename | Fixed name set used for path-based selection. | Canonical target identity değil. |
| ECC-L60 — existing protected file | lstat-success protected path → block. | Edit weakens rule demek değil. |
| ECC-L61 — absent protected file | Protected basename path yoksa guard no-objection. | Creation safe/authorized guarantee değil. |
| ECC-L62 — alias path | Unprotected name aynı underlying target'a point etse de basename guard tarafından selected olmayabilir. | Live host bypass incident değil. |
| ECC-L63 — profile gate | minimal/standard/strict etc. hook activation selection. | Authenticated operator policy değil. |
| ECC-L64 — managed hook config | ECC config'den effective profile/hook settings fallback. | Enterprise-enforced host policy ile aynı değil. |
| ECC-L65 — dry-run | Guard decision preview/no block path. | Authorized actual write değil. |
| ECC-L66 — oversized-input refusal | Runner truncation flag, admitted/enabled security hook'a incomplete payload standing'i taşıyıp config-protection'ın block path'ini tetikleyebilir. | Her oversized event veya inactive profile block değildir; conversation E05 minimal-profile karşılığı guard admission'ının ayrı olduğunu gösterir. |
| ECC-L67 — malformed-input no-objection | Parse failure→empty object path. | Host authorized demek değil. |
| ECC-L68 — exit 2 block | Config-protection runner'ın host contract-level blocking signal'i. | Every hook uses nonzero blocking değil. |

## 6. GateGuard fact-forcing

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-L69 — GateGuard | First-touch interruption/context-request mechanism. | Verified investigation engine değil. |
| ECC-L70 — first-touch mark | Key'i state'e yazıp initial request'i deny etme sequence. | Facts actually gathered proof değil. |
| ECC-L71 — checked key | Path/command/session key previously marked standing. | Current evidence/justification cached değil. |
| ECC-L72 — fact-forcing request | Importers/interfaces/schemas/user instruction/rollback gibi investigation prompts. | Response validated/admitted değil. |
| ECC-L73 — repeat allow/no-objection | Same retained key later request'te challenge edilmemesi. | Investigation completed guarantee değil. |
| ECC-L74 — file key | Raw file path based retained key. | File content/digest/instruction binding değil. |
| ECC-L75 — destructive command key | Command text hash-based retained key. | Target state/CWD/approval binding değil. |
| ECC-L76 — routine shell session key | Bash/PowerShell routine commands için shared __bash_session__ key. | Every command purpose revalidated değil. |
| ECC-L77 — key expiry | Shared inactivity-based TTL. | Evidence semantic freshness değil. |
| ECC-L78 — subagent exemption | Selected subagent file operations'in first-touch challenge'dan bypass path'i. | Parent actually investigated this file proof değil. |
| ECC-L79 — persistence-failure no-deny | New marker store edilemezse endless-loop avoidance için allow/no objection. | Fail-closed security posture değil. |
| ECC-L80 — structured deny | exitCode 0 + permissionDecision:deny JSON result. | Process nonzero olmak zorunda değil. |
| ECC-L81 — internal dispatcher composition | Multiple Bash subhooks'ı normalize/aggregate eden ECC dispatcher. | Host sibling-hook merge ile aynı layer değil. |
| ECC-L82 — decision-loss composition | Earlier additionalContext output precedence nedeniyle GateGuard deny payload'ının final internal output'ta kaybolabilen conditional path. | Executed destructive-command bypass değil. |

## 7. Governance events

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-L83 — governance capture | Selected hook event'i classify edip stderr'e governance JSON emit etme optional path. | DB insertion/approval enforcement değil. |
| ECC-L84 — governance event | id/type/session/payload/resolution fields taşıyan record shape. | Authenticated decision değil. |
| ECC-L85 — secret_detected | Pattern match event label. | Verified credential/exposure değil. |
| ECC-L86 — approval_requested | Command classifier match event label. | Human actually contacted/waiting approval değil. |
| ECC-L87 — policy_violation | Sensitive path pattern event. | Policy engine adjudication değil. |
| ECC-L88 — security_finding | Selected elevated-operation pattern event. | Effect success/exploit finding değil. |
| ECC-L89 — hook_input_truncated | Caller-marked incomplete input event. | Missing content inspected/refused değil. |
| ECC-L90 — stderr event transport | Capture event'in process stderr JSON line representation'ı. | Host decision/additionalContext channel değil. |
| ECC-L91 — state-store governance record | Explicit API call ile SQL persisted governance row. | Hook output automatically ingested değil. |
| ECC-L92 — capture→store gap | Examined producer stderr ile state-store writer arasında demonstrated bridge bulunmaması. | Repository-wide absence theorem değil. |
| ECC-L93 — mutable governance upsert | Same ID conflict'te event/resolution/createdAt update path. | Append-only audit history değil. |
| ECC-L94 — pending governance | resolved_at IS NULL rows. | “Needs human approval” with verified identity değil. |
| ECC-L95 — governance resolution | resolvedAt/resolution fields populated state. | Resolution justified/authenticated proof değil. |
| ECC-L96 — pending count | DB'deki unresolved governance rows total. | Current session/repo-specific observation coverage değil. |
| ECC-L97 — governance attention | Pending count'un readiness/status attention aggregate'ına katkısı. | Actual prior effect blocked/resumed değil. |
| ECC-L98 — zero pending | This database'de unresolved row yok. | Capture enabled/complete/clean system proof değil. |

## 8. C3 closure refinements

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-L99 — location-derived instinct scope | Instinct'in effective project/global/personal scope'unun yalnız frontmatter field'dan değil, okunduğu directory/namespace'ten de türetilmesi. | scope: global yazmak tek başına global materialization değildir. |
| ECC-L100 — analyzed set vs archived set | Observer tail-sample ile analyze edilen observations kümesi ile success sonrası archive'a taşınan whole live file'ın aynı olmak zorunda olmaması. | Archived = analyzed/learned evidence guarantee değil. |
| ECC-L101 — current version label | Skill health/versioning yüzeyinde gösterilen current version number/snapshot-derived label. | O health window'daki bütün runs'ın aynı bytes/version ile üretildiği content identity değildir. |
| ECC-L102 — governance host-field adaptation | Capture hook'un session/phase/output bilgisini environment ve tool_output gibi selected fields'ten alması; current host contract'taki session_id/tool_response ile doğrudan eşleşmemesi. | Her installed host'ta fidelity failure olduğu kanıtlanmaz; adapter/environment bridge olabilir. |
| ECC-L103 — governance event correlation identity | Pre/post captures'ın random event IDs ile ayrı records üretebilmesi ve inspected object'te tool_use_id gibi exact operation correlation key bulunmaması. | Same command events'in kesin duplicate incident olduğu anlamına gelmez; higher-level reconciler olabilir. |
| ECC-L104 — governance data minimization | Event payload'ın matched secret/full command yerine category, restricted command name, fingerprint ve bounded path gibi dar representation taşıması. | Original tool input/output'un başka yerde yok edildiği, anonymity veya complete privacy guarantee değildir. |

## 9. C6b E04/E05 refinement source map

The new L105–L114 refinements are grounded in [Note09](../../../research/studies/ecc/notes/09-CONFIGURATION-PROTECTION-AND-ENFORCEMENT.md), [U06-A source ledger](../../../research/studies/ecc/evidence/U06-A-SOURCES.md), exact Node driver [probe.cjs](../../../research/studies/ecc/evidence/u06-a-config-probe/probe.cjs) with recovered [results.json.xz](../../../research/studies/ecc/evidence/u06-a-config-probe/results.json.xz), and the separate conversation-E05 [reconciliation README](../../../research/studies/ecc/evidence/u06-a-conversation-record/README.md) plus [original-evidence.tar.xz](../../../research/studies/ecc/evidence/u06-a-conversation-record/original-evidence.tar.xz). These are SOURCE/recorded local-evidence readings and C6 read-only recovery; they are not a new E05 campaign. L66's refinement uses the same joined source/evidence boundary.

## 9. C6b E04/E05 raw-evidence refinements

Aşağıdaki kayıtlar C3'ün önceki kaynak-aile aktarımını iptal etmez; C6b'de driver + ham sonuçların tam okunmasıyla source-local kullanım ayrımlarını tamamlar.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-L105 — mixed-purpose config exclusion | `pyproject.toml` linter-related içerik taşısa da fixed config-protection basename set'inin dışında bırakılan multipurpose path örneği. | Bütün multipurpose files veya bütün pyproject writes güvenli/authorized demek değil. |
| ECC-L106 — non-ENOENT stat refusal | Protected basename için lstat hatası ENOENT değilse source guard bunu absence saymak yerine blocking path'te tutar; E05 Node ENOTDIR karşılığı bunu sınar. | Her filesystem/permission/race hatasında fail-closed guarantee veya canlı host sonucu değil. |
| ECC-L107 — hook-ID exclusion | `ECC_DISABLED_HOOKS` gibi selector ile belirli hook ID'sinin profile uygun olsa bile runner admission'dan çıkarılması. | User authorization, enterprise policy veya effect acceptance değil. |
| ECC-L108 — hook-setting precedence | Explicit ECC environment selection'ın plugin/managed hook settings ve default'ların önüne geçebildiği effective configuration ordering. | Bu precedence'i seçen actor authenticated/authorized demek değil; host policy authority'si de değil. |
| ECC-L109 — invalid-profile fallback | Tanınmayan profile value'nun effective selection'da default/standard davranışına düşebilmesi; conversation E05 C15'te guard block'a gider. | Her malformed configuration aynı fallback'i kullanır veya güvenli kabul edilir demek değil. |
| ECC-L110 — runner-error no-objection | Parsed input truthy fakat target helper'ın beklemediği type (ör. non-string file_path) exception üretirse wrapper diagnostic yazıp zero/passthrough dönebilen path. | Valid host event bypass'ı veya effect authorization kanıtı değil; malformed-JSON L67'den ayrı failure mode. |
| ECC-L111 — truncation/admission interaction | Oversized input handling target classification'dan önce olabilir; admitted standard security hook truncated standing'i block ederken minimal profile'da aynı guard invoke edilmeden zero/empty-output path oluşabilir. | “Oversized = always block” veya “minimal = authorized write” sonucu çıkarılmaz. |
| ECC-L112 — content-insensitive protected-path refusal | Existing protected basename seçildikten sonra guard proposed content'in identical, weaker veya stronger olmasını semantic olarak ayırmadan refusal üretebilir. | Guard'ın kendisi configuration correctness veya policy intent oracle'ı değil. |
| ECC-L113 — case-folded basename selection | Config-protection protected-name matching'i basename lower-casing üzerinden yapar; source test family case-variant handling'i içerir. | Bu Concepts turunda case-insensitive filesystem behavior çalıştırılmadı. |
| ECC-L114 — dangling protected symlink presence | Protected basename'deki dangling symlink lstat ile present object olarak block path'ine girebilir. | Canonical target identity, alias protection veya symlink write semantics certificate'i değil. |

## 10. C3 non-collapse

- observation ≠ learning;
- learning ≠ promotion;
- promotion ≠ context use;
- context use ≠ task benefit;
- invocation success ≠ task success;
- proposal ≠ repair;
- rate difference ≠ causal efficacy;
- version snapshot ≠ validated version;
- guard decision ≠ host enforcement;
- marker ≠ justification;
- event classification ≠ persistence;
- persistence ≠ approval;
- approval label ≠ authenticated decision;
- pending count ≠ observation completeness;
- no objection ≠ authorization.

