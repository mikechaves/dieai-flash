# Future Backlog

> Deferred and long-range DieAI ideas that are not in the active execution queue.

_Current as of: 2026-05-24_

---

## Scope

This file is the parking lot. It should not be treated as a commitment to build everything
here. Move items into [Active Backlog](./ACTIVE_BACKLOG.md) only after they have clear
validation, a reason to beat the current queue, and a preservation-safe implementation path.

If another doc records a follow-up, finding, or proposed roadmap item, it must also appear
here or in [Active Backlog](./ACTIVE_BACKLOG.md). Otherwise it is context, not work.

## Preservation And Reproducibility

- [ ] Create a full Flash/Animate rebuild guide if the original toolchain can be reproduced.
- [ ] Record source-to-SWF checksums and artifact metadata for preservation audits.
- [ ] Convert the supporting project analysis document into accessible Markdown if it is useful
      as historical context.
- [ ] Add an archive note explaining which assets are original, generated later, or wrapper-only.
- [ ] Evaluate whether the FLA should be mirrored to a release artifact or external archive.

## Wrapper And Runtime

- [ ] Revisit vendoring Ruffle locally if CDN reliability, availability, privacy, or archival
      requirements justify it.
- [ ] Add a tiny static smoke-test script for the wrapper if the repo starts accepting more web
      changes.
- [ ] Add optional service-worker caching for the SWF and static images if GitHub Pages caching is
      insufficient.
- [ ] Add richer OpenGraph/Twitter preview metadata after the final project card copy is settled.
- [ ] Add a lightweight changelog or release notes once wrapper changes become more frequent.

## Accessibility And Input

- [ ] Add a non-playable story/screens transcript for users who cannot run the Flash game.
- [ ] Research keyboard focus improvements inside the Ruffle embed.
- [ ] Research touch controls for mobile play without changing the original desktop-first game.
- [ ] Research gamepad support through Ruffle/browser APIs.
- [ ] Add reduced-motion guidance for wrapper effects if animation increases.

## Game Remaster Ideas

- [ ] Explore a faithful JavaScript/canvas remaster only after the preserved Flash version is stable.
- [ ] Prototype modern collision and input handling in a separate branch or repo before touching the
      preservation wrapper.
- [ ] Add new levels, enemy behaviors, or scoring only as an explicit remaster track.
- [ ] Add pause, mute, restart, or settings UI outside the Flash runtime if Ruffle limitations allow it.
- [ ] Evaluate a standalone downloadable build if browser runtime support becomes unreliable.

## Portfolio And Distribution

- [ ] Add a portfolio case-study link once the case study exists.
- [ ] Prepare a short project write-up covering original 2018 context, revival process, and tooling.
- [ ] Publish a stable release artifact with the SWF, source snapshot, and wrapper state.
- [ ] Evaluate submitting the preserved build to a Flash preservation archive.
- [ ] Add social-preview screenshots optimized for project sharing.

## Strategic Framing

### Tier 1: Preservation

- Keep the original SWF playable.
- Keep source artifacts inspectable.
- Keep wrapper behavior predictable across common browsers.

### Tier 2: Presentation

- Make the project understandable to visitors, reviewers, and portfolio readers.
- Keep screenshots, controls, story context, and source links easy to scan.

### Tier 3: Reliability

- Avoid fragile CDN/runtime assumptions.
- Add lightweight checks only when they reduce real regression risk.

### Tier 4: Remaster

- Treat ports, new gameplay, and platform-specific controls as a separate product track, not as
  preservation maintenance.

---

_For current execution, see [Active Backlog](./ACTIVE_BACKLOG.md)._
