---
title: "Module 4 — GitHub Actions (CI)"
---

# Module 4 — GitHub Actions (CI)

⏱️ **60 minutes** · Paired lab: [Lab 06 — Author the CI workflow](../labs/lab-06-author-ci-workflow.md) · [← Home](../index.md)

## Goals

- Understand what **GitHub Actions** is and the vocabulary of a workflow.
- Read and author a **continuous integration (CI)** workflow that builds and tests
  CivicPermit on every push and pull request.
- See a **status check** appear on your PR.

## What is CI, and why?

**Continuous integration** means: every change is automatically built and tested, so
problems surface in minutes, on a PR, instead of days later in someone else's branch. CI
turns "it works on my machine" into "it works on a clean machine, every time."

## GitHub Actions vocabulary

| Term | Meaning |
| ---- | ------- |
| **Workflow** | A YAML file in `.github/workflows/` describing automation. |
| **Event** | What triggers it — `push`, `pull_request`, `workflow_dispatch`, `tag`. |
| **Job** | A set of steps that run on one **runner**. |
| **Runner** | The machine that executes a job (we use `ubuntu-latest`). |
| **Step** | A single command (`run:`) or a reusable **action** (`uses:`). |
| **Action** | A packaged, reusable step (e.g., `actions/checkout`). |

## Our CI workflow

Here is `.github/workflows/ci.yml`, annotated:

```yaml
name: CI

on:                       # WHEN it runs
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

permissions:              # LEAST PRIVILEGE — only read the repo
  contents: read

concurrency:              # cancel superseded runs on the same ref
  group: ci-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build-and-test:
    name: Build & Test
    runs-on: ubuntu-latest        # WHERE it runs
    steps:
      - uses: actions/checkout@v4         # get the code
      - uses: actions/setup-dotnet@v4     # install the .NET SDK
        with:
          dotnet-version: '10.0.x'
      - run: dotnet restore
      - run: dotnet build --configuration Release --no-restore
      - run: dotnet test  --configuration Release --no-build --logger "trx;LogFileName=test-results.trx" --results-directory ./TestResults
      - uses: actions/upload-artifact@v4  # save the test results
        if: always()
        with:
          name: test-results
          path: ./TestResults/*.trx
```

### Why these choices?

- **Only GitHub-owned actions.** `actions/checkout`, `actions/setup-dotnet`, and
  `actions/upload-artifact` are maintained by GitHub — safe for locked-down orgs. We use
  **no third-party actions** anywhere in this repo.
- **`permissions: contents: read`.** Grant the least the job needs. CI doesn't write to
  the repo, so it only reads.
- **`--no-restore` / `--no-build`.** Each step reuses the previous step's output — faster
  and it proves the pipeline is wired correctly.
- **`if: always()` on upload.** Save test results even when tests fail, so you can inspect
  them.

## Status checks on the PR

Once `ci.yml` is on your branch and your PR is open, GitHub runs the workflow and shows a
**check** — ✅ or ❌ — right on the PR. In [Module 5](05-branch-protection-and-merge.md)
we make that check **required** so nothing merges red.

## Reading a failed run

- Open the **Actions** tab (or the check on the PR) and expand the failing step.
- The `dotnet test` output names the failing test and the assertion.
- Download the **test-results** artifact for the full `.trx`.

## Common pitfalls

- **Wrong paths.** Workflows run from the repo root; use repo-relative paths.
- **Missing SDK version.** Pin `dotnet-version: '10.0.x'` so the runner matches your app.
- **Over-broad permissions.** Start from `contents: read` and add only what a job needs.
- **Reaching for a Marketplace action.** For build/test/release you don't need one — the
  GitHub-owned actions plus the `dotnet` and `gh` CLIs cover it.

> 💡 **Copilot Connection:** Authoring YAML is a great Copilot use case — it can scaffold
> a workflow and explain each key. We go deep in the Copilot workshop; today you write it
> yourself so you can read (and debug) any workflow you're handed.

## ➡️ Now do the lab

[**Lab 06 — Author the CI workflow**](../labs/lab-06-author-ci-workflow.md)
