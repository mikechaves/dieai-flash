# Archive Release Inventory Reconciliation

> Alignment note for archive asset scope and the GitHub Release bundle inventory.

_Current as of: 2026-05-31_

---

## Scope

This note reconciles the archive asset map, non-publishing release-bundle dry run, release publish
runbook, runtime decision, temporary-artifact exclusions, and checksum-manifest expectations before a
real GitHub Release publish pass.

It does not create a tag, build a final release archive, upload a release asset, or submit the game to
an external archive.

## Decision

The archive scope and GitHub Release bundle inventory agree.

The first real preservation release should use the curated inventory below, generate a fresh
`SHA256SUMS.txt` inside the bundle from the final release commit, publish a separate archive checksum
asset, and keep external Ruffle runtime bytes plus temporary QA output outside the repository bundle.

## Release Bundle Inventory Contract

| Bundle Area | Included Paths | Source / Reason |
| ----------- | -------------- | --------------- |
| Original authoring artifact | `DieAI.fla` | Canonical Adobe Animate / Flash source document. |
| Exported Flash artifacts | `assets/DieAI.swf`, `assets/DieAI.html` | Playable SWF and original generated HTML evidence. |
| Wrapper imagery | `assets/images/**` | Screenshots, fallback imagery, and social preview assets used by the static wrapper and docs. |
| Modern wrapper | `index.html`, `scripts/smoke-wrapper.mjs` | GitHub Pages wrapper and dependency-free smoke validation helper. |
| Original source | `lib/shoot/**` | Michael Chaves-authored ActionScript gameplay source. |
| Bundled dependency | `com/greensock/**` | Third-party GreenSock ActionScript source required for source/rebuild compatibility. |
| Project documentation | `README.md`, `CHANGELOG.md`, `LICENSE`, `docs/**` | Entry docs, release notes, license, preservation evidence, QA notes, accessibility notes, historical notes, portfolio draft, and backlog governance. |
| Internal manifest | `SHA256SUMS.txt` | Generated inside the temporary bundle directory during the publish pass; not tracked in git. |
| Release checksum asset | `dieai-preservation-YYYY-MM-DD.zip.sha256` | Generated next to the release zip and attached to the GitHub Release; not tracked in git. |

This matches the inventory used by:

- [Archive Asset Scope](./ARCHIVE_ASSET_SCOPE.md);
- [Archive Distribution Decision](./ARCHIVE_DISTRIBUTION_DECISION.md);
- [Preservation Release Bundle Dry Run](./PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md);
- [GitHub Release Publish Runbook](./GITHUB_RELEASE_PUBLISH_RUNBOOK.md).

## Explicit Exclusions

| Excluded Surface | Reason |
| ---------------- | ------ |
| Ruffle CDN package files | The current runtime decision keeps Ruffle external at the pinned CDN URL. If vendored later, update the runtime decision and this inventory in the same change. |
| GitHub-generated source archives | Useful supporting release behavior, but not the curated project-owned preservation payload or checksum manifest. |
| `/tmp/dieai-*` output | Local smoke, Playwright, dry-run, and scratch-publish evidence is temporary unless a future decision intentionally tracks visual baselines. |
| Playwright traces and screenshots | QA evidence may be referenced by path during a run, but generated browser artifacts are not release-bundle inputs. |
| Local HTTP server logs or caches | Environment-specific validation output, not preservation content. |
| `node_modules` or temporary tool installs | Tooling used for validation must not become part of the static preservation bundle. |

## Checksum Expectations

The publish pass must generate two checksum layers from the final release commit:

1. `SHA256SUMS.txt` inside the bundle directory, covering every bundled file except
   `SHA256SUMS.txt` itself.
2. `dieai-preservation-YYYY-MM-DD.zip.sha256` beside the zip archive, covering the uploaded archive
   file.

Both layers must be regenerated for the final release commit. Do not reuse the historical dry-run
manifest, dry-run zip, or dry-run archive checksum.

## Dry-Run Reconciliation

The dry run proves the command shape and manifest process. Its recorded file count, manifest count,
archive size, and archive SHA-256 are historical evidence for the dry-run commit listed in that note.

Because `docs/**` is intentionally included in the release inventory, later documentation updates are
expected to change release-bundle counts and checksums. A real publish pass must rebuild the bundle
after all documentation updates are committed and `main` matches `origin/main`.

## Runtime Posture

The release bundle includes the wrapper that references the pinned Ruffle CDN package, but it does not
include Ruffle JavaScript or WASM bytes. This is intentional and matches
[Ruffle Runtime Decision](./RUFFLE_RUNTIME_DECISION.md).

The first GitHub preservation release does not require a self-contained Ruffle runtime. The release
bundle is allowed to preserve the current wrapper's external pinned runtime reference as long as the
publish pass records a clean smoke result and the release notes make clear that runtime emulation is
provided by the wrapper through the pinned Ruffle package.

If a future release requires a fully self-contained runtime, first promote the vendoring task from
[Future Backlog](../backlog/FUTURE_BACKLOG.md), vendor the exact runtime package and license files,
update `index.html`, and re-run live/local browser smoke before publishing.

## Publish Readiness Check

Before creating any real preservation release:

1. `main` is clean and matches `origin/main`.
2. `node scripts/smoke-wrapper.mjs` passes.
3. A current live or local browser smoke pass has no release-blocking runtime failures.
4. The bundle inventory still matches this note.
5. `SHA256SUMS.txt` verifies every bundled file.
6. `unzip -t` verifies the final zip archive.
7. The archive checksum file verifies the final zip.
8. The approval checkpoint in [GitHub Release Publish Runbook](./GITHUB_RELEASE_PUBLISH_RUNBOOK.md)
   is satisfied before tag or release creation.
