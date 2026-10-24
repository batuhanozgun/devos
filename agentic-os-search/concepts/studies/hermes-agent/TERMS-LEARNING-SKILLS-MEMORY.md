# Hermes Agent — Learning, skills and memory terms

2026-09-20, **B6-T15-H5 / DURABLE TRANSFER COMPLETE / PACKAGE-COMPLETE**. TERMS.md'nin bağlı parçasıdır. Kaynak: notes 02–15/30, synthesis/01, U15 evidence ve önceki published learning/curator records.

## 1. Learning and proposal lifecycle

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-L01 — learning candidate | Background review, memory observation veya current interaction'dan çıkan henüz admitted olmayan reusable lesson. | Applied system change değil. |
| HA-L02 — proposal | Skill/memory/procedure change önerisini approval için durable/stateful form'a getiren object. | Mutation değil. |
| HA-L03 — pending proposal | Henüz approve/reject edilmemiş proposal state. | User approval veya recoverability guarantee değil. |
| HA-L04 — approval | Proposal'ın belirli mutation'a geçmesine human/user authority veren transition. | File mutation'ın gerçekleştiği receipt değil. |
| HA-L05 — rejection | Proposal'ın mutation'a admission almaması. | Future re-proposal'ı evrensel olarak yasaklamaz. |
| HA-L06 — review | Candidate/proposal'ın content, scope, safety veya usefulness açısından değerlendirilmesi. | Independent verifier garantisi değil. |
| HA-L07 — curator | Skill/library maintenance kararlarını planlayan/uygulayan specialized mechanism/role family. | Historical author veya universal owner değil. |
| HA-L08 — background learning | Foreground answer'dan ayrı, conversation/artifact evidence'tan reusable skill/memory candidate üretme path'i. | Foreground task success ile aynı değil. |
| HA-L09 — foreground learning | Current interaction içinde explicit correction/user signal'dan immediate reusable change candidate üretme. | Background proposal lifecycle ile aynı path olmak zorunda değil. |
| HA-L10 — learning admission | Candidate lesson'ın persistent memory/skill mutation'a dönüşmesi için gerekli review/approval/policy transition. | Mere detection değil. |
| HA-L11 — learning efficacy | Persisted learning/skill change'in future task quality'sini gerçekten iyileştirmesi. | **Q60 NOT RESEARCHED**; current package bunu establish etmez. |

## 2. Skill identity and source/local state

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-L12 — skill | SKILL.md/frontmatter/supporting files ile model-visible reusable procedure/capability package. | File/directory, loaded context, runtime capability ve task success aynı şey değil. |
| HA-L13 — bundled skill | Hermes dağıtım source tree'sinden gelen skill package. | User-created/local/external skill ile aynı origin değil. |
| HA-L14 — local skill copy | Active profile skills directory'sindeki current filesystem package. | Bundled source ile byte-equal olmak zorunda değil. |
| HA-L15 — skill name | Frontmatter veya directory-derived logical identifier. | Physical path veya unique loadable target ile aynı değil. |
| HA-L16 — canonical path | Bundled source category/path structure'ına göre intended target location. | Same-name alternate copies'i ortadan kaldırmaz. |
| HA-L17 — origin hash | Bundled manifest'te skill name için stored previous distributed-content digest. | Historical authorship, semantic truth veya security proof değil. |
| HA-L18 — bundled manifest | Name → origin baseline tracking store. | Revision history veya current loadability registry değil. |
| HA-L19 — local content hash | Current local skill directory content digest. | User intent veya origin'i tek başına açıklamaz. |
| HA-L20 — bundled current hash | Current pinned/distributed skill source digest. | Local active content'in bunu kullandığı receipt değil. |
| HA-L21 — pristine / origin-matching local | Local hash previous origin baseline'a eşit olduğu için updater'ın owned/unmodified sayabildiği state. | Historical human authorship değil. |
| HA-L22 — user-modified | Local hash previous origin baseline'dan farklı olduğu için automatic overwrite'dan korunan state. | Change'in user tarafından bilinçli/kaliteli yapıldığı anlamına gelmez. |
| HA-L23 — user-deleted | Manifest'te skill bilinirken active target bulunmaması sonrası recovery yollarından sonra deletion-protect interpretation. | Kimin/neden sildiği bilinmez. |
| HA-L24 — upstream removed | Bundled catalog/source'ta skill'in artık bulunmaması. | Local library'den otomatik silindi demek değil. |
| HA-L25 — reintroduced skill | Daha önce upstream removal/manifest cleanup sonrası aynı logical skill'in tekrar bundled source'a dönmesi. | Prior user deletion tombstone'u kalıcıysa engellenir diye garanti yok. |
| HA-L26 — v1 manifest migration baseline | Legacy name-only manifest'ten current local hash'i first observed origin olarak kaydetme. | O local content'in gerçekten last distributed content olduğu kanıtlanmaz. |
| HA-L27 — essential skill | Opt-out/suppression politikalarında özel olarak korunabilen builtin skill class. | Opt-out = empty library olmadığını gösterir. |
| HA-L28 — opt-out | Bundled skill seeding/sync'in normal nonessential kısmını kapatma preference/state. | Existing skills'i otomatik silmek veya essentials'ı yok etmek değil. |
| HA-L29 — external skill source | Local active library dışında configured external directory/source. | Hub/org/bundled origin ile aynı governance değil. |
| HA-L30 — official optional skill | Official source'tan optional olarak restore/backfill edilebilen skill class. | Backfilled provenance yeni scan yapıldığı anlamına gelmez. |

## 3. Sync, archive and curation records

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-L31 — skill sync | Bundled source, local skill, manifest baseline, suppression/external state üzerinden update/preserve/move decisions üreten process. | One atomic transaction değil. |
| HA-L32 — re-baseline | Current local/bundled content'i future sync comparison için origin baseline olarak kaydetme. | Content quality veya authorship admission değil. |
| HA-L33 — orphan/rename recovery | Missing target'ı backup/alternate same-name copy'den canonical path'e recover etme. | User-deleted intent'i her zaman override etmez. |
| HA-L34 — suppression | Curator-pruned builtin'in future bundled reseeding'ini engelleyen sidecar policy. | Generic loader deny veya current file absence değil. |
| HA-L35 — .curator_suppressed | Suppressed builtins list/store. | Skill usage/archive state ile aynı değil. |
| HA-L36 — archive | Active skill package'i .archive altında active scan'den çıkarmak için relocate etme. | JSON state-only transition değil. |
| HA-L37 — restore | Archived package'i yeniden active tree'ye taşımaya çalışma. | Original category/whole system state restore değil. |
| HA-L38 — .usage.json | Skill view/use/edit counters, curator-management opt-in ve state/pin gibi sidecar record. | Task success veya historical authorship değil. |
| HA-L39 — created_by:agent | Curator-management opt-in için consumed field. | LLM historical author proof değil. |
| HA-L40 — adopt skill | Existing local skill'i curator-managed lifecycle'a explicit kabul etme. | File creation history'sini değiştirmez. |
| HA-L41 — usage/view counter | Skill content'in load/view path'tan geçtiğine dair operational telemetry. | Procedure followed veya task improved receipt değil. |
| HA-L42 — curator ledger | Curator-hooked mutation için before/after files ve actor record'u taşıyan JSONL + content blobs. | Universal filesystem mutation ledger değil. |
| HA-L43 — ledger actor | Mutation path'in kim adına/which caller under işlendiğine dair operational attribution. | Independent human identity proof değil. |
| HA-L44 — ledger entry rollback | One recorded mutation'ın entry files'ını before state'e döndürme. | Usage/suppression/cron/library whole transaction rollback değil. |
| HA-L45 — whole-tree snapshot | Skills tree + selected sidecars/manifest/archive/cron-copy gibi broader backup. | Whole Hermes home/system time-travel değil. |
| HA-L46 — safety snapshot | Rollback öncesi current state'i kaybetmeme amacıyla mandatory backup record. | Restore success veya all sidecars included guarantee değil. |
| HA-L47 — .hub/lock.json | Hub/official install/ownership/provenance operational metadata. | Every content was freshly scanned proof değil. |
| HA-L48 — provenance backfill | Existing content official optional source'la eşleşirse operational origin/trust record'ı yeniden kurma. | Historical download origin'i kanıtlamaz. |

## 4. Discovery, index and loading

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-L49 — skill discovery | Project/local/external/org/etc. roots'tan candidate skill packages bulma. | Unique loadable skill veya model usage değil. |
| HA-L50 — skill index | System prompt'a name/description metadata listesi olarak exposed available skills view. | Full content load değil. |
| HA-L51 — skills_list | Metadata-level list consumer; same-name first-wins davranışı olabilir. | Bare-name skill_view'un unique target bulacağı guarantee değil. |
| HA-L52 — skill_view | Explicit skill content/load/readiness/provenance view tool sonucu. | Procedure executed veya task success değil. |
| HA-L53 — refusing-to-guess collision | Same priority tier'de multiple same-name candidates bulunursa bare-name view'u reject etme. | List view'un tek satır göstermesiyle çelişmek zorunda değil; consumer semantics farklı. |
| HA-L54 — discovery exclusion | .archive/.curator_backups gibi roots'un iterator'dan çıkarılması. | Her dot-directory generic exclusion değil. |
| HA-L55 — restore-backups collision | Official restore backup path'i generic exclusion set'te olmadığında same-name alternate candidate yaratabilen conditional composition. | Actual incident gözlenmedi. |
| HA-L56 — index cache | Skill index metadata'nın process/disk cache'i. | Disk her request'te fresh-read demek değil. |
| HA-L57 — tool-list cache | skills tool metadata/signature/TTL cache'i. | System-prompt index cache ile aynı değil. |
| HA-L58 — repeat-view dedup | Same task + source path/mtime/size koşulunda full content yerine stub dönme optimization. | New content read/use event değil. |
| HA-L59 — setup_needed | Skill content yüklenmiş olsa bile required environment/credential/tool readiness eksik standing'i. | skill_view success = fully usable capability değil. |
| HA-L60 — loaded skill | Model-visible skill content'in current turn/context'e alınmış olması. | Applied/followed procedure değil. |
| HA-L61 — applied skill | Model/agent'in loaded procedure'ü actual reasoning/actions'ta kullanması. | Task outcome quality guarantee değil. |
| HA-L62 — skill efficacy | Skill kullanımı nedeniyle future/current task outcome'unun iyileşmesi. | Q60 öncesi establish edilmedi. |

## 5. Memory state and prompt visibility

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-L63 — memory store | Persistent memory data/state'in disk/DB/provider representation'ı. | Current agent prompt'ta visible olduğu anlamına gelmez. |
| HA-L64 — live memory state | Process içindeki loaded/current memory object/cache. | Disk ile aynı version olmayabilir. |
| HA-L65 — memory prompt snapshot | Current turn için selected memory content'in prompt representation'ı. | Store'un tamamı değil. |
| HA-L66 — pending memory mutation | User approval/processing bekleyen memory change record. | Applied persistent change değil. |
| HA-L67 — memory replay | Restart/session continuation'da durable pending/history'den current process'e state/event geri getirme. | Prior task/work re-execution değil. |
| HA-L68 — memory approval roundtrip | Proposal/pending memory change → user decision → persistent mutation lifecycle. | Approval UI display ≠ mutation success receipt. |
| HA-L69 — disk state != prompt state | Persistent content'in current prompt snapshot'a hangi selection/cache/version ile girdiğinin ayrı olması. | synthesis/notes. |
| HA-L70 — prompt-visible memory | Current model request'e actual selected memory representation'ın eklenmesi. | Memory was relevant/used correctly guarantee değil. |
| HA-L71 — DB prompt / cache / prepared request | Memory'nin farklı derived/runtime views'i. | Birbirinin synonym'i değil. |
| HA-L72 — stored system prompt | Session DB'de persisted full system-message representation; compatible ise fresh MemoryStore snapshot build'i yerine restore edilebilir. | U01-M4. Current memory file/version ile otomatik eşit değil. |
| HA-L73 — prompt compatibility | Stored prompt'un model/provider/platform/cwd gibi runtime identity fields ile current run'a reuse edilebilir sayılması. | U01-M4. Memory freshness bu inspected comparator'ın bir dimension'ı değil. |
| HA-L74 — prompt restore | Compatible persisted system prompt'u current agent cache'e geri bağlama path'i. | Fresh prompt rebuild değil. |
| HA-L75 — prompt invalidation | Cached system/static prompt'u clear edip memory store'u diskten reload etme operation'ı. | DB-stored full prompt'u kendi başına rewrite etmez. |
| HA-L76 — prompt rebuild / persist | Current memory snapshot + prompt parts'tan yeni full prompt üretip selected persistence path'e yazma. | Invalidation veya memory approval ile aynı transition değil. |
| HA-L77 — approval mode | Future writes'in staged/pending gate'e girip girmeyeceğini belirleyen configuration state. | Existing pending proposal'ın approve/apply transition'ı değil. |
| HA-L78 — payload approval / approve <id> | Specific pending record'un replay/application için human-command transition'ı. | Approval-mode setter/cache eviction path'iyle aynı değil. |
| HA-L79 — pending namespace | Active Hermes home altında subsystem+ID ile stored pending mutation records. | Per-user ownership relation bu record schema'da intrinsic değil. |
| HA-L80 — proposer origin | Pending record'daki foreground/background_review gibi provenance. | Human proposer/approver identity değil. |
| HA-L81 — apply success vs cleanup success | Mutation effect'in landed olması ile pending record'un queue'dan unlink/discard edilmesinin ayrı standing'leri. | U01-M2 N11; Approved count queue-empty receipt değil. |
| HA-L82 — staged applicability | Proposal'ın pending olarak serializable/stageable olması. | Later target/schema/operation validation pass guarantee değil; invalid batch stage edilebilir. |
| HA-L83 — routed profile home | Gateway/CLI work'in memory/pending/config filesystem namespace'inin context-scoped Hermes home'u. | Transport authorization home ile aynı role değil. |
| HA-L84 — transport authorization home | Primary multiplex ingress'te user/source authorization için preserved admitting-transport home. | Runtime data target/profile home ile aynı değil. |
| HA-L85 — prompt-use visibility chain | pending apply → persistent file → live store/snapshot → prompt restore/rebuild/cache → prepared request → actual wire/model use. | Earlier stage success later visibility receipt değildir. |


## 6. Learning/change lifecycle relation

Hermes source current coverage altında güçlü chain:

**conversation/artifact evidence → candidate lesson → proposal → review → approval/rejection → skill/memory mutation → persistent/local/library records → discovery/index → explicit load/view → model-visible context → actual future task use → task-quality effect.**

Araştırma şu an **task-quality effect** aşamasını Q60 olarak açık bırakıyor. Bu yüzden:
- proposal accepted ≠ mutation landed;
- mutation landed ≠ next session saw it;
- next session saw it ≠ skill was loaded;
- loaded ≠ followed;
- followed ≠ task improved;
- usage counter ≠ efficacy metric.

Bu ayrımlar Hermes concepts kaydında korunur.
