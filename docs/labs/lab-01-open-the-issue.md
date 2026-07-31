---
title: "Lab 1 — Open the Issue"
---

# Lab 1 — Open the Issue

⏱️ ~15 min · Module: [The GitHub Workflow & Issues](../modules/01-github-workflow-and-issues.md) · [← Home](../index.md)

**Goal:** open the issue that starts our story, using the repository's feature-request
template.

> This is the **Issue** step of `Issue → Branch → Commit → PR → Review → Workflow → Merge → Release`.

## Steps

### 1. Enable Issues on your fork

If you **forked** the workshop repo, GitHub turns **Issues off** on the new fork by default —
so the **Issues** tab won't be there yet, and `gh issue create` will fail. Turn it on before
you file anything:

```bash
# CLI — enable Issues on your fork (use your own repo)
gh repo edit <owner>/<your-repo> --enable-issues
```

> 💡 Prefer the web UI? Open your repo → **Settings → General → Features** and tick
> **Issues**, then come back here.

(Working in a **shared org repo** instead of a fork? Issues is usually already on — skip
straight to the next step.)

### 2. Open the issue from the feature-request template

The repo ships a feature-request form at `.github/ISSUE_TEMPLATE/feature_request.yml`. Filing
from the template is how issues get created in real life — it prompts for exactly the fields a
good issue needs, so nothing important gets skipped.

1. Go to your repo on **GitHub.com → Issues → New issue → Feature request**
   (or run `gh issue create --web`, which opens the same template in your browser).
2. Fill it in with our story's feature:

   - **Title:** `Add the ability to schedule an inspection for an existing permit`
   - **What problem are we solving?** Permit staff need to schedule an inspection once a
     permit is under review.
   - **Proposed change:** Add `POST /permits/{id}/inspections` that records a scheduled
     inspection (type + date) for an existing permit and returns `201 Created`.
   - **Acceptance criteria** (the template pre-fills these — leave them as-is):
     - [ ] `POST /permits/{id}/inspections` creates an inspection for an existing permit
     - [ ] Returns `404` when the permit does not exist
     - [ ] Returns `400` when the request is missing required fields
     - [ ] Covered by an xUnit test
     - [ ] CI is green
   - **Area:** API
3. Click **Submit new issue**. The `enhancement` label is applied automatically.

**Write the issue number down** (e.g., `#1`). We'll call it **`<issue-number>`** for the rest
of the workshop — it's the thread that ties your branch, commits, and PR together.

<details>
<summary>⚙️ <strong>Automate it (scripting / CI)</strong> — create the same issue from the command line</summary>

Hand-typing an issue body isn't something you'd normally do — but when you need to open issues
*in bulk or from a pipeline*, `gh issue create` with an inline body is the right tool. This
creates the same core content as the template, but it won't populate template-only fields like **Area**.

```bash
# Bash
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

# PowerShell
$issueBody = @"
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
"@

gh issue create `
  --title "Add the ability to schedule an inspection for an existing permit" `
  --label "enhancement" `
  --body $issueBody
```

</details>

### 3. Confirm it exists

```bash
gh issue list
gh issue view <issue-number>
```

You should see your issue with the `enhancement` label and the acceptance-criteria checklist.
(`gh issue list --assignee @me` shows just your issues; `gh browse <issue-number>` jumps
straight to it in the browser.)

## What just happened?

- You captured **intent** — the *why* — before touching code.
- The issue number is the thread that ties your branch, commits, and PR together.
- The acceptance criteria are your **definition of done** — and, increasingly, the **spec**
  someone (or something) builds from. A teammate can pick this up… and so can the Copilot
  coding agent. A vague issue produces vague work from a human *or* an AI; a sharp one is what
  makes fast, reviewable delivery possible.

> 🤖 **Optional — hand the issue to Copilot:** because this issue has a clear title and
> explicit acceptance criteria, it's ready to *delegate*. On GitHub.com you can **assign the
> issue to Copilot**, and the coding agent will open a **draft PR** that attempts the change.
> You don't need this for the workshop — we'll build the feature ourselves so the fundamentals
> stick — but notice the shift: the rest of today's labs (branch → PR → review → CI → merge)
> are exactly the skills you'd use to **review and govern** that agent's work. Needs Copilot
> enabled; skip it if it isn't.

## ✅ Checkpoint

- [ ] The **Issues** tab is enabled on your repo (forkers: Step 1).
- [ ] `gh issue view <issue-number>` shows your issue.
- [ ] It has the `enhancement` label and the acceptance-criteria checklist.
- [ ] You've noted the issue number.

## Troubleshooting

- **No Issues tab, or `gh issue create` says issues are disabled** → Issues is off on your
  fork. Enable it (Step 1): `gh repo edit <owner>/<your-repo> --enable-issues`, or
  **Settings → General → Features → Issues** in the browser.

> 💡 **Copilot Connection:** a one-line request is all Copilot needs to draft full acceptance
> criteria — and a sharp issue is what it needs to *act*. Writing "done" clearly yourself is
> the skill that makes AI output easy to trust, whether Copilot drafts the issue, the code, or
> both.

## ➡️ Next

[**Lab 2.1 — Branch & first commit**](lab-02-1-branch-and-first-commit.md)
