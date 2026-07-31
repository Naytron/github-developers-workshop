---
title: "NJ DHS — Attendee Quickstart (Fork Setup)"
---

# NJ DHS — Attendee Quickstart

[← Home](index.md) · [NJ DHS 2-day agenda](agenda-njdhs.md) · [Full Lab 0 setup](labs/lab-00-setup.md)

This is the **NJ DHS-specific** version of setup. It maps the generic lab placeholders to the
real names for our run and calls out the **fork defaults** you have to flip. Do the first three
steps **before Day 1** if you can — that's what keeps Day 1 about GitHub, not setup.

> **Our environment:** GitHub Enterprise Cloud with **Enterprise Managed Users (EMU)**. Your
> account is a **managed identity** inside the enterprise, your fork is **internal** (visible to
> the enterprise, never public), and everything you do stays within the enterprise boundary.

| Placeholder in the labs | Your real value |
| --- | --- |
| `<src-org>` | **`dhs-learning`** |
| upstream repo (`github-developers-workshop`) | **`github-labs`** |
| `<yourname>-gh-training` | **`<initials>-github-labs`** (e.g. `jsd-github-labs`) |
| `<your-username>` | your EMU username (what you signed in as) |

---

## 1. Sign in

```bash
gh auth login
```

Choose **GitHub Enterprise Cloud**, authenticate in the browser (you'll SSO with your managed
account), and pick **HTTPS** for Git. Confirm:

```bash
gh auth status
```

## 2. Fork the staged repo → `<initials>-github-labs`

Fork **`dhs-learning/github-labs`** into your own account, give it your initials-based name, and
clone it — all in one command:

```bash
gh repo fork dhs-learning/github-labs --fork-name <initials>-github-labs --clone
cd <initials>-github-labs
```

This creates your fork (owned by you, **internal** visibility), wires an **`upstream`** remote
back to `dhs-learning/github-labs`, and clones it locally. Confirm your remotes:

```bash
git remote -v   # origin = your fork; upstream = dhs-learning/github-labs
```

> 💡 Prefer the browser? Open **`dhs-learning/github-labs` → Fork**, set the repository name to
> **`<initials>-github-labs`**, create it, then `gh repo clone <your-username>/<initials>-github-labs`.

## 3. Turn on Issues (forks start with it OFF)

A fresh fork has **Issues disabled**, so the **Issues** tab isn't there yet — and you need it in
[Lab 1](labs/lab-01-open-the-issue.md). Turn it on:

```bash
gh repo edit <your-username>/<initials>-github-labs --enable-issues
```

Or in the browser: **your fork → Settings → General → Features → tick _Issues_**.

## 4. Turn on Actions (also OFF on a fresh fork)

A fork also has **Actions disabled**, which you need in [Lab 4](labs/lab-04-author-ci-workflow.md).
Enable it in the browser:

```bash
gh repo view --web   # → Settings → Actions → General → "Allow all actions and reusable workflows" → Save
```

(If a DHS admin has already enabled Actions across the org, you'll see the workflows with
`gh workflow list` and can skip this.)

## 5. Build & test to confirm you're ready

```bash
dotnet test   # expect: succeeded: 5
```

---

## Two fork gotchas to remember during the labs

**① Open every PR against YOUR fork — not `dhs-learning/github-labs`.**
Because your clone has an `upstream` remote, `gh pr create` and the browser compose form both
default the **base _repository_** to `dhs-learning/github-labs`. If you leave it there, your PR
lands on the shared staged repo and your CI, branch protection, and release labs won't behave.
Point it at your own fork:

```bash
gh pr create --repo <your-username>/<initials>-github-labs --base main --web
```

In the browser, use the left **base repository** dropdown and pick your fork.

**② You can't approve your own PR (Lab 5).**
You own your fork, so you can't approve your own pull request. When you set up branch protection
in [Lab 5](labs/lab-05-branch-protection-and-merge.md), either set **Required approvals** to `0`,
**pair up** and approve each other's PRs, or have an instructor approve. Rulesets/branch
protection themselves work fine on our **internal** forks — Enterprise includes them at every
visibility, so there's no plan blocker.

---

Stuck on any of this? See [Troubleshooting](troubleshooting.md) or grab an instructor during
**Module 0**. The generic, tool-by-tool version of this setup lives in
[Lab 0](labs/lab-00-setup.md).
