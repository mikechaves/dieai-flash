# Touch Control Feasibility

> Touch-input decision record for the preserved DieAI Ruffle build.

_Current as of: 2026-05-31_

---

## Scope

This audit covers whether mobile or touch controls can be supported in the current static wrapper
without changing the preserved `assets/DieAI.swf` or the original ActionScript source.

The decision applies to the current wrapper path:

- `index.html` loads `assets/DieAI.swf` through the pinned `@ruffle-rs/ruffle@0.2.0` runtime.
- Gameplay input remains owned by the SWF after focus enters the Ruffle player.
- The wrapper does not currently add any on-screen controls or translate touch input into Flash
  input.

## Decision

Do not add touch controls to the preservation wrapper right now.

The preserved game can likely receive tap-to-click behavior only where the original SWF already
listens for mouse clicks, such as menu progression and the gameplay click-to-shoot plane. Full touch
movement is not preservation-safe in the current wrapper because the original game exposes no public
input API and stores movement state inside the SWF.

Keep touch-control implementation deferred unless it becomes an explicit remaster or experimental
wrapper-overlay track with its own validation plan.

## Source Findings

| Area                      | Finding                                                                                                                                        | Impact                                                                                                       |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| Menu progression          | `lib/shoot/DieAIDoc.as` starts the intro and gameplay through `MouseEvent.CLICK` listeners on Flash buttons.                                   | A browser tap may work where Ruffle/browser input maps touch to mouse click, but this is not a touch system. |
| Gameplay shooting         | `lib/shoot/DieAIGame.as` registers `MouseEvent.CLICK` on a transparent `touchLayer` and shoots toward `mouseX` / `mouseY`.                     | Tap-to-shoot may be feasible if the click reaches Ruffle, but it only covers firing.                         |
| Gameplay movement         | `DieAIGame` sets movement flags from `KeyboardEvent.KEY_DOWN` / `KEY_UP`; source handling is limited to `Keyboard.A`, `Keyboard.D`, and space. | Touch cannot move the player without translating touch into keyboard state or changing the SWF.              |
| Flash touch APIs          | The source contains no `TouchEvent`, `GestureEvent`, `Multitouch`, or touch input-mode handling.                                               | The SWF does not provide native Flash touch semantics for Ruffle to preserve.                                |
| Page-to-SWF communication | The source contains no `ExternalInterface` or `fscommand` callback for gameplay input.                                                         | The wrapper has no supported ActionScript bridge for setting movement or firing state.                       |

The variable name `touchLayer` is historical source naming for a transparent mouse/click target. It
does not represent Flash touch-event support.

## Ruffle And Browser Constraints

Ruffle's public `PlayerElement` API is designed around loading, playback, fullscreen, volume, trace,
download, and display-message controls. It does not expose a supported method for injecting trusted
keyboard, pointer, or touch state into the running SWF.

Flash's own touch and gesture APIs require ActionScript listeners such as `TouchEvent`,
`GestureEvent`, and `Multitouch` mode configuration. The preserved DieAI source does not use those
APIs, so Ruffle cannot preserve touch behavior that the original SWF never defined.

Because browser touch-to-mouse compatibility can vary, do not claim mobile touch playability until it
has been checked on a real touch browser against the loaded Ruffle player.

References:

- [Ruffle `PlayerElement` API](https://ruffle.rs/js-docs/master/interfaces/Player.PlayerElement.html)
- [Ruffle ActionScript compatibility](https://ruffle.rs/compatibility)
- [Flash `GestureEvent` / touch API reference](https://docs.ruffle.rs/en_US/FlashPlatform/reference/actionscript/3/flash/events/GestureEvent.html)

## Preservation-Safe Path

The wrapper may continue to:

- focus the Ruffle player for keyboard control;
- document desktop keyboard controls;
- describe the fallback screenshots and transcript for users who cannot operate the SWF;
- test whether menu taps and click-to-shoot work as incidental mouse-click behavior.

The wrapper should not add touch controls that imply full mobile playability unless movement,
shooting, focus, viewport scaling, and game-over recovery have all been verified in a real touch
environment.

## Deferred Implementation Shape

If touch support is promoted later, treat it as a separate implementation track:

1. Define whether the goal is preservation-adjacent wrapper assistance or a true remaster feature.
2. Test real-device tap behavior for the start menu, intro button, gameplay shooting, and focus.
3. Prototype an overlay only outside the preserved SWF and document that it is modern assistive
   control translation.
4. Avoid synthetic keyboard events unless Ruffle explicitly documents support for that route.
5. Keep the original SWF and ActionScript source unchanged unless the project explicitly leaves the
   preservation track.

## Validation

Validation for this audit:

- Source search for touch and bridge APIs:

  ```bash
  rg -n "TouchEvent|GestureEvent|Multitouch|ExternalInterface|fscommand" lib/shoot index.html
  ```

- Source search for active input handling:

  ```bash
  rg -n "KeyboardEvent|Keyboard\\.|MouseEvent|touchLayer|mouseX|mouseY" lib/shoot
  ```

- Static wrapper regression check after documentation or wrapper updates:

  ```bash
  node scripts/smoke-wrapper.mjs
  ```
