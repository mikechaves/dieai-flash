# External Archive Submission Readiness

> Readiness notes for any future Internet Archive or Flashpoint submission.

_Current as of: 2026-05-31_

---

## Scope

This note prepares external archive submission metadata and blockers. It does not submit DieAI to an
external archive, create an Internet Archive item, upload a Flashpoint curation, or make a Flashpoint
request.

The current preservation order remains:

1. keep the repository and GitHub Pages wrapper stable;
2. publish the approved GitHub preservation release bundle;
3. use that release URL, checksum, and rights note as the source of truth for any external archive
   submission.

## Decision

Do not submit to an external archive yet.

The project now has enough metadata to prepare a submission, but it still needs a published GitHub
Release bundle URL and final archive checksum before an external archive item should be created.
Flashpoint also needs a target-specific curation package and playable test, not just the general
GitHub preservation zip.

## Sources Checked

- [Internet Archive Uploading - A Basic Guide](https://archivesupport.zendesk.com/hc/en-us/articles/360002360111-Uploading-A-Basic-Guide)
- [Internet Archive Uploading - Tips](https://archivesupport.zendesk.com/hc/en-us/articles/360016475032-Uploading-Tips)
- [Internet Archive Rights](https://archivesupport.zendesk.com/hc/en-us/articles/360014759692-Rights)
- [Flashpoint Curation Format](https://flashpointarchive.org/datahub/Curation_Format)
- [Flashpoint Curation Tutorial](https://flashpointarchive.org/datahub/Curation_Tutorial)
- [Flashpoint Request Form](https://flashpointarchive.org/datahub/Request_Form)
- [Flashpoint Submission System](https://fpfss.flashpointarchive.org/web)

The 2026-05-31 refresh confirmed:

- Internet Archive upload pages require item metadata such as title, identifier, description, subject
  tags, creator, date, collection, language, and license; item identifiers should use simple
  lowercase ASCII characters, dashes, or underscores.
- Internet Archive upload tips still advise avoiding very large single-page uploads and note that
  item processing can take time after upload.
- Internet Archive rights guidance still places non-infringing-use responsibility on the uploader and
  does not guarantee item rights metadata.
- Flashpoint curation guidance still expects a curation archive with metadata, `content/`, `logo.png`,
  screenshot evidence, a Flash-compatible launch command, and real Flashpoint Infinity testing.

## Candidate Targets

| Target           | Candidate Use                                                                                                    | Current Status                                                                                             |
| ---------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Internet Archive | Mirror the approved GitHub preservation release bundle as a downloadable item with checksum and rights metadata. | Not ready until the GitHub Release exists and the final archive SHA-256 is known.                           |
| Flashpoint       | Preserve a playable Flash curation or submit a request after duplicate and eligibility checks.                    | Not ready until a Flashpoint-specific curation package is built, tested, and reviewed against their format. |

Do not treat the GitHub preservation zip as a Flashpoint-ready curation. Flashpoint expects a curation
layout with metadata, images, and playable content arranged for Flashpoint, while this repository's
release bundle is a broad preservation payload.

## Internet Archive Metadata Draft

Use the final GitHub Release, not the dry-run archive, as the upload source.

| Field | Draft Value / Guidance |
| ----- | ---------------------- |
| Title | `DieAI Flash Game Preservation Bundle` |
| Identifier / page URL | Prefer `dieai-flash-game-preservation-bundle` if available; otherwise append the release date, for example `dieai-flash-game-preservation-bundle-YYYY-MM-DD`. |
| Creator | `Michael Chaves` |
| Date | `2018-10-30` for the original Flash publish evidence; mention the preservation release date in the description. |
| Description | Preservation bundle for the 2018 DieAI Flash game, including the original Adobe Animate FLA, exported SWF, original generated HTML, ActionScript source, imagery, modern Ruffle wrapper, documentation, and checksums. |
| Subject tags | `Flash`; `Flash game`; `ActionScript 3`; `Adobe Animate`; `Ruffle`; `web game preservation`; `student game`; `DieAI`; `AICorp`; `Michael Chaves` |
| Language | `English` |
| Mediatype | Prefer `software` if the item is treated as a preserved playable/software artifact; confirm collection fit during the actual upload pass. |
| Collection | Let Internet Archive auto-select from the uploaded file format first, then review whether a software-related collection is more appropriate. |
| Files | Approved `dieai-preservation-YYYY-MM-DD.zip` plus `dieai-preservation-YYYY-MM-DD.zip.sha256`. |
| Source | GitHub repository URL, GitHub Release URL, and final archive SHA-256. |
| License | Do not select a blanket Creative Commons license for the whole bundle unless a fresh rights review approves it. Use the rights note below. |
| Custom metadata | Consider adding repository URL, GitHub Release URL, archive SHA-256, original publish evidence date, and `Ruffle` runtime note as custom metadata or description text. |

Filename constraints are already compatible with Internet Archive guidance if the release bundle keeps
the ASCII `dieai-preservation-YYYY-MM-DD.zip` naming pattern from
[GitHub Release Publish Runbook](./GITHUB_RELEASE_PUBLISH_RUNBOOK.md).

### Internet Archive Pre-Upload Checklist

Do this only after the approved GitHub Release exists:

1. Confirm the release URL and final archive SHA-256 from the published GitHub Release.
2. Confirm the exact uploaded files are the approved zip and `.zip.sha256` assets.
3. Confirm the item identifier is available and uses simple lowercase ASCII, dashes, or underscores.
4. Confirm mediatype and collection fit during the actual upload pass.
5. Paste the rights note below into the description or rights field as appropriate.
6. Avoid selecting a blanket Creative Commons license for the whole mixed-rights bundle unless a fresh
   rights review approves it.
7. After upload, wait for item processing and verify the item page, file list, download links,
   metadata, rights text, and checksum file.

## Rights Note Draft

Use this as the starting rights text for any external archive item:

```text
Michael Chaves-authored portions of this preservation bundle are released under the repository MIT
License unless a file says otherwise. The bundle also includes bundled GreenSock ActionScript files
preserved for source and rebuild compatibility; those files retain their own copyright and terms
notices and are not relicensed by the repository MIT license. See LICENSE,
docs/preservation/GREENSOCK_LICENSE_REVIEW.md, and SHA256SUMS.txt inside the bundle.
```

Before upload, review whether the archive target has a separate license selector that conflicts with
the mixed-rights bundle. If it does, prefer custom description/rights text over selecting a blanket
license that overstates the grant.

## Flashpoint Readiness Draft

Flashpoint should be evaluated as a separate playable curation, not as a mirror of the GitHub
preservation bundle.

Before any Flashpoint submission:

1. Search the Flashpoint database and current submission channels for duplicates.
2. Confirm the work is eligible as a browser-playable Flash game or personal/offline project.
3. Build a Flashpoint curation with:
   - `meta.yaml` generated through Flashpoint's Curate tab;
   - `logo.png`;
   - screenshot PNG;
   - `content/` containing the SWF and any required files in a Flashpoint-compatible path.
4. Test the curation in Flashpoint, including launch, movement, firing, intro transition, and game-over
   recovery.
5. Record whether `localflash` is appropriate for this personal/student project or whether curators
   prefer another launch-command structure.
6. Join the Flashpoint Discord and use the Flashpoint Submission System only after the curation passes
   local testing.

Metadata starting point:

| Field | Draft Value / Guidance |
| ----- | ---------------------- |
| Title | `DieAI` |
| Library | `Arcade` |
| Platform | `Flash` |
| Application Path | `FPSoftware\Flash\flashplayer_32_sa.exe`, unless local testing proves another Flash projector is required. |
| Developer / Creator | `Michael Chaves` |
| Release Date | `2018-10-30` if accepted, otherwise `2018`. |
| Source | `Personal Archive: Michael Chaves` or the final GitHub Release URL, depending on curator guidance. |
| Launch Command | Proposed preflight value: `http://localflash/dieai/DieAI.swf`. Confirm with curators because `localflash` is reserved for offline media and personal projects. Do not use the GitHub Pages HTTPS URL. |
| Original Description | Use the README/project description and note the runtime-confirmed `A`, `D`, and `Space` controls. |
| Notes | Mention that the curation is based on a preserved 2018 student Flash game with source, FLA, SWF, and Ruffle wrapper context in the GitHub preservation release. |
| Curation Notes | Mention any `localflash` rationale, missing original hosted URL, release URL, checksum, and test results. |

### Flashpoint Curation Preflight Plan

Do this only after the GitHub preservation release exists or an explicit Flashpoint curation pass is
started:

1. Search the Flashpoint database, FPFSS, not-accepted curations, and relevant curation channels for
   `DieAI`, `Michael Chaves`, `AICorp`, and `Buddy Bots`.
2. Confirm eligibility as a browser-playable Flash game or personal/offline project.
3. Create a local curation folder outside the repo, for example
   `/tmp/dieai-flashpoint-curation-YYYY-MM-DD/`.
4. Use Flashpoint Infinity's Curate tab to generate `meta.yaml`; do not hand-edit the metadata file
   as the source of truth.
5. Build this proposed content layout for local testing:

   ```text
   dieai/
   ├── content/
   │   └── localflash/
   │       └── dieai/
   │           └── DieAI.swf
   ├── logo.png
   ├── screenshot.png
   └── meta.yaml
   ```

6. Use `assets/DieAI.swf` from the final GitHub Release bundle as the playable content source.
7. Generate `logo.png` from the title/start-screen art and `screenshot.png` from active gameplay,
   both as PNG files.
8. Test in Flashpoint Infinity through the Curate tab with the Run button.
9. Exercise launch, start screen, intro skip, `A`, `D`, `Space`, game-over or win-state recovery, and
   logs for missing asset requests.
10. Export the curation only after local testing passes.
11. Submit through FPFSS only after Discord/curator flow and duplicate checks are complete.

## Remaining Blockers

- No current GitHub preservation release URL exists yet.
- The final release archive SHA-256 is not known yet.
- Internet Archive collection and mediatype should be confirmed during the actual upload pass.
- Internet Archive item identifier availability has not been checked.
- A Flashpoint curation package has not been built, exported, or tested.
- Flashpoint duplicate, not-accepted, FPFSS, Discord, and eligibility checks have not been performed.
- Flashpoint `localflash` launch-command suitability needs curator confirmation or local test proof.
- Rights language should be reviewed once the final release bundle exists.

## Submission Gate

External archive submission can move out of future backlog only when:

1. the GitHub preservation release bundle exists;
2. the final release URL and archive SHA-256 are recorded;
3. the rights note is reviewed against the exact uploaded bundle contents;
4. the selected external target is explicit;
5. target-specific metadata is finalized;
6. any Flashpoint curation package has passed local Flashpoint testing;
7. the user explicitly requests the external upload, request, or submission.
