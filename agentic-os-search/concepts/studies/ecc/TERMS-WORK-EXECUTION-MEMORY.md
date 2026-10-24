# ECC — Work, execution and memory terms

2026-09-20, **B6-T16-C2 / DURABLE-COMPLETE / C2-COMPLETE**. [TERMS.md](TERMS.md)'nin linked parçasıdır. Bu dosya U03–U04 source package kullanımını taşır.

## 1. Work/session records

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-W01 — work item | Local state-store'da id/source/title/status/priority/owner/session metadata taşıyan persisted work record. | Running agent/process değil. |
| ECC-W02 — work-item status | open/running/blocked/done vb. mutable local label. | Accepted execution outcome değil. |
| ECC-W03 — owner field | Work item üzerinde current assignment/source-authorship gibi farklı producers tarafından yazılabilen field. | Exclusive lease veya authenticated authority değil. |
| ECC-W04 — source owner | GitHub import'ta author login'den üretilen owner value. | Local execution assignee ile aynı semantic değil. |
| ECC-W05 — local claim | Helper'ın work item owner/status mutation'ı ile assignment yapması. | Concurrent exclusive execution lock değil. |
| ECC-W06 — explicit claim | ID ile chosen existing nonterminal card'ı başka owner'a atayabilen path. | Existing owner protection guarantee değil. |
| ECC-W07 — automatic pickup | Recent bounded list içinden unowned/nonterminal candidates'i priority ile seçme. | Global priority veya dependency-ready selection değil. |
| ECC-W08 — pickup window | listWorkItems(limit=100) gibi selection universe. | All work items değil. |
| ECC-W09 — lane move | Status'u another board lane value'ya değiştirme operation. | Lifecycle transition graph enforcement değil. |
| ECC-W10 — reopen | Done card'ın move ile open yapılabilmesi. | Prior completion invalidated by independent evidence demek değil. |
| ECC-W11 — task dependency metadata | C1 fixture'daki blockedBy gibi illustrative metadata. | ECC-defined dependency schema/enforcement olarak promote edilmez. |
| ECC-W12 — imported work item | Remote issue/PR'dan local state-store record üretme. | Remote object control/closure değil. |
| ECC-W13 — limited remote list | gh pr/issue list --limit ile bounded fetched set. | Complete remote corpus değil. |
| ECC-W14 — stale-close inference | Previously imported local item'in later bounded remote list'te görünmemesine dayanarak local closed yapılması. | Authoritative remote closure receipt değil. |
| ECC-W15 — sourceClosedAt | Local stale sweep'in generated close timestamp'i. | Remote authoritative closed-at event değil. |

## 2. Session records and views

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-W16 — session snapshot | Adapter/collector'dan normalized session/workers/intent/output/artifacts representation. | Live process itself değil. |
| ECC-W17 — canonical session | ecc.session.v1 normalized adapter representation. | SQLite flat session row ile aynı shape değil. |
| ECC-W18 — session row | State-store SQL'deki flat session persistence/query object. | Adapter fallback recording ile same storage contract değil. |
| ECC-W19 — default recording fallback | Recognized snapshot writer yoksa JSON latest/history recording path. | SQLite sessions table ingestion değil. |
| ECC-W20 — session history snapshot | Fallback latest + changed-snapshot history. | Complete runtime transcript veya continuation state değil. |
| ECC-W21 — active-session query | Stored state active/running/idle + ended_at null predicate. | Fresh liveness/process probe değil. |
| ECC-W22 — readiness summary | Failed runs/install warnings/governance/work attention aggregate. | Specific task prerequisites/owner/resources correct oracle değil. |
| ECC-W23 — attention exit code | status --exit-code ile attention durumunu process code 2'ye yansıtma. | Downstream enforced gate olduğu anlamına gelmez. |
| ECC-W24 — stored activity | Persisted row/snapshot status. | Live control/readiness değil. |
| ECC-W25 — worker health | Snapshot mapping'deki stale/degraded/healthy projection. | Semantic task quality değil. |

## 3. Execution/worktree orchestration

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-W26 — plan | Worker tasks/launcher/baseRef/paths/session config'ini taşıyan execution input. | Immutable full input manifest değil. |
| ECC-W27 — dry-run | Execution plan/effects preview üretip actual commands uygulamama mode. | Environment unchanged in every dependency sense değil. |
| ECC-W28 — write-only | Coordination/task/status/handoff artifacts materialize edip worker dispatch yapmayan mode. | Work executed değil. |
| ECC-W29 — execute mode | Worktrees/tmux/panes/commands effects path'i. | Worker readiness/completion guarantee değil. |
| ECC-W30 — worker | Per-task worktree/pane/provider command execution unit. | Independent agent authority guarantee değil. |
| ECC-W31 — worktree | Git branch-backed filesystem workspace. | Complete environment/process isolation değil. |
| ECC-W32 — seed overlay | Main checkout'taki selected current/dirty/untracked bytes'i worker worktree'ye overlay etme. | Base Git ref tek başına exact worker input identity değil. |
| ECC-W33 — coordination directory | task/status/handoff control artifacts'ının worktree dışı filesystem root'u. | Whole orchestration state transaction değil. |
| ECC-W34 — tmux session | Orchestrator/worker panes process container. | Task completion/readiness oracle değil. |
| ECC-W35 — pane | Worker command gönderilen tmux execution surface. | Agent/process semantic progress değil. |
| ECC-W36 — command submission | tmux send-keys ile launcher command gönderme. | Command succeeded/worker ready receipt değil. |
| ECC-W37 — launch success | Worktrees/session/panes/send-keys setup path'in exception vermeden bitmesi. | Worker work success veya accepted outcome değil. |
| ECC-W38 — createdState | Setup attempt'te created session/worktrees'i rollback için izleyen local state. | Valuable produced work/content listesi değil. |
| ECC-W39 — setup rollback | Caught provisioning failure sonrası created session/worktrees/branches/coordination dir cleanup. | Prior accepted/useful work preservation veya full transaction rollback değil. |
| ECC-W40 — replaceExisting | Existing session/worktree names'i cleanup edip replacement kurmaya hazırlama path'i. | Recovery/restore değil. |
| ECC-W41 — recovery vs replacement | Önceki runtime/work state'i restore etme ile delete/recreate replacement ayrımı. | Same operation değil. |

## 4. Worker status, handoff and acceptance

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-W42 — worker status file | running/completed/failed plus branch/worktree timestamps. | Task correctness/acceptance değil. |
| ECC-W43 — handoff file | Worker final message/report content + metadata representation. | Independent verification değil. |
| ECC-W44 — process completion | Provider wrapper exit code/normal termination. | Task semantic completion değil. |
| ECC-W45 — completed status | Wrapper exit 0 sonrası written lifecycle label. | Validation success veya finished task proof değil. |
| ECC-W46 — failed status | Missing task/nonzero provider path'te written label. | All partial evidence retained guarantee değil. |
| ECC-W47 — raw handoff | Full worker-written final text embedded in artifact. | Parsed structured fields değil. |
| ECC-W48 — parsed handoff | Collector'ın Summary/Validation/Remaining Risks exact heading/bullet grammar'ından çıkardığı normalized arrays. | Raw text'in lossless semantic view'i değil. |
| ECC-W49 — representation loss | Human-readable alternate formatting raw artifact'ta kalırken parsed arrays boş kalabilmesi. | Model output wrong demek değil. |
| ECC-W50 — validation report text | Worker final response'taki claimed verification content. | Tests independently executed/passed receipt değil. |
| ECC-W51 — remaining risks | Handoff parser'ın recognized bullets'tan çıkardığı risk listesi. | Empty list = no risks established değil. |
| ECC-W52 — generic failure handoff | Nonzero provider exit'te partial final output yerine generic failure representation. | All diagnostics lost değil; stderr ayrı olabilir. |
| ECC-W53 — observation liveness | tmux pane list + worker dirs/status timestamps üzerinden current activity view. | Work readiness/progress/semantic success değil. |
| ECC-W54 — sessionActive | At least one pane returned predicate. | Agent working/on task proof değil. |
| ECC-W55 — stale worker heuristic | Timestamp-based worker health classification. | Actual stalled process measurement değil. |

## 5. Memory Vault

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-W56 — Memory Vault | Local Markdown-based cross-harness context-transfer store. | SQLite work/session store veya automatic behavioral memory değil. |
| ECC-W57 — memory record | Frontmatter + body carrying kind/scope/status/trust/source/targets etc. | Truth/authority certificate değil. |
| ECC-W58 — memory kind | context/decision/fact/handoff/lesson/note/preference/runbook content class. | Factuality/decision acceptance değil. |
| ECC-W59 — memory trust | Pinned v1 path'te unreviewed standing. | Two-state reviewed/unreviewed ladder değil. |
| ECC-W60 — memory status | active/rejected/superseded recall eligibility/history standing. | Trust veya truth değil. |
| ECC-W61 — active record | Ordinary search eligibility state. | Current external truth guarantee değil. |
| ECC-W62 — rejected/superseded record | Search'ten excluded historical record. | Direct-ID read inaccessible olmak zorunda değil. |
| ECC-W63 — memory scope | project/team/user filesystem/root scope. | Authenticated principal identity değil. |
| ECC-W64 — target harness | Intended recipient/routing metadata. | Recipient acknowledged/accepted content değil. |
| ECC-W65 — sourceHarness | Producer attribution label; MCP server can stamp configured identity. | Authenticated human/process identity değil. |
| ECC-W66 — create-only write | Destination overwrite etmeyen exclusive publication behavior. | Immutable journal against all filesystem actors değil. |
| ECC-W67 — lexical search | Title/tags/metadata/body scoring + updated-time tie behavior. | Semantic relevance/current truth oracle değil. |
| ECC-W68 — bounded scan | Entry/byte/depth limits + diagnostics. | Complete corpus guarantee değil. |
| ECC-W69 — partial search | Valid matches ile invalid/truncated diagnostics coexist edebilmesi. | Plain CLI bunu görünür göstermek zorunda değil. |
| ECC-W70 — incomplete direct read | Invalid/truncated selected scope varsa absence/uniqueness claim'i reddeden path. | Search availability ile aynı policy değil. |
| ECC-W71 — diagnostic omission in plain CLI | Structured search result'taki invalid/truncated diagnostics'in terminal view'da görünmemesi. | Structured/MCP view'da da kayıp demek değil. |
| ECC-W72 — direct historical read | Rejected/superseded record'ı ID ile retrieve edebilme. | Ordinary recall eligibility değil. |
| ECC-W73 — supersession link | links field ile record IDs arasında relation. | Automatic old-record status mutation değil. |
| ECC-W74 — governed artifact | Vault dışında human-reviewed/accepted knowledge target'ı. | Vault record itself değil. |
| ECC-W75 — MCP memory surface | save/search/read/doctor tools with server-stamped source/scope controls. | Human authentication/review workflow değil. |
| ECC-W76 — operator CLI surface | Caller-selected source/target options ve full structured JSON/plain views. | MCP caller policy ile aynı authority değil. |
| ECC-W77 — evidence verifier example | Example envelope'i separate host-owned catalog/digest/context against checking. | Core save/recall automatic safeguard değil. |
| ECC-W78 — doctor | Vault structural/scan/link/duplicate health report. | Truth/task readiness certificate değil. |

## 6. C2 closure refinements

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-W79 — inspection persistence side effect | Session inspection/default adapter path'in explicit --write olmasa bile fallback latest/history recording yazabilmesi. | Inspection = pure read-only demek değil; SQLite session ingestion da değil. |
| ECC-W80 — worker input identity | baseRef + seed overlay bytes + rendered launcher/task/config birlikte actual worker input'u belirler. | Base Git ref tek başına immutable execution identity değildir. |
| ECC-W81 — coordination-dir preservation vs content preservation | Pre-existing coordination directory kaldırılmasa bile materializePlan içindeki task/status/handoff files yeniden yazılabilir. | Directory survived = previous artifacts survived unchanged değil. |
| ECC-W82 — rollback resource scope vs produced value | Setup rollback attempt-created worktrees/session/branches'i temizleyebilir; worker'a command gittiyse yeni useful output oluşmuş olabilir. | Created-resource cleanup = accepted/valuable work preservation değil. |
| ECC-W83 — worker enumeration set | Collector, task/status/handoff file bulunan directories'i worker olarak discover eder. | Current plan'ın expected worker set'iyle reconciliation guarantee değil. |
| ECC-W84 — observation-failure collapse | tmux missing/nonzero list-panes sonucu empty pane list'e dönüşebilir. | Empty pane list = definitely no session/workers değil. |
| ECC-W85 — status timestamp vs heartbeat | Wrapper status Updated yalnız selected lifecycle transitions'ta yazılır. | Periodic liveness heartbeat değil; stale heuristic long-running worker'ı yanlış yorumlayabilir. |
| ECC-W86 — session locator identity | Launcher slug/session/root üretimi ile collector plan/name-only lookup rules farklı adresleme yolları taşıyabilir. | Benzer session name/path = same coordination artifacts guarantee değil. |
| ECC-W87 — user-scope two-stage opt-in | MCP user memory için server-level opt-in + per-call explicit user-scope request gerekir. | Opt-in user scope'u default recall'a eklemez veya authenticated user identity sağlamaz. |
| ECC-W88 — memory read status projection | Structured/JSON read record status'u taşırken plain terminal read status'u göstermeyebilir. | Status core object'ta yok demek değil; view-level omission. |
| ECC-W89 — doctor ok vs process exit | Doctor structural health result'ında ok=false mümkünken ordinary CLI success path issue-specific nonzero exit üretmeyebilir. | Process exit 0 = healthy vault değil. |

## 7. C2 non-collapse

- card/status/owner ≠ running worker;
- claim ≠ exclusive lease;
- session snapshot ≠ SQLite session row;
- stored running ≠ live running;
- worktree provisioned ≠ worker ready;
- command sent ≠ provider completed;
- provider completed ≠ task accepted;
- raw handoff ≠ parsed handoff;
- report text ≠ independent validation;
- memory stored ≠ reviewed;
- reviewed/governed artifact ≠ model consumed;
- memory active ≠ current truth;
- target harness label ≠ recipient authority.

