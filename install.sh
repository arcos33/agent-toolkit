#!/usr/bin/env bash
# Install agent-toolkit on this machine.
# Symlinks AGENTS.md, skills/, and commands/ into each agent's config dir:
#   Claude Code  -> ~/.claude/
#   Codex        -> ~/.codex/
#   opencode     -> ~/.config/opencode/
#
# Run from the repo root: ./install.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -L "$dest" ]]; then
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $dest → $backup"
    mv "$dest" "$backup"
  fi
  ln -s "$src" "$dest"
  echo "Linked $dest → $src"
}

# Global instructions — one canonical AGENTS.md, exposed where each agent reads it.
# Claude Code reads ~/.claude/CLAUDE.md; opencode also reads that path.
link "$REPO_DIR/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$REPO_DIR/AGENTS.md" "$HOME/.codex/AGENTS.md"
link "$REPO_DIR/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"

# Skills — Claude Code and Codex use the same SKILL.md format.
# opencode discovers ~/.claude/skills already, so no separate link needed.
mkdir -p "$HOME/.claude/skills" "$HOME/.codex/skills"
for dir in "$REPO_DIR"/skills/*/; do
  name="$(basename "$dir")"
  link "$dir" "$HOME/.claude/skills/$name"
  link "$dir" "$HOME/.codex/skills/$name"
done

# Commands — Claude Code slash commands.
mkdir -p "$HOME/.claude/commands"
for file in "$REPO_DIR"/commands/*.md; do
  [[ -e "$file" ]] || continue
  name="$(basename "$file")"
  link "$file" "$HOME/.claude/commands/$name"
done

echo ""
echo "Done. Restart your agents to pick up changes."
