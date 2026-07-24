---
title: "Advanced Module 11 — Reusable Workflows"
---

# Advanced Module 11 — Reusable Workflows

⏱️ **30 minutes** · Optional architect extension · [← Home](../index.md)

## Goals

- Standardize CI/CD across repositories with reusable workflows.
- Reduce copy/paste YAML drift.
- Keep policy controls centralized while preserving team autonomy.

## Why this matters

When every repo has hand-edited pipeline YAML, quality and security controls drift over
time. Reusable workflows let you enforce a single baseline.

## Pattern

1. Create a reusable workflow with `on: workflow_call`.
2. Define explicit `inputs` and `secrets`.
3. Call it from application repos.

```yaml
jobs:
  ci:
    uses: your-org/platform-workflows/.github/workflows/dotnet-ci.yml@main
    with:
      dotnet-version: "10.0.x"
```

## Exercise

> ➡️ **Full hands-on lab:** [Lab 12 — Reusable Workflows](../labs/lab-12-reusable-workflows.md) (check the [prerequisites matrix](../guides/advanced-track-prerequisites.md) first).

1. Move your build+test logic into one reusable workflow.
2. Call it from the workshop repo.
3. Add one required input and one optional input.
4. Verify the caller workflow stays small and readable.

## Validation checklist

- [ ] At least one workflow uses `workflow_call`.
- [ ] Shared logic no longer duplicated across files.
- [ ] Inputs/secrets are explicit and documented.
