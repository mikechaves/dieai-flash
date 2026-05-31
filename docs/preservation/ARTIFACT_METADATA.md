# Artifact Metadata

> Checksum and size manifest for DieAI preservation audits.

_Current as of: 2026-05-31_

---

## Purpose

This note records the current repository artifact metadata needed to verify the preserved Flash
build, original source files, wrapper-critical assets, and supporting preservation evidence.

The hashes below are SHA-256 values from the current preservation artifact set. Temporary QA
screenshots, browser traces, local generated output, and this note itself are intentionally excluded.

## Artifact Set Manifest

| Scope            | Files | Bytes      | Manifest SHA-256                                                   |
| ---------------- | ----- | ---------- | ------------------------------------------------------------------ |
| Preservation set | `145` | `59129200` | `403431afcb6bb69919801df556d0e5ffb0ae75389391ee4866e5fc6b4c141b1a` |

The preservation set covers the core artifacts listed below plus `lib/shoot`, `com/greensock`, and
`assets/images`. Its manifest is the SHA-256 of sorted per-file SHA-256 lines for that set.

## Core Artifacts

| Artifact                              | Bytes      | File type                                      | SHA-256                                                            | Role                                          |
| ------------------------------------- | ---------- | ---------------------------------------------- | ------------------------------------------------------------------ | --------------------------------------------- |
| `DieAI.fla`                           | `50392143` | Zip archive data                               | `a38a6fa7b614a73c1c710fdd9c69d8e05b0af1dd9d200a94369448b779a093df` | Original Adobe Animate / Flash authoring file |
| `assets/DieAI.swf`                    | `3223681`  | Macromedia Flash data (compressed), version 37 | `1cb333d6a97c41752e2a76e617921ae5509b5ae6cd33f71bcc33f673e0992f9e` | Playable build loaded by Ruffle               |
| `assets/DieAI.html`                   | `2018`     | HTML document text, UTF-8 with BOM             | `c1f6e1b8e71a154e7a0aaf05193f874a18551daa2e23fa6138dfbc52e64d121a` | Legacy Flash embed output                     |
| `index.html`                          | `27780`    | HTML document text, ASCII text                 | `8a4df5c2e867365862656ef775e1a3c115a6233aedf1b4eaf7536751c6beb4f6` | Modern Ruffle wrapper                         |
| `docs/Chaves_rhetoricalAnalysis.docx` | `21012`    | Microsoft Word 2007+                           | `dd925df8dbecaba8abbf3acbf392a6f57ef75f64ab42c9491ffe367b942322cd` | Supporting historical project document        |

## Tree Manifests

These tree manifests use sorted file paths. Each manifest hash is the SHA-256 of the newline-delimited
`shasum -a 256` output for that tree.

| Tree            | Files | Bytes     | Manifest SHA-256                                                   | Notes                                      |
| --------------- | ----- | --------- | ------------------------------------------------------------------ | ------------------------------------------ |
| `lib/shoot`     | `4`   | `19857`   | `05f5130e671bb9e85de2864d41e4229dc525aa23ff3295e50b08936bd13b902b` | Original ActionScript game source          |
| `com/greensock` | `129` | `1944599` | `2ee13a708081a0ad43304337af53e03f8805ddcc6e277c683cb338a64fa98b65` | Bundled ActionScript GreenSock dependency  |
| `assets/images` | `7`   | `3498110` | `2d6f8c6add3c6ebad6948b263504ce4e9dbe356edc43cc50f144a58517f21f7c` | Wrapper screenshots and promotional images |

## ActionScript Source Files

| File                     | Bytes   | SHA-256                                                            |
| ------------------------ | ------- | ------------------------------------------------------------------ |
| `lib/shoot/DieAIDoc.as`  | `1692`  | `f1ffb15b2429f9782cbdf59e8e524d7b844a8c0a266459a6a630f36f2d9fdc9e` |
| `lib/shoot/DieAIGame.as` | `14616` | `81c452d34cdbe199a3517ab0017fdbf504429ea5d33da54ea18fbeed1c25032c` |
| `lib/shoot/Particle.as`  | `560`   | `a53c15575e4e6cc107f7230c3ec1a6b214e28482227d3f80d450a1fd195183e7` |
| `lib/shoot/Robot.as`     | `2989`  | `8da53c09c88380ad28ac3e4ba53a02d4690fd25792ca891a7b3ad143325f49f9` |

## Wrapper Images

| File                               | Bytes     | SHA-256                                                            |
| ---------------------------------- | --------- | ------------------------------------------------------------------ |
| `assets/images/game-over.png`      | `28951`   | `6b916983c43fe38ba17cacaebe5f378437a60820bbdcbff5d00456d7dc779b63` |
| `assets/images/intro-good.png`     | `42411`   | `dc62a5132392068b04f872c9367927a3d409493a8fd6642ef429baa848781c3e` |
| `assets/images/intro-hacked.png`   | `45533`   | `2737c10e2199d827ce4c25966195d8aa9c15b7e097512cdcfe4cce955e8eff7e` |
| `assets/images/level-one.png`      | `67802`   | `d6e094512d972461d5e3a2d2b7b945c51ae093eec710bad808c078cb6932dabe` |
| `assets/images/main-image.png`     | `2186182` | `b7c17616476ba74f9565747743402c11e9924902aedf9ca8573cd1d6321e9c54` |
| `assets/images/social-preview.png` | `1093217` | `1d06b65a4ac502a4f59fdb86d00a20a4a06520d4398850a125e947e04c61d82c` |
| `assets/images/start-screen.png`   | `34014`   | `3c81fc707c66eb98fc4e311aa2cca3a1013cdb3ac7c831bab7e8c3effa60fabb` |

## Publish Metadata Cross-Check

`assets/DieAI.swf` is `3,223,681` bytes. `DieAI.fla` contains a publish-history entry with
`publishSize="3223681"` and `publishTime="1540935999"` (`2018-10-30T21:46:39Z`), matching the
tracked playable SWF size.

The FLA publish settings still report:

| Setting              | Value                |
| -------------------- | -------------------- |
| Flash version        | `37`                 |
| External player      | `FlashPlayer26.0`    |
| ActionScript version | `3`                  |
| AS3 package paths    | `.`                  |
| Document class       | `lib.shoot.DieAIDoc` |

## Audit Commands

Run these from the repository root to regenerate the metadata above.

```bash
file DieAI.fla assets/DieAI.swf assets/DieAI.html index.html docs/Chaves_rhetoricalAnalysis.docx
shasum -a 256 DieAI.fla assets/DieAI.swf assets/DieAI.html index.html docs/Chaves_rhetoricalAnalysis.docx
stat -f '%N|%z|%Sm' -t '%Y-%m-%d %H:%M:%S %Z' DieAI.fla assets/DieAI.swf assets/DieAI.html index.html docs/Chaves_rhetoricalAnalysis.docx
```

```bash
for dir in lib/shoot com/greensock assets/images; do
  count=$(find "$dir" -type f | wc -l | tr -d ' ')
  bytes=$(find "$dir" -type f -exec stat -f '%z' {} + | awk '{s+=$1} END {print s+0}')
  digest=$(find "$dir" -type f | sort | while IFS= read -r file; do shasum -a 256 "$file"; done | shasum -a 256 | awk '{print $1}')
  echo "$dir|$count|$bytes|$digest"
done
```

```bash
{ printf '%s\n' DieAI.fla assets/DieAI.swf assets/DieAI.html index.html docs/Chaves_rhetoricalAnalysis.docx; find lib/shoot com/greensock assets/images -type f; } | sort | while IFS= read -r file; do shasum -a 256 "$file"; done | shasum -a 256
unzip -p DieAI.fla PublishSettings.xml | rg "DocumentClass|Version>|ExternalPlayer|ActionScriptVersion|AS3PackagePaths"
```

## Notes

- File modification times in a local checkout are useful for detecting local drift, but they are not
  original creation dates. Prefer embedded FLA publish metadata for historical dating.
- The accessible Markdown transcription for `docs/Chaves_rhetoricalAnalysis.docx` lives at
  [Historical Rhetorical Analysis Markdown](../historical/CHAVES_RHETORICAL_ANALYSIS.md).
- `DieAI.fla` emits the ZIP central-directory warning documented in
  [SWF Provenance And Rebuild Notes](./SWF_PROVENANCE.md). Automated extraction still reads the
  publish settings used above, but Adobe Animate remains the authoritative opener.
- Asset classes and review scope are documented in
  [Archive Asset Scope](./ARCHIVE_ASSET_SCOPE.md).
- Bundled GreenSock source licensing posture is documented in
  [GreenSock License Review](./GREENSOCK_LICENSE_REVIEW.md).
- Ruffle runtime bytes are not tracked in this repo. The pinned CDN runtime decision is documented in
  [Ruffle Runtime Decision](./RUFFLE_RUNTIME_DECISION.md).
