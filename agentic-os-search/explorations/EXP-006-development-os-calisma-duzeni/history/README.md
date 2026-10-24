> **30 Eylül 2026 — tarihsel EXP-006 gezinme alanı.** Bu klasör DevOS kurulumunun güncel çalışma yüzeyi değildir. [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri) ve [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) güncel kurulum yönünü; [depo bakım planı](../../../REPOSITORY-TRANSITION.md) ChatGPT'nin bu depodaki bakım işini gösterir.
>
> Aşağıdaki eski README de korunmuş tarihsel metindir. İçindeki “Current authority yolu” güncel DevOS yetkisi değildir. Anlık görüntülerin gövdeleri ve eski bağlantı yazımları değiştirilmez; doğru tarihsel konuma dönüş aşağıdaki eşlemeden yapılır.

<a id="historical-source-map"></a>
## Sabit tarihsel kaynak eşlemesi

Üç gövde, `8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e` commit'indeki özgün konumlarında aynı Git blob kimliği ve boyutla bulundu. Aşağıdaki bağlantılar birer tarihsel okuma yoludur; eski görevleri yeniden açmaz.

| Korunan anlık görüntü | Özgün konumdaki aynı gövde | Git blob |
|---|---|---|
| [2026-09-25-pre-work-system-INDEX.md](2026-09-25-pre-work-system-INDEX.md) | [INDEX.md](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/INDEX.md) | `e27aacbf86992c150e96665af3dffba4c18a3f23` |
| [2026-09-25-pre-work-system-STATE.md](2026-09-25-pre-work-system-STATE.md) | [STATE.md](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/STATE.md) | `c074998b3c3a874b09ba3c0c19317dc62f336b05` |
| [2026-09-25-pre-split-WORK-MAP.md](2026-09-25-pre-split-WORK-MAP.md) | [EXP-006_Work_Map.md](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/EXP-006_Work_Map.md) | `bfdc8c64896e34126cdbe8058cb6c0493c442631` |

**Bağlantı sınırı:** Anlık görüntüdeki göreli bağlantılar bugünkü `history/` konumuna göre çözülürse yanlış yere gider. Özgün konumdaki sabit sürüm, aynı gövdeyi eski dizin bağlamında açar. Bu, o metindeki bütün eski bağlantı hedeflerinin ve başlıklarının tek tek doğrulandığı anlamına gelmez. Örneğin INDEX içindeki yazıyla kaydedilmiş `\n` dizileri de kaynak gövdesinin parçası olarak kalır. Gövde dışı eşleme, tarihsel metni sessizce düzeltmenin yerine kullanılır.

## Korunan önceki README gövdesi

---

# EXP-006 — history

Bu klasör **current çalışma yüzeyi değildir**.

Buradaki dosyalar, EXP-006 yaşayan çalışma sistemine geçmeden önceki büyük STATE / INDEX / WORK-MAP snapshot'larını tarihsel iz ve migration kanıtı olarak korur.

Kurallar:

- Normal cold-start sırasında okunmaz.
- İçlerindeki "current", "next", "authoritative" veya benzeri ifadeler snapshot'ın üretildiği tarihe aittir.
- Current phase, next responsibility veya rol modeli için bu klasörden karar çıkarılmaz.
- Current authority yolu: `../STATE.md → ../HANDOFF.md → ../WORK.md → ../ACTORS.md`.
- Tarihsel relative link'ler bugünkü dosya yapısında çalışmayabilir; snapshot'lar sırf bugünkü yapıya uysun diye yeniden yazılmaz.

Mevcut snapshot'lar:

- `2026-09-25-pre-work-system-INDEX.md`
- `2026-09-25-pre-work-system-STATE.md`
- `2026-09-25-pre-split-WORK-MAP.md`
