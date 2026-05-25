# Ruffle Runtime Decision

> Decision record for how the DieAI web wrapper loads Ruffle.

_Current as of: 2026-05-24_

---

## Decision

Keep loading Ruffle from the pinned CDN URL:

```text
https://unpkg.com/@ruffle-rs/ruffle@0.2.0
```

Do not vendor Ruffle into this repo right now.

Revisit vendoring only if CDN reliability, privacy, availability, or archival requirements become
stronger than the current need to keep the repository small and easy to inspect.

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

## Evidence

Observed package metadata for `@ruffle-rs/ruffle@0.2.0`:

- Version: `0.2.0`.
- License: `(MIT OR Apache-2.0)`.
- Package tarball size: about `10.2 MB`.
- Unpacked size: about `29.0 MB`.
- Runtime files include:
  - `ruffle.js` (`458.0 kB`).
  - Two core JavaScript files (`102.9 kB` and `110.3 kB`).
  - Two WASM files (`13.9 MB` and `13.0 MB`).
  - Source maps and license files.

Observed HTTP behavior:

- `https://unpkg.com/@ruffle-rs/ruffle@0.2.0` redirects to the pinned `ruffle.js`.
- The redirected script returns `200`.
- The matching WASM runtime request returns `200`.
- CDN responses use long cache headers for pinned package assets.
- The live GitHub Pages page returns `200`.

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
