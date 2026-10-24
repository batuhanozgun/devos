# U06-L — Önceden sabitlenmiş süreç-içi lease ayırıcıları

2026-09-11. Bu SPEC ilk davranış koşusundan önce yazıldı. Nesne: primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` içindeki **tam** `gateway/turn_lease.py`; Git blob `1f65614e66e748ec61573aced3fa48b57ee20281`, 9,190 byte. Kaynak connector metninden materyalize edildi, tam Git blob eşleşti, henüz import/execute edilmedi.

## Kurulum ve oracle

Standart Python asyncio, tek process/tek event loop, ayrı registry instance'ları, sentetik session/routing key ve generation değerleri. Gerçek asyncio.Lock, wait_for, cancellation ve token identity kullanılır; scheduler, clock veya registry acquire/rebind/release taklit edilmez. Event/pending-count bariyerleriyle sıra kurulur; timeout değerinin hızını benchmark yapmayız. Her koşu dış watchdog ile sınırlanır. Upstream test suite, gerçek SessionDB, model, gateway host, adapter, OS restart, Kanban task veya dış etki çalıştırılmaz. Bu modülün name/path'ı araştırma import adıyla değiştirilir; içeriği byte-identical kalır.

Beklenenler kaynak incelemesinden sonra, koşu sonuçları görülmeden aşağıda sabitlenmiştir. Bu bağımsız oracle değildir; ayrı event trace + token/registry state assertions ile mekanik sözleşme sınanır. Her başarısızlık kaydedilir; sonuca göre eşik gevşetilmez.

| ID | Ayırıcı koşul | Beklenen gözlem |
|---|---|---|
| L01 | Aynı SID, iki routing key | İkinci acquire ilk release'e kadar tamamlanmaz; admit/release sırası A→B. |
| L02 | Tutulan lease üzerinde kısa timeout | Gerçek TurnLeaseTimeoutError; sonrası sentetik iş gövdesine giriş yok; ilk holder/lock korunur; waiter sayacı sıfırlanır. |
| L03 | Held parent→child rebind, her iki ID'den bekleyenler | İki isim aynı lock'a bağlanır; iki waiter da ilk sahibin arkasında ve kendi aralarında sırayla kabul edilir. |
| L04 | Yeni SID'de zaten farklı live lease | Rebind False; iki ayrı eski map/holder korunur; birleşik serialization kurulmuş sayılmaz. Bu bir transcript yarışı deneyi değildir. |
| L05 | Alanları eşit, nesne kimliği farklı token; eski token tekrar release | Sahte token release False, hakiki holder kalır; eski release successor'ı bırakmaz. |
| L06 | İptal edilmiş waiter ve max_entries=1 altında iki live lease | Waiter iptal edilir/count temizlenir; kapasite aşımı uğruna live lease evict edilmez; idle cleanup sonraki edinmede mümkündür. |
| L07 | İki bağımsız registry instance'ı, aynı SID | İkisi de kabul eder; registry'nin kendi başına süreçler arası/durable fence olmadığı görülür. Gerçek process restart değildir. |

## Hata-duyarlılığı kontrolleri

N00: tek-byte değişmiş kaynak normal kimlik denetçisinde import öncesi reddedilmeli.
N01: yalnız timeout raise kolunu `return None` yapan açık mutant L02 oracle'ında başarısız olmalı.
N02: yalnız conflicting rebind reddini kapatan açık mutant L04 oracle'ında başarısız olmalı.
Mutantlar ayrı kimlikle yüklenir; original kaynak dosyası değiştirilmez. Mutant geçerse orijinalin yeşili ilgili güveni üretmez; sonuç gizlenmez. Negatif kontroller ürün kapsamı veya bağımsız replication sayısı değildir.

## Raporlama

RESULT.json tüm case/trace/assertion ve exception ayrıntıları, UTC/Python/SQLite-dışı kapsam, exact source/probe/SPEC hash'lerini taşır. stderr/log ve stdout saklanır. Bu SPEC previous U05 CHECKS-NOT-RUN'daki actual-DB/history veya whole-process restart kontrollerini tamamlamaz; yalnız yeni ayrılan süreç-içi mekanizmayı sınar.
