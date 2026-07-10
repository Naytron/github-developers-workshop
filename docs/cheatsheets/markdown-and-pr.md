---
title: "Cheat Sheet — Markdown & Pull Requests"
---

# Cheat Sheet — Markdown & Pull Requests

[← Home](../index.md)

## Markdown you'll use in issues & PRs

```markdown
# Heading 1
## Heading 2

**bold**  _italic_  `inline code`

- bullet
- list
  - nested

1. numbered
2. list

- [ ] unchecked task
- [x] checked task

> blockquote / callout

[link text](https://example.com)

​```bash
fenced code block with a language
​```

| Col A | Col B |
| ----- | ----- |
| a     | b     |
```

## Linking issues & PRs

| You type | Effect |
| -------- | ------ |
| `#42` | Links to issue/PR 42. |
| `Closes #42` (in a PR) | Auto-closes issue 42 when the PR merges. |
| `Refs #42` (in a commit) | Associates the commit with issue 42. |
| `@username` | Mentions/notifies a person. |
| `@org/team` | Requests a team (see `CODEOWNERS`). |

## A good PR description (template we ship)

```markdown
## What & why
One or two sentences. Closes #42

## Changes
- Bullet the key changes first

## How to test
​```bash
dotnet test
​```

## Checklist
- [x] Focused change matching the issue
- [x] Build succeeds
- [x] Tests pass locally
- [x] Covered by a test
```

## Review comment phrasing

| Instead of | Say |
| ---------- | --- |
| "This is wrong." | "This returns 200 on an unknown permit — should it be 404?" |
| "Bad name." | "Consider `scheduledFor` to match the model field." |
| "Fix everything." | "Blocking: the 400 path is untested. Nit: extra blank line." |

- Mark **blocking** vs. **nit** explicitly.
- Suggest a concrete change; use GitHub **suggestions** for one-liners.

## PR hygiene

- Keep PRs small and focused (ours: one endpoint + a test).
- Read your **own** diff before requesting review.
- Respond to every thread; resolve when addressed.
- Re-request review after pushing fixes.

> 💡 **Copilot Connection:** Copilot can draft PR descriptions and review comments in this
> exact shape. The Copilot workshop shows how; this cheat sheet is the standard to hold
> them to.
