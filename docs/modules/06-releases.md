---
title: "Module 6 — Releases"
---

# Module 6 — Releases

⏱️ **30 minutes** · Paired lab: [Lab 08 — Cut a release](../labs/lab-08-cut-a-release.md) · [← Home](../index.md)

## Goals

- Understand **tags** vs. **releases**.
- Cut a release for the merged feature using the **GitHub CLI**.
- (Optional) See how a release can be automated with a workflow.

## Tags vs. releases

- A **tag** is a permanent Git pointer to a specific commit — a bookmark like `v1.1.0`.
- A **release** is a GitHub object built *on top of* a tag: it adds a title, notes, and
  optional downloadable assets.

You tag the exact commit you shipped, then publish a release so others can find and
consume that known-good version.

## Semantic Versioning (SemVer)

Version numbers follow `MAJOR.MINOR.PATCH`:

| Part | Bump when… | Example |
| ---- | ---------- | ------- |
| **MAJOR** | You make a breaking change | `2.0.0` |
| **MINOR** | You add functionality, backward-compatible | `1.1.0` |
| **PATCH** | You make a backward-compatible bug fix | `1.0.1` |

Our baseline app is `v1.0.0`. Adding the inspection endpoint is a backward-compatible
feature, so it ships as **`v1.1.0`**.

## Cutting a release with `gh`

We use the **GitHub CLI** rather than any third-party release action — it's pre-installed
on runners and available on your machine:

```bash
# Create tag v1.1.0 on the current commit, publish a release, and
# auto-generate notes from merged PRs since the last release.
gh release create v1.1.0 \
  --title "CivicPermit v1.1.0" \
  --generate-notes
```

`--generate-notes` reads merged PRs (like your inspection PR) to draft the changelog —
another reason good PR titles pay off.

### Attaching a build artifact (optional)

```bash
dotnet publish src/CivicPermit.Api -c Release -o ./publish
cd publish && zip -r ../CivicPermit.Api-v1.1.0.zip . && cd ..

gh release create v1.1.0 CivicPermit.Api-v1.1.0.zip \
  --title "CivicPermit v1.1.0" \
  --generate-notes
```

## Automating releases (optional)

Our repo includes `.github/workflows/release.yml`, which triggers on a pushed `v*.*.*`
tag, publishes the app, and runs `gh release create` for you:

```yaml
on:
  push:
    tags: [ 'v*.*.*' ]
permissions:
  contents: write        # needed to create the release
```

So you can either run `gh release create` by hand (the lab) **or** just push a tag and let
the workflow do it. Both use only GitHub-owned tooling.

## Common pitfalls

- **Tagging the wrong commit.** Make sure your feature is **merged to `main`** and you've
  pulled, so the tag lands on the right commit.
- **Re-using a tag.** Tags are meant to be immutable; pick the next version instead.
- **Missing `contents: write`** in an automated release workflow — `gh release create`
  will fail without it.

> 💡 **Copilot Connection:** Copilot can help you draft human-friendly release notes from
> your changes. We explore that in the Copilot workshop; today `--generate-notes` gives
> you a solid, automatic baseline.

## ➡️ Now do the lab

[**Lab 08 — Cut a release**](../labs/lab-08-cut-a-release.md)
