---
name: sync-tools
description: Update ~/CLAUDE.md and ~/.openclaw/workspace/TOOLS.md when a tool, MCP server, plugin, or integration is added, removed, or changed.
---

# Sync Tools

When a tool, MCP server, plugin, LaunchAgent, or integration is added, removed, or changed, update both config files so Claude Code and OpenClaw stay in sync.

## Files to update

1. **`~/CLAUDE.md`** — Claude Code's system instructions
2. **`~/.openclaw/workspace/TOOLS.md`** — OpenClaw's local tooling reference

## Process

1. **Read both files** — always read the current state of both files before editing.

2. **Determine what changed** — review the current conversation for any tooling changes that were made (e.g., `claude mcp add`, plugin installs, new integrations, LaunchAgent changes). Identify:
   - What was added, removed, or changed
   - Which sections in each file are affected (MCP Servers, LaunchAgents, Projects, etc.)
   - If something is already present in both files, skip it — do not duplicate

3. **Update both files** — edit the relevant sections in each file:
   - Match the existing format and style of each file (they differ slightly)
   - `~/CLAUDE.md` uses `###` subsections under `## Environment` with bullet-point lists
   - `TOOLS.md` uses `##` sections, some with tables, some with bullet lists
   - Add entries in the same style as existing ones
   - If removing something, delete the entry (don't comment it out)
   - If a section doesn't exist yet for this type of tool, create one following the file's conventions

4. **Update MEMORY.md if needed** — if the change affects the MCP Servers section in `~/.claude/projects/-Users-samanthashiro-projects/memory/MEMORY.md`, update that too.

5. **Report** — show a short diff summary of what was changed in each file.

## Rules

- Never add secrets or API keys — reference 1Password items instead
- Keep entries concise — one or two lines per tool/server
- Preserve existing content — only touch the sections relevant to the change
- **Idempotent** — if an entry already exists in a file, do not add it again. Check before writing.
- If unsure where something belongs, ask
