> **29 Eylül 2026 — tarihsel P4 v4 teslim kaydı; Codex ortam kararı geçersizdir.** [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri), D027/D029'un Codex ortam ve kurucu kararını geçersiz kılar. Aşağıdaki Agents API adayı ve “P5 Codex rehberi sıradaki” ifadeleri bugünkü kurulum yönü değildir. DevOS Claude Code cloud'da kurulacak ve çalışacaktır; tek geçerli plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır (devir sürümü 2.1).
>
> Özgün rapor tesliminin kaynak, öneri ve kanıt ayrımları aşağıda korunur; platformdan bağımsız bulgular sırf ortam değişti diye silinmez. Claude Code ve DevOS bu araştırma deposunu yalnız okur. [Bakımın A3 arşiv işi](../../../REPOSITORY-TRANSITION.md) ayrı ve henüz açıktır; bu statü notu dosyaların yeniden test edildiği veya bütünüyle arşivlendiği anlamına gelmez.

---

# P4-05 — Codex hedef ortamı revizyonu ve v4 rapor teslimi

**Tarih:** 28 Eylül 2026. **Üst iş:** [WORK/P4](../WORK.md).
**Statü:** P4 V4 RAPOR/KAYNAK TESLİMİ HAZIR / P5 KURULUM REHBERİ SIRADAKİ AYRI AŞAMA / HEDEFTE KURULMADI.
**Başlangıç repository ref'i:** `7f653f925e07ad98c17a0a93daf7f72cd06116cd`.

## 1. Yetki ve Environment transition

Kullanıcı DevOS'u yaratacak hedef yapının artık **Codex** olmasına karar verdi. Önce mevcut mimari dokümanın bu karara göre yeniden hazırlanmasını, sonra P5 kurulum rehberinin Codex'e göre hazırlanmasını istedi.

D027 current Environment kararını Claude Code cloud'dan Codex'e geçirir; D011 tarihsel provenance olarak korunur. D028 sıralamayı P4 v4 rapor revizyonu → P5 kurulum rehberi olarak kaydeder. Bu kayıt P5'i başlamış veya kurulmuş saymaz.

## 2. V4 mimari yorumu

V3'ün Work/RPD, rol–agent–principal, K1/K2, Information/memory/context, typed relations, protected effect, publication/recovery, uzun ürün ve yöntem aktarımı omurgası korunur.

Güncel OpenAI resmî kaynaklarıyla Environment-bound tasarım yeniden açıldı. Agents API, managed Codex harness üzerinden Agent/Environment/Session/event yüzeylerini, multi-agent root/subagent orkestrasyonunu ve hosted/self-hosted environment seçeneklerini sunuyor. V4'ün **P5 için birincil teknik blueprint adayı**:

`DevOS application/control plane → Agents API managed Codex harness → root + gerektiğinde specialist subagents → başlangıçta OpenAI-hosted sandbox → protected effects için ayrı trusted tool/broker sınırı`.

Bu, kullanıcının yalnız “Codex” kararından daha dar bir teknik öneridir. OpenAI-hosted yerine self-hosted gerekmesi, broker/publisher topolojisi, PostgreSQL/persistence ve subagent dağılımı P5 qualification ile değişebilir.

## 3. Platform sınırları

Codex session/subagent state'i canonical Work state'inin yerine geçmez. Session environment'tan daha uzun yaşayabilir; replacement compute dosyaları otomatik geri getirmez; timeout/pending input durable replay garantisi değildir; session idle veya completed turn bütün tool sonuçlarının başarılı olduğu anlamına gelmez.

Sandbox içinde açılan resource/credential'lar agent-generated kod tarafından kullanılabilir. Application API key environment dışında tutulur; protected third-party credential/effect'ler vault/proxy veya application-side trusted tool/broker üzerinden daraltılır. Subagent role adı security principal veya bağımsız reviewer kanıtı değildir.

K1/K2 bu platform mekanizmalarının üstünde DevOS sözleşmesi olarak kalır: talep → doğru Work → contribution → actual use; rutin geçişlerde Batu taşıyıcı olmaz.

## 4. Kaynaklar ve kanıt statüsü

Seçici taze resmî kaynaklar:

- OpenAI Agents API overview: https://developers.openai.com/api/docs/guides/agents-api/overview
- Architecture: https://developers.openai.com/api/docs/guides/agents-api/architecture
- Multi-agent: https://developers.openai.com/api/docs/guides/agents-api/multi-agent
- OpenAI-hosted sandboxes: https://developers.openai.com/api/docs/guides/agents-api/environments/openai-hosted
- Sandbox security: https://developers.openai.com/api/docs/guides/agents-api/environments/security
- Sandbox lifecycle: https://developers.openai.com/api/docs/guides/agents-api/environments/lifecycle
- Session webhooks: https://developers.openai.com/api/docs/guides/agents-api/sessions/webhooks

Bu dokümanların okunması Batu'nun actual hesabında kurulum/qualification değildir.

V3 mekanik tabanı v4 çalışma kopyasında yeniden koşuldu: v2 40 test/dört guard, sekiz scoped karşı örnek, 53 candidate test, sekiz mutation içinde yedi assertion/tek downstream error. Bunlar Codex-native test değildir.

## 5. Gerçek teslimler

| Dosya | Byte | SHA-256 |
|---|---:|---|
| `EXP-006_DevOS_v4_Codex_Hedefli_Rapor.pdf` | 355677 | `cd60f7fde9e1ba4fe7f1ecc7f2abb0b008e57bc12868d51721d6442f17c2e425` |
| `EXP-006_DevOS_v4.md` | 141259 | `22f4660d16b487f5a35a3a9eecff1e65246efc53707f93ce50d99b3d3dc9f146` |
| `EXP-006_DevOS_v4_Codex_Kaynak_ve_Kanit_Paketi.zip` | 3638865 | `df895557d77c4585627615010ac5061cde95ce768f73cfdea59259d1e5726aff` |

PDF 51 sayfa ve 31 üst bölüm taşır; 675/675 beklenen metin birimi extraction QA'da bulundu, out-of-bounds text/replacement glyph/broken internal link yoktu. Seçili yüksek-bilgi sayfaları görsel incelendi. ZIP 110 üyedir; CRC testi geçti ve iç MANIFEST 95 üyeyi byte/hash ile doğrular. Kimlik/layout kontrolü teknik yeterlik sertifikası değildir.

Tam kaynaklar conversation teslim eklerindedir; repository bu record ve continuity state'i taşır. V4 ZIP, exact v3 kaynak paketini provenance için `baseline-v3/` altında korur.

## 6. Sonraki ayrı aşama

**P4 v4 doküman teslimi burada tamamlanır.** Sonraki ayrı çalışma, kullanıcının belirlediği sıra gereği **P5 Codex kurulum rehberi**dir.

P5 rehberi actual Agents API hesabı/environment seçenekleri, application/control plane, persistence, PostgreSQL, trusted effect tools/broker, Git publication, secrets/network, restart/recovery ve H-ENV/H-K1-K2/H-AUTH qualification adımlarını kurulabilir sıraya çevirmelidir. Rehber hazırlanması bile P6 kabulü veya ilk SOUL backlog'unun seçilmesi değildir.
