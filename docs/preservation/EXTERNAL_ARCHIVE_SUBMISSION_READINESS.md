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

| Field          | Draft Value / Guidance                                                                                                                                                 |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Title          | `DieAI Flash Game Preservation Bundle`                                                                                                                                 |
| Creator        | `Michael Chaves`                                                                                                                                                       |
| Date           | `2018-10-30` for the original Flash publish evidence; mention the preservation release date in the description.                                                         |
| Description    | Preservation bundle for the 2018 DieAI Flash game, including the original Adobe Animate FLA, exported SWF, original generated HTML, ActionScript source, imagery, modern Ruffle wrapper, documentation, and checksums. |
| Subject tags   | `Flash`; `Flash game`; `ActionScript 3`; `Adobe Animate`; `Ruffle`; `web game preservation`; `student game`; `DieAI`; `AICorp`; `Michael Chaves`                       |
| Language       | `English`                                                                                                                                                              |
| Mediatype      | Prefer `software` if the item is treated as a preserved playable/software artifact; confirm collection fit during the actual upload pass.                                |
| Files          | Approved `dieai-preservation-YYYY-MM-DD.zip` plus `dieai-preservation-YYYY-MM-DD.zip.sha256`.                                                                           |
| Source         | GitHub repository URL, GitHub Release URL, and final archive SHA-256.                                                                                                   |
| License        | Do not select a blanket Creative Commons license for the whole bundle unless a fresh rights review approves it. Use the rights note below.                              |

Filename constraints are already compatible with Internet Archive guidance if the release bundle keeps
the ASCII `dieai-preservation-YYYY-MM-DD.zip` naming pattern from
[GitHub Release Publish Runbook](./GITHUB_RELEASE_PUBLISH_RUNBOOK.md).

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

| Field                | Draft Value / Guidance                                                                                       |
| -------------------- | ------------------------------------------------------------------------------------------------------------ |
| Title                | `DieAI`                                                                                                      |
| Platform             | `Flash`                                                                                                      |
| Developer / Creator  | `Michael Chaves`                                                                                             |
| Date                 | `2018` or `2018-10-30` if Flashpoint accepts the more precise preserved publish evidence.                     |
| Source               | `Personal Archive` or the final GitHub Release URL, depending on curator guidance.                           |
| Launch Command       | Must be Flashpoint-compatible HTTP or approved `localflash` structure; do not use the GitHub Pages HTTPS URL. |
| Original Description | Use the README/project description and note the runtime-confirmed `A`, `D`, and `Space` controls.             |
| Curation Notes       | Mention preserved source, original SWF, Ruffle wrapper context, and any localflash/personal-project rationale. |

## Remaining Blockers

- No current GitHub preservation release URL exists yet.
- The final release archive SHA-256 is not known yet.
- Internet Archive collection and mediatype should be confirmed during the actual upload pass.
- A Flashpoint curation package has not been built or tested.
- Flashpoint duplicate and eligibility checks have not been performed.
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
