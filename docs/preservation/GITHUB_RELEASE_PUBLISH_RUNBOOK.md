# GitHub Release Publish Runbook

> Approval-gated checklist for publishing the first current DieAI preservation release bundle.

_Current as of: 2026-05-31_

---

## Scope

This runbook describes how to publish a curated GitHub Release preservation bundle after an explicit
release publish pass is requested.

It does not authorize creating a tag, GitHub Release, or uploaded asset during ordinary backlog work.
Stop at the approval checkpoint unless the publish pass has been explicitly approved.

## Release Shape

- Tag format: `preservation-YYYY-MM-DD`
- Release title format: `DieAI Preservation Release YYYY-MM-DD`
- Bundle directory format: `dieai-preservation-YYYY-MM-DD`
- Bundle archive format: `dieai-preservation-YYYY-MM-DD.zip`
- Checksum asset: `dieai-preservation-YYYY-MM-DD.zip.sha256`

Do not reuse the older `dieai`, `ruffle`, or `html5` tags. Those tags point at the initial commit
and are not the current preservation baseline.

If a same-day preservation tag already exists, choose an explicit suffix such as
`preservation-YYYY-MM-DD-2` and mirror that suffix in the bundle name and release title.

## Required Preconditions

Before building a real release candidate:

1. `main` is clean and matches `origin/main`.
2. The release commit is the intended final preservation commit.
3. `node scripts/smoke-wrapper.mjs` passes.
4. The release bundle dry-run path remains valid.
5. The inventory still matches
   [Archive Release Inventory Reconciliation](./ARCHIVE_RELEASE_INVENTORY_RECONCILIATION.md).
6. GitHub CLI authentication and repository permissions are available.
7. A human has approved moving past the approval checkpoint.

## Clean-Main Preflight

Run from the repository root:

```bash
git fetch --tags origin main
git status --short --branch
git rev-list --left-right --count HEAD...origin/main
git rev-parse HEAD
node scripts/smoke-wrapper.mjs
```

Required results:

- `git status --short --branch` shows `## main...origin/main` with no modified files.
- `git rev-list --left-right --count HEAD...origin/main` prints `0 0`.
- `node scripts/smoke-wrapper.mjs` passes.

If any preflight step fails, stop and fix the repo state before building the bundle.

## Build The Bundle

Set release variables:

```bash
TAG=preservation-YYYY-MM-DD
BUNDLE_NAME=dieai-preservation-YYYY-MM-DD
DRY_ROOT=/tmp/dieai-preservation-release-$TAG
```

Build from the final release commit:

```bash
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
unzip -t "$BUNDLE_NAME.zip"
```

Record before publishing:

```bash
find "$DRY_ROOT/$BUNDLE_NAME" -type f | wc -l
wc -l "$DRY_ROOT/$BUNDLE_NAME/SHA256SUMS.txt"
du -h "$DRY_ROOT/$BUNDLE_NAME.zip"
cat "$DRY_ROOT/$BUNDLE_NAME.zip.sha256"
```

## Prepare Release Notes

Create a temporary notes file:

```bash
cat > "$DRY_ROOT/release-notes.md" <<'EOF'
Curated preservation bundle for the current DieAI Flash revival.

Includes:
- original Adobe Animate authoring file (`DieAI.fla`)
- exported SWF and original generated HTML
- modern Ruffle wrapper and static smoke script
- original ActionScript source
- bundled GreenSock ActionScript dependency
- committed imagery
- README, changelog, preservation docs, QA docs, accessibility notes, historical notes, and backlog docs
- `SHA256SUMS.txt` inside the bundle

The accompanying `.zip.sha256` asset records the SHA-256 for the uploaded archive.
EOF
```

Adjust the notes only if the final bundle contents differ.

## Approval Checkpoint

Stop here unless the publish pass has explicit approval.

Before asking for approval, present:

- release tag;
- release commit SHA;
- bundle archive path;
- bundle file count;
- manifest entry count;
- archive size;
- archive SHA-256;
- confirmation that no tag or GitHub Release has been created yet.

## Publish Commands

Run these only after approval:

```bash
git tag -a "$TAG" -m "DieAI preservation release $TAG"
git push origin "$TAG"

gh release create "$TAG" \
  "$DRY_ROOT/$BUNDLE_NAME.zip" \
  "$DRY_ROOT/$BUNDLE_NAME.zip.sha256" \
  --title "DieAI Preservation Release ${TAG#preservation-}" \
  --notes-file "$DRY_ROOT/release-notes.md"
```

## Verify Published Release

After publishing:

```bash
gh release view "$TAG" --json tagName,name,isDraft,isPrerelease,assets,url
git ls-remote --tags origin "$TAG"
```

Download the uploaded assets into a fresh temporary directory and verify the archive checksum:

```bash
VERIFY_ROOT=/tmp/dieai-preservation-release-verify-$TAG
rm -rf "$VERIFY_ROOT"
mkdir -p "$VERIFY_ROOT"

gh release download "$TAG" --dir "$VERIFY_ROOT"
cd "$VERIFY_ROOT"
shasum -a 256 -c "$BUNDLE_NAME.zip.sha256"
unzip -t "$BUNDLE_NAME.zip"
```

The release is not complete until the downloaded archive passes checksum and zip integrity checks.

## Post-Publish Documentation

After a successful publish pass:

1. Add the release URL and final archive SHA-256 to
   [Archive Distribution Decision](./ARCHIVE_DISTRIBUTION_DECISION.md) or the changelog.
2. Keep the actual uploaded archive out of git.
3. Commit and push the documentation update to `main`.
4. Only then consider external archive readiness work.

## Rollback Notes

Rollback requires explicit confirmation because it removes public release state.

If the tag was pushed but the release was not created:

```bash
git push origin ":refs/tags/$TAG"
git tag -d "$TAG"
```

If the GitHub Release was created with incorrect assets or notes, prefer fixing the release in place
only when the tag, archive, and checksums are still correct.

If the release must be removed, confirm the current `gh release delete` flags locally, then delete the
release and clean up the tag intentionally. Record what happened in the next documentation update.
