# Çalışma Sistemi Sürekliliği

## Amaç

ChatGPT oturumları, model hafızası veya konuşma geçmişi değiştiğinde projenin çalışma durumunun sessizce kaybolmasını, drift etmesini veya yeni bir aktörün yanlış işi devralmasını önle.

Bu protokol, bir turun sonunda yalnız iyi bir cevap üretmenin yeterli olmadığını kabul eder. Tur; kalıcı proje bilgisini, mevcut/sonraki işi, aktör yetki ve sorumluluklarını, kullanılabilir ortam/kabiliyetleri veya bunların aralarındaki ilişkileri maddi biçimde değiştirdiyse, bu değişikliğin canonical persistent surface'e yansıtılması gerekip gerekmediği ayrıca değerlendirilmelidir.

Bu protokol `Records / Work / Actors / Environment` ayrıştırmasını ontolojik gerçek kabul etmez. Bu terimleri mevcut çalışma sistemini gözden geçirmek için pratik bir lens olarak kullanır; proje araştırması ileride bu ayrımı değiştirebilir.

## Temel İlke

> Bir substantive turun sonucu, fresh session yalnız canonical repository state'ini okuyarak doğru amacı, yetkiyi, durumu ve sıradaki sorumluluğu recover edemeyecekse çalışma kapanmış sayılmaz.

Konuşma geçmişi yararlı bağlam olabilir; canonical proje state'inin yerine geçemez.

## Ne Zaman Uygulanır

Aşağıdakilerden herhangi biri mümkünse protokolü uygula:

- yeni bir araştırma/çalışma yönü seçildi, yetkilendirildi, durduruldu veya reddedildi;
- mevcut Work state, sıradaki sorumluluk, durma noktası veya sequencing değişti;
- önemli bir bulgu, working hypothesis, open question, candidate decision veya kabul edilmiş karar ortaya çıktı;
- bir Actor'ın rolü, yetkisi, sorumluluğu, approval boundary'si veya handoff'u değişti;
- environment, tool/capability availability, repository, interface veya önemli constraint değişti;
- bir relation/control rule veya cross-boundary dependency değişti;
- mevcut canonical state artık stale, eksik veya yeni oturumu yanlış yönlendirecek hale geldi;
- yapılan repository mutation başka router/state/handoff yüzeylerini de güncellemeyi gerektirebilir.

Basit selam, teşekkür, açıklama talebi veya mevcut state'i değiştirmeyen konuşma turlarında kontrol yine routing sorusu üzerinden yapılır; confidently no ise protokol yüklenmez.

## Protokol

### 1. Turun Çalışma Etkisini Ayır

Substantive cevap veya tool işi ilerledikçe şu sınıflardan hangilerinde maddi değişiklik oluştuğunu değerlendir:

- **Persistent state / Records:** Gelecekte bilinmesi gereken yeni gerçek, karar, hipotez, handoff veya state var mı?
- **Work:** Mevcut iş, sıradaki iş, sequencing, scope, stop condition veya authorization değişti mi?
- **Actors / authority:** Kim/ne hangi rol, sorumluluk veya karar yetkisini taşıyor; bunda değişiklik oldu mu?
- **Environment / capability:** Kullanılabilir ortam, tool, repository, interface, constraint veya capability değişti mi?
- **Relations / controls:** Yukarıdaki alanlar arasındaki dependency, authority, provenance, handoff, acceptance veya transition ilişkisi değişti mi?

Bu sınıflar yalnız kontrol lensidir; proje ontolojisi değildir.

### 2. Canonical Surface'i Belirle

Değişiklik varsa önce hangi mevcut canonical yüzeyin bunu taşıması gerektiğini bul:

- current state / authority için `STATE` benzeri canonical durum dosyası;
- ayrıntılı geçiş ve cold-start bağlamı için handoff;
- retrieval yolu değiştiyse router/index;
- established research sonucuysa uygun synthesis/finding;
- yalnız working hypothesis/open question ise bunu açık epistemic statüyle uygun exploratory/handoff yüzeyinde tut.

Yeni dosya üretmeden önce mevcut canonical yüzeyin güncellenmesinin yeterli olup olmadığını değerlendir. Aynı gerçeğin birden fazla authoritative kopyasını yaratma.

### 3. Epistemik Statüyü Koru

Repository continuity sağlamak, konuşmada oluşan her fikri 'truth' yapma yetkisi vermez.

Ayrı tut:

- established finding;
- cross-source/cross-vertical inference;
- working hypothesis;
- open question;
- candidate decision;
- authorised/accepted decision;
- implementation state.

Bir çalışma hipotezini canonical handoff'a kaydetmek, onu architecture truth veya research finding yapmaz.

### 4. Yetkiyi Koru

Repository güncellemesi yeni bir substantive karar yaratmamalıdır.

Şunları ayır:

- kullanıcı tarafından zaten verilmiş karar/authorization'ın state'e işlenmesi;
- mevcut sonucu doğru biçimde kaydetmek;
- yeni araştırma/architecture/implementation kararı üretmek.

İlk ikisi continuity çalışması olabilir. Üçüncüsü ayrıca uygun owner/decision gate gerektirir.

Agent-control (`AGENT.md`, `agent/**`) mutation'ları bu protokolün otomatik sonucu değildir; onlar `AGENT.md` Mutation Rule'a tabidir ve explicit user request/approval gerektirir.

### 5. Fresh-Session Testi

Tur kapanmadan önce, maddi değişiklik oluştuysa şu testi uygula:

> Önceki konuşmayı hiç görmemiş yeni bir ChatGPT oturumu, canonical repository girişinden başlayarak doğru current purpose, established-vs-hypothesised ayrımı, authorization, current/next Work, actor/authority sınırları ve gerekli environment/capability bağlamını bulabilir mi?

Cevap hayırsa, hangi canonical yüzey eksik veya stale olduğunu belirle ve yetki dahilindeyse güncelle.

### 6. Cross-Surface Tutarlılığı Kontrol Et

Bir state/handoff/router dosyası değiştirildiğinde ilgili diğer yüzeylerin stale kalıp kalmadığını kontrol et.

Örnekler:

- `STATE` yeni araştırmayı authorised gösterirken `INDEX` hâlâ eski handoff'a yönlendiriyor mu?
- yeni handoff current direction taşıyor ama README hâlâ previous phase'i current diye tanımlıyor mu?
- current work kapanmış ama next responsibility eski kalmış mı?
- actor authority değişmiş ama work acceptance/approval route eski aktörü gösteriyor mu?

Her değişiklikte her dosyayı güncellemek gerekmez. Yalnız semantik olarak etkilenen authoritative/derived yüzeyleri değiştir.

### 7. Gereksiz Mutation'dan Kaçın

Her substantive mesaj repository write gerektirmez.

Yazma gerekmeyebilir eğer:

- konuşma yalnız açıklama/yorum sağlıyorsa;
- yeni bilgi mevcut canonical state'i değiştirmiyorsa;
- geçici düşünce henüz handoff değerinde değilse;
- repository zaten aynı state'i doğru statüyle taşıyorsa.

Ama 'küçük görünüyordu' gerekçesiyle material authorization, state transition, handoff veya next-work değişikliğini chat içinde bırakma.

## Diğer Protokollerle Ayrım

- **R01** unresolved assumption/framing'in sonucu değiştirip değiştirmediğini sınar. Bu protokol, sonuç oluştuğunda çalışma state'ine doğru yansıyıp yansımadığını sınar.
- **R03** work direction/method'un end goal'e uyumunu sınar. Bu protokol, current/next Work state'inin fresh session için recoverable olup olmadığını sınar.
- **R05** source/view fidelity'yi sınar. Bu protokol, canonical project state'in güncel ve yeterli olup olmadığını operasyonel olarak kapatır.
- **R04** verification'ın geçerliliğini sınar. Bu protokol, verified/unverified durumunun doğru state/handoff'a taşınıp taşınmadığını kontrol eder.

## Nihai Kontrol

Bu protokol yüklendiğinde tur kapanmadan önce şunları değerlendir:

1. Bu tur hangi kalıcı proje gerçeğini veya çalışma durumunu değiştirdi?
2. Current/next Work veya authorization değişti mi?
3. Actor rolü/yetkisi/sorumluluğu değişti mi?
4. Environment/capability/constraint değişti mi?
5. Bunlar arasındaki relation/control semantiği değişti mi?
6. Hangi canonical surface bunu taşımalı?
7. Epistemik statü doğru mu?
8. İlgili router/state/handoff yüzeyleri tutarlı mı?
9. Fresh session eski konuşmayı okumadan doğru devam edebilir mi?
10. Repository mutation gerekmiyorsa, bunun nedeni gerçekten state'in değişmemesi mi?

## Temel İlke

**İyi cevap üretmek çalışma sürekliliğini garanti etmez. Material state değişikliği canonical yüzeye doğru statüyle taşınmadan substantive Work kapanmış sayılmaz.**
