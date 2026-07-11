---
title: "Lab 01 — Open the Issue"
---

# Lab 01 — Open the Issue

⏱️ ~15 min · Module: [The GitHub Workflow & Issues](../modules/01-github-workflow-and-issues.md) · [← Home](../index.md)

**Goal:** open the issue that starts our story, using the repository's feature-request
template.

> This is the **Issue** step of `Issue → Branch → Commit → PR → Review → Workflow → Merge → Release`.

## Steps

### 1. Create the issue with the GitHub CLI

The repo ships a feature-request template at
`.github/ISSUE_TEMPLATE/feature_request.yml`. Create the issue directly:

```bash
gh issue create \
  --title "Add the ability to schedule an inspection for an existing permit" \
  --label "enhancement" \
  --body "$(cat <<'EOF'
## What problem are we solving?
Permit staff need to schedule an inspection once a permit is under review.

## Proposed change
Add POST /permits/{id}/inspections that records a scheduled inspection
(type + date) for an existing permit and returns 201 Created.

## Acceptance criteria
- [ ] POST /permits/{id}/inspections creates an inspection for an existing permit
- [ ] Returns 404 when the permit does not exist
- [ ] Returns 400 when the request is missing required fields
- [ ] Covered by an xUnit test
- [ ] CI is green
EOF
)"
```

`gh` prints the new issue's URL and number — **write the number down** (e.g., `#1`). We'll
call it **`<issue-number>`** for the rest of the workshop.

### 2. Confirm it exists

```bash
gh issue list
gh issue view <issue-number>
```

You should see your issue with the `enhancement` label and the acceptance-criteria
checklist.

> 💡 **CLI tip:** Prefer a web form? `gh issue create --web` opens the browser template.
> `gh issue list --assignee @me` shows just your issues, and `gh browse <issue-number>`
> jumps straight to one in the browser.

## What just happened?

- You captured **intent** — the *why* — before touching code.
- The issue number is the thread that will tie your branch, commits, and PR together.
- The acceptance criteria are your definition of **done**; every later lab checks one off.

## ✅ Checkpoint

- [ ] `gh issue view <issue-number>` shows your issue.
- [ ] It has the `enhancement` label and the acceptance-criteria checklist.
- [ ] You've noted the issue number.

> 💡 **Copilot Connection:** Copilot can expand a one-line request into full acceptance
> criteria. We practice that in the Copilot workshop — here, writing them yourself builds
> the habit of defining "done" up front.

## ➡️ Next

[**Lab 02 — Branch & first commit**](lab-02-branch-and-first-commit.md)
