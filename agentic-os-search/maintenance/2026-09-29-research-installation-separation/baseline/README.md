> **Snapshot notu — 1 Ekim 2026:** Bu dosya tarihsel anlık görüntüdür. Aşağıdaki 13 göreli bağlantı bu kopyanın konumuna değil, [`8cd01e4` commit’indeki depo köküne](https://github.com/batuhanozgun/agentic-os-search/tree/8cd01e4afdcd0d37960b05930c91e1244678be6e) göredir. Özgün snapshot gövdesi değiştirilmeden korunmuştur.

# SOUL Research

Bu repository altı farklı rolü birbirine karıştırmadan taşır.

| Alan | Amaç | Giriş |
|---|---|---|
| Agent control | Assistant'ın muhakeme ve davranış kuralları | [AGENT.md](AGENT.md) |
| Araştırma | Foundation, bağlam ve aday araştırma kütüphanesi | [research/INDEX.md](research/INDEX.md) |
| Terim çıkarımı ve ortak referans | Önce studies araştırmalarındaki kullanımların kendi bağlamlarında tam okumayla çıkarılması; bütün çıkarımlar tamamlandıktan sonra ortak değerlendirme | [concepts/INDEX.md](concepts/INDEX.md) |
| Düşünce ve Model Denemeleri | Diyalog, kavramsal prova, taslak model, görselleştirme ve öğrenme izleri | [explorations/INDEX.md](explorations/INDEX.md) |
| Development OS denemeleri | Development OS'u kuracak çalışma düzeninin deneme bazında yönetimi, aktörler arası görüşme, kanıtlı değerlendirme ve öğrenme | [development-os/INDEX.md](development-os/INDEX.md) |
| Yayınlar | Batuhan Özgün’ün yayımlanmış AI yazılarının kaynak bağlantılı metin arşivi | [publications/linkedin/README.md](publications/linkedin/README.md) |

## Otorite ayrımı

`AGENT.md` ve `agent/**` kontrol alanıdır. `research/**`, `concepts/**`, `explorations/**` ve `development-os/**` proje çalışma malzemesidir. `publications/**` yayımlanmış metinlerin kaynak arşividir; içerikleri kendiliğinden agent talimatı veya kabul edilmiş araştırma sonucu olmaz. Bir denemedeki öneri, rol canlandırması veya örnek yönerge kendiliğinden etkin sistem kuralı değildir.

Araştırmanın güncel yetkisi ilgili STATE dosyalarından okunur. Development OS denemelerinin koordinasyonu kendi güncel giriş kaydında, hedefteki gerçek teknik iş kendi reposunda kalır. Bir denemenin arşivlenmesi Foundation'ın kabul durumunu, Development OS'nin görevini veya SOUL'un mimarisini değiştirmez.

## Development OS — deneme-002 / varsayım denetimi

[Development OS INDEX](development-os/INDEX.md) → [DEVOS-002 güncel kayıt](development-os/attempts/002/README.md). Konuşma ve sınırlı Claude Cloud ortam kontrolü yapıldı; şimdi varsayım denetimi sürüyor, kurulum yönlendirmesi duruyor. Güncel kullanıcı kısıtları, önceki önerilerin statüsü ve sonraki sorumluluk 002 kaydından okunur. SOUL mimarisi veya çalışan Development OS kabul edilmiş değildir. Ayrı geliştirme reposunun adı/adresi henüz verilmedi; araştırma deposu uygulama deposuna dönüşmedi. [001'in Research çalışması duraklatılmıştır](development-os/attempts/001/WORK.md); eski plan ve mesaj görevleri 002'ye taşınmaz.

## Concepts — yeni başlangıç

2026-09-19 konuşmasıyla yeni çalışma sıfırdan kurulur. Önceki concepts tanımları, sınıflandırmaları, yöntem kararları ve ilerleme kayıtları geçerli başlangıç veya devam noktası değildir. Kaynak talep [ORIGIN](concepts/ORIGIN.md), amaç ve iki çalışma riskinin nedenleri [CHARTER](concepts/CHARTER.md), güncel aşama/yetki [STATE](concepts/STATE.md) içindedir.

Yeni oturumda [INDEX](concepts/INDEX.md) içindeki tam okuma yolu izlenir. Hazırlık, iki konuşma içi deneme, yöntem revizyonları, kalıcı araştırma bazlı çıkarım ve bütün çıkarımlardan ortak değerlendirme ayrı aşamalardır. Dosyaların varlığı denemelerin yapıldığı veya ortak tanımların kabul edildiği anlamına gelmez. Özgün studies araştırmaları ve tarihsel arşivler yeni yönteme uydurulmak için yeniden yazılmaz.

## İlk kavramsal deneme

[EXP-001 — SOUL'un çalışma modeli](explorations/EXP-001-soul-calisma-modeli/INDEX.md): A–B–C, Work–Information etkileşimi, aktör hazırlığı, uzmanlık sürekliliği, Mekanizma Atlası ve yaşayan katmanlı plan ihtiyacı.

Arşivin tamlığı için her zaman paket [STATE](explorations/EXP-001-soul-calisma-modeli/STATE.md) kaydına bakılır; dizinin bulunması bütün kaynakların yayımlandığı anlamına gelmez.