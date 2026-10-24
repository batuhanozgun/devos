def _bot_chat_prompt_stale(agent, stored_prompt: str) -> bool:
    """Bot Chat capability epoch check for a stored prompt.

    The stored prompt embeds a capability fingerprint; a mismatch is a deliberate
    once-per-change rebuild. Unstamped prompts never match; probe failures fail closed
    to "reuse" so the cache is kept. Legacy upgrade: a Bot Chat prompt predating the
    epoch mechanism gets ONE title-gated migration rebuild; the stamped result cannot
    re-fire."""
    try:
        from tools.bot_mode_probe import (
            BOT_CHAT_TITLE,
            stored_bot_chat_prompt_needs_upgrade,
            stored_prompt_capability_stale,
        )
        home = None
        try:
            from agent.system_prompt import _agent_home
            home = _agent_home(agent)
        except Exception:
            pass
        if stored_prompt_capability_stale(stored_prompt, home):
            return True
        if not getattr(agent, "_bot_mode_protocol", True):
            return False
        title = str(getattr(agent, "_session_title_hint", "") or "").strip()
        if not title and agent._session_db and agent.session_id:
            try:
                title = str(agent._session_db.get_session_title(agent.session_id) or "").strip()
            except Exception:
                title = ""
        return title == BOT_CHAT_TITLE and bool(stored_bot_chat_prompt_needs_upgrade(stored_prompt, home))
    except Exception:
        return False


def _persist_system_prompt(agent, failure_message: str, *, persist_tools: bool = False) -> None:
    """Persist ``agent._cached_system_prompt`` to the session row; failures log at WARNING
    (with ``failure_message``) because the gateway path (fresh AIAgent per turn) reads
    this row every turn, so a silent failure breaks prefix-cache reuse."""
    if not agent._session_db:
        return
    try:
        agent._session_db.update_system_prompt(agent.session_id, agent._cached_system_prompt)
        if persist_tools:
            from tools.mcp_tool_agent import persist_agent_tool_names
            persist_agent_tool_names(agent)
    except Exception as exc:
        logger.warning(failure_message, agent.session_id, exc)


def _restore_or_build_system_prompt(agent, system_message, conversation_history):
    """Restore the cached system prompt from the session DB or build it fresh.

    Mutates ``agent._cached_system_prompt`` and persists a freshly-built prompt on first
    build. Row states ``missing``/``null``/``empty``/``present`` are logged and DB
    failures log at WARNING so silent prefix-cache misses show in ``agent.log``."""
    stored_prompt = None
    stored_state = "missing"
    session_row = None
    if conversation_history and agent._session_db:
        try:
            session_row = agent._session_db.get_session(agent.session_id)
            if session_row is not None:
                raw_prompt = session_row.get("system_prompt")
                stored_state = "null" if raw_prompt is None else ("empty" if raw_prompt == "" else "present")
                stored_prompt = raw_prompt or None
        except Exception as exc:
            logger.warning(
                "Session DB get_session failed for system-prompt restore (session=%s): %s. "
                "Falling back to fresh build — prefix cache will miss for this turn.",
                agent.session_id, exc,
            )

    if stored_prompt and _stored_prompt_matches_runtime(agent, stored_prompt):
        if _bot_chat_prompt_stale(agent, stored_prompt):
            logger.info(
                "Bot Chat capability epoch changed for session %s; rebuilding system prompt to "
                "adopt the new capability surface (one-time prefix-cache break).",
                agent.session_id,
            )
            agent._session_title_hint = "Bot Chat"
            # The skills index cache (LRU + disk snapshot) does not watch the skills
            # dir; a capability refresh must rebuild THROUGH it or new skills are lost.
            try:
                from agent.prompt_builder import clear_skills_system_prompt_cache
                clear_skills_system_prompt_cache(clear_snapshot=True)
            except Exception:
                pass
            agent._cached_system_prompt = agent._build_system_prompt(system_message)
            # Persist so the NEXT turn restores the new bytes verbatim (cache break is
            # once per capability change). on_session_start not re-fired: continuation.
            _persist_system_prompt(
                agent,
                "Session DB update_system_prompt failed after Bot Chat capability refresh "
                "(session=%s): %s. The refresh will re-fire next turn.",
            )
            return
        # Continuing session — reuse the exact system prompt from the
        # previous turn so the Anthropic cache prefix matches.
        agent._cached_system_prompt = stored_prompt
        # Same contract for tools[]: pin the array to the order this session already
        # sent (tools freeze) instead of re-probing every check_fn on a fresh AIAgent.
        try:
            saved_tools = session_row.get("tool_names") if session_row else None
            if saved_tools:
                from tools.mcp_tool_agent import restore_agent_tool_prefix
                restore_agent_tool_prefix(agent, json.loads(saved_tools))
        except Exception:
            logger.debug("tool prefix restore skipped", exc_info=True)
        # Prompt-section callbacks are new-session-only; recover their frozen bytes
        # from the persisted prompt so a compression rebuild keeps them. The static
        # prefix is not persisted either; rebuild it for the early cache breakpoint or
        # fresh-per-turn gateway agents fall back to the single-breakpoint layout
        # (reconstruct_static_prefix gates on _use_prompt_caching, fails open to legacy).
        from agent.system_prompt import reconstruct_static_prefix, restore_plugin_prompt_sections
        restore_plugin_prompt_sections(agent, stored_prompt)
        reconstruct_static_prefix(agent, system_message=system_message)
        return
    if stored_prompt:
        stored_state = "stale_runtime"
        logger.info(
            "Stored system prompt for session %s has stale runtime identity; "
            "rebuilding for model=%s provider=%s.",
            agent.session_id, getattr(agent, "model", "") or "", getattr(agent, "provider", "") or "",
        )

    if conversation_history and stored_state in ("null", "empty"):
        # Continuing session with an unusable stored prompt: every turn now rebuilds
        # and the prefix cache misses every time.
        logger.warning(
            "Stored system prompt for session %s is %s; rebuilding from scratch this turn. Prefix "
            "cache will miss until the rebuild persists. Investigate the previous turn's "
            "update_system_prompt write path.",
            agent.session_id, stored_state,
        )

    # First turn of a new session (or recovering from a broken stored prompt).
    agent._cached_system_prompt = agent._build_system_prompt(system_message)

    # Plugin hook: on_session_start — fired once for a brand-new session, not on continuation.
    try:
        from hermes_cli.lifecycle import invoke_hook as _invoke_hook
        _invoke_hook(
            "on_session_start", session_id=agent.session_id, model=agent.model,
            platform=getattr(agent, "platform", None) or "",
        )
    except Exception as exc:
        logger.warning("on_session_start hook failed: %s", exc)

    # Cold-start credits seed (L3) fallback for the first-turn path; TUI/desktop seed at
    # session open, so this is idempotent (skips when _credits_state exists). Fail-open.
    try:
        from agent.credits_tracker import seed_credits_at_session_start
        seed_credits_at_session_start(agent)
    except Exception:
        logger.debug("cold-start credits seed failed (fail-open)", exc_info=True)

    _persist_system_prompt(
        agent,
        "Session DB update_system_prompt failed for session %s: %s. Subsequent turns will "
        "rebuild the system prompt and miss the prefix cache.",
        persist_tools=True,
    )


def _stored_prompt_matches_runtime(agent, prompt: str) -> bool:
    """Return False when the persisted runtime-identity lines are stale."""

    lines = prompt.splitlines()

    def line_value(label: str) -> str:
        """Last matching line wins — safe ONLY for volatile-tier fields at the END of the
        prompt (embedded project context could shadow earlier fields; see ``host_info_value``)."""
        prefix = f"{label}:"
        matches = [line[len(prefix):].strip() for line in lines if line.startswith(prefix)]
        return matches[-1] if matches else ""

    def host_info_value(label: str) -> str:
        """Read a field from the prompt's own host-info block, anchored on the FIRST ``User
        home directory:`` line so a user's ``AGENTS.md`` row cannot force a rebuild every turn."""
        prefix = f"{label}:"
        for idx, line in enumerate(lines):
            if line.startswith("User home directory:"):
                for candidate in lines[idx + 1: idx + 4]:
                    if candidate.startswith(prefix):
                        return candidate[len(prefix):].strip()
        return ""

    # Model/provider identity, then cwd drift, then runtime-surface drift (reusing a
    # desktop-built prompt on a terminal session would inject the wrong runtime hints).
    for label, attr in (("Model", "model"), ("Provider", "provider")):
        stored = line_value(label)
        current = str(getattr(agent, attr, "") or "").strip()
        if stored and current and stored != current:
            return False
    # Compare against resolve_agent_cwd() — the SAME resolver used to build the
    # prompt — so TERMINAL_CWD sessions are not falsely rejected.
    stored_cwd = host_info_value("Current working directory")
    if stored_cwd and stored_cwd != str(resolve_agent_cwd()):
        return False
    stored_platform = line_value("Platform")
    current_platform = str(getattr(agent, "platform", "") or "").strip()
    return not (stored_platform and current_platform and stored_platform != current_platform)
