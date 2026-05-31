# Future Backlog

> Deferred and long-range DieAI ideas that are not in the active execution queue.

_Current as of: 2026-05-31_

---

## Scope

This file is the parking lot. It should not be treated as a commitment to build everything
here. Move items into [Active Backlog](./ACTIVE_BACKLOG.md) only after they have clear
validation, a reason to beat the current queue, and a preservation-safe implementation path.

If another doc records a follow-up, finding, or proposed roadmap item, it must also appear
here or in [Active Backlog](./ACTIVE_BACKLOG.md). Otherwise it is context, not work.

## Promotion Notes

- 2026-05-31: Promoted Flash/Animate rebuild-guide feasibility to
  [Active Backlog](./ACTIVE_BACKLOG.md) as decision-gated preservation/reproducibility work.
- 2026-05-31: Completed the Flash/Animate rebuild-guide feasibility audit in
  [SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md); a full guide remains
  deferred until Adobe Animate can complete a scratch publish round trip.
- 2026-05-31: Promoted the pinned Ruffle CDN versus vendored-runtime review to
  [Active Backlog](./ACTIVE_BACKLOG.md) as decision-gated wrapper/runtime work.
- 2026-05-31: Promoted service-worker caching scope to
  [Active Backlog](./ACTIVE_BACKLOG.md) as a wrapper/runtime decision before any implementation.

## Preservation And Reproducibility

- [ ] Write a full Flash/Animate rebuild guide after Adobe Animate can open `DieAI.fla`, publish a
      scratch SWF/HTML pair, and record emitted sizes, hashes, warnings, and browser-smoke results
      without changing tracked game assets.

## Wrapper And Runtime

- Promoted: Ruffle vendoring review is now active as a runtime decision gate.
- Promoted: service-worker caching scope is now active as a cache-scope decision gate.

## Accessibility And Input

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

- [ ] Add an external portfolio-site link to the case study once the portfolio page is published.
- [ ] Publish the first GitHub preservation release bundle when a release publish pass is explicitly
      started; include the FLA, SWF, source, wrapper state, docs, and SHA-256 manifest.
- [ ] Evaluate submitting the preserved build to a Flash preservation archive after the GitHub
      preservation release bundle exists and the rights/metadata note is ready.

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
