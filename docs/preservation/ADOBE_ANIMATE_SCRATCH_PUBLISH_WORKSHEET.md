# Adobe Animate Scratch Publish Worksheet

> Worksheet for a future Adobe Animate scratch publish of the preserved DieAI FLA.

_Current as of: 2026-05-31_

---

## Scope

This worksheet defines what to capture when testing whether `DieAI.fla` can be opened and published
from Adobe Animate without changing tracked repository assets.

It is not a rebuild guide and it does not authorize replacing `assets/DieAI.swf`. Use it only for a
scratch round trip that writes output to an untracked directory, records evidence, and decides whether
a full rebuild guide is safe to write later.

## Safety Rules

- Start from clean `main`.
- Do not overwrite `assets/DieAI.swf` or `assets/DieAI.html`.
- Publish only to an untracked scratch directory.
- Do not commit generated SWF/HTML output from the scratch pass.
- Treat Adobe Animate as the authoritative opener for `DieAI.fla`; command-line ZIP extraction is
  evidence only because the FLA emits the known central-directory warning.
- Do not write a full rebuild guide until the scratch SWF can be browser-smoked without tracked asset
  changes.

## Baseline Artifact Facts

Use these values to compare the scratch output against the preserved build.

| Artifact            | Expected Value                                                            |
| ------------------- | ------------------------------------------------------------------------- |
| `DieAI.fla`         | SHA-256 `a38a6fa7b614a73c1c710fdd9c69d8e05b0af1dd9d200a94369448b779a093df` |
| `assets/DieAI.swf`  | `3,223,681` bytes, compressed SWF version `37`                             |
| `assets/DieAI.swf`  | SHA-256 `1cb333d6a97c41752e2a76e617921ae5509b5ae6cd33f71bcc33f673e0992f9e` |
| `assets/DieAI.html` | SHA-256 `c1f6e1b8e71a154e7a0aaf05193f874a18551daa2e23fa6138dfbc52e64d121a` |
| Stage               | `1000 x 600`                                                               |
| Frame rate          | `30` fps                                                                   |
| Document class      | `lib.shoot.DieAIDoc`                                                       |
| AS3 package path    | `.`                                                                       |
| External player     | `FlashPlayer26.0`                                                          |
| Flash/SWF version   | `37`                                                                       |
| Publish outputs     | `DieAI.swf`, `DieAI.html`                                                  |

The source-of-truth provenance details live in
[SWF Provenance And Rebuild Notes](./SWF_PROVENANCE.md).

## Environment Capture

Fill this table before opening the FLA.

| Field                         | Value |
| ----------------------------- | ----- |
| Date                          |       |
| Operator                      |       |
| Host OS and version           |       |
| CPU architecture              |       |
| Adobe Animate product version |       |
| Adobe Animate build number    |       |
| Adobe account/license context |       |
| Java runtime visible          |       |
| Repo commit SHA               |       |
| Repo path                     |       |
| Scratch output path           |       |

Preflight commands:

```bash
git status --short --branch
git rev-list --left-right --count HEAD...origin/main
git rev-parse HEAD
file DieAI.fla assets/DieAI.swf assets/DieAI.html
shasum -a 256 DieAI.fla assets/DieAI.swf assets/DieAI.html
```

Required preflight result:

- `main` is clean.
- `HEAD` matches `origin/main`.
- Baseline hashes match the table above.

## Attempt Log - 2026-05-31

Status: blocked before FLA open.

This pass verified the repository and artifact preflight, but it did not open or publish
`DieAI.fla` because Adobe Animate is not installed on this host. This is not a completed scratch
publish pass.

### Environment Captured

| Field                         | Value |
| ----------------------------- | ----- |
| Date                          | `2026-05-31 10:58:56 PDT` |
| Operator                      | `michaelchaves` local checkout user |
| Host OS and version           | macOS `26.6` build `25G5028f` |
| CPU architecture              | `arm64` / Apple M4 Pro |
| Adobe Animate product version | Not available; no Adobe Animate application found. |
| Adobe Animate build number    | Not available. |
| Adobe account/license context | Not tested; Adobe Animate was unavailable. |
| Java runtime visible          | No; `/usr/bin/java` shim exists, but macOS reports no Java runtime installed. |
| Repo commit SHA               | `b93a7ced1858ce93c7ce1d47973c1f060fcc7cbd` |
| Repo path                     | `/Users/michaelchaves/GitHub/dieai-flash` |
| Scratch output path           | `/tmp/dieai-animate-scratch-publish-20260531` |

### Preflight Result

| Check | Result | Notes |
| ----- | ------ | ----- |
| Clean `main` | Pass | `git status --short --branch` showed `## main...origin/main`. |
| Local/remote sync | Pass | `git rev-list --left-right --count HEAD...origin/main` returned `0 0`. |
| `DieAI.fla` hash | Pass | SHA-256 matched `a38a6fa7b614a73c1c710fdd9c69d8e05b0af1dd9d200a94369448b779a093df`. |
| `assets/DieAI.swf` hash | Pass | SHA-256 matched `1cb333d6a97c41752e2a76e617921ae5509b5ae6cd33f71bcc33f673e0992f9e`. |
| `assets/DieAI.html` hash | Pass | SHA-256 matched `c1f6e1b8e71a154e7a0aaf05193f874a18551daa2e23fa6138dfbc52e64d121a`. |
| File types | Pass | FLA reported as ZIP archive data; SWF reported as compressed Flash data version `37`; HTML reported as UTF-8 with BOM. |
| Scratch directory | Pass | `/tmp/dieai-animate-scratch-publish-20260531` was created outside the repo. |

### Tool Availability

| Check | Result | Notes |
| ----- | ------ | ----- |
| Adobe Animate app search | Blocked | No Animate or Flash application was found under `/Applications`, `~/Applications`, or Spotlight application metadata. |
| Flash/Flex/AIR CLI tools | Blocked | `animate`, `Animate`, `flashplayer`, `mxmlc`, `compc`, `adl`, `adt`, and `swfdump` were not found on `PATH`. |
| Java runtime | Blocked | `/usr/bin/java` exists only as the macOS shim and reported that no Java runtime is installed. |

### Command-Line Publish Settings Cross-Check

The ZIP-backed FLA still emits the known 54-byte central-directory warning under `unzip`, but
`PublishSettings.xml` remained readable for inspection.

| Setting              | Observed Value                          | Result |
| -------------------- | --------------------------------------- | ------ |
| SWF output name      | `DieAI.swf`                             | Pass |
| HTML output name     | `DieAI.html`                            | Pass |
| Width / height       | `1000 x 600`                            | Pass |
| Flash/SWF version    | `37`                                    | Pass |
| External player      | `FlashPlayer26.0`                       | Pass |
| ActionScript version | `3`                                     | Pass |
| Document class       | `lib.shoot.DieAIDoc`                    | Pass |
| AS3 source path      | `.`                                     | Pass |
| Compress movie       | `1`                                     | Pass |
| Use network          | `0`                                     | Pass |
| HTML template        | Adobe Animate CC 2018 default HTML path | Pass |

### Blocked Checks

| Check | Result | Notes |
| ----- | ------ | ----- |
| FLA open result | Blocked | Adobe Animate was unavailable, so `DieAI.fla` was not opened. |
| Animate UI publish settings comparison | Blocked | Cannot compare Animate UI settings without Adobe Animate. |
| Scratch SWF/HTML output | Blocked | No scratch publish occurred; no SWF or HTML output was generated. |
| Scratch SWF browser smoke | Blocked | No scratch SWF exists to test through Ruffle. |
| Tracked-file cleanliness after attempt | Pass | No tracked game assets changed during the preflight-only attempt. |

### Decision

Keep the full rebuild guide deferred. The next scratch-publish attempt requires a machine with Adobe
Animate installed and licensed. Resume this worksheet from the FLA open check after confirming the
app can open `DieAI.fla` and publish to the untracked scratch directory above or a fresh equivalent
outside the repository.

## FLA Open Check

Record the result before publishing anything.

| Check                                             | Result | Notes |
| ------------------------------------------------- | ------ | ----- |
| `DieAI.fla` opens without repair prompt           |        |       |
| If repair prompt appears, exact text saved        |        |       |
| Library panel loads expected folders              |        |       |
| Timeline opens without missing media error        |        |       |
| Document class still shows `lib.shoot.DieAIDoc`   |        |       |
| Stage shows `1000 x 600`                          |        |       |
| Frame rate shows `30` fps                         |        |       |
| Source paths can resolve repo files               |        |       |

If Animate rewrites or prompts to save the FLA on open, cancel the save and record the prompt. Do not
commit any changed authoring file.

## Publish Settings Check

Compare Animate's UI against the stored `PublishSettings.xml` values.

| Setting              | Expected Value               | Observed Value | Pass/Fail | Notes |
| -------------------- | ---------------------------- | -------------- | --------- | ----- |
| SWF output name      | `DieAI.swf`                  |                |           |       |
| HTML output name     | `DieAI.html`                 |                |           |       |
| Width / height       | `1000 x 600`                 |                |           |       |
| Flash/SWF version    | `37`                         |                |           |       |
| External player      | `FlashPlayer26.0`            |                |           |       |
| ActionScript version | `3`                          |                |           |       |
| Document class       | `lib.shoot.DieAIDoc`         |                |           |       |
| AS3 source path      | `.`                          |                |           |       |
| Compress movie       | `1` / enabled                |                |           |       |
| Use network          | `0` / disabled               |                |           |       |
| HTML template        | Animate CC 2018 default HTML |                |           |       |

Command-line cross-check:

```bash
unzip -p DieAI.fla PublishSettings.xml \
  | rg "DocumentClass|Version>|ExternalPlayer|ActionScriptVersion|AS3PackagePaths|Width>|Height>|CompressMovie|UseNetwork"
```

## Scratch Publish Procedure

1. Create an untracked scratch directory outside the repo, for example:

   ```bash
   SCRATCH_ROOT=/tmp/dieai-animate-scratch-publish-YYYYMMDD
   rm -rf "$SCRATCH_ROOT"
   mkdir -p "$SCRATCH_ROOT"
   ```

2. In Adobe Animate, set the publish output path to the scratch directory.
3. Confirm source path `.` resolves from the repo root so `lib/shoot/**` and `com/greensock/**`
   compile.
4. Publish SWF and HTML.
5. Do not save changes to `DieAI.fla` unless a separate preservation decision approves that.
6. Return to the shell and record the scratch output.

## Scratch Output Capture

Run:

```bash
find "$SCRATCH_ROOT" -maxdepth 2 -type f -print | sort
file "$SCRATCH_ROOT"/*
stat -f '%N|%z|%Sm' -t '%Y-%m-%d %H:%M:%S %Z' "$SCRATCH_ROOT"/*
shasum -a 256 "$SCRATCH_ROOT"/*
```

Fill this table:

| Output File | Bytes | File Type | SHA-256 | Notes |
| ----------- | ----- | --------- | ------- | ----- |
|             |       |           |         |       |

Comparison:

| Check                                      | Result | Notes |
| ------------------------------------------ | ------ | ----- |
| Scratch SWF exists                         |        |       |
| Scratch HTML exists                        |        |       |
| Scratch SWF is compressed Flash data       |        |       |
| Scratch SWF reports version `37`           |        |       |
| Scratch SWF byte size compared to baseline |        |       |
| Scratch SWF SHA-256 compared to baseline   |        |       |
| No tracked files changed                   |        |       |

If the scratch SWF hash differs, that is not automatically a failure. Animate may rewrite metadata
while preserving behavior. Treat behavior and publish settings as the next decision gate.

## Browser Smoke Evidence

Test the scratch SWF through the modern wrapper without replacing tracked files.

Suggested temporary approach:

1. Copy the repository to a throwaway directory or serve a temporary wrapper variant from `/tmp`.
2. Point the wrapper's `SWF_URL` at the scratch SWF.
3. Serve over local HTTP, not `file://`.
4. Run the manual checks from [Browser Smoke Checklist](../backlog/BROWSER_SMOKE_CHECKLIST.md).

Record:

| Check                         | Result | Notes |
| ----------------------------- | ------ | ----- |
| Local HTTP wrapper loads      |        |       |
| Ruffle initializes scratch SWF |       |       |
| Start screen appears          |        |       |
| Intro can be skipped          |        |       |
| `A` moves left                |        |       |
| `D` moves right               |        |       |
| `Space` fires                 |        |       |
| Game-over or win state works  |        |       |
| Console has no wrapper errors |        |       |
| Responsive layout unchanged   |        |       |

Evidence to save outside git:

- browser name and version;
- local URL;
- screenshots or screen recording;
- console warnings/errors;
- network failures, if any;
- scratch SWF hash and byte size.

## Decision After The Scratch Pass

| Outcome                                                       | Next Step |
| ------------------------------------------------------------- | --------- |
| FLA cannot open                                               | Keep full rebuild guide deferred; document the opener error. |
| Publish settings differ unexpectedly                          | Keep full rebuild guide deferred; decide whether settings should be corrected or documented. |
| Publish succeeds but scratch SWF fails browser smoke          | Keep full rebuild guide deferred; record runtime failure evidence. |
| Publish succeeds and scratch SWF passes browser smoke         | Write a full rebuild guide as a future task; do not replace tracked SWF unless separately approved. |
| Publish succeeds and scratch SWF matches the tracked SWF hash | Record the exact toolchain as the preferred rebuild environment. |

## Completion Criteria

This worksheet is complete when it captures:

1. Animate version and host OS;
2. FLA open result;
3. publish settings comparison;
4. scratch output file list, sizes, hashes, and warnings;
5. browser-smoke evidence against the scratch SWF;
6. tracked-file cleanliness after the test;
7. decision on whether a full rebuild guide can be written.
