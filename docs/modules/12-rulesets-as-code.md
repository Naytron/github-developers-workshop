---
title: "Advanced Module 12 — Rulesets as Code"
---

# Advanced Module 12 — Rulesets as Code

⏱️ **30 minutes** · Optional architect extension · [← Home](../index.md)

## Goals

- Manage branch and tag protection at org scale with rulesets.
- Version-control governance settings.
- Detect and remediate drift.

## Why this matters

Manual branch settings do not scale across dozens of repositories. Rulesets provide a
single control plane and consistent policy enforcement.

## Recommended controls

- Require pull requests on default branch.
- Require status checks.
- Require signed commits (if your org standard mandates it).
- Require linear history or merge queue (team preference dependent).
- Restrict bypass permissions to a minimal admin set.

## Exercise

1. Create a repository or org ruleset for `main`.
2. Include at least required PR + required status check.
3. Export and save your ruleset JSON in a governance repo.
4. Reapply from JSON in a second repo to prove repeatability.

## Validation checklist

- [ ] Ruleset is active and enforceable.
- [ ] Bypass list is explicit and minimal.
- [ ] Ruleset definition is stored in source control.
