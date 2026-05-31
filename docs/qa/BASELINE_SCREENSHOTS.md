# Baseline Screenshot QA

> Current baseline screenshot evidence for the DieAI Ruffle wrapper.

_Current as of: 2026-05-30_

---

## Purpose

Use this note as the lightweight record for wrapper screenshot baselines. The generated PNG files are
temporary QA artifacts and are intentionally not committed to the repo.

Regenerate these screenshots after changes to `index.html`, wrapper CSS, Ruffle configuration,
screenshots, or layout-sensitive documentation.

## Latest Run

| Field       | Value                                                                                                                                           |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Date        | 2026-05-30 21:29 PDT                                                                                                                            |
| Target      | `http://localhost:8000` served with `python3 -m http.server 8000`                                                                               |
| Desktop     | `/tmp/dieai-baseline-desktop-viewport-2026-05-30.png` (`1265x720`)                                                                              |
| Mobile      | `/tmp/dieai-baseline-mobile-viewport-2026-05-30.png` (`375x844`, captured from a `390x844` viewport override)                                   |
| Full-page   | `/tmp/dieai-baseline-desktop-2026-05-30.png` and `/tmp/dieai-baseline-mobile-2026-05-30.png` were also generated for local inspection only.     |
| Browser     | Codex in-app Browser                                                                                                                            |
| Interaction | Clicked inside the Ruffle player before capture so the SWF reached the visible DieAI start screen instead of the browser autoplay play overlay. |

## Checks

| Check               | Desktop | Mobile | Notes                                                                                     |
| ------------------- | ------- | ------ | ----------------------------------------------------------------------------------------- |
| Page title          | PASS    | PASS   | `DieAI - Flash Revival`                                                                   |
| Ruffle player       | PASS    | PASS   | Ruffle object present and player status reported ready.                                   |
| Start screen        | PASS    | PASS   | Screenshot shows the DieAI start screen inside the player frame after the player click.   |
| Console health      | PASS    | PASS   | No browser `error` or `warn` logs were captured for the wrapper.                          |
| Framework overlay   | PASS    | PASS   | No Next.js, Vite, Webpack, or generic error overlay text present.                         |
| Horizontal overflow | PASS    | PASS   | Desktop and mobile checks reported no horizontal overflow.                                |
| Primary interaction | PASS    | N/A    | Desktop `Start game` link resolved to one action and scrolled to the player at `#ruffle`. |
| Screenshot storage  | PASS    | PASS   | Generated files live under `/tmp` and should not be committed.                            |

## Regeneration Steps

1. Start the static server:

   ```bash
   python3 -m http.server 8000
   ```

2. Open <http://localhost:8000> in the Codex in-app Browser.
3. Wait until the player status reads `Game loaded`.
4. Click inside the player to dismiss the browser autoplay play overlay and show the DieAI start
   screen.
5. Capture a desktop viewport screenshot and save it as:

   ```text
   /tmp/dieai-baseline-desktop-viewport-YYYY-MM-DD.png
   ```

6. Set the browser viewport to `390x844`, reload the page, click inside the player, and save the
   mobile viewport screenshot as:

   ```text
   /tmp/dieai-baseline-mobile-viewport-YYYY-MM-DD.png
   ```

7. Confirm both captures have no horizontal overflow and no browser console `error` or `warn` logs.

## Notes

- The committed repo should keep this note and the wrapper code only. Do not commit generated
  screenshots unless the project explicitly changes to track visual baselines.
- Full-page screenshots are useful for local review, but viewport captures are the canonical
  lightweight baseline because sticky headers and long-page captures can add browser-specific noise.
