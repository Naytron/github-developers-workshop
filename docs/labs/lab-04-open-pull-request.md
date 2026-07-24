---
title: "Lab 04 — Open a Pull Request"
---

# Lab 04 — Open a Pull Request

⏱️ ~15 min · Module: [Pull Requests & Review](../modules/03-pull-requests-and-review.md) · [← Home](../index.md)

**Goal:** open a pull request that proposes merging your feature branch into `main`, using
the repository's PR template and linking the issue.

> This is the **Pull Request** step.

## Steps

### 1. Make sure your branch is pushed

```bash
git status         # should be "up to date with origin/feature/<issue-number>-schedule-inspection"
```

If not: `git push`.

### 2. Create the PR with the GitHub CLI

```bash
gh pr create \
  --base main \
  --title "Add endpoint to schedule an inspection for a permit" \
  --body "$(cat <<'EOF'
## What & why
Adds POST /permits/{id}/inspections so staff can schedule an inspection for an
existing permit.

Closes #<issue-number>

## Changes
- New Inspection model + ScheduleInspectionRequest
- PermitStore.AddInspection(...)
- POST /permits/{id}/inspections endpoint (201 / 400 / 404)
- xUnit tests for the endpoint

## How to test
```
dotnet test
```

## Checklist
- [x] The change is focused and matches the linked issue
- [x] dotnet build succeeds
- [x] dotnet test passes locally
- [x] New behavior is covered by an xUnit test
EOF
)"
```

```powershell
$prBody = @"
## What & why
Adds POST /permits/{id}/inspections so staff can schedule an inspection for an
existing permit.

Closes #<issue-number>

## Changes
- New Inspection model + ScheduleInspectionRequest
- PermitStore.AddInspection(...)
- POST /permits/{id}/inspections endpoint (201 / 400 / 404)
- xUnit tests for the endpoint

## How to test
`dotnet test`

## Checklist
- [x] The change is focused and matches the linked issue
- [x] dotnet build succeeds
- [x] dotnet test passes locally
- [x] New behavior is covered by an xUnit test
"@

gh pr create `
  --base main `
  --title "Add endpoint to schedule an inspection for a permit" `
  --body $prBody
```

`gh` prints the PR URL. Note the **PR number** (e.g., `#2`).

> 💡 **CLI tip:** `gh pr create --fill` drafts the title and body straight from your
> commits. `gh pr checks --watch` live-follows the checks, and `gh pr status` lists all
> your open PRs.

> The `Closes #<issue-number>` line means merging this PR will **automatically close** your issue
> from Lab 01.

### 3. Look at your PR

```bash
gh pr view --web     # opens in the browser
# or, in the terminal:
gh pr view
gh pr diff
```

Review the **Files changed** — this is exactly what your reviewer will see. Read your own
diff first; it's the fastest way to catch a stray change.

### 4. Watch the checks (preview of Module 4)

This repo **ships the CI workflow pre-built** ([.github/workflows/ci.yml](../../.github/workflows/ci.yml)),
so you'll see a **Build & Test (CivicPermit)** check start right away. You'll read and
modify that workflow yourself in [Lab 06](lab-06-author-ci-workflow.md). If your repo
doesn't have it yet, the check appears once you add it there.

```bash
gh pr checks
```

A passing run looks like:

```text
Build & Test (CivicPermit)   pass   1m23s   https://github.com/.../actions/runs/123
```

(While it's still running you'll see `pending`; a failure shows `fail`.)

## ✅ Checkpoint

- [ ] `gh pr view` shows your PR targeting `main`.
- [ ] The PR body links the issue with `Closes #<issue-number>`.
- [ ] The diff contains only your intended changes.

## Troubleshooting

- **`gh pr create` says no commits between branches** → you haven't pushed, or you branched
  from the wrong place. Push, or rebase onto `main`.
- **PR shows unexpected files** → you committed build output or unrelated edits; see
  [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** Copilot can draft this PR description from your commits and
> diff. We try that in the Copilot workshop; writing it here teaches you what a reviewer
> actually needs.

## ➡️ Next

[**Lab 05 — Review & address feedback**](lab-05-review-and-address-feedback.md)
