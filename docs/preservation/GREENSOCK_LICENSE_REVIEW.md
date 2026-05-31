# GreenSock License Review

> Public-repo posture for the bundled GreenSock ActionScript source.

_Current as of: 2026-05-30_

---

## Purpose

This note records the licensing posture for `com/greensock/**`, which is preserved as a bundled
third-party dependency for the original DieAI Flash source. It is a project review note, not legal
advice.

## Sources Checked

- Local source notices in `com/greensock/**`, including `TweenLite.as`, `TweenMax.as`,
  `TweenLiteVars.as`, and `BlitMask.as`.
- Official GreenSock ActionScript 3 repository:
  <https://github.com/greensock/GreenSock-AS3>
- GitHub repository metadata for `greensock/GreenSock-AS3`:
  <https://api.github.com/repos/greensock/GreenSock-AS3>
- Current GSAP Standard License:
  <https://gsap.com/community/standard-license/>

## Findings

| Finding                                          | Evidence                                                                                                                                                                                                                                                                                                             | Project posture                                                                                                                                           |
| ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GreenSock is third-party                         | Representative local files include GreenSock copyright notices and terms links, for example `com/greensock/TweenLite.as:300` and `com/greensock/TweenMax.as:527`.                                                                                                                                                    | Do not treat `com/greensock/**` as Michael Chaves-authored code, and do not relicense it under this repo's MIT license.                                   |
| Public AS3 source exists                         | The official `greensock/GreenSock-AS3` repository is public and describes itself as GreenSock's ActionScript 3 libraries for GSAP, TweenLite, TweenMax, and LoaderMax.                                                                                                                                               | Keep the source visible in this preservation repo as third-party bundled source while preserving GreenSock notices and attribution.                       |
| No root license was detected                     | The GitHub API reported `"license": null`, and the official repository root contents were `.gitignore`, `README.md`, `bower.json`, `changelog.txt`, and `src`.                                                                                                                                                       | Do not infer MIT, Apache, or another open-source license from repository visibility alone.                                                                |
| Legacy terms URL changed                         | Local source comments reference `http://www.greensock.com/terms_of_use.html`; a current redirect check ended at `https://gsap.com/terms_of_use.html`, which returned 404.                                                                                                                                            | Prefer linking reviewers to the current GSAP standard-license page plus the local source notices rather than relying on the legacy URL.                   |
| Current GSAP license is permissive for many uses | The current GSAP Standard License grants no-charge use for permitted uses and prohibits removing or altering proprietary notices. The page says commercial usage is covered at no charge.                                                                                                                            | This supports the current no-charge public demo posture, but it is not treated here as a blanket retroactive relicensing of the 2014 AS3 source comments. |
| No bundled Club plugin files found               | A filename scan did not find `DynamicPropsPlugin`, `Physics2DPlugin`, `PhysicsPropsPlugin`, `ThrowPropsPlugin`, `TransformAroundCenterPlugin`, or `TransformAroundPointPlugin` source files. `TweenLiteVars.as` and `TweenMaxVars.as` mention some of those as membership-benefit options in documentation comments. | Do not add or rely on membership-benefit plugin source without a fresh license review.                                                                    |
| DieAI source uses core GreenSock APIs            | `lib/shoot/DieAIDoc.as` imports `com.greensock.*` and `com.greensock.easing.*`, then uses `TweenLite.to(...)` with `Back.easeInOut` during the intro flow.                                                                                                                                                           | Preserve `com/greensock/**` because it is part of the original source/rebuild context.                                                                    |

## Repository License Posture

- The top-level MIT license applies to Michael Chaves-authored portions of this archive unless a file
  says otherwise.
- `com/greensock/**` remains third-party GreenSock ActionScript source and retains the copyright,
  terms, and attribution notices already present in those files.
- `assets/DieAI.swf` is the exported playable artifact and may contain compiled GreenSock code from
  the original Flash build; the repo does not relicense that embedded third-party code.
- Redistribution of the full archive should keep GreenSock notices intact and should not remove or
  alter proprietary notices.
- New use of paid, Club, or membership-benefit GreenSock plugins should not be added without a fresh
  review.
- If the project later removes bundled GreenSock source, the rebuild documentation must explain how to
  restore the exact dependency version before publishing a rebuilt SWF.

## Files Updated By This Review

- [README](../../README.md) now distinguishes the repo MIT license from bundled GreenSock source.
- [LICENSE](../../LICENSE) now includes a third-party source notice.
- [Archive Asset Scope](./ARCHIVE_ASSET_SCOPE.md) now points to this review instead of leaving
  GreenSock licensing as an open active item.
