# U01 — Deneyimden kalıcı bellek ve beceriye geçiş

**Tarih:** 2026-09-07. **Snapshot:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.  
**Statü:** SOURCE-GROUNDED PARTIAL MECHANISM NOTE. Review/guard/approval kesiti incelendi; bütün öğrenme ailesi tamamlanmadı.  
**Kaynak rotası:** [SOURCE-LEDGER](../SOURCE-LEDGER.md), H03–H10 ve H13. Burada geçen semboller belirtilen pinned dosyaya geri giriş noktalarıdır.

## 1. İnceleme sorusu ve bulunan dar mekanizma

Bir konuşmanın ardından HERMES neyi 'öğrenme' diye kalıcı hale getiriyor, bunu hangi yetki ve kanıtla yapıyor, sonraki çalışmaya nasıl taşıyor?

**Gözlenen çekirdek:** `agent/background_review.py` bir conversation snapshot'ını ayrı AIAgent örneğinde yeniden işler. Bu örnek bellek ve beceri düzenleme işi için kurulmuştur; ana konuşmanın kaydını olduğu gibi sürdürmek için değildir. Yine de ana oturumla bazı kimlikleri, cache'i ve built-in memory store'u paylaşır. Bu nedenle 'ayrı ajan' ifadesi tek başına bağımsızlık veya tüm durumların ayrılığı anlamına gelmez. [H04: `build_cache_parity_fork`, `_fork_init_kwargs`, `_run_review_fork`]

Araştırma zinciri şu anda böyle görünür:

```text
turn/trigger                    henüz tam izlenmedi
  → konuşma snapshot'ı          review girişinde görünür
  → model/context seçimi        doğrudan kod okundu
  → aday memory/skill değişikliği prompt + izinli araçlar görünür
  → köken/sahiplik/okuma kontrolü guard kodu okundu; mutator zinciri açık
  → doğrudan yazma veya pending  gate/store/komut kodu okundu
  → asıl apply + ledger         çağrı hedefleri bulundu; implementation closure açık
  → sonraki session/skill load  belge kontratı; ilgili kod yolu açık
  → daha iyi sonuç              bu okumada doğrulanmadı
```

Bu ayrım, bir metnin değişmiş olmasını başarılı öğrenme sonucu olarak kabul etmeyi engeller.

## 2. Aynı model ve başka model farklı kanıt görünümü alabiliyor

**OBSERVATION:** Aynı-model fork'u ebeveynin runtime, cached system prompt, toolset yapılandırması ve bazı request seçeneklerini taşır. Farklı auxiliary modele yönlendirilmiş yolda `_digest_history` yakın geçmişten varsayılan 24 mesajı korur; başlangıcın tool-result olmaması için bu kuyruğu gerektiğinde uzatır. Daha eski user metnini 300 karakter, assistant metnini 200 karakterle sınırlar; tool çağrılarının isimlerini alır, eski tool sonuçlarının gövdelerini bu digest'e taşımaz. Bu, kaynakta görülen deterministik seçim/kısaltmadır. [H04]

**INFERENCE:** İkinci modelle karşılaştırma yalnız 'farklı değerlendirici' değişkenini değiştirmiyor; görülen kanıt da değişebiliyor. Maliyet yararı veya aynı bilgi yakalama kalitesi ancak uygun deneyle değerlendirilir. Dokümandaki performans/benzer capture anlatımı bu tur bağımsız doğrulanmadı. Daha küçük görünümün hangi dersleri kaybettirdiği açık sorudur. [H03, H04]

Runtime çözümleme başarısız olursa parent'a dönüş kodu vardır. Dolayısıyla auxiliary modelin ayarlanmış olması, her review'un o modelde gerçekleştiği gözlemi değildir.

## 3. Görünen araçlar ile gerçekten izin verilen çağrılar ayrılıyor

**OBSERVATION:** Cache parity için fork'un reklam edilen tool şeması parent'la benzer tutulur; `_review_tool_whitelist` ve `_run_review_fork` ayrıca dispatch tarafında whitelist kurar. Varsayılan küme, flags'e bağlı memory/skills ile `read_file`/`search_files` içerir. `write_file`, genel `patch`, terminal, mesaj gönderme ve delegation varsayılan review kümesine dahil edilmez. Profile config seçili `extra_tools` ekleyebilir; bu, mevcut parent araçlarının ötesinde yeni tool tanımı yaratmaz. [H04]

**TEST SOURCE INSPECTED:** H09 constructor'a parent toolset ayarlarının verildiğini ve kurulan whitelist'in olumlu/olumsuz üyelerini yakalar. `read_file` için full read'in mark bırakması, partial read'in bırakmaması ve foreground okumaların review mark'ı sayılmaması da test edilir.

**Sınır:** Testlerin ilk kısmı mock ile kurulan parametre/kümeyi yakalar; bütün gerçek dispatch yollarını yürütmez. Bu tur ana tool-dispatch/plugin gate zinciri tam okunmadığı için 'her kaçış engellenir' sonucu verilmez. Ayrıca H13 bu tür in-process kontrolleri adversarial containment sınırı olarak kabul etmez. Kooperatif iş sınırı ile OS izolasyonu ayrı değerlendirilmelidir.

## 4. Fork izolasyonu seçici: transcript ayrılıyor, bazı depolar ortak

**OBSERVATION:** Fork `skip_memory=True` ile oluşturulur; dış memory plugin'in review harness'ini gerçek kullanıcı namespace'ine yazma riskine karşı bu yol ayrıştırılır. Ardından built-in memory store parent'tan bağlanır. `_persist_disabled`, session-JSON ve end-session-on-close flags; `_session_db=None`; compressor'ın session bağını ayırma kodu vardır. Compressor ayırma başarısızsa compression kapalı bırakılır. Buna karşılık review kullanım maliyeti parent'ın auxiliary usage kaydına bilinçli olarak aktarılır. 'Hiç DB etkisi yok' demek doğru değildir. [H04: `_detach_fork_compression`, `_record_review_usage_to_parent`]

Sonlandırmada yalnız fork clients serbest bırakılır; paylaşılan session ID üzerinden parent'ın terminal kaynaklarını kapatabilecek genel close yolundan kaçınılır. Bu doğrudan implementation niyetidir; bütün hook/provider varyantlarında yan etki yokluğu henüz doğrulanmadı.

**INFERENCE:** İzolasyon en az transcript, session yaşam döngüsü, mutable store, araç etkisi ve kullanım kaydı düzeylerinde ayrı sorulmalı. Tek 'isolated' etiketi yeterli açıklama değildir.

## 5. Sahiplik ile yazmadan önce okuma aynı kontrol değil

**OBSERVATION:** H06 ContextVar üzerinde `foreground` / `background_review` kökenini taşır. Bu etiket kişi kimliği veya bütün kullanıcı onayları modeli değildir; regular cron/subagent da burada foreground kategorisine girebilir.

H05'in autonomous write guard'ı pinned, dış, bundled/hub ve kullanıcıya ait becerileri kontrol eder. Curator-managed ownership kaydı olmayan/missing/null hedefler otomatik olarak review-owned kabul edilmez; sahiplik doğrulanamazsa ilgili koruma reddeder. Buna karşılık genel pinned guard foreground düzenlemeyi değil silmeyi kısıtlar. İki kipin kuralı farklıdır. [H05: `_background_review_write_guard`, `_pinned_guard`]

Read-before-write kontrolü review'a ait bir resolved-path kümesi tutar. Önceki konuşmada metnin bulunması yeterli sayılmaz. Bu guard'ın kendi kaydı içerik hash'i veya sürümünü bağlamaz. **Buradan tüm sistemde bir yarış açığı kanıtlandığı sonucu çıkmaz:** mutator'ın exact matching, kilit, ledger ve replay mekanizmaları ayrıca okunmalıdır. [H05: `_BackgroundReviewReadMarks`, `_background_review_read_before_write_guard`; H09]

Autonomous consolidation delete için `absorbed_into` hedefi istenir. Bir yönlendirme hedefinin varlığı, bütün önemli içeriğin semantik olarak korunduğunun kanıtı değildir; gerçek consolidation ve geri alma ayrı inceleme gerektirir. Organizasyon mirror'ına düzenleme/proposal yolunun bulunması da skill değişiminin yalnız yerel dosya işlemi olmadığını gösterir. [H05]

## 6. Yazma onayı gerçek bir ayrım; varsayılan olarak açık bir engel değil

**OBSERVATION:** H07'de `write_approval_enabled` geçerli true konfigürasyonu yoksa false döndürür; config exception durumunda da false. `evaluate_gate` false olduğunda allow verir. True olduğunda skills ve background writes pending'e gider; foreground memory için interactive callback varsa approve/deny, yoksa veya uygun yanıt alınamazsa staging vardır. Bu, bir preference gate'inin mevcut contract'ıdır; genel güvenlik sertifikası değildir.

**TEST SOURCE INSPECTED:** H10 varsayılan gate-off, geçersiz değer, doğrudan bellek yazımı, inline approve/deny, invalid parametrelerin staging öncesi reddi ve approve-all gibi belirli davranışları sınayan kod içerir. Bu tur bu testler çalıştırılmadı. Test yorumunun bir varsayılanı 'safe' diye adlandırması bizim güvenlik hükmümüz değildir.

Pending kaydı payload, origin, tarih ve summary taşır. H08'in `_apply_one` yolu memory için `apply_memory_pending`, skill için `apply_skill_pending` çağırır. Başarılı sonuçta pending kaydı silinir; başarısız olanlar kullanıcıya ayrı rapor edilir. `skill_pending_diff` diff'i o anda diskteki içeriğe göre üretir. Henüz okunmamış apply implementasyonunun sürüm/köken kontrolünü yaptığı veya yapmadığı varsayılmayacak. [H07, H08]

**Yerel failure-path gözlemi:** H07 `stage_write`, diske yazma hatasını logladıktan sonra yine oluşturduğu record'u döndürüyor. Kod yorumu bunu hiçbir şeyin sessizce commit edilmemesi olarak gerekçelendiriyor. Bu yolun kendi içinde record döndürmesi, pending kaydının gerçekten kalıcı olduğuna kanıt değildir. Gerçek disk arızası koşulunu burada üretmedik; tüm kullanıcı yüzeylerinin bunu nasıl rapor ettiği de henüz bilinmiyor. Dar sonuç: **yetkisiz değişiklik yapmama ile devam edilebilir kayıt bırakma farklı başarı ölçütleri**.

## 7. Canlı işe öncelik, maliyet ve gözlenebilirlik

H04'te yeni live turn review cancellation ister ve request-completion için iki saniyelik bounded bekleme kullanır; acknowledgment gelmezse warning ile foreground devam eder. Bu liveness tercihi eski worker'ın kesin sonlandığı veya ortak depoya artık dokunmadığı garantisi değildir. Trigger/caller ve store synchronization devam işi olarak açıktır.

Kaynakta 16 iteration ve varsayılan 600.000 aggregate input-token review bütçesi tanımlanır; enforcement'ın conversation loop'taki yolu bu tur okunmadı. Notification düzeyi, review işlemini kapatmakla aynı şey değildir. Eylem özeti eski transcript tool sonuçlarını yeni değişiklik diye göstermemeye çalışır. Fakat bir tool'un success cevabını raporlamak, üretilen dersin doğruluğunu ölçmez. [H03, H04]

## 8. Öğrenme kalitesi: araştırılacak gerilim

Review prompt'u class-level, yeniden kullanılabilir prosedürleri; transient hataları kalıcı yasaklara dönüştürmemeyi; çözülememiş denemeleri çalışır yöntem diye kaydetmemeyi ister. Bunlar değerli task-contract ayrımlarıdır. Aynı prompt, çoğu oturumda bir güncelleme yapmayı kuvvetle teşvik eder; no-op'u kaçırılmış öğrenme olarak çerçeveler, fakat gerçekten sinyal yoksa veya hedef protected ise kayıt yapmama yolunu da açık bırakır. [H04]

**HYPOTHESIS:** Güncelleme baskısı gereksiz kural, aşırı genelleme veya kullanıcı tercihini doğruluk ölçütüyle karıştırma riski yaratabilir. Kod metni bu riskin gerçekleştiğini veya gerçekleşme oranını kanıtlamaz. Sonraki araştırmada update sayısı, metadata/provenance ve gerçek gelecek-task başarısı birbirinden ayrılmalı; varsa eval/rollback/curator evidence okunmalıdır.

Bu kaynak kümesinde 'bir skill güncellemesi sonraki işte gerçekten yararlı oldu' iddiasını doğrulayan bağımsız performans deneyini incelemedik. Bu ifade repository'nin hiçbir yerinde böyle kanıt bulunmadığı iddiası değildir.

## 9. Bounded sonuç ve devam

İlk kaynak kesiti HERMES'in yalnız 'hatırla' prompt'u kullanmadığını gösteriyor: review örneği, selective persistence, origin/ownership, read-before-write, pending approval ve kullanıcıya değişiklik gösterme mekanizmaları var. **Bunların varlığı başarılı veya güvenilir öğrenme döngüsünün tamamlandığını göstermiyor.**

Sonraki kaynak adımı: trigger/caller + gerçek tool-dispatch → mutator/apply → provenance/ledger/geri alma → sonraki yükleme. Ardından curator, paylaşım ve eval yüzeyleri. Böylece bu not üst senteze yalnız savunabildiği ayrımları taşıyacak; açık halkaları varsayımla kapatmayacak.
