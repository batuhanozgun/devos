#!/usr/bin/env python3
"""SessionStart hook, matcher "compact" (.claude/settings.json; D-010, summary item 20).

After a compaction the working session holds only a summary, so this tells it to re-read its working
order and current state from the record. Plain text on stdout becomes context for Claude. It never
fails the session: it always exits 0.
"""
import os
import sys

MESSAGE = """Context was just compacted; the summary may have lost detail. Before you continue, re-read from the files:
1. plan/Installation_Working_Order.md
2. plan/ledger.md, sections 1 (Current state) and 2 (Next action)
3. DURUM.md
4. the last entries of the current stage's log, plan/ledger/<stage>-log.md (the stage is named in ledger section 1)"""

try:
    sys.stdout.write(MESSAGE + "\n")
    sys.stdout.flush()
except Exception:
    pass
os._exit(0)  # skips the exit-time flush, which would turn a closed stdout into exit code 120
