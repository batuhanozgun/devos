# Canonical Çalışma Preflight'ı

## Amaç

Yeni bir ChatGPT oturumu, yeni bir çalışma fazı veya canonical repository state'ine bağlı substantive bir iş başlatılırken, araştırma/analiz/karar/repository çalışmasının yanlış, eksik, stale veya yalnız konuşma hafızasından recover edilmiş bir state üzerinden başlamasını önle.

Bu protokolün amacı continuity'yi sonradan test etmek değildir. Amaç **gerçek Work başlamadan önce doğru çalışma durumunu yüksek güvenle recover etmek ve materially tutarsız durumda fail closed etmektir.**

## Temel İlke

> Canonical state güvenilir biçimde recover edilmeden substantive Work'e başlama.

Bir oturumun hızlı biçimde makul görünen bir cevaba ulaşması; doğru current purpose, authorization, epistemic status, current/next Work ve gerekli source depth'in gerçekten yüklendiği anlamına gelmez.

## Ne Zaman Uygulanır

Aşağıdakilerden biri söz konusuysa bu protokolü uygula:

- yeni conversation'da substantive proje işi başlayacaksa;
- yeni bir araştırma/çalışma fazı veya handoff devralınıyorsa;
- mevcut iş repository state, handoff, authorization veya önceki çalışma sonuçlarına materially bağlıysa;
- uzun/karmaşık bir çalışma akışında current state'in yeniden recover edilmesi gerekiyorsa;
- repository mutation'ları current router/state/handoff yüzeylerini değiştirdiyse ve sonraki substantive adım yeni state'e dayanacaksa;
- kullanıcının verdiği yeni prompt mevcut canonical state ile birlikte okunmadan doğru biçimde yorumlanamayacaksa.

Basit açıklama, selam, mevcut cevabın küçük bir devamı veya canonical project state'e bağlı olmayan konuşma için confidently no ise protokol yüklenmeyebilir.

## Protokol

### 1. Control Bootstrap'ın Tam Olduğunu Doğrula

Önce canonical `AGENT.md` bootstrap'ının ve routing gate'in tamamlandığını doğrula.

Bu protokol agent-control bootstrap'ının yerine geçmez.

Gerekli bir control dosyası okunamıyorsa substantive proje işine başlama.

### 2. Current Project Entry Surface'ini Bul

Project-work layer içinde current state ve retrieval yönünü taşıyan canonical yüzeyleri belirle.

Tercih sırası:

1. current `STATE` / status / current-work yüzeyi;
2. current `INDEX` / router;
3. current handoff / next-responsibility yüzeyi;
4. aktif work/research package veya phase-specific entry file;
5. gerektiğinde domain/context router'ları.

Dosya adlarını evrensel varsayma. Repository'nin kendi current router'ını takip et.

Historical, exploratory veya superseded yüzeyi current authority gibi kullanma.

### 3. Mandatory Reads'i Eksiksiz Yap

Current router/handoff hangi dosyaları mandatory, required, full-read veya preflight material olarak belirtiyorsa substantive reasoning'den önce onları **tam canonical içerikleriyle** oku.

Özet, excerpt, search result, prior-session memory veya conversation summary mandatory full read'in yerine geçmez.

Bir mandatory yüzey decision-critical ayrımı korumuyorsa ilgili retrieval router üzerinden daha derine in.

### 4. Current State'i Recover Et

En az şu soruların cevabını canonical project state'ten çıkar:

- Şu anki end goal / current purpose nedir?
- Hangi Work tamamlandı, hangisi current, hangisi next?
- Current authorization ve stop boundaries nelerdir?
- Kim/ne hangi Actor rolü/yetkisi/sorumluluğunu taşıyor?
- Hangi environment/capability/constraint'ler materially geçerli?
- Established finding, inference, working hypothesis, open question, candidate decision ve accepted decision ayrımı nasıl?
- Hangi source/retrieval depth mevcut görev için yeterli; nerede daha derine inmek gerekir?

Bu başlıklar kontrol lensidir; proje ontolojisi olarak dayatılmaz.

### 5. Cross-Surface Consistency Check Yap

Current `STATE`, router/index, handoff, active work package ve gerekiyorsa context surfaces arasında şu konularda materially conflict olup olmadığını kontrol et:

- current phase;
- authorization;
- next responsibility;
- epistemic status;
- stop condition;
- current vs historical/superseded surface;
- source freshness / exact-target binding gerektiğinde.

Material conflict varsa bir yüzeyi sessizce seçip devam etme.

Önce conflict'in mevcut canonical hierarchy ile çözülebilir olup olmadığını kontrol et. Çözülemiyorsa fail closed: affected substantive Work'i durdur ve conflict'i açıkça bildir.

### 6. User Prompt'u Canonical State ile Birleştir

Kullanıcının yeni mesajını tek başına çalışma tanımı sayma.

Prompt'u recovered current purpose, authorization, existing results, handoff ve stop boundaries ile birlikte yorumla.

Kullanıcı yeni bir yön/authorization veriyorsa bunu R07 continuity kontrolüyle kapanması gereken potential state transition olarak değerlendir.

### 7. User-Visible Orientation Checkpoint

Yeni conversation'da veya material phase/handoff devrinde, ilk substantive response araştırma/analiz sonucuna atlamadan önce kısa ve denetlenebilir biçimde şunları göstermeli:

- hangi canonical project surfaces'in full read edildiği;
- recovered current purpose / authorization / next responsibility;
- mevcut görevde established olanla hypothesis/open olanın temel ayrımı;
- materially sabitlenmemesi gereken framing/assumption/rival seçenekler;
- varsa conflict veya access failure.

Bu orientation checkpoint kullanıcıdan projeyi tekrar anlatmasını istemek için değildir. Repository coherent ise doğrudan authorised Work'e devam edilir.

Aynı conversation içinde current state değişmediyse bu checkpoint'i her mesajda tekrar etme.

#### EXP-006 — kalıcı kısa iletişim sınırı

Kullanıcının EXP-006 için açık kalıcılık talebiyle 27 Eylül 2026'da eklendi. Yetki izi: `explorations/EXP-006-development-os-calisma-duzeni/sources/U002-cloud-plan-and-autonomy.md`, U002-A. Bu atıf kaynak kaydıdır; bütün project-work dosyalarını agent-control'a dönüştürmez.

EXP-006'yı devraldıktan sonra bu çalışmanın kullanıcıya dönük cevaplarında:

- Önce sonucu veya yapılan değişikliği doğrudan ver; sonra yalnız kararı etkileyen belirsizliği ve mevcut plandaki tek devam noktasını ekle.
- Varsayılan olarak birkaç kısa paragraf veya küçük bir tablo yeterlidir. Olağan ilerleme cevabını yaklaşık 150–250 kelimenin altında tut; bu bir doldurulacak uzunluk hedefi değildir. Kullanıcı daha kısa istiyorsa daha kısa yaz.
- İç değerlendirmeyi, bütün alternatiflerin tartışmasını, protokol açıklamalarını veya geçmiş çalışmanın tamamını uzun anlatı olarak kullanıcıya yükleme. Kullanıcı açıkça ayrıntılı açıklama/denetim isterse gerekli kapsamı aç.
- Maddi belirsizlik ve kanıt sınırını sırf kısaltmak için silme; gerekli okuma ve analiz derinliğini azaltma. Ayrıntılı bulgu ve kaynak izini uygun repository yüzeyinde koru; kullanıcıya her seferinde tekrar okutma.
- AGENT'in zorunlu routing disclosure'ını koru; bunu uzun gerekçe veya tekrar eden yön anlatısıyla genişletme.

Bu dar kapsamlı iletişim değişikliği EXP-006 dışında yeni bir çıktı politikası, epistemik kural değişikliği veya araştırma/mimari yetkisi getirmez.

### 8. Fail-Closed Kuralı

Şunlardan biri varsa affected substantive Work'e başlama:

- mandatory canonical file erişilemiyor;
- current authorization çözülemiyor;
- state/router/handoff materially conflict ediyor ve hierarchy ile çözülemiyor;
- required source depth recover edilemiyor;
- kullanıcı prompt'u mevcut canonical state ile açıkça çelişiyor ve hangisinin authoritative olduğu belirlenemiyor.

Bu durumda varsayım üretip ilerlemek yerine eksik/conflict'i bildir.

### 9. Hız Değil Gerekli Güven

Preflight'ı sırf cevap hızlı olsun diye kısaltma.

Ancak her şeyi de körlemesine okuma. Repository'nin progressive retrieval düzenini kullan:

- mandatory entry surfaces full read;
- bounded question için yeterli current retrieval depth;
- decision-critical ayrım ortaya çıktığında deeper source recovery.

Amaç minimum token değil, **minimum yeterli canonical context**.

## R05 ve R07 ile Ayrım

- **R05 Source–View Fidelity:** Bir summary/view/retrieval yüzeyinin source'u yanlış veya eksik temsil edip etmediğini sınar.
- **R07 Work-System Continuity:** Bir turun sonunda material state değişikliğinin canonical surface'e doğru taşınıp taşınmadığını kapatır.
- **Bu protokol:** Substantive Work başlamadan önce current canonical state'in doğru biçimde recover edilip edilmediğini ve entry conditions'ın güvenli olup olmadığını sınar.

Birlikte şu halkayı oluştururlar:

`canonical state → fail-closed preflight → substantive Work → continuity closure → updated canonical state`

## Nihai Kontrol

Bu protokol yüklendiğinde substantive Work başlamadan önce şunları değerlendir:

1. Current project entry surfaces'i buldum mu?
2. Mandatory full reads tamamlandı mı?
3. Current purpose, authorization ve next responsibility net mi?
4. Established vs hypothesis/open ayrımı recover edildi mi?
5. Material Actors/authority ve Environment/capability constraints biliniyor mu?
6. State/router/handoff surfaces coherent mi?
7. Decision-critical claim için gereken source depth yeterli mi?
8. User prompt current canonical state ile birlikte yorumlandı mı?
9. Orientation checkpoint gerekiyorsa görünür biçimde verildi mi?
10. Bir conflict/access failure varsa gerçekten fail closed ediyor muyum?

## Temel İlke

**Gerçek çalışma continuity testi değildir. Canonical state önce recover ve doğrulanır; substantive Work ancak entry conditions güvenliyse başlar.**
