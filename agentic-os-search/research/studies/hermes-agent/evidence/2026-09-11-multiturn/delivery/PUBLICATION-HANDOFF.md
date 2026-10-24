# U04 — Yayın durumu ve devralma

## Gerçek durum

U04 kaynak incelemesi ve yeni G01–G12/H01–H09 koşusu üretildi. Yeni araştırma,
SOURCES, SPEC, ham sonuç, kod ve üçüncü provisional sentez bu teslimdedir.
**GitHub'a yeni commit/ref yazılmadı.** Tool discovery'de create_tree/create ve
ilgili writer görünmedi; tam keşif 48 okuma eylemi gösterdi. Kurulu GitHub plugin'i
etkin bulundu. Çalışma ortamında `gh` bulunmadı; git komutunun bulunması bağlı yazma
oturumunun varlığı sayılmadı. Ayar, izin veya kimlik bilgisi değiştirilmedi.

Bu tur `Resource not found` döndüren gerçek bir create_file çağrısı yapılmış gibi
raporlanmamalıdır: geçerli yazma eylemi yüzeye çıkmadığından çağrı oluşturulmadı.
Kesin backend kök neden bilinmiyor. Önceki turların yazma başarı/başarısızlıkları
bu turun sonucu yerine geçirilmez.

## Canonical taban ve kapsam

Başlangıç main `13e00420d27547998475ac3d1bcd0d4a492f2229`, HERMES v0.15.
Sonraki okuma `e335438fb1cf97539c429c585775cd84394eb3b0`; compare sonucu beş commit
ve yalnız Foundation dosyaları gösterdi. Bu nedenle hazırlık, HERMES mevcut-dosya
blob kimliklerini koruyan ileri bir main üzerinde de uzlaştırılabilir. Main ref'i
önceden bilinen eski ağaçla değiştirilmemelidir.

Yalnız `research/studies/hermes-agent/**` ve CATALOG'da HERMES satırı değişebilir.
Önceki evidence/not/synthesis dosyaları silinmez veya düzenlenmez. Yeni 18 notu,
03 provisional sentezi ve 2026-09-11-multiturn paketi eklenir; state/plan/meta/
questions/source-ledger/index ile HERMES catalog row güncellenir.

## Makinece denetlenebilir hazırlık

`publication_manifest.json` mevcut dosyaların beklenen Git blob kimliklerini,
7 project-work dosyasının güncelleme yöntemini ve bütün yeni payload dosyalarını
listeler. `prepare_repository.py /path/to/clone` varsayılan olarak yalnız kontrol
eder ve planı raporlar. `--apply` yerel clone dosyalarına yazar; commit/push yapmaz.
Bütün kontroller mutation'dan önce yapılır. Bir HERMES hedefi değişmişse veya yeni
hedef zaten varsa güvenli biçimde durur; farkların owner tarafından yeniden
uzlaştırılması gerekir. Bu script gerçek bir GitHub yayını değildir.

Bağlı writer geri geldiğinde aynı manifestten tree/commit kurulabilir. Önce HEAD,
ilgili mevcut içerikler ve semantic conflict kontrolü; sonra candidate diff;
sonra non-force ref ilerlemesi; sonra main ref ve bütün hedef blob/content
readback. Başarı yalnız bu son gerçek kayıtla söylenebilir. Paket SHA kontrolleri
transfer doğrulamasıdır, yeni HERMES davranış koşusu değildir.

## Yeni oturum için ilk iş

Bu paket henüz main'de değilse ilk iş yayın uzlaştırmasıdır; yeni araştırma dilimine
atlayıp U04'ü kaybetme. Paket içindeki v0.16 aday metinleri main'deki current state
ile karıştırma. Yayın kapandıktan sonra teknik devam actual SessionDB/state_meta,
parent→child session aktarımı ve host reactivation'dır; yeni plan bu sınırı taşır.
