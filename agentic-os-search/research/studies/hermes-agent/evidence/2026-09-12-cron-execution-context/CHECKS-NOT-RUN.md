# U10 — Yapılmamış doğrulamalar ve yeniden açma koşulları

**2026-09-12 / NOT RUN.** [RESEARCH](RESEARCH.md), [SPEC](SPEC.md), [RESULT](RESULT.json). C01–C06 yalnız native context selector'ı sınar. Aşağıdaki kontroller tamamlanmış veya planın tümü için zorunlu başlangıç engeli değildir.

| Alan | Ayırıcı gerçek kontrol | Şimdiki sınır |
|---|---|---|
| Q49 accepted→agent | Gerçek run_one_job→run_job→AIAgent kabulünü, exact execution/task/session ID ve ilk hazırlanmış request ile kaydet; agent ve no_agent yollarını ayır | Kaynakla bağlandı, whole-host/DB/provider koşusu yok |
| Q51 context_from | Gerçek output writer + selector + notepad/memory + ilk model request zincirinde sessiz/boş/error/uzun prompt durumlarını ayır | Yalnız selector gerçek; producer doc biçimleri sentetik; model etkisi yok |
| Q52 monitor | Hash/snapshot kaydı, ardından preflight/model/teslim hatası ve sonraki unchanged tick'i gerçek store ile ölç; partial write ve birbirine geçen iki gözlemi ayır | Monitor kaynak-only; C02 bu test değil |
| Cwd | Aynı job.workdir ile no_agent, monitor_script ve agent pre-run script için gerçek subprocess cwd'sini ve agent task-cwd'sini kaydet | Omitted-argument/default zinciri source-only; script çalıştırılmadı |
| Runtime/gates | Default/pin/fallback çifti, affirmative preflight hata ve internal-error varyantlarını actual consumer'da ayır; ölçüt gerçek backend/request kimliği olmalı | Resolver/credential çağrısı, skill scanner effectiveness, tüm config precedence kapanmadı |
| Bilgi/otorite | Profile isolation, origin vs sender, stateless delegation, builtin/external memory ve notepad consumer'larını actual worker üzerinde gözle | Constructor/helper source; alt capability/permission/OS güvencesi yok |
| Persistence | DB init timeout→lazy recall açılışı, compression tip finalize, stale-owner write ve lifecycle unknown/probe-failure | Gerçek SessionDB/full worker yok |
| Sonuç | Max-iterations summary, empty response, job status, session end_reason ve kullanıcı acceptance'ını ayrı ölç | Kaynak yorumları kalite oracle'ı değil |
| Cleanup | Gerçek still-running worker Future'ı bittiğinde finalization ve teardown sırası; profile scope/cancellation yarışları | S08 source-only; yeni thread/OS koşusu yok |

Tam kaynak/bağımlılık erişimi, yeni karşı kanıt veya bir reliability/adoption kararının bu iddiayı yük taşıyan hale getirmesi, ilgili doğrulamayı yeniden açar. Kendi fake'inin returned acceptance değerini başarı ölçütü yapmak yeterli değildir. Yeni bir deneyden önce oracle/scope/kimlik sabitlenir; model/provider/credential veya full product sınırı ayrıca yetki ister.

Q40 actual SessionDB quiet-history, Q42 restart actual admission, Q47 late callback/NAS/clock, Q48/Q50 full transport/status/receipt ve eski Q07/Q22/Q26/Q29/Q38 aynı açıklıkta kalır. Bu dosya onları yeniden yapıldı veya kapatıldı göstermez. Sonraki geniş source araştırması Q53 provider/runtime/backend; bütün fault matrisi bitmeden bu açıklama genişleyebilir.
