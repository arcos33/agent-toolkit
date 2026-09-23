# Project Files — How To

Every new project gets seven project files (stubs OK until content is verified).

## Files to create

| File | What it's for |
|------|---------------|
| `README.md` | Stable project overview, setup, and usage |
| `PROJECT-STATE.md` | Current status, blockers, and one next action |
| `ACTION-ITEMS.md` | Open and resolved tasks |
| `SESSION-LOG.md` | Dated history of working sessions |
| `CHANGELOG.md` | *What* changed — list of changes, newest first |
| `DECISION-LOG.md` | *Why* — decisions, findings, and reasoning |
| `SPECS.md` | Confirmed requirements, measurements, APIs, and constraints |

## How to use

- **"pick up here"** → read `PROJECT-STATE.md`, open `ACTION-ITEMS.md`, and recent `SESSION-LOG.md`; use a legacy README handoff if `PROJECT-STATE.md` says its first snapshot is pending
- **"update the specs"** → edit `SPECS.md` first, then code
- **After meaningful work** → update `PROJECT-STATE.md` and `ACTION-ITEMS.md`; append `CHANGELOG.md` for changes and `DECISION-LOG.md` for durable reasoning
- **At session close** → append one dated `SESSION-LOG.md` entry even if no project change resulted

## PROJECT-STATE.md structure

```markdown
# Project State

## Current status

Brief verified status and blockers.

## Next action

NEXT ACTION: One concrete step.
```
