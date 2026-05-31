# Gamepad Support Feasibility

> Gamepad-input decision record for the preserved DieAI Ruffle build.

_Current as of: 2026-05-31_

---

## Scope

This audit covers whether gamepad controls can be supported in the current static wrapper without
changing the preserved `assets/DieAI.swf` or the original ActionScript source.

The decision applies to the current wrapper path:

- `index.html` loads `assets/DieAI.swf` through the pinned `@ruffle-rs/ruffle@0.2.0` runtime.
- Gameplay input remains owned by the SWF after focus enters the Ruffle player.
- The wrapper does not currently add gamepad mappings, a controller-status UI, or a browser
  `Gamepad` API loop.

## Decision

Do not enable gamepad controls in the preservation wrapper right now.

Gamepad support is feasible as an experimental Ruffle button-to-keyboard mapping, not as native
gamepad support inside the original SWF. The pinned Ruffle runtime includes `gamepadButtonMapping`,
which can map named gamepad buttons to ActionScript key codes before the loaded SWF receives input.
That gives the project a plausible future path for D-pad and face-button controls without editing
the SWF.

Keep implementation deferred until a physical-controller browser pass confirms:

- the exact key codes the compiled SWF accepts;
- whether held and released mapped buttons behave like real `KeyboardEvent` input;
- whether the page must be focused before `gamepadconnected` and Ruffle input work;
- whether browser and controller differences affect the public control copy.

## Source And Runtime Findings

| Area                       | Finding                                                                                                                                       | Impact                                                                                                                                        |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Ruffle mapping surface     | Ruffle documents an experimental `gamepadButtonMapping` load option that maps gamepad button names to ActionScript key codes.                 | The wrapper could prototype gamepad buttons as keyboard input without changing the SWF.                                                       |
| Pinned runtime             | The published `@ruffle-rs/ruffle@0.2.0` `ruffle.js` bundle contains `gamepadButtonMapping` and named buttons such as `dpad-left`.             | The current pinned runtime appears to include the needed option; a version upgrade is not required for a prototype.                           |
| Native Flash gamepad APIs  | The DieAI source contains no `flash.ui.GameInput`, `GameInputDevice`, `GameInputControl`, or gamepad-specific ActionScript.                   | The original game does not request native Flash gamepad input; support must be wrapper/runtime translation.                                   |
| Browser-to-SWF bridge      | The source contains no `ExternalInterface` or `fscommand` gameplay callback for input.                                                        | A custom JavaScript `navigator.getGamepads()` loop has no safe public ActionScript hook for setting movement or firing state.                 |
| Gameplay movement          | `DieAIGame` uses `KeyboardEvent.KEY_DOWN` / `KEY_UP`; source-visible movement is `Keyboard.A` and `Keyboard.D`, with `Keyboard.SPACE` firing. | A prototype should test `DPadLeft -> A`, `DPadRight -> D`, and one face button or trigger mapped to `Space`; arrow and `Esc` support is open. |
| Analog sticks and axes     | Ruffle's public mapping option is button-name based; the documented enum covers face buttons, triggers, start/select, and D-pad directions.   | Analog-stick movement is not covered by this preservation-safe path.                                                                          |
| Current wrapper load state | `index.html` calls `player.load({ url: SWF_URL, backgroundColor: "#000000" })` without a gamepad mapping.                                     | The live wrapper has no gamepad-support behavior today.                                                                                       |

## Browser Constraints

The W3C Gamepad API exposes gamepad buttons and axes through browser-controlled state. It is a
low-level API, and browsers can withhold gamepad state until a gamepad user gesture occurs. A proper
test needs the loaded wrapper in a real browser, a physical controller, and a focused page or player.

Do not treat simulated keyboard events as sufficient validation. The purpose of this feasibility
track is to determine whether Ruffle's runtime mapping can carry real controller input into the
preserved SWF.

References:

- [Ruffle `gamepadButtonMapping` option](https://ruffle.rs/js-docs/master/interfaces/Config.BaseLoadOptions.html#gamepadbuttonmapping)
- [Ruffle `GamepadButton` enum](https://ruffle.rs/js-docs/master/enums/Config.GamepadButton.html)
- [W3C Gamepad API](https://www.w3.org/TR/gamepad/)

## Prototype Boundary

If gamepad support is promoted later, start with a local-only prototype equivalent to:

```js
await player.load({
  url: SWF_URL,
  backgroundColor: "#000000",
  gamepadButtonMapping: {
    "dpad-left": 65,
    "dpad-right": 68,
    south: 32,
  },
});
```

Those values match source-visible `A`, `D`, and `Space` key codes only. They are not a shipped
control contract until runtime testing proves the compiled SWF behaves the same way as the source.

Do not add public gamepad copy or a controller UI until the implementation can prove:

1. the controller connects and is visible to the focused page;
2. mapped left/right controls move the player and stop on release;
3. mapped attack controls fire at a usable cadence;
4. mapped controls still work after menu, intro, focus, and game-over transitions;
5. keyboard controls remain unchanged;
6. the browser smoke checklist and static wrapper smoke script pass.

## Deferred Implementation Shape

Keep future gamepad work narrow:

- Use Ruffle's `gamepadButtonMapping` first instead of a custom `navigator.getGamepads()` loop.
- Prefer D-pad and button mapping over analog-stick claims.
- Verify the compiled SWF's actual accepted key codes before updating `README.md`, `index.html`, or
  the browser smoke checklist.
- Leave broader controller options, remapping UI, haptics, analog movement, and settings screens in
  a remaster track.

## Validation

Validation for this audit:

- Source search for gamepad and bridge APIs:

  ```bash
  rg -n "Gamepad|gamepad|GameInput|ExternalInterface|fscommand" lib/shoot index.html
  ```

- Source search for active keyboard handling:

  ```bash
  rg -n "KeyboardEvent|Keyboard\\.|MouseEvent|touchLayer|mouseX|mouseY" lib/shoot
  ```

- Pinned runtime check for the Ruffle mapping option:

  ```bash
  curl -fsSL https://unpkg.com/@ruffle-rs/ruffle@0.2.0/ruffle.js | rg -o "gamepadButtonMapping|dpad-left|dpad-right|south" | sort | uniq -c
  ```

- Static wrapper regression check after documentation or wrapper updates:

  ```bash
  node scripts/smoke-wrapper.mjs
  ```
