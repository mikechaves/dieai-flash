# SWF Provenance And Rebuild Notes

> Source-of-truth notes for the preserved DieAI Flash build.

_Current as of: 2026-05-24_

---

## Artifact Summary

| Artifact                              | Role                                               | Notes                                                                                           |
| ------------------------------------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `DieAI.fla`                           | Original Adobe Animate / Flash authoring file      | ZIP-backed FLA containing XFL metadata, library symbols, embedded sounds, and publish settings. |
| `assets/DieAI.swf`                    | Playable Flash build used by the Ruffle wrapper    | Compressed SWF v37, 3,223,681 bytes, loaded by `index.html`.                                    |
| `assets/DieAI.html`                   | Legacy Flash embed output                          | Original plugin-era HTML wrapper for a colocated `DieAI.swf`.                                   |
| `lib/shoot/*.as`                      | ActionScript 3 game source                         | Document controller, game controller, particle base class, and robot enemy class.               |
| `com/greensock/`                      | Bundled ActionScript GreenSock dependency          | Required by `DieAIDoc` for intro animation and by any timeline/source references.               |
| `assets/images/*.png`                 | Modern wrapper screenshots and promotional artwork | Used for the web revival page; not required to rebuild the SWF.                                 |
| `docs/Chaves_rhetoricalAnalysis.docx` | Supporting historical project document             | Not part of the SWF build path.                                                                 |

## Current SWF

The tracked playable build is `assets/DieAI.swf`.

Observed metadata:

- File type: compressed Macromedia Flash data.
- SWF version: `37`.
- Size: `3,223,681` bytes.
- SHA-256: `1cb333d6a97c41752e2a76e617921ae5509b5ae6cd33f71bcc33f673e0992f9e`.

`DieAI.fla` contains a publish-history entry with `publishSize="3223681"` and
`publishTime="1540935999"` (`2018-10-30T21:46:39Z`), which matches the byte size of the
tracked SWF.

## Authoring File

`DieAI.fla` is a ZIP-backed Adobe Animate document. The archive reports a central-directory
length warning under `unzip`, but the XFL contents are still readable with Info-ZIP. Treat this
as a preservation risk: verify the file opens in Adobe Animate before relying on automated
extraction alone.

Key `DOMDocument.xml` metadata:

- Creator: Adobe Animate.
- Platform: Windows.
- Saved by: Animate Windows `24.0` build `14`.
- XFL version: `23.0`.
- Stage: `1000 x 600`.
- Frame rate: `30`.
- Library folders include `_buttons`, `_fonts`, `_sounds`, `StartScreenFolder`,
  `IntroScreenFolder`, `LevelOneFolder`, `PlayerFolder`, `Robots`, `GameOverFolder`,
  `HealthBarFolder`, and `CorpLogoFolder`.

The embedded sound and bitmap library items retain original Windows source paths such as
`C:/Users/mikej/Downloads/...`; the actual media data is embedded in the FLA archive, so those
source paths are provenance context rather than required runtime paths.

## Publish Profile

`DieAI.fla/PublishSettings.xml` defines the relevant build settings:

| Setting              | Value                                       |
| -------------------- | ------------------------------------------- |
| SWF output name      | `DieAI.swf`                                 |
| HTML output name     | `DieAI.html`                                |
| Width / height       | `1000 x 600`                                |
| Flash version        | `37`                                        |
| External player      | `FlashPlayer26.0`                           |
| ActionScript version | `3`                                         |
| Document class       | `lib.shoot.DieAIDoc`                        |
| AS3 package paths    | `.`                                         |
| Compress movie       | `1`                                         |
| Use network          | `0`                                         |
| HTML template path   | Adobe Animate CC 2018 default HTML template |

The modern web wrapper does not use the legacy generated HTML directly. It loads
`assets/DieAI.swf` through Ruffle.

## ActionScript Entry Points

The FLA document class is `lib.shoot.DieAIDoc`.

Source entry points:

- `lib/shoot/DieAIDoc.as`
  - Sets `stage.scaleMode = StageScaleMode.SHOW_ALL`.
  - Sets `stage.align = StageAlign.TOP_LEFT`.
  - Creates `StartScreen`, then `IntroScreen`, then `DieAIGame`.
  - Imports GreenSock TweenLite/easing for intro animation.
- `lib/shoot/DieAIGame.as`
  - Main gameplay controller.
  - Assumes `1000 x 600` stage constants.
  - Builds `LevelOne`, player, exit collider, robot/laser layers, score HUD, and timer HUD.
  - Handles keyboard input, shooting, robot spawning, win/loss state, and cleanup.
- `lib/shoot/Particle.as`
  - Base movement and purge-event class for lasers/robots.
- `lib/shoot/Robot.as`
  - Enemy class extending `Particle`.
  - Expects a timeline `healthBar` reference.

The ActionScript source depends on FLA library symbols exported for ActionScript, including:

| Linkage class | Library role              | Base class           |
| ------------- | ------------------------- | -------------------- |
| `StartScreen` | Start menu timeline       | FLA symbol default   |
| `IntroScreen` | Intro story timeline      | FLA symbol default   |
| `LevelOne`    | Main gameplay background  | FLA symbol default   |
| `Player`      | Player avatar             | FLA symbol default   |
| `MainLaser`   | Laser projectile          | `lib.shoot.Particle` |
| `Robot1`      | Left/right robot variant  | `lib.shoot.Robot`    |
| `Robot2`      | Left/right robot variant  | `lib.shoot.Robot`    |
| `GameOver`    | Loss overlay              | FLA symbol default   |
| `WinGame`     | Win overlay               | FLA symbol default   |
| `DieAIfont`   | Embedded HUD/display font | `flash.text.Font`    |

## Expected Rebuild Path

Use this only when intentionally regenerating `assets/DieAI.swf`.

1. Open `DieAI.fla` in Adobe Animate on a machine that can load legacy Flash/Animate documents.
2. Confirm the publish settings still show:
   - ActionScript 3.
   - Flash Player 26 / SWF version 37.
   - Document class `lib.shoot.DieAIDoc`.
   - Stage size `1000 x 600`.
   - AS3 source path `.` so `lib/shoot/*.as` and `com/greensock/` resolve from the repo root.
3. Publish the SWF and generated HTML.
4. Copy or configure the SWF output to replace `assets/DieAI.swf`.
5. Keep `assets/DieAI.html` only as legacy embed evidence unless the generated HTML materially
   changes and needs to be preserved.
6. Run the [Browser Smoke Checklist](../backlog/BROWSER_SMOKE_CHECKLIST.md):
   - Live and local HTTP targets load the game.
   - Direct `file://` launch shows the local-server guard.
   - SWF, Ruffle, and image assets return expected HTTP statuses.
   - Desktop/mobile layouts have no horizontal overflow.
   - Console output has no wrapper errors or warnings.

## Known Gaps

- The repo does not currently include an automated command-line SWF rebuild.
- The exact Adobe Animate version required to round-trip the FLA without changes is not proven.
  The FLA metadata says it was saved by Animate Windows `24.0` build `14`, while the publish
  template path references Adobe Animate CC 2018.
- `DieAI.fla` emits a ZIP central-directory length warning in `unzip`; Adobe Animate should be
  treated as the authoritative opener.
- The FLA publish settings output `DieAI.swf` / `DieAI.html` by default, but the web revival
  expects the playable build at `assets/DieAI.swf`.
- Rebuilding may produce a different SWF hash even when behavior is unchanged because Animate can
  rewrite timeline/library metadata.
- Third-party licensing for bundled GreenSock ActionScript source is tracked separately in the
  active backlog.

## Verification Commands

These commands verify the currently tracked artifact, not a full rebuild:

```bash
file DieAI.fla assets/DieAI.swf assets/DieAI.html lib/shoot/*.as
shasum -a 256 DieAI.fla assets/DieAI.swf assets/DieAI.html lib/shoot/*.as
unzip -p DieAI.fla PublishSettings.xml | rg "DocumentClass|Version>|ExternalPlayer|ActionScriptVersion|AS3PackagePaths"
```
