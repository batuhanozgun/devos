# Neden ECC araştırması?

**Date:** 2026-09-17. Bu dosya gerekçe/başlangıç hipotezidir; tamamlanmış ECC araştırması değildir.

## Primary question

ECC hangi işi, kimler ve hangi araç/ortam/kalıcı bilgi üzerinden koordine ediyor; hangi parçaları gerçekten çalıştırıyor, hangilerini yalnız tarif ediyor ve bunların değişim/başarısızlık/yeniden kullanım sınırları neler?

Taşınabilirlik güçlü bir başlangıç sorusudur, fakat sonucu baştan belirleyen bir tanım değildir. Araştırma ECC'yi yalnız skill kataloğu, yalnız meta-harness veya tek ve tamamlanmış bir operating system kabul etmeden aralarındaki gerçek sınırları ortaya çıkarmalıdır.

## Why this can add value

Ön taramada ortak skill/rule varlıkları ile host adaptasyonu, memory, öğrenilmiş davranış, session normalizasyonu ve ayrı operator-system yönü görüldü. Kaynaklar ve okuma sınırları [SOURCE-LEDGER](SOURCE-LEDGER.md) içindedir. Bu alanların varlığı etkililik veya birbirine tamamlanmış entegrasyon kanıtı değildir.

Mevcut kütüphane katkıları seçici kullanılır:

| Karşılaştırma zemini | ECC'ye sorulacak ek soru |
|---|---|
| gstack — implemented software workflow ve kaynak→sentez yöntemi | Benzer iş mekanizması farklı host'larda aynı sorumluluk ve kontrolü koruyor mu? |
| Hermes — runtime / skill-library yaşamı | Kaynağın sahipliği, kurulu kopya, keşif, kullanma ve öğrenmeden dönüşüm ECC'de nasıl ayrılıyor? |
| Superpowers — portable procedure / host-conditioned bootstrap | Instruction paylaşımı nerede yeterli, nerede executable davranış veya ortam desteği gerekiyor? |
| Context/memory/harness ve Carbon Layer | Kalıcı kaydın oluşması, doğru bağlama girmesi, iş state'i ve davranış değişimi arasındaki ayrımlar korunuyor mu? |
| Anthropic SDLC | Agent konfigürasyonu nasıl gözleniyor, sınanıyor ve değişikliğin etkisi nasıl doğrulanıyor? |

Bunlar eşdeğer ürünler veya birbirinden bağımsız kanıt kaynakları diye sıralanmaz. Karşılaştırma aynı mekanizma, sürüm ve analiz düzeyinde yapılır; gerekli bulgular o aşamada geri okunur.

## SOUL / Development OS connection

Araştırma, ileride ihtiyaçlara uygun çalışma sistemi oluşturma ve yönetme sorularını besleyebilir. Bunun için ECC'de neyin hazır varlık seçimi, neyin kuruluma dönüştürme, neyin aktif koordinasyon, neyin gerçekten öğrenme/uyarlama olduğunu ayırmak önemlidir. Bir harness paketi seçmek, ihtiyaçları keşfedip uygun sistemi üretmekle aynı başarı ölçütüne sahip değildir.

Foundation dört alanı ve ilişkileri sonradan karşılaştırma zemini sağlayabilir; ECC kaynaklarını daha başta bu kutulara dağıtmayacağız. Aynı şekilde araştırma üretiminin kendisi de incelenecek: doğru kaynak mevcutken neden kullanılmamış olabilir, kritik aileyi neden atlamış olabiliriz, yöntem revizyonu sonraki turda neyi gerçekten değiştirdi?

## Corrections to the initial screening frame

- Ön değerlendirmedeki yedi konu kesin ECC alt-sistemleri değildir; U01 bunları sınar.
- README/roadmap statüsü, release numarası ve code path farklı nesnelerdir. Eski bir roadmap'teki alpha/RC ifadesi tek başına bugün bütün ürünün statüsü sayılamaz.
- Haziran 2026 security roadmap'inde anılan issue'lar güncel açık güvenlik kusuru diye aktarılmayacak; tarih/issue/patch/runtime ayrıca doğrulanmalıdır.
- Dokümanda Codex veya başka host için yazan support etiketi gerçek host davranışı olarak kabul edilmeyecek; code/config/release ve gerekiyorsa resmi host kaynağıyla bağlanacaktır.
- Skill/agent/dosya sayısı sistemin bütünlüğünün, araştırma değerinin veya kapsam yeterliliğinin ölçüsü değildir.

## Two deliverables, both revisable

1. Kaynağa geri izlenebilir ECC-native mekanizma ve sistem açıklaması; sınırlı SOUL/Development OS aday değerlendirmesi.
2. Kullanılan yöntemin sürümleri, değişme gerekçeleri, başarısız/yararlı seçimleri ve açık geçerlilik sınırlarıyla yöntem vaka dosyası.

İyi örnek olma amacı olumsuz bulguları saklama, planı koruma veya yöntemi başarılı ilan etme baskısına dönüşmemeli. Sonuç ECC'nin bazı iddialarının desteklenmediği veya yöntemin bazı parçalarının çıkarılması gerektiği de olabilir.
