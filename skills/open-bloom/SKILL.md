---
name: open-bloom
description: Open the current directory (or PATH) in Bloom file manager. Use when the user says "open".
---

# Open in Bloom

When the user says **open**, open the working directory in **Bloom** (`/Applications/Bloom.app`). Reuses the **front Bloom window** (navigates via AppleScript); only opens a new window if Bloom has none.

## Run

```bash
~/projects/claude-config/scripts/open-bloom.sh [PATH]
```

| Input | Result |
|-------|--------|
| **open** (no path) | Bloom opens **cwd** |
| **open** `subdir` | Bloom opens that path (relative to cwd) |

Use the agent's current working directory / active workspace root when cwd is unclear.
