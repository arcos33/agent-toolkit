---
name: git-sync-claude-config
description: Sync personal Claude Code skills/commands/CLAUDE.md across machines via the claude-config git repo
---

# Sync Claude Config

Syncs `~/projects/claude-config` (which symlinks into `~/.claude/`) between this
machine and GitHub. Use this whenever you've edited skills/commands/CLAUDE.md
and want to share them, or whenever you've started on a machine and want to
pull the latest from the other one.

## Steps

1. **cd into the repo:** `cd ~/projects/claude-config`

2. **Pull latest from origin first:** `git pull --rebase`
   - If it fails due to local uncommitted changes, stash them, pull, then pop:
     `git stash && git pull --rebase && git stash pop`

3. **Check for local changes:** `git status`

4. **If there are local changes:**
   - Show the diff briefly (`git diff --stat`)
   - Infer a short commit message from what changed (e.g. "Add foo skill",
     "Tweak CLAUDE.md preferences")
   - `git add -A && git commit -m "<message>" && git push`

5. **If there are no local changes:** nothing to push. Just report what pull
   brought in (if anything).

6. **Detect new skill dirs or command files that weren't there before:**
   - If the pull added a new `skills/<name>/` or `commands/<name>.md` that
     doesn't have a symlink in `~/.claude/`, run `./install.sh` to create it.
   - Otherwise skip — existing symlinks pick up file edits automatically.

7. **Report a one-line summary:** pulled N files, pushed N commits, installed
   N new symlinks, or "already in sync".

## Notes
- The repo lives at `github.com/arcos33/claude-config` (private).
- Symlinks are created by `install.sh`; once created they stay live — no need
  to re-run unless a brand-new skill/command file appears.
- Do NOT commit `.bak.*` files — those are local backups from install.sh.
