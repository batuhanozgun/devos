C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# Row 7, session part: step P1

## Item 1: install

- Command run: the first command of P1 item 1, with no change. It used the CPU-only torch index, then sentence-transformers. The fallback was not needed.
- Call: one foreground Bash call with the timeout set to 600000 ms. It did not move to the background; the call returned only after the install had finished.
- `INSTALL OK`: printed.
- Printed times: 2026-10-11T13:40:16Z to 2026-10-11T13:41:20Z, so the install took 64 s.
- Versions installed (Python 3.11): torch 2.14.1+cpu, sentence-transformers 6.1.0, transformers 5.19.0, huggingface-hub 1.33.0, tokenizers 0.23.3, safetensors 0.8.0, numpy 2.4.6, scipy 1.17.1, scikit-learn 1.9.1. The torch wheel was 196.2 MB. pip replaced setuptools 68.1.2 with 78.1.0.
- GPU device: none. `ls /dev/nvidia*` printed "No such file or directory".
- The machine as the session sees it: 4 CPUs (`nproc`) and 16093 MB of memory (`free -m`).

## Item 2: script

`c01-run/P1/embed.py`. It takes the model and the revision as arguments and loads the model through sentence-transformers on the CPU. It embeds the twelve sentences of 6.4 as written, with no model-specific prefix, and normalises the vectors. It prints:

- the seconds for download and load together, since the download happens inside the load;
- the seconds for embedding;
- the vector dimension;
- the process's peak resident memory (`ru_maxrss`);
- the cosine similarity of the three parallel pairs and of the three unrelated pairs.

## Item 3: candidates
