---
title: "Cheat Sheet — GitHub Actions YAML"
---

# Cheat Sheet — GitHub Actions YAML

[← Home](../index.md) · Module: [GitHub Actions (CI)](../modules/04-github-actions-ci.md)

## Where workflows live

```
.github/workflows/<name>.yml
```

## Minimal skeleton

```yaml
name: My Workflow      # shown in the Actions tab

on:                    # WHEN it runs
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

permissions:           # LEAST PRIVILEGE
  contents: read

jobs:
  my-job:
    name: My Job       # the check name shown on PRs
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4     # an action (uses:)
      - run: echo "hello"             # a shell command (run:)
```

## Common events (`on:`)

```yaml
on:
  push:
    branches: [ main ]
    tags: [ 'v*.*.*' ]        # e.g., trigger a release on version tags
    paths: [ 'docs/**' ]      # only when matching files change
  pull_request:
    branches: [ main ]
  workflow_dispatch:          # manual "Run workflow" button
```

## GitHub-owned actions used in this repo

| Action | Purpose |
| ------ | ------- |
| `actions/checkout@v4` | Check out the repository. |
| `actions/setup-dotnet@v4` | Install the .NET SDK. |
| `actions/upload-artifact@v4` | Save build/test outputs. |
| `actions/configure-pages@v5` | Configure GitHub Pages. |
| `actions/jekyll-build-pages@v1` | Build the Jekyll site. |
| `actions/upload-pages-artifact@v3` | Package the built site. |
| `actions/deploy-pages@v4` | Deploy to GitHub Pages. |

> This repo uses **only** GitHub-owned actions. For releases we use the `gh` CLI, not a
> third-party action.

## Permissions (grant the least you need)

```yaml
permissions:
  contents: read        # default for CI (read the code)

# For a release job that creates the release:
permissions:
  contents: write

# For the Pages deploy job:
permissions:
  contents: read
  pages: write
  id-token: write
```

## Useful contexts & expressions

```yaml
${{ github.ref }}          # e.g., refs/heads/main
${{ github.ref_name }}     # e.g., v1.1.0 (tag or branch name)
${{ github.sha }}          # commit SHA
${{ github.token }}        # the automatic GITHUB_TOKEN
if: always()               # run a step even if a previous one failed
if: github.event_name == 'push'
```

## Concurrency (avoid redundant runs)

```yaml
concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true
```

## Passing env / secrets to a step

```yaml
- name: Create the release
  env:
    GH_TOKEN: ${{ github.token }}     # gh reads GH_TOKEN
  run: gh release create "${GITHUB_REF_NAME}" --generate-notes
```

## Debugging tips

```bash
gh run list --limit 5      # recent runs
gh run watch               # live-follow the latest run
gh run view --log-failed   # only the failing step's log
```

> 💡 **Copilot Connection:** Copilot is strong at scaffolding and explaining this YAML —
> covered in the Copilot workshop. This sheet is the vocabulary you'll use to check its
> output.
