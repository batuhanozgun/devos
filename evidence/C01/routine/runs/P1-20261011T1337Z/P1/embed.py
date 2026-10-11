# C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).
"""Row 7 session part (step P1): load one embedding model at a pinned revision,
embed the twelve synthetic sentences of CONTROL.md 6.4 and print the timings,
the vector dimension, the peak memory and six cosine similarities.

Usage: python3 embed.py <model id> <revision>
The sentences are embedded as written, with no model-specific prefix.
"""
import resource
import sys
import time

SENTENCES = {
    "TR1": "Bahçedeki domatesler bu yıl erken olgunlaştı.",
    "EN1": "The tomatoes in the garden ripened early this year.",
    "TR2": "Toplantı yarın sabah saat dokuzda başlayacak.",
    "EN2": "The meeting will start tomorrow morning at nine.",
    "TR3": "Kütüphane hafta sonları akşam altıda kapanır.",
    "EN3": "The library closes at six in the evening at weekends.",
    "TR4": "Kedi pencerenin önünde güneşleniyor.",
    "EN4": "The bridge was painted blue last spring.",
    "TR5": "Dağ yolunda kar yüzünden trafik yavaşladı.",
    "EN5": "She keeps her old letters in a wooden box.",
    "TR6": "Fırından yeni çıkmış ekmeğin kokusu sokağa yayıldı.",
    "EN6": "Two trains left the station at the same minute.",
}
PARALLEL = [("TR1", "EN1"), ("TR2", "EN2"), ("TR3", "EN3")]
UNRELATED = [("TR4", "EN4"), ("TR5", "EN5"), ("TR6", "EN6")]


def main():
    if len(sys.argv) != 3:
        sys.exit("usage: python3 embed.py <model id> <revision>")
    model_id, revision = sys.argv[1], sys.argv[2]

    t0 = time.perf_counter()
    from sentence_transformers import SentenceTransformer

    model = SentenceTransformer(model_id, revision=revision, device="cpu")
    load_s = time.perf_counter() - t0

    keys = list(SENTENCES)
    t1 = time.perf_counter()
    vectors = model.encode([SENTENCES[k] for k in keys], normalize_embeddings=True)
    embed_s = time.perf_counter() - t1
    index = {k: i for i, k in enumerate(keys)}

    def cosine(a, b):
        return float(vectors[index[a]] @ vectors[index[b]])

    peak_mb = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1024
    print(f"model: {model_id}")
    print(f"revision: {revision}")
    print(f"download_and_load_seconds: {load_s:.1f}")
    print(f"embedding_seconds: {embed_s:.2f}")
    print(f"dimension: {vectors.shape[1]}")
    print(f"peak_memory_mb: {peak_mb:.0f}")
    for a, b in PARALLEL:
        print(f"parallel {a}-{b}: {cosine(a, b):.4f}")
    for a, b in UNRELATED:
        print(f"unrelated {a}-{b}: {cosine(a, b):.4f}")


if __name__ == "__main__":
    main()
