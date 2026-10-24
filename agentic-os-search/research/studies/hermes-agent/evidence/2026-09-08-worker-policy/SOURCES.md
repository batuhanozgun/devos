# Kaynak, okuma ve yürütme defteri — worker-policy

**Tarih:** 2026-09-08. **Research tabanı:** `36f1b7e6ae07da5c1d9d57ff9633d48473c42537`.
**Birincil upstream pin:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Hareketli HEAD doğrulanmadı.

Bu defterde E kimlikleri bu çalışma dilimine özeldir. Önceki H/S/W/D kaynak ve deney kimlikleri yeniden numaralandırılmaz. Tam kaynağın araç cevabıyla alınması, tam ürün yürütmesi veya bütün dosyanın araştırma açısından kapanması değildir.

| ID | Pinned kaynak | Git blob SHA | Bu tur kaynak ve deney derinliği |
|---|---|---|---|
| E01 | [agent/tool_executor.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/tool_executor.py) | `799199c10f9930da77c01da2324373614b27cb78` | Tam blob yanıtı alındı; ordinary sequential/shared middleware/policy/worker/commit ve concurrent bağlantılar seçili incelendi. **Yalnız `excerpts/tool_executor.selected.py` içindeki elle aktarılmış tanımlar yürütüldü; tam modül hash doğrulaması/yürütmesi yok.** |
| E02 | [hermes_cli/plugins.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/plugins.py) | `da8d7e2c68b2346e6ecc15567d755d96085ef767` | Tam blob yanıtı alındı; module-level whitelist setter/consumer ve directive/approval çözümü seçili incelendi. **Yalnız `excerpts/plugins.selected.py` tanımları yürütüldü; gerçek PluginManager/discovery değil.** |
| E03 | [tools/thread_context.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/thread_context.py) | `d8c37af8f5a529680e81e867177140e41c4c6656` | FULL READ; tam yerel byte'lar Git blob formülüyle doğrulandı; EXECUTED. Terminal callback API'si sentetik. |
| E04 | [tools/daemon_pool.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/daemon_pool.py) | `5682a8f6ae103a421c1081b69ee6f9272957acdf` | FULL READ; tam yerel Git blob eşleşmesi; EXECUTED. CPython executor internallerine bağımlı. |
| E05 | [agent/tool_dispatch_helpers.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/tool_dispatch_helpers.py) | `f994ecfab247490695d75211f93f55688166dc6d` | Tam blob yanıtı alındı; planner/admission/path rezervasyonu ve `_NEVER_PARALLEL_TOOLS` incelendi. Bu modül çalıştırılmadı. Harness'teki `frozenset({'clarify'})` bu kaynaktan alınan sabittir. |
| E06 | [agent/turn_tool_validation.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/turn_tool_validation.py) | `db3e89334ebb4302f55357e8063c28f5758becd5` | FULL READ; 10.065 byte'lık tam yerel kopya Git blob eşleşmesiyle doğrulandı. V01–V05'te `validate_tool_calls` EXECUTED; agent holder/message helpers sentetik. |
| E07 | [LICENSE](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/LICENSE) | `75410e73319c72cd3e991a501c5455eb78f38375` | Önceden alınmış U01B2 arşivindeki MIT lisansı yerel dosyaya aktarıldı; Git blob eşleşmesi tekrar kontrol edildi. Lisans yorumu/dağıtım kararı yapılmadı. |

## Deneydeki gerçek ve sentetik parçalar

`excerpts/` dosyaları kaynak seçkileridir, tam modül değildir. İlgili işlev gövdeleri blob yanıtından elle aktarılmıştır; import scaffolding eklenmiş, bazı tanımların dosya içi sırası değişmiştir. Kendilerine ait SHA-256 kimlikleri RESULT ve manifestte tutulur. Bu kimlikler **upstream'in tam dosya kimliği değildir**. İncelenen orijinal kaynakla bağı sembol+blob rotasıdır; otomatik AST eşitlik kontrolü bu tur yapılmadı.

E01 seçkisi: `_ToolCallRef`, `_ManagedToolResult`, timeout/cancel marker sınıfları, `_registered_tool_worker`, `_blocked_tool_result`, `_pre_tool_block`, `_dispatch_authorized_once`, `_run_agent_tool_execution_middleware`, sequential poll/abandon/wrapper tanımları ve `_ConcurrentToolAuthorizationGate`.

E02 seçkisi: `_thread_tool_whitelist`, `_PreToolCallDirective`, set/clear, `_get_pre_tool_call_directive_details`, `_resolve_block_from_details`, `_dispatch_pre_tool_call_hooks`.

Yerel sınır taklitleri: Relay, request/execution middleware, lifecycle hook teslimi, guardrail nesnesi, approval transport/context API, UI/post-hook/heartbeat, süre ayarları, parent agent nesnesi, origin/profile işaretleri ve terminal callback API. Testlerin etkisi yalnız bellekte zararsız işaretleyici kaydıdır. E02 tüketicisinin algoritması sentetik izin listesi karşılaştırmasıyla değiştirilmemiştir; kendi module-level threading.local durumunu okur. Sadece gözlem sarmalayıcısı eklenmiştir.

Tam AIAgent, review/fork inşası, registry keşfi, gerçek valid-name kümesinin oluşması, bütün ordinary loop, concurrent executor, PluginManager lifecycle/discovery, gerçek kullanıcı profili, provider/model, credentials, gerçek terminal/MCP aracı, kurulum, network etkisi ve üretim kullanımı yürütülmedi.

## Kanıt zamanları ve bütünlük

- C01–C14: `RESULT.json`, UTC `2026-09-08T19:31:50.677314+00:00`; Python 3.13.5/Linux.
- V01–V05: `VALIDATION-RESULT.json`, UTC `2026-09-08T19:36:58.555297+00:00`; aynı runtime. İlk deneyin ardından yazılan ayrı VALIDATION-SPEC'e göre keşifsel ek; holdout değildir.
- Kaynak bozulması: `IDENTITY-CHECK.json`, UTC `2026-09-08T19:36:24.270992+00:00`. Gerçek pre-import doğrulayıcı değiştirilmiş geçici kopyada ValueError verdi; upstream import yapılmadı.

İlk RESULT içindeki `modified_full_source_identity_rejected` alanı yalnız bozuk byte'ların farklı hash üretmesi karşılaştırmasını kaydetmiştir. Gerçek guard çağrısının hata vermesi sonradan ayrı IDENTITY-CHECK ile sınandı; eski RESULT bu ayrımı gizlemek için yeniden yazılmadı.

E06 tam kopyasının quote/escape aktarım farkları importtan önce düzeltilip beklenen blob ile eşleştirildi; beklenen hash değiştirilmedi. E01/E02 seçkilerini bu yöntemle tam dosya doğrulanmış saymıyoruz. `verify_excerpts.py` tam pinned kaynaklar yerelde mevcut olduğunda seçili tanımların AST'sini karşılaştırmak için hazırlanmıştır; bu tur canonical tam dosyalara karşı koşturulmadı. Yalnız derlenebilirliği kontrol edildi.

## Haricî açıklama kaynakları

- [Python 3.13 contextvars](https://docs.python.org/3.13/library/contextvars.html): Context ve iş parçacığı ilişkisinin resmî açıklaması. Hermes davranışının yerine geçen kanıt değildir; stdlib'in bütün sürümleri hakkında yorum yapılmadı.
- [Hermes Tools Runtime](https://hermes-agent.nousresearch.com/docs/developer-guide/tools-runtime): registry/definition/dispatch için belge keşfi. Commit'e bağlanmamış web görünümüdür; E01–E06'nın sürüm otoritesi yerine kullanılmadı.

## Erişim ve yayın

Bu tur pinned blob içerikleri GitHub bağlantısından alınabildi. Yerel doğrudan URL indirme denemesi DNS hatası verdi; tool çıktısındaki büyük kaynakların otomatik yerel byte kopyası kurulmadı. Bu nedenle seçki ile hash-verified tam modül ayrımı korunur.

GitHub yazma keşfi bir aşamada create_file şeması gösterdi; gerçek çağrı `Resource not found: GitHub.create_file` döndürdü. Sonraki full keşif yalnız okuma ağırlıklı 48 eylem gösterdi; ref/tree/update yazısı bulunamadı. SPEC'in uzak yayını başarılı sayılmadı. Kurulu/enabled GitHub plugin araması yeni bir yazma yolu sağlamadı; user izinleri değiştirilmedi veya hata nedeni diye varsayılmadı. Yayın sonucu için PUBLICATION-HANDOFF esas alınır.
