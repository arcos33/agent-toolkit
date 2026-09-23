# write-rules.md — Project Files Write Contract

Governs the seven project files in a single project or confirmed sub-topic. This conversation supplies the session's new information; existing files supply the baseline.

## Rule 1 — Which fact goes where

- **README.md** — stable project overview, setup, and usage. Change it when those facts change.
- **PROJECT-STATE.md** — concise current status, blockers, and one `NEXT ACTION`. Include exact resumption detail when continuing immediately. This file reflects *now*: rewrite stale status rather than appending history.
- **ACTION-ITEMS.md** — open and resolved work. Move an item from open to resolved in place; don't duplicate it. Keep task details here so `PROJECT-STATE.md` stays short.
- **SESSION-LOG.md** — append-only dated record of what happened in each working session, including findings, verification, where work stopped, and what is next.
- **CHANGELOG.md** — meaningful changes to the project. Do not add an entry merely because a session occurred.
- **DECISION-LOG.md** — settled decisions, non-obvious findings, root causes, and reasoning. Do not turn routine activity into a decision entry.
- **SPECS.md** — current confirmed requirements, measurements, interfaces, and constraints.

## Rule 2 — Preserve the decision trail

- **Fixing how an entry is written** (a typo, unclear wording, wrong reference) — edit it in place.
- **Reversing the decision or correcting the underlying conclusion** — retain the old entry and add a new dated entry explaining the reversal and evidence.

## Rule 3 — Dedupe before writing

Check existing files before adding an entry. A session that reconfirms an existing decision adds no new decision entry. Update current status and task state in place.

## Rule 4 — Date and support durable entries

Date `DECISION-LOG.md` and `SESSION-LOG.md` entries (`YYYY-MM-DD`). Where useful, cite the file, test, command output, or observed result that supports them. Do not present unverified claims as confirmed.

## Rule 5 — SESSION-LOG.md always gets an entry

At session close, append one dated entry even if no decisions or project changes resulted. State that nothing durable changed when that is the case.

## Rule 6 — No padding

An empty change, decision, or spec update is valid. Do not add entries solely to make a session look productive.
