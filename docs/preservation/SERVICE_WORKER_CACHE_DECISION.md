# Service Worker Cache Decision

> Decision record for service-worker caching in the DieAI web wrapper.

_Current as of: 2026-05-31_

---

## Decision

Do not add a service worker to the live wrapper right now.

The current GitHub Pages and Ruffle CDN caching behavior is good enough for the preservation wrapper,
and adding a service worker would introduce update and stale-asset risk without a current offline or
repeat-load requirement.

## Current Runtime Shape

The project is intentionally static:

- `index.html` is the only modern wrapper page.
- `assets/DieAI.swf` is the preserved playable Flash build.
- `assets/images/*.png` are wrapper, transcript, fallback, and social-preview images.
- Ruffle is loaded from the pinned external package documented in
  [Ruffle Runtime Decision](./RUFFLE_RUNTIME_DECISION.md).
- The repo does not currently register a service worker or include a web app manifest.

## Header And Size Evidence

Observed on 2026-05-31:

| Asset                                                                       | Result | Cache behavior / size                                    |
| --------------------------------------------------------------------------- | ------ | -------------------------------------------------------- |
| `https://mikechaves.github.io/dieai-flash/`                                 | `200`  | `cache-control: max-age=600`; `content-length: 29693`.   |
| `https://mikechaves.github.io/dieai-flash/index.html`                       | `200`  | `cache-control: max-age=600`; `content-length: 29693`.   |
| `https://mikechaves.github.io/dieai-flash/assets/DieAI.swf`                 | `200`  | `cache-control: max-age=600`; `content-length: 3223681`. |
| `https://mikechaves.github.io/dieai-flash/assets/images/main-image.png`     | `200`  | `cache-control: max-age=600`; `content-length: 2186182`. |
| `https://mikechaves.github.io/dieai-flash/assets/images/social-preview.png` | `200`  | `cache-control: max-age=600`; `content-length: 1093217`. |
| `https://mikechaves.github.io/dieai-flash/assets/images/start-screen.png`   | `200`  | `cache-control: max-age=600`; `content-length: 34014`.   |

Local static payload if the SWF and all committed wrapper images were cached:

| Scope                         | Bytes       |
| ----------------------------- | ----------- |
| `assets/DieAI.swf`            | `3,223,681` |
| `assets/images/*.png`         | `3,498,110` |
| Combined SWF plus image cache | `6,721,791` |

The Ruffle runtime is not included in this total because the live wrapper loads it externally from a
pinned package. That package already uses versioned asset names and long cache headers.

## Why Not Add It Now

- The wrapper has no explicit offline-play requirement.
- The live page, SWF, and images already have short HTTP cache headers through GitHub Pages.
- Ruffle runtime files are already versioned and long-cached by the CDN.
- A service worker would need careful version invalidation whenever `index.html`, `assets/DieAI.swf`,
  or image assets change.
- Caching `index.html` incorrectly could hide new preservation notes, metadata, or wrapper fixes.
- A service worker does not help direct `file://` launches, which still need the existing local-server
  guard.

## Future Cache Scope

If service-worker caching is promoted later, keep it narrow:

- Use a versioned cache name derived from the preservation artifact version or asset manifest.
- Pre-cache only:
  - `assets/DieAI.swf`;
  - `assets/images/main-image.png`;
  - `assets/images/start-screen.png`;
  - `assets/images/intro-good.png`;
  - `assets/images/intro-hacked.png`;
  - `assets/images/level-one.png`;
  - `assets/images/game-over.png`;
  - `assets/images/social-preview.png`.
- Treat `index.html` as network-first so wrapper fixes and metadata updates are not trapped behind a
  stale service worker.
- Do not service-worker-cache the external Ruffle CDN runtime unless Ruffle is vendored locally first.
- Delete old named caches during `activate`.
- Keep the custom `file://` fallback unchanged.

## Promotion Triggers

Reopen implementation only if one of these becomes true:

- The live demo needs resilient repeat-load behavior during public review or portfolio traffic.
- GitHub Pages cache behavior becomes insufficient for the SWF or images.
- The project needs a self-contained release mode where the browser wrapper intentionally works
  after the first network-backed load.
- Ruffle is vendored locally and the repo needs a matching cache policy for all runtime bytes.

## Validation If Implemented

Before closing any future service-worker implementation:

1. Run `node scripts/smoke-wrapper.mjs`.
2. Verify first-load behavior from an empty browser storage profile.
3. Verify repeat-load behavior after refresh.
4. Verify an updated `index.html` is not hidden by stale service-worker state.
5. Verify `assets/DieAI.swf` and all cached image assets return expected content.
6. Verify unregistering or updating the service worker recovers cleanly.
