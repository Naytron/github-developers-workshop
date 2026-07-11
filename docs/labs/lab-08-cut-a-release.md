---
title: "Lab 08 — Cut a Release"
---

# Lab 08 — Cut a Release

⏱️ ~20 min · Module: [Releases](../modules/06-releases.md) · [← Home](../index.md)

**Goal:** tag the merged feature and publish a GitHub Release with the GitHub CLI.

> This is the **Release** step — the finish line of our story. Work from an up-to-date
> `main` that contains your merged feature.

## Step 1 — Make sure `main` is current

```bash
git switch main
git pull
git log --oneline -3   # you should see your squashed feature commit
dotnet test            # sanity check: Passed: 8
```

## Step 2 — Cut the release

Our baseline app is `v1.0.0`; adding a backward-compatible feature makes this **`v1.1.0`**
(see SemVer in [Module 6](../modules/06-releases.md)).

```bash
gh release create v1.1.0 \
  --title "CivicPermit v1.1.0" \
  --generate-notes
```

- This creates the **tag** `v1.1.0` on the current commit and publishes a **release**.
- `--generate-notes` drafts the changelog from merged PRs — including your inspection PR.

## Step 3 — (Optional) Attach a build artifact

Ship a runnable build alongside the notes:

```bash
dotnet publish src/CivicPermit.Api -c Release -o ./publish
cd publish && zip -r ../CivicPermit.Api-v1.1.0.zip . && cd ..

gh release upload v1.1.0 CivicPermit.Api-v1.1.0.zip
```

> **On Windows?** `zip` isn't installed by default. Use PowerShell's `Compress-Archive`
> in place of the `zip` line:
>
> ```powershell
> dotnet publish src/CivicPermit.Api -c Release -o ./publish
> Compress-Archive -Path ./publish/* -DestinationPath CivicPermit.Api-v1.1.0.zip
> gh release upload v1.1.0 CivicPermit.Api-v1.1.0.zip
> ```

(Or attach it at creation time by adding the zip path to `gh release create`.)

## Step 4 — Verify the release

```bash
gh release view v1.1.0
gh release view v1.1.0 --web
gh release list
```

`gh release list` shows something like:

```text
TITLE               TYPE    TAG NAME  PUBLISHED
CivicPermit v1.1.0  Latest  v1.1.0    about 1 minute ago
```

You should see **CivicPermit v1.1.0** with auto-generated notes (and your asset, if you
uploaded one).

## Step 5 — (Optional) See release automation

The repo also ships `.github/workflows/release.yml`, which does all of the above whenever
you push a `v*.*.*` tag. Try it with the next version:

```bash
git tag v1.1.1
git push origin v1.1.1
gh run watch          # watch the Release workflow build & publish
```

Both paths — manual `gh` and the tag-triggered workflow — use only GitHub-owned tooling.

## ✅ Checkpoint

- [ ] `gh release view v1.1.0` shows a published release.
- [ ] The notes mention your inspection PR.
- [ ] (Optional) an artifact is attached, or the release workflow published a version.

## Troubleshooting

- **`tag already exists`** → pick the next version (`v1.1.1`).
- **Release notes are empty** → make sure the feature was merged as a PR into `main` before
  tagging.
- More in [Troubleshooting](../troubleshooting.md).

## 🎉 You did it

You carried one feature through the entire workflow:

```
Issue → Branch → Commit → Pull Request → Review → Workflow → Merge → Release
```

> 💡 **Copilot Connection:** Copilot can polish release notes into customer-friendly prose.
> The Copilot workshop shows how; `--generate-notes` is your automatic baseline today.

## ➡️ Next

[**Lab 09 — Secure the repository**](lab-09-secure-development.md)
