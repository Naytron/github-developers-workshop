---
title: "Lab 06 — Author the CI Workflow"
---

# Lab 06 — Author the CI Workflow

⏱️ ~35 min · Module: [GitHub Actions (CI)](../modules/04-github-actions-ci.md) · [← Home](../index.md)

**Goal:** ensure a CI workflow builds and tests CivicPermit on every push and PR, and see
a **status check** appear on your pull request.

> This is the **Workflow** step. It uses **only GitHub-owned actions**.

## Step 0 — Enable Actions on your repo/fork

If you **forked** the workshop repo, GitHub disables Actions by default. Enable it:

```bash
gh workflow list     # if this errors with "Actions disabled", enable it in the browser:
gh repo view --web   # → Settings → Actions → General → "Allow all actions" → Save
```

(In a shared org repo, Actions is usually already enabled — `gh workflow list` will show
the workflows.)

## Step 1 — Review (or create) the workflow

This repository ships the workflow at `.github/workflows/ci.yml`. Open it and read it
against [Module 4](../modules/04-github-actions-ci.md).

If you're working in a repo that **doesn't** have it yet, create it now with exactly this
content:

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

permissions:
  contents: read

concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build-and-test:
    name: Build & Test
    runs-on: ubuntu-latest
    steps:
      - name: Check out the code
        uses: actions/checkout@v4

      - name: Set up the .NET SDK
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '10.0.x'

      - name: Restore dependencies
        run: dotnet restore

      - name: Build
        run: dotnet build --configuration Release --no-restore

      - name: Test
        run: >
          dotnet test
          --configuration Release
          --no-build
          --logger "trx;LogFileName=test-results.trx"
          --results-directory ./TestResults

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: test-results
          path: ./TestResults/*.trx
          if-no-files-found: warn
```

## Step 2 — Make a deliberate change and watch CI run

Let's make the job name clearer so we can see a fresh run. Edit `.github/workflows/ci.yml`
and change the job's display name:

```yaml
    name: Build & Test (CivicPermit)
```

Commit and push on your feature branch:

```bash
git add .github/workflows/ci.yml
git commit -m "ci: clarify CI job display name

Refs #<issue#>"
git push
```

## Step 3 — See the check on your PR

```bash
gh pr checks           # lists the checks and their status
gh run list --limit 5  # recent workflow runs
gh run watch           # live-follow the latest run (Ctrl+C to stop)
```

Open the PR to see the ✅/❌ **Build & Test (CivicPermit)** check:

```bash
gh pr view --web
```

## Step 4 — (Optional) Break it on purpose, then fix it

Great way to see CI earn its keep:

1. In a test, change an expected value so it fails (e.g., assert `PermitId == 2`).
2. Commit and push — watch the check go ❌ and read the failing step.
3. Revert the change, push — watch it go ✅ again.

```bash
gh run view --log-failed   # jump straight to the failing log
```

## ✅ Checkpoint

- [ ] Actions is enabled and `gh workflow list` shows the **CI** workflow.
- [ ] Your push triggered a run (`gh run list`).
- [ ] `gh pr checks` shows **Build & Test** with a status.
- [ ] You can open the run and read a step's log.

## Troubleshooting

- **No runs appear** → Actions disabled on a fork (Step 0), or the workflow isn't on the
  branch you pushed.
- **`setup-dotnet` fails** → confirm `dotnet-version: '10.0.x'`.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** Copilot is excellent at scaffolding and explaining workflow
> YAML. The Copilot workshop goes deep; authoring it here means you can read and debug any
> workflow you inherit.

## ➡️ Next

[**Lab 07 — Branch protection & merge**](lab-07-branch-protection-and-merge.md)
