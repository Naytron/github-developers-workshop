---
title: "Module 1 — The GitHub Workflow & Issues"
---

# Module 1 — The GitHub Workflow & Issues

⏱️ **45 minutes** · Paired lab: [Lab 1 — Open the Issue](../labs/lab-01-open-the-issue.md) · [← Home](../index.md)

## Goals

- See the full GitHub workflow as one connected loop.
- Understand **Issues** as the unit of work that starts everything.
- Write a clear, actionable issue using a repository **issue template**.

## The workflow, end to end

```
┌────────┐   ┌────────┐   ┌────────┐   ┌──────────────┐   ┌────────┐   ┌──────────┐   ┌───────┐   ┌─────────┐
│ Issue  │ → │ Branch │ → │ Commit │ → │ Pull Request │ → │ Review │ → │ Workflow │ → │ Merge │ → │ Release │
└────────┘   └────────┘   └────────┘   └──────────────┘   └────────┘   └──────────┘   └───────┘   └─────────┘
```

Each step has a job:

| Step | What it answers |
| ---- | --------------- |
| **Issue** | *What* are we doing and *why*? |
| **Branch** | Where do I work without disturbing others? |
| **Commit** | What changed, in small reviewable steps? |
| **Pull Request** | Here's my proposed change — please review. |
| **Review** | Is it correct, safe, and clear? |
| **Workflow** | Does it build and pass tests automatically? |
| **Merge** | Fold the change into the main line, safely. |
| **Release** | Package a known-good version for others. |

## Why start with an Issue?

An issue is the **shared record of intent**. It gives the team:

- A single place to discuss scope and acceptance criteria.
- A number (`#42`) that links commits, branches, and PRs together.
- A trail an auditor or a future teammate can follow.

In enterprise settings this traceability matters: the issue is *why* the code changed.

## Anatomy of a good issue

- **Title:** short and specific — *"Add endpoint to schedule an inspection"*.
- **Problem:** the user need in a sentence or two.
- **Proposal:** what should change.
- **Acceptance criteria:** a checklist that defines "done."
- **Labels:** `enhancement`, area, priority — for triage and filtering.

## Issue templates

Repositories can ship **issue templates** so every issue captures the right information.
Ours lives at `.github/ISSUE_TEMPLATE/feature_request.yml` and is the one you'll use in
the lab. Templates reduce back-and-forth and make issues consistent across a team.

## The issue we'll open

> **Title:** Add the ability to schedule an inspection for an existing permit
>
> **Acceptance criteria**
> - `POST /permits/{id}/inspections` creates an inspection for an existing permit
> - Returns `404` when the permit does not exist
> - Returns `400` when required fields are missing
> - Covered by an xUnit test
> - CI is green

Everything else today references this issue number.

## Common pitfalls

- **Vague titles** ("fix API") that no one can triage.
- **No acceptance criteria**, so "done" is a matter of opinion.
- **Skipping the issue** and going straight to code — you lose the *why*.

> 💡 **Copilot Connection:** Copilot can help draft an issue's acceptance criteria from a
> one-line description. We'll practice that in the Copilot workshop; today, writing them
> by hand builds the habit of defining "done" up front.

## ➡️ Now do the lab

[**Lab 1 — Open the Issue**](../labs/lab-01-open-the-issue.md)
