---
name: sync-tools
description: Update the canonical AGENTS.md when a tool, MCP server, plugin, or integration is added, removed, or changed.
---

# Sync Tools

When a tool, MCP server, plugin, LaunchAgent, or integration is added, removed, or changed,
update the canonical `AGENTS.md` so every agent (Claude Code, Codex, opencode) stays in sync.

## Files to update

**`~/projects/agent-toolkit/AGENTS.md`** — the single source of truth. It symlinks into:

| Agent | Global instruction file |
|-------|--------------------------|
| Claude Code | `~/.claude/CLAUDE.md` |
| Codex | `~/.codex/AGENTS.md` |
| opencode | `~/.config/opencode/AGENTS.md` |

## Process

1. **Read `AGENTS.md`** — always read the current state before editing.

2. **Determine what changed** — review the conversation for tooling changes
   (e.g. `claude mcp add`, plugin installs, new integrations, LaunchAgent changes). Identify:
   - What was added, removed, or changed
   - Which sections are affected (MCP Servers, LaunchAgents, Projects, etc.)
   - If something is already present, skip it — do not duplicate

3. **Update `AGENTS.md`** — edit the relevant section, matching the existing
   format and style. Add entries in the same style as existing ones. If removing
   something, delete the entry (don't comment it out). If a section doesn't exist
   yet for this type of tool, create one following the file's conventions.

4. **Report** — show a short diff summary of what was changed.

## Rules

- Never add secrets or API keys — reference 1Password items instead
- Keep entries concise — one or two lines per tool/server
- Preserve existing content — only touch the sections relevant to the change
- **Idempotent** — if an entry already exists, do not add it again. Check before writing.
- If unsure where something belongs, ask
