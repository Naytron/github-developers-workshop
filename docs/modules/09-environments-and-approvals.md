---
title: "Advanced Module 9 — Environments & Approvals"
---

# Advanced Module 9 — Environments & Approvals

⏱️ **30 minutes** · Optional architect extension · [← Home](../index.md)

## Goals

- Design environment promotion with explicit approval gates.
- Separate secrets and deployment permissions by environment.
- Enforce branch-to-environment mapping.

## Why this matters

Most incidents happen at promotion boundaries. Environment protections in GitHub give you
an auditable gate between build success and production access.

## Recommended baseline

1. Create `dev`, `staging`, and `production` environments.
2. Put environment-specific secrets in each environment, not repo-level secrets.
3. Require reviewers for `production`.
4. Restrict `production` deployments to `main` only.

## Exercise

> ➡️ **Full hands-on lab:** [Lab 9 — Environments & Approvals](../labs/lab-09-environments-and-approvals.md) (check the [prerequisites matrix](../guides/advanced-track-prerequisites.md) first).

1. Open **Settings → Environments**.
2. Add `staging` and `production`.
3. Add required reviewers to `production`.
4. In your deploy workflow, set:

```yaml
jobs:
  deploy-production:
    if: github.ref == 'refs/heads/main'
    environment:
      name: production
```

5. Trigger a test run and confirm the approval gate appears.

## Validation checklist

- [ ] Production job pauses for approval.
- [ ] Environment secrets are not duplicated at repo level.
- [ ] Production deploy is blocked from non-`main` branches.
