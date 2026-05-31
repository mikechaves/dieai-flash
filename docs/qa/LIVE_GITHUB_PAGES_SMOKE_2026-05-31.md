# Live GitHub Pages Smoke - 2026-05-31

> Current live-browser smoke evidence for the DieAI GitHub Pages wrapper.

_Current as of: 2026-05-31_

---

## Scope

This note records a live HTTPS smoke pass against the public GitHub Pages wrapper. It verifies that
the current public page loads the preserved SWF through Ruffle, focuses the player, accepts the
documented runtime controls, keeps the responsive wrapper usable, and preserves the direct
`file://` fallback behavior.

This is not a full game-completion pass. It does not replace the broader
[Browser Smoke Checklist](../backlog/BROWSER_SMOKE_CHECKLIST.md) or the local
[Keyboard Runtime Input Audit](./KEYBOARD_RUNTIME_INPUT_AUDIT.md).

## Result

Pass. No follow-up blocker was found.

The live page loaded over HTTPS, Ruffle initialized, `assets/DieAI.swf` returned `200`, keyboard
focus entered `RUFFLE-PLAYER`, `A` and `D` moved the player, `Space` fired, desktop and mobile
viewport checks had no horizontal overflow, and the direct `file://` path showed the custom local
server message without requesting Ruffle or the SWF.

## Environment

| Field          | Value |
| -------------- | ----- |
| Date           | `2026-05-31` |
| Target         | `https://mikechaves.github.io/dieai-flash/` |
| Browser        | Playwright Chromium `148.0.7778.96` |
| Evidence path  | `/tmp/dieai-live-smoke-2026-05-31/` |
| Wrapper script | `node scripts/smoke-wrapper.mjs` |

## Live HTTPS Checks

| Check | Result | Evidence |
| ----- | ------ | -------- |
| Page load | Pass | `https://mikechaves.github.io/dieai-flash/` returned `200` with `text/html; charset=utf-8`. |
| Title | Pass | Browser title was `DieAI - Flash Revival`. |
| Ruffle element | Pass | Player child was `RUFFLE-PLAYER` with `tabindex="0"`. |
| Focus path | Pass | After using `Start game` and clicking the player, `document.activeElement` was `RUFFLE-PLAYER`. |
| Focus status | Pass | Status changed to `Player focused. Use A, D, and space for the preserved Flash controls.` |
| Wrapper images | Pass | Committed wrapper images requested during load returned `200`; no missing images were reported. |
| Desktop overflow | Pass | At `1280 x 900`, `documentElement.scrollWidth` was `1280`. |
| Mobile overflow | Pass | At `390 x 844`, `documentElement.scrollWidth` was `390`. |
| Mobile player sizing | Pass | Mobile Ruffle frame measured about `336 x 201.59` CSS pixels and stayed within the viewport. |

## Network Checks

| Asset | Result |
| ----- | ------ |
| Live page | `200`, `cache-control: max-age=600` |
| `assets/DieAI.swf` | `200`, `content-type: application/x-shockwave-flash`, `cache-control: max-age=600` |
| `https://unpkg.com/@ruffle-rs/ruffle@0.2.0` | `301` to the pinned `ruffle.js` package file |
| `ruffle.js` | `200`, `content-type: text/javascript; charset=utf-8`, one-year cache header |
| `core.ruffle.a6584f4c154875f3f805.js` | `200`, one-year cache header |
| `ecc5e233d534bdc785c1.wasm` | `200`, `content-type: application/wasm`, one-year cache header |
| Wrapper images | `200` for the committed PNGs requested by the page |

No failed requests were observed.

## Runtime Control Checks

The gameplay probe started the SWF from the start screen, skipped the intro, clicked the player again
to preserve focus, and compared Ruffle screenshots before and after input.

| Input | Result | Evidence |
| ----- | ------ | -------- |
| `A` | Pass | Orange player-platform centroid moved left from `x=411.39` to `x=263.37`. |
| `D` | Pass | Orange player-platform centroid moved right from `x=263.37` to `x=458.41`. |
| `Space` | Pass | Screenshot diff found `974` changed cyan laser pixels while `Space` was held. |

All input checks reported `RUFFLE-PLAYER` as the active element and `#ruffle:focus-within` as true.

## Direct File Guard

The local `file:///Users/michaelchaves/GitHub/dieai-flash/index.html` path was loaded as a guard
check.

| Check | Result |
| ----- | ------ |
| Fallback heading | `Local server required` |
| Status text | `Direct file launches are blocked before Ruffle loads, so the SWF is not requested.` |
| `assets/DieAI.swf` requests | None |
| Ruffle script/runtime requests | None |
| Console output | No errors or warnings |

## Console Observations

The live HTTPS run produced expected Ruffle/browser messages:

- Ruffle WASM initialization log.
- Ruffle instance creation log for version `0.2.0`.
- `Loading SWF file assets/DieAI.swf` log.
- Chromium AudioContext autoplay warnings before user gesture.
- WebGL `ReadPixels` performance warnings during screenshot capture.

No uncaught JavaScript exceptions, page errors, failed network requests, or wrapper-owned console
errors were observed.

## Follow-Up

No new active follow-up is required from this smoke pass. If a later pass finds a live outage,
missing asset, Ruffle runtime failure, focus regression, or control regression, promote that issue to
[Active Backlog](../backlog/ACTIVE_BACKLOG.md) with reproduction steps and the failing target.
