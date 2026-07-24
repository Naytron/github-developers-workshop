---
title: "Module 2 — Branching & Commits"
---

# Module 2 — Branching & Commits

⏱️ **45 minutes** · Paired labs: [Lab 2.1 — Branch & first commit](../labs/lab-02-1-branch-and-first-commit.md), [Lab 2.2 — Implement the endpoint & test](../labs/lab-02-2-implement-endpoint-and-test.md) · [← Home](../index.md)

## Goals

- Create a **branch** to isolate your work from `main`.
- Make small, well-described **commits**.
- Push your branch to GitHub and understand what "tracking" means.
- Land the feature as a small, well-tested **commit** on your branch (Lab 2.2).

## Why branches?

`main` is the shared, always-working line of code. You never build directly on it.
Instead you create a **branch** — a lightweight, private line where you can experiment,
commit as often as you like, and only merge back when it's ready and reviewed.

Benefits:

- Your half-finished work never breaks anyone else.
- Multiple people can work in parallel.
- A branch maps cleanly to *one issue / one feature*.

## Branch naming

Pick a convention and stick to it. A common, readable pattern ties the branch to its
issue:

```
feature/<issue-number>-<short-description>
```

For our story:

```
feature/42-schedule-inspection
```

Other prefixes teams use: `fix/`, `chore/`, `docs/`. Consistency helps humans and tooling.

## Creating and switching branches

Always start from an up-to-date `main`:

```bash
# Get the latest main before branching
git switch main
git pull

# Create a new branch from main and switch to it
git switch -c feature/42-schedule-inspection

# See where you are
git branch --show-current
```

`git switch` is the modern, purpose-built command for changing branches. (`git checkout`
still works and you'll see it in older docs.)

### Why `git pull` before you branch?

A branch is just a pointer to the commit you're on when you create it. If your
local `main` is behind the remote, your new branch inherits that stale starting
point. That leads to three common problems:

- **Stale base:** you build on old code and miss changes teammates already merged.
- **Duplicated work:** you might re-implement something that's already done.
- **Merge conflicts:** the further your branch drifts from the real `main`, the
  harder it is to merge — and the noisier your pull request diff becomes.

Pulling first guarantees your branch starts from the latest shared history, so
your changes stay small, current, and easy to review.

## What makes a good commit?

A commit is a **snapshot with a message explaining why**. Good commits are:

- **Small and focused** — one logical change.
- **Green** — the code still builds/tests where practical.
- **Well-described** — the message tells a reviewer *what* and *why*.

### Commit message shape

```
<type>: <short summary in the imperative>

<optional body explaining why, wrapped at ~72 chars>

Refs #42
```

Example:

```
feat: add empty inspections endpoint stub

Introduces the POST /permits/{id}/inspections route returning 501 so the
branch has a compiling starting point for the feature.

Refs #42
```

This is the **Conventional Commits** style — see the [guide](../guides/conventional-commits.md).
It's optional but pays off: readable history and automatable release notes.

## The everyday commit loop

```bash
git status                 # what changed?
git add <files>            # stage the changes you want in this commit
git commit -m "feat: ..."  # record them with a message
git push -u origin feature/42-schedule-inspection   # publish the branch
```

The `-u` (upstream) on the first push links your local branch to the remote one, so later
you can just `git push` and `git pull`.

## Staging vs. committing

- **Working directory:** your edited files.
- **Staging area (index):** the changes you've marked with `git add` for the next commit.
- **Commit:** a permanent snapshot of the staged changes.

This two-step design lets you craft a clean commit even when your working directory is
messy.

## Writing the feature commit (Lab 2.2)

Branching and a throwaway first commit are the mechanics; **Lab 2.2** is where the real
change lands. You'll add the endpoint to `src/CivicPermit.Api/Program.cs`:

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
or test right after — either way, the branch ships with a test, ready to propose as a PR in
Module 3.

## Common pitfalls

- **Committing on `main`.** Always branch first. If you did, see [Troubleshooting](../troubleshooting.md).
- **Giant commits** that mix five changes — impossible to review or revert.
- **Forgetting `-u`** on the first push, then wondering why `git push` complains.

> 💡 **Copilot Connection:** Copilot can draft a commit message from your staged diff.
> Handy — but you still own the *why*. We cover that in the Copilot workshop; today,
> writing messages yourself builds the instinct for what a good one says.

## ➡️ Now do the labs

1. [**Lab 2.1 — Branch & first commit**](../labs/lab-02-1-branch-and-first-commit.md)
2. [**Lab 2.2 — Implement the endpoint & test**](../labs/lab-02-2-implement-endpoint-and-test.md)
