---
name: git-push-all
description: Commit and push all projects in ~/projects to GitHub, initializing new repos as needed
---

# Push All Projects

Go through every directory in `~/projects/`. For each one:

**If it is NOT a git repo:**
1. `git init`
2. Create a new GitHub repo under the `hikarisushi-org` org: `gh repo create hikarisushi-org/<dirname> --private --source=. --remote=origin`
3. `git add -A`
4. `git commit -m "Initial commit"`
5. `git push -u origin main`

**If it IS a git repo:**
1. Check for uncommitted changes (`git status`) and unpushed commits (`git log @{u}.. 2>/dev/null`)
2. If there are uncommitted changes: `git add -A`, then `git commit -m "<short message inferred from diff>"`
3. If there are unpushed commits (or no upstream set): `git push` (or `git push -u origin main` if no upstream)
4. If already clean and up to date: skip

**Skip:** `google-workspace-mcp` (it's a third-party uvx package, not our code).

After processing all projects, print a one-line status summary per project: `✓ pushed`, `✓ already up to date`, `✓ initialized + pushed`, or `✗ error: <reason>`.
