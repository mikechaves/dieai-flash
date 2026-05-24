# Active Backlog

> Current execution queue for DieAI preservation and web revival work.

_Current as of: 2026-05-24_

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

| Priority | Area              | Item                                                                              | Status   | Validation / Exit Criteria                                                                                                                                            |
| -------- | ----------------- | --------------------------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| P0       | Preservation      | Document SWF provenance and the rebuild path from source artifacts.               | TODO     | Docs identify the source FLA, ActionScript entry points, bundled dependencies, expected publish target, tool assumptions, and known gaps to recreating `DieAI.swf`.   |
| P1       | Runtime Stability | Decide whether to vendor Ruffle locally instead of relying on a CDN script.       | RESEARCH | Decision note compares pinned CDN, vendored runtime, cache behavior, maintenance burden, and GitHub Pages reliability; chosen path is documented in README/backlog.   |
| P1       | User Experience   | Improve the Ruffle-unavailable fallback beyond an error message.                  | TODO     | When Ruffle cannot load, the page still gives a useful non-playable experience with screenshots, controls, and clear next action without obscuring the rest of page.  |
| P1       | QA Evidence       | Capture baseline screenshots for wrapper regression review.                       | TODO     | Desktop and mobile screenshots are regenerated from the live/local page, named predictably, and referenced from a lightweight QA note without committing temp output. |
| P2       | Licensing         | Confirm public-repo licensing posture for bundled GreenSock ActionScript sources. | TODO     | LICENSE/README notes clearly distinguish original DieAI code, bundled third-party source, and any redistribution constraints discovered during review.                |

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
- [Live Demo](https://mikechaves.github.io/dieai-flash/)
- [Modern Ruffle Wrapper](../../index.html)
- [Browser Smoke Checklist](./BROWSER_SMOKE_CHECKLIST.md)
- [Original ActionScript Source](../../lib/shoot/)
- [Bundled GreenSock Dependency](../../com/greensock/)
- [Project Screenshots](../../assets/images/)
