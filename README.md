# claude-config

Personal Claude Code configuration synced across my Macs.

## Contents
- `CLAUDE.md` — global user instructions (symlinked from `~/.claude/CLAUDE.md`)
- `skills/` — personal skills (symlinked into `~/.claude/skills/`)
- `commands/` — personal slash commands (symlinked into `~/.claude/commands/`)
- `scripts/init-project.sh` — bootstrap quartet + `CLAUDE.md` on new projects
- `templates/project-quartet/` — README, CHANGELOG, DECISION-LOG, SPECS, CLAUDE stubs

Not tracked here: GSD-installed skills (managed by `npx get-shit-done-cc`), plugin skills (e.g. `claude-mem:*`), session history, caches.

## Setup on a new Mac
```bash
git clone https://github.com/arcos33/claude-config.git ~/projects/claude-config
~/projects/claude-config/install.sh
```

The install script symlinks everything into `~/.claude/`. Existing files get backed up with a timestamp suffix.

## New project

```bash
cd ~/projects/3d-prints/my-thing && ~/projects/claude-config/scripts/init-project.sh          # here
cd ~/projects/3d-prints       && ~/projects/claude-config/scripts/init-project.sh foo-tray  # child dir
```

Or: **init project** / **init project foo-tray** (Claude `/init-project`, Cursor skill).

**Open in Bloom:** say **open** (Claude `/open`, Cursor skill) — opens cwd in Bloom.

## Daily workflow
- Edit skills/commands normally — changes are live via symlinks
- Push: `cd ~/projects/claude-config && git add -A && git commit -m "..." && git push`
- Pull on other Mac: `cd ~/projects/claude-config && git pull`
