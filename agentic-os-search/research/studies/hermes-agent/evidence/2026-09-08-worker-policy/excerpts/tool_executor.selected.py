# SOURCE EXCERPT, not the complete tool_executor.py module. See SOURCES.md.
from __future__ import annotations
import concurrent.futures
import contextlib
import json
import logging
import threading
import time
from dataclasses import dataclass
from typing import Any, Optional
from tools.thread_context import propagate_context_to_thread
logger = logging.getLogger(__name__)

@dataclass
class _ToolCallRef:
    """Identity of one tool call as every hook / result message sees it: the (possibly
    middleware-rewritten) name and args, the task, the pairing id and the request trace."""

    name: str
    args: dict
    task_id: str
    call_id: str
    trace: list

    def middleware_kwargs(self) -> dict[str, Any]:
        """Keyword form ``_run_agent_tool_execution_middleware`` (and tests patching it) expect."""
        return {
            "function_name": self.name, "function_args": self.args, "effective_task_id": self.task_id,
            "tool_call_id": self.call_id, "middleware_trace": self.trace,
        }

    def emit_post(self, agent, result, *, trace=None, **outcome) -> None:
        """Emit the one terminal ``post_tool_call`` for this call (``outcome`` = status /
        error_type / error_message / duration_ms). Resolved through the module attribute so
        tests patching ``_emit_terminal_post_tool_call`` still intercept."""
        _emit_terminal_post_tool_call(
            agent,
            function_name=self.name,
            function_args=self.args,
            result=result,
            effective_task_id=self.task_id,
            tool_call_id=self.call_id,
            middleware_trace=list(self.trace if trace is None else trace),
            **outcome,
        )

    def emit_cancelled(self, agent, start_time: float) -> str:
        """Synthesize the ``cancelled`` result for a KeyboardInterrupt mid-tool and emit its hook."""
        message = "Tool execution cancelled by user interrupt"
        result = json.dumps({"error": message, "status": "cancelled"}, ensure_ascii=False)
        self.emit_post(
            agent, result, duration_ms=int((time.time() - start_time) * 1000),
            status="cancelled", error_type="keyboard_interrupt", error_message=message,
        )
        return result

    def emit_invalid_arguments(self, agent, result: str) -> None:
        self.emit_post(
            agent, result, trace=[],
            status="error", error_type="invalid_tool_arguments", error_message="Tool arguments must be a valid JSON object",
        )

@dataclass
class _ManagedToolResult:
    result: Any
    args: dict[str, Any]
    middleware_trace: list[dict[str, Any]]
    blocked: bool
    dispatched: bool

class _ToolTimeoutResult(str):
    """Marker for a synthesized sequential-tool timeout result."""

class _ToolCancelledResult(str):
    """Marker for a synthesized sequential-tool user-interrupt result; its terminal
    post_tool_call was already emitted, so a late-finishing abandoned worker must not report."""

@contextlib.contextmanager
def _registered_tool_worker(agent):
    """Track this worker tid for interrupt fan-out (``AIAgent.interrupt()``); on ANY exit
    (incl. BaseException) discard it and clear its interrupt bit so a recycled tid starts clean."""
    tid = threading.current_thread().ident
    with agent._tool_worker_threads_lock:
        agent._tool_worker_threads.add(tid)
    try:
        yield tid
    finally:
        with agent._tool_worker_threads_lock:
            agent._tool_worker_threads.discard(tid)
        with contextlib.suppress(Exception):
            _ra()._set_interrupt(False, tid)


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
        resolve = lambda: _pre_tool_block(agent, ref)  # noqa: E731
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
            # interrupt() already fanned out to tracked tids, but this worker may have
            # registered after that ran; then 3s grace (mirrors the concurrent path).
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
            assert timeout_s is not None  # only reachable when a deadline exists
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
        # Never join a wedged worker (daemon pool also keeps it out of the atexit join).
        executor.shutdown(wait=not abandoned, cancel_futures=abandoned)

class _ConcurrentToolAuthorizationGate:
    """Serialize policy prompts and exclude human approval waits from batch deadlines.

    The acquire is BOUNDED: on expiry the worker prompts unserialized rather than starving
    the batch behind a wedged plugin/approval client. Exclusion is measured at the SOURCE
    of the human wait (``tools.approval.human_wait_seconds``), NOT as gate residency —
    residency-based exclusion let a wedged plugin keep the deadline from ever firing.

    Serialization keeps concurrent approval prompts from interleaving on the user's screen. The acquire is
    BOUNDED: a worker wedged inside the gate (a hanging ``pre_tool_call`` plugin, or an approval round-trip
    to a client that went away) must not park every other worker forever. On expiry the worker runs its
    prompt unserialized — worst case is interleaved prompts, strictly better than permanent starvation (same
    tradeoff as the start-order gate, #79705).
    Gate residency is arbitrary code — using it as the exclusion signal let a wedged plugin grow the
    exclusion 1:1 with wall clock, keeping the batch deadline's ``remaining`` constant so it never fired and
    the turn hung forever (#79719). A wedged plugin now contributes nothing to the exclusion and the batch
    times out normally, while a genuine approval wait (which can legitimately exceed any fixed bound) is
    still excluded in full.
    """

    def __init__(self, *, lock_timeout: float | None = None, session_key: str | None = None) -> None:
        self._serialization_lock = threading.Lock()
        self._lock_timeout = _authorization_gate_lock_timeout() if lock_timeout is None else lock_timeout
        self._session_key = session_key
        if self._session_key is None:
            # Snapshot on the SUBMITTING thread: excluded_seconds() is polled from the
            # batch wait loop, whose context may differ from the workers'.
            try:
                from tools.approval_context import get_current_session_key

                self._session_key = get_current_session_key()
            except Exception:
                logger.debug(
                    "authorization gate could not snapshot the session key; "
                    "human-wait exclusion will re-resolve it at poll time",
                    exc_info=True,
                )
        self._baseline_wait_seconds = self._human_wait_seconds()

    def _human_wait_seconds(self) -> float:
        try:
            from tools.approval_human_wait import human_wait_seconds

            return human_wait_seconds(self._session_key)
        except Exception:
            return 0.0

    def run(self, callback):
        if not self._serialization_lock.acquire(timeout=self._lock_timeout):
            # Deterministic failure (bad command, non-MCP URL, 401/403): every retry hits the same wall.
            # Park immediately instead of burning the retry ladder and spamming N identical warnings
            # (#65673). Auth failures park here too rather than returning. Returning ends the run task, and
            # with it the only listener on ``_reconnect_event`` — so a 401 on the very first connect left
            # the server unrevivable for the life of the process, even after the user re-authenticated with
            # ``hermes mcp login``. Parking keeps the task alive so the 300s self-probe (and an explicit
            # /mcp refresh) can pick up fresh tokens.
            logger.warning(
                "authorization gate lock not acquired after %.1fs "
                "(holder wedged in a pre_tool_call plugin or approval "
                "round-trip?); running prompt unserialized",
                self._lock_timeout,
            )
            return callback()
        try:
            return callback()
        finally:
            self._serialization_lock.release()

    def excluded_seconds(self) -> float:
        """Return human-approval wait seconds accrued since the batch started."""
        return max(0.0, self._human_wait_seconds() - self._baseline_wait_seconds)
