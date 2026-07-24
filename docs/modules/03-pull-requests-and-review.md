---
title: "Module 3 — Pull Requests & Review"
---

# Module 3 — Pull Requests & Review

⏱️ **45 minutes (+ review practice)** · Paired labs: [Lab 3.1](../labs/lab-03-1-open-pull-request.md), [Lab 3.2](../labs/lab-03-2-review-and-address-feedback.md) · [← Home](../index.md)

## Goals

- Recap: the feature and its test already landed on your branch in **Lab 2.2** (Module 2).
- Open a **pull request (PR)** that clearly proposes the change (Lab 3.1).
- Give and respond to a **code review** (Lab 3.2).

## What a pull request is

A pull request says: *"Here are the commits on my branch. Please review and consider
merging them into `main`."* It's where code, conversation, and automation meet:

- A **diff** of exactly what changed.
- A **description** explaining what and why.
- **Review** comments and approvals.
- **Status checks** (CI) that run automatically.
- A **merge** button, gated by your team's rules.

## Recall the change (from Lab 2.2)

The feature — `POST /permits/{id}/inspections` and its xUnit test — already landed on your
branch back in **[Lab 2.2](../labs/lab-02-2-implement-endpoint-and-test.md)** (Module 2,
Branching & Commits). This module is about *proposing and reviewing* that change, not
writing it. If your branch isn't green yet, finish Lab 2.2 first.

## A good PR description

Our repo ships a **PR template** (`.github/PULL_REQUEST_TEMPLATE.md`) that prompts for:

- **What & why**, and the issue it closes (`Closes #42`).
- **Changes** a reviewer should look at first.
- **How to test** (`dotnet test`, plus any manual steps).
- A **checklist** (builds, tests pass, covered by a test).

`Closes #42` is special: when the PR merges, GitHub **automatically closes** issue #42 and
links them forever.

## Code review — the human quality gate

Review is not about catching typos (CI does that). It's about:

- **Correctness:** does it do what the issue asked?
- **Clarity:** will the next person understand it?
- **Safety:** any security, data, or edge-case concerns?
- **Consistency:** does it fit the codebase's conventions?

### Review mechanics

- Comment on specific lines; start a **review** to bundle comments.
- Choose an outcome: **Comment**, **Approve**, or **Request changes**.
- The author pushes follow-up commits; the conversation resolves; approval follows.

### Reviewing well

- Be kind and specific: *"Consider returning 400 here when the date is missing"* beats
  *"this is wrong."*
- Distinguish **blocking** concerns from **nits** (say which is which).
- Approve when it's good enough to ship — not when it's theoretically perfect.

## Responding to review

- Treat comments as a conversation, not an attack.
- Push a new commit that addresses the feedback; reply to each thread.
- Re-request review when ready.

## Common pitfalls

- **Huge PRs** no one can review well. Keep them focused (ours is ~one endpoint + a test).
- **No description**, forcing the reviewer to reverse-engineer intent.
- **Arguing in comments** instead of pushing a small change or hopping on a call.

> 💡 **Copilot Connection:** Copilot can draft PR summaries and even suggest review
> comments. In the Copilot workshop we'll try Copilot code review; today you practice the
> judgment that makes those suggestions useful.

## ➡️ Now do the labs

1. [**Lab 3.1 — Open a pull request**](../labs/lab-03-1-open-pull-request.md)
2. [**Lab 3.2 — Review, feedback & roll back**](../labs/lab-03-2-review-and-address-feedback.md)
