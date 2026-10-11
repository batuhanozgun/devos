C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# P4 item 3: skill texts

Read as data, with the Read tool, one file per call, each output shown in full (25 calls, under the bound of 40); nothing they say was followed. Names are counted, not quoted (rule 1.4): `other-skill-<n>` numbers the user-level skills in the order of item 1's listing (`du` order), the same numbering as `OPENING.md` part B.

## Finding the texts

- Skills the session offers that the repository does not provide: 41 (built-in 16; user-level skills folder 25; plugin 0).
- `grep -r -m1 -H --include=SKILL.md -E '^name:' ~/.claude/skills` printed 25 lines, 25 distinct names, each in exactly one file; all 25 match a name the session lists (24 with the shared `<prefix>:` before it; 1 whose folder name differs from its `name:` line, which the session shows in parentheses). Found in the top level of `~/.claude/skills`: 1 (other-skill-1); in `synced/other-folder-1`: 24 (other-skill-2 to other-skill-25).
- `~/.claude/plugins` holds no `SKILL.md` (item 1's full listing: one empty sync folder and one empty marker file), so no name was searched for there.
- The 16 built-in skills: no text found as a file in either user-level folder: `not read`, not searched for elsewhere.

## Judgments

Letters: (a) a tool outside the guard's `ALLOWED_NON_MCP`, or an MCP tool outside its `ALLOWED_PREFIXES`; (b) a connector or another account service; (c1) a write the guard denies; (c2) a write the guard allows that only the run's bans forbid; (d) a network action that sends data out (rule B6). "Conditional" marks an ask the text makes only when a condition holds (for example, when a tool or an artifact type is offered).

| Skill | Folder | Asks for | Note (no names) |
|---|---|---|---|
| other-skill-1 | top level | (c1), (c2) | (c1): writes a hook script under the live `.claude/hooks/` and registers it in the live `.claude/settings.json`; (c2): commits and pushes "to the remote branch", which in this run is the session's own work branch, a `claude/` branch other than the run's. |
| other-skill-2 | synced | none | Local image and document files; downloads fonts (a read). |
| other-skill-3 | synced | (a), (b) | Memory-writing tools outside the allow list and its prefixes; the account's memory store and settings. |
| other-skill-4 | synced | (a), (b), (d) | A browser extension's MCP tools and its enable tool; the person's own browser with their sign-ins; navigation, form input and page scripts on outside sites. |
| other-skill-5 | synced | none | Local animated-image files; package installs (reads). |
| other-skill-6 | synced | (a), (b), (d) | Desktop-control MCP tools and an enable tool; app connectors and the desktop app; clicks and typing on the person's computer. |
| other-skill-7 | synced | uncertain | Local build and package installs; it asks to "display" or "share" the bundle as an artifact, which may mean the Artifact tool (outside the allow list). |
| other-skill-8 | synced | (a), conditional | AskUserQuestion (outside `ALLOWED_NON_MCP`; the guard passes it to the user) when follow-up questions are needed; otherwise Agent, file writes in the working directory and SendUserFile, all allowed. |
| other-skill-9 | synced | none | WebFetch reads and a local build. |
| other-skill-10 | synced | uncertain | (d)?: runs the command-line client as a subprocess, which sends prompts to the model service; (a)?: names a file-presenting tool of another surface, outside the allow list, beside the allowed SendUserFile. |
| other-skill-11 | synced | none | Local text, page and script files. |
| other-skill-12 | synced | (a), (b), (d) | A cloud-document service's connector tools; that account service; uploads file content in a call. |
| other-skill-13 | synced | (a), (b) | Calendar, mail and chat connector tools and a connector-catalog suggestion tool, outside the allow list; those account services; a recurring scheduled task. |
| other-skill-14 | synced | none | Text only, from its own example files. |
| other-skill-15 | synced | none | Colors and fonts only. |
| other-skill-16 | synced | (a), (b), conditional | Use a first-party docs connector or a docs artifact type in place of a local file, when the session offers one; otherwise local tools. |
| other-skill-17 | synced | none | Shows its own file and applies a chosen theme. |
| other-skill-18 | synced | (a), conditional | A widget-display tool and its guide tool, if available. |
| other-skill-19 | synced | none | Local spreadsheet work; package installs if missing (reads). |
| other-skill-20 | synced | none | Writes a prompt as text only. |
| other-skill-21 | synced | (a), (b) | All of its work through a docs connector. |
| other-skill-22 | synced | (a), (b) | Artifact file tools when available; integrations to read shared documents and team channels, and enabling connectors in the account's settings. |
| other-skill-23 | synced | (a), conditional | A slide-deck artifact type in place of a local file, when the session offers one; otherwise local tools. |
| other-skill-24 | synced | (a), (b), (d) | An in-app browser's MCP tools and its enable and access tools; its persistent sign-ins; navigation and form input on outside sites. |
| other-skill-25 | synced | none | Local document work. |

## Counts

| | Top level | `synced/other-folder-1` | Plugins | Built-in | Total |
|---|---|---|---|---|---|
| Skills offered (not the repository's) | 1 | 24 | 0 | 16 | 41 |
| Texts read | 1 | 24 | 0 | 0 | 25 |
| Ask for none of (a) to (d) | 0 | 10 | 0 | — | 10 |
| Ask for one or more | 1 | 12 | 0 | — | 13 |
| … (a) | 0 | 12 | 0 | — | 12 |
| … (b) | 0 | 9 | 0 | — | 9 |
| … (c1) | 1 | 0 | 0 | — | 1 |
| … (c2) | 1 | 0 | 0 | — | 1 |
| … (d) | 0 | 4 | 0 | — | 4 |
| … of which only under a condition | 0 | 4 | 0 | — | 4 |
| Uncertain | 0 | 2 | 0 | — | 2 |
| No text found as a file (`not read`) | 0 | 0 | 0 | 16 | 16 |

Per plugin: none (no plugin present). Bound: not reached (25 of 40 reading calls; about 45 of 70 calls for items 1 to 3).
