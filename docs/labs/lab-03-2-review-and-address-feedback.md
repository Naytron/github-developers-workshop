---
title: "Lab 3.2 — Review, Feedback & Roll Back"
---

# Lab 3.2 — Review, Feedback & Roll Back

⏱️ ~25 min · Module: [Pull Requests & Review](../modules/03-pull-requests-and-review.md) · [← Home](../index.md)

**Goal:** experience both sides of code review — review a partner's PR on **GitHub.com**,
push a change that addresses feedback, and learn how to **roll back** a merged PR.

> Part A is best run as an **instructor-led demo on GitHub.com**, with attendees following
> along on a partner's PR. Every step also has a **GitHub CLI** equivalent for reference, so
> you can do the whole flow from the terminal if you prefer. Pair up if you can; otherwise
> self-review, which is a valuable habit on its own.

## Part A — Review a partner's PR (GitHub.com demo)

Swap PR numbers with a partner (or use your own PR to self-review).

### 1. Open the PR on GitHub.com

Go to the repo → **Pull requests** → open your partner's PR. Skim the **Conversation** tab
for the description and linked issue, then open **Files changed** to see the diff.

> 🖥️ **CLI reference:** `gh pr view <their-PR#> --web` opens it in the browser;
> `gh pr diff <their-PR#>` reviews the diff right in the terminal.

### 2. Run their code locally (optional but the best review you can give)

```bash
gh pr checkout <their-PR#>
dotnet test
```

Then switch back to your own branch when you're done (`git switch -`).

### 3. Leave inline comments

On the **Files changed** tab, hover a line and click the blue **+** to add an inline
comment. Start a review so your notes batch into one submission. Consider suggesting:

- *"Should `ScheduledFor` in the past be rejected? Out of scope for #<issue-number>, just noting."*
- *"Consider a comment on why we return 404 before validating the body."*

Mark clearly which comments are **blocking** vs. **nits**.

> 🖥️ **CLI reference:** `gh pr comment <their-PR#> --body "..."` drops a quick top-level
> note without opening the browser.

### 4. Submit a verdict

Click **Review changes** (top-right of **Files changed**) and choose:

- **Approve** if it meets the acceptance criteria.
- **Request changes** if something must change before merge.
- **Comment** for non-blocking feedback only.

> 🖥️ **CLI reference:**
> ```bash
> gh pr review <their-PR#> --approve --body "LGTM — tests cover the key paths."
> # or: gh pr review <their-PR#> --request-changes --body "One blocking item inline."
> # or: gh pr review <their-PR#> --comment --body "A couple of nits, nothing blocking."
> ```

> 🤖 **Optional — add Copilot as a reviewer:** on the PR, open **Reviewers** and request a
> review from **Copilot** (where enabled). It posts an automated review — summarizing the diff
> and flagging likely issues — within a minute or two. Treat it as a *fast first pass*, not the
> verdict: **you** still decide what's blocking, what's a nit, and what's a false positive.
> That adjudication is the reviewer skill you just practiced, and it's exactly what makes an
> auto-reviewer (or an AI-authored PR) safe to rely on.

## Part B — Address feedback on your PR

Back on your own branch:

### 1. Make a small improvement

Add a clarifying comment above your endpoint in `Program.cs`, for example:

```csharp
// Validate existence before the body so an unknown permit always returns 404,
// regardless of the payload.
```

### 2. Build, test, commit, push

```bash
dotnet test
git add src/CivicPermit.Api/Program.cs
git commit -m "docs: clarify 404-before-validation ordering

Addresses review feedback on PR.

Refs #<issue-number>"
git push
```

Your PR updates automatically, CI re-runs, and reviewers can re-review.

### 3. Reply and resolve

In the browser PR view, reply to each comment (e.g., *"Done in <commit sha>"*) and resolve
the thread. Re-request review if your team requires a fresh approval.

```bash
gh pr view --web
```

## Part C — Roll back a PR (technique)

Sometimes a merged change needs to come out — a regression slips through, or a release is
pulled. GitHub makes this a **forward** operation: you create a **new** commit/PR that undoes
the merged one, so history is preserved and auditable (you never rewrite `main`).

> 🧪 **Demo only — don't actually merge the revert today.** Walk through it so you know the
> mechanics, then close the revert PR without merging so the shipped feature story stays
> intact for the rest of the workshop.

**On GitHub.com:** open the **merged** PR → scroll to the merge event at the bottom of the
**Conversation** tab → click **Revert**. GitHub opens a new branch and a **revert PR** that
undoes every change from the original. It still needs a review and a green CI run before it
could merge — same rules as any other PR.

> 🖥️ **CLI reference:** revert a merge commit locally by its SHA. `-m 1` tells Git to keep
> the first parent (i.e. `main` as it was before the merge):
> ```bash
> git switch main && git pull
> git log --oneline --merges -5          # find the merge commit SHA
> git switch -c revert/<pr-number>
> git revert -m 1 <merge-sha>            # creates the revert commit
> git push -u origin revert/<pr-number>
> gh pr create --base main --title "Revert: <original title>" --fill
> ```
> For a PR that was **squash-merged** (a single normal commit, not a merge commit), drop the
> `-m 1`: `git revert <squash-commit-sha>`.

## ✅ Checkpoint

- [ ] You left at least one review comment on a PR (a partner's or your own).
- [ ] You pushed a commit that addresses feedback.
- [ ] CI re-ran on the new commit (`gh pr checks`).

## Etiquette recap

- Be specific and kind; suggest, don't demand.
- Separate blocking issues from nits.
- Approve when it's good enough to ship — not when it's perfect.

> 💡 **Copilot Connection:** Copilot code review can act as an automated reviewer on every PR —
> flagging issues and summarizing the diff before a human looks. The judgment you built here is
> what tells you when to accept those suggestions and when to push back.

## ➡️ Next

[**Lab 4 — Author the CI workflow**](lab-04-author-ci-workflow.md)
