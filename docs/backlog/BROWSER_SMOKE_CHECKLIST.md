# Browser Smoke Checklist

> Repeatable smoke checks for the DieAI Ruffle wrapper.

_Current as of: 2026-05-24_

---

## Purpose

Use this checklist after changes to `index.html`, `assets/DieAI.swf`, image assets, Ruffle
configuration, GitHub Pages settings, or browser-facing documentation.

The goal is not full gameplay QA. The goal is to confirm that the preserved Flash build is reachable,
the wrapper behaves predictably, and visitors get a clear path whether they open the live demo, run the
repo locally, or accidentally open `index.html` as a local file.

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
- [ ] Clicking inside the player focuses keyboard input.
- [ ] `WASD`, arrow keys, `Space`, and `Esc` are still documented next to the player.
- [ ] The direct `file://` path shows `Local server required` with the `python3 -m http.server 8000`
      instruction.
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

## Console Checks

- [ ] HTTP targets have no console errors or warnings from the wrapper.
- [ ] Ruffle info logs are acceptable.
- [ ] The direct `file://` path has no uncaught JavaScript exceptions.
- [ ] If Ruffle fails to download on HTTP targets, the wrapper shows `Ruffle failed to load` with the
      connection/refresh retry message.

## Responsive Checks

- [ ] Desktop viewport has no horizontal overflow.
- [ ] Mobile viewport has no horizontal overflow.
- [ ] Player, controls, screenshot gallery, and preservation section stack cleanly on mobile.
- [ ] Buttons remain readable and do not overlap neighboring content.
- [ ] Sticky navigation does not cover the player or screenshots when using anchor links.

## Suggested Automation Commands

These commands are optional helpers for local verification. Do not commit generated screenshots,
Playwright traces, or temporary output.

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
- Direct file launch shows the custom local-server instruction.
- SWF, Ruffle, and image assets are reachable where expected.
- Desktop and mobile layouts have no horizontal overflow.
- Console output contains no wrapper errors or warnings.

Record failures as active backlog items only when they need follow-up work. Otherwise keep this file as
the verification checklist, not a shadow backlog.
