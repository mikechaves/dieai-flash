# Gamepad Mapping Test Plan

> Physical-controller validation plan for a future Ruffle `gamepadButtonMapping` prototype.

_Current as of: 2026-05-31_

---

## Scope

This plan defines the physical-controller browser pass required before DieAI can ship any public
gamepad support claim.

It applies only to the preserved Ruffle wrapper path. It does not authorize a committed controller UI,
public gamepad copy, remapping settings, analog-stick support, or changes to `assets/DieAI.swf`.

## Decision Gate

Do not publish gamepad support until a real controller pass proves that Ruffle can translate physical
button input into the compiled SWF's runtime-confirmed keyboard controls:

- `A` / key code `65`: move left;
- `D` / key code `68`: move right;
- `Space` / key code `32`: fire.

Synthetic keyboard events, browser `Gamepad` API polling alone, and Playwright keyboard tests are
not sufficient for this gate. The test must use a physical controller in a real browser.

## Prototype Configuration

Use a local-only wrapper experiment equivalent to:

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

If a controller does not expose D-pad buttons through Ruffle's mapping layer, record that result
instead of falling back to analog-stick claims. Analog movement is not part of this preservation
test.

## Required Coverage

Minimum coverage before publishing any support:

| Area       | Requirement                                                                 |
| ---------- | --------------------------------------------------------------------------- |
| Browser    | One Chromium-family browser on desktop.                                     |
| Controller | One physical controller with a D-pad and at least one face button.          |
| Target     | Local HTTP wrapper, not `file://`.                                          |
| Runtime    | Current pinned `@ruffle-rs/ruffle@0.2.0` runtime unless deliberately changed. |
| Baseline   | Keyboard `A`, `D`, and `Space` still work before and after controller tests. |

Preferred expanded coverage:

| Area       | Preferred Coverage                                                             |
| ---------- | ------------------------------------------------------------------------------ |
| Browsers   | Chromium plus Firefox or Safari.                                               |
| Controllers | One Xbox-style controller and one PlayStation-style or generic HID controller. |
| States     | Fresh load, after intro skip, after game over, and after page refresh.          |

## Preflight

1. Start from clean `main`.
2. Run the static wrapper check:

   ```bash
   node scripts/smoke-wrapper.mjs
   ```

3. Start a local HTTP server:

   ```bash
   python3 -m http.server 8000
   ```

4. Load `http://127.0.0.1:8000/`.
5. Confirm the page loads the game through Ruffle and the keyboard controls still match
   [Keyboard Runtime Input Audit](./KEYBOARD_RUNTIME_INPUT_AUDIT.md).
6. Apply the local-only `gamepadButtonMapping` prototype.
7. Reload the local page and connect the controller.

## Manual Test Cases

| ID  | Scenario                 | Steps                                                                 | Expected Result                                                                   |
| --- | ------------------------ | --------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| G1  | Controller visibility    | Connect the controller and press a face button after the page loads.  | Browser/Ruffle accepts the controller gesture without console errors.             |
| G2  | Player focus             | Click inside the player, then press the mapped D-pad and face button. | The Ruffle player remains the active gameplay target.                             |
| G3  | D-pad left               | Hold `dpad-left` during gameplay.                                     | Player moves left, matching the keyboard `A` behavior.                            |
| G4  | D-pad left release       | Release `dpad-left`.                                                  | Player stops moving left without stuck input.                                     |
| G5  | D-pad right              | Hold `dpad-right` during gameplay.                                    | Player moves right, matching the keyboard `D` behavior.                           |
| G6  | D-pad right release      | Release `dpad-right`.                                                 | Player stops moving right without stuck input.                                    |
| G7  | Attack button            | Press and hold the mapped `south` button during gameplay.             | Laser firing appears and stops cleanly after release.                             |
| G8  | Menu transition          | Use mouse/keyboard to start the game and skip the intro, then retest. | Mapped controller inputs still work after menu and intro transitions.             |
| G9  | Game-over recovery       | Reach or force a game-over state, restart if available, then retest.  | Mapped inputs do not remain stuck across the state change.                        |
| G10 | Refresh recovery         | Refresh the page, focus the player, then retest all mapped buttons.   | Controller mapping still works after reload and focus recovery.                   |
| G11 | Keyboard regression      | Retest keyboard `A`, `D`, and `Space`.                                | Keyboard controls still work exactly as documented.                               |
| G12 | Public-copy boundary     | Inspect README, wrapper controls, and smoke checklist.                | No public gamepad support copy is added until all required cases pass.            |

## Evidence To Record

For each browser/controller combination, record:

- date;
- operating system;
- browser and version;
- controller model and connection type;
- Ruffle runtime version;
- local URL;
- pass/fail result for each test case;
- console errors or warnings;
- screenshots or short video clips for movement and firing;
- whether keyboard controls still pass after controller testing.

Use this table shape:

| Browser | Controller | G1 | G2 | G3 | G4 | G5 | G6 | G7 | G8 | G9 | G10 | G11 | G12 | Notes |
| ------- | ---------- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --- | --- | --- | ----- |
|         |            |    |    |    |    |    |    |    |    |    |     |     |     |       |

## Pass Criteria

Gamepad support may move from future backlog into implementation only when:

1. all required coverage passes with a physical controller;
2. D-pad movement starts and stops reliably;
3. the mapped attack button fires reliably;
4. menu, intro, game-over, refresh, and focus recovery do not leave stuck inputs;
5. keyboard controls remain unchanged;
6. the static wrapper smoke script still passes;
7. public copy updates are limited to the proven mapping.

## Failure Handling

If any required case fails:

- keep gamepad support out of public copy;
- keep the wrapper's shipped `player.load` configuration unchanged;
- record the failure in this plan or a follow-up QA note;
- leave remapping UI, analog-stick support, and broader controller work in the remaster backlog.
