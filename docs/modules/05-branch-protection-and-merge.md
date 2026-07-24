---
title: "Module 5 — Branch Protection & Merge"
---

# Module 5 — Branch Protection & Merge

⏱️ **45 minutes** · Paired lab: [Lab 5 — Branch protection & merge](../labs/lab-05-branch-protection-and-merge.md) · [← Home](../index.md)

## Goals

- Protect `main` so changes can only arrive via reviewed, tested pull requests.
- Make the CI check **required**.
- Merge your PR and understand the three merge strategies.

## Why protect a branch?

Without protection, anyone can push straight to `main` — bypassing review and CI. Branch
protection (or a **ruleset**) turns your team's good intentions into **enforced rules**:

- Require a pull request before merging.
- Require **approvals** (e.g., at least one).
- Require **status checks** to pass (our `Build & Test (CivicPermit)` job).
- Require branches to be **up to date** before merging.
- Optionally require **CODEOWNERS** review, signed commits, or linear history.

## Rulesets vs. classic branch protection

GitHub offers two ways to express these rules:

- **Repository rulesets** (newer) — layered, org-shareable, with clear evaluation.
- **Classic branch protection rules** — the long-standing per-branch settings.

Either works for this workshop. Rulesets are the direction of travel and are easier to
manage at org scale; the lab shows both entry points.

## Required status checks

A **required status check** is a workflow result that *must* be green before merge. We'll
require our CI job by name (**Build & Test (CivicPermit)**). After that:

- A red CI run **blocks** the merge button.
- Pushing a fix re-runs CI; green unblocks the merge.

This is the safety net that makes "merge to `main`" trustworthy.

## CODEOWNERS

The `.github/CODEOWNERS` file maps paths to owners. When protection requires
**"Review from Code Owners,"** a PR that touches `/src/**` automatically requests review
from the listed team. Combined with required reviews, it guarantees the right eyes see
each change.

## The three merge strategies

| Strategy | What it does | When to use |
| -------- | ------------ | ----------- |
| **Squash and merge** | Combines all PR commits into **one** commit on `main`. | Default for most teams — clean, linear history; one commit per feature. |
| **Merge commit** | Keeps every commit and adds a merge commit. | When the individual commits carry value you want to preserve. |
| **Rebase and merge** | Replays your commits onto `main` with no merge commit. | Teams that want a linear history *and* to keep individual commits. |

For this workshop we recommend **Squash and merge**: our feature is one logical change, so
one tidy commit on `main` is ideal — and the squash message becomes great release-note
material.

## The merge, step by step

1. CI is ✅ and you have the required approval(s).
2. Click **Squash and merge**; edit the squash commit message to be meaningful.
3. Confirm — GitHub merges and (because the PR said `Closes #42`) **closes the issue**.
4. **Delete the branch** — its work now lives in `main`.

## Common pitfalls

- **Admins bypassing rules.** Decide deliberately whether admins are exempt; for real
  protection, include administrators.
- **Requiring a check that never runs.** The check name must match the job, and the
  workflow must trigger on `pull_request`.
- **Stale branches.** If "require up to date" is on, update your branch from `main` before
  merging.

> 💡 **Copilot Connection:** Copilot can summarize a large diff before you approve, helping
> reviewers focus. The Copilot workshop covers that; today you practice the review and
> protection mechanics that make such summaries actionable.

## ➡️ Now do the lab

[**Lab 5 — Branch protection & merge**](../labs/lab-05-branch-protection-and-merge.md)
