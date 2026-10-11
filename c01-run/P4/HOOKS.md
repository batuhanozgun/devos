C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# P4 item 4: hooks the repository does not provide

For the run from S (2026-10-11T19:14:17Z) to this item (about 19:22Z). The repository's hooks are those part B item 3 lists: the guard (PreToolUse `.*` and PermissionRequest `.*`; its output and denials begin `DevOS guard:`), a PostToolUse hook on two session tools this run does not call, and the re-read message after a compaction (SessionStart `compact`).

(a) Hook output that reached the session's context, other than the repository's: 0, under every hook event and tool. No hook output of any kind was shown to the session in this run: the guard allowed every call without visible text, and no other hook text appeared. What did appear beside tool results were the harness's own reminders (unused task tools; a prompt to tell the user what it is doing; the deferred-tool lists; the GitHub server's instructions; a notice of two new tools from the `ccd_session` server), none shown as a hook's. Shows a hook the repository does not provide acting: `no`.

(b) Denials the session shows as a hook's whose text does not begin `DevOS guard:`: 0. Denials by the platform's permission classifier: 0 (counted apart). The run saw no denial of any kind. Shows such a hook acting: `no`.

(c) Files under `~/.claude` modified at or after S (`date -u -d 2026-10-11T19:14:17Z +%s` = 1791746057; `du -a --time --time-style=+%s ~/.claude | awk -F'\t' -v s=1791746057 '$2 >= s {print $3}'`, then counted by the first folder below `~/.claude`):

| First folder | Entries | What they are |
|---|---|---|
| (`~/.claude` itself) | 1 | The folder; `du` gives a folder the newest time of its contents. |
| `projects` | 5 | The folder `projects/`, this project's folder, this session's transcript (`<session>.jsonl`), this session's folder, and one file in it, `ccr-tip.json`. |
| any other | 0 | — |

Shows a hook the repository does not provide acting: `no`. The transcript and the session folder are files Claude Code writes for itself; `ccr-tip.json` was not read, and its name points to the platform's remote runtime, not to a hook. No file changed in `plugins/`, `skills/` or any other folder.
