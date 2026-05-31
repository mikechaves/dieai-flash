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

No active work is selected right now.

The 2026-05-31 live browser smoke pass, preservation case-study refresh, and archive release
inventory reconciliation are complete and linked below. The remaining future backlog items are gated
by Adobe Animate access, explicit release-publish approval, external archive prerequisites, physical
controller hardware, runtime-vendoring requirements, or an explicit remaster decision, so they should
stay parked until one of those gates is satisfied.

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
- [Archive Distribution Decision](../preservation/ARCHIVE_DISTRIBUTION_DECISION.md)
- [Preservation Release Bundle Dry Run](../preservation/PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md)
- [GitHub Release Publish Runbook](../preservation/GITHUB_RELEASE_PUBLISH_RUNBOOK.md)
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
