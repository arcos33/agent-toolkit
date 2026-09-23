---
name: session-start-personal
description: "Resume a personal project from its project files at the project root. Read PROJECT-STATE.md, ACTION-ITEMS.md, the latest SESSION-LOG.md entries, and relevant decisions to give a brief bullet summary of current state, recent work, next action, and blockers."
when_to_use: "At the start of a fresh session picking up a personal project closed out in a previous one — 'resume this', 'pick this back up', 'continue where I left off', or right after telling session-close-personal you're continuing right away and then opening a new session."
allowed-tools: "Read, Bash, Grep, AskUserQuestion"
---

# Resume a Personal Project Session, Cheaply

The read-back half of the personal project files workflow. `session-close-personal` writes a session's output into the project files at the end; this reads the current state back at the start of the next one.

**Don't reconstruct state from scratch.** Stick to what Step 2 reads plus the cheap local checks in Step 3. If the docs turn out to be stale, say so and ask what to do — don't start re-deriving history yourself.

## Step 1 — Resolve the project and thread

In order, stopping at the first that works:

1. The current working directory, if it's already inside a project with project files.
2. A project named in this conversation.
3. If neither, list projects with `PROJECT-STATE.md`/`SESSION-LOG.md` pairs under the user's project roots and their newest session entry date, most recent first. Four or fewer: AskUserQuestion. More: a numbered plain-text list.

If the project has multiple sub-topics with their own project files (per session-close-personal's Step 2), resolve which one the same way — ask if it isn't obvious from context.

If the resolved project has no project files yet, say so — there's nothing to resume from. Don't fall back to guessing from memory.

## Step 2 — Read the docs

Read that project's `PROJECT-STATE.md`, `ACTION-ITEMS.md`, and newest few `SESSION-LOG.md` entries. Read `README.md` for stable context if needed. During migration, if `PROJECT-STATE.md` says its first snapshot is pending or labels its handoff older than the README, read `README.md` § Pick up here as the previous handoff and label it as such. Read `DECISION-LOG.md` entries referenced by the state or needed for the next action; consult `SPECS.md` or recent `CHANGELOG.md` entries only when relevant. These project files are the data source for the initial brief.

Pull out:

- `PROJECT-STATE.md`'s current status and `NEXT ACTION`. If the last session-close-personal ran in "continuing right away" mode, use its exact file/line/command, uncommitted-file list, and pending verification where concrete.
- Open `ACTION-ITEMS.md` bullets relevant to the next action.
- What the most recent `SESSION-LOG.md` entry says happened and where work stopped.
- Relevant `DECISION-LOG.md` entries only when they explain the next action.

## Step 3 — Flag staleness, don't chase it

`PROJECT-STATE.md` is a claim, not a live query. Two cheap, local checks before trusting it:

- If code was involved, run git status and, if there's a remote, git log origin/<branch>..HEAD. If the files say "pushed, clean" but the branch has moved since the `SESSION-LOG.md` entry's date, say so plainly.
- If the docs mention some other external state (a running process, a deploy, a test left failing), a quick local check is fine. Don't go re-deriving the full task here — that's the actual work once resumed, not part of resuming.

If something's meaningfully stale, say what's stale and let the user decide whether to re-verify first or just proceed knowing the gap.

## Step 4 — Hand back a resume brief, not a re-briefing

Start the new session with a brief summary in bullets, like a compact GSD catch-up. Report just enough to act on the next step immediately:

**my-cli-tool**

- **Current state:** Head a3f21c9 matches origin; nothing local-only.
- **Last session:** Confirmed the retry approach; implementation remains open.
- **Next action:** Wire exponential backoff into fetch.ts:88 (`DECISION-LOG.md`, 2026-09-20).
- **Open items/blockers:** None beyond the next action. Nothing left running from the last session.

If `PROJECT-STATE.md` was written in the terse style, the brief will naturally be shorter. Omit bullets with no useful information; don't pad to match the example.

## Reference

- Write-rules contract for the docs this reads: write-rules.md, in session-close-personal's skill folder
- Write-back half: session-close-personal — its "continuing right away" mode supplies exact resumption detail
