# Browser Smoke Checklist

> Repeatable smoke checks for the DieAI Ruffle wrapper.

_Current as of: 2026-05-31_

---

## Purpose

Use this checklist after changes to `index.html`, `assets/DieAI.swf`, image assets, Ruffle
configuration, GitHub Pages settings, or browser-facing documentation.

The goal is not full gameplay QA. The goal is to confirm that the preserved Flash build is reachable,
the wrapper behaves predictably, and visitors get a clear path whether they open the live demo, run the
repo locally, or accidentally open `index.html` as a local file.

Run the static wrapper smoke script before the manual browser checks whenever the wrapper or bundled
assets change:

```bash
node scripts/smoke-wrapper.mjs
```

The script is intentionally dependency-free. It checks required local assets, local file references,
the pinned Ruffle and SWF constants, controls, focus affordances, fallback UI text,
social-preview metadata, and the `file://` guard that prevents Ruffle from loading before the
custom local-server message.

## Latest Recorded Pass

The latest live GitHub Pages pass is recorded in
[Live GitHub Pages Smoke - 2026-05-31](../qa/LIVE_GITHUB_PAGES_SMOKE_2026-05-31.md).

That pass verified HTTPS load, Ruffle initialization, `assets/DieAI.swf`, player focus,
runtime-confirmed `A`/`D`/`Space` controls, desktop/mobile overflow, network responses, console
observations, and the direct `file://` guard.

## Targets

| Target             | URL or Command                                                                       | Expected Outcome                                                                                      |
| ------------------ | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| Live GitHub Pages  | <https://mikechaves.github.io/dieai-flash/>                                          | Page loads, Ruffle initializes, and `assets/DieAI.swf` returns `200`.                                 |
| Local HTTP server  | `python3 -m http.server 8000`, then open <http://localhost:8000>                     | Page loads from HTTP, Ruffle initializes, and `assets/DieAI.swf` returns `200`.                       |
| Direct file launch | Open `index.html` directly from a file manager, or use the equivalent `file://` URL. | Page shows the custom local-server-required message and does not show Ruffle's orange protocol error. |

## Manual Browser Checks

Run these in a current desktop browser. Repeat layout checks at one desktop viewport and one mobile
viewport.

- [ ] Page title is `DieAI - Flash Revival`.
- [ ] Hero, primary actions, player frame, controls panel, screenshots, preservation section, and
      footer render without missing images.
- [ ] The Ruffle player area reaches the start screen on HTTP targets.
- [ ] `Start game` scrolls to the player and requests focus after the Ruffle player loads.
- [ ] Clicking inside the player focuses keyboard input and shows the player focus state.
- [ ] Tab navigation can reach the loaded Ruffle player on HTTP targets.
- [ ] `A`, `D`, and `Space` are still documented next to the player.
- [ ] The direct `file://` path shows `Local server required` with the `python3 -m http.server 8000`
      instruction.
- [ ] If Ruffle cannot initialize on an HTTP target, the player frame shows the non-playable
      screenshot/control fallback with retry and screenshots actions instead of a bare error.
- [ ] The direct `file://` path does not attempt to load `assets/DieAI.swf`.
- [ ] The direct `file://` path does not show Ruffle's default orange protocol error.

## Network Checks

Use browser DevTools or a browser automation request log.

- [ ] `index.html` returns `200` on HTTP targets.
- [ ] `assets/DieAI.swf` returns `200` on live and local HTTP targets.
- [ ] `https://unpkg.com/@ruffle-rs/ruffle@0.2.0` or its redirected runtime script returns `200`.
- [ ] The Ruffle WASM request returns `200`.
- [ ] Wrapper screenshots under `assets/images/` return `200`.
- [ ] No `assets/DieAI.swf` request is made on the direct `file://` path.

## Social Preview Checks

- [ ] Canonical URL is `https://mikechaves.github.io/dieai-flash/`.
- [ ] OpenGraph and Twitter/X tags use the same title, description, preview image, and image alt
      text documented in [Social Preview Metadata](../qa/SOCIAL_PREVIEW_METADATA.md).
- [ ] `assets/images/social-preview.png` is `1200x630`.
- [ ] The static wrapper smoke script passes its metadata invariants.

## Console Checks

- [ ] HTTP targets have no console errors or warnings from the wrapper.
- [ ] Ruffle info logs are acceptable.
- [ ] The direct `file://` path has no uncaught JavaScript exceptions.
- [ ] If Ruffle fails to download on HTTP targets, the wrapper shows the screenshot/control fallback
      with a retry action instead of a bare error.

## Keyboard Focus Checks

- [ ] The loaded Ruffle element has `tabindex="0"`.
- [ ] `document.activeElement` becomes the loaded Ruffle element after clicking inside the player.
- [ ] The player frame matches `:focus-within` while Ruffle has focus.
- [ ] The status line changes from the loaded instruction to the focused-controls instruction after
      focus enters the player.
- [ ] Focus changes are wrapper-only; the wrapper does not intercept gameplay keys.

## Runtime Keyboard Checks

- [ ] `A` moves the player left in the preserved SWF.
- [ ] `D` moves the player right in the preserved SWF.
- [ ] `Space` fires in the preserved SWF.
- [ ] Arrow keys, `W`, `S`, and `Esc` are not documented as supported controls unless a future
      runtime pass proves otherwise.

## Responsive Checks

- [ ] Desktop viewport has no horizontal overflow.
- [ ] Mobile viewport has no horizontal overflow.
- [ ] Player, controls, screenshot gallery, and preservation section stack cleanly on mobile.
- [ ] Buttons remain readable and do not overlap neighboring content.
- [ ] Sticky navigation does not cover the player or screenshots when using anchor links.

## Reduced Motion Checks

- [ ] With `prefers-reduced-motion: reduce` emulated, anchor navigation uses immediate scrolling
      instead of smooth scrolling.
- [ ] Wrapper-owned hover, focus, fallback, and responsive states do not introduce CSS animation or
      transition timing outside the preserved SWF.
- [ ] Ruffle/SWF animation remains preserved game behavior and is not altered by wrapper
      reduced-motion handling.

## Suggested Automation Commands

These commands are optional helpers for local verification. Do not commit generated screenshots,
Playwright traces, or temporary output.

```bash
node scripts/smoke-wrapper.mjs
```

```bash
python3 -m http.server 8000
```

```bash
curl -I http://localhost:8000/assets/DieAI.swf
curl -I https://mikechaves.github.io/dieai-flash/assets/DieAI.swf
curl -I https://unpkg.com/@ruffle-rs/ruffle@0.2.0
```

If using the Codex Playwright wrapper, verify both desktop and mobile viewports against
<http://localhost:8000>. The wrapper may block `file://` navigation; in that case, verify the
direct-file path manually in a regular browser.

## Pass Criteria

The smoke pass is complete when:

- Live and local HTTP targets load the game.
- Click and keyboard tab paths can focus the Ruffle player.
- Direct file launch shows the custom local-server instruction.
- SWF, Ruffle, and image assets are reachable where expected.
- Desktop and mobile layouts have no horizontal overflow.
- Console output contains no wrapper errors or warnings.

Record failures as active backlog items only when they need follow-up work. Otherwise keep this file as
the verification checklist, not a shadow backlog.
