# GitHub Release Approval Packet

> Draft approval checkpoint for the first current DieAI preservation release bundle.

_Current as of: 2026-05-31_

---

## Scope

This packet prepares the approval-checkpoint values from
[GitHub Release Publish Runbook](./GITHUB_RELEASE_PUBLISH_RUNBOOK.md) without creating a tag,
GitHub Release, or uploaded release asset.

It is a review packet, not a publish record. The actual publish pass must rebuild the bundle from
the final approved release commit before tagging.

## Decision

Ready for approval review, not approved for publishing.

No release blocker was found in the local bundle build. Publishing remains gated on explicit human
approval and a final clean-main rebuild.

## Self-Reference Note

The release inventory includes `docs/**`. Because this approval packet is itself a documentation file,
committing it changes any future final release bundle checksum.

The values below are therefore the approval-candidate values for source commit
`07ce9ec65fa3bc3381573b4ba302ba79e1dd6148`, before this packet was committed. During the real publish
pass, regenerate the archive, manifest, and checksum from the final approved commit and present those
final values before creating the tag or GitHub Release.

## Candidate Release Shape

| Field | Value |
| ----- | ----- |
| Proposed tag | `preservation-2026-05-31` |
| Proposed release title | `DieAI Preservation Release 2026-05-31` |
| Bundle directory | `dieai-preservation-2026-05-31` |
| Bundle archive | `dieai-preservation-2026-05-31.zip` |
| Checksum asset | `dieai-preservation-2026-05-31.zip.sha256` |
| Candidate source commit | `07ce9ec65fa3bc3381573b4ba302ba79e1dd6148` |
| Temporary output root | `/tmp/dieai-preservation-release-approval-preservation-2026-05-31` |
| Candidate archive path | `/tmp/dieai-preservation-release-approval-preservation-2026-05-31/dieai-preservation-2026-05-31.zip` |
| Candidate checksum path | `/tmp/dieai-preservation-release-approval-preservation-2026-05-31/dieai-preservation-2026-05-31.zip.sha256` |
| Temporary notes file | `/tmp/dieai-preservation-release-approval-preservation-2026-05-31/release-notes.md` |

## Preflight Results

| Check | Result |
| ----- | ------ |
| `main` clean | Pass |
| `HEAD` matches `origin/main` | Pass, `0 0` ahead/behind |
| Static wrapper smoke | Pass, `58` checks |
| Same-day local preservation tag | None found for `preservation-2026-05-31*` |
| Existing GitHub Release | `gh release view preservation-2026-05-31` returned `release not found` |
| Tag created by this packet | No |
| GitHub Release created by this packet | No |
| Release asset uploaded by this packet | No |

## Candidate Bundle Results

| Output | Result |
| ------ | ------ |
| Files in bundle | `178` files including `SHA256SUMS.txt` |
| Manifest entries | `177` tracked bundle files |
| Manifest verification | `shasum -a 256 -c SHA256SUMS.txt` passed for all entries |
| Zip integrity | `unzip -t dieai-preservation-2026-05-31.zip` passed |
| Archive size | `46M` |
| Candidate archive SHA-256 | `ab76b6bef6fac3a67387a8ff80dd61d456aefe0dc21a8e5a95d3582245515d5a` |

Sample manifest verification output:

```text
./CHANGELOG.md: OK
./DieAI.fla: OK
./LICENSE: OK
./README.md: OK
./assets/DieAI.html: OK
./assets/DieAI.swf: OK
./assets/images/game-over.png: OK
./assets/images/intro-good.png: OK
./assets/images/intro-hacked.png: OK
./assets/images/level-one.png: OK
./assets/images/main-image.png: OK
./assets/images/social-preview.png: OK
```

Zip integrity result:

```text
No errors detected in compressed data of dieai-preservation-2026-05-31.zip.
```

## Candidate Release Notes

The temporary notes file contains:

```text
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
```

## Approval Gate

Before publishing, present the final regenerated values from the final approved commit:

1. release tag;
2. release title;
3. release commit SHA;
4. bundle archive path;
5. bundle file count;
6. manifest entry count;
7. archive size;
8. archive SHA-256;
9. confirmation that no tag or GitHub Release has been created yet.

Only after explicit approval should the publish pass create the annotated tag, push it, create the
GitHub Release, upload the zip and `.zip.sha256` assets, and verify the downloaded release assets.
