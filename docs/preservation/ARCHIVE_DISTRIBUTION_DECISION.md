# Archive Distribution Decision

> Decision record for whether `DieAI.fla` should be mirrored outside the git history.

_Current as of: 2026-05-31_

---

## Decision

Mirror `DieAI.fla` in a GitHub Release asset at the next preservation publish gate, but do not
publish a standalone FLA-only upload.

The release asset should be a curated preservation bundle that includes the original FLA, exported
SWF, original generated HTML, current wrapper state, original ActionScript source, bundled
GreenSock dependency, committed imagery, README, changelog, preservation docs, and checksums. The
normal GitHub source archive remains useful as the broad repository snapshot, but the attached
bundle gives reviewers a named, checksum-backed preservation payload.

Do not submit the build to an external public archive yet. Keep Internet Archive, Flashpoint, or
similar submission as deferred work until the GitHub Release bundle exists and the upload metadata,
rights notes, and collection expectations are reviewed.

## Sources Checked

- [GitHub Docs: About releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases):
  release assets are attached to tag-based releases; a release can have up to 1000 assets, each
  under 2 GiB, with no stated total release size or bandwidth limit.
- [Internet Archive Help: Uploading - A Basic Guide](https://archivesupport.zendesk.com/hc/en-us/articles/360002360111-Uploading-A-Basic-Guide):
  uploads require an account, metadata, a license field, and file-name constraints; item processing
  can take time after upload.
- [Internet Archive Help: Rights](https://archivesupport.zendesk.com/hc/en-us/articles/360014759692-Rights):
  uploaders and users remain responsible for non-infringing use; Archive.org item rights metadata is
  not a guarantee.

## Current Artifact Facts

| Artifact            | Size bytes | SHA-256                                                            | Role                                           |
| ------------------- | ---------- | ------------------------------------------------------------------ | ---------------------------------------------- |
| `DieAI.fla`         | `50392143` | `a38a6fa7b614a73c1c710fdd9c69d8e05b0af1dd9d200a94369448b779a093df` | Original Adobe Animate / Flash authoring file. |
| `assets/DieAI.swf`  | `3223681`  | `1cb333d6a97c41752e2a76e617921ae5509b5ae6cd33f71bcc33f673e0992f9e` | Playable SWF loaded by the Ruffle wrapper.     |
| `assets/DieAI.html` | `2018`     | `c1f6e1b8e71a154e7a0aaf05193f874a18551daa2e23fa6138dfbc52e64d121a` | Original Flash publish-profile HTML output.    |

Existing GitHub releases `dieai`, `ruffle`, and `html5` were published on 2025-07-14 with no
attached assets. All three tags point at the initial commit, so they should not be reused as the
current preservation baseline.

## Options

| Option                                        | Benefits                                                                                            | Costs / Risks                                                                                                      | Decision                                                                            |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------- |
| Keep only git history                         | Lowest maintenance. The FLA is already tracked in the repository.                                   | Less discoverable for non-git users; no named preservation package or release checksums.                           | Insufficient for the current preservation posture.                                  |
| Rely only on GitHub generated source archives | Automatic for every tag and includes tracked files at that tag.                                     | Generated archive checksums are not the project-owned manifest; package contents are not curated for preservation. | Keep as supporting release behavior, not the primary distribution record.           |
| Attach a GitHub Release preservation bundle   | Clear project-owned artifact; supports release notes, checksums, download counts, and repo context. | Requires packaging discipline and a clean publish checklist.                                                       | Chosen next gate.                                                                   |
| Upload to an external archive                 | Better long-term discoverability and resilience outside GitHub.                                     | Requires upload account, metadata, license/rights review, collection fit, and a stable packaged artifact first.    | Defer until after the GitHub Release bundle exists and rights metadata is reviewed. |

## Release Bundle Gate

When publishing the first current preservation release:

1. Start from clean `main` after the static wrapper smoke script passes.
2. Create a dated release tag, such as `preservation-YYYY-MM-DD`, instead of reusing the old
   `dieai`, `ruffle`, or `html5` tags.
3. Build a temporary bundle directory that includes:
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
4. Generate `SHA256SUMS.txt` for the bundle contents and the final archive file.
5. Attach the archive and checksum file to the GitHub Release.
6. Verify the release with `gh release view <tag> --json tagName,assets,url`.
7. Add the release URL and final archive checksum to the changelog or this decision note.

## Release Bundle Dry Run

The first non-publishing bundle dry run completed on 2026-05-31 and is recorded in
[Preservation Release Bundle Dry Run](./PRESERVATION_RELEASE_BUNDLE_DRY_RUN.md).

The dry run verified that the full committed bundle inventory can be generated from clean `main`,
that a `SHA256SUMS.txt` manifest can be produced and checked, and that a local zip archive can be
created without creating a tag, GitHub Release, or uploaded asset.

## Publish Runbook

The approval-gated publish checklist is recorded in
[GitHub Release Publish Runbook](./GITHUB_RELEASE_PUBLISH_RUNBOOK.md).

The runbook documents clean-main preflight, bundle generation, checksum verification, release notes,
the approval checkpoint, publish commands, release verification, post-publish documentation, and
rollback handling.

## External Archive Readiness

External archive submission metadata and blockers are recorded in
[External Archive Submission Readiness](./EXTERNAL_ARCHIVE_SUBMISSION_READINESS.md).

That note keeps Internet Archive mirroring and Flashpoint curation separate, and keeps both deferred
until the GitHub preservation release URL, final archive checksum, rights review, target-specific
metadata, and explicit submission approval exist.

## Backlog Impact

- Remove the completed archive-distribution decision row from
  [Active Backlog](../backlog/ACTIVE_BACKLOG.md).
- Keep the GitHub Release bundle publish step in
  [Future Backlog](../backlog/FUTURE_BACKLOG.md) until a release publish pass is explicitly started.
- Keep external archive submission in Future Backlog until the release bundle URL, checksum,
  reviewed rights note, selected target, target-specific metadata, and explicit approval are ready.
