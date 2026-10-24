> **30 Eylül 2026 — aktif araştırma programı; DevOS kurulum talimatı değildir.** Bu girişteki okuma sırası, “global current authority” ve “güncel/sonraki iş” ifadeleri yalnız ChatGPT'nin bu terim araştırmasını yürütmesine ilişkindir. Claude Code ve DevOS ekibi burayı bilgi kaynağı olarak salt okunur kullanır; buradaki `AGENT.md` / protokol yükleme yönünü kendi kontrol talimatı saymaz.
>
> Araştırmanın kendi yetki, yöntem ve tamamlanma durumları korunur; bu alan tarihsel veya tamamlanmış ilan edilmez. DevOS kurulum yönü [D030](../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri) ve [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) üzerinden; bu bakımın devamı [depo bakım planından](../REPOSITORY-TRANSITION.md) alınır. Aşağıdaki özgün metin değiştirilmeden korunmuştur.

---

# Concepts — Araştırma Bazında Terim Çıkarımı ve Ortak Referans

Bu alan 2026-09-19 konuşmasıyla sıfırdan başlatıldı. Eski concepts listesinin, yönteminin veya tanımlarının devamı değildir. Studies araştırmaları kendi yerinde korunur; burada önce her araştırmanın terim/jargon kullanımları kendi bağlamında çıkarılır, bütün çıkarımlar tamamlanınca ayrı bir ortak değerlendirme yapılır.

## Yeni oturumda giriş

Önce repository kökündeki AGENT.md ve tetiklenen protokoller. Ardından aşağıdaki dosyaları tam oku:

1. [STATE.md](STATE.md) — güncel aşama, yazma/çalışma yetkisi, gerçek durum ve tam devam noktası.
2. [CHARTER.md](CHARTER.md) — amaç, iki riskin nedenleri, kapsam ve başarı ölçütü.
3. [ORIGIN.md](ORIGIN.md) — bu yeni çalışmanın kullanıcı kaynak talebi ve hazırlık yetkisinin bağlamı; tarihsel kaynak kaydı.
4. [METHOD.md](METHOD.md) — okuma/çıkarım/yorum izleme yöntemi, pilot değerlendirmeleri ve aşama geçiş koşulları.
5. [PLAN.md](PLAN.md) — repo hazırlığı ile yürütmenin ayrı planları; pilotlar, kalıcı düzen ve seri çıkarım sırası.
6. [SETUP-REVIEW.md](SETUP-REVIEW.md) — hazırlığın tarihsel kontrol kapsamı, korunmuş alanlar ve doğrulama sınırları.
7. [SCOPE.md](SCOPE.md) — kaynak-sürümlü seri kapsam, paket/alt çalışma/taşınma ilişkileri, sıra ve değişiklik takibi.

Sonra STATE'in gösterdiği etkin paketin READING.md ve TERMS.md dosyalarını tam oku. İlgili study'nin güncel META/STATE/INDEX'i, gerçek dosya envanteri ve gereken kaynak derinliği devralınır. Katalog, çalışma özeti veya dosya sayısı tam araştırma okuması sayılmaz. Aynı konuşmada tam ve değişmemiş kaynakları mekanik tekrarlama; yeni oturumda gerekli gerçek içerikleri geri kazan.

## Rolleri karıştırma

ORIGIN kaynak taleptir; CHARTER amaç konsolidasyonudur; METHOD çalışma yöntemi ve değerlendirme kaydıdır; PLAN aşama sırasıdır; STATE global current authority'dir; SCOPE kaynak evreni ve sahipliktir; SETUP-REVIEW tarihsel hazırlık kontrolüdür. Yerel READING paket okuma/aktarım durumunu, TERMS ise kullanımları taşır. Hiçbiri ortak kabul edilmiş terim tanımı veya mimari kararı değildir. Bu alan project-work layer'dır, agent-control değildir.

Global güncel iş STATE'den alınır. Bir dosyanın veya yöntem sürümünün varlığı, bütün seri çıkarımın yapıldığı, yöntemin bağımsız doğrulandığı veya ortak referansın oluştuğu anlamına gelmez. ORIGIN/SETUP-REVIEW içindeki pilotlar henüz başlamadı ifadeleri hazırlık checkpoint'ini anlatır; bugünkü next değildir. SCOPE'un başlangıç durumları da yerel current READING'nin yerine geçmez.

## Mevcut seri kayıtlar

[SCOPE.md](SCOPE.md) artık oluşturulmuştur. Kaynak ağacı ve bütün kapsamın sahipliği burada; her paketin yaprak dosyaları kendi READING envanterinde açılır. Global kapsamı bilmek bütün dosyaları okumuş olmak değildir.

| Paket | Yerel durum ve kaynak hesabı | Bağlamlı kullanımlar |
|---|---|---|
| context-memory-harness-engineering | [READING.md](studies/context-memory-harness-engineering/READING.md) | [TERMS.md](studies/context-memory-harness-engineering/TERMS.md) |
| superpowers | [READING.md](studies/superpowers/READING.md) | [TERMS.md](studies/superpowers/TERMS.md) |
| ai-knowledge-strategies | [READING.md](studies/ai-knowledge-strategies/READING.md) | [TERMS.md](studies/ai-knowledge-strategies/TERMS.md) |
| multi-agent-patterns | [READING.md](studies/multi-agent-patterns/READING.md) | [TERMS.md](studies/multi-agent-patterns/TERMS.md) |
| anthropic-ai-native-sdlc-playbook | [READING.md](studies/anthropic-ai-native-sdlc-playbook/READING.md) | [TERMS.md](studies/anthropic-ai-native-sdlc-playbook/TERMS.md) |
| gstack | [READING.md](studies/gstack/READING.md) | [TERMS.md](studies/gstack/TERMS.md) |
| hermes-agent | [READING.md](studies/hermes-agent/READING.md) | [TERMS.md](studies/hermes-agent/TERMS.md) |
| ecc | [READING.md](studies/ecc/READING.md) | [TERMS.md](studies/ecc/TERMS.md) |

Bu tablo yalnız gerçekten oluşturulmuş kayıtları gösterir; paketin tamamlandığı anlamına gelmez. Kalıcı kayıtları henüz oluşturulmamış paketlerin sırası SCOPE'dadır. Kapanış veya kısmi durum ilgili READING'den alınır.

B4'te kararlaştırılan yerleşim korunur: concepts/studies/<araştırma-yolu>/READING.md ve TERMS.md. READING gerçek okumayı ve kaynak tarafından kapsam kontrolünü; TERMS bağlamlı kullanımları, ilişki görünümünü ve yorum değişikliklerini taşır. Büyük kayıtlar girişleri korunarak bölünebilir.

Pilotların özgün içerikleri konuşmadadır. Kalıcı aktarımda görünür çıktılar ve bütün ek/düzeltmeler kaynak sürümüne karşı kontrol edilir; erişilemeyen eski yanıt STATE özetinden uydurulmaz. Pilot kapanışını yeniden bütün araştırmayı başlatma nedeni yapma; gereken kaynak/çıktı recovery'sini METHOD ve yerel READING'ye göre yürüt.

## İki çalışma riski

Batu okuma anındaki anlam seçimlerini denetleyemediği için önemli yorumlar, belirsizlikler ve değişiklikler görünür olmalıdır. Aynı sözcükle aynı anlamın kastedildiği varsayılamaz; kullanıcı onayı, kaynak kullanımı ve assistant yorumu teknik doğruluk yerine geçmez. Bu nedenlerin her concepts turunda kısa hatırlatılması kullanıcı talebidir; davranışsal uygulama R09'un concepts bölümündedir.

## İlişkili kütüphane

[Studies girişine](../research/studies/INDEX.md) ve [kataloğa](../research/studies/CATALOG.md) dön. Bu program ayrı bir study satırı üretmez; özgün araştırma paketlerinin bulgularını, tamamlanma durumunu veya yetkisini değiştirmez.
