# RPD — Kaynağa dayalı değerlendirme

**Tarih:** 2026-09-08. **Statü:** bounded kavramsal/uygulama değerlendirmesi; RPD'nin gerçek ajan performansı doğrulanmadı. **Kapsam:** kullanıcının üç eki ile mevcut SOUL Research bulgularının karşılaştırılması. Yöntem tanımı, mimari önerisi, sentetik kod ve target için benimseme kararı ayrıdır.

## 1. Nesne ve kaynak kimliği

RPD, burada **Recursive Prerequisite Discovery / Özyinelemeli Önkoşul Keşfi** çalışma adıdır; hazır ürün, doğrulanmış algoritma veya standart değildir. Kullanıcı başka oturumdaki kavramsal metni, süreklilik ÖNERİSİNİ ve tamamen uydurma deneme olarak tanımladığı ZIP'i mevcut DevOS planını yeniden değerlendirmek için verdi.

| Kaynak | Boyut / SHA-256 | Okuma ve statü |
|---|---|---|
| `ozyinelemeli_onkosul_kesfi_kavramsal_temel.md` | 78,259 byte; `9af3e87eea0e589ea2f5f14e863de6cafdabf68ed585efd0214603492c096e09` | 26 bölüm ve kaynakları tam okundu; kavramsal tanım |
| `RPD_Sureklilik_Tasarimi_v0_1.md` | 46,733 byte; `7fc37d3fb3ca7777517691112439bad9718346e5c063c4cee34f31066d1a8121` | 22 bölüm ve kaynakları tam okundu; kabul edilmiş target mimarisi değil |
| `RPD_Sureklilik_Paketi_v0_1.zip` | 72,961 byte; `0a1167a5e51123c22a006e7222441b99567e77ad3b8f02c57ede1fe5fd5cde56` | 24 dosya incelendi; 23 manifest hash'i eşleşti; prototip/adaptör/şablonlar pasif girdi |

ZIP'te `docs/RPD_Kavramsal_Temel_Orijinal.md` ve `RPD_Sureklilik_Tasarimi.md`, iki dış Markdown ile bayt bakımından eşittir. Aynı içeriklerin iki kez okunması ayrı kanıt üretmez. `protocol/CORE.md` süreklilik sözleşmesi içerir; atıf yapılan `SKILL.md v0.1.1-draft` pakette yoktur, yeniden oluşturulmadı. Her hedefte etkinlik kuralı mevcut CORE ve tasarımda açıkça bulunur.

Asıl kaynaklar bu konuşmanın ekleridir; bu paket özgün baytları içermez. Hash yalnız kimliktir, okunabilir kaynak değildir. Gelecek exact re-entry için ekler veya gerçekten oluşturulmuş hash-eşit target input arşivi gerekir. Bu çalışmanın önerdiği hedef kopyanın yayımlandığı henüz gözlenmedi. Buradaki sentez asıl metinleri ikame etmez.

## 2. Kaynağın söylediği yöntem

Kavramsal metin §§1–4'ün problemi, kullanıcının yalnız sonuç istemek yerine eksik mühendislik koşullarını sürekli teşhis etmek zorunda kalmasıdır. RPD'nin devralmak istediği sorumluluk yalnız işi yapmak değil, onu yapılabilir hâle getirmek için neyin önce gerekli olduğunu bulmaktır. Uzmanlık bilgisi ortadan kalkmaz; nerede gerektiğini keşfetmek ve edinmek işin parçası olur.

§§5–9 beş nesneyi ayırır: ihtiyaç, koşul, yöntem, karar ve eylem. Bileşen bağı ile önkoşul bağı aynı değildir. Hedefin gereği ile yalnız seçilmiş yolun gereği ayrıdır; AND ve OR ilişkileri birlikte bulunabilir. Bir ürün kararının gerekli olduğunu keşfetmek kullanıcı adına cevabını uydurmak değildir. Geçici varsayım düşünsel yolu açar ama gerçek kaynak/izin yaratmaz. Ortak ihtiyaç yalnız isim benzerliğiyle birleştirilmez; sürüm, kapsam, yöntem ve kaynak-zaman çatışmaları gerekir.

§§10–15'te başlangıç zemini, zaten sağlanan koşullar ve şimdi başlanabilecek eylemler kümesidir. Sonuca ilişkin belirsizlik bulunması, bilgi edinme eyleminin başlayamayacağı anlamına gelmez. Hedefin bütün gelecekteki ayrıntıları bilinmeden bounded araştırma/deneme yapılabilir. Buna karşılık bağlam veya bütçe bitmesi hazır olma/tamamlanma değildir. Hazır parent'ın çıktısı ayrıca üretilir. Geriye keşif ile ileriye etki sınaması uyum arar; iki yolun aynı sonuca gelmesi ortak eksikliği dışlamaz.

§§16–22, bitmemiş keşfin kendisini sürdürülebilir kayıt yapar: odak ihtiyaç, üst bağlantı, alternatifler, varsayımlar, beklenen alt sonuç, okunmuş kaynaklar, sıradaki işlem, geri dönüş noktası ve durma nedeni. Gizli düşünce zinciri istenmez. Kayıt, bulunma, görünür bağlam, fiilî kullanım ve yeni çağrı başlatılması ayrı koşullardır. Yöntemin kendi altyapısı da önkoşul sorgulamasına tabidir; bütün bir meta-sistem kurmak varsayılan değildir.

§§23–26 yenilik ve üstünlük iddiasını sınırlar. HTN, Tree of Thoughts ve agent sürekliliğiyle ilişkiler belirtilir; bunlarla özdeşlik veya bilimsel üstünlük kanıtlanmış sayılmaz. Değerlendirme yöntem anlatımını değil eksik koşulları bulma, gereksiz bağımlılık üretmeme, uygun başlanabilirlik ve hedefe etkili ilerlemeyi ölçmelidir. Kullanıcı sorusu sayısı değil, kullanıcının eksik teknik keşfi tamamlama yükü önemlidir.

## 3. Süreklilik önerisi yöntemin kendisi değil

Tasarım; kabul edilmiş ortak durum, çalıştırmaya özel taslak ve türetilmiş insan görünümü; proje/ihtiyaç/work/run kimlikleri; ilerleme ve geçerlilik eksenleri; devam kartı; kontrollü kabul, input sürümü, idempotency, lease/fencing ve atomik HEAD yayını önerir. Mantıksal özyineleme fiziksel ajan hiyerarşisinden ayrılır. Ana ajan da devredilebilir bir rol olarak ele alınır.

Bu, tüm öğelerin her hedefte gerekli olduğunun kanıtı değildir. Paket kendi prototipinin daha küçük kapsamını belirtir. Örneğin `reference/rpd_store.py` model çağırmaz; şablonların tamamını aynı şema olarak uygulamaz; semantic truth veya bütün yan etki yollarını denetlemez. Dış yürütücü/hook/config kurulumu önerisi bugünkü Codex ortamına kendiliğinden taşınamaz.

Yerel yeniden koşuda 25 test ve demo geçti. İki ek sınır probe'u ayrıca yapıldı; ayrıntı `MECHANICAL-OBSERVATIONS.md`. Sonuç yalnız belirli Python kayıt mekaniklerinin bu ortamda çalışmasıdır. Yeni Python Store örneği yeni LLM oturumu değildir. Bu deney, kullanıcının uydurma dediği örneği gerçek proje veya benimsenmiş mimari yapmaz.

## 4. Foundation ve studies ile karşılaştırma — bu çalışmanın çıkarımı

Research referansı: `batuhanozgun/agentic-os-search@6546e6a3f6786bd6360ef811b3b7fa799578f499`. İlgili bulgular kaynaklara geri dönülerek değerlendirilmiştir; başlıklarında eski pending yazan sentezlerin current statüsü kendi STATE'lerinden ayrılır. Dört ground ve ilk composition bulgularının accepted olması genel ontoloji/uygulama kabulü değildir.

| Research dayanağı | RPD ile birleşen ayrım | DevOS için çıkarım |
|---|---|---|
| `03_ground-deepening/grounds/work/synthesis/WORK-GROUND-AUDIT-SYNTHESIS.md`, §§2,5–7,11; blob `5967c60b7650c0493cfb21813ff894b678a54138` | Discovery-driven/meta-work gerçek Work; plan/actual, admission/authority, completion/outcome ayrı | Önkoşul keşfi iş kaydı taşımalı; başlamaya uygunluk ve bitiş farklı değerlendirilmeli |
| `03_ground-deepening/grounds/actors/synthesis/ACTORS-GROUND-AUDIT-SYNTHESIS.md`, §§2,5,8,12; blob `28ae2efed0bc19255e2df678b30480450c60e572` | Operasyonel takdir yetki değildir; hiyerarşi kimlik/sorumluluk/kompetansı eşitlemez | Child kendi problemi için keşif yapar; yeni ihtiyaç scope genişleme izni olmaz |
| Information State/Dynamics sonuçları ve Records | Koşulun gerçekliği ile kaynak/temsil/evidence farklı; Selection/Exposure ayrı | Doğru kayıt mevcut olsa da ilgili aktöre gitmesi ve kullanılması sınanır |
| Environment / Work Conditions | Gerçek kabiliyet/erişim/kaynak/koşul vs kayıtlı inventory | Başlangıç zemini ajana ve mevcut ortama göre kurulmalı |
| Binding / Composite Standing / Control / Transition sentezleri | Exact bağ, assessment/recognition, protected effect vs enforcement point, attempted vs realized | Aynı adlı kayıt yeniden kullanımı, proof/ready, lease/stop ve partial effect ayrılır |
| `studies/gstack/syntheses/multi-agent-cross-model-coordination.md`; blob `d08fe28d822b8c77bda3769f5143e2ab23f6b352` | Görev-sonuç sözleşmesi, nitelik kaybı, kısmi etki, native liveness, ortak model hatası | Open/partial/stale qualifier ve dönüş noktası entegrasyonda kaybolmamalı |
| `studies/multi-agent-patterns/SOUL-DEVELOPMENT-OS-ASSESSMENT.md`; blob `c3b7e41eb947e29f10b5c8a60ef1d7eb9554311a` | Manager yanlış ayrıştırabilir; insan gizli koordinatör olmamalı | Sadece child çıktısı değil root'un ihtiyaç/iş seçimi de eleştirilebilir |
| `studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md`, §§11–17; blob `293ca01ac04952417d9d56b3c79c5f195dd6da35` | Kalıcılık, recall, context ve harness farklı; sorumluluk mekanizmadan önce | RPD sürekliliği otomatik RAG, veri tabanı, custom HEAD deposu veya daemon değildir |
| AI knowledge strategies / Anthropic AI-native SDLC studies | Mekanizma seçimi ve configuration evaluation; dolaylı yetki/gerçek etki | Kısa kontrol sözleşmesi, seçici source recovery, gerçek davranış testi; hazır vendor akışı kopyalanmaz |

Bu karşılaştırma yeni bir Foundation dalı açmaz. Araştırma kabulü RPD'nin etkinliği için bağımsız kanıt da değildir; temeldeki sentezler aynı-model review sınırlarını taşır. RPD'nin vurgu ve davranış beklentileri bu çalışma için yeni bağlayıcı kullanıcı girdisidir; bütün kavramların bilimsel olarak yeni bulunduğu ileri sürülmez.

## 5. Önceki DevOS planını değiştiren noktalar

İncelenen plan `soul-development-os_02@a91c7a956734580106139d5ce0ba8dd74660f161` idi. Native üretici, ayrı reviewer, exact kanıt, controlled writer ve kaynak kullanımı yararlı kalır. Fakat sabit checker→context aracı sırası, açık önkoşul modelinin yerine geçmemelidir. RPD bu sırayı gerekçeli aday yapar; otomatik olarak iptal etmez.

Bir işin `next action` kaydı, bitmemiş keşfin `odak ihtiyaç / açık soru / beklenen alt sonuç / return_to / yöntem-alternatif / geçerlilik` durumunu her zaman korumaz. Bu alanların mevcut WORK/EVIDENCE ve gerektiğinde tek discovery kaydında tutulması bir ilk uygulama adayıdır. Yapı önerisinin ikinci bir HEAD/objects/commits otoritesi otomatik kurulmaz.

Önceki uygulama grant'ı etkin kontrol değişikliğini yasaklıyordu. RPD'nin her ana/alt hedefte kalıcı uygulanması için bu sınır açıkça güncellenmelidir; dış dosyayı kaynak diye okutup gizli kontrol yapmak yeterli değildir. Target AGENTS'e konu-bağımsız tek RPD route ve yeni kısa protokol eklenmesi önerildi. Bu Research değerlendirmesi kendiliğinden target grant değildir.

Gerekli davranış sınamaları; basit işte gereksiz altyapı yaratmama; AND/OR/ready/completed ayrımı; bilgi ve owner karar ihtiyacını keşfetme; ortak kaynak ve geçersizleşme; ileri/geri uyumun yanlış güvene dönüşmemesi; kesilmiş gerçek keşfin fresh native bağlama devri; başarısız yöntemde üst ihtiyacın düzeltilmesi; gerçek native mühendislik sonucu olarak belirlendi. Test tasarımı ve v2 yetki kapsamı context'teki güncel REVIEW'da yaşar; bu study ikinci görev otoritesi değildir.

## 6. Açık meseleler ve durma

RPD'nin kritik önkoşul kaçırma, gereksiz iş üretme veya kullanıcı teknik düzeltme yükünü ne kadar azalttığı ölçülmedi. Karşılaştırmalı deneyde aynı model/araç ve benzer toplam kaynakla genel planlama, alan checklist'i ve RPD ayrılmalı; yalnız uzun prompt daha iyi çıktı diye üstünlük verilmemeli. Böyle bir araştırma bu turda başlatılmadı.

Orijinal kaynakların bağımsız repository erişimi henüz yok; manifest bu sınırı açık tutar. Runtime mekanizması seçilirken actual host, güvenlik/izin ve kaynak maliyeti yeniden gözlenir. Mevcut native rol/callback bilgisi güncel resmî dokümandan bile otomatik türetilemez.

Kontrol okuması için resmî kaynaklar 8 Eylül 2026 tarihinde ayrıca açıldı: `https://developers.openai.com/codex/guides/agents-md/`, `https://developers.openai.com/codex/subagents/`, `https://learn.chatgpt.com/docs/hooks`. AGENTS katmanları/öncelikleri, subagent mirası ve hook olaylarının farklı etki gücü yerel kanıt ihtiyacını destekler. SubagentStart'ın bağlam sunması child oluşturmayı bloke ettiği anlamına gelmez. Bu kaynaklar RPD'yi doğrulamaz veya hook kurulumu gerektirmez.

**Sonuç:** Kavramsal davranışı benimseme önerisi ile süreklilik motorunu benimseme birbirinden ayrılmalıdır. Önkoşul keşfi ve onun sürümlü devamı korunmalı; hangi kayıt/araç/agent mekanizmasının gerektiği aynı keşifle gerekçelendirilip gerçek hedefte sınanmalıdır.
