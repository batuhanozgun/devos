# D1 — Received archive and selected evidence

**Received/audited:** 2026-09-07.  
**Role:** source-preserving selections and static audit results, not operating authority or a live Mac observation.  
**Attachment:** `file_00000000e69c81f4a548acb969dd295d`, `D1-EVIDENCE.zip`.

## 1. Source identity and receipt

The actual uploaded ZIP was obtained from `/mnt/data/D1-EVIDENCE.zip`; no further Gmail retrieval was needed.

- ZIP size: **104578 bytes**.
- Independently calculated SHA-256: `4495e9b919ce5b896c7c877f6547e95f582919ed542699c714973dee5935bfa6`.
- 65 regular file entries, 247074 uncompressed bytes, under `D1-EVIDENCE/`.
- CRC check: no failing entry; no duplicate names, absolute/traversing member paths or symlink entries found.
- `MANIFEST-SHA256.json` contains 64 entries; all matched independently calculated hashes. The only unlisted member is the manifest itself.
- The calculated ZIP checksum matches the expected checksum previously recorded from the email. This is transfer/content consistency, not authentication of every originating execution claim.

Original Mac directory:

`/Users/Batu/Documents/Codex/SOUL-Development-OS-Run-Evidence/G0-D1-20260906T200915Z-hcg4769w/`

The full archive remains the source package; this repository retains selected evidence, not a second binary archive or the live Development OS state.

## 2. Reading and verification scope

The research assistant read the complete `REPORT-TR.md`, `scripts/prepare.py`, `scripts/probe.py`, `scripts/close.py`, runtime/config records, fixture descriptions and relevant source excerpts. All nine plan/intent/result/process records were parsed and cross-compared, including complete argument/profile equality, fixture hash continuity and aggregate-result consistency. No supplied script was executed, no Codex run was started, and the Mac was not accessed directly.

Internal static checks established:

- both TOML profile objects in every recorded argv match `PLAN.json`;
- every intent's test object equals its planned object;
- recorded plan time precedes all intents; intent/process-start/result order and sequential non-overlap are consistent;
- individual probe results equal the corresponding `RESULTS.json` entries;
- all six fixture hashes form a consistent before/after chain across all probes;
- all retained fixture content strings reproduce their recorded hashes;
- classification recomputed from exit/output/error/change agrees with all nine recorded classifications;
- six PASS, two FAIL, one CAUSAL_OBSERVATION. These counts are not a readiness score.

Timestamps, PIDs and command outputs are supplied records, not independently authenticated telemetry. Static consistency does not prove runtime enforcement outside the recorded cases.

## 3. Requested profiles — exact keys and roles

Let E denote the original Mac D1 evidence directory above, and S denote `/private/tmp/devos-g0-d1-n7lstg5k`. These abbreviations are only for this extract; absolute paths are present in the archive.

Profile A, `d1-causal`:

```text
: minimal [actual key :minimal] = read
E/neutral = read
E/inputs = read
S/temp-readonly.txt = read
network.enabled = false
```

Profile B, `d1-bounded`:

```text
:minimal = read
E/neutral = read
E/inputs = read
/private/tmp = deny
/private/var/tmp = deny
:tmpdir = deny
S/scratch = write
network.enabled = false
```

There is **no glob deny** in profile B. The evidence directory's parent/root was not granted as a general readable root; `E/withheld/sentinel.txt` is a sibling of inputs and neutral. Paths are reported physical and non-symlink. Initial fixture modes are 0644: the read-only requirement was a sandbox-policy requirement, not chmod protection.

All nine actual probes use this command shape:

```text
/Applications/ChatGPT.app/Contents/Resources/codex sandbox
  --permission-profile <A-or-B>
  --include-managed-config
  -C <E/neutral>
  -c default_permissions="<A-or-B>"
  -c permissions.<A-or-B>=<complete-profile>
  -- <synthetic-command>
```

The inspected launcher always uses this inner sandbox command; no unsandboxed probe fallback appears in its code. Approval of the launcher and enforcement on the inner command remain different claims.

## 4. Complete probe-result inventory

| ID | Operation | Expected | Exit / retained result | Changed fixture |
|---|---|---|---|---|
| 01-A | `cat E/inputs/allowed.txt` | allow | 0; exact `D1-ALLOWED-n7lstg5k` content; PASS | none |
| 02-A | `cat S/withheld/sentinel.txt` | causal comparison | 0; exact `D1-TEMP-UNLISTED-n7lstg5k`; CAUSAL_OBSERVATION | none |
| 03-A | `cat E/withheld/sentinel.txt` | deny | 1; `Operation not permitted`; PASS | none |
| 04-A | append to `S/temp-readonly.txt` | deny | 0; FAIL | temp_readonly only |
| 05-A | append to `E/inputs/readonly.txt` | deny | 1; `Operation not permitted`; PASS | none |
| 06-B | `cat E/inputs/allowed.txt` | allow | 0; exact allowed content; PASS | none |
| 07-B | `cat S/withheld/sentinel.txt` | deny | 0; exact temp content; FAIL | none |
| 08-B | append to `E/inputs/readonly.txt` | deny | 1; `Operation not permitted`; PASS | none |
| 09-B | append to `S/scratch/write.txt` | allow | 0; PASS | scratch only |

The write commands were `/bin/sh -c 'printf "D1-WRITE-PROBE\n" >> "$1"' d1-probe <target>`. They address newly created synthetic targets, not actual G0 criteria or personal files.

04-A before/after content:

```text
BEFORE: D1-TEMP-READONLY-n7lstg5k\n
AFTER:  D1-TEMP-READONLY-n7lstg5k\nD1-WRITE-PROBE\n
```

SHA-256 changed from `d80a0ccea1ce1b64641e5ff8534ff499874c5c4d828f77cead6d935a0f15aede` to `7c1cc105305580b8dedf7bfa8d49145c2fc0d04a7ffe9d49106238e0ccda591c`. The non-temp read-only fixture retained `ed1bcc9f3812101f561967c38b061d1a6c5037b15b5f0a969ce5e036b1caf15f` throughout. Content hashes were independently recalculated from the archived strings.

All nine processes have recorded exits, no timeout, and elapsed durations of 0.123–0.206 seconds. `PROCESSES.json` records a final narrow ps check of those PIDs with no matching process. This is evidence of the recorded process closure, not a current whole-machine audit.

## 5. Runtime identity, budget and limits

`initial-runtime.json` records:

- binary `/Applications/ChatGPT.app/Contents/Resources/codex`;
- version `codex-cli 0.153.4`;
- binary bytes 237502224 and SHA-256 `42662bbc0522f0002eedc1e43dcda25d328176dda397d0428c0d33e26bff15ec`;
- actual help: `codex sandbox [OPTIONS] [COMMAND]...`, with singular `--permission-profile`;
- `codex help sandbox macos` rejected `macos` as a subcommand.

The earlier `sandbox macos --help` attempt is recorded as an incorrect command/help dispatch ending with `sandbox_apply: Operation not permitted`, exit 71. Its accounting is retained as an extra conservative attempt, not a synthetic file-access result. The nine successful launches plus that reported attempt consume D1's 10-attempt budget.

No child-model run was launched. The allowed optional model run was not used after the native prerequisite failed. CLI version equality is not binary-to-source provenance, and native commands are not qualification of an unexecuted agent-shell profile.

## 6. Protected inputs and source-copy comparisons

The supplied before/final records have identical hashes for four C1 repository files and 93 files in the original G0 evidence directory. Their Git identity/branch/ref/status/diff records also match and report clean C1 at `66e97050dd141f688fa4da8b26ac3823b020af37`, tree `37b60cde322a54012a023b521a2c214028e61e9e`, main/origin-main at `3776384a7789ccf1959b99bba92c8cf1b3131f81`.

The research assistant also compared those C1 file hashes with the previously uploaded G0 ZIP and all 89 G0 manifest-covered records with their D1 protection-record counterparts; they match. G0 startup boundary/result copies also match the older archive. D1 does not contain new full raw Git commit objects or a live checkout.

The archived D1 brief reproduces blob `cefef3a72b46809faebdc46b6e43f6d50dfe027a`; archived G0 review/extracts reproduce `bb95618266b8d5d31a2b0d327af09331fe1801ad` and `f66e20322e8fa3b27aeed4c68331d20cdafd36b3`. Beginning/closing research STATE snapshots reproduce `7790761a3b521ececca09f33666c77a8a29def5d` and `35be7b21299827ac7c9ddad97c0f3385a38c9137`. These are source fidelity checks, not evidence that every source was cognitively used.

## 7. Bounded conclusion from the supplied evidence

D1's summary is materially consistent with the detailed records. Its two failed controls remain failed. Outside-temp results support a narrower layout candidate, not automatic permission to expose real inputs or declare all temporary-path restrictions fixed.

The packet does not prove personal-file access, exfiltration, actual mutation of G0, complete global-config isolation, network enforcement, a model's unprompted policy violation, T1–T4 success or operating acceptance. The causal/code assessment and next-work recommendation are separate in `REVIEW.md`.
