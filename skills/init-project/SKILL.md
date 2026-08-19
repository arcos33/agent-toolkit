---
name: init-project
description: Bootstrap a new project with quartet docs (README, CHANGELOG, DECISION-LOG, SPECS) and AGENTS.md
argument-hint: "[NAME] [--desc DESC] [--type cad|app|mcp|ops|generic]"
---

# Init Project

Creates the **project quartet** plus a thin **`AGENTS.md`** in a new or existing directory.

## When to use

- User says **"init project"**, **"/init-project"**, or is creating a new repo/subproject under `~/projects/` or `~/lumen-agency/`
- Before `/gsd-new-project` if they want GSD planning later (quartet first, GSD second)

## Run from cwd

```bash
~/projects/agent-toolkit/scripts/init-project.sh [NAME] [options]
```

| Input | Result |
|-------|--------|
| (no NAME) | Quartet in **current directory** |
| `foo-tray` | Child dir `./foo-tray/`, quartet inside |
| `~/projects/3d-prints/foo` | That path (ignores cwd) |

| Option | Default | Notes |
|--------|---------|-------|
| `--name` | dirname title-cased | Display name in files |
| `--desc` | empty | One-line description |
| `--type` | `generic` | `cad` · `app` · `mcp` · `ops` · `generic` — picks `SPECS.md` stub |

**Idempotent:** skips files that already exist. Never overwrites populated work.

## Examples

```bash
cd ~/projects/3d-prints/sushi-organizer
~/projects/agent-toolkit/scripts/init-project.sh                    # quartet here

cd ~/projects/3d-prints
~/projects/agent-toolkit/scripts/init-project.sh foo-tray --type cad --desc "Prep tray"

~/projects/agent-toolkit/scripts/init-project.sh ~/projects/hikari-tools/mcp/foo --type mcp
```

## After bootstrap

1. Fill in `README.md` overview (below § Pick up here) if needed
2. Add ops notes to `AGENTS.md` § Ops notes (auth, deploy, MCP launch) as the project grows
3. Optional: `/gsd-new-project` for phased planning

## Templates

`~/projects/agent-toolkit/templates/project-quartet/`
