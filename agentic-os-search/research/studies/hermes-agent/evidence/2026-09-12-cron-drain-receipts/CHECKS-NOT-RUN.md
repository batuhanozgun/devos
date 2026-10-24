# U08 — Yapılmamış kontroller ve yeniden açma koşulları

Bu dosya bir SPEC sonucu değildir. U08/B01–B03 yalnız tam native async köprü modülünü çalıştırır. Aşağıdaki deneyler yapılmadı.

## 1. Gerçek enclosing send consumer

Pinned `cron/scheduler_delivery.py` ve `gateway.delivery` full-source/bağımlılıklarıyla `_live_send_text`/live→standalone yolunu kur. Effect-before-ack, timeout-to-error ve normal confirmation durumlarında gerçek transport receipt ile fallback kararını kaydet. Test fake'i cancel boolean'ını kendi istediği gibi ayarlayıp sonra sonucu gerçek runtime diye sunmamalı. Güvenli local transport kullanılabilir, fakat gerçek dış kanal sonucu olduğu söylenmemeli. Herhangi bir live/provider çalışma ayrıca yetki ister.

U08 karşı örneği bu çalışmaya neden ihtiyaç olduğunu gösterir; enclosing function koşulmuş sayılmaz. Native/non-relay fallback ile relay fail-closed yolu farklıdır. Platform idempotency ve cancellation semantiği değerlendirilmeden gerçek duplicate ihtimali/olay sıklığı hesaplanmaz.

## 2. Queue → worker → job/execution → CLI uzlaştırması

Gerçek current target için aynı exact execution ID'de pending timeout, geç delivered, geç failed ve unknown geçişlerini DB kayıtları + iş özeti + CLI çıktı alanlarıyla ölç. Job'un bir sonraki run'ı old delivery ile yarışırsa hangi kaydın kime ait olduğunu ayır. U07'nin queue SQL koşusu ve U08 source CLI bağlantısı bu birleşik deney değildir. 'Last run ok' ile açık 'delivered' metinlerini aynı UI iddiası sayma.

## 3. Profile/housekeeping ve kapanış

Gerçek hosted gateway'de root/secondary, None/{}/SharedRouteAdapters, resolver failure, startup failure ve shutdown sırasında drain yolları. Thread'in varlığı liveness/latency kanıtı değildir. Upstream mocked housekeeping testlerinin call-argument oracle'ını transport-success testi sayma.

## 4. Conversation seed/mirror

Timeout nedeniyle varsayılan delivery kararının actual seed/mirror persistence'ına ulaşıp ulaşmadığını, dönen false veya exception telafilerini ve son kullanıcı reply history'sini ölç. Bu tur yalnız caller bağlantısı okundu; görünmemiş brief'in kesin DB'ye yazıldığı gösterilmedi.

## 5. Önceden açık olanlar

Q40 actual SessionDB + quiet next-request/wire; Q42 startup preclaim/carrier/drain/agent admission; Q41 rotation/migration/profile; Q43 full worker/OS/arbitrary tool effects; Q44/45 semantic quality/stop; Q07/Q22 final request; Q26/Q29 full worker; Q38 manual parent fidelity açık. U08 bunların substitute testi değildir.

## Sıralama

Q48 source bridge birimi ilerledi. Tüm bu doğrulama borçlarının kapanması broad HERMES araştırmasının ön şartı değil: ilk yeni source birimi Q47 occurrence/late callback/claim/rearm, sonra Q49 run_job/context. Bu deneyler ilgili tam-source/bağımlılık erişimi ve güvenli yürütme imkânı doğduğunda veya güçlü reliability/adoption kararı için yük taşıdığında yeniden açılır. Aynı üç B durumunu çoğaltmak yeni consumer araştırması yerine geçmez.
