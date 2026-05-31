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
- 2026-05-31: Completed the Ruffle CDN versus vendored-runtime review in
  [Ruffle Runtime Decision](../preservation/RUFFLE_RUNTIME_DECISION.md); vendoring remains deferred
  until a concrete reliability, privacy, or self-contained archival requirement appears.
- 2026-05-31: Promoted service-worker caching scope to
  [Active Backlog](./ACTIVE_BACKLOG.md) as a wrapper/runtime decision before any implementation.
- 2026-05-31: Completed the service-worker cache scope decision in
  [Service Worker Cache Decision](../preservation/SERVICE_WORKER_CACHE_DECISION.md); implementation
  remains deferred until there is an offline, repeat-load, GitHub Pages cache, or local-vendored
  runtime requirement.
- 2026-05-31: Promoted touch-control feasibility, gamepad-support feasibility, and reduced-motion
  posture review to [Active Backlog](./ACTIVE_BACKLOG.md) as preservation-safe accessibility/input
  decision work.
- 2026-05-31: Completed the touch-control feasibility audit in
  [Touch Control Feasibility](../qa/TOUCH_CONTROL_FEASIBILITY.md); implementation remains deferred
  unless it becomes an explicit remaster or experimental wrapper-overlay track.
- 2026-05-31: Completed the gamepad-support feasibility audit in
  [Gamepad Support Feasibility](../qa/GAMEPAD_SUPPORT_FEASIBILITY.md); implementation remains
  deferred until Ruffle's experimental button-to-key mapping can be verified with a physical
  controller.
- 2026-05-31: Completed the reduced-motion posture review in
  [Reduced Motion Posture](../qa/REDUCED_MOTION_POSTURE.md); future wrapper-owned animation must
  include reduced-motion coverage before shipping.
- 2026-05-31: Promoted documented-keyboard-controls reconciliation to
  [Active Backlog](./ACTIVE_BACKLOG.md) after the reduced-motion review cleared the active queue.
- 2026-05-31: Completed documented-keyboard-controls reconciliation in
  [Keyboard Runtime Input Audit](../qa/KEYBOARD_RUNTIME_INPUT_AUDIT.md); public control copy now
  reflects the runtime-confirmed `A`, `D`, and `Space` inputs.
- 2026-05-31: Promoted the preservation release bundle dry run to
  [Active Backlog](./ACTIVE_BACKLOG.md) as repo-owned distribution readiness work. The actual
  GitHub Release publish step remains deferred until the dry run passes and a publish pass is
  explicitly requested.
- 2026-05-31: Completed the preservation release bundle dry run in
  [Preservation Release Bundle Dry Run](../preservation/PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md);
  the actual GitHub Release publish step remains deferred until explicitly requested.

## Preservation And Reproducibility

- [ ] Write a full Flash/Animate rebuild guide after Adobe Animate can open `DieAI.fla`, publish a
      scratch SWF/HTML pair, and record emitted sizes, hashes, warnings, and browser-smoke results
      without changing tracked game assets.

## Wrapper And Runtime

- [ ] Vendor the exact Ruffle runtime package files only if CDN reliability, privacy, or
      self-contained archival-release requirements justify the added runtime footprint and upgrade
      procedure.
- [ ] Add service-worker caching only if the project needs offline/repeat-load behavior, GitHub
      Pages caching becomes insufficient, or Ruffle is vendored locally; keep the scope limited to
      `assets/DieAI.swf` and committed wrapper images.

## Accessibility And Input

- [ ] Add touch controls only as an explicit remaster or wrapper-overlay track after real-device
      validation proves movement, shooting, focus, viewport scaling, and recovery can be supported
      without changing preservation semantics.
- [ ] Prototype Ruffle `gamepadButtonMapping` only after a physical-controller test plan exists;
      verify accepted SWF key codes, held-button release behavior, focus requirements, and control
      copy before publishing gamepad support.

## Game Remaster Ideas

- [ ] Explore a faithful JavaScript/canvas remaster only after the preserved Flash version is stable.
- [ ] Prototype modern collision and input handling in a separate branch or repo before touching the
      preservation wrapper.
- [ ] Add new levels, enemy behaviors, or scoring only as an explicit remaster track.
- [ ] Add pause, mute, restart, or settings UI outside the Flash runtime if Ruffle limitations allow it.
- [ ] Evaluate a standalone downloadable build if browser runtime support becomes unreliable.

## Portfolio And Distribution

- [ ] Add an external portfolio-site link to the case study once the portfolio page is published.
- [ ] Publish the first GitHub preservation release bundle after the active dry run passes and a
      release publish pass is explicitly started; include the FLA, SWF, source, wrapper state, docs,
      and SHA-256 manifest.
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
