# Named canonical definitions from pinned agent/tool_executor.py lines 778-886.
# Not a complete upstream file; comparison-only transcription.
_SEQUENTIAL_DEADLINE_EXEMPT_TOOLS = frozenset({"delegate_task"})

def _abandoned_sequential_result(agent, ref: _ToolCallRef, message: str, result_cls, **outcome) -> _ManagedToolResult:
    """Emit the terminal post_tool_call for a worker the sequential runner gave up on
    (timeout / interrupt) and wrap ``message`` in its marker ``result_cls``."""
    ref.emit_post(agent, message, **outcome)
    return _ManagedToolResult(result=result_cls(message), args=ref.args, middleware_trace=ref.trace, blocked=False, dispatched=True)

def _poll_sequential_future(agent, future, function_name: str, deadline: float | None, started: float, authorization_gate) -> tuple[str, Any]:
    """Wait for the worker in interrupt-poll slices, extending the deadline by human approval
    wait; returns ``("done", result)``, ``("timeout", None)`` or ``("interrupted", None)``.
    A disabled deadline still polls: this loop is what makes a non-cooperative tool
    interruptible, so no deadline must not mean no interrupt checks."""
    _last_heartbeat = 0
    while True:
        wait_slice = _SEQUENTIAL_INTERRUPT_POLL_SECONDS
        if deadline is not None:
            remaining = deadline + authorization_gate.excluded_seconds() - time.monotonic()
            if remaining <= 0:
                return "timeout", None
            wait_slice = min(wait_slice, remaining)
        try:
            return "done", future.result(timeout=wait_slice)
        except concurrent.futures.TimeoutError:
            if agent._interrupt_requested:
                return "interrupted", None
            elapsed = int(time.monotonic() - started)
            if elapsed - _last_heartbeat >= 30:
                _last_heartbeat = elapsed
                agent._touch_activity(f"sequential tool running ({elapsed}s): {function_name}")

def _run_sequential_tool_execution_middleware(
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
) -> _ManagedToolResult:
    """Run one sequential call on a worker thread under the concurrent executor's deadline.
    Interactive tools (``clarify``) own their wait via ``agent.clarify_timeout``; the
    generic deadline would report ``tool_timeout`` while the prompt is still live."""
    timeout_s = None if function_name in _SEQUENTIAL_DEADLINE_EXEMPT_TOOLS else _resolve_sequential_tool_timeout()
    ref = _ToolCallRef(function_name, function_args, effective_task_id, tool_call_id, middleware_trace)
    kwargs = dict(ref.middleware_kwargs(), execute=execute, scope_block=scope_block, display_index=display_index)
    if function_name in _NEVER_PARALLEL_TOOLS:
        return _run_agent_tool_execution_middleware(agent, **kwargs)

    from tools.daemon_pool import DaemonThreadPoolExecutor

    authorization_gate = _ConcurrentToolAuthorizationGate()
    worker_tid: list[int] = []

    def _run() -> _ManagedToolResult:
        with _registered_tool_worker(agent) as tid:
            worker_tid.append(tid)
            return _run_agent_tool_execution_middleware(agent, authorization_gate=authorization_gate, **kwargs)

    if ref.trace is None:
        ref.trace = []
    executor = DaemonThreadPoolExecutor(max_workers=1)
    future = executor.submit(propagate_context_to_thread(_run))
    deadline = time.monotonic() + timeout_s if timeout_s is not None else None
    started = time.monotonic()
    abandoned = False
    try:
        state, result = _poll_sequential_future(agent, future, function_name, deadline, started, authorization_gate)
        if state == "done":
            return result
        if state == "interrupted":
            _interrupt_worker_tids(agent, worker_tid, reason=getattr(agent, "_tool_interrupt_reason", None))
            concurrent.futures.wait([future], timeout=3.0)
            if future.done() and not future.cancelled():
                return future.result()
            interrupt_reason = getattr(agent, "_tool_interrupt_reason", None) or "interrupt requested"
            message = f"[Tool execution cancelled — {function_name} was abandoned: {interrupt_reason}]"
            logger.info(
                "sequential tool %s abandoned due to %s (%.1fs elapsed)",
                function_name, interrupt_reason, time.monotonic() - started,
            )
            result_cls, outcome = _ToolCancelledResult, dict(
                duration_ms=int((time.monotonic() - started) * 1000), status="cancelled",
                error_type="tool_interrupted", error_message=f"Tool execution cancelled: {interrupt_reason}",
            )
        else:
            assert timeout_s is not None
            message = f"Error executing tool '{function_name}': timed out after {timeout_s:.1f}s"
            logger.warning("sequential tool %s timed out after %.1fs", function_name, timeout_s)
            result_cls, outcome = _ToolTimeoutResult, dict(
                duration_ms=int(timeout_s * 1000), status="timeout", error_type="tool_timeout", error_message=message,
            )
        abandoned = True
        future.cancel()
        if state == "timeout":
            _interrupt_worker_tids(agent, worker_tid)
        return _abandoned_sequential_result(agent, ref, message, result_cls, **outcome)
    finally:
        executor.shutdown(wait=not abandoned, cancel_futures=abandoned)
