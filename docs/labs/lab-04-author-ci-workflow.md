---
title: "Lab 4 — Author the CI Workflow"
---

# Lab 4 — Author the CI Workflow

⏱️ ~40 min · Module: [GitHub Actions (CI)](../modules/04-github-actions-ci.md) · [← Home](../index.md)

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
  workflow_dispatch:        # lets you start a run by hand — no push required

permissions:
  contents: read

concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build-and-test:
    name: Build & Test (CivicPermit)
    runs-on: ubuntu-latest
    steps:
      - name: Check out the code
        uses: actions/checkout@v7

      - name: Set up the .NET SDK
        uses: actions/setup-dotnet@v6
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
        uses: actions/upload-artifact@v7
        with:
          name: test-results
          path: ./TestResults/*.trx
          if-no-files-found: warn
```

> 💡 **Why `workflow_dispatch`?** The `push`/`pull_request` triggers cover normal work, but
> `workflow_dispatch` adds a **Run workflow** button in the Actions tab (and a
> `gh workflow run` command) so you can re-run CI on demand — handy for testing the workflow
> itself without inventing a code change to push. You'll use it in Step 2.

## Step 2 — Trigger CI by hand (workflow_dispatch)

Because the workflow now has a `workflow_dispatch` trigger, you can start a run **without
pushing anything**. Make sure the branch carrying the workflow is pushed, then:

```bash
gh workflow run CI --ref <your-branch>   # queue a manual run
gh run watch                             # live-follow it (Ctrl+C to stop)
```

You can also click **Actions → CI → Run workflow** in the browser and pick your branch.
This is the fastest way to exercise a workflow while you're still building it — no code
change required.

> 🖥️ `gh run watch` follows the most recent run. If several are queued, grab the id from
> `gh run list --workflow CI --limit 5` and pass it: `gh run watch <run-id>`.

## Step 3 — Make a deliberate change and watch CI run

Let's make a small, safe change so we can watch a fresh run — we'll rename a **step**
(not the job). Edit `.github/workflows/ci.yml` and change the test step's display name:

```yaml
      - name: Run the tests
```

> ⚠️ **Don't rename the job.** The job's `name:` (`Build & Test (CivicPermit)`) is the
> **status-check name** you'll require in Lab 5. Renaming the job creates a *new* check
> context and can strand the required check on every open PR. Renaming a **step** is safe.

Commit and push on your feature branch:

```bash
git add .github/workflows/ci.yml
git commit -m "ci: clarify the test step name

Refs #<issue-number>"
git push
```

## Step 4 — See the check on your PR

```bash
gh pr checks           # lists the checks and their status
gh run list --limit 5  # recent workflow runs
gh run watch           # live-follow the latest run (Ctrl+C to stop)
```

Open the PR to see the ✅/❌ **Build & Test (CivicPermit)** check:

```bash
gh pr view --web
```

## Step 5 — (Optional) Break it on purpose, then fix it

Great way to see CI earn its keep:

1. In a test, change an expected value so it fails (e.g., assert `PermitId == 2`).
2. Commit and push — watch the check go ❌ and read the failing step.
3. Revert the change, push — watch it go ✅ again.

```bash
gh run view --log-failed   # jump straight to the failing log
```

> 💡 **CLI tip:** `gh run rerun --failed` re-runs only the failed jobs, and
> `gh workflow view CI --web` opens the workflow's run history in the browser.

## ✅ Checkpoint

- [ ] Actions is enabled and `gh workflow list` shows the **CI** workflow.
- [ ] You started a run **manually** with `gh workflow run CI` (or the **Run workflow** button).
- [ ] Your push triggered a run (`gh run list`).
- [ ] `gh pr checks` shows **Build & Test (CivicPermit)** with a status.
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

[**Lab 5 — Branch protection & merge**](lab-05-branch-protection-and-merge.md)
