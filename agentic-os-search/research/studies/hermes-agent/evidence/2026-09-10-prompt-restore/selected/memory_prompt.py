def _memory_parts(agent: Any) -> List[str]:
    """Built-in memory/USER.md blocks plus the external provider block (gated on
    the same check ``inject_memory_provider_tools`` uses, so we never advertise
    tools the toolset config gated off)."""
    parts: List[str] = []
    if agent._memory_store:
        for enabled, kind in ((agent._memory_enabled, "memory"), (agent._user_profile_enabled, "user")):
            block = agent._memory_store.format_for_system_prompt(kind) if enabled else None
            if block:
                parts.append(block)
    # External memory provider system prompt block (additive to built-in). Gated on the same check
    # ``inject_memory_provider_tools`` uses so we never advertise provider tools that the agent's toolset
    # configuration has already gated off (#81014).
    if agent._memory_manager:
        try:
            from agent.memory_manager import memory_provider_tools_exposed as _mem_exposed
        except Exception:
            _mem_exposed = None
        if _mem_exposed is None or _mem_exposed(agent):
            try:
                _ext_mem_block = agent._memory_manager.build_system_prompt()
            except Exception:
                _ext_mem_block = None
            if _ext_mem_block:
                parts.append(_ext_mem_block)
    return parts


def invalidate_system_prompt(agent: Any) -> None:
    """Force a rebuild on the next turn (after compression): reload memory from
    disk and clear the frozen plugin snapshot (previous bytes stashed as the
    fail-open fallback) so plugins re-render at the same boundary.

    Called after context compression events. Also reloads memory from disk so the rebuilt prompt captures
    any writes from this session, and clears the frozen plugin-section snapshot so plugins re-render at the
    same boundary (maintainer-directed, #95681 arc): a plugin section is just another prompt block carrying
    state — freezing it while memory, skills, and guidance refresh would recreate the stale-block disease
    inside plugin-land. The previous bytes are stashed so a plugin whose render RAISES falls back to its
    last good section instead of vanishing (fail-open guard, not a freeze).
    """
    agent._cached_system_prompt = None
    agent._cached_system_prompt_static = None
    if hasattr(agent, "_plugin_system_prompt_sections_snapshot"):
        agent._plugin_system_prompt_sections_previous = agent._plugin_system_prompt_sections_snapshot
        del agent._plugin_system_prompt_sections_snapshot
    if agent._memory_store:
        agent._memory_store.load_from_disk()
