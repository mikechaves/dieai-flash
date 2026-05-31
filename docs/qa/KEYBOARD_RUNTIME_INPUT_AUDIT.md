# Keyboard Runtime Input Audit

> Browser/SWF runtime evidence for the preserved DieAI keyboard controls.

_Current as of: 2026-05-31_

---

## Scope

This audit verifies which documented keyboard controls actually affect the preserved
`assets/DieAI.swf` when the game runs through the current Ruffle wrapper.

It updates public control copy only. It does not change the SWF, ActionScript source, Ruffle runtime,
or gameplay behavior.

## Decision

Document the preserved runtime controls as:

- `A`: move left;
- `D`: move right;
- `Space`: fire.

Do not document `WASD`, arrow-key movement, `Esc` pause, or `Esc` restart for the preserved Ruffle
build. The browser/SWF runtime pass did not show movement or state changes for those keys, and the
visible ActionScript input handler only switches on `Keyboard.A`, `Keyboard.D`, and `Keyboard.SPACE`.

Mouse clicks are still documented as a focus path for the Ruffle player. They are not treated as a
public attack control unless a future manual pointer-shooting pass verifies that behavior across
browsers.

## Runtime Test

Test target:

- Local HTTP wrapper: `http://127.0.0.1:8765/?keyboard-runtime=...`
- Runtime: pinned `@ruffle-rs/ruffle@0.2.0`
- Browser: Playwright Chromium
- Screenshot evidence: `/tmp/dieai-keyboard-runtime-2026-05-31/`

Method:

1. Start a local static server.
2. Load the wrapper over HTTP.
3. Click the Ruffle player, click the start prompt, and click the intro skip control.
4. For each tested key, reload to a fresh gameplay state.
5. Confirm `document.activeElement` is `RUFFLE-PLAYER`.
6. Hold the tested key and compare the orange player platform centroid before and after input.
7. For `Space`, capture a screenshot while the key is held and check for laser-pixel differences.

## Results

| Input       | Result      | Evidence                                                                                  |
| ----------- | ----------- | ----------------------------------------------------------------------------------------- |
| `A`         | Supported   | Player platform centroid moved left from `x=412.94` to `x=322.42` over a held key press.  |
| `D`         | Supported   | Player platform centroid moved right from `x=412.94` to `x=502.14` over a held key press. |
| `Space`     | Supported   | Runtime screenshot showed a laser firing; attack-region diff was `1982` changed pixels.   |
| Arrow left  | Unsupported | Player platform centroid stayed at `x=412.94`; no movement observed.                      |
| Arrow right | Unsupported | Player platform centroid stayed at `x=412.94`; no movement observed.                      |
| `W`         | Unsupported | Player platform centroid stayed at `x=412.94`; no movement observed.                      |
| `S`         | Unsupported | Player platform centroid stayed at `x=412.94`; no movement observed.                      |
| Arrow up    | Unsupported | Player platform centroid stayed at `x=412.94`; no movement observed.                      |
| Arrow down  | Unsupported | Player platform centroid stayed at `x=412.94`; no movement observed.                      |
| `Esc`       | Unsupported | Player platform centroid stayed at `x=412.94`; no pause, restart, or overlay observed.    |
| Mouse click | Unverified  | Automated click-to-fire check did not show attack-region differences.                     |

All key tests reported `RUFFLE-PLAYER` as the active element before input.

## Source Cross-Check

`lib/shoot/DieAIGame.as` matches the runtime result:

```actionscript
case Keyboard.D:     moveRight = true; break;
case Keyboard.A:     moveLeft  = true; break;
case Keyboard.SPACE: spaceBar  = true; break;
```

No `Keyboard.LEFT`, `Keyboard.RIGHT`, `Keyboard.UP`, `Keyboard.DOWN`, `Keyboard.W`, `Keyboard.S`, or
`Keyboard.ESCAPE` handling exists in the preserved source.

## Wrapper Updates

The public wrapper, fallback controls, README, transcript, and browser smoke checklist now use the
runtime-confirmed `A`, `D`, and `Space` control set.

Focus guidance remains unchanged: click inside the player or tab to it after Ruffle loads if
keyboard input is not active.

## Validation

Runtime evidence command shape:

```bash
python3 -m http.server 8765 --bind 127.0.0.1
NODE_PATH=/tmp/dieai-pw/node_modules node <playwright-runtime-input-script>
```

Static wrapper regression check:

```bash
node scripts/smoke-wrapper.mjs
```
