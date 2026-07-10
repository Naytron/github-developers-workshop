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
shared org. Once you have a URL:

```bash
git clone https://github.com/<your-org>/github-developers-workshop.git
cd github-developers-workshop
dotnet test
```

If you see **`Passed!`**, you're ready. If not, check [Troubleshooting](troubleshooting.md).

---

Having trouble? That's what [Troubleshooting](troubleshooting.md) is for — and your
instructor will help during **Module 0**.
