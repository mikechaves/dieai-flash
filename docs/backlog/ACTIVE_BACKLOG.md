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

| Priority | Area                | Item                                               | Status | Validation / Exit Criteria                                                                                                                                                       |
| -------- | ------------------- | -------------------------------------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| P1       | Project Framing     | Write the preservation project case-study draft.   | TODO   | A concise Markdown write-up covers the original 2018 context, revival process, Ruffle/tooling choices, artifact links, and portfolio-ready summary; README or evidence links it. |
| P1       | Wrapper Metadata    | Finalize social-preview metadata and image assets. | TODO   | `index.html` includes complete OpenGraph/Twitter metadata, preview image dimensions are documented or validated, and wrapper smoke coverage checks the critical meta tags.       |
| P2       | Accessibility/Input | Audit keyboard focus behavior inside Ruffle.       | TODO   | A wrapper fix or decision note records whether focus can be improved, updates the browser smoke checklist, and keeps the click-to-focus instruction accurate.                    |

## Deferred

The following remain intentionally non-active:

- Native JavaScript or canvas remaster work.
- New levels, enemies, scoring systems, or mechanics.
- Touch controls, gamepad support, and mobile-specific gameplay tuning.
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
- [Story And Screens Transcript](../accessibility/STORY_SCREENS_TRANSCRIPT.md)
- [Archive Distribution Decision](../preservation/ARCHIVE_DISTRIBUTION_DECISION.md)
- [Archive Asset Scope](../preservation/ARCHIVE_ASSET_SCOPE.md)
- [GreenSock License Review](../preservation/GREENSOCK_LICENSE_REVIEW.md)
- [Historical Rhetorical Analysis Markdown](../historical/CHAVES_RHETORICAL_ANALYSIS.md)
- [Artifact Metadata](../preservation/ARTIFACT_METADATA.md)
- [SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md)
- [Ruffle Runtime Decision](../preservation/RUFFLE_RUNTIME_DECISION.md)
- [Original ActionScript Source](../../lib/shoot/)
- [Bundled GreenSock Dependency](../../com/greensock/)
- [Project Screenshots](../../assets/images/)
