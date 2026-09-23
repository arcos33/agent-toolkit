---
name: open-finder
description: Open the containing folder of the current file or artifact in Finder when the user says "open".
---

# Open the containing folder in Finder

When the user says **open**, resolve the file or artifact from the conversation and open its containing folder in Finder. Do not launch the file or merely select it with `open -R`.

## Resolve the folder

Use this priority order:

1. If the user names a file or artifact, open its containing folder. If they name a folder, open that folder.
2. For a bare **open**, open the folder containing the file, screen, deliverable, or artifact most recently discussed or created. A recently active client/screen folder is more relevant than the repository root.
3. Only when the conversation has no clear folder target, open the active workspace root or current working directory.

Do not ignore clear conversational context merely because the user omitted the path in the latest message.

## Run

Use `open [DIRECTORY]`. Confirm the directory exists before opening it when the target is uncertain.

| Input | Result |
|-------|--------|
| **open** after discussing an image | Finder opens the image's containing folder |
| **open** with no contextual target | Finder opens the active workspace root or **cwd** |
| **open** `subdir` | Finder opens that folder (relative to cwd) |
