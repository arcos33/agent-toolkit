# agent-toolkit

Personal AI-agent toolkit — skills, commands, scripts, templates, and instructions shared across Claude Code, Codex, and opencode.

## Contents
- `AGENTS.md` — global instructions (developer profile + project quartet rules), symlinked to each agent's global instruction file
- `skills/` — personal skills (symlinked into `~/.claude/skills/` and `~/.codex/skills/`)
- `commands/` — slash commands (symlinked into `~/.claude/commands/`)
- `scripts/init-project.sh` — bootstrap quartet + `AGENTS.md` on new projects
- `templates/project-quartet/` — README, CHANGELOG, DECISION-LOG, SPECS, AGENTS stubs
- `HOW-TO.md` — quartet usage guide

Not tracked here: GSD-installed skills, `project-context-logger` (its own repo), and install artifacts (`.skillshare/`, `.claude/`, `.codex/`, `.agents/`).

## Setup on a new machine
```bash
git clone https://github.com/arcos33/agent-toolkit.git ~/projects/agent-toolkit
~/projects/agent-toolkit/install.sh
```

The install script symlinks AGENTS.md, skills, and commands into `~/.claude/`, `~/.codex/`, and `~/.config/opencode/`. Existing files get backed up with a timestamp suffix.

## New project

```bash
cd ~/projects/3d-prints/my-thing && ~/projects/agent-toolkit/scripts/init-project.sh          # here
cd ~/projects/3d-prints       && ~/projects/agent-toolkit/scripts/init-project.sh foo-tray  # child dir
```

Or: **init project** / **init project foo-tray** (the `init-project` skill).

**Open in Bloom:** say **open** — opens cwd in Bloom.

## Daily workflow
- Edit skills/commands normally — changes are live via symlinks
- Push: `cd ~/projects/agent-toolkit && git add -A && git commit -m "..." && git push`
- Pull on other machine: `cd ~/projects/agent-toolkit && git pull`
