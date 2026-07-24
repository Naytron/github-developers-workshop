---
title: "Advanced Module 10 — OIDC Deployments"
---

# Advanced Module 10 — OIDC Deployments

⏱️ **30 minutes** · Optional architect extension · [← Home](../index.md)

## Goals

- Replace long-lived cloud credentials with short-lived OIDC tokens.
- Apply least privilege to both cloud roles and `GITHUB_TOKEN`.
- Understand trust boundaries between GitHub and cloud providers.

## Why this matters

Static cloud secrets are high-risk and hard to rotate. OIDC eliminates stored credentials
in GitHub and issues ephemeral tokens at run time.

## Minimal workflow shape

```yaml
permissions:
  contents: read
  id-token: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      # cloud login action goes here
```

## Exercise

1. Create a cloud workload identity / federated credential for your repo.
2. Scope the trust policy to branch and environment claims.
3. Add `id-token: write` only in deploy jobs.
4. Remove old static cloud secrets from repo/environment settings.

## Validation checklist

- [ ] Deployment succeeds without cloud access keys in GitHub secrets.
- [ ] Trust policy is branch-scoped.
- [ ] Only deploy jobs receive `id-token: write`.
