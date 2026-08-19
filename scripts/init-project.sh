#!/usr/bin/env bash
# Bootstrap project quartet + CLAUDE.md from templates.
# Usage: init-project.sh [PATH] [--name NAME] [--desc DESC] [--type cad|app|mcp|ops|generic]
#
# No PATH     → current directory
# PATH=name   → child directory ./name (simple name, no slashes)
# PATH=./foo  → explicit relative path
# PATH=~/...  → absolute or home-relative path

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES="$REPO_DIR/templates/project-quartet"

NAME=""
DESC=""
TYPE="generic"
TARGET=""

usage() {
  cat <<'EOF'
Usage: init-project.sh [PATH] [--name NAME] [--desc DESC] [--type TYPE]

  (no PATH)   Bootstrap in current directory
  PATH        Project directory (created if missing)
              Simple name (e.g. foo-tray) → child dir under cwd
  --name      Display name (default: dirname, title-cased)
  --desc      One-line description (default: empty)
  --type      cad | app | mcp | ops | generic (default: generic)

Idempotent: skips files that already exist.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name) NAME="$2"; shift 2 ;;
    --desc) DESC="$2"; shift 2 ;;
    --type) TYPE="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *)
      if [[ -z "$TARGET" ]]; then
        TARGET="$1"
        shift
      else
        echo "Unknown argument: $1" >&2
        usage >&2
        exit 1
      fi
      ;;
  esac
done

# Default: current directory
if [[ -z "$TARGET" ]]; then
  TARGET="."
fi

# Bare name → child directory (init project foo-tray)
if [[ "$TARGET" != "." && "$TARGET" != ".." && "$TARGET" != /* && "$TARGET" != ~* && "$TARGET" != *"/"* ]]; then
  TARGET="./$TARGET"
fi

case "$TYPE" in
  cad|app|mcp|ops|generic) ;;
  *)
    echo "Invalid --type: $TYPE (use cad, app, mcp, ops, or generic)" >&2
    exit 1
    ;;
esac

# Expand ~ and resolve absolute path
TARGET="${TARGET/#\~/$HOME}"
mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

if [[ -z "$NAME" ]]; then
  base="$(basename "$TARGET")"
  NAME="$(echo "$base" | sed 's/[-_]/ /g' | awk '{for (i = 1; i <= NF; i++) $i = toupper(substr($i, 1, 1)) substr($i, 2); print}')"
fi

DATE="$(date +%Y-%m-%d)"
SPECS_FILE="$TEMPLATES/SPECS-${TYPE}.md"
[[ -f "$SPECS_FILE" ]] || SPECS_FILE="$TEMPLATES/SPECS-generic.md"

substitute() {
  local template="$1" dest="$2"
  sed \
    -e "s|{{NAME}}|${NAME}|g" \
    -e "s|{{DESC}}|${DESC}|g" \
    -e "s|{{DATE}}|${DATE}|g" \
    -e "s|{{PATH}}|${TARGET}|g" \
    "$template" > "$dest"
}

write_if_missing() {
  local filename="$1" template="$2"
  local dest="$TARGET/$filename"
  if [[ -f "$dest" ]]; then
    echo "skip  $dest (exists)"
    return
  fi
  substitute "$template" "$dest"
  echo "write $dest"
}

write_if_missing "README.md" "$TEMPLATES/README.md"
write_if_missing "CHANGELOG.md" "$TEMPLATES/CHANGELOG.md"
write_if_missing "DECISION-LOG.md" "$TEMPLATES/DECISION-LOG.md"
write_if_missing "SPECS.md" "$SPECS_FILE"
write_if_missing "CLAUDE.md" "$TEMPLATES/CLAUDE.md"

echo ""
echo "Project ready: $TARGET"
echo "  README.md CHANGELOG.md DECISION-LOG.md SPECS.md CLAUDE.md"
