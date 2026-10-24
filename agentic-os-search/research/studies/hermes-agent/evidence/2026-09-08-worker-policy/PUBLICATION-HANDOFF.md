# Publication handoff — NOT PUBLISHED

**Date:** 2026-09-08. **State:** local artifact delivery; canonical repository update NOT completed.

## Actual write failure

The GitHub discovery surface returned a `GitHub.create_file` schema. The actual invocation, intended to create `research/studies/hermes-agent/evidence/2026-09-08-worker-policy/SPEC.md` on main before execution, failed with:

```
Resource not found: GitHub.create_file.
Call api_tool.list_resources again to rediscover the currently available tools.
```

Subsequent discovery did not expose usable Git tree/ref/file writes; full discovery listed 48 read-oriented actions. The installed/enabled GitHub plugin search did not add a write path. No settings or permissions were changed. There is no evidence identifying the underlying cause as user permissions. This is a tool invocation/availability observation, not a diagnosis of GitHub repository ACLs.

The latest checked main in this turn remained **`36f1b7e6ae07da5c1d9d57ff9633d48473c42537`**. No successful new remote commit or ref update was observed, and no publish success is claimed. The experiment spec exists locally; it was not successfully pre-registered in the remote repository.

## Package verification

Use MANIFEST.json for every content file's bytes/SHA-256. It excludes only itself. Upstream complete source identities are additionally checked by the harness and listed in the results. Manual large-module excerpts have their own package hashes, not upstream full-module hashes. READ/EXECUTED/selected-vs-full distinctions must not be flattened during publication.

Original evidence files, timestamps and hashes must be preserved byte-for-byte; publishing is not rerunning tests. Prior U01B/U01B2/transport files, caller/memory notes and concurrent cross-project work must not be overwritten.

## Suggested mapping and safe continuation

1. Re-fetch `AGENT.md` and necessary control protocols according to the canonical bootstrap, then current root/studies catalog/package state. Do not inherit this handoff's base as current HEAD.
2. Publish the package evidence files beneath `research/studies/hermes-agent/evidence/2026-09-08-worker-policy/`. If that path already exists, inspect it rather than replacing it blindly. All experimental source/results/spec/script files retain their bytes and local relative links.
3. Copy REPO-NOTE-09.md to `research/studies/hermes-agent/notes/09-WORKER-POLICY-EXECUTION-BOUNDARY.md` only if that number/path is free; otherwise choose a non-conflicting current entry and update links. The full research remains RESEARCH.md in the evidence folder.
4. Apply the semantic updates in CONTINUATION-DELTA.md to current STATE/source ledger/INDEX/META/catalog/plan/questions selectively. Do not replace canonical files with stale whole copies. This package does not assert an accepted new plan version.
5. Record actual successful publication in a new publication record, leaving this failed handoff and the original run files historical. Prefer an atomic commit when a suitable tool exists; use non-forced ref updates and protect simultaneous changes. Re-read the actual commit/ref and evidence identities before reporting success.

The current technical next question remains complete pinned-module/real review construction integration with a harmless handler, not more repetitions of the same selected-function fixture. The broader pending/memory/ledger/curator/family continuation stays in scope. No system installation, provider call, credential access, upstream mutation, Foundation change or adoption is authorized by this handoff.

A fresh session that only reads the unchanged canonical repository will not know this work slice. That continuity gap is explicit; the local ZIP is a recovery delivery, not a second canonical repository.
