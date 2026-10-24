# U01-M3 / slash-access — bounded diagnostic specification

Date: 2026-09-10. Scope fixed before this recorded run. Source-informed exploratory checks, not independent holdout verification.

Object: full `gateway/slash_access.py` from Hermes pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, Git blob `07204201e411f29f912bb9bba6beec0566acab9d`. Only Python standard-library dependencies. Source must match this identity before import. Synthetic config/source inputs; no gateway, account, provider, user files or network.

AP01: without an admin list, the slash gate is disabled even if a user command list exists; this says nothing about ingress authorization.
AP02: with a DM admin list, non-admin memory is denied, admin memory allowed, help/whoami remain available.
AP03: slash/case normalization grants the canonical memory command, not skills. A literal 'memory approve' entry is not a subcommand policy and does not grant canonical 'memory'. The production caller separately supplies the canonical command name.
AP04: DM and group administrators are independent; absence of group administrators disables that separate scope rather than importing the DM list.
AP05: an empty DM command list falls back to the group command list, but not its administrator list.
AP06: a missing user id cannot use gated memory, while the help floor remains allowed. Missing config returns a disabled *slash* policy, not full gateway admission.

Oracle: expected boolean decisions below are written independently of the function return values before execution. These checks exercise policy interpretation, not complete authentication, actual pending replay, config hot reload, gateway dispatch or cache freshness.

Negative identity check: mutate source bytes in memory and feed them to the same pre-import verifier; it must reject them before import. No claim that this alone validates source semantics.
