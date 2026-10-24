"""Reused manual selection from previously read canonical Kanban source.
Pin c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a; parent blob
47fdffc353b1fd432acf5929f56463df07b413ad; hermes_cli/kanban_db.py.
get_task is an explicit fixture. SQL/control flow below follows the previously
read complete function; no full-parent byte/AST identity claim. This turn's
attempt to retrieve an additional parent range returned HTTP 429.
"""
import sqlite3
from typing import Optional

_RUN_OUTCOME_TERMINAL_STATUS = {
    "completed": "done",
    "review_requested": "review",
    "changes_requested": "changes_requested",
    "blocked": "blocked",
    "dependency_wait": "blocked",
}


def get_task(conn, task_id):
    raise RuntimeError("fixture get_task must be bound")


def goal_run_status(
    conn: sqlite3.Connection, task_id: str, expected_run_id: Optional[int] = None,
) -> Optional[str]:
    """Lifecycle status as seen by ONE run: terminal handoffs bind to that run,
    any other ownership loss is ``superseded`` — otherwise an old goal loop
    would read the successor's live ``running`` and mutate it."""
    task = get_task(conn, task_id)
    if task is None:
        return None
    if expected_run_id is not None:
        row = conn.execute(
            "SELECT outcome FROM task_runs WHERE id = ? AND task_id = ?",
            (int(expected_run_id), task_id),
        ).fetchone()
        outcome = str(row["outcome"]) if row and row["outcome"] is not None else None
        terminal_status = _RUN_OUTCOME_TERMINAL_STATUS.get(outcome)
        if terminal_status is not None:
            return terminal_status
        if outcome is not None or task.current_run_id != int(expected_run_id):
            return "superseded"
    if task.status in {"ready", "todo"}:
        event = conn.execute(
            "SELECT kind FROM task_events WHERE task_id = ? "
            "ORDER BY id DESC LIMIT 1", (task_id,),
        ).fetchone()
        if event and event["kind"] == "changes_requested":
            return "changes_requested"
    return task.status
