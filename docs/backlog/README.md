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
- [Story And Screens Transcript](../accessibility/STORY_SCREENS_TRANSCRIPT.md): non-playable
  story, controls, level, and game-over context for users who cannot run Flash or Ruffle.
- [Baseline Screenshot QA](../qa/BASELINE_SCREENSHOTS.md): temporary desktop and mobile screenshot
  evidence for wrapper regression review.
- [Archive Asset Scope](../preservation/ARCHIVE_ASSET_SCOPE.md): review map for original,
  exported, wrapper-only, documentation, and external runtime assets.
- [GreenSock License Review](../preservation/GREENSOCK_LICENSE_REVIEW.md): public-repo posture for
  bundled third-party ActionScript source.
- [Artifact Metadata](../preservation/ARTIFACT_METADATA.md): preservation audit checksums, sizes,
  and manifest commands.
- [SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md): source artifact and
  rebuild-path evidence.
- [Ruffle Runtime Decision](../preservation/RUFFLE_RUNTIME_DECISION.md): pinned CDN versus
  vendored-runtime decision.

## Rules

- Add new work to a backlog, not to scattered notes.
- Do not leave roadmap commitments, follow-up tasks, or open findings only inside README,
  source comments, screenshots, or historical docs.
- Link historical artifacts only as evidence.
- Move completed work into a completion/decision note if the work materially changes the
  preservation strategy.
- Keep completed work out of the active queue unless it is needed as validator evidence.
- Do not add per-doc version stamps. Use release notes and "current as of" dates for freshness.
