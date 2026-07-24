---
title: "Lab 00 — Setup"
---

# Lab 00 — Setup

⏱️ ~20 min · Module: [Welcome & Setup](../modules/00-welcome-and-setup.md) · [← Home](../index.md)

**Goal:** a working local clone of CivicPermit that **builds and tests green**, plus a
signed-in GitHub CLI.

## Prerequisites

- Git, the .NET 10 SDK, and the GitHub CLI installed
  ([Before the Workshop](../before.md)).
- Access to your organization's GitHub Enterprise.

## Steps

### 1. Verify your tools

```bash
git --version
dotnet --version   # must start with 10.
gh --version
```

If `dotnet --version` doesn't start with `10.`, see [.NET SDK setup](../guides/dotnet-sdk-setup.md).

### 2. Sign in to the GitHub CLI

```bash
gh auth login
gh auth status
```

Pick your enterprise host, authenticate in the browser, and choose **HTTPS** for Git
operations.

### 3. Get the code

The workshop repo lives at [Naytron/github-developers-workshop](https://github.com/Naytron/github-developers-workshop).

Your instructor will tell you whether to **fork** or clone into a shared org.

> 🏷️ **Pick your repo name first.** Everyone in the room can't use the same repo name, so
> choose a personal one in the format **`<yourname>-gh-training`** (lowercase, hyphens, no
> spaces) — e.g. `alex-gh-training`. Use that **same name** everywhere below.

With `gh` (replace `<yourname>` and `<src-org>` — the org you're forking **from**):

```bash
# Option A — fork to your account with a personal name, and clone in one step
gh repo fork <src-org>/github-developers-workshop \
  --fork-name <yourname>-gh-training --clone

# Option B — clone a repo already created for you in a shared org
gh repo clone <src-org>/<yourname>-gh-training <yourname>-gh-training
```

```powershell
# Option A — fork to your account with a personal name, and clone in one step
gh repo fork <src-org>/github-developers-workshop `
  --fork-name <yourname>-gh-training --clone

# Option B — clone a repo already created for you in a shared org
gh repo clone <src-org>/<yourname>-gh-training <yourname>-gh-training
```

> 💡 Prefer the web UI? You can also open
> [Naytron/github-developers-workshop](https://github.com/Naytron/github-developers-workshop)
> and click **Fork** to create your own copy, then clone it.

Then move into the folder `gh` just created:

```bash
cd <yourname>-gh-training
```

Confirm your remotes are wired up correctly:

```bash
git remote -v
```

You should see **`origin`** pointing at *your* fork (`<yourname>-gh-training`). If you
forked (Option A), `gh` also adds an **`upstream`** remote pointing at the original
`<src-org>/github-developers-workshop` — that's how you'll pull in updates later.

### 4. Set your Git identity

Git stamps every commit with a name and email, so set them before you commit anything.
Use the **same email** that's on your GitHub account so your commits link back to your
profile.

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Confirm they're set:

```bash
git config --global user.name
git config --global user.email
```

> 💡 The `--global` flag sets this for every repo on your machine. Drop it to configure
> just the current repo (handy if you use a different identity per project).

> ✍️ **Skip Vim.** By default Git opens commit messages in Vim. To use VS Code instead,
> run `git config --global core.editor "code --wait"` — Git will open a tab and wait for
> you to save and close it before continuing.

### 5. Build and test

```bash
dotnet test
```

You should see:

```
Test summary: total: 5, failed: 0, succeeded: 5, skipped: 0, duration: 1.1s
Build succeeded in 5.5s (or other)
```

### 6. Run the app (optional but fun)

```bash
dotnet run --project src/CivicPermit.Api
```

Note the URL it prints (e.g., `http://localhost:5150`). In another terminal:

```bash
curl http://localhost:5150/permits
```

```powershell
Invoke-RestMethod http://localhost:5150/permits
```

You'll see the two seeded permits as JSON. Press `Ctrl+C` to stop the app.

> 💡 **CLI tip:** `gh browse` opens this repo in your browser at the current branch — no
> hunting for the URL. Set up conveniences once: `gh config set editor "code --wait"` and
> `gh alias set co 'pr checkout'` (then you can type `gh co <number>`).

> ⌨️ **Hotkey:** In the terminal, **`Ctrl+C`** stops a running process — you'll use it to
> stop `dotnet run` and `dotnet watch` throughout the workshop.

## ✅ Checkpoint

- [ ] `git`, `dotnet` (10.x), and `gh` all report versions.
- [ ] `gh auth status` shows you're logged in.
- [ ] You have a local clone of the repo (`origin` points at your `<yourname>-gh-training`).
- [ ] `git config --global user.name` and `user.email` return your details.
- [ ] `dotnet test` prints **Test summary: … succeeded: 5**.

## Troubleshooting

- `dotnet restore` hangs → corporate proxy/NuGet feed. See [Troubleshooting](../troubleshooting.md).
- `gh auth login` can't open a browser → use the one-time device code it offers.

## ➡️ Next

[**Lab 01 — Open the Issue**](lab-01-open-the-issue.md)
