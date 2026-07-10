---
title: "Module 3 — Pull Requests & Review"
---

# Module 3 — Pull Requests & Review

⏱️ **45 minutes (+ review practice)** · Paired labs: [Lab 03](../labs/lab-03-implement-endpoint-and-test.md), [Lab 04](../labs/lab-04-open-pull-request.md), [Lab 05](../labs/lab-05-review-and-address-feedback.md) · [← Home](../index.md)

## Goals

- Implement the feature and a test on your branch (Lab 03).
- Open a **pull request (PR)** that clearly proposes the change (Lab 04).
- Give and respond to a **code review** (Lab 05).

## What a pull request is

A pull request says: *"Here are the commits on my branch. Please review and consider
merging them into `main`."* It's where code, conversation, and automation meet:

- A **diff** of exactly what changed.
- A **description** explaining what and why.
- **Review** comments and approvals.
- **Status checks** (CI) that run automatically.
- A **merge** button, gated by your team's rules.

## Writing the change (Lab 03)

You'll add the endpoint to `src/CivicPermit.Api/Program.cs`:

```csharp
app.MapPost("/permits/{id:int}/inspections", (int id, ScheduleInspectionRequest request, PermitStore store) =>
{
    if (store.GetById(id) is null)
        return Results.NotFound();

    if (string.IsNullOrWhiteSpace(request.InspectionType) || request.ScheduledFor == default)
        return Results.BadRequest("InspectionType and ScheduledFor are required.");

    var inspection = store.AddInspection(id, request.InspectionType, request.ScheduledFor);
    return Results.Created($"/permits/{id}/inspections/{inspection!.Id}", inspection);
});
```

…plus a small model and store method, and an **xUnit test** proving it works. Test first
or test right after — either way, the PR ships with a test.

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

1. [**Lab 03 — Implement the endpoint & test**](../labs/lab-03-implement-endpoint-and-test.md)
2. [**Lab 04 — Open a pull request**](../labs/lab-04-open-pull-request.md)
3. [**Lab 05 — Review & address feedback**](../labs/lab-05-review-and-address-feedback.md)
