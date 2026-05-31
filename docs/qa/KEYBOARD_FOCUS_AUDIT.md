# Keyboard Focus Audit

> Ruffle keyboard-focus behavior for the preserved DieAI web wrapper.

_Current as of: 2026-05-31_

---

## Scope

This audit covers the modern wrapper around the preserved `assets/DieAI.swf`. It does not change
the SWF, ActionScript input handling, or Ruffle's internal keyboard event model.

Test target:

- Local HTTP wrapper: <http://127.0.0.1:8000/?focus-audit=20260531>
- Runtime: pinned `@ruffle-rs/ruffle@0.2.0`
- Browser surface: Codex in-app browser automation

## Findings

| Check                         | Result | Evidence                                                                                         |
| ----------------------------- | ------ | ------------------------------------------------------------------------------------------------ |
| Player reaches ready state    | PASS   | The status line reported `Game loaded` and the DOM exposed the loaded `RUFFLE-PLAYER` element.   |
| Click-to-focus behavior       | PASS   | After clicking inside the player, `document.activeElement` became the loaded `RUFFLE-PLAYER`.    |
| Player focus containment      | PASS   | The `#ruffle` frame matched `:focus-within` while the Ruffle element had focus.                  |
| Start link focus before patch | GAP    | The `Start game` link scrolled to `#ruffle`, but focus stayed outside the loaded player.         |
| Keyboard tab reachability     | PATCH  | The wrapper now sets `tabindex="0"` on the loaded Ruffle element so keyboard users can reach it. |

## Wrapper Decision

Keep the existing click-to-focus guidance because Ruffle correctly focuses the loaded player after a
pointer click. Improve the wrapper without modifying the preserved SWF by:

- adding `tabindex="0"` to the loaded Ruffle element;
- preserving the player's `aria-label` and adding `aria-describedby="player-status"`;
- adding a visible `#ruffle:focus-within` frame state and player `:focus-visible` outline;
- making the `Start game` control request player focus after the runtime is ready;
- updating the status line to distinguish loaded and focused states.

The wrapper does not intercept `A`, `D`, or `Space`; those inputs remain owned by the original Flash
runtime through Ruffle. The runtime-supported key set is documented separately in
[Keyboard Runtime Input Audit](./KEYBOARD_RUNTIME_INPUT_AUDIT.md).

## Validation

Run the static smoke script after focus-related wrapper changes:

```bash
node scripts/smoke-wrapper.mjs
```

Manual browser checks:

- Confirm the page title is `DieAI - Flash Revival`.
- Confirm the status reaches `Game loaded`.
- Click inside the player and confirm the status changes to `Player focused`.
- Confirm the player frame shows the focused border state.
- Confirm the browser console has no wrapper errors or warnings.

## Remaining Limits

Ruffle and the original SWF still own gameplay input after focus enters the player. The wrapper can
make focus easier to reach and see, but it cannot expose individual in-SWF controls to the page DOM
without a separate remaster or a different accessibility layer.
