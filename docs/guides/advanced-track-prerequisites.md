---
title: "Advanced-Track Prerequisites & Difficulty Matrix"
---

# Advanced-Track Prerequisites & Difficulty Matrix

The optional architect labs (10–14) go beyond the core workflow into **enterprise controls**.
Unlike the core labs (0–7), several depend on your **plan tier**, **admin/owner rights**, a **cloud
subscription**, or **GitHub Advanced Security (GHAS)**. Use this page to decide, per cohort,
which labs are **hands-on** vs **instructor-demo**.

## Feasibility at a glance

| Lab | Needs | Free public repo | Free private repo | Team/Enterprise |
|-----|-------|:---:|:---:|:---:|
| [10 Environments & Approvals](../labs/lab-09-environments-and-approvals.md) | Repo admin | 🟢 | 🔴 rules ignored | 🟢 |
| [11 OIDC Deployments (Azure)](../labs/lab-10-oidc-azure-deploy.md) | Azure tenant admin + subscription | 🟠 GitHub side only | 🟠 GitHub side only | 🟢 |
| [12 Reusable Workflows](../labs/lab-11-reusable-workflows.md) | Repo write (same-repo) | 🟢 | 🟢 | 🟢 |
| [13 Rulesets as Code](../labs/lab-12-rulesets-as-code.md) | Repo admin / org owner | 🟢 | 🟢 | 🟢 |
| [14 Security Policy Automation](../labs/lab-13-security-policy-automation.md) | GHAS for full scan set | 🟢 code+secret free | 🟠 needs GHAS | 🟢 |

🟢 fully hands-on · 🟠 partial / needs external resource · 🔴 demo only on this tier

## Constraints that add difficulty (know these before you teach)

### Lab 9 — Environments & Approvals
- **Protection rules are plan-gated.** Required reviewers, wait timers, and deployment-branch
  restrictions are **only enforced on public repos or private repos on Team/Enterprise**. A
  free-private repo can *create* environments, but the gates are silently ignored.
- **Self-approval is the default.** The user who triggers a deployment can approve their own run
  unless you add a different reviewer / enable "prevent self-review."
- **Environment secrets require the binding.** Only a job that declares `environment: <name>` can
  read that environment's secrets.

### Lab 10 — OIDC Deployments (Azure)
- **Cloud access is the real gate.** You need rights to create an **Entra app registration**, a
  **federated credential**, and an Azure **role assignment**. Most attendees lack this → demo in
  a sandbox subscription.
- **The subject claim is exact** and is the #1 failure. It must match the trigger:
  - Branch: `repo:<ORG>/<REPO>:ref:refs/heads/main`
  - Environment: `repo:<ORG>/<REPO>:environment:production`
  - Pull request: `repo:<ORG>/<REPO>:pull_request`
  A mismatch fails with opaque errors like `AADSTS700213` / "no matching federated identity."
- **`id-token: write` is not default.** It must be granted per job that requests OIDC.
- **Fork PRs get no id-token** by design — you cannot OIDC-deploy from a forked pull request.
- **Propagation + caps.** A newly created federated credential may take a minute to work, and
  there's a per-app-registration limit on the number of federated credentials.
- **GHES differs.** The OIDC issuer URL is different on GitHub Enterprise Server.

### Lab 11 — Reusable Workflows
- **Nesting limit: 4 levels.** A chain of reusable workflows can nest at most four deep.
- **Private sharing is opt-in.** A private reusable workflow must be shared via **Settings →
  Actions → General → Access** before another repo can call it.
- **Secrets don't flow automatically.** Use `secrets: inherit` or an explicit map; the callee's
  `GITHUB_TOKEN` cannot exceed the caller's granted permissions.
- **Cross-repo reuse needs a second repo** — provide a same-repo `uses: ./...` fallback if
  attendees only have one.

### Lab 12 — Rulesets as Code
- **Admin/owner required.** Repo rulesets need repo **admin**; org rulesets need **org owner**.
- **Signed commits are high-friction.** "Require signed commits" forces every contributor to set
  up **GPG/SSH/gitsign** or their pushes are rejected — a common blocker.
- **IDs aren't portable.** `bypass_actors` and required-check references are stored as
  **team/app/integration IDs**, which differ per org/repo; moving a ruleset across orgs requires
  remapping them.
- **Rulesets vs classic protection** can coexist and both apply — watch for confusing overlaps.

### Lab 13 — Security Policy Automation
- **GHAS gating.** On private repos, secret scanning, push protection, and code scanning need
  **GitHub Advanced Security**. Public repos get code + secret scanning free.
- **Token scope trap.** Security-read endpoints often need `security_events`/admin scope; the
  default `GITHUB_TOKEN` may return 403, forcing a **PAT secret** — which reintroduces stored
  secrets (scope it tightly; it's a teaching moment about the OIDC/env-scoping tradeoff).
- **Scheduled workflows are unreliable timers.** GitHub **auto-disables `schedule` triggers after
  ~60 days of repo inactivity**, and scheduled runs can be delayed under load. Don't mistake
  "nothing ran" for a bug — trigger manually to verify.

## Instructor prep checklist

- [ ] Decide per lab: **hands-on** or **demo** based on your cohort's tier and rights.
- [ ] For Lab 10, pre-create a **sandbox Azure subscription** + app registration you can screen-share.
- [ ] For Lab 11 cross-repo, pre-create a **platform-workflows** repo (or use the same-repo path).
- [ ] For Lab 12, decide whether to demo **signed commits** (skip if attendees aren't set up).
- [ ] For Lab 13, prepare a scoped **`AUDIT_TOKEN`** PAT if you want the full security read.
- [ ] Run `scripts/workshop-bootstrap.ps1`/`.sh` to replace placeholders before the session.

## See also

- [Environments & approvals module](../modules/09-environments-and-approvals.md)
- [OIDC deployments module](../modules/10-oidc-deployments.md)
- [Reusable workflows module](../modules/11-reusable-workflows.md)
- [Rulesets as code module](../modules/12-rulesets-as-code.md)
- [Security policy automation module](../modules/13-security-policy-automation.md)
- [Troubleshooting](../troubleshooting.md)
