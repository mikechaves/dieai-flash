# DieAI

DieAI is a Ruffle-powered web revival of my 2018 Flash game. The repo keeps the
original ActionScript source, the exported SWF, project imagery, and a static web
wrapper together so the game remains playable in modern browsers without Flash
Player.

[Play the live demo](https://mikechaves.github.io/dieai-flash/)

## How to play

- `A`: move left
- `D`: move right
- `Space`: fire

If keyboard input does not respond, click once inside the game player or tab to
the player after it loads to focus the Ruffle canvas.

For a non-playable text walkthrough of the preserved story, controls, level,
and game-over screens, read the
[story and screens transcript](docs/accessibility/STORY_SCREENS_TRANSCRIPT.md).

## Running locally

Clone the repository:

```bash
git clone https://github.com/mikechaves/dieai-flash.git
cd dieai-flash
```

Start a local static server:

```bash
python3 -m http.server 8000
```

Open <http://localhost:8000> in a browser.

Do not open `index.html` directly from your file manager. Ruffle cannot run the
SWF from a `file://` URL because browsers block required runtime features for
local files.

Run the static wrapper smoke check before browser QA after changing the wrapper
or bundled assets:

```bash
node scripts/smoke-wrapper.mjs
```

## Project structure

```text
dieai-flash/
├── assets/
│   ├── DieAI.swf           # exported Flash build loaded by Ruffle
│   ├── DieAI.html          # original Flash embed output
│   └── images/             # screenshots and promotional artwork
├── com/greensock/          # bundled GreenSock ActionScript dependency
├── docs/                   # supporting project documentation
├── lib/shoot/              # original ActionScript game source
├── scripts/                # static validation helpers
├── CHANGELOG.md            # preservation release notes
├── DieAI.fla               # original Flash authoring file
├── index.html              # modern Ruffle web wrapper
├── LICENSE
└── README.md
```

## Notes

- The live page is intentionally static: no bundler, framework, or build step.
- Ruffle is loaded from a pinned public `@ruffle-rs/ruffle` package; see
  `docs/preservation/RUFFLE_RUNTIME_DECISION.md` for the runtime decision.
- If Ruffle or the local browser protocol blocks playback, the wrapper falls back to screenshots,
  controls, and the next action instead of hiding the rest of the page.
- The original source files are kept in the repo for preservation and review,
  while `assets/DieAI.swf` is the playable build used by the web wrapper.
- Preservation checksums and artifact sizes are recorded in
  `docs/preservation/ARTIFACT_METADATA.md`.
- The archive distribution path for the FLA and release bundle is recorded in
  `docs/preservation/ARCHIVE_DISTRIBUTION_DECISION.md`.
- The non-publishing release bundle dry run is recorded in
  `docs/preservation/PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md`.
- The GitHub Release publish checklist is recorded in
  `docs/preservation/GITHUB_RELEASE_PUBLISH_RUNBOOK.md`.
- A portfolio-ready preservation case-study draft lives at
  `docs/portfolio/PRESERVATION_CASE_STUDY.md`.
- Social preview metadata and image dimensions are documented in
  `docs/qa/SOCIAL_PREVIEW_METADATA.md`.
- Ruffle keyboard focus behavior is documented in
  `docs/qa/KEYBOARD_FOCUS_AUDIT.md`.
- Runtime keyboard control evidence is documented in
  `docs/qa/KEYBOARD_RUNTIME_INPUT_AUDIT.md`.
- Touch-control feasibility is documented in
  `docs/qa/TOUCH_CONTROL_FEASIBILITY.md`.
- Gamepad-support feasibility is documented in
  `docs/qa/GAMEPAD_SUPPORT_FEASIBILITY.md`.
- Physical-controller gamepad mapping validation is documented in
  `docs/qa/GAMEPAD_MAPPING_TEST_PLAN.md`.
- Reduced-motion posture is documented in
  `docs/qa/REDUCED_MOTION_POSTURE.md`.
- Service-worker caching scope is documented in
  `docs/preservation/SERVICE_WORKER_CACHE_DECISION.md`.
- Original, exported, wrapper-only, and external runtime assets are scoped in
  `docs/preservation/ARCHIVE_ASSET_SCOPE.md`.
- A non-playable story and screens transcript is available at
  `docs/accessibility/STORY_SCREENS_TRANSCRIPT.md` for users who cannot run Flash
  or Ruffle.
- The original rhetorical analysis document is preserved as DOCX at
  `docs/Chaves_rhetoricalAnalysis.docx` and as accessible Markdown at
  `docs/historical/CHAVES_RHETORICAL_ANALYSIS.md`.
- Preservation release notes and the update convention live in `CHANGELOG.md`.
- Current and deferred project work lives in `docs/backlog/`.

## Credits

| Contribution                                     | Author / Project                                     |
| ------------------------------------------------ | ---------------------------------------------------- |
| Game design, art, and original ActionScript code | Michael Chaves                                       |
| Flash runtime emulation                          | [Ruffle](https://ruffle.rs/)                         |
| Preservation reference and inspiration           | [Flashpoint Archive](https://flashpointarchive.org/) |

## License

Released under the [MIT License](LICENSE) for Michael Chaves-authored portions of this archive unless
a file says otherwise.

The bundled `com/greensock/**` ActionScript source is third-party GreenSock code preserved for
source/rebuild compatibility. It retains its own copyright and terms notices and is not relicensed by
this repo. See [GreenSock License Review](docs/preservation/GREENSOCK_LICENSE_REVIEW.md).
