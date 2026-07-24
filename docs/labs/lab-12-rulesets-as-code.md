---
title: "Lab 12 — Rulesets as Code"
---

# Lab 12 — Rulesets as Code

⏱️ ~30 min · Optional architect extension · Module: [Rulesets as Code](../modules/12-rulesets-as-code.md) · [← Home](../index.md)

**Goal:** manage branch protection as **version-controlled JSON**. You'll create a `main`
ruleset, **export** it, store the definition in the repo, and **re-import** it to prove your
governance is repeatable across repositories.

> ⚠️ **Permissions:** repo rulesets need **admin** on the repo; **org** rulesets need
> **org-owner**. See the [prerequisites matrix](../guides/advanced-track-prerequisites.md).

## Step 1 — Create a ruleset for `main`

**Settings → Rules → Rulesets → New branch ruleset.** Target the default branch and enable:

- **Require a pull request before merging** (1 approval).
- **Require status checks** → add `Build & Test (CivicPermit)`.
- **Block force pushes** and **restrict deletions**.
- **Bypass list:** keep it minimal (e.g. Repository admin only).

## Step 2 — Export the ruleset to JSON

List and export via the API:

```bash
# Bash
# find the ruleset id
gh api repos/{owner}/{repo}/rulesets --jq '.[] | "\(.id)\t\(.name)"'
# export it (replace <ID>)
gh api repos/{owner}/{repo}/rulesets/<ID> > docs/assets/rulesets/main-protection.exported.json

# PowerShell
gh api repos/{owner}/{repo}/rulesets --jq '.[] | "\(.id)`t\(.name)"'
gh api repos/{owner}/{repo}/rulesets/<ID> | Out-File -Encoding utf8 docs/assets/rulesets/main-protection.exported.json
```

## Step 3 — Compare against the shipped template

The repo ships a portable definition at
`docs/assets/rulesets/main-protection.ruleset.json`. It uses `~DEFAULT_BRANCH` so it applies to
any repo's default branch without editing:

```bash
# Bash
cat docs/assets/rulesets/main-protection.ruleset.json

# PowerShell
Get-Content docs/assets/rulesets/main-protection.ruleset.json
```

## Step 4 — Re-import to prove repeatability

Apply the template as a **new** ruleset (or in a second repo) straight from JSON:

```bash
# PowerShell: swap the trailing \ for a backtick `
gh api -X POST repos/{owner}/{repo}/rulesets \
  --input docs/assets/rulesets/main-protection.ruleset.json
```

You just applied governance from source control — no clicking.

> 🧠 **Portability gotcha:** `bypass_actors` reference **team/app IDs**, and required checks
> reference **integration IDs**, which differ per org/repo. When moving a ruleset between orgs
> you must **remap those IDs**; the branch/PR/deletion rules port cleanly.

## Step 5 — (Optional) Require signed commits

Add a **Require signed commits** rule to see enterprise-grade control — and its cost.

> ⚠️ **High-friction:** every contributor must configure **GPG, SSH, or gitsign** signing or
> their pushes are **rejected**. This is a frequent workshop blocker; enable it as a demo unless
> your cohort already signs commits.

## ✅ Checkpoint

- [ ] A `main` ruleset enforces PR + the CI status check.
- [ ] You exported the live ruleset to JSON.
- [ ] The portable template is understood and stored in source control.
- [ ] You re-imported a ruleset from JSON (or demoed it).
- [ ] You can explain why `bypass_actors`/check IDs need remapping across orgs.

## Troubleshooting

- **`Resource not accessible by integration` / 403** → you're not repo admin / org owner.
- **Import fails on `bypass_actors`** → the actor IDs don't exist in this repo/org; remove or
  remap them.
- **Status check never becomes required** → the check name must match the job name exactly
  (`Build & Test (CivicPermit)`), and it must have reported at least once.
- **Push rejected after Step 5** → set up commit signing or drop the signed-commits rule.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** ask Copilot to diff two exported ruleset JSON files and summarize
> the governance drift in plain English.

## Next

Continue to [Lab 13 — Security Policy Automation](lab-13-security-policy-automation.md).
