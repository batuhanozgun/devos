# U01-D — Gerçek çağrı zinciri, kontrol bağlamı ve sonuç kaydı

**Tarih:** 2026-09-08. **Statü:** PINNED SOURCE ANALYSIS + BOUNDED THREE-MODULE TRANSPORT PROBE; bütün ürün doğrulaması değil.
**Pin:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.
**Kaynak:** [D01–D21 defteri](../evidence/2026-09-08-context-transfer/SOURCES.md). **Deney:** [giriş ve sınırlar](../evidence/2026-09-08-context-transfer/README.md), [ham sonuç](../evidence/2026-09-08-context-transfer/RESULT.json).

## 1. Önceki boşluk ve bu turun kapsamı

[05 belge notu](05-DISPATCH-CONTEXT-AND-REPLAY-CONTRACTS.md) gerçek caller kodunu doğrulamıyordu. Bu tur aynı path isteği yine 429 verdi; fakat sabit commit'in Git ağacı ve blob kimlikleri üzerinden kaynaklar erişilebilir oldu. Primary pin değiştirilmedi. Dolayısıyla artık yalnız doküman kontratı değil, gerçek ordinary-loop, worker ve dispatch kodunun incelenmiş kesitleri vardır. Bu erişim gözlemi bütün GitHub erişim sorunlarının düzeldiği anlamına gelmez.

Soru: review/foreground çağrısı bir araç etkisine dönüşürken hangi kontrol, köken ve sonuç bilgisi hangi yürütme sınırından geçer? Kullanıcının amacı HERMES'i anlamaktır; bu not upstream düzeltme veya güvenlik sertifikası değildir. Curator'ın batch raporu, tüm UI'lerin onay yolu, ledger/sync ve öğrenme kalitesi hâlâ açık bırakılır.

## 2. Artık kaynakla görülen çalışma zinciri

```text
AIAgent / run_agent façade                         D01
  → TurnFacadeMixin.run_conversation               D12
      canlı turn öncesi review cancellation çağrısı
      turn admission / lease / accounting scopes
  → conversation_loop.run_conversation             D13
  → build_turn_context                             D14
      session ve write-origin bağlama
      prompt restore/build, bellek nudge, prefetch
  → loop'un tool-round çağrısı                      D13
  → executor / shared middleware                   D04
      izin-scope, pre-tool directive, guardrails
      → agent-local inline araç                    D03
      → genel model_tools / registry               D05
  → sonuç sınıflandırma / kalıcılaştırma / bildirim  D04
```

Bu şema çalıştırılmış tam bir trace değildir; incelenmiş çağrı noktalarının statik birleşimidir. Tool-round ara modülü ve her middleware/lease bağımlılığı bu tur kapanmadı. D13'te `api_mode == codex_app_server` ordinary loop'tan önce başka runtime'a döner. Bu yüzden ordinary executor bulgusu bütün transport'lara yayılmaz.

D14 `set_current_write_origin(getattr(agent, '_memory_write_origin', 'assistant_tool'))` ile kökeni açıkça bağlar. D19'un ContextVar varsayılanı `foreground` olsa da actual prologue'un fallback literal'i `assistant_tool`'dur. Bu adların hepsini tek kullanıcı kimliği gibi yorumlamamak gerekir. `is_background_review` yalnız ilgili sentinel ile eşitliği sınar. Profil, köken, insan onayı ve OS yetkisi aynı alan değildir.

D12 canlı turn başlamadan review cancellation fonksiyonunu çağırır; admission ve accounting/affinity scopes kurar, çıkışta turn/lease/idle işaretlerini temizler. Bu callsite'ların bulunması eski worker'ın her durumda durduğu veya paylaşılan store'un tüm yarışlarının kapandığı kanıtı değildir. Lease implementation ve bütün finalization varyantları ayrıca araştırılmalıdır.

## 3. Özel bellek yolu kontrolsüz bir kısa yol değildir

**SOURCE OBSERVATION:** D04'ün ortak dispatch katmanı request/execution middleware, yetkilendirilmiş çağrı, pre-tool kontrol ve guardrail adımlarını inline/genel ayrımından önce düzenler. D03'te `memory` agent-local store kullanabilir. Genel D05 çağrısına bazı `skip_*` bayraklarının aktarılması, bu dış katmanda zaten yapılmış kontrollerin ikinci kez yapılmaması içindir.

**Sınırlı sonuç:** 05/K01'in rakip açıklamalarından 'özel memory mutlaka pre-tool denetimi dışında kalır' çıkarımı desteklenmiyor; ortak denetim callsite'ı var. Ancak ortak fonksiyonun varlığı denetimin her worker'da aynı policy state'ini gördüğünü kanıtlamaz. Bir sonraki bölüm bu ikinci soruyu açıyor.

Bu katmanlar yalnız güvenlik filtresi değildir: scope, çağrı kimliği, aynı etkinin tekrar çalıştırılmaması, guardrail ve sonuç temsili de yürütme modelinin parçalarıdır. İlgili middleware bağımlılıklarının tamamı okunmadan tek 'güvenli/güvensiz' etiketi verilmez.

## 4. Sıralı çağrı, aynı iş parçacığı demek değil

**SOURCE OBSERVATION:** D11 batch planner'ı çağrıları sıralı/paralel segmentlere ayırır. Path çakışması, bilinmeyen kapsam veya güvenli kabul edilmeyen araç bir sıralama engeli olabilir. Buna karşılık `_NEVER_PARALLEL_TOOLS` bu pin'de yalnız `clarify` içerir.

D04'ün sıralı yolunda bu özel küme dışındaki çağrılar tek worker'lı daemon pool'a gönderilebilir; `propagate_context_to_thread` kullanılır. Concurrent yol da worker aktarımı kullanır. Bu nedenle 'skill_manage paralel-safe değil' bilgisinden 'review thread'inin yerel durumunu doğrudan görür' sonucu çıkmaz. Planner'ın iş sırası ile executor'ın thread yerleşimi ayrı kararlar vermektedir.

## 5. Kontrol bağlamının aktarımında kaynakla belirlenen aday boşluk

**SOURCE OBSERVATION:** D18 review kodu tool whitelist'i review thread'inde kurar. D07'de bu whitelist `threading.local()` tabanlı `_thread_tool_whitelist` içinde saklanır. Pre-tool directive işleyicisi mevcut thread'in `allowed` kümesini kontrol eder. D10 ise `ContextVar` kopyalar; D09 buna ek olarak terminal approval/sudo callback'lerini açıkça yakalayıp worker'a kurar. D09 keyfi bütün `threading.local` nesnelerini kopyalamaz.

**CROSS-SOURCE INFERENCE:** Review thread'inde kurulan whitelist ile worker içinde tüketilen whitelist arasında kontrol bağlamı süreksizliği adayı vardır. Origin'in worker'a ulaşması, whitelist'in de ulaştığına yeterli kanıt değildir. Bu, ortak pre-tool katmanı hiç yok iddiasından farklı ve daha dar bir sorundur.

**BOUNDED EXECUTED RESULT:** Üç exact modül (D09/D10/D19), sentetik callback API, sentetik profil ContextVar'ı ve sentetik thread-local allowlist ile çalıştırıldı. P01–P07 gözlemleri:

| Yol | Origin/profil işareti | Callback'ler | Sentetik allowlist |
|---|---|---|---|
| Parent olumlu kontrol | Var | Var | Var; zararsız ad reddediliyor |
| Çıplak standart pool | Bu koşuda varsayılana dönüyor | Yok | Yok |
| Gerçek daemon pool | Taşınıyor | Yok | Yok |
| Daemon pool + gerçek helper | Taşınıyor | Taşınıyor | Yok; aynı sentetik kontrol reddetmiyor |
| Worker'da açık allowlist kurulması | Taşınıyor | Taşınıyor | Kontrol tekrar reddediyor |
| Hedef exception'ı sonrası worker | ContextVar aktarımı ayrı | Callback'ler temizlenmiş | Yerel kurulum yok |
| Parent son kontrol | Değişmemiş | Değişmemiş | Değişmemiş |

P05 kasıtlı duyarlılık kontrolüdür; üretim düzeltmesi önerisi veya uygulanmış patch değildir. P06 temizlemeyi gösterir, önceki bir callback'in geri yüklenmesini değil. Deneyde hiçbir yasak araç çalıştırılmadı; yalnız zararsız bir ad bir kümeyle karşılaştırıldı.

**Sınır:** Actual PluginManager, AIAgent, tool executor, gerçek profil resolver'ı ve gerçek tool bu deneyde çalıştırılmadı. Bu nedenle sonuç 'bütün HERMES yetki kontrolleri aşılabiliyor' veya üretimde gerçekleşmiş güvenlik olayı değildir. Bir üst doğrulamada actual executor + actual whitelist işleyicisi + zararsız handler birlikte sınanmalı; handler'a ulaşmadan önce başka callsite'ın aynı kısıtı kurup kurmadığı gözlenmelidir. Diğer guardrail/approval mekanizmaları da ayrı kalır.

## 6. Timeout, exception ve telafi farklı sonuçlar

D08'in Python hook dağıtımı timeout/skipped pre-tool callback için bloklayıcı directive üretebilir. Buna karşılık yakalanan callback exception'ı loglayıp devam eden yol aynı blok üretimini zorunlu kılmaz. D04'te beklenmeyen pre-tool hata yolunun da ayrı fallback'i vardır. Dolayısıyla 'pre-tool kontrolü var' veya 'timeout fail-closed' ifadesi bütün hata türlerinin aynı politikaya sahip olduğu anlamına gelmez. Bu statik dal incelemesidir; hook hataları bu tur yürütülmedi. Shell-hook konfigürasyonu ile Python callback dalı karıştırılmamalıdır.

D04/D05'te hata yanıtı üretme ve sonuç kaydetme katmanları vardır. İncelenen generic workspace checkpoint yolu `write_file`/`patch` ve belirli terminal etkileri içindir; bundan `skill_manage` batch'i için ek dosya rollback'i türetilemez. Önceki U01B raised-exception karşı örneği henüz actual dispatch ile birlikte yeniden yürütülmedi. Dolayısıyla wrapper'ın görüldüğü, fakat bütün compensation closure'ın kurulmadığı kaydedilir.

Worker timeout/cancel sonrası `effect_disposition` gibi belirsiz etki temsilleri de önemlidir. Başlamamış işi durdurmak, başlamış worker'a iptal istemek, thread'in gerçekten bitmesi ve etkiyi geri almak ayrı olaylardır. Bu not güvenli sentetik transport deneyinden gerçek tool termination garantisi çıkarmıyor.

## 7. Araç etkisi, kalıcı transcript ve tamamlandı bildirimi

**SOURCE OBSERVATION:** D04 `_commit_tool_result` kalıcı session flush'ını `tool.completed` bildirimi öncesine koyar. Persistence failure sonraki çağrıların devamını etkileyen durum taşır. Bu, işlem sonucunun UI'ye verilmesiyle durable kayıt arasındaki ilişkiyi bilinçli biçimde kuran olumlu mekanizmadır.

**Sınır:** O noktadan önce araç etkisi gerçekleşmiş olabilir. Transcript yazılamaması fiziksel etkiyi otomatik geri almaz. Ayrıca post-tool hook ile `tool.completed` aynı bildirim değildir; hepsinin persistence sonrasında olduğunu söylemek yanlış olur. 'Etki gerçekleşti', 'sonuç kalıcılaştı', 'kullanıcıya bildirildi' ve 'tekrar denemede aynı etki üretilmeyecek' ayrı kanıt ister.

Bu gözlem, HERMES-native model için aday bir zincir verir: admission → execution → effect disposition → persistence → delivery. Henüz bütün ürünün kabul edilmiş modeli veya SOUL primitive'i değildir.

## 8. Bu birimin kapanışı ve sıradaki sınırlı soru

Kaynak erişimi engeli artık bu okunmuş nesneler için devam gerekçesi değildir. İnceleme, 05'in ilk caller sorusunu maddi biçimde ilerletti; fakat U01'in tamamını kapatmadı.

İlk yüksek değerli devam: **actual worker/executor ve actual whitelist precheck'ini zararsız hedefte birlikte izlemek**. Sonrasında [07 bellek/replay notu](07-MEMORY-STORE-AND-PENDING-REPLAY.md)'nun gerçek UI/caller profile bağını, disk/store/prompt readback'ini ve ledger/sync/curator batch raporunu bağlamak. Geniş gateway/provider/delegation/kurulum/eval aileleri korunur; bu aday boşluk sonsuz güvenlik yan dalına dönüştürülmez.

Deney yedi tanılayıcı beklentiyi karşıladı; bu sayı araştırma tamamlanma oranı veya ürün PASS'i değildir. Eski U01B koşusu tekrarlanmadı. Current HEAD/kurulu release, gerçek kullanıcı profili, gelecek-task kalite ve bağımsız araştırmacı doğrulaması yapılmadı.
