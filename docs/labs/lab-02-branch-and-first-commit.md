---
title: "Lab 02 — Branch & First Commit"
---

# Lab 02 — Branch & First Commit

⏱️ ~20 min · Module: [Branching & Commits](../modules/02-branching-and-commits.md) · [← Home](../index.md)

**Goal:** create a feature branch, make a small first commit, and push it to GitHub.

> This is the **Branch → Commit** step of the story.

## Steps

### 1. Make sure you're on an up-to-date `main`

```bash
git switch main
git pull
```

### 2. Create your feature branch

Use the issue number from Lab 01:

```bash
git switch -c feature/<issue-number>-schedule-inspection
git branch --show-current
```

### 3. Make a small, meaningful first change

We'll leave a clear marker for the feature so the branch has a real commit. Open
`src/CivicPermit.Api/Program.cs` and find the `TODO (Lab 03)` comment near the bottom.
Update it to record that work has started:

```csharp
// Feature (#<issue-number>): schedule an inspection for an existing permit.
//   POST /permits/{id}/inspections
// Endpoint and test are added in Lab 03.
```

Save the file, then confirm it still builds:

```bash
dotnet build
```

### 4. Stage and commit

```bash
git status
git add src/CivicPermit.Api/Program.cs
git commit -m "chore: start schedule-inspection feature

Marks the feature entry point in Program.cs so the branch has a
compiling starting point.

Refs #<issue-number>"
```

### 5. Push the branch

```bash
git push -u origin feature/<issue-number>-schedule-inspection
```

The `-u` links your local branch to the remote so future `git push`/`git pull` need no
arguments. `gh` prints a URL to open a PR — we'll do that in Lab 04.

## ✅ Checkpoint

- [ ] `git branch --show-current` shows `feature/<issue-number>-schedule-inspection`.
- [ ] `git log --oneline -1` shows your commit.
- [ ] `dotnet build` succeeds.
- [ ] The branch is pushed (visible with `git status` → "up to date with origin/...").

## Troubleshooting

- **Committed on `main` by accident?** See "Move a commit to a new branch" in
  [Troubleshooting](../troubleshooting.md).
- **`git push` rejected?** You may not have `-u`'d; run the full push command above.

> 💡 **Copilot Connection:** Copilot can draft that commit message from your staged diff.
> Useful — but you still own the *why*. More in the Copilot workshop.

## ➡️ Next

[**Lab 03 — Implement the endpoint & test**](lab-03-implement-endpoint-and-test.md)
