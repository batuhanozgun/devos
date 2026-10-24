# EXP-001 — Araştırma kaynaklarına dönüş

## Kaynak rolleri

Bu dosya EXP-001'in kullandığı araştırma dayanaklarına yeniden ulaşmak içindir; yeni araştırma değildir. `AGENT.md` ve `agent/**` burada araştırma kanıtı olarak kullanılmaz. Asıl konuşma ayrı korunur; dosya yolları bir cümlenin doğruluğunu otomatik kanıtlamaz.

Konsolidasyon Ek D ve Atlas `source/model.json` içindeki kaynak tablosu, temel dayanakları **634ab66f195130d551d58dfc062639e0feec23fa** repository snapshot'ına ve aşağıdaki blob kimliklerine bağlar. Bu bilgiler özgün eserden bu arşivleme turunda yeniden okunmuştur. Atlas sonrası S017'nin kaynak geri dönüşü ayrı bir olaydır; bu eski snapshot'a otomatik atanmaz. Arşivleme başlangıcındaki repo HEAD'i **917d981d40ea0d1159543caac6c3fc27308cb36c** idi. İki snapshot aynı olay değildir.

## Temel repository kaynakları

Aşağıdaki göreli bağlantılar mevcut repository yoluna gider. Tarihsel tam bağ için belirtilen snapshot ve blob kullanılır. Eski dosyaların başlığındaki awaiting statüsü yerine güncel paket STATE okunmalıdır.

| Kimlik | Yol / doğrudan giriş | Tarihsel blob SHA | EXP-001'deki işlev |
|---|---|---|---|
| K01 | [Work bütünleşik sentez](../../../research/soul-foundations/01_verticals/work/synthesis/WORK-VERTICAL-SYNTHESIS.md) | `58fb887139fa84adf6eb522569c593e320b51684` | Amaç/eylem/yöntem; iş kabulü; bağımlılıklar; plan/actual; kapanış |
| K02 | [Work ground denetimi](../../../research/soul-foundations/03_ground-deepening/grounds/work/synthesis/WORK-GROUND-AUDIT-SYNTHESIS.md) | `5967c60b7650c0493cfb21813ff894b678a54138` | Gerçek Work≠temsil; discovery/meta-work; koşul ve otorite sınırı |
| K03 | [Information Dynamics sentezi](../../../research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/synthesis/INFORMATIONAL-DYNAMICS-SYNTHESIS.md) | `1c3f3f3c12c7f859c63d79e9d65ef0ae91154a93` | Oluşum, türetim, seçme/görünürlük; bilgi mevcut≠tüketici görüyor |
| K04 | [Actors ground denetimi](../../../research/soul-foundations/03_ground-deepening/grounds/actors/synthesis/ACTORS-GROUND-AUDIT-SYNTHESIS.md) | `28ae2efed0bc19255e2df678b30480450c60e572` | Kimlik/rol/yeterlilik/yetki/sorumluluk; görevden önce süregelen sorumluluk |
| K05 | [Context/Memory/Harness sentezi](../../../research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md) | `293ca01ac04952417d9d56b3c79c5f195dd6da35` | Bağlam, kalıcılık, bellek ve gerçek işletim ayrımı |
| K06 | [Agent Memory](../../../research/studies/context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md) | `6203b06fe56cad61354e9093d0b404a1ee3592c7` | Deneyim statüsü, güncelleme ve yeniden çağırma |
| K07 | [Harness](../../../research/studies/context-memory-harness-engineering/03-HARNESS-ENGINEERING.md) | `53f3cbcfbc934155553c9ae6c4ff931126b00876` | Araçlar, yürütme, kontroller, gözlem, süreklilik; kural≠enforcement |
| K08 | [RPD değerlendirmesi](../../../research/studies/recursive-prerequisite-discovery/ASSESSMENT.md) | `ffd95e71c6f49192d3cdf6ffc2a4d13b1b7a10d0` | İhtiyaç/koşul/yöntem/karar/eylem; bitmemiş keşif ve return_to |
| K09 | [Work çerçeveler ve birimler](../../../research/soul-foundations/01_verticals/work/findings/WORK-FRAMES-AND-UNITS.md) | `592fccfb1633c37425890a883f52cf8606258f45` | Hiyerarşi, alternatif refinement, kısmi sıra ve progressive elaboration |
| K10 | [Foundation STATE](../../../research/soul-foundations/STATE.md) | `049ec467cd4eccaf814249982b74525dcd3d8abb` | Tarihsel kabul/yetki bağlamı; EXP-001 bu state'i değiştirmedi |

## Atlas sonrası planlama sorgusunun geri dönüş yolu

[S017](conversation/assistant/S017.md) → [Work INDEX](../../../research/soul-foundations/01_verticals/work/INDEX.md) → [Work Source Ledger](../../../research/soul-foundations/01_verticals/work/evidence/SOURCE-LEDGER.md) → ilgili birincil kaynak.

Ek repository yüzeyleri:

- [Başlangıç yönelimi](../../../research/soul-foundations/01_verticals/work/orientation/RESEARCH-ORIENTATION.md), blob `b49a2e78f794dcd79b3f28960994d043e00e3634`.
- [Deferred relations](../../../research/soul-foundations/01_verticals/work/DEFERRED-RELATIONS.md), blob `28b6d8583a6425871f9503733a06a55bf4a5ceca`.
- [Intake/selection](../../../research/soul-foundations/01_verticals/work/findings/INTAKE-SELECTION-COMMITMENT-AND-PRIORITY.md), blob `0201c31111716b1dac2ccfb8782b1fcea0822f38`.

Bu ek blob kimlikleri ilgili önceki GitHub okumalarının meta verilerinden aktarılmıştır; bu tur bunların tümü için bağımsız yeniden hash doğrulaması yapıldığı ileri sürülmez.

## Konuşmada kullanılan başlıca dış kaynaklar

Bu liste kaynak linklerini kalıcılaştırır; bugünkü durum veya uygulama benimsemesi değildir.

| Kaynak | Adres | Kullanım / sınır |
|---|---|---|
| HTN, Erol–Nau–Hendler 1993 | https://cdn.aaai.org/Symposia/Spring/1993/SS-93-03/SS93-03-005.pdf | Work ledger S04; alternatif hiyerarşik refinements ve kısmi sıra |
| PMI Scheduling, 2. baskı, 2011 | https://www.pmi.org/-/media/pmi/documents/public/pdf/certifications/practice-standard-scheduling.pdf | Work ledger S15, §2.3.1 rolling wave; eski baskı, güncel uyumluluk hükmü değil |
| OMG CMMN | https://www.omg.org/cmmn/ ve https://www.omg.org/spec/CMMN/1.0/PDF | Work ledger S01–S02; değişen durum, discretionary work, plan örneği |
| Malone–Crowston coordination | https://crowston.syr.edu/sites/default/files/acmcs94.pdf | Work ledger S05; bağımlılık/koordinasyon |
| AAPOR best practices | https://aapor.org/standards-and-ethics/best-practices/ | S007'de örneklem/yorum sınırı; gerçek araştırma örneklemi kurulmadı |
| GPT-3 / in-context learning | https://arxiv.org/abs/2005.14165 | S002/S011'de parametreli kapasite ve bağlamdan uyarlama ayrımı |
| Context engineering | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | Görünür working context, external memory ve seçim |
| Effective agents | https://www.anthropic.com/engineering/building-effective-agents | Araç/sonuç döngüsü, workflow ve agent ayrımı |
| Long-running harness | https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents | Oturum devri ve kalıcı çalışma bilgisi |
| Harness design | https://www.anthropic.com/engineering/harness-design-long-running-apps | Harness maliyeti/model bağımlılığı; kullanıcının felsefesi bu maliyetle eşitlenmedi |
| OpenAI harness | https://openai.com/index/harness-engineering/ | Ortam, geri bildirim, kaynak haritası ve mekanik kontrol |
| NASA system design | https://www.nasa.gov/reference/4-0-system-design-processes/ | Amaç/koşul/çözüm geliştirme |
| Skills | https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills | Dosya yönlendirmesi ve çalıştırılabilir kod ayrımı |
| Tool calling | https://platform.openai.com/docs/guides/function-calling | Model isteği, gerçek çalıştırma ve sonuç ayrımı |
| C4 / Structurizr / SVG | https://c4model.com/ ; https://structurizr.org/ ; https://developer.mozilla.org/en-US/docs/Web/SVG | Atlas gösterimi; SOUL ontolojisi veya runtime kararı değil |
| SAP PS WBS | https://help.sap.com/docs/SAP_S4HANA_ON-PREMISE/4dd8cb7b1c484b4b93af84d00f60fdb8/26d4b65334e6b54ce10000000a174cb4.html | S017'de karşılaştırma ipucu; SAP benimsenmedi |

## Atıf sadakati sınırı

Eski `filecite` işaretlerini tek bir global tabloya körlemesine çevirmedik: araç kimlikleri konuşmanın farklı restore dönemlerinde yeniden kullanılabilir. İfade, ait olduğu S mesajı ve konusuyla birlikte yukarıdaki kaynağa bağlanır. Kaynak ledger'ının A/B/C görünüm kalitesi ve yorum sınırları ayrıca korunur.

RPD kavramsal özgün ekleri başka konuşmaya aittir; bu paketin erişilebilir özgün ekleri arasında değildir. RPD ASSESSMENT kendisi de bu kaynak-recovery sınırını belirtir. EXP-001 o ekleri hash veya özetinden yeniden üretmez.
