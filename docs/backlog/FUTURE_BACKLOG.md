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

## Accessibility And Input

- [ ] Add touch controls only as an explicit remaster or wrapper-overlay track after real-device
      validation proves movement, shooting, focus, viewport scaling, and recovery can be supported
      without changing preservation semantics.

## Game Remaster Ideas

- [ ] Explore a faithful JavaScript/canvas remaster only after the preserved Flash version is stable.
- [ ] Prototype modern collision and input handling in a separate branch or repo before touching the
      preservation wrapper.
- [ ] Add new levels, enemy behaviors, or scoring only as an explicit remaster track.
- [ ] Add pause, mute, restart, or settings UI outside the Flash runtime if Ruffle limitations allow it.
- [ ] Evaluate a standalone downloadable build if browser runtime support becomes unreliable.

## Portfolio And Distribution

- [ ] Add an external portfolio-site link to the case study once the portfolio page is published and
      the repository handoff requirements are satisfied.

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
