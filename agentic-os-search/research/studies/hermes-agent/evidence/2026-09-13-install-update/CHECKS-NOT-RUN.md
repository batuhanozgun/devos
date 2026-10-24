# U14 — Çalıştırılmamış ayırıcı kontroller

**2026-09-13 / NOT RUN.** [A](INSTALL-AND-ACTIVATION.md) ve [B](UPDATE-AND-RECOVERY.md) kaynak araştırmasıdır. Bu tabloda yeni test sonucu yoktur. Her kontrol exact hedef/source/dependency/config, ölçülen gerçek etki ve kabul makbuzuyla yeniden kurulmalıdır; sahte successful helper gerçek ürün kabulü değildir.

| Alan | Ayırıcı ölçüm | Bu turun açık sınırı |
|---|---|---|
| Q58 source/ref | Fresh/existing/broken checkout, ancestor/nonancestor commit isteği, dirty files vs local commits, stash restore conflict; effective HEAD ve working-tree identity | Parametre, version string veya Git return code actual kurulu kaynak değildir |
| Q58 dependency identity | Lock-first/re-resolve/core fallback ve editable-skip yollarında actual interpreter, installed distribution graph, extras/assets/console shims, fresh process imports | A/B source hiçbir installer/solver veya full dependency graph çalıştırmadı |
| Q58 home/profile/activation | Explicit HERMES_HOME/dir/profile, sticky profile, supervised service, PATH/venv shim ve actual first request/config | Source/cwd/command aynı user state veya çalışan runtime demek değildir |
| Q58 staged install | Noninteractive setup/gateway skip, prerequisite failure, complete marker ve actual service readiness ayrı ölçülsün | ok+skipped ile tam configuration/health eşit değil |
| Q58 update admission | Valid/invalid/absent/unreadable image provenance, detect-method failure, managed/plan/check/apply entrypoints | Marker reader exception fallback ve actual provenance authority full doğrulanmadı |
| Q58 update concurrency | İki gerçek contender aynı empty marker aşamasında; write-denied, stale-age/live PID, handoff, shared code/different home; readback ownership | UpdateLock normal read→write atomic değil; olası iki kabul source inference, runtime gözlemi değil |
| Q58 recovery concurrency | O_EXCL normal yarış, stale recovery lock, permission failure, live marker owner ve core/lazy differing argv | Recovery lock ayrı mekanizma; bütün hata kollarında exclusion garanti edilmedi |
| Q58 phase interruption | Code swap öncesi/sonrası, core/lazy install, module purge, fleet restart marker; next launch ve pending obligation | Tek rollback/tek complete transaction yok; actual repair/OS interruption NOT RUN |
| Q58 backup/state | Disabled/failed/oversize snapshot, siblings, newest valid image, concurrent DB holders, restored contents vs latest events | Snapshot ve integrity geçişi kayıpsız semantic history garantisi değildir |
| Q58 verification | Critical-file parse vs missing file/import, probe cannot launch/unknown, actual runtime SHA/model service health | Narrow verifier veya absence of error full product proof değil |
| Q58 fleet | Expected-empty, stopped-without-replacement, unknown SHA, stale serve generation, platform supervisor/plan reconciliation | Socket/status/PID/checked-out code bilgisi full physical or functional outcome değildir |
| Q58 result contract | Node refresh fail, desktop fail, unknown runtime probe, update_complete/restart.incomplete; banner/exit/receipt/gateway marker together | Kaynakta koşullu divergence var; actual composite flow çalıştırılmadı |
| Q58 receipt | Versioned file write failure, latest pointer failure, singleton pop ve command-boundary retry | Finalization once kalıcı publish garantisi değil |
| Q59 candidate bridge | Install/update/startup skills sync origin/manifest, user edit/deletion, profile seeding ve curator archive; next discovery/readback | Caller report operational skill-library lifecycle doğrulaması değildir; yeni geniş kaynak işi henüz yapılmadı |

Bu kontrollerin hepsini bitirmek geniş araştırmanın ön koşulu değildir. Güvenilirlik/adoption kararı, karşı kanıt veya gerçek erişilebilir dependency closure gerektirdiğinde ilgili residual yeniden açılır. Canlı installer/update/service veya gerçek kullanıcı ortamına müdahale yetkisi bu tablodan türemez. U13 Q57, U12 Q54, U11 Q55/Q56 ve eski U04–U10 fidelity/quality/DB/worker sınırları korunur; eski diagnostic'ler yeniden çalıştırılmadı.
