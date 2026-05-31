# Changelog

> Lightweight release notes for DieAI preservation and web revival work.

This repo does not publish package versions. Use dated preservation notes when a change materially
affects playability, wrapper behavior, artifact provenance, licensing posture, accessibility, or
public documentation.

Keep entries short and link the durable evidence docs when they carry the detailed decision, audit,
or validation record. Completed backlog rows should be removed from
[Active Backlog](docs/backlog/ACTIVE_BACKLOG.md) and captured here only when the work changes the
project's preservation or visitor-facing posture.

## Unreleased

- No unreleased preservation notes yet. Track planned work in
  [Active Backlog](docs/backlog/ACTIVE_BACKLOG.md).

## 2026-05-31 - Preservation Baseline Notes

### Added

- Added the [Gamepad Support Feasibility](docs/qa/GAMEPAD_SUPPORT_FEASIBILITY.md) decision,
  deferring gamepad implementation while documenting Ruffle's experimental button-to-key mapping
  path and the required physical-controller validation.
- Added the [Touch Control Feasibility](docs/qa/TOUCH_CONTROL_FEASIBILITY.md) decision, deferring
  touch-control implementation while documenting the preserved SWF, Ruffle, and browser-input
  constraints.
- Added the [Service Worker Cache Decision](docs/preservation/SERVICE_WORKER_CACHE_DECISION.md),
  deferring service-worker implementation while documenting the future cache scope for the SWF and
  wrapper images.
- Added the 2026-05-31 Ruffle CDN versus vendored-runtime review to
  [Ruffle Runtime Decision](docs/preservation/RUFFLE_RUNTIME_DECISION.md), keeping the pinned CDN
  path and deferring vendoring until a concrete archival or reliability requirement appears.
- Added a Flash/Animate rebuild-guide feasibility audit to
  [SWF Provenance And Rebuild Notes](docs/preservation/SWF_PROVENANCE.md), documenting the local
  toolchain blocker and the required scratch-publish gate before a full guide is written.
- Added the [Keyboard Focus Audit](docs/qa/KEYBOARD_FOCUS_AUDIT.md), a visible Ruffle focus state,
  and a keyboard-reachable player tab stop while preserving the original SWF input handling.
- Added dedicated social-preview metadata and a `1200x630` preview image for the wrapper, with static
  smoke coverage and [Social Preview Metadata](docs/qa/SOCIAL_PREVIEW_METADATA.md).
- Added the [DieAI Preservation Case Study](docs/portfolio/PRESERVATION_CASE_STUDY.md) as a
  portfolio-ready project draft covering original context, revival approach, tooling decisions, and
  artifact links.
- Added the
  [Archive Distribution Decision](docs/preservation/ARCHIVE_DISTRIBUTION_DECISION.md), selecting a
  GitHub Release preservation bundle as the FLA distribution path while deferring external
  archive submission.
- Added the modern Ruffle wrapper fallback path for blocked runtime states, including the
  direct-`file://` guard and screenshot/control fallback.
- Added static wrapper smoke validation in `scripts/smoke-wrapper.mjs` and the manual
  [Browser Smoke Checklist](docs/backlog/BROWSER_SMOKE_CHECKLIST.md).
- Added accessibility and review evidence through the
  [Story And Screens Transcript](docs/accessibility/STORY_SCREENS_TRANSCRIPT.md) and
  [Baseline Screenshot QA](docs/qa/BASELINE_SCREENSHOTS.md).
- Added preservation evidence for [Artifact Metadata](docs/preservation/ARTIFACT_METADATA.md),
  [SWF Provenance And Rebuild Notes](docs/preservation/SWF_PROVENANCE.md),
  [Ruffle Runtime Decision](docs/preservation/RUFFLE_RUNTIME_DECISION.md),
  [Archive Asset Scope](docs/preservation/ARCHIVE_ASSET_SCOPE.md), and
  [GreenSock License Review](docs/preservation/GREENSOCK_LICENSE_REVIEW.md).
- Added an accessible Markdown transcription of the preserved historical rhetorical analysis in
  [Historical Rhetorical Analysis Markdown](docs/historical/CHAVES_RHETORICAL_ANALYSIS.md).

### Changed

- Formalized `docs/backlog/` as the active/future backlog source of truth for preservation work.
- Documented the current external Ruffle CDN decision and the conditions that would reopen vendoring.
