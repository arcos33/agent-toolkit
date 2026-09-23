---
name: session-close-personal
description: "Close out a working session into the project's seven project files: README.md, PROJECT-STATE.md, ACTION-ITEMS.md, SESSION-LOG.md, CHANGELOG.md, DECISION-LOG.md, and SPECS.md. Reads the conversation for durable decisions, findings, changes, current state, and next actions so a fresh session can resume from the files."
when_to_use: "When the user is wrapping up a working session on a personal project and wants what it produced preserved — 'I'm done for now', 'closing out', 'wrap up this session', 'record what we did before I start fresh'."
allowed-tools: "Read, Write, Edit, Bash, Grep, AskUserQuestion"
---

# Close Out a Session Into This Project's Files

A lightweight personal session close-out workflow. The project's seven files have distinct roles; this conversation supplies the new session information.

**Read `write-rules.md` (in this same skill folder) before writing anything** — that file is the contract for file roles, dedupe, provenance, and dating. Don't re-derive those rules from memory.

## Step 1 — Ask how you're closing

Before triaging anything, ask what happens right after this: `AskUserQuestion` with something like:

- **Continuing right away, new session** — same task, closing only to shed context weight (the token-conservation case).
- **Done for now** — picking this back up another day.
- **Switching to a different task** — attention moves elsewhere, unclear when this comes back.

This doesn't change *what* counts as durable (Step 4's rules are the same regardless), and it doesn't change `DECISION-LOG.md`, `ACTION-ITEMS.md`, or `SESSION-LOG.md` at all — a decision is a decision whether you're back in five minutes or five days. It changes only how much resumption detail `PROJECT-STATE.md` gets in Step 6:

- **Continuing right away** — write the dense version: exact branch/file/line or command to run next, any pending verification or in-flight agent, a one-line summary of uncommitted work if there is any.
- **Done for now / switching tasks** — the normal terse handoff: one `NEXT ACTION` line plus brief context.

If the user already said which mode applies, skip asking — just note which mode you're using.

**Check for anything still running before closing, regardless of mode.** A background agent or subagent dispatched this session is not resumable from a new session. If one is still in flight, say so and let the user decide: wait for it, or accept losing it.

## Step 2 — Resolve the project and thread

No epic-key lookup here — the project is just the current working directory / repo. Confirm it's the right one (e.g. `pwd`, `git remote -v`) if there's any ambiguity.

**Sub-topics:** most sessions belong to the project's main set of project files at its root. If this project has more than one active thread (a distinct feature/experiment being tracked separately), ask whether this session belongs to the root or to a named sub-topic folder (e.g. `./session/<topic>/`) with its own project files. Don't create a new sub-topic folder speculatively — only when the user confirms this is genuinely a separate thread, not just a phase of the main one.

If the project files don't exist yet, offer to scaffold them before writing.

## Step 3 — Read the baseline

Read `PROJECT-STATE.md`, `ACTION-ITEMS.md`, `DECISION-LOG.md`, recent `SESSION-LOG.md` entries, and recent `CHANGELOG.md` entries. Consult `README.md` and `SPECS.md` for project context and confirmed requirements. You need the baseline to dedupe and to know what the current state claims. Anything already recorded there isn't news.

Also check `git status` and the current branch if code was involved. Uncommitted work is a status fact worth recording. Distinguish **local-only commits from pushed ones** (`git log origin/<branch>..HEAD`) too, if there's a remote.

In "continuing right away" mode, carry the actual file list forward, not a summary. In the other two modes a summary is fine.

## Step 4 — Triage the session

Walk the conversation and pull out only what's durable. Sort each item into the seven project files per the write-rules contract. Be strict — the failure mode isn't missing something, it's filling `DECISION-LOG.md` with narration.

What tends to be durable at close time:

- **A decision** — an approach settled, a design question closed, an API shape agreed. Would a future session go wrong without knowing it?
- **An insight about the code** — a non-obvious mechanism found, a wrong assumption corrected, a root cause identified.
- **Status** — what's done, what's half-done, what's uncommitted, what a test now proves.
- **A next step** — the single concrete thing to do next, which becomes `PROJECT-STATE.md`'s `NEXT ACTION`.
- **New open items** — something surfaced that needs doing, not yet in `ACTION-ITEMS.md`.
- **A meaningful change** — what changed in the project, for `CHANGELOG.md`.
- **A confirmed requirement or measurement** — current measurable truth, for `SPECS.md`.
- **Stable overview or usage information** — update `README.md` only when that information changed.

What is *not* durable: files read, searches run, options weighed and dropped, a bug introduced and fixed within the session, your own summaries of work already visible in the diff.

## Step 5 — Show the triage, then write

Print what you extracted and where each item lands, grouped by target file, before touching anything:

DECISION-LOG.md — 1 new entry
- <decision + why>

ACTION-ITEMS.md — 1 new, 0 resolved
- New: <item>

PROJECT-STATE.md — current state updated
- NEXT ACTION becomes: <next step>

CHANGELOG.md — 1 meaningful change (if any)

SPECS.md / README.md — updated only if their content changed

SESSION-LOG.md — 1 entry

Then ask for the OK. Cutting a row here is free; a wrong `DECISION-LOG.md` row is permanent.

If the user waves it through or has already said to just write, skip the confirmation — but still print what you wrote afterward.

## Step 6 — Write, then report

Apply the writes per the contract: retain superseded decisions in `DECISION-LOG.md`, dedupe first, date entries (`YYYY-MM-DD`), always write the `SESSION-LOG.md` entry even if nothing else changed. Keep `PROJECT-STATE.md` concise; put task detail in `ACTION-ITEMS.md`.

Report which files changed and what went in. If the session produced nothing durable, say that plainly and write only the `SESSION-LOG.md` entry — don't pad entries to make the session look productive.

## Reference

- Write-rules contract: `write-rules.md`, in this same skill folder
- Everything reads/writes plain files in the project itself
