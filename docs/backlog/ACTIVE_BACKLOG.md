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
- `GATED`: Ready to track, but blocked by explicit approval, external artifacts, or hardware.

## Active Workboard

The current active queue tracks the next preservation-safe gates after the release-readiness docs
pass. Do not change the preserved SWF, create tags, upload release assets, submit external archives,
or start remaster work unless the row's gate has been explicitly cleared.

| Priority | Area                       | Item                                                                            | Status  | Validation / Exit Criteria                                                                                                                                                                          |
| -------- | -------------------------- | ------------------------------------------------------------------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| P1       | Preservation/Rebuild       | Run the Adobe Animate scratch-publish worksheet.                                | BLOCKED | Preflight-only attempt is recorded; resume when Adobe Animate is installed/licensed so the FLA can be opened, scratch-published, browser-smoked, and checked against clean git state.                |
| P1       | Preservation/Rebuild       | Write the full Flash/Animate rebuild guide.                                     | BLOCKED | Only start after the scratch-publish worksheet proves `DieAI.fla` opens and publishes cleanly; guide captures Animate version, publish settings, emitted files, hashes, warnings, and smoke results. |
| P1       | Preservation/Distribution  | Publish the first GitHub preservation release bundle.                           | GATED   | Start only after explicit release-publish approval; rebuild from final clean `main`, generate fresh manifest/checksum values, create the tag/release, upload assets, verify downloads, and record URL/checksum. |
| P1       | External Archive Readiness | Evaluate Internet Archive or Flashpoint submission from the published release.   | GATED   | Start only after the GitHub Release URL and final archive SHA-256 exist; finalize target-specific metadata, rights review, duplicate checks, and Flashpoint local curation testing before any submission. |
| P1       | Wrapper/Runtime            | Vendor the exact Ruffle runtime package files if a release trigger clears.      | GATED   | Start only if CDN reliability, privacy, availability, or self-contained archive requirements justify the footprint; update runtime docs, license coverage, wrapper path, and smoke checks. |
| P2       | Wrapper/Runtime            | Add service-worker caching if an offline or local-runtime trigger clears.       | GATED   | Start only if offline/repeat-load behavior, GitHub Pages caching gaps, or local Ruffle vendoring create a real need; scope cache behavior to wrapper-owned assets with recovery tests. |
| P2       | Accessibility/Input        | Prototype Ruffle `gamepadButtonMapping` with a physical controller.             | GATED   | Start only when physical-controller testing is available; verify accepted SWF key codes, held-button release behavior, focus requirements, game-over recovery, and public control-copy boundaries. |

## Deferred

The following remain intentionally non-active:

- Native JavaScript or canvas remaster work.
- New levels, enemies, scoring systems, or mechanics.
- Touch implementation and mobile-specific gameplay tuning beyond preservation-safe feasibility
  notes.
- Public gamepad support copy or UI before a physical-controller prototype passes.
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
- [Live GitHub Pages Smoke - 2026-05-31](../qa/LIVE_GITHUB_PAGES_SMOKE_2026-05-31.md)
- [Baseline Screenshot QA](../qa/BASELINE_SCREENSHOTS.md)
- [Social Preview Metadata](../qa/SOCIAL_PREVIEW_METADATA.md)
- [Keyboard Focus Audit](../qa/KEYBOARD_FOCUS_AUDIT.md)
- [Keyboard Runtime Input Audit](../qa/KEYBOARD_RUNTIME_INPUT_AUDIT.md)
- [Touch Control Feasibility](../qa/TOUCH_CONTROL_FEASIBILITY.md)
- [Gamepad Support Feasibility](../qa/GAMEPAD_SUPPORT_FEASIBILITY.md)
- [Gamepad Mapping Test Plan](../qa/GAMEPAD_MAPPING_TEST_PLAN.md)
- [Reduced Motion Posture](../qa/REDUCED_MOTION_POSTURE.md)
- [Story And Screens Transcript](../accessibility/STORY_SCREENS_TRANSCRIPT.md)
- [DieAI Preservation Case Study](../portfolio/PRESERVATION_CASE_STUDY.md)
- [Portfolio Link Handoff](../portfolio/PORTFOLIO_LINK_HANDOFF.md)
- [Archive Distribution Decision](../preservation/ARCHIVE_DISTRIBUTION_DECISION.md)
- [Preservation Release Bundle Dry Run](../preservation/PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md)
- [GitHub Release Publish Runbook](../preservation/GITHUB_RELEASE_PUBLISH_RUNBOOK.md)
- [GitHub Release Approval Packet](../preservation/GITHUB_RELEASE_APPROVAL_PACKET.md)
- [External Archive Submission Readiness](../preservation/EXTERNAL_ARCHIVE_SUBMISSION_READINESS.md)
- [Archive Asset Scope](../preservation/ARCHIVE_ASSET_SCOPE.md)
- [Archive Release Inventory Reconciliation](../preservation/ARCHIVE_RELEASE_INVENTORY_RECONCILIATION.md)
- [GreenSock License Review](../preservation/GREENSOCK_LICENSE_REVIEW.md)
- [Historical Rhetorical Analysis Markdown](../historical/CHAVES_RHETORICAL_ANALYSIS.md)
- [Artifact Metadata](../preservation/ARTIFACT_METADATA.md)
- [SWF Provenance And Rebuild Notes](../preservation/SWF_PROVENANCE.md)
- [Adobe Animate Scratch Publish Worksheet](../preservation/ADOBE_ANIMATE_SCRATCH_PUBLISH_WORKSHEET.md)
- [Ruffle Runtime Decision](../preservation/RUFFLE_RUNTIME_DECISION.md)
- [Service Worker Cache Decision](../preservation/SERVICE_WORKER_CACHE_DECISION.md)
- [Original ActionScript Source](../../lib/shoot/)
- [Bundled GreenSock Dependency](../../com/greensock/)
- [Project Screenshots](../../assets/images/)
