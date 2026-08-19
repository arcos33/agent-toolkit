<!-- project-context-logger:managed:start schema=1 sha256=3f159c424aa035d464b3ff5e4e0e87da5a2c62667164cea05ab9ef744596085a -->
## Agent Toolkit Engineer

Purpose: Personal AI-agent toolkit — skills, commands, scripts, templates, and instructions shared across Claude Code, Codex, and opencode.

### Operating contract

- Treat repository files as the source of truth for current implementation; Context Logger stores history, reasoning, and handoff state.
- Treat `Hi, Jarvis`—and the `Hey, Jarvis` or `Hello, Jarvis` variants—as an explicit visible catch-up request, regardless of capitalization or punctuation. Greet briefly, then use the already-injected `PROJECT CONTEXT LOGGER — HISTORICAL BRIEF` when available; otherwise run `.ai/context-logger/run brief --max-chars 4200`. Summarize current state, recent meaningful work, active issues, and the next likely step in concise bullets. Include a past decision or failed approach only when it affects what to do next. Never initialize a Context Logger session for catch-up alone, and never invent the user's name; use it only when a reliable stored preference provides it.
- At the start of meaningful work, use the injected `PROJECT CONTEXT LOGGER — HISTORICAL BRIEF` when present; otherwise run `.ai/context-logger/run brief --max-chars 4200`. Reconcile memory against the repository.
- When code does not explain why it exists, run `.ai/context-logger/run search --query "<topic>" --limit 8` before repeating an old approach.
- Start a Context Logger session only for distinct, substantial work: `.ai/context-logger/run init --user-context "<goal>" --session-title "<title>"`.
- Record architecture decisions, root causes, constraints, direction changes, meaningful implementation milestones, and failed approaches worth remembering.
- Do not log formatting, typo fixes, routine command output, every file touched, or other facts obvious from the repository.
- Before ending substantial work, record a handoff with `.ai/context-logger/run checkpoint --summary "<done>" --current-state "<state>" --next-step "<next>"` plus issues, failures, and verification when relevant.
- The primary agent owns Context Logger writes. Spawned specialists return durable findings to the primary instead of writing memory concurrently.
- Review this generated setup with `.ai/context-logger/run agent update --dry-run`; apply only conflict-free changes.

### Stable project signals

- Stack: Inspect repository evidence before choosing tools
- Important areas: `commands/`, `scripts/`, `skills/`, `templates/`
- Discover and use the repository's own validation commands before changing behavior.
<!-- project-context-logger:managed:end -->

# claude-config

## Existing Project Instructions

Read and follow `CLAUDE.md` completely. It contains the developer communication profile, decision preferences, debugging style, UX expectations, and Markdown preview workflow that apply to work in this repository.
