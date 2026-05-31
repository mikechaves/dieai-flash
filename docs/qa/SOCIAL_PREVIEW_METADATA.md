# Social Preview Metadata

> Current OpenGraph and Twitter/X card contract for the DieAI wrapper.

_Current as of: 2026-05-31_

---

## Purpose

Use this note when reviewing social preview behavior for the static wrapper. It documents the
canonical URL, card copy, image asset, and validation path so social-preview changes do not drift
from the playable GitHub Pages target.

## Preview Contract

| Field         | Value                                                                                                                               |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Canonical URL | `https://mikechaves.github.io/dieai-flash/`                                                                                         |
| Title         | `DieAI - Flash Revival`                                                                                                             |
| Description   | `Play DieAI, Michael Chaves's 2018 Flash game revived with Ruffle. Stop AICorp's Buddy Bots before the launch gets out of control.` |
| Card type     | `summary_large_image` for Twitter/X; `website` for OpenGraph.                                                                       |
| Image         | `https://mikechaves.github.io/dieai-flash/assets/images/social-preview.png`                                                         |
| Image alt     | `DieAI title art showing one friendly Buddy Bot and one hacked Buddy Bot.`                                                          |

## Image Asset

| Asset                              | Dimensions | Type      | Source                                                                |
| ---------------------------------- | ---------- | --------- | --------------------------------------------------------------------- |
| `assets/images/social-preview.png` | `1200x630` | PNG / RGB | Cropped and resized from `assets/images/main-image.png` for card use. |

The social preview image is intentionally separate from the full hero image. The hero image remains
`1536x1024`; the social card asset uses the common large-card `1200x630` size to avoid relying on
platform-side cropping of the hero artwork.

## Validation

Run the static wrapper smoke check after changing social-preview metadata or image assets:

```bash
node scripts/smoke-wrapper.mjs
```

The smoke script checks:

- `assets/images/social-preview.png` exists and is non-empty.
- The preview PNG dimensions are `1200x630`.
- The canonical URL, OpenGraph tags, Twitter/X tags, image URL, dimensions, type, and alt text match
  this contract.
