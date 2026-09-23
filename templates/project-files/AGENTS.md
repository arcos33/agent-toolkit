# {{NAME}}

{{DESC}}

## Project files

Every project uses the same seven files. Stubs are fine until you have content.

| File | Purpose |
|------|---------|
| [README.md](./README.md) | Stable overview, setup, and usage |
| [PROJECT-STATE.md](./PROJECT-STATE.md) | Current status, blockers, and one next action |
| [ACTION-ITEMS.md](./ACTION-ITEMS.md) | Open and resolved tasks |
| [SESSION-LOG.md](./SESSION-LOG.md) | Dated working-session history |
| [CHANGELOG.md](./CHANGELOG.md) | Meaningful project changes |
| [DECISION-LOG.md](./DECISION-LOG.md) | Decisions, findings, and reasoning |
| [SPECS.md](./SPECS.md) | Confirmed requirements and measurable facts |

## Session triggers

- **"pick up here"** → read `PROJECT-STATE.md`, open `ACTION-ITEMS.md`, and recent `SESSION-LOG.md`
- **"update the specs"** (CAD) → `SPECS.md` first, then code
- **After meaningful work** → update `PROJECT-STATE.md` and `ACTION-ITEMS.md`; append `CHANGELOG.md` for changes and `DECISION-LOG.md` for durable reasoning; append one `SESSION-LOG.md` entry at session close

Global rules: `~/projects/agent-toolkit/AGENTS.md` § Project files

## Ops notes

Add deployment, auth, MCP launch commands, and other project-specific instructions below as this project grows.
