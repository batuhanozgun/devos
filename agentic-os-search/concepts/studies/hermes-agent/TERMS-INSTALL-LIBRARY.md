# Hermes Agent — Installation, update and library lifecycle terms

2026-09-20, **B6-T15-H5 / DURABLE TRANSFER COMPLETE / PACKAGE-COMPLETE**. TERMS.md'nin bağlı parçasıdır. Kaynak: notes 29–30, U14–U15 evidence.

## 1. Installation identity and materialization

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-I01 — install source | Managed/source checkout veya package/image source identity. | Installed command/runtime identity değil. |
| HA-I02 — INSTALL_DIR | Hermes code/source checkout'un physical install root'u. | User data/home state ile aynı değil. |
| HA-I03 — HERMES_HOME | Profile/config/state/skills gibi user-level persistent data root. | Code checkout/install method değil. |
| HA-I04 — install layout | Non-root/home, FHS/root, Termux gibi code/command/data roots dağılımı. | Same platform bütün kullanıcılarda same effective path guarantee değil. |
| HA-I05 — install method marker | Code tree'nin Git/package/image vb. hangi management path'le yönetildiğini belirten marker. | Running process/model/capability readiness receipt değil. |
| HA-I06 — requested ref / commit | Installer/update input olarak target branch/commit request. | Effective checked-out HEAD ile aynı değil. |
| HA-I07 — effective HEAD | Install tree'de gerçekten checkout edilmiş Git identity. | Dependency/materialized/runtime identity değil. |
| HA-I08 — dirty working tree | Local uncommitted code state. | Local commit history/user data ile aynı preservation object değil. |
| HA-I09 — stash | Dirty file changes'i update sırasında geçici saklama mechanism. | User home backup veya successful restore guarantee değil. |
| HA-I10 — venv | Selected Python interpreter/dependency environment. | Whole Hermes capability set değil. |
| HA-I11 — lock-first dependency install | uv.lock + locked resolver policy ile dependency graph materialization denemesi. | Every fallback path same graph değil. |
| HA-I12 — dependency fallback | Locked/full optional install başarısızsa narrower/re-resolved core paths'e düşme. | Install success = all optional capabilities ready değil. |
| HA-I13 — console shim / launcher | PATH command'i selected interpreter ve checkout module entrypoint'e bağlayan executable wrapper. | Shell PATH reload veya config/profile readiness değil. |
| HA-I14 — profile | User/config/runtime state'in named partition/identity surface'i. | HERMES_HOME veya process identity ile aynı değil. |
| HA-I15 — active profile | Startup resolver'ın effective selected profile'i. | All services same profile kullanır guarantee değil. |
| HA-I16 — sticky profile | Persisted preferred profile selection. | Explicit CLI/profile override üzerinde absolute priority değil. |
| HA-I17 — supervised service profile | Long-running gateway/service için fixed/default profile selection behavior. | Interactive UI profile switching ile aynı değil. |
| HA-I18 — template/bootstrap state | Missing config/env/persona/skill data directories'in install/setup sırasında seeded olması. | Setup fully configured/service ready receipt değil. |
| HA-I19 — stage manifest | Staged installer'ın stage outcome JSON representation'ı. | ok:true + skipped:true = configured/healthy demek değil. |
| HA-I20 — setup completed | Installer orchestration'ın intended steps'ten acceptable endpoint'e ulaşması. | Gateway/model/browser/all optional capability readiness değil. |

## 2. Update authority and source transition

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-I21 — update admission | Current install provenance/method/mode'a göre in-place update'in allowed/refused/plan/check olduğuna karar verme. | Update effect değil. |
| HA-I22 — UpdateRefusal | Image/package-managed install'ın Hermes Git updater tarafından mutate edilmemesi gerektiğini taşıyan explicit result. | Product failure değil; responsibility boundary. |
| HA-I23 — manager-owned update | Docker/Nix/apt/image/package manager'ın source/runtime change authority'sini taşıması. | Hermes in-place updater ile aynı lifecycle değil. |
| HA-I24 — update plan | Apply etmeden expected/current update work'i gösteren read-oriented view. | Mutation değil. |
| HA-I25 — update check | Current/source state'i inspect edip update applicability/freshness raporlama path'i. | Apply authority veya success değil. |
| HA-I26 — UpdateLock | Concurrent updater coordination için process-home marker mechanism. | Atomic mutex guarantee değil; source read→write race/fail-open I/O sınırı var. |
| HA-I27 — recovery lock | Early recovery'de O_CREAT|O_EXCL normal path kullanan ayrı lock mechanism. | UpdateLock ile aynı guarantee değil. |
| HA-I28 — updater ownership / handoff | Parent-child/process ancestry ile same orchestrating update claim altında marker kullanımına izin veren logic. | Cross-process all-path mutual exclusion değil. |
| HA-I29 — Git source transition | Fetch/checkout/ff/merge/reset/rescue-ref ile managed code tree'yi new state'e taşıma. | Dependencies/user data/running process transition değil. |
| HA-I30 — source rollback | Critical syntax/HEAD validation failure sonrası pre-pull Git state'e dönme attempt'i. | User-data/dependency/process rollback değil. |
| HA-I31 — rescue ref | Divergent/history cases'te old/local source state'i recoverable reference olarak saklama. | Restore occurred guarantee değil. |

## 3. Backup, recovery and pending obligations

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-I32 — quick snapshot | Selected critical home/profile/data state'in bounded backup'ı. | Full user history backup değil. |
| HA-I33 — full backup | Broader home archive + selected snapshots. | Atomic all-system rollback değil. |
| HA-I34 — backup disabled/failed | Update proceed edebilen failure/choice state. | Update necessarily aborted değil. |
| HA-I35 — DB restore | User-state database'i valid snapshot'tan recover etme path'i. | Newer events losslessly preserved guarantee değil. |
| HA-I36 — source/data/process recovery separation | Git rollback, home/DB restore ve service restart'ın ayrı operations olması. | One transaction değil. |
| HA-I37 — update-incomplete marker | Dependency/core installation work'i next process'e taşıyan durable obligation. | Source code unchanged demek değil. |
| HA-I38 — lazy-refresh-incomplete | Optional/lazy dependency refresh'in tamamlanmadığını taşıyan ayrı marker. | Core install state ile aynı değil. |
| HA-I39 — fleet_restart_pending | New code/dependency sonrası old runtime processes'in replacement/restart obligation'ı. | Restart completed receipt değil. |
| HA-I40 — early recovery | Third-party imports öncesinde pending install/refresh markers'i inspect/repair etme startup path'i. | Every failure fully repaired guarantee değil. |
| HA-I41 — pending core recovery | Core marker varsa narrow import probe'a güvenmeden install repair'i sahiplenebilme. | Actual package correctness guarantee değil. |
| HA-I42 — bounded repair attempts | Recovery'nin retry/attempt cap ile sınırlı olması. | Permanent failure solved demek değil. |

## 4. Runtime activation and fleet standing

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-I43 — loaded module graph | Updater process'in memory'de tuttuğu old/new Python modules state'i. | On-disk checkout ile aynı değil. |
| HA-I44 — module purge/reload | Pull sonrası selected runtime modules'i fresh code'a bağlama attempt'i. | Whole process graph atomic refresh değil. |
| HA-I45 — control-state preservation | Update orchestration classes/receipt/lock state'i purge/reload'dan deliberately koruma. | Application code all-current guarantee değil. |
| HA-I46 — fleet | Gateway/serve/dashboard gibi currently known runtime process set'i. | All functional service state değil. |
| HA-I47 — runtime inventory | Pre-update running process/profile/supervisor/code identity snapshot. | Perfect completeness/liveness oracle değil. |
| HA-I48 — process code SHA | Runtime process'in reported loaded code identity. | Functional health veya correct config değil. |
| HA-I49 — fleet stale | Runtime process'in code identity current checkout'tan farklı standing'i. | Process unusable demek değil. |
| HA-I50 — fleet down | Expected pre-existing runtime'ın replacement olarak bulunmaması. | Root cause veya service health whole-picture değil. |
| HA-I51 — fleet unknown | Code identity veya status data insufficient standing. | Healthy veya failed demek değil. |
| HA-I52 — restart attempted | Supervisor/process replacement action'ının requested/executed olması. | Fresh replacement verified değil. |
| HA-I53 — restart verified | New expected runtime identity'nin post-update readback ile bulunması. | Full functional/model health guarantee değil. |
| HA-I54 — old process gone != replacement ready | Prior PID/process disappearance'ın activation success receipt olmaması. | U14 source distinction. |

## 5. Update result and receipt semantics

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-I55 — update outcome | Caller'ın refused/partial/success gibi composite status hükmü. | Every step boolean automatically aggregated değil. |
| HA-I56 — partial update | Some code/dependency/restart/user-state obligations incomplete while other transition succeeded. | Total failure veya success değil. |
| HA-I57 — update summary/banner | CLI-visible textual status. | Exit code veya persistent receipt ile aynı değil. |
| HA-I58 — command exit code | CLI process completion signal. | Persistent receipt or every substep success değil. |
| HA-I59 — update receipt | Pre/post identities, step/skips/outcome/restart details taşıyan durable report. | File definitely written guarantee değil. |
| HA-I60 — receipt finalize | In-memory receipt singleton'ı one-time final outcome'a dönüştürüp write etmeye çalışma. | Durable publish success ile aynı değil. |
| HA-I61 — latest receipt pointer | Latest update receipt'e convenience/reference pointer write. | Versioned receipt itself ile aynı write guarantee değil. |
| HA-I62 — update marker | Gateway/restart-related early phase progress/result representation. | Final fleet verification değil. |
| HA-I63 — banner/exit/receipt divergence | Node/desktop/restart/receipt branches nedeniyle user text, exit status ve durable outcome'un farklı standing taşıyabilmesi. | Source-conditional; actual failure sequence U14'te run edilmedi. |

## 6. Skill-library lifecycle under install/update

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-I64 — bundled skill seeding | Initial install/setup sırasında default skills'in empty/eligible profile library'ye kopyalanması. | Later sync lifecycle'in tamamı değil. |
| HA-I65 — skills sync | Install/update/startup sırasında bundled source ile local library'yi reconcile etme. | Every user customization preserved guarantee değil. |
| HA-I66 — skill sync caller report | Update/install orchestration'ın sync result/log'u. | Actual library origin/user-edit/deletion semantics receipt değil. |
| HA-I67 — profile skill library | Named profile altındaki active skill packages. | Bundled source tree veya external source ile aynı değil. |
| HA-I68 — library readiness | Skills discoverable/loadable ve required runtime/setup usable olma composite-like operational standing. | Skill file exists ile aynı değil. |
| HA-I69 — curator notification | Update sonrası curator'a library change/maintenance opportunity bildirme. | Curator change admitted/applied demek değil. |

## 7. Library enumeration and views

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-I70 — active library | Current discovery roots'ta loadable candidates olarak görünen skill packages set'i. | Archive/backup/manifest history'nin tamamı değil. |
| HA-I71 — archived library | Active discovery dışına taşınmış skill packages. | Deleted content değil. |
| HA-I72 — suppressed builtin set | Bundled re-seeding'e karşı retained curator policy. | Active path always absent guarantee değil. |
| HA-I73 — library index | System prompt/skills metadata consumer için derived available-skill view. | Full source truth değil. |
| HA-I74 — library collision | Same logical name için same priority tier'de multiple candidate packages. | List consumer ve view consumer farklı davranabilir. |
| HA-I75 — library lifecycle | Bundled/source→sync→local modified/deleted→archive/suppress/adopt→discovery/load→later update relation family. | Tek manifest/ledger state machine değil. |

## 8. Installation/update/library non-collapse

Hermes U14–U15 current research şu zincirleri ayrı tutar:

**source checkout → dependency environment → launcher/shim → home/profile/config → running module/process → update source transition → dependency repair → fleet restart/readback → receipt**

ve

**bundled source → manifest baseline → local skill content → usage/suppression/archive/ledger state → discovery/index/view → model load/readiness.**

Özellikle:
- requested commit != effective HEAD;
- effective HEAD != dependency graph;
- dependency install success != all optional capabilities ready;
- command installed != gateway/service/model ready;
- source advanced != materialization complete;
- materialization complete != old live process replaced;
- backup/stash/snapshot/rescue ref protect different objects;
- restart attempted != replacement verified;
- receipt finalized != receipt persisted;
- skill sync called != user library semantics verified;
- skill file exists != loadable/ready/reused.
