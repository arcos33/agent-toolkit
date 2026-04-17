#!/usr/bin/env bash
# Install claude-config on this machine.
# Symlinks CLAUDE.md, skills/, and commands/ from this repo into ~/.claude/.
#
# Run from the repo root: ./install.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/commands"

link() {
  local src="$1" dest="$2"
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

link "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

for dir in "$REPO_DIR"/skills/*/; do
  name="$(basename "$dir")"
  link "$dir" "$CLAUDE_DIR/skills/$name"
done

for file in "$REPO_DIR"/commands/*.md; do
  [[ -e "$file" ]] || continue
  name="$(basename "$file")"
  link "$file" "$CLAUDE_DIR/commands/$name"
done

echo ""
echo "Done. Restart Claude Code to pick up changes."
