# U01-M3 — Slash-policy component probe

Date: 2026-09-10. Upstream pin: c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a.

## Question and boundary

What does the actual additional slash-command authorization module decide, given an already-supplied gateway configuration and source identity? This does NOT authenticate a person, run a real gateway, prove a routed deployment's config ownership, execute pending writes, or send a model request.

The complete `gateway/slash_access.py` must match Git blob `07204201e411f29f912bb9bba6beec0566acab9d` before import. Only stdlib dependencies. Source/config objects are synthetic `SimpleNamespace` values. No credentials, network, provider, subprocess or user files. No previous M2 probes are repeated.

## Predetermined diagnostic expectations

- SA01: no admin list, even with a user-command list, leaves this second gate disabled; guest memory/skills allowed by THIS gate only.
- SA02: DM admin list activates the gate; guest memory/skills denied, help/whoami retained; owner memory/skills allowed.
- SA03: `/MeMory` in the user-command config normalizes to memory; guest memory allowed, skills denied. Caller must still supply canonical command names.
- SA04: DM and group admin lists are distinct. Setting only a DM admin list does not activate the group gate. With both lists set, a DM-only administrator cannot run group skills.
- SA05: empty DM command list falls back to group command names, without borrowing group administrators.
- SA06: changing only `source.profile` between two fixture profiles leaves the decision unchanged when the supplied config/platform/chat_type/user stay fixed. Supplying a different config changes the decision. This is parameter sensitivity, NOT a demonstrated deployment isolation failure.
- SA07: absent gateway config or missing platform config disables this gate. Earlier external-user admission is outside this module and must not be inferred absent.
- SA08: empty/None chat_type uses the group branch despite the empty-string entry in `_DM_CHAT_TYPES`; `dm` uses DM. Normal platform source construction is not tested.

Sensitivity: the same loaded module must give a different denial after removing the configured user grant (SA03), and after changing supplied configuration (SA06). A one-byte-modified source copy must be rejected by the SAME pre-import guard, not merely yield a hash inequality.

These are source-informed exploratory cases fixed before their first run, not independent product verification or a random/representative sample. Record actual values and exceptions; do not reclassify a failed expectation as product PASS. Source transcription was corrected only before import to match the pre-existing canonical hash; the expected hash was not changed.
