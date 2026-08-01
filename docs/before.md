---
title: Before the Workshop
---

# Before the Workshop

[← Home](index.md)

Spend 20–30 minutes on this **the day before**. Coming in with tools installed means you
spend the workshop learning GitHub, not fighting setup.

## 1. Accounts & access

- [ ] You can sign in to your organization's **GitHub Enterprise** in a browser.
- [ ] You can create repositories (or you've been told which org/team to use).
- [ ] Your instructor has shared the workshop repository URL.

## 2. Install the tools

You need three tools. All are free and enterprise-approved in most environments.

| Tool | Why | Guide |
| ---- | --- | ----- |
| **Git** | Version control on your machine | [Git basics](guides/git-basics.md) |
| **.NET 10 SDK** | Build and test the sample app | [.NET SDK setup](guides/dotnet-sdk-setup.md) |
| **GitHub CLI (`gh`)** | Create issues, PRs, and releases from the terminal | [GitHub CLI setup](guides/github-cli-setup.md) |

Recommended (optional):

- **Visual Studio Code** with the **C# Dev Kit** extension — see [VS Code setup](guides/vscode-setup.md).
- Or, on Windows, full **Visual Studio 2022** — see [Visual Studio setup](guides/visual-studio-setup.md).

## 3. Verify your setup

Open a terminal and run each command. You should see a version number for each.

```bash
git --version
dotnet --version
gh --version
```

Expected (versions may differ slightly):

```
git version 2.4x or newer
10.0.xxx
gh version 2.5x or newer
```

## 4. Sign in to the GitHub CLI

```bash
gh auth login
```

Choose **GitHub Enterprise Cloud** (or your server host), authenticate in the browser, and
pick **HTTPS** when asked about Git protocol. Confirm it worked:

```bash
gh auth status
```

## 5. Grab the code

Your instructor will tell you whether to **fork** the workshop repo or clone a copy in a
shared org. Everyone can't use the same repo name, so pick a personal one in the format
**`<yourname>-gh-training`** (lowercase, hyphens, no spaces) — e.g. `alex-gh-training`.
Once you have a URL:

```bash
git clone https://github.com/<your-org>/<yourname>-gh-training.git
cd <yourname>-gh-training
dotnet test
```

If the summary shows **`failed: 0, succeeded: 5`** (older SDKs print `Passed!` instead —
either means green), you're ready. If not, check [Troubleshooting](troubleshooting.md).

> 🍴 **Forking the repo?** A brand-new fork starts with **Issues and Actions turned off**, and
> its pull requests default to targeting the **upstream** repo rather than your fork. You'll
> enable each when you first need it (Labs 1 and 4) and aim your PR at your own fork (Lab 3.1) —
> [Lab 0](labs/lab-00-setup.md) walks through it. *(Running an org-hosted clone instead of a
> fork? These are usually already set.)*

## 6. Instructor-only: bootstrap your copy (recommended)

If you're hosting the workshop from this template, run the bootstrap/preflight once before
class to replace org placeholders and validate settings:

- [Workshop bootstrap + preflight guide](guides/workshop-bootstrap-preflight.md)

---

Having trouble? That's what [Troubleshooting](troubleshooting.md) is for — and your
instructor will help during **Module 0**.
