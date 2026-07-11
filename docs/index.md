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
- 🧑‍🏫 **Instructors:** [Facilitation guide](instructor/facilitation-guide.md)

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

## Labs

| Lab | Advances the story to… |
| --- | ---------------------- |
| [Lab 00 — Setup](labs/lab-00-setup.md) | A working local clone that builds and tests |
| [Lab 01 — Open the Issue](labs/lab-01-open-the-issue.md) | **Issue** |
| [Lab 02 — Branch & first commit](labs/lab-02-branch-and-first-commit.md) | **Branch → Commit** |
| [Lab 03 — Implement the endpoint & test](labs/lab-03-implement-endpoint-and-test.md) | **Commit** (the feature) |
| [Lab 04 — Open a pull request](labs/lab-04-open-pull-request.md) | **Pull Request** |
| [Lab 05 — Review & address feedback](labs/lab-05-review-and-address-feedback.md) | **Review** |
| [Lab 06 — Author the CI workflow](labs/lab-06-author-ci-workflow.md) | **Workflow** |
| [Lab 07 — Branch protection & merge](labs/lab-07-branch-protection-and-merge.md) | **Merge** |
| [Lab 08 — Cut a release](labs/lab-08-cut-a-release.md) | **Release** |
| [Lab 09 — Secure the repository](labs/lab-09-secure-development.md) | Hardening the same repo |

## Reference

- 📌 **Cheat sheets:** [Git](cheatsheets/git-commands.md) · [GitHub CLI](cheatsheets/gh-cli.md) · [dotnet CLI](cheatsheets/dotnet-cli.md) · [Markdown & PRs](cheatsheets/markdown-and-pr.md) · [Actions YAML](cheatsheets/actions-yaml.md)
- 📚 **Guides:** [Git basics](guides/git-basics.md) · [.NET SDK setup](guides/dotnet-sdk-setup.md) · [GitHub CLI setup](guides/github-cli-setup.md) · [VS Code setup](guides/vscode-setup.md) · [Conventional Commits](guides/conventional-commits.md)
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
