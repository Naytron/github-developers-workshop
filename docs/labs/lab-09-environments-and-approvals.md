---
title: "Lab 9 — Environments & Approvals"
---

# Lab 9 — Environments & Approvals

⏱️ ~30 min · Optional architect extension · Module: [Environments & Approvals](../modules/09-environments-and-approvals.md) · [← Home](../index.md)

**Goal:** put a human approval gate between "build passed" and "deployed to production"
using GitHub **Environments**, scope secrets per environment, and restrict production
deploys to `main`.

> ⚠️ **Entitlement check first.** Environment **protection rules** (required reviewers, wait
> timers, branch restrictions) are only enforced on **public repos** or **private repos on
> GitHub Team/Enterprise**. On a **free private** repo you can *create* environments, but the
> rules are silently ignored. See the [Advanced-track prerequisites](../guides/advanced-track-prerequisites.md)
> matrix. If you're gated, run this as an **instructor demo**.

## Step 1 — Create the environments

**Settings → Environments → New environment.** Create `staging` and `production`.

Or from the CLI:

```bash
# Bash
gh api -X PUT repos/{owner}/{repo}/environments/staging >/dev/null && echo "staging created"
gh api -X PUT repos/{owner}/{repo}/environments/production >/dev/null && echo "production created"

# PowerShell
gh api -X PUT repos/{owner}/{repo}/environments/staging | Out-Null; "staging created"
gh api -X PUT repos/{owner}/{repo}/environments/production | Out-Null; "production created"
```

## Step 2 — Require a reviewer on `production`

**Settings → Environments → production → Required reviewers.** Add yourself or a teammate.

> 🧠 **Gotcha:** by default the person who triggers a deployment **can approve their own
> run**. For true separation of duties, add a *different* reviewer, or enable
> "Prevent self-review" if your plan offers it.

## Step 3 — Restrict `production` to `main`

Still on the `production` environment, set **Deployment branches → Selected branches** and add
`main`. Now only the default branch can deploy to production.

## Step 4 — Move secrets to the environment (not the repo)

Repo-level secrets are visible to **every** workflow. Environment secrets are only readable by
a job that declares `environment: <name>`. Put deployment secrets where they belong:

```bash
gh secret set DEPLOY_TARGET --env production --body "civicpermit-prod"
```

## Step 5 — Gate a job on the environment

The repo ships a deploy workflow at `.github/workflows/deploy-oidc-azure.yml`. The key lines
are the environment binding — a job only pauses for approval when it targets a protected
environment:

```yaml
jobs:
  deploy:
    environment:
      name: production   # <-- triggers the approval gate + branch restriction
```

Trigger it:

```bash
gh workflow run deploy-oidc-azure.yml --ref main
gh run watch
```

The run should **pause** on "Waiting for review." Approve it from the Actions run page (or
`gh run view`) and watch it proceed.

## ✅ Checkpoint

- [ ] `staging` and `production` environments exist.
- [ ] `production` requires a reviewer.
- [ ] `production` deploys are restricted to `main`.
- [ ] At least one secret lives at the **environment** scope, not repo scope.
- [ ] A deployment job **paused for approval** (or you demoed why it can't on this plan).

## Troubleshooting

- **The job didn't pause** → your repo plan doesn't enforce protection rules (free private).
  Confirm in the [prerequisites matrix](../guides/advanced-track-prerequisites.md); demo on a
  public repo instead.
- **You approved your own deploy** → expected default; add a second reviewer for real SoD.
- **Secret not found in the job** → the job must declare `environment:` to read env secrets.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** ask Copilot to draft the `environment:` block and a matching
> deployment-branch policy, then review *why* each line matters — the reasoning is the skill.

## Next

Continue to [Lab 10 — OIDC Deployments (Azure)](lab-10-oidc-azure-deploy.md).
