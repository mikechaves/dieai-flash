# Preservation Release Bundle Dry Run

> Non-publishing dry run for the first current DieAI GitHub preservation release bundle.

_Current as of: 2026-05-31_

---

## Scope

This dry run proves the release-bundle inventory and checksum path without creating a tag, GitHub
Release, or uploaded release asset.

It does not publish anything. It only builds a temporary local bundle from a clean `main` checkout,
generates a `SHA256SUMS.txt` manifest, verifies the manifest, and records the resulting archive
checksum for review.

## Decision

The preservation release bundle path is viable.

No bundle-construction blockers were found. The actual GitHub Release publish step remains deferred
until a release publish pass is explicitly requested.

Publish-time GitHub permissions, tag creation, release creation, and asset upload were intentionally
not tested in this dry run.

## Inputs

- Source commit: `9e06d71` (`Refresh preservation backlogs`)
- Branch state before dry run: `main` matched `origin/main` (`0 0` ahead/behind)
- Wrapper preflight: `node scripts/smoke-wrapper.mjs` passed `58` checks
- Temporary output root: `/tmp/dieai-preservation-release-dry-run-20260531/`
- Bundle directory name: `dieai-preservation-2026-05-31`

The dry run used this committed inventory:

- `DieAI.fla`
- `assets/DieAI.swf`
- `assets/DieAI.html`
- `assets/images/**`
- `index.html`
- `scripts/smoke-wrapper.mjs`
- `lib/shoot/**`
- `com/greensock/**`
- `README.md`
- `CHANGELOG.md`
- `LICENSE`
- `docs/**`

Using all of `docs/**` keeps the release bundle aligned with the repository's preservation evidence,
QA records, backlog governance, portfolio case study, accessibility notes, historical notes, and
source-of-truth decisions.

The current inventory contract and exclusions are reconciled in
[Archive Release Inventory Reconciliation](./ARCHIVE_RELEASE_INVENTORY_RECONCILIATION.md).

The counts and archive checksum below are historical evidence for this dry-run commit. Because
`docs/**` is part of the intended release bundle and documentation continues to evolve, a real
publish pass must rebuild the bundle from the final release commit instead of reusing this archive or
expecting these exact counts.

## Results

| Output                  | Result                                                                  |
| ----------------------- | ----------------------------------------------------------------------- |
| Bundle directory        | `/tmp/dieai-preservation-release-dry-run-20260531/dieai-preservation-2026-05-31/` |
| Bundle archive          | `/tmp/dieai-preservation-release-dry-run-20260531/dieai-preservation-2026-05-31.zip` |
| Files in bundle         | `171` files including `SHA256SUMS.txt`                                  |
| Manifest entries        | `170` tracked bundle files                                              |
| Manifest verification   | `shasum -a 256 -c SHA256SUMS.txt` passed for all entries                |
| Archive size            | `47M`                                                                   |
| Archive SHA-256         | `ef01c916a69e452230ef57fa40ac1e25ca9d846c2d20e449b8fb2247ed8bbc40`      |

Sample verified manifest entries:

```text
./CHANGELOG.md: OK
./DieAI.fla: OK
./LICENSE: OK
./README.md: OK
./assets/DieAI.html: OK
./lib/shoot/DieAIDoc.as: OK
./lib/shoot/DieAIGame.as: OK
./lib/shoot/Particle.as: OK
./lib/shoot/Robot.as: OK
./scripts/smoke-wrapper.mjs: OK
```

## Dry-Run Command Shape

```bash
DRY_ROOT=/tmp/dieai-preservation-release-dry-run-20260531
BUNDLE_NAME=dieai-preservation-2026-05-31

rm -rf "$DRY_ROOT"
mkdir -p "$DRY_ROOT"

git archive --format=tar --prefix="$BUNDLE_NAME/" HEAD -- \
  DieAI.fla \
  assets/DieAI.swf \
  assets/DieAI.html \
  assets/images \
  index.html \
  scripts/smoke-wrapper.mjs \
  lib/shoot \
  com/greensock \
  README.md \
  CHANGELOG.md \
  LICENSE \
  docs \
  | tar -xf - -C "$DRY_ROOT"

cd "$DRY_ROOT/$BUNDLE_NAME"
find . -type f ! -name SHA256SUMS.txt -print0 \
  | sort -z \
  | xargs -0 shasum -a 256 > SHA256SUMS.txt
shasum -a 256 -c SHA256SUMS.txt

cd "$DRY_ROOT"
zip -qr "$BUNDLE_NAME.zip" "$BUNDLE_NAME"
shasum -a 256 "$BUNDLE_NAME.zip" > "$BUNDLE_NAME.zip.sha256"
```

## Publish Gate

Before a real GitHub Release publish pass:

1. Start from clean `main` after `node scripts/smoke-wrapper.mjs` passes.
2. Rebuild the bundle from the final release commit; do not reuse this dry-run archive.
3. Regenerate `SHA256SUMS.txt` and the archive checksum from that final commit.
4. Create a new dated `preservation-YYYY-MM-DD` tag only after approval.
5. Attach the archive and checksum file to the GitHub Release only during the approved publish pass.
6. Verify the release with `gh release view <tag> --json tagName,assets,url`.
7. Record the release URL and final archive checksum in the changelog or release decision note.
