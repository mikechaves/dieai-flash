# Active Backlog

> Current execution queue for DieAI preservation and web revival work.

_Current as of: 2026-05-31_

---

## Scope

This file is the canonical backlog for work we are willing to start next. It keeps the
near-term queue focused on preserving the original Flash artifact, keeping the web wrapper
reliable, and making the project inspectable.

Rules:

- Keep this file short enough to make real priority tradeoffs.
- Add only work that has clear validation or a decision gate.
- Move completed work to a completion note or changelog instead of leaving `DONE` rows here.
- Keep broad remaster, port, or expansion ideas in [Future Backlog](./FUTURE_BACKLOG.md).
- Do not treat README notes, source comments, screenshots, or historical docs as a work queue.
  Promote new work here or park it in Future Backlog before acting.

## Current Project Posture

- DieAI is a static Ruffle-powered revival of the original 2018 Flash game.
- The repo preserves the original ActionScript source, bundled GreenSock dependency, FLA,
  exported SWF, wrapper page, and project imagery.
- The live demo is hosted on GitHub Pages and intentionally has no build step.
- Near-term work should favor preservation quality, replayability, docs clarity, and wrapper
  reliability over gameplay rewrites.

## Priority Legend

- `P0`: Blocks playability, GitHub Pages reliability, preservation integrity, or basic trust.
- `P1`: Improves project quality, reviewability, or user experience without changing the game.
- `P2`: Worth shaping, but not allowed to displace P0/P1 preservation work without an explicit
  decision.
- `RESEARCH`: Needs a technical or product decision before implementation.

## Active Workboard

| Priority | Area                | Item                                                                 | Status | Validation / Exit Criteria                                                                                                                                                                           |
| -------- | ------------------- | -------------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RESEARCH | Accessibility/Input | Audit touch-control feasibility for the preserved Ruffle build.      | TODO   | A decision note records browser/Ruffle/SWF constraints, whether touch can be supported without changing the original game, and any implementation remains parked unless preservation-safe.           |
| RESEARCH | Accessibility/Input | Audit gamepad-support feasibility for the preserved Ruffle build.    | TODO   | A decision note records whether Ruffle or browser gamepad APIs can route input into the preserved SWF, the testing path, and whether support stays deferred as remaster/platform-specific work.      |
| P2       | Accessibility/Input | Review reduced-motion posture for wrapper effects and documentation. | TODO   | A decision note or wrapper/checklist update confirms current motion behavior, verifies `prefers-reduced-motion` coverage, and leaves future animation guidance clear without changing game behavior. |

## Deferred

The following remain intentionally non-active:

- Native JavaScript or canvas remaster work.
- New levels, enemies, scoring systems, or mechanics.
- Touch/gamepad implementation and mobile-specific gameplay tuning beyond preservation-safe
  feasibility notes.
- Leaderboards, analytics, or account-backed features.
- Broad portfolio-site integration beyond a stable project link.

See [Future Backlog](./FUTURE_BACKLOG.md) for the full parking lot.

## Evidence

- [Project README](../../README.md)
- [Changelog](../../CHANGELOG.md)
- [Live Demo](https://mikechaves.github.io/dieai-flash/)
- [Modern Ruffle Wrapper](../../index.html)
- [Static Wrapper Smoke Script](../../scripts/smoke-wrapper.mjs)
- [Browser Smoke Checklist](./BROWSER_SMOKE_CHECKLIST.md)
- [Baseline Screenshot QA](../qa/BASELINE_SCREENSHOTS.md)
- [Social Preview Metadata](../qa/SOCIAL_PREVIEW_METADATA.md)
- [Keyboard Focus Audit](../qa/KEYBOARD_FOCUS_AUDIT.md)
- [Story And Screens Transcript](../accessibility/STORY_SCREENS_TRANSCRIPT.md)
- [DieAI Preservation Case Study](../portfolio/PRESERVATION_CASE_STUDY.md)
- [Archive Distribution Decision](../preservation/ARCHIVE_DISTRIBUTION_DECISION.md)
- [Archive Asset Scope](../preservation/ARCHIVE_ASSET_SCOPE.md)
- [GreenSock License Review](../preservation/GREENSOCK_LICENSE_REVIEW.md)
- [Historical Rhetorical Analysis Markdown](../historical/CHAVES_RHETORICAL_ANALYSIS.md)
- [Artifact Metadata](../preservation/ARTIFACT_METADATA.md)
- [SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md)
- [Ruffle Runtime Decision](../preservation/RUFFLE_RUNTIME_DECISION.md)
- [Service Worker Cache Decision](../preservation/SERVICE_WORKER_CACHE_DECISION.md)
- [Original ActionScript Source](../../lib/shoot/)
- [Bundled GreenSock Dependency](../../com/greensock/)
- [Project Screenshots](../../assets/images/)
