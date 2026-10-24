# Hermes Agent — Runtime, tools and delegation terms

2026-09-20, **B6-T15-H5 / DURABLE TRANSFER COMPLETE / PACKAGE-COMPLETE**. TERMS.md'nin bağlı parçasıdır. Kaynak: notes 26–28, U11–U13 evidence ve related source-study records.

## 1. Runtime selection and execution ownership

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-R01 — requested provider | Config/user/job tarafından talep edilen provider identity. | Resolved/effective runtime değil. |
| HA-R02 — requested model | Config/user/job tarafından talep edilen model identity. | Actual native/effective model receipt değil. |
| HA-R03 — runtime resolution | Credentials/base-url/provider config/pool/registry üzerinden effective runtime seçme. | Actual request sent değil. |
| HA-R04 — resolved provider | Resolver'ın seçtiği provider identity. | Client/request/backend owner ile aynı değil. |
| HA-R05 — api_mode | chat-completions, responses, codex_app_server gibi transport/whole-turn execution mode selector. | Provider adıyla aynı değil. |
| HA-R06 — base_url | Model transport endpoint identity. | Provider label veya auth identity ile aynı değil. |
| HA-R07 — runtime source | Resolver result'in hangi credential/config path'ten geldiğini açıklayan provenance field. | Request success değil. |
| HA-R08 — effective runtime | Provider/model/api_mode/base_url/client/config'in current execution için resolved composition'ı. | Turn baştan sona değişmez guarantee değil. |
| HA-R09 — client construction | SDK/client object'in effective config ile oluşturulması. | Main model request'in o client üzerinden gerçekleştiği receipt değil. |
| HA-R10 — transport owner | Actual model request send/stream lifecycle'ını yöneten runtime component. | Whole turn owner olmak zorunda değil. |
| HA-R11 — whole-turn backend owner | Model-tool loop/history/compaction/tool surface'in tamamını veya büyük kısmını sahiplenen backend. | Ordinary transport helper'dan farklı olabilir. |
| HA-R12 — ordinary API transport | HERMES conversation loop içindeki Chat Completions/Responses/Anthropic/etc. request path. | Native whole-turn runtime değil. |
| HA-R13 — native app-server runtime | HERMES outer turn facade içinde early branch ile entire inner turn'ü Codex app-server session'a veren path. | All HERMES admission skipped demek değil. |
| HA-R14 — runtime snapshot | Primary provider/model/api/client/request/compressor state'in restoration/fallback için captured formu. | Actual request history değil. |
| HA-R15 — fallback runtime | Ordinary path failure sonrası alternate model/provider/runtime'a geçiş. | Merely changing model string değil. |
| HA-R16 — runtime retirement | Native/runtime path'in future reuse için disabled/retired hale getirilmesi. | Current work automatically replayed elsewhere değil. |

## 2. Tool visibility, admission and execution

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-R17 — tool registry | ToolEntry/name/schema/handler/scope/check_fn records taşıyan registry. | Tool current agent için visible/allowed demek değil. |
| HA-R18 — ToolEntry | Schema + handler + scope/availability metadata taşıyan registered tool object. | Actual call/effect değil. |
| HA-R19 — tool definition | Model request'e exposed tool schema/name description. | Handler permission/effect receipt değil. |
| HA-R20 — tool visibility | Enabled/disabled toolsets, registry scope, availability, Tool Search selection sonrası modelin görebildiği tools. | Call authority ile aynı değil. |
| HA-R21 — tool availability | check_fn/runtime probe'a göre tool'un usable görünmesi. | Exact current execution success receipt değil. |
| HA-R22 — tool proposal | Modelin name + call ID + arguments ile tool invocation istemesi. | Admitted call/effect değil. |
| HA-R23 — tool-call validation | Name, duplicate ID, JSON/truncation gibi generic validation stage. | Tool-specific semantics/schema correctness'in tamamı değil. |
| HA-R24 — valid tool name | Current agent/session'ın accepted tool-name setinde bulunma. | Handler policy passed demek değil. |
| HA-R25 — deferred tool / Tool Search | Concrete schema'yı initial prompt'tan çıkarıp bridge üzerinden on-demand resolve etme. | Underlying registry'nin tümüne free access değil. |
| HA-R26 — tool_call bridge | Deferred tool name/schema resolution için intermediate call surface. | Underlying effect authority değil. |
| HA-R27 — execution middleware | Dispatch öncesi request/execution transformations/control callbacks. | All failures fail-closed değil. |
| HA-R28 — pre-hook | Tool args'i değiştirebilen veya policy signal üreten plugin hook. | Hook exception bazı paths'te fail-open olabilir. |
| HA-R29 — final arguments | Middleware/pre-hook sonrası actual policy/handler'a giden arguments. | Initial model proposal ile aynı olmak zorunda değil. |
| HA-R30 — guardrail before_call | Final arguments üzerinde allow/block/approval logic. | All tool paths aynı guard contract'i kullanıyor demek değil. |
| HA-R31 — authorized dispatch | Scoped/middleware/guardrail checks sonrası handler çağrısına izin verilmesi. | Effect succeeded değil. |
| HA-R32 — handler | Actual tool implementation callable. | Result persistence veya external outcome değil. |
| HA-R33 — tool effect | Handler/underlying OS/API/file operation'ın actual side effect'i. | Handler returned success string ile aynı değil. |
| HA-R34 — tool result | Handler outcome'un normalize edilmiş semantic response'u. | Persisted message/UI view ile aynı olmayabilir. |
| HA-R35 — tool-result persistence | Tool result message'ın SessionDB/history'ye flush edilmesi. | Physical effect rollback değildir. |
| HA-R36 — tool.completed event | Result persistence sonrası emitted completion/view event. | post_tool_call hook ile aynı timing değil. |
| HA-R37 — effect_disposition=unknown | Timeout/interrupt sonrası actual effect terminal standing'i bilinmiyorsa kullanılan result qualification. | “No effect” değil. |

## 3. Proposal, effect and persistence boundaries

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-R38 — pre-effect proposal persistence | Tool-call proposal block'un effect başlamadan history/DB'ye flush edilmeye çalışılması. | Final args/effect receipt değil. |
| HA-R39 — proposal flush gate | Explicit persistence failure'da handler execution'a geçmeme control. | No-DB/None paths aynı değil. |
| HA-R40 — result flush failure | Handler effect sonrası result persistence başarısızlığı. | Effect geri alınmış demek değil. |
| HA-R41 — incremental persistence failure | Result/history flush sorunu nedeniyle later segments/model request'in durdurulabildiği turn state. | Already-realized sibling effects'i rollback etmez. |
| HA-R42 — dispatch-once local guard | Same invocation callback'in accidental second dispatch'ini engelleyen local state. | Restart/duplicate call ID/external exactly-once guarantee değil. |
| HA-R43 — batch plan | Tool calls'ın parallel-safe/sequential segments'e ayrılması. | Policy rewrite sonrası same resource reservations guarantee değil. |
| HA-R44 — path overlap | File operations'ın target path overlap'ına göre concurrency barrier oluşturma. | Whole OS effects serializable guarantee değil. |
| HA-R45 — original-order result append | Parallel completion farklı zamanlarda olsa da tool results'ı original call order'da history'ye ekleme. | Physical effects original order'da gerçekleşti demek değil. |
| HA-R46 — human approval wait | Batch execution timeout/accounting'te intentionally user-decision waiting olarak ayrı time class. | Arbitrary hook/lock delay ile aynı değil. |

## 4. Delegation construction and authority

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-R47 — delegate_task | Ordinary parent-bound HERMES path'te child agent/work spawn/control tool family. | Native stateless MCP surface ile aynı değil. |
| HA-R48 — parent_agent binding | Delegation call'ın current parent agent/session/context authority'sine explicit bağlanması. | Tool registry entry alone değil. |
| HA-R49 — spawn admission | Action/depth/pause/config/task/schema/runtime checks sonrası new child creation approval. | Control action list/steer/stop ile aynı path değil. |
| HA-R50 — spawn depth | Parent-child delegation nesting depth. | Capability strength/authority ranking değil. |
| HA-R51 — max_spawn_depth | Configured nesting admission bound. | Total number of children/global cost cap değil. |
| HA-R52 — child role | Depth + orchestrator_enabled gibi trusted config ile effective role. | Model-facing legacy role string ile aynı olmayabilir. |
| HA-R53 — role-granted delegation | Effective orchestrator child için delegation capability'nin policy tarafından yeniden eklenebilmesi. | Model self-escalation kanıtı değil. |
| HA-R54 — child toolset | Parent selections/disabled sets/role policy sonrası child'a exposed tools. | Always strict subset theorem değil. |
| HA-R55 — fresh child conversation | Parent conversation_history replay edilmeden new AIAgent/run_conversation ile başlayan child context. | Zero inherited information veya environment isolation değil. |
| HA-R56 — child prefill | Parent-selected setup/system/context information'ın child prompt'a ayrıca aktarılması. | Parent full transcript değil. |
| HA-R57 — child task ID | Child tool/workspace scope identity. | Filesystem/container/session isolation receipt değil. |
| HA-R58 — child session ID | Child conversation identity. | Child task ID veya delegation unit ID değil. |
| HA-R59 — parent session ID | Delegation origin/ownership lineage için parent conversation identity. | Same Python object requirement değil. |
| HA-R60 — delegation ID | One delegation call/group result lifecycle identity. | Child ID veya task index ile aynı değil. |
| HA-R61 — unit | Detached/sync grouping içinde result-delivery/finalization unit. | Work dependency object değil. |
| HA-R62 — group | Multiple child results'i birlikte return/finalize etme grouping semantics. | Children birbirine dependency taşıyor demek değil. |
| HA-R63 — async slot | Detached units'in capacity ownership/accounting slot'u. | Child count veya global concurrency count değil. |
| HA-R64 — worktree isolation | Optional local/git child workspace separation. | Fresh context'in default consequence'u değil. |
| HA-R65 — shared workspace fallback | Worktree kurulamadığında child'ın parent environment/filesystem'i paylaşabilmesi. | New session = separate filesystem değil. |
| HA-R66 — child runtime pin | Model/provider/base_url route'un child için parent inheritance veya explicit config ile resolve edilmesi. | Actual native model request receipt değil. |
| HA-R67 — child SessionDB ownership | Parent db_path/provided registry üzerinden acquired child persistence resource. | Dedicated physical SQLite connection guarantee değil. |

## 5. Delegation execution, result and lifecycle

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-R68 — synchronous delegation | Parent tool call child completion'ını bekleyip result JSON döndürür. | Detached completion semantics değil. |
| HA-R69 — detached delegation | Child execution parent direct wait ownership'undan çıkarılıp async registry/ledger ile later completion üretir. | Fire-and-forget without ownership değil. |
| HA-R70 — async delivery support | Origin host/session'ın detached child result'i later parent/user context'e taşıyabilme capability standing'i. | Result actually consumed değil. |
| HA-R71 — self-wake | Some API/session origins'te detached completion'ın parent-like session'ı wake edebilmesi. | Universal host behavior değil. |
| HA-R72 — sync fallback | Detached return path unavailable/rejected ise parent wait/result path'e dönme. | Child not created demek değil; bazı phases'de objects already exist. |
| HA-R73 — child heartbeat | Child iteration/tool/last-activity change'iyle liveness/progress signal. | Semantic progress oracle değil. |
| HA-R74 — stalled child | Async monitor progress marker donunca synthesized terminal/interrupt path. | Physical worker definitely stopped değil. |
| HA-R75 — logical terminal | Async/delegation result ledger'ın one finalization winner ile terminal result seçmesi. | OS thread/process/effects ceased guarantee değil. |
| HA-R76 — physical close | Child agent/session/resource teardown/worker completion. | Logical terminal ile aynı an değil. |
| HA-R77 — steering | Parent/user'ın live child'a correction/instruction enqueue etmesi. | Applied before child terminal guarantee değil. |
| HA-R78 — missed_steer | Steering accepted path ile child consume boundary arasındaki race sonucu correction uygulanamamış standing. | Request queued == applied genellemesini bozar. |
| HA-R79 — stop / interrupt_requested | Child cancellation intent/request. | External side effects stopped receipt değil. |
| HA-R80 — child result status | completed/failed/interrupted/stalled vb. result classification. | Task/user goal acceptance değil. |
| HA-R81 — completed + max_iterations + truncated | Usable summary varsa status completed while budget-exhausted/truncated metadata coexist edebilmesi. | Full task complete demek değil. |
| HA-R82 — output schema validation | Child final text'in requested JSON/shape'e uyması. | Semantic correctness/effect correctness değil. |
| HA-R83 — correction turn | Schema invalid olduğunda bounded extra child turn ile shape correction denemesi. | Original work quality repair guarantee değil. |
| HA-R84 — child summary | Parent'a returned bounded textual result. | Full child transcript veya independently verified account değil. |
| HA-R85 — summary spill | Long child result'in trimmed view + full text file pointer ile taşınması. | Parent model'in spill file'ı read ettiği guarantee değil. |
| HA-R86 — self-report | Child summary/schema result'in child tarafından üretilmiş claim olması. | External effect için independent receipt değil. |
| HA-R87 — tool trace / exit metadata | Summary yanında selected tool/token/exit/worktree/log metadata. | Full audit trail değil. |

## 6. Async completion and parent re-entry

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-R88 — durable completion record | Detached unit terminal result'in persistent async ledger row'u. | Parent model saw it değil. |
| HA-R89 — completion queue publication | Persisted result'in shared/in-memory host queue'ya sunulması. | Current owner claimed/admitted değil. |
| HA-R90 — delivery claim | Competing consumers arasında completion event'i consume etme hakkı. | Parent turn started değil. |
| HA-R91 — delivery token | Ack/release/drop operation'larını exact claim'e bağlayan identity. | Interim notice empty token final claim'i consume etmemeli. |
| HA-R92 — delivery ack | Consumer'ın event'i handled kabul edip persistent delivered update istemesi. | Model turn completed veya result used değil. |
| HA-R93 — delivery release | Failed/declined consumer claim'i tekrar eligible bırakma. | Result lost değil. |
| HA-R94 — retry/drop | Claim expiry/retry exhaustion sonrası event lifecycle transitions. | Child execution status ile aynı değil. |
| HA-R95 — parent re-entry | Completion information'ın current parent session history üzerinden new turn'e kabul edilmesi. | Queue publication/ack alone değil. |
| HA-R96 — ack without schedule | U13 bounded selected diagnostic'te lower submit False/schedule=0 iken upper caller'ın ack request etmesi. | Product-wide data loss kanıtı değil. |
| HA-R97 — claim-with-local-slot residue | Durable claim None selected seam'de local running slot'un release edilmeyişi. | Whole-product deadlock kanıtı değil. |
| HA-R98 — exception compensation | Submit exception path'in claim release + local running cleanup yapması. | No-exception False path ile aynı değil. |
| HA-R99 — scheduling refusal | Active-session/closing/replacement conditions altında prompt turn start'ın False dönmesi. | Exception veya successful schedule değil. |
| HA-R100 — interim empty token | Early child failure notice'ın durable final ack callback'ini çağırmamasını sağlayan delivery distinction. | Final completion delivery ile aynı değil. |

## 7. Runtime/tools/delegation non-collapse

Hermes current research şu zinciri ayrı tutar:

**requested model/provider → resolved runtime → client/transport → actual turn owner; tool registry → visible definition → model proposal → validation/policy → handler → effect → result → result persistence; delegation request → child construction → child authority/context/workspace → execution → logical terminal → durable completion → claim/ack → parent re-entry.**

Özellikle:
- tool visible != authorized/effectful;
- proposal persisted != effect happened;
- effect happened != result persisted;
- new child conversation != isolated environment;
- group != dependency;
- status=completed != task accepted;
- stop requested != physical cessation;
- completion persisted != parent used it;
- fresh context != independent verifier;
- same AIAgent facade != same backend/history/tool owner.


## 8. Review policy, middleware and gateway admission refinements

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-R101 — advertised / valid tool-name set | Agent tool definitions/schema'lardan türetilen name set; generic turn validation tool adını bununla tanır. | Review-specific dispatch authorization değildir. |
| HA-R102 — review tool whitelist | Background review için memory/skill/read/search/extras gibi narrower allowed dispatch set'i. | Parent advertised set ile inspected path'te aynı object değil. |
| HA-R103 — thread-local whitelist | Review thread'inde plugin policy consumer'ın okuduğu per-thread dispatch policy state. | ContextVars propagation ile otomatik worker transfer guarantee değil. |
| HA-R104 — worker policy binding | Worker execution thread'inde narrower whitelist'i explicit olarak yeniden kurma intervention/requirement. | U01-D2 bounded diagnostic; whole product enforcement theorem değil. |
| HA-R105 — name acceptance vs policy admission | Tool name validator'ın OK demesi ile later review whitelist/guardrail/lifecycle/approval gates'in allow etmesinin ayrı stages olması. | “Valid” = “authorized” değil. |
| HA-R106 — middleware next_call | Execution middleware callback'in downstream chain/handler'a tek-use continuation capability'si. | Handler effect receipt değil. |
| HA-R107 — middleware short-circuit | Callback'in next_call yapmadan own result dönüp downstream handler effect'ini sıfırda tutması. | Generic policy semantics callback role'a bağlı. |
| HA-R108 — middleware self-failure before next | Ordinary Exception türündeki callback failure'ın warning ile skip edilip downstream execution'ın devam edebilmesi. | Mandatory authorization callback için fail-closed guarantee değil; BaseException branch farklı. |
| HA-R109 — downstream exception | Handler/inner next failure'ın original exception olarak outer'a taşınması. | Middleware's own post-next failure ile aynı değil. |
| HA-R110 — saved downstream result | next_call başarıyla result/effect ürettikten sonra outer middleware hata verse bile first successful result'in korunabilmesi. | Actual external effect atomicity/rollback guarantee değil. |
| HA-R111 — duplicate next-call guard | Aynı middleware callback'in downstream execution'ı ikinci kez çağırmasının local single-use guard ile engellenmesi. | Exception mutlaka top-level'e çıkar demek değil; observed wrapper warning + first result preserve edebilir. |
| HA-R112 — ingress authorization | Normal external gateway message'ın source/user admission kontrolü. | Slash command authorization ile aynı gate değil. |
| HA-R113 — slash-command access | Admitted external user'ın canonical command family'yi çalıştırıp çalıştıramayacağına dair DM/group policy. | Pending subcommand/record bazında fine-grained permission değil. |
| HA-R114 — canonical command name | Access policy'nin memory/skills/help gibi normalized command family identifier'ı. | Literal “memory approve” policy unit'i actual caller path'te değil. |
| HA-R115 — command-family granularity | memory izninin builtin policy düzeyinde pending/list/approve/mode gibi subactions'a tek tek ayrılmaması. | Optional hooks/other layers daha dar control ekleyebilir. |
| HA-R116 — idle command | /memory ve /skills gibi normal no-active-turn command dispatch table'ında yer alan command family. | Mid-run plain handler değil. |
| HA-R117 — busy-session command refusal | Same active session running iken normal memory/skills command'ın mid-turn dispatch'e alınmaması. | Same profile/process üzerindeki bütün writers'a global lock değil. |
| HA-R118 — transport profile vs runtime profile | Message'i admitting adapter/authorization scope'u ile routed execution/data home'unun farklı semantic roles olması. | Profile label tek başına auth object değil. |
| HA-R119 — live-store caller | CLI'nın mevcut agent MemoryStore varsa common pending apply'e onu vermesi. | Disk/frozen prompt freshness guarantee değil. |
| HA-R120 — fresh-store caller | Gateway memory approval handler'ın each call load_on_disk_store ile fresh store vermesi. | Cached resident agent memory/prompt automatically refreshed demek değil. |
