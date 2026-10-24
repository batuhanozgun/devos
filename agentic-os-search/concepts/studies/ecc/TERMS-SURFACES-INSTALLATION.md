# ECC — Surfaces, installation and ownership terms

2026-09-20, **B6-T16-C1 / DURABLE-COMPLETE / C1-COMPLETE**. [TERMS.md](TERMS.md)'nin linked parçasıdır. Bu dosya U01–U02 source package kullanımını taşır; evrensel installation/host taxonomy değildir.

## 1. Repository and distribution surfaces

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-S01 — repository surface | Source tree içindeki files/manifests/scripts/docs/workflows/ecc2 gibi authored corpus. | Installed package veya live runtime değil. |
| ECC-S02 — npm package surface | Root package.json/files listesiyle distribution'a dahil edilen Node package surface. | Repo root'un tamamı değil. |
| ECC-S03 — native plugin surface | Provider marketplace/plugin registration üzerinden tüketilen repo-native surface. | npm files allowlist ile aynı distribution boundary değil. |
| ECC-S04 — Rust ecc2 surface | Ayrı Cargo package/runtime/control-plane scaffold. | Node control pane veya npm package ile aynı artifact değil. |
| ECC-S05 — workflow pilot surface | workflows/ altındaki native Workflow-tool oriented pilot assets. | Root package inclusion veya installed workflow guarantee değil. |
| ECC-S06 — dispatcher | scripts/ecc.js gibi named command'i child script'e yönlendiren entrypoint. | End-to-end orchestration veya effect acceptance değil. |
| ECC-S07 — harness label | Codex/Claude/Kimi/OpenCode gibi target/provider name. | Tek bir install path/capability/host contract anlamına gelmez. |

## 2. Codex-specific source distinctions

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-S08 — native SessionStart hook | .codex-plugin manifest→codex-hooks→bootstrap chain'de declared synchronous SessionStart mechanism. | Full hook parity değil. |
| ECC-S09 — instruction-backed support | Shared architecture text'teki instruction-oriented Codex support description. | Same pin'deki native SessionStart surface'i yok saymaz. |
| ECC-S10 — plugin enablement | Provider inventory'de ECC plugin installed/enabled standing. | Hook command trust veya content completeness değil. |
| ECC-S11 — hook-command trust | Host'un hook command definition/approval trust boundary'si. | Plugin enabled standing ile aynı değil. |
| ECC-S12 — cache reference check | Cached manifest'teki seçili reference fields'in existence/type check'i. | Manifest'in bütün refs'i veya runtime usability değil. |
| ECC-S13 — false-green reference verdict | E01'de missing current hook reference'e rağmen checker success. | Real installed cache/host incident değil. |
| ECC-S14 — manifest coverage | Verifier'ın hangi manifest fields'i gerçekten collect/check ettiği. | “All references” label'ından otomatik çıkmaz. |

## 3. Installation channels

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-S15 — native provider reconciliation | Marketplace/plugin CLI üzerinden provider-owned registration/provenance reconciliation. | Managed home adapter değil. |
| ECC-S16 — managed home install | Manifest/request/resolver/adapter/apply engine ile target home'a managed files/state materialization. | Native marketplace registration değil. |
| ECC-S17 — legacy sync | Separate shell copy/merge/ownership workflow. | Native/managed routes'ın synonym'i değil. |
| ECC-S18 — install channel | Aynı named harness'a ulaşan concrete lifecycle path. | Harness name alone channel identity değildir. |
| ECC-S19 — install source boundary | Repo root, npm package, marketplace local source veya legacy source context'i. | Effective installed bytes değil. |
| ECC-S20 — selected component | User-facing named component/skill/language selector. | Leaf file payload olmak zorunda değil. |
| ECC-S21 — resolved module | Component mapping/dependency filtering sonrası selected install module. | Applied target operation değil. |
| ECC-S22 — target compatibility | Module/component'in specific target'a uygunluğu predicate'i. | Runtime readiness veya host acceptance değil. |
| ECC-S23 — operation plan | Adapter tarafından target paths/strategies'e çevrilen intended file/config operations. | Effects gerçekleşti receipt'i değil. |
| ECC-S24 — materialization | Plan'daki source content/config'in target files/state'e uygulanması; transform içerebilir. | Simple byte copy değil. |
| ECC-S25 — transformed content | Link rewrite/merge/filter gibi apply-time transformation sonucu installed bytes. | Source bytes'la eşit olmak zorunda değil. |
| ECC-S26 — applied operation | Apply engine'in gerçekten effect path'ine aldığı operation. | Persisted ownership/current health ile aynı değil. |
| ECC-S27 — skipped operation | Collision/policy/compatibility vb. nedeniyle uygulanmayan plan operation. | Plan'dan hiç var olmadı demek değil. |
| ECC-S28 — partial application | Multi-harness veya per-target apply'nin bazı effects sonrası failure standing'i. | Global transaction rollback değil. |
| ECC-S29 — retryHarnesses | Coordinator'ın failure sonrası yeniden denenmesi gereken harness listesi. | Next retry'nin admission garantisi değil. |

## 4. Ownership and install state

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-S30 — managed ownership | ECC'nin destination'ı future update/repair için kendine ait saydığı operational standing. | Historical authorship veya user authorization değil. |
| ECC-S31 — unowned destination | Existing destination için previous managed record/evidence bulunmayan state. | Bytes farklı/aynı olmak ownership'i tek başına belirlemez. |
| ECC-S32 — identical-but-unowned | Existing bytes source'a eşit olsa da common guard'ın ownership vermediği state. | Byte equality = management authority değil. |
| ECC-S33 — managed-update | Prior operation identity + current content evidence ile guided preflight'ın updateable saydığı destination. | Signed approval değil. |
| ECC-S34 — content digest | Installed/current bytes'i SHA-256 ile bağlayan evidence field. | Human intent veya semantic correctness değil. |
| ECC-S35 — operation identity | kind/moduleId/sourceRelativePath/strategy/scaffoldOnly gibi planned-operation identity. | Path alone değil. |
| ECC-S36 — install-state record | ecc.install.v1 canonical JSON representation. | Live filesystem truth veya completed install receipt değil. |
| ECC-S37 — installedAt | State record construction timestamp field. | Installation gerçekten bitti demek değil. |
| ECC-S38 — state preview | Writes öncesi/failure-recovery için candidate install-state representation. | Completed-effects journal değil. |
| ECC-S39 — bridge state | Apply öncesi/partial failure sonrası management/recovery context taşıyan intermediate state. | Claude-only migration artifact değil; non-Claude plans'ta da üretilebilir. |
| ECC-S40 — final install state | Effective operations/digests sonrası intended durable ownership record. | Projection DB veya host usage ile aynı değil. |
| ECC-S41 — preserveUnwrittenFiles | Failure path'te prior managed metadata'yı ve unowned/skipped destinations'i yanlış sahiplenmemeye yönelik adjustment. | Atomic rollback değil. |
| ECC-S42 — partial-write checkpoint | Failure sonrası written/unwritten/pending operation bilgisini koruyan state. | Every listed operation happened anlamına gelmez. |
| ECC-S43 — recovery record | Safe refusal/cleanup/retry context sağlayabilen intermediate state. | Same-command transparent continuation garantisi değil. |
| ECC-S44 — retry admission | Next guided attempt'in current state/content/identity üzerinden yeniden kabul edilmesi. | retry listesi/checkpoint existence ile aynı değil. |

## 5. Projection and readiness

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| ECC-S45 — canonical install state | Target home'daki authoritative-ish managed JSON for that install path. | Derived DB projection değil. |
| ECC-S46 — install-state projection | Canonical state'ten state-store row üretme/reconcile etme view. | File integrity veya host usage değil. |
| ECC-S47 — discovered target identity | Reconciliation'ın inspect ettiği bounded target/home identity set'i. | Global absence/presence oracle değil. |
| ECC-S48 — canonicalStatus | Current canonical state/health inspection sonucu healthy/unverified vb. projection field. | Whole system readiness değil. |
| ECC-S49 — managed-file health | Current files üzerinde selected integrity/health issues. | Model/task effectiveness değil. |
| ECC-S50 — projection warning | Derived store sync/reconciliation problem signal. | Canonical file operation failure ile aynı değil. |
| ECC-S51 — registration readiness | Native provider plugin installed/enabled/provenance predicate. | Cache/hook/model readiness değil. |
| ECC-S52 — capability readiness | Required runtime/package/tool actually usable standing. | Skill installed/file exists ile aynı değil. |
| ECC-S53 — source→selected→materialized→visible→admitted→effective | U01/U02 boyunca tekrar eden staged interpretation chain. | Mandatory universal lifecycle değil; source-grounded distinction. |

## 6. C1 closure refinements

| ECC-S54 — install profile | minimal/standard/strict gibi install-time module/capability selection context'i. | Hook profile veya host trust policy ile aynı değil. |
| ECC-S55 — hook profile | Hook runner/registration'ın hangi hooks'u activate ettiği profile dimension. | Install profile aynı isimleri kullansa bile identical selector/capability set olduğu kanıtlanmaz. |
| ECC-S56 — source/runtime version binding | Research pin, installer/provider lifecycle source, installed cache/runtime ve current host version'ın ayrı kimlikler olarak tutulması. | Research pin tek başına actual installed/runtime version'ı belirlemez. |

## 7. C1 boundaries

Özellikle:
- source available ≠ selected;
- selected ≠ materialized;
- materialized ≠ managed/recorded;
- recorded ≠ projected/current;
- provider registration ≠ cache completeness;
- cache completeness ≠ hook trust/invocation;
- hook invocation ≠ useful context/task benefit;
- structurally valid state ≠ completed effect;
- checkpoint ≠ successful retry;
- identical bytes ≠ ownership.

Bu kayıtlar ECC source-study'nin U01–U02 kullanımına bağlıdır.
