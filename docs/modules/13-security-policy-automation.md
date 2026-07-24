---
title: "Advanced Module 13 — Security Policy Automation"
---

# Advanced Module 13 — Security Policy Automation

⏱️ **30 minutes** · Optional architect extension · [← Home](../index.md)

## Goals

- Automate repository security baseline controls.
- Turn security posture into continuous checks instead of one-time setup.
- Operationalize policy exceptions with traceability.

## Why this matters

Security controls decay without automation. Teams need repeatable checks that identify
drift in features like Dependabot, code scanning, secret scanning, and policies.

## Baseline automation targets

1. `SECURITY.md` present and current.
2. Dependabot config present for package and Actions ecosystems.
3. Code scanning enabled and producing alerts.
4. Secret scanning and push protection enabled (where plan supports it).
5. Rule and environment checks aligned to deployment criticality.

## Exercise

> ➡️ **Full hands-on lab:** [Lab 13 — Security Policy Automation](../labs/lab-13-security-policy-automation.md) (check the [prerequisites matrix](../guides/advanced-track-prerequisites.md) first).

1. Add a scheduled governance workflow (`workflow_dispatch` + `schedule`).
2. Query repository security settings via `gh api`.
3. Fail or warn when required controls are missing.
4. Publish a status artifact for audit evidence.

## Validation checklist

- [ ] Security policy checks run on a schedule.
- [ ] Findings are visible in workflow logs/artifacts.
- [ ] Missing controls produce actionable output.
