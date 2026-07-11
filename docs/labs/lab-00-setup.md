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

Your instructor will tell you whether to **fork** or clone into a shared org. With `gh`:

```bash
# Option A — fork to your account and clone in one step
gh repo fork <your-org>/github-developers-workshop --clone

# Option B — clone a repo you already have access to
gh repo clone <your-org>/github-developers-workshop
```

Then:

```bash
cd github-developers-workshop
```

### 4. Build and test

```bash
dotnet test
```

You should see:

```
Passed!  - Failed:     0, Passed:     5, Skipped:     0, Total:     5
```

### 5. Run the app (optional but fun)

```bash
dotnet run --project src/CivicPermit.Api
```

Note the URL it prints (e.g., `http://localhost:5150`). In another terminal:

```bash
curl http://localhost:5150/permits
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
- [ ] You have a local clone of the repo.
- [ ] `dotnet test` prints **Passed! … Passed: 5**.

## Troubleshooting

- `dotnet restore` hangs → corporate proxy/NuGet feed. See [Troubleshooting](../troubleshooting.md).
- `gh auth login` can't open a browser → use the one-time device code it offers.

## ➡️ Next

[**Lab 01 — Open the Issue**](lab-01-open-the-issue.md)
