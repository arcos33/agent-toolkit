# Decision Log

## 2026-09-22 — Use seven project files with distinct roles

**Decision:** Use `README.md` for stable project information; `PROJECT-STATE.md` for a concise current snapshot and next action; `ACTION-ITEMS.md` for tasks; `SESSION-LOG.md` for working-session history; `CHANGELOG.md` for meaningful changes; `DECISION-LOG.md` for decisions and non-obvious findings; and `SPECS.md` for confirmed requirements. Use uppercase names before the conventional `.md` extension. Call the set "project files."

**Why:** The prior four-file standard already held substantial project data, while the new session skills introduced duplicate filenames. Separate state, tasks, and session history keep the current snapshot short and preserve work that did not produce a code change.
