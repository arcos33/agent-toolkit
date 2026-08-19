---
name: save
description: Review the current session and ensure claude-mem captured everything important. Manually save any key context that automated capture may have missed.
---

# Save Session Memory

claude-mem automatically captures observations from every tool call. This skill is for reviewing what was captured and filling in any gaps — high-level decisions, project context, or user preferences that automated capture might miss.

## Process

1. **Review the conversation** — identify anything notable that happened:
   - New tools, scripts, automations, or features built
   - Important decisions (architecture, approach, tradeoffs)
   - Project status changes
   - New credentials or integrations set up (never save actual secrets)
   - User preferences or feedback learned

2. **Skip if nothing extra needed** — claude-mem auto-captures tool calls. If the session was routine work, say "claude-mem captured everything — nothing extra to save" and stop.

3. **Save gaps via claude-mem** — if there's important context that tool-call observations wouldn't capture (e.g., a verbal decision, a preference, project motivation), use claude-mem's MCP tools or the worker API to save it:
   - POST to `http://127.0.0.1:37777/api/sessions/observations` with the context
   - Or just write it as a concise note to `~/.claude-mem/` if the API isn't available

4. **Report** — tell Sam what was saved, in a short bulleted list.

## Rules

- claude-mem is the single memory system — do NOT write to hikari-brain, Claude Code local memory files, or OpenClaw workspace memory files
- Don't save code patterns or file structure — that's in the code itself
- Don't save actual secrets — only reference 1Password item names
- Convert relative dates to absolute dates
