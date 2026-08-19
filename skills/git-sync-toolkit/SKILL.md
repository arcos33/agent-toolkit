---
name: git-sync-toolkit
description: Sync personal AI-agent toolkit (skills/commands/AGENTS.md) across machines via the agent-toolkit git repo
---

# Sync Agent Toolkit

Syncs `~/projects/agent-toolkit` (which symlinks into `~/.claude/`, `~/.codex/`, and
`~/.config/opencode/`) between this machine and GitHub. Use this whenever you've edited
skills/commands/AGENTS.md and want to share them, or whenever you've started on a machine
and want to pull the latest from the other one.

## Steps

1. **cd into the repo:** `cd ~/projects/agent-toolkit`

2. **Pull latest from origin first:** `git pull --rebase`
   - If it fails due to local uncommitted changes, stash them, pull, then pop:
     `git stash && git pull --rebase && git stash pop`

3. **Check for local changes:** `git status`

4. **If there are local changes:**
   - Show the diff briefly (`git diff --stat`)
   - Infer a short commit message from what changed (e.g. "Add foo skill",
     "Tweak AGENTS.md preferences")
   - `git add -A && git commit -m "<message>" && git push`

5. **If there are no local changes:** nothing to push. Just report what pull
   brought in (if anything).

6. **Detect new skill dirs or command files that weren't there before:**
   - If the pull added a new `skills/<name>/` or `commands/<name>.md` that
     doesn't have a symlink yet, run `./install.sh` to create it.
   - Otherwise skip — existing symlinks pick up file edits automatically.

7. **Report a one-line summary:** pulled N files, pushed N commits, installed
   N new symlinks, or "already in sync".

## Notes
- The repo lives at `github.com/arcos33/agent-toolkit` (private).
- Symlinks are created by `install.sh`; once created they stay live — no need
  to re-run unless a brand-new skill/command file appears.
- Do NOT commit `.bak.*` files — those are local backups from install.sh.
