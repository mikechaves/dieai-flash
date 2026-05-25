# DieAI Backlog

This directory is the active planning home for DieAI preservation and web revival work.

Use backlog documents for current and future work. Historical project notes, screenshots,
source files, and README sections are supporting evidence, not planning queues.

## Source Of Truth

[Active Backlog](./ACTIVE_BACKLOG.md) and [Future Backlog](./FUTURE_BACKLOG.md) are the
only canonical work queues.

Other docs may contain decisions, evidence, run notes, QA checklists, or historical
context, but they should not become shadow backlogs. If a review, audit, or project note
discovers new work, do one of the following in the same change:

- Add near-term work to [Active Backlog](./ACTIVE_BACKLOG.md) with priority and validation
  criteria.
- Add deferred or decision-bound work to [Future Backlog](./FUTURE_BACKLOG.md).
- Mark the finding `DONE / SUPERSEDED` with a short rationale if it is no longer valid.
- Keep validation-only checklists in their local docs only when they describe how to verify
  a feature, not what to build next.

## Canonical Files

- [Active Backlog](./ACTIVE_BACKLOG.md): current preservation and web-wrapper execution queue.
- [Future Backlog](./FUTURE_BACKLOG.md): deferred, long-range, or decision-bound work.
- [Browser Smoke Checklist](./BROWSER_SMOKE_CHECKLIST.md): repeatable playability and wrapper
  regression checks.
- [SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md): source artifact and
  rebuild-path evidence.

## Rules

- Add new work to a backlog, not to scattered notes.
- Do not leave roadmap commitments, follow-up tasks, or open findings only inside README,
  source comments, screenshots, or historical docs.
- Link historical artifacts only as evidence.
- Move completed work into a completion/decision note if the work materially changes the
  preservation strategy.
- Keep completed work out of the active queue unless it is needed as validator evidence.
- Do not add per-doc version stamps. Use release notes and "current as of" dates for freshness.
