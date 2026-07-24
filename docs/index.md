---
title: GitHub for Developers
---

# GitHub for Developers

A **6-hour, instructor-led workshop** for enterprise development teams on **GitHub
Enterprise**. You'll learn the everyday GitHub workflow by taking a single real feature
request all the way from an idea to a shipped release — on a small, self-contained
**.NET 10** sample application called **CivicPermit**.

> **One story, start to finish:**
> **Issue → Branch → Commit → Pull Request → Review → Workflow → Merge → Release**

> ⏱️ **On timing:** "6-hour" is the **teaching time** (modules + labs). With two breaks
> and lunch, plan a **~7.75-hour calendar day**. See the [agenda](agenda.md) for the full
> schedule and compressed-timing options.

---

## Start here

- 🧭 **Before the workshop:** [Prepare your machine](before.md)
- 📅 **The plan:** [6-hour agenda](agenda.md)

---

## Modules

| # | Module | Time |
| - | ------ | ---- |
| 0 | [Welcome & Setup](modules/00-welcome-and-setup.md) | 30 min |
| 1 | [The GitHub workflow & Issues](modules/01-github-workflow-and-issues.md) | 45 min |
| 2 | [Branching & Commits](modules/02-branching-and-commits.md) | 45 min |
| 3 | [Pull Requests & Review](modules/03-pull-requests-and-review.md) | 45 min |
| 4 | [GitHub Actions (CI)](modules/04-github-actions-ci.md) | 60 min |
| 5 | [Branch protection & Merge](modules/05-branch-protection-and-merge.md) | 45 min |
| 6 | [Releases](modules/06-releases.md) | 30 min |
| 7 | [Secure development](modules/07-secure-development.md) | 45 min |
| 8 | [Wrap-up & next steps](modules/08-wrap-up-and-next-steps.md) | 15 min |

## Optional architect hardening track

These advanced modules are designed for architect-level cohorts after the core workshop.
Each has a hands-on lab. **Read the [prerequisites & difficulty matrix](guides/advanced-track-prerequisites.md) first** — some labs are plan- or cloud-gated.

| Topic | Lab | Suggested Time |
| ----- | --- | -------------- |
| [Environments & approvals](modules/09-environments-and-approvals.md) | [Lab 9](labs/lab-09-environments-and-approvals.md) | 30 min |
| [OIDC deployments](modules/10-oidc-deployments.md) | [Lab 10](labs/lab-10-oidc-azure-deploy.md) | 40 min |
| [Reusable workflows](modules/11-reusable-workflows.md) | [Lab 11](labs/lab-11-reusable-workflows.md) | 30 min |
| [Rulesets as code](modules/12-rulesets-as-code.md) | [Lab 12](labs/lab-12-rulesets-as-code.md) | 30 min |
| [Security policy automation](modules/13-security-policy-automation.md) | [Lab 13](labs/lab-13-security-policy-automation.md) | 30 min |

## Labs

| Lab | Advances the story to… |
| --- | ---------------------- |
| [Lab 0 — Setup](labs/lab-00-setup.md) | A working local clone that builds and tests |
| [Lab 1 — Open the Issue](labs/lab-01-open-the-issue.md) | **Issue** |
| [Lab 2.1 — Branch & first commit](labs/lab-02-1-branch-and-first-commit.md) | **Branch → Commit** |
| [Lab 2.2 — Implement the endpoint & test](labs/lab-02-2-implement-endpoint-and-test.md) | **Commit** (the feature) |
| [Lab 3.1 — Open a pull request](labs/lab-03-1-open-pull-request.md) | **Pull Request** |
| [Lab 3.2 — Review, feedback & roll back](labs/lab-03-2-review-and-address-feedback.md) | **Review** |
| [Lab 4 — Author the CI workflow](labs/lab-04-author-ci-workflow.md) | **Workflow** |
| [Lab 5 — Branch protection & merge](labs/lab-05-branch-protection-and-merge.md) | **Merge** |
| [Lab 6 — Cut a release](labs/lab-06-cut-a-release.md) | **Release** |
| [Lab 7 — Secure the repository](labs/lab-07-secure-development.md) | Hardening the same repo |

### Advanced-track labs (optional)

Companion labs for the architect hardening modules. Check the
[prerequisites & difficulty matrix](guides/advanced-track-prerequisites.md) before running them.

| Lab | Focus |
| --- | ----- |
| [Lab 9 — Environments & approvals](labs/lab-09-environments-and-approvals.md) | Promotion gates & env-scoped secrets |
| [Lab 10 — OIDC deployments (Azure)](labs/lab-10-oidc-azure-deploy.md) | Keyless deploy via federated identity |
| [Lab 11 — Reusable workflows](labs/lab-11-reusable-workflows.md) | `workflow_call` + thin callers |
| [Lab 12 — Rulesets as code](labs/lab-12-rulesets-as-code.md) | Governance as version-controlled JSON |
| [Lab 13 — Security policy automation](labs/lab-13-security-policy-automation.md) | Scheduled audit + evidence artifact |

## Reference

- 📌 **Cheat sheets:** [Git](cheatsheets/git-commands.md) · [GitHub CLI](cheatsheets/gh-cli.md) · [dotnet CLI](cheatsheets/dotnet-cli.md) · [Markdown & PRs](cheatsheets/markdown-and-pr.md) · [Actions YAML](cheatsheets/actions-yaml.md)
- 📚 **Guides:** [Git basics](guides/git-basics.md) · [.NET SDK setup](guides/dotnet-sdk-setup.md) · [GitHub CLI setup](guides/github-cli-setup.md) · [VS Code setup](guides/vscode-setup.md) · [Conventional Commits](guides/conventional-commits.md) · [Workshop bootstrap + preflight](guides/workshop-bootstrap-preflight.md) · [Advanced-track prerequisites](guides/advanced-track-prerequisites.md)
- 🛠️ **[Troubleshooting](troubleshooting.md)**

---

## About the sample app

**CivicPermit** is a fictional public-sector **Residential Permit & Inspection Tracker**.
It's a single ASP.NET Core Minimal API backed by an in-memory store — **no database, no
external services, no PII**. The recurring feature you'll build is:

> **"Add the ability to schedule an inspection for an existing permit."**

---

> 💡 **Copilot Connection:** A separate follow-up workshop covers **GitHub Copilot** in
> depth. You'll spot short *Copilot Connection* notes throughout these materials — but no
> lab depends on Copilot, so everything works whether or not it's enabled.
