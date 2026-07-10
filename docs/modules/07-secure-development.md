---
title: "Module 7 — Secure Development"
---

# Module 7 — Secure Development

⏱️ **45 minutes** · Paired lab: [Lab 09 — Secure the repository](../labs/lab-09-secure-development.md) · [← Home](../index.md)

## Goals

- Turn on GitHub's built-in security features for the CivicPermit repo.
- Understand what **Dependabot**, **secret scanning**, and **code scanning** each protect
  against.
- See how these features reinforce the same Issue → PR → Review → Merge loop.

## Security is part of the workflow, not a bolt-on

Everything you learned today — issues, PRs, required checks — is exactly how security
findings get fixed. A vulnerable dependency becomes a **Dependabot PR**; a scanning result
becomes an **alert** you triage and fix on a branch. Same loop, safety built in.

## The three pillars (GitHub-native, no third-party tools)

### 1. Dependabot — vulnerable & outdated dependencies

- **Dependabot alerts** warn when a dependency has a known vulnerability (CVE).
- **Dependabot security updates** open a **PR** that bumps the package to a fixed version.
- **Dependabot version updates** keep dependencies current on a schedule.

Our repo ships `.github/dependabot.yml` configured for two ecosystems:

```yaml
version: 2
updates:
  - package-ecosystem: "nuget"          # the sample app + tests
    directory: "/"
    schedule: { interval: "weekly" }
  - package-ecosystem: "github-actions" # the actions in our workflows
    directory: "/"
    schedule: { interval: "weekly" }
```

Because a Dependabot fix arrives as a PR, your **required CI check** runs on it — you get
an automated fix *and* proof it still builds and tests.

### 2. Secret scanning — leaked credentials

- Detects tokens, keys, and other secrets committed to the repo.
- **Push protection** can *block* a push that contains a detected secret before it ever
  lands.
- CivicPermit has **no secrets** by design (in-memory store, no external services) — which
  is exactly the point: keep credentials out of code and let scanning enforce it.

### 3. Code scanning (CodeQL) — vulnerabilities in your code

- **CodeQL** analyzes your source for security issues (injection, unsafe patterns, etc.).
- Findings appear in the **Security** tab and as **PR annotations**.
- GitHub provides **default setup** — a few clicks, no third-party action required — which
  configures CodeQL for the repo's languages (C# here).

## The Security tab

One place to see it all: **Security** → alerts for Dependabot, secret scanning, and code
scanning, plus your **security policy** (`SECURITY.md`) and advisories. Triaging here uses
the same skills as triaging issues.

## Enterprise notes

- Availability of secret scanning and code scanning depends on your **GitHub Enterprise**
  plan and org settings. If a toggle is missing, your org admin may need to enable it —
  the lab flags each such step.
- None of these features require installing anything or adding a Marketplace action.

## Common pitfalls

- **Ignoring Dependabot PRs.** They pile up; review and merge them like any other PR.
- **Committing a secret "just for testing."** Push protection exists because this is
  common — never do it, even temporarily.
- **Assuming scanning = done.** Tools find issues; the fix still flows through a PR and
  review.

> 💡 **Copilot Connection:** In the Copilot workshop you'll see Copilot Autofix propose
> code changes for scanning alerts. Today you learn to *enable and triage* the findings so
> those suggested fixes make sense.

## ➡️ Now do the lab

[**Lab 09 — Secure the repository**](../labs/lab-09-secure-development.md)
