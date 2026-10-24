# gstack — Browser Runtime, Security Boundaries, and Evidence Semantics

## Status and boundary

**Status:** BOUNDED SUBSYSTEM SYNTHESIS  
**External target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Observed:** 2026-09-05  
**Package:** 1.79.0

This synthesis reconstructs the browser/runtime mechanism that upstream QA, ship, design-review and other workflows treat as an evidence-producing execution environment.

It covers:

- the long-lived browser daemon and browser lifecycle;
- the browser command/evidence surface;
- tab/session/reference state;
- local versus tunnel exposure;
- root/scoped-token authorization;
- pair-agent isolation semantics;
- URL/path/CDP capability boundaries;
- session persistence;
- content/prompt-injection defense layers;
- audit/activity evidence;
- selected deterministic and behavioral tests.

It does **not** establish that the browser subsystem is universally secure. It does not independently validate gstack's threat model, does not reproduce a live ngrok exposure, does not prove complete prompt-injection resistance, and does not yet synthesize the separate `cso`, `careful`, `freeze`, `guard`, or broader host-security workflows.

The subsystem is studied in gstack-native terms. Foundation projection remains deferred.

---

## 1. Executive reconstruction

gstack's browser is not a thin Playwright helper. At the pinned revision it is a persistent execution/control subsystem with its own:

```text
skill / operator contract
        ↓
CLI client
        ↓
long-lived local daemon
        ↓
BrowserManager + per-tab TabSession
        ↓
Playwright Chromium / persistent context
        ↓
command handlers + snapshot/ref layer
        ↓
security / authorization / persistence / audit boundaries
```

The important architectural consequence is that `$B` evidence used by QA/ship is produced through a stateful runtime, not one isolated browser invocation per command.

The same persistence that makes iterative QA cheap also creates evidence hazards: stale tabs, stale refs, inherited browser state, authentication state, and user/agent ownership all need explicit lifecycle controls.

The design repeatedly treats those hazards as **state-validity problems**, not just browser-automation problems.

---

## 2. Persistent execution is a deliberate system property

`browse/SKILL.md.tmpl` presents a persistent Chromium workflow: first call starts the browser/daemon, later commands reuse it. The actual runtime supports that model.

`browse/src/server.ts` is a long-lived Bun HTTP daemon that dispatches browser commands. `browse/src/browser-manager.ts` owns browser/context/page lifecycle. `browse/src/tab-session.ts` holds tab-local operational state.

The runtime separates at least two browser modes:

- **launched/headless:** regular `chromium.launch()` plus a browser context;
- **headed:** `launchPersistentContext()` with a persistent Chromium profile and visible browser window.

The headed path is not merely `headless: false`; it has different persistence, dialog and user-control semantics. User handoff/resume can promote the browser into a visible interactive state while preserving cookies/storage/tabs.

### Evidence consequence

Browser evidence is session-relative. A screenshot or assertion can be technically correct while observing the wrong inherited tab/state.

The browser skill itself warns that:

- tabs persist across calls;
- `reload` or `screenshot` without an explicit `goto` can target an earlier page;
- hover can alter scroll position before a screenshot.

So persistent execution improves throughput, but it also means **freshness must be constructed**. QA consumers that start with explicit navigation and re-snapshotting are not cosmetic best practices; they are evidence-validity controls.

---

## 3. Browser state is decomposed rather than treated as one opaque session

### 3.1 Per-tab state

`browse/src/tab-session.ts` extracts state that belongs to an individual tab:

```text
TabSession
├─ Page
├─ ref map (@e*, @c*)
├─ last snapshot baseline
├─ active frame
└─ loaded HTML replay state
```

This supports parallel/batch execution without forcing all element references and diff baselines into one global browser state.

Main-frame navigation clears stale refs, active frame, and loaded-HTML replay metadata. Detached frames also invalidate refs.

This matters because element references are only valid relative to the page/frame state from which they were generated.

### 3.2 Snapshot → ref → action

The preferred interaction pattern is:

```text
ARIA snapshot
   ↓
parse semantic roles/names
   ↓
assign @e1, @e2 ...
   ↓
store Playwright Locator objects in the active TabSession
   ↓
click/fill/is/etc. by @ref
```

The snapshot implementation also adds `@c*` refs for cursor-interactive / onclick / tabindex elements that may be absent from the accessibility tree.

A stale or missing ref fails with an instruction to obtain a fresh snapshot rather than silently re-resolving an unrelated selector.

### 3.3 Evidence ambiguity is sometimes surfaced explicitly

Annotated screenshots can encounter locators that resolve ambiguously or cannot be measured. The implementation records ambiguity/skips in the output rather than silently claiming a fully faithful annotation.

This is an important evidence design choice:

```text
image produced
≠
all annotations uniquely grounded
```

The artifact can carry a degraded-evidence note.

---

## 4. The command surface is broader than its historical read/write labels

`browse/src/commands.ts` is the shared command registry used by runtime dispatch and documentation generation.

It exposes navigation, reading, inspection, interaction, extraction, visual, tab, server and meta operations.

However, the top-level `READ_COMMANDS` / `WRITE_COMMANDS` classification is **not itself the security authority**.

For example, the historical READ set includes operations such as:

- `js`;
- `eval`;
- `cookies`;
- `storage`.

The scoped-token subsystem explicitly reclassifies dangerous operations according to actual side effects. `browse/src/token-registry.ts` places JS execution, credential/storage access and page mutations into an `admin` capability class.

Therefore:

> command documentation taxonomy and security-capability taxonomy are related views, not interchangeable truth sources.

This correction is source-explicit: the token registry says the command registry's historical READ classification is too permissive for security decisions.

---

## 5. Authorization is multi-dimensional

The runtime does not reduce authorization to “has a bearer token.”

A scoped browser client can be constrained by:

```text
client identity
+ capability scopes
+ domain allowlist
+ tab policy / ownership
+ request rate
+ expiry
+ exposed listener surface
```

### 5.1 Root versus scoped tokens

The root token represents local administrative authority and receives all scope classes.

Scoped tokens are issued either directly or through a setup-key pairing ceremony. Setup keys are short-lived and single-use with bounded idempotent reconnect behavior.

The reserved client ID `root` cannot be used by a scoped token because downstream scope/domain/rate checks use that identity as the omnipotent sentinel. Persisted malicious `root` entries are skipped on restore.

Root-token comparison uses constant-time comparison after a byte-length check.

### 5.2 Scope classes

The token registry defines:

- `read`;
- `write`;
- `admin`;
- `meta`;
- `control`.

`control` covers browser-wide destructive/lifecycle operations and does not ride in implicitly with normal pair scopes.

The default pair ceremony grants read/write/admin/meta, but control remains explicit.

### 5.3 Domain restrictions

Scoped tokens can carry domain restrictions. Navigation-like operations including `goto` and `newtab` are checked against those restrictions.

### 5.4 Rate and expiry

Scoped tokens carry rate limits and expiry. The pairing `/connect` surface also has a global flood-control rate limiter.

### 5.5 Re-pairing can immediately reduce authority

A particularly important control behavior is **grant reduction**.

If an existing client is re-paired with a strictly narrower grant — fewer scopes, narrower domains, lower rate, or stricter tab policy — the old session can be revoked immediately rather than waiting for the remote agent to reconnect.

The implementation intentionally fails toward revocation where domain-superset reasoning is not provable.

This means authority reduction is treated as a state transition that should become effective now, not only on next session creation.

---

## 6. Tab ownership is a contextual isolation boundary, not a universal one

This subsystem contains an easy-to-overstate result.

### Pair-agent / tunnel

Scoped tokens with `tabPolicy: own-only` must own the target tab for both reads and writes. `newtab` is exempt from the pre-access check so the agent has a way to create a tab it can own.

This is the strict multi-agent browser-isolation mode.

### Local skill execution

Local/shared-policy scoped clients are intentionally different. They can operate on unowned tabs and even tabs owned by another client.

The source comments are explicit: local skill ergonomics require bundled browser skills to drive the user's existing natural tabs, so tab ownership is **not** treated as the security boundary for those shared clients. Capability scopes and the local trust boundary carry the responsibility instead.

Therefore the correct claim is:

> gstack implements strict tab isolation for the own-only pair-agent/tunnel context; it does not promise universal cross-agent tab isolation for all scoped browser clients.

### Revocation and ownership

When a client is revoked, its tab ownership can be released so a future client reusing the same name cannot inherit authenticated access to those tabs merely because authorization checks compare `owner === clientId`.

This is a useful example of identity lifecycle and resource ownership being coupled explicitly.

---

## 7. Local and remote exposure are separated by listener topology

The most concrete browser-network security boundary is the dual-listener design.

When tunnel mode is active, the server does not merely expose the same local HTTP port and rely on route-by-route auth.

Instead:

```text
LOCAL listener
  broader local/bootstrap/admin surface

TUNNEL listener
  /connect
  /command
```

ngrok is pointed at the tunnel listener's ephemeral local port, not the local daemon port.

The source states the security property directly: bootstrap endpoints are unreachable to tunnel callers because they are on a different TCP listener.

Additional tunnel constraints include:

- a closed path allowlist;
- root tokens rejected on the tunnel surface;
- scoped-token requirement for command use;
- a closed tunnel-command allowlist;
- command-level scope/domain/rate/tab checks;
- remote disk-write forms such as `js/eval --out` disallowed over the tunnel.

### Verification strength

`browse/test/dual-listener.test.ts` uses exact-set source assertions so widening `TUNNEL_PATHS` or `TUNNEL_COMMANDS` requires an intentional test update.

`browse/test/pair-agent-e2e.test.ts` spawns a real browse daemon and behaviorally exercises the HTTP ceremony:

```text
root /pair
→ setup key
→ /connect
→ scoped token
→ allowed / denied command behavior
```

But that E2E explicitly does **not** launch a real ngrok tunnel.

So:

```text
dual-listener shape            → strongly structurally pinned
pair/connect scoped HTTP flow  → behavioral E2E
live public ngrok exposure      → not reproduced by inspected E2E
```

---

## 8. Extension bootstrap avoids putting the root token into health/status

`/health` is liveness-only and intentionally does not expose the root token.

The side-panel extension obtains the token through a separate local `POST /extension-token` path, gated by:

- the pinned extension origin;
- loopback host validation.

The tunnel surface cannot reach that path.

The significance is not simply “token endpoint has auth.” It is a separation between:

```text
liveness visibility
and
credential bootstrap
```

The repository contains regression checks preventing a return to a health endpoint that leaks token or browsing-state information.

---

## 9. CDP is a deny-default capability escape hatch

Raw Chrome DevTools Protocol access could bypass higher-level browse safety checks. gstack therefore does not provide arbitrary CDP forwarding.

`browse/src/cdp-allowlist.ts` defines an explicit allowlist. Each admitted method records:

- domain;
- method;
- tab- or browser-wide lock scope;
- trusted/untrusted output classification;
- written justification.

Important denied examples include:

```text
Runtime.evaluate
Runtime.callFunctionOn
Runtime.compileScript
Runtime.runScript
Page.navigate
Network.getResponseBody
Network.getCookies
Browser.close
Browser.crash
Target.createTarget
Target.attachToTarget
```

`Page.navigate` is intentionally absent so navigation must use the higher-level path that applies URL validation.

### Concurrency control

The CDP bridge uses per-tab versus browser-global locks depending on method classification, with acquisition and call timeouts and `finally` release semantics.

### Behavioral evidence

`browse/test/cdp-e2e.test.ts` starts real Chromium and confirms, among other cases:

- admitted accessibility/performance methods execute;
- untrusted CDP output is wrapped;
- `Runtime.evaluate` is denied;
- `Page.navigate` is denied;
- `Network.getResponseBody` is denied.

This is stronger than a documentation-only deny list: selected capability boundaries are behaviorally exercised against a real CDP session.

---

## 10. URL validation is a shared SSRF/navigation boundary

`browse/src/url-validation.ts` centralizes navigation URL validation.

It blocks or constrains:

- unsupported schemes such as `javascript:` and `data:`;
- cloud metadata targets;
- encoded/alternate metadata IP representations;
- IPv6 ULA and link-local ranges relevant to metadata/internal access;
- unsafe `file://` locations;
- DNS resolutions that land on blocked metadata addresses.

Loopback/private-network access remains permitted because local QA is a primary use case.

A notable failure-semantic caveat: unexpected DNS infrastructure failure in the rebinding probe is fail-open rather than blocking all navigation.

### Direct fetch paths

The repository found and repaired a class where `download` / `scrape` could call `page.request.fetch()` directly and bypass the `goto` safety path.

Regression tests now require direct fetch call sites to pass through `validateNavigationUrl()` before network access.

This is a useful systemic correction:

> securing the obvious navigation command was insufficient because the same external effect was reachable through another command family.

The control was moved toward the shared effect boundary instead of remaining a single-command patch.

---

## 11. Filesystem effects are constrained separately from browser scopes

Browser commands can write screenshots, PDFs, downloads, archives, scrape manifests and `js/eval --out` results.

`browse/src/path-security.ts` centralizes path validation for those effects.

The implementation accounts for:

- absolute path normalization;
- safe-directory containment;
- symlink traversal;
- target-parent validation for new files;
- stricter temp-only policy for remote file serving.

Remote `/file` serving is intentionally narrower than local command writes: project files are not made remotely downloadable merely because local commands may write/read inside the project cwd.

`browse/src/file-permissions.ts` additionally attempts owner-only permissions for sensitive state on POSIX and Windows.

Important limitation:

> permission hardening is explicitly best-effort in several failure paths.

The filesystem remains functional when ACL/chmod hardening cannot be achieved, with warnings in selected cases. Therefore file-permission hardening must not be described as an unconditional fail-closed security guarantee.

---

## 12. Session persistence separates continuity from authority/content replay

### Headed mode

Headed mode already uses a persistent Chromium profile.

### Headless mode

Cross-daemon session persistence is opt-in via `BROWSE_PERSIST_STATE=1`.

When enabled, the daemon persists:

- cookies;
- URL;
- localStorage;
- sessionStorage.

It deliberately does **not** persist:

- loaded HTML;
- tab owner identity.

The rationale is security-sensitive: a tampered state file must not be able to inject HTML around `load-html` checks or forge an agent's ownership standing.

Additional controls include:

- owner-only file permissions where supported;
- atomic temp-write → rename;
- filtering of malformed/internal-network cookies;
- URL revalidation during restore;
- corrupt-state quarantine to `.corrupt` and fresh boot instead of permanent startup failure.

### Behavioral evidence

`browse/test/session-persist.test.ts` contains a real-Chromium round trip:

```text
launch browser
→ create cookie/localStorage/URL state
→ persist
→ full browser teardown
→ relaunch
→ restore
→ verify surviving and filtered state
```

So selected continuity claims are supported behaviorally, not only structurally.

### Evidence caveat

The skill phrase “state persists between calls” is true inside the live daemon. It should not be broadened to “headless state always survives daemon restart”; cross-restart persistence is opt-in.

---

## 13. Prompt-injection/content defense is layered but not a proof of safety

The browser has several content-safety mechanisms.

### Deterministic/string-level layers

`browse/src/content-security.ts` includes:

- session datamarking for selected text output;
- hidden/deceptive element marking and stripping;
- ARIA injection-pattern checks;
- content-filter hooks;
- exfiltration-oriented URL blocklist;
- untrusted-content envelopes;
- escaping of forged envelope sentinels.

The central server wrapping path marks page-derived content as untrusted, especially for scoped clients.

### Instruction layer

Pair-agent instructions also contain an explicit SECURITY block telling the receiving agent not to follow instructions from untrusted browser content.

This is a policy layer, not runtime proof.

### Optional ML layer

A TestSavantAI BERT-small/ONNX classifier runs in a separate Node sidecar because the compiled Bun binary cannot safely package the native dependency.

The sidecar is lazy, bounded by timeouts/request size, and uses a failure circuit breaker.

The classifier is explicitly **fail-open**: model load/classification failure removes the L4 signal and lower deterministic layers continue.

Therefore:

```text
ML classifier available
→ extra defense-in-depth signal

ML classifier unavailable
→ no L4 certification; lower layers remain
```

The correct conclusion is not “gstack solves prompt injection.” The source establishes layered mitigations and selected tests, while adaptive-attack robustness and independent benchmark validity remain open.

---

## 14. Security standing itself is treated as evidence that can become stale

A notable epistemic-security decision appears in `browse/test/server-security-surface.test.ts` and the related code cleanup.

An older `/health.security` style surface depended on state that no longer had a live writer after a prior architecture change. Keeping the reader could produce:

```text
stale persisted state
→ "protected" / false-green status
```

when the actual condition was:

```text
not currently measured
```

The stale surface was removed and regression-pinned.

This is stronger than merely adding another security layer. It encodes a principle:

> absence of current measurement must not be represented as positive security standing.

This finding remains gstack-native candidate evidence. It is not promoted into Foundation by this study.

---

## 15. Audit and live activity are different evidence surfaces

The browser runtime has two distinct observability paths.

### Persistent command audit

`browse/src/audit.ts` appends JSONL command records containing fields such as:

- timestamp;
- canonical command / alias;
- truncated args;
- origin;
- duration;
- ok/error status;
- error detail;
- cookie-import context;
- launched/headed mode.

This is intended as a forensic trail across daemon restarts.

But audit writes are explicitly best-effort and never block the command.

Therefore:

```text
command succeeded
≠
audit record definitely persisted
```

The audit trail is useful evidence but not an admission/control dependency.

### Live activity stream

`browse/src/activity.ts` maintains a bounded in-memory ring buffer and SSE/history surface for command start/end, navigation and errors.

It:

- associates activity with client identity;
- redacts selected sensitive args/query parameters;
- truncates result previews;
- detects when a consumer cursor fell behind an evicted buffer range.

The activity stream is real-time operational visibility, not a durable complete forensic log.

This distinction matters because a bounded ring buffer with gap detection is more honest than presenting it as complete history.

---

## 16. Security failure polarity is intentionally heterogeneous

The browser subsystem does not implement one universal fail-closed policy.

Examples:

### Strong/closed behavior

- unknown CDP method → deny;
- root token on tunnel → reject;
- non-tunnel route on tunnel listener → 404;
- unsafe URL schemes / metadata targets → reject;
- unsafe file target → reject;
- own-only client on unowned tab → reject;
- invalid/reserved token options → reject;
- tunnel listener bind failure → no fallback to local listener;
- narrowing re-pair can revoke existing broader authority immediately.

### Graceful/best-effort behavior

- ML classifier unavailable → lower layers continue;
- filesystem permission hardening failure → often warning/best effort;
- audit-write failure → command continues;
- unexpected DNS failure in metadata-rebinding probe → navigation check fails open;
- content-filter default mode is warn rather than global block.

This asymmetry should be preserved in any later system model. A label such as “security layer” is not enough to infer control strength.

---

## 17. Selected verification map

| Claim / mechanism | Evidence observed | Strength / limit |
|---|---|---|
| daemon + BrowserManager stateful topology | implementation source + architecture docs | strong implementation observation |
| per-tab refs/frame/session state | full `tab-session.ts` + browser/snapshot source | strong implementation observation |
| session persistence round-trip | unit + real Chromium teardown/relaunch test | behavioral evidence for selected path |
| root/scoped-token scope model | token-registry source + unit tests + pair E2E | strong first-party behavioral/structural support |
| own-only tab isolation | server gate + BrowserManager logic + unit/source tests; selected pair flow coverage | strong structural/unit evidence; do not generalize to shared clients |
| local/tunnel path separation | server implementation + exact-set source tests | strong structural pin |
| live public tunnel | not reproduced in inspected suite | open |
| pair/connect scoped-token ceremony | real daemon HTTP E2E | behavioral evidence |
| CDP deny-default | allowlist + unit tests + real Chromium CDP E2E | strong selected behavioral evidence |
| URL/SSRF controls | shared implementation + unit/source regression tests | strong structural/unit evidence; external DNS behavior not independently audited |
| filesystem path controls | implementation + relevant tests observed | strong first-party implementation evidence |
| permission hardening | implementation | platform-dependent, explicitly best-effort |
| content envelopes/hidden-content filters | implementation + focused tests | deterministic layer evidence |
| ML prompt-injection classification | implementation/sidecar contract | optional fail-open defense; benchmark/oracle not independently validated here |
| persistent audit | implementation | useful but best-effort; not guaranteed complete |
| live activity feed | implementation + auth/source checks | bounded observability, not durable complete history |
| overall browser security | no independent reproduction / penetration evaluation | **not established** |

---

## 18. Strongest subsystem conclusions

### B1 — `$B` is an evidence-producing runtime, not merely a command wrapper

**Status:** strong subsystem inference.

QA/ship browser evidence depends on a stateful daemon, browser lifecycle, per-tab state, snapshot/reference semantics, and effect/security controls.

### B2 — persistence creates both capability and evidence risk

**Status:** strong cross-source inference.

The runtime deliberately preserves state for speed and user continuity, then compensates with explicit navigation, ref invalidation, ownership, restart/persistence gates and restore validation. Evidence freshness is an active operation.

### B3 — authority is represented as capabilities over effects, not only actor identity

**Status:** strong implementation observation.

Token scopes, domains, rate, expiry, listener surface and tab policy jointly determine effective action authority.

### B4 — strict isolation is context-specific

**Status:** strong corrective finding.

Own-only pair-agent/tunnel clients receive strict tab isolation. Local shared-policy skills intentionally do not. Any whole-system statement must preserve this boundary.

### B5 — high-risk escape hatches are routed through narrower capability gates

**Status:** strong implementation + selected behavioral support.

Raw CDP, remote tunneling, file output, URL navigation, credential/storage operations and browser-wide control are not all exposed under one generic read/write permission.

### B6 — evidence channels carry explicit degradation in several places

**Status:** strong subsystem inference.

Stale refs fail, activity gaps are detectable, annotation ambiguity is surfaced, corrupt persistence is quarantined, and dead security-status feeds were removed rather than presented as current truth.

### B7 — security mechanisms have different enforcement polarities

**Status:** strong synthesis conclusion.

Some boundaries are deny-default/hard fail, while ML classification, audit and permission hardening are intentionally graceful/best-effort. “Security enabled” is too coarse a state.

### B8 — the source contains examples of systemic rather than one-call security repair

**Status:** bounded causal inference.

Examples such as moving URL validation to direct fetch paths, preventing stale security-status claims, and revoking broad sessions on authority reduction address broader failure classes rather than only the triggering call site.

---

## 19. Remaining browser/security gaps

This bounded synthesis is sufficient to treat the browser runtime as reconstructed for the current research ladder, but several security topics remain open and should be picked up by later clusters when relevant:

1. full `pair-agent` workflow/orchestrator behavior beyond the browser-side ceremony;
2. `cso` security-review workflow and its relationship to runtime controls;
3. `careful` / `freeze` / `guard` / `unfreeze` guarded-action mechanisms;
4. complete command-by-command effect audit;
5. live ngrok/tunnel exposure under hostile conditions;
6. independent prompt-injection / SSRF / filesystem attack testing;
7. full platform portability/security behavior across Windows/Linux/macOS;
8. complete audit-log test coverage and retention behavior;
9. browser skill subcommands / domain-skill execution beyond the core runtime;
10. relationship between browser runtime and production canary/deployment observation.

These are later-study dependencies, not reasons to keep this subsystem permanently open.

---

## 20. Cross-subsystem consequence for the gstack model

The preceding planning and ship syntheses showed that gstack repeatedly constructs a **qualified state** before consequential continuation.

The browser subsystem adds a different layer:

```text
qualified work intent
        ↓
actor / token authority
        ↓
runtime capability boundary
        ↓
observable external effect
        ↓
evidence artifact / activity / audit
        ↓
freshness / ambiguity / trust classification
        ↓
consumer qualification decision
```

This suggests a stronger gstack-native working hypothesis:

> gstack is not only a workflow library; it is a qualification-driven work system in which prompts, durable artifacts, runtime capabilities and evidence channels are connected by explicit authority and control transitions.

This remains a **working cross-subsystem hypothesis**, not yet a whole-gstack conclusion. It must survive investigation, memory/context, multi-agent, production-feedback and eval-infrastructure research before becoming a core synthesis.

---

## 21. Source re-entry map

Load-bearing upstream sources for this synthesis include:

- `browse/SKILL.md.tmpl`
- `BROWSER.md`
- `ARCHITECTURE.md`
- `browse/src/server.ts`
- `browse/src/browser-manager.ts`
- `browse/src/tab-session.ts`
- `browse/src/commands.ts`
- `browse/src/token-registry.ts`
- `browse/src/snapshot.ts`
- `browse/src/cdp-allowlist.ts`
- `browse/src/cdp-bridge.ts`
- `browse/src/url-validation.ts`
- `browse/src/path-security.ts`
- `browse/src/file-permissions.ts`
- `browse/src/session-persist.ts`
- `browse/src/content-security.ts`
- `browse/src/security.ts`
- `browse/src/security-classifier.ts`
- `browse/src/security-sidecar-client.ts`
- `browse/src/audit.ts`
- `browse/src/activity.ts`
- `browse/test/dual-listener.test.ts`
- `browse/test/server-factory.test.ts`
- `browse/test/server-auth.test.ts`
- `browse/test/pair-agent-e2e.test.ts`
- `browse/test/tab-isolation.test.ts`
- `browse/test/token-registry.test.ts`
- `browse/test/cdp-allowlist.test.ts`
- `browse/test/cdp-e2e.test.ts`
- `browse/test/url-validation.test.ts`
- `browse/test/session-persist.test.ts`
- `browse/test/content-security.test.ts`
- `browse/test/server-security-surface.test.ts`

Use `../SOURCE-LEDGER.md` for exact read status and blob identifiers recorded during the study. Return to the pinned upstream source before load-bearing reuse where the ledger says `SUBSTANTIAL / CONTINUE` rather than `FULL`.
