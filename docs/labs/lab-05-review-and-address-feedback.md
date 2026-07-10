---
title: "Lab 05 — Review & Address Feedback"
---

# Lab 05 — Review & Address Feedback

⏱️ ~25 min · Module: [Pull Requests & Review](../modules/03-pull-requests-and-review.md) · [← Home](../index.md)

**Goal:** experience both sides of code review — leave review comments, then push a change
that addresses feedback.

> This is the **Review** step. Pair up if you can; otherwise you'll self-review, which is a
> valuable habit on its own.

## Part A — Review a partner's PR (paired)

Swap PR numbers with a partner. Then:

### 1. Check out their PR locally (optional but great for real review)

```bash
gh pr checkout <their-PR#>
dotnet test
```

Running the code is the highest-quality review you can give.

### 2. Leave line comments and a review

```bash
# Start a review with an overall verdict:
gh pr review <their-PR#> --comment --body "Nice, focused change. One suggestion below."
```

For line-level comments, open the PR in the browser (fastest for inline notes):

```bash
gh pr view <their-PR#> --web
```

On the **Files changed** tab, click a line's **+** to comment. Consider suggesting:

- *"Should `ScheduledFor` in the past be rejected? Out of scope for #<issue-number>, just noting."*
- *"Consider a comment on why we return 404 before validating the body."*

Mark clearly which comments are **blocking** vs. **nits**.

### 3. Submit a verdict

- **Approve** if it meets the acceptance criteria.
- **Request changes** if something must change before merge.

```bash
gh pr review <their-PR#> --approve --body "LGTM — tests cover the key paths."
```

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

## ✅ Checkpoint

- [ ] You left at least one review comment on a PR (a partner's or your own).
- [ ] You pushed a commit that addresses feedback.
- [ ] CI re-ran on the new commit (`gh pr checks`).

## Etiquette recap

- Be specific and kind; suggest, don't demand.
- Separate blocking issues from nits.
- Approve when it's good enough to ship — not when it's perfect.

> 💡 **Copilot Connection:** In the Copilot workshop you'll try Copilot-assisted review,
> which can flag issues and summarize diffs. Today you build the judgment that tells you
> when to accept such suggestions.

## ➡️ Next

[**Lab 06 — Author the CI workflow**](lab-06-author-ci-workflow.md)
