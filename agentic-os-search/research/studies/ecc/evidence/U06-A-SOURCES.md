# U06-A — Source and execution ledger

**Date:** 2026-09-18. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Pinned source root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). FULL means body through EOF, not every dependency, host or passing test.

| ID | Path | Git blob | Actual coverage |
|---|---|---|---|
| S123 | scripts/hooks/config-protection.js | 2da5358c2f2e7711194580df96241cf9d55d1979 | FULL; E05 executed through original runner |
| S124 | scripts/lib/hook-flags.js | 69d3f25d6ba5d49acdebed943352674f87caa5c3 | FULL; E05 effective configuration dependency |
| S125 | scripts/hooks/pretooluse-visible-output.js | dc48119099f6206e6011174a62ad9912d7af9a25 | FULL; original runner dependency loaded; context-rendering branch not itself a tested claim |
| S126 | scripts/hooks/plugin-hook-bootstrap.js | 8d573ffedaa0f55de122a704737d3db0aa23f68d | FULL 1–260 + 261–550 through EOF; node forwarding/fallback; NOT executed |
| S127 | tests/hooks/config-protection.test.js | e383753ecfae04d3b7a27e273f1454faf5e6f29e | FULL 1–260 + 261–570 through EOF; test-source inspection ONLY |
| S128 | scripts/hooks/gateguard-fact-force.js | bfd2b11c6fa9ecd1dcc63fe16dedb522f4232599 | SELECTED 1–240; scope/config/helper imports only; main gate remains unread |
| S129 | hooks/hooks.json | 641873396e35359894076a8888623b79f3acbe51 | SELECTED 58–96; config-protection registration, neighboring gate and wrappers; not full manifest |
| S122 reused | scripts/hooks/run-with-flags.js | 9f6de372212d5c3ba20502b5e05711431f1a0053 | Full source retained from U05-B; local bytes reconstituted and verified; E05 executed |

## Claim binding

Note09 §§1–2: S123/S124/S126/S129 and retained S122. E05 C00–C14 supplies local decision evidence. Note09 §3: actual configuration precedence in S124, not authenticated authorization; C10–C14 tests representative choices. Note09 §4: fixture/outputs and realpath/inode identity from E05; alias consequences are limited to the guard, not a live Write. Note09 §5: source-based causal explanation, not historical cause. S128 is a next-unit frontier, not a concluded fact-forcing study.

**W14:** [Official Claude Code hooks reference](https://code.claude.com/docs/en/hooks), observed 2026-09-18. SELECTED current PreToolUse block/no-decision/timeout semantics (exit output and timeouts sections). This is a current host contract, not a pinned host-version test. Unofficial search mirrors were not used. No diagram/PDF analysis or external scanner ran.

## E05 and limits

[Prospective plan, exact runner, readable summary and lossless output](u06-a-config-probe/README.md). Single run 2026-09-18T04:48:43.248Z–04:48:43.684Z, Linux/Node v22.16.0, outer exit zero and empty captured probe stderr. Fifteen expectations matched; no actual agent tool operation or model ran. Child diagnostics are preserved inside raw output. Four source blobs verified before/after; no target double, new dependency install or rewritten target logic. Only temporary fixtures were created and cleaned. Exact raw stdout includes full oversized input; lossless XZ retains it rather than a rewritten summary.

E05 begins at run-with-flags, not the full plugin bootstrap, root search, manifest execution, other hooks or host permissions. Explicit invocation simulates registration; it does not demonstrate host activation. Source tests were not executed. No real user files/config/cache, credentials, remote command, installation, upstream report or patch. E01–E04 unchanged.

## Retrieval and continuity

Fresh main AGENT and protocol identities were checked; the same-conversation full R01–R09 bodies remain unchanged and active. Current STATE/META/WHY/QUESTIONS/MR08/E04 plan were read; prior full METHOD/PLAN/INDEX/Note08/source/README/receipt remained available. Current main ffb89901ed362da43f0c1a7685d28b1ba9bcf19a is the prior U05-B closure, not a newly changed study state. This is same-conversation re-entry, not independent cold-start validation.

Auxiliary raw-network acquisition failed at DNS. Four full connector texts were reconstructed locally and byte-checked; downloading was not counted as reading. Search for config-protection used default ref dd6ee538aee0f548d4a6b520118f875431fd749e only to locate tests; all bodies stayed pinned. Full recursive inventory was not completed. S128 dependencies shell-substitution, powershell-destructive-command and gateguard-heredoc remain frontier until needed; no claim about those implementations follows from an import name.

Publication evidence belongs in PUBLICATION-U06-A after actual branch/diff/readback checks. The full shared catalog must match its canonical base blob before the one-row replacement; no generative whole-file repair is accepted merely because it looks similar.
