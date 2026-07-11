---
title: "Lab 07 — Branch Protection & Merge"
---

# Lab 07 — Branch Protection & Merge

⏱️ ~30 min · Module: [Branch Protection & Merge](../modules/05-branch-protection-and-merge.md) · [← Home](../index.md)

**Goal:** protect `main` so it requires a pull request and a passing CI check, then merge
your feature.

> This is the **Merge** step. Protecting a branch requires **admin** rights on the repo. If
> you're working in a shared org repo without admin, do Part A as a demo with your
> instructor and go straight to Part B on your own fork.

## Part A — Protect `main`

You can protect a branch with a **ruleset** (newer) or a **classic branch protection
rule**. Both are shown; pick one.

### Option 1 — Ruleset (recommended), via the browser

```bash
gh repo view --web
```

Go to **Settings → Rules → Rulesets → New branch ruleset**:

- **Target:** the default branch (`main`).
- Enable **Require a pull request before merging** (set **Required approvals** to `1`).
- Enable **Require status checks to pass** → add **Build & Test (CivicPermit)**.
- Enable **Require branches to be up to date before merging**.
- Optionally **Require review from Code Owners** (uses `.github/CODEOWNERS`).
- Set **Enforcement status** to **Active** and **Create**.

> ⚠️ **The check name must match exactly.** The required check is the workflow **job
> name** — `Build & Test (CivicPermit)`. It only appears in the picker after that job has
> reported on at least one PR, so open your PR (Lab 04) and let CI run first. If you ever
> rename the job, update the required check to match or every PR will wait forever.

> **Solo, or on a personal fork?** You can't approve your own PR, and the `@your-org/...`
> team in [`.github/CODEOWNERS`](../../.github/CODEOWNERS) won't resolve on a fork — so
> **Require review from Code Owners** can't be satisfied there. Either set **Required
> approvals** to `0` and leave Code Owners review **off**, or have your instructor approve.
> (Point CODEOWNERS at your own username if you want to watch it work.)

### Option 2 — Classic protection, via the GitHub CLI

You can enable a required status check with the API through `gh`:

```bash
gh api -X PUT repos/{owner}/{repo}/branches/main/protection \
  -H "Accept: application/vnd.github+json" \
  -f "required_status_checks[strict]=true" \
  -f "required_status_checks[contexts][]=Build & Test (CivicPermit)" \
  -f "enforce_admins=true" \
  -f "required_pull_request_reviews[required_approving_review_count]=1" \
  -f "restrictions=null"
```

> Replace `{owner}/{repo}` or run from inside the repo so `gh` fills them in. If your plan
> doesn't expose an option, note it and move on — the concept is what matters.

### Verify the protection

Try to push directly to `main` — it should be rejected:

```bash
git switch main
echo "# direct edit" >> README.md
git commit -am "test: direct push should be blocked"
git push          # expect: protected branch / PR required
git reset --hard origin/main   # undo the local test commit
```

## Part B — Merge your pull request

Back on your feature PR:

### 1. Confirm the gate is green

```bash
gh pr checks       # Build & Test (CivicPermit) must be ✅
gh pr view         # shows required reviews / mergeability
```

If a review is required and you're solo on a fork, approve isn't possible on your own PR —
your instructor can approve, or temporarily set required approvals to `0` for the exercise.

### 2. Squash and merge

We recommend **squash** so the feature becomes one clean commit on `main`:

```bash
gh pr merge --squash --delete-branch
```

`gh` opens the squash commit message — make it meaningful (it feeds release notes in
Lab 08). Confirm.

> 💡 **CLI tip:** `gh pr merge --auto --squash --delete-branch` turns on **auto-merge** —
> the PR merges itself the moment required checks pass, so you don't have to babysit it.

### 3. Confirm the issue closed

Because your PR said `Closes #<issue-number>`, merging closes it:

```bash
gh issue view <issue-number>    # State: CLOSED
```

### 4. Sync your local `main`

```bash
git switch main
git pull
```

## ✅ Checkpoint

- [ ] Direct pushes to `main` are blocked.
- [ ] **Build & Test (CivicPermit)** is a required check.
- [ ] Your PR merged via **squash**, and the branch was deleted.
- [ ] Issue `#<issue-number>` is **closed**.
- [ ] Local `main` contains your feature (`git log --oneline -3`).

## Troubleshooting

- **Merge button disabled** → a required check is red or a required review is missing.
- **Can't approve your own PR** → expected; have a partner/instructor approve, or lower
  the required-approvals count for the workshop.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** Before approving a big PR, Copilot can summarize the diff so
> reviewers focus on what matters — covered in the Copilot workshop.

## ➡️ Next

[**Lab 08 — Cut a release**](lab-08-cut-a-release.md)
