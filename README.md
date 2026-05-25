# DieAI

DieAI is a Ruffle-powered web revival of my 2018 Flash game. The repo keeps the
original ActionScript source, the exported SWF, project imagery, and a static web
wrapper together so the game remains playable in modern browsers without Flash
Player.

[Play the live demo](https://mikechaves.github.io/dieai-flash/)

## How to play

- `WASD` or arrow keys: move
- `Space`: attack / interact
- `Esc`: pause / restart

If keyboard input does not respond, click once inside the game player to focus
the Ruffle canvas.

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
├── DieAI.fla               # original Flash authoring file
├── index.html              # modern Ruffle web wrapper
├── LICENSE
└── README.md
```

## Notes

- The live page is intentionally static: no bundler, framework, or build step.
- Ruffle is loaded from a pinned public `@ruffle-rs/ruffle` package; see
  `docs/preservation/RUFFLE_RUNTIME_DECISION.md` for the runtime decision.
- The original source files are kept in the repo for preservation and review,
  while `assets/DieAI.swf` is the playable build used by the web wrapper.
- Current and deferred project work lives in `docs/backlog/`.

## Credits

| Contribution                                     | Author / Project                                     |
| ------------------------------------------------ | ---------------------------------------------------- |
| Game design, art, and original ActionScript code | Michael Chaves                                       |
| Flash runtime emulation                          | [Ruffle](https://ruffle.rs/)                         |
| Preservation reference and inspiration           | [Flashpoint Archive](https://flashpointarchive.org/) |

## License

Released under the [MIT License](LICENSE).
