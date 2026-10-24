# HERMES — Zamanlanmış iş ve yeniden kurulan bağlam: dördüncü geçici sentez

**2026-09-12 / PROVISIONAL HERMES-NATIVE SUBSYSTEM SYNTHESIS.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [STATE](../STATE.md) current authority; bu dosya bağımsız kanıt, final CORE, completed cron modeli, Foundation sınıflandırması veya SOUL/Development OS benimsemesi değildir. [Synthesis01](01-LEARNING-AND-CHANGE-PROVISIONAL.md), [02](02-TURN-CONTEXT-AND-SESSION-PROVISIONAL.md), [03](03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md) korunur. U07–U10'un tek bir native açıklamada kullanılabilir olması için eklenmiştir.

## 1. Bir zamanlayıcı değil, bağlı sorumluluklar

İncelenen sistem şu zincirle açıklanabilir:

**Kalıcı iş tanımı → tetikleyicinin kurulması → belirli planlanmış çalıştırmanın kabulü → deneme ve çalışma hakkı → bilgi/çalışma bağlamı → betik veya ajan yürütmesi → çıktı ve kabul kayıtları → teslim → sonraki çalışma koşullarının yeniden kurulması.**

Bunlar tek transaction veya tek başarı bayrağı değildir. Her ok ayrı bir caller, durum aktarımı, yetki veya tüketici gerektirir. Bir halkadaki başarı diğer halkayı ispatlamaz. Aynı zamanda bu ayrımlar sistemde her şeyin bozuk olduğunun göstergesi değildir; hangi mekanizmanın hangi yükü taşıdığını gösterir. Kanıt: [U07](../evidence/2026-09-11-cron-scheduling-delivery/RESEARCH.md), [U08](../evidence/2026-09-12-cron-drain-receipts/RESEARCH.md), [U09](../evidence/2026-09-12-cron-occurrence-admission/RESEARCH.md), [U10](../evidence/2026-09-12-cron-execution-context/RESEARCH.md).

## 2. Plan, occurrence ve attempt

Job, tekrar kullanılabilen iş tanımıdır. Next-run/fire-at, belirli planlanan zamanı temsil eder. Execution ID bir kabul denemesine, owner token o anda çalışma hakkına aittir. Finite one-shot sayacı dispatch öncesinde tüketilebilir; bu yüzden “bir çalışma hakkı tüketildi” ile “başarılı rapor üretildi” ayrılır. [U07/U09]

Chronos provision'da iş+zaman anahtarıyla dış kayıt tekilleştirmesi istenir. Pinned inbound hop'larında bu kimlik job-only kabulüne daralır. Canlı claim çakışmayı sınırlayabilir; normal finish sonrasında temizlenen claim geçmiş occurrence'ı hatırlayan bir kayıt değildir. U09'un geçerli eski callback için yeni claim çıkarımı koşulludur, gerçek NAS duplicate deneyi değildir. Built-in due-scan'in zaman kapısı external direct-claim'e otomatik taşınamaz. [U09]

## 3. Çalışmak her zaman model çağırmak değildir

No-agent script, değişiklik izleyicisi ve wake gate, normal agent yolundan ayrı iş kipleridir. Sessiz başarı, o turda rapor gerekmemesi olabilir. Script başarısızlığı no_agent için iş hatasıdır; agent pre-run için modele açıklanacak veri olabilir. Bu yüzden tick sayısı, agent run sayısı ve kullanıcıya sunulan rapor sayısı aynı ölçü değildir. [U10]

Çalışma kimliğine profil, secret scope, terminal policy ve cwd eklenir. Teslim origin'i gönderici yetkisi gibi taşınmaz; cron normal agent yolunda stateless completion beyanı kullanılır. Ancak scope'un kurulma anı önemlidir: erken pre-run script'e sonraki agent workdir'inin geriye dönük uygulanması mümkün değildir. Profil ayarının varlığı da bütün tool/OS containment doğrulaması değildir. [U10]

## 4. Kalıcılık ile yeniden kullanım arasındaki seçiciler

Yeni cron ajanı, yalnız son transcript'i yeniden oynatarak devam etmiyor. İş tanımı, geçici run context, önceki output dosyası, iş not defteri, prefill, profile memory ve proje/SOUL context birbirinden farklı girdiler olabilir. Kaydın bulunması, seçilmesi ve effective model request'e girmesi ayrı olaylardır. [U10; genel model için synthesis02]

`context_from=self`, aynı job'ın en yeni output belgesini seçer; tam önceki konuşma veya başarılı çalıştırma garantisi değildir. Native selector'ın C02/C03/C04/C05 gözlemleri bunu ayırır: sessiz/boş/error yeni dosya, eski anlamlı raporun önüne geçebilir; leading-prefix kesimi Response'u dışarıda bırakabilir. Önceki rapor diskte durur. Notepad, memory veya current prompt ayrıca telafi sağlayabilir; bu deney gerçek model kalitesini ölçmez. [U10 SPEC/RESULT]

Monitor checkpoint'i de başka bir yeniden kullanım seçicisidir: yeni içerik gözlemi model/teslim başarısından önce kaydedilir. Yeniden değişmeyen içerik bastırılabilir. Bu anti-repeat tercihi, “başarıyla işlendi” watermark'ı gibi kullanılırsa anlam değişir. Kaynak gözlemi ile gerçek storage/failure challenge ayrıdır. [U10]

## 5. Sonuç üretimi ile teslim ve devam

Run tuple, execution ledger, job last-status, session end-reason, çıktı dosyası ve delivery queue farklı durumlardır. Max-iteration fallback özeti operasyonel başarı olarak taşınabilir; bunun kullanıcı işini tamamladığı ayrıca değerlendirilmelidir. Çıktı sessizlik kontrolünden önce yazılabilir; kullanıcıya gönderilmemiş belge sonraki bağlamın girdisi olabilir. [U10]

U07 native queue diagnostic'i hata-yok dönüşünün pending row ile birlikte gerçekleşebildiğini gösterdi. U08 gerçek drainer/CLI consumer bağını açtı. Ayrıca native async bridge deneyinde cancel=True önceki etkiyi geri almadı; cancel=False başarılı teslimi ispatlamadı. Bunlar exact bileşen/koşu sonuçlarıdır; gerçek platform duplicate oranı veya bütün UI hükmü değildir. [U07/U08]

Gönderim bakım döngüsünün yeniden başlaması, zamanlayıcının çalışıyor olmasıyla eşdeğer değildir. Tamamlanmış hesaplamanın yeniden teslimi ile hesaplamayı yeniden yapmak ayrı yükümlülüklerdir. Aynı biçimde run_job'ın timeout dönmesi, worker thread'inin durması veya SessionDB'nin kapanması aynı an değildir; deferred teardown gerçek worker tamamlanmasına bağlanabilir. [U08/U10]

## 6. Bu modelin gerçekten dayandığı kanıt

| Bağ | Dayanak | Taşımadığı hüküm |
|---|---|---|
| Job/register/admission/finish | Pinned source; U09 belge-kod karşı okuması | Dış NAS ve multi-process occurrence exactly-once |
| Queue persistence/unknown | U07 tam queue + gerçek temp SQLite; synthetic transport | Gerçek ağ/SessionDB/gateway restart |
| Drainer/CLI/cancel | U08 source; native async bridge + yerel etkiler | Bütün sender/fallback/mesaj teslimi |
| Run context ve erken gate'ler | U10 source caller→helper→consumer | Bütün provider/worker/OS ve semantic quality |
| Eski output seçimi | U10 tam prompt module'ünün yalnız selector işlevi, gerçek dosyalar | Gerçek ilk model request ve kullanıcı başarısı |

Sentez tablosu testleri bağımsız tekrar veya ürün puanı olarak toplamaz. U04-A/B, U06 L, U07 D, U08 B ve U10 C aynı vaka değildir. Kaynak/senaryo kapsamları kendi local ledger ve raw'larında kalır.

## 7. Bütün sistemi açıklamaya etkisi

Bu model, synthesis03'teki session goal/loop/heartbeat'i tek bir cron mekanizmasına indirgemez. Cron önceki tura devam etmek yerine yeni bir koşuyu farklı kalıcı bilgi kanallarıyla kurabilir. Ortaklıklar vardır; kimlikler, driver'lar, gate'ler ve kabul sorumlulukları eşitlenmez. Aynı AIAgent çekirdeğini kullanmak farklı host'ları eşdeğer yapmaz.

Büyük açık alan artık yalnız zamanlama değil: seçilen model/provider/API modu hangi backend tarafından gerçekten yürütülür; context ve cancellation'ın sahibi nerede değişir? Q53 bunun ilk geniş kaynak birimidir. Delegation, tool/plugin policy, skill-ledger/sync/quality, alternatif UI ve install/eval henüz tam açıklanmamıştır. Bu geçici sentez o boşlukları gizlemek için bir kapanış modeli değildir.
