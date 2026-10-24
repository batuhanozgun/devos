# ECC U01-A — Cache reference coverage probe

**Date:** 2026-09-17. **Class:** source-informed exploratory local execution. Not a Codex installation, live-host test, independent replication or upstream test-suite run.

## Target and hypothesis

Pinned target `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`:

- `scripts/codex/check-plugin-cache.js`, blob `6839b413cc78d6755cc56f61be0d57f4754b5fa6`.
- `.codex-plugin/plugin.json`, blob `7ad227cac60a8ce5d97e6d152e449812857d13eb`.

The checker says all cached manifest references resolve when its collected list passes. The current manifest adds a `hooks` path, but `collectManifestRefs` collects only skills, MCP, composer icon and logo. The bounded question is whether missing hook content can coexist with checker success.

[PROBE-PLAN.json](PROBE-PLAN.json) was written before executing these three cases, after inspecting the source. This is not a blind or independent preregistered experiment. The source-based prediction (exit 0 for C1) is distinct from the desired complete-reference criterion (C1 should be rejected).

## Execution and results

The unchanged checker and manifest were materialized from the GitHub text reads. Both local byte sequences were checked with Git's blob SHA-1 framing and matched the upstream blob IDs before execution. No full checkout is claimed. A synthetic root `package.json` contains only the version field read by this checker. All other target contents are dummy files; an empty skills directory is intentional. This is a presence/type test, not a valid-runtime baseline.

| Case | Difference | Actual exit | Interpretation |
|---|---|---:|---|
| C0 | All five referenced targets exist | 0 | Presence-only baseline accepted |
| C1 | Only hook file absent | 0 | Missing current manifest reference was missed |
| C2 | Hook restored; MCP file absent | 1 | Missing checked reference detected; sensitivity control |

[RESULTS.json](RESULTS.json) preserves commands, exact temporary paths, stdout, stderr, source identities, plan/runner SHA-256 and environment. Observed environment: Linux x86_64, Node v22.16.0, Python 3.13.5. The temporary directories in raw logs were deleted after execution; they are not persistent evidence locations.

Do not summarize this as 'three product tests passed'. One of the three cases demonstrates a false-green under the stated all-reference existence claim. It does not show a real user has a broken cache, that Codex would accept it, or that missing hook content is undetected by every other control.

## Reproduce

Fetch the two source files above at the pinned commit through an authorized source access path. Then run:

```bash
python3 run-cache-probe.py --checker /path/to/check-plugin-cache.js --manifest /path/to/plugin.json --plan PROBE-PLAN.json --output /path/to/new-results
```

The runner rejects source identity drift before running Node. It uses only a temporary source tree/cache/home and invokes no shell, package manager, ECC installer, network service, credential flow or Codex executable. It copies no real user cache. The local fixture does not execute hook definitions.

## Remaining boundary

Manifest inclusion, package/cache materialization, hook trust, hook invocation, correct context content and task benefit are separate claims. This probe tests only the checker's coverage of declared path existence. The wider install/bootstrap/consumer chain remains open in Q02/Q03/Q08 and U01-B. See [the bounded note](../../notes/01-SURFACES-AND-CODEX-CACHE.md).
