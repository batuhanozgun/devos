# Named definitions from pinned agent/tool_executor.py, ranges 241-288 and 430-538.
# Not a complete upstream module. Comments omitted, AST/docstrings retained.
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
