# GitHub for Developers — Instructor-Led Workshop

A complete, self-contained **6-hour, instructor-led workshop** that teaches enterprise
development teams the everyday GitHub workflow on **GitHub Enterprise**, using a single
running story and one small **.NET 10** sample application.

This repository is two things at once:

1. **A GitHub Pages website** (`docs/`) used **before, during, and after** the workshop.
2. **A companion training repo** with the sample app, labs, guides, cheat sheets,
   instructor notes, and troubleshooting content.

If you are running this workshop as an instructor, start with the
[bootstrap + preflight guide](docs/guides/workshop-bootstrap-preflight.md) to replace org
placeholders and validate repo settings before attendees join.

---

## The narrative spine

Every lab and demo advances **one** story — a single developer working a real feature
request from start to finish:

```
Issue → Branch → Commit → Pull Request → Review → Workflow → Merge → Release
```

The recurring feature request is:

> **"Add the ability to schedule an inspection for an existing permit."**

You implement it end-to-end: open an Issue, create a branch, add the endpoint, write an
xUnit test, open a pull request, get a review, watch CI run, merge with branch
protection, and cut a release.

---

## The sample application — CivicPermit

**CivicPermit** is a fictional, generic public-sector app: a **Residential Permit &
Inspection Tracker** for a state/local government agency that issues building and
land-use permits. Staff intake an application, track it through review stages, schedule
inspections, and record the final decision.

- **Stack:** a single ASP.NET Core **Minimal API** targeting **.NET 10 (LTS)**.
- **Storage:** an in-memory store — **no database, no external services, no PII**.
- **Tests:** xUnit (`dotnet new xunit`), restored via **NuGet only**.
- **Everything** runs with the `dotnet` CLI, identically on hosted runners and
  locked-down machines.

Endpoints:

| Method | Route | Description |
| ------ | ----- | ----------- |
| `GET`  | `/permits` | List all permits |
| `POST` | `/permits` | Intake a new permit |
| `GET`  | `/permits/{id}` | Get a single permit |
| `POST` | `/permits/{id}/inspections` | **You build this during the workshop** |

---

## Quick start

> Prerequisites: **Git**, the **.NET 10 SDK**, and the **GitHub CLI (`gh`)**.
> VS Code (with the optional C# Dev Kit) is recommended. See
> [docs/guides/dotnet-sdk-setup.md](docs/guides/dotnet-sdk-setup.md) and
> [docs/guides/github-cli-setup.md](docs/guides/github-cli-setup.md).

```bash
# 1. Clone your fork
git clone https://github.com/<your-org>/github-developers-workshop.git
cd github-developers-workshop

# 2. Restore, build, and test
dotnet test

# 3. Run the API
dotnet run --project src/CivicPermit.Api

# 4. In another terminal, try it out
curl http://localhost:5150/permits                # Bash
Invoke-RestMethod http://localhost:5150/permits   # PowerShell
```

The port is printed on startup (typically `http://localhost:5150`).

---

## Repository layout

```
.
├── src/CivicPermit.Api/           # The sample Minimal API (starter — no inspections endpoint yet)
├── tests/CivicPermit.Api.Tests/   # xUnit integration tests (ship green)
├── solutions/                     # Reference implementation of the workshop feature
├── .github/                       # Issue/PR templates, CODEOWNERS, Dependabot, workflows
│   └── workflows/
│       ├── ci.yml                 # Build + test (the required status check)
│       ├── pages.yml              # Builds and deploys the GitHub Pages site
│       └── release.yml            # Optional: publishes a release on tag push
├── docs/                          # The GitHub Pages website + all workshop content
│   ├── modules/                   # Core modules + optional architect hardening track
│   ├── labs/                      # Hands-on labs (lab-00 … lab-07 core, + advanced lab-09 … lab-13)
│   ├── guides/                    # Setup and reference guides
│   ├── cheatsheets/               # One-page command references
│   └── troubleshooting.md
├── scripts/                       # Instructor bootstrap + preflight automation
├── global.json                    # Pins the .NET SDK band
├── CivicPermit.sln
└── README.md
```

---

## The workshop at a glance

| # | Module | Lab |
| - | ------ | --- |
| 0 | [Welcome & Setup](docs/modules/00-welcome-and-setup.md) | [Lab 0 — Setup](docs/labs/lab-00-setup.md) |
| 1 | [The GitHub workflow & Issues](docs/modules/01-github-workflow-and-issues.md) | [Lab 1 — Open the Issue](docs/labs/lab-01-open-the-issue.md) |
| 2 | [Branching & Commits](docs/modules/02-branching-and-commits.md) | [Lab 2.1 — Branch & first commit](docs/labs/lab-02-1-branch-and-first-commit.md) · [Lab 2.2 — Implement the endpoint & test](docs/labs/lab-02-2-implement-endpoint-and-test.md) |
| 3 | [Pull Requests & Review](docs/modules/03-pull-requests-and-review.md) | [Lab 3.1 — Open a pull request](docs/labs/lab-03-1-open-pull-request.md) · [Lab 3.2 — Review, feedback & roll back](docs/labs/lab-03-2-review-and-address-feedback.md) |
| 4 | [GitHub Actions (CI)](docs/modules/04-github-actions-ci.md) | [Lab 4 — Author the CI workflow](docs/labs/lab-04-author-ci-workflow.md) |
| 5 | [Branch protection & Merge](docs/modules/05-branch-protection-and-merge.md) | [Lab 5 — Protect & merge](docs/labs/lab-05-branch-protection-and-merge.md) |
| 6 | [Releases](docs/modules/06-releases.md) | [Lab 6 — Cut a release](docs/labs/lab-06-cut-a-release.md) |
| 7 | [Secure development](docs/modules/07-secure-development.md) | [Lab 7 — Secure the repo](docs/labs/lab-07-secure-development.md) |
| 8 | [Wrap-up & next steps](docs/modules/08-wrap-up-and-next-steps.md) | — |

## Optional architect hardening track

After the 6-hour core workshop, run this optional extension for cloud solution architects.
Each module has a companion hands-on lab; start with the
[prerequisites & difficulty matrix](docs/guides/advanced-track-prerequisites.md) since some
labs are plan- or cloud-gated.

| Topic | Lab |
| - | - |
| [Environments & approvals](docs/modules/09-environments-and-approvals.md) | [Lab 9](docs/labs/lab-09-environments-and-approvals.md) |
| [OIDC deployments](docs/modules/10-oidc-deployments.md) | [Lab 10](docs/labs/lab-10-oidc-azure-deploy.md) |
| [Reusable workflows](docs/modules/11-reusable-workflows.md) | [Lab 11](docs/labs/lab-11-reusable-workflows.md) |
| [Rulesets as code](docs/modules/12-rulesets-as-code.md) | [Lab 12](docs/labs/lab-12-rulesets-as-code.md) |
| [Security policy automation](docs/modules/13-security-policy-automation.md) | [Lab 13](docs/labs/lab-13-security-policy-automation.md) |

---

## Copilot connection

A separate follow-up workshop covers **GitHub Copilot** in depth. Throughout these
materials you'll see short **💡 Copilot Connection** callouts where Copilot naturally
helps (commit messages, PR descriptions, code review, writing tests, authoring workflow
YAML). No lab depends on Copilot — everything works whether or not it is enabled.

---

## Enterprise-lockdown guarantees

- **No** NPM, Node.js, or package installs beyond `dotnet restore` (NuGet).
- **No** third-party GitHub Actions — only GitHub-owned actions are used.
- **No** Jekyll plugins — the site uses a GitHub-supported theme built by GitHub-owned
  actions.
- Releases are created with the **GitHub CLI** (`gh release create`), not a third-party
  action.

---

## License

[MIT](LICENSE). CivicPermit is fictional; any resemblance to a real agency or system is
coincidental. No real customer name, PII, or data is used anywhere in this repository.
