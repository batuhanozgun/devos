> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this text are fictional; no personal or business data.

# BR-212 · Retention job for the run store

**Context.** Brindle is the AI-assisted development system that our platform team runs for four product teams. Its dispatcher starts agent sessions, and every session writes a run record into the run store. The run store's volume is 87% full, and the disk alert has fired every day for a week.

**What to produce.** A design for a retention job that deletes run records so that the run store stays below 70% of its volume, without losing anything Brindle still needs. The design says:

1. which run records the job deletes and which it keeps, and why;
2. when and how the job runs;
3. how it avoids deleting the wrong thing;
4. how the job will be tested before it is enabled.

A platform engineer will build the job from your design, so write it so that they can build it without coming back to you.

**Materials.** The team's documentation and notes on Brindle are in `{{WORKSPACE}}/materials/`. They are your only source; nothing else about Brindle exists.

**How to work.**

- Use only the Read, Glob and Grep tools, and only on files inside `{{WORKSPACE}}`. Give every call an absolute path inside it; for Glob and Grep, set `path` to `{{WORKSPACE}}/materials`. Do not use the shell, the web, GitHub, other agents or any other tool, and do not write files.
- You have at most 40 tool calls. If you reach that limit, return the best design you have.
- No one can answer questions during this work.
- Return the design as your final message, in Markdown, in at most about 1,500 words.
