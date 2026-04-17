---
description: Sync all repos from the hikarisushi-org GitHub organization to ~/projects/
allowed-tools: [Bash, Read, Write]
---

# Sync Hikari Sushi Repos

Sync all repos from the `hikarisushi-org` GitHub organization to the
`~/projects/` directory on this machine.

## Steps

1. **Resolve the projects directory** — run `echo $HOME/projects` to get the
absolute path for this machine. Use this path for all subsequent steps.

2. **List org repos** — run `gh repo list hikarisushi-org --limit 50` to get
the full repo list. Note the exact repo name for each (e.g. `hikari-ha`, not
`ha`).

3. **Check local folders** — for each folder in `~/projects/`, run `git remote
 -v` to get its remote URL and extract the repo name from it.

4. **Detect stale local folders** — if a local folder's remote URL points to a
 repo name that no longer matches the folder name (e.g. folder is `ha` but
remote is `hikari-ha`), that folder is stale from a rename. Rename it locally
to match: `mv ~/projects/<old-name> ~/projects/<new-name>`.

5. **Fix bad remotes** — if any local repo's remote points to `hikarisushi/`
instead of `hikarisushi-org/`, fix it with `git remote set-url origin
https://github.com/hikarisushi-org/<repo>.git`.

6. **Pull existing repos** — for each local repo that belongs to
`hikarisushi-org`, run `git pull` and report what changed.

7. **Clone missing repos** — check for a personal access token first by
running `gh auth token`. If a token is returned, clone using it: `git clone
https://<token>@github.com/hikarisushi-org/<repo>.git ~/projects/<repo>`. If
no token, fall back to plain HTTPS: `git clone
https://github.com/hikarisushi-org/<repo>.git ~/projects/<repo>`.

8. **Report results** — summarize: any folders renamed, what was updated (with
 changed file counts), what was already up to date, and what was newly cloned.

## Notes
- Use `~/projects/` as the work directory — works on any machine regardless of
 username.
- GitHub auto-redirects renamed repos, but local folder names must be manually
 kept in sync — this skill handles that in step 4.
- The active GitHub account varies by machine — run `gh auth status` to
confirm the active account before proceeding.
- For cloning, check for a personal access token first: run `gh auth token` to
 retrieve it. If a token is returned, clone using it: `git clone
https://<token>@github.com/hikarisushi-org/<repo>.git ~/projects/<repo>`. If
no token is available, fall back to plain HTTPS: `git clone
https://github.com/hikarisushi-org/<repo>.git ~/projects/<repo>`.
