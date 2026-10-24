# Named canonical definitions, pinned agent/tool_executor.py around lines 598-758.
# Not a complete upstream file. Comparison-only transcription from connector text.
def _blocked_tool_result(agent, ref: _ToolCallRef, *, block_message: Optional[str], block_error_type: str, guardrail_decision) -> str:
    """Synthesize the result for a call blocked by scope/plugin (``block_message``) or by
    guardrail policy (``guardrail_decision``) and emit its terminal post_tool_call."""
    if block_message is not None:
        result, error_type, error_message = json.dumps({"error": block_message}, ensure_ascii=False), block_error_type, block_message
    else:
        result = agent._guardrail_block_result(guardrail_decision)
        error_type = "guardrail_block"
        error_message = getattr(guardrail_decision, "message", None) or "Tool blocked by guardrail policy"
    ref.emit_post(agent, result, status="blocked", error_type=error_type, error_message=error_message)
    return result

def _pre_tool_block(agent, ref: _ToolCallRef):
    """Run ``pre_tool_call`` plugin hooks; returns ``(block_message, final_args)`` with any
    hook-modified args applied. Hook failures never block."""
    try:
        from hermes_cli.plugins import _dispatch_pre_tool_call_hooks

        block_msg, modified_args = _dispatch_pre_tool_call_hooks(
            ref.name,
            ref.args,
            **tool_hook_ids(agent, ref.task_id, ref.call_id),
            middleware_trace=list(ref.trace),
        )
        return block_msg, (ref.args if modified_args is None else modified_args)
    except Exception:
        return None, ref.args

def _dispatch_authorized_once(
    agent,
    state: _ManagedToolResult,
    ref: _ToolCallRef,
    *,
    execute,
    scope_block: str | None,
    display_index: int | None,
    begin_execution,
    authorization_gate: _ConcurrentToolAuthorizationGate | None,
) -> Any:
    """Hermes policy (scope → plugin pre-hooks → guardrails) then the one real dispatch.

    Plugin ``modify`` hooks may rewrite ``ref.args`` (mirrored into ``state.args``).
    ``begin_execution`` (concurrent start-order gate) is advanced exactly once on every
    path so later-ordered workers keep moving; blocked calls advance it without a callback.
    """
    def _advance_start_order(callback=None) -> None:
        if begin_execution is not None:
            begin_execution(callback)
        elif callback is not None:
            callback()

    block_message, block_error_type = scope_block, "tool_scope_block"
    if block_message is None:
        block_error_type = "plugin_block"
        resolve = lambda: _pre_tool_block(agent, ref)
        block_message, ref.args = resolve() if authorization_gate is None else authorization_gate.run(resolve)
        state.args = ref.args

    guardrail_decision = None
    if block_message is None:
        guardrail_decision = agent._tool_guardrails.before_call(ref.name, ref.args)
        if guardrail_decision.allows_execution:
            guardrail_decision = None

    if block_message is not None or guardrail_decision is not None:
        _advance_start_order()
        state.blocked = True
        return _blocked_tool_result(
            agent, ref,
            block_message=block_message, block_error_type=block_error_type, guardrail_decision=guardrail_decision,
        )

    if ref.name == "memory":
        agent._turns_since_memory = 0
    elif ref.name == "skill_manage":
        agent._iters_since_skill = 0

    _advance_start_order(lambda: _begin_tool_execution(agent, ref, display_index))
    return _run_with_activity_heartbeat(agent, ref.name, lambda: execute(ref.args))

def _run_agent_tool_execution_middleware(
    agent,
    *,
    function_name: str,
    function_args: dict,
    effective_task_id: str,
    tool_call_id: str,
    execute,
    scope_block: str | None = None,
    display_index: int | None = None,
    middleware_trace: list[dict[str, Any]] | None = None,
    begin_execution=None,
    authorization_gate: _ConcurrentToolAuthorizationGate | None = None,
) -> _ManagedToolResult:
    """Run Relay rewrites before Hermes policy and dispatch exactly once."""
    from agent import relay_tools
    from hermes_cli.middleware import (
        apply_tool_request_middleware,
        run_tool_execution_middleware,
    )

    trace = middleware_trace if middleware_trace is not None else []
    state = _ManagedToolResult(result=None, args=function_args, middleware_trace=trace, blocked=False, dispatched=False)
    dispatch_lock = threading.Lock()

    def _authorized_dispatch(final_args: dict[str, Any]) -> Any:
        with dispatch_lock:
            if state.dispatched:
                raise RuntimeError("Hermes tool execution callback invoked more than once")
            state.dispatched = True
            state.blocked = False
            state.args = final_args
        return _dispatch_authorized_once(
            agent,
            state,
            _ToolCallRef(function_name, final_args, effective_task_id, tool_call_id, trace),
            execute=execute,
            scope_block=scope_block,
            display_index=display_index,
            begin_execution=begin_execution,
            authorization_gate=authorization_gate,
        )

    def _hermes_pipeline(relay_args: dict[str, Any]) -> Any:
        request_result = apply_tool_request_middleware(
            function_name,
            relay_args,
            skip_relay=True,
            **tool_hook_ids(agent, effective_task_id, tool_call_id),
        )
        request_args = request_result.payload if isinstance(request_result.payload, dict) else relay_args
        trace.clear()
        trace.extend(request_result.trace)
        return run_tool_execution_middleware(
            function_name,
            request_args,
            lambda next_args: _authorized_dispatch(next_args if isinstance(next_args, dict) else request_args),
            original_args=function_args,
            **tool_hook_ids(agent, effective_task_id, tool_call_id),
        )

    state.result, _relay_args = relay_tools.execute(
        function_name,
        function_args,
        _hermes_pipeline,
        session_id=str(getattr(agent, "session_id", "") or ""),
        tool_call_id=tool_call_id or None,
        metadata={
            "task_id": effective_task_id or "",
            "turn_id": getattr(agent, "_current_turn_id", "") or "",
            "api_request_id": getattr(agent, "_current_api_request_id", "") or "",
            "tool_call_id": tool_call_id or "",
        },
    )
    return state

_SEQUENTIAL_INTERRUPT_POLL_SECONDS = 1.0
