# Portfolio Link Handoff

> Requirements for adding the future external portfolio-page link to the DieAI case study.

_Current as of: 2026-05-31_

---

## Scope

This note defines when and how to add an external portfolio-site link to
[DieAI Preservation Case Study](./PRESERVATION_CASE_STUDY.md).

It does not create the external portfolio page and does not add the link before the page exists.

## Decision

Keep the external portfolio-site link deferred until a stable public page exists.

The case study is already portfolio-ready inside this repository. The only remaining handoff is to
add a link to the external portfolio page after that page is published, reachable, and consistent with
the current preservation story.

## Required Inputs

Before adding the external link, capture:

| Field | Requirement |
| ----- | ----------- |
| Public URL | Final `https://` URL for the portfolio page. |
| Page title | Human-readable title used by the portfolio page. |
| Owner | Person who published or owns the external page. |
| Link target | The specific section or page that presents DieAI, not only a generic homepage. |
| Backlink expectation | Whether the portfolio page links back to the live demo, repository, or case study. |

## Link Placement

When ready, add the link in three places:

1. [DieAI Preservation Case Study](./PRESERVATION_CASE_STUDY.md), under `Primary Links`.
2. [Project README](../../README.md), in `Notes`, only if the portfolio page is a durable public
   destination rather than a temporary draft.
3. [Future Backlog](../backlog/FUTURE_BACKLOG.md), by removing the deferred external-link row once
   the link is live and validated.

Do not add the link to active backlog as a reminder after this handoff note exists.

## Suggested Copy

Use concise text:

```markdown
- [Portfolio Case Study](https://example.com/path-to-dieai)
```

If the external page is broader than DieAI, use:

```markdown
- [Michael Chaves Portfolio](https://example.com/)
```

Prefer the first form when a DieAI-specific page exists.

## Validation

Before committing the link:

1. Confirm the URL returns `200` over HTTPS.
2. Confirm the page title and visible content identify DieAI.
3. Confirm the page links to at least one stable project target:
   - live demo: `https://mikechaves.github.io/dieai-flash/`;
   - repository: `https://github.com/mikechaves/dieai-flash`;
   - repo case study: `docs/portfolio/PRESERVATION_CASE_STUDY.md`.
4. Confirm the page does not imply a gameplay rewrite, remaster, or new feature that is not in the
   preserved project.
5. Run the markdown local-link checker for repository links.

## Completion Criteria

The future backlog item can be closed only when:

1. the external page is published;
2. the repository links to it from the case study;
3. the link is reachable over HTTPS;
4. the public copy matches the preservation-first project posture;
5. the future backlog row is removed in the same change.
