# Ruffle Runtime Decision

> Decision record for how the DieAI web wrapper loads Ruffle.

_Current as of: 2026-05-31_

---

## Decision

Keep loading Ruffle from the pinned CDN URL:

```text
https://unpkg.com/@ruffle-rs/ruffle@0.2.0
```

Do not vendor Ruffle into this repo right now. The 2026-05-31 review confirmed the pinned package
is reachable, cacheable, and still small enough to load externally, while vendoring would add the
full runtime package footprint and a manual upgrade procedure without solving a current production
problem.

Revisit vendoring only if CDN reliability, privacy, availability, or archival requirements become
stronger than the current need to keep the repository small and easy to inspect.

## First Preservation Release Decision

Decision: the first GitHub preservation release does not need to be self-contained for Ruffle.

The release bundle may include the current wrapper that references the pinned external runtime, while
keeping Ruffle JavaScript, WASM, source maps, and license files outside the repository bundle. This
matches the current no-build GitHub Pages wrapper and the release inventory in
[Archive Release Inventory Reconciliation](./ARCHIVE_RELEASE_INVENTORY_RECONCILIATION.md).

Rationale:

- The preservation release is a curated repository artifact, not an offline runtime distribution.
- The bundle includes the original FLA, exported SWF, legacy generated HTML, source, wrapper, docs,
  and checksums needed to inspect the preserved game.
- The live wrapper continues to load and play through the pinned external runtime.
- Vendoring would add about `29,000,511` unpacked bytes plus maintenance and license-copying work
  without solving a current release blocker.
- The approval packet and release runbook both require rebuilding from final `main`, so vendoring can
  still be promoted before publishing if an explicit self-contained-runtime requirement appears.

Publish implication: do not vendor Ruffle before the first release unless the approval process adds a
new requirement that the uploaded zip must run without any external runtime fetch. If that requirement
appears, stop the publish path, promote the vendoring task from
[Future Backlog](../backlog/FUTURE_BACKLOG.md), vendor the exact runtime package and license files,
update `RUFFLE_SRC`, rerun browser smoke, and regenerate the release bundle.

## Current Runtime Path

`index.html` defines:

```js
const RUFFLE_SRC = "https://unpkg.com/@ruffle-rs/ruffle@0.2.0";
```

At runtime:

1. The wrapper blocks direct `file://` launches before loading Ruffle.
2. The wrapper injects the pinned Ruffle script.
3. Ruffle downloads its matching core JavaScript and WASM runtime from the same pinned package.
4. The wrapper loads `assets/DieAI.swf`.

The pinned URL redirects to:

```text
/@ruffle-rs/ruffle@0.2.0/ruffle.js
```

## Options Considered

| Option                                | Benefits                                                                 | Costs / Risks                                                                                              | Decision                                |
| ------------------------------------- | ------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| Pinned CDN package                    | Small repo, no build step, one explicit version, long CDN cache headers. | Depends on unpkg/npm availability and external runtime fetches.                                            | Use now.                                |
| Vendor full `@ruffle-rs/ruffle@0.2.0` | Self-contained GitHub Pages runtime; fewer external availability risks.  | Adds about 29 MB unpacked runtime assets and requires manual upgrade/copy discipline.                      | Defer.                                  |
| Vendor only selected runtime files    | Smaller than full package while reducing external runtime dependency.    | Easy to miss required core/WASM variants; source maps/licenses need explicit handling; upgrade path risky. | Defer unless full vendoring is too big. |
| Track latest CDN package              | Receives runtime fixes automatically.                                    | Can introduce breaking changes without a repo diff.                                                        | Avoid.                                  |

## 2026-05-31 Re-Evaluation

Decision: keep the pinned unpkg runtime and leave vendoring deferred.

Primary references checked:

- [Ruffle downloads](https://ruffle.rs/downloads) lists `0.2.0` as the stable web package and
  documents both CDN installation and self-hosting.
- [Ruffle GitHub](https://github.com/ruffle-rs/ruffle) describes Ruffle as a Rust Flash Player
  emulator targeting desktop and web through WebAssembly, and lists the MIT / Apache-2.0 dual
  license.
- `npm view @ruffle-rs/ruffle@0.2.0` reports package version `0.2.0`, license
  `(MIT OR Apache-2.0)`, tarball integrity
  `sha512-3SgiTrl+q4cCROpWiKZIwXyrWBpxfSFB42sNUINq1X4IcLNy/lq00UBbIonMB99Onmo1nx91lWxkI83I2tMwvw==`,
  and unpacked size `29,000,511` bytes.
- `npm pack @ruffle-rs/ruffle@0.2.0 --dry-run --json` reports tarball size `10,176,886` bytes,
  unpacked size `29,000,511` bytes, and `12` package files.
- `https://unpkg.com/@ruffle-rs/ruffle@0.2.0/?meta` reports the same `12` package files and
  per-file integrity values.

Current HTTP checks:

| URL or asset                                                | Result | Relevant headers / notes                                                                                           |
| ----------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------ |
| `https://unpkg.com/@ruffle-rs/ruffle@0.2.0`                 | `301`  | Redirects to `/@ruffle-rs/ruffle@0.2.0/ruffle.js`.                                                                 |
| `https://unpkg.com/@ruffle-rs/ruffle@0.2.0/ruffle.js`       | `200`  | `content-type: text/javascript; charset=utf-8`; `cache-control: public, max-age=31536000`; `cf-cache-status: HIT`. |
| `core.ruffle.a6584f4c154875f3f805.js`                       | `200`  | Versioned core JavaScript returned with one-year public cache headers.                                             |
| `core.ruffle.f8e79026a9aea0a4e05d.js`                       | `200`  | Versioned core JavaScript returned with one-year public cache headers.                                             |
| `bae0d5b86e41210ba443.wasm`                                 | `200`  | `content-type: application/wasm`; one-year public cache headers.                                                   |
| `ecc5e233d534bdc785c1.wasm`                                 | `200`  | `content-type: application/wasm`; one-year public cache headers.                                                   |
| `https://mikechaves.github.io/dieai-flash/`                 | `200`  | GitHub Pages page returned `content-length: 29693` and `cache-control: max-age=600`.                               |
| `https://mikechaves.github.io/dieai-flash/assets/DieAI.swf` | `200`  | GitHub Pages SWF returned `content-length: 3223681` and `content-type: application/x-shockwave-flash`.             |

Runtime package footprint if vendored:

| Package file                          | Size                 |
| ------------------------------------- | -------------------- |
| `ruffle.js`                           | `457,962`            |
| `core.ruffle.a6584f4c154875f3f805.js` | `102,936`            |
| `core.ruffle.f8e79026a9aea0a4e05d.js` | `110,264`            |
| `bae0d5b86e41210ba443.wasm`           | `13,872,777`         |
| `ecc5e233d534bdc785c1.wasm`           | `12,974,369`         |
| Source maps                           | `1,468,637` combined |
| License/readme/package metadata       | `13,566` combined    |

Vendoring remains unjustified for the live wrapper because the project has no current CDN outage,
privacy prohibition, or self-contained release requirement. If a future preservation release needs
every runtime byte, vendor the exact package files above, preserve `LICENSE_APACHE` and
`LICENSE_MIT`, update `RUFFLE_SRC`, and re-run the browser smoke checklist.

## Evidence

Observed package metadata for `@ruffle-rs/ruffle@0.2.0`:

- Version: `0.2.0`.
- License: `(MIT OR Apache-2.0)`.
- Package tarball size: `10,176,886` bytes.
- Unpacked size: `29,000,511` bytes.
- Runtime files include:
  - `ruffle.js` (`457,962` bytes).
  - Two core JavaScript files (`102,936` and `110,264` bytes).
  - Two WASM files (`13,872,777` and `12,974,369` bytes).
  - Source maps and license files.

Observed HTTP behavior:

- `https://unpkg.com/@ruffle-rs/ruffle@0.2.0` redirects to the pinned `ruffle.js`.
- The redirected script returns `200`.
- The matching WASM runtime request returns `200`.
- CDN responses use long cache headers for pinned package assets.
- The live GitHub Pages page returns `200`.
- The live `assets/DieAI.swf` request returns `200`.

## Cache Behavior

The pinned package path is content-stable enough for the current wrapper:

- The top-level pinned URL redirects to a versioned package file.
- Runtime asset filenames are hashed.
- The CDN currently serves the versioned runtime with a one-year public cache header.

GitHub Pages serves this repo's static page and SWF separately. The page itself can update through
normal commits, while Ruffle runtime assets remain cached by their pinned version and hashed names.

## Maintenance Expectations

Keep the CDN path pinned until there is a concrete reason to change it.

When upgrading Ruffle:

1. Change `RUFFLE_SRC` in `index.html` to a new explicit version.
2. Run the [Browser Smoke Checklist](../backlog/BROWSER_SMOKE_CHECKLIST.md).
3. Confirm the script, WASM request, and `assets/DieAI.swf` all return `200`.
4. Verify desktop and mobile wrapper layouts.
5. Watch for new console warnings or Ruffle compatibility regressions.
6. Update this decision note if the runtime loading strategy changes.

## Vendoring Trigger

Move vendoring out of the future backlog only if one of these becomes true:

- unpkg/npm availability becomes a real production reliability problem.
- The project needs a fully self-contained archival release.
- Browser or CDN policy changes make the external runtime fetch unreliable.
- Privacy/security requirements prohibit third-party runtime requests.
- A release artifact needs to include every runtime byte used by the live page.

If vendoring is promoted, prefer vendoring the exact package files required by the wrapper plus the
Ruffle license files, and document the upgrade procedure in the same change.
