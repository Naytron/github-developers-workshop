---
title: "Guide — Visual Studio Setup (Optional)"
---

# Guide — Visual Studio Setup (Optional)

[← Home](../index.md)

Full **Visual Studio** is an **optional** alternative to the terminal (and to
[VS Code](vscode-setup.md)). Every lab still lists the exact `git`, `gh`, and `dotnet`
commands, so the CLI remains the canonical path — this guide just shows the equivalent
**in-IDE** flow for the steps that map cleanly to Visual Studio.

> **Visual Studio only replaces the *local* half of the workflow.** Opening issues, setting
> branch protection, cutting releases, and configuring security have **no Visual Studio
> equivalent** — you'll still use GitHub.com or the `gh` CLI for those. See
> [What Visual Studio does *not* cover](#what-visual-studio-does-not-cover) below.

## Before you choose Visual Studio

| Consideration | What to know |
| --- | --- |
| **Platform** | Visual Studio is **Windows-only**. On macOS/Linux use [VS Code](vscode-setup.md) + the CLI. |
| **Licensing** | **Community** edition has eligibility limits (org size/revenue); a government agency typically needs **Professional** or **Enterprise**. VS Code and the CLI are free. Confirm your org's licensing before class. |
| **Version** | Use a current **Visual Studio 2022 (latest 17.x)** so the **.NET 10 SDK** and **built-in GitHub features** are available. |
| **Extensions** | Prefer the **built-in** GitHub features (Git menu → GitHub) so you don't depend on a Marketplace extension that may be blocked in a locked-down environment. |

## Install Visual Studio

- Download from your org's software portal, or <https://visualstudio.microsoft.com/>.
- In the **Visual Studio Installer**, select the **"ASP.NET and web development"** workload.
  This bundles the **.NET SDK** and **Git for Windows**, so you don't install them
  separately.
- Launch Visual Studio and confirm the **.NET 10 SDK** is available. If `dotnet --version`
  in the Developer PowerShell doesn't start with `10.`, follow
  [.NET SDK setup](dotnet-sdk-setup.md).

## Sign in to GitHub

- **File → Account Settings… → All accounts → Add → GitHub** (choose **GitHub Enterprise**
  if your org uses it), and authenticate in the browser.
- This lets Visual Studio clone, push, and create pull requests without a separate
  `gh auth login` — though you may still want the [GitHub CLI](github-cli-setup.md) for the
  issue/release/review steps VS can't do.

## Open the project

- **File → Open → Project/Solution…** and pick **`CivicPermit.sln`** from the folder you
  cloned in [Lab 0](../labs/lab-00-setup.md).

## Build, test & run from the IDE

| Task | In Visual Studio | CLI equivalent |
| --- | --- | --- |
| **Build** | **Build → Build Solution** (`Ctrl+Shift+B`) | `dotnet build` |
| **Run the tests** | **Test → Run All Tests**, then read results in **Test Explorer** | `dotnet test` |
| **Run / debug the API** | Press **F5** (Debug) or **Ctrl+F5** (without debugging); the launch URL opens automatically | `dotnet run --project src/CivicPermit.Api` |

> **Test Explorer** lists each xUnit test with pass/fail and lets you run just the new
> `Inspections` tests — the IDE equivalent of `dotnet test --filter`.

## Source control — the Git Changes window

Visual Studio's built-in Git tooling covers the local loop:

| Task | In Visual Studio | CLI equivalent |
| --- | --- | --- |
| **Get latest `main`** | Branch picker (bottom-right) → check out **main** → **Git → Pull** | `git switch main && git pull` |
| **New feature branch** | **Git → New Branch…** (base it on `main`) | `git switch -c feature/…` |
| **Stage & commit** | **Git Changes** window → stage files → type a message → **Commit All** | `git add … && git commit` |
| **Push** | **Git → Push** (first push publishes the branch) | `git push -u origin …` |

> Multi-line commit messages: type the summary on the first line, then a blank line and the
> body, right in the Git Changes message box.

## Create a pull request

- **Git → GitHub → Create Pull Request** (built into recent Visual Studio 2022). Set the
  **base** to `main`, add a title and body, and create it.

> ⚠️ Visual Studio's PR compose form does **not** load the repo's
> `PULL_REQUEST_TEMPLATE.md` or apply labels the way the web form does. For the full
> template experience (and to add `Closes #<issue-number>`), use `gh pr create --web` or open
> the PR on GitHub.com — the labs show both.

## What Visual Studio does *not* cover

For these steps, stay in the **browser** or the **`gh` CLI** — there is no Visual Studio
equivalent:

| Workshop step | Where to do it instead |
| --- | --- |
| **Open the issue** ([Lab 1](../labs/lab-01-open-the-issue.md)) | GitHub.com **Issues → New issue**, or `gh issue create --web` |
| **Review / comment on a PR** ([Lab 3.2 Part A](../labs/lab-03-2-review-and-address-feedback.md)) | GitHub.com **Files changed** (in-IDE review is limited) |
| **Author the CI workflow** ([Lab 4](../labs/lab-04-author-ci-workflow.md)) | VS edits YAML but has no Actions schema help — use [VS Code](vscode-setup.md) or the web editor |
| **Branch protection & merge** ([Lab 5](../labs/lab-05-branch-protection-and-merge.md)) | GitHub.com **Settings → Rules/Branches** |
| **Cut a release** ([Lab 6](../labs/lab-06-cut-a-release.md)) | `gh release create`, or GitHub.com **Releases** |
| **Secure the repo** ([Lab 7](../labs/lab-07-secure-development.md)) | GitHub.com **Security** tab (Dependabot, code scanning) |

## Where you'll see Visual Studio callouts

The labs that convert cleanly to the IDE carry an optional **🖱️ In Visual Studio**
callout you can expand:

- [Lab 2.1 — Branch & first commit](../labs/lab-02-1-branch-and-first-commit.md)
- [Lab 2.2 — Implement the endpoint & test](../labs/lab-02-2-implement-endpoint-and-test.md)
- [Lab 3.1 — Open a pull request](../labs/lab-03-1-open-pull-request.md)
- [Lab 3.2 — Review, feedback & roll back](../labs/lab-03-2-review-and-address-feedback.md) (Part B)

## If you prefer the terminal

Every lab lists the exact `git`, `gh`, and `dotnet` commands, so you can do the entire
workshop from a shell — or mix and match, e.g. edit and test in Visual Studio but open
issues and releases with `gh`.

> 💡 **Copilot Connection:** Visual Studio also ships **GitHub Copilot** and **Copilot
> Chat**. The follow-up Copilot workshop builds on this same setup — so installing the IDE
> now sets you up for both.
