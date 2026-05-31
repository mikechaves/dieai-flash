# Reduced Motion Posture

> Reduced-motion decision record for the preserved DieAI web wrapper.

_Current as of: 2026-05-31_

---

## Scope

This audit covers motion owned by the modern `index.html` wrapper. It does not change the preserved
`assets/DieAI.swf`, original ActionScript, Flash timeline animation, or Ruffle's internal rendering.

The wrapper's role is to:

- keep page navigation and fallback UI predictable;
- avoid adding decorative motion around the game;
- respect `prefers-reduced-motion` for wrapper-owned behavior;
- leave the original SWF behavior intact as a preserved artifact.

## Decision

Keep the current reduced-motion posture: disable smooth page scrolling for users who request reduced
motion, and avoid adding wrapper-owned animations unless they include explicit reduced-motion
coverage.

Do not pause, suppress, or reinterpret the original SWF animation from the wrapper. The Flash game,
story screens, GreenSock timeline work, and gameplay remain part of the preserved artifact. Users
who cannot or do not want to run the SWF still have the screenshot fallback and
[Story And Screens Transcript](../accessibility/STORY_SCREENS_TRANSCRIPT.md).

## Motion Inventory

| Surface                    | Current behavior                                                                                              | Reduced-motion posture                                                                                           |
| -------------------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Anchor navigation          | `html { scroll-behavior: smooth; }` creates smooth page scrolling for `Start game`, nav links, and fallbacks. | `@media (prefers-reduced-motion: reduce)` switches `html` to `scroll-behavior: auto`.                            |
| Wrapper hover/focus states | Buttons, links, and the Ruffle frame change color, border, shadow, or outline instantly.                      | No CSS `transition` or `animation` is applied, so there is no extra motion to suppress.                          |
| Background treatment       | Hero image, grid overlay, screenshots, and fallback imagery are static CSS backgrounds or images.             | No parallax, autoplaying video, GIF, canvas animation, or CSS keyframe loop is present in the wrapper.           |
| JavaScript focus helpers   | `requestAnimationFrame` is used to defer focus/status sync after player load or click.                        | This is state synchronization, not a visual animation loop.                                                      |
| Ruffle / SWF content       | The preserved SWF may animate internally through Flash timelines and ActionScript.                            | Wrapper-level reduced-motion settings do not alter the original game; changing that belongs in a remaster track. |

## Current Coverage

`index.html` includes:

```css
@media (prefers-reduced-motion: reduce) {
  html {
    scroll-behavior: auto;
  }
}
```

The static smoke script now treats the media query and `scroll-behavior: auto` fallback as wrapper
invariants. The browser smoke checklist also includes manual reduced-motion checks for future
wrapper changes.

## Future Guidance

If future wrapper work adds animation, transition timing, scroll-linked effects, video, canvas,
remaster UI, or another motion surface outside the preserved SWF, require all of the following
before shipping it:

1. A `prefers-reduced-motion: reduce` branch that disables or substantially reduces the effect.
2. A browser check with reduced motion emulated.
3. A static smoke or checklist update if the behavior is part of the public wrapper contract.
4. Clear copy that does not imply the preserved SWF itself can honor page-level reduced-motion
   preferences.

## Validation

Validation for this audit:

- Source search for wrapper motion:

  ```bash
  rg -n "prefers-reduced-motion|animation|transition|scroll-behavior|requestAnimationFrame|autoplay|video|canvas" index.html docs scripts
  ```

- Static wrapper regression check:

  ```bash
  node scripts/smoke-wrapper.mjs
  ```

- Manual browser check:
  1. Open the local or live wrapper.
  2. Emulate `prefers-reduced-motion: reduce` in browser DevTools.
  3. Use `Start game` and nav/fallback anchor links.
  4. Confirm page jumps without smooth scrolling and wrapper controls remain readable.
