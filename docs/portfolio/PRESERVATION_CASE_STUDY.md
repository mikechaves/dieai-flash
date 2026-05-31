# DieAI Preservation Case Study

> Portfolio-ready draft for the DieAI Flash revival and preservation project.

_Current as of: 2026-05-31_

---

## Summary

DieAI is a preservation-focused revival of a 2018 Flash game by Michael Chaves. The project keeps the
original Adobe Animate authoring file, ActionScript source, exported SWF, bundled GreenSock
dependency, screenshots, and modern web wrapper together so the game can still be played and reviewed
after browser Flash Player support ended.

The current public version uses a static GitHub Pages wrapper and the Ruffle emulator to run the
original SWF in modern browsers. The revival work intentionally avoids a gameplay rewrite. Its goal
is to preserve the artifact, document the build context, and make the game understandable to players,
reviewers, and future portfolio readers.

## Portfolio Summary

DieAI began as a student Flash game about AICorp Buddy Bots being hacked before launch. The preserved
version now runs through Ruffle on a static web page, with fallback screenshots, controls, source
links, checksum records, and rebuild notes. The work demonstrates legacy-game preservation,
documentation discipline, source archaeology, and practical modernization without replacing the
original runtime artifact.

## Original Context

The original game was built in 2018 for GIMM 110. Its story places Dr. Gimmastein in a warehouse on
the night before AICorp ships its first Buddy Bots. When the robots are compromised and begin moving
toward the exit, the player has to stop them before they leave the facility.

The historical analysis preserved in
[Individual Game Rhetorical Analysis](../historical/CHAVES_RHETORICAL_ANALYSIS.md) describes the
project as a modified version of a "Shoot" game. The original implementation used ActionScript 3,
Flash timeline symbols, GreenSock intro animation, keyboard input, enemy robots, lasers, a timer,
score display, and win/loss states.

## Revival Approach

The revival keeps three layers separate:

1. The original artifact layer: `DieAI.fla`, `lib/shoot/**`, `com/greensock/**`, and the exported
   `assets/DieAI.swf`.
2. The modern presentation layer: `index.html`, wrapper screenshots, fallback UI, README, and
   validation scripts.
3. The preservation evidence layer: provenance, checksum, archive-scope, licensing, accessibility,
   and backlog notes under `docs/`.

This separation keeps the original game inspectable while letting the web wrapper improve browser
behavior, visitor context, and fallback states.

## Technical Decisions

### Ruffle Runtime

The wrapper loads Ruffle from a pinned `@ruffle-rs/ruffle@0.2.0` CDN URL. The decision is documented
in [Ruffle Runtime Decision](../preservation/RUFFLE_RUNTIME_DECISION.md). Vendoring is deferred
until CDN reliability, archival self-containment, privacy, or release-bundle requirements justify the
extra repository weight.

### Static Wrapper

The live page has no build step. It uses `index.html`, committed images, and `assets/DieAI.swf`.
Direct `file://` launches are blocked with a custom local-server message before Ruffle loads, because
browsers block runtime features needed by the emulator on local file URLs.

### Source And Rebuild Evidence

[SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md) records the FLA metadata,
publish settings, ActionScript entry points, symbol dependencies, and expected Adobe Animate rebuild
path.
[Adobe Animate Scratch Publish Worksheet](../preservation/ADOBE_ANIMATE_SCRATCH_PUBLISH_WORKSHEET.md)
captures the future round-trip evidence needed before writing a full rebuild guide.
[Artifact Metadata](../preservation/ARTIFACT_METADATA.md) records checksums and byte sizes for the
core preservation set.

### Third-Party Dependency Posture

The original source depends on bundled GreenSock ActionScript files. The project keeps those files as
third-party source for rebuild compatibility and documents the posture in
[GreenSock License Review](../preservation/GREENSOCK_LICENSE_REVIEW.md).

### Release And Archive Posture

The archive path is approval-gated rather than automatic.
[Archive Distribution Decision](../preservation/ARCHIVE_DISTRIBUTION_DECISION.md) selects a GitHub
Release preservation bundle as the first distribution gate, while
[Preservation Release Bundle Dry Run](../preservation/PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md) proves
the local bundle and manifest command shape.
[Archive Release Inventory Reconciliation](../preservation/ARCHIVE_RELEASE_INVENTORY_RECONCILIATION.md)
aligns the archive asset scope, release inventory, external Ruffle posture, temporary-artifact
exclusions, and checksum expectations before any real publish pass.

## User Experience

The modern wrapper provides:

- A playable Ruffle player for HTTP and HTTPS contexts.
- A direct local-file guard that avoids Ruffle's default protocol error.
- Screenshots and story context when the SWF cannot run.
- Visible controls for keyboard play.
- Links to source, preservation notes, and the live demo.

For non-playable review, [Story And Screens Transcript](../accessibility/STORY_SCREENS_TRANSCRIPT.md)
describes the start screen, opening story, hacked warning, gameplay scene, game-over state, and
controls.

## Validation

The project uses lightweight checks rather than a build pipeline:

- `node scripts/smoke-wrapper.mjs` verifies wrapper-critical paths, constants, fallback copy,
  controls, and the local-file guard.
- [Live GitHub Pages Smoke - 2026-05-31](../qa/LIVE_GITHUB_PAGES_SMOKE_2026-05-31.md) records a
  live HTTPS pass covering Ruffle load, SWF fetch, focus, `A`/`D`/`Space` controls, responsive
  layout, network responses, console observations, and the direct `file://` guard.
- [Browser Smoke Checklist](../backlog/BROWSER_SMOKE_CHECKLIST.md) describes manual live/local
  browser checks for the player, assets, console output, responsive layout, and fallback behavior.
- [Baseline Screenshot QA](../qa/BASELINE_SCREENSHOTS.md) records current desktop and mobile wrapper
  screenshot evidence.
- [Keyboard Focus Audit](../qa/KEYBOARD_FOCUS_AUDIT.md) and
  [Keyboard Runtime Input Audit](../qa/KEYBOARD_RUNTIME_INPUT_AUDIT.md) document the wrapper focus
  path and runtime-confirmed `A`, `D`, and `Space` controls.
- [Touch Control Feasibility](../qa/TOUCH_CONTROL_FEASIBILITY.md),
  [Gamepad Support Feasibility](../qa/GAMEPAD_SUPPORT_FEASIBILITY.md), and
  [Gamepad Mapping Test Plan](../qa/GAMEPAD_MAPPING_TEST_PLAN.md) keep platform-specific input work
  parked behind preservation-safe validation gates.

## Current Gaps

- The repo does not yet include an automated command-line SWF rebuild.
- The exact Adobe Animate version required for a clean round trip remains unproven.
- Ruffle is still loaded externally rather than vendored.
- GitHub Release bundling is parked until a release publish pass is explicitly started.
- External archive submission is deferred until a release bundle, checksum, rights note, and archive
  target are ready.
- The external portfolio-site link remains deferred until a portfolio page exists.

## Primary Links

- [Live Demo](https://mikechaves.github.io/dieai-flash/)
- [Project README](../../README.md)
- [Modern Wrapper](../../index.html)
- [Live GitHub Pages Smoke - 2026-05-31](../qa/LIVE_GITHUB_PAGES_SMOKE_2026-05-31.md)
- [Original ActionScript Source](../../lib/shoot/)
- [Artifact Metadata](../preservation/ARTIFACT_METADATA.md)
- [Archive Asset Scope](../preservation/ARCHIVE_ASSET_SCOPE.md)
- [Archive Release Inventory Reconciliation](../preservation/ARCHIVE_RELEASE_INVENTORY_RECONCILIATION.md)
- [Archive Distribution Decision](../preservation/ARCHIVE_DISTRIBUTION_DECISION.md)
