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

## Preservation And Reproducibility

- [ ] Write a full Flash/Animate rebuild guide after the scratch-publish worksheet proves Adobe
      Animate can open `DieAI.fla`, publish a scratch SWF/HTML pair, and record emitted sizes,
      hashes, warnings, and browser-smoke results without changing tracked game assets.

## Wrapper And Runtime

- [ ] Vendor the exact Ruffle runtime package files only if CDN reliability, privacy, or a
      self-contained preservation-release requirement justifies the added runtime footprint and
      upgrade procedure.
- [ ] Add service-worker caching only if the project needs offline/repeat-load behavior, GitHub
      Pages caching becomes insufficient, or Ruffle is vendored locally; keep the scope limited to
      `assets/DieAI.swf` and committed wrapper images.

## Accessibility And Input

- [ ] Add touch controls only as an explicit remaster or wrapper-overlay track after real-device
      validation proves movement, shooting, focus, viewport scaling, and recovery can be supported
      without changing preservation semantics.
- [ ] Prototype Ruffle `gamepadButtonMapping` only after the physical-controller test plan can be
      run against real hardware; verify accepted SWF key codes, held-button release behavior, focus
      requirements, and control copy before publishing gamepad support.

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
- [ ] Publish the first GitHub preservation release bundle using the approval-gated runbook after a
      release publish pass is explicitly approved; include the FLA, SWF, source, wrapper state, docs,
      the reconciled release inventory, and SHA-256 manifest from the final release commit.
- [ ] Evaluate submitting the preserved build to Internet Archive or Flashpoint after the GitHub
      preservation release bundle exists, the final checksum is recorded, target-specific metadata
      is finalized, and any Flashpoint curation package passes local testing.

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
